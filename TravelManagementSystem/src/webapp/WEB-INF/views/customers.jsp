<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.travel.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        async function fetchCustomers() {
            const response = await fetch('/api/customers');
            const customers = await response.json();
            const customerTable = document.getElementById('customerTable');
            customerTable.innerHTML = '';

            customers.forEach(customer => {
                customerTable.innerHTML += `
                    <tr>
                        <td>${customer.id}</td>
                        <td>${customer.name}</td>
                        <td>${customer.email}</td>
                        <td>
                            <button class="btn btn-danger" onclick="deleteCustomer(${customer.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
        }

        async function deleteCustomer(id) {
            await fetch(`/api/customers/${id}`, { method: 'DELETE' });
            fetchCustomers();
        }

        window.onload = fetchCustomers;
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Manage Customers</h1>
        
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="customerTable">
                <!-- Customers will be populated here -->
            </tbody>
        </table>
        
        <h2 class="mt-5">Add New Customer</h2>
        <form id="customerForm" onsubmit="return addCustomer(event)">
            <div class="form-group">
                <label for="name">Customer Name</label>
                <input type="text" class="form-control" id="name" placeholder="Enter customer name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email address" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Customer</button>
        </form>
    </div>

    <script>
        async function addCustomer(event) {
            event.preventDefault();
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;

            await fetch('/api/customers', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ name, email })
            });

            fetchCustomers();
            document.getElementById('customerForm').reset();
        }
    </script>
</body>
</html>
