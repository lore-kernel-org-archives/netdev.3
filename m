Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825280;
	b=ao3Ui3tcTXiZMMQdmbuzRDoWeTBMZ0p1EqrRryIuoa+NwRHxtI+NmdnWEkq6N+474G1Z
	 +4gpXS+bYAx6UEIZorDIBzCk8GrUwlt1BitqxtrY9B/ZjNbGAdnlAuFHZJpiRVlbCZume
	 TCDdomG7g/BAyd1XZqfw68XZvseaWggF06WLitf1JkS7ws/vxFba1X0Cw5onhBuwRGvAp
	 ThSLoXfj6m/y68DHmt4YZj2xi7xm8Ufxm6vNzvHmmQr7fXYnYD8CTaVi0jvrpjuOPOzxd
	 37fbtKUVJUHOjlGyO903Q0gMemt1G/1DmMLy55pYgrb+5R0E9OTFxlPqxDRKZzCm7GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=I0fgOhN7DOs5sphgS4nlyf+SCbWBYGAvkUGVDVkmjaU=;
	b=kiQA7/XxY8mQpZiHHdyOizi0EIAYN3D4S7KqbGOxBcfUxNyzhhwt5Kalg5+RAprOP3Yz
	 TpXZtjqDeAD590OR1/3nqEBq8RN+obRhh+Jj9jb49u8ubqlFYS+TQOPEEKSCns0VUccrN
	 xB6fR3CrsCWPz6rpwHdpnoCO/JszY8el346hIWO14oOnlmaiTYWeXFRSiXVV3U2E4sXq2
	 WVnLurjRekepFUfGjj8M/Zzld38q3Adv8gwc3gTMWtNwq5V6KwZBLEU6WIVZ/Hal3TMN4
	 6yFhASXGOyS/Xp1SEPJzHfXNDwpY4KbehqqdpizTlHFoHOtMboYjLULILNotY99cgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YDJTrwwM;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6566097320
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E6566097320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YDJTrwwM
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91bb5795792so12669766d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825279; x=1794430079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0fgOhN7DOs5sphgS4nlyf+SCbWBYGAvkUGVDVkmjaU=;
        b=YDJTrwwMNzWZhpqHWAwh0/U7X7bKPFN9bG8joZwVNyH1FdSqG5VMTsM3OrdkmH0u0/
         OJOoveA9Rc8RO7KfhGJKsPLNtGR0lMlI04wtKEwt+lPRGzCBt32voi95Z9Gss/rP0lA4
         17CWSeYeywWfXc+GR5xoNPOGQ5EkSel3SrIduDiQxUCMiZ+VN0csYxQ5eonSOhGgtbDZ
         8QwsDoAssfMjFZlbHP1YFecSmiZtxG72sZanIvCauhd2bIODki7X0iDgkg2NVpRh34cd
         AvRX2whPHKp5m097S7UTPFvVd+5Vi6FGtCY0zc5PwW9B0iPC088258L5zktzhjdi2eUO
         ixJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825279; x=1794430079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0fgOhN7DOs5sphgS4nlyf+SCbWBYGAvkUGVDVkmjaU=;
        b=YNWNhb2+36CFj/8eIy4ZIUONHsNi0fXEPfwYCgoMHxFFFcE9nClGmkCJvcTkXPwUEE
         Mr56xd++eFEw95L8kdvlQeOYQPfNgkTg58/wC8LemV1LZvlMd6b9mBq/RQrFzPA9cCOW
         qP7OmH+VdlXIauMTeWrjYBXXnlzZMcpHegGrTj1dbuexNpSoWUJH2VvvebyjGF+g4bs/
         7g5B76y5EpJCR4t032MxF4f/Or4jXpVZATlkREEDAxrCWwZ2aNjedmLJMlesziGO6Vdt
         i/h6H0nExZFrwFEYdUhZkvs+jBz6M/OYMxiuwXdmv3aYQ9DMBhkJldFvIzl26inHR9Pq
         F35w==
X-Forwarded-Encrypted: i=1; AKwUvBxgsGd0L2RcczjhYe92EJxgxRtZRsbH3ZyLmZkMnRbuUsLR4HTMHWo7q3/nIyo3RUo9rW+5Xc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GElnGpdcYcNyV7MoeDkL5Lc5KZuwdL9Gz3pKwnrJ8/zLxIa26
	XWYveyVsNDJ/CD/i4AqBm60TL+5/Y+YZMASEm6o0jLHVY3easF7ZQwmoOcRlZF++cO0=
