Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04F490BFD
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046762; cv=none; b=j2rIhB3L9ZDnfDejkLwCU4qFqgdoLpH3KBD5UHqv2w8bztUd2Q1FDKiA9RVPftCk+YTWHUjy/slywxwtAxwRjapHnRjJcEH126y69hPKLi5fIlRr8SijMx+qJ3vJWnng88KyvNttCQSEgfA6mivmyqMqki/Z+hGAKjF/A5WBBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046762; c=relaxed/simple;
	bh=gVwAS/LBuK8afcKNl332o34aDKkQ5P/ZvI/zk8kZssA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fH+cUvFc3/TpLLsYdyihrQPDNliKS0GbRXiV99PFaEKhb/9sdPcIg8m48TkAxLWs6iYDhSDq3gkeIiRRXrgohxzBrDQg5y+sRvAgxHMJ344wi0RSd+KNpaP/C2IJjnbGF5zG2i6Dz2ZRyQBYYUoRTzHr+4QHfdUpALEgdXOsz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZAmSkPA; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZAmSkPA"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so3762203a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786046752; x=1786651552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mYilKGc1Ozm+Wqc6rMtn6RGepKDO0nOO45ZaajNWpPU=;
        b=BZAmSkPAqNX1xVr9tElT0+47IBlw3In+UB3W1AIarClCC3aRY/9LWxcwbsJK7922+V
         elgN+b7sJKjUAg24CUqULTHQwatZzyglf8cRjjR+vvKXrUFFnd3VBQwVFXLZ2Jc4gx/4
         6CBXBCwycWsK+EKgHknOQfzsTXGUqXCwpCD4+eTpXZekTk54nkAD+mvGABhS1RzaLTR6
         njTuaTyJYPypmPiK466drhZGVVelHxtIbnTlF2xiLotIQacrqyMYtJtG60Z1v0qVp6Fk
         d3VxjiqVbv/Q9Zjy3oH7x7AhDzjARsqf76br9oGN8NH9x0WmNWU34V1b5TQoN2b7/IE2
         XWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786046752; x=1786651552;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYilKGc1Ozm+Wqc6rMtn6RGepKDO0nOO45ZaajNWpPU=;
        b=MKEXgBYro3yrnLMROymYoj6EL698w6+JlsYeyTuCuXfnkes3AGCw+e82MJlZNT5+NX
         n+lMIKftJGvcF/14jFo8AazgH8M+DZB8IfSjxTdZ90omm90DIOH9crl/OQ7kb18mlpeW
         kH7dQ50kSuG1ZzOYiL2CbDNFuSHFCmTCKTS/Y64sTzlxn6MorMkM00MEFZS59kR0NjLW
         LPq8TelTszU8RTRHYcofAHNTf3PNCo6fplzK1SDVQkPQBoT7bBL42VZrHYSbJvyDCoVB
         Fu3Os1CkrSnyfQbYUpkRc9d9o0aU0c+TS8KvX0ooqRRhyzwWwjVTL+y4BVLeiWkEznK2
         5z3w==
X-Forwarded-Encrypted: i=1; AHgh+RozA1nhPZnGWFlRWIN3ro/6q1LA/Vly6v/4o/RWMMLxiL3pOvrOUeh0WgUB/waW8n3GkjDsrec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcYVAT63vOIALyScBHtcedRTtxLrqoepAneanBpK6VepRXP5W
	4RlapCPmOISYU1TtJP6NCoK5wdOhNDc8/qRVC189NqbPDA0arJFt48msdPcXXaLLB2KFt6qJ/VK
	mEnGWog==
X-Received: from dlzz39.prod.google.com ([2002:a05:7022:4a7:b0:13c:fa0e:4693])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:3c4:1c9f:d81
 with SMTP id adf61e73a8af0-3cb85e2b5ffmr16224877637.7.1786046751801; Thu, 06
 Aug 2026 13:05:51 -0700 (PDT)
Date: Thu,  6 Aug 2026 13:05:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806200548.3124802-1-surenb@google.com>
Subject: [PATCH v4 0/5] mm: Unconditional per-VMA locks and cleanups
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@kernel.org, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v2 version of this patchset [1] was written by Dave Hansen and per his
request, I'm taking over this series.

tl;dr: Make per-VMA locks available in all configs. Simplify some
of the per-VMA lock users now that they can rely on them being
always available.

Binder and networking folks: Your code is the target of the cleanups.
I'm cc'ing you now on v2 because there's emerging consensus on the mm
side that the approach here is sane. I'm not quite sure how this pile
would get merged, but ack/review tags would be appreciated if this
looks good to you.

Longer version:

When working on some x86 shadow stack code, it was a real pain to
avoid causing recursive locking problems with mmap_lock. One way
to avoid those was to avoid mmap_lock and use per-VMA locks instead.
They are great, but they are not available in all configs which
makes them unusable in generic code, or if you want to completely
avoid mmap_lock.

