Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916D4F93C3
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417861; cv=none; b=T9lwIjxJ8zPb2XWqc9MPimwQU5q83ZG29YrtUf2r68ZBmIuLjwabOCniwiAkUf7phkjG6IV9iDk5tHdDe3XZLUGgyT8dUc/9fN1sQibuFtWzh6oYIzSYYmGcXXKrZEvpWoIzgnrTo/aY/S4S0/qUGlz7tqQ3vGXyok2Zd5yIwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417861; c=relaxed/simple;
	bh=ZlvWwY4Y8lGqu2UhxWxy8P8g8HVcQXW7x438vujwS94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDnHnq6UbMjs4CzCzx5OZoSPObG4MT3U5JYaTtVd0K6DnI9M4MN9cvaOUxqfchRi5nqOToAAamFU+03Llk/lAfrhITT83jeiB2XWJI8BFf3ZfML/fvg+xFJxZddG4DlL/pYNomqICxY2mIz+z1c9F7IW/r8/0t0YGq/4rOen5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=gR21DHOU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="gR21DHOU"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53667180af3so12442381cf.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417858; x=1793022658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9xcHh2wY++h6+R9ioq32anwJ7T1kqXqVTQttxnVock=;
        b=gR21DHOU15zLyouCBOmvw62H003OAnr0P3sVCi3k5ttQz2ntNC0Ii54V5nXMW+K4AX
         lzBYyfslzSkGkQ9Ooec5jRJAvkuiivq8aFctPc0BB+/KlSxjgRhb42r5Do/FX11nGiye
         3fIUNGa26IBgZw0KyCH0mZc7qXjLEpT3JCI6TPiIMTw0hoPcXNEySqmchZ20accVrF8P
         ZLsh2x5UG2tc++jKPXXmjNy7HE2n65DeA4goyGItCPQhFeLCeLGHKM+L8M6xuRvKlOnW
         UB+Ly7JnxpRkzOp1NAKtXy64cOaHZAjIb3/uXIGKiNQALu9EwCmE+bGf//hN05wI1neP
         lu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417858; x=1793022658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9xcHh2wY++h6+R9ioq32anwJ7T1kqXqVTQttxnVock=;
        b=1cDERllUnGFeAKUG3n/ozSMNaii7QHql+sSuFrymakvLAyXQsqYnJ8/a+l1rToc7kI
         CGlxHcflCQc6OZo0TXtainQo5vUFPV8aklKpL9jiibygkHm+Na0HMn6zGx3YCwbjlQ4S
         aF+ty79dlvXXEWMiN+BSHHL3EvTcYv1gB4tFKLukoT1K0vDkadVDayfO7Nyrpe3VjFua
         PGtqjDjX7+H+41NrLWLf0iBAyNdEjlv4s+spJReXK0cZHZ0AzMiDkFgDh+2jSCdiBSt9
         meFM3zSDVqMAQm72KnJAfp7j5b152p4TosSbEIJ365m07DDAx0SwIdHndVNk0XjJjAeA
         7qkg==
X-Forwarded-Encrypted: i=1; AKwUvBxwH5h9XyCdrWSHvOnLyPI/rFRl/d3wRfZOoNVwRU4opvC1wWIM3yCRWATy+l/UP5ydilgl/rw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdfEcTZD5muaHal/FBiP7i2th8I/E9bPbITO6p2BIziY5FE0XJ
	4RYDXiIUDGefvmD5jSQIUR1Aam5v3GLpAdNzVd/v5tYlY7VDHfFCtxC7chEgkpzaqdakgvMJ5+s
	Q/yxo
X-Gm-Gg: AYBFou05tK5b6lgaOABTgupncZVGxn7gmQxWq5z1FgOda8v/9UBM78Yi7z4NlKKzyo8
	iHNJAujOhA+3OFcvinHfGEq9VDDOjdDZQC24cVIGpQzTz6EhqWyG0ebwXC8AhxR+SuY0/18Jmay
	J3UWNFR/Ekt6Huw4dy2TtoVcucHrGXSK2L5sJ6cbwHSuumNm+i/W62bJsra/SsNxBo1xoAzLfcD
	nfvWIYrJL4zPHcUSKK9o8mUrbxiDjXGJLzXTkzZ3ZhhDi3l3t3mxi5D+kO54CWl7jMSvxG814b+
	FxLSb+pmCTRwaLbIJnDvmE8kt2RHk6DbrBCs+Tsz6dEuPUiWL18AMSzW2JmfM0xp6xbQOZi6LSH
	cmWDtEyeIuvb6uGE+5vNtr1K2OqKb6ykrlKUj+JB0cWTdWYjbgFDXrvfe9h5oIxr6FizgoRiZSv
	OhvWs6Azw0+xdEtDcWyjCWh0s+UihGi3g0jUEIwwYbaHDZ8tBMYcc13OyjtxlL4QehFYYEpThUK
	2Oo0EGlW3Cleftw
