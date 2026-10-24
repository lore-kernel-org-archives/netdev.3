Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833983;
	b=QaObN5JoOJoae51N3YU+noUknsPEaBE7EEj1T9HIKUtD2PO7xM/v2io6zYRP4Br2hsAW
	 wEI0ilsMkiw3ykX1m6Rw3gM/Wfx2M4aUABDAGkFAkfUwCnUKjHV5upANlgnFjFFfNBLDd
	 sOjKJ8aB/k5w/ujJ+lQyjSU1WTT3fzRqVsOuNC7K9LS7EyXPwo3lCVY2+dTiEo2ori338
	 sUrSleVyI17DFbVsFIvhSMlfB3JtC/ou07CQBQbIjm+mvChEj/msNLTiFwKUV6P5swXhM
	 bFAJLJUuSLpH1ahzV4Q76IfYx/xj8KZx0lA/Enw65DkEp+Ik81x8OTn2LXpXTG/TCXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833983;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=nexS3fYSB/PqkjFd+9OTp4k86TyAUg+3bb5stPFQM28=;
	b=lRV5Sw6sAqm/eUEHFAw+/KAGfzJ4pRbssLoW2ZC/IwN7iRn7xQC+Bs9MPizi3PDXiXCr
	 vCHLcMtoCBRc5lY+2rC385m7170WAAbu2TNOk4/ixkGeqP2LO3/CBou4qaPQXxKiGuWNS
	 0/Sulv/xY+wuE55FK1PNwjTet+C0iQeFuPLN7snkBn2UzuRnqg8lgfAeZ9BXVGXLJiXUk
	 4lT8YcI0v27E+W2fY/+6WlGuFEfBJpKgNVXT+MBV3N8lC1Sta7R0Hk6DafzHPYHyEatMu
	 VAPm/oy73F2Nf7QZcAXKTh0HJLtiThzLAPNb/5uYG7UNyRZq5wnS0TBf4JgQ+O1TJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=uukbCjF6;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E18606A32D;
	Sat, 24 Oct 2026 09:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E18606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=uukbCjF6
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jBZJM1ZtMz9tXl;
	Sat, 24 Oct 2026 11:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nexS3fYSB/PqkjFd+9OTp4k86TyAUg+3bb5stPFQM28=;
	b=uukbCjF6gSFwApQNGt6z5PW4rpdC/XegCONKrwjoj1l/LEY3XHrMn5cg1HYDMXCFyWjxLT
	S1Qj7b6JCYzPnvET1AitQj9Fgt5MBaJJ0So1q23LbX7qCnSO99Cym+zb4xhojY1eY6rzPi
	UqlB2aOWpg46RyFMutNhngkbrzUEs3DsJi48qyipI6uq6oSOUu1C0raBU1uQRIUJKIb3QN
	t1fZoOp2+lTXM+tD5frmK3T40OK0qA3At/IfpQtQyis5T9QzkkzHZ38kKjGcc/saR+IH+n
	V++Mi6DKOC7omrpNZeD4bMpcjgzwx1DD5zcwqnkUqs4tJ2bRQ+pVyPpotGX0HA==
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
Subject: [RFC net-next v2 10/18] net: ipxlat: add checksum and offload helpers
Date: Sat, 24 Oct 2026 11:25:20 +0200
Message-ID: <20261024092532.172005-11-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJM1ZtMz9tXl

Add incremental pseudo-header checksum replacement, CHECKSUM_PARTIAL
setup, complete IPv6 checksums, RFC 4884 payload relayout and
cross-family GSO metadata normalization.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-7-ralf@mandelbit.com/
- Rework the v1 checksum helpers around the attachment-independent
  engine.
- Distinguish GSO aggregate length from eventual segment length,
  including legacy UFO's header-inclusive gso_size convention.
- Introduce helpers only in the patch containing their first caller,
  keeping each intermediate build free of unused-static-function
  warnings. (Sashiko)

 net/ipxlat/Makefile    |   1 +
 net/ipxlat/transport.c | 179 +++++++++++++++++++++++++++++++++++++++++
 net/ipxlat/transport.h | 127 +++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 net/ipxlat/transport.c
 create mode 100644 net/ipxlat/transport.h

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index 56c8a78fc863..91baab41d5eb 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -9,3 +9,4 @@ ipxlat-objs += core.o
 ipxlat-objs += address.o
 ipxlat-objs += packet4.o
 ipxlat-objs += packet6.o
