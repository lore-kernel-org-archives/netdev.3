Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636071;
	b=vdt//yNHgBMDlI7u9NbfN7Lu2rzfOPyUl7MbgEA/huWQLCax9qfFvlhNED6cW+ohU4re
	 FfTJnk0iG7QH4L/NBcmbGqS5LQ+WuBWFCRnLZ4+YdNml/YmzKa4M0HGw12pZihkOgRrl4
	 MBfS2PnDeBpMvSteXryDTQZ0J719FpJswUzlc/d6NAK9UG7PiDY3t+9HqF7/4SxfQClQK
	 yJDiXR2PS/LHXkKHY4SzMCGoixztQObYpjdP9/ZKcubrbFNwzFuWqmJF29OFfHFnVneH5
	 K+dxrj1D6bQuvaQyM8f97i7jImy0g1uYzjQKDVBvBaAi5AWhALPW50bfa5tF+npGjAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xq5JtlRc0bd7QYpBrNP/yR1XPt2PV3UUDwsNUvNWTIw=;
	b=E++Tsnq7JIQT8MU06E3tTD5IoCS6XQysTsaSZ6jAPaaWh6ZkKJa1PdiKpHNsr97dXH/o
	 GqEvyo2mzgpPdsgqGuN8vvHNEf6Zdx8Rb0R/jw8JjT6lbAvCE5Bvl7juV+Ux5ieChliSw
	 pXAgSy0GK83sF1H6GO1Doste32TDl9NYUtaP7fKvQVmpazfuvLxWv6x0Eb6feqVA//0JW
	 UjP/po6z9QgBXTy7TtFMSpq86OcFWJThjMuyOzIEDoqvHeBmzi9FtgPag3EFYRSj/K4Tf
	 uHrECNYondEjPRZkIpu6BYvihglgWFv/tRxObnzjHmw45q/zXV8FVhYFuJsMm6jO+zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+Bf4sh;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BC606A910
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329BC606A910
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+Bf4sh
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso21317255e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636069; x=1794240869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xq5JtlRc0bd7QYpBrNP/yR1XPt2PV3UUDwsNUvNWTIw=;
        b=AJ+Bf4shabMyjTIBY0O+LXPatqHnqTS127UhZsQaTlHtowQdrqPjokyL/XjHXYqMlt
         GeLKIB+MzYbgoous0JoqPyEm2FI4uoff4cfGT/jdnGCjay7a8NtdzyaL2onq1O5/xYxh
         b7ujNy0qFQbVKpr7C7+6l3VyLTbF9V/XXxfuG/EwdP4ciaQkhq/RPT3njAxQL9+g2dud
         KmdPujr5WcSbefxjEXprbRnrQN7Bxdyiz3GTgtBIlsqmTsqBvi8yHDoeUwVXcDwoMCZ5
         NpmpLh6QNQtIYsbvFn0j1gjx3URsAcQa4XRTHqISfUswbiSx1KM0p0AtBmgSQkCsrdpk
         MxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636069; x=1794240869;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xq5JtlRc0bd7QYpBrNP/yR1XPt2PV3UUDwsNUvNWTIw=;
        b=RPfP20umAoWEm9Hpk3Oi+5VyWhno1mjXT7iDKciODBDbP1A8obnJPmEQbKUPHpzKDT
         AVpbc+NOsXVyBCdTp5MpVeJhJ/AtaVkXWVIQ0BruypqmfIk6ggBM/b63fcpySi63EAAk
         FVp/ltBcbsRFMyQT9I+Ky1gjH31tV9XvCo3pJ8P5MfL/DuSXGjKOawG0Y1Un0PCROKtS
         ySnotKXUed+NKUFb5KRjqakuNBAP/bNmxZZsSyo1LQW0CLtaH8BqdGsrHGhGNX6vbQbY
         zePnv8/H8ASibwx4vlmFWK/cgN8lLEOWhgHx4rxPfQpWrP2oVc45VjES1gNzBX1iu74o
         0Lvw==
X-Forwarded-Encrypted: i=1; AKwUvBwLkBkUWCwbGFpLDcbyyYL0bH5KO+dBTOf1S5072hPd2/l781h8Y+dsre4vCSnTTK2d0itT9O0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PaqN7K9760GkeJ+GTnxXPSMa3ix/YTg9AjNK99wP8NKLoK+up
	VgQy2ptS0Sf+YVaBTFYMRRF0WXsRBBUT3hS3SvO0L8xMeSCEFrYsQqVG
