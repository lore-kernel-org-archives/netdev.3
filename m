Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26F41D120
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531062; cv=none; b=qYQkPAoaNG73AXBnKpgYr4XeKsu1eocBor+HUfxsRqexDDu8QT6OJv19C1fcVRoX7cFabyzy3tcAuiUqAPdFqgXf8gNr0s63NrrnFpIgJHdxiLDhl7M/OkzF0pPnVJcVML0CU9DCwhqNd0w0xqQT9t5EqhKeVKsbeBkRxluEFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531062; c=relaxed/simple;
	bh=yZcaEjEYSswv0oPohOPwr5uDwkBOr45OOsHi7Uwm8/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emUKhkVVFb4SuvPAwXaRYIRzD8QwF+QgmLp4Cj/YUGGxLlhheVBlruD/fDj7OApZ76nEKAScnVyCVW8FjwUHMTC4aEXlrszvzgTVbGNfZYoFWX0noQfjhA/kOcJS60Wlvg7bp7KDTfVVOltqM2mxfQ8eoH/Nwk9zxI2iklMbkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kum3BEJF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kum3BEJF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so1940313f8f.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531059; x=1791135859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFdg28cjkK57y5Nms1NhKpYwFl6OCJWFse4hVSZd8CY=;
        b=Kum3BEJFgIbOWzwp925FPwE/kY9fc7mSftd5ckkZpB8lswPjrFyyny5uztIkiJ/5a1
         ogrQNeeBxWp3h75AQLwM2EhyasJKXVL7+OA+AgZJ+JSdo8YGgc/KHChI3lAz9pO1AxgH
         YmK04JXHqrmW85KrWfVThT4K0qDzKL8Vkd8GnJ1ohYWCN44K1NgL2aXltQq/7fi1gBwg
         eJ0GBs7gSRYc8g2y/6/bzNiOliM5jNNDUrDNgwNRj8wXdBVvNzlBVWRxS25XvDiWMBho
         8k0IrjX/WFRlejS6zxHGSsP/8xnF2NebaR8LNynCkY7ICsJmHW9mySVFTArg0gwXWLgr
         tlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531059; x=1791135859;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFdg28cjkK57y5Nms1NhKpYwFl6OCJWFse4hVSZd8CY=;
        b=i97cOjN8s8qBZXptNTHFYDfG3VOPPZbt9PVzNRCiDyNF58Hsn9CiWLsb+24pKd4x30
         U5l464lzs/X4dWouk5I9aNvQ3hJmx8D5TGY39I3t9HZqhUxdoxkTIcc8JLYCU33gyPCc
         iMXoJ1xdWvK0ioSUXDZ+w2GYodyZyLKtNIxd4c9L6+1KOVXr7GWpv4dQd+RYlaPrXzsx
         s23QWgoYUEpmGJyzRWQOYzEW0p6VuFfGv187NsqoVkjIYM/6hvDvQ6+33swXDR6wmSnq
         SiuPEwnljgFeupCC3IwLGCpgIB1OeL3CLdirS8F7thU9CzcX+IMpEPLu6EB0DoVAvyGF
         TMIA==
X-Forwarded-Encrypted: i=1; AKwUvBxGncQjJIlfi8vnZt3KyNkm+0ggCcfGpvxzvurh4h/T5vvQ97D5xLsI4xtCxl4Oc3jpqt9+Ykg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7F5rus1b9pr2K/ZzHFxMhAOzvfskgDCKCwAPRv/Kwo549Ul62
	uP83xrHFN1xApDBXFpAY8wi2XptXMlucdURS87cK40JA93QAODfymjM9
X-Gm-Gg: AYBFou2W9HoSxxUSYU8+fJqGU5YFjC6trcv6ajdgWBQpjWB3RmAoT8mgO1S9UMdyqDY
	zCQ2E+qBGAI830t5eJUpl+4vy5HlwbPLqwTPA52P5OLoENj5imTTf9Y7pTWZwG8azzyaBA96Uwk
	PSxic1//DPtc95oBNn2M0QGNlTkm/YOrleVbGi13F0uFl3YQII7xZpJakEhC7sW2UrafngsSbz/
	zel7MhAr767nkZoEtZ3JReyjTG/n7M8ygD1H+Eg8FBRGhjSP48VsIsgStJjTHCXJz+m9tTi3MVg
	WGAvSxHV1zWNdXcLZKgcwN/X8LA4ZKomoIO2duqK1vTD+sLu93dYpGi8GzDImL4vThjEYAerzrW
	FK03x7vQXFYAPu/2tKk47zWLAUfSVRp1ZxOOVWGH5Q9ZQ79UGgkt7/gpNT3+GrDwQHTs5TIhO/c
	asdbK7xCNwduWFxT4PI1YLzRNxsA65ToqI26rm8r7+1izdx5+ACcY1X2z9MUh17QoB5BoTyBYzm
	t/0RLM6vjacynv3C3dUmuXNXLaX5bo3bJM=
