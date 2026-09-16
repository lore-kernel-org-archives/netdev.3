Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50C4E50AA
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593970; cv=pass; b=qb26fN/glJ+JGWix/wfKDKAvC7jCGnzn9id3DEnu1i3dsOeLxIUwx36FhCuP+1ddTqK+KXFFYuNgyl3TP/ctc+Eb05g9OtRodz/yCmEAioyb+1eEXNltkOQJyHXnd9x6QgwR5GTkOQBS+0k3+p8FcgV7LVu+q8xZNtFhMJ8jIbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593970; c=relaxed/simple;
	bh=PaEyW8ziV39/D+o3TZiBGYjeiJYSGmcsepQiVBnz1sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ublzy5NZOtH7KgPyw+CeGSgkQOHHUYE66hRRFGbzA638o7QBGS3GYszMkysw6kf+PXcJJ6BKisQYjwfSzVpUyL3bIGOv4OnKEVU2Sktl+c6jVmNiDoT2gUqt4py4Gj+PYrizpKXBlrQVNlBM/JgvLeqrDXC9unl/FSEev0CBCu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfIu5n/t; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfIu5n/t"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so30826966b.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789593953; cv=none;
        d=google.com; s=arc-20260327;
        b=nfY0aKARDrvwL0pKK8LlxfQGeWhVKzt3AWPcOs1bN/m/dkxGToF2Dhwj/Ck9HGc55f
         qFAGINm0eVXFkwsvZd2iGwBp612jX4LZoYJxIQjPuHHfDTk6gb6V1H3GCrHzcZ8uaiSV
         Y269pwgyXK9NqlKOe7UuhIVt09yHUtbKFrpHmKDHiCtyDj3K/64x2oN9rtATxam4kVfd
         xEW1ye8f8RvyFDr4pKygAt7wa7LDPcxC1uYSNdpnLoYVGko3VI3p+SAlJQS1eBvEsskr
         OV1JckgU+yq6KY/8lDOn8zowZ3iTbjMSU7e2HFQJ04i5GMFdX+mxQhQt1R2VSUcREoy+
         bZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24dq6MGP09BQVdqu/qtRfDCvRFA88J8G77yWogi+o5k=;
        fh=FQ44TGQ5hDpGCUbWYd2PQEPooHTCUq1fQjtYpfApMf8=;
        b=PvMHB4frd5I8LJ9Ul211R2dl3RD7Tcpg0zxy2qVGcQAYEpBY7DcZZOcaoyLVSLA/Og
         BaWzxLJWN1QkBQbF8hcRPAMzI8U7G6r70YOaGERvKCaq8qpS1lXfwngqATABbpWw2RXC
         qplVGEz3qhlWPJTGmcGHK1LLQSQRkAS5v4qR090bebfWwxUv9Cnmm7MagZlTrYnRyEYs
         +xONdNHa9fzpc3ZRh75x3Qp/dr/j+9PZPn3gBusXyQ/QfrBlY2kbFVKGppsLQFrBgKed
         Gq2XRxbur0S5+O/I7GZx4u3sxFG/in3yv8lEjyxPhUTQWcAjUeiJplaQJmairL24QINI
         1x0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593953; x=1790198753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24dq6MGP09BQVdqu/qtRfDCvRFA88J8G77yWogi+o5k=;
        b=MfIu5n/t1RRV2o/akMJ+Y31OkeyhzD2pq7zmpeZYO4oUGALZZNAW6R7ZQrHOdY01oY
         aJCPZXbJd3tR0RcGsB4VR7z1EqiWPQcldm+1+WF3JPxZGZH8edKlprJ76XvmSAAOTqUp
         kbRmPNf80/Yrs8PE3nnlzjAQHj7a8IgBsHlnK0l6XljHuaNLSn+jGOMK9vXt/jisRZ1o
         OrO/1DWdFp5ykOXUlwTpXDkiOkthwoRpfliaERFEdiswXKomJuwUAdWvnSnp73u/3IrQ
         OHl5f1FrRzafawmfnwoqLbAh2NzN/bE+8PMZfYNlHv9uf8BLgPeaxO7nfbO8miWoWCaK
         vtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593953; x=1790198753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24dq6MGP09BQVdqu/qtRfDCvRFA88J8G77yWogi+o5k=;
        b=im5+c/i/XdZeA1bNhdSxXos9bBlC1WwY96xnlWgk5u4IhdI3jNDz19ezvFqoluYEYk
         kMCMXl6L/hL+uwVPQtLQdMnglqsG+M0JVFNjQ49GN9OzEUIRZAbi6b0V6RTCP8aU6bxU
         lTg3xQQ0d4y1pXguT6l50lOpkWfrMcY0hMkb04K4T+bNKVlWC38M0R8bEtQlGzkcgYNr
         8nd1dccpRSXA0xFCssjubcVc0Ju1fR2S6ridOG/zh294+akpyzW+iZuiRGsB/jz9jZNE
         p/CkKYmApC5ThNkx7USp9E6R1A80iqLPRtSfi/ADVfNQxYiq9dzBvO1drlcC/qGRwZRg
         Jzmw==
X-Forwarded-Encrypted: i=1; AKwUvBy16Y5KJqcaX9yJ2ihDG8P79nwCGZso2jO+6Rrb9HnM6GZoKZmv9naN7FFV6jQOouCx77H1jY4=@vger.kernel.org
X-Gm-Message-State: AFuF++kpUva7ibSXqWaZdmQwQM6uq727vdSo1E/TfAegf+88n8AY4xgQ
	JatAD9ejnbzI6aEx0gfczYB4WHO9mGubjjBeKXz0j2Ht59WLyhwU7xqKRV/WqxD4Z55pliYtr/s
	CWIkPCedYu7D6RonWGYSNySX2M5+vvK0=
