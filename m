Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6ED476CD4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251462; cv=none; b=YvHDwS79Uinnh/gpxtApggrln+7UfU/DdCyOQAfLAawzgXUEXLJ5i4KSEVHbdIE4JqFUMUjXex4wHXpTucyJyF/Hi6z8FVpiHgTg3tsr6Ds68WFMaYvJ/qVEyOscOBSr6J3m7zmre1hKpanrySIpkqSqLejrhMHXdeQzRVdjroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251462; c=relaxed/simple;
	bh=6Y/65abMp5Nohg7N8G1qV3p/3sJQdmZOJabLlnpjX9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8Jehj8cbr2etIXzsLzlvJR9AUxDxzVDZZ98fVQsBbm17awdyK8E6R0ZvVGsxoWIGxoTmowsSdcxkn9r2rzXHM1892N/AOXA3+czboYISaTM70LhJ2JIkXPr5nRNAfgUxu+dQFcOZqqmsgIOuaUplVDQfs/e+P83BWPXd8epDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YE4Bqklc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tLVY9wqB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE4Bqklc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tLVY9wqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788251459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGtCK6VOxSgm6lDDeYDwNNguoRKasdMBXEHsdlLzAo=;
	b=YE4BqklcV7d4f9lETyKCCzVoDwTDzbwrNS52StrUC+5hNlPEa+I7Zj8GGMcy3kI7ZyiNPl
	stC30FIrmZpaUMYTxenu3WokX82eHuRs3Vtp7kd2yjTYlqhcug8BWdjYk9go4aC8+gQEgf
	7VQr5WpoQcaB9kO+5kHjCHKrncIbyZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3QX5y1TfNgmdjel13JrzfA-1; Tue, 01 Sept 2026 04:30:56 -0400
X-MC-Unique: 3QX5y1TfNgmdjel13JrzfA-1
X-Mimecast-MFC-AGG-ID: 3QX5y1TfNgmdjel13JrzfA_1788251455
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so4069185e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788251455; x=1788856255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeGtCK6VOxSgm6lDDeYDwNNguoRKasdMBXEHsdlLzAo=;
        b=tLVY9wqBSbkKV2lX27oQbzdtvEsPYT+uv57pH+JWCAHboou/JWCfrWhP66O7oTmnLg
         xxcc0sT5lY/X0FwlAwWXnmPzVAuO7vuBRfRgQNRmGrEKRkYb0K9DxMoXOQ20CgADaZUL
         OjlXCcMQBhQmQqTCPDQrdXLr8hPO7TWKsQvdq4kfjpr/oRjTRP2HiAiHQJ41Ceh2qVGL
         Vfs9ScGzALhRdd7g86v1s2+fc7PUcbUAdDDKUvMf7HAKaIMUFVCet6Lo5XSgi0+AMxMq
         lSJKQ6TQsnuptmYdWDcOgtFS4VaFNqPYiuEa3vj9q2gSK7ppD0qWQG4hQZOpdWLVGeSW
         sLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251455; x=1788856255;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeGtCK6VOxSgm6lDDeYDwNNguoRKasdMBXEHsdlLzAo=;
        b=jtLPM4rjDYQJH/BWxxrc1u0dOuW+lsWFKFRJV3m9ECQGzZsvYPxDvAnfcrBxl7sAWo
         EObXcrJ556LTKizeP9nuYXaBixHym8YMmioiiwfmHTHDoak7sDiujPVXoVzZMB6SiMOi
         C/ck/3UN3bybF1vdLu/i9PUGFfU+CbdrvzhfmZ1Qip6+Hn2tuvlvUNNzcs0IHp7M/LRN
         8jX/7L6p6UXjEOVc9y0K67NZajjhRHCiC4ed/nuCx2UFLZcxUNyBA+ezOA0aFNWu26LX
         4s6UH5sOINuYifr7hW+CHV1IgMnRt2YPkKZrxQyX7A27vfIXZJeWiHwvFC8yez/tnMAg
         Nw/g==
