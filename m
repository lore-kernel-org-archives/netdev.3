Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D27396D28
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470064; cv=pass; b=UZsY+Lbo/eZzjawzQo2iu9DWW/66pv8D2Iu9djy4XLgM/eocaClsN6cDkwXWoUaknctcLXOf7BRZtocZGwQko4a1yBLZuynmmr5Tx02QrliKvxpCEJytsk5zGpQ48M/6ByYh4c/1BpwCryxRURffvdFG6eGtyl/v47gvC9YoRuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470064; c=relaxed/simple;
	bh=ShfwVZywbbRnyGcVfJBs5EymL414dash4IifQFgqxPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhRhiCEL/t5/RxoQJgzn7Bu8vP8uK65e/LBWVellT+mnUFoG2ODy8mf5PsOdQwRmgOJbFvvGabXWulhBCvmCr+SnbuKnoyuxqi78XGwdMaXgS7+3NT1wCDJ8HXElZtJSKueevrTbtBfhFNKE9G9QOWe9Id5KJpS6y9DpJRI6/1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI9bCfkD; arc=pass smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI9bCfkD"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c254403ada6so199004466b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470061; cv=none;
        d=google.com; s=arc-20260327;
        b=FJkObLXxl8noTXQtX4Ue6eVTg7E1D9p6HxOgSyWfe2yQYvrKKPEUBGDpsrJ/Ry42FB
         lGgxbmmdlUhxWB2BArBuAW66mH1Sz2ETwdZZ7hbecJDCEccdsjgyQk45BS/ah7aHP0t9
         wIXukIHb8uya//jGt2zI7mJg7gx5CB5Y8KmxgNx0NNPSnRwFQydS8yZ4Aa9SXqCvF1pP
         VeIhgbiZZCX3unIuoVyvlYpHTV76waXQQVFP0IsrN7dhFIcHNd8I4rF7ufAohox4Nkxq
         au/YOSiZOd0GTtTCwuruFnlwoUaev8MgfRfWG5ZvqxYCz4i7+M0LuLte5p/KxVT8wkwR
         GNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R3NdES2zmmnH5dOJ3l6qlbKwygMQlPwsvVMB1hGOtHs=;
        fh=DQrmtVdMzicdwDsmVgXurT114j+nNnurvgW8lzXQyPs=;
        b=bpp43rEBsad7E1JgRtunXLGvzf5Wy7xo3XeU+75DjCtbDMny9AEHiLL86AGmTAPNB4
         5oxPMPwyxoV/qrfFQhRjdeJKrTGjwQ8PPrqBP9b1iQLAPtIL7Jc3i+ApKl9eFXqpI4iG
         bTamOipDzuZ4AQKw2yWV3G/OFzZxOfaEJXRBvvJBbh/KhEQASt/q7kBOyEXuy7YlYwML
         tZUiKFUfyg6w3+zfm7gLMb2YXkZ4tMeJJpEkLGwBN+F4TcbSnx2AOkEYP9M0pGzWUS9F
         quilw8te2CjkETQ5DH//AQadgKaWR8G152yb5V+jYAyKKjIwOYYZUto8X7uRsrqOOC+b
         j2ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470061; x=1790074861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R3NdES2zmmnH5dOJ3l6qlbKwygMQlPwsvVMB1hGOtHs=;
        b=XI9bCfkDiQFA+b8eqU5hSi2ZqmBaWk82IJcjo3xmcSztkfbXMDyfTEE98n86ynkc2k
         NsQQvvfXmHpQemOn5Fk56Wa1Jfz8barI1QWhLpq1NWVaHkLXnLPF2eaXlza6OywsErxM
         vko4HaXDO52f7SPQWCR3mZA0odjEEAN71K/1QNWb/Zm/DvFIWoEWLHS9tuMMuEKYRfyq
         2e1mKtDpnUaOX1/COe5EK6i9lHw/Qt4vK307CMQD86eSMxOye4a4XgmdHwu0378ItIdq
         hbzW13xqmOUqE/mkWjpR7r+mjoUFwpCPAphwPXG0D5pCpI97kH1284nqp2gZphjCtJd6
         YhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470061; x=1790074861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3NdES2zmmnH5dOJ3l6qlbKwygMQlPwsvVMB1hGOtHs=;
        b=V74HHJ7RpHcSkniGgiX4ZiBeCDOIuiQguztFrTpRff2VdxYG9dx3o94AiYhBA4v9fZ
         2XFyShjpE3UM4ej7lIMGUTa6FAZ9hMk2Sqn+9u8zBWKsshyc/LTgkJ0cKYmFrBdYwRFO
         b6p+0D1oA4NSNb4pIgBPn8yhxAR+ua7qEY2r1iMNsmpF3az0k2PAWipooQm2/l2ml/E6
         f/Q2NKxcz4ZCG2vPDtDqcjfetYBagRWXpvq6W2lLtPR58j6EoUrb63/6rX+hbNSCHgBo
         RMpOUDgkcY52fpvMgJ4uY+GBLoWmEWHrLKZvySWDpytywKQ1iWgS6hB39AWrNnF1KTBW
         Ci0w==
