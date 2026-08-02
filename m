Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEA3DCDB1
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707716; cv=none; b=AAGxszBxQR1xEshkILfzfBH5DmnDe8qTmqEgGD1DWq2kWEjgH8YC7Wd0+7aYfCUf4gMUw74YZvGLLa3oKUOCmsG4spHpWAk4h2B7aB6EIjZ/ihzwAL8DJ3JymDqAwQ0GcznbjzpFuCMn5iHtzdsegdLPF40ykknMO+e6M3Lxnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707716; c=relaxed/simple;
	bh=DjZ68FKnv53M8cPQ2cNyW+Y/DBTCZnr07T9sJL4GD0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WM/QFxtqQSZmwpIBU+keeyJuiQTwEb5u0QtCk3X6Nt8IsYQ8FjWnidYZeojC6k3XphrC7Legr/+qYwwwdZx17fZhC2DU7V9Fxk1MPCgjteTtMBTuVcA8/bDe3MmLAwnZrJs71xA+5q+U+GXhAxOByjGt+JE0wIyK2Rc/DwZfywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1rE3C4n; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1rE3C4n"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca860baea9fso7088987a12.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785707713; x=1786312513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xyBuTBv3WW28OhNQPFgbAciWJmDFVPYFH/JX2U0eD1I=;
        b=o1rE3C4ncfoJyxEgZCSWxrz2EDG4+KNMgUxwhuw6ONgbrayAApSWHlXXbCt4agDSKc
         ctGMtPJrJRpjEbFRwJYq/ND4U5HgcvUgJHVaVe/cAiLLIA5oPhiIcTqU14/QqItpWWW1
         6gAZUvM/hoLZYFxn7/jWD0YCt4gpqhiFvdJQCLBWqy624mKlQg5ik22nBXTAHi9DPO7x
         0PaFeJAjUWOQmMnrTCVyx2F9YqNbnqJka0slpAS+OOMiXzNCzryQ/FMZABMkDmJvmB3K
         yHhAD7Lgi9SpNed8ue3zD8nMlH6cJ7H8vpi3Y7d93xmRPPik+1CZyKY1RK5vCEvLjX0i
         BgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707713; x=1786312513;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyBuTBv3WW28OhNQPFgbAciWJmDFVPYFH/JX2U0eD1I=;
        b=DTSmm+x2a8Lbt3vtb8PlPJX82u2K7RRje9LbsFvDxI8kFeLfDdWG8qk91yo54vVtXt
         BCWHw3nhJXFyD20vzUDDvFHx9jmwD/yDKG0H7GGTjZAK2mLEeGy+iaHnc4y4QwOq7O0H
         62lxvo2PKYeHGev6MHm8AOisrQ9HH14U1ZMMq97GvfFDMSxbq6MCAaTb+OqBqB241mtS
         DJ5CPig7uDW4IXdQRLas3JEKn0Ceh3itW1Qv5NrL85yUScvs7KPdNUrHrQUfstXqSUpE
         bpJk9SuFcj6uhsRylMuuH1K1AbwZ7nHA8shbpGJD+oKQGmobSiue2DAg/wZf/N8TBnhh
         VmlA==
X-Forwarded-Encrypted: i=1; AHgh+Rpao/OxyvjGBPKsvKPgYXQxPKv/OaTiYX0WqeTM5z+T7Ye+4aPiJ1aCWRTEkQ1fVxvvxGv/BwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpYdJ0OirIZJNjlpHoGQOh7MHFLg46W01P4Ue7x/4lwItiTJJ
	yl19B9sWtIzhu8Gr2paDcoZZVBFAwnaerquDtnx2XOB4yrm8H4yQanKXkvS00E4ClwarnSPuJO8
	3WjJqzw==
X-Received: from dled7-n2.prod.google.com ([2002:a05:701b:42c7:20b0:13b:962e:3bc8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:505:b0:3c3:9a32:70b6
 with SMTP id adf61e73a8af0-3c92a85f682mr8949124637.44.1785707712418; Sun, 02
 Aug 2026 14:55:12 -0700 (PDT)
Date: Sun,  2 Aug 2026 14:54:58 -0700
In-Reply-To: <20260802215459.2769283-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260802215459.2769283-5-surenb@google.com>
Subject: [PATCH v3 4/5] binder: Remove mmap_lock fallback
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
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
 rust/kernel/mm.rs                    | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 28 deletions(-)

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
index 84104ba04e30..519dcded19b2 100644
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
index 2633e704c83d..877fad68be9c 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -190,6 +190,24 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> O=
ption<VmaReadGuard<'_>> {
         }
     }
=20
+    /// Find the VMA covering 'address' and lock it for reading. Waits for=
 writers to finish if the
+    /// VMA is being modified.
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
2.55.0.508.g3f0d502094-goog

