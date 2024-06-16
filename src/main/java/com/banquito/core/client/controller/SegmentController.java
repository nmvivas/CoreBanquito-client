package com.banquito.core.client.controller;

import com.banquito.core.client.model.Segment;
import com.banquito.core.client.service.SegmentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*", allowedHeaders = "*", methods = { RequestMethod.GET, RequestMethod.POST,
        RequestMethod.PUT })
@RestController
@RequestMapping("/segment")
public class SegmentController {

    private final SegmentService segmentService;

    public SegmentController(SegmentService segmentService) {
        this.segmentService = segmentService;
    }

    @GetMapping
    public List<Segment> getAllSegments() {
        return segmentService.getAllSegments();
    }

    @GetMapping("/{code}")
    public ResponseEntity<Segment> getSegmentByCode(@PathVariable String code) {
        try {
            Segment segment = segmentService.getSegmentByCode(code);
            return ResponseEntity.ok(segment);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Segment createSegment(@RequestBody Segment segment) {
        return segmentService.createSegment(segment);
    }

    @PutMapping("/{code}")
    public ResponseEntity<Segment> updateSegment(@PathVariable String code, @RequestBody Segment segmentDetails) {
        try {
            Segment updatedSegment = segmentService.updateSegment(code, segmentDetails);
            return ResponseEntity.ok(updatedSegment);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{code}")
    public ResponseEntity<Void> deleteSegment(@PathVariable String code) {
        try {
            segmentService.deleteSegment(code);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
