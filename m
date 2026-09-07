Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE4424D58
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773447; cv=none; b=TGrSmphKnIgVpd2PL48TW9AYhnvkx83xwFMTUB9AtuxD5mlGwhYMiZO9w+UglyeQe7i1Sf0GTmmFeEOyFp6SfOMbUrq8zn+7ihXYQj70xSnFXNP/byw85q2aJVnt36Muw0RjRQujS90GJwQGZVKHYxG5/JKJ9oGeiP1hO+jXFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773447; c=relaxed/simple;
	bh=cd64t0v47rn3Th5A5cRySwyl0xVvV/EJonXAt++B35o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUHhiv4QSDNnwV/ULJpxXaj7QBraEJ6p/q0w1irAGBh9FCdx9M0YEYT3I55YeqoDmqzsHjBxIRNpRKcxsw8aoxo32IoOfwbbimHh+SRA3Fep0pnZApP6MIjp5L8lR6yJj1zi0LvHjo9IiECmeRGvCGElWA0cfpLAHrb61FdWyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=opwVOpfO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="opwVOpfO"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A749C20719;
	Mon,  7 Sep 2026 11:30:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tlgLdps7iGmH; Mon,  7 Sep 2026 11:30:42 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BEAB8201D5;
	Mon,  7 Sep 2026 11:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BEAB8201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773442;
	bh=GWCYwai0ttNgfGoAxZjBFsv9RKP7bg3hnat/3H4+3I0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=opwVOpfOtmTFVer2b+kLDbzSUlvKJJfEnb7NQWrv3ssRT7vijxX3mPo3D6LWwv7U2
	 kwFunqthj/TJSJ4A0R8xRnKUg5J1MxrixUw/KEq92Z7BPV01lbNtjNmeaVXmp7R2oy
	 DqUF2lFrnd95iweFrgHebAso6RfH0oBqFaUIB/7NGLCkahycN0zowTXp4JRGDK+hoV
	 UZpCdmGPsRKTV5qUeIxYobAZxjKVlK55R+d2P/j5H7O/foHEZ05RhVr076sx5DO0CX
	 A+6nln37OjuMMg4/6fM6/d+mD/NYK6S1T/QYQlRgkNdSPhPLUTgHAmpNKIZZwj57eA
	 WbXrnus78HhgQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:41 +0200
Received: (nullmailer pid 2228820 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/12] xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
Date: Mon, 7 Sep 2026 11:29:50 +0200
Message-ID: <20260907093020.2228346-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Eric Dumazet <edumazet@google.com>

syzbot reported a suspicious RCU usage warning in ip6_pkt_drop():

  WARNING: suspicious RCU usage in ip6_pkt_drop
  include/net/addrconf.h:389 suspicious rcu_dereference_check() usage!

  Call Trace:
   __in6_dev_get_safely include/net/addrconf.h:389 [inline]
   ip6_pkt_drop+0x596/0x610 net/ipv6/route.c:4620
   ip6_pkt_discard+0x1c/0x30 net/ipv6/route.c:4651
   xfrm_trans_reinject+0x324/0x630 net/xfrm/xfrm_input.c:806
   process_one_work kernel/workqueue.c:3322 [inline]
   process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
   worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486

When commit 4f4920669d21 ("xfrm: Reinject transport-mode packets through
workqueue") converted xfrm_trans_reinject from a tasklet to a workqueue,
the reinjection loop ceased running in softirq context. Workqueue workers
run in process context where local_bh_disable() does not enter an RCU
read-side critical section under CONFIG_PREEMPT_RCU.

Because finish callbacks (such as ip6_rcv_finish) expect to run under an
RCU read lock (performing route lookups, l3mdev lookups, and accessing
RCU-protected data structures), invoking them in workqueue context without
rcu_read_lock() triggers RCU lockdep warnings.

Furthermore, packets queued to the workqueue via xfrm_trans_queue_net()
may carry non-refcounted (noref) dst entries (e.g. from ip_route_input_noref).
Additionally, on netdevice unregistration, dst_dev_put() replaces dst->dev
with blackhole_netdev, so dst entries do not keep skb->dev alive while
queued in the workqueue.

Fix these issues by:
1. Calling skb_dst_force(skb) in xfrm_trans_queue_net() while still in the
   caller's RCU section to ensure dst is reference-counted before queuing.
2. Holding a reference on skb->dev via dev_hold()/dev_put() across workqueue
   deferral so skb->dev remains valid during finish() callback processing.
3. Acquiring rcu_read_lock() around the finish callback invocation loop in
   xfrm_trans_reinject().

Fixes: 4f4920669d21 ("xfrm: Reinject transport-mode packets through workqueue")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Liu Jian <liujian56@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a..8f6109eada7e 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -800,12 +800,17 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
+	rcu_read_lock();
 	while ((skb = __skb_dequeue(&queue))) {
 		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+		struct net_device *dev = skb->dev;
 
 		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		if (dev)
+			dev_put(dev);
 		put_net(net);
 	}
+	rcu_read_unlock();
 	local_bh_enable();
 }
 
@@ -821,12 +826,18 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 	if (skb_queue_len(&trans->queue) >= READ_ONCE(net_hotdata.max_backlog))
 		return -ENOBUFS;
 
+	if (skb_dst(skb) && !skb_dst_force(skb))
+		return -EHOSTUNREACH;
+
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
 	hold_net = maybe_get_net(net);
 	if (!hold_net)
 		return -ENODEV;
 
+	if (skb->dev)
+		dev_hold(skb->dev);
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
 	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	spin_lock_bh(&trans->queue_lock);
-- 
2.43.0

