Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A339EF0F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952866; cv=pass; b=PmKPYtrDBXg1DrXoNA4SvV0Y/M6yWZnow8AaxtPb0A4FsABcMEvLbxD3TzzyF5sPo698qPJ8DztZDg+jq86cfG8km1gI/3YdLS6ShAStnpL3EMuh54kHGG/bUpFzqPsUhDEBo/c0M4efs942yBbzway2Y2ULH2/GaIYwgKqeIp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952866; c=relaxed/simple;
	bh=indTwi+3WjS9NSvy8W8k85TDGxYoCbuAcLS6EouvusI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCwgYdsAQJlAF+Gbex3KT2UsF2IQuuQ3pLxwjGUFOcXhFsPyaZ6A3QjRGVmuM7g6ZECVd/XuxiPBvO2S4ZtE5BeX/NmR0mFatyGUGeq7+DqCoUQXyejKIJuy5VHx9hoAetoz33mBJxjGATi2j37oKZTpkTQCNu4yBIpZGyLIfV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Z/uE1Q/R; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Z/uE1Q/R"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84847482584so122038b3a.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 11:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952865; cv=none;
        d=google.com; s=arc-20260327;
        b=a+lWfR3KmEgcyaXFL/gdrM15lnrhFuIEVlaQnE4t4pwLs8Cu3o8C1TlOMq1oE8Pz/c
         oUexzokZugxZ1MOAjeWLWFjHjv1K0zP2pd41R/Kk+xTZoQLdzK2OMXw0+6liz2Z9rZAB
         c2B13Hs5LlQ5sp0nlU/UQP3btBVxAzO6mvjCqs7vOg1gb65b9pBzHjlC86oE4Ke6fRuD
         pnxq9H5YbCiIJO1vwI/ThqYrja4DVlg1sFwuDkR9pA9IF6bGqJsIPwIB6G84aaJuM5ce
         gd1za8WKO6szik/a6DVg3SgEJ5MvVqJ5svx49g4bBQPSyCdudIx/bAbWKpOyWco9305X
         zrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IImXp5tYgOAPEIfPBSngCYL+EFkP9uPWh6fVcl2H4aw=;
        fh=7LVj7NzDUep7A98dMFtKU3jsserAm6+UYJ/ZON3HZmg=;
        b=mlKBhdSaSv6uz545xlE2C9bPb1Br6K9sKWdAy+pDgumjOB98/u+A/93XH/z1vKpSVL
         ezc/uQkguzfBJPpRKpipPWVcAHDg8+Cses9EXL5mjqjonMMrpZhVlJVSpiyBgprOWk6W
         Gd1FFbSVTsQ10IPmqJFYRQvxqcLXr14yUsoJJYj+jr+600hxq3Urxg6D4ouyUkQpBMW6
         1HkfLo93YTk8+ucB5kFsT6sZCpMmahe5qN3d9hi7GJM/F3qhWbMBzRTTJB3wd7lCXH3U
         41GOBkxm+KUnjVVtAhDB9/kXXu8DXNFjZXWVbHBHtUc+XvMWKDljdCQNv+tBsbOQRnTz
         oRxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785952865; x=1786557665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IImXp5tYgOAPEIfPBSngCYL+EFkP9uPWh6fVcl2H4aw=;
        b=Z/uE1Q/ReFaHEJz5Q8RuNhx6cHsknMv2IS2nxwGCGXEjypXptyoq8+G9Xal680DRrO
         HISJglaYy4oQucEczmMpEulV9J55XsvqFAwb4jI57WpJUcgQoPQAccE9Tivxq9ojVzIs
         udhuxHt5ua9HVYauZD7WX2R+Xw8pRpiwiRBKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952865; x=1786557665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IImXp5tYgOAPEIfPBSngCYL+EFkP9uPWh6fVcl2H4aw=;
        b=hSRh8Wj2hCi7vNmN5eiDUhkZ3re8fvsIFHoh23GW+fjb9ZbEu27ZSUQ4JaCrahMsUc
         +6hQr2+7zbs5I5c40rDvUBB++aY3HW8dx2brVpj3H97aD1lREjaNioRJw7DV8+iXUCCZ
         FrCHMR1kNr1ZS1pj0L+sefRNf2LRXja9e25iDtuAmW50Z0OyqZMFOu+MUVqn5sI1C5t1
         sgJnJ65BRBTZ/KHWMg3PJk/tDO+ezV1FNzbrRlim7kVCDt8QdQapjXPPv9uesx8XDYNQ
         jdpxL/TUgIAnf60+LfiZnQLXp55z8KRoWKvnFlyyWVigNcOeAkmCOISnisvOfhF55v+w
         ayDA==
