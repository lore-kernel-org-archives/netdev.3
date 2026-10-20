Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526980;
	b=HFOZO/mYRhyuyTjuZTwiEUcT7tYAIUzQyUz24zgpJpYQ0mPFQGVbXVdNj3DHfk3FOlOJ
	 jOLj3sIYGsdjlHuQgAnyt9Una3i4SowtXqOyaMpx+tQjab0xmLNxSFaeTW95GZCyxX7dK
	 AphRd/HpHPd811fIIjaioL4hHed+WjXZZkn/Avqm/vl5Kcy7GaShpIXHO37sWcNahUlvb
	 91oI9juevNpJITv5jUX8KnyKm8oDsWcH3NSP1gw/CGwRJHVR5pldODv5785URbur2v1nm
	 39UH1qSJ0GZ2CUeT1cNFtii7kQqtoOkv8u4OVuS/Y+w8cpW+7rvbIG8/tY8+UUHO9Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a/FHpmQozRyX6PRPz0UuyxMFmwgJ5gMZhHW6lZCR6ao=;
	b=ITL4wTUC5U2V2gF0wnNphoyz6G4ExyV9P8SnnizQAvax6Dr+BWtsXQTkpU2wXkKYpS60
	 qpY4pE7nRkIsl5LGMx0S43EI+zfBPM89rpp0yF70VuyYOptjpJ5/aCMOsyQ5JoEhBjHdt
	 8T9SDC+7oqtfl9eVRASveyGG1ZApaFvXfthjjVI5lVvUhgANiwPN0iaQKGk/birIdLYiu
	 hIUiK2A50yZoqQdJaSGvrPdBUWNWgHFUq6vWwdTzDGmxcMigRZeWYiepA7C12rydWH+XW
	 dc/iA1IcYG4Lczlhzjmtj199C3b7T9FophjwIi9/R28Xkvc8NqXtA+WhpBeJZTG4WIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="B6/6wkgC";
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8D606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B6/6wkgC
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso342405e0c.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526979; x=1793131779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/FHpmQozRyX6PRPz0UuyxMFmwgJ5gMZhHW6lZCR6ao=;
        b=B6/6wkgCtTCgJammcFuwhqKlnyTGcX9RcrAEXFj9ZVVXjP4qzu5LOITCyDW6EZ1qCr
         x9KwLuEgVoT6rHJuJsR48lfA6KwXYbTiOIPg1HGxbggojsTpvvutYsHxAfj76SU9PQe0
         A+ajBbMFa7YK1+xEU+5ejZLe569WkcY0ClVwZavS9r2CPQNiMWFBJIsxVArL8dBzNXox
         jcWO8dOlLGk/MElONkaxHRfmVfo6Y1zU5bWnHXW6bqVxrjRwGX34OyX5JGFoI+rDyrqV
         ycxc4Ak9UakKVW1PRltZrvZ3maTSfkcIYDHwdHNnRcIl+cFUmdO5UWXda5BOwjnWWFN/
         3PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526979; x=1793131779;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/FHpmQozRyX6PRPz0UuyxMFmwgJ5gMZhHW6lZCR6ao=;
        b=bu2Q4q0FGstAKc0pAQX+16xdPEQShv3QIFfis1bcFub1bzWhSBM7E7PNxD8Sv8c2He
         QEsGCtbC1ZZD7pNpIhNufD/sMyKDt6GGYhX/6ac6DBCwpbYFn3F8k+Fs98EZzPGu+sq+
         LHlLTK5bN6FP2J4xPxncx4P0mYpIE7erx1Lq7S2ly+grUaxFfo2r+ST7PFJ1mJBRRrsf
         xIqSvR7OL+7V7mSlMQZrf/shq9VWpAkGfytkg66Bm95/KBAiBExp5KQm5RQF1usMDuZu
         WW2UNUsrzmvgXO3v8NeX6I4bAeFNWJEzcPMx6ubSnQKQFLwK9rO3GF9i2hbwtw1d9k3l
         S5eQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrEmODzxjjtiNeKAOeB+rp14qyj6uYuB6cxeoWl24eda6SiUymr8g8sG4IZnHxWQEVYgJvm+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn0GX+s9tgW3ER6X7RIi628B6/FiJhsh2v5CnPArI/COftCDCl
	IEg+x2u9B7VV1Rdy+nehKw6cJh9ad1dzSZ1WMDIdQzTrrM80xX4tqoDI
