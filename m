Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283963ACF0A
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540683; cv=none; b=sg5EvW8yQ0Ij8ymd/Szm2XhevkWbNqyqdyYsFo5QeLgJ+wK4QGI/BOXAhK713mDjRVPjLPFOwzS7J/1oy83/fN+k1GL5cVMTzk7F8AEvxNfcWPUykSLhEWzABTSErctMBG0bXGcTkwBd669d/h2cYARu+L82AFc+44cT46lNEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540683; c=relaxed/simple;
	bh=rviC/GzkaoeGgZ0E2urn+/27m0VK4ZHIUECGlesZkwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tL8njVW8e7oP3FBQKMjgLKpNm34kzTYYXoSdEcQdkuTq0txDMPKQq3ahm5zpBwh8K4QUbmqj2AdIk8GPUmm8xvPKTAcrVDemmlc5Vu57UF4Le5tO5CfsL+OdfQ6LK8uS9CQf6rFRXlsz36czAN16DDgOY7TpMSNdXg2O+OWTsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1UPuuPJ; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1UPuuPJ"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1760682a91.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540681; x=1791145481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxbyZvUjnydyA9udw2bwD3xkHp0mEg7uaaqJi6g0bT8=;
        b=K1UPuuPJ//86EFxl0B+QRYQybRdJvUVMAVLZEt0ciCfA9i0sPAOZl1jXB4OFgsmZJQ
         3jv9qfWkjGtn3OxDQuG+6QPEwB0vD3vSjJwjHgRDneihVtn6tzL5abzlymPUARibERpq
         FUh0grJ0mta2XZD/fJUk7mE5afuiYk5uE5C43Bk2nZsT9hW1EltwW/CjreXBIpUrx2PW
         TG5WuDhVD4gBgFyQCuZqRdaqt2ktYjO1obJb31a1VJuEhAwoB0wkLA3M9IthvOA87CzK
         HA2jGFnPmyLy6XclO/j50bgL77yCbWlSAkL6lmtTLCO9vy2ywoq6YFGEuSYE19XtfcC7
         sHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540681; x=1791145481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxbyZvUjnydyA9udw2bwD3xkHp0mEg7uaaqJi6g0bT8=;
        b=xcUrjice/4ypoiMFv8a0N1VeJ88SuOaXBjNk+3UXEo+vzi7k3CNHPrW2n2uZu3BV7z
         yEOyRPU4q4XEy/Fha6i/t2kc0JBZQzMcy63XK29dljjQ0t34TkdPLU383bKbtTQ8tY6n
         aKVU94bLVf9V+QFWGDm2jcc73iewYGAdqiRrqbtOFu53phdr+P3Xa1J+hq59PrLVAj2G
         Zv2HED1pXaeOzWszlpVGwtEjaPSW3Xpx5sVGvfdFcZ8TOfrrQiyJxTw+pyIpQV3/xx5n
         YpTV0BX+KX7tA1JnABBD+h96SUH7SfcpC93acOJuBwQ3DYOuYRIsahCMs5XdRtPRDjwO
         GWjg==
X-Forwarded-Encrypted: i=1; AKwUvBzL0Yj/53i5u/pb+sMqdbS0rIZ28ZmGKqcEA6KINEiES2eU7X11HZUieTzLj8PB7ErJBDFubxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIaDMXm1cunEAQIKzJ0aeSBU27HS/ji5UNxKrOB6HAwPBsT29u
	06BeAuqeS+k7I9nt9v3w/B5/Gg63r5V/0Ev136ESn5usNzSReS/eohpwdN7YLzWvRYq3KozxPUH
	otnSoCA==
