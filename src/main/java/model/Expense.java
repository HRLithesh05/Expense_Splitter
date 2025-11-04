package model;

import java.sql.Timestamp;

public class Expense {
    private int expenseId;
    private String description;
    private double amount;
    private int paidBy;
    private Timestamp dateAdded;
    private String paidByName;
    private String memberName;

    public Expense() {
    }

    public Expense(int expenseId, String description, double amount, int paidBy, Timestamp dateAdded) {
        this.expenseId = expenseId;
        this.description = description;
        this.amount = amount;
        this.paidBy = paidBy;
        this.dateAdded = dateAdded;
    }

    public Expense(String description, double amount, int paidBy) {
        this.description = description;
        this.amount = amount;
        this.paidBy = paidBy;
    }

    public int getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(int expenseId) {
        this.expenseId = expenseId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getPaidBy() {
        return paidBy;
    }

    public void setPaidBy(int paidBy) {
        this.paidBy = paidBy;
    }

    public Timestamp getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Timestamp dateAdded) {
        this.dateAdded = dateAdded;
    }

    public String getPaidByName() {
        return paidByName;
    }

    public void setPaidByName(String paidByName) {
        this.paidByName = paidByName;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    
    public String getMember() {
        return memberName;
    }

    @Override
    public String toString() {
        return "Expense [expenseId=" + expenseId + ", description=" + description + ", amount=" + amount
                + ", paidBy=" + paidBy + ", dateAdded=" + dateAdded + "]";
    }
}
