Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7305E429CDF;
	Fri, 17 Jul 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298770; cv=none; b=kZr6t6FYLvxN/pGKABhX7yXoyOK2IUwvG9fBbTA0gwYhtPPT+hbE3EdPUE7RPR2P/RqB4HulP4IrCGW4E/wG1OCH1I/Y4IdvNgYsKzx1NG/9Ym8isLqsNPshSAHX1BmdGhoSXS2Ue96Ssv2Gpnvr6Pw+xGzLqrsVY1y9IetvLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298770; c=relaxed/simple;
	bh=SlDOV5HEiZlvLrGr02vHURpPJCtkUDc2F9slhw6rNQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCkFr7K8vXki7sBRyX0QepjOvZyEPik0W2mAxDdtvoywGNRoBdcXTqzq9WF8epIA5AeIi2WYNVPA8SQ3LjxrozA8omtXeVaNPEPhb7HcBJuD0IelI0lVYnMuXVPaYILE6CliZ/ewWs7KNvg+8k1W9mqyNwvu+SuE9Oe0pOoFuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=L5i357pz; arc=none smtp.client-ip=111.202.115.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="L5i357pz"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Li RongQing
	<lirongqing@baidu.com>, Kees Cook <kees@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
Date: Fri, 17 Jul 2026 22:32:30 +0800
Message-ID: <20260717143230.1836-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1784298760;
	bh=KD96x89q42X1YxXnAThpL74UYBHTxmO7xHWfal6hLkU=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=L5i357pz23GhuPZ5U5/HNH2mxZWXHv48CUkBijQsanbPVlEVPlC1ViBvGpcy/kias
	 6YH9J6V/MCBvQKCmb2qKx3ON+XftGmirlT7vPPIH9SfTUx1oDDsvH/UfYlPKneU7cR
	 QLPznJy6akgUtQe17pzJrhmcMXI946LiGe3OugfH0tk3ugkpdCKo8C4bWLOF3B94lk
	 VBdy8ZWzVF5arozc6NXiSP0kVyCh2hFKKzdFqSKCoHtQM78yM3R+c6d1HWvgwGOaPN
	 KRILmq6XGQ3LB7RGnpDUoa6836A2awluqXMdksNQAuCMCHn7fvGancYvJp8nKe8Lll
	 Vh4ylnXpPDU4Q==

From: Li RongQing <lirongqing@baidu.com>

In raw6_icmp_error(), raw_v6_match() is called with inet6_iif(skb) passed
to both the 'dif' and 'sdif' arguments. This is a copy-paste or typo error,
as the last argument should represent the secondary interface index (sdif).

This mismatch breaks ICMPv6 error handling for IPv6 raw sockets in VRF
(Virtual Routing and Forwarding) environments. When a raw socket is bound
to a VRF master device, raw_v6_match() fails to find a match because it is
not given the correct sdif value, causing the socket to miss relevant
ICMPv6 error notifications.

Fix this by properly passing inet6_sdif(skb) as the last argument to
raw_v6_match().

Fixes: 5108ab4bf446fa ("net: ipv6: add second dif to raw socket lookups")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/ipv6/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 3cc5869..b88d364 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -349,7 +349,7 @@ void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
 		const struct ipv6hdr *ip6h = (const struct ipv6hdr *)skb->data;
 
 		if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
-				  inet6_iif(skb), inet6_iif(skb)))
+				  inet6_iif(skb), inet6_sdif(skb)))
 			continue;
 		rawv6_err(sk, skb, type, code, inner_offset, info);
 	}
-- 
2.9.4

