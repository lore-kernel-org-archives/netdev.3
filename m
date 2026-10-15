Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35F499F18
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102019; cv=none; b=uCLPSJL9UuSoa4HExf4thhNuKWM3NJY5TjACR6G+8gz9wyomRs8xzx5ZFLT51Xoooe83bH4iNKE++TqPdSbNHNLYpvMrnAyoAlYxddOm9IH8pyQfJcCTr63Tq5ZZhAZKWJ/2jnWllncXQaTJX6i00Uzaizn+w/ogbhsOS1Bk2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102019; c=relaxed/simple;
	bh=ev7fPl2EVHaOZsJPfCWER6Z9/En4vBWS4kjYIJhVCNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILzpCT3qkxIe2J74N1s5j77ByPEuao8gmQL2OgdyDFr2Ganh0oLLqsMQalrHyfSed55F3GA7SLxyIZbiPjB1j/yQCWw9//M1zMzfPUXHJdY8/ifYyfLLEDc5kmfQIHR08qgk5PIM5RmfmdhTM58LjzWdTpDEbrReGoRuiGW4Q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=oXB2OzGH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="oXB2OzGH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4016150eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792102016; x=1792706816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bTl2y4vrdTPshV1sUZLr3PhNtc+TOPlEOlG+ICoNjbo=;
        b=oXB2OzGHMbw3BkltapdXh0ucD9G+JCE+t/sQEDV9NKWD42RmGJRICBvDwfybrp0jjV
         Ny/7nbs7ESxuDAF5iQb8CWe1pww+MLXkpnfN9mKUKrJIL7t8gn9LnAQuvfEAtP9CBndD
         NMbGRzEPUbVY17mwe0VSoApUZd7+xCgukfOW/0k/k2yUfReB3J0MAAlsEA4nEdoVLsAg
         GQsXlG6zoWIgZTatt36GkRvI63HDx+wtGMDFyUXh+Tza5iWMlbcdsiiCt3mqBbSnr4pq
         nyXuVq3MrKz72FfOEvm+Tgd+oacT5zmJ3wr3UbqFVJVxNL42ukZAaRiffXG46ZZqxIDW
         wL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102016; x=1792706816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bTl2y4vrdTPshV1sUZLr3PhNtc+TOPlEOlG+ICoNjbo=;
        b=duw2AWi6sGJbr9Eqg6vn8qHfmTkEt+qp0W5a7YSn2eNFQNPMhb5AITNk6/+JsVDz4z
         Nl0TDopIDOf9ObQDWdbc2nRap2hBdr/ZfNsyO9LF2rcDhHsj1zKWra5QGuZHOQDN+nMa
         ti5WLCtYTQm/QN3O0lVc1rH3HZbFWegb+CKR18QRWJ3EQOqY+kpReohphhGchOozflyF
         jfPkLxU+CQViNdRdIbcrImYfMBWUg3Sh/aUyBnRpbuPoVIEF5siCC4TEK3WzIpWj+0Tx
         wgSdNq7/KBQ3ygCYMdulijrAWMADTDqVhZXppkawo+L4AzX7e/DCgfq7sqo7aV+nyCd6
         ap2w==
X-Gm-Message-State: AFq9FYITFATbyR1J2ZS6NuxnZhg9TLYw4FlV2iFWaKrCTYl40AWvrpqk
	b6YADd9qa/NsZHUrhnSdKH8+i5MDy29MYOD84Sg5Z2HzQsB2ZGpnO2kQQPdviS2NGfc=
X-Gm-Gg: AYBFou0a/gU7b9qM17nhjjL7Ee2pE01cOuw0Ks70+ddzMtrqwkJ/2s65te2Qorc2pVv
	ctZg2HW/s7z/qklRsjfjLolHihiJgRZM+81VeHlcpFyMkYsREI+YDQ34jTFC2ovbi6miOS725ua
	HELAALdoL1MWdi9jT2XwZUr3rybIb6M9pVSV8O/XBcZyfdU8jYiPluKd3fjgREA1R/DDapXFm0Y
	DrTbHcpVYBBasju8Itg8nBk4p/4RE00PgPfqdOtEv8nu0ilLmqvwiaM/qrBDuUNspPahSCo9tNd
	YB1jVnEIdFKSgsS6xZ4RDwK7gDMX7K8Ts8Fc1x+RTl7oUp/yNqUENfLhkWZ0x8eItNvS05SYNKk
	cwnOz5908qxgvKwdT5b171MtWmTHqjuGaJr3OcNQx7NVrbOL5uOmJkBvWSx/sfccOgJgMdP746V
	cg3SdrNcXUK4xS/YrtgAn7A1f85m04xdB5Y7stXvEe/cBYjljNByrtIcwjxUnrl8HWNuLN0436S
	Vc52YOxNnUQdkGevujRtfUYggCPH+fkwwMMSUD5Ag==
