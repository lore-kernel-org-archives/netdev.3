Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672930;
	b=jemhUoPnB9MrO0rNLnNW0yKbIJ4V6TTO7gzA2O+peszW3CE+5AY/tkxvuYosQx2QOhxa
	 G/C5WBFrq9QjAtbpdXATyWMrkB92ceAUbUtXhqc9Swd+YJ7MGRx/LPQz64wpBdOwIdQK+
	 8zCNUwrGc2LD/5DSzif1t8aIhUjCCCRUvd6ME+oDXKmluPMIqpRcHiotxEuhiLL7b5N9V
	 bqASGuCHFZJWxio4/TWqfS2GJPwXXSh+Z4OyeO+L//Pao+rFayuEauFJD1xrHjIweEcXx
	 IhfCPf0LPiRRS7Ayv5poga8bWMvbPvG2MUOg0F2LaSXs+xZCK2904D7YPmKyZmlEAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+ozleYq79PAzQSOQnNjxaTI69FhB0adJYpSCNMdxkqo=;
	b=MRx24saJyIjNrcg0K3gAzi6TcvP4Gkig2eqwI4jDPO5iD75l0I9Msn7ES84dcumOJMvG
	 x0UT128jetLoUnZW2+lw84+3q8Xj6WB/g/cNrXc0yMgoQH+LSsmNS3yiVGPGRdQPeN9WZ
	 yGaHmtdG39txaOJDdjNz/WkY0SJ2th9fxz3Ohaubczu/jnEeRPpqBuj/uxVYEaByZ/87+
	 sDe+ik4pfKDpqdnJ53n6YOsHQ8M96htxDnipCg8DIRDBJLANa+KO45ao12dL6YR9xui4u
	 MF4GJcu5pYlvFXjzFoQ8Gdzl1M6btRqNGj/klVwCVz2BhUjBwJ4+3EifjQ8KmhY5HdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RJoaaxa3;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44217606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44217606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RJoaaxa3
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53665358476so43039521cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672929; x=1794277729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ozleYq79PAzQSOQnNjxaTI69FhB0adJYpSCNMdxkqo=;
        b=RJoaaxa3rFNrGgRo6UyHPUsr2ZdqYlEUIHOVvDQtbJuDPp3766m1xvQRsoRlBAOT6X
         Se5DmeNf2L5IBkFgp4ezUdn1xyTV3rhxSvGR6fMaI9z/Tw3r4wKIhDSEw8D+lRlML3G2
         uh48uNhA+utV1EgZAitpRmAGXeGflxfgUG8LqVzzv86LkO58PeSPALwnqiBgfKnP4Beg
         1kDlm5S9WsTNHGpqbp1Fu37Q9d3aoLt5CQCOTw9ZWcOVwoO0e0tY0dl1gqMk7iJ4KVuQ
         mNJ2vOo9gJMr8oDJqIILKk5N1l16fzBYkBHqzYj1TDi1xAsL1OfZf2v7HBM1W6PRqcZ1
         ALqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672929; x=1794277729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ozleYq79PAzQSOQnNjxaTI69FhB0adJYpSCNMdxkqo=;
        b=UOPpHb8v1Jz7hRbUNwxucvBxNxIiC8qv/ZNUlBNOqY0GpNygmvk/w691W3OUESKhL+
         vAYdfwtrm/mQPcQAeicnwB7lg3J197eWvrpLQ6WGTz/fAo+jlTx1YPbnffJkT8odlMbo
         M4mDcLZ5yT5AQAiYTBb7jnkUhXc5XQoPKrUW/tFUmtn2kO53DhebQWCORR7pWNBg7buF
         JW+a+rscVchG8UY95iZcNBqPIwXEInD806hg7wsqi58BWBEq7azUju8QFqcZFSmrOuBw
         Drh2yShfI6hrYV0zORt0rRWquKY/CDWJKUoDS2MabgpXhRFvEoMT2TWrkt9ECDBgDmtk
         WCJg==
X-Forwarded-Encrypted: i=1; AKwUvBzkyWbJYlwPCJBQjp0DTkfcWpGgffVTrWoJnINk9iFGPsZc0Ou5Sd8SKa2JaYX8paj0z51ccOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpBUI1idhAI8NWnEw/PtQ7aD374lUUqkGukE7xHNN2QSAYciEg
	fqwrfG6WrXSaqUSZ5NFVj26ZsDV/4fxzQnCJn8klUcR6G/EzXokCHLcoxOOf7f8KaFc=
