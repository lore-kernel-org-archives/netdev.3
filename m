Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972353D88FC
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833808; cv=none; b=WaOTjjUK5wxIkUtdtfsXpVhTLSM/HX9mX1ZdKKUAVSVAGn6lsW36sxQo1NHLuQIbaMK83B7U7atJXD3zJ88lmtKboBHidDkcmYqJKWQ8ChERNLB0ydjtmmqldRGkn5n41W9yQc13j7xdMd8w96B583IRw0R1UW6ff/9+K0zE5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833808; c=relaxed/simple;
	bh=upfHv6iyo7Z9EZt8DBtL2SH98IOgD3QK7mWq/Cj82L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWp3qfgf893CU/j9oqWS3dfnsRy6ur2a2SxK1H2vwro60u9A4zZqMR6lO9lYrLYynIyszDzmZHvn/tEGgRZoDfnTbD7na0U/D0YP/NURTRB4imbU4kIORXdWwmXAIl73GfBJa6oWiQEgSRVJ2kuTbarADdOhfsnpV9T6ueOHiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ZoFB+dx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZRt0W6w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ZoFB+dx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZRt0W6w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CA776EC0445;
	Fri, 10 Apr 2026 11:10:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833806; x=
	1775920206; bh=Sa2wC7fCBqVg0vfdquWtj2OzcykBYwUffdHTbefTmLk=; b=Z
	oFB+dx17BwOQIzL+S9thex7a3zr1kJOS+CBiVlIQoIR2XfJVkrYzogp6Fu1z1BVB
	H6vcK1raSF4tq7uipxArz5Vzcnhktz0K+mEZmGc8/A63FlmuSEpXQLB615ud0DW5
	cym52xZFkONZYEwXKkJqn5fKQDl2sMPt+Llm2pKi/Zl9JywC9izrB4A4jlNyRWyu
	Lbb2J0ZJPt/aBJ026mI6P+3CD/3O+SY7+T43z6pvHT2BXnENvS24gtH8nfJmVnwU
	1Msz3n8xMLwCG+NUtEjBPgdXErd3fRSrxME9cnP+BNQHmyY5mLFV4nBnZZdOjLva
	gFewkbmHeykiIqWFIW9zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833806; x=1775920206; bh=S
	a2wC7fCBqVg0vfdquWtj2OzcykBYwUffdHTbefTmLk=; b=eZRt0W6w+R9cxXLGL
	Rbdo+8/N2KXJ/EipFDuu1VzvLV+Egx+clboKyfno8PW2Iz6Lrs/9oKXjthL+Avyc
	aqQ8aosbpcgoi0xGSFA7qestewxQr2p2PzUXLnz/5XaJdtZjpL/oPz9dGekTM9vk
	b2Xz9pbXOyf58xU5VIZ/6ptmctD5VuxzQD9J5ZRjHPMp9wjZh8DCXcXc997lB+cS
	CHi+91LWmtEhWlgPRLYdVz1RBmqGhCrVGJQwAxUIfNPqChauGZD53WGbv26PhpHJ
	qPIYiUa1ETlpP5AUDLfjMOX0igt4clJ3hdBkJ6NZ10HTp1c9XMOLKcyOMRpH8C1F
	Ixivw==
X-ME-Sender: <xms:zhLZadyI8VjuFvkeymwm7aMLd57kzVrMWS4JBQbcn_rfosb8SVE8WA>
    <xme:zhLZadtgRwYXpxG2yR4qW_RMfgY87Thc7lDcL3T8s2ZsaizctRnvZMiMPUR4e2Q5B
    pnhWvSvQDj-IswgXDhVDouP6Zaoc2gVjvwqAaO2Wp4oUD1DJ8hhbKU>
X-ME-Received: <xmr:zhLZaXFvMGLQ0AAVXCdUAlSxXJc6mwGieIEPC5tapgW5Ko7ElwbAfmqDseQRig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:zhLZab7IfGMmr0aeShc0DKvgDcipkOEi_hKkvtJkiGDK308QZDXtQw>
    <xmx:zhLZaYw3T2ZLWNKgqSZ0kdXIpJGamBfSv-guJeOwi6PQo9bN6zdB8g>
    <xmx:zhLZaR3OZQy3PQjjBLO-PIZwVM2styEVdgJJFg0yJqjewkktYBbCTA>
    <xmx:zhLZaT5YlPseaoU6HlcueHl5_nvE6MJtJCo1oSWHVZq92FqCdpIdbQ>
    <xmx:zhLZadrIlqpy30LqZagdaE-UI4LP0g31KU0iEhuPf2VBU3zGBFOLqsPi>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:05 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 01/12] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Fri, 10 Apr 2026 18:09:32 +0300
Message-ID: <20260410150943.993350-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
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
2.53.0