X-Received: from pgbfm27.prod.google.com ([2002:a05:6a02:499b:b0:cc7:6138:fe1b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0f:b0:39e:6a81:5a98
 with SMTP id 98e67ed59e1d1-3a098e3994cmr9054115a91.44.1790540681112; Sun, 27
 Sep 2026 13:24:41 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:41 +0000
In-Reply-To: <20260927202429.2452589-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/5] ipv4: Batch rt_flush_dev() for dying netns.
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
it adds O(N_dev x (N_cpu + N_route)) costs to netns dismantle.

Let's call it (almost) once per cleanup_net().

When rt_flush_dev() is called with NULL from ->pre_exit_batch(),
it purges every entry in dying netns, reducing the cost to
O(N_cpu + N_route).

Since ->pre_exit_batch() is called before synchronize_rcu(),
we must prevent adding a new route for dying netns, so now
rt_add_uncached_list() checks !check_net() and swaps the device
with blackhole_netdev.

When rt_flush_dev() is later called again from fib_netdev_event()
via NETDEV_UNREGISTER, it just returns.

Note that net_pre_exit_done() cannot be replaced with !check_net()
because:

  1. some ->pre_exit() call unregister_netdevice() before
     fib_net_ops (e.g. ovs_pre_exit_net(), l2tp_pre_exit_net()).

  2. ->dellink() could call unregister_netdevice() for another
     netdev in a dying netns queued for the next cleanup_net()
     batch, for which ->pre_exit_batch() has not been called
     yet (e.g. veth).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c |  6 ++++++
 net/ipv4/route.c        | 28 +++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8a3dc04e8cac..b8d76b6279e1 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1685,6 +1685,11 @@ static void __net_exit fib_net_pre_exit(struct net *net)
 	nl_fib_lookup_exit(net);
 }
 
+static void __net_exit fib_net_pre_exit_batch(struct list_head *net_exit_list)
+{
+	rt_flush_dev(NULL);
+}
+
 static void __net_exit fib_net_exit_rtnl(struct net *net,
 					 struct list_head *dev_kill_list)
 {
@@ -1704,6 +1709,7 @@ static void __net_exit fib_net_exit(struct net *net)
 static struct pernet_operations fib_net_ops = {
 	.init = fib_net_init,
 	.pre_exit = fib_net_pre_exit,
+	.pre_exit_batch = fib_net_pre_exit_batch,
 	.exit_rtnl = fib_net_exit_rtnl,
 	.exit = fib_net_exit,
 };
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7da2f1acbb5..cbe328b3f254 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1554,14 +1554,29 @@ struct uncached_list {
 
 static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
 
+static void rt_replace_uncached_list(struct rtable *rt)
+{
+	struct net_device *dev = dst_dev(&rt->dst);
+
+	rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
+	netdev_ref_replace(dev, blackhole_netdev,
+			   &rt->dst.dev_tracker, GFP_ATOMIC);
+}
+
 void rt_add_uncached_list(struct rtable *rt)
 {
 	struct uncached_list *ul = raw_cpu_ptr(&rt_uncached_list);
 
+	/* Set once and never cleared: non-NULL marks an uncached route. */
 	rt->dst.rt_uncached_list = ul;
 
 	spin_lock_bh(&ul->lock);
-	list_add_tail(&rt->dst.rt_uncached, &ul->head);
+
+	if (check_net(dst_dev_net_rcu(&rt->dst)))
+		list_add_tail(&rt->dst.rt_uncached, &ul->head);
+	else
+		rt_replace_uncached_list(rt);
+
 	spin_unlock_bh(&ul->lock);
 }
 
@@ -1587,6 +1602,9 @@ void rt_flush_dev(struct net_device *dev)
 	struct rtable *rt, *safe;
 	int cpu;
 
+	if (dev && net_pre_exit_done(dev_net(dev)))
+		return;
+
 	for_each_possible_cpu(cpu) {
 		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
 
@@ -1595,11 +1613,11 @@ void rt_flush_dev(struct net_device *dev)
 
 		spin_lock_bh(&ul->lock);
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
-			if (rt->dst.dev != dev)
+			if (rt->dst.dev != dev &&
+			    (dev || check_net(dev_net(rt->dst.dev))))
 				continue;
-			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
-			netdev_ref_replace(dev, blackhole_netdev,
-					   &rt->dst.dev_tracker, GFP_ATOMIC);
+
+			rt_replace_uncached_list(rt);
 			list_del_init(&rt->dst.rt_uncached);
 		}
 		spin_unlock_bh(&ul->lock);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

