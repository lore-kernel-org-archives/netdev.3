Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EC3BED2D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171753; cv=none; b=bXXJS1KHZsIAxrrp+6j2bXsIIv4bgoeEslaJTywgy6lorSwI4opFSeLsIf1tNFpE6b7mLA9O49QbnsW/oP8tegeEC04H6SPuNZIz9uZ44ISbn9xiaWQezz9RAQgsT/B+UCizmWs96AUqtT6Lu3wnjYCuGY75aEWpkcFcNHeNPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171753; c=relaxed/simple;
	bh=MTB+CB7JOkKT5cyVHEeO1r1WBh2YaAw8im/nYKA6Jro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpXacB8Buud/dmSvN19ed7e2T/wxZ3D0kSpmDcwOl7cDy/F8Ctw//V8bJFl959qaQGMwbFVxGk3sAr2bpb4nhoAS120rEn6VrHNCCcuD/hIvuH2GDJcJ0Hl+E4D5EW2+ssdHlvR7+nzBOoA1coRBwZya1nGshO+UxSOCucvFc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mz7TK864; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOuQexkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz7TK864";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOuQexkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788171750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HR1vgxnw0fPgNUWcYtspZyZyjeyKhK12Y86DuVgq/44=;
	b=Mz7TK864s+4tw6THN6DYufxvfTz65ScB8P0mioG0k5rnhbCkgO0EOCtwDWQNBNNrzLcUvs
	Ok2hKazhLuFJO2XFqfcM6w2DxZ8R9zSDDiTKRHNKDZIfHB6hA006bWrKWPXihsMBnpOW+O
	tKtQZcaJe5HX8Hb28IGYvQTuOanghDk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-bU54W9CnNLOjy_-pAAUDIQ-1; Mon, 31 Aug 2026 06:22:29 -0400
X-MC-Unique: bU54W9CnNLOjy_-pAAUDIQ-1
X-Mimecast-MFC-AGG-ID: bU54W9CnNLOjy_-pAAUDIQ_1788171748
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48437090e74so893673f8f.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788171748; x=1788776548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HR1vgxnw0fPgNUWcYtspZyZyjeyKhK12Y86DuVgq/44=;
        b=MOuQexktJn8spi+7oTlFdaAo2fojX3EGOU4B5bTnugXOjvBcWHwIyUPvs+/Wpjvf/V
         y9azhMlNu1JjCgXlgsCOqV4R0lP8wG3UIr5BHCmCj7SMQB7XzUaYmZGmIwQn4mT3niIp
         sMdntn2lD0lo8eSRREGauM9+L5r/Nm/nIvsptCQ/tDpD8xU0712jo6TtC5AGhiEdF0KP
         RtdsCvsEwKkPmhyPIfvMxb9c+TYfX3JIWifWgFyectnoZ9q8dsWOvhOJxWSl1eyZvZL9
         OfCizOVQgzgkImtccJ26gs2cG+uWfBjAj6PTY7Z1t9BQabKm9ba6HZvIdekgNt0tzuy5
         Mr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788171748; x=1788776548;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HR1vgxnw0fPgNUWcYtspZyZyjeyKhK12Y86DuVgq/44=;
        b=XbhFJdsHhVj3T/FeJ2gmvIggy0rbw1Czqsa0FmW4PZRqwoKes5HAIGjmnhSVJ/JqdN
         ib6aMq2i8vjIsSx5vmdGkEij6ShDa1iPau2UEJzJDhzlDtpZvrNIoOwXn36XqS35ApWp
         lpdagsMqVHcfRAbi8mdUiHAr2qNlWM7qpYS6Yoh3eJ7c55EdjwTv7hi+QQW3k+hCV4KK
         aV7llc3eyzn7lv2Al6KyQM06KCCBLdU+NOFi5VwkbPLSto0KTzeD78d1FpA+boStp1vA
         HYS+7gw9X7OG75jsNfB1XtZGrIOSeLn578IiVPy9YSzYXbpAp4E6SmKfFByCdzf/HYSu
         xvoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRoeq1IZwmNAjDmZsH8qu8WIUe1uyUu019b3zXf96oRRgrXyEm0DYWC4pZTDWgyr1NVBWqPt8=@vger.kernel.org
X-Gm-Message-State: AFuF++l4F1bWq8OKmm1upMLFpoqvIU/cxFOSLATXP1ntheFA643hVHsA
	5QhhnAV9tOQEVKLWkKmUGv9Nz6BW9BfOEn381+r0b44684EQdYsFEmPb0gcL1ibLgaljBkKa6fB
	K7+PIvkBGyhljd267zgmQJwU5HCSW6CmMmecgLbIUOln7+cmq1vjQJlCOiQ==
X-Gm-Gg: AR+sD13J79O/ZdkTcMhzZhtmd58FG/hhlv7OtblWwXhOzhxl149hEU5i+SJKShJSF37
	vjdPLWAkqUoo3l05VCKgUSt/kyvwS4Rb/g3xqwtTtAD0cosDrnDrBuP7JzPEMDEI8PSNleWgB1i
	U4s4GRF+csHi0VNw8zeRvZkK1gIv3ubzvjbsRfH3kYoMudaGuOo/stZ8/MDefT3Dpm/R1EETPjg
	XKSHityJMBrGmkakVOHNB5hTRWYgix0wbBjH3hX59yCVG/Y/o7B02OSffIauXlSLQSZzx/lcGFn
	Umq7YZU1nwGxa+5abqBOD6a5ACiyxYa0+aUzLoOcPySIbcPnju39t+LBOWISfJa/2ENBvG9f2Gu
	ZcSf0whjGomTlEsIPsfes/jcayew=
