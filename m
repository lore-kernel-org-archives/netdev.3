Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42F3AFD02
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554926; cv=pass; b=UBurbTt+lo2IK/M16VfCjETkwL7dZ5bvbE2BFqDi767pjX0dmm/F84QS50R1ia0h15gJdaWcb1IrN18XmUBYxj8UML5AK21uYMgK36gil2+MNiz5lXQKZEE26wXY/+87C3ozzcylNh8PLh9pN+hMWgh/7RS+bLRGgGybDlsuG+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554926; c=relaxed/simple;
	bh=0AtVtBXzAjTr5tgxiE3p7ZGzyivFmkCFWSojKz8lYTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOP+b2uNNtKIZiKwtLDa1JaDANMKat+x3CW42Gq7K+wOFvuGmPK0YIg1ZPGnI8RRVB9b4vMc3YILr80EhVVFcK0oEtAvB/zNQPuDQ4tjtqcmjO//a5disIXgKa4aocC5Yc+hgDydNZPyOdsmzk7l7Zw1oF/ZQ74ePfM76BTgl6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OoYxiJZb; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OoYxiJZb"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8633a38df87so443469b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789554908; cv=none;
        d=google.com; s=arc-20260327;
        b=WmB0LGgHH1n3bCIBOT0+IdhsCsgfkGzp/U3JOsRWpWvACFBo2mhyk0/cpdfOP9NEHT
         HScgrlISl7z4CRZDhSaIjgtHQRIOxTw6x674YQrR3VP/AT77O1egnK9dpTpK7nOxjqWo
         Vo3wKBlrkT65+l0kZWH6zuIIW/SmWR4pp2aAcqnIV1kGUYFOCg/qmHPBjuxg7xjupcVx
         AOPc9QdpL86g7ftU9pmgTGA3yNmvesKit2iUTto04Q3aWl6OLvVFqVrHZN/7zriT1y9X
         ynWuf7JE1ynEtAoxxQVmNha4g3Q5qoGQmEmDiGphSfCN9ma7E7p8g8C6wuKVTEmmQI0k
         4H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VX2UakJDyoshtDZiFNwXMfLqIFwYkzWpLSYo8MxgLTM=;
        fh=psW8OOxpMrGOX9P2hwo5xfcMJ9gE6whvkBB9TxNIKW8=;
        b=eicQsVTuDb7Rrths9wdHfwtAk4PkKsxi4V0NSQgH61ojIUCE4wlp/Jg1ZnsqJYfuCY
         QdkiqCLNYlmexDvYC2dM7TyQN/1gWfluZyklkwPUsNO9I7xDLbXTsMUAyTQuf6cRtuxW
         kOARjAvmrFqPQ9pud8L/F81Tlg/8so7AS+WRRVSmOe8r+gmAxJaROOSzhKcperZYXeEO
         xD+5CQTkpDWuD7twivWn+eXRibNXYuq6ui9CPnlQNN7a++h0juQcJ47k8j4ZKrlwwAsf
         K/WI1yCyFvk6JMYVdYZzAhtEs9Tj+J/DytprF1MPprbqcnBftBAkJiyNR+hCSD8tNyxr
         cPYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789554908; x=1790159708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VX2UakJDyoshtDZiFNwXMfLqIFwYkzWpLSYo8MxgLTM=;
        b=OoYxiJZb5X67JANQwOQEOKdNd+VkZ2nkebX/I6hMEn7iJ+6XGmpXuVZ8mJvw4xwouA
         mnkEZPAFYxfT7LZ6eZIND8IOXig0ZnCBY+j5GIv2I0mB/ywJnNA5iBX1FK0gPPYAWEhC
         v+5I/AthittJAQ4NktQnEmXIMToAurLwZbWIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789554908; x=1790159708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VX2UakJDyoshtDZiFNwXMfLqIFwYkzWpLSYo8MxgLTM=;
        b=edkO0yq7Uoti4wPKNAuNMofKtLOHj3GMAsqavXFlB2bp0R/X5Hopdea55LoVzmMcZO
         x1lFRetyvq4CLIVLVZn7U8p5aJa25sk+ISPP0XhnCm8ZaYj2tFvtwcMuxFL7jb72dDH7
         ZeU/E/urTtFh/Hq68WxFh+Aei1oeDx766g2OB73HuZOUsyCfmxsnDl+LhXP99bT2P55N
         KKyXiiYdYl9j4S2eScETCd45i20p7pyMikcsN62ewuE/STa4k/B2DEusB7q4Vw2hc40g
         9Q19PT6NABzy6O9jnY1q+NdryrrSLgTzp5xHH3fbLCWa5dJtZ76yogOLQrghtkdNcGmt
         c2xA==
X-Forwarded-Encrypted: i=1; AKwUvByTMEq3VL0V/ukiqbUftKf05z3aQwZYi0TBiVBhcMXKMWwBsf9kdx+ccl2MZXaeIyr3OoIiuU8=@vger.kernel.org
X-Gm-Message-State: AFuF++ln/LfrfTlUeHxfuXGhL0zgqY8Omlvzgx+ncDVdWEghtyVNrvb5
	h2nFlRyTPSi0ivAj8/rXCJ1XTZuYmvOrrHWCPaErTQO2T5MaTq1Rt+KZIef6j58PcxvEwE/irD1
	xtrR/gUJTMpAQo3btE0oSWfAiBu5Om70mom7alEs9
