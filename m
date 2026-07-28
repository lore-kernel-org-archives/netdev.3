Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622373AB269
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245973; cv=none; b=rts8y406o1tEYJAbSxXREo7M/DH3f3jnxbwSacCrmqTpMXy03OtePWhuZPFtWBOHuUzpTm+vzNCraQgf5HfiNawLnPU9SCDDogAmG4uE/v5zicDUcKuTu1y0km3r6yUaIGVe4KuvlFcHg6iht4ozZ3gRq5cvDs/kI68DLkPggX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245973; c=relaxed/simple;
	bh=TY3A16GT1LpGfFSDi8a0ofviBpI+MFRH6/5PFYs0n3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCXY1Zxhp3bSvJjmXxME8ucFtTmJcokr/eEnBM3Vme6r3UTpBqm0V3kMKkYst/0Bu3+waIZeGL/Ut3xMOq8+R5xJnGY1H7oAw3ROebR+jGgP53zJ1HZuXd7dbtkrcGnLYLkDnRvs2sCuTvog0qAbBRVVV0XGYux/B2bIrEV+FBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=L3KB4b6E; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="L3KB4b6E"
Received: from kero.packetmixer.de (p200300c59717eaD808F168C97E5563A8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9E7A9FA148;
	Tue, 28 Jul 2026 15:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPlZbrrBlYoUhwneGyVSDbj1Ba7M6YZ3n/+CunzPp+8=;
	b=L3KB4b6Eb+aujJtH8h+rdhAYzjifuRfgFx6hbQedFXuQc1PE0YeuOflTZy5fRsxEncMeBr
	B8hb0mSbwR96sXcXrg/7PUbllD7kexVd+BBLHNbCx69uNpubtO2WZd16Hf4zWcqDsCBBDs
	rX/RepXB2dWpE5xxPj50/RaPOcn3EJVUm6DbzDbkjypHQxt5Z+BR5ef7/9FThGuko890Z0
	HeXpC+SrJg+rVEgouUz7PY8Lhd18kWmuIyHGqBHdPpUGer4kelzcEp37h2E2tzYO2i5l9h
	KhDNRDIFbdbuED7455v4XgOVgbIvOHvyU+Bv7TraSKjCJJI3qcpMy+exAgqwcg==
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
Subject: [PATCH net-next 11/15] batman-adv: annotate functions which may reallocate the skbuff
Date: Tue, 28 Jul 2026 15:39:14 +0200
Message-ID: <20260728133918.643267-12-sw@simonwunderlich.de>
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

When a function is called which reallocated the skbuff, it is necessary to
reacquire the pointers into the skb data. Otherwise they might cause an
use-after-free.

But is hard to identify such case when it is not clear that helpers are
actually using skb-reallocating functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 +++++++
 net/batman-adv/distributed-arp-table.c | 40 ++++++++++++++++++++++++++
 net/batman-adv/gateway_client.c        |  6 +++-
 net/batman-adv/main.c                  |  5 ++++
 net/batman-adv/mesh-interface.c        |  5 ++++
 net/batman-adv/multicast_forw.c        | 10 +++++++
 net/batman-adv/routing.c               | 10 +++++++
 7 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8ee3ec5eb2c5e..18eafbeeccfdd 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1087,6 +1087,11 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
  * @primary_if: the primary hard interface of this batman mesh interface
  * @skb: the frame to be checked
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if it was a claim frame, otherwise return false to
  * tell the callee that it can use the frame on its own.
  */
@@ -1816,6 +1821,11 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull() and batadv_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the orig_node is also a gateway on the mesh interface,
  * otherwise it returns false.
  */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0251cdf5542bb..e9cc4690068eb 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1039,6 +1039,11 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull(). Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: the ARP type if the skb contains a valid ARP packet, 0 otherwise.
  */
 static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
@@ -1115,6 +1120,11 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
  * The caller must ensure that at least @hdr_size + ETH_HLEN bytes are
  * accessible after skb->data.
  *
+ * Warning: This function calls batadv_get_vid() and may therefore reallocate
+ * the skb data buffer. Any pointer into the skb data (e.g. obtained from
+ * skb->data or eth_hdr()) before this call must be considered invalid
+ * afterwards and has to be reacquired.
+ *
  * Return: If the packet embedded in the skb is vlan tagged this function
  * returns the VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS
  * is returned.
@@ -1177,6 +1187,11 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the message has been sent to the dht candidates, false
  * otherwise. In case of a positive return value the message has to be enqueued
  * to permit the fallback.
@@ -1282,6 +1297,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the request has been answered, false otherwise.
  */
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
@@ -1349,6 +1369,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
  * batadv_dat_snoop_outgoing_arp_reply() - snoop the ARP reply and fill the DHT
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -1398,6 +1423,11 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet was snooped and consumed by DAT. False if the
  * packet has to be delivered to the interface
  */
@@ -1812,6 +1842,11 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
  * This function first checks whether the given skb is a valid DHCPACK. If
  * so then its source MAC and IP as well as its DHCP Client Hardware Address
  * field and DHCP Your IP Address field are added to the local DAT cache.
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/batadv_dat_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb, int hdr_size)
@@ -1859,6 +1894,11 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the broadcast packet
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the node can drop the packet, false otherwise.
  */
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 48fc711b8fd62..f4d53d9ea3b31 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -677,7 +677,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
  * server. Due to topology changes it may be the case that the GW server
  * previously selected is not the best one anymore.
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Must be invoked only when the DHCP packet is going TO a DHCP SERVER.
  *
  * Return: true if the packet destination is unicast and it is not the best gw,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c5f4e9f8728c0..fa82ffb706b3f 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -610,6 +610,11 @@ void batadv_recv_handler_unregister(u8 packet_type)
  * The caller must ensure that at least @header_len + ETH_HLEN bytes are
  * accessible after skb->data.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull(). Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: VID with the BATADV_VLAN_HAS_TAG flag when the packet embedded in the
  * skb is vlan tagged. Otherwise BATADV_NO_FLAGS.
  */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 667ea5704fbdb..982de90906b59 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -57,6 +57,11 @@
  * @skb: packet buffer which should be modified
  * @len: number of bytes to add
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow_head(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index c99579dc1ca98..75a3a4567b08b 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1080,6 +1080,11 @@ unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
  * Tries to expand an skb's headroom so that its head to tail is 1298
  * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow() / skb_linearize(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: -EINVAL if the given skb's length is too large or -ENOMEM on memory
  * allocation failure. Otherwise, on success, zero is returned.
  */
@@ -1123,6 +1128,11 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
  * that signaled interest in it, that is either via the translation table or the
  * according want-all flags, is attached accordingly.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_mcast_forw_expand_head(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: true on success, false otherwise.
  */
 bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c1114ee575478..770037b8ca4e4 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -172,6 +172,11 @@ bool batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
  * @hard_iface: incoming hard interface
  * @header_len: minimal header length of packet type
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow() / skb_linearize(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: true when management preconditions are met, false otherwise
  */
 bool batadv_check_management_packet(struct sk_buff *skb,
@@ -863,6 +868,11 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * @skb: the unicast packet to check
  * @hdr_len: length of the unicast header preceding the payload
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull() and batadv_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet may be processed further, false if it has been
  *  consumed or has to be dropped by the caller
  */
-- 
2.47.3

