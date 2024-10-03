package com.travel.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.*;

@Entity
@Table(name = "tickets")
public class Ticket {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String passengerName;

    @Column(nullable = false)
    private String flightNumber;

    @ManyToOne
    @JoinColumn(name = "package_id", nullable = false)
    @JsonManagedReference
    private Package travelPackage;

    // Constructors
    public Ticket() {}

    public Ticket(String passengerName, String flightNumber, Package travelPackage) {
        this.passengerName = passengerName;
        this.flightNumber = flightNumber;
        this.travelPackage = travelPackage;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPassengerName() {
        return passengerName;
    }

    public void setPassengerName(String passengerName) {
        this.passengerName = passengerName;
    }

    public String getFlightNumber() {
        return flightNumber;
    }

    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }

    public Package getTravelPackage() {
        return travelPackage;
    }

    public void setTravelPackage(Package travelPackage) {
        this.travelPackage = travelPackage;
    }
}
