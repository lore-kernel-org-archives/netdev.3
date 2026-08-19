Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A55469853
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133289; cv=pass; b=BcV2NaPh6SCN51ZeAFhnmrsF2ejyvP/iSxaZJ7kNV6NHm0iEBECzp/l7R1Qaky1Q0Aa6aP0DTHEjisVh6KWQn63s0Ku2fajyCCk9nqBn7L89kfBwLEerjJbQZyR/09c/rBsseN861DV6vvqzXr6h1Bf8QhLteE4A9DCdn9velrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133289; c=relaxed/simple;
	bh=43lEaGQRzdUCTJ2eeb9C/glhDzPxx1xHP5c9H6u1CZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJZFHVCAhaUrB/OkrftLL1dCR+o8ll1iNtlbLH16wLUYtU4nP/kwuAaKyPTrJqAmS4/vVtkXPknBkA7WGBtPcZpX6Nf3nzOp0VeC5VuSB9Gw4lqsjRJr7d7izWHJCcyZDqvMVucVJzw4KAHaT3sPrE59vU1qoQDtdRqk7f2Dygo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mTDIYpK3; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mTDIYpK3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so681153b3a.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787133271; cv=none;
        d=google.com; s=arc-20260327;
        b=YTpS7idAAxDQG9JD7ufQQ2gyNt50sAUn916GOIo+hJv0Fg0wRLtmNTUi5dm4+WIXJ3
         7VA3fAQZ54MQ8QCmIZlB8Z/TfKJR/euXimD9Q9aUlgmhD62OZ2OapZWDMhkDxaOw7yGX
         IKhcVnGMQNRdldmlRLODJeaivbLTFKDLZrNo6XsVxyJTVLEw2TDeaEqsfyaZSkT3RCY5
         MyTrtEpexHpbnbIIR2fLSoM2WcpWW31oBT0G1y1QEWsRhERngJPLmqaU7Q0PgLXxiwkW
         cTa/9++d+fvWH5IUgLSvQLFqhCihHCgWEQUqGvWXxzLXcaqDegyvLa7Kp1yi7eizU17U
         he3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVmoTNI7ZmmJP++Kx2TQbN2JseYj9xkmHfxaPdLeAPQ=;
        fh=NUoGjAzI/gngAcZx5hAQPSPpjDoclWkpS0Yq9o16nYY=;
        b=TskU73BiBHB+JFX2IiuE0iOFV4KneOj3eQ/UhNaw1eNB+ue+Gy6jxEjozGcWS5LkB/
         Pzav/qI4T7ntxoEbjAeQ+lwGbVQNV9vzFBNdtkPDv/JUzxwfmDZ2SZD6nUTR+pYHhikZ
         64xEf7MGpAb9DTn7Jhkcb9pAtzrrrOhJ9ZBK+/A64A/HNVjPMdPVK7hppnIPWBV98F0+
         eHVdLhG916y1gUDwwKFI2vPiKtOVHSe7b1yolPfXVldJBkGdM9Vb76+eS2qHh5Ok64ZA
         ZlmP5khMwysq9kDaK2megPGVkODBxSQ/5t7qOGZWsTF8AwEiMAqCUB697MV0s+qrdWLg
         GKWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787133271; x=1787738071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVmoTNI7ZmmJP++Kx2TQbN2JseYj9xkmHfxaPdLeAPQ=;
        b=mTDIYpK3zWY/iVI9UyfKqetoeOVdAOiPUxbeNj3dcost6BxHGkMW7dmYpV6sY4L2bU
         HNMAJF6qDU8T/V3YgWzqCsjGYcbHnvg5sjX1wsFA6ZmZm2ZRLm1KBB4OPy1I8mMKp9xC
         44lWKBABWmRooHBuMSADenRtABgJF47saszCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787133271; x=1787738071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVmoTNI7ZmmJP++Kx2TQbN2JseYj9xkmHfxaPdLeAPQ=;
        b=LDuhuMUzmtNUWwtrceSt8B2yRQbIQ+hDQL49jrfVgCqP3opLt7+GlfWlI7X9Cife8H
         TzP17u1D7eI0D2sj490E0BHpzcG7SBGXKgoz4HHBTG4wlLljE+kH/5UkPggorR1qhyTU
         UrZYaEg788KDbrxYBfZiI2da26efAeXHDNg3Ki+VVsE+pc7Ej8Uc21im6uGCeKD3/7op
         +sjwwHTdVxGfuiciVuVdNayZOHq91LD3NXDsQwk0dUkhiJEua3wdpYv+QzNQbeyJI5s/
         5UtgnphbDxC4cpNKVRi3Mp8YD7qj05ous+Hpwv5CedlTx4NuMJWhkJAA47dft4yBnt9R
         CEQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rry96JsKpBSGDBIVvgsPeulhbsJPuT3m1bmd9/qNJD2ObQywcMIenTI+O3ZWbFbLElKb5c5tpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuf6yyyV/jkABPq1IPwC0kAGUNg8pMdnwotQ+6P5FjE/AgE7P
	jNG2hBGNuAucPvaUAmN4kXoRAHAgBstrlmN4WnkpC9V+HIVWbkHtiI1dL4zSxbznZL8WeXJlNUB
	deDB7FA0suFhJC08NdfnYN3YtoQz5F5Ibtx9feRxMVL4gs4MPj8fKqtLf
