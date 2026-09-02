Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D92798F8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358792; cv=pass; b=mr2NVkqKEcNsboP011t1l0Q+xx+QpHmVrsGOzJZZSTAoSV5/bXJB3aUz6HgO7DvLzwz5iM3+4aUYVt5Zyl/cllvJ1RI2vN4CsBCiV1IRlIPL8w5O1eZz1llF+P7MaZ6JnoAtMLoiT6WuwXTagqTByCQxaFphElqYE7V0pqKI5Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358792; c=relaxed/simple;
	bh=7WVcDCeNoNJVJ62VGmwppvZiYM7vvnUPgQp7fjZ7D6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLc6/ro8aC/yZOK+LDBX+BoqK40+4qTVYYBNeHXPAZK9vZsqfE+R8qcdOfQHwqUxFU4Uc5Fqe5jNrpN5TOKgTnmOkt3VOWWCFMpiwMEbA/n7+cgnXfkeXI8AEQT223cHk0HFZddt84X0DjsMHwFvCQXxNtkjOcpAYE9VKeEso+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=COeQ1iYH; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="COeQ1iYH"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-85c9a79590aso1323803b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 07:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358791; cv=none;
        d=google.com; s=arc-20260327;
        b=J3tjJ4gAdNDmgO9CEC6K0jU+GXmuCcGY2JLl4qFL7fU94NBG6+LzH420jvxV0fgp88
         nT3m8UmZoGrwI74Qpzjy+gNuFkIWofi/x4GRaOZWiF7Csk7nHiE3AW1NfutiDTcYloKp
         2++he+Y5ZZfJPzZl8Xo4bvZxt0bkkrL4avEmUTYxMROj6LJVuF87XQkCjjTIcgTzSZiU
         exwwBzHV1p0SFipaGpLvzIoNnqj2aBJYl/FGWACqTLc+mhf5SpWzLJdmtprglURbfik8
         Y0uAX5PivkzF4npkm8gsBhiKz0mPnZTvPv/Oz0s1P3ioeyO/AikptNsaw0MS11UPpYL4
         bGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hvqo7YFW1dqU5IF1koaoFEnQPCsWNf4SP2mwIABHbpg=;
        fh=LN3BsfuxMESshIRkztJhsrM0xLUausVzen9ySWhdK54=;
        b=OsT9zgmYB2TXWes5cjiuznvah/ncSeo3DEOlZakKdMB3BmMz6mIS86bp9EkxXgXMoo
         KlpSRMNxB7dmCXXkyh8dYz5hd2fkLX2SYmMo2jgdLaaQEO+ASTiQJNdpqnehttsKm4OX
         u6WdciVD1GgbqHxXKsi19SPqsZBmlwM1WxNe5PRad47bGK1e4Eu7l4qhY5bdQOyMC6Q1
         ZERjeOWeRmRAHzkbhjEa3FhPlVrvOSHpjuTUuGxZrrt6ZCzhbhajtDIcBtVERvPZJ3GX
         3qZLGNNbqnUPNA40vyhZwL1PxLFbbXNybxT4YddL8tZVVQBYLxIfuP+oksMOYzge+Mng
         e7mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788358791; x=1788963591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hvqo7YFW1dqU5IF1koaoFEnQPCsWNf4SP2mwIABHbpg=;
        b=COeQ1iYH8q7opTb4W8XHhS7W9wHBDXm3BIZl6oy7/DiHVZB9dDla9T//zGHeJMEjD2
         CZ/GGpy7Xp5rDd8vcSA9wQoPicOxEOa6rMqN1aCc5yHQceJOJ/pEnYIMXJexDkrmWd/5
         Od9Ql9diFhkysjpD4YZiiHUCJqbM+OT/3ZWvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358791; x=1788963591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hvqo7YFW1dqU5IF1koaoFEnQPCsWNf4SP2mwIABHbpg=;
        b=b2EkKoon1ynTWVorJJW//07bSzF1EkPL1mpNX1fqfwTmAyR8WUp4UjKXQQkuhxUeom
         Euj59Je2m8IjR6PDAYzj7L1ly0XUVsltSbmikoUcrbwk0Vwyj//LjRScJyEyS+no93QL
         fx4TrWaIg6rIdi2it8m625fRg1tXkaDv93Uv21qOSq6RnVJT9vw8X7EmnXN3nDuEtZOy
         OAB0GbkJmhnSlnscseucV/kcDLY47ciQbmDUItPlaSk2o+Zlnz1/vnIx4z/yW4ETe3dP
         KAJ+XPrS+kS4sMi9mG7v2wktJusb354I0iXJS2pPaf79lw4VlN5XPcg8pWNFUs78zVht
         AnGA==
X-Forwarded-Encrypted: i=1; AKwUvByoSGc2Tq2HkzRNrkHRSkmQqNoq+yDvTJITDXhA/ssp7vOS0OnsSr7zbgx1t3FV6112gQUy6rw=@vger.kernel.org
X-Gm-Message-State: AFuF++nuBPPVOEtbVsU+tYiZfF08Yi3jvyn2gl7eSTE+yP3pz4nm3N4S
	H7tfSorO98Ewmjc8ot8q+O8VEKLOVDLg2x1BvK9zA4CTsrRjhAsa2c/l0hkZmtivjQQDHcZ+jTJ
	CNVdhfYCNcstq6CtvPAMrTzubaDzG3VJpiz1mLI6l