X-Forwarded-Encrypted: i=1; AHgh+RplEGK0q++lTa0lejPoG6fsDAgP07dlQL7NvxIKuYhDY2GmbZlhMNz52uZDRLV6zIEEiZNYhcA=@vger.kernel.org
X-Gm-Message-State: AFuF++m9XqaqgGWKrGUuomlTszTyiktIoMLS/Smzk+Lv368RQyLr0vZT
	SfjJwtG+aTXhGtMKXZXi1kkfY/bChY6n4FRNBSIoysC6eXgNfsPa6Fw66XUgzZW6wYnXbZZlxgs
	mIw+JL3b7fttH6CnXo10kckdgkixjhDzAc1nNvYH/6Yx5YHZLXFaLbFAQ5A==
X-Gm-Gg: AR+sD13fRuc7hNzxXSR3QdWE2Hgx0yktue+WJmBM5S8S28KqPwlHUosH+UdX9+W+Ksp
	DaVGqUcf652p44yThL5HsR2ww+EtuZuQFLRIpesCmktTHOLQZAwev1QWJOQdBERyGas5AcceeTy
	ynKpZqhYMFaeiaeCRmZM25YGgqOgy5DaGiJwcmWU/36GJhiaPrw+DtmIJQLePVdQ+byci54n08J
	8FmdWqrZZy8x03KD4rEr9zOckfXMhSYmA4uYpOGl4YSg0vUIjDJZCuenKmzPcnh26pJlFA8DHpO
	4S0T4od7zCZkxlOYaw/JzKyuC53TLgafQOz79QLV/zIBeoshS8P7Vk4woPo400bgpVYIRlkfGno
	kNsq6r7goQFShqo6AOuhIsYWmIic=
X-Received: by 2002:a05:600c:870c:b0:499:dc34:bdc with SMTP id 5b1f17b1804b1-49b91c1c401mr576242335e9.1.1788251444479;
        Tue, 01 Sep 2026 01:30:44 -0700 (PDT)
X-Received: by 2002:a05:600c:870c:b0:499:dc34:bdc with SMTP id 5b1f17b1804b1-49b91c1c401mr576219485e9.1.1788251433471;
        Tue, 01 Sep 2026 01:30:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce08b8esm46512175e9.3.2026.09.01.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:30:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2FDCA97C514; Tue, 01 Sep 2026 10:30:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Move section-defined program
 flags to prog_flags
In-Reply-To: <9b25ba2abfe778871d07bfa7d08dbf4809a6a865dabf0b88e6818d21f54d9189@mail.kernel.org>
References: <20260831132648.65843-1-toke@redhat.com>
 <9b25ba2abfe778871d07bfa7d08dbf4809a6a865dabf0b88e6818d21f54d9189@mail.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Sep 2026 10:30:31 +0200
Message-ID: <87jyp5v0ew.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

bot+bpf-ci@kernel.org writes:

>> commit 24627f60026bd2b231e09d4373e14ca1975a2d96
>> Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Date:   Mon Aug 31 15:26:41 2026 +0200
>>
>>     libbpf: Move section-defined program flags to prog_flags
>>
>>     The libbpf section definition modifiers for XDP frags support and
>>     sleepable programs stores the flags bits only in the private section
>>     definition cookie from object open to load time. This has the
>>     unfortunate consequence that API consumers cannot see (or manipulate)
>>     the flag between object open and program load.
>>
>>     In particular, libxdp has special handling of frags-enabled programs=
 to
>>     make them compatible with the dispatcher. This doesn't work on XDP
>>     programs that enable frags through the 'xdp.frags' section definition
>>     because the flag is not visible through bpf_program__flags()[0].
>>
>>     Fix this by changing how libbpf loads the program flags from section
>>     definitions: instead of using the private section definition cookie,=
 add
