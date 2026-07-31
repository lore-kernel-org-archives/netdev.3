Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220842E8FB
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511312; cv=pass; b=BruefQg8iCLQaG1il8VqTkKekZBEoj0rtlPFGDIwMFWm2h+QC4NDj0cyLSTLHLOkzZ4dFkucqjjnbZ0TLUe8gX93EzuzeOSdp/ml1RplQ87CkrfH5bUKWhbR51BVlVWjOcdA4iDeffHgsjnQG7q60zhKD2Gm111yZvoQRjiqbg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511312; c=relaxed/simple;
	bh=v+WL3XoOwQikXd2JtezOQGH92bijGZnMB9gOFI0vCIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj8WL62Sw0QuCUILN+GpqNSjRtJ0SIOk6Iz7TMBsE9jDBNEAeTsNHxga/99EiDfnp/05v/8IaOoNTGKCtN9qUWrX4WF6XsWA+H4WGTlbwsW9SW64ztjBKsxSXbifNXtQga0ZH5+ZUqfEel9YT0XfhfV8QAq7w1vAlHmv6LIS+LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQeqDpEH; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQeqDpEH"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1235746b3a.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511305; cv=none;
        d=google.com; s=arc-20260327;
        b=ku/EZIL4KFef/xeAEVmD/CncESsrn8iqu9EPUvJMWCff9YsSvbgomP1hQmkHTDmtCX
         OwvdOh/ShDJ4xAmnl7Oau8fZKzGJEmP85MQK7lr97ulLF4Vae4+W36P62QWiPyncmOQh
         4qYtvidYSwRz3rSTisAoFQ/8eY8+aJCmquKqZgNW4uEYwnvbs/xW8l84Uok6vpcmpbUL
         sp0iO/lweCDx84Bm4CPk9Hru+94pJ1Y9Vxe+quImbX6cpPZ10NfI5LL+ZK8C3TdbtM7Y
         FgLT573daXOnOCCyuE7Bc2fPJPiph0SKlHHBoLhcRoTZ2+/mRzEvh6h3P7RGy65958OD
         LrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        fh=oFeODAPr0SedgqM1eHfoyKnUYleTy4XTUungB3p+1zw=;
        b=IBJct+SM6bk4/KPI9RsqA9L1rFLe/CYV8g+D4LMod4IlbfVm06bjSVTuy+DykpOp5A
         dQR0c1pYVfOTgPPUjUjY27MDRUzjpMEazsidy8daPpsrZ3bLvUYmVasjRwhN++fA1fva
         wviI73vVfLjv4LGBpNcfkAZYpkw1WADLfDq9JlD6ErS/3WcQJKo5NSX/TbhvF3ZFRDf2
         UYRjmtE2C4A0oQLYoLX8zLLe5jsgN44GmtWnXM5fGLbQhdWfyBqdtEGvdQntSTbmnjLR
         3dEtl0vsmYEQQ9UHTVqSNh3+4oy1X1vI2rDa5twv5GxfOcsNhAK1TKySM2rj6EqBurK0
         kCmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511305; x=1786116105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        b=MQeqDpEHId0AWi0fgHZhE1c71pI0bvQX5eTFev+whg/QuqGJdhQX8ac8o/w2I91UTm
         MGkSTswyKgaeoFfVRoSOLX/4EAbb2u0vq/rqvhvbSOzlU1u7hGsyJN8oeQHcIDYxQ/Su
         61hScehPZXmT9xHG0S5L/LePjdMg2ogk3DTyPKzbhI/j+5ZC+tztzfFqdL4Cgbyiu+U7
         MF6soGGw+PeXaMxAji8TpP5tZmiWTMTqT7qc3G33uGv0xX3Bu2LX2V4X1ZJNUvlHUDyl
         vwv9CxogyV2tqUquBhiBZPY0E3Btq+QcLYoeYUFc/kAJC/KKmSNxgq3lCERZw6qAEbD8
         mAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511305; x=1786116105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        b=LF0yUJxqSTFXZDSh940zvlc2QPwOdZtYV7giIxt5HvvmqmGK3aNtI3tIKidgh38dab
         Iod8Sym1OWLdArXNKpAVX99yvaCPZz1bIqTby7LBrffaVH7RJyH0z7BV4x7JcjeDMDl6
         OVa7tU34tL9W/Yo1QxUKA2OWXTv1WBOPx8cEIyAbibdbMVREQIEBuhs8K3EcAtR1hUzW
         +0NZoobuH99keHO+DWmm9XZXhYWmoXPG6ZDsbP7PgwRma1HT0SpnvJ3e9lAPJgglBjvx
         vEa+kXXOwiCKPQIHI/gVT7JOBOgcsTCUnjkD4YkJiqjAYO1dqm4hSrnrQIoqo6dclOjN
         N9Zg==
