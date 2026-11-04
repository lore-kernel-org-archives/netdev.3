Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793783690;
	b=gP0VL1c1Z3+toh0fknLjDn5N7WAANRnNUC3Wc7F9CusMBw920Z/U92bvjKQYzNG2nKud
	 dXz961N8K/Tq2nU9kh6L70gUcCIxgdJqPKl/RZPPiYPsAOnbfAaAyny+DREXjZfXOle3M
	 BwKa2DxdWRUc4t3aT2yV2Qd3Zyq8znzLxsLqUbtjmYuOIQtWzSJEXXeTzsaZ27zHbTGZt
	 Elvvu+6UUe4YKERpq83st1SkRUvafgReNfG9ZtPCjJnp6ejBSFm0nuDisJYI7lCZn/rIB
	 K4f/JWqcZSOOEIY9pww3rzoI5Ao7K9aophaDIfgC6jifaM+eKeBZkMfElYbUlL+pE0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
	b=xHw/yHWRGK0JUsw0dYUeVPMqVTGZHsBX3zi7ACPmIiyvBuAtumzE0SECqBtg3ANFlf4T
	 0A0ID9ewwOBL7sv4FOXsyT/njQO+ba1pUyNYmEm9tdRp0ha/PFN0pJsgLcEHk/ctU4qrU
	 2rhFrwOL/OyTHXDjMYBAwnZvRZEcoWK+ahQuGsH16KcIednmZaP0V2k24U3j8J8uTNIk7
	 ZdWvaAAVXyaP0eABi91PwPjj+cu7vjRFkaXXLSzD64Nt2HYH68QTvWwHUUCh1h/2XUyHs
	 QI0SJ/8qg4/CIfgsYJVXvqBa9NjGvXW6dCJROkPWMdDNy7+Liqpe9DRMYDOLU1osdgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AQqHQRIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A7606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399A7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AQqHQRIl
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so228784b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793783689; cv=none;
        d=google.com; s=arc-20260327;
        b=Xnyt6naC7bOOeVa2cidY91xHaQ71jW84dVv8TehIBkeJkdgLKjQA+d04M3nhStHhS+
         ry8NUMHl7axKUROpGT3YGPrOUPViwvtjL+6x6FmnVZ2vFVgq2Zst9s7EVtRYv6zb9EaE
         lYuThZSa1ok4jE8fg2XJh2o/ecFksYZOSyI30toOoBWXYYR2ngLiVtnF3G3koKyi8p0o
         c4CeTHJx50Qf6rHUFiG4TJty6ewjwzdbTcg7qfivz19hfqSepUfVRNh9ipqGyyT82I9z
         LQv/QHKbd1+R4lh+XHHY45wFBsaPt3c9mfOwrWgx3TaJQwLkAN8dKTzEdxTotDfiWqFy
         S0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        fh=x4xhomiBH41unImTZwfWiBgFlqpZewoUX4ShROqIbzg=;
        b=WR0plemb74wuzEHLzIEqC0mCBMGCBXEeVZnH21EMtAeM/KZrQE73/tQG/SYr4a2rEj
         aia/tv4dUKVtf70Cr5PvCPBJm+pVMF4B4LgN7vtcS9e0cPt5meY9Sns1steq6IKxgqNY
         DjMXW6nkssThZgPHYvV+qOzmyV/viQNAHYUwRvzOUhR2216FYpNpJr4VdMCwiIAt6Qni
         o/0/+L3FKu65CzbwmnApoDVKMGyePC0iZpvHE8HG8MpTqjw/zqVt7BFMrjrkiA9Pnxjk
         8HBOYuH2tpA7oAvRWEjA8yMec6hEagNx3passBJSXK1nzEhw6W2ylt0M+MJQ1qgbTLI8
         Qkdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793783689; x=1794388489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        b=AQqHQRIlgEz6uzCGkg04TmOJsYG2eT4MvgX8UrzjPyNzZbEQwCB9itFh1O+e74qSrk
         +0mlDibQIRXNWIfyTomgiRrLRHHZOhnGIOrNSSSnZG4tCrSYL9c2r4MFvmFhmfNGTbVg
         UvVj59+PYDAcmXXiru/Roz+PEE2YVAl8Mj9Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783689; x=1794388489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czUbxv5EfuLpmjrkgw21CAlQ/JdV9gdYAJCXYckMMh4=;
        b=2CfNOBwfnbqxu+oMItkdtAwGfPh+iic7J4Qi3PtuuiivGAncgOUZgvAYdwQikHZxSK
         bUoecyMscp1JSwpO3yLPtSuL8MjDrqpMawEsE34G+z909XwNsiqacIwO281ayNg27F7B
         RxiGNbklvB4zV6D2I/cGkK+JcOqy8S2THxbrwrdYFcyXX4GUNIZ6o5vMDWlylPchIxGR
         CJS3CSEzYnVJbPgjvtuFp06RxrIOqKV5I4JjZ+iChuBPJauVjIJsLEchr7Lguz5/I53c
         it5XrdT6zXc5NjvDI9UAsfHNGsbJnsy2x3pAP+WfS6DwDYOuX32UG5r7d2g0EmN4EM/3
         xsSA==
