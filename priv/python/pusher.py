import os
import urbanairship as ua

from erlport import Atom

print "Preparing... "
print "key: ", os.environ['URBAN_KEY']
print "secret: ", os.environ['URBAN_SECRET']

airship = ua.Airship(os.environ['URBAN_KEY'],
                     os.environ['URBAN_SECRET'])


def push(email):
    print "Email: ", email
    #global airship
    #push = airship.create_push()
    #push.audience = ua.or_(ua.device_token('some_token1'),
    #                       ua.device_token('some_token2'))
    #push.notification = ua.notification(alert='Test')
    #push.device_types = ua.device_types('ios', 'android')
    #push.send()
    return Atom("ok")

print "GO!"
