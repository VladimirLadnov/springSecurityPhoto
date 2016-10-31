package com.vel.springsecurityapp.controller;

import com.vel.springsecurityapp.model.User;
import com.vel.springsecurityapp.service.SecurityService;
import com.vel.springsecurityapp.service.UserService;
import com.vel.springsecurityapp.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 *
 * @author Wladimir
 * @version 1.0
 */

@Controller
public class UserController {


    private Map<Long, byte[]> photos = new HashMap<Long, byte[]>();


    @RequestMapping(value = "/view", method = RequestMethod.POST)
    public ResponseEntity<byte[]> onView(@RequestParam("photo_id") long id) {
        return photoById(id);
    }


    @RequestMapping("/view_all")
    public String viewAll(Model model) {
        Set<Long> id_set = photos.keySet();
        model.addAttribute("id_set", id_set);
        return "view_all";
    }


    @RequestMapping(value = "/add_photo", method = RequestMethod.POST)
    public String onAddPhoto(Model model, @RequestParam("photo") MultipartFile[] photosArr) {
        System.out.println(photosArr);
        System.out.println(photosArr.length);
        Set<Long> id_set = new HashSet<>();
        boolean addPhoto = false;
        for (MultipartFile photo : photosArr) {
            try {
                long id = System.currentTimeMillis();
                byte[] photoArr = photo.getBytes();
                if(photoArr.length==0){
                    break;
                }
                id_set.add(id);
                System.out.println(id);
                photos.put(id, photoArr);
                addPhoto = true;
            } catch (IOException e) {
                throw new PhotoErrorException();
            }
        }
        if (!addPhoto) {
            throw new PhotoErrorException();
        }
        model.addAttribute("id_set", id_set);
        return "view_all";
    }


    @RequestMapping("/delete/{photo_id}")
    public String onDelete(@PathVariable("photo_id") long id) {
        if (photos.remove(id) == null)
            throw new PhotoNotFoundException();
        else
            return "welcome";
    }


    @RequestMapping("/delete_or_load")
    public String onDeleteAll(Model model,
                              HttpServletResponse response,
                              @RequestParam(value = "photos_id", required = false) long[] photosId,
                              @RequestParam(value = "removeOrLoad") String removeOrLoad) {
        if (photosId != null) {
            if(removeOrLoad.equals("Remove selected")) {
                for (long id : photosId) {
                    photos.remove(id);
                }
            }
            else{
                try {
                    byte[] photo = null;
                    String name = "";
                    if(photosId.length > 1){
                        ByteArrayOutputStream byteOs = new ByteArrayOutputStream();
                        ZipOutputStream zipOs = new ZipOutputStream(byteOs);
                        for (long id : photosId) {
                            byte[] ph = photos.get(id);
                            ZipEntry zipEntry = new ZipEntry(id+".jpeg");
                            zipOs.putNextEntry(zipEntry);
                            zipOs.write(ph, 0, ph.length);
                            zipOs.closeEntry();
                        }
                        zipOs.close();
                        photo = byteOs.toByteArray();
                        byteOs.close();
                        name = "photos.zip";
                        response.setContentType("application/zip");
                    }
                    else {
                        long id = photosId[0];
                        name = id +".jpeg";
                        photo = photos.get(id);
                        response.setContentType("image/jpeg");
                    }
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
                    InputStream is = new ByteArrayInputStream(photo);
                    OutputStream os = response.getOutputStream();
                    byte[] buffer = new byte[1024];
                    int read;
                    while ((read = is.read(buffer)) != -1) {
                        os.write(buffer, 0, read);
                    }
                    os.flush();
                    os.close();
                    is.close();
                }
                catch (IOException e){
                    throw new PhotoNotFoundException();
                }
            }
        }
        return viewAll(model);
    }


    @RequestMapping("/photo/{photo_id}")
    public ResponseEntity<byte[]> onPhoto(@PathVariable("photo_id") long id) {
        return photoById(id);
    }


    private ResponseEntity<byte[]> photoById(long id) {
        byte[] bytes = photos.get(id);
        if (bytes == null)
            throw new PhotoNotFoundException();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);


        return new ResponseEntity<byte[]>(bytes, headers, HttpStatus.OK);
    }

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getConfirmPassword());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null) {
            model.addAttribute("error", "Username or password is incorrect.");
        }

        if (logout != null) {
            model.addAttribute("message", "Logged out successfully.");
        }

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(Model model) {
        return "admin";
    }
}
