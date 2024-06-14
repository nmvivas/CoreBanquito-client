package com.banquito.core.client.util.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.mapstruct.ReportingPolicy;

import com.banquito.core.client.dto.ClientAddressDTO;
import com.banquito.core.client.model.ClientAddress;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ClientAddressMapper {

    ClientAddressDTO toDTO(ClientAddress clientAddress);

    ClientAddress toPersistence(ClientAddressDTO dto);
}
