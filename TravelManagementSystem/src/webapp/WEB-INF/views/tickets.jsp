<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.travel.model.Ticket" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Tickets</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        async function fetchTickets() {
            const response = await fetch('/api/tickets');
            const tickets = await response.json();
            const ticketTable = document.getElementById('ticketTable');
            ticketTable.innerHTML = '';

            tickets.forEach(ticket => {
                ticketTable.innerHTML += `
                    <tr>
                        <td>${ticket.id}</td>
                        <td>${ticket.customerId}</td>
                        <td>${ticket.packageId}</td>
                        <td>
                            <button class="btn btn-danger" onclick="deleteTicket(${ticket.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
        }

        async function deleteTicket(id) {
            await fetch(`/api/tickets/${id}`, { method: 'DELETE' });
            fetchTickets();
        }

        window.onload = fetchTickets;
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Manage Tickets</h1>
        <table class="table mt-3 table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Customer ID</th>
                    <th>Package ID</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="ticketTable">
                <!-- Tickets will be populated here -->
            </tbody>
        </table>

        <h2 class="mt-5">Add New Ticket</h2>
        <form id="ticketForm" onsubmit="return addTicket(event)">
            <div class="form-group">
                <label for="customerId">Customer ID</label>
                <input type="number" class="form-control" id="customerId" required>
            </div>
            <div class="form-group">
                <label for="packageId">Package ID</label>
                <input type="number" class="form-control" id="packageId" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Ticket</button>
        </form>
    </div>

    <script>
        async function addTicket(event) {
            event.preventDefault();
            const customerId = document.getElementById('customerId').value;
            const packageId = document.getElementById('packageId').value;

            await fetch('/api/tickets', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ customerId, packageId })
            });

            fetchTickets();
            document.getElementById('ticketForm').reset();
        }
    </script>
</body>
</html>
