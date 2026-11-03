Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703863;
	b=Vb1jyhLUe05b8daA65smwU0jIfXrYXFvA+RPv+hpoDCWZKsPr3FynwkqPSacRB/AJ56X
	 H1KA+udyxO++CvJfyKmGQBNqrcn/6fQQRnDiHi21NJSSftc9E0r1e8qx/cR+0EjZYfWel
	 5nA3uuYR7JZNU6LbwxrXjQycv/Qw1w2m3n4jOahD1ZSOmupGWGyTNvYoRHL1UcAPHrSBk
	 +7uU9YleEjAwj0vaO96KCVMrW/nTwZGj8NN+OHn63D5tGb6ncTr+c09c3+p6xUjOUo483
	 x3Es5OhCDvYTY2ElwwgRgHy3EyoYWVgnI1O0yaIZ9MAnglUTVif30Q6IF2tafWwa/Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
	b=AgUdUDJMbbhtJXofwEdgHoJX1wN7X+hA+rkTVVtAi4E4/+m2nQabx9PZorJiwAgNvpIO
	 vNfX4n6S6Df1ef6iw1WexWXgNwbQLS2w9MJkkcqN+m+bbkTKgkXV6+RxUitGATxIJTxem
	 VxCgUOWLUGWkYEEiljGnn5xn/PBjfmd1ft28eCWq2YQWEP6Hz6O3exp4GxyVbtadmhLHS
	 NFzeAPeE6elDFjrkx9IBBfXJ0MKGDS+Ufa7g53rInlWfDi+bu1o8LvW5Zt3+2S4CF7z/h
	 Dn/kgR0dK3wMEjN8KgZwfzZUlQt1pmf8QZr0cyQIC8ibRrK9/s0gbHyjFaI6mMpQ6AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cEIk6BUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7F606BA77
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB7F606BA77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cEIk6BUK
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso2152669a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703863; cv=none;
        d=google.com; s=arc-20260327;
        b=QaHKu1CZxEMfaulDjkwLbV5wUMozBTYwC/Eqyyg5GaN6ZxoKbXiYIoKOUxFT7vSZvG
         aAohuxqv1qhGEYjiLk0FqBLCzWQzBjpnRriDHYQ83ednntjWjrQMYnebYAAkP15DmJ0x
         oeIckT0SEQ1/kjnmVfylUNALVq7528reuRXcA3JDhynYg9tZHuxq1xiiCFTHHECxLZ3W
         Z8Mlwt0aPzytIz4vY3VfR4J7WU6pBrl6gNjjo07x8+KIVCJi7zRIpCgWHIlY4/aZSwKk
         Q0svU/mhlzXn9D7/KlIsDletWeud88Cf/0j4rtp26BH4t6yK1KnuVQDoHCqXo5Zx2sMC
         f2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        fh=Wb9DVDULmpc6j8VpUw/87dSUm8bUBKa2Tfv3D2tp0ZI=;
        b=UXqrynfAJlcfXPEpkJ50SSPtUv18hJAf0IRGin6A56PMi6dp9yeBb+kK7DO608Q7ec
         yfp2/p9iWxHjvD47onihJjE0RJp9z0EtTm313apB1e5AKqvoj1qMP4Cz5aplWFPrAF+y
         bFiABEK+xYoafvh/oKLWux7//8Sek9WnePeM9KRfhe8raZ5Utg5jiWo5rFMYDn3YAmGR
         RzIJ6qs688+3AvUL2XKNeIrizc0xETHAw/nfg6KuiEuiN5KRz1Y5u8ItyEvOIOTJzmxv
         L99TyZ3DEgyfYuMcbXm6jjXxeoo688Z421k6RvihU+h5h0pDA6OB90WVemr/28le6rUh
         XSKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703863; x=1794308663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        b=cEIk6BUKNNrstBnq1gVT2sp/ppmTqr6iugiER4Sl8QQ1Iw95mgVDmfaEBP2WMoYaPG
         Hr7IV54AUpbjPO/goo6B59UyzKdLt6qHE3MS/zyi9oKHGd7IumnPTnxaEiP5zkMOGTAx
         qLOeJ18yrdFVAP+pyPqbDEM7dD4oDU9xcZP44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703863; x=1794308663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ihq6fFi6/Py7vQ5miYBdO3v37BD8vmOxVL3kmQ5hPfA=;
        b=NHBhQ85BAtkkGDCBjUio9f8fnbs+5I/YIB6gZeC2QK3ElFiXN5aDhscYU7RI5XTto2
         0z4CwjDzhJTVpayrLVwdteOjzN8ba21BFcAeaqtjbN8i1iiy9NvsH33m2g4rH1pxYB4n
         zbPPEC1GMKPX/bHzrAiWZNmdEpeYwjOTXW/njPrdHHyI1XjpmOJaQgOIgXyq5BZWJsGM
         S9zOqOaOMt1cbrrVSjv8cQhZ5bD9i64v8IYLUQ+YbP0OWwBS4UWVJGKPqJny8mHWZR1p
         Hp+jTujuF8i2jr+FUkPeeaxKPN/arXLgUwg0fIwN8XqtAA2cbYOBOz8ibFW8uxee3DC3
         V7Ig==
