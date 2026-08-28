Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C6411F80
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912994; cv=pass; b=Oio6CRUxDBwE3Rzzpu10JS/VsskdzeKW2TsYQkqMjVQjpSn3+/oPBACpMvSmeVbRIwmUnCkQGOTTvCq1ZCzD0mYlfg29y5rBu67jORUCtJ6tpMYz3wunV7acRhW70QPT9G0xZaa/VhOEc8LbF5glbsLHu8TI7AhfhdH1HjkFtMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912994; c=relaxed/simple;
	bh=2//e3DwCGJOQidpg8uCFiQQV/bUoaFberVIWhbIc3RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/dJzRrgfeCOr6lU2ORxpxgvfm2StVuwwLq3m9khxByM21tMDI1WKRI1R5thYbBCYIj72OjRb+H/PPivuh4vrRfP83khIC16iATdKKqSCMp657Q+uiUKDxR1lAxzDEdwt7u21Thm88VSW2aK4p//Xhg8vB8KxgIXJgAOsKCdft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MnVUVzxs; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="MnVUVzxs"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso733974b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787912989; cv=none;
        d=google.com; s=arc-20260327;
        b=mD0WjSnuxvOyqvV1Th+A3VOsrMXPVK8Uiip70HNzK4xx2GmNFMD9+vG8NkW75NaiCP
         YTkz3KS8Ux7VpA9ZROGkQb7oQAc4hwU35A+ozWchxww9c1G9xZX7xhNZ6dPFlTrTE7qi
         srqBidpHgJBrGAF164LaHGeyegFdmALseJsBxU+Wv61Zm8+dof77zhMxoE1S4hk6qbeQ
         +76l6FVPiGXNieTwYD65yRmGXW3o6GgvAxxSHaolAPZm6pUxoUFzK0MYhbpDwPhmN7mq
         8Ck2Qy6odoMF/V8erLg5QZ/rd6nWZSWKDNFLRxiLhfCciMau4NO2s4qV6g6/uzhFdTUv
         CVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzWqPpyiNdDWvlAa7ObVMhLFRMXenMVDW76N50jUTB8=;
        fh=VdIE8irQdMztvZvWd7pFJTH0S7KpJAO7/sagonXu1Kk=;
        b=Z/wz3ICzbJryj30eWx7IC91dvpobKJyB472R/IXBKkcD9xyN35q0ns5/a9M3MYrvmy
         +7e/0urLoZ0y1zC6YHSq1PYJgpCD9Dq8reOOWpZOI2wkndozWvybI+nVZqxMD7qMQHM4
         HGVwMOx9eo00eHFK/tP8YlpL6mkVgWcGqmjAALW32JkF63jQ8n3asMDSE1xJba7ap1RA
         rwzZ2QxrbWogiwvH8bvPgxSJI/EY+D0DkROyYH5VM1B0K0EXkJPkOulteFmxY0cayLVI
         WosU4GWcN2BA8M3ozmja1cYnRW8aB3+BVkKJJKS6vdVKbxZzdwcNiZZJC57QyIzf2tos
         jp5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787912989; x=1788517789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzWqPpyiNdDWvlAa7ObVMhLFRMXenMVDW76N50jUTB8=;
        b=MnVUVzxsCyJD9tsb8L0uNjZClpmQPRH87d/ysqrvFzMEhZTbqRe7jCy1wKsGOOCvgU
         5o6DDtfi41efCuXGDm8yB+M58jS7CMg17IR1XDzvxbMmBAW0MzDOywJN6PJvL+j7Xs7q
         RVXj+arPz3exyIRXbhi+wcL7XMt5/QtrKfxgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912989; x=1788517789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzWqPpyiNdDWvlAa7ObVMhLFRMXenMVDW76N50jUTB8=;
        b=XJCps355UWUNbVZ8PpRDiTMvRYKLD+4wFWyrLEUjSmWrSl93DlDpCvu9oBsh+KN2cW
         kz2pUnz2094T3YbdDwTB+DT/DTuaASztloVDDhYkH9SHKJW6BnqldqJIl9YpM1sSRzUP
         xAsRapUvVq0hMjkJYduiVITY08bHyqJJD/tmgJgbKRph9jaSNOy/JJ6GMxH1achdE16B
         qU8OhkAhiar4M+y/fR31LFuFtfAf89A2oQjIdgX9VCbc14WmESdyZ6pFiGPrhjVAjGlI
         ROzqM/OzmBiotRBNHsvtOdU7F9xDZTzI1t6XrTvqDPZmPbqCyD1Tf/liUNKTyMKP5itn
         A59g==
X-Gm-Message-State: AFuF++n2puszV/q7Qi3mFwst3Nw1JpoJOP+/HQMQDcg6QgHy15j23SUH
	c3FdCKvK8ROtIFp/2FX5BCXLDl4RrAp8rOUaEzn+VGA8NMjOW9LmRj9J2DJ0p8QB0tr+hU8NcoP
	DFm5KeiUWhzUQAUP0ma8IyjOhSLyrg8FtnVN3dB/n
