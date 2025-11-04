package service;



import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.ExpenseDAO;
import dao.MemberDAO;
import model.Member;

public class BalanceCalculator {
    
    private MemberDAO memberDAO;
    private ExpenseDAO expenseDAO;
    
    public BalanceCalculator() {
        this.memberDAO = new MemberDAO();
        this.expenseDAO = new ExpenseDAO();
    }
    
    public Map<Integer, Double> calculateBalances() throws SQLException, ClassNotFoundException {
        List<Member> members = memberDAO.getAllMembers();
        Map<Integer, Double> balances = new HashMap<>();
        
        
        if (members.isEmpty()) {
            return balances;
        }
        
        double totalExpense = expenseDAO.getTotalExpenses();
        double perPersonShare = totalExpense / members.size();
        
        for (Member member : members) {
            int memberId = member.getMemberId();
            double paidSoFar = expenseDAO.getTotalPaidByMember(memberId);
            
            
            double balance = paidSoFar - perPersonShare;
            balances.put(memberId, balance);
        }
        
        return balances;
    }
    
    public List<Map<String, Object>> generateSettlementSummary() throws SQLException, ClassNotFoundException {
        Map<Integer, Double> balances = calculateBalances();
        List<Member> members = memberDAO.getAllMembers();
        List<Map<String, Object>> settlements = new ArrayList<>();
        
        Map<Integer, String> memberNames = new HashMap<>();
        for (Member member : members) {
            memberNames.put(member.getMemberId(), member.getName());
        }
        
        
        List<Map.Entry<Integer, Double>> debtors = new ArrayList<>();
        List<Map.Entry<Integer, Double>> creditors = new ArrayList<>();
        
        for (Map.Entry<Integer, Double> entry : balances.entrySet()) {
            if (entry.getValue() < 0) {
                debtors.add(entry);
            } else if (entry.getValue() > 0) {
                creditors.add(entry);
            }
        }
        
        debtors.sort((a, b) -> Double.compare(a.getValue(), b.getValue()));
        creditors.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));
        
        int debtorIdx = 0;
        int creditorIdx = 0;
        
        while (debtorIdx < debtors.size() && creditorIdx < creditors.size()) {
            Map.Entry<Integer, Double> debtor = debtors.get(debtorIdx);
            Map.Entry<Integer, Double> creditor = creditors.get(creditorIdx);
            
            double debtAmount = -debtor.getValue(); 
            double creditAmount = creditor.getValue();
            
            double paymentAmount = Math.min(debtAmount, creditAmount);
            
            if (paymentAmount > 0.01) { 
                Map<String, Object> settlement = new HashMap<>();
                settlement.put("fromName", memberNames.get(debtor.getKey()));
                settlement.put("toName", memberNames.get(creditor.getKey()));
                settlement.put("amount", Math.round(paymentAmount * 100.0) / 100.0); 
                settlements.add(settlement);
            }
            
            
            double newDebtorBalance = debtor.getValue() + paymentAmount;
            double newCreditorBalance = creditor.getValue() - paymentAmount;
            
            debtor.setValue(newDebtorBalance);
            creditor.setValue(newCreditorBalance);
            
            
            if (Math.abs(newDebtorBalance) < 0.01) {
                debtorIdx++;
            }
            
            if (Math.abs(newCreditorBalance) < 0.01) {
                creditorIdx++;
            }
        }
        
        return settlements;
    }
}