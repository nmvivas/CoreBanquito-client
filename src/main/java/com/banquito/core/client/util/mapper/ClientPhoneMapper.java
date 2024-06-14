package com.banquito.core.client.util.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.mapstruct.ReportingPolicy;

import com.banquito.core.client.dto.ClientPhoneDTO;
import com.banquito.core.client.model.ClientPhone;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ClientPhoneMapper {

    ClientPhoneDTO toDTO(ClientPhone clientPhone);

    ClientPhone toPersistence(ClientPhoneDTO dto);
}
