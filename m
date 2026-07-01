Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE721A0BF3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876320; cv=none; b=P19MXctMmvvxh8bg/AkkdMoJqwBVMhHG2LD8YqsEHz7d4RUW6G69LWi7q3PD7Ul7DDfhmuuLjlaNcaqcMNBRUlLvXEIVxB3vTfrpT+877pVfXEKmjS05iJQYm06/hQVii09pJR2NxWjRinY2iHRQZYG2LcyrpfzcxYtXWR6ldDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876320; c=relaxed/simple;
	bh=v/+DavR8tRBmPogGEbRLyoYwByy7clgvstIgjdG2E7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJWpuGLOoRwoXPEGuaHe5E+F3NzjyOvrF2KVETikE2chRao3lYbJW7564LOUsGdzNDtJQkwRi6rUhFMoQ+PfyqNks+ngy3/uO0bsISVRE2jfJkkyEM4EbhJk5YnGJksF9eGczPXVFW+WRsPoSL0+SbidDmcIuJ71gNRZSXJdzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyPrKojf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyPrKojf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782876316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NAHIWlyEWl1hlg6uEH0Z3tmc81TasF279IcSkQr1qc=;
	b=tyPrKojfAZh2s3UZst1vhJjj6fIf9WlOAVp8EVR6zKt04IgiK4Wi1rI97PIR3JC4wfrD77
	PlH1VipRks9MKq83uSt6gc3G6RzTc5JlUbl0C/Wj6ZbQqecl1/U8H+/FFII4N9VB7Mpghz
	IVlNyB/O9BsCRMG9t2fFdm00/vhWEG0=
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
Subject: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev under RCU
Date: Wed,  1 Jul 2026 11:24:34 +0800
Message-ID: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rt_flush_dev() walks the per-CPU uncached route list and rewrites
rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
This lock does not exclude RCU readers, which may load rt->dst.dev
multiple times within a single rcu_read_lock() region.

ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
three times to obtain in_dev, the L3 master ifindex, and net.
A concurrent device unregistration can repoint rt->dst.dev to
blackhole_netdev between those reads, making the reader combine
state from two different net_devices — for instance, an in_dev
from the real device but a netns and peer lookup from the blackhole
device.  ip_rt_get_source() has the same problem: it reads
rt->dst.dev four times to obtain the output ifindex, the netns,
and the source address, so a concurrent flush can cause the source
selection to mix state from different devices.

Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
of each affected RCU reader and use that snapshot throughout, so
concurrent flushes cannot cause mid-function inconsistency.
Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
to match the readers.

Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
v2:
- Use dst_dev_rcu() and dev_net_rcu() for the RCU readers.
- Use rcu_assign_pointer() when publishing the uncached route device
  replacement.
- Slightly adjust the commit message wording because this issue was found
  by inspection, not from an observed user-visible failure.

v1: https://lore.kernel.org/all/20260630094250.29386-1-xuanqiang.luo@linux.dev/

 net/ipv4/route.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5..57f38467e6d0c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -873,6 +873,7 @@ static void ipv4_negative_advice(struct sock *sk,
 void ip_rt_send_redirect(struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
+	struct net_device *dev;
 	struct in_device *in_dev;
 	struct inet_peer *peer;
 	struct net *net;
@@ -880,15 +881,16 @@ void ip_rt_send_redirect(struct sk_buff *skb)
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
+	} else {
 		struct fib_result res;
 		struct iphdr *iph = ip_hdr(skb);
+		struct net_device *dev = dst_dev_rcu(&rt->dst);
+		struct net *net = dev_net_rcu(dev);
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
 
@@ -1565,7 +1570,7 @@ void rt_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
-			rt->dst.dev = blackhole_netdev;
+			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
 			list_del_init(&rt->dst.rt_uncached);
-- 
2.43.0
