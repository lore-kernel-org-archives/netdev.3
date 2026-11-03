Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672942;
	b=hl6kfwmrNshHmOOhGAlNT/x22aszBoY+Vp9hfp/aZy4XGcGvWLhAy84Vy5/WgZimEOU4
	 Qx6S7M/k1nI+3G+fvhydwaukihdVCNWW+f0cteVdwaR6WSYN7WpKFS/Vua5EczI7I1NhT
	 SOpQjFDBm7EWqGE7BxLMvgMvE+jVBT05VbhIlnY1oZREyZe42OfIlPDT/4r4DWQ5Q4nZi
	 6LgTVq9/LUCcbIzRAqtjMv7Yz740hwN/xsVey+NOY7LasLNG+VW/EgcnboBP/dQKi/hF0
	 hsxdyANb4Z0m00/8A+MaEoYAMWADwgws4q+MqCs9Uqztmt9EjfS/VOcTYzUVf3i0SKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bijbOirZ4Girus6JZtdOIUGExRiLbvnwYnc1tpajYRo=;
	b=Q/N87xdrsIhwOOR6XybYvJbXJ+xEMEsD5oV8s3ep38lj05+msxn6retEbiVX6kqMIK29
	 znTUcztUoIuIQ1xtMO9/pe+18dbT84/WiWoIPQfV2hb9vYf8RAdGZfSQ5bsPm1khX4uAt
	 MYfujVvS931GbFgeHbYuE1dDrIw16kuZEt9kZCnind6FdtN3o4ChSOa3e2Ij30mWTip/3
	 +4SNjhfA/G7Pep3m9U089nyWRP14r1zhtn/SApw/YrhP6xfI7sAQdeFAI0APjAFhIzBkU
	 /NTAPlWhc6Y7IM2y0PwV18uSTgVsz9pdqnk+GuwVYA0Whj5erxZZPsYjrAiibmfi4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TQpBvKqn;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33B606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E33B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TQpBvKqn
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917a64f28d0so3078756d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672941; x=1794277741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bijbOirZ4Girus6JZtdOIUGExRiLbvnwYnc1tpajYRo=;
        b=TQpBvKqnlBhIQEvWtNAeiT90AIGYrow7KUzZDD9jjvC+5+0Fkg2QhZZtIMNaoAELhY
         fEuO8Wd/G7BtByHNq5mxjathtmNBai1QB9kTeak9DHx3OhHdjdAIcbR8TI2We1iPg6Rs
         JhYgUEcS8DA/nnHtGwjSlCa2Y3QzchaxM+j+vmfzFAlLWntXSPilEe3K8C3M9FKP0eSm
         W9r69/WUH1tzckVUpi/igACoFo2T3Mhv5Owu+BkYXHqw/wTkShOpnpk1hSGqTYlDQfRO
         0v0gg4DWbUznmfelgpO5JwlnRl+wjELJWuztqogyk/tKpAr+P0hJltSECXpUx/3KFncs
         o0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672941; x=1794277741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bijbOirZ4Girus6JZtdOIUGExRiLbvnwYnc1tpajYRo=;
        b=c3+GYkJ0X7qTuHNPdFljJ3gkGSZ/ysB1VhR6LXmTByWZn7+HY6HlZ8DoSy2lGUt/1r
         BQbmNjj8wA0Gxw4V03JfeBWAvYPLIXu/6+0TBmGWKj0wawyATxspiLmKQEjfot0bATnB
         wJy/x5CCN3Z0J7b3YxnC3v440nsJPWKsT5rGh6q8s30VGfk5n8dMYntoE/AtwFgK9k+Y
         VELgOf5gNJWEmfjxLFmmyzMB2u5BkGikQvKy0aCbLIi1RqEpVGgcIT/Bcg7G8/Mw29sE
         /bYjKXx3d+bes6WmU/VEHmq5wg3qMVFrVaaYpXuI8L5O7E7nxGt4qmdXQ9d18spJfRJN
         6iiQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9pW29ZI7ZfyoFRC3YOT4a/lVFEmDvdkOIzPQyXZxHLeOHh6TiMOfRVUd47whK039mK6v2Hp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+prXbj7ntxkLXrB+POQXkT8lPraK/IQGODblGvgXmk+opvNk/3
	gceCwuVdVvFXcaE6Z70T0ZGLatq+/csZpsRtamFzAEZHqOfCqMHDOnoze88BrpA7/Qg=
X-Gm-Gg: AYBFou3yC9hmFBLf0jqjili6SoGR9sUTH4hILVT/Xzzo18/kFRPsN0LrOJDZCXR4fMR
	PigifbgR6fNWIX4xzzq95BbG0orIY+II3g8AJ3OqgAZTY5TL2JyPDxlJW3ZJHmT52x05dy7FZOw
	OK9R4klpLxsLf5dH8s2Nqk3i/0y2WvF5Wjbiqj9ZtfaYirgUqSCUhy03czbeBV4qCg8vMAQyhie
	hIJzAEygRN6BPcO/L50AmPGPkdn2BQPxEeuyP+daNrXGR/seXlfx8k8ONZWvMTgaEYb6Gs985wW
	X7LxajIa+o9Hs0sZxYnAkzMAs0ILWj+anwu1FiCBnKh61LPJTb5BY3Dea+UkAbccp/fyUDaVMji
	fvK3uDxRZQJ6x5uenDcKhWBDt3simbmdzpeEUbh1Ka/a5YGra9wFYRsb7eN8EkI+H+d5rs6nQEU
	skeg1xkQbhh2TdomZAwAacaBwIJJCGO3yvU5c78v/UspES7MquIiyEqcG/n8NrPvAWTM9gQAcmH
	wLCzAXmup2apQ4ZNtGy4wIaMGkeQ4lEIuTLoJWJ5a1ixGy4W98vKe7BoRSwNQIh4uKAoOhhB47g
	Pf8XMXAvRZXxlr/SHAsXTJvlW1idW4Na9OKo2mvtPn6CsA==
X-Received: by 2002:ad4:596c:0:b0:91b:b26a:9793 with SMTP id 6a1803df08f44-91c9089912dmr253427966d6.35.1793672941013;
        Mon, 02 Nov 2026 18:29:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91cb4478981sm75612356d6.35.2026.11.02.18.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:34 +0000
Subject: [PATCH net-next v3 08/15] net: skbuff: make skb_try_coalesce()'s
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-8-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=3910;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=1Y0cvQvaM5FSv1SKjKnlMhZ0E3xrC/xLgZhh+okRfpo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBH7ZWBZQqHx6yS5pMlRH07gVqL72akx3JP37eJaittte4ldQJH4Xai9J9l8tM0eu/jylaeSWnS
 SeZVX/4+BAQo=
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
index d79d8463c44e..e400990595f8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6478,7 +6478,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		      bool *fragstolen, int *delta_truesize)
 {
 	struct skb_shared_info *to_shinfo, *from_shinfo;
-	int i, delta, len = from->len;
+	unsigned int len = from->len;
+	int i, delta;
 
 	*fragstolen = false;
 
@@ -6523,9 +6524,6 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return false;
 
 	if (skb_headlen(from) != 0) {
-		struct page *page;
-		unsigned int offset;
-
 		if (to_shinfo->nr_frags +
 		    from_shinfo->nr_frags >= MAX_SKB_FRAGS)
 			return false;
@@ -6534,13 +6532,6 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -6549,7 +6540,19 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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

