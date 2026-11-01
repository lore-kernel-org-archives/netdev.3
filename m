Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793574975;
	b=yvUfdEs/BFtzh5v3zH0f4VLe1GMbPL5ilQc+waoK69D6cNHuwLIEP4TcaHwwnB/noP1z
	 v0i5bRvIWcVUW8qbjkCo20JZVNb1NKQbR/Ljy4HvzvXTBelIesMYmUZ5el3oWN1f+zha4
	 ym7MxB5RIVyNfybslpbidKuBWSQ6i6ls78tuiK7boYbzbwZbFpbAAw/46eDJYi6sZdVyo
	 E33lkHIylunwxKIAzxkr0LfTKd/Ebqmc6Xc4qxBTsOPXghii54gImaiUaz4yoV4qMe9Cw
	 FwU4Io5hRSChuxXne+Ub9nOyjpCZ4fsNgYN4UO2w9n0jR3j6HOwM6qm+/WrEUkPvshw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
	b=MC2yCvli+nd0h1kQwr85WEPI1CsjWD81/Ryb17Pw7KtZvx2xA1dJNPXyH36kQ+o4Z/io
	 PCOTAs92jgLtcA1GyMpmP02NHzrNePKoQJ1gi4Rdy4DtKNyusXbwHtHXEGzWAcceC9Ji0
	 2AXT2JIvKCxO5IkdgwlvyPfPUriI0vZhumFPCpSoPG5GaBdQ+7Bolh1RTlPZ0hvkD/5t+
	 u5vq9sYg8uPMLJglYBG6DasbNLcwmU0GWmgIsRclaNnWMuy7uF70PZhobaR4TRbWtJyNF
	 v6VGUKKIY9UW5uCy5lVsNJarcxxYYz1l/qg4onWEFb6szp6V9UfxSSly7K+rAE3dv3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="B6eD/wO5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426E606A332
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 23:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9426E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B6eD/wO5
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso7514a12.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 15:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793574974; cv=none;
        d=google.com; s=arc-20260327;
        b=Sc8z9/l3dPayLLXiwdS9fP+UW3xJSWSvoBEITXq3UIVG8aNXrzyqx/S5SZy1Jv+uOO
         +Iyrd0OTvwIEGa/JV9UDc9/yMBSl6q9sExA85fwWAS6nfd2Q19/y951BL9EeLTC0D+QA
         qxPCnzO15/3ZAwQLmHKeKLNNIwlwgwM3E414BA8DuITJLUkQtkGiKOjRumLUiUob9Zlh
         lyRGRbBUTHxLHZ17r47xMC+j2M3KiUXpVNfMG1fMmgEU2OsBAvsOhuvlFcDKJBBXLqy5
         B6Bs1Lb/tCqf4c0SBUy2NG9+UnwRHhNPnvZWjf1rPZ2Qbwc+zZyAqnPbXEjqC/0Aoel6
         KLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
        fh=c5OtIO9n3Mhvkmz3gjzE6DrMEVP5b0cXHqV69m+1Vls=;
        b=Lud1GJcvfp0p3LDoRE0GxwCT1elYMeIdVJVxXRX7E+imaFUcdu3yw8516JbYu2SxDh
         A6/krh6weMPJQlemQ+QFBY19JqsKw9KTIDqCTJ7xkBbn4xcARrLaKJMTv3E5t3CXyJEy
         UrIrervNE9AXQqUPHBluhET9nqg0Vy+WcYqLv0dwUKEg+1jm/yKlN4/hotlTC5MPVYBh
         j4ode5ElsbdEDmS9/H6F3eqh9OWI/aNIQShuPbSSKYX4mdSQApkK9NAii+nLwKszjrGa
         5Y197OBwib380BBPls3zXtBEjxBCBdaulmPQ9ggVVY5moKvOZjLVBblkbfDptITtiykX
         CrHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793574974; x=1794179774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
        b=B6eD/wO5t7w9cr5msgMFDILth1F5IYv2yTF+M3oN3LY5yBUCf8LbsX8b/EG2x90vMc
         o1ifbd35SU/EjpMruPB9UPjK5pHCrRD2cuHlsD4MZZQaolUEBfaANH7GMS3ZcR0cBYfC
         Pn/HQAGHTRAxbdUurIHjZmgux4R8Hl73PetNQjifvN5ayQO7L1PgUm3ExnpeEepNgAzg
         UDBfzpgqcd5dTvc37HDnF2segKwhVXFd4tJrk1GoygafHDKHc4yY44rDa2sFoitlIrgJ
         WnOMy7XyDHGR7QjkAlpTH09T83L+F3uzmZZLwA7BBZZ4ZKX06XcjrBbyXWiLg2e0uuom
         V+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574974; x=1794179774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
        b=1SnhmndFp19AnDnI1QXVL4MYtvmAgJlZDQVggSSws67tilMT/txpd0PPI66iIYnPHr
         QEontlmmaNjDLSH4W59KzR/+0VWPZPmdcl06PgDHxIMHEA+6yIzkO2mcHuSRJw8Qs3t8
         PgadxafWIpE4/XvgieIbOeP1mzdAcO+wF6fgxLT/8vR7fqvuLbfJIAHx34iZNbM1ta9g
         XUaMMjKlb0Shse2dsrlmRa+8SDfOfIOzw9JQwPAXTb1Xeef/g1XAaAl+2C2kJakkUrHw
         Xrf8S/viQsbid/zDVZI5VHP5CIl9wkIO9DkwnKYTaWddj8OXtMTPcQi4exBK+2ljwHjp
         0Ezg==
