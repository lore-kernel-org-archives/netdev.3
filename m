Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E89404BE3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809992; cv=none; b=qVea2o/LyGO+A2HCTcGhIst1DXYAHUYC3rXb0tvFv4UDDp3UUcoVUnEwuHqePcYnw2DgV94pQ0mReM9FfV0+ylzkqIMM83no9gwdQKOJlIzDHZAk9jpGcM8urnuDs4+qXlCwt7TDCaSBUghTLLrR788NupHk1PI9f3yYwhFVTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809992; c=relaxed/simple;
	bh=xvEfOTH+u2cfXR/qJC6OJpECraiNLZlNn8v6eCQQ7mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtmc5zFmbewjy4kESrT9MnBeshXLTK9qXXUukA14ZA3/YJCGVBctgKJdStPkhWvx06RHMecXlwkkcVVTd+nZvOwOvRzEUzoPMDuXtNFgLkak0tGuyywDZw8eMtnb57e4Kc6iT7tiCh2fVmUxKxF0gNYjWvtBlj+FPxMqTPwwRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=u6yvVkF6; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="u6yvVkF6"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1419d3416ceso2429265c88.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809990; x=1792414790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auUK6uwbLjz7XvVLwkxu7WhsyxT8v+KxmTQKUtaP1KA=;
        b=u6yvVkF6BHIXeJgR8n4eFat9ZHH2Vt/srX9KOkFGihPRyOaKeetL4frItFdaVo25II
         UKQBX+PHYwDVuu0bnwsqEURx4djoFv0XpMxmiMfuW9XNTBY4vA6csqbRbygzoQR1Egps
         93dasrKhnp6A66z5rZRNpAkdcsqB6LtoR95uoovfRJsXeh2RjQlhDx8P8YU+OPUFB4+A
         bNpjp1V8eK8sw2CPHiwYyu9WMaIHAttu4vf1K+KjrZZKjWKJaxfL61ErAIe/3ex1QJOT
         2O5358Zky6rowMzuvBx33TOQSqOK0Au+Be78cQJ6I6T3nzTz1KdcY+vAgi8KYSx4IEo0
         QABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809990; x=1792414790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=auUK6uwbLjz7XvVLwkxu7WhsyxT8v+KxmTQKUtaP1KA=;
        b=TMKpa/yR82qczvPxqLaHdbZsg1cX/uDQFx/Oo1E+x8lD9xUQ03QFIvkMpwqZOwW7Ek
         o1l02WjZXwTY9+amJt6cb40GrAnGaQ33leYKyAnPP9tEkm37zam7VFlNZc45AJYq4153
         0VQHJsYv39ryhpkAgcVof995J0e4V6WiPq+74mWX0YatmDpLpqKtLBU7MHlxaKPB/bmk
         WCSUqkr28+dRRjDWX9r5aGo0B81+9gV0b/O7jgtLwlLNAhKZEmobsTKaMGtevVLl57an
         uJnXeBlv9ScFkQ0OAnVTPs8B5m9XAgmi+8qkb3rQtJV7KQaCJHGpwLW2yJ7ixvYrTfja
         E4ow==
X-Gm-Message-State: AFq9FYJ9l+CBjua/yCLIdDQFPPLyWyptwuiYautK8kKbToyAbc93tJ00
	ieInXHGYDLyD7/VoVIE2pwFJ0xYWgeYywjtTNkEAfbfszewvvk1EBqq/c3dYGM12iM4=
