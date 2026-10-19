Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56924EA386
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417882; cv=none; b=XeJJEgOw7d693qI0S67dnuQDtw9qjPdQeVOFs4h7zbYCZL8n2mcFCmtN4y0iivU9HepxHwYIzY0bBQNeFxqPLLPZ58DD/h+dzZuK7EsnmLCxEkEYh1Ef8cE73Q50YW0gvqmJyI7gMZmMxy7QEcYeeWFBWFD5NHYU4cffanF6orA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417882; c=relaxed/simple;
	bh=4gDL1d1n3xZ9vhvHuHh+fxzaWH1kti0hEf02jn3aBlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0zucBD9VLc9oh7ywa3B1mRkERP175/mupnzhExH0rkE0S3RfVY/3jGK1VpsNp+6t74B64I2gUXEqnAFSDRT41caJtsUukc/R9V55Hgm7tyEHeZfrfjE7/y/AzfkMPdnyE8tWi781TnUTBuU+kMTcTqk+jGIRV4ksPUwlwBFnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=SHfkxMnY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="SHfkxMnY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f1cf92c9eso224795285a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417878; x=1793022678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydoWrUsryFQCXy0qk0+H+VOsHqxoYPyCdAWJE4iSCqQ=;
        b=SHfkxMnY4JYzDH+rSJxHVUfyz+aJyxRRq7b5AqJpEr9/IvMrUxqjdPc62/nPn7s1LL
         FQGf+WWKvQgXIkmEeOo97Un4XDOcOcljS57aILXN5vjGX0peTTpwtYpfoooJS5qLWNri
         6RF9k/kbgTWXDzqECjvo+n5iG92m7tjGYjLOE3elPTO8bF7BUJuBucBHFGA/ArGLNdVU
         V0GFZjGV2FLO2ASAw3KVR+QIWOIgwrhIfSDNLdANVu1GAJ5gCdOmjkINuCAssJN409I2
         U3Iw/o2rqoTyiqbWpyESmwR15KaikEQR5TOz0OssFP4VLGIK+nTmmau3smyzjpgiswXP
         EtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417878; x=1793022678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydoWrUsryFQCXy0qk0+H+VOsHqxoYPyCdAWJE4iSCqQ=;
        b=keuh9Zz2Ve//A+WC8/axIGJyZqClONGWrL0UdJvNf+E06M8QclWCjQRUfTxXDvhBjj
         MVBIOCnGqT9DVTe2bc179uzKM/CgFaj3agXOBwncZuIWRFkdNZdOpFForGsgEYjU8xUS
         VthPUiIcLZSrpWdq7YOBmogI56xEix1sSI5onGkKA4uPy/+H8XvI9C8YdCflx+RRkZbg
         pl57axfPfwzZ316CapVoS4gTjzpzmrsi2s2AhhjckNsRLTiiYhGkUBDzTbcqlqYgp6T+
         CarIk8uSTP7yugKOUwrLMMhqTjwop3DjKwsZc8p/BuDaC+F9JrAqg3RePMGtj+BM5zLx
         YnIw==
X-Forwarded-Encrypted: i=1; AKwUvBxpdqxvCace3yIYXvZe2T6pEEyz9Jzv70kHNm745YF452TCspeVwO7LZOkDcyjBRygT65Ps1sM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFV6VXqCdeHs9Zxx3u7MvIG8SiIPAG0QDOkGd0m2TwMkb+P9YH
	hA01xGubNFjkF4U77ctDlRGMM1nf60etZxULFuyvhQSQ6GkEOkIVRiXULbQU7o4leA0=
X-Gm-Gg: AYBFou1iTdSy9Dwl4ylHis3iJwx3HsxspocZ5uYh8PdTJItJtFrpUtDN6f+QRwwC2DI
	qen+CdRx2gdyVevHtv239pjC/L8AaSy5xMmO14/ku11y1Pbt4tSuPNCP8QIDQTQTWtOOlkgGdvF
	oFkBPCcyPyw8wW2GRODjvq4+afNkS3Z/0syDIottqpWVNn8v/xR8SkinvjST0S2xKmvewHj3NQQ
	Cu6CGS8fTUaz0N/gnYnzXu96paa4odLC6KLq4/Wn8aiLtB9WgkQWUYpdcxpghw6qZ+nG67mMe59
	77pvIMtD3x6JNMuQeipTwXPIkf/EOueE3dD3kcYjHTvhdMAsFRqnBQ8LRKjlujrF5AOdHy0QaY8
	/fop0S+6qPVIGi0l7eC2xufKS82qiQj33Ne53IIC5pBncrRouy4zCsXc4WzHt9Wu9bTrJ1zmfqq
	6WkfXn5h60s8UN6WQCoJFsQV+jZRzDULEgjUPWdj8sRqpp3MmUURETQSKiBc7Cbcip0/g8H/hBO
	w7rtbyZlttfRpA=
