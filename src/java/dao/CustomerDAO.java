/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.sun.org.apache.bcel.internal.generic.RETURN;
import static dao.AccountDAO.session;
import entity.Customer;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class CustomerDAO {
    static Session session = null;
    
    public static int save(Customer bean)
        {   
            //bean.s
            session = HibernateUtil.getSessionFactory().openSession();
            Transaction t=session.beginTransaction();
            int i =(int) session.save(bean);
            t.commit();
            session.close();
           
            //return inserted;
            return i;
        }
    public static Customer viewById(int id){
        String hql = "from Customer where CId = "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Customer> products = query.list();
        session.close();
        Customer obj = null;
        if(!products.isEmpty()){
            obj = products.get(0);
        }
        return obj;
    }
    
    public static Customer viewByEmail(String email){
        String hql = "from Customer where email = '"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Customer> products = query.list();
        session.close();
        Customer obj = null;
        if(!products.isEmpty()){
            obj = products.get(0);
        }
        return obj;
    }
    
    public static int getId(String email){
        //String hql = "from Accounts where email='"+email+"'";
        String hql = "select CId from Customer where email ='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setMaxResults(1);
        List users = query.list();
        //users.get(0);
        int Id = (int) users.get(0);
        System.out.println(users.get(0));
        session.close();
        return Id;
    }
}
