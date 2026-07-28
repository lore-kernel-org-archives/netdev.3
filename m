Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF293AA507
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245972; cv=none; b=ehnuNgviHr+XDlMmQV1i22r4w1H+TDKb+FNbdhVGzuiytLDQGbMvgzWsLeK7G0J0A5qIQ3H+9oLic6Vs6SFYKiELRQNQTnkPvM62GMY4ffSXfDbw3r1IbKZ1ZsWcVw8NnV4Sl8BoPEjveusZIN2Iv7ELDBuvh4z+a6S/U7K/6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245972; c=relaxed/simple;
	bh=Dauifq9dkKQBxu417szPCRf4Pc0EPpMcKvc97mqQjis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hedVCxGshj6uHFeotjWVPLjWOLkx25AZm6KrbIjedv3iNebcOW0xxvXT/MbhD2P6xH775B+5FX+cHdPre7B4Qt9KaEgliEDz4dtcQbkItr/mXIzEBgtunk/7/9tvHAoJUQuAEj1Lzf7XRBW3vam4AK2YOywIsurp5X6pm2KCjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=cUsDvy5f; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="cUsDvy5f"
Received: from kero.packetmixer.de (p200300c59717ead808f168C97E5563A8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 4C61BFA12A;
	Tue, 28 Jul 2026 15:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiDLPwNbw7L9mWuEIB4qYmA/KNvUUU6rZcIkHkVREBg=;
	b=cUsDvy5f51QyQl3Pa5DqVHq/1NrRb0NfvOi1BLgEkOl83ONNn9Q6RsVqhZx0RBssBoPkMp
	SS/Wtcm8x8wtWiyVKJa6vtiPLWl3Pfelp84UIxxt1ObxnupTv2/NbyY4Dq6eQgSCHiDB9x
	j6JmYhWhbNiKrN+b2MkGFmqJ2EdDSmBFGR9TqqAZNwzshuSg9fzXt8m5T8GItrcc2KxEyr
	sIhBxnbJB46LbI7nycTfkpL1a33bJxZdwn/TGacNJm6duP5SD80IDIbahJII0T3VI9br0d
	zsMrP5gN4vJ9he1i8pePqb9m1CTRiy5QPwE4HVmDl/MMSqUoYHE0F5VNXUYn6A==
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
Subject: [PATCH net-next 08/15] batman-adv: dat: drop non-4addr backwards compatibility
Date: Tue, 28 Jul 2026 15:39:11 +0200
Message-ID: <20260728133918.643267-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
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
index 95d8e3a383902..180f654d5e515 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1293,17 +1293,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
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

