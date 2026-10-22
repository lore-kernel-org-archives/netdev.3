Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660492;
	b=3J63XRDJ0RLzN5J8cKsBJIUCwMCo8tlT7NSkON/6o4tcTPn3DU+szS+CRLPauWl6x86Y
	 PshM4Imi6+zkBPQc52psDoE2H/OX+qGFq8dubp13JBqBZzB7cW+r+ZPVCXVWOO66rNrI1
	 8O9MoqkNHpunZLN5c3WSYGu3wkwau8BlojIU/a67xWcPePzKO4V6R3jo1FWrVoPzNSjx+
	 qu2OM5Jjep83sTDfWIfQ1UKYZVjh4KCC6aU6RiTEh/kwPFLKZScwufCZ1EnahxJk/IqX6
	 oowViOFMDrKMRNKFJ46yoAwUAXWYoay/Db0RQt9xzs/3ioLM6k0CQKV+gG/fJKeZAyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9co7tSosO1NT5+GsCtzpgr4VrYszNR5FX5+n+UHBqPo=;
	b=iMANp8LwErju14G6hFd0fw7lU0qVJxPk+0DT7wXR4nXrfF7IHyNhTBSCiDQNgP9Kdenh
	 upl2D2aOopi0j4HHrvfwVXKyIWlVWmYI4Ek7ukJ+lACLkD1NsFcEZSBiXt81oMhZmLp34
	 VV2nBz0XRZEvdYKzdzSfR6oQIOUj3mxg7FOMoDwQAIvbszntHQmP8ajdors0ZeORWozgR
	 +qfUaQGy05UWCW/be9UlpiGSEzs+tadUnNpRJGpXwBrz5vkJNKXYneM9sQjiuuvIuDQu+
	 GhykIsTe3I6mlSKZ3QFelgyPtrmf+S7gkVE+dY551BC25Ow3fOeXsVKatSYewS4oifA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VCKtHp26;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DE606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 408DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VCKtHp26
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06e79e152so752089b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660490; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTCuYHn+BNXwGTnr6/Q0rjWgfLlmsNQWmGnxeMPp8V6NkmKOtGN402ew26O507yZoY
         S0ZQQDBFup685p5smLRwFlF6LMUrttkptuJOJ4jYyA//tsgBjNiwIofPlttLNk9UzYxI
         QWK0kH7RbKAxU5PnQhwKciOYLZusfWKrvnXPWpbH5tkdLuuTfdh5hlS2ifCndcFsCLFW
         knZhdaNZhNfvmL1YWGXPx4hvNMswzBNcbDuH33zqnHky7h7vBr/8dgumI2wSvHmn2Zc9
         xEwYNBNIb3ICoYk0Q8ybARAjFCEwO5t1QX4HdVEBhJgd+KiWa/zREV+Atuec0u2cZkRW
         3Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9co7tSosO1NT5+GsCtzpgr4VrYszNR5FX5+n+UHBqPo=;
        fh=DVu2Rj/QxXfEUPtJLkFD0edxL9kzZmakBFEc6nZXNQU=;
        b=FQnYsl3mJskz962/d8oBTslsf8/KBBOyKCXVc+SMwcICq3Lj0b5iyGSr03/bem2XAK
         wRat6TetzUNWf1dEl19MoE8/SyNo5OoxcCH+meEDUM+GBiv5Rd6RDEyHkKaJcCqmAQXx
         13C8tgjSaMpS0H/YdohZHGQV/0vAQUna6ihyGG9iDFTbIGoDOxF5YclNFNvPWrOYpS0m
         S1gf6OCM94qzbcyTIYtIJcKTUcK23Rt5CJM8Na7vy+k8q1gMf0FaOqpJ2r4oK0X4dkL1
         zZguF2pdEgXfkXQ9grsmR4N2sQjlL3oigp0927cg/BhPH6yHasNKAhS07hDvNDfD2iYd
         64Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660490; x=1793265290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9co7tSosO1NT5+GsCtzpgr4VrYszNR5FX5+n+UHBqPo=;
        b=VCKtHp26rMDwluZSd/4/1UR1dwqIILCPxqkGXCvCfuNEkAe0P3OWJcQsKIkGlxKq0B
         JauD0QYo+92KcNgN+orsj3BPfqhFgAmX6XE1ZD74KqleknvjesEpGgbXAtmdJAIJWw1i
         9WfJasMPArS51dKsT4e6fye9XILmy+qE4bNMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660490; x=1793265290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9co7tSosO1NT5+GsCtzpgr4VrYszNR5FX5+n+UHBqPo=;
        b=2fn2w9i/pWqPGbfcodQHtrSkMsV3VbGrIboKwDhZ+1D1yUZkK6NiDtkwAzAwWb15ps
         dzB9KBYo24NZ1CtVqh/PSJYVSRhJDGnAZyRvTbTMijITdRDrbGpZnA856W6hTmomEU5i
         NfteH9v+O6MtVuf+1J4nclrQHiGggudWFnYQXv+QT5ujWMrx3+OytC+Ut6OjRht/2b1V
         g0Tj9rrwsKTR6R8nEXdgfgD2XMWBelw4xBS5jkOlLqESSTNahSMnNwmhrtYIbc6e2iGO
         fS1TJ36ZDX97VmnloL7NuCc5RR4AcUlz1ZBEHraFedYlNIOJ/z9quzwooelO04Q3olcJ
         lmjg==