X-Received: by 2002:a05:620a:4095:b0:93e:6b9e:6167 with SMTP id af79cd13be357-93f29cee007mr1347508785a.16.1792417858142;
        Mon, 19 Oct 2026 06:50:58 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba3d5a1sm97403096d6.8.2026.10.19.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:50:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:36 +0000
Subject: [PATCH net-next 02/15] net: skbuff: add skb_checksum_full() that
 reports failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-2-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=5325;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ZlvWwY4Y8lGqu2UhxWxy8P8g8HVcQXW7x438vujwS94=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNFaoaSkHTQ/kJoHxBw9tZmbGdrEQBXIlSmcmhx2hYL/udLBNhUXEeeONY2pepSid3GD1qdel1E
 VD02yM/ZF5Ao=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_checksum() can't fail.  When the range runs into unreadable frags
or past the end of the skb it returns 0, which is also a valid
checksum, so its callers can't tell the sum from a failure.  For the
receive-side validation helpers that means a packet whose payload was
never checksummed can pass, and commit 20ddd0fd2fcd ("net: skbuff:
don't BUG() on leftover length in skb_checksum() and friends") made the
past-the-end case one of those instead of a BUG().

Add skb_checksum_full(), which adds the range's sum to *@csump and
returns 0, or returns -EFAULT for unreadable frags or a range past the
end of the skb, and -EINVAL for a negative length, leaving *@csump
alone.  It's __must_check so a caller can't ignore the failure, and it
recurses into frag_list members through itself so a failure there
isn't lost either.

skb_checksum() becomes a wrapper around it that behaves as before for
the callers that haven't been converted: it returns 0 on failure and
warns once if that was because of unreadable frags.  The following
patches convert the core users, and the rest will follow per subsystem.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 56 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 09db32f70b53..969b1c3269ec 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4279,6 +4279,8 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
 int __must_check skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 					u8 *to, int len, __wsum *csum);
+int __must_check skb_checksum_full(const struct sk_buff *skb, int offset,
+				   int len, __wsum *csump);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int len,
 		    unsigned int flags);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a2b52a5a61a9..061c61422a38 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3545,12 +3545,31 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 EXPORT_SYMBOL(skb_store_bits);
 
 /* Checksum skb data. */
-__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
+/**
+ *	skb_checksum_full - checksum a range of an skb
+ *	@skb: buffer to checksum
+ *	@offset: offset in @skb to start at
+ *	@len: number of bytes to checksum
+ *	@csump: the sum to add to; on success the range's sum is added to it
+ *
+ *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
+ *	has unreadable frags in the range or runs out before @len does.  On
+ *	failure *@csump is not changed.
+ */
+int skb_checksum_full(const struct sk_buff *skb, int offset, int len,
+		      __wsum *csump)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
+	__wsum csum = *csump;
 	int pos = 0;
+	int err;
+
+	if (unlikely(len < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	/* Checksum header. */
 	if (copy > 0) {
@@ -3558,13 +3577,13 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
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
@@ -3593,7 +3612,7 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 			}
 
 			if (!(len -= copy))
-				return csum;
+				goto out;
 			offset += copy;
 		}
 		start = end;
@@ -3606,14 +3625,17 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
-			__wsum csum2;
+			__wsum csum2 = 0;
+
 			if (copy > len)
 				copy = len;
-			csum2 = skb_checksum(frag_iter, offset - start, copy,
-					     0);
+			err = skb_checksum_full(frag_iter, offset - start, copy,
+						&csum2);
+			if (err)
+				return err;
 			csum = csum_block_add(csum, csum2, pos);
 			if ((len -= copy) == 0)
-				return csum;
+				goto out;
 			offset += copy;
 			pos    += copy;
 		}
@@ -3621,9 +3643,23 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 	}
 	if (unlikely(len)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
-		return 0;
+		return -EFAULT;
 	}
+out:
+	*csump = csum;
+	return 0;
+}
+EXPORT_SYMBOL(skb_checksum_full);
 
+/* skb_checksum() has no way to report failure, so it returns 0, which is a
+ * valid checksum.  Use skb_checksum_full() in new code.
+ */
+__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
+{
+	if (unlikely(skb_checksum_full(skb, offset, len, &csum))) {
+		WARN_ON_ONCE(!skb_frags_readable(skb));
+		return 0;
+	}
 	return csum;
 }
 EXPORT_SYMBOL(skb_checksum);

-- 
2.55.0