X-Gm-Gg: AYBFou1aqRcSHzt3ruEvvFpS4XqsyaISsFp3dhUt3pedDDfKTV/pjOUCWcAGvFDzYDU
	r3uAHAzt2WXRL243UQMqWUk9paMF4sfLXmwm10hCnrzlOJLP7vU+JbpNMGaCR8hce7NODB4B8Q+
	TZtpTeIwH4ZqYu+ZMywNKWEworXdZwC/ANzUVJRGUkSIWHGzgGXKZv7mV+fURKpAyUqf6O/Amrj
	DcacICGt4bPO6bBN1qUztU6wp9jbeni9QyIVF5AzhuCfnFWDQmAA5thOun07amQZFuW5N+qQkFk
	EdeTc6jZXVjvNngBQbEEU5dlwU//tRkq7R7Gjf7ZmQGXYIXErFW+QIgavY2wa0X34MxhphIN3rc
	rG2jGGbGtYBg6q8hKeGrd/kWyBP60Yr5TkvbINm89/oNk9VGq9H6GE8HTpTGI6Ju/AV2W1up29P
	CmZp8aZthIctMgrWBm7RVzAdTtaSXuI/SiEjsRSE2gjYWNATRmNg+qIragUMjnLSSpErdOVUzEN
	A2tevrKwM0qgaKrJ8TmGxpOLfzkj3KVV2/aPdE8WV1sUS2ZkoS/+MOw8CGQUdwduJe7VbZmmS/h
	uJK83Q4X6qz0SvGQjrc/LSiZDfMLZ2R+bLgIWCl528QsbQ==
X-Received: by 2002:a05:622a:5a18:b0:535:1f5c:e489 with SMTP id d75a77b69052e-542b3c7654amr201014651cf.5.1793672929169;
        Mon, 02 Nov 2026 18:28:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49dcbasm13852001cf.6.2026.11.02.18.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:28 +0000
Subject: [PATCH net-next v3 02/15] net: skbuff: add skb_checksum_full()
 that reports failure
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-2-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=7462;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=iRXaavMuCCaIGwQeEKD5PODE5O9BI1CI4qAS/RRmb+g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFbzfrMZOtH7r3Qw/39UwgOlx0VaLuRXbKWQmLqAJvZ0BPoJPrHv+hz+CnhxLSOHCSomsdC80Mi
 ocS25mNUyyQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_checksum() can't fail.  When the range runs into unreadable frags or
past the end of the skb, skb_checksum() returns 0, which is also a valid
checksum, so its callers can't tell a sum from a failure.

Add skb_checksum_full(), which adds the range's sum to *@csump and
returns 0.  On failure it leaves *@csump alone and returns -EFAULT, or
-EINVAL for a negative length.  It is __must_check.  Its frag_list loop
sits in a noinline function so that taking the address of a local
doesn't give skb_checksum_full() a stack protector.

skb_checksum() becomes a wrapper for the callers that aren't converted
yet, and still returns 0 on failure.  Three things change for them:

 - When a frag_list member fails, skb_checksum() returns 0 for the whole
   range instead of the sum of the parts it could read.  Neither value
   is the checksum of the range.
 - skb_checksum() only warns about unreadable frags if @skb itself has
   them.
 - A negative length returns 0 instead of reaching csum_partial().

Convert skb_checksum_help(), which can already return an error, so that
a packet that can't be checksummed is dropped instead of sent with a
wrong checksum.  The following patches convert checksum validation,
skb_segment() and pskb_trim_rcsum().  The rest will follow per
subsystem.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |   2 +
 net/core/dev.c         |   7 +++-
 net/core/skbuff.c      | 111 ++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f4c092b78006..608c1491597e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4282,6 +4282,8 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
 int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 					u8 *to, int len, __wsum *csump);
+int __must_check skb_checksum_full(const struct sk_buff *skb, int offset,
+				   int len, __wsum *csump);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int len,
 		    unsigned int flags);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..00a62c391056 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3665,7 +3665,7 @@ void skb_warn_bad_offload(const struct sk_buff *skb)
  */
 int skb_checksum_help(struct sk_buff *skb)
 {
-	__wsum csum;
+	__wsum csum = 0;
 	int ret = 0, offset;
 
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
@@ -3697,13 +3697,16 @@ int skb_checksum_help(struct sk_buff *skb)
 			  offset, skb_headlen(skb));
 		goto out;
 	}
