Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886682165EA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394951; cv=pass; b=KoUfMc8hgZcNUlhJgnBAL8OcNiyeapt0YY8mdJCtHNoooX8AT/ThS/LZWW0sLw07NoQwRnxcgcls9UpmVbEBgum+3mb99/7PQxUb3b5gBg6LVATCuRe8DiCHNfXyA3ZXzsGfnzHCT5B9JemJH/vRs1i3IhKCXja8hQuuF13SUaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394951; c=relaxed/simple;
	bh=HpXZGHKjm19GrKGeBKOpw8KiMZWEY3w+BaVtBt5+knU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLkYNXJyVPTx2qrE8ysNpy5hqbaPNpc9Gwu/NXUxU3lUyLJIDgiOA86PZmMRRmp9i6jUrd1/DC5z5EnASGS7A3E6X9mP6Uh0vO1kcilBI9KavCEUKfT6Iz4Agnw32WUNCzMBr3FBCBd4p1s7X6xoNwW30f/y437igPfEcyab7Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgqT9Ja4; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgqT9Ja4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so1562380b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 17:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394949; cv=none;
        d=google.com; s=arc-20260327;
        b=iHo7ihL9x9qDujmCv2I8B9ZKzI5NBw1lFrZRqnhgxAD+Pny0kqTk/ZraAtBRQdJzH1
         wJ8H3y3I+e5mdf+7TEEDzgQVu/eDTnzvcIgJMKb0s0keumaA+EkXeLyYOb76cRXp4Z5F
         1+uW59AJzH1u5fWfNqRIHScJBA4G/4oRE9qPLdiarSnTCBANRdGrR3ls6a8I0FPvkPQD
         vYtcbN8e9SlDqmUEwSEg822ehaR2+5oeEFtVLpq9fqf/lK3Wp/Xkadz2v9WkjVx/0Fhl
         Ec91DxycZstIHTBpgdM9qCfMyfXWam3yt6KWnfIM2G2UJHlGugCqbbJUuGabdPz+z9Oi
         V4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        fh=dJXIwG2zgWXiS4Rn5ArX6/uzNpiTJZmC0j+RFhYWGp8=;
        b=k1cVDS3QJKDTYrKXvIUObrv60MREVqDF0oWTnx1vuioj4UL1npLqc0eb4hMaWuvfDS
         F/Y7A+Gg4uV5JNTWsHKtGpvXdAgqvsm2RZIEzKbbi/xbrI9suADeVz9ApIuZGXt2huW/
         0w3tgq0sXoJ0GOyUlM9sdIPzBPt3kf86dVyX3CMrmVTLhRNorTYFBqgsmxf0skdSQufQ
         WysdovoDM7rAMEWEi5HMyOKwXo6yXsYOSSYEyB6fmrQBBW8p+mcajG9KKr/iQJBllW2z
         xVRfDRo1WqupbCzSgBeiB3wAWoH3/WHXP8E5ygaebvfBS2ou3TkK86nGwQ5OiA6FgHi2
         t3TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394949; x=1788999749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        b=UgqT9Ja4QslI+H0nJlHEo3L3FrVIzKP97lfiwc5Vg0pwxI9O4TCkmABM1cxsyUTh/o
         bsHQmDLCVZdQ8hb+ZhE2Fixtnl5+IrZoq/014hSzMWuCmOQeOBYZkXJbILvq0ubclxhG
         tcNG0uCx2u6KAkzPpHt4VoQfwrrovB2wzCzfCb/23UMdHd5oA5FuDI5YSxSGtnuuJIOL
         VdfGmmuEzsDpz3KpcsR8HHBl7X4iy5EzSsCt01zBzxbCB4Jn8weZ2LFDF8jwbqIunFJb
         ueN6xmAtGh/OG0PxUj93Fx72/f/fvMSzmcL3AwC+bmeKoFDdzy6og0hwfcLL1vaOYit8
         lBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394949; x=1788999749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        b=C6aAnTtUMs6VZoZTKNq8wrAapt8Z0OnHE9bwvQbQMsslQBobOOTCinuYrGU+0ZNIDi
         +2iBS9uKLJzd9nKUAuhPopNiI3GIgPr/j3ybmukzXWmxcWGOGUj2QpMh5LyRXRnTcYGa
         xaRSqax6lPqUITjQCR/II8I7KlHC8sEddCdvB4yfhdr40p15hdUD00+mxyi63sHbjczx
         KdyC8nDbGV66OaaW1shMF5G4RKgg+WbY468pstx2D8UhEMCKgwHwn5Cu6ZnrSuFTya4y
         FCH/9hW/Yrkb/9Qk15Q++k2Dm2+on09B0MZBLXsoYrz8zOt2DDaR+8ABUhl25Gy2wLLx
         dQOg==
X-Forwarded-Encrypted: i=1; AKwUvBwrYmj+zuO+i9XnS27ErCXig0HlBcE2iDScbLSmHeJ8+jKYMad19QFVco49adTtw0SbunB87mg=@vger.kernel.org
X-Gm-Message-State: AFuF++mQoXCMP6sqZ8c5A8GSdi/wD8nMoSJmNzOgZRePUjnnkMuFiI3S
	EMVECt/Hg2hFmFYvVFomcMP8c55LtnMVqIKZFxUKs49C4jvPcl+P6omG1MliWJl6rUas2trjKVC
	aZlrnpH37W5RYbSDsgJCoZgdBu+MHSo0=
