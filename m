Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410763DCD8A
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707713; cv=none; b=jTIchR4awGmGI1QKu0/1k1BCvveb7BukAWK62/xOjMRiA4V5vuy0wHoPnvLNXCRTDlX3t0aSQ4q+lUnlBUut8aO2621QexsfDErxV50VF77BOmSgg08qLGyIFBaoqoUyN4AwytK89r/QW5b54e8ByVPkX8QocSbEGTdhA/nKKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707713; c=relaxed/simple;
	bh=+YqZSzP/I2a03BPXHHL01Weg11cKi/MFACPBRAnB+Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WO6Tv/xnn7W51uW7vKCb+kuoKjPRs+kV5wkcNaQqXg1rypb0ktblbEXmGLywJfUGDuDgRF84ypKVz1j8nUJBU7iAsETrYPhaFZ8Ie8OqFb44dioUsVVyRNrQL5nwAIXiGSezBo8YIPdZzMmci5BkdoDPOLk2mIf+UTfKd/oZziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSjvFYZn; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSjvFYZn"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so1266198a91.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785707711; x=1786312511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PbBMXqyTQfOdEQP+TBH4NONBT8Q85IiQo7bFMy00X9U=;
        b=uSjvFYZnu8GohW7U9KMKhq3DcLY7BKupCWaq5TzP8t5YNxv5L5Av9W8LqpwN+pL5c8
         vqQQFrH2T1X9dR9/004amEZuPTP6lNIY2QUnKZPr3hO3S3w99kDL36HfSxkeyPaYbOpr
         zVuAK3bLLAyn6OJIqAIesvYFK+sEfwdOxlcTiJoZRMerkIN0YGuu5cT1fkVfOQaUuTpB
         AsOdwKbHm/pG/paIrqEt/1Jo+FfI9I+FzCZ4SBz/0CicZtGdOVxji7Ndi9ADWaEA1ZW4
         1qPfbxJQWFTrwSUhXNRuA8T9DLB2yvmv2iaIrPzwmvc606VgjETCDgHUxw0Mu64EBMUm
         UqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707711; x=1786312511;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbBMXqyTQfOdEQP+TBH4NONBT8Q85IiQo7bFMy00X9U=;
        b=bP7KwWjXwRj2N45EwLi84Q2vobnLX3c/582F9NcSuJ4AgNapLlTppcTTvaBotPYlLh
         imLQHOfdc8vOUiNgpcCN+MnyX8U2RwXvsZM7xFdOhlatGFX6SfrZRK/6bWo6AJHuX0hy
         jJX9ADRMihXxREYXZlSfXQW5zmcluGZQr4s0iFvEAUrFlAKW3yG8Ahrs32f04DwONivL
         frsAdMdzpo3U9P5Wjg4T+IKM6GOeOGkPDqiog0ClZcKWweat+Eto/EHPcaD99EogiBH5
         dfQbQGoB5fAOkEd9DUKLQQSuU+kpobAaJMysYm96ImmaG4fUqmqu2dVaOr0FeO2DcODu
         qT9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpNBfuqyz5FAhvp4l5b9AzJf5AR14gEqO40b+PEq/yFKK8tgi8f71oV/WLI5oh+AtyD174gfTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpXZdl/xU+/Bzf1Wt1bdGqOwBmP/SZA1Ebq7opiG+hhUIIeV5
	H9P5jVg7IXR5hpvLGiNDZTAQKLPKFRjjMeG/lhYxz6omg6vyKYxP1xHJa2MX2Q9WmpmjH5KEUMY
	3ITtezQ==
X-Received: from dlbou23.prod.google.com ([2002:a05:7022:1117:b0:13e:6e68:2a1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0c:b0:37f:c69d:ce69
 with SMTP id 98e67ed59e1d1-38fbc432bb3mr6817011a91.10.1785707710250; Sun, 02
 Aug 2026 14:55:10 -0700 (PDT)
Date: Sun,  2 Aug 2026 14:54:57 -0700
In-Reply-To: <20260802215459.2769283-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260802215459.2769283-4-surenb@google.com>
Subject: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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

=3D=3D Background =3D=3D

There are basically two parallel ways to look up a VMA: the
traditional way, which is protected by mmap_read_lock, and the RCU-based
per-VMA lock way which is based on RCU and refcounts.

=3D=3D Problem =3D=3D

The mmap_lock one is more straightforward to use but it has a big
disadvantage in that it can not be mixed with page faults since those
can take mmap_lock for read, which can deadlock when mixed with nested
page faults and parallel writers.
For example:

	mmap_read_lock(mm);
	// Another thread does mmap_write_lock().
	// New mmap_lock readers are blocked.
	vma =3D vma_lookup(mm, address);
	// This deadlocks on mmap_read_lock() if it faults:
	copy_from_user(address);
	mmap_read_unlock(mm);

The per-VMA lock can be mixed with faults, but they can fail and need to
be able to fall back to the traditional way.

=3D=3D Solution =3D=3D

Add a variant of the RCU-based lookup that waits for writers. This is
basically the same as the existing RCU-based lookup, but on a failure to
lock it temporarily takes mmap_lock for read and waits for writers
to finish before locking the VMA, dropping the mmap_lock and returning
the locked VMA. This has some advantages:

 1. Callers do not need to have a fallback path for when they
    collide with writers.
 2. It can be used in contexts where page faults can happen because
    it can take the mmap_lock for read but never *holds* it.
 3. Its fast path does not require taking mmap_lock for read.

Basically, when applied correctly, this approach results in faster
*and* simpler code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
---
 include/linux/mmap_lock.h | 15 +++++++++++----
 mm/mmap_lock.c            | 29 +++++++++++++++++++++++++++++
 mm/userfaultfd.c          |  6 ++++--
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index eb32b482434e..fdd8f5cf5722 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -228,10 +228,12 @@ static inline void vma_refcount_put(struct vm_area_st=
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
+ * VMA can't be detached while we are holding mmap lock, therefore in prac=
tice this
+ * function can fail only when there are so many readers that vm_refcnt ov=
erflows.
  */
 static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma=
, int subclass)
 {
@@ -247,16 +249,21 @@ static inline bool vma_start_read_locked_nested(struc=
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
+ * VMA can't be detached while we are holding mmap lock, therefore in prac=
tice this
+ * function can fail only when there are so many readers that vm_refcnt ov=
erflows.
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
index e20d01e8d38f..6ff05e68e61b 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_st=
ruct *mm,
 	return NULL;
 }
=20
+/*
+ * Find the VMA covering 'address' and lock it for reading. Waits for writ=
ers to
+ * finish if the VMA is being modified. Returns NULL if there is no VMA co=
vering
+ * 'address'.
+ *
+ * Use only in code paths where no mmap_lock and no VMA lock is held.
+ *
+ * The fast path does not take mmap_lock.
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
index edd90892f8cc..c3a0c38a3dc3 100644
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
2.55.0.508.g3f0d502094-goog

