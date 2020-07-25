## 目录结构

### ~/.vim/colors/

  `vim`配色方案

### ~/.vim/plugged/

  每次启动vim都会被运行一次的插件

### ~/.vim/ftplugin/

  `vim`给缓冲区的`filetype`设置一个值时,`vim`会在`~/.vim/ftplugin/`目录下查找和`filetype`同名文件
  例如:你运行`set filetype=c`后,`vim`将查找`~/.vim/ftplugin/c.vim`,若存在就运行它
  不仅如此,它还会运行`ftplugin`下同名子目录中所有文件,如`~/.vim/ftplugin/c/`文件夹下所有文件都会被运行

### ~/.vim/indent/

  就像`~/.vim/ftplugin/`,根据名字来加载,放置相关文件类型的缩进
  例如`python`应该怎么缩进,`C`应该怎么缩进等等
  放在`ftplugin`中效果相同,这里只是为了方便管理和理解

### ~/.vim/compiler/

  就像`~/.vim/indent/`,它放的是相应文件类型应该如何编译的选项

### ~/.vim/after/

  这里的文件同样会在`vim`每次启动的时候加载,但是会在`~/.vim/plugged/`加载之后进行

### ~/.vim/autoload/

  放置当你真正需要的时候才被自动加载运行的文件,而不是在`vim`启动时就加载

### ~/.vim/doc/

  存放文档,例如`:help`的时候可以用到

### ~/.vim/spell/

  拼写检查脚本

### ~/.vim/syntax/

  语法描述脚本