X-Gm-Gg: AYBFou1DQSFm9u5HLNqLlrobAzmL+mV6PMz/OuBCdAYa39JTtlGNL+fPGpDFaRFLN/I
	p2lErqcnUnOMFSvc+epemPhYtnVJJWcvtZVpztZCG5Lr5Nirw6Dvk/gtdcT3QzSglYvZMpp91Dr
	MVjdz0QnKAMjDKElCjACFgKkxLWRUtJH2HnMaWOcTpz40nNVK+1c6NjC4VB24hh5x19JQ46e5/Q
	mtkuqg7YTQ9yxmW5elZkp/OMe0Z67BCeA/ggIMFqWdlrOzcVwtJ8qxwOTDmCmuVtCpulJAPWWli
	jAbE0yyaPFY+nnb1bF4jN+b80A80Qc07bjcpKpUYbjDkx5l1Nwdw3UenI+1ZqB3rCeqmBExtbMB
	tE5H5mWFXJDCh8TPLkBUVmXS8acyLUbB7J4P1
X-Received: by 2002:a05:6a00:997:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-85ed25e06efmr11217290b3a.7.1788394948796; Wed, 02 Sep 2026
 17:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com> <140ef9fa6dc454d62eaf49b168850890f1617fba462dcc37288747f6fbc7dae8@mail.kernel.org>
In-Reply-To: <140ef9fa6dc454d62eaf49b168850890f1617fba462dcc37288747f6fbc7dae8@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:22:15 -0700
X-Gm-Features: AcwNN1VQ1YMtD0MgL0myLt2ygnmk6dG-xiKZpsmTHuTFu9Rx8blS2RsSJlnGUVk
Message-ID: <CAEf4Bzbvy=igxp9ihNrc9WHs8gXeY4nvfxc+Dt=0Oijmy+gyXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Move section-defined program
 flags to prog_flags
To: bot+bpf-ci@kernel.org, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: toke@redhat.com, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, larysa.zaremba@intel.com, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index f09cbfd8e729d..c036e8a91ed88 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_progr=
am *prog, int *btf_obj_fd)
> >       return 0;
> >  }
> >
> > +static int libbpf_setup_prog_flags(struct bpf_program *prog, long cook=
ie)
> > +{
> > +     enum sec_def_flags def =3D cookie;
> > +
> > +     if (def & SEC_SLEEPABLE)
> > +             prog->prog_flags |=3D BPF_F_SLEEPABLE;
> > +
> > +     if (def & SEC_XDP_FRAGS)
> > +             prog->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > +
> > +     return 0;
> > +}
> > +
> >  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-su=
pported sec_defs */
> >  static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >                                   struct bpf_prog_load_opts *opts, long=
 cookie)
> > @@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_p=
rogram *prog,
> >       if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEA=
T_EXP_ATTACH_TYPE))
> >               opts->expected_attach_type =3D 0;
> >
> > -     if (def & SEC_SLEEPABLE)
> > -             opts->prog_flags |=3D BPF_F_SLEEPABLE;
> > -
> > -     if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> > -             opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > -
>
> Does this change break bpf_program__clone() when the caller passes
> non-zero opts.prog_flags?
>
> Before this patch, libbpf_prepare_prog_load() OR'd in the section flags
> after the caller's override:
>
>     /* in bpf_program__clone() */
>     attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags=
;
>     ...
>     prog->sec_def->prog_prepare_load_fn(prog, &attr, ...);
>
>     /* in libbpf_prepare_prog_load() */
>     if (def & SEC_SLEEPABLE)
>         opts->prog_flags |=3D BPF_F_SLEEPABLE;
>
> So a caller doing:
>
>     LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags =3D BPF_F_TEST_STAT=
E_FREQ);
>     fd =3D bpf_program__clone(prog, &opts);
>
> would get TEST_STATE_FREQ | SLEEPABLE for a program in SEC("fentry.s/..."=
).
>
> After this patch, the flags live only in prog->prog_flags, and the `?:`
> in bpf_program__clone() discards prog->prog_flags entirely when the
> caller passes non-zero opts.prog_flags:
>
>     attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags=
;
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                       returns TEST_STATE_FREQ, prog->prog_flags is ignore=
d
>
> So the same caller now gets only TEST_STATE_FREQ without SLEEPABLE. For
> sleepable-only helpers like bpf_copy_from_user, this produces a verifier
> rejection. For BPF_PROG_TYPE_SYSCALL, which requires prog->sleepable,
> it fails at load. For xdp.frags programs, BPF_F_XDP_HAS_FRAGS is lost.
>
> Looking at the pattern immediately below in the same function:
>
>     if (attr.token_fd)
>         attr.prog_flags |=3D BPF_F_TOKEN_FD;
>
> should the section flags be OR'd in unconditionally, or should the

no, I don't think so. In the given example, I think BPF_F_SLEEPABLE
flag should be provided by the caller explicitly.

Mykyta, can you please check if veristat would need some adjustments
due to these changes? Thanks!

> caller-override `?:` be removed for prog_flags? The commit message
> mentions bpf_program__set_flags() and bpf_program__set_type() as
> affected APIs but doesn't mention bpf_program__clone().
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/334899=
85893
