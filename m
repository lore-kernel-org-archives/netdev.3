Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590430;
	b=jkkUQkj0whmnFDNimZsT8iyIchHxCZI1DUFg7HmEcaq4JtcNiG+V2k9Z3XOFXmdvKXeC
	 lXJkeLMFKSrO87stDwfqxxUReOuq7iFBydUGjeTyZxkaIw46LZVvxVP+eE9skcg4r/zKh
	 I1BDgDzn946TYxJaOR9wFaF9u/LUUjpg20v4f76hfldr4aBbkJXTxyilCzfdWXs8rnnlV
	 /aMlO5o5aLP47thMmlQdNf/tuhAI3VWefQpLEeHUge74MXTZfuXndQlrUOXiMDNK5ciQm
	 94fj1Etz++ptLXCcmxq+VvUleM0I7/aGOjJsLCxDRjSg/4+n6wsm7Jj8myjr3q73x7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qblwx7bbNy5k368b4HO2T3MytVs1L8oRqcYO8Zy3rtU=;
	b=gN6NL/59fBuvLB9AYyY073PjSmu/KNmNUcuPNjNjvp0sHFXsVxEjCf8ZoYroUbRqDAhB
	 VgmW77dQ15b/UJMnam6kyt2WB/qb86O2SBvIML2s/AByF2jS6zqnIXb0UQldjisnkOjxY
	 lSeDHbiSUlSO8R7bwwZOetcqP7baTbdZM9z4ukXS7fa4YQG+o+ibLzSz659BzE0JAl4p8
	 2Vt9sbiC/gxfwztymBxRBrqqmkJk7Lrf8LPjpxRrWmECdGRM/8y//y1khaE+K6MUwV9iX
	 Vd/00ZupAR3PKXu+q9xp++VW2xLJUJse9QvZG9bl+AZkKahXFwICzH9BH69O7zNBvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EcvLzyTC;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D360A2600
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131D360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EcvLzyTC
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91befbcad6dso13332816d6.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590429; x=1793195229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qblwx7bbNy5k368b4HO2T3MytVs1L8oRqcYO8Zy3rtU=;
        b=EcvLzyTC58kbRcxUD+q5tdJsEFIpz2msrJPAuo6aXO+6i1hLB7bEZwjleHxd7UD6Ya
         aMtssUun4H9vQBZL4c7A3qqPWNf/ptTdf9vq9E+hgkydUcoVnnvZgCHKMN3QnxfxQua6
         830Xn7npTu4eIbQVtzM9o3lJ3YtpeY8Mnr1bJc8bIGA60HGeJFkDvGy+8gg1EeDt45OT
         Pr2Epvzm7+0chSSC1YkV9TiLH7HLnbSDdnYfCXFL3Ip4G7KW7AEClr0CNKSqU8fmyREq
         I58Gd/Do1/Wt1BhURRhpFa/x1WbEftJUdDCuBSuc2dcrOtcioamJwL4dDr5JtPj21MG3
         3myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590429; x=1793195229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qblwx7bbNy5k368b4HO2T3MytVs1L8oRqcYO8Zy3rtU=;
        b=jdt6WsjGhSwGEAM+HuCUUV0DwILUUntWLM5Ophw/dR839vvCSRzQ8vXLXLY1OfGO60
         VUILOZAgwOLywdm316Ocq0VNA3SmS3yusch+vmX7BPCNGlaRAoZZN5MBaoaYmxAemUS3
         dMF1dHQBkUgHhh5uC7lNq7cD7EW+PJEs35vfKEdqY3DnPxxEexndxmMIsSEP+0q9ihl9
         RkgKvdZA408f1Bs6+aen5Hs0MMhzfztU7zymm3Tz2BnXoYCPn+jMGWqM3bChjl0NXbg8
         E3dWwYio80KsGwip2jIW2+AIfyQE6IqvGqHVcfrHLJjTdPtjmNP1CoO/9piypk3OK10z
         rr7A==
X-Forwarded-Encrypted: i=1; AKwUvBwcJTWloU5eHC8PzWH2aAVF2YzJWIbdhpfjk3VmScju19C/XotejSTGJu4wmFnrn/H0Ppb+QVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI7caOlp4XXT5/DHbTui44Bzv3GsZqDs9RQj9btUtOG98VBuwe
	pBoc3bTxX7tDxJz9ndKe2X2hmVTKOwnA3GxT1HpxPG4TbIhFpyUqpd+jkFTiVdNtX2palXhzyHs
	NydC4
X-Gm-Gg: AYBFou323wHrRATNEfu1bcwj8T13OYKwaKNRgwKpO+MCje6EcyLqPfHX9kP6LFGIQ1d
	olaRSNmcXgSnpAllhKUnzdh0jRIKDncyKKRD/b7yl6P7FWhze/My+OYULtEeQJ9h6gjYjBn7efA
	xqQ4BoZ4gG385/nEf7lrbnOkQpRaODld8fDUpPFVDpegluJgPGU2DjmWIpIlX8BFiTTuV1XC9dj
	EaxjHlbeLNB8r9bJ8VBEktfotU0Sp2cseM1+fZGXiJTvWltm6WyobrOHjJMVYHJ4bSAyVCtI29B
	4Xd3KbVBqm8xscxxpug3tpYiFTh+NQKZI3jpoMJ7QSuWRGgcDcqeVLcdfgIUOB/4ehhJLw2Z5D4
	Cj6361mPn9KIOyrBpqJEBY4M6arbjJObVOLKbw07Rdwcm/H8a+5BMea3XsS41J7SiG5vgl/HsQH
	CQVh3b3CTeYBgCabgS70n5nhmI+vAMrPnjp90xa7m7OGeMgvIl2lk33rAOhEpv2TJmdjMv2y55N
	x3kllcTbiauNkaILTvDztAj5hYGaeOhQOOcDst9HpWTO2EvCx6jeccjxLGKFEQxAreOy6rx
X-Received: by 2002:a05:6214:4b11:b0:917:fadc:2f21 with SMTP id 6a1803df08f44-91c12f01d19mr33872926d6.41.1792590428703;
        Wed, 21 Oct 2026 06:47:08 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c5002bsm24928116d6.42.2026.10.21.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:45 +0000
Subject: [PATCH net-next v2 01/15] net: skbuff: make
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590422; l=13888;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=dL3q9YRxfCrEbWcizXq9oznfRWHecZyPcn5ovtK2fxY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLjOa2jk/RqfHBEHNl98PapaCIgqg156sTloid5SLqvbbvhKLKBISHp0ZjIrUQ3V73NPcL7eVfA
 LaF6it8760wk=
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

