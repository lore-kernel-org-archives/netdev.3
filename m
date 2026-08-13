Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A344606E
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611169; cv=pass; b=oNmrFHEMbi8zctxFZZ2/I0sBjPyJZwGAH+xMchEviathLIX9nM3cJHrV2PRgX/KwV0byvo1VEZTA5Zr6TsPzQ3ciBjpFA4l6K9zBITqlGUtNwZOhYSdPS3/DYSGWPCmqf7koJ10PjUes4xNrJdWPSwVh+WJPV5vjOgxOlAEctnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611169; c=relaxed/simple;
	bh=OuHmCFJxSVJBidCXfFZYNZ0poOvLesgUedmmoEQ/ihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O11N/NlyrQ2f45whvR3GAqYEPkKLfmruuIasVgwzPsQm5Xz4WIB+mHbb6qPEQk4OB6doTb8ABYUIXjZ7eIkVvxSLSzjZYXuO4MYI/B332hX8aGepjwaK5nCkwT+CqUmAW400oNtbAohbeXOI9SuNz0VGyWUcMpHaZp5T0zzTRYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ix45WXuQ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ix45WXuQ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848743155bcso835329b3a.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611167; cv=none;
        d=google.com; s=arc-20260327;
        b=CW21Z1ATYJ40ToBkMbdru9rbqQ/pv4sNt9Zq9ew2YjJR1esn7BYrJGPb2CZYHjLk0J
         at6KSd9mRyzoReWRImmX+0jbBJfLztDkPtrxbuGvv6+pEvzT8UjQAB5m9lmrdHbTvMSA
         ZCdyIwOtrpLMzTp7PK1KzGqcCpP4wjNOZZlEVjIaZgP3AzrkCRhYYLi9jNzwbfrXHwiW
         b7VuLfjHnbzT74+r9YMMAQwC057jKTrpVWjITGbZda7kfWI/jfmGCEfQxH1RWzZFke3r
         3qQrGGUk1S1K5n7LNtwGoEmQygn7SdtarSrZZbF01S686dzqrnuOOE/mf6jCKcWkyuPK
         BO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        fh=q2D//7CfxJJM6RhNyZe2STe35AIgYQAmg+C1pwy1R2Q=;
        b=YBc1gu4uthb/AKlFh6Zol/UpLCTFESu1bFrUKmU+hiUw0VZiFNSXIFh11PlRDp2iYL
         4vVpUWr2VstSllT+w5KxT4xhxCUQsR8qgPmnNd+3Te6rDREYB7WpKtGnGi6KotSBmtG/
         HyTNfUOiLXCWHcHCw9tOFK75oMR4ucM8BsVPRZwJzgwVN6qurVJVru7K8VONoYLd+nFc
         3UN0BhE29T69UwG0EZH0zzrmFmRK4qmGZLuqZcmDhoomDwVla/oltmS1Zom1cql0OtuH
         telWO/Z5NFoq0CZKou5D+0ZhOdsE1/8wiM5BSRX/eq/Umhw6hYB9tky6DVoN3ifdRzs6
         ntMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786611167; x=1787215967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=Ix45WXuQi1B/KzBzQq6pZrj+eyHx1usm9lNuBiLKjFNvbDFoTV4xcj4TbNeo8S2ZTG
         n+lufhzd4Rw7YfYrFHqdPxqBuRp/bWVJUN2IV2gtv1msTmY3ZNOg4MfAkzmAqjFfnlSE
         WqdoltD0oru+cDYDom9AFu8VNuOCeQrPAXUUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611167; x=1787215967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=Krxyb6+0dtQVw3NgTMo1AFJK/zOgYSB/PSqQqBsLpbJMa8JUrfPMTv0eyTygPyusLa
         q8BgBHKauvIvoT2i8ZjXSZcPR9gxxgeXe/HHgo6/Vov9DnLqzG07kFeK1MsURd7ZOgmM
         6S7sV97TkyRRVdNemLaa1QVVmWPs0+elVLO45jE6xlvvv5kQK3DkQehwC/mU6zdy2vC7
         xB6LMLuRD/PRaAWEja+gDjms/5J8yFsxGPmzLUfadPJ3ouxNZj1iOot228l2LrdUvlzz
         8zczB/oU3vaiDVlzVimBIbVmmtW76HR7iS1LmfYxeJgi7zm016IqJki4vNxFonqWk+Wa
         cunw==
