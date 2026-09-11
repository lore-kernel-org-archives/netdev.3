Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275F20ED
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086242; cv=pass; b=uWWePODMAZVnL24//+MokFtxM6NgsTB0C9fxcxZ5fRHnuisdTI50eMqdf3jF9/r6z2fGuGEDztfoY5JtUZw1UH0YYklYlJb1vf00mCwrSR9W6Ldl6bTdOA0yA13yPPHFTmW86E4IyOn6FuuhF/5gf7PNMasEjUe20n1pjBp6OAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086242; c=relaxed/simple;
	bh=nmdKc/a5wnE8PDWAlKyr1buTBobwOO09KZmLFJnzqoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu7u3qbtSj98pBAkyBY3nMpIQBXUt/kbvnBy3vDILDG4B+IILlIrRAw11yNqpiL8x9tBDRfwXqYRvWlzGfwvACaU25HQzSdoNWjPyn75CmogTnIc3vq8p2bcJ41ZFutM+380HHJ1bGunGMTj/w1BKu4A/i0lDzs/H968j4Os6ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlGpdJLi; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlGpdJLi"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so21165ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789086239; cv=none;
        d=google.com; s=arc-20260327;
        b=o7KwBSRhwxJ6LkXbkh3gZnHxMeaJOSWu9tboAyhSMHZs3W56ePLdh8igfAr039GU4V
         a5ymmotjNhAH2ij3nM2+l+MlA22wfocdJYLPeOhKlnpYJ/+/A/ZdDajFV3WsnXudUW0u
         tUZzVCRWBzjQvbJc8skMy/Ym0YIyJaDwOo+QO7VGVZG2ejkmkboPUCUoJIvbT5Z4+jPf
         wN0wShrNoVPpW7/FK8ir5lrdjDNLuZGiOlTS7dj1vA3DlfkPQNy5rAbNUNbxhnkEPoj3
         bp/LqzyEJBl8z1pdWSB38VGKUQ5q2CKUKtt+BxGKmBAVN28S12ysJdT2jk25Z3rNe/Q4
         d+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqEdcnUoGpZiwMUleMzp5ubvFf8h672eTAjjjl3YB6k=;
        fh=tbZNW/+yd/aYY4xXSCzHlSvxAezAtCerzA4AUpUnXZw=;
        b=g+y7whWzM/JRGVRTXtXy0uUTtStU1934KDkcZ9fHUAp7barovYGzg3/FJDVj5ymguz
         fp2amBgqVWmls8/Y70tF5GKTu2vbJWGN9JW22JJ7hjt0ZMIbpKMjqBAi+IuztpYtW7Kf
         ftsA/9IZ8beSmJp8dGNLnVpPTfgv+eVTp9sIHS9H5QfiQ1ikxKeyEQMRjwnLvH38D78i
         QCZianVPYbGusFRqnmhv1mox+o+0jqMR2+hZNVPcNcxJkyuzgzEQMO1cF+SeXsugRZlQ
         d8Onz8CL3mxjsiZNG4tKYdVvHxX4ptHX4oOXcs/sJCBIQnnIMbGNBeUWjshQM4IUNaio
         C7+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789086239; x=1789691039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqEdcnUoGpZiwMUleMzp5ubvFf8h672eTAjjjl3YB6k=;
        b=VlGpdJLi4lUVoiBvcJWGAGO4NY33SuDUaO1V6CjjMq73IrClR7irJs7S/bK3tjCgrS
         +sUUuZTWyCrPqXr0axFZ3JpI4zSuJoowyd7P8q1MbMNA3fwGs4MWKcXVa+Bydk+1tB+N
         Z17a+n5QhmRXv/5NdhMXp6exlcXA3sxJ975OHtfiY17io3jWLiVfEk8MAbIDhUr3QGqz
         xpzmCs4v5j5hhA5KrhLgNl0hdrY3zekzA+7DBAlqchvstfCH+nXYkG7SGDHTyADoTE4K
         JFPXjTl/ahCbhEjtLICiTZoFmu2lNiZpQGrbrXC7K1MdxKl0MIWsm28wqWomiyl51qTH
         SoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789086239; x=1789691039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqEdcnUoGpZiwMUleMzp5ubvFf8h672eTAjjjl3YB6k=;
        b=Jq9u+JEfGQWaWZ00XFy0owiMb92MDHHAD/ae6UyX7btdu00K0g7DMPDeTO3Q4brjdc
         zjpWq05Uj+PdcTPv6/mOi47hbKSHpfE5J/nSiFFgQ5HDq8YNe2iWuluHUtXOYYusNupc
         rkEkPaXsqi+AOwBT2fql8p2TYcEyaZcgNimHJC2vN8L1Tp2t6hz2OpA042RuDOzqApZL
         i2fxj+ZEg82IvKxIXEdrUxy1blBkVnzoHgqhnvYEO7E4WzG45867k9qrhRnvvbcbt+tr
         T/zbd6r+ztWDXmrpFvpXXe+ui5end1Od2h48j4eavSwcvyfcHRgCNF6+EzPAyj8H31zd
         1i9g==
