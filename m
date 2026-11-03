Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793720863;
	b=queUdhwsU3eTXeDH05LKyfi0Z7fn88F6Gn1Gh5tSWzbc02CAUFjdjqmBLR8v6MNsaaPP
	 ROzLk1UdOO2LZz+9BqyFEFmh5rfmbCDDczXKRRohgptrQA8MZ/5ZidbH/sP2a/Pag5N4P
	 pKIsjP92xDoLBNizRpRiR/zFPZ2/OongUMJp7iHZ/59BKH/j66RpnjsEs+L5bDjCBhBvZ
	 rvnQHbaecA4fZdMc+9P4WH1U75kAimtrCchMA+g23LqVZKm86eGz9DZSUMLFIWukFMm7P
	 glchFiVZi01Ipyj+2W8p2YX6FvHdUJmbCVfpXFRNqZh6NxS0kuKDC6486BbI967eP8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TeMclKfCDNmL6wdCZNtIoHpg1BgrBEBrtRcEWNmtqAc=;
	b=ypIVTK/VWp6zsN5YPFwr2kUQevqAMgFj/N3WpgSGn0o+Late5K07WlOo+bAMixXbgJdA
	 9S2GPZDvJR+6QejOtmcb1P4/ec9oWqAlZo5X+bGFPvoGnpIcy7ybM0EmaSX2q0dXGS0If
	 voth4n8sfRItIcycC47R888dWx8+aUK1uJFMcWTeTm9WAzXKqiF4OnyNMx4HTh07JIcK3
	 rvfNvX/1t/Sp9r4zYHNxnRAk9p/nvZt7NgKDrJdbsk5XAt/mIVFk98F3Lqql98CxoJTMt
	 vz+OG+zHuaDBVeBqT5c2P9WlmlLLsnPjk8H6FBmlD7T93qoCxIhu2O0YtLevaNqX06A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B/c3T8k7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DB606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 889DB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B/c3T8k7
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a3c08d6928so5497395c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720862; cv=none;
        d=google.com; s=arc-20260327;
        b=ixBM0xUNvP5URCuGcdyno4YrLpzFY7mPMjKFArW9vCqJ6xB0dfkhSBYd+SczEFWfHi
         Yoix0Dp9AbjTOQxcb88rnfTPNjuW47Jig6XtXjdF+cyrAw5IIIu52SWVzHc8afKextg0
         jZb43nqzpqFkX1fsgb0ziibF0eU/gLG3heF6kj0kVA+St6CRkKznfPn3PZC5zDwyKkYR
         0FYjj9+nP8g/6YuFfIvnJo8OGbwYVHeON4BcJw8VnqWWPmPo8DQCcVdACGTr4npRUrcB
         z3WLMZFYHKO8VT7Pm9XpYu8I5wOvm6eo31wPjw91CZ99TUhE/l8raE68oFkmLSVgXPOS
         xQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TeMclKfCDNmL6wdCZNtIoHpg1BgrBEBrtRcEWNmtqAc=;
        fh=MJrR4gq/dqYxL62hR0CB22gnmYGJ0vD8MxDd0VY+okU=;
        b=rPwkCukMwgGKRLrT0ZiN05zAx9RiqHmDG/N4amNhX2RD7FhrHs+nGPz9axWa0ZzQNQ
         om4PHeAusb4UW8y6+vZLGLK8HWgren+W+yDy2gEDuJGPqbaOnzEIUSs6yLK1jMFo01x9
         ppMsbBMHItMY8yRc9hxiS7L7DzAkauR+CUUhYcu5eTr6xtb3e94c0Fu2rcmr43eogo6m
         krBTtC8EnVNZiU3kGgKOoGm3CDyXLFFSntf3FVHLImLsWAnVsPvnYl88ijUvNJAKwD/p
         LK1472YcIwU4dliPyonLd0xTSM9at+Ej7N8Ivx220gAaE3lTyx3ficxkFq0KiEdGJjmU
         d+HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720862; x=1794325662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TeMclKfCDNmL6wdCZNtIoHpg1BgrBEBrtRcEWNmtqAc=;
        b=B/c3T8k7H5BbUta+CbaRgPkU3gbwEsec46DGg+fL3CT5C522daaTEl0s3aKiIbuRqZ
         TwHgvkQNS7HyHwgruGAIg7erWMgXJQ6MX7K/isAFDJrzSE4aTplna7Cg/1lhGKQV+T9P
         mlRMYD2kkrETXwLnrR4NIAxBMUpOBUb+um6NzVlTLjWM6v/AyLJ1tVZKNhK4ouAwF/6b
         1kUq4iveBjd02n3FjMQG46bWOeGXHF91u/CmvMl9KpJb8OrBklAkli7dfNqYNKCL5YSv
         XuEVnfrYStZvDZo6KyrxN8kWkBYpVQFZy8jvImYZSdL59MzZI8UV/KwrE9SLwu1vMEeS
         NUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720862; x=1794325662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TeMclKfCDNmL6wdCZNtIoHpg1BgrBEBrtRcEWNmtqAc=;
        b=M1cLU7ZJnZfYzPWiTSQZcPoq7DmT2Bdjfn4+xy7a3UDJamgY03N5DZC3GST4PFVOxA
         EDu+YYFPSYY+erikRvDQX2n2jcAfNZEJznUZGo6VLMPHUEgf9JsyLvNDjD9bEBwj/IJR
         cqte+3XAm26drhC8jGuFdHlaBsqeWsADs0ARgRcprYtyJkKvgY28YHG/+mOLd3Fbpa6/
         nrVGGJxDpVmTwTTSJVui20lCu2vCjCMAN27KTZoNPI2DRFqGWmSF3wwPVBvlWhFiL3WB
         PnCxRCFFYWE8WgEmal/HzlAc/2ZMstv1qbJxJVa2GEBKGB6jSxmtgnCvNO9VlQUt/34V
         R64A==
