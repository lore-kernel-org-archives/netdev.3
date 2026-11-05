Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897088;
	b=T9W2YTXz8tX43FwxxGPntOKXx4HBTG2djEsdoiUrxV9GN2Yy6cqRiGxHrqKCKnjrJ/DR
	 G8rOIS3a/3STaMN1gffxnC21k/P2GBFy76CdIIDjtDq9iCZ2kJdq5P1ZJO7GfCZCYK1z7
	 I7GmDyFNAo451ni7h41L4FRelKQTN0PtqCUlKQ5tHBFOa1zR1QH9/uXRrgjJ+b9QmxyBt
	 FkJl6f8LRzCafVE2b7+L3aifVuQ2aqFzLXBe78KwC8mVExVacPwErDpfSTzrfjVyCOO8W
	 MUUsbNZul/hnQ6J0XCP2gdzOsi9pubUqAN/nA50bttvS3XLm8nsECqgJG7mQZIrcafA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZqMiJDrBp9dqyb3cO42U+9O+NQ7NWtABCad+4xnCfR4=;
	b=WwPe32kKe2BFu08KtHhpgBiGA/KjnI8565Xm9cfugG+30sIqdqdkoNgvsdbE+y7ENSm/
	 GoT8kEDfrO95xYWSXeEB8tFAxmN5kWUmvDP/TnhtK9lpNeeGnd1+aBrdJRQMqt/D6A5pe
	 4u89iG1PTfXiSAah1Ejxr2u16Ih5qCMoF8AZl0mK9hQMzXTjxSI20Xvl4bDy4L/HObEJU
	 atLloV9ZV09h8ieTeDU8hlpDd3oZ9Yn7ycHR9OQzWtMWFfGlfjFCaA+gEDudeiZdx7Who
	 lHoAJbcmBAg2hpJEAtXeOG0Ys2lLxhsgWNp4xLhb89A+nxiGyNZ++6f+5xBQvMWb3FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b01Rcwgg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15F606A916
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E15F606A916
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b01Rcwgg
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so144804866b.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897086; cv=none;
        d=google.com; s=arc-20260327;
        b=Mul4SwjbRhHtpvGvDPhMwLLreC+KMHBgPZcjLJO7nlEK3jNYz+MTZ5O2qK3VtqiO+N
         jfjyH2MrF2t793ri9tjF8y8OlKD4VbJCJJnrL6mfHofLy5CsYla6DdKLC/5Kkf24RGJy
         7QSC3K1or3y2xh762MpxNi/uWXOlwL/scux6Qv0owReD0KbArrD04w3Mc3CqKayWS00a
         jV9/UD93XlUkl1h6C4ADaBbsB1F94h+yNilDe6iJQWeGiq0gfy0tJ4IydsBOtJ7Vsj3w
         7Q9KI1mAPzqIsUhHOKuXTpIqRKEypN5w4lfCkn5qwI+1vhigAf5LbDOG6HK4dpVhr42o
         hV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=ZqMiJDrBp9dqyb3cO42U+9O+NQ7NWtABCad+4xnCfR4=;
        fh=HfGCniDTQ5rOTPOd6YWusJN18hHyqkP7AvXkxMnosN4=;
        b=IXXIEkaEkO/bm1zQlmjm16mWH9GVW4Xpb83xG/yeITSj+VUBS7kO3vMSDdIDQZKXDO
         N42plsemdFjN7dNqLYHrQrcbcC218JQe00LQJCrclw+yJ9IHnMt7mwQbrrRuPY79kEhJ
         SLXho5jABfsz3QD/2rMFOlRjOkIYg+tHadvI791ZYygZhBAPdugcpgiu5CIQd8bugnzH
         9oNfYHVStB+qBwZ1EWXWnWiDEDxDINRN13Vlz3bJlhob4hXT8ikl0Ufnnh4k6JEqTnPR
         +U5hW+pNf/YYb55/BbIQuh3GjeolqFYPR3RXQHjjPI2y/c56JcJ5EorOKwmQm+/zpYlh
         O5Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897086; x=1794501886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqMiJDrBp9dqyb3cO42U+9O+NQ7NWtABCad+4xnCfR4=;
        b=b01Rcwgg4xzxHkoGJsC9MswRqBWrzkxTQNBAVtIkQfYjPLLvI2QKHgosecpsHrTcn7
         PI8eXrcMKe0WT3HnhXDNHZit3ibYF1yx0BNyXAd8u0UqPg3XtBYsJQ/5CF6/utvJrC+2
         V02saf/O3u2/Qyor9iPiSwa0zGX9TZYQFBfIR5sHVlzcxG1i6eAfa3wLJLzPu+OCJRQJ
         9voFjAokw76fxBV2dnOXVZDaNbm0KYp5/dSdjPDMlORXFdzzLk+WHXYdgsqXwd18jLv3
         ATgv17clGJnQmIyBQfYC0hSCMQq0Gr9gCoc7h6P/ST8O8rfRw3aitX7oDWM8U09hekDx
         mcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897086; x=1794501886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqMiJDrBp9dqyb3cO42U+9O+NQ7NWtABCad+4xnCfR4=;
        b=lz3lajfjD1wN4lyutjUzw9/1stVjpWVfahD6s0X9mVEZAAT1yJVSZ5P4D9ZiT7VqMb
         LMkrow9Z2mN23GH5Hu2RmKiTDRW9o7vzYTyUoCgBf6t9cf8Oe090c8SPfMQiN2iJZG8k
         2aF0MNyOI/sZppwiWJvehPzeSq1EUKHRxp+KEY1sXg5ebr6zKoCPC9gJmmWsNn82aMkM
         QWQOOohFC+GMhamuqKh099MRCsOGhRrRZC1eC5JjzaXlwLfCTlY6Gh7UZiDNxJfRXgvF
         Y2huH7mzDm/kX958QKSqOxPhcF3uQtiVDOV3FUZ+oA5memIkr0iwMNoOeMwDkUCZkeFo
         Wbmw==
