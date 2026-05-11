package com.football.model;

import java.time.LocalDateTime;

public class Match {
    private int id;
    private int homeTeamId;
    private int awayTeamId;
    private LocalDateTime matchDate;
    private String stadium;
    private String tournament;
    private String status;

    private Team homeTeam;
    private Team awayTeam;

    public Match() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getHomeTeamId() { return homeTeamId; }
    public void setHomeTeamId(int homeTeamId) { this.homeTeamId = homeTeamId; }
    public int getAwayTeamId() { return awayTeamId; }
    public void setAwayTeamId(int awayTeamId) { this.awayTeamId = awayTeamId; }
    public LocalDateTime getMatchDate() { return matchDate; }
    public void setMatchDate(LocalDateTime matchDate) { this.matchDate = matchDate; }
    public String getStadium() { return stadium; }
    public void setStadium(String stadium) { this.stadium = stadium; }
    public String getTournament() { return tournament; }
    public void setTournament(String tournament) { this.tournament = tournament; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Team getHomeTeam() { return homeTeam; }
    public void setHomeTeam(Team homeTeam) { this.homeTeam = homeTeam; }
    public Team getAwayTeam() { return awayTeam; }
    public void setAwayTeam(Team awayTeam) { this.awayTeam = awayTeam; }
}
