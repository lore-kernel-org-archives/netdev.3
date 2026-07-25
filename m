Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188831618C
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988403; cv=pass; b=FwMLGZ1NSqXPgy50UkMFMurWHZC6G1KPBgltoMOwPylEILorFOI8h+m/KP8j6X57YH3/+bdfBEd7PXrXvJrkDaPgz3ovIaOdnnYWZZWUeKtJhqKzAv9WoCew7GpEUxJ6DYBAOZfmi3pEZspwjOQoGRsF0c1DnnLXUYFIq+RCgZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988403; c=relaxed/simple;
	bh=0Z5qqrFRERn3lTAUsiX5WOoyz3NsYalrCShLHzDhxgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFznVa6772nzwpwO3cMPzQLyA9dUgBegT+tatl6Di4XIYTZ/Q/76hLfDaqyz4ho/DUykZQYrhjmnZdLh21pCon91xeBxPwZtUg0G89VpY9PO0eOg5sUX7FoXqF0YhFqCU9/l6dMbg31PF22jaW3rBlT8zEMMFsPx+6VmY3Q10sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2P79+S/; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2P79+S/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1670dad7a8so211168766b.3
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784988400; cv=none;
        d=google.com; s=arc-20260327;
        b=RGY2M50/yotgF3LRiZy1jFsXXgdixd5gEhUFGNhAaHuo7Rr/WUM7GqbCnBr3fCqFPh
         FvaycBoX/N5lbOSji17MGaEcZrL4W6bdOh6bQlbgMVfb75Z54yCLPXd9tJEknzGZjhVH
         qpiB/2WYleOWWTf01afzMJfSaoqZb4ACrc8Z09N5M2LWBjrG9D28apwlwjZN+/Gqpjln
         OGhRnvJHh9x6ka8JKRDgn6HGOTf1hcMNakFex+GNm0WL87W0lBCWbXtTnMRvFH7G77tC
         NnbYY5xz6Pig1xoj3J5iP4DgPrgXhjZ3UOvBnn7CmHwsL0plxsjqI4IPkLUy4Alv+K7n
         KqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5R/x5Wn+PQhLsdPcxAznOmmw9oD/Z0FYDH3NQZNyxJA=;
        fh=bXkAkc+xdabC9CrApHH1Fs4D30d6RThvseYJGZwrhYE=;
        b=ieGGxUqoXvBHSRxBqlDHz99kt0zfyffAAX8x8r2oksbrGqkIv53cgwcrIdwpTjegYh
         M8Fy4Rl6iG+xSA32tXvWHF3fF3uEsF5tHy7fZ72wBl1fBHABHiDLds7sdDlL/grw4vwv
         IklCm4mujt0hES9RRgEPvAfhFHHxvqqmPqtwfgqzqsBOJEEAWk3B+oyrn6G4zYIPFypr
         qp8xCft908M3mQyE9wKtwGgwRtIMuxVmwV+AHYf8FBbuPrAZYithoErpqzWdYopdnAHn
         FeodhkDrGXuENydCmAQiLShJ2NsSY6riNr+JZcmuvZAEiF2RYWq/z8UfeLrdpYiVD0yD
         rv7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784988400; x=1785593200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5R/x5Wn+PQhLsdPcxAznOmmw9oD/Z0FYDH3NQZNyxJA=;
        b=c2P79+S/E1C50BHuxZTXz1nsN51U6QOILerBtbmMlRBnPgQ7ilwTAQ+z99O7yoImBn
         stPdmCR+yv4qwKXRz1wEJBa03+EgW7mTKcebE5ujLOjYkr/jpO/rRG9bkvLMfJ0QGNUA
         +XZjqaU8zA0w3dTFe1Wp4alE0oEr2NxuHZ4YGnwcuZOBeoSLg7GyzFm9DtT6bZmHRklJ
         /ArywuCzNNmOjs8h97FrrjCHx7rjIEQWq1t7Zdi3bJWl9jh7FXCj5hwuMA4GjVqhMac9
         T5Rr/0ndu60z9iNEccw4eO7U2hVdFA5xkaXH9XYccLo2ZdYo2w1qUUK7UhzEN4ZZtZpZ
         +2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784988400; x=1785593200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5R/x5Wn+PQhLsdPcxAznOmmw9oD/Z0FYDH3NQZNyxJA=;
        b=Tvx2X+vunonW3ok+gZE9B7ZvmU0B8p2vFXfeKW0pUnNljkftVA9U9aRF2nVeLjBNG4
         6vW6B4KQMQsGdM4oYJmzKX78AGDZCUsYoz8T27Brq2qT+00H3XnQ4aFnCR2CSizlprha
         kFppYk4eVoUdSjPVEhgij5xhW9BFzTEhEFVwZNoM0x4gvyF0j9D+BuQkRNdmIePo6/VU
         V1Szavtwo9I6E26XMsWMm8RP5A+/uZtz35PPuxKX1CJH30ovX5Db7m4Th7tkNpyDUsrF
         TusX2k45rpGa84zmArFGii+1155FznZfKfHNYe87piLde2XE87INUyiQOTZk6M9z1ENa
         07jg==
