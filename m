Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112711;
	b=z5dulgg1wb77oOFcEO0Edu0kuLUnQ0Ds3u/O4F31Fwd1YUGn5gRM9y94rJ2V0tqcWoyW
	 Zcl1/9WK15kr5Grnxiw61CdY2eU8XESYBP/w8IC1Otr6Dw6/3GOtaV2Ki90zJ9mQjwSVP
	 5k6PoEdWWMPsqoDzMPLAbbSd6bcCwcjEUNjnIsF6R51xQktsjEg0IIqLPvj9pQLL63NM9
	 uDcAUMErKwmvEnmZOtj2mSESHCAJEXtVIdfoXrxMA+BuKA5tHRw1JUg/9dHhhSFlnBjXh
	 q450qEv8i0mqoajk+riGaHWs1eudv8KcYxpSvBL3N6+bNrkIuOxLmMZDBu689/PSwtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OKc4Bh4uFk3DkEm+qqx5OjnbVTtIfi1KH/DJQhTslQQ=;
	b=y6iINrcNL1yv+Ce9EWDCwvl8b+osy8qaRFsJeB/HiwHZLTgRViKS7MrhHOmYBF+6wnv5
	 Px70Pi3HX6BPa8gjoQdKtGnwFCnoHI0hfmer3PaMC9XjiTEbNQZojtpXtB/1C7429w/CE
	 TshKHTXTuJy7bU+BSAjekVIpeNUZY5DbA061P3PqEG0NnniVxzOrgrmX1tfKV06Zrlh3x
	 LkPFgQg/fRkH3AhYc/Lm2TouA5x1ke9UNwDkdv81fn1/NA2LW6rqxE/FyOhdOk+6fB+iR
	 T3QuGeJvuzcww7Ayrv66E98EFRYCgWvMjpDjaM+8yia4JsB+z+2R4Tlyew4AWGcurkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jl3jPQ3D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F9606A327
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2F9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jl3jPQ3D
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so3175693a91.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112710; cv=none;
        d=google.com; s=arc-20260327;
        b=p44lFBn/xf+sEl2gW3JLotzs7RxnkmhbIvfrvr2oBoYC22hCC3P5QzQQg8q4zGVzH1
         3YiMcri0Zo8ukfhQcXbfxst8SvitmhaRBSsFY9x/CQonvI4n0ZPO+ZmLE+kqB+4RCX4A
         uDzBsnR34ky3TPCz1US6+8MdKv+31LcFiwlUpRasNXJzX5MOwnndX6V8Nc12zgPdj4QS
         Ts0/76KkBWHwRKeTgrbzqVKn4AURIIN0x5BbIVC9yKmOnzt9ZeCA9UVlS43FuJg4y1lh
         /a1/IZfA4padJ/ilFL45tigwSnQpyH+5kr+qIbh3tCBNcjpwmYh7RLjtEhq65jZEzjXo
         99ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKc4Bh4uFk3DkEm+qqx5OjnbVTtIfi1KH/DJQhTslQQ=;
        fh=/y6KcYhW1PiyDOu1MxEAly6YwvXnGWSQRTXmIr4GJxo=;
        b=L7znVn658zHkC4VhufBL9iGL+GQIgRC1rY82ySLr970PJNPaOYfKLFK1DhaTOiI1yZ
         y0QSrUkd/2pEVK8xcuaSydzC+pFEC57oeuUyVCqMQgUFf/dhIcLWQInOQ6ghnZuH/g6P
         tkhPCcf0xezIkxJIMsQaXwpGap7jDpfyOXO14lL3fjnix4ofT/UxpJ6wZbOYBhzsLQKG
         bu06pNhm66luz8uXOLDDwShF3CXGkwHUw4uf4VFi/Zii5rxkH3Pk5POiZnm5UOykQg0i
         3CDXJ5yTlkqSdvjsHGm1+aqPG4AGNBGIwi1uo+HyyW5pjIGnt/H0NDKJ8VVqgqhB24yD
         tfXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793112710; x=1793717510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKc4Bh4uFk3DkEm+qqx5OjnbVTtIfi1KH/DJQhTslQQ=;
        b=Jl3jPQ3DUZZn2ZfL42bDRJ7yAwcT8Z87mlygeaL9LSUUXxJ8fiW1Y+oKIHYWxeWxhA
         phw9fDYNGxv5zcJTemASKS7/Z5I9hIwQkxfdi3kqE8ibg0HMUcOq1019RKKOL50P433f
         qUDe2PmN0g9N2JH+Zt36GH07pOAlEv1qEDHcLd+nAQ4X9ej1MG5NNh4YSYl6A3q1v/aY
         N/fxwl2pzaQEnAUmqcRe0GRxPDc7jxvUi80PjRpNwvaRgRL2zp4ziV2AZzRCzLFa918W
         obA39r/1Q3K2/sSKM1nELt7Mx6G/JH5zVVerDILoycvSxKFRoS8YvNTKQMIBY7mX8cBY
         0fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112710; x=1793717510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKc4Bh4uFk3DkEm+qqx5OjnbVTtIfi1KH/DJQhTslQQ=;
        b=NfQVlJo6DkXJw2ZW+3xS5pwRvU0GOg5OyCDZ7JV8+3vsF6G9EgOVVVtQsZrkJmdsmh
         3qykTcnPm3G6tU4jywF1tSxr4ZpYiT7HJ39nQdtArS63Df+AucSVBVuhWQutUI/KHSeG
         sNDWL6j80W9xcWYgAQJTfZkEjfo38yIjtFXEq+CUWxZJWJtqYOAMNujtIkuNK8HG4iL1
         E44SCEE/J+4yTrPbUkFI1J4nONtFl5Ne/KKGrMVmfcSj8OaTvKD/SeBtnUjVuPArF0oE
         XloFGb7J+PnV6MfJFPFEdt36DuPDdP1otOG7FYestXy7c2cFRzm1uRgvWLQbmjILpxQs
         RgsA==
