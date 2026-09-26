Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E836B93F
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452046; cv=none; b=OjfxNOJGt3jZNrer0X0o5n752YFpyVU463kxvYoLSUOgqoaRDZmysf0CEEXSBz92N8Zz3jZzMmm+ijGLyViqtjB9GYU/knBkxcopE6tcVMXBIAttcvG9TTFsvZn+l5RmgRbUDr40YnB0tKXg6eWImA4t3kq6khxF30v3rFcWupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452046; c=relaxed/simple;
	bh=9Ei0p+nKx4vnn2o6W8x4l0G+Hc2kLsrm3GR4Jh+Lyvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOFu6Mt2XZ7Kl/LMFeqvvhTr7W/IwVTZQHz4EkV3WHGfSIfrvWpv89CIxdrij7UOJtUNzEGXu22fxIkxbdk+qUarvPK1/D8XiqAaS3jaYuewtN962wHuKM5+TLgyJteV3RqjMjXgpo7busUz3ix18mFty/Z9oN6HRIbxdE0K9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bfaNHZDF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bfaNHZDF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0EB811A0FB2;
	Sat, 26 Sep 2026 19:47:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C66FC60749;
	Sat, 26 Sep 2026 19:47:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5594D102F1E4C;
	Sat, 26 Sep 2026 21:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790452038; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NRKEYWP3qLY2tzN5RMOtvo4PCJDQVM6G+I/NcSBHzTY=;
	b=bfaNHZDFhxH/4D2eGOPs+iwf7U92cLl138cdTxljTCJ7v1HP6rnzxLv9UWxOPNuhg/dxkd
	XwC0usMle3e+IEncdKECFwkz2Im5zLoqjmyfTslj7wWWTcqbLs7YZR4OtvleGOxl+ivqcR
	YgLYScXZuz+/CgA6ESCxmBTLO7r/s1gEM+K6BpNXykfEvmgnK1IRqspPP6KdimISdApAvC
	z2qpSrVcM/O1Jqt1AfGyTnWJhZAYFa71VSvtSAs5w2iLDZHiGplglIZYk2xBvh8rjGN3rd
	qR47dNlcEnajfcRmyY5b0LuielRkns/FV7ku3fxKf0WwVt2AabUvTD6Pw++yZw==
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
Subject: [PATCH net] net: keep the NAPI_DISABLE flag while napi is disabled
Date: Sat, 26 Sep 2026 21:47:13 +0200
Message-ID: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While running the napi_threaded kselftest on a variety of embedded
devices, it was found that the ksft hangs on stmmac boards. This seems
to be because stmmac creates multiple napi instances, some of them are
used exclusively for XDP (the rxtx napi).

When setting napi threaded on and off again on a disabled napi
instance, we enter an infinite loop in napi_stop_kthread() :

while(true) {
	[...]
	if (val & NAPIF_STATE_SCHED_THREADED) || ...) {
		...
	} else {
		msleep(20);
	}
}

The thing is the _STATE_SCHED_THREADED flag seems to only be set during
____napi_schedule().

So, on an unused napi loop the flag is never set, we hang in that loop.

This seems to be more general than stmmac though, there are lots of
drivers that create the napi instances in .probe(), so they still live
outside of .open()/.close(). It was verified by running the following on
an mvneta board :

  ip link set eth0 down
  echo 1 > /sys/class/net/eth0/threaded
  echo 0 > /sys/class/net/eth0/threaded
  -> hang

The proposed approach here is to extend the NAPI_DISABLE flag so that
it stays set while the napi instance isn't enabled, and use that flag
when stopping the napi kthread.

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..5ec2ac54524f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -423,7 +423,7 @@ struct napi_struct {
 enum {
 	NAPI_STATE_SCHED,		/* Poll is scheduled */
 	NAPI_STATE_MISSED,		/* reschedule a napi */
-	NAPI_STATE_DISABLE,		/* Disable pending */
+	NAPI_STATE_DISABLE,		/* Disable pending or already disabled */
 	NAPI_STATE_NPSVC,		/* Netpoll - don't dequeue from poll_list */
 	NAPI_STATE_LISTED,		/* NAPI added to system lists */
 	NAPI_STATE_NO_BUSY_POLL,	/* Do not add in napi_hash, no busy polling */
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..7f21d87a8c7a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7229,7 +7229,8 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		 * STATE_THREADED can be unset here.
 		 */
 		if ((val & NAPIF_STATE_SCHED_THREADED) ||
-		    !(val & NAPIF_STATE_SCHED)) {
+		    !(val & NAPIF_STATE_SCHED) ||
+		    (val & NAPIF_STATE_DISABLE)) {
 			new = val & (~(NAPIF_STATE_THREADED |
 				       NAPIF_STATE_THREADED_BUSY_POLL));
 		} else {
@@ -7646,6 +7647,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLE, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7694,8 +7696,6 @@ void napi_disable_locked(struct napi_struct *n)
 		napi_save_config(n);
 	else
 		napi_hash_del(n);
-
-	clear_bit(NAPI_STATE_DISABLE, &n->state);
 }
 EXPORT_SYMBOL(napi_disable_locked);
 
@@ -7727,7 +7727,8 @@ void napi_enable_locked(struct napi_struct *n)
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
-		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
+		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+			      NAPIF_STATE_DISABLE);
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
-- 
2.55.0

