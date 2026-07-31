Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA535B62F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476387; cv=pass; b=SBXSeBW1iuZ49J3VBACnzi/rIJO6tkyTmc1cC0m1NBZyh3dtdr1sl4ax9CGm5f9EBkUVjKOmdgpY94jg3Jpd8X9/wCxVJ2o8kwej78/p8353+AyOJg3k9daXiPeQINaySKA+pUPmQnKtLTIro7MC+J94PntljX8IgZscmFrL6Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476387; c=relaxed/simple;
	bh=YV6LY5U5Uupo/A5L4Qsrdwx+wBINDhZH9IMMf93Yq04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAn2cH7yuAXS61D9+39Vbhy6s1cefzH+t/gMUICMkz/cg+pFrXL+L6OLlROluPBDsJhSQIU9qqXRdXnPD2pFAmecRjmlCacX6PTb9Tp5Qw7zYKLIAuKEEBoEt1j6CZolraZntn8XJ71ZCoi2+tBMsMaRQWbhF5xQ6645SYxsAlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiyAxg26; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiyAxg26"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1047362a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476384; cv=none;
        d=google.com; s=arc-20260327;
        b=ioCraBFlZ7v5eoglolQwXbp7SwYuPVoNjJ3kc/yvxL0V25bK1qc0lrVaTDmGj5T0oZ
         osiLTWLFVlG9SQO5zfSydD+feWxK3NagYyL5Pp+bJkeBO19UBuUI5Skv56v0X9SZGDLk
         U+UPXid9jn2zZJqIFhcRlsw5DZSdNYfwXLzihb+/5MKq5bqHPbl2/iSJbxBDigRJ+MDm
         kX6vAXt99I27Bo/SWxhSEZAvXGKRQR2suLz6DR6dx90tu6qcGZdg0Em5BeEnTgFQ43kT
         jtEP3KIP1Gd7IEAghXi1+CO1+2hHWSEf3QtEN6hnwLcJSgU8853CU03RvgzZzIauWLmh
         tFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        fh=8EEaI46cyYqNy0VdHymwb+FcN3/x5mmV5MTzGXTudyo=;
        b=lWWlzaJYYUHR9CluHvMyzaNOKBsDLowdBiM7LAq4PUzoAhmSIPrwLCfQLH95543iIT
         8B9A7SJVN34kt1JKdzNkFyQbTm958y5ievPEqTxeXkt6KdfnZlUrjZ6er/Bk02tox1fg
         orxYoq5F1JMhCXtqG53sgtUC1kn9gUfckwnjFP8oPia30JvaEYMzX0AZ1ZZTepDXhKJt
         C4WJPqDtC9keCkifGnRsBUmuiWKoh3tj1Qp+Sf4fIMsIH60fxeKLOtoaxrdsANTOr/JD
         dgHU2gs7rqpq7q58PQNj3QOMuk0amnfwkYzGnKZgUcASZoSunncg2hDnf+leYypW8T8D
         Fh4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785476384; x=1786081184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        b=AiyAxg26dmVYY0x/c8RfMvsUDsgpBG/uk0ymiNw7JdZmSEYMjQ13wj/tfnew7+0b79
         6ueOai3jMgzzw8WKNpciuNRwUW9RqPKm/cA73riOngMFnghcxMLNDwvAhzvbZ+oX4OhG
         al0SU0LznsJrx0YYrwUfVZk4ROfVQnM7AWMC07k2KEkq03HCBhbIXFdluqHvdtuPqhoW
         f7wuEOzwUZYIkzRJ4MMkfRmj5U//YHbILaq/GhAOD3AucTMkY5bS8TMXc4IcRUVUntjP
         ca2luj1rDj5vNNF+Y8kGCoys/CKCi3bIAALwoCi1CBqHAEFrRD366u6nknJv0Xf1R5/X
         A2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476384; x=1786081184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        b=dr2kjngXNeVkXV4CCUR+wL/VH3c9J3cMnPjLoah+PE4rkbR3ggczbZWe4bg1kg5ZgY
         4fY8kmTzLP4s85WPCMTbT1UeIlS/XX3yWFQofL3fNZeE/FhCc3MCkowGiclY8d/EG4gr
         tjHFWAcor/fHq5dz8VOMaTbEjmRL1ctjNHbVGwk4aOzJEo5IPF0977NeU1yzPGxGUvDG
         VpesqV8S5RXCmKi/fSD4kCt4I2YqL/YUEyFmhFTiR8HiEmTqsTv3CJgP0k8Ba/8oZXSz
         Z4k5BVRWCqCeJMsEVP2mZ0ChC4t3odW72L5hmnXyZ7uLjbhQFJirxULVu4LpXLl74OME
         oONw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8HUAkvgAUoFIHpzd0UN3JwuGuRKu3FbsVnigUilYZjst+vaq3Gw0JASWFYnIyN3XVY175MI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzyqB5Vf0C/7y7c+SRius5m44szxyqw+lHRO6n+NMvEoxAEl5
	7eH0VflV/wWRxCRXUJ/Rso6mczTT5hSNEIo2gEQ30SbI2xIOUvrwsHzNyF1FPu7ePWA+ErBvtej
	ZQAb7u42PRXu2JBf5LTOgNpu4QwUoVb9l9udqGOat
