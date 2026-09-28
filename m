Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1037AA9C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623478; cv=pass; b=hic8i5uR1y6ezpLAP7sAWfxMZ1jGzgzd69f7Wui3BhQpKRyz9fJwhTosmU536ggcb1FGlwo/nRfzNfu+QvgsqmFx0e8C5o+ae2qpC81wju2/Iinu8yQOF7QeBOPxmwF7kPxCPrqPPxkXvjadxYMeaUS6S+irn39XMHp4qgc+Xkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623478; c=relaxed/simple;
	bh=R07dChNgz97uAb16cExXKaLp/1vzSHRrzI0UatQofQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGFEg08lkCtVzbx5k+s1fDfYBmGB/qd5/lZ5TpzGYCS/lGtX+sR6zWm8qmaXPaGV1zkDqps8UfkALDBafiv39cprA2zS0GWQ1NPY+eRNdtFvc56lOR3tcT0h7zBqF96zc+hEEFR7YMtJ8IbndWZRkoWxp5iQQkkUhLL6eOQrS0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmRvuRFH; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmRvuRFH"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-883a16b758dso268476b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623476; cv=none;
        d=google.com; s=arc-20260327;
        b=fJ862ugzkcY0kvrVlln/537fGZQqJZHVecsRg7j8TjlnjP2XHgYwWZxCXjv0IVUHBu
         I4n8jiYXqDNrkHJcEdG2L0XaSwRz2wopST3Ea46ov78DApBlFcLUXSWt8a6ooA5WtJXY
         F+OGmJRzmdY4jgVss7VvRUMt+CuUTV6cs3nPvclga9xzEl7tK6TV0Zvx1nfL7Yff0VwL
         lZEljlrI4zPdjvSuMtD3m99XXN/x84OwW9wb31d6DRyj4mFKpMDOGPsoCAPKWNzP3i8s
         W32XnJXcmpV6rh/ft9V8lr5c3LNENWqRowhnJdrB81bNvTGMvl/uSadxyl8HHUMNwIw1
         TLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/6AePfqmUPTnHU7L6Sz6cTsQuJ8/0NdRudtX/a8olk=;
        fh=Mo5Lx3zeVsv0X8x1EUvwAX7GDxkGgVNrTubMQkMcBts=;
        b=ODZam5hYfqnco925CJWjbzQQjIOyheRH1YC5BsOdZjcpSK/66CTtmNGm/zKEI7uKui
         50mMXjgKedxFpAS1XUtjwMfRk0em6beYc2w83+5mcPl8LZMoiE8qhW+P4W/milWHuHaD
         JcZ56vU6WL0xlLgrO6SkbjxtR17+xPTE7vIzrl1J2CgrEV6YDyL0b0WRzDa6/bKveF9K
         JgzMopEPithab+W7KwlKCEuNcVmZY9g6O55qcPB0cZrPLsIiCS+9HW9j/SIM9M3xy4so
         ovB4Aaf9n+qLDOyAIq1nk31ajvhDqQ7oypzG6efyHNCWewLj8cqxPlMwIQdsdaSuOADB
         Xe0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623476; x=1791228276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/6AePfqmUPTnHU7L6Sz6cTsQuJ8/0NdRudtX/a8olk=;
        b=lmRvuRFHzzlI8g7O/YRlvgeXMZs+pIsxulb5QHuixdG48AWzRq5d5kh5ytXdaA8gEX
         e0HyQ7XAEuHqaEv7GbPRg4aqH2TDARhzsBEMaggpaTdVabYYga4Ipb/ojfOxdFwxnELQ
         hD1pLzzQz4fFwKFIheLHXYAdP5bJD4C67E0/lXNPYQIqNkoCxTnFdxuJqRn7kgRpM/0u
         3x7pS8AzXZPES5nlOTm458TY3fxTE9pXN/PiCPqdNNXjhsPqLdJEN85R5ygN6UXZ8JXq
         LQqdY1y7uxFV0jMsJb5pf3LAXNrA9Rm/c3keMxDQxxKfZHJL2WdH5N21KarXiZu0aa3v
         rrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623476; x=1791228276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/6AePfqmUPTnHU7L6Sz6cTsQuJ8/0NdRudtX/a8olk=;
        b=xuJgbxqhL9vi5ohTR2JX7MLIeEuhy6+ekzQEgYP7Kk/AJs6usLMLxDXAisZTythWAR
         dmD6X3KQWsYekBVGYOWV6GW1cMLpkKNb3FDHFu0HvY5RDEzQ6CAs4+rhsIW6LsjN2Gju
         0/nLb6VEZXLcc5Q7UZeL/AP09NDuNLUXRXQDcyYXKY6svLsyrCgn6kD20NdsacUz0eTU
         c4nIAuUFRpfpKzr9ehondSj3DCJyMH6Eb8BzPHagL8lnLpcxQPitEM+heIqhi6btTGQU
         YnNUMM0qdQuUjYjoWxHfvNTLSFJHXH+8d77z1c9+JHuzvnffEFilowdNJS6z8QQ+gS0c
         DSkg==
