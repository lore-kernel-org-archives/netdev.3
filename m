Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794449140;
	b=aMqGa5QaTqM7XTjyC9XR3Gf29ZPG0h52XyYZ9yUlhTlg4EdyGGpxCBqiwIX3M+CaZlPf
	 aWxH3FlA0NtP+pi469DzXr0NUu6Wk1L1zEyhiRgRcuWqJFjGTRaFHvvi84yk4ClQ2Kb9H
	 UY/C4zDkLmoPcyErgiXnfTv2eDIv+YsQIHoflDmceixNdr/qH/q8zdhhtfB87F5L8E83Q
	 SQQpWpIaT/QAXw37jlg6WO+VjGBajcXBw4/D0HC7ISOIHEWQLU62A/DUOeLkoJScASGIj
	 uS4zQQUByJzQSAF0atwH5hUP2Bri0rgkAobQRY7GNinlLmhWWPWBz3YB0erZO1IKjWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/0vlj8biEbEIWWLJtlyy4L8kRDSEsonB5oCN5/5B1Ag=;
	b=BelXgHMMrQgYHMDdd5216LpqtNR32FbSV/GAFU5QB+/tCuiB8d+XeOvnd18/cN1XwImL
	 fEP74nI9XFJcTVD07D/FFTKNv9P2FawckUp4fwIafua01AnIH5Pgg9lCKPiMlCWkddoBE
	 EddirRKuKGp6JSyvoNbHyGB5vdARgp2CyxWEqFKo5eJf2Sl0zW9FA/4xa5A2bcl7R46Ot
	 ALN8e6qN2m+P+WqGp60KOQ4oo9sc9lga1MapV7ZqhOzO7IZVm+dr80iHSankgHoXDJzoy
	 pW04L66qt4ZahcsEkCaTu2msz57urY3waLf4X9KMWgDb01DlzsR8kR4tS0znO1QXNGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IxMQTF2h;
	arc=fail smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAD606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DAD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IxMQTF2h
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91eb449364cso41818966d6.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:05:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794449139; cv=none;
        d=google.com; s=arc-20260327;
        b=pCXPtUsLqjPPgUv7/7VQk6BxQhS1cEOEjX3TdXG6OwHa7k4XzMUC/8PkyK0izF2B97
         sAhTy2z16htKNrO/tvg7GOJuAhflREG77of3mP+1EUvVZ6xbbKAN1rrCh0MCTYuIfVlb
         eX7WIjZgzWnuEJcHMkAJLk4Z7Nf/i2ns4qLqvHlqAf5pRki8e50UDMEXI90EzL4BWFrU
         XF0bHnn18ekfUvYP/hBg6Nl7C0y50KwfBSQH/X+lk07V2iuURiHxID5OqGM/InrbriIU
         KFwHHN1N8MmooDcIt3bAjXyOyb9166OO6RY7Z02LTVTj2ZysEgPu3JWV6GAZjg6ylYg3
         R+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0vlj8biEbEIWWLJtlyy4L8kRDSEsonB5oCN5/5B1Ag=;
        fh=EJfS1+np55MeDoIFCHNUU8BvmHS68cDuJ0UEzLpxD+c=;
        b=PAavLFT1+zSuAJLFAGahWHc6PGzR3iRPO+PxhMWzlVNhH3ld7s8W0DgVE69Nkb1UM4
         PR4aYXMLuZ4JVVXkCosqJw14VYIqHPSKpQsLzAgMvTuwQQApZp5U1nXVH2p95/MAjmoo
         cdSpa1DadfjnseLB5zZkvFAfruh4c85PJRN3wShy1xeHuXlTuNerssV3+oi1NPfEs8yU
         cITpa3+gWK3UFU4QGJkHHevI3QkRzvVo82jRJTJrXmTEP4ASMIxv/icr4spPlU+zIPzI
         AOytDPVjypv4Ia3sEcW2RUMTwYk2aa5+ES7siNPmPCYOhovo7v9dXRuRGEXyZ9qy9Rjq
         cl/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794449139; x=1795053939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0vlj8biEbEIWWLJtlyy4L8kRDSEsonB5oCN5/5B1Ag=;
        b=IxMQTF2hXMeOywXftS4CEqMs9Wi82FwbNRyXZbtqcwrfp1U5QT4rEuqqNkML1oMMPo
         A+/V3ilJDoOtHydMsR5g3l2PiUWeP6p46TeGyR8EhLUQtMlWqt0gxKJJ0d6OojFgpXf0
         OLBAHUtFm2JvubuE7gXumU+K9gj/uPcnwvy340VA28enEqmPVnCAK7yLRyFsKINw/h6z
         KnbMNVmOu/kRWhlGKJuSU/z/wq4rZcBfEY824f+cyJM9Ct7dpFQZvyXUI6O3rkZ6A+lu
         pfxNqH9RinHwLC79DgxxPHQC+/uicsZWcAwy0D3DnNRDJQX9VHXQ2AlkvHqQc86yZ4sN
         yeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794449139; x=1795053939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0vlj8biEbEIWWLJtlyy4L8kRDSEsonB5oCN5/5B1Ag=;
        b=Lx4hr9MNAw7V37zG2lEBZANm5nhJ4k0/wy3VH72eO4a6MeQ20oEoxCySZwLmtADRQo
         NwoqZK8HErrUN6KWL09lK20ww1wV+7HduuXN1lEzjBu+Zod5NQ1oDvXEdv2243MjYwe7
         g33eVVEqzcjjJlF5iKltn1qycJX7QcDGLtb1PqwL9GccW/nmFhPNktqop3NfD88ZJwac
         pnRLzlPZH7QTfECIqnGGVINQ7xnFjyLtZniX0XzBMO78xNSboDxUs7HstwV1r1xR+m7B
         HXVP+mdopWUZ/nkl1dr9J4+umwJ5X6wsIkoC63db5hUV0i1KE5k1O0uICDxFUi50kIaE
         PE9Q==