X-Gm-Message-State: APuU4Z8vgfqPBPeXhHto8gZU97YeAxauZsF1fyVEjGMLTPc8r04afgiw
	Fiqnhl9OD50AvIFRk0qEqQMwvuTIykYF4NCBjbwLb/h4gm3qowNcKAb2NGlvgJVxps1W3SQaR9W
	lmlcPVLH2HzeHAwW4Wxc8EUXJZEjqpq4=
X-Gm-Gg: AYBFou2xonetKZA/zxAVUERKre+U9mE1gtIIlkXidftKSGVZvE/j4yW2nm+RSCLtyVP
	oN9YFDY2ptbdJVCC3cmvkgqsQN5hY1fBDf3JRKI8pVGmTpuZhd0TrLoPDrratLIe1h7dR+/Vhzn
	v+0HXvHCpHAgkWr9dhbrtxQbtVnWEb4X/POAvwnizAcuW8Tan+hXIxiWbf4xPNwRUgNDXsHLZ1K
	zZcTYpwMZjs3f0f+wJ+T/XzDtgnIrOYsG0mon+SApokWZ/W1pC3tZTGanPMJPSvWZDs8TWpNptk
	xwfSRnBUGb6nn6DMvdRgtjgM5GRtrLbeBjR81dEt0/9VE/fdG8wR5fhawMfzw0hAgUUaW/IprAf
	cKpvIvBx0gjBsrnEaTYTF17kYpm4xgNva0HChDUJhHAabHl9tELzgl1ypYf3tsrfVF0R7F2o7C8
	5lc9WbKwbvVFJj1a24cVDlvfgBVCLAmo2Teq7gNGicDvPzsIpMkcAgPf1KVHIl/0PQTlRTNOuDf
	y6NYf6kOKemzQZiVw==
X-Received: by 2002:a17:907:6d20:b0:c2e:204d:9490 with SMTP id
 a640c23a62f3a-c4d206eeb04mr289874166b.17.1793897086336; Thu, 05 Nov 2026
 08:44:46 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 08:44:43 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 08:44:43 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Florin Badita-Nistor <baditaflorin@gmail.com>
In-Reply-To: <CAL4WiirS2n23vb9qHUHX+xBWqjiiM2KzCoFR2dysEzdXrcFQpg@mail.gmail.com>
References: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
 <CADnh+D3nz5aehxjvurK+Fv7gF6n4csMm-dFatvdMmg1fWdGSQg@mail.gmail.com> <CAL4WiirS2n23vb9qHUHX+xBWqjiiM2KzCoFR2dysEzdXrcFQpg@mail.gmail.com>
Date: Thu, 5 Nov 2026 08:44:43 -0800
X-Gm-Features: AclHuK8kDXY8JI8yzjWMA1cEKLPpuiBD7I5EcwcGty_AjuJnIHOuzNY_Tlbm3_g
Message-ID: <CADnh+D3faqV0QBm5tnqpTCoU9ugX_5j0mbkzKae7GT0hhgOU4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: avoid false bind exhaustion with odd-sized
 port ranges
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> Please mention the side effect: with an odd @remaining, the wrap
> (port -=3D remaining) flips parity, so the first scan is no longer
> restricted to odd offsets.