X-Received: by 2002:a05:7300:cc93:b0:360:9a25:88cc with SMTP id 5a478bee46e88-3609a2588f6mr220595eec.11.1792102015577;
        Thu, 15 Oct 2026 15:06:55 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm1016445eec.3.2026.10.15.15.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:06:52 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 1/5] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Thu, 15 Oct 2026 22:06:44 +0000
Message-ID: <20261015220648.1545576-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015220648.1545576-1-omar@blockcast.net>
References: <20261015220648.1545576-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_update_handler() refreshes a relay tunnel's garbage-collection timer
with mod_delayed_work(&tunnel->gc_wq, ...) on a tunnel found by a lockless
list_for_each_entry_rcu() walk, holding only rcu_read_lock().  Nothing
serialises this against amt_tunnel_expire(), which runs from that same
gc_wq: once expire has taken amt->lock, done list_del_rcu() and queued
kfree_rcu(), a concurrent Update that already cached the tunnel pointer
re-arms gc_wq on an object that is about to be freed.  After the grace
period the delayed_work timer is left armed in freed memory, so it fires
into a use-after-free (and double-list_del_rcu/nr_tunnels underflow on the
way).

Make amt_tunnel_expire() the only context that frees a tunnel on the
timeout path and let it re-arm itself: the Update path only stamps
tunnel->last_seen, and expire re-reads last_seen under amt->lock to decide
whether to re-arm or free.  The Update path therefore never touches gc_wq,
so it can no longer re-queue the work of a tunnel being torn down.

amt_dev_stop() is the other freer, and it walked tunnel_list without
amt->lock while a running gc_wq could free the next entry under it.  Mark
every tunnel dead under amt->lock first, so a gc_wq that is already
running sees ->dead and bails instead of freeing in parallel; then unlink
the tunnels one at a time with list_del_rcu() under amt->lock, and cancel,
clear and free each one outside it.  The tunnel is freed exactly once, and
because readers walk tunnel_list locklessly under RCU, the entries are
unlinked in place rather than spliced onto a local list head.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b53f8ec..b06916c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -215,9 +215,14 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
 
 static void amt_destroy_source(struct amt_source_node *snode)
 {
-	struct amt_group_node *gnode = snode->gnode;
+	struct amt_group_node *gnode;
 	struct amt_tunnel_list *tunnel;
 
+	if (READ_ONCE(snode->dead))
+		return;
+	WRITE_ONCE(snode->dead, true);
+	gnode = snode->gnode;
+
 	tunnel = gnode->tunnel_list;
 
 	if (!gnode->v6) {
@@ -249,6 +254,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	struct hlist_node *t;
 	int i;
 
+	if (READ_ONCE(gnode->dead))
+		return;
+	WRITE_ONCE(gnode->dead, true);
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
 	hlist_del_rcu(&gnode->node);
@@ -282,13 +290,20 @@ static void amt_source_work(struct work_struct *work)
 	struct amt_source_node *snode = container_of(to_delayed_work(work),
 						     struct amt_source_node,
 						     source_timer);
-	struct amt_group_node *gnode = snode->gnode;
-	struct amt_dev *amt = gnode->amt;
+	struct amt_group_node *gnode;
+	struct amt_dev *amt;
 	struct amt_tunnel_list *tunnel;
 
-	tunnel = gnode->tunnel_list;
-	spin_lock_bh(&tunnel->lock);
 	rcu_read_lock();
+	gnode = READ_ONCE(snode->gnode);
+	amt = READ_ONCE(gnode->amt);
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(snode->dead) || READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		return;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -299,8 +314,8 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
@@ -403,26 +418,35 @@ static void amt_group_work(struct work_struct *work)
 	struct amt_group_node *gnode = container_of(to_delayed_work(work),
 						    struct amt_group_node,
 						    group_timer);
-	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
-	struct amt_dev *amt = gnode->amt;
+	struct amt_tunnel_list *tunnel;
+	struct amt_dev *amt;
 	struct amt_source_node *snode;
 	bool delete_group = true;
 	struct hlist_node *t;
 	int i, buckets;
 
+	rcu_read_lock();
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	amt = READ_ONCE(gnode->amt);
 	buckets = amt->hash_buckets;
 
 	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		dev_put(amt->dev);
+		return;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		/* Not Used */
 		spin_unlock_bh(&tunnel->lock);
-		goto out;
+		rcu_read_unlock();
+		dev_put(amt->dev);
+		return;
 	}
 
-	rcu_read_lock();
-	for (i = 0; i < buckets; i++) {
-		hlist_for_each_entry_safe(snode, t,
-					  &gnode->sources[i], node) {
+	for (i = 0; i < buckets; i++)
+		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node) {
 			if (!delayed_work_pending(&snode->source_timer) ||
 			    snode->status == AMT_SOURCE_STATUS_D_FWD) {
 				amt_destroy_source(snode);
@@ -431,14 +455,12 @@ static void amt_group_work(struct work_struct *work)
 				snode->status = AMT_SOURCE_STATUS_FWD;
 			}
 		}
-	}
 	if (delete_group)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
-out:
+	rcu_read_unlock();
 	dev_put(amt->dev);
 }
 
