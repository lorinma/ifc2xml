ifc2xml
============
open source (LGPL) software for converting IFC file to xml using matlab

操作步骤
1  将您的ifc文件放置于 project_of_teacherMa\data路径下 ；
2  修改main_CreateGeometricalXML.m文件中ifcfilename = 'Project1'为自己的ifc文件名字 ，注意此处不需要.ifc的后缀；
3  直接运行main_CreateGeometricalXML.m文件；
4  project_of_teacherMa\data路径下 会自动生成 FACESandVERTICES-ifcname.txt与Geometrical-ifcname.txt这样的两个文件；

测试
以Project1.ifc作为测试实例
1  将文件Project1.ifc放置于 project_of_teacherMa\data路径下 ；
2  修改main_CreateGeometricalXML.m文件中ifcfilename = 'Project1' ；
3  直接运行main_CreateGeometricalXML.m文件；
4  project_of_teacherMa\data路径下自动生成 FACESandVERTICES-Project1.txt与Geometrical-Project1.xml两个文件；

运行时间大约10s左右。
