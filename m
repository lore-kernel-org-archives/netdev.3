Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392861;
	b=sLocYl5Be8fL5PLLMvQ41SDOyY+T1YkT5URXw620KXhwNtpEclzE09h9wPM4EJKeDfMb
	 CWS2lLHggN+dGG1TEFn+XxQ5+ofM5grN0WpqNPATumGp2Lxku/CakZ3Ra4z6jtXFGpV4t
	 7QtotWebJDDSKNnNbx4SjsW6WV0QQFD5ATN2VWTjO5VIeuCBI9GDQdRprxg8vkEhcrSOe
	 JA2DSoDpw73Q+Nhkib3kCqm1xDr9pJctVvT2JrPLhstQozprZpHq9bzGUXfMq8Z9uivp5
	 Yy++nt9vWA1KI3p+pgZPQEbOjSdJXCrTSfPVG5mFMagBADliTeer7/RHxiS+PwhRpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392861;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=StVT0aDN7ua5h8DSyA7kZ57nE3Qg1nYxCGZxl7QEwmg=;
	b=E+DL0TZ+VtrFQFZ145iZ2YU15pACMdWH7xik5yPU8bgEjT63NMzczNcuPUbRazOkh9Qv
	 AZ6qFExK7BNQpNEQJWFE+TEs7BYtxRFC4pwx6cAzBgjBduvH4DTbk7gIaMoCZ/ZJml8RM
	 o4A1MDXP7JnbzutNzBpXy00DPhnq3HAbruCuXwRwX18khs0disW+a5OC/beHPOmfHgWB8
	 FKOixfO93rSFM8IqBK79bPFWLlSz9Lmp15y8jyh1nnaumEdrzDIdCxqKhy3fToP7Bkt8Z
	 9aDbOl4+SYGrCf9slO13a7MKDXlohBt7eNKrstTJOhd/WGAOFre1ANLwLABHCuaFaAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XNgE9bYU;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2DECB606A33E
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DECB606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XNgE9bYU
Received: from kero.packetmixer.de (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7BDF1FA113;
	Wed, 11 Nov 2026 11:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StVT0aDN7ua5h8DSyA7kZ57nE3Qg1nYxCGZxl7QEwmg=;
	b=XNgE9bYU12UxbP/pTXnRxGQi0kQK7+Q3pl7a/e03AtxSAtt0wzsQxX6neMxTVQIx1n1/fq
	67q4qTQB+uRw5cQ9JP92rNDhEHyjs7lyDZ7uq4HbBDOrHsglU5dVrVHRjMehVpmwEg/37/
	f3PM3Jx7ascn4xqKCloiyjb4TjseXSIuUs/Lgh0QdvU7/MBz6me8JmOW4y3jr9XxdWQ4pW
	aWKbPbu5iaFrCjY4qACJFBO2G7LbwtPva0dvQhIcfQczOk6G//uHd/t+xi8v6XocBn+09z
	Xs4K6wzw4LecK3Y71J9+bKmdJ3gmiZA7LGyUg5r6MJFX/ig1MavJFLrT0OQq1g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: uapi: add note/clarification on access of reserved bytes/bits
Date: Wed, 11 Nov 2026 11:27:17 +0100
Message-ID: <20261111102729.2096241-4-sw@simonwunderlich.de>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

Similar to the note in include/uapi/linux/ethtool.h, add a note regarding
reserved fields to include/uapi/linux/batadv_packet.h.

Userspace must not access these fields directly, as they may be renamed or
repurposed in the future. When creating packets, userspace should zero the
whole struct (e.g. via memset or a struct initializer). When parsing
packets, reserved fields must be ignored.

While at it, unify the kernel-doc text of all @reserved members.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 32436560ecc8b..67e2bad7407b6 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -12,6 +12,14 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+/* Note on reserved space.
+ * Reserved fields must not be accessed directly by user space because
+ * they may be replaced by a different field in the future. They must
+ * be initialized to zero before making the request, e.g. via memset
+ * of the entire structure or implicitly by not being set in a structure
+ * initializer.
+ */
+
 /**
  * batadv_tp_is_error() - Check throughput meter return code for error
  * @n: throughput meter return code
@@ -216,7 +224,7 @@ struct batadv_bla_claim_dst {
  * @seqno: sequence identification
  * @orig: address of the source node
  * @prev_sender: address of the previous sender
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tq: transmission quality
  * @tvlv_len: length of tvlv data following the ogm header
  */
@@ -312,7 +320,7 @@ struct batadv_icmp_header {
  * @dst: address of the destination node
  * @orig: address of the source node
  * @uid: local ICMP socket identifier
- * @reserved: not used - useful for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
@@ -433,7 +441,7 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
@@ -454,7 +462,7 @@ struct batadv_unicast_4addr_packet {
  * @orig: originator of the fragment used when merging the packet
  * @no: fragment number within this sequence
  * @priority: priority of frame, from ToS IP precedence or 802.1p
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @total_size: size of the merged packet
  */
@@ -484,7 +492,7 @@ struct batadv_frag_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @seqno: sequence identification
  * @orig: originator of the broadcast packet
  */
@@ -505,7 +513,7 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved byte for alignment
+ * @reserved: reserved for alignment; also see note on reserved space
  * @tvlv_len: length of the appended tvlv buffer (in bytes)
  */
 struct batadv_mcast_packet {
@@ -559,7 +567,7 @@ struct batadv_coded_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @reserved: reserved field (for packet alignment)
+ * @reserved: reserved for alignment; also see note on reserved space
  * @dst: address of the destination
  * @src: address of the source
  * @tvlv_len: length of tvlv data following the unicast tvlv header
@@ -604,7 +612,7 @@ struct batadv_tvlv_gateway_data {
  *  the tt tvlv container
  * @crc: crc32 checksum of the entries belonging to this vlan
  * @vid: vlan identifier
- * @reserved: unused, useful for alignment purposes
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_tvlv_tt_vlan_data {
 	__be32 crc;
@@ -631,7 +639,7 @@ struct batadv_tvlv_tt_data {
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
  *  batadv_tt_client_flags)
- * @reserved: reserved field - useful for alignment purposes only
+ * @reserved: reserved for alignment; also see note on reserved space
  * @addr: mac address of non-mesh client that triggered this tt change
  * @vid: VLAN identifier
  */
@@ -655,7 +663,7 @@ struct batadv_tvlv_roam_adv {
 /**
  * struct batadv_tvlv_mcast_data - payload of a multicast tvlv
  * @flags: multicast flags announced by the orig node
- * @reserved: reserved field
+ * @reserved: reserved for alignment; also see note on reserved space
  */
 struct batadv_tvlv_mcast_data {
 	__u8 flags;
-- 
2.47.3

