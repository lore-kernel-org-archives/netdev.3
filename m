Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D96432E88
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603829; cv=pass; b=SE5nQlGKKbIjztAGi77b6oolTIrpvyLYGFsQkztCK0BqKWUu7VY4n5YmAe8YutkdygCgaSmnLaUM/ZwUNS5n8eNmcQzRp4xbCMohPJObODRw4/6xl1gZnj5x0pDpFbOyBVe1A+U3nvE6osRvnD8URL3mS96zc3VgGYSZqMcgK1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603829; c=relaxed/simple;
	bh=dmKGCNnmqCpk7bmSNM2Jd2yQDm/4OjJULpJ+tSyr350=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiEtN/jhjJ6qfPqjicPWvjY2WwPWHxdkMGVpV/3GDZmPeudMUsARIaAKJo7KTIRa8Joq95PDifFN0+x+WPk1OIBYwE+j/tT8jWro3LLIRpXDVy9r/r8CfFI7UicI+aE2SCiUWrsOMZ5/jggYpvtPHw/lNu8SJAI+eYA5TP/5maw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=of0M24iR; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of0M24iR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efec2c28f8so12187426d6.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786603826; cv=none;
        d=google.com; s=arc-20260327;
        b=p5h/E1VI3xqpls3JuIlJztVeytwcjb9WkATKT+Ri0OZhqrFE0jzacpug88TpjCbYKp
         1RsMthuHB6bxVLTEfUT7iOctQGrscRtI6ya0sQ/ZMiPVd40TIP/2ZcwU25TpK0T42W9+
         AezZWi+d2N7NkGYQb1N8S5JJUFgnCd236uz7d+TNwgVea1Ojkt7pt2Cswl6lvZxq+TMK
         5EvxuGCvGDwvjVesDLzhOi1MjcoQVMzKBvBYqMHdLvszr1u5CVrYP718jzqdYAEu9sNU
         wZC5+ZxEEErdEw1qfj7O8cAR8gMdbNf4r2PrEl+G42jgbXkmP8W1gUoHf4V+3HZZE63Z
         b0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vQ/+J4iWaSr0QAaImk9CwK8bHeHUTPzax+SIIzoJ1RA=;
        fh=08Ye8S8ya6VZSqUiqU85gns/Qy4P+tdPMm73JSJgk/w=;
        b=ad7+f2LKDRrGI89Bp7qGk0JffPGKosxbQG9Kec/TNLvLHzjiP3luGTNpgelbKV0TX3
         Yjfa8FM4uUcP2DNswqbYfy26phfHpXQmpncqQ8PoWDxPHWc3YNAfKp398ELpw3icaaKz
         6k0CYy+vDX/tebaP0B5VXOX99RvUr6Wq3h2UuwClcFqHW1msoXjfFjKeU+7Pjw9vhGbX
         lzbb4AVt8CNJUoloFtQPIuL5cSMfibFCh4fQ+pSiIUirq9qrqBODigUIzTrmhCbD9+UP
         j3htvMUGo6f2Mu4n73NzO3ZSnxxX8+nxyJH0tG2QCEISOMlDIpBpBAuCuhejqKv4dHWv
         VygA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786603826; x=1787208626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQ/+J4iWaSr0QAaImk9CwK8bHeHUTPzax+SIIzoJ1RA=;
        b=of0M24iRwBMr5UzKI6tN+PbmvBhxSfNLSLTeTxazBJOfJFxgigRaPytCFppPXZcpGo
         FFy/hO5SS5HY/y9T0ZliSxGE3tXcNPKhMv+ZcuV2ZdfJ4mGUj7blfAbfucFPtS3KwR0f
         LmIz7TqJnXtsxeJMb6fJU9MiD3LTDC9D+5dRLCKZKH4erEd+CQj9hoMs2z1fSfLnsnzL
         nfkEla64mI/WYKe3lu3ZSVgwy/ywtuRnjSztxT5dqJXwudFNXGJ+q6Y1vifPO7LlNuiW
         ZGJsGY5eofFdEpfHxfnVOU9+BGbbMYFh+/ORW0SY/DpFOLOR4iPYWc3xrfi+qsOF7lov
         mmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786603826; x=1787208626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQ/+J4iWaSr0QAaImk9CwK8bHeHUTPzax+SIIzoJ1RA=;
        b=Q1Umvri/mzA9hSGZUpiJ2gtUT2HkVcZK5hmbt2bOqTQNZ34Vvxhw/cGA8KNa26v9Cb
         zjdzZZG/zFTYJmUwDAALHHCgiGxg/XL76rqcrkwYkcqa7JDFJlIPUrPz1dty4LuDwr8z
         N/6lr69HhbBYuMzES/5NfX4VOjHXpW40RbsfaZvGfZc8aMLSRzPQhIHnejx+66pwjkcu
         bWZKQH+QbL2U7IDqsdxeQqEdALNrojyHDgPgzuZW7+98GWQV23BiKm+MAwFghtol6/4W
         eY+Sh8KtfxNdukzwj6FO7sxc/qHTHZOsVcOPl9ENTasQ2ToDjreBXjpR7x7WejBxegoG
         B+9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqeODJYybI8cZOVloFDOEB8e5ytSpFLAnH4nRpbquBwEZbeUMej1JqgwETxyEVwVt6wW/iNEjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrsDOWKv/vlVykn8oQcOJWrkPcV7QqJ22CKPvAyh18RrQ02Br
	Eh8r9pJcVp0m7msF896xoQF4wM7PcC8sKoDsNMRJxHJOWNPIxtw+/UxEHVOqYD+Mda1udR8nSTW
	WR4EBnTpEq15ERDTQ34mspgCi3PW1D+A=
