package com.banquito.core.client.controller;

import com.banquito.core.client.model.ClientAddress;
import com.banquito.core.client.service.ClientAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/client_address")
public class ClientAddressController {

    @Autowired
    private ClientAddressService clientAddressService;

    @GetMapping
    public List<ClientAddress> getAllClientAddresses() {
        return clientAddressService.getAllClientAddresses();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClientAddress> getClientAddressById(@PathVariable Long id) {
        try {
            ClientAddress clientAddress = clientAddressService.getClientAddressById(id);
            return ResponseEntity.ok(clientAddress);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/client/{clientId}")
    public List<ClientAddress> getClientAddressesByClientId(@PathVariable Long clientId) {
        return clientAddressService.getClientAddressesByClientId(clientId);
    }

    @GetMapping("/client/{clientId}/default")
    public List<ClientAddress> getDefaultClientAddressesByClientId(@PathVariable Long clientId) {
        return clientAddressService.getDefaultClientAddressesByClientId(clientId);
    }

    @PostMapping
    public ClientAddress createClientAddress(@RequestBody ClientAddress clientAddress) {
        return clientAddressService.createClientAddress(clientAddress);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientAddress> updateClientAddress(@PathVariable Long id,
            @RequestBody ClientAddress clientAddressDetails) {
        try {
            ClientAddress updatedClientAddress = clientAddressService.updateClientAddress(id, clientAddressDetails);
            return ResponseEntity.ok(updatedClientAddress);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClientAddress(@PathVariable Long id) {
        try {
            clientAddressService.deleteClientAddress(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
