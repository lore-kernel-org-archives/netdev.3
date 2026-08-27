Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE852D7D47
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855961; cv=pass; b=PqU/YSMaV96A/WhNkL8HsbF1GbBl+rlCpjEtPjEpBYRUHc1FcEWIJAs4K6afdTmGDb0x8VuT8f9UKcKQHQDJZ0ZvEs4mEUS2iXYCIX32yXyxSDfu+wtKT6ABM+iYURYTr5DHM1rQD/gPUx7u66Y6Fni84RgscGeSX2UXprdBz7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855961; c=relaxed/simple;
	bh=t1YTCYnw7taCGQOC3DmeU3gnr8wnT7msmENWPO1h/kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcPutUJsSptC5af4HED/qVIufTQaH/X9BxyXau4pBXfd4fVbtuBmFOw98Te3lJnJXDVnPXEpAtoSKZ2kyDL9eod2rXcD1xtUGFKORrzL+dSA7w9OSJDIWCCKoI5BJiZAL38qUfXJlhftC/B60xTwEp+dagVW7wphWBA0d9d6PqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DdbjciqO; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DdbjciqO"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66d146f04cfso536618d50.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787855959; cv=none;
        d=google.com; s=arc-20260327;
        b=E+7RxNnapWgMNEGW2hSZFxXAKh3e1QUwZlV5wA1Od294ZtKx9pcxx3Eu04tcW5QQmt
         R0m3YZknoDdsvCIHfqSJNjUMWNoIMvm8xTvwXWEaIrkCT5UNfYrBeFTiGlonEuDjaSSR
         MS2Hz9cMbEfz4WmGABHv+szTY/4T7JZUxhc18r5hkuXoFdmxnmBYPRp9nl7j7/g4RmeC
         GJgl0J90/QC64jy6cc/IK+YzqRCHnvTzl/y8VjsvZIQgnXDCWDwXpf/cy86j3ylyY3VR
         HgGtfDibgvTwInnD2mExz5S9HzmoPkwteSMCi5asUbbBpnd8fCOfsarogtQfnNlwTJYA
         TcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAVPEg27oHBf2ZAIG8X1Zu028g2AuFXVbv5fslOiiKE=;
        fh=8ZY0tp67fVj6e7mMovC1rSveYX+wb40ljVaIKF5IUUE=;
        b=hDAXtI//LgL2OUvzbKqP6Hk2HzPxsn34AItxXgmCdpA35wwyCsshZkqczU+yPDnqIP
         kmB6H/H697iInd4OvJFFkaYvTbiAHct/SaP+ThFg4Z670Z2cbGjFV+SDj7nUrnJaxCCZ
         bC4TNh+o5b4ezcgk+EYTjruUV2wvZMjyk/8ugaEPEVcw8AjWoJwaLPyiSd+HzuoTiN/T
         nsGMN0bb2bUq7+1fI2Z553tkq2/4AhqaT8QkqLZM04HAfcbpYNkfJ76ptpoNw2YO+7BC
         Tl2KB2K4Q5cw/ujqf3swoY4JNjgFg437fTahW7DUNy9nwI6GarRvA0yctOX1WBhqh3XH
         3Rbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787855959; x=1788460759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uAVPEg27oHBf2ZAIG8X1Zu028g2AuFXVbv5fslOiiKE=;
        b=DdbjciqO/tYDHAqLYmYiVScxuUbzqGM+HtUn2KV5h5DzAwYQetyhc4aZBKHuZXeYbt
         t0arkLZ3FvXbxLqCtR0b8XuPKpfU78EuDrgOQqJE5ZpdcXz9d4KICKdGprr6w4Cr1A7G
         qH5MxJ0aOHzxASxAeERHOyfFXlgnY0yIGuPkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855959; x=1788460759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAVPEg27oHBf2ZAIG8X1Zu028g2AuFXVbv5fslOiiKE=;
        b=blHTZULz6lqe2Cn5lhMXEBNCbFStAt3J+5BLoe0DdE1SJsNShSkCeTrDaXVy9VypA8
         f/0GT88rtGS7KLNMyEgyBfuCh6Ixe9oV7vStvkqi5HvhYimpvEQJAR1lmW0mjS3fDypl
         Ob9cXjfeLFKaZNGSE8hEj3M9/1Fmk2X3mTY3rssC5fFinBgfkGdr1Z05f1zUDdDrMcxc
         cEJBgdGxvysBflNEL+x4pFMZr8OhxhrbAUSX8PDN3oBAAeUn0wmXl3veL3VeNRmNU7Ua
         g0GtyvknuQ/wVVbD2NjDW4nmdr2Io0uFm9u4i32lCz/snoU+PZq44YPqvSgnK0u1xgsn
         mM7g==
