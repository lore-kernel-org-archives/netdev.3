Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392862;
	b=fnLjb6498+S+41r1JwUBZc8tX4c6LX45dbU874yOIkTe5PI6gZZXLA6deq0KxxWmZF1r
	 miRViUwALs+13YTTzNE97Q2Q9/RWtEv5IzcO2YlH616j96zlo1gAxOpFcaV6VXVRTmtGJ
	 KP9zifdqlrVjcLUiWhYao9yUJGaWK1q87BfttXVjHVdrcPDwm37KwzMfIVUI7YO/c+PYv
	 67yi7J2rLJwD9CB1Jy8JbIMEhexLxuz/Ujktdytn/TvskFdUGrG1wpN6WQI8/XM735hQG
	 Arg9Izoi/0exKawVLcSOA2X/OaZ7seZCZx7xjOKROBUTLSqPyOoFFOJBOPiA2ox+hlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392862;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9S+d2M18RQfWHvx8jt1sd6SSt8G845pD8JNi8Ep67Bk=;
	b=3Ha2b4/OPCqUvXDeFqPKRDeorDGyU0mYDnV7D0eSMMDmriai2+cE2Cj+LRHJSPcd4vWc
	 IaiMQjaBnXNFWkKHxujTE9PDzGX5yMUjBPm98/b7gfOPupSqkYSJ3mD6vO79y5DgCzrCs
	 TKH5oFUiDGfi1F+9vA8DR972NVgSXPTnFCYeI8xqdAvmo7kbMazgEkQQA2F5n4I5p0LxQ
	 YtqB+XXFRye9y2u9F4wSLCAaQbfcVqnrhI+wVYXC+vc2xPawDHMpnNe2VVbXBe/rjdYvv
	 mrpsY54QB6sOzZo+cZKmAKYWM7lkU7HMQikMMAlnBpsvuX4lqfsn3C5/ZTw99uAjn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=dGDQGE8Z;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 539C4606A884
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539C4606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=dGDQGE8Z
Received: from kero.packetmixer.de (p200300c59740DED843bE7e4a980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2E3EDFA197;
	Wed, 11 Nov 2026 11:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9S+d2M18RQfWHvx8jt1sd6SSt8G845pD8JNi8Ep67Bk=;
	b=dGDQGE8Z7LxRQpbYS32JYxEfMbGKNPEzgPISZa8ZzSlPzxbcwFPO4F1WPf+JIbvU+lGDku
	KUD3GST9DKb3r4VzTaRocFWP9anQuNZwmEU+dfliBvOEVi5Z7jiUyRd5L37nfrGHQXqGEZ
	/lhXmJOT1vKx/moUhA5LmjY9VoT90zQN8XzvfcHxQ57j5ZTWbZ/B00ZL23QUH12RLHd7S4
	794WiUPYl5w6HJ91yQuGR7V/GcHX6Q+0LsBLSRI6P02sT9VdUrgW/rpkBA+G1uvUCFI4xS
	oyyt3w0iPSQPNH4PAWnINfC2fn6GhBxrcQvEOgvJR4qwSwelvOaS+ceCVtQfsQ==
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
Subject: [PATCH net-next 05/15] batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
Date: Wed, 11 Nov 2026 11:27:19 +0100
Message-ID: <20261111102729.2096241-6-sw@simonwunderlich.de>
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

hardif_neigh->bat_v.last_unicast_tx is implicitly initialized to 0. As long
as no unicast packet was sent to a neighbor, the delta computed in
batadv_v_elp_wifi_neigh_probe() is therefore relative to an arbitrary point
in time. When the truncated millisecond delta happens to fall into [0,
BATADV_ELP_PROBE_MAX_TX_DIFF] (for example when jiffies passes 2^32 about 5
minutes after boot), the throughput probe for this neighbor is skipped for
one ELP interval.

Initialize last_unicast_tx on neighbor creation to a defined value to
ensure that new neighbors behave the same way - at least independent of the
time when they were created.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3522d0..4a25e513864ca 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -143,6 +143,7 @@ static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
+	WRITE_ONCE(hardif_neigh->bat_v.last_unicast_tx, jiffies);
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
 }
 
-- 
2.47.3

