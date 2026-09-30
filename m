Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2330DD2F;
	Wed, 30 Sep 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731989; cv=none; b=cOXiKVjRx7/fKGWB8NafYSEri+cEy0aaIFh+4Z5EITUSyZ5E02z7Tepl8MYXmY4gqIvttU9VPyHpvE+DH/PpwduiRQbscFSUcqYOSkoamQZ7+r3fyhtm5fmCfpu7hKmqPGvYs5APYgKVaLpk6Wajd5hPx06oDw3jPm+H68r8T78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731989; c=relaxed/simple;
	bh=mEVczxqhoWIHjtJRVnlraq1vd7L61iBUG1ngt/aikAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1eqNz8T66Ndsm0OLoImTwPhPjHnaF50NLZoWpwguwWlFvvCZzMdO9urF38bGeRAk/7vuD3VmRu+67rnrcHZ/03zLaVGNg/P0ITclK27EDPEdA67RyucZwkYJcGYjtHtFRD4LTHjMyRuDVKWjTWzIkL5WnCBNqSdgYPJR4x0jUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM+sYz85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM+sYz85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C71F000FF;
	Wed, 30 Sep 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731987;
	bh=E9LFBu3yJsDQ69TLBDzRvOENcK1uacHJ+6beUmMVpe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JM+sYz85EuQ1Pc/ToqHwjyyrWQ5qhidcHK9+vHBv+X7ngHQWkQZRKjoh+Wr8soW/w
	 NTuJWuYafs2kVosOh4Y7o39wnniNajmM8M74eKQQHwVLyCPiFGZj+O88KRg8n0Qd4L
	 LZM3KNyJcsj772lBhwVM54vOk1DJZtO46jwJQhnHNApkEQY6PtqjiphyIkaGpcibbE
	 3193lTulW2YDMNQfbygaldH06RuZOju+p92y7soxpbWLHiI+u+/ePHRVnThchZuYm4
	 lD4kvzzptU1HIMytqiANY1luTHfm0qLMV0qI2KH5aLz4Vb2ueJIFwny9NW18+N0TdH
	 mZoHF4G4UzYxA==
Date: Tue, 29 Sep 2026 18:33:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20260929183306.24a26c74@kernel.org>
In-Reply-To: <20260927131838.6774-1-demyansh@gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 15:17:56 +0200 Demian Shulhan wrote:
> arm64 currently uses the generic csum_partial_copy_nocheck(), which
> performs memcpy() followed by a second pass for csum_partial(). This
> double pass exerts unnecessary pressure on the L1 cache.
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
NIPA CI flagged a regression from this patch: the new "checksum" KUnit
suite fails on the x86-64 test kernel (ARCH=x86_64, qemu). Specifically:

  test_csum_copy_small_all_alignments  (len=0, src_off=0, dst_off=0)
  test_csum_copy_patterns              (len=1, src_off=0, dst_off=0)
  test_csum_copy_zero_len

All three failures involve a zero-length (or very short) copy. Digging
into it, x86-64's csum_partial_copy_generic() (arch/x86/lib/csum-copy_64.S)
seeds its accumulator with -1 (0xffffffff) rather than 0:

    movl  $-1, %eax
    ...
    cmpl  $8, %ecx
    jb    .Lshort

For len == 0 (and other very short lengths that never execute an
add/adc against the seed) it returns that -1 unmodified, which folds to
0. The naive reference used by the new tests, and csum_partial()'s own
convention for an empty input, instead treat the "empty checksum" as raw
sum 0, which folds to 0xffff. So the new tests' expectations don't match
the pre-existing x86-64 assembly implementation for these edge cases.

It looks like the tests were validated against the new arm64
implementation and against memcpy()+csum_partial() under QEMU on arm64,
but not run against x86-64's existing csum_partial_copy_nocheck()
implementation, which is what our CI kunit runner builds by default.

Could you take a look at either:
  - adjusting the zero/short-length expectations in the new test to
    match the existing (documented?) x86-64 behavior, or
  - treating this as a real x86-64 bug and fixing
    csum_partial_copy_generic()'s handling of very short lengths,

whichever is judged correct? Happy to share the full kunit log if useful.
