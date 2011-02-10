The printf conversion %f is used to print a floating-point number; "6.2" specifies a
minimum field width of six and a precision of two.

match�����������ַ�����������ʽλ�õ�����������Ҳ���ָ����������ʽ�򷵻�0��
match�����������ڽ�����RSTARTΪ�ַ��������ַ����Ŀ�ʼλ�ã�RLENGTHΪ�����ַ���ĩβ���ַ�������
substr��������Щ��������ȡ�ַ�����������ʽ���£�
            match( string, regular expression )
ʵ����
            $ awk '{start=match("this is a test",/[a-z]+$/); print start}'
            $ awk '{start=match("this is a test",/[a-z]+$/); print start, RSTART, RLENGTH }'
��һ��ʵ����ӡ������Сд�ַ���β�Ŀ�ʼλ�ã�������11��
�ڶ���ʵ������ӡRSTART��RLENGTH������������11(start)��11(RSTART)��4(RLENGTH)�� 

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
    
awk��ʽ��
awk -F\| ' BEGIN{printf("dbaccess gzboss@gzboss<<EOF\n")};
    {printf("unload to %s select vc_wayacctname from gl_pw_way where c_wayid=\"%s\";\n",$1,$1)};
    END {printf("EOF\n")}' 1.sort>tt.sh
    
awk -F\| '{if ($0~! /END/) print $0}' result2 > result3(��ƥ�����,�ֶηָ��������[]��ʾ����֮һ��
awk -F\| '{if (NR % 2==1) print $0}' result_ > result2 ����������У�
awk -F\& '{gsub(/DG01226440/,"DG0126440",$17);gsub(/527920170/,"DG0126440",$1);print $0}'  1.txt >2.txt //�滻
awk '{$7 %= 3; print $7}'  file ����7��3������������������7���ٴ�ӡ��
awk '{a[$7]+=$10} END {for (i in a) print i,a}' �������������൱�� sum($10) group by $7,����� $7 �������sum���, iָ���������±�

awk ����HAN��ͷ��һ��HAN����һ������Ϊ��β���ļ� ... ��������ȡ��һ�ļ��� ��HAN��ͷ,��һ��HAN����һ�����ֶ�Ϊ��β��һ��  
����HAN1���������ļ� 
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

1300018   �㶫
1300019   �㶫
1300100   ����
1300101   ����
1300126   ����
1300127   ����
1300128   ����
1300129   ����
1300130   ���
1300131   ���
1300132   ���
1300133   ���

��õ������ļ���
�㶫2.txt
1300018 
1300019

����6.txt
1300100
1300101
1300126
1300127
1300128
1300129
   
���4.txt
1300130
1300131
1300132
1300133

awk '{a[$2]++;print $1 > $2} END {for (i in a) {print "mv " i " " i""a[i]".txt" }}' ufile|sh
----------------------------------------------------------------------------------------------

����ҳ��ļ���������a����,��һ����b��ͷ,����b�����е�ĩβ���a
***a
b***
�ĳ�
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
--���һ��: awk -F/ 'NR==FNR{a[$2]=$0}NR>FNR{while ($1 in a) sub($1,a[$1]);print}' 2.txt 2.txt 
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