Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C34E3EED
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744306; cv=pass; b=qnayXGBa6Sp77WKZhNFvLj1Bo4djg8uKR0PSL1kqB9hYesCL7Y1UD+11ckcXxayOLvf/mVLbkprkzYIWZABic8mMQ0ildRGax95tcaqdvm4SNVXCtH29MyHOSaKW6vR8l1a4X/E+aGjOTvg/VNRpag8EBbZIcYebgP+2fmd536U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744306; c=relaxed/simple;
	bh=ySw2e0Slxah83INbdyRA/uPg8EPZAU+tZCCTjZwh/j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTUe4Y5s6lUo+G5GRSYBbl06edBVzlI0iVQB2urRYGlMlQ8JsEGl2+04zA+HfUF68ylbpTaeVOdfVfBDIb9K473wwPq41/63rSeobjkWESifbGkFLUj/2JSmeLLqzsss4Yw2VAfUWbchVcw5HGHUTyxzlVBeowIJ4xWjJZfOUqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qze27Prb; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qze27Prb"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ece3so664883f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789744302; cv=none;
        d=google.com; s=arc-20260327;
        b=WKI4ZeByOHfyubrHc/bmbBTpsp0KdqTe9bOOQNneN8Cxsd3sx1aB61bWdnNt1BgeSF
         VA3n++nCV6TmeFacjG/VX9FJ93zoevN0iGS4/wf/5a8IbapQQFrpyCM42AYOd7xMnODD
         vHmdZtDeNHDGCyY4v63iAGMkGTXLvTNXQnkTZvylQb6TkR87kYtro0A1Wjx03xX3PIIA
         yms56D7se3c1v6nG9NXkk7H5Du33I4yRNy2b+ks5X3MmC+2cbxU8HeDZX2ekVy0lql8j
         6eAmuTcXcaUpDBCC9soHMP5MgqWscP08Nve5ZW/x6CTNbK951ItFhANDlg69LF3w7oeP
         f48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VU2Jlhzin4gyTLOzmJvgLL1JCVYLZchV+1XJwH3G60c=;
        fh=iV6JIq2XCdEGzMbsv/k6Vz5yMtQ5WvkueSO8IP3csDg=;
        b=Pu0jp60GEaasPP7AK5R5Ty7oMwYVbaIZKwYPhr0Hgb+Qx5dIJYRf1GgY306U4k3PWc
         TLaGVCEpyYWYNOYbBs0+RKUKbkvvgMHZHW8L7mPlv40VpQoqvKKRG5195jukSzJWdEl6
         IqS4yHu9jDaxIC109P5u/YZu0d0SStRZtOAaAeV++nYUhnott0Rx5F1edhIhe6fRX0k2
         rsOQVgH6S89kAx9r2ZtD8qgn7QRcOplafjXx2IM51uUQJlxpZv6FBRizBYMCB4GhrLFv
         6YbZYdFgFkyoYaABWZX6MmCRFZE9Hn5XbMpK3Ej+ohM0NgS2bZwgk8pqjT/M+0NMBt2z
         E4bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744302; x=1790349102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VU2Jlhzin4gyTLOzmJvgLL1JCVYLZchV+1XJwH3G60c=;
        b=Qze27Prbiky4hSMR+I3lxHfdfM9W0TGYCI7tBsXqxIdd0A+hQIftPtiZnyJbIuo37x
         GSXmcHXpH6s+ag6ofPREMiOVeCfOZqN2AfNeAKHBeSZ3LgGQ1PNVQ1DTREd+pTmZ9dbF
         ybaB93mrmMgWlZhMXvqhc0spKmU5q1/8V8OsX0xd/pUzS0jlj3cz/8IUS6+AsqrOlVQx
         OOOZrrgOc/IuJ9XeA+dcUnlu3SaIO75rIDuaW5iTvI9LpWsKWMsYM7B5lgDh5/yDPUl+
         eZ5DDiso60WaBUV8BIA3XY0+hJ2YR5l3PmkduzK3Q8FTSgu+ZTq3pLEf99I0WKPXg06N
         2dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744302; x=1790349102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VU2Jlhzin4gyTLOzmJvgLL1JCVYLZchV+1XJwH3G60c=;
        b=scWsgRyjzx0ZrqSDJTsh6uHOKhj94cClvpew6E/zgd22oNXdjvctlWblBK/vHYAoqm
         0Ei2RGijE59GhkWNAZmnWV7SJMG2XDe7rt9TIN6NfngNN9uC5pKxqYPEbkzXsFGB64cU
         xFvyj1VW8Xkoe5G2zf0NkfqB1bJMleKgNRH361wZ3CSNVW3xZ5EN6ZuqPbM/IAwvUtd4
         hj7oXsOH4q08W3aGdadNgzh6lObICrrDTgPXQnsEXNuKOosaI7Glv0I65PMgeWggIYgT
         CnWlIFi5aeh3a603YSVl6kXOZschSzPm2nk5GU8coGNahT3NGTQmYs81QQ7+VztgFuGj
         PTEA==
