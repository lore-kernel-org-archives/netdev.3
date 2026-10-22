Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655890;
	b=GqRVXF8Z5yHAmOVgCvvzIZMY1/8avU6dRUvnzCpSKo1DD1CNP6fK4AyTKGYdvTLMHfkl
	 mfd0uHI8/6VcYqOYxDCj9auSxQvqvLt13zT4OyGoWG5h5hyAuRyCy84VnTDKS7899qq9Z
	 76wF1jAoECV3Ub+TvHpsCnzSnVgOXkoD7M8BBqhOwUbTKVFW0KYXrygojL+Ov9NlS4HKu
	 1tSSFkE06u8ymOQXWEjSgkg6p3O7Ca7ild+UEV08T7gFGkiivDZkCSiVyIuzrp2lhFsSl
	 sbEWj2jZ7PAT0Fjv4U2xqUmhjMrP30PPPA2LVRMgv5kZCIkC73BQUnM07BmQj5Y0gVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655890;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=UmN2s6tgOm0A9GoZQElNdrU9oC4VAYnyPyJsot4d7LQ=;
	b=Qcug8nHjkU9XpimRPVkAza9HxDXKQItuGFEF7TRMX/PkkFItQ+1V9KA2cVYiLyECNRjh
	 mk8uqHOuxxtt31tsWsTyDXt3ehNZ7gCKWN2BavxPIl93qqUTkfix4ObDRIEd/QT38c0q5
	 WwDzME2VWawIjOgih5fxMcFariMCFH47SThOAhVRItT46OTHAdjjNHonCQx1Dy0ymEw0f
	 tmufHPLQF4zdqYbSyK1YFNXIq870UNEIpzG+ibjyc7QvFgqPr6xQhrdcPZdQcCiMk9FWf
	 mRJzKU/bJgwrtT3hNmlRv7BEz0pjbzmudGWk+wc3u6dYREYcYOeyckSPIE2AeQ9OsuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xugHXf76;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F4606A319;
	Thu, 22 Oct 2026 07:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE0F4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xugHXf76
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26666C5846E;
	Thu, 22 Oct 2026 07:59:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4D2C60360;
	Thu, 22 Oct 2026 07:58:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C370A10328C52;
	Thu, 22 Oct 2026 09:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792655883; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=UmN2s6tgOm0A9GoZQElNdrU9oC4VAYnyPyJsot4d7LQ=;
	b=xugHXf76jZoypisO7ZkjxkEsPO4sC0PscGRj5Bv65MeP2LRwiSTTmsksoyKe2mUtnP2mmD
	QEa0e0wrjgZLAxCIk5hQ5MKwF6EIDUxeMmCnywPQkmUXXeXVKwxPPGAQwPVYRpordz/DOu
	m7PEx/tG+z0tTcDzH8XBzvdS6xIB8Nm/VtN7VJ/1wbNgPCFe9tGOANVvSsxuKFrfdkuxpf
	qsoUeyOjdvjB/Y4BT3Hle6fW+w95/sHQ9gGzGo7b0bmv1zQaBKAB27MQ593W2dJY3LwJhK
	qTKxNj7rg0e7c4AtZDDT1zYEiW6YeH+g12X0PsDMZXZg1YKh9gCPORlfANTxqA==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: Use a dedicated flag to track disabled napi instances
Date: Thu, 22 Oct 2026 09:57:57 +0200
Message-ID: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>
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
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3:
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
index ac257221c7c5..d410c7303d1a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -433,6 +433,7 @@ enum {
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
 	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
+	NAPI_STATE_DISABLED,		/* NAPI is disabled */
 };
 
 enum {
@@ -448,6 +449,7 @@ enum {
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
 	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_DISABLED		= BIT(NAPI_STATE_DISABLED),
 };
 
 enum gro_result {
diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..a6d66af8947a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7253,6 +7253,13 @@ static void napi_stop_kthread(struct napi_struct *napi)
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
@@ -7283,6 +7290,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
+stop:
 	kthread_stop(napi->thread);
 	napi->thread = NULL;
 }
@@ -7678,6 +7686,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLED, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7714,7 +7723,8 @@ void napi_disable_locked(struct napi_struct *n)
 			val = READ_ONCE(n->state);
 		}
 
-		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
+		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+		      NAPIF_STATE_DISABLED;
 		new &= ~(NAPIF_STATE_THREADED |
 			 NAPIF_STATE_THREADED_BUSY_POLL |
 			 NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7759,7 +7769,8 @@ void napi_enable_locked(struct napi_struct *n)
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