X-Gm-Gg: AR+sD10E9072xZItN4+9wyttQiT6eHuHv4jxW6gyKHRoo1FusaCqhbQte35wguHOxLD
	aQTxheb7K01SvVaLDXbO/emSoePgMSJjGnMRNI+QQxb4tmSDRQof6NMkinTNcSr1W9HdYxKTmy2
	M/tt4Bzw12YzBnunaSQGl29rYvBg9Ou/tGCJQPOBamb3IcWBJAm4+3y0p5+IaaJJcvNiYORcZ9o
	HTG7gOCoV3Ov6cEgchmx998xj6E2QlEtyvFcY4myBp8WhGQGUoVYFJfzHB0S3wE4SEJbCnxf4mr
	pZ2owR+MWWdFn+Hot7gDd3R/HDP2VKjLnjEhL35l5Uo9y6JknVuXie6X1NmPI0Cvko+kcvgnIn1
	tcS2s3KdLrIteeJYDx1rFBq2+Ic/TvFS0LseGFedbv9qxHbl29yI6E4qt7zL3o3mliOFZakw9yk
	iKPrfRmqRvH7Fuuw==
X-Received: by 2002:a05:6a20:da14:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c91a986ba0mr689991637.29.1785476383794; Thu, 30 Jul 2026
 22:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
In-Reply-To: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Jul 2026 07:39:32 +0200
X-Gm-Features: AUfX_mxoiNAZ2_4GQT37uXq_pM18fA3M8ZQOQQVR0wahW-fHgJsC7RX5hVgtgCg
Message-ID: <CAAVpQUAoxyhmfbfCGeMUyQK7F4RifMsFDM0XyDqO9SOMZmASvA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 12:33=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain, drops the bucket lock, and only afterwards sets
> rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() handle this with
> refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses plain
> sock_hold() while holding the bucket lock, on the assumption that the
> lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>   CPU 0                                CPU 1
>   -----                                -----
>   tcp_conn_request()
>    reqsk_queue_hash_req()
>     inet_ehash_insert(req)
>      spin_lock(bucket)
>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>      spin_unlock(bucket)
>                                        bpf_iter_tcp_established_batch()
>                                         spin_lock(bucket)
>                                         sock_hold(req)   <-- addition on =
0
>                                         spin_unlock(bucket)
>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>   Call Trace:
>    bpf_iter_tcp_established_batch+0x14e/0x170
>    bpf_iter_tcp_batch+0x53/0x200
>    bpf_iter_tcp_seq_next+0x27/0x70
>    bpf_seq_read+0x107/0x410
>    vfs_read+0xb9/0x380
>
> The iterator's stolen reference is lost when the publishing CPU's
> refcount_set() overwrites the count, leaving the socket one reference
> short. When the last legitimate owner drops its reference the reqsk is
> freed while still reachable, leading to use-after-free.
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure. A skipped
> socket is still part of the bucket, so keep counting it in expected.
> The reallocations are sized from expected, and a request sock whose
> refcount gets published while the lock is held across the last realloc
> must already have room.
>
> A skipped socket is counted in expected but never batched, so end_sk
> can be short of expected on a batch that is actually complete. Decide
> completeness by whether the walk left any socket behind instead. The
> WARN after the locked realloc checks the same, replacing an
> end_sk =3D=3D expected check that could not hold on that path since
> commit cdec67a489d4 ("bpf: tcp: Make sure iter->batch always
> contains a full bucket snapshot").
>
> If every matching socket in a bucket is mid-init (refcount 0), end_sk
> stays 0. Advance to the next bucket rather than returning a batch entry
> that was never filled this round.
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
