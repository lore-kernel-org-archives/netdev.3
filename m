Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287908;
	b=ZNlizNk1v2qk8LqxpzXK1d6NAvvtRsb/b76IX9qi+z6jpDhsso+pEDjU7peI58i+ENa8
	 0Ji/g23WrhLICXKd3EXJsm+pbmpiimWd11l/wlj2do50UOjrTsFau7GOaB361235/y6Qs
	 nNQUKSADoVTsmGpmu0Zptv3nr+rPfZQb9U7mGBr7Qk5SqsXD3lt98MhQejzbrY4G3I0Ps
	 sJnIQHvwAAzAD26bQLq7w6jJtjBrmE9bIAClfIeYuC/kzc/jdnVPXXTWUJt6J7/fTjLNv
	 BZa/Q3RwrGv7Y9npL3cY5kgBpb2zTjqO2cohZ6AyRDBvPyH3ZS3th5t5A0bC1gQkUhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287908;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=vEZnp/jEQWQVcQeMGZ2Twe6JvBpF/eyHesYEwXJ9/KM=;
	b=LzvHK+kXIlKshOHKf+TXKkYUIkavncW7vOo+2tksee+rkjr+2QllE1xqxtTtbdJL43+i
	 z8xOKo7MbwWnTFCk9C29jfv1qpGju4EUiYWRDnDweNYY9klqeO0kQkxA8INS5MFBknnKU
	 4G6OaOPvwl75RnUSksHY4c2p0arHv1FjT1liUjORcSV62QkAYwg5nDrtyVyKcJlm8L9Xh
	 hOYDdrr+ZgdvFcJQlUWtKsAYqGdw20SQZGFxoHmcOLV8ovJsRApCSmwa+YunzqFb44qv6
	 zHIv/TnJMnMn0DKi2QC/zpiFAhawe6IoZTHpcik9bwb4USK2aaeoSNhhrIUNNrBgxIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lp3UwwJZ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6826606A31A;
	Thu, 29 Oct 2026 15:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6826606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lp3UwwJZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1BE6AC49F4C;
	Thu, 29 Oct 2026 15:32:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4B2960360;
	Thu, 29 Oct 2026 15:31:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB0711032909B;
	Thu, 29 Oct 2026 16:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793287899; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vEZnp/jEQWQVcQeMGZ2Twe6JvBpF/eyHesYEwXJ9/KM=;
	b=lp3UwwJZS+d2OnBccHTO0d65Cqb1Ad1PNWi1yTbYJ2O8Qi0oI/5cK8VyB2eAkOGi1YpZUA
	IEs+7LIPnsDcZGGmMHttxWKCSM5IOiupl+GFeexU1QpFOqB/RqHdU6ek67sx0lm5CI5ea/
	fnNjF4hFYfK1IEE3wBV2oxC/gi7ZmPUR456qwX38VcDnomquHDJRc89+xo86snO6csUkaK
	36vgXTX+kWY/kX3yFgqNtRaS35KMGwnphzBQp6V7ZCmEmsCqfsakhsGIJbuws2zhrJkHVq
	Yvj27CqUVY/MZRdGRHQks4qsM65XCsWYQxp4dm2erOJUs2qQvFxhEpGSDFh+kQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v4] net: Use a dedicated flag to track disabled napi instances
Date: Thu, 29 Oct 2026 16:31:29 +0100
Message-ID: <20261029153130.121204-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
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
X-Last-TLS-Session-Version: TLSv1.3

Trying to disable the napi threaded state while the napi instance is
disabled will hang forever in napi_stop_kthread(), as it waits for
NAPIF_STATE_SCHED_THREADED to clear.

This won't happen until the next ____napi_schedule() call, which won't
happen as it's disabled.

This happens in 2 instances :

 - Drivers that create but don't use napi instances (stmmac's rxtx napi
   for AF_XDP for example), here it's a driver bug

 - Drivers that create their napi instances in .probe(). Here, setting
   threaded off while the interface is down will hang :

   ip link set eth0 down
   echo 1 > /sys/class/net/eth0/threaded
   echo 0 > /sys/class/net/eth0/threaded
   -> hang

Checking on netif_running() isn't enough, as napi instances may be
transiently disabled when changing the MTU for example, let's use a
dedicated flag to track if the instance is disabled.

This allows immediately disabling the kthread when the instance is
disabled.

This was tested on mvpp2 (probe-time napi_add) and stmmac.

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4:
 - Rebase on net, add Daniel's tested-by

V3:
https://lore.kernel.org/r/20261022075757.1164283-1-maxime.chevallier@bootlin.com
 - Use a new flag to keep track of the napi instance state, if it's
   disabled or not. It was tested on the same set of boards as before.

   I guess if this approach doesn't work either, we'll have to start
   fixing all the drivers :)

V2:
https://lore.kernel.org/r/20261006141119.85562-1-maxime.chevallier@bootlin.com
 - Different approach as per Jakub's review, just don't allow setting
   the napi threaded mode while interface is down. Uses the NAPI_STATE_NPSVC
   flag to check the napi state, but it wasn't enough.

V1:
https://lore.kernel.org/r/20260926194714.648819-1-maxime.chevallier@bootlin.com

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344..435be7880d7e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -440,6 +440,7 @@ enum {
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
 	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
 	NAPI_STATE_PERCPU,		/* NAPI handler is run per-CPU - incompatible with threaded mode */
+	NAPI_STATE_DISABLED,		/* NAPI is disabled */
 };
 
 enum {
@@ -456,6 +457,7 @@ enum {
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
 	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
 	NAPIF_STATE_PERCPU		= BIT(NAPI_STATE_PERCPU),
+	NAPIF_STATE_DISABLED		= BIT(NAPI_STATE_DISABLED),
 };
 
 enum gro_result {
diff --git a/net/core/dev.c b/net/core/dev.c
index 87a79d6004c8..fa767d417d09 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7381,6 +7381,13 @@ static void napi_stop_kthread(struct napi_struct *napi)
 {
 	unsigned long val, new;
 
+	/* Instance is disabled, we can immediately stop the kthread */
+	if (test_bit(NAPI_STATE_DISABLED, &napi->state)) {
+		clear_bit(NAPI_STATE_THREADED, &napi->state);
+		clear_bit(NAPI_STATE_THREADED_BUSY_POLL, &napi->state);
+		goto stop;
+	}
+
 	/* Wait until the napi STATE_THREADED is unset. */
 	while (true) {
 		val = READ_ONCE(napi->state);
@@ -7411,6 +7418,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
+stop:
 	kthread_stop(napi->thread);
 	napi->thread = NULL;
 }
@@ -7806,6 +7814,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLED, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7842,7 +7851,8 @@ void napi_disable_locked(struct napi_struct *n)
 			val = READ_ONCE(n->state);
 		}
 
-		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
+		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+		      NAPIF_STATE_DISABLED;
 		new &= ~(NAPIF_STATE_THREADED |
 			 NAPIF_STATE_THREADED_BUSY_POLL |
 			 NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7887,7 +7897,8 @@ void napi_enable_locked(struct napi_struct *n)
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
-		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
+		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+			      NAPIF_STATE_DISABLED);
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
-- 
2.56.0