X-Forwarded-Encrypted: i=1; AKwUvBwzLJixkQA0k518JwA4HDC0YfCjkD0pZypAgl/5MC3VD2CwqDFnbxU4EG/f5vbuf56BnNnfrtA=@vger.kernel.org
X-Gm-Message-State: AFuF++lj1dsYHrQi/kkQ28oZcpUziBo78O2N902G3ZgpRoNL1pbhH9YK
	npK9UUbphCLz3xmkQXBHBZGsaNeqIMMbRKCcfswneeCQ60pmNFexCc2DOkpwOkk3zwcA68ie3Tj
	c9fZ7B2EfmZfqdCqbbxMpWnfPwK0Vn8Y=
X-Gm-Gg: AYBFou18rY7v4fG/VvbAIaQsIB8EUsSA/VZdQ6lBvAtevr2nwBjc9IsfjUzIkdFh1NQ
	cU7dPdn26OaISGHjt0+ZTPuUwWMoMJSYPwRpVyNAsYwSuI4MQ7Vuv41Iyq2BFDKWt5iF3iy8Gu/
	BpqTaJWitHWQg0s2K4W+xLjQm0OZUrrDcZTBPR5jJrcleS5bnwwQ4uHmCMCk7xd/WiQeNUGt4LL
	rRgEi64clm7k2pepT/5ZmU9bGd+LWbq9lO+7o3u8kRsRkR2FeLt4lJlSS7MqSEEiPX1VCSWMhTW
	WkW6zJtw1RH3w5Rwh7I9ZxzyMbM6PFdf/vHHgLJ87gkCJcLjFm+ccGP/wA==
X-Received: by 2002:a17:907:8b91:b0:c29:52dd:317b with SMTP id
 a640c23a62f3a-c29b86f5e2emr383389466b.29.1789470060405; Tue, 15 Sep 2026
 04:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185849.907479-7-coiaprant@gmail.com> <178941748560.22033.7667125492368880786@kernel.org>