+ipxlat-objs += transport.o
diff --git a/net/ipxlat/transport.c b/net/ipxlat/transport.c
new file mode 100644
index 000000000000..118f5801c7e8
--- /dev/null
+++ b/net/ipxlat/transport.c
@@ -0,0 +1,179 @@
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
+#include <net/ip.h>
+#include <net/ip6_checksum.h>
+
+#include "transport.h"
+
+int ipxlat_set_partial_csum(struct sk_buff *skb, u16 csum_offset)
+{
+	if (likely(skb_partial_csum_set(skb, skb_transport_offset(skb),
+					csum_offset)))
+		return 0;
+	return -EINVAL;
+}
+
+static __wsum ipxlat_pseudohdr6_csum(const struct ipv6hdr *hdr)
+{
+	return ~csum_unfold(csum_ipv6_magic(&hdr->saddr, &hdr->daddr, 0, 0, 0));
+}
+
+static __wsum ipxlat_pseudohdr4_csum(const struct iphdr *hdr)
+{
+	return csum_tcpudp_nofold(hdr->saddr, hdr->daddr, 0, 0, 0);
+}
+
+__sum16 ipxlat_46_update_l4_csum(__sum16 csum16, const struct iphdr *in_ip4,
+				 const struct ipv6hdr *out_ip6)
+{
+	__wsum csum;
+
+	csum = ~csum_unfold(csum16);
+
+	/* only address terms change for TCP and UDP */
+	csum = csum_sub(csum, ipxlat_pseudohdr4_csum(in_ip4));
+	csum = csum_add(csum, ipxlat_pseudohdr6_csum(out_ip6));
+	return csum_fold(csum);
+}
+
+__sum16 ipxlat_64_update_l4_csum(__sum16 csum16, const struct ipv6hdr *in_ip6,
+				 const struct iphdr *out_ip4)
+{
+	__wsum csum;
+
+	csum = ~csum_unfold(csum16);
+
+	/* only address terms change for TCP and UDP */
+	csum = csum_sub(csum, ipxlat_pseudohdr6_csum(in_ip6));
+	csum = csum_add(csum, ipxlat_pseudohdr4_csum(out_ip4));
+	return csum_fold(csum);
+}
+
+__sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
+			    const struct in6_addr *daddr,
+			    const struct sk_buff *skb, unsigned int l4_off,
+			    unsigned int l4_len, u8 proto)
+{
+	return csum_ipv6_magic(saddr, daddr, l4_len, proto,
+			       skb_checksum(skb, l4_off, l4_len, 0));
+}
+
+static int ipxlat_ensure_tailroom(struct sk_buff *skb, const unsigned int grow)
+{
+	int err;
+
+	if (!grow || skb_tailroom(skb) >= grow)
+		return 0;
+
+	/* tail growth may reallocate backing storage and move skb data */
+	err = pskb_expand_head(skb, 0, grow - skb_tailroom(skb), GFP_ATOMIC);
+	if (unlikely(err))
+		return err;
+
+	return 0;
+}
+
+int ipxlat_icmp_relayout(struct sk_buff *skb,
+			 const struct ipxlat_icmp_layout *layout)
+{
+	const unsigned int output_ext_off = layout->outer_len +
+					    layout->output_quote_len +
+					    layout->output_pad_len;
+	const unsigned int input_ext_off = layout->outer_len +
+					   layout->input_quote_len;
+	const unsigned int new_len = output_ext_off +
+				     layout->output_ext_len;
+	const unsigned int old_len = skb->len;
+	unsigned int grow = 0;
+	int err;
+
+	/* reserve tailroom before extending the translated layout */
+	if (unlikely(new_len > old_len)) {
+		grow = new_len - old_len;
+
+		err = ipxlat_ensure_tailroom(skb, grow);
+		if (unlikely(err))
+			return err;
+
+		__skb_put(skb, grow);
+	}
+
+	if (unlikely(layout->output_ext_len))
+		memmove(skb->data + output_ext_off, skb->data + input_ext_off,
+			layout->output_ext_len);
+
+	if (unlikely(layout->output_pad_len))
+		memset(skb->data + layout->outer_len + layout->output_quote_len,
+		       0, layout->output_pad_len);
+
+	if (unlikely(new_len < old_len)) {
+		err = pskb_trim(skb, new_len);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
+			    u32 gso_from, u32 gso_to)
+{
+	struct skb_shared_info *shinfo;
+	bool preserve_l4_hash;
+
+	if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE))
+		skb->ip_summed = CHECKSUM_NONE;
+
+	if (!skb_is_gso(skb))
+		goto out_hash;
+
+	/* align with forwarding paths that reject LRO skbs before xmit */
+	if (unlikely(skb_warn_if_lro(skb)))
+		return -EINVAL;
+
+	shinfo = skb_shinfo(skb);
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		/* segment payload size is unchanged by address-family
+		 * translation so there's no need to touch gso_size
+		 */
+		if (shinfo->gso_type & gso_from) {
+			shinfo->gso_type &= ~gso_from;
+			shinfo->gso_type |= gso_to;
+		} else if (unlikely(!(shinfo->gso_type & gso_to))) {
+			return -EINVAL;
+		}
+		break;
+	case IPPROTO_UDP:
+		break;
+	case IPPROTO_ICMP:
+		/* for ICMP there is no GSO transform: clear stale offload
+		 * metadata so the stack treats it as a normal frame
+		 */
+		skb_gso_reset(skb);
+		break;
+	default:
+		/* other GSO types need an explicit cross-family mapping */
+		return -EINVAL;
+	}
+
+out_hash:
+	preserve_l4_hash = !is_fragment &&
+			   (l4_proto == IPPROTO_TCP || l4_proto == IPPROTO_UDP);
+	if (likely(preserve_l4_hash))
+		skb_clear_hash_if_not_l4(skb);
+	else
+		skb_clear_hash(skb);
+	return 0;
+}
diff --git a/net/ipxlat/transport.h b/net/ipxlat/transport.h
new file mode 100644
index 000000000000..a82776abccc8
--- /dev/null
+++ b/net/ipxlat/transport.h
@@ -0,0 +1,127 @@
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
+#ifndef _NET_IPXLAT_TRANSPORT_H_
+#define _NET_IPXLAT_TRANSPORT_H_
+
+#include <linux/icmp.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+/**
+ * ipxlat_l4_min_len - minimum transport header size for protocol
+ * @protocol: transport protocol identifier
+ *
+ * Return: minimum header length for @protocol, or 0 when unsupported.
+ */
+static inline unsigned int ipxlat_l4_min_len(u8 protocol)
+{
+	switch (protocol) {
+	case IPPROTO_TCP:
+		return sizeof(struct tcphdr);
+	case IPPROTO_UDP:
+		return sizeof(struct udphdr);
+	case IPPROTO_ICMP:
+		return sizeof(struct icmphdr);
+	default:
+		return 0;
+	}
+}
+
+/**
+ * ipxlat_set_partial_csum - program CHECKSUM_PARTIAL metadata on skb
+ * @skb: packet with transport checksum field
+ * @csum_offset: offset of checksum field within transport header
+ *
+ * Return: 0 on success, negative errno on invalid skb state.
+ */
+int ipxlat_set_partial_csum(struct sk_buff *skb, u16 csum_offset);
+
+/**
+ * ipxlat_46_update_l4_csum - replace IPv4 pseudo-header checksum terms
+ * @csum16: folded TCP or UDP checksum
+ * @in_ip4: original IPv4 header
+ * @out_ip6: translated IPv6 header
+ *
+ * Return: checksum adjusted for the translated addresses.
+ */
+__sum16 ipxlat_46_update_l4_csum(__sum16 csum16, const struct iphdr *in_ip4,
+				 const struct ipv6hdr *out_ip6);
+
+/**
+ * ipxlat_64_update_l4_csum - replace IPv6 pseudo-header checksum terms
+ * @csum16: folded TCP or UDP checksum
+ * @in_ip6: original IPv6 header
+ * @out_ip4: translated IPv4 header
+ *
+ * Return: checksum adjusted for the translated addresses.
+ */
+__sum16 ipxlat_64_update_l4_csum(__sum16 csum16, const struct ipv6hdr *in_ip6,
+				 const struct iphdr *out_ip4);
+
+/**
+ * ipxlat_l4_csum_ipv6 - compute full L4 checksum with IPv6 pseudo-header
+ * @saddr: IPv6 source address
+ * @daddr: IPv6 destination address
+ * @skb: packet buffer
+ * @l4_off: transport header offset
+ * @l4_len: transport span (header + payload)
+ * @proto: transport protocol
+ *
+ * Return: folded checksum value covering pseudo-header and transport payload.
+ */
+__sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
+			    const struct in6_addr *daddr,
+			    const struct sk_buff *skb, unsigned int l4_off,
+			    unsigned int l4_len, u8 proto);
+
+struct ipxlat_icmp_layout {
+	unsigned int outer_len;
+	unsigned int input_quote_len;
+	unsigned int input_ext_len;
+	unsigned int output_quote_len;
+	unsigned int output_pad_len;
+	unsigned int output_ext_len;
+};
+
+/**
+ * ipxlat_icmp_relayout - resize quoted ICMP payload/extensions in place
+ * @skb: packet buffer
+ * @layout: input and output quote/extension layout
+ *
+ * Moves extension bytes, adds the requested padding and grows or trims the skb
+ * to match @layout.
+ *
+ * Return: 0 on success, negative errno on resize/memory failures.
+ */
+int ipxlat_icmp_relayout(struct sk_buff *skb,
+			 const struct ipxlat_icmp_layout *layout);
+
+/**
+ * ipxlat_finalize_offload - normalize checksum/GSO metadata after translation
+ * @skb: translated packet
+ * @l4_proto: IPv4-side transport protocol
+ * @is_fragment: resulting packet is fragmented
+ * @gso_from: input TCP GSO type bit
+ * @gso_to: output TCP GSO type bit
+ *
+ * Remaps TCP GSO family bits, preserves UDP GSO and clears ICMP GSO metadata.
+ * It also rejects LRO or incompatible GSO representations and clears stale
+ * packet hashes when tuple semantics changed.
+ *
+ * Return: 0 on success, negative errno on incompatible offload metadata.
+ */
+int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
+			    u32 gso_from, u32 gso_to);
+
+#endif /* _NET_IPXLAT_TRANSPORT_H_ */
-- 
2.55.0

