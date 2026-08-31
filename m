Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762938B12D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208267; cv=none; b=FcDayg2TGMko+lUbmiMdNoVPdtIg9u6B6tPu2YTKxacc6z/i3XvrReEVHtrMsQbhG3U2D1Km0rT6JiTtxkYH/iltKUNKwzyG4j5fRNn6jfPgEDApTfGPSuRfGvlK0WvpsDgdMQq6KBoUVeJRIT+8W6Fe84hbj//raAirp4RWbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208267; c=relaxed/simple;
	bh=Ouv2uOgETbMRJXR8YkrtDs0dcskv5u5kBsaCdK4/3xk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oPUkZmXLSLICJJhiGeoboconrmhvh+CiB5rz6qTiGQ4jRY1Urn7KBKRf3VFNyIyHr6MUxj9zWEpIfpLur/gmtYvq+uBvok86h91IHNbYGEaZFxv3W4+rw3VGKhiibn02vaUE9BcBSR/S/W5HQmEjsf8KF8KvIpk8vgFCCFnMqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rf6c+ur5; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rf6c+ur5"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso174848a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208264; x=1788813064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MD955j7svwcecXFODkmvNY3vK8UjCpMQPU48awBPMVA=;
        b=Rf6c+ur5FaUAgN12pDIBmtVUvYNgjRN3m2uhfl2CNBzB3jE3aO5/BMuIiXF0mmXzSZ
         wDSNyRF7AUNkhUXnwDWeoHyOMWCgNs7vFH1I/8u2MEFaq0Fy1nzM249n8doHvRHKn/F9
         wyd/75f3LHTaN/brxcTnfxpugFTNMvWZYvWEllr54o6MyLA5JBDkIfJsoxEDR9EmhANp
         EIHt5NaNhLVMIWD4D7sdtvIePxyH0qXXznrItKOhsigNhT+KoY9prpnx9IIt9SIAbQhf
         +pNsxJpCRyZ2velNEgnF2RGRfEF8uEEAd69w9THp22aJukFFpCyiQDCg9pJElm6+obGq
         QJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208264; x=1788813064;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MD955j7svwcecXFODkmvNY3vK8UjCpMQPU48awBPMVA=;
        b=Q89zI6lN6UVe5wXj8NnQU/QsoaNxSmE3ERk4BeYONVB+YrppW9RK/1yVRWH5HQch6/
         HGPvnVyB4+r7RJiSOXumABgae5ssRnFm0orH4FkcPRHjN1uZnTx+H64RAG2xFJFe4xx/
         0LpFcLsH0ffZ+hIeAtAxX02cx904nZtVtuaD+8j9NvpMRV1dEUJyihOM6dlAOWkB/WdM
         /uYWxL6A/kXqRO4sXRaGrw/o/WIOS0rehFytFg7+yvH1v1AQ+Z0p6L+0DtzO30N2KDXJ
         DvMpVSskCcHMdeN55ZNVb5PS+ddHOiOlB3R8rJZtrgaxsjcJMUmk6xzqFN9g64u/5Fdy
         Us3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4sqJbI7WUOhTcUnrhqtpDU6WsXj2vp7bWzPyU23OrYQ7pJMf/MkO5cJ1DAMny8CsR3S3wZGQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nNDyVC7wIoGbdiXKMo5/h2a4NCKRwo4uVkcYQv964uVMr4Czzw
	5W79/H9C22w3fA1A4Y+YFxzU43v362XRB3jJAr3HPn6zSxVxUGpqoMcJn6nOc+yKL3Znh/SzOZA
	JbuXnBw==
X-Received: from dlbvt12.prod.google.com ([2002:a05:7022:3f8c:b0:142:d756:9ce9])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a29:b0:3d1:be60:281b
 with SMTP id adf61e73a8af0-3d268ef9eb5mr42600453637.15.1788208263607; Mon, 31
 Aug 2026 13:31:03 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:52 -0700
In-Reply-To: <20260831203056.838265-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-2-surenb@google.com>
Subject: [PATCH v7 1/5] mm: Make per-VMA locks available universally
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

From: Dave Hansen <dave.hansen@linux.intel.com>

The per-VMA locks have been around for several years. They've had some
bugs worked out of them and have seen quite wide use. However, they
are still only available when architectures explicitly enable them.
Remove the conditional compilation around the per-VMA locks, making
them available on all architectures and configs.

The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
when the architecture started using per-VMA locks in the fault
handler. But, contrary to the naming, the Kconfig option does not
really indicate whether the architecture supports per-VMA locks or
not. It is more of a marker for whether the architecture is likely to
benefit from per-VMA locks.

