Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833975;
	b=2DsVuLcjjSZ1F87/+KHziwy9vJenXIyccFXq+asc1m0YFvGzZZ9++Qoe+QXSPhk23H+a
	 hAsQ9aTHKHD+tQt4A8hlO6k5W6HlyBYnYG3bPCfUFdM/KXraXBQHU6e7VUQU2Tw/JCz3u
	 bWdwTbkhbYln0w6RtMOjNcCoa/ICH8QoZG+qZGVAk10R07J8ckIs+2kA2xK69FrmMwEN1
	 zLw1Vgz3jDn4ifacJ9hr/WlDs9dWQ0Tzww/rR9pa/Z7Dj7OC/IY6R2MXlnZk2ypjMbVpK
	 +8is9dIVaD5BSiLm0L2FKapK7DMhHUDZpZBQbJ0scb6fm5YCsxjkdseIpfdoCWP4Z9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833975;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=+KU48K2y3a/h3zCxPUwLjBYhjWwwybNQzNrXzKbqF/A=;
	b=scWn6Fnn1A/1GDCtivN2q7yW+Ql6bX156JkKlf0mj9/4f9wom5DGVRheSVA8wqkR0wI7
	 YJsEeAMZruJzZcJkwJXyTG7vdYX6LZygy4KIWfUj/D+B/GIp16GfhYOf88uDT7GU4P0Oj
	 7RxeTXZI3geGKxX+YDJOPsROd8m+iBnVXc1OvQ8rLOrm8JCZ4SeIlGk5cPu+vhQLVvyaS
	 J7kJIspFvJBaTKy+RUYhq3ag2xya6rFZ8WfAJartD/BMkQrNBM2ML7bPRwmQpm1p3imbA
	 iXkZNzfbTjDMlX5NcbI9fLU7NcAb6PaVFzlHoc+zMyxiD00QwI4OrQkqJzPKw3mxjVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=v66TdWO4;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C00606A327;
	Sat, 24 Oct 2026 09:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C00606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=v66TdWO4
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jBZJL3FtyzFqtK;
	Sat, 24 Oct 2026 11:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KU48K2y3a/h3zCxPUwLjBYhjWwwybNQzNrXzKbqF/A=;
	b=v66TdWO46Ul0CrPFPETVU2bGi6h1HmMbvlbPVLJ4SrtfaiWT5v02Kz+pyFHfp1JH8JfC0H
	U10P0h2kz9bwUhzDQW6CQx4r3fyJw9y8425I2RXAcaUZcI/GUWoeSah+pxKSxbcdTeJNk8
	CxOxgSCP+fFJeKMZkKXBC0qiZ/BpqbyEb2ITroceWKq13A3adUZmog3W/pKnvJz2EG3xAQ
	lX9PmYUTJ901lcv7t1gsoFIXGFUdUQER2qMsFU9smgtPwjE3Iorbi3oKMo5BxR/Qg9gUjW
	qsngEuqts2S8TR4nly6AWB+5eKbKJSq52qY2astubXHlKLktiusnQ35F2gQDbA==
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
	Xavier Hsinyuan <xavierhsinyuan@outlook.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 09/18] net: ipxlat: add IPv6 packet validation
Date: Sat, 24 Oct 2026 11:25:19 +0200
Message-ID: <20261024092532.172005-10-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJL3FtyzFqtK

Validate IPv6 base and extension headers, transport headers, checksums
and bounded ICMPv6 quotes while recording the headers that survive
translation.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-6-ralf@mandelbit.com/
- Split IPv6 parsing out of the v1 combined packet.c implementation.
- Replace the IPv6 header walk with one explicitly bounded by the packet
  or quoted-datagram length.
- Include the IPv6 checksum declarations used by the ICMPv6 validator.
  (Xavier)
- Validate the TCP data offset and pull the complete declared header
  before later translation stages use it. (Sashiko)
- Accept a zero IPv6 payload length for the kernel's oversized GSO
  representation instead of rejecting it unconditionally. (Sashiko)
- Validate ICMPv6 checksums represented by CHECKSUM_COMPLETE. (Sashiko)
- Stop IPv6 header walking at an Authentication Header instead of
  silently removing it from the translated packet.
- Reject a zero UDPv6 checksum unless CHECKSUM_PARTIAL indicates that
  checksum completion is still pending.

 net/ipxlat/Makefile  |   1 +
 net/ipxlat/packet6.c | 468 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 469 insertions(+)
 create mode 100644 net/ipxlat/packet6.c

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index f517eaa75423..56c8a78fc863 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -8,3 +8,4 @@ ipxlat-objs += config.o
 ipxlat-objs += core.o
 ipxlat-objs += address.o
 ipxlat-objs += packet4.o
