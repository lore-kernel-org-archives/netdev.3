Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833982;
	b=FjZ5DmFKlIcrB6GjpnjQGz5v14NLF783FUZjUdN9/9HE3bSQXkqZz1XwCi474yie6uik
	 NsRcSfVsqIB1hCInbpbkTwgn4kUQWGQrGzG5eExDJCFb+japsf09k5rpX7UpOecOqa2ro
	 gSw5b3wahC6vkGZx8xrvW0Nv3VU8rJYdFpK8rLix6O61nqXS9jwUesMiXV3Vs9L95apiK
	 HIJ3Ipuz+qLYO/W9gg7kZnbLb0N1yXAI5HPafW0KMwuLPGXM8D1IzKKiuKj7UI83DH0dq
	 Sam34q9GX6nDN/SXvc/13oJqlL0bcjFsIClubf7So1hsnKkcWHgtupAMdSsHHCY3HwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833982;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=Occ5W4juoSZKuX+c20ikX3p/vP5RFTn3K0lLNbv5xys=;
	b=CFl1RO8jhpP+ljujC5WvbXygMa26DkTWn1ZgIWqmxV9/Yzb5dGMkhJThrSme6859QLlB
	 fXz4vs/PZcs86zP3agz3N9borPD5JSge0cLiNLd8j7jNADbkgnbalxzSjrG+lHQYq6RfM
	 uXwmh0YV9GmS9kAoMj2n34gpTrbgSm2m802IZthfld21DxR9YqhdDS4qgWyIoGUcswFlK
	 JfJn4OBaO+QUaivmvIqfECYG+i6YGSUouTHhMbxCn/8H4brlCGyplUyXmYiG9uZ9RUZr9
	 iYbzn4JuKSRgqmZBSDW7mfrQq+5c82PBzeUBH7RPTi2DL6yeANcfY2i40gkUZDmtskg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=nBuPK57g;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BB606A329;
	Sat, 24 Oct 2026 09:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 778BB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=nBuPK57g
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jBZJJ1CqnzLm3r;
	Sat, 24 Oct 2026 11:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Occ5W4juoSZKuX+c20ikX3p/vP5RFTn3K0lLNbv5xys=;
	b=nBuPK57gg8cKERUGB5kFefOiV4OfNQRFKcs8OYzJqNDyAhufMd+YcCyx7hnlsmkoBoVi+J
	+3SgT5hSxNntRZHWUh4bWrvn3ULsXBZezU+0VEQBI35AooAyJ9atFy7uFCldioRy7KByv8
	r4MqbtU80P/Qa16Nz/6AjQtM+EXZPl9r1hVJG3FY6LWmCZDkzL0m7fh5mwuAwrv696rVsm
	RlYJL22aFBGQumwtG0yl/wg+Y+2tPjqDcBbGXLqEJ5Og+0uHg1+XNzYcLCkn3/YC/64vL+
	AXEtfVhOrG12LFjazRAx8tGAvZMOv2Y1VFT6IqXzG4AWQNtrFxgh9Rclfh/zXQ==
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
	Beniamino Galvani <bgalvani@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 06/18] net: ipxlat: add RFC 6052 and EAM address translation
Date: Sat, 24 Oct 2026 11:25:16 +0200
Message-ID: <20261024092532.172005-7-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJJ1CqnzLm3r

Translate each endpoint through a matching RFC 7757 EAM first and
use the configured RFC 6052 prefix as fallback. Permit the RFC 7915
dummy IPv4 source only for otherwise unmappable ICMPv6 errors.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-3-ralf@mandelbit.com/
- Extend the v1 symmetric RFC 6052 conversion with an optional RFC 7757
  EAM. Each endpoint independently uses the EAM on a match and RFC 6052
  otherwise, supporting both single-address and delegated-prefix CLAT.
  (Beniamino)
- Validate the reserved RFC 6052 u octet during 6-to-4 extraction.

 net/ipxlat/Makefile  |   1 +
 net/ipxlat/address.c | 218 +++++++++++++++++++++++++++++++++++++++++++
 net/ipxlat/address.h |  57 +++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 net/ipxlat/address.c
 create mode 100644 net/ipxlat/address.h

diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index 47d00b7b05bb..013c338a2576 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_NET_IPXLAT) += ipxlat.o
 
 ipxlat-objs += config.o
 ipxlat-objs += core.o