X-Forwarded-Encrypted: i=1; AHgh+RqD3t4w1TfPMTBJ1w+jQoRhYGJV4HOogNDS7tMLnsNgZmr6Lt1NQkIErf+dpFZTNtyw8h+XK7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/pDlZdCOEF92tDhC9zjQGDI+9cvtVJ7DXPHutAZoz18R1VOT
	pt7xxYTwMxlF852n2HzZ2m8wgXdd1s20unizcCtESQgF6awVEH5VhLnRfyTbSijDChbMUMp3Ak9
	8w5e0kZp/ylWtkxFmhNOuaVoZTmV8zac=
X-Gm-Gg: AR+sD12AiNLRHQ5xV35rp3PoPvYfRIj+wPjABJ6nkGEzOMBcSyNq7nSfLfYLTEysWS2
	5Yh+QHPixQqoH1EwT+ZlieOata1pWE7TiNbRcfhcbDgMjdKNmnLzJsPrLf5fKna0q8HThpX+lvY
	v6x+fRKTQ173Gm0vdOlXpy0zc4WAjOJqYJIZQfiG+hW01f6V9V/PCiPX3Ug9qNaF8PE19Qq/l2k
	YTOhQbyISXrEQ1SOmNnh96tnBLMNvetZAFe5kNYj7L+2DtFBVTFlIhkquUYtuQDvf1i96KA201m
	zscTf7dAyKRHI+Btx06Pi0T9vN5LKsgQiLCjPKNsWvFYEuyBOiCnopjrsjj2L1wEEio28u3ufNq
	csOhkJORWIkIU3Lcbe9Y/cT841g==
X-Received: by 2002:a05:6a00:418d:b0:848:2f77:e2dc with SMTP id
 d2e1a72fcca58-84ee49aa19bmr73028b3a.69.1785511304566; Fri, 31 Jul 2026
 08:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725132624.78373-1-leon.hwang@linux.dev> <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
 <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
In-Reply-To: <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Jul 2026 08:21:32 -0700
X-Gm-Features: AUfX_mwX1Lnn-oFVg3jgqe6P4ofXoWURmDZdlHg78-NJyoQdPMHudZHx9cqdijU
Message-ID: <CAEf4BzbjmW0e6DqFLUAyV+m_usHSkHpux3AdS72bJtsmYQC_LA@mail.gmail.com>
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

On Thu, Jul 30, 2026 at 10:20=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 31/7/26 08:07, Andrii Nakryiko wrote:
> > On Sat, Jul 25, 2026 at 6:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing =
prog
> >> is allowed to attach to '__x64_'-alike prefix symbols.
> >>
> >> It is because the verifier does not verify whether the symbol is a ker=
nel
> >> function or a bpf prog. That said, a sleepable tracing prog is allowed=
 to
> >> attach to a bpf prog target whose name has '__x64_'-alike prefix.
> >>
> >> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> >
> > we do have addr, so we should be able to distinguish between attaching
> > to kernel function vs BPF program, no?
>
>
> Yes, we can distinguish a bpf prog from a kernel function by addr.
>
> I'd prefer passing 'tgt_prog' to btf_id_allow_sleepable() as a simple
> change.
>

I don't think there is a need for new tgt_prog argument, we can just
check that supplied btf is not kernel/module BTF (see btf_is_kernel())

> >
> >> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> >> helper. After attaching the XDP prog to lo interface, the kernel BUG
> >> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
> >>
> >> [    3.460756] BUG: sleeping function called from invalid context at k=
ernel/bpf/trampoline.c:1324
> >>
> >> Fix it by disallowing sleepable tracing prog always when its target is
> >> bpf prog.
> >
> > what happens when we freplace sleepable BPF program/subprogram with
> > another sleepable BPF subprogram? And same question for sleepable
> > fentry/fexit program attaching to sleepable BPF program? Is it
> > something that just cannot work or we can actually allow that?
>
>
> Currently, sleepable freplace/fentry/fexit progs are already disallowed
> from attaching to bpf prog, because btf_id_allow_sleepable() returns
> -EINVAL for them (except for this BUG).
>
> Since no one has proposed relaxing the restriction, I'd like to keep it
> as-is when fixing this BUG.
>
> I'm not sure whether allowing it would introduce any issue.
>
> Thanks,
> Leon
>
> > [...]
>
>
