Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794118922;
	b=TfnQKvEMAxWDhtPwmVdXBFGM0nqsoombR9eKE2TnZy4isEx7RrB3mlAXw/4LNmdf7vdp
	 J+sFj6WUCG504huTs9tjusmQVJeAdBt4fv8gfFfGSuuLpk2DV30rBHYeJ8YhD68wsl6uB
	 4/I8jZ9FKburCqlToDo9A1F+NieuakE15U56ikWLjN2ZamK6hl0SU5/CNu5RrEcYqQc8V
	 DP7RTc9mvNFbA6Boh48s4YIDJIPf49ITRp9+wVS+s8JqrzVv2mdec0VWF2ux/eEhOiUgy
	 bG2WNGQRXCFw1oGnMy+Ai/pkMMUyvw3Kgx3xRlu1aeDYst3Xsx+AfBWTTBSzzJKWD9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794118922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
	b=y4riHxD1CZMqbiJBXmPFHVcoFWHUHNdAghto1rHttapE/thQMKEOjv2TSzN9U8hm8YlP
	 cfFEMb4ZcwcH21PU9ljXUL+cnvx9U5Oz0uyYpgUCOBBLVQxcVnIL/N9BmhMQC4aYp9ns3
	 R9hKd9QLy9AwpQNLnYtQWcvROaL7MICvGZv6R0cmiaU5jNhIrGrm4AcX3QoUmj+QnQ7Lr
	 P6Lb1E+Hp6Wgonl6lEoyX0zGja8PSF0vbYvOQ+19tGP2poa5n9xKtqHVBybLZgztjwBr6
	 qExZu0QUeYibLbSVjxk/rz7SOyhPoxV+51Kigh244JxE2buaDID2Gwrcna42MlsFh5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hUgHyzbh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A52606A31D
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A52606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hUgHyzbh
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso221a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:22:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794118920; cv=none;
        d=google.com; s=arc-20260327;
        b=hhAyy26fs/xg70pIwECXqsVByefj4EE6XHjfMUycRTFgl0oG7WlEad8EmOwXQjSThO
         jTxZxwDboiYqD1uU6hcgpdXjD0//gbwzt5nnLtmLTekR+QWJu1P4LAquIVg5LxVVPgY4
         a0M8T/5vYcMeU5U1vJWYczRi1AmxG/rQSmRDR8E1lavbgXmkiCLQ196HAyCrbCVfKChV
         OHHO2FWg3Kgen7icK1Ytv5j3gGpLtFm5ARgAsxyN4nkzvynlC/OQITJsW+my/JJ7qXu6
         2PHr86soe7SRtOtI8L0urdZVlAT4Cy7RPqmpjiQD3dg0Xpq49kgwPw8/6Y+/bL/THTxd
         Ntsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
        fh=G+1sc63uYJ6FNssCNngeTrtwbKG1M4GkMhKgifHG6Cs=;
        b=Mmox/HZvaQRGwqK6W/cMFs+YyQkoDCFW2qYMMSV4lGSDYLdcJbDWVfQbcHTBl2z7P/
         yXHn0U3Pl09PNgmTeZfIoDPDgCM7ySh2Ng5QlbKw6/ebPNiZgChxBjsmrVDzAiDmQFqd
         FX3NVMUB3VSWdJDbVMxMnMyFpAkRxc82SbYwRx7zn6UvPcdAYYl09/OYLLrd/loBZ6If
         z34NHKFjS7eXMOVV6SgQKrd99339MxDQ8t4ZtLoImqvqkpHXMf0VJ+40xqmWdeZ8S0VO
         x6oEr2YVRceJpZB09rFCOTERm9CzByIP5rJOAcAIBbh48Dz4bZuZ/E3x1m4NHSZzIkX6
         4N0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794118920; x=1794723720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
        b=hUgHyzbhHHaa3x0MGZHtZ50WogQLFlCdZt/lmpI5crcqaTYEzBLVvoJT+z9qJrP+mN
         2zbgqjLjweGNemctefm1fEFSRBhgSp3oao5JaYrbL794p9RQwLH8IbD03A1vfK9G8Hgn
         xU6BgmL/ohZrkZkQyqHOCeP1wKoEuHAy+mrlzWmeCsJ2azmakD7HX9Dv1qYjRCWTRvml
         +A31W1Sdhj137368ySt2DvScSVHTeX6n1V3A5imgT+udmv2EDO5fo8gOJEOirBFNfme2
         CiOhPNFnNc+LyuKNTbG/oQjABYDT9OeAE1XRKctqmZGWr4uzP4FMUjddZw6ab+cFyo3z
         Mnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794118920; x=1794723720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2XprYGCXtRTCuqB4/wKtddK9ZYd1kM+u1y6WT6JlOc=;
        b=TW1Wu8y/mzywY6kpVhPK0Gd86J1uAxBSS8x+0aftxLygoOJdfNObanOUIgdn1hg9rQ
         0AO1eSJAGgTcdGqoVZXWtd1hyqgfWlq2qAeDEun9StD9oTM+LhkpBH1RC7yaUqgFdist
         Lt4y59I2Jl6pt+VC5Rccci0ZjNrPRlcmQom2esJfkbyp1Ntr/UybsjguRUvJi2wMCT0e
         +fCEVvuRGF8QiFnPqWfSE1YrHkNR79kALusAVSVWhix2Xtyn6kmtioaEi2BXbAvqEtHq
         cNLYHoyTBcrauTKs86mrAsr5W+D/r7mWm13b3gFhUdYKSIAYbJLrxqcyGMUNp3jwkbvr
         81QA==
