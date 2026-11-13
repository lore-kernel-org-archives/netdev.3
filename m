Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600095;
	b=EIRkc3JyyKQioiFmvDDM1wSBD9AT7uXZ+Oj+gslfAmTVbJL3nKtGBVnI4Oq/WCfIIj+c
	 bE9EyaPQVwDR39pQyGeQz8O5+zgIhzsV9B/GrdJ0kLdYyh/S61WB9De4Uu4meZpyCcAPe
	 5DUY8BTP2dpFgeq0ESZiby2HcMstYP41frtNbxNB/2JlZV7utlU+bVe+mkEkcMNgv898Y
	 eXTNn8Ql4ZuqaRIpsQwccoDuXjvQq23DOCuH4ew0oYn/qQnpSs/Rp2akIgMk6KjzxdTyS
	 18zVSIElNjwFUWNwqwAZeVDVolFy8jKiK7ZYGvP5DdgSWEtrak8hhnnkrIaAcTLILWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
	b=W+g5AaUa4JsX9ihtr6sjWrzxqovMyTtiWklR3kV7gCF+vWcoK9rgRrFFO++vj5gaUE6G
	 +R5h6qHsVTseob5on1tTbR21SzsFc8yoTGjJNmm0gH0OgmPz6oF2t1rO40LYiP9tPHGix
	 VXK5xzS0Xgptx72k8g8X+Be/ke3smh3yZ7WtquxD349eaOZaynvvs/jr65uPic/vGZ1Sx
	 gKnZxJg+O6BkjIDUxB82DZMa2FxMjvxgzQMcX/pRnvEMxe9C6NBioh/mOnKv9F+xrwuF3
	 jo5pM6V7okGIFsQ1uaHVo2NmGh96TzEC2EnUSTRPeLE+Nfn5Eo1dH157qpCjppSXFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="Ii/Q4AtR";
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13074606A880
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13074606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ii/Q4AtR
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702fd86d674so1732290eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794600094; x=1795204894; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
        b=Ii/Q4AtR+Ka3hto0ms2y390aqMzxmLu8CN8YPpbROMpPT+7mBlffjgccAy64QexD1m
         /wWxNx6PzyyD5aohb8jfcva8gy9MyZXidbtNC1cwD6YAZVGUoTZZQ5FnfaJU7nGRVbJH
         5mQuFodpF8yl+6lV00hZvs4Mei6pwi08rBiYYW0TMaR4Ei+hXMM4a5jzlVMh3zVhSu9N
         +vu2lQb6Qt2o8BF28jOcaBSPdR2OAtepAjhGIwpWdWGMrAThWgFkzHRp7WM1ecEj9EXg
         5Z1YsiPTERo1fqy8klWRT941zWFNbUa/4sbuz90bdILGzYqVlGsnaTwCB95v5Ok593YO
         xKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600094; x=1795204894;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EC9RASKFPMm8luP0GQ/7tSz6vapPp12uuDlPtIQw68s=;
        b=oHBvQcALhkRXQYMIn9/ELVZl2jTSR7TnWZ6XXkJjr0zN4E5XwbVS3no5RCSQchOYSP
         uDzpSNZtjQE9cDS6l4vZUoJ57U6UL1BlDAB9wyWrSw9ltBBsLR9odaSE5MPjqn5zIQ/h
         2zXYsXreeCVubUd1cAI5jIU9uE74Bt1uMbwompLhsh36qvYu0Q50op9dEZOX10GgIGJb
         kj0VciCc9QLMyGpGUDq32aUzjSuYb6uEIc2rZTfHEh230wporOXaKjt541zU83bV+3VJ
         eOL6PCOz6jnhNDRG8fazs5QE1O+Y4qUBRx9kDFEmVzifKUl3HCR2s+urdEXGErEduZHh
         oHhg==
X-Gm-Message-State: APuU4Z+AT0+BZL+1H7f/rXrq3/WfnM3UgIhh46dR10KJ08I5NZzx3Ahc
	ggusobNerkDIiIwEutEo858aaRdR20IoCCVef2xSNMjUkpWtNcyaxH8G6L6ToJg5XL0=
