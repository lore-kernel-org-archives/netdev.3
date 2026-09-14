Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934037D10E
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411752; cv=pass; b=uSGQdxdLNpRL6cZ/JD7Ny2xGsfqg6ezgOefn1O3rIU4/sjWwmlQJ2pMeYGWDVa7RMatmzFucb330kH4LXCY7y/7rdhV0AMJjiZU4X4c/x2XJlCRjo7NnB0XH1yloUOWSqy3y6z2+J7j+VRe4UBVsymUrGp6pPm+MtbI+Q/2hMw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411752; c=relaxed/simple;
	bh=I5y/x3zg8Ny/i9s4perD0XJoBAOwFnm4Qoo1X9dewqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMEFduSPIJjqNXd3sNVJmuRTHAuqBUvckqy/2powAz+G+Ds7X4JUxnaJSgFiGooIY9bpJxqNN2cqCa+i5NwwGLDjsHOyKXOmj+BkMRTDLtTAaSNQo1E+Kye/0qc4EHeK8pyZSbhlI/Uso+Ovpb7FSetIWLb69up0+wOAhoAVEHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdFt8hUH; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdFt8hUH"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so2172837a34.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789411746; cv=none;
        d=google.com; s=arc-20260327;
        b=LP0GgNaLQYx9cw3Qot35EN/stmaYHEOhfCOIK0dUzPtMEWrHTMWzmTmT83cN2V0bOf
         2XDc/UmDXnhSznn3df4NX7X88p8kYiUz9PYUcCGJt763sqEBxOinrtxdpmBOzsUV3WNG
         laxY6yQHtVpa/NGFM+pcIPNRDN9JDQbazjk+kuehUJtdQwARWL2W/BVhPLE98MgYgmEI
         UxgWDfHop6iaXJ8GBm1ajzZsvgm6iU3Ve7EzjcrFE0sQ0I5c5HIa19mh0sp8+K3tJQLY
         wmTexTqOVbsMV3ZtxfFry6GHuXeQuO8o319iP05jb8bFMrka6IceFKjQnEBwmrytYmGr
         bgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fgjYAnCNIvmMVVgUnMQbGXatUXySQpQ8c1S2uxWfzQ=;
        fh=jqz8VYI+L44m4auVtSrXTXO/m6Tc8PLEkg7eQ2ry/uE=;
        b=oziCPNVK6DZW0/cbddYX4z3uLI7AFNZZIzFBkpJw5RIaePine+p8OcFE7IItioY7OZ
         desjy0kEGAwbOquAmYml9i6TjfKH0Mf+QOY36VkYHRW9OmKG0lVDW/S5Bv0gZTYTrDGf
         cmmcDyxrSH+7fOI2rIVE6pkOpaGbU3gTKDtGYYEZlmN7qXnAnjfJlxFX9jqmTwAvxv/U
         zhg4bPos7kKePluuaJNFSv+WNaJHJOsUKuZ92Hry1ca6bT/jDmdi3xCRX7zhJmTQcqmK
         I4c7J86OlWo3wdwdKF4odgxMsYD4VQg59wWc0StV7DJC4YzDJoFSstMEbV2X1RN7o4kR
         9YGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789411746; x=1790016546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fgjYAnCNIvmMVVgUnMQbGXatUXySQpQ8c1S2uxWfzQ=;
        b=PdFt8hUHcg7GKQj3LULup8a6WiywKqQkxA7PtGCfal9Gi0kRFAR9Dy7AXyZL7ySwNK
         TwgRf+OCGvCoxqugWXGS4CccgmPWyqNov3KQUlALBRhPiKDvIq6Hrcaf5D1gdjELNpVv
         a5YntiVOMu+f6TzicspYuJzm6gXmJ4Bi6Mn3ryqVuIsytyNsbpq/NXe1NyvEefkyQKdN
         g6iXC+gbqhyF486lE+sDIy0fo9gDt5mo4AtgJfcBEg5hqV5TdstGPSOeFHG+Ev/s1ZEU
         iTycbim51eQdBzZwIE4gr5ZvQqDP4trNSzcXQAy42My6yfPDPDxLQEx/+OXbJQ0bPg2u
         iDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789411746; x=1790016546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fgjYAnCNIvmMVVgUnMQbGXatUXySQpQ8c1S2uxWfzQ=;
        b=JvWBno0EPHLcG3ugOz8Rz8DLiXW60PWQbd965vwmiLw7+9uSPeAi4LxshpB1Jlz0Yf
         1bfhwrBX7HH19UmKoYEfIa3/K+TIcQMv1iZRBALvXUp2yoK7QZKjnYKXvk0Y/+lmOqIY
         vL0Dluk2OHzwoHoWIDv6WVwF5IItPmh8rMc8pl1Kvo9sE3bOX4bxVNYfcxwjZ9VFOdlR
         qyb4RGiLx9tpwvOfOtyYSh8PgM+0qUVbQXzEpLLZyWSjNgHOuHY0MfVx0dS4GlLogEQd
         INtG3cJz8plkAhzSqwwBXysNk0NE/QerGvnv6Mo9uaGXalCHMdNWTIXWtf8roo4keASW
         fy7w==
