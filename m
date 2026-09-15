Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EE41A4E5
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488569; cv=none; b=YW/CepBQadYPh83a9+6br19vGjILx3kW3TdkqHfiPBfvezB3c0AVsb2lUszKjGLK0LRGDxH5zrPQIKiST4sFAldc0sJTeisFLqgE4IcfqPUa2pOEcSARzIsDtKgq0BHHmrRbRgbWu/E2efqlykGSXUAawuJ5lWMRMiJWWEPsR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488569; c=relaxed/simple;
	bh=p9P7kYzSh3SbjB0vQ6ROZ0Hb+PYQpcKTdHSqF3/h/1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTq6tS8/sQ8dFnsXSjflBvGh3O4mUqZmSYmIy27r/iF9ndVOZ0/qouFWBOTMpv+Z7jqWDfuZYx06uHXSHwHB/3W1R5Hf7LUYehmjnW93oUOMy/tELaUPcXC+ADEMBfmsYcNMkTaMFpheRB89Gnl2JP07SXXFsOW5RX6w6Cx9/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwGUt+Zs; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwGUt+Zs"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so89876695ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789488566; x=1790093366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Sn4QXU5DeLhNiD9gxKV86tuuXX6fexObvLyuo9X7U0=;
        b=mwGUt+ZsJ+ZJqxFbysZIygU2UiTSHZy+uXcvTrNVtRXAvQo9Q3sV7dpIesr+ZwBEw+
         3scD5uXyS498WxISeZU++tTW08fQMa3PzF/H6489Ya+ySxWiplNxgjLjD0SygSMAYrdf
         iZQRf/SskbzFLtC9u1rDgxYrL/PLZ0NCQPKGuAzQK3WCXwkmgfc7M1+rQsQqs/7ozlzs
         s0I660M35Lu2+Ob9waDLaf4+scrzKQxyq3qOkJdwUOcZHCZmApsdluyB0dtvhlkVa1TY
         eHhmAS6cx6wS6DaJ6nrCgjapY2M4SrrFCPPtq+dg+jctzYudsZvuHyOTxaSoDCj7wA7/
         B7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488566; x=1790093366;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Sn4QXU5DeLhNiD9gxKV86tuuXX6fexObvLyuo9X7U0=;
        b=ZqoCQSr6JEi77SzbkoCTVl076SICYcqrZ+ODaKwtxgQ/Q3f06A9mmcg90AMKoyHvXE
         wefScE13DRUMxWgsXipZnQBwFzpPrsqg2z4liaOWfAgXqo4y2wmDQcAIIE+zXWnh3IgW
         xhIp90AMx3b5MatUOtExpoDg6IpOiawYLqzd/+jyhMGrwQux6FcM93mdVC7GaiGnS4T/
         QisGFsMWYJaD0c14vObsW3P0AVhmlF7s+4nN3w0Q4pnEbwjZXP11/FbirUbmCDbITnb9
         pXcJaA6wq7l+Ah2jZnhAAf92lNNGRJTzloF8FLjEqSTwxITSwZQf1i7FOZJt5iJazRif
         qIVA==
X-Forwarded-Encrypted: i=1; AKwUvBzKd1fb+WheLbitQnLcObsfNZZAiOWnGE3eCouYbF5N1/iIXaZJsm7gdhPqWLcDfnXcVVMqjCM=@vger.kernel.org
X-Gm-Message-State: AFuF++krq+CJZi5LaheNu2SIZd14KCN8L/djEzXvZKFmlI2OvEQKDbqf
	vKpq6fEfpYU8d3OkPzL5Ttzk+MIhpB1mH+fLLzqzVwqlq4J33Uh/wdcLEs1+RSizBUqv4JSLmWc
	lG5Q71Q==
X-Received: from plbmm8.prod.google.com ([2002:a17:903:a08:b0:2db:6055:260])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e8:b0:2db:2c09:98ad
 with SMTP id d9443c01a7336-2dd6c6dbcbamr182682915ad.12.1789488566398; Tue, 15
 Sep 2026 09:09:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:08:00 +0000
In-Reply-To: <CANp29Y7hm+ehJ4+whyBtRtDMUcGXH=ee6aCrFMAMWL9k-G8ZJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANp29Y7hm+ehJ4+whyBtRtDMUcGXH=ee6aCrFMAMWL9k-G8ZJg@mail.gmail.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915160925.2611036-1-kuniyu@google.com>
Subject: Re: [PATCH v3] net: track raw dev_put()/dev_hold() usage under CONFIG_NET_DEV_REFCNT_TRACKER=y
From: Kuniyuki Iwashima <kuniyu@google.com>
To: nogikh@google.com
Cc: dvyukov@google.com, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 14 Sep 2026 20:48:52 +0200
> On Mon, Sep 14, 2026 at 1:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Sep 14, 2026 at 3:24=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2026/08/29 23:58, Tetsuo Handa wrote:> syzbot is still reporting
> > > >
> > > >   unregister_netdevice: waiting for DEV to become free
> > > >
> > > > problems. There is netdevice_tracker which helps identifying culpri=
t
> > > (...snipped...)
> > > > ---
> > > > To: Eric
> > > >   Please see off-list mail <e2f7c53b-fe15-4047-8149-145c91de297f@I-=
love.SAKURA.ne.jp> .
> > > >
> > > > Changes in v3:
> > > >   - Repost as v3, as sashiko's review comments at
> > > >     https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e=
513e@I-love.SAKURA.ne.jp
> > > >     was addressed. I assume that no more technical problem remains,=
 and only how to split