X-Forwarded-Encrypted: i=1; AKwUvBw4nQtPb0H2RMfmNSQol8Xgll/mrMUtIAGLk0FeGjE6TJDDk1ihr/srTn1NmPBH6lGm99QrRns=@vger.kernel.org
X-Gm-Message-State: AFq9FYKigbCQTAm18u998OIc2lvZFuEl1xsJmDFLoIf/3MbnhMNtP96s
	l0dJdR68HwcIKO5ngHuagUV/lGBnQGQ33XdWOUBWRMlE1DUg7nq0qGV2rzZUwkvptN+XdcLvWuz
	NMmW8eNDk9WqCTaunicImPJfmKuZrI3tj66FlT40/
X-Gm-Gg: AYBFou2y3LgyyGeSMO7O5n+SPJ+A8M6bohByURUf1g3Vlh+gCDH0vii8qHleGCVY/Aq
	EREf8Lh3vdnuyNJYA9w0oY2/O/8xIIftYPBjpCn8X1p0v8aAgNUN8X4HXKAIY/siuHevGb2MRVf
	2js1glhbm/K38WXTFhOqPYHMKQdMlli2ZbUr0PHJD5Ka1sVY3h2cK1DjtissAZVJR3rl8dyyJi2
	SjCCTfUqN2WPpVgMBottsNlB0AEqxg5gtRbro8Kso4eYUbrN5DVZW2vucswJ/xfKDmjGt48PScf
	8bGmAU4Od6QCDouQIF3HiDDtcJBwv6ua2famQFcKX5hFU3U9JYs1MCOIuuMvANWzcjeIedkvg8l
	xn73Wh0nvffDg9/iZxhW1mQJWd3oKzR4t0HF0C6Fv+K/afNPMJfIGJLhxBQJn20im98VOy0Y=
X-Received: by 2002:a17:90b:5105:b0:3ac:9176:e81c with SMTP id
 98e67ed59e1d1-3adeae76765mr8659776a91.46.1793112709541; Tue, 27 Oct 2026
 07:51:49 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023204706.3112215-3-hramamurthy@google.com> <179306532583.3134.7567788102217743644@kernel.org>
