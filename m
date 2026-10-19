Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257814F96A5
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417860; cv=none; b=ZzPZ/WKFUQfleo+f4TRvIe0+CHosYy/2G8ZcMBxEMKZ9I/UWTknNSuAqjj07lTgAg1hXGUCVLMX23qfa0ZGOJGYAamJBdeqE3FygP1bIU8/mml1qoxiNRd8HNamWmtdKyYGpa9ZfNBmO8M1Iw9SzApoYpACWe/T5jBlet7+yvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417860; c=relaxed/simple;
	bh=dL3q9YRxfCrEbWcizXq9oznfRWHecZyPcn5ovtK2fxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkibP2yRPM5VDvx10ax358cU4+CydPdt8o2i9UDO0DZOjYcxQNxvCh5IBC0g1Yyu6R7lQ3Crkrcse8vQtEkciGq9V9cAKkGqz9B5tXWXdGKD3EL9EiKDzl3CwqqD4CuzOAed9uQi6sr6wKkTAdqbih8DXj965S40sx/pujpMgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ag2NkosX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ag2NkosX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917d595138fso14196896d6.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417856; x=1793022656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qblwx7bbNy5k368b4HO2T3MytVs1L8oRqcYO8Zy3rtU=;
        b=ag2NkosXbXP2wHldeSYkodzXu585n6z9+p7yC273RbkZV/yGO95HEq1G+SF/74UjHo
         Erp6xkpwBEWdoi9rsFviwV94ssbQJJeJ+bX79/yVIqTVigntQlJUDVLLbPAY3ORsalHX
         pz5dGsbd9hCNBnR9WZo8a+Gs1P8xwl3dAtIORn1EvzO2vB4+UR0c0HBftq8ndcVk9f6M
         R0BZu5Tz+RVQ86HwBM2OxrKpMzSXXCDsJZiJwqu1aHdi4cT7R/uPgyvq0P/1h42Bx3Iv
         ougeDci75KO2oqHtyHPEMO9e90YDhHi8s8QhGH9VuaNvpiHiftPZsgH90RYvOsCueCaT
         by1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417856; x=1793022656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qblwx7bbNy5k368b4HO2T3MytVs1L8oRqcYO8Zy3rtU=;
        b=cwA2oYWON0EaPtF6kVbioD4EGhLvx6CZtByuaLonCqWEnLMhnsvnHI+n8RiiYAAzBB
         fBY5LhFTvSAdMWty0q5PBpm0KTIKLhjECBcc7gcRaaYXsL0U8nxiu50TgUNBTvmXcVdo
         051iafn9ypiY3sB7U4vwDTF8ZHiVhbo1Vxtjt8//jLWYT1IOTzaSJIDED+yxXjiv4u4g
         VSOwxfSMpELnvir03N9BOe6O1RDGPTi664a//T4ZVW8Dmn9R4+CTwGGx9AMN5IVe5HPa
         Ttv2YjRRjzfIQo4fWUEq6n+6Znwfj/gdLIdOnQXpWkccQxJDU0ACw5f01h8CD4wlwGul
         Wk+w==
X-Forwarded-Encrypted: i=1; AKwUvBypT/4Yc1uTeL8NzHFoH+E4eacfbdsDumutoi8OGvz7kIfsqE1G3TLAKo0mwskiXjtC+i87xuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnmeLJeFOqpXYIqwMd5NVgP757s+HHcL/NzOfBt1hL9Mbz7TLy
	HIkgK6oE5GiQRYnbnbr6t4cAw6xigVqOdjmzqOUM0xgfk1EPhJyOWKhtbQjr7n7RBNE=
