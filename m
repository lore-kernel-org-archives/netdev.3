Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029C474273
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386258; cv=pass; b=HFXuuFMKjsAz/z1d8p1MS9qRjaOyVJHO4cCNnQYBDQNWr5IQ1+vWkyMwYEH7NcIeamZtGaq/gsF22RJwLJOQTlPOxChRAre1kK1r9kZarQisXhTQa2DTkepoGLK58kqome/x5WucS5VmMsvgaU+G1cxfEkIKSG5I7a0H/3sM354=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386258; c=relaxed/simple;
	bh=sseiXUjYECIl50jQsuolW+AKr32VGHWchTKC9sGrFxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDUUPaNW1qGg9gjBWZpOErzfJBqXXsE7afOBnHqjts+oor3H4/fffu+fp9xpT4DcGCGUzt5RnHonJAXnPW/AMVcmcfAYrnz3eh6gI93JclgiE/3Tvhy3ZRriJ1hOsKXTn5C9zFuI+5B/qZtE5zdlchUPUgqmI5rSXakDkmgxVDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvkUMARt; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvkUMARt"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb1fso25877421cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 04:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789386255; cv=none;
        d=google.com; s=arc-20260327;
        b=KIoKoo4zOhLUDSDmXnjCuJGzfodAEjtJ0+t/iwfXZo5EMcd248uUXqyuG7vtSw/k9W
         bzqpn1Bjt1qoLKfYsfSxinFUV2BMHzjeE0j0aUoJ31wmZxRAaxQaYVZCMrpEUK9Jwj9s
         +vZZZ9T4v60D4xIA8KSFRQB/HNaC7u0+TK1VpU2kztka7rxDhPoKqsCMxj8592LKhlVW
         fEsSFkllxrOG+SyFSqzpDqfgZ6YtoMET1VxRgmw8rYP7ogL6inJAB34aUT/tH4+IMrZ3
         31piHAyMg5uKMU826dF0dsNoYeSmleLN2tq3u8GvOVsi1znjikqd4+4I1TQOZN20uvnz
         HxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=793QNQcmMFb+rfsw6Iu+XrkmIdBBhEdUV/WAWUDyjCs=;
        fh=re6dzTB82xMLb6rxnf7sjl9lEBx+NjBuslAR/EAG83w=;
        b=k0RdYYAghaHkfUbOg1rs8P8LgxQY3+3xyOgVIe3QDsiE4LUbeDlvYZfD03Cw5fWRDt
         xFQPHMN+kIOaINpMDJnesV/OeBUxiU9P3AIr1YR5yBXAM8+XntHe3n9iVOAnLgrA7EEO
         zVS9AFy8Xsne5z5S/ntumj+CYErqLgagZs4eQYXWycBmoUMl2AwXaikTqyhyGLRva2nq
         1mZejtlKOREi64SmrNKqR0Mnloh/OWB+ojR9qzp1TpjHHEtmpaRHYKW4Z4itr6qXDYlc
         UfrddqacdPCe0T5fEzMNTtatumU0Zvuafvvf3H6jAdpEmdVBijWxCTBE0FtItxTukSK/
         2E2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789386255; x=1789991055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=793QNQcmMFb+rfsw6Iu+XrkmIdBBhEdUV/WAWUDyjCs=;
        b=kvkUMARtMkWCp1D6Cm+jcGU7ksgSgGF9kahHpw/x4HhzVdOab4p6jMdT3NqW9yhsQF
         MpFN9GnAXyQ89QB8TyrFB5FATsrYr6q0Rm14twR3BfcqZVUlEsBQGOstS23qfqidtQnl
         XfhFZ4Oii1AoL2tYnoIVGfCmhnusPhTwiiwJHooZQosghNvWpisrybnTYcVnhKBqSaPh
         KmOA2jiZDNYCzbsRVzoT0CvyqbMztfFrwujMrhbzTP6FrKFd+A3bHcXmfUqTs1SASheF
         1H18Gz1YunxAsj4I22HdDYzRLsePaYpYLHT4In6mXGo3PlVBrVWMAbKgGK/ixJOXqEP7
         AFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386255; x=1789991055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=793QNQcmMFb+rfsw6Iu+XrkmIdBBhEdUV/WAWUDyjCs=;
        b=neafJgbrb8e/cwhCWID/J+RFg1jI1jkUlaXo6LlFMVvuKEsf6B+T+Y2eTf9Q0xiLCQ
         wPVZUISUn/JUmQYP4MhpfUhFp7xojZQ2VBt4whN+NktqPd5mcJs/8A6L9f9m4oRPiFjj
         IFPymusZrY3Mi4TWosHuLPSHqz0bixq54blGkRi+cADIrBGWTWO1b5x1sNIhgwS9luUt
         bhi2bmcUCkJXL2fzIYHM7LpvjQCOrJFmNLzEbtrJi8NdxLPfjux6DCLcQO7tkpHTjDHL
         R7+luvGape3kH23Jho0fC9B5pUjylS7d9kMxcGXHLFcq1T62F/KpEaaEHeFQy8mYPfRV
         ifTg==
