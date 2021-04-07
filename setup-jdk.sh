
ITEMS="appletviewer  extcheck  idlj  jar  jarsigner  java  javac  javadoc  javah  javap  javaws  jconsole  jdb  jexec  jhat  jinfo  jmap  jps  jrunscript  jsadebugd  jstack  jstat  jstatd  keytool  mozilla-javaplugin.so  native2ascii  orbd  pack200  policytool  rmic  rmid  rmiregistry  schemagen  serialver  servertool  tnameserv  unpack200  wsgen  wsimport  xjc"

for I in $ITEMS 
do
    sudo update-alternatives --install /usr/bin/$I $I /opt/jdk1.8.0_281/bin/$I 1
done