X-Forwarded-Encrypted: i=1; AKwUvBxZlP/nI9p7d1f5FufR5THCYb4Hd4Elw74d0SMvTzg2e+f82ftRIzNwNl5/wTU3zR3bHJz17gE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrF9ivU4QJhYMo4W2LTPsGLHpuemBQpGl5YZxuB1Z9plLCFv/c
	nWlZ1cWiv/Ni+kWhy/B6OML3tVrWKNA/i4elbnxe8e9bWzqw9vYNamc6jnTmPlBVIHIBYPABitR
	w6LizcWj8eRXEpb8xsv4qiObCYMmR7lcSDpaIjNa6
X-Gm-Gg: AYBFou0u6V+FJ/+Czp+7ET/iCf5vCtMod+WW+pyxoiC3SDuGgDw4t6JgvfW0uHKvSCR
	T/ywPphbvBkoqYu4SkweG7PtXB81dGKo78tD9kWIelIntTVgyCYXwRzP4XSSgS4xR775qKj61mJ
	m10A9HpmjKD4VJWc+rDrvkHyOJSlzNeX+I+MWKrJicuKZuM6S2xSDJLmoXB1jdecshPf9RrQEYA
	xS9U5h1N6LS9cacLmVPkPRbk5oE8DrQa4s1FKUKivjIzCXEtvL+3FFBeRp1ffRS2eUoTr6/w3jF
	2ARLNR0rqTXPpKuYi0z+q2fxBRjSstmtE16HP0wN41NregswuM+fEo0XWa0gEmqjmDYsAUMGuQ3
	m8kH2HhDnYBQ//iAH2qL0N2InYQ61qLiwx3NpUUZJ5GY2HuJdSxI4nTgFN/udfM+9QZrp+sw55A
	D1TQmR4a0kkhiZhpo=
X-Received: by 2002:a05:6a00:1c94:b0:8a0:20e0:b131 with SMTP id
 d2e1a72fcca58-8a089f250cemr3406412b3a.19.1792660490595; Thu, 22 Oct 2026
 02:14:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
 <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
 <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com> <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com>
In-Reply-To: <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 05:14:38 -0400
X-Gm-Features: AclHuK_dV5iV-K-FqlLOG7EjQwj00HjHhl1qxOWtD1RjLWmEzwEJj7wLhmR3d8U
Message-ID: <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: David Lee <david.lee@trailofbits.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:56=E2=80=AFAM David Lee <david.lee@trailofbits.c=
om> wrote:
>
> Hi Jamal,
>
> Following up on this thread. Please let me know if you had a chance to re=
view the attached reproducer or if you need any additional information.
>

Please resend to the list - I lost track.
And if you follow up after like 2 months(!) you will really have to
retest with the new kernel and likely look at the list to see if there
are other fixes that cover this issue.


cheers,
jamal

