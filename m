Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794317635;
	b=M4cRksllJv+CT2477p7WnHGH3MQFvLNmouBH6jj/MDs/fHsQZ1LtYtKtTF8H9WKuCUHW
	 HwtssJaR2TToF5DXVlaO4tXGbd7u554wJjVgcYmNpQs4HfyNVPKilFGsOFnGwUwBs3wVK
	 BFu8/Eaxo6y1SgLddLaa7l0p6fgrSWrWiUePngBXWE3g1MvAYHGu7j2SPilOXseZtNOSs
	 9eFD4JE7iXwlvZV1ILag2IbJlUBPxLSHWJyh+q5lza6BFLB9Ps3r9MrC8kltHN0h+zBC/
	 p8KPHsmhNYpgJD9ofXSob2/E045XV2w7MdM31ES+fhg4W+emuOMD/79E3HpL1/CJFkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=X61eP2Ihn7qgYJ/jch6hAGpV6brxyelEfH9o/K5zbm0=;
	b=kyKtsjYLBWPf4b7a3gHj/AIn6nMZIj+0V6RysozBDoGuceV2jyPTUdoqUHULf/tWQIPz
	 3OQ+j5KZFppUr1Sjr2xhneE0EaiRSBWl5yXMQetY5DTaqHbrkVqDR+s35CFLZWMjVBYQR
	 6+05TRIPh9eahtcLF+Kc4fBHKeUGJ6AU5dQg3zvcuXGYWgpXw6n58sA9bUz6V2OOzWOO+
	 1UhdQI3ELl80vx5jSqBRHXzq+f6YwuGD9HRDrelU13YTqlbpr9+D/uT97EGuDATYyXSty
	 +W2K47oov7ncJ/efCcjtMwgKsCYba7N+6rjyfWBraB+G7MymsT3OOeVdp1RJODcoMsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ousVbo5T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF6606BFCE
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7EF6606BFCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ousVbo5T
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f14642adb4so1117759b6e.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:33:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317634; cv=none;
        d=google.com; s=arc-20260327;
        b=UAiULWtNWV3eU7rkvCFqg68NxYkJpmCjehIZQfncqxWSW537YCPhD6llgAJL3/f/mi
         8EJt8sRjkM47cvGiGZEkRjwUyHFO9jgaLXBwbDgg6ADCC9PDEdnCAVlOp4DrKIjfgZ//
         ajKL6L8njVek9o/j636kV5Z7Z/42A1phQj64cXnaDPTBlemq1KyjeBmTPfVdsXhTvcg3
         MahlIoOExk9u+X3URW8lbdPt0fALxvnGNeZCw1HKR5PWMZIlffZrpabzMV6o7+A36UrU
         SYeLfkx/CtpbaHatFAtLpqztCcr125Kfae4CcIvt9f0eyJyEx2HZ5uhiEzYC/fFnK6qv
         /PuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X61eP2Ihn7qgYJ/jch6hAGpV6brxyelEfH9o/K5zbm0=;
        fh=FACD9aQ6xnAUagvI2SsLS5xB2IQ/KQDM4t3LBH1/uQQ=;
        b=YR+y9cKKluEs81EBufi4l6UOxwG0QfH7azlRY7Rija9kxaxpyjZYIhFiXaLyG5B+Mm
         atj8Y0zkmXPdmQBsVLjqNolD+Wr2aZT0MbmCpKb5PSKNGOs44NzEbRGhQ9ngYoIqkPoA
         JS2hNPhpBD7Q/fkT89h+WTG5WshpJ16UhSwtn/8QqrieyHPe3Lk7g7OawhTfeDMTNbLF
         T9Cwegky1GxWNOZx4ywOVYlTHTETr9NQj5gZXOh2KzL51N5tLNg/J9suILlyf1+ECUbs
         9132jZcVO7G96ZDaDb6zXOttGj/+vLDJ1STHBSyI07rYYIjl5f5mp+51/kgl5W+B0fgp
         PBKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794317634; x=1794922434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X61eP2Ihn7qgYJ/jch6hAGpV6brxyelEfH9o/K5zbm0=;
        b=ousVbo5Tc9DHtDdynM/uFuJyGIu0s09bGCwGXcD3Wj6iDQMfNVsdn+CqPFGtVOcTnB
         5bKRk6Refz/qIeUA7DZzVZ0pxv4009+Fse+VV3ssr1csDf0pr8DjUPLLFPhr7wZqVcX7
         rY5Kp+tQWbcZ3ubHMSpsCvPqgOZK1uQGnq/ugZQTtr6cFEtrGUPwa6YsBjJNcR6pmSFU
         ysYMXh3VRKe0KZmSO4JcWRHS9OdeJ7E+RmbWRO761WiXLdSdODexWRwKjqY1SWoHaLo1
         sSWoRr0rHESgOJTykl3U5CoEU3LtC5dCaVYOfcTyw+3ypjj4UsJY4EwBO1xw/2/17Idv
         WywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317634; x=1794922434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X61eP2Ihn7qgYJ/jch6hAGpV6brxyelEfH9o/K5zbm0=;
        b=FCGmUhMPOW2zKTj8XpAZuFYMv1KGtFgQQlh6WROQdo4Zd0v3/yJin8kGbAROu8Vc4V
         6sqwPfb7N3cS8x1eHSk7w4uWIMedjNyTjCxlZfWuhoYdewh7XK1F7S+/nWFHusYrN8qL
         5snHgx9+6fFP5P8lIE6jPxOBXide8OhF5yeqmNMvwSS2eW3FK0syUFwmWtVAGpwQiuCo
         6FwyNE+LPjviqGbtOvEOA4NGEJHCPpFhFb7T1+wzQbho29JsjJ+bhGwT7+EZ59CSvDiD
         OLFZTEKyG57G8RkxFS3TUzHqoNcysWSxNmiQ1RwrtHglbO+aIYlThrgBWWVop7+httni
         4UnQ==
