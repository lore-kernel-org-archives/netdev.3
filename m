Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F0383C67
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208265; cv=none; b=VWnPNBd3wdx5gKYZkEXOm7VMb8DGHhoptr+iyVGn2BTuIFjcYqj4PmWHgV3CypANo0bsYSTvY63Eibf9sffQr/weZubAEMnO4H3IFZu23MQTLflSTi+ZiRb4Nb6qMCaCAoUCWVw9LHTQUuUqjCewQ61xzOyvuXSabCWtLCAFYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208265; c=relaxed/simple;
	bh=erAR2zhPkaRzNaZ5ezE88XC7ZntEvQq048vwqWZwcS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CnW6pWhP3r3y0IwESOw7PYUMIRupcSP9pPR6hJ366AXTC1NxYd0bRB1i004amSnsXk0BqVV4gTopqjHWuXlzGVB7sF+gSaDuw5VOa9iZlkev5YPs8yy94Rj03JWlBM5ZP7Yn95WraCj9f8bTwyBHXJR2gUaBJSBISDnQRatiydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSDbAi55; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSDbAi55"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0aso394099a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208261; x=1788813061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HdPoO1BmhDpKCIht74EVe5TolJMRKRIfbTssD9lBUXc=;
        b=DSDbAi55kiJR8w+UfRXx4EKk2QEQavGGwVscicj+99pCsoG+A5Km9t6j0eq0C3tXSK
         FML+pZrWbKnfVNPFjacJYBW0I5ZYQBOxlgb/Vz2uHe4kSrG6E28BxaJwmahfMR2NvskN
         rQWjfTVwX+Fig1CIla22fpgBh/nZI/CiySmV+ciPEVNlyPwTBZJN2tqnpXMRBLhC/kUd
         vdCqtfOIpC45DaxzzwVAYlHnE78sjpoeyjXGYFeakICpVqc3NXXjVnJDVK53DG5jvqQI
         At9trc10yctMwYtrizMXG2CNl1ZVgsTgQw689ufUyyrzloPU3cH8odDTiMTIwMwOZkYP
         0IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208261; x=1788813061;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HdPoO1BmhDpKCIht74EVe5TolJMRKRIfbTssD9lBUXc=;
        b=UPZ2kQOLgFUv4lhO/W8TYdWESHlHf2/lACAgTQnMVPfWsgi1AcCMPflvkXLNmQ2PCl
         EIuki4Brx3FgnFYf3sseJl6Mn5FbLh+Vq+ZdtxeT7xwn+JyvNVJZgZ3io61W1yr7lIKU
         svO85TGUlQLW0urJYFaBOH+iqcf0AZpoWaoHMznFvIrCRGP8NKS1+xz+2yLIJfBeQryP
         aQgGj0G1FotO/1Zwa48mJHZFKXC5lLjS6+D9nvDmD7pUdTvcKFGQ6LfhKZX7a5T7lmPf
         fDSix0tbcQSRZLxVSbePDr92Xx7X56UnjVZN9lywLSzQhgpjXOUQnZ/CN5TGp9k6lQmU
         B9hA==
X-Forwarded-Encrypted: i=1; AKwUvByLorTFIBpyX/o+QsdIHpqXPbyJOEp0ZH8QtmN7RflQO4PGUH0Z5Ev9PiwPECEpUl2b9IkrF/E=@vger.kernel.org
X-Gm-Message-State: AFuF++mujRYiORJK9HoG73g6R8KnbCYoQdtUl2Zp3PRinaMZaSlrmx+j
	kEK7R/lsDjuJWdFvPb76ksUWJZa1C0pAP2bZbgeasyAcdcccnTQDBLSfaTX5y373GwcNySDgoP6
	czej38g==
X-Received: from dlbvv7.prod.google.com ([2002:a05:7022:5f07:b0:140:f5a8:30ec])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c6:b0:398:c6e1:dceb
 with SMTP id 98e67ed59e1d1-3990f757be8mr597806a91.9.1788208260811; Mon, 31
 Aug 2026 13:31:00 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-1-surenb@google.com>
Subject: [PATCH v7 0/5] mm: Unconditional per-VMA locks and cleanups
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

Changes since v6 [2]:
- Rebased over mm-unstable
Patch 1:
- Added Reviewed-by, per Lorenzo Stoakes
Patch 2:
- Added Acked-by, per Carlos Llamas
Patch 4:
- Added INVARIANT comment, per Sashiko and Alice Ryhl

Applies cleanly over mm-unstable

[1] https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc=
.intel.com/
[2] https://lore.kernel.org/all/20260813193433.3318288-1-surenb@google.com/

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
 drivers/android/binder_alloc.c         | 63 +++++++----------
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
 rust/kernel/mm.rs                      | 58 ++++++++++------
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 31 files changed, 167 insertions(+), 396 deletions(-)


base-commit: 42d64d4fef83a241c919c8693fdf0a21b2cb6061
--=20
2.55.0.966.g6673acef38-goog

