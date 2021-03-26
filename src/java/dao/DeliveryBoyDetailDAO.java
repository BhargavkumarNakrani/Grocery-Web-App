/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.DeliveryBoyDetail;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class DeliveryBoyDetailDAO {
    static Session session = null;
    
    public static List<DeliveryBoyDetail> viewAll(){
        String hql = "from DeliveryBoyDetail";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<DeliveryBoyDetail> dbDetail = query.list(); 
        session.close();
        return dbDetail;
    }
    
    public static void insert(DeliveryBoyDetail bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.save(bean);
        t.commit();
        session.close();
    }
    
    public static long viewOrderTaken(int Id){
        String hql = "select SUM(ordersTaken) from DeliveryBoyDetail where deliveryBoy.dbId="+Id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = 0;
        try {
            i = (long) query.uniqueResult();
        } catch(Exception ex){
            
        }
        session.close();
        return i>0 ? i : 0;
    }
}
