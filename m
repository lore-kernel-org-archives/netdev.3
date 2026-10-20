Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455963;
	b=lsBZNq4xPiDcdYIk6FnYIkuRvloxUDmJRsGDzHzZn3FyywzBrF/Bw6SPc09sp9oWAATa
	 Xr6Y9M6hSV5Ch/4HdnISzMHKVQdXdzvZX3N/4xSueecw2R++x7m71FWHSUMS3RZINfXwp
	 9rLJixHhIutdAGZTC6fyAhHeoDS1W0zMpkoKqw0hkpkm6ZjMw4ygB2Lrp7p958p+BMhbB
	 RwtUHUWu8LpZylhtkyY44n2T8vsHAKDhlfHzAo01D3xFg2XNpc43e04C5ruGvQTkE2dUt
	 gKEQE7G/5bgzF7+Z3sy9rfkjFSD1kDRpPWLy/ESXk8eEzyDzydtwLVNmIsQ0ppGB5pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hWUr700lYgaUejwbaKh3NbdtT8h9phwNCHxKjI7qbxw=;
	b=eTDDG87cl/CIWiQRUd5iw+k2y7iHRHCqbtRhXPAsS5LPCRq2NfxVEuHhxA2FIcOcetBm
	 J0B+IjjIsxauqVrQhLVWfcCuEjRIIh2xBSps/HP9PSF8BehxARhKYGX02INY78SsIsdhH
	 OftBBNIK+M5Bv1vOxOlHe2nx0iRbnKcAr5iMzXd+IPv7mll51KdhXM1XukLMxumcMQP6T
	 waggofTgv/N9L4iEr+eS9ecaCjsrCSbdjXevYPQ+Sjw873CBuAsWDfC9WzOr0d4hkARC+
	 OTbX2qKMyfnhZb2m+pkjoH0FsWoxngr3rbtkLo3e8PqIq48ZWScArui57hkgtZFNzag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=FE44eoH1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EE606A321
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE2EE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=FE44eoH1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so3735181eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455962; x=1793060762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWUr700lYgaUejwbaKh3NbdtT8h9phwNCHxKjI7qbxw=;
        b=FE44eoH1G7akOZrrKwwrwc+Rb2lUdu7itRlGet/prfWLF3mbmJ0r2a/azPq0TKSi8o
         9M8tzVzKI90G5KIJCKNsigFrI3D0R4ylsIOBcLGMhba71dAfrci1HhzkEQdJtJIYHsPH
         roW7SP7JIGRtUIWIPmzaKjmBozE17KCTn6kpOMSjH8+FU+bZjFJjcJ/wiZzP7Tp29Cot
         lnn1IPum8tMvdRPwbur18mcTm6ZnWUatBQMgWP2fI1rX3ZwiMtIdC/c0QY/PAtyHmtMH
         Znp3eaxiBaCzK4m6y6qsdWMW3pg1xpHgFsWRi4Dcy8gISD3JKJ+mG8z4SImrx84UZsO7
         D9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455962; x=1793060762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hWUr700lYgaUejwbaKh3NbdtT8h9phwNCHxKjI7qbxw=;
        b=hIMQRGeV0b6smMxWspRRe3KrYJJ542YBk8dEz/JrorfUYZcTHoGz3wGtcpWX4VM1Yl
         ZlkdcGaC0YQuzyUnfeA8besw7ozMblcIqkmH1dR/8/7L1PFgrBZ8nJeOqpCHdLzCE03g
         5qxgUtUTsRKxcsK0x5+H9TUCGaSM4rI9ElzryCvLftqyM0c0PfdmqBBQlrblB1rcpQIy
         hcZ4O+UdRUNeUCLTMYJ4R5xmyf+8GaGEcAxZvCRX5LKpbBfpcwKHXswkwU0QG903wLaw
         t8sp2Pw1/RPAbj3vMiYpZx/W8PekNx++LOYAjj45ZemVdaFPy/Tn4TRHgGQ9MbXUKDco
         pToQ==
