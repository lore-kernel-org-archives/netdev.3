Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB403932D5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208276; cv=none; b=WE6sgiCcp/v8ediEgrKTHwYckMCddAwoN1ICTNPYtsExbptOjAobsfVy59ev/bxUD6mJ/gfjGbpiNO99bLrEe5mepoJI/aXAKOHdXoKLyRY+9lxpLpXtjwV3LOKeYTCE8erqhJizsciAjV23N0qv7GSa7YpkqQdnqr0rlwG98Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208276; c=relaxed/simple;
	bh=E5omcHuGcH/5sMqY70uPWGBn/Pv7a09NS/jGJbvxUDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVXPl1FmZqZa3R66TFjoQKzZYM3R28TwXaEBMcGr6hr0Wc69w4VVvD2rISZL6C8M9H1CUKjr3qxPD0xxblw4dM3pCZWny+oF2lXPUE/4/QPjfGp04AV+qwtoGXKDCSho8GeJhPZX1Td9+b6J1kyOh+qkTdOPEVbphVoatQqnZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwjO+kRP; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwjO+kRP"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398e1fafe17so291932a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208272; x=1788813072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fMb1BIWAt7k71K1WS7NJDkr5bMmZbsfs3e75iDz3R4U=;
        b=UwjO+kRPdRYCN7XOF0SKWzCdwZYzLGaLUA83mFXoGZnSam+2QZ+MsWDfjCBo1gkpAo
         SyQerbaqC0HXCD9H2GvE56Z4tfLD0Z5C9p655IDZYQbiM1U6dH/fr6+ARJ4lQTBCX4Ms
         aACs42ZrAFCCGFELTv5+8OaqVR22S3KigQyE4H1lpL2qIH0yiMZP0e1p1HuGKBh+NokL
         tsglwUqoIzkzkMW/fE2CoEKGcjfw7MqvEumtSU3naNJx1i5WCP5bbXSCgJLXFkqh7hDD
         OKrta5LeTC0s+YDVSpCmb2ycN/7dyWzBDblWgOwtNG19/CmaWP+ciTAJSkbwy78dwr+B
         P3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208272; x=1788813072;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMb1BIWAt7k71K1WS7NJDkr5bMmZbsfs3e75iDz3R4U=;
        b=hJR6xEiuG4Ukn2+lfqHF7KWDo6M5zc1cVkmYBb4lEwtgWxPId/e0juCbLZoDAWILif
         OXZ3fT5aGRKz76xVpKSK4NWOINVWi/t8b+QsxuKaWl8rMMdHLwW/R8ImAsRJk2Z/s+nJ
         WBl5K5bNRvBXlNOVUVAyWBXjvoRwxkhdAFl72ivOcxMy37j7fB0Xkd41SeGwAKlw1Y0H
         ryG8s/WdBIeb/606VZLATxA6czoQBe8/ZhuBKrwxMUHWZHMwFhAHDAjoa6U5QmF6M9Kn
         bz2adJBciu5QZccvSR/UVsXG/qyaLaORxCPj5OzVcFA4Bfb6PUuddxiKym67s1Sigou4
         cJNw==
X-Forwarded-Encrypted: i=1; AKwUvBwphOx5cnEuJRVfqkfjs1vSbuMRSwv5pjgh36S0TyYTZXiW61zeTFmGYl+v+y1U31C97K7Jut8=@vger.kernel.org
X-Gm-Message-State: AFuF++lw6+up3QukEtjtHt1BnKpRulMASyNxOkH+KTwocz6Nciw1nCZx
	06zx5XqR3Ig5TBGexmLI0M8/eaZgaTzUs3EFuoGhTXhde3RU0rW6TXk7Nh94pOdRO/OhQeplu9V
	AFY1Q7A==
X-Received: from dlak6.prod.google.com ([2002:a05:701b:2906:b0:141:5987:7f07])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8a:b0:38e:524:8797
 with SMTP id 98e67ed59e1d1-396d10076e9mr43087877a91.13.1788208271612; Mon, 31
 Aug 2026 13:31:11 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:55 -0700
In-Reply-To: <20260831203056.838265-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-5-surenb@google.com>
Subject: [PATCH v7 4/5] binder: Remove mmap_lock fallback
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

Previously, the per-VMA locking could fail in the face of writers
which necessitate a fallback to mmap_lock. The new
vma_start_read_unlocked() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/android/binder/page_range.rs | 19 +++----------------
 drivers/android/binder_alloc.c       | 17 +++++------------
 rust/kernel/mm.rs                    | 28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/=
page_range.rs
index 52ffbf3504e7..71febd3d5b07 100644
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
index fcb744088e77..d6eae0aa7085 100644
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
index f4fa54616085..58bc1793fdaf 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -186,6 +186,34 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> O=
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
+        // INVARIANT: We just acquired the VMA read lock.
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
2.55.0.966.g6673acef38-goog

