Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA33911CA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208271; cv=none; b=jHAr1gXPbcRrPUzkBG53NxtPQWfblqcKNfhIvvL3wkp1bB62PJSWyIB6Db9jFvpExZjCiCFISgEISizzCNdHQakGT32yJX8Q3D0afL5cRJ2lZiBY+fzUG2Gseh2zU4lLDdS1MK56mfV6Z6exGMJ5TEZcYHEwZ0+1svFYzBT7+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208271; c=relaxed/simple;
	bh=0yZiSioIL8z81HUTM4QdI25XMPcYXqTlcPZ2v8++geA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FMODb4HXmgjXAPwIqy5lZ0MKTsm5sZSluPH2eJsGDvU0pt/2PGeEFml3G4ORNH8+QOw7LmR4KqAnkxSE4o/Jjg4rviNTqSroKOJnwTO/gDUMXVf5TyP8/sH66Z9UQD2IdV0Fipx1sGVB5hirSnuSt+SlasTfgXB0Sw5xNHrft8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=if6LhE4h; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="if6LhE4h"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so5614218a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208269; x=1788813069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2d63lXSBmx7NRIUq5ZJpOYybhygf0jA0W5buHn0/eWM=;
        b=if6LhE4hEY5TUG9h4NJHIj/PXTGXgQcjOooFA7otSYa7YchEDHN9ioKHLd1mBPsEew
         uXTU5o8cihMu/DvcG7l7aoO2FKbShGKQzvkTEe+2/0D6i35cF/zki0ZgMkQwiOX/N2GH
         AT51yjzSG1MqreVULMBz3bPYCihKPfWj6hosWSGx/LqcgTtErLJQ9hdskrWh9MC9P105
         cPkR5Eex2Np+oGNFiKy5tanTogmVzVYXJ/401SaPt+Hx5Bokoebzgs3ooKxfkfctv3i1
         iPbASbYtW8Mj4mo/w8U3waHYiMnQP5haSysIcvm/Dx4JnF6I2XRAcMEMd3Q7NFC7ghuN
         2Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208269; x=1788813069;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d63lXSBmx7NRIUq5ZJpOYybhygf0jA0W5buHn0/eWM=;
        b=jwD4xvT57gS9dBdGidyMxYh010pZZTHg1VRzwhEgodowJ8mnckZEVorbMiXOKKoNoo
         6iSd/9zlkg9KU2paoo6Jad3EoEWaRhXpQvNHkqCjQMi42mm9tomj/lQ5mKy26Y2LbDXA
         Pg3e34H6s96mG9d+QMpj44wBcU3HOWBrd6qZGQKizxCRBc2OBYpF6K8fS2pyXKDz9g8J
         PhgR5xC6c8HywcNcVTNsXmcLuwyIPEhhelnOl5fxFsgd0zzfIuwyxLu1IGJ8vrFT2XFk
         SUd+Lph7GzTazaW0RhCPUmccd6/PxwQ35GSI5pWeQfR+SZrPPyAtRIis03h//f7qoR5q
         z1Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzQgKr7g1XyJS/eWo2YoKUf9wVrzmnylfHVpgeirtF3BnFksvoPEsRelZ+C55iQjbgOcxD+aEA=@vger.kernel.org
X-Gm-Message-State: AFuF++lCRu0W64OhYl1nwWWhwKEL7TTYpnFrvBcKwm/5aRZOMFR8zWKX
	0IF1x+XvvHvikxnD6mCEi6IwjEs+20DlreqV0c2ayplgv3nYIOSfYgZi6jQcqi76udsCX8o8Zpy
	3NG9xOA==
