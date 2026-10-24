Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833994;
	b=sm+Rbw8E9zJ/xKkK7uGTa0Kkd8SfsmsljqYwCHufJw2VK9kGgaHvxYZry9BD85Qkz01N
	 3o4UsM45QEWJTzi/9/f0cbVxfGaurWnZARisncQtgKE9gSJi45mFRKnM9b04u9q9GXypP
	 xUqwvMPC524vNve15ruz5ZBClSp5ZUQVd/3xDUK1feR1e9EajDTqSdPrx6Yvu401k3iDj
	 Xcnuj8cqBh75NJxAEpDhrfZ2rg9nzlp1pxrmr1P5PK70HVA1V0t5CrNriP/zyqG1DDp4O
	 f0UG1RogKJVH0+LNq4aCgCksvA6QfgB0lTZOiyw6kw4RsYUOVQMHH218rPh0UlY5AMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833994;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=KvfCUSTip5sdqsoUbheejuL+i8/AfDU2PnnfVUeg6TY=;
	b=v8bZtb5wpOsB3dYmDShKifJstnTsKRt/MaZeROT9i+jT4nPHxeYshAJX4iYSGhLTv+6k
	 KKe7WXAXKDVLtEhI7C9m0JMFHzVZ0mQ1j/d45Y9JuIuy+zgjLwhGSWO55nB1XOf/WErSY
	 K/k53rglUFLrAQRuiKTPdLI8N5KvXjrRgUb/SAUg1Pe5kTY5/CY2DZh6Qi+6MuPmTYS0N
	 i2KXG7eoSaT+zp9AhfiHBY6NXv2fWnxc7Ks5e2igqyoE3Ys5nYwSBFlXp1P7ZZ+7AfNgC
	 NDWqEU7xNRI4IL7tGLgQrhSmpECTu5FA17iA4pAOrZ3nzfA7rX/2ckVhCa/9YQBQN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Nu32ezme;
	arc=none smtp.remote-ip=195.10.208.52
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074D60A262D;
	Sat, 24 Oct 2026 09:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A074D60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Nu32ezme
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jBZJK4mBMzLmGQ;
	Sat, 24 Oct 2026 11:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvfCUSTip5sdqsoUbheejuL+i8/AfDU2PnnfVUeg6TY=;
	b=Nu32ezmefBqQ6TOsfb4qOypcP0mW4OAGnlfSQB1OyhudLXf3e2c1nmBKKdWNfS8NmUup7c
	flAKCW2ys6Ju+UpDsd8eiuke+xbNFht+j/ydT2XRwYSh6qqF8JftnfzOHPinlVi8KHdtGY
	GAzhdmFQOloXuRJiprCqahE5OGQA2xTf3q05hyunJQ/rdgcdqB8CPJIjumgDx65vYqfQge
	O4TM59SZ/1sBQuj/Ea4msz3Zfa6noUhcqexipblESpjWMEVcGuLQVLI5u+CGKkADNKXg4a
	IcLiNhB2LBSz74RotX/wzpvCkzJ1fJpfX2TNGOwpcphlNQLVgFW5Qf0Tu+thdQ==
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
Subject: [RFC net-next v2 08/18] net: ipxlat: add IPv4 packet validation
Date: Sat, 24 Oct 2026 11:25:18 +0200
Message-ID: <20261024092532.172005-9-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJK4mBMzLmGQ

Validate IPv4 headers, options, transport headers, checksums and
bounded ICMP quotes while caching the offsets needed by later
translation stages.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-5-ralf@mandelbit.com/
- Split IPv4 parsing out of the v1 combined packet.c implementation.
- Separate unsupported packet shapes from malformed packets so an
  attachment can fall back before translation starts.
- Bound quoted-packet parsing to the quoted datagram.
- Pull the complete declared outer TCP header before later stages use it.
- Treat a CHECKSUM_PARTIAL UDP packet as checksum-present even when the
  checksum field still contains zero. (Sashiko)
- Validate ICMP checksums represented by CHECKSUM_COMPLETE rather than
  trusting all hardware checksum metadata. (Sashiko)

 net/ipxlat/Makefile  |   1 +
 net/ipxlat/packet4.c | 410 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 411 insertions(+)
 create mode 100644 net/ipxlat/packet4.c

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index 013c338a2576..f517eaa75423 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_NET_IPXLAT) += ipxlat.o
 ipxlat-objs += config.o
 ipxlat-objs += core.o
 ipxlat-objs += address.o