In-Reply-To: <178941748560.22033.7667125492368880786@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 15 Sep 2026 19:00:48 +0800
X-Gm-Features: AcwNN1WuimdbnTvudxI3nS0nRX30kh2n0AVc8NeUW8GvUoUT_30BX46WRVzlpTk
Message-ID: <CALj3r0isnSmOPyX_viMYw2w=5K2HxyyuWaC+v8137WnStJxiNg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/11] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org, 
	linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz, 
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 4 =C2=B7 Low: 0
>
> - [High] In xpcs_get_state_c37_sgmii() the combination
>   'DW_VR_MII_AN_STS_C37_ANCMPLT_INTR set + DW_VR_MII_C37_ANSGM_SP_LNKSTS=
=E2=80=A6
> - [Medium] Undisclosed functional change: besides the two BMCR_ANRESTART
>   additions the commit message advertises, the patch adds a new=E2=80=A6
> - [Medium] Device-specific quirk applied unconditionally: the commit
>   message and the new comment at drivers/net/pcs/pcs-xpcs.c:776-781=E2=80=
=A6
> - [Medium] Wrong ordering in xpcs_get_state_c37_sgmii(): the latched AN-
>   complete indication is consumed (xpcs_write(DW_VR_MII_AN_INTR_STS, 0),=
=E2=80=A6
> - [Medium] The patch turns the read-only-by-contract pcs_get_state()
>   callback into a hardware-state-changing operation (BMCR read-modify-=E2=
=80=A6
>
> --
>
> net: pcs: xpcs: add ANRESTART support for SGMII link recovery
>
> The patch sets BMCR_ANRESTART together with BMCR_ANENABLE when
> xpcs_config_aneg_c37_sgmii() enables in-band AN, and makes
> xpcs_get_state_c37_sgmii() clear DW_VR_MII_AN_INTR_STS and assert
> BMCR_ANRESTART when the link is down with AN completion latched.  A new
> comment explains that the DesignWare databook says AN restart is not
> needed for MAC side SGMII, but that some parts (Rockchip RK3568) need it.
>
> A few questions below.
>
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 0337e2bcc0125..8c3875b6985b9 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> > @@ -769,7 +771,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xp=
cs *xpcs,
> >        *       SR_MII_AN_ADV. MAC side SGMII receives AN Tx Config from
> >        *       PHY about the link state change after C28 AN is complete=
d
> >        *       between PHY and Link Partner. There is also no need to
> > -      *       trigger AN restart for MAC-side SGMII.
> > +      *       trigger AN restart for MAC-side SGMII on most devices.
> > +      *
> > +      * Note: While the DesignWare databook states that AN restart is
> > +      *       not needed for MAC side SGMII, some implementations (e.g=
.
> > +      *       Rockchip RK3568) exhibit a timing quirk when integrated =
with
> > +      *       phylink and do not restart AN automatically when the lin=
k
> > +      *       comes back up. An explicit AN restart is required on tho=
se
> > +      *       parts to recover the link after a disconnect.
> >        */
>
> [Severity: Medium]
> The comment says the restart is only "required on those parts" and that
> there is "no need to trigger AN restart for MAC-side SGMII on most
> devices", and the commit message says "This is not a fix for an existing
> mainline platform".  The code, however, applies the restart on every
> device: no gate on xpcs->info.pma or xpcs->desc, and struct dw_xpcs gains
> no quirk flag.
>
> The same function already uses that gating idiom a few lines below:
>
>         if (xpcs->info.pma =3D=3D WX_TXGBE_XPCS_PMA_10G_ID) {
>                 mask |=3D DW_VR_MII_AN_CTRL_8BIT;
>                 val |=3D DW_VR_MII_AN_CTRL_8BIT;
>                 /* Hardware requires it to be PHY side SGMII */
>                 tx_conf =3D DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
>
> Note that this TXGBE case is configured as PHY-side SGMII, which the
> MAC-side/RK3568 rationale in the comment does not cover.
>
> Should the new restart be gated on the affected PMA (or on a new dw_xpcs
> quirk flag) so the code matches what the comment and the commit message
> describe?

Rockchip does not own a unique PMA ID, so there is nothing to gate on.
The restart is a standard BMCR bit, and it was tested on Wangxun and on
older XPCS hardware without adverse effect. Enabling AN and restarting
it in the same write is the correct sequence regardless of the return
value.

> Also, phylink already has a path for this: pcs_config() may return a
> positive value to ask phylink to call .pcs_an_restart, and
> xpcs_an_restart() in this same driver performs exactly the same register
> write:
>
>         xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
>                     BMCR_ANRESTART);
>
> Would using that framework path be preferable to open-coding the restart
> in the config and get_state callbacks?

I think enable and restart AN at once whatever returns value is correct.

> > @@ -816,9 +825,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xp=
cs *xpcs,
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Clear CL37 AN complete status */
> > +     ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0=
);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> [Severity: Medium]
> The commit message describes the change as "Add BMCR_ANRESTART in two
> places" plus a comment update, but this hunk adds a third functional
> change that is only visible as item "5)" in the in-code numbered list.
>
> This write is unconditional: it runs for every xpcs_config() ->
> xpcs_do_config() -> xpcs_config_aneg_c37_sgmii() call and for every
> neg_mode, including PHYLINK_PCS_NEG_OUTBAND where no AN is subsequently
> enabled.  It clears the register that xpcs_get_state_c37_sgmii() uses as
> its only source of link/speed/duplex and of state->an_complete:
>
>         ret =3D xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
>
> It also changes the value returned when neg_mode is not
> PHYLINK_PCS_NEG_INBAND_ENABLED: the function now returns the result of
> this AN_INTR_STS write instead of the DIG_CTRL1 modify.
>
> Could the commit message mention this status clear and the return value
> change?  For reference, xpcs_config_aneg_c37_1000basex() already performs
> the identical clear, so the write itself matches existing driver practice=
.

The clear is already performed in xpcs_get_state_c37_sgmii() before
this patch, so the behaviour is unchanged for that path. I'll leave the
commit message as is.

> >       if (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)
> >               ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> > -                              mdio_ctrl | BMCR_ANENABLE);
> > +                              mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTA=
RT);
> >
> >       return ret;
> >  }
> > @@ -1093,9 +1107,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xp=
cs *xpcs,
> >               return 0;
> >       }
> >
> > -     /* Clear AN complete status or interrupt */
> > -     if (state->an_complete)
> > -             xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0=
);
> > +     if (state->an_complete) {
> > +             /* Clear AN complete status or interrupt */
> > +             ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INT=
R_STS, 0);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             /* Initiate the next round of AN */
> > +             ret =3D xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_=
ANRESTART,
> > +                               BMCR_ANRESTART);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
>
> [Severity: High]
> Is the trigger condition here really "stuck AN"?  The state reached at
> this point is ANCMPLT latched with LNKSTS clear, taken from the same
> register read:
>
>         state->an_complete =3D ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
>
>         if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
>                 ...
>                 return 0;
>         }
>
> For C37/SGMII, isn't that the normal steady state whenever the partner
> PHY's media side is down?

