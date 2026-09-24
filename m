Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72146D560
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257289; cv=pass; b=UzegB7srbNqmfoGdqayUIejbVvy+m2nywPl2o6r6Hv3IRQ+dgYaio4Wq9VojSGONnbwCBxY8vmyeEhB4nHFld13eF1IMzHKl1b+tsOIjKjnkLFRscAtKE3+xD/vBnWNflU7ppj01IZq17d9eDSsqV7hmr9f+G/viTq6u17wgRB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257289; c=relaxed/simple;
	bh=cqW7SjFZ2VMeKZwt6tJnhW9zBsZWK5w5aMHQYAxktLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sItzKgObvOqIyUSmx0c6OXvTvNM++QskrKBuFNqGmjihYYcUOVUmvKBYasrzD4u2D67emrBKmugtCxEmInvMuaKZbAGnXxKPV+XQNURmJB4TP0IjOll4XMkS4d9TMkb+AfjOQ4267am9AI77zoB4RKlMa5TeVAUJLvnM1u+7BI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IapRArF3; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IapRArF3"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c5231570so2114053e87.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257281; cv=none;
        d=google.com; s=arc-20260327;
        b=p8juW8os7Tpfu1n7cY1TltBUCd/fD+QGTfeNxBV3ZjKFQV/woaoY2xhrCmYmoJnHRl
         QdT1V5JFYGNB0qi6tC372WpLtwJ8LsdRnCoEh7O+MY7yich/VOumLjF4fMeRnTNzoeeW
         E+Mg9CMpCvHjIsffFaqeQYpuaDq848YJdH24IGv+i3lDMl5+vsQ1/NmcoGac67VpCg+V
         HUa52OdoOG8ZepLvKkYHLD9xgrVF/Yq8VbQiAY+euG4KFmLOc+2abpKwgfeNJHNWAm3z
         26IjoHcA7z53nTtENy3DaE0+Um75IgJWJhQHllTCbL3VjHpHxmGckdW/dCTvHoW9MY/+
         pcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GGZb92y65Zgpq3x5v+GtiE7R/fU6xpwCAj6PKyWY/vY=;
        fh=0vCl46X7hFnuiRcbvJ1ZlikxQHxt31PCyR4d1ocGubY=;
        b=nU+DTII8aypxs8I9e7dvJA48FE3yJhZzf07fLpHFIQ6qpHa+mA4slC0zlSiVczMVWx
         5nSlNAWCaT4GGWJAs6PSxOAm83oD5g8o+JSlaE+U0naTYxjdoh753lfeIDtoJnSec3Cq
         hSIIktyw+YZh3Fp9Erm8RWiqnNDquLcQC8tY7ieoKfx0gxro8ZELzCatByknFHChlKet
         wV+fWi7GD1wv6s/yKSNvOnn09MbrlQBFR33YTvhjKpTZ5+dFUknwNBUTz2aCqjtqN4rF
         dtLmuByed+21+h7FewmZLjnQvkezQFdH2bHHXzCJx2AUL1mca6TeB/RQDDqsXiRHIL2A
         2NqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257281; x=1790862081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GGZb92y65Zgpq3x5v+GtiE7R/fU6xpwCAj6PKyWY/vY=;
        b=IapRArF3xZ3q54PUrDQ0oxoRvDIz7dOmcx0rBfLeofV9+TCoyxjHZqM14+WkwQu2kD
         S58nsc4Mm1+9hg8NryYurtPLwHkVxbrM1iqJZ29foIoS6ouMNkX188sMvgF/v5dA3La0
         1daqYGV0WKGnBBkid9KEJBJBiIBRieBQFMRFL377lcloUCo4GdL/t/G3wIbh981PMdPE
         /5xffJpJBnXtQAmPLTpABtm/dS8KOuhGLMVf2rXppP64JbAcynP1jR8gt24VGlXSsalO
         MHHFXGFtexJQBqJ3qlkbDLxBg0Kdsd+cYD79i5ktAHQBp396BpMdWmtBFIjENdIBF3gc
         2IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257281; x=1790862081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGZb92y65Zgpq3x5v+GtiE7R/fU6xpwCAj6PKyWY/vY=;
        b=IPiflvum9mwxefH/ktYp4asjfPPwKDM6RSO+xcJ+O2/Q5GtKTL4evkRO6izqNr+Lkv
         msZg6PPHO3j5V6aSxdBi1Zd5podOUhs3BbRWZZ+2NIqXPI8xQMU+L0RTnwzBKQJLP/Nx
         eBFWoFpE0HIK0UNqQSgf5+Cj4zZbtmYLW2RXZgDNB3s6it7/FXRuTFrgzfryFR8H4eWj
         l4jLCMV5w8Us6zpNPH1HXz4C0WYTb1TErvmIDHl20ftcMSABzplPxHgS7sdB0qpHXeTy
         6fkIhAT75ZhNVUOAP3SVBZhJ7jOFwN0Y38CBMzC5J8+S/nlzq7kGrYVK7IYj27X9pAjx
         WO6g==
