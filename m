Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41D4749C0
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057765; cv=pass; b=ud7znkItPwXzbEU7lnzH3hq5HxKjJ2yay/C4ICYCMFByBPdbz8RLAcBsWuhCL1yz/GR3Ip2zjsDuQv2buWa3Eg6bAiJrP1DydAntfSysnDjl7G8/YfeO8sXfKgQqQuK3xAe71vA2w7GjOH7PdoKUtlomn6sL0BlqTyDqQe6xuLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057765; c=relaxed/simple;
	bh=8WZmKtXfDYAxNty2zOXXko3KjoLk2aTZGmS07916+ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOg866MM/MDcdWhmAWV7bwVbO3cHPXAX/UFD+1T60cVQ+XFYlYVXedfWKFnYWrTWxH2rYXI8YG+L9fshZrQgB8DwDBl9zb/WXt0+XBSE8lOPxPpHEBTXXw2I19CUn0jmpYQXIUPzP5ePrTnAHE/6jZYHRn0lwWzgxqsjYPejz4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7LExdLw; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7LExdLw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5b048375so235889385a.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 05:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787057761; cv=none;
        d=google.com; s=arc-20260327;
        b=QJmyj1OvuFsED2d4Z6smRaLp+j3CGd0jmdaZdOj6IXMV1rmxrSUNoeBlEx+JJ7M3PZ
         CKTQcaEgN7jY6m/6+nen7l7C8kthWoS8Wc0Q0YnRp4cpajp9+STV8GG8u4qI4LlX/F1T
         9fI3YtTuMm7TeTKAO+hlV2hCBY2DhtPKS+E2bQqhyo3Dhzs9iLiuOaX/QpylsGsU4lqQ
         +GFRkF4Bl3Dx9AR2eshzycmztlGgFrqyMjJ62xBvVwzBSIeGuVOWsksOf/fENQ2zdP7n
         wGbK324PU7XAhNUWSfVb62r56kLkFtAFXwPPwNwrQmCm8s7rgGz9C9TWwmvP0fr1APFn
         jZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        fh=UsrKk07FccOpEtA/GUEbHfYk93l9IMcC52HeQuS9tL4=;
        b=JTilNfvdsfTSvJtu3y0nid8dqAew5BpuCRNSovQXofuffZkMHkeiAYEeNul5ETpHpc
         0jjtAQtuIbPbLiwrjuJPip7Xo7auxA1cS6JMRPUWJMsGtoDISeD9LACM/anKAoeFb1NA
         sAqRTWI65F415UPdr3hLSISHMgo0w29KId826VfhWr5AjoRp2pS5G+TE7MziT3YTBBaF
         zwWXOJ8Wd54NrZRt4M35R+erE4/elwH17J3BJdsIQ6qgVJG7M/ImaVdHSqCtCZunjJjB
         PyFlUGTCZWdmkp8ke103MHQ+HQInRkGr53T6OfJdoCvVijhu100cSmoOhvj36OrXDg1+
         B8jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787057761; x=1787662561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        b=N7LExdLwEtAL2n/lnUV3uWStJM0/eIePxM21vrERbsF3TSJhgd2YgruQ4N8gbJn2kE
         qK6/IHqFCB+kzGwr74RUAy8nPkyAMZjXiw92lWcNFYC+eyIYO7S+JcklUYj3lvMJY1z7
         0vKFfwpksTn+lvmLPKivqL94Qfk1Bf/h3xQ188po1L+iFpyUvbUmAjQQ/YMG/oFhRWzT
         Ka9Om7u0Xv9YLSRU1w0s4/WLpIZxknllRQTqOCiJkf2M72c0+8VuSRfLPjCV+0YF8hxP
         aAcwrUM3gF52AjY7rveXSCBhzXWYN/8+W0m0MT1Tzz7cmcHT35eEu+7s8AzTjX6v19Kj
         xDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057761; x=1787662561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        b=qCziW0ojOsLFFiLOrjMo59BndqCNlV9Ktvre7ARWYJgblaVTPUYazKU8287s3JDpFb
         DH0a3xuGElA67SaL3cTVljQQRHqgAvrnnBwL6WNDwfSeO50oPSL0qyTYWQyGULxf1nmz
         e/JZAnvXVytI/YZBBeF1fgV4bFh7z/OZTtMUrZ9wCqC+MgH5fMQf08Ny1fsO3fprMbUE
         DF3qZMyZIQqR4pkvRjI+pJAgfVuTSWM4Ek9EdXtG1Dti3Zur5/CS8IUVGnBQGxc6DdLz
         mPKD9he0ncxIwSLaubQ5CpHIC6ZEFNkhdYjzp/2iFRWz6+rzBRj2cVhBD0Ve1I/3i9wL
         I4yg==
