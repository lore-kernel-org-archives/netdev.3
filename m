Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792768008;
	b=fpXyIN2l5iwgFH7aVkMMqouXYPH9G59Z/YWfPUxU8qtjZepRdVLCUrrCgO1aUeJT8dLd
	 xe7H8vDvFnXA4rRyl6fXqux2DWLRmIvmXEEsYMi8vVW1HtQaQ1GY3LEy7lAAw7BoGDgFJ
	 2VJWPqedIOICVQbE8nKmkCYpJuthr+k6S7SllbgZwKoNVzvB8jGQwz5b8OaCGyZj+sAYK
	 0qnhTIv7/+tWt2+aGZdV4KeJVlDP17aZU0w7dFcdYXhyA29MR4EXrDC2tcbTjh0f8UrAg
	 EwAf+bF0TM9uBbTvuzF59luA6G6NZIv5e3j0LwECrN+v9RJCh16LCOcPECd4Hr6lITA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
	b=lGLsUU3P7YBg7WOUFDY4Ns26yQ0UEEJQ7Pgm+hL0NslGoRPbP2IgnNom3n8rxRudxsM/
	 m8LNv3mfJxJN3yyOhWQTtN2K7giC8FArqBLeQlIB97cBJHIzO95X6WWPRozL1TsW7QAA2
	 aPrMkPqEPptIB/UIkznIrMF6UWmPdecL/s1l75eJL4QimSDbMZ2pIAUzD2Nrd6ZNKTH6v
	 2cpH5wMEO+J0GrcqTPbwN6XDipPZSdSEDyTTKQZ/XMJz+9h/QmAk/CdhTv0rx6dkFyNW6
	 LR+7AXtq8nMpLZD7YWPo3qWFcsU1CrDZwv1HPUsJAxZwubKXImhUoQz2dfrkt4sFxAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KVJ9FXKu;
	arc=fail smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99A606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F99A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KVJ9FXKu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso9779a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768006; cv=none;
        d=google.com; s=arc-20260327;
        b=Fu+X/cteHJh7qX5PJpkWoYfAYY/tqe63WIyj/mGLMm/8fM088ULrX5gZzBYrtIXbeK
         5dDoVVObIFGajd8Lb4P3+cL1qWgWei9fxw+W6yJfSGvYffjvFLAhREgv8vqFdnyfd2GK
         5q1VVoRX7VYyFFdoc2vlCsgzpiVLud9BMuElBv64At+2MsAQXJ6KcGARrwTeXHJ3li8+
         GDxUi0H+U+4WJIc1Y5G/QWYhJbeyKhMLyKgnixgmtMdgY5bJ0Rk3Fey0RoVq7LhPNiKg
         a6FRH1jxj9fPFHzQbqzKtZgYYs4yIyMcb3AxBILn3X7OaXYPSANNccl1QzGRG3R7UNFE
         Vkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        fh=UP7OQpisZcwOzq6gYU1WAbSFVyfV08gh8XBvdjms7g4=;
        b=JgtnmnP1y4hdawJAK4fCdQUG4DnqqvcYP9BjQaQtRJzb5Uql08B0OUq7jU3i+7wW4L
         g2RmJbA+cFQhJRLIXRRbzrM8FBAhVyfcaT0tRXlWF+fQlRcOi385mBFlqbmsG2DGJNgd
         g8v5h2Qhmja+ds92p+Dgzs80m1y0aAtVudFAXMg9FJwD41ybB97XXmXjxWwZ6qcgyhu9
         jCrBHX9+2wW4YrNXoMZcf73FmiNSAF2wPE19xG//+lsrdKhfb+PbFhQqp7GfMGOGWgJd
         h7EqS1BfpjQzlwtSyK1gIar3LvTOSxH+jKIVHFoERXKuh9MrEfcOYesOobuPPmKDMp7V
         ioLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792768006; x=1793372806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        b=KVJ9FXKuxZw9511/Juyf4W9Ir2Z0uLB4exJreByU2W1txP0+Hq/3sBLO0/iYx2G7nK
         lyl6usjXdqPwD0cI1SmvOg4V1aylyH8Gh+SH8JlzdA/9/ZJZfnE06F3M1g+JlmTR6n4j
         ifn03DAI+dswyUbGsOHxei7RWVQsTJeoTJWvtHj0B57Nm6BkutYTrA5rS/hpTHxlOTVR
         BwRzz0ZKJjB4KnZ2a3ieSu2N60QZsTsTwgRfGKnOAHVttL08H/YlMmOgwo9r1nBjAcan
         XUM8S2YsyHtSYuB8sZ/a2+/N5QlVaB0Hi+kBiJqOIHYjVzMyIfU/ckwtLYk9Nz15a0V1
         l17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768006; x=1793372806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        b=CaqAbKNUPoOY1qi3Rtry6RG6/9AMTBT3Ei0wqCj1hku51iNeh3xUhzKSOjmDVCUiOZ
         fidPp6NFygLDKi3fZefpxufxUmrhIj69ql5lfyJhu7se3GixMlzQggQAma6/irJHBDCK
         8b3Xx6r+GwULps6wfgf4yuXA5fw3jWUJS4/zaO31/pGhKLdsEIVKbDMG/WXv8k8FoSSy
         6mxR5d0V3FIAPLkPyivvJLV8UnM4GeM00d05gjoSYIbIYUkyyShci5lq1YKyPiXvCo0m
         aVcOgdLidkWarPh2yDVQUZGLxlBJHddF4rSJoHc5mT2KDhaMIs6hoEWsbKb5Kfkc3Tqc
         cLcg==
