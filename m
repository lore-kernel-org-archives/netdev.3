Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B840DB42
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821198; cv=pass; b=FOMrYR5P9UE31GubHnfq3WRBsXpWTD2OVbCkdfr4RLXq3RG0oPuAJjXUloI5MH16+C5OqaK0q/lXvxqAvnWp8+D41Y+db0TgfIob9VdxI3c56HxPxGy5V3gfAq67SNTOvLZ4l5mes46wR2t6KXIeZeD4acQKFuwlrMNcu8QGIeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821198; c=relaxed/simple;
	bh=Zl0Xi1im1WWgWmTNZS51xXxuwsxPbGv4es/ndeBbCpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWe+3pS1KdeknzYZzpC/p3560AlZFki9aOLX5ljICBJgZyfChV3E3NsmquJ0TuiJIXE0eeumns4ewVh84XsQawdhJVIxHD+30dt7sDLjF57aARJxRknp36Zf66IBu/f6hfEpskiHLXeWHHpnzGVb2LIpQNUR9qpNyVr1qzqlH44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq53GHdg; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq53GHdg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1530222a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787821195; cv=none;
        d=google.com; s=arc-20260327;
        b=olX8PTlzNGSIyI0mKRf9gSN8i9igSb1iZoOr4t/m7AqP7X4Ltf2HHSf/lo5c5+puQ2
         w3d+So1wxdhiCfoVdoXygmV4wbDtnjRnTHxadpBdKF89T59+CmmlcfbeDL9dMqi05ZX+
         vbIm2j+jWamcY7zpLiEp7gHg0l+blVzI0T52ObmHA9s9iItxpsBgswPNjEffguYQp0Gb
         UqQWOs6QNsNhmZXmXrRXSivEdCVKKZ5vrqjsG2fd4w2mRoODZ3Jpy5potj/wQzW2vTTZ
         A+K7G4fKOJZMRHwpk8Tf3JbinB8IpLygznzlmgSMiAYYE1MW84tqKVLQAhLjuyacE7fO
         AAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5o/wEz5/lt+36aU3uUCxwokoFei+3AJ1EnYcOWvnko=;
        fh=Ol1hsEhnAVl71+xd5LmlW4W9Cl6jLUvln/dPlWH/9hs=;
        b=I2TSmPdm4/2sldPmD3Z4cynz5PVEAB0UQJuD7+uYdlAYwtoZOE+CWIcgUND+thzMRC
         /iC//h0QHRfzRPhLj0pcn4RvT3Lzs8jF9GSm223oC24Q4vPvMc7UAaEX/Q+sxzm5NpoN
         AIMpHnJZNYl8kinxlLHkTmQmhOgTauEp0PCE13ZSNUprtCTdeqtqLRf3T0t+n1AcBJBv
         4+vnEiipPcx3aPOqepbvVypevhi6H9VvvJTcSUfo8IrB50AwqqjpUgyxJA63Dd99Gc9A
         tlSg26OIIOUxetbehIU7s1mGSbygPn2p69VDZGMUm1/VmOt27G1Vgb+82criqMwbfk96
         nGIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787821195; x=1788425995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5o/wEz5/lt+36aU3uUCxwokoFei+3AJ1EnYcOWvnko=;
        b=Oq53GHdgNBdqw4+AGnl28IpzRIZOTbf/GvP5Z6tRTf5X7JsgLaGws2zwYrU48NOg2Y
         yHB7uQw/icx3wMS7ZM8qWlKeyyneWrtTwz3dNsYNvEXPA6I6m4YYR0L/mz966mwK5JXw
         yOZ63Ji/1liHBXwoDsXIUBgEnbEJm7BvMa8aOCcfD9DcxHk/DSAgJz8mCdKxI7YxneoY
         LXV08AGywKQlxQBmnJbUST5qar15JgrBheCAOMXXMqGln92b/Y2fdRU/RykQuFberDnm
         8a0RbFdmNxA1TEDN4kNdT4cRJIV0gxHcgccTmbI/ZIkcQDhr0EJmdLMaxEJhDu9JgdqN
         eA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821195; x=1788425995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5o/wEz5/lt+36aU3uUCxwokoFei+3AJ1EnYcOWvnko=;
        b=emoNH4+hUaME9sMkO42cx5r34SDfKEHAwzo5WYsrqtPsjq/d0XRfpaSMfxnLmzsmj+
         4XmSiqBpl8bDhEfj2eXB0aQ7EPi2hsFtjUjaDzz00yyBwT8KLV3UEBbtwXB0zrLjKRj+
         Oglyeb7W1sm+YPhe3g485p5UfRxjHHQSWRKXxZbxQEKTbomgUfV68NAMTTq3FFPqZfAY
         TGbndU6HPnukJnJ6I6nDb+zL6RmqdTLsdIaODAIT8eX4uCu92KwIkxXhE0oqbl/0XQ0r
         LE+VIr2tWQJ/ne7jl3cVspbL0SJHDI9cnamC0V0KijbIqH2AfyEAIlaXQX1KngLe/hd2
         X8VQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZpqguSMoIW4fsU0Pm8TaluCLttGKWDydR7MR2RciiDWd81Ay940Dx7kDpXwV3vBSYpw8UwlM=@vger.kernel.org
