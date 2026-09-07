Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DA424D48
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767937; cv=none; b=jQH/Y2YK0uYHhyg3xxDV6fyxMQYjHCbUu9OTMB1Df6k2/NNa71VKHpZetght/sPK6gPg2VzTP3TpS53nIpv7fX7heubwyVO+Y9mdiiV6CxHOwgJEEGv1b3ZzBL1FVleH+RW/qcv7UxQq8wieUFgBU7ABOVlA3D5AbCOvevztr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767937; c=relaxed/simple;
	bh=pkUSS715p7d5hGPiF+aYF7T+6zleozhSlqCpZugoAUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScDmTVlvG5/YBV54JXmrY5SvtzQmEJK9ngEyn7RzNPO+2yfeJkg6RDCjlTsdt3y6SYA4O9SAqKU5Xqb/2dXUHhxSVFyMGDqxEr9Ft4MdxL/7kl+la0wCIA6N6lTpIS0ilNeROMOlYfky5bXc+nYUNaYKZgohj56VYr+GcpAy8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pz3fyRRo; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pz3fyRRo"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939a6937513so113171485a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767934; x=1789372734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BaeqZtHJoEIzUDnyhRVEvnp2Lmbszo5r/MdxSoprwx8=;
        b=pz3fyRRohv7JiSOoUbOBxmjfKVaok8aiCUcPYw0h35M+jS1S47IYrBfKwUFE8Ee0BB
         qECvCgSMmPLJ+UuvuoCvKwqg38S5WvF4uPb+PKuREsLGuJyXu8hx0JNRYWf0z2UaUZy3
         3NP+sMppXEw4tv0u8BoPMpTapeU/sSzF+bCQZLs9u2xF94rAm4r7ppjrZeqjCc18Lsn6
         FnATEMXL9UiqFmhz0KaoqwtsyQf7etfJP+jUvgSrql+xqVrVSzUZ/TWcXY7HTZQd3aOm
         VHSTQjCmgcKY6qFOwl395+mLo4z8LmFGDCIQe3CXA72X8OgwKCsxn/i0O7wjMLXMUp4K
         M5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767934; x=1789372734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaeqZtHJoEIzUDnyhRVEvnp2Lmbszo5r/MdxSoprwx8=;
        b=qHABFwfM+npsixKv/R9qhVbc/8POSwonNbOEVr7Y+JuDIetKNbQz72LIeu45gLizYE
         fN8Jjrci4qnuajnWRZpg07YD3zrJk+rrSI/ja5w6vASE1plhdq4kRQY1CoKpfHw4+uEU
         7g6QCg6Cum1Shs2z1mLeco0Lw9eD+GshWnBQ8AzQy4bSc4HYaVkUOJGaorBq2kouf+jh
         LrJHXYhlHmoX51DtjowHFR55WLkFhivTvWgImO4cNJYjAWtqntZgu7/Z8f8fyWSENzYv
         wOveL2c5JX6314hi+LPS84fpHGE3NUzzHGUkDCIgoOsIFNnOn6TNicHATmtApWUz61EQ
         ubkA==
X-Forwarded-Encrypted: i=1; AKwUvBzlK5Fpue7Sso0VUoQdeZi4MXcX6SArtY029jvY9++UZwnubYswjxsBZCBGgqD+LpYmDIOunL4=@vger.kernel.org
X-Gm-Message-State: AFuF++m0YMMyr+kdT+/8ag9Uf8q95RvNX7KRsRD6Tfw7EH8HVtdnHctJ
	nitk0P9aAyJ+hOtMA8xwaJqGpoM3CWfKoT8Zslb9tO02WahOAnSDs7cus51Z8tbNg6lOSGZ/lC3
	eTyPAdYpNbqB+kw==
X-Received: from qknot2.prod.google.com ([2002:a05:620a:8182:b0:92e:5c5a:beda])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:5229:b0:936:afa0:3661 with SMTP id af79cd13be357-939804a386cmr1669135685a.36.1788767933756;
 Mon, 07 Sep 2026 00:58:53 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:41 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-5-edumazet@google.com>
Subject: [PATCH net-next 4/9] sit: annotate data-races around tunnel->fwmark
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipip6_tunnel_xmit() runs locklessly (dev->lltx == true) and reads
tunnel->fwmark.

In preparation for converting ipip6_fill_info() to run without RTNL,
add READ_ONCE() and WRITE_ONCE() annotations around tunnel->fwmark.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 9a2bbd76d3794849cd11c6530ba1303bf53fa388..e85fa80e80d1ad2c593b860685b9f5bac21e66d9 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -929,7 +929,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
 		goto tx_error;
 
-	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
+	flowi4_init_output(&fl4, tunnel->parms.link, READ_ONCE(tunnel->fwmark),
 			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
 			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
@@ -1153,7 +1153,7 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
 	t->parms.iph.frag_off = p->iph.frag_off;
 	if (t->parms.link != p->link || t->fwmark != fwmark) {
 		t->parms.link = p->link;
-		t->fwmark = fwmark;
+		WRITE_ONCE(t->fwmark, fwmark);
 		ipip6_tunnel_bind_dev(t->dev);
 	}
 	dst_cache_reset(&t->dst_cache);
@@ -1706,7 +1706,7 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_IPTUN_PROTO, parm->iph.protocol) ||
 	    nla_put_be16(skb, IFLA_IPTUN_FLAGS,
 			 ip_tunnel_flags_to_be16(parm->i_flags)) ||
-	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, tunnel->fwmark))
+	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, READ_ONCE(tunnel->fwmark)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_IPV6_SIT_6RD
-- 
2.55.0.979.g7e5102b832-goog