X-Gm-Message-State: APuU4Z8KkmrlGnbES4lnBx/CIHDLhcZ2LqhO62+8aTmT+B1JldSBa0cp
	C4/EQQ2LVX43800RKBtp60jlgXaYMNquEUl8uxVTxUmJhNIqL4Q7qN6JRvHedTIZYd2rd5VgN5J
	giVasqYIGtAKH07o0RroKXYwdEHKQevYFCK9gggY7
X-Gm-Gg: AYBFou37V28kf8UP80c30ftX6lbcfD7/TkxCsacm1cLgqGtzvJcs6vcNofyK0GAutVm
	xPyvqqSwvHHGpjNa3LDgGZvYNjJIN/J4eX5dciOMJJJssFeSuxglPKMQjQOOL5JlxSeYorLhcRb
	583QLkheoWvUilddlzE4JlOgdtZ13FPA30bIRuwjNTfmHdn23G5V966kr3o61z/ipMsVnH5BB4I
	5T40pb/6Z8bWCrKi/rSeyKiO+2PR1u8tV0plFKSDhdk/nv5b/pHEMp7Ej5/acR9qsmyP4ZNqtoe
	MrwrtbXDZryuWxZLoHPvdQboRLIq0FeypRhbRtsuYrQabLrQvtje1jHLGf/xdp72B6/V9rWkg2y
	FAymdI3cxSz7LLz8Wj/EBUWvCTuKmlII0R2z0OfG0sgcb87pf5X10LuqfM8dUkWoVd0KSRuKzsW
	ye+nAZOeOqohX6nfg=
X-Received: by 2002:a05:6a21:8809:b0:3e1:4527:6350 with SMTP id
 adf61e73a8af0-3e928e16ca9mr8996830637.64.1793703862587; Tue, 03 Nov 2026
 03:04:22 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v2.r0.20261101171325-3@mojatatu.com> <179366641863.488856.17368571591466000274@kernel.org>
In-Reply-To: <179366641863.488856.17368571591466000274@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 06:04:11 -0500
X-Gm-Features: AclHuK_7WMAkLafIRWU2ORlMWzjxOnh31UgwAxu8axG1fGQl-__VNHwZVi8gZuo
Message-ID: <CAM0EoMnaxs4h5jRGX8Fw_oXh608WdEJo_9QAFTgmTbHcgN-BgQ@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:40=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix only enforces the master/slave same-netns rule once,
>   when a slave attaches.

Nothing to do with this patch - preexisting. Captured for a followup.

