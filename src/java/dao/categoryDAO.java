/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Category;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class categoryDAO {
    static Session session = null;
    
    public static List<Category> viewAll(){
        String hql = "from Category";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Category> category = query.list();
        session.close();
        return category;
    }
    
    public static Category viewSinglebyId(int id)
    {
        String hql = "from Category where categoryId='"+id+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Category> category = query.list();
        session.close();
        Category obj=null;
        if(!category.isEmpty())
            obj = category.get(0);
        return obj;
    }
}
