Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793540041;
	b=yF/pfVIjRwDJcwWwu1xBGlpbnaPeLkAZrJuIb3k3XtfZUy4EPysaqJcVZ+4yeWSbKedx
	 70R8AHLP1WgfSI7n5q9wzyQKlmZOWiXuO2af0a8GeUjTF7hqqRl872VkVYb+P2ciwItHT
	 WEMOrXVaBatZefPiYge9QfDQwbvwCALhJB7bQNnL+I2J7sPtDyRPHBJt2gJbRqp9pEvSJ
	 h2s5tYABRtGH8w7KInICWyfCVfqppmvNMEJ3jQBV+StZSgnLXdx6CANXcwzfasMstfr8K
	 t6A7Lf/IfgmWworYpTOC/dDlRGrtMpT5qSQZVZjpWC4gUs0dKP8pk3Eja8vbWh/nfxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793540041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4FoSNuo4120zGj2L29GeDCwMhfV0RCk5eABERU3r5fE=;
	b=QKo5ckZsTa1K+5RQsQbO+W96nr4f5VPfUjQDIXMyI0ZdE9sjTjEPkpE2FrAPe03XBBCd
	 pAXTRo7Bd6E0X8bm9xrxSzK5o65NSByfKOhlQU6n6ELIb4o/cdZeS9E1ujIpubUzrWNK+
	 m0ZuB3uVCSAlucJx3O2jyJ/2YBSL0Y5L/jAgDXq0SLsoLMW4J/9Yv8MYQqW3ltje6iz5F
	 qtDiAwu19Zmpf3HQitWSwglfwuMaSAAc1AGcQGPThDvWUdWNQ+4bmH7KDw66wAD40Tty7
	 meKsxI2C2jlVr1VWUQiLmny4oswSKBNQHSfnep/WiRkBzl7W/GDFruUjFtRCRGgyGPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ap7tarRd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5D606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 13:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C5D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ap7tarRd
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so338595c88.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 05:34:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793540040; cv=none;
        d=google.com; s=arc-20260327;
        b=nrdWdOw/gxJwv0xnfixhKjWAn/bX8AbdrNXRUVEm0/CUxLSSr2TcWqS+cDCMqpu3RQ
         BPM2Vva8ndlz5eQVXLsrCD1CHHQhYsWfRozUfgJGSmMrU1W97IOJQWyZKhJsO6tqhY3l
         WYg5Xss6muS75u0IQ0sfpl+jh9rG3dGLFFLQMODOmhEJC47zweqV5FipKcPfOIGazHjz
         Xp0bZXguz6Ugq+aBa5on0p9ZTnp1eJrqGgLx3m1SBqwcGMwJ/QTDNGS9NDRWtebZg5N7
         JbpjWZWilaXBqjY/9UtwCGUrHtOFJjmjVBF5eEaDVJgKAcJZgXREItAKjffazVq9OAE1
         8BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4FoSNuo4120zGj2L29GeDCwMhfV0RCk5eABERU3r5fE=;
        fh=6KKJVqTM+l4nywH1DdSQY5OOq+FwQg7wGD+Xkds8lI4=;
        b=olwV9jRtMsy5KacGG8yRtqbT2BDfjmhqJKbLFjlbJhOHQJoQj03sYNJoQeGEIAreD3
         nxKUyPOzzOqs7M/DZrAQUGKkhH7OMBCOrMZt705BcLFpVexwbqiacfSSDzSVc1mF7AE9
         7PQKcqEHkgA7Ltvkq19qAowzXI8hHBetE2Oly4Lft+qENCge1U58HLaS0Zmwt7K5f1vH
         eph8azNxhMTU6kS5rAX2LX8R3BDcCPM+mRI+cFt/oiIlaKZXzpdCF8VFT2ojeM1tJ0O1
         nsMR7E+0/YDP4UK2lZsP6Fd1xTQvI/Y9nE+g2Tkx43sg/BXCa3fhHOKs9JSW1tOikRgK
         ZVIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793540040; x=1794144840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FoSNuo4120zGj2L29GeDCwMhfV0RCk5eABERU3r5fE=;
        b=ap7tarRdmcn/+khd6TzQJW9GI+QtvqC5RDzR8lYDIZBlpvZiswV/ixdPDrRq0/6hrx
         NQkdG90oIDk64ppXy7XzeNmB2ZmG1Nh5VY045BTIiVb2n1sXE/s6g08pb7RMQpa461bY
         sA/WibAfd7/NsMe4U5S6WcNHuK5n+pqcJmS+T8mFEekPGgsPpUdJovv8g/DPHOYZ3GwO
         2aVoLAaEdAXAzBeGEO1YBMIKzTY5wAiwIpp4IDM5b021VHJ7zZboT2EkBBrzTK9W794d
         bmhxTSk/fcpMQ/H9VJ4L/XTiedsc9Cukx2j2nPFoAUBeOLiRi5x66y6p/2UBXe2FYQjt
         nYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793540040; x=1794144840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FoSNuo4120zGj2L29GeDCwMhfV0RCk5eABERU3r5fE=;
        b=IqpsNhcywlo62eekKy2WFZIioLl/mlvNrk2BoCuvKRDcAKg8c+ogyCgkvLTWZ82wSD
         EMeJmNoKdUEiZzI3dxO8YT+yMXEvPr84mmz40BZDribMn0GyA5QHFkSM1+vkmWSYgkQX
         6Ug+fqOG+6eVjVxaXjYoIOqNR9Xivdxk7ysAAAznTxTEoETs+IW8stA6D6m1qXbaxY/s
         VtA+PAPa7EpfmSzIBv9HSLZqx66Tn3bD9XIpPoGI2pF7YXgaYZEivZIHnU+6nxfvyItJ
         r4UbuL1hdVlCh3GDFbzlis0KADJLL7Qcpivjo/ABBJK6zcrboV2KWaprg3sJt3TjE89o
         Pzlw==
