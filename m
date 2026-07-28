Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C63AC0ED
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247067; cv=pass; b=I8ADp40a0jhvLYa8Zx52N26gd9zSmByQOyIbHUeWidmg/Na6OBUwB+7MO9wSfI4XPxidV0sIPTdvpwWYHTwPqjNwqqbhw/ybwAYZeu/0nKFT8ORq2alzvbaWBzd7SeLBe/eiEobNJ+ZmP9VIJoZEMQ6O2AJf8Ew04hrp9JqrzsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247067; c=relaxed/simple;
	bh=ojGfcJdBRqcfiZ4iHWIC3vFPG+TI1J10TfOqynK1Kjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krSKZVs2nwmoVxKd4tJe95ClWghh8CHqv9PLGOpg4Y34fA0VSPSkQCI83dUCon5TFVkOhssQTaPtsTmCaYk2uB+V+a/uPl7tx95SY5rl+lW/nZt+espyWd0LZ4Dgri0pORgELuUyUs2AY+wK8CcCehqsYmzpv3wbVCScUp/1grE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIPEVdxL; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIPEVdxL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-667f1390f58so4179824d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247064; cv=none;
        d=google.com; s=arc-20260327;
        b=qIOGihihTxAh8UGzhxDg6qbPf+NdajRhP+7ziZUOss31beBunRE8uuTaEMkWzSAJph
         rHgkMIUXFT0o9HUxvpXu2W0Ah7reff2RtioixdYhMNUCw40peKFZXevhTL5MCm2vjqW1
         fde4A9kbWdVgHWFC1ohQYPQagHV3NHhdaOVQlBvjQJc7/t3C8x8na3PFHrWlVk7e31jW
         5RJqjpC9E0DHN01vLmHpy1NWWglnAAqqqKbingyWmt7/eD8yKmXC7RCiCaConvTrQYBX
         N+PmDn4E4zg26PLQ67hqbZ4xEngkdFk0zFGn0jvmZh5QJMNNvyVy6RIwWBa7jt+Nd9j3
         DtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/O6ksK3AB9LZHWSiL+7EQIVBSyOjmgRfjqILkXUwuQ=;
        fh=wkl9grsE15hzVJpvDUhnIss5o6lL9tS1JVV5v734ktA=;
        b=m8D60m9q3BK7lc76YfcrTCXosPDZ0F7ZS3oQu6MC+RZEOsfkwTM9J1+5JGaILYLXyn
         lMeBqo0vA1HtN65rUFVahmMAufHHVWG9bZuyq2UlKl54v6EvUyfC6jL29hXGnqq+RYua
         2XCibplH+MjvklTNaGDA1HQdDH8zFbkwyXw1M3FGPSqyn4HgSRzw+1w52kUjDQyM/2tu
         dNsQh/FoHJ85BOoEdF2NUVZLCDNY3jFdBDndZ95nGr3AY535RFiXQUYaF3k24stL+QyN
         ZDkh6Q6fmA4fnpSqXgzHEyXff0IccjV2EfePFKj9K7DzzR1yjT3AFK0xHeUftK1CvegC
         TX0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785247064; x=1785851864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9/O6ksK3AB9LZHWSiL+7EQIVBSyOjmgRfjqILkXUwuQ=;
        b=PIPEVdxLuncXgfjoINpwtUXJ9UfvRwInyYZ/wCG9W+0HD/m3O2qH8OjPGZOmKpOjul
         /YGV5W2WcWcVsuQ7Ay0pTXSq+e1CW69n4F2G6YS5KhxDFkSk0JJVUPPSQ7cIoyYZXAia
         DJQamsmFp948avlIDxPcq/6Z4BjIdixwQGiYzLEtWSaIGSKvRgXJKEVFUBfhBRkawOUG
         t40t2+GhoC4aUirLkkwlQsUgzqZq/9GqPllLtt0j6xdTxZB0fB3gVa0cihKLOHwcPOod
         5DldA/kj+qxD1ocZVe38XUsuuD6FlE6eCSsk9kB740N1FcPZgggnRPOHazdLdcXhSKXM
         CgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247064; x=1785851864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/O6ksK3AB9LZHWSiL+7EQIVBSyOjmgRfjqILkXUwuQ=;
        b=iuLs/+E43IhVTJxFaLBdM5xFK5iqNv9xMLBs29nPoX7fo4K5+1Hmiwj+aYN7VqyEu7
         pb+0JOs/zXpQxlCYRnfzLkeLyWtVuXcPCoOhcXsuqX7Q1CwLWxjHC4cjmtKqT/9+wqei
         pO668EvVgXmFpZa/VRCr07F9H6HNANqCfCgpMdPFX+zlEdbdECpI+t43lrEn4VNpSXvD
         XTGeTpuenL1xqPiZl4rqvnJPChXgkq1sShxDHfv2lR5Ir10OAkR/zQj3aTaiaTmMGXcD
         0/TaZ9aF10qHxlzpt16bcwGE4Ud2DUnpBU750VO7bIWlM0GzoLnkR30rmYtG87wLl/5D
         sugg==
X-Forwarded-Encrypted: i=1; AHgh+RqncItc9eTA7N8CQldi4UP3xOVGhVv4YVncgmWmAIS7cwolhVjKQfPBrbOx8KBk29NWf5jdivM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVPyo7pqpwmCOkOWo7ox0wkrmqu8nCOMYeP7AvymSWxrrzSNj
	J2Vr1B740T+SmOTi562QZt5L0LMXA5RosKoK74TrjHH2nIFINTjZq+JB2kokFVABBe2vMwjCKJz
	9KDWjFP7ooDV32BQx2rCbKSgjTaQvn3A=
