<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.travel.model.Package" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Packages</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        async function fetchPackages() {
            const response = await fetch('/api/packages');
            const packages = await response.json();
            const packageTable = document.getElementById('packageTable');
            packageTable.innerHTML = '';

            packages.forEach(pkg => {
                packageTable.innerHTML += `
                    <tr>
                        <td>${pkg.id}</td>
                        <td>${pkg.name}</td>
                        <td>${pkg.price}</td>
                        <td>
                            <button class="btn btn-danger" onclick="deletePackage(${pkg.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
        }

        async function deletePackage(id) {
            await fetch(`/api/packages/${id}`, { method: 'DELETE' });
            fetchPackages();
        }

        window.onload = fetchPackages;
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Travel Packages</h1>
        <table class="table mt-3 table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="packageTable">
                <!-- Packages will be populated here -->
            </tbody>
        </table>

        <h2 class="mt-5">Add New Package</h2>
        <form id="packageForm" onsubmit="return addPackage(event)">
            <div class="form-group">
                <label for="name">Package Name</label>
                <input type="text" class="form-control" id="name" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" class="form-control" id="price" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Package</button>
        </form>
    </div>

    <script>
        async function addPackage(event) {
            event.preventDefault();
            const name = document.getElementById('name').value;
            const price = document.getElementById('price').value;

            await fetch('/api/packages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ name, price })
            });

            fetchPackages();
            document.getElementById('packageForm').reset();
        }
    </script>
</body>
</html>