X-Gm-Message-State: AFuF++mGHkiOhOc/+laaMJ13KzlL87RCBc7w6ODEkKTZT5FMHKny8yCq
	udbzgs9zNBWRd1xuSy5Cy/zphZa8tCGbYLfXfggs0NxlvG9qTVp/kZllqB0WzNb6KrCpTezaktN
	vfkHuxw8ZBexH0v70JwLdVq1ZWVI0P3Dkf4ZROeJA
X-Gm-Gg: AYBFou1ZqqRmR29nBrN30nu62v1n+lLczWw+pxXB4ToNxApY3u60ADeDlR7HC1i93LR
	5D7QhDcIBup18ZFMFhAaRr+ykvhlylYW54ic+CiykEQX5Gb2jkm8A29z6iq6jecbqrlnt/Xm1z+
	XlVn5gEHCmWRYyy5yMpYLWaHiF3MS1i0n3FFZrFic8UfVw7rPQew4fpWWEm7WmGpW/i5Ym3M7/j
	OMi+iAMA04cJq0qO5jcIB9SA+PTO8gqXQIi94805XE/eeTwTsAg6vpVfV9Cznvie94I9eMHjCw3
	5CBJKBWpZFRYmitP08C6qz+ZAm+d/Dp+XTOgUkT+Cx0dFm/zlCCosKIGhUbUxQe/AuDBGNBLFrq
	J5zMgGCN8fSjjPIUFr2ov9jgtZTG5ijiq/BNVO78YTzdW0r9GfNQQJ6FtYj/8Sm6zhCU=
X-Received: by 2002:ac8:7c52:0:b0:530:b2e2:d7d8 with SMTP id
 d75a77b69052e-5310d0653c6mr30908351cf.51.1789386254042; Mon, 14 Sep 2026
 04:44:14 -0700 (PDT)
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
 <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp> <d0d5bb33-c9fb-4442-9015-7999f91b4e29@I-love.SAKURA.ne.jp>
In-Reply-To: <d0d5bb33-c9fb-4442-9015-7999f91b4e29@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 04:44:02 -0700
X-Gm-Features: AcwNN1WO8ATf4iAlbAV4po2Tw7p1MNhgy_FLBaG8pjaaHCQqrrPNAahhnvqg0bM
Message-ID: <CANn89i+-pNgDa1TEs3TYCoeHhf6_eeLuQ7jhpzDZvEXc+3WkcA@mail.gmail.com>
Subject: Re: [PATCH v3] net: track raw dev_put()/dev_hold() usage under CONFIG_NET_DEV_REFCNT_TRACKER=y
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>
Cc: Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:24=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/08/29 23:58, Tetsuo Handa wrote:> syzbot is still reporting
> >
> >   unregister_netdevice: waiting for DEV to become free
> >
> > problems. There is netdevice_tracker which helps identifying culprit
> (...snipped...)
> > ---
> > To: Eric
> >   Please see off-list mail <e2f7c53b-fe15-4047-8149-145c91de297f@I-love=
.SAKURA.ne.jp> .
> >
> > Changes in v3:
> >   - Repost as v3, as sashiko's review comments at
> >     https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e513e=
@I-love.SAKURA.ne.jp
> >     was addressed. I assume that no more technical problem remains, and=
 only how to split
> >     this patch into several patches for getting approval from relevant =
subsystems remains.
> >
>
> Sashiko did not find problems with this version
> ( https://sashiko.dev/#/patchset/271af679-34c1-4f7e-875c-4761c22595eb@I-l=
ove.SAKURA.ne.jp ) .
> Any questions?

I am adding Dmitry and Aleksandr to Cc, because I think the best answer
to your problem is not a netdev one. More on this below.

First, sorry for letting this series sit for three rounds. You are one
of the very few people actually chasing the "unregister_netdevice:
waiting for %s to become free" reports, that work is not fun, and
silence is not the answer you deserved.