X-Forwarded-Encrypted: i=1; AKwUvBxO0i974uLFjt3KqUWsT0ujyPZ3VrTdQ6m+03lrHx9ZFVZ+QAMqTw5LaFVWdQjWh/AZx36DWk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tLM+Tm0HlDKoHk7kjfbtE18FjXN7BAjs1+RsmyBauc3YCtUc8
	y9xlcqe2Wp+sMQu2DJvJEfdkq4d23WAa942rdjQ6WzyFe6UxuB5ez7ZyJmge9bGMgv6yFN1WHBX
	MjqIn5xwN6nzNSbz0R/LS7fJnDWvMGOlT4XatvcDV
X-Gm-Gg: AYBFou0M86rwsrwmgwNy03dsCR5WSvSp+FK31nxZtNDydE8oHlEWXn2IBuUHT3YH2zV
	IcI9xC0zP5xPdDKrGzTIoEHznCIybnYR3i5xGOuEXiBpZYXHX/y0Od/TycD95beam902+v52382
	zYqMI+9xYd/3z78hiqT8wOxVKUewhOaeTkpnWJ4CYp2QDZPEMIRrNqfgPpHJLXrnf9D5qrYxY3P
	jeAeGbkfLRny0KDAMKbOwN+q8rApOcBjAWZvTpVj4Jn6KgC1G31J4QZXy9ydMJ3jT4yZaQitNKp
	OkKhrxu8J0uow0vGsYJ8lGx1ZLJFkXGF3fNfpoHBttHOoiQG6XVRmM6WXK02xNh7Y7gxiD0LEw8
	Mzz8GDrBVqLIee1t9vKsxECj6ceF80OibQowzVdsiAKOaxTxSw3Hj5minxuDaYvo8GHOpga0ZG+
	QOuPvt+PIFLyMDbgo=
X-Received: by 2002:a05:6a00:a90:b0:89f:521:8089 with SMTP id
 d2e1a72fcca58-8a9bcff6a9dmr11969821b3a.19.1793783689421; Wed, 04 Nov 2026
 01:14:49 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030030453.31928-1-cenzhang@linux.microsoft.com> <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
In-Reply-To: <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 4 Nov 2026 04:14:38 -0500
X-Gm-Features: AclHuK8QWfUruPb5mmDSb_oYTX82loMdqpI8kSB4xjZlQlMEjnsaHJgwVrRB1uY
Message-ID: <CAM0EoMn5ODpLK=OhPTy=0Zq1rgT7Gm6JGKnRs=Q=mzp_6x+JDw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix rate estimator use-after-free when
 clearing NOLOCK
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:10=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/26 04:04, Cen Zhang (Microsoft) wrote:
> > qdisc_create() creates the rate estimator requested by TCA_RATE before
> > qdisc_graft() converts a lockless child of a locking parent. The
> > conversion in qdisc_clear_nolock() frees the per-CPU statistics, but
> > the estimator keeps its own copy of the cpu_bstats pointer and its
> > timer keeps reading the freed per-CPU memory on every estimator tick.
> >
> > An unprivileged local user can trigger this.

This is a bit of an overstatement (Sashiko is infecting me with its
pedancity); you should qualify it with "needs CAP_NET_ADMIN in a
userns" or something like that. In general you should provide for
conditions on how to reproduce this in the commit (looks like straight
tc commands).

