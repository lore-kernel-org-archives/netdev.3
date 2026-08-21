Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EC27A907
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328266; cv=pass; b=EhVgZzLDcG0e/MYxxaHTxV3lT5VPAXSgQwPyIdCpa7nqWVjA6E9LFKgvTX8a9VZh2OXJzik/e9C7EmW/20kao2IM0u3681uUCHMEKahWT6tFkSKHwsLnGUcRnrS6dR9FfYjmxM66VDEHC1HpWO0Pjp5WrdHhWcSYdxZiRcRjfHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328266; c=relaxed/simple;
	bh=SerHokd/DjReQDG8vtbBBC8t/wy+cBj5FkxUWoJCcDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwvII7pW/atH/Vp2Mu4KqZuVjCIqtXneyE7INihl5WEUteNqNSwzQ48EW5F64Dtr34NlpShpUOeDIrf2u27v/FL+7vuL52UoD57nQSo73GL+shcDrnbvo6v7pz03HGblPYd9gET6ablTB+pa5tpwLfDVmGiXKuqJNV+wJ7Ti9to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mZDqar3r; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mZDqar3r"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso787925b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787328264; cv=none;
        d=google.com; s=arc-20260327;
        b=JHrpouFEQxJZM7vf16l2kA8trTxnKvmy7akdaDou0fjoNR3jG+17Bu/NnRW8REQvUD
         wWCinOwrmRObWvF+sfuo3I9SHI/p3TfQdpOm+/KLg8etI/Zku5hqgLbAtJc8lm3qIQfv
         Uwy8qfC8W5lWTHmYzZCPvXmO7E+n7rRzVczeeAojd/uKkhobRVgKXWB7POxL4PYuPRVh
         T2/30S8WMh+FZrw5B8TN+ICXhUolJx24HMkxCfHzX14XmTHN/uMCLYgAHDcvFaDnID4p
         hTV0CfwtDVRryn8qPR52FK8W8Xak465dIkNPG9hbvMspbavMQCx3k11vwK9hYQIwlHom
         AKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40B84Kno1PtoPAti0QyzQp4UA1yoqhnYSR2vpkV5e5g=;
        fh=T+lcaWEP4TbvTDTxY3V+GOJqeVz/AjJrP9ekRJzR/3k=;
        b=GJ9Fa/3N6er/xrmS1wL++l4s9a2euVwLarKHVmM3b/RuwB1OYt/TOLN5YNt22Z5YJe
         Sq0WDzUHfBs1hMnfsf2ooNry0Iqgu44LR4VJ2G6Ybfatm8+KkTOPjbM3aRREoOgHLqFg
         x4GG9/NmBgiVHZh/KEp1fIw6yrXGi9qjJQAAvCvWfB5XyXDsVa93gt4tnPYsA0drFe4l
         JGmn1fgm1CrCpHUb3XiBmHGsa+tnfv3l9QSJgmR5gVwWleR0uR4m54Twr9EdvDh8Bxk6
         AxgXM4wKrJFvTL2Xta6JF5zlh7Cwn2uvsoUfJiQ7cRkhVY/tsc/SUDYzmqayeCc+3HhK
         0OOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787328264; x=1787933064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=40B84Kno1PtoPAti0QyzQp4UA1yoqhnYSR2vpkV5e5g=;
        b=mZDqar3rhhD5gh0162MTi8HPMtMhynT4KVVyyGRJHUXUc5RJmV6IitGCNOCZF35fPc
         QkKJZdHNzuFk9P5Ot4e2qjuQn7BTu7RYySdfd1ldvXMXodlEyDJp7Jbtvy5Ao1qkqBKq
         namLtbf1O/RXlOVfJmz7i0MXA8h2+v6j7Hz4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328264; x=1787933064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40B84Kno1PtoPAti0QyzQp4UA1yoqhnYSR2vpkV5e5g=;
        b=Ff3RdkCXXNqSiDpLT0o9L6/Cjrx42oQHnREWMPwqubQHVs6XuJmR2/E5ZLm0YZyzd0
         6PpFxqbluwTA5hyJY54Ndv/YvT+4r2ZRCRwZtS6ivznZpydXKc7a/VrrPQUUCNioQQEQ
         l4nZo1Xi5M22vpoHLvOEZmjMaNp7BKKxkmNiQ6NU+Qu5U93qjTu9wwXpYzRUFpTD1908
         dY+YwmEpJbSnLNmq/pEJcbB+n73Ha19ZaYKOnvLV0YwfRhFEmpNbkZJnOKtDg/fBfWI8
         8WX0OMGwQzknVU02Yruk19q2iMFreEZ+fQujrfHnI+vU08txP/sjQ6whxQ20B+C7S55m
         gZOg==
X-Forwarded-Encrypted: i=1; AHgh+Rqxs8IgMYbo/5J1nFfIpF57LJusXAWnEuxCmWWr5TVE8eocFRJOZIaT6pjlsWLaM3tl+uoczGc=@vger.kernel.org
X-Gm-Message-State: AFuF++mbWaT8YMv/x4sKM8JkPK1P33vJ7kJu3IoxeDzJAC9e6GuBq6Rc
	VLAsQwPGlYHO1ROCYySYIwkz4ef0spOcd8zy4bpPEvWg9eg1CqublhR4LqiJgv2NOO8W8l3gJwO
	eOhVB+Q/M6f94PWCjVr7atp+nbQW5AEsMDEu+ijWh
