/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Accounts;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class AccountDAO {
    static Session session = null;
    
    public static Boolean ValidUser(String email, String password){
        String hql = "from Accounts where email='"+email+"' AND password = '"+password+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Accounts> users = query.list();
        session.close();
        Boolean obj= false;
        if(!users.isEmpty())
            obj = true;
        return obj;

    }
    
    public static String getRole(String email){
        //String hql = "from Accounts where email='"+email+"'";
        String hql = "select role from Accounts where email ='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setMaxResults(1);
        List users = query.list();
        //users.get(0);
        String ROLE = (String) users.get(0);
        System.out.println(users.get(0));
        session.close();
        return ROLE;
    }
    
    public static int save(Accounts bean)
        {   
            //bean.s
            session = HibernateUtil.getSessionFactory().openSession();
            Transaction t=session.beginTransaction();
            int i = (int) session.save(bean);
            t.commit();
            session.close();
           
            return i;
        }
    public static String getPassword(int id){
        //String hql = "from Accounts where email='"+email+"'";
        String hql = "select password from Accounts where acccountId ='"+id+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setMaxResults(1);
        List users = query.list();
        //users.get(0);
        String password = (String) users.get(0);
        System.out.println(users.get(0));
        session.close();
        return password;
    }
    
    public static void update(Accounts bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.update(bean);
        t.commit();
        session.close();
        //return 1;
    }
    
    public static Accounts viewByEmail(String email){
        String hql = "from Accounts where email = '"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Accounts> products = query.list();
        session.close();
        Accounts obj = null;
        if(!products.isEmpty()){
            obj = products.get(0);
        }
        return obj;
    }
    public static List<Accounts> viewAll(){
        String hql = "from Accounts";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Accounts> accounts = query.list();
        session.close();
        return accounts;
    }
}
