Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793878927;
	b=IhPKSDgVe1sVtl+sOawL5C1Ba4m8vLeUHXYsSoJlegbry5ijH0tsIfloAwJFnzsavs5L
	 oBgffJ7RTjvaa9YQY0UJh0vQJbA7v+m7YQhksMyjiBiZqeOHqExa8QRX5ppPR/UfslmnJ
	 evsyowWcgGyULvDuISeUv5pLhyEiImoxa4oexuiAaLXp1C3d6eP/t4bqijF1b/smlTApH
	 4+opbPjCAZGekBswcNCOmeMqVIkp75mWDwmVPREjbTjRI1UeA/9brkjYvE53s0sr0DtLK
	 aknK+gHftd19RuaxvbxqG6bJN+mlF6tcKKE+71XMis3gWME12c6C/iVYrbD57nFadRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LZy2AlGoHMhT5kSino03X+cU+0j9SA9toGXagMkx2FA=;
	b=ra2B9DZpAH+OVwNdEocbl+sDtIP2NLUjlUSf/3eN5oEs1Tg/ycksMRmX3ZhYcELfggRe
	 s59/Q8VOMcXONf+XBOwtgYsWq69H35TxRvDr2/8PRp2ZGPVx6LmfD4WOhMTIVJpy+lJVc
	 quXRc8ZQJa7csDlC9+8uivu+Ld+qHk0UQ7UCijrDCKmGUpkk/jLGLzeEMg2ZQTcS2TnI8
	 Z0upb5hjHdFR3i4DdDeJ5uzrVS6jXxiW7my3hVKBIViNuilwAs/y8zopVPMqzH+NdkZ3r
	 eDKc3vCrsESAIs+i5/V+r6EXDcBGfH4zV8uy00121BDJThl0f+B5OMReFIABCPF0ShA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bhttfltf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E6606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bhttfltf
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4781150eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793878926; cv=none;
        d=google.com; s=arc-20260327;
        b=A73KEPvldhFxBxp58tN3xa1JLP2JJ0ISXU602ANn72/kBfntLA7yYx9hUP+BKfEbe9
         v6YyaJ9p3yRTkM0VC8BoDEgn2ikejJpJ1hq8t+Tj/SPSHTK2oB9PgGkMuj4jcK02kWez
         t71tgJ7lJ2GNoyFEY54N0JJ2/D0neBGY46u6VW12O8dilKa5pVgi86diuYTaH8ejGt2E
         vRhN3DcigbisglAfjm4czZCKVEs51xRlaMxjvJCOtuy6W/PywZwjc7ySCXXhv4V542RE
         AmjkSYZ4f2DFeJv2wDrKmL+RMPN1ftci/qVMcACAr3zAtUJ5oWbtfgB+FtRh1yhkNYl8
         1nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZy2AlGoHMhT5kSino03X+cU+0j9SA9toGXagMkx2FA=;
        fh=MhZb15HfMP0g8K+U8ZSAWEQE2PiVi/r2CTqUH82vui0=;
        b=FwsqV+xrttAfyK4iFg/+fXDeclSe53P/grxUx0eVnmls6ENqj/k/4FBIIHfPIjU0ri
         0sz6QE45+yBt0hNtANTSkQW10YBR+2h3JFbt2uHn60G0fvfgeO1Q1f5kiHUg/H1D7pyr
         AmQNYlZTpxZ2CF4JIZEpadi+5/m0mRZP8bI5MAgX70DU+M03wIFkrkVZkdC3hQbI5fSQ
         KlwDw64LV8wEB7tLjizAwCx2kuD0nOl4MdPXRIhp5CFaYQHplmXFjSvprKJyuzSrefw/
         lag5zVo2NGPd7q9syP7UQZuFXpeDtLoaxmns/hj7ikiBNIjJUWknYnW8MKZ7OM3KVPeb
         RMsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878926; x=1794483726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZy2AlGoHMhT5kSino03X+cU+0j9SA9toGXagMkx2FA=;
        b=BhttfltfOTDQYtp0d+cp1cMYwC4lOp1Bj6E6fICsFqspis75mtx0CwZXtTxPCbt96w
         hGOn4WfEBNyEWgsf1XwJyrzYunaKUyrwlrCCRc1wUGhOeY/rNLxrIujcQFm6p+gt9wN6
         WQrGlCWweuFnZ77UcploMTt9osgk5P6nHOd5rzayOli6sBMtx8T2Auuu73i2s3rBAmqY
         8fF+mjfR+J/U0gQZQLC9n1Bh/kw4i1uUObiJrxu0s8CirGE2L6a7yMbQvOTdTE+d281/
         T90s6OasWfb9F1omu43aY3ELtB6Wnl+fwSuprgd6uJnjbGfgm/UWxtva8theB4HGrGG7
         SsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878926; x=1794483726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZy2AlGoHMhT5kSino03X+cU+0j9SA9toGXagMkx2FA=;
        b=fpwqoD7S/pacUR6t9v/whVSHANn/F1ga56oTC+bFQlfAWoPrx2zGhKmIZ6yJINqvES
         aGZFic4M0mSgjv33ZhRqmbGwwp1Vtegv0ecHfBcLYbBVR0dtCa+nFxPilB9Rc94NjdNM
         vrzSQM3fjH0pviQssUjXp/E8cEBhjKZvy3YtKMjqso1LvVFBVTBn+MzHuK6/Q0+Yja67
         +4Xo8S9gXZIKMQ4ulMnou1me/JUvwawfds+oYhLjdIqfzYngcU+N0P+BWrTUM8qnpXbK
         lO0rOztb1NzDepY4uoK8eHfOKGszdfXr/TyDOWtDlWzylqm6v7jiD48XJTajt9N6SPYU
         0bWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkBM6M35iV1u2XEV/WeydsiFMuxuSSncKO0VWdWCZ4gtInIwlTkme1a5E3vIOmFk+IvOJaM8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kLAE/D8eW/9fgXPyUBa0JkhXaB7LzlqEAl4yuhNqqMx9kdvZc
	fAetoAddbakK3uJrNhL0xC8ayogAK/xSBYQFsManqQRRlZ7ojTVYH+NoSOMJYilwAocvyws7/qA
	IttW0GGnPOz3DIeBEU96kYBZq8xTofy8=
