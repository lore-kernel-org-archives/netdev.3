Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE437F006
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940349; cv=none; b=INva3qEUAPmYaP30suH5+7wu444hP3Av0Fz7WEj8d4epytX6nxzucK4HEMNQNEbLW7/xPa/TxHnUhP958ow8otilBkvTHWFczFLpPkWYEn5tRccgcz9zyXLdHisAgQLmwDXxTFJdn+7aeqQWROpQDd+ZCVJrVcg/5L7Z5Eq5P60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940349; c=relaxed/simple;
	bh=GPGBo4vByh7GNg0oTLhYHCHOJ5WJd0MD5R5+gwSeNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kA6/VZU6bIK1pmn7DKZ9oYOxiBIO/yToWEukZEqb5leG9Hsi+sHxRFWofX7N5xBZuvF1utHhUoyAZQ/q494yJ67mYg6/4e7KsS3F9+nhn2UyRln4jcDlnjvAIu2bwM9a2tUIOT+s9TY8DNmxdCOqsU8XMJsCtrvHr724hWK61aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=QuAAvnma; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="QuAAvnma"
Received: from kero.packetmixer.de (p200300c5970B56D88eeBAc4310d100Aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 93B0FFA1DB;
	Wed, 05 Aug 2026 16:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEV/0JzIrtODzVkGJNUGo+ar3illtmG1jUtSduTBbKE=;
	b=QuAAvnmawsDJiTGgcJO4ugKFaXeKn7+/A+8laFGsSwM1uxk15Zua8KLGPT9FjittaFp6mO
	pEcGLW+OUuqp8ZiHEPe+0QjHktCJLwsdzfnpzR41AcohWz/0saPj0NWxP/9BwVfWgITwEF
	+wwRt5Me7hFwY7I4AZgzHiAOfBBKxZqpR2zJgcEskdFbxn4wZJgz6XcXhtGKf/ywCn3std
	yxLLzrfZaek+JP3ugsUZLcbzeG9iBzqtfuZWZWJv6jDvUrzJiA3N83KAhQQDn9d9LVxMER
	0zv71T6EGBMr4lyCIZEvc/0BxcQ7lcBY95XPybZvsf3LY3AUJyW5IdkH2Ldr9Q==
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
Subject: [PATCH net-next 05/10] batman-adv: annotate functions which may reallocate the skbuff
Date: Wed,  5 Aug 2026 16:27:19 +0200
Message-ID: <20260805143200.722098-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 net/batman-adv/bridge_loop_avoidance.c | 15 +++++++++-
 net/batman-adv/distributed-arp-table.c | 40 ++++++++++++++++++++++++++
 net/batman-adv/gateway_client.c        | 11 +++++--
 net/batman-adv/main.c                  |  5 ++++
 net/batman-adv/mesh-interface.c        |  5 ++++
 net/batman-adv/multicast.c             | 10 +++++--
 net/batman-adv/multicast_forw.c        | 10 +++++++
 net/batman-adv/routing.c               | 10 +++++++
 8 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f9a1fadf8de9e..247f8bb4d5fc0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1078,6 +1078,11 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
  * @primary_if: the primary hard interface of this batman mesh interface
  * @skb: the frame to be checked
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if it was a claim frame, otherwise return false to
  * tell the callee that it can use the frame on its own.
  */
@@ -1807,6 +1812,11 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/batadv_get_vid()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the orig_node is also a gateway on the mesh interface,
  * otherwise it returns false.
  */
@@ -2061,7 +2071,10 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
  *
  * in these cases, the skb is further handled by this function.
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_bla_process_claim()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  *
  * Return: true if handled, otherwise it returns false and the caller shall
  * further process the skb.
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index d284b090fdf11..e1176aa8683cc 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1031,6 +1031,11 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/... Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: the ARP type if the skb contains a valid ARP packet, 0 otherwise.
  */
 static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
@@ -1107,6 +1112,11 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
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
@@ -1169,6 +1179,11 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid()/.... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the message has been sent to the dht candidates, false
  * otherwise. In case of a positive return value the message has to be enqueued
  * to permit the fallback.
@@ -1271,6 +1286,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the request has been answered, false otherwise.
  */
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
@@ -1333,6 +1353,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
  * batadv_dat_snoop_outgoing_arp_reply() - snoop the ARP reply and fill the DHT
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -1382,6 +1407,11 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet was snooped and consumed by DAT. False if the
  * packet has to be delivered to the interface
  */
@@ -1788,6 +1818,11 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
  * This function first checks whether the given skb is a valid DHCPACK. If
  * so then its source MAC and IP as well as its DHCP Client Hardware Address
  * field and DHCP Your IP Address field are added to the local DAT cache.
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/batadv_dat_get_vid()/... Any pointer into the skb data
+ * (e.g.obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb, int hdr_size)
@@ -1835,6 +1870,11 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the broadcast packet
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the node can drop the packet, false otherwise.
  */
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 48fc711b8fd62..971ae3664fa74 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -553,7 +553,10 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @chaddr: buffer where the client address will be stored. Valid
  *  only if the function returns BATADV_DHCP_TO_CLIENT
  *
- * This function may re-allocate the data buffer of the skb passed as argument.
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  *
  * Return:
  * - BATADV_DHCP_NO if the packet is not a dhcp message or if there was an error
@@ -677,7 +680,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
  * server. Due to topology changes it may be the case that the GW server
  * previously selected is not the best one anymore.
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Must be invoked only when the DHCP packet is going TO a DHCP SERVER.
  *
  * Return: true if the packet destination is unicast and it is not the best gw,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 78b81daaeff9a..0a0ad9978494b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -610,6 +610,11 @@ void batadv_recv_handler_unregister(u8 packet_type)
  * The caller must ensure that at least @header_len + ETH_HLEN bytes are
  * accessible after skb->data.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/... Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: VID with the BATADV_VLAN_HAS_TAG flag when the packet embedded in the
  * skb is vlan tagged. Otherwise BATADV_NO_FLAGS.
  */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index effa37ff3bb1d..cc004343208c3 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -57,6 +57,11 @@
  * @skb: packet buffer which should be modified
  * @len: number of bytes to add
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow_head()/... Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 1c5315e55c046..5c2c19babfd54 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -951,7 +951,10 @@ static void batadv_mcast_mla_update(struct work_struct *work)
  * batadv_mcast_is_report_ipv4() - check for IGMP reports
  * @skb: the ethernet frame destined for the mesh
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * ip_mc_check_igmp()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  *
  * Checks whether the given frame is a valid IGMP report.
  *
@@ -1017,7 +1020,10 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  * batadv_mcast_is_report_ipv6() - check for MLD reports
  * @skb: the ethernet frame destined for the mesh
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * ipv6_mc_check_mld()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  *
  * Checks whether the given frame is a valid MLD report.
  *
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 1404a3b7adfb1..60ec12805742c 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1080,6 +1080,11 @@ unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
  * Tries to expand an skb's headroom so that its head to tail is 1298
  * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow()/skb_linearize()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: -EINVAL if the given skb's length is too large or -ENOMEM on memory
  * allocation failure. Otherwise, on success, zero is returned.
  */
@@ -1120,6 +1125,11 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
  * that signaled interest in it, that is either via the translation table or the
  * according want-all flags, is attached accordingly.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_mcast_forw_expand_head()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: true on success, false otherwise.
  */
 bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index de0848cce98ab..d3b766f391997 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -172,6 +172,11 @@ bool batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
  * @hard_iface: incoming hard interface
  * @header_len: minimal header length of packet type
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow()/skb_linearize()/... Any pointer into the skb data (e.g.
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
+ * pskb_may_pull()/batadv_get_vid()/... Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet may be processed further, false if has to be
  * dropped by the caller
  */
-- 
2.47.3

