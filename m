Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CF3FC5C4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145378; cv=none; b=O7G8v7ExrODdo+rCyJB5sWLfGr44jvO/yjGKOkUNDHXsd17I52UUwNlWA3FYRK9dV4n8qy4QGJ/fJ/OXh22bwwtQwU8uxmglrR49qLUptInEFTRY78Oeq+oh7HJur3HQAkPKU1D3FrXPFd6iQU8eiICsPhhxvGTeRXKBp7pbi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145378; c=relaxed/simple;
	bh=oHtui7Hj7RcAH9UBLhWHgaXhmfjFZTjDU0QyzUTUr6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QR+/soQ0Hsm+gNKq/ohV86obSDOsSnX/JM7rn3lOVqXKzXHF3I65iWvUW09qKkgmecXXGXrYHeOH88dR4WuAthQnBRlqzIO332l3nWGJpZlwtKOElnCAglSh+b/5i+mIcWV/vgMTWH8fsn2LZ6n+4GLwZJ+K56GRPWbry5sYToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGjHS7i7; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGjHS7i7"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso98763b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145376; x=1786750176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YnPA/dUjw8h78HfyCCV2PyTmFNe31WD8LM9MY/olzM=;
        b=UGjHS7i7d00IK4sUWkANSU+halTZXZM6Z0x9PCj8oTqIP2g8y8J7xookBn0aC2oCwa
         XIYX+3w32ihJez9rB8EwQyxBTJA96tk7GUjBheHScuTS4b8VhldUhnLOo8lHr2JxJ3si
         yA4/aagQBakiyCvdp8f2KN7udt2118KOAvDNOthDTRqUrTa74veR9T7GjQjDSrwUAZlm
         IPw2HXBBfj2wQeP3u5GcgGgUxMD8+ZGWz8EHMlc/BNMpPH/9dtKh9fX3qSv6MGICVpiN
         12or9TdwS1r2j/R263Qih5FoyG7jQB4u2GMVb4ZNR7pV8nxEoxhhVRSOrS7Rmv7G00nX
         8/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145376; x=1786750176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YnPA/dUjw8h78HfyCCV2PyTmFNe31WD8LM9MY/olzM=;
        b=dftSlmWEkGd9LbU/T+L3jaVYBLcLFY4C5LPtwKxH84QjoS0GXCLyqZYxIM0bVJYi4M
         VoQ7I8GTjdMBhPYttAk6jtaz4EPR7p4XhYWsc1pPyY70KDgtwzUL9EuA+sud9SklgKX+
         7ZZI5ALfvCQVq1mXrzeA2HwqLCq6kSAb1fBUB8hBGmLICO4QxxtCaLjDjeQYDnxRJh3U
         NcVPRt1773QcdLACLtjxbN3JvpAGorQGjMuKKoehgYdb69o0F3zDfjNMRUmrgP45Mbb9
         Yhyio5RFHuhVdbyTL4mn7a1FqwkG6sgKYMp2HCPr7iU/yYP+awOjsdYf1PtHLsYFG+f0
         uiqw==
X-Forwarded-Encrypted: i=1; AHgh+RrUtFb3LMeje2B5Qs8TOtq8l2Pgibw5jBV9xa6oTWTlIaPdQceej+n7AmybPtLctV1/gRdYveg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfP2VEIYdfHBdWOwrHO/XYqLBtYtSd2dYQuoYDwOgsZgkDrf5q
	JnkzG3wFHcYmSbfI8Iej9G/TGkpLqXTX8o6gPk8E6O+MIGrHrVYM46zGf2YQFGL7hXTdBkLRqJO
	WsCnFKA==
X-Received: from pgiz16.prod.google.com ([2002:a63:c050:0:b0:cb5:f998:de4e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391a:b0:847:8704:1c54
 with SMTP id d2e1a72fcca58-84f2e0395a1mr24757941b3a.22.1786145375647; Fri, 07
 Aug 2026 16:29:35 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:40 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/13] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__neigh_update() could call neigh_update_gc_list() and
neigh_update_managed_list().

Both of them acquire neigh->tbl->lock and neigh->lock, check
neigh->dead, perform link operations, and release the locks.

Let's remove the lock dance.

Note that neigh->dead is always marked under neigh->tbl->lock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 69a5f9dfa851..13eea09721c6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -135,6 +135,8 @@ EXPORT_SYMBOL(neigh_rand_reach_time);
 
 static void neigh_mark_dead(struct neighbour *n)
 {
+	lockdep_assert_held(&n->tbl->lock);
+
 	n->dead = 1;
 	if (!list_empty(&n->gc_list)) {
 		list_del_init(&n->gc_list);
@@ -148,11 +150,6 @@ static void neigh_update_gc_list(struct neighbour *n)
 {
 	bool on_gc_list, exempt_from_gc;
 
-	spin_lock_bh(&n->tbl->lock);
-	write_lock(&n->lock);
-	if (n->dead)
-		goto out;
-
 	/* remove from the gc list if new state is permanent or if neighbor is
 	 * externally learned / validated; otherwise entry should be on the gc
 	 * list
@@ -169,20 +166,12 @@ static void neigh_update_gc_list(struct neighbour *n)
 		list_add_tail(&n->gc_list, &n->tbl->gc_list);
 		atomic_inc(&n->tbl->gc_entries);
 	}
-out:
-	write_unlock(&n->lock);
-	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_managed_list(struct neighbour *n)
 {
 	bool on_managed_list, add_to_managed;
 
-	spin_lock_bh(&n->tbl->lock);
-	write_lock(&n->lock);
-	if (n->dead)
-		goto out;
-
 	add_to_managed = n->flags & NTF_MANAGED;
 	on_managed_list = !list_empty(&n->managed_list);
 
@@ -190,9 +179,6 @@ static void neigh_update_managed_list(struct neighbour *n)
 		list_del_init(&n->managed_list);
 	else if (add_to_managed && !on_managed_list)
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
-out:
-	write_unlock(&n->lock);
-	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
@@ -1523,10 +1509,23 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 
 	write_unlock_bh(&neigh->lock);
 
-	if (((new ^ old) & NUD_PERMANENT) || gc_update)
-		neigh_update_gc_list(neigh);
-	if (managed_update)
-		neigh_update_managed_list(neigh);
+	gc_update |= !!((new ^ old) & NUD_PERMANENT);
+	if (gc_update || managed_update) {
+		spin_lock_bh(&neigh->tbl->lock);
+
+		if (!neigh->dead) {
+			write_lock(&neigh->lock);
+
+			if (gc_update)
+				neigh_update_gc_list(neigh);
+			if (managed_update)
+				neigh_update_managed_list(neigh);
+
+			write_unlock(&neigh->lock);
+		}
+
+		spin_unlock_bh(&neigh->tbl->lock);
+	}
 
 	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-- 
2.55.0.679.g6767b8d81c-goog