X-Gm-Message-State: AOJu0Yw5NcIPTVwsm94EB6aDYETI0M+zF78A9XTVgIxreQAr7c6ia0pD
	RkWBHPBItNVV3Y7jPGzX1IsTd2ZfZpSqYvcv5Oe0vOqjQjq0wkiIoOoNXwpsRrzFIN+phTZBjjO
	807X2dmxSHQC+kuof+bn8STHndmdEfT6LdruhWKKE2TlTecD7FrZTMA==
X-Gm-Gg: AR+sD125Ni9D/xo5Po9kXs4Hn+0y2gCY/AQXzRREDX0Ecae1sV6HmdjkWhZIb9JZwh+
	jF4NejUc/wDGh4OIafLsO5hmKz9x0hT7VBfY0/p/YqAIHWt/TOJhJ/ZS4eieDgHktd0zmFBd3tI
	ssG9JeDxOEgAboVBTaTAhm2pBPQ6/Xz9oC5sBHcHOQI+HntAWbiHT+IwzMJrh69aWrka72MilWz
	uqliRdp/zcHxp9NI51yLvPeH92VYJnUip4cDN4hDZ9Wa6A0Tg/EgRJyVk933KerSDs1MuNzf5go
	AvLjvkgFPpdauqTC4v3V+ZfII3/dwQ9V7q4QIGO68Q==
X-Received: by 2002:a05:6a00:1891:b0:845:c6fc:2821 with SMTP id
 d2e1a72fcca58-84fc6e04476mr4296840b3a.22.1786611166640; Thu, 13 Aug 2026
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com>
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Aug 2026 04:52:35 -0400
X-Gm-Features: AUfX_mzYJSHQ81nk6K5CQtHRiM8w99otSWYBW2UKmO4T55DkFo0ZHPMcwhj5DCs
Message-ID: <CAM0EoMm0xj=R4c+3yoBJyEDgNAmsaCospYT9jxVTTihJzSnvPg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded=
)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
>
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specif=
ic device")

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")

cheers,
jamal

> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_bpf.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 001d8c4ebfed..6d19155becc8 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -374,7 +374,8 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, =
struct cls_bpf_prog *prog)
>  }
>
>  static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog=
 *prog,
> -                                u32 gen_flags, const struct tcf_proto *t=
p)
> +                                u32 gen_flags, const struct tcf_proto *t=
p,
> +                                struct netlink_ext_ack *extack)
>  {
>         struct bpf_prog *fp;
>         char *name =3D NULL;
> @@ -388,6 +389,19 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb,=
 struct cls_bpf_prog *prog,
>         if (IS_ERR(fp))
>                 return PTR_ERR(fp);
>
> +       if (bpf_prog_is_dev_bound(fp->aux)) {
> +               struct tcf_block *block =3D tp->chain->block;
> +               struct net_device *dev;
> +
> +               dev =3D block->q ? qdisc_dev(block->q) : NULL;
> +               if (!dev || !bpf_offload_dev_match(fp, dev)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Program is bound to a different d=
evice");
> +                       bpf_prog_put(fp);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         if (tb[TCA_BPF_NAME]) {
>                 name =3D nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
>                 if (!name) {
> @@ -492,7 +506,7 @@ static int cls_bpf_change(struct net *net, struct sk_=
buff *in_skb,
>         prog->gen_flags =3D gen_flags;
>
>         ret =3D is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
> -               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
> +               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp, extack);
>         if (ret < 0)
>                 goto errout_idr;
>
> --
> 2.34.1
>
