Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1393B9D98
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723689; cv=pass; b=NLHM2MdvLLZjqqaQkwGe2vUWSlBJ1iOHtZ9h24tnULDhJi6PjW2ERU77zXpJXlbOPTIe3cDY20AW3lstptLmcCiPnpqfzhe+hDVZ4edJvMlI679dCJDmIUg6i3B+wbcfE4eYk7hiOjf72XBId4LxqJoLaLC+EumKiXN8h2iy88k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723689; c=relaxed/simple;
	bh=VJT/xv4TOnyvyWaW7CqWNytji0v2EjJCwHCotLsHQiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b94L7ONsIOSmxlN9lRMtC9iExettdpsRa03XlwjViKDk7TIhHqTU7+zm4GKiBRa4dd5SvF8pOPFVFpEr5Ou+wiKoBJ6nxPKj1ep79HCBgkNwL5Ing4OmrDjpfSJUmQRq3gGxLef2YEkNH0sjGoN5/e4SwoIdrfs3jZYvJhLgyqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=LLQck4LO; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="LLQck4LO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b813ac020so1050316d6.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791723683; cv=none;
        d=google.com; s=arc-20260327;
        b=sviT+RcvPQaE69iJZfOIzC22BXrjk+jJ/7KeDAqWFwf4UghxYUdB+qJRaILIBgC6o8
         Hq/sfCyd6Ze69vV0+L6ez36TRvk3pDdPE1TO8+EH4k9aGlAFjsPm2/4i1bcFVwBa7zgc
         v03dXDrrKpLV70XI0GA4c7Qqls/pHB6MzLjeBXT44jAmiej+HURaF5sTurkqB7GTAxwB
         bkHC5JEQ22QZ6WKmYrmfr+SRDeVqW2Pp5/E24qOth/C+VR+EfnAnjijUgsEehOXoj5iy
         pf/NRVlxMdrkOsc53L64r0BfOOkZC62U9kX7L2GLSGAa6Rv7zY4GPbF0kelJkKnsAZzg
         Y4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=710+ECo1g+nv54gecwVSO644bkeC1UbYdL+hIsbub4I=;
        fh=e6tmw1Mc/fjL9L4s3ePQ+6hQtPqmLyUC+KU5CJ11Yo8=;
        b=eFt6R/0R4lZO7QjWsSMwdf3CUWbMpwsEaO1KPTnyOj0wLFiraC1s2TARODrMwifk7O
         UmzrhTY0/p/wthfsmYyNayLet8XrsgizMv/vdCzcqnq+AH8jOUPzDpXsz365bCppLohS
         0RaK1tSHP2vxIFAIvctKKcyrAFX4kMqvPOYF1uEfJUcKr4FW/xGNrFKTf5yhQTp8WGCB
         uff4ADpuciszBwm8pwy9p5OQkZOmpkfqkA1jl7tVYzDlfV3AAZOISiqMFUilcnR0T6wb
         DbVTpSPC+8lAGzJ2DX9oE9soi7c5obalE8Inp8il6kIPPX9/JbAETKKlF8k/pabq/bHF
         v9sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791723683; x=1792328483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=710+ECo1g+nv54gecwVSO644bkeC1UbYdL+hIsbub4I=;
        b=LLQck4LOQzYM6vMEe8QxG2sesFU58laxEumgy9ApGdv58kcKZ+wXj2JhR9xumjXQq2
         1mHixGLsfOhpy9gdWV2S6iFO2Iz5U19b5YWCq6ORzrrBsjJ1GAlu3A/IXlTk2N9Bp7IY
         K08/VM0Si/b7kEex7uUPF/tgJ8zeJMFAfoFFN8mg0JzY0MrxBNK1DHOo+l/GbnJENnP5
         nqv0/xZvCoWoBYPAL0+mPvgdWkDNVZKpsfsXGZRCVTAzzhSZdLADdXAuzfZvhiuo2DZB
         7nyIcPdC1SMQ2dj9iZKSC+YGR2N5c48E84eufNcoT1M+naW+lmwUO5GFuJhdK23ZNscT
         TJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723683; x=1792328483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=710+ECo1g+nv54gecwVSO644bkeC1UbYdL+hIsbub4I=;
        b=O/q57fi+Ftsd/FmXhPXkqFYo2nSVFoHR+X9tN7ltWWni2go2MAA9+0Pliheg99QLqW
         lwlwsd1jpomYS8jyJ2Flzt1K+cHDONRGA1s2ivqtHF22VU1Wvy5yLIPI6BqCB8XokCtS
         NvlSVAHH+CDsBeang+qi8YzhQQ6ZY+iqofTV6fbxS2pn801Kin0KQLRtvZlpTl4M42sg
         GYIcwpMQ/7HP6CsMgkrRaRMiRf/m5gtYyFBR5bPX7gJyqjlaykOhYD7FQEXMkDbCoBr6
         cnIlecqbAEAnGXIQHpQ5k0QVwerRsFcDGrwR3dhtPa5SD81+gZOIvn+U43WIf7hVEJz9
         jfAQ==
