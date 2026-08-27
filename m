Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1EB389116
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852387; cv=pass; b=IRTMZY8BR6OZ0FQQ+jJQ3eGtTqbSoNquW2YEzKLbBp/oYhX/xhI+O6IOhBP4ShcvkU2OWko/TCiRPkB64bucksnCKbxzMKXGULQSICAniZXN/mkYnraqYQssbEB1Aso999uWqZQQM0hzi25zZs62o9QrLTIT4GjsHY0Fj0Y35KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852387; c=relaxed/simple;
	bh=X9YbJ6QofxnPh7gMvJb/TbnUGqOGkcvag5nMxtHriUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6DgEZpmKMjtc2kAviXFAULEx5YYvLF4rSNtZZLNek7vtf4/xN6aPa7r6udu88UuhOnXZ+oHEpAA3rJF161CUPQiAVgQk35JAQPGAgVKFS5wvV0BLmO8kM/D7xg2EaF3KlVm6kGILSzEHxszpZARkmh8Z7bHgJtbDW34A9Z+dLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LJjc50/0; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LJjc50/0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8534d507f59so254852b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852385; cv=none;
        d=google.com; s=arc-20260327;
        b=ZSQe8ntbERAU/zFwJgONfgDg0NJLsM9VVaJ89aqWfH5+nSMMJqjrXg9vWa1bR0zLcf
         4vIMBcac8hkfzGlQ4QfX7Y6nmPnfXe0zI905ELZKbTv93PpCV+I30ZDHN3ZIT0j7ddpS
         4qx/iI8h9BusEpE0NzQXsshPN3TcDvaLE7kKpMhe1daAN43NX9k9Anqi6dhLOiZIY/R0
         nDCQLXLlgdXUYkR7AUitu1AxXbMpZU3sE/dJpZMi/bL6vGzN5byCwPBBbmSUQ/Md92+R
         RLtvoaelzR3mZ3OAYSzAPMlxPGIQeUS4K04Fk26mCxRG+I3L7EAlTsp2hxgYkDT9VSrE
         4SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        fh=VdIE8irQdMztvZvWd7pFJTH0S7KpJAO7/sagonXu1Kk=;
        b=Zr9GYFUvN9G2Ur2us+pKhbN8plmXGMXh6HXDmlLeNeIHtNrsZ37aGSUCEyXgn83rlK
         rxJthncwNVTZQNdrxiePhiCraPFpJo9+vreciPfB1nzFSb6gWHTZ2nvpY8pApwCjB1gs
         oZVbEn11ZZTDelFB4vN2dHMRX3jWIqHFj4Z173FM+pPKTgcIunGyMtpdEm83TglHCafy
         UxPeB7MxnSGvmjRmTXOJ++/cwI/en1mxqUj24lL29bdRFJjWlqwSxZlySoaGLUGv+WRu
         9Tw9GGPR22sqwv4eWzQXzs68GgdXYQ74NTbSQnrKdFPFNuLdUld0YNxbCfeWjkArDiiT
         NnfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787852385; x=1788457185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        b=LJjc50/0XCgM8Ux3z5UMx/sVPMDgySw3tFPe6REU5I2TTbGRMApNg2w/VRelLxEOZx
         IyH67SHJwyOz1Unpdd2u5UhXnruRvKsd1s5vQWwVJ8qc9A2hwrGkVOFxzw6Oy1Hhk5J6
         f0TO7Tb5jl64MievYIeAUK/GpTtABug4GFvfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852385; x=1788457185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTGdWxptOrtcajv4oSEp2WQDMzQSokE8vUw0BxvLVgw=;
        b=b+gf8IxZwS28kNrzThNAzcFgOs+qqLA8wEl4BhVkyG3IwmeYOhQhPD1B6PQWbQT6IN
         0kPyjX+X00XjwXKQ2gJLdSR7QLI+hrx6o2NkvDmXAokl0GSpZYTQ9GGgPe83xSI/761x
         X03AG1PDb+efq9prtJSMUNvZw3DNEqn93/WIPjUIHbrR8SmfGDuXbYbDPLDgWid6jc4A
         KfImexsF2/OVmGhlJU/9CT1ccucOsJLikqk/GiWE+m/LGGkoQDYtsk22rIC/VGG1rvVs
         p0vBcGcJ0dcSQA89inV1CzpYNtKYx6WpAcXBGJ0D3FcvABjvRCybyP6NfzYKTkaGgTib
         1uRA==
