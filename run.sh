#!/bin/bash

# test Doxia 1.12.0
doxiaVersion=1.12.0
[ -d output/doxia-${doxiaVersion} ] || mkdir output/doxia-${doxiaVersion}
[ -d output/doxia-${doxiaVersion}/xdoc ] || mkdir output/doxia-${doxiaVersion}/xdoc
[ -d output/doxia-${doxiaVersion}/xhtml5 ] || mkdir output/doxia-${doxiaVersion}/xhtml5

# doxia converter 1.3, uses Doxia 1.12.0
[ -f doxia-converter-1.3-jar-with-dependencies.jar ] || wget https://repo.maven.apache.org/maven2/org/apache/maven/doxia/doxia-converter/1.3/doxia-converter-1.3-jar-with-dependencies.jar

for f in src/site/*/*
do
  from=$(basename $(dirname $f))
  echo "convert $(basename $f) to Doxia xdoc"
  java -jar doxia-converter-1.3-jar-with-dependencies.jar -in $f -from $from -out output/doxia-${doxiaVersion}/xdoc -to xdoc
  echo "convert $(basename $f) to Doxia xhtml5"
  java -jar doxia-converter-1.3-jar-with-dependencies.jar -in $f -from $from -out output/doxia-${doxiaVersion}/xhtml5 -to xhtml5
done

# TODO test Doxia 2.0.0-M5 on same content
# TODO also test every Doxia 1.x release, to detect when something has changed
# TODO test sitetool impact, with a skin: via maven-site-plugin?