X-Forwarded-Encrypted: i=1; AKwUvBxsHsMzim66v4pwihyz2uTrQoNHUtycaGry2I38tT/S9c/whUW6DTUxVYZ20ovjFbzPXiezAgo=@vger.kernel.org
X-Gm-Message-State: AFuF++komEVZ1GhCYK+VGJ6KwnSKQMech+5GVbSoNHxOgrLXC+8eihnE
	/J3VkVDisBewYZN67l1CftgxRbpEEMu1MHsvhLB8hltOl1RKjjJ3H/oQm/oIAe7tq3Cba5Fvn2I
	aqad3FSQrfWEEcfZZ4nDMlM49TD3PJbVX7eLvJEr7
X-Gm-Gg: AYBFou2/mGGMcClV0vJhRQ3QJKMwOlz+YraD+c8/FeUNMjtQ4AGJnApoJsP8SSjK30d
	KGusg9AByKSmQXIf8GIQoVqzJtk5g4YTCB4e+n4XAlJrNKDI/61iU9CCQspoJ84cgbEr1GkyRet
	xnUXe4xQzfZwF4KWxxBNufQ6B6BsIiVhQvWF48+tzUhsRJMApM89+rPnB4W2Bdi51DIqnd8JZ4T
	L2WU0Dh8IUCxaNqsgp0qc+8zPARxb2327WT2Lj6/c7uM5Ox1CkXvpr7fbghI7R2HyroVHfqpQWn
	hZRulFUc8Pj8Cj0FRCfTU9q/oSqcNRxvHCrqEis6PExMifGn/6hdQrAGR5UHSC0kHpJN3ATIbM+
	UmLuJmigFe/h98P0DnRFQXo1a/RtXT1Zplr0J1M5fpyrSCbVUtp9HbO/FaGN/tB0JQ3/pp7t9dE
	o8kM+vBYMgpCTP11p3smG7MryTlw==
X-Received: by 2002:a05:6830:6d23:b0:805:7395:3db4 with SMTP id
 46e09a7af769-8089974bc35mr4950561a34.12.1789411745697; Mon, 14 Sep 2026
 11:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
 <39ed6ba0-bef0-4710-9790-ab13092521b1@I-love.SAKURA.ne.jp>
 <591e7555-a399-4753-becb-b00df2df660d@I-love.SAKURA.ne.jp>
 <56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp>
 <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp>
 <d0d5bb33-c9fb-4442-9015-7999f91b4e29@I-love.SAKURA.ne.jp> <CANn89i+-pNgDa1TEs3TYCoeHhf6_eeLuQ7jhpzDZvEXc+3WkcA@mail.gmail.com>
In-Reply-To: <CANn89i+-pNgDa1TEs3TYCoeHhf6_eeLuQ7jhpzDZvEXc+3WkcA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 14 Sep 2026 20:48:52 +0200
X-Gm-Features: AcwNN1Ui9KNy01_dk8NiW12z7_kNg-gLkKZZ3QyPz320ynOwp--FSDRYt7i5O4g
Message-ID: <CANp29Y7hm+ehJ4+whyBtRtDMUcGXH=ee6aCrFMAMWL9k-G8ZJg@mail.gmail.com>
Subject: Re: [PATCH v3] net: track raw dev_put()/dev_hold() usage under CONFIG_NET_DEV_REFCNT_TRACKER=y
To: Eric Dumazet <edumazet@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Vyukov <dvyukov@google.com>, 
	Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 14, 2026 at 3:24=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2026/08/29 23:58, Tetsuo Handa wrote:> syzbot is still reporting
