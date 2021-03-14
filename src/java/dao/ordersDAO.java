/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Orders;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class ordersDAO {
    static Session session = null;
    
    public static Orders viewByOrderId(int id){
        String hql = "from Orders where OId= "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Orders> order = query.list();
        session.close();
        Orders obj = null;
        if(!order.isEmpty()){
            obj = order.get(0);
        }
        return obj;
    }
    
    public static int save(Orders bean){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t = session.beginTransaction();
        int i = (int) session.save(bean);
        t.commit();
        session.close();
        return i;
    }
    
    public static List<Orders> viewAll(){
        String hql = "from Orders where status!=2";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Orders> order = query.list();
        session.close();
        return order;
    }
    public static Boolean checkDB(int OId){
        String hql = "from Orders where OId="+OId+" and deliveryBoy.dbId IS NULL";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Orders> order = query.list();
        session.close();
        Boolean obj= false;
        if(!order.isEmpty())
            obj = true;
        //return obj;
        return obj;
    }
    public static Boolean checkDB(int OId, String email){
        String hql = "from Orders where OId="+OId+" and deliveryBoy.email ='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Orders> order = query.list();
        session.close();
        Boolean obj= false;
        if(!order.isEmpty())
            obj = true;
        //return obj;
        return obj;
    }
    
    public static int updateDB(int OId , int DBId){
        String hql = "UPDATE Orders set deliveryBoy.dbId='"+DBId+"' ,status=1 where OId="+OId;
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        int updatedEntities = session.createQuery(hql).executeUpdate();
        t.commit();
        session.close();
        return updatedEntities;
    }
    
}
