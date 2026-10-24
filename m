Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833990;
	b=D9aRJ9bHRDz4U0vhB6NZftpZpvELEWofukyq721zqP89DJdbL2ty4aCk6nVLqSlh2vwR
	 zNPkPFSykAN99yAepvMekXzDp6jBNhhqIG8PmeUxwyW3A1tWEMe7Ybgze0PeC9n9vdVMc
	 EXlasAa5/8Yn0UDKgAR8jYGC4y8i2G2mKel4RyIwCLwArsI8i1TyYOlRDZOMmi4D3dWM0
	 q00DKkCqkjQx92ISCo3HjAoOrtoQzjeAbrGghuWr5yaafi6rT8vLFIHcloQH7l2efJOiU
	 /K+GW+24Lxh0tjLzP9RhaJ5sJbEJme+BbFSbu8992PgL9gGYsPZlgQMkPHZh4hQ28xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833990;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=xgsK41h1iZknhEOzSvk0NGM0MdTExY3KTLxZgpFWMZQ=;
	b=jPg70SQ8By1dyT71x3P8y899IjmZK8aHB16dmiVZgyK43Fdz2FLy3EG+c8lP11p2Zz9j
	 SONAI1PxNN6vguScTmcxRpi2lLBLQG1+a2wTdp8UyF+LvK271M1dwy9TCY+trxrp1MutM
	 5hqLEclBo9/99v6HPtT4kXTk5kVQZrnDX4DMmBzgE4U8FsnxP5Wyryj8z2ZbeVwks1WwN
	 pEE4r+wpeT7zm4l+FJVeVkKAiyKAYIIqdILL8eRHQWkF+UvkXCkS6s831gVsKvZDGeye6
	 dpOofAldU3VnFW7r9Q/2anH2nUaGUe3E9ioq8p2CZ1wBOmjGyBNlMMgNnzHY63azviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=tQx31s4o;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D360A260A;
	Sat, 24 Oct 2026 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 436D360A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=tQx31s4o
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jBZJQ56qzzLmJh;
	Sat, 24 Oct 2026 11:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgsK41h1iZknhEOzSvk0NGM0MdTExY3KTLxZgpFWMZQ=;
	b=tQx31s4oMAL0Qu6NQ0qNG4rkLPjFP9kRDEooHbQGlopKSYDc3MytCJXp7WfvtuWOU5Ksw2
	c6J6OSwlgpwLyD8FKHugjsa+3lxgQ++V9LBKgQasSVV2ZmVsQOx85AMJFwNd76ZuXgBO1M
	pNzGRb76cak8NpqmNByZIw0px8iwRypHbR7VQAGIWY92i6Cc6lOh5QhZDkENeHf0dPC0IT
	93QKERIzKbcYvwvotqPQynD1+cySb3/WYoMSO2qBN1JOv6uLyWg+BuYEUUqDpXscdwcDjZ
	kiL40/MyvxsFhQ4oOsm6aI4lpu2ks98EnsS3dZ6ZBtymQNqPLqEppHOfLFPphQ==
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
Subject: [RFC net-next v2 14/18] net: ipxlat: add ICMP informational translation
Date: Sat, 24 Oct 2026 11:25:24 +0200
Message-ID: <20261024092532.172005-15-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJQ56qzzLmJh

Translate ICMP echo requests and replies in both directions, including
incremental conversion of complete checksums and reseeding of partial
checksums. Decline ICMP errors until quoted-packet translation is
available.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-12-ralf@mandelbit.com/
- Remove the ICMPv6 pseudo-header seed before producing a
  CHECKSUM_PARTIAL informational ICMPv4 packet. (Sashiko)

 net/ipxlat/Makefile       |   2 +
 net/ipxlat/core.c         |  15 +++--
 net/ipxlat/icmp.h         |  70 +++++++++++++++++++++++
 net/ipxlat/icmp_46.c      | 106 +++++++++++++++++++++++++++++++++++
 net/ipxlat/icmp_64.c      | 114 ++++++++++++++++++++++++++++++++++++++
 net/ipxlat/translate_46.c |   4 ++
 net/ipxlat/translate_64.c |   4 ++
 7 files changed, 311 insertions(+), 4 deletions(-)
 create mode 100644 net/ipxlat/icmp.h
 create mode 100644 net/ipxlat/icmp_46.c
 create mode 100644 net/ipxlat/icmp_64.c

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index b0fab158c7b3..2190cad37c7f 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -12,3 +12,5 @@ ipxlat-objs += packet6.o
 ipxlat-objs += transport.o
 ipxlat-objs += translate_46.o
 ipxlat-objs += translate_64.o
