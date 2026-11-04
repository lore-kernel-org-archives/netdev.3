Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825278;
	b=22NbYjHrcoqgXYa0Naceo7nXVgkTzdyZTvtmVtyopofE1P9wu+XtaRL/gzrD/AtRxM5x
	 5ZGECxl4HIDW/MMtg7YbtKQmT6pnkeJ5ep5//0IoYt+CdUqiAxW5SlIg8p3eqo6v9wyU5
	 nB7RXZxdx24HC+p818rxjbSV0b58qCMBNvQEHyLUgAhQml7N/fm2jJ9DHMhQSQPPbRXy+
	 G4rCY/odvaVsqSmAlYuqoZH6PTFmspm3aombguLxDyboixA7Ao75P9nGIG5WEHBvcRhbX
	 yhImHQAOcV6Ao0GjN3S9WzFfBfQ9hGeJ6+IivFkxtRYOjzOAlnSFujjwgd2lIx/8fQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2iqbyIbqll56rZUjTWyhCsGjkAY8FnoBuOzACgDTjoA=;
	b=h3PywEFNrsHKTnz89RcyxaAIdORLvfKO6hc+pA9tZDaTzF2B5cvWDGhdXhSHFrc7PpMo
	 s6dkG5rNd9SOoxt/YKcXGdq4TTb12OUtbfbTQdUR9jDba+cYdhO4JECtZXX1bFtL2uzXk
	 AlshxTy/lEjTI6/RAiAAn5H8OBGTDLeMZdCsUnL8/jCH3Upm+qVdIlGhN6OD+x9UwmfD9
	 KFu3Z2OI9lcZ9OrRroSEG59jwd0bunox6l99LeTlbfL+zwyaO/fEK/AlZrXyJhOBJnj28
	 lYyM9+uZKpY6FBLHT82zeJ1OYT4HDppFYMRIX3jg26XMyxlkI39uZgsRhYF6wlbFzyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ibsFOcez;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB2609730C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CBB2609730C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ibsFOcez
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9441591aa5cso265279385a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825277; x=1794430077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2iqbyIbqll56rZUjTWyhCsGjkAY8FnoBuOzACgDTjoA=;
        b=ibsFOceznUJfjIwGcuBQZiE8cFnhCeUEYwKIDDZAeX86hPufDr2yD1Gl8igQgOz3rz
         NKWkCma29DXZJgvKzAFE/1C5fyEo0j9V3rpoRYZiMacQg9tAfXTXBfez2CLDmr6vWjgZ
         2knrZ97F57hez4B79/R9sSiOpQDAFqjfD26j4DtUBiTjSnb06tGAec43WD66GQWaA8fw
         k4dTmtnBHs+tDa5dZaZCqTGLYlFbameMovpqUXb9yFdBdIIyU0jVIg46lEW66BjGDCGK
         1nzJz3au7nNvjIYyTn9O8wmlemcIxYtDfvEU4JRjN+5nMVlEYMn65f7DjMfRUgGIrfC6
         bAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825277; x=1794430077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iqbyIbqll56rZUjTWyhCsGjkAY8FnoBuOzACgDTjoA=;
        b=fHN5evDGPsEn+4fHgkOEUUt+eJ2osW9oY8LN9AWQIeXB6c2HatYfTzvwvyfcLVxCI/
         EEPB/bX9b1yWYODV4qUS/+yOJjsEumpGqojyW6mByjlQNz7xijiVp7BIkAJF49CgWHgi
         0o7Xcjy/maYLLpgO/K85AWiC6ytfghTUcY0JiAYVSbTYOSQdsCyum56qj4kuuh9ema0D
         4FYYEE50XenhP/tu+QkMsxW5PJGrgArkZ8NRCQeFhjiKgVC6taX7AptEH+luNOe6TjBW
         xLEb3Pf8cumtw1UpruiBhuNVhAVA+ZrhMQGMEUzgbLRmBXPP7g+3YbEyqh1gVKW0YWP5
         Aydw==
X-Forwarded-Encrypted: i=1; AKwUvByh2lQjLHflxzIobt3SppGwZgfxLcwkksenRfX69jS6z8rtga+zihmTPYNyRj9ocrnD1hZ0Luc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T6zgyp1wGBN9UURkezolPTjum5f33QtP3rZV+QUXcpzG1Qgex
	fVT7zQtYs22DeVgc9/DZHl47B0sWArd/s9n3VKYiAVjBeVNVu2tKmgUpBkyKWRNKbrU=
X-Gm-Gg: AYBFou0zSAUhjGakWt9yxyzi0ifyCec7GKWNix9/uuNy2uN86lWBrlE3xWSvd2jTj/L
	1lUv8/RtE59ef31AJTQ3V30u/5+Nq1d2KJHgdaey2NhLIlnHeJya3VRmP4NejcKlsoKy4+jLibU
	R1ZjqL1If5afpdBRzn6bVcj0YkpVUjkuUQEb6TL5wm5mf6/lRg9X78GD2PMTwcALDfSlXXRpA7Q
	vXOhZjeGKusPCEym6tcoO52/3VOPHL2fu9Iu1fW6Z3cLBHZK8+kbURNvUKS4TW22hpF+LnOisbU
	suMPd0fZl6d6nclFNUOcMP4Q5fCkuI/TIuXfA1WJ1YUL4k/Vv7AY0XdENM0z0UOMDPrjyokp7bP
	CNIZ3W/1bo9BW0mUicf7BSzhE7ZILB1RyZ4ldMf+pRdHIwaYPW/tYPMqA9mtg7Ztq50KTOXLdfP
	Qwuy9yFcOkCad6pkBVibQpH2c5T5XIDxI4H3d5N4wL1CVXOQPRqpz5Lr2wkRmsZ9+qv8hApaBRN
	nWDdBFsHXSOP9Gpp/CokLbIcVg8aA5WZhMWh5ezMxeL0Wh5DpZaHO/SMSFQHQH6UcYarjbXR4g3
	C+URWlghhcbgKwgNHkgV4qJ2qZyYz9zy3AWw8PLba4JPug==
X-Received: by 2002:a05:620a:2788:b0:93f:3834:31f9 with SMTP id af79cd13be357-945e16aa3e7mr108928085a.12.1793825277204;
        Wed, 04 Nov 2026 12:47:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4899dc6sm291976285a.43.2026.11.04.12.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:18 +0000
Subject: [PATCH net-next v4 06/15] net: skbuff: add skb_crc32c_full() that
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-6-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=5927;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DmjhWQ5DbJzFnm4Wwg1TpS3SDY+QYZAOw6lUp58u+o4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBjRiNxwpgAKwONkFhB+BneqX78IwJRr+LyApr85bnefV3HRAkCkhFAn5Dl/gju2+QcLKWjlQoe
 FEZd97LNDlQ4=
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
index 66ba9bfa8fc7..96c8835a262b 100644
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

