Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883016;
	b=H+Y3qogn3WhFIe7/NPGwh+6Y0zdeP2qpBlI13gNmcKB1FTY5L0pR3dgT/rzvmYkV3OSu
	 5SDMDfDjKIZ387CI1VbscIQKhO2COx4MWd7iGxBlwtY5DFGeKWqbq5molihOOrCDRs6QG
	 Qxa3k/mTRZsIXXTK39Ng03IUlyGQNK51MtuFOtJA9o8qP43Z/1ORGnwXC7hg+6EkFn8QP
	 D/RgSd1X01lVfHgbLfW3b8x6hTo1E/IykAHrUEqPPbb4p1J4S6CLPxb86/PScHgdmAmId
	 VXRKHwboT62/sXAjLLkRG8V0mGIprKrS55FuyF/Pb0QHb6VCeZujq9G0qJLlbP9gUaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xl+n4CRxTMqfVMfOB+6leLeFjJGVGlKjUv8kn3xusBA=;
	b=1EFEe11CkHxF5XSkA3zUa0NTnqBFuYSpOWSca/jGHXrif35W6t5RLJqarg+u9ySZ4K2w
	 3qBNuxg7eNP22rUU6kmZPDnAAa3vVp7j5hqIeVYAK3/qfbxsdVbzcisZqN+LMdkc4zF4U
	 qdwZ3IHhlSh9hAhqlrWsUrx8pOgqf7dchEvrWvvqAmyyauuZtu1nFMkI6CmZYyE1K5VkB
	 xd4atnfr2nADV40Stel8JeNSTu1BWFFrHN8irpamlINdsRAK76NIMqOKVjdaqHeRUi3p9
	 k/xdHZEDjAPd8n0aptYx1Rz5JLC02GPdZA/EvBgaNjFFcGgER1dqaljrGYlbMrzhUMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=xj9RAIow;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0B606A337
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB0B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=xj9RAIow
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4944949eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883015; x=1794487815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xl+n4CRxTMqfVMfOB+6leLeFjJGVGlKjUv8kn3xusBA=;
        b=xj9RAIow9MS/0nMoaojIIvqSyqis2ECC3HXgJFofOLnVhC2Ruwe3oM1GOtCIwv4AD1
         U0Nptxz4tb5ocHUxWRoz2eYUj+lKhGR0Krj0GM+kfSr35WjEWDrt1VGesd7sbEkOwLf8
         xbEwikEZlKv3AbXbA63hplZmQDIJhEeZBxk9FGldvSsg/Smaii125gVCxayxB1nrFubA
         OXUVY7EAaFm+r+y4qdL6AQOmVLlAa1pPDbaa5d3ysKlUr9ox0yidOjx4pP3RjZqQ0Ciu
         1XFKHbMQempITwJGkzRPfjaZW76wn8IOnEE8NDmKIupBWreOWmTJzDk6XvfHniRv16UK
         +HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883015; x=1794487815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xl+n4CRxTMqfVMfOB+6leLeFjJGVGlKjUv8kn3xusBA=;
        b=Q4nm9jdKEbi6wV5GPJqlPbJigbEIuwv5C9JI0gPEX+C8HQ0FHax39bpCLJ2nwDfpkm
         dGC07Racs8UucoRQ0nF6W1o8vmJyI42P2y/vnmaMrbWnIA8VQv1NtXGwS3p/aWmyCrGm
         OI4+0fFYipXajh8dRXVhST09xyrV+LNEwBz4Xkv9Tu4G5jRc5lCwmERVfFzEGBMBgtZe
         eB4Q9n41b3yH178Qtv4xL0pxrv7runvzybQ324FIW3jWjbh7P+JZ/OzEV2SJ0Efls6tA
         GpsYqyOio3joHcof7a4rkDRBZeDCMknOi4HCVtBTadNZBdrPgpa8o/MW8znYlA30eaLU
         ljhQ==
X-Gm-Message-State: APuU4Z/BvHBeoyq0J7R3UavRxoUu9GmZ3J22ROsT2GVamtF/f9bCqfvP
	ZBDP2/firEq/5UlJXiMuCegz4MCRv9ME6gAvxzT0axu4fC8xlUdqOBcIFqfIwV84y7s=
