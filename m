Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B634FD7AD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015888; cv=none; b=g3MMwR2+wCXE4u5R/R73FkHChez7YZejCoJdzgJIltBe+COCuo65t4QEQrHITFcNFhlIVzA8t64IbkHKNM/9ozs4JF0KO32WMtsCU3zC0VwcPs4vyCMKHwN8FsPRKephu4SuaqPD75yOACbyvqQEb7KptK1OWO0XrIewYznnn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015888; c=relaxed/simple;
	bh=Tn5POOHoCyG9SsUvOtunIPwz/blWQ8dfDDO7sFhggr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0H6dXP9zpBUtZI7mmZEEI+ttYjcJ0r7VJnoWZyEV1/akBIgM5V1+MY+LwRAlSgdbmWX+CS8tIESDZlA5d74NL4ct+SdLlV7/5ydiCcdiC7YJuZYnAJdxw5kvFtThGy/0YV8gwkdz5TNkUDbQwda94vhsEz2OpVIZIdDkaOY3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVDLmjXB; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVDLmjXB"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91242b356cbso43241256d6.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015885; x=1790620685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKN7CzkO9lFovuX2pRaQMLbqlIom1lAMJF56n9eP1YQ=;
        b=uVDLmjXBJSqFumk0IsnhOFxxCVDZ7LySp2qlRVLepBuzywn7cQ8xS9Zo1oCTaJbUGl
         wySyrFDHZlOINz74fruDTbn+p38lhNSF2w/FEZXNh+KzOBWKa0wqQj2SDL6mqFwFEvA/
         zKxZb+YuoULmXI42TaicXDl1D7u6vvXmI95nXQ/2d9G/0QMIjNOQEVrXxlXnKjc4gjGM
         3EBLaamYP+c7NC9Xlau3sKjOskz755wZUmJ8eI6N3yR/6xYOWNG8zgXpcNi11tYoElvx
         4zNhMLkC+VD90Ht/GFTi8fnDCrkB82veT7riYG3KSKIEq85d4WpGNr0dLsjWXD0w9D0R
         bWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015885; x=1790620685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKN7CzkO9lFovuX2pRaQMLbqlIom1lAMJF56n9eP1YQ=;
        b=XxKKweLyEI6Fkgj14WFL64bRSKYXieCfADqYD9sAbPXHhqRMfROy7i1TBuhuszcaxK
         e0tklvDi35SGododLwpsBtF/az7VbIaj4H6PEiu/C8fSDV3+A8oTh0FJqsXaZWswQTUK
         fzdONytxmGImaIB/sKtyfhQJLprktT6T+BUeTof56KgFLWNET2FuPJFGgm9Ek+4Oe5NR
         aUziAvIIwT+od8qIeBS7INnCoX+v4hjS69jZ1oQrwN2tmf7+41XFPNXdMgrBadGAteeR
         EvSDdR+7bo8tZodz1jTW2sf7bwW0Be52PrAwdBxThB1MUWaASaoVLsoeQc0wbl7BRSt3
         igpA==
X-Forwarded-Encrypted: i=1; AKwUvBw+vQHrsUb/MLBrm9/ajEpRqy/RJCt8nt9wxYx5/98eHwIXYKjFrHz+kvlbMeVnntVn/XBXRqs=@vger.kernel.org
X-Gm-Message-State: AFuF++n01AUxFjMfUwDQ7WXfBsfcVVtrtOOIFGQM851lG6iEJFGUQpwt
	dmLjWS4iaBVX4zTmWNuZRYsrx8JWdsAb8DSoU4Mqld1AFyJ1mvOAuTLtnL7jFU4InWtofBfRmnP
	y41FYJSOCEttTEQ==