X-Forwarded-Encrypted: i=1; AKwUvBylvnMoxZbIHZg9qjstNc92Upw3qrYawgzX3uzvGcqXtLEQ4Rc4ao2ofTIf4ulN9lFmLJZXKv8=@vger.kernel.org
X-Gm-Message-State: AFuF++kLfZwTg3Ibsi8uAXbMu+uYRkAq3AOCJixSjsJNuqhy6e85eI7l
	cWop/ph+CTxTDZxGogSHD9KqmvqELR87cecGQxzmeYR+PmNw/Kgt3nam9oHuV1YobIInA71dCKP
	2+y8kF6CO1AyUtwflzA+xw01bwz18fr4=
X-Gm-Gg: AYBFou35nFIl6Yr7Nry50MOSFMZprd0BSLuUC0h3kJqTwGDT+ucR7NF9FxHRM8BaT5j
	goTaWycLSeUmtqQTDPXcJI8euMJXfPEYoIU1/Ws5MbSH5cde3hmApZFEI5+q/Yn0POxWhRIpMIT
	66HLNSpNqYez7kadVSrdhp3Zl9MkrXSWJsF7trA39gTroi3SYSJ1qsWXVgYykb9hnUMclgD+DPt
	nsSxgjgUL+2aiOTR6kA/ONJ4wKjuQNj8V3K01QuMN7lbDQbJklfOz9FE27UYOOSAQ/kDo6rknNi
	wmq1C+bpegiHSFhxrY9SSfhRMxBMBx3CPdTwJ3m2vXfpJZ46OaODlwPAgHNE/xpY
X-Received: by 2002:a05:6512:1192:b0:5b8:b3a6:719a with SMTP id
 2adb3069b0e04-5b8df09d744mr945812e87.30.1790257281161; Thu, 24 Sep 2026
 06:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917115657.20697-1-maimon.sagi@gmail.com> <178999185805.2160803.2118648689532400433@kernel.org>
In-Reply-To: <178999185805.2160803.2118648689532400433@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Thu, 24 Sep 2026 16:40:54 +0300
X-Gm-Features: AclHuK_mv6cx7MF56HvpPI8ZeHUQyEOf1bmrhadhyKpWsU2yerYqhZUPa9QgwcM
Message-ID: <CAMuE1bEbupbvFxV4W8ZS5NxMAQP6SvxP=S6DC=+ho-+zkFQ=Vg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: axienet: bound TX completion cleanup by the
 NAPI budget
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org, 
	robert.hancock@calian.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 2:57=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Incomplete fix: the new budget guard in axienet_free_tx_chain()
