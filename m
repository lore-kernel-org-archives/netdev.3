Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793877990;
	b=PjQOewVZq6Wg7+4W5mPU6S4OdxaK5HuIM9NoFdV+FEVXQbEYHBhtSNvqWOSoYz8ziCfg
	 3SNVIfFcDEpT7gnanBJLd0ZzIs7mDtYO/jcA+zkPG31mwXgS9+ms85TkDl5775a9UvY0m
	 3U7lnHXFRdgSrCXqmm7t40raEu3XEg9DrSUeKyeitlwwq8IhX6zIR8DGAKEEpPy2hFFOa
	 +4y3vW7eXyUa8aoZ3q5JrxQ0M5CbwJyX3MLkNGy6hzCR6aZQPgzafwbgLgGc8E02XQJ8g
	 EvHVL7Kyc8gW9meOGuxTAPhLOqMvn0ml+8RZ0RZTarHW0SDos5+yGkQIRtpNkwknHPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I7fUbd6jySFTYXojRucHrW6MESqyOXFo5+vXKDsjOPk=;
	b=LglVR1nGD7xcWwl4DI7/xiTr90Uc6K7fSWp/yCXsFVSrq1B7Y2wR8zlbZz/IPRSOm/OX
	 HqeflApKYlxEthxkpT4UtKc3xp8csIAobTTmogYp+/XJox6ctPyXZAFDyGs5TTZ9S6oJZ
	 LysI3Xs3tiRnhQbxbikq50SlSmnbcpDhaHjogl7X8jcdeZnQbSbK38fl4QND9VZdP7hEl
	 7G+rbmB2wIahVQQjsCC+BrAMNPfcKUGqbA5wNNKMy1mSPNYdPD5uR8FdpXkoodga9vg3H
	 6QH2SK4lLuy2vD5qb+jPTC35atGmxUO7hfgYxcSiO26QQxbb2jzdmj7wT4hHc/LdKsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LLpgp0D6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBD606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFBD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LLpgp0D6
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06454116eso958014b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877989; cv=none;
        d=google.com; s=arc-20260327;
        b=GUZ/CpoYQ75V1EqJHZ4Qwca+sjIU07or01JnUpO8bIVWQM3mC0+FOYXBSF4e0ejHlC
         y+9O1pFteE6C5VhbMle3MUsYyb1IG+l2/pabBjiOFR2h7Gy9XKb085Ae5Cgus4DhmSMJ
         YcjPecN6ISuURYI6pM8IearEAofXFX08kclzs52ITpCT8wGIViJCN3Kz3/ltgjW+FP0Z
         MOpYBkK9uh0ny/8sZzSOG22vERH+C7CmskJG9DYaUyIVFL7q5cJ2z5cwr+lpG12dh6J0
         fkjXHa47Av9CrR5EWog3bRpzVk54Bvw5d287Jh16XpaMtataAeANyGUWayRSodcgnLZJ
         p3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7fUbd6jySFTYXojRucHrW6MESqyOXFo5+vXKDsjOPk=;
        fh=/jIisGAiWSI5FZn8kG3i5HXTUmaXwJMJDUxnJVVeuO8=;
        b=DasgqpYtq0uN5lANuta2dESvec7yxxwEwRyPmBY9WSyU/ZkFAiyxiq9PPZeGJdPZBZ
         Klpvd49eatGcDEehU+A1C39pwFERG/0lbjkvj5AJMfATo+ZgSZfEyqENUh+eVOxH/YsD
         7dONswQzxeFLG3EtUCMOPHeeXqQul3CQ21VB9GOE4OU84f+aVr5buAEw6n1+/BB3e/Le
         PZcI4nkvrQZAe7xqBtSlj2trAWKgvuNGfLg+rw4ZR/mOTsUjHfXwK4YzIGGpUEIXmrYx
         AQ4asAz/MRX2xpfHYuMX9VJutZMwBMFy6jmvKyh5F3C41MuumvhEI6zX1jy9qkS9ZMjA
         DkcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793877989; x=1794482789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I7fUbd6jySFTYXojRucHrW6MESqyOXFo5+vXKDsjOPk=;
        b=LLpgp0D6DViTChmTItYo7v99Ae+JllWa2NYr32jp1xbgKhFbsAYLmm0THy/yIiltDG
         SiiQXzqT8b0+O/1TWyR9dpXRizOaeYkN+enn27SMswdmwvunsOCIh/Cn6JgC19TeKUB4
         sGGcwQllz+ksxQOyoknsPQD5m0n/YWUTkigYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877989; x=1794482789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7fUbd6jySFTYXojRucHrW6MESqyOXFo5+vXKDsjOPk=;
        b=0cnU1VAyY+7MDymoFgMqg71BNou1LVfZTv9dwCzpXlbYrM/VEjKdfm08JKsqDywh80
         ZPtpA5uJQLNJ/UISP/KbzPNn5DHsYA61UBR2d6ZvxLlcc8yOLzVX8WlESy73U//Oil1N
         Nr4IuxWV+jcjVxNlxPBDwIFAVnhNO+uBVAvoNs9au296eey8yRj0Kqq2u5MnEincjPDW
         PTiG5EPqfd9xVhReewDx9LO4VN1vkLk9Ej30OiP58kmwN0I4cAF9HBukM8FHi1BkIj24
         de5uQ5AMG68QTdwVUfYJNvopgAJlRBgBnCr8wG5HJwuq9134YQnq64DNa0rLca4/5xHd
         B8Uw==
