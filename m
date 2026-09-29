Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB025771
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712956; cv=none; b=EBcQhjofqIZqLy3w6omT+PnTpbs4ZgJP14WNEWY6djggdpQVrlR4zDbA2jVgYyUKyjv89jeAHR6c2JQdD73SACIC5OXHW3l0T+wY6YZ/+BWm9jVxsIkYpnm5C1GueDw1tYduD9H/5koocJ9YFnWpSWq7fwBTrbIIW/afAF5ZSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712956; c=relaxed/simple;
	bh=js83jNlomQKu6F26IS6B5hMXwOhbsah5XFewzvqlHY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qiTCTedR7QEQsl+rPO7kKS9W171TB0oY4Sp/6vWgJbwexyoZRo3iks+ndJ0N0iZ/D/Lou6mhPEG2axPIVEVp0jv8uA8aocqPHwpbjgoNLEiVJd0pmPnDfbnMGPMJcSbcU52jH3AG2bCq66a7946gzp+aDFbEqY3Q0AJ7WLB02fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hchu8d64; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hchu8d64"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so43841985ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790712955; x=1791317755; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irAlRf8RxboJXAm86r5aGyKHO1MFXpezbnJ0NmxYytM=;
        b=hchu8d64YdOLmibZXoo7dRA7mdB6iHx1fygQEeucuOEM8tYb/oojfDMF/KuRyuEGRU
         VEiWePa7RiZ8MFjakN00r/Tvo820aHLHp+zaB1/6HveWJANxhhg1ILgP/HICu2FoClwo
         s2zuPw4m9aunfHYJrgV1tY/1S6U/UyHUoNiYy6GC2MUkQ6iEhmMDP1xupLKok5WwwW5u
         6wpG+hBOBogaUlIcFxvY3bLKVj69yw/BjZxD/JQFpYvZujCsnaXRIo+QpjZ0dPVt96y2
         OmRB9IRhVdWzzw9lbSInr6T+W74s75t70N005YO7dDHz/t4mCMYXhpqL3L4uKjg0USF6
         nSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790712955; x=1791317755;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irAlRf8RxboJXAm86r5aGyKHO1MFXpezbnJ0NmxYytM=;
        b=R8ne7XhtjU3KF4a5fNq3eveySyRiFzKtf2p3mdM02fL04R+FuJ1Dm8LWWIJ6l/O80e
         ppz1IYAFE2coR768Xrq0Q1N8o1VGVj3B9IOmJHkNDDA/PkGZVTqrm0HBSFO9Cn4RpdTM
         +8X5wpQasKVKCObhlY2LQ1ddmUuGTAiafQJbc+uOZC3RV0tz6auHIkzeO7An0bQjPC1P
         GJppFEQpAif3wBGOjtFYftEIMEz7ctgC2E22fhQ2z4IcbnVlR6A4oL2SWFNuRYObgUhx
         f8VXoa+RNMk5NF2U93rFPDAVI/sW/NFtL2RxSlcrVJKmtVF1xp4ydx3Rap7nYdYoNq/z
         if4g==
X-Forwarded-Encrypted: i=1; AKwUvBxtcFct8a2/2SY9qLOSBbdutkYL5hWn/cjcA0sq5quGKpnhhXITkXMAeVhtRo7KZi+5dyTel4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBemEx2FKknbh7J+HfnzE5nqVcd5YSVv1hjJflSbgnPm534DNA
	9KZ90yeI3GJOFGSBf/y3FBgJnawI3+9xPxTnCZYBbvPMp4wj86gZW5zxr3gnXQeJDd1bn8A5qww
	YYJDYSg==
X-Received: from plgq13.prod.google.com ([2002:a17:902:eb8d:b0:2e2:c975:eb50])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:2dd:c100:424c
 with SMTP id d9443c01a7336-2e2de502bd5mr1927175ad.48.1790712954653; Tue, 29
 Sep 2026 13:15:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 20:15:08 +0000
In-Reply-To: <20260929201546.1533268-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929201546.1533268-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929201546.1533268-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/2] ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IPv6 uncached routes are linked to the global per-cpu lists,
rt6_uncached_list.

When unregistering a netdev, rt6_uncached_list_flush_dev()
iterates over the potentially long lists to find uncached
routes tied to the device and swap it with blackhole_netdev.

Since it is called for every device in dying netns under RTNL,
it adds O(N_dev x (N_cpu + N_route)) costs to any batched device
unregistration.

Let's call it once per batched device unregistration without RTNL.

Note that !ul->head.next must be checked in case disable_ipv6_mod
is true or boot fails before inet6_init().

Reported-by: Chris J Arges <carges@cloudflare.com>
Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip6_route.h |  7 +++++++
 net/core/dev.c          |  4 +++-
 net/ipv6/route.c        | 18 ++++++++++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 0f9b7a260d25..b9de335b639a 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -231,6 +231,13 @@ void rt6_multipath_rebalance(struct fib6_info *f6i);
 
 void rt6_uncached_list_add(struct rt6_info *rt);
 void rt6_uncached_list_del(struct rt6_info *rt);
+#ifdef CONFIG_IPV6
+void rt6_uncached_list_flush_dev(struct net_device *dev);
+#else
+static inline void rt6_uncached_list_flush_dev(struct net_device *dev)
+{
+}
+#endif
 
 static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 9cedc17b5bdc..0b3213ff56e7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11838,8 +11838,10 @@ void netdev_run_todo(void)
 		linkwatch_sync_dev(dev);
 	}
 
-	if (!list_empty(&list))
+	if (!list_empty(&list)) {
 		rt_flush_dev(NULL);
+		rt6_uncached_list_flush_dev(NULL);
+	}
 
 	cnt = 0;
 	while (!list_empty(&list)) {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a76869ff87cd..38261775e713 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -158,14 +158,20 @@ void rt6_uncached_list_del(struct rt6_info *rt)
 	}
 }
 
-static void rt6_uncached_list_flush_dev(struct net_device *dev)
+void rt6_uncached_list_flush_dev(struct net_device *dev)
 {
 	int cpu;
 
+	if (dev && dev->dismantle)
+		return;
+
 	for_each_possible_cpu(cpu) {
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 		struct rt6_info *rt, *safe;
 
+		if (unlikely(!ul->head.next))
+			return;
+
 		if (list_empty(&ul->head))
 			continue;
 
@@ -175,19 +181,23 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 			struct net_device *rt_dev = rt->dst.dev;
 			bool handled = false;
 
-			if (rt_idev && rt_idev->dev == dev) {
+			if (rt_idev &&
+			    (dev ? rt_idev->dev == dev :
+			     READ_ONCE(rt_idev->dev->reg_state) == NETREG_UNREGISTERED)) {
 				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
 				in6_dev_put(rt_idev);
 				handled = true;
 			}
 
-			if (rt_dev == dev) {
-				rt->dst.dev = blackhole_netdev;
+			if (dev ? rt_dev == dev :
+			    READ_ONCE(rt_dev->reg_state) == NETREG_UNREGISTERED) {
+				rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 				netdev_ref_replace(rt_dev, blackhole_netdev,
 						   &rt->dst.dev_tracker,
 						   GFP_ATOMIC);
 				handled = true;
 			}
+
 			if (handled)
 				list_del_init(&rt->dst.rt_uncached);
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

