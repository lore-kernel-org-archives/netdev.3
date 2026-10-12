Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390D3CAA55
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833110; cv=pass; b=VIsoLJvJcTsvrYrjGenp7wAluuPk+GvcRpYNpghoKVtf5TskH/3uHlmnINIC7P6p51gh1rXU+YG89Qk/aVqi7gvAHAVNq7X5hUVjQllDwUsLXyqIgTIQsC6T0i5PwWKeBupTLE5P1bpLv1ci+J8qWpCZ/62fGQ4SNcmijpVsp9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833110; c=relaxed/simple;
	bh=tgIZVnCf3XGFRPbT2LLSKxTT3U2rAEpxKOb6eHJqbdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcWL+HIp6nkgB6R1rrSrGz8X2bSYa7iyxd9d6EBvVZWwmitypOu9K6xyquCHi+pKtf7S8e3E+sPCaDCfmHL9gSNa9gGuEdQ2RFped++ZtXIvdXb/6IBU8H/AEi5dh5YounBNG6mhh7D/C5xLPAZ8DttsiDKROE+woBDtZKcMBhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDQoBfQ+; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDQoBfQ+"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c3305a41e91so98486866b.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833107; cv=none;
        d=google.com; s=arc-20260327;
        b=YyxdGv+4BS15ay6JFx0+CN9daTDmsbT3uUF6NLfaTO87E3HJvWwv2zmvK6f4Zp/baa
         cUMp1XHMiB17hPBRV5ZjF9u6M0/ORkejsHcE69PGyMnzsG0g/s11buNZw+aKvyM/Uuv/
         HO7tF3nCD09soBjO/rx+3obReVGFzqoBwOEcJZBCvmLh8oet2J7Ogvyss6wzBS8AGcgh
         RfYu7S1imGvlBHEoLqQsJzzqa5khACpgp0gYceGFyDWFNDlND1IaAPTQZLcfmplIwP0r
         pqEoXWNdBDT21UdhuDrKyKIMTPYnOppiUeMCHCNcvKuqpxNSFwIXZvHuScRBoyfFZ/TR
         LBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L70Ii9x5C+z302d/Psn2CqblJNvQ2CMmeLwkxN/XibM=;
        fh=6694cGZWKmRYVJwxcwwyrkKeiVC9aSdviCATJDoK7kw=;
        b=HDlnl9hmdc4RzLLmWH7E3G49m8AaPJwaKhwUbN/qtM5lquLOVuyXERB6/rXOU0XTaf
         2lqhKUn3cDE/VJufwvbmuuKzEycSc56nhmtZbdKRwzXzF6BHQ4xsf4qEqnfJdChOtdSq
         hrbCtxteITbTquh4HRQCdWl/dBtRch90racBbc5qF/aC3HSyK8qwoLTBOBoDCk4pZmql
         Q6W1GLf7ZvAgkUlW8JDJpYlo9GUUt9HiCaeBhWDOR95vigXs14Fobr5H3GKoBq1pC3cx
         1VaP7B65fNYQops9xtsJrd7iCNtpK2C0bk3yiyN1wX2vrMtped+xGh5jT/MtQDQdonXL
         GdKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791833107; x=1792437907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L70Ii9x5C+z302d/Psn2CqblJNvQ2CMmeLwkxN/XibM=;
        b=ZDQoBfQ+rT9HTYW4+uiEMdJEdlujo8CsZRIsDKUY5oArj8I85efzyKg+TEET5Dvmo5
         pX8kHWIcYG1g60TGWnazVOVQ4QDtCjaxBu8HnGfktOxCQ4Lt+XbbZ52YeuPnkIv3t7R2
         uwFmKMTOtJCGqfeHNT+II5rlsIL3roBWl7q/O8wE/TE74OO0CEO5KB9D2iSPJSgArjF2
         2HhXwy+Fh8gTtW2W1qVRQSrC4nSwdodECNgkqlAXpOFy7Xhe7mc8Jj9gZG3HSkyU5HGz
         r7VfljbgJDMs7uZbf12lF8rEBMPBN/p2Ry/OWRliy2Kt/rDNM5NXAQl9D0YmoNndxrLb
         FW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833107; x=1792437907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L70Ii9x5C+z302d/Psn2CqblJNvQ2CMmeLwkxN/XibM=;
        b=u0sU1OHWSrIKzDdDRlJpLP98B+/5ZZKyMpNjFmONLW7E/Dep14sFUWT5+LJCdEjynt
         gh3tlxAHHWRLudMQlBUUsOmxAjuADK8IOZlr14uj3Pt2FB2RfzCCqafsZv1y4652hjCk
         6DRW8i5TTU8uPQOHtc4lOMD3q57emD8JnEdzgqQh9ro5bJrHr+oUXnKXY8m19XXmo9/j
         G2kkA/XZ5e/FIZTFzXm9owQaj2G6JoktSfpjTKOPFbxQawWjnTmCE4Ve/jlbr/h0kpnL
         D5b6ldBwaysTi+ne0SX4Qj8RXOCITn3XJ6SpmSgd4oH+Tw4nnD9h93O749A0F0/KSm8P
         VX0w==