X-Forwarded-Encrypted: i=1; AL+hErEdXMK30XFFEBiuqhRqBcroxaCCExVllj8/p2aOqn6K0gFoniCghFXv+MLZV4Eh6BDMN7AvFuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hTU6SCIVhrEjp7ZsYXwZLguyJA85lHey+/5JPlWkcs/QTvrMM
	2FyAxH6VCjKI1mBdYA8JB7Xrwg1r6sL9sVGo44n/VFaCkNrZaplCXq+usavxJcuceqFESG7qXnS
	mE7vVIJcw20oGNRyKWqLGCOxuOaoBDYL7GwwfDn8=
X-Gm-Gg: AYBFou0UPXkiyroGAjgKX4C33NrXODjw3JJkSB7muanPn3whtk+zPoXJf0SabZDMFtR
	Ubs/a70xJYvsM0jdowLS9TW9Zyf5lqdMcDSBElSLmjuMVzalqXa402Rx5F+9jjiSsRrhvlcV5af
	Z0ge8bOMh/yfWjJLxUeY4X9uVn0KVibG+bCDeuUB9ARum3oCBbIsdqZWGQSQ/FcZYittc/177Ye
	+Kr/UIemrppHUleOT7ALNSu+FXKLrbtyM5dEk4ktS51NsKgDBfm4h2oHY2f2CjKcZHeo/TkeyKL
	df1BS6acskTZSXW+8wsuTFDVagRoPE5FTc62M26sBBvZddZloe01ZX4ryiR4sa+p2ir5EbENR7m
	EPtHToesgbquEfLnVjpRBF6usSbkH07X9mSbo
X-Received: by 2002:a05:6214:43c4:b0:91e:a16b:7f59 with SMTP id
 6a1803df08f44-91f041a3015mr70947606d6.32.1794449139052; Wed, 11 Nov 2026
 18:05:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111143322.2234321-1-zxyan0222@gmail.com> <8cecf0d6-d04a-4bb6-91fb-b5c9b091ae8e@bootlin.com>
