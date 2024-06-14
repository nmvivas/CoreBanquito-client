package com.banquito.core.client.dto;

import java.math.BigDecimal;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ClientAddressDTO {

    private Long id;
    private String typeAddress;
    private String line1;
    private String line2;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private String zipCode;
    private Boolean isDefault;
    private String state;
}
