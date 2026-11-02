Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793650069;
	b=UIgZMfEEq3Ss1cJyKDw8Mh8AYe4I/Xmro0Jgh4HxCSTxjq8Cmg1bxpWPmLqh2rvt+YZW
	 kGU7jvc1YTvHmwddQGq2RSBeKJBdWcp+e34ZKMYweN5XSUlqtdBAOVZkLwi9cQCDe4Li1
	 6HupXVMwXVCMOLxoa0nDwhpcmoolYj9G/gJvN74amkNl6I/OoE8DNyLVbFbJ7JxZmyYmc
	 NxQCYg8Ha/U6VEP2nQWLZUbatwfryAitr21Zr6E/bT/gQ1jfFOaMD0LGZ4dZzlKZjVgR2
	 UzXP/vT3yxpZFXUuhdW6vrR5IdCHqwXx9Z3BCek5FPR9ZkVM+TwwHhteQMA2usx79bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2y2WavsP8svBBeJai9Uevzqpj1fQ7NNZDo+HgkQhGww=;
	b=fj6bpG9Sp5P7tvD7Uc4T2ImIg93H2ajUDa+rPr8B7HlgvV+FZYPzgYJTRDCQkObckpkn
	 wDvw/cFWs6gLkeDCKHC9U9aomIJTbyA194CjVYmj+gBdjeBgqxiAECvDFsZWRWTn3C+nQ
	 JQoFtRFSwK+1rKOvTOB5SQdiedna9ep8/6atWUgO48+jhg3nKwJQUyKYyxz6GPvodZPzI
	 yV3MA3cmzWR3TSofXltC6nxRLVY6i46WXHTCpx1cnu6GyZOHP8Bv04RyFyyBUsUVfOVfK
	 wSWa21a8oopskoX6xfDk4gLE/20dJiVzsT91CMokNulZdud/HHBbPxjZs2I//oqiW3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jk8TrkOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015E606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C015E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jk8TrkOl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1782a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793650067; cv=none;
        d=google.com; s=arc-20260327;
        b=iavb2gxI+uqYSuW6NcOar8EWosKtB6wK12gYO9FKn9CKqTdtvnLqKsVTX6W2aBpOrc
         7WF6TI9uWBvbjomZBSqBEthOca7dN7xQ0ODkFlO7sjJUQjFr3rAs8s7HpxEb1Q2G7NB3
         52jtl62Ijr/mPMk5hWVpyEPCzfCGF/lwelYdruhpep34SOx8/o410NxG0rIkmF/bDUAs
         nOEuLIuFwwZz/4IZuJwYua3f+Zk+mhN1vcpfpdQqJ6J6aO3nGIeX57BGDZxO9JiM2F29
         /QgJFtgWjJDfDJuge5q5eUmk2HXCtfU8az/MlmvEyI3Y2lgrPiqd5O4kHLxdhNtggjNR
         3VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2y2WavsP8svBBeJai9Uevzqpj1fQ7NNZDo+HgkQhGww=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=TCWuwyKSqFjM8ZVtd1dHZD3wBBtdyjmI3hw5WEfJw+w0uVroar8bGyo7ar/e7xO9s4
         LqrygVLKzFtx6X/JLFTkC55mQyK/aJodcOotbxHYEw5hKXH6ITOrBp2nl9l8KUjSOXTm
         ktQ+SDC1NIPLWwT9yGpRjrdRIp2xVLaanwPtxWsrcNyp5sHsH+Q+ZP1EJQZhGRT0/YM0
         Hz1PICf9H0qbesobtYtSplmZYAiEaFTlLjEnKr6xfYadeUzsQG2tLEF3BOQHkPay6uBp
         GO3NPoD0p5bxrhxN4B1duPlnQqH+CqilFgZsceSekLipKBij29AZVr5QKPN6PGb45Tmn
         yl5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793650067; x=1794254867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2y2WavsP8svBBeJai9Uevzqpj1fQ7NNZDo+HgkQhGww=;
        b=jk8TrkOlsW97Uh2N2lxEQCWSr5BDOlLraKDAJDImF5X93emauVjuWCB4kRG5DXJ2mg
         oXi8tL+XOW49nPtI2u2njp9hmZSDUMa6G/1KMaO9Q5qzNu07fJxBg+FGZwHSPkrB/3+p
         +n35tr9rPg7bWoPu4eX8xtne358FzfbxYLhTbxaih9uGNnm8EspyFlcWvKfSR929T1wP
         PdhuKIXNMBvyc8JGPZ0UjLnzK8d/ugvhnqcVfKUScJJXgrIRL8SofUmBK+358GTHLXn6
         4DOPImXL7BUxCQKWkh8a6VYnY27wG/hPyzEY2mSBDHGTrMVjqQIyvUjbN5Mtc+HYQcjd
         XJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650067; x=1794254867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2y2WavsP8svBBeJai9Uevzqpj1fQ7NNZDo+HgkQhGww=;
        b=UaR03K1rtVjyoe0j1WF38C3yHKh8Yun+0mRDjBozOnpptVMIefuXsAxRSe1X/AaAX5
         gDutfq6RuiR65GeLL3TkUEgQMM2akpw6tQFypKdjB9ZNY4iKNHi3zXoKFKyjS7Xra23J
         RJ3HbE24nO+9RnxpRw+xjMfIke0PGCUU9CC2NwaV9aai4co2sE/gNDEeJhbfWECYea01
         A4hQoYoMXJ38BS/nBPO3E5FT0k38bmfvADEb34f5XognDZNHAEm3Ea+2QG06RPhEC3RF
         6HH4o8Zv+14uI8ZlZw8ulCGyzcmjaJpiBc6jX4t1C1aBiis75SqaRf/ZlfqmWcqzyIt1
         GBeA==