X-Gm-Message-State: AFuF++mR2erODXyzuO7vjI7B+wrf1YIkkDJfAcXxXLNeRX51K9gkmETc
	l+kjZAQUXnDxIgW5FD5H1qMtHwg9maqvtRCXaTDmB44CirumGCSndNgUFBdHnFeoiLRFoukr8x3
	auGz6ry0mL+4KTMUn3Nyiu6hosLQl43g=
X-Gm-Gg: AR+sD12NcDrk85hJ9EtSnaGt3uO1fhO5biv1i1XS1WzPm/phAd/Mq344ewBg+uwGp6E
	iDV8qo1oGkEC6Xh9SzxHIhZjpkyRtpyGV9vcGF1WVoqTbVWP25BrfFH4137KBbYbjJFJLGVRud+
	mG197HWr0hJE0bg1tFlX5XGZagcutbjV4/fZKYRmxy6mJ49IiHwdAnuxpqCMHP9iYDMsQ/bNvkW
	YD/96w/0GpRZ8eh9t1yP1LhXx0gldGty/eZVuNnabv5tCzV+HD/HlJvzmFLuBp213s45nOmmRrP
	mseX/NPN7BVjWgW9tfiuNCLB7n+DsuRjk+z4EXl3OPefWYxs86UDY8Iqafz9SFxLKarbAeke8mp
	EbQQHwFnmuaAMqdiWVCK/yDXQHiPlmJhlGZgBGTnENtzsdwZlJkU+0zUUXV4l
X-Received: by 2002:a05:6a21:680d:b0:3c3:bbe6:95de with SMTP id
 adf61e73a8af0-3cf75e8e39cmr32380428637.6.1787821192868; Thu, 27 Aug 2026
 01:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260825214928.rz52tysloa5yxq2y@skbuf> <CA+DkFDaHQVE8g2iDUrSbRcY6-xihJQpRNommh57B8wRnePZa1A@mail.gmail.com>
 <20260826153634.ygcvnsbtc4ibpp7f@skbuf>
