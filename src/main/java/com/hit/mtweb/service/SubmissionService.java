package com.hit.mtweb.service;

import com.hit.mtweb.dao.*;
import com.hit.mtweb.domain.MTSystem;
import com.hit.mtweb.domain.Submission;
import com.hit.mtweb.domain.TestSet;
import com.hit.mtweb.utils.Threads.HandleSubmitThread;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class SubmissionService {

    @Autowired
    SubmissionDao submissionDao;

    @Autowired
    TestSetDao testSetDao;

    @Autowired
    LangDao langDao;

    @Autowired
    SystemDao systemDao;

    @Autowired
    TrackDao trackDao;

    public Submission handleSubmit(String setId, String sysId, String srcLang, String tgtLang, String notes, String filename, String track,String username,String path) {
        Submission submission = new Submission();
        MTSystem system = systemDao.queryById(sysId);
        TestSet testSet = testSetDao.querySetById(setId);

        submission.setSystemid(sysId);
        submission.setSystemName(system.getName());
        submission.setTestsetid(setId);
        submission.setTestset(testSet.getName());
        submission.setSubmitter(username);

        submission.setSrclang(langDao.queryFullByAbbr(srcLang));
        submission.setTgtlang(langDao.queryFullByAbbr(tgtLang));
        submission.setNotes(notes);
        //用户上传的结果
        submission.setFile(filename);
        submission.setTime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
        submission.setTrack(track);


        //翻译方向
        String direction = trackDao.getDirection(track);


        new HandleSubmitThread(submission,testSet,system,path,direction,submissionDao).start();

        //submission.setBLEU(computeBLEU(setId,srcLang,tgtLang,filename));
        //submission.setTER(computeTER(setId,srcLang,tgtLang,filename));
        //submission.setBEER(computeBEER(setId,srcLang,tgtLang,filename));

        //submission.setBLEU_SBP("110");

        //submission.setBLEU_SBP(computeBLEU_SBP(setId,srcLang,tgtLang,filename,path));

        //this.saveSubmission(submission);

        return submission;

    }

    private String computeBLEU_SBP(String setId, String srcLang, String tgtLang, String filename,String path) {

        System.out.println("setId:"+setId);
        System.out.println("srcLang:"+srcLang);
        System.out.println("tgtLang:"+tgtLang);
        System.out.println("filename:"+filename);
        System.out.println("path:"+path);
        System.out.println("RealPath:"+System.getProperty("rootPath"));

        /*try {
            String command = "python "+path+"eval\\test.py"+" "+path+"uploads\\"+filename;
            System.out.println(command);
            Process process = Runtime.getRuntime().exec(command);
            InputStream in = process.getInputStream();
            BufferedReader bf = new BufferedReader(new InputStreamReader(in));
            String line;
            while((line = bf.readLine())!=null) {
                System.out.println(line);
            }
            in.close();
            bf.close();
        } catch (IOException e) {
            e.printStackTrace();
        }*/


        return "100";
    }

    private void saveSubmission(Submission submission) {
        submissionDao.saveSubmission(submission);
    }

    //计算BEER，需执行本地python代码
    private String computeBEER(String setId, String srcLang, String tgtLang, String filename) {
        return "15";
    }

    //计算TER，需执行本地python代码
    private String computeTER(String setId, String srcLang, String tgtLang, String filename) {
        return "20";
    }

    //计算BLEU，需执行本地python代码
    private String computeBLEU(String setId, String srcLang, String tgtLang, String filename) {
        return "30";
    }

    public List<Submission> queryBySysId(String systemid) {
        return submissionDao.queryBySysId(systemid);
    }

    public List<Submission> queryByTrack(String track) {
        return submissionDao.queryByTrack(track);
    }

    public List<Submission> queryByOwnerNTrack(String username, String track) {
        return submissionDao.queryByOwnerNTrack(username,track);
    }

    public List<Submission> queryByTrackSortMetric(String track, String metric) {
        return submissionDao.queryByTrackSortMetric(track,metric);
    }
}
