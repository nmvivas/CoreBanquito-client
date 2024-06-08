package com.banquito.core.bank.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.banquito.core.bank.model.Bank;
import com.banquito.core.bank.model.Role;
import com.banquito.core.bank.repository.BankRepository;
import com.banquito.core.bank.repository.ChannelRepository;
import com.banquito.core.bank.repository.RoleRepository;

@Service
public class CommonBankService {

    private final BankRepository bankRepository;
    private final RoleRepository roleRepository;
    private final ChannelRepository channelRepository;

    public CommonBankService(BankRepository bankRepository, RoleRepository roleRepository,
            ChannelRepository channelRepository) {
        this.bankRepository = bankRepository;
        this.roleRepository = roleRepository;
        this.channelRepository = channelRepository;
    }

    public Bank obtainBankDefault() {
        List<Bank> banks = this.bankRepository.findAll();
        if (!banks.isEmpty()) {
            return banks.getFirst();
        } else {
            throw new RuntimeException("No se encuentra ningun banco");
        }
    }

    public List<Role> obtainAllRoles() {
        return this.roleRepository.findAll();
    }

    public Role obtainRole(String id) {
        Optional<Role> roleOpt = this.roleRepository.findById(id);
        if (roleOpt.isPresent()) {
            return roleOpt.get();
        } else {
            throw new RuntimeException("No existe el role con id: "+id);
        }
    }
}
