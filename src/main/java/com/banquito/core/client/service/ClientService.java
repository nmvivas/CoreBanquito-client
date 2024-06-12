package com.banquito.core.client.service;

import com.banquito.core.client.model.Client;
import com.banquito.core.client.repository.ClientRepository;
import com.banquito.core.client.repository.ClientPhoneRepository;
import com.banquito.core.client.repository.ClientAddressRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class ClientService {

    private final ClientRepository clientRepository;
    private final ClientPhoneRepository clientPhoneRepository;
    private final ClientAddressRepository clientAddressRepository;

    public ClientService(ClientRepository clientRepository, ClientPhoneRepository clientPhoneRepository,
            ClientAddressRepository clientAddressRepository) {
        this.clientRepository = clientRepository;
        this.clientPhoneRepository = clientPhoneRepository;
        this.clientAddressRepository = clientAddressRepository;
    }

    public Client getClientById(Long id) {
        Optional<Client> clientOpt = clientRepository.findById(id);
        return clientOpt.orElseThrow(() -> new RuntimeException("No existe el cliente con id: " + id));
    }

    public Client getClientByIdentification(String identification) {
        return clientRepository.findByIdentification(identification);
    }

    public Client getClientByEmail(String email) {
        return clientRepository.findByEmail(email);
    }

    public Client getClientByFullName(String fullName) {
        return clientRepository.findByFullName(fullName);
    }

    public List<Client> getAllClients() {
        return clientRepository.findAll();
    }

    public Client createClient(Client client) {
        return clientRepository.save(client);
    }

    public Client updateClient(Long id, Client clientDetails) {
        Client client = getClientById(id);
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
        client.setTradename(clientDetails.getTradename());
        client.setCompanyType(clientDetails.getCompanyType());
        client.setState(clientDetails.getState());
        client.setCreationDate(clientDetails.getCreationDate());
        client.setLastStatusDate(clientDetails.getLastStatusDate());
        client.setNationality(clientDetails.getNationality());
        client.setMaritalStatus(clientDetails.getMaritalStatus());
        client.setMonthlyAvgIncome(clientDetails.getMonthlyAvgIncome());
        client.setNotes(clientDetails.getNotes());
        return clientRepository.save(client);
    }

    @Transactional
    public void deleteClient(Long id) {
        Client client = getClientById(id);
        client.setState("INA");
        clientRepository.save(client);

        clientPhoneRepository.findByClientId(id).forEach(phone -> {
            phone.setState("INA");
            clientPhoneRepository.save(phone);
        });

        clientAddressRepository.findByClientId(id).forEach(address -> {
            address.setState("INA");
            clientAddressRepository.save(address);
        });
    }

    @Transactional
    public void reactivateClient(Long id) {
        Client client = getClientById(id);
        client.setState("ACT");
        clientRepository.save(client);

        clientPhoneRepository.findByClientId(id).forEach(phone -> {
            phone.setState("ACT");
            clientPhoneRepository.save(phone);
        });

        clientAddressRepository.findByClientId(id).forEach(address -> {
            address.setState("ACT");
            clientAddressRepository.save(address);
        });
    }

    public Client getLastInsertedClient() {
        return clientRepository.findTopByOrderByCreationDateDesc();
    }

    public List<Client> getClientsByIdentificationType(String identificationType) {
        return clientRepository.findByIdentificationType(identificationType);
    }

    public List<Client> getClientsByTradename(String tradename) {
        return clientRepository.findByTradename(tradename);
    }

    public List<Client> getClientsByCompanyName(String companyName) {
        return clientRepository.findByCompanyName(companyName);
    }
}
