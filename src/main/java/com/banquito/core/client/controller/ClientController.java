package com.banquito.core.client.controller;

import com.banquito.core.client.dto.ClientDTO;
import com.banquito.core.client.service.ClientService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import com.banquito.core.client.model.Client;
import com.banquito.core.client.service.ClientService;

@CrossOrigin(origins = "*", allowedHeaders = "*", methods = { RequestMethod.GET, RequestMethod.POST,
        RequestMethod.PUT })
@RestController
@RequestMapping("/client")
public class ClientController {

    private final ClientService clientService;

    public ClientController(ClientService clientService) {
        this.clientService = clientService;
    }

    @GetMapping
    public List<ClientDTO> getAllClients() {
        return clientService.getAllClients();
    }


    @GetMapping("/{id}")
    public ResponseEntity<ClientDTO> getClientById(@PathVariable Long id) {
        try {
            ClientDTO client = clientService.getClientById(id);
            return ResponseEntity.ok(client);
        } catch (RuntimeException rte) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/identification/{identification}")
    public ResponseEntity<ClientDTO> getClientByIdentification(@PathVariable String identification) {
        try {
            ClientDTO client = clientService.getClientByIdentification(identification);
            return ResponseEntity.ok(client);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<ClientDTO> getClientByEmail(@PathVariable String email) {
        try {
            ClientDTO client = clientService.getClientByEmail(email);
            return ResponseEntity.ok(client);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/fullname/{fullName}")
    public ResponseEntity<ClientDTO> getClientByFullName(@PathVariable String fullName) {
        try {
            ClientDTO client = clientService.getClientByFullName(fullName);
            return ResponseEntity.ok(client);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ClientDTO createClient(@RequestBody ClientDTO client) {
        return clientService.createClient(client);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientDTO> updateClient(@PathVariable Long id, @RequestBody ClientDTO clientDetails) {
        try {
            ClientDTO updatedClient = clientService.updateClient(id, clientDetails);
            return ResponseEntity.ok(updatedClient);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClient(@PathVariable Long id) {
        try {
            clientService.deleteClient(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/reactivate/{id}")
    public ResponseEntity<Void> reactivateClient(@PathVariable Long id) {
        try {
            clientService.reactivateClient(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/last")
    public ResponseEntity<ClientDTO> getLastInsertedClient() {
        return ResponseEntity.ok(clientService.getLastInsertedClient());
    }

    @GetMapping("/identification_type/{identificationType}")
    public List<ClientDTO> getClientsByIdentificationType(@PathVariable String identificationType) {
        return clientService.getClientsByIdentificationType(identificationType);
    }

    @GetMapping("/tradename/{tradename}")
    public List<ClientDTO> getClientsByTradename(@PathVariable String tradename) {
        return clientService.getClientsByTradename(tradename);
    }

    @GetMapping("/company_name/{companyName}")
    public List<ClientDTO> getClientsByCompanyName(@PathVariable String companyName) {
        return clientService.getClientsByCompanyName(companyName);
    }
}