X-Received: by 2002:a05:620a:31a8:b0:93f:2957:39e with SMTP id af79cd13be357-93f29df1566mr1298617785a.71.1792417878389;
        Mon, 19 Oct 2026 06:51:18 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f23eb7ba5sm842774385a.27.2026.10.19.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:40 +0000
Subject: [PATCH net-next 06/15] net: skbuff: add skb_crc32c_full() that
 reports failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-6-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=5122;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4gDL1d1n3xZ9vhvHuHh+fxzaWH1kti0hEf02jn3aBlw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNQsoPXudgIBCQ4amU4Ot8wGr4uN4l6ll3DjM3OCKkakLx6NEe8pB0UhGAzuQHiV90XwzqMDHE4
 OA5x0AeiNWQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_crc32c() has the same problem as skb_checksum(): when the range runs
into unreadable frags or past the end of the skb it returns 0, which is
also a valid CRC.  sctp_compute_cksum() complements it, so a failed
walk looks like a checksum of 0xffffffff whatever the packet contains,
and the packet is accepted whenever its checksum field holds that.

Add skb_crc32c_full(), which updates *@crcp and returns 0, or returns
-EFAULT or -EINVAL and leaves *@crcp alone, like skb_checksum_full().
skb_crc32c() becomes a wrapper that behaves as before for the callers
that haven't been converted.

Convert skb_crc32c_csum_help(), which already returns an error when it
can't fill in the CRC, so a transmitted SCTP packet that can't be
checksummed is dropped instead of going out with a CRC of 0xffffffff.
The SCTP and other callers will follow with the skb_checksum() callers.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/dev.c         |  7 +++++--
 net/core/skbuff.c      | 51 ++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 969b1c3269ec..327a01a5d6d0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4329,6 +4329,8 @@ static inline int memcpy_to_msg(struct msghdr *msg, void *data, int len)
 
 __wsum skb_checksum(const struct sk_buff *skb, int offset, int len,
 		    __wsum csum);
+int __must_check skb_crc32c_full(const struct sk_buff *skb, int offset,
+				 int len, u32 *crcp);
 u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc);
 
 static inline void * __must_check
diff --git a/net/core/dev.c b/net/core/dev.c
index 8eb9bf1ff9eb..1d34fa4544a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3738,8 +3738,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
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
index de433d452939..3b2a3747f009 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3788,23 +3788,41 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
 #ifdef CONFIG_NET_CRC32C
-u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+/**
+ *	skb_crc32c_full - CRC32C a range of an skb
+ *	@skb: buffer to read
+ *	@offset: offset in @skb to start at
+ *	@len: number of bytes to include
+ *	@crcp: the CRC to continue from; on success, updated with the range
+ *
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	has unreadable frags in the range or runs out before @len does.  On
+ *	failure *@crcp is not changed.
+ */
+int skb_crc32c_full(const struct sk_buff *skb, int offset, int len, u32 *crcp)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
+	u32 crc = *crcp;
+	int err;
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
@@ -3829,7 +3847,7 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 			}
 			len -= copy;
 			if (len == 0)
-				return crc;
+				goto out;
 			offset += copy;
 		}
 		start = end;
@@ -3844,19 +3862,36 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 		copy = end - offset;
 		if (copy > 0) {
 			copy = min(copy, len);
-			crc = skb_crc32c(frag_iter, offset - start, copy, crc);
+			err = skb_crc32c_full(frag_iter, offset - start, copy,
+					      &crc);
+			if (err)
+				return err;
 			len -= copy;
 			if (len == 0)
-				return crc;
+				goto out;
 			offset += copy;
 		}
 		start = end;
 	}
 	if (unlikely(len)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
-		return 0;
+		return -EFAULT;
 	}
+out:
+	*crcp = crc;
+	return 0;
+}
+EXPORT_SYMBOL(skb_crc32c_full);
 
+/* skb_crc32c() has no way to report failure, so it returns 0, which is a
+ * valid CRC.  Use skb_crc32c_full() in new code.
+ */
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+{
+	if (unlikely(skb_crc32c_full(skb, offset, len, &crc))) {
+		WARN_ON_ONCE(!skb_frags_readable(skb));
+		return 0;
+	}
 	return crc;
 }
 EXPORT_SYMBOL(skb_crc32c);

-- 
2.55.0

