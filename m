Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715629;
	b=glWg+JRTxdBXAshxxCIYm0i4I8ONX4DbpYgoltMN8/V+Bumklrtz+2NbuqqB4Pv3+k+Z
	 +i5Q4JS9MspJ/1STULU5BR7291QHI4LIOHTf+iX17H7EapSG7bG0CHTGNQV2wDeU8DhAI
	 Ty8CBSUlSpYpiuLNXf5GyPNJiAXux+dvMYrzMXSpu8UEPwzTZ5q23691H31VGholPuAw4
	 18nTaOE2LskK+78yWmuahfXuVoF2gpyNOHoIFT6b4tTn+oGnFaXbeWRbhQD6j5jEPt4xF
	 cwyUqOym6xsa6m2nE8OYIOiSfmw7O8ADMfkX+fLCOWCe/XNWU0wIzzf0bMcOjbWKsCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LQSJ1MoRuywQlY0tB2jmAqJ+yOElpGeNOkB2OxmHhkg=;
	b=EoQlLC8tDX80K4d2PRuwPFmLP/pJVMQn5vCnk3iIVIdRsHtOnW80fR0mGz6+wBd+5U5+
	 mRnrHYWXX8kYi0QO0itWAf9UjqGzULJEBmMK6bk82T/7MdR0ZF6jJwBvp5QabEnJ0Gxxp
	 cJmjwl1cVqyGBNtZ8irRUvqn/wLpWorYQrgjL/nG08wmhAx8sz4dnGJZnU6jDC+MnqsOj
	 pGbd6gfDdD364m5A/l/0mBAXffRnueMLHkaR/6TOaYZdN2R1zSGv8ygGcgGz33r+BXaJK
	 RQmCDJyumIfeLNHPDxwkultbKy0AcY5HdwgclrKhZBIUsCGDXiSp8Ck1AX/l6CtGUvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJHoO2cX;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF982606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF982606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJHoO2cX
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a091e4eea2so442550b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715628; x=1794320428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQSJ1MoRuywQlY0tB2jmAqJ+yOElpGeNOkB2OxmHhkg=;
        b=XJHoO2cXhO8+zds3bQze/gISOa8oq6P2VrkKhTHJkrgcbr06eaEHVkD7NTZRQEq8MC
         KKv0HMe0qhz6MkQ8NGGc+COgp0kpSHedpB6MW5v2Z9i3we1EADMABfRQLBdzvo/7HENn
         +W6NqXKTulg07Wd/jdnIJZu+g72IFgbBF2A6KsmtTTc5v2XNnmQGrDj4QmfQ22mvWyhB
         Jt1CKx5/87kNCIEZgv2U/hp7QTZJKF78mY4zEYgov7HB7QQ1Q5cnNCo9j2mGUSj7+Eo9
         S40vXG3h7sFJRfF0FuVIy42gzUapNjwQFI9POwBEauQaotY9z6TjF3ICo1vLH29toTV0
         DQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715628; x=1794320428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQSJ1MoRuywQlY0tB2jmAqJ+yOElpGeNOkB2OxmHhkg=;
        b=L8j9Gj4PA+ttgejKF2UTR3DEsMTUYq48fH64pMGAGzFaFz7ROgUJBtKmTTG4wjfXqw
         TSGlchWj/DQOUvxbRE/li2vQjo6k5J6jclmKn9/LIZXXb4ZbF/qoMj2lqPX3p8KbL4iM
         7Iaq6FyVOdOpAdWN3DaJ0fZYvlSq3PiaCNmsgY7CEvkazs2zLWDOpuPbSBmMbq3fkrI+
         Mpi220T81ZenNRM1z8vr8hOao1ldxp+7z+2gmsoAHdKBmVx743gYwE2RQj+ALLxZSYXB
         4A+O/bo8H19cG0xLZSx+P0Ln4yOyE2J1TubPlF6CDh7ap1MR9/D+yN3vxmfiR5c92WAF
         cNUw==
X-Gm-Message-State: APuU4Z/Fz6B1yjXUm+XA89fFnrBVW2MD6y6EFSY9XNZJ3M/73qI4d4Do
	o+A4lQAE5fJ0lGCk6CUASbOY7fAXkXZibU2+Gn7J3z2H2py4HExu4OnDcN6I7k+8XvU=
