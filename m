Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900A395AD3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940813; cv=none; b=AVcImaUtpYIFj4PdLyB9NYXBmEZCt78sETvlhuTRG/CMuF3JPG6yJLf2DEXcMV1bYnLZd70m5QfBxtmOkKMfUB5txBlqIi4jj1PasiKO6n+z99mKOv6r/J8OdgXtYSeZLefR8AIeokatcsvzN5ruhUHHVSg4OYDT5ULpmstq6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940813; c=relaxed/simple;
	bh=R/C9eCJH1xp2yeP55uJmz49PDrUkXzX/HKF3juNz1FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvWEb4cC7CDvY5j/YUWp3IpQI0UbKRUWxr9zqL9+0EdQxd1rQOPnQl1IaboZX+jLijN88xssWYJoLMRPlpHfdPaEvWzKJQ4KSig7G1T2/QJTVbqNmnvuKEypJTw2hWRaGwISjWB6l0yW8Cgnvhve0VHUbMgMc04vvPhUvhHNJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=M/uZJkkQ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="M/uZJkkQ"
Received: from kero.packetmixer.de (p200300c5970B56d88eEbaC4310d100aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 98131FA1C9;
	Wed, 05 Aug 2026 16:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV+yoa8pcMjmnzwq4i3jrAXYGKZ71UdYTICkAASchw8=;
	b=M/uZJkkQVDKWzFhbBjH/w2s83hc2aT+JtiaSbg29hIuLFrVadUCED36jvxIG8AlsG+UQx0
	a4av2B6jCzcFXtBLhprilcl8hs5aSveKDlw8e64TZSh9vEfWMF/mPkEVn35Bj76BxfJv0R
	8gT9rpN0IkcDWPPwZ49fK011aZNypdM5j2In6VQhVtN1XuaZk+TtpCnVUGOm4aOR93Hz/R
	vWm7yEmtW0hVMW77bsyHFlNayE4qoBigmxlcI6Hku2XLuPa+yEskBcf+Z5H8atMLUCJjb0
	N0BAfydy9kv18d8QZXgO/CC+H4C6HytW1xv+0cBLM+yXGr9F6TCqlMsVA2XxRg==
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
Subject: [PATCH net-next 02/10] batman-adv: tvlv: handle negative tvlv processing return codes
Date: Wed,  5 Aug 2026 16:27:16 +0200
Message-ID: <20260805143200.722098-3-sw@simonwunderlich.de>
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

batadv_tvlv_containers_process() was implemented with only two return codes
from the handlers in mind:

* NET_RX_SUCCESS (0)
* NET_RX_DROP (1)

The multicast handlers broke this convention and are also returning
negative return codes. But the processing code was never updated to
correctly aggregate them.

To handle negative return codes for non-OGM(2) handlers, they are now
aggregated to:

* NET_RX_SUCCESS when no handlers returned a different return code
* the last negative return code when at least one handler returned a
  negative return code
* NET_RX_DROP otherwise

With the current callers, the old implementation is not triggering any
unexpected behavior. The behavior is only adjusted for new code which might
need more reliable return values.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c |  4 +++-
 net/batman-adv/tvlv.c    | 22 ++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bbd40fe3a8e59..a9d657f2a831a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1334,7 +1334,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
  * mesh interface.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS if the skb was locally received, NET_RX_DROP otherwise
+ * or a negative errno code when the multicast tracker TVLV could not be
+ * processed
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 49bf2ed9ecdc3..cc14a76582b5a 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -383,8 +383,9 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success if the handler was not found or the return value of the
- * handler callback.
+ * Return: NET_RX_SUCCESS if the handler was not found or the return value of
+ * the handler callback. The latter is NET_RX_SUCCESS or NET_RX_DROP for the
+ * unicast handler and additionally a negative errno code for the mcast handler.
  */
 static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_handler *tvlv_handler,
@@ -524,8 +525,9 @@ static bool batadv_tvlv_containers_contain(void *tvlv_value,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success when processing an OGM or the return value of all called
- * handler callbacks.
+ * Return: NET_RX_SUCCESS when processing an OGM or the combined return value of
+ * all called handler callbacks. The latter is NET_RX_SUCCESS, NET_RX_DROP or,
+ * for BATADV_MCAST packets, a negative errno code.
  */
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   u8 packet_type,
@@ -540,6 +542,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	u16 tvlv_value_cont_len;
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
+	int res;
 
 	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
@@ -548,10 +551,13 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
 
-		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
-						packet_type, orig_node, skb,
-						tvlv_hdr + 1,
-						tvlv_value_cont_len);
+		res = batadv_tvlv_call_handler(bat_priv, tvlv_handler,
+					       packet_type, orig_node, skb,
+					       tvlv_hdr + 1,
+					       tvlv_value_cont_len);
+		if (ret == NET_RX_SUCCESS || res < 0)
+			ret = res;
+
 		batadv_tvlv_handler_put(tvlv_handler);
 	}
 
-- 
2.47.3

