NR == FNR { if (NF==2) a[$1]; else a[$1$2$3]
	}
NR > FNR {
		for (i in a) {
			if (split(i, b, "/") > 1)
				{if (($NF==b[1])||($NF==b[2])) print b[1]" / "b[2]"\t"$NF}
			else {if(($NF==i)) print i"\t"$NF}
		}
}

如果文件a中包含文件b，则将文件b的记录打印出来输出到c文件里

文件a: 
10/05766798607,11/20050325191329,29/0.1,14/05766798607 
10/05767158557,11/20050325191329,29/0.08,14/05767158557 

文件b: 
05766798607 
05766798608 
05766798609 
通过文件a和文件b对比,导出这样的文件出来. 
10/05766798607,11/20050325191329,29/0.1,14/05766798607
 
方法一：  awk -F'[/,]' 'ARGIND==1{a[$0]}ARGIND>1{if ($2 in a)print $0}' b a >c
 
方法二：  awk -F'[/,]' 'NR==FNR{a[$0]}NR>FNR{if ($2 in a) print $0}' b a >c
 
这两种方法是用数组处理的，速度比较快，处理9万行只需4秒。
-------------------------------------------------------------------------------------

例二　awk数组处理两个文件索引的问题（替代法）
 [root@TestAs4 zlwt]# more a
deptA
deptB
deptC
deptD
[root@TestAs4 zlwt]# more b
aaa 0
bbb 1
ccc 2
ddd 0
eee 2
fff 2
[root@TestAs4 zlwt]# awk 'NR==FNR {k[i++]=$1} NR>FNR { print $1,k[$2]}' a b
aaa deptA
bbb deptB
ccc deptC
ddd deptA
eee deptC
fff deptC
 
NR==FNR {k[i++]=$1}　#先把a文件的值赋给数组k，下标从0自动增长
NR>FNR { print $1,k[$2] #其中　$1,$2是b中的第一,二个域，k[$2]为a的值
--------------------------------------------------------------------------------
	
另外一个例子
 awk ' BEGIN{FS="[|]";OFS="|"}
FNR==NR{a[$1]=$2}
FNR<NR{if(!a[$1]) {$1="13";print}
else {$1=a[$1];print}}
' wj wj1>wj2


文件1 
1|name1
2|name2
3|name3
5|name5
6|name6

文件2
1|name11
2|name22
3|name33
4|name44
5|name55
6|name66
7|name77
8|name88

输出结果
name1|name11
name2|name22
name3|name33
13|name44
name5|name55
name6|name66
13|name77
13|name88
 
 
它在处理2个以|分割的文件
例如
文件1 wj 格式
id1|desc1
文件2 wj1格式
id2|desc2

FNR==NR{a[$1]=$2} 意思是处理第一个文件时 把 desc1 赋值给 数组 a 的 a[id1] 单元。
FNR<NR 条件是在处理第2文件成立。这样在处理第2 文件时
{if(!a[$1]) {$1="13";print}
else {$1=a[$1];print
如果a[$1] 是空，就把第2文件那行的第1列替换为 13 输出 如： 13|desc2
如果a[$1]非空，就是这个数组值已经在处理第1文件赋过值。就把$1替换为 a[$1] 即 文件1对应的$2。输出的就是 desc1|desc2
-----------------------------------------------------------------------------------------------------------------

[root@TestAs4 mdn]# more  test1
1300019                 510             020     广州
1300101                 110             010     北京
1300103                 110             010     北京
1300104                 110             010     北京
1300106                 110             010     北京

[root@TestAs4 mdn]# more temp 
1300970 13009700055
1300970 13009700495
1300970 13009701075
1300970 13009701282

[root@TestAs4 mdn]# more awk_script
BEGIN { while ((getline < "test1") > 0){ lines[$1]=$4 };OFS=" " } 
{ 
   if($1 in lines){ 
       $1=lines[$1]    #把test1文件的$4替换到temp文件的$1上
        print $0
   }
}  
#要求把test1文件的第四个字段插入到temp文件的相应条目的第一个子段中
#利用getline获取test1文件的第四个字段，并且放到一个数组中
[root@TestAs4 mdn]# awk -f awk_script  temp