X-Gm-Gg: AYBFou1fAkObOYroWhgHq5bv7VNlHmmPhHzyX1y2MmOppW8OBwUoE8+3ZVE4wMglqSN
	fvHXna+efnoM22b1mFyhamOCfthzXXOg5fGSistYodjuazkPzJcV+Xm9ZLG4FD7AHH3bQJOTVEO
	9RFyH2h3LhE1Zj5lpFRlWlkfU2EVzPsc50zHOTh0dCLs15TavxTgNeZGS5rKlBCDJ/9TfypOR5s
	8E4jmMeqQykw3jNX4zidOp+ZzE+rXwr3eJRB7AbdE84gVNj3pW1LHK0ep4996qN3VauMTdquiBp
	arwk29VDp2hmLRnq4RgrnFAttRoO8yXHI/IjL+X1d3hiLUEelEWRZgZmYV6XY0YKpUDN/LvEf2b
	m3AZa9L2/NJC8Dz39y5h5iWpoz3xUqYcA2bgoWjpHWSX+NyvYe7yD1hDM3DYWL5hDVaPrVLx/8l
	RK5h/D/z1KcVxqZPqgYB2rs0qIyIP8oz5ow2cKnh3m2ZWxde0+Lu2xFegjNCtsKfW1b03Fr/rPL
	Vgldx4xdzDqnjJsQLrJCk9eVUkQGnNIHFefUfFMx6WCuzHG/0O7C7FDW5pgG1nTUCDo20e8YuDF
	Am026koclx5uAl6gQiLa8gb23SgVwUPNHTdA9uvwUprXAU3HXMlruRIUwlpZQhdu
X-Received: by 2002:a17:90b:53c4:b0:3ac:9e5e:d1a5 with SMTP id 98e67ed59e1d1-3ae8988339dmr20233260a91.6.1793715627896;
        Tue, 03 Nov 2026 06:20:27 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm4536310a91.11.2026.11.03.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:20:27 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	horms@kernel.org,
	khc@pm.waw.pl,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH net-next v3 1/2] hdlc_cisco: shut down the keepalive timer on ->detach
Date: Tue,  3 Nov 2026 22:20:14 +0800
Message-Id: <20261103142015.1588144-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103142015.1588144-1-lui2012qwq@gmail.com>
References: <20261103142015.1588144-1-lui2012qwq@gmail.com>
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

cisco_start() arms st->timer unconditionally and cisco_timer() re-arms
itself on every fire.  The only deletion lives in cisco_stop(), which is
unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  The
cisco hdlc_proto has no ->detach at all, so unregistering an up cisco
device leaves the keepalive timer armed on top of freed memory; it fires
within one keepalive interval and cisco_timer() writes through the dead
cisco_state (st->lock, st->txseq++, cisco_keepalive_send()).

Add a ->detach callback that shuts the timer down permanently before the
state is freed, mirroring the CVE-2026-63803 ppp fix
(timer_shutdown_sync() in ppp_timer_release()).

Initialize the timer in cisco_ioctl() when the protocol is attached and
drop the timer_setup() from cisco_start(), so the timer is initialized
exactly once at attach time: attach_hdlc_protocol() uses kmalloc() (not
kzalloc), so st->timer is uninitialized garbage until the first
timer_setup() and ->detach() must never run timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free write in __run_timer_base() within one
keepalive interval after rmmod of an up cisco HDLC device (allocated by
attach_hdlc_protocol() via cisco_ioctl(), freed by
detach_hdlc_protocol() via unregister_hdlc_device()).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: retarget to net-next and drop Cc: stable per maintainer guidance;
    no code change.  v1: https://lore.kernel.org/netdev/
 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index bfc978b15b..2173d5c6d6 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -274,7 +274,6 @@ static void cisco_start(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 
 	st->dev = dev;
-	timer_setup(&st->timer, cisco_timer, 0);
 	st->timer.expires = jiffies + HZ; /* First poll after 1 s */
 	add_timer(&st->timer);
 }
@@ -293,9 +292,17 @@ static void cisco_stop(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 }
 
+static void cisco_detach(struct net_device *dev)
+{
+	struct cisco_state *st = state(dev_to_hdlc(dev));
+
+	timer_shutdown_sync(&st->timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= cisco_start,
 	.stop		= cisco_stop,
+	.detach		= cisco_detach,
 	.type_trans	= cisco_type_trans,
 	.ioctl		= cisco_ioctl,
 	.netif_rx	= cisco_rx,
@@ -353,6 +360,7 @@ static int cisco_ioctl(struct net_device *dev, struct if_settings *ifs)
 
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		spin_lock_init(&state(hdlc)->lock);
+		timer_setup(&state(hdlc)->timer, cisco_timer, 0);
 		dev->header_ops = &cisco_header_ops;
 		dev->hard_header_len = sizeof(struct hdlc_header);
 		dev->type = ARPHRD_CISCO;
-- 
2.25.1