X-Received: from qvil7.prod.google.com ([2002:a0c:d6c7:0:b0:912:5076:669c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3d0c:b0:90c:ea32:738e with SMTP id 6a1803df08f44-913fc8d974emr20850876d6.23.1790015884424;
 Mon, 21 Sep 2026 11:38:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:56 +0000
In-Reply-To: <20260921183758.1812310-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] net: ethtool: add KUnit tests for the generated
 RSS key
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Check the property from the definition of the Toeplitz hash, independently
of the way netdev_rss_key_init() achieves it: an aligned block of 2^q
consecutive values of one field has to land on the 2^q queues exactly once
each.

Four checks and a control. rss_key_property_test() does the algebra for
the named fields of the usual hash inputs, rss_key_grid_test() sweeps every
16-bit aligned position of the key, since the generator does not get to
know the layout the hardware uses, and rss_key_spread_test() hashes the
inputs of an actual burst and looks at where they land. The control,
rss_key_checker_test(), feeds degenerate keys to the rank check so that a
check accepting everything cannot make the others pass.

rss_key_alias_test() covers the other half of what the generator promises,
that no two input bits read the same 32-bit key window and are therefore
indistinguishable to the hash. It sorts the windows instead of comparing
them pairwise, so unlike netdev_rss_key_init() it looks at every distance
rather than at the multiples of 16 alone.

The field table includes a PSP over UDP over IPv6 layout, whose inner TCP
ports sit far past the plain 4-tuple, because that is the case the offsets
of the standard layouts do not cover.

Commenting out the fixup makes three of the five cases fail and leaves the
control passing. Keeping the fixup but skipping the redraw fails
rss_key_alias_test alone.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/Kconfig                |  14 ++
 net/ethtool/Makefile       |   2 +
 net/ethtool/common.h       |  11 ++
 net/ethtool/ioctl.c        |   5 +-
 net/ethtool/rss_key_test.c | 314 +++++++++++++++++++++++++++++++++++++
 5 files changed, 344 insertions(+), 2 deletions(-)
 create mode 100644 net/ethtool/rss_key_test.c

diff --git a/net/Kconfig b/net/Kconfig
index e384773935515d54ab05ec71b3d2792347428ad7..4a8dc0e5b075a1b1c535d940a80cb8976fe47694 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -540,4 +540,18 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ETHTOOL_RSS_KEY_KUNIT_TEST
+	tristate "KUnit tests for the generated RSS key" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests checking the RSS key that netdev_rss_key_fill() hands
+	  to the drivers: flows differing only in the low order bits of one
+	  hashed header field have to spread over all the RX queues, for
+	  every field of the Toeplitz hash inputs, for every 16-bit aligned
+	  position of the key, and for every queue count up to
+	  2 ** NETDEV_RSS_KEY_QMAX.
+
+	  If unsure, say N.
+
 endif   # if NET
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 629c10916670ecc2dc5f3dbb7091c1c126679975..6588cfe652810e3bbbcc78185ad1a8bd68ae92e5 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -10,3 +10,5 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
 		   phy.o tsconfig.o mse.o
+
+obj-$(CONFIG_ETHTOOL_RSS_KEY_KUNIT_TEST)	+= rss_key_test.o
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 4e5356e26f400aa0a303e54c072bc0119f11513b..c1b6191f456935d2e3994ac6e12605e1f30693d4 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -15,6 +15,17 @@
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 #define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
 
+/* netdev_rss_key_fill() guarantees that flows differing only in the low order
+ * bits of one hashed header field spread over all the RX queues, for any queue
+ * count up to 2 ** NETDEV_RSS_KEY_QMAX and any 16-bit aligned field of the
+ * hash input. See netdev_rss_key_init().
+ */
+#define NETDEV_RSS_KEY_QMAX	8
+
+#if IS_ENABLED(CONFIG_KUNIT)
+void netdev_rss_key_init(u8 *key, size_t len);
+#endif
+
 struct genl_info;
 struct hwtstamp_provider_desc;
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index bdc40cfd27217d85b4aa2ac93d0b70fc8d22371a..e625175ed1cbdd540e290967ece2d0bdaab1b00f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -31,6 +31,7 @@
 #include <linux/unaligned.h>
 #include <linux/utsname.h>
 #include <linux/ethtool_netlink.h>
+#include <kunit/visibility.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
 #include <net/flow_offload.h>
@@ -1334,7 +1335,6 @@ bool netdev_rss_key_initialized __read_mostly;
  * NETDEV_RSS_KEY_QMAX is both enough for 256 queues and the largest value
  * keeping the ranges of two adjacent positions disjoint.
  */
-#define NETDEV_RSS_KEY_QMAX	8
 #define NETDEV_RSS_KEY_SPAN	(2 * NETDEV_RSS_KEY_QMAX - 1)
 
 static bool netdev_rss_key_bit(const u8 *key, unsigned int bit)
@@ -1444,7 +1444,7 @@ static bool netdev_rss_key_aliases(const u8 *key, unsigned int bits)
 	return false;
 }
 
