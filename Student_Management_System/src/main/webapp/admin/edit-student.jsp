<%-- 
    Document   : edit-student
    Created on : May 10, 2025, 1:43:23 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><%@ include file="header.jsp" %> 
<html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Student Page</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-6">

  <div class="max-w-4xl mx-auto bg-white shadow-xl rounded-xl p-6">
    <h1 class="text-3xl font-bold text-center text-blue-700 mb-6"> Manage Students</h1>

    <!-- Add/Edit Student Form -->
    <form id="studentForm" class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
      <input type="text" id="studentName" placeholder="Full Name" class="border p-2 rounded" required>
      <input type="email" id="studentEmail" placeholder="Email" class="border p-2 rounded" required>
      <input type="text" id="studentClass" placeholder="Class" class="border p-2 rounded" required>
      <button type="submit" class="col-span-1 md:col-span-3 bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
        Save Student
      </button>
    </form>

    <!-- Student List Table -->
    <div>
      <h2 class="text-xl font-semibold mb-3 text-gray-800">Student List</h2>
      <table class="w-full border border-gray-300">
        <thead class="bg-gray-200 text-gray-700">
          <tr>
            <th class="border px-4 py-2">#</th>
            <th class="border px-4 py-2">Name</th>
            <th class="border px-4 py-2">Email</th>
            <th class="border px-4 py-2">Class</th>
            <th class="border px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody id="studentTableBody" class="text-center">
          <!-- Dynamic rows inserted here -->
        </tbody>
      </table>
    </div>
  </div>

  <script>
    let students = [];
    let editIndex = null;

    const studentForm = document.getElementById('studentForm');
    const studentTable = document.getElementById('studentTableBody');

    studentForm.addEventListener('submit', function (e) {
      e.preventDefault();

      const name = document.getElementById('studentName').value.trim();
      const email = document.getElementById('studentEmail').value.trim();
      const studentClass = document.getElementById('studentClass').value.trim();

      if (!name || !email || !studentClass) {
        alert("All fields are required.");
        return;
      }

      const student = { name, email, studentClass };

      if (editIndex !== null) {
        students[editIndex] = student;
        editIndex = null;
      } else {
        students.push(student);
      }

      studentForm.reset();
      renderStudentTable();
    });

    function renderStudentTable() {
      studentTable.innerHTML = "";

      students.forEach((student, index) => {
        const row = document.createElement("tr");
        row.innerHTML = `
          <td class="border px-4 py-2">${index + 1}</td>
          <td class="border px-4 py-2">${student.name}</td>
          <td class="border px-4 py-2">${student.email}</td>
          <td class="border px-4 py-2">${student.studentClass}</td>
          <td class="border px-4 py-2 space-x-2">
            <button class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600" onclick="editStudent(${index})">Edit</button>
            <button class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600" onclick="deleteStudent(${index})">Delete</button>
          </td>
        `;
        studentTable.appendChild(row);
      });
    }

    function editStudent(index) {
      const student = students[index];
      document.getElementById('studentName').value = student.name;
      document.getElementById('studentEmail').value = student.email;
      document.getElementById('studentClass').value = student.studentClass;
      editIndex = index;
    }

    function deleteStudent(index) {
      if (confirm("Are you sure you want to delete this student?")) {
        students.splice(index, 1);
        renderStudentTable();
      }
    }
  </script>

</body>
</html>
<%@ include file="footer.jsp" %>

