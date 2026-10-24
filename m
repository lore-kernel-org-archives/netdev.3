Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833993;
	b=jYtn5L50Qfbz8rrmUc0gNQh/0Sdt5RA+AfviPrm9CtpbMBQkIbF2qocZiF80eJZwMB+w
	 T3cduWlrmZIyz9v7BC6c0a8e9ZP47ewU9ZSXhE8yazsZNe4UWo5avw2+3rpHhGeKcQJjy
	 jxYTrYa3nZRbGqiOvmZerNbdjB8b4NBQ/oIrl540cTshh6nJadkdX77qPv9gUUmsf/hY9
	 W1YaFwSWHR/BiFTOG53ILnJFOzVII6XSSv/VFcFFrv01GOhQw3k63RodSOZ55b3t6c6NR
	 UwaTpEk+e1sToxj9FOQM86zG+SEPnH+SRiEtQc/u3kwaJF4ueZd3XMBE/V+/n5vdRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833993;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=gbCskcSxSurQxPeaiIcv/otZSUNuYrU9shVjsM/Up2Q=;
	b=5Hg3XVzkwShm0zb3t+z3m//CzRiKJhzu8f+y/oEl/n/JLs8HWhwLFqX/uiO/GqQ5GaDS
	 RgctNwdT7tDq4EYUd/JMMV/HD8bWDGTO6csgzfDB5iSXpoo7PWBDRp8yibkccsPm9RPHR
	 xFWMnZIvNcErx/fFqFMu1vHP1U2NSkdO9piUB1EZXsuk12XowgrGB/sDc2AzQG50tzPzu
	 Um6w8oHsh1KrfzPhDagWTR/nqZlBcIJbpSN4/MURMUd/5mrTlsDgVID4sZG22fD+4BX6u
	 jU/F0aF3f8lAYMFIpH32NDnustAu9P13zbiwJ8g8udBvSSc7WK0vpp5TY9LaV0w0XgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=NYKYuQqg;
	arc=none smtp.remote-ip=195.10.208.51
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680F60A2634;
	Sat, 24 Oct 2026 09:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3680F60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=NYKYuQqg
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jBZJS4D9ZzY8;
	Sat, 24 Oct 2026 11:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbCskcSxSurQxPeaiIcv/otZSUNuYrU9shVjsM/Up2Q=;
	b=NYKYuQqg8L2gagKP7mdK7dLspx4VrRQVk42N1gyrycU5OLxVbsUWP9gbAus23xuPmqC8g2
	YTkFlFYtFhFM45LmEBkf3y+FgrihtwkyqK8Si6IfEG6DuBqvDNURtg7Ib8ZPBwz2yLB/e7
	RtYY63CIvNQ0SiUFqqjdcBSdXJKjtJfU4SGCvm6QJkOTdy7ZJ3SCgpkUmr5T4sOXhSXvdt
	YPgZlTC+G9AId1iKcJNeVh75DL8mp9+3zwh2E38cq4Dv+fOUH2ukO991aW8jxvvwH4dNf3
	R6ULmFHmwzaK/RRQcAl00MU5KPqxop9GoKvV+fHqVELhqwBvTQq8To9GB1fbRg==
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
	Beniamino Galvani <bgalvani@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 16/18] net: ipxlat: add lightweight tunnel attachment
Date: Sat, 24 Oct 2026 11:25:26 +0200
Message-ID: <20261024092532.172005-17-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJS4D9ZzY8

Attach the reusable translator to IPv4 and IPv6 routes. Parse immutable
route configuration, support input and output LWT callbacks, return
ineligible packets to the original route, and re-enter the translated
family through routing and netfilter.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-14-ralf@mandelbit.com/
- New attachment replacing the v1 virtual netdevice. (Toke)
- Parse an immutable RFC 6052 prefix and optional one-element EAMT from
  route LWT attributes (normal route, multipath, and nexthop-object
  lifetimes own the state).
- Support both input and output LWT callbacks. Return packets rejected
  as unsupported during preparation to the route's native callback.
- Scrub original-family metadata, perform a fresh translated-family
  route and XFRM lookup, and continue received traffic through
  PRE_ROUTING or local traffic through LOCAL_OUT. Populate only
  fragment-stable flow selectors.
- Let translated-family forwarding own TTL/Hop Limit and PMTU behavior,
  and expose translated packets to ordinary conntrack and NAT.
