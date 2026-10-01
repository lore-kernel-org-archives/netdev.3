Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26452B1F3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887682; cv=none; b=CpFwUhEKJUQsfnMsKN6Fnb8vnCQNLt5A50Dg/Fr4sn3I034skGOAx6HeF9G4nwoubChGaMbeaO0hsSGic+33NEHLJPLRtCqhqY3SVNwN8K1GLgz1nU/NrT59UNPVM4ymthtLnVQFVxratFVJXrzpkA5W6Ma0fEVnz2z2+fjloC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887682; c=relaxed/simple;
	bh=9aCdRjsrjiMBxN4t9l2qxonFJjOvemJjazVsc5P/u8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3xdD8IApKpvh4vExQSgP4zI4qGLN78yhPDhq+Eq7koGwxW3eS9ZhcUYZQ+/vuRX7iNzjzFQYc3JrLnCMf4XDfF1eSulvepz44T6fenxD8FOzvIg5spn0vg2muWBiJeCPiZzc7zdZaZPiaZK1/iRSqlnG3MwQUbttV+VTtTBgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVuvnQno; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVuvnQno"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb48f41343aso839711a12.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887680; x=1791492480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjn6+rH7myWaYLMNxYCasSYllBxCI0u0SP9qsZ8+fRQ=;
        b=HVuvnQnovUxMPaCaEO7rY8Ng18fYY32tROdI/bBLWXLRoDqoOn+3khcRr/hWvtzrOL
         SCqNZsOtYAmaBOBaZJBGCKB8IJNPKcWKXN3xqtyGrDU+nZzZXEg+IVKo4oR/HeTgQmKA
         abFet3fQ+pNbEOE7pOt0805r1NYqM52MgDgnusH93P8kyMdSZ+PoN5GYY4tBn1oxWI6i
         nnczhrbr/1MeU7cgm1N1mqt4YBJiB63a+O8IdNuAY1UH3S5AVHt7tmSf1JoDY1SRfK+8
         v7sP28P07+o39nIZu/tNpT5A1NTMfNa7cYEZeqgVkfbKB14vrr0kvdo7O7XB7OHy0p2J
         cX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887680; x=1791492480;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fjn6+rH7myWaYLMNxYCasSYllBxCI0u0SP9qsZ8+fRQ=;
        b=QTKEDAuEZir3dQm9lkFcfJypm0OmwFMow4hofr+JmZgJ3vg3MABz961suUmITd5eOO
         xsy74wKjEuolvVrWf67k1hbKD1r0URoFUoNuC1HcepJjtc6F4D71aiLg12VZyRBsbDnW
         bf0UThSNEeL30ootSugL5vasNA9yYjqSgEk0byDULtfrunUwEGshZim7bSaXdj7xtrQ0
         9xZwU9bo0kfxohUVDdHUOVsx1b2qbO1S2lByTZqY6JIRAPz8TYWGUEKQOiyl20jiXxaL
         k/h5n7rRXAqnSkoHUq5to0GP44ekz6p4Z1qLdbSSJ7NwYgZDcQVznCQ3PoIVmP35Ifo4
         Iemg==
X-Forwarded-Encrypted: i=1; AKwUvByFMRLI2twy1rNdKABOoIptBa0fdheGHLzoX2W1JajVWbXj/IU9EqhtG+gDmVptnE+20gn+FeY=@vger.kernel.org
X-Gm-Message-State: AFuF++m5BJMW1qdmdK1WOtKQDdigOrREU5ETOlPbeb1C/mgdTttSe0/l
	tsHwYb0ecxADWC253Kk7yhHPjOUYnIKATgrWk1BaYZgzbOAFqLWFkuuT/dizcN1H+959AQ7eHAW
	7A+lAFQ==
X-Received: from pgch19.prod.google.com ([2002:a05:6a02:5093:b0:cc7:d7c0:9625])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4002:b0:3d8:e57a:5a5b
 with SMTP id adf61e73a8af0-3e0bc9ebc99mr316596637.5.1790887680220; Thu, 01
 Oct 2026 13:48:00 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:17 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 5/6] ipv4: Batch rt_flush_dev() in netdev_run_todo().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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

Reported-by: Chris J Arges <carges@cloudflare.com>
Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/route.h |  6 ++++++
 net/core/dev.c      |  4 ++++
 net/ipv4/route.c    | 11 +++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

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
index a8eb382f40ca..7dba0292f052 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -129,6 +129,7 @@
 #include <linux/ip.h>
 #include <net/ip.h>
 #include <net/mpls.h>
+#include <net/route.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
 #include <linux/jhash.h>
@@ -11838,6 +11839,9 @@ void netdev_run_todo(void)
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

