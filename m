Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C625423E98
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327393; cv=none; b=qGI33rK0iVT9OaoeOrEmaqKeAnneZO+2zWm7BwybEdTAA/aW5/vMlkLoIBRgsWD5B/g20zKr+LI8I6YX1zrY2fWj84vh8NIkP86q8MIsAbt4BP/yKMd5SvtVzBxZ7plhFn8MdYuSo8OWPZ6m4QPI12OlD+ODkPkkFW+d8bVAT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327393; c=relaxed/simple;
	bh=0E9m9yuxgNDTQrGD/DMWOOxTZX02GSh/wTsje1l9L8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbOY8w/KN5pqwwVFSqCzB4QegiUKTK2lu5PpomkcmqLYYWaJ7EOncBSKcAiBivFiGnrA5JAeFC3OPEGfmRIH59bZG23CM4lidmdHPyqQ1rSNfi3xBnr2JUlvHfNI6yU4MVNW5yIF1p4D1yMeUZZgk6/1R3pg1ZMIjOBrNzTW7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOeTysH3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOeTysH3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so867992f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327389; x=1785932189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vih9lgzt1GoIVRjPuBhz9EBsJwtySLMnDilyBJHjRH4=;
        b=UOeTysH3pMA/yCVrooWg7Y3wi1WK9UF1Ew9CiU510mbkQ5WgxUIIr3kWZhXQ/LJneO
         cNgLl+KoHtGRNIvmeLwjx1CHBbj15g0ZDkSqjFpCOCGGt3dJwKaVjndb7O5vcBZLBkvP
         1KRy1BMapo1ITxNuNar6XHWPSxORWhZPIHDbGVj3eWzI9OtZKDNkV11akJ1gIbm8CQ6W
         3Tcu7VzTzmPlyVr7L9esbmWC8BgbJ0iRlR8jM1NAUodDNMxJXfhrMaBmgrsDAnxEGrcO
         pdO224QCiKQC0NmUd7WnSWwx/jV9ICpp5dW1RhidDcfO2Ad30p9rFLSQcbIeE1vYL3/k
         KkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327389; x=1785932189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vih9lgzt1GoIVRjPuBhz9EBsJwtySLMnDilyBJHjRH4=;
        b=Bu2EXwWX+xlDzmoeaB2wzXyIx9SX4rRABKohpF3KPBx2Ai75imH4w372XbB0iD/BGf
         Nh/n7cQ5NYAsY9Cb072qbgkJ9HYlDyzQlLAG6TIMXtMoUzh1mqyKlM/94fZz7XMhNuOd
         7gWmDuWdsdexs4t1XBIGWqODDU1k0Fm4600TxjzDgP9ovzXeRWQlsYf76rW58Ll/1rd9
         pA1q8NkY/kaKFjkGlQqz2ILu9MR7BaycFe8MdkHhnrIkwoAzWs5VBnHj0nDhnE7Fuasd
         8yAbzh6Frruug8p8gF/TCOk4S17LYB/EwIXtTYPs07L4IjJc6LG0vl/H1tGjLXB0icaJ
         2emw==
X-Forwarded-Encrypted: i=1; AHgh+RogyVuTSsvVqPtMCKbpnYejwyjiYVOjMRppLB0Lk/ynsruA0JUwFdaodozX18sEBRNboy+ho0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6QMFrVeAqz/Tq+gd4atV8iJx9BgOckw8GfLZip26al6yuguF
	VNR0NKKqRsTowEIQ6svn5LUc6DHuPHubpmtJcueqpOyu4FvI7JBykv+gHLcCRlzA