X-Gm-Message-State: AFuF++mlvQg4uUKE7VfXWRKYDr/h8+zuSgO6LlC/fhCDgk0zIw2FCm2h
	KIISD7gwg4CpUfMo88qT0cSdrbw3kmOrDLkO1TiQ2HIdRNfvSLV/JOa5xe24gY9ATB/Vr3btFlb
	nH4oTVcnjbVmLfJ194fds5x8xHEUQd8jWwKSuinlQ
X-Gm-Gg: AYBFou12OabJm4rF0ntceikSni/cWcM7jqff2yBL5RQXjgJIiIf0KdoBUvYCeGD1/zI
	K4a1G8gh1z0RJwDMzQ4uz0CegPDLWSxuEhul4VllZMrHlKgtfuikQil67sKD1VYrDGZ77nzVYx8
	qrkQvdorOW68qeOF4oLW/Z7AawLEw23HZvXAUHLmgAOPJiMJ74tfQzOr+3OcyuyQq6hPBuEdXHF
	JSRk8jMKuqr1xxptJ28c4AgDKQFV0c6OF5hnRLB4Lr3MMkZF6rsTwKWIWZRVTkx+mar3PfZIT8Q
	UwI0cftSVzv9hNMADhtvM98I+VcEuDxV67EYhgvDQeL3Zly3AVeXKADpKfxkUGgjtgNQspWcDvw
	doqdgmsm4EDpms7F/YdDacMX7aVWNuf5v3g==
X-Received: by 2002:a17:902:ea09:b0:2ca:6bf:5bac with SMTP id
 d9443c01a7336-2dd2ce1d368mr3248775ad.8.1789086238978; Thu, 10 Sep 2026
 17:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909191136.3811892-2-hramamurthy@google.com> <178907842956.219967.4077695444710153181@kernel.org>
