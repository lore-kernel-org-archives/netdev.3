Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672929;
	b=3FlmL52WiHsX+riGceoIv3dI1ljzHR5hlZ9ZzE4EJFS3ldZlJa648W21FnwSItVBui7K
	 98R9fsE4wmEnNE4q2FPFuqSm9+RJddY5pj5O+sHNSMAS7qfs0padN1VekXcOgwh16axOc
	 TvGVolTiiTpRQSxFW99kMFUYqIXYJth5VnbiNyD0/TEsbnVRwdl+WD/mIpI+uaa1CJcfI
	 FAHffqIeQoqgjECwJqMBMlmOk/2V4fK2E85MeUOBm2FSuxaHt3Uxy17OjmEWG3l+xZoFo
	 zDftUrCSRpWml+KF3fICZvkD7tWLb8w7oD21y4spwZxxS+gGstiA46oiYuJFwyZP8FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ItNbbfoSMigin0nEzX5YnYh+yWL40HL4VuZt49ucLwc=;
	b=3Js/acjQkleZDRhsRS/k1YIsO+o/dbF2mT9DyqGQHLwXCzsIWbQ4CH2s0k+3m44LZ15H
	 LEzcWqaQiCLT731aFZ/d6+9gzz4kGWNZqZ8x458RygX2QA9GqvsplMXjnz18oFyKZVOo7
	 zTfpn5wLKgXSF7lhMbhG3HF8FvTlAo2JnHbkEc2Pc4s1EXXE2frxpThEz81r3LPaObyN6
	 BjD5vSiIzGjyArrt7YY508tLCmvbvT5pm12w8QtTkNS4bqlpg1n7MLWDYZ7FAlO+dnSAs
	 BbpYGRNFvMnRo9EVw+ctxFFlTNckK+jQBWgNiJ7lT31rZ5sbwHS1NrllN7t9txULJBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=APT3XGqO;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86875606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86875606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=APT3XGqO
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5361e313e63so42598131cf.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672927; x=1794277727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItNbbfoSMigin0nEzX5YnYh+yWL40HL4VuZt49ucLwc=;
        b=APT3XGqOinSadZcXMGT5Mgh/iGLb0a0CGtLCheqrPEJ50Y+6UFaBAh4/U5bKZ/EHQG
         jqqVgGXkP0C4yO86LJ5vR2uJaL4ieRi1oiPHWd1nesV3iwmvwfw7pKv/45TPKQlwFlQb
         dBYR1Sygwni0EM8BSBpAzVwoLkrt6q9mXGgXpbneJthkYMQD8FJLi8T31wWcsWTk+bKE
         edY8enmROYZeRmdb1pAgDVUbo0J3hnI+0vn4vKZRYWaFPwx5AO/Ws5p/+rJ+TEhYbFZs
         c96Z1Mu8pGFaD/brsPduAU8zooBtzmcm0r2g1yahywEPvd+UnQEEB7TxPRuo+o1uYggf
         Ykiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672927; x=1794277727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItNbbfoSMigin0nEzX5YnYh+yWL40HL4VuZt49ucLwc=;
        b=XLrGQnRvmD6BzvlO2wH1LOOeAHVo7gQQkFkcqpKwcysZGKYFfd8VFlnH0gORmXzv7l
         Zl6hIMavNvvcLa8cyG37x1CIqGGsKiz2AS/DJCn38h5iIkNXkDo6kgqJtclIYTminRrS
         qqEBme5OTQ5IxCOJnCjgUrSDeqZDud7esmwDyaSHs5WpPJPfn2EEhiTUshO9yzoyLO3N
         FZuv4DfY1B6i1mB2jNTTgAITLwcJaoECjjTuliB6s1hEEDc11RoXRXN1krOpFWWv7ZSF
         HPpdzQOLo8VuzDxEIlJ9PR5z6m6Sj/hPRgtMMFEjRhuajYNvjcig60QPy4nSc8WuCUSi
         hpRg==
X-Forwarded-Encrypted: i=1; AKwUvBzLRW7/JkfdC/nBYsCAQ48bDPFZOZ6Gp/TsJ+yRwANtLq9s0wYqNXMsYLeggvNwtUUGL3YvArY=@vger.kernel.org
X-Gm-Message-State: AFq9FYII0nPL407JulvxLvQ8AFyrzfSkdFC63Vuoe7Do85TDksruqMLF
	ko9TIxvJ43+OG1FFcbUK5ptswZVV9/mKGVbiqyHTNN9+araIuPuzfUZMrwsy1iLs68c=