X-Gm-Gg: AYBFou0+fO1kNk+AxanALnanOvKjikaDWZxu22NcNl05QLlVWeIZr9fGEO3x4yR+Qt5
	DvqSidjiScfnof6Tkv6gTZ1IbPQrXX0bj8O0q0Fo/Thp5ck1GMSw71/GJGCXKlLSrUkqNCmRYiq
	IIbD7cEbo8xpOdUB3i3CwORdCupLHSizgXL+33SXGVexQcB2s+vLLRyq/jwVPdEBra9Wnwz8JWX
	7GiM2yO6g3iyhyyu9ESaTbLj8JtMw49Sn8y/tG4bnQpG1KsPLUFe0UtoYK73lVFHiXI3fqOO1xo
	+F4w+Xkx9e0mRSfmba+AXxImjXD/RpKKOvkWUA5MnnaImAceeorziwKMxjMkcyZQfQptbJS6RTo
	Y5A2iObJwSALiwKiDiDBI55J32Cdsk4gk31hJfHGIu1RzGGTO58Ha1crLOpoONNV8BDF9IjiW0A
	mxpA0WWeLkYOOzS7OPIhJbrN5ncxI6uN7az6pViU7XTRr6hyZPGYUOBpwB068M8yKb98bD9KTIq
	0kz
X-Received: by 2002:a17:907:9343:b0:c29:62d8:68af with SMTP id
 a640c23a62f3a-c29e5311f45mr285472266b.47.1789593952818; Wed, 16 Sep 2026
 14:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915181709.11323-1-rosenp@gmail.com> <aqrxFTWEsJmFIrel@SMW015318>
 <CAKxU2N_zEA1NxAp6H6J6COjTwUv8NK909m3OZ2kcyVCpCby18A@mail.gmail.com> <aqr7Lfji97j_0nVd@SMW015318>
In-Reply-To: <aqr7Lfji97j_0nVd@SMW015318>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 16 Sep 2026 14:25:41 -0700
X-Gm-Features: AcwNN1V3Sj2lR93W3zP_MWf1RpGY0ZFkZFuGnqEzbiPZuRWy3aeiqO_w5mHISZk
Message-ID: <CAKxU2N-bWXPHNgg2jLjZ8dUFQELr8RV3kWhKdSi8gKF3_9JRVQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: bestcomm: Enable compile testing
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 1:25=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Sep 16, 2026 at 12:47:52PM -0700, Rosen Penev wrote:
> > On Wed, Sep 16, 2026 at 12:42=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com=
> wrote:
> > >
> > > On Tue, Sep 15, 2026 at 11:17:09AM -0700, Rosen Penev wrote:
> > > > Allow the BestComm DMA engine to be selected for PowerPC
> > > > compile-test builds.
> > > >
> > > > The freescale ethernet and sound drivers now need a dependency on
> > > > PPC_MPC52xx as they use headers/functions from that platform.
> > > >
> > > > Assisted-by: LLM
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/dma/bestcomm/Kconfig           | 3 +--
> > > >  drivers/net/ethernet/freescale/Kconfig | 2 +-
> > > >  sound/soc/fsl/Kconfig                  | 2 +-
> > > >  3 files changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kc=
onfig
> > > > index 5dd437295964..153b5492c93c 100644
> > > > --- a/drivers/dma/bestcomm/Kconfig
> > > > +++ b/drivers/dma/bestcomm/Kconfig
> > > > @@ -5,7 +5,7 @@
> > > >
> > > >  config PPC_BESTCOMM
> > > >       tristate "Bestcomm DMA engine support"
> > > > -     depends on PPC_MPC52xx
> > > > +     depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
> > > >       default n
> > > >       select PPC_LIB_RHEAP
> > > >       help
> > > > @@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
> > > >       depends on PPC_BESTCOMM
> > > >       help
> > > >         This option enables the support for the GenBD tasks.
> > > > -
> > > > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/e=
thernet/freescale/Kconfig
> > > > index b34c0fcfddea..d81984fcec64 100644
> > > > --- a/drivers/net/ethernet/freescale/Kconfig
> > > > +++ b/drivers/net/ethernet/freescale/Kconfig
> > > > @@ -38,7 +38,7 @@ config FEC
> > > >
> > > >  config FEC_MPC52xx
> > > >       tristate "FEC MPC52xx driver"
> > > > -     depends on PPC_BESTCOMM
> > > > +     depends on PPC_BESTCOMM && PPC_MPC52xx
> > >
> > > use seperate patch for difference subsystem.
> > The issue is this patch exposes the issue. It's also extremely
> > difficult to get anything into net without the maintainers claiming
> > this is pointless churn.
>
> Maybe you try enable COMPILE_TEST for FEC_MPC52xx also
IIRC it compiles but does not link.
>
> Frank
>
> >
> > >
> > > Frank
> > >
> > > >       select CRC32
> > > >       select PHYLIB
> > > >       select PPC_BESTCOMM_FEC
> > > > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > > > index 04940879dfd8..101bc952aa14 100644
> > > > --- a/sound/soc/fsl/Kconfig
> > > > +++ b/sound/soc/fsl/Kconfig
> > > > @@ -234,7 +234,7 @@ config SND_SOC_MPC5200_I2S
> > > >
> > > >  config SND_SOC_MPC5200_AC97
> > > >       tristate "Freescale MPC5200 PSC in AC97 mode driver"
> > > > -     depends on PPC_BESTCOMM
> > > > +     depends on PPC_BESTCOMM && PPC_MPC52xx
> > > >       select SND_SOC_AC97_BUS
> > > >       select SND_MPC52xx_DMA
> > > >       select PPC_BESTCOMM_GEN_BD
> > > > --
> > > > 2.55.0
> > > >
