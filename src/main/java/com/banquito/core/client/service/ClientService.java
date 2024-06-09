package com.banquito.core.client.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.banquito.core.client.model.Client;
import com.banquito.core.client.repository.ClientRepository;

@Service
public class ClientService {

    private final ClientRepository repository;

    public ClientService(ClientRepository repository) {
        this.repository = repository;
    }

    public List<Client> getAllClients() {
        return repository.findAll();
    }

    public Client getClientById(Long id) {
        Optional<Client> clientOpt = repository.findById(id);
        if (clientOpt.isPresent()) {
            return clientOpt.get();
        } else {
            throw new RuntimeException("No existe el cliente con id: " + id);
        }
    }

    public Client getClientByIdentification(String identification) {
        Client client = repository.findByIdentification(identification);
        if (client != null) {
            return client;
        } else {
            throw new RuntimeException("No existe cliente con la identificación: " + identification);
        }
    }

    public Client getClientByEmail(String email) {
        Client client = repository.findByEmail(email);
        if (client != null) {
            return client;
        } else {
            throw new RuntimeException("No existe cliente con el email: " + email);
        }
    }

    public Client getClientByFullName(String fullName) {
        Client client = repository.findByFullName(fullName);
        if (client != null) {
            return client;
        } else {
            throw new RuntimeException("No existe cliente con el nombre completo: " + fullName);
        }
    }

    public Client createClient(Client client) {
        return repository.save(client);
    }

    public Client updateClient(Long id, Client clientDetails) {
        Optional<Client> optionalClient = repository.findById(id);
        if (optionalClient.isPresent()) {
            Client client = optionalClient.get();
            client.setCodeSegment(clientDetails.getCodeSegment());
            client.setClientType(clientDetails.getClientType());
            client.setIdentificationType(clientDetails.getIdentificationType());
            client.setIdentification(clientDetails.getIdentification());
            client.setLastName(clientDetails.getLastName());
            client.setFirstName(clientDetails.getFirstName());
            client.setFullName(clientDetails.getFullName());
            client.setEmail(clientDetails.getEmail());
            client.setBirthDate(clientDetails.getBirthDate());
            client.setCompanyName(clientDetails.getCompanyName());
            client.setCompanyType(clientDetails.getCompanyType());
            client.setState(clientDetails.getState());
            client.setCreateDate(clientDetails.getCreateDate());
            client.setLastStatusDate(clientDetails.getLastStatusDate());
            client.setNationality(clientDetails.getNationality());
            client.setMaritalStatus(clientDetails.getMaritalStatus());
            client.setMonthlyAvgIncome(clientDetails.getMonthlyAvgIncome());
            client.setNotes(clientDetails.getNotes());
            return repository.save(client);
        } else {
            throw new RuntimeException("No existe el cliente con id: " + id);
        }
    }

    public void deleteClient(Long id) {
        Optional<Client> optionalClient = repository.findById(id);
        if (optionalClient.isPresent()) {
            repository.delete(optionalClient.get());
        } else {
            throw new RuntimeException("No existe el cliente con id: " + id);
        }
    }
}
