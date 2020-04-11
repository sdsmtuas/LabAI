# This is just my take on getting and sending emails, I don't really expect it to be used, just getting experience

import smtplib
import os
from email.message import EmailMessage
import email
import imaplib
from bs4 import BeautifulSoup
import mimetypes

# os is for keeping email & pass secure


# the os.environ.get is used to keep the email and password secure from anyone who
#  views the project on github. To make this usable on your machine, go to the home
#  directory and in .profile add in 'export vladPass="###" and likewise for the email
EMAIL_ADDR = os.environ.get('vladEmail')
EMAIL_PASS = os.environ.get('vladPass')


def send_mail(to, subject, body):

    msg = EmailMessage()
    msg['Subject'] = subject
    msg['From'] = EMAIL_ADDR
    msg['To'] = ', '.join(to)
    msg.set_content(body)

    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:

        # pretty obvious what this does lol
        smtp.login(EMAIL_ADDR, EMAIL_PASS)

        smtp.send_message(msg) 


def get_mail():
    mail = imaplib.IMAP4_SSL('imap.gmail.com')
    mail.login(EMAIL_ADDR, EMAIL_PASS)
    mail.select("inbox")
    result, data = mail.uid('search', None, 'ALL')
    inbox_item_list = data[0].split()

    for item in inbox_item_list:
        result2, email_data = mail.uid('fetch', item, '(RFC822)')

        raw_email = email_data[0][1].decode('utf-8')

        email_message = email.message_from_string(raw_email)

        to_ = email_message['To']
        from_ = email_message['From']
        subject_ = email_message['Subject']
        date_ = email_message['date']
        counter = 1
        for part in email_message.walk():
            if part.get_content_type() == 'multipart':
                continue
            filename = part.get_filename()
            content_type = part.get_content_type()
            if not filename:
                ext = mimetypes.guess_extension(content_type)
                if not ext:
                    ext = '.bin'
                if 'text' in content_type:
                    ext = '.txt'
                elif 'html' in content_type:
                    ext = '.html'
                filename = 'msg-part-%08d%s' %(counter, ext)
            counter += 1

        #save file
        save_path = os.path.join(os.getcwd(), "emails", from_, subject_)
        if not os.path.exists(save_path):
            os.makedirs(save_path)
        with open(os.path.join(save_path, filename), 'wb') as fp:
            fp.write(part.get_payload(decode=True))


        '''print(subject_)
        if 'plain' in content_type:
            print(part.get_payload())
        elif 'html' in content_type:
            html_ = part.get_payload()
            soup = BeautifulSoup(html_, "html.parser")
            text = soup.get_text()
            print(text)
        else:
            print(content_type)'''

    # send_mail([EMAIL_ADDR, "Other emails"], "Subject line", "Body :)")
    # get_mail()