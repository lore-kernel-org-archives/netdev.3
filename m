Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E219DF62
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327397; cv=none; b=GEKaGuPGOxiH10+Xb/Jgark9hIhYxiVmgg4HRVjRooA6u7a3s2NY+TbBNXIvy/5ogOXqltEml28xilZMSOCG6q6UtHvrpFvo5m/HMBF5YMZddei9Fifk7NM7tdoc0GmeZ9zj3i1yTRG44R8x3nmEIw54IhxDG5gq0ld7l8j21+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327397; c=relaxed/simple;
	bh=Tbh1UE9kpkjffP3nlKfn8rHcwQE5VDDLBDJVZgKYfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTBRk0biD/X2qNJELtJ3cXlM1JEp0JmisMZQRdtPdHUW6YryaAggHEAfMAVLf1mlTnDhwe69CXEpWlRaOOU2o47rp/lntLEwjV69QCAc7TyD7Ac+A2vL7BFkANo+Uy22UWvtu5hFVWi5QiFtymZuugIGhXe4LWtPAn8wfjsVxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ql/CDb5r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql/CDb5r"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso816925f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327394; x=1785932194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwlQi6SKyzVRglpz9ib9XFTpx6TzI5gjwlAfPCOGYx4=;
        b=ql/CDb5rnbq4vDdqU+KyJEhnQP6ynFHuZ4kdY/FeA8E/jfLSQ6od5LVCUibJQrd1t0
         v/0FiGJqIAWeSybHGWrO2iFxU/Xd1LvGADYWoFIJ+R54Re3H46b2HclsTZkAiooruca9
         V+l7/WfxkxZCx9N+i/RuS1u8VgTsDfia0CvFlS2vZK0mhzqYlWP8gY5aIrnBW/527nuf
         LUKZ8EE8PEUuoeAqKCC64Ze8kJrxA56ZDVGXZ8nHsEsYz/G5Hk/w1TSjKT+ilUiiQryr
         jz99eGlf8rm5ZFhvqwXMQO2ZcPCBln+WowHKIlNUj93rrBtiReBMDLAh5Pg2l3QFFUns
         fJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327394; x=1785932194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwlQi6SKyzVRglpz9ib9XFTpx6TzI5gjwlAfPCOGYx4=;
        b=W/CVTV8tO/5BTN2gPhD2Z659aiv2/QPsYc4c+wD7qpBayrsgb++7DIT5ioC09G1GJk
         eAIOTIAgVkU28OqTwXLGRfPWYyfaCWg2UcC9X22zrfgWh/mFd3LjcR/0Oqde35gullj0
         gdAZoPwD1Q4g2bDGTe84CZTpNdAmyDVts62kC8XhA4z7RDHeemoTo65oUK3QpGvY8+no
         PKS7S8mHWazF7zrbtgtbSE1tTY9A/pbIjnOLzzH0HWwBdnsFnuqa7cr19zFpXGCrfo/V
         W1lUJYvgB/2o9MRKRiM5c5yna8zsQKHjMo8Zz4cBuXdUFP8ZM4RjysTRxidqdAwd3YLe
         m2RQ==
X-Forwarded-Encrypted: i=1; AHgh+RryK9q4YacebKk5sOLe4jvk7sscUs/bFx+ZIi8kcInYbYcmToSMEKNHbb+Ofpldr2pVRLpXRu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfJdoCbOHBLYzosrtEtkxAJvm440A1naulCmGSVDg6J0RoqHJ
	hd4gIMJs0qiY4RjqKGAXkO90KHOX23AoF/SaxmGbUI2X1AtR9U6wOE6J
X-Gm-Gg: AR+sD12UCrLPKQr6t+aesPEkE4icx8gOxfK879fXxyfP8piuxzVjEimgM4uGilU4iNw
	x8K8Rc5n3USP8YFBZEjaHC4WXnOzcbGwu7qCGyRCzPkoOlzXOr7ioeBvztpBGELOx/m4lapnXSD
	Y6ofr9/HqTdynZU/Vqh50CCnFaBOmPmOgecQTs73MUjgC8qSiQ1guA3K2k6JZL2WpBScfvPl8pM
	UzZCHKzvNgremsfuUkA0fN49vhXpLhTGAGs1Lq9bgW1zJAjYqtCZ1lSB4Rv/WMpbUkBgDIei82e
	fXYx0Gtn7gkQZzygeWQjODYOpfm8iTdsth2zlQw2KNxO91lykV5Y6bMoIJbFe6pG+5gtqi6OFVL
	6RSEj88om+R2AiH29JAVd8cEF48FU0UZkWQjno0XLgex2/ilrJ5GchV+tY1Qq/peq9FZEJ/qzOt
	PtJX9L6Yoii2Lg6DnnX4rG8KqIx0ROOJYo+h3jHbL9yPm/JuDDfkn8GGoFlEXn/yC9pBE=
X-Received: by 2002:a05:6000:200e:b0:47f:5a97:2a63 with SMTP id ffacd0b85a97d-47fb1e60052mr7064198f8f.9.1785327393913;
        Wed, 29 Jul 2026 05:16:33 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef88sm8473995f8f.23.2026.07.29.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:16:33 -0700 (PDT)
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
Subject: [PATCH 5.15/6.1] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
Date: Wed, 29 Jul 2026 15:16:03 +0300
Message-ID: <20260729121605.134642-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729121605.134642-1-alexevgmart@gmail.com>
References: <20260729121605.134642-1-alexevgmart@gmail.com>
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
index 434e70eabe08..1ddecea1df6e 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -218,6 +218,11 @@ static void __exit tipc_exit(void)
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
index e8dcdf267c0c..835ff27f8ea8 100644
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
@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
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
  * @d: ptr to link dest structure
@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
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

