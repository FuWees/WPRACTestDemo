//
//  ViewController.m
//  WPRACTestDemo
//
//  Created by wupeng on 2017/5/23.
//  Copyright © 2017年 wupeng. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width

#define kScreenH [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) RACDisposable *textDisposable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *btnTitle = @[@"RACSiganl",@"RACSubject",@"RACReplaySubject",@"RACTupleAndRACSequence",@"RACCommand",@"RACMulticastConnection",@"RACScheduler",@"flatternMap",@"concat",@"then",@"zipWith",@"reduce",@"take",@"doNext",@"q_signal",@"q_subject",@"replay_siganl",@"replay_subject",@"replayLast",@"replayLazily",@"retry",@"map",@"filter",@"ignore",@"distinctUntilChanged",@"throttle",@"merge"];
    for (int i = 0; i < btnTitle.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        CGFloat width = 120;
        CGFloat height = 40;
        CGFloat x = 5 + (width + 5) * (i%3);
        CGFloat y = 74 + (height +5) * (i/3);
        btn.frame = CGRectMake(x, y, width, height);
        btn.tag = i;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.borderWidth = 1.0;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, kScreenH - 64 - 40 - 10, kScreenW - 40, 40)];
    textField.placeholder = @"测试rac信号输入...";
    textField.layer.borderColor = [UIColor redColor].CGColor;
    textField.layer.borderWidth = 1.0;
    [self.view addSubview:textField];
    self.textField = textField;
    
    
    
}

- (void)onClickButton:(id)button{
    UIButton *btn = (UIButton *)button;
    switch (btn.tag) {
        case 0:
        {
            [self RACSignal];
        }
            break;
        case 1:
        {
            [self RACSubject];
        }
            break;
        case 2:
        {
            [self RACReplaySubject];
        }
            break;
            
        case 3:
        {
            [self RACTupleAndRACSequence];
        }
            break;
        case 4:
        {
            [self RACCommand];
        }
            break;
        case 5:
        {
            [self RACMulticastConnection];
        }
            break;
        case 6:
        {
            [self RACScheduler];
        }
            break;
        case 7:
        {
            [self flatternMap];
        }
            break;
        case 8:
        {
            [self concat];
        }
            break;
        case 9:
        {
            [self then];
        }
            break;
        case 10:
        {
            [self zipWith];
        }
            break;
        case 11:
        {
            [self reduce];
        }
            break;
        case 12:
        {
            [self take];
        }
            break;
        case 13:
        {
            [self doNext];
        }
            break;
        case 14:
        {
            [self q_signal];
        }
            break;
        case 15:
        {
            [self q_subject];
        }
            break;
        case 16:
        {
            [self replay_siganl];
        }
            break;
        case 17:
        {
            [self replay_subject];
        }
            break;
        case 18:
        {
            [self replayLast];
        }
            break;
        case 19:
        {
            [self replayLazily];
        }
            break;
        case 20:
        {
            [self retry];
        }
            break;
        case 21:
        {
            [self map];
        }
            break;
        case 22:
        {
            [self filter];
        }
            break;
        case 23:
        {
            [self ignore];
        }
            break;
        case 24:
        {
            [self distinctUntilChanged];
        }
            break;
        case 25:
        {
            [self throttle];
        }
            break;
        case 26:
        {
            [self merge];
        }
            break;
        default:
            break;
    }
    
}


- (void)RACSignal{
    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
//        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
    
}

- (void)RACSubject{
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@"1"];
    
}

- (void)RACReplaySubject
{
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
    
}

- (void)RACTupleAndRACSequence{
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        NSLog(@"%@ %@",key,value);
    }];
    
}

- (void)RACCommand{
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        
        // 创建空信号,必须返回信号
        //        return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    // 强引用命令，不要被销毁，否则接收不到数据
    //_command = command;
    
    // 3.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
        
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    //    [command.executing subscribeNext:^(id x) {
    [[command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
    // 5.执行命令
    [command execute:@1];
    
}

- (void)RACMulticastConnection{
    NSLog(@"======问题：订阅两次，发送两次请求数据====");
    // 1.创建请求信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSLog(@"发送请求");
        
        return nil;
    }];
    // 2.订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"接收数据");
        
    }];
    // 2.订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"接收数据");
        
    }];
    
    // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
    NSLog(@"=====解决：订阅了2次，但仅仅发了一次请求，且两个订阅者都会收到信号====");
    // RACMulticastConnection:解决重复请求问题
    // 1.创建信号
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    // 2.创建连接
    RACMulticastConnection *connect = [newSignal publish];
    
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者一信号");
        
    }];
    
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者二信号");
        
    }];
    
    // 4.连接,激活信号
    [connect connect];
    
}

