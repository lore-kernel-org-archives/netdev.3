Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38943F4AD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608178; cv=none; b=UjHAxCZF7JirsLALCgJmKmSMHNKcSRZ8m4J6pVH+sm9XF28uCnnUm0HZGOY+ZGWYcpVaAp1zLEEM/MtX3y4bDgL5PCxfn8G/+rYVA9DJCbDJ8GZK6f0pTz9Yr+oJu7liScEsYymBRbFkVrEDiOhOGi9emHqHmVQekCsxSEjp4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608178; c=relaxed/simple;
	bh=TTTHiOjPnqEtJv811smDJmt5f5AGejpp6otjNH2i86w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WJNla/6Vls7dntb66Y+mWQpKKPC6Z6N3PSWrIzGdrCD6wQvPpLAvrXJchviZiemUzldyz2K8gSOYasV6PJx9ZmD/jTqOhabAZFV9QJp84CCePR1eDO3MNvpuJQgSzItoRC7Rj7VkSsA9jwU6QRLp6lJ+IMIOUmUYm+gbsLCfErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2fUI61l; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2fUI61l"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e04598adeso1654395b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608174; x=1787212974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVCMzyLmQe8c/y9xHACUJkb6rgB1dcmg4AOyFrDCqUg=;
        b=a2fUI61l1zqiGZ6NElnG4F7yZ47ZsQMtMxoBqUgTm2ga8Y0mrrqqSWKxgTkf+9QlJa
         OzNJW1Xik48tc0CNCIKJjEc1KD4cTSbEapg0573/l8u4qCZP4t8ajTZ0OE9wpQ8gXI4Q
         t3LSeeaVBGAsvvT/gCwO8TmY0mrlkjfLdtlgqPYXZYoPgBUlESgL26C54YYoz61hWKwu
         3NRpRFd+V4fLwlvp8+Tbkxr/rlAWkWEng0ldAJP+0iXBGT0vaxzrrubbAezO7X1+0Ux3
         9GxGEgCFnaTcBCjx7cOnC2FAskbZyorK20naG/zLTR4cJI5Y2zGhBw3bOBOHKw7kAXTn
         q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608174; x=1787212974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVCMzyLmQe8c/y9xHACUJkb6rgB1dcmg4AOyFrDCqUg=;
        b=cEk55mNoYGNdSCpvv19aqvCKcvnZttXPibBU+Axidpt4vjKiVfM3jnimBPTZtXtW9+
         cUpt4ckUIda2qwG1xMo850suO68vYqpoEUc1JWEat2AWtOg9GotYFPkSaXdpPYNJ1p0q
         qZgGSoVTT1tA7Eqy0rE9jDMvSFyO9AvwxARZIvQc10nQN5tSplbi3veEUniuiJYNwXpi
         mVJDV0i3puwBdDcPqTThlOIbQCuHSVZZ07531WbBG2MTrT1LvVqhm01DozsKS9d/QIrk
         gyVDeVeTlAjc1xQvVN9q2ARx321RLtL808tdF+qu/jCewM/jfbMhBZu7JqkpFLi5IBkI
         s/bw==
X-Forwarded-Encrypted: i=1; AHgh+RrD9uTgCfGMVw7pEYWZ+2YEhOf1VI/r/FDfL9Ua6kJMMMw0VHS+4VsePtk04Fp8fJKQ57rxujo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfwo+ajvqYQd65aV4gP3c/4jrTWyjk+7glM/b9sTgCRQlqEn2b
	S+P5TNFcyFo1rVLkxYkiRJRyvatIaz4BV1Lch+aMRcQGYW6d/uXU9cMOQiGSkDru8Uh8Z9ZkUDg
	2VpDQXg==
X-Received: from pfx15.prod.google.com ([2002:a05:6a00:a44f:b0:848:7bbd:284b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391b:b0:848:2e3c:9955
 with SMTP id d2e1a72fcca58-84fc6cb1537mr3726255b3a.4.1786608173476; Thu, 13
 Aug 2026 01:02:53 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:18 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-5-kuniyu@google.com>
Subject: [PATCH v4 net-next 04/15] neighbour: Remove unnecessary EXPORT_SYMBOL().
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.55.0.691.gc56d675ccc-goog