-static void netdev_rss_key_init(u8 *key, size_t len)
+VISIBLE_IF_KUNIT void netdev_rss_key_init(u8 *key, size_t len)
 {
 	unsigned int lsb, bits = len * BITS_PER_BYTE;
 
@@ -1469,6 +1469,7 @@ static void netdev_rss_key_init(u8 *key, size_t len)
 	smp_wmb();
 	WRITE_ONCE(netdev_rss_key_initialized, true);
 }
+EXPORT_SYMBOL_IF_KUNIT(netdev_rss_key_init);
 
 void netdev_rss_key_fill(void *buffer, size_t len)
 {
diff --git a/net/ethtool/rss_key_test.c b/net/ethtool/rss_key_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..1a583f2930c5ba92a64a349c291bb6922c44998d
--- /dev/null
+++ b/net/ethtool/rss_key_test.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Tests for the RSS key generated by netdev_rss_key_fill().
+ *
+ * The property under test is that flows differing only in the low order bits
+ * of one hashed header field land on distinct RX queues. It is checked here
+ * from the definition of the Toeplitz hash, independently of the way
+ * netdev_rss_key_init() achieves it.
+ */
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/sort.h>
+
+#include "common.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/* Longest hash input exercised here: an IPv6 header, a UDP header, a PSP
+ * header and the inner TCP ports. See rss_key_test_fields[].
+ */
+#define RSS_KEY_TEST_INPUT_LEN		68
+
+#define RSS_KEY_TEST_KEYS		32
+
+/* Number of queue counts exercised end to end by rss_key_spread_test(), which
+ * hashes 2 ** q inputs for each of them. The algebraic check covers all the
+ * queue counts up to NETDEV_RSS_KEY_QMAX.
+ */
+#define RSS_KEY_TEST_SPREAD_QMAX	6
+
+/* Position of the least significant bit of each field, counting from the most
+ * significant bit of the hash input, and the length of that input. These come
+ * from the definition of the hash, not from the key generator.
+ */
+static const struct rss_key_test_field {
+	const char	*name;
+	unsigned int	lsb;
+	unsigned int	nbits;
+} rss_key_test_fields[] = {
+	{ "IPv4 saddr",		31,	96 },
+	{ "IPv4 daddr",		63,	96 },
+	{ "IPv4 sport",		79,	96 },
+	{ "IPv4 dport",		95,	96 },
+	{ "IPv6 saddr",		127,	288 },
+	{ "IPv6 daddr",		255,	288 },
+	{ "IPv6 sport",		271,	288 },
+	{ "IPv6 dport",		287,	288 },
+	/* Hardware is free to hash an encapsulated header instead, and then
+	 * it reads the key far past the 40 bytes an IPv6 4-tuple needs. These
+	 * offsets are those of PSP transport mode over UDP over IPv6
+	 * (Documentation/networking/psp.rst): 40 bytes of IPv6, 8 of UDP,
+	 * PSP_HDR_SIZE of PSP, then the inner TCP ports. Prepending an
+	 * Ethernet header, or the 4 extra bytes of an encapsulation tag,
+	 * shifts all of this by a whole number of 16-bit units.
+	 */
+	{ "PSP outer IPv6 saddr",	191,	544 },
+	{ "PSP outer IPv6 daddr",	319,	544 },
+	{ "PSP inner sport",		527,	544 },
+	{ "PSP inner dport",		543,	544 },
+};
+
+static bool rss_key_test_bit(const u8 *buf, unsigned int bit)
+{
+	return buf[bit / BITS_PER_BYTE] & (0x80 >> (bit % BITS_PER_BYTE));
+}
+
+static void rss_key_test_assign_bit(u8 *buf, unsigned int bit, bool value)
+{
+	u8 mask = 0x80 >> (bit % BITS_PER_BYTE);
+
+	if (value)
+		buf[bit / BITS_PER_BYTE] |= mask;
+	else
+		buf[bit / BITS_PER_BYTE] &= ~mask;
+}
+
+/* The 32 key bits starting at @bit, which is what input bit @bit contributes
+ * to the hash.
+ */
+static u32 rss_key_test_window(const u8 *key, unsigned int bit)
+{
+	u32 window = 0;
+	unsigned int i;
+
+	for (i = 0; i < 32; i++)
+		window = (window << 1) | rss_key_test_bit(key, bit + i);
+
+	return window;
+}
+
+static u32 rss_key_test_toeplitz(const u8 *key, const u8 *input,
+				 unsigned int nbits)
+{
+	u32 hash = 0;
+	unsigned int i;
+
+	for (i = 0; i < nbits; i++)
+		if (rss_key_test_bit(input, i))
+			hash ^= rss_key_test_window(key, i);
+
+	return hash;
+}
+
+/* Is the map from the q low order bits of the field at @lsb to the q low order
+ * bits of the hash a bijection? Gaussian elimination over GF(2) on the q
+ * windows involved, reduced to their q low order bits.
+ */
+static bool rss_key_test_full_rank(const u8 *key, unsigned int lsb,
+				   unsigned int q)
+{
+	u32 basis[NETDEV_RSS_KEY_QMAX] = {};
+	unsigned int j;
+
+	for (j = 0; j < q; j++) {
+		u32 v = rss_key_test_window(key, lsb - j) & (BIT(q) - 1);
+
+		while (v) {
+			unsigned int b = __ffs(v);
+
+			if (!basis[b]) {
+				basis[b] = v;
+				break;
+			}
+			v ^= basis[b];
+		}
+
+		if (!v)
+			return false;
+	}
+
+	return true;
+}
+
+/* Degenerate keys the rank check must reject, so that a check accepting
+ * everything can not make the other tests pass.
+ */
+static void rss_key_checker_test(struct kunit *test)
+{
+	u8 *key = kunit_kzalloc(test, NETDEV_RSS_KEY_LEN, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, key);
+
+	/* All the windows are zero. */
+	KUNIT_EXPECT_FALSE(test, rss_key_test_full_rank(key, 31, 1));
+
+	/* All the windows are equal, which is enough for one queue only. */
+	memset(key, 0xff, NETDEV_RSS_KEY_LEN);
+	KUNIT_EXPECT_TRUE(test, rss_key_test_full_rank(key, 31, 1));
+	KUNIT_EXPECT_FALSE(test, rss_key_test_full_rank(key, 31, 2));
+}
+
+static void rss_key_property_test(struct kunit *test)
+{
+	u8 *key = kunit_kzalloc(test, NETDEV_RSS_KEY_LEN, GFP_KERNEL);
+	unsigned int i, j, q;
+
+	KUNIT_ASSERT_NOT_NULL(test, key);
+
+	for (i = 0; i < RSS_KEY_TEST_KEYS; i++) {
+		netdev_rss_key_init(key, NETDEV_RSS_KEY_LEN);
+
+		for (j = 0; j < ARRAY_SIZE(rss_key_test_fields); j++) {
+			const struct rss_key_test_field *f;
+
+			f = &rss_key_test_fields[j];
+
+			for (q = 1; q <= NETDEV_RSS_KEY_QMAX; q++)
+				KUNIT_ASSERT_TRUE_MSG(test,
+						      rss_key_test_full_rank(key, f->lsb, q),
+						      "%s does not spread over %u queues",
+						      f->name, 1U << q);
+		}
+	}
+}
+
+/* rss_key_test_fields[] can only list the layouts somebody thought of, but
+ * the generator does not get to know what the hardware hashes. Sweep the
+ * whole key instead: the property has to hold at every 16-bit aligned
+ * position, which is where a field of any layout can end.
+ */
+static void rss_key_grid_test(struct kunit *test)
+{
+	unsigned int bits = NETDEV_RSS_KEY_LEN * BITS_PER_BYTE;
+	u8 *key = kunit_kzalloc(test, NETDEV_RSS_KEY_LEN, GFP_KERNEL);
+	unsigned int i, lsb, q;
+
+	KUNIT_ASSERT_NOT_NULL(test, key);
+
+	for (i = 0; i < RSS_KEY_TEST_KEYS; i++) {
+		netdev_rss_key_init(key, NETDEV_RSS_KEY_LEN);
+
+		for (lsb = 15; lsb + 32 <= bits; lsb += 16)
+			for (q = 1; q <= NETDEV_RSS_KEY_QMAX; q++)
+				KUNIT_ASSERT_TRUE_MSG(test,
+						      rss_key_test_full_rank(key, lsb, q),
+						      "field ending at bit %u does not spread over %u queues",
+						      lsb, 1U << q);
+	}
+}
+
+static int rss_key_test_cmp(const void *a, const void *b)
+{
+	u32 x = *(const u32 *)a, y = *(const u32 *)b;
+
+	return x < y ? -1 : x > y;
+}
+
+/* Two input bits contributing the same 32-bit window are indistinguishable
+ * to the hash: flipping both of them leaves it unchanged, so the flows of a
+ * burst differing in exactly those two bits all collide. A uniformly random
+ * key has such a pair with probability 2 ** -11, and the generated key must
+ * not do worse.
+ *
+ * netdev_rss_key_init() redraws on a collision at a distance that is a
+ * multiple of 8, which is where the fixup makes one likely, and leaves every
+ * other distance at the odds of a random key. So assert on what it
+ * guarantees: group the windows by their offset modulo 8 and sort each group
+ * on its own. Sorting all of them together instead would be asserting on the
+ * random odds, and would fail about one run in 26 on a correct kernel.
+ */
+static void rss_key_alias_test(struct kunit *test)
+{
+	unsigned int count = NETDEV_RSS_KEY_LEN * BITS_PER_BYTE - 31;
+	u8 *key = kunit_kzalloc(test, NETDEV_RSS_KEY_LEN, GFP_KERNEL);
+	unsigned int i, j, n, r;
+	u32 *windows;
+
+	windows = kunit_kcalloc(test, count, sizeof(*windows), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, key);
+	KUNIT_ASSERT_NOT_NULL(test, windows);
+
+	for (i = 0; i < RSS_KEY_TEST_KEYS; i++) {
+		netdev_rss_key_init(key, NETDEV_RSS_KEY_LEN);
+
+		for (r = 0; r < 8; r++) {
+			n = 0;
+			for (j = r; j < count; j += 8)
+				windows[n++] = rss_key_test_window(key, j);
+
+			sort(windows, n, sizeof(*windows),
+			     rss_key_test_cmp, NULL);
+
+			for (j = 1; j < n; j++)
+				KUNIT_ASSERT_NE_MSG(test, windows[j],
+						    windows[j - 1],
+						    "two input bits a multiple of 8 apart read the same key window %08x",
+						    windows[j]);
+		}
+	}
+}
+
+/* Hash the inputs of a burst differing only in the low order bits of one
+ * field, and check that they fill the indirection table evenly.
+ */
+static void rss_key_spread_test(struct kunit *test)
+{
+	u8 *key = kunit_kzalloc(test, NETDEV_RSS_KEY_LEN, GFP_KERNEL);
+	u8 *input = kunit_kzalloc(test, RSS_KEY_TEST_INPUT_LEN, GFP_KERNEL);
+	unsigned int i, j, q;
+
+	KUNIT_ASSERT_NOT_NULL(test, key);
+	KUNIT_ASSERT_NOT_NULL(test, input);
+
+	netdev_rss_key_init(key, NETDEV_RSS_KEY_LEN);
+
+	for (i = 0; i < ARRAY_SIZE(rss_key_test_fields); i++) {
+		const struct rss_key_test_field *f = &rss_key_test_fields[i];
+
+		for (q = 1; q <= RSS_KEY_TEST_SPREAD_QMAX; q++) {
+			u64 seen = 0;
+
+			get_random_bytes(input, RSS_KEY_TEST_INPUT_LEN);
+
+			for (j = 0; j < (1U << q); j++) {
+				unsigned int t, queue;
+				u32 hash;
+
+				for (t = 0; t < q; t++)
+					rss_key_test_assign_bit(input,
+								f->lsb - t,
+								j & BIT(t));
+
+				hash = rss_key_test_toeplitz(key, input,
+							     f->nbits);
+				queue = hash & (BIT(q) - 1);
+
+				KUNIT_ASSERT_FALSE_MSG(test, seen & BIT_ULL(queue),
+						       "%s hits queue %u twice out of %u",
+						       f->name, queue, 1U << q);
+				seen |= BIT_ULL(queue);
+			}
+		}
+	}
+}
+
+static struct kunit_case rss_key_test_cases[] = {
+	KUNIT_CASE(rss_key_checker_test),
+	KUNIT_CASE(rss_key_property_test),
+	KUNIT_CASE(rss_key_grid_test),
+	KUNIT_CASE(rss_key_alias_test),
+	KUNIT_CASE(rss_key_spread_test),
+	{},
+};
+
+static struct kunit_suite rss_key_test_suite = {
+	.name = "ethtool-rss-key",
+	.test_cases = rss_key_test_cases,
+};
+
+kunit_test_suite(rss_key_test_suite);
+
+MODULE_DESCRIPTION("Tests for the RSS key generated by netdev_rss_key_fill()");
+MODULE_LICENSE("GPL");
-- 
2.55.0.1082.g2b9226bbc0-goog