X-Forwarded-Encrypted: i=1; AKwUvBxNWStY6CL977N4aYaz07EchU3FxSRXRvgKidbzUxlUa9ZcNecPeESkciyc+rESEfBDovnToE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OQBnI9rIx9XA0n56azOvLLNHO4B3NoBUHYfih2mGvHK4gs7x4
	UJIhjXlN3FgcmLTJyAlPmntGaJLNjHngnr8lXb7AB29HZcfLErIx6NdFKv1V/SGp2u62CJj7Tms
	BYdUFzuhYCdVVvPkICUTYPtW42ehXVaDzw5ceqVje
X-Gm-Gg: AYBFou2ty51J2fvtjxSdYRoiduJzGwa1KuuFG2blu+Gsi+OdNxGiszaVFS3VabR4Ar8
	inRAs4aEh/FE6u+8g/Eydv+p3nLGe4sXT3z1FZkBgyLoEIPQjeVv4+gJ3ZdTUDcMBusswTiMru4
	dHfirmGEReWrQwIx+7bbQPBKUCfFvUgSTsv+DBb8TgibJH8YaKnp5pYD+zF9xNuThKEOyh42Dvj
	p28oOdQcQS3bZcqx3fNFwuUSX65atnLSYxyQcKECYzQvSOqeuVUXUPmD7/UTYrPP1Y0adPyD/zD
	0KjxVCX6eflUcZf+XvIWsYXvVoYg8N56fcYGHZr1D9svVT+wLFqYLUkN/oXVacm7mW1SVlftpza
	WnB+2ZqRHnvNjvCCmQsUcFLpuUps+Sv+4WFNMvl6MlCeOoADkwi1qmun2BoAP+e9twJDW5FFReH
	2RyWW/ngsXUgajCyOF0gGDZ4Az6ql8VkRpDUz/SAu9hw==
X-Received: by 2002:a05:6a00:b4a:b0:880:3b31:a4bb with SMTP id
 d2e1a72fcca58-8a9bdebaf29mr15523213b3a.20.1793877989598; Thu, 05 Nov 2026
 03:26:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104214607.556269-1-acassen@corp.free.fr> <20261104214607.556269-3-acassen@corp.free.fr>