In-Reply-To: <179306532583.3134.7567788102217743644@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 27 Oct 2026 22:51:37 +0800
X-Gm-Features: AclHuK_r134DQq9f-MM94YPe5SSEL_CL1JSycuvsAHgd8vqn87yNzLMk2J92-zA
Message-ID: <CAHwYsiq0v7yLAjh6fkmhckZHL4q80BOk9fVT1chuXwk_kGt8Cw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] gve: Fix backward stats when interface goes
 down or configuration is adjusted
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When XDP is attached, the new base snapshot counts XDP TX ring
>   traffic only at teardown, so device-level netdev qstats tx-packets/tx-=
=E2=80=A6
>
> --
>
> gve: Fix backward stats when interface goes down or configuration is adju=
sted
>
> This patch keeps baseline rtnl and qstats counters in gve_priv so that
> device statistics do not go backwards across queue teardown. Ring counter=
s
> are folded into the base in gve_queues_mem_remove() and in
> gve_rx_queue_stop(). gve_get_base_stats() now reports the saved values
> instead of zeros.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 26fdd22644f4d..52c152a986eb7 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -646,6 +688,9 @@ static void gve_queues_mem_remove(struct gve_priv *=
priv)
> >       gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> >
> >       spin_lock_bh(&priv->stats_lock);
> > +     gve_get_ring_stats(priv, &priv->base_net_stats);
> > +     gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
> > +
> >       priv->tx =3D NULL;
> >       priv->rx =3D NULL;
> >       spin_unlock_bh(&priv->stats_lock);
>
> [Severity: Medium]
> With an XDP program attached, will the device-level qstats tx-packets and
> tx-bytes jump forward on every ifdown or reconfiguration?
>
> The TX loop in gve_get_ring_stats() goes up to gve_num_tx_queues(), and
> that count includes the XDP TX rings:
>
>     return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;
>
> As a result, the full pkt_done/bytes_done history of the XDP TX rings
> ends up in base_net_stats.tx_*. Those counters are updated by
> gve_clean_xdp_done() and by the DQO XDP path.
>
> While the interface is up, qstats never reads those rings live:
>
> gve_queues_start()
>     netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
>
> netdev_nl_stats_by_netdev()
>     netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
>                           0, netdev->real_num_tx_queues, &tx_sum);
>
> So gve_get_tx_queue_stats() is only called for the non-XDP TX queues. The
> new gve_get_base_stats() returns only the saved snapshot.
>
> The qstats device total therefore leaves out live XDP TX traffic. Then,
> when gve_close() or gve_adjust_config() reaches gve_queues_mem_remove(),
> all of that traffic shows up at once. gve_get_stats() counts the live XDP
> rings the whole time, so rtnl and qstats report different totals while
> the interface is up.
>
> The netdev_stat_ops kernel-doc says get_base_stats "can also be used to
> report any miscellaneous packets transferred outside of the main set of
> queues used by the networking stack".
>
> Should gve_get_base_stats() also add the live counters of
> tx[tx_cfg.num_queues .. gve_num_tx_queues())? The other option is to
> limit the teardown snapshot's TX loop to tx_cfg.num_queues.

We will make gve_get_base_stats() include stats from the XDP queue in v4.
>
> > @@ -2844,12 +2901,22 @@ static void gve_get_base_stats(struct net_devic=
e *dev,
> >                              struct netdev_queue_stats_rx *rx,
> >                              struct netdev_queue_stats_tx *tx)
> >  {
>
> [ ... ]
>
> > +     spin_lock_bh(&priv->stats_lock);
> > +     rx->packets =3D base_stats->rx_packets;
> > +     rx->bytes =3D base_stats->rx_bytes;
> > +     rx->alloc_fail =3D base_err_stats->rx_alloc_fails;
> >
> > -     tx->packets =3D 0;
> > -     tx->bytes =3D 0;
> > +     tx->packets =3D base_stats->tx_packets;
> > +     tx->bytes =3D base_stats->tx_bytes;
> > +     spin_unlock_bh(&priv->stats_lock);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023204706.3112215-1-hramamurthy%40google.com

Regards,
Pin-yen