> > > >     this patch into several patches for getting approval from relev=
ant subsystems remains.
> > > >
> > >
> > > Sashiko did not find problems with this version
> > > ( https://sashiko.dev/#/patchset/271af679-34c1-4f7e-875c-4761c22595eb=
@I-love.SAKURA.ne.jp ) .
> > > Any questions?
> >
> > I am adding Dmitry and Aleksandr to Cc, because I think the best answer
> > to your problem is not a netdev one. More on this below.
> >
> > First, sorry for letting this series sit for three rounds. You are one
> > of the very few people actually chasing the "unregister_netdevice:
> > waiting for %s to become free" reports, that work is not fun, and
> > silence is not the answer you deserved.
> >
> > Let me also say clearly that I do not think the approach is bogus. Once
> > a reference is taken without a tracker, there is no slot to store a
> > cookie in, so counting +1/-1 per unique stack and looking at the balanc=
e
> > is essentially the only thing one can do. And 10 bugs fixed is more
> > evidence than most debug facilities come with.
> >
> > My problem is the cost/benefit for mainline. This adds a field to
> > struct net_device and code to __dev_hold()/__dev_put(), which are inlin=
e
> > and expanded in thousands of places, in order to produce information
> > that is strictly weaker than what ref_tracker already gives us (a stack
> > balance cannot tell which hold was not released when the same call site
> > does both). It is a workaround for an incomplete migration, and we woul=
d
> > be carrying it forever. Even with a perfect implementation I would be
> > lukewarm, and I would rather tell you that now than stay silent again.
> >
> > But you should not have to wait for netdev consensus to get the data yo=
u
> > need, so:
> >
> > Could syzbot run a dedicated instance on a branch carrying this patch?
> >
> > There is precedent: KMSAN lived out of tree for years with its own
> > syzbot instance, and that is exactly how it accumulated the evidence
> > that got it merged. Your real requirement, as I understand it, is not
> > "this must be in net-next", it is "the mechanism must be present in a
> > tree that syzbot builds", because the remaining bugs have no reproducer
> > and #syz test is therefore unavailable. A dedicated instance on, say,
> > linux-next plus your patch would give you continuous coverage on exactl=
y
> > the bugs you cannot reproduce, immediately, and without anyone having t=
o
> > agree first.
>=20
> Normally, syzbot fuzzes kernel changes across different environments
> (qemu, various gce machines) and architectures (amd64, arm64, riscv),
> but adding just one dedicated instance, which would get much less
> compute than the rest of the syzbot fleet, IMO offers very little
> benefit over just casually running syzkaller locally.
>=20
> How to organize this is also an interesting question. Applying the
> patch on the syzbot side would make syzbot show non-existent commit
> hashes in the reports. If there's to be a separate branch/tree that we
> would fuzz, it really must not lag too far behind linux-next/torvalds
> - the community is very annoyed by outdated reports.
>=20
> Speaking of the absence of reproducers, I think we should start by
> cleaning up the existing open bug:
> https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd
>=20
> Currently, it is an umbrella for many different crashes accumulated
> over many months. It also has some reproducers; some were even found
> recently. If we keep closing this bug after fixing the root causes
> found by the open reproducers, syzbot will keep on discovering and
> reporting new ones even without an extra debugging patch.
>=20
> A small related question: should we report it per-device type, like
> `unregister_netdevice: waiting for netdevsimNUM to become free`,

+1

I think this is the major reason why we slowed down netdev_hold()/put()
conversion at some point.

After Eric converted the core code and first-class drivers, I remember
I always saw the reports were dominated by can and vcan, which we
usually don't care much, and I gave up finding an interesting one.


> or
> would that only create duplicates, and it's better to keep everything
> in one bucket?
>=20
> >
> > It is not free for you: you would own the branch and the rebases. But i=
t
> > also turns the discussion around. If the instance produces a stream of
> > diagnosed imbalances over a few months, the case for upstreaming become=
s
> > an empirical one rather than a design argument, and I would find it muc=
h
> > harder to object to.
> >
> > Dmitry, Aleksandr, does that sound feasible?
>=20
> Tetsuo, based on historical experience, how many issues do you expect
> to detect this way?
>=20
> I can imagine setting this up as a short-term experiment, but I still
> wonder about the benefits of having it specifically on the syzbot
> infrastructure.
>=20
> >
> > If you would rather still pursue mainline inclusion, here is what I
> > would need, roughly in order of importance:
> >
> > 1) The per-call list walk has to go. Today every __dev_hold() /
> >    __dev_put() walks a per-device list doing memcmp() of up to 160 byte=
s
> >    per node. With a few thousand distinct traces on a device, that is
> >    hundreds of KB of memory traffic per refcount operation, and it gets
> >    worse precisely on the devices you are investigating. I suspect it
> >    costs much more than the stack_trace_save() itself. stack_depot_save=
()
> >    gives you a handle, and a small hash of { handle -> atomic count }
> >    makes this O(1), removes the 6 MiB static array, the global raw
> >    spinlock, the sticky "exhausted" flag and the dedup pass at dump tim=
e.
> >    Ideally this lives in lib/ref_tracker.c as a "count only" mode, so
> >    other ref_tracker users benefit and net/core/dev.c gains a few lines=
.
>=20
> FWIW there were any stack traces in the reports at all, syzbot's AI
> repro generation (which we are piloting now) would already be able to
> kick in and generate reproducers even if syzkaller fails.
>=20
> >
> > 2) Do not overload CONFIG_NET_DEV_REFCNT_TRACKER. People enable it toda=
y
> >    expecting the cost of one stackdepot entry per tracked reference. A
> >    separate option (default n, depends on DEBUG_KERNEL), ideally behind=
 a
> >    static key, lets them opt in knowingly. Some numbers on the slowdown
> >    would help too.
>=20
> Upstreaming it under some separate option would be the best approach
> for syzbot - we could then just enable it on all our instances.