To me, the most important thing side-effect of universal availability
is letting per-VMA locks be used in SMP=3Dn configs. This lets us use
per-VMA locking in all x86 code without fallbacks.

Overall, this just generally makes the kernel simpler. Just look at
the diffstat. It also opens the door to users that want to use the
per-VMA locks in common code. Doing *that* brings additional
simplifications.

The downside of this is adding some fields to vm_area_struct and
mm_struct. There are likely ways to optimize this, especially for
things like SMP=3Dn configs. For now, do the simplest thing: use the
same implementation everywhere.

=3D=3D Considerations for NOMMU config =3D=3D

NOMMU systems do not write-lock VMAs, therefore read-locking a VMA
would always succeed unless VMA is detached. Therefore for NOMMU
config we make vma_mark_attached() a NOOP, which keeps VMAs always in
detached state. This causes VMA read-locking to always fail and the
caller falls back to locking mmap_lock.

The following functions will have a different implementation in NOMMU
config:

- vma_mark_attached(), vma_mark_detached() are made NOOPs, keeping VMAs
always in a detached state and preventing assertions and refcount
underflows;

- vma_start_write(), vma_start_write_killable() are made NOOPs to avoid
warnings in __vma_start_write() due to VMAs being detached.
These functions are not used in NOMMU code but __vma_start_write()
is an exported function, therefore might be used by drivers.

- vma_assert_attached() is made NOOP because it's reachable from NOMMU
code via split_vma()->vma_iter_store_new()->vma_iter_store_overwrite();

- vma_assert_write_locked() is asserting vma->vm_mm is write-locked, as
was done before this change;

- vma_assert_locked() is asserting vma->vm_mm is locked, as was done
before this change;

The following functions work for both MMU and NOMMU configs:

- vma_lock_init() performs the same initialization as for MMU config;

- mm_lock_seqcount_init(), mm_lock_seqcount_begin(), mm_lock_seqcount_end()
are called from mmap_write_{lock|unlock} and update mm_lock_seq correctly.

- mmap_lock_speculate_try_begin(), mmap_lock_speculate_retry() work as is
because mm_lock_seq is updated correctly;

- vma_start_read(), vma_start_read_locked() will always fail because VMAs
are always detached;

- vma_end_read() will never be called because vma_start_read() never
succeeds;

- vma_is_attached() always return false because VMAs are always detached;

- vma_assert_detached() will never trigger because VMAs are never attached;

- vma_start_read_locked() always return false because VMAs are always
detached;

- lock_vma_under_rcu() will be safe as the attempted read lock will bail;

Changes in the following files are not affecting NOMMU config:

task_mmu.c - not compiled when CONFIG_MMU=3Dn;
pagewalk.c - not compiled when CONFIG_MMU=3Dn;
userfaultfd.c - not compiled when CONFIG_MMU=3Dn (CONFIG_USERFAULTFD depend=
s
on CONFIG_MMU);

The following changes in the BPF code are made to keep NOMMU config
working like before:

stack_map_lock_vma() - keeps mmap_lock in NOMMU config;
bpf_iter_task_vma_new() - bails out in NOMMU config;

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
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
Cc: David S. Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 arch/arm/Kconfig                       |  1 -
 arch/arm64/Kconfig                     |  1 -
 arch/loongarch/Kconfig                 |  1 -
 arch/powerpc/platforms/powernv/Kconfig |  1 -
 arch/powerpc/platforms/pseries/Kconfig |  1 -
 arch/riscv/Kconfig                     |  1 -
 arch/s390/Kconfig                      |  1 -
 arch/x86/Kconfig                       |  2 -
 fs/proc/internal.h                     |  2 -
 fs/proc/task_mmu.c                     | 93 --------------------------
 include/linux/mm.h                     | 12 ----
 include/linux/mm_types.h               |  8 +--
 include/linux/mmap_lock.h              | 75 +++++++--------------
 kernel/bpf/stackmap.c                  | 17 ++---
 kernel/bpf/task_iter.c                 |  2 +-
 kernel/fork.c                          |  2 -
 mm/Kconfig                             | 12 ----
 mm/Kconfig.debug                       |  1 -
 mm/debug.c                             |  4 --
 mm/init-mm.c                           |  2 -
 mm/memory.c                            |  2 -
 mm/mmap_lock.c                         | 26 +------
 mm/pagewalk.c                          |  2 -
 mm/rmap.c                              |  2 -
 mm/userfaultfd.c                       | 55 ---------------
 rust/kernel/mm.rs                      | 32 +++------
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 28 files changed, 48 insertions(+), 316 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f10379dfe7a3..3075e5c60a25 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,7 +42,6 @@ config ARM
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..2bbeded33da0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -81,7 +81,6 @@ config ARM64
 	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SCHED_SMT
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a21f51e5815e..9c5def706222 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -69,7 +69,6 @@ config LOONGARCH
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_PTE_PROTNONE if 64BIT
 	select ARCH_SUPPORTS_NUMA_BALANCING if NUMA
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SCHED_SMT if SMP
 	select ARCH_SUPPORTS_SCHED_MC  if SMP
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platform=
s/powernv/Kconfig
index b5ad7c173ef0..dd8f6060fb7a 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -17,7 +17,6 @@ config PPC_POWERNV
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
 	select FORCE_SMP
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select PPC_RADIX_BROADCAST_TLBIE if PPC_RADIX_MMU
 	default y