X-Gm-Gg: AYBFou0Oc9fzwwfx23/Raq6MZAXWVgblF3Iisy0Rwrz1QgPeQ2r++KhPn2bpIH0/1U4
	72XFIeYkDPLVaQOFc6PYqFIbJAjMxhWOkYo5BxD7ILbK34rbJtIYzeB1LU0k4x5PdJ1NCjxZc1F
	wIsAyeczi5gLMO28D6ooNMObpYVAsyKj3SPcFGLK62t0zDQibOIw7s1EX6JeMcX0pFC3+jotkVY
	hnwY12n3eUaB8Ao9g20fFdHTl+lJoxumYM0/8awb46pNpeC3f8tVrLCH5K1TE7QWCJRfuLturLl
	ClzB3w6+ZB4uCH72MvX58jyccfcrf29OrSFDZqXf+jFKBQu0VW7KVgvnruE9mPwctMDmc3q9+Np
	tttHP7q0rhmi6o4gRIvOaXO0HrIZ9cbLWuA==
X-Received: by 2002:a05:6a00:3399:b0:862:bb07:2b97 with SMTP id
 d2e1a72fcca58-87238c81968mr4158870b3a.13.1789554908396; Wed, 16 Sep 2026
 03:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911133146.3440982-1-victor@mojatatu.com> <20260914191108.55a1a4f1@kernel.org>
 <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com> <20260915085304.775a829a@kernel.org>
In-Reply-To: <20260915085304.775a829a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Sep 2026 06:34:57 -0400
X-Gm-Features: AcwNN1WvBcfAG7EFjO15o-r5CDxCboMMaccMuPUhP6OGNkWCH0RcRNUHMR7GEAs
Message-ID: <CAM0EoMmiw_kVnK4RjTT_dkquw0YLSB5VgO_7EoV2WT_pQXbCYw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: Jakub Kicinski <kuba@kernel.org>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org, Yuan Tan <yuantan098@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 15 Sep 2026 07:50:54 -0400 Jamal Hadi Salim wrote:
> > On Mon, Sep 14, 2026 at 10:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote:
> > > > This is a less intrusive fix meant for backporting; a cleaner appro=
ach that
> > > > uses a per-device IDA over all qdisc handles is planned for net-nex=
t.
> > >
> > > I don't think this is net-worthy in the first place.
> > > We have a ton of code under rtnl_lock.
> > > We cannot provide any protection from malicious netns admin from
> > > overloading the machine.
> >
> > That is the one million dollar question.  We labelled this as net for
> > this exact reason. i.e malicious container could overload the whole
> > machine.
> > But it borders on "hardening" (improves performance), so net-next as a
> > target sounds reasonable. It was a coin toss.
>
> IMO any attack from containers / user ns is hardening. If it leads
> to a crash we take it via net _because it's a crash_ not because
> user ns can trigger it.
>

Ok - will review the pending ones with this in mind.

FWIW, here are the rules we have been using:

It is net if: Regression (worked before, broke) or always-triggerable
crash/UAF/leak/lockup
This specific bug could potentially cause a soft lockup but it wasnt
consistently...

It goes to net-next if:
a) Never worked (adds a cap, validation, accounting, or enforcement
that never existed, e.g. memcg-class)
b) Doc/comment
c) tests - although the exception we currently make is if we create a
tdc test for a net patch then it goes to net just dont cc stable on
it.

> > Since we have a few similar "grey" issues in our pending queue - so
> > where's the line for net/net-next?
>
> TBH the line shifts depending on how bad the AI flood is.
> I tried to document some rules but it only lead to bikesheding.
> So my recommendation is to write the final fix, without worrying
> about keeping it simple. And assume the maintainers will redirect
> to the other tree based on their judgement when applying.
>
> With all the AI kiddies these days we routinely apply to a different
> tree than tagged.
>

Given the flood, here are the priority rules we are using:
1) submit net before net-next
2) All bugs must be reproducible by our (semi-automated) system
(hybris). I dont even look at issues unless they are reproducible
(hence my nagging "do you have a PoC?" ;->)
3) Assign a priority to each bug and submit the highest priority ones
first. The priorities are assigned as follows:
- base (reproduced, ACCURATE) +1
- Crash (oops/panic/NULL-deref/OOM/corruption) +2
- UAF +2
- Lockup (soft lockup/livelock/infinite loop) +1
- leak +1
- simple-trigger (plain tc/tdc, no special PoC) +1
- privilege required: (root) +1 / (unshare -Urn) +2

The priority is capped at 9. So a priority 9 with net gets immediate attent=
ion.
A priority 9 that requires root permission is not as important as
priority 9 that requires cap_net_admin (-urn)
Yuan has a taxonomy as well; he calls these L1 and L2 when we pull the
reports from his system.
There is an exception: Priority 10. These are assigned to bugs which
require no root/cap_net_admin and other UPEs

We also capture all "pre-existing bugs" and address them when the
pending queue is empty. Most of these end up being a waste after fixes
go in.

> > > Nothing against the patch itself, but if you plan to do something
> > > else in net-next let's just go with that from the start..
> >
> > We could resend the same patch for net-next, the alternative "proper
> > fix" is more intrusive. See attached.
>
> I'm not sure we have to do this, given Victor's patch already
> drops the time 50x ?
>
> > Another option: Is this worth fixing?
>
> Right, I think it is but IDK if it's worth maintaining state for.
> IOW Victor's patch would be enough for my taste.

Ok, we'll send that patch as net-next.

cheers,
jamal
