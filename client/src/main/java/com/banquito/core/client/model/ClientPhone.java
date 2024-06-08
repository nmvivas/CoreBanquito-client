package com.banquito.core.client.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "CLIENT_PHONE")
public class ClientPhone implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CLIENT_PHONE_ID", nullable = false)
    private Integer id;
    @Column(name = "CLIENT_ID", nullable = false)
    private Integer clientId;
    @Column(name = "PHONE_TYPE", length = 3, nullable = false)
    private String phoneType;
    @Column(name = "PHONE_NUMBER", length = 20, nullable = false)
    private String phoneNumber;
    @Column(name = "IS_DEFAULT", nullable = false)
    private Boolean isDefault;
    @Column(name = "STATE", length = 3, nullable = false)
    private String state;
    @ManyToOne
    @JoinColumn(name = "CLIENT_ID", referencedColumnName = "CLIENT_ID", insertable = false, updatable = false)
    private Client client;

    public ClientPhone(Integer id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        ClientPhone other = (ClientPhone) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }

}