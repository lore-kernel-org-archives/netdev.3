Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833975;
	b=kOnWQhACyaGHuG/PXFiO83yuO0zHv6np4X7NANbGTCA4G6dLzyWPvQzxlEidBh4V54Vi
	 u2P4GYT11c8XDeq6pm6L0n8PrcOWA31yqvAIzb26xv5ZkLVxVdocFtTkBU/+rV+0QCZ2L
	 yZQx/hlAU6DPVu8HVOvnOa33Qe34KY1O/laiwppVO6yU6d22aDgLjG+E/MIjNlmKHQX4G
	 f+cxTrQjIkyH4+ElsivTMjCK99FaW+Xr4D8yJhD2Yb4hrThPFkaqv5iP8No1anug1Xcv4
	 XNZjwFnEzi4+FqtnQebYwtfZzt4ElfpmS5jS8+Ux5Q5tg6FAi1xJ5FekJCdNRgxKNMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833975;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=aHQjbiEDaDFKpIHp1kYu+vnjbkH110NdIRcCdcZ77Ec=;
	b=GELSm3MhZcEPEHnn640+Z7cfANmhQQKiy0+TLRQotLukV2CUFUQla6x20bUcUcHRWY73
	 j32sfBo4a5L3FY9u8aJuvT4BMu95PrNwd8mEDgpFgnFYJr0k8ATgmYwV2/Uo9TbSE67DK
	 MJTAk4vxttpMqGIFhxwa2IXUulmyoTA9xz5mb/O/1+rbUz2j73GIEEYGn9fKi23Zr6voz
	 fW+ULeLQrc/Rpkg6iv6HgeAHeaAX5muef5fcVBRSdkyq6QGXUSOYBTmKzxMNd05gK7L1V
	 KFFnt1f3nPcmTqJSKQUgh4U7nkKPkOPMMgPT7F9N90MQLjmZ88KfQFsrKzmNnl7E0TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=b1PtLjSk;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5150606A31E;
	Sat, 24 Oct 2026 09:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5150606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=b1PtLjSk
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jBZJD0X7Jz9tWQ;
	Sat, 24 Oct 2026 11:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHQjbiEDaDFKpIHp1kYu+vnjbkH110NdIRcCdcZ77Ec=;
	b=b1PtLjSkuSWz6XAdJZLejRYVmem8mctQoW3Y8ws4QiqRrsMvpRdYYlwHR1GR71uHlWDP0f
	hfWphuNwIESzXw+uTaZUqP2GH46vjalfe+iPRoqdbWpE3bRPlliNN5WSF0ou1e4P5kAnfV
	/btr9Wjk7L8opYCton1/+tncI32Q6zweZmmY287k3qHMYSF2N0QBik+TQh0eJYKHFst1sh
	Jbl/Ts3wVJYKrJGn9Lx717U2FPu1npaAZrIpA5QoXMz3qoi0G2puxLmgppeNXlV5/eZBKv
	QcIbD9Uy6nL+3SHecoNj4K4md1hjnbPabyYxyxvyom68s39OkdUsm+1iEdwslQ==
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 02/18] ipv4/ipv6: add LWT receive helpers
Date: Sat, 24 Oct 2026 11:25:12 +0200
Message-ID: <20261024092532.172005-3-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJD0X7Jz9tWQ

Cross-family LWT translation constructs a validated target-family
packet and needs to enter its receive path at PRE_ROUTING. Add helpers
that invoke the hook and continue with normal input routing.

The continuation remains in IP core, so it stays valid if NFQUEUE holds
a packet after the selecting LWT dst has been dropped.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch in RFC v2.

 include/net/ip.h     |  1 +
 include/net/ipv6.h   |  1 +
 net/ipv4/ip_input.c  | 10 ++++++++++
 net/ipv6/ip6_input.c | 11 +++++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index 618b9806c10b..761b6b0d48f7 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -170,6 +170,7 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 			  struct ip_options_rcu *opt, u8 tos);
 int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
 	   struct net_device *orig_dev);
+int ip_rcv_lwt(struct sk_buff *skb);
 void ip_list_rcv(struct list_head *head, struct packet_type *pt,
 		 struct net_device *orig_dev);
 int ip_local_deliver(struct sk_buff *skb);
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..e3f245d640ac 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1016,6 +1016,7 @@ static inline __be32 flowi6_get_flowlabel(const struct flowi6 *fl6)
 
 int ipv6_rcv(struct sk_buff *skb, struct net_device *dev,
 	     struct packet_type *pt, struct net_device *orig_dev);
+int ip6_rcv_lwt(struct sk_buff *skb);
 void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
 		   struct net_device *orig_dev);
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..f679e38a1a1c 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -493,6 +493,16 @@ static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return ret;
 }
 
+/* enter IPv4 PRE_ROUTING with a validated LWT packet */
+int ip_rcv_lwt(struct sk_buff *skb)
+{
+	struct net *net = dev_net(skb->dev);
+
+	return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING, net, NULL, skb,
+		       skb->dev, NULL, ip_rcv_finish);
+}
+EXPORT_SYMBOL_GPL(ip_rcv_lwt);
+
 /*
  * 	Main IP Receive routine.
  */
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d332ec60f915..47aaa1fcf82b 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -26,6 +26,7 @@
 #include <linux/mroute6.h>
 #include <linux/slab.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/module.h>
 
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv6.h>
@@ -119,6 +120,16 @@ int ip6_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return dst_input(skb);
 }
 
+/* enter IPv6 PRE_ROUTING with a validated LWT packet */
+int ip6_rcv_lwt(struct sk_buff *skb)
+{
+	struct net *net = dev_net(skb->dev);
+
+	return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING, net, NULL, skb,
+		       skb->dev, NULL, ip6_rcv_finish);
+}
+EXPORT_SYMBOL_GPL(ip6_rcv_lwt);
+
 static void ip6_sublist_rcv_finish(struct list_head *head)
 {
 	struct sk_buff *skb, *next;
-- 
2.55.0