X-Forwarded-Encrypted: i=1; AKwUvByq3qyFkWFhHtFMQLqLUFbU2EetXdHbYDFB3Iry/X6D0KkAMkFg/bRCw9FEyRkJ6e5vx00MwXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIntv69C8BEvCJo05TL8AZuEWYlQ5+l+TVzAsF1pAYyNeA4Btvj
	dzDE/mKbDIrI3akLoallh9xTJrudymx+0PinxuBVtu8F5LW0rYwh4LCbat8+FS7zgVPZqQV8XPv
	bx2q7SJPXK1K2uQHEnY9COlbwMkrvgRIOQPFwzCBy
X-Gm-Gg: AYBFou2Xk8LeZWe21Ws0uMwiHxxDkWjqxOSS6lEzjTx3QBKgjFT0VLbxBzTiRe2RYtJ
	bVJ181xxOu8Pl1S2SAAhN/ZYyQRxFVGECg8aAZsddzjgpQS+u/dVKmCGIBdEjmDa48IJLGaSTR/
	UNCpX7HXZyZnzMHFu6tTc6Iw9eFZrdyiwVfkhhdrACUYZVPNy7not36iTHKa5wlOot3DpTHNvSY
	HbZm/6gFQZIARhZSoKpIJxqlETkzcHN4YUkwvh5G6tGxbLjq4qya7dP4sRJ+sd9VUwn2Pk3/Rak
	lDHg2PptDv+TeYkggyUn1l9v3M8gh5b2NCCwGyjNK1S3ZB+MK8k+YBA=
X-Received: by 2002:a05:6214:cc1:b0:915:e732:33b4 with SMTP id
 6a1803df08f44-91b554b6417mr124823836d6.19.1791723678664; Sun, 11 Oct 2026
 06:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
In-Reply-To: <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
From: James Clark <jjc@jclark.com>
Date: Sun, 11 Oct 2026 20:01:07 +0700
X-Gm-Features: AclHuK-iWfBhKLAzxUK6ajbUqVcMn9MseKuVioPY-H1ZhOahAL30FsMFK5dLkuU
Message-ID: <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Russell King <linux@armlinux.org.uk>, 
	Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theo,

Thanks for looking at this! I am very new to this, so I really
appreciate any guidance.

(For some reason your message didn't make it into Lore, although your
followup did.)

On Sun, Oct 11, 2026 at 4:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> I'm invoking my colleague @Maxime to get his opinion. What impacts the
> MDIO write_c22 duration and how likely is it that this duration varies
> (1) on the same MAC+PHY combo, (2) with a different PHY or (3) with a
> different MACB revision?

(3) is the one case where I think it could possibly vary.  But 63.5
periods makes sense assuming the first bit starts at the moment the
command is written and the PHY acts on it when it samples the last of
64 bits at the rising edge half-way through the last period. In 5/5
there's a different situation: there UniMAC's MDC is free-running, so
the frame can start up to a period after the command write, leading to
a possible range of 63.5-64.5. So I don't think 63.5 is as arbitrary
as it might at first seem.

