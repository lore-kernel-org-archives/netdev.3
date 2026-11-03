Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694811;
	b=dP8DMBPp5CXbeNMEgpGxkSHAoDG4uLkIz2W5kNF2mduZIC/F2VXXUIOG/wGakc+5ViNQ
	 l7S6SmVgAENFEEWlhZCtqKSsZ/wHeab2Mi7EeAqSqTpJbbb9Sw3U0u34LdWtY16KcMeQt
	 iqEFcMsnHwAq7G54YcG+R9qQZkcJ3MsxR7UYLYUOiautGDzMjd0peXoVm8GoFA0RvamWJ
	 I+cFLHUPNzK3pVZPxdcLAnVpGFD+i7pThhhJYLSKmUoPbZHpT8pRchYlLZ6Z+PobM4Whm
	 UR0EDVfG0ogrOF+sNOGab55w/N2b9TbBhnOz+trlKyNJlCtTR85qyJzrOoXSnSKOQHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
	b=3N6vMl4UnrHLflEBArMCNK08tOiY7a7V/KvmZrHYZR2t6KsUcdavlYIiIYzywH1HWhhU
	 ywZBi/YNAGjVYelbojhINzVe9oWJ7ZtC+KI8QmtGaC7jLkxbdlMuCCCzRVK4pxX+9pCkL
	 dn+Iy5jJqXOFVG4l0Nxhxau6gdq2AVDRKZpmRkZp10yQQc2Ic34Wn/dgN8t9YfvIrkAVX
	 nu9kX3gqmeLhWovl8ELpc6xKFxPTUJpmSzIG+bJ6Y7mbL5L3JtaTGc0H6ZfH8fcqj3oN6
	 Oif2sNXhPlZ8sfk0TzuA50qYHwYlnGobqlxd79I5MihwkxsHwpKFXckHTScRGtiQxEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCg4RMQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D50606EE94
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D50606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCg4RMQo
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e95bd1c14cso35464745ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:33:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694811; cv=none;
        d=google.com; s=arc-20260327;
        b=MEoSN05s4GB13azZptOSNXy9qWrha12ZNcVgavJ0WfqY2aLPfkrI6lRvvtpAFoRngx
         jnWxPL2I52YKdudrRY3H+mx/v+ClhaQyaMusRZeX2IzDMupdn8UJJdpmeDWQQaDQK/Km
         D09FxJF6nJbeTis8CS6F6utoGQaZA2VQxDPen7TOqTlcqICV8gyyeqwCvLX2WXwaswTu
         w31MhU4RosumTKUWK9bIXw8M6tIoOLzbAnol6kI1S1Bjbh0XvteTGV8ie8RbMtJuhb8b
         D0oYI1OFv8LliT1y+b0SS1BPDPg1qYggyxoMYXnwS9Ps8tPHtn51Xog41WhM/Ovm7QcS
         bDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        fh=TIYJx1dImJddKjAeyZv/A1b9ciOXu+0w0tj5MOHanfk=;
        b=EBtCC0AI9clL+vbrPRtqTp/PBqaluI+K2r/mH7YX//1iGhUEDAivaG23Qiopg+WJ6/
         PXNUJMXOZrjargSNz3d3Mk3fd8YFRSA2xw13SpD8ntx9bYmfphMUcEc6iLdU+lc3spkO
         gDCNxgF+Ucjmb6hRpPrPeQH5HvDqkqBJ+OhNlBUqr1gAARdu2csGDBJkz1uQE4PrFBi4
         XhovqihwdAPv/fI1xpqtAj7m2YcvXyUgUjeo875P/Vhq2q80QC5t0gciIEaPpVVlgoIe
         vLWfmhlpOMJmnxqNCGRPvbNXdtDSsfJihaimmRp3Pz9FdjlspjJnmP2PLorJdgwpEHeN
         noMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694811; x=1794299611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        b=pCg4RMQo97Y1LBmF9lm1jx9L1k5JnwwSM15fQw+LIz8alJ19qoAMYYXufZTFjI0Eqy
         RJv2c+Czx9lyf9RCREUVIUGi+c7vYjBanaq4m4w1AJbkNpL61ZudlF+qUH3ECSEVrVeH
         d86tSN+PO9tOQl0FAmtqylKYxZJAaWtCohHIvbZCbKi6H9ttb52C/FmIZAU9LidxZueI
         kz5LF6BwX5bh35hsZEe/ra72Uvrs69TkLf8X75dFGl9ELV+nIn8/7dRaIw8LTz6KaPUt
         HhQsI9koa7T4MfEMsecjpjhgp3UP7YXQ/TQyJDlihffqbIEDsPUNumCJs/Le0V2+kHce
         Qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694811; x=1794299611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        b=U67HoRCSRsIhEuwY1HRmurzbjG+yDC12W+4VNemrscaSeR8X0QkK/2qg1yW9EvEQOE
         OLhfQud/6za17hZvSCdcsnKERdsAtekV99YGuH4DpPVtFGNMUYX1uiT9dYCYb8TWqffM
         i354jpOhp8scvG9CMu38f/SfjuEDu0PsT0PoCWm37BuATTUhr86wmWnAj9HNo/2uxsgZ
         PVMefDFFjHaFO8c1bhZBbKG5XHU7zOjUYfIwRYNJKrJWkSPVtwfqv5nxkvM8nt+HN01K
         CTlK9fLk1FToek9VqawteOiXtIX3OtBHWmx06f0CHdGwbqcs4Y4hPwBJzLmPQeA9lD6K
         +djQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/Slgfj22tUTz7MrLIP2ZVojyIZrVeRQcAV3k5IUFhBP0qH+8itbfsxPiE+pmodndag34ggTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bxJAqNveLDZxeSkZw4j8Mdw+yaDPCXer7xZfji6gH0xxlZ//d
	+aUkHFPRFYg6IZyDEXkznI//+h0fxF2wet+Pl3CWaklDD4VFbrlzc5HHvaxUNO5MXadQrC90ZlQ
	PI/+dYdYNknWmvQ4isf3bOQ5lcDGOEdxqnJVNXzy2