X-Forwarded-Encrypted: i=1; AKwUvBzjXjrryS9ET5PrAVaBloVAX16Vl2qtV/IZxzYguQymAfb0LwREiUZ1dYC2+UxBWPFSEKNeFyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiRKkAIsH2JzzVZSWJvus6muu2rxvTzJl16Db0awCZpDDsp1nx
	GeGaZgtGkdSX1wBrSGJyZNK0hce+ghRz9mVqE2uLCSmsi3YXa4OmDI5UhgkrxToYdSW42+tcpGX
	HnhmF361g6hXqMl2HpcqFie18YSSWDMMQjp9cjeo=
X-Gm-Gg: AYBFou3a8SxIA62eCE3aEaKp7aIbO6UnN24mDmkeIOlg2Fcqx2WZwLXK+mOzZu1WNgD
	rixtNhjm8vqbCOdw7+oQCC3dq1psVHy8KV9v/eiQVqFEiCcRM6D9bxItf1VnTt8Rx7BAtGlI2TC
	WQxQw6o1gey4Q+l4ZqjXEK83wSKcyP7X9K8ZDzB2P0hpY3J83+6Bhr2gOcS+CKCWx3aSTwGJVS7
	RxWoAt2XBytSyxzzbVEapv0Y5aePtLmwr8jrzhpfqA2VhOBM5w0Vy61ZRnGLx2K7iHBja1MX4Q7
	ighoOfDjfNFyBbTGEaUgB99lPj8ZA83iqAkLTXz2geErt+/c5BfNe4TGWiNI8WxqMkA5bCutm8R
	5U4tc6wt3fIgPMuoOCTkMflUhYCmFLSA3WANkN1XAIRJu+jFQNKu0FBPcUOHzZ3wYKFYVY2Tq
X-Received: by 2002:a05:7022:b047:20b0:1a3:bfb6:44ad with SMTP id
 a92af1059eb24-1ac5da797d4mr12358096c88.32.1793540040375; Sun, 01 Nov 2026
 05:34:00 -0800 (PST)
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
In-Reply-To: <20260927184414.6c0c8867@pumpkin>
From: Demian Shulhan <demyansh@gmail.com>
Date: Sun, 1 Nov 2026 14:33:49 +0100
X-Gm-Features: AclHuK-VTVK2Zx9itCVd1q2fYcmda4QQ21q-m0eczAKCyG7Q3SKFRADCEFBZaD8
Message-ID: <CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
To: David Laight <david.laight.linux@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David Gow <davidgow@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Sorry for the delay, I was in the middle of a company change.

You are right about SG and TX csum, but only when the traffic goes
straight to a NIC that offloads them. There is another side: software
GSO (skb_segment() with !sg && !csum) hits this path on 100% of TCP
payload over WireGuard (wg_xmit() -> skb_gso_segment(skb, 0)), and on
drivers without SG/TX csum (u_ether/f_ncm, cdc_ncm, mt76, rtw88/89,
ath9k).

