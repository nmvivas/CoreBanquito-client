package com.banquito.core.client.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ClientPhoneDTO {

    private Long id;
    private String phoneType;
    private String phoneNumber;
    private Boolean isDefault;
    private String state;
}