>> The estimator timer can
> > access freed per-CPU statistics in softirq context and panic the kernel=
:
> >
> >    BUG: unable to handle page fault for address: ff9d8b20ffa47920
> >    RIP: 0010:gnet_stats_add_basic+0x77/0xc0
> >    Call Trace:
> >     <IRQ>
> >     est_fetch_counters+0x31/0x50
> >     est_timer+0x52/0x170
> >     call_timer_fn+0x9f/0x210
> >     run_timer_softirq+0x6e/0xb0
> >     </IRQ>
> >    Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fix by doing the NOLOCK conversion in qdisc_create(), right before
> > the estimator is created, instead of in qdisc_graft(), so that the
> > estimator captures the final statistics pointer. Removing the
> > conversion from qdisc_graft() is safe: a new qdisc is created by
> > qdisc_create() with the parent it is grafted under, and since
> > commit bc50835e83f6 ("net: sched: Disallow replacing of child qdisc
> > from one parent to another") an existing qdisc can only be grafted
> > again under its original parent. Either way the qdisc was already
> > converted for that parent at creation.
> >
> > Fixes: 8a53e616de29 ("net: sched: when clearing NOLOCK, clear TCQ_F_CPU=
STATS, too")
> > Cc: stable@vger.kernel.org
> > Cc: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> > ---
> >
> > The bug was found and this fix was developed with the assistance of an
> > LLM-based code analysis tool.
> >
> > Backport note: trees without commit bc50835e83f6 (v6.14) still allow
> > regrafting an existing child qdisc under a different parent and need
> > an additional fix for that path, for example cherry-picking that
> > commit as well.
> >

Good note - this fix is not safe in older kernels before bc50835e83f6.
Is this the protocol to signal backporters? My gut feel is they use
automated tools and would not be reading commit logs to backport?

> >   net/sched/sch_api.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index f36c41224bcc..d89f3f0a3c5f 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1247,10 +1247,6 @@ static int qdisc_graft(struct net_device *dev, s=
truct Qdisc *parent,
> >               unsigned long cl;
> >               int err;
> >
> > -             /* Only support running class lockless if parent is lockl=
ess */
> > -             if (new && (new->flags & TCQ_F_NOLOCK) && !(parent->flags=
 & TCQ_F_NOLOCK))
> > -                     qdisc_clear_nolock(new);
> > -

Please leave the above lines alone; they seem like a separate
unnecessary "fix." Follow up with net-next to remove this hunk.
On current main it is dead code, so it does not help you fix this
graft issue and for older kernels the backporters wouldnt have to
worry about the dependency on bc50835e83f6

The rest looks reasonable.

cheers,
jamal

> >               if (!cops || !cops->graft)
> >                       return -EOPNOTSUPP;
> >
> > @@ -1327,6 +1323,7 @@ static int qdisc_block_indexes_set(struct Qdisc *=
sch, struct nlattr **tca,
> >
> >   static struct Qdisc *qdisc_create(struct net_device *dev,
> >                                 struct netdev_queue *dev_queue,
> > +                               struct Qdisc *parent_qdisc,
> >                                 u32 parent, u32 handle,
> >                                 struct nlattr **tca, int *errp,
> >                                 struct netlink_ext_ack *extack)
> > @@ -1405,6 +1402,11 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >                       goto err_out4;
> >       }
> >
> > +     /* Only support running class lockless if parent is lockless */
> > +     if ((sch->flags & TCQ_F_NOLOCK) && parent_qdisc &&
> > +         !(parent_qdisc->flags & TCQ_F_NOLOCK))
> > +             qdisc_clear_nolock(sch);
> > +
> >       if (tca[TCA_RATE]) {
> >               err =3D -EOPNOTSUPP;
> >               if (sch->flags & TCQ_F_MQROOT) {
> > @@ -1817,7 +1819,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >   create_n_graft2:
> >       if (clid =3D=3D TC_H_INGRESS) {
> >               if (dev_ingress_queue(dev)) {
> > -                     q =3D qdisc_create(dev, dev_ingress_queue(dev),
> > +                     q =3D qdisc_create(dev, dev_ingress_queue(dev), N=
ULL,
> >                                        tcm->tcm_parent, tcm->tcm_parent=
,
> >                                        tca, &err, extack);
> >               } else {
> > @@ -1834,7 +1836,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >               else
> >                       dev_queue =3D netdev_get_tx_queue(dev, 0);
> >
> > -             q =3D qdisc_create(dev, dev_queue,
> > +             q =3D qdisc_create(dev, dev_queue, p,
> >                                tcm->tcm_parent, tcm->tcm_handle,
> >                                tca, &err, extack);
> >       }
>
> Jamal: could you please have a look?
>
> Side note: I'm not sure if you are aware but we process the pending patch=
es
> in this order:
>
> https://netdev.bots.linux.dev/suie.html?delegate=3Dnetdev
>
> And you can restrict the list to the tc subsystem selecting the appropria=
te
> filter with the funnel icon in the top right.
>
> /P
>