=20
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platform=
s/pseries/Kconfig
index 74910ce3a541..7d125e288f6e 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -23,7 +23,6 @@ config PPC_PSERIES
 	select HOTPLUG_CPU
 	select FORCE_SMP
 	select SWIOTLB
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select PPC_RADIX_BROADCAST_TLBIE if PPC_RADIX_MMU
 	default y
=20
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f8e26c4bed2b..505eed4af932 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -72,7 +72,6 @@ config RISCV
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
-	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_HAS_PTE_PROTNONE if MMU
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..b88b85042136 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -156,7 +156,6 @@ config S390
 	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USES_CFI_GENERIC_LLVM_PASS if CC_IS_CLANG
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..ac92b3fd70c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,7 +27,6 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
-	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
@@ -1849,7 +1848,6 @@ config X86_USER_SHADOW_STACK
 	bool "X86 userspace shadow stack"
 	depends on AS_WRUSS
 	depends on X86_64
-	depends on PER_VMA_LOCK
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 04bd6c9e65a7..623bb43ede55 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -385,10 +385,8 @@ struct mem_size_stats;
=20
 struct proc_maps_locking_ctx {
 	struct mm_struct *mm;
-#ifdef CONFIG_PER_VMA_LOCK
 	bool mmap_locked;
 	struct vm_area_struct *locked_vma;
-#endif
 };
=20
 struct proc_maps_private {
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..e671b4fd8ded 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -130,8 +130,6 @@ static void release_task_mempolicy(struct proc_maps_pri=
vate *priv)
 }
 #endif
=20
-#ifdef CONFIG_PER_VMA_LOCK
-
 static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 {
 	int ret =3D mmap_read_lock_killable(lock_ctx->mm);
@@ -233,46 +231,6 @@ static inline void reacquire_rcu(struct proc_maps_priv=
ate *priv)
 	vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
 }
=20
-#else /* CONFIG_PER_VMA_LOCK */
-
-static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
-{
-	return mmap_read_lock_killable(lock_ctx->mm);
-}
-
-static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
-{
-	mmap_read_unlock(lock_ctx->mm);
-}
-
-static inline bool lock_vma_range(struct seq_file *m,
-				  struct proc_maps_locking_ctx *lock_ctx)
-{
-	return lock_ctx_mm(lock_ctx) =3D=3D 0;
-}
-
-static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx=
)
-{
-	unlock_ctx_mm(lock_ctx);
-}
-
-static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
-					   loff_t last_pos)
-{
-	return vma_next(&priv->iter);
-}
-
-static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
-					 loff_t pos)
-{
-	return false;
-}
-
-static inline void drop_rcu(struct proc_maps_private *priv) {}
-static inline void reacquire_rcu(struct proc_maps_private *priv) {}
-
-#endif /* CONFIG_PER_VMA_LOCK */
-
 static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppo=