X-Forwarded-Encrypted: i=1; AKwUvBxSXbgsU2UaLBa5J6w/nn6glWIjFsIXcQphnNpaH1LElHUKN0Ltj/oVATSLqGhpzlTLuioP1NQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kneP8yliGtbVBqdShUdp0RQwRAD3YJr+LBcCfrWq8Ooe549NEs
	dN6GW1sr9jzRdPoB18wFnHKhkSOegF/Sn1pf+4N60MvDQv370XPcamkPeBktn9hc5/ANyD32EPZ
	Tnvf+Y84BH/QvoYpHpCpjPmMNnwHlHn0=
X-Gm-Gg: AYBFou1AoX9RJ4kPVYAIpO2dO9/7hDrjFormeSZ9Fx92orOS67YAZiFc+5D8mWoatk0
	ZeMCCllp3Adrub/ukQLtHkXzYVkYGrGwzIcZMt3/F/uKNar3KkuzXTmC6f5E5FyTxHRmkTfwhOK
	7hlCkXsPq9pP81e9/If2iTKEjmrY+jFhjHg/D8f+3e9s9++K/dfWMmfvRONNw2gCSIN2K7yCb4M
	ZFfzHK/15VcYdKjnyROVvnGxcz9RcKeZjMTNV44nO3wdiYIQJU5+Mb3Q/6McMHA70uV3unA1T3K
	XhOXvbw7AWu7kDjwkUson6TJQFyyX4mjubNBei3SZBXTNANq43EdvFf26T1LK+jft4qjaazRzlR
	XAZClTTTVVmQL
X-Received: by 2002:a05:6a20:7348:b0:3de:60e0:5ca5 with SMTP id
 adf61e73a8af0-3de7ca7091emr226450637.9.1790623475412; Mon, 28 Sep 2026
 12:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928142233.1131459-1-adrianox@gmail.com> <CANn89i+dFQjW4vnTBWjtVGFmwY5KQZctrUrNYq=VYsOZz8okFQ@mail.gmail.com>
In-Reply-To: <CANn89i+dFQjW4vnTBWjtVGFmwY5KQZctrUrNYq=VYsOZz8okFQ@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Mon, 28 Sep 2026 16:24:23 -0300
X-Gm-Features: AclHuK8iqVcTNxq2cQ2pAWBlrWBwn0YcpU2_45fv4awfOyaFyXSAB8MnKf2vzfk
Message-ID: <CAMGU2hXKPKtRr65SQt1fJGxPS22qA0zU7jJvo8OHPWTh4zYk3w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: revert tx_queue_len on partial qdisc
 resize failure
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 28 sept 2026 a las 11:38, Eric Dumazet (<edumazet@google.com>) escr=
ibi=C3=B3:
>
> On Mon, Sep 28, 2026 at 4:22=E2=80=AFPM Adriano Cordova <adrianox@gmail.c=
om> wrote:
> >
> > Pass the old length to dev_qdisc_change_tx_queue_len() and, when a queu=
e
> > fails to resize, use it to restore the queues already handled.
> >
> > Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len"=
)
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >  include/net/sch_generic.h |  2 +-
> >  net/core/dev.c            |  2 +-
> >  net/sched/sch_generic.c   | 15 +++++++++------
> >  3 files changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index f35bd06a6bad..0ce97b4b2da1 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -720,7 +720,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_has=
h *,
> >  void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
> >  void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
> >
> > -int dev_qdisc_change_tx_queue_len(struct net_device *dev);
> > +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int=
 old_len);
