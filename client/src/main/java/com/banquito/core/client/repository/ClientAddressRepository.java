package com.banquito.core.client.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.banquito.core.client.model.ClientAddress;
import java.util.List;

public interface ClientAddressRepository extends JpaRepository<ClientAddress, Long> {
    List<ClientAddress> findByClientId(Long clientId);

    List<ClientAddress> findByClientIdAndIsDefault(Long clientId, Boolean isDefault);
}