X-Gm-Gg: AR+sD132T90WgSTdflTL7vsfaTSGdsT9C4A5ZCGZh+W3uO5x4u/1mJgZhpqBvm99K1e
	7lY3DAK5eMUyP2ss185IPAl+GEI8QG93j3aG+xidEA4IHv97ZMboy9dGgXZ2RuZq8/m59IwoB6w
	qAGlrjHxJEmzrc9rJ4buLUDMiMOdKqebKNseCrMFBFpBHJ1DJOijEMVH96QkeTrH1UE2UwwOE07
	CuKEZURTJsi/xL96Fz7PDDFql52fX7+qDQwUdT65+7k+46MZTd/SS96mu2qPpTVc93i2a17IDRW
	xAjKn0q9xYrTSwN13ePLQqoqB5SWY21ikE1yO8Hfrhay7+JTArpLXmXqRO/Vei6t+hPU0d7lVZ9
	8idVFNj4b7vZaErzGpSSiBMQikZWdIsfD7raALxaHcMkIk3iAMBTp+dcvVEr0yIRJgA6ooDjxHz
	GBHU8msu67HfP3RclOfby7NC8hhrysUNiNQjCscEKUI2Z3nSQvzNe63e2cfPHDVXyaaS8=
X-Received: by 2002:a05:6000:4304:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-47fb1edfe39mr7385595f8f.25.1785327389255;
        Wed, 29 Jul 2026 05:16:29 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef88sm8473995f8f.23.2026.07.29.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:16:28 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH 5.10] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
Date: Wed, 29 Jul 2026 15:16:02 +0300
Message-ID: <20260729121605.134642-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

commit 1579342d71133da7f00daa02c75cebec7372097b upstream.

bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(),
but tipc_disc_rcv() still dereferences b->disc in RX softirq under
rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).

L2 bearers are safe thanks to the synchronize_net() in
tipc_disable_l2_media(), but the UDP bearer defers that call to the
cleanup_bearer() workqueue, so the discoverer is freed with no grace
period:

 BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:149)
 Read of size 8 at addr ffff88802348b728 by task poc_tipc/184
 <IRQ>
  tipc_disc_rcv (net/tipc/discover.c:149)
  tipc_rcv (net/tipc/node.c:2126)
  tipc_udp_recv (net/tipc/udp_media.c:391)
  udp_rcv (net/ipv4/udp.c:2643)
  ip_local_deliver_finish (net/ipv4/ip_input.c:241)
 </IRQ>
 Freed by task 181:
  kfree (mm/slub.c:6565)
  bearer_disable (net/tipc/bearer.c:418)
  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)

The bearer is freed with kfree_rcu(); free the discoverer the same way.
Add an rcu_head to struct tipc_discoverer and free it and its skb from an
RCU callback.

Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
call_rcu() that is still pending when the tipc module is unloaded would
invoke a freed function. Add an rcu_barrier() to tipc_exit() after the
bearer subsystem has been torn down, so all pending discoverer callbacks
have run before the module text goes away.

Reachable from an unprivileged user namespace: the TIPCv2 genl family is
netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs CONFIG_TIPC
and CONFIG_TIPC_MEDIA_UDP.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20260617135744.3383175-3-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-64543
 net/tipc/core.c     |  5 +++++
 net/tipc/discover.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 7724499f516e..4f01691aea3a 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -220,6 +220,11 @@ static void __exit tipc_exit(void)
 	unregister_pernet_device(&tipc_net_ops);
 	tipc_unregister_sysctl();
 
+	/* TODO: Wait for all timers that called call_rcu() to finish before
+	 * calling rcu_barrier().
+	 */
+	rcu_barrier();
+
 	pr_info("Deactivated\n");
 }
 
diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 2730310249e3..28665de32245 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -58,6 +58,7 @@
  * @skb: request message to be (repeatedly) sent
  * @timer: timer governing period between requests
  * @timer_intv: current interval between requests (in ms)
+ * @rcu: RCU head for deferred freeing
  */
 struct tipc_discoverer {
 	u32 bearer_id;
@@ -69,6 +70,7 @@ struct tipc_discoverer {
 	struct sk_buff *skb;
 	struct timer_list timer;
 	unsigned long timer_intv;
+	struct rcu_head rcu;
 };
 
 /**
@@ -381,6 +383,15 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d = container_of(rp, struct tipc_discoverer,
+						 rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link duest structure
@@ -388,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
 	del_timer_sync(&d->timer);
-	kfree_skb(d->skb);
-	kfree(d);
+	call_rcu(&d->rcu, tipc_disc_free_rcu);
 }
 
 /**
-- 
2.43.0