X-Gm-Gg: AR+sD13CFNn4oAt9dmbOq8eAK2Zp0vb9R0QkV2jcTQk5EoSadVXBWEldJwJ3a/DxcML
	F7H3iiPbp7MShOVYaWYmcf/3OuIzQhymnelGLnEd3Jx35cbj5/6hB34qYLRx6XDk+4jAF8VD6mU
	Z5afDR8OgAmkkcsnyJMep2YJ2k8f70/8CknyKNiwz5phj5HD1eQrnu3ybuVn8RrjEpQHg1+CgKf
	iywFSunFT6wpJ4TaPykmZEYMEmJs8PoXNAsbdkKRgI7Y/LoLFRuO808t9rsVSHCIL0gO1/w9R9d
	WcnUmB5kHU0NlEfc3wLtqTFxeHosEQRxrFweyYgZBVnU
X-Received: by 2002:a05:6214:3019:b0:90a:804c:325a with SMTP id
 6a1803df08f44-90a80a18dd5mr32786616d6.13.1786603826047; Wed, 12 Aug 2026
 23:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810100221.9166-1-zxyan0222@gmail.com> <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
 <20260812202027.976@gmail.com> <96146485-03f4-4c82-bb4b-9338b6591b2f@bootlin.com>
In-Reply-To: <96146485-03f4-4c82-bb4b-9338b6591b2f@bootlin.com>
From: zhu xin <zxyan0222@gmail.com>
Date: Thu, 13 Aug 2026 14:50:14 +0800
X-Gm-Features: AUfX_mwuR7TH-SyGnaiEE7b7kMzgyrxcbmtqcBBKgjZW-m2zIUMKpIqkp1nO7UM
Message-ID: <CAP7veT+fufSoBZBOQg+MQoGeedfzQBRtFrRPz8si2DJSJJ7NtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp
 interrupt support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	andrew+netdev@lunn.ch, richardcochran@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Wed, Aug 12, 2026 at 10:08=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> +Nazim