> >  void dev_qdisc_change_real_num_tx(struct net_device *dev,
> >                                   unsigned int new_real_tx);
> >  void dev_init_scheduler(struct net_device *dev);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f660fccfc0db..57e1fa320d53 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -10002,7 +10002,7 @@ int netif_change_tx_queue_len(struct net_device=
 *dev, unsigned long new_len)
> >                 res =3D notifier_to_errno(res);
> >                 if (res)
> >                         goto err_rollback;
> > -               res =3D dev_qdisc_change_tx_queue_len(dev);
> > +               res =3D dev_qdisc_change_tx_queue_len(dev, orig_len);
> >                 if (res)
> >                         goto err_rollback;
> >         }
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..8fd0fce23cc4 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -1422,13 +1422,14 @@ void dev_deactivate(struct net_device *dev, boo=
l reset_needed)
> >  EXPORT_SYMBOL(dev_deactivate);
> >
> >  static int qdisc_change_tx_queue_len(struct net_device *dev,
> > -                                    struct netdev_queue *dev_queue)
> > +                                    struct netdev_queue *dev_queue,
> > +                                    unsigned int len)
> >  {
> >         struct Qdisc *qdisc =3D rtnl_dereference(dev_queue->qdisc_sleep=
ing);
> >         const struct Qdisc_ops *ops =3D qdisc->ops;
> >
> >         if (ops->change_tx_queue_len)
> > -               return ops->change_tx_queue_len(qdisc, dev->tx_queue_le=
n);
> > +               return ops->change_tx_queue_len(qdisc, len);
> >         return 0;
> >  }
> >
> > @@ -1465,7 +1466,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, uns=
igned int new_real_tx)
> >  }
> >  EXPORT_SYMBOL(mq_change_real_num_tx);
> >
> > -int dev_qdisc_change_tx_queue_len(struct net_device *dev)
> > +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int=
 old_len)
> >  {
> >         bool up =3D dev->flags & IFF_UP;
> >         unsigned int i;
> > @@ -1475,13 +1476,15 @@ int dev_qdisc_change_tx_queue_len(struct net_de=
vice *dev)
> >                 dev_deactivate(dev, false);
> >
> >         for (i =3D 0; i < dev->num_tx_queues; i++) {
> > -               ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> > -
> > -               /* TODO: revert changes on a partial failure */
> > +               ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i],
> > +                                               dev->tx_queue_len);
> >                 if (ret)
> >                         break;
> >         }
> >
> > +       while (ret && i--)
> > +               qdisc_change_tx_queue_len(dev, &dev->_tx[i], old_len);
> > +
>
> Ah... Probably driven by the TODO  comment and a LLM ?
>
> One caveat is that pfifo_fast_change_tx_queue_len() is currently the
> only ->change_tx_queue_len() implementation, and it only fails on
> -ENOMEM (inside skb_array_resize_multiple_bh() after freeing the
> previous ring arrays on already-processed queues).
>
> Trying to revert queues 0..i-1 back to old_len will therefore have to
> allocate new ptr_ring arrays right after an -ENOMEM failure (which is
> especially likely to fail again if old_len > new_len), and cannot
> recover packets already dropped if the ring was shrunk.
>
> pw-bot: cr

Yes.

So there is not much to do about the TODO. I could send a v2 where
qdisc_change_tx_queue_len returns void and emits a warning on failure.