s)
 {
 	struct proc_maps_private *priv =3D m->private;
@@ -560,8 +518,6 @@ static int pid_maps_open(struct inode *inode, struct fi=
le *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
=20
-#ifdef CONFIG_PER_VMA_LOCK
-
 static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
 {
 	reset_lock_ctx(lock_ctx);
@@ -612,26 +568,6 @@ static struct vm_area_struct *query_vma_find_by_addr(s=
truct proc_maps_locking_ct
 	return vma;
 }
=20
-#else /* CONFIG_PER_VMA_LOCK */
-
-static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
-{
-	return mmap_read_lock_killable(lock_ctx->mm);
-}
-
-static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
-{
-	mmap_read_unlock(lock_ctx->mm);
-}
-
-static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_lock=
ing_ctx *lock_ctx,
-						     unsigned long addr)
-{
-	return find_vma(lock_ctx->mm, addr);
-}
-
-#endif  /* CONFIG_PER_VMA_LOCK */
-
 static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_=
ctx *lock_ctx,
 						 unsigned long addr, u32 flags)
 {
@@ -1314,8 +1250,6 @@ static const struct mm_walk_ops smaps_shmem_walk_ops =
=3D {
 	.walk_lock		=3D PGWALK_RDLOCK,
 };
=20
-#ifdef CONFIG_PER_VMA_LOCK
-
 static const struct mm_walk_ops smaps_walk_vma_lock_ops =3D {
 	.pmd_entry		=3D smaps_pte_range,
 	.hugetlb_entry		=3D smaps_hugetlb_range,
@@ -1345,22 +1279,6 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *p=
riv)
 	return &smaps_shmem_walk_vma_lock_ops;
 }
=20
-#else /* CONFIG_PER_VMA_LOCK */
-
-static inline const struct mm_walk_ops *
-get_smaps_walk_ops(struct proc_maps_private *priv)
-{
-	return &smaps_walk_ops;
-}
-
-static inline const struct mm_walk_ops *
-get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
-{
-	return &smaps_shmem_walk_ops;
-}
-
-#endif /* CONFIG_PER_VMA_LOCK */
-
 /*
  * Gather mem stats from @vma with the indicated beginning
  * address @start, and keep them in @mss.
@@ -3497,7 +3415,6 @@ static const struct mm_walk_ops show_numa_ops =3D {
 	.walk_lock =3D PGWALK_RDLOCK,
 };
=20
-#ifdef CONFIG_PER_VMA_LOCK
 static const struct mm_walk_ops show_numa_vma_lock_ops =3D {
 	.hugetlb_entry =3D gather_hugetlb_stats,
 	.pmd_entry =3D gather_pte_stats,
@@ -3512,16 +3429,6 @@ get_show_numa_ops(struct proc_maps_private *priv)
 	return &show_numa_vma_lock_ops;
 }
=20
-#else /* CONFIG_PER_VMA_LOCK */
-
-static inline const struct mm_walk_ops *
-get_show_numa_ops(struct proc_maps_private *priv)
-{
-	return &show_numa_ops;
-}
-
-#endif /* CONFIG_PER_VMA_LOCK */
-
 /*
  * Display pages allocated per node and memory policy via /proc.
  */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..7aaa25abc241 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -928,7 +928,6 @@ static inline void vma_numab_state_free(struct vm_area_=
struct *vma) {}
  * These must be here rather than mmap_lock.h as dependent on vm_fault typ=
e,
  * declared in this header.
  */
-#ifdef CONFIG_PER_VMA_LOCK
 static inline void release_fault_lock(struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
@@ -944,17 +943,6 @@ static inline void assert_fault_locked(const struct vm=
_fault *vmf)
 	else
 		mmap_assert_locked(vmf->vma->vm_mm);
 }
-#else
-static inline void release_fault_lock(struct vm_fault *vmf)
-{
-	mmap_read_unlock(vmf->vma->vm_mm);
-}
-
-static inline void assert_fault_locked(const struct vm_fault *vmf)
-{
-	mmap_assert_locked(vmf->vma->vm_mm);
-}
-#endif /* CONFIG_PER_VMA_LOCK */
=20
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6d815f6440c9..5413bd10fff2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -950,7 +950,6 @@ struct vm_area_struct {
 		vma_flags_t flags;
 	};
=20
-#ifdef CONFIG_PER_VMA_LOCK
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
@@ -966,7 +965,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-#endif
+
 	/*
 	 * Low 32-bits of anonymous page offset.
 	 * See vma_start_anon_pgoff() comment for details.
@@ -1003,7 +1002,6 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
-#ifdef CONFIG_PER_VMA_LOCK
 	/*
 	 * Used to keep track of firstly, whether the VMA is attached, secondly,
 	 * if attached, how many read locks are taken, and thirdly, if the
@@ -1046,7 +1044,6 @@ struct vm_area_struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map vmlock_dep_map;
 #endif
-#endif
 #ifdef CONFIG_64BIT
 	/*
 	 * High 32-bits of anonymous page offset.
@@ -1254,7 +1251,6 @@ struct mm_struct {
 					  * init_mm.mmlist, and are protected
 					  * by mmlist_lock
 					  */
-#ifdef CONFIG_PER_VMA_LOCK
 		struct rcuwait vma_writer_wait;
 		/*
 		 * This field has lock-like semantics, meaning it is sometimes
@@ -1274,7 +1270,7 @@ struct mm_struct {
 		 * mmap_lock.
 		 */
 		seqcount_t mm_lock_seq;
-#endif
+
 		struct futex_mm_data	futex;
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index bec0eab6ef03..27c00bac29f9 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -76,8 +76,6 @@ static inline void mmap_assert_write_locked(const struct =
mm_struct *mm)
 	rwsem_assert_held_write(&mm->mmap_lock);
 }