X-Gm-Message-State: APuU4Z+0XyXwKJcHIMrMMv/OezFXZVSgL+Fh/tFrsMC0MQODYPbPA8LP
	n9EnzG1eI94ENHqYhPmXatOIXksCFGMeaqEglCkS4nc1HlgdFXjYd3iieIq+kO3ncE1Fhqk84M2
	PAYgC841XEoH3/qk5h2OATN5lsACIxyw=
X-Gm-Gg: AYBFou0nGbZ+EDKtBKFq8jFEWhYLQWxDiYDogmYM9P8z/ZXwfezci0c3lJcITd9Rvr1
	52o6DKi8J3fCBsqapzrwDB9KmWcSDanvV2b00uU0EzkrCCP0iE8rhTWLRJPwCj8ZHibtnsIaRgw
	9Z4LW3N2uudBKPfqM5x6tnZQVtYSrJSlWq3fcI26/xLTb1A4xcDcqeBsoqucgL2fzYJ1y0FcXst
	0vYiNMiRMEvC73ZkrqpFoMCbwq7RCMd8S55K9NOXIxg0byL7pVV1xjXz5Iim1t+xFIfhKUgEIZv
	LVeu0Nj0O6f+2aqesyAIJY7CncP6wuGWTn5yxtO61rzDrvPBislsCI1tnBNRvGJtBaLo9lyLUke
	qIRh5KbJr9PlOOYPweXXtW2r/IfrK0laXthil9gTRgbtN0pvd9B2q8i13KNFO2BF5fo34
X-Received: by 2002:a05:6808:6415:b0:4dd:18c7:544d with SMTP id
 5614622812f47-5683c9d4bcdmr1886915b6e.31.1794317633794; Tue, 10 Nov 2026
 05:33:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-2-amaan.cheval@gmail.com> <179431229760.994134.9605192478932025271@kernel.org>
In-Reply-To: <179431229760.994134.9605192478932025271@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Tue, 10 Nov 2026 19:03:41 +0530
X-Gm-Features: AclHuK-uXx_1zJMXTZbtuw3oLLha1LOdSp4g6XMU_QQFDYEGasPY6t5aAdtAMuU
Message-ID: <CAG+wEg3+7SdyKxN=Uidg+RugMwmmedRibkTekOyAF3Kn-8eVcg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 5:35=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch is incomplete for GVE_GQI_RDA_FORMAT.
>
> --
>
> gve: block XDP on the DQO-QPL queue format
>
> This patch adds a queue_format check to gve_verify_xdp_configuration()
> that refuses XDP program setup on DQO-QPL. That check was lost when
> d8a8ca14c937 enabled XDP on DQO-RDA. The DQO-QPL RX page accounting can
> free a page that is still DMA-mapped when a redirect target releases the
> buffer synchronously.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba6331..4e9e692a0ed0a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >       struct gve_priv *priv =3D netdev_priv(dev);
> >       u16 max_xdp_mtu;
> >
> > +     if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "XDP is not supported in DQO QPL queue=
 format.");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
