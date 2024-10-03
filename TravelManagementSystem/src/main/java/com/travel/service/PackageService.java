package com.travel.service;

import com.travel.model.Package;
import com.travel.repository.PackageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PackageService {

    @Autowired
    private PackageRepository packageRepository;

    // Get all packages
    public List<Package> getAllPackages() {
        return packageRepository.findAll();
    }

    // Save a package
    public Package savePackage(Package travelPackage) {
        return packageRepository.save(travelPackage);
    }

    // Find a package by ID
    public Package getPackageById(Long id) {
        return packageRepository.findById(id).orElse(null);
    }

    // Delete a package
    public void deletePackage(Long id) {
        packageRepository.deleteById(id);
    }
}