X-Forwarded-Encrypted: i=1; AHgh+RqvuREmef702lyIVnb8wqOCLZbL27DsWWXBSYzt6MIJwV0r7pjzTtrMnemiNc5klbSjAXE2tsA=@vger.kernel.org
X-Gm-Message-State: AFuF++mgrjXZCs75IPWTL5Yz6uSKTXr4l5LOXP0HzdnsSe7DAK6cR3UF
	I5hNdEc6CnQLRe0/Hz6Tl3gowoe2t5p+b2h3Yd3ApIIXikJ8J4nQjhoYeJxbGQG6Y6aHSvaQxvf
	67u6ElIsPDkSuAx+Gm+ReGjVoDUVtvw0IFYypwdYg
X-Gm-Gg: AR+sD10u7oE4P1VjU1EfZ2QIJWGZYd6ODN3LwQIrb1k/a7HTQ9j+xICM/nbH6NZol1c
	JbnyBkm6IHqOs5IJXd2CQTHJbn0ygatcGICcP7NgB1OndxIq8o+Yq1gidUTPZiX+sKUa8p0CHNN
	AMcypVkXLpibPKOxWmIqWW3uuaaa/8HvOW02OxSsNC7bqW0v/yndMTuKKdJxLP+DXNr/L6MF+fN
	i8crNBgQ8tI+kr6HI+nDhvD0o5glfMqp1YtKar+Ez/ecFPBcj83cRXoIRdE16sjVeAjLuuKudSJ
	10uGItKYU3oyTaA5R2Wc4ARMGZoZ180Czlu40XlnLrgggc+njdUkF1cmA48=
X-Received: by 2002:a05:690e:d4f:b0:667:5cde:6f36 with SMTP id
 956f58d0204a3-66e4c539b60mr246521d50.33.1787855958597; Thu, 27 Aug 2026
 11:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153903.4143642-1-victor@mojatatu.com> <20260824153903.4143642-5-victor@mojatatu.com>
 <20260827085332.GC396647@horms.kernel.org>