>
> [Severity: High]
> Does this leave GVE_GQI_RDA_FORMAT uncovered? The commit message says the
> check removed by d8a8ca14c937 "refused every format but GQI-QPL", so it
> blocked GQI-RDA as well as DQO-QPL. Only DQO-QPL is added back here.

pw-bot: cr

v5 addresses this here:
  https://patchwork.kernel.org/series/1205920/

>
> GQI-RDA also falls into the else branch of gve_set_netdev_xdp_features():
>
>         } else {
>                 xdp_features =3D 0;
>         }
>
> and gve_xdp_xmit() rejects it too:
>
>         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT)
>                 return gve_xdp_xmit_gqi(dev, n, frames, flags);
>         else if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT)
>                 return gve_xdp_xmit_dqo(dev, n, frames, flags);
>
>         return -EOPNOTSUPP;
>
> On GQI-RDA, though, every remaining check in this function can pass:
>
>   - GQI has no NETIF_F_GRO_HW.
>   - Header split is DQO-RDA only.
>   - packet_buffer_size defaults to 2K.
>   - GVE_RX_PAD is only subtracted for GQI-QPL.
>   - The rx/tx queue count condition can be met with ethtool -L.
>
> Once verification passes on a running interface, the path is:
>
> gve_xdp()->gve_set_xdp()->gve_configure_rings_xdp()->gve_adjust_config()
>   ->gve_queues_start()->gve_reg_xdp_info()
>
> On GQI-RDA, gve_is_qpl() is false, so gve_reg_xdp_info() takes this
> branch:
>
>                 else
>                         err =3D xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
>                                                          MEM_TYPE_PAGE_PO=
OL,
>                                                          rx->dqo.page_poo=
l);
>
> On a GQI ring, rx->dqo.page_pool is NULL because gve_rx_alloc_ring_gqi()
> memsets the ring. __xdp_reg_mem_model() therefore returns -EINVAL. By
> then gve_adjust_config() has already closed the old queues, so it logs
> "!!! DISABLING ALL QUEUES !!!" and turns the device down.
>
> Before that failure, gve_queues_start() has already set:
>
>         priv->tx_cfg.num_xdp_queues =3D tx_alloc_cfg->num_xdp_rings;
>
> and nothing rolls it back. A later ifdown/ifup goes through
> gve_open()->gve_get_curr_alloc_cfgs(), rebuilds the XDP rings, and fails
> in gve_reg_xdp_info() again. Does the NIC then stay down until a device
> reset? If the interface is already down at attach time, gve_set_xdp()
> installs the program, and every later gve_open() fails with -EINVAL.
>
> There is also a NULL dereference that only this failure hides.
> gve_tx_fill_xdp() uses tx->tx_fifo.base and
> tx->tx_fifo.qpl->page_buses. On raw-addressing GQI TX rings these are
> never set up: gve_tx_alloc_ring_gqi() skips the FIFO/QPL setup, and
> gve_can_tx() skips the FIFO check. That dereference would become
> reachable if GQI-RDA mem model registration ever succeeded.
>
> Would an allowlist (accept only GQI_QPL and DQO_RDA) be a closer match to
> "matching the features the driver advertises"? Checking for
> NETDEV_XDP_ACT_BASIC in dev->xdp_features would also work.
>
> With the Fixes: d8a8ca14c937 and Cc: stable tags, backporters may assume
> that regression is fully closed. The later patch in the series ("gve: fix
> RX page refcount overflow from the pagecnt bias") does not touch
> gve_verify_xdp_configuration().
>
> >       if (dev->features & NETIF_F_GRO_HW) {
> >               NL_SET_ERR_MSG_MOD(extack,
> >                                  "XDP is not supported when HW-GRO is o=
n.");
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261106114551.212675-1-amaan.cheval%40gmail.com
