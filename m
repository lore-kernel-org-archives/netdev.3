Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793290985;
	b=RmODUCLdVMpLJoh3VDjc21RYpSMIHxyCiU45mQjV1Jqj1I4UY8OTltN1fZfhLOcxaWCX
	 1lGdN/j/D/ebg+XXmwzBFfiNqAeM1jyzbDVW4t++vVrTle0o7SKpjAs+wxtQHPPVsrEzu
	 NifUYZ7smtgIC3jLRnG64sEPx1E4xME3OvZ37z23BToU6GerCziyv3EOdLmk+QweVSevc
	 mOjR49L7863h6+Olr/Gjz3fiAkXwYO/xxsipVU37drKE22KZT/nS89H03PzkXiI0EH/S2
	 u/diY4g2UZFOhDf8ojG5Sj658qLOYGiNJoR8HTD52UBZrfN4GC4NcUJRGmdHMDmfM1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
	b=YQFCjzYGMHVIMZQeIeDbRMrzxe1PsVPLxf5CGB78VJIvPLQLl2/4M1dodUUHFP+iclDb
	 ZlJjH7V9cbgM4nsBprfb6UXKnblcT9bb2+G7NvQtfAyDvbGDY7+dbsL80HQNUsrcs3Ic6
	 ETk2mVx3kRaGFc453grRvcngKOMaCXh/DlHRQGn+GFVpyxmZ4h8djj0flCWE/Y5Ub/SOO
	 S+soCwGMxUfFWGZoljpH1GjOmlU9XMJWP0sMgPIRnKy79J4mjF4jOLJXpFfNHBH9RRBUU
	 lQlM7sXsKcDbmAdX7L1+saj/KDztBF5osY3s9FEQdZhYliSBBexJV72EqigTaXn2nTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT;
	arc=fail smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C060A2628
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57C060A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c45551fa84eso288944566b.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793290983; cv=none;
        d=google.com; s=arc-20260327;
        b=mX6RzV92goHqX+PQ2THsQkKeJD3mV5MnKDT08FeJ14JPKQR0bPUBuZ166yRZC5a39d
         8XMPnyl+muvMaGv2NIzP72N52I55eu3LVnLwY30gJKGBiUv1dwtI4SUKxd1Wj269u36z
         ed0NNcIrDzSgF4lM9pP0u2P0AVHVepeAXUFB9ez27sAvMeU6rrn4kwLGjnKYkxJqJAHP
         NF+PrOaomGyF10q+xifoR5P7KVABLL/kPZTsyjcChs9y07R71mEPPV2oVeP1ZQ32WVP+
         CpYVlvr3/dD2/d6vNG5qvEcWA+2jj1sj6saViSBmIAl/hD1FdIqyWbRPubo11jgcu2jz
         PSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        fh=EC+a6Hg2FddWedtBNROX+zxJSO2s+OWKxj9nXnYTqLA=;
        b=cb4oSYqzgvoQ+jgy9cQ3dUmtdmRmvpuI42guXf3qIyGOPN+/S+U74gvE5grwVgb3/p
         dnNkbp+jbPUHBrm0gBkrw+xTaeIE2/B9n6W+9WKNq6qqdhzA6aUFSOISZuP/Vg0Nf9Om
         pZ+KGKpPAhiA20z7Y1wWSH3FhsmQqDeRwrKDekYGeLja1mdabEWwGwrDwWIrPYlGSqiI
         8EMFUBDUUYkalnYU6ENzolVp3FVYz0PVEr9xlJcJKmyMS8kL544R6fLf6H28VUQ2Lmsi
         DsEVleYvRLEBBMzHXbqbwrahaVcSYfn0ldMcH64w2F6/k+GC6fswh/O2oQemZ8etJITF
         f77g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290983; x=1793895783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=vl6h3FxTysc9yet6D3Q0d2GO8gweert+j49hx6iOwi7wFPNTUWfuBL7fsyyfVvnyvZ
         +Z1/kzcfRHuriJXExOiQjIZH32FZIEYk36Du+K2Qp+xNd/zW+Vw7+cZ+3sHCdKppJ5o8
         eatU0GNm4EFgoeUQ+hg+aufwcL0fsR0bxtDwsqwYPSmTHeXFmK4DaWOmC6SqnWgBoZ3w
         PCxuGBUd4CKVgczgjA3vYepQkhpbhYZnVWmJ7nhg0H7W7tE5tOgms8p4YL8rZwXyG2iI
         Zc2yNh+LlvzPXc6XiXnDpdY/AAXfxq39EqGeUq5qFxEMHK/EKYejffUV2/LJ4wO5JK9I
         JZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290983; x=1793895783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=LzUq4tc1+Kc6RHuhWfvXdWfHfUN4bhcv71oZwaSgadWiNouwi2yoq3dtv3GNlJplHc
         OCvx+7xCwrHiD1an2qfSRUvuoYZIZHZCyuTNJWHYvemVo0oH+GD6e0HLJZDhblMzCL4e
         bl3bVyDcAZ1JD7Z8Kfep23ZS3vv8G0Ik/aFdOPG+NYO0AWWak952v3eO7aaK8IBoqt4t
         KaFTZjlbda0Jfxs1vcNIuMHxpPHsSnssmLrhH7NCveUTK1Sqi0drmys/E1h9flg9mI1x
         2kIkFwlwMkm2TzDf0ZGjGJdi/FdOSyarXmIRqsz7WnjXyph/yXqLzJ6ffski3auCjNb+
         6sFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpSoKWLv9CQBEWiUtKLDpNaiZtM+XXQevfqJc9YpCAsSQGIhfLe803c8UyFcs5FYEWbNr2TMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI55ZVVU8fz7NgFKVLZdxbNvEzDGlqce5giejN1H/8FAHlFGOsd
	g+SEMec1/L30Ujm7vZk1S5Yxrr3t3u21hNuD7+ok2NtrH8VblH2auWaEzToPSY4ii885Zk8aS7h
	rHWMhR39UtsH+OSo4wmowf1Y6nij7uTs=
