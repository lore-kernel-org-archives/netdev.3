Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506749DBBA
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557814; cv=pass; b=oN1O/dkoszjsR2/mlrA/YeIaXB4xWH6eIsG7gEA+XzLj/pEEQJP5CwMwV58QuT/cjQuCuZhaxWq+c5xXSIAfEeKHZY2uGWFWdJ/wLtanJIxSHNpxmmVhW2LS76RVSlZOMCcHecwDyRREujusAbEq0PH4scD0flbSfk2CAXbVdyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557814; c=relaxed/simple;
	bh=RDc54bT9OWxGIWUorn7bZp0Jv9F6JiXajua9F2dPTLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhg89yP9BZrp5nLKa6t++hn4jpukbcTkLqAlXFmlxD544HZBEp7/9olBTe1WYQcnZ5vfnOwZYLenMd7D/HFgUCuDlZCbDqbcSIi5baEvF8Ox9Kc7sm0OCntuxy0c0u6FtQCA5uYU3WZa0zHretWaxpvrkbfNWqEfFUxBWsrFpTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BKZ5y5VW; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BKZ5y5VW"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso514367b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789557799; cv=none;
        d=google.com; s=arc-20260327;
        b=q0O0kt4TRB7Mb//Ugs7Jl1ZLmn6BPYFo8Hx2nufRKExbaBozoe9HcZma+5WzC9iq6r
         qxOIdaXyAijdZR0kTVsUT5N6wtfDI+XDNf2L51NZBKk4V8khsejgZMKcCKrMRQlCyscx
         qb7x/gUDw3b5D/YTtPbOw12GNUschPTQx1IdnQHu7zd5i0hCUKtAnztnriV1obAOardv
         NPJ24R077Ea6GFvAahUtwRzWuHtlr5DesVjlCmwTDlexmnrlHylLFKadcsMbfiOs0Gd6
         CwLygryqHr/UYy8XlmVwYl1XLQXGc/J3XSekUW/WxbIzuiSyJVD18bLdcHE8x1p27Xvp
         agrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AONOafjW7txCDGIo29C5fL0XBE9LCcUGG/YpNgguHqA=;
        fh=Ck+Ss38EkPx63nO47Ke8PbOPXUyk24XZeNmR5bR3qa0=;
        b=eoVK5wuEsMzuNHlx7+onPqowPvWu/P2MPYLxLLeef1dw188zEurnjoCBI4GbcIYwOv
         ldUoPN7qe/2Gk5c76vDBU/JYBVDElHcQgsQk8+m3pKcGlficHx8OgIU5gaGTaVHXgjP/
         y/3zPOrEdHrDoXWeTCWKN7nQYpgBeVIcux6xJt3II2F8YmxdqeP25UJw7Hy6mX5TBKrQ
         KGuQ5hNTpT2vEgm6VXv920BEqfHirgD/3h2vbLP8Zzh7wICMslwbtB68IUDAiznXDxit
         1R7thHTBlCvtJvrzgxItgPaPKPFHIR0W8iVtBQOGg0KogzD0NZJdczRX10xWGGEfipzC
         TajA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789557799; x=1790162599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AONOafjW7txCDGIo29C5fL0XBE9LCcUGG/YpNgguHqA=;
        b=BKZ5y5VWobcLoWVoafTMrgt0V4aJSGSenwGa79gNZ+KGJU82l6HXRU3kYeQEqSrrBR
         uekmvFWYIC1SHCbCpBIspgdciRTLixEbnOj+zi4aJ5aoBxwklXw2g4l0Uzc8xarxPxew
         Mu4T/ji2aephKUNzN6HjOxSRBg9s1CVO4RZo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557799; x=1790162599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AONOafjW7txCDGIo29C5fL0XBE9LCcUGG/YpNgguHqA=;
        b=G2UKksQF9srmZKOEY+Moc/226tWW1XVEMPXCnX+o5fTjkPt2VIiAKcY+YpJHr1TZgp
         KnrPG5mcGju6SxjN9Z8KJWnhaEeCsWttY9p/i8fjHFw4u1EF2ugNTZNMHs3ac3DQyHmC
         nQDO2LqJUMA2AbOFubeloIR+IMMwpCdQqa/7CiVWNSVwVqJKd5ys5v27RJa1CqtcoQD+
         14xFJv24qe30DbdHPeCkhIWawkhTqciqwxcLnZgL4lSdBXGDHlX2f48P8AIyCI1myTLZ
         Du6r9wLWgtC0FY1/TA5Tay2OG4x19Z4w/yzQag8yQLDwM40RdSdXZ0TuPuQM9ltRm384
         SuOg==
