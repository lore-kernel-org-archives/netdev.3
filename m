Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19073D565D
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707717; cv=none; b=RF7dxoJwqtQ3Dso/qMy0jQmmv3Hw71R/5KlhZomQtdCacBTnDQ0SGWBba4fEdC2xMWYVoioUMzSf+OCe3R/IlHJHLr4QqsADWsVi1yoyFrvkR+xi7+FVqDy5Qp4QIH7uAAtK7vwyZxWKNpGVTf3z0q+czuaosmVICbYRX5QH5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707717; c=relaxed/simple;
	bh=ehiROkTUONMb1XfowgmGCN5Etu/lait0K9h2IywdBVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n6rrOwrs4lz3qWKSKT7Tzzh0YXcwK2wCLqOCse1RcFmURGySXFua/LBLIS44HytblpAQi7kCnMIQtUCpM9oavOflCN2qVBaC1A4PZFmHS68ebUiZ3O9Y1UMWu6dOZ2V/amqW/5aihPq1cQ8vmeDVxKlCisDDNgZk/D71bMhkimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMKyf0mU; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMKyf0mU"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb687f82eso40344005ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785707715; x=1786312515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNzfa/Q2B0yr5cHe2iHTydpaM2L8dTGY4PL8h7AQ+vM=;
        b=VMKyf0mU/9SO7w/E6ybQZ4ENACjFKRDBksqBCXWpemQN/KzAMU5F1k1AzZKdmdL4vz
         GbT/eqY/LBIzayWtik7o6xGHolJrryrf/tBhI134vqW+kiWbLcwObmJqUzvLqEfCjHZD
         JiStzo6wdtLIxTNWKPrxXrpGcjJqaqG9r5LCfobm+nQMfJu+qV7vITkbsmPX7eFfw0pG
         eAy2UzVLQBjAK+m9t/nYBFSuHLYkUm+gnV5si98lNT7yefrnVrNbD80VO1B4srkHrsFH
         XOV854NmNpNzSaqjggq8zelePSasPHmOXnooOqoKmN4b5dCa4VcQg1hg7InlOtUZ9tak
         Fl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707715; x=1786312515;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNzfa/Q2B0yr5cHe2iHTydpaM2L8dTGY4PL8h7AQ+vM=;
        b=gVlZqDu4WDkDYt7lrKxVWD2L7PdbcAVPdDm+z8N9n7dqNDVjLC3kXm7RELZKEIMM5l
         +oWrdjgZJffdarXSPSHvmanwAulKq8cVDVIa7Lv7fLVO148tsJr8jIW78UzxQ1LinBjU
         PmzuU5JMeRkg01qLHYsolCe4qQ1xUwyoo38cXWpRD+WKzLBac6C1XeSOIIRpopEsgkUF
         dDewfIe3nUhcXGaLavKXiWArYWH/u3WUyZkSHle7L6qmILN4Q5DtQoGflzAwVf7QNObs
         RWuxX7fhIlfsn4ePw/t8JtpBTb8JKOc/vQJMrFkn4rSeUONyPCpQXI8yZywkbTkgY8gj
         4vmg==
X-Forwarded-Encrypted: i=1; AHgh+RrnWb5PZj0nw5BcYDVfqjPs6XbkIhHwN7vUxVUPxlPbYGUxtmJebi4dCjwz8GEyM+pq2wxVARA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYaOgmsIq4W+0BM5U1o2tHi6yekEATDs9yYVLtDZ6MrPh03ScT
	sad6e5AV8+aQg65cMxwhXZi+SMIfzqpAVSoGgjGyXc81xtP1LhHO2D/R2rtdrX6QWY/cq4y9BNG
	CBP2PKA==
X-Received: from dlep14-n1.prod.google.com ([2002:a05:701b:458e:10b0:13d:2928:7996])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80f:b0:3ba:cd5b:3dc8
 with SMTP id adf61e73a8af0-3c92a5f1c89mr7273098637.31.1785707714551; Sun, 02
 Aug 2026 14:55:14 -0700 (PDT)
Date: Sun,  2 Aug 2026 14:54:59 -0700
In-Reply-To: <20260802215459.2769283-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260802215459.2769283-6-surenb@google.com>
Subject: [PATCH v3 5/5] tcp: Remove mmap_lock fallback path
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	surenb@google.com, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, the per-VMA locking could fail in the face of writers
which necessitates a fallback to mmap_lock. The new
lock_vma_under_rcu_wait() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

This really is a nice cleanup. It removes the need to pass the lock
state back and forth to find_tcp_vma().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Tested-by: syzbot@syzkaller.appspotmail.com
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
 net/ipv4/tcp.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..62defe70f3ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2167,27 +2167,18 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *=
sk,
 }
=20
 static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
-					   unsigned long address,
-					   bool *mmap_locked)
+					   unsigned long address)
 {
-	struct vm_area_struct *vma =3D lock_vma_under_rcu(mm, address);
+	struct vm_area_struct *vma =3D vma_start_read_unlocked(mm, address);
=20
-	if (vma) {
-		if (vma->vm_ops !=3D &tcp_vm_ops) {
-			vma_end_read(vma);
-			return NULL;
-		}
-		*mmap_locked =3D false;
-		return vma;
-	}
+	if (!vma)
+		return NULL;
=20
-	mmap_read_lock(mm);
-	vma =3D vma_lookup(mm, address);
-	if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
-		mmap_read_unlock(mm);
+	if (vma->vm_ops !=3D &tcp_vm_ops) {
+		vma_end_read(vma);
 		return NULL;
 	}
-	*mmap_locked =3D true;
+
 	return vma;
 }
=20
@@ -2208,7 +2199,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	u32 seq =3D tp->copied_seq;
 	u32 total_bytes_to_map;
 	int inq =3D tcp_inq(sk);
-	bool mmap_locked;
 	int ret;
=20
 	zc->copybuf_len =3D 0;
@@ -2233,7 +2223,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 		return 0;
 	}
=20
-	vma =3D find_tcp_vma(current->mm, address, &mmap_locked);
+	vma =3D find_tcp_vma(current->mm, address);
 	if (!vma)
 		return -EINVAL;
=20
@@ -2315,10 +2305,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 						   zc, total_bytes_to_map);
 	}
 out:
-	if (mmap_locked)
-		mmap_read_unlock(current->mm);
-	else
-		vma_end_read(vma);
+	vma_end_read(vma);
 	/* Try to copy straggler data. */
 	if (!ret)
 		copylen =3D tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
--=20
2.55.0.508.g3f0d502094-goog

