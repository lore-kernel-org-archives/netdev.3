Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD982745E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456438; cv=pass; b=p92Lu7uZhKrTh/+AZrDSJ3HXKcAVAyvajYZgWssqStlBWG1QxwJ9TLKbjbVFh40KKvYSJD5t/9uEJXroOH3kfWlqA51GyI6fnnmWXepg//qz9sr8HNPMsjPiIHBhP+GaFA7eGLP1FoPB+rvdau+AJvV9jDQc197YOSwEdQln0Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456438; c=relaxed/simple;
	bh=IQgcCgUN9ob2aK8ni//osqPFYvEUV2QuifcC8kLAH3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdmAzuXxKsr424sJVuM1wSspz6HwZmP0CM3/0XNneL6evEbxJGYXYTHSHWn73cJMNWT69DEM5F38R8TI+HgA4WwMdlcv3kv1sivmt3dqUCWjg8nYmbfa/NgZCbZrtfd2BR6dOAanXxv4maEU/K9bIEEcgpbkHMb8Ut5oSLNkJE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqmcu73C; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqmcu73C"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso496108b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456436; cv=none;
        d=google.com; s=arc-20260327;
        b=PDvkXqwubEQkhrg86bg9luaM05Os+13HuX+PBKBtR+U1SVtmBEOU/FhcMQgn4rwYkP
         k7EnyV/KRKYx+PIfWIaRGNW8oINviSF7b49Qp1sJbOk8YZ7sFVlMT9MXhvcl589gy+hQ
         ygO3krYmhvHy+Mr8WsfS0L3CXoJIqr8hLdVz7VSqiZZcMIMEltUQ6IIKXx5B8mSFut4V
         IdF8SzuhA5fMAMo7wWztoBQcnsqT2dWbRsdul/91V6LC/Hdj7Ku09IGq76XK8JRyiJqj
         OnmsOyKZJDO94zoAbgATR0xGrwTIkMTQbnKggl3JkyuAg7fb8QospEHi6HEb9ekUC23i
         u1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        fh=StT1e6gVLaJWCz40iqQVS+XAzD/n5PZ/jzM6xf2xujs=;
        b=plDtu15s1BuxEnBWp4qU6IFSdSyhiCGve2A8qizQa3pZYxYjjVJKKcs7vJt52HQlpn
         hplryoxqapZxTdXjQUvwpNdgLbPQ3dHpk4pdZ2BgI3LzckQetBvWVO7+Dqm3bgb4Dpc6
         86wUcupCtH/AG8B26zKQTVHA7rVhEIpfKmJf3Q0JDVoEzI1EY8+dp9oMwsAVX9Ol1ob7
         lVC4iNSodZM2B1iTKup/nqq9ljSqYwHOSRgYp+l4ETXqhbZxVrru6HTcHT3lTflTMLmI
         dPNX/cPAr87jW1TshQ1hEuAqywn4gXN+TdhZP9KzA2JbqJlexEShdnnL8o3bo0DZrdSx
         Rerw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456436; x=1786061236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        b=eqmcu73CpPSiKFhkKn1kG4usgrTsv4Vsy+qAGJPjME0CR3ZnnhO/hgAW21Zl2Hs/rZ
         w+cHqyDxFRmjTz2wQu9fRwECJnWsgtX6atJXYmGhv+n8duBKm2Qis2CKOs2voFx9Oiib
         o/tfN2Ga6oM9m9arEwHorpfpbX4k9DOilBaKbBNPsIhphy/1q+4LPlrfFHUumwbfw55r
         lUyZXDtxjFOPOLuCj3IxSz4n4BvEevUl02KJnz2QwVIWi9XDHkVxTZ/aQLfjje+HfC/b
         2DRVEo7zSdY0MSbsOHbdBvVxPEaIrQjhTNuKBRFjgA2f+UMR8XKdmhkPfiCguGduEM4y
         /W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456436; x=1786061236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        b=NnP4qvVHruSVONnLYf1yrbc3SnMRe4XNpAKvaV4VCDHGB1iSl9fMU0rw3qmj3+mDT6
         iEl+uQ3a7vD4eTmR4zcq1c4Vvx/wt44UPd1DOaplBLV+VQVGOONokGhCZa0umtrQ3d5S
         d2+LPVBXp6a9a81Sg4niNEpWfx1YcxUMZ3/N8w0ogJd2yckxdW+uKY0dDFf8AV3NasMQ
         mioKjO1mE//G/3Q0xHzWVgnfBeEBFoJOlJxgMcc6jebC0DS5Lmqv37zFCcvv8I3wpJDA
         AAnxZ58WT/WYfoDMADW6ZQPg5JC/LDIkSFqKRFuNeVMXl65pPj89uvYZXx18HMzthUQr
         mwQw==
