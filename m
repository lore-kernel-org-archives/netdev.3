Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825275;
	b=1lYSCSuA+7kD1Z7J76amFduLsWXhqnAASOylD2bF2WFuvZyRxOJ3+3fMep7NDWRW+DTF
	 rFSlfb0gzOlePU6e8yEZ/8HKthMxJbDnX+8PIrBqGEEefTdbppTb4JE5X5nnhYcifDmtF
	 3JnwudfbsJ4O5OeL4B15PQJmMg8gSv6tQ9wgaL20gxRtVYHq8rbtM37RZpT8mhZEaW0r5
	 ZL6lOAaX/+FUgVdIZUR4WRkbYTf8iXeyAidqiYIjV1DdKUIOJSJ/n9CobahPNufoXSfnp
	 ysEce+GVgpQ4rgu4D0qRPgOQhIYwvFuDh90JKQcyVorPAFoHqbjn8UprBrIRhUdptTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VmZ/3gC03rOFS4IvFRf+urbZu7mk8uManzJKXnUZilo=;
	b=a1uB52k1EjpRHPc9If2XNyJGhAbTXZ8QfF7Cp/LjSnLAXV4guNFPFYK6m4Ub/k0zXPW0
	 IFOoww6n1s1XhHQDuuPeycJRRjfdmAXC//XCqALodBkigpgWnv93dPIWUPg1eCYI44Pmc
	 +AEuA0K7bATzbNHdP0lj3P4AYP5CJLd9LLe4IqRdSBKh2nS9ZIDX778k52aw/+0DN7vLz
	 rGlPjO+cRdu4GgPoOWPjjo+s73HrC5nxQBY7nib9J5Xes7k260H9MV5RFOyso7NWc9Mur
	 e2ZfZDh8T7k1jamk2AAOgISEhF4Adqdd0DS3GfWyntVVEI7Jy6rAQHYgLN7z0Y/FyTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Zug+QhY2;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381D6096BEA
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6381D6096BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Zug+QhY2
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53c4b82919fso14039741cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825274; x=1794430074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmZ/3gC03rOFS4IvFRf+urbZu7mk8uManzJKXnUZilo=;
        b=Zug+QhY2fwh37DmoM7DBrl/o9aIeZ0OgPZoj/lGtiVT0eIG0ENeOqCJXvG3V/P+3Z9
         nzOezL/lEySk1lA4qlvTTlozuFkhJlGZGRfLKLkUGbn7BaipSSdu7hE8ky/DyAYKeU0q
         BWcbpjEAAKImOLnIvU8TsN9fCA/3McDlScHeGtPR0fJcTgWvV3zdZLcrQcXS09ppABQd
         Ni/vrUZBf7HjjA4IJg8moHjOguJOAIaU/Rn0d7413BBUNEU4/EzpS5evYR/VBnv1LDZE
         IyjFgpAv/ZgQmcB/RHdXDflR75X1SJKGSZ1Ov3R68i4X07fM8KbCG8UEJJOEYcjU/PoC
         owAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825274; x=1794430074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VmZ/3gC03rOFS4IvFRf+urbZu7mk8uManzJKXnUZilo=;
        b=0v0z2lUXM0jcs7g6yS2tH9jXtkPpIiJV7M8CWz1oRiUi/5zgzd5NWsLHADJ3EqOuAr
         Kyu5gOnt/cAxKaP90fsV+KXqMXBltZaXCm+EjGXiWjXUxg0qOaOT9wIS01hzi7s3ViYc
         0YuzyZbhqgGvPt6+NTH0bPaEgzrAMK8F2mNaCHeLN1iOr7uVHyUneY+uHonEjCu4IeG8
         Qt17EIixXv6Qo3n5e9xHuVOLI+EDMJ5L3G2BL8kikQ/3N/xITCuBTEfa4Pzh4RfBnL1k
         6xlqAFflhvk+FZBPnWwlgJAYgp5GqIogXl/WqTkrwE5e7qGEQo6lEhrq06SGkWTIawjF
         6oXA==
