Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995152F277
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914060; cv=none; b=CBuZWSw40p5ByXjbms25995juf0KA+eU6igWQ1IlJq+lykOg6U5HmJD+Q9ZMNy9SlJZy6uz8B7TQHzn0UpsG8O8iO0KMIx+uNSLnNKQ4XOiYQ02xLXlA6kQKXRHfF9mhODky2foR7CgLEI5lIbf3QQ8KP5ASbrdq+JuZJcVB8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914060; c=relaxed/simple;
	bh=+rgBUuhxJKmBBTvpxj/U/iDjMDtWha+2tcGcORqxevc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URCQhpgDb83XQeMwx8JGeSf1z0UHL3HTvAtN4J2pmJ4xmaN+rRNxvspxZ9mI9mb0S0KLrxAyUqjNMaKwED0yQriONyqg5NIuR0MM3jLm/Ef4LoU7kNiQuuLPFuSB1/PsvyoC5bVZ3FqaWtDnx78tK5Me4YpF+a5zloKY1tRRPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=ZtNqiCu+; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="ZtNqiCu+"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1472686eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914054; x=1792518854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy7vuCVC6dqQsBOXU3Poy9CiftIHFw0TvdwLI+E7rDM=;
        b=ZtNqiCu+zLFrwB+5EE3EgYM1R/IKFvgEyP5nOn0dzLkZcFKN+pnEkrLQRDFT+FxGf6
         LMt0C8vX5q8mC3LoDyRM3/VjZ4qaMoh0Tv9tE21eQMCX6NtmllBiWJZjRcgAuHW75URw
         6o3Me/fwbIH4/0R9hOsyam5jbx6Nb5RqpuF6gdmrWo+mEdzUXoThTRW41D8LF1qjF5/L
         nUMckHj+Q6OqDfN8bTCsBd5LckMrlMCu9gC4h5zAg1oht+fjxpIqHxBCxbPfDTvHIuyA
         Rod9AB9mvUdWo7l6vH9ZgS68StqJ6XoeUGcdYWB8U6Qm6ga/Hx0tpufM2ld6UYRV0nls
         PEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914054; x=1792518854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iy7vuCVC6dqQsBOXU3Poy9CiftIHFw0TvdwLI+E7rDM=;
        b=H4P3sSCzoEVqRk5LJyVUnzDjsBdurRb5L8J+33qWvF7ZFP75YETHtZuYaQCqO26NWT
         XtaOQNwXxJ1QY57obn6qL0hBoDMuQGnloRmjNcEspXwWWR3lZdyeART3tce14PKSnh25
         kDfMb3HBQvnid7cNaUw1Wz0qlHetnUNcr+D3Vdj0QOKo88AMy0qskHxadolcaKff3/zR
         H5sezbmY/OE9pnDH5hlUokDhWvR+mRGcf5UgdEE86B5wI/8IgAh8SYnOLp3qhHztO7LH
         Bwx+qQksOvlyZK6HvnR6xqbbTqcK7RZXWJ7gut0wOwq+XipdpYK8Wy+5eNeixje8BuRT
         Nn+Q==
X-Gm-Message-State: AFq9FYLGOg5g1khueAFXErpKWVORJs7WWFlumqsphSDMpqPhLxau+Smk
	N5fiG8icoqtxgRv8/y0aCg1yTtOfx8/FbeO1t/zqAtpvbxX1A1/5iQdP7SRxb+/C9Tg=
