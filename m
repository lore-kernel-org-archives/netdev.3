Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB552F28A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887683; cv=none; b=sEHSf2wNxxWlLgTy12eNPGrffOoiY6OBJEpne+78xzmkhThbjiqFgKdbJmH5MFzUseLvtanCl5xLnChzfu/tjfSRvmWc33YseXZd44Yi5yq8NCGbWZjfRXdcs2THTTP14OYAkuKJZxy+PHhMF61h7KQiWHIBRBfNktG435UnkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887683; c=relaxed/simple;
	bh=NGXFPdmiChrdE5M6SWAs0iRQDUcZdzCb8S2NQm3+3To=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVLZpvv0c0clZFLFXNSEPLkbL6pOZ99mOe6ehEln8CepD9nqmOvHS2rzTLb9o7Twhq4B+V9xPuK+9+CcIB22SfDeQyO/ZSxn7/zutDbLUsXalITmY7bG8tr1whtOKunK06ZchdAM1/KbbiWOeAkJM5LAdLi9w2tlpiif3sUx1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Px7xVyDK; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Px7xVyDK"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-868db1b2c64so5909450b3a.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887681; x=1791492481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u12zhQ1tGLgxlzTIA7n/qwZL64gU1GN/BcHRBiw/9vw=;
        b=Px7xVyDKdhGIoZ/f1ZDWtuU5ulShsDm/VM1F9Z3Y10P0ACWQN/Q7X2pAUMmPVOfUAR
         Uez4yoOumqRSAbtNgQqaOEAl1KFK8Yc3sTupSgtfWgl1sVuQVhES1MJddb5+JFofEIH8
         Xm3IoXOP/DVcFCv70vTb+Onkv8J3cBSudWcYjEzTcGxi6aQWJr1hD57BW+TDcVIMFsRa
         3jP++IVqAdYlHeQ3qEFGLOSowXUmDoS3WiqVPMXM813KAXOPB9LKfeCesiuZnh8YRqWB
         Cm7fr3zhCYPGpoJ4qO2h+0OrY8yyk4ZRL8cK6cPphkcP19Wqb0Fwsw7XkaQBi9u3hk4I
         JYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887681; x=1791492481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u12zhQ1tGLgxlzTIA7n/qwZL64gU1GN/BcHRBiw/9vw=;
        b=URlb8HCp4iEK7WYuOrbWQ58oKbSw+V90SU4HLbMo+YGzUw4s41VYJdPwSr6VO6zNWF
         bLucCDd6PABG46Hnwtww+s9gMn/Z+0cKreulq3wd7xomemFuAG6sw4YuQUFLYPvDUqxD
         ojcEmz8GuleYqixlRDlkuqy3/DJyEnM3IG1aQzoISWRit7e5VOHEPXl8u0ZRPeuvf4vU
         XSmdGLPFeeh35FVJ6bqmkzpmVoo1p0fP+t6ba0EzUG1Knxn3/3BNV9m3qrBMG38YDz4l
         QtikfGd1k9RhIDyrTroHM+psTk6KnxqSIsWeaIesAbbFX8lDyoK5tmjcctzli+uy+ZGd
         anUA==
X-Forwarded-Encrypted: i=1; AKwUvBzpdWVwPIhyFdvwEttMQDq5y32m99BJWF7KkiOXgmmiG0Er2W+Z7MGUOwv6fZJh9/Y59Wyz+QE=@vger.kernel.org
X-Gm-Message-State: AFuF++lVnTFNfiE6yANZ+djXYoe9gE4CL5W6qAiElvPgHZvYRuSErSyx
	gJwCU4mc7qGPqf4qkEuB9rxGx+Or1Q1KHe5UAYU6GmU96dFzwqSX0ervXBB4lsBXOt5RE9lvZhR
	Yc2hVBg==
X-Received: from pfbdn5.prod.google.com ([2002:a05:6a00:4985:b0:87f:22a2:2139])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d5:b0:873:5267:dfd0
 with SMTP id d2e1a72fcca58-88af3cc63ffmr666058b3a.5.1790887681040; Thu, 01
 Oct 2026 13:48:01 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:18 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 6/6] ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IPv6 uncached routes are linked to the global per-cpu lists,