X-Gm-Message-State: AFq9FYIzYig5bD/a9qEnZhuU20StcerbdoLkNgzEH6gQc2ilLQFp90u0
	gMhRMpERsE+koDAWTrRhPeDM+9IvzSAPkTa9ogweQqTdMMeZBED3cFbwaYiOE5/R4rY=
X-Gm-Gg: AYBFou0/rcDD86sQdO9ojBSMp6asQd//dpb9Q/qC/D5flq2mTyNRL1waGOz2ZhVc1f7
	dwmf+J35dY3VvdFhMCwFZn7Rtk3vsXs3nXl1wVsov4jkIC1ECGtBkEfOB1z9UqSyN9mNzMSKNsV
	Wlf/DVIt5+XntXkbYHaIuba3G20Tt+VSEm9nH0RyaExznldIxjuZqgLLmii9zmyJRhMTUs1VAfg
	V/ZwIAREcTOdNNxq/okfS+uCx/y5Ufb/tDwyQXTebgAnp1NOfmUNXOOYj/4l5hMuoElSIx3Yu9z
	b5UuvEp5aLa00SVv/JLhKwFj6EhBa1NurVmwBmuOihr/35bR/FZfh4/GZXvE+rbdrFDvaOzWkYu
	SF5VciqO9+PFnwVzWdhQ1HBStY7Dn2qVh6el2l1vIdHtQHGnvtiT+xw8/BoJ6Clmr20JhF6x9e/
	8GWBoO40ksEj6cJFI35yPRGFhxKfuSiPGmSRQ0roCepxK1jksDq/sZr02KPjc4PZojDAVfM6Wr7
	hIueLSwGap0lOBL9y2bBNWQrMK2vIeqZwCJ6eT5wyqS0nVimtWPKwFzxA39c9jU
X-Received: by 2002:a05:7301:4296:b0:35d:bf7c:f77d with SMTP id 5a478bee46e88-361a254d54amr13878505eec.29.1792455961792;
        Mon, 19 Oct 2026 17:26:01 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:01 -0700 (PDT)
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
Date: Tue, 20 Oct 2026 00:25:53 +0000
Message-ID: <20261020002557.3984927-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

amt_update_handler() refreshes a relay tunnel's garbage-collection timer
with mod_delayed_work() on a tunnel found by an RCU walk. A concurrent
amt_tunnel_expire() can unlink and free that tunnel while the Update path
still has the cached pointer, leaving gc_wq armed in freed memory.

Make amt_tunnel_expire() the only timeout-path freer. The Update path
records last_seen, and expire rechecks it under amt->lock before either
rearming or freeing the tunnel. Protect the dead state with tunnel->lock so
report handling cannot add multicast state after teardown begins. Device
stop marks tunnels dead, unlinks them with list_del_rcu(), synchronously
cancels
their work, and frees them after lockless readers have passed.

Apply the same lifetime rules to group and source timer work: mark nodes
dead
under tunnel->lock, keep RCU held while workers resolve their owners, defer
node freeing, and synchronously cancel each timer before freeing its owner.
Drain that deferred work before freeing a tunnel, and release the group
timer's device reference on every exit. A Request-only tunnel retains the
original GMI timeout; only an authenticated Membership Update refreshes
last_seen and uses the longer lifetime.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
---
 drivers/net/amt.c | 210 +++++++++++++++++++++++++++++++++++++++-------
 include/net/amt.h |  16 ++++
 2 files changed, 196 insertions(+), 30 deletions(-)

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b53f8ec..478bd85 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -38,6 +38,10 @@ static HLIST_HEAD(source_gc_list);
 /* Lock for source_gc_list */
 static spinlock_t source_gc_lock;
 static struct delayed_work source_gc_wq;