X-Gm-Message-State: AFuF++m/uSkHZ0omUnHLE572+GXVH2rl6tenTZxp58rRInB0hByDt90z
	A2N56t3DtoebZ1ACsbvXZ7gbSOILdaaV8Mo7Egd4ZdWaVM0JYmtWAJAVeO7Gjvt6PIS6J5bD9Mc
	k9XdEyTEzktgIxkLgbVMN3Leyn1U1lHY=
X-Gm-Gg: AYBFou3VIhgP5LfmbSkXGO4LfOHms90vGm0GJUFL38ORl2UfVwVt6r7qWN16Ew6d3oF
	kOlDwR6cVKVUEZtqn/xEEXiVUCjvSsVUHpF0H1WVv4eomW+M0tzTe76I+AV2N4GWYsAuEwypNtM
	Cr+If1hrAJ0SuCrRR1tbg946Q0ZfUw9+H+rhTaHMIoTrmYwTpwlpv1Nmp523QGUM2FtNFr2fCjs
	X0mBQ1aXdkrdcMoU0q09kVbCAx/75z5Kbr6nemt8Xb/fB219IicF8dpCPdadkLKTX/pEMNLapGE
	86pzNde2ziH06A/im97MUZhfQBqIcjBUCuIWoneBIxCwEGSePMsQYXjsvzZJeSFD4PadVegrTd7
	ND9L4+LMfZiNBazPLc5eUNpbhRZJ9EXAbbR8XfhiUE2FQJQIXfKcH6QXORWE=
X-Received: by 2002:a05:6000:4904:b0:486:fed8:8710 with SMTP id
 ffacd0b85a97d-4871e367d9amr4141891f8f.38.1789744301914; Fri, 18 Sep 2026
 08:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
 <178967952944.22033.10329187569173798096@kernel.org>
