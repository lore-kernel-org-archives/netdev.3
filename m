Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5F414DC9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770421; cv=none; b=W5OrvDmatnrd7NOmdWHFiZnsGSU/TqC0EIiGgIoiXS0uPTAe3cVwlWHAYif78IhWnJ3MfT7BNSTu2NSyUJGQ7sWGTzyMhTujdZKjWFvuoFEenhDNwICq5nmaG8OGVKJfvghgyiBzXD3G9YEgLX37okkq9ouxL7J/hTmiRhfX2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770421; c=relaxed/simple;
	bh=nSQVfcEKUDzcVn6txqrTUTXtTY5Rt7mGPJf60BnRvJA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OYd+W1+sopXbqAZJj8hJesPaNQEgoDMO05zc90IIF0hmaaIRnapjp3PIcCN8DQMuJvHleV+fMJ4hKWkNg9RxAFnKKsT7jjPp7RnpzTmIfJ0DpOmI3pAx0fmsRaYlA3X3DoskI/wSNxpfbcOm1BhG7ETK9LG98iuvD5X+9E1oV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJtYfFE9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJtYfFE9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff05e5d009so41615787b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785770418; x=1786375218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1s3fgM0FE9Wd3Hmeze1Hi0a0MQ/TEreWO+/MiVyLIc=;
        b=cJtYfFE92aH9ZX561y4lET7o4usLjHJPl8Pz0OI+tF//R6LbKDpBnoiwXGlxAI9KRZ
         GbE9pHllzLhnUeRfaVX1RD0A1yJl3ldKLiOa/Vl4yxSJmQq+Om/E4XNm1kD/thF4+YRu
         YVa8SqgM0icQR1knE4CHN7D0qi3UC9DyK2iEbQEOZbZWXCMnnSjf7fkteNj0pJF+t+ZT
         Rdxuzkw4WRIdBiEg0D4MFKztN8ufQvvue2AORtl9zhoizsXwuxYgqZPbdDKIXpaJGnvl
         t//qqbbEdj76uUTmAGaJs/4fA1jd2oDCSyRaszy2fgGTBq53MN92I3vrCM6dWvK8XcQi
         P1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770418; x=1786375218;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1s3fgM0FE9Wd3Hmeze1Hi0a0MQ/TEreWO+/MiVyLIc=;
        b=tDpdCiX/MXWdsaoPGN8edioZ+fdVaasYR3qFK5elrFRu3vLT+4s7+6eb3J2OPwBrUt
         AtY0UbvbEjQ85ERCE88bjYnXUMoRmYx2zVBcIAkHI83uYts5nDsDglDq7olXcFdwFXlS
         Nr8LTD4qinPx781t3D7Lhu28nNsHua7oDBy/+rE4vno7xpNB0m9SdI6pfmJP2YyVpkmR
         fWd38XVT1KL02JaExtMgu5MJRLtG8l2wO+j1U+9uCC94KR6lLmRJ9Xvz/BWcMdmvko3F
         uOATlaIyMrp7ymVwHIq+LNdDv9ZZZTBzh2As+YeIDq91p5r4oyd9CR6YH3kuKZWh4zS9
         pi2g==
X-Forwarded-Encrypted: i=1; AHgh+RrNGYYn7UEVVGTEh8f/db6OMQeOchXHYnWJbWWw+OODd20QqokWzX5AXDkJJYf5rHaFf0y0ZYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8Qvvkwki1923wVaviWB0UrA/Hkbayvpft/Laomff37dZdmFD
	ldQISqOiul53dKfzMWJ1RqtTH+jPOqnT04sxHROACr2yrHDoMTP/eyqj
X-Gm-Gg: AR+sD10y+ANOBjSG2slg3U5yt3wzqEv47FQP+QELOw27LsIDjxAeSl+BxRWF/hVQ0MK
	cPxij1BFtFJp2fVOIt8xmGmQOFM2+K6FPIxxCily6Wqwtjmxvd3F7krJVomQ93rQ/jB8dMl4Y9X
	oZ+HoF+IN4U7DzpH5TEKrZJAiJtYIHj688VTfr7qxChtZngBphaKLU51zonIZLBGlCzohNGkm31
	4I/hfsusBHVsOgcm4Hor4DTyiKQE/vhBkrCiksH+kHwyUx4f9bJNpjLUqlOEDcbI4c421ClTXMA
	FJyw4dCQfphfQsrTppO5vT/GlYNmXaUxTYrVoRt8faodJkOYyhiqgm7fci5vaQWcjJyMKl8zQqk
	o16S3ZWdf0GBa2gRA5g9ezwbvTUHNQdCYZnAML7t4fEu8krZjGAJM2nnKJ8TJZtukVGmCW665ZD
	BYEG3qgyMESoIJozgNk9CFt1zBDnQ1h89KwXFHKaruVkd6H+Yz66bIdTA78qyymauhGfdWwP6F8
	RNmhbE1nBZ5xYgtrW+IyL3UUX8UHRJ2uX0d
