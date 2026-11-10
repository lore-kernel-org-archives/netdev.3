Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342034;
	b=QNtR9LX4PEa4AOnTvRwSIKPSmusmZ1nEF/s5tvRn9nfeCpMg/d5+ztqagrNwxNvhl+C/
	 enQj9/SP9EpEjvog/SiTk82BB7qD9zdyh4jfdoA1bJ2KjkZ1XcEU2EZRZPVSMgD9p9OQB
	 XWhSe/pwRfd47TbpOkAVOKuK+xr4i1AMdqFPGxQ9hpCjDZzStr7HXQqC4tcBouGFMw8CJ
	 iFI63Gzzm1eX/qLO+MSSLX3bCTNOvL+2H+qVPYvlFfpc9leppypWrtxHcM0E61UgNCqWO
	 9RIjKmycoHxu3InF9Ayt6vUKl87hTeq1H65vmWOD3+XEn2G4hdzdC0RMYcvigFlScYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nu0B1eopGv0aUO/omSfPZHl8ExvL8wF099XPbZRGuQ8=;
	b=3d5H4eZEd6h/k9y+Bxsv0MIc5zn1IpBBZ1D7HCJgvd3hYLutJ0ivWfcbqphVfAp1fsbE
	 +KV40b0+vUrvAs3C97yjGxxPUBUpzemTDGDCMyVcqJZWrNtnS5z64daJgrk4qjTlvKaeC
	 FJdOZUyXDVSjk43kfJkdqs7at2zwDecbaTgpo1fIUoVnwLNAAEJtsx0mw/4G/iL9JXA7Q
	 MTjCX0nxOnqYxaTphd4XXQZ5hqCsKOqmbMcgW1ONl9nLl0IOfIM8SV4frhbF+Lj1DY1Mz
	 fhRBRPAEASNTsUT4cKzVqhJZKokDwWEgz+xoc2YTv8HXIB9enKwalQrcxt2CGPM2xGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THUspvVj;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D760A263E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC5D760A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THUspvVj
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3adef977ad9so18427191fa.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342032; x=1794946832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nu0B1eopGv0aUO/omSfPZHl8ExvL8wF099XPbZRGuQ8=;
        b=THUspvVjXGP2pkX0jnPrnPStqjtMMg+FPYcZNQQgBBgQjCym/Pi9puQ65aJY0tspA5
         6JQlLOttlgmluYwqpQ3+P2azOHZv5tJLfl7JVOz6ADx7bw7a+dKj0f7NSOlXiYOLMsGe
         Yqhwc1Ln8sFAQwdxxbDUesT3PVGrFoq3W7Ab1aEuS2VDXCJ9mJpI2yOLcnUnk9SImymW
         QGCZqX5fWO9Zj/IxGcLUmVcW7fVZa9M0zTnNeuFx8HaEOkaOFtTH+I95PiEy/wNPLSMh
         4onitrixFYbyebBQpMpBoXNzgf9bmnuv4KzAG9QjW+76CPyJyIIuS9YApeDlY43W5MeF
         xtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342032; x=1794946832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nu0B1eopGv0aUO/omSfPZHl8ExvL8wF099XPbZRGuQ8=;
        b=Z8RPfV0Bs3tGXfW9Hmebef+3JocDHufiGcG3gM+A2RoKCXDY9SCF2jYgxdZ0GO1YGm
         rjhqOrJ7bSkx494k03p6sL72wxIbDQq1j3Sci3Caaqb1owPYKbvrt+iUHQNlKqCiko2K
         pkAWaqf6GPr8kiW/6bZSAFWKmstsuUeiFXdkszjo5QSlJX320R2G4hD41nXWWwitRqaO
         WVq7JUdZhr0A49RKiZc0Rq2S36YBo9XkJnhvU6RTx0CuA7eA1LelQtUPouOcUc/6Z7IX
         i/VTsWzaimKZEzbw66Jsz/a7Skj9wCCko4Wen+1GvjYWv955tYHJhV+w0hSn2f8kDYGg
         OSgw==
X-Gm-Message-State: APuU4Z9BuoFXhMI8QddWi2W8VJV+1whzQ0KJNHF8fQGikWzjBQTCkky1
	zh36WOTI8wUZ6CBQYZfWgE7+p5Zg6dA68NshqUSTQ/o+ytndyDHYr91AfT1bRvhQHCL9/Q==
X-Gm-Gg: AYBFou206aiRGvIj+nGORKAOcwUJM29UJQVuNlZwKC9ofq+wRlDfObizSyNBMEFs6YL
	gCVrIfNYX2pWNidTOJboExgbKaj1+9AkLuEPueonIRlRB+wzf5p+jLwnMRQgUj9ozkeqMoWmf9A
	8Qd7ElTvDNuZo+FjPQdC7zdgfS0BwxyGQ4cWEFuA/8iCBUTpIex9eXhBjczrNKSTot+X9bNtCBh
	BnlBoLHu2Y6jpIFz9A7xhzEZXUt61Citzs5WNYb8vAOKqNsbq9xiw5eCVn8yAAyDiPUhPu1bHcq
	buCbKPOJ/m0fwoMFRU0osRUsicHpTDC3cJvQ2Fx8QAji0SWYcFGSVjQ2nEOke+cCDuqWj59vmWt
	s+fJfucMo7h+Vryh+RU63+4CgrmQvtGRPnaj8+AUC3DiTo/Br29CvRmVDabstqTFk+BTteTFDxB
	4kDMYIh5o03xzmqh33KAolb+0q6gG00Xy7STcH7VuzCebiCC0t0qf/GH/seiURayh5VN7QoA2VY
	ITcEBIVnq87GteEA/hLAHY4amdsDmCtjMJAH3EA9pRqPRxXYQAsMZbtJEKM3xyGoT3DVshl/oBv
	rBRQIz5bBbGE5fTj+wpTx353A8v5jFuv+bhNSdrL7XT7Jsk4au58fhwRj1yn08D65iySaHr3AI5
	qFtVEp14bzVQK7ucJ
