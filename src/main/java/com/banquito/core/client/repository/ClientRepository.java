package com.banquito.core.client.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.banquito.core.client.model.Client;
import java.util.List;

public interface ClientRepository extends JpaRepository<Client, Long> {

    Client findByIdentification(String identification);

    Client findByEmail(String email);

    Client findByFullName(String fullName);

    List<Client> findByState(String state);

    List<Client> findByIdentificationType(String identificationType);

    List<Client> findByTradename(String tradename);

    List<Client> findByCompanyName(String companyName);

    Client findTopByOrderByCreationDateDesc();
}
