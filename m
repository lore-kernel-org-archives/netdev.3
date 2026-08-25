Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C22EEE90
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787627669; cv=pass; b=syXIWxEm9h1vmtLajU9T1WpNa6J6XOk5lOKYmI1P34HpKiqg1pi+tvazXte1EYGKUunozysyXkgi76gitm3kLptVFb0jYkuPWPTi5dYDsVY/DnoiEjtbT1OfhhXYIzyMCU8Dtf7/NKrlAkTQ0IAUgTWMGXH4Tl07FL7PQo6ByQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787627669; c=relaxed/simple;
	bh=dRs+t2C5DM0FBnIBiCSm+EGEkYKjoAyRCd6uSWWyGYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlCZDiuptSP3Qfz7WIdUHZP+p2Y7ugptxe2YuvEF9dzU8C6mQmc1jDpZUOMZq0cHVmr4xvRHus+sFnHWG8Ghz30aunngha5sthqkQ9HI6sxCLMll6e4A9rzFsyQA8aGAgu6DVLvmqwD6aDzIObCwH5DZYqYKlfKooGyqAdyG8j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNnlL7Ou; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNnlL7Ou"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so42192765ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 20:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787627666; cv=none;
        d=google.com; s=arc-20260327;
        b=GIfINHyxyGcs+yHv+E4ml+9e2yu7l/+M/I8qyzwGXetdluV02Sq0JrVDwQZ3Kcj1xO
         c6pdm49ymBPmZUWNpAYKee0VtN1BDHATwJywq4ugWdpQF5HeKXp6Bgk8D0ycGiMFSRID
         qJKHUwDT+eWusmyVSixSkrBBJDRwC2uSxoOMl1ix5Bp2UnmsC2tS1Awnd8+BTlIJ4e/2
         rh6bMHR8JVAVuHK6NYPTZ/XYu2pEFNXoVlcI6AVMy8g+3RyvvnEgiwSp14JXnfRgNRDd
         CxdwCR4XQijMYyKeaVi3+Y5KAARVAmAq2FqgbP9CV8osciOO7xlBghZZCedK1hzENhp1
         W0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        fh=V+KsS58puCqvEDMciHL6tS5dK8wr8GB5Cw7OQPCPUcc=;
        b=pc1Bf7FXgm6U5en2GsvNU2Eqm9p1bkhjSF/Pb0zOSuXI5cLCiKeslFTlyvrP2LLir3
         OJ22qf+Vw+QdhqGFpbkTPRu+ElmMotAhwq6dAdOI/YS28jcDya1+2hwu45SXfuFxrcF9
         2xZwy7swVSAcpo7gm5TGfbbqtN2Y2gNYOc15RgTlE2Nvun3IZmhBuZEa26B39cOowHO3
         9JPYJPi+RWK9GQ0uyP6f1V5NL5UuQWPNXnlyqlOw7jiEhBcklVZj5b11v/t3FbxmaxDb
         gcOC28GKQboUr1mOG6tLPFaqHlT/o6040gHVBo+GPSuM+I0b9iJlHPLiQFw5xCJHL1j8
         +XPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787627666; x=1788232466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        b=KNnlL7Ouu1DiXnnwxJ+1HRr6sKhAbNyYkQXQEYPQ1Cpc4Apuz4cVc6X2mLXL3t+6fa
         fP/JyJSNZREY2T18afSkHf2DzOEMO/NrwhKcisH7b8PBLG6PkTHN8WQv9fMuN6mGNirg
         r3NuYEJqKKJevi2hNXMPOMqtGi5K0DrjEZvkMSe6CWoHXDxsKDkcGckYSaendrM/kBwI
         WO1B3SYJYIjCq31ckTgIv/uhFB6e/ISiediw4pfpj6E5VUsCUBBNOEEF2g7DmtiKr1w7
         ZWS4dRuPkhoOmMZGzzdZFc477epNOP0gs+wGE+9l4voQy8QA9aKTllFkABDrkIRhF2Zv
         1vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787627666; x=1788232466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        b=kw+/VwGaakAgXD+8xOeDT2Mvv3qRVxcZ2R7uyIgbJHgg+xmfRrDqlEUCBMd/gFnECz
         hlGBlXNJHy56TC9TdIHJq5QSQyntbqtH3e+ahezbsP2L2nIU3zY+Tvsb3OdA4D9033A/
         SlmlG3v4QP/FL+EQycqPHg5PAZUIu3bLsqKbBvMjV8WgK8LXnWxVVQe7NIv3vAz3BBsy
         OAVrKvkzR1xAJ6OU79Nm1FVzg6Yqji2cR8NtcymU6RFR4UZNj0V3gAggCYXBcLTa/+sR
         OZhVC0YT8rZq4SLd0CMXhCqQ+KYK8wAumigi8Kor+xOVIaugTa4M4akzgYqlacy4LERm
         BvJQ==
X-Gm-Message-State: AFuF++kZc503eTD3LI6SnXhvfVkwE3D2s0DZT9diU4tf2eHuz4HSmST3
	aHTzlPFE4jzykz4HqYMBBGhqqcf4WXg3QsK+XsPCYI6v+Cpamb2SG86HMqGEeVB5mXYyaLVynqE
	iGXmkxyjTqqLcWqqdGuEpTROtTUPSu7Y=