X-Gm-Gg: AR+sD13Zn/FaaBmHv7lr0Hdp6azf42j8kzUv46vT++g4qDvhzBvmBaunxvVZPvrNkwJ
	Q7+trKm5+u3ILfeqd5td9GYS4MRmUyo71HfR8xjdFHzXd/X1K9dGJh39Nzt5f4fs9hrLpSRoM+e
	/hfzKnWqSB77vHZdZGJaEL8J2utDSOAyxTjhV2u9XnmhcMBBni/Xq2X55czDMrDcp+ez/V05GwW
	xCjyEtDf33wZC7suVfKejSIsBcWSa3JK1ovZr4hStPJiAStjmNrbB5xL7z0zJerUDfyYyOCbdwr
	z+1eFw6JOmrliZ1fsC89V5WvjPmd8gN1b8TxLkwV04Uppgb5uHSQKZUoNby/Pwth5GsB2aPl95Z
	xvcewqboH6/vYM/JHvId7yJk=
X-Received: by 2002:a05:6a00:1d97:b0:84e:354:422b with SMTP id
 d2e1a72fcca58-85628f673c9mr2444972b3a.2.1787912989371; Fri, 28 Aug 2026
 03:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081751.134086-1-jhs@mojatatu.com> <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
 <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com> <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com>
In-Reply-To: <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Aug 2026 06:29:36 -0400
X-Gm-Features: AcwNN1XrQNwuVNsWYkq2OHTBpHPj5wSKZYt3RJHR_7vumvgjXlKfPUYU7WwR1D4
Message-ID: <CAM0EoMnV66aObnjNJg-FLbvXaE21b1_K-yOJ1s==+z+xj5RnEg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/27/26 7:39 PM, Jamal Hadi Salim wrote:
> > On Thu, Aug 27, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> >>> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> >>> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> >>> bound. An unprivileged user (via unshare -Urn) can set a huge
> >>> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> >>> memory, causing a system-wide OOM.
> >>>
> >>> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> >>> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> >>> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> >>> via extack whereas for the resize path, the error propagates to
> >>> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> >>> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> >>> are charged to the allocating process's memory cgroup.
> >>>
> >>> S16_MAX is the virtio virtqueue size limit: the virtio specification
> >>> stores the queue size as a u16 with a maximum of 32768, so 32767 is
> >>> the largest tx_queue_len any in-tree driver can meaningfully use.
> >>>
> >>> Conditions to recreate the bug:
> >>> - CONFIG_NET_SCHED=3Dy, CONFIG_VETH=3Dy, CONFIG_USER_NS=3Dy, CONFIG_N=
ET_NS=3Dy.
> >>> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> >>> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
> >>>   while the devices are down.
> >>> - Attach mq at root, then replace each child queue with pfifo_fast:
> >>>     tc qdisc replace dev veth0 root handle 1: mq
> >>>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
> >>>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> >>> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_arra=
y
> >>>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=3D500000).
> >>> - On the unfixed kernel this exhausts global memory in ~28 iterations
> >>>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
> >>>   tx_queue_len is rejected with -ERANGE.
> >>>
> >>> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> >>> Reported-by: vega@nebusec.ai
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>> ---
> >>> v1 -> v2:
> >>> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (=
Jakub)
> >>> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
> >>>   virtio16 ring size limit.
> >>> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
> >>>   already prepends KBUILD_MODNAME).
> >>> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> >>> - Fixed tdc teardown to use JSON list form for acceptable exit codes.
> >>> ---
> >>>  net/sched/sch_generic.c | 14 ++++++++++++--
> >>>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> >>> index ef2b4bf51564..eb5c0d3f67c2 100644
> >>> --- a/net/sched/sch_generic.c
> >>> +++ b/net/sched/sch_generic.c
> >>> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc,=
 struct nlattr *opt,
> >>>       if (!qlen)
> >>>               return -EINVAL;
> >>>
> >>> +     if (qlen > S16_MAX) {
> >>> +             NL_SET_ERR_MSG_FMT_MOD(extack,
> >>> +                                    "ring size %u too large (max %d)=
",
> >>> +                                    qlen, S16_MAX);
> >>> +             return -ERANGE;
> >>
> >> Sashiko noted that setting a large tx_queue_len to a down
> >> interface gives an inconsistent behavior:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134=
086-1-jhs%40mojatatu.com
> >>
> >> (all other comments are IMHO noise and should be ignored)
> >>
> >> I don't see and effective way to avoid that, short of falling
> >> back to v1, WDYT?
> >
> > I changed my mind on this. See this thread and let me know what you thi=
nk:
> > https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEe=
vLu=3Di=3Db+xKg@mail.gmail.com/
> Whoops, I missed the last message in such a thread. I think it makes
> sense and will cover all the sashiko-reported concerns. You can probably
> also additionally get rid of the old test:
>
>          if (new_len !=3D (unsigned int)new_len)
>                 return -ERANGE;

Good catch; that check becomes dead once the S16_MAX cap is in place.
I'll drop it
How do i "withdraw" this patch? Is it sufficient to say:
pw-bot: cr

Based on what you said to Victor: Should i keep GFP_KERNEL_ACCOUNT or
make it a followup to net-next?
The tdc test patch is still valid.

cheers,
jamal


>
