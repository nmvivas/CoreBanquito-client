package com.banquito.core.client.service;

import com.banquito.core.client.model.ClientAddress;
import com.banquito.core.client.repository.ClientAddressRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClientAddressService {

    private final ClientAddressRepository repository;

    public ClientAddressService(ClientAddressRepository repository) {
        this.repository = repository;
    }

    public List<ClientAddress> getAllClientAddresses() {
        return repository.findAll();
    }

    public ClientAddress getClientAddressById(Long id) {
        Optional<ClientAddress> clientAddressOpt = repository.findById(id);
        if (clientAddressOpt.isPresent()) {
            return clientAddressOpt.get();
        } else {
            throw new RuntimeException("No existe la dirección con id: " + id);
        }
    }

    public List<ClientAddress> getClientAddressesByClientId(Long clientId) {
        return repository.findByClientId(clientId);
    }

    public List<ClientAddress> getDefaultClientAddressesByClientId(Long clientId) {
        return repository.findByClientIdAndIsDefault(clientId, true);
    }

    public ClientAddress createClientAddress(ClientAddress clientAddress) {
        return repository.save(clientAddress);
    }

    public ClientAddress updateClientAddress(Long id, ClientAddress clientAddressDetails) {
        Optional<ClientAddress> optionalClientAddress = repository.findById(id);
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
            return repository.save(clientAddress);
        } else {
            throw new RuntimeException("No existe la dirección con id: " + id);
        }
    }

    public void deleteClientAddress(Long id) {
        Optional<ClientAddress> optionalClientAddress = repository.findById(id);
        if (optionalClientAddress.isPresent()) {
            repository.delete(optionalClientAddress.get());
        } else {
            throw new RuntimeException("No existe la dirección con id: " + id);
        }
    }
}