In-Reply-To: <20261104214607.556269-3-acassen@corp.free.fr>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Nov 2026 06:26:16 -0500
X-Gm-Features: AclHuK_Jqwjt2vvJ3DPakkSmrqyvZxwpCLsiMZ17Z0KwOwtyZ62u0dIDRAJ_h8Q
Message-ID: <CAM0EoMk8-BT92QtAgKQYuKu7_DaCymAV53FU-K2cLhSUcPCZTA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net/sched: act_api: pass the filter
 offload flags to action init
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:46=E2=80=AFPM Alexandre Cassen <acassen@corp.free.=
fr> wrote:
>
> A skip_sw filter gives its skip_sw flag to its actions only after their
> ->init() returns. ->init() then cannot know that the action never runs
> in software unless the user also sets skip_sw on the action. Since
> commit 34d35b4edbbe ("net/sched: act_api: deny mismatched
> skip_sw/skip_hw flags for actions created by classifiers"), this action
> flag also needs the filter one. The Sashiko AI review [1] of the
> tunnel_key dst cache patch reports this limit.
>
> Pass the filter offload flags to ->init() so that an action can skip the
> state only the software path needs, like the tunnel_key dst cache.
> tcf_idr_create() stores them in the new action, which replaces the
> inheritance after ->init(). Since commit 9463e8d8c692 ("net/sched:
> act_api: inherit filter offload flags only on new actions"), this
> inheritance only applies to new actions, so the final action flags do
> not change.
>
> No action reads skip_hw at init and only act_skbedit reads skip_sw.
> Since commit 4a6a676f8c16 ("act_skbedit: skbedit queue mapping for
> receive queue"), it requires skip_sw for a receive queue_mapping. The
> filter flag is now enough for this check.
>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.=
3619697-1-acassen%40corp.free.fr [1]
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> ---
>  net/sched/act_api.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e142d33dc5ef..13317d1abde1 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1531,6 +1531,12 @@ int tcf_action_init(struct net *net, struct tcf_pr=
oto *tp, struct nlattr *nla,
>                 ops[i - 1] =3D a_o;
>         }
>
> +       /* New actions inherit these flags and init can skip software sta=
te */
> +       if (tc_skip_sw(fl_flags))
> +               flags |=3D TCA_ACT_FLAGS_SKIP_SW;
> +       if (tc_skip_hw(fl_flags))
> +               flags |=3D TCA_ACT_FLAGS_SKIP_HW;
> +
>         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
>                 act =3D tcf_action_init_1(net, tp, tb[i], est, ops[i - 1]=
,
>                                         &init_res[i - 1], flags, extack);
> @@ -1549,9 +1555,7 @@ int tcf_action_init(struct net *net, struct tcf_pro=
to *tp, struct nlattr *nla,
>                                 /* Action is created by classifier and is=
 not
>                                  * standalone. Check that the user did no=
t set
>                                  * any action flags different than the
> -                                * classifier flags, and inherit the flag=
s from
> -                                * the classifier for the compatibility c=
ase
> -                                * where no flags were specified at all.
> +                                * classifier flags.
>                                  */
>                                 if ((tc_act_skip_sw(act->tcfa_flags) && !=
skip_sw) ||
>                                     (tc_act_skip_hw(act->tcfa_flags) && !=
skip_hw)) {
> @@ -1560,13 +1564,6 @@ int tcf_action_init(struct net *net, struct tcf_pr=
oto *tp, struct nlattr *nla,
>                                         err =3D -EINVAL;
>                                         goto err;
>                                 }
> -                               /* Other filters share an existing action=
 */
> -                               if (init_res[i - 1] !=3D ACT_P_CREATED)
> -                                       continue;
> -                               if (skip_sw)
> -                                       act->tcfa_flags |=3D TCA_ACT_FLAG=
S_SKIP_SW;
> -                               if (skip_hw)
> -                                       act->tcfa_flags |=3D TCA_ACT_FLAG=
S_SKIP_HW;
>                                 continue;
>                         }
>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

BTW - you will have to resend this because net-next is closed (If i am
not mistaken it opens monday).

Re-looking if you are going to make an update: act_bpf, act_ife and
act_skbmod still hardcode the per-cpu stats; their fast paths use raw
per-cpu derefs so they need the helper conversion first. Sorry
Alexandre ;->

cheers,
jamal
