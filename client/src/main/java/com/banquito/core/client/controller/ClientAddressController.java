package com.banquito.core.client.controller;

import com.banquito.core.client.model.ClientAddress;
import com.banquito.core.client.repository.ClientAddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/clientAddress")
public class ClientAddressController {

    @Autowired
    private ClientAddressRepository clientAddressRepository;

    @GetMapping
    public List<ClientAddress> getAllClientAddresses() {
        return clientAddressRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClientAddress> getClientAddressById(@PathVariable Long id) {
        Optional<ClientAddress> clientAddress = clientAddressRepository.findById(id);
        return clientAddress.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/client/{clientId}")
    public List<ClientAddress> getClientAddressesByClientId(@PathVariable Long clientId) {
        return clientAddressRepository.findByClientId(clientId);
    }

    @GetMapping("/client/{clientId}/default")
    public List<ClientAddress> getDefaultClientAddressesByClientId(@PathVariable Long clientId) {
        return clientAddressRepository.findByClientIdAndIsDefault(clientId, true);
    }

    @PostMapping
    public ClientAddress createClientAddress(@RequestBody ClientAddress clientAddress) {
        return clientAddressRepository.save(clientAddress);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientAddress> updateClientAddress(@PathVariable Long id,
            @RequestBody ClientAddress clientAddressDetails) {
        Optional<ClientAddress> optionalClientAddress = clientAddressRepository.findById(id);
        if (optionalClientAddress.isPresent()) {
            ClientAddress clientAddress = optionalClientAddress.get();
            clientAddress.setClientId(clientAddressDetails.getClientId());
            clientAddress.setTypeAddress(clientAddressDetails.getTypeAddress());
            clientAddress.setLine1(clientAddressDetails.getLine1());
            clientAddress.setLine2(clientAddressDetails.getLine2());
            clientAddress.setLatitude(clientAddressDetails.getLatitude());
            clientAddress.setLongitude(clientAddressDetails.getLongitude());
            clientAddress.setZipCode(clientAddressDetails.getZipCode());
            clientAddress.setIsDefault(clientAddressDetails.getIsDefault());
            clientAddress.setState(clientAddressDetails.getState());
            final ClientAddress updatedClientAddress = clientAddressRepository.save(clientAddress);
            return ResponseEntity.ok(updatedClientAddress);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClientAddress(@PathVariable Long id) {
        Optional<ClientAddress> optionalClientAddress = clientAddressRepository.findById(id);
        if (optionalClientAddress.isPresent()) {
            clientAddressRepository.delete(optionalClientAddress.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