X-Gm-Gg: AYBFou0a27Lmszpu7TCj7hKP/a4fHgY4JvzN7wjOyrDmM4gG5yrOHIBoHppj6hLzzJP
	BbuI33E4EVz9DJPn1v4cbjLwGXSaGGAPwTA3oNt0EF2yvh+iBVigS97YQdL8IZ6F6lc6ZqCJmnh
	W8cAG7hwvHznlB2CUy8CXOGCvivTZp4FGeF/rvUSEp8stxeh/RfjadThRmYybhlPwN2FVihlJn2
	uvGNJb0zXZCzKBkOnNnETXILO6weqwT5EpvE9l7GMIhGpg15MDC3Aeuo8MIUfgyCrKANNzVr9Oq
	33zTdSOkOa8tZGfui5uohu7Uc7l6+OY7oJCIm1vsuHz+GtCxkWRQVqGhSiXsleK+s0ksm6KAk1L
	DCHuAS6BwpOuKkBfLbx/ftNBq4GHZhFggGYCqpwsCOW0F7Dsj6P3PRlI0gxJaHVRvz27hmaykKl
	/jTOE3DRfgn7NvbwJwRhEa7+0ZLNV86jgio5rGFjyPYSIDuOjTVLzFxVqL3JS7w1ARUB64B60Gs
	c5/BkI3zSKgJBhA8Xi32snlYIJjR1u48PmYuU0MVoiUpzVvO8bwM9qrR1XK7Se0GrNENKlsqKNH
	gq5shTpzL1XFWIt7cWrPkGeCps1RsbzWk5JzO0WEsZDd2A==
X-Received: by 2002:a05:6214:3017:b0:914:1807:dc70 with SMTP id 6a1803df08f44-91ca4adcf1emr285668046d6.13.1793825279344;
        Wed, 04 Nov 2026 12:47:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e962b4403sm2743706d6.20.2026.11.04.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:20 +0000
Subject: [PATCH net-next v4 08/15] net: skbuff: make skb_try_coalesce()'s
 len unsigned
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-8-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=3910;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=1Fxify4JpxLzLM1Ti2e+64TfuNshdGdOIM7pownAVrU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHxEsFLzJgR3nlUT1UdgoB00cssfz8v87Mti65uiGcMrjonP4uPcKrvqTbz8Wc8/j5y224vXNuI
 0BaUMX9dJ8Aw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_try_coalesce() keeps from->len, which is unsigned, in an int.  A
corrupt from->len above INT_MAX turns negative, gets past the
len <= skb_tailroom(to) check, and reaches skb_copy_bits() as a negative
length.  skb_copy_bits() returns -EFAULT for most such skbs.  If
skb_headlen(from) is still a small positive value, skb_copy_bits()
clamps the head copy to the negative length and memcpy() takes that as
2GB or more.

skb_put() used to run before the copy, and its overflow check caught
most of these lengths, but not the ones that wrap skb->tail back below
skb->end.  commit 279877d86c82 ("net: skbuff: don't BUG() when
skb_copy_bits() fails in copy helpers") moved the copy ahead of
skb_put(), which left only the tailroom check.

Make len unsigned, like from->len, so that such an skb doesn't take the
copy path.  It gets to the truesize sanity check instead, which sees
that from->len is more than from->truesize can hold.  That check only
warns, and only after the head of @from has been added to @to as a frag
of that size.  Make the check refuse the coalesce, and move it ahead of
the head steal so that @to isn't touched.  The check compares the int
delta against len, so it now tests delta < 0 explicitly.

An skb from a driver that under-reports truesize used to warn once and
get coalesced.  It isn't coalesced any more.

A test module that coalesces an skb with a page frag head and a len of
0x80000010 gets false and an untouched @to.

Found by the Sashiko AI review of the BUG_ON() series.

Fixes: 279877d86c82 ("net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers")
Fixes: bad43ca8325f ("net: introduce skb_try_coalesce()")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fd4689cea94b..2c246f563555 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6480,7 +6480,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		      bool *fragstolen, int *delta_truesize)
 {
 	struct skb_shared_info *to_shinfo, *from_shinfo;
-	int i, delta, len = from->len;
+	unsigned int len = from->len;
+	int i, delta;
 
 	*fragstolen = false;
 
@@ -6525,9 +6526,6 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return false;
 
 	if (skb_headlen(from) != 0) {
-		struct page *page;
-		unsigned int offset;
-
 		if (to_shinfo->nr_frags +
 		    from_shinfo->nr_frags >= MAX_SKB_FRAGS)
 			return false;
@@ -6536,13 +6534,6 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 			return false;
 
 		delta = from->truesize - SKB_DATA_ALIGN(sizeof(struct sk_buff));
-
-		page = virt_to_head_page(from->head);
-		offset = from->data - (unsigned char *)page_address(page);
-
-		skb_fill_page_desc(to, to_shinfo->nr_frags,
-				   page, offset, skb_headlen(from));
-		*fragstolen = true;
 	} else {
 		if (to_shinfo->nr_frags +
 		    from_shinfo->nr_frags > MAX_SKB_FRAGS)
@@ -6551,7 +6542,19 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		delta = from->truesize - SKB_TRUESIZE(skb_end_offset(from));
 	}
 
-	WARN_ON_ONCE(delta < len);
+	/* @from claims more data than it has memory for.  Leave @to alone. */
+	if (WARN_ON_ONCE(delta < 0 || delta < len))
+		return false;
+
+	if (skb_headlen(from) != 0) {
+		struct page *page = virt_to_head_page(from->head);
+		unsigned int offset;
+
+		offset = from->data - (unsigned char *)page_address(page);
+		skb_fill_page_desc(to, to_shinfo->nr_frags,
+				   page, offset, skb_headlen(from));
+		*fragstolen = true;
+	}
 
 	memcpy(to_shinfo->frags + to_shinfo->nr_frags,
 	       from_shinfo->frags,

-- 
2.55.0

