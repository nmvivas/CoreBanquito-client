package com.banquito.core.client.dto;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ClientDTO {

    private Long id;
    private String codeSegment;
    private String clientType;
    private String identificationType;
    private String identification;
    private String lastName;
    private String firstName;
    private String email;
    private LocalDateTime birthDate;
    private String companyName;
    private String tradename;
    private String companyType;
    // private String state;
    private LocalDateTime creationDate;
    // private LocalDateTime lastStatusDate;
    private String nationality;
    private String maritalStatus;
    // private BigDecimal monthlyAvgIncome;
    private String notes;

    public String getFullName() {
        return this.firstName + " " + this.lastName;
    }
}
