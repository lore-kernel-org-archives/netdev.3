Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590432;
	b=lARt0dBSSD4kmyd71nwmaNdfVALPfcNaqcQDQxb1YpFc+JcKmkBCMo6pLXNhI21bMlh+
	 KivYnkF6V+DVHmlZ5wv24Gi/kK1yXs1t/wIiBmEXIgeCISSmZmyU86zMmAQ+6omrp2yyK
	 EhBzgHgmLC0ozvJZb7lKoSeByH/wzk1pywUzm5JhLysj4DHP64NR6HUhqbXnDZoUS7m5C
	 h2S8Bkz1yCXCicy6rL597II1mKbX1aoHJPLaKG+aO7fLOFOckGI970JmEb6XaBZLK6RdR
	 vvac/U8OWXg9CwDQAaamFRhIvcx12doPCjEzwWA1DBgYtUO+2jHSZACstWY9YQobu4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=j9xcHh2wY++h6+R9ioq32anwJ7T1kqXqVTQttxnVock=;
	b=t/ONrnlmt70zPqWlqVWm4A3Zpit0le1QzruUyiW3vur2TnrSm0uA1Fv8mu0Gm6S/YsJH
	 36mUPWdVL02puvHZ6Z/bb+afvXYA0PFOnW3TnywomqJyi6jrVt4+A2q6pO5XnJ7CCITpj
	 YtVVyPjpf6ubgVYUtrtftHs9q7z94ZA/+SDOS49BFpEdLnYsyrZPh4ilH9gji8dLS13tb
	 zgcgdyhuimk0oFu0JOwwMfNGsdRaSN8WxuQekLEMqO3X1Jkd96BHv6iCQGkvJzpTw3U1J
	 4/bJgds2aD3zJkjLitkx3mk2/M5ryGwMKZOpIY85I4BfLx0RtN0/m/ktFFT4sjqccpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=sjxMuq5v;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FA606A321
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55FA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=sjxMuq5v
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f560af6aeso81916285a.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590431; x=1793195231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9xcHh2wY++h6+R9ioq32anwJ7T1kqXqVTQttxnVock=;
        b=sjxMuq5vSH626Xn9Q7GtjRtjWruuy1PwIkZ7tH1T5M1v+qnb9+xerWW3x8notTt1cI
         oo4HgW2sB/8GgYUOPkcSQif49eNmvsrgsbXb2vXlV0HdKidwMQe3FSIiuQoBj/0xumnO
         t+FedUyNXeuZcRV0h2WMD2IK64ozEH55/tCiF97HWY1UrcY7KEG9Pb8t069g/pDksAGW
         hpq/9rxEpRdvz7eEXEETgC8UIB8Lv8QdkH4U09JrLrEl6ZqXPTYsr6iBo7xLMRWieE5g
         dAXNevSVTEMR3P9N4zCIg/9kXe09T3WOXLQ/tuR6alAWSsoTgsmAZoosUbe292JLzMrw
         JPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590431; x=1793195231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9xcHh2wY++h6+R9ioq32anwJ7T1kqXqVTQttxnVock=;
        b=z4f8sn1bzsrrzQ7jjKHmA0S8UbRGIDvfJfr2DTlzy1jGw40TUTUDNldX8VeU6uwiKd
         XpB16fHt0uwdU1Q4sWzKZUy067w8bxkivKaot8EM3RfUTOUqt4tl0bmvUTsBrcUH6IXt
         moDXjArfApMdkSL51mkAPJ9iZpN3xgMEKz6lC8Ogh4AEICH3/NW+spJoygq7+wQGXdN4
         pvbWrjxBaZEqqZ+p3s+0GIiCWy7Bek+CXJRkZaf/zfl5rfCyhm2S4+kbfm1asIp0qy0D
         FkNCqppPh63VQCoyaLdpLrSwmubohTPxY7QPjOMoxBilRuo+Jinys8WkULuZkPz6IsRY
         g7KQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMg/Ma/CFmBOEXpyssKGI8rNwsVCZ07eTunyc+hc4o5qTQ2+RTYsk3LWwaL3VoXLpPnYfuaeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWoTQPxzrHBDSRMMlTH33DlRF3klHKQ1/HgBio28VawmJX4N/j
	K7+tDcuHRHVqn0DS7zi/O4GX4pWFW0xh7TtyAhpZtM9rYFzny4meqjjwR08o3VETLH4=
X-Gm-Gg: AYBFou1R85Nt7CWKrtlvfKi5lKzXNX41biDBhoiiX1caTxmpLshFTmwIK0hqLEBjF6C
	jXv7xnMakhXFk7js41hqQRkwg/80BKOPGg6toMTCebHrx/GgA/1YZWv7S4awMNdPx/vNOzU77qD
	33ZBwiVGSae5zMitGlQrMBKFXofmldbSF3MHIs0aiSs4jiTZOhv9yOFSS0L64P4CppvGBw+BIa2
	Lgxgi7Ne8RQubR//0awFcA6p+uSISqdd7Ap/x1k5hZFr7L3IXHItCleQa7ggGIIt47UQwkDjIuc
	p1j7aAGRgbm1HGKZHizYo7ssBn4Q5+ASDJgvwP5bCBm/De6B8C3ElS9jfdUY9Sigb6kF7GxkrgT
	ovSEXs9Q7ac2Vkqpxmx4Gz2FwoGQ8rF5/suqFFY/qIYrVef08Rmuw5L7lxVwkhl9vlNnHpqIKrk
	OC3q6XkL8GalfnGzKHSJs0ZHobCHfNXxMHeyrjFVkLCPVf1JKdOrWbDjqowf3iHk+hQalqIzFnu
	EQXA0wgmLafI6G4tUCbltbJUXZj4CuguAkr9eKDV/CI5YreObQj6fsQW5aLxnq05leFN2PqOw==
X-Received: by 2002:a05:620a:468c:b0:93e:ce12:aadd with SMTP id af79cd13be357-93f57f47979mr408941985a.58.1792590430520;
        Wed, 21 Oct 2026 06:47:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c42b17sm25128096d6.40.2026.10.21.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:46 +0000
Subject: [PATCH net-next v2 02/15] net: skbuff: add skb_checksum_full()
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-2-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590422; l=5325;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ZlvWwY4Y8lGqu2UhxWxy8P8g8HVcQXW7x438vujwS94=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB9IaUyRRnrhDlcjRASKEoLr8PFoRFRxjWkPSpu94bv/cMt6C3uKGuj4pHXocRUTVQp2sAYCM4v
 P9XCyt8XsuQ0=
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