X-Forwarded-Encrypted: i=1; AL+hErFNiH32IoL2hl46Sv+JhAD04iJCMMqgRun+g3b7oU5zffODj8jIjP6TQtNYo5xeWHWy3m1sJ0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AKGIyrHdjAEWPcQL16QRP79eYPpsX+Iz0VHkclY/6BTYfNn7/
	ahn719UB01rM5h7iq6oD93c9xBf+A9ntN0fKfibWgVEl0ZTT91p5dWs+sg6tjrKg64ogx6nSgJ1
	I0cC79ZpFxcydetVPag/VPZ40l2b3FH1KByxr8OJN
X-Gm-Gg: AYBFou3nztOVfM0Q3rO2xZmJauXivU8w07D2GajbJoi/UnwS7kmS9gzCz7ijRHQrjcs
	3u98x9pNiJV/eeCc0XD5ZLxVRXNTar4kVLeIpkTcbuMPdp2+AXNGzlsOHhFmcqgum7orTls2nFb
	MEjS0w1LOhCuYFxnsqOIoUvuriub/nW7s+BcHnYVRlzsVXl/C8MYn4BxRUz2njuktpKZAyRfwiH
	dO/ky+uADW9Y61HWV9/NN3BSFwxDl4MI17lE7aqSTWrtvcXSCoY8Rk5/N4l6DK1VYcL0red2skg
	GQQYWxnpGUiT7VY7p9W3BmqGz9THdL3Xj1l7qyqJmK1pgzRxa2oFG08ciOIkrhLEUfd/caswGCo
	l173oARY1O6hmcPrDIKzGaTo5wLcDXic9uCLqLVrl6qm0fPQbffv69soP4Q==
X-Received: by 2002:a05:6402:c502:20b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b6fef8853fmr25733a12.10.1794118919631; Sat, 07 Nov 2026
 22:21:59 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com> <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com> <20261021132304.23e0a4e7@kernel.org>
In-Reply-To: <20261021132304.23e0a4e7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 7 Nov 2026 22:21:48 -0800
X-Gm-Features: AclHuK84A9Z4KJMCekRVvO906KgemJ7leA4F7qgUGSEUquHWR-U_KufDY8SuGMQ
Message-ID: <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > But on the other hand the test coverage is nice, and maybe one day if
> > we add enough devmem support in netdevsim we'll be able to fuzz the
> > data path or something. Is there a way to get the best of both worlds?
> > Like put a comment on top of netdevsim that this is test simulator
> > device and any missing functionality and/or bugs in it should be
> > medium criticality max or something? Or is it too much trouble and I
> > should drop the netdevsim support and tests?
>
> I already strip Fixes tags and apply the patches to net-next.
> But it's still a burden. If you're signing up to fix the issues /
> review the slop we can try.

Hi Jakub,

So I started looking into whether we can improve test and fuzz
coverage with an improved netdevsim. My LLM prototyped full datapath
(with devmem) and offload support in netdevsim so the hardware
selftests and packetdrill run and pass in a plain VM without physical
NICs. I posted the branch at:

https://github.com/mina/linux/tree/nsim-devmem-rx-tx

The main problem is the total LLM generated diff to netdevsim: 62
files changed with 5,525 additions and 672 deletions :( So it's a big
change.

But with this, we can do pretty cool things:

- All 36/36 drivers/net/hw/ tests, 18/18 drivers/net/ tests, and
164/164 net/packetdrill/ tests now pass on a linked netdevsim pair,
without needing real hardware. This is significant because a lot of
these 'driver' tests also actually tested unique code paths in core
like devmem.

- NIPA can now (I think) run all these netdev driver tests and
packetdrills without real hardware:
https://github.com/mina/patches/tree/nipa-nsim-hw-and-packetdrill

- Packetdrill can now run on netdevsim:
https://github.com/mina/patches/tree/packetdrill-nsim-default

-(best part) Syzkaller can now fuzz live devmem/zcrx datapath &
offload netlink APIs:
https://github.com/mina/patches/tree/syzkaller-nsim-full-net-coverage

You asked me to do add syzkaller devmem support before, but adding
devmem support to netdevsim was too hard. With LLMs, it's almost
trivial, but it involves a lot of generated code.

Do you think this (or a subset) is valuable to post upstream to add to
netdevsim?

--=20
Thanks,
Mina
