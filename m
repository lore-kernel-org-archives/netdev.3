Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC22BEC45
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515205; cv=none; b=iJbs12TrWdLWZzWmzFdYGibIxO3yviwrpn2SFaEhoJHTQNXV5Omw6ys1SS7Q/icB63nnHUBiWU6pTY3wkqBxNrJThT9gzaWQM8WUjVCbci8jmPQD6r0zj4x7iGCJQN8UBPZd1F89UsSFApOZShtf824lV8eWUIoJ5GdV5TVpia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515205; c=relaxed/simple;
	bh=dyYw3Tm3hTj8DLauIeAGN0ZLDTdgf7122SZJk55EqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+iie9JHdKMr3fp4FSWLLST6CM+PPpF9CP4waVdqgmp/tMMwZLIV5PAWTftCYzcbqrVReODxfkYuQC0JAh6s0ygYRaC92xyiD3QGvCrNhCoG9W24BoO1e5ANnfZXSObsUGiQXkuHAnakx8oAHeHdj1kgJmQGZqojqhZ/broKmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7WgXXDK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7WgXXDK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so16198505e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790515202; x=1791120002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGzUbv8x/qChEM/5fcor4kLUFepBVWkPmo87o0g+kKg=;
        b=l7WgXXDK7xi0o3VbL6PXPbA4nCjTRga1Z2rWq/ZOZKwk8hyuAxWBOz/PSVMz55yhJM
         vfFQl+tG2vZLEzL1JL9c44Tn/9y4bygn+xuLCIQ+YYdiZMh9aqxA/nfFjXHAELRRe18s
         XkieTPFK7u6f1tRsLiGJ8VWIf5A/i5SmgAGuCENNzjTH44fzatSdrzXwcr9gC0HkFlYs
         qwiznfNFq29HaW0pc7KCL9N8M2wCfgAkJiQslG7anQUNJriJcs3cB9kcwUkTK2uUgOgZ
         jSzG9BGItLqx3QlWDsCFsNRkdiUUil18UojS6kvZAT0jkHUslgluBggzROfg36ZBBE7Y
         OiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515202; x=1791120002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGzUbv8x/qChEM/5fcor4kLUFepBVWkPmo87o0g+kKg=;
        b=OdzbI27kb16YOI7enPGc+fOTZn1J/1J2nU6pQJBl2QfwFdDUcqYDi8MihM0qS3GnHm
         wQKCTrzk8c/r4knXwlCyrPS7BwGbNiuRsUo8jazRxAZiy3g0x4F0L//O2WZ4mqiN1cLx
         vpbSNSR+qNo6TOysbTwjtiXAPA7GZlp4g823zVW+pdmON1mCyirBnDfF8VfVdgth5Wuv
         whUtwh6joRLDBQuN5B0pchaf4s+ciWNYQkA45S8Q4C7LTHDISp0lMW+8umAqiPq1REMk
         2wJFaM6kUuaPCHjRJG1J7iqGpWQdmM2Y0A25aMfDb5hb9MHcnCIh5btgrRpq1IJvYYZf
         zQcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRqYGnu7yZg93JnvNCo+eTu65P3x+6urfoeTX8MqZj7X2AElIu1IXUd8ieUunrciKUUMDZjJc=@vger.kernel.org
X-Gm-Message-State: AFuF++le1Mn54PTSC0kmBbVWHzZiHgLy1iO5EBjzDy97+a/dDmg76b6M
	oAcv+afgWyLgIg2N/UnT5WWthMVXmRQNzH8fJaQdk/q9PBOz1gwnBxXP
X-Gm-Gg: AYBFou20/junzOh8TNteINJ9UNu5HhcRq6ALPWXGCVVheFJquJtlr7kslOHag0ul+RF
	QQI8RTAdHshWW9NhzVT5sjhIcXfR9I83e1xLEseeBbUqFG9IsJKL20Jwj6pq9R5oam2Iopx9QPj
	L/q3ZcUioR+y1qQLSW8bTA1OeY63/TQcyX3kPHf6Aac0u2iD0uJGtZ7DS7wCQ2vGx2GjQA70bQ9
	eDwC89p2NCOY2dCrmfYZw3/1V0ITT+dbPgG4OItbBA5itr96zyw43EMW3++cAXvRQz2JS7IY+Ex
	C0a8uA35L7tN8p2ppKNeg8IMnu7jucxvZiRZ477KiE/obLXT97zWHoY6C3ELxbRV0DWVhSXovBK
	m0eUBlu1uuEPsk+J0B0ZB4y161tKFjixgk5RdPutsAn8Kk4LdSHABuyl/9aTb/4vt7YYTokcgjL
	ykS2grSepb611+ZCi8gvSGqxcNR3vMF1Vt9k6N/wmFjbvPilWERRu7pR2oxRslCCK2vn9aRioSy
	+IGNhzKV7EHA42jydEtNhr6L0PI5qQvYFGvwVQ=
X-Received: by 2002:a05:600c:4e53:b0:49f:d58f:1f8b with SMTP id 5b1f17b1804b1-49fe66d807bmr178581125e9.18.1790515202245;
        Sun, 27 Sep 2026 06:20:02 -0700 (PDT)
Received: from lima-dev.. (89-67-112-196.dynamic.play.pl. [89.67.112.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0019057cfsm73615905e9.11.2026.09.27.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:20:01 -0700 (PDT)
From: Demian Shulhan <demyansh@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Demian Shulhan <demyansh@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
Date: Sun, 27 Sep 2026 15:17:56 +0200
Message-ID: <20260927131838.6774-1-demyansh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 currently uses the generic csum_partial_copy_nocheck(), which
performs memcpy() followed by a second pass for csum_partial(). This
double pass exerts unnecessary pressure on the L1 cache.

Replace it with a single-pass implementation. The new implementation
provides a general-purpose register path for short buffers and atomic
contexts, and a kernel-mode NEON path for lengths >= 1024 bytes.

Measured in-kernel on an Ampere Altra (Neoverse-N1):
- Scalar path: 1.2x-1.6x faster for lengths < 1024 bytes.
- NEON path: 1.2x faster at 1024 bytes, scaling up to 1.6x-1.8x at
  4096 bytes.
On Apple M-series cores, gains are 1.3-1.7x below 1024 bytes and
1.6-2.4x above. No length or alignment regresses on either
microarchitecture.

Patch 1 implements the fused routines and the dispatcher.
Patch 2 adds KUnit test coverage for the new API and internal paths.

Tested: in-kernel benchmark module on Neoverse-N1 with both
implementations cross-checked (0 mismatches); KUnit suite under QEMU
(with/without KASAN, with PREEMPT_RT), exhaustive and random userspace
testing of both routines against a naive reference with PROT_NONE guard
pages, gcc 13 and clang 18 W=1 builds, checkpatch --strict.

Demian Shulhan (2):
  arm64: csum: Add fused copy and Internet checksum
  lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()

 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/Makefile           |   7 +-
 arch/arm64/lib/csum-copy-neon.c   | 168 +++++++++++
 arch/arm64/lib/csum-copy.c        | 108 +++++++
 arch/arm64/lib/csum-copy.h        |  84 ++++++
 arch/arm64/lib/csum.c             |  54 ++++
 lib/Kconfig.debug                 |  10 +
 lib/tests/checksum_kunit.c        | 463 ++++++++++++++++++++++++++++++
 8 files changed, 896 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/csum-copy-neon.c
 create mode 100644 arch/arm64/lib/csum-copy.c
 create mode 100644 arch/arm64/lib/csum-copy.h


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.43.0

