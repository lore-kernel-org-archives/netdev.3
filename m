Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242C3DAACA
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707707; cv=none; b=YB+KYz+jHyKpLQQ6HztWwxWwZVt5EKGArkzwbJX7aPQQd+tsoJNmRt3JMu+19uIcLpSVDjUjOqsq5Md0P2BVmtRE4f4CTZbJE6mpVpbCsWRza7nCoIOuvC1v0EEEk8GqUDLjPkHJn1N8hNcJDXXoNiRxoP0FSLy+Dzhvucuxdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707707; c=relaxed/simple;
	bh=KWKYix4+wMswJZiI0kUEbrMiyjXt9CTIoRd/ZBC5Zpk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GuLgGqJUGLLe3EHsp1NLv516wgPY1kg270Mxav0mYMY5zmNe4csypN0gusfztqQT8xGdgdNxD8Q1t2O3GqWGtVSBspyNSYCwZBDu/wlU/ByvEdrWkQCyXgxsCOVWMhnvSIhXU8wE0MNZCgtoYvWhSP8/ExXtLUhC56Y95CT0aYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uw1IYrGb; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uw1IYrGb"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2036422a12.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785707704; x=1786312504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cmKFkPc8uWOvZ02aIzcS8pqwykgpBkJTCfqehw1k6ls=;
        b=uw1IYrGbQ2Qz2ocAH9ZP+VVfhfTtiTCnrl/yql8BQXxLjvxI9Eyw+eHuCfKYv+Ed4o
         fsFSoolXMgLYbVtYbjZ+HPcVBaHY5ezCc2vck03wKyU7U4U1yS1B0S1MiKL/tfEs3bZa
         cjgPUy52kMdEGtcygSUQ29NPgTWi9WIfVufZrMSJ3b8E2LbQMLIqeAAL2/4B68V/Z+da
         5lYa5YzHFmFCN+MjRoDfabRZJF4ffLTHMoctV59JSS49EqIv2x2U0WRMc6zronBD9+nT
         4uF2KL/fbh8rcdT6I6qml1IAn1g6YqT1H1j/Y2bShMTVCbasOiLeI762Owaxr5jwVuxy
         uzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707704; x=1786312504;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cmKFkPc8uWOvZ02aIzcS8pqwykgpBkJTCfqehw1k6ls=;
        b=WNFk9PUvwnuIx0Pxqmpm2AtCc8DEvF2o9cFkM97yRoEsmq46YFgi0zhKgKfk8iBJiG
         0QPeJOc2tdahmUP25BhZypVKnhBGrXTmIhVa4kaYBLTzmOK35LarQnbv6urW3DdEAGlK
         jseFlra/b4UA7HFXzMI0LbJKlhRJWG55QagzoEoZ31XMTd+qy/gOktDD1CU6TfWzX35w
         KR+nyMgryWCz/BPTBqB+yYAQXwpytPBe4SU/t9ZhqSt27fdcI1P3ynbERxLEgQ6t7C0G
         aaoaxbnWcvC8f5fQDlM/KR3semMqGIjIR2pH3gvN0ScXoxIwmeiZ56sZLaCAOni+RT9t
         p6Wg==
X-Forwarded-Encrypted: i=1; AHgh+RodC4usLbBxQpQeSiVPTXdGelzTx0D7+uVbTtCs29yypnFaTzR1j7sjPv2QcG9kVjLJNsovcKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7nJul44auWCKklWPyqb4fAF4AL0R7s6M/QwLyrDGib0kw1WG
	1CxDyuNMvYL0Kyc6xMf0Tj3QmuSvLrs80V18VsNv1BhkdyBeC0xXVkCEBAzU7E61YSc8f+ZR/1q
	XsPQLRQ==
X-Received: from dlbvv7.prod.google.com ([2002:a05:7022:5f07:b0:139:fea6:ad4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:310c:b0:3c0:9c19:65a0
 with SMTP id adf61e73a8af0-3c92a95b9damr7174685637.72.1785707703486; Sun, 02
 Aug 2026 14:55:03 -0700 (PDT)
Date: Sun,  2 Aug 2026 14:54:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260802215459.2769283-1-surenb@google.com>
Subject: [PATCH v3 0/5] mm: Unconditional per-VMA locks and cleanups
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
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

Changes from v2 [1]:
Patch 1
- Removed new CONFIG_PER_VMA_LOCK usage in kernel/bpf/stackmap.c
- Modified lock_vma_under_rcu Rust implementation, per Alice Ryhl
Patch 2
- Added binder_alloc_is_mapped() check to allow page freeing if the vma is
unmapped, per Alice Ryhl and Carlos Llamas
- Removed earlier Reviewed-by's and Acked-by's
Patch 3
- Modified comments for vma_start_read_locked_nested(),
vma_start_read_locked() and uffd_lock_vma(), per Vlastimil Babka
- Updated vma_start_read_unlocked() to call vma_lookup(), per Dave Hansen
- Added a check for VMA to be valid before calling
vma_start_read_locked(), per Vlastimil Babka
- Replaced guard with mmap_read_lock/mmap_read_unlock
- Modified the comment to indicate mmap_locking is temporary,
per Vlastimil Babka
Patch 4
- Removed earlier Reviewed-by's and Acked-by's
- Added Rust version of vma_start_read_unlocked() and used it in Rust
version of the binder driver, per Alice Ryhl
Patch 5
- Replaced lock_vma_under_rcu_wait() with vma_start_read_unlocked() in the
changelog, per Vlastimil Babka

Applies cleanly over mm-unstable

[1] https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc=
.intel.com/

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
 drivers/android/binder_alloc.c         | 46 ++++++-------
 fs/proc/internal.h                     |  2 -
 fs/proc/task_mmu.c                     | 93 --------------------------
 include/linux/mm.h                     | 12 ----
 include/linux/mm_types.h               |  8 +--
 include/linux/mmap_lock.h              | 65 +++---------------
 kernel/bpf/stackmap.c                  | 16 +----
 kernel/bpf/task_iter.c                 |  5 --
 kernel/fork.c                          |  2 -
 mm/Kconfig                             | 13 ----
 mm/Kconfig.debug                       |  1 -
 mm/debug.c                             |  4 --
 mm/init-mm.c                           |  2 -
 mm/memory.c                            |  2 -
 mm/mmap_lock.c                         | 53 ++++++++-------
 mm/pagewalk.c                          |  2 -
 mm/rmap.c                              |  2 -
 mm/userfaultfd.c                       | 61 ++---------------
 net/ipv4/tcp.c                         | 31 +++------
 rust/kernel/mm.rs                      | 38 +++++++----
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 31 files changed, 106 insertions(+), 386 deletions(-)


base-commit: 94f9b3980dd446b56acf1dfed649e9b32a9f3813
--=20
2.55.0.508.g3f0d502094-goog

