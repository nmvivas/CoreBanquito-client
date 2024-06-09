package com.banquito.core.client.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.banquito.core.client.model.ClientPhone;
import java.util.List;

public interface ClientPhoneRepository extends JpaRepository<ClientPhone, Long> {
    List<ClientPhone> findByClientId(Long clientId);

    List<ClientPhone> findByClientIdAndIsDefault(Long clientId, Boolean isDefault);
}
