Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE044A3E6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292690; cv=none; b=iUoSa7vCfEEjJddEl1yGtcpJYZ65XGU4EUQ2iiba6C1z+7b7q7tRpZfV3iWslPcY74lFjJbzBUxJ1tdhP/u+5rGWBpGQMo09dBNSAHeX/5o6TrAN5GR1U/7WxgE00puyBOX3NFB7VccqgVzD38znhRdxdD7DpxxS6n/geX22o7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292690; c=relaxed/simple;
	bh=h5g19SztFkEyFkjk0/cKFCbVHJ2HbodvOjb/zahKntc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCWjOuRf7IZqAroGCIfDUdkmq5cvEDYIvUuZOsSi9bZUkOYiwxSnCM/okbQt6DGTW5+rqSHOp2nqaQCCNGJMv8iY+Q1bFliVZEHuafFaAC7+yyJ3ftlo4ASs5tYqGPHezHmmXFhS71mZ2jo+S7EK44M3L304OXcpE6bMDt5Zquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Y/F93o5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7qU1AGm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Y/F93o5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7qU1AGm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E457D7A00AD;
	Tue,  1 Sep 2026 15:58:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 15:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1788292686; x=
	1788379086; bh=LeYtaEEhyDnwQ2HLainJO/J0XK6yonvKpQawt9qdEhY=; b=Y
	/F93o5SEDBsd6TFmrODp8PzwBFKhHcZNR78JvQYoqGjb7H5jQJ8R4R7fyOtwYDLR
	SQlG4vhcORaC310WElAC2PAo83rMXQnuI8fBneUOLrIdYFCYNHlMndiLVfGMIjJs
	6YU9SYuxkVdMtbThP8vqtlRaOCovfD9wIGKNbjJ4OdgNJ154Mdn97Bb8NmKuQW9A
	R2GzP3S494Jcb5sDMhJhphzekciZEGkSgUX/7xjILrC1Ea6pX0sqp0wiIU73EAPf
	eI0Py1yv8uDcpaKe2Eciw9pWPzNEnwiSus9NZJpyG/JsOyQjlwh6szHVjd7/3FD0
	EEb3wJnLqz9Pgi96oWkVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788292686; x=1788379086; bh=L
	eYtaEEhyDnwQ2HLainJO/J0XK6yonvKpQawt9qdEhY=; b=d7qU1AGm3ymK8bHgB
	5hN/v00JJFhNKuaeKs3BJfzCO8EM/ddQABx6aS7Y5le+7arqLvNeBQd2/3npm3Ls
	r5mH0zNfnrqCqz9jGAayRmqJqJOEV2IkPO14bWQS+pVLFGNMH9zOJYIWfQMczcrA
	n43zVY7TzMSCV2uCpqRSGlRPiZKCP7S/+SSk+g6LlpzriimzYisoP8CaEHCTA0tl
	rDJ3KV7+VU1CrJwyKat/opHLu18X+P6DUhp2DTu3MAHi5zkjdSNj3ZB9m2RjFRlq
	y8hEziaIzzp6PcNFf3HrNcuPkIaFnqyv7G5yPoCN7HDQIirHo63NeUGRCg0K/yRQ
	sF28A==
X-ME-Sender: <xms:Ti6XauSzYs8Zv2Whst2tv0sbS90eGdgwt8vE3XncP8zKVTm5GlDHtQ>
    <xme:Ti6Xandjmyajlrqw5wlAK4f1o5Z6q9IFGrRH6zXtgH2hfxWyAIG5Y2CXVmPlS9K-8
    rfv_h42LvAaP4SKYNf1OrhJFIrWYD_wi06GvJlAIfWU3FvExFzwPq0J>
X-ME-Received: <xmr:Ti6XakeRsbb7J-miU8JOyQy4zTeSylSUwRHOE08netV1ExOUVCta2t5_B8SzjNPJCDZzeDn6Xu0LghNLEdBbTNY>
X-ME-Proxy-Cause: dmFkZTFbOziUSr6IKVqYzGMnQqqLqpz4/GW9SiBKHax7ntUiJyYR2tQiayaS8y0igZY2vR
    nV625AU9QVfc1wz1bFtctU0X3jKJ6nbYAolqzUobflk66zRPZSdPdeg22EaptFLG2NLPlQ
    oDbDHVUYLFn4qZSYUtWoGo8wgLbknoRxYsy/qzGjxCnl0yT4iXZaGbGdgUXK8MzYcioT9w
    wHgLyBooZFiULBZLRB4ObY5sY7I8nZO6YhJLgqZuvPKM2+w5gDcmxvt3BpJmK+Kk0pOJIK
    BnX5WToKcjfsd4um7E/sabkCVGKlbyPd3GlMmlAk2zX4jRYzzNDS7c/s1PcjzAxhX/PYtu
    hh7Sm2HBgp/P9nkYsnf3e/Kdc5MeuycAUOa9qfN3aoWRj4mc5+NDEITwPJD+EwpfDB4qck
    eNjaIS+Kc0jZhHOKc3ehCDIOKz+vHv1YCjJFvao1OCgfx4dyNrGeKcm26I84P3kBZ8fOPk
    r1/uxeJvM96gIv8RKX3NdnM31ESwNqB4BX/fTXq+AgsAQA/3ihycjuVCQz8wjjR/EhHSU1
    UsJR6T1IIrQ8Fbaw+xMHvpQhoeQdXScMMIG/HS7JRaHgp7+gA43LFNZ0MoHNRCsWVGDPob
    XnwRVZeJuzbFCtflZGNu1g80w4TOVU/CNpbCNPI9yZEjjgoHUN/j1/gvsbhw
X-ME-Proxy: <xmx:Ti6XarbsFAIV1NG-s4YIoj0XAEmnIgfsLSF7sbetNPQ6S_5SdTNyTw>
    <xmx:Ti6Xao7Vxto2OX0wubHTgw4Cj0j5JOG1avkKAEXaY8RFMUL7v964ig>
    <xmx:Ti6XapfAjGvdwps0wo-rjyNS_7nMNFlHB_9LL1S8R45oxlEM5EOYig>
    <xmx:Ti6Xarw9pZ_Ljhd3UmKJNVZRp0lCTE5QySlaGK62fN992yHa2W_Idg>
    <xmx:Ti6XarsTfGKCyp0qvMtxMOS7E_jHpzgYPSPBINpjJo0X7-dOJUzo5mQw>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:58:05 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v5 4/4] net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward
Date: Tue,  1 Sep 2026 22:57:14 +0300
Message-ID: <20260901195714.673548-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195714.673548-1-alice.kernel@fastmail.im>
References: <20260901195714.673548-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
dropped the IP6_MAX_MTU clamp that used to be present in ip6_mtu(). A
similar IPv4 commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
ip_dst_mtu_maybe_forward") preserves the IP_MAX_MTU clamp.

Restore the upper bound in the IPv6 flow to avoid potential 16-bit
overflows in forwarding paths.

Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip6_route.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index c69f1c871922..b9e8d2b759e9 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -384,6 +384,8 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	rcu_read_unlock();
 
 out:
+	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
-- 
2.55.0