X-Gm-Message-State: AFuF++mkzfpJi2exqVPzqXsaPFr4UK+yGCEHgGyD5YBWvE4s2Syxlzkp
	R2jFZKUqLae1JH3EmCbawcH1iTAEEs4EfxLtZUqOw9QEn0GGhJgwdWS9hsiI7bkdsAmSaAVxZLr
	U7ysgN/id+scGOG2BwRWvfOmPKcFkS+yjQrj+NZ4n
X-Gm-Gg: AYBFou2KSZEXoJxrCqe0HB9WD4ym85luzWvIKnI388yBEdXyPJUwid4XF0VblpmGAVg
	dzNVjX64nwE6Jb/ZQ24FT4kViwOUUfSBC0oBDRjIUdAAwKSWX1jru74rrffHMIL6+keyeDAZ4+h
	b5LNskgkfIQ3Y9pVjUKcFpNGcdtaXsnLSnjKmzcxamr1RlEHbqHnr8xAKSN97bTDwDpNxva8W1+
	sGtsA78/0MvMQd1I0q5iESL5UOsLhtd4l0BPeMuhuX3nYHHEGgU7J56wSZAUNeVnzvv8XwSAXf0
	EL4f9RIWZHgraYsvYwpvoY217q92cC5skRfyTJdstHQxI9SPG95BWQ9TGhe9CgzjAEHxdaa6j13
	L4/G+xXpwH0kq8Fk5FlyVFj+Lsvrvyi0h3WKe7qBRYXJ3
X-Received: by 2002:a05:6a00:23c7:b0:851:8394:1696 with SMTP id
 d2e1a72fcca58-87238e871dcmr4344966b3a.12.1789557798929; Wed, 16 Sep 2026
 04:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-CTUU.v2.20260913192615@mojatatu.com> <178946024991.22033.9851836059395249894@kernel.org>
In-Reply-To: <178946024991.22033.9851836059395249894@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Sep 2026 07:23:07 -0400
X-Gm-Features: AcwNN1XDSPG3hPcFS2Wf5Gps4gxrNKWDiaXmOLji8LaW66a5ANT9g-_DiVK3iQA
Message-ID: <CAM0EoMke_zOc1DC=AGNNKzftzvMJrruaD9tAg8gY+wEQ_pWcuA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: tc-testing: add a lateral-drift
 hfsc classify-walk test
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, sashiko-bot@kernel.org, hybris@mojatatu.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:17=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 0
>

pw-bot:cr

cheers,
jamal

