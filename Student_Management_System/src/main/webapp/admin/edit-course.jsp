<%-- 
    Document   : edit-course
    Created on : May 10, 2025, 1:42:54 PM
    Author     : Nilesh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %> 
<html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Manage Courses</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-10">

  <h1 class="text-3xl font-bold mb-8">Manage Courses</h1>

  <div class="bg-white shadow-lg rounded-xl p-6 max-w-5xl mx-auto">
    
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-xl font-semibold">Course List</h2>
      <button class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700">
        Add New Course
      </button>
    </div>

    <input type="text" placeholder="Search courses..." class="w-full mb-4 p-2 border border-gray-300 rounded-md">

    <table class="min-w-full text-left border-collapse">
      <thead>
        <tr class="bg-gray-200 text-sm text-gray-700">
          <th class="p-3">ID</th>
          <th class="p-3">CODE</th>
          <th class="p-3">NAME</th>
          <th class="p-3">CREDIT HOURS</th>
          <th class="p-3">TEACHER</th>
          <th class="p-3">ACTIONS</th>
        </tr>
      </thead>
      <tbody class="text-sm">
        <tr class="border-t">
          <td class="p-3">1</td>
          <td class="p-3">MA 102.3</td>
          <td class="p-3">Mathematics for Computing</td>
          <td class="p-3">4</td>
          <td class="p-3">Gayan perera</td>
          <td class="p-3 space-x-2">
            <a href="#" class="text-indigo-600 font-medium hover:underline">Edit</a>
            <a href="#" class="text-indigo-600 font-medium hover:underline">Assign Teacher</a>
            <a href="#" class="text-red-600 font-medium hover:underline">Delete</a>
          </td>
        </tr>
        <tr class="border-t bg-gray-50">
          <td class="p-3">2</td>
          <td class="p-3">SE 101.4</td>
          <td class="p-3">System Analysis Design</td>
          <td class="p-3">4</td>
          <td class="p-3">Gayan perera</td>
          <td class="p-3 space-x-2">
            <a href="#" class="text-indigo-600 font-medium hover:underline">Edit</a>
            <a href="#" class="text-indigo-600 font-medium hover:underline">Assign Teacher</a>
            <a href="#" class="text-red-600 font-medium hover:underline">Delete</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

</body>
</html>
<%@ include file="footer.jsp" %>
