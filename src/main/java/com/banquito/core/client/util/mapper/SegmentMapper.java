package com.banquito.core.client.util.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.mapstruct.ReportingPolicy;

import com.banquito.core.client.dto.SegmentDTO;
import com.banquito.core.client.model.Segment;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface SegmentMapper {

    SegmentDTO toDTO(Segment segment);

    Segment toPersistence(SegmentDTO dto);
}
