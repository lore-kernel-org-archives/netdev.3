Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686914FD786
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015886; cv=none; b=Loz4i4VU7c6hd6uXWo0V3I3ki2uKWkhit/jINnBkMYzfcEfrqU8llNjI9uP5b8pJ1QUYWT5otrwvv16zljwuZznRNSygYhwZouJQBlKbzSiVWVzYSqdO8HETU3ppd9sQ65NBnTJFqfC6yR2JEjThiFHY8cHfnrZPTvKjkuo2b+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015886; c=relaxed/simple;
	bh=zC8pq5/a/e8f5Rd9dYHGJlMWOz3cJ8EOI2x+puY873g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSVksUWqZ0BuSOFskImtvVECOJgiaS5O5D1gZm8JCmJZ4U/klNdCEQrey5mUJDtB3NpFRWicRTWv9Ga+1Ic3LuGpIL+aSOUDWHRKPwkwVaW51soxzGeGLFatBq4aOmo2ZD0u4goZvIR+DpckH8N7oJp0YvI5FPzRku9LZeyTXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmB007QI; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmB007QI"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530f65ddee1so76079741cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015883; x=1790620683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8W78mKkFLt4yNIN7OSxckcYij7aSl/LmgglwIhiZPQ=;
        b=jmB007QI3wEvBdMV6uga5HT5j+4gVx+EDGgu3eeiUqEM4JRKnBlrlzAL80WYjywO5C
         E87lwE68fhV8OuHQkB14eL01EoY+IUSMArGLiSXiHMDlVLIds5wSpDUeoKp90kpAXS3p
         9zYUr5y6ZiVRol1Xt6Dvst8RLbrs+r73r9lE0EnyQ6V/CdS2OXW7UYyJv2fbl9wMlv/d
         8bcBOo9h2cPJGNg2tGCAXRkVmOwHR2pD2j3+FFMMkxYZyX+uVh1ekiLtsLzimxcSXMDe
         AWlPoyZZn0h+HsxrKmZExY2X0dInENUr/0JOPx6t0r6Y3AdjMT0ulLjQixqHt71c+LCB
         ZUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015883; x=1790620683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8W78mKkFLt4yNIN7OSxckcYij7aSl/LmgglwIhiZPQ=;
        b=ue0EAE+OB5Mb/O19y3rOtwONVdjUVziImwC13UCwHEqpfoZznoAvh7tLkNUmd3dOVM
         lSsmE6Tle3ETXUT8aB3afRr9iXPl16RTENN1iXJGLXlrTs3X2RAFfLLvGz8lkyzpVJxX
         DP5bNhheDSYMSqdSHZpJsYkhEHpLKxVCCpBKU+1Tllmx8axZTiZf3pPGFvRV21BkFsF/
         NdzMJ/i0DKkiUOHF0h8NWnP5SB32VSA1qySnd8VoRexZsB1nBK4X10m0zCKX/fPl9x0k
         7KjS7L9HKX4g5cazPRFR6DLMBWWi+g+IchQMpSeW4E1l5e1/QggUmo92pkSlrHUVx+/+
         /KAA==
X-Forwarded-Encrypted: i=1; AKwUvByOGEocrDqF+j4wx9XUTX+XfMI2NQm+1ekhdYBtkZxoKnyJZfODTfaWv5pG7tc+4OeAJdQJ+SQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k4XuvvKF44Affk30fJldEPfnQtEmszUHA3f/jC5Vl16C+DAwg8
	CWKxaZPFpLcRfQTPwHZQXbORfpYnd0h+hJPy+nO8dUkz524Kwijywp59bAjd+1tD1QFq2vyzTj1
	Dy/1YlspARl4cPg==
X-Received: from qtny12.prod.google.com ([2002:ac8:524c:0:b0:530:e81a:ef05])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:22a3:b0:532:a2ba:c3d with SMTP id d75a77b69052e-532d8d3482dmr17386371cf.10.1790015882996;
 Mon, 21 Sep 2026 11:38:02 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:55 +0000
In-Reply-To: <20260921183758.1812310-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] net: ethtool: generate RSS keys that spread
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
properties.

Checked against an independent Toeplitz implementation: for every 16-bit
aligned position and every q in 1..8, an aligned block of 2^q consecutive
values of a field ending there lands on the 2^q queues exactly once each.
Over 20 random keys that is 20160 checks, which 50.1% of plain random keys
fail and none of the generated keys do, for an average of 502 rewritten
bits out of 2048.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/scaling.rst |   9 ++
 net/ethtool/ioctl.c                  | 172 ++++++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 6 deletions(-)

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
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b2820f02ca2790a8a3c13395e20040ee6976006f..bdc40cfd27217d85b4aa2ac93d0b70fc8d22371a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -25,7 +25,10 @@
 #include <linux/rtnetlink.h>
 #include <linux/sched/signal.h>
 #include <linux/net.h>
+#include <linux/once.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
+#include <linux/unaligned.h>
 #include <linux/utsname.h>
 #include <linux/ethtool_netlink.h>
 #include <net/devlink.h>
@@ -1305,15 +1308,172 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
 bool netdev_rss_key_initialized __read_mostly;
 
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
+	if (key != netdev_rss_key)
+		return;
+
+	/* Pair with smp_rmb() in proc_do_rss_key(). */
+	smp_wmb();
+	WRITE_ONCE(netdev_rss_key_initialized, true);
+}
+
 void netdev_rss_key_fill(void *buffer, size_t len)
 {
 	BUG_ON(len > sizeof(netdev_rss_key));
-	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
-	if (unlikely(!READ_ONCE(netdev_rss_key_initialized))) {
-		/* Pair with smp_rmb() in proc_do_rss_key(). */
-		smp_wmb();
-		WRITE_ONCE(netdev_rss_key_initialized, true);
-	}
+	DO_ONCE(netdev_rss_key_init, netdev_rss_key, sizeof(netdev_rss_key));
 	memcpy(buffer, netdev_rss_key, len);
 }
 EXPORT_SYMBOL(netdev_rss_key_fill);
-- 
2.55.0.1082.g2b9226bbc0-goog

