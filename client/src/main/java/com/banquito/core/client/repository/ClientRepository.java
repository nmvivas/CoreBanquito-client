package com.banquito.core.client.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.banquito.core.client.model.Client;

public interface ClientRepository extends JpaRepository<Client, Long> {

    Client findByIdentification(String identification);

    Client findByEmail(String email);

    Client findByFullName(String fullName);
}
