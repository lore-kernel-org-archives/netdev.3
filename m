Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EB3D5226
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400963; cv=pass; b=BJrZIrTQRY2YFgOwL+JhO8lforR96WJhNW8YOBtYGoPvgRpXZHZdFixaJRNurH7x9AFLUtKdm8a/9nfNYKusKFDVj3z7DDSE2xTZSUvCoWEwvjz47QBz2ZxGJG+kjPMRYTgaR+XYUYMnM8vrFM7jjTV7gitK5N8VPSAQXolT+JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400963; c=relaxed/simple;
	bh=HTXX1+Dr9yxVxip38NUqa3CkMR+4Rre5eLPQAlXXUqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhfAEM6TX0RkdVYlmwdSdElmDPysQ+Yxpfyrf15M7p5G5fxolzl4B7ubtzY6RxaD5aKD3sbg4QTA4zvlRSxuYcELNiysqaYAYNO+GksVLPUFRU9dYc1uSG3V+f0QMyGtL7uGuBWCoeFh/X2GtMsD4EgzKUSsdO7A0FcODx97/cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=L1NdNANU; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="L1NdNANU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84eb992a881so403187b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400961; cv=none;
        d=google.com; s=arc-20260327;
        b=glGLvbC2zX/DSjBumMXLiiiRSwE1XYbepYoDjit6y4+0X1/xyMt0pXCY+X5g3oQc/9
         pH0WIb0qB9mFE/aCMAe1+oooSC56piic1TOZ/NouXGGgyDuwe1On8VpKCs6eFmpP3+a4
         bur03GVSnuATOrQ8x+VGyER5bHLaIAYgs3aIW2XnMLmeSHd3innFvE8lSZ6oIetvtTFP
         9TX5Z6DsautaiTPsxXSeAxL+Lx5DqwENG5VrMbyNDx9R4+IsCG0ooB6CXms3a0h6X+ta
         S9Kmov9XieeF2R31X3XP4vvEDiHLIkzIXrVzm3u54wYCQdxaLHUpRhLCNDnfI9aoemP0
         GDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SqANPqT3HFyccDB0zYTxOyPElg7ENSLn9K4m/P9yl2U=;
        fh=68k4wrhjm+X+zarppED4t5u9pQSdHBLx6rSI0vzOyYQ=;
        b=J2PMT+ZvPg/niAYDveRDqObw2XqTFhf90vfEBc/FwWb7As4TJxU9ORO2ffSgRojZfg
         dMn08L6LehDSjuytojB+2qkKex/tUPJGzqqaYOMftZ/b2GlGSf3PluivLrkIFpsNSgZd
         alkhK+7ghNBj2HB3vJWZB7qy32IR8XO2D6DGN/+SSEwMqcq8aWyfvaGKG9GkMAOWqv93
         9A96i6AIeWaQlswfVyKi+EL0n7AW9k7lWbH8o3sTAmBDyXtwUhB33b2xd9S4gwubCToM
         w+fUETqpQVZKZxfPMY3AhyAxzN871U5oPEiLbxalkUQecN/lu5jXzO3VPKzx9k67gRNh
         /Lqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785400961; x=1786005761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SqANPqT3HFyccDB0zYTxOyPElg7ENSLn9K4m/P9yl2U=;
        b=L1NdNANUQ+5Nz08Zcve7hazp53b4xanDMKPDSfUuUpX5UtkUbculUw5N/RVuR9pIWC
         HrDuLi5Zutp0yq2l7yFaVxXxiDwf/HGZzB8IA+qowybviUUpH5gON/5f5aRAgclTqT15
         nhivJjcyUBGvGIPBB6oSL1AMa8o3tHjgRrt88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400961; x=1786005761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqANPqT3HFyccDB0zYTxOyPElg7ENSLn9K4m/P9yl2U=;
        b=I5z8RKkS5BnRtBa4vRd2sQstpccY6oO0l31pUoE4JyKarzb5ButKbs1U7TOOGKqrfO
         zxK/38/isIsLD9I3JJPHioEm7ejj8iqsBYgA29e/mNCPCIHkwO02lyZWvJFkS1F86KUh
         4yTFmglV/KKQXXlKyEHjbFZ4dnEaIlg3TceYQqBk4tX7epxV9vWUUGKvPKL4uxewC7vt
         C5BV6cvBfztglP+gtli2O4TvICEhP1uCOJrn+Jh1laEDQISaOy1ruxjVc5WDf8Tp/WQn
         T9cN0iaP4QKLUA558xnXCfXwrjD45XSxdIZ1CcrxEOD65G0sBqDdryky+T4Gq7+OvSGc
         SmVA==
