Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E172D97B7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122937; cv=none; b=VdknV5f/9k9t7bbeJ3iseIFu2B+lrrVtPFV4hXn9T3gKOFDXL44001gAcmAf5hLIcJi1+juRP3r1dMHRo2tpT2gWeVOMPe+JhsKC05RlQHZKtzMp76XbOD9ZWBufcj7OmLArQtRULwR53adUmcsKPld6lSg2hLw6Dj6HC9bM+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122937; c=relaxed/simple;
	bh=Nf6+KwXmSvPx6toa2jUyr/PfzSERQxni0ZCupDqdBVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r6hOuv3XTqqv+2ri4htsIbV8+NN5ba/sv5iFpbD3QQW9zQPG7KNRjPj9C092Hm+nSObGDkH5mewq8zgdMnsjW8K/ZAZPjX/qG1QjEJy3krimPeSf9YYrmqNA+WAm/bA3C195MqFy94TPVh4BHzi9qrcgIs26LfTsDe5NAPPwXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ew09n2iE; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ew09n2iE"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so485398485a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122935; x=1786727735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhMBCFTEOpXI0g5V9wXUZYc5UUVpY1tQrhSJqvgKLCA=;
        b=Ew09n2iENl/KEfgSLYcGpGpKEbyl+LYoqbgnx+5TgH5qGWRlEpv38dRV7eEyXGGLb6
         DZNQGZgcniaHhdWCBfqa4XfMTBjrMP+OknirtaaocD4q4fPpMT5lCKLu+4ieibpAAYl7
         Dy9eKXdmzI87wBid1nH0u8meFZoQNpS/WueMRbDV+irua1nx828wFo9/aSX2Ia1bpuDV
         QDzLog/9EKCr0zgnniuKCCvpFxOEVdu62utX/5eVksaPgt42Ch0Q9Dhrcg2n5fHy2J2l
         LPCpSSjNy3L1dvuLcuMqxh4UJN0o17AFSfY6mT3SyGeZV+4431X1cUpQtvjZOrOw3msg
         9aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122935; x=1786727735;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhMBCFTEOpXI0g5V9wXUZYc5UUVpY1tQrhSJqvgKLCA=;
        b=fCVORfqukOApu1N1obutidNU0S3/vcxpX5Fg3LSTQpQ+0Xi5clsuv58iFhERxRMv+J
         rFZka4u4lhb1MWu30iWMPHoPkGpTNNkZCw8X/zWEXiA2pJccQun/b2w81/JBF8ep3zJH
         F7heqyspq5VbD11aUC8Y/tmCwqdDqkyTKrij9DmEsQvPe2+vN3knL/rWVkZxq7ug0s1H
         YrNNNMD28gnDRXkmrgHNiT1btOp+Dx4Akp2LdtNh3LbHHUL9Xym/iljbHhE/M7NVqVA4
         jNe41KKIggCwbnLJTe0GlB6abG13x1LhTg6Mg+UQQPu5i4mZqWulMu76VN7IYhomlx4Q
         J7yg==
X-Forwarded-Encrypted: i=1; AHgh+RpV+iSXb07RapuvfEmTiY74LgYCEwVhqD0UhLhfFg+mBpDBxEueAr13X1qu5HcPnnYRnsQTacs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwigJBED4X4kgZhXma0uYIrsS6dk5wjLqVFlK2dADUhMOZZQfTD
	ArujlfjmEREIUIMBw/Usnwf/jsA6i+JLTL6LCGr6lhqiZFT8CN/5kswuYPEya1A1j3IVEjI4Gp6
	yx3NDqmpPZx6sJQ==
X-Received: from qkaw18-n2.prod.google.com ([2002:a05:620a:a2d2:20b0:920:56cf:20c4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a502:b0:923:7821:dc0d with SMTP id af79cd13be357-93649267a9fmr2324389785a.33.1786122934459;
 Fri, 07 Aug 2026 10:15:34 -0700 (PDT)
Date: Fri,  7 Aug 2026 17:15:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807171533.1904697-1-edumazet@google.com>
Subject: [PATCH net] xfrm: add missing rcu_read_lock(), skb_dst_force() and
 dev_hold() for xfrm_trans_reinject()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Liu Jian <liujian56@huawei.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 net/xfrm/xfrm_input.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a794588b192598851bd77427c8392..8f6109eada7eaaf1c70aa2da610523b42d75b50c 100644
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
2.55.0.654.g21b8a5bc05-goog