X-Gm-Gg: AYBFou05egzScVSeXqj2sMh2JFe11eTi3kROEnxQ/pbMXfnc2uQTQKhg99WIB0tMhuG
	OOKme7lbUFL6bBJC/d2MvAICRwN6ABAVHn0i+JJf0lYGT4Dk0uUReJkCkyBQ1H1DlARfzMrkrrt
	WKduczMXb9pjd1clTMWoa5+osKut+TLQL1xsa9KuwMb5OlU/3zFxyvTGbtUWEoKIg6Wf3oE1CIz
	NQdfSWmYWVUyjJMMEGSC4Ad4WzXVSQKV/xgjCpWTmnj1EGczfHgglwI5/ABfIYo2yAKNNmOS4ak
	FPgvrrPBh44piV1Xzb8ms2T3s0x1a2w5Qhw0PIX0XrutocNpvC6vVS4jrcAXctFmPR9Cn0N2Ha0
	DlXJEJNDkmDCdWOaSf8P6ZAhFoHlaDxGHEelwNQE0BRNhg8wZ4EQgEksn8jzahlEVC1zeSZOtbW
	IFyeTA5mVE0bx/HzRN+Aj/O3NpmGDtFKCdqtVTgZUgaZiwvWS2Ul76BlZxmWNVrVgytGUY8yoZp
	YBVycE59c0fUx4GfyGIHnwgYN/yH33gRkxqUS085Du7BNr0JQgEJ8UMxB9vl3Qxi3AmPN+G5mDC
	sjECooWFDnpekNidRVzE2g5WEPVBXWUprtKh3d6j9GS1ERuX3Pbyr1ICyu3BvQhfSgVAwpU=
X-Received: by 2002:a05:7300:c00f:10b0:36a:5207:e58b with SMTP id 5a478bee46e88-36a5207e70fmr28081127eec.27.1793883014886;
        Thu, 05 Nov 2026 04:50:14 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:14 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 1/5] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Thu,  5 Nov 2026 12:50:06 +0000
Message-ID: <20261105125010.1107546-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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
cancels their work, and frees them after lockless readers have passed.

Apply the same lifetime rules to group and source timer work: mark nodes
dead under tunnel->lock, keep RCU held while workers resolve their
owners, defer node freeing, and synchronously cancel each timer before
freeing its owner. Flush the deferred GC before freeing a tunnel so
nodes are reclaimed promptly; flush rather than cancel so periodic GC
keeps running. Lifetime does not rest on the flush, which can return
while a GC run that already spliced its list is in flight: it rests on
kfree_rcu() and on the owner pointers being cleared, and the dead checks
made, under tunnel->lock. Release the group timer's device reference on
every exit. A Request-only tunnel retains the original GMI timeout; only
an authenticated Membership Update refreshes last_seen and uses the
longer lifetime.

The Sashiko review of v2 of this series pointed out the gc_wq re-arm,
and reading amt_update_handler() against amt_tunnel_expire() and
amt_dev_stop() confirms it. It is theoretical: it needs a Membership
Update that has already found the tunnel under RCU to arrive while
amt_tunnel_expire() is freeing that tunnel. I have not triggered it,
so there is no trace to include. Review of v3 and v4 raised the races
in the group and source timer work.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 201 +++++++++++++++++++++++++++++++++++++++-------
 include/net/amt.h |  16 ++++
 2 files changed, 189 insertions(+), 28 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..d8914d811 100644
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
@@ -106,6 +111,42 @@ static void amt_source_gc_work(struct work_struct *work)
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
+	/* Group deletion queues all of its sources first.  Flush that queue
+	 * so they are reclaimed promptly; a source callback cannot reach a
+	 * freed group because it resolves snode->gnode under RCU and the
+	 * pointer is cleared before the source is queued.  Flush rather than
+	 * cancel: source_gc_wq re-arms only itself, so cancelling it here
+	 * would stop periodic source GC for good.
+	 */
+	flush_delayed_work(&source_gc_wq);
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
@@ -215,9 +256,14 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
 
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
@@ -238,8 +284,9 @@ static void amt_destroy_source(struct amt_source_node *snode)
 	hlist_del_init_rcu(&snode->node);
 	tunnel->nr_sources--;
 	gnode->nr_sources--;