In-Reply-To: <20260827085332.GC396647@horms.kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 27 Aug 2026 15:39:07 -0300
X-Gm-Features: AcwNN1VYL_swJuqZoqGbNCgXQCvpH4j_MWpF70vC4RkHQ7Mo9FK6vF0EKtv0QcU
Message-ID: <CA+NMeC-xaHMo9N6fvu_TGtVEgeaCexFmLHqMAyTcn40gFPMG8A@mail.gmail.com>
Subject: Re: [PATCH net 4/4] net/sched: act_mirred: account for
 TCA_MIRRED_BLOCKID in get_fill_size
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, pctammela@mojatatu.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:53=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Aug 24, 2026 at 12:39:03PM -0300, Victor Nogueira wrote:
> > tcf_mirred_get_fill_size() only budgets TCA_MIRRED_PARMS, but
> > tcf_mirred_dump() also emits TCA_MIRRED_BLOCKID whenever the action was
> > created with a block instead of a device. So tcf_mirred_get_fill_size i=
s
> > missing 8 bytes in its accounting.
> >
> > Fix this issue by accounting for TCA_MIRRED_BLOCKID unconditionally:
> > it costs 8 bytes for device-mirred actions and avoids having to read
> > tcfm_blockid outside tcf_lock, where a concurrent replace could change
> > it between sizing and dumping.
> >
> > Note: Dumping mirred with blocks currently works in most use cases, but
> > would break in some corner cases, for example, if there are 20 blockcas=
t
> > mirred actions in one request, each with a non-ANY hw_stats and a
> > non-zero user flag, with a listener on RTNLGRP_TC (or NLM_F_ECHO):
> >
> > budget 180 B/action -> attr_size =3D 20*180 + 24 =3D 3624
> >                     -> alloc_skb(3776) =3D 3776, tailroom exactly 3776
> > emitted 196 B/action -> 20*196 + 24 =3D 3944 > 3776
> >                      -> tca_get_fill() fails
> >
> > Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>
> Hi Victor,
>
> Although the issue flagged below by an AI-generated review of this patch[=
1]
> may be strictly out of scope for this patchset I am pasting it here
> because I see that quite some work is being undertaken to correct
> get_fill_size issues and I wanted to be sure that this is considered
> on the scope of that broader set of work.
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.41=
43642-1-victor%40mojatatu.com
>
> AI-generated review text:
>
>   This is a pre-existing issue and not something this patch introduces, b=
ut
>   while the audit is being done on get_fill_size callbacks, was act_gate
>   looked at?  Its shortfall is unbounded rather than a fixed 8 bytes.
>
>   net/sched/act_gate.c:tcf_gate_get_fill_size() {
>         return nla_total_size(sizeof(struct tc_gate));
>   }
>
>   That is 24 bytes, while tcf_gate_dump() emits TCA_GATE_BASE_TIME,
>   TCA_GATE_CYCLE_TIME and TCA_GATE_CYCLE_TIME_EXT via nla_put_u64_64bit()=
,
>   plus TCA_GATE_CLOCKID, TCA_GATE_FLAGS, TCA_GATE_PRIORITY, TCA_GATE_TM a=
nd
>   a per-entry nest:
>
>   net/sched/act_gate.c:tcf_gate_dump() {
>         ...
>         entry_list =3D nla_nest_start_noflag(skb, TCA_GATE_ENTRY_LIST);
>         if (!entry_list)
>                 goto nla_put_failure;
>         list_for_each_entry(entry, &p->entries, list) {
>                 if (dumping_entry(skb, entry) < 0)
>                         goto nla_put_failure;
>         }
>         ...
>   }
>
>   Each TCA_GATE_ONE_ENTRY costs roughly 40 bytes, and parse_gate_list() p=
uts
>   no bound on the entry count:
>
>   net/sched/act_gate.c:parse_gate_list() {
>         nla_for_each_nested(n, list_attr, rem) {
>                 if (nla_type(n) !=3D TCA_GATE_ONE_ENTRY) {
>         ...
>   }
>
>   So for one gate action the emitted dump is about 256 B plus 40 B per ga=
te
>   control list entry, against tcf_action_fill_size() returning 264 + 24 =
=3D
>   288 B with an NLMSG_GOODSIZE floor of about 3776 B on x86_64.  Beyond
>   roughly 88 entries, does tca_get_fill() start failing?
>
>   If it does, two effects follow.  RTM_GETACTION on such an action return=
s
>   -EINVAL unconditionally, since tcf_get_notify() builds the reply even w=
ith
>   no listener.  And on RTM_NEWACTION with an RTNLGRP_TC listener or
>   NLM_F_ECHO, the failure happens after the action is created:
>
>   net/sched/act_api.c:tcf_action_add() {
>         ret =3D tcf_add_notify(net, n, actions, portid, attr_size, extack=
);
>         /* only put bound actions */
>         tca_put_bound_many(actions, init_res);
>         return ret;
>   }
>
>   leaving the gate action installed while userspace is told the command
>   failed.  Would it make sense to mention act_gate in the series, or fix =
it
>   in the same audit, so readers do not assume the sizing audit is complet=
e?

This looks like a legit issue, but I think it should be part of another ser=
ies.
In the case of act_gate, I think we should limit the maximum number of
act_gate control list entries first.
Since those are unbounded today, the message size could grow
significantly, creating a clear path for excessive memory allocations.
Analogously, it seems like sch_taprio has a similar issue...
Since the entires there are also unbounded, it might not fit on a dump
which always allocates NLMSG_GOODSIZE.
Will also take a look later.

cheers,
Victor
