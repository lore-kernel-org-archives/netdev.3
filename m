Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF37494828
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046775; cv=none; b=EXOf5e1x6bRJg/7IiiI48oJCvuXm6cOQWtJQcsMUi94AuwyjyvrwGIp/qVc4MJIrk0HZWN418I7I54OYTBoIijNzt4LHgFrTqB4jvdTww7zUsqnxMbGZCD+qFfpUCoptJKUQuvw8KqYKZtsPve8hG6dkyrMCt4YOyEE8KAHVCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046775; c=relaxed/simple;
	bh=xPo0ALC5GAD0pJpjspQena11dKnVnoOGrSo0u0zS+80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiuNj3JbUHsGvsdWoHmpnU7hncl4DUdUmsK5eVeXPU5L6V1Nbyh+hkEWmE0St0SI/91UyNK9ZgWcLlcxvsJTjz52axE+54ylFL/rHSB+k1oZMSkTrx3Kr1Di52alvCco9/hE3l3AWr3FDSi70ZnlZt+y/cLqXhR9e1P5JpLtM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv9A0Cfe; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv9A0Cfe"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1521173a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786046760; x=1786651560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qo+gPZDCnzT8MahhMkr4ixbPoS7BupzxB9Ai/ylfWm8=;
        b=cv9A0CfeC03ES9ME+CswT47xH3un2xsmUiOMSkw+jsYfh25rBH70jTRk1j6IpMKy7q
         tApECJgoG4fgLyMNUZBuQ1GHR144DEQNZi7Y4N2NUR+diswxppM+8GkUOyaWvjlMmvXs
         /0BzBjuI0+ZonkjHrmuCciW90gKB5Ka7WAhvuM44L8i2kcr7Xcdsx5+K0mkeqc5SIM2I
         C+718/WEJLVfRoAjEwfA8ah9WY3sii3ZmxdQWhz+6rkD+l5UxpJHpgvJFjDEiOEETK1b
         l5FYPN21Sd7rdhtYAUjQap+FqNCfaRS30QDr+VRZrO8FbPADiO8wSCxSULWFNsH5UXqW
         eAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786046760; x=1786651560;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qo+gPZDCnzT8MahhMkr4ixbPoS7BupzxB9Ai/ylfWm8=;
        b=SDzIx2IzfbzZYHgqDmcbUNNmbb3FIJ6zOaIh6yRXmvcXJ2btw1OZ3YnUuyJ0P4uwIf
         B6RNaBHyKhuntW7ErK9F6ep5283tfoupHBkCFWqZYE1mf2gafbXlV8gprHcv5nie2GQ0
         ZSfMlXcG9gquIG2UddyIo6MUzW9xJGF6GgxiWZb1nckxztyFKF0DKBzbJROF2CfltOD2
         XTiMVPFK5msjjB16s3pB6uZ4nX7ubs0+CJGw1IbNQ2SimGewVV3pjixwL7ZzJXatqnTJ
         g1FHc+zY9o9OZcnNdYWjxz/bPvbLiQTb/z5dH1UK3ZJzmPTnqP/cDEsjmW/KrZrxDskh
         7Q8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVozP6JEKahObTkAaEuo5BSTSLs2yNFTxXihFjrl9mcdRz39/r7ulU4j3mBhMl+BRiDywT2Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhEJUY9qfyQfQsKNOeN5EsXY/IuPjX4IT3uWPBph3AtEtA0pL
	yxK/xRBc+fv+HUhTX4tEjvf5y3ZwusTeCqvNJiVYUFbAzZuRfm2HbgXYz1hcxmUFsiEkmi6xjqO
	HvlpqeQ==
X-Received: from dybqh4.prod.google.com ([2002:a05:7301:6244:b0:30c:83f3:7370])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6daa:b0:3c4:3672:ba6
 with SMTP id adf61e73a8af0-3cbadc15329mr4732449637.22.1786046759808; Thu, 06
 Aug 2026 13:05:59 -0700 (PDT)
Date: Thu,  6 Aug 2026 13:05:47 -0700
In-Reply-To: <20260806200548.3124802-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806200548.3124802-5-surenb@google.com>
Subject: [PATCH v4 4/5] binder: Remove mmap_lock fallback
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

