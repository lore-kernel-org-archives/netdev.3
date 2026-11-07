Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089603;
	b=1ZCJvIKnuawqILeDDafRgKt01E2YRgkH0CadZD+1B90ZJRzAwjkFVrGD3UNWmR9hRqzn
	 EAo4BJPehDhdsfyZJ/eFmgmVV7wSgNeYy0ERXRjKrrJMt/HIe55PM8tUDn0Oe5HJdFaTP
	 8RyAoO2DdJs91GNgaux2F/Poxh9x0GlbemqXQWLZLvRky9kcLMunyRPse+RFWpJy5G8LM
	 e+J2eTSR2uyk7h0U64vy2J6dFcYZG+ZhQrfrqPDhLAFEUCaxJ5ja4L6iTpPYnYZSS74nt
	 AhiIJuyIb/h27Ubt/vqEl99xQjh1zJaC+swuJ4H2X5WFCV2k9vUqlFPpRiIyWd0CCjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
	b=EVw0ARBzV+MZcIldXV5lQj62nNnOALRFt3McXzT1qe0cV8yCcEeDmm9k1LJXS4A/6CZ0
	 UVnahc1oM4+VATzX0oLvRkz3YKAO1xpDHjvWxXabB2VtMlBXWB1RrnCMqkhJCCrEMxfOz
	 ohERkg2yCCu5C/8usr9BSPkjvsXNUbETK93NMXNhnp9FszdnKewLdQ5SiqupA+Kz1tLFW
	 HboSq/YPqpI88aMYvXiDcFU1c3mULoOq2fXW8W1pgp3yIU7pgcHPneCtVmjKW8kAv1pX8
	 5GjwomPZXaQKfekaKGacvZ4eQkcPu3zkhkkvsQNhUrm4iTl2wr4SHEfeqq/1P69aZhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XJmhDb1+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E771606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 22:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E771606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XJmhDb1+
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06454116eso15123b3a.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 14:13:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089602; cv=none;
        d=google.com; s=arc-20260327;
        b=ooH0+rbUCdWAjZhkf1+0yPqeYSmyzaRMy6B88V1qngzXlgPGDBdtFZTLO6NpFKQv+N
         kahvUtP6XFxMB6j2+PJtE+G6f14vBpOktWoi+noXhAwE5zpvgtaewd/f2IrkX0lqIhCg
         kxQxHbjwo5tS6jM8TNoJfoRjKPctsRgkrlxmGA5autW3CI5ObnjeggvCDY1b1WCi5L13
         HitvLZkwGXA328oEkJfSwzrrJSBnSlSoM9fZ8Kcb1JjXghxMBBekQgbE4+U6/fxGDrVW
         Ljm+aFbdKMw4kQA1u4eQDU8t3BiD+5xnCSKohjfsaaa8pEN6bg1MfvSYcfwtqgx/Qk8C
         9Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        fh=Wb9DVDULmpc6j8VpUw/87dSUm8bUBKa2Tfv3D2tp0ZI=;
        b=qQZUHpBTFLTn9PQoMaZjE5evFFKEAGXVgce22RfE3txuQxS4PLjHrcaw6NA/DgNJ5Z
         zyITbLpGKPOYM1hsiuhmJzws86zb+CMA0QO/iQx0428otERrPPhNkCGZ1+OLo7PPdsQe
         UQ8UBErDFpZc0/muUAXWxToVsUhktnaaYnkJYWPitsjLikUJMKvjzhzb/l/mGY+qJSLY
         RUyqClrVpYAa1zJn0SQgwRUNWks2oTsb+KW7tiyND/rDNSBxamHuEQsdmHUjRcFpEfYp
         AmszjuJxRYTdLnMJ916GMKxoX9xDSo5ZVtZnJl8sYLLK+01OLaZ16ZBqjL5lGkrnY5Gt
         NkDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089602; x=1794694402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        b=XJmhDb1+YdoXCsxpJ/S44gGck8KS5crPC19DOevfgL7KXi4xY5ul/Qw9sV0uPvEazc
         BaYVdahO8EZhvdGdmVHatq+IvfjpGEjU9A+jia196v+3ocfrBu3FKnmmbzoe70eCVErZ
         HkmrKcspsgDf+Das7hUVwqdfpl64ooRseyl+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089602; x=1794694402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ri5ORY3eJx7Dxs5dHTw0DMoceR4v2VXZ5izkz0UQP3A=;
        b=Xh1tKfqIvZ06Nm4sa2ZR56g+aMpsOXel3PNs6lkyJl2CHw+Q9MYpRptBKfzbMk3UNr
         YI4ITP1/7+hmfvK6NTRqJNqWaK2dotPxEbtoPRzfjpeCyqXh59dZOW5O3/JcgNEtKRJ8
         Kf9jXi/715p02z0Vqy1nKKZ6FdUFVyYvumYh3La138uJBapGMfrQWxZcyBn1HHmkPsPD
         B14XvwgHmvTvexyx1kbtUOY85eLrPPXlR+IJYufQXREFBNKt/380gEpuCDdkevUOJ93+
         oTGgxl8HRpBNi7krppZbbr15mIKi4iJUHkbSNw6w+jcv7xIwtkrSWrcfzpMvVezJhCU1
         x4Ag==