X-Received: by 2002:a05:690c:3a0:b0:81e:8b74:b35c with SMTP id 00721157ae682-81fd4c07431mr151389257b3.36.1785770418305;
        Mon, 03 Aug 2026 08:20:18 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd10c991sm58362827b3.36.2026.08.03.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:20:17 -0700 (PDT)
Date: Mon, 03 Aug 2026 11:20:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: manizada <manizada@pm.me>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com
Message-ID: <willemdebruijn.kernel.13bf4b267a818@gmail.com>
In-Reply-To: <eomszRvXgVrS3x5vXue_XYiGLN5bMyD6kM3D3rJtIp2V6uy4BvpCo9mtrovsJihu5kC2nVfbBvqpGxU15vRCP3Wpxs2Se4ewVi0upVj7U3o=@pm.me>
References: <20260721014117.2234892-1-manizada@pm.me>
 <20260723171437.784955-1-kuba@kernel.org>
 <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me>
 <willemdebruijn.kernel.296b127eabe3c@gmail.com>
 <xPAgsryD7ZWPCp4djQ2-FNguiK-v4wu_PDQFjCQ22hABd2Y8C8lIXzAskbJ3S_yJDysh9izzb82ELATvewS2RD0o2VH3q7yirg9HH_mrHd8=@pm.me>
 <willemdebruijn.kernel.6d2e5b527c46@gmail.com>
 <eomszRvXgVrS3x5vXue_XYiGLN5bMyD6kM3D3rJtIp2V6uy4BvpCo9mtrovsJihu5kC2nVfbBvqpGxU15vRCP3Wpxs2Se4ewVi0upVj7U3o=@pm.me>
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