+ipxlat-objs += packet6.o
diff --git a/net/ipxlat/packet6.c b/net/ipxlat/packet6.c
new file mode 100644
index 000000000000..c772a2967b30
--- /dev/null
+++ b/net/ipxlat/packet6.c
@@ -0,0 +1,468 @@
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
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+
+#include <net/ip6_checksum.h>
+#include <net/ipxlat.h>
+
+#include "packet.h"
+
+static bool ipxlat_v6_validate_saddr(const struct in6_addr *addr6)
+{
+	return !(ipv6_addr_any(addr6) || ipv6_addr_loopback(addr6) ||
+		 ipv6_addr_is_multicast(addr6));
+}
+
+static int ipxlat_v6_pull_l4(struct sk_buff *skb, unsigned int l4_offset,
+			     u8 l4_proto, bool *is_icmp_err)
+{
+	unsigned int tcp_hdr_len;
+	struct icmp6hdr *icmp;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	*is_icmp_err = false;
+
+	switch (l4_proto) {
+	case NEXTHDR_TCP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*tcp))))
+			return -EINVAL;
+
+		tcp = (struct tcphdr *)(skb->data + l4_offset);
+		if (unlikely(tcp->doff < 5))
+			return -EINVAL;
+
+		tcp_hdr_len = __tcp_hdrlen(tcp);
+		if (unlikely(!pskb_may_pull(skb, l4_offset + tcp_hdr_len)))
+			return -EINVAL;
+
+		return tcp_hdr_len;
+	case NEXTHDR_UDP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*udp))))
+			return -EINVAL;
+
+		udp = (struct udphdr *)(skb->data + l4_offset);
+		if (unlikely(ntohs(udp->len) < sizeof(*udp)))
+			return -EINVAL;
+
+		return sizeof(struct udphdr);
+	case NEXTHDR_ICMP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*icmp))))
+			return -EINVAL;
+
+		icmp = (struct icmp6hdr *)(skb->data + l4_offset);
+		*is_icmp_err = icmpv6_is_err(icmp->icmp6_type);
+		return sizeof(struct icmp6hdr);
+	default:
+		return 0;
+	}
+}
+
+/* see ipxlat_v4_pull_icmp_l4: a minimum ICMP quote need not contain a
+ * complete TCP header, so only inspect fields present in the first 8 bytes
+ */
+static int ipxlat_v6_pull_icmp_l4(struct sk_buff *skb, unsigned int l4_offset,
+				  unsigned int quote_end, u8 l4_proto)
+{
+	struct icmp6hdr *icmp;
+	unsigned int need;
+
+	switch (l4_proto) {
+	case NEXTHDR_ICMP:
+		need = sizeof(*icmp);
+		break;
+	case NEXTHDR_UDP:
+		need = sizeof(struct udphdr);
+		break;
+	default:
+		return 0;
+	}
+
+	if (unlikely(l4_offset > quote_end || need > quote_end - l4_offset ||
+		     !pskb_may_pull(skb, l4_offset + need)))
+		return -EINVAL;
+
+	if (l4_proto == NEXTHDR_ICMP) {
+		icmp = (struct icmp6hdr *)(skb->data + l4_offset);
+		if (unlikely(icmpv6_is_err(icmp->icmp6_type)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v6_icmp_quote_end(const struct sk_buff *skb,
+				    unsigned int payload_off,
+				    unsigned int *quote_end)
+{
+	const struct icmp6hdr *icmp;
+	unsigned int quote_len;
+
+	icmp = (const struct icmp6hdr *)(skb->data + payload_off -
+					 sizeof(*icmp));
+	quote_len = icmp->icmp6_datagram_len << 3;
+	if (!quote_len) {
+		*quote_end = skb->len;
+		return 0;
+	}
+
+	/* a nonzero RFC 4884 delimiter describes at least 128 quoted bytes */
+	if (unlikely(quote_len < ICMP_EXT_ORIG_DGRAM_MIN_LEN ||
+		     payload_off > skb->len ||
+		     quote_len > skb->len - payload_off))
+		return -EINVAL;
+
+	*quote_end = payload_off + quote_len;
+	return 0;
+}
+
+/* Walk one IPv6 header chain without reading past packet_end. Outer packets
+ * also reject an active Routing Header; quoted packets are parsed only far
+ * enough to translate the bytes they contain.
+ */
+struct ipxlat_v6_hdrs {
+	unsigned int fragh_off;
+	unsigned int l4_off;
+	u8 l4_proto;
+	bool has_l4;
+};
+
+static bool ipxlat_v6_may_pull(struct sk_buff *skb, unsigned int offset,
+			       unsigned int len, unsigned int packet_end)
+{
+	if (offset > packet_end || len > packet_end - offset)
+		return false;
+	return pskb_may_pull(skb, offset + len);
+}
+
+static int ipxlat_v6_walk_hdrs(struct sk_buff *skb, unsigned int l3_offset,
+			       unsigned int packet_end,
+			       struct ipxlat_v6_hdrs *hdrs,
+			       bool check_rh)
+{
+	unsigned int ext_len, off;
+	struct ipv6_opt_hdr *ext;
+	struct ipv6_rt_hdr *rh;
+	struct frag_hdr *frag;
+	struct ipv6hdr *ip6h;
+	u8 nexthdr;
+	u32 ptr;
+
+	if (unlikely(!ipxlat_v6_may_pull(skb, l3_offset, sizeof(*ip6h),
+					 packet_end)))
+		return -EINVAL;
+
+	ip6h = (struct ipv6hdr *)(skb->data + l3_offset);
+	nexthdr = ip6h->nexthdr;
+	off = l3_offset + sizeof(*ip6h);
+	hdrs->has_l4 = true;
+	hdrs->fragh_off = 0;
+
+	while (ipv6_ext_hdr(nexthdr)) {
+		/* AH is protected payload here: translation preserves it but
+		 * does not inspect or rewrite anything after it
+		 */
+		if (nexthdr == NEXTHDR_AUTH || nexthdr == NEXTHDR_NONE)
+			break;
+
+		if (nexthdr == NEXTHDR_FRAGMENT) {
+			if (unlikely(hdrs->fragh_off ||
+				     !ipxlat_v6_may_pull(skb, off,
+							 sizeof(*frag),
+							 packet_end)))
+				return -EINVAL;
+
+			frag = (struct frag_hdr *)(skb->data + off);
+			hdrs->fragh_off = off;
+			nexthdr = frag->nexthdr;
+			off += sizeof(*frag);
+
+			/* IPv6 fragment offsets include any extension headers
+			 * after the Fragment Header. Later fragments do not
+			 * carry those headers, so a stateless translator
+			 * cannot remove them and adjust every offset. AH also
+			 * cannot survive the outer header rewrite because the
+			 * translator cannot update its integrity value.
+			 * ipv6_ext_hdr deliberately excludes ESP, which is
+			 * preserved as opaque payload as required by RFC 7915.
+			 */
+			if (unlikely(ipv6_ext_hdr(nexthdr) &&
+				     nexthdr != NEXTHDR_NONE)) {
+				ipxlat_mark_icmp_drop(skb, ICMPV6_DEST_UNREACH,
+						      ICMPV6_ADM_PROHIBITED, 0);
+				return -EINVAL;
+			}
+
+			if (!ipxlat_is_first_frag6(frag)) {
+				hdrs->l4_proto = nexthdr;
+				hdrs->l4_off = off;
+				hdrs->has_l4 = false;
+				return 0;
+			}
+			continue;
+		}
+
+		if (unlikely(!ipxlat_v6_may_pull(skb, off, sizeof(*ext),
+						 packet_end)))
+			return -EINVAL;
+
+		ext = (struct ipv6_opt_hdr *)(skb->data + off);
+		ext_len = ipv6_optlen(ext);
+		if (unlikely(!ipxlat_v6_may_pull(skb, off, ext_len,
+						 packet_end)))
+			return -EINVAL;
+
+		ext = (struct ipv6_opt_hdr *)(skb->data + off);
+		if (check_rh && nexthdr == NEXTHDR_ROUTING) {
+			rh = (struct ipv6_rt_hdr *)ext;
+			ptr = off - l3_offset +
+			      offsetof(struct ipv6_rt_hdr, segments_left);
+
+			if (unlikely(rh->segments_left)) {
+				ipxlat_mark_icmp_drop(skb, ICMPV6_PARAMPROB,
+						      ICMPV6_HDR_FIELD, ptr);
+				return -EINVAL;
+			}
+		}
+
+		nexthdr = ext->nexthdr;
+		off += ext_len;
+	}
+
+	hdrs->l4_proto = nexthdr;
+	hdrs->l4_off = off;
+	return 0;
+}
+
+static int ipxlat_v6_pull_outer_l3(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	unsigned int payload_len, skb_payload_len;
+	struct ipv6hdr *l3_hdr;
+
+	if (unlikely(!pskb_may_pull(skb, l3_off + sizeof(*l3_hdr))))
+		return -EINVAL;
+	l3_hdr = ipv6_hdr(skb);
+
+	if (unlikely(l3_hdr->version != 6 ||
+		     !ipxlat_v6_validate_saddr(&l3_hdr->saddr)))
+		return -EINVAL;
+
+	payload_len = be16_to_cpu(l3_hdr->payload_len);
+	skb_payload_len = skb->len - l3_off - sizeof(*l3_hdr);
+	/* A zero payload length represents an empty packet, a wire jumbogram,
+	 * or an oversized GSO aggregate. Jumbograms are not supported.
+	 */
+	if (payload_len) {
+		if (unlikely(payload_len != skb_payload_len))
+			return -EINVAL;
+		return 0;
+	}
+	if (!skb_payload_len)
+		return 0;
+	if (unlikely(!skb_is_gso(skb) || skb_payload_len <= IPV6_MAXPLEN))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ipxlat_v6_pull_icmp_inner(struct sk_buff *skb,
+				     unsigned int outer_payload_off,
+				     unsigned int quote_end)
+{
+	struct ipxlat_v6_hdrs hdrs;
+	unsigned int datagram_end, inner_l3_len;
+	unsigned int inner_payload_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct ipv6hdr *inner_ip6;
+	int err;
+
+	if (unlikely(!ipxlat_v6_may_pull(skb, outer_payload_off,
+					 sizeof(*inner_ip6), quote_end)))
+		return -EINVAL;
+
+	inner_ip6 = (struct ipv6hdr *)(skb->data + outer_payload_off);
+	if (unlikely(inner_ip6->version != 6))
+		return -EINVAL;
+	inner_payload_len = be16_to_cpu(inner_ip6->payload_len);
+	datagram_end = outer_payload_off + sizeof(*inner_ip6) +
+		       inner_payload_len;
+	quote_end = min(quote_end, datagram_end);
+
+	err = ipxlat_v6_walk_hdrs(skb, outer_payload_off, quote_end, &hdrs,
+				  false);
+	if (unlikely(err))
+		return err;
+	inner_l3_len = hdrs.l4_off - outer_payload_off;
+	if (unlikely(inner_l3_len > sizeof(*inner_ip6) + inner_payload_len))
+		return -EINVAL;
+	if (unlikely(outer_payload_off > U16_MAX || hdrs.l4_off > U16_MAX ||
+		     hdrs.fragh_off > U16_MAX))
+		return -E2BIG;
+
+	cb->inner_l3_offset = outer_payload_off;
+	cb->inner_l4_offset = hdrs.l4_off;
+	cb->inner_fragh_off = hdrs.fragh_off;
+	cb->inner_l4_proto = hdrs.l4_proto;
+
+	if (likely(hdrs.has_l4)) {
+		err = ipxlat_v6_pull_icmp_l4(skb, hdrs.l4_off, quote_end,
+					     hdrs.l4_proto);
+		if (unlikely(err < 0))
+			return err;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v6_pull_hdrs(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	unsigned int l3_len, payload_off, quote_end;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct ipxlat_v6_hdrs hdrs;
+	struct frag_hdr *frag;
+	int l4_len, err;
+
+	/* parse IPv6 base header and perform basic structural checks */
+	err = ipxlat_v6_pull_outer_l3(skb);
+	if (unlikely(err))
+		return err;
+
+	/* walk extension/fragment headers and locate the transport header */
+	err = ipxlat_v6_walk_hdrs(skb, l3_off, skb->len, &hdrs, true);
+	if (unlikely(err))
+		return err;
+
+	l3_len = hdrs.l4_off - l3_off;
+	payload_off = hdrs.l4_off;
+	if (unlikely(hdrs.l4_off > U16_MAX || hdrs.fragh_off > U16_MAX ||
+		     l3_len > U16_MAX))
+		return -E2BIG;
+
+	cb->l4_proto = hdrs.l4_proto;
+	cb->l4_off = hdrs.l4_off;
+	cb->fragh_off = hdrs.fragh_off;
+	cb->l3_hdr_len = l3_len;
+
+	if (likely(hdrs.has_l4)) {
+		l4_len = ipxlat_v6_pull_l4(skb, hdrs.l4_off, hdrs.l4_proto,
+					   &cb->is_icmp_err);
+		if (unlikely(l4_len < 0))
+			return l4_len;
+		payload_off += l4_len;
+	}
+	if (unlikely(payload_off > U16_MAX))
+		return -E2BIG;
+	cb->payload_off = payload_off;
+
+	if (unlikely(hdrs.l4_proto == NEXTHDR_ICMP && hdrs.fragh_off)) {
+		/* A stateless translator cannot reliably translate ICMP
+		 * checksum across real IPv6 fragments, so fragmented ICMP is
+		 * dropped. A Fragment Header alone, however, is not enough to
+		 * decide: so-called atomic fragments (offset=0, M=0) carry a
+		 * Fragment Header but are not actually fragmented.
+		 */
+		frag = (struct frag_hdr *)(skb->data + hdrs.fragh_off);
+		if (unlikely(ipxlat_get_frag6_offset(frag) ||
+			     (be16_to_cpu(frag->frag_off) & IP6_MF)))
+			return -EINVAL;
+	}
+
+	if (unlikely(cb->is_icmp_err)) {
+		/* validate the quoted packet in an ICMP error */
+		err = ipxlat_v6_icmp_quote_end(skb, payload_off, &quote_end);
+		if (unlikely(err))
+			return err;
+
+		err = ipxlat_v6_pull_icmp_inner(skb, payload_off, quote_end);
+		if (unlikely(err))
+			return err;
+	}
+
+	DEBUG_NET_WARN_ON_ONCE(cb->is_icmp_err && cb->l4_proto != NEXTHDR_ICMP);
+
+	return 0;
+}
+
+static int ipxlat_v6_validate_icmp_csum(const struct sk_buff *skb,
+					unsigned int l4_off)
+{
+	struct ipv6hdr *iph6;
+	unsigned int len;
+	__sum16 csum;
+
+	switch (skb->ip_summed) {
+	case CHECKSUM_UNNECESSARY:
+	case CHECKSUM_PARTIAL:
+		return 0;
+	case CHECKSUM_COMPLETE:
+		iph6 = ipv6_hdr(skb);
+		len = skb->len - l4_off;
+		if (csum_ipv6_magic(&iph6->saddr, &iph6->daddr, len,
+				    NEXTHDR_ICMP, skb->csum))
+			return -EINVAL;
+		return 0;
+	case CHECKSUM_NONE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	iph6 = ipv6_hdr(skb);
+	len = skb->len - l4_off;
+	csum = csum_ipv6_magic(&iph6->saddr, &iph6->daddr, len, NEXTHDR_ICMP,
+			       skb_checksum(skb, l4_off, len, 0));
+
+	return unlikely(csum) ? -EINVAL : 0;
+}
+
+int ipxlat_v6_validate_skb(struct sk_buff *skb)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int l3_off, max_len6, pkt_len4, pkt_len6;
+	int err;
+
+	err = ipxlat_v6_pull_hdrs(skb);
+	if (unlikely(err))
+		return err;
+
+	/* IPv6's payload length does not include its 40-byte base header, so a
+	 * legal IPv6 packet can be 65575 bytes long. IPv4's total length does
+	 * include its header, and zero is only meaningful for a GSO aggregate.
+	 */
+	l3_off = skb_network_offset(skb);
+	pkt_len6 = skb->len - l3_off;
+	pkt_len4 = pkt_len6 - cb->l3_hdr_len + sizeof(struct iphdr);
+	if (unlikely(!skb_is_gso(skb) && pkt_len4 > IP_MAX_MTU)) {
+		/* IPv4 cannot represent the translated length: tell a remote
+		 * IPv6 sender the largest packet that can cross this node.
+		 */
+		max_len6 = IP_MAX_MTU + cb->l3_hdr_len - sizeof(struct iphdr);
+		ipxlat_mark_icmp_drop(skb, ICMPV6_PKT_TOOBIG, 0, max_len6);
+		return -EMSGSIZE;
+	}
+
+	if (unlikely(cb->is_icmp_err)) {
+		/* the translated ICMPv4 checksum is recomputed from scratch,
+		 * so reject bad ICMPv6 error checksums before conversion
+		 */
+		err = ipxlat_v6_validate_icmp_csum(skb, cb->l4_off);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
-- 
2.55.0

