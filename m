Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FA3B47C1
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978719; cv=none; b=hB3URYPI8wppThfbLifqjCp3NtRuAyKiD7QkkhEhF5SzZ95Tjjtg1dnmE/NHb5FDWh8woXWUMyrnRjkBy39NcAG7Gzlt/iwWOMDPuUktw/oeav0cVqdcDlseedMSLJ2XFoJ5X2xDi9fF6nm2Rgo6pXZgTYjcQCxACf2boTTjHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978719; c=relaxed/simple;
	bh=7SIwkUwDZC8PynNLF97Z7LIijsDycuVBB1OdCf94DmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pbmdTxLzKJPrr0aS3siqD5fObydxOnbATnQXafYmr/YWpRLIbn/Z45kvOaxxNDEQXmj/3PIG9OBc4kpIc+8U8+NpQxDVpRTmJnWQQ3nRIV4CCB15G+D6qtMV4JqR5z2NrXvK3i7fs1A/CJkUszOQyCh6zv3D17cbU7IW9f1pnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaFdLxBo; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaFdLxBo"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1461283a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978717; x=1786583517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gYbutCgmNaSnbAioZiD/fXIyRmG9bSYrdY6CVLx9Lk=;
        b=jaFdLxBo9sJ/e/7T7q4jU99Tx4U7/2QQSr9kVXpTnO20sfgYePV/quOPqefSaR61eu
         xbMXRP4HOiDoT1XPMJzXklPZ6J+TfHcqwqV3RRy5p2spFKpG9AOD12YjDE1NwTq0pj/h
         wRj5Kork8Cs+0BDcoRTP5LrQPn7ya8TQSnHdDQvZBw5i4GhwjF1LLIYgpGKddEk2jBst
         7fJCqbFiJBJWJ7IGwe0Gn0Zh+HZC2vigXWEwQhaKLb6JwQ9qraEZa4KrOgeEbVzeDptB
         ST4GUCu75jeBcXVF7CNdAktkE2iI66SmC5gLO7uOxG6qK5mNqNZ/6+xX5yjKAbO/rBG8
         DWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978717; x=1786583517;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gYbutCgmNaSnbAioZiD/fXIyRmG9bSYrdY6CVLx9Lk=;
        b=jgqhtL2ukD10zgYXH2QqkCKXwAZyn32bmNBXaYDUmlL7dd6RHlHJ5AdBcJkW6kpxRZ
         dFsF6NNEQyhtD0S6xnmFNyx98CVEIM+HcxpJ6ZQlNVi+1vPMMtVw5qsavhdg1BdFyV8c
         YS/Y0CoqlP4Xz9ShT1+t7cu3ZpjI5NOywpSlYI6ogknYDVy7G4sp1c+HykDknM9RxB1q
         cxBOU9xVDacRTNIKM0C1qoPsgFT9vxY6rwM+HqXQchzyqAnSc7IsIj+MCKa/R5gaP5fH
         gYcGDWiwzg60xF9TwrvrXSb117hSnjn1SUER/dbkOMN5OcxJEdoNcRlkrz5/4avbpex7
         FmkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFRhu7JH90ZV9QFwrj8Wu1WsQOXtZ2pq2QeaeAtRUxkxNyR4UmUcWpQQEmB/R8akulJDatjG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacZaxGR5bYD2xh70TdYcLaaS8lhckU2U0J0yUCEKf/eIkI2sa
	c2ek0MYPrY/9jRozb/vcpwa8x7mOlIMF574/oFfuGiCDUTQ2ReFWV3jwLXD9YthBsvCusr/cZZS
	YZQk+vw==
X-Received: from pjbca10.prod.google.com ([2002:a17:90a:f30a:b0:38e:8c19:321b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5683:b0:381:26f:8f05
 with SMTP id 98e67ed59e1d1-3903c5380f7mr11055802a91.3.1785978716854; Wed, 05
 Aug 2026 18:11:56 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:25 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/11] neighbour: Remove unnecessary EXPORT_SYMBOL().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 1bf20cc62a54 ("neighbour: remove obsolete EXPORT_SYMBOL()")
unexported some functions in neighbour.c because IPv6 is no longer
built as module.

Since it unexported neigh_table_init(), no module can register
neigh_table dynamically.

Let's unexport a few more functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 13eea09721c6..6fda0052027b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -131,7 +131,6 @@ unsigned long neigh_rand_reach_time(unsigned long base)
 {
 	return base ? get_random_u32_below(base) + (base >> 1) : 0;
 }
-EXPORT_SYMBOL(neigh_rand_reach_time);
 
 static void neigh_mark_dead(struct neighbour *n)
 {
@@ -1539,7 +1538,6 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
 {
 	return __neigh_update(neigh, lladdr, new, flags, nlmsg_pid, NULL);
 }
-EXPORT_SYMBOL(neigh_update);
 
 /* Update the neigh to listen temporarily for probe responses, even if it is
  * in a NUD_FAILED state. The caller has to hold neigh->lock for writing.
@@ -1557,7 +1555,6 @@ void __neigh_set_probe_once(struct neighbour *neigh)
 			jiffies + max(NEIGH_VAR(neigh->parms, RETRANS_TIME),
 				      HZ/100));
 }
-EXPORT_SYMBOL(__neigh_set_probe_once);
 
 struct neighbour *neigh_event_ns(struct neigh_table *tbl,
 				 u8 *lladdr, void *saddr,
@@ -1570,7 +1567,6 @@ struct neighbour *neigh_event_ns(struct neigh_table *tbl,
 			     NEIGH_UPDATE_F_OVERRIDE, 0);
 	return neigh;
 }
-EXPORT_SYMBOL(neigh_event_ns);
 
 /* called with read_lock_bh(&n->lock); */
 static void neigh_hh_init(struct neighbour *n)
@@ -1623,7 +1619,6 @@ int neigh_resolve_output(struct neighbour *neigh, struct sk_buff *skb)
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_HH_FILLFAIL);
 	goto out;
 }