X-Forwarded-Encrypted: i=1; AKwUvByIlIDJvhzNhQL0O9ejF1iHRq+H3bXKSMPx/KSZ+qhuFk1GhX8gYsf0KDNKSR25R0fZxXPMqfc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRFETtTHN/wHBmHJsh7GqXME4u55tQlAR5JOTh1opCzYpKJD8B
	psQ2Hmkaytx3E72Q0woGyPJaYfrvP3EITvJbg17vnL24BhTZ1VtjCU1KYc0Y5DFJxeyA4fSYLyF
	t26mycPv5Qn4mbUUwXUz74jEdbfS/TKo=
X-Gm-Gg: AYBFou3lCgFIDKRZsd/LgH6J8+0O1FlfmzUx6gQcEQDftaoF6JQ6tUSS4bwzJcQ4q05
	zZA2PRlZkxvs6fIBO3YzQNHzxaSmfSvPxj2fXWPMb+4Ruo7t1X9Mg5z6aS2gQJJd12GvAo1Xno/
	ZXFKS9HBfrGZ1lM06W1vsFt03vO+F3TDwR095/OM/Xp+90W3asOo2BJ++wHGPpqLff+IxieIp4u
	FhXeGyHS1i790lgORcHdxtrUm/0Vj7lwksMQRiPc1LLuhEjVvYpZC4bgemMQZxRqJwf/2M9Ft2o
	XdZ8zOA7ibRPETBcoJTukXVihpafP6vZf6aInYt61nNWIkCTCx0zfl+rQA==