X-Gm-Gg: AYBFou0YsE/DFHkkeiOjo/Mv7Y0Q0aETBiZyhjClC3WMTq6M7L0AsgHYsBjQ77qrEpU
	E6cloQ0GWE4Nq8cXNwlZg2dA5/MFMLMN5liDPSRdJ6RkCpjZduQMWepofayEoHJPhmIxCnC6OqV
	S9r6t+6MautJ18EdsoCD2nqVFMdBvEiRtFbMLMwkx2cKQF/5RFOnLXFcyM3aChnq6r1/Lei6KUa
	sUXwLQ2DwWh09DDMpRKh2O8vF18wLoIz+aLApHX0cEkJsNiK8Dk2ZpkLQPx19i3h4JCRQLX7Tt2
	T6IAY9C4jxDU0jtih4HemSPqdYuSNbGaFUxnvgYk5O7K8IX6nUYCexyow6Nq0ax5RLbxfsdxGnh
	ATH6J3+ThgxVXiV0IsDMHTg6FvVb0
X-Received: by 2002:a05:6a00:1d06:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-85ed92cba5fmr8148322b3a.15.1788358790569; Wed, 02 Sep 2026
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902071659.395509-1-ruanjinjie@huawei.com>
In-Reply-To: <20260902071659.395509-1-ruanjinjie@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 10:19:38 -0400
X-Gm-Features: AcwNN1UvCsBsrszWjzjo6WrPU1fBJsPuCIdttqUJvXgZUZvTNhdH0Wjh-Ea6nbY
Message-ID: <CAM0EoMnZMUxc+gq_3xt9jT=Nb8x9NjXXXhp6JRjgOo0Dx530YQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: sched: act_gact: use acquire/release for tcfg_ptype
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:16=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> Replace the smp_wmb()/smp_rmb() barrier pair with
> smp_store_release()/smp_load_acquire() on gact->tcfg_ptype.
> tcf_gact_init() publishes tcfg_ptype via release after writing
> tcfg_pval/tcfg_paction; tcf_gact_act() acquires it before
> dispatching to gact_net_rand()/gact_determ(), ensuring the probability
> parameters are visible.
>
> No functional change intended.
>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Assisted-by: DeepSeek:DeepSeek-V3
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v3:
> - Split out from following patch set as Kuniyuki suggested.
> Link: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huaw=
ei.com/
> ---
>  net/sched/act_gact.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index 565860cccba6..d4f39f98e2cf 100644
> --- a/net/sched/act_gact.c
> +++ b/net/sched/act_gact.c
> @@ -25,7 +25,6 @@ static struct tc_action_ops act_gact_ops;
>  #ifdef CONFIG_GACT_PROB
>  static int gact_net_rand(struct tcf_gact *gact)
>  {
> -       smp_rmb(); /* coupled with smp_wmb() in tcf_gact_init() */
>         if (get_random_u32_below(gact->tcfg_pval))
>                 return gact->tcf_action;
>         return gact->tcfg_paction;
> @@ -35,7 +34,6 @@ static int gact_determ(struct tcf_gact *gact)
>  {
>         u32 pack =3D atomic_inc_return(&gact->packets);
>
> -       smp_rmb(); /* coupled with smp_wmb() in tcf_gact_init() */
>         if (pack % gact->tcfg_pval)
>                 return gact->tcf_action;
>         return gact->tcfg_paction;
> @@ -133,11 +131,8 @@ static int tcf_gact_init(struct net *net, struct nla=
ttr *nla,
>         if (p_parm) {
>                 gact->tcfg_paction =3D p_parm->paction;
>                 gact->tcfg_pval    =3D max_t(u16, 1, p_parm->pval);
> -               /* Make sure tcfg_pval is written before tcfg_ptype
> -                * coupled with smp_rmb() in gact_net_rand() & gact_deter=
m()
> -                */
> -               smp_wmb();
> -               gact->tcfg_ptype   =3D p_parm->ptype;
> +               /* Pairs with smp_load_acquire() in tcf_gact_act(). */
> +               smp_store_release(&gact->tcfg_ptype, p_parm->ptype);
>         }
>  #endif
>         spin_unlock_bh(&gact->tcf_lock);
> @@ -160,7 +155,8 @@ TC_INDIRECT_SCOPE int tcf_gact_act(struct sk_buff *sk=
b,
>
>  #ifdef CONFIG_GACT_PROB
>         {
> -       u32 ptype =3D READ_ONCE(gact->tcfg_ptype);
> +       /* Pairs with smp_store_release() in tcf_gact_init() */
> +       u32 ptype =3D smp_load_acquire(&gact->tcfg_ptype);
>
>         if (ptype)
>                 action =3D gact_rand[ptype](gact);
> --
> 2.34.1
>
