Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A7380FFD
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940808; cv=none; b=aUIBhXSE/h+NDtgdJvjdzeEsDyqOQV/MCna6FK6EbHr4z0BCdgRm58q50UqMNVejF06wzWe7m9/ASATjjd6dzbsfM7K+pDDVvXvbFZilSwW7CMZFi0Nt/PFj3jQMOJLaSBDol+EkZHFwyt4un8XmGJHDQEGFExFLfrrCHTLpK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940808; c=relaxed/simple;
	bh=ye9+6qUliE7QBPN5PAxIVVWtOE6zl/kBV0/t9LeruGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+NEAo0hWBAIjTqm9Jsdor7vWvCZ+n5R8S3gzj6B5ftbOKT/DFRx9XfbL1QCLVNdlP8Rcke4kJA5QU7/1VgBtHVQ3UiTOr/3gkmcX5/UwuLNDuLjaqZCnVgMU5D5s/h97kZxcxOUvPOElK7Cd6klLetKb7uReoqhJhWE1Vz7nE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Hzuik7D0; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Hzuik7D0"
Received: from kero.packetmixer.de (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C57E2FA1C6;
	Wed, 05 Aug 2026 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPzmQVht5KvQLJQDX2WIhvwIyHqu8oIsuXYqtJQeYJY=;
	b=Hzuik7D0kFc/xKwTtddnmDsOKDeIlvbtPOfgUUr3zvwhEG6n8IAkbnc0eDxs6RUCvLpkCh
	Ydt2yhXOICnykGASnrnF0AhKHucW/xUW22J2H1FVCAuiCbEyM0OiTjf5FSAzv3XzozDoWf
	Q4B5G8eQ5p2UjBJ4Bt2ONCzRV25/euA41Gk5m9sGBIreI9OjCX1pxzoll3lcWoAAzw/QsQ
	D+mATtfmuZuj5VnSe0jbzi5rQoYTUTY+IhXh8vNV8k+Sz7GkIunS/GQwIqKiTEdIBerz2O
	vF79A7atMzJvFjj1y4UHGQg5K0oVaw4wG2NSJiYdWJgDcPqCSYSvEWDXEopjHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards compatibility
Date: Wed,  5 Aug 2026 16:27:15 +0200
Message-ID: <20260805143200.722098-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The 4addr unicast packet support is mandatory in compat version 15. No
older compat version is supported and the kernel doesn't need to keep code
to talk to nodes which cannot be in the same mesh.

Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a6fe4820f65b9..c5fca53f3074c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1277,17 +1277,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
-	/* To preserve backwards compatibility, the node has choose the outgoing
-	 * format based on the incoming request packet type. The assumption is
-	 * that a node not using the 4addr packet format doesn't support it.
-	 */
-	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
-		err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
-						   BATADV_P_DAT_CACHE_REPLY,
-						   NULL, vid);
-	else
-		err = batadv_send_skb_via_tt(bat_priv, skb_new, NULL, vid);
-
+	err = batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
+					   BATADV_P_DAT_CACHE_REPLY,
+					   NULL, vid);
 	if (err != NET_XMIT_DROP) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
 		ret = true;
-- 
2.47.3

