package com.banquito.core.client.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.banquito.core.client.model.Segment;
import java.util.List;

public interface SegmentRepository extends JpaRepository<Segment, String> {
    List<Segment> findAllByOrderByName();
}