-	csum = skb_checksum(skb, offset, skb->len - offset, 0);
+	ret = skb_checksum_full(skb, offset, skb->len - offset, &csum);
+	if (ret)
+		goto out;
 
 	offset += skb->csum_offset;
 	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
 		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
 			  offset + sizeof(__sum16), skb_headlen(skb));
+		ret = -EINVAL;
 		goto out;
 	}
 	ret = skb_ensure_writable(skb, offset + sizeof(__sum16));
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4ac2b476b0a9..c5f8aca89221 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3536,27 +3536,88 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 }
 EXPORT_SYMBOL(skb_store_bits);
 
-/* Checksum skb data. */
-__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
+/* The frag_list part of skb_checksum_full().  It's out of line so that taking
+ * the address of csum2 doesn't cost every caller a stack protector.
+ */
+static noinline int skb_checksum_frag_list(const struct sk_buff *skb, int start,
+					   int offset, int len, int pos,
+					   __wsum csum, __wsum *csump)
+{
+	struct sk_buff *frag_iter;
+	int copy, err;
+
+	skb_walk_frags(skb, frag_iter) {
+		int end;
+
+		WARN_ON(start > offset + len);
+
+		end = start + frag_iter->len;
+		copy = end - offset;
+		if (copy > 0) {
+			__wsum csum2 = 0;
+
+			if (copy > len)
+				copy = len;
+			err = skb_checksum_full(frag_iter, offset - start, copy,
+						&csum2);
+			if (err)
+				return err;
+			csum = csum_block_add(csum, csum2, pos);
+			len -= copy;
+			if (len == 0)
+				goto out;
+			offset += copy;
+			pos    += copy;
+		}
+		start = end;
+	}
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EFAULT;
+	}
+out:
+	*csump = csum;
+	return 0;
+}
+
+/**
+ *	skb_checksum_full - checksum a range of an skb
+ *	@skb: buffer to checksum
+ *	@offset: offset in @skb to start at
+ *	@len: number of bytes to checksum
+ *	@csump: the sum to add to; on success the range's sum is added to it
+ *
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	runs out before @len does, or if the range goes past the linear area
+ *	of an skb, @skb or one on its frag_list, that has unreadable frags.
+ *	On failure *@csump is not changed.
+ */
+int skb_checksum_full(const struct sk_buff *skb, int offset, int len,
+		      __wsum *csump)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
-	struct sk_buff *frag_iter;
+	__wsum csum = *csump;
 	int pos = 0;
 
+	if (unlikely(len < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
 	/* Checksum header. */
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
 		csum = csum_partial(skb->data + offset, copy, csum);
 		if ((len -= copy) == 0)
-			return csum;
+			goto out;
 		offset += copy;
 		pos	= copy;
 	}
 
-	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
-		return 0;
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
@@ -3585,37 +3646,31 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 			}
 
 			if (!(len -= copy))
-				return csum;
+				goto out;
 			offset += copy;
 		}
 		start = end;
 	}
 
-	skb_walk_frags(skb, frag_iter) {
-		int end;
+	return skb_checksum_frag_list(skb, start, offset, len, pos, csum,
+				      csump);
+out:
+	*csump = csum;
+	return 0;
+}
+EXPORT_SYMBOL(skb_checksum_full);
 
-		WARN_ON(start > offset + len);
+/* skb_checksum() has no way to report failure, so it returns 0, which is a
+ * valid checksum.  Use skb_checksum_full() in new code.
+ */
+__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
+{
+	int err = skb_checksum_full(skb, offset, len, &csum);
 
-		end = start + frag_iter->len;
-		if ((copy = end - offset) > 0) {
-			__wsum csum2;
-			if (copy > len)
-				copy = len;
-			csum2 = skb_checksum(frag_iter, offset - start, copy,
-					     0);
-			csum = csum_block_add(csum, csum2, pos);
-			if ((len -= copy) == 0)
-				return csum;
-			offset += copy;
-			pos    += copy;
-		}
-		start = end;
-	}
-	if (unlikely(len)) {
-		DEBUG_NET_WARN_ON_ONCE(1);
+	if (unlikely(err)) {
+		WARN_ON_ONCE(err == -EFAULT && !skb_frags_readable(skb));
 		return 0;
 	}
-
 	return csum;
 }
 EXPORT_SYMBOL(skb_checksum);

-- 
2.55.0

