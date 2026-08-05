Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8B394792
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940813; cv=none; b=O4eDoogZjC4yKG3SW/UvQbZTTr9mJLGTPWHLg/99QvP5AIr4O2CnfRigT6RmQm4OtoywVAKP5ZZ12HZi13AdOY4BcweXcuAUIXREwbmvfLKrUmcIP+dN1pg6WWqVJkiYCI+yuSCat5q/DmCZQx9HtB3vj8Y9kpfx8bCD4ywBYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940813; c=relaxed/simple;
	bh=JPhZ17j6fWfUE+XhKqrj+B/rza9Wn5Ab1ej9/9m4cCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKBaxPSuYokEqd5y++RYdy+FhxWTma0snTC0o/4rYm33KOfkQITtQiVxj3I1EEzBie0cH3M7Xtu0YEZxqaeJ1nmMypT0N0rzcKuS/tfXybYMnwZK8f6++47jMRtQwwsMeZNBeeg1v+f+4PFgLb9GP9h/CFVatDKmNAVjfmYV1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=xzMl3a2x; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="xzMl3a2x"
Received: from kero.packetmixer.de (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0313BFA1DA;
	Wed, 05 Aug 2026 16:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Howpo1a3QB5x6OHOeonqhkoLDqgr8XPk8OtZIK1fu6A=;
	b=xzMl3a2xgR194p32kbuQcYrYeCVtS4bkWe0BdXJ08w+T87hF3GDcRs49m39WBXoEr1Hujl
	3noZXxRAFYvr5jT4GRrxazxs52Thd4B2ZoamywO9FEiNBOyHwyHmkW7buA8JDh0wDpC6sa
	vv3TIRAm6XeVsmbDudb4JzY7/UIZ+QmZq1FS0N94i0CuF6hiHYwhvYQRXmNq6SeTr2oIUM
	rNsVZ+XgnGlRLsBYJWCTmfs9ta+a6Za4dgAoQP8obKDykbE4D2P50gIAwscWKV9rpBxfNL
	PmEELCIZrEcH4uVnkMBPatcz7Ad60EfMyarrTNPmXAqkk2Q2LFMrHYpbDwmz8g==
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
Subject: [PATCH net-next 04/10] batman-adv: fix kernel-doc for functions holding skb ownership
Date: Wed,  5 Aug 2026 16:27:18 +0200
Message-ID: <20260805143200.722098-5-sw@simonwunderlich.de>
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

Most functions in batman-adv will take the ownership of an skb when they
receive it as argument.  Their NET_RX_DROP return value is only indicating
whether there was direct visible problem while processing it. The caller
must not try to also free the skb when such a negative return code was
received.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b62a984e73dc0..de0848cce98ab 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -263,8 +263,7 @@ static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: icmp packet to process
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb)
@@ -986,8 +985,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if)
@@ -1120,8 +1118,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
@@ -1177,7 +1174,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
  * the assembled packet will exceed our MTU; 2) Buffer fragment, if we still
  * lack further fragments; 3) Merge fragments, if we have all needed parts.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
-- 
2.47.3

