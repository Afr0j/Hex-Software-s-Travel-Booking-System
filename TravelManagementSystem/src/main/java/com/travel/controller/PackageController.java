package com.travel.controller;

import com.travel.model.Package;
import com.travel.service.PackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/packages")
public class PackageController {

    @Autowired
    private PackageService packageService;

    // Get all packages
    @GetMapping
    public List<Package> getAllPackages() {
        return packageService.getAllPackages();
    }

    // Get package by ID
    @GetMapping("/{id}")
    public ResponseEntity<Package> getPackageById(@PathVariable Long id) {
        Package travelPackage = packageService.getPackageById(id);
        return travelPackage != null ? ResponseEntity.ok(travelPackage) : ResponseEntity.notFound().build();
    }

    // Create a new package
    @PostMapping
    public Package createPackage(@RequestBody Package travelPackage) {
        return packageService.savePackage(travelPackage);
    }

    // Delete a package
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePackage(@PathVariable Long id) {
        packageService.deletePackage(id);
        return ResponseEntity.noContent().build();
    }
}
