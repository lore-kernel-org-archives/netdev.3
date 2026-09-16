Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8943F0B0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588106; cv=pass; b=BDRjEoptg34H8QGmUU5zYO+mLftQUNA2W3pt1cmCbfMslkv5xVqvRqDXtwLZB7knq2U0Yp+W9YwfAwft5TSJ1NETZLeCqRGdcrJqzoMGPW4P969XcyhhBKvDmPjPjKiYxzZZvCNai3RDlhB5YyXWTWIlBnGRPFxP1ljQJFb4Uxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588106; c=relaxed/simple;
	bh=wU+5155qdUPgw7RyzztSXCOgYlXDyq4rSWa8o9Db53U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2t/BZsX7KNQBokJ9L0W9eWpeXX2/G29nH0ObHpt+CmqlsRnMLUJ8gQaqwCfAlznbOjNNpR+IQnlF0I27T8UE0cc33TwkyVg4pMnzPZHOql8P593k8JgsTZ3ePHX4NL+nfCJvtszMH3N1Tv6tJRDLojVmLzo6OhWup9EXzQmRY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3wCsWwr; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3wCsWwr"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso15618666b.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588086; cv=none;
        d=google.com; s=arc-20260327;
        b=VjgUbwZF59iuHnCDjheipIbkmVcMUh848Je2/LNrwtNAIQ51g08C+lJsIERH18Qp54
         gS8bLkuCOPloVQPki7KfTONaGwbpgr0RwMEjvgPub1L/3Wp6X7ck3NekMBTFfGr/XK9s
         iPAUdtdlr1MKtGvNqFJwBZjdYCimXz3XvRBwvaQSYk3eqCERvnQ4Bnni+jFBp0PAS4lG
         uo+T4yijLwKdcHUSAZfM5uLBb+Fa+zxLt5zYop5rGwxS9PHcquiWpbsTq8y3GvNmPU8S
         2Qg+ndDOoCvNKUL0CFx2ZzGowFsFXztZU5jmYe6IrvBzQQWMn1X1uXsfpNr0tSlQKXy+
         0KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUwNANsqCyAEnoTGeTMQrWBhCYCOT0fgfggYDa58xD4=;
        fh=breDwZTqHoIeVEsu71rfjdAVTuWFTTuPktNF/9+GozY=;
        b=d/lQ8tUo91FM1vBcMQtw2Sqcb9HedLSSMX/roBu1RaxQYqqodmYfta3nSBwumSx4Im
         GNDw/zRjE1V7h+s1KmLpHM88deHZHiClUMTeY2dbz+IRnFNONGcjYU+9Xism1m1yCl0p
         NIJbVVD++LrIBb1GijermbBjIiVWLzMzoeaPaE0X96OtCLmn63qv4vQV3qkwKdSS17um
         r46MCqZfGoTpIce8i77Q0mWmOzDHWjDwUUrmKcNDZTHHbS0zBxWic6NIenavhUwXP7tK
         wSfLu7W7YmDenstGDNXK4LRJZdvDvWAQgzQZ4q5rKlb21d7yQm8UcN/Eul4btGsez4D8
         PyGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789588086; x=1790192886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUwNANsqCyAEnoTGeTMQrWBhCYCOT0fgfggYDa58xD4=;
        b=H3wCsWwr/wqoeV/byKUorfvf1//TjUw+lUK7PZ9FoQIuayEavGD8iAfUto4Hkte2DN
         0ib2TCGLehY9/G9o5/uX6fhPxzN2r0AKAfWGA4owTHgu/Mkig9DY8I7i5arikNQgnp9+
         ypFKml4y2hCIXDS1sXJCgn9kca7+HjVMlMWduaCdE63pFw9FFc3mO3j7D4D8NLj1Xr9o
         e/Z05HuQtzAaWV9++IziI688FmAOUIhiuNOWbDMg3m1pnDq9yv1wQlSAltuU2lNX9Xop
         K6nXE051Mvv3w6GaUSZnrLIjH4qVI9L6AblZV6NQJuvwQQn0xkn1Z3WRcwfe0Xon7Wkf
         PJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588086; x=1790192886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUwNANsqCyAEnoTGeTMQrWBhCYCOT0fgfggYDa58xD4=;
        b=Bh1EsHFowRFabRXMIu6dufQBvcqyb3M4dgAFuUDeeJd2k5iKB9Muv+FMfg2O7O2oM3
         27J016hpbUqSxu6JbVSJO0agWPdP0MSqQgK4uet/30ZgJkM7JI9/+KWuqTXf+Vph2GhZ
         atnXShmllTrLFd12xOeaX1P6w1aOCZ5GclsPb2idf0z+wn0gyDAd1umdecqKISVbd42f
         NquKae6qphk7J+V6p9iA20xOg0EJXZ5nV668XAJlTxsilQ1iv1sECxH/hLxySTXcok45
         2g2GQNYsacQe2ZqYndGzfSCRav1ZV0fBhpWLLGYvzZpcRBnWPxuhK7gtuqRrYHCGn7Kv
         AndA==
