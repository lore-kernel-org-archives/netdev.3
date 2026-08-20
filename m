Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6E3CF021
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257121; cv=pass; b=SVpyN7fxtbFuRoi8lhRawE6P6zfyUTnfzFZ+96Kp/dBc9TzPAzBiSeu37U2mfcZp4QKKE+5RQgu2IolvInLovBn1s/WDIKQ/Jd2w435w63bbdY6fBAuK+Bp+lgmB2tQvNSzPUmpV6kfZYDPujNXm+u/JUUgd3s9tzF23T+ZqNcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257121; c=relaxed/simple;
	bh=xoc8D01MpiWL5unCeL5WEMm2hUQN1RbSOoLqOs4HrPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhTqgpp7KXNxxPn+g9JA4/MjKOEKjLyX55/c6EUVqa3nQ5nf3338+5DkBmMxD5LAVkZG9BXly5NxvdxzVtjc0M1Ud8tL2qFMTOlFSQTaNHSKphPPJ90BMVFXRe85PWpYv8uycG69P6eJKS7l9FduzfxV6m/mcPuHOLO0KrnVT38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhG4X0gz; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhG4X0gz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so32607466b.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787257115; cv=none;
        d=google.com; s=arc-20260327;
        b=E4wkHqmO+Rl1bKIVuWoSvdD6h7ctI68d5iJvFnMm68l6jPIsYJgG1ZERaPYke4qgsp
         POergKkqBr3dxXo3f/MvILXl3flIPpFnxcxHNvwETTLoB3reMtHkjzm4Dq7vb56B7vwv
         saszHm2bsT6uUCJFT8ISOwqBXxyRpKZ+aBqKjSdjpM8e2A7Jp5nBHNlxgfGg6SU7q+U6
         7qQE15ntFakW5ItmKY3zQ10/3nxP1NJDEiujYfimXiovAl3faYLcFgsY1LLub24SOaD6
         ELFlH5o8RwmGcDfXiV/Ljc7VobOdyg7m+fvmR9For1XqAKbjOLurbkNhVmowLGpAY4m3
         gxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=juNQ1Ri6l95QwdEXhHnYdn7aFisOSy5EEtGzSyCI12U=;
        fh=JyB33mPIFgR/5hBmj16pJWm17wTiMM3uGj0BfvvAmog=;
        b=RmvVT5+jWuP8bHLVGz/645SlIi1hEAAMLfNI7/bpos4Fh8yADk3NvgrUog/z/heHLB
         UCn4QCAmJd485g8gnvO26Qb9LT3V480O6bKi0R1SYCbZ2DTWQ3sYI7Bi7FnZh7F2325x
         ipFtmLP9mxPK0yx9me1teRkBVwMp9DyukIIMAzlqtdP9IPZyvZaO3wMthceR0d3kKtZl
         Re4wxT5A4WeweWvneYjnoIIQW1Nx6JfN2MCGt08aPh1x3+JftJOWoxSEJruEVD+hoNWc
         5HbRjFkfNEfp34jPf8MJKpaZxWScGeI7fnW0+RplRI+Us/PP96hL28yUvQTb5DPxlCOZ
         fTEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787257115; x=1787861915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=juNQ1Ri6l95QwdEXhHnYdn7aFisOSy5EEtGzSyCI12U=;
        b=WhG4X0gzVSRIDAobdzVNcCm22a5Ecpma0HwV5Fss0xHEmQ/XtH4PaJFEir6t6l33eR
         AZHbU7/O5gChzh5Dz+Kl2Njr95wXxrRcNTmCxdXhSQX1QzGwjqrCfrI4u5GSgkLTOWG0
         dlYul2tjvo6+seFhKqArGahAEurW5zmJt+BKzVyFZ2JIUsMAKbPSBlSVcFcdleOaUlbV
         2wamgf6kPYrmu3O11bDKerpJamzTaNDHHirEwYHTj+sSTxBEHsYWdn7JkwaPA5aNwE6s
         mZcw/Mq7v+XLySIMNmw6O6xjE/K9+uOR6Ph1PA7jrtrrvSytbTWOJxTkP+IdLoOvwS/n
         Uivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787257115; x=1787861915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juNQ1Ri6l95QwdEXhHnYdn7aFisOSy5EEtGzSyCI12U=;
        b=qvd2LzFYYLOrp/8YwyIEFEUWYpLLyvBDHCAkAdfNitkmrj2VVqnA5gDw/CnCIyk4u8
         IRQgUZ4VN2Yjx8i/a2Hr1ED6T3+odcHMrTjV5wg5LzhvcTybzntk2WvLSucWv1vr4GES
         rOpMgtaP49RYDTvzsgx59GxaNtL+stWuZvs3XmYf1nPVnJpJedYNNWxPf0g1EXlTRXgc
         jxf0doOVhfTF56MnCDMFjv4c1wYVKtiCjzvwQnMof6iJzw7ja+quQ5wUGrHQysIHqmEw
         qDlnLbJEB0/fxfXyyH1ixo3SJSViRcCcwRSm4SrIS/TdlsQ30Xumw37SfRVGu0Sa6RJh
         fOng==
