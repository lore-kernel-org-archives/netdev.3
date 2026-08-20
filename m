Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8447F774
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248074; cv=pass; b=NkJE0RstE9ZjoELb97CG8n1oD8qyRqFGA5DfyNmhXu2de4CwBms010XiJ7gfcDV6UEcTSmdWFbqbnxEeYXuvGU5u2KrfEUxxpvOIlL6ItfGP/DeWdKHbtPYX9OXUoWBIuQ3SrAqGqQZEjUnVi1m4AkriRGLGJ9MF069JXzO3O+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248074; c=relaxed/simple;
	bh=PK2juyR0+4sSX8nWB4ZgPQINhNKqxmYt1dGYGExkS/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIwDLaWpFgEeL4oLfCSd9w3RYMxhjd1LTsH0ghZXT04Gz8KK+ZBT/ZDHwKGBzB/td4QHaVDc9tsMn6hmX5aMctXNPccNgnGBoeMXaIeRF17wKkrCqmZVIqdbz6kNZvDs6ZWMVytj/j9g6W92owF9CKxtkKCDSYjsOg+ZHHxfbuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vnIyjEaJ; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vnIyjEaJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so72355b3a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248071; cv=none;
        d=google.com; s=arc-20260327;
        b=ppaf/cpxqptdjqS48YxkCvXV0YFEPDHxwTQJjBW0f9Sw32nF6Uk5oabbx2gOGOpSPc
         +4MbvDknHDkZOWyYcCJPmrbGQI1vIEg1exRtIcorxbXbL/XpCklMQdwHVsmcc5x/x1qu
         axBvuy5y05BPt8nTA4YynxNkoNNdz3RdUd/vOWXbj9w22LpsUJUX4ZJQbQ+fPSX90frf
         KWXmZWCGlv6PoMfHnjKRubC+XCpefXK2achIjfmmpzi7riNY+50i5Ki2OwJAQL/u81Eu
         1Tp7CKu1QGpoy8CAWqJEVS5aPnp0Vy4rbRqAHt7DqT+7SgF5RnEtOMN5IaFPHZIuDf0H
         7ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        fh=EAg5rmz5WXGp3M2A+OrgXBoap7BJ6iKjVtr3srN9cNU=;
        b=RTawx/lqYhsZaxAivk5olEYKH0mu/1TgH9RFsjxi20iLulNXre7ny215waQ753hPzT
         iWM0JnboYadDwQ6Q6SETYpNqZCFHKc8s/8hoZQj4VjgtuvlkiZ4ydfNWiLvH93X461i/
         V2C2dMBk1hHwcxAMEAYtMomOvZS5k02EN4ITQjYV62BvGqGQnARtUuAJ8Y7TiwPtgZgJ
         fd37eoMyVxHQn6RZ0gzHKSZ74ts1G5TZId7K1E2+tGvMKFOnDqUgxVuDxQNjsh6HR+kS
         WfFmRQCZw99im7qg4XlbOnAI0MnQt4ohTyOjsmOF4ikIUnJnXwN/iGBrq6LqpWNJcYj0
         45Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787248071; x=1787852871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        b=vnIyjEaJQ85wiQmWq9/HZ0YNhFrt5xGZGkKaYVPywExqrIzITq7r5umWa3fYChFPoT
         pSoTYc/+VCJ8+a3x4tdX08a00OmnYtGsNdq1/EIX8HtIiUjhNPcemm9OciJfs8bYBaN7
         2p5aCp6NnajzST4vg9AObzzFInSWfL9FjU0Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248071; x=1787852871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        b=O8MsXGn21oLTupJJQx5C44L5vHKmsDABvp4P3ysihYN64CcGQJ+thcjEUoYsXTZwW6
         rkU4uXW9DcmQdLBsgtacVGCkAUmnp/HxI6eY+jCFJA//n4ONfQH3MXAEsxwTcjIUGaL6
         MUrP3jr8xhjzp1ylIs3xBgGZIGD76qhi0UPRwh2n61J3hZZd2vBzzJTrWtwgWUKfpJ2y
         MBxGxhH2DfwEjn+evVPvpba6XHkCOz4du7inzsMH6f8mhEJ/oJutguBfa+eA+O1U2pNl
         RDvRlXQ3FZ1/x43nCiAYV2A9744KN8mAoqRU28NNEJfqhvdbKAiV8L8zPaByill2FVWN
         G1+g==
X-Gm-Message-State: AOJu0Ywylg1OF7wB5DWPS2cRDP0NieKo5Igvi1BarBhrAnMM8LI3RxQB
	IvxCU8qv3BzbVJfaUfMTgwjmWdhONiZq3pfvyR3clkO5GCjZsNja6NnbHloAiWUY3+uRDFEbGmD
	P1qBUlApHXEHfQwZI8sUPl0LM2zBqud+4GgB7jErlYUmpJroGhVzMxS5A