+ipxlat-objs += packet4.o
diff --git a/net/ipxlat/packet4.c b/net/ipxlat/packet4.c
new file mode 100644
index 000000000000..590f95fb6b2c
--- /dev/null
+++ b/net/ipxlat/packet4.c
@@ -0,0 +1,410 @@
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
+
+#include <net/ipxlat.h>
+
+#include "packet.h"
+
+static bool ipxlat_v4_validate_addr(__be32 addr4)
+{
+	return !(ipv4_is_zeronet(addr4) || ipv4_is_loopback(addr4) ||
+		 ipv4_is_multicast(addr4) || ipv4_is_lbcast(addr4));
+}
+
+/* RFC 7915 Section 4.1 requires ignoring IPv4 options unless an unexpired
+ * LSRR/SSRR is present, in which case we must send ICMPv4 SR_FAILED.
+ * We intentionally treat malformed option encoding as invalid input and
+ * drop early instead of continuing translation.
+ */
+static int ipxlat_v4_srr_check(struct sk_buff *skb, const struct iphdr *hdr)
+{
+	const u8 *opt, *end;
+	u8 type, len, ptr;
+
+	if (likely(hdr->ihl <= 5))
+		return 0;
+
+	opt = (const u8 *)(hdr + 1);
+	end = (const u8 *)hdr + (hdr->ihl << 2);
+
+	while (opt < end) {
+		type = opt[0];
+		if (type == IPOPT_END)
+			return 0;
+		if (type == IPOPT_NOOP) {
+			opt++;
+			continue;
+		}
+
+		if (unlikely(end - opt < 2))
+			return -EINVAL;
+
+		len = opt[1];
+		if (unlikely(len < 2 || opt + len > end))
+			return -EINVAL;
+
+		if (type == IPOPT_LSRR || type == IPOPT_SSRR) {
+			if (unlikely(len < 3))
+				return -EINVAL;
+
+			/* points to the beginning of the next IP addr */
+			ptr = opt[2];
+			if (unlikely(ptr < 4))
+				return -EINVAL;
+			if (unlikely(ptr > len))
+				return 0;
+			if (unlikely(ptr > len - 3))
+				return -EINVAL;
+
+			ipxlat_mark_icmp_drop(skb, ICMP_DEST_UNREACH,
+					      ICMP_SR_FAILED, 0);
+			return -EINVAL;
+		}
+
+		opt += len;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v4_pull_l3(struct sk_buff *skb, unsigned int l3_offset,
+			     unsigned int packet_end)
+{
+	const struct iphdr *iph;
+	unsigned int tot_len;
+	int l3_len;
+
+	if (unlikely(l3_offset > packet_end ||
+		     sizeof(*iph) > packet_end - l3_offset ||
+		     !pskb_may_pull(skb, l3_offset + sizeof(*iph))))
+		return -EINVAL;
+
+	iph = (const struct iphdr *)(skb->data + l3_offset);
+	if (unlikely(iph->version != 4 || iph->ihl < 5))
+		return -EINVAL;
+
+	l3_len = iph->ihl << 2;
+	if (unlikely(l3_len > packet_end - l3_offset))
+		return -EINVAL;
+
+	/* an ICMP skb has no GSO representation, so iph_totlen also works
+	 * for quoted inner headers without using unrelated GSO metadata
+	 */
+	tot_len = iph_totlen(skb, iph);
+	if (unlikely(tot_len < l3_len))
+		return -EINVAL;
+
+	if (unlikely(!pskb_may_pull(skb, l3_offset + l3_len)))
+		return -EINVAL;
+
+	return l3_len;
+}
+
+static int ipxlat_v4_pull_l4(struct sk_buff *skb, unsigned int l4_offset,
+			     u8 l4_proto, bool *is_icmp_err)
+{
+	unsigned int tcp_hdr_len;
+	struct icmphdr *icmp;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	*is_icmp_err = false;
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
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
+	case IPPROTO_UDP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*udp))))
+			return -EINVAL;
+
+		udp = (struct udphdr *)(skb->data + l4_offset);
+		if (unlikely(ntohs(udp->len) < sizeof(*udp)))
+			return -EINVAL;
+
+		return sizeof(struct udphdr);
+	case IPPROTO_ICMP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*icmp))))
+			return -EINVAL;
+
+		icmp = (struct icmphdr *)(skb->data + l4_offset);
+		*is_icmp_err = icmp_is_err(icmp->type);
+		return sizeof(struct icmphdr);
+	default:
+		return 0;
+	}
+}
+
+/* ICMP errors are only required to quote the first eight transport bytes.
+ * That is enough for UDP and ICMP, but not for a TCP data offset/checksum.
+ * We leave a quoted TCP header unchanged when the quote does not contain the
+ * complete header.
+ */
+static int ipxlat_v4_pull_icmp_l4(struct sk_buff *skb, unsigned int l4_offset,
+				  unsigned int quote_end, u8 l4_proto)
+{
+	struct icmphdr *icmp;
+	unsigned int need;
+
+	switch (l4_proto) {
+	case IPPROTO_ICMP:
+		need = sizeof(*icmp);
+		break;
+	case IPPROTO_UDP:
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
+	if (l4_proto == IPPROTO_ICMP) {
+		icmp = (struct icmphdr *)(skb->data + l4_offset);
+		if (unlikely(icmp_is_err(icmp->type)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v4_icmp_quote_end(const struct sk_buff *skb,
+				    unsigned int payload_off,
+				    unsigned int *quote_end)
+{
+	const struct icmphdr *icmp =
+		(const struct icmphdr *)(skb->data + payload_off -
+					 sizeof(*icmp));
+	unsigned int quote_len = icmp->un.reserved[1] << 2;
+
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
+static int ipxlat_v4_pull_icmp_inner(struct sk_buff *skb,
+				     unsigned int inner_l3_off,
+				     unsigned int quote_end)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int datagram_end, inner_l4_off;
+	const struct iphdr *inner_l3_hdr;
+	int inner_l3_len, err;
+
+	inner_l3_len = ipxlat_v4_pull_l3(skb, inner_l3_off, quote_end);
+	if (unlikely(inner_l3_len < 0))
+		return inner_l3_len;
+
+	inner_l3_hdr = (const struct iphdr *)(skb->data + inner_l3_off);
+	datagram_end = inner_l3_off + ntohs(inner_l3_hdr->tot_len);
+
+	/* accept non-first quoted fragments: only inner L3 is translatable */
+	inner_l4_off = inner_l3_off + inner_l3_len;
+	if (unlikely(inner_l3_off > U16_MAX || inner_l4_off > U16_MAX))
+		return -E2BIG;
+	cb->inner_l3_offset = inner_l3_off;
+	cb->inner_l4_offset = inner_l4_off;
+
+	if (unlikely(!ipxlat_is_first_frag4(inner_l3_hdr)))
+		return 0;
+
+	err = ipxlat_v4_pull_icmp_l4(skb, inner_l4_off,
+				     min(quote_end, datagram_end),
+				     inner_l3_hdr->protocol);
+	if (unlikely(err < 0))
+		return err;
+
+	return 0;
+}
+
+static int ipxlat_v4_pull_hdrs(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int payload_off, quote_end;
+	const struct iphdr *l3_hdr;
+	int err, l3_len, l4_len;
+
+	/* parse IPv4 header and get its full length including options */
+	l3_len = ipxlat_v4_pull_l3(skb, l3_off, skb->len);
+	if (unlikely(l3_len < 0))
+		return l3_len;
+	l3_hdr = ip_hdr(skb);
+
+	if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->daddr)))
+		return -EINVAL;
+
+	/* RFC 7915 Section 4.1 */
+	if (unlikely(ipxlat_v4_srr_check(skb, l3_hdr)))
+		return -EINVAL;
+	/* fragmented ICMPs cannot be translated by a stateless translator */
+	if (unlikely(l3_hdr->protocol == IPPROTO_ICMP &&
+		     ip_is_fragment(l3_hdr)))
+		return -EINVAL;
+
+	if (unlikely(l3_off + l3_len > U16_MAX))
+		return -E2BIG;
+
+	cb->l3_hdr_len = l3_len;
+	cb->l4_proto = l3_hdr->protocol;
+	cb->l4_off = l3_off + l3_len;
+	cb->payload_off = cb->l4_off;
+	cb->is_icmp_err = false;
+
+	/* only non fragmented packets or first fragments have transport hdrs */
+	if (unlikely(!ipxlat_is_first_frag4(l3_hdr))) {
+		if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->saddr)))
+			return -EINVAL;
+		return 0;
+	}
+
+	/* parse transport header and get its full length */
+	l4_len = ipxlat_v4_pull_l4(skb, cb->l4_off, l3_hdr->protocol,
+				   &cb->is_icmp_err);
+	if (unlikely(l4_len < 0))
+		return l4_len;
+	l3_hdr = ip_hdr(skb);
+
+	/* illegal IPv4 sources are accepted only for ICMPv4 errors */
+	if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->saddr) &&
+		     !cb->is_icmp_err))
+		return -EINVAL;
+
+	payload_off = cb->l4_off + l4_len;
+	if (unlikely(payload_off > U16_MAX))
+		return -E2BIG;
+	cb->payload_off = payload_off;
+
+	/* validate the quoted packet if it's an ICMP error */
+	if (unlikely(cb->is_icmp_err)) {
+		DEBUG_NET_WARN_ON_ONCE(cb->l4_proto != IPPROTO_ICMP);
+
+		err = ipxlat_v4_icmp_quote_end(skb, cb->payload_off,
+					       &quote_end);
+		if (unlikely(err))
+			return err;
+
+		err = ipxlat_v4_pull_icmp_inner(skb, cb->payload_off,
+						quote_end);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v4_validate_icmp_csum(const struct sk_buff *skb,
+					unsigned int l4_off)
+{
+	__sum16 csum;
+
+	switch (skb->ip_summed) {
+	case CHECKSUM_UNNECESSARY:
+	case CHECKSUM_PARTIAL:
+		return 0;
+	case CHECKSUM_COMPLETE:
+		return csum_fold(skb->csum) ? -EINVAL : 0;
+	case CHECKSUM_NONE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* compute checksum over ICMP header and payload, then fold to 16-bit
+	 * Internet checksum to validate it
+	 */
+	csum = csum_fold(skb_checksum(skb, l4_off, skb->len - l4_off, 0));
+	return unlikely(csum) ? -EINVAL : 0;
+}
+
+int ipxlat_v4_validate_skb(struct sk_buff *skb)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int udp_len;
+	struct iphdr *l3_hdr;
+	struct udphdr *udph;
+	int err;
+
+	err = ipxlat_v4_pull_hdrs(skb);
+	if (unlikely(err))
+		return err;
+
+	if (unlikely(cb->is_icmp_err)) {
+		/* Translation path recomputes ICMPv6 checksum from scratch.
+		 * Validate here so a corrupted ICMPv4 error is not converted
+		 * into a translated packet with a valid checksum.
+		 */
+		return ipxlat_v4_validate_icmp_csum(skb, cb->l4_off);
+	}
+
+	l3_hdr = ip_hdr(skb);
+	if (unlikely(!ipxlat_is_first_frag4(l3_hdr)))
+		return 0;
+
+	if (cb->l4_proto != IPPROTO_UDP)
+		return 0;
+
+	udph = (struct udphdr *)(skb->data + cb->l4_off);
+	/* CHECKSUM_PARTIAL is authoritative even when the checksum field is
+	 * zero, translation will simply reseed it for the IPv6 pseudo-header
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		return 0;
+
+	if (likely(udph->check != 0))
+		return 0;
+
+	/* We are in the path where the UDP header is present (unfragmented
+	 * packets or first fragments) and its checksum is zero. Fragmented
+	 * checksum-less IPv4 UDP is rejected because 4->6 cannot reliably
+	 * translate it.
+	 * We record an administrative-prohibited error so an ingress harness
+	 * can tell the sender why it was dropped.
+	 */
+	if (unlikely(ip_is_fragment(l3_hdr))) {
+		ipxlat_mark_icmp_drop(skb, ICMP_DEST_UNREACH, ICMP_PKT_FILTERED,
+				      0);
+		return -EINVAL;
+	}
+
+	/* udph->len bounds the span used to compute replacement checksum */
+	udp_len = ntohs(udph->len);
+	if (unlikely(udp_len > skb->len - cb->l4_off))
+		return -EINVAL;
+
+	return 0;
+}
-- 
2.55.0

