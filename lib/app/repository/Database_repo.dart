import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';

class DatabaseService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Fetching Projects Function
  Future<List<Project>> fetchProjects() async {
    try {
      final response = await _supabaseClient.from('projects').select().order('id', ascending: false);
      return response.map((json) => Project.fromJson(json)).toList();
        } catch (e) {
      debugPrint('Error fetching projects: $e');
      return [];
    }
  }

  // Download Resume Function
  Future<void> downloadResume() async {
    try {
      final storage = Supabase.instance.client.storage;
      final downloadResponse = await storage.from('resumes').download('resume.pdf');

      // Here you would typically save the file to the device
      // For example using the `flutter_downloader` package
      debugPrint('Resume download successful');
        } catch (e) {
      debugPrint('Error downloading resume: $e');
    }
  }

  // Add Projects Function
  Future<bool> addProject(Project project) async {
    try {
      final response = await _supabaseClient.from('projects').insert([project.toJson()]);
      if (response is Map<String, dynamic>) {
        debugPrint('Project added successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when adding project');
        return false;
      }
    } catch (e) {
      debugPrint('Error adding project: $e');
      return false;
    }
  }

  // Update Projects Function
  Future<bool> updateProject(Project project) async {
    try {
      final response = await _supabaseClient.from('projects').update(project.toJson()).match({'id': project.id});
      if (response is Map<String, dynamic>) {
        debugPrint('Project updated successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when updating project');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating project: $e');
      return false;
    }
  }

  // Delete Projects Function
  Future<bool> deleteProject(String projectId) async {
    try {
      final response = await _supabaseClient.from('projects').delete().match({'id': projectId});
      if (response is Map<String, dynamic>) {
        debugPrint('Project deleted successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when deleting project');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting project: $e');
      return false;
    }
  }

  // Fetch Certifications Function
  Future<List<Certification>> fetchCertifications() async {
    try {
      final response = await _supabaseClient.from('certifications').select().order('id', ascending: false);
      return response.map((json) => Certification.fromJson(json)).toList();
        } catch (e) {
      debugPrint('Error fetching certifications: $e');
      return [];
    }
  }

  // Add Certification Function
  Future<bool> addCertification(Certification certification) async {
    try {
      final response = await _supabaseClient.from('certifications').insert([certification.toJson()]);
      if (response is Map<String, dynamic>) {
        debugPrint('Certification added successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when adding certification');
        return false;
      }
    } catch (e) {
      debugPrint('Error adding certification: $e');
      return false;
    }
  }

  // Update Certifications Function
  Future<bool> updateCertification(Certification certification) async {
    try {
      final response = await _supabaseClient.from('certifications').update(certification.toJson()).match({'id': certification.id});
      if (response is Map<String, dynamic>) {
        debugPrint('Certification updated successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when updating certification');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating certification: $e');
      return false;
    }
  }

  // Delete Certifications Function
  Future<bool> deleteCertification(String certificationId) async {
    try {
      final response = await _supabaseClient.from('certifications').delete().match({'id': certificationId});
      if (response is Map<String, dynamic>) {
        debugPrint('Certification deleted successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when deleting certification');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting certification: $e');
      return false;
    }
  }

  // Fetch Testimonials Function
  Future<List<Testimonial>> fetchTestimonials() async {
    try {
      final response = await _supabaseClient.from('testimonials').select().order('id', ascending: false);
      return response.map((json) => Testimonial.fromJson(json)).toList();
        } catch (e) {
      debugPrint('Error fetching testimonials: $e');
      return [];
    }
  }

  // Add Testimonial Function
  Future<bool> addTestimonial(Testimonial testimonial) async {
    try {
      final response = await _supabaseClient.from('testimonials').insert([testimonial.toJson()]);
      if (response is Map<String, dynamic>) {
        debugPrint('Testimonial added successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when adding testimonial');
        return false;
      }
    } catch (e) {
      debugPrint('Error adding testimonial: $e');
      return false;
    }
  }

  // Update Testimonials Function
  Future<bool> updateTestimonial(Testimonial testimonial) async {
    try {
      final response = await _supabaseClient.from('testimonials').update(testimonial.toJson()).match({'id': testimonial.id});
      if (response is Map<String, dynamic>) {
        debugPrint('Testimonial updated successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when updating testimonial');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating testimonial: $e');
      return false;
    }
  }

  // Delete Testimonials Function
  Future<bool> deleteTestimonial(String testimonialId) async {
    try {
      final response = await _supabaseClient.from('testimonials').delete().match({'id': testimonialId});
      if (response is Map<String, dynamic>) {
        debugPrint('Testimonial deleted successfully');
        return true;
      } else {
        debugPrint('Unexpected response format when deleting testimonial');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting testimonial: $e');
      return false;
    }
  }

  // Fetch Contact Messages
  Future<List<ContactMessage>> fetchContactMessages() async {
    try {
      final response = await _supabaseClient.from('contact_messages').select().order('timestamp', ascending: false);
      return response.map((json) => ContactMessage.fromJson(json)).toList();
        } catch (e) {
      debugPrint('Error fetching contact messages: $e');
      return [];
    }
  }
}