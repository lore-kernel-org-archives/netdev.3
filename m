Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5840BCD2
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196960; cv=none; b=rDaNmaT/SqbDbZcv7EGpEkhM3P4orX2hM1afA3N5hJGLKJifUr0nFvTEr3AZMHT3b2yMx8j8Rn59jNr4jyddB2NS/VmALDqwO39c/3RO+uKxEkU2sSVg4BBs8nK7ZLNWCcQPTBNueE6noZCZdpu/KHu/hH2M6bGEVxUi3q9LVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196960; c=relaxed/simple;
	bh=T6g7rg3VitWcivV7EeuR9/yu2am9emv7c3wvIiILvEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iNCUimlBlgjv3Ru/v9uD9nKFaOOibE65fDqJ8fYb6oqRb2/DFt5d73ZtTn4v25Ak2zgeVYfNMaqiPX/UYJ/6Vp28f3NFSI1nrS5jHE6fjGRBCgo9HKOM79xcGcxsZkcBLykgktb29gte3FaoppO7piCYcPweBVMpVQUhJwkFsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrUnnujf; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrUnnujf"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5737bb2so77539a34.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781196957; x=1781801757; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh9XW+WhkgIww8VbLUN7r2hGLoFdTbeh596jB8sD3f8=;
        b=RrUnnujfxy00+c8g0X3L+FmekhiBn1M/EKVeBtewSm6yEa7uQvLWyRmLZuD0xfqbYn
         0cDT7LicQCJJa/Zi6im+5xgF8fTQL3qVHl0mHYTmsM772KfVUSkcQi3DAqx4F391xC0Q
         vBX/LhpnlttN8XBXYIsT0OTHg0HWKZLqDz1nzjTOiV9m446+viAhbJx/HOP+DH+lkRy4
         jV1Yx7HOxTvnQMXFMdWIZ4Jn/XjZN7QQm0331U23FqGvTixU7HyaHmMGoHstkSddo6kM
         MfmwEpfL+6ODeWEvBpbjYyBcDFYu0iyTocjeY26znnSj69ZSDEXw3b0T7k1ARVJ4/L9L
         AP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196957; x=1781801757;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh9XW+WhkgIww8VbLUN7r2hGLoFdTbeh596jB8sD3f8=;
        b=FpVevotcDqUTMGZy4yVsKnjM0bmc4js26AEQCut5euguhebPIwrlnO9/XWks0LxwN5
         x+effnso+a7VU0qFIvCa24dAlp4Iqxr2ZQvEqhBdlmW4/fNon4KR3/M5Mbl94cDrUvM5
         weNv3rgsKdAQwwXKyYmJkn2hrS3OrFqT5ngE5nnSxPMZvXCXvhkJUhv7zhoBGy32dU2b
         5BNy/TET9A2Gfhf4bCIMqkTtFwlWdCNXLk/XJkUSpKVG3q2ataSXE8QtSSJCC87GFVuq
         n41XO+6jl8+ivHtDcyIzRE+tePCxfG8C2t5f/7cILd9d4IMOMPPWTeA1bb2dA83qTT7t
         YgUQ==
X-Gm-Message-State: AOJu0YyemLTNWO6/J+CUl0eFrleyIUpiPObseeBJ03StLAFGQnjAu7s/
	t/NhVezN9IQBDk7qOwPcVDKihntSF+iquzYTZO2ekH8PnL8CR1ke6XLH
X-Gm-Gg: Acq92OGqyykBe+YfaIP0XmkzGfPnPLO/f8DcBwzw+6q7MrabYQRqJ+4YLPVLFryopiq
	u0WzWkNBoGSezKz1OtXv+b2kzgavGN7Yy9+KWFw1rDtGlbKns58yDDtrg6vuRoS+HvpiCF47scJ
	rgEKmeBMY64XtVnMwx6/AZkwfgnJm6eedmvVscnQrz1j3k0Ic2eMFmwe+OycpIGbLf0dDfTUq2W
	IFin2XcVdHVo9hbIB6h9bhYi+hGH9+u6Tbz5KTWgfWSkfgVcolyZ5KNqPVW+r689NwwAav1EpqR
	xclDZy0PtQ+rq56cjv1A2ujSL7v+IrJ5zsGg0c2+4mX1AlP0MX1X5YZpdaDltHq1ZDFUtIXH31I
	Gq+tPhiS0dnQhndhD5Rzayxvq2r5MKbbkGtYyXS2fuZxRXXXOLRtG/ztE7kfqT/K4fdPHgOHUr0
	YSXmlCjX/PCevpuKxvonu79JFziPXQMTVm/sKIWWMQ+ksD8xuO2uU3Jq3ZY3Zm1Ph8Q3MKMFLa7
	1C+FX6WDSmYFHvTEQ==
X-Received: by 2002:a05:6830:6885:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7e7735278camr2782858a34.10.1781196956889;
        Thu, 11 Jun 2026 09:55:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e774cee36fsm1748641a34.22.2026.06.11.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 09:55:55 -0700
Message-Id: <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <kpsingh@kernel.org>, <haoluo@google.com>,
 <jolsa@kernel.org>, <menglong8.dong@gmail.com>, <eddyz87@gmail.com>,
 <shung-hsi.yu@suse.com>, <stable@vger.kernel.org>, <mykolal@fb.com>,
 <tamird@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhenzhong Wu" <jt26wzz@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260611160749.391279-1-jt26wzz@gmail.com>
In-Reply-To: <20260611160749.391279-1-jt26wzz@gmail.com>

On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> Add a verifier runtime test for a branch pattern where a helper return
> value and a related scalar stay live across the same control-flow
> sequence. Rust/Aya-generated eBPF can naturally produce this shape when
> a match on a helper status keeps data derived before the helper call
> live across the same branches. Such code commonly uses the helper return
> value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=3D 0
> branch shape.
>
> The test preserves that branch shape but shifts the success value to 1
> before branching. Using r0 =3D=3D 1 / r0 !=3D 1 avoids depending on the
> verifier's not-equal-zero refinement, so the test exercises linked
> scalar precision and pruning behavior directly instead of being masked
> by zero-specific range refinement.
>
> On affected kernels the verifier can explore an impossible path where
> r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
> test return 1. With linked scalar precision tracked per instruction,
> state pruning keeps the real success path, and the test returns 0.
>
> Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/to=
ols/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index 70ae14d60..de71d547f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> @@ -448,6 +448,41 @@ __naked void linked_regs_broken_link_2(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("tc")
> +__description("helper retval linked scalar pruning")
> +__success __retval(0)
> +__naked void helper_retval_linked_scalar_pruning(void)
> +{
> +	asm volatile (
> +	"r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
> +	"r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
> +	"r7 -=3D r5;"
> +	"r2 =3D 0;"
> +	"r3 =3D r10;"
> +	"r3 +=3D -8;"
> +	"r4 =3D 1;"
> +	"call %[bpf_skb_load_bytes];"
> +	"r0 +=3D 1;"
> +	"r6 =3D 1;"
> +	/* success path keeps r7 independent; failure path links r7 to r0. */
> +	"if r0 =3D=3D 1 goto l0_%=3D;"

this exercises linked registers with BPF_ADD_CONST logic.
We already have such tests. Why do we need this one?
How is it different?

pw-bot: cr