In-Reply-To: <178907842956.219967.4077695444710153181@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 10 Sep 2026 17:23:47 -0700
X-Gm-Features: AcwNN1W7h8BCT1HfUY5jlvBtlhd4Vt-El5VfmDAA3SO96n8igRuwiM-3v0cCp9E
Message-ID: <CAEAWyHdw=W9P3OWwc+=wHe4-=kMKquRddkoSX9om8PW-mfjKjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/12] gve: add struct gve_device_info to hold
 device properties
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:13=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 2
>
> - [Low] After this patch, struct gve_priv still declares `u16
>   default_num_queues; /* default num queues to set up */` (gve.h:856)=E2=
=80=A6
> - [Low] Stale comment: gve_probe() still states "Features might be set in
>   other locations as well (such as `gve_adminq_describe_device`)."=E2=80=
=A6
>
> --
>
> gve: add struct gve_device_info to hold device properties
>
> This adds struct gve_device_info as a single place to hold the properties
> negotiated with the device, converts gve_adminq_describe_device() and its
> helpers to fill that structure, and moves the code that applies those
> properties to priv/netdev into gve_init_priv().
>
> A couple of questions on leftovers from the conversion.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index c280ff35ee771..021adb9108dff 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -797,6 +797,34 @@ struct gve_ptp {
> >       struct gve_priv *priv;
> >  };
> >
> > +struct gve_device_info {
> > +     enum gve_queue_format queue_format;
> > +     u16 default_tx_queues;
> > +     u16 default_rx_queues;
> > +     u16 max_tx_queues;
> > +     u16 max_rx_queues;
> > +     u16 default_tx_ring_size;
> > +     u16 default_rx_ring_size;
> > +     u16 max_tx_ring_size;
> > +     u16 max_rx_ring_size;
> > +     u16 min_tx_ring_size;
> > +     u16 min_rx_ring_size;
> > +     u16 max_mtu;
> > +     u8 mac[ETH_ALEN];
> > +     u16 max_rx_buffer_size;
> > +     u16 header_buf_size;
> > +     u32 max_flow_rules;
> > +     u16 rss_key_size;
> > +     u16 rss_lut_size;
> > +     u16 tx_pages_per_qpl;
> > +     u16 num_event_counters;
> > +     u64 max_registered_pages;
> > +     bool default_min_ring_size;
> > +     bool nic_timestamp_supported;
> > +     bool modify_ring_size_enabled;
> > +     bool cache_rss_config;
> > +};
> > +
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index f05f4895f4c74..512349c5517f4 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
>
> [ ... ]
>
> > @@ -190,7 +190,7 @@ void gve_parse_device_option(struct gve_priv *priv,
> >
> >               /* device has not provided min ring size */
> >               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> > -                     priv->default_min_ring_size =3D true;
> > +                     priv->device_info.default_min_ring_size =3D true;
> >               break;
>
> [ ... ]
>
> > @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct=
 gve_priv *priv,
>
> [ ... ]
>
> >       if (dev_op_flow_steering &&
> >           (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
> >               if (dev_op_flow_steering->max_flow_rules) {
> > -                     priv->max_flow_rules =3D
> > +                     info->max_flow_rules =3D
> >                               be32_to_cpu(dev_op_flow_steering->max_flo=
w_rules);
> > -                     priv->dev->hw_features |=3D NETIF_F_NTUPLE;
> >                       dev_info(&priv->pdev->dev,
> >                                "FLOW STEERING device option enabled wit=
h max rule limit of %u.\n",
> > -                              priv->max_flow_rules);
> > +                              info->max_flow_rules);
> >               }
> >       }
>
> [Severity: Low]
> With this hunk, the NETIF_F_NTUPLE assignment leaves the describe-device
> path entirely, so is the comment in gve_probe() now stale?
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_probe() {
>         /* Set default and supported features.
>          *
>          * Features might be set in other locations as well (such as
>          * `gve_adminq_describe_device`).
>          */
>         dev->hw_features =3D NETIF_F_HIGHDMA;
>         ...
> }
>
> A grep of gve_adminq.c at this commit shows no remaining write to
> priv->dev->hw_features (only dev_err() logging and a read of
> priv->dev->features in gve_adminq_create_rx_queue()), since the only such
> write moved to gve_init_priv():
>
>         priv->max_flow_rules =3D device_info->max_flow_rules;
>         if (priv->max_flow_rules)
>                 priv->dev->hw_features |=3D NETIF_F_NTUPLE;
>
> Should the comment point at gve_init_priv() instead, given a second
> describe-device implementation (MailboxQ) is being added on top of this?
>
> [ ... ]
>
> > @@ -1595,6 +1618,8 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
> >
> >  void gve_set_num_queues(struct gve_priv *priv)
> >  {
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> > +
> >       priv->tx_cfg.max_queues =3D
> >               min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks /=
 2);
> >       priv->rx_cfg.max_queues =3D
> > @@ -1602,10 +1627,13 @@ void gve_set_num_queues(struct gve_priv *priv)
> >
> >       priv->tx_cfg.num_queues =3D priv->tx_cfg.max_queues;
> >       priv->rx_cfg.num_queues =3D priv->rx_cfg.max_queues;
> > -     if (priv->default_num_queues > 0) {
> > -             priv->tx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
> > +     if (device_info->default_tx_queues > 0)
> > +             priv->tx_cfg.num_queues =3D min_t(int,
> > +                                             device_info->default_tx_q=
ueues,
> >                                               priv->tx_cfg.num_queues);
> > -             priv->rx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
> > +
> > +     if (device_info->default_rx_queues > 0)
> > +             priv->rx_cfg.num_queues =3D min_t(int,
> > +                                             device_info->default_rx_q=
ueues,
> >                                               priv->rx_cfg.num_queues);
> > -     }
> >  }
>
> [Severity: Low]
> Should the now-unused copies of these fields be dropped from struct
> gve_priv in the same patch?
>
> After this conversion, struct gve_priv still declares:
>
>         bool default_min_ring_size;
>         ...
>         u16 default_num_queues; /* default num queues to set up */
>
> but nothing in drivers/net/ethernet/google/gve/ writes or reads either on=
e
> any more.  The last writer of priv->default_num_queues was
> gve_set_queue_properties(), which became gve_fill_device_info() setting
> device_info->default_tx_queues/default_rx_queues, and the last reader is
> this gve_set_num_queues() hunk.  Similarly gve_parse_device_option() now
> sets priv->device_info.default_min_ring_size and
> gve_enable_supported_features() reads info->default_min_ring_size.
>
> A grep at this commit only finds the declarations:
>
>         drivers/net/ethernet/google/gve/gve.h
>           822:  bool default_min_ring_size;    /* gve_device_info */
>           849:  bool default_min_ring_size;    /* gve_priv, no users */
>           856:  u16 default_num_queues;        /* gve_priv, no users */
>
> Since the leftover gve_priv fields share names with live gve_device_info
> members, could later code (for instance the MailboxQ path) read
> priv->default_num_queues or priv->default_min_ring_size and silently get
> 0/false?

No, MailboxQ won't use these fields. Since this patch was already
quite substantial, I wanted it focused on the introduction of the
struct gve_device_info and its usage in the driver. I can send a clean
up patch later for this and the comment clean-up comment above.

>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 9cc343a162712..d3882de584e36 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -2507,12 +2523,34 @@ static int gve_init_priv(struct gve_priv *priv,=
 bool skip_describe_device)
> > +     priv->max_flow_rules =3D device_info->max_flow_rules;
> > +     if (priv->max_flow_rules)
> > +             priv->dev->hw_features |=3D NETIF_F_NTUPLE;
> > +
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909191136.3811892-1-hramamurthy%40google.com
