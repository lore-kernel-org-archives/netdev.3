Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4721D5B0
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497070; cv=none; b=ur3lkh/T/eTI7+tGVRWdexiUZ1yA2aFvpOSPGdxHYob03MZNcSQ7jVfRSHBy4qglNnefiMq3/2DFjIayyZpMmrZTk5TqrjD3OtvMiJA8g8NUeUpmlkkOEgeNTOvOcGOYIUVefeF4VTyFZM1PdXVW1MOZD6Ua/22gybR4MhzBeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497070; c=relaxed/simple;
	bh=rIFwQlUSYrgYFi0zbrVtfprgU8wmJ9FpZk8etm6u6D0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6bC6tD/LJzaLJewOlD9n8auEZCvL+yONRV5BmF0H637AB5eB6lgkDOJZHEvhpplRF+uBTa9JxoeWE1cFySJ+CBQPw4UzKLWQ1uSMnZLDIRAaB8OLDS3H64gOTRtGFWcyDtvoU7bWD1e+O3FDzXJUY7rA6r/OcPmKkf7FJ5eD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX/RVIwp; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX/RVIwp"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso306261a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786497068; x=1787101868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rPcWv3lIZQHmlL4xVWCaljaB1PQXpS1s6XfJcGGVLeI=;
        b=SX/RVIwpouYw+otK0jhjEgcmTBiHNPeBc+RVkP42TI2WogAFkqxaYdijmd0mjPbsqv
         eJfco52+FinM9R1eUMx7tfDj5lsvgGA+xWwJlDbrj1O7cUV733o5jhoe8vMJc8Jn4XSk
         6lNi/FRDJqR3AlI5ce5yPtpyXs50Jc0KqyWhQ8rOdbuJgDUwowMFwJLl5Rl5xZiKsKD4
         6Ws2vIJi5ddWePdta4uFdd799Gt9JkK0V7wmsWvOyT/En6reh9poV0a5QEK+ICSQaTIl
         g2Zux1aIedGaTh7koZsAQdTKZc+1W6Uk4RDwLHZ0ufc5cLlDGbU8HYmggBFkfWY3ILys
         lKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497068; x=1787101868;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPcWv3lIZQHmlL4xVWCaljaB1PQXpS1s6XfJcGGVLeI=;
        b=Z2sxHq3sKA04+mUn+F2jcY37wtI6qvgC8toFHP1yIX59rmyuIQsHnrsCzSltaxfVYt
         NNLYqA3V223wdlBcD5yxsao/IapyhkQk1YsDoNLiNsyi4C5mnU0GDT/28NtU8v+EU3UW
         TI9uASSw9xZtV+sgySWyqduxYQ3tWya9mZyeu0BpYfYBkII75UMWRPIbK9YgNOTHBuC5
         dihzqdMFlOpWgF7PIA/jbBf0kt96c6C43iwBmnwQYqgyTP7xPMdfi/AKomt1CqoIifNz
         S5XVPe2pLLNCbPi1lFinheYhuiql+6pXimMBRlfzXHcVF9GI04XP25zKjzgJRWxv2K+3
         pyhw==
X-Forwarded-Encrypted: i=1; AHgh+RqNhX1r+ugT+3Az+fN3MS5YBneRkJF4yCFFSlqNqWZgU7/mbKxURU+WYb8e1DmYkqyc0ujOo4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVBGmZApdB9tTVIm973+zWF3hPasb6E/mMaOsqkU9kpILtASg
	Stq0OE5MRXV4FFjbaeN76qrSLgBPMw1u+NkMNYueBFs43+dOJZpOtTAFoQcj9/IYo9y7T2t8cS0
	MeK4LQA==
X-Received: from dlbcm37.prod.google.com ([2002:a05:7022:68a5:b0:13b:801f:924c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4a:b0:37f:a915:1c29
 with SMTP id 98e67ed59e1d1-3930167c7c7mr1130828a91.19.1786497067658; Tue, 11
 Aug 2026 18:11:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:10:53 -0700
In-Reply-To: <20260812011056.902771-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812011056.902771-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812011056.902771-4-surenb@google.com>
Subject: [PATCH v5 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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
index db2dbf84943c..5a3626dd0c18 100644
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
index 0b279b82eaa6..d17ca4d2bb39 100644
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
2.55.0.691.gc56d675ccc-goog

