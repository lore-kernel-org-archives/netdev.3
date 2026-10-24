Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833982;
	b=mpzWGU203nyN5UdltZ7QP+272zJs9a7g/uha+ZmaSpwD3D1jAQ67bFkkpj8UUBr32hv/
	 bs15vFxcTsp/azrSHFjmfObhN+DJcCh1e/BqD0thSKdnpTyhumZX6vn6KdEJCOxTMYz6F
	 dxjPiYmwST6T8PY599CJCsoflxm/rBZGj9Mm6zU56dBVYE2qnQqB30faq5yjAbjtqQkkX
	 OCAyyEqkU5ZGOLtBuLV4G7VemHcv8zb2ROfaZT1P96Razuvf2g0SLgz8rs2MCxWO5rQmB
	 +tzTanyPjpf/UrOt8YgS3XlyuXQ5vjB4TKyDMQ5To7aS9bWu359MZTOIjOpql2D7v3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833982;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=3xlPK5rfjvIpCumPx4sya77S1DpdTCfoE90ByGw/BeM=;
	b=DqsCbBV+Ga0fxyPlXBlUrbq9albVadDcj89ZlVbAqJwKoQjWo6EQH7ghB7npor8QTMjT
	 0vj0w/r9XvmgAt09XBk9PVmEBFVODUtZ4AkIf73GldTtlLvvafV8G34FzYFFrSbscGb4B
	 mFsuOV3MACCYehF9QMgGXxGp41Kt8J/p0hHpSLQ/F8wXPs8Fsstjl9jPQCljhgcxXPWTW
	 Qu17SF3hbJAKAVyZq6aIyk4Hahk8EA765zQR69ecq5BRK60QWN4+91+LxiqSlRPzM0812
	 pyHguE0XDtQQn9o0uEettuu8bCYMbmNhQUUQ4DN1cWe9QhQNxOP66u36CSyKq0sbPdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LEJMB8J9;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCB60A2613;
	Sat, 24 Oct 2026 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DCB60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LEJMB8J9
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jBZJJ6qqgzKnWZ;
	Sat, 24 Oct 2026 11:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xlPK5rfjvIpCumPx4sya77S1DpdTCfoE90ByGw/BeM=;
	b=LEJMB8J9HV32iN68/RPE/r0DPWN1FeulsVFYkWH9fRfFxwzI9Muf+nuKJCTqkpxTEYjjxz
	SDB4+TK1UYGgIeIgyWx916VcMKOevPYyr8Z0bvmN7CehM7fV7aG38W2aHaTmJWcU3D52BE
	onCur8QrH7nlMEOdibjlAfs4jND6VV+67TMGkgZLg4gATBjgn771yYWuDzXqXEoNuTRDOP
	dZuzT4Mm6NakMYlTFXGL+Kwtla+fVidyCESJqPT8SAJ549D9tK90gB6eTsEzWVikrrXk6p
	12IY0V3JWBkMQZCyCMbn3IKhy03FEhnSQ3ITasRao4Cag6aYRIFO2bNuS5LUfg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 07/18] net: ipxlat: add packet metadata and header helpers
Date: Sat, 24 Oct 2026 11:25:17 +0200
Message-ID: <20261024092532.172005-8-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024092532.172005-1-ralf@mandelbit.com>
References: <20261024092532.172005-1-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJJ6qqgzKnWZ

Define the skb control block used while a packet is prepared, together
with offset, length, fragment and pending-error helpers shared by
the two protocol families.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-4-ralf@mandelbit.com/
- Reshape the v1 control block for the prepare-translate engine contract,
  remove netdevice actions and continuation policy from its metadata,
  and split family-specific parsing into packet4.c and packet6.c.
- Make headers which expose IPv6 packet and Fragment Header types
  include the declarations they use. (Sashiko)

 net/ipxlat/packet.h | 243 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 net/ipxlat/packet.h