X-Gm-Message-State: AOJu0Yw1fDJDn5szJ8H8p3707766GARYFU/+74E8bx+dxbqe7AQC7eYu
	1jUdOQ1SktQI1JKb1GsTJkGYOToFK0HuSRX45o+vsnCMyxom1ULS+2ZV1J1EN6mTa750NBpWxhA
	n+aRLdH7VRZSHb0FYxbOuQcEDevb3bwZNUBlsy6f6Nsl16TN9ckUr6w==
X-Gm-Gg: AR+sD11xBJ3QohB5qmfapwGHI2DlN33warTAi6tWUiMGOBsUv8i8Q49G16lr5yIbg6s
	Wfh3XRlExvNIrVtq946HQ6LzGbjbEQEkjAwp6IWKiJibDrL7hZhDfkT/a3+vcshKk3JVmfsOLKe
	2YYc1YrUeLhCAUW647VnsL5GCzj6rSERO7nNPw/ZxC1naZ3S9ThRFidCDtg2WCHVyH0h63D09Bb
	OQ2bOEO0bXdq/ItWsmtivyxYUYg9sGa8KCS/2PVumk1MdNogIlfMmo1N0gf/AT2VLtt5Mcyc1oN
	UR8DJq91zMXcdvMk0zGox3ZUP88CB+MHzOM1ZbHpEkxiig==
X-Received: by 2002:a05:6a00:148f:b0:84d:ff47:fa53 with SMTP id
 d2e1a72fcca58-84ebc1fd19bmr1739609b3a.2.1785400960907; Thu, 30 Jul 2026
 01:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785304107.git.milkory@outlook.com> <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
In-Reply-To: <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Jul 2026 04:42:29 -0400
X-Gm-Features: AUfX_mwqFIEgK3lHZHOHrQBXYT5CJTKv6uZwk_oQyRbM90qSjHrtmnqespFzXQQ
Message-ID: <CAM0EoM=VxHRg-xULQqPLvC5_XveZ0EvvaCH3EmL6vTWnM9+aNw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai, milkory@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:41=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wro=
te:
>
> From: Zijie Huang <milkory@outlook.com>
>
> When creating a new qdisc under an existing classful qdisc, the current
> code does not check the depth of the parent hierarchy before grafting the
> new qdisc. This allows users to grow a qdisc hierarchy one level at a tim=
e
> past the intended depth limit.
>
> Reject the operation before creating the new qdisc when the parent
> hierarchy is already too deep.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zijie Huang <milkory@outlook.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/sched/sch_api.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 668bcd60d183..09d57ad76b89 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1467,6 +1467,24 @@ check_loop_fn(struct Qdisc *q, unsigned long cl, s=
truct qdisc_walker *w)
>         return 0;
>  }
>
> +static int qdisc_parent_depth(struct net_device *dev, struct Qdisc *qdis=
c)
> +{
> +       int depth =3D 1;
> +
> +       while (qdisc->parent !=3D TC_H_ROOT) {
> +               if (qdisc->flags & TCQ_F_NOPARENT)
> +                       break;
> +
> +               qdisc =3D qdisc_lookup(dev, TC_H_MAJ(qdisc->parent));
> +               if (!qdisc)
> +                       break;
> +
> +               depth++;
> +       }
> +
> +       return depth;
> +}
>

1) This check is expensive because it runs for every graft.

>  const struct nla_policy rtm_tca_policy[TCA_MAX + 1] =3D {
>         [TCA_KIND]              =3D { .type =3D NLA_STRING },
>         [TCA_RATE]              =3D { .type =3D NLA_BINARY,
> @@ -1749,6 +1767,12 @@ static int __tc_modify_qdisc(struct sk_buff *skb, =
struct nlmsghdr *n,
>                 return -ENOENT;
>         }
>  create_n_graft2:
> +       if (p && !(p->flags & TCQ_F_MQROOT) &&
> +           qdisc_parent_depth(dev, p) > 7) {
> +               NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
> +               return -E2BIG;
> +       }
> +

Could we introduce an O(1) variant? Store the depth in the qdisc tree
when grafting a new one and then just check here and reject?

Also, if we are going to check here - i think the dump check for loop
is obsolete now?

cheers,
jamal

>         if (clid =3D=3D TC_H_INGRESS) {
>                 if (dev_ingress_queue(dev)) {
>                         q =3D qdisc_create(dev, dev_ingress_queue(dev),
> --
> 2.47.2