X-Forwarded-Encrypted: i=1; AKwUvBxrWpU6CIDV5kTx2jfJWZ5ww8E++5BWx1wnnu1pDKHxTFAjaWYStJ19b0kwmp6jXCayy6291os=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YmAllc+yp6r5t5oWsFhp1UGr7Tjx346vEZw5ikM9mYW1unpPS
	QkzgpPcF6gP9PdXTUxHzxd25Xd0yE8cQHvXu2TpjGSID+L5LfZvCMaWzjq/7KGtS10XRtiJt0tU
	Jcedx5/2Y8QVr8kgH+OZwMF4PHgzkhEc=
X-Gm-Gg: AYBFou1M6RWvfjAmZdm33k6KUQOHDSOFgIhWGSL44FYZvBNpJ31p+Qon1sOimHBTh54
	W+rQtecCN33rq6f3ycrIrPij0Y5JVvUUEvz2mlnMNaGFu1ihUPlDwQbn4hMP/4OOdJVJijtu5G1
	ANCUnpfB746vbeCuX+QsMuTpRdKg/DRqG/o6BXfrBd5nY4N+5G8I0AkMXq4xy+2+bYhl7lQynr9
	74bmgHh/f2u1YKYLbSzuI+MbP1KV7mpPqn4sUPJJkUJicEQSwDmaruVhpk58jyGTmeUh3jvE8Y3
	0Dc8eyz3f/BKZxegNXIlmBTJrqFoWZPOhhOa9da6nZF0k4JfpzuyEglRvu020ZeNXd/CqBo1VWS
	0z4L1K59taKsAAgLwGvDNLd7clyZ/F9PoV8gojjfNOHGuU6xHHzzZfcw5Gb7poJU5thqS