Agreed. I will state that wrapping an odd-sized range can select ports
of the parity preferred by __inet_hash_connect(), while even-sized
candidate sequences remain unchanged.

> Also note that __inet_hash_connect() has the same rounding for
> netns-wide ranges, so connect() still misses a port there.

Understood. I will make the scope explicitly bind() allocation only.
The netns-wide connect() behavior remains unchanged; I will not suggest
that odd-sized namespace ranges are fully handled.

> This has been there since 2016 and needs an odd-sized range, I would
> target net-next and drop the stable Cc.

I will retarget both patches to net-next and remove the stable Cc.

> Both patches are mangled by your mailer [...] Please use
> git send-email for v2.
>
> Also, please trim the cover letter to the problem and the test
> results.

Sorry for the malformed patches. The raw Sent copies applied locally,
but that did not establish that the copies received by the list were
intact. I will use git send-email for v2 and verify the received copies.
I will also shorten the cover letter to the problem and test results.

I will allow at least 24 hours from v1 for further feedback before
posting v2 as a new thread, with a link to v1.

Thanks for reviewing the change.

Florin


On Thu, 05 Nov 2026 12:17:56 +0100, Eric Dumazet <edumazet@kernel.org> wrot=
e:
> Le jeu. 5 nov. 2026 =C3=A0 12:04, Florin Badita-Nistor
> <baditaflorin@gmail.com> a =C3=A9crit :
> >
> > inet_csk_find_open_port() rounds the range length down to an even
> > number but keeps the original exclusive upper bound for wrapping.
> > For an odd-sized range, the two scans can therefore miss a valid port
> > and return EADDRINUSE while an eligible port remains free.
> >
> > For example, restrict a TCP socket to IP_LOCAL_PORT_RANGE [40000, 40002=
]
> > and hold explicit binds on 40000 and 40001. bind(..., 0) always fails,
> > although an explicit bind to 40002 succeeds. Both IPv4 and IPv6 TCP and
> > MPTCP are affected. A namespace-wide odd-sized ip_local_port_range can
> > also trigger the failure without a per-socket range setting.
> >
> > Keep the full length for the scan bound and wrapping. The two scans
> > then cover every candidate in an odd-sized range, with at most one
> > repeated candidate when exhausted. Even-sized candidate sequences
> > remain unchanged.
> >
>
> Please mention the side effect: with an odd @remaining, the wrap
> (port -=3D remaining) flips parity, so the first scan is no longer
> restricted to odd offsets. For odd-sized ranges, bind() will now pick
> ports of the parity __inet_hash_connect() prefers.
>
> I think this is fine: same-parity netns ranges already trigger
> "ip_local_port_range: prefer different parity for start/end values",
> and __inet_hash_connect() ignores parity (step =3D=3D 1) for per-socket
> IP_LOCAL_PORT_RANGE. But the changelog should say so.
>
> Also note that __inet_hash_connect() has the same rounding for
> netns-wide ranges, so connect() still misses a port there. This is
> fine since the sysctl already warns about this setup, but the
> changelog should not suggest netns-wide odd ranges are now fully
> handled.
>
>
> > The issue was triggered while developing port-range selftests with
> > Codex assistance, then confirmed using userspace reproducers on
> > unmodified kernels. No kernel instrumentation or fault injection was
> > needed. Booted x86-64 KVM kernels were tested against the regression
> > selftest, the full ip_local_port_range suite, and a Go net.Listen
> > reproducer. The Go reproducer fails 100/100 times per IP version before
> > the fix and 0/100 afterwards with a three-port namespace range and two
> > listeners occupying its first two ports.
> >
> > Fixes: ea8add2b1903 ("tcp/dccp: better use of ephemeral ports in bind()=
")
> > Cc: stable@vger.kernel.org
>
> This has been there since 2016 and needs an odd-sized range, I would
> target net-next and drop the stable Cc.
>
> > Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index e56beec43..755fcea35 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -343,8 +343,6 @@ inet_csk_find_open_port(const struct sock *sk,
> > struct inet_bind_bucket **tb_ret,
>
> Both patches are mangled by your mailer (wrapped hunk header here,
> wrapped diff --git line in 2/2), they do not apply. Please use
> git send-email for v2.
>
> Also, please trim the cover letter to the problem and the test
> results.
>
> The code change itself looks good to me.
>
> pw-bot:cr