X-Gm-Message-State: AOJu0YwjyBSYd5evMbmdr+qOTY7YDc3TZ7kuRExWVVsg4VXLfaE9Pwez
	1iU6A2QfhD7I16G7+1i7206Duj+q8nfYkWLy8gtZQpJ2X0/NU3UIE8XEdTLRQ24ULy/fl1JF4od
	E0X2Y7SKq45ogZgD1juc7OhDTouTb/w==
X-Gm-Gg: AR+sD133MrBXd2Fhp/sBR8gXInnOvHT254Xo0gAQSqGLwVqo3VHx0i6cAb3xCrL7v0Q
	Yb54ViyaptIMmb5LhNjsBrjlRqhCpY1DLL2tEFZdp/CrUvZZqA99FtQyY8cKOikt+H+JUyt+NwD
	xLhkxXjb828/gUoPaJtHrxEW6M3iF2GrmZsr2kvfm6Qt7pw1/bu/tWu9B+LwO3hd/r42Uw4E3oR
	PrNz8ybV1c8MibIYMd6pYANMcD1EInpN/1eN2Y1iXyjMEzrbvW80fzVEakZL+pjyrSxIICDFA/o
	aAfDnFXYUngAcu+hmmxnp2MoHWnHZfPxxlF84zkh1Z6PeNnCeXX5/a5uc7LxNQ==
X-Received: by 2002:a17:906:ee89:b0:c20:f95c:9088 with SMTP id
 a640c23a62f3a-c246a30c3b5mr104918666b.4.1787257114733; Thu, 20 Aug 2026
 13:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com> <aoSnqurLLgdVT_Eu@makrotopia.org>
In-Reply-To: <aoSnqurLLgdVT_Eu@makrotopia.org>
From: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Date: Thu, 20 Aug 2026 23:18:23 +0300
X-Gm-Features: AcwNN1UY78trrCBEnBsV4RrWx-VvGxpQcnmILGMnFCzTNSxNa9AqTH-okMtaf4k
Message-ID: <CADDoYm63JMq=5CyNvqkTo65BgS927iURKMmhvhD=B-ytqq3Ygg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: mt7530: do not advertise EEE on MT7621 switch
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, dqfext@gmail.com, 
	sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Hi Daniel,

Thanks for the review.

> Do we know what is broken here? MAC or PHY? If it is the PHY which is
> broken, it would be better to put the workaround into the PHY driver.

It is the PHY that is broken -- the MT7530 internal GE PHY (PHY ID
0x03a29412, driven by mediatek-ge). Landen Chao (MediaTek, 2021) puts the
root cause there: "EEE of the 10-year-old MT7530 internal gephy has many
IOT problems, so it is recommended to disable its EEE."

That would point to the PHY driver as the natural home, but I think the
DSA side is actually the right place, and af3b4b0e59de -- the commit this
patch fixes -- is itself the evidence: it removed the early EEE disable
from mtk_gephy_config_init() on the rationale that the disable done there
"is somehow enabled afterwards", i.e. a PHY-driver-side disable does not
stick (something re-enables EEE advertisement after config_init). What
does stick is the disable done earlier in the DSA setup path -- which is
why MT7531 does it in mt7531_setup() and why af3b4b0e59de considered the
mtk-ge disable redundant for MT7531. The catch is that mt7530_setup()
never had that loop, so MT7621 (and MT7530) lost their only effective
early disable when af3b4b0e59de dropped the mtk-ge one. Putting the
disable back into the PHY driver would reintroduce the "gets re-enabled
afterwards" problem af3b4b0e59de removed it for. So I'd keep it on the
DSA side

