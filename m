Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D282D46A1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204872; cv=pass; b=Bm21YROsRj2gCgNkMAxKZTBJvNL8Zm71Y8x4pSeAyH2r7JiFIeq+VnqgNoKrP31ahcEUxHuHR5ZoB9mWQtHHbf4IB4ANMoGVBmSa+7GckLUTHlUggHjlxj5aRdYoLReiKMjEQGCkAFKDv+h+g/cB1Cl9xCGYttEMP48N0YYQMGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204872; c=relaxed/simple;
	bh=eny3RK02S4/Mh/D9RLG3tWEsx3zPf7uXemh3o5mnl54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+ALjbO2xT+PbMhExfyDm24j/0YO0p3vSnSbZeRykGltM5amnxDIsPD+rNyrrScy8Tm4urcZ2m2QcpzNDFEwyqSURe2A4YVpKPidz5owu+4ydcy4NOonGux5nCxL6IhYE4AGPehXoF90ld6i+MLQjCb8/CxoV2DK7CpCLM+1+FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb4hvn+N; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb4hvn+N"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f3b227a4aso42724087b3.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 19:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785204870; cv=none;
        d=google.com; s=arc-20260327;
        b=boz3C0vf+iBV6A+4xBMkPFINzM+QtOWddA5q8SCDxPWpbCn6wDhblzHfVVdKKfrhgu
         JmrwYz8IKPYx8V5Syy4Y9aqMG0IuK1c3LOK/wEKXbpBM1Oj+WKQofE7opjPx7aOBCHV7
         KNqXA5OtVucM8CiURVJrxXetAKMHGTZjlUektqsQsPeu4/50nadfkKc1FxXjvorMcKiR
         /RCb3yxuyDfCjtXiY3leXxqXDwKAJAWkmkpRjAa/A3f+0MEIjL3DTM4BuL+CbaxZB4Ys
         BsGTzjIkZBuKGHvw5tbEFmFATuHgvu8cAVEEeJzxFcK5n+g4BwT8O7wizzsFxGDaSyOX
         eZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s66f5dxTpDYOfgWlIibSDtZoO/MusvgYxmCX/XIHZDg=;
        fh=wWBXkg/SJkRGmDgV4r6eOfMp1L6N9FENRNKt2BnN7IQ=;
        b=jvuNnx5gqBn4KaMSwoVzdaJ7EOUn+2D+FObKuy7H0CK+pGyZUESDmsB+S/fbyoYUYE
         F3N+rJky2TVdFjbPOhjT9VnT7LxX8vpp0swD/t+EuBu8N25lTymkdzU3owaN/YZASJu6
         rJhZGFOh6Z/1/jgvFmH1XQaCiVPMs+xm2ehLoJ7k7RntESFi7WroQizzugNBU0LaQPbA
         uAFluLNnTUn8B399DoaWohyEJdr3/E0ruWiSR3UvYv+W4Z8uwTRw644niJmnXFrOSrA5
         cQhu8Q1K+1zxhmp9AzMz0q+LG2oj8OS7/ZlJWB05R+GKT9EMyeXZeeLRIpBZC8NPwZ+w
         Y3FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785204870; x=1785809670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s66f5dxTpDYOfgWlIibSDtZoO/MusvgYxmCX/XIHZDg=;
        b=Kb4hvn+NVdKrIN2J0repdB4lLuu8z30Ror/YLHOFG/xY0FzE/FTn/qUCSTWVX3ujvd
         oCAOcF18WPIDgqWKVfj/V24AVGzJSxgnbqUCayBQD+2Or1zraWKm129IL5X6ekY8Koeh
         REkLuYWnM4FPaKugc0GtfG+Wkliii/YsCaNHJOQQRdhW9dH16Yb+zuGOw/QckVi1Q7Mr
         rwmTZ0TveqtJEA22zAe9OLcTdRwL/K6EPiLupRsz5zkTtsmb1BN78nVMOsnm4ItU9IpB
         trcXLl1nxWNMvQFFcUwQYaHOMQL50jmaXiNWHt0AmTY404VYmtjJ4ncI7cQe0ii+9V7w
         RjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785204870; x=1785809670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s66f5dxTpDYOfgWlIibSDtZoO/MusvgYxmCX/XIHZDg=;
        b=Fy++MjaaGjZMX31Y9oYSG3hgkR+EoEBwD5ICNAELzsKxcG+Jd5pqxwaE01VYMLFN7H
         pPWYJ+1Z5Orv0NOXf3cDn1bKVXlhUgbXrg7yGTX/9Wu+tfztAjEI2z1YzcaR092xZGiS
         RqU5p4W/7wpK8xU9P+NdlXrMLi34Joxq+PNJmVvdCsB2zS2OUn6dhJvPLvXMwWycCsgJ
         9JOr38S1oA136vQL+ZJXAssQD6XdJn2kIgZMIoW98hK8uwFZCiQ6Au6fv8cFR7ZHYEBc
         piu21aFSVSxwokuiVqC3VXFF6OYfzYJRKUEGYGL2WWDxEyncAGL/0XN2cUkrAWzlYqL9
         BwVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTQiXIAHBFmDvfint7Ve43izvIiZaszIR9TecBEIUL9+lk1t2L1cgXzJK1XMFtfWb0bM0COTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+27yFU/oGTEmya1JT/P6AbwEo4ypGkHQPH9zyjqD8NKAizQgz
	p72OdutCJ6vgyeV6pILLugff2KDst3ioh90QTcuBbfIVzQo+Falngw9CS9gt4Ql5geN/4/Sk9tD
	ozLavkMwAC05HlGxNlDM2Oi2nK4EC3FU=