X-Gm-Message-State: AOJu0YwukwW55fXN2ZI8EeO1Og2FR2EaRP/JlDF0HUikG/o377JpaaVH
	Az0rx53357KTHjchJyKX8v1HeFSIsW1YcKhrXbMVftBm7zQX+Tf2DeLrB8LMnUrLJnl8EtfwdCA
	TnEDozf9lc/t4/4G0HupdUlJf+w9RU76zNHNAHfak
X-Gm-Gg: AR+sD12gud+EeC7IistUJt650c7mrSOzPq5K37yfNU3KlnqFuLcOqL1zo1ppb/gJd4h
	THRYiKnC39kyswuvtABBxotF+S4zCYXvtB95flYFgmremG3vEmLNG2Z4wMe0EDMCIYQHT2jukLQ
	rv87ijPbTZIABVl/UIc9iGCiZpFufJeRXyhY7YylV97s+TD+eqhp98WA3OU0UFvzDpSHyvGc1uH
	xi/x9m30B/P560cx2bvTUfQBgq7YjpoQom5FHn6tap8G+GKQAURh/hxgRop1nwXXUuQ8RCtr9GW
	dregJMA4zdYWnSFbuZrJtahULzN61Ac0wI5PmzVwZl8xLAwzsCxTnF/iZCCh0tVwGdZsqLXPVAe
	vELLBvH5B6rdH4ZIeqRReOK9j4hTfbPnUa+rB5XT4aj1QuD+kzZHLTbl/3HwdBsKMOmMPZP6bcF
	FcbjD+sTgbyOKjmkA8u0a2PhysUA==
X-Received: by 2002:a05:620a:2b98:b0:936:c04c:27b7 with SMTP id
 af79cd13be357-93704b159cemr825658585a.19.1787057759870; Tue, 18 Aug 2026
 05:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101130.16203-1-jhs@mojatatu.com>
In-Reply-To: <20260818101130.16203-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 14:55:47 +0200
X-Gm-Features: AcwNN1XZLSx0-wKpDGGXkSHHqqvRkuUqUcFLUb_eZuGC9qhicoAFIq1yJEZzSEo
Message-ID: <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 12:11=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> Several qdiscs derive their per-flow quantum or backlog from psched_mtu()
> or accumulate qdisc_pkt_len() into a u32/int counter without an overflow
> or zero clamp, which can drive the dequeue/credit-refill loop into a soft
> lockup or a NULL deref.
> vega@nebusec.ai provided reports and PoCs which illustrated the following=
:
>
> - sch_fq: fq_dequeue() credit-refill loop with a small quantum spins ~1B
>   iterations under the qdisc lock (soft lockup); fq_init() computes
>   quantum =3D 2 * psched_mtu() with no overflow check.
> - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
>   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
>   packets wrap the counter to 0, and fq_codel_drop() then picks an empty
>   flow and derefs NULL.
> - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow chec=
k;
>   a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit +=3D weight=
 *
>   quantum loops forever.
> - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge MT=
U
>   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles betwe=
en
>   INT_MIN and 0 forever.
>
> Clamp the quantum to a sane minimum and promote the backlog/credit sums t=
o
> avoid the wrap, so the dequeue loops terminate and the drop path never
> selects an empty flow.
>
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c       |  9 ++++++---
>  net/sched/sch_fq_codel.c | 14 +++++++++++++-
>  net/sched/sch_hhf.c      | 12 +++++++++++
>  net/sched/sch_sfq.c      |  7 +++++++
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..66e9c6e530d8 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>         f =3D head->first;
>         retry =3D 0;
>         if (f->credit <=3D 0) {
> -               f->credit +=3D q->quantum;
> +               if (f->credit + (int)q->quantum > 0)
> +                       f->credit +=3D q->quantum;
> +               else
> +                       f->credit =3D q->quantum;

Lets not add cost in FQ fast path just because of a configuration issue?

>                 head->first =3D f->next;
>                 fq_flow_add_tail(q, f, OLD_FLOW);
>                 goto begin;
> @@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> +       q->quantum              =3D max_t(u32, 2 * psched_mtu(qdisc_dev(s=
ch)), 256);
> +       q->initial_quantum      =3D max_t(u32, 10 * psched_mtu(qdisc_dev(=
sch)), 256);

We instead can make sure quantum and initial_quantum are in an acceptable r=
ange.

[256, 16M] would probably make sense.