From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, the per-VMA locking could fail in the face of writers
which necessitate a fallback to mmap_lock. The new
vma_start_read_unlocked() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
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
---
 drivers/android/binder/page_range.rs | 19 +++----------------
 drivers/android/binder_alloc.c       | 17 +++++------------
 rust/kernel/mm.rs                    | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/=
page_range.rs
index e82a5523804f..f7ad88a0d806 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -439,22 +439,9 @@ unsafe fn use_page_slow(&self, i: usize) -> Result<()>=
 {
         // workqueue.
         let mm =3D MmWithUser::into_mmput_async(self.mm.mmget_not_zero().o=
k_or(ESRCH)?);
         {
-            let vma_read;
-            let mmap_read;
-            let vma =3D if let Some(ret) =3D mm.lock_vma_under_rcu(vma_add=
r) {
-                vma_read =3D ret;
-                check_vma(&vma_read, self)
-            } else {
-                mmap_read =3D mm.mmap_read_lock();
-                mmap_read
-                    .vma_lookup(vma_addr)
-                    .and_then(|vma| check_vma(vma, self))
-            };
-
-            match vma {
-                Some(vma) =3D> vma.vm_insert_page(user_page_addr, &new_pag=
e)?,
-                None =3D> return Err(ESRCH),
-            }
+            let vma_read_guard =3D mm.vma_start_read_unlocked(vma_addr).ok=
_or(ESRCH)?;
+            let vma =3D check_vma(&vma_read_guard, self).ok_or(ESRCH)?;
+            vma.vm_insert_page(user_page_addr, &new_page)?;
         }
=20
         let inner =3D self.lock.lock();
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index c13a588c37de..efa23f6b8360 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -259,21 +259,14 @@ static int binder_page_insert(struct binder_alloc *al=
loc,
 	struct vm_area_struct *vma;
 	int ret =3D -ESRCH;
=20
-	/* attempt per-vma lock first */
-	vma =3D lock_vma_under_rcu(mm, addr);
-	if (vma) {
-		if (binder_alloc_is_mapped(alloc))
-			ret =3D vm_insert_page(vma, addr, page);
-		vma_end_read(vma);
+	vma =3D vma_start_read_unlocked(mm, addr);
+	if (!vma)
 		return ret;
-	}
=20
-	/* fall back to mmap_lock */
-	mmap_read_lock(mm);
-	vma =3D vma_lookup(mm, addr);
-	if (vma && binder_alloc_is_mapped(alloc))
+	if (binder_alloc_is_mapped(alloc))
 		ret =3D vm_insert_page(vma, addr, page);
-	mmap_read_unlock(mm);
+
+	vma_end_read(vma);
=20
 	return ret;
 }
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index f4fa54616085..11466fb304df 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -186,6 +186,33 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> O=
ption<VmaReadGuard<'_>> {
         })
     }
=20
+    /// Find the VMA covering 'address' and read-lock it.
+    ///
+    /// The fast path does not take mmap_lock. Waits for writers to finish=
 if the
+    /// VMA is being modified by taking mmap_lock.
+    /// Use when mmap_lock is not held, otherwise use vma_start_read_locke=
d().
+    /// Nothing prevents VMAs being unmapped/mapped before or after the VM=
A is
+    /// looked up, if a stronger guarantee is required, take an mmap_lock.
+    ///
+    /// Return: If a VMA exists which spans @address, return that VMA, rea=
d-locked.
+    /// If no VMA is mapped there or, very unlikely, a reference count ove=
rflow
+    /// occurred, return NULL.
+    #[inline]
+    pub fn vma_start_read_unlocked(&self, vma_addr: usize) -> Option<VmaRe=
adGuard<'_>> {
+        // SAFETY: We may invoke `vma_start_read_unlocked` because we know=
 this `mm` has non-zero
+        // `mm_users`.
+        let vma =3D unsafe { bindings::vma_start_read_unlocked(self.as_raw=
(), vma_addr) };
+        if vma.is_null() {
+            return None;
+        }
+        Some(VmaReadGuard {
+            // SAFETY: If `vma_start_read_unlocked` returns a non-null ptr=
, then it points at a
+            // valid vma. The vma is stable for as long as the vma read lo=
ck is held.
+            vma: unsafe { VmaRef::from_raw(vma) },
+            _nts: NotThreadSafe,
+        })
+    }
+
     /// Lock the mmap read lock.
     #[inline]
     pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
--=20
2.55.0.654.g21b8a5bc05-goog