X-Gm-Gg: AR+sD122ApqmCxqcMkteqXUqcp6tVBdvTvlGNkltxfzDS8uw8RRW/9sBtmjtzAvyAyj
	6nP9yX0WOYfSDKhLoj0bA/pZC6aNbuW/F2Ma/pUaTJZVe3bndozQithJtdTJ5/aB4V1AD0+ahe2
	XuOki99t0QIZUn/HnMQQ1hGkfRPy3Orju0H+jHOTcxMFVj97ods64lusHc7a8KU82ILzqcmm/3P
	tr2Fmfb4wjHOHZjj1INXN7h7c8XIESZMRXAF2CnSqiIBmNx87PUCPVZ8WtZdg==
X-Received: by 2002:a05:690c:6804:b0:80c:f6bb:565d with SMTP id
 00721157ae682-81f9921c3bcmr1821787b3.19.1785204870332; Mon, 27 Jul 2026
 19:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727205602.1188008-1-gahing@gahingwoo.com>
In-Reply-To: <20260727205602.1188008-1-gahing@gahingwoo.com>
From: Gavin Gao <attinagaoxu@gmail.com>
Date: Tue, 28 Jul 2026 10:14:17 +0800
X-Gm-Features: AUfX_mwPthmXiJzhXc55bA8wYRZBnevQc-idOB6263_HLyZuhE8x_4eJln52qSQ
Message-ID: <CAK2JjQU28+Q5ZU1atm09tuMp=P0gd63L7xY-8dX3G5weS9Heeg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org, alchark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

Thanks for folding in YT8521 support.

I tested this on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
The 25 MHz reference clock from RK3576 REFCLKO25M_GMACx_OUT stays active,
and Ethernet works.

Tested-by: Gavin Gao <attinagaoxu@gmail.com>

Thanks,
Gavin

On Tue, Jul 28, 2026 at 5:04=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> These PHYs need a 25 MHz reference. On boards without a local crystal
> it is fed from the SoC and described as a clock on the PHY node. Get and
> enable it in probe, via a small helper called from both yt8521_probe and
> yt8531_probe, so the PHY is clocked before its registers are accessed.
> The clock is optional, so crystal-clocked boards are unaffected.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>
> Changes in v2:
> - Factor the clock enable into ytphy_get_and_enable_refclk() and call it
>   from yt8521_probe as well, so the YT8521 is covered too, not only the
>   YT8531. v1 only touched yt8531_probe.
> - Carried Andrew's Reviewed-by; the enable itself is unchanged, only
>   moved into the helper.
>
> v1: https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo=
.com/
>
> A second crystal-less RK3576 board with a YT8521 needs the same handling
> (see the RK3576 GMAC 25M refout thread [1]), so v2 covers both PHYs. This
> supersedes the withdrawn dwmac-rk MAC-side series. The DTS that consumes
> the clock (rk3576-armsom-cm5) goes to the rockchip tree separately; the
> clock is optional so this patch stands alone. The YT8531 path is tested
> on an ArmSoM CM5-IO (links at 1000 Mbit/s).
>
> [1] https://lore.kernel.org/all/20260727021048.3375444-1-attinagaoxu@gmai=
l.com/
>
>  drivers/net/phy/motorcomm.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 708491bc1..32eb5ce93 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -6,6 +6,7 @@
>   * Author: Frank <Frank.Sae@motor-comm.com>
>   */
>
> +#include <linux/clk.h>
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -1043,6 +1044,29 @@ static int yt8531_set_ds(struct phy_device *phydev=
)
>         return 0;
>  }
>
> +/**
> + * ytphy_get_and_enable_refclk() - get and enable the PHY reference cloc=
k
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * A crystal-less YT8521/YT8531 takes its 25 MHz reference from the SoC.=
 When
> + * that reference is described as a clock, enable it for the life of the
> + * device. It is optional, so crystal-clocked boards are unaffected.
> + *
> + * returns 0 or negative errno code
> + */
> +static int ytphy_get_and_enable_refclk(struct phy_device *phydev)
> +{
> +       struct device *dev =3D &phydev->mdio.dev;
> +       struct clk *clk;
> +
> +       clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk),
> +                                    "failed to get and enable the refere=
nce clock\n");
> +
> +       return 0;
> +}
> +
>  /**
>   * yt8521_probe() - read chip config then set suitable polling_mode
>   * @phydev: a pointer to a &struct phy_device
> @@ -1064,6 +1088,10 @@ static int yt8521_probe(struct phy_device *phydev)
>
>         phydev->priv =3D priv;
>
> +       ret =3D ytphy_get_and_enable_refclk(phydev);
> +       if (ret)
> +               return ret;
> +
>         chip_config =3D ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONF=
IG_REG);
>         if (chip_config < 0)
>                 return chip_config;
> @@ -1171,6 +1199,11 @@ static int yt8531_probe(struct phy_device *phydev)
>         struct device *dev =3D &phydev->mdio.dev;
>         u16 mask, val;
>         u32 freq;
> +       int ret;
> +
> +       ret =3D ytphy_get_and_enable_refclk(phydev);
> +       if (ret)
> +               return ret;
>
>         if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz=
", &freq))
>                 freq =3D YTPHY_DTS_OUTPUT_CLK_DIS;
> --
> 2.43.0
>
