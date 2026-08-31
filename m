Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5B59B664
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184303; cv=none; b=WcaNOhJICb8Ahid6d/PR0XRfD/rYAjoqU16TACw6rZfJUC/LTzB4uL+yr7qeDXij3o2W6q6JrcpToyhtL4W4hHjRFdUF3F+JQlZlP97f6vouxoFjSky0YUKS6mG6b3wDT+B2b0VE9Am4vUNL6g+BeVVTafpeGdwksDvy5Of2weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184303; c=relaxed/simple;
	bh=A8/vWGmRRp2bbZIlo8M/BvMfjugf2eADHdmQQplRCDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpBeCHLgg2UrcD1qhktKH3cmccFn4q93c0So1dUvSoz2wuelMlfcvIrz38QWEm0vPcDk3WPRUT2+pVgkOjHsJb2pwOVk8GJmij5b4qS/ebrmUplTJb86FXNaxThGRqUFY//8Q5+zc59zfaMDtLv965meUSBkwLl2xo3PE2muhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wlvAyQq4; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="wlvAyQq4"
Received: from kero.packetmixer.de (p200300c5970EeDd85f51F1FAA919D7A5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 47198FA1BF;
	Mon, 31 Aug 2026 15:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXoJTFAkEdSND2l97LaevL2z/g3mDE3KdUP84/d7fqQ=;
	b=wlvAyQq4/bmnEK29FkC9fH5sjVK9pRpx1oG1wsYYeZN3GW+kIqAUjSK5ynMyzEzrUlHivP
	HoCbx33jrDgyf+OQz835om/fjbpJ6KN8Dyo3Qlt+839JInFaTwnMIXImt2l/P2tdilWwO8
	CokFaYYkwaw+v5bBgnBPPIp5oqblSyp1zUDLbIN41kt2FHt7T0WEANisjEUJjIJ/ArGygH
	matRCkeC1gxQFxp0eX5Y9N8L9NViLPrxc6+KPaJ0R7J/Rz1sb6DkI2ZcG31fAG/P5o0Ckh
	12J3rMatz18Tffp14d/u9XpTmijWeYQ2LhvxYy7Hy4mqbCLNzkc/vZIpF4IMrA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 06/15] batman-adv: ensure u16 aligned mac address arrays on stack
Date: Mon, 31 Aug 2026 15:51:08 +0200
Message-ID: <20260831135117.574836-7-sw@simonwunderlich.de>
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

An u8 array on the stack has a natural alignment of only 1 byte. An
u8[ETH_ALEN] array on the stack must therefore be assumed to only be 1 byte
aligned. But many etherdevices.h functions are requiring a 2 byte (u16)
alignment.

Annote all u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure
that the compiler takes care of aligning it correctly.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260821094813.201800-1-sw%40simonwunderlich.de?part=5
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/mesh-interface.c        | 12 ++++++++----
 net/batman-adv/multicast.c             |  6 +++---
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f635da4b8ca65..ad6ab4a50658f 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -663,7 +663,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 				     struct batadv_bla_backbone_gw *backbone_gw)
 {
-	u8 mac[ETH_ALEN];
+	u8 mac[ETH_ALEN] __aligned(2);
 	__be16 crc;
 
 	memcpy(mac, batadv_announce_mac, 4);
@@ -1582,7 +1582,9 @@ static struct lock_class_key batadv_backbone_hash_lock_class_key;
  */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
-	u8 claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
+	static const u8 claim_dest[ETH_ALEN] __aligned(2) = {
+		0xff, 0x43, 0x05, 0x00, 0x00, 0x00
+	};
 	struct batadv_hard_iface *primary_if;
 	unsigned long entrytime;
 	u16 crc;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 270f8d6e29545..a4be5b2a87d7a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -940,7 +940,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
-	u8 mac[ETH_ALEN];
+	u8 mac[ETH_ALEN] __aligned(2);
 	u64 u64_mac;
 	int msecs;
 	void *hdr;
@@ -1236,10 +1236,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 {
 	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
-	u8 mac[ETH_ALEN];
 	int hdr_size = 0;
 	__be32 ip_dst;
 	__be32 ip_src;
@@ -1344,10 +1344,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
-	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
 	u64 u64_mac;
@@ -1474,9 +1474,9 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	bool dropped = false;
 	unsigned short vid;
-	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
 	u64 u64_mac;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e202088cf1fd4..63af21954cf90 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -141,9 +141,9 @@ static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	u8 old_addr[ETH_ALEN] __aligned(2);
 	struct batadv_meshif_vlan *vlan;
 	struct sockaddr *addr = p;
-	u8 old_addr[ETH_ALEN];
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -213,13 +213,18 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *mesh_iface)
 {
-	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00, 0x00, 0x00};
-	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	enum batadv_dhcp_recipient dhcp_rcp = BATADV_DHCP_NO;
 	enum batadv_forw_mode forw_mode = BATADV_FORW_BCAST;
+	static const u8 ectp_addr[ETH_ALEN] __aligned(2) = {
+		0xCF, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+	static const u8 stp_addr[ETH_ALEN] __aligned(2) = {
+		0x01, 0x80, 0xC2, 0x00, 0x00, 0x00
+	};
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
+	u8 chaddr[ETH_ALEN] __aligned(2);
 	int network_offset = ETH_HLEN;
 	unsigned int header_len = 0;
 	unsigned long brd_delay = 0;
@@ -229,7 +234,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	struct ethhdr *ethhdr;
 	bool do_bcast = false;
 	u8 *dst_hint = NULL;
-	u8 chaddr[ETH_ALEN];
 	unsigned short vid;
 	bool client_added;
 	__be16 proto;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 82fd527b61c02..22dd28d5e1abc 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -368,9 +368,9 @@ batadv_mcast_mla_meshif_get_ipv4(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	struct batadv_hw_addr *new;
 	struct in_device *in_dev;
-	u8 mcast_addr[ETH_ALEN];
 	struct ip_mc_list *pmc;
 	int ret = 0;
 
@@ -435,9 +435,9 @@ batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	struct batadv_hw_addr *new;
 	struct inet6_dev *in6_dev;
-	u8 mcast_addr[ETH_ALEN];
 	struct ifmcaddr6 *pmc6;
 	int ret = 0;
 
@@ -587,10 +587,10 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				       struct batadv_mcast_mla_flags *flags)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	u8 tvlv_flags = flags->tvlv_flags;
 	struct br_ip_list *br_ip_entry;
 	struct batadv_hw_addr *new;
-	u8 mcast_addr[ETH_ALEN];
 	struct br_ip_list *tmp;
 	int ret;
 
-- 
2.47.3

