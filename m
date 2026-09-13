Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89030C60D
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339617; cv=none; b=CqwD1rMexEhflbiXzMT5vJRq39L31sxb+tz/Eds5UldBS2bALXtrjsuWVGI/rLhgRu+T5B1JDSmwZ+ZjYJmThswrZhbGiISMeq9Kj2dtR68fh0EUWJPwayjAC4Ubazxr4JAPg+xrvKgRQ7NEXsA3WLR+ul33n4rp09+9DO22n9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339617; c=relaxed/simple;
	bh=f7g6zXVilwddxptfkL/USO9oZbQ1gzWDd74Fx4qifog=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QjcCC+FTOxl0l/fBYJz/iWoaHdMghLAm1RyvHGEBSCUJDG+QH2RHjWNszIqP0+RVhJaZcjtEDiJRGHpRE9S1Vsi74p5qH8hOeWKr+epJZPdIeZ/SLQ8jZVPBje784a3VythwF6gO4GBB+Xfnd8hk6UkIqJj7OgCy0w/g/Qq5rO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7mVFiLU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7mVFiLU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8706dfdcd4fso24310117b3.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789339614; x=1789944414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2O2w+/0+tuJH6CYorTtrmcLZUju0PTpZ3Cer9pa/gqA=;
        b=N7mVFiLUQWpxKAZgthOiJqCUKTX59+4jU8MFszY3n7AsLqNxMvPoRdGbNzxtyvKkg3
         CaAAOSkxHyWDC63vpfXnLa6z4vI820iasa32O3cLwUab73KNGIcl/jJN84V0euXnrq3a
         RaCssAouxXeXBiXs4V07sSR3y7HYp26Er9suLPuK9pHKHlZ9acG1AQtnTDXd7HxT6v09
         zY7uToss3SNZdBI/PD+owPXZkqQKkzSo9V0kJrYRUckiB3QTHnsUxbw2rJg2CE+l3KkW
         JhGkUYTM15ZsrNjdZGXoBReW03A2RigwNKyCLyLQxb0knqgSu4zUls8nwbxYVrILwUAJ
         TQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789339614; x=1789944414;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O2w+/0+tuJH6CYorTtrmcLZUju0PTpZ3Cer9pa/gqA=;
        b=SeHqb/dBFsyOWoiAJTFudxK2snrO1C+p8e4wxo1c6QzB/Mkz+ICUB5lysxyDgqjtNh
         O4JpxZJ1DiXurcSXQOE6SawPnYQUi/QWZY77m33rwJnLKSK8oUQmG0PdEPp5ufhTM+Gf
         ZuVsB6sTKYJXiP8i2a38WI8BKsbGOIW1ZpJPhprneb/BiesYn8h1b/wadZd1tCVhAC+Z
         e5h2fIDKEM/uZwQqGfoeV6oye1/wyeL+ua/tXbC4IJJXcmgXWGmhfxs6XN5YJ1O0YR0O
         Wyt0Joh8ZJexn8T3t+SaHcnn4yxbak16iLXWy3aBTwrwC9EocdJhsGxdbb3FLPUer8OV
         +ViQ==
X-Forwarded-Encrypted: i=1; AKwUvByNW2lODHsPpmOt/vOs3O4aw9zLjqk0t2KZiAnRPIVXa9AvDXUq7/Oo+2nGEbFVFtQi5Jie10E=@vger.kernel.org
X-Gm-Message-State: AFuF++mjyh233KgVpR5J/bYWzuUwo/O0I4WHOR/VrzPIY1bcPi/pwOIx
	43172u5o1fkqVLWTt3KXgRZ2A+7+w9yqzfx+QmU0/NKdQLusXKYvd6gd
X-Gm-Gg: AYBFou1GdMtz1vCvklBExMRttPk9yRI7IzHO5Ur8dhIRIO9bN9co4hxuD38GFiM35ou
	blr0ovdtlQMlS3QN7aJtjnaxGl5o2XP9U7immcUI/p2JoiQXJFHrDlJ2gurl7ANGG2BF4fT1QO+
	GwE0Zh+MM4ULyUQPanHrIbOH1dDvPHvk57sTs8WmX6vyqXJ8R/8Jeftg7wwTHamdGBqWgUZs5ZR
	ZMpqAx5Ef2ssYequwkmUGNVEtw31O3srgu21s8IQiawuVEGek0m2XHFzic09uMMqZH3YJfmzz35
	Ms3D6MkVNIQFsdjELAtWA6Oyp3m/ZJblut6tHWFPCQwe8tILDR/IQjgF9J4a0pMz8/hqZMTvywL
	G2qjRK/PaUYLL4V24+uA8hVvHhUO2621IdUXjJpm1RZm9odUTtiY+VUgOs1hQWI21Cip/smDnUm
	T+hkE/n6osNo7X/5LTnIIAtXYzENDCouoVKQEez88EigATviQQZm7si9khLyJer4JwOSbG8TSPZ
	FwZo+x5cbhkSOjtO3VhIX0tinZSBlMp42VvXpVnm05x3Iz00JLc
X-Received: by 2002:a05:690c:60c4:b0:873:5bb2:6c21 with SMTP id 00721157ae682-88d22ed00b0mr322407b3.40.1789339614081;
        Sun, 13 Sep 2026 15:46:54 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488c3ab26sm30991127b3.40.2026.09.13.15.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:46:53 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:46:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 zihanx@nebusec.ai, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 willemb@google.com, 
 kuniyu@google.com, 
 kees@kernel.org, 
 richardbgobert@gmail.com, 
 jiayuan.chen@linux.dev, 
 stable@vger.kernel.org, 
 Vega <vega@nebusec.ai>, 
 Luxing Yin <root@tr0jan.top>
Message-ID: <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
In-Reply-To: <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
References: <cover.1789302084.git.zihanx@nebusec.ai>
 <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zihan Xi wrote:
> IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
> only state that tracks this nesting is encap_level, which records header
> bytes and has no recursion bound. A sufficiently deep chain can consume the
> kernel stack before a transport GSO callback is reached.
> 
> The unbounded callback nesting was introduced when inet_gso_segment() was
> made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
> support predated that change, and IP-in-IP GSO/TSO support later made the
> affected path reachable.
> 
> Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
> callback entry. Thus 14 callback entries are allowed to complete;
> GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> successful callbacks. Initialize the counter for each top-level GSO
> operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
> nesting is bounded.
> 
> Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  include/net/gso.h      | 9 +++++++++
>  net/core/gso.c         | 1 +
>  net/ipv4/af_inet.c     | 3 +++
>  net/ipv6/ip6_offload.c | 3 +++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/include/net/gso.h b/include/net/gso.h
> index 29975440cad5..2665acbb9205 100644
> --- a/include/net/gso.h
> +++ b/include/net/gso.h
> @@ -19,10 +19,19 @@ struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	/* Number of GSO callbacks this packet already went through. */
> +	u8	recursion_counter;
>  };
>  #define SKB_GSO_CB_OFFSET	32
>  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
>  
> +#define GSO_RECURSION_LIMIT	15	/* First callback depth to reject. */
> +static inline int gso_recursion_inc_test(struct sk_buff *skb)

What is 15 based on? Is that where in your test stack overflow occurs?

A realistic practical limit would likely already be smaller.
