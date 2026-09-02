Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68167375F96
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381465; cv=none; b=f8JbxUEBhFuEp+Z2uOjkT/6xp8gUxYliEnTflbLQylOpYC1o1lngTw2URo2gCEN/SO/Yo6hZJKMeBNtKyUN697XWEzTZkItJKd5QV0i1XD2Cw+QS0rUqeTV61fw16jDzwTWbO90sm1L8RlxQ4/VOZMv81tMIegjzNjBDdNv50O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381465; c=relaxed/simple;
	bh=tBTTi1koY2zZSXj+yuYORsIOjjkmaY+n0eqGJc0NEPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QGCeP2UpgSyPyqkYgSCvyA8uNI8nYM2/KnIq0JE0QPp+uRlM33EL04t/0vl8pSK27hoP2AZt8T8xDlW+JhH4dVhQGt/xhhHhTWaLFzg1+mEmzgdiCEdphZJvlqSjoYYOjf2H/RyHveU7RFv9p/KUeiQ0tCjJg1ZRImwfTMjcDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhKUspEl; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhKUspEl"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc2229450b4so1509270a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381464; x=1788986264; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJke2pxtHWZObMHrTShNbG7YGkQdhPMvA5pT1Pylb/0=;
        b=LhKUspEl0Q3Zfo/o3GdplWQoJxvZGdhg9Z9SFFZNjj5JhFg8I7fTTQ61HRXWoEiFn5
         v6WUY26Z55nVjOHykW3T9X7ZXYsvazF6dXeLqjavkzfGtoO4NTytsr7VAx3GjqhaA1iT
         pDC8/4uiasTfz2hZjDI+H7ODQaDnGNnolT/0iUVdgjUZQQr0Ljx1IrAwg7w8n0JyLWN3
         3PSd5LJ4mt9+Jli5s+FYRHVeuM01C1yWrUSudDdDkIU+gZ3CAYfkKBUHIXSKaLvvLz45
         GRm9jta8KEeXF2IphOI8L38EWgVT3tcsH6YB9KVJs5SN7kcPQInAEjlRSZEyBQscqzml
         WCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381464; x=1788986264;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJke2pxtHWZObMHrTShNbG7YGkQdhPMvA5pT1Pylb/0=;
        b=R5NirISLA+1k+BTBjQwUmlbAi4QHdd9D1pcuFe8kOvl6VlSMxwCwDThNt/ibuqTFWh
         mUGsMNesLX8Br2+ekllVwZA+V+WDWzXoZJeh2+kyFu0oOMC6OfPzNtbEI9ZOofENAkyu
         JasdSTlggLQw5tgHyTnHGWT1rY8N5QWjWzPXXFt2D3JU+RL1NET8CBwQ43zGLa31nPe3
         wIHA4kifu27BbzrqCeTa0ZPgf6qTH+3igY48G4ugX5Qw6fYDoF4Qt9Pf69W+pFoz38Le
         sKzkAg3nAGiur/ga0QA6Y9DVcEr2Ww3klu6H+7AOXZsIYMJWmJRgMcnnNNcwfKf0fFqt
         b7nQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1bWCEHgBnVFfhkL0raZ+zeHMulIVvr7n163TkWRcNN9rMo5MzwDHA8bXi6LatT25gXKUvzMw=@vger.kernel.org
X-Gm-Message-State: AFuF++m0rtQeu3hm8G0xizFocT5+ijxEbmPys02URBAicptULbj0yLKd
	vpPAnYQLjNZ2M5yNZL+TbF1hqX+yVa5Zfs5U+Uj7MizErt8mJqJzenrjexOmsvmetr9rGDnWKiw
	F/BODJA==
X-Received: from pgbm8-n1.prod.google.com ([2002:a05:6a02:6188:10b0:cc1:c65d:a771])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a20:b0:3d3:adbf:7777
 with SMTP id adf61e73a8af0-3d9ae8ee528mr9760998637.19.1788381463459; Wed, 02
 Sep 2026 13:37:43 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:43 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-3-kuniyu@google.com>
Subject: [PATCH v6 net-next 02/15] neighbour: Remove __neigh_for_each_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Since commit 6deb53595092 ("net: remove unused ATM protocols
and legacy ATM device drivers"), there is no in-kernel user of
__neigh_for_each_release().

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/neighbour.h |  2 --
 net/core/neighbour.c    | 31 -------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc..7847c29496ae 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -405,8 +405,6 @@ static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
 void neigh_app_ns(struct neighbour *n);
 void neigh_for_each(struct neigh_table *tbl,
 		    void (*cb)(struct neighbour *, void *), void *cookie);
-void __neigh_for_each_release(struct neigh_table *tbl,
-			      int (*cb)(struct neighbour *));
 int neigh_xmit(int fam, struct net_device *, const void *, struct sk_buff *);
 
 struct neigh_seq_state {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..69a5f9dfa851 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3161,37 +3161,6 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 }
 EXPORT_SYMBOL(neigh_for_each);
 
-/* The tbl->lock must be held as a writer and BH disabled. */
-void __neigh_for_each_release(struct neigh_table *tbl,
-			      int (*cb)(struct neighbour *))
-{
-	struct neigh_hash_table *nht;
-	int chain;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
-
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
-			int release;
-
-			write_lock(&n->lock);
-			release = cb(n);
-			if (release) {
-				hlist_del_rcu(&n->hash);
-				hlist_del_rcu(&n->dev_list);
-				neigh_mark_dead(n);
-			}
-			write_unlock(&n->lock);
-			if (release)
-				neigh_cleanup_and_release(n);
-		}
-	}
-}
-EXPORT_SYMBOL(__neigh_for_each_release);
-
 int neigh_xmit(int index, struct net_device *dev,
 	       const void *addr, struct sk_buff *skb)
 {
-- 
2.55.0.970.g62bdec98f9-goog

