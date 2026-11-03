Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741708;
	b=UTJoiRTTSRO76gna7rpbWrn1IO1joJOVg0Vs89rf7+ZWB6fkz3J/i8UY1+0yvsNXBori
	 uKBY4DMwB61wt2kkn+eIo/+NGEuk8HpockBu7gYZiGcFR+OR5E3Ed4+atTj0wo4kRULJy
	 R1Mt7ADu0dHu0GLIkYPPfc1Wj0Ihz4GcrFwTFPTHZDHpojJdYQFakkLkOC9DhCx6nKpM+
	 x8djritXfkNr0d+H9T5/wPLngZM7LyUdsjVli5EREw/HrOc+osPuWK4rEC8EkqNLqgKTT
	 eOaR3rQW18PAwxqHZYlNvIJxEgyirrDH+zMAq+oQgKUXf65qogr07jiga9W8To87cGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2/Oq2yxr5c36O2jrWUkxKvnaxXC/ugdrj8Dp7ILTXKU=;
	b=NealTsJXgbRfV7x29A86Fip4WSftoc5wKDsvka3BMzMX5CSEeViJWC8MHk/rC6oMqJ5+
	 1XNGpeXU1YwnaRzThtVMRTthvpcsbiQGeLBNWpP+334CvlzIU7UTNTms9eU+hCneC10+c
	 1XDdHJz83SFNOMdBrgRI8zBiluX3FRVnd99qgdCLiuP45BxWzE7uKoG4NinrHuby4uS8/
	 +U5ZAc1l41920+Mq/SmyI8g/g5TlPSBBARMjK/Dc67VNywKS2ZfuSdo2CJwDpUP/681ED
	 xhdySR5Y+GukEhBdIxYjvQstcHDmxNZolUUh8ggQD9WlbDb5Y0JyCSAn3hjEUetbqIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lysk.ai;
	spf=pass smtp.mailfrom=lysk.ai;
	dkim=pass header.d=lysk.ai header.i=@lysk.ai header.a=rsa-sha256 header.s=google header.b=SujUWrcy;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BF606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA0BF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lysk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysk.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lysk.ai header.i=@lysk.ai header.a=rsa-sha256 header.s=google header.b=SujUWrcy
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c445c95d553so8339866b.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lysk.ai; s=google; t=1793741706; x=1794346506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/Oq2yxr5c36O2jrWUkxKvnaxXC/ugdrj8Dp7ILTXKU=;
        b=SujUWrcyDIB78G9Ozq452zDuE/vNNQ0L+EvDHuP97QxnmqaVgqUJxaftfA5bXLdw9V
         jen9UVfmbKSuCXux5S10rKPyWAHWlB3F7cAKcN+WfkyDHzjUdaVHdDNfu34lkljpTr4B
         A8LWur6Q4HbENP4vMYSsW00CI0LprtvhzTnQfMFHu8AO1WVbbTG6625aebOepiggqBvR
         0OT5wublgFG6JLbRrciz+bJwM9/OwpHAn9RIiFIc6utz5ai0IK/dx99fKlvXbNpB4HQm
         4Fj+nK9awyGJMhLQttYxO19my2qLxj7gmXhxJRZfZ5AFsBmtIE7V7xUHCjDhz/ElvPMo
         wMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741706; x=1794346506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/Oq2yxr5c36O2jrWUkxKvnaxXC/ugdrj8Dp7ILTXKU=;
        b=q722nbfDMZuBU/JkqHscIQuyjt/2jaTZhIV5JAzBe/bsXbV/B2nvD2gTGYA0F773ie
         zXi8I/WgM84yb40bjWOlTEQZCXoBnS/ONwfQ65KBP0owJC4Hu0JAN+1RxoFPcSzaU9sE
         9lreEG3sVgGDdBrccoJEoiIWRpA6O30t+y/ilQY2IWFo1SH9ksnpLm4We3W53iz7+dNJ
         fPcycg7tsoZLgJ2KyFhT1MEJb6OmmO03feZe+M/RsIb6xVQKbN5/3PdrjicnDspqv/9v
         K8UbVTLtLBTsBZQT00vWLIh80m1c+ri771c5M74tZYTELLtrPE7zz8fCUCVdueamap/K
         L8Sg==
X-Forwarded-Encrypted: i=1; AKwUvBzDH4dYpNnepFV/CzZ7okoEUQj4Rs/DXLazs1sUha1R0BuCgHTi41f2LQdQE6/6VMr+deFa51Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uzfUPYQkBC6z4QCNcaBjxZtmT0IZYyr0SvPeV7uMLUGtvWekc
	Fqcg0h8OY5XiUlZapyr9Z4phG70Zv1cvzv8mHt5MpxHW9JWz90INzS48pT94Z/i0tHko
