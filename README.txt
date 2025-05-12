# DEA-Assignment-Group-G - Student Management System

Group Members

Name                    Responsibilities
NN Akmeemana            Creating Project Structure and Front-end & Back-end & Debugging Errors

                              •	Java files (model, dao, controller, util)
                                com.sms.model
                                •	User.java
                                •	Student.java
                                •	Teacher.java
                                •	Course.java
                                •	Attendance.java
                                •	Grade.java
                                (6 files)
                              
                                com.sms.controller
                                •	LoginServlet.java
                                •	RegisterServlet.java
                                •	AdminServlet.java
                                •	StudentServlet.java
                                •	TeacherServlet.java
                                •	LogoutServlet.java
                                •	ProfileServlet.java
                                (7 files)

                              • JSPs:
                                •	index.jsp
                                •	login.jsp
                                •	register.jsp
                                •	profile.jsp
                                •	error.jsp
                                •	error-404.jsp
                                •	error-500.jsp
                                (7 files)


SKSN Dayarathna         Database Design & Front-end
                              • JSPs

                                admin/                                
                                •	edit-student.jsp
                                •	edit-teacher.jsp
                                •	edit-course.jsp
                                •	assign-teacher.jsp
                                (4 files)

SA Gunarathna           Debugging and Find Errors, and Resolve Them
GMA Hansamalee          Front-end and Creating Project Report

                              • JSPs
                                includes/
                                •	header.jsp
                                •	footer.jsp
                                (2 files)

                              • Creating Project Report

AMDT Jayasekara         Front-end & Debugging and Find Errors, and Resolve Them

                              • JSPs
                                admin/
                                •	dashboard.jsp
                                •	manage-students.jsp
                                •	manage-teachers.jsp
                                •	manage-courses.jsp                               
                                (4 files)


IDJA Kumara             Backend-end

                              •	Java files (model, dao, controller, util)
                                com.sms.dao
                                •	TeacherDao.java - insertTeacher, getTeacherByid, getTeacherByUserId, getAllTeachers, updateTeacher, deleteTeacher, getTeacherCourses
                                •	CourseDao.java - insertCourse, getCourseById, getAllCourses, getCoursesByTeacherId, getCoursesByStudentId, updateCourse, deleteCourse, getStudentCountForCourse
                                •	AttendanceDao.java - insertAttendance, getAttendanceById, getAttendanceByStudentCourseDate, getAttendanceByStudentId, getAttendanceByCourseId, getAttendanceByStudentAndCourse,                                         getAttendanceByDateAndCourse, updateAttendance, deleteAttendance, getAttendancePercentage
                                •	GradeDao.java - insertGrade, getGradeByStudentAndCourse, getGradesByStudentId, getGradesByCourseId, updateGrade, deleteGrade
                                (4 files)

DAOY Peiris             Front-end and Creating Project Report

                              • JSPs
                                student/
                                •	dashboard.jsp
                                •	view-courses.jsp
                                (2 files)

                              • Creating Project Report

MJD Priyashan           Front-end

                              • JSPs
                                student/
                                •	view-grades.jsp
                                •	view-attendance.jsp
                                •	course-registration.jsp
                                (3 files)

MWVL Rupasingha         Back-end & Debugging and Find Errors and Resolve Them
                              •	Java files (model, dao, controller, util)
                                com.sms.dao
                                •	DatabaseConnection.java - database.properties file
                                •	UserDao.java - insertUser, validateUser, usernameExists, emailExists, getUserById, getAllUsers, updateUser, updatePassword, deleteUser
                                •	StudentDao.java - insertStudent, getStudentById, getStudentByUserId, getStudentsByCourseId, getAllStudents, updateStudent, deleteStudent, enrollStudentInCourse,                                                       getStudentCourses, removeStudentFromCourse                     
                                (3 files)


MJPS Sanduwinna         Ui Design

