Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2171429022
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649695; cv=none; b=YVSybFrCgFG1H2Qb0N2bkyqiANNT29J64i/RTk6rDpd0/kFBUgeHYB187geQBAqCVFINh0ydontUbQMYB2mLidroZ+iLsuZWXgPLOIa6WNtX0EwgqU1wJrGWoRP4yGt16VcfQW2AWef06foTUHUk1JX8e5A2TKgAbsed0XGNM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649695; c=relaxed/simple;
	bh=n+zxvJNkgXllBXsAuFrQ/5G3lF00aufPfpbEa450R68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Idk7IWfVHhSBgZELts48UGYTQp5oWjvLjbmQ9OrZVVAr+GlRP4l4X60WjAswLVV8lM/0DD6bkTiSpPDai7LHpdWz/erOHuC/2OAW8BHlT+fgCnixSF1GIoZD/bRRYEIHXAHCtkrIZGjC3OmknktaSnJJOrmqUIjpNmwGIhYKCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCVKdzST; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCVKdzST"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso164640a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786649689; x=1787254489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qCaRRVvjGSC4kAtkk2EEVd2d10nX9bq42OPxaiCJ5Jg=;
        b=RCVKdzSTemFU/3QWohp2AOlYFkWB1LA1L42TBtIYnwPiJRHBz74t+JroF3PfEwh8k+
         2FSBmMxJmpSidXh918Ac4Fj1gdGIWCaeBXyy/2drYbLTifV6aBCAwQ7uduhv6TjAJbJo
         sRupdcHJDtnUFasjHXMItb8eWw8CvSAKFL5Bxc1aN+Vf2fBkun8u8wZKmHNl+TAF5TbF
         UuRtd0iWP4WwzDNlt9wnjcZ6ZlnzRNrNmr9HHWNTn5NVRb2KiRkxXXC30LBpFneCvlFv
         QDMSPI0eeNMChuXQfgkJJS70GDDcVwXkjTlkz46tQDhWnu0y/HRHuW1lTIbHE1AGmJJp
         wH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649689; x=1787254489;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCaRRVvjGSC4kAtkk2EEVd2d10nX9bq42OPxaiCJ5Jg=;
        b=A9NTibYnFwCxJXU28XEhbyUrMUTonxMSbaX+FDK+6xbFZxKxtq89FkaDsdqZx4sVSv
         1qT3JRLHd9aWT7fR8RtRg2kYQObmAocQWY00wKh20xoXbefOZHKtJMMGeIecqzZHSX6H
         CpVoFGhwQq9TQ9CNwC/ARnS9KEAMkfhzIOtpow1VN97ycu/ucSiKQRuPT2YKyMa4B0mJ
         nRSFyCpdLGPaxBEYli7xtWyX+1tXtzXJw073MZXiRmY6D1zB8xpzZYZ5FyNCJEpCCoBV
         5BzmuDiYQHKBc6PBHcM5n2DKkvyGRUpe9Txtr8NjkNgF4I1YA3Nnw9KWMEt0Sv6lON0m
         /vHw==
X-Forwarded-Encrypted: i=1; AHgh+RoUgLphddrcDp5MY1d6eRJqRsulWtZMQTyQKNH42btQ6ONybVYHWEb6dkri0us2WG/CynotOFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZB0u400+uCiwxw7sDQ74MuEM8wIPFvXm+iUlysZidzJ04w4eP
	r/hY114NA3iYHfnLAZhHn23bLqRBIJUMBH7Yy0R2h1ZRB1cCGtysmVtgsxIzubvnR961EP6sy5B
	eBmbgPQ==
X-Received: from dlbqk7.prod.google.com ([2002:a05:7022:ec87:b0:13d:314a:1ffa])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac8:b0:38e:11ba:992c
 with SMTP id 98e67ed59e1d1-3933e5d22acmr228908a91.12.1786649689046; Thu, 13
 Aug 2026 12:34:49 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:34:32 -0700
In-Reply-To: <20260813193433.3318288-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813193433.3318288-5-surenb@google.com>
Subject: [PATCH v6 4/5] binder: Remove mmap_lock fallback
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
2.55.0.691.gc56d675ccc-goog

