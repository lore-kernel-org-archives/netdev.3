Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E87568FD9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094906; cv=none; b=I9uki6nUdTDk041II4OhFT8Vq0RBhQCECY+lJK/x3NJ76+VZX/SzLhz/Kz0Yl3/yoQcy/7tyAtp5CSb0BtKQKab25R3U4fMnyeIpKv/UCrsVrhYR0hSr8Q4p3ytc2lkj+DUn2mfHTgrKYPcEptteQqzbtjPEG8pVDwEmfHuSbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094906; c=relaxed/simple;
	bh=PBex7yDO2Mhw/Nvi3StSFK43hHFvsoBg3fE9B3wBgME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oRDPbb+W6e3a6IjceWxt5InAT6abrlxJSFfg2FzRakO4soCssLkzWszal+lyk7S0EgER6tWwWCKVoCjXYEaJr8T2AH3pDmvBOD6SxUBIVx4x+1/f/nqYapDzj4HJvg/Hrrd6iwBEkH7c6uvsoVkAKqknlzkvBoWIZrXlDmipqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdNQQ1iW; arc=none smtp.client-ip=209.85.222.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdNQQ1iW"
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso815819241.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790094902; x=1790699702; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2KG7WoqL6MDUfFcY9UDQ2lZC9iYeBArJH1WfhGL2AE=;
        b=CdNQQ1iWp1SUbS/rXh6tcugJ52GUvFBUSrgZzvDE/0EgNw5GD5Mz9MUiG4IWiiCcRY
         uSGg9CE4cqdTtNt7tDO7VpobCHnC1KzbrcrfqJd3d/a54HGMKGBiX0OJEGN9hMrO3V0n
         1PmUVreScXMHnrmf0hSixNIpeXKNhBkGbq8wb6j7ZRf87Cvv0FCaSFu93WfQn2+rXSPi
         AAfRRixpccgTYd6zKGyMWG/Jw2GulGJpjVPnJ41TTgj7JHwl6pTQiX2NljN0bcZhwKAG
         +vcrCdcTl/hUdP0gxB7M4AI+9FM+QHoY5P+GzwTC7IeFU6djJXUbOj4APHdssTC0xwF+
         tumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094902; x=1790699702;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2KG7WoqL6MDUfFcY9UDQ2lZC9iYeBArJH1WfhGL2AE=;
        b=lGFtG6J8RgFQllTqmoe6DQTNSmtvqJSF2vAReeGr330N7eqEgyOzdQXrH1nHYyPsYc
         bJfRnI8uBS1lQc1tqH4HLrTGrxPiOUxqaB5axgGb4+VcvEc2PNpr3U1wGkH3hcwmdlGo
         OIRgE+aktUpo84Yw7t5wTDr0AcGzRe5S1LZZpo4gtcLrhdW0n6BhtggB8ZD5YXHrymGs
         fpatrlEDEmy7SvR5snTGN9jUt5Z+L6QVaUgzT563HZD0d32wkVjjDMAPBQUCIOayfI8v
         Nj0Ml6vQKUVSUZW++JhyLdoRrs/kShQ/qvFZdwQS87eVxJIUHng9Li6znpIs+NXU04GK
         9BfA==
X-Forwarded-Encrypted: i=1; AKwUvByUMLzFEYvBtFzY6uOnozPcjQUx73LCKPbfRhiv7dRQ95NymF4q+CyEDU6dJI+mZ58tDisyAPI=@vger.kernel.org
X-Gm-Message-State: AFuF++kgyZepuZcrhCpcLo1qS96iDZ8TKKFMTtI6P/yJQSlTSsfllXfY
	T25lilWFpEFzYaz0JemvBTdhLTHnLxpzGhR2WJaggGLALtPfWT4bdywwX6baPqIVWSsx6vm9DWO
	BjwB1luR7YDjONA==