In-Reply-To: <178967952944.22033.10329187569173798096@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Sep 2026 08:11:04 -0700
X-Gm-Features: AcwNN1XB5A7RvRJrcSW8lwP6JajSBBLVW-ot0M9hzx4CsY1sQxnMnMcKGDL8dgE
Message-ID: <CAKgT0Uf2xJr5hD_yAtNg67-2t5XS5d-QBf+gPscPJe+L1Miydg@mail.gmail.com>
Subject: Re: [net PATCH v2 3/6] eth: fbnic: use the Rx queue napi pointer to
 find the napi vector
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:12=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 (2) =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] The invariant the patch relies on - "The pointer is NULL exactly
>   while the datapath is down" - does not hold across PCIe=E2=80=A6
>
> Pre-existing issues:
> - [High] fbnic_queue_stop() uses nv->qt[t].sub0.q_idx as the queue
>   identifier for every triad, but that field is 0 for two kinds of=E2=80=
=A6
> - [High] fbnic_alloc_qt_page_pools(): when the queue has an unreadable
>   memory provider, the second page_pool_create() overwrites the local=E2=
=80=A6
>
> --
>
> Here is the review report.
>
> eth: fbnic: use the Rx queue napi pointer to find the napi vector
>
> The queue management ndos stop deriving the napi vector from
> fbn->napi[idx % fbn->num_napi] and instead read the association that
> fbnic_set_netif_napi() published in netdev_rx_queue.napi.  A new helper
> fbnic_rxq_nv() performs the lookup, and fbnic_queue_mem_alloc() returns
> -ENETDOWN when the pointer is NULL.
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net=
/ethernet/meta/fbnic/fbnic_txrx.c
> > index 81a30e2d449b2..e93174fc1239f 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
>
> [ ... ]
>
> > @@ -2829,6 +2830,17 @@ void fbnic_napi_depletion_check(struct net_devic=
e *netdev)
> >       fbnic_wrfl(fbd);
> >  }
> >
> > +/* Returns the napi vector servicing an Rx queue, or NULL if the datap=
ath
> > + * is torn down.  The association is published by fbnic_set_netif_napi=
()
> > + * and cleared by fbnic_reset_netif_napi(), both under the instance lo=
ck.
> > + */
> > +static struct fbnic_napi_vector *fbnic_rxq_nv(struct net_device *dev, =
int idx)
> > +{
> > +     struct napi_struct *napi =3D __netif_get_rx_queue(dev, idx)->napi=
;
> > +
> > +     return napi ? container_of(napi, struct fbnic_napi_vector, napi) =
: NULL;
> > +}
> > +
>
> [Severity: High]
> The commit message says "The pointer is NULL exactly while the datapath i=
s
> down".  Does that hold across the resume path?
>
> In fbnic_pci.c, the publish and the enable are split across two calls wit=
h
> the instance lock dropped in between:
>
> __fbnic_pm_resume()
>     netdev_lock()
>     __fbnic_open()
>         fbnic_set_netif_queues()
>             fbnic_set_netif_napi()
>                 netif_queue_set_napi()   /* publishes rxq->napi */
>     netdev_unlock()
>
> __fbnic_pm_attach()
>     if (netif_running(netdev))
>         fbnic_up(fbn);               /* napi_enable_locked() happens here=
 */
>     netif_device_attach(netdev);

This one has me scratching my head in how the code was able to get
into this state in the first place and has been this way for so long.
I am assuming it was relying on the netif_device_detach/attach for
some security. I would probably fix this as a separate patch as it
requires restructuring for several reasons, and I would classify it as
a pre-existing issue.

First the fact that the fbnic_up operating outside of any locking is
problematic at best as it could easily race with a dev_close request
and end up leaving things in a bad state. Second it looks like this
pattern exists in other drivers as well such as igb so we will need to
likely fix it across several drivers.

Basically we should be holding the rtnl and the netdev_lock and run
things from open through up all in one shot, likely including the
netdev_device_attach. What I will probably look at doing is merging
the __fbnic_pm_resume and __fbnic_pm_attach calls all into
fbnic_pm_resume and then only call it from the err_resume instead of
running down two different paths.

