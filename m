Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB23B3BFE
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978718; cv=none; b=VX65LCFLrABSKHSp/tuv6fatk9x9Pv3/lueL76I0O5pSt4vQkUOK7tDt1Mjhd7iLmW9ilg7qeBMUmNCflm2qOLY3GNjGAFd9zT5K7u10hmOjRjxqU80xQXR2xTlnpq/Vop7glvP7G7EDh6ccfMswjXyehebu2HrfNlu/bdaRax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978718; c=relaxed/simple;
	bh=oHtui7Hj7RcAH9UBLhWHgaXhmfjFZTjDU0QyzUTUr6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/YfIkAFTkQ8YlltwLaGvYMVG7ms/a6vEEGxc6Huz4hN5GEfv7YkB+rN0hc5bmL0grTBVwOWtmcYgnp15IqbtF4YPn574tsVlokTthNCcs5w4L4T1gyvNwaeGmIGR08z5AntjIfBsA0StakE2iE7GqsVBWuVNYIlM3hL+1O9Z4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OU68Nybk; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OU68Nybk"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2447932a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978716; x=1786583516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YnPA/dUjw8h78HfyCCV2PyTmFNe31WD8LM9MY/olzM=;
        b=OU68NybkbxmL/XhZCjhJqJdRLRDizZEhRwnkwCqj72eXma0hUYsEzl1++5+FciRv7g
         pjgfKGV8bDllqXkI1Nlwb3SEgya0WW8HoDoU+CwrEEzwaccC+5zJ50aBZ9YWsuaoY1Kc
         VqViQGst6l2V01Y5TdJ0m1Jt7b3Xkypm8J3vI8ws4E/hTnn0o2gtS2Yam/LrfOa5cI2U
         AVSHYxJKa9xpkgq5xj1HClm5bGpudhonbkv/baXWLFl5f6KYRAMYgSvDWnbl9sBbIdn9
         lFNa0IIrh2gqYFAX0TKn0Pl04yOYAMzjU2YfhmbYLLL+FM7YKqgU4JOekuknB1c/NzEZ
         b9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978716; x=1786583516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YnPA/dUjw8h78HfyCCV2PyTmFNe31WD8LM9MY/olzM=;
        b=Z7cQSiD9ZERKiLBHsLchsCpKSc1OsGHtYadcYP+FYNksEIFZpX5pWEON0a4tOVQSDP
         P1Gh1XWQT4DVsCOkW/ZFZW1fBMmD4vqiGwWFzt/5HGzJIHV+B3LH3rQPq9QniU7hpN0I
         hJ8Qc69GPEEB/kNQhHBBlCvMLxXMs2TUicvGeVwwJsRf04IqaJSwT42J2XSliMiSDtpa
         oeFbkQH/cmL9r/uE2GAMxgFpYJLAh/DCUgKr48VYwwo8xnsao8N6W4w4oVAeOapWv1nj
         a7T58y3larYRtUkV77gV2rjwtbmq6DR9HSDh1pfZ+UqXXVyX05CS6dDQ3M8DA/Rv29re
         m0Mw==
X-Forwarded-Encrypted: i=1; AHgh+RoNS2EmZbfjLrBN0YVbxZifMbkp+pwAGA7t1NF90utK3b8YuiwE2WhPki+e5oW9iONovUWhXbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVQHhN0z0Qu/OczF2371RI3o6xCQpkkt+VxXt5Oje6+/kE7GW
	vO70aAj1bKZBH1wpfS9ScdmObtRBu48lQqoUw9rgV0v9yTEKgViv5zXEJaM5VsQiM1FnX4ecEqx
	7svBaUA==
X-Received: from pjzb8.prod.google.com ([2002:a17:90a:e388:b0:38f:57ca:2593])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f43:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-3903c54302bmr11843984a91.8.1785978715966; Wed, 05
 Aug 2026 18:11:55 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:24 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/11] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
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