Make per-VMA locks available in all configs. Right now, they are
only available on select architectures when SMP and MMU are enabled.
But all of the primitives that per-VMA locks are built on (RCU, maple
trees, refcounts) work just fine without SMP or MMU.

The only real downside is that making VMAs a wee bit bigger on !MMU
and !SMP builds.

The upside is much cleaner code, lower complexity and less #ifdeffery.

Clean up a binder VMA locking site now that it can rely on per-VMA
locks.

Building on top of universally-available per-VMA locks, introduce a
new helper. Since the new API does not require callers to have a
fallback to mmap_lock, it's much easier to use. Callers can
potentially replace this very common kernel idiom:

	mmap_read_lock(mm);
	vma =3D vma_lookup()
	// fiddle with vma
	mmap_read_unlock(mm);

with:

	vma =3D vma_start_read_unlocked(mm, address);
	// fiddle with vma
	vma_end_read(vma);

Which avoids mmap_lock entirely in the fast path.

Use that new API for another binder site and one in the TCP code.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org

Changes from v3 [2]:
Patch 1:
- Restored a comment in Kconfig, per Vlastimil Babka
- Removed extra braces in mm.rs, per Vlastimil Babka
- Removed obsolete comment in mm.rs, per Sashiko
- Updated patch description to explain considerations for !CONFIG_MMU
- Changed stack_map_lock_vma() to keep mmap_lock if !CONFIG_MMU
- Changed bpf_iter_task_vma_new() to bail out if !CONFIG_MMU
- Added !CONFIG_MMU versions of vma_mark_attached(), vma_mark_detached(),
  vma_start_write(), vma_start_write_killable(), vma_assert_attached() and
  vma_assert_write_locked()
Patch 2:
- Move binder_alloc_is_mapped() check to only protect zap_vma_range() and
  make error handling consistent, per Alice Ryhl and Lorenzo Stoakes
Patch 3:
- Added Suggested-by, per Lorenzo Stoakes
- Updated the comments for vma_start_read_unlocked(), per Lorenzo Stoakes
  and Vlastimil Babka
- Updated the patch description, per Vlastimil Babka and Lorenzo Stoakes
Patch 4:
- Updated comments for vma_start_read_unlocked() Rust version to be
  consistent with C, per Lorenzo Stoakes
- Added Reviewed-by and Acked-by, per Alice Ryhl and Lorenzo Stoakes
Patch 5:
- Added a note in the changelog why the mmap_lock fallback removal does
  not affect NOMMU case

Applies cleanly over mm-unstable

[1] https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc=
.intel.com/
[2] https://lore.kernel.org/all/20260802215459.2769283-1-surenb@google.com/

Dave Hansen (5):
  mm: Make per-VMA locks available universally
  binder: Make shrinker rely solely on per-VMA lock
  mm: Add RCU-based VMA lookup helper that waits for writers
  binder: Remove mmap_lock fallback
  tcp: Remove mmap_lock fallback path

 arch/arm/Kconfig                       |  1 -
 arch/arm64/Kconfig                     |  1 -
 arch/loongarch/Kconfig                 |  1 -
 arch/powerpc/platforms/powernv/Kconfig |  1 -
 arch/powerpc/platforms/pseries/Kconfig |  1 -
 arch/riscv/Kconfig                     |  1 -
 arch/s390/Kconfig                      |  1 -
 arch/x86/Kconfig                       |  2 -
 drivers/android/binder/page_range.rs   | 19 +-----
 drivers/android/binder_alloc.c         | 62 +++++++----------
 fs/proc/internal.h                     |  2 -
 fs/proc/task_mmu.c                     | 93 --------------------------
 include/linux/mm.h                     | 12 ----
 include/linux/mm_types.h               |  8 +--
 include/linux/mmap_lock.h              | 89 ++++++++++--------------
 kernel/bpf/stackmap.c                  | 15 ++---
 kernel/bpf/task_iter.c                 |  2 +-
 kernel/fork.c                          |  2 -
 mm/Kconfig                             | 12 ----
 mm/Kconfig.debug                       |  1 -
 mm/debug.c                             |  4 --
 mm/init-mm.c                           |  2 -
 mm/memory.c                            |  2 -
 mm/mmap_lock.c                         | 59 +++++++++-------
 mm/pagewalk.c                          |  2 -
 mm/rmap.c                              |  2 -
 mm/userfaultfd.c                       | 61 ++---------------
 net/ipv4/tcp.c                         | 31 +++------
 rust/kernel/mm.rs                      | 57 ++++++++++------
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 31 files changed, 157 insertions(+), 395 deletions(-)


base-commit: bacc32cc7de65ffff70080a48eb294f89e434d5e
--=20
2.55.0.654.g21b8a5bc05-goog