X-Gm-Message-State: APuU4Z/qNt2YLGIb9k7Drigwi1ampMh/JIpzed9y4D8Rm+m82WN2xGt8
	5AEwMkR4OMAuRi+CWHoL12kAmsmbtVOQyvjZdTQb1dgdbOmaWQoFqZtHO7p7IjeOY+avgjk3n5L
	0JVIvub8LQKEIblhrKxBRXrIH5uPFKREnaP/Kh/IY
X-Gm-Gg: AYBFou1QkE15KJOs6rT7SJgY/eb+yqWqppnHomK0CohJ5VO/Wo8Hhqah4RgbnkGuP6J
	E3qZDqxc8HaYdcVb7cbGoeKYJAkxp+lpcL1seF3BzGQo35aFBsJw+MqgEjokNwq2Ot7LXbUXtEY
	lX8yetMMhw1o8rJrkQm9aZMSWkLbrQqN8HwkKzr2Aa4t3eX9OOtr3DnKBX+dZtEc3wOA5waX6d9
	ZtsOyOaes9IBfHfOguzNX6/ed0fYXaVXwtVdDVjOstGiQNxvTCXsZj8MTJsTPO6WUbWKGKCbh5z
	0UYZyIe0STmuNGj2S+DNqBeICVFcKSz4VcGhV259sx6NAL3x/0L8BWoZOem4ApMKn7HbwBDkO+C
	DgimcJl4Yz0a+41nxG3YD0iMzp37Uu/HV18f7F8I=
X-Received: by 2002:a05:6402:2154:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b4b42a63d3mr252843a12.14.1793574973443; Sun, 01 Nov 2026
 15:16:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083539.777877-2-almasrymina@google.com> <179357408146.3131.2882435952119280563@kernel.org>
In-Reply-To: <179357408146.3131.2882435952119280563@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 1 Nov 2026 15:16:01 -0800
X-Gm-Features: AclHuK_Z0S06xrAeAq_HAO4Ko_jHw-2goCa0w2rOFRiQDckpwHJNSPwxMM9jz2A
Message-ID: <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me, 
	kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
	andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
	tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 3:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The dma_dev use-after-free this patch says it fixes can still
>   happen for RX bindings made on a virtual device that leases queues,=E2=
=80=A6
>

I know about the issues with leased devices. That needs a bit of a
rework, which I have done locally, and would like to send out as a
follow up fix.

 --
Thanks,
Mina