X-Gm-Gg: AR+sD12WlmdvfZTwaoTYhEE+UHuDA1p5IuIDNu7/w0r+dna2ZPAiGYquFYSOHPx3jtm
	ziUGqO+dp/FPDO03YIl6PdsCnR8wMNq2ti8XaThkXu5Vq3KmB5m1XXcTguaH6lNztLv1a6mWiUq
	cDozGOmATwNM66+FaWuG1fcxROgHSwLDgMoQ6pv332rj91A1hjkvCgSF1trtqDADavjzyLwNU0S
	27nVWrtKAbpPyWNJQBg9kw4RUHV+w0CLhlH6fBKtMXepqEz1feCngQ8Zxf2vj2PB0dgDzL35f7+
	p5liQkGNhlUAk788gdA/8xrIZ7fzvwZmyUbWu4x3wk+r
X-Received: by 2002:a05:690e:482:b0:667:a285:7625 with SMTP id
 956f58d0204a3-6690582d16dmr580446d50.88.1785247064468; Tue, 28 Jul 2026
 06:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727205602.1188008-1-gahing@gahingwoo.com> <CABjd4YwmznLERMx_DgfTeqXmOEZh=pcOjf+NYfkV069mETe-uQ@mail.gmail.com>
In-Reply-To: <CABjd4YwmznLERMx_DgfTeqXmOEZh=pcOjf+NYfkV069mETe-uQ@mail.gmail.com>
From: Gavin Gao <attinagaoxu@gmail.com>
Date: Tue, 28 Jul 2026 21:57:32 +0800
X-Gm-Features: AUfX_mxzpovyIRUTrYGKBrXRurd9JRDsVacqu2CDyv0oSDWGubwak2MApr2KfoU
Message-ID: <CAK2JjQVsJbC5wuLs1wFvose0S9ho6FDNPbhteveWOttE0prjeA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
To: Alexey Charkov <alchark@gmail.com>
Cc: Jiaxing Hu <gahing@gahingwoo.com>, Frank.Sae@motor-comm.com, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maxime.chevallier@bootlin.com, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

I slightly prefer keeping the helper.

This looks like a common pattern for the Motorcomm family rather than a
YT8521/YT8531-specific detail. Other PHYs in the same series may need the
same optional reference clock handling later, and a small helper keeps
that path easy to reuse without duplicating the same code.

Best Regards,
Gavin Gao

On Tue, Jul 28, 2026 at 12:16=E2=80=AFPM Alexey Charkov <alchark@gmail.com>=
 wrote:
>
> Hi Jaxing,
>
> On Tue, Jul 28, 2026 at 1:04=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com>=
 wrote:
> >
> > These PHYs need a 25 MHz reference. On boards without a local crystal
> > it is fed from the SoC and described as a clock on the PHY node. Get an=
d
> > enable it in probe, via a small helper called from both yt8521_probe an=
d
> > yt8531_probe, so the PHY is clocked before its registers are accessed.
> > The clock is optional, so crystal-clocked boards are unaffected.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> > ---
> >
> > Changes in v2:
> > - Factor the clock enable into ytphy_get_and_enable_refclk() and call i=
t
> >   from yt8521_probe as well, so the YT8521 is covered too, not only the
> >   YT8531. v1 only touched yt8531_probe.
> > - Carried Andrew's Reviewed-by; the enable itself is unchanged, only
> >   moved into the helper.
> >
> > v1: https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingw=
oo.com/
> >
> > A second crystal-less RK3576 board with a YT8521 needs the same handlin=
g
> > (see the RK3576 GMAC 25M refout thread [1]), so v2 covers both PHYs. Th=
is
> > supersedes the withdrawn dwmac-rk MAC-side series. The DTS that consume=
s
> > the clock (rk3576-armsom-cm5) goes to the rockchip tree separately; the
> > clock is optional so this patch stands alone. The YT8531 path is tested
> > on an ArmSoM CM5-IO (links at 1000 Mbit/s).
> >
> > [1] https://lore.kernel.org/all/20260727021048.3375444-1-attinagaoxu@gm=
ail.com/
> >
> >  drivers/net/phy/motorcomm.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> > index 708491bc1..32eb5ce93 100644
> > --- a/drivers/net/phy/motorcomm.c
> > +++ b/drivers/net/phy/motorcomm.c
> > @@ -6,6 +6,7 @@
> >   * Author: Frank <Frank.Sae@motor-comm.com>
> >   */
> >
> > +#include <linux/clk.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -1043,6 +1044,29 @@ static int yt8531_set_ds(struct phy_device *phyd=
ev)
> >         return 0;
> >  }
> >
> > +/**
> > + * ytphy_get_and_enable_refclk() - get and enable the PHY reference cl=
ock
> > + * @phydev: a pointer to a &struct phy_device
> > + *
> > + * A crystal-less YT8521/YT8531 takes its 25 MHz reference from the So=
C. When
> > + * that reference is described as a clock, enable it for the life of t=
he
> > + * device. It is optional, so crystal-clocked boards are unaffected.
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int ytphy_get_and_enable_refclk(struct phy_device *phydev)
> > +{
> > +       struct device *dev =3D &phydev->mdio.dev;
> > +       struct clk *clk;
> > +
> > +       clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +       if (IS_ERR(clk))
> > +               return dev_err_probe(dev, PTR_ERR(clk),
> > +                                    "failed to get and enable the refe=
rence clock\n");
>
> A helper for a single-line function call looks like an overkill, and
> requires scrolling to understand what is going on where an open-coded
> version would be self-explanatory at the first glance.
>
> Maybe fold it into the two caller functions instead?
>
> Best regards,
> Alexey
