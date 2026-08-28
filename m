Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075A28C840
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876470; cv=pass; b=ELMHbo51r+2r7UhqvbuqkCTfNe/RXFOyfSNAc1gpYLenV0TJ5Whb0P83gB2u6461sfoi+KDa0VGa1A1r+A6KgDcSpPQSkAcVDYf46OBtbAMpfCeRjVVphBoeHhCCUZ17lyS0rAkbiqWHBrPAfkgsvUWSlybeS61TB3pS1PRZGtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876470; c=relaxed/simple;
	bh=bjf5Hsz9QIzLA6lvdSDKXAYUwc5cxHnM5lKA+KBX+WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll4KdIN2hnDNpGrl9has/jR9yW1uRciFsUZPw3XjughL3XAddml1hsCSkgOpPqyxH9hQOz26YrcLsbiQNsIHbk8EStssChLrLEHrJsAd3W9sWSshZr/pEznObZrRrAeQ0KC4FJIn/jTXOdvjmRgEFy3majhE29EphKsrH4u4Ytk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq/z2bXT; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq/z2bXT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so548559a12.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787876468; cv=none;
        d=google.com; s=arc-20260327;
        b=JqteYuTdnEVIEeLwgLZZapVnWdGdPAaPwAOpfAsS01cw3Hvu58zoy7GTMZa3mqQG+g
         kYluJY1ANGRufRcNp7CYdwrEMijN9OL1jFuQ1SSklqUl3XVsyBXBYIUKAOv/wWf4D8cA
         Gi66dQFPzUMQ1blc4DzWI7vuNARFZ7AnLFmDycFQqGsRGHUoMWcNWqDby5FWoE872dtZ
         wYMcvF8ZBsIV0buS7TzkDQiJ1Oykgq+eZRYuyKb/VQCKFqaCNfJbp0CWxgjkyhbuRGQZ
         w7M/mv/fPN6G+WrjFrUVeKA0uv3Up9+YAUiKow7yxyZw7LKZDFltHNDXbXOGG/j6YP/8
         Rfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        fh=cTr8ZEkK0kF/E7jVgQEDiU/3ZkhuQjc4klm1MN4U3us=;
        b=dNC2/hW0Paik7PEBQqB3IZPDhydv4yD9F8lUE7Z3mAluXjcFSQK2gLF0Mgv9FH7Lwo
         XM2X2VMe+wrOvVWaaXRe09eUAfRdaG9yJODPTDRnIWqjju++Tm7z53A7/BBRh6KlW6L4
         iUAzyB7jahZ7ftyYqrLfuTZFXixoUbMx3BVmZQtryd91BW+Nt5VqnbFF40z75IuLRN/t
         a39uNPWLLDvs20+D3pkw03mD0HoPGTFrSs/sEmU/B9F8oEBgEnWp4h/KqkFQRPTFLzMu
         Po9UlgYwG/JMUJyFO1p1uAJuGmjM7N8wH5kTyFR7tRTYst19vFSa9tbO5o/dpgKvV836
         Z+ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787876468; x=1788481268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        b=oq/z2bXTNGFDYjGU5xk33bsrAja1VXKdhrICrNw9fAQcJDmPO+CO6nozUlCmNqFexd
         1rW6vmH8+t4zItFSlhyZ5/1CmSkz5rfAIMoayZh6nJOYk4sf0DwUEyUi8OlALjWt53D2
         fuXv9TI7RSDG46ah2JuuAcf1JldT/8SHplRB0jRR7NNQQfLMvvBFy22X/3H247AaKcvR
         Zm+7v7yVV5xzrrtxXo89sIAS8Ym7nNHjwj2QukVif+nc9KatrvrPm2PqAPWHnSbmmgSQ
         Pxzl2Zf+65o2s4zuFF44kEYOBSpbpDGJjSOwWQYxUFNG4VJN5d766Rr+C0ddLUlLpX5d
         xXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787876468; x=1788481268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/M3iuB7vkG6CWTTtd49jF8rSL19O1YOSXS3GGtvJSA=;
        b=ChYnThfjw+1rHnx77ZScEje6Z43m0etHrh/+TTwAgP5ZgTpcIDrecplolmmrGwzQ+X
         j/d4KdncS2B4bcHFEXJ6zPv8ROKVc5t8SgZ62Do07hbV5nwygg2jMYKazwY6agq1jc/r
         gW4HtYFPoJaK64+gmy+bzfyBX239GXSyQBxzxp3EmnMg0JyTBYW0NvxB7kpfU+/HJlHH
         x+GMzrFjfmkDSAozhVWC0NHlxBReoMz0E8+WtYz2L9f4a7vHklqicGEpqZnK+DAYkNIg
         pSruZFFX1+qhe5T6K7IKu+nyiyN0e7ZB9FAesTfSBzBJopK5EV6EJv4MmAn08jgbtqHX
         uRcA==
X-Forwarded-Encrypted: i=1; AHgh+RrEboQq3wTaTYSmWKPgUatPmmO5cmuEJaoJztoajqw4jmV4PhEOJGr3oxAE5AUPWfpQaMwQ8N0=@vger.kernel.org
X-Gm-Message-State: AFuF++meD4q1CddAK+s8YpnGSzwZzEXzWjaGjYwHGB1Wjb94NYTKIbAr
	Ovxn8N6DZbLxcNzWWAqs/JUleLBCmaLYF6p0nKnQJfUK6PzOnb2uW+vr4TdPdYJdWx+sgmB58MU
	FsEsWVcEZlXgpFCYDUmunOA8chkne5CI=
