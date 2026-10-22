Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633637;
	b=D9AhJ71kwCjo2C7BuZ5rI46GTbzKtX74AbRiYoYFo1n9whhKbNANHQ/+R6c0WufSAcWA
	 2U/d1ngM/qxEzYE1a/Lz0GzxY1+ato7yUR1EtlUk+97A6poCaibN2rReOET+QjHiv4W93
	 mVkWB83FmQWeNtNUqLEHKWyeMvrEWheeJOwlBBT0is+LqniqKQOv6TdhrIqL7d+ACKbTk
	 nE6ZW6+tqXZZTV6li75gp24Y1a8M0ezwocSgPOD+vcKdzY71r83PXSnBiQzfxSW9eueMA
	 J+uzNHUFN3bkV+d/MD3hJDLXu/G4N+zS/mhWZe42+45MQhgQAK3IzNjzqiKSMWw3Wew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jCKRYOUlKmoPJSnDi6pvpqUte660v3ToEOh1Wa/1TdM=;
	b=SK6eb8vq5EVLJ4qfjbEZOjKFQZjQlA/8P9noXev7Cxgd7Il4HelWoPD1BK+SHUlH83Ms
	 m2py4gauynLvC52Cr1BwcGomi3LwJZGj4u+UpO95llwM4M6qRZFJOMp5ROLIiHj06SfaN
	 RN87iFWZFAre4rzckX47JI6Yb+hgyiVzx0Ohpr+/5GhabHyHrhvYqdgMiIsI9CEufk2Q3
	 dxuAts4rrzEPqIk0ZlGocgHpBjUR5jCwL6ooT8MC9trz3Wy2cXpQ4i5+iAfL14VYds9Z0
	 l5tbQjZ08Beq6OoGi0SpFz/kpJDwjkeQonnMFxVepjkzYQtqCrbYlUX4hbU2HRz7VzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8bkoLYx;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554B606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5554B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8bkoLYx
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so845885e0c.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792633636; x=1793238436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jCKRYOUlKmoPJSnDi6pvpqUte660v3ToEOh1Wa/1TdM=;
        b=e8bkoLYx7ax0rHmA5TVR5sVFCMou4ByuTnwIf3iAcEpdWK+SFphmKlwpW7HJBj8mn2
         eH5E+xrhrJjWibsOnefdCOeheNZyN0+D/b8y09ssUcRUmEIw7iBrsgZrT9icLNw1BJMR
         MSdImODSw8S5llUMVkn4uKfDZ9il1/XKx6cwK89XvSDs+/lrSk3jZVKMsHdBhJYBnkmq
         wz2N41cM1YyT2pP3WKb9J4bINV0gLk3WepaRZ34hDCh7hqImMZ+98sa6ExwpRUw7A5W5
         lnU2RJiZPAdgX25/0JNNuKea0G2V3cyP8LjSfWjerY5bYBcz/Hyrk5O9q7QbCP/D7s64
         /xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792633636; x=1793238436;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCKRYOUlKmoPJSnDi6pvpqUte660v3ToEOh1Wa/1TdM=;
        b=GZOvIPh+1ChOi+v0U1OpD4Mkfm61/CkzogJqhQLKp9UVbSRupQrSdkMLgmpxNTR4vE
         kL3bejujw+JaBCdtxp5K/g7w0RvtQFoKGDmyqRnTxzwOuGvPyCkOvctW+CxPYvgbedfR
         U8e3D8vCw1p+O24emukox1qfmd8dJJfwKzMPMwFWB6Opae1QzHEOw4annB5MsECyVhs1
         8UT/7UomAmr9aCmkuekBFZBAT+rM6gWpVhvaKK/kERwYxDJWdDz+499oPoOsmCMfWrKR
         upPfzZ3DFa2Iv5xMDp1jpSCjU+JgE5coXD5PyZkwD7R7O9tRNRLSFl6WQ8bTydxfAnWS
         MV7w==
X-Forwarded-Encrypted: i=1; AKwUvBwvQMlh+hrzFdKb0BGqTOCfuvhgqJ/A0m6LGX0wCfWmX184eChZSscWoJMcdiAgycswonYqhgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+ze5dv9GQeF8+BJZUROl/8h2S4TXMVjyvjYHwIIGTMhI0OhHi
	tdOJO3Yf4de659hlSDq50gfBjMrJArBe5OBG0JhzKEwutgiw9z4osZIo