X-Forwarded-Encrypted: i=1; AKwUvBwLECj0h5ytYjlTsltGLMSMNtI44XrbDqvoFu57BxNhJHVXzwb7jYjRfWGNysFo6rHKcrCtyqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdEYu4d4qwA0kXQjHDeJ3zBuS5adlkwM1uiGT3Y+vEMZjb6A1f
	TialvTPKFiwIL8aBVXcwbiZPNteYD58QGcH8lS/dU01S3KeYteor7qwQUl+wepFQbb3xykh2M5R
	/FYKtrcyaGk8Z3OpL8N+FGhwj2YNC/1r15JKxFhy4
X-Gm-Gg: AYBFou2ezn7euI6jfaI5t2lQFaFDcMWi8FR0J2TEVcgAFrRAve1414EHsCC80TlcXZd
	zjfOaCMG+6ttm8va5I2Lw7mDUBJB+1XnZ1IuZjTh2S7K1oIQqFbQ1IRYMy3diexbJoT5pwHuZMC
	bsjBKmxOQMdWrfDGOK+PFLCNbgEwIUmUNYtDpVZl5ghlWmLL3grzpTRZhfASY0IWVuine/IMjRL
	igDvCa7Q2V+R8H5ZbTctJfB1JzL5X8uKGgdcSYdR1+FrueKHa3O4L0476jxTIYAyAmeN64BYDaM
	LKH+klXfXDxWOY0zcPiUh6MPbeVvjlboaJ9VctMTkI8ipNXlwBxtEaczZ17n/cLfpLM6ovDL4Pa
	Xsb6nFX2URWpLH8LMlr7lH9YKaEUoMMyxT9yf0tbIBI1KWlFA84kyPH2ZxjIQNMqt8pSfohK3uF
	9fFPcJ5s+xn8oQj4hpGsYETN8=
X-Received: by 2002:a05:6402:44d8:b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b432d316bdmr68184a12.4.1792768005447; Fri, 23 Oct 2026
 08:06:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com> <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev>
In-Reply-To: <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Oct 2026 11:06:22 -0400
X-Gm-Features: AclHuK-H_9kcDdlRg4oJIo1R46Cqrg9YXsq9lGWJiBUgtLV5WO5v6PEgZsMeA1Y
Message-ID: <CADVnQynhY17Romr6VvzAyq-9h1zQ8gd-+pfC+1qFtz8xRaqCYg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 10:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
>
> On 10/23/26 10:40 PM, Yingjie Wang wrote:
> > tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> > sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> > an upper bound, so it accepts values through 255. Values above 31 make
> > the shift undefined.
> >
> > A process with CAP_NET_ADMIN in the target network namespace can set th=
e
> > per-netns sysctl. With CONFIG_UBSAN_SHIFT=3Dy, setting it to 32 and sen=
ding
> > TCP data over loopback triggers:
> >
> >    UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
> >    shift exponent 32 is too large for 32-bit type 'unsigned int'
> >    Call Trace:
> >     __ubsan_handle_shift_out_of_bounds
> >     tcp_tso_segs
> >     tcp_write_xmit
> >     __tcp_push_pending_frames
> >     tcp_push
> >     tcp_sendmsg_locked
> >
> > Limit the sysctl to 31, the largest valid shift count for a u32, and
> > document the accepted range. Writes of larger values now fail with
> > -EINVAL.
> >
> > On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
> > accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
> > valid boundary values produced no sanitizer diagnostics.
> >
> > Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yingjie Wang <1075151112@qq.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks!
neal
