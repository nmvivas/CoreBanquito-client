package com.banquito.core.client.service;

import com.banquito.core.client.model.Client;
import com.banquito.core.client.repository.ClientRepository;
import com.banquito.core.client.repository.ClientPhoneRepository;
import com.banquito.core.client.repository.ClientAddressRepository;
import com.banquito.core.client.dto.ClientDTO;
import com.banquito.core.client.util.mapper.ClientMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClientService {

    private final ClientRepository clientRepository;
    private final ClientPhoneRepository clientPhoneRepository;
    private final ClientAddressRepository clientAddressRepository;
    private final ClientMapper clientMapper;
    private static final String CLIENT_NOT_FOUND = "No existe el cliente con id: ";

    public ClientService(ClientRepository clientRepository, ClientPhoneRepository clientPhoneRepository,
            ClientAddressRepository clientAddressRepository, ClientMapper clientMapper) {
        this.clientRepository = clientRepository;
        this.clientPhoneRepository = clientPhoneRepository;
        this.clientAddressRepository = clientAddressRepository;
        this.clientMapper = clientMapper;
    }

    public ClientDTO getClientById(Long id) {
        Client client = clientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(CLIENT_NOT_FOUND + id));
        return clientMapper.toDTO(client);
    }

    public ClientDTO getClientByIdentification(String identification) {
        return clientMapper.toDTO(clientRepository.findByIdentification(identification));
    }

    public ClientDTO getClientByEmail(String email) {
        return clientMapper.toDTO(clientRepository.findByEmail(email));
    }

    public ClientDTO getClientByFullName(String fullName) {
        return clientMapper.toDTO(clientRepository.findByFullName(fullName));
    }

    public List<ClientDTO> getAllClients() {
        return clientRepository.findAll().stream()
                .map(clientMapper::toDTO)
                .collect(Collectors.toList());
    }

    public ClientDTO createClient(ClientDTO clientDTO) {
        Client client = clientMapper.toPersistence(clientDTO);
        return clientMapper.toDTO(clientRepository.save(client));
    }

    public ClientDTO updateClient(Long id, ClientDTO clientDetails) {
        Client client = clientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(CLIENT_NOT_FOUND + id));
        client.setLastName(clientDetails.getLastName());
        client.setFirstName(clientDetails.getFirstName());
        client.setFullName(clientDetails.getFullName());
        client.setEmail(clientDetails.getEmail());
        client.setMaritalStatus(clientDetails.getMaritalStatus());
        client.setNationality(clientDetails.getNationality());
        client.setCompanyName(clientDetails.getCompanyName());
        client.setTradename(clientDetails.getTradename());
        client.setCompanyType(clientDetails.getCompanyType());
        client.setNotes(clientDetails.getNotes());
        client.setIdentificationType(clientDetails.getIdentificationType());
        client.setIdentification(clientDetails.getIdentification());
        client.setMonthlyAvgIncome(clientDetails.getMonthlyAvgIncome());

        return clientMapper.toDTO(clientRepository.save(client));
    }

    @Transactional
    public void deleteClient(Long id) {
        Client client = clientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(CLIENT_NOT_FOUND + id));
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
        Client client = clientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException(CLIENT_NOT_FOUND + id));
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

    public ClientDTO getLastInsertedClient() {
        return clientMapper.toDTO(clientRepository.findTopByOrderByCreationDateDesc());
    }

    public List<ClientDTO> getClientsByIdentificationType(String identificationType) {
        return clientRepository.findByIdentificationType(identificationType).stream()
                .map(clientMapper::toDTO)
                .collect(Collectors.toList());
    }

    public List<ClientDTO> getClientsByTradename(String tradename) {
        return clientRepository.findByTradename(tradename).stream()
                .map(clientMapper::toDTO)
                .collect(Collectors.toList());
    }

    public List<ClientDTO> getClientsByCompanyName(String companyName) {
        return clientRepository.findByCompanyName(companyName).stream()
                .map(clientMapper::toDTO)
                .collect(Collectors.toList());
    }
}