X-Gm-Gg: AYBFou3TvdZeIZ+nqYIvFbPkJqKsYA1kJ+F5e12Pe6pCQkAXDgP64k9l5/oj2d+HQK6
	JuEGBju5MjjU3v/XRRYq2RBVhiWJXVTYkM97NsPYajCRjsFAleXZF6V+oiy2KzeEe3UPsXkDUJi
	6x/6XOFBzCwwwMcval1nILDox/T8xPOzP8o+gFdXJw2jWUyyi9oWpY2ik7Gg9hZiLXKL+MMEnxn
	LM35dg1TTTYbwzuzYyTaz0B6p5QbtfRGgDFtK5nweyuaMeiTJ7WjxRb7m9guCxoMzNuxX7KYXuz
	8FIILYwU4H1IkuqnqMErlNoM0ss9LXJRImIolHwyJES1Oa2MMx7Hxgaz/M+cehNwt9MEyUD+Of0
	w5lDEHIoY2yL60EOT2g90bMo9IT6T3uJXg0DoopKmWbzEi2jf+ueMnSfjpbwDYPW9/hw=
X-Received: by 2002:a05:701b:4281:20b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1ac5e6f5362mr29461112c88.39.1793878925686; Thu, 05 Nov 2026
 03:42:05 -0800 (PST)
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
 <CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com>
 <20261102161426.2403d308@pumpkin> <CAOLeWCviRtGMhGJQx3HHFQOze439576PQqr4tmvjGkMMfYfcog@mail.gmail.com>
 <20261103223846.5e6a1dfc@pumpkin>
In-Reply-To: <20261103223846.5e6a1dfc@pumpkin>
From: Demian Shulhan <demyansh@gmail.com>
Date: Thu, 5 Nov 2026 12:41:54 +0100
X-Gm-Features: AclHuK8YmBfrvU8U1rrj8-xeeVAzdXMtREA20yl9x0xVbHvq-vQqOjWILfZrKI8
Message-ID: <CAOLeWCvDKWAuCJ1cW1bbhtmvhV6ei2cPYcQVw_4sM+i1tc+-wg@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
To: David Laight <david.laight.linux@gmail.com>, 
	saeed bishara <saeed.bishara.os@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David Gow <davidgow@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The scalar path seems like generic C code and not restricted to arm64,
> curious how that performs against existing (e.g. x86) assembly
> optimized implementation.

Hi David, Saeed,

I tested David's sum64() loop, with the store added, on x86-64 and arm64.
It is portable and correct on both, but no single C form was fast on
both:

- x86-64, vs csum-copy_64.S (GCC 15, Clang 19-22): with dst alignment
  and 64 bytes per pass it reaches 0.89-0.94 of the asm. The form costs
  two ALU ops per word (add + adc $0) against one adc in the asm, so even
  a hand-written asm version of it stays at 0.94-0.98.
- arm64, vs the scalar loop from my series (four accumulators,
  res + (res < data)): the same 64-bit loop is 0.90x, while the same
  loop on 128-bit val/sum with 2-4 independent lanes is 1.19-1.24x. On
  x86 those 128-bit lanes drop to 0.40-0.52 of the asm with GCC.

