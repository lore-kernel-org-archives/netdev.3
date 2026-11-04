Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825273;
	b=Nh1E+Q0WeJ10pxP2Sosv9FMQixFGRRhedlSWLaWZEYUwboaC0bMVLHf6rA+KHu9Bu+PU
	 SHAdAtlTEcWnMvZCwanEYtWaSVilV/WjxsylgZ9Ob8LSgkaspCszxyeT1zlrrgkkGu/8b
	 R/REgX75EWhK2nmk0/+q74Cyk1vDGDM31N9kzQuRE3OCp5eU71go6pXRZTyhrMqMrJuaB
	 +5NDOR9tWVPShlhweDZs+khYDkb4k2816mr5Z9rSPISD8qsFJj9Dypklxp1qPNrxwYy3w
	 FTUiu8hW3LNMmCpDqOJPkgQn6aQwwkh8u26RXEzd77rPOW2WP0nitBGzw5vXGKccMpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gH271GlUICfDLFVrS64JI/r5nC3Lsa5y8Cpm0L9A1DU=;
	b=umFCpTJ+u6uZF/4ZdcCzH3i/fWVzaQnIlW/Hl8DaloOasbTD/wgxUpCVxZGlbV9xbK08
	 e2vIrOsVRwvbHr/4s3BdHkgkBbmm42doMkiS6kXpLb+DhGD9v71yq1xfmXHxUKBxljwhm
	 I26A9ZuvURf6+0I4aX+2wvwH8oldtltUUxpXhfvPgfb3MkmNzuedWahoUDfuobGcXgrZd
	 0xEOI5QKiVuvTqjZQmXZYQ2PEboAq3/bG/i05SzAFpx8iyHJtp7rMY957WQDAthtUjxrm
	 gYQYCr5rmtpqIDcgJCtKgfe+L71ZTwZt9UKZKztDdZrx+RlN3+YK8pCygorrz6SiS9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CVSVQl3Z;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D860960A5
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55D860960A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CVSVQl3Z
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c76540d0bso12576936d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825272; x=1794430072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH271GlUICfDLFVrS64JI/r5nC3Lsa5y8Cpm0L9A1DU=;
        b=CVSVQl3Z20uZyvM63HOXmoiAMyVhqRpjWFkZHPvEfaTWJHkgWokjySyZbXvTaAD6y6
         6owyr9elXtj7Utki8u6TVOL91M5OjltSdsy/5C2gVTEFv5rqUvWOSGqR2AfkXDHvLR9O
         RjThb5t3k8Bv8pNuSIXXiZu3zTToxcWvtaMJMCrJYDTPRY9+9E2HwoEvSzsfIhBvd0sa
         EtbYcFkD2mYURV7ygo+6CroCKBPQ6Hpa54SiqRTe+MKlcZHA+xScvD0JR8oLphvzLH9U
         7kVv0jJpCaXk2IreqDBpPxju7XPM6uOEJb9XHp5PD1t2NcmTVo4uQHnGl2bP6EyeEIwV
         KlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825272; x=1794430072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gH271GlUICfDLFVrS64JI/r5nC3Lsa5y8Cpm0L9A1DU=;
        b=vs1iiHzaFOxOAcrnbo8auyeY5FbibQwT5Nj5b7ti3BkDmFlci4C3il+X1yNhpFKGl2
         Du2IQXfc6l7X+YrDxSufssSuxL706MTAlxL4qMZetbtoIyQUkVwU+kzn9FEq8/fOXCZr
         ELin35YTqFdI8TFFcJ4VW8a67gQi8DgHuRTcO656DbM7sbYFH4YD/wmHPzgLonESMYxU
         HoetgbS5qu4SKlS6jGSfDA/IXJ/GNZF0F5QwrB5MS0La/ahYKgDX6vUxrkRWX39xzFgO
         t6Bs2Vzeg0cFfHDL+UjyoiUlCrp2e6Q9WnwaOqo4P7MN5gEIVG2JQXq9jh8A8cHIVnFE
         g9EA==