=20
-#ifdef CONFIG_PER_VMA_LOCK
-
 #ifdef CONFIG_LOCKDEP
 #define __vma_lockdep_map(vma) (&vma->vmlock_dep_map)
 #else
@@ -297,6 +295,9 @@ int __vma_start_write(struct vm_area_struct *vma, int s=
tate);
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU))
+		return;
+
 	if (__is_vma_write_locked(vma))
 		return;
=20
@@ -319,6 +320,9 @@ static inline void vma_start_write(struct vm_area_struc=
t *vma)
 static inline __must_check
 int vma_start_write_killable(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU))
+		return 0;
+
 	if (__is_vma_write_locked(vma))
 		return 0;
=20
@@ -331,6 +335,11 @@ int vma_start_write_killable(struct vm_area_struct *vm=
a)
  */
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		mmap_assert_write_locked(vma->vm_mm);
+		return;
+	}
+
 	VM_WARN_ON_ONCE_VMA(!__is_vma_write_locked(vma), vma);
 }
=20
@@ -343,6 +352,11 @@ static inline void vma_assert_locked(struct vm_area_st=
ruct *vma)
 {
 	unsigned int refcnt;
=20
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		mmap_assert_locked(vma->vm_mm);
+		return;
+	}
+
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
 		if (!lock_is_held(__vma_lockdep_map(vma)))
 			vma_assert_write_locked(vma);
@@ -432,6 +446,9 @@ static inline bool vma_is_attached(struct vm_area_struc=
t *vma)
  */
 static inline void vma_assert_attached(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU))
+		return;
+
 	WARN_ON_ONCE(!vma_is_attached(vma));
 }
=20
@@ -442,6 +459,9 @@ static inline void vma_assert_detached(struct vm_area_s=
truct *vma)
=20
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU))
+		return;
+
 	vma_assert_write_locked(vma);
 	vma_assert_detached(vma);
 	refcount_set_release(&vma->vm_refcnt, 1);
@@ -451,6 +471,9 @@ void __vma_exclude_readers_for_detach(struct vm_area_st=
ruct *vma);
=20
 static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
+	if (!IS_ENABLED(CONFIG_MMU))
+		return;
+
 	vma_assert_write_locked(vma);
 	vma_assert_attached(vma);
=20
@@ -484,54 +507,6 @@ struct vm_area_struct *lock_next_vma(struct mm_struct =
*mm,
 				     struct vma_iterator *iter,
 				     unsigned long address);
=20
-#else /* CONFIG_PER_VMA_LOCK */
-
-static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
-static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
-static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-
-static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, uns=
igned int *seq)
-{
-	return false;
-}
-
-static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigne=
d int seq)
-{
-	return true;
-}
-static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_re=
fcnt) {}
-static inline void vma_end_read(struct vm_area_struct *vma) {}
-static inline void vma_start_write(struct vm_area_struct *vma) {}
-static inline __must_check
-int vma_start_write_killable(struct vm_area_struct *vma) { return 0; }
-static inline void vma_assert_write_locked(struct vm_area_struct *vma)
-		{ mmap_assert_write_locked(vma->vm_mm); }
-static inline bool vma_is_attached(struct vm_area_struct *vma)
-		{ return true; }
-static inline void vma_assert_attached(struct vm_area_struct *vma) {}
-static inline void vma_assert_detached(struct vm_area_struct *vma) {}
-static inline void vma_mark_attached(struct vm_area_struct *vma) {}
-static inline void vma_mark_detached(struct vm_area_struct *vma) {}
-
-static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *=
mm,
-		unsigned long address)
-{
-	return NULL;
-}
-
-static inline void vma_assert_locked(struct vm_area_struct *vma)
-{
-	mmap_assert_locked(vma->vm_mm);
-}
-
-static inline void vma_assert_stabilised(struct vm_area_struct *vma)
-{
-	/* If no VMA locks, then either mmap lock suffices to stabilise. */
-	mmap_assert_locked(vma->vm_mm);
-}
-
-#endif /* CONFIG_PER_VMA_LOCK */
-
 static inline void vma_assert_can_modify(struct vm_area_struct *vma)
 {
 	if (vma_is_attached(vma))
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a839041e0d00..8fb70c2a9c8e 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -272,13 +272,10 @@ struct stack_map_vma_lock {
 /*
  * Acquire a stable read-side reference on the VMA covering @ip.
  *
- * With CONFIG_PER_VMA_LOCK=3Dy this returns a VMA with its per-VMA read
- * lock held and mmap_lock dropped, so the caller may sleep.
- *
- * With CONFIG_PER_VMA_LOCK=3Dn it returns a VMA with mmap_lock still
- * held; the caller must snapshot any fields it needs and pin vm_file
- * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
- * the VMA may be split, merged, or freed after that.
+ * On NOMMU configurations, returns with the mmap_lock held.  If the MMU
+ * is enabled, the per-VMA lock will be held instead.  The lock
+ * should be released with stack_map_unlock_vma() which will release the
+ * appropriate lock.  Once the lock is released, the VMA may be freed.
  *
  * Returns NULL on failure, in which case no lock is held.
  */
@@ -288,7 +285,6 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, uns=
igned long ip)
 	struct mm_struct *mm =3D lock->mm;
 	struct vm_area_struct *vma;
=20
-	/* noop under !CONFIG_PER_VMA_LOCK */
 	vma =3D lock_vma_under_rcu(mm, ip);
 	if (vma) {
 		lock->vma =3D vma;
@@ -308,21 +304,20 @@ stack_map_lock_vma(struct stack_map_vma_lock *lock, u=
nsigned long ip)
 		return NULL;
 	}
=20
-#ifdef CONFIG_PER_VMA_LOCK
+#ifdef CONFIG_MMU
 	if (!vma_start_read_locked(vma)) {
 		mmap_read_unlock(mm);
 		return NULL;
 	}
 	mmap_read_unlock(mm);
 #endif
-
 	lock->vma =3D vma;
 	return vma;
 }