X-Gm-Gg: AYBFou19Y2FLz+bPuis5M+2KhF2nrnI0SeSPeWjFSNrdCrx+nFFtyRRgyaMwDt8OBUK
	M8tHwFKkgv7mOT4h9Z2gcU+fx/03nqX1MvW0MIlaOFF24Hir7fyoVSHLOwbTstQs1VSUrjxV8jP
	oeJ5HR9szxHNPkXIS58Otd+8ryaXI8NIQeiaaA5oMkhgCNiMG9KV+RgcKEkuWumz5dfc7mtNdZx
	D6BFzpWPvR/jZg4/AFG+wqLtIyVvoYyTnaP9kkdkoTE24c1lVnMEp3fGeDiuCwb4+3Q317lhtfm
	llttssNayFbguzm4rm0IJnY5Fk1dKXlkUddWr0hkfBxmD21E0bQQrtpZ4v6pDVVc083JVAv3HLx
	K/wkxCmLMlnMU3MzZxO1zGsIzDvVc8xMdArhFxl7M/IAr8v23q8dwa7RpVKPpY9sTicB476lM8Q
	nYiikFwOEdlnT/ztEWD2zl2YwPyRJpO2FVD+0PcjCSESWh7zKCCOw/Rd9WmpYPxvjuWoD7wp6xI
	IbRRanlcq2jDTThoSpPFgliLDUaKKpFmN5icrIzwmX3mX1TFgS4a+9S+GnPakbc+o5FaoY0qIO4
	d6GYbT0ghJH3wCFQ/dcuz6hcdSv8p2ahj0aQxNaFH2ed4g==
X-Received: by 2002:a05:622a:394:b0:536:699d:9a1c with SMTP id d75a77b69052e-542b3979709mr204371611cf.2.1793672927274;
        Mon, 02 Nov 2026 18:28:47 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm13831151cf.4.2026.11.02.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:27 +0000
Subject: [PATCH net-next v3 01/15] net: skbuff: make
 skb_copy_and_csum_bits() report unreadable frags
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-1-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=13352;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=+G2u4WuzqFRwukhQ5bvu8a1h5fsGccFSEyEcvJUXbLo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHioHkzRf9qW/+GyWuZtNQbmDIwqaFZOeLV1PK/nMSdeCk5HhZyyNtfxFqCDDkBgs6hQVxRSgTd
 IkeyQ2Cw97w8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_bits() has no way to fail.  When it reaches unreadable
frags, or runs out of skb before @len, it zero-fills the rest of the
buffer and returns 0.  Its callers can't tell that the copy didn't
happen.

In the !sg && !csum branch of skb_segment() that turns a devmem TCP
payload into zeroes under a valid TCP checksum, and the peer accepts
them as stream data.  It takes a device with both SG and TX checksum
offload turned off.  A test module that segments an skb with 3000 bytes
in an unreadable frag gets 3 all-zero segments before this patch and
-EFAULT after it.

Return 0 or -EFAULT, hand the checksum back through a pointer, and mark
the function __must_check.  Every caller takes the error path it already
has for a failed copy.  skb_copy_and_csum_dev() can't return an error,
so it zeroes the whole frame.  csum_partial_copy_to_xdr() no longer
checksums the bytes it didn't copy.  That only ran when the function was
about to fail anyway, and skb_checksum() warns on an unreadable skb.

The frag_list loop takes the address of a local, so it moves into a
noinline function to keep a stack protector out of
skb_copy_and_csum_bits().

Found by the Sashiko AI review of commit ab9414ed70bd ("net: skbuff:
don't leave stale bytes in skb_copy_and_csum_bits()").

Fixes: ab9414ed70bd ("net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()")
Fixes: 417261779eab ("net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()")
Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
Suggested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/sunvnet_common.c |  10 ++-
 include/linux/skbuff.h                    |   4 +-
 net/core/skbuff.c                         | 133 ++++++++++++++++++++----------
 net/ipv4/icmp.c                           |   9 +-
 net/ipv4/ip_output.c                      |  11 ++-
 net/ipv6/icmp.c                           |   7 +-
 net/ipv6/ip6_output.c                     |  11 ++-
 net/sunrpc/socklib.c                      |   9 +-
 8 files changed, 127 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 5cca95869052..4f229fcecc32 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1167,9 +1167,13 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
 
 			/* copy the rest, with csum calculation */
 			*(__sum16 *)(skb->data + offset) = 0;
-			csum = skb_copy_and_csum_bits(skb, start,
-						      nskb->data + start,
-						      skb->len - start);
+			if (skb_copy_and_csum_bits(skb, start,
+						   nskb->data + start,
+						   skb->len - start, &csum)) {
+				dev_kfree_skb(nskb);
+				dev_kfree_skb(skb);
+				return NULL;
+			}
 
 			/* add in the header checksums */
 			if (skb->protocol == htons(ETH_P_IP)) {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e..f4c092b78006 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4280,8 +4280,8 @@ void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
 int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
-__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to,
-			      int len);
+int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
+					u8 *to, int len, __wsum *csump);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int len,
 		    unsigned int flags);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..4ac2b476b0a9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3620,14 +3620,74 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 }
 EXPORT_SYMBOL(skb_checksum);
 