X-Gm-Message-State: APuU4Z8cNO9u3OoxtYeATma9tJnJApVCTTYFh8nM5nhAkbmRmYsLhXv6
	jsdRq25NTl19xfe88GjuRmXTRLPSUoNwnR3Mylf9mZJoPB/QpXxL0oHiZeZDjrHg0rfLjVU9rVF
	fAwh/YSfRsKgSnoL8RNX4e08GlOPQCW0XbF38HQR8
X-Gm-Gg: AYBFou1gEL1vdnoOTWbWS+bdtQ7ksE/p++uuAY5fyIEuNMW/nx/MgRNb5WkohXl/8gq
	/8TqNPgT2pVG/P4QDWUwaH4Ugt59nc7B7DgBlQ65Hu2zugCRTZcAtB2eaK1uqK9QUxfzgYq2Ub6
	WNuDk1njsqFCQF+iE2kgnzc0zhp4iGlVSoodXk5ei9skmvgHNxXJK53zCh4Y69J+RQzEHMo9J7U
	oc6gHbPDbjK+dNNkyBbTngLJfMbSQ0NKo+WRNR//tEZuu1zogPcIGSRuo91Bj45N2LFF9nIC/MF
	01RjC7/vEdbrGPpngroGnO4FPo+z1+YerAai/7ko1hW7UbhyC/T6eEzvllJ10j8arwPdghd39yM
	ldCSMZnWD+LSL6HhJJPV3FwhZB7abNaI/hhRNGykF0ubWaOo1zP0DI/94tzsYqYfMA5IExgU05s
	Z5RPsYLrxEATqN
X-Received: by 2002:aa7:d752:0:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6b539cf7661mr6374a12.5.1793650066614; Mon, 02 Nov 2026 12:07:46
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:07:34 -0800
X-Gm-Features: AclHuK9gfr07IGAAZ9tA7d9yIuAWy2wfQLlcGX2KzOTTr8xZ9Khn8LIVGKzus2g
Message-ID: <CAHS8izPAaA5fNGmA6TTAuo7z8T4-+1xmR0yF=OZH6EAcQEF-RA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] net: devmem: size TX net_iovs from the
 dmabuf layout
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> 68KB, which makes BIG TCP ineffective for devmem TX.
>
> This series picks the TX net_iov size from the dmabuf sg table instead:
> the largest power of 2, up to 2MB, which aligns every DMA segment. With
> a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> no UAPI change since TX addresses are dmabuf offsets.
>
> TCP still bounds skbs by size_goal, so frags get larger, skbs don't.
> A single frag can now be as large as the skb, which matters for
> NETMEM_TX drivers with tso_max_size above 64KB:
> - mlx5: 32-bit length per data segment
> - gve: splits frags into 16KB descriptors
> - fbnic: keeps the default 64KB tso_max_size
> - bnxt: 16-bit BD length, devmem TX frags are capped at 32KB by a new
>   per-device limit
>
> Tested on two mlx5 400Gb/s hosts with kperf (udmabuf, 32KB RX
> net_iovs, 2MB hugepage-backed TX buffer), series backported to a 7.1
> kernel on the sender only. 4 flows, MTU 4200, 6 x 60s runs, medians
> (CPU over the 3 runs where every flow got its own CPUs):
>
>                               before    after
>   frags per skb (sender)       16-17      1-2
>   throughput (Gb/s)            389.6    389.6
>   sender sendmsg CPU (sys)     12.0%     6.7%   (-44%)
>
> The link is the bottleneck, so the gain is CPU, not throughput.
>

I mean, test single flow please so we see the throughput gain. But
CPU% reduction is good enough reason to merge I guess too.

--=20
Thanks,
Mina