X-Gm-Gg: AYBFou10kw463r1Y81a05NFa7g3tvYAnignhPXExpDkaWJK0rM1BAZPvO4MohOdzkd+
	tpMsG8U4oCcHfock9UJvm/WAwACGwDirLcix+hdrbxg0Ucc+mmwKL9R9xMDLsPNEYIBQo0YKzqO
	NwKix/DqHGv4+Tyh+1pv2YeG902D7IwPIJNiAogHikMNXG95hH1npFDQITmYPfdFP/ZSDqYqCbC
	hMBfUc5uK1OFxDXnABG9xIpDkyiCI+Kpe5qEWBgX97ZsEeCEXpIV0vQqBYuu+RrTIMJhCYR12ZK
	LDxeMIPrSNKMibVYfLIjB4U2C70f17ImIpTDAxcgeBZFm6s8nRUy3kelGdS6FwTR/Jj16Hixt0x
	pIASHC/12/2RrTkH9BfpKEU+J+9nYKJVjocOqNEQLH0eCTLVT5JRIQoN9wGx3TFACeznA3WjmOV
	bvM0rjzJjE0OjbWIm2R+81Ey08JjwdR5OVeO7BoJ0LAohKL7NUPNIdYl8ChaZsLnCzXk9+2WqAm
	VgUzWh0rMUwaULxwMGyK4ApDJEsA8NMvDhp+QtUvYSO4oiUfBsAGFVNnXscKGyYeqbJTDJMDsqd
	O12kcrb+7qw8HihjtbIDEdgU7fNAnSxNajS8HAs=
X-Received: by 2002:a05:6820:1355:b0:716:d710:3d6b with SMTP id 006d021491bc7-71ab5083d31mr2286905eaf.49.1794600093872;
        Fri, 13 Nov 2026 12:01:33 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac6:bf21:1923::281:18])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab428b337sm2590808eaf.4.2026.11.13.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:01:32 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
Date: Fri, 13 Nov 2026 14:01:23 -0600
Subject: [PATCH 7.3.y] net: Use a dedicated flag to track disabled napi
 instances
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-napi-disabled-backport-7-3-v1-1-99560caf8bca@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAwA0atUXuMqbgpFXKVikY8BA0qjuCBQ1
 bsTYDmzeAsoF2GFQ7NA4aeoTKkGbRoIF5fOjBJrQ2e6HRFZTC4LRlHn7xzRu3DLU5lxQItmS73
 ZO2Ni76ECufBJXj98hKG17RuO/60Pf+Uwf2FY1w89Vmd0hQAAAA==
X-Change-ID: 20261113-napi-disabled-backport-7-3-051408a00d4b
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1794600090; l=5274;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=Jv9QV00aR+M1g59jP00fdAw8leVncE+PrUsMH8483fU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHlTpd5TAUpqR3hrf1Ua/ezmcrYrnH8wNvJmqTGKyAi2ptxR/RiI41qfut245SFSLyRaNhYhLWH
 B/NoHh+0KCgY=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit 8dc87fc5d6a0eb337744737008177342a708bf36
("net: Use a dedicated flag to track disabled napi instances") upstream.

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

[ Backport: place the disabled state after the threaded busy-poll state;
  the adjacent per-CPU NAPI state is not present in 7.3.y. ]

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20261029153130.121204-1-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
Backport upstream commit 8dc87fc5d6a0 ("net: Use a dedicated flag to
track disabled napi instances") to 7.3.y.

The commit fixes a reproducible hang in napi_stop_kthread() when
threaded NAPI is turned off while the NAPI instance is disabled. The
sysfs writer holds the netdev instance lock while waiting, which can
also block device recovery.

The upstream patch does not apply cleanly because the adjacent per-CPU
NAPI state is not present in 7.3.y. Place the new disabled state after
the threaded busy-poll state; the functional changes are unchanged.
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3e64af0b932d..02119fa153c9 100644
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
index cc7b32ab5608..0e0a11ba2ada 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7264,6 +7264,13 @@ static void napi_stop_kthread(struct napi_struct *napi)
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
@@ -7294,6 +7301,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
+stop:
 	kthread_stop(napi->thread);
 	napi->thread = NULL;
 }
@@ -7689,6 +7697,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	set_bit(NAPI_STATE_DISABLED, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
@@ -7725,7 +7734,8 @@ void napi_disable_locked(struct napi_struct *n)
 			val = READ_ONCE(n->state);
 		}
 
-		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
+		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+		      NAPIF_STATE_DISABLED;
 		new &= ~(NAPIF_STATE_THREADED |
 			 NAPIF_STATE_THREADED_BUSY_POLL |
 			 NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7770,7 +7780,8 @@ void napi_enable_locked(struct napi_struct *n)
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
-		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
+		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC |
+			      NAPIF_STATE_DISABLED);
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));

---
base-commit: 7595a62d45ee1a2297eafa5f2ef5d0a45142d84d
change-id: 20261113-napi-disabled-backport-7-3-051408a00d4b

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