This state must trigger an ANRESTART. On an unplugged SGMII port, the
partner PHY keeps sending a LNKSTS=3D0 config word, so the PCS completes
AN and latches ANCMPLT while LNKSTS stays clear. Without a restart the
PCS stays in that state indefinitely and never re-runs AN when the
partner comes back, so the link can never recover. Re-issuing ANRESTART
on each poll while the link is down is the mechanism that makes
recovery possible.

> The PHY keeps sending config words, the SGMII
> AN exchange completes and latches ANCMPLT (bit 0), and the media link
> state is carried separately in the received config word via LNKSTS
> (bit 4), per pcs-xpcs.h:
>
>         #define DW_VR_MII_AN_STS_C37_ANCMPLT_INTR       BIT(0)
>         ...
>         #define DW_VR_MII_C37_ANSGM_SP_LNKSTS           BIT(4)
>
> If so, then on an unplugged port each restart re-completes within the AN
> link timer with LNKSTS still 0 and re-latches ANCMPLT, so the condition
> re-arms itself and a fresh AN restart is issued on every poll,
> indefinitely.  phylink polls pcs_get_state once per second and
> xpcs->pcs.poll is true for everything except WX_TXGBE and MP_FBNIC, so
> this affects the existing DW_AN_C37_SGMII users (stmmac/Intel mGbE, NXP
> SJA1105/SJA1110, Wangxun), not only RK3568.
>
> Two further consequences: with MAC_AUTO_SW armed, the hardware-selected
> speed/duplex is dropped on each cycle, and because the whole status word
> is cleared by writing 0, a restart that lands on a just-latched LNKSTS=3D=
1
> word destroys that link-up indication and costs an extra poll interval.

The speed/duplex bits in the status word are read-only, so the
"MAC_AUTO_SW result dropped each cycle" concern does not apply: the
hardware re-derives them after each restart.

> For the interrupt-driven case there may also be a faster loop.  The SGMII
> AN_CTRL modify in xpcs_config_aneg_c37_sgmii() does not include
> DW_VR_MII_AN_INTR_EN in its mask, while the 1000BASE-X path sets it:
>
>         if (!xpcs->pcs.poll) {
>                 mask |=3D DW_VR_MII_AN_INTR_EN;
>                 val |=3D DW_VR_MII_AN_INTR_EN;
>         }
>
> so an enable programmed by a previous 1000BASE-X configuration persists
> into SGMII mode.  On txgbe the AN event is routed to the link IRQ:
>
> drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c:txgbe_misc_irq_handle() {
>         if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
>                     TXGBE_PX_MISC_ETH_AN)) {
>                 sub_irq =3D irq_find_mapping(txgbe->misc.domain, TXGBE_IR=
Q_LINK);
>         ...
> }
>
> which ends in phylink_pcs_change() -> pcs_get_state(), so the restart can
> be re-triggered at hardware rate rather than once per second.
>
> Would gating this on the affected PMA/quirk, or on an explicit "AN is not
> active" hardware condition rather than on the latched AN-complete bit,
> address this?

