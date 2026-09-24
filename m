Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6813DA7D9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245784; cv=pass; b=GNkNtGe9n2zGcj8RUeoY9nKCfG0oXT3hQ1gftKTtGDwaqvmUHgPqo3y3NOB/D7eRnrtQZQOiDXMTKX3DJE/hjBMKGg2iRg8UxCJlUKb1GU/Gla7PvnlmVgmri8yrUIRQpWRoUzA2+bBP/Ef6pYJcZKfLutf1j12ZX1sEY4Dysdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245784; c=relaxed/simple;
	bh=G74mpPleZBdV6sts4IWt44dv6esQXRZkYrm8knhqpvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFh9rXUPzjJFil76/UuRCbQqeeUCy8P5YmsHWIeTDzGtKN3lZc3GrP/1T/mbzuKHhUeIXSqeA2dmgECUNZT/QUINZSWB3M5gRqoOafS7Ly4KN6TkTTXbGVdsU4Z6zl4OzIIXcNaXHh86CmcPf6edDAL9bxha5juxM2YTfPCBiWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfrkL9hS; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfrkL9hS"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7fcb425fb68so1243966a34.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790245782; cv=none;
        d=google.com; s=arc-20260327;
        b=XB/zFJgRMg/zpalOPpT5AAzNFqKJs2IouqKvODntxpctI9sBv849p3C0UT7sYO26/T
         m94gyfymXrTHs3husZWh0av6v1ijME/X1DDHkZ5Ke/bsbGYO1aLd13MjDPLdnuUr+HJj
         uDI0hMWMwA8Ow2lTqzn0lHN3FJaBUC5+x9L9S4bC5VW+gJroyw7koAr/1d7OYWgY8exw
         L3O+dTZJxgT9GdihD5S+cMBj/HUcmkXyPX1u6TDFMPUK0BP6Xewabm1FEG2IGvn2wL80
         qXUZPvVhTi6NEnIj/RE8LKz2Or5G24rAYhnhE+b5dxcybbbQVwvpzmUybTsCdP0SFXsI
         CwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Za0dWSit03gXTMmeVZPbk2nVTp5Bf9hP0g9GqMt8bYk=;
        fh=NMYx32nrC/lXMVy537AQ1TIGKoqmJ5o/AEiOPVrkO0w=;
        b=Kiwz+4P2Yc8pgxeIl/fvQXB7U2x7DXVzkvuV6lGnu32QlPTFIwFE1uo3mtFqpuJ72O
         V71/PmIkxLMQN5HSfi4NmZnwm0pwX3BnuzWvUmoq1aGjfwrvca/S/lgWb7qKc72rrDIV
         0KI3ZGGivEHO1yQIgXaShBkh//4UvJNM9PIMRxLVW0BlqBlU+hXTeFvq0lBhNFlcHSHU
         gxCQX0NM/eAV4Cvd1MwKljZnvMUliNjpcnMKjEGqhftBcEaqvZK8+s4Va3/JvmG3ka7x
         +ZcdJhdP7QLH6cVIYG0/yWDpcvVmw4N4yI9rhUTIEYg0eGANubVyt72qzcSsVvw6GFKi
         2HWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790245782; x=1790850582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Za0dWSit03gXTMmeVZPbk2nVTp5Bf9hP0g9GqMt8bYk=;
        b=xfrkL9hSE9eu8oOoWZKYmdnYILJA8AoDP/KsJCwxKkuyrXVxsAJ2U3RkyR4Pr/VELe
         XM8Q1T2ENKkCBmJJc+14lXogUl+Y5bzO4JSobm9l7gbEPcqXuno4GhimSpdpqPKCcEKF
         reL8GU75MYUPLD8hjQuwj4aFt829teoZdzdRuM9HEl4bNRGU/N9fbLAFnPJ8O1aE3b29
         zCdH2FVU9gTV23aQC5TN+6Ys0Dths0fXCDoAbOI0sDO0QPJTjvZVvgs9naJhl2Shg7Qt
         4oXY8zPGBG3heIaLucnKQoX/zwD6lLzaHhWkfnxuNTLwAdOWyQPNu35WKulleynVXcH/
         1I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245782; x=1790850582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Za0dWSit03gXTMmeVZPbk2nVTp5Bf9hP0g9GqMt8bYk=;
        b=FD4wI5jy3dk9ulwwN/dzkcnN43kNI47jD8+tf6g92kUN8PjXfOxUUIpGtZl3p9PNXu
         4kJ1/NgDv0Tec9NXNpjVLVjalivnVN+ii4SQcgCJs/YMgSzQxyUE7M5dq4yqrl5AC9to
         9gqa4AdTrx6N2r/YFVSj1wphpnC/kWTCnq3BqxvuYCrUmO5UCMrbeYk5WwzaNzG0AhA7
         lDWKwR64MXlQKBnkTAV5G8Z+tAekSxqrdEQlBuk0H5z3R1cb5oBr+2PeRFRY5zQ/B8YJ
         awNngGddki2qFb7PzZ/eFdkhv5oMqtRp3zyDEJPhbTPoQ9afA2I7HwY/mMkfI5zo5jnn
         Dw8w==
X-Forwarded-Encrypted: i=1; AKwUvBxuuyv0YKmHX5MNW7+RFu2XpsVlaI2P2SCD6OzlHYArF9m0oG5MMqIqz6nA4OhqsdmLAyoGjms=@vger.kernel.org
X-Gm-Message-State: AFuF++n8Si645TkA9pVYqq9gQHYfDTy5cTslRgk56KOVDKtc+iVSh2It
	jJ+tKnOnd7dkGE5WEo9l8IwAmd7jVU6fWebCtmK2XV0jbG5X8qUUpjUsLlXPsyFRw3UIi7UN2KJ
	PsFDRdUIzTpYhO0xLY9rpPoQ8S//wKyEP0+dYdeKJrg==
