Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672939;
	b=bXCXG81zT72LPfS37OuiYFr5lcOuuSCC004/Baez4EYcyqpIy1L/slsZ2Yj88kdVAVi7
	 3MJj1RGBgueR1k8QKGQJ5/tc1yZzLfcb5CXqFfYEKHVHPXsC4kraQR063JGfWrh79xfxu
	 hWpELtPik82t2Knodbfog+8bNEHIw1V/V5UgsPRNSE+uhdnPye9qtOSo0XGczr4IoIOoZ
	 W/gNVPLetkc64zhPSAFEroJSO9JtQufRyjkKn0adw1Ff7urBBYhGahcIb3fw5aWaSSVhp
	 x3RNDILeGpr8/yGa14EUk4dj7TffDVRGGwO0dYjQlcQLvMyP54t76W2JnHImOGroNfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lzfHr7VS3R55wgwqyUPsK6dja/9+8+R/PoE9WBcM+FY=;
	b=wOGvYYXjf9pyO3wTnuIDwONVZFy7JVvW1+Vu3kebvghE8qwLva7YzFMjYGAmiwsh8tcI
	 9es0bJRkpGFzeou4WQUYQYwBL14et1wTOncYJVN5qDHM6TmdgbDh7gnJhcBHu5s78VZvc
	 NFQPaI27JShVXCTHLb7AcubhYpAsHsyhsCLXmY0Ave1zsboI2kUlmC5oD/UQr1Z03kOa+
	 wXfCieykDUBLt6eSC6gnLzTtEOeOQV5q+CaZvEqApvxq7gXyAILW/GeIiw8RgcXgrzmRD
	 6fXYcKLTogxn3CEGqHhYSY31mx4EEF2npSHqeIs1sg0YUwx4sEt+zrtf5HMDK/gXZsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=E1GFwHlf;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F4606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47F4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=E1GFwHlf
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f269e335eso481333985a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672937; x=1794277737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzfHr7VS3R55wgwqyUPsK6dja/9+8+R/PoE9WBcM+FY=;
        b=E1GFwHlfx9ea9RVj6VnsVgLfVqz8siSLeSnAtQu21kFTEE799ev6SXWgEqtAooiStV
         io5TwPtu89xZgQgBCrh6wvGf8P/mO8+5alCuQOOSjaXZMsGOhVhv4NP9qjJptv6GJxLt
         b+t6232hkDwYpSBC5UeGaChF28d4vb3d7n64b5f2QNrex67dPOCgsd155pn+KbvQo2Lt
         9E5bUJoyKB40gEWv9HEIJndd6rX0Dv16sK1G+2BIP31M53TnLPBVn01lNld37saGkjsO
         mZ9MQcOiZDBhaLGLOqMPZhJApG8cSDeBJi/VDA+0zz0JQx2y+PClB5u7tjEr3/Nf2Fqp
         2eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672937; x=1794277737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzfHr7VS3R55wgwqyUPsK6dja/9+8+R/PoE9WBcM+FY=;
        b=W1ioGcD8mkUL8r4HdyFGt+vFTAmH0kfRJyR0qWP9YP9CU57p+0d/dVCjQoUn0ruajR
         T3jTnPefh0thrpw8dg7JBOuwyEEZQHeMIB32QRE7NS+OIYZDXVUZJvWYT/dlNUIUm6UH
         MEPiUfLp7ODuqeH6DNV5kKNR/uYEBpYbj2mbhqh3FYO6W8jre7aNfKnXdFTvu0yek1ij
         6p7MdAxyRhcI1CEgd4UJPyAfoEFJ/RkwL46K3Evje9HmbPdpjR+jCWCjP4VuwNA/gg4r
         UncWu2WJ6n4xUzH4cPcG/4lDIWQUrOJIMB9TS1wYd/s2Ip+oU7AXKtCt8PyBrJvo+9iT
         2t+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYldpmbnNGnvaRppcNrmNQ2EHPdBvl8+gE70uhtnKpE0oJmxJ+bfwbDfFu7gTK6yxaCQYnNd0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMSkjll5eiwmtw2i76w2hVK9J5vTw54SHI/QDmixynr99pqmN3
	+wjbPq12nnBlANAtTe1xXnSQJfNEhvCis0FN5Wou/YX747Z3ufxY0cBhn2pedbrpciQ=
X-Gm-Gg: AYBFou0oU4KcQFxSIjraJiCLRPPJxyuNkEfq2Syyowvwv/icIiud3x4sBDtZdWVaKPc
	SPhwzS7cWZ3BbKsNn9i+sblOAjW6iz0j2ManGgLRF01Bvg7tvIRC4lS1NEtptAcfvTDoBa9KlHz
	mI5OmzZ935v2k7aWyvpSEZkvFBWxrzy/FwRg+2k/FlIMnxE8oeqbG50P3HmLXlNVA1diQzhChEB
	v/segla/tFdLUqLjBiSpe3oPjY4gyaX1usOrmoeeYMfWZAxusHnNhPlkAdU7LzrK6vst3cnT4lD
	KcwwnXa717jR1lpzVcIU8Bh7PnV6+y8SXIRwybdkMcqNaL5qlEcI7B7nZoXUlV8OFruBDy9tFsp
	A1itBz/RS+0vWnoR86BGVH3XmlSwyC/MGOD+O8LkLORCOsLaiLhAf3uQ/oQvpuRLY/ZP9j1NSKV
	1VqVX6AlUqFXnpE6qzOZ5+o9ZYOWtbwdEka8my4ioJGBRJ1g+pYyHgmNoLw1Tc8OcrIaZeUYGhJ
	2lXl2Ps4g0rbF9vcSLGfEhVvkt1OEQfYiRH3EJOCuGPQSn1PBHY6Wk+Hb5Lf0SB2AybzdcQuj3F
	vmLuJb1KEv1la0X6N0NABxRDMZbDrYr3EFM+zrYwt58xqQo=