X-Gm-Gg: AYBFou2Sia4c0ZGf3vT+PAYnCNBF941ck58pzciB3EUpiD4g8QqgiI7Esm6f0VqtH6c
	UdSCz2P84oG7OsuV2rhgMhZoDXTrsZL9zQ3bIzw9v0sHTEb3mqJHO2G+/psl6+KlNBA1nwr7cfZ
	TeSTI8eTYkz1btGV6ij6G2ykM7y+4Cc3S0KMRiEfn0iqnQddjrgkN2UKdKAPqNdSLdlxhaSpWkm
	HHGVgQP26TI4fWYZZRTa/Pie43tY0dUJjoBmi2YBBE/lzzQxlx12UGBCOZ1iYtifTa/sJy1iAUw
	6uQLI8HeH/bpRIw2xncbDAywDmZC+aexBEc4FAEZMu1sR40MF8vLtwtGIBLbcd4Y0WIOOa/POC/
	NQ9BqnMFggMcR3roAkyl4G0t/LUWqR4RLx8Kt0j1rXLJcWYR9IDp4I5rh7a5/3PFYgeHfYn/qns
	q4VtJJxuB1Q7sVVlBJ7DOt/1WprHc/+UD7lWmRfuTf8a84u+IFx4EzfRn3ueGHSOo5nZ6YCZoSJ
	2AyeceDz7S+CKLOeHFzN7AUM1+C9BZ87/lMVrZyOdgRKwcpXrBtfeG/fqmDNMo=
X-Received: by 2002:a05:701b:230c:b0:14f:5cd:f286 with SMTP id a92af1059eb24-16a6203dc73mr14727010c88.34.1791809989483;
        Mon, 12 Oct 2026 05:59:49 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:48 -0700 (PDT)
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
Subject: [PATCH net v3 1/6] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Mon, 12 Oct 2026 12:59:38 +0000
Message-ID: <20261012125943.558629-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
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

amt_dev_stop() is the other freer; mark each tunnel dead and splice the
list out under amt->lock before cancelling and freeing, so a gc_wq that is
already running sees ->dead and bails instead of freeing in parallel.  The
tunnel is then freed exactly once.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 48 +++++++++++++++++++++++++++++++++++++++++------
 include/net/amt.h | 11 +++++++++++
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b53f8ec..b284fa7 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1328,8 +1328,29 @@ static void amt_tunnel_expire(struct work_struct *work)
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
+	/* A Membership Update may have refreshed the tunnel after this work was
+	 * queued.  Re-arm from last_seen rather than letting amt_update_handler()
+	 * re-arm gc_wq: this handler is then the only context that frees the
+	 * tunnel (and the only one amt_dev_stop() has to cancel), which closes
+	 * the use-after-free where a concurrent Update re-armed gc_wq on a tunnel
+	 * this function had already list_del_rcu()'d and kfree_rcu()'d.
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
@@ -2494,9 +2515,12 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (tunnel->ip4 == saddr) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
-				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-						 msecs_to_jiffies(amt_gmi(amt))
-								  * 3);
+				/* Refresh liveness only.  gc_wq is re-armed by
+				 * amt_tunnel_expire() itself from last_seen, never
+				 * from here, so this cannot re-queue the work of a
+				 * tunnel that is being freed.
+				 */
+				WRITE_ONCE(tunnel->last_seen, jiffies);
 				goto report;
 			} else {
 				netdev_dbg(amt->dev, "Invalid MAC\n");
@@ -2732,6 +2756,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&tunnel->groups[i]);
 
+	tunnel->last_seen = jiffies;
 	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
 
 	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
@@ -3053,6 +3078,7 @@ static int amt_dev_stop(struct net_device *dev)
 	struct amt_tunnel_list *tunnel, *tmp;
 	struct sk_buff *skb;
 	struct sock *sk;
+	LIST_HEAD(doomed);
 	int i;
 
 	disable_delayed_work_sync(&amt->req_wq);
@@ -3079,9 +3105,19 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 
-	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
-		list_del_rcu(&tunnel->list);
-		amt->nr_tunnels--;
+	/* Mark every tunnel dead and detach the list under the lock, so a
+	 * concurrent amt_tunnel_expire() sees ->dead and bails instead of
+	 * freeing a tunnel in parallel.  The detached list is then private to
+	 * this path, which is the sole freer.
+	 */
+	spin_lock_bh(&amt->lock);
+	list_for_each_entry(tunnel, &amt->tunnel_list, list)
+		tunnel->dead = true;
+	list_splice_init(&amt->tunnel_list, &doomed);
+	amt->nr_tunnels = 0;
+	spin_unlock_bh(&amt->lock);
+
+	list_for_each_entry_safe(tunnel, tmp, &doomed, list) {
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
-- 
2.43.0