diff --git a/net/ipxlat/packet.h b/net/ipxlat/packet.h
new file mode 100644
index 000000000000..463f1ef027d0
--- /dev/null
+++ b/net/ipxlat/packet.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) engine
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_PACKET_H_
+#define _NET_IPXLAT_PACKET_H_
+
+#include <net/ip.h>
+#include <net/ipv6.h>
+
+#include <net/ipxlat.h>
+
+/**
+ * struct ipxlat_cb - per-skb parser and control metadata stored in skb->cb
+ * @l4_off: outer L4 header offset
+ * @payload_off: outer payload offset
+ * @fragh_off: outer IPv6 Fragment Header offset, or 0 if absent
+ * @inner_l3_offset: quoted inner L3 offset for ICMP errors
+ * @inner_l4_offset: quoted inner L4 offset for ICMP errors
+ * @inner_fragh_off: quoted inner IPv6 Fragment Header offset, or 0
+ * @l4_proto: outer L4 protocol (or nexthdr for IPv6)
+ * @inner_l4_proto: quoted inner L4 protocol
+ * @l3_hdr_len: outer L3 header length including extension headers
+ * @is_icmp_err: packet is ICMP error and carries quoted inner packet
+ * @emit_icmp_err: datapath must emit translator-generated ICMP on drop
+ * @saddr4: translated outer IPv4 source address for 6->4
+ * @daddr4: translated outer IPv4 destination address for 6->4
+ * @inner_saddr4: translated quoted IPv4 source address for ICMP 6->4
+ * @inner_daddr4: translated quoted IPv4 destination address for ICMP 6->4
+ * @pending_icmp_err: ICMP type/code/info cached for deferred emission
+ * @pending_icmp_err.type: ICMP type to emit
+ * @pending_icmp_err.code: ICMP code to emit
+ * @pending_icmp_err.info: ICMP auxiliary info (e.g. pointer/MTU)
+ */
+struct ipxlat_cb {
+	u16 l4_off;
+	u16 payload_off;
+	u16 fragh_off;
+	u16 inner_l3_offset;
+	u16 inner_l4_offset;
+	u16 inner_fragh_off;
+	u16 l3_hdr_len;
+	u8 l4_proto;
+	u8 inner_l4_proto;
+	bool is_icmp_err;
+	bool emit_icmp_err;
+	__be32 saddr4;
+	__be32 daddr4;
+	__be32 inner_saddr4;
+	__be32 inner_daddr4;
+	struct {
+		u8 type;
+		u8 code;
+		u32 info;
+	} pending_icmp_err;
+};
+
+static inline struct ipxlat_cb *ipxlat_skb_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ipxlat_cb) > sizeof(skb->cb));
+	return (struct ipxlat_cb *)(skb->cb);
+}
+
+static inline unsigned int ipxlat_skb_l4_len(const struct sk_buff *skb)
+{
+	return skb->len - skb_transport_offset(skb);
+}
+
+/* return the L4 length of one eventual segment rather than the GSO aggregate */
+static inline unsigned int ipxlat_skb_l4_seg_len(const struct sk_buff *skb,
+						 const struct ipxlat_cb *cb)
+{
+	const struct skb_shared_info *shinfo;
+
+	if (skb_is_gso(skb)) {
+		shinfo = skb_shinfo(skb);
+		/* legacy UFO's gso_size already includes the UDP header */
+		if (shinfo->gso_type & SKB_GSO_UDP)
+			return shinfo->gso_size;
+
+		/* TCP and UDP-L4 GSO sizes describe payload bytes only */
+		return cb->payload_off - cb->l4_off + shinfo->gso_size;
+	}
+	return skb->len - cb->l4_off;
+}
+
+static inline u8 ipxlat_get_ipv6_tclass(const struct ipv6hdr *hdr)
+{
+	return (hdr->priority << 4) | (hdr->flow_lbl[0] >> 4);
+}
+
+static inline u16 ipxlat_get_frag6_offset(const struct frag_hdr *hdr)
+{
+	return be16_to_cpu(hdr->frag_off) & IP6_OFFSET;
+}
+
+static inline u16 ipxlat_get_frag4_offset(const struct iphdr *hdr)
+{
+	return (be16_to_cpu(hdr->frag_off) & IP_OFFSET) << 3;
+}
+
+static inline bool ipxlat_is_first_frag6(const struct frag_hdr *hdr)
+{
+	return !hdr || ipxlat_get_frag6_offset(hdr) == 0;
+}
+
+static inline bool ipxlat_is_first_frag4(const struct iphdr *hdr)
+{
+	return !(hdr->frag_off & htons(IP_OFFSET));
+}
+
+/**
+ * ipxlat_replace_l3 - replace an outer or quoted L3 header in place
+ * @skb: packet containing the L3 header
+ * @old_l3_end: current offset immediately after the L3 header
+ * @new_l3_end: desired offset immediately after the L3 header
+ * @transport_off: transport header offset after replacement
+ *
+ * The caller must provide valid offsets and enough headroom. Bytes following
+ * @old_l3_end remain unchanged, and the network header is reset to @skb->data.
+ */
+static inline void ipxlat_replace_l3(struct sk_buff *skb,
+				     unsigned int old_l3_end,
+				     unsigned int new_l3_end,
+				     unsigned int transport_off)
+{
+	skb_pull(skb, old_l3_end);
+	skb_push(skb, new_l3_end);
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, transport_off);
+}
+
+/**
+ * ipxlat_cb_rebase_offsets - shift cached cb offsets after skb relayout
+ * @cb: parsed packet metadata
+ * @delta: signed byte delta applied to cached offsets
+ *
+ * All cached absolute offsets include the old outer L3 length. Apply the same
+ * delta to keep them pointing at the same logical fields after replacement.
+ */
+static inline void ipxlat_cb_rebase_offsets(struct ipxlat_cb *cb, int delta)
+{
+	cb->l4_off += delta;
+	cb->payload_off += delta;
+
+	if (unlikely(cb->is_icmp_err)) {
+		cb->inner_l3_offset += delta;
+		cb->inner_l4_offset += delta;
+
+		if (cb->inner_fragh_off)
+			cb->inner_fragh_off += delta;
+	}
+}
+
+#ifdef CONFIG_DEBUG_NET
+/**
+ * ipxlat_cb_offsets_valid - validate monotonicity and bounds of cb offsets
+ * @cb: parsed packet metadata
+ *
+ * Checks that L4 precedes payload, quoted L3 follows the outer payload and a
+ * quoted Fragment Header lies inside the quoted L3 area before quoted L4.
+ *
+ * Return: true if cached offsets are internally consistent.
+ */
+static inline bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb)
+{
+	if (unlikely(cb->payload_off < cb->l4_off))
+		return false;
+
+	if (cb->is_icmp_err) {
+		if (unlikely(cb->inner_l3_offset < cb->payload_off))
+			return false;
+		if (unlikely(cb->inner_l4_offset < cb->inner_l3_offset))
+			return false;
+		if (unlikely(cb->inner_fragh_off &&
+			     cb->inner_fragh_off < cb->inner_l3_offset))
+			return false;
+		if (unlikely(cb->inner_fragh_off &&
+			     cb->inner_fragh_off >= cb->inner_l4_offset))
+			return false;
+	}
+
+	return true;
+}
+#else
+static inline bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb)
+{
+	return true;
+}
+#endif
+
+/**
+ * ipxlat_mark_icmp_drop - record an ICMP error for a dropped packet
+ * @skb: packet carrying the translator metadata
+ * @type: ICMP or ICMPv6 type
+ * @code: ICMP or ICMPv6 code
+ * @info: ICMP or ICMPv6 auxiliary information
+ */
+static inline void ipxlat_mark_icmp_drop(struct sk_buff *skb, u8 type, u8 code,
+					 u32 info)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+
+	cb->emit_icmp_err = true;
+	cb->pending_icmp_err.type = type;
+	cb->pending_icmp_err.code = code;
+	cb->pending_icmp_err.info = info;
+}
+
+/**
+ * ipxlat_v4_validate_skb - validate and summarize IPv4 packet into skb->cb
+ * @skb: packet to validate
+ *
+ * Ensures required headers are present and consistent, populates
+ * &struct ipxlat_cb for subsequent 4->6 translation, and may mark a
+ * translator-generated ICMP action on failure paths.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
+int ipxlat_v4_validate_skb(struct sk_buff *skb);
+
+/**
+ * ipxlat_v6_validate_skb - validate and summarize IPv6 packet into skb->cb
+ * @skb: packet to validate
+ *
+ * Ensures required headers are present and consistent, populates
+ * &struct ipxlat_cb for subsequent 6->4 translation, and may mark a
+ * translator-generated ICMP action on failure paths.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
+int ipxlat_v6_validate_skb(struct sk_buff *skb);
+
+#endif /* _NET_IPXLAT_PACKET_H_ */
-- 
2.55.0