X-Gm-Gg: AYBFou36r5awL31iZoqhGKbGlDoipZGWimH70mx/Rn4F+iGdbrHgJ3m+FiBN13gshBm
	PPw8mC7xJny3Y2VaN0kfMOw3kui9exipSOm1Fy6EUFkMn9QUKyqa1u7lWhRkxIi3PV3fHmEUKfq
	DdcMmD7W/T8564C5RWZpJMqbrk9Qj5jPyq/z9HdIK45a6ir/+n0e3gxch5otN2ZH16v0IQRyl8K
	DpimCauMz3AErFdoOr4fhpo545G5Je/d1LBbtTsS9OyJceZ/co3u54gxnpVYDk11VTeXF9mHO8M
	3cH7lQ4tK2OKOOQNQvJiLYTnwENRnVj1zIXaUron+LU1aNMvn5nBXSZlkGiGacfkP34xqwAHNpc
	x9OwLReI1IkqiWQx9f/qsDtQTZ9leVQfEqTNd58Z9jDMWXx3VWOcy8PJNzrDFlSlCysBqHe3FvE
	/EQqvhs+Ht9dLJRaYwF6AUug5nZ/oF++2Rzad9dpu0Ma+rwHAlICpnQt118oMBJrz1HG0e4tqPc
	QUKl5Jxeurh/tKlfycPWVpxmT2pXmkvTDDfSVuawDfAQ8T/XO0Ak1rKyX7vEOisViKZzysy50Bu
	t6FnVWUruNICmppLdvwMWfkCF4VtFs4l/MaUCAxtCIyTThG0YqXC0z7OMHYP5UjopQN83GDBgrX
	Ap+35gUwwmpAtONX94W0=
X-Received: by 2002:a05:6122:1d9f:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5eaebef16acmr1695454e0c.22.1792633636272;
        Wed, 21 Oct 2026 18:47:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae980f64esm5275613e0c.13.2026.10.21.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:47:15 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:47:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, 
 Willem de Bruijn <willemb@google.com>, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.11bad1f39601b@gmail.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-11-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-11-2aa780a03524@toxicpanda.com>
Subject: Re: [PATCH net-next v2 11/15] net: skbuff: refuse to segment a nested
 frag_list
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> skb_segment() walks head_skb's frag_list, but for each member it only
> looks at the linear part and frags[], never at the member's own
> frag_list.  head_skb->len still counts those bytes, so with a nested
> frag_list the walk runs out of members while it still owes data, sets
> list_skb to NULL, and dereferences it on a later pass, before any of
> the layout checks get a chance to catch it.  When the member is taken
> whole with skb_clone(), the pskb_trim() that follows also drops its
> nested data.
> 
> Nothing in the tree is known to build such an skb; GRO flushes instead
> of chaining an skb that already has a frag_list.  Check each member as
> the walk takes it, in the GSO_BY_FRAGS, clone and frag paths, and fail
> the segmentation with -EINVAL if there's no member left or it has its
> own frag_list, with a DEBUG_NET_WARN_ON_ONCE() for debug kernels, like
> the other frag_list layout checks.  Without SG the payload is copied
> with helpers that do recurse into nested frag_lists, so that path is
> left alone.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 56cec58bccb7..c5e28a52114b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5087,6 +5087,15 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		int size;
>  
>  		if (unlikely(gso_by_frags)) {
> +			/* The walk only goes one level deep: running out of
> +			 * members, or finding one with its own frag_list, means
> +			 * a nested frag_list that head_skb->len counts.
> +			 */
> +			if (unlikely(!list_skb || skb_has_frag_list(list_skb))) {
> +				DEBUG_NET_WARN_ON_ONCE(1);
> +				err = -EINVAL;
> +				goto err;
> +			}

This patch became quite a bit more complex because of my request.
More than I anticipated.

Are you sure this first block is needed?


>  			len = list_skb->len;
>  		} else {
>  			len = head_skb->len - offset;
> @@ -5096,9 +5105,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  		hsize = skb_headlen(head_skb) - offset;
>  
> -		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
> +		if (hsize <= 0 && i >= nfrags && list_skb &&

this test for list_skb != NULL is new. Previously this code already
tested skb_headlen(list_skb) without it. Likely not needed for
anything new in this patch?

> +		    skb_headlen(list_skb) &&
>  		    (skb_headlen(list_skb) == len || sg)) {
> -			if (unlikely(skb_headlen(list_skb) > len)) {
> +			if (unlikely(skb_headlen(list_skb) > len ||
> +				     skb_has_frag_list(list_skb))) {
>  				DEBUG_NET_WARN_ON_ONCE(1);
>  				err = -EINVAL;
>  				goto err;
> @@ -5216,6 +5227,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  		while (pos < offset + len) {
>  			if (i >= nfrags) {
> +				if (unlikely(!list_skb ||
> +					     skb_has_frag_list(list_skb))) {
> +					DEBUG_NET_WARN_ON_ONCE(1);
> +					err = -EINVAL;
> +					goto err;
> +				}
> +
>  				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
>  				    skb_zerocopy_clone(nskb, list_skb,
>  						       GFP_ATOMIC))
> 
> -- 
> 2.55.0
> 


