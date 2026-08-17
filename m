Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCE322B8F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943062; cv=pass; b=pCETkEJT9lgUgJf+eFIsJXkpALG/vGQ5N8WbvZzwFmre+UMuYbdspp2tk9tYbHjZv95ajIJGDN3c906iVOHbuDX02F/NhmNiX/fZ3M8UOkL6QbxVlfFAGOQx5J3SyDR5Vy+H/CfyudI0yzJJIBIzg6cLQOuB4yHpouzFcSxt7ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943062; c=relaxed/simple;
	bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evQWim/rxowBSsZGnRgF5FhySWnLKVauHDDUpNIWTS0FlqXNb/k8oGPmwgxWauXJlhCj/S664oZFrZa4VnSWfZYjIVLUUJvLN/oubLgbWaIz+3u+3YS63mAKeIx+PAsRwfC5V/MTknD+oN/xkOf5NwYxgR8ljMpcuGMe33AaQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufGoLhQO; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufGoLhQO"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2385226a12.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786943061; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3X97GO2l6HxWB45lmhrFIn99momK62xeDfrS50ig4Jcm1qSJAUjKQ0HOWrWnjuc6K
         b5E8NzSJ9rJ74cwWhNnMi874vhA3HNvYDR9Y6/Pv5MBi9IqpkSiVB7DMVs6JLc7Dbk71
         B+oCBnk178PpKLB6EqW8yWnLyU0Fb6Y8huQn4ojlN49MDOsAgeslW9DIRWCjCSLzp8xU
         ypKqheCPBGCdIbFo1CWD6BuyiJQOZkzK4TR0w8qIxfpfp2u74EVzZYxZtb0RvfqaYFDy
         UcaOQtpZ4Nly3acdnwcEtiISjREOLeIQ7G2ZXNbmhmxgFxKegc008zW481qlBJhUNkqz
         MC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        fh=Z72k2VQ9duK3ufLuWJ0SmKu6RoTkL9EfkxXTyFuMbdY=;
        b=Dgf4h1sdx2O6NaVgob5YBr9aVdlvZKKNYPOmNCGuK3tCcw2StIk0k7iTodOrVtxksN
         QMOcJpO3q6RyiAvwgoeH917oKvwZmEcux9nI4yhWQuV9FzSY2AgSKVGV4IO/KGLR1BMp
         jIs91w4+EA69wwhcDTT5QkBuhGYR1iUBiCp8v0gPwh42RToxqt1vRjc5H7mPtcDn7gvg
         HVYiYnRpsHSNRYwmurfNX9lvMTX1gYls+6hfjlg0ulj9wyFS2ChPkTL3loz9bNzOhdFJ
         whTcRX8lnZDvl4nLg6eEQ+X8IS1owywBvo381JTDqxVGjMMjhv20tc7REm6lYyl8M2Zj
         9WSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786943061; x=1787547861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        b=ufGoLhQOZShPrW82jVdtbRtmuCTj9YCinSYVAoZtpHqp3J9IO5xVlM/rqyz4lx3Wap
         00lwZhlwhMih9vccL3fjc/1KuaMzLJjvLYkErvusq5Z7ZTZ79An1+TPB2mhoTAVw4I/M
         9p9wv3SMDWZliYcMDpP1kKWTBNiPHby81nngcYfSxmz9hnz4m6e1VzXwJP6YJcEij/4k
         9t/nlqXW/VjdkcNVFWOqMsDPlSrE6wYeuDYnNoqorwtIkrl5SQa0dlXI4K9pABgJqEKs
         0syLQ4x5OJULI6TYs8669DHASkkWGnq3Z6VT6aK2oZQv/Bzw0wBgWPhIOkGIC6IyWks1
         LEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943061; x=1787547861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        b=ZA8H7dVltuwLmTFKLYE1a9txzD0onVmybObV5NaqAEGFAPln1q3MOqggaSfIy+v4oc
         wae8QkRg0ZuVp9gwC0Xt9gBPXBqyQQSEi2stBKiVQgOJw3W53yIvQz/GIv5wWwWBiKWa
         dwmNY1qTlYsp7uhuQrcpsW2mklA2h6gZMIQnar7T7Ov8L3AmpQMxojHeOd6RoWZC2xTC
         s3xjz9l/h3Q7R9BHCOqdkaCG3OcSlA0csgJkVqxky8jbZ0OuXlMz4gJqPS6Jjj+iNvhk
         NXa9f2jjskuBAay4v+Jp2eSZKiNkPqV/6x3HpxHEOnAiSPl+mCBxu0w1hhk2tqabifas
         0i/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoOyM5F4faAcQCNUqmjTSyDQorx+KL7sGUo2Jgyh+dO/+BB4DFuY/Al87ptULVHCO0KMWcJdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/it7P2bYVrGFTiHqJqAwEowaPsWYXSxbpPtlIpQDaCiEgcUb
	XhH0cUirDioppw+jmfFCPyOij+PPo7ewObm+dZesdmCg0V+f94VhKzrzrFeEbA5nWc11ZGZkJbY
	HCd9ifeaB7Rg6WdGuQl3tUQhcD7aZBLNT7jD9rlx7
X-Gm-Gg: AR+sD11bqo+8XqHsezpIV3NhO94wFAsrXA+Tv8fY12aDEdg7U7DbeBeIwMHbPMcSmSv
	BOqtbdBCLXfGJc0SrxFdZJACgt3Yp4NCIPG/JQJVjfJnMnahVBpo+GaSnKqr/p7HHthB8kTR85V
	V0d7j2Jh02QXGKrtcRwsWijc9EAxX7o9HBNjSIevchQcEnU3FkCTC9yEJWWkJB+SqGIdm9UMNDc
	qYqgm+C3qBkFcTzPLTgmLMRfUrysKFj6QE4G7PkkCLZLw7Bu7TI2dGCmrFj/AnOMyWikB4K+MtY
	IocO2sFRzeHfY1wEYA1HYXDDLbTI5eSsnu0PuL4d9scq6O4gh36XSEEGLECfNYG/tNa8msGFtXF
	DsAJaLaciJfxm93rHQyBRGP1iM85V9lhJ5bb47fbsC0xzdqKptZn8BWNGtTUbddr9vY0=
X-Received: by 2002:a05:6a21:9981:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc7177a8e5mr19421702637.0.1786943060377; Sun, 16 Aug 2026
 22:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812091654.244752-1-zirajs7@gmail.com>
In-Reply-To: <20260812091654.244752-1-zirajs7@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 16 Aug 2026 22:04:09 -0700
X-Gm-Features: AcwNN1UsPd-ngtIs5v2NvwK3PN-7a-ZlMOROwWseAnhzc5-QwQ6SAZKKnaGk3_I
Message-ID: <CAAVpQUCLKnN_aa4aCrufQukjuCcvZFUFy0hfPXOiGGLQw7bLAQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX
 getname hooks
To: Junseo Lim <zirajs7@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:17=E2=80=AFAM Junseo Lim <zirajs7@gmail.com> wrot=
e:
>
> _bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
> full sockets, so these helpers expect the socket lock to be held.
>
> BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
> programs without acquiring the socket lock. A program attached to
> either hook can therefore trigger the sock_owned_by_me() warning by
> calling bpf_setsockopt() or bpf_getsockopt().
>
> Disallow bpf_setsockopt() and bpf_getsockopt() for CGROUP_UNIX_GETPEERNAM=
E
> and CGROUP_UNIX_GETSOCKNAME.
>
> Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix socke=
ts")
> Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>

Makes sense, probably no one calls getsockopt/setsockopt() at the hook.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
