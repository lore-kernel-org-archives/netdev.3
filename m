Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2364F68A6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627002; cv=none; b=ehR/+nw7Ep7xPvxAqIU8tQjt8EwI4I9PGZh8sg4q2ZyNVD2aVakns4w7wqflhF493MxZaoWarky0vZpZzZlqBxhs0J+rV6ANXNKOhJfNJzXCn9cnadEFuGanLXchx3JOFnBWJvM2VkI+ZEw4IKYK03PUivJ2RvxUq0quzF4hYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627002; c=relaxed/simple;
	bh=H3xzNMATqmZ6U4sRFJ9aYFKcSofTzyqh5gIl2IuxhcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8SxaMz7LzASKoK8thbACEwcKSxe8UCi9graA1QvluqMX6P9aL3S0meICu9I9dnqIYAnraN9TZqB4WFZdUEIp6/4t9ZGoRsa1T00xk7+05CklVSCxe/l2dtAgq0yPx9iqf1TcqDtaXF1ocHQr6/NhPvCu64JUo2FEHlGrdCzpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=BLO97HYi; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="BLO97HYi"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so9438455e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790626999; x=1791231799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/O/e9pIJvdC/89qC40V6amodvhfACYnGXhL98tlWOg=;
        b=BLO97HYiEd5QOeWQ19LIgE3BgWLnQBCFx8wPu2sZu1wXJadyTBWxHJ0S+WyLngR88c
         WhckmXBwiI9zVqU+KUJTzTieu/cgecuEAjImkDRspoHEfbcojqaH4mqtofj2gVurGyCu
         sder1jBijUgvIHvTXyjPkrf5PfX7Xwhr9olGUDHhB7K1VJrg+U5CCf51Jb0l3YFP7Eay
         Zx3FcHgyoFSikqmr8w9A3bJ7aX9TLc/i6ScrbZps54u35ual8ydGCstEExJqwu8hF1mn
         vvfTqfGAWIH2DtBLDvRHs8dKO5VLPD8Wu5/hZ6yUx1dbkdKnuIcmd+QtKsSaI6C3SS67
         klaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626999; x=1791231799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/O/e9pIJvdC/89qC40V6amodvhfACYnGXhL98tlWOg=;
        b=cHwtwvWKUcl2oWSWOtzNxyY+ESBxuqDB2i7Qzw0j5KOeRqk/0AZU1s5dOJFvxfZ9MQ
         1YpGQUqNbGXb+RO4bp4ekZo334f0o1TnpP3iZIu921XzwxF7UmWc4tF2Mf894kHFFThG
         bacGGZmjom15smSJPAEXCD9KdLgNQhuL1YwVahRHGsZvUAtzxTUTY+QzG5s4NyDwljxX
         aYN4GSitQ3qa9sI9g2UHRrmKUlCze9vKQOAtH5Xsb1En5hRUqjgUiu3xZKkK74s/kG1D
         UqIi/nv0GbHWDI8SqE2J8rlmvPWnAC5RCIIl702TBfrA5eZHeNR6h3n7LmUaUM9/fLCR
         zQaw==
X-Forwarded-Encrypted: i=1; AKwUvBzV0ensVKM7dwB7Y/xBkORMvXRLgYGO2WtbyLuk0uR1wtqIUDubLecb2dpeKOmLq/jgNC2eUH4=@vger.kernel.org
X-Gm-Message-State: AFuF++lVS4fEHYD+KWxc6vtMm0zEj9eFIw4xUNay6DaVrDweraaR+csn
	Xz47EVfMr/239ZEbEF86Cesw4FpEbw0M8idznQTSA0VUKxAVVXm9NtoYIw2/gbDehPs=
