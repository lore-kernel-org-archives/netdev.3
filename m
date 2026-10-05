Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213F4908C4
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225459; cv=pass; b=nxduL+Y7foRIN+PKnCrOdPTjptXqg7mVeKMTxIuHNRU/MlJ3FcUdmcwxwS8RrWsf9afSOCcbGlzAHPJycSsm5qRsVcqozX8AXq+U0dr5FHmlWocARlLtKK6GXCr6IGKNXd/mqqN/b62WSZ81zJvhwM1yE2rG4zJ3EHK0kRkmyOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225459; c=relaxed/simple;
	bh=2JU+Sheh6MQ1xEoN5samKQCu2q7ijg0IaggxyuAyf1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3qF70Q2Ux24lPLqoNgD9oyXojwP0bfE1htbosT+zFNRQrpYsy0Jgyjp5tLBfyd08q6mk2fopOD4NEt1o9HebUs5aBsWP1U2O+4rUZ25eNO7DJ2QkguS9bJJLhIV/uq7q6LyL8eFxt+PDCUgnSxTKozAswE9ZgfCDXKJEBLagTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZ4FvSS0; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ4FvSS0"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1433e7b057fso1218789c88.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791225457; cv=none;
        d=google.com; s=arc-20260327;
        b=H4cygDJC1/yRrLEEkmQdhGJzxfU4jJQsq/LfnNquECfOB/fycWVVj7TBSCdiR3mpGb
         sik0qSPKxlR6SQGMzvGrImFc+ajNG+nsePystWWtcBm4GOnXE++AdPaF+IaJEQwnqSry
         WEgorM/cGFvj40gosv7oZ+pIjzE/qYbj3X0Vl8u7vXWo6RxeC26ZGcXTc8KHSDnAwpvh
         zQPbbIXTxaWqui/+bgfIiJxU3scGUk3QFwd66oy6V0YwcPXnlV8HO63ford1H8POJ8b0
         nBXaUfz2F5xsNt9ZcnJrsFOPcZczOoDGtZH7rVixfyVG807WGqbybhm2yIU6+aLoF5cI
         tmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        fh=pULc+JuY/IvmgthdkKT1iF0tLYIG4PazBGlzSYiB2wQ=;
        b=SwXjjIzWdNkn/H8ovBfbpb/Hd5p9+tSl4rqW9E2xVCqeqIAw/H3+ilspRBpZacZnGb
         pLFhAq25h0mde9RL2aCkOW+hok3iCxiGpTf4s0sd04uddeDCEURjziJDpWc1yLQULHHA
         n0Tg5mWGytgkG9J0LTcD4N7xdr71igDSv5y4JZWQObZGFHQdChICxy6RkTPMeNe9NadL
         kLYE6eSzdNQrlG9Mp8nWsQAThE28BL/iiCl+3ed8/yIrZV+Gwx5upyquTrjR2L2mZRua
         q3bUHo1aNWUXP3EZPUdWAMyBTVBZw6x023Wte4lYbR/CuMGruuLP8FTHWXTBtHBC77zc
         /INA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791225457; x=1791830257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        b=AZ4FvSS0jSF8Qo7UdXfySa2q1ycVumXiEJJQJ7/8/EKkRj9QNEodm1mTZqikkIOs6y
         w0zAlYJK4EZNLwWc5mM+X7+fMCOe3sQ9bgqkTt8MTe8IyzqzAbls2uTjytGsfhiXdvy2
         vZhuFtWHNr2uFjQwz9of/ZSJkSQx6aMJOEj0mso5eAUvw06Ehn3/y0mUT6/CtmQNpnEZ
         gJsiv3BiBsoedwI04P73DU5y6/W31k0WDivD4LRULhKhJnzT88OxY17L4cm6m7SRdfOW
         QqE/KG5gYQcXvI2YrPcMPTL43FvVYXlaLyIGRZitIxyG0sPZmUUQEWs072WVXGjSPEXC
         FNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225457; x=1791830257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        b=G42J7b7ZYGncBBWn697JJ2T9wsPQcdcVj0aXl0J3BGJ8d/1VdkxFU2gyHMld1wGKGn
         veeWtL9mBB6Ji/f05eW9Rr9ACCtrM7nnvByL2rJLUzVH9XP161X+wSt2yFY1q00GxYPp
         f+hBj+t1Xgl4NovyTYix9JWLppY/7SOsfLSTf/02L39EBfe4E5eSMdg8C3H9HVEbg/xE
         V8vKhHN1GN6DEizIjm4XJiwX/XufonMjeuL+CBVS83WA3SYm+jE2rPT7wcN9/r2Ke/qk
         NhXoMNduGZIQIRjt9B66L2xcle0pVX2nU1rAg/8DeTSwGW9T3mCHm94SlEOPLoUp5qYy
         MsBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgxxB17SOII1sHiazeAmz5bc2jgEryYvPl5h9Wm7XhADnZzaaJBJI2aXmNycO1ns3Q/8lRlZE=@vger.kernel.org