-/* Both of above in one bottle. */
+/* The frag_list part of skb_copy_and_csum_bits().  It's out of line so that
+ * taking the address of csum2 doesn't cost every caller a stack protector.
+ */
+static noinline int skb_copy_and_csum_frag_list(const struct sk_buff *skb,
+						int start, int offset, u8 *to,
+						int len, int pos, __wsum csum,
+						__wsum *csump)
+{
+	struct sk_buff *frag_iter;
+	int copy, err;
 
-__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
-				    u8 *to, int len)
+	skb_walk_frags(skb, frag_iter) {
+		__wsum csum2;
+		int end;
+
+		WARN_ON(start > offset + len);
+
+		end = start + frag_iter->len;
+		copy = end - offset;
+		if (copy > 0) {
+			if (copy > len)
+				copy = len;
+			err = skb_copy_and_csum_bits(frag_iter, offset - start,
+						     to, copy, &csum2);
+			if (err) {
+				/* The child zeroed its part; zero the rest. */
+				memset(to + copy, 0, len - copy);
+				return err;
+			}
+			csum = csum_block_add(csum, csum2, pos);
+			len -= copy;
+			if (len == 0)
+				goto out;
+			offset += copy;
+			to     += copy;
+			pos    += copy;
+		}
+		start = end;
+	}
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
+		return -EFAULT;
+	}
+out:
+	*csump = csum;
+	return 0;
+}
+
+/**
+ *	skb_copy_and_csum_bits - copy data out of an skb and checksum it
+ *	@skb: source buffer
+ *	@offset: offset in @skb to start copying from
+ *	@to: destination buffer
+ *	@len: number of bytes to copy
+ *	@csump: where to store the checksum of the copied bytes
+ *
+ *	Return: 0 on success, or -EFAULT if @skb has unreadable frags or runs
+ *	out before @len does.  On failure *@csump is not set and the part of
+ *	@to that couldn't be filled is zeroed.
+ */
+int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
+			   u8 *to, int len, __wsum *csump)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
-	struct sk_buff *frag_iter;
 	int pos = 0;
 	__wsum csum = 0;
 
@@ -3638,7 +3698,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		csum = csum_partial_copy_nocheck(skb->data + offset, to,
 						 copy);
 		if ((len -= copy) == 0)
-			return csum;
+			goto out;
 		offset += copy;
 		to     += copy;
 		pos	= copy;
@@ -3648,7 +3708,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		/* Don't hand the caller a buffer with stale bytes in it. */
 		if (len > 0)
 			memset(to, 0, len);
-		return 0;
+		return -EFAULT;
 	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
@@ -3680,43 +3740,18 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 			}
 
 			if (!(len -= copy))
-				return csum;
+				goto out;
 			offset += copy;
 			to     += copy;
 		}
 		start = end;
 	}
 
-	skb_walk_frags(skb, frag_iter) {
-		__wsum csum2;
-		int end;
-
-		WARN_ON(start > offset + len);
-
-		end = start + frag_iter->len;
-		if ((copy = end - offset) > 0) {
-			if (copy > len)
-				copy = len;
-			csum2 = skb_copy_and_csum_bits(frag_iter,
-						       offset - start,
-						       to, copy);
-			csum = csum_block_add(csum, csum2, pos);
-			if ((len -= copy) == 0)
-				return csum;
-			offset += copy;
-			to     += copy;
-			pos    += copy;
-		}
-		start = end;
-	}
-	if (unlikely(len)) {
-		DEBUG_NET_WARN_ON_ONCE(1);
-		/* Don't hand the caller a buffer with stale bytes in it. */
-		if (len > 0)
-			memset(to, 0, len);
-		return 0;
-	}
-	return csum;
+	return skb_copy_and_csum_frag_list(skb, start, offset, to, len, pos,
+					   csum, csump);
+out:
+	*csump = csum;
+	return 0;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
@@ -4001,9 +4036,15 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	skb_copy_from_linear_data(skb, to, csstart);
 
 	csum = 0;
