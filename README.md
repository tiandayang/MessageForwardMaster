# MessageForwardMaster
## 内容
 * NSArray + runtime    这个类目里主要提到了动态方法解析 和 方法重定向，以及消息转发
 * DYModel 、DYSubModel 提到了 给父类添加一个新实现 做方法替换等
## 知识点
*+ (BOOL)resolveInstanceMethod:(SEL)sel  方法解析返回值为Bool 如果返回是yes则直接进入消息处理 如果是no的话就进入下一项- (id)forwardingTargetForSelector:(SEL)aSelector
* - (id)forwardingTargetForSelector:(SEL)aSelector  方法的重定向  在消息转发机制执行前，Runtime 系统会再给我们一次偷梁换柱的机会，即通过重载- (id)forwardingTargetForSelector:(SEL)aSelector方法替换消息的接受者为其他对象
* - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector  方法签名 在forwardInvocation:消息发送前，Runtime系统会向对象发送methodSignatureForSelector:消息，并取到返回的方法签名用于生成NSInvocation对象
* - (void)forwardInvocation:(NSInvocation *)anInvocation 当动态方法解析不作处理返回NO时，且重定向也为处理时消息转发机制会被触发。在这时forwardInvocation:方法会被执行
* class_addMethod(self, @selector(work), [self instanceMethodForSelector:@selector(newWork)],type)  给当前类指定方法添加一个实现 具体参数描述可看官方文档
* class_replaceMethod(self, @selector(work), [self instanceMethodForSelector:@selector(newWork)], type); 这个是做方法替换 看官网介绍的时候发现有两个注意的地方 一是 如果要替换的方法没有实现的话 那么该方法的功能就有点类似class_addMethod的功能一样 动态添加一个方法的实现 二是如果要被替换的方法已经实现 那么功能就类似method_setImplementation给制定方法重新设置一下实现 也差不多相当于替换的意思

## 发现
* class_addMethod 当要添加的方法 在当前类已经实现的话方法是添加不成功的，文档中有这么一句话( class_addMethod will add an override of a superclass's implementation, but will not replace an existing implementation in this class,To change an existing implementation, use method_setImplementation)

## 应用场景
常见的应用场景有
* 避免常见崩溃
* hook也可以帮你找到一些不容易发现的崩溃
* hook也能在使用一些第三方工具的时候 改变第三方的交互行为
* hook系统方法 来实现自己的功能 比如 FDFullscreenPopGesture 里的应用

