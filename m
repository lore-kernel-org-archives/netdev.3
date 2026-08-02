Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8093DBD49
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707710; cv=none; b=EQ30eJyL4U9StlXMiU9uI/E1+YKHHgNL2mIUR9cs5dnLsp60QkPbkJbQc0dU97ZzWGdgm0/JiykZUt4QVSVQzYswWHk3PZlaHVg7w7NlYyWo8bEATVbbFdPnvn+FZ6TCv9alE3RR192q0kwxKr8TGKYmUck1nTxegy3335J7VzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707710; c=relaxed/simple;
	bh=p62l3PJjOIdYZzi6CGFj9/z2xtIpPh0sBcEeuCMuHo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcrVtGZkF9TZzIiUPces8QEndTj5fLx/9Qhsiun/ATrL9fOKcCfs3nPxEcqlVlyb7t0YpbshRu0x54ra8lj0kAkZhMNpQLsfe670o5eucV31Epvdw3HofJR5uxP3sVW1KSQRbBVaVXVWs6X6j231ZfnP40fTKMIh+nq6hmRcICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DO81pyuu; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DO81pyuu"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so83748015ad.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785707708; x=1786312508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G37mEYyNGIkcVcWDIKuo53Q1LK9xSdA30i8azc+FTGc=;
        b=DO81pyuuJuR85ndcsnnbbXyEXpLmh0o2wqdUHtllFk8xKcKZi2pG4Cs7EIzVdUBVMb
         gxCwQp0HE6H1AjQJ/E5ufllP1Kk+fTqm0L05wFnwXJarKRpBb7t7Dfj82MKBgAKDPKdK
         XJC179A/JLx0H5jAUjRZSb1HrHmQkrs6VjyYl49/iA5T0QC5tt0lsSGsyJsIIhTTpl4V
         00kiG6ujSDxbQAH6tZUObAAfAww0SegRkVPz+QrJDxQUs7GfQvTDeUDolZu/0B7kA7TV
         O7JHMNy8J5k/Fa1r6DjNllPwNWCGf8sdZiiChPgpuzYtFDUXK/10pw5Nv/RxpJLpJjL9
         uROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707708; x=1786312508;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G37mEYyNGIkcVcWDIKuo53Q1LK9xSdA30i8azc+FTGc=;
        b=UpFiVIeCkeZxI/ZDxTyOwET4Au8VZBhvVqXstWsFvt5/uwIkIyWgQeUnm2+nI6Tafg
         ODcy9dMs4KcexNB0lLMNzfj7P/PgBkAE+MeSpCwcKTnyeuH6e0unXYpgRTgUyDYwNnGy
         ulghRKehOY3AP/IK5I2Sw8nqqFIXW3+gY7LC9RrT9JK7tGijyjZm6T6pgEG1tcfwwnmo
         +YZ/x947KCSZWsXx/BGCLHQMFOJpG4X2GS3oiQvGWsyymy7az221jw2kqkKgz5DbiuAh
         bVg08e2K7fj/RolB9MBn5Uj5uQ0kOtvfsrhX2jr6HZItKyFugFfB4b1L05YRZHpuOUjv
         5rlg==
X-Forwarded-Encrypted: i=1; AHgh+RqbQGkwZTkN512Bhwc72yaDSRZQvqyauWtRdIRXxZdFscnKRkRarq8c88fW8tTVTb7equI8jL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzixZBDrmZq+jWimfjcTn1ha9H7nnDJ3bIS1dHWUA2g36rhE2HT
	4KtHzbNxyqnx4HLpnELYisOyJD379zaW5qH9UPTKpScWnBTcYWN2i2MX8U+ctgSuG/lu/hRAzly
	N5XbvEw==
X-Received: from dlag2.prod.google.com ([2002:a05:701b:2502:b0:139:b9a8:f222])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f15:b0:3c4:1493:6822
 with SMTP id adf61e73a8af0-3c92a59aca9mr7723441637.18.1785707708099; Sun, 02
 Aug 2026 14:55:08 -0700 (PDT)
Date: Sun,  2 Aug 2026 14:54:56 -0700
In-Reply-To: <20260802215459.2769283-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260802215459.2769283-3-surenb@google.com>
Subject: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
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

tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
it and mmap_read_trylock().

Long Version:

=3D=3D Background =3D=3D

Historically, binder used an mmap_read_trylock() in its shrinker code.
This ensures that reclaim is not blocked on an mmap_lock. Commit
95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
support for the per-VMA lock, but left mmap_read_trylock() as a
fallback.

This was presumably because the per-VMA locking can fail for several
reasons and most (all?) lock_vma_under_rcu() callers have a fallback
to mmap_read_trylock().

=3D=3D Problem =3D=3D

The fallback is not worth the complexity here. lock_vma_under_rcu() is
essentially already a non-blocking trylock. The main reason it fails
is also the reason mmap_read_trylock() fails: something is holding
mmap_write_lock().

The only remedy for a collision with mmap_write_lock() is to wait,
which this code can not do. So the "fallback" after
lock_vma_under_rcu() failure is not really a fallback: it is really
likely to just be retrying in vain. That retry in an of itself isn't
horrible. But it adds complexity.

=3D=3D Solution =3D=3D

Now that per-VMA locks are universally available, lock_vma_under_rcu()
will not persistently fail. Rely on it alone and simplify the code.

Full disclosure: I originally tried to do this with
lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
trylock semantics. Claude caught this in a review and suggested the
approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
I guess.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
---
 drivers/android/binder_alloc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index e4488ad86a65..84104ba04e30 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_he=
ad *item,
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
 	unsigned long page_addr;
-	int mm_locked =3D 0;
 	size_t index;
=20
 	if (!mmget_not_zero(mm))
@@ -1151,14 +1150,20 @@ enum lru_status binder_alloc_free_page(struct list_=
head *item,
 	index =3D mdata->page_index;
 	page_addr =3D alloc->vm_start + index * PAGE_SIZE;
=20
-	/* attempt per-vma lock first */
+	/*
+	 * Attempt per-vma lock. This is essentially a
+	 * "trylock". It can fail even if the VMA exists
+	 * for 'page_addr'.
+	 */
 	vma =3D lock_vma_under_rcu(mm, page_addr);
 	if (!vma) {
-		/* fall back to mmap_lock */
-		if (!mmap_read_trylock(mm))
-			goto err_mmap_read_lock_failed;
-		mm_locked =3D 1;
-		vma =3D vma_lookup(mm, page_addr);
+		/*
+		 * If the vma exists, we can't continue because we cannot
+		 * remove the page from the vma. However, if the vma was
+		 * unmapped, it's okay to continue.
+		 */
+		if (binder_alloc_is_mapped(alloc))
+			goto err_vma_lock_failed;
 	}
=20
 	if (!mutex_trylock(&alloc->mutex))
@@ -1191,9 +1196,7 @@ enum lru_status binder_alloc_free_page(struct list_he=
ad *item,
 	}
=20
 	mutex_unlock(&alloc->mutex);
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
+	if (vma)
 		vma_end_read(vma);
 	mmput_async(mm);
 	binder_free_page(page_to_free);
@@ -1203,11 +1206,9 @@ enum lru_status binder_alloc_free_page(struct list_h=
ead *item,
 err_invalid_vma:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
+	if (vma)
 		vma_end_read(vma);
-err_mmap_read_lock_failed:
+err_vma_lock_failed:
 	mmput_async(mm);
 err_mmget:
 	return LRU_SKIP;
--=20
2.55.0.508.g3f0d502094-goog