X-Gm-Gg: AYBFou2a/2e7DKOo8vmAh4GPgiOaa/aPRX3DgRc6Tuecq0Ly9SkzOVkY1Zj7YSY1uOg
	UnqGviQe6BAAbwRUHWX0z+dTmeC/Ky//PVAry4uC4TsV8mn2CEVpMhCcwwq5WsuNRmMC1C1xciu
	pGQWJev1g58bDndh04BTsXAVbJ4PEwKO+XFPL7bRTxylmBWqF/oAe5G2HNMsm1LDzkX9nyc4mWp
	FQs/ka1mon09AdbxyB4u2NE25rznx/UaEHuQPZHDUSyjonqhI61yRLmJHiCqpB5DXaFGs6YtXXI
	1fCaPck8fCmmOjcefqK/90+G+CBw7HnJIuHJsqBJ0Z+23zISMHO+9SnSJ+5Di6yUJSjkSamEPfN
	/omdKrmOIbCvJ/a8Rmi/dR4/wgS6EMCDn5emHNgoKPdQJf/a3DcsMwN8Sag7NMRjqo6ZGYX0xjI
	hP0iWmau8Sp6PLSrpwrGv3/Fw1i+2qOYflqfUi7Gy59sU6XFbzNtrj+GhUOcm3aBuchn/kePfk6
	9NFEQzZrrX1fTEdnqDpco7JvJYrBh2rqcNNjutA5Yjh6JLHz4T8iBi4s+iccnY78kgaNKTgjGZj
	9rOaSEtmryGGaQqEb7l/emlucWbk5sf/PaOTJOVkynnxAvJMz79S6Aai24zvsa4e
X-Received: by 2002:a05:600c:c118:b0:4af:79ee:f660 with SMTP id 5b1f17b1804b1-4af79eef775mr111736695e9.31.1793636069327;
        Mon, 02 Nov 2026 08:14:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm267629925e9.0.2026.11.02.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:14:28 -0800 (PST)
Date: Mon, 2 Nov 2026 16:14:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Demian Shulhan <demyansh@gmail.com>
Cc: saeed bishara <saeed.bishara.os@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, Ard Biesheuvel
 <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David Gow
 <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
Message-ID: <20261102161426.2403d308@pumpkin>
In-Reply-To: <CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
	<20260927184414.6c0c8867@pumpkin>
	<CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
	<CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
	<CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 16:14:06 +0100
Demian Shulhan <demyansh@gmail.com> wrote:

> > The scalar path seems like generic C code and not restricted to arm64,
> > curious how that performs against existing (e.g. x86) assembly
> > optimized implementation. =20
> Depends. I think __builtin_addcll() is needed to get roughly the same
> performance as the asm version. In my tests GCC on arm64 turns it
> into adds + cset instead of adcs like on x86.
> But I will look at it, thanks!

The C version I posted earlier has the loop:
    buf +=3D count;
    count =3D -count;
    sum =3D carry =3D 0;
    do {
        val =3D *(u64 *)(buf + count);
        sum +=3D val;
        carry +=3D sum < val;
    } while ((count +=3D 8));

for aarch64 you get:
.L4:
        ldr     x1, [x0, x4]
        adds    x2, x2, x1
        cinc    x3, x3, cs	# adc $0,%rxx on x86
        adds    x4, x4, 8
        bne     .L4

I suspect that is close to optimal - especially for fast cpu with
out of order execution.

https://godbolt.org/z/eso79K7Wq

David

>=20
> =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:=
44 saeed bishara <saeed.bishara.os@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gmail.c=
om> wrote: =20
> > >
> > > I would prefer to keep only the scalar version of the fused copy+csum.
> > > It reads the data once instead of twice, and on real Armv9 hardware it
> > > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> > > depending on the core (+6-8% throughput). It uses only general-purpose
> > > registers, so there is no FPSIMD state to save and it is safe in any
> > > context.
> > >
> > > If you are OK with the scalar path, I can send v2 with NEON dropped,
> > > the scalar path only, and the KUnit fix for the x86 zero-length case
> > > Jakub reported.
> > > =20
> > The scalar path seems like generic C code and not restricted to arm64,
> > curious how that performs against existing (e.g. x86) assembly
> > optimized implementation.
> > saeed =20

