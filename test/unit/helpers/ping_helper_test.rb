require 'test_helper'
require 'action_view/test_case'
require 'tmail'
require 'net/pop'

class PingHelperTest < ActionView::TestCase
  FIFTYFIVE = 55 + 55.55/60
  TWENTYTWO = 22 + 22.22/60

  # Subject parsing tests
  test "north and west" do
    string = "55 55.55 N 22 22.22 W"
    lat, long = parse_lat_long(string)

    assert_equal(FIFTYFIVE, lat)
    assert_equal(-TWENTYTWO, long)
  end

  test "south and east" do
    string = "55 55.55 S 22.22 E"
    lat, long = parse_lat_long(string)

    assert_equal(-FIFTYFIVE, lat)
    assert_equal(TWENTYTWO, long)
  end

  test "padding " do
    string = " 55   55.55   S  22   22.22    E    "
    lat, long = parse_lat_long(string)

    assert_equal(-FIFTYFIVE, lat)
    assert_equal(TWENTYTWO, long)
  end

  test "no space" do
    string = "55 55.55S 22 22.22E"
    lat, long = parse_lat_long(string)

    assert_equal(-FIFTYFIVE, lat)
    assert_equal(TWENTYTWO, long)
  end

  test "no decimal" do
    string = "55 55 S 22 22 E"
    lat, long = parse_lat_long(string)

    assert_equal(-55.0 - 55.0/60.0, lat)
    assert_equal(22.0 + 22.0/60.0, long)
  end

  test "no long" do
    string = "22 E"
    lat, long = parse_lat_long(string)

    assert_nil(lat)
    assert_nil(long)
  end

  test "no lat" do
    string = "55 N"
    lat, long = parse_lat_long(string)

    assert_nil(lat)
    assert_nil(long)
  end

  # Message parsing tests
  test "basic message" do
    ping = parse_message mail_fixture(BASIC_MESSAGE)

    assert_equal 12.34, ping.latitude
    assert_equal 56.78, ping.longitude
    assert_equal "This is my simple message.", ping.message
  end
  
  test "real message" do
    ping = parse_message mail_fixture(REAL_MESSAGE)

    assert_equal 12.34, ping.latitude
    assert_equal 56.78, ping.longitude
    assert_equal "This is my message.", ping.message
  end

  #####################################
  # Mail test fixtures
  #####################################
  def mail_fixture(name)
    mail = Net::POPMail.new(nil, nil, nil, nil)
    mail.stubs(:pop).returns(name)
    return mail
  end

  BASIC_MESSAGE = <<MAIL
From: Chris Metcalf <chris@chrismetcalf.net>
Date: Thu, 3 Sep 2009 22:27:03 -0700
Subject: 12.34 N 56.78 W
To: me34tcalf@timmetcalf.net

This is my simple message.
MAIL

  REAL_MESSAGE = <<MAIL
Return-Path: <chrismetcalf@gmail.com>
X-Original-To: me34tcalf@timmetcalf.net
Delivered-To: x9681342@friskymail-mx2.g.dreamhost.com
Received: from mail-yx0-f186.google.com (mail-yx0-f186.google.com [209.85.210.186])
	by friskymail-mx2.g.dreamhost.com (Postfix) with ESMTP id 21C4C544BD
	for <me34tcalf@timmetcalf.net>; Thu,  3 Sep 2009 22:27:26 -0700 (PDT)
Received: by yxe16 with SMTP id 16so2096969yxe.4
        for <me34tcalf@timmetcalf.net>; Thu, 03 Sep 2009 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=NUHVGhW4r7hobH/rgBd+XI0SwUxuWIcEVgwMBFID3zo=;
        b=xqGpQTfPttvmhdPa+wOGr1uXHTFePy5ZYUJvcpUjh5kFZLOXwNeMnBXoCT6JMBZ8h1
         qahB/sI322DWZQzAMYb70slyyDzt5j62OPzHgmksv9MUN2WAJVLDBlpgVg5iyjYN5eDx
         3vmgCZzztr/9/SBppqacixGdYLsHSw2cqHzJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=ovPrha5T+BVCbHVwkc1UQJaG70fAA3/O5rqZ/S73AwxbL5P4hInykOxTUWnKSkxTME
         AO68zoLmI/NJ9fab3ahropJvsruXfJfE0lBJEfZlfKHJHvjIBQ8R0Wo1iBcYFr2K6D3h
         WTZBWDFJhEA66ZjvN3hk1/aAoqOSDmVGXx6WU=
MIME-Version: 1.0
Sender: chrismetcalf@gmail.com
Received: by 10.150.237.1 with SMTP id k1mr17749675ybh.69.1252042043094; Thu, 
	03 Sep 2009 22:27:23 -0700 (PDT)
From: Chris Metcalf <chris@chrismetcalf.net>
Date: Thu, 3 Sep 2009 22:27:03 -0700
X-Google-Sender-Auth: 8ee40855ae783867
Message-ID: <455596e0909032227n42d71a11i3573e77662d2afdc@mail.gmail.com>
Subject: 12.34 N 56.78 W
To: me34tcalf@timmetcalf.net
Content-Type: multipart/alternative; boundary=000e0cd2dc3238f7ae0472b9c172

--000e0cd2dc3238f7ae0472b9c172
Content-Type: text/plain; charset=ISO-8859-1

This is my message.

----

Chris Metcalf
chris@chrismetcalf.net
http://chrismetcalf.net
--------------------------------
Urgent Message?
http://awayfind.com/chrismetcalf

--000e0cd2dc3238f7ae0472b9c172
Content-Type: text/html; charset=ISO-8859-1

This is my message<br>
<br>
----<br>
<br>
<br clear="all">Chris Metcalf<br><a href="mailto:chris@chrismetcalf.net">chris@chrismetcalf.net</a><br><a href="http://chrismetcalf.net">http://chrismetcalf.net</a><br>-------------------------------- <br>Urgent Message?<br>

<a href="http://awayfind.com/chrismetcalf">http://awayfind.com/chrismetcalf</a><br>

--000e0cd2dc3238f7ae0472b9c172--
MAIL

end