X-Gm-Gg: AYBFou2myMGjdJe2y6q+3SVlOcw4IGyVgDjIlTyPSkZlDaJrPBk6zhkP8gpoD86CdjW
	a9WZ+Jh9AJ6fNQcoIhH4FiTN7eJqaQ9AFYkbFz7TbhfvWJvRe109gXEe2UI7nQ0lfEYIfUmjfaw
	rU1T6871KTjEespOVr5BhJruLqRwVU3tVU33bWHjJOUY/QjjLSbTJ1S2cdJMiAvYVi/Y26eHnEn
	C4VkEHoErKDosRd2Gxfwa0D5YZe0/IIt4QsvMCEpHJSk2/LLyHRTQzx/7AMHfZsOuHxx9mT8HvI
	bDGXonrOxhydnyeK2SW8o9zfRqc9FEisWnQGv9KHxdh2EmrAzUPri6A10sgVdzPtCavlBgS2xQA
	4nBjUU7vkz9p9DdKWYyR0qxBw4f1RnttJTZRjy0IMvOp7LHypPll0uhxgogEY6I0/vy6NH54gwN
	2fRy3HkBqUNF/4JTMXYiKZ+JT996ZdUE6HM3uqLthW2C2mCJhHwHpEpNcpq9Y800swKD7C/gA7c
	Ie0SqAt9FFU56AppYPPGCm6eTg4S13+N+S0YwLRYNjktMAeWwpCN7o1SMrSURs1pFjwGzyn
X-Received: by 2002:a05:6214:44a0:b0:917:a4d9:1373 with SMTP id 6a1803df08f44-91bdf127eaemr121313976d6.23.1792417856134;
        Mon, 19 Oct 2026 06:50:56 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbaae645sm99626496d6.21.2026.10.19.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:50:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:35 +0000
Subject: [PATCH net-next 01/15] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-1-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=13888;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=dL3q9YRxfCrEbWcizXq9oznfRWHecZyPcn5ovtK2fxY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmxDJSAVza1wipmMQxYPi6qoFImua7iVjrYNs1kkIjpC41hXs6QTatTN021+n+ilY/mobmNNiA
 3jVRJaLK4rw0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_bits() has no way to fail.  When it reaches
unreadable frags it zero-fills the rest of the buffer and returns 0,
and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
the buffer.  Its callers can't tell the copy didn't happen.

That matters in the !sg && !csum branch of skb_segment().  A devmem TCP
skb keeps its whole payload in unreadable frags, so every segment ends
up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
checksum over it, and the peer accepts the zeroes as stream data.  This
is reachable when both SG and TX checksum offload are turned off on a
device used for devmem TX: sk_setup_caps() still gives TCP SG and
HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
lets the skb through for a NETMEM_TX_NO_DMA device or a matching
binding, and software GSO segments it with neither feature.  Before
that commit the segments carried uninitialized memory with a checksum
that almost never matched.

This was reproduced with a test module rather than on devmem hardware:
skb_segment() on a TCPv4 GSO skb with 3000 bytes of payload in a page
frag marked unreadable, with features == 0, returns 3 segments whose
payloads are all zeroes, each with a checksum of 0, which is correct for
zeroes.  There's no warning or error; the data is silently replaced.
With this patch skb_segment() returns -EFAULT.