> > >
> > >   unregister_netdevice: waiting for DEV to become free
> > >
> > > problems. There is netdevice_tracker which helps identifying culprit
> > (...snipped...)
> > > ---
> > > To: Eric
> > >   Please see off-list mail <e2f7c53b-fe15-4047-8149-145c91de297f@I-lo=
ve.SAKURA.ne.jp> .
> > >
> > > Changes in v3:
> > >   - Repost as v3, as sashiko's review comments at
> > >     https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e51=
3e@I-love.SAKURA.ne.jp
> > >     was addressed. I assume that no more technical problem remains, a=
nd only how to split
> > >     this patch into several patches for getting approval from relevan=
t subsystems remains.
> > >
> >
> > Sashiko did not find problems with this version
> > ( https://sashiko.dev/#/patchset/271af679-34c1-4f7e-875c-4761c22595eb@I=
-love.SAKURA.ne.jp ) .
> > Any questions?
>
> I am adding Dmitry and Aleksandr to Cc, because I think the best answer
> to your problem is not a netdev one. More on this below.
>
> First, sorry for letting this series sit for three rounds. You are one
> of the very few people actually chasing the "unregister_netdevice:
> waiting for %s to become free" reports, that work is not fun, and
> silence is not the answer you deserved.
>
> Let me also say clearly that I do not think the approach is bogus. Once
> a reference is taken without a tracker, there is no slot to store a
> cookie in, so counting +1/-1 per unique stack and looking at the balance
> is essentially the only thing one can do. And 10 bugs fixed is more
> evidence than most debug facilities come with.
>
> My problem is the cost/benefit for mainline. This adds a field to
> struct net_device and code to __dev_hold()/__dev_put(), which are inline
> and expanded in thousands of places, in order to produce information
> that is strictly weaker than what ref_tracker already gives us (a stack
> balance cannot tell which hold was not released when the same call site
> does both). It is a workaround for an incomplete migration, and we would
> be carrying it forever. Even with a perfect implementation I would be
> lukewarm, and I would rather tell you that now than stay silent again.
>
> But you should not have to wait for netdev consensus to get the data you
> need, so:
>
> Could syzbot run a dedicated instance on a branch carrying this patch?
>
> There is precedent: KMSAN lived out of tree for years with its own
> syzbot instance, and that is exactly how it accumulated the evidence
> that got it merged. Your real requirement, as I understand it, is not
> "this must be in net-next", it is "the mechanism must be present in a
> tree that syzbot builds", because the remaining bugs have no reproducer
> and #syz test is therefore unavailable. A dedicated instance on, say,
> linux-next plus your patch would give you continuous coverage on exactly
> the bugs you cannot reproduce, immediately, and without anyone having to
> agree first.

Normally, syzbot fuzzes kernel changes across different environments
(qemu, various gce machines) and architectures (amd64, arm64, riscv),
but adding just one dedicated instance, which would get much less
compute than the rest of the syzbot fleet, IMO offers very little
benefit over just casually running syzkaller locally.

How to organize this is also an interesting question. Applying the
patch on the syzbot side would make syzbot show non-existent commit
hashes in the reports. If there's to be a separate branch/tree that we
would fuzz, it really must not lag too far behind linux-next/torvalds
- the community is very annoyed by outdated reports.

Speaking of the absence of reproducers, I think we should start by
cleaning up the existing open bug:
https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd

Currently, it is an umbrella for many different crashes accumulated
over many months. It also has some reproducers; some were even found
recently. If we keep closing this bug after fixing the root causes
found by the open reproducers, syzbot will keep on discovering and
reporting new ones even without an extra debugging patch.

A small related question: should we report it per-device type, like
`unregister_netdevice: waiting for netdevsimNUM to become free`, or
would that only create duplicates, and it's better to keep everything
in one bucket?

>
> It is not free for you: you would own the branch and the rebases. But it
> also turns the discussion around. If the instance produces a stream of
> diagnosed imbalances over a few months, the case for upstreaming becomes
> an empirical one rather than a design argument, and I would find it much
> harder to object to.
>
> Dmitry, Aleksandr, does that sound feasible?

Tetsuo, based on historical experience, how many issues do you expect
to detect this way?

I can imagine setting this up as a short-term experiment, but I still
wonder about the benefits of having it specifically on the syzbot
infrastructure.

>
> If you would rather still pursue mainline inclusion, here is what I
> would need, roughly in order of importance:
>
> 1) The per-call list walk has to go. Today every __dev_hold() /
>    __dev_put() walks a per-device list doing memcmp() of up to 160 bytes
>    per node. With a few thousand distinct traces on a device, that is
>    hundreds of KB of memory traffic per refcount operation, and it gets
>    worse precisely on the devices you are investigating. I suspect it
>    costs much more than the stack_trace_save() itself. stack_depot_save()
>    gives you a handle, and a small hash of { handle -> atomic count }
>    makes this O(1), removes the 6 MiB static array, the global raw
>    spinlock, the sticky "exhausted" flag and the dedup pass at dump time.
>    Ideally this lives in lib/ref_tracker.c as a "count only" mode, so
>    other ref_tracker users benefit and net/core/dev.c gains a few lines.

FWIW there were any stack traces in the reports at all, syzbot's AI
repro generation (which we are piloting now) would already be able to
kick in and generate reproducers even if syzkaller fails.

>
> 2) Do not overload CONFIG_NET_DEV_REFCNT_TRACKER. People enable it today
>    expecting the cost of one stackdepot entry per tracked reference. A
>    separate option (default n, depends on DEBUG_KERNEL), ideally behind a
>    static key, lets them opt in knowingly. Some numbers on the slowdown
>    would help too.

Upstreaming it under some separate option would be the best approach
for syzbot - we could then just enable it on all our instances.

< ... >

--=20
Aleksandr