X-Gm-Message-State: APuU4Z/4YmP8eP/pdoQElJTBjShvxPEccHCPrRo46whfn//eElmiGoIy
	aiR8QYuHgbz5/dYwwVpfNcI/YFXI0mH2nZEiO++AxdMdVpa8L73L6L2Yx9oAZ9oykiMyEkj7RUz
	4KoawCTqOmtzcgqv8xYQykCu5k8eDLDO1DS+n8aM0
X-Gm-Gg: AYBFou2dR5bfe3qyRz4mhIQSUJyg3uSjenGeoCsM+5jdYbS/7ZBSZdsF0oRPBslrRFh
	EtGvjsXz6zMX8RUkfkeUmhzR0o+mxX+RPocgebdMCEThj5VAAKB2ja6Gv8+THTJh3p1VEOKoUL3
	uqQTqSxQAdARBcLu7Yv4aoT070kkPVmdByeqVk3iU4OieVi/ikAjnTXzOoSvISu3Hr2o93LXJMt
	M2x6rtTn7N6ITtTbKpbaLR0kqW1nRjAIiHJfgWpUBfPUyGpr5k8XamTN5kXF0F6nIOOupMIXuJh
	tmvtTtV6lFZZ78QwcVHPxrAGHbaHQDujxYwMwVYtyR0QGI0VU142DunQ2Am3w1DBIzKcBkESAlq
	N2jxwgZg2PaQrxvOL9BhcJIFxXL+QQln6R/ljLVLg0cP9/CKLp9s8+wScptp5q5eG+7dabWhS1T
	oo5lolyp7hHAOoPAo=
X-Received: by 2002:a05:6a00:430c:b0:88d:20ff:15c9 with SMTP id
 d2e1a72fcca58-8b66c3ee757mr60184b3a.17.1794089601977; Sat, 07 Nov 2026
 14:13:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com> <179406301946.994134.7212801896124135602@kernel.org>
In-Reply-To: <179406301946.994134.7212801896124135602@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:13:10 -0500
X-Gm-Features: AclHuK-DdyhjEwGSmkn65EuH-Exx6Vi4NCxhfLsT3bmzjz441IxX6sjyxKbhEI0
Message-ID: <CAM0EoMmZ6msUa_HDx5511GYPpKiaWFw+G9OAJFB61hGvVm1D3A@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix checks that the slave device and the master are in the
>   same network namespace only once, in teql_qdisc_init()=E2=80=A6
> - [Low] The commit message says only that a qdisc from another netns
>   could attach to the init-net master "and change its MTU and flags".
> - [Low] Moving skb_queue_head_init(&q->q) to the top of teql_qdisc_init()
>   (sch_teql.c:203) is presented as groundwork for the new netns failure=
=E2=80=A6
>

Again, cosmetics i will fix if i have to resend.
The netns_immutable gap is pre-existing and needs CAP_NET_ADMIN in
init_net, so it stays the net-next follow-up.
The reorder keeps this patch's Fixes: because the namespace refusal is
itself reachable through qdisc_create_dflt() -> qdisc_reset() ->
teql_reset(), and if i have to resend then I will state the
interception impact in the body...


