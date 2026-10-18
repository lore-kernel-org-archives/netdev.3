Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E84A2A5D
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328348; cv=none; b=VGQDRVrMmfbJ6rW4eAAOmsBxEsmoknAO40AyE3q0hyIC901qWzGYqeXoWPq2EnTuhtovKJcIwmALqgHQwLM3cj6YYZbLRX2vjkPBsuMHciCTm7zKei/SSnxeddUc4wHXP42dMsAm54aW3VH0mgo6z+8L7drfPabyU51TUCL5f3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328348; c=relaxed/simple;
	bh=nWS0ydmrO4FpPtgExlGrGBKn4Swl2QUnK8Q7wPcpPf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlBYnIDck9OVLM3yCmIjJ9DmR2+wmr3Z6bY/EhPi/Xk4OncVhOwWFseUey9cXZXXk80vgeqU9gBp+UI0HojU3qkXc//vkL6c4d+X+w8Afs9xfRuxWwZYMlt6uK8JaQeHq3qLdqq9E3W5V6amIgLoF92xlaGHh+veqmYIG6V6ang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=fVnKhipI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="fVnKhipI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2acc1e170cso175708366b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792328345; x=1792933145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzu8LVWuEVBDU9lAlwBSEvZPtderP+BauzcapsS8E9A=;
        b=fVnKhipIoGeId8TdF/Z6g9LI43UOZLwMbalZnC2C5aG/YYEbIGh/OoW5TGfVM9aHl5
         aNX+qUaUErc59ux32N7PzWd5sSjEXFgZycNjt14U9mgPAmETpS4x+rVanzLy4cj4kzMo
         aDmPaOjOwACVCzxpuUNigJPckCWAsdHPPKdE3Ei1dHE54SLNQgrJ5eIZidz0E33FEH2X
         c1Fu2Q5RshvxipWebxzlTPBMcXxMXk/vSERK1RLSzefkri/1/tBZHQoaKSot8E52LqiF
         5OsSjZIbH/npaPFcdsgQWr4Yce2TsS+UtqJl8OAZ2z710HIcq4SmdS9WiHnZEImdatj3
         48Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328345; x=1792933145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzu8LVWuEVBDU9lAlwBSEvZPtderP+BauzcapsS8E9A=;
        b=Rbz/chtCmYK7HoUW5QXnzUIvVjtkUM52UbZSivF3V04o0xvOu5dvQpnSyQ5j4QzwqC
         uR/uK36wK8wVHBRoffqQsfU34tf24gXZkors42Nj3wkGAX8uA9IbHPSptBZqCRt8oefr
         mPArmKm+WUMgFg7vaTFgwZearCfG6GyCaFk6EFnXtXn00nZ9DMZz3WTNz5HmUSMhpQDJ
         lKYmCqk3GJwSJP4AshFBU8J3yg4ShuVlkvSM+zmRs8I/X3R6qrMY3OGJ4h1w92Wxn+u3
         9AGiFjtMOSGNQjgmjYGl37WGmsRj+E8yiBYYz01FyMTxsdgdARdPj05I5m19sildxCUK
         CZzQ==
X-Gm-Message-State: AFq9FYIy1D3BQoyG5p3zlALKbrWULuNZPVvA8BdMEC5rNyQg7r0Ktx+L
	fUTtj38cllj4wWdqPCpHGzAJOwzFBXSTf7VgHbAYwJ85youWjIyOgYYUYR8gmAep5Z+lEKauuUB
	wKiJmubzhDOo=
X-Gm-Gg: AYBFou3XHlfg2O56vy1aZ6mhwCeuSmOM2pxnZSuR6JhNzc9ssDyPZikP1MgpfXwKeGN
	7DNV7vgLIeOZmJZFYIgtNEA1HRBTvkM0mED8zvV3xTBBCKT26qxkiWjQd6Ugy0Yl3btwp2JyZ4e
	Sp4umStrzshYTIqkFeMrSXiJ0vne0EZtfGMbXrEuYCT6e9oFru5vayGJDtUrMvXds00p4mwZlrn
	sfMZDunDQi+weKgjDhme11AFZO0kowzJq37RT0nA3nKbnt+NbSonGn4LxLYUXflFR7jSkRsOJvM
	ohYl3vU/EgZT89a9VCNFB8Pu7WAXjuoOPx2G9XieUjUvXs7rckt1JcqiK5sp57H0j24AxH+miy5
	zfAsngoDcr2ZW/+eMKalJXiXI2Udw63+X1VXEbMbvVhgcza4NlT9Fj2ftHgUIFIDFn0Z/shve0Z
	cktChaq23xfxNrplKYF1f8PehL0OfyI//LgJRS+PaG0UC3kNUJf843NwCXY2ulw7WErcAykC3Wn
	pSQwUN6Kw1vZf2jbsHvvcRqWJX77gzdLOdAxjs+xiqjRGOboDp3U3P0Jnf6ixNTzEcGR1iq+X+3
	EJG/YL8p2DP2bqtJ57bBaB4rIMZeUSj/utNz5YtxqVtg02GB67WgzV3wnIIXn+43NwRMDhZfoD+
	IYz1lgxxo3rhXzOzA4S1EG7gPvbom2JVL+jnJFKKNhQ0yhaa7gQ8LLbC+o1nXYa5i5HYsBdLWrR
	irFk9AHLzu
X-Received: by 2002:a17:907:3d50:b0:c2d:ca32:2176 with SMTP id a640c23a62f3a-c419d540bd9mr324041566b.8.1792328344943;
        Sun, 18 Oct 2026 05:59:04 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm259032066b.33.2026.10.18.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:59:04 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/4] ipmr: do not drop GSO packets that fit the MTU after segmentation
Date: Sun, 18 Oct 2026 14:58:54 +0200
Message-ID: <ba6744246a54f77d4ff5acd72a0f1a1ee695bdad.1792327155.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792293419.git.julius@bairaktaris.de>
References: <cover.1792293419.git.julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_prepare_xmit() drops a packet with DF set when skb->len exceeds the
route MTU, without checking whether it is a GSO packet. A UDP multicast
stream received with fraglist GRO or UDP GRO forwarding enabled is
aggregated into GSO packets, and every aggregate is dropped with
FragFails, while ip_forward() lets the same packets pass by checking
skb_gso_validate_network_len(). Do the same for multicast routing,
leaving room for the outer header on tunnel vifs. ip6mr has no such
check and leaves GSO packets to ip6_output().

On an IPQ8074 router with fraglist GRO on, a 10 Mbit/s stream of
1316-byte DF datagrams routed by igmpproxy loses 14.5 to 15.5% (n=3)
and 0% with this change.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6f2eb571f30f7..0a2c573ceeb79 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1914,6 +1914,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	struct rtable *rt;
 	struct flowi4 fl4;
 	int    encap = 0;
+	unsigned int mtu;
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
@@ -1946,7 +1947,10 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 			return -1;
 	}
 
-	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	mtu = dst4_mtu(&rt->dst);
+	if (skb->len + encap > mtu && (ntohs(iph->frag_off) & IP_DF) &&
+	    !(skb_is_gso(skb) && mtu > encap &&
+	      skb_gso_validate_network_len(skb, mtu - encap))) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
-- 
2.53.0