So I'll keep it in arch/arm64, and x86 keeps its asm. In the next
version I'll move the loop to 128-bit val/sum with independent lanes,
the same way arm64's do_csum() already works on __uint128_t.

Demian

=D0=B2=D1=82, 3 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 23:38=
 David Laight <david.laight.linux@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 3 Nov 2026 16:47:29 +0100
> Demian Shulhan <demyansh@gmail.com> wrote:
>
> > > .L4:
> > >         ldr     x1, [x0, x4]
> > >         adds    x2, x2, x1
> > >         cinc    x3, x3, cs      # adc $0,%rxx on x86
> > >         adds    x4, x4, 8
> > >         bne     .L4
> > Agreed, that is a nice loop for the sum-only case, one dependent op on
> > the sum chain and no builtin needed.
> > For the copy case I tried the same form on x86 (Zen 3, GCC 15, Clang
> > 19-22, -O2) with a store added, against csum-copy_64.S, as posted it ra=
n
> > at 0.85x of the asm with GCC and 0.73-0.76x with Clang (which rewrites
> > it into setb/adc), and ~0.8x unrolled 2x/4x - a bit slower than the
> > posted 4-accumulator loop (0.88-0.95x).
>
> I just added *(u64 *)(dest + count) =3D val to one of my loops.
> gcc just replaces the 'add from memory' with mov/mov/add.
>
> I'm now confused though, I seem to be getting different output from earli=
er.
> With -Os (which I didn't think I was passing) clang is refusing to do the
> 'offset from end of buffer' loop.
> With -O2 it bloats everything by unrolling 4 times and adding lots of
> extra instructions.
> (AFAICT the optimiser has a completely incorrect cpu model.)
>
> If the compiler doesn't generate the expected code it is all pointless.
> The xor parity code loop had to be in the asm block to stop the compiler
> changing it to a much slower form.
>
> For the checksum code I have managed to work out how many bytes/clock
> the code was generating and getting it to (reasonably) match the expected
> values.
> But you have to use relatively short buffers to avoid D-cache effects.
>
> David
>
> >
> > =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
7:14 David Laight <david.laight.linux@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> >
> > >
> > > On Mon, 2 Nov 2026 16:14:06 +0100
> > > Demian Shulhan <demyansh@gmail.com> wrote:
> > >
> > > > > The scalar path seems like generic C code and not restricted to a=
rm64,
> > > > > curious how that performs against existing (e.g. x86) assembly
> > > > > optimized implementation.
> > > > Depends. I think __builtin_addcll() is needed to get roughly the sa=
me
> > > > performance as the asm version. In my tests GCC on arm64 turns it
> > > > into adds + cset instead of adcs like on x86.
> > > > But I will look at it, thanks!
> > >
> > > The C version I posted earlier has the loop:
> > >     buf +=3D count;
> > >     count =3D -count;
> > >     sum =3D carry =3D 0;
> > >     do {
> > >         val =3D *(u64 *)(buf + count);
> > >         sum +=3D val;
> > >         carry +=3D sum < val;
> > >     } while ((count +=3D 8));
> > >
> > > for aarch64 you get:
> > > .L4:
> > >         ldr     x1, [x0, x4]
> > >         adds    x2, x2, x1
> > >         cinc    x3, x3, cs      # adc $0,%rxx on x86
> > >         adds    x4, x4, 8
> > >         bne     .L4
> > >
> > > I suspect that is close to optimal - especially for fast cpu with
> > > out of order execution.
> > >
> > > https://godbolt.org/z/eso79K7Wq
> > >
> > > David
> > >
> > > >
> > > > =D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 12:44 saeed bishara <saeed.bishara.os@gmail.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > > >
> > > > > On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@g=
mail.com> wrote:
> > > > > >
> > > > > > I would prefer to keep only the scalar version of the fused cop=
y+csum.
> > > > > > It reads the data once instead of twice, and on real Armv9 hard=
ware it
> > > > > > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12=
%
> > > > > > depending on the core (+6-8% throughput). It uses only general-=
purpose
> > > > > > registers, so there is no FPSIMD state to save and it is safe i=
n any
> > > > > > context.
> > > > > >
> > > > > > If you are OK with the scalar path, I can send v2 with NEON dro=
pped,
> > > > > > the scalar path only, and the KUnit fix for the x86 zero-length=
 case
> > > > > > Jakub reported.
> > > > > >
> > > > > The scalar path seems like generic C code and not restricted to a=
rm64,
> > > > > curious how that performs against existing (e.g. x86) assembly
> > > > > optimized implementation.
> > > > > saeed
> > >
>