+ipxlat-objs += icmp_46.o
+ipxlat-objs += icmp_64.o
diff --git a/net/ipxlat/core.c b/net/ipxlat/core.c
index dc03ca3c9f89..5a2d7099c9d9 100644
--- a/net/ipxlat/core.c
+++ b/net/ipxlat/core.c
@@ -22,6 +22,7 @@
 #include <net/ipxlat.h>
 #include "address.h"
 #include "packet.h"
+#include "icmp.h"
 #include "translate_46.h"
 #include "translate_64.h"
 
@@ -49,16 +50,22 @@ int ipxlat_prepare(const struct ipxlat_config *cfg, struct sk_buff *skb)
 		if (unlikely(ret))
 			return -EOPNOTSUPP;
 
-		if (unlikely(cb->l4_proto == NEXTHDR_ICMP))
-			return -EOPNOTSUPP;
+		if (unlikely(cb->l4_proto == NEXTHDR_ICMP)) {
+			ret = ipxlat_64_icmp_preflight(cfg, skb);
+			if (ret)
+				return ret;
+		}
 		break;
 	case ETH_P_IP:
 		ret = ipxlat_v4_validate_skb(skb);
 		if (unlikely(ret))
 			return ret;
 
-		if (unlikely(cb->l4_proto == IPPROTO_ICMP))
-			return -EOPNOTSUPP;
+		if (unlikely(cb->l4_proto == IPPROTO_ICMP)) {
+			ret = ipxlat_46_icmp_preflight(skb);
+			if (ret)
+				return ret;
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/net/ipxlat/icmp.h b/net/ipxlat/icmp.h
new file mode 100644
index 000000000000..0e887746efe0
--- /dev/null
+++ b/net/ipxlat/icmp.h
@@ -0,0 +1,70 @@
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
+#ifndef _NET_IPXLAT_ICMP_H_
+#define _NET_IPXLAT_ICMP_H_
+
+#include <linux/ipv6.h>
+
+#include <net/ipxlat.h>
+
+/**
+ * ipxlat_46_icmp_preflight - check whether an ICMPv4 packet is translatable
+ * @skb: validated packet carrying ICMPv4
+ *
+ * This check runs before any packet bytes are rewritten.
+ *
+ * Return: 0 when translatable or %-EOPNOTSUPP when the packet should be left
+ * in its original representation.
+ */
+int ipxlat_46_icmp_preflight(struct sk_buff *skb);
+
+/**
+ * ipxlat_46_icmp - translate ICMP payload after outer 4->6 L3 rewrite
+ * @cfg: immutable route translation configuration
+ * @skb: packet carrying ICMPv4 transport payload
+ *
+ * Handles both ICMP info translation and ICMP error quoted-inner rewriting.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_46_icmp(const struct ipxlat_config *cfg, struct sk_buff *skb);
+
+/**
+ * ipxlat_64_icmp_preflight - check whether an ICMPv6 packet is translatable
+ * @cfg: immutable route translation configuration
+ * @skb: validated packet carrying ICMPv6
+ *
+ * This check includes quoted endpoints and runs before any packet bytes are
+ * rewritten.
+ *
+ * Return: 0 when translatable, %-EOPNOTSUPP when the packet should be left in
+ * its original representation, or another negative errno for invalid input.
+ */
+int ipxlat_64_icmp_preflight(const struct ipxlat_config *cfg,
+			     struct sk_buff *skb);
+
+/**
+ * ipxlat_64_icmp - translate ICMP payload after outer 6->4 L3 rewrite
+ * @net: namespace owning quoted translated IPv4 fragment-ID state
+ * @skb: packet carrying ICMPv6 transport payload
+ * @in6: snapshot of original outer IPv6 header
+ *
+ * Handles both ICMP info translation and ICMP error quoted-inner rewriting.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+int ipxlat_64_icmp(struct net *net, struct sk_buff *skb,
+		   const struct ipv6hdr *in6);
+
+#endif /* _NET_IPXLAT_ICMP_H_ */
diff --git a/net/ipxlat/icmp_46.c b/net/ipxlat/icmp_46.c
new file mode 100644
index 000000000000..bb3952256162
--- /dev/null
+++ b/net/ipxlat/icmp_46.c
@@ -0,0 +1,106 @@
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
+
+#include "icmp.h"
+#include "packet.h"
+#include "transport.h"
+
+static int ipxlat_46_icmp_map_info_type_code(const struct icmphdr *in,
+					     struct icmp6hdr *out)
+{
+	switch (in->type) {
+	case ICMP_ECHO:
+		out->icmp6_type = ICMPV6_ECHO_REQUEST;
+		out->icmp6_code = 0;
+		out->icmp6_identifier = in->un.echo.id;
+		out->icmp6_sequence = in->un.echo.sequence;
+		return 0;
+	case ICMP_ECHOREPLY:
+		out->icmp6_type = ICMPV6_ECHO_REPLY;
+		out->icmp6_code = 0;
+		out->icmp6_identifier = in->un.echo.id;
+		out->icmp6_sequence = in->un.echo.sequence;
+		return 0;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
+int ipxlat_46_icmp_preflight(struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmphdr *icmp4;
+	struct icmp6hdr mapped = {};
+	int err;
+
+	if (cb->is_icmp_err)
+		return -EOPNOTSUPP;
+
+	icmp4 = (const struct icmphdr *)(skb->data + cb->l4_off);
+	err = ipxlat_46_icmp_map_info_type_code(icmp4, &mapped);
+	return err ? -EOPNOTSUPP : 0;
+}
+
+static void ipxlat_46_icmp_info_update_csum(const struct icmphdr *icmp4,
+					    struct icmp6hdr *icmp6,
+					    const struct ipv6hdr *ip6,
+					    unsigned int l4_len)
+{
+	struct icmp6hdr icmp6_zero = *icmp6;
+	struct icmphdr icmp4_zero = *icmp4;
+	__wsum csum;
+
+	icmp4_zero.checksum = 0;
+	icmp6_zero.icmp6_cksum = 0;
+	csum = ~csum_unfold(icmp4->checksum);
+	csum = csum_sub(csum, csum_partial(&icmp4_zero, sizeof(icmp4_zero), 0));
+	csum = csum_add(csum, csum_partial(&icmp6_zero, sizeof(icmp6_zero), 0));
+	icmp6->icmp6_cksum = csum_ipv6_magic(&ip6->saddr, &ip6->daddr, l4_len,
+					     IPPROTO_ICMPV6, csum);
+}
+
+static int ipxlat_46_icmp_info_outer(struct sk_buff *skb)
+{
+	const struct icmphdr icmp4 = *icmp_hdr(skb);
+	const struct ipv6hdr *ip6 = ipv6_hdr(skb);
+	struct icmp6hdr *icmp6 = icmp6_hdr(skb);
+	unsigned int l4_len;
+	int err;
+
+	err = ipxlat_46_icmp_map_info_type_code(&icmp4, icmp6);
+	if (unlikely(err))
+		return -EINVAL;
+
+	l4_len = ipxlat_skb_l4_len(skb);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		icmp6->icmp6_cksum = ~csum_ipv6_magic(&ip6->saddr, &ip6->daddr,
+						      l4_len, IPPROTO_ICMPV6,
+						      0);
+		return ipxlat_set_partial_csum(skb, offsetof(struct icmp6hdr,
+							     icmp6_cksum));
+	}
+
+	ipxlat_46_icmp_info_update_csum(&icmp4, icmp6, ip6, l4_len);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_icmp(const struct ipxlat_config *cfg, struct sk_buff *skb)
+{
+	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
+		return -EINVAL;
+
+	return ipxlat_46_icmp_info_outer(skb);
+}
diff --git a/net/ipxlat/icmp_64.c b/net/ipxlat/icmp_64.c
new file mode 100644
index 000000000000..ce3131ffc6be
--- /dev/null
+++ b/net/ipxlat/icmp_64.c
@@ -0,0 +1,114 @@
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
+
+#include "icmp.h"
+#include "packet.h"
+#include "transport.h"
+
+static int ipxlat_64_icmp_map_info_type_code(const struct icmp6hdr *in,
+					     struct icmphdr *out)
+{
+	switch (in->icmp6_type) {
+	case ICMPV6_ECHO_REQUEST:
+		out->type = ICMP_ECHO;
+		out->code = 0;
+		out->un.echo.id = in->icmp6_identifier;
+		out->un.echo.sequence = in->icmp6_sequence;
+		return 0;
+	case ICMPV6_ECHO_REPLY:
+		out->type = ICMP_ECHOREPLY;
+		out->code = 0;
+		out->un.echo.id = in->icmp6_identifier;
+		out->un.echo.sequence = in->icmp6_sequence;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static __sum16 ipxlat_64_compute_icmp_info_csum(const struct ipv6hdr *in6,
+						const struct icmp6hdr *in_icmp6,
+						const struct icmphdr *out_icmp4,
+						unsigned int l4_len)
+{
+	struct icmp6hdr icmp6_zero = *in_icmp6;
+	struct icmphdr icmp4_zero = *out_icmp4;
+	__wsum csum, pseudo_csum;
+
+	icmp6_zero.icmp6_cksum = 0;
+	icmp4_zero.checksum = 0;
+
+	csum = ~csum_unfold(in_icmp6->icmp6_cksum);
+	pseudo_csum = ~csum_unfold(csum_ipv6_magic(&in6->saddr, &in6->daddr,
+						   l4_len, NEXTHDR_ICMP, 0));
+	csum = csum_sub(csum, pseudo_csum);
+	csum = csum_sub(csum, csum_partial(&icmp6_zero, sizeof(icmp6_zero), 0));
+	csum = csum_add(csum, csum_partial(&icmp4_zero, sizeof(icmp4_zero), 0));
+	return csum_fold(csum);
+}
+
+static int ipxlat_64_icmp_info_outer(struct sk_buff *skb,
+				     const struct ipv6hdr *in6)
+{
+	struct icmp6hdr *ic6 = icmp6_hdr(skb);
+	struct icmphdr *ic4 = icmp_hdr(skb);
+	struct icmp6hdr ic6_copy = *ic6;
+	unsigned int l4_len;
+	int err;
+
+	err = ipxlat_64_icmp_map_info_type_code(&ic6_copy, ic4);
+	if (unlikely(err))
+		return err;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* ICMPv4 has no pseudo-header so discard the IPv6 seed and let
+		 * checksum completion cover the translated ICMPv4 message
+		 */
+		ic4->checksum = 0;
+		return ipxlat_set_partial_csum(skb, offsetof(struct icmphdr,
+							     checksum));
+	}
+
+	l4_len = ipxlat_skb_l4_len(skb);
+	ic4->checksum = ipxlat_64_compute_icmp_info_csum(in6, &ic6_copy, ic4,
+							 l4_len);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_64_icmp_preflight(const struct ipxlat_config *cfg,
+			     struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmp6hdr *icmp6;
+	struct icmphdr mapped = {};
+	int err;
+
+	if (cb->is_icmp_err)
+		return -EOPNOTSUPP;
+
+	icmp6 = (const struct icmp6hdr *)(skb->data + cb->l4_off);
+	err = ipxlat_64_icmp_map_info_type_code(icmp6, &mapped);
+	return err ? -EOPNOTSUPP : 0;
+}
+
+int ipxlat_64_icmp(struct net *net, struct sk_buff *skb,
+		   const struct ipv6hdr *in6)
+{
+	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
+		return -EINVAL;
+
+	return ipxlat_64_icmp_info_outer(skb, in6);
+}
diff --git a/net/ipxlat/translate_46.c b/net/ipxlat/translate_46.c
index add29d9ef0a7..824b429dadb5 100644
--- a/net/ipxlat/translate_46.c
+++ b/net/ipxlat/translate_46.c
@@ -18,6 +18,7 @@
 #include <net/ipxlat.h>
 
 #include "address.h"
+#include "icmp.h"
 #include "packet.h"
 #include "transport.h"
 #include "translate_46.h"
@@ -199,6 +200,9 @@ int ipxlat_46_translate(const struct ipxlat_config *cfg, struct sk_buff *skb)
 	case IPPROTO_UDP:
 		err = ipxlat_46_translate_udp_csum(skb, &outer4);
 		break;
+	case IPPROTO_ICMP:
+		err = ipxlat_46_icmp(cfg, skb);
+		break;
 	default:
 		err = 0;
 		break;
diff --git a/net/ipxlat/translate_64.c b/net/ipxlat/translate_64.c
index 2448d3da32e4..3888ec0d8061 100644
--- a/net/ipxlat/translate_64.c
+++ b/net/ipxlat/translate_64.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 
 #include "translate_64.h"
+#include "icmp.h"
 #include "packet.h"
 #include "transport.h"
 
@@ -207,6 +208,9 @@ int ipxlat_64_translate(const struct ipxlat_config *cfg, struct net *net,
 	case IPPROTO_UDP:
 		err = ipxlat_64_translate_udp_csum(skb, &outer6);
 		break;
+	case IPPROTO_ICMP:
+		err = ipxlat_64_icmp(net, skb, &outer6);
+		break;
 	default:
 		err = 0;
 		break;
-- 
2.55.0