> - [High] Test 8c39 ("HFSC classify walk still reaches leaf after lateral
>   drift") never exercises the new lateral-hop drift budget in=E2=80=A6
> - [Medium] Test 8c39 makes the qdisc's default class the same leaf it
>   asserts on: the root qdisc is created with `hfsc default 31`=E2=80=A6
> - [Medium] Test 8c39's cmdUnderTest is the compound shell command `ping
>   -n -c 10 -W 1 127.0.0.1; sleep 1` with expExitCode "0"=E2=80=A6
>
> --
>
> selftests: tc-testing: add a lateral-drift hfsc classify-walk test
>
> This adds tc-testing case 8c39, which builds an HFSC hierarchy with
> lateral filter binds (root -> 1:1 -> 1:2 -> 1:3 -> leaf 1:31), pings
> through it, and checks that packets are counted on class 1:31.  The
> intent is to show that the new classify-walk drift budget does not
> misfire on a legal lateral chain.
>
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.js=
on b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> > index c98c339424d4e..82d2f8af1460d 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
> > @@ -169,5 +169,39 @@
> >          "teardown": [
> >              "$TC qdisc del dev $DUMMY handle 1: root"
> >          ]
> > +    },
> > +    {
> > +        "id": "8c39",
> > +        "name": "HFSC classify walk still reaches leaf after lateral d=
rift",
> > +        "category": [
> > +            "qdisc",
> > +            "hfsc"
> > +        ],
> > +        "plugins": {
> > +            "requires": "nsPlugin"
> > +        },
> > +        "setup": [
> > +            "ip link set lo up",
> > +            "$TC qdisc add dev lo handle 1: root hfsc default 31",
> > +            "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100=
kbit",
> > +            "$TC class add dev lo parent 1: classid 1:2 hfsc rt m2 100=
kbit",
> > +            "$TC class add dev lo parent 1: classid 1:3 hfsc rt m2 100=
kbit",
> > +            "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 5=
0kbit",
> > +            "$TC class add dev lo parent 1:2 classid 1:20 hfsc rt m2 1=
0kbit",
> > +            "$TC class add dev lo parent 1:3 classid 1:30 hfsc rt m2 1=
0kbit",
> > +            "$TC class add dev lo parent 1:3 classid 1:31 hfsc rt m2 1=
00kbit",
> > +            "$TC filter add dev lo parent 1: protocol ip prio 1 u32 ma=
tch u8 0 0 at 0 flowid 1:1",
> > +            "$TC filter add dev lo parent 1:1 protocol ip prio 1 u32 m=
atch u8 0 0 at 0 flowid 1:2",
> > +            "$TC filter add dev lo parent 1:2 protocol ip prio 1 u32 m=
atch u8 0 0 at 0 flowid 1:3",
> > +            "$TC filter add dev lo parent 1:3 protocol ip prio 1 u32 m=
atch u8 0 0 at 0 flowid 1:31"
> > +        ],
>
> [Severity: High]
> Does this setup order actually build the lateral chain the test needs?
>
> All of the child class adds (1:10, 1:20, 1:30, 1:31) come before the
> filter adds, so by the time the lateral binds are issued 1:2 and 1:3 are
> already interior classes at level 1.
>
> For "$TC filter add dev lo parent 1:1 ... flowid 1:2", the class 1:1 is
> passed as the bind base, and hfsc_bind_tcf() rejects the bind:
>
> net/sched/sch_hfsc.c:hfsc_bind_tcf() {
>         ...
>         if (cl !=3D NULL) {
>                 if (p !=3D NULL && p->level <=3D cl->level)
>                         return 0;
>                 qdisc_class_get(&cl->cl_common);
>         }
>         ...
> }
>
> With p =3D 1:1 (level 1) and cl =3D 1:2 (level 1), p->level <=3D cl->leve=
l
> holds, so 0 is returned.  __tcf_bind_filter() then stores that as
> res.class:
>
> include/net/pkt_cls.h:__tcf_bind_filter() {
>         cl =3D q->ops->cl_ops->bind_tcf(q, base, r->classid);
>         cl =3D __cls_set_class(&r->class, cl);
>         ...
> }
>
> Nothing is propagated back to userspace, so the tc command still exits 0
> and the setup step looks like it succeeded.  The same applies to the
> 1:2 -> 1:3 filter.
>
> At classify time the second hop therefore has res.class =3D=3D NULL and t=
he
> walk stops at the pre-existing downward-only check rather than at the new
> drift check:
>
> net/sched/sch_hfsc.c:hfsc_classify() {
>         ...
>         cl =3D (struct hfsc_class *)res.class;
>         if (!cl) {
>                 cl =3D hfsc_find_class(res.classid, sch);
>                 if (!cl)
>                         break;  /* filter selected invalid classid */
>                 if (cl->level >=3D head->level)
>                         break;  /* filter may only point downwards */
>         }
>         ...
> }
>
> 1 >=3D 1 breaks the loop, so the drift budget is never consumed and the
> test would pass identically with a bound of 0.
>
> Related to that, the commit message says the chain is built "with 1:2/1:3
> deepened to interior level 1 after the binds", but in the setup list the
> deepening class adds precede the binds.  Should each deepening add follow
> its corresponding lateral bind instead, i.e. bind 1:1 -> 1:2 while 1:2 is
> still level 0, then add 1:20; bind 1:2 -> 1:3 while 1:3 is still level 0,
> then add 1:30 and 1:31?
>
> The commit message also states "on a too-tight bound it would drop the
> packet instead" - with the current ordering, is that still true?
>
> > +        "cmdUnderTest": "ping -n -c 10 -W 1 127.0.0.1; sleep 1",
> > +        "expExitCode": "0",
>
> [Severity: Medium]
> Which command's exit status does expExitCode compare against here?
>
> tdc runs cmdUnderTest through a shell:
>
> tools/testing/selftests/tc-testing/tdc.py:exec_cmd() {
>         proc =3D subprocess.Popen(command,
>             shell=3DTrue,
>             stdout=3Dsubprocess.PIPE,
>             stderr=3Dsubprocess.PIPE,
>             env=3DENVIR)
>         ...
> }
>
> Because the ';' is a shell separator, proc.returncode is the status of
> sleep 1, which is always 0.  Does that make the expExitCode "0" check
> unable to fail even if ping is missing or loses every echo request?
>
> There is a second effect from the compound command.  nsPlugin prepends
> the netns wrapper only to the head of the split command:
>
> tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py:adjust_command(=
) {
>         cmdlist =3D command.split()
>         ...
>         cmdlist.insert(0, self.args.NAMES['NS'])
>         cmdlist.insert(0, 'exec')
>         cmdlist.insert(0, 'netns')
>         cmdlist.insert(0, self.args.NAMES['IP'])
>         ...
>         command =3D ' '.join(cmdlist)
> }
>
> So does "sleep 1" run in the initial namespace rather than in the test
> namespace?  Would putting the delay in the verify step, or dropping it,
> keep the whole command inside the namespace and let the ping status be
> the one that is checked?
>
> > +        "verifyCmd": "$TC -s class show dev lo",
> > +        "matchPattern": "class hfsc 1:31 parent 1:3 rt.*\\n.*Sent [0-9=
]+ bytes [1-9][0-9]* pkt",
> > +        "matchCount": "1",
>
> [Severity: Medium]
> Can this assertion distinguish a successful lateral walk from a failed
> classification?
>
> The root qdisc is created with "hfsc default 31" and the pattern counts
> packets on class 1:31, which is the same class the default fallback
> selects:
>
> net/sched/sch_hfsc.c:hfsc_classify() {
>         ...
>         /* classification failed, try default class */
>         cl =3D hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
>                                        READ_ONCE(q->defcls)), sch);
>         if (cl =3D=3D NULL || cl->level > 0)
>                 return NULL;
>
>         return cl;
> }
>
> Any classification failure - a rejected bind, an early downward-only
> break, or a future misfire of the drift guard - still credits the packets
> to 1:31, so the tc output looks the same either way.
>
> Would a default class distinct from the walk's terminal leaf (for example
> default 30), or a default that is not a valid leaf so failures drop, make
> this test able to fail when the guard misbehaves?
>
> > +        "teardown": [
> > +            "$TC qdisc del dev lo handle 1: root"
> > +        ]
> >      }
> >  ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-CTUU.v2.20260913192614%40mojatatu.com