manizada wrote:
> 
> 
> 
> 
> On Sunday, August 2nd, 2026 at 8:24 AM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > manizada wrote:
> > >
> > >
> > >
> > >
> > > On Saturday, July 25th, 2026 at 2:37 PM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > manizada wrote:
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > >
> > > > > > This is an AI-generated review of your patch. The human sending this
> > > > > > email has considered the AI review valid, or at least plausible.
> > > > > > ---
> > > > > > tun: prevent underflow in rx headroom calculation
> > > > > >
> > > > > > This patch clamps good_linear to zero in tun_get_user() so that a large
> > > > > > tun->align value coming from ndo_set_rx_headroom() does not cause
> > > > > > SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to the
> > > > > > linear variable, and later cause the skb data pointer to end up outside
> > > > > > the allocated head.
> > > > > >
> > > > > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > > > > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > > > > > > --- a/drivers/net/tun.c
> > > > > > > +++ b/drivers/net/tun.c
> > > > > > > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > > > > > >  	}
> > > > > > >
> > > > > > >  	good_linear = SKB_MAX_HEAD(align);
> > > > > > > +	good_linear = max(good_linear, 0);
> > > > > >
> > > > > > [High]
> > > > > > Does this fully cover the IFF_TAP path when align is large enough that
> > > > > > SKB_MAX_HEAD(align) is <= 0?
> > > > > >
> > > > > > With the clamp, good_linear becomes 0, and later in tun_get_user() the
> > > > > > non-zerocopy path does:
> > > > > >
> > > > > >     copylen = len;
> > > > > >     linear = min(hdr_len, good_linear);
> > > > > >     ...
> > > > > >     if (!linear)
> > > > > >         linear = min_t(size_t, good_linear, copylen);
> > > > > >     skb = tun_alloc_skb(tfile, align, copylen, linear, noblock);
> > > > > >
> > > > > > so linear ends up 0 and the resulting skb has skb_headlen(skb) == 0.
> > > > > >
> > > > > > For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
> > > > > >
> > > > > >     skb->protocol = eth_type_trans(skb, tun->dev);
> > > > > >
> > > > > > eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
> > > > > > and __skb_pull() has:
> > > > > >
> > > > > >     if (unlikely(skb->len < skb->data_len))
> > > > > >         BUG();
> > > > > >
> > > > > > Since skb->len and skb->data_len both start at the packet length and
> > > > > > skb->len is decremented by ETH_HLEN in the pull, would this reach the
> > > > > > BUG() when a user writes to /dev/net/tun with tun->align pushed above
> > > > > > the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking described
> > > > > > in the commit message?
> > > > > >
> > > > > > The pre-existing behavior at align == 3776 appears to hit the same
> > > > > > BUG() and align > 3776 pre-patch corrupted memory before reaching it,
> > > > > > so this change is an improvement, but would forcing linear >= ETH_HLEN
> > > > > > in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans()
> > > > > > regardless of the frags flag) be needed to close the remaining panic?
> > > > >
> > > > > Oh this is a good catch. But while making the TAP pskb_may_pull
> > > > > (ETH_HLEN) check unconditional would address the eth_type_trans() case,
> > > > > raw TUN with IFF_NO_PI also directly reads the first protocol byte from
> > > > > skb->data, so we'd have the same issue there.
> > > > >
> > > > > Rather than add consumer-side handling for a fully nonlinear skb state
> > > > > introduced by the repair, maybe the cleanest is preventing TUN from
> > > > > creating this state?
> > > > >
> > > > > 	#define TUN_MAX_HEADROOM 512
> > > > >
> > > > > 	tun->align = clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);
> > > > >
> > > > > This fixes the original SKB_MAX_HEAD() arithmetic issue, and also preserves
> > > > > linear space for both the raw-TUN protocol byte and the TAP Ethernet
> > > > > header. The 512-byte value matches the existing ceiling in
> > > > > ip_tunnel_adj_headroom(), so requests above the cap can require later
> > > >
> > > > Is that a ceiling specific to ip_tunnel or universal for tuntap? I
> > > > suspect only the second. In which case this would add a new condition.
> > >
> > > Yeah you're right, that was specific to ip_tunnel_adj_headroom(), not universal.
> > > Sorry for the delay here, the more I look into this the more potential issues
> > > I find (including couple more I'll send a patch for separately):
> > >
> > > >
> > > > > skb expansion instead of unsafe preallocation by TUN.
> > > > >
> > > > > Does this sound reasonable? If so, I can post v2 using the TUN-side cap.
> > > >
> > > > Why NET_SKB_PAD, aside from that it happens to be larger than both
> > > > IFF_TAP and IFF_NO_PI cases?  (good catch on that NO_PI btw.)
> > > >
> > > > The IFF_TAP case already has a pskb_may_pull, but only for frags.
> > > > Perhaps we should just always enable that. And a similar check before
> > > > the NO_PI case reads skb->data[0]. That is in line with standard rx
> > > > protocol parsing logic.
> > > >
> > > > Alternatively indeed clamp, but to the true minimum required values in
> > > > these cases, which coincide with the values tested in pskb_may_pull.
> > > >
> > >
> > > With NET_SKB_PAD I just meant to preserve the existing lower-bound behavior in
> > > tun_set_headroom() for negative/very small requests, not set a protocol
> > > minimum for either side.
> > >
> > > RE: pull-based alternative, it sounds reasonable, and making pskb_may_pull(skb, ETH_HLEN)
> > > unconditional and pulling 1 byte before the IFF_NO_PI read would fix the
> > > immediate fully non-linear skb.
> > 
> > This is probably most robust. The network stack in general supports
> > non-linear skbuffs and uses pskb_may_pull for safe access.
> 
> Yep, I think it makes sense to have this as an extra defensive check.
> 
> > 
> > > But, those pulls would still leave
> > > skb_headroom() unbounded.
> > 
> > Would it? That good_linear limit itself was introduced to bound
> > headroom, in commit 96f8d9ecf227 ("tuntap: limit head length of skb
> > allocated").
> > 
> > If we ensure good_linear is safe, then all allocation paths should
> > create skbs with a bounded skb_headroom.
> 
> Unfortunately, yes -- I don't think clamping good_linear to zero restores
> that bound on the ordinary tun_alloc_skb() path. With good_linear ==
> linear == 0, align remains prepad. tun_alloc_skb() passes prepad + linear
> as header_len through sock_alloc_send_pskb() and alloc_skb_with_frags() to
> alloc_skb(), and then skb_reserve(prepad) leaves skb_headroom() equal to
> align. Pulling packet bytes linear doesn't reduce that headroom. The path
> is basically this:
> 
>   good_linear = 0
>   linear = 0
> 
>   tun_alloc_skb(prepad=align, linear=0)
>       sock_alloc_send_pskb(header_len=align, data_len=len)
>           alloc_skb_with_frags(header_len=align, ...)
>               alloc_skb(align)
> 
>   skb_reserve(skb, align)
> 
> I actually just tested the exact zero clamp plus both pulls on the same 7.2
> rc3. With effective align 4160, skb_headroom() was 4160 both before and
> after the pull. And with effective align 65535, it was 65535 both before
> and after the pull; the subsequent mac and network header resets stored
> 0xffff. So 96f8d9ecf227's expected 1-page allocation invariant isn't
> respected.
> 
> So I think the pulls can remain as defensive parsing, but the ordinary
> allocation path still needs some explicit TUN-side bound -- or a rejection
> derived from the available skb-head budget and the required linear bytes:
> 1 byte for raw TUN and ETH_HLEN for TAP, accounting for NET_IP_ALIGN.

Yes, I agree with your previous approach to hardcode those lower bounds. 