X-Forwarded-Encrypted: i=1; AHgh+RqE6et3eVAsAYz0pvlp5q5dsmGurY1Z3JpRzEHTmbP7XIZCCQQ5Lp4+PpmuF/OLPwnMSohujc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpv1ZnXrAxq60+1GEefva10f463hQNi44pPdDrY0OfbFOb21YE
	YfJAcr0WaiMwNuxHGhvvuSew88mzXqavyGfs3Py8ltqDM2DH1N71XNbYz9D4oK3B9dOAUIiCJN0
	VTFSV0BJt0koYMLCnf+oQ7hWOHI1eFA==
X-Gm-Gg: AR+sD11/JQ5QG9jXyTeeDMqx/jxQK329MbuJ4S9D9iCUpNc0TGQ0YdrI2LcZRF/tyxM
	v0xOG2kEdM0xJB5UIgc+IRCvejxQhu6a2hKXWTnk5gRva20kr6D9uLTVtcoOGKRbt7Se+1g7hTI
	P3FCosWJr/FRVCHHMeVp6y7mvbHBbAVNxv+06D6JcEpH5tGYXhD8znAYHsziOv1M4afE8/F5KgA
	Eijk+8Kg2gqFZfn5rSuaOpdsra7ENAMvvD2VV9m/oGfhy2XZOQVT1L+7I3y0u0sW0WN9rbjDGoH
	42pMahpv7NyvphB4v2yeVcP6safs653WoyMOiylvV2AbO0Mn6uwDHrXzYialaRhU4DL1+hE=
X-Received: by 2002:a17:906:9fd1:b0:c1c:5ec9:1954 with SMTP id
 a640c23a62f3a-c1f1f15b7f7mr128786466b.32.1784988400091; Sat, 25 Jul 2026
 07:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721125753.35944-1-mhun512@gmail.com> <875x2788ac.fsf@nvidia.com>
In-Reply-To: <875x2788ac.fsf@nvidia.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 25 Jul 2026 23:06:27 +0900
X-Gm-Features: AUfX_mwqkKfYhv9D8Yc5WgBlUa_kOB08VfcPi9zYcYxrHL8zee9Dh9h2VHf0VP4
Message-ID: <CAGEsz8GZBtrQ_KBn1CZKB=b695y_9UpRgZw-Eph=9NvFjP4JXQ@mail.gmail.com>
Subject: Re: [PATCH net v2] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI before teardown
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel test robot <lkp@intel.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

The extra a in truea was accidentally introduced while I was preparing
the patch email after the build test. Sorry about that.

I also understand that this should target net-next rather than
net/stable, and I will drop the stable Cc. Your proposed start/stop
approach also looks cleaner. I will review it carefully and build-test
the next revision before sending it, after allowing sufficient time
for further feedback.