X-Forwarded-Encrypted: i=1; AKwUvBzey8dgwS75HT/qzSEXAhM/AFR0rk9WZDxM5y2vbMRvGxBURK7Qyfp6t3KZfQvb1aqft8iuclQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/KcwFIogsAgfXapzl8P44ZAyO6RbGdKbb7M/24YtS5tw3aRyI
	kowuKsCtBWyv7qNqtVWz+bJLZXeV2qkv7X0hVUBQ9ALcSjafkmxHSyJy7RHQae1a0/s=
X-Gm-Gg: AYBFou3qbpQguJNQLvGco+coAM2u48oUI4p0VLPQMd81hvW7UY3ApubOAAo8EDIHR9x
	vOIOQ0vz6C0owu40c8J/LPK7N/hBVdVmWUyVN+uSgEf3sXoDulSSClsrochKOTClh3/xuNryZLL
	8W1EbKSGw1AtQLxy17HYrxZcmmZIxGqRNpIOh2INHKXzw0yCj/fNLamUFUh1bH9n66UNK/ytD+M
	wwX63YQF8oeCRYg4xiYDBu6NrwUuyNhgDgHI2x4TjPRJnXIB8JGm6CTNLuBSr4/5EEYOLTtHAsv
	0NpkXB668kN1J4x9GLqRkketQW1CdgK7s0Eu7EmdpVDeiNWbRd+no1iDkcdt4cl5x1qLhLlvsbN
	yfDSERVeiwTcZX13t8LzrzLm/hUhykaltwFPA+EEPgU+to9u4FlyQm1+vlyjGWEEDdYnBbkmUFN
	oGHwfx5e4Kf3QxhC1S9csl/gnibnFGK3aZZq9MNMjR0FOBJf4wrnY8UXfstTlwqC1tDa1/vFx3i
	Shb/swl5LlwfQKPxFYNVq/mirm/yIRdEWmNocUE85snOM2CWTThZYWtWRMAif5sGHp9Bh4oVbf+
	kIXU/jA9XU/cs3YMkd/AvUhd+wZKWiblnEBZhjxH7bqDlA==
X-Received: by 2002:ac8:59d3:0:b0:536:3a49:f76 with SMTP id d75a77b69052e-542b62a60f2mr301290451cf.27.1793825274007;
        Wed, 04 Nov 2026 12:47:54 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7006asm33796401cf.17.2026.11.04.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:15 +0000
Subject: [PATCH net-next v4 03/15] net: skbuff: fail checksum validation
 when the skb can't be checksummed
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-3-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=5641;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Lx+sg563Gwi7/eqkbjWaelHQ+u2/rBUxkXNgf6ZDN3A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIBEqqq3ka7HmeaWWRJD2T+myoIbf+nMkpwdF2b0vlJsA0tYmEFfRvaeCBuvlGjyE/GzzQk+iqN
 3kCfR/y6KEwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_checksum_complete() and __skb_gro_checksum_complete() verify a
packet with skb_checksum(), which returns 0 when the payload is in
unreadable frags or the skb's lengths don't add up.  Both add that 0 to
the pseudo-header sum, so they accept the packet whenever the
pseudo-header sum folds to 0xffff.  The sender controls that sum through
the addresses and the length.

Use skb_checksum_full() in both, and in __skb_checksum_complete_head(),
and report an skb that can't be checksummed as having a bad checksum.

Also take the skb off CHECKSUM_COMPLETE on that path.  nf_ip_checksum()
stores the pseudo-header sum in skb->csum before it calls
__skb_checksum_complete(), and conntrack doesn't drop a packet with a
bad checksum.  If the skb stayed CHECKSUM_COMPLETE,
__skb_checksum_validate_complete() would add the same pseudo-header sum
to skb->csum and accept the packet under the same condition.

A test module builds an skb that claims 50 more bytes than it holds,
with a pseudo-header sum of 0xffff.  Both functions accept that skb
before this patch and reject it after.

