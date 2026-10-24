Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833977;
	b=ZuV/2i4HswReb8HYXhp6puV6VD0igs2gESfnSnIf/b0FGvh/zPJbAwRF77SyiRKCoxxS
	 gV9j7DJgLDe0LOkh3HYTkfDJ8SzBQf1Y658tBp9JZiR7XZqOz/ya45regVbRRntlwtCtt
	 05OtRoFCe+UibO89JzyXnaSR2uDKN/hNXfoUj68OL+f30zoUGF2VMFFAObSHzCgjhQAEf
	 VL8eyCeo6Bn9zfuQs/2sm8hu/LoYzeIVWJG+Y3Nl9PpYNKRudw36JDIB3aEQv9SD0O9Ox
	 62GGlSMFbiE0wt8VpM094m8FJ4xLCv05JzD3j79AJ9LNZJGn5uG8binwsBL8Vrw1m/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833977;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=/iAARVQBV9kP2SynQHyp3MrEjyNiz12BEAt6nvdrBlk=;
	b=0/3lGxq2faiZY4yJPl9kbau3PZW/nteXj/b39urMmNISW2Up1d8WpmC4VaKQwI7B7aHM
	 bB0y3UVdM8ibqLGkFgOj9mDRIOlKfO0J/pcu5qd8mUji5AXmPbH+5QQpOb3V9d1nI+Ngy
	 EW/VVIs2VHWrp3xBBXB1BBcLEyZ4Q7uuJxhZAnHHyj57LKSmSO3htIIUtxwZK2RmPnAdd
	 0n9L+f6Ma/CULmQnyU6hfCpqcWtLmlLgUwtIc/5gPM3B2QVt4CugsvTfny/PPSl/bZSnp
	 Keh5v0NxcrPF9ImpjhWdcw9NQCnvRly9RydQ9eDy3LHWoqplyurmPovWufWTBoM2Vnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Q4PFMJCv;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA1606A323;
	Sat, 24 Oct 2026 09:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CA1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Q4PFMJCv
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jBZJH2bTLz5wnn;
	Sat, 24 Oct 2026 11:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iAARVQBV9kP2SynQHyp3MrEjyNiz12BEAt6nvdrBlk=;
	b=Q4PFMJCvPZTxlo98i7xj6Cf90ZcOZc7Q+/CBNLEUrRhbwJ1wS83ZFS1D/GoRljgTLwDK5D
	Y36iszgd8yIa6QM0Wn7WlLxX14nQfwp4lQHmUBNA2VgqWm+ZlI99XQUmjG8sdxqrIcETBD
	YpDwuIJwehlfb+lI3WHYLJCpQ2C9SxHyZwbh69Kp66kn8nh6fZzjAFmhjSOZIaJ1pm4Eyn
	aNj35ZapaN/0LDMx0lXLkJ44XK4AHXNdSia/XdH2I1QUiinoVqXtbzk39ri65hZTY3PQnh
	VHXyNeyL+kLNJF4JogzzvbDOpjGwL51iEVyBrICCH61D+0wYuEr+87Ptscr7CA==
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
Subject: [RFC net-next v2 05/18] net: ipxlat: add engine skeleton and configuration model
Date: Sat, 24 Oct 2026 11:25:15 +0200
Message-ID: <20261024092532.172005-6-ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jBZJH2bTLz5wnn

Add the reusable ipxlat module, immutable RFC 6052/EAM configuration
structures and validation helpers. Attachment-specific configuration
is intentionally left for a later patch.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-2-ralf@mandelbit.com/
- Move ipxlat from drivers/net to net/ipxlat, remove the virtual
  netdevice and generic-netlink control plane, and make the engine
  independent of any attachment. (Toke)
- Replace mutable per-device values with validated immutable RFC 6052
  and EAM configuration structures supplied by the caller.

 include/net/ipxlat.h | 66 +++++++++++++++++++++++++++++++++++
 net/Kconfig          |  1 +
 net/Makefile         |  1 +
 net/ipxlat/Kconfig   | 14 ++++++++
 net/ipxlat/Makefile  |  8 +++++
 net/ipxlat/config.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipxlat/core.c    | 17 +++++++++
 7 files changed, 189 insertions(+)
 create mode 100644 include/net/ipxlat.h
 create mode 100644 net/ipxlat/Kconfig
 create mode 100644 net/ipxlat/Makefile
 create mode 100644 net/ipxlat/config.c
 create mode 100644 net/ipxlat/core.c