- (void)RACScheduler{
    //deliverOn
    NSLog(@"====deliverOn====");
    //创建信号
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"sendTestSignal%@",[NSThread currentThread]);
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    //订阅信号
    //要想放在主线程执行只要将[RACScheduler scheduler]更换为[RACScheduler mainThreadScheduler]
    [[signal deliverOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
        NSLog(@"receiveSignal%@",[NSThread currentThread]);
    }];
    
    //subscribeOn
    //    NSLog(@"=====subscribeOn=======")
    //    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //
    //        NSLog(@"sendSignal%@",[NSThread currentThread]);
    //        [subscriber sendNext:@1];
    //        return [RACDisposable disposableWithBlock:^{
    //        }];
    //    }] subscribeOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
    //
    //        NSLog(@"receiveSignal%@",[NSThread currentThread]);
    //    }];
    //
    //    //timeout
    //    NSLog(@"======timeout=======")
    //    RACSignal *timeoutSignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //        return nil;
    //    }] timeout:3 onScheduler:[RACScheduler currentScheduler]];
    //
    //    [timeoutSignal subscribeNext:^(id x) {
    //
    //        NSLog(@"%@",x);
    //    } error:^(NSError *error) {
    //        // 3秒后会自动调用
    //        NSLog(@"%@",error);
    //    }];
    
    //interval
    //    NSLog(@"=======interval=======")
    //    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
    //
    //        NSLog(@"%@",x);
    //    }];
    
}

- (void)flatternMap{
    // 创建信号中的信号
        RACSubject *signalOfsignals = [RACSubject subject];
        RACSubject *signal = [RACSubject subject];
    
        [[signalOfsignals flattenMap:^RACStream *(id value) {
    
            // 当signalOfsignals的signals发出信号才会调用
    
            return value;
    
        }] subscribeNext:^(id x) {
    
            // 只有signalOfsignals的signal发出信号才会调用，因为内部订阅了bindBlock中返回的信号，也就是flattenMap返回的信号。
            // 也就是flattenMap返回的信号发出内容([signal sendNext:@1])，才会调用。
    
            NSLog(@"%@aaa",x);
        }];
    
        // 信号的信号发送信号
        [signalOfsignals sendNext:signal];
    
        // 信号发送内容
        [signal sendNext:@1];
}

- (void)concat{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 以后只需要面对拼接信号开发。
    // 订阅拼接的信号，不需要单独订阅signalA，signalB
    // 内部会自动订阅。
    // 注意：第一个信号必须发送完成，第二个信号才会被激活
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)then{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        
        // 只能接收到第二个信号的值，也就是then返回信号的值
        NSLog(@"%@",x);
    }];
}

- (void)zipWith{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    // 压缩信号A，信号B
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)reduce{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
//        [subscriber sendError:[NSError new]];
        return nil;
    }];
    
    // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
    // reduce中的block简介:
    // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
    // reduceblcok的返回值：聚合信号之后的内容。
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
        return [NSString stringWithFormat:@"%@ %@",num1,num2];
    }];
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)take{
    NSLog(@"======take======");
    // 1、创建信号
    RACSubject *signal = [RACSubject subject];
    // 2、处理信号，订阅信号
    [[signal take:3] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 3.发送信号
    [signal sendNext:@1];
    [signal sendNext:@2];
    [signal sendNext:@3];
    
    NSLog(@"=======takeLast======");
    // 1、创建信号
    RACSubject *signal1 = [RACSubject subject];
    // 2、处理信号，订阅信号
    [[signal1 takeLast:20] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 3.发送信号
    [signal1 sendNext:@1];
    [signal1 sendNext:@2];
    [signal1 sendCompleted];//必须调完成
}

- (void)doNext{
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id x) {
        // 执行[subscriber sendNext:@1];之前会调用这个Block
        NSLog(@"doNext");;
    }] doCompleted:^{
        // 执行[subscriber sendCompleted];之前会调用这个Block
        NSLog(@"doCompleted");;
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)q_signal{
    __block int num = 0;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id  subscriber) {
        num++;
        NSLog(@"Increment num to: %i", num);
        [subscriber sendNext:@(num)];
        return nil;
    }];
    NSLog(@"Start subscriptions");
    // Subscriber 1 (S1)
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    // Subscriber 2 (S2)
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    // Subscriber 3 (S3)
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
}

