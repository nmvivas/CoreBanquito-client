package com.banquito.core.client.service;

import com.banquito.core.client.model.ClientPhone;
import com.banquito.core.client.repository.ClientPhoneRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClientPhoneService {

    private final ClientPhoneRepository repository;
    private static final String CLIENT_PHONE_NOT_FOUND = "No existe el teléfono con id: ";

    public ClientPhoneService(ClientPhoneRepository repository) {
        this.repository = repository;
    }

    public List<ClientPhone> getAllClientPhones() {
        return repository.findAll();
    }

    public ClientPhone getClientPhoneById(Long id) {
        Optional<ClientPhone> clientPhoneOpt = repository.findById(id);
        if (clientPhoneOpt.isPresent()) {
            return clientPhoneOpt.get();
        } else {
            throw new RuntimeException(CLIENT_PHONE_NOT_FOUND + id);
        }
    }

    public List<ClientPhone> getClientPhonesByClientId(Long clientId) {
        return repository.findByClientId(clientId);
    }

    public List<ClientPhone> getDefaultClientPhonesByClientId(Long clientId) {
        return repository.findByClientIdAndIsDefault(clientId, true);
    }

    public ClientPhone createClientPhone(ClientPhone clientPhone) {
        return repository.save(clientPhone);
    }

    public ClientPhone updateClientPhone(Long id, ClientPhone clientPhoneDetails) {
        Optional<ClientPhone> optionalClientPhone = repository.findById(id);
        if (optionalClientPhone.isPresent()) {
            ClientPhone clientPhone = optionalClientPhone.get();
            clientPhone.setClientId(clientPhoneDetails.getClientId());
            clientPhone.setPhoneType(clientPhoneDetails.getPhoneType());
            clientPhone.setPhoneNumber(clientPhoneDetails.getPhoneNumber());
            clientPhone.setIsDefault(clientPhoneDetails.getIsDefault());
            clientPhone.setState(clientPhoneDetails.getState());
            return repository.save(clientPhone);
        } else {
            throw new RuntimeException(CLIENT_PHONE_NOT_FOUND + id);
        }
    }

    public void deleteClientPhone(Long id) {
        Optional<ClientPhone> optionalClientPhone = repository.findById(id);
        if (optionalClientPhone.isPresent()) {
            repository.delete(optionalClientPhone.get());
        } else {
            throw new RuntimeException(CLIENT_PHONE_NOT_FOUND + id);
        }
    }
}