> Best regards,
>
>
>
> On Mon, Aug 10, 2026 at 11:22=E2=80=AFAM David Lee <david.lee@trailofbits=
.com> wrote:
>>
>> Hi Jamal,
>>
>> Reproducer has been attached to this email.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>
>> 1. Build Linux at 82a47586c0b9266622657009aa30573dddf09f53
>>    with the configuration options listed above and KASAN enabled.
>>    Use a system with at least two CPUs. If QFQ is configured as a
>>    module, make sch_qfq available before running the reproducer.
>>
>> 2. Build the attached poc.c:
>>
>> ~
>> gcc -static -O2 -pthread -Wall -Wextra -o poc poc.c
>> ~
>>
>> 3. Run the resulting binary:
>>
>> ~
>> ./poc
>> ~
>>
>> The reproducer creates user and network namespaces, brings up the
>> loopback device, installs a QFQ qdisc and class, and races class
>> changes against packet enqueue. Race timing varies between systems.
>> On the validated KASAN kernel, the expected result is a
>> slab-use-after-free report in qfq_add_to_agg(), followed by a kernel
>> panic. The full observed output is attached as splash.txt.
>>
>> he issue was reproduced on Linux 7.2-rc3 at:
>>
>> 82a47586c0b9266622657009aa30573dddf09f53
>>
>> It is also present in Linux 7.2-rc5 at:
>>
>> f5098b6bae761e346ebcd9da7f95622c04733cff
>>
>> As of July 27, 2026, the vulnerable sequence remains in upstream
>> master at:
>>
>> 62cc90241548d5570ee68e01aaba6506964e9811
>> https://github.com/torvalds/linux/commit/62cc90241548d5570ee68e01aaba650=
6964e9811
>>
>> Required configuration:
>>
>> * CONFIG_NET_SCHED
>> * CONFIG_NET_SCH_QFQ
>>
>> The attached reproducer additionally requires:
>>
>> * CONFIG_USER_NS
>> * CONFIG_NET_NS
>> * CONFIG_INET
>>
>> KASAN is recommended to observe the first invalid access.
>>
>> Regarding the format, I can send v2 if the reproducer looks good on your=
 end.
>>
>> Thank you.
>>
>> Best regards,
>> David
>>
>> On Fri, Jul 31, 2026 at 12:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>>>
>>> On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM David Lee <david.lee@trailofbi=
ts.com> wrote:
>>> >
>>> > qfq_change_class() snapshots the current aggregate settings while
>>> > holding the qdisc tree lock, but drops the lock before selecting the
>>> > destination aggregate. During that gap, qfq_enqueue() can move the
>>> > class to an aggregate matching the requested settings.
>>> >
>>> > When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
>>> > If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
>>> > before qfq_add_to_agg() immediately accesses the same pointer, causin=
g
>>> > a use-after-free.
>>> >
>>> > While holding the tree lock, skip the replacement when the destinatio=
n
>>> > is already the current aggregate. Any estimator replacement has alrea=
dy
>>> > completed, so the class change can finish normally.
>>> >
>>> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at D=
RR cost")
>>> > Bug found and triaged by OpenAI Security Research and
>>> > validated by Trail of Bits.
>>> >
>>>
>>> Please always send a reproducer - either as a tdc test case or if it
>>> is sensitive send it privately to me and Cc the other maintainers.
>>> As trivial as this looks I will not look at it without a repro.
>>>
>>> cheers,
>>> jamal
>>>
>>> > Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
>>> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
>>> > ---
>>> > Trail of Bits has a reproducer for this bug that triggers a
>>> > KASAN use-after-free and can share if needed.
>>> >
>>> >  net/sched/sch_qfq.c | 3 +++
>>> >  1 file changed, 3 insertions(+)
>>> >
>>> > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
>>> > index 6f3b7273c..e900890e9 100644
>>> > --- a/net/sched/sch_qfq.c
>>> > +++ b/net/sched/sch_qfq.c
>>> > @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, =
u32 classid, u32 parentid,
>>> >                 sch_tree_lock(sch);
>>> >                 qfq_init_agg(q, new_agg, lmax, weight);
>>> >         }
>>> > +       if (existing && new_agg =3D=3D cl->agg)
>>> > +               goto unlock;
>>> >         if (existing)
>>> >                 qfq_deact_rm_from_agg(q, cl);
>>> >         else
>>> >                 qdisc_class_hash_insert(&q->clhash, &cl->common);
>>> >         qfq_add_to_agg(q, new_agg, cl);
>>> > +unlock:
>>> >         sch_tree_unlock(sch);
>>> >         qdisc_class_hash_grow(sch, &q->clhash);
>>> >
>>> > --
>>> > 2.53.0
>
>
>
> --
> David Lee
> Security Engineer I, Application Security | Trail of Bits
> trailofbits.com