=20
 static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
 {
-#ifdef CONFIG_PER_VMA_LOCK
+#ifdef CONFIG_MMU
 	vma_end_read(lock->vma);
 #else
 	mmap_read_unlock(lock->mm);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 13e1aabe6f88..c65ba1dcd866 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -869,7 +869,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_t=
ask_vma *it,
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(struct bpf=
_iter_task_vma));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __alignof__(=
struct bpf_iter_task_vma));
=20
-	if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
+	if (!IS_ENABLED(CONFIG_MMU)) {
 		kit->data =3D NULL;
 		return -EOPNOTSUPP;
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..22283bf849e1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1083,9 +1083,7 @@ static void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
 	mm_lock_seqcount_init(mm);
-#ifdef CONFIG_PER_VMA_LOCK
 	rcuwait_init(&mm->vma_writer_wait);
-#endif
 }
=20
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p)
diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..ece5d37b4eb7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1430,18 +1430,6 @@ config LRU_GEN_WALKS_MMU
 	depends on LRU_GEN && ARCH_HAS_HW_PTE_YOUNG
 # }
=20
-config ARCH_SUPPORTS_PER_VMA_LOCK
-       def_bool n
-
-config PER_VMA_LOCK
-	def_bool y
-	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
-	help
-	  Allow per-vma locking during page fault handling.
-
-	  This feature allows locking each virtual memory area separately when
-	  handling page faults instead of taking mmap_lock.
-
 config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 15dca19dd07d..9eaa25d1cf23 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -310,7 +310,6 @@ config DEBUG_KMEMLEAK_VERBOSE
=20
 config PER_VMA_LOCK_STATS
 	bool "Statistics for per-vma locks"
-	depends on PER_VMA_LOCK
 	help
 	  Say Y here to enable success, retry and failure counters of page
 	  faults handled under protection of per-vma locks. When enabled, the
diff --git a/mm/debug.c b/mm/debug.c
index 9a0297b3988d..655e6bcc0e8d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -157,17 +157,13 @@ void dump_vma(const struct vm_area_struct *vma)
 	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
-#ifdef CONFIG_PER_VMA_LOCK
 		"refcnt %x\n"
-#endif
 		"flags: %#lx(%pGv)\n",
 		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma_start_pgoff(vma),
 		vma->vm_file, vma->vm_private_data,
-#ifdef CONFIG_PER_VMA_LOCK
 		refcount_read(&vma->vm_refcnt),
-#endif
 		vma->vm_flags, &vma->vm_flags);
 }
 EXPORT_SYMBOL(dump_vma);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3e792aad7626..a1bb2c2d0284 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -39,10 +39,8 @@ struct mm_struct init_mm =3D {
 	.page_table_lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		=3D LIST_HEAD_INIT(init_mm.mmlist),
-#ifdef CONFIG_PER_VMA_LOCK
 	.vma_writer_wait =3D __RCUWAIT_INITIALIZER(init_mm.vma_writer_wait),
 	.mm_lock_seq	=3D SEQCNT_ZERO(init_mm.mm_lock_seq),
-#endif
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock =3D __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 8b0c2c735d3d..7bd660d48ff7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6817,7 +6817,6 @@ static vm_fault_t sanitize_fault_flags(struct vm_area=
_struct *vma,
 				 !vma_is_cow_mapping(vma)))
 			return VM_FAULT_SIGSEGV;
 	}
