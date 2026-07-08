Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632437D11F
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490806; cv=none; b=WLZmWF5SEmw1jst6db6OqSs18xJwVF2NJE8W5TUElrfUtcQb/quzvYkRP2AnWXeRjA6R3qjJ2dWzA8q5DI6ZDlaCFHFkZ9vuKmp3WyxO7YmJSTW5v4SdEvSWMVZIcia7jSN23iwNuAcYQpRhcvqAtCoMyQyDn19JqHYlCLFf9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490806; c=relaxed/simple;
	bh=cJAKCsATZu1hv6z4ZbiF7Btxv6VeiniLdNRhSY8UXCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndoxlwKV9ukp/2QSxMd526/JXqyKUYWXGwVREmLadYDqLqBAFOfdU9Ghcn29EzbNBE8I28NkTqQNuykvNWDLNRKsuD9KCg73W+ScY5dk+ZVf7IKTy9JNYz7/hwmjafhN5qmIEB3zSuhkHFWeuWu7XtvI7AU6WEcyntIhIK9amJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jojbmrBi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jojbmrBi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783490802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCj9Nnj2Mldbj02SmTcTXwvZVO75xuL0hZ3WqcMIS0M=;
	b=jojbmrBiVYDRlWy6EYAO/pY6uH0o0estbGyedKzSDvIJi3UvWSoYrheT/ogzoKWWbrXvPy
	qhw8VFN4QsCMIDh9vv9UomROQjh6iJxBcI40J/yVgmu9KmjQG2R9Ku2EFaSY9CPFyuzGZ1
	TKroHwwYeD7+CKgyPi9ePMq3lKLSJDI=
From: xuanqiang.luo@linux.dev
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 2/2] ipv4: snapshot dst.dev in ip_rt_send_redirect() and ip_rt_get_source()
Date: Wed,  8 Jul 2026 14:05:37 +0800
Message-ID: <20260708060537.17188-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
References: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rt_flush_dev() can replace rt->dst.dev with blackhole_netdev while RCU
readers are running.  ip_rt_send_redirect() and ip_rt_get_source() both
read rt->dst.dev more than once and use the results in one operation.

If rt->dst.dev changes between those reads, the operation can use values
from two devices.  For example, ip_rt_send_redirect() can use in_dev from
the old device and the L3 master ifindex from blackhole_netdev.

Read rt->dst.dev once in these two functions and use the snapshot for the
later device accesses.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/route.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b668375df71e2..4fed07cae7da2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -874,21 +874,23 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
 	struct in_device *in_dev;
+	struct net_device *dev;
 	struct inet_peer *peer;
-	struct net *net;
 	int log_martians;
+	struct net *net;
 	int vif;
 
 	rcu_read_lock();
-	in_dev = __in_dev_get_rcu(rt->dst.dev);
+	dev = dst_dev_rcu(&rt->dst);
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev || !IN_DEV_TX_REDIRECTS(in_dev)) {
 		rcu_read_unlock();
 		return;
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
-	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
+	vif = l3mdev_master_ifindex_rcu(dev);
 
-	net = dev_net(rt->dst.dev);
+	net = dev_net_rcu(dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
 		rcu_read_unlock();
@@ -1287,29 +1289,32 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 {
 	__be32 src;
 
-	if (rt_is_output_route(rt))
+	rcu_read_lock();
+	if (rt_is_output_route(rt)) {
 		src = ip_hdr(skb)->saddr;
-	else {
-		struct fib_result res;
+	} else {
+		struct net_device *dev = dst_dev_rcu(&rt->dst);
+		struct net *net = dev_net_rcu(dev);
 		struct iphdr *iph = ip_hdr(skb);
+		struct fib_result res;
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
 			.flowi4_dscp = ip4h_dscp(iph),
-			.flowi4_oif = rt->dst.dev->ifindex,
+			.flowi4_oif = dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
 		};
 
-		rcu_read_lock();
-		if (fib_lookup(dev_net(rt->dst.dev), &fl4, &res, 0) == 0)
-			src = fib_result_prefsrc(dev_net(rt->dst.dev), &res);
+		if (fib_lookup(net, &fl4, &res, 0) == 0)
+			src = fib_result_prefsrc(net, &res);
 		else
-			src = inet_select_addr(rt->dst.dev,
+			src = inet_select_addr(dev,
 					       rt_nexthop(rt, iph->daddr),
 					       RT_SCOPE_UNIVERSE);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
+
 	memcpy(addr, &src, 4);
 }
 
-- 
2.43.0