Found by the Sashiko AI review of the BUG_ON() series.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Link: https://lore.kernel.org/all/179273111951.3134.3452028799437573017@kernel.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  4 ++--
 net/core/gro.c         | 11 +++++++++--
 net/core/skbuff.c      | 27 +++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 608c1491597e..5a5354a6b6ba 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4892,7 +4892,7 @@ static inline void skb_checksum_complete_unset(struct sk_buff *skb)
  *   0: checksum is validated or try to in skb_checksum_complete. In the latter
  *	case the ip_summed will not be CHECKSUM_UNNECESSARY and the pseudo
  *	checksum is stored in skb->csum for use in __skb_checksum_complete
- *   non-zero: value of invalid checksum
+ *   non-zero: value of invalid checksum, or 1 if the skb can't be checksummed
  *
  */
 static inline __sum16 __skb_checksum_validate_complete(struct sk_buff *skb,
@@ -4932,7 +4932,7 @@ static inline __wsum null_compute_pseudo(struct sk_buff *skb, int proto)
  *
  * Return values:
  *   0: checksum is validated or try to in skb_checksum_complete
- *   non-zero: value of invalid checksum
+ *   non-zero: value of invalid checksum, or 1 if the skb can't be checksummed
  */
 #define __skb_checksum_validate(skb, proto, complete,			\
 				zero_okay, check, compute_pseudo)	\
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..e2e847c95270 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -798,10 +798,17 @@ EXPORT_SYMBOL(napi_gro_frags);
  */
 __sum16 __skb_gro_checksum_complete(struct sk_buff *skb)
 {
-	__wsum wsum;
+	__wsum wsum = 0;
 	__sum16 sum;
 
-	wsum = skb_checksum(skb, skb_gro_offset(skb), skb_gro_len(skb), 0);
+	/* If the data can't be checksummed it can't be valid either, and
+	 * NAPI_GRO_CB(skb)->csum only holds the pseudo checksum.
+	 */
+	if (skb_checksum_full(skb, skb_gro_offset(skb), skb_gro_len(skb),
+			      &wsum)) {
+		NAPI_GRO_CB(skb)->csum_valid = 0;
+		return (__force __sum16)1;
+	}
 
 	/* NAPI_GRO_CB(skb)->csum holds pseudo checksum */
 	sum = csum_fold(csum_add(NAPI_GRO_CB(skb)->csum, wsum));
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d51fdcb3e016..0082b12544cf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3885,11 +3885,28 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 EXPORT_SYMBOL(skb_crc32c);
 #endif /* CONFIG_NET_CRC32C */
 
+/* The data can't be checksummed, so it can't be valid either.  The caller has
+ * put the pseudo header's checksum in skb->csum, so don't leave the skb
+ * CHECKSUM_COMPLETE for a later validator to take that for the packet's.
+ */
+static __sum16 skb_checksum_complete_failed(struct sk_buff *skb)
+{
+	if (!skb_shared(skb)) {
+		skb_checksum_complete_unset(skb);
+		skb->csum_valid = 0;
+	}
+	return (__force __sum16)1;
+}
+
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
 {
+	__wsum csum = skb->csum;
 	__sum16 sum;
 
-	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
+	if (skb_checksum_full(skb, 0, len, &csum))
+		return skb_checksum_complete_failed(skb);
+
+	sum = csum_fold(csum);
 	/* See comments in __skb_checksum_complete(). */
 	if (likely(!sum)) {
 		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE) &&
@@ -3909,14 +3926,16 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
  *
  * It returns non-zero if the recomputed checksum is still invalid, otherwise
  * zero. The new checksum is stored back into skb->csum unless the skb is
- * shared.
+ * shared. If the skb can't be checksummed it returns non-zero, skb->csum is
+ * left alone, and the skb is no longer CHECKSUM_COMPLETE unless it's shared.
  */
 __sum16 __skb_checksum_complete(struct sk_buff *skb)
 {
-	__wsum csum;
+	__wsum csum = 0;
 	__sum16 sum;
 
-	csum = skb_checksum(skb, 0, skb->len, 0);
+	if (skb_checksum_full(skb, 0, skb->len, &csum))
+		return skb_checksum_complete_failed(skb);
 
 	sum = csum_fold(csum_add(skb->csum, csum));
 	/* This check is inverted, because we already knew the hardware

-- 
2.55.0

