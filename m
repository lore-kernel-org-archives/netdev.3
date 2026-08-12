Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F492364E9A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497064; cv=none; b=NJoBek5/JXQul97n8j0Ds5tc7kcLBGinIAXjJXrNqlDrlpk8tIDNrSpte4sm2152lM0ayTc61CJz9iTV9F8yv63eZrBAW1kk8NV9rL8Mvb1iTCRWidnnc7RIGHAzq0uep/55taRKyRJxKXnel6MazoA8GOV/UyNbNPtMoPTZyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497064; c=relaxed/simple;
	bh=zzxvP5H5NRA3nF4PnwW+otE7yewJqauhIe4H/ioHBak=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=roJ5+O1vTH4MTZQ+p00msHOz7LpF2eEry48/huiBVl3k8uoiydiEhnWBHJB9282M9kQcbYM0wyZrbK7onQlrEnDaHkCJnwhrBGMUdYEdNsTgNIbU0XDhf8BYHbeC7ATaIItvQwOackDpnuAgLyPgx4ZKTUQdxT5MaK9tQsC9r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ot38mCdR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot38mCdR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso610222a91.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786497059; x=1787101859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ymmox5ngHEOJixoUwvIF+857zRrBcDTQSn1VqCUgM4A=;
        b=Ot38mCdRVLMEOJFbAbEFqykoETHW0axQWD19emZcmFUANNyKvwhzalrXYPFsvF2FS8
         yglbPCuKRdnOIUKhOgXB4IaXM3kC0dVpIosHTCJ1QQBbpIDRSnjc5TKAcEMBWappDnTr
         KjpmJxxJ5XOQ7tdKxnL66+hgiNmknYRnVGrZ7HFcXea708KWra+QpBJpoAJ1JcyksvMB
         omrewN3PFzdNsFqaPiwcwZfhExM9q3vtNM6EObrW1jvfdsV+rcYXNdSw95kjmKxgRWGc
         iB6yIUQ46DxFyEq0Up5bG7Iz4n7m2YUon273Jp6E0gWlC6QlepeDJvEIZl8/kaSuHSEh
         K8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497059; x=1787101859;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ymmox5ngHEOJixoUwvIF+857zRrBcDTQSn1VqCUgM4A=;
        b=P/hqZpcJTFEN/62QDmWyRyyBhA4Mw+R1MV1yvs1i1bMEoqMH7FLTT0XoAHOz0lyL68
         qk0jmzrYodOMN0Ot0kshc7pm+iHnt7dCv/hMTBkolHf0dvIoGnI8pFgXB3zexIEQv2pM
         oC3DMe+1uhttghhk3xLFh+W5XT7IYyACKsPeR09QiSU99W2HKJllYEYXrgMdeaODzRzf
         MYTJ+B63j91oGC0HhvqjirVkowG5CfNZRABheanJMfU9cGGNLxO0L2Upcoer4cagvkft
         B3d3cTpkrEMb/u4Bisii+wbKpUtHZgRNrWjb8NbIfZo6nssv4ilhzl7PMdGOllbLlqkB
         T8pA==
X-Forwarded-Encrypted: i=1; AHgh+Rpx2V2vN35UorVdn+/fGtkICYl0O4q3VehTNxrUB8LrR85OA7vV6tHY7X4T7oRwq7bPbN4F8P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhMfcbtCGjCFADsBwD7ypl825ECciXipw5NidJRRUAakBgTqd
	p2andbgXM1I38jEsVskdbY31L6gAGajj7o82oDJAEKq16w42hdWF9L6p+6tYKnMiqP+Pf2KJMsX
	LIjiG8g==
X-Received: from dlbro11.prod.google.com ([2002:a05:7022:158b:b0:140:ef7c:eac])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5847:b0:381:6c5:3f63
 with SMTP id 98e67ed59e1d1-393011f39e1mr1328797a91.6.1786497059420; Tue, 11
 Aug 2026 18:10:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:10:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812011056.902771-1-surenb@google.com>
Subject: [PATCH v5 0/5] mm: Unconditional per-VMA locks and cleanups
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

Changes from v4 [2]:
Patch 1:
- Changed vma_assert_locked() NOMMU implementation to assert ma->vm_mm is
  locked, per Sashiko
- Amended patch 1 changelog to include vma_start_read_locked() and
  lock_vma_under_rcu in NOMMU considerations section, per Lorenzo Stoakes
- Changed comments for stack_map_lock_vma(), per Matthew Wilcox
- Added early exit in lock_vma_under_rcu() for !CONFIG_MMU,
  per Lorenzo Stoakes
Patch 2:
- Updated changelog to explain the extra change making missing VMA
  handling consistent, per Carlos Llamas
Patch 3:
- Rewrote changelog to better represent the changes in the patch,
  per Matthew Wilcox
Patch 5:
- Fixed vma_start_read_unlocked() function name in the changelog,
  per Matthew Wilcox
All patches
- Added Acked-by and Reviewed-by, per Vlastimil Babka, Lorenzo Stoakes and
  Alice Ryhl
- Rebased over mm-unstable, per Lorenzo Stoakes

Applies cleanly over mm-unstable

[1] https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc=
.intel.com/
[2] https://lore.kernel.org/all/20260806200548.3124802-1-surenb@google.com/

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
 fs/proc/task_mmu.c                     | 93 -------------------------
 include/linux/mm.h                     | 12 ----
 include/linux/mm_types.h               |  8 +--
 include/linux/mmap_lock.h              | 94 +++++++++++---------------
 kernel/bpf/stackmap.c                  | 17 ++---
 kernel/bpf/task_iter.c                 |  2 +-
 kernel/fork.c                          |  2 -
 mm/Kconfig                             | 12 ----
 mm/Kconfig.debug                       |  1 -
 mm/debug.c                             |  4 --
 mm/init-mm.c                           |  2 -
 mm/memory.c                            |  2 -
 mm/mmap_lock.c                         | 61 ++++++++++-------
 mm/pagewalk.c                          |  2 -
 mm/rmap.c                              |  2 -
 mm/userfaultfd.c                       | 61 ++---------------
 net/ipv4/tcp.c                         | 31 +++------
 rust/kernel/mm.rs                      | 57 ++++++++++------
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 31 files changed, 166 insertions(+), 395 deletions(-)


base-commit: 1029098ee3275ea5b78e329ce132262affa2f8cc
--=20
2.55.0.691.gc56d675ccc-goog

