OEM_app
=======
目前实现了,创建相册， 对相册的增删改， 图片的滤镜处理。

view controllers group

    MainViewController 主要显示所有相册目录,滑动删除等。 
    EditPhotosViewController 主要是编辑相册，longpress item 可进行删除操作  点击进入 预览和 修改界面。
    ChoosePhotoViewController 主要是读取用户手机，让用户选择相片制作相册。

    EditImageView  相片预览， 左右滑动可查看改相册其它图片，点击进行 滤镜选择。
    FiterView 滤镜的选择


views group 

     与上面viewcontroller 对应的自定义cell


model group 
        user，section，item ，等主要是对数据模式的处理

        Photos 主要实现，从本地相册读取照片数据，保存照片到本地document 下
         
        ManagerCoreDataObject 管理coredata

        CHTCollectionViewDelegateWaterfallLayout  主要实现 collectionviewlayout  

        FiterView 滤镜的实现