Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C23B774F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540684; cv=none; b=b3kO13K93YDPQIow4B7Zkw1IP4mO+GHFS6r4Kh3CvxzkVlAQ39NnKrsD9ohkluMfner8ua94CG4TLz/H1ylgbXKhxLdlAZiIH5JPwKgja6l0rWkX8vQ0JQ4tia88FS/5hGgc2BJd2PrBgimjAUiaIBcfKQS1kOrPBpDuLuN02hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540684; c=relaxed/simple;
	bh=5oQqZlsdAdQQFiVGtPLf3B8/edF8PNBWde6KX2QYiRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1AmAFlztXsk78Sp1LW8Qe8XX3cHhUHSndk4CysQur33jglv6rk0ZYY15+5OOicNQ6QA1ta5yp1eKtJ6hk3xToszEryVrgFdaw8ZAuPZH1H9GL6e05vVeWCjXPyIOb2xuwnOTxEckXOJrhuWWgeVhNrIkOLnknRULcWqILutFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+sT+ckh; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+sT+ckh"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso2656408a12.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540682; x=1791145482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXFzPCtESlJpidUEerkOiCAPLf1WMF1n9IsF0il7Pbs=;
        b=c+sT+ckhsFoa1+WtR4i4uO7fe2sX2MnUmhpU+pz6UWS9j2aDVPXZWoseMBNM18Px2N
         ZyZmfGy6iw37HTIbqZW1nHtW30JmCVXFdD0MBdndAotuEbJC9SIDLH9WyUKD1xSQc9W5
         z7bpDn39tQaZtXs57N0Wb2z45P+X1W0oYe0mN5T22sutApbAtvfbCivN369ZIQrukhE8
         z0vRERmoMs0E6LYOD/xXSIokcAw5f7LCg0Lc87PUATw5taP3w0f7N15U3Rk69tQlZjHp
         BOY1JrhCB3dEECpKynFMRL2GtOhN3g1OQpx6qrjTD0Z0tLKXs2shD4yaL+Fql6lRA1NU
         lfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540682; x=1791145482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXFzPCtESlJpidUEerkOiCAPLf1WMF1n9IsF0il7Pbs=;
        b=R7AsFZcXLc75HQa9RnUJwU7A+L2UgZGr1kKfQphp63+d6OjEK9Q3Mrg+iKDsdl2CXe
         Kcmyp/GPneVLQa6lpCBy50agCopb6G0VOsI1irRlJ+8It2CCewsiElUVPj7EyFf8Sehf
         0Z3gsfVvjYkgF5epuQFRks8ygzkIxth5ZBVYOsnOLzbZdkWe3pmfcBh+q0AgHn9W6qbg
         ApqS2Z/jpWTJWMAz96HNTnCuxQN2Q+g/0U6jxdOsV44bm2Pr2VrYERQTEztXxgN17/2g
         AyXdPFNKQqSbuIl/jjgV1wFVNOIYwUECiQRNkXu/7Du+BoxTEt+QKiDLiCEVEQ/ZyVAv
         lXZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy43yroVpH5xRMXzGU4ypxzbFA82A8YO3cwfehpO9KOieZ0OzpjPuG2uoSN+QtXH1Kh+2nDkmI=@vger.kernel.org
X-Gm-Message-State: AFuF++ktWyBpraDXuvZipB5sA57Tqzk7Att8XprKk2t2D6o6qaUE/gP2
	G6bYmBLGYdRlIQGNsqm+nEyjAKL31v/yVaW7fdCbImDtx5jx8Y+LLJewPwcKpy46hnw1WyR/BMb
	zxFOrbw==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:cc7:a826:e274])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f8f:b0:3c3:a3f4:5485
 with SMTP id adf61e73a8af0-3de26c0f5efmr6610735637.6.1790540681880; Sun, 27
 Sep 2026 13:24:41 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:42 +0000
In-Reply-To: <20260927202429.2452589-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/5] ipv6: Batch rt6_uncached_list_flush_dev() for
 dying netns.
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
it adds O(N_dev x (N_cpu + N_route)) costs to netns dismantle.

Similar to IPv4, let's call it (almost) once per cleanup_net().

Chris J Arges verified the changes improve RTNL wait time
during cleanup_net() by 75x, quoted from [0]:

  <...> I was able to confirm even greater reduction in contention
  as measured by how much latency an unrelated process takes when
  waiting for cleanup_net to complete. <...>

  Some rough average latency numbers with 36 devices, 160k routes,
  8 vCPUs:

  - main: 137ms
  <...>
  - your patchset: 1.8ms

Reported-by: Chris J Arges <carges@cloudflare.com>
Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
Link: https://lore.kernel.org/netdev/aq2B8PSfjn-xau4V@20HS2G4/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 54 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 475ced827ec5..7747e4f20fee 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -135,6 +135,22 @@ struct uncached_list {
 
 static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt6_uncached_list);
 
+static void rt6_uncached_list_replace(struct rt6_info *rt)
+{
+	struct net_device *dev = dst_dev(&rt->dst);
+	struct inet6_dev *rt_idev = rt->rt6i_idev;
+
+	if (rt_idev) {
+		rt->rt6i_idev = in6_dev_get(blackhole_netdev);
+		in6_dev_put(rt_idev);
+	}
+
+	rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
+	netdev_ref_replace(dev, blackhole_netdev,
+			   &rt->dst.dev_tracker,
+			   GFP_ATOMIC);
+}
+
 void rt6_uncached_list_add(struct rt6_info *rt)
 {
 	struct uncached_list *ul = raw_cpu_ptr(&rt6_uncached_list);
@@ -143,7 +159,12 @@ void rt6_uncached_list_add(struct rt6_info *rt)
 	rt->dst.rt_uncached_list = ul;
 
 	spin_lock_bh(&ul->lock);
-	list_add_tail(&rt->dst.rt_uncached, &ul->head);
+
+	if (check_net(dst_dev_net_rcu(&rt->dst)))
+		list_add_tail(&rt->dst.rt_uncached, &ul->head);
+	else
+		rt6_uncached_list_replace(rt);
+
 	spin_unlock_bh(&ul->lock);
 }
 
@@ -162,6 +183,9 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 {
 	int cpu;
 
+	if (dev && net_pre_exit_done(dev_net(dev)))
+		return;
+
 	for_each_possible_cpu(cpu) {
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 		struct rt6_info *rt, *safe;
@@ -173,23 +197,17 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			struct inet6_dev *rt_idev = rt->rt6i_idev;
 			struct net_device *rt_dev = rt->dst.dev;
-			bool handled = false;
 
-			if (rt_idev && rt_idev->dev == dev) {
-				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
-				in6_dev_put(rt_idev);
-				handled = true;
+			if (dev) {
+				if (rt_dev != dev &&
+				    (!rt_idev || rt_idev->dev != dev))
+					continue;
+			} else if (check_net(dev_net(rt_dev))) {
+				continue;
 			}
 
-			if (rt_dev == dev) {
-				rt->dst.dev = blackhole_netdev;
-				netdev_ref_replace(rt_dev, blackhole_netdev,
-						   &rt->dst.dev_tracker,
-						   GFP_ATOMIC);
-				handled = true;
-			}
-			if (handled)
-				list_del_init(&rt->dst.rt_uncached);
+			rt6_uncached_list_replace(rt);
+			list_del_init(&rt->dst.rt_uncached);
 		}
 		spin_unlock_bh(&ul->lock);
 	}
@@ -6801,6 +6819,11 @@ static int __net_init ip6_route_net_init(struct net *net)
 	goto out;
 }
 
+static void __net_exit ip6_route_net_pre_exit_batch(struct list_head *net_exit_list)
+{
+	rt6_uncached_list_flush_dev(NULL);
+}
+
 static void __net_exit ip6_route_net_exit(struct net *net)
 {
 	kfree(net->ipv6.fib6_null_entry);
@@ -6839,6 +6862,7 @@ static void __net_exit ip6_route_net_exit_late(struct net *net)
 
 static struct pernet_operations ip6_route_net_ops = {
 	.init = ip6_route_net_init,
+	.pre_exit_batch = ip6_route_net_pre_exit_batch,
 	.exit = ip6_route_net_exit,
 };
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