cheers,
jamal
> --
>
> net/sched: sch_teql: reject qdiscs from another network namespace
>
> This patch makes teql_qdisc_init() reject a teql qdisc whose device is
> in a different network namespace than the teql master. It returns
> -EOPNOTSUPP with an extack message. It also moves skb_queue_head_init()
> of the private queue to the top of teql_qdisc_init(), so every
> constructor failure path sees an initialized queue.
>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.=
20261031160050-3%40mojatatu.com
> Link: https://lore.kernel.org/netdev/179366641863.488856.1736857159146600=
0274@kernel.org/
>
> > The issue:
> > The teql master devices are created once in the initial network
> > namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
> > teql_master embedded in the registered sch->ops and uses it without
> > checking whether the new qdisc's device lives in the same network
> > namespace as the master. A qdisc created in another netns can therefore
> > attach to the init-net master and change its MTU and flags.
>
> [Severity: Low]
> Does this description understate the impact of the bug?
>
> Besides changing the MTU and flags, teql_qdisc_init() links the foreign
> qdisc into the master's slave ring, or makes it the first slave:
>
>     rcu_assign_pointer(NEXT_SLAVE(first), sch);
>
> >From then on, teql_master_xmit() round-robins init_net traffic sent
> through teqlN onto the device from the other netns. There is no netns
> check and no skb scrubbing:
>
>     skb->dev =3D slave;
>     if (!netif_xmit_frozen_or_stopped(slave_txq))
>         rc =3D netdev_start_xmit(skb, slave, slave_txq, false);
>
> If teql0 is already up with slaves, the attach still succeeds as long as
> the foreign device has compatible flags and an MTU at least as large as
> the master's. A CAP_NET_ADMIN holder in a user namespace can set both.
>
> With a veth slave, the netns owner could capture or drop part of the
> host's teql traffic. It could also answer ARP that __teql_resolve()
> sends on that device.
>
> The code change closes this path as well. Since stable and CVE triage
> depend on the stated impact, could the commit message describe the
> cross-netns traffic interception?
>
> > Initialize the private skb queue before any validation so every
> > constructor failure path, including qdisc_create_dflt(), which resets t=
he
> > qdisc before destroying it, sees an initialized empty queue.
>
> [Severity: Low]
> This isn't a bug, but should the commit message say that this reorder
> also fixes an existing NULL pointer dereference?
>
> Before this patch, three returns happened before skb_queue_head_init():
> -EINVAL (hard_header_len), -ELOOP (m->dev =3D=3D dev) and -EOPNOTSUPP
> (non-root parent). On those paths q->q was still zeroed. When init
> fails, qdisc_create_dflt() calls qdisc_put(), which leads to:
>
>     qdisc_put()
>       __qdisc_destroy()
>         qdisc_reset()
>           teql_reset()
>             skb_queue_purge(&dat->q)
>
> skb_queue_purge_reason() sees list->next =3D=3D NULL. That is not equal t=
o
> list, so it treats the queue as non-empty, and skb_queue_splice_init()
> dereferences a NULL first pointer.
>
> This looks reachable with net.core.default_qdisc=3Dteql0. mq, mqprio and
> taprio create children with a non-root parent, and
> attach_one_default_qdisc() on teql0 itself returns -ELOOP. Setting
> default_qdisc needs CAP_NET_ADMIN in init_net.
>
> Would it be worth calling out the crash fix explicitly, for backports
> and Fixes: attribution?
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 70c948a26f809..dc21cd9704a25 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
>
> [ ... ]
>
> > @@ -211,9 +213,12 @@ static int teql_qdisc_init(struct Qdisc *sch, stru=
ct nlattr *opt,
> >               return -EOPNOTSUPP;
> >       }
> >
> > -     q->m =3D m;
> > +     if (dev_net(dev) !=3D dev_net(m->dev)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
> > +             return -EOPNOTSUPP;
> > +     }
>
> [Severity: Medium]
> Is a netns check at attach time enough to keep the master and its
> slaves in the same namespace?
>
> teql_master_setup() never sets dev->netns_immutable. That means
> __dev_change_net_namespace() lets teqlN move to another netns while
> slaves are attached, because this is the only guard:
>
>     if (dev->netns_immutable) {
>         NL_SET_ERR_MSG(extack, "The interface netns is immutable");
>         goto out;
>     }
>
> The move runs dev_shutdown() only on teqlN's own qdisc. The teql slave
> qdiscs on the init-net devices stay linked in m->slaves:
> teql_master_close() only stops the queue, and teql registers no netdev
> notifier.
>
> Once the master is in netns B, three things can happen:
>
> The owner of B, who may be root in an unprivileged user namespace,
> passes the new dev_net(dev) =3D=3D dev_net(m->dev) check. It can then add
> its own devices to a ring that still holds init-net slaves.
>
> teql_master_open() takes the MTU and flags from the init-net slaves.
>
> Traffic sent through teqlN in B reaches teql_master_xmit(), which sets
> skb->dev =3D slave and calls netdev_start_xmit() on the init-net slave.
> Through __teql_resolve(), it also calls ipv4_neigh_create() on the
> init-net slave.
>
> Moving teqlN out of init_net needs CAP_NET_ADMIN in init_net, so the
> unprivileged user cannot do this alone. After this patch, though,
> moving the master seems to be the only way a container can use teql.
>
> Should the master be marked netns_immutable? Alternatively, should a
> netns change of the master be refused, or detach the existing slaves?
>
> > -     skb_queue_head_init(&q->q);
> > +     q->m =3D m;
> >
> >       raw_spin_lock_irqsave(&m->slaves_lock, flags);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