In-Reply-To: <20260826153634.ygcvnsbtc4ibpp7f@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Thu, 27 Aug 2026 10:59:40 +0200
X-Gm-Features: AcwNN1WGPx46vyjABkQI0k31IMmNVq4-GWF-LqDO9U9Aw1o6rsQ0YaaLuGai6Tc
Message-ID: <CA+DkFDZLv5BS7z7MEV_uBFdNgfrBQr_nkzGa2q6BKx_F4fU0xQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 26, 2026 at 5:36=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
> I suspect our documentation is wrong, in that both for USXGMII and for
> 10G-QXGMII, we have the same text:
>
>   Set the Link Timer value from 0 to 6.4ms in 3.2ns steps (312.5MHz clock
>   periods or 312.5 million XGMII columns per second). The reset value set=
s
>   the Link Timer to 1ms (312500).
>
> But when you think about it, 10G-QXGMII multiplexes 4 ports over the
> same lane. So each XGMII receives one block at 1/4 the rate of the lane,
> because of the time slicing. Consequently, by my logic, the PCS link
> timer, which uses the rate of those columns to keep track of time,
> *can't* have the same link timer tick for both the single-port as for
> the multi-port mode.
>
> I was suspicious of the link timer limit I obtained (263050 ticks,
> corresponding to the ~0.84 ms I was talking about yesterday). Higher
> than that, and the AQR412C system side autoneg would restart (and a PHY
> counter would continuously increase, indicating this). Furthermore, the
> AQR412C system side PCS would never lose block lock.
>
> So I wanted to see whether an ENETC, using the single-port USXGMII mode,
> could also make its AQR112 PHY to fail in-band autoneg in the same way.
> And surprise, I could, by increasing the link timer to 1037500 ticks.
> Surprisingly (or not), the maximum # of link timer ticks for USXGMII is
> 3.94x the maximum # of link timer ticks for 10G-QXGMII.
>
> So actually, I suspect that when we program a link_timer of
> LINK_TIMER_VAL(1600000 ns) on 10G-QXGMII, in reality this results in a
> link timer of 6.4 ms. And my AQR412C doesn't like a value this large.
>
> The above is pure speculation/intuition, but it's the only thing that
> seems to be consistent with all data so far. The only unknown is - why
> does your PHY tolerate a link timer value that the AQR412C doesn't, and
> will it work when we set the link timer to 1/4 that value?

That sounds plausible to me, especially given the ~4x difference you
measured between USXGMII and 10G-QXGMII. I hadn't considered the
effect of the time slicing on the link timer before.

> Could you please test the diff below, which should give us the info to
> the second question?
>
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index 305740b577fc..735ef4069a7f 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -24,8 +24,11 @@
>  #define IF_MODE_SPEED_MSK              GENMASK(3, 2)
>  #define IF_MODE_HALF_DUPLEX            BIT(4)
>
> -/* USXGMII replicator link timer step is 3.2 ns (312.5 MHz clock) */
> -#define USXGMII_LINK_TIMER_VAL(ns)     ((u32)((ns) * 10 / 32))
> +/* USXGMII replicator link timer step is 3.2 ns (312.5M XGMII columns pe=
r sec)
> + * for single port mode. For quad port mode, it is 1/4 of that.
> + */
> +#define LINK_TIMER_VAL_USXGMII(ns)     ((u32)((ns) * 10 / 32))
> +#define LINK_TIMER_VAL_10G_QXGMII(ns)  ((u32)((ns) * 10 / 128))
>
>  struct lynx_pcs {
>         struct phylink_pcs pcs;
> @@ -187,7 +190,10 @@ static int lynx_pcs_config_usxgmii(struct mdio_devic=
e *pcs,
>
>         link_timer_ns =3D phylink_get_link_timer_ns(interface);
>         if (link_timer_ns > 0) {
> -               link_timer =3D USXGMII_LINK_TIMER_VAL(link_timer_ns);
> +               if (interface =3D=3D PHY_INTERFACE_MODE_10G_QXGMII)
> +                       link_timer =3D LINK_TIMER_VAL_10G_QXGMII(link_tim=
er_ns);
> +               else
> +                       link_timer =3D LINK_TIMER_VAL_USXGMII(link_timer_=
ns);
>
>                 ret =3D mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
>                                         LINK_TIMER_LO, link_timer & 0xfff=
f);
>

I tested it and it keeps working fine. Logs below, but there is
nothing new compared to the previous test.
Given your other email, for v3, I understand that I should retarget
the patch from net to net-next.
I'm just not sure how you'd prefer to handle your changes. Should I
fold them into my patch for v3, or are you planning to send them
separately?

root@tru-:~# ip link set up swp0
[  134.191267] mscc_felix 0000:00:00.5 swp0: configuring for
inband/10g-qxgmii link mode
[  137.215349] mscc_felix 0000:00:00.5 swp0: Link is Up - 1Gbps/Full -
flow control off

Best regards
Patryk
