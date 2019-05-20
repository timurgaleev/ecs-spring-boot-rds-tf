package com.example.aksisapp.repos;

import com.example.aksisapp.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface MessageRepo extends CrudRepository<Message, Long> {

}
