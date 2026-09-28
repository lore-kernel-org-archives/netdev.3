Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0323845D3
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619368; cv=none; b=CezM8g8170EBR6d1zMr+xCa5mS7C1eDNUk2hD3s2psn0IqwoJH7IEVfDCdaxTQGlmg4R8HnkFaFaxyaqsihb+FgCreahH1xqZRNumbrK6gZtGUF/Xt63P1/21zaHNC8Suf2M0zUqdjVa8/wVdB/vJeQgoOTqpzNTE9S+kd3ZLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619368; c=relaxed/simple;
	bh=wra5l2muN1/5vtvQmwScWgclyhHdjGWxClTkLj8GSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/HyvIM0biAxS+V3QjilOavGkxNyW+sjwYcENMPiUcsfCjxiFrA8lwSPmwcR2EOP/OFia0GLU5PY3CxQuuxmpYIldLua/6XTrEKbujPxCgMWLMBF4VGjTwcgNyysW7NsXcVYBzn0OO/tLeLU4XjPSGYgMEC8KjILjPt2FN02ClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=yP3IXvHj; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="yP3IXvHj"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso14147075e9.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790619365; x=1791224165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+A/WKwePq+HaGCo901Wbxj13PChd0Mmwu8vylJoE6pM=;
        b=yP3IXvHj/khr4mAHPCDkbl9ViGWSTdT4JSbyH36+ne3Y2hneL/oQzP07iWvdbn3d/A
         GsgWRQ0op7GNkn1Us25Cu3dRhmYaH807I4HgxsT1xa/CN4i9gIJEfDjmO7ZoOoQJHGem
         t+97PwSD8hMZdXLaq7SgUMwdIC00vpOdtHdi5Iyzrc0cjd59vA6u4jJf4+Ox5mK2MJMt
         TfA+PjfoPqKEdFEcVgsONwXiw3BZp0aIv0SmmbW5CwifXxL3f0TvMUrmLHZ/ULP0Xb4b
         zyEWK2TT5avdn863RZd4GEMDaXd2REMxhGVXg+Vu6JW96UWgepbysZmVYE3joRWAf1hd
         uy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619365; x=1791224165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+A/WKwePq+HaGCo901Wbxj13PChd0Mmwu8vylJoE6pM=;
        b=ouKD2uCPNZ2J/OKB/PPQl7QZ8bocrcEg6sQLB8ats9XNbkcBl1WsUUgtVnC2Q3vf57
         I6ymTa+aaVhJtclZIRT0C0dF23CjcmBL0Q6WXMOqyqyxR46bpCTrEJCuCwZ77pcus+kW
         C6NUq6kY7pTNz2NXlg3mZpqZdG7gIcwsO602uI+yeQWKipW0z+kNY8QTKt9gZh9+7ohm
         daS5BIRwH9xcvf+kkMuFRROMWgj1O2GCzKPWsz1Xjhk1R/k4e/0dIecjv3p2FI/wa1rE
         SfU6orQrC1y7eNkselLBlyo6zEsacjflcMzkRvjqYHt5B+gNOjDPQdbQIsv4gqZ/DEDD
         7ang==
X-Forwarded-Encrypted: i=1; AKwUvBxl/wBwW5xqeDm3+anPkIaqg6bqVzuSy2T7DahSjFgMUyxz0es+GLaHyCLi7mgdEOzxDYsGhds=@vger.kernel.org
X-Gm-Message-State: AFuF++n06lKHvS5A0fIdH6voQgTbXzG/hPsDNqALtCW8XyAd+P15Fj1N
	pnU86x7tVh03XLhD8TPLd2sm8l4UiccUDkksmpol2gR7/0fDMa4blj4DMmMqikljPqs=
X-Gm-Gg: AYBFou3oJlay0FllDW9iWvioR+ruLD2dcopsL5F1QpRdcySb0YN6Av/V3PeKXYwr9sh
	C2hd6rUKho1i0Pzg+497DEg9m+bgnrR0yT7S+tg3hhefI6Xb5Z3gYH5W3AM9CqqIb6HMR7VdFqd
	bxkzmVOz9ziMVRW8/fFVbKZH5jGoVJGhtO+2IXeC41U0RhlVRiKCY39owLnB+Pr44osqz7HrMY4
	Z+uhiSsKIS3anMJo78gA7MBBpH8xIqJORlwO9gk0WyKaEQBJbAUh5J6nCxtTvUjz3YSqDWoNK0D
	yTDEV9OPUhTmZrn/kYvxpozr8Le0/5xQCDfOdgj5SkCOzrxtBcfG2XSrsvhbeLsv/yF0Dr7TBSa
	ramEM1GPrAvCR/QHRonUl6uAjD8pglp688kyHCgcv75lPhfyN/EJSt3l8OxnaClLhwXQZ3jN1Go
	zOoyTttib3xZj0PHlEN0IcD59Rj3oWDBKb/vbndxjkhg2O55CHg/sLSmkjjj+MUWLoKazzsc1l8
	wimDgx/uU3lYIKC8+XnyfZWPUTK0S9xRzK90CviUkJVGP6CTo10o59mlUx91XBD77UG0uFexk7+
	gg==
X-Received: by 2002:a05:600c:4754:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49fe66d2ce2mr248263965e9.11.1790619365293;
        Mon, 28 Sep 2026 11:16:05 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3627a8sm31553169f8f.23.2026.09.28.11.16.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 11:16:04 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net v3] amt: send the relay's General Query directly from the receive path
Date: Mon, 28 Sep 2026 21:16:01 +0300
Message-ID: <20260928181601.85857-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
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

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.3