> - [Low] After this patch, tc-testing case 124e ("Try to add teql as a
>   child qdisc", tools/testing/selftests/tc-testing/tc-=E2=80=A6

True - 124e is now answered by either check, so it no longer isolates
the root-only rule. I will send v3.

pw-bot: cr
> --
>
> net/sched: sch_teql: reject qdiscs from another network namespace
>
> With this patch, teql_qdisc_init() rejects a teql slave qdisc whose
> device is in a different network namespace from the teql master. It
> returns -EOPNOTSUPP and sets an extack message. It also moves
> skb_queue_head_init() ahead of all validation, so every constructor
> failure path sees an initialized queue.
>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.=
20261031160050-3%40mojatatu.com
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
> This checks the namespace only once, when the slave attaches. What keeps
> the master and its slaves in the same namespace after that?
>
> teql_master_setup() does not set dev->netns_immutable, and sch_teql does
> not register a netdevice notifier. So the master can still be moved with
> "ip link set teql0 netns X". __dev_change_net_namespace() only refuses
> the move when netns_immutable is set, and it only shuts down the device
> being moved:
>
> net/core/dev.c:__dev_change_net_namespace() {
>     ...
>         if (dev->netns_immutable) {
>                 NL_SET_ERR_MSG(extack, "The interface netns is immutable"=
);
>                 goto out;
>         }
>     ...
>         dev_shutdown(dev);
>     ...
> }
>
> The slave qdiscs sit on other net_devices, so teql_destroy() never runs
> for them. m->slaves and NEXT_SLAVE() still point at devices in the old
> namespace.
>
> After the move, teql_master_open() takes its MTU and flags from those
> slaves and teql_master_mtu() checks against them. teql_master_xmit()
> also sends the master's traffic through them:
>
> teql_master_xmit()
>     struct net_device *slave =3D qdisc_dev(q);
>     ...
>
> Doesn't that bring back the cross-netns master/slave state this patch
> is trying to remove?
>
> There is also a way back into init_net. teql0 has no rtnl_link_ops, so
> when its netns is destroyed, default_device_exit_net() moves it back to
> init_net:
>
>         err =3D dev_change_net_namespace(dev, &init_net, fb_name);
>
> Suppose root gives teql0 to a container netns B. The container could
> attach a slave in B, move teql0 to another netns C that it owns, and
> then delete C. teql0 would end up in init_net with a slave on a
> container-controlled device in B. That looks like the case the commit
> message describes.
>
> The first move out of init_net needs CAP_NET_ADMIN in init_net, so this
> patch does close the unprivileged reproducer in the commit message.
>
> Could teql_master_setup() also set dev->netns_immutable =3D true? Another
> option would be to detach the slaves when the master changes netns.
>
> [Severity: Low]
> After this change, does tc-testing case 124e ("Try to add teql as a
> child qdisc") still test the root-only rule?
>
> 124e requires nsPlugin, so $DUMMY is created inside a per-test netns.
> teql0 is always in init_net. The root-only check and the new netns
> check both return -EOPNOTSUPP. 124e only checks the exit code and an
> empty matchJSON:
>
>         "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 2:1 t=
eql0",
>         "expExitCode": "2",
>         "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
>         "matchJSON": [],
>
> If the "teql can only be used as root" check were removed or broken,
> the netns check would still reject the command with the same exit code.
> The test would still pass.
>
> The v2 notes say:
>
>   The cross-netns check ran before the "teql can only be used as root"
>   check, so every case it did not catch was answered by that check, maski=
ng
>   the assertion that tc-testing case 124e makes.  The root-parent
>   validation now runs first and the namespace check second
>
> The new order only changes which check fires first. Either way, 124e
> cannot tell the two checks apart.
>
> Could 124e run in init_net instead? It could drop nsPlugin and create
> $DUMMY in its setup, as 84a0 does. Alternatively, it could check the
> extack message.
>
> >
> > -     skb_queue_head_init(&q->q);
> > +     q->m =3D m;
> >
> >       raw_spin_lock_irqsave(&m->slaves_lock, flags);
> >       first =3D rcu_dereference_protected(m->slaves, lockdep_is_held(&m=
->slaves_lock));
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v2.r0.20261101171325%40mojatatu.com
