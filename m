Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294311;
	b=buAes+X8qQWUrA2bOowsp8DTMHz1Leh/EvcEJo4q9niHpzNrCgPbC+OWMq1uyjPPAAK7
	 PONUwpzp2Tyyd16cihloN64MpragoIIRk1+KdQbBU5KCLO/mIxLrPRo/zNk80KHsuWogG
	 4R/V2Nmx7xf7ltRed7eRsKRzUzymBBBku8CXkGyaAKkNpDWZJF7YlE+a+rlxhx45jfL/p
	 v5Lo6sH9lIrxG29XoFIkziQgEAGD0zK59BwbXH9KmeK2kFD+Kdbx1Ajo9HVmHCL2fFJHN
	 +PBKwXxPZ6eM59YA22/QJ0YobSkjmFl2CtaHpl5BlFcEIMVedJt3hI2RelE6/A1EPnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294311;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BnNedezTioyADzuMpCOdCnuZokX80G9WaFneDTb10vQ=;
	b=jWgcCVLGWJ1DpqmaqD4SVGWulouVuU/ualOGQdVefwb3risGTGDtjc+Br8lA7Px/vl4G
	 P32cGtOGsU5yu3S+SbAd0Z4Ftg3QnbYXReSAQqpxFrTn1d0ikTq/GFSmmJ64MVBkAgW5c
	 HdGii6CJzA2mdssI1aCswyK9Nuhk02THemJu7KU8oZBiA/D+T0mpwtEz+l6uEj35tXQC6
	 IZg017OqWJWr2XCmIouulukTc1u00q8urZjMPMWVCITyKRzz+pNN0saudlvEFFT4eJ4zB
	 n54ji+8AN+YGDntlEHk6dKvhjieV/+6zdY+DBW1LIrPKc0V08GzKBPwqtRVpHI2Phiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofIwHVx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A4606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofIwHVx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C7A1F008A3
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294310;
	bh=BnNedezTioyADzuMpCOdCnuZokX80G9WaFneDTb10vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ofIwHVx8MbkgSNQVhfD72a+9EIzFn9QH/Ap9XuqX+xMBd/RDeIfHpR/hHjj3tRcMm
	 lm7INK8ZwlFm6I6yTnJdORYxrdlj+FjPyf5Hr51UDTCmcd1xhoCFiJEYbiyE8VFBGl
	 RdjeWt1LkEScnrP2YeG1s1mMUVFLBuqM55plz7yVN5Vbni+hzMzk0eGN0d6wQaQBLo
	 3ac1wUXZUzTtaXupzznW6q89QWibbxEJGFX9DUpJ4sacp8PBfQJ5Zn4vnKKAK4h3K+
	 usZBLbjJ30SWnbO1BiAdplljz95OGEMovLnKr9xy7o+9yOwGA+WxSJcfXfvoxTBIRW
	 icZumDJwQV/lg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-7190d9bdb2cso47269eaf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 23:05:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFjq14WhTYtbRroVTPs+nbENI1YcTgQDte/OEopLIi1hjDYXsUmMtZtfneEBNpvMJAdfoGQXBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tYvOVvpseG0vuVt8wVjuWRBdeO6o+MU+yOHiEOyjin2nbICDn
	Ij7JCIdU7epP8G/cNtPDNnQnbCKaKtObPMmTKS9vZfWqX7vQALrOHjuVeidk0p3EZxbJxal7mHb
	7VBqDP1ycyfKDK3VphXS2crkBP7c4Spw=
X-Received: by 2002:a05:6820:240b:b0:6dd:9701:6305 with SMTP id
 006d021491bc7-718a6e2ddd4mr641568eaf.65.1794294310126; Mon, 09 Nov 2026
 23:05:10 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106171442.31811-1-baditaflorin@gmail.com>
 <20261106171442.31811-2-baditaflorin@gmail.com> <avK8iXcNfXSt1_CQ@google.com>
In-Reply-To: <avK8iXcNfXSt1_CQ@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 08:04:58 +0100
X-Gmail-Original-Message-ID: <CAL4WiioPRW-SxsKbOC3aOtZg8ZJpA28Xva0qM4375cTygfVHgA@mail.gmail.com>
X-Gm-Features: AclHuK-NJxidM8lNPtjHGZ7TEVWKZvAA6snjm_p1ThNmdP7HN_Zn2F8YrWLmn4I
Message-ID: <CAL4WiioPRW-SxsKbOC3aOtZg8ZJpA28Xva0qM4375cTygfVHgA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: avoid false bind exhaustion with
 odd-sized port ranges
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Florin Badita-Nistor <baditaflorin@gmail.com>, netdev@vger.kernel.org, ncardwell@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 07:45, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Fri, 06 Nov 2026 19:14:41 +0200, Florin Badita-Nistor wrote:
> > inet_csk_find_open_port() rounds the range length down to an even
> > number but keeps the original exclusive upper bound for wrapping.
> > For an odd-sized range, the two scans can therefore miss a valid port
> > and return EADDRINUSE while an eligible port remains free.
> >
> > For example, restrict a TCP socket to IP_LOCAL_PORT_RANGE [40000, 40002=
]
> > and hold explicit binds on 40000 and 40001. bind(..., 0) always fails,
> > although an explicit bind to 40002 succeeds. Both IPv4 and IPv6 TCP and
>
> This is the reason of warning in set_local_port_range(),
> so kind of WAI to me.
>
> The change should be fine, but we should remove the warning.

I would keep the warning.

It was added in commit ed2dfd900992 ("tcp/dccp: warn user for preferred
ip_local_port_range") because connect() wants an even number of ports.
This is still the case: __inet_hash_connect() rounds an odd-sized netns
range down to an even size, so connect() can still miss one port there.

The per-socket IP_LOCAL_PORT_RANGE case has no warning at all, and
bind() can miss a free port there without any hint to the user.
This patch fixes that.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
