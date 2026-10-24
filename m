Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833988;
	b=PvIGlHsX+Mp518QC6/4LOx1H0xWhxAl73ePkkMuSq53SW+uAygFfIP8I/siYDoAQa2ll
	 7RFnuop8SqcZLdxMnupA86jQIe31w+aCR7M56L3yMPjL78sKFDfCe54wqiR3qXQL+/YXp
	 j9KvVrXFi5Us4FJWCctmOJrG/+ke9kouoYpNeEWrMhJVVvxs2nALDRLTyg5ODrPBTLREw
	 VPLnF0Q5wC8OFzLWn2A+6X157X3SQLpRH25ivDPfWXISZCvl7RXFSKABLdVE6SJQjxvIi
	 99teeuKGOoHd7ebI9cFPtz6YotQDdEdmbsLTDSJfdBdZmGdURwPtLvv2rwunsu41i6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833988;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=27DoGpF3BvoUxZ2276w/wnlfSAKqgELwl0gMsKGPmNA=;
	b=pidl/mMMtMAu5iWqx0B4cHzZ4mI0VJymp198MPrYJIp6hdeNlBOxu7jH4KpcD4y7/52t
	 9teOmy7c25PvUUSkAbRd1GhTM/GIw+iko2U2EvLzKDXgVkK6ujdnzZ28Qxfac9/k1uNg2
	 pUZP70yIk25whvwtqkrr4WIuQDGyuP1WvpB3bak1qDHWeYNnDyeaNGGVOhube306MuIFo
	 z1NeBV+blDEWd440DMoOvgDRxcVi/HVJ6826gohVdvgT1lx1QVnYaW8AkxfZhswLQP/k2
	 pL5Kz+8ezAJx6Ih2dcCAwApUOMVuLiDzynmtOvSYqoW/aCxgqoNiItxtRcIdTjka4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=VypiYXLa;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14918606A32A;
	Sat, 24 Oct 2026 09:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14918606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=VypiYXLa
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jBZJM72WXzNm0b;
	Sat, 24 Oct 2026 11:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27DoGpF3BvoUxZ2276w/wnlfSAKqgELwl0gMsKGPmNA=;
	b=VypiYXLaLCOGgKF+50g8fAhlhJlZCcPwvJq6Kh1HLZRfnRCmEW9nOZCcVqZxhrd8Bjb6Cq
	OLCR8DuPRyOqXHT8b/lDbJAQB4otDQgEiEa0FUufMDVt7LlK5hNgAWiOQ++ypWyy39AW7a
	/wtBLWsCPIM/mnnncQieUqDQq9knnPB2yAptiGcC02KUyvmZpgchoFu+Qfl2Wyz8Ywd7tv
	3QKmFIIpUIckofVyGpLvpB4LX1SrITmQ1bGMylZGOeE9CwzOu/zAaKfSYIpHZAqh6OJBWJ
	JrAF4K7z9EGK6syVEfs/oaf3ka/i/U3e2pOUItTqT3Kun1KglG0rERBDLDnOFA==
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
Subject: [RFC net-next v2 11/18] net: ipxlat: add IPv4/IPv6 header and transport translation
Date: Sat, 24 Oct 2026 11:25:21 +0200
Message-ID: <20261024092532.172005-12-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJM72WXzNm0b

Rewrite IPv4 and IPv6 headers in place, map Fragment Headers and update
TCP and UDP checksums for ordinary, partial-checksum and GSO packets.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-8-ralf@mandelbit.com/
- Drive the L3 and TCP/UDP rewrite paths only from prepared metadata and
  configuration, without routing or device policy.
- Base 6-to-4 GSO DF selection on each eventual IPv4 segment and leave
  DF clear for legacy UFO.
- Make the 6-to-4 skb writable before moving or changing headers.
  (Sashiko)
- Reacquire header pointers after operations which can move packet
  storage.
- Use the kernel's zero length-field convention for oversized GSO
  packets instead of truncating translated lengths, and reject
  unrepresentable non-GSO packets. (Sashiko)