X-Gm-Gg: AYBFou2v6aVlfQnfPQPvu1eUvZmP/xYwbpe6SH5ZhhILURLJwGVwMyPm7/k2PzN9J6F
	+62n+JKALTMj67Yaq5Yt37eH0BmsMuXuHx/A1Miv1iL4+5OrNDJHEP+Ifpl1HdSWA3AkG7ebsJ2
	CTfNRj5ECphZolj/Y0N9nj+8uRBo1m0DE8TtVsqyzYhowFabKUS6GKsQFqByBp/CuEkk+pxhfmt
	QFtUXhJCM/d/sggxPk0wInj3Jc9Yspbpo6Cj8hhIbrwughYLC7Nv1Jy5UyDhhjuopIoQW0QaZa7
	cvJXAPK+foAL8uYyP4Wdop2WZEDnW38ME4uLRnke0f8ksMp7whsiAAQ6j5uJDz4qT1eMIIis2AL
	Kc+qaFzAVxVx1wwuPutecsmzdNRV3Oj/3CvnnrfjW5gDnudYYebjxizO6i9IwHcmPjx+8TOWrFv
	U15jIkAj8BtcWLJN5JoHrnWBkJII+LJWflPoFwMvrqafBPDAZdjFdq86MFAKZw1iF/GeLt3EpsZ
	71tjUCXShxG1nkMtk5ZmmzMBkIOBqG3saP7zRLW7V63dEEZ+SP3fIhcu4uzkY2ei5DhcrSlxPCk
	ug==
X-Received: by 2002:a05:600c:4689:b0:49f:fe48:d171 with SMTP id 5b1f17b1804b1-49ffe48d27amr117814195e9.35.1790626998388;
        Mon, 28 Sep 2026 13:23:18 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm29620500f8f.2.2026.09.28.13.23.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 13:23:17 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net v4 1/2] amt: send the relay's General Query directly from the receive path
Date: Mon, 28 Sep 2026 23:23:11 +0300
Message-ID: <20260928202312.74574-2-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928202312.74574-1-omar@blockcast.net>
References: <20260928202312.74574-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb queued in a qdisc can outlive the tunnel it references
through a raw pointer in skb->cb. For example, with igmp_qrv set
to 1 on the relay a tunnel lives for 135s, so a netem delay of
180s on the amt device outlives it; when the tunnel expires and is
freed, the subsequent dequeue triggers a use-after-free in
amt_dev_xmit().

  BUG: KASAN: slab-use-after-free in amt_dev_xmit+0x2763/0x2e20
  Call Trace:
   amt_dev_xmit+0x2763/0x2e20 [drivers/net/amt.c:1262]
   dev_hard_start_xmit+0x22f/0x620
   sch_direct_xmit+0x12e/0xac0
   netem_dequeue+0x333/0xc50
   net_tx_action+0x35c/0xa60

amt_send_igmp_gq() and amt_send_mld_gq() are only called from
amt_request_handler(), inside the rcu_read_lock_bh() section of
amt_rcv(). amt_request_handler() already has the tunnel the query is
for: it found or created it inside that section. Queuing the query with
dev_queue_xmit() only leads back into amt_dev_xmit(), which strips the
Ethernet header and calls amt_send_membership_query() for that tunnel.

Make that call directly from the two senders instead, the same way
amt_send_advertisement() transmits from the receive path. The query
never waits in a qdisc, the tunnel is only dereferenced inside the
RCU section that found or created it, and nothing is stored in
skb->cb, so no lookup or refcount is needed. Remove the query branch
of amt_dev_xmit(), amt_skb_cb() and struct amt_skb_cb, which have no
users left.

Behaviour changes:
 - The relay's own General Queries no longer pass through the amt
   device's egress path: its qdisc, tc egress (clsact/tcx), the
   netfilter egress hook and packet taps. They are still visible as
   UDP on the underlay.
 - A query that is sent successfully is no longer counted as
   tx_dropped. The old query branch left through the unlock label,
   which counted every sent query as dropped.
 - A query that reaches amt_dev_xmit() on a relay from elsewhere,
   such as a userspace querier, is now dropped at the IGMP/MLD type
   switch. Before, it trusted whatever skb->cb held, and a NULL
   tunnel hit the WARN_ON(1).

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
v4: no code change. Add a selftest (patch 2), as Taehee asked in the v2
  thread:
  https://lore.kernel.org/netdev/CAMArcTXsU+YbUzjF8BOLsVjL2L_Quasv54mdm8iiJN5QdoAPZA@mail.gmail.com/