X-Received: by 2002:a05:651c:1a0b:b0:3a9:79d6:c792 with SMTP id 38308e7fff4ca-3ae0960e277mr9525951fa.5.1794342031956;
        Tue, 10 Nov 2026 12:20:31 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:31 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 5/8] ip6_gre: add drop reasons to the RX path
Date: Tue, 10 Nov 2026 23:20:18 +0300
Message-ID: <20261110202021.821224-6-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
References: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
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

Mirror the previous patch on the IPv6 side. So far gre_rcv() reported
the drops below as SKB_DROP_REASON_NOT_SPECIFIED, all from the same
kfree_skb_reason() call. Now it reports:

 - SKB_DROP_REASON_TUNNEL_NOT_FOUND when no tunnel matches,
 - what pskb_may_pull_reason() returns when an ERSPAN header cannot be
   pulled,
 - what iptunnel_pull_header() and __iptunnel_pull_header() return
   when the pull fails,
 - SKB_DROP_REASON_NOMEM when the metadata dst cannot be allocated.

Unlike ip_gre, gre_rcv() calls the helper before the tunnel lookup, so a
packet whose ETH_P_TEB inner Ethernet header or WCCPv2 extra word is cut
short is reported as SKB_DROP_REASON_PKT_TOO_SMALL whether a tunnel
matches or not.

Like their IPv4 counterparts, ip6gre_rcv() and ip6erspan_rcv() now
return SKB_NOT_DROPPED_YET where they returned PACKET_RCVD and a drop
reason where they returned PACKET_REJECT. That leaves PACKET_RCVD,
PACKET_REJECT and PACKET_NEXT without users, so remove them.
PACKET_REJECT has the value of SKB_CONSUMED, and a stray one in a
function that now returns a drop reason would build silently and be
traced as a consumed packet.

gre_rcv() no longer sets SKB_DROP_REASON_NOT_SPECIFIED once the header
is parsed: every drop now gets its reason from the helper or the handler
that fails.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip_tunnels.h |  4 ----
 net/ipv6/ip6_gre.c       | 51 ++++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cccf4c0e691..792690ae4f26 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -207,10 +207,6 @@ struct tnl_ptk_info {
 	int hdr_len;
 };
 
-#define PACKET_RCVD	0
-#define PACKET_REJECT	1
-#define PACKET_NEXT	2
-
 #define IP_TNL_HASH_BITS   7
 #define IP_TNL_HASH_SIZE   (1 << IP_TNL_HASH_BITS)
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 75665a576657..eae170ea0ba6 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -451,7 +451,8 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
-static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
+static enum skb_drop_reason ip6gre_rcv(struct sk_buff *skb,
+				       const struct tnl_ptk_info *tpi)
 {
 	const struct ipv6hdr *ipv6h;
 	struct ip6_tnl *tunnel;
@@ -471,31 +472,33 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id, 0);
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		} else {
 			ip6_tnl_rcv(tunnel, skb, tpi, NULL, log_ecn_error);
 		}
 
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
 
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 }
 
-static int ip6erspan_rcv(struct sk_buff *skb,
-			 struct tnl_ptk_info *tpi,
-			 int gre_hdr_len)
+static enum skb_drop_reason ip6erspan_rcv(struct sk_buff *skb,
+					  struct tnl_ptk_info *tpi,
+					  int gre_hdr_len)
 {
 	struct erspan_base_hdr *ershdr;
 	const struct ipv6hdr *ipv6h;
+	enum skb_drop_reason reason;
 	struct erspan_md2 *md2;
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
-	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
-		return PACKET_REJECT;
+	reason = pskb_may_pull_reason(skb, sizeof(*ershdr));
+	if (unlikely(reason))
+		return reason;
 
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
@@ -507,13 +510,14 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
-		if (unlikely(!pskb_may_pull(skb, len)))
-			return PACKET_REJECT;
+		reason = pskb_may_pull_reason(skb, len);
+		if (unlikely(reason))
+			return reason;
 
-		if (__iptunnel_pull_header(skb, len,
-					   htons(ETH_P_TEB),
-					   false, false))
-			return PACKET_REJECT;
+		reason = __iptunnel_pull_header(skb, len, htons(ETH_P_TEB),
+						false, false);
+		if (reason)
+			return reason;
 
 		if (tunnel->parms.collect_md) {
 			struct erspan_metadata *pkt_md, *md;
@@ -530,7 +534,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id,
 						  sizeof(*md));
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -558,10 +562,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			ip6_tnl_rcv(tunnel, skb, tpi, NULL, log_ecn_error);
 		}
 
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
 
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 }
 
 static int gre_rcv(struct sk_buff *skb)
@@ -573,19 +577,20 @@ static int gre_rcv(struct sk_buff *skb)
 	if (reason)
 		goto drop;
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
-	if (iptunnel_pull_header(skb, tpi.hdr_len, tpi.proto, false))
+	reason = iptunnel_pull_header(skb, tpi.hdr_len, tpi.proto, false);
+	if (reason)
 		goto drop;
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
+		reason = ip6erspan_rcv(skb, &tpi, tpi.hdr_len);
+		if (!reason)
 			return 0;
 		goto out;
 	}
 
-	if (ip6gre_rcv(skb, &tpi) == PACKET_RCVD)
+	reason = ip6gre_rcv(skb, &tpi);
+	if (!reason)
 		return 0;
 
 out:
-- 
2.47.3