X-Received: by 2002:a17:906:7948:b0:c29:60b7:3f14 with SMTP id
 a640c23a62f3a-c31aa02b449mr966426866b.46.1791833106527; Mon, 12 Oct 2026
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008175225.3375274-2-coiaprant@gmail.com> <179183168522.434549.14619345397319265452@kernel.org>
In-Reply-To: <179183168522.434549.14619345397319265452@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 13 Oct 2026 03:24:59 +0800
X-Gm-Features: AclHuK_IK-J3xdjBLHul-e3CTuwWO6mo07_5PjrwMDoCpvY_M9ekvq5ssPY4yMg
Message-ID: <CALj3r0jTq+wztO=-TMDkNTM7OFkB4UHMpugTnQ+YPiuWYD9MFA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/6] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	david.wu@rock-chips.com, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. Both points were raised in earlier versions and are intentional
for this hardware.

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=8C 03:01=E5=86=99=E9=81=93=EF=BC=9A
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
> - [Medium] xpcs_get_state_c37_sgmii() now does a non-atomic read -> act
>   sequence.
> - [Low] Concern: in xpcs_get_state_c37_sgmii() the ANCMPLT latch is
>   cleared (pcs-xpcs.c:1112) before BMCR_ANRESTART is issued (pcs-=E2=80=
=A6
>
> --
>
> net: pcs: xpcs: add ANRESTART support for SGMII link recovery
>
> This patch sets BMCR_ANRESTART alongside BMCR_ANENABLE when configuring
> C37 SGMII AN. It also clears DW_VR_MII_AN_INTR_STS before AN starts. In
> xpcs_get_state_c37_sgmii(), when AN completion is seen with the link down=
,
> it clears the ANCMPLT latch and restarts AN, so that parts such as RK3568
> can recover the link.
>
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index b415b93d77c15..6466e0ff2a98b 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
>
> [ ... ]
>
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
>
> [Severity: Medium]
> Can two callers of .pcs_get_state() race here and restart a negotiation
> that has just finished with the link up?
>
> The read of DW_VR_MII_AN_INTR_STS at the top of the function and the
> clear and restart here are not atomic. phylink calls .pcs_get_state()
> from contexts that do not share a lock:
>
>   phylink_resolve()                   holds pl->state_mutex, not RTNL
>   phylink_ethtool_ksettings_get()     holds RTNL only (MLO_AN_INBAND,
>                                       no phydev)
>   phylink_mii_ioctl()->phylink_mii_read()   holds RTNL only
>
> struct dw_xpcs has no lock of its own, and the MDIO bus lock only covers
> each single access.
>
> A possible interleaving:
>
> CPU1 (ethtool get)                  CPU0 (phylink_resolve)
> xpcs_read(INTR_STS)
>   link=3D0, ANCMPLT=3D1
>                                     xpcs_read(INTR_STS)
>                                       link=3D0, ANCMPLT=3D1
>                                     xpcs_write(INTR_STS, 0)
>                                     xpcs_modify(BMCR, ANRESTART)
>                                     ... AN completes, link up ...
> xpcs_write(INTR_STS, 0)
> xpcs_modify(BMCR, ANRESTART)
>
> CPU1 acts on its stale sample. It clears the newly latched ANCMPLT and
> restarts AN on a link that has just come up.
>
> Before this patch, a concurrent caller could only clear the latch. The
> extra restart is new. Unprivileged users can issue ethtool get link
> settings.
>
> The commit message's reason for clearing the latch before the restart
> assumes that get_state calls are serialized. Does phylink actually
> guarantee that for these callers?

The C37 SGMII path needs to restart AN from xpcs_get_state() because
phylink does not call .pcs_an_restart for SGMII. On RK3568 the PCS does
not restart AN by itself, so a link that goes down would stay down
without this. The same pattern is already used by xpcs_get_state_c73(),
which calls xpcs_soft_reset() and xpcs_do_config() from the same
callback.

On the non-atomic read-act sequence: the concurrent caller can only
come from ethtool or mii_read, which do not hold pl->state_mutex. So
yes, the sequence is not strictly serialized against the normal poll
path.

The consequence is a possible extra AN restart on a link that just
came up. On this hardware an AN restart is idempotent and safe: if the
link is already up, the PCS re-negotiates and comes back up. There is
no state corruption, no register left in a bad state, and no way for
the concurrent caller to observe a torn value, since each MDIO access
is individually locked.

Before this patch a concurrent caller could clear the latch; the extra
restart is new, but its only effect is to shorten the window in which
a stale sample can be acted upon.

> [Severity: Low]
> What retries the restart if the xpcs_write() of DW_VR_MII_AN_INTR_STS
> succeeds and then this xpcs_modify() of MII_BMCR fails?
>
> The latched ANCMPLT that triggers this path has already been cleared. No
> restart is pending, and xpcs_get_state() only logs the error:
>
> phylink_resolve()
>   xpcs_get_state()
>     xpcs_get_state_c37_sgmii()
>       xpcs_write(DW_VR_MII_AN_INTR_STS, 0)    succeeds
>       xpcs_modify(MII_BMCR, BMCR_ANRESTART)   fails
>     dev_err(..., "xpcs_get_state_c37_sgmii", ...)
>
> On parts that do not restart AN by themselves, the link would then stay
> down until the interface is reconfigured.
>
> The commit message covers this case:
>
>   "If an MDIO access fails at this point, it indicates an unrecoverable
>   hardware condition until reset."
>
> On RK3568, the MMIO-based MDIO back end added later in the series seems
> to fail only through pm_runtime_resume_and_get(). That failure is not
> transient. On other XPCS platforms the databook says AN restarts on its
> own. So the documented behaviour may be fine as it is.
>
> > +     }
> >
> >       return 0;
> >  }

The latch ordering is deliberate: clearing it after the restart would
discard a freshly latched ANCMPLT from the new negotiation. An MDIO
failure at that point means the transport is gone, so there is nothing
to retry.
