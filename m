Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24533939C;
	Tue,  6 Oct 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295900; cv=none; b=L9ypSKBVuZosAUy6w9hdd4mhgXJQn+767m1v37d60HlE/Tasxtyg5krUZbt+da3XxoyXuWbQnyjwJ02udwjamK4DeV9lePXOLgmZzmwLvK959ujALnTyUwsidsV8YmxHHf1Y+AXmpv7MDZ+e+3vOV8sUdZGS7aKrqs4y1rpEKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295900; c=relaxed/simple;
	bh=ROFYvkuwW07+yq8vCE0lVwJZstbLU/tF5UKPz+tIxeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WntHnU7z7XopDdtC4lX1EOwHXYx4SSa3m0vhs1gWhDd5eICjUjlSpKWEXuQ/0oAeH60zJ/Jn3PxWBsu/Di1oYVp32PLVyYCfjrARpqlpZVXmMpHqX+qEXfl9NijexRDnG2OjBZK35dFTJhXA4b5SB2w1Y2vwjDh+SUjPto6o8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TkecgpkP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TkecgpkP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EECD44E4115B;
	Tue,  6 Oct 2026 14:11:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C10D560553;
	Tue,  6 Oct 2026 14:11:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4609C1033047C;
	Tue,  6 Oct 2026 16:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791295891; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=p1MYdMRCfnV24LWWZd53dgkkASgGPs7NImyG0veQl1c=;
	b=TkecgpkP+pbT5w3pjBaTJRCBM3dRARMZZjSfzpbBaQZKLd0BUJWMWgFYu2UD/GY+X4g2db
	cGYSqs7pU5zfulC1xxj6t/aayJVhKL88Zhxh2Exo1iv2IjM2p94tFEEUJZsWFCplvGTHjd
	vjs704dCxQq0YbaUpwTKb/JqF2gz2MtlPWT20FVCrN1acVCZMUXugDBhFjqpQUqwmxBUcj
	e87co0notG+sW8tAn29zHpjgPNhEnMJcdLy6FnCro6C7KAdk2DnvUbXn6c/igEuFidPq9S
	5YJLroC3YSnWY0pvERKFKfJHRznZUHA8VJoXvoNa4CbOmEWm5y4rGG85/5Px9w==
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
Subject: [PATCH net v2] net: Don't allow disabling napi kthread mode while napi instances are disabled
Date: Tue,  6 Oct 2026 16:11:18 +0200
Message-ID: <20261006141119.85562-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
transiently disabled when changing the MTU for example, so let's check
the NAPIF_STATE_NPSVC flag instead, that's clear when the napi instance
is enabled.

This fix only addresses the second case. For the first case where
drivers have unused napi instances, the "threaded" mode can't be
switched off once enabled, these drivers will need fixing. As this
hasn't been seen before on said drivers, I guess it's OK as it used to
just freeze the system.

This was tested on mvpp2 (probe-time napi_add) and stmmac.

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2:
 - Different approach as per Jakub's review, just don't allow setting
   the napi threaded mode while interface is down.

   I'm unsure about the correctness of this, to me it seems that the
   NAPI_STATE_NPSVC flag indicates the condition we're interested in (is
   napi instance enabled or not ?), but I may be missing something
   obvious :(

V1:
https://lore.kernel.org/r/20260926194714.648819-1-maxime.chevallier@bootlin.com

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..fcf18c9eedb8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7315,6 +7315,12 @@ int netif_set_threaded(struct net_device *dev,
 				}
 			}
 		}
+	} else {
+		list_for_each_entry(napi, &dev->napi_list, dev_list) {
+			if (napi->thread &&
+			    test_bit(NAPI_STATE_NPSVC, &napi->state))
+				return -EBUSY;
+		}
 	}
 
 	WRITE_ONCE(dev->threaded, threaded);
-- 
2.55.0