> I'd recommend disabling EEE advertisement on MT7621 and MT7530;
> Hence I'd suggest to extend 'struct mt753x_info' with a 'broken_eee'
> bool instead of maintaining an in-code list of EEE-broken silicon IDs.

Agreed on both. ID_MT7530 (the dedicated MT7530 IC, e.g. BananaPi R2)
uses the same mt7530_setup() and the same internal GE PHY, so it should
be covered too. I have prepared  v2 that adds a broken_eee bool to
struct mt753x_info and sets it for ID_MT7621 and ID_MT7530, gating the
MDIO_AN_EEE_ADV clear loop on priv->info->broken_eee instead of the
open-coded ID check.

v2 follows as a fresh thread with a lore link back to v1.

Regarding older Trendnet/Econet SoCs sharing the lineage: I don't have
that hardware, so I'd rather not guess the flag makes it trivial to
extend later if someone with access can confirm

=D0=B2=D1=82, 18 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 21:43, Dan=
iel Golle <daniel@makrotopia.org>:
>
> Hi,
>
> On Tue, Aug 18, 2026 at 09:28:29PM +0300, Vladislav Karmanov wrote:
> > There are hardware defects in the MT7621 (MT7530) EEE support: with EEE
> > advertised, some link partners cannot establish a stable connection.
> > Notably, on a 2-pair (4-wire) cable where both ends advertise gigabit,
> > 1000BASE-T training cannot succeed, and instead of falling back to
> > 100 Mbps the port flaps in a loop and no link/DHCP lease is obtained.
> > This is confined to the WAN / phylib bring-up path; the DSA/LAN side on
> > the same device is unaffected.
> >
> > The MT7530 internal GE PHY advertises EEE by hardware default. The
> > eee-broken-100tx / eee-broken-1000t device-tree properties only take
> > effect during the late PHY config_init path, which is too late for thes=
e
> > link partners: they negotiate EEE before the OS disables it and then
> > fail to fall back cleanly.
> >
> > Commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
> > advertisement") removed the early EEE-advertisement disable from
> > mtk_gephy_config_init(), on the rationale that "disabling EEE
> > advertisement before the PHY driver initialises keeps it off", i.e. tha=
t
> > the DSA subdriver already performs that early disable. That rationale
> > holds for MT7531, whose mt7531_setup() clears MDIO_AN_EEE_ADV on each
> > switch PHY -- but it does not hold for MT7621, whose mt7530_setup()
> > never had such a loop. So af3b4b0e59de removed the only early EEE
> > disable that covered MT7621, reintroducing the flapping on MT7621-based
> > boards (regression reported on ramips/mt7621).
> >
> > MediaTek's own recommendation (Landen Chao, 2021) confirms the hardware
> > is the root cause: "EEE of the 10-year-old MT7530 internal gephy has ma=
ny
> > IOT problems, so it is recommended to disable its EEE."
> > [...]
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> > @@ -2518,6 +2518,15 @@
> >       if ((val & MT7530_XTAL_MASK) =3D=3D MT7530_XTAL_40MHZ)
> >               mt7530_pll_setup(priv);
> >
> > +     if (priv->id =3D=3D ID_MT7621) {
>
> It'd be very surprising if this limitation doesn't also apply for the
> nearly identical decicated MT7530 IC (found eg. on BananaPi R2).
>
> I'd recommend disabling EEE advertisement on MT7621 and MT7530; and I
> suspect that some of the older Trendnet/Econet SoCs which share common
> linage with the MediaTek's Ethernet switch and PHY designs could also
> be affected.
>
> Hence I'd suggest to extend 'struct mt753x_info' with a 'broken_eee'
> bool instead of maintining an in-code list of EEE-broken silicon IDs.
>
> > +             /* Disable EEE advertisement on the switch PHYs. */
> > +             for (i =3D MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
> > +                  i < MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr) + MT75=
30_NUM_PHYS;
> > +                  i++) {
> > +                     mt7530_phy_write_c45(priv, i, MDIO_MMD_AN, MDIO_A=
N_EEE_ADV, 0);
> > +             }
> > +     }
> > +
>