X-Received: by 2002:a05:7022:3f0d:b0:18a:8164:ce4 with SMTP id
 a92af1059eb24-1ac4fb0c60amr20787898c88.0.1793720861540; Tue, 03 Nov 2026
 07:47:41 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927131838.6774-1-demyansh@gmail.com> <20260927184414.6c0c8867@pumpkin>
 <CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
 <CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
 <CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com> <20261102161426.2403d308@pumpkin>
In-Reply-To: <20261102161426.2403d308@pumpkin>
From: Demian Shulhan <demyansh@gmail.com>
Date: Tue, 3 Nov 2026 16:47:29 +0100
X-Gm-Features: AclHuK_ib7dEyaiKe1UK4pPwMx_v8L7eBFgO0-a0RmurEZQOzqGEC7L3Ybfd7oc
Message-ID: <CAOLeWCviRtGMhGJQx3HHFQOze439576PQqr4tmvjGkMMfYfcog@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
To: David Laight <david.laight.linux@gmail.com>
Cc: saeed bishara <saeed.bishara.os@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Ard Biesheuvel <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> .L4:
>         ldr     x1, [x0, x4]
>         adds    x2, x2, x1
>         cinc    x3, x3, cs      # adc $0,%rxx on x86
>         adds    x4, x4, 8
>         bne     .L4
Agreed, that is a nice loop for the sum-only case, one dependent op on
the sum chain and no builtin needed.
For the copy case I tried the same form on x86 (Zen 3, GCC 15, Clang
19-22, -O2) with a store added, against csum-copy_64.S, as posted it ran
at 0.85x of the asm with GCC and 0.73-0.76x with Clang (which rewrites
it into setb/adc), and ~0.8x unrolled 2x/4x - a bit slower than the
posted 4-accumulator loop (0.88-0.95x).

=D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:14=
 David Laight <david.laight.linux@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:


>
> On Mon, 2 Nov 2026 16:14:06 +0100
> Demian Shulhan <demyansh@gmail.com> wrote:
>
> > > The scalar path seems like generic C code and not restricted to arm64=
,
> > > curious how that performs against existing (e.g. x86) assembly
> > > optimized implementation.
> > Depends. I think __builtin_addcll() is needed to get roughly the same
> > performance as the asm version. In my tests GCC on arm64 turns it
> > into adds + cset instead of adcs like on x86.
> > But I will look at it, thanks!
>
> The C version I posted earlier has the loop:
>     buf +=3D count;
>     count =3D -count;
>     sum =3D carry =3D 0;
>     do {
>         val =3D *(u64 *)(buf + count);
>         sum +=3D val;
>         carry +=3D sum < val;
>     } while ((count +=3D 8));
>
> for aarch64 you get:
> .L4:
>         ldr     x1, [x0, x4]
>         adds    x2, x2, x1
>         cinc    x3, x3, cs      # adc $0,%rxx on x86
>         adds    x4, x4, 8
>         bne     .L4
>
> I suspect that is close to optimal - especially for fast cpu with
> out of order execution.
>
> https://godbolt.org/z/eso79K7Wq
>
> David
>
> >
> > =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
2:44 saeed bishara <saeed.bishara.os@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gmail=
.com> wrote:
> > > >
> > > > I would prefer to keep only the scalar version of the fused copy+cs=
um.
> > > > It reads the data once instead of twice, and on real Armv9 hardware=
 it
> > > > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> > > > depending on the core (+6-8% throughput). It uses only general-purp=
ose
> > > > registers, so there is no FPSIMD state to save and it is safe in an=
y
> > > > context.
> > > >
> > > > If you are OK with the scalar path, I can send v2 with NEON dropped=
,
> > > > the scalar path only, and the KUnit fix for the x86 zero-length cas=
e
> > > > Jakub reported.
> > > >
> > > The scalar path seems like generic C code and not restricted to arm64=
,
> > > curious how that performs against existing (e.g. x86) assembly
> > > optimized implementation.
> > > saeed
>
