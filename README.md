# Requirements

- [Python] 3.6 or later 

# Commands:
- python3 server.py
- python3 client.py

server listening on 127.0.0.1:60000

##REPORT
# Architeture Design:

<em>The Key Value Cache Class containing:</em>
-	Constructor to define socket, port, define the address type, lock, and bind the connection
-	listen() is the starting call to establish the connection for a defined client and start a specific thread for a for a client's connection pipe to read from it's buffer. Lock() for a specific client also gets initialized.
-	For each client, the ListenToClient() starts the connection and starts listening to it's buffer via - byte_data = client.recv(2048). 
	-	Reads incoming data for token keywords to call relevant _get and _set.
	-	Tokenized key, size, and value and sends the get, set parameters
-	_set() acquires lock for a client for the write operation hence ensuring the exclusive writes priveledges. The entered key, value gets json dumped in a file. 
	-	In case of faliue in the file access and/or key insert/update operation "NOT STORED" gets handled in the exception. Lock released for the write operation and critical section for the connection is implemented here. 
-	_get() outputs searched value for the given key from the json object of the file and also handles invalid search for unstored key.
-	The appropriate return in the listenToClient() is flushed to the client. The server keeps listening for the incoming client connections continuously.
- 	client.py makes multiple get and set requests to the server. including the significantly big value streams and searching for a key that does not exist in the store. 

#Testing and Performance:

-	Multiple instances of client started simutaneously to check the currency and performance. 
-	<strong>time.sleep(60)</strong> function blocks after client's set request so that, starting other clients, concurrency can be checked.
-	The code has also been tested with dummy telnet clients in addition to the test cases implemented in the client.py for concurrency check.
-	The server also outputs the time taken for data processing of clients request for performance measurement approximations. Given client test cases take approximately <strong>100 ns</strong> for the completion, on average.
-	 The server handles various edge cases of store and retrive functions and also handles exceptions in connection faliure, file access faliure, multiple, concurrent write operations.
-	Implements two key search in the file system techniques. File seek/search technique for performance enhancement can be used. 
 
#Limitations and Proposed Improvements : 

-	Implementation of key-store cache in the file as the json can be inefficient due to full file read and write operations. A File seek based approach can lead to faster results by sequencial file traversal.
-	Above can have a key seek based implementation similar to the code snippet written on the server side. 
- 	Suggested structure for key-store cache file:
		- k1 size1 encoded<value1>\r\n
		  k2 size2 encoded<value2>\r\n
		  ...
		  kn sizen encoded<valuen>\r\n
-	Base-64 Encoded values can help in excluding the special character glitches in the file traversal. 
-	Above will help in <strong>skipping</strong> the exact "sizen" for a "keyn" in case keyn is not the searched key. The search will hence be faster as it's skipping bytes written after the key and not traversing the whole file.
-	Another limitation can be a limited buffer size for extremely large data inputs. We have currently defined 2048 as the buffer size but for huge client loads this can be a bottleneck.
-	file open is also an expensive operation. This is limiting our server performance and we have to open and close the file for each operation. Especially for critical section this can become bottleneck for few client operations. Hence write intensive client operation may not be very efficient. 
-	Initial check and creation of file store is handled for the first operation.
-	There is certainly better error handling scope in the code. Keyboard incurrupt occasionally breaks the pipe. Also, the port can remain engaged if not killed properly. We can implement better edge cases for process kills.
-	Client's implementation can be improved by splitting the set command input in two lines that can be entered by the user. A continuously interfacing client that let's user input multiple set <key> <size>\r\n <value> and get <key> input can be improvised. 

Sample key-store.json is zipped in the folder.

![server-log-sample](file:///home/arunima/cloud_asignment_1/assignment1/server-logs.png)