X-Gm-Gg: AYBFou3PruTHFRvXEeys8QTKDcqT1SLBLfHwuihmYn14XAcjkzPYBrDeH6fJYkpCdUL
	N95w03rzEo2QFQv+LROTDAOTb+zB51VpKG7Hx4wGuM8U19/oFYfFsXozjnGAsfM9sXhdGx52VaK
	Phfka1dpL5IEydxlK61HexhUUK0F/thbv6od+hSaFT/SQXTQ6fWWHxnAA51Acu/MHVTi1dhDp7m
	DI6dH9ZUyZE0Y47z3L24J8VirGVGbD78b3s5cDXvt6WPvlT70q0M5tyX2sL2A/MgXc6GD7Vi16l
	g/8igF3hftrB1MVH3hJobdZJkuPEfVx0+ix/28xcu3Nu1J/3+Huy7jsWbhKkCzNCR0qg4yBPhj9
	3q2eZMcKqUheTOljFlIDV1+/vRtVYTn6sWbujekUYWXdKk0ZFJDU2agVWttLYIvbFVpqeWysqSX
	ZUpqfziDI8sGYLNKuZIuFhD+/bnR5/TGHk2/Qkt8+ri4f37uvOggQgYzZV7nIJTnkdpAXA6tFDd
	TUY9u/GKCwf3J+fr6G24MTQ+UBgvdUEQPp49MaZCXBif0NLM+2pPNmJIWm7mXu0
X-Received: by 2002:a05:7301:1826:b0:359:866d:5bea with SMTP id 5a478bee46e88-359866d78a0mr11394322eec.21.1791914054301;
        Tue, 13 Oct 2026 10:54:14 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:13 -0700 (PDT)
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
Date: Tue, 13 Oct 2026 17:54:03 +0000
Message-ID: <20261013175407.947606-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
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
---
 drivers/net/amt.c | 63 +++++++++++++++++++++++++++++++++++++++++------
 include/net/amt.h | 11 +++++++++
 2 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b53f8ec..530650d 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1328,8 +1328,30 @@ static void amt_tunnel_expire(struct work_struct *work)
 						      struct amt_tunnel_list,
 						      gc_wq);
 	struct amt_dev *amt = tunnel->amt;
+	unsigned long deadline;
 
 	spin_lock_bh(&amt->lock);
+	/* amt_dev_stop() has taken ownership of the teardown. */
+	if (tunnel->dead) {
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	/* A Membership Update may have refreshed the tunnel after this work
+	 * was queued.  Re-arm from last_seen rather than letting
+	 * amt_update_handler() re-arm gc_wq: this handler is then the only
+	 * context that frees the tunnel (and the only one amt_dev_stop() has
+	 * to cancel), which closes the use-after-free where a concurrent
+	 * Update re-armed gc_wq on a tunnel this function had already
+	 * list_del_rcu()'d and kfree_rcu()'d.
+	 */
+	deadline = READ_ONCE(tunnel->last_seen) +
+		   msecs_to_jiffies(amt_gmi(amt)) * 3;
+	if (time_before(jiffies, deadline)) {
+		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	tunnel->dead = true;
 	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
@@ -2494,9 +2516,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
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
@@ -2732,6 +2758,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&tunnel->groups[i]);
 
+	tunnel->last_seen = jiffies;
 	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
 
 	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
@@ -3050,7 +3077,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3079,9 +3106,31 @@ static int amt_dev_stop(struct net_device *dev)
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
+	list_for_each_entry(tunnel, &amt->tunnel_list, list)
+		tunnel->dead = true;
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
index 2846dde..0520121 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -240,6 +240,17 @@ struct amt_tunnel_list {
 	u32			nr_sources;
 	enum amt_status		status;
 	struct delayed_work	gc_wq;
+	/* Last time a valid Membership Update refreshed this tunnel.  gc_wq
+	 * re-arms itself from this rather than being re-armed by the Update
+	 * path, so the Update path cannot re-queue the work of a tunnel that
+	 * amt_tunnel_expire() is freeing.
+	 */
+	unsigned long		last_seen;
+	/* Set under amt->lock by whichever of amt_tunnel_expire() or
+	 * amt_dev_stop() reaches the tunnel first; the other then leaves it
+	 * alone, so the tunnel is freed exactly once.
+	 */
+	bool			dead;
 	__be16			source_port;
 	__be32			ip4;
 	__be32			nonce;