X-Gm-Gg: AYBFou18QiODYLkiLNXvSpDW7ftFXiMpNvekMxxBWe5fkRHSqjRBqyIi6ZeoJl8zphM
	Ceru8CwBoOTUVT99cpgqiyX02sSMlSBC4dLupR4AyWakcyC5L1dbI3bQJHAxsicyYBokv6acC2v
	g4e6GpdGIdPame7y3NHEelymz146dPOfFaxfXqYVMRqx95fv9/xA6vhtmYKBE0cDl+f7GCAecx2
	sC3jvtexSAmGd0HScvv/TxKA8xhwrRsoIUEdfyKTuRz8IHnijzE/q6PqtZbob5vzWZUb8MccjDN
	9MsG3uAG5hKuahXvbzpAc62yVTZSBdxtYudQeit5suNXbTkLExc5JVGBnAtGWsaHIVCrYLcfyzo
	EmtVpFyUzNOCBnZSK0GKdbYlVDW5yMCInePK6vEZcT5NSUIEpzV6mDdHMYcNEYpEwHo4f39YRKs
	ADQsRo/+eGsFzz1f3qSq2LMHkqgvPgK863TVSK3ji+ztE9MEhzyQrbasc=
X-Received: by 2002:a17:907:2d10:b0:c31:91f9:60b7 with SMTP id
 a640c23a62f3a-c49bdf43869mr561025466b.34.1793290982774; Thu, 29 Oct 2026
 09:23:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026154948.99408-1-leon.hwang@linux.dev> <20261026154948.99408-6-leon.hwang@linux.dev>
In-Reply-To: <20261026154948.99408-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 09:22:44 -0700
X-Gm-Features: AclHuK8UvOBWlBbj0vfMh3zLVN3mKm1giM1eECBMPqUpu-79pHcpcFNIaDEnC_I
Message-ID: <CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for bpf_link_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:51=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Since the iter_info and iter_info_len in struct bpf_link_create_opts are
> legacy, reuse the slot of iter_info to place log_opts.
>
> When adding log_opts support for iter link_create in the future, we will
> move the iter_info and iter_info_len to the last union, see below. And,
> keep the backward compatibility meanwhile, that uses iter_info if
> iter_info_len is set.
>
> struct bpf_link_create_opts {
>         /* ... */
>         union {
>                 /* ... */
>                 strut {
>                         struct bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 20 +++++++++++++++++---
>  tools/lib/bpf/bpf.h |  5 ++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index aea534764dfe..38dcb31e8c0e 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_create)=
;
>         __u32 target_btf_id, iter_info_len, relative_id;
> +       union bpf_iter_link_info *iter_info =3D NULL;
> +       struct bpf_log_opts *log_opts =3D NULL;
>         int fd, err, relative_fd;
>         union bpf_attr attr;
>
> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>         iter_info_len =3D OPTS_GET(opts, iter_info_len, 0);
>         target_btf_id =3D OPTS_GET(opts, target_btf_id, 0);
>
> +       if (iter_info_len && attach_type !=3D BPF_TRACE_ITER)
> +               return libbpf_err(-EINVAL);
> +
> +       if (iter_info_len)
> +               iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> +       else
> +               log_opts =3D OPTS_GET(opts, log_opts, (void *)0);
> +
>         /* validate we don't have unexpected combinations of non-zero fie=
lds */
>         if (iter_info_len || target_btf_id) {
>                 if (iter_info_len && target_btf_id)
> @@ -824,7 +834,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>
>         switch (attach_type) {
>         case BPF_TRACE_ITER:
> -               attr.link_create.iter_info =3D ptr_to_u64(OPTS_GET(opts, =
iter_info, (void *)0));
> +               attr.link_create.iter_info =3D ptr_to_u64(iter_info);
>                 attr.link_create.iter_info_len =3D iter_info_len;
>                 break;
>         case BPF_PERF_EVENT:
> @@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         default:
> -               if (!OPTS_ZEROED(opts, flags))
> +               if (!OPTS_ZEROED(opts, iter_info_len))

semantically cleaner would be to use log_opts here instead of
iter_info_len, send in a follow up?

>                         return libbpf_err(-EINVAL);
>                 break;
>         }
>  proceed:
> -       fd =3D sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
> +       fd =3D __sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz, log_opts);
>         if (fd >=3D 0)
>                 return fd;
>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fent=
ry
> @@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
>         if (err !=3D -EINVAL)
>                 return libbpf_err(err);
>
> +       /* bpf_raw_tracepoint_open() does not support log_opts */
> +       if (log_opts)
> +               return libbpf_err(err);
> +
>         /* if user used features not supported by
>          * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
>          */
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65..fe3b7fd8512b 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date l=
inux/bpf.h */
>  struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
> -       union bpf_iter_link_info *iter_info;
> +       union {
> +               union bpf_iter_link_info *iter_info;
> +               struct bpf_log_opts *log_opts;
> +       };
>         __u32 iter_info_len;

in a follow up, let's add comment next to iter_info above and
iter_info_len here that these are deprecated and that iter.info and
iter.info_len should be used instead

applied series to bpf-next, thank you!


>         __u32 target_btf_id;
>         union {
> --
> 2.55.0
>
