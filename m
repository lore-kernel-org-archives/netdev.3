Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745530;
	b=iZ9MJaMEmiXKOLE5zaWcvQ6cGh9e/bzmTPPp+Cx2Dq+OwlWbL5WatoacDyohIVRwMblA
	 h/79WxXZIVviLPoLAS1OuXekPFNkDoXLUvxoRkkRuUoNZXGKfF9BpSiwZ10x5wWgLUkXI
	 YnewNy5YU+0cI7ZPBE3UgTOz8v3PAW1MIOI1+GcCpeE7sdgQ3oQ0zm/Rc5ZDgPnX9HvQz
	 Xw3g+58pHbLF3avEfl+frJwywZNnnmrSCoQ6fJAmZZg6igmkHbK2TZpL3H6a5aF5vggZ7
	 kt6PLu4oSrZkk7/If8nIWxnkMfpASWQH0bxQTGu6/CL48WY011DhW6FvKaiJkLKmCEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7Y4hWEy3KCqBGcgLZyC88t/BtG1nVv31oLpGNCBZoVw=;
	b=xItPrSKeZSslft2QBAcWtw6cTMUCRwxzbBQHi6YhmT8+YfdxG0Kzymb9Otn2K2/Emypf
	 Z0TDVzSJv98gm9dZfy7JuavhWb4aPxLMLZ58yfi9f9q5TlZW/xAoj/uBK4ylwMMOT3RAu
	 oGoxKmwC72TjRqkz7Utl2YhaMKF/wEBVG0pzo4/DdSJvST4kUl/G2TRNUQU1lmnpL+ofe
	 zUwDeMye6eUSq5pNIdEMWmYq70b4Yjc+Ge0sZANiI/5hV+QITVjh9fNAIbZEMVvc/EifF
	 VK0JkTqP61hCdUIl+AqVWEsB2DZ9iLzRm1sy+1QW87nKlAPhlHPOTgUb4e85M+/FY7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q83QGk6Z;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A6606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313A6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q83QGk6Z
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so66915e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745529; x=1794350329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Y4hWEy3KCqBGcgLZyC88t/BtG1nVv31oLpGNCBZoVw=;
        b=q83QGk6ZlvK41Xnj9VYjDJsaU/LVIlKY/O3UTOsd7cHawXlaokPl1p1agoBY/5nwQg
         uPzkJbtm0E91Y8sCbX76cPRL3i6SSTUKoXzttrTc/gWurMr2GWS0k5ylOm8PFozwb36o
         OS3bFPXf8wE9XoVm/Dw9eCQmeqCwK0ijKk3mbqWteVs9IzoU8g54pTAHJRaxm52hAkiu
         7twTSt9UNnEzbw5wK5y4pN3/8W+5ruU9wDD555aCgwBySzZ9UMbSQ/4Vj2g+AHO5WIHz
         uHru3TjxC9/+VhraivLgz3IWOjs2cfBPVSktUTxcdqSG/kW/hrbRL1LEOapw9UlMVR/o
         lXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745529; x=1794350329;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Y4hWEy3KCqBGcgLZyC88t/BtG1nVv31oLpGNCBZoVw=;
        b=vI4Dp6fT2QmniK0L6umQHTpyRkAizQTwuos01BwPRCt9yq42AWRW4MBn+L139TsTSn
         1rX9oT12OnAWLgsCerOD4ggkGJ7Jzj+pLxT/SauAyXnoO9FTEPYYheHB8BvcOjtEdWpi
         VJRPBxURweSNIQ9DOo8k60LEuJxGXUQIacGKqPDim5B1a83mXW/OYLdLCJueoGu33IOf
         U6WIG61nj9qntfQCc2rUT2iEDTt/KmZYpNhfwHYsDylhYOpQkN0OA1klsPGsXb2rS2VL
         IkPXqlAyCUmjG+Tb/dgS4FJodkRnZ0S9o1TD70rdwNl9h3wSoVD34d4sxm9EjOumEohC
         I/DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG3zpS2KXxV/poQZYiE20d9FvcYD6ut8n+bMaKmDEE4pfxo788VS+nGK2vtcTy9Mlq24bFsWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pJEzo8mfDZwuIPOHoZ01TohhoGgdfHvf21NuDIYQytskhhorZ
	vceRbZOVCG0ANjvQQHLv1jGl1kwuqV4q2mCQN4Q3hilymXjgisL1hwDj
X-Gm-Gg: AYBFou3Mdmq15NvDThQzIi4VWAsMTZ22/mz53VOajuEYAggQA9SMuTaMePkPhtpy86T
	9oyvxjYmf/cqhZFI0b01r9/gDpwj3QcOQKHn0YVe6tbKuNbkkRv3D5El+rCtiLAboyRqpT05bn+
	yUTKXIDa2Kyef+8j0f4GT+DoYljIPdUeEWqsEZJQkm4ewaVPflscXfX6YWKQMEUTDxxlJ4DBGWj
	jlUCcI6H3hvtB+wv9k9ZiQndrpC1upHpTaA2WAORX42B6sTSA9+by0j5WK73e88nij2taYP7Oq7
	TAGhkIYNrrQWPEh3Bz/8YF6Nu5xMhqG0igRFyVQe8sGrpEiqhvAyi5Y9mao8lUAcnxWU0rG6fNs
	pfrhULvIANI/U7LrBNohbnEkPvn+Wz6ciTiHpvTOhQnwH0xguPYxYRDM9VeNXJMYjF/k8zRgw7p
	Csk877KwYCb/wONtD+o7Xmjj7X/atOFKUiAotFKn6K0L2Qh6MzWQN7ru9vkHWRLVJzjrIu0pa6j
	igYBZdqs7WU9MnrQOOTyGW6qzJUApkPBO0krJd9A10TAqeCwCvoceNSmqFCES6vv5IMXBhLEeET
	weShfEM/X9woPUKxIJH2tbL/fC4RE1AQa4jLMMiqpQh1jLTjglZvn+ipW81+G2gQT5k0bvU43MR
	2XMyVwMUHyQ==
