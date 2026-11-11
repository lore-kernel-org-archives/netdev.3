Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392862;
	b=C0jzbuQsD79ePteJvorBVmwiZwxIqpfJ7Hqb3wJT9dbPbFqBE2jSLhI7k+4uvcKKyZS8
	 ApLgWR0ztm6jo/iVvBz25+6DAnrlVfQGKTvEXYeYs6sj9W3Jc/dZddjD2OUe0EGgWQy9t
	 h0dSAa5wq1EmTEEX89WX7FrLecfv2+qxa2L4Ppe3Ccokf+8gZdkVs2C0NAsHYPl7HqE9I
	 15x8dTyuA2Z0miwaeJlvtaUe6DgU71FtVqAhUXXw2AQ4WrEoaBuz/NCU4At+ZuxxVWwPn
	 6/vrYHimdwhZY07adr+ekj5yDl/lQbnOapQ5x9wE6akr1ObVKwOrHpx2mpVu+VNPwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392862;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GblHUlYfymPMnJg/hy5fnjUORn5qjLqynksLlfm220c=;
	b=yigy2dUBoBbd6BSlhmM2ag00gJDrFbRMLlxfez65xJySDcgZTyApmhi9/ZT7Whitg7ir
	 KTLKq9MWRcjWg5yU8XigzSZosBbe6UcHFL9qtAIcYCll8HW268BbFTrdHjrg0EcOlc8wa
	 kDOGjmKO0FtS0uvcNBOAeZO13R5UBTj2jHHcP5OcRkLn7oWOgwQR3t84SEy7oMmBQ4g8x
	 I6xN/SBpXQBHgcRrXMiW8YlPyBubGm5DMugc1/seGKJAK2swZ2PohQPIuj5DY7R6MB5FI
	 OlfOTXiq+2d2zTzhSEYOyW0Bj/kNl+tEhnimZ+uBooTQeYfptFz1HGrnupemiexVPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b="1LIt5/o7";
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BD2D7606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD2D7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=1LIt5/o7
Received: from kero.packetmixer.de (p200300C59740dEd843bE7E4A980e9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id E3058FA1CC;
	Wed, 11 Nov 2026 11:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GblHUlYfymPMnJg/hy5fnjUORn5qjLqynksLlfm220c=;
	b=1LIt5/o7GK1sxkjC+uiGbZnwAGTl9bpdzeA03lIYW2d75UMfl31iBY60ri4B0dzYrWChg4
	ZgavBNs7ogPjk6djA+3vUqV5PrkehXu0gYutHChtW3bLyMncwlWYiHzl9OXKY99lGAVhgk
	Bb9ZC58fwh+M1qDy5GUW0qcsN6xw3lo6FkqKOcNM/2q2BmzFTt9aKQqZFZBi99VWtr22Wi
	ULJdoEdja/QfCd1cFQ5ywnzatDOToo9TnuIZCzGAKizHFLCL7IoGgOW1XDL5Asoxo42LoQ
	8/JLyHOIv69z+RtcpVIlDTT59ZQhYNTCXbxxFvLF/HmyK9SvZvyufj/4INR9Bw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
Date: Wed, 11 Nov 2026 11:27:21 +0100
Message-ID: <20261111102729.2096241-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

To avoid an underflow due to an non-strict order read of jiffies vs
lasttime, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269da8d37..0833f9f99e2a9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2363,6 +2363,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	unsigned long lasttime;
 	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
@@ -2385,7 +2386,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
+	lasttime = READ_ONCE(backbone_gw->lasttime);
+	msecs = jiffies_delta_to_msecs(jiffies - lasttime);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
-- 
2.47.3

