Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833979;
	b=TNO7L1fLr2PKRhlxUmsUw24uGs1tH0jRfqIDNk3sqcGDgr2TbBPKoZuzdvBdLb1y1KUB
	 9SB6dItpyEW38PQaE5EN3vqBcJT6HEjSurvvDnoy6mzOKhJa0JpbcJt0K1oZYla9T0A03
	 ftFfqxk3ctyr+Hx6qWkBO2F2ZzFxVYWxph/pLCMi7J0YwS/YUEE63oz73Q6BFai3o5dVU
	 O96RUbkYY20fDOcpWittw7LizIPVAVJeYLSL8khx+qzPqskNEzMMblg2Bf9tE4YI6/PPQ
	 Yx5VH/16l9L5ogDUOeY+tRD/JHKubvxpRFvJjmD2dCppb2MtiUGXybhi9ri9vJUy4aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833979;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=N9uA8jllFwTMruE/1nsLXKX9TPpVlW6LoicOK8rphvw=;
	b=wPaPxIlktM2P0AMjANICwMarpgp7UEW7Ng6BvbcWDX+tBOJH/Jwg6zqWR0jf3eheu4wA
	 sIyjnZ8mLsWsrPW0p63/gPqglJO9R8u5ul9tAQBYj6wCWo8bMnvzsf/EsKUCMurAEE0KU
	 M8njB2uKsnPBiyJX0WK1y8SgutjnY2Qr5qwQ7qOxbzT1IvktvGn6cmRdvC6rWB9DwicZJ
	 +w0hxFYOVZcukS7askO4QmMOoGApd4y6TVyVMuslUgv3y3EOFLvg+/12rFC2go7l9bdJP
	 fhXpc0Ra4CROUT74E7dEdF7xN+WHb6gCHZubeQBvRwCXiCwejv6SP49mZcP6xGkHmng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=rmSZKYph;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE960A2614;
	Sat, 24 Oct 2026 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFE960A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=rmSZKYph
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jBZJR44sDzKmcK;
	Sat, 24 Oct 2026 11:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9uA8jllFwTMruE/1nsLXKX9TPpVlW6LoicOK8rphvw=;
	b=rmSZKYphTJgU+2DK+H14huCuLKckcCYHxs+nFJgJX0514cBUgJT33EWLyKQ/2ZaElv8new
	UoAJMgtJu+1gQqV0TC9CMvxhnLmxvthzH4j7quVZN54WYoKZyCUMNpjvPiwg6StB/g7yYI
	fRpx/WQ5dzt5ESCwlDgUyAz47W7yVRwcSydONl9OQDiD/+uP1esq72YpSnXSSjvzXxkBuv
	XJkN+YPsBW8npq1dKziFbPnX1BGtoEeYXXJNhosNY8kIl62v7wHrp/LHRRYIANuLQR2wS4
	xwStF0V9tSZFktCgYzfDDeYCRJx84hCkXtbdXfnRgl/WiL/liKDxTqe2vT8ByA==
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
Subject: [RFC net-next v2 15/18] net: ipxlat: add ICMP error and quoted-packet translation
Date: Sat, 24 Oct 2026 11:25:25 +0200
Message-ID: <20261024092532.172005-16-ralf@mandelbit.com>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBZJR44sDzKmcK

Map ICMP error types, codes, pointers and MTUs; translate quoted
inner headers and checksums; and rebuild RFC 4884 quote, padding and
extension layouts in both directions.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-13-ralf@mandelbit.com/
- Accept the minimum eight-byte ICMP quote without requiring a complete
  quoted TCP header, and update quoted TCP and UDP checksums only when
  enough bytes are present. (Sashiko)
- Preserve CSUM_MANGLED_0 if an incremental quoted-inner UDP checksum
  update produces zero. (Sashiko)
- Do not retain quoted-header pointers across operations which can
  reallocate packet storage.

 net/ipxlat/icmp_46.c | 490 ++++++++++++++++++++++++++++++++++++++++-
 net/ipxlat/icmp_64.c | 513 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 993 insertions(+), 10 deletions(-)

diff --git a/net/ipxlat/icmp_46.c b/net/ipxlat/icmp_46.c
index bb3952256162..793d8151a859 100644
--- a/net/ipxlat/icmp_46.c
+++ b/net/ipxlat/icmp_46.c
@@ -13,10 +13,50 @@
 
 #include <net/ip6_checksum.h>
 
+#include "address.h"
 #include "icmp.h"
 #include "packet.h"
+#include "translate_46.h"
 #include "transport.h"
 
+#define IPXLAT_ICMP4_PP_CODE_PTR 0
+#define IPXLAT_ICMP4_PP_CODE_BADLEN 2
+
+/* RFC 7915 Section 4.2, Figure 3 */
+static const u8 ipxlat_46_icmp_param_prob_map[] = {
+	0, 1, 4, 4, 0xff, 0xff, 0xff, 0xff, 7, 6,
+	0xff, 0xff, 8, 8, 8, 8, 24, 24, 24, 24,
+};
+
+/* RFC 1191 plateau table used when ICMPv4 FRAG_NEEDED reports MTU=0 */
+static const u16 ipxlat_46_mtu_plateaus[] = {
+	65535, 32000, 17914, 8166, 4352, 2002, 1492,
+};
+
+static u8 ipxlat_icmp4_get_param_ptr(const struct icmphdr *ic4)
+{
+	return ntohl(ic4->un.gateway) >> 24;
+}
+
+static int ipxlat_46_icmp_map_param_prob(const struct icmphdr *in,
+					 struct icmp6hdr *out)
+{
+	u8 ptr;
+
+	if (unlikely(in->code != IPXLAT_ICMP4_PP_CODE_PTR &&
+		     in->code != IPXLAT_ICMP4_PP_CODE_BADLEN))
+		return -EPROTONOSUPPORT;
+
+	ptr = ipxlat_icmp4_get_param_ptr(in);
+	if (unlikely(ptr >= ARRAY_SIZE(ipxlat_46_icmp_param_prob_map) ||
+		     ipxlat_46_icmp_param_prob_map[ptr] == 0xff))
+		return -EPROTONOSUPPORT;
+
+	out->icmp6_code = ICMPV6_HDR_FIELD;
+	out->icmp6_pointer = cpu_to_be32(ipxlat_46_icmp_param_prob_map[ptr]);
+	return 0;
+}
+
 static int ipxlat_46_icmp_map_info_type_code(const struct icmphdr *in,
 					     struct icmp6hdr *out)
 {
@@ -38,18 +78,153 @@ static int ipxlat_46_icmp_map_info_type_code(const struct icmphdr *in,
 	return -EPROTONOSUPPORT;
 }
 
+static __be32 ipxlat_46_compute_icmp_mtu6(unsigned int pkt_mtu,
+					  u16 tot_len_field)
+{
+	unsigned int i;
+	u32 mtu6;
+
+	/* RFC 7915 Section 4.2:
+	 * If the IPv4 router set the MTU field to zero, then the translator
+	 * MUST use the plateau values specified in RFC 1191 to determine a
+	 * likely path MTU and include that path MTU in the ICMPv6 packet.
+	 */
+	if (unlikely(pkt_mtu == 0)) {
+		for (i = 0; i < ARRAY_SIZE(ipxlat_46_mtu_plateaus); i++) {
+			if (ipxlat_46_mtu_plateaus[i] < tot_len_field) {
+				pkt_mtu = ipxlat_46_mtu_plateaus[i];
+				break;
+			}
+		}
+	}
+
+	/* The engine has no authoritative next-hop routes for the quoted flow.
+	 * Preserve the reported path information, adjust for the larger IPv6
+	 * header and enforce the IPv6 minimum MTU. The output path handles its
+	 * own route PMTU after translation.
+	 */
+	mtu6 = pkt_mtu + sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	if (mtu6 < IPV6_MIN_MTU)
+		mtu6 = IPV6_MIN_MTU;
+
+	return cpu_to_be32(mtu6);
+}
+
+static int ipxlat_46_build_icmp_dest_unreach(const struct icmphdr *in,
+					     struct icmp6hdr *out,
+					     const struct iphdr *inner4,
+					     bool *ie_forbidden)
+{
+	unsigned int inner4_tot_len, in_frag_mtu;
+
+	*ie_forbidden = false;
+	switch (in->code) {
+	case ICMP_NET_UNREACH:
+	case ICMP_HOST_UNREACH:
+	case ICMP_SR_FAILED:
+	case ICMP_NET_UNKNOWN:
+	case ICMP_HOST_UNKNOWN:
+	case ICMP_HOST_ISOLATED:
+	case ICMP_NET_UNR_TOS:
+	case ICMP_HOST_UNR_TOS:
+		out->icmp6_type = ICMPV6_DEST_UNREACH;
+		out->icmp6_code = ICMPV6_NOROUTE;
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_PORT_UNREACH:
+		out->icmp6_type = ICMPV6_DEST_UNREACH;
+		out->icmp6_code = ICMPV6_PORT_UNREACH;
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_NET_ANO:
+	case ICMP_HOST_ANO:
+	case ICMP_PKT_FILTERED:
+	case ICMP_PREC_CUTOFF:
+		out->icmp6_type = ICMPV6_DEST_UNREACH;
+		out->icmp6_code = ICMPV6_ADM_PROHIBITED;
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_PROT_UNREACH:
+		out->icmp6_type = ICMPV6_PARAMPROB;
+		out->icmp6_code = ICMPV6_UNK_NEXTHDR;
+		out->icmp6_pointer =
+			cpu_to_be32(offsetof(struct ipv6hdr, nexthdr));
+		*ie_forbidden = true;
+		return 0;
+	case ICMP_FRAG_NEEDED:
+		out->icmp6_type = ICMPV6_PKT_TOOBIG;
+		out->icmp6_code = 0;
+		in_frag_mtu = be16_to_cpu(in->un.frag.mtu);
+		inner4_tot_len = be16_to_cpu(inner4->tot_len);
+		out->icmp6_mtu =
+			ipxlat_46_compute_icmp_mtu6(in_frag_mtu,
+						    inner4_tot_len);
+		*ie_forbidden = true;
+		return 0;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+}
+
+static int ipxlat_46_icmp_map_error_type_code(const struct icmphdr *in,
+					      struct icmp6hdr *out,
+					      const struct iphdr *inner4,
+					      bool *ie_forbidden)
+{
+	int err;
+
+	*ie_forbidden = false;
+
+	switch (in->type) {
+	case ICMP_DEST_UNREACH:
+		return ipxlat_46_build_icmp_dest_unreach(in, out, inner4,
+							 ie_forbidden);
+	case ICMP_TIME_EXCEEDED:
+		out->icmp6_type = ICMPV6_TIME_EXCEED;
+		out->icmp6_code = in->code;
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_PARAMETERPROB:
+		out->icmp6_type = ICMPV6_PARAMPROB;
+		*ie_forbidden = true;
+		err = ipxlat_46_icmp_map_param_prob(in, out);
+		if (unlikely(err))
+			return err;
+		return 0;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
 int ipxlat_46_icmp_preflight(struct sk_buff *skb)
 {
 	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
 	const struct icmphdr *icmp4;
 	struct icmp6hdr mapped = {};
+	struct icmphdr inner_icmp4;
+	struct iphdr inner4;
+	bool ie_forbidden;
 	int err;
 
-	if (cb->is_icmp_err)
+	icmp4 = (const struct icmphdr *)(skb->data + cb->l4_off);
+	if (!cb->is_icmp_err) {
+		err = ipxlat_46_icmp_map_info_type_code(icmp4, &mapped);
+		return err ? -EOPNOTSUPP : 0;
+	}
+
+	/* quoted headers are not guaranteed to be naturally aligned */
+	memcpy(&inner4, skb->data + cb->inner_l3_offset, sizeof(inner4));
+	err = ipxlat_46_icmp_map_error_type_code(icmp4, &mapped, &inner4,
+						 &ie_forbidden);
+	if (err)
 		return -EOPNOTSUPP;
 
-	icmp4 = (const struct icmphdr *)(skb->data + cb->l4_off);
-	err = ipxlat_46_icmp_map_info_type_code(icmp4, &mapped);
+	if (!ipxlat_is_first_frag4(&inner4) || inner4.protocol != IPPROTO_ICMP)
+		return 0;
+
+	memcpy(&inner_icmp4, skb->data + cb->inner_l4_offset,
+	       sizeof(inner_icmp4));
+	err = ipxlat_46_icmp_map_info_type_code(&inner_icmp4, &mapped);
 	return err ? -EOPNOTSUPP : 0;
 }
 
@@ -97,10 +272,317 @@ static int ipxlat_46_icmp_info_outer(struct sk_buff *skb)
 	return 0;
 }
 
+struct ipxlat_46_quote {
+	struct iphdr ip4;
+	unsigned int l3_off;
+	unsigned int l4_off;
+	unsigned int l4_len;
+	unsigned int end;
+	bool is_frag;
+};
+
+static int ipxlat_46_icmp_inner_l3(const struct ipxlat_config *cfg,
+				   struct sk_buff *skb,
+				   struct ipxlat_46_quote *quote,
+				   int *inner_delta)
+{
+	unsigned int inner_l3_payload, inner_l3_len, inner_tot_len;
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	unsigned int input_quote_end, input_quote_len;
+	unsigned int old_l4_off, new_l4_off;
+	struct ipv6hdr outer_ip6_copy;
+	struct ipv6hdr *inner_ip6;
+	int adjusted_quote_end;
+	struct frag_hdr *fh6;
+	u8 next_hdr;
+
+	/* inner header alignment is not guaranteed */
+	quote->l3_off = cb->inner_l3_offset;
+	memcpy(&quote->ip4, skb->data + quote->l3_off, sizeof(quote->ip4));
+	inner_l3_len = quote->ip4.ihl << 2;
+	quote->is_frag = ip_is_fragment(&quote->ip4);
+	input_quote_len = icmp_hdr(skb)->un.reserved[1] << 2;
+	input_quote_end = input_quote_len ? cb->payload_off + input_quote_len :
+					    skb->len;
+
+	/* save outer IPv6 hdr because pull+push destroys that hdr region */
+	outer_ip6_copy = *ipv6_hdr(skb);
+
+	old_l4_off = quote->l3_off + inner_l3_len;
+	new_l4_off = quote->l3_off + sizeof(struct ipv6hdr) +
+		     (quote->is_frag ? sizeof(struct frag_hdr) : 0);
+	*inner_delta = (int)new_l4_off - (int)old_l4_off;
+	adjusted_quote_end = (int)input_quote_end + *inner_delta;
+	quote->end = adjusted_quote_end;
+
+	if (unlikely(skb_cow_head(skb, max_t(int, 0, *inner_delta))))
+		return -ENOMEM;
+
+	ipxlat_replace_l3(skb, old_l4_off, new_l4_off,
+			  skb_transport_offset(skb));
+
+	*ipv6_hdr(skb) = outer_ip6_copy;
+	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+
+	inner_ip6 = (struct ipv6hdr *)(skb->data + quote->l3_off);
+	/* Use quoted IPv4 total-length, not skb->len: skb->len also includes
+	 * ICMP extension bytes at the end, which are not part of the quoted
+	 * inner IP datagram length.
+	 */
+	inner_tot_len = ntohs(quote->ip4.tot_len);
+	quote->l4_len = inner_tot_len - inner_l3_len;
+	quote->l4_off = new_l4_off;
+	quote->end = min(quote->end, quote->l4_off + quote->l4_len);
+	inner_l3_payload = inner_tot_len - inner_l3_len +
+			   (quote->is_frag ? sizeof(struct frag_hdr) : 0);
+	if (quote->is_frag)
+		next_hdr = NEXTHDR_FRAGMENT;
+	else
+		next_hdr = ipxlat_46_map_proto_to_nexthdr(quote->ip4.protocol);
+
+	ipxlat_46_build_l3_hdr(inner_ip6, &quote->ip4, inner_l3_payload,
+			       next_hdr, quote->ip4.ttl);
+
+	ipxlat_46_convert_endpoints(cfg, &quote->ip4, &inner_ip6->saddr,
+				    &inner_ip6->daddr);
+
+	if (quote->is_frag) {
+		fh6 = (struct frag_hdr *)(inner_ip6 + 1);
+		ipxlat_46_build_frag_hdr(fh6, &quote->ip4, quote->ip4.protocol);
+	}
+
+	return 0;
+}
+
+static int ipxlat_46_icmp_inner_l4(struct sk_buff *skb,
+				   const struct ipxlat_46_quote *quote)
+{
+	struct icmp6hdr *inner_icmp6;
+	struct icmphdr inner_icmp4;
+	struct ipv6hdr *inner_ip6;
+	unsigned int write_end;
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+	int err;
+
+	if (unlikely(!ipxlat_is_first_frag4(&quote->ip4)))
+		return 0;
+
+	inner_ip6 = (struct ipv6hdr *)(skb->data + quote->l3_off);
+	switch (quote->ip4.protocol) {
+	case IPPROTO_TCP:
+		/* Only the pseudo-header addresses change. If the quote reaches
+		 * the checksum field, the rest of the TCP message is not needed
+		 * for an incremental update.
+		 */
+		write_end = quote->l4_off + offsetof(struct tcphdr, check) +
+			    sizeof(tcp->check);
+		if (write_end > quote->end)
+			return 0;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner_ip6 = (struct ipv6hdr *)(skb->data + quote->l3_off);
+		tcp = (struct tcphdr *)(skb->data + quote->l4_off);
+		tcp->check = ipxlat_46_update_l4_csum(tcp->check, &quote->ip4,
+						      inner_ip6);
+		return 0;
+	case IPPROTO_UDP:
+		write_end = quote->l4_off + sizeof(*udp);
+		if (unlikely(write_end > quote->end))
+			return -EINVAL;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner_ip6 = (struct ipv6hdr *)(skb->data + quote->l3_off);
+		udp = (struct udphdr *)(skb->data + quote->l4_off);
+		if (!udp->check)
+			return 0;
+		udp->check = ipxlat_46_update_l4_csum(udp->check, &quote->ip4,
+						      inner_ip6);
+		if (!udp->check)
+			udp->check = CSUM_MANGLED_0;
+		return 0;
+	case IPPROTO_ICMP:
+		write_end = quote->l4_off + sizeof(inner_icmp4);
+		if (unlikely(write_end > quote->end))
+			return -EINVAL;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner_ip6 = (struct ipv6hdr *)(skb->data + quote->l3_off);
+		/* inner header alignment is not guaranteed */
+		memcpy(&inner_icmp4, skb->data + quote->l4_off,
+		       sizeof(inner_icmp4));
+		inner_icmp6 = (struct icmp6hdr *)(skb->data + quote->l4_off);
+		err = ipxlat_46_icmp_map_info_type_code(&inner_icmp4,
+							inner_icmp6);
+		if (unlikely(err))
+			return -EINVAL;
+		if (quote->is_frag) {
+			/* a first fragment contains enough bytes to map the
+			 * ICMP header, but not enough to rebuild its checksum
+			 * over the full datagram
+			 */
+			return 0;
+		}
+		ipxlat_46_icmp_info_update_csum(&inner_icmp4, inner_icmp6,
+						inner_ip6, quote->l4_len);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+/* Adjust ICMP error quoted-datagram/extensions after inner 4->6 translation.
+ * The inner rewrite changes quoted datagram length; this helper recomputes
+ * RFC 4884 delimiter/padding, preserves extensions only when allowed, and
+ * enforces IPv6 minimum-MTU packet size constraints.
+ */
+static int ipxlat_46_icmp_squeeze_ext(struct sk_buff *skb,
+				      unsigned int icmp4_ipl, int inner_delta,
+				      bool ie_forbidden)
+{
+	unsigned int max_ext_len, output_quote_units = 0;
+	unsigned int packet_len_cap, payload_len;
+	struct ipxlat_icmp_layout layout = {};
+	int input_quote_len, err;
+	struct icmp6hdr *ic6;
+	struct ipv6hdr *iph6;
+
+	/* icmp4_ipl marks where quoted dgram ends and extension area starts */
+	if (likely(!icmp4_ipl))
+		goto no_extensions;
+
+	layout.outer_len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	payload_len = skb->len - layout.outer_len;
+	input_quote_len = icmp4_ipl + inner_delta;
+	if (unlikely(input_quote_len < 0 || input_quote_len > payload_len))
+		return -EINVAL;
+	layout.input_quote_len = input_quote_len;
+
+	if (likely(layout.input_quote_len == payload_len))
+		goto no_extensions;
+
+	layout.input_ext_len = payload_len - layout.input_quote_len;
+	max_ext_len = IPV6_MIN_MTU -
+		      (layout.outer_len + ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (unlikely(ie_forbidden || layout.input_ext_len > max_ext_len)) {
+		packet_len_cap = min_t(unsigned int,
+				       skb->len - layout.input_ext_len,
+				       IPV6_MIN_MTU);
+		layout.output_quote_len = packet_len_cap - layout.outer_len;
+	} else {
+		packet_len_cap = min_t(unsigned int, skb->len, IPV6_MIN_MTU);
+		layout.output_quote_len =
+			round_down(packet_len_cap - layout.input_ext_len -
+				   layout.outer_len,
+				   sizeof(u64));
+		layout.output_pad_len =
+			max_t(unsigned int, ICMP_EXT_ORIG_DGRAM_MIN_LEN,
+			      layout.output_quote_len) -
+			layout.output_quote_len;
+		layout.output_ext_len = layout.input_ext_len;
+		output_quote_units = (layout.output_quote_len +
+				      layout.output_pad_len) >> 3;
+	}
+
+	/* if no ext bytes are copied and no pad is written, relayout only
+	 * trims/updates lengths and does not require full data writability
+	 */
+	if (unlikely(layout.output_ext_len || layout.output_pad_len)) {
+		err = skb_ensure_writable(skb, skb->len);
+		if (unlikely(err))
+			return err;
+	}
+
+	err = ipxlat_icmp_relayout(skb, &layout);
+	if (unlikely(err))
+		return err;
+
+	iph6 = ipv6_hdr(skb);
+	iph6->payload_len = htons(skb->len - sizeof(*iph6));
+
+no_extensions:
+	if (unlikely(skb->len > IPV6_MIN_MTU)) {
+		err = pskb_trim(skb, IPV6_MIN_MTU);
+		if (unlikely(err))
+			return err;
+
+		iph6 = ipv6_hdr(skb);
+		iph6->payload_len = htons(skb->len - sizeof(*iph6));
+	}
+
+	ic6 = icmp6_hdr(skb);
+	ic6->icmp6_datagram_len = output_quote_units;
+	return 0;
+}
+
+/**
+ * ipxlat_46_icmp_error - translate ICMPv4 error payload to ICMPv6 error form
+ * @cfg: immutable route translation configuration
+ * @skb: packet carrying outer ICMPv4 error
+ *
+ * Rewrites the quoted inner datagram in place, maps type/code/fields and
+ * adjusts RFC 4884 datagram/extension layout before recomputing outer checksum.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+static int ipxlat_46_icmp_error(const struct ipxlat_config *cfg,
+				struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmphdr icmp4 = *icmp_hdr(skb);
+	struct ipxlat_46_quote quote;
+	unsigned int l4_len, l4_off;
+	struct icmp6hdr *icmp6;
+	struct ipv6hdr *iph6;
+	int inner_delta, err;
+	bool ie_forbidden;
+
+	if (unlikely(!cb->is_icmp_err)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* rewrite the quoted IP hdr, then repair transport data when present */
+	err = ipxlat_46_icmp_inner_l3(cfg, skb, &quote, &inner_delta);
+	if (unlikely(err))
+		return err;
+	err = ipxlat_46_icmp_inner_l4(skb, &quote);
+	if (unlikely(err))
+		return err;
+
+	err = ipxlat_46_icmp_map_error_type_code(&icmp4, icmp6_hdr(skb),
+						 &quote.ip4, &ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	err = ipxlat_46_icmp_squeeze_ext(skb, icmp4.un.reserved[1] << 2,
+					 inner_delta, ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	/* error path rewrites quoted packet bytes/lengths, so use full
+	 * checksum recomputation instead of incremental update
+	 */
+	iph6 = ipv6_hdr(skb);
+	icmp6 = icmp6_hdr(skb);
+	l4_off = skb_transport_offset(skb);
+	l4_len = ipxlat_skb_l4_len(skb);
+	icmp6->icmp6_cksum = 0;
+	icmp6->icmp6_cksum = ipxlat_l4_csum_ipv6(&iph6->saddr, &iph6->daddr,
+						 skb, l4_off, l4_len,
+						IPPROTO_ICMPV6);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
 int ipxlat_46_icmp(const struct ipxlat_config *cfg, struct sk_buff *skb)
 {
 	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
-		return -EINVAL;
+		return ipxlat_46_icmp_error(cfg, skb);
 
 	return ipxlat_46_icmp_info_outer(skb);
 }
diff --git a/net/ipxlat/icmp_64.c b/net/ipxlat/icmp_64.c
index ce3131ffc6be..db3a2c784e61 100644
--- a/net/ipxlat/icmp_64.c
+++ b/net/ipxlat/icmp_64.c
@@ -12,11 +12,39 @@
  */
 
 #include <net/ip6_checksum.h>
+#include <net/route.h>
 
+#include "address.h"
 #include "icmp.h"
 #include "packet.h"
+#include "translate_64.h"
 #include "transport.h"
 
+#define IPXLAT_ICMP4_ERROR_MAX_LEN 576U
+
+/* RFC 7915 Section 5.2, Figure 4 */
+static const u8 ipxlat_64_icmp_param_prob_map[] = {
+	0, 1, 0xff, 0xff, 2, 2, 9, 8, 12, 12,
+	12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
+	12, 12, 12, 12, 16, 16, 16, 16, 16, 16,
+	16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
+};
+
+static int ipxlat_64_icmp_map_param_prob(u32 ptr6, u32 *ptr4)
+{
+	if (unlikely(ptr6 >= ARRAY_SIZE(ipxlat_64_icmp_param_prob_map) ||
+		     ipxlat_64_icmp_param_prob_map[ptr6] == 0xff))
+		return -EPROTONOSUPPORT;
+
+	*ptr4 = ipxlat_64_icmp_param_prob_map[ptr6];
+	return 0;
+}
+
+static void ipxlat_icmp4_set_param_ptr(struct icmphdr *ic4, u8 ptr)
+{
+	ic4->un.gateway = htonl((u32)ptr << 24);
+}
+
 static int ipxlat_64_icmp_map_info_type_code(const struct icmp6hdr *in,
 					     struct icmphdr *out)
 {
@@ -38,6 +66,81 @@ static int ipxlat_64_icmp_map_info_type_code(const struct icmp6hdr *in,
 	}
 }
 
+static int ipxlat_64_icmp_map_error_type_code(const struct icmp6hdr *ic6,
+					      struct icmphdr *ic4,
+					      bool *ie_forbidden)
+{
+	const u32 header_delta = sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	u32 mtu4, mtu6, ptr6, ptr4;
+	int err;
+
+	*ie_forbidden = false;
+
+	switch (ic6->icmp6_type) {
+	case ICMPV6_DEST_UNREACH:
+		ic4->type = ICMP_DEST_UNREACH;
+		switch (ic6->icmp6_code) {
+		case ICMPV6_NOROUTE:
+		case ICMPV6_NOT_NEIGHBOUR:
+		case ICMPV6_ADDR_UNREACH:
+			ic4->code = ICMP_HOST_UNREACH;
+			break;
+		case ICMPV6_ADM_PROHIBITED:
+			ic4->code = ICMP_HOST_ANO;
+			break;
+		case ICMPV6_PORT_UNREACH:
+			ic4->code = ICMP_PORT_UNREACH;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ic4->un.gateway = 0;
+		return 0;
+	case ICMPV6_TIME_EXCEED:
+		ic4->type = ICMP_TIME_EXCEEDED;
+		ic4->code = ic6->icmp6_code;
+		ic4->un.gateway = 0;
+		return 0;
+	case ICMPV6_PKT_TOOBIG:
+		ic4->type = ICMP_DEST_UNREACH;
+		ic4->code = ICMP_FRAG_NEEDED;
+		ic4->un.frag.__unused = 0;
+		/* The engine has no authoritative next-hop routes for the
+		 * quoted flow so we preserve the received path information and
+		 * adjust it for the smaller IPv4 header. The output path
+		 * handles its own route PMTU.
+		 */
+		mtu6 = be32_to_cpu(ic6->icmp6_mtu);
+		mtu4 = mtu6 > header_delta ? mtu6 - header_delta : 0;
+		ic4->un.frag.mtu = cpu_to_be16(min_t(u32, mtu4, IP_MAX_MTU));
+		*ie_forbidden = true;
+		return 0;
+	case ICMPV6_PARAMPROB:
+		ptr6 = be32_to_cpu(ic6->icmp6_dataun.un_data32[0]);
+		switch (ic6->icmp6_code) {
+		case ICMPV6_HDR_FIELD:
+			ic4->type = ICMP_PARAMETERPROB;
+			ic4->code = 0;
+			err = ipxlat_64_icmp_map_param_prob(ptr6, &ptr4);
+			if (unlikely(err))
+				return err;
+			ipxlat_icmp4_set_param_ptr(ic4, ptr4);
+			break;
+		case ICMPV6_UNK_NEXTHDR:
+			ic4->type = ICMP_DEST_UNREACH;
+			ic4->code = ICMP_PROT_UNREACH;
+			ic4->un.gateway = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		*ie_forbidden = true;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static __sum16 ipxlat_64_compute_icmp_info_csum(const struct ipv6hdr *in6,
 						const struct icmp6hdr *in_icmp6,
 						const struct icmphdr *out_icmp4,
@@ -91,24 +194,422 @@ static int ipxlat_64_icmp_info_outer(struct sk_buff *skb,
 int ipxlat_64_icmp_preflight(const struct ipxlat_config *cfg,
 			     struct sk_buff *skb)
 {
-	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
-	const struct icmp6hdr *icmp6;
+	unsigned int inner_datagram_len, inner_l3_len, inner_payload_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmp6hdr *icmp6 =
+		(const struct icmp6hdr *)(skb->data + cb->l4_off);
+	struct frag_hdr inner_fragh;
+	struct icmp6hdr inner_icmp6;
 	struct icmphdr mapped = {};
+	struct ipv6hdr inner6;
+	bool ie_forbidden;
 	int err;
 
-	if (cb->is_icmp_err)
+	if (!cb->is_icmp_err) {
+		err = ipxlat_64_icmp_map_info_type_code(icmp6, &mapped);
+		return err ? -EOPNOTSUPP : 0;
+	}
+
+	err = ipxlat_64_icmp_map_error_type_code(icmp6, &mapped, &ie_forbidden);
+	if (err)
+		return -EOPNOTSUPP;
+
+	/* quoted headers are not guaranteed to be naturally aligned */
+	memcpy(&inner6, skb->data + cb->inner_l3_offset, sizeof(inner6));
+	inner_l3_len = cb->inner_l4_offset - cb->inner_l3_offset;
+	inner_payload_len = ntohs(inner6.payload_len);
+	inner_datagram_len = sizeof(inner6) + inner_payload_len;
+	if (unlikely(inner_l3_len > inner_datagram_len))
+		return -EINVAL;
+
+	if (inner_datagram_len - inner_l3_len + sizeof(struct iphdr) >
+	    IP_MAX_MTU)
+		return -EOPNOTSUPP;
+
+	err = ipxlat_64_convert_endpoints(cfg, &inner6, false,
+					  &cb->inner_saddr4, &cb->inner_daddr4);
+	if (err)
 		return -EOPNOTSUPP;
 
-	icmp6 = (const struct icmp6hdr *)(skb->data + cb->l4_off);
-	err = ipxlat_64_icmp_map_info_type_code(icmp6, &mapped);
+	if (cb->inner_l4_proto != NEXTHDR_ICMP)
+		return 0;
+
+	if (cb->inner_fragh_off) {
+		memcpy(&inner_fragh, skb->data + cb->inner_fragh_off,
+		       sizeof(inner_fragh));
+		if (!ipxlat_is_first_frag6(&inner_fragh))
+			return 0;
+	}
+
+	memcpy(&inner_icmp6, skb->data + cb->inner_l4_offset,
+	       sizeof(inner_icmp6));
+	err = ipxlat_64_icmp_map_info_type_code(&inner_icmp6, &mapped);
 	return err ? -EOPNOTSUPP : 0;
 }
 
+struct ipxlat_64_quote {
+	struct ipv6hdr ip6;
+	struct frag_hdr frag6;
+	unsigned int l3_off;
+	unsigned int l4_off;
+	unsigned int l4_len;
+	unsigned int end;
+	u16 frag_offset;
+	bool has_frag_hdr;
+	bool more_fragments;
+	bool has_l4;
+	bool l4_len_known;
+};
+
+static void ipxlat_64_icmp_inner_frag(const struct sk_buff *skb,
+				      const struct ipxlat_cb *cb,
+				      struct ipxlat_64_quote *quote)
+{
+	quote->has_frag_hdr = !!cb->inner_fragh_off;
+	quote->more_fragments = false;
+	quote->frag_offset = 0;
+	quote->has_l4 = true;
+	quote->l4_len_known = true;
+	if (!quote->has_frag_hdr)
+		return;
+
+	memcpy(&quote->frag6, skb->data + cb->inner_fragh_off,
+	       sizeof(quote->frag6));
+	quote->frag_offset = ipxlat_get_frag6_offset(&quote->frag6);
+	quote->more_fragments = !!(be16_to_cpu(quote->frag6.frag_off) & IP6_MF);
+	/* An atomic fragment has offset zero and M clear, so its L4 header and
+	 * complete length are available. A first real fragment exposes L4 but
+	 * not the complete length; later fragments expose neither.
+	 */
+	quote->has_l4 = !quote->frag_offset;
+	quote->l4_len_known = quote->has_l4 && !quote->more_fragments;
+}
+
+static int ipxlat_64_icmp_inner_l3(struct net *net, struct sk_buff *skb,
+				   struct ipxlat_64_quote *quote,
+				   int *inner_delta)
+{
+	unsigned int inner_datagram_len, inner_l3_len, inner_tot_len;
+	unsigned int inner_payload_len, input_quote_end, input_quote_len;
+	unsigned int new_l4_off, old_l4_off;
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr outer4_copy = *ip_hdr(skb);
+	struct iphdr *inner4;
+	u8 inner_l4_proto;
+	__be16 frag_off4;
+	bool df;
+	int adjusted_quote_end;
+
+	quote->l3_off = cb->inner_l3_offset;
+	old_l4_off = cb->inner_l4_offset;
+	inner_l3_len = old_l4_off - quote->l3_off;
+
+	inner_l4_proto = ipxlat_64_map_nexthdr_proto(cb->inner_l4_proto);
+
+	/* inner header alignment is not guaranteed */
+	memcpy(&quote->ip6, skb->data + quote->l3_off, sizeof(quote->ip6));
+	input_quote_len = icmp6_hdr(skb)->icmp6_datagram_len << 3;
+	input_quote_end = input_quote_len ? cb->payload_off + input_quote_len :
+					   skb->len;
+
+	/* the quoted IPv6 length is the full datagram length, not the number
+	 * of bytes present in this ICMP quote
+	 */
+	inner_payload_len = ntohs(quote->ip6.payload_len);
+	inner_datagram_len = sizeof(quote->ip6) + inner_payload_len;
+	if (unlikely(inner_l3_len > inner_datagram_len))
+		return -EINVAL;
+	inner_tot_len = inner_datagram_len - inner_l3_len +
+			sizeof(struct iphdr);
+	if (unlikely(inner_tot_len > IP_MAX_MTU))
+		return -EMSGSIZE;
+	quote->l4_len = inner_tot_len - sizeof(struct iphdr);
+	ipxlat_64_icmp_inner_frag(skb, cb, quote);
+
+	new_l4_off = quote->l3_off + sizeof(struct iphdr);
+	*inner_delta = (int)new_l4_off - (int)old_l4_off;
+	adjusted_quote_end = (int)input_quote_end + *inner_delta;
+	quote->end = adjusted_quote_end;
+	quote->end = min(quote->end, quote->l3_off + inner_tot_len);
+	quote->l4_off = new_l4_off;
+
+	/* unlike 46, inner 6->4 always shrinks quoted L3 size */
+	ipxlat_replace_l3(skb, old_l4_off, new_l4_off,
+			  skb_transport_offset(skb));
+
+	*ip_hdr(skb) = outer4_copy;
+
+	inner4 = (struct iphdr *)(skb->data + quote->l3_off);
+	/* RFC 7915 Section 5.1 */
+	if (likely(!quote->has_frag_hdr)) {
+		df = ipxlat_64_should_set_df(inner_tot_len);
+		frag_off4 = ipxlat_64_encode_frag_off(df, false, 0);
+	} else {
+		frag_off4 = ipxlat_64_encode_frag_off(false,
+						      quote->more_fragments,
+						      quote->frag_offset);
+	}
+
+	ipxlat_64_build_l3_hdr(net, inner4, &quote->ip6, inner_tot_len,
+			       frag_off4, inner_l4_proto, cb->inner_saddr4,
+			       cb->inner_daddr4, quote->ip6.hop_limit,
+			       quote->has_frag_hdr ? &quote->frag6 : NULL);
+
+	return 0;
+}
+
+static int ipxlat_64_icmp_inner_l4(struct sk_buff *skb,
+				   const struct ipxlat_64_quote *quote)
+{
+	struct icmp6hdr inner_icmp6;
+	struct icmphdr *inner_icmp4;
+	unsigned int write_end;
+	struct iphdr *inner4;
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+	int err;
+
+	if (unlikely(!quote->has_l4))
+		return 0;
+
+	inner4 = (struct iphdr *)(skb->data + quote->l3_off);
+	switch (inner4->protocol) {
+	case IPPROTO_TCP:
+		/* Only the pseudo-header addresses change. If the quote reaches
+		 * the checksum field, the rest of the TCP message is not needed
+		 * for an incremental update.
+		 */
+		write_end = quote->l4_off + offsetof(struct tcphdr, check) +
+			    sizeof(tcp->check);
+		if (write_end > quote->end)
+			return 0;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner4 = (struct iphdr *)(skb->data + quote->l3_off);
+		tcp = (struct tcphdr *)(skb->data + quote->l4_off);
+		tcp->check = ipxlat_64_update_l4_csum(tcp->check, &quote->ip6,
+						      inner4);
+		return 0;
+	case IPPROTO_UDP:
+		write_end = quote->l4_off + sizeof(*udp);
+		if (unlikely(write_end > quote->end))
+			return -EINVAL;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner4 = (struct iphdr *)(skb->data + quote->l3_off);
+		udp = (struct udphdr *)(skb->data + quote->l4_off);
+		if (!udp->check)
+			return 0;
+		udp->check = ipxlat_64_update_l4_csum(udp->check, &quote->ip6,
+						      inner4);
+		if (!udp->check)
+			udp->check = CSUM_MANGLED_0;
+		return 0;
+	case IPPROTO_ICMP:
+		write_end = quote->l4_off + sizeof(inner_icmp6);
+		if (unlikely(write_end > quote->end))
+			return -EINVAL;
+		if (unlikely(skb_ensure_writable(skb, write_end)))
+			return -ENOMEM;
+
+		inner4 = (struct iphdr *)(skb->data + quote->l3_off);
+		/* inner header alignment is not guaranteed */
+		memcpy(&inner_icmp6, skb->data + quote->l4_off,
+		       sizeof(inner_icmp6));
+		inner_icmp4 = (struct icmphdr *)(skb->data + quote->l4_off);
+		err = ipxlat_64_icmp_map_info_type_code(&inner_icmp6,
+							inner_icmp4);
+		if (unlikely(err))
+			return err;
+		if (!quote->l4_len_known) {
+			/* a first fragment contains enough bytes to map the
+			 * ICMP header, but not enough to rebuild its checksum
+			 * over the full datagram
+			 */
+			return 0;
+		}
+		inner_icmp4->checksum =
+			ipxlat_64_compute_icmp_info_csum(&quote->ip6,
+							 &inner_icmp6,
+							 inner_icmp4,
+							 quote->l4_len);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+/* Rebuild ICMPv4 quoted-datagram/extensions after inner 6->4 translation.
+ *
+ * The inner rewrite changes the quoted datagram length. This helper updates
+ * the RFC 4884 delimiter/padding and extension bytes, then enforces the IPv4
+ * ICMP error size cap.
+ *
+ * This is intentionally not a mirror of ipxlat_46_icmp_squeeze_ext:
+ * - 4->6 always writes icmp6_datagram_len (either computed or 0).
+ * - 6->4 updates ICMPv4 datagram-length only when extensions are allowed.
+ *   Some mapped ICMPv6 errors set ie_forbidden, and in that case we keep the
+ *   ICMPv4 header semantics for that type/code and only relayout/trim payload.
+ */
+static int ipxlat_64_icmp_squeeze_ext(struct sk_buff *skb,
+				      unsigned int icmp6_ipl, int inner_delta,
+				      bool ie_forbidden)
+{
+	struct ipxlat_icmp_layout layout = {};
+	unsigned int max_ext_len, output_quote_units = 0;
+	unsigned int packet_len_cap, payload_len;
+	unsigned int new_tot_len;
+	int input_quote_len, err;
+	struct icmphdr *ic4;
+	struct iphdr *iph4;
+
+	if (likely(!icmp6_ipl))
+		goto finalize;
+
+	layout.outer_len = skb_transport_offset(skb) + sizeof(struct icmphdr);
+	if (unlikely(skb->len < layout.outer_len))
+		return -EINVAL;
+
+	payload_len = skb->len - layout.outer_len;
+	input_quote_len = (int)icmp6_ipl + inner_delta;
+	if (unlikely(input_quote_len < 0))
+		return -EINVAL;
+	layout.input_quote_len = input_quote_len;
+	if (unlikely(layout.input_quote_len > payload_len))
+		return -EINVAL;
+
+	if (likely(layout.input_quote_len == payload_len))
+		goto finalize;
+
+	layout.input_ext_len = payload_len - layout.input_quote_len;
+	max_ext_len = IPXLAT_ICMP4_ERROR_MAX_LEN -
+		      (layout.outer_len + ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (unlikely(ie_forbidden)) {
+		layout.output_quote_len = layout.input_quote_len;
+	} else if (unlikely(layout.input_ext_len > max_ext_len)) {
+		packet_len_cap = min_t(unsigned int,
+				       skb->len - layout.input_ext_len,
+				       IPXLAT_ICMP4_ERROR_MAX_LEN);
+		layout.output_quote_len = packet_len_cap - layout.outer_len;
+	} else {
+		packet_len_cap = min_t(unsigned int, skb->len,
+				       IPXLAT_ICMP4_ERROR_MAX_LEN);
+		layout.output_quote_len =
+			round_down(packet_len_cap - layout.input_ext_len -
+				   layout.outer_len,
+				   sizeof(u32));
+		layout.output_pad_len =
+			max_t(unsigned int, ICMP_EXT_ORIG_DGRAM_MIN_LEN,
+			      layout.output_quote_len) -
+			layout.output_quote_len;
+		layout.output_ext_len = layout.input_ext_len;
+		/* RFC 4884 field is in 32-bit units for ICMPv4 errors */
+		output_quote_units = (layout.output_quote_len +
+				      layout.output_pad_len) >> 2;
+	}
+
+	/* if no extension bytes are copied and no pad is written, relayout
+	 * only trims/updates lengths and doesn't require full data writability
+	 */
+	if (unlikely(layout.output_ext_len || layout.output_pad_len)) {
+		err = skb_ensure_writable(skb, skb->len);
+		if (unlikely(err))
+			return err;
+	}
+
+	err = ipxlat_icmp_relayout(skb, &layout);
+	if (unlikely(err))
+		return err;
+
+finalize:
+	if (!ie_forbidden) {
+		ic4 = icmp_hdr(skb);
+		ic4->un.reserved[1] = output_quote_units;
+	}
+
+	if (unlikely(skb->len > IPXLAT_ICMP4_ERROR_MAX_LEN)) {
+		err = pskb_trim(skb, IPXLAT_ICMP4_ERROR_MAX_LEN);
+		if (unlikely(err))
+			return err;
+	}
+
+	iph4 = ip_hdr(skb);
+	new_tot_len = skb->len;
+	if (unlikely(be16_to_cpu(iph4->tot_len) != new_tot_len)) {
+		iph4->tot_len = cpu_to_be16(new_tot_len);
+		/* relayout/trim may invalidate precomputed DF decision */
+		iph4->frag_off &= cpu_to_be16(~IP_DF);
+		iph4->check = 0;
+		iph4->check = ip_fast_csum(iph4, iph4->ihl);
+	}
+
+	return 0;
+}
+
+/**
+ * ipxlat_64_icmp_error - translate ICMPv6 error payload to ICMPv4 error form
+ * @net: namespace owning translated IPv4 fragment-ID state
+ * @skb: packet carrying outer ICMPv6 error
+ *
+ * Rewrites the quoted inner datagram in place, maps type/code/fields and
+ * adjusts RFC 4884 datagram/extension layout before recomputing outer checksum.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+static int ipxlat_64_icmp_error(struct net *net, struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmp6hdr ic6 = *icmp6_hdr(skb);
+	unsigned int icmp6_ipl, l4_len, l4_off;
+	struct ipxlat_64_quote quote;
+	int inner_delta, err;
+	struct icmphdr *ic4;
+	bool ie_forbidden;
+
+	if (unlikely(!cb->is_icmp_err)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* rewrite the quoted IP hdr, then repair transport data when present */
+	err = ipxlat_64_icmp_inner_l3(net, skb, &quote, &inner_delta);
+	if (unlikely(err))
+		return err;
+	err = ipxlat_64_icmp_inner_l4(skb, &quote);
+	if (unlikely(err))
+		return err;
+
+	/* build outer ICMPv4 error header after inner relayout */
+	ic4 = icmp_hdr(skb);
+	err = ipxlat_64_icmp_map_error_type_code(&ic6, ic4, &ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	icmp6_ipl = ic6.icmp6_datagram_len << 3;
+	err = ipxlat_64_icmp_squeeze_ext(skb, icmp6_ipl, inner_delta,
+					 ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	/* relayout may reallocate the skb, so reload the header pointer */
+	ic4 = icmp_hdr(skb);
+	/* recompute whole ICMPv4 checksum after error-path relayout */
+	l4_off = skb_transport_offset(skb);
+	l4_len = ipxlat_skb_l4_len(skb);
+	ic4->checksum = 0;
+	ic4->checksum = csum_fold(skb_checksum(skb, l4_off, l4_len, 0));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
 int ipxlat_64_icmp(struct net *net, struct sk_buff *skb,
 		   const struct ipv6hdr *in6)
 {
 	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
-		return -EINVAL;
+		return ipxlat_64_icmp_error(net, skb);
 
 	return ipxlat_64_icmp_info_outer(skb, in6);
 }
-- 
2.55.0