On the loop rate: phylink only registers its own link IRQ for
MLO_AN_FIXED with a link GPIO. For in-band SGMII, phylink either polls
pcs_get_state() through the PCS poll timer when pcs->poll is set, or
waits for the PCS driver to call phylink_pcs_change() from its own
interrupt. On RK3568, xpcs->pcs.poll is set, so this runs at phylink's
resolve interval, roughly once per second. A single MDIO register write
per second is not a concern. On interrupt-driven parts the behaviour
was tested by Wangxun and no adverse effect was observed.

> [Severity: Medium]
> Is the ordering here recoverable if the second access fails?  The latched
> AN-complete indication is consumed by the xpcs_write(DW_VR_MII_AN_INTR_ST=
S,
> 0) before the fallible read-modify-write that actually starts the next
> negotiation.
>
> If the write succeeds and the xpcs_modify() of MII_BMCR fails on the
> register back-end, the only indication that AN completed is gone and no
> new negotiation was started.  The block that would retry is itself gated
> on state->an_complete, which is now read back as 0, so the restart is
> never attempted again.  The error only reaches xpcs_get_state(), which
> logs it from a void callback:
>
>                 ret =3D xpcs_get_state_c37_sgmii(xpcs, state);
>                 if (ret)
>                         dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
>                                 "xpcs_get_state_c37_sgmii", ERR_PTR(ret))=
;
>
> and nothing records a pending restart.  This matters most on the hardware
> this patch targets, where AN is not restarted automatically, so the port
> would stay down until a fresh pcs_config().  The failure is plausible for
> these vendor-MMD accesses: the RK3568 back-end added later in this series
> returns errors from pm_runtime_resume_and_get() inside
> xpcs_rk_write_reg()/xpcs_rk_read_reg().
>
> Would asserting BMCR_ANRESTART before clearing the status word, or
> retrying independently of the latch, close this window?

If an MDIO access fails at this point, it means an unrecoverable
hardware error until reset. Retrying independently of the latch would
not help in that case.

> [Severity: Medium]
> This makes pcs_get_state() change hardware state rather than only read it=
,
> and phylink calls that callback from contexts with no common lock.
>
> phylink_resolve() holds pl->state_mutex (and the phy locks) but not RTNL,
> while these two callers hold only RTNL:
>
> drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
>         ...
>                 phylink_mac_pcs_get_state(pl, &link_state);
>         ...
> }
>
> drivers/net/phy/phylink.c:phylink_mii_read() {
>         ...
>                         phylink_mac_pcs_get_state(pl, &state);
>         ...
> }
>
> The lockset intersection is empty, and the driver holds no private lock,
> so two CPUs can run this block at once and both assert BMCR_ANRESTART,
> aborting each other's negotiation.  It can also interleave with the
> multi-transaction BMCR sequence in xpcs_config_aneg_c37_sgmii(), which
> reads BMCR, writes it with ANENABLE cleared, programs AN_CTRL/DIG_CTRL1,
> clears AN_INTR_STS, and finally writes the cached value back:
>
>         mdio_ctrl =3D xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
>         ...
>                 ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
>                                  mdio_ctrl & ~BMCR_ANENABLE);
>
> Each xpcs_read/xpcs_write is a separate bus transaction, so an AN restart
> can land while AN is disabled and the AN configuration is only half
> applied.
>
> Both RTNL-only paths need the PCS-only case (no phydev), which is
> reachable for inband SGMII without a PHY, and SIOCGMIIREG and
> ETHTOOL_GLINKSETTINGS are unprivileged.  Before this patch these paths
> only cleared the AN status word; should the restart be moved to a context
> that is serialized with pcs_config(), such as the .pcs_an_restart op?

xpcs_get_state_c73() already calls xpcs_soft_reset() and
xpcs_do_config() from the same callback, so changing hardware state
from pcs_get_state() is an established pattern in this driver, not
something this patch introduces. The locking model is phylink's, and
reworking it is out of scope for this series.
