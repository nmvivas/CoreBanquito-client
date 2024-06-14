package com.banquito.core.client.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class SegmentDTO {

    private String code;
    private String name;
    private String clientType;
    private String description;
}