Let me also say clearly that I do not think the approach is bogus. Once
a reference is taken without a tracker, there is no slot to store a
cookie in, so counting +1/-1 per unique stack and looking at the balance
is essentially the only thing one can do. And 10 bugs fixed is more
evidence than most debug facilities come with.

My problem is the cost/benefit for mainline. This adds a field to
struct net_device and code to __dev_hold()/__dev_put(), which are inline
and expanded in thousands of places, in order to produce information
that is strictly weaker than what ref_tracker already gives us (a stack
balance cannot tell which hold was not released when the same call site
does both). It is a workaround for an incomplete migration, and we would
be carrying it forever. Even with a perfect implementation I would be
lukewarm, and I would rather tell you that now than stay silent again.

But you should not have to wait for netdev consensus to get the data you
need, so:

Could syzbot run a dedicated instance on a branch carrying this patch?

There is precedent: KMSAN lived out of tree for years with its own
syzbot instance, and that is exactly how it accumulated the evidence
that got it merged. Your real requirement, as I understand it, is not
"this must be in net-next", it is "the mechanism must be present in a
tree that syzbot builds", because the remaining bugs have no reproducer
and #syz test is therefore unavailable. A dedicated instance on, say,
linux-next plus your patch would give you continuous coverage on exactly
the bugs you cannot reproduce, immediately, and without anyone having to
agree first.

It is not free for you: you would own the branch and the rebases. But it
also turns the discussion around. If the instance produces a stream of
diagnosed imbalances over a few months, the case for upstreaming becomes
an empirical one rather than a design argument, and I would find it much
harder to object to.

Dmitry, Aleksandr, does that sound feasible?

If you would rather still pursue mainline inclusion, here is what I
would need, roughly in order of importance:

1) The per-call list walk has to go. Today every __dev_hold() /
   __dev_put() walks a per-device list doing memcmp() of up to 160 bytes
   per node. With a few thousand distinct traces on a device, that is
   hundreds of KB of memory traffic per refcount operation, and it gets
   worse precisely on the devices you are investigating. I suspect it
   costs much more than the stack_trace_save() itself. stack_depot_save()
   gives you a handle, and a small hash of { handle -> atomic count }
   makes this O(1), removes the 6 MiB static array, the global raw
   spinlock, the sticky "exhausted" flag and the dedup pass at dump time.
   Ideally this lives in lib/ref_tracker.c as a "count only" mode, so
   other ref_tracker users benefit and net/core/dev.c gains a few lines.

2) Do not overload CONFIG_NET_DEV_REFCNT_TRACKER. People enable it today
   expecting the cost of one stackdepot entry per tracked reference. A
   separate option (default n, depends on DEBUG_KERNEL), ideally behind a
   static key, lets them opt in knowingly. Some numbers on the slowdown
   would help too.

3) The kernel/softirq.c, kernel/rcu/tree.c, kernel/workqueue.c and
   net/socket.c hunks are not needed, and this one is free for you:
   filter_irq_stacks() (include/linux/stackdepot.h), already used by
   KASAN, KFENCE and kmemleak, trims the stack at the
   .irqentry/.softirqentry boundary, which is what your open-coded
   trimming does. That removes the noinline declarations, the boot time
   timer + kallsyms dance, and the need for acks outside netdev. The
   remaining name matching ("process_one_work", "__sys_bind", ...) will
   rot silently; capping the depth should be enough.

4) The dump is called from the 10 seconds warning loop, so a device that
   never goes away prints 100+ traces every 10 seconds forever. That
   message is not rare in the field, and the flood can cause hung task
   splats and RCU stalls of its own. Please print once, or behind a
   ratelimit / an explicit sysctl.

Two minor ones: in alloc_netdev_mqs() the erase_netdev_trace_buffer()
call sits inside the #ifdef CONFIG_PCPU_DEV_REFCNT block, so entries leak
on that path when it is unset; and netdev_trace_buffer_exhausted is never
cleared, so one unlucky device permanently disables the balance line for
all others.

Last thing, on netdevice_tracker. I know your view is that nobody will
convert the remaining callers, and you are not wrong that it has been
slow. But a converted call site gives paired data, which is strictly
better than a balance, and it is a permanent improvement rather than a
debug facility. If you send me the list of remaining raw
dev_hold()/dev_put() users, I will take a share of the conversions and
review the rest, subsystem by subsystem. That is a burden you should not
be carrying alone, and it is a fair thing for you to ask of us.

One small request: an automated reviewer not finding problems is not an
argument for merging, and leading with it makes it harder, not easier,
for people to engage with the series. The objections here were never
about bugs in the code.

Thanks for sticking with this.
