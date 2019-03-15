# demo 编码规范(请使用MARKDOWN工具打开此文件以显示图片)

### 一、类名 (Class)

设置自动类名前缀 Class Prefix

效果如图：

![](http://tc.kaopuyu.com/1545982356.png?imageMogr2/thumbnail/!70p)

设置方法：

左侧目录导航栏->找到工程配置文件->定位“TARGETS”选项卡->找到Xcode右边侧栏->定位到“Project Document”下的“Class Prefix”输入框->输入前缀。

![](http://tc.kaopuyu.com/1545982442.png?imageMogr2/thumbnail/!70p)

前缀命名风格：

	1.大驼峰命名法
	2.小驼峰命名法
	以上皆可
	
### 二、类别 (Category)

类别名添加 大写前缀 IA ， 方法名添加 小写前缀 ia 。
	
		NSObject+demoNetworkingMethods.h

		@interface NSObject (demoNetworkingMethods)

		- (BOOL)ia_isEmptyObject;

		@end

### 三、委托 (Delegate)

第一个参数是触发委托的对象

第一个关键词是触发对象的类名

除非该方法只有一个参数

	// 第一个关键词为触发委托的类名
	- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;  
	
	// 当只有一个"sender"参数时可以省略类名
	- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender;

根据委托方法触发的时机和目的，使用should,will,did等关键词

	- (void)browserDidScroll:(NSBrowser *)sender;

	- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window;、
	
	- (BOOL)windowShouldClose:(id)sender;

### 四、通知 (Notification)

通知常用于在模块间传递消息，所以通知要尽可能地表示出发生的事件，通知的命名范式是：

	[触发通知的类名] + [Did | Will] + [动作] + Notification

例子：

	NSApplicationDidBecomeActiveNotification
	UIKeyboardWillShowNotification
	NSUserDefaultsDidChangeNotification
	UITextFieldTextDidBeginEditingNotification

### 五、常量或者宏

常量：k为前缀，后续遵循 驼峰命名法， kConstantName

宏：全部使用大写字母加下划线的形式，MACORS_NAME

### 六、方法(Methods)

命名采用 小驼峰命名法 即首个单词全部用小写字母，后续的单词首字母大写。

方法名中不应该有标点符号(包括下划线)，除了以下的情况：

可以用带下划线的小写前缀来命名私有方法或者类别中的方法

	- (void)ia_setControls

如果方法表示让对象执行一个动作，使用动词打头来命名，注意不要使用do，does这种多余的关键字，动词本身的暗示就足够了：

	//正确，使用属性名来命名方法
	- (NSSize)cellSize;
	
	//错误，添加了多余的动词前缀
	- (NSSize)calcCellSize;
	- (NSSize)getCellSize;

对于有多个参数的方法，务必在每一个参数前都添加关键词，关键词应当清晰说明参数的作用：

	//正确，保证每个参数都有关键词修饰
	- (void)sendAction:(SEL)aSelector toObject:(id)anObject forAllCells:(BOOL)flag;
	
	//错误，遗漏关键词
	- (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag;
	
	//正确
	- (id)viewWithTag:(NSInteger)aTag;
	
	//错误，关键词的作用不清晰
	- (id)taggedView:(int)aTag;

不要用and来连接两个参数，通常and用来表示方法执行了两个相对独立的操作（从设计上来说，这时候应该拆分成两个独立的方法）：

	//错误，不要使用"and"来连接参数
	- (int)runModalForDirectory:(NSString *)path andFile:(NSString *)name andTypes:(NSArray *)fileTypes;
	
	//正确，使用"and"来表示两个相对独立的操作
	- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName andDeactivate:(BOOL)flag;
	
方法的参数命名也有一些需要注意的地方:

* 和方法名类似，参数的第一个字母小写，后面的每一个单词首字母大写
* 不要再方法名中使用类似pointer,ptr这样的字眼去表示指针，参数本身的类型足以说明
* 不要使用只有一两个字母的参数名
* 不要使用简写，拼出完整的单词

### 七、命名属性和实例变量（Properties&Instance Variables）

属性和对象的存取方法相关联，属性的第一个字母小写，后续单词首字母大写，不必添加前缀。属性按功能命名成名词或者动词：

	//名词属性
	@property (strong) NSString *title;
	
	//动词属性
	@property (assign) BOOL showsAlpha;

### 八、命名常量（Constants）

	//定义一个枚举
	typedef NS_ENUM(NSInteger, NSMatrixMode) {
	    NSRadioModeMatrix,
	    NSHighlightModeMatrix,
	    NSListModeMatrix,
	    NSTrackModeMatrix
	};

### 八、注释

#### 文件注释

复制一份项目中的：IDETemplateMacros.plist 文件到以下目录：

	<ProjectName>.xcodeproj/xcuserdata/[username].xcuserdatad/
	
然后新建一个测试文件即可知道有无成功生成文件注释。

![](http://tc.kaopuyu.com/1545984730.png?imageMogr2/thumbnail/!70p)

#### 请勿修改文件注释配置文件：IDETemplateMacros.plist

注释内容根据主机电脑自动带上你自己名字。请勿修改文件以及文件名！

如要修改请参考如下系统宏参数解释：

* ___DATE___ 				：当前系统日期
* ___FILENAME___ 		：当前文件名
* ___COPYRIGHT___ 		: 版权
* ___PACKAGENAME___ 		：当前项目工程名
* ___FULLUSERNAME___ 	：当前电脑的管理员名称