X-Received: from dlbeg32.prod.google.com ([2002:a05:7022:fa0:b0:141:4d1b:41b8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17ca:b0:395:4de5:1054
 with SMTP id 98e67ed59e1d1-39907d65648mr3496744a91.16.1788208268999; Mon, 31
 Aug 2026 13:31:08 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:54 -0700
In-Reply-To: <20260831203056.838265-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-4-surenb@google.com>
Subject: [PATCH v7 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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

There are basically two parallel ways to look up a VMA: the traditional
way, which is protected by mmap_read_lock, and the RCU-based per-VMA
lock way which is based on RCU and refcounts. However, per-VMA locks
will fail if the lock is help by a writer and therefore never waits.
In a number of places we need to wait for the lock and it's done by
falling back to mmap_read_lock, locking the VMA and releasing the
mmap_lock once VMA is locked.

Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
waits for writers. This is basically the same as the existing RCU-based
lookup, but on a failure to lock it temporarily takes mmap_lock for read
and waits for writers to finish before locking the VMA, dropping the
mmap_read_lock and returning the locked VMA. This has some advantages:

 1. Callers do not need to have a fallback path for when they
    collide with writers.
 2. Its fast path does not require taking mmap_lock for read.

Basically, when applied correctly, this approach results in faster
*and* simpler code.

While at it, fix the comments for vma_start_read_locked(),
vma_start_read_locked_nested(), and uffd_lock_vma().

Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 19 +++++++++++++++----
 mm/mmap_lock.c            | 35 +++++++++++++++++++++++++++++++++++
 mm/userfaultfd.c          |  6 ++++--
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 27c00bac29f9..00eae65b74bd 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -228,10 +228,14 @@ static inline void vma_refcount_put(struct vm_area_st=
ruct *vma)
 }
=20
 /*
- * Use only while holding mmap read lock which guarantees that locking wil=
l not
- * fail (nobody can concurrently write-lock the vma). vma_start_read() sho=
uld
+ * Use only while holding mmap read lock which guarantees that vma lock is=
 not
+ * contended (nobody can concurrently write-lock the vma). vma_start_read(=
) should
  * not be used in such cases because it might fail due to mm_lock_seq over=
flow.
  * This functionality is used to obtain vma read lock and drop the mmap re=
ad lock.
+ *
+ * VMA can't be detached while we are holding mmap lock, therefore in prac=
tice this
+ * function can fail only when there are so many readers that vm_refcnt ov=
erflows.
+ * The failure case is very unlikely and is already annotated as such inte=
rnally.
  */
 static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma=
, int subclass)
 {
@@ -247,16 +251,23 @@ static inline bool vma_start_read_locked_nested(struc=
t vm_area_struct *vma, int
 }
=20
 /*
- * Use only while holding mmap read lock which guarantees that locking wil=
l not
- * fail (nobody can concurrently write-lock the vma). vma_start_read() sho=
uld
+ * Use only while holding mmap read lock which guarantees that vma lock is=
 not
+ * contended (nobody can concurrently write-lock the vma). vma_start_read(=
) should
  * not be used in such cases because it might fail due to mm_lock_seq over=
flow.
  * This functionality is used to obtain vma read lock and drop the mmap re=
ad lock.
+ *
+ * VMA can't be detached while we are holding mmap lock, therefore in prac=
tice this
+ * function can fail only when there are so many readers that vm_refcnt ov=
erflows.
+ * The failure case is very unlikely and is already annotated as such inte=
rnally.
  */
 static inline bool vma_start_read_locked(struct vm_area_struct *vma)
 {
 	return vma_start_read_locked_nested(vma, 0);
 }
=20
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address);
+
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	vma_refcount_put(vma);
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 272f9ac762b9..2f94ee0fdee2 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -340,6 +340,41 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_st=
ruct *mm,
 	return NULL;
 }
=20
+/**
+ * vma_start_read_unlocked() - Find the VMA covering 'address' and read-lo=
ck it.
+ * @mm: the mm_struct of the address space to search
+ * @address: address that the vma should contain
+ *
+ * The fast path does not take mmap_lock. Waits for writers to finish if t=
he
+ * VMA is being modified by taking mmap_lock.
+ * Use when mmap_lock is not held, otherwise use vma_start_read_locked().
+ * Nothing prevents VMAs being unmapped/mapped before or after the VMA is
+ * looked up, if a stronger guarantee is required, take an mmap_lock.
+ *
+ * Return: If a VMA exists which spans @address, return that VMA, read-loc=
ked.
+ * If no VMA is mapped there or, very unlikely, a reference count overflow
+ * occurred, return NULL.
+ */
+struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
+					       unsigned long address)
+{
+	struct vm_area_struct *vma;
+
+	/* Fast path: return stable VMA covering 'address': */
+	vma =3D lock_vma_under_rcu(mm, address);
+	if (vma)
+		return vma;
+
+	/* Slow path: preclude VMA writers by temporarily getting mmap read lock.=
 */
+	mmap_read_lock(mm);
+	vma =3D vma_lookup(mm, address);
+	if (vma && !vma_start_read_locked(vma))
+		vma =3D NULL;
+	mmap_read_unlock(mm);
+
+	return vma;
+}
+
 static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_stru=
ct *mm,
 							    struct vma_iterator *vmi,
 							    unsigned long from_addr)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d157e15fc77c..6ee933a3803c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struc=
t mm_struct *mm,
  *
  * Should be called without holding mmap_lock.
  *
- * Return: A locked vma containing @address, -ENOENT if no vma is found, o=
r
- * -ENOMEM if anon_vma couldn't be allocated.
+ * Return: A locked vma containing @address, -ENOENT if no vma is found,
+ * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
+ * overflow happened due to high number of readers and the caller should
+ * retry later.
  */
 static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 				       unsigned long address)
--=20
2.55.0.966.g6673acef38-goog

