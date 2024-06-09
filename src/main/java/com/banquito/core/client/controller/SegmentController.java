package com.banquito.core.client.controller;

import com.banquito.core.client.model.Segment;
import com.banquito.core.client.repository.SegmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/segment")
public class SegmentController {

    @Autowired
    private SegmentRepository segmentRepository;

    @GetMapping
    public List<Segment> getAllSegments() {
        return segmentRepository.findAllByOrderByName();
    }

    @GetMapping("/{code}")
    public ResponseEntity<Segment> getSegmentByCode(@PathVariable String code) {
        Optional<Segment> segment = segmentRepository.findById(code);
        return segment.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public Segment createSegment(@RequestBody Segment segment) {
        return segmentRepository.save(segment);
    }

    @PutMapping("/{code}")
    public ResponseEntity<Segment> updateSegment(@PathVariable String code, @RequestBody Segment segmentDetails) {
        Optional<Segment> optionalSegment = segmentRepository.findById(code);
        if (optionalSegment.isPresent()) {
            Segment segment = optionalSegment.get();
            segment.setName(segmentDetails.getName());
            segment.setClientType(segmentDetails.getClientType());
            segment.setDescription(segmentDetails.getDescription());
            final Segment updatedSegment = segmentRepository.save(segment);
            return ResponseEntity.ok(updatedSegment);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{code}")
    public ResponseEntity<Void> deleteSegment(@PathVariable String code) {
        Optional<Segment> optionalSegment = segmentRepository.findById(code);
        if (optionalSegment.isPresent()) {
            segmentRepository.delete(optionalSegment.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
