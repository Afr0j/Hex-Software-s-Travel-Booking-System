package com.travel.service;

import com.travel.model.Ticket;
import com.travel.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    // Get all tickets
    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    // Save a ticket
    public Ticket saveTicket(Ticket ticket) {
        return ticketRepository.save(ticket);
    }

    // Find a ticket by ID
    public Ticket getTicketById(Long id) {
        return ticketRepository.findById(id).orElse(null);
    }

    // Delete a ticket
    public void deleteTicket(Long id) {
        ticketRepository.deleteById(id);
    }
}