>
> On 8/12/26 14:59, Zxyan Zhu wrote:
> > Hi Maxime,
> >
> > On 8/12/26 5:10 PM, Maxime Chevallier wrote:
> >> If there's an interrupt storm, then this should probably be a fix for =
-net
> >> with a Fixes tag.
> >
> > There is no interrupt storm. XGMAC_TSIE was never enabled before this
> > patch (XGMAC_INT_DEFAULT_EN was LPIIE | PMTIE only), and
> > dwxgmac2_host_irq_status() masks the status with the enable mask, so
> > XGMAC_INT_TSIS could never fire. The actual symptom is that
> > auxiliary-snapshot extts events were never reported -- a feature that
> > was never wired up, not a live interrupt storm.
>
> Ah indeed, quite the opposite then.
>
> >
> > So I'd like to keep this on net-next as a new feature rather than
> > retarget it to net.
>
> Yes makes sense indeed.
>
> Can you take a look at the sashiko-reported issues, it spots that this
> could interfere with the timestamping on agilex5 (another XGMAC platform)=
 :
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810100221.9166-1=
-zxyan0222%40gmail.com
>
> Maybe there's some stuff that could be made more generic by moving them o=
ut
> of the socfpga code and putting it in the more generic timestamping code =
?

Thanks for the pointer. I looked at the sashiko v2 review and the
Agilex5 concern is real. On Agilex5, smtg_crosststamp() polls
XGMAC_INT_STATUS for TSIS in process context as its only completion
signal. The patch enables XGMAC_TSIE in XGMAC_INT_DEFAULT_EN, so the
new hardirq handler now runs on every timestamp event and clears TSIS
by reading XGMAC_TIMESTAMP_STATUS -- that read can win against the
poll loop, and getcrosststamp() then times out with "Wait for time
sync operation timeout".

On moving socfpga bits to the generic timestamping code: the
crosststamp path splits into a generic half (pick ATSENx, set ATSFC,
poll TSIS, read ATSNS, pop ATNR/ATSR) and an Agilex5-specific half
(GPO0 rising-edge trigger + SMTG MDIO system counter). Only the
generic half is worth lifting, and the platform-specific trigger
belongs in plat->crosststamp. That's a useful cleanup but may be
orthogonal to this race.

For the race itself I'd like your view on the fix below. The simplest
option I found is to mask XGMAC_TSIE around the cross-timestamp so the
hardirq handler cannot steal TSIS while smtg_crosststamp() owns the
snapshot FIFO:

  static int smtg_crosststamp(ktime_t *device,
                              struct system_counterval_t *system,
                              void *ctx)
  {
      ...
      if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
          return -EBUSY;

      /* mask TSIE so the hardirq dwxgmac2_timestamp_interrupt() can't
       * clear TSIS via reading XGMAC_TIMESTAMP_STATUS while we poll it
       */
      stmmac_mac_irq_modify(priv, XGMAC_TSIE, 0);

      ... arm ATSENx, ATSFC, toggle GPO0 ...

      ret =3D readl_poll_timeout(ioaddr + XGMAC_INT_STATUS, v,
                               (v & XGMAC_INT_TSIS), 100, 10000);
      if (ret) {
          ...
          stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
          return ret;
      }

      ... read ATSNS, pop FIFO, get_smtgtime() ...

      stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
      return 0;
  }

  /* every return path, including the -EINVAL default of the
   * int_snapshot_num switch, restores XGMAC_TSIE */

  static void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
  {
      u32 ts_status =3D readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);

      if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
          return;
      ...
  }

This keeps the extts handler unchanged and just makes "who owns TSIS"
explicit on the crosststamp side.

An alternative I considered:
  - making socfpga set STMMAC_FLAG_INT_SNAPSHOT_EN and wait on
    tstamp_busy_wait like intel: cleaner long-term, but a bigger
    rewrite than fixing the regression warrants here.

One worry: I'd like to confirm masking TSIE for the ~poll window is
acceptable on this platform -- extts snapshots taken during the window
still latch TSIS (just don't raise an interrupt) and are reported after
TSIE is restored, so they are delayed rather than lost. Does that match
your expectations?

>
> I don't have any xgmac boards to verify sashiko's claim though.
>

I don't have Agilex5 hardware to validate the crosststamp path either,
so I'm relying on the code analysis above. If this approach looks
reasonable I'll send it as a v3 with this as a second patch.

Thanks,
Zxyan