2026=EB=85=84 7=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:27, =
Petr Machata <petrm@nvidia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> Myeonghun Pak <mhun512@gmail.com> writes:
>
> > mlxsw_pci_eq_irq_handler() schedules the EQ tasklet. The tasklet reads
> > the EQ ring and schedules CQ NAPI instances. The CQ poll callbacks, in
> > turn, dereference the RDQ or SDQ associated with the CQ.
> >
> > mlxsw_pci_fini() unregisters the IRQ and immediately tears down the
> > asynchronous queues in RDQ, SDQ, CQ, EQ order. free_irq() waits for IRQ
> > handlers, but not for a tasklet already scheduled by one. In addition,
> > mlxsw_pci_cq_fini() disables each CQ NAPI only after all RDQs and SDQs
> > have been freed. A pending tasklet or NAPI poll can therefore access
> > freed queue storage.
> >
> > Kill the EQ tasklet after free_irq() so it cannot schedule any more CQ
> > NAPI instances. Disable all CQ NAPI instances before freeing the first
> > descriptor queue, ensuring their poll callbacks have completed. Track
> > the enabled state per CQ to avoid disabling a NAPI instance twice when
> > the CQ is later destroyed, while preserving the partial initialization
> > unwind.
> >
> > Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > v2:
> > - Fix typo in napi_enabled assignment reported by kernel test robot.
> >
> > v1: https://lore.kernel.org/r/20260721062105.55014-1-mhun512@gmail.com/
> >
> > Found by static analysis on v7.2-rc2; not tested on hardware.
> >
> >  drivers/net/ethernet/mellanox/mlxsw/pci.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/et=
hernet/mellanox/mlxsw/pci.c
> > index 0da85d36647d..feeb32134d2a 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> > @@ -86,6 +86,7 @@ struct mlxsw_pci_queue {
> >                       enum mlxsw_pci_cqe_v v;
> >                       struct mlxsw_pci_queue *dq;
> >                       struct napi_struct napi;
> > +                     bool napi_enabled;
> >                       struct page_pool *page_pool;
> >               } cq;
> >               struct {
> > @@ -989,6 +990,15 @@ static void mlxsw_pci_cq_napi_teardown(struct mlxs=
w_pci_queue *q)
> >       netif_napi_del(&q->u.cq.napi);
> >  }
> >
> > +static void mlxsw_pci_cq_napi_disable(struct mlxsw_pci_queue *q)
> > +{
> > +     if (!q->u.cq.napi_enabled)
> > +             return;
> > +
> > +     napi_disable(&q->u.cq.napi);
> > +     q->u.cq.napi_enabled =3D false;
> > +}
> > +
> >  static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
> >                                      enum mlxsw_pci_cq_type cq_type)
> >  {
> > @@ -1064,6 +1074,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *ml=
xsw_pci, char *mbox,
> >               goto err_page_pool_init;
> >
> >       napi_enable(&q->u.cq.napi);
> > +     q->u.cq.napi_enabled =3D true;
> >       mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
> >       mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
> >       return 0;
> > @@ -1078,7 +1089,7 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *m=
lxsw_pci,
> >  {
> >       enum mlxsw_pci_cq_type cq_type =3D mlxsw_pci_cq_type(mlxsw_pci, q=
);
> >
> > -     napi_disable(&q->u.cq.napi);
> > +     mlxsw_pci_cq_napi_disable(q);
> >       mlxsw_pci_cq_page_pool_fini(q, cq_type);
> >       mlxsw_pci_cq_napi_teardown(q);
> >       mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
> > @@ -1439,6 +1450,14 @@ err_cqs_init:
> >
> >  static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
> >  {
> > +     struct mlxsw_pci_queue_type_group *queue_group;
> > +     int i;
> > +
> > +     queue_group =3D mlxsw_pci_queue_type_group_get(mlxsw_pci,
> > +                                                  MLXSW_PCI_QUEUE_TYPE=
_CQ);
> > +     for (i =3D 0; i < queue_group->count; i++)
> > +             mlxsw_pci_cq_napi_disable(&queue_group->q[i]);
> > +
> >       mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
> >       mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
> >       mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
> > @@ -2089,6 +2108,7 @@ static void mlxsw_pci_fini(void *bus_priv)
> >       struct mlxsw_pci *mlxsw_pci =3D bus_priv;
> >
> >       free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
> > +     tasklet_kill(&mlxsw_pci_eq_get(mlxsw_pci)->u.eq.tasklet);
> >       mlxsw_pci_aqs_fini(mlxsw_pci);
> >       mlxsw_pci_napi_devs_fini(mlxsw_pci);
> >       mlxsw_pci_fw_area_fini(mlxsw_pci);
>
> Hm, my first instinct is to just reorder stuff so that it's correct, but
> this is not just init / fini ordering issue. The init ordering between
> CQ and EQ is the way it is because CQ refers to EQ, it should be like
> this. Fini then needs to be the other way around.
>
> The processes have the opposite requirements though: tasklet refers to
> NAPI refer to queues, so it's EQ to CQ to queues.
>
> I think the fix needs to be done differently though. The patch has
> tasklet_kill() invoked from overall PCI fini, while the corresponding
> tasklet_setup() is in mlxsw_pci_eq_init(), the EQ-specific init
> callback. Likewise the patch touches the NAPIs directly in aqs fini,
> even though they are CQ-specific. Then the napi_enabled flag seems to
> just be there to prevent repeated calls to napi_disable(). I mean, just
> don't call it the second time?
>
> So how about something like the below patch instead?
>
> The idea is that since we can't relax the order in which HW queues are
> initialized, we need a different queue-specific entry points that we can
> invoke to specifically initialize the SW processes. By ordering them
> correcly (and not forgetting a tasklet_kill()) we guarantee that NAPI is
> created after the queues, but torn down before them, and tasklet is
> created after NAPI, but torn down before it.
>
> I took it for a light test and it didn't catastrophically explode.
>
> From 116f63a959bcf9d658302605708e449588da8a69 Mon Sep 17 00:00:00 2001
> Message-ID: <116f63a959bcf9d658302605708e449588da8a69.1784725020.git.petr=
m@nvidia.com>
> From: Petr Machata <petrm@nvidia.com>
> Date: Wed, 22 Jul 2026 14:49:30 +0200
> Subject: [PATCH net-next] mlxsw: pci: Le fix [xxx]
> To: <netdev@vger.kernel.org>
> Cc: <mlxsw@nvidia.com>
>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 63 +++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethe=
rnet/mellanox/mlxsw/pci.c
> index 0da85d36647d..30111ef16443 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -1063,7 +1063,6 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxs=
w_pci, char *mbox,
>         if (err)
>                 goto err_page_pool_init;
>
> -       napi_enable(&q->u.cq.napi);
>         mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
>         mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
>         return 0;
> @@ -1078,12 +1077,23 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *m=
lxsw_pci,
>  {
>         enum mlxsw_pci_cq_type cq_type =3D mlxsw_pci_cq_type(mlxsw_pci, q=
);
>
> -       napi_disable(&q->u.cq.napi);
>         mlxsw_pci_cq_page_pool_fini(q, cq_type);
>         mlxsw_pci_cq_napi_teardown(q);
>         mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
>  }
>
> +static void mlxsw_pci_cq_start(struct mlxsw_pci *mlxsw_pci,
> +                              struct mlxsw_pci_queue *q)
> +{
> +       napi_enable(&q->u.cq.napi);
> +}
> +
> +static void mlxsw_pci_cq_stop(struct mlxsw_pci *mlxsw_pci,
> +                             struct mlxsw_pci_queue *q)
> +{
> +       napi_disable(&q->u.cq.napi);
> +}
> +
>  static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
>  {
>         return q->u.cq.v =3D=3D MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
> @@ -1177,7 +1187,6 @@ static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxs=
w_pci, char *mbox,
>         err =3D mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
>         if (err)
>                 return err;
> -       tasklet_setup(&q->u.eq.tasklet, mlxsw_pci_eq_tasklet);
>         mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
>         mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
>         return 0;
> @@ -1189,6 +1198,18 @@ static void mlxsw_pci_eq_fini(struct mlxsw_pci *ml=
xsw_pci,
>         mlxsw_cmd_hw2sw_eq(mlxsw_pci->core, q->num);
>  }
>
> +static void mlxsw_pci_eq_start(struct mlxsw_pci *mlxsw_pci,
> +                              struct mlxsw_pci_queue *q)
> +{
> +       tasklet_setup(&q->u.eq.tasklet, mlxsw_pci_eq_tasklet);
> +}
> +
> +static void mlxsw_pci_eq_stop(struct mlxsw_pci *mlxsw_pci,
> +                             struct mlxsw_pci_queue *q)
> +{
> +       tasklet_kill(&q->u.eq.tasklet);
> +}
> +
>  struct mlxsw_pci_queue_ops {
>         const char *name;
>         enum mlxsw_pci_queue_type type;
> @@ -1198,6 +1219,10 @@ struct mlxsw_pci_queue_ops {
>                     struct mlxsw_pci_queue *q);
>         void (*fini)(struct mlxsw_pci *mlxsw_pci,
>                      struct mlxsw_pci_queue *q);
> +       void (*start)(struct mlxsw_pci *mlxsw_pci,
> +                     struct mlxsw_pci_queue *q);
> +       void (*stop)(struct mlxsw_pci *mlxsw_pci,
> +                    struct mlxsw_pci_queue *q);
>         u16 (*elem_count_f)(const struct mlxsw_pci_queue *q);
>         u8 (*elem_size_f)(const struct mlxsw_pci_queue *q);
>         u16 elem_count;
> @@ -1225,6 +1250,8 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_c=
q_ops =3D {
>         .pre_init       =3D mlxsw_pci_cq_pre_init,
>         .init           =3D mlxsw_pci_cq_init,
>         .fini           =3D mlxsw_pci_cq_fini,
> +       .start          =3D mlxsw_pci_cq_start,
> +       .stop           =3D mlxsw_pci_cq_stop,
>         .elem_count_f   =3D mlxsw_pci_cq_elem_count,
>         .elem_size_f    =3D mlxsw_pci_cq_elem_size
>  };
> @@ -1233,6 +1260,8 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_e=
q_ops =3D {
>         .type           =3D MLXSW_PCI_QUEUE_TYPE_EQ,
>         .init           =3D mlxsw_pci_eq_init,
>         .fini           =3D mlxsw_pci_eq_fini,
> +       .start          =3D mlxsw_pci_eq_start,
> +       .stop           =3D mlxsw_pci_eq_stop,
>         .elem_count     =3D MLXSW_PCI_EQE_COUNT,
>         .elem_size      =3D MLXSW_PCI_EQE_SIZE
>  };
> @@ -1349,6 +1378,28 @@ static void mlxsw_pci_queue_group_fini(struct mlxs=
w_pci *mlxsw_pci,
>         kfree(queue_group->q);
>  }
>
> +static void mlxsw_pci_queue_group_start(struct mlxsw_pci *mlxsw_pci,
> +                                       const struct mlxsw_pci_queue_ops =
*q_ops)
> +{
> +       struct mlxsw_pci_queue_type_group *queue_group;
> +       int i;
> +
> +       queue_group =3D mlxsw_pci_queue_type_group_get(mlxsw_pci, q_ops->=
type);
> +       for (i =3D 0; i < queue_group->count; i++)
> +               q_ops->start(mlxsw_pci, &queue_group->q[i]);
> +}
> +
> +static void mlxsw_pci_queue_group_stop(struct mlxsw_pci *mlxsw_pci,
> +                                      const struct mlxsw_pci_queue_ops *=
q_ops)
> +{
> +       struct mlxsw_pci_queue_type_group *queue_group;
> +       int i;
> +
> +       queue_group =3D mlxsw_pci_queue_type_group_get(mlxsw_pci, q_ops->=
type);
> +       for (i =3D 0; i < queue_group->count; i++)
> +               q_ops->stop(mlxsw_pci, &queue_group->q[i]);
> +}
> +
>  static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
>  {
>         struct pci_dev *pdev =3D mlxsw_pci->pdev;
> @@ -1426,6 +1477,9 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlx=
sw_pci, char *mbox)
>                 goto err_rdqs_init;
>         }
>
> +       mlxsw_pci_queue_group_start(mlxsw_pci, &mlxsw_pci_cq_ops);
> +       mlxsw_pci_queue_group_start(mlxsw_pci, &mlxsw_pci_eq_ops);
> +
>         return 0;
>
>  err_rdqs_init:
> @@ -1439,6 +1493,9 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlx=
sw_pci, char *mbox)
>
>  static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
>  {
> +       mlxsw_pci_queue_group_stop(mlxsw_pci, &mlxsw_pci_eq_ops);
> +       mlxsw_pci_queue_group_stop(mlxsw_pci, &mlxsw_pci_cq_ops);
> +
>         mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
>         mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
>         mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
> --
> 2.54.0