-EXPORT_SYMBOL(neigh_resolve_output);
 
 /* As fast as possible without hh cache */
 
@@ -1740,7 +1735,6 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 	mod_timer(&tbl->proxy_timer, sched_next);
 	spin_unlock(&tbl->proxy_queue.lock);
 }
-EXPORT_SYMBOL(pneigh_enqueue);
 
 static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
 						      struct net *net, int ifindex)
@@ -1788,7 +1782,6 @@ struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 	}
 	return p;
 }
-EXPORT_SYMBOL(neigh_parms_alloc);
 
 static void neigh_rcu_free_parms(struct rcu_head *head)
 {
@@ -1811,7 +1804,6 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 	netdev_put(parms->dev, &parms->dev_tracker);
 	call_rcu(&parms->rcu_head, neigh_rcu_free_parms);
 }
-EXPORT_SYMBOL(neigh_parms_release);
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
@@ -3398,7 +3390,6 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 
 	return *pos ? neigh_get_idx_any(seq, pos) : SEQ_START_TOKEN;
 }
-EXPORT_SYMBOL(neigh_seq_start);
 
 void *neigh_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -3425,7 +3416,6 @@ void *neigh_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++(*pos);
 	return rc;
 }
-EXPORT_SYMBOL(neigh_seq_next);
 
 void neigh_seq_stop(struct seq_file *seq, void *v)
 	__releases(tbl->lock)
@@ -3437,7 +3427,6 @@ void neigh_seq_stop(struct seq_file *seq, void *v)
 	spin_unlock_bh(&tbl->lock);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(neigh_seq_stop);
 
 /* statistics via seq_file */
 
@@ -3561,7 +3550,6 @@ void neigh_app_ns(struct neighbour *n)
 {
 	neigh_notify(n, RTM_GETNEIGH, NLM_F_REQUEST, 0);
 }
-EXPORT_SYMBOL(neigh_app_ns);
 
 #ifdef CONFIG_SYSCTL
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
@@ -3657,7 +3645,6 @@ int neigh_proc_dointvec(const struct ctl_table *ctl, int write, void *buffer,
 	neigh_proc_update(ctl, write);
 	return ret;
 }
-EXPORT_SYMBOL(neigh_proc_dointvec);
 
 int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos)
@@ -3667,7 +3654,6 @@ int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write, void *bu
 	neigh_proc_update(ctl, write);
 	return ret;
 }
-EXPORT_SYMBOL(neigh_proc_dointvec_jiffies);
 
 static int neigh_proc_dointvec_userhz_jiffies(const struct ctl_table *ctl, int write,
 					      void *buffer, size_t *lenp,
@@ -3687,7 +3673,6 @@ int neigh_proc_dointvec_ms_jiffies(const struct ctl_table *ctl, int write,
 	neigh_proc_update(ctl, write);
 	return ret;
 }
-EXPORT_SYMBOL(neigh_proc_dointvec_ms_jiffies);
 
 static int neigh_proc_dointvec_unres_qlen(const struct ctl_table *ctl, int write,
 					  void *buffer, size_t *lenp,
@@ -3894,7 +3879,6 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 err:
 	return -ENOBUFS;
 }
-EXPORT_SYMBOL(neigh_sysctl_register);
 
 void neigh_sysctl_unregister(struct neigh_parms *p)
 {
@@ -3905,7 +3889,6 @@ void neigh_sysctl_unregister(struct neigh_parms *p)
 		kfree(t);
 	}
 }
-EXPORT_SYMBOL(neigh_sysctl_unregister);
 
 #endif	/* CONFIG_SYSCTL */
 
-- 
2.55.0.679.g6767b8d81c-goog