- (void)q_subject{
    RACSubject *letters = [RACSubject subject];
    RACSignal *signal = letters;
    
    // Subscriber 1 (S1)
    NSLog(@"Subscribe S1");
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    NSLog(@"Send A");
    [letters sendNext:@"A"];
    NSLog(@"Send B");
    [letters sendNext:@"B"];
    
    // Subscriber 2 (S2)
    NSLog(@"Subscribe S2");
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    NSLog(@"Send C");
    [letters sendNext:@"C"];
    NSLog(@"Send D");
    [letters sendNext:@"D"];
    
    // Subscriber 3 (S3)
    NSLog(@"Subscribe S3");
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
    
}

- (void)replay_siganl{
    __block int num = 0;
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id  subscriber) {
        num++;
        NSLog(@"Increment num to: %i", num);
        [subscriber sendNext:@(num)];
        return nil;
    }] replay];//调用replay
    
    NSLog(@"Start subscriptions");
    
    // Subscriber 1 (S1)
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    
    // Subscriber 2 (S2)
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    
    // Subscriber 3 (S3)
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
}

- (void)replay_subject{
    RACSubject *letters = [RACSubject subject];
    RACSignal *signal = [letters replay];
    
    NSLog(@"Subscribe S1");
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    
    NSLog(@"Send A");
    [letters sendNext:@"A"];
    NSLog(@"Send B");
    [letters sendNext:@"B"];
    
    NSLog(@"Subscribe S2");
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    
    NSLog(@"Send C");
    [letters sendNext:@"C"];
    NSLog(@"Send D");
    [letters sendNext:@"D"];
    
    NSLog(@"Subscribe S3");
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
}

- (void)replayLast{
    RACSubject *letters = [RACSubject subject];
    RACSignal *signal = [letters replayLast];
    
    NSLog(@"Subscribe S1");
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    
    NSLog(@"Send A");
    [letters sendNext:@"A"];
    NSLog(@"Send B");
    [letters sendNext:@"B"];
    
    NSLog(@"Subscribe S2");
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    
    NSLog(@"Send C");
    [letters sendNext:@"C"];
    NSLog(@"Send D");
    [letters sendNext:@"D"];
    
    NSLog(@"Subscribe S3");
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
}

- (void)replayLazily{
    __block int num = 0;
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id  subscriber) {
        num++;
        NSLog(@"Increment num to: %i", num);
        [subscriber sendNext:@(num)];
        return nil;
    }] replayLazily];  //跟replay不同的就这么一个地方
    
    NSLog(@"Start subscriptions");
    
    // Subscriber 1 (S1)
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    
    // Subscriber 2 (S2)
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    
    // Subscriber 3 (S3)
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
    
}

- (void)retry{
    __block int i = 0;
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (i == 10) {
            [subscriber sendNext:@1];
        }else{
            NSLog(@"接收到错误");
            [subscriber sendError:nil];
        }
        i++;
        return nil;
    }] retry] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
    }];
    
}

- (void)merge{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@2];
        return nil;
    }];
    // 合并信号,任何一个信号发送数据，都能监听到.
    RACSignal *mergeSignal = [signalA merge:signalB];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

#pragma mark - textFieldSignal
- (void)map{
    [self.textDisposable dispose];
    
    self.textDisposable = [[_textField.rac_textSignal map:^id(id value) {
        // 当源信号发出，就会调用这个block，修改源信号的内容
        // 返回值：就是处理完源信号的内容。
        return [NSString stringWithFormat:@"输出:%@",value];
    }] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
}

- (void)filter{
    
    [self.textDisposable dispose];
    // 过滤:
    // 每次信号发出，会先执行过滤条件判断.
    self.textDisposable = [[_textField.rac_textSignal filter:^BOOL(NSString *value) {
        //此处做筛选的条件操作
        return [value length] > 3;
    }] subscribeNext:^(id x) {
        NSLog(@"x = %@", x);
    }];
    
}

- (void)ignore{
    [self.textDisposable dispose];
    
    // 内部调用filter过滤，忽略掉ignore的值
    [[_textField.rac_textSignal ignore:@"1"] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)distinctUntilChanged{
    [self.textDisposable dispose];
    // 过滤，当上一次和当前的值不一样，就会发出内容。
    // 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
    self.textDisposable = [[_textField.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)throttle{
    [self.textDisposable dispose];
    
    self.textDisposable = [[[_textField rac_textSignal] throttle:1] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