diff --git a/include/net/ipxlat.h b/include/net/ipxlat.h
new file mode 100644
index 000000000000..6b8efb2669b8
--- /dev/null
+++ b/include/net/ipxlat.h
@@ -0,0 +1,66 @@
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
+#ifndef _NET_IPXLAT_H_
+#define _NET_IPXLAT_H_
+
+#include <linux/in6.h>
+#include <linux/types.h>
+
+struct ipxlat_prefix4 {
+	__be32 addr;
+	u8 len;
+};
+
+struct ipxlat_prefix6 {
+	struct in6_addr addr;
+	u8 len;
+};
+
+struct ipxlat_eam {
+	struct ipxlat_prefix4 prefix4;
+	struct ipxlat_prefix6 prefix6;
+};
+
+/**
+ * struct ipxlat_config - immutable translation configuration
+ * @rfc6052_prefix6: RFC 6052 fallback prefix
+ * @has_eam: whether @eam is present
+ * @eam: optional RFC 7757 explicit address mapping
+ */
+struct ipxlat_config {
+	struct ipxlat_prefix6 rfc6052_prefix6;
+	bool has_eam;
+	struct ipxlat_eam eam;
+};
+
+/**
+ * ipxlat_prefix6_len_valid - check an RFC 6052 prefix length
+ * @len: prefix length in bits
+ *
+ * Return: true when @len is one of the RFC 6052 prefix lengths.
+ */
+bool ipxlat_prefix6_len_valid(u8 len);
+
+/**
+ * ipxlat_config_validate - validate a complete translation configuration
+ * @cfg: configuration to validate
+ *
+ * If present, the EAM's IPv6 prefix must provide enough host bits for its IPv4
+ * prefix.
+ *
+ * Return: 0 when valid, otherwise a negative errno.
+ */
+int ipxlat_config_validate(const struct ipxlat_config *cfg);
+
+#endif /* _NET_IPXLAT_H_ */
diff --git a/net/Kconfig b/net/Kconfig
index 76ab44aa439a..c4d8b9a707aa 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -135,6 +135,7 @@ config INET
 if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"
+source "net/ipxlat/Kconfig"
 source "net/netlabel/Kconfig"
 source "net/mptcp/Kconfig"
 
diff --git a/net/Makefile b/net/Makefile
index 5b2dd7f07a85..ea92d88706e3 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
 obj-$(CONFIG_INET_PSP)		+= psp/
 obj-y				+= ipv6/
+obj-$(CONFIG_NET_IPXLAT)	+= ipxlat/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
 obj-$(CONFIG_BRIDGE)		+= bridge/
diff --git a/net/ipxlat/Kconfig b/net/ipxlat/Kconfig
new file mode 100644
index 000000000000..6b0e47f8ce90
--- /dev/null
+++ b/net/ipxlat/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# IPXLAT - Stateless IP/ICMP Translation (SIIT)
+#
+
+config NET_IPXLAT
+	tristate "IPv6<>IPv4 packet translation engine (SIIT)"
+	depends on IPV6
+	help
+	  Reusable stateless IP/ICMP packet translation engine implementing
+	  RFC 7915. Useful for IPv6 focused networks. Particularly NAT64,
+	  SIIT-DC, 464XLAT network architectures.
+
+	  To compile this engine as a module, choose M here.
diff --git a/net/ipxlat/Makefile b/net/ipxlat/Makefile
new file mode 100644
index 000000000000..47d00b7b05bb
--- /dev/null
+++ b/net/ipxlat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) engine
+
+obj-$(CONFIG_NET_IPXLAT) += ipxlat.o
+
+ipxlat-objs += config.o
+ipxlat-objs += core.o
diff --git a/net/ipxlat/config.c b/net/ipxlat/config.c
new file mode 100644
index 000000000000..06bd6fdc6c21
--- /dev/null
+++ b/net/ipxlat/config.c
@@ -0,0 +1,82 @@
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
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/module.h>
+#include <net/ipv6.h>
+
+#include <net/ipxlat.h>
+
+bool ipxlat_prefix6_len_valid(u8 len)
+{
+	switch (len) {
+	case 32:
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 96:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(ipxlat_prefix6_len_valid);
+
+static bool ipxlat_v4_prefix_canonical(const struct ipxlat_prefix4 *prefix)
+{
+	__be32 mask = inet_make_mask(prefix->len);
+
+	return (prefix->addr & mask) == prefix->addr;
+}
+
+static bool ipxlat_v6_prefix_canonical(const struct ipxlat_prefix6 *prefix)
+{
+	struct in6_addr masked = prefix->addr;
+
+	ipv6_addr_prefix(&masked, &prefix->addr, prefix->len);
+	return ipv6_addr_equal(&masked, &prefix->addr);
+}
+
+int ipxlat_config_validate(const struct ipxlat_config *cfg)
+{
+	u8 host4, host6;
+
+	if (!ipxlat_prefix6_len_valid(cfg->rfc6052_prefix6.len))
+		return -EINVAL;
+	if (!ipxlat_v6_prefix_canonical(&cfg->rfc6052_prefix6))
+		return -EINVAL;
+	if (cfg->rfc6052_prefix6.addr.s6_addr[8])
+		return -EINVAL;
+
+	if (!cfg->has_eam)
+		return 0;
+
+	if (cfg->eam.prefix4.len > 32 || cfg->eam.prefix6.len > 128)
+		return -EINVAL;
+	if (!ipxlat_v4_prefix_canonical(&cfg->eam.prefix4) ||
+	    !ipxlat_v6_prefix_canonical(&cfg->eam.prefix6))
+		return -EINVAL;
+
+	host4 = 32 - cfg->eam.prefix4.len;
+	host6 = 128 - cfg->eam.prefix6.len;
+	/* every IPv4 host bit must fit into the mapped IPv6 host space */
+	if (host4 > host6)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipxlat_config_validate);
diff --git a/net/ipxlat/core.c b/net/ipxlat/core.c
new file mode 100644
index 000000000000..85037446291e
--- /dev/null
+++ b/net/ipxlat/core.c
@@ -0,0 +1,17 @@
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
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("IPv6<>IPv4 stateless translation engine (SIIT)");
+MODULE_LICENSE("GPL");
-- 
2.55.0

