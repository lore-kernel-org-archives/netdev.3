Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398449DBAA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287615; cv=none; b=uKhU1OJLpdaAC5Nf0K9SWKsx2ONHXx8LZZgdh1jPzZzoIM94XT8tsjFDW3NaUggI4F/08yBU/lAHnJ5ZI9EsgRgixZ+d1t1FHmqzM9rhad+mm0LCgp4/jbtGL48vwnqxnpjT//oS0PJTyUdC/uBME3bUPuAWqY3n9GpBO51Z9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287615; c=relaxed/simple;
	bh=mbc0habY+J+4HHbaAr3RQdyZpKJnTeNJabzk/LAzIKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l2yetHgvxV9n6catwsfoNqQZca8jzVkywWPBk6LieL6+JIzXtMUu180ADN85iY9/9ZvmAN1h36AmqRrpQ35notlPNcAu7OnXTnAayOa4kTppM0OVfZYtzpG81AcxT3AnHFH/SfpF5Hnm/x3hbQCbsc7VVt07Y3DI6rAdnAlTJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKH6Athr; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKH6Athr"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b10so242681a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287613; x=1788892413; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFJjRdoSd/aYOAGz+d0Mf+LQais5f7F02HwpUM8/wYk=;
        b=HKH6AthrpDNwlBURT6JAlt0ucuSsUBWc4ClfEpI+2gwQFNOIRvWEmYAMzYYDA3VfZm
         IGrWhrqX0rt7NTLXUSnAoMuQBEgHGHjYjQJOK3SegitBSS5tLDxCWaaolzVpDGwUSG6p
         u+nTyePN3aWugVp5abPXfN2QcTAUgIyo3MsoYMBvyeW1AWQJTk/qPKHVXYREv/w9Z0UE
         jcpKH5wT/EKhvYU87wKAY9d8rqMjn93Bma14uzF5fTfh1C98EYcJO/mh8Fwvq5dz199o
         hJM6qzoau7kCgzMS26ILkA1eBef/vTqYrrD9f4PiZjy+Nh93311s72PKYcJQSiKAzIlB
         GSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287613; x=1788892413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFJjRdoSd/aYOAGz+d0Mf+LQais5f7F02HwpUM8/wYk=;
        b=eaww3XgjEYemc1UZLuDOOOJDhqEHQN8P5/HKWCijn1lDxsvzsBDtugxLqgvij1YWvi
         n/7wvLi644HzKYNLyQZGGu0q6eYAE2ZmEcY34SdOrgZDawszsUDEMQ3AJYdcsuVHkRmx
         Xc0w8vPtU1OLpEAFxHQHUPit0CZLe2e/SPtASosRFIQRu/wRG9D6L/ucb4PUzhCQ1kPq
         ODP+IVJLDcQnlnC15B9FOu1v7b4j4FNkOfWdPsUX2T4z5ziqZ94lUEfMjxPBOP7gCnFp
         7t2YlpcBjGnmNyfiFQ6vlbia3rwTeTTtw45Y7whSblSGo0XcPaGQDRQhwVNFVW5AscTt
         wRLg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8sEblp122vHfeN5Oz2IkoLxS1V8REG+wdSQxM4c4kSlbr70GuVEyH42gTHM15fV1Yt3b+mU0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVaAzjdxD1mTsKQisl1pNKFWblHbBw0fQiHCMZsYEatm1REaZI
	jckILlqi4phm4yywmBo2m7d4roPpm/8WTweXYW9Q0Esaq038L00hGzp7GONPS8LgL9kkkLJxcHE
	WULuLCA==
X-Received: from pgam10.prod.google.com ([2002:a05:6a02:2b4a:b0:cc1:b85e:b029])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca8:b0:3c4:4272:b400
 with SMTP id adf61e73a8af0-3d984562d03mr37673637.18.1788287613049; Tue, 01
 Sep 2026 11:33:33 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:53 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-5-kuniyu@google.com>
Subject: [PATCH v5 net-next 04/15] neighbour: Remove unnecessary EXPORT_SYMBOL().
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
2.55.0.966.g6673acef38-goog

