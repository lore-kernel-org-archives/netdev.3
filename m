Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5940DB43
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145378; cv=none; b=lb6zMYb4fRjNERn9ZijHrAG1CIv2/CMGysgehLhU4yZZbegJWKvWQ/cWLUd5odNiR8zlvR0mBVQfJhxIvuyxp5FoLxZv76OfMhwWoOL38MyDzagPxiK7rthEqd+ilFzgQnWh3E//gnfZbAeQX8IAfwmQaUYoJoXiuAmzwVYBAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145378; c=relaxed/simple;
	bh=7SIwkUwDZC8PynNLF97Z7LIijsDycuVBB1OdCf94DmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rFNd8bM00bCs55uDGZO8B7Ww2Hd6AuEcKoV+GK36LyKEd9UN6fzqzbMkqixh6gRBFEYETpnrMXItm8fzrToOPdbKEX8s+JhtiMPPGhG2vCaNZ3BJpCOsBYERP1zMLQnkHfZhYlDptd7BzuvPJdG8f3jf9ySlScVDpkwao3bROLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNXafAm8; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNXafAm8"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so103974b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145377; x=1786750177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gYbutCgmNaSnbAioZiD/fXIyRmG9bSYrdY6CVLx9Lk=;
        b=TNXafAm8hRHR98l5yAjY4Yds6FCuHyFtt2DxT9b3VI7wIXWdi1bUbwU4JEK0vWGXJR
         UfUKvG0Z6ROVPRKDt0BWYBwVH68fNkSwZV5yl/jAeVtDR4lbLgTCdx2CJ8dlGuo9YfQ9
         6i2Rn3QhZ73hyammRwTJx5ruCbUL1371Oxtt0+8kShft3vItwZ/JDFHdonruGI08bbp/
         wZ6S6tgszKm8Ug52mZzfpPeGWGA8k76QoQBkgaqyHlBsw2XEF0CB4ParRYBXY+zI/qjl
         vd7K11uD6dezvw8KWU3E6rR9c327eBCyFvEEOBr1Dc8dyR6pxTMShfSsffv9RW+Ehn8s
         pFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145377; x=1786750177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gYbutCgmNaSnbAioZiD/fXIyRmG9bSYrdY6CVLx9Lk=;
        b=LkLhBikZQ0OzOQEjdETUOBPXDgjvCDG4Hp9B0Wjwf9wilwUNGcdz+V7iTVA3eZ30ao
         ZddntY8hoe0b8VfIKITfEJaUnqXyOxVAOEchl4UzcT33z5mssZLmHlFQc/oJ+eez1whX
         ev8fbeq6jhmMI3IDrCxSiSo0FOREeY0mB+zqINi3e20+vTj/9IiQQxjnFTUrse1ZBzH5
         AqEBFPk+fH3I8VqeyTg7pgT3qU6zfY8IRo8WfjLpknTs5QVvY6rhqDyLw5p8tBMSVYMN
         ZzP63ZI6lXf+KgjRewyrwUJudRH/uQxiPi6PElppzhSYeQQxUJxQRw8N6Lrtdnh7bi/H
         NxYg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6j9VmsM+wPRXgn7nLyOXD4x1LxYHq3so5FTSTpWDuaE6FiJXTSRu3Dyv/dnpHdUYKu10ck7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZTGkC7a2lJ/C0dwJuuyjhGRIMP37ius3XJTyTAN0MBHoNAhb
	cHXtIxvgtcHN5qXAtfzRBIduNM9Kek7rDjz+YgE2adBKHqlKnc6CsbPQ9UqmyVQGliK+fmgsgqV
	uHcZZLA==
X-Received: from pfblb8.prod.google.com ([2002:a05:6a00:4f08:b0:847:b8ab:8270])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:278b:b0:848:7b92:8e74
 with SMTP id d2e1a72fcca58-84f2e0dc994mr31914460b3a.39.1786145376444; Fri, 07
 Aug 2026 16:29:36 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:41 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/13] neighbour: Remove unnecessary EXPORT_SYMBOL().
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