@@ -1328,8 +1350,30 @@ static void amt_tunnel_expire(struct work_struct *work)
 						      struct amt_tunnel_list,
 						      gc_wq);
 	struct amt_dev *amt = tunnel->amt;
+	unsigned long deadline;
 
 	spin_lock_bh(&amt->lock);
+	/* amt_dev_stop() has taken ownership of the teardown. */
+	if (READ_ONCE(tunnel->dead)) {
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	/* A Membership Update may have refreshed the tunnel after this work
+	 * was queued.  Re-arm from last_seen rather than letting
+	 * amt_update_handler() re-arm gc_wq: this handler is then the only
+	 * context that frees the tunnel on the timeout path; amt_dev_stop()
+	 * still owns teardown during device shutdown.
+	 */
+	deadline = READ_ONCE(tunnel->last_seen) +
+		   msecs_to_jiffies(amt_gmi(amt)) * 3;
+	if (time_before(jiffies, deadline)) {
+		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	spin_lock_bh(&tunnel->lock);
+	WRITE_ONCE(tunnel->dead, true);
+	spin_unlock_bh(&tunnel->lock);
 	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
@@ -2494,9 +2538,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (tunnel->ip4 == saddr) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
-				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-						 msecs_to_jiffies(amt_gmi(amt))
-								  * 3);
+				/* Refresh liveness only.  gc_wq is
+				 * re-armed by amt_tunnel_expire() itself
+				 * from last_seen, never from here, so this
+				 * cannot re-queue the work of a tunnel
+				 * that is being freed.
+				 */
+				WRITE_ONCE(tunnel->last_seen, jiffies);
 				goto report;
 			} else {
 				netdev_dbg(amt->dev, "Invalid MAC\n");
@@ -2732,6 +2780,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&tunnel->groups[i]);
 
+	tunnel->last_seen = jiffies;
 	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
 
 	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
@@ -2739,7 +2788,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
 	amt->nr_tunnels++;
 	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+			 msecs_to_jiffies(amt_gmi(amt)) * 3);
 	spin_unlock_bh(&amt->lock);
 
 send:
@@ -3050,7 +3099,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3079,9 +3128,34 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 
-	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
-		list_del_rcu(&tunnel->list);
-		amt->nr_tunnels--;
+	/* Mark every tunnel dead first, so a concurrent amt_tunnel_expire()
+	 * sees ->dead and bails instead of freeing a tunnel in parallel; this
+	 * path is then the sole freer.
+	 */
+	spin_lock_bh(&amt->lock);
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		spin_lock_bh(&tunnel->lock);
+		WRITE_ONCE(tunnel->dead, true);
+		spin_unlock_bh(&tunnel->lock);
+	}
+	spin_unlock_bh(&amt->lock);
+
+	/* Unlink one tunnel at a time with list_del_rcu() rather than splicing
+	 * the list onto a local head: a lockless reader walking tunnel_list
+	 * must always terminate at &amt->tunnel_list, never at a stack head.
+	 */
+	for (;;) {
+		spin_lock_bh(&amt->lock);
+		tunnel = list_first_entry_or_null(&amt->tunnel_list,
+						  struct amt_tunnel_list, list);
+		if (tunnel) {
+			list_del_rcu(&tunnel->list);
+			amt->nr_tunnels--;
+		}
+		spin_unlock_bh(&amt->lock);
+		if (!tunnel)
+			break;
+
 		cancel_delayed_work_sync(&tunnel->gc_wq);
 		amt_clear_groups(tunnel);
 		kfree_rcu(tunnel, rcu);
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde..ffe231b 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -240,6 +240,16 @@ struct amt_tunnel_list {
 	u32			nr_sources;
 	enum amt_status		status;
 	struct delayed_work	gc_wq;
+	/* Last time this tunnel was refreshed.  gc_wq
+	 * re-arms itself from this rather than being re-armed by the Update
+	 * path, so the Update path cannot re-queue the work of a tunnel that
+	 * amt_tunnel_expire() is freeing.
+	 */
+	unsigned long		last_seen;
+	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
+	 * tunnel first; the other then leaves it alone, so it is freed once.
+	 */
+	bool			dead;
 	__be16			source_port;
 	__be32			ip4;
 	__be32			nonce;
@@ -282,6 +292,8 @@ struct amt_source_node {
 #define AMT_SOURCE_OLD	0
 #define AMT_SOURCE_NEW	1
 	u8			flags;
+	/* Protected by gnode->tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 };
 
@@ -296,6 +308,8 @@ struct amt_group_node {
 	struct amt_tunnel_list	*tunnel_list;
 	struct hlist_node	node;
 	struct delayed_work     group_timer;
+	/* Protected by tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 	struct hlist_head	sources[];
 };
-- 
2.43.0

