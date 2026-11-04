Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825274;
	b=enxvGLtpz19xi9ESbxB/UvWLe4r4X7LJBNzAkYF1Zd3O+K2mUO+w9YuGsDTmTNwbx0TL
	 L19FbK0/g+ZD7TBEgC8HhbSyAGrwVgh+59CR3Z8Mg5dS25jmUz8Nt4N2N074Wl94MlMBQ
	 tVVdf/Haz+3eQkw8MgyMOYIjbX/eLz22yp3WSl9Avpcr5txdaf1F8KWwtt7Y5Ervm9Qdt
	 5jou1AFaovHPEh+xG4aQq8typH5k5gByy2hVlXpSHyM7cwR1Jw0V3Fji8A6Q5d6S2PmeP
	 jI5kgBVQ4r4HcEWtMbZYV6+efdSbTrThlW+1DF4DaxpYfhmKuArTXULWHEuBytk09FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4zFbC/7v49JIwDAMUqTjgaY3Ekh9T54PUOgPwA6tYbI=;
	b=yiSJ8zp/rC5HPYaBWOJnoMa/jh8ijC84p6+i9fWuo4bevzOvjfrHtHI+FhnEf92E/9uY
	 fHvJJ47lyH5J7fu/pjPd4vMP/xeXIpg4BnDApr1b8WX185EwdlxHuKFWLVvkqiKOeVcld
	 YoC8z0jKrjGde03MLO/Lx8j9eEsWd3/uaiH4KKXgJQ9NYW/kr+qK64qvI3L8GCX9mxyUH
	 isQr18Q+JIrZJtYx96rHG/LWPSGTwkFC1jCkj2MIKPnmMODpPKLcEetTCU2lw3pq3k3Z6
	 aISg+z3p3v+AfXCnpiFZIQcmbkx3eA78okIWZVAKDsOzJRP01bxo6yBDWMiUpZPXlww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="Nb/GZcjr";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF796096938
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF796096938
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Nb/GZcjr
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f20b304c0so109589385a.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825273; x=1794430073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zFbC/7v49JIwDAMUqTjgaY3Ekh9T54PUOgPwA6tYbI=;
        b=Nb/GZcjrtbwkwsl4K0nzRbJRuI72Gl3jexl+tYBUWFvZwtLDqz9bH1E1RUwgvCRgGO
         KHGJ9/C6TPinQLS43/WdNKD75HlJS7V6vmy9vvEcXVasILGLdVV2dMmNi0YBZEfNhcgg
         RI4etPPjWP01OuJ16eFOgUdudeMROpub9z3JY4Q5/jy96l3kDTgqkv291njt/BtAaLcf
         FRaxCcVH+Ao/B6elOb7Y5kD+WWEfu8xo6t3AhFwfCylgeAzZ8XgUj49pMhJAh4Ocl8ve
         c4z9+v8RbtE3OtNwsZxeFJkB+byIliYYRlGC12+WLo4WUVCgb4ru49VE+fJ9f5t/1PsJ
         SQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825273; x=1794430073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zFbC/7v49JIwDAMUqTjgaY3Ekh9T54PUOgPwA6tYbI=;
        b=KBC0A2nkfLYwcQfiat2dKjX6G7bJNCCM8FIEkkzwWbOyOW0GRs4WE/84UsAFdLff6r
         RwKZbJH7PY2zm+jYmJrxt/if5q/h5rpdoTJWdM4hmQ3TjnbiQP2vSq+7wrsbvOb+C3RB
         CJgqA0qgQPEzIYbhnjz1aTMMuaHpUWln7yi/WZFsS0wsjlcyQVL27g69ifYTT3uXdhOT
         czYjT/oIPQLJ2hyRdrsM1n6lYcd0cs7M3F/uUkJevh3k0nr1k2PcsPHEtx6TPw7I1ogE
         ckvmpp9qJh9KsGCQb8if+UvbYDOCOHmko3Plj2XmXuZMSUbg4uyZHPvqcV06gk5yip99
         Bc3g==
X-Forwarded-Encrypted: i=1; AKwUvBxVQ9H2uhIilx0TRk8HN8Wg323JmYYmyurSN4fv7iUjR4L5YVfj3GZx1IBuBsZCjXRT3CxjpSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lDx7XJTV1k4KrpCAYP+EHYqC7ogtC78mnC6MJMQP1nQVJgEpq
	Uft88jS+EXqD2y7c9SmT03murr8OCdEpfgFFSDW3Efh17N49kng1vslL3tbf9T4vsM4=
X-Gm-Gg: AYBFou1awdJoB1lWpxwiBPn1vQGEn4Qkt9LSUnhcRn+/LoLDLvxMWl3dYvHJUg7B8hp
	QjbE+1xq7wbCcMeaSCVAxU20owopfF2vMrEPqD2bhqFilrd/xQ5RBqNlKArXptJrVxHnnK9tfcZ
	NDKitPNRhepEdDW9JadyT4bYqgMCtIOGa95sHmLvNLmm9nIgeqr7x6/NMGA/DvPwuq7SCD8HnKt
	WPV9sDO1PxWfVj/BRRls33Jd/Z9nEe2eyCQDE3RWg/z2OfD3kzcFpjXFnX65L595EZgKaXnKjSJ
	1H5ok0gHeP/cocrN0p9zjdv+Cgbp8apW5Ee6ux0QBbdQKiqT+blKlFFjQQamdiHFM7OfdnPs+nB
	TBQ8rKPPxCb6lpj4NAHf3fqggdfIFGADH8jr5R513Olw59S3k1TV5lBPDMFtu2TGd64wZD9Xn+5
	C/NJ9w+UukMfTqzLO52Na/DG5vCgHe46oYUYYCROWwCTVDX/oZxI8varRRFH6iXT7mjmLsAsrCP
	Xs3siPx306NL8gTKZZ8/2K+dLvLxfx2Rie9VIeEV8qHfBAuyZGgH7YKKzF52bAFxbIlaXlpj3ZB
	B74qrWLBKjqaQejr21HtZXclDJ5xouOb6ergBu70tQxsRw==
X-Received: by 2002:a05:620a:6485:b0:93e:94f2:ada5 with SMTP id af79cd13be357-94421659b6cmr2765029485a.25.1793825272920;
        Wed, 04 Nov 2026 12:47:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479a7easm292770685a.12.2026.11.04.12.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:14 +0000
Subject: [PATCH net-next v4 02/15] net: skbuff: add skb_checksum_full()
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-2-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=7462;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=d2CsFLSStwR7TGVFC+ZiW187zIVn3/uYt4yIWAhReOw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBXORyJhU0rJllDflHqUJ2j1KtvdAJ3xu+S8gR8KsNKR8EZZffwb0bw4sZdXclvEZDEkJjiW8pD
 dMjfKjVkjGAQ=
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
index f52b0717e4da..d51fdcb3e016 100644
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

