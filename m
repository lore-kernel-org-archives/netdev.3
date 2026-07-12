Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94225776
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820499; cv=none; b=k79s3CuZpEpR8W8pZirINcXcdR4FlRB2HMV/PdTh9QYU7F0kBi9WKoFwM15SFORtIcwOG27Ho5shoGgxDYY0wU8hl3b7U0S7ZWZdAnoY9ECe+4KPcw9zqtbv+NK0iuPDDSDvrDqrXFEij0UJh/lqY7GIJ+nCfMc8rIwxag5b7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820499; c=relaxed/simple;
	bh=U31TgNbKPfnopsLN55ATW10o/TlKSv0lz9ygAOijAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4V2huEGBULftQdieOLN5XAqHyGr2exQRSnk4GA+gZKgOjnRYDAp+k5wnCU8y9+yAE8ywdUo5kEqycE869RXmptYfQOp6blSbXQOF6x/qkGTnTh+SqgU7FKCN4kqA+IwqS5FU5Bo254nx68W0qRCGpxw9bNaWJkjWeYqKwgtwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5EFB77703C;
	Sun, 12 Jul 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5FAD779B5;
	Sun, 12 Jul 2026 01:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOdBKc7wUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:34 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/13 RFC net-next] net: tunnel: guard IPv4 tunnel functions with CONFIG_IPV4
Date: Sun, 12 Jul 2026 03:39:08 +0200
Message-ID: <20260712013941.4570-11-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 5EFB77703C
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

To enable compiling INET subsystem withou IPv4, IPv4 specific IP tunnel
core functions must be bypassed when the protocol is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/ip_tunnel_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3c677e9bff2..700a759d3c46 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -52,6 +52,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
 		   u16 ipcb_flags)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	int pkt_len = skb->len - skb_inner_network_offset(skb);
 	struct net *net = dev_net(rt->dst.dev);
 	struct net_device *dev = skb->dev;
@@ -103,6 +104,12 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	}
 
 	dev_xmit_recursion_dec();
+#else
+	if (skb->dev)
+		DEV_STATS_INC(skb->dev, tx_errors);
+	ip_rt_put(rt);
+	kfree_skb(skb);
+#endif
 }
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
@@ -212,6 +219,7 @@ EXPORT_SYMBOL_GPL(iptunnel_handle_offloads);
  */
 static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	const struct iphdr *iph;
 	struct icmphdr *icmph;
 	struct iphdr *niph;
@@ -269,6 +277,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	skb_reset_mac_header(skb);
 
 	return skb->len;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 /**
-- 
2.54.0