X-Gm-Gg: AYBFou1TyEOregPAqcqmJfIhCRV/9ghxEllbSn/zYDFNq+a3l2WBnzQeJ5gZQrG9iBr
	AjpFLct1h4OdS5bYOb0eW/Wd2c4Pun9IoR0phR4EQ4j0ApZ9I2nPB18sJUwW8kwmtJONI0Ilik4
	TycNFS4oqJKgEO+w74YSQFqivQ0Okcd7GoGxddP5hR+F0/orQ1sOD2hxVG6jGLxwyiRN2P9gpFK
	CPe5n5LqTILRxk7xQn0gxZOJhZ+VZAXim+aVC7s3VzKT2n/KLEusCUVVUicMM550kAom4C21bVx
	52EVZoVowrm7ptTTbyC5GQK0ty0WOcen0BtViA37uKrJjA/iRO93cctelGyRi+BaiY+xOnMwDxc
	Xs5FWaU3UUBFUslPYgkIDCsLMHWl/FWNRT8+1
X-Received: by 2002:a17:903:1c1:b0:2e9:6333:fbb8 with SMTP id
 d9443c01a7336-2eb364936fcmr122129865ad.12.1793694809842; Tue, 03 Nov 2026
 00:33:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-2-hramamurthy@google.com> <179365431852.3131.15974768163319773656@kernel.org>
In-Reply-To: <179365431852.3131.15974768163319773656@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:18 -0800
X-Gm-Features: AclHuK822Wf9DTeUoa6mUrIKemK_tfGKzjcfqPnGUM0p_VrNgJWlcfcDSwcas6o
Message-ID: <CAHwYsirZ8CpNL4QA_ie9EX6WCs=Waq9F3JsPXL+LYPjx=RJ7ZA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/4] gve: Fix race between stats query and queue reconfig
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