X-Gm-Gg: AR+sD13tqgHjS4rxxkhOaXSSLJzYFSruLql7qNMI6bTVYQEjvyqd0KHW56MKSA+4arB
	kMrmekxw3GUnNsUo+tup/b8/bIcV42oAP8v3BxqqD5WzHxbNrm3ybUvd8Wgrwabc84HHq9SiLTu
	1SKZWVJjDSmDizG9lX8rY0jCZiFTBdsBjrl3a0MTDqEtyQW4Aw5MuM7c8gsO1MSO6Kjc43YGddS
	OolZsNWG4U2Ev/DtuRGGA7C5FuzpJ7pb+9hr605DawygEthMpDVDn40XNcbMKnb7nYPAcygtGqj
	bwSgXFFHn7OXhgHIHmW1NssKliIXNhuLozivIGWmjMgs9EPGyEv4FtZQmnQC
X-Received: by 2002:a17:903:a90:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2d670b60ceemr444455745ad.2.1787627666097; Mon, 24 Aug 2026
 20:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820141034.1400439-1-xuziyougm@gmail.com> <20260824185043.2701718-1-kuba@kernel.org>
In-Reply-To: <20260824185043.2701718-1-kuba@kernel.org>
From: js node <xuziyougm@gmail.com>
Date: Tue, 25 Aug 2026 11:14:13 +0800
X-Gm-Features: AcwNN1VxbJzVE2V05L28ezCK6b_JXEDxc0VipP-5b32B7Wmg-aKUKM5V_yzkGqs
Message-ID: <CAF2gcSXK6H76A5Z6-k-D04VaCR4QXNiWLmbQmcCBpsW=L+Hwyw@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: air_en8811h: restore LED GPIO output after
 MCU restart
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ericwouds@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

I don't have AN8811HB hardware, so I can't confirm whether the MCU
restart clears AN8811HB_GPIO_OUTPUT in the same way.

Looking at the register layout, I agree it is very likely affected.
However, I'd prefer to keep this patch scoped to EN8811H where the
fix is verified, rather than extend it to AN8811HB based on
speculation.

If someone with AN8811HB hardware can confirm, a follow-up patch
adding the same restore to an8811hb_config_init() would make sense.


Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 02:50=E5=86=99=E9=81=93=EF=BC=9A
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Verified. Report follows.
>
> commit 90353ad40d9c49a8f67a9cf009916549d394f63d
> Author: Ziyou Xu <xuziyougm@gmail.com>
>
> net: phy: air_en8811h: restore LED GPIO output after MCU restart
>
> The LED GPIO3/4/5 output-enable write is moved out of en8811h_probe() and
> into en8811h_config_init(), just before air_leds_init(), so the pads are
> re-enabled after every MD32 restart.
>
> > diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811=
h.c
> > index edd49c193e476..fbd87fc712bfb 100644
> > --- a/drivers/net/phy/air_en8811h.c
> > +++ b/drivers/net/phy/air_en8811h.c
>
> [ ... ]
>
> > @@ -1317,6 +1310,16 @@ static int en8811h_config_init(struct phy_device=
 *phydev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /*
> > +      * Restarting MD32 clears the GPIO3/4/5 output enable bits. Resto=
re
> > +      * them after every restart, before enabling the corresponding LE=
Ds.
> > +      */
> > +     ret =3D air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
> > +                                       EN8811H_GPIO_OUTPUT_345,
> > +                                       EN8811H_GPIO_OUTPUT_345);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but should the sibling AN8811H=
B
> path in the same file get the same treatment?
>
> AN8811HB_GPIO_OUTPUT_345 is written in exactly one place, an8811hb_probe(=
):
>
>         /* Configure led gpio pins as output */
>         ret =3D air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>                                           AN8811HB_GPIO_OUTPUT_345,
>                                           AN8811HB_GPIO_OUTPUT_345);
>
> an8811hb_config_init() then restarts the MCU on every call after the firs=
t
> and goes straight to the LEDs without touching that register:
>
>         if (priv->mcu_needs_restart) {
>                 ret =3D en8811h_restart_mcu(phydev);
>                 ...
>         }
>         ret =3D an8811hb_config_serdes_polarity(phydev);
>         ...
>         ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
>                             AIR_LED_MODE_USER_DEFINE);
>
> For AN8811HB, en8811h_restart_mcu() does a superset of the EN8811H
> sequence:
>
>         if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
>                 ret =3D an8811hb_mcu_assert(phydev);
>                 ...
>                 ret =3D an8811hb_mcu_deassert(phydev);
>                 ...
>         }
>         ret =3D air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>                                          EN8811H_FW_CTRL_1_START);
>
> If the premise stated in the new comment ("Restarting MD32 clears the
> GPIO3/4/5 output enable bits") holds for this device family, do the
> AN8811HB LEDs also go dark on the second and later .config_init() call
> (ifdown/ifup, or a repeated phy_init_hw())?
>
> After this patch the two peer paths in the file disagree: en8811h_config_=
init()
> restores the pad output-enable bits on every restart, while
> an8811hb_config_init() still assumes they survive it.
>
> Would it make sense to place the restore in the shared en8811h_restart_mc=
u()
> or air_leds_init() path so both models are covered, or duplicate it in
> an8811hb_config_init()? If AN8811HB is genuinely unaffected, could the co=
mmit
> message say why?
>
> Note this concern is based on the register definitions rather than measur=
ed
> hardware behaviour: AN8811HB_GPIO_OUTPUT is the same 0xcf8b8 offset withi=
n
> the AN8811HB PBUS window with an identical BIT(3) | BIT(4) | BIT(5) mask,=
 and
> commit 6b9c9def95cb ("net: phy: air_en8811h: Introduce resume/suspend and
> clk_restore_context...") notes that PHY reinitialisation reverts chip-con=
fig
> registers such as CKO to their initial values.
>
> >       ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> >                           AIR_LED_MODE_USER_DEFINE);
> >       if (ret < 0) {
> --
> pw-bot: cr
