Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590440;
	b=rOgouOY7NAvcLWHlQvfr9/Bibl3yfUp2hCfuH+czQlW3eKjMtA1fgjgA5h/32SKv9kus
	 QOI3sDS13s16QZCiosT8DM/Oy9JEI/ADpJR6SLaBCd5T3jKmGwuhZ3Pf2TaEkEhVi1c6F
	 kaN8Ritj+5O43uvLFGv8Y2XwUi/RxfVwHcu2w9xmuIumOaQHaqPHvBUhFVKH5/nD8cuPZ
	 9ow6ic9R/9ip9xZ1OezjlaIEUGMofh15Jnp95SQNsM02JoU++X8usEvlUs4tN+xUc69mH
	 mt+omRUS8Oi9ETaU1CTp0Wol5XffVc2THSxzvAD5CWLYfgIETOdnsQQRD14g7WdiccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ydoWrUsryFQCXy0qk0+H+VOsHqxoYPyCdAWJE4iSCqQ=;
	b=jaOfATqY1N25maJ2np/ox34STd3CezuEJdlXCJSpsxvo7cEdX3Ahv8dpZRM6FjCTYryA
	 SI1F3dOyzJg7J9/shaVyIsU78oHf+ErMtlCL10t5xjOuudXHU19HzNKayVWBCiMSlbvil
	 /2hl0CcFt+TMx7coWrCw1j3DGpoa/ts75LhkTrF2fhzvJi+ZSxV/HhI7Pb5QYdDx9a+Bw
	 bwiJgk7OsiKu9YU5PEhpz14xH+u53LbKWraWN29Z+vK6L5xjWXPqK749NGuY5+M7a4oKj
	 ryclm/Fmzl0lcxfRipWyUQlr0caYkWMfUoIWPY8kjueZMMV/t2IO90rzpaovs/90FWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="EW/IiNIF";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8418606A337
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8418606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EW/IiNIF
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b8b456dbeso7749116d6.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590439; x=1793195239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydoWrUsryFQCXy0qk0+H+VOsHqxoYPyCdAWJE4iSCqQ=;
        b=EW/IiNIFaYciaQ0XER5tcjy7uigiWhJ2pNWi+JtbVhTndx3bmdDZltuKUJmu6bmZk0
         KVUIziWjyK3Jw0XplPbL+544PDQDf5x440D8qqpHzhNkWxLQq/jnntWIG7owGHY2dp02
         u5R0zN5sKdo7uyCqbNanDOad4ph2R0NXIBiFwVhwl7auRq7tNxYfn5lr1yCta/dOiRVS
         EH18g5ZnYJge3ZZ5qwTxB8Zt7iO/wFz6fg9oOKiZX9wVpbf/aBkweSOqUa3CG77931zh
         U/Yfs5TnibswNIkfJs+FrHW4yUE6eMUFnBUItuLJLCfIYvYV0u2+K0/nxGCjHLHQ5Fuy
         +dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590439; x=1793195239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydoWrUsryFQCXy0qk0+H+VOsHqxoYPyCdAWJE4iSCqQ=;
        b=l6U/KIiT4mC3lNajxXXmtqREhUizdoEPsMFYQgiM2VmG2FkT+XwAM0w50+hAzaZxmn
         rhd5/Ugp/rfxkc2SFYzzWLd+0m00hBoUsFNp7z4DDiFgqtnSCXQ4/HcGW+iV0MpXmJ0X
         F9tMMDKCW/7MdNwPMe6Eddem0ZQsOIhbnka4u2QlfROYMszBSAyl1QoSQvbHTzO+X01w
         h4/GhdEnvPtia8GiOSKXULYOaZfKVHB8NtfzfBiSyanYTjUEqQuDc0qDHdFs2ZgJV049
         ++ymyoWK6py7n5u4JdsDw5Sap4Da08Lx5+mbqZFHbAut+4vRwyVmy1WoTyxB+GcoJOcJ
         w2qA==
X-Forwarded-Encrypted: i=1; AKwUvByqVLDlX83sYOXv2ZPrlq6gWaRV3pNBJGR+82/J+XT+AYHlvo935fF1gMqcE8p+fPP97Q1UMaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxg/Qg7hsyLxl6SucruvUreOVnkW98thrj7+sDfnKmqFA3nnoP
	FaZ6BXywUWewh4xTdZgszVbREQzJIPHNQQWKrGO5i4ZWrHG8NVf+/4bIFS9L0gMnsfg=
X-Gm-Gg: AYBFou1aKoTpLjZHnU1a4026219MQmIZDazllViYAxhwzne3oemqpZcS6QRhClCfly/
	F5jOYKlU2B6MF8VL24c6sLuaW0DRlFol3CHpizP2YJGOZ7QwkYCiM53yPEd1EFXKGuMgh/p+i4y
	Mqbp83dAgOFGRrt7JAku1nT/PsGSYwu1h6H4N7tYhYxi71ACe6Pg557kPxNT02DSpkSiJYdtv0X
	RzbV1xg52NBNmXHUIp+5VZSYClivHSECl8GgFhsUjiVNCp8UIfx7M6jB0Ryn+7GPNOe6yMAff3t
	Y7glCg8dsJtxYM2y4d8YNTAScyXuYLjtkshtrsHksuCqMSyX5UuQ9IDuqE2ir+KhDSfIPBMkMrq
	qzbABlH1gEJnUs819WoUeiZPzRfzn+quVfSXb+hIZ+2A39e+e7Etpn2Kv2TRKOLLZCKMsmmHcrk
	YCfCTJnYGiqM1V0t71qe/b0U3EdkqWFX2E+ka+sz68hiPZVGOqjir3Ex0hyOSSSkBgtan8Iw/Xa
	g/PbIHkSlZExA4fldSe8hU1D+N+3zWzlOPwEF8DTsVpJ2aGMuQ6KY5I4o9bphcfWb3fZvYO
X-Received: by 2002:a05:6214:3c8e:b0:914:7df6:ca52 with SMTP id 6a1803df08f44-91c12edf334mr35650786d6.9.1792590438463;
        Wed, 21 Oct 2026 06:47:18 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b736adsm24541966d6.7.2026.10.21.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:50 +0000
Subject: [PATCH net-next v2 06/15] net: skbuff: add skb_crc32c_full() that
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-6-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=5122;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4gDL1d1n3xZ9vhvHuHh+fxzaWH1kti0hEf02jn3aBlw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGFH6qByESWgbyznzi7Yaz/CoAWhQfAOqIbi/BhB5oBR1rY2fhlWIxIK8c81xGv75bwiI8TG6yn
 I+0cEu9/8yQc=
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