- Register the LWT module alias used by route-encapsulation autoloading
  rather than retaining the v1 rtnl-link alias. (Sashiko)

 include/uapi/linux/ipxlat.h   |  56 +++
 include/uapi/linux/lwtunnel.h |   1 +
 net/core/lwtunnel.c           |   3 +-
 net/ipxlat/Kconfig            |  11 +
 net/ipxlat/Makefile           |   5 +-
 net/ipxlat/lwt.c              | 643 ++++++++++++++++++++++++++++++++++
 6 files changed, 717 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/ipxlat.h
 create mode 100644 net/ipxlat/lwt.c

diff --git a/include/uapi/linux/ipxlat.h b/include/uapi/linux/ipxlat.h
new file mode 100644
index 000000000000..018de958f699
--- /dev/null
+++ b/include/uapi/linux/ipxlat.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) LWT configuration
+ *
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+/*
+ * IPXLAT lightweight-tunnel configuration.
+ *
+ * The attributes below are carried in RTA_ENCAP for
+ * LWTUNNEL_ENCAP_IPXLAT. Prefix addresses are raw network-byte-order
+ * address values; prefix lengths are expressed in bits.
+ */
+#ifndef _UAPI_LINUX_IPXLAT_H
+#define _UAPI_LINUX_IPXLAT_H
+
+#include <linux/types.h>
+
+enum {
+	IPXLAT_A_UNSPEC,
+	IPXLAT_A_RFC6052_PREFIX6,
+	/* nested array: each indexed element contains IPXLAT_A_EAM_*
+	 * attributes
+	 */
+	IPXLAT_A_EAMT,
+	__IPXLAT_A_MAX,
+};
+
+#define IPXLAT_A_MAX (__IPXLAT_A_MAX - 1)
+
+enum {
+	IPXLAT_A_PREFIX6_UNSPEC,
+	IPXLAT_A_PREFIX6_ADDR,
+	IPXLAT_A_PREFIX6_LEN,
+	__IPXLAT_A_PREFIX6_MAX,
+};
+
+#define IPXLAT_A_PREFIX6_MAX (__IPXLAT_A_PREFIX6_MAX - 1)
+
+enum {
+	IPXLAT_A_EAM_UNSPEC,
+	IPXLAT_A_EAM_PREFIX4,
+	IPXLAT_A_EAM_PREFIX4_LEN,
+	IPXLAT_A_EAM_PREFIX6,
+	IPXLAT_A_EAM_PREFIX6_LEN,
+	__IPXLAT_A_EAM_MAX,
+};
+
+#define IPXLAT_A_EAM_MAX (__IPXLAT_A_EAM_MAX - 1)
+
+#endif /* _UAPI_LINUX_IPXLAT_H */
diff --git a/include/uapi/linux/lwtunnel.h b/include/uapi/linux/lwtunnel.h
index 229655ef792f..34538de6baf7 100644
--- a/include/uapi/linux/lwtunnel.h
+++ b/include/uapi/linux/lwtunnel.h
@@ -16,6 +16,7 @@ enum lwtunnel_encap_types {
 	LWTUNNEL_ENCAP_RPL,
 	LWTUNNEL_ENCAP_IOAM6,
 	LWTUNNEL_ENCAP_XFRM,
+	LWTUNNEL_ENCAP_IPXLAT,
 	__LWTUNNEL_ENCAP_MAX,
 };
 
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index db21b9ff6f86..c3028124126f 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -53,6 +53,8 @@ static const char *lwtunnel_encap_str(enum lwtunnel_encap_types encap_type)
 	case LWTUNNEL_ENCAP_XFRM:
 		/* module autoload not supported for encap type */
 		return NULL;
+	case LWTUNNEL_ENCAP_IPXLAT:
+		return "IPXLAT";
 	case LWTUNNEL_ENCAP_IP6:
 	case LWTUNNEL_ENCAP_IP:
 	case LWTUNNEL_ENCAP_NONE:
@@ -200,7 +202,6 @@ int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int remaining,
 					return -EINVAL;
 				}
 				encap_type = nla_get_u16(nla_entype);
-
 				if (lwtunnel_valid_encap_type(encap_type, extack))
 					return -EOPNOTSUPP;
 			}
diff --git a/net/ipxlat/Kconfig b/net/ipxlat/Kconfig
index 6b0e47f8ce90..b73a443eef0f 100644
--- a/net/ipxlat/Kconfig
+++ b/net/ipxlat/Kconfig
@@ -12,3 +12,14 @@ config NET_IPXLAT
 	  SIIT-DC, 464XLAT network architectures.
 
 	  To compile this engine as a module, choose M here.
