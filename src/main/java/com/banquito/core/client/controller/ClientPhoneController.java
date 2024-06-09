package com.banquito.core.client.controller;

import com.banquito.core.client.model.ClientPhone;
import com.banquito.core.client.service.ClientPhoneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/client_phone")
public class ClientPhoneController {

    @Autowired
    private ClientPhoneService clientPhoneService;

    @GetMapping
    public List<ClientPhone> getAllClientPhones() {
        return clientPhoneService.getAllClientPhones();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClientPhone> getClientPhoneById(@PathVariable Long id) {
        try {
            ClientPhone clientPhone = clientPhoneService.getClientPhoneById(id);
            return ResponseEntity.ok(clientPhone);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/client/{clientId}")
    public List<ClientPhone> getClientPhonesByClientId(@PathVariable Long clientId) {
        return clientPhoneService.getClientPhonesByClientId(clientId);
    }

    @GetMapping("/client/{clientId}/default")
    public List<ClientPhone> getDefaultClientPhonesByClientId(@PathVariable Long clientId) {
        return clientPhoneService.getDefaultClientPhonesByClientId(clientId);
    }

    @PostMapping
    public ClientPhone createClientPhone(@RequestBody ClientPhone clientPhone) {
        return clientPhoneService.createClientPhone(clientPhone);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientPhone> updateClientPhone(@PathVariable Long id,
            @RequestBody ClientPhone clientPhoneDetails) {
        try {
            ClientPhone updatedClientPhone = clientPhoneService.updateClientPhone(id, clientPhoneDetails);
            return ResponseEntity.ok(updatedClientPhone);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClientPhone(@PathVariable Long id) {
        try {
            clientPhoneService.deleteClientPhone(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