>   is disabled when @budget =3D=3D 0 (`if (!force && budget && packets >=
=3D=E2=80=A6
>
> Pre-existing issues:
> - [Medium] Pre-existing (not introduced or claimed to be fixed by this
>   patch): axienet_dma_bd_release()=E2=80=A6
>
> --
>
> net: axienet: bound TX completion cleanup by the NAPI budget
>
> The patch adds a budget check to axienet_free_tx_chain() so the TX
> completion loop stops on a packet boundary once the NAPI budget is spent,
> and treats a budget of zero as "no limit" so the netpoll TX reclaim and t=
he
> @force callers still drain the ring.  The kernel-doc for @budget is updat=
ed
> to match.
>
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/driver=
s/net/ethernet/xilinx/xilinx_axienet_main.c
> > index 1722b7038f340..039885814a5d2 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -772,7 +772,9 @@ static int axienet_device_reset(struct net_device *=
ndev)
> >   * @force:   Whether to clean descriptors even if not complete
> >   * @sizep:   Pointer to a u32 accumulating the total byte count of
> >   *           completed packets (using skb->len). Ignored if NULL.
> > - * @budget:  NAPI budget (use 0 when not called from NAPI poll)
> > + * @budget:  NAPI budget. When @force is false, cleanup stops after th=
is
> > + *           many completed packets. Zero means no limit, as used by t=
he
> > + *           netpoll TX reclaim and by callers outside NAPI poll.
> >   *
> >   * Would either be called after a successful transmit operation, or af=
ter
> >   * there was an error when setting up the chain.
> > @@ -788,6 +790,15 @@ static int axienet_free_tx_chain(struct axienet_lo=
cal *lp, u32 first_bd,
> >       dma_addr_t phys;
> >
> >       for (i =3D 0; i < nr_bds; i++) {
> > +             /* A NAPI poll must not return more than its budget.  Sto=
p on a
> > +              * packet boundary once it is spent - cur_p->skb is only =
set on
> > +              * a packet's last descriptor, so no packet is left half-=
freed.
> > +              * A zero budget means no limit: netpoll polls with a bud=
get of
> > +              * 0 to reclaim the TX path only, and must still clean th=
e ring.
> > +              */
> > +             if (!force && budget && packets >=3D budget)
> > +                     break;
> > +
>
> [Severity: High]
> With the "budget &&" term, is the case the commit message is about still
> reachable on the netpoll path?

Yes.  For a budget of 0 the loop drains the ring and axienet_tx_poll()
then returns the reclaimed count, which can trip the WARN_ONCE() in
poll_one_napi().  That was already reachable before this patch, while the
loop was unbounded, but since the patch is about honouring the budget it
should cover this case as well.  v3 returns "budget ? packets : 0" from
axienet_tx_poll() as you suggest, keeping the accounting and the queue
wake.

>
> For a budget of 0 the guard never fires, so axienet_free_tx_chain() walks=
 up
> to lp->tx_bd_num descriptors and increments packets for every completed
> descriptor with a non-NULL cur_p->skb.  axienet_tx_poll() then returns th=
at
> count verbatim:
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_tx_poll() {
>         packets =3D axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num=
, false,
>                                         &size, budget);
>         ...
>         if (packets < budget && napi_complete_done(napi, packets)) {
>         ...
>         return packets;
> }
>
> netpoll is the caller that enforces the invariant:
>
> net/core/netpoll.c:poll_one_napi() {
>         /* We explicitly pass the polling call a budget of 0 to
>          * indicate that we are clearing the Tx path only.
>          */
>         work =3D napi->poll(napi, 0);
>         WARN_ONCE(work, "%pS exceeded budget in poll\n", napi->poll);
>         ...
> }
>
> lp->napi_tx is on dev->napi_list (netif_napi_add(ndev, &lp->napi_tx,
> axienet_tx_poll) in axienet_probe()), so netpoll_poll_dev()->poll_napi()-=
>
> poll_one_napi() reaches axienet_tx_poll() with budget 0.  If netconsole o=
r
> kgdboe is active on the interface and at least one TX descriptor has
> XAXIDMA_BD_STS_COMPLETE_MASK set with cur_p->skb !=3D NULL, doesn't that =
poll
> return non-zero work for a budget of 0 and trip the WARN_ONCE?
>
> The "packets < budget" test is also false for budget 0, so
> napi_complete_done() is skipped on that pass, which is the secondary symp=
tom
> the changelog describes.
>
> Would it work better to keep the unlimited reclaim for budget 0 (it is
> already bounded by lp->tx_bd_num) but have axienet_tx_poll() report
> "budget ? packets : 0", while still doing the byte/packet accounting?
>
> The new kernel-doc says zero means "no limit, as used by the netpoll TX
> reclaim".  netpoll asks for two things: drain the TX path, and report zer=
o
> work.  Could the kernel-doc and the in-loop comment mention both?

Will do.

>
> One more nit on the changelog:
>
>   "Zero therefore means no limit, which also covers the @force callers th=
at
>   clean up after a DMA mapping failure with a budget of 0."
>
> The guard is already gated on !force, so the @force callers are unaffecte=
d by
> the value of @budget here.

Right, that sentence is wrong.  v3 drops it.

>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but while looking at the TX
> reclaim path: does axienet_dma_bd_release() leak the outstanding TX skbs =
and
> their streaming DMA mappings?

Yes.  It is independent of this patch, so I will send it as a separate
fix rather than fold it in.
v3 follows.  It passes traffic on hardware; the over-budget and netpoll
cases themselves were not exercised.

>
> The RX side walks the ring and cleans up:
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_bd_release(=
) {
>         for (i =3D 0; i < lp->rx_bd_num; i++) {
>                 ...
>                 dev_kfree_skb(lp->rx_bd_v[i].skb);
>                 ...
>                 dma_unmap_single(lp->dev, phys, lp->max_frm_size, DMA_FRO=
M_DEVICE);
>         }
>         ...
>         /* If we end up here, tx_bd_v must have been DMA allocated. */
>         dma_free_coherent(lp->dev,
>                           sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
>                           lp->tx_bd_v,
>                           lp->tx_bd_p);
> }
>
> The TX ring is freed with no equivalent pass over lp->tx_bd_v, so descrip=
tors
> between lp->tx_bd_ci and lp->tx_bd_tail keep their cur_p->skb and their
> dma_map_single() mapping.
>
> axienet_stop() disables TX reclamation before the release, so nothing can=
 run
> afterwards:
>
>         napi_disable(&lp->napi_tx);
>         ...
>         axienet_dma_stop(lp);
>         cancel_work_sync(&lp->dma_err_task);
>         free_irq(lp->tx_irq, ndev);
>         free_irq(lp->rx_irq, ndev);
>         axienet_dma_bd_release(ndev);
>
> So an "ip link set down" or a driver unbind with frames in flight would l=
ose
> up to lp->tx_bd_num skbs and mappings.  The budget cap added here can lea=
ve
> completed-but-unreclaimed descriptors around for a later poll, which slig=
htly
> widens the window, but the leak is independent of this change.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260917115657.20697-1-maimon.sagi%40gmail.com
