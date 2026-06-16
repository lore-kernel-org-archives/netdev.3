Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968422DECC2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597388; cv=none; b=Teq1Qt36MI//0pBYFytwl4EV2r1/kHkduZD3L7I2S0CnthSuKrfvGscnJ1F4JyCbRI9nD9nEkg3FYWLwJWcLb6Dic75+kNWr7Ph+5T+c67N6br2QHygQpVuu01xtTpm69eMrx4XsG4UNZS6wdssLBYqDi0J6jK7WFPNkJy29bZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597388; c=relaxed/simple;
	bh=W3sZijV6GnmWL8u81rgFB/GhJTvOsILap4K/snWiBWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XUVyH83LSOkUhEq7S1d9BFAd8yXWlK/LSVWiJaXTDRj/Z+17jsh2pg+NszL3gNTTt/JNrztkyuIuQbzgQXnZGMMNfvzz7GERZm5AKgzqeAxxpxtcEkKD/cGNEvBu7G2ekkh0CUq2LluSUEMSvHU/ihvN66YlYsvI5nIRSNXifq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJEMRSPz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJEMRSPz"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490eca575d6so23566665e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781597383; x=1782202183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9R5Lgx8hxTU1Zj6XMxBcaWV9XB+tRFd0xLqwOfSNo0=;
        b=IJEMRSPzPqe2t7w6Y2fIvW9a52jz+/vncMaxs8xqTIUI0gUFyguHWo1gojRQPAYeJf
         bIkye38fT7sUQ4rQj56VFvTYJUaUd/lvfEqzmWwcof+NvAjJnvNtAt+AH00N6UQe+/d/
         K4NQGMKQzVitBvvRwrrLnnzZbsnHuNEsrt6Ipvjjmv5/NQRk4vdFt3xS1yQxZNRNwUDQ
         a4pl64ynyOBxTuT4l0/sfOsffDoYYC2gQA6YTPWewZQ+sZnzeTdnmBcciYWWnfqgC3Lk
         Vc1v5sojSJUNZeR14xJN9owFFTGj5VDWjTZ6KxdWEAkqpnqb7/ESZMeenitfZUJqzZXu
         o72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781597383; x=1782202183;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A9R5Lgx8hxTU1Zj6XMxBcaWV9XB+tRFd0xLqwOfSNo0=;
        b=WXi3eIZ188bP3zAR+NIvPSX+5ov0PTPDhHAD97RzB6d4uk+fGM+s9zJ1/cNX+yhnv/
         YOHTYr/rTmrUxyK8kqlJDFMsmEUjY84gF72i51z7Qnd79ogH2/MxlF+pF2OopQNe/lyd
         PmxoLIS//gMdu5lzMJiznwR0IPKRg6F6IsAe/o32VAG6hgSKW45a8rZdpon4VqWZbQOo
         jCYb+ec+G12dopyADsYACYYJuFDW5t46BrnoX+nKv+c0ahIYonL1puDBeyZ4IMBxo/Up
         MDdtzZOtKjUrPEKRsu9HevLhBvKO9OQGDYt8VTlBGu9ZUwYCozFw0gEqLQ5rxEcUlGc+
         C01g==
X-Forwarded-Encrypted: i=1; AFNElJ8gse0dzLJZ8c5qRyN+F+hES54qSCVvBQwUxyKEueO2/oGSfYZIosu903rJaj9/2EXEZNPhdlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiB5Qh0EO/FVnRUi2APrYtY94mBsdHjHxc+BUwibMrfe5P13P
	Tr+xQgM+i46GfLVtwaZbokOd6Fo/i0SDM3PIzunpRYA5EJBPL2H6dtdelvPWtJzYLK8mJCz/LzK
	raYZ8iFp3tThSOPdX6g==
X-Received: from wmbgz11.prod.google.com ([2002:a05:600c:888b:b0:490:c5d1:64bb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a219:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490ec50af2dmr135770925e9.29.1781597382796;
 Tue, 16 Jun 2026 01:09:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:09:41 +0000
In-Reply-To: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
Message-ID: <ajEExWh9YwXZ1iRp@google.com>
Subject: Re: [PATCH v2 4/5] binder: Remove mmap_lock fallback
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 04:04:17PM -0700, Dave Hansen wrote:
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
>=20
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
>=20
> ---
>=20
>  b/drivers/android/binder_alloc.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/androi=
d/binder_alloc.c
> --- a/drivers/android/binder_alloc.c~binder-vma-waiter	2026-06-10 15:57:5=
6.419452721 -0700
> +++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:56.423452863 -0700
> @@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
>  	struct vm_area_struct *vma;
>  	int ret =3D -ESRCH;
> =20
> -	/* attempt per-vma lock first */
> -	vma =3D lock_vma_under_rcu(mm, addr);
> -	if (vma) {
> -		if (binder_alloc_is_mapped(alloc))
> -			ret =3D vm_insert_page(vma, addr, page);
> -		vma_end_read(vma);
> +	vma =3D vma_start_read_unlocked(mm, addr);
> +	if (!vma)
>  		return ret;
> -	}
> =20
> -	/* fall back to mmap_lock */
> -	mmap_read_lock(mm);
> -	vma =3D vma_lookup(mm, addr);
> -	if (vma && binder_alloc_is_mapped(alloc))
> +	if (binder_alloc_is_mapped(alloc))
>  		ret =3D vm_insert_page(vma, addr, page);
> -	mmap_read_unlock(mm);
> +
> +	vma_end_read(vma);
> =20
>  	return ret;
>  }
> _

It would be nice if we could update Rust Binder as well.

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/=
page_range.rs
index e54a90e62402..8d56b991744f 100644
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
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 16f617d11479..2973718af48e 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -188,6 +188,24 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> O=
ption<VmaReadGuard<'_>> {
         })
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

Alice