rt6_uncached_list.

When unregistering a netdev, rt6_uncached_list_flush_dev() iterates
over the potentially long lists to find uncached routes tied to
the device and swap it with blackhole_netdev.

Since it is called for every device in dying netns under RTNL,
it adds O(N_dev x (N_cpu + N_route)) costs to any batched device
unregistration.

Let's call it once per batched device unregistration without RTNL.

Because it now runs without RTNL, rt->dst.dev and rt->rt6i_idev->dev
may transition to NETREG_UNREGISTERED at different times.  Thus, we
must check that both devices are blackhole_netdev before unlinking
the route; otherwise, the remaining device reference would not be
flushed when the other device is unregistered.

In addition, since netdev_run_todo() runs even when IPv6 is disabled,
rt6_uncached_list_flush_dev() must check ipv6_mod_enabled() before
touching rt6_uncached_list.

Note also that netdev_run_todo() cannot be called before
rt6_uncached_list is initialised because:

  1. unregister_netdevice_many_notify() panics when
     dev_boot_phase == 1 (net_dev_init() is subsys_initcall()).

  2. the only device registered before fs_initcall_sync() is
     loopback and loopback_net_init() panics in case of failure.

Reported-by: Chris J Arges <carges@cloudflare.com>
Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3:
  * Unlink only when both devices are blackhole_netdev
  * Clarify netdev_run_todo() does not run before
    rt6_uncached_list is initialised
  * Fix CONFIG_IPV6=n build
---
 include/net/ip6_route.h |  7 +++++++
 net/core/dev.c          |  5 ++++-
 net/ipv6/route.c        | 24 ++++++++++++++++--------
 3 files changed, 27 insertions(+), 9 deletions(-)

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
index 7dba0292f052..12a0e7d6567b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -131,6 +131,7 @@
 #include <net/mpls.h>
 #include <net/route.h>
 #include <linux/ipv6.h>
+#include <net/ip6_route.h>
 #include <linux/in.h>
 #include <linux/jhash.h>
 #include <linux/random.h>
@@ -11839,8 +11840,10 @@ void netdev_run_todo(void)
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
index a76869ff87cd..b1dcb5e5da88 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -158,10 +158,16 @@ void rt6_uncached_list_del(struct rt6_info *rt)
 	}
 }
 
-static void rt6_uncached_list_flush_dev(struct net_device *dev)
+void rt6_uncached_list_flush_dev(struct net_device *dev)
 {
 	int cpu;
 
+	if (!ipv6_mod_enabled())
+		return;
+
+	if (dev && dev->dismantle)
+		return;
+
 	for_each_possible_cpu(cpu) {
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 		struct rt6_info *rt, *safe;
@@ -173,22 +179,24 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			struct inet6_dev *rt_idev = rt->rt6i_idev;
 			struct net_device *rt_dev = rt->dst.dev;
-			bool handled = false;
 
-			if (rt_idev && rt_idev->dev == dev) {
+			if (rt_idev &&
+			    (dev ? rt_idev->dev == dev :
+			     READ_ONCE(rt_idev->dev->reg_state) == NETREG_UNREGISTERED)) {
 				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
 				in6_dev_put(rt_idev);
-				handled = true;
 			}
 
-			if (rt_dev == dev) {
-				rt->dst.dev = blackhole_netdev;
+			if (dev ? rt_dev == dev :
+			    READ_ONCE(rt_dev->reg_state) == NETREG_UNREGISTERED) {
+				rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 				netdev_ref_replace(rt_dev, blackhole_netdev,
 						   &rt->dst.dev_tracker,
 						   GFP_ATOMIC);
-				handled = true;
 			}
-			if (handled)
+
+			if (rt->dst.dev == blackhole_netdev &&
+			    (!rt->rt6i_idev || rt->rt6i_idev->dev == blackhole_netdev))
 				list_del_init(&rt->dst.rt_uncached);
 		}
 		spin_unlock_bh(&ul->lock);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