v3: https://lore.kernel.org/netdev/20260928181601.85857-1-omar@blockcast.net/
v3 (Omar): send the GQ directly from amt_request_handler()'s RCU
  section, instead of storing (ip4, source_port) in skb->cb and looking
  the tunnel up again at dequeue. This also removes the per-query
  tunnel_list walk that Taehee raised on v1, and the v2 window Sashiko
  found in which a re-created tunnel could be matched before its nonce
  and mac were written. Cen agreed in the v2 thread to go this way if
  Taehee is fine with it.
v2: https://lore.kernel.org/netdev/20260922214150.13970-1-cenzhang@linux.microsoft.com/
v1: https://lore.kernel.org/netdev/20260818164825.63967-1-blbllhy@gmail.com/

Testing: Cen's KASAN reproducer, in which netem holds the General Query
for 160s past a 135s tunnel lifetime, reports the slab-use-after-free
in amt_dev_xmit() on net, and nothing with this patch or with v2
applied. tools/testing/selftests/net/amt.sh passes 5/5 with and without
this patch on a KASAN + lockdep kernel.

 drivers/net/amt.c | 48 +++++++++++++++--------------------------------
 include/net/amt.h |  4 ----
 2 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index bddc24e18..b53f8ec55 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -80,15 +80,6 @@ static struct in6_addr mld2_all_node = MLD2_ALL_NODE_INIT;
 static struct mld2_grec mldv2_zero_grec;
 #endif
 
-static struct amt_skb_cb *amt_skb_cb(struct sk_buff *skb)
-{
-	BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct tc_skb_cb) >
-		     sizeof_field(struct sk_buff, cb));
-
-	return (struct amt_skb_cb *)((void *)skb->cb +
-		sizeof(struct tc_skb_cb));
-}
-
 static void __amt_source_gc_work(void)
 {
 	struct amt_source_node *snode;
@@ -791,6 +782,11 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	rcu_read_unlock();
 }
 
+static bool amt_send_membership_query(struct amt_dev *amt,
+				      struct sk_buff *skb,
+				      struct amt_tunnel_list *tunnel,
+				      bool v6);
+
 static void amt_send_igmp_gq(struct amt_dev *amt,
 			     struct amt_tunnel_list *tunnel)
 {
@@ -800,8 +796,11 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
-	dev_queue_xmit(skb);
+	skb_pull(skb, sizeof(struct ethhdr));
+	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+		amt->dev->stats.tx_dropped++;
+		kfree_skb(skb);
+	}
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -885,8 +884,11 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
-	dev_queue_xmit(skb);
+	skb_pull(skb, sizeof(struct ethhdr));
+	if (amt_send_membership_query(amt, skb, tunnel, true)) {
+		amt->dev->stats.tx_dropped++;
+		kfree_skb(skb);
+	}
 }
 #else
 static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
@@ -1186,7 +1188,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	bool report = false;
 	struct igmphdr *ih;
-	bool query = false;
 	struct iphdr *iph;
 	bool data = false;
 	bool v6 = false;
@@ -1204,9 +1205,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			case IGMP_HOST_MEMBERSHIP_REPORT:
 				report = true;
 				break;
-			case IGMP_HOST_MEMBERSHIP_QUERY:
-				query = true;
-				break;
 			default:
 				goto free;
 			}
@@ -1228,9 +1226,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			case ICMPV6_MLD2_REPORT:
 				report = true;
 				break;
-			case ICMPV6_MGM_QUERY:
-				query = true;
-				break;
 			default:
 				goto free;
 			}
@@ -1261,19 +1256,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto free;
 		goto unlock;
 	} else if (amt->mode == AMT_MODE_RELAY) {
-		if (query) {
-			tunnel = amt_skb_cb(skb)->tunnel;
-			if (!tunnel) {
-				WARN_ON(1);
-				goto free;
-			}
-
-			/* Do not forward unexpected query */
-			if (amt_send_membership_query(amt, skb, tunnel, v6))
-				goto free;
-			goto unlock;
-		}
-
 		if (!data)
 			goto free;
 		list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
diff --git a/include/net/amt.h b/include/net/amt.h
index a0255491f..2846dde0c 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -231,10 +231,6 @@ struct amt_relay_headers {
 	};
 } __packed;
 
-struct amt_skb_cb {
-	struct amt_tunnel_list *tunnel;
-};
-
 struct amt_tunnel_list {
 	struct list_head	list;
 	/* Protect All resources under an amt_tunne_list */
-- 
2.47.3

