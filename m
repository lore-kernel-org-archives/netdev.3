Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.39])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5C357CE9;
	Sun, 13 Sep 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789329390; cv=none; b=IoO9bB9R7zo5TW6L9XYXHZG2bVwrh3Ws93GsGyV1TYyfqSIemWq4FTr4d8mnDGIRFk1xSd5a4CfcHpr2SeNZbXTHnA1RXgfgS7o1RD/gdgdNo7frscIwXuZm9+C0oD8FK6bdjuwd/kACMLor2LQrH3zqueNArjr3gctBKOP6hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789329390; c=relaxed/simple;
	bh=JmuAd/D3KbaJprIWm4vd9LRfm3eTu6aVdgQSQQXbRLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZXhLfMBUSxzhL3LjPnHD8hCffayU5OqAj18SSXtq/BMftlNY9RtQ2Gw2IlKHlpP4UYByNouVSHHrpOCZIs445kW7bI3Y4/CV9ylAX/pJwOB+ORr1Lf5SGa0PoYiup63V9jdUumR4qVMqusrIts5maSFrRV5XdcWC8W+EEQCDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=pL0v5Dq0; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=m4ZR5+W1; arc=none smtp.client-ip=160.80.4.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="pL0v5Dq0";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="m4ZR5+W1"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68DJjAER019500;
	Sun, 13 Sep 2026 21:45:16 +0200
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 081391227F1;
	Sun, 13 Sep 2026 21:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1789328707; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=aXrAdzLpygAHb/8pjwLQyRhm/egTXtHyBi7542GKxGA=;
	b=pL0v5Dq0x/qJELMP0pvFrq9jfeIgvSHmkzD8B25MHFUPKB9YFgpTK5CzE5qa3P1bfZnf98
	X/utHN4+78vmFtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1789328707; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=aXrAdzLpygAHb/8pjwLQyRhm/egTXtHyBi7542GKxGA=;
	b=m4ZR5+W162HW8s2L2mCu6RnQa1aMzfdWqHa1e4CM5XLO/Wrzm8q+iYUbDO24VvP7YgU9Rh
	aVGp0kzhtJ8knhwsMJI8l09SWvgrm5pZs42Z4Ftc5FGd3MExhIZuVvq/NBwpcDishYSNR9
	wEV7TsKXiWHuLsZmWpanW6EydZGjV9atfDfTqcgBRIN2JybRhFCItxo9nG/2GvXgLAr3Q+
	W2yJh3CTRpVGmLjA0P/BV2yG28363C/o/ZQ2zelwLaQ6Tzdi5/2XiZkN16PYguuLhT+++1
	Asd5eyMczoAKX/j8glOiW/lpuD/JdJcmUZvsi5oW6zf2Dd2MyY1tr/ULtfiReQ==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net] seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation
Date: Sun, 13 Sep 2026 21:44:21 +0200
Message-Id: <20260913194421.31-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

When an SRv6 packet arrives on an interface enslaved to a VRF,
vrf_ip6_rcv() sets IP6SKB_L3SLAVE in IP6CB, but decap_and_validate()
has never set IPSKB_L3SLAVE in IPCB. The bit stayed clear in the
common case, and with CONFIG_IPV6_MIP6 the leftover frag_max_size of
a reassembled outer packet could even set it, with no VRF involved.
Commit 44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
decapsulation") then made the unreliable bit reliably clear.

The effect of the missing flag is visible with End.DX4 when a
delivery to a local address of the node reaches the socket lookup.
For example, a UDP socket bound to the enslaved ingress interface
does not receive any of the decapsulated packets, while an unbound
socket outside the VRF does.
This contradicts Documentation/networking/vrf.rst: by default the
scope of an unbound UDP or TCP socket is limited to the default VRF.

Set IPSKB_L3SLAVE for IPv4 in decap_and_validate(), which already does
the same for IPv6. The socket lookup then matches the decapsulated
packet like any other packet received on that enslaved interface. Such
a packet matches an unbound UDP or TCP socket only when
udp_l3mdev_accept or tcp_l3mdev_accept is set.

Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 7b5212220185..d1070aec7b72 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -257,10 +257,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 		return false;
 
 	if (proto == IPPROTO_IPIP) {
+		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
 		int iif = IP6CB(skb)->iif;
 
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->iif = iif;
+		if (l3slave)
+			IPCB(skb)->flags |= IPSKB_L3SLAVE;
 	} else if (proto == IPPROTO_IPV6) {
 		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
 		int iif = IP6CB(skb)->iif;
-- 
2.43.0