X-Gm-Message-State: AFuF++kw2/z7v9CqmisPpY3Io71VeXVGnCF81B7chRDS90p4fUpjZKgI
	asmsChdGRMbs4COnasiqPHuCL76sEJRkIzW9LSFPUf+gZB4Q3J38rIzXAy6KzLMSNCZOjJiZrS1
	n7POMOLED/fcoTgJmk+SMsavEau05J462H4rCPb7o
X-Gm-Gg: AR+sD13eYk+uee51XXMQqsU1WW/aeO8ECCTdTutnsGy7zOjhRMhoyeQQBH3xkwtVTIX
	WZzb4GpGZssXKNoOeq4Y3hKckWRW4AW/ZUzsZ9/2vk3d5gvnknRWMtGyRZVyxXCnUAQHlHHFTlH
	8mP0ACGTWb6EIsfdBe1smeGnXq2BmqHzI2G2c9XMUMJwIYn4PUSpoRRBygBkyAZYwIeigA1WCJr
	vnvUSM9zt3qCxLnf0AA25SbuJVZ3GVQuqfANsJQbRF+IKMeyQ5LgevZYARVDe8kl0npZQ8a0/+d
	C8CH/tudyPNzT+ON8AKHImUsHOl/5CTcFQsFoFsWO8DmwA==
X-Received: by 2002:a05:6a00:1143:b0:852:131f:b9d2 with SMTP id
 d2e1a72fcca58-85626f06db3mr1663965b3a.2.1787852384661; Thu, 27 Aug 2026
 10:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081751.134086-1-jhs@mojatatu.com> <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
In-Reply-To: <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 13:39:32 -0400
X-Gm-Features: AcwNN1XdcbmgV0dvtYrOQWsFkN2ugg8bCS-hzROqjekOwutDYlvFA_wJO950OTo
Message-ID: <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
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

On Thu, Aug 27, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> > pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> > ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> > bound. An unprivileged user (via unshare -Urn) can set a huge
> > tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> > memory, causing a system-wide OOM.
> >
> > Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> > in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> > Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> > via extack whereas for the resize path, the error propagates to
> > netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> > the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> > are charged to the allocating process's memory cgroup.
> >
> > S16_MAX is the virtio virtqueue size limit: the virtio specification
> > stores the queue size as a u16 with a maximum of 32768, so 32767 is
> > the largest tx_queue_len any in-tree driver can meaningfully use.
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_VETH=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET=
_NS=3Dy.
> > - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> > - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
> >   while the devices are down.
> > - Attach mq at root, then replace each child queue with pfifo_fast:
> >     tc qdisc replace dev veth0 root handle 1: mq
> >     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
> >     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> > - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
> >   rings of tx_queue_len entries (~12MB per qdisc at QLEN=3D500000).
> > - On the unfixed kernel this exhausts global memory in ~28 iterations
> >   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
> >   tx_queue_len is rejected with -ERANGE.
> >
> > Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2:
> > - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Ja=
kub)
> > - Changed cap from 65535 to S16_MAX (32767), matching virtio's
> >   virtio16 ring size limit.
> > - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
> >   already prepends KBUILD_MODNAME).
> > - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> > - Fixed tdc teardown to use JSON list form for acceptable exit codes.
> > ---
> >  net/sched/sch_generic.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index ef2b4bf51564..eb5c0d3f67c2 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, s=
truct nlattr *opt,
> >       if (!qlen)
> >               return -EINVAL;
> >
> > +     if (qlen > S16_MAX) {
> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "ring size %u too large (max %d)",
> > +                                    qlen, S16_MAX);
> > +             return -ERANGE;
>
> Sashiko noted that setting a large tx_queue_len to a down
> interface gives an inconsistent behavior:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134086=
-1-jhs%40mojatatu.com
>
> (all other comments are IMHO noise and should be ignored)
>
> I don't see and effective way to avoid that, short of falling
> back to v1, WDYT?

I changed my mind on this. See this thread and let me know what you think:
https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=
=3Di=3Db+xKg@mail.gmail.com/

cheers,
jamal
> /P
>