-#ifdef CONFIG_PER_VMA_LOCK
 	/*
 	 * Per-VMA locks can't be used with FAULT_FLAG_RETRY_NOWAIT because of
 	 * the assumption that lock is dropped on VM_FAULT_RETRY.
@@ -6826,7 +6825,6 @@ static vm_fault_t sanitize_fault_flags(struct vm_area=
_struct *vma,
 			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)) =3D=3D
 			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)))
 		return VM_FAULT_SIGSEGV;
-#endif
=20
 	return 0;
 }
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 898c2ef1e958..272f9ac762b9 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -43,9 +43,6 @@ void __mmap_lock_do_trace_released(struct mm_struct *mm, =
bool write)
 EXPORT_SYMBOL(__mmap_lock_do_trace_released);
 #endif /* CONFIG_TRACING */
=20
-#ifdef CONFIG_MMU
-#ifdef CONFIG_PER_VMA_LOCK
-
 /* State shared across __vma_[start, end]_exclude_readers. */
 struct vma_exclude_readers_state {
 	/* Input parameters. */
@@ -299,6 +296,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_str=
uct *mm,
 	MA_STATE(mas, &mm->mm_mt, address, address);
 	struct vm_area_struct *vma;
=20
+	if (!IS_ENABLED(CONFIG_MMU))
+		return NULL;
 retry:
 	rcu_read_lock();
 	vma =3D mas_walk(&mas);
@@ -431,7 +430,6 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *=
mm,
=20
 	return vma;
 }
-#endif /* CONFIG_PER_VMA_LOCK */
=20
 #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
 #include <linux/extable.h>
@@ -548,23 +546,3 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_=
struct *mm,
 	return NULL;
 }
 #endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
-
-#else /* CONFIG_MMU */
-
-/*
- * At least xtensa ends up having protection faults even with no
- * MMU.. No stack expansion, at least.
- */
-struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
-			unsigned long addr, struct pt_regs *regs)
-{
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	vma =3D vma_lookup(mm, addr);
-	if (!vma)
-		mmap_read_unlock(mm);
-	return vma;
-}
-
-#endif /* CONFIG_MMU */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cc07fcf50e87..7411702a37f5 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -444,7 +444,6 @@ static inline void process_mm_walk_lock(struct mm_struc=
t *mm,
 static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 					 enum page_walk_lock walk_lock)
 {
-#ifdef CONFIG_PER_VMA_LOCK
 	switch (walk_lock) {
 	case PGWALK_WRLOCK:
 		vma_start_write(vma);
@@ -459,7 +458,6 @@ static inline void process_vma_walk_lock(struct vm_area=
_struct *vma,
 		/* PGWALK_RDLOCK is handled by process_mm_walk_lock */
 		break;
 	}
-#endif
 }
=20
 /*
diff --git a/mm/rmap.c b/mm/rmap.c
index d1819fd69938..fed0362e0bd0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -260,11 +260,9 @@ static void check_anon_vma_clone(struct vm_area_struct=
 *dst,
 	/* For the anon_vma to be compatible, it can only be singular. */
 	VM_WARN_ON_ONCE(operation =3D=3D VMA_OP_MERGE_UNFAULTED &&
 			!list_is_singular(&src->anon_vma_chain));
-#ifdef CONFIG_PER_VMA_LOCK
 	/* Only merging an unfaulted VMA leaves the destination attached. */
 	VM_WARN_ON_ONCE(operation !=3D VMA_OP_MERGE_UNFAULTED &&
 			vma_is_attached(dst));
-#endif
 }
=20
 static void maybe_reuse_anon_vma(struct vm_area_struct *dst,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74f04c323c50..d157e15fc77c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -122,7 +122,6 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct=
 mm_struct *mm,
 	return vma;
 }
