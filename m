Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833984;
	b=jLe7ztVVSyrHDIXe+tbBgVL0zQO71ITHDixIcTJvJIPrP2EpU9o2pi+Wxen/BC3zD1OP
	 8ty9qe9K+zygoXu7kjAM8i2KaSX7TJ28h0aZD5VeGrCXvpJ+n2TgLseFLjZxPsB0NpSus
	 W40sX9hjvABKHFm+n3dujEJUIWvIE62KrwVSRmOJhXqNhQPLD25fQvIsZ55fts6QZcAH/
	 DUXVk0pXRxHEmVgJ+xXr5jYcufKYmMz6AY/9tPd7ZkIIjDevrix02hEp1XTZ9fkpHuk3b
	 oQ9xhYfvIgO9jQ5+TWtEw1FvwV61Temnn+CMuHfo5XMTa4W5tMF3HVftZx5hGqze6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833984;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=6aWxOhnZu57Z8wsL701uZLoHTAEt+9yoYzWAJWITAtQ=;
	b=uavjnj3gBNRppMss+pKbmfpvaraTMr18+81cmnTjtkcWajMQmrFnlRLhU60hKBpWN+4H
	 mIXbskxBu6us+VHSxY1eF3bZ7oakzWiIag04+ChXO0UahQgAYLUWR7OC6YBjrygJYyJ4D
	 BlIsKzOWofw+U/WXiPhF9LQg+KGrRR2JFZe8pJdlCchniAuvNAfPP1yGZoRF1cQfpV4N3
	 XzNAHMC+jqnXsEL1VedwObHXzihnmWZYvFsHw7oNO8Yd/DFF1RjkiP6+qFPcq8GRrFmlX
	 v+oIC7/ZjnrS/RM15l4p1oXte1FO5BaAdez4zSYSGFNfoxMN+hmUTPOPLd54kSD4mFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=clrnKyn4;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67560A2628;
	Sat, 24 Oct 2026 09:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A67560A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=clrnKyn4
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jBZJP5tVbzNljY;
	Sat, 24 Oct 2026 11:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aWxOhnZu57Z8wsL701uZLoHTAEt+9yoYzWAJWITAtQ=;
	b=clrnKyn4JPo8YOCUHOC926Jg2GAdE7fWCIfUExikl0/7FodWEkr9GzI6ZdqjjRJUP7LKBk
	MQ1N3zROAbU8kMrR3oVdo3xPpJ16c5Z5Dh0r77l81bOi4jidsWOqZWH8/mq6qbzx3PxDQV
	rbizob3RsA/eqVkvKPswXAbk9hmwmrn6KbQqUtZcubdL2TPTyMJgFL1WP/uxmUh44qHq8x
	m9w3PQeY0vMODNrdNllk40KJHRd3ubPOxJLA3sl31gxUybeCidttltqp/YK1yaJVUKbf/B
	kDPq//+ioOoFRwaHBdiEJd3uKYeQQgRdZg6OVJlfQHRTxrIO6Nxp0fBjyupb2A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 13/18] net: ipxlat: add translator-generated ICMP errors
Date: Sat, 24 Oct 2026 11:25:23 +0200
Message-ID: <20261024092532.172005-14-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024092532.172005-1-ralf@mandelbit.com>
References: <20261024092532.172005-1-ralf@mandelbit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBZJP5tVbzNljY

Let validation record an ICMP error without emitting it immediately,
and provide an input-side helper which sends the pending error while
the original packet headers and ingress device are still available.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-10-ralf@mandelbit.com/
- Replace the netdevice drop/action path with pending-error metadata
  recorded during preparation.
- Add an input-side emission helper which runs while the original
  headers and real ingress device are still available.
- Leave local-output failures to the originating stack instead of
  inventing an ingress device solely to generate an ICMP error.

 include/net/ipxlat.h | 12 ++++++++++++
 net/ipxlat/core.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/net/ipxlat.h b/include/net/ipxlat.h
index ddc98058ff20..592429f4cff5 100644
--- a/include/net/ipxlat.h
+++ b/include/net/ipxlat.h
@@ -98,4 +98,16 @@ int ipxlat_prepare(const struct ipxlat_config *cfg, struct sk_buff *skb);
 int ipxlat_translate(const struct ipxlat_config *cfg, struct net *net,
 		     struct sk_buff *skb);
 
+/**
+ * ipxlat_emit_icmp_error - emit a pending error for a received packet
+ * @dev: real ingress device, required for IPv4 ICMP routing
+ * @skb: original-family input packet; IPv6 emission also uses @skb->dev
+ *
+ * Callers must retain the original headers and must not use it for locally
+ * originated errors. A forwarded packet may reach an output LWT callback, but
+ * it still has an ingress device and a remote sender which needs the error.
+ * It does nothing when the engine did not record an ICMP error.
+ */
+void ipxlat_emit_icmp_error(struct net_device *dev, struct sk_buff *skb);
+
 #endif /* _NET_IPXLAT_H_ */
diff --git a/net/ipxlat/core.c b/net/ipxlat/core.c
index 1dc1fc7e6f04..dc03ca3c9f89 100644
--- a/net/ipxlat/core.c
+++ b/net/ipxlat/core.c
@@ -11,8 +11,12 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
 #include <linux/module.h>
+#include <net/icmp.h>
 #include <net/ip.h>
+#include <net/route.h>
 #include <net/ipv6.h>
 
 #include <net/ipxlat.h>
@@ -105,5 +109,41 @@ int ipxlat_translate(const struct ipxlat_config *cfg, struct net *net,
 }
 EXPORT_SYMBOL_GPL(ipxlat_translate);
 
+void ipxlat_emit_icmp_error(struct net_device *dev, struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr *iph = ip_hdr(skb);
+	struct inet6_skb_parm param6 = {};
+	struct inet_skb_parm param4 = {};
+
+	if (!cb->emit_icmp_err)
+		return;
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		/* __icmp_send requires an input route on the offending packet.
+		 * Rebuild it if the original route was dropped.
+		 */
+		if (!skb_dst(skb)) {
+			if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
+						 ip4h_dscp(iph), dev))
+				return;
+		}
+		__icmp_send(skb, cb->pending_icmp_err.type,
+			    cb->pending_icmp_err.code,
+			    htonl(cb->pending_icmp_err.info), &param4);
+		break;
+	case ETH_P_IPV6:
+		icmp6_send(skb, cb->pending_icmp_err.type,
+			   cb->pending_icmp_err.code,
+			   cb->pending_icmp_err.info, NULL, &param6);
+		break;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(ipxlat_emit_icmp_error);
+
 MODULE_DESCRIPTION("IPv6<>IPv4 stateless translation engine (SIIT)");
 MODULE_LICENSE("GPL");
-- 
2.55.0