+static HLIST_HEAD(group_gc_list);
+/* Lock for group_gc_list */
+static spinlock_t group_gc_lock;
+static struct delayed_work group_gc_wq;
 static char *status_str[] = {
 	"AMT_STATUS_INIT",
 	"AMT_STATUS_SENT_DISCOVERY",
@@ -90,8 +94,9 @@ static void __amt_source_gc_work(void)
 	hlist_move_list(&source_gc_list, &gc_list);
 	spin_unlock_bh(&source_gc_lock);
 
-	hlist_for_each_entry_safe(snode, t, &gc_list, node) {
-		hlist_del_rcu(&snode->node);
+	hlist_for_each_entry_safe(snode, t, &gc_list, gc_node) {
+		cancel_delayed_work_sync(&snode->source_timer);
+		hlist_del_init(&snode->gc_node);
 		kfree_rcu(snode, rcu);
 	}
 }
@@ -106,6 +111,39 @@ static void amt_source_gc_work(struct work_struct *work)
 	spin_unlock_bh(&source_gc_lock);
 }
 
+static void __amt_group_gc_work(void)
+{
+	struct amt_group_node *gnode;
+	struct hlist_head gc_list;
+	struct hlist_node *t;
+
+	spin_lock_bh(&group_gc_lock);
+	hlist_move_list(&group_gc_list, &gc_list);
+	spin_unlock_bh(&group_gc_lock);
+
+	/* Group deletion queues all of its sources first.  Drain that queue
+	 * before freeing the group so a source callback cannot dereference it.
+	 */
+	cancel_delayed_work_sync(&source_gc_wq);
+	__amt_source_gc_work();
+
+	hlist_for_each_entry_safe(gnode, t, &gc_list, gc_node) {
+		cancel_delayed_work_sync(&gnode->group_timer);
+		hlist_del_init(&gnode->gc_node);
+		kfree_rcu(gnode, rcu);
+	}
+}
+
+static void amt_group_gc_work(struct work_struct *work)
+{
+	__amt_group_gc_work();
+
+	spin_lock_bh(&group_gc_lock);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	spin_unlock_bh(&group_gc_lock);
+}
+
 static bool amt_addr_equal(union amt_addr *a, union amt_addr *b)
 {
 	return !memcmp(a, b, sizeof(union amt_addr));
@@ -215,9 +253,14 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
 
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
@@ -238,8 +281,9 @@ static void amt_destroy_source(struct amt_source_node *snode)
 	hlist_del_init_rcu(&snode->node);
 	tunnel->nr_sources--;
 	gnode->nr_sources--;
+	RCU_INIT_POINTER(snode->gnode, NULL);
 	spin_lock_bh(&source_gc_lock);
-	hlist_add_head_rcu(&snode->node, &source_gc_list);
+	hlist_add_head(&snode->gc_node, &source_gc_list);
 	spin_unlock_bh(&source_gc_lock);
 }
 
@@ -249,6 +293,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	struct hlist_node *t;
 	int i;
 
+	if (READ_ONCE(gnode->dead))
+		return;
+	WRITE_ONCE(gnode->dead, true);
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
 	hlist_del_rcu(&gnode->node);
@@ -266,10 +313,10 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
 			amt_destroy_source(snode);
 
