Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA43391833
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208276; cv=none; b=d7aGjE/F0nmJdDlx4I/voVM33F6azZU4FXSGJ1PaqNgLAWjj85UAQjqfb0vZfGnaVt8f7XPUohKHkZSMq9zKfOZt0ivGQdJ1jwKztTuTc9b4dsfL30SyGjLYNbe5CDyZPHwmRnYsW/ynQvcI+jswexaKUqaocLQP+Gp1dbMIMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208276; c=relaxed/simple;
	bh=H5Lc6BdEbXCjpa9lGiNJgyEyPhusZ9dehbsNMdHLR0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zp8OvF1Y+j0+7ODzYHhtzupzLhITXlecolajsn49Horz83LFupm6S6atdqHIgGF+lMMZsBxqkhUt56qb/cDT2cKzDuQNHzGdyhVpk+Mg4iM0EjmkVKutjAioH4807iUmpoZbRSLPc8axKiFDkoJuTki/R1FeyVhDkXIkYNnGYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBLLhBHv; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBLLhBHv"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc12e8e22b7so427128a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208274; x=1788813074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ELv/N+6IjeKMBTz6azi//X4BSCo29f+bI+vir4cQf2g=;
        b=ZBLLhBHvOCgw7kUF5dNd2jmtO+8THjspA1cTInUjnr87Ed2Ovju96LfdVPFxSbAS14
         KRKMo9vlSmYswJ26SLiM7Et/xnvVkyUZXmabcktlbxKkYQBDk1rOdpdC9HBocMYRb4SG
         tCqa6YhN7PoqsFaFPK9ojkQNLmQh4MicQCb8UN3ZutCoceHEXNwB/Pv0P2cCRm9CLGW2
         T/ebZLjCYNJykqeKx+vbXKyWQnapnEbVZI23xa3xEVOZ4jY3eKVuAbkgXl0wi1ZbNjAJ
         aCfCEmMuitYlWHk8kIvPo8vazc88Od7+jJ/Jq6bmZfz5I0oZfF9ocsBhuis4nU/ZVMhF
         ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208274; x=1788813074;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELv/N+6IjeKMBTz6azi//X4BSCo29f+bI+vir4cQf2g=;
        b=O98SpkuRZfiwa37NuqIC6Hp1vJxHHraz9+5o+oeocsxrRQxJSMLHb1Jz0feoMhusw2
         2jpbmJ+/36gPtqmZHdAAGouaou7UmJL8XlhtQ8ztZVRjhqo6GYkPZ3d6ET1UMuOaL2ve
         WUAXsTD05yiTD1Q0oAnlLJYm2qLuIxXdNrMZ/PQyf50ySm3DefBlYT10TpTx2Xd40n0i
         ITgS/o0olNzpXfPyx0g4+XYam7ixrODq7IK/yzZea/U6QEkcJunCTh6kiC2JVWD86zph
         wqUbu6pCSAoUhmnDMC/0r6kg/Bp8GNh+cI3uD8/Wr9mXSxf935KssvCza2PRycjtCNFy
         jWsw==
X-Forwarded-Encrypted: i=1; AHgh+RqmWL31VuyDKImfQiVRNjIe80h5XlxHI4jZvi7O74TOTSxExgbIm+lQYVjbsG1E7SzM+0fQsHc=@vger.kernel.org
X-Gm-Message-State: AFuF++m3Ezcvh6m76G5TjRyuaCJBCVw2ERbPyqszptqz0tYJZ6ZP12P+
	+wYG8Nlw5B5FWecIt7Cgx433w0ATinu/dOj6KupGRQcLQiazVo8KSSLa6nxPc7zi8Q65uFlVYL1
	G0s6+cA==
X-Received: from dlbrl15.prod.google.com ([2002:a05:7022:f50f:b0:13e:5fe8:61ef])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a93:b0:3d1:e510:9052
 with SMTP id adf61e73a8af0-3d265e3f792mr48387570637.7.1788208274250; Mon, 31
 Aug 2026 13:31:14 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:56 -0700
In-Reply-To: <20260831203056.838265-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-6-surenb@google.com>
Subject: [PATCH v7 5/5] tcp: Remove mmap_lock fallback path
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
vma_start_read_unlocked() will wait for writers instead of failing.

Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
The fallback removal does not affect NOMMU case because TCP_ZEROCOPY
is gated on CONFIG_MMU.

This really is a nice cleanup. It removes the need to pass the lock
state back and forth to find_tcp_vma().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
2.55.0.966.g6673acef38-goog