X-Gm-Gg: AYBFou3KAs5IE+Yi/z+8fZSC24nM8KF5a+2DBHXbOxA/8VbSEDVLeKYwquKX3pt0BAP
	gBI1AXLG6YL1kEsPETh503nPap3WqZZKJ1YZyk+SluZWW162e7wzRAnI4zLJicBO2a17wOZgt61
	rgQO5nFfiUn+v62S1bgMXobgrtZuZ1tWWTG6HWUB+8ksmfsQ54puAce+SztTcX3wB4AqUyZgMW1
	yawc7v2Ya+o9d2fLvH7zsUfjnAMrNJcjV97DNCDR/VQZOlfy77b3KNul1AIf/HGsKemNrlIxkrU
	e0kvV1YIyBFnHciCZrp0J+096KuwisbU1g6weknUy9i92c/aJPXHnxMunRHzbZGoQk74DL+ISeg
	9Z/Yq6zsVF1aFrXWu5oCZCKrZbZFUCSGN6MGTZY4SxhQpNR59GFQ0P+wsbmMcDXDdYzQEIrZWMM
	yjBvdfG7Rac2CZK/6SaouxhGyhYxdpRxgVTEdemUY4hUjWUl0/CjBSM1If72ZlX2FMi+/Nz6+zl
	RuFopidQ2WOQx+OhcxWcCsQhZnbf79ALNrNkIjPVFOTWSSt3S9UqqA2HXH/KJAuisq6bMovLtLs
	qfBq8ZroxIrIJYrbbnYLlQ1ke2LtdzOV85bk1gsh/HkrLhXzDwma/GmEabknlDDiPjigQxKV9+2
	srqsiT28rFsZziUroeOAi3yzVz7XB+Q7dq644fMjV/ibc67dkNxBRMRv2/LTZ0Dwnd2OoVpwXcA
	z4I9R/nV2jpfthrgS+2yfeSofn1zTKeDP8GaFx8r7mx2daZmWX1KDUMrpSFnbwZcM2uTuxiH3AH
	NCvwuxVDVyhU+D0YiXMaNc7mnaAPjGRX4lbJg==
X-Received: by 2002:a17:907:724a:b0:c46:645f:cee1 with SMTP id a640c23a62f3a-c4ca7ae41ebmr1308021766b.42.1793741706083;
        Tue, 03 Nov 2026 13:35:06 -0800 (PST)
Received: from turris.internal.popcount.org (2a01-110f-4328-c400-0000-0000-0000-0001.aa.ipv6.supernova.orange.pl. [2a01:110f:4328:c400::1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e46a465sm2548766b.58.2026.11.03.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:35:05 -0800 (PST)
From: Marek Majkowski <marek@lysk.ai>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Marek Majkowski <marek@lysk.ai>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH nf-next] netfilter: flowtable: tunnel device poisons h_source of fast-path frames
Date: Tue,  3 Nov 2026 21:34:29 +0000
Message-ID: <20261103213430.2850-1-marek@lysk.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
References: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
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

When a flow enters an IP tunnel, the forward path discovered by
dev_fill_forward_path() starts with a DEV_PATH_TUN entry for the tunnel
device, followed by whatever carries the outer packet.
nft_dev_path_info() handles DEV_PATH_TUN in the same switch case as the
Ethernet-like path types and copies path->dev->dev_addr into
info->h_source if it is still unset. For a tunnel device dev_addr is not
an Ethernet address: ip6_tunnel stores the 16-byte local IPv6 there and
ip_tunnel the 4-byte local IPv4. The tunnel entry is the first one on
the path, so its "address" wins and poisons h_source: every fast-path
frame is transmitted with the first bytes of the tunnel local IP address
as the Ethernet source MAC.

Seen on a DS-Lite setup, LAN -> ip6tnl (IPv4 inside IPv6) -> PPPoE ->
802.1Q VLAN -> Ethernet, with conntrack flows offloaded through an
nftables flowtable ('flow add @ft'). The first packets of a flow, still
on the slow path, and the fast-path packets of the same flow differ only
in the Ethernet source address:

  slow path:  d8:58:d7:00:2e:bd > 80:ac:ac:39:ef:c2, 802.1Q vlan 35,
              PPPoE [ses 0x454] IP6 2a01:110f:4328:c400::1 >
              2a01:1000:0:1::2216 next-header IPIP, 192.0.0.2.40010 >
              1.1.1.1.53
  fast path:  2a:01:11:0f:43:28 > 80:ac:ac:39:ef:c2, same frame otherwise

As you can see 2a:01:11:0f:43:28 is the start of 2a01:110f:4328:c400::1,
the tunnel local address. The PPPoE endpoint binds the session to the
subscriber MAC and silently drops the frames, the effect is that every
TCP/UDP flow dies the moment it is offloaded, while ICMP, which is never
offloaded, keeps working. Received traffic is unaffected.

Do not let DEV_PATH_TUN poison h_source: skip the assignment for it. The
real link-layer device appears later on the same path and provides the
correct address; for a path with no Ethernet device the address stays
zero as before.

Fixes: ab427db17885 ("netfilter: flowtable: Add IPIP rx sw acceleration")
Signed-off-by: Marek Majkowski <marek@lysk.ai>
---
Found while testing this series on a Turris Omnia (Debian, armhf) behind
a DS-Lite ISP: with the series applied, IPv4 flows through the ip6tnl
were offloaded but no fast-path frame ever got past the PPPoE
concentrator. The problem is in the existing DEV_PATH_TUN handling, so
it applies to net-next with or without this series; with the fix the
series works here (tested: UDP flows with a fixed source port, TCP, bulk
downloads through the tunnel). Without the series the same wrong MAC
should affect ipip and ip6ip6 tunnels in front of PPPoE.

 net/netfilter/nf_flow_table_path.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 841f09943..4ca6e09c7 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -121,7 +121,12 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 		case DEV_PATH_PPPOE:
 		case DEV_PATH_TUN:
 			info->dev = path->dev;
-			if (is_zero_ether_addr(info->h_source))
+			/* A tunnel device has no Ethernet address: its dev_addr
+			 * is the tunnel local IP address. Take h_source from the
+			 * real link-layer device further down the path.
+			 */
+			if (path->type != DEV_PATH_TUN &&
+			    is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
 
 			if (path->type == DEV_PATH_ETHERNET ||
-- 
2.39.5