In-Reply-To: <8cecf0d6-d04a-4bb6-91fb-b5c9b091ae8e@bootlin.com>
From: zhu xin <zxyan0222@gmail.com>
Date: Thu, 12 Nov 2026 10:05:27 +0800
X-Gm-Features: AclHuK_JBKbEg5YNVMjlOYXo-dms9mDeiUQevOueQJI8T7Konue-phx2WH1WrNg
Message-ID: <CAP7veTJVEs9rU66+1PXZt-BvfwGPUiXEwkO2nR6ftVYytTbvAw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: program the FSM timeout timer
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rmk+kernel@armlinux.org.uk, Jose.Abreu@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, Nov 12, 2026 at 12:19=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 11/11/26 15:33, Zxyan Zhu wrote:
> > stmmac enables the FSM timeout checker (TMOUTEN) but never programs the
> > MAC_FSM_ACT_Timer register.  Per the databook the checker only fires on=
ce
> > NTMRMD is programmed with a non-zero duration; NTMRMD =3D=3D 0 disables=
 the
> > timer, so with TMOUTEN set but the timer left at reset a stuck FSM is
> > never reported and the advertised timeout protection is ineffective.
> >
> > Program MAC_FSM_ACT_Timer right after TMOUTEN is enabled, deriving the
> > TMR field (CSR clocks per 1us tic) from the CSR clock rate and defaulti=
ng
> > to a 1s timeout.  A platform can override the default through the new
> > ntmrmd field in stmmac_safety_feature_cfg.
> >
> > The issue was hit in testing on a downstream platform, where a stuck FS=
M
> > was not reported through the safety interrupt despite TMOUTEN being set=
.
> >
> > Fixes: 8bf993a5877e ("net: stmmac: Add support for DWMAC5 and implement=
 Safety Features")
> > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC c=
ore")
> > Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
>
> IMO this should go to net-next, this seems to just never have worked.

OK, I'll resend this as a net-next patch.

>
> Out of curiosity, did you test on dwmac4 or on dwxgmac ?

Both. The timer programming was tested on dwmac4 and on dwxgmac.

>
> Maxime
>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 20 ++++++++++++++++++-
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  6 +++++-
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +++
> >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 20 ++++++++++++++++++-
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  3 ++-
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 +++++++-
> >  include/linux/stmmac.h                        | 17 ++++++++++++++++
> >  7 files changed, 72 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac5.c
> > index f1bb981cab7c..4ab7a3df98c6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > @@ -2,6 +2,7 @@
> >  // Copyright (c) 2017 Synopsys, Inc. and/or its affiliates.
> >  // stmmac Support for 5.xx Ethernet QoS cores
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/bitops.h>
> >  #include <linux/iopoll.h>
> >  #include "common.h"
> > @@ -184,7 +185,8 @@ static void dwmac5_handle_dma_err(struct net_device=
 *ndev,
> >  }
> >
> >  int dwmac5_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
> > -                           struct stmmac_safety_feature_cfg *safety_fe=
at_cfg)
> > +                           struct stmmac_safety_feature_cfg *safety_fe=
at_cfg,
> > +                           unsigned int csr_clk_mhz)
> >  {
> >       struct stmmac_safety_feature_cfg all_safety_feats =3D {
> >               .tsoee =3D 1,
> > @@ -245,6 +247,22 @@ int dwmac5_safety_feat_config(void __iomem *ioaddr=
, unsigned int asp,
> >               value |=3D TMOUTEN; /* FSM Timeout Feature */
> >       writel(value, ioaddr + MAC_FSM_CONTROL);
> >
> > +     /* Program the FSM active timer so the timeout checker actually f=
ires.
> > +      * TMR is the number of CSR clocks per 1us tic, i.e. csr_clk in M=
Hz.
> > +      * Default to a 1s timeout when the platform did not select one.
> > +      */
> > +     if (safety_feat_cfg->tmouten && csr_clk_mhz) {
> > +             u32 ntmrmd =3D safety_feat_cfg->ntmrmd;
> > +
> > +             ntmrmd =3D (ntmrmd >=3D STMMAC_NTMRMD_1US &&
> > +                       ntmrmd <=3D STMMAC_NTMRMD_64SEC) ?
> > +                      ntmrmd : STMMAC_NTMRMD_1SEC;
> > +
> > +             writel(FIELD_PREP(MAC_FSM_ACT_TIMER_NTMRMD, ntmrmd) |
> > +                    FIELD_PREP(MAC_FSM_ACT_TIMER_TMR, csr_clk_mhz),
> > +                    ioaddr + MAC_FSM_ACT_TIMER);
> > +     }
> > +
> >       /* 4. Enable Data Parity Protection */
> >       value =3D readl(ioaddr + MTL_DPP_CONTROL);
> >       if (safety_feat_cfg->edpp)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net=
/ethernet/stmicro/stmmac/dwmac5.h
> > index 00b151b3b688..734e7630f28d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > @@ -8,8 +8,11 @@
> >  #define MAC_DPP_FSM_INT_STATUS               0x00000140
> >  #define MAC_AXI_SLV_DPE_ADDR_STATUS  0x00000144
> >  #define MAC_FSM_CONTROL                      0x00000148
> > +#define MAC_FSM_ACT_TIMER            0x0000014C
> >  #define PRTYEN                               BIT(1)
> >  #define TMOUTEN                              BIT(0)
> > +#define MAC_FSM_ACT_TIMER_TMR                GENMASK(9, 0)
> > +#define MAC_FSM_ACT_TIMER_NTMRMD     GENMASK(19, 16)
> >
> >  #define MAC_PPS_CONTROL                      0x00000b70
> >  #define PPS_MAXIDX(x)                        ((((x) + 1) * 8) - 1)
> > @@ -82,7 +85,8 @@
> >  #define GMAC_INT_FPE_EN                      BIT(17)
> >
> >  int dwmac5_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
> > -                           struct stmmac_safety_feature_cfg *safety_cf=
g);
> > +                           struct stmmac_safety_feature_cfg *safety_cf=
g,
> > +                           unsigned int csr_clk_mhz);
> >  int dwmac5_safety_feat_irq_status(struct net_device *ndev,
> >               void __iomem *ioaddr, unsigned int asp,
> >               struct stmmac_safety_stats *stats);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/n=
et/ethernet/stmicro/stmmac/dwxgmac2.h
> > index f8ab347f7b5b..1fd501728b18 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -169,8 +169,11 @@
> >  #define XGMAC_HWFEAT_PCSEL           GENMASK(1, 0)
> >  #define XGMAC_MAC_DPP_FSM_INT_STATUS 0x00000150
> >  #define XGMAC_MAC_FSM_CONTROL                0x00000158
> > +#define XGMAC_MAC_FSM_ACT_TIMER              0x0000015C
> >  #define XGMAC_PRTYEN                 BIT(1)
> >  #define XGMAC_TMOUTEN                        BIT(0)
> > +#define XGMAC_MAC_FSM_ACT_TIMER_TMR          GENMASK(9, 0)
> > +#define XGMAC_MAC_FSM_ACT_TIMER_NTMRMD               GENMASK(19, 16)
> >  #define XGMAC_MDIO_ADDR                      0x00000200
> >  #define XGMAC_MDIO_DATA                      0x00000204
> >  #define XGMAC_MDIO_C22P                      0x00000220
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 1a88cbaed70c..76c850ea13a5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -4,6 +4,7 @@
> >   * stmmac XGMAC support.
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/bitrev.h>
> >  #include <linux/crc32.h>
> >  #include <linux/iopoll.h>
> > @@ -835,7 +836,8 @@ static void dwxgmac3_handle_dma_err(struct net_devi=
ce *ndev,
> >
> >  static int
> >  dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
> > -                         struct stmmac_safety_feature_cfg *safety_cfg)
> > +                         struct stmmac_safety_feature_cfg *safety_cfg,
> > +                         unsigned int csr_clk_mhz)
> >  {
> >       u32 value;
> >
> > @@ -871,6 +873,22 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, =
unsigned int asp,
> >       value |=3D XGMAC_TMOUTEN; /* FSM Timeout Feature */
> >       writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
> >
> > +     /* Program the FSM active timer so the timeout checker actually f=
ires.
> > +      * TMR is the number of CSR clocks per 1us tic, i.e. csr_clk in M=
Hz.
> > +      * Default to a 1s timeout when the platform did not select one.
> > +      */
> > +     if (safety_cfg && safety_cfg->tmouten && csr_clk_mhz) {
> > +             u32 ntmrmd =3D safety_cfg->ntmrmd;
> > +
> > +             ntmrmd =3D (ntmrmd >=3D STMMAC_NTMRMD_1US &&
> > +                       ntmrmd <=3D STMMAC_NTMRMD_64SEC) ?
> > +                      ntmrmd : STMMAC_NTMRMD_1SEC;
> > +
> > +             writel(FIELD_PREP(XGMAC_MAC_FSM_ACT_TIMER_NTMRMD, ntmrmd)=
 |
> > +                    FIELD_PREP(XGMAC_MAC_FSM_ACT_TIMER_TMR, csr_clk_mh=
z),
> > +                    ioaddr + XGMAC_MAC_FSM_ACT_TIMER);
> > +     }
> > +
> >       /* 5. Enable Data Path Parity Protection */
> >       value =3D readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
> >       /* already enabled by default, explicit enable it again */
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/e=
thernet/stmicro/stmmac/hwif.h
> > index 8ae95e91a36a..395655b01ea8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > @@ -378,7 +378,8 @@ struct stmmac_ops {
> >                            bool srgmi_ral);
> >       /* Safety Features */
> >       int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
> > -                               struct stmmac_safety_feature_cfg *safet=
y_cfg);
> > +                               struct stmmac_safety_feature_cfg *safet=
y_cfg,
> > +                               unsigned int csr_clk_mhz);
> >       int (*safety_feat_irq_status)(struct net_device *ndev,
> >                       void __iomem *ioaddr, unsigned int asp,
> >                       struct stmmac_safety_stats *stats);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index f8dceafdda2d..52f63f624d67 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3639,10 +3639,16 @@ static void stmmac_mtl_configuration(struct stm=
mac_priv *priv)
> >
> >  static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
> >  {
> > +     unsigned int csr_clk_mhz =3D 0;
> > +
> >       if (priv->dma_cap.asp) {
> >               netdev_info(priv->dev, "Enabling Safety Features\n");
> > +             if (priv->plat->stmmac_clk)
> > +                     csr_clk_mhz =3D clk_get_rate(priv->plat->stmmac_c=
lk) /
> > +                                   1000000;
> >               stmmac_safety_feat_config(priv, priv->ioaddr, priv->dma_c=
ap.asp,
> > -                                       priv->plat->safety_feat_cfg);
> > +                                       priv->plat->safety_feat_cfg,
> > +                                       csr_clk_mhz);
> >       } else {
> >               netdev_info(priv->dev, "No Safety Features support found\=
n");
> >       }
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 00be2df63d22..cb470a153bf8 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -168,8 +168,25 @@ struct stmmac_safety_feature_cfg {
> >       u32 edpp;
> >       u32 prtyen;
> >       u32 tmouten;
> > +     /* FSM normal-mode timeout value (MAC_FSM_ACT_Timer.NTMRMD). The =
TMR
> > +      * field (CSR clocks per 1us) is derived from the CSR clock by st=
mmac.
> > +      * 0 selects the default 1s timeout.
> > +      */
> > +     u32 ntmrmd;
> >  };
> >
> > +/* MAC_FSM_ACT_Timer.NTMRMD timeout durations */
> > +#define STMMAC_NTMRMD_1US            0x1
> > +#define STMMAC_NTMRMD_4MS            0x2
> > +#define STMMAC_NTMRMD_16MS           0x3
> > +#define STMMAC_NTMRMD_64MS           0x4
> > +#define STMMAC_NTMRMD_256MS          0x5
> > +#define STMMAC_NTMRMD_1SEC           0x6
> > +#define STMMAC_NTMRMD_4SEC           0x7
> > +#define STMMAC_NTMRMD_16SEC          0x8
> > +#define STMMAC_NTMRMD_32SEC          0x9
> > +#define STMMAC_NTMRMD_64SEC          0xa
> > +
> >  /* Addresses that may be customized by a platform */
> >  struct dwmac4_addrs {
> >       u32 dma_chan;
>