Make skb_copy_and_csum_bits() return 0 or -EFAULT and hand the checksum
back through a pointer, and make it __must_check so a new caller can't
ignore the failure.  Running out of skb before @len returns -EFAULT
too; commit 417261779eab ("net: skbuff: don't BUG() on leftover length
in skb_copy_and_csum_bits()") made that a zero-fill and a checksum of 0.
Each caller takes the error path it already has for a failed copy:

 - skb_segment() fails the segmentation, as the csum branch already
   does when skb_copy_bits() fails.
 - icmp_glue_bits() and icmpv6_getfrag() return the error, so the ICMP
   error isn't sent.
 - __ip_append_data() and __ip6_append_data() drop the new skb and
   return -EFAULT, as they do when getfrag fails.
 - vnet_skb_shape() fails the same way it does when its skb_copy_bits()
   call fails.
 - xdr_skb_read_bits() returns 0 without consuming anything, as it does
   when skb_copy_bits() fails, so desc.count stays non-zero and
   csum_partial_copy_to_xdr() fails.  csum_partial_copy_to_xdr() used
   to checksum the bytes it hadn't copied before checking desc.count.
   desc.offset and desc.count always add up to skb->len, so that only
   ran when it was about to fail anyway, and on an unreadable skb
   skb_checksum() would WARN.  Drop it.
 - skb_copy_and_csum_dev() can't return an error, so it leaves the
   checksum alone and the frame goes out with a bad one.  Its callers
   are drivers that never see unreadable skbs anyway.

The zero-fill stays, so a caller that does send the buffer still
doesn't leak anything.

This was found by the Sashiko AI review of that commit, and
Mina suggested reporting the error from the helper rather than checking
for unreadable frags in skb_segment().

Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
Suggested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/sunvnet_common.c | 10 +++--
 include/linux/skbuff.h                    |  4 +-
 net/core/skbuff.c                         | 63 +++++++++++++++++++++----------
 net/ipv4/icmp.c                           |  9 +++--
 net/ipv4/ip_output.c                      | 11 ++++--
 net/ipv6/icmp.c                           |  7 +++-
 net/ipv6/ip6_output.c                     | 11 ++++--
 net/sunrpc/socklib.c                      |  9 ++---
 8 files changed, 83 insertions(+), 41 deletions(-)

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
index af1cbc2799b7..09db32f70b53 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4277,8 +4277,8 @@ void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
 int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
-__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to,
-			      int len);
+int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
+					u8 *to, int len, __wsum *csum);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int len,
 		    unsigned int flags);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 93c2f440b9ec..a2b52a5a61a9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3630,14 +3630,27 @@ EXPORT_SYMBOL(skb_checksum);
 
 /* Both of above in one bottle. */
 
-__wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
-				    u8 *to, int len)
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
 	struct sk_buff *frag_iter;
 	int pos = 0;
 	__wsum csum = 0;
+	int err;
 
 	/* Copy header. */
 	if (copy > 0) {
@@ -3646,7 +3659,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		csum = csum_partial_copy_nocheck(skb->data + offset, to,
 						 copy);
 		if ((len -= copy) == 0)
-			return csum;
+			goto out;
 		offset += copy;
 		to     += copy;
 		pos	= copy;
@@ -3656,7 +3669,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		/* Don't hand the caller a buffer with stale bytes in it. */
 		if (len > 0)
 			memset(to, 0, len);
-		return 0;
+		return -EFAULT;
 	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
@@ -3688,7 +3701,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 			}
 
 			if (!(len -= copy))
-				return csum;
+				goto out;
 			offset += copy;
 			to     += copy;
 		}
@@ -3705,12 +3718,16 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		if ((copy = end - offset) > 0) {
 			if (copy > len)
 				copy = len;
-			csum2 = skb_copy_and_csum_bits(frag_iter,
-						       offset - start,
-						       to, copy);
+			err = skb_copy_and_csum_bits(frag_iter, offset - start,
+						     to, copy, &csum2);
+			if (err) {
+				/* The child zeroed its part; zero the rest. */
+				memset(to + copy, 0, len - copy);
+				return err;
+			}
 			csum = csum_block_add(csum, csum2, pos);
 			if ((len -= copy) == 0)
-				return csum;
+				goto out;
 			offset += copy;
 			to     += copy;
 			pos    += copy;
@@ -3722,9 +3739,11 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		/* Don't hand the caller a buffer with stale bytes in it. */
 		if (len > 0)
 			memset(to, 0, len);
-		return 0;
+		return -EFAULT;
 	}
-	return csum;
+out:
+	*csump = csum;
+	return 0;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
@@ -4006,9 +4025,13 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	skb_copy_from_linear_data(skb, to, csstart);
 
 	csum = 0;
-	if (csstart != skb->len)
-		csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
-					      skb->len - csstart);
+	/* On failure the rest of @to is zeroed; leave the checksum alone so
+	 * the frame goes out with a bad one.
+	 */
+	if (csstart != skb->len &&
+	    skb_copy_and_csum_bits(skb, csstart, to + csstart,
+				   skb->len - csstart, &csum))
+		return;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		long csstuff = csstart + skb->csum_offset;
@@ -5057,11 +5080,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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