- Preserve CSUM_MANGLED_0 when an outer 4-to-6 UDP checksum update
  produces zero. (Sashiko)

 net/ipxlat/Makefile       |   2 +
 net/ipxlat/translate_46.c | 213 ++++++++++++++++++++++++++++++++++++
 net/ipxlat/translate_46.h |  77 +++++++++++++
 net/ipxlat/translate_64.c | 222 ++++++++++++++++++++++++++++++++++++++
 net/ipxlat/translate_64.h |  96 +++++++++++++++++
 5 files changed, 610 insertions(+)
 create mode 100644 net/ipxlat/translate_46.c
 create mode 100644 net/ipxlat/translate_46.h
 create mode 100644 net/ipxlat/translate_64.c
 create mode 100644 net/ipxlat/translate_64.h

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index 91baab41d5eb..b0fab158c7b3 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -10,3 +10,5 @@ ipxlat-objs += address.o
 ipxlat-objs += packet4.o
 ipxlat-objs += packet6.o
 ipxlat-objs += transport.o
+ipxlat-objs += translate_46.o
+ipxlat-objs += translate_64.o
diff --git a/net/ipxlat/translate_46.c b/net/ipxlat/translate_46.c
new file mode 100644
index 000000000000..add29d9ef0a7
--- /dev/null
+++ b/net/ipxlat/translate_46.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <net/ip6_checksum.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+
+#include <net/ipxlat.h>
+
+#include "address.h"
+#include "packet.h"
+#include "transport.h"
+#include "translate_46.h"
+
+u8 ipxlat_46_map_proto_to_nexthdr(u8 protocol)
+{
+	return (protocol == IPPROTO_ICMP) ? NEXTHDR_ICMP : protocol;
+}
+
+static __be16 ipxlat_46_build_frag_off(u16 frag_offset, bool mf)
+{
+	return cpu_to_be16((frag_offset & IP6_OFFSET) | (mf ? IP6_MF : 0));
+}
+
+void ipxlat_46_build_frag_hdr(struct frag_hdr *fh6, const struct iphdr *hdr4,
+			      u8 l4_proto)
+{
+	const u16 frag_off4 = ipxlat_get_frag4_offset(hdr4);
+	const bool mf = !!(be16_to_cpu(hdr4->frag_off) & IP_MF);
+
+	fh6->nexthdr = ipxlat_46_map_proto_to_nexthdr(l4_proto);
+	fh6->reserved = 0;
+	fh6->frag_off = ipxlat_46_build_frag_off(frag_off4, mf);
+	fh6->identification = cpu_to_be32(be16_to_cpu(hdr4->id));
+}
+
+void ipxlat_46_build_l3_hdr(struct ipv6hdr *iph6, const struct iphdr *iph4,
+			    unsigned int l3_payload_len, u8 nexthdr,
+			    u8 hop_limit)
+{
+	iph6->version = 6;
+	iph6->priority = iph4->tos >> 4;
+	iph6->flow_lbl[0] = (iph4->tos & 0x0F) << 4;
+	iph6->flow_lbl[1] = 0;
+	iph6->flow_lbl[2] = 0;
+	ipv6_set_payload_len(iph6, l3_payload_len);
+	iph6->nexthdr = nexthdr;
+	iph6->hop_limit = hop_limit;
+}
+
+int ipxlat_46_prepare_udp_csum(struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct udphdr *udp = udp_hdr(skb);
+	struct iphdr *iph4 = ip_hdr(skb);
+	unsigned int udp_len;
+	__sum16 csum;
+
+	if (!ipxlat_is_first_frag4(iph4) || skb->ip_summed == CHECKSUM_PARTIAL)
+		return 0;
+	if (likely(udp->check))
+		return 0;
+
+	udp_len = ntohs(udp->len);
+	if (unlikely(skb_ensure_writable(skb, cb->l4_off + sizeof(*udp))))
+		return -ENOMEM;
+
+	/* skb_ensure_writable might move pointers so re-acquire the headers */
+	iph4 = ip_hdr(skb);
+	udp = udp_hdr(skb);
+	udp->check = 0;
+	csum = csum_tcpudp_magic(iph4->saddr, iph4->daddr, udp_len, IPPROTO_UDP,
+				 skb_checksum(skb, cb->l4_off, udp_len, 0));
+	udp->check = csum ? csum : CSUM_MANGLED_0;
+	return 0;
+}
+
+static int ipxlat_46_translate_tcp_csum(struct sk_buff *skb,
+					const struct iphdr *in4)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct ipv6hdr *out6 = ipv6_hdr(skb);
+	struct tcphdr *tcp = tcp_hdr(skb);
+
+	/* CHECKSUM_PARTIAL contains a pseudo-header seed rather than a final
+	 * checksum. Replace it with the translated IPv6 pseudo-header and
+	 * leave completion to the later output path.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		tcp->check = ~tcp_v6_check(ipxlat_skb_l4_seg_len(skb, cb),
+					   &out6->saddr, &out6->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct tcphdr, check));
+	}
+
+	tcp->check = ipxlat_46_update_l4_csum(tcp->check, in4, out6);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+static int ipxlat_46_translate_udp_csum(struct sk_buff *skb,
+					const struct iphdr *in4)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct ipv6hdr *out6 = ipv6_hdr(skb);
+	struct udphdr *udp = udp_hdr(skb);
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		udp->check = ~udp_v6_check(ipxlat_skb_l4_seg_len(skb, cb),
+					   &out6->saddr, &out6->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct udphdr, check));
+	}
+
+	udp->check = ipxlat_46_update_l4_csum(udp->check, in4, out6);
+	if (unlikely(!udp->check))
+		udp->check = CSUM_MANGLED_0;
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_translate(const struct ipxlat_config *cfg, struct sk_buff *skb)
+{
+	unsigned int l3_payload_len, min_l4_len, old_l3_len, new_l3_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr outer4 = *ip_hdr(skb);
+	bool has_frag, first_frag;
+	u8 l4_proto4, l4_proto6;
+	struct frag_hdr *fh6;
+	struct ipv6hdr *iph6;
+	int l3_delta, err;
+
+	/* snapshot the original IPv4 header fields before skb layout changes */
+	l4_proto4 = cb->l4_proto;
+	l4_proto6 = ipxlat_46_map_proto_to_nexthdr(l4_proto4);
+	has_frag = ip_is_fragment(&outer4);
+	first_frag = ipxlat_is_first_frag4(&outer4);
+
+	old_l3_len = cb->l3_hdr_len;
+	new_l3_len = sizeof(struct ipv6hdr) +
+		     (has_frag ? sizeof(struct frag_hdr) : 0);
+	l3_delta = (int)new_l3_len - (int)old_l3_len;
+
+	/* reserve headroom and make the transport header writable */
+	if (unlikely(skb_cow_head(skb, max_t(int, 0, l3_delta))))
+		return -ENOMEM;
+	if (first_frag) {
+		min_l4_len = ipxlat_l4_min_len(l4_proto4);
+		if (unlikely(skb_ensure_writable(skb, cb->l4_off + min_l4_len)))
+			return -ENOMEM;
+	}
+
+	/* replace outer L3 area: drop IPv4 hdr, reserve IPv6(+Frag) hdr */
+	ipxlat_replace_l3(skb, old_l3_len, new_l3_len, new_l3_len);
+	skb->protocol = htons(ETH_P_IPV6);
+
+	/* parsed offsets include the old L3 length, which the delta replaces */
+	ipxlat_cb_rebase_offsets(cb, l3_delta);
+	DEBUG_NET_WARN_ON_ONCE(!ipxlat_cb_offsets_valid(cb));
+
+	cb->l3_hdr_len = new_l3_len;
+	cb->fragh_off = has_frag ? sizeof(struct ipv6hdr) : 0;
+	cb->l4_proto = l4_proto6;
+
+	/* build outer IPv6 base hdr from translated IPv4 fields */
+	iph6 = ipv6_hdr(skb);
+	l3_payload_len = skb->len - skb_network_offset(skb) - sizeof(*iph6);
+	ipxlat_46_build_l3_hdr(iph6, &outer4, l3_payload_len, l4_proto6,
+			       outer4.ttl);
+	ipxlat_46_convert_endpoints(cfg, &outer4, &iph6->saddr, &iph6->daddr);
+
+	/* add IPv6 fragment hdr when the IPv4 packet carried fragmentation */
+	if (unlikely(has_frag)) {
+		iph6->nexthdr = NEXTHDR_FRAGMENT;
+
+		fh6 = (struct frag_hdr *)(iph6 + 1);
+		ipxlat_46_build_frag_hdr(fh6, &outer4, l4_proto4);
+	}
+
+	/* non-first fragments have no transport header to translate */
+	if (unlikely(!first_frag))
+		goto out;
+
+	/* translate transport hdr and pseudohdr dependent checksums */
+	switch (l4_proto4) {
+	case IPPROTO_TCP:
+		err = ipxlat_46_translate_tcp_csum(skb, &outer4);
+		break;
+	case IPPROTO_UDP:
+		err = ipxlat_46_translate_udp_csum(skb, &outer4);
+		break;
+	default:
+		err = 0;
+		break;
+	}
+	if (unlikely(err))
+		return err;
+
+out:
+	/* normalize checksum/offload metadata for the translated frame */
+	return ipxlat_finalize_offload(skb, l4_proto4, has_frag, SKB_GSO_TCPV4,
+				       SKB_GSO_TCPV6);
+}
diff --git a/net/ipxlat/translate_46.h b/net/ipxlat/translate_46.h
new file mode 100644
index 000000000000..b3a63284e641
--- /dev/null
+++ b/net/ipxlat/translate_46.h
@@ -0,0 +1,77 @@
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
+#ifndef _NET_IPXLAT_TRANSLATE_46_H_
+#define _NET_IPXLAT_TRANSLATE_46_H_
+
+#include <net/ipxlat.h>
+
+struct iphdr;
+struct ipv6hdr;
+struct frag_hdr;
+struct sk_buff;
+
+/**
+ * ipxlat_46_map_proto_to_nexthdr - map IPv4 L4 protocol to IPv6 nexthdr
+ * @protocol: IPv4 L4 protocol
+ *
+ * Return: IPv6 next-header value corresponding to @protocol.
+ */
+u8 ipxlat_46_map_proto_to_nexthdr(u8 protocol);
+
+/**
+ * ipxlat_46_build_frag_hdr - build IPv6 Fragment Header from IPv4 fragment info
+ * @fh6: output IPv6 fragment header
+ * @hdr4: source IPv4 header
+ * @l4_proto: original IPv4 L4 protocol
+ */
+void ipxlat_46_build_frag_hdr(struct frag_hdr *fh6, const struct iphdr *hdr4,
+			      u8 l4_proto);
+
+/**
+ * ipxlat_46_build_l3_hdr - build translated IPv6 header from IPv4 metadata
+ * @iph6: output IPv6 header
+ * @iph4: source IPv4 header
+ * @l3_payload_len: IPv6 payload length
+ * @nexthdr: resulting IPv6 nexthdr
+ * @hop_limit: resulting IPv6 hop limit
+ */
+void ipxlat_46_build_l3_hdr(struct ipv6hdr *iph6, const struct iphdr *iph4,
+			    unsigned int l3_payload_len, u8 nexthdr,
+			    u8 hop_limit);
+
+/**
+ * ipxlat_46_prepare_udp_csum - checksum a validated zero-checksum UDP packet
+ * @skb: original IPv4 packet
+ *
+ * This runs after translation eligibility is known. Packets which already
+ * carry a checksum are unchanged.
+ *
+ * Return: 0 on success or %-ENOMEM when the UDP header cannot be made
+ * writable.
+ */
+int ipxlat_46_prepare_udp_csum(struct sk_buff *skb);
+
+/**
+ * ipxlat_46_translate - translate outer packet from IPv4 to IPv6 in place
+ * @cfg: immutable route translation configuration
+ * @skb: packet to translate
+ *
+ * Rewrites outer L3 in place, rebases cached offsets and translates L4 on
+ * first fragments only.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_46_translate(const struct ipxlat_config *cfg, struct sk_buff *skb);
+
+#endif /* _NET_IPXLAT_TRANSLATE_46_H_ */
diff --git a/net/ipxlat/translate_64.c b/net/ipxlat/translate_64.c
new file mode 100644
index 000000000000..2448d3da32e4
--- /dev/null
+++ b/net/ipxlat/translate_64.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <linux/icmpv6.h>
+#include <net/ip.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+
+#include "translate_64.h"
+#include "packet.h"
+#include "transport.h"
+
+u8 ipxlat_64_map_nexthdr_proto(u8 nexthdr)
+{
+	return (nexthdr == NEXTHDR_ICMP) ? IPPROTO_ICMP : nexthdr;
+}
+
+void ipxlat_64_build_l3_hdr(struct net *net, struct iphdr *iph4,
+			    const struct ipv6hdr *iph6,
+			    unsigned int tot_len, __be16 frag_off, u8 protocol,
+			    __be32 saddr, __be32 daddr, u8 ttl,
+			    const struct frag_hdr *frag6)
+{
+	iph4->version = 4;
+	iph4->ihl = 5;
+	iph4->tos = ipxlat_get_ipv6_tclass(iph6);
+	iph_set_totlen(iph4, tot_len);
+	iph4->frag_off = frag_off;
+	iph4->ttl = ttl;
+	iph4->protocol = protocol;
+	iph4->saddr = saddr;
+	iph4->daddr = daddr;
+	iph4->id = 0;
+	if (frag6)
+		iph4->id = ipxlat_64_map_frag_id(frag6);
+	else
+		__ip_select_ident(net, iph4, 1);
+	iph4->check = 0;
+	iph4->check = ip_fast_csum(iph4, iph4->ihl);
+}
+
+static int ipxlat_64_translate_tcp_csum(struct sk_buff *skb,
+					const struct ipv6hdr *in6)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr *out4 = ip_hdr(skb);
+	struct tcphdr *tcp = tcp_hdr(skb);
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		tcp->check = ~tcp_v4_check(ipxlat_skb_l4_seg_len(skb, cb),
+					   out4->saddr, out4->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct tcphdr, check));
+	}
+
+	tcp->check = ipxlat_64_update_l4_csum(tcp->check, in6, out4);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+static int ipxlat_64_translate_udp_csum(struct sk_buff *skb,
+					const struct ipv6hdr *in6)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr *out4 = ip_hdr(skb);
+	struct udphdr *udp = udp_hdr(skb);
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		udp->check = ~udp_v4_check(ipxlat_skb_l4_seg_len(skb, cb),
+					   out4->saddr, out4->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct udphdr, check));
+	}
+	/* A zero checksum is invalid on ordinary IPv6 UDP, but specialized
+	 * receive paths can allow it. It is a valid checksum choice in IPv4.
+	 */
+	if (!udp->check) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return 0;
+	}
+
+	udp->check = ipxlat_64_update_l4_csum(udp->check, in6, out4);
+	if (unlikely(!udp->check))
+		udp->check = CSUM_MANGLED_0;
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+static __be16 ipxlat_64_build_frag_off(const struct sk_buff *skb,
+				       const struct frag_hdr *frag6)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int ipv4_seg_len, l4_seg_len;
+	bool df, is_gso, mf;
+	u16 frag_offset;
+
+	/* an IPv6 Fragment Header maps to IPv4 fragmentation with DF clear */
+	if (frag6) {
+		mf = !!(be16_to_cpu(frag6->frag_off) & IP6_MF);
+		frag_offset = ipxlat_get_frag6_offset(frag6);
+		return ipxlat_64_encode_frag_off(false, mf, frag_offset);
+	}
+
+	/* legacy UFO represents one UDP datagram that will be materialized as
+	 * fragments, so its IPv4 header must leave DF clear
+	 */
+	is_gso = skb_is_gso(skb);
+	if (is_gso && (skb_shinfo(skb)->gso_type & SKB_GSO_UDP))
+		return ipxlat_64_encode_frag_off(false, false, 0);
+
+	/* IPv6 cannot use ordinary PMTU discovery below 1280 bytes. The
+	 * corresponding IPv4 size is 1260 bytes because its base header is 20
+	 * bytes smaller. Clear DF at or below that floor so low-MTU IPv4 links
+	 * can fragment the packet; above it, set DF so the IPv6 sender can
+	 * learn a smaller usable PMTU.
+	 */
+	if (is_gso) {
+		/* TCP and UDP-L4 GSO contain independent datagrams. Decide DF
+		 * from the IPv4 packet each eventual segment will become, not
+		 * from the size of the coalesced skb.
+		 */
+		l4_seg_len = ipxlat_skb_l4_seg_len(skb, cb);
+		ipv4_seg_len = sizeof(struct iphdr) + l4_seg_len;
+		df = ipxlat_64_should_set_df(ipv4_seg_len);
+		return ipxlat_64_encode_frag_off(df, false, 0);
+	}
+
+	df = ipxlat_64_should_set_df(skb->len);
+	return ipxlat_64_encode_frag_off(df, false, 0);
+}
+
+int ipxlat_64_translate(const struct ipxlat_config *cfg, struct net *net,
+			struct sk_buff *skb)
+{
+	unsigned int min_l4_len, old_l3_len, new_l3_len, tot_len4;
+	const struct ipv6hdr outer6 = *ipv6_hdr(skb);
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct frag_hdr *frag6 = NULL;
+	struct frag_hdr frag_copy;
+	u8 l4_proto4, l4_proto6;
+	struct iphdr *iph4;
+	int l3_delta, err;
+	__be16 frag_off;
+	bool first_frag;
+
+	/* snapshot original outer IPv6 fields before L3 rewrite */
+	l4_proto6 = cb->l4_proto;
+	l4_proto4 = ipxlat_64_map_nexthdr_proto(l4_proto6);
+	if (unlikely(cb->fragh_off)) {
+		frag_copy = *(struct frag_hdr *)(skb->data + cb->fragh_off);
+		frag6 = &frag_copy;
+	}
+	first_frag = ipxlat_is_first_frag6(frag6);
+
+	old_l3_len = cb->l3_hdr_len;
+	new_l3_len = sizeof(struct iphdr);
+	l3_delta = (int)new_l3_len - (int)old_l3_len;
+
+	/* reserve headroom and make the transport header writable */
+	if (unlikely(skb_cow_head(skb, max_t(int, 0, l3_delta))))
+		return -ENOMEM;
+	if (first_frag) {
+		min_l4_len = ipxlat_l4_min_len(l4_proto4);
+		if (unlikely(skb_ensure_writable(skb, cb->l4_off + min_l4_len)))
+			return -ENOMEM;
+	}
+
+	/* replace outer IPv6 header with IPv4 in-place */
+	ipxlat_replace_l3(skb, old_l3_len, new_l3_len, new_l3_len);
+	skb->protocol = htons(ETH_P_IP);
+
+	/* parsed offsets include the old L3 length, which the delta replaces */
+	ipxlat_cb_rebase_offsets(cb, l3_delta);
+	DEBUG_NET_WARN_ON_ONCE(!ipxlat_cb_offsets_valid(cb));
+
+	cb->l3_hdr_len = sizeof(struct iphdr);
+	cb->fragh_off = 0;
+	cb->l4_proto = l4_proto4;
+
+	/* build outer IPv4 base hdr from translated IPv6 fields */
+	iph4 = ip_hdr(skb);
+	frag_off = ipxlat_64_build_frag_off(skb, frag6);
+	tot_len4 = skb->len - skb_network_offset(skb);
+	ipxlat_64_build_l3_hdr(net, iph4, &outer6, tot_len4, frag_off,
+			       l4_proto4, cb->saddr4, cb->daddr4,
+			       outer6.hop_limit, frag6);
+
+	/* non-first fragments have no transport header to translate */
+	if (unlikely(!first_frag))
+		goto out;
+
+	/* translate transport hdr and pseudohdr dependent checksums */
+	switch (l4_proto4) {
+	case IPPROTO_TCP:
+		err = ipxlat_64_translate_tcp_csum(skb, &outer6);
+		break;
+	case IPPROTO_UDP:
+		err = ipxlat_64_translate_udp_csum(skb, &outer6);
+		break;
+	default:
+		err = 0;
+		break;
+	}
+	if (unlikely(err))
+		return err;
+
+out:
+	/* normalize checksum/offload metadata for the translated frame */
+	return ipxlat_finalize_offload(skb, l4_proto4,
+				       ip_is_fragment(ip_hdr(skb)),
+				       SKB_GSO_TCPV6, SKB_GSO_TCPV4);
+}
diff --git a/net/ipxlat/translate_64.h b/net/ipxlat/translate_64.h
new file mode 100644
index 000000000000..f0ed37e6ad91
--- /dev/null
+++ b/net/ipxlat/translate_64.h
@@ -0,0 +1,96 @@
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
+#ifndef _NET_IPXLAT_TRANSLATE_64_H_
+#define _NET_IPXLAT_TRANSLATE_64_H_
+
+#include <linux/ipv6.h>
+
+#include <net/ipxlat.h>
+
+struct sk_buff;
+struct iphdr;
+struct ipv6hdr;
+
+/**
+ * ipxlat_64_should_set_df - choose DF for IPv6 packets without a Fragment
+ *                           Header
+ * @pkt_len4: size of the resulting IPv4 packet
+ *
+ * Return: true when the IPv4 packet is above the IPv6-derived PMTU floor.
+ */
+static inline bool ipxlat_64_should_set_df(unsigned int pkt_len4)
+{
+	return pkt_len4 > IPV6_MIN_MTU - sizeof(struct ipv6hdr) +
+			  sizeof(struct iphdr);
+}
+
+/**
+ * ipxlat_64_map_frag_id - derive an IPv4 ID from an IPv6 Fragment Header
+ * @frag6: source IPv6 Fragment Header
+ *
+ * Return: the low 16 bits of the IPv6 identification in network byte order.
+ */
+static inline __be16 ipxlat_64_map_frag_id(const struct frag_hdr *frag6)
+{
+	return cpu_to_be16(be32_to_cpu(frag6->identification));
+}
+
+static inline __be16 ipxlat_64_encode_frag_off(bool df, bool mf,
+					       u16 frag_offset)
+{
+	return cpu_to_be16((df ? IP_DF : 0) | (mf ? IP_MF : 0) |
+			   (frag_offset >> 3));
+}
+
+/**
+ * ipxlat_64_build_l3_hdr - build translated IPv4 header from IPv6 metadata
+ * @net: namespace owning IPv4 identification state
+ * @iph4: output IPv4 header
+ * @iph6: source IPv6 header
+ * @tot_len: resulting IPv4 total length
+ * @frag_off: resulting IPv4 fragment offset/flags
+ * @protocol: resulting IPv4 L4 protocol
+ * @saddr: resulting IPv4 source address
+ * @daddr: resulting IPv4 destination address
+ * @ttl: resulting IPv4 TTL
+ * @frag6: source Fragment Header, or NULL to allocate a fresh IPv4 ID
+ */
+void ipxlat_64_build_l3_hdr(struct net *net, struct iphdr *iph4,
+			    const struct ipv6hdr *iph6, unsigned int tot_len,
+			    __be16 frag_off, u8 protocol, __be32 saddr,
+			    __be32 daddr, u8 ttl, const struct frag_hdr *frag6);
+
+/**
+ * ipxlat_64_translate - translate outer packet from IPv6 to IPv4 in place
+ * @cfg: immutable route translation configuration
+ * @net: namespace owning translated IPv4 fragment-ID state
+ * @skb: packet to translate
+ *
+ * Rewrites outer L3 in place, rebases cached offsets and translates L4 on
+ * first fragments only.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_64_translate(const struct ipxlat_config *cfg, struct net *net,
+			struct sk_buff *skb);
+
+/**
+ * ipxlat_64_map_nexthdr_proto - map IPv6 nexthdr to IPv4 L4 protocol
+ * @nexthdr: IPv6 next-header value
+ *
+ * Return: IPv4 protocol value corresponding to @nexthdr.
+ */
+u8 ipxlat_64_map_nexthdr_proto(u8 nexthdr);
+
+#endif /* _NET_IPXLAT_TRANSLATE_64_H_ */
-- 
2.55.0

