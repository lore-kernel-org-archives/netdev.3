Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C2483BCF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046772; cv=none; b=AOM3BRdRUlxnEzkGPsHLST7PUtTTDf/75gE4vOv4aVFksU0qCyGT0DHrdde5Jdm5jOi3MhPzkmGkhRTiSZ6rL6U9O/uNReSKky7ERQexWVCbWDMymbTIumVVfwj3JI1V1zR95nswstq6mL7be8Xlo31fc3T20aHwLfslvikJA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046772; c=relaxed/simple;
	bh=mUqZ7Veb1zFzK/WMrx+J1dlL4u1EqvbVFzzSi64rsvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBogWH3vXJPcxSWvnPC8oGoXZAiqGPFriLV0Z27RtUgr2mISuFUBJRN7U2V1gtxoxeFjKut26XbVX2jLEju6d9dUcC31lfYWGwmQ4LhJ6fEJMD92SdbBmXtmwZJQiWNtHKO2knYt99QyMbhTKyuswQ2vVL/I5rVT8AiWZTanO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVw/f90+; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVw/f90+"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2643248a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786046758; x=1786651558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WxdxEYaVQTOzSX1A2H67ZbXWMmNc4RyRDurH1LCMnVo=;
        b=vVw/f90+obTFzPKFfsClGu3kRPwL03UYt0y8dKQWUHgprYyT3RrxOSft8u83bV+4K3
         sLuP3wPdE28F0pGcoG2U3RuEwPIXBWGGGsc9O4Zo6Lqrq1gnQm/lM0vHTAlY6ed/HE0y
         9EFt7zeGJV9oenBKy10KV0pCpm2cbbxWiINk/IlsZqAwh8CVCPNZhRG085ktxsu7jRrC
         5rUeQSDUTkLwfTeyQN0hmcXk6Bk3Hu/FhD40Gm01uip0MWy127GrVI55UzbEhd4sMnFK
         M2e4CUalx+tNxau7InZ1lLHsdrD/PY5pBZ26TOWcxu30fDmjyFyqzcq2yMdPFygEcK2k
         2FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786046758; x=1786651558;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxdxEYaVQTOzSX1A2H67ZbXWMmNc4RyRDurH1LCMnVo=;
        b=amVIi5jn9x9cDRft/hkUBqiYT4UeJNcX/L1hsUAnHXzHzew51qQujkYcz1lwfjsRNn
         MusJHnT152q7sYEtY4n4jOMdIVp8DW4ncpVE8idXez4lf5sEIf99S6GCn5ljgo+k6kXu
         hTtOb6pet05nLkbYYw1Rt31rp5fx5G87sgQRcF/6zrmWFyA+65WuOAnWk8VRLouMBpQe
         2qJOBfoV6ajRFdZG5LQZ9gqEW9ILyl+jy6iKre9ITPCzanXU+JJ4sJxRCSzP2zQqCyyX
         +zJ3W5SvUjVzTkqYodG9BZplFAckL2DdCPhFPscztOZtalCSClw7mU6ly+cQZKzLIWJn
         L9nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqf/ZS3kT1W7pTEZHZxTjpMaEERKCdKF73aU662wcQEWf7Zif+M9xWG7/szsqgQKjURkW3TK8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5kBHIAevSVYHkh1hTH2NWPlC669PrauPnzPPJyIaWiYzwI8f
	bVEvwXQaKICGkCQb+bmSBoRgRXyHwqobsea3cqvfngq7r3GAnG9GA0/lF+IulCJ8P+ecr7FNSe/
	1ujxrPA==
X-Received: from dybgk24.prod.google.com ([2002:a05:7301:198:b0:313:cf3c:796])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:398:8870:b58f
 with SMTP id adf61e73a8af0-3cb85de7ddbmr20267974637.14.1786046757653; Thu, 06
 Aug 2026 13:05:57 -0700 (PDT)
Date: Thu,  6 Aug 2026 13:05:46 -0700
In-Reply-To: <20260806200548.3124802-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806200548.3124802-4-surenb@google.com>
Subject: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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

Add vma_start_read_unlocked() - a variant of the RCU-based lookup that
waits for writers. This is basically the same as the existing RCU-based
lookup, but on a failure to lock it temporarily takes mmap_lock for read
and waits for writers to finish before locking the VMA, dropping the
mmap_lock and returning the locked VMA. This has some advantages:

 1. Callers do not need to have a fallback path for when they
    collide with writers.
 2. It can be used in contexts where page faults can happen because
    it can take the mmap_lock for read but never *holds* it.
 3. Its fast path does not require taking mmap_lock for read.

Basically, when applied correctly, this approach results in faster
*and* simpler code.

While at it, fix the comments for vma_start_read_locked(),
vma_start_read_locked_nested(), and uffd_lock_vma().

Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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
 include/linux/mmap_lock.h | 19 +++++++++++++++----
 mm/mmap_lock.c            | 35 +++++++++++++++++++++++++++++++++++
 mm/userfaultfd.c          |  6 ++++--
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 7b2bbb09a952..a23fe6cbe301 100644
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
index e20d01e8d38f..1c4902131e98 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -338,6 +338,41 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_st=
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
2.55.0.654.g21b8a5bc05-goog