X-Forwarded-Encrypted: i=1; AHgh+RoFIYtwi7/AZw14xC/5ril3QWCadmw/9ZQCDgLvyB/J+ix8sXN1s53YRK/RHJ6caFkTj5cSmns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkXz4mvx/UjqUJEnGN1FIzrZDDeV4duk/Ko8CbfM6Dfj0v/38
	UYT2ydCelYVpyeWEogM+xF6OLs8gaGPJ1sEKGenA4eqpxzzOWckD9J+/uzlCQhUSTLjCzhRosP2
	Z1xMnC/nv7638Kgu6CZfsGt9VfdoUII8CUYnfaeNc
X-Gm-Gg: AR+sD137XJChtQbQfpDZZkRUAd48COSGYJbQBK/tss7vyDhBjR0wE3qMmgyWhShhXNK
	JNMJmjI+qdB0GKTgF+oljqscrMMkiwqgCNT4ihLsCIWzA/OoRLYLkgLh0Q+KuOm8+wQyYusihNX
	hE1cNwjvLPtBWbUd1Hmc/3YaCwrNdf7kZfiiybwfIJroJLT9NM1J1yN2bfMys1GYkHjveBEENQv
	fBwrXRpGSNyhS6rR/RCBGOy38i/a7hcrMHoT7LhUQzIgOqmNI3lMXPoa2GCgD6Pjis9tYbQMCSl
	JYYNz62w74N2e7xCFRJ2iqmToPDqly2LkiDzjXN7G9MPuw==
X-Received: by 2002:a05:6a00:3495:b0:846:eaac:a5ea with SMTP id
 d2e1a72fcca58-84f41b8eb60mr1190206b3a.3.1785952864535; Wed, 05 Aug 2026
 11:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805102505.740806-1-david.lee@trailofbits.com>
In-Reply-To: <20260805102505.740806-1-david.lee@trailofbits.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Aug 2026 14:00:52 -0400
X-Gm-Features: AUfX_myKNk9_XBlZf_vm2495McZtXe_QlX04n26A2L7YtFAuyTnMkGYBWj2Z1Lk
Message-ID: <CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed creation
To: David Lee <david.lee@trailofbits.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:25=E2=80=AFAM David Lee <david.lee@trailofbits.com=
> wrote:
>
> From: Kyle Zeng <kylebot@openai.com>
>
> A qdisc's init callback can publish state to RCU readers before
> qdisc_create() completes. In particular, clsact_init() binds a populated
> shared ingress block and installs an embedded mini_Qdisc in
> dev->tcx_ingress. If subsequent rate estimator setup fails, the unwind
> removes that pointer but qdisc_free() immediately releases the qdisc and
> its per-CPU statistics. A reader that obtained the miniq before removal
> can then access freed memory.
>
> Add qdisc_free_rcu() and use it for the creation error path, matching
> normal qdisc destruction. This keeps the embedded miniq and the per-CPU
> statistics alive until pre-existing readers complete.
>
> Fixes: 51ab2994c387 ("net: sched: allow ingress and clsact qdiscs to shar=
e filter blocks")
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>

Thanks for finding the issue. But you should know the deal by now,
send the poc - you can send it in private. Same goes for your other
patch.

cheers,
jamal

> ---
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
>
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can share if needed.
>
>  include/net/sch_generic.h | 1 +
>  net/sched/sch_api.c       | 2 +-
>  net/sched/sch_generic.c   | 7 ++++++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 45a1e8c782..d45442c926 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -793,6 +793,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_qu=
eue,
>                           const struct Qdisc_ops *ops,
>                           struct netlink_ext_ack *extack);
>  void qdisc_free(struct Qdisc *qdisc);
> +void qdisc_free_rcu(struct Qdisc *qdisc);
>  struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
>                                 const struct Qdisc_ops *ops, u32 parentid=
,
>                                 struct netlink_ext_ack *extack);
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 668bcd60d1..041bd60072 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1373,7 +1373,7 @@ static struct Qdisc *qdisc_create(struct net_device=
 *dev,
>  err_out3:
>         qdisc_lock_uninit(sch, ops);
>         netdev_put(dev, &sch->dev_tracker);
> -       qdisc_free(sch);
> +       qdisc_free_rcu(sch);
>  err_out2:
>         bpf_module_put(ops, ops->owner);
>  err_out:
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index ef2b4bf515..86d551fbab 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1103,6 +1103,11 @@ static void qdisc_free_cb(struct rcu_head *head)
>         qdisc_free(q);
>  }
>
> +void qdisc_free_rcu(struct Qdisc *qdisc)
> +{
> +       call_rcu(&qdisc->rcu, qdisc_free_cb);
> +}
> +
>  static void __qdisc_destroy(struct Qdisc *qdisc)
>  {
>         const struct Qdisc_ops  *ops =3D qdisc->ops;
> @@ -1127,7 +1132,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>
>         trace_qdisc_destroy(qdisc);
>
> -       call_rcu(&qdisc->rcu, qdisc_free_cb);
> +       qdisc_free_rcu(qdisc);
>  }
>
>  void qdisc_destroy(struct Qdisc *qdisc)
> --
> 2.53.0
