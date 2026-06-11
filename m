Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0629DB9A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206225; cv=none; b=RJkXYLvkKzLZySEQP95KeI3QP1hYH2lft3nXIHcybSi7HUqioNOqdQGLxn8fGfyMqwMLv7/aLYkxwGNJ2LlZBazhXRGr/tfxfxMs29vhBmemKSRhIKxFyVUlQPiY4OVL7wpugmX3XCtvNA9KYyHsuOPuoxwmuez/xAZ4tdjmPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206225; c=relaxed/simple;
	bh=NmyU+LzzDIVulR+Wa58VSzqOQTcNA5ulDK0vhrFu6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWw2OAf2rs7d+vxVZHEyzFe8LDQxawGBhQBHlEoZi2RWkgelxfa5B+XRAbxq3BvU4ctSXfHfSPcQcAm8j+hAvyefat28vBkwHICBXu8uGibCQkkZ9U37JKBCuZRLFpNy9YCdL5UHX6dgHG2PIhW0wYOkseTUY6KiHfM547XW7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Htr+9RuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKFRveBH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Htr+9RuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKFRveBH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 003FC1D00105;
	Thu, 11 Jun 2026 15:30:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 15:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206222; x=
	1781292622; bh=C8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=H
	tr+9RuUpRPrvc3hpuf1Ro7d7q9bs5WLHmJ2GCCrJjuNhm4CBlNZ0YsActPNYwWFZ
	tAxKrJogYGn24LOG6xkbYA8ypbAQNsJZv+gvm2xqPXKXNcnm/kQbfsgotamDKr1R
	PAD8N9pv0T94qg8342ljWi1qR227Y0Y4uc3vApKESM0EIgOQcAZL+4vnpo2lHepl
	6gsCZmJ+C6z17jHFqRn/zZICMlWaM9ZK1p9YuPCITxltN0shV06tKchTgyfhVnK1
	QyLulK4taNq0woqWZcwHsbCjazS3i1d90hN99+1h1/PdWR9JfLRciXpu0Z/TAaXW
	aLFicad7gPa252ECRZkAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206222; x=1781292622; bh=C
	8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=QKFRveBHFTfFTS7WJ
	h9E8jqs80LaOH3J06jdsSI6e9VqzrtQhLw70k4dMagebMKgYsBLuVpxRTseHfkoW
	m/65ZZSZgYRmpyvKKsC18m5VkGIVP+e4xpI3LE2X1v0u7dt10IJkbmquhbEJTxmB
	xcc/EdRKhDcqMYQGE5xGJNErLP7hD+yD5wimg+npMOaOUoexF5Ks6KRLFHd7HZvG
	aAlCd7aoTlQtI4SmE7blUhDN6Kr+bfuPLwJLJBYc0WW5PssnMxW6bVvFPQc1g8PM
	yeInlGtSQ3tKdYJXVtskHfCnU4VFd1ye4Au7SsJsd2utGASE0H3k8JNbX92KGC5K
	d/VDw==
X-ME-Sender: <xms:zgwrahjF6g6iQ0rKDFC510M0FYd1QQfV2yv8oNQ3NMgCVn56r-uyZA>
    <xme:zgwraiVFq3a9gtV5rPxAi_ddKAoKZTIl37ejvwkCZR03KrZsn9MhWQ6tteWfZI1Cb
    RV7YiMANqgB2KurOHhkgMf9SMaeyWfjrNDI9yuXPSJOYhKe3wl1tDI>
X-ME-Received: <xmr:zgwraitRHfUfGI_8gBPmu1kBs8daXhyjKRgd0G2VX7dxVEJUisI5giJQMxiQ3us8c2KYl8zy89tyOeXPBp5Acgc>
X-ME-Proxy-Cause: dmFkZTEiC3WdhRi6lmpvrurG1zsBSCtiqP0WNrqAbghd5WJJ5VA7rTMHapznV9StKJaapp
    RCFRaoACDzmV+WD4oXwzhVyqAYewgJwskY7+pzj89kGgG6Z5gh5qwjqnnl1xPZ9xw9XTL3
    6h0yQhC9JWLW9+mdqRsn8FaDYVGkm04cbHUvo+O2iHxAKiVWkwOc7fmUFydM3Q3w8Zl56u
    v+GK2GCObb3b4V4RDlvLsMODXfS6N+5oUdni3ao7DuI/y5kjlxXKXH9JMIpsen+KUYBZ/y
    QM6GhQcs+90PA2n4UkkP5wtLFs/TKnXuu0mgwtrACzJAoOCVpXiPf0MWRzXp2RALkPmoKA
    IlypGZjdzGLazEcvmYhhi+OK9PfwnqEtH8VjlSzmrZv7Wf0jmInVIQM9uuQwUHrNrWb/aZ
    r4oo1nCo8B8izQvipukksevbel161GGQNzLJoBSGs7zUqEh/TUgtJfeUznWB03FN4uTzm+
    JXprvI1PVVElkpuaTA7weBvtvz+3pA5o0F+GS1/SlT2ER2s1/b951gPZ/KvGK7NMReAqiI
    zs/7g2Kbf8RasjyBlWWRj8cTKjnYZw0Az0+27QXcx9TaZhVxz88PEpFwAchmMllD0R0MH8
    Jt3SeQeRIzy+c2dhjDwsiDnklBJHeAcAg6BfdBaK/HABfELpq5gzUvjTx0Cw
X-ME-Proxy: <xmx:zgwrajbwUBuzXCxit6nJrcrjtWjbE98eQnfFKGFcHkO6f-ii0jFAlg>
    <xmx:zgwraj5n8GHXFzkK5bsVClbvQUa2qyPvzQ7bFvhRaH_NHLkcBFO9MQ>
    <xmx:zgwrajmC68N68Hz7i7LLzw738KQnGJAxXQR1prGJ8GBOlpV_SSKU4Q>
    <xmx:zgwrahFbkYllBHBT3_91rY_amrHaZR7oYztsZC14821mVPBJEHpm-A>
    <xmx:zgwrah00eo-nK8gv9jJgizMa4_GTQIjmo-vqXYvprBpH65MWYASMCocb>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:21 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next v7 01/11] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Thu, 11 Jun 2026 21:29:45 +0200
Message-ID: <20260611192955.604661-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Similar to commit add641e7dee3 ("sched: act_csum: don't mangle TCP and
UDP GSO packets"), UDP tunnel GSO packets going through act_csum
shouldn't have their checksum calculated at this point, because it will
be done after segmentation. Setting the checksum in act_csum modifies
skb->ip_summed and prevents inner IP csum offload from kicking in,
resulting in a packet with a bad checksum.

Add UDP tunnel GSO packets to the exceptions, and also add UDP GSO
(SKB_GSO_UDP_L4), as the same logic as in the commit mentioned above
applies to UDP GSO too.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/act_csum.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index a9e4635d899e..078d3a27130b 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -259,7 +259,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct iphdr *iph;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
@@ -315,7 +317,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
-- 
2.54.0