X-Forwarded-Encrypted: i=1; AKwUvBy3pCDR9+HJtOqayM5Sjva42/Qbq+VT26L0A/x5EXHsP5rdh/3Ru/32z2zcdi/ZjaIcrAoZvyI=@vger.kernel.org
X-Gm-Message-State: AFuF++kvDaZdT2HChx4yjI+ZqZY8oNs/xtrxMxyMZ8KwPCJbfNLs6GXf
	p0oep4LlXjeR9GMsPO8npcrcqCkEB91leyyIdM3j7KgrI3k/jrn/yFegPxTab8+YAChwZpH9O1+
	2Y1ozyw2WY/9dvRDv5V+RKOn0pOf+JU8=
X-Gm-Gg: AYBFou3k3rBSmNrz/gSvjseTUIQVoGomCDkyzjcWl4jvejM0am6hjW/CRu9jwAELRdS
	3/1Gkf4VtnZWhyvP58l2Ol53rCMJcQU2NQfVkYBOf+pYArk4ZWsVUK60q4EONTtIauXkshrE46E
	Sgx1t0orB0MccZYsSd4EwNwySSK5fXFJDENt9Bbn5kzx5A0/ZO0S19HOIbEOUl3RRNA+hR2LYIs
	uVBcRRSNhj6nZoojKj1i3vCLgz2BTEizvEz88pZvr8omiFrJuiS4l/C/oNnTpTMa5ToJmjgKMj5
	qEn3knUI919Gp99wRlOW5hlLsOrEXxgkUH3+WZbenVUivGnLc5ZgVvH9vLmT8ozoR+oYAuqmLBC
	kGsV3z4bUBSLg0AvxQWo44N03uqXeFdfU14yO61RrSaHWTv+tpRnyxHNbVP2OL2ZL+0mDeWcghr
	SkGud7taGXFnF+f87It+4OQb0hP86SafQ/aZZiJ+3zHU7zmMzO0zKsI27fHEbt/v+wDg==
X-Received: by 2002:a17:907:c705:b0:c29:6400:ef8e with SMTP id
 a640c23a62f3a-c29e5413d2fmr269131466b.42.1789588085865; Wed, 16 Sep 2026
 12:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915181709.11323-1-rosenp@gmail.com> <aqrxFTWEsJmFIrel@SMW015318>
In-Reply-To: <aqrxFTWEsJmFIrel@SMW015318>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 16 Sep 2026 12:47:52 -0700
X-Gm-Features: AcwNN1VWEP860etYY_BLQbwSQ7HYCEYQgEcVWOM6xtWBlz1ixaj6SyE77I5cWWg
Message-ID: <CAKxU2N_zEA1NxAp6H6J6COjTwUv8NK909m3OZ2kcyVCpCby18A@mail.gmail.com>
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

On Wed, Sep 16, 2026 at 12:42=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
>
> On Tue, Sep 15, 2026 at 11:17:09AM -0700, Rosen Penev wrote:
> > Allow the BestComm DMA engine to be selected for PowerPC
> > compile-test builds.
> >
> > The freescale ethernet and sound drivers now need a dependency on
> > PPC_MPC52xx as they use headers/functions from that platform.
> >
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/dma/bestcomm/Kconfig           | 3 +--
> >  drivers/net/ethernet/freescale/Kconfig | 2 +-
> >  sound/soc/fsl/Kconfig                  | 2 +-
> >  3 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfi=
g
> > index 5dd437295964..153b5492c93c 100644
> > --- a/drivers/dma/bestcomm/Kconfig
> > +++ b/drivers/dma/bestcomm/Kconfig
> > @@ -5,7 +5,7 @@
> >
> >  config PPC_BESTCOMM
> >       tristate "Bestcomm DMA engine support"
> > -     depends on PPC_MPC52xx
> > +     depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
> >       default n
> >       select PPC_LIB_RHEAP
> >       help
> > @@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
> >       depends on PPC_BESTCOMM
> >       help
> >         This option enables the support for the GenBD tasks.
> > -
> > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ether=
net/freescale/Kconfig
> > index b34c0fcfddea..d81984fcec64 100644
> > --- a/drivers/net/ethernet/freescale/Kconfig
> > +++ b/drivers/net/ethernet/freescale/Kconfig
> > @@ -38,7 +38,7 @@ config FEC
> >
> >  config FEC_MPC52xx
> >       tristate "FEC MPC52xx driver"
> > -     depends on PPC_BESTCOMM
> > +     depends on PPC_BESTCOMM && PPC_MPC52xx
>
> use seperate patch for difference subsystem.
The issue is this patch exposes the issue. It's also extremely
difficult to get anything into net without the maintainers claiming
this is pointless churn.

>
> Frank
>
> >       select CRC32
> >       select PHYLIB
> >       select PPC_BESTCOMM_FEC
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index 04940879dfd8..101bc952aa14 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -234,7 +234,7 @@ config SND_SOC_MPC5200_I2S
> >
> >  config SND_SOC_MPC5200_AC97
> >       tristate "Freescale MPC5200 PSC in AC97 mode driver"
> > -     depends on PPC_BESTCOMM
> > +     depends on PPC_BESTCOMM && PPC_MPC52xx
> >       select SND_SOC_AC97_BUS
> >       select SND_MPC52xx_DMA
> >       select PPC_BESTCOMM_GEN_BD
> > --
> > 2.55.0
> >
