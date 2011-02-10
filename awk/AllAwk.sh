The printf conversion %f is used to print a floating-point number; "6.2" specifies a
minimum field width of six and a precision of two.

match函数返回在字符串中正则表达式位置的索引，如果找不到指定的正则表达式则返回0。
match函数会设置内建变量RSTART为字符串中子字符串的开始位置，RLENGTH为到子字符串末尾的字符个数。
substr可利于这些变量来截取字符串。函数格式如下：
            match( string, regular expression )
实例：
            $ awk '{start=match("this is a test",/[a-z]+$/); print start}'
            $ awk '{start=match("this is a test",/[a-z]+$/); print start, RSTART, RLENGTH }'
第一个实例打印以连续小写字符结尾的开始位置，这里是11。
第二个实例还打印RSTART和RLENGTH变量，这里是11(start)，11(RSTART)，4(RLENGTH)。 

	for ( x=1; x<=NF; ++x ) {
			if (x==3)
						continue
			print x, $x
	}
	
The next statement causes the next line of input to be read and then resumes execution at the top of the script. This 
allows you to avoid applying other procedures on the current input line. A typical use of the next statement is to
continue reading input from a file, ignoring the other actions in the script until that file is exhausted. The system
variable FILENAME provides the name of the current input file. Thus, a pattern can be written:
	FILENAME=="acronyms" {
		action
		next
	}
	{print}
This causes the action to be performed for each line in the file acronyms. After the action is performed, the next line 
of input is read. Control does not pass to the print statement until the input is taken from a different source.

awk '{
      while( getline vc_mobileno < "bb1" )
      {  
        if( substr($1,5,11)==vc_mobileno )
         { print $0 >> "file.txt1"}
      }
      close("bb1");
    }' cccc > haha.txt
    
awk格式：
awk -F\| ' BEGIN{printf("dbaccess gzboss@gzboss<<EOF\n")};
    {printf("unload to %s select vc_wayacctname from gl_pw_way where c_wayid=\"%s\";\n",$1,$1)};
    END {printf("EOF\n")}' 1.sort>tt.sh
    
awk -F\| '{if ($0~! /END/) print $0}' result2 > result3(不匹配表达符,字段分割符可以用[]表示其中之一）
awk -F\| '{if (NR % 2==1) print $0}' result_ > result2 （输出单数行）
awk -F\& '{gsub(/DG01226440/,"DG0126440",$17);gsub(/527920170/,"DG0126440",$1);print $0}'  1.txt >2.txt //替换
awk '{$7 %= 3; print $7}'  file 将第7域被3除，并将余数赋给第7域再打印。
awk '{a[$7]+=$10} END {for (i in a) print i,a}' 整个语句的作用相当于 sum($10) group by $7,最后按照 $7 分类输出sum结果, i指的是数组下标

awk 处理HAN开头下一个HAN的上一行数字为结尾的文件 ... 或者中提取任一文件段 以HAN开头,下一个HAN的上一行数字段为结尾的一段  
生成HAN1等这样的文件 
[root@TestAs4 cwm]# more file1.txt 
HAN  1
12 23 34 45
23 45 56
HAN  2
12 23 34 45
23 45 56
12 23 34 45
HAN  3
12 23 34 45
23 45 56 44
12 23 34 45
23 45 56
HAN  4
12 23 34 45
23 45 56
HAN  n
awk '{  if ($1=="HAN" && NF==2) fn=$2;   print $0>>"HAN" fn;}' file1.txt 
--------------------------------------------------------------------------------------

1300018   广东
1300019   广东
1300100   北京
1300101   北京
1300126   北京
1300127   北京
1300128   北京
1300129   北京
1300130   天津
1300131   天津
1300132   天津
1300133   天津

想得到三个文件：
广东2.txt
1300018 
1300019

北京6.txt
1300100
1300101
1300126
1300127
1300128
1300129
   
天津4.txt
1300130
1300131
1300132
1300133

awk '{a[$2]++;print $1 > $2} END {for (i in a) {print "mv " i " " i""a[i]".txt" }}' ufile|sh
----------------------------------------------------------------------------------------------

如何找出文件中上行以a结束,下一行以b开头,并在b所在行的末尾添加a
***a
b***
改成
***a
b***a
[root@test ~]# more 1
d2222a
k1111
1111a
b1111
22222
b3333
4444a
b8888
[root@test ~]#  awk 'BEGIN{FS="\n";RS="";OFS="\n"} {for(i=1;i<=NF;i++) if($i~/a$/ && $(i+1)~/^b/)print $i,$(i+1)"a"}' 1
1111a
b1111a
4444a
b8888a
----------------------------------------------------------------------------------------------

[root@gfs1 ~]# more 2.txt 
8/10
4/8
1/3
2/5
3/7
6/9
3/6
2/4
10/11
1/2
[root@gfs1 ~]# awk -F/ 'NR==FNR{a[$2]=$0}NR>FNR{while ($1 in a) sub("^"$1,a[$1]);print}' 2.txt 2.txt 
--结果一样: awk -F/ 'NR==FNR{a[$2]=$0}NR>FNR{while ($1 in a) sub($1,a[$1]);print}' 2.txt 2.txt 
1/2/4/8/10
1/2/4/8
1/3
1/2/5
1/3/7
1/3/6/9
1/3/6
1/2/4
1/2/4/8/10/11
1/2