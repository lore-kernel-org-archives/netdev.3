Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C83A5E9F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712956; cv=none; b=UgMfJhInnskE6fD2256jW2vvmiDUB56SE3IgqjmAffgyvIeeYyr752qC6kb7TrfwpQNTg+AmnyCFmCp1UOWsSoiCWR9OMY+hdkjXfzfos1XfBscdYyB2dGn5clKHGKFsTw2r/dTaC8h96NXPL5J5xjHxfqUIu0MRKUDZWtyeATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712956; c=relaxed/simple;
	bh=JBsYckfEku5rKMm32evMDllAtqvjCB1BnaaIph6HlGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzqFATiuN7q7UkRfiFtf7lPo33yne1gBpErOQX7u4hEbNe6wMxzk4NM8tunPatDXfE8jiyfiStkNnL2c3VGtmHVlE22Pbm6eWjEc/PIwvDFnL3U6ziaU7+8a5SoVByZa0jDVuDAWqNEkNl4E0e00/DmMUiH2SogzdYlnIwmgLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZYvDFdb; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZYvDFdb"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so38188175ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790712954; x=1791317754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xt2wkUp+V4bkFP/iiqMEB0yRaYjpI6dTuvRr3ewoa+I=;
        b=CZYvDFdbcIAjD98X+ItlmmL/mQfP6j3gi68N+SvpcaaFGDGl3BaxcVoUAEun8SMp4e
         DdKUsAvAZY2dPAM0yYsYPDQa50EgB9ZDIaAreEvc1szElWHyqK7TuaUTaDdK+eCNIFRG
         Ve/X0+65e/MyedKNAYo7MNk2DhkMVOJvsaEdnV6A7qLWnFNbU0JETOI9hEz5NsbbCWX9
         OvNk7RxMkSv7K7Q37PBrvm2reR/6KcH0rAEjwYqkNh+YwDhYNSZC0+28DlQ3pK6OLm9s
         d8c0mWyH/RVjlLPeVtwqkt1vH1C5VBGXh6JDIC4/5pQ+7JLK8vz1dyHmIhJusAtMBmuD
         9SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790712954; x=1791317754;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xt2wkUp+V4bkFP/iiqMEB0yRaYjpI6dTuvRr3ewoa+I=;
        b=ogHbCsIGX8+rlM+wU7YAaGgWUZiJaX9pzAm96+GfG+8cNoV8TEzZaZE8QpipUxC7tl
         NP4YtIFE9ifJSY/WuIMVm/9TSyR+HQbTiS8025j4hH8jYgva9RtGM+9fEcO4e8e4Fq+F
         Jlmw+6OgyJlM7oNeuNxC93AkzL41sWqR1IirliWj0B+sAY03hGbt1haoVPkJs2TjU+N5
         BqdpBuSXDcGdGpC/tBbTWGUHOb7mPalX5jfKWBWv2Op806Ja2YZhSAEFJCblNpcBv64G
         ns5UNRR95CR2lav6xKk6mXtoorx/2iR2x+IbGRxZKbhXV/PogLjDApnhtQm34Mx0scFn
         KZTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDWA4hIlRtJq1SPnPsity7BCewdpjB94QG6GrdH1MlkUURcY118yx75bM4JxIxruidZtZTPdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIidLNeGRpv8QXPjbL9WMrWJ9s4AGAy9cfLEfD/zdYsQhFydZoe
	hioT5qNHE4a+a+L+sFR0LpPJgs6PZHyV5KP2IzeWh+VVCYPI8G6PUYXtAgaiJfrExYhuEx9Wrnm
	O6M/A3A==
X-Received: from plan4.prod.google.com ([2002:a17:903:4044:b0:2df:ab17:418b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2dd:ad73:5b68
 with SMTP id d9443c01a7336-2e2de4f6f8emr1496815ad.24.1790712953783; Tue, 29
 Sep 2026 13:15:53 -0700 (PDT)
Date: Tue, 29 Sep 2026 20:15:07 +0000
In-Reply-To: <20260929201546.1533268-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929201546.1533268-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929201546.1533268-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/2] ipv4: Batch rt_flush_dev() in netdev_run_todo().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IPv4 uncached routes are linked to the global per-cpu lists,
rt_uncached_list.

When unregistering a netdev, rt_flush_dev() iterates over the
potentially long lists to find uncached routes tied to the device
and swap it with blackhole_netdev.

Since it is called for every device in dying netns under RTNL,
it adds O(N_dev x (N_cpu + N_route)) costs to any batched device
unregistration.

Let's call it once per batched device unregistration without RTNL.

Note that rt_flush_dev() must be called after setting dev->reg_state
to NETREG_UNREGISTERED.  Otherwise, because rt_flush_dev(NULL) runs
without RTNL, it could race with unregister_netdevice_many_notify()
and prematurely purge routes for NETREG_UNREGISTERING dev, for
which flush_all_backlogs() has not been called yet.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/route.h |  6 ++++++
 net/core/dev.c      |  3 +++
 net/ipv4/route.c    | 11 +++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 6b55de2e4df8..3fccd31eb74d 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -129,7 +129,13 @@ struct in_device;
 
 int ip_rt_init(void);
 void rt_cache_flush(struct net *net);
+#ifdef CONFIG_INET
 void rt_flush_dev(struct net_device *dev);
+#else
+static inline void rt_flush_dev(struct net_device *dev)
+{
+}
+#endif
 
 static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
 				       struct flowi4 *fl4)
diff --git a/net/core/dev.c b/net/core/dev.c
index a8eb382f40ca..9cedc17b5bdc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11838,6 +11838,9 @@ void netdev_run_todo(void)
 		linkwatch_sync_dev(dev);
 	}
 
+	if (!list_empty(&list))
+		rt_flush_dev(NULL);
+
 	cnt = 0;
 	while (!list_empty(&list)) {
 		dev = netdev_wait_allrefs_any(&list);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7da2f1acbb5..1b641901f10d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1587,6 +1587,9 @@ void rt_flush_dev(struct net_device *dev)
 	struct rtable *rt, *safe;
 	int cpu;
 
+	if (dev && dev->dismantle)
+		return;
+
 	for_each_possible_cpu(cpu) {
 		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
 
@@ -1595,10 +1598,14 @@ void rt_flush_dev(struct net_device *dev)
 
 		spin_lock_bh(&ul->lock);
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
-			if (rt->dst.dev != dev)
+			struct net_device *rt_dev = rt->dst.dev;
+
+			if (dev ? rt_dev != dev :
+			    READ_ONCE(rt_dev->reg_state) != NETREG_UNREGISTERED)
 				continue;
+
 			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
-			netdev_ref_replace(dev, blackhole_netdev,
+			netdev_ref_replace(rt_dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
 			list_del_init(&rt->dst.rt_uncached);
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

