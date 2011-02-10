SCRIPT=`readlink -f $0`  #To get physical path of this file, /home/rice/Slink.sh
PA=`dirname $SCRIPT`     #Trim the file's name, /home/rice/
file="$PA/var"

if [ -h ~/var ] ; then(
 rm ~/var
 ln -s $file ~/var)
elif [ -w ~/var ] ; then
 echo 'Please rename you "var" folder or file!'
else
ln -s $file ~/var
fi