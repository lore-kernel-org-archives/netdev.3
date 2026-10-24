Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833977;
	b=jikGrznFIcYNDvXxm2berDSHDLLPmR6AK1Fno+ZAbFMD5hUAk5nzvghenaT7IFakzEtS
	 BxfWsLP4I8y1YGYr7H+a21QnZcV+09EIKM+nXTo59/bBdbCP+1p7vja18pj60Bx2ghy25
	 TJSVHbdi0woBgS8YhDsKNAt4y+0rNjiU+TsTUIGkHcFJw1XzbIi9DFydZNUisop0A919W
	 dJhgwoslKJs2EJDodw1hBUzvL8pxyUwECR6/Y6LFwYiRMtbURU4JIr1XfPCazzhw4NWnb
	 T9jr9yU7EAHEQAoqKUHffxeL9guSMr5YHsKdqXFMeEk/UArj4PyffMWJU7kyPKGtXhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833977;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=CWscuE6h4MsT6ScEWupVOzqsOKdqnz8AjJsWzvvF6ck=;
	b=s4JLKnNWV/MHKDpBSUzNhZvHouLjuUerOJRIE1lXKkGTmpvyT5Ym93AfgQ1ZokRiLtUR
	 mxHLWV9guEDCXnJE2gz1ad8ShMFBvSDzxMZ3lPVajqjdolOlwZ2dRtTjX6f9bL3Suc6Ft
	 cYWqSWdguci4Ado5gUwhCsUBHnu7LcVBo4pgMGHfDnor14qR/ytoH/KjAVdngRKEzO7U+
	 RfZU72aUxc4VZ7rCMtJKZWuuF/5qYt4gaW2ksmBd0eggjHRoiT63O70gJmJ5T/XhGpPGG
	 R9VOXVPVu+h/Ac5P1Szfa0U4SlwqkGsJP5kdiT6R0jDxYRPBK9WpryMvTsNH05YAI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=f0FPFHkh;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F308606A32C;
	Sat, 24 Oct 2026 09:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F308606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=f0FPFHkh
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jBZJN6Kzjz3y47;
	Sat, 24 Oct 2026 11:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWscuE6h4MsT6ScEWupVOzqsOKdqnz8AjJsWzvvF6ck=;
	b=f0FPFHkh52NrqBYd3dxtXDyeOasShqiwe2nT9lpT0qrMm0X8s3X+98XTXU0DaHtea2um7Y
	7zjWKpVkK1E3Pc17G7u8yrz6GzRerYSUSDTw2sm+hIQPtfBSbYYFR7MPPKs3EH+92qUvzb
	mNquC+LxNwJ6SbKiaN/T9OT5MH3LOuGWOjwtoe0nUh+gvxJo29fAZWn2YDCY8O34X4gmOd
	Vm5M4+sXDXmJbfIQsfmK5Eqh0NIsBsiRWZrRweutuJQNJcceXBpQm54OrC5ZPXt0yWRaxi
	rbGKwSwnOTEjy2iPhxqdsYC5rCe3egRVSTo0gs8B9f3DjxmZhm68e9HPVs6FoQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 12/18] net: ipxlat: add translation preparation and dispatch
Date: Sat, 24 Oct 2026 11:25:22 +0200
Message-ID: <20261024092532.172005-13-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJN6Kzjz3y47

Expose a two-stage engine interface which validates and caches packet
metadata before rewriting. Mark translated DF-clear IPv4 packets so
IPv6 output owns any required fragmentation or refragmentation.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-9-ralf@mandelbit.com/
- Replace the v1 ndo_start_xmit dispatch/actions with the exported
  ipxlat_prepare and ipxlat_translate engine interface so attachments
  other than the initial LWT harness can reuse the translator. (Toke)
- Complete eligibility checks and protocol preflight before mutation so
  unsupported packets can be returned untouched. Allocation failures
  during the rewrite still leave the packet for the caller to discard.
- Stop decrementing TTL or Hop Limit inside the engine: the
  translated-family forwarding path owns the one forwarding decrement.
  (Sashiko)
- Remove pre-fragmentation and mark translated DF-clear IPv4
  representations for fragmentation by the target IPv6 output route.

 include/net/ipxlat.h | 35 +++++++++++++++++
 net/ipxlat/core.c    | 92 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/include/net/ipxlat.h b/include/net/ipxlat.h
index 6b8efb2669b8..ddc98058ff20 100644
--- a/include/net/ipxlat.h
+++ b/include/net/ipxlat.h
@@ -16,6 +16,7 @@
 
 #include <linux/in6.h>
 #include <linux/types.h>
+#include <net/ip.h>
 
 struct ipxlat_prefix4 {
 	__be32 addr;
@@ -63,4 +64,38 @@ bool ipxlat_prefix6_len_valid(u8 len);
  */
 int ipxlat_config_validate(const struct ipxlat_config *cfg);
 
+/**
+ * ipxlat_prepare - validate a packet and cache translation metadata
+ * @cfg: validated, immutable translation configuration
+ * @skb: packet to prepare
+ *
+ * The caller must own @skb exclusively. This function uses @skb->cb as parser
+ * storage but does not rewrite packet bytes. On success it sets the transport
+ * header offset. %-EOPNOTSUPP means ipxlat does not handle the packet. A caller
+ * that passes such a packet back to the original stack must restore the old
+ * control buffer.
+ *
+ * Return: 0 when @skb is ready for ipxlat_translate, or a negative errno.
+ */
+int ipxlat_prepare(const struct ipxlat_config *cfg, struct sk_buff *skb);
+
+/**
+ * ipxlat_translate - translate one prepared skb without consuming it
+ * @cfg: configuration used by the preceding ipxlat_prepare call
+ * @net: namespace in which translation runs and whose IPv4 ID state is used
+ * @skb: prepared packet to translate
+ *
+ * The caller must provide a non-NULL @net and must not change @cfg, @skb or
+ * its cached metadata between preparation and translation. Successful
+ * Translation of a DF-clear IPv4 packet sets @skb->ignore_df and marks the
+ * resulting IPv6 packet as locally owned for target-family fragmentation. A
+ * harness which scrubs the skb must preserve both properties.
+ *
+ * Return: 0 with @skb in the translated representation, or a negative errno
+ * with the packet representation unspecified, in which case the caller must
+ * discard it.
+ */
+int ipxlat_translate(const struct ipxlat_config *cfg, struct net *net,
+		     struct sk_buff *skb);
+
 #endif /* _NET_IPXLAT_H_ */
diff --git a/net/ipxlat/core.c b/net/ipxlat/core.c
index 85037446291e..1dc1fc7e6f04 100644
--- a/net/ipxlat/core.c
+++ b/net/ipxlat/core.c
@@ -12,6 +12,98 @@
  */
 
 #include <linux/module.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+
+#include <net/ipxlat.h>
+#include "address.h"
+#include "packet.h"
+#include "translate_46.h"
+#include "translate_64.h"
+
+int ipxlat_prepare(const struct ipxlat_config *cfg, struct sk_buff *skb)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	int ret;
+
+	DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
+	memset(skb->cb, 0, sizeof(struct ipxlat_cb));
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IPV6:
+		ret = ipxlat_v6_validate_skb(skb);
+		if (unlikely(ret))
+			return ret;
+
+		/* packets with non-translatable IPv6 addresses can be handed
+		 * back to the stack unchanged since they might be intended for
+		 * native traffic such as ND
+		 */
+		ret = ipxlat_64_convert_endpoints(cfg, ipv6_hdr(skb),
+						  cb->is_icmp_err, &cb->saddr4,
+						  &cb->daddr4);
+		if (unlikely(ret))
+			return -EOPNOTSUPP;
+
+		if (unlikely(cb->l4_proto == NEXTHDR_ICMP))
+			return -EOPNOTSUPP;
+		break;
+	case ETH_P_IP:
+		ret = ipxlat_v4_validate_skb(skb);
+		if (unlikely(ret))
+			return ret;
+
+		if (unlikely(cb->l4_proto == IPPROTO_ICMP))
+			return -EOPNOTSUPP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	skb_set_transport_header(skb, cb->l4_off);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipxlat_prepare);
+
+int ipxlat_translate(const struct ipxlat_config *cfg, struct net *net,
+		     struct sk_buff *skb)
+{
+	bool frag_source;
+	int ret;
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IPV6:
+		return ipxlat_64_translate(cfg, net, skb);
+	case ETH_P_IP:
+		frag_source = !(ip_hdr(skb)->frag_off & htons(IP_DF));
+
+		if (ipxlat_skb_cb(skb)->l4_proto == IPPROTO_UDP) {
+			/* calculate the csum of a csumless UDP packet */
+			ret = ipxlat_46_prepare_udp_csum(skb);
+			if (unlikely(ret))
+				return ret;
+		}
+
+		ret = ipxlat_46_translate(cfg, skb);
+		if (unlikely(ret))
+			return ret;
+
+		/* Replace parser state with IPv6 fragmentation metadata.
+		 * DF-clear IPv4 packets may be fragmented by the target route,
+		 * while IP6SKB_FRAG_SOURCE lets reassembly and ip6_fragment
+		 * preserve an existing translated Fragment Header.
+		 */
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		skb->ignore_df = frag_source;
+		if (frag_source)
+			IP6CB(skb)->flags |= IP6SKB_FRAG_SOURCE;
+		return 0;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(ipxlat_translate);
 
 MODULE_DESCRIPTION("IPv6<>IPv4 stateless translation engine (SIIT)");
 MODULE_LICENSE("GPL");
-- 
2.55.0

