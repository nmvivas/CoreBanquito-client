package com.banquito.core.client.controller;

import com.banquito.core.client.model.ClientPhone;
import com.banquito.core.client.repository.ClientPhoneRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/clientPhone")
public class ClientPhoneController {

    @Autowired
    private ClientPhoneRepository clientPhoneRepository;

    @GetMapping
    public List<ClientPhone> getAllClientPhones() {
        return clientPhoneRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClientPhone> getClientPhoneById(@PathVariable Long id) {
        Optional<ClientPhone> clientPhone = clientPhoneRepository.findById(id);
        return clientPhone.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/client/{clientId}")
    public List<ClientPhone> getClientPhonesByClientId(@PathVariable Long clientId) {
        return clientPhoneRepository.findByClientId(clientId);
    }

    @GetMapping("/client/{clientId}/default")
    public List<ClientPhone> getDefaultClientPhonesByClientId(@PathVariable Long clientId) {
        return clientPhoneRepository.findByClientIdAndIsDefault(clientId, true);
    }

    @PostMapping
    public ClientPhone createClientPhone(@RequestBody ClientPhone clientPhone) {
        return clientPhoneRepository.save(clientPhone);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientPhone> updateClientPhone(@PathVariable Long id,
            @RequestBody ClientPhone clientPhoneDetails) {
        Optional<ClientPhone> optionalClientPhone = clientPhoneRepository.findById(id);
        if (optionalClientPhone.isPresent()) {
            ClientPhone clientPhone = optionalClientPhone.get();
            clientPhone.setClientId(clientPhoneDetails.getClientId());
            clientPhone.setPhoneType(clientPhoneDetails.getPhoneType());
            clientPhone.setPhoneNumber(clientPhoneDetails.getPhoneNumber());
            clientPhone.setIsDefault(clientPhoneDetails.getIsDefault());
            clientPhone.setState(clientPhoneDetails.getState());
            final ClientPhone updatedClientPhone = clientPhoneRepository.save(clientPhone);
            return ResponseEntity.ok(updatedClientPhone);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClientPhone(@PathVariable Long id) {
        Optional<ClientPhone> optionalClientPhone = clientPhoneRepository.findById(id);
        if (optionalClientPhone.isPresent()) {
            clientPhoneRepository.delete(optionalClientPhone.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
