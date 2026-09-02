Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B64A8408
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381467; cv=none; b=OSmnxjyyN2yQS66t18C/y5Uq4U4ZXryalZO+EuvmnF8saaA0UANjbryQf9h8mgsHfJDQPge69xKJ+yyNqz2XTKSwh3V5SpbNfZTxmvndis94otiGzfJZKhrVbGqFHTpjUv3z3iaK9mQUnaQ0cL2AkbP33SCyzEvqxYsaDGO81Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381467; c=relaxed/simple;
	bh=oh5hzNBqW1ZywWNLztq9DuVS6kHrgCrIuueNaBPomR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YTEUkvWzitzxqDkG8UWQAnZyi/AO1PaP12VfBVqpPFBE+7PFlMJvKVqEopq7SWceowX6AkzQcTVdy+6E3NNDGR+Xt9MSC3yIPS+xwXRgFPzElPEzXxiiZ9iUUnGotSOZ63+APkeHBVbVMLdwxh8lBUFAhUi98vJA67ecJvMFmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xde8w0KE; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xde8w0KE"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc2229450b4so1509280a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381465; x=1788986265; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZAhWp3RGbD33CIWAycyOfBl36UDaNG0WHk+vOb8VZ0=;
        b=Xde8w0KE+3wgFFuTYyjhaQOhYbTc//5WpSjYrb0CKjIeljAbKcVFPNHNwvtuxkrhJX
         HPY8iIHvkPZ9I3XPKS7ui7v680jeZeaTG+WKWGQEpp62ogtNvOfPIsS8B/y1GHKbMIu0
         98dUiv0AQvK8WsFvzxe/QSgxyG5NSrMfgVanlXqm8ngOhj/mT5bp2s8v4VUkx23V1GtE
         XfjE+mjTSbScr00n2aprx0ewed4AoCPnNYkpnnH7OYGSTZZjbP/kIQF/Hp93OhFyjTnq
         AaJzhBXBJIEfvMvp9ljVAeO3JpbPq9uN8AijVgcjYI8yBehfG0dRcCHvOwrrSrTWjAAB
         vhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381465; x=1788986265;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZAhWp3RGbD33CIWAycyOfBl36UDaNG0WHk+vOb8VZ0=;
        b=QxfTwu9or7NRRI2Y1lsUhSrihfOw+2SpB/tXMdm5eC06JjM+BJuPUV+N78p1U4rl20
         t851ypUGYPe5JROLmmgnnR88J//RTYCDts5yO4Q2WTVjFwJah+gMfu4Dzm9qOFC48QUH
         hSXSseAPH23pNa6P8m3AmIjUcPERs3B90OF5HEo+oBzCbIiJ1V9cxDtt1qlQTY3r+Xpq
         j8sy4ota7riiSodp4/lIfLd3+Zn5CXppDLXxjUHnDHN5qaPEbHm27ebdfgvDHxj4SIEZ
         9xE2dYD4PBWOO6MImLSim6/tbITcaA+lpMt3L+TbV6zeT6DTOzUTi5r8u0hK0KSRadhJ
         jqeA==
X-Forwarded-Encrypted: i=1; AKwUvBzN/EywAm1YUMWka7mh66crDUaVwVnEu8bTMDsj5Et1tFSmN27nYR9cUE82LHSKOOoW4ah3szQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mXGTO4A3rQroSwd3jeYh72zGLNtCjwoHaWTgqwHt4ZJHbXE/YO
	avfqrOJi1Q96aTnPQdIIR3YO2dnf1EAW+zV3gY3tuVBNeSq3PhyR2tEuSNZhfF5oNqDMGLEYLBU
	3mzEppg==
X-Received: from pfbbd31.prod.google.com ([2002:a05:6a00:279f:b0:84a:1bf6:cb4a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:998:b0:847:9267:2104
 with SMTP id d2e1a72fcca58-85ed3793258mr10712486b3a.12.1788381465250; Wed, 02
 Sep 2026 13:37:45 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:45 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-5-kuniyu@google.com>
Subject: [PATCH v6 net-next 04/15] neighbour: Remove unnecessary EXPORT_SYMBOL().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Commit 1bf20cc62a54 ("neighbour: remove obsolete EXPORT_SYMBOL()")
unexported some functions in neighbour.c because IPv6 is no longer
built as module.

Since it unexported neigh_table_init(), no module can register
neigh_table dynamically.

Let's unexport a few more functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.970.g62bdec98f9-goog