X-Received: by 2002:a05:620a:4515:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-944216f1f16mr2068343185a.61.1793672937350;
        Mon, 02 Nov 2026 18:28:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945c1757d8fsm183190485a.2.2026.11.02.18.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:32 +0000
Subject: [PATCH net-next v3 06/15] net: skbuff: add skb_crc32c_full() that
 reports failure
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-6-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=5927;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=xQ13tNp8b5b8bmXMu0MecWu7GssBiAZfq3djIXb3o+I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMNAudkydV4sX8J5UoevpFC9R5qZwEOJDugWoZB2YvCOLWe1pQlj56Bu8v3uVapFQnfAVmE8Bqf
 3/smPffQ63AQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_crc32c() has the same problem as skb_checksum().  When the range
runs into unreadable frags or past the end of the skb, skb_crc32c()
returns 0, which is also a valid CRC.  sctp_compute_cksum() and
skb_crc32c_csum_help() complement it, so a failed walk looks like a
checksum of 0xffffffff whatever the packet contains.

Add skb_crc32c_full(), which works like skb_checksum_full().
skb_crc32c() becomes a wrapper for the callers that aren't converted
yet.  The wrapper still returns 0 on failure, but it no longer warns
when only a frag_list member has unreadable frags.

Convert skb_crc32c_csum_help(), which can already return an error, so
that an SCTP packet that can't be checksummed is dropped on transmit.
The other callers will follow with the skb_checksum() callers.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |   2 +
 net/core/dev.c         |   7 +++-
 net/core/skbuff.c      | 100 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 83 insertions(+), 26 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5a5354a6b6ba..5581ed3cbf47 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4332,6 +4332,8 @@ static inline int memcpy_to_msg(struct msghdr *msg, void *data, int len)
 
 __wsum skb_checksum(const struct sk_buff *skb, int offset, int len,
 		    __wsum csum);
+int __must_check skb_crc32c_full(const struct sk_buff *skb, int offset,
+				 int len, u32 *crcp);
 u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc);
 
 static inline void * __must_check
diff --git a/net/core/dev.c b/net/core/dev.c
index 00a62c391056..f9878db781df 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3752,8 +3752,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 	if (ret)
 		goto out;
 
-	crc = ~skb_crc32c(skb, start, skb->len - start, ~0);
-	*(__le32 *)(skb->data + offset) = cpu_to_le32(crc);
+	crc = ~0;
+	ret = skb_crc32c_full(skb, start, skb->len - start, &crc);
+	if (ret)
+		goto out;
+	*(__le32 *)(skb->data + offset) = cpu_to_le32(~crc);
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 68801a4f471b..15d1f4142f29 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3825,23 +3825,79 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
 #ifdef CONFIG_NET_CRC32C
-u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+/* The frag_list part of skb_crc32c_full().  It's out of line so that taking
+ * the address of crc doesn't cost every caller a stack protector.
+ */
+static noinline int skb_crc32c_frag_list(const struct sk_buff *skb, int start,
+					 int offset, int len, u32 crc,
+					 u32 *crcp)
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
+			copy = min(copy, len);
+			err = skb_crc32c_full(frag_iter, offset - start, copy,
+					      &crc);
+			if (err)
+				return err;
+			len -= copy;
+			if (len == 0)
+				goto out;
+			offset += copy;
+		}
+		start = end;
+	}
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EFAULT;
+	}
+out:
+	*crcp = crc;
+	return 0;
+}
+
+/**
+ *	skb_crc32c_full - CRC32C a range of an skb
+ *	@skb: buffer to read
+ *	@offset: offset in @skb to start at
+ *	@len: number of bytes to include
+ *	@crcp: the CRC to continue from; on success, updated with the range
+ *
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	runs out before @len does, or if the range goes past the linear area
+ *	of an skb, @skb or one on its frag_list, that has unreadable frags.
+ *	On failure *@crcp is not changed.
+ */
+int skb_crc32c_full(const struct sk_buff *skb, int offset, int len, u32 *crcp)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
-	struct sk_buff *frag_iter;
+	u32 crc = *crcp;
+
+	if (unlikely(len < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	if (copy > 0) {
 		copy = min(copy, len);
 		crc = crc32c(crc, skb->data + offset, copy);
 		len -= copy;
 		if (len == 0)
-			return crc;
+			goto out;
 		offset += copy;
 	}
 
-	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
-		return 0;
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
@@ -3866,34 +3922,30 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 			}
 			len -= copy;
 			if (len == 0)
-				return crc;
+				goto out;
 			offset += copy;
 		}
 		start = end;
 	}
 
-	skb_walk_frags(skb, frag_iter) {
-		int end;
+	return skb_crc32c_frag_list(skb, start, offset, len, crc, crcp);
+out:
+	*crcp = crc;
+	return 0;
+}
+EXPORT_SYMBOL(skb_crc32c_full);
 
-		WARN_ON(start > offset + len);
+/* skb_crc32c() has no way to report failure, so it returns 0, which is a
+ * valid CRC.  Use skb_crc32c_full() in new code.
+ */
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+{
+	int err = skb_crc32c_full(skb, offset, len, &crc);
 
-		end = start + frag_iter->len;
-		copy = end - offset;
-		if (copy > 0) {
-			copy = min(copy, len);
-			crc = skb_crc32c(frag_iter, offset - start, copy, crc);
-			len -= copy;
-			if (len == 0)
-				return crc;
-			offset += copy;
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
 	return crc;
 }
 EXPORT_SYMBOL(skb_crc32c);

-- 
2.55.0

