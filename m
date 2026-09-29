Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F34FE2C6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677024; cv=none; b=tpIthbz4v1wPZl6MBKl/1XAqVib4wWkkaNZ4QOMqNM7z1aaZ0f5qfrIZDhln0jcAW0OFe9/DnQ4TJcHbGrgZlhOkoGVzx+vXMUqH8LvPp/rc8E39FjfFNYmOnAfGW1NaesQY84KxyalKryoAfsn8M2Fuw1G3mZJWKkcjs36+yU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677024; c=relaxed/simple;
	bh=SeO42RFH7nV3OnzzG7BqonOWu5DVWs951UX7NYFZKKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbwAe8/f2EqIw4mSY0Unty35p1KOQGVJMe/cmtekaUUBsOUHaYNNJg4s80PvvugTl0+BndnZr933PEPUDSB/Lb4OnVl+/n6LrDcLNHadeg8zqOWy/kvP2KUUNomU/00Uskf1ngrrdUYQ1VQ0vsLjv/LL+H0N5py90EJQC6HImM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WIcQx1LB; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WIcQx1LB"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c963d7503fso1362296e0c.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790677009; x=1791281809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsyRsDIsZttsfvu5V5hGcOc1AE8kzeL9+Ouy6xZvVKs=;
        b=WIcQx1LBIu/P2ejXZYILaHNc882scssNLxoJnoYkAwshADGs7wKwULIoIzEb226Kq2
         ntuTkCGMCcth4w7tKJDCOkghzbe9GzLvvUi/NSV7tqaJw5mUHRTrcDVUVroPJwlIcBKQ
         /l5uMJ5DJmWyD7GG5XsSKU7Nr255OsUnLhY8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677009; x=1791281809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsyRsDIsZttsfvu5V5hGcOc1AE8kzeL9+Ouy6xZvVKs=;
        b=JnzWWfhCqWN3YRxnU3IME6EGDjfstWDAjtPkyIIjxWk6v/mwHT0i+zM07qU7nsbxto
         0iSP/Rou67/GNeF02oi6Lb1E7D+z6LWi0x/ChQ4YdGN4oV8OfsjXiWfTY8URJT5m7YR/
         /DCu2sVoQzAcQrQm5wjaxbrfT7pAGc+e1D2QSZUPVJXTO7AdprtJ1VV8PkKWfbN5er7N
         CsSogyf2WC4xG6dpr6oLqPTNxb1K37z6lWgdOBiwxs70CCXEYYdOIYexqSa1o/zw1CVm
         qSljI4dLJygn3TTrCNlXPe2+XVmlBazwKnMDvDTaAtofuVq4duZJNcEaalQ7QAXXXNqM
         Be4A==
X-Gm-Message-State: AFq9FYLlDuDyawqtRJ4agxDzvW9QFUxcuxEY1E8Js3AikPlJoaWuPSlY
	hOlFF5VSVtP272ztokCt6W+PcQQNuOnwX70er4ZxBiTZ4wwjlEbAjqn2r4Mmek1F9zn5yNi1iz0
	+zmYZxQ==
X-Gm-Gg: AYBFou0cD1Ry7UI3/ZTetaxge+0cQvlFTlLukUUNePHm8OHDk51j654ZftvK2gf4ctI
	LzUx4VPyopIdsjvFiqLGwGF75qSVUwXhDQobUisZUBu2+F5en1CbEaB28WqdVHU9ZAVCRBy7F5j
	SGtn7aOF6L0dHsMuWAoXq5pYEeToENcskPDdJw8glLBw0q3dfB8fz36K+oWqfudJBQKtMc55HNg
	wAEtFjBmiWUmIk2iV+XzO2YTN9mQuZVJlJhUNtOT50qwaeNCO07bM6ICttnmOBtxvr9IXl8C7pF
	Uf5ZmvzXwuDFctzK5ZdgctAdS2zkaoi/BSjzY3VFQjQ2V2JY13riMg0RlTJ7JCh5y8lFDbfPwOE
	77Y8blbYmf2c84uDE8Dmqgtjilgm85Y51aYE7m47FZFlxKSQ5gGabO1tIr8oNjJlhs+tLruwykj
	saA6zfGFXuHfycbJSyTF8LxPX5ipuBez6lLsdhJzSHwdzYthQxBQl58p+4jf8+B6YkdnMUofbV+
	iXOw7V8UpwknRUyfG+u7o8KzHlOloNj9EG+GjI24NmCLp16jA==
X-Received: by 2002:a05:6102:32d1:b0:7ba:3572:2789 with SMTP id ada2fe7eead31-7ba35722b5fmr97782137.3.1790677008710;
        Tue, 29 Sep 2026 03:16:48 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm13134189137.5.2026.09.29.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:16:47 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 1/2] net/sched: sch_teql: fix shared headroom and header strip on slave retry
Date: Tue, 29 Sep 2026 06:16:13 -0400
Message-Id: <QDISC-6HS9.v1.20260928064754@mojatatu.com.1>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

teql_master_xmit() writes the link header of the current slave directly
into the skb via teql_resolve(), and on retry undoes it with
__skb_pull(skb, skb_network_offset(skb)). Two problems exist on retry:

1. When the skb is shared (for example a packet tap installed on the
   master makes xmit_one() clone it before teql_master_xmit()),
   dev_hard_header() writes into memory shared with the other clones and
   corrupts them.  The headroom must be made private before the write.

2. The pull blindly removes skb_network_offset() bytes.  For a frame
   that carries its own link header in the payload (AF_PACKET/SOCK_RAW
   with no dst entry), teql_resolve() returns 0 without adding a header,
   so the retry strips the userspace-supplied header and pushes a frame
   whose first bytes are payload.

Fix this by calling skb_cow_head() before dev_hard_header(), and by
pulling back only the header length that this slave actually added,
tracked per iteration.  An AF_PACKET/SOCK_RAW frame is then retried on
the next slave with its header intact, and a shared skb is unshared
before it is modified.

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path"), which restored skb->dev to the
master on the slave failure path but left these pre-existing defects on
the same teql_resolve()/retry path.

Conditions to recreate the bug: a teql master with at least two slaves,
the first of which does not consume the skb, then send an
AF_PACKET/SOCK_RAW frame (no dst entry) through the master: the frame
arriving on the second slave's peer has its MAC header stripped.  The
shared-headroom write needs a packet tap on the master so the skb is
cloned before teql_master_xmit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..acd03f9afc6b 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -245,7 +245,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* The skb may be shared (e.g. a packet tap clone); make the
+		 * headroom private before dev_hard_header() writes into it.
+		 */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The header, if any, is prepended above skb->data, so the
+		 * network offset grew by exactly the bytes to undo later.
+		 */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -281,11 +294,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 static inline int teql_resolve(struct sk_buff *skb,
 			       struct sk_buff *skb_res,
 			       struct net_device *dev,
-			       struct netdev_queue *txq)
+			       struct netdev_queue *txq,
+			       int *hlen)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	int res;
 
+	*hlen = 0;
 	if (rcu_access_pointer(txq->qdisc) == &noop_qdisc)
 		return -ENODEV;
 
@@ -293,7 +308,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -305,6 +320,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	int busy;
 	int nores;
+	int hlen;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
@@ -332,7 +348,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Undo only the header teql_resolve() pushed for this slave.
+		 * Pulling skb_network_offset() instead would strip a
+		 * userspace-supplied header when the slave added none, e.g.
+		 * an AF_PACKET/SOCK_RAW frame with no dst entry.
+		 */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

