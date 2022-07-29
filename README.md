# MSK Comands For Creating a Cluster and Streaming Data

Install Java:
sudo yum install java-1.8.0

Get Kafka:wget https://archive.apache.org/dist/kafka/2.2.1/kafka_2.12-2.2.1.tgz

Extract Kafka:
tar -xzf kafka_2.12-2.2.1.tgz

Get Cluster ARN:
aws kafka describe-cluster --cluster-arn "ClusterArn" --region 

List Topics:

./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --list


Create Topic:
./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --create --replication-factor 1 --partitions 1 --topic dev.mytest.topic

bin/kafka-topics.sh --create --zookeeper "ZookeeperConnectString" --replication-factor 2 --partitions 1 --topic AWSKafkaTutorialTopic

Delete Topic:

./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --delete --topic i.really.know.that.i.need.to.delete.this.topic


Consume/View Message
The console consumer consumes and displays messages. 

For checking all messages use the from-beginning (Note, messages in Kafka have a retention, so if this is beyond retention period the message will not be available.)

./kafka-console-consumer.bat --topic dev.mytest.topic --bootstrap-server b-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094,b-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094 --consumer-property security.protocol=SSL --from-beginning
For checking from a specific offset use the offset flag.  (Note offset requires a partition, using 0 as the partition.

$ ./kafka-console-consumer.bat --topic dev.mytest.topic --bootstrap-server b-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094,b-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094 --consumer-property security.protocol=SSL --offset 2 --partition 0
Close console with Ctrl+C after you are done.


User the Trust store:
cp /usr/lib/jvm/JDKFolder/jre/lib/security/cacerts /tmp/kafka.client.truststore.jks

client.properties:
security.protocol=SSL
ssl.truststore.location=/tmp/kafka.client.truststore.jks

Get Brokers:
aws kafka get-bootstrap-brokers --cluster-arn ClusterArn --region

Producer:
./kafka-console-producer.sh --broker-list BootstrapBrokerStringTls --producer.config client.properties --topic AWSKafkaTutorialTopic

Consumer:
./kafka-console-consumer.sh --bootstrap-server BootstrapBrokerStringTls --consumer.config client.properties --topic AWSKafkaTutorialTopic --from-beginning


EC2 linux Kafka Full Video Link= https://www.youtube.com/watch?v=WZIGJrjBpCI&t=2744s

MSK Kafka Video= https://www.youtube.com/watch?v=y4wowEQd4Os&t=1023s




AWS MSK with AWS ClI Commands


List Topics
This is a non mutating operation, so you can do this to list all the topics.

./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --list
Create Topic
Use with caution as per requirements as it creates a persistent topic within the Cluster.  Requirements on partition and replication and retention would need to be determined based on use case.

./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --create --replication-factor 1 --partitions 1 --topic dev.mytest.topic
Delete Topic
Use with even more caution as you are about to delete a topic.

./kafka-topics.bat --zookeeper z-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181,z-3.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:2181 --delete --topic i.really.know.that.i.need.to.delete.this.topic
Produce Message
Topic owners (producers) should own the production of messages.  But if this is needed for testing or manual trigger, you can use the below command.

The console producers accepts input as a line.  Every new line is considered a message.  So either paste the message in the buffer as a single line or use a file with lines per message.

Create a file with payload as a single line.  For example message.json.
Run below command.
./kafka-console-producer.bat --topic dev.mytest.topic --bootstrap-server b-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094,b-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094 --producer-property security.protocol=SSL < message.json
3. Close console with Ctrl+C

Consume/View Message
The console consumer consumes and displays messages. 

For checking all messages use the from-beginning (Note, messages in Kafka have a retention, so if this is beyond retention period the message will not be available.)

./kafka-console-consumer.bat --topic dev.mytest.topic --bootstrap-server b-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094,b-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094 --consumer-property security.protocol=SSL --from-beginning
For checking from a specific offset use the offset flag.  (Note offset requires a partition, using 0 as the partition.

$ ./kafka-console-consumer.bat --topic dev.mytest.topic --bootstrap-server b-1.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094,b-2.dev-elevaterewrite-ka.idck3t.c16.kafka.us-east-1.amazonaws.com:9094 --consumer-property security.protocol=SSL --offset 2 --partition 0
Close console with Ctrl+C after you are done.