X-Gm-Gg: AR+sD13/i9rJAKkbdeBRCgHXtKAGqLwtC4YDbhfDBlWVDm/ONA2HzV/jK4W1mU0jMkx
	T5UecF8Dxk4FqXrSYoJC/vO/P22L8ujUyoj4iWwT8C3udqgqAfboMEcAVbSucni3P8mFeV9Nss8
	jujA+5nGXuG5mvzsvaKkhMqdOPFu2xtcFd0ucbG0B+hqE29Le/vrMLB85gRLlN5KJ71LqtZvzyz
	Pt1xrAqyGQIWXdiPIkzsUXFVxThnkLso1LuVWfbWdpUnWswWG9Mzx+4qXBG2vhU2aoNSgZe73ZD
	dh8zQU+EXGpIrnq6uyWYXv9h2VWdsKeU4G9nL38HFVvUSw==
X-Received: by 2002:a05:6a00:190e:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-851d382dc95mr5121261b3a.5.1787133271533; Wed, 19 Aug 2026
 02:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805102505.740806-1-david.lee@trailofbits.com>
 <CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
 <CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
 <20260812182246.3df00681@kernel.org> <CAC_etQFk=tGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com>
 <CAM0EoMkv0yLNez7gvNo6=qTQ4rLmbyZL-tiiY6K9tJAuH4WPWw@mail.gmail.com>
In-Reply-To: <CAM0EoMkv0yLNez7gvNo6=qTQ4rLmbyZL-tiiY6K9tJAuH4WPWw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 05:54:19 -0400
X-Gm-Features: AcwNN1WTAUyJZv6aUQSPVgNsubZ-knJN5974Ae_lu5c7VK1iGVqJcIRR2Y9-rpo
Message-ID: <CAM0EoM=+P8ayVRvCFs3fQ6EZVSnSJpzSeheOb6x77-YzPHBD5w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed creation
To: David Lee <david.lee@trailofbits.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HanQuan <eilaimemedsnaimel@gmail.com>, 
	Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Aug 17, 2026 at 5:06=E2=80=AFAM David Lee <david.lee@trailofbits.=
com> wrote:
> >
> > Hi Jakub,
> >
> > Apologies for the confusion. I've reattached the correct reproducer.
> >
>
> Thanks for reattaching the correct reproducer. I have run it and the
> KASAN use-after-free in now matches the bug exactly. The earlier log
> showed a different issue, please ensure logs match the bug and the
> repro in the future to reduce review time. We run every test - and we
> will vet your claim; so sending the wrong log consumes our time for no
> good reason.
>
> The fix itself is sound, but it requires a v2:
> Per request from both Jakub and Sashiko: Inline qdisc_free() into
> qdisc_free_cb() (or make it static) since your patch removes its last
> external caller, so the standalone symbol is dead weight.
> Attaching a C poc to the patch is not something i have seen; make it
> separate. So mext steps: you are going to send 0/1 with the attached
> poc and a good description of what changes you made since v1. Then 1/1
> is the refactored patch.
>
> Keep Fixes: 51ab2994c387 since the that's the commit that made clsact
> bind a shared block before creation completes.
>

