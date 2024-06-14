package com.banquito.core.client.util.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.mapstruct.ReportingPolicy;
import com.banquito.core.client.dto.ClientDTO;
import com.banquito.core.client.model.Client;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ClientMapper {
    ClientDTO toDTO(Client client);

    Client toPersistence(ClientDTO dto);
}
