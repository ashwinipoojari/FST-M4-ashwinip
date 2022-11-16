--loading into HDFS
dialogues = LOAD 'hdfs:///user/root/project' USING PigStorage('\t') AS (name: chararray,line: chararray);
--group
eachUser = GROUP dialogues BY name;
--filter
user = FOREACH eachUser GENERATE $0 AS name, COUNT($1) AS lines;
--sort
sort = ORDER user BY lines DESC;
-- Store the result in HDFS
STORE sort INTO 'hdfs:///user/root/final';
STORE sort INTO '/user/project';