Reviewing your patch triggered my memory so i looked around...
This _same exact bug_ (with the same KASAN signature) was reported by
eilaimemedsnaimel@gmail.com(on Cc) on the security list on Jul 20.
They promised to send a patch to the list (which was the same as
yours!) but they never did.
Two main differences i will note:
1. Their repro was different than yours (ask them to send it to you if
you are curious)
2.  They quoted Fixes as 3a7d0d07a3867 (in a way that is defensible as well=
)

So please, when you send a v2 give them some credit in reported-by

cheers,
jamal

> cheers,
> jamal
>
> > =3D=3D=3D=3D=3D=3D=3D=3D Affected Versions =3D=3D=3D=3D=3D=3D=3D
> > Runtime reproduction: Linux 7.2.0-rc3-kasan
> > Confirmed vulnerable revision:
> > f5098b6bae761e346ebcd9da7f95622c04733cff (Linux 7.2-rc5)
> > Latest inspected vulnerable revisions:
> > * 62cc90241548d5570ee68e01aaba6506964e9811 (Torvalds master)
> > * 9d8da8e0a9bce4a340af60dd0446bc7eb8d07587 (net main)
> > Introduced by:
> > 51ab2994c387c80b45caf8b8067b3f3b97771d25
> > ("net: sched: allow ingress and clsact qdiscs to share filter blocks")
> > https://github.com/torvalds/linux/commit/51ab2994c387c80b45caf8b8067b3f=
3b97771d25
> >
> > Required Configs for the Vulnerability:
> > * CONFIG_NET_SCHED
> > * CONFIG_NET_SCH_INGRESS
> > * CONFIG_NET_CLS_ACT
> >
> > Additional Configs used by the Proof-of-Concept:
> > * CONFIG_NET_CLS_BPF
> > * CONFIG_TUN
> > * CONFIG_USER_NS
> > * CONFIG_NET_NS
> > * CONFIG_KASAN
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > Step 1: Build and boot a KASAN-enabled kernel with the configurations
> > listed above.
> >
> > Step 2: Statically compile the attached `poc.c`:
> >
> > ~
> > gcc -static -O2 -Wall -Wextra -pthread -o poc poc.c
> > ~
> >
> > Step 3: Run `./poc` as a regular local user. The program creates an
> > owned user and network namespace, two TUN interfaces, and a populated
> > shared ingress block. It sends ingress traffic while repeatedly
> > requesting a `clsact` qdisc with the shared block and the invalid rate
> > estimator.
> >
> > Step 4: Because this is a race, triggering time varies. The validated
> > run reported:
> >
> > ~
> > BUG: KASAN: slab-use-after-free in tc_run+0x5e3/0x620
> > Read of size 8 ... by task poc/...
> >
> > Freed by task ...:
> >   kfree
> >   qdisc_free
> >   qdisc_create
> >   tc_modify_qdisc
> > ~
> >
> > The complete KASAN report is attached as `splash.txt`.
> >
> > Best regards,
> > David
> >
> > On Wed, Aug 12, 2026 at 9:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Tue, 11 Aug 2026 00:58:27 +0900 David Lee wrote:
> >> > [  230.057740] ipip: IPv4 and MPLS over IPv4 tunneling driver
> >> > [  231.667279]
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > [  231.667738] BUG: KASAN: stack-out-of-bounds in
> >> > __ip_options_echo+0xdf7/0x1860
> >>
> >> I'm struggling to see how this is a repro for the qdisc lifecycle bug
> >>
> >> In any case -- if the fix is really correct and there's some real repr=
o
> >> shared off list - I think you're deleting the last caller of
> >> qdisc_free() so you should inline it into qdisc_free_cb()
> >>
> >> So patch as is needs to be refactored. But please don't repost just
> >> to refactor, we need a convincing repro first.