+
+config NET_IPXLAT_LWT
+	tristate "IPv6<>IPv4 packet translation LWT attachment"
+	depends on NET_IPXLAT
+	depends on LWTUNNEL
+	help
+	  Attach the ipxlat translation engine to IPv4 or IPv6 routes using the
+	  lightweight-tunnel route encapsulation. Routes select the packets to
+	  translate and contain their address mapping. Translated packets then
+	  enter normal routing and netfilter processing for their new address
+	  family.
diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
index 2190cad37c7f..6dc58be53e4d 100644
--- a/net/ipxlat/Makefile
+++ b/net/ipxlat/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# IPXLAT - Stateless IP/ICMP Translation (SIIT) engine
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) engine and LWT attachment
 
 obj-$(CONFIG_NET_IPXLAT) += ipxlat.o
+obj-$(CONFIG_NET_IPXLAT_LWT) += ipxlat_lwt.o
 
 ipxlat-objs += config.o
 ipxlat-objs += core.o
@@ -14,3 +15,5 @@ ipxlat-objs += translate_46.o
 ipxlat-objs += translate_64.o
 ipxlat-objs += icmp_46.o
 ipxlat-objs += icmp_64.o
+
+ipxlat_lwt-objs += lwt.o
diff --git a/net/ipxlat/lwt.c b/net/ipxlat/lwt.c
new file mode 100644
index 000000000000..6b26edb5f6b0
--- /dev/null
+++ b/net/ipxlat/lwt.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) LWT harness
+ *
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/inetdevice.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/lwtunnel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/icmp.h>
+#include <net/flow_dissector.h>
+#include <net/ip.h>
+#include <net/ip6_route.h>
+#include <net/ipv6.h>
+#include <net/lwtunnel.h>
+#include <net/route.h>
+#include <net/sock.h>
+#include <uapi/linux/ipxlat.h>
+
+#include <net/ipxlat.h>
+
+struct ipxlat_lwt {
+	struct ipxlat_config config;
+};
+
+static struct ipxlat_lwt *ipxlat_lwt_state(const struct lwtunnel_state *lws)
+{
+	return (struct ipxlat_lwt *)lws->data;
+}
+
+static const struct nla_policy ipxlat_prefix6_policy[IPXLAT_A_PREFIX6_MAX + 1] = {
+	[IPXLAT_A_PREFIX6_ADDR] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[IPXLAT_A_PREFIX6_LEN] = { .type = NLA_U8 },
+};
+
+static const struct nla_policy ipxlat_eam_policy[IPXLAT_A_EAM_MAX + 1] = {
+	[IPXLAT_A_EAM_PREFIX4] = NLA_POLICY_EXACT_LEN(sizeof(__be32)),
+	[IPXLAT_A_EAM_PREFIX4_LEN] = { .type = NLA_U8 },
+	[IPXLAT_A_EAM_PREFIX6] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[IPXLAT_A_EAM_PREFIX6_LEN] = { .type = NLA_U8 },
+};
+
+static const struct nla_policy ipxlat_lwt_policy[IPXLAT_A_MAX + 1] = {
+	[IPXLAT_A_RFC6052_PREFIX6] =
+		NLA_POLICY_NESTED(ipxlat_prefix6_policy),
+	[IPXLAT_A_EAMT] =
+		NLA_POLICY_NESTED_ARRAY(ipxlat_eam_policy),
+};
+
+static void ipxlat_normalize_prefix6(struct ipxlat_prefix6 *prefix)
+{
+	struct in6_addr original = prefix->addr;
+
+	ipv6_addr_prefix(&prefix->addr, &original, prefix->len);
+}
+
+static void ipxlat_normalize_prefix4(__be32 *prefix, u8 len)
+{
+	*prefix &= inet_make_mask(len);
+}
+
+static int ipxlat_parse_prefix6(struct nlattr *nla,
+				struct ipxlat_prefix6 *prefix,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[IPXLAT_A_PREFIX6_MAX + 1];
+	int err;
+
+	err = nla_parse_nested_deprecated(tb, IPXLAT_A_PREFIX6_MAX, nla,
+					  ipxlat_prefix6_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb[IPXLAT_A_PREFIX6_ADDR] || !tb[IPXLAT_A_PREFIX6_LEN]) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "ipxlat rfc6052-prefix6 needs address and prefix length");
+		return -EINVAL;
+	}
+
+	prefix->addr = nla_get_in6_addr(tb[IPXLAT_A_PREFIX6_ADDR]);
+	prefix->len = nla_get_u8(tb[IPXLAT_A_PREFIX6_LEN]);
+	if (!ipxlat_prefix6_len_valid(prefix->len)) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[IPXLAT_A_PREFIX6_LEN],
+				    "unsupported RFC 6052 prefix length");
+		return -EINVAL;
+	}
+
+	ipxlat_normalize_prefix6(prefix);
+	return 0;
+}
+
+static int ipxlat_parse_eam(struct nlattr *nla, struct ipxlat_eam *eam,
+			    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[IPXLAT_A_EAM_MAX + 1];
+	struct in6_addr original, prefix6;
+	__be32 prefix4;
+	int err;
+
+	err = nla_parse_nested_deprecated(tb, IPXLAT_A_EAM_MAX, nla,
+					  ipxlat_eam_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb[IPXLAT_A_EAM_PREFIX4] ||
+	    !tb[IPXLAT_A_EAM_PREFIX4_LEN] ||
+	    !tb[IPXLAT_A_EAM_PREFIX6] ||
+	    !tb[IPXLAT_A_EAM_PREFIX6_LEN]) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "ipxlat EAM needs both IPv4 and IPv6 prefixes");
+		return -EINVAL;
+	}
+
+	eam->prefix4.addr = nla_get_be32(tb[IPXLAT_A_EAM_PREFIX4]);
+	eam->prefix4.len = nla_get_u8(tb[IPXLAT_A_EAM_PREFIX4_LEN]);
+	eam->prefix6.addr = nla_get_in6_addr(tb[IPXLAT_A_EAM_PREFIX6]);
+	eam->prefix6.len = nla_get_u8(tb[IPXLAT_A_EAM_PREFIX6_LEN]);
+	if (eam->prefix4.len > 32 || eam->prefix6.len > 128) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "EAM prefix length is out of range");
+		return -EINVAL;
+	}
+	if (32 - eam->prefix4.len > 128 - eam->prefix6.len) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "EAM IPv6 prefix has insufficient host space");
+		return -EINVAL;
+	}
+
+	prefix4 = eam->prefix4.addr;
+	prefix6 = eam->prefix6.addr;
+	original = prefix6;
+	ipxlat_normalize_prefix4(&prefix4, eam->prefix4.len);
+	ipv6_addr_prefix(&prefix6, &original, eam->prefix6.len);
+	if (prefix4 != eam->prefix4.addr ||
+	    !ipv6_addr_equal(&prefix6, &eam->prefix6.addr)) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "EAM prefixes must be canonical");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipxlat_parse_eamt(struct nlattr *attrs, struct nlattr *eamt,
+			     struct ipxlat_config *config,
+			     struct netlink_ext_ack *extack)
+{
+	int rem, count, err;
+	struct nlattr *pos;
+
+	count = 0;
+	nla_for_each_nested(pos, attrs, rem) {
+		if (nla_type(pos) != IPXLAT_A_EAMT)
+			continue;
+		if (++count > 1) {
+			NL_SET_ERR_MSG(extack, "duplicate EAMT attribute");
+			return -EINVAL;
+		}
+	}
+
+	if (!eamt)
+		return 0;
+
+	count = 0;
+	nla_for_each_nested(pos, eamt, rem) {
+		if (++count > 1) {
+			NL_SET_ERR_MSG(extack,
+				       "ipxlat supports at most one EAM");
+			return -EINVAL;
+		}
+		err = ipxlat_parse_eam(pos, &config->eam, extack);
+		if (err)
+			return err;
+	}
+	config->has_eam = count != 0;
+	return 0;
+}
+
+static int ipxlat_build_state(struct net *net, struct nlattr *nla,
+			      unsigned int family, const void *cfg,
+			      struct lwtunnel_state **ts,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[IPXLAT_A_MAX + 1];
+	struct ipxlat_config config = {};
+	struct lwtunnel_state *newts;
+	struct ipxlat_lwt *ilwt;
+	int err;
+
+	if (family != AF_INET && family != AF_INET6) {
+		NL_SET_ERR_MSG(extack,
+			       "ipxlat LWT requires an IPv4 or IPv6 route");
+		return -EAFNOSUPPORT;
+	}
+
+	err = nla_parse_nested_deprecated(tb, IPXLAT_A_MAX, nla,
+					  ipxlat_lwt_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb[IPXLAT_A_RFC6052_PREFIX6]) {
+		NL_SET_ERR_MSG(extack, "ipxlat rfc6052-prefix6 is required");
+		return -EINVAL;
+	}
+	err = ipxlat_parse_prefix6(tb[IPXLAT_A_RFC6052_PREFIX6],
+				   &config.rfc6052_prefix6, extack);
+	if (err)
+		return err;
+
+	err = ipxlat_parse_eamt(nla, tb[IPXLAT_A_EAMT], &config, extack);
+	if (err)
+		return err;
+
+	err = ipxlat_config_validate(&config);
+	if (err) {
+		NL_SET_ERR_MSG(extack,
+			       "invalid normalized ipxlat prefix config");
+		return err;
+	}
+
+	newts = lwtunnel_state_alloc(sizeof(*ilwt));
+	if (!newts)
+		return -ENOMEM;
+
+	ilwt = ipxlat_lwt_state(newts);
+	ilwt->config = config;
+	newts->type = LWTUNNEL_ENCAP_IPXLAT;
+	newts->flags = LWTUNNEL_STATE_INPUT_REDIRECT |
+		       LWTUNNEL_STATE_OUTPUT_REDIRECT;
+	*ts = newts;
+
+	return 0;
+}
+
+static int ipxlat_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lws)
+{
+	const struct ipxlat_config *cfg = &ipxlat_lwt_state(lws)->config;
+	struct nlattr *prefix, *eamt, *eam;
+
+	prefix = nla_nest_start_noflag(skb, IPXLAT_A_RFC6052_PREFIX6);
+	if (!prefix)
+		return -EMSGSIZE;
+
+	if (nla_put_in6_addr(skb, IPXLAT_A_PREFIX6_ADDR,
+			     &cfg->rfc6052_prefix6.addr) ||
+	    nla_put_u8(skb, IPXLAT_A_PREFIX6_LEN, cfg->rfc6052_prefix6.len))
+		goto cancel_prefix;
+	nla_nest_end(skb, prefix);
+
+	if (!cfg->has_eam)
+		return 0;
+
+	eamt = nla_nest_start_noflag(skb, IPXLAT_A_EAMT);
+	if (!eamt)
+		return -EMSGSIZE;
+
+	eam = nla_nest_start_noflag(skb, 1);
+	if (!eam)
+		goto cancel_eamt;
+
+	if (nla_put(skb, IPXLAT_A_EAM_PREFIX4, sizeof(__be32),
+		    &cfg->eam.prefix4.addr) ||
+	    nla_put_u8(skb, IPXLAT_A_EAM_PREFIX4_LEN,
+		       cfg->eam.prefix4.len) ||
+	    nla_put_in6_addr(skb, IPXLAT_A_EAM_PREFIX6,
+			     &cfg->eam.prefix6.addr) ||
+	    nla_put_u8(skb, IPXLAT_A_EAM_PREFIX6_LEN,
+		       cfg->eam.prefix6.len))
+		goto cancel_eam;
+	nla_nest_end(skb, eam);
+	nla_nest_end(skb, eamt);
+	return 0;
+
+cancel_eam:
+	nla_nest_cancel(skb, eam);
+
+cancel_eamt:
+	nla_nest_cancel(skb, eamt);
+	return -EMSGSIZE;
+cancel_prefix:
+	nla_nest_cancel(skb, prefix);
+	return -EMSGSIZE;
+}
+
+static int ipxlat_get_encap_size(struct lwtunnel_state *lws)
+{
+	const struct ipxlat_config *cfg = &ipxlat_lwt_state(lws)->config;
+	int eam_payload_size, eam_size, prefix_payload_size, size;
+
+	prefix_payload_size = nla_total_size(sizeof(struct in6_addr)) +
+			      nla_total_size(sizeof(u8));
+	size = nla_total_size(prefix_payload_size);
+	if (cfg->has_eam) {
+		eam_payload_size = nla_total_size(sizeof(__be32)) +
+				   nla_total_size(sizeof(u8)) +
+				   nla_total_size(sizeof(struct in6_addr)) +
+				   nla_total_size(sizeof(u8));
+		eam_size = nla_total_size(eam_payload_size);
+		size += nla_total_size(eam_size);
+	}
+
+	return size;
+}
+
+static int ipxlat_cmp_encap(struct lwtunnel_state *a, struct lwtunnel_state *b)
+{
+	const struct ipxlat_config *ac = &ipxlat_lwt_state(a)->config;
+	const struct ipxlat_config *bc = &ipxlat_lwt_state(b)->config;
+
+	if (ac->has_eam != bc->has_eam ||
+	    ac->rfc6052_prefix6.len != bc->rfc6052_prefix6.len ||
+	    !ipv6_addr_equal(&ac->rfc6052_prefix6.addr,
+			      &bc->rfc6052_prefix6.addr))
+		return 1;
+	if (!ac->has_eam)
+		return 0;
+	return ac->eam.prefix4.addr != bc->eam.prefix4.addr ||
+	       ac->eam.prefix4.len != bc->eam.prefix4.len ||
+	       ac->eam.prefix6.len != bc->eam.prefix6.len ||
+	       !ipv6_addr_equal(&ac->eam.prefix6.addr,
+			      &bc->eam.prefix6.addr);
+}
+
+/* Populate routing and XFRM selectors from the target-family packet.
+ * Fragmented packets deliberately use only addresses and protocol so every
+ * fragment follows the same policy.
+ */
+static void ipxlat_flowi4_selectors(const struct sk_buff *skb,
+				    struct flowi4 *fl4)
+{
+	struct flow_dissector_key_icmp icmp = {};
+	struct flow_keys keys;
+
+	/* classify the translated packet, not an encapsulated inner flow */
+	if (!skb_flow_dissect_flow_keys(skb, &keys,
+					FLOW_DISSECTOR_F_STOP_AT_ENCAP))
+		return;
+
+	fl4->flowi4_proto = keys.basic.ip_proto;
+	if (keys.control.flags & FLOW_DIS_IS_FRAGMENT)
+		return;
+
+	fl4->fl4_sport = keys.ports.src;
+	fl4->fl4_dport = keys.ports.dst;
+	if (keys.basic.ip_proto == IPPROTO_GRE) {
+		fl4->fl4_gre_key = keys.keyid.keyid;
+	} else if (keys.basic.ip_proto == IPPROTO_ICMP) {
+		/* the default flow-keys dissector does not collect ICMP data */
+		skb_flow_get_icmp_tci(skb, &icmp, skb->data,
+				      skb_transport_offset(skb),
+				      skb_headlen(skb));
+		fl4->fl4_icmp_type = icmp.type;
+		fl4->fl4_icmp_code = icmp.code;
+	}
+}
+
+static void ipxlat_flowi6_selectors(const struct sk_buff *skb,
+				    struct flowi6 *fl6)
+{
+	struct flow_dissector_key_icmp icmp = {};
+	struct flow_keys keys;
+
+	/* classify the translated packet, not an encapsulated inner flow */
+	if (!skb_flow_dissect_flow_keys(skb, &keys,
+					FLOW_DISSECTOR_F_STOP_AT_ENCAP))
+		return;
+
+	fl6->flowi6_proto = keys.basic.ip_proto;
+	if (keys.control.flags & FLOW_DIS_IS_FRAGMENT)
+		return;
+
+	fl6->fl6_sport = keys.ports.src;
+	fl6->fl6_dport = keys.ports.dst;
+	if (keys.basic.ip_proto == IPPROTO_GRE) {
+		fl6->fl6_gre_key = keys.keyid.keyid;
+	} else if (keys.basic.ip_proto == IPPROTO_ICMPV6) {
+		/* the default flow-keys dissector does not collect ICMP data */
+		skb_flow_get_icmp_tci(skb, &icmp, skb->data,
+				      skb_transport_offset(skb),
+				      skb_headlen(skb));
+		fl6->fl6_icmp_type = icmp.type;
+		fl6->fl6_icmp_code = icmp.code;
+	}
+}
+
+static struct dst_entry *ipxlat_route_output4(struct net *net,
+					      struct sk_buff *skb, kuid_t uid)
+{
+	struct iphdr *iph = ip_hdr(skb);
+	bool select_icmp_source;
+	struct flowi4 fallback;
+	struct flowi4 fl4 = {
+		.daddr = iph->daddr,
+		.flowi4_dscp = inet_dsfield_to_dscp(iph->tos),
+		.flowi4_proto = iph->protocol,
+		.flowi4_mark = skb->mark,
+		.flowi4_uid = uid,
+	};
+	struct rtable *rt;
+
+	/* The engine uses a dummy IPv4 address when translating ICMPv6 errors
+	 * with non-convertible source addresses. The route lookup replaces it
+	 * with a local IPv4 source when possible and falls back to
+	 * FLOWI_FLAG_ANYSRC otherwise.
+	 */
+	select_icmp_source = iph->saddr == htonl(INADDR_DUMMY) &&
+			     iph->protocol == IPPROTO_ICMP &&
+			     icmp_is_err(icmp_hdr(skb)->type);
+	fl4.saddr = select_icmp_source ? 0 : iph->saddr;
+	ipxlat_flowi4_selectors(skb, &fl4);
+	fallback = fl4;
+
+	/* the translated packet has no socket, so only global XFRM applies */
+	rt = ip_route_output_flow(net, &fl4, NULL);
+	if (unlikely(select_icmp_source && (IS_ERR(rt) || !fl4.saddr))) {
+		if (!IS_ERR(rt))
+			ip_rt_put(rt);
+
+		/* If routing cannot select a local IPv4 source address, send
+		 * the error from the reserved dummy address. FLOWI_FLAG_ANYSRC
+		 * permits that address even though it is not assigned locally.
+		 */
+		fl4 = fallback;
+		fl4.saddr = htonl(INADDR_DUMMY);
+		fl4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+		rt = ip_route_output_flow(net, &fl4, NULL);
+	}
+
+	if (IS_ERR(rt))
+		return ERR_CAST(rt);
+	if (unlikely(select_icmp_source)) {
+		iph->saddr = fl4.saddr;
+		ip_send_check(iph);
+	}
+	return &rt->dst;
+}
+
+static struct dst_entry *ipxlat_route_output6(struct net *net,
+					      struct sk_buff *skb, kuid_t uid)
+{
+	struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	struct dst_entry *dst;
+	struct flowi6 fl6 = {
+		.daddr = ip6h->daddr,
+		.saddr = ip6h->saddr,
+		.flowi6_proto = ip6h->nexthdr,
+		.flowi6_mark = skb->mark,
+		.flowi6_uid = uid,
+		/* translation currently leaves the Flow Label at zero, but
+		 * carrying the complete flowinfo also preserves Traffic Class
+		 */
+		.flowlabel = ip6_flowinfo(ip6h),
+	};
+
+	ipxlat_flowi6_selectors(skb, &fl6);
+	/* the translated packet has no socket, so only global XFRM applies */
+	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
+	return dst;
+}
+
+static int ipxlat_handoff_output(struct net *net, struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+	kuid_t uid;
+	int err;
+
+	/* route socketless translated output as normal kernel-originated
+	 * traffic
+	 */
+	uid = sock_net_uid(net, NULL);
+	if (skb->protocol == htons(ETH_P_IP))
+		dst = ipxlat_route_output4(net, skb, uid);
+	else
+		dst = ipxlat_route_output6(net, skb, uid);
+	if (IS_ERR(dst)) {
+		err = PTR_ERR(dst);
+		goto drop;
+	}
+
+	skb_dst_set(skb, dst);
+	if (skb->protocol == htons(ETH_P_IP))
+		return ip_local_out(net, NULL, skb);
+	return ip6_local_out(net, NULL, skb);
+
+drop:
+	kfree_skb(skb);
+	return err;
+}
+
+static void ipxlat_scrub_translated(struct sk_buff *skb)
+{
+	bool frag_source = false;
+	bool ignore_df = false;
+	int iif = skb->skb_iif;
+
+	if (skb->protocol == htons(ETH_P_IPV6)) {
+		ignore_df = skb->ignore_df;
+		frag_source = IP6CB(skb)->flags & IP6SKB_FRAG_SOURCE;
+	}
+
+	/* translation invalidates route, ct and other family-specific state */
+	skb_scrub_packet(skb, false);
+	skb_orphan(skb);
+	skb_set_queue_mapping(skb, 0);
+
+	/* skb->cb contains ipxlat parser state. The target-family stack reuses
+	 * it as IPCB/IP6CB, so clear it and restore only the ingress identity
+	 * and IPv6 fragment provenance that remain meaningful.
+	 */
+	skb->skb_iif = iif;
+	if (skb->protocol == htons(ETH_P_IP)) {
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	} else {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		if (frag_source)
+			IP6CB(skb)->flags |= IP6SKB_FRAG_SOURCE;
+	}
+	skb->ignore_df = ignore_df;
+}
+
+static int ipxlat_finish_error(struct sk_buff *skb,
+			       struct net_device *ingress_dev, int err)
+{
+	if (ingress_dev)
+		ipxlat_emit_icmp_error(ingress_dev, skb);
+	kfree_skb(skb);
+	return err;
+}
+
+static int ipxlat_lwt_input(struct sk_buff *skb)
+{
+	const struct lwtunnel_state *lws = skb_dst(skb)->lwtstate;
+	u8 cb_snapshot[sizeof_field(struct sk_buff, cb)];
+	struct net_device *ingress_dev = skb->dev;
+	const struct ipxlat_config *cfg;
+	struct net *net;
+	int ret;
+
+	/* in the input path, the packet must have been received by an iface */
+	if (unlikely(!ingress_dev)) {
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
+	net = dev_net(ingress_dev);
+	cfg = &ipxlat_lwt_state(lws)->config;
+
+	/* preparation owns skb->cb: preserve the receive metadata in case the
+	 * translator declines the packet and the original route handles it
+	 */
+	memcpy(cb_snapshot, skb->cb, sizeof(cb_snapshot));
+	ret = ipxlat_prepare(cfg, skb);
+	if (ret == -EOPNOTSUPP) {
+		/* let the stack handle unsupported packets */
+		memcpy(skb->cb, cb_snapshot, sizeof(cb_snapshot));
+		return lws->orig_input(skb);
+	}
+	if (ret)
+		return ipxlat_finish_error(skb, ingress_dev, ret);
+
+	ret = ipxlat_translate(cfg, net, skb);
+	if (ret)
+		return ipxlat_finish_error(skb, ingress_dev, ret);
+
+	ipxlat_scrub_translated(skb);
+	if (skb->protocol == htons(ETH_P_IP))
+		return ip_rcv_lwt(skb);
+	return ip6_rcv_lwt(skb);
+}
+
+static int ipxlat_lwt_output(struct net *net, struct sock *sk,
+			     struct sk_buff *skb)
+{
+	struct net_device *ingress_dev = skb->skb_iif ? skb->dev : NULL;
+	u8 cb_snapshot[sizeof_field(struct sk_buff, cb)];
+	const struct dst_entry *dst = skb_dst(skb);
+	struct lwtunnel_state *lws = dst->lwtstate;
+	const struct ipxlat_config *cfg;
+	int ret;
+
+	cfg = &ipxlat_lwt_state(lws)->config;
+
+	/* preparation owns skb->cb: preserve the receive metadata in case the
+	 * translator declines the packet and the original route handles it
+	 */
+	memcpy(cb_snapshot, skb->cb, sizeof(cb_snapshot));
+	ret = ipxlat_prepare(cfg, skb);
+	if (ret == -EOPNOTSUPP) {
+		/* let the stack handle unsupported packets */
+		memcpy(skb->cb, cb_snapshot, sizeof(cb_snapshot));
+		return lws->orig_output(net, sk, skb);
+	}
+	if (ret)
+		return ipxlat_finish_error(skb, ingress_dev, ret);
+
+	ret = ipxlat_translate(cfg, net, skb);
+	if (ret)
+		return ipxlat_finish_error(skb, ingress_dev, ret);
+
+	ipxlat_scrub_translated(skb);
+	return ipxlat_handoff_output(net, skb);
+}
+
+static const struct lwtunnel_encap_ops ipxlat_lwt_ops = {
+	.build_state = ipxlat_build_state,
+	.output = ipxlat_lwt_output,
+	.input = ipxlat_lwt_input,
+	.fill_encap = ipxlat_fill_encap,
+	.get_encap_size = ipxlat_get_encap_size,
+	.cmp_encap = ipxlat_cmp_encap,
+	.owner = THIS_MODULE,
+};
+
+static int __init ipxlat_lwt_init(void)
+{
+	return lwtunnel_encap_add_ops(&ipxlat_lwt_ops, LWTUNNEL_ENCAP_IPXLAT);
+}
+module_init(ipxlat_lwt_init);
+
+static void __exit ipxlat_lwt_exit(void)
+{
+	lwtunnel_encap_del_ops(&ipxlat_lwt_ops, LWTUNNEL_ENCAP_IPXLAT);
+}
+module_exit(ipxlat_lwt_exit);
+
+MODULE_ALIAS_RTNL_LWT(IPXLAT);
+MODULE_DESCRIPTION("IPv6<>IPv4 translation lightweight tunnel (SIIT)");
+MODULE_LICENSE("GPL");
-- 
2.55.0