> [ ... ]
>
> > @@ -2841,8 +2853,16 @@ static int fbnic_queue_mem_alloc(struct net_devi=
ce *dev,
> >       if (!netif_running(dev))
> >               return fbnic_alloc_qt_page_pools(fbn, qt, idx);
> >
> > +     /* A failed PCIe recovery or resume can leave the datapath torn d=
own
> > +      * while netif_running() is still true.  This ndo runs before
> > +      * netdev_rx_queue_restart() checks netif_running(), so bail out
> > +      * rather than touching rings and vectors that are already freed.
> > +      */
> > +     nv =3D fbnic_rxq_nv(dev, idx);
> > +     if (!nv)
> > +             return -ENETDOWN;
> > +
>
> [Severity: High]
> Continuing the point above: does a non-NULL rxq->napi actually imply the
> datapath is up?  For the resume window the pointer is published while the
> vectors exist but are not enabled, so this check passes and
> fbnic_queue_stop() runs napi_disable_locked() on a NAPI that was only add=
ed
> by netif_napi_add_config_locked(), which leaves NAPI_STATE_SCHED and
> NAPI_STATE_NPSVC set:
>
> net/core/dev.c:napi_disable_locked() {
>         ...
>         do {
>                 while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>                         usleep_range(20, 200);
>                         val =3D READ_ONCE(n->state);
>                 }
>         ...
> }
>
> napi_enable_locked() is the only thing that clears those bits, and it has
> not run yet, so does this loop spin forever with the netdev instance lock
> held, blocking the pending fbnic_up(), dev_close(), unregister and ethtoo=
l?
>
> Would a "datapath enabled" state test, or moving fbnic_up() inside the
> instance-locked region of the resume path, be a better fit than keying of=
f
> the published pointer?

Odds are pretty slim for hitting this race, but this would be
addressed via the locking bug fix I called out above. Again the
pattern before was more of a NULL pointer dereference that was a
guaranteed hit versus this locking race.

> > +     real =3D container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
> > -     nv =3D fbn->napi[idx % fbn->num_napi];
> >
> >       fbnic_ring_init(&qt->sub0, real->sub0.doorbell, real->sub0.q_idx,
> >                       real->sub0.flags);
>
> [Severity: High]
> This is a pre-existing issue, but since both branches of this ndo reach i=
t,
> could fbnic_alloc_qt_page_pools() be dereferencing an error pointer?  The
> second page_pool_create() overwrites the local pp, and the error label th=
en
> destroys that value rather than the pool it should be releasing:
>
>         qt->sub0.page_pool =3D pp;
>         if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
>                 ...
>                 pp =3D page_pool_create(&pp_params);
>                 if (IS_ERR(pp))
>                         goto err_destroy_sub0;
>         ...
> err_destroy_sub0:
>         page_pool_destroy(pp);
>         return PTR_ERR(pp);
>
> net/core/page_pool.c:page_pool_destroy() only filters NULL:
>
>         if (!pool)
>                 return;
>
>         if (!page_pool_put(pool))
>                 return;
>
> so page_pool_put() would dereference the ERR_PTR, and qt->sub0.page_pool
> leaks because netdev_rx_queue_reconfig() does not call ndo_queue_mem_free
> on the mem_alloc failure path.  The reachable trigger is a devmem or
> io_uring bind on a queue with an unreadable memory provider where the
> second page_pool_create() fails with -ENOMEM, or where the provider's
> ->init() returns an error.  Would saving the error before destroying
> qt->sub0.page_pool address this?
>
> [ ... ]

This is yet another pre-existing issue that would likely be better
fixed as it is an unrelated problem. Looks like it should be a 2 liner
to use sub0.page_pool instead of pp in page_pool_destroy, and then to
reset that back to NULL.

> > @@ -2915,7 +2935,7 @@ static int fbnic_queue_stop(struct net_device *de=
v, void *qmem, int idx)
> >       int err;
> >
> >       real =3D container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
> > -     nv =3D fbn->napi[idx % fbn->num_napi];
> > +     nv =3D fbnic_rxq_nv(dev, idx);
> >       fbnic_dbg_nv_exit(nv);
> >
> >       napi_disable_locked(&nv->napi);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the standalone-Tx
> configuration this patch targets remain incorrect afterwards?  The rest o=
f
> fbnic_queue_stop() uses sub0.q_idx as the queue identifier:
>
>         for (i =3D 0; i < nv->txt_count; i++)
>                 netif_stop_subqueue(dev, nv->qt[i].sub0.q_idx);
>         fbnic_nv_disable(fbn, nv);
>
>         for (t =3D 0; t < nv->txt_count + nv->rxt_count; t++) {
>                 err =3D fbnic_wait_queue_idle(fbn, t >=3D nv->txt_count,
>                                             nv->qt[t].sub0.q_idx);
>
> but sub0.q_idx is 0 for two kinds of triads.  For the placeholder Tx tria=
d
> of an Rx-only vector, fbnic_alloc_napi_vector() sets:
>
>                 } else {
>                         fbnic_ring_init(&qt->sub0, db, 0,
>                                         FBNIC_RING_F_DISABLED);
>                 }
>
> and for the Rx BDQ rings:
>
>                 db =3D &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_HP=
Q_TAIL];
>                 fbnic_ring_init(&qt->sub0, db, 0,
>                                 FBNIC_RING_F_CTX | FBNIC_RING_F_STATS);
>
> so the real HW block index only lives in cmpl.q_idx.

I agree that this is a pre-existing bug, but I wouldn't fix it in this
patch. I would probably introduce yet another patch to resolve it.

By my count we have 3 pre-existing issues that aren't directly related
to the original problem. If possible I would prefer to address them
separately, otherwise I can tack on 3 additional diffs to the set and
resubmit.
