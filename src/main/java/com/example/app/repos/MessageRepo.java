package com.example.app.repos;

import com.example.app.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface MessageRepo extends CrudRepository<Message, Long> {

}
