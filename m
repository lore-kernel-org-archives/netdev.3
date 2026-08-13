Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46507384232
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649680; cv=none; b=SE58Z39H2TkBmbUBtNhmhIr2ulnPgltGcHo+4AqltDE1VBVQCNkC1LIIOIHbqPNRZB7fgQuFYrDZp37FeAu1XsMBANYdKqAfIQSQp9d4eJu14/B9XcyKNzfYNUn0ZIgbOEgJ/0BBhr4Iy+Se/eQwAHsw4Vmu00r7znSNsnKnOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649680; c=relaxed/simple;
	bh=pszYivCzPET0xa1JnP+lRORaPl+hKmdl+WtEK02wUN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ucGNYoaQ1R/R870I1mdaTPEMJljOJrqPFxvN1HPRdb12noE0pU9zP9TKpMz2NQNQ+kcq8D2DsLhnB9ypjZtjyLliClHbkfPTvUEz3JUNCteXjzrpjlro6syUg7Mj4NMjbj6AKA7PTS66XzeqXVVvApf1DO6lglEk1kJmksXMl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVnf3Clo; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVnf3Clo"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so236951a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786649678; x=1787254478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=myMALrPmiftJzuMGzKXuNexYM0KxETCacC1JofGVCac=;
        b=SVnf3CloULQ2tLCJ8A+kZdAFFJltHG/NTaSGIEmSvCd9M5spKK3aKXlbnRBPRwggG7
         s6Z1eB8ll1uo7kto2Uj54+NjOmStMBcXZUuXDuyeRSMLM9CztUzbW6gnHGj1gzJp/GUg
         IAou4BPjTQ9142zr1aUsd8HzyuNQYUe9E+LfDrm2VzW6t0df9t7gso5exyuV973iintN
         W1xQgbQ1G9ct+NBi1iiKKPJ1+iL2imN95sn55kbOVj/yulk11Q01wG4X/QLuJCD1+iZs
         Knt5+VjBrszH3G5rh1rwtEWP+5uravMzgpX3hcilbPXy1iXRuHGepoLNWYHm6Sxle0J9
         JVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649678; x=1787254478;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myMALrPmiftJzuMGzKXuNexYM0KxETCacC1JofGVCac=;
        b=dcn9hwd72d0P9aSY9ICr8zobRox7ISjY+/8+rTrpNJZ+FAWvk5Nr12CwZGPl33qCTn
         5bmE+abDzPLq0U35BqaPbQuHdrB2SNtzlwJjTia/d7AJgwQZCalgvcgS93JL/XZJMNCW
         mfIRsXZ2AOcg6MfRQwb8hAau/l29Mx4hvN57tbfuBwYD12smtM5jK6RX8MVw7OHrDyJE
         5P0DIMW7LSkbX4DbbvBd4yGJJorByHK41R6agrF6y9nY+d5KwaS97rFhbPVktZ0M4Ie0
         S0nkf2aniHlgFlH8orbswNXQeNbgwrpEWm2s2PZLjSutY2FBeSbZeseTGXOfF9FUP80e
         m98w==
X-Forwarded-Encrypted: i=1; AHgh+Rqrn2812WdQciGTNNNwaAyFOybWJ4ryHyUgxBMaxIeVt0qGmQ80misNNre51SbD7MJ//RSiZtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1IXGDL1uGqY+/LRiMwMwVRf/UN7bHQ1SRO0Av11L8lfJ25vr
	q0WUbd8nh7VS/GBA6Nl4CUpFh6T24ifphbswPG4SZ7TzT+F+2z2+TEk3vuorqP1W1tpkXGLmofW
	byppRNg==
X-Received: from dybvt10.prod.google.com ([2002:a05:7301:78ca:b0:313:d014:d248])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b90:b0:37f:e177:f58
 with SMTP id 98e67ed59e1d1-3933b874ba2mr305120a91.9.1786649677316; Thu, 13
 Aug 2026 12:34:37 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:34:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813193433.3318288-1-surenb@google.com>
Subject: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
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

Changes since v5 [2]:
Patch 2:
- Removed dead code, per  Alice Ryhl
- Rebased over mm-unstable

Applies cleanly over mm-unstable

[1] https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc=
.intel.com/
[2] https://lore.kernel.org/all/20260812011056.902771-1-surenb@google.com/

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
 rust/kernel/mm.rs                      | 57 ++++++++++------
 tools/testing/vma/include/dup.h        |  5 +-
 tools/testing/vma/vma_internal.h       |  1 -
 31 files changed, 166 insertions(+), 396 deletions(-)


base-commit: f9ca2fa9ef7e9b39ec79a0596929d1a1f8704c5f
--=20
2.55.0.691.gc56d675ccc-goog