+ipxlat-objs += address.o
diff --git a/net/ipxlat/address.c b/net/ipxlat/address.c
new file mode 100644
index 000000000000..e1ff81daf7dc
--- /dev/null
+++ b/net/ipxlat/address.c
@@ -0,0 +1,218 @@
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
+#include <linux/errno.h>
+#include <linux/inetdevice.h>
+#include <linux/kernel.h>
+
+#include "address.h"
+
+static bool ipxlat_prefix4_contains(const struct ipxlat_prefix4 *prefix,
+				    __be32 addr)
+{
+	return (addr & inet_make_mask(prefix->len)) == prefix->addr;
+}
+
+static bool ipxlat_prefix6_contains(const struct ipxlat_prefix6 *prefix,
+				    const struct in6_addr *addr)
+{
+	return ipv6_prefix_equal(&prefix->addr, addr, prefix->len);
+}
+
+static void ipxlat_rfc6052_46_embed(__be32 addr4, struct in6_addr *dst,
+				    unsigned int q1, unsigned int q2,
+				    unsigned int q3, unsigned int q4)
+{
+	const u32 src = ntohl(addr4);
+
+	dst->s6_addr[q1] = src >> 24;
+	dst->s6_addr[q2] = src >> 16;
+	dst->s6_addr[q3] = src >> 8;
+	dst->s6_addr[q4] = src;
+}
+
+static void ipxlat_rfc6052_46(const struct ipxlat_prefix6 *rfc6052_prefix6,
+			      __be32 addr4, struct in6_addr *addr6)
+{
+	*addr6 = rfc6052_prefix6->addr;
+
+	/* always skip the 9th (index 8) byte which is the reserve "u" octet */
+	switch (rfc6052_prefix6->len) {
+	case 96:
+		addr6->s6_addr32[3] = addr4;
+		break;
+	case 64:
+		ipxlat_rfc6052_46_embed(addr4, addr6, 9, 10, 11, 12);
+		break;
+	case 56:
+		ipxlat_rfc6052_46_embed(addr4, addr6, 7, 9, 10, 11);
+		break;
+	case 48:
+		ipxlat_rfc6052_46_embed(addr4, addr6, 6, 7, 9, 10);
+		break;
+	case 40:
+		ipxlat_rfc6052_46_embed(addr4, addr6, 5, 6, 7, 9);
+		break;
+	case 32:
+		addr6->s6_addr32[1] = addr4;
+		break;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		break;
+	}
+}
+
+static __be32 ipxlat_rfc6052_64_extract(const struct in6_addr *src,
+					unsigned int q1, unsigned int q2,
+					unsigned int q3, unsigned int q4)
+{
+	const u32 a = src->s6_addr[q1];
+	const u32 b = src->s6_addr[q2];
+	const u32 c = src->s6_addr[q3];
+	const u32 d = src->s6_addr[q4];
+
+	return htonl((a << 24) | (b << 16) | (c << 8) | d);
+}
+
+static int ipxlat_rfc6052_64(const struct ipxlat_prefix6 *rfc6052_prefix6,
+			     const struct in6_addr *addr6, __be32 *addr4)
+{
+	if (!ipxlat_prefix6_contains(rfc6052_prefix6, addr6) ||
+	    addr6->s6_addr[8])
+		return -EINVAL;
+
+	/* always skip the 9th (index 8) byte which is the reserve "u" octet */
+	switch (rfc6052_prefix6->len) {
+	case 96:
+		*addr4 = addr6->s6_addr32[3];
+		break;
+	case 64:
+		*addr4 = ipxlat_rfc6052_64_extract(addr6, 9, 10, 11, 12);
+		break;
+	case 56:
+		*addr4 = ipxlat_rfc6052_64_extract(addr6, 7, 9, 10, 11);
+		break;
+	case 48:
+		*addr4 = ipxlat_rfc6052_64_extract(addr6, 6, 7, 9, 10);
+		break;
+	case 40:
+		*addr4 = ipxlat_rfc6052_64_extract(addr6, 5, 6, 7, 9);
+		break;
+	case 32:
+		*addr4 = addr6->s6_addr32[1];
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void ipxlat_set_bit(struct in6_addr *addr, unsigned int bit, bool value)
+{
+	/* IPv6 prefix bits are numbered from the most significant bit */
+	u8 *p = &addr->s6_addr[bit >> 3];
+	u8 mask = BIT(7 - (bit & 7));
+
+	if (value)
+		*p |= mask;
+	else
+		*p &= ~mask;
+}
+
+static bool ipxlat_get_bit(const struct in6_addr *addr, unsigned int bit)
+{
+	return addr->s6_addr[bit >> 3] & BIT(7 - (bit & 7));
+}
+
+static void ipxlat_eam_46(__be32 addr4, const struct ipxlat_eam *eam,
+			  struct in6_addr *addr6)
+{
+	const u8 host_bits = 32 - eam->prefix4.len;
+	const u32 host = ntohl(addr4);
+	unsigned int i;
+
+	/* append the IPv4 suffix to EAM6 and leave the unused tail zero */
+	*addr6 = eam->prefix6.addr;
+	for (i = 0; i < host_bits; ++i)
+		ipxlat_set_bit(addr6, eam->prefix6.len + i,
+			       host & BIT(host_bits - 1 - i));
+}
+
+static void ipxlat_eam_64(const struct in6_addr *addr6,
+			  const struct ipxlat_eam *eam, __be32 *addr4)
+{
+	const u8 host_bits = 32 - eam->prefix4.len;
+	unsigned int i;
+	u32 host = 0;
+
+	/* RFC 7757 discards IPv6 suffix bits which do not fit in IPv4 */
+	for (i = 0; i < host_bits; ++i)
+		host = (host << 1) |
+		       ipxlat_get_bit(addr6, eam->prefix6.len + i);
+
+	*addr4 = eam->prefix4.addr | htonl(host);
+}
+
+static void ipxlat_46_convert_addr(const struct ipxlat_config *cfg,
+				   __be32 addr4, struct in6_addr *addr6)
+{
+	const struct ipxlat_eam *eam = &cfg->eam;
+
+	if (cfg->has_eam && ipxlat_prefix4_contains(&eam->prefix4, addr4)) {
+		ipxlat_eam_46(addr4, eam, addr6);
+		return;
+	}
+
+	ipxlat_rfc6052_46(&cfg->rfc6052_prefix6, addr4, addr6);
+}
+
+static int ipxlat_64_convert_addr(const struct ipxlat_config *cfg,
+				  const struct in6_addr *addr6, __be32 *addr4)
+{
+	const struct ipxlat_eam *eam = &cfg->eam;
+
+	if (cfg->has_eam && ipxlat_prefix6_contains(&eam->prefix6, addr6)) {
+		ipxlat_eam_64(addr6, eam, addr4);
+		return 0;
+	}
+
+	return ipxlat_rfc6052_64(&cfg->rfc6052_prefix6, addr6, addr4);
+}
+
+void ipxlat_46_convert_endpoints(const struct ipxlat_config *cfg,
+				 const struct iphdr *iph4, struct in6_addr *src,
+				 struct in6_addr *dst)
+{
+	ipxlat_46_convert_addr(cfg, iph4->saddr, src);
+	ipxlat_46_convert_addr(cfg, iph4->daddr, dst);
+}
+
+int ipxlat_64_convert_endpoints(const struct ipxlat_config *cfg,
+				const struct ipv6hdr *hdr6,
+				bool allow_dummy_src, __be32 *src, __be32 *dst)
+{
+	int err;
+
+	err = ipxlat_64_convert_addr(cfg, &hdr6->saddr, src);
+	if (err) {
+		if (!allow_dummy_src)
+			return err;
+
+		/* ICMPv6 errors may come from a router whose source address has
+		 * no configured IPv4 mapping
+		 */
+		*src = htonl(INADDR_DUMMY);
+	}
+
+	return ipxlat_64_convert_addr(cfg, &hdr6->daddr, dst);
+}
diff --git a/net/ipxlat/address.h b/net/ipxlat/address.h
new file mode 100644
index 000000000000..5f43c729bc94
--- /dev/null
+++ b/net/ipxlat/address.h
@@ -0,0 +1,57 @@
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
+#ifndef _NET_IPXLAT_ADDRESS_H_
+#define _NET_IPXLAT_ADDRESS_H_
+
+#include <linux/ip.h>
+#include <net/ipv6.h>
+
+#include <net/ipxlat.h>
+
+/**
+ * ipxlat_46_convert_endpoints - convert both endpoints of an IPv4 header
+ * @cfg: validated translation configuration
+ * @iph4: original IPv4 header
+ * @src: translated IPv6 source
+ * @dst: translated IPv6 destination
+ *
+ * A matching RFC 7757 EAM takes precedence for each endpoint. Endpoints not
+ * covered by the EAM are converted with the RFC 6052 prefix.
+ */
+void ipxlat_46_convert_endpoints(const struct ipxlat_config *cfg,
+				 const struct iphdr *iph4, struct in6_addr *src,
+				 struct in6_addr *dst);
+
+/**
+ * ipxlat_64_convert_endpoints - convert both endpoints of an IPv6 header
+ * @cfg: validated translation configuration
+ * @hdr6: original IPv6 header
+ * @allow_dummy_src: permit the RFC 7915 dummy IPv4 source (for an ICMP error)
+ * @src: translated IPv4 source
+ * @dst: translated IPv4 destination
+ *
+ * A matching RFC 7757 EAM takes precedence for each endpoint. Endpoints not
+ * covered by the EAM are converted with the RFC 6052 prefix.
+ *
+ * If the source address cannot be converted and @allow_dummy_src is true,
+ * INADDR_DUMMY will be used as source.
+ *
+ * Return: zero on success or a negative errno when an endpoint cannot be
+ * represented in IPv4.
+ */
+int ipxlat_64_convert_endpoints(const struct ipxlat_config *cfg,
+				const struct ipv6hdr *hdr6,
+				bool allow_dummy_src, __be32 *src, __be32 *dst);
+
+#endif /* _NET_IPXLAT_ADDRESS_H_ */
-- 
2.55.0

