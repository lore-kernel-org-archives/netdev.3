Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8ED59B663
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184301; cv=none; b=qlWyrCBXUGNqsajb9hZ2/A9jR+o4HLOmiWTF12+ARuIUJ0h1c42Y1ZY9UyKp4QoM0fJbNYLx8WLmtImfnOQQK/30Kk8aaLOB/8ZYM9J8zmgOHbE19jAovFOGKPi+5mv2GHm4HCD8v0G8FEYMZYuXE56kFW+nimTUREs183iKKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184301; c=relaxed/simple;
	bh=/KbEy2v5DxlkAPfZa5TGLlbM0YyAvMrAB/Qla5yviYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqrR3JMQnOW7LmnPRBAozcm/Q1Xwb2NZq8qDwIe2CpMAXc/aG/4t/SYBAxY2W2G+Tq1FAVs+aSohXMsYuolgo2oob1IWeoC56Kh1/7SCmm8+VS2FfQmx447SK+7DYVyYLs8JY7E9gbynHj+e0Z8YseT9V3rC3L3RK3J3/dlKjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=tF1DaBtX; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="tF1DaBtX"
Received: from kero.packetmixer.de (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id DFF49FA1CC;
	Mon, 31 Aug 2026 15:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtQOkpiHnes8mpnleD54qSgD8djfVr3QVhGA6hv1Jvs=;
	b=tF1DaBtXZTo9EJVkObiOXPft0/xAOzCCknrxsZu6gyD6Ns4OYxMO7isqy1WASdvTTp0Pxi
	bvpHF97HminDoV2ImJr8z9AwESY5UygLtvuZzHY3xWk6fgsCudZnMYSgINRvMoz/yq76He
	3ayNDwTaK85+1OYUEETt3Hhol44re9dx0UaYb4Ek7NzjQoEtwVhFdXgql/WgGeyEKnQF/9
	4B30yzTNsDl/mGPaconH2jhxU3yLS1EygWG/mv/0worFLApnz0qjuhthoE0Qwr0Y7cKZ31
	ub09DmMAh9Np7nHxSp+EK28bG30GOaOznMInQ7eA9k1kuQ23MEf/i9sfPhHXgQ==
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
Subject: [PATCH net-next 07/15] batman-adv: ensure u16 aligned mac address in structs
Date: Mon, 31 Aug 2026 15:51:09 +0200
Message-ID: <20260831135117.574836-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

An u8 array in structures have a natural alignment of only 1 byte. An
u8[ETH_ALEN] array must therefore be assumed to only be 1 byte aligned. But
many etherdevices.h functions are requiring a 2 byte (u16) alignment.

All these addresses were either on the start of a struct or after a struct
member which required at least an alignment of 2 byte. Still, annote all
u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure that this
assumption isn't broken by other modifications inside the structs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 99667f632d4d9..c42a4aa8f41a3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -410,7 +410,7 @@ struct batadv_orig_bat_iv {
  */
 struct batadv_orig_node {
 	/** @orig: originator ethernet address */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @ifinfo_list: list for routers per outgoing interface */
 	struct hlist_head ifinfo_list;
@@ -634,12 +634,12 @@ struct batadv_hardif_neigh_node {
 	struct hlist_node list;
 
 	/** @addr: the MAC address of the neighboring interface */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/**
 	 * @orig: the address of the originator this neighbor node belongs to
 	 */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @if_incoming: pointer to incoming hard-interface */
 	struct batadv_hard_iface *if_incoming;
@@ -677,7 +677,7 @@ struct batadv_neigh_node {
 #endif
 
 	/** @addr: the MAC address of the neighboring interface */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @ifinfo_list: list for routing metrics per outgoing interface */
 	struct hlist_head ifinfo_list;
@@ -777,7 +777,7 @@ struct batadv_neigh_ifinfo {
  */
 struct batadv_bcast_duplist_entry {
 	/** @orig: mac address of orig node originating the broadcast */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @crc: crc32 checksum of broadcast payload */
 	u32 crc;
@@ -1085,7 +1085,7 @@ struct batadv_priv_bla {
 	struct batadv_hashtable *backbone_hash;
 
 	/** @loopdetect_addr: MAC address used for own loopdetection frames */
-	u8 loopdetect_addr[ETH_ALEN];
+	u8 loopdetect_addr[ETH_ALEN] __aligned(2);
 
 	/**
 	 * @loopdetect_lasttime: time when the loopdetection frames were sent
@@ -1352,7 +1352,7 @@ struct batadv_tp_vars_common {
 	struct batadv_priv *bat_priv;
 
 	/** @other_end: mac address of remote */
-	u8 other_end[ETH_ALEN];
+	u8 other_end[ETH_ALEN] __aligned(2);
 
 	/** @session: TP session identifier */
 	u8 session[2];
@@ -1765,7 +1765,7 @@ struct batadv_bla_backbone_gw {
 	 * @orig: originator address of backbone node (mac address of primary
 	 *  iface)
 	 */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
@@ -1810,7 +1810,7 @@ struct batadv_bla_backbone_gw {
  */
 struct batadv_bla_claim {
 	/** @addr: mac address of claimed non-mesh client */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: vlan id this client was detected on */
 	unsigned short vid;
@@ -1840,7 +1840,7 @@ struct batadv_bla_claim {
  */
 struct batadv_tt_common_entry {
 	/** @addr: mac address of non-mesh client */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: VLAN identifier */
 	unsigned short vid;
@@ -1942,7 +1942,7 @@ struct batadv_tt_req_node {
 	/**
 	 * @addr: mac address of the originator this request was sent to
 	 */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @issued_at: timestamp used for purging stale tt requests */
 	unsigned long issued_at;
@@ -1959,7 +1959,7 @@ struct batadv_tt_req_node {
  */
 struct batadv_tt_roam_node {
 	/** @addr: mac address of the client in the roaming phase */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: VLAN identifier */
 	u16 vid;
@@ -2204,7 +2204,7 @@ struct batadv_hw_addr {
 	struct hlist_node list;
 
 	/** @addr: the MAC address of this list entry */
-	unsigned char addr[ETH_ALEN];
+	unsigned char addr[ETH_ALEN] __aligned(2);
 };
 
 /**
-- 
2.47.3