-	if (csstart != skb->len)
-		csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
-					      skb->len - csstart);
+	if (csstart != skb->len &&
+	    skb_copy_and_csum_bits(skb, csstart, to + csstart,
+				   skb->len - csstart, &csum)) {
+		/* Send zeroes rather than intact headers on a payload that
+		 * couldn't be copied.
+		 */
+		memset(to, 0, skb->len);
+		return;
+	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		long csstuff = csstart + skb->csum_offset;
@@ -5057,11 +5098,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			if (!csum) {
 				if (!nskb->remcsum_offload)
 					nskb->ip_summed = CHECKSUM_NONE;
-				SKB_GSO_CB(nskb)->csum =
-					skb_copy_and_csum_bits(head_skb, offset,
-							       skb_put(nskb,
-								       len),
-							       len);
+				if (skb_copy_and_csum_bits(head_skb, offset,
+							   skb_put(nskb, len),
+							   len,
+							   &SKB_GSO_CB(nskb)->csum)) {
+					err = -EFAULT;
+					goto err;
+				}
 				SKB_GSO_CB(nskb)->csum_start =
 					skb_headroom(nskb) + doffset;
 			} else {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 90c0e22c29be..35008785e3d2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -364,12 +364,15 @@ static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
 	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
 			IP_OPTIONS_DATA_FIXED_SIZE);
 	__wsum csum;
+	int err;
 
 	icmp_param = from;
 
-	csum = skb_copy_and_csum_bits(icmp_param->skb,
-				      icmp_param->offset + offset,
-				      to, len);
+	err = skb_copy_and_csum_bits(icmp_param->skb,
+				     icmp_param->offset + offset,
+				     to, len, &csum);
+	if (err)
+		return err;
 
 	skb->csum = csum_block_add(skb->csum, csum, odd);
 	if (icmp_param->data.icmph.type <= NR_ICMP_TYPES &&
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 3396f177a18d..f7da4538d05b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1162,9 +1162,14 @@ static int __ip_append_data(struct sock *sk,
 			data += fragheaderlen + exthdrlen;
 
 			if (fraggap) {
-				skb->csum = skb_copy_and_csum_bits(
-					skb_prev, maxfraglen,
-					data + transhdrlen, fraggap);
+				if (skb_copy_and_csum_bits(skb_prev, maxfraglen,
+							   data + transhdrlen,
+							   fraggap,
+							   &skb->csum)) {
+					err = -EFAULT;
+					kfree_skb(skb);
+					goto error;
+				}
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..31ca3da80b1f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -322,9 +322,12 @@ static int icmpv6_getfrag(void *from, char *to, int offset, int len, int odd, st
 	struct icmpv6_msg *msg = (struct icmpv6_msg *) from;
 	struct sk_buff *org_skb = msg->skb;
 	__wsum csum;
+	int err;
 
-	csum = skb_copy_and_csum_bits(org_skb, msg->offset + offset,
-				      to, len);
+	err = skb_copy_and_csum_bits(org_skb, msg->offset + offset,
+				     to, len, &csum);
+	if (err)
+		return err;
 	skb->csum = csum_block_add(skb->csum, csum, odd);
 	if (!(msg->type & ICMPV6_INFOMSG_MASK))
 		nf_ct_attach(skb, org_skb);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..d259e7dca8ba 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1724,9 +1724,14 @@ static int __ip6_append_data(struct sock *sk,
 			skb->transport_header = (skb->network_header +
 						 fragheaderlen);
 			if (fraggap) {
-				skb->csum = skb_copy_and_csum_bits(
-					skb_prev, maxfraglen,
-					data + transhdrlen, fraggap);
+				if (skb_copy_and_csum_bits(skb_prev, maxfraglen,
+							   data + transhdrlen,
+							   fraggap,
+							   &skb->csum)) {
+					err = -EFAULT;
+					kfree_skb(skb);
+					goto error;
+				}
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index d8d8842c7de5..5d780ad4ae3a 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -49,7 +49,9 @@ xdr_skb_read_bits(struct xdr_skb_reader *desc, void *to, size_t len)
 	if (desc->need_checksum) {
 		__wsum csum;
 
-		csum = skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
+		if (unlikely(skb_copy_and_csum_bits(desc->skb, desc->offset,
+						    to, len, &csum)))
+			return 0;
 		desc->csum = csum_block_add(desc->csum, csum, desc->offset);
 	} else {
 		if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
@@ -142,11 +144,6 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 	desc.csum = csum_partial(skb->data, desc.offset, skb->csum);
 	if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
 		return -1;
-	if (desc.offset != skb->len) {
-		__wsum csum2;
-		csum2 = skb_checksum(skb, desc.offset, skb->len - desc.offset, 0);
-		desc.csum = csum_block_add(desc.csum, csum2, desc.offset);
-	}
 	if (desc.count)
 		return -1;
 	if (csum_fold(desc.csum))

-- 
2.55.0