=20
-#ifdef CONFIG_PER_VMA_LOCK
 /*
  * uffd_lock_vma() - Lookup and lock vma corresponding to @address.
  * @mm: mm to search vma in.
@@ -182,34 +181,6 @@ static void uffd_mfill_unlock(struct vm_area_struct *v=
ma)
 	vma_end_read(vma);
 }
=20
-#else
-
-static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
-					      unsigned long dst_start,
-					      unsigned long len)
-{
-	struct vm_area_struct *dst_vma;
-
-	mmap_read_lock(dst_mm);
-	dst_vma =3D find_vma_and_prepare_anon(dst_mm, dst_start);
-	if (IS_ERR(dst_vma))
-		goto out_unlock;
-
-	if (validate_dst_vma(dst_vma, dst_start + len))
-		return dst_vma;
-
-	dst_vma =3D ERR_PTR(-ENOENT);
-out_unlock:
-	mmap_read_unlock(dst_mm);
-	return dst_vma;
-}
-
-static void uffd_mfill_unlock(struct vm_area_struct *vma)
-{
-	mmap_read_unlock(vma->vm_mm);
-}
-#endif
-
 static void mfill_put_vma(struct mfill_state *state)
 {
 	if (!state->vma)
@@ -1850,7 +1821,6 @@ int find_vmas_mm_locked(struct mm_struct *mm,
 	return 0;
 }
=20
-#ifdef CONFIG_PER_VMA_LOCK
 static int uffd_move_lock(struct mm_struct *mm,
 			  unsigned long dst_start,
 			  unsigned long src_start,
@@ -1925,31 +1895,6 @@ static void uffd_move_unlock(struct vm_area_struct *=
dst_vma,
 		vma_end_read(dst_vma);
 }
=20
-#else
-
-static int uffd_move_lock(struct mm_struct *mm,
-			  unsigned long dst_start,
-			  unsigned long src_start,
-			  struct vm_area_struct **dst_vmap,
-			  struct vm_area_struct **src_vmap)
-{
-	int err;
-
-	mmap_read_lock(mm);
-	err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap)=
;
-	if (err)
-		mmap_read_unlock(mm);
-	return err;
-}
-
-static void uffd_move_unlock(struct vm_area_struct *dst_vma,
-			     struct vm_area_struct *src_vma)
-{
-	mmap_assert_locked(src_vma->vm_mm);
-	mmap_read_unlock(dst_vma->vm_mm);
-}
-#endif
-
 /**
  * move_pages - move arbitrary anonymous pages of an existing vma
  * @ctx: pointer to the userfaultfd context
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 4764d7b68f2a..f4fa54616085 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -170,30 +170,20 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_s=
truct) -> &'a MmWithUser {
     ///
     /// This is an optimistic trylock operation, so it may fail if there i=
s contention. In that
     /// case, you should fall back to taking the mmap read lock.
-    ///
-    /// When per-vma locks are disabled, this always returns `None`.
     #[inline]
     pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGua=
rd<'_>> {
-        #[cfg(CONFIG_PER_VMA_LOCK)]
-        {
-            // SAFETY: Calling `bindings::lock_vma_under_rcu` is always ok=
ay given an mm where
-            // `mm_users` is non-zero.
-            let vma =3D unsafe { bindings::lock_vma_under_rcu(self.as_raw(=
), vma_addr) };
-            if !vma.is_null() {
-                return Some(VmaReadGuard {
-                    // SAFETY: If `lock_vma_under_rcu` returns a non-null =
ptr, then it points at a
-                    // valid vma. The vma is stable for as long as the vma=
 read lock is held.
-                    vma: unsafe { VmaRef::from_raw(vma) },
-                    _nts: NotThreadSafe,
-                });
-            }
+        // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay g=
iven an mm where
+        // `mm_users` is non-zero.
+        let vma =3D unsafe { bindings::lock_vma_under_rcu(self.as_raw(), v=
ma_addr) };
+        if vma.is_null() {
+            return None;
         }
-
-        // Silence warnings about unused variables.
-        #[cfg(not(CONFIG_PER_VMA_LOCK))]
-        let _ =3D vma_addr;
-
-        None
+        Some(VmaReadGuard {
+            // SAFETY: If `lock_vma_under_rcu` returns a non-null ptr, the=
n it points at a
+            // valid vma. The vma is stable for as long as the vma read lo=
ck is held.
+            vma: unsafe { VmaRef::from_raw(vma) },
+            _nts: NotThreadSafe,
+        })
     }
=20
     /// Lock the mmap read lock.
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/du=
p.h
index 4c58487b764e..57046d8ac81d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -560,7 +560,6 @@ struct vm_area_struct {
 		vma_flags_t flags;
 	};
=20
-#ifdef CONFIG_PER_VMA_LOCK
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
@@ -576,7 +575,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-#endif
+
 	unsigned int __vm_anon_pgoff_lo;
=20
 	/*
@@ -610,10 +609,8 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
-#ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
-#endif
 #ifdef CONFIG_64BIT
 	unsigned int __vm_anon_pgoff_hi;
 #endif
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_inter=
nal.h
index 8a48b231aa7a..54d5c3360aa2 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -15,7 +15,6 @@
 #include <stdlib.h>
=20
 #define CONFIG_MMU		1
-#define CONFIG_PER_VMA_LOCK	1
=20
 #ifdef __CONCAT
 #undef __CONCAT
--=20
2.55.0.966.g6673acef38-goog