X-Received: by 2002:a05:600c:1549:b0:49c:d294:41e5 with SMTP id 5b1f17b1804b1-49cd294439fmr148081415e9.8.1788171748406;
        Mon, 31 Aug 2026 03:22:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:49c:d294:41e5 with SMTP id 5b1f17b1804b1-49cd294439fmr148080285e9.8.1788171747900;
        Mon, 31 Aug 2026 03:22:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm374312215e9.1.2026.08.31.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:22:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 541E597C415; Mon, 31 Aug 2026 12:22:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
In-Reply-To: <CAEf4BzaupNE1_svo_zjOB+ccfZWUrAm7s5kJDCMOnMKaZ4Odww@mail.gmail.com>
References: <20260827100214.169215-1-toke@redhat.com>
 <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
 <87cxv34rsi.fsf@toke.dk>
 <CAEf4BzaupNE1_svo_zjOB+ccfZWUrAm7s5kJDCMOnMKaZ4Odww@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 31 Aug 2026 12:22:26 +0200
Message-ID: <874igawpwd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Aug 27, 2026 at 6:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> bot+bpf-ci@kernel.org writes:
>>
>> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> >> index b749c01742ee0..7d6f0fe518d99 100644
>> >> --- a/tools/lib/bpf/libbpf.c
>> >> +++ b/tools/lib/bpf/libbpf.c
>> >
>> > [ ... ]
>> >
>> >> @@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_pro=
gram *prog, int *btf_obj_fd)
>> >>      return 0;
>> >>  }
>> >>
>> >> +static int setup_xdp_frags(struct bpf_program *prog, long cookie)
>> >> +{
>> >> +    prog->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
>> >> +    return 0;
>> >> +}
>> >
>> > Does storing BPF_F_XDP_HAS_FRAGS in prog->prog_flags here break callers
>> > that use bpf_program__set_flags()?
>> >
>> > bpf_program__set_flags() overwrites rather than OR-ing:
>> >
>> >     int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
>> >     {
>> >             ...
>> >             prog->prog_flags =3D flags;
>> >     }
>> >
>> > Previously the flag was OR'd into the load-time opts by
>> > libbpf_prepare_prog_load(), so it survived any user manipulation of
>> > prog_flags between open and load. The new code latches it into
>> > prog->prog_flags at open time, so it's lost whenever a caller assigns
>> > prog_flags instead of OR-ing.
>>
>> Making it possible to manipulate the flag after loading is the whole
>> point of the patch, so this is expected. As for users like:
>>
>> > bpf_object_load_prog() passes prog->prog_flags straight to the kernel:
>> >
>> >     load_attr.prog_flags =3D prog->prog_flags;
>> >
>> > Two in-tree callers do exactly that on SEC("xdp.frags") programs.
>> >
>> > bpftool (tools/bpf/bpftool/prog.c), i.e. 'bpftool prog load FILE PIN
>> > xdpmeta_dev DEV':
>> >
>> >     if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
>> >             bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
>> >             bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>>
>> ...doing a set_flags without preserving the existing flags will lead to
>> clobbering, that's what's implied by the API? So any users doing that
>> are buggy, I'd argue.
>>
>> > Keeping the load-time 'opts->prog_flags
>> > |=3D BPF_F_XDP_HAS_FRAGS' in addition to the new prog_flags initialisa=
tion,
>> > or having bpf_program__set_flags() preserve section-implied bits, woul=
d give
>> > visibility without breaking existing callers.
>>
>> Both of these options will still make it impossible to turn off the
>> frags bit after loading the object. I guess we could do the "preserve
>> section-implied bits" part and add an explicit
>> bpf_program__clear_flags() to remove everything. What do others think?
>>
>> >>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-=
supported sec_defs */
>> >>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
>> >>                                  struct bpf_prog_load_opts *opts, lon=
g cookie)
>> >>  @@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf=
_program *prog,
>> >>      if (def & SEC_SLEEPABLE)
>> >>              opts->prog_flags |=3D BPF_F_SLEEPABLE;
>> >>
>> >> -    if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>> >> -            opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
>> >> -
>> >
>> > Should setup_xdp_frags() keep a program type guard?
>>
>> No, the setup callback callback is called too early for this to make
>> sense. However:
>>
>> > The trigger requires a deliberate retype, but the guard removal is a
>> > behaviour change that the changelog does not mention. If the flag is m=
eant
>> > to be XDP-only, should setup_xdp_frags() keep the type test or should
>> > bpf_program__set_type() drop the bit when moving away from
>> > BPF_PROG_TYPE_XDP?
>>
>> Clearing the type-specific flags on type change could make sense. I can
>> add that in v2 if others agree?
>
> no, let's not.
>
> But instead of making this XDP-specific custom callback, let's have a
> generic default libbpf setup callback that will do the same for
> BPF_F_SLEEPABLE, seems a fair game (and technically will allow to
> dynamically downgrade sleepable to non-sleepable, if there is ever any
> good reason to do that)

Alright, will do. I'll also fix up the destructive use of
bpf_program__set_flags() in the selftests, then :)

-Toke

