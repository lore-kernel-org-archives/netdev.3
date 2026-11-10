Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285021;
	b=udvoqvqmeDXZbqTsLeySN9PuPu7iM6HAdBqyO0UdbTMP6iw5bc6e+4X7WxYIEoZFcXlQ
	 ObM1AXYj0tPXRAhLGl+K2ABvfSIJTCOw025rGCbMjdBKjD0LJKHO5NmCXXlN5AY9MN0DC
	 2VnzmCLyYPZeaxdg8nZzlk5M9w1h4PhKOuBmGzsFOXnNGKeqTYtwvf+h7ulrM80DPfpIH
	 oZoxn8sRpzNdCxADCvujUnoIE2FyJRXHgXfVfDV/iMq/aC2rv4BBLfM4Rr/y0RGUWBW0F
	 nb8CwH8HrvldaebALInJ/fecbc3euGkG6W4e7HKoo7jfCgjexnSAear2NU4Ev/WdezA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
	b=265jYhMx50jGAqb31Zdo5Z6Ciuhyy+yGVlr6dqaQkV7CvfyANiPjJS7c+HDuSw1D5l9C
	 yMNfUvjEgeH4CQnPdazxsUQLKxoe4e2n4YQt1Qr9VVzsMHZfnXWrzVXExEzVU8rzYQ0nM
	 gdemQSUYhzjjbkgDOSvmo6rERG0YYlhRTIRw6j1M6Y6VGC7Kf9VbfjJ5qI7UETvasDhCu
	 nkZyqxAJy3aXAkwhZZyCh8wNyG++wqcGqxSIcErmcFjE8Ug2cID3YnvNzKEwJV7vHh9iy
	 dSzjYeixCv1RY15FuBa8JYCFjoVlVgdDej+2DyciUCYAv1UFyiyICsFeQ0SJrIBws5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhLF37tq;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2774606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2774606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhLF37tq
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso20671626d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285020; x=1794889820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
        b=yhLF37tqJVy0RfoNOIf341vWvPM2VDB5/dEMhzJJI3vGi5Rv89+jEKjPQLGvAd9+EE
         B136HDRR2rEQSDkoJEXw3SjIp/h8jyoz7IFvxJ/N7oaaNQvJfagJt0d6CcURrIi/LlRZ
         ggYx0BKb8mxQ0nYbwkFgg9+sEBPGIt7Iy9c9Obg0g+ARQKLkJ0qiSHKMBiTJt3vDA0Ze
         b3vh6CD1rRKiF0Qx6tPeGkb1QYRW4fwGtemv/fN4QLEr+SBoI+1gGK6ihzmqSAw33wKk
         nzRkugrVd25XwNdm+pPLt7n60ejuUE924YhaGX1QAsI4vl4RZza8hQKR3UMfrV0h/uyl
         d/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285020; x=1794889820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
        b=L42lriNMXT3VjWGbXFFNRVdOLaTYznSoX+Sk8FrBwM0XY1iaMB9DME6CUB2vvYHaFH
         XOORnqc0nkc6GMVT8kRfYAWBjPhtp0WsV9w5pQupMTV2O80QPrERIU1gbor01UQjBCUm
         xW96F6yi4JbwS9RDapp2fHw5345TQy4+1haCgMc+XI07D5VDOA1rEuvYGauApulFVYuM
         xrosmkLAD7hhD0URaYwhorzs2L7FKoYtbXHJ7Nkob+bdkfju/MHQpqEm9VS/RlWtyWQt
         M/xRcnUgXlNxq+OwIzvBsW0vhITdwNivPtLlL5CEF3rZCNc2KtKv/nA6cqe2M6HzIFLQ
         sFJA==
X-Forwarded-Encrypted: i=1; AL+hErE4+NkumwfIsgym4SzphQ5ME8hsrCuSeG2ypotjb+JJav8g3YtXvdYju1ywmxgwge307geCHn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j3Ips3l80S+O5arZWp9ueW52LmksDsejQETJmdEXgZ95ZVWW5
	e5VzsdglTbHlx59kYdJfgPtyhFCoBvaujKkI2vobp+ew0ppAGRv6yV4=
X-Gm-Gg: AYBFou3EgIm5V1y5M0GWycgv1WAfodLWxEcBw8R2elwEKNcAyL9n7tfOXEYOOR6nn/h
	y2nZK1w6mLsul30u0uPzIB8Kyb2XqCy3ggyjdrbrBIGXAHkj1nzX0iIpufKg1BJflKmK4ZhRwDv
	1xUDsilmqPiamCOopX4daHxJiTAGf/7Ndu6vt4wpmEOKRbIKF6x6E87s/1M30Bt7Jqnl9eH9TSr
	jFq1pNVJhZBc9wwWdADWSLlNAAHZTpGB9o2i7Yhmiy94Dw+rmNikx5alu/Eh+me7C7GdrIASWGM
	GqSJzAl2FXOV/9z5RXBRa6so7hWPpO7OGUPrkKydcfQjHGnbY1UpThKm8pNS8UdP/+6lCck3O5h
	DuVcFKvCgYmZHwXK/f+ePl0JgOYr4XO5chFoTfOFlWnnX7B8sysAz8ZZGY1gs1b9Yx6dOmqAFgy
	bRU/9ahg5dwQWN+tDCei3OUP+3Hwa4ekoA+s3cEcxjXfMLbCP4hdXta7QAQFqqs8re11Du+IJUh
	CLcZ7cUhWJgJZTCgiP6usak4Z8csAeAt3LQjyIh3JoL8zJTMyUiwU2O6B9izKFLAOz/EWX5dqrP
	REx95M/YrlAdtnYjDQcKVmWQmdxFfKzIait1nthIEK6JbWtoyyqhVhVJmH/q8x1Wix8td/WUgMQ
	mEmezzuUM3D9IoHwiTkjKgIj/ApA9+tjyeSbtjV2e9LxciDVqud7RVZqJ69UYrDQe
X-Received: by 2002:a05:620a:2a08:b0:93e:c12c:9b6b with SMTP id af79cd13be357-9479f3e4359mr239464285a.70.1794285019816;
        Mon, 09 Nov 2026 20:30:19 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm136779285a.4.2026.11.09.20.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:19 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on disconnect
Date: Mon,  9 Nov 2026 23:30:16 -0500
Message-ID: <20261110043016.56986-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl8150_disconnect() kills the RX tasklet before killing the URBs.
Endpoint flushing does not wait for completion handlers: a
read_bulk_callback() that passed the unplug check can still schedule
the tasklet after the first kill. During driver unbind, disabled
endpoints make RX resubmissions fail, so rx_fixup() can keep
rescheduling itself and access freed driver data after free_netdev().

Kill the tasklet again after unlink_all_urbs() has waited for all
completion handlers. tasklet_kill() drains any late tasklet and prevents
self-rescheduling; disabled endpoints prevent it from leaving an RX
URB in flight. Keep the first kill to stop an existing reschedule loop
before unregister_netdev().

Found by a static analysis tool under development.

Fixes: eff674a514bd ("USB: rtl8150_disconnect() needs tasklet_kill()")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/net/usb/rtl8150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index d51e43170e03..98c36c377956 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -971,6 +971,8 @@ static void rtl8150_disconnect(struct usb_interface *intf)
 		tasklet_kill(&dev->tl);
 		unregister_netdev(dev->netdev);
 		unlink_all_urbs(dev);
+		/* A completion may have scheduled it after the first kill. */
+		tasklet_kill(&dev->tl);
 		free_all_urbs(dev);
 		free_skb_pool(dev);
 		dev_kfree_skb(dev->rx_skb);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

