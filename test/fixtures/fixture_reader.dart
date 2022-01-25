
import 'dart:io';

String fixtures(String name) => File("test/fixtures/$name").readAsStringSync(); 

//test can not read a file so we convert the file to a String