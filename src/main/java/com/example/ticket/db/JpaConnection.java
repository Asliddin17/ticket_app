package com.example.ticket.db;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConnection {
    private JpaConnection(){}
    EntityManagerFactory entityManagerFactory;

    public EntityManager  entityManager(){
        if (entityManagerFactory ==null){
            entityManagerFactory = Persistence.createEntityManagerFactory("my_orm");
        }
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        return entityManager;
    }
    public static JpaConnection jpaConnection;
    public static JpaConnection getInstance(){
        if (jpaConnection == null){
            jpaConnection = new JpaConnection();
        }
        return jpaConnection;
    }
}