On Mon, Nov 2, 2026 at 1:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] At this commit, the new priv->stats_lock is not taken by the
>   single-queue (queue-mgmt API) writers of priv->rx[idx].
> - [Medium] At this commit, the device-level qstats totals drop to 0 once
>   the interface is down.
>
> --
>
> gve: Fix race between stats query and queue reconfig
>
> This commit adds priv->stats_lock to serialize the stats readers
> (gve_get_stats(), gve_handle_report_stats() and the per-queue qstats
> callbacks) against queue teardown in gve_queues_mem_remove(). Queue
> pointers are now cleared under the lock before the ring memory is freed.
> The per-queue callbacks also return early when priv->rx or priv->tx is
> NULL.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba6331..26fdd22644f4d 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -69,6 +69,7 @@ static void gve_get_stats(struct net_device *dev, str=
uct rtnl_link_stats64 *s)
> >       int num_tx_queues;
> >       int ring;
> >
> > +     spin_lock_bh(&priv->stats_lock);
> >       num_tx_queues =3D gve_num_tx_queues(priv);
> >       if (priv->rx) {
> >               for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) =
{
>
> [Severity: Medium]
> Does stats_lock cover every writer of priv->rx[idx]? The single-queue
> restart path still rewrites the ring contents without taking the lock,
> and priv->rx stays non-NULL the whole time:
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_stop() {
>     ...
>         gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
>         *gve_per_q_mem =3D priv->rx[idx];
>         memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
>         return 0;
> }
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_start() {
>     ...
>         gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
>         priv->rx[idx] =3D *gve_per_q_mem;
>     ...
> abort:
>     ...
>         memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
>         return err;
> }
>
> These run under rtnl and the instance lock. gve_get_stats() (via
> ndo_get_stats64) and gve_handle_report_stats() (from the stats report
> worker) hold neither of those. They only take stats_lock.
>
> Suppose a devmem, XSK or page-pool queue restart races with a read of
> /proc/net/dev or with the stats report worker. Could the reader then see
> a partly copied or zeroed ring, including its statss? It would then
> report torn rpackets, rbytes, desc.seqno or fill_cnt values.
>
> The readers only copy scalar counters, so this looks like wrong
> statistics, not memory corruption.
>
> The later patch in this series, "gve: Fix backward stats when interface
> goes down or configuration is adjusted", wraps these writes in
> spin_lock_bh(&priv->stats_lock). This patch is tagged for stable. Would
> it make sense to move that part into this patch?

Agreed. We will move the spin lock to this patch in v5.
>
> [ ... ]
>
> > @@ -2786,9 +2796,15 @@ static void gve_get_rx_queue_stats(struct net_de=
vice *dev, int idx,
> >                                  struct netdev_queue_stats_rx *rx_stats=
)
> >  {
> >       struct gve_priv *priv =3D netdev_priv(dev);
> > -     struct gve_rx_ring *rx =3D &priv->rx[idx];
> > +     struct gve_rx_ring *rx;
> >       unsigned int start;
> >
> > +     spin_lock_bh(&priv->stats_lock);
> > +     if (!priv->rx)
> > +             goto unlock;
> > +
>
> [Severity: Medium]
> When the interface is down, this early return (and the matching one in
> gve_get_tx_queue_stats()) leaves rx_stats and tx_stats untouched.
> netdev_nl_stats_add() then skips them as NETDEV_STAT_NOT_SET. At this
> commit gve_get_base_stats() still reports zero:
>
> static void gve_get_base_stats(struct net_device *dev,
>                                struct netdev_queue_stats_rx *rx,
>                                struct netdev_queue_stats_tx *tx)
> {
>         rx->packets =3D 0;
>         rx->bytes =3D 0;
>         rx->alloc_fail =3D 0;
>
>         tx->packets =3D 0;
>         tx->bytes =3D 0;
> }
>
> After some traffic and then ip link set dev down, does the device-level
> qstats total drop from the live counters to 0? That looks like it would
> still fail check_down() in tools/testing/selftests/drivers/net/stats.py.
> That check requires every qstats key to be non-decreasing across ifdown.
>
> The NULL dereference is fixed, but the totals now go backwards. The next
> patch in the series, "gve: Fix backward stats when interface goes down
> or configuration is adjusted", seems to fix this. It folds the ring
> counters into priv->base_net_stats and priv->base_ring_err_stats in
> gve_queues_mem_remove() and reports them from gve_get_base_stats().
>
> Given the stable tag, is it intended that this patch alone leaves the
> qstats totals non-monotonic across ifdown?

Yes, this is intended. This patch focuses on fixing the kernel panic
and the next patch addresses the stats values across ifdown.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen

---

pw-bot: cr