X-Forwarded-Encrypted: i=1; AKwUvBxh2qT6xpGsWMQpEYlu22ARlZl0t7l9wkIptf9Y0n8coPDynHl53z12TOMTgJd4nDyxmCiv6uc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KLOWEqIAH8QveAKUObXYT4BFnSAN8i8yge2QDS7tJFfxTrTur
	Fe8unk6uola9MgFqoL5e3JKjbim8Kj9h+db2YiqtEpYZS328ywXiOVDK4gs+yiab1dQ=
X-Gm-Gg: AYBFou3uv+pB5zDUhsx9ie8zbXpnK9TmCbWsTQ9hChgTHJyeeLguWshGOutgG2snIF6
	g7Ldp3RK3YyNXxsuH9EipfVnCIw4xItbZih7YmHUIOtSvupq7l6btJlzjE0np5yJbtSH3LRoXZJ
	642cqk02g2jKwVXzJRL6eTiS7NN+L5YybYZzqyjJEfqDZHgn2xkEDOC4muk/JFEfwTN5Lgj7dOK
	r/x5xD/L67nuXUSyRQNXFVD9W7UYD/ZVCXFk8npSXFgXdl65+eTAWejCvUMsIO7vBvc3QgN5nmB
	xj/YksfqSpQxnCdeS9oKoV5pnpGrK6pthRCd21XQpeBvWQT3cvvvfHTGBgxZydM0xcObq15etBS
	Ps1fL345kzSrMq2tdut8Z6v9gCw67pviS/heE/FDUFa7+rgmn7kWP72R8loCZ2ZSSa7X6W6j0La
	fnr3wvIAbkVJwbjyMsgmgQwcl/xpIIjhUE07QXvUHeqV+fhByQ0mc0i9f9O5Z+EMEPrf+vQoZlJ
	KTW2wRMiYja3I3kUgqhKKE7u6Evo9Qw03PD4orLkySQFYEZvR2CDSexluNoVMEdMUOGPUVSUG+c
	XBuZFfLvTNypEQTp3dMvIwPJB3H9rUd8iniz3O47/KlLlQQgmUvhdgjeZzgj8fifHX2c
X-Received: by 2002:a05:6214:5bc5:b0:91c:7da5:2185 with SMTP id 6a1803df08f44-91ca4bb4a15mr307849916d6.38.1793825271664;
        Wed, 04 Nov 2026 12:47:51 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e8dac2a3esm13006576d6.1.2026.11.04.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:13 +0000
Subject: [PATCH net-next v4 01/15] net: skbuff: make
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-1-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=13813;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EWpLlq8Mw3XxwjVP1ClwIfXj7doLlC4zD1PirZnOhYE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJqO/KYWLso78B3NTCNEG4Z4lztm1S6ZIMPwryAlJHaZV5533DWzIbtoHA2wJ0OEbED8w0X7uPN
 RS3fTmef4xAo=
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

The !sg && csum branch of skb_segment() copies with skb_copy_bits() and
returns -ENOMEM when that fails.  Make it -EFAULT as well, so that both
branches report the same failure the same way.

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
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/sunvnet_common.c |  10 ++-
 include/linux/skbuff.h                    |   4 +-
 net/core/skbuff.c                         | 137 ++++++++++++++++++++----------
 net/ipv4/icmp.c                           |   9 +-
 net/ipv4/ip_output.c                      |  11 ++-
 net/ipv6/icmp.c                           |   7 +-
 net/ipv6/ip6_output.c                     |  11 ++-
 net/sunrpc/socklib.c                      |   9 +-
 8 files changed, 130 insertions(+), 68 deletions(-)

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
index 48f676411724..f52b0717e4da 100644
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
+
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
@@ -5057,16 +5098,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
-				if (skb_copy_bits(head_skb, offset, skb_put(nskb, len), len))
+				if (skb_copy_bits(head_skb, offset, skb_put(nskb, len), len)) {
+					err = -EFAULT;
 					goto err;
+				}
 			}
 			continue;
 		}
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

