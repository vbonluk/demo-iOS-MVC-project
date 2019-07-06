# demo 基础架构

本项目基于：[https://github.com/vbonluk/demo-iOS-MVC-project](https://github.com/vbonluk/demo-iOS-MVC-project)
欢迎star我的GitHub项目
如需迁移，您可以使用：[https://github.com/vbonluk/demo-iOS-MVC-project](https://github.com/vbonluk/Project-Rebuilder)

	1.主目录结构
	-demoProject
	    --AppDelegate         // 程序入口
	    --Class               // 业务模块。
	    --FunctionModule      // 功能模块  
	      ---Manager          // 管理类。账号管理等
	      ---Utility          // 工具类。HUD,AlertView等
	    --BasicModule         // 基础模块
	      ---Config           // 初始化配置。包含宏定义文件，全局配置文件，全局常量文件  
	      ---Category         // 类目。包含各种类的分类
	      ---Vendors          // 第三方库。部分需要修改或者不支持cocoapod的第三方的框架引入
	    --Resource            // 资源。包含plist,image,html,bundle，Localizable.strings等
          --Supporting Files    // 项目配置文件
	-demoProject Tests
	-demoProject UITests
	-Products                 // 系统自动生成的.app所在文件夹
	-Pods                     // 采用 CocoaPods 管理的第三方库
	
	2.模块目录结构
	-- Class         
	    ---Base               // MVC、MVVM的基类或者通用类
	        ----Controller     
	        ----Model       
	        ----View 
	        ----ViewModel    	 //MVVM架构才存在,本项目暂不采用MVVM
              ----Service       //网络封装层,基于AFNetworking封装的YTKNetworking采用的Command设计模式,离散型API封装。
	    ---Home
	        ----Controller     
	        ----Model       
	        ----View 
	        ----ViewModel      //MVVM架构才存在,本项目暂不采用MVVM
              ----Service        //网络封装层
              ----SubControllers //子结构
		类推...
# demo Class文件结构(顺序)
	
	-.h
            -- 文件注释
            -- #import			// 导入类
            -- NS_ENUM			// 枚举类
            -- @protocol			// 代理
            -- @interface		// 文件入口
            -- @property			// 属性
            -- methods		    // 方法
	
	-.m
            -- 文件注释
            -- #import			// 导入类
            -- #define			// 宏定义
            -- static 			// 静态变量
            -- @interface		// 文件入口
            -- @property			// 属性
            -- @implementation	// 实现
            -- methods			// 方法	

# demo Class文件规范

	-.m
            --Lifecycle           		// 生命周期
            --Overwrite Super Class		// 重写父类
            --Response Mehtods			// 响应方法(通知,Target等)
            --Delegate        		   	// 代理方法
            --Private Methods        	// 本类文件使用的方法，私有的
            --Public Methods			// 暴露给外界的接口
            --Getters and Setters		// 属性的get、set方法，所有的属性都通过 懒加载的形式来初始化
    
    example:
        
            #pragma mark - Lifecycle
            
            
            
            #pragma mark - Overwrite Super Class
            
            
            
            #pragma mark - Response Mehtods
            
            
            
            #pragma mark - Delegate
            
            
            
            #pragma mark - Private Methods
            
            
            
            #pragma mark - Public Methods
            
            
            
            #pragma mark - Getters and Setters
            
            
            
