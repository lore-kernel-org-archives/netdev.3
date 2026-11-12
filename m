Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457465;
	b=a7Q7kraiWq5xlJln07MpWFIqHstGODGeejeZqbliA7oB90lELdz1AA+B3fY4rrkzzEwO
	 7JuHRYTmcV0yQ93U0pm7Keuc8wwCrAYBoGF+wwPo74nzlMZEfoWRO6r6QABPN0snAPsbk
	 /FQMsvLrRJL2pFmj2c1cXsCPSugN1TECDwDaxFUxwm5ANpmh/ifmRuXio42iYAFtNUnxB
	 e6YeEB5i8Z7CtlZ408OV9iRRdzAGzZBzAY108pDlW2ogw1joXzCpNovz93fMrluc23bIk
	 1yCMd8WpIZwZtvgI/iJ2VrkprHnKvwvsDIBJHuVI0AWylBjIxkxExA+vZO7h57Ifsbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
	b=r0tT0EUZEKTyC4BG2VuX/e7GF7LPYu7wMtaU9jcnKmQD3BivrEWA0T1/7LYWZ0rIEJt9
	 I6oDCQBa9z8OHR9cmvHJVtMcWgyq7q5pGSpatkRU48pt1QIAfJd9Gm1Hg7t5IkTsxzi2j
	 QrlxgnEMDfOGb2lc47u+tRfg5xP0oRNxvWad9nApCIVpaz4x3jHGto9jFzf7ODF8wfJdp
	 FfWgWnILMsuX2D09HXYSMHQbn2jDYfkPEgg9VBjF5g0YPXRIDLrgfdh8VyVsNrmdKCsS3
	 z0mdtpbg7sLUETLyjR1QnpVW0PdMBHUe2T9Pboy7jiRQk13B/lNVqH9mT5j6MloHeNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dZp+0eOc;
	arc=none smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FD606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dZp+0eOc
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f2a0576df3so190043b6e.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794457464; x=1795062264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
        b=dZp+0eOc7wf67+aV9XcOB9yjsrNEhiEJuWZRMp4y85VlJLW8OlwqJMn7CEYTRAzwg3
         W8VJKgm/oGP9cCmLAHuHiJ9izkrdETd/R/a4uRiAditF26dNTa9ZRgeHOb8MaI49JokK
         Zya0oeg80Id2CG9kYrNJAP/W/O/+NQy7mg0mQuQPdaFLRwmkRd7+mpIou1v82/6lJjM1
         MfhuQk4m69Ia9zNaQS/Sqsoovgy2nt9aMRJxgddK91Ax456Qqft6YjtAOfqEpM4/HuIx
         cfAj4tPrB13Xdt5Afph7W/8pPWseLrqRPszMQitrPgVtUeuW76plj+LOoDYA+cDWyex1
         pktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794457464; x=1795062264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpp4FX5gZJokt1GnwgH1j6FAHpdM7kiuFK8F/Wda8qU=;
        b=fmV4rb9Bawgubn8d1Vquhu2megPR4YbDehA2vESJVy/ituosAJnMxjjnezoHZ/IHh6
         ElMvvvNa/v7iFB5kLGiCjNlq6zo5ZOp5SFMZyLga5jtTwPZV/PJ0N+rwmP4RAcHvXo4m
         OQyVyvPl6ALxJsBIoiklXSUvZk/xjOPhwhXP5ikh9o2gxg5JLgsN5aeO+5UPIe0DGB7u
         Cwj117dwCniXLh/psF7eXQS8+XgBFH1KsPjtUmBrG4j6vAkM1tA7656JdhBUQK+59K6Q
         wESj06XQMvBRJyURaopTw9eLSo7q9W3FaWkYdY/V+zRFAaagjZop9D1e23hQl82upeZH
         2O2Q==
X-Gm-Message-State: APuU4Z+/7eg4O2GgyadUvazW/aCiKCUPIN+deMd/pADVsqx3ct4SDx4F
	Yn4dvft+p5HdNLQdjIQwddgxuyUw0H7Vs4epJRpYE/XtqkokyKYxR0E7
X-Gm-Gg: AYBFou0nP9fPtrj7fN3opNN/DBdalYFIXU5fki00lz71kk5d3ttcTnLvR13SF9haqgi
	npOw8HGrnzje8V8Lj9oH/509TKhZY4y4gJlB2UbEsBopzHuBlhugUuqLexpW93CYsbzOppFnA9E
	GURcCIgTXodpSbuUskTpE2Qz1Q7wcWnsnhteb07Igb5OVR6PX7B8KtQ26RVG6Y9qGi/q/nIebLJ
	oNFeeHWIeBBGr/96eM0eNRI5Ncu4oFfjgimQNgBieBD7OLRSSZUDzrCdvP1PRpEBcfUkcfqxWEc
	zaxOdJyULzvoFeaKefBh4IxaiwM91Bsx+37SL+dVtqwWEiz0j6UcVxHtdCxLkrrRIR3Wv2jyh8d
	lyHlhbWAeYH8NN3ljGZgeioWCcjNhNvvcu07RaBe4Fx8Pl0ILbMgtxF6OzahrjBB4rbgmMvwJYv
	L/7Rb44SpSxdsmlX66CJQX8v/J2S14evcr706yw9rBIpfbIQie9dDsS7Day3ok2CFJoZiCVDJ9b
	/WfnNWtKH8hmI9wHB4ftZTSGUZ/SYda04sS++YvKMQ+oqxcdYFGgKgx9urqEzepe0tX2C6Q4gzw
	qckVVuh1HGdhOsYD3K48X3xrGdBUBxbwdg53LpKbu0ghkFum3L8J0rE5daZphrL+qEQ=
X-Received: by 2002:a05:6808:1246:b0:532:6c52:9778 with SMTP id 5614622812f47-56cd65417d6mr1113652b6e.20.1794457464100;
        Wed, 11 Nov 2026 20:24:24 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905146a03sm6947187b6e.6.2026.11.11.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:24:23 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ip6mr: prevent info-leak in ip6mr_cache_report()
Date: Thu, 12 Nov 2026 12:24:15 +0800
Message-ID: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

The non-WHOLEPKT branch copies the IPv6 header at offset 0 and then
appends 40 bytes with skb_put(), but the mrt6msg is written at offset 0
after skb_reset_transport_header(), so the appended 40 bytes are never
initialized.  They hold stale heap contents.

The report is queued to the mroute6 socket and copied into the
IP6MRA_CREPORT_PKT netlink attribute, disclosing the stale bytes to
user space.  The stale bytes can contain kernel heap and image
pointers, and the report is reachable from an unprivileged user
namespace (MRT6_INIT in a new netns, plus the non-root
RTNLGRP_IPV6_MROUTE_R group).

Use skb_put_zero() instead, as the IPv4 code does since
commit 4f34002e2e376 ("ipmr: prevent info-leak in pmr_cache_report()").

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 7bc570c8b4f75 ("[IPV6] MROUTE: Support multicast forwarding.")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index dd0638d3c3f95..b7ae220d6b21d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1154,7 +1154,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	/*
 	 *	Add our header
 	 */
-	skb_put(skb, sizeof(*msg));
+	skb_put_zero(skb, sizeof(*msg));
 	skb_reset_transport_header(skb);
 	msg = (struct mrt6msg *)skb_transport_header(skb);
 
-- 
2.43.7

