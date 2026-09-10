Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FB4A8FDC;
	Thu, 10 Sep 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051857; cv=none; b=GGPCGaxue2FqzKZH1PITZYXWGGOPmI+ZjOmrxf1Ejioz8DO2BQ7lynNsvT1mW6HK9Hn5EtFELzObnosftXimT9h+2djTNLMNDzxq/+j/Q5nCHEpMy+m4IU3QGRFJ1Bep2Yn5niBL2oi6uuKGZ6kKMoU9K5HwnjscwlffKTAeOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051857; c=relaxed/simple;
	bh=eUFMYPPYisKt15Fsc9muRHoXDSWEaDGEQzgVg4Jn8jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdxjLqrK0QzCyE6X008kR4Fh2aeO+prk+S26iJbzkJpQQ7tav8l2eQu5Inm5SuCPtoO+Ww6E8j7oOdPr0Lp+q5P/1j6HArRNA6VWaaBbQvjuiaH8LnwxD+o512ffELSulEhM+pgXV6p63ptho+GOhlqne9ZFUT2qFynqJDoSSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B32EF21D65;
	Thu, 10 Sep 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E85137FD;
	Thu, 10 Sep 2026 14:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMI7OsvDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:51 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/13 net-next] net: tunnel: guard IPv4 tunnel functions with CONFIG_IPV4
Date: Thu, 10 Sep 2026 16:48:35 +0200
Message-ID: <20260910144914.8025-11-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: B32EF21D65
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
2.55.0