X-Gm-Gg: AYBFou1eYWTehNxp8j0oAi40gzTnQcHl6X7w86DI4XkGBwVsE6HDsWJgmV05hxpePAA
	hcW1AOqv62Hz7MTr8msqEYkz9KOddOtYUracVr0DcnyUnboOH/K5I7/ErdHtfHmV+2v+9PrVzto
	3HtSfSzqa4H4zL6FEZuAD3GR7yU8REaXw04F102QwOxkuQH1Hd23S+J0oA/SYYIXMPt8sA5UzQS
	HBcQmXyjB0cB6CVQr5Wz+HCXJNsMMU9l4DXFUV97mHr2ju91CA8E+4ZybuKttp2r82n8kE/QYpr
	xFW5lklXf/i86PN7XiQKe+veOd5rKq6FKXAMl/P6dgFvm9sOAAwhAWqh6cyqsTFz+LUeY5Ye+wG
	ZrbXJpO+uMCQxr7ep8pWFklEkp5r3CG+Pa8fPtdlrQIWLbX//4awKwgA=
X-Received: by 2002:a05:6830:6d49:b0:814:aa56:6e89 with SMTP id
 46e09a7af769-8177e2c4c2bmr2369455a34.0.1790245781726; Thu, 24 Sep 2026
 03:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org> <179021686449.2160803.8908232708246171616@kernel.org>
In-Reply-To: <179021686449.2160803.8908232708246171616@kernel.org>
From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Date: Thu, 24 Sep 2026 12:29:30 +0200
X-Gm-Features: AclHuK_aOxC3J5_iCvwfOE00WCFt-0d0n6YkXEksYRBvq7Sj8b1cGea10v1asag
Message-ID: <CAK8z29U=KG0cZKBCeRcyX7BFMFwP=nhnbkN_O3HrCxJ2NXQZvg@mail.gmail.com>
Subject: Re: [PATCH] net: phy: mxl-gpy: add 2.5G for MXL68211C
To: netdev-bot+sashiko@kernel.org
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 24 Sept 2026 at 04:27, <netdev-bot+sashiko@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Missing `Fixes:` tag =E2=80=94 a user-visible bug fix is submi=
tted as
>   a net-next feature.

My guess would be that we can add this, I suspect that stable would pick up
this patch automatically  either way.

> - [Low] Commit message names the wrong part number: the subject ("net:
>   phy: mxl-gpy: add 2.5G for MXL68211C") and the body sentence ("the=E2=
=80=A6

I'll fix the typos in a v2.

>
> --
>
> net: phy: mxl-gpy: add 2.5G for MXL68211C
>
> This switches the MxL86211C phy_driver entry from gpy_config_init() to
> gpy21x_config_init(), so that PHY_INTERFACE_MODE_2500BASEX and
> PHY_INTERFACE_MODE_SGMII get advertised in phydev->possible_interfaces.
> The changelog reports that 2.5G then negotiates against a Mikrotik
> CRS310-G+2S+IN.
>
> > net: phy: mxl-gpy: add 2.5G for MXL68211C
>
> [Severity: Low]
> The subject says "MXL68211C", and the body repeats it in "the 2.5G speed
> indication is the same between GPY211 & MXL68211C", while the first body
> sentence and the code use MXL86211C.
>
> The driver only knows the latter spelling:
>
> drivers/net/phy/mxl-gpy.c:
>         #define PHY_ID_MXL86211C        0xC1335400
>         ...
>                 .name           =3D "Maxlinear Ethernet MxL86211C",
>
> Could the digits be un-transposed in the subject and in that sentence on =
a
> resend?
>
> > diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> > index 0da2d4e9d8548..089a1a9e5bc61 100644
> > --- a/drivers/net/phy/mxl-gpy.c
> > +++ b/drivers/net/phy/mxl-gpy.c
> > @@ -1405,7 +1405,7 @@ static struct phy_driver gpy_drivers[] =3D {
> >               PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
> >               .name           =3D "Maxlinear Ethernet MxL86211C",
> >               .get_features   =3D genphy_c45_pma_read_abilities,
> > -             .config_init    =3D gpy_config_init,
> > +             .config_init    =3D gpy21x_config_init,
>
> [Severity: Medium]
> Should this carry a Fixes: tag rather than going in as a feature?
>
> The only functional delta is the possible_interfaces advertisement:
>
> drivers/net/phy/mxl-gpy.c:
>         static int gpy21x_config_init(struct phy_device *phydev)
>         {
>                 __set_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_=
interfaces);
>                 __set_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_inte=
rfaces);
>
>                 return gpy_config_init(phydev);
>         }
>
> git blame shows the MxL86211C entry, including .config_init =3D
> gpy_config_init, came in with:
>
> 9d844da693d6d0 ("net: phy: mxl-gpy: add support for MxL86211C")
>
> and every other GPY21x entry (GPY211B/C, GPY212B/C, GPY215B/C) already us=
es
> gpy21x_config_init. Together with the changelog note that 2.5G only
> negotiates "with this change", that reads like the original entry was
> incomplete rather than an intentional 1G restriction.
>
> Would it make sense to add:
>
>         Fixes: 9d844da693d6 ("net: phy: mxl-gpy: add support for MxL86211=
C")
>
> so that boards with this PHY, which are limited to 1G on released kernels=
,
> get the fix through stable?
>
> >               .probe          =3D gpy_probe,
> >               .inband_caps    =3D gpy_inband_caps,
> >               .config_inband  =3D gpy_config_inband,
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f%40linaro.org

pw-bot: cr