-	/* tunnel->lock was acquired outside of amt_del_group()
-	 * But rcu_read_lock() was acquired too so It's safe.
-	 */
-	kfree_rcu(gnode, rcu);
+	RCU_INIT_POINTER(gnode->tunnel_list, NULL);
+	spin_lock_bh(&group_gc_lock);
+	hlist_add_head(&gnode->gc_node, &group_gc_list);
+	spin_unlock_bh(&group_gc_lock);
 }
 
 /* If a source timer expires with a router filter-mode for the group of
@@ -282,13 +329,28 @@ static void amt_source_work(struct work_struct *work)
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
+	if (!gnode) {
+		rcu_read_unlock();
+		return;
+	}
+	amt = READ_ONCE(gnode->amt);
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	if (!tunnel) {
+		rcu_read_unlock();
+		return;
+	}
+	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(snode->dead) || READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		return;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -299,8 +361,8 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
@@ -368,6 +430,7 @@ static struct amt_source_node *amt_alloc_snode(struct amt_group_node *gnode,
 	snode->status = AMT_SOURCE_STATUS_NONE;
 	snode->flags = AMT_SOURCE_NEW;
 	INIT_HLIST_NODE(&snode->node);
+	INIT_HLIST_NODE(&snode->gc_node);
 	INIT_DELAYED_WORK(&snode->source_timer, amt_source_work);
 
 	return snode;
@@ -403,26 +466,40 @@ static void amt_group_work(struct work_struct *work)
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
+	if (!tunnel) {
+		rcu_read_unlock();
+		dev_put(amt->dev);
+		return;
+	}
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
@@ -431,14 +508,12 @@ static void amt_group_work(struct work_struct *work)
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
 
@@ -479,6 +554,7 @@ static struct amt_group_node *amt_add_group(struct amt_dev *amt,
 	gnode->tunnel_list = tunnel;
 	gnode->filter_mode = MCAST_INCLUDE;
 	INIT_HLIST_NODE(&gnode->node);
+	INIT_HLIST_NODE(&gnode->gc_node);
 	INIT_DELAYED_WORK(&gnode->group_timer, amt_group_work);
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&gnode->sources[i]);
@@ -1328,14 +1404,41 @@ static void amt_tunnel_expire(struct work_struct *work)
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
+	deadline = READ_ONCE(tunnel->last_seen);
+	if (!deadline)
+		deadline = jiffies;
+	else
+		deadline += msecs_to_jiffies(amt_gmi(amt)) * 3;
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
 	amt_clear_groups(tunnel);
 	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
+	cancel_delayed_work_sync(&group_gc_wq);
+	__amt_group_gc_work();
 	kfree_rcu(tunnel, rcu);
 }
 
@@ -2494,9 +2597,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
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
@@ -2522,6 +2629,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_igmp_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2542,6 +2653,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -3050,7 +3165,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3079,11 +3194,38 @@ static int amt_dev_stop(struct net_device *dev)
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
+		cancel_delayed_work_sync(&group_gc_wq);
+		__amt_group_gc_work();
 		kfree_rcu(tunnel, rcu);
 	}
 
@@ -3461,11 +3603,17 @@ static int __init amt_init(void)
 	}
 
 	spin_lock_init(&source_gc_lock);
+	spin_lock_init(&group_gc_lock);
 	spin_lock_bh(&source_gc_lock);
 	INIT_DELAYED_WORK(&source_gc_wq, amt_source_gc_work);
 	mod_delayed_work(amt_wq, &source_gc_wq,
 			 msecs_to_jiffies(AMT_GC_INTERVAL));
 	spin_unlock_bh(&source_gc_lock);
+	spin_lock_bh(&group_gc_lock);
+	INIT_DELAYED_WORK(&group_gc_wq, amt_group_gc_work);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	spin_unlock_bh(&group_gc_lock);
 
 	return 0;
 
@@ -3485,6 +3633,8 @@ static void __exit amt_fini(void)
 	unregister_netdevice_notifier(&amt_notifier_block);
 	cancel_delayed_work_sync(&source_gc_wq);
 	__amt_source_gc_work();
+	cancel_delayed_work_sync(&group_gc_wq);
+	__amt_group_gc_work();
 	destroy_workqueue(amt_wq);
 }
 module_exit(amt_fini);
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde..123725c 100644
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
@@ -275,6 +285,7 @@ enum amt_source_status {
 /* protected by gnode->lock */
 struct amt_source_node {
 	struct hlist_node	node;
+	struct hlist_node	gc_node;
 	struct amt_group_node	*gnode;
 	struct delayed_work     source_timer;
 	union amt_addr		source_addr;
@@ -282,6 +293,8 @@ struct amt_source_node {
 #define AMT_SOURCE_OLD	0
 #define AMT_SOURCE_NEW	1
 	u8			flags;
+	/* Protected by gnode->tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 };
 
@@ -295,7 +308,10 @@ struct amt_group_node {
 	u32			nr_sources;
 	struct amt_tunnel_list	*tunnel_list;
 	struct hlist_node	node;
+	struct hlist_node	gc_node;
 	struct delayed_work     group_timer;
+	/* Protected by tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 	struct hlist_head	sources[];
 };
