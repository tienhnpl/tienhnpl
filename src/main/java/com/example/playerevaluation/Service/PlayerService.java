package com.example.playerevaluation.Service;

import com.example.playerevaluation.Models.Indexer;
import com.example.playerevaluation.Repository.PlayerRepository;

import java.util.List;

public class PlayerService {
    private final PlayerRepository repository = new PlayerRepository();

    public List<Object[]> getAllPlayers() throws Exception {
        return repository.findAllPlayers();
    }

    public List<Indexer> getAllIndexers() throws Exception {
        return repository.getAllIndexers();
    }

    public void addPlayer(String name, int age, int indexId, float value) throws Exception {
        Indexer indexer = repository.getIndexerById(indexId);
        if (value < indexer.getValueMin() || value > indexer.getValueMax()) {
            throw new IllegalArgumentException("Value out of range: " + indexer.getValueMin() + " - " + indexer.getValueMax());
        }
        repository.insertPlayer(name, age, indexId, value);
    }

    public void updatePlayerIndex(int id, float value, int indexId) throws Exception {
        Indexer indexer = repository.getIndexerById(indexId);
        if (value < indexer.getValueMin() || value > indexer.getValueMax()) {
            throw new IllegalArgumentException("Value out of range: " + indexer.getValueMin() + " - " + indexer.getValueMax());
        }
        repository.updatePlayerIndex(id, value);
    }

    public void deletePlayerIndex(int id) throws Exception {
        repository.deletePlayerIndex(id);
    }
}
