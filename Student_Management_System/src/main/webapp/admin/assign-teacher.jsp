<%-- 
    Document   : assign-teacher
    Created on : May 10, 2025, 1:42:09 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %> 
<html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Teacher Management Portal</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-6">

  <div class="max-w-3xl mx-auto bg-white shadow-lg rounded-xl p-6">
    <h1 class="text-3xl font-bold text-center text-blue-700 mb-6"> Add Teacher</h1>

    <!-- Form to Add Teacher -->
    <form id="teacherForm" class="space-y-4">
      <div>
        <label class="block text-gray-700">Full Name</label>
        <input type="text" id="name" class="w-full border p-2 rounded" placeholder="e.g., John Doe" required>
      </div>

      <div>
        <label class="block text-gray-700">Email</label>
        <input type="email" id="email" class="w-full border p-2 rounded" placeholder="e.g., john@example.com" required>
      </div>

      <div>
        <label class="block text-gray-700">Subject</label>
        <input type="text" id="subject" class="w-full border p-2 rounded" placeholder="e.g., Mathematics" required>
      </div>

      <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
        Add Teacher
      </button>
    </form>

    <!-- Teacher List -->
    <div class="mt-8">
      <h2 class="text-2xl font-semibold text-gray-800 mb-4">Teacher List</h2>
      <table class="w-full table-auto border border-gray-300">
        <thead class="bg-gray-200">
          <tr>
            <th class="px-4 py-2 border">#</th>
            <th class="px-4 py-2 border">Name</th>
            <th class="px-4 py-2 border">Email</th>
            <th class="px-4 py-2 border">Subject</th>
          </tr>
        </thead>
        <tbody id="teacherTableBody" class="text-center">
          <!-- Rows will be added here -->
        </tbody>
      </table>
    </div>
  </div>

  <script>
    const form = document.getElementById('teacherForm');
    const tableBody = document.getElementById('teacherTableBody');
    let teacherCount = 0;

    form.addEventListener('submit', function (e) {
      e.preventDefault();

      const name = document.getElementById('name').value.trim();
      const email = document.getElementById('email').value.trim();
      const subject = document.getElementById('subject').value.trim();

      if (!name || !email || !subject) {
        alert("Please fill in all fields.");
        return;
      }

      teacherCount++;
      const row = document.createElement('tr');

      row.innerHTML = `
        <td class="border px-4 py-2">${teacherCount}</td>
        <td class="border px-4 py-2">${name}</td>
        <td class="border px-4 py-2">${email}</td>
        <td class="border px-4 py-2">${subject}</td>
      `;

      tableBody.appendChild(row);

      // Clear form fields
      form.reset();
    });
  </script>

</body>
</html>
<%@ include file="footer.jsp" %>