X-Forwarded-Encrypted: i=1; AHgh+RpftDGYKuL9SVbNmc7i1eNAvCF3I6YZJM9y4ROhtyTsiWNCUGdWye3HhBwW0ghpHDIQXAGuyxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmA7rIP1TL2DmJtjiqHrzM1GXPDGzOdBoye899VbpNARkBQaG
	sclK6VoUZ8tTTr/mUV5LksYhxB/Is0tKfxfJcBiypGhJUF9bic0GXNeYJOx9cCvUT85l1C3VkBh
	MiBWHP5DoFFc8iNt6gmQOdMMlEobm680=
X-Gm-Gg: AR+sD10NDNr9O8gpSc7+KLudXYl0sa+oyli34uckBeWBwErI7xKwoJUc98LylAWBM07
	ouavx+Rz3wmg0U5ANrC/gtOcHa7RM3yzJwJfbgonT+cpLWeWad4Yv2zhs7Ah3WIQpmsdg36PGyx
	KRLJl60mLd7GJXoyZlhcQyE0z3pAlOpi7j4UcbrYyYgNQODwvMliw++ZW0IpF5LQ8n65eSs2TaA
	g4chE6fyg+QbefBsgmWaHHMFAu28z11i+vp1S/6zBGPg31VAJLr0BlRf4DFRcxZfn+r1NViPzK4
	EpbLStkBOGjFryaXcZ6zNW8RxnM+ISpi+OmN7ZR+dDGFlLd0DdHnKw9QP4uH9bSe+9vlfClyR9N
	XvpZV00TVDcCu4cGx/MKtGhwxjwFzNtofV6LWVIyJsZ2R5a6M6siz2Q==
X-Received: by 2002:a05:6a00:10d2:b0:842:614e:cc94 with SMTP id
 d2e1a72fcca58-84ebc241216mr4383107b3a.26.1785456436320; Thu, 30 Jul 2026
 17:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725132624.78373-1-leon.hwang@linux.dev>
In-Reply-To: <20260725132624.78373-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 17:07:02 -0700
X-Gm-Features: AUfX_mw0ZEm9k-Ub0vT04vq0qsIVheV8T4aJPOF6Vp_lZfK9C9VKzujLurVt-sw
Message-ID: <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Sechang Lim <rhkrqnwk98@gmail.com>, 
	Varun R Mallya <varunrmallya@gmail.com>, Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 6:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing pro=
g
> is allowed to attach to '__x64_'-alike prefix symbols.
>
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>
> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP

we do have addr, so we should be able to distinguish between attaching
to kernel function vs BPF program, no?

> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> helper. After attaching the XDP prog to lo interface, the kernel BUG
> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>
> [    3.460756] BUG: sleeping function called from invalid context at kern=
el/bpf/trampoline.c:1324
>
> Fix it by disallowing sleepable tracing prog always when its target is
> bpf prog.

what happens when we freplace sleepable BPF program/subprogram with
another sleepable BPF subprogram? And same question for sleepable
fentry/fexit program attaching to sleepable BPF program? Is it
something that just cannot work or we can actually allow that?

>
> Changes:
> v1 -> v2:
> * Drop redundant 'prog->sleepable' check.
> * Collect Acked-by from Viktor, Thanks.
> * v1: https://lore.kernel.org/bpf/20260724141422.10463-1-leon.hwang@linux=
.dev/
>
> Leon Hwang (2):
>   bpf: Fix sleepable check for tracing prog
>   selftests/bpf: Verify rejection of sleepable tracing prog
>
>  kernel/bpf/verifier.c                         |  9 ++-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
>  .../selftests/bpf/progs/fentry_sleepable.c    | 19 +++++++
>  tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
>  4 files changed, 88 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c
>
> --
> 2.55.0