X-Gm-Gg: AR+sD115FKsYGRd0pIAADqdr/J2GIpcZ1LriNqeZf0Bfx+7eEeZ2J934XRey8DgtU+2
	o3qARBYudRbT3n76wFre1U3fjR5Snt4qu2x9CH0VJ5vr0eb396AYt/6j7RvlfDzB5/JAQF7OKlw
	qbF7ZGbZh0thiPza8RT9ugMwYkTilXyWjusCEUEZJ0aPeJmSoBmrgV0g1O8gVMYd2nuEGwBqAZc
	mcsXkLu9v1x1D62in1wyTIuiz2MG7flMV4KDFt4w82HzvH4fGbiJFTDmSv4vKZdubKzf9Gi2W3n
	yQaogrIBazsNMvZXZBqFhdwmqGnWYVIeE+5HM6qXBA==
X-Received: by 2002:a05:6a00:37c3:b0:848:76c4:fba9 with SMTP id
 d2e1a72fcca58-851e6741ab6mr11315632b3a.7.1787248070664; Thu, 20 Aug 2026
 10:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101735.16655-1-jhs@mojatatu.com>
In-Reply-To: <20260818101735.16655-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 13:47:38 -0400
X-Gm-Features: AcwNN1U622mcQ_XE5FHiQQfckxRpOICEQKMJI2lJXfG28Y0JomuR068mochjHag
Message-ID: <CAM0EoMkoRBX5-RZu4-zwJ9CEDFj6sE7q5mzvsoS1bsbjYkz=4w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: bound TCA_STAB overhead to prevent
 qdisc soft lockup
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:17=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> qdisc_get_stab() copies the TCA_STAB_BASE overhead from userspace
> without bounding it. A huge overhead (e.g. 2147483000) combined with
> a small DRR class quantum (1) makes qdisc_calculate_pkt_len() set a
> ~2 GiB accounting length, so drr_dequeue() spins ~2 billion times
> adding quantum=3D1 to the deficit under the qdisc spinlock with BH
> disabled, producing a soft lockup / RCU stall.
>
> The same unbounded stab overhead also lets qdisc_pkt_len() overflow
> the per-flow counters of other qdiscs (fq_codel, hhf, sfq), which
> were recently clamped per-qdisc; bounding the overhead at the source
> closes the root cause for all of them.
>
> Reject overhead > 65535 (matching QFQ_MAX_LMAX and the max single
> skb length) in qdisc_get_stab(); legitimate L1 overheads are a few
> dozen bytes at most.
>
> vega@nebusec.ai provided PoCs for both DRR and ETS demonstrating the
> soft lockup.
>
> Conditions to recreate the bug:
> - require CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> - Create a veth pair (or use lo) and attach a root qdisc with a
>   TCA_STAB overhead near INT_MAX, e.g.:
>     tc qdisc add dev veth0 root handle 1: \
>         stab mtu 2048 tsize 0 overhead 2147483000 drr
>   (or ... ets bands 1 strict 0 quanta 1 priomap 0 0 ... for ETS).
> - Add a class with a tiny quantum of 1:
>     tc class add dev veth0 parent 1: classid 1:1 drr quantum 1
> - Send one small packet (e.g. `ping` or a single UDP datagram) on the
>   device; the ~2 GiB accounting length makes the deficit loop spin
>   billions of times under the qdisc lock, tripping the softlockup
>   detector (panic with kernel.softlockup_panic=3D1).
> - Reachable as root, or from an unprivileged user in a fresh user+net
>   namespace (`unshare -Urn`) with namespace-local CAP_NET_ADMIN
>   (Level 2).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

I sent v2 and i noticed when i changed the subject it confused patchwork

--
pw-bot: cr

cheers,
jamal
> ---
>  include/net/pkt_sched.h | 1 +
>  net/sched/sch_api.c     | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 18a419cd9d94..a4c1b7b0263d 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -12,6 +12,7 @@
>
>  #define DEFAULT_TX_QUEUE_LEN   1000
>  #define STAB_SIZE_LOG_MAX      30
> +#define STAB_OVERHEAD_MAX      65535
>
>  struct qdisc_walker {
>         int     stop;
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65b35528d125..cdcf861c85f5 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -544,6 +544,11 @@ static struct qdisc_size_table *qdisc_get_stab(struc=
t nlattr *opt,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (abs(s->overhead) > STAB_OVERHEAD_MAX) {
> +               NL_SET_ERR_MSG(extack, "Invalid size table overhead");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         stab =3D kmalloc_flex(*stab, data, tsize);
>         if (!stab)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.43.0
>