X-Gm-Message-State: AFuF++msGkv2nFWAiT3gMoJRB/ZdiypHZfl0N162SMjrtGDNmUWvvgcN
	/Mno6qSFaNP62hqyWVfn1PhbCl7k7oHI20ZeM6237vxxdgE39qchVpl9IYTha4lKO6cgDvBp5Ix
	S2kAzoHAg+EOrFE0ieOhh8O++fg84SkWZQWJ7GAFW
X-Gm-Gg: AYBFou0m5+0TYAQRZQTz/FCmlnF3H33U+L/2GLA6skC2US1VE50l1Whts9qbUdHmhom
	ZHSgjBXKNCEraxpgQ8c0aS3t75YcH0WGjfR8mJL2CrX5lpcYiZ3zXVoha7/vAVIkl23sPD/P4v4
	IbJwqI2suYIr/KQUfHFVT28gSFrs3w9C4AGFyaq9EhEDwchIekjjkr18vmPJD3JmfCV9BxXn/zj
	d9BUaHCcwnDhe6UtCYExqEraqp9hJ/z3X5L68l4gAqRbiSV39FamANQ/ZL0kl5yClZVviz6JwcY
	Vxi9j7t7xbbp34vNAH/xcil6/ZMc+7SEpyaqkZ9Hwro64jTwEAZ99zo+FlMrbZWVeGkQ1A59gHz
	C5JZwKT0yoMgfMIc85kkuRFe9mZgL8ELzezz7qnpWtIdduicAmsw/vrLdTlqW12SHJmOQRFF7uU
	bV7PFhyHv1OrshvsgSje+zew==
X-Received: by 2002:a05:7022:f51a:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-151c33d34cbmr10196374c88.21.1791225456263; Mon, 05 Oct 2026
 11:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-3-kuniyu@google.com>
 <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
In-Reply-To: <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 11:37:24 -0700
X-Gm-Features: AclHuK-8QnzKqa05dEZjVlQCiqXkS0NX0LuNZTU47FVLnAJahel19JQ74BKYS8s
Message-ID: <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:30=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 10/05, Kuniyuki Iwashima wrote:
> > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > tp->bpf_sock_ops_cb_flags.
> >
> > In contrast, bpf_tcp_ops was initially designed without per-socket
> > flags so that users can simply define only the callbacks they need.
> >
> > However, it turned out that even attaching a bpf_tcp_ops with a NULL
> > callback incurs measurable overhead in the fast path. [0]
> >
> > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > 1 bit left for a new opt-in callback, while not all of the 7 existing
> > opt-in hooks are in the fast path and really need a flag guard.
> >
> > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > update it, both of which require sock_owned_by_me(sk):
> >
> >   * bpf_sock_ops_cb_flags_set()
> >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
>
> Can we return -EINVAL from these when used with sock_ops?

bpf_sock_ops_cb_flags_set() is not allowed for bpf_tcp_ops,
so we could add a check in bpf_setsockopt() for bpf_tcp_ops
to disallow TCP_BPF_SOCK_OPS_CB_FLAGS.

But not all of bpf_tcp_ops hooks are opt-in, so we cannot prevent
attaching bpf_tcp_ops to SOCK_OPS-enabled sockets.


> If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
> bpf_tcp_ops_call under the same if conditional?

I assuemd we will use the new flag only for bpf_tcp_ops and will no
longer add a new bit to the sock_ops flag and fainlly we can deprecate
it under a Kconfig like CONFIG_BPF_LEGACY_SOCK_OPS.