> Sashiko makes an interesting point with PCLK that might change over
> time, giving an example (which I've not checked) where it would be
> derived from the CPU clk which might change with cpufreq.

I tried a bunch of different approaches before landing on what I sent
in v1, and ran Sashiko locally to review. And every approach had its
problems. Sashiko is right here, but on the other hand the existing
macb_mdc_clk_div() (it's only called at probe, open and resume) has
the same problem.

My plan for v2 was to limit this to RP1, as Sashiko suggested, with a
MACB_CAPS_MDIO_WRITE_STS flag
set in raspberrypi_rp1_config. This would solve the PCLK point since
the PCLK is fixed in the RP1.

> If you share more details on your testing setup it would help for us to
> reproduce on other hardware to gather more data points.

I created a gist with the code I used (this is all agent-written)

https://gist.github.com/jclark/372822d80ba27a9648d1aea939191b53

Key point is that the measurement technique depends on there being a
PHY with a PHC connected over MDIO, which is the case when write_sts
is useful. I believe the RP1 is the only such case in the tree at the
moment. If in the future there's another case, then it can be measured
and added using the same technique.

> I'm wondering if we could do better than a hardcoded delay? For example
> we could busy-wait for NSR.IDLE inside the prets/postts region, but
> that implies at least 25=C2=B5s with IRQs disabled. Or we could do a few
> measurements at init to sample our platform delay?

On the RP1, IDLE is not the edge: IDLE comes at 65.0 periods. The only
way we could measure the edge is by using the PHY as an external
reference.

> > +     unsigned long rate =3D READ_ONCE(bp->mdio_sts_rate);
> > +     u32 config =3D macb_readl(bp, NCFGR);
> > +     u32 divisor;
> > +
> > +     if (macb_is_gem(bp))
> > +             divisor =3D gem_divisors[GEM_BFEXT(CLK, config)];
> > +     else
> > +             divisor =3D macb_divisors[MACB_BFEXT(CLK, config)];
>
> I'm a bit surprised to see you reading NCFGR.CLK and derive the current
> divisor from that. The divisor is set by us in macb_mdc_clk_div(), with
> only input being the PCLK rate.

This was something a local Sashiko review found in an earlier version.
The divider in hardware isn't always the one macb_mdc_clk_div() chose:
after suspend with the interface down, macb_resume() doesn't reprogram
NCFGR.

Incidentally, it is also what made the measurement technique work: the
bounds follow a divider changed through /dev/mem.

> > +     if (sts) {
> > +             delay_ns =3D macb_mdio_sts_delay(bp);
> > +             local_irq_save(flags);
> > +             ptp_read_system_prets(sts);
> > +             /* macb_writel() is relaxed; order it after the timestamp=
. */
> > +             mb();
> > +     }
> > +     macb_writel(bp, MAN, cmd);
> > +     if (sts) {
> > +             /* Flush the posted write before taking the upper bound. =
*/
> > +             macb_readl(bp, NSR);
>
> An unconditional readl for flushing the posted write won't do it.
> MACB is over PCI only on very few platforms. I guess the straightforward
> solution is a POSTED_WRITES flag that is then read from here.

This is only under sts.  Assuming write_sts becomes RP1 only, then it
is only over PCIe. I am not sure if I have understood what you are
getting at here.

> > +             /* Order the read-back before the system timestamp. */
> > +             rmb();
>
> Why rmb() and not mb()?

The rmb() here only has to order the NSR read before the post
timestamp read, since by the same device rule that read can't complete
before the MAN write has arrived.

> > +     /* Record the pclk rate the MDC divider is chosen from, for
> > +      * write_sts, which can't call clk_get_rate() under the MDIO bus
> > +      * lock.
> > +      */
> > +     rate =3D clk_get_rate(bp->pclk);
> > +     if (rate)
> > +             WRITE_ONCE(bp->mdio_sts_rate, rate);
>
> Can you clarify here and in the commit message why clk_get_rate() is
> unacceptable under the MDIO bus lock?
>
> Seeing your comment, my guess is an ABBA deadlock risk between
> clk_prepare_lock and mii_bus->mdio_lock but please write it out.

Your guess is right. I tried this earlier and a local Sashiko review
found the problem:

bcm_ptp_gettimex()
  bcm_phy_write_exp_sts()
    phy_lock_mdio_bus()
    __mdiobus_write_sts()
      macb_mdio_write_c22_sts()
        macb_mdio_sts_delay()
          clk_get_rate()
            clk_prepare_lock()

clk_summary_show()
  clk_prepare_lock()
  clk_summary_show_one()
    clk_core_is_enabled()
      en8811h_clk_is_enabled()
        air_phy_buckpbus_reg_read()
          phy_select_page()
            phy_save_page()
              phy_lock_mdio_bus()

I will clarify this in the comment and commit message.

James