X-Gm-Gg: AYBFou2METit7KR0WrAqxOXaxw71omEqdrW2SsNT5dTWztx86k3wSy4m9Cz3BiRdGTb
	KCxMLpXnRiVCAOP6FZgOfnGIsinzvR3eVZvoY9lA4bj+f3pfro5M5t0EU874cloUYgEDGgOr/xN
	JbSk7eGC54g4jlJhlGDKiTrxbjtOLi1GXJ43Ng29XTXgHaYfqjoTSCchYJdtkLqX1GSeu3woZTE
	N7pAiJEgURJ9Zs89p27A5Hrg0/o06KbexzQHwPCtzVxn0brKqpbjHFVwRpr/AgLHUlWX90+sm/7
	b4wrja6f4SgZrjdF/tZQL+ebRhGiF1EQ9kGBT91IT5K1Z66gmGMeBLyp2scotwSXm+SmLrv4pSu
	6GF9sqNpEPKV8SayQp4l/M2chu1y5KbpUhWwP+8NzhW71+DFKwBYm+hwvLkJnrvV7wC3TyGkl9q
	vTb0xWi9mvxxvX8SAClnhUMzDI2NliSp5tFqHzSAio9lBveqkASMm8PW3U4Aw5TryvwsH7b2sjt
	jmigLFNC60JnqJqCxjuIVCQU/wupEf1xCZkKMmwZp0w+ebi8V61RiDwGaAOAj9Oq394vhQSc0fV
	/LDvsn7HxLmHlu9fqZBtxd5q377CIqInA6bfhQ==
X-Received: by 2002:a05:6122:8616:b0:5c9:a60b:e5c8 with SMTP id 71dfb90a1353d-5eaaa414a8bmr4189894e0c.11.1792526978625;
        Tue, 20 Oct 2026 13:09:38 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae981d239sm558143e0c.14.2026.10.20.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:09:38 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:09:37 -0400
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
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.29f6b224b2d77@gmail.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-11-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-11-41dbef50b9f7@toxicpanda.com>
Subject: Re: [PATCH net-next 11/15] net: skbuff: refuse to segment a nested
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
> list_skb to NULL, and dereferences it on the next pass, before any of
> the layout checks get a chance to catch it.
> 
> Nothing in the tree is known to build such an skb; GRO flushes instead
> of chaining an skb that already has a frag_list.  Check for it up front
> and fail the segmentation with -EINVAL, with a DEBUG_NET_WARN_ON_ONCE()
> for debug kernels, like the other frag_list layout checks.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 56cec58bccb7..b6ada54ecc57 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4962,6 +4962,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_segment_list);
>  
> +/* skb_segment() only walks one level of frag_list. */
> +static bool skb_segment_nested_frag_list(const struct sk_buff *head_skb)
> +{
> +	const struct sk_buff *iter;
> +
> +	skb_walk_frags(head_skb, iter)
> +		if (skb_has_frag_list(iter))
> +			return true;

We can probably check the same without adding an extra skb_walk_frags.

Perhaps

@@ -5025,6 +5025,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
                while (pos < offset + len) {
                        if (i >= nfrags) {
+                               if (unlikely(!list_skb || skb_has_frag_list(list_skb))) {
+                                       DEBUG_NET_WARN_ON_ONCE(1);
+                                       err = -EINVAL;
+                                       goto err;
+                               }
+

> +	return false;
> +}
> +
>  /**
>   *	skb_segment - Perform protocol segmentation on skb.
>   *	@head_skb: buffer to segment
> @@ -5023,6 +5034,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	sg = !!(features & NETIF_F_SG);
>  	csum = !!can_checksum_protocol(features, proto);
>  
> +	/* The walk below never looks inside a member's own frag_list, but
> +	 * head_skb->len counts those bytes, so it would run out of members
> +	 * and dereference a NULL list_skb.
> +	 */
> +	if (unlikely(list_skb && skb_segment_nested_frag_list(head_skb))) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
>  	if (sg && csum && !gso_by_frags)  {
>  		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
>  			struct sk_buff *iter;
> 
> -- 
> 2.55.0
> 