X-Gm-Gg: AR+sD10buFpG/SE1DrGhV5/jVwJuAqNKg2xdPOm8b/C5EDeeNyYv581w7/xWiA3aEVz
	FIWb4/20OijXe5q7fWe2+aOyH4s0IsL48ICsnpZ6MFxEZFsrmZ5furUSw8vopdf2cIE20qKWPKl
	fwtI8CXA4Nd89ulC5CQW5xxi1B2lVY6TA+LClHu6iEX+de3DHqn44sSwLt4xpAjd6pOXRJ0zdcR
	UE7/VTTIZuQURuTMvUcaShyZLUwmDPW/UuTJyuUiO7PMA3UQrAZKcZiWLBcQkQuRVYFUsJfmMq+
	LmzAu4Gp4Y8p4ltvKxL6gufPH6JtIfkzsdS55sf4lA==
X-Received: by 2002:a05:6a00:410f:b0:845:c694:5c3d with SMTP id
 d2e1a72fcca58-851f972a856mr13293160b3a.1.1787328264050; Fri, 21 Aug 2026
 09:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807133155.1242599-1-victor@mojatatu.com> <20260811001150.1034738-1-kuba@kernel.org>
In-Reply-To: <20260811001150.1034738-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Aug 2026 12:04:12 -0400
X-Gm-Features: AcwNN1UPcX8vgRn80g01oSrQ4CzFPiLQ8dsCaDHOt4uR_dCWdXTO3jFrw0zJBEU
Message-ID: <CAM0EoMmXhqmuSkLCS1hXczFK4GZtQR2Gy1YZ5Vx2wfqCD87PDA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_teql: restore skb->dev on the slave
 failure path
To: Jakub Kicinski <kuba@kernel.org>
Cc: victor@mojatatu.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, bestswngs@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/sched: sch_teql: restore skb->dev on the slave failure path
>
> teql_master_xmit() used to leave skb->dev pointing at a slave after that
> slave's ndo_start_xmit() failed, so the skb could end up queued on a late=
r
> slave's neighbour arp_queue while referring to the earlier slave.  The
> patch restores skb->dev to the master device at the end of each slave
> iteration.
>

Let's please apply this patch. The patch correctly fixes the reported
UAF (namespace-reachable, slave deleted while skb queued on another
slave's neighbour).

What sashikos are claiming is partly followup material (the rmmod
issue requires root where this UAF requires CAP_NET_ADMIN) and
partially hallucinations. So, let's address those issues in follow-up
patches.

cheers,
jamal

> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 5c42a29a981c..9e52afc2d980 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
> > @@ -377,6 +377,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >                       nores =3D 1;
> >                       break;
> >               }
> > +             skb->dev =3D dev;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does it leave a smaller
> version of the same dangling skb->dev behind, with the master netdev in
> place of the previous slave?
>
> After the restore, skb->dev is the teql master, and the skb can still be
> parked on the arp_queue of a neighbour that belongs to a slave device.  O=
n
> the second pass (skb_res =3D=3D skb after the goto restart), teql_resolve=
() ->
> __teql_resolve() creates the neighbour on the slave because dst->dev is t=
he
> master:
>
> net/sched/sch_teql.c:__teql_resolve() {
>         ...
>         if (dst->dev !=3D dev) {
>                 struct neighbour *mn;
>
>                 mn =3D __neigh_lookup_errno(n->tbl, n->primary_key, dev);
>         ...
>         if (neigh_event_send(n, skb_res) =3D=3D 0) {
>         ...
>         } else {
>                 err =3D (skb_res =3D=3D NULL) ? -EAGAIN : 1;
>         }
> }
>
> __neigh_event_send() then keeps the skb:
>
> net/core/neighbour.c:__neigh_event_send() {
>         ...
>                 skb_dst_force(skb);
>                 __skb_queue_tail(&neigh->arp_queue, skb);
>         ...
> }
>
> teql_master_xmit() returns NETDEV_TX_OK for the err =3D=3D 1 case and los=
es
> ownership.  At that point the queued skb's skb->dev (master) is not the
> neighbour's device (slave), so the arp_queue flushing done by
> arp_ifdown()/neigh_ifdown() for the master's device never sees this skb.
> skb->dev also takes no netdev reference.
>
> Is the held dst enough to pin the master here?  On NETDEV_UNREGISTER,
> rt_flush_dev() and dst_dev_put() swap dst->dev to blackhole_netdev via
> netdev_ref_replace(), which drops the master's refcount, so
> netdev_wait_allrefs() does not hold off free_netdev().  The master has no
> rtnl_link_ops, so the free comes from teql_exit():
>
> net/sched/sch_teql.c:teql_exit() {
>         ...
>                 unregister_qdisc(&master->qops);
>                 unregister_netdev(master->dev);
>                 free_netdev(master->dev);
>         ...
> }
>
> which means rmmod sch_teql after the last teql qdisc is deleted, racing a
> pending neighbour resolution (the retransmit window is multiple seconds b=
y
> default).  The next use of the queued skb dereferences the freed master
> through the same path as the KASAN report quoted in the commit message,
> neigh_invalidate() -> arp_error_report() -> dst_link_failure() ->
> ipv4_link_failure() -> __icmp_send():
>
> net/ipv4/icmp.c:__icmp_send() {
>         ...
>         if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
>               !icmpv4_global_allow(net, type, code, &apply_ratelimit))
>         ...
> }
>
> and on the successful resolution path,
> neigh_update_process_arp_queue() -> n1->output() -> dev_queue_xmit() uses
> the freed device's netdev_ops and _tx.
>
> Would setting skb->dev to the device of the neighbour that actually takes
> the skb (the slave used by __teql_resolve()), or declining to hand the sk=
b
> to a neighbour whose device differs from skb->dev, close the remaining
> window?
>
> > \t\t__skb_pull(skb, skb_network_offset(skb));
> >       } while ((q =3D rcu_dereference(NEXT_SLAVE(q))) !=3D start);
> >
> --
> pw-bot: cr