So in general the software copy+csum path is still alive.

On the other hand, NEON is useless here. skb_segment() splits GSO
packets into 1-MSS segments before copying, so on these paths calls
never exceed 1448 bytes (1368 on WireGuard). At that size
kernel_neon_begin()/end() costs more than NEON saves, on real hardware
v1 was ~3% slower in cycles/byte than the scalar loop on the slower
cores. So that part can go.

I would prefer to keep only the scalar version of the fused copy+csum.
It reads the data once instead of twice, and on real Armv9 hardware it
cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
depending on the core (+6-8% throughput). It uses only general-purpose
registers, so there is no FPSIMD state to save and it is safe in any
context.

If you are OK with the scalar path, I can send v2 with NEON dropped,
the scalar path only, and the KUnit fix for the x86 zero-length case
Jakub reported.

Thanks,
Demian

=D0=BD=D0=B4, 27 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 19:44 Davi=
d Laight <david.laight.linux@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 27 Sep 2026 15:17:56 +0200
> Demian Shulhan <demyansh@gmail.com> wrote:
>
> > arm64 currently uses the generic csum_partial_copy_nocheck(), which
> > performs memcpy() followed by a second pass for csum_partial(). This
> > double pass exerts unnecessary pressure on the L1 cache.
>
> Which workload actually needs this?
> Most modern ethernet MAC support checksum setting on transmit and
> checking on receive.
> So the software checksum shouldn't be needed very often.
>
> IIRC there is also code to defer UDP checksum validation until the
> copy_to_user().
> I'd bet (a few pints of beer) that the complication this adds isn't
> actually worth while.
> Even Linus can't remember why it was done, my guess is it improved the
> performance of the userspace NFS (over UDP) daemon that would be
> doing 8k UDP send/receive (fragmented by IP).
>
> There is certainly still code to checksum data during copy_from_user()
> in send().
> Last time I looked I couldn't see why send on TCP sockets didn't go throu=
gh it.
> On x86 (in particular) copies can be done far faster than ones that
> include a checksum.
>
> David
>
> >
> > Replace it with a single-pass implementation. The new implementation
> > provides a general-purpose register path for short buffers and atomic
> > contexts, and a kernel-mode NEON path for lengths >=3D 1024 bytes.
> >
> > Measured in-kernel on an Ampere Altra (Neoverse-N1):
> > - Scalar path: 1.2x-1.6x faster for lengths < 1024 bytes.
> > - NEON path: 1.2x faster at 1024 bytes, scaling up to 1.6x-1.8x at
> >   4096 bytes.
> > On Apple M-series cores, gains are 1.3-1.7x below 1024 bytes and
> > 1.6-2.4x above. No length or alignment regresses on either
> > microarchitecture.
> >
> > Patch 1 implements the fused routines and the dispatcher.
> > Patch 2 adds KUnit test coverage for the new API and internal paths.
> >
> > Tested: in-kernel benchmark module on Neoverse-N1 with both
> > implementations cross-checked (0 mismatches); KUnit suite under QEMU
> > (with/without KASAN, with PREEMPT_RT), exhaustive and random userspace
> > testing of both routines against a naive reference with PROT_NONE guard
> > pages, gcc 13 and clang 18 W=3D1 builds, checkpatch --strict.
> >
> > Demian Shulhan (2):
> >   arm64: csum: Add fused copy and Internet checksum
> >   lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()
> >
> >  arch/arm64/include/asm/checksum.h |   3 +
> >  arch/arm64/lib/Makefile           |   7 +-
> >  arch/arm64/lib/csum-copy-neon.c   | 168 +++++++++++
> >  arch/arm64/lib/csum-copy.c        | 108 +++++++
> >  arch/arm64/lib/csum-copy.h        |  84 ++++++
> >  arch/arm64/lib/csum.c             |  54 ++++
> >  lib/Kconfig.debug                 |  10 +
> >  lib/tests/checksum_kunit.c        | 463 ++++++++++++++++++++++++++++++
> >  8 files changed, 896 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/lib/csum-copy-neon.c
> >  create mode 100644 arch/arm64/lib/csum-copy.c
> >  create mode 100644 arch/arm64/lib/csum-copy.h
> >
> >
> > base-commit: 93f51579e7df248780214094418f205253383cc5
>