X-Received: from qvbmg15.prod.google.com ([2002:a05:6214:560f:b0:912:57f:614c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:1628:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7a685d6a55cmr7648389137.1.1790094902119;
 Tue, 22 Sep 2026 09:35:02 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:34:56 +0000
In-Reply-To: <20260922163458.3900996-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922163458.3900996-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922163458.3900996-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net: ethtool: generate RSS keys that spread
 flows over all queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_rss_key_fill() returns a key made of uniformly random bytes. That
is not enough, because the Toeplitz hash is linear over GF(2).

Walking the hash input MSB first, each set bit contributes a 32-bit
sliding window of the key, and hardware indexes the indirection table with
the low order bits of the result. Only the tail of each window therefore
reaches the queue index:

        v(i) = key bits [i + 32 - q .. i + 31]

with q = log2(number of RX queues). Consecutive input bits give windows
overlapping in q - 1 positions, so the q vectors belonging to the q lowest
bits of a header field form a Toeplitz matrix built from 2 * q - 1 key
bits, rather than q * q independent ones. Over GF(2) a random Toeplitz
matrix is singular with probability exactly 1/2, whatever its size.

When it is singular, flows differing only in the low order bits of that
field cannot reach all the queues. This is not theoretical: a burst of
connections draws ephemeral ports from a narrow range, and on one affected
host only 4 of the 16 RX queues received any traffic at all, until its key
was replaced.

Keep drawing the key at random, since it is a secret that stops a remote
attacker from steering flows onto a single queue, but force the handful of
bits that decide this. Writing d[t] for key bit (lsb + 31 - t), where lsb
is the position of the least significant bit of a field in the hash input,
the matrices of all the q values up to 8 are non singular if and only if

        d[2 * i] = 1 ^ d[i] ^ d[i + 1] ^ ... ^ d[2 * i - 1]

The odd positions stay free, so this is a one pass fixup rather than a
search. It is in fact a bijection from those free positions onto the set
of the values having the property, so the key stays uniformly distributed
over that set and the whole cost is 8 bits of entropy per position.
Searching for such a key by rejection would not have been an option: a
freshly drawn one has the property everywhere with probability 2^-1008.

Apply this at every 16-bit aligned position of the key, rather than at the
offsets of the 2-tuple and 4-tuple layouts only. The core does not get to
know what a given NIC hashes. Hardware may select the bytes it feeds to
Toeplitz out of a header window with a bitmap, and hash an encapsulated
header: for PSP over UDP over IPv6 it can pick the outer addresses and the
inner TCP ports, which sit 78 bytes into the frame and read key bits well
past the 40 bytes an IPv6 4-tuple needs. Hashed fields are 16 bits wide at
the smallest and are not expected to straddle that grid, so covering the
grid covers the layouts that were never written down, at no cost in code.

This spends 8 bits of entropy per position, 1008 bits out of the 2048 bits
of netdev_rss_key, leaving 1040 bits. 8 is also the largest usable bound,
as each q constrains 2 * q - 1 bits and anything larger would make the
ranges of two adjacent positions overlap.

What the fixup leaves behind is visible structure: 8 of every 16 bits are
derived from the 8 others, so a 16-bit aligned word of the key takes only
2^8 values and about 27 of the 128 words of netdev_rss_key duplicate
another one. That much is forced rather than an artefact of this
implementation, 1040 bits spread over 128 words being a little over 8 bits
each, but it has one consequence worth removing. Two 32-bit windows a
whole number of words apart now collide with probability 2^-16 instead of
2^-32, and two input bits reading the same window are indistinguishable to
the hash, since flipping both of them leaves it unchanged. Over 500 keys,
23% of them had such a pair, where a uniformly random key has one with
probability 2^-11.

So draw another key when that happens. Four out of five pass. Which
distances to look at follows from where the structure is: covering the
multiples of 16 leaves 1.2e-3 expected colliding pairs per key, still 2.6
times the 4.6e-4 of a plain random key, and almost all of that excess sits
at a distance of 8 modulo 16. Covering every multiple of 8 brings the total
down to 4.2e-4, below what a plain random key gives over all distances, and
within a few percent of the 4.0e-4 it gives over the distances that are
left.

Two windows a multiple of 8 bits apart are two windows at the same offset
modulo 8, so this is a handful of pairwise sweeps rather than one pass over
the key per distance. DO_ONCE() runs the generator under a spinlock with
hard IRQs disabled, so keep the windows of a class in an array rather than
recomputing both sides of every pair: 116 us instead of 254 us for the
worst case, a 2048-bit key with no collision anywhere, at a cost of 512
bytes of stack.

The shared key is fixed up once and every driver prefix inherits both
properties. Move netdev_rss_key and netdev_rss_key_fill() from
net/ethtool/ioctl.c to net/ethtool/common.c, and move the netdev_rss_key
declaration out of include/linux/netdevice.h into net/core/dev.h.

Checked against an independent Toeplitz implementation: for every 16-bit
aligned position and every q in 1..8, an aligned block of 2^q consecutive
values of a field ending there lands on the 2^q queues exactly once each.
Over 20 random keys that is 20160 checks, which 50.1% of plain random keys
fail and none of the generated keys do, for an average of 502 rewritten
bits out of 2048.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/scaling.rst |   9 ++
 include/linux/netdevice.h            |   1 -
 net/core/dev.h                       |   1 +
 net/ethtool/common.c                 | 174 +++++++++++++++++++++++++++
 net/ethtool/ioctl.c                  |  16 ---
 5 files changed, 184 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 6c261eb48845a40516f201233df13694863ee8cd..6c9836000a8d15c209d52fe78e46d346156893e4 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -48,6 +48,15 @@ count is not a power of two. NICs should provide an indirection table
 at least 4 times larger than the queue count. 4x table results in ~16%
 imbalance between the queues, which is acceptable for most applications.
 
+The Toeplitz hash is linear over GF(2), so the quality of the hash key
+matters as much as its randomness. For a key made of uniformly random
+bytes, the q lowest order bits of a given header field fail to spread
+flows over all 2^q queues with probability 1/2, and a burst of connections
+picking nearly consecutive ephemeral ports then lands on a fraction of the
+queues while the others stay idle. The netdev_rss_key_fill() helper draws
+a random key that is free of this defect; drivers should use it rather
+than seeding a key of their own.
+
 Some NICs support symmetric RSS hashing where, if the IP (source address,
 destination address) and TCP/UDP (source port, destination port) tuples
 are swapped, the computed hash is the same. This is beneficial in some
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5d16737167eed1b96bd7e0f03bafb598160d94ba..d037faff7c44b61c80d8f572c23b49d2a8c1ab8f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5323,7 +5323,6 @@ void netdev_lower_state_changed(struct net_device *lower_dev,
 				void *lower_state_info);
 
 #define NETDEV_RSS_KEY_LEN 256
-extern u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
 void netdev_rss_key_fill(void *buffer, size_t len);
 
 int skb_checksum_help(struct sk_buff *skb);
diff --git a/net/core/dev.h b/net/core/dev.h
index 0127b4d03e5251e0ad695aa649d0c52c2248bc8c..a5e22b2eae5231b013fcf246922c8bd3ac787e69 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -95,6 +95,7 @@ extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
 extern int		dev_weight_rx_bias;
 extern int		dev_weight_tx_bias;
+extern u8		netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
 extern bool		netdev_rss_key_initialized;
 
 extern struct rw_semaphore dev_addr_sem;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 23db40618fed147c4fa3de754b100cda1f98f5cd..b4e766e60d38ae22ea3cb52e74afae24a2b66946 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -2,6 +2,9 @@
 
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/unaligned.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
@@ -1400,3 +1403,174 @@ enum ethtool_link_medium ethtool_str_to_medium(const char *str)
 	return ETHTOOL_LINK_MEDIUM_NONE;
 }
 EXPORT_SYMBOL_GPL(ethtool_str_to_medium);
+
+u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
+bool netdev_rss_key_initialized __read_mostly;
+
+/* Toeplitz is linear over GF(2): the hash is the XOR of the 32-bit key
+ * windows selected by the set bits of the input, and hardware indexes the
+ * indirection table with the low order bits of the hash. Only the tail of
+ * each window therefore matters for queue selection:
+ *
+ *	v(i) = key bits [i + 32 - q .. i + 31]
+ *
+ * for input bit @i, with q = log2(number of RX queues). Consecutive input
+ * bits give windows overlapping in q - 1 positions, so the matrix formed by
+ * the windows of the q lowest bits of a header field is a Toeplitz matrix
+ * built from 2 * q - 1 key bits, not from q * q independent ones. A random
+ * Toeplitz matrix over GF(2) is singular with probability 1/2, whatever its
+ * size, and when it is singular the flows of a burst differing only in the
+ * low order bits of that field (consecutive ephemeral ports, typically)
+ * cannot reach all the RX queues no matter how many of them are configured.
+ *
+ * Keep the key random, but constrain the few bits that decide this. The
+ * fixup is applied at every 16-bit aligned position of the key, rather than
+ * at the offsets of the one hash input layout the software happens to know
+ * about: hardware is free to hash whatever it wants, but the fields it picks
+ * are 16 bits wide at the smallest and are not expected to straddle that
+ * grid, so an encapsulated or offloaded layout is covered like the usual
+ * 2-tuple and 4-tuple ones. Each position constrains 2 * q - 1 bits, so
+ * NETDEV_RSS_KEY_QMAX is both enough for 256 queues and the largest value
+ * keeping the ranges of two adjacent positions disjoint.
+ */
+#define NETDEV_RSS_KEY_QMAX	8
+#define NETDEV_RSS_KEY_SPAN	(2 * NETDEV_RSS_KEY_QMAX - 1)
+
+static bool netdev_rss_key_bit(const u8 *key, unsigned int bit)
+{
+	return key[bit / BITS_PER_BYTE] & (0x80 >> (bit % BITS_PER_BYTE));
+}
+
+static void netdev_rss_key_assign_bit(u8 *key, unsigned int bit, bool value)
+{
+	u8 mask = 0x80 >> (bit % BITS_PER_BYTE);
+
+	if (value)
+		key[bit / BITS_PER_BYTE] |= mask;
+	else
+		key[bit / BITS_PER_BYTE] &= ~mask;
+}
+
+/* Writing d[t] for key bit (@lsb + 31 - t), the matrices of all the q values
+ * up to NETDEV_RSS_KEY_QMAX are non singular if and only if
+ *
+ *	d[2 * i] = 1 ^ d[i] ^ d[i + 1] ^ ... ^ d[2 * i - 1]
+ *
+ * The odd positions stay free, so this is a one pass fixup rather than a
+ * search. It is also a bijection onto the set of the values having the
+ * property, so the key stays uniformly distributed over that set. It costs
+ * NETDEV_RSS_KEY_QMAX bits of entropy per position.
+ */
+static void netdev_rss_key_fixup_field(u8 *key, unsigned int lsb)
+{
+	bool d[NETDEV_RSS_KEY_SPAN];
+	unsigned int i, t;
+
+	for (t = 0; t < NETDEV_RSS_KEY_SPAN; t++)
+		d[t] = netdev_rss_key_bit(key, lsb + 31 - t);
+
+	for (i = 0; 2 * i < NETDEV_RSS_KEY_SPAN; i++) {
+		bool value = true;
+
+		for (t = i; t < 2 * i; t++)
+			value ^= d[t];
+
+		d[2 * i] = value;
+	}
+
+	for (t = 0; t < NETDEV_RSS_KEY_SPAN; t++)
+		netdev_rss_key_assign_bit(key, lsb + 31 - t, d[t]);
+}
+
+/* The 32 key bits starting at @bit, which is what input bit @bit contributes
+ * to the hash. @bit + 32 must fit in the key.
+ */
+static u32 netdev_rss_key_window(const u8 *key, unsigned int bit)
+{
+	unsigned int byte = bit / BITS_PER_BYTE;
+	unsigned int shift = bit % BITS_PER_BYTE;
+	u32 window = get_unaligned_be32(key + byte);
+
+	if (shift)
+		window = (window << shift) |
+			 (key[byte + 4] >> (BITS_PER_BYTE - shift));
+
+	return window;
+}
+
+/* Two input bits contributing the same window are indistinguishable to the
+ * hash, since flipping both of them leaves it unchanged. For a uniformly
+ * random key that is a 2 ** -32 event per pair of positions, but the fixup
+ * makes it likelier: it derives 8 of every 16 bits from the 8 others, so a
+ * 16-bit aligned word only takes 2 ** 8 values and two windows a whole
+ * number of words apart collide with probability 2 ** -16 instead. Half a
+ * word apart is less affected but still well clear of the random odds, so
+ * cover every distance that is a multiple of 8. What is left after that is
+ * below what a plain random key gives.
+ *
+ * Two windows at a distance that is a multiple of 8 are two windows at the
+ * same offset modulo 8. Caching a whole class would put 253 u32 on the
+ * stack, so cache one class modulo 16 and stream the class 8 bits above it
+ * against it.
+ */
+static bool netdev_rss_key_aliases(const u8 *key, unsigned int bits)
+{
+	u32 windows[NETDEV_RSS_KEY_LEN * BITS_PER_BYTE / 16];
+	unsigned int i, j, n, r;
+
+	for (r = 0; r < 16; r++) {
+		n = 0;
+		for (i = r; i + 32 <= bits; i += 16)
+			windows[n++] = netdev_rss_key_window(key, i);
+
+		for (i = 0; i < n; i++)
+			for (j = i + 1; j < n; j++)
+				if (windows[i] == windows[j])
+					return true;
+
+		if (r >= 8)
+			continue;
+
+		for (i = r + 8; i + 32 <= bits; i += 16) {
+			u32 window = netdev_rss_key_window(key, i);
+
+			for (j = 0; j < n; j++)
+				if (windows[j] == window)
+					return true;
+		}
+	}
+
+	return false;
+}
+
+static void netdev_rss_key_init(u8 *key, size_t len)
+{
+	unsigned int lsb, bits = len * BITS_PER_BYTE;
+
+	/* Four keys out of five come out of the fixup free of aliases, so
+	 * drawing another one is both simpler and cheaper than repairing.
+	 */
+	do {
+		get_random_bytes(key, len);
+
+		/* A field ending at bit @lsb uses key bits [.. , @lsb + 31],
+		 * so stop as soon as a 32-bit window no longer fits in the
+		 * key.
+		 */
+		for (lsb = 15; lsb + 32 <= bits; lsb += 16)
+			netdev_rss_key_fixup_field(key, lsb);
+	} while (netdev_rss_key_aliases(key, bits));
+
+	/* Pair with smp_rmb() in proc_do_rss_key(). */
+	smp_wmb();
+	WRITE_ONCE(netdev_rss_key_initialized, true);
+}
+
+void netdev_rss_key_fill(void *buffer, size_t len)
+{
+	if (WARN_ON_ONCE(len > sizeof(netdev_rss_key)))
+		len = sizeof(netdev_rss_key);
+	DO_ONCE(netdev_rss_key_init, netdev_rss_key, sizeof(netdev_rss_key));
+	memcpy(buffer, netdev_rss_key, len);
+}
+EXPORT_SYMBOL(netdev_rss_key_fill);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b2820f02ca2790a8a3c13395e20040ee6976006f..2b449d08ddcf30e20caf86e9dd294f3e0819ac2d 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -34,7 +34,6 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 
-#include "../core/dev.h"
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -1302,21 +1301,6 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 	return 0;
 }
 
-u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
-bool netdev_rss_key_initialized __read_mostly;
-
-void netdev_rss_key_fill(void *buffer, size_t len)
-{
-	BUG_ON(len > sizeof(netdev_rss_key));
-	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
-	if (unlikely(!READ_ONCE(netdev_rss_key_initialized))) {
-		/* Pair with smp_rmb() in proc_do_rss_key(). */
-		smp_wmb();
-		WRITE_ONCE(netdev_rss_key_initialized, true);
-	}
-	memcpy(buffer, netdev_rss_key, len);
-}
-EXPORT_SYMBOL(netdev_rss_key_fill);
 
 static noinline_for_stack int ethtool_get_rxfh_indir(struct net_device *dev,
 						     void __user *useraddr)
-- 
2.55.0.1082.g2b9226bbc0-goog