+	WRITE_ONCE(snode->gnode, NULL);
 	spin_lock_bh(&source_gc_lock);
-	hlist_add_head_rcu(&snode->node, &source_gc_list);
+	hlist_add_head(&snode->gc_node, &source_gc_list);
 	spin_unlock_bh(&source_gc_lock);
 }
 
@@ -249,6 +296,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	struct hlist_node *t;
 	int i;
 
+	if (READ_ONCE(gnode->dead))
+		return;
+	WRITE_ONCE(gnode->dead, true);
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
 	hlist_del_rcu(&gnode->node);
@@ -266,10 +316,10 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
 			amt_destroy_source(snode);
 
-	/* tunnel->lock was acquired outside of amt_del_group()
-	 * But rcu_read_lock() was acquired too so It's safe.
-	 */
-	kfree_rcu(gnode, rcu);
+	WRITE_ONCE(gnode->tunnel_list, NULL);
+	spin_lock_bh(&group_gc_lock);
+	hlist_add_head(&gnode->gc_node, &group_gc_list);
+	spin_unlock_bh(&group_gc_lock);
 }
 
 /* If a source timer expires with a router filter-mode for the group of
@@ -282,13 +332,28 @@ static void amt_source_work(struct work_struct *work)
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
@@ -299,8 +364,8 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
@@ -368,6 +433,7 @@ static struct amt_source_node *amt_alloc_snode(struct amt_group_node *gnode,
 	snode->status = AMT_SOURCE_STATUS_NONE;
 	snode->flags = AMT_SOURCE_NEW;
 	INIT_HLIST_NODE(&snode->node);
+	INIT_HLIST_NODE(&snode->gc_node);
 	INIT_DELAYED_WORK(&snode->source_timer, amt_source_work);
 
 	return snode;
@@ -403,26 +469,33 @@ static void amt_group_work(struct work_struct *work)
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
+	if (!tunnel)
+		goto out;
 	buckets = amt->hash_buckets;
 
 	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		goto out;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		/* Not Used */
 		spin_unlock_bh(&tunnel->lock);
 		goto out;
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
@@ -431,14 +504,13 @@ static void amt_group_work(struct work_struct *work)
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
 out:
+	rcu_read_unlock();
 	dev_put(amt->dev);
 }
 
@@ -479,6 +551,7 @@ static struct amt_group_node *amt_add_group(struct amt_dev *amt,
 	gnode->tunnel_list = tunnel;
 	gnode->filter_mode = MCAST_INCLUDE;
 	INIT_HLIST_NODE(&gnode->node);
+	INIT_HLIST_NODE(&gnode->gc_node);
 	INIT_DELAYED_WORK(&gnode->group_timer, amt_group_work);
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&gnode->sources[i]);
@@ -1342,14 +1415,40 @@ static void amt_tunnel_expire(struct work_struct *work)
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
+	flush_delayed_work(&group_gc_wq);
 	kfree_rcu(tunnel, rcu);
 }
 
@@ -2508,9 +2607,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
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
@@ -2536,6 +2639,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_igmp_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2556,6 +2663,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -3064,7 +3175,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3093,11 +3204,37 @@ static int amt_dev_stop(struct net_device *dev)
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
+		flush_delayed_work(&group_gc_wq);
 		kfree_rcu(tunnel, rcu);
 	}
 
@@ -3475,11 +3612,17 @@ static int __init amt_init(void)
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
 
@@ -3499,6 +3642,8 @@ static void __exit amt_fini(void)
 	unregister_netdevice_notifier(&amt_notifier_block);
 	cancel_delayed_work_sync(&source_gc_wq);
 	__amt_source_gc_work();
+	cancel_delayed_work_sync(&group_gc_wq);
+	__amt_group_gc_work();
 	destroy_workqueue(amt_wq);
 }
 module_exit(amt_fini);
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde0c..123725c88 100644
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
-- 
2.47.3