X-Received: by 2002:a05:6000:3105:b0:488:8192:c768 with SMTP id ffacd0b85a97d-4888192c8f5mr13570954f8f.30.1790531059310;
        Sun, 27 Sep 2026 10:44:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a4e9sm18464590f8f.11.2026.09.27.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:44:18 -0700 (PDT)
Date: Sun, 27 Sep 2026 18:44:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Demian Shulhan <demyansh@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Biggers
 <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marco
 Elver <elver@google.com>, Ard Biesheuvel <ardb@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, Nathan Chancellor <nathan@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
Message-ID: <20260927184414.6c0c8867@pumpkin>
In-Reply-To: <20260927131838.6774-1-demyansh@gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 15:17:56 +0200
Demian Shulhan <demyansh@gmail.com> wrote:

> arm64 currently uses the generic csum_partial_copy_nocheck(), which
> performs memcpy() followed by a second pass for csum_partial(). This
> double pass exerts unnecessary pressure on the L1 cache.

Which workload actually needs this?
Most modern ethernet MAC support checksum setting on transmit and
checking on receive.
So the software checksum shouldn't be needed very often.

IIRC there is also code to defer UDP checksum validation until the
copy_to_user().
I'd bet (a few pints of beer) that the complication this adds isn't
actually worth while.
Even Linus can't remember why it was done, my guess is it improved the
performance of the userspace NFS (over UDP) daemon that would be
doing 8k UDP send/receive (fragmented by IP).

There is certainly still code to checksum data during copy_from_user()
in send().
Last time I looked I couldn't see why send on TCP sockets didn't go through it.
On x86 (in particular) copies can be done far faster than ones that
include a checksum.

David

> 
> Replace it with a single-pass implementation. The new implementation
> provides a general-purpose register path for short buffers and atomic
> contexts, and a kernel-mode NEON path for lengths >= 1024 bytes.
> 
> Measured in-kernel on an Ampere Altra (Neoverse-N1):
> - Scalar path: 1.2x-1.6x faster for lengths < 1024 bytes.
> - NEON path: 1.2x faster at 1024 bytes, scaling up to 1.6x-1.8x at
>   4096 bytes.
> On Apple M-series cores, gains are 1.3-1.7x below 1024 bytes and
> 1.6-2.4x above. No length or alignment regresses on either
> microarchitecture.
> 
> Patch 1 implements the fused routines and the dispatcher.
> Patch 2 adds KUnit test coverage for the new API and internal paths.
> 
> Tested: in-kernel benchmark module on Neoverse-N1 with both
> implementations cross-checked (0 mismatches); KUnit suite under QEMU
> (with/without KASAN, with PREEMPT_RT), exhaustive and random userspace
> testing of both routines against a naive reference with PROT_NONE guard
> pages, gcc 13 and clang 18 W=1 builds, checkpatch --strict.
> 
> Demian Shulhan (2):
>   arm64: csum: Add fused copy and Internet checksum
>   lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()
> 
>  arch/arm64/include/asm/checksum.h |   3 +
>  arch/arm64/lib/Makefile           |   7 +-
>  arch/arm64/lib/csum-copy-neon.c   | 168 +++++++++++
>  arch/arm64/lib/csum-copy.c        | 108 +++++++
>  arch/arm64/lib/csum-copy.h        |  84 ++++++
>  arch/arm64/lib/csum.c             |  54 ++++
>  lib/Kconfig.debug                 |  10 +
>  lib/tests/checksum_kunit.c        | 463 ++++++++++++++++++++++++++++++
>  8 files changed, 896 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/lib/csum-copy-neon.c
>  create mode 100644 arch/arm64/lib/csum-copy.c
>  create mode 100644 arch/arm64/lib/csum-copy.h
> 
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5

