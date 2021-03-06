BOOTSEG equ 0x07C0 ;宏定义，用于初始化ES

mov bp, HelloMsg ;将HelloMsg的地址赋值给bp
mov ax, BOOTSEG
mov es, ax      ;es:bp = 字符串地址
                ;HelloMsg只是段内的偏移地址
                ;而代码被加载到0x7C00，故设置段地址
                ;即es * 16 + bp为实际内存地址
mov cx, 13 ;串的长度
mov ax, 0x1301 ;AH = 0x13，表示串打印
               ;AL = 0x01，表示打印后光标移动
mov bx, 0x000C ;BH = 0x00，表示页码
               ;BL = 0x0C，表示红色
mov dx, 0x0000 ;第0行0列开始
int 0x10

loop1:
    jmp loop1 ;jmp段内跳转，是相对当前地址
              ;翻译成机器指令后，是0xeb 0xfe
              ;0xeb表示jmp段内跳转的指令号
              ;0xfe即-2，表示往前跳2个字节
              ;这是因为执行本指令时，IP已经移到下条
              ;指令开头了。
              ;所以不会是jmp 0x00这样的写法。

HelloMsg:
    db "Hello, world!" ;共13个字符

times 510 - ($ - $$) db 0 ;填充一堆的0
                        ;$表示当前位置，$$表示文件头部
db 0x55
db 0xAA ;上面两行用于设置引导扇区的标识
