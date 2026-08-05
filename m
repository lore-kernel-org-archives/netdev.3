Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F337E5FB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940344; cv=none; b=ZJToNkuj0AiKT11ym2FoEmbIS3lhbVVLiuqhK0vgI92/0uFZhtfWIrsqGkZPu+pG0BblS8TkIDFI/meIh615iFfZZJ1IaPMeVS7lYPSTK0HB4gF7PMurGAjuvlZd0j81wgmcxsohQ38cVLnyu538UD1M1V6Dn4ZgXWr73eaRcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940344; c=relaxed/simple;
	bh=VY+LVRE5SL49VLGU2BdbBzwdoq6ckVBKG1H3IRWKG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDtdIQkoiRxnckKM1u+iH4bFUn7K4B0f4MO+KLEY2JIkqazhnZCEAk+NY0xZhHJfcq+b5FeJM0XihofTDvgxYml43idwwVNBH52pysvLqmafuw7YeiOmZxzuBNQclx5zLHdanHDwRr3Fs/D74nNBApubA/vHNJvaoHCV2g3j2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=z/pcV47e; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="z/pcV47e"
Received: from kero.packetmixer.de (p200300c5970B56d88eEbaC4310d100aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id AA9E5FA26E;
	Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbxbhQOvhhTdAU3fZ2FnZyfAODsoGSs5O9cRmBMxbAo=;
	b=z/pcV47euLcXNVl2E3zmofoqTAbyiy7FZbmUz/vtMuQGfZDNWqSlbonoVcGWH82RlInFlb
	3s9hw0S1iToeXxSR/2vxMj4ve2Glxy/6/HRa38AEXJBBgKRE6D8ZfdRFogJoQMxOZjl67q
	5ywwUqH00/yIvUL9vR827ROJ5DZRY6U4m0XJeLEH96JZFiAZbC9vlQMoxjg2T2hfZ5olJv
	9Xjy3JTxYfA7yB3kF9qGTKPTyQFMiRR9u1eleLu9c9xb1gK5w6b5vaRRxQOZtb5SD5j5nL
	LSmt+i6eq/GtWCTdH0XPgbJOZlHaMlCLiGg/Yad4xK+6Uyoi6uzVRIuoVdIfKA==
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
Subject: [PATCH net-next 10/10] batman-adv: remove negative returns for batadv_send_skb_unicast
Date: Wed,  5 Aug 2026 16:27:24 +0200
Message-ID: <20260805143200.722098-11-sw@simonwunderlich.de>
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

The kernel documentation for batadv_send_skb_unicast() states that only the
return values NET_XMIT_DROP and NET_XMIT_SUCCESS are valid. Functions like
batadv_dat_snoop_incoming_arp_request() are only checking if the return is
not NET_XMIT_DROP to check if send was successful or not. Negative values
were therefore also handled as success.

Similar functions are not returning the batadv_send_skb_to_orig() return
value directly but are checking if it is a direct success and only then
marking the return as such. This must also be adopted for
batadv_send_skb_unicast().

The callers of this function are mostly not affected. Only packet counting
in batadv_dat_snoop_incoming_arp_request() will now work as expected in
case of a negative return value from batadv_send_skb_to_orig().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2122560c90e51..929b6dd34c107 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -324,6 +324,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 	struct ethhdr *ethhdr;
+	int res;
 
 	if (!orig_node)
 		goto out;
@@ -360,7 +361,10 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-	ret = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_XMIT_SUCCESS;
+
 	 /* skb was consumed */
 	skb = NULL;
 
-- 
2.47.3

