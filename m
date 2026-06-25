Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96B23E325
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406438; cv=none; b=RCupQuEgYLNN+9ZXMO1Jqi9YyCr1UGS4K89vbMuYQmDiGSkXG4ShY2mYy2W0iUJeGq3Mh5HddCO0iEN+RvOQTSqEBnSk+iQpw0jT5yNSirklmuZseqYkMEoMlL8dzf7p5fDn8U2P25dwpJvgHFRgNYmQ7jryLt6clO8RR01GuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406438; c=relaxed/simple;
	bh=5qVHps26hM+lLmNc8QeJKUzcQRmEU09xSvy67t8Jwwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5O3h2pXXHkwGL3c6zQ104LQMXF1noMXVuymhpQkVYj6KHzFq5Dek62WQ6EJlTqvGt4VC8Guq1AAPaMNOnHDAvsnvc5mnV5BuwBoGpuGZeuwGDXWPOz6rgWZsP4qwmDvmTrUDFspfwSo1WIX2CJamjJd3fmhSuQSyPsdVUXAwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCPdbfGg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCPdbfGg"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39972d9a66fso1378311fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406434; x=1783011234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tDUw2ua7IfiwLpN7RDrJJg19vrTPnELI9CPZKMaHeY=;
        b=dCPdbfGgGOLQwsUijOjAC8b7Veorb68bosqGxZ3uUfYWQqgchdoUdyLFqxZKi75F95
         gwEoSjqlmv2wOxlCnumxDd3lFLFS8rkQpvcWFRCdjM4QZBhMYUS+0ph6XOJZ7yPoUyU+
         KNY6DK0wz/X3pP+vzjGsGzXwMcm5K8VOpinfu2crjsBXaLACLozao/8GwzciB/M5YlP+
         DK5O0a2KJqoOiiqAnSb6Gk2r+EBDftiYTJ8f1cdO9q/eWAW5TnQZOI8tAcl5I2U9qbnt
         jp67eGH9FW6fkckaawhdSwFQjMcap98kryzwO+N8ByVrIt38mgaGVEKwq7TLJMEjXiBX
         jhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406434; x=1783011234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tDUw2ua7IfiwLpN7RDrJJg19vrTPnELI9CPZKMaHeY=;
        b=LJ+V2MU8zdPmeLCG27uzqdgWW4NI3HqXIkJtVhINoF8nF0uMhjqmYOn8KUQG65TWCn
         k6rJm+kxLrEx3OPFJt85xMtiNcxaErYQomAM/Iwo3wQ3SqKLT0Ilnil7In9YFRebXyTb
         wAR991MwIZa3atWWUd9sxA9oaBcr3k/VVaGJovB5D7xSRmKPcZwY8GWNP+z9Dqgt3PJp
         sRo2AsGFYoDAPW5NkAw4Th5U+utYaFqrToX+AMpZxeGZ9ojRsFz+Njv3tKht76Vkfxpq
         +Jsu6e97Zk26jGN78QPDImy7WrxmlyGWB28yd/raPgsp/ApouzOPyj61E44xqBDSq9a3
         5cMg==
X-Forwarded-Encrypted: i=1; AHgh+RojpGSKu3lwUSeULnJBcAjeRA3gn890TQ1a6++ZaOv5pS4BXAh8PrGHL/lIloAejvyrh9tjCuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGBWBhc/YxN+cvNAVJNNegqFKTFFaAuB6T+LV5tcwujCkx8Im
	njGKW66c2a95gDBjxxeWsh8oQruEV39eUN5g9Hk1wUGpn2khTlXGdAu6
X-Gm-Gg: AfdE7cmvgnPfGmwQVufxLVlbALj3prW02EgGu9fw+t9gGIHk5xmQ6g5jJNqq3EIJuEi
	ETuAqkHE3UAoDuBu+86CQdvfyF/NxhAHS17cVONIA+RMBVbxlGBC9vLN2v9ovElbeP+XrEwy/d5
	oQLve1Uk3WblquKiIgMfVfUFkJ0vjGW7/gHYnKY7Ticc3yW4gEdMTv9+F2iLLn/sS7ZzweVj3I7
	hs6nn/OK0B0H4ZzYBHgGVuLXyVKT4ho1nrg62Sq+SarwOadZx5Njy+HKdmeEjN9iv7PtJDtrLAK
	x2fIFdShAdfwmDYmk3DXUcXGaZQkVeTJnMmnFnTV6d80GJU4Bw/vQPdxt+0APxzZOZRtGLfwiL/
	o+qO+d+tMt4q/U9DczpdgkvpuNb0+6ciJbMhhA+2n0F/c2pwNVyK596SZ3Dd6EC1G+D94ln/hNq
	jQiyZZunZdUc0WPQiLR+tUXej8uq4E
X-Received: by 2002:a05:6512:2510:b0:5ae:a333:e982 with SMTP id 2adb3069b0e04-5aea333ea42mr853884e87.27.1782406434168;
        Thu, 25 Jun 2026 09:53:54 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:53 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH 5.15/6.1/6.6 1/2] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Thu, 25 Jun 2026 19:53:32 +0300
Message-ID: <20260625165335.162311-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625165335.162311-1-alexevgmart@gmail.com>
References: <20260625165335.162311-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

commit 6a7d88ca15f73c5c570c372238f71d63da1fda55 upstream.

The function always returns zero, thus the return value does not carry any
signal. Just make it void.

Most callers already ignore the return value. However:

- Refold arguments of the call from sctp_v6_xmit() so that they fit into
  the 80-column limit.

- tipc_udp_xmit() initializes err from the return value, but that should
  already be always zero at that point. So there's no practical change, but
  elision of the assignment prompts a couple more tweaks to clean up the
  function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/7facacf9d8ca3ca9391a4aee88160913671b868d.1750113335.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 include/net/udp_tunnel.h  |  2 +-
 net/ipv6/ip6_udp_tunnel.c |  3 +--
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 6818a59a1ebc..dc796ddd231d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,7 +152,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
 			 struct net_device *dev, struct in6_addr *saddr,
 			 struct in6_addr *daddr,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 7aef559e60ec..886c42de0566 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,7 +74,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
 			 struct net_device *dev, struct in6_addr *saddr,
 			 struct in6_addr *daddr,
@@ -108,7 +108,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 0673857cb3d8..12469cf1a49d 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,9 +263,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	return udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr,
-				    &fl6->daddr, tclass, ip6_dst_hoplimit(dst),
-				    label, sctp_sk(sk)->udp_port, t->encap_port, false);
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+			     tclass, ip6_dst_hoplimit(dst), label,
+			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	return 0;
 }
 
 /* Returns the dst cache entry for the given source and destination ip
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index e993bd6ed7c2..26aca3df2978 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -172,7 +172,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
 	struct dst_entry *ndst;
-	int ttl, err = 0;
+	int ttl, err;
 
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
@@ -217,13 +217,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		err = udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
-					   &src->ipv6, &dst->ipv6, 0, ttl, 0,
-					   src->port, dst->port, false);
+		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
+				     src->port, dst->port, false);
 #endif
 	}
 	local_bh_enable();
-	return err;
+	return 0;
 
 tx_error:
 	local_bh_enable();
-- 
2.43.0