X-Gm-Gg: AR+sD101p5E8AU83rDgFvDh0KHSBEy7KGPqtgGgSwtXhR5ymIVGcxi6Xtw4xTAaHy2f
	iAoVt3WGK5v763aqhhalWVi+Mqq/0ewsPdwuGGljpT0mdVXFZIDXy/0wf/ZTBeG6M671r3OlfKe
	hc9GinGkE19IyYkhPpklc0yTxtdGGnlg2hfpVsgcYu0PiznULhDCnozaEKMvUoJKcCWXALmYNqQ
	aPjWwaelx8D2zQCr9hElmdCGy22vtjkmbvyX3nhlLlIYSjtZ3TYpHh67/FdRgrpZX9PHZZbayZT
	O0iujrCub+wZGkkV4EsxjGj4w/X9CIuhUIKFS3/drZ3UcRu0mP4T8YX9s9Ph1bOmZd4ouWUef/s
	t/hG0FwjCiTH2pnamOvkpfqRKKw==
X-Received: by 2002:a05:6a20:258a:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3d2686a9058mr4249511637.9.1787876468214; Thu, 27 Aug 2026
 17:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827100214.169215-1-toke@redhat.com> <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
 <87cxv34rsi.fsf@toke.dk>
In-Reply-To: <87cxv34rsi.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:20:55 -0700
X-Gm-Features: AcwNN1UthGpVkmYrvAH5z2HeAW139K55ZeLEO1miPfjporsm5eaIOOJ6W6eK0Ao
Message-ID: <CAEf4BzaupNE1_svo_zjOB+ccfZWUrAm7s5kJDCMOnMKaZ4Odww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	lorenzo@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index b749c01742ee0..7d6f0fe518d99 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >
> > [ ... ]
> >
> >> @@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_prog=
ram *prog, int *btf_obj_fd)
> >>      return 0;
> >>  }
> >>
> >> +static int setup_xdp_frags(struct bpf_program *prog, long cookie)
> >> +{
> >> +    prog->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >> +    return 0;
> >> +}
> >
> > Does storing BPF_F_XDP_HAS_FRAGS in prog->prog_flags here break callers
> > that use bpf_program__set_flags()?
> >
> > bpf_program__set_flags() overwrites rather than OR-ing:
> >
> >     int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
> >     {
> >             ...
> >             prog->prog_flags =3D flags;
> >     }
> >
> > Previously the flag was OR'd into the load-time opts by
> > libbpf_prepare_prog_load(), so it survived any user manipulation of
> > prog_flags between open and load. The new code latches it into
> > prog->prog_flags at open time, so it's lost whenever a caller assigns
> > prog_flags instead of OR-ing.
>
> Making it possible to manipulate the flag after loading is the whole
> point of the patch, so this is expected. As for users like:
>
> > bpf_object_load_prog() passes prog->prog_flags straight to the kernel:
> >
> >     load_attr.prog_flags =3D prog->prog_flags;
> >
> > Two in-tree callers do exactly that on SEC("xdp.frags") programs.
> >
> > bpftool (tools/bpf/bpftool/prog.c), i.e. 'bpftool prog load FILE PIN
> > xdpmeta_dev DEV':
> >
> >     if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
> >             bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> >             bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>
> ...doing a set_flags without preserving the existing flags will lead to
> clobbering, that's what's implied by the API? So any users doing that
> are buggy, I'd argue.
>
> > Keeping the load-time 'opts->prog_flags
> > |=3D BPF_F_XDP_HAS_FRAGS' in addition to the new prog_flags initialisat=
ion,
> > or having bpf_program__set_flags() preserve section-implied bits, would=
 give
> > visibility without breaking existing callers.
>
> Both of these options will still make it impossible to turn off the
> frags bit after loading the object. I guess we could do the "preserve
> section-implied bits" part and add an explicit
> bpf_program__clear_flags() to remove everything. What do others think?
>
> >>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-s=
upported sec_defs */
> >>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >>                                  struct bpf_prog_load_opts *opts, long=
 cookie)
> >>  @@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf_=
program *prog,
> >>      if (def & SEC_SLEEPABLE)
> >>              opts->prog_flags |=3D BPF_F_SLEEPABLE;
> >>
> >> -    if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> >> -            opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >> -
> >
> > Should setup_xdp_frags() keep a program type guard?
>
> No, the setup callback callback is called too early for this to make
> sense. However:
>
> > The trigger requires a deliberate retype, but the guard removal is a
> > behaviour change that the changelog does not mention. If the flag is me=
ant
> > to be XDP-only, should setup_xdp_frags() keep the type test or should
> > bpf_program__set_type() drop the bit when moving away from
> > BPF_PROG_TYPE_XDP?
>
> Clearing the type-specific flags on type change could make sense. I can
> add that in v2 if others agree?

no, let's not.

But instead of making this XDP-specific custom callback, let's have a
generic default libbpf setup callback that will do the same for
BPF_F_SLEEPABLE, seems a fair game (and technically will allow to
dynamically downgrade sleepable to non-sleepable, if there is ever any
good reason to do that)

pw-bot: cr

>
> -Toke
>