>>     a setup function to the default section definitions that stores the
>>     flags for sleepable and XDP frags programs in the prog_flags field of
>>     struct bpf_program.
>>
>>     Exposing the flags this way means that any use of
>>     bpf_program__set_flags() will override the flags unless the caller t=
akes
>>     care of updating flags in a non-destructive way. This is unavoidable
>>     with the set-only API, and any user setting flags unconditionally is
>>     already broken in the sense that they will also override any other
>>     current and future flags. A subsequent patch fixes up all in-tree us=
ers
>>     of the API.
>
> This looks like a bug fix for SEC(\"xdp.frags\") flag visibility. Should
> this include:
>
>   Fixes: 082c4bfba4f7 ("libbpf: Add SEC name for xdp frags programs")

Sure, why not?

> The commit message states "A subsequent patch fixes up all in-tree users
> of the API." Is this statement accurate?
>
> Looking at the end of the series (645bdf199b3cb), there is one destructive
> bpf_program__set_flags() call site that remains unconverted:
>
>     tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c:38
>         bpf_program__set_flags(prog, testing_prog_flags());

As I replied to the other bot (why are there so many bots?), I missed
this one. Will add and respin.

[...]

> Is keeping the flags across a type change intended? If so, that seems wor=
th
> noting in the changelog. If not, should the type check be kept or should
> bpf_program__set_type() clear the SEC-derived bits?

Sure, will note this in the patch description.

[...]

> Should the in-tree user fix-ups land before (or be folded into) this comm=
it
> to avoid the bisection hazard? The usual kernel ordering is to fix the
> users first so that no intermediate commit regresses.

Sure, why not? Will reorder in the next version.

>> @@ -10099,6 +10106,7 @@ int bpf_program__clone(struct bpf_program *prog,=
 const struct bpf_prog_load_opts
>>  	.prog_type =3D BPF_PROG_TYPE_##ptype,				    \
>>  	.expected_attach_type =3D atype,					    \
>>  	.cookie =3D (long)(flags),					    \
>> +	.prog_setup_fn =3D libbpf_setup_prog_flags,			    \
>>  	.prog_prepare_load_fn =3D libbpf_prepare_load_fn,		    \
>>  	__VA_ARGS__							    \
>>  }
>
> Does bpf_program__clone() lose the SEC()-derived flags whenever the caller
> supplies a non-zero opts->prog_flags?
>
> Before this patch, bpf_program__clone() got the SEC flags back from the
> sec_def callback it invokes:
>
>     if (prog->sec_def && prog->sec_def->prog_prepare_load_fn)
>         err =3D prog->sec_def->prog_prepare_load_fn(prog, &attr,
>                                                    prog->sec_def->cookie);
>
> which used to do opts->prog_flags |=3D BPF_F_SLEEPABLE / |=3D BPF_F_XDP_H=
AS_FRAGS.
> So even when the caller passed its own prog_flags, a SEC("fentry.s/...") =
or
> SEC("xdp.frags") program was still cloned with the right bit set.
>
> After this patch libbpf_prepare_prog_load() no longer touches
> opts->prog_flags, so this line in bpf_program__clone():
>
>     attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
>
> discards prog->prog_flags entirely as soon as the caller sets any flag of
> its own. Cloning a sleepable program with, say, opts.prog_flags =3D
> BPF_F_TEST_STATE_FREQ now loads it without BPF_F_SLEEPABLE, which
> kernel/bpf/verifier.c:20602-20610 rejects for BPF_PROG_TYPE_SYSCALL and f=
or
> sleepable-only LSM/tracing attach points (-EINVAL).
>
> No in-tree caller triggers this today: the only opts-passing caller,
> process_prog() in tools/testing/selftests/bpf/veristat.c:1730-1737, leaves
> opts.prog_flags at 0, and none of the follow-up commits in this series add
> such a caller. Would it be safer to OR the caller's flags into
> prog->prog_flags, or is the all-or-nothing fallback intended to let calle=
rs
> override SEC-derived flags explicitly?

Yes, giving the caller control over the flags is the point of this
patch, so this is expected.

-Toke