X-Received: by 2002:a05:600c:6555:b0:4a1:d45a:3ae9 with SMTP id 5b1f17b1804b1-4aa8b05fa4bmr341420665e9.15.1793745528451;
        Tue, 03 Nov 2026 14:38:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm467832f8f.6.2026.11.03.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:38:48 -0800 (PST)
Date: Tue, 3 Nov 2026 22:38:46 +0000
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
Message-ID: <20261103223846.5e6a1dfc@pumpkin>
In-Reply-To: <CAOLeWCviRtGMhGJQx3HHFQOze439576PQqr4tmvjGkMMfYfcog@mail.gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
	<20260927184414.6c0c8867@pumpkin>
	<CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
	<CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
	<CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com>
	<20261102161426.2403d308@pumpkin>
	<CAOLeWCviRtGMhGJQx3HHFQOze439576PQqr4tmvjGkMMfYfcog@mail.gmail.com>
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

On Tue, 3 Nov 2026 16:47:29 +0100
Demian Shulhan <demyansh@gmail.com> wrote:

> > .L4:
> >         ldr     x1, [x0, x4]
> >         adds    x2, x2, x1
> >         cinc    x3, x3, cs      # adc $0,%rxx on x86
> >         adds    x4, x4, 8
> >         bne     .L4 =20
> Agreed, that is a nice loop for the sum-only case, one dependent op on
> the sum chain and no builtin needed.
> For the copy case I tried the same form on x86 (Zen 3, GCC 15, Clang
> 19-22, -O2) with a store added, against csum-copy_64.S, as posted it ran
> at 0.85x of the asm with GCC and 0.73-0.76x with Clang (which rewrites
> it into setb/adc), and ~0.8x unrolled 2x/4x - a bit slower than the
> posted 4-accumulator loop (0.88-0.95x).

I just added *(u64 *)(dest + count) =3D val to one of my loops.
gcc just replaces the 'add from memory' with mov/mov/add.

I'm now confused though, I seem to be getting different output from earlier.
With -Os (which I didn't think I was passing) clang is refusing to do the
'offset from end of buffer' loop.
With -O2 it bloats everything by unrolling 4 times and adding lots of
extra instructions.
(AFAICT the optimiser has a completely incorrect cpu model.)

If the compiler doesn't generate the expected code it is all pointless.
The xor parity code loop had to be in the asm block to stop the compiler
changing it to a much slower form.

For the checksum code I have managed to work out how many bytes/clock
the code was generating and getting it to (reasonably) match the expected
values.
But you have to use relatively short buffers to avoid D-cache effects.

David

>=20
> =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:=
14 David Laight <david.laight.linux@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>=20
>=20
> >
> > On Mon, 2 Nov 2026 16:14:06 +0100
> > Demian Shulhan <demyansh@gmail.com> wrote:
> > =20
> > > > The scalar path seems like generic C code and not restricted to arm=
64,
> > > > curious how that performs against existing (e.g. x86) assembly
> > > > optimized implementation. =20
> > > Depends. I think __builtin_addcll() is needed to get roughly the same
> > > performance as the asm version. In my tests GCC on arm64 turns it
> > > into adds + cset instead of adcs like on x86.
> > > But I will look at it, thanks! =20
> >
> > The C version I posted earlier has the loop:
> >     buf +=3D count;
> >     count =3D -count;
> >     sum =3D carry =3D 0;
> >     do {
> >         val =3D *(u64 *)(buf + count);
> >         sum +=3D val;
> >         carry +=3D sum < val;
> >     } while ((count +=3D 8));
> >
> > for aarch64 you get:
> > .L4:
> >         ldr     x1, [x0, x4]
> >         adds    x2, x2, x1
> >         cinc    x3, x3, cs      # adc $0,%rxx on x86
> >         adds    x4, x4, 8
> >         bne     .L4
> >
> > I suspect that is close to optimal - especially for fast cpu with
> > out of order execution.
> >
> > https://godbolt.org/z/eso79K7Wq
> >
> > David
> > =20
> > >
> > > =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE=
 12:44 saeed bishara <saeed.bishara.os@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:=
 =20
> > > >
> > > > On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gma=
il.com> wrote: =20
> > > > >
> > > > > I would prefer to keep only the scalar version of the fused copy+=
csum.
> > > > > It reads the data once instead of twice, and on real Armv9 hardwa=
re it
> > > > > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> > > > > depending on the core (+6-8% throughput). It uses only general-pu=
rpose
> > > > > registers, so there is no FPSIMD state to save and it is safe in =
any
> > > > > context.
> > > > >
> > > > > If you are OK with the scalar path, I can send v2 with NEON dropp=
ed,
> > > > > the scalar path only, and the KUnit fix for the x86 zero-length c=
ase
> > > > > Jakub reported.
> > > > > =20
> > > > The scalar path seems like generic C code and not restricted to arm=
64,
> > > > curious how that performs against existing (e.g. x86) assembly
> > > > optimized implementation.
> > > > saeed =20
> > =20

