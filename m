Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE995424653
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649696; cv=none; b=Eg0BQB/74Q2jARv47ESCwjsYQeqtvSK1h8V0YAgZTZcJQw2+MlnwYG189sAlAbpKZukzvMAwdYIPriJK6819r1Kgkg6jpy7qTjz+rBm99cUtgMCmLtecX70kyCIrbCi4h+tHhJ1Tc6tcTZ86q62n9SBQDv0sBiJt/3ri4Sgnjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649696; c=relaxed/simple;
	bh=HNYxBdyOh14kqgiYmhmFiuIu85oIFik1ZXi46cT5wHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trCyKsl24RVzYV9Ubemx0b23sPTmL0tmMrQQloBXfLATrQLcgIPUvqapyM6FLzAb1xl9tBEkRSmKgaWh7rBbBsoE/sulNRnbCje89/sQICQGMSagd3lKXKTnIFUO7ft25IL37AWqG7MeartxN8DpHL2xRgaDbuI3hnhJ/OHBH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rpwv5xBX; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rpwv5xBX"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so1438620a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786649692; x=1787254492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3M2OkRAFnIlxQQMdn0Hyw7w0AIFN/vFNTKvAHQz2U0I=;
        b=Rpwv5xBXu411xQHHpzRctYPo8ORo/mQJhYIIg7/06Shxzzc2MZBBuFUo2QW9Ez35U8
         3I+C78rXCSORvhYJYWDqBf4qimMee/mlZVB2iZ/Lbl6xxrNDD8+wnx+ggQ6YPudZ7D/n
         WaTLKmoZSPkNYM48znhOW4ZEeLo7RafOa2MSiJsX5Ocf1gLMQT3AEnQbwKs16FRMEgIV
         x+/niVhAX8F0g4zjfnfF4y/W3wq/upAPwrmwwunWBzKCEylgxuuw8yH6ti3pOdbeMsWx
         wHU0QzrWAX/D9krED1GlxQy3N6nPhr8y70rE5xRHSLxRFjRe4/TrBo4spdfkOpQr9+1O
         Sgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649692; x=1787254492;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3M2OkRAFnIlxQQMdn0Hyw7w0AIFN/vFNTKvAHQz2U0I=;
        b=j0s+N+XGGHnMvtXr/AIJya/ajnYKvkCbqIZ8GdLOjTqmaANrLCRQgTyuM0n03xe6Ou
         LHMbXx5Z6ncIw2oUNsYMxdS35iasxB6EFUDS1EN5LeGu1DhPUaMk3UkcqARa1RUKwu2K
         DyxN+vjNdcPwQZb7gA6StgCbtdU6xFrYfVdyQERKiPLMY3/KlphTqYlnQifHgWswqFKJ
         afq8xzm5g5D4xI4TXX8f6SFX+8brlCWIvHV7kxxMvgATRz/4l+FSWR81hTxF+JM3lTgc
         d1vrA98YexET+k8dJCTdlZReJWzm8NuSVheVa2chk6W3aE7W19tfMQeBrT1LXHZGjrZ5
         2Zow==
X-Forwarded-Encrypted: i=1; AHgh+Ro4nsKpTFLwJk5IC27vZQcTw4ZZUPORaQd8gA2GUVPa+mO0h8IQxfnqhcXJTrFQoFyee4dyCt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pOHrGL+oZPCQPb3lr5LwxsLLMpl8s72dRvNvb7MZ9V06XjOT
	dBb7sM+jiE9+928wi+yFClMcFQ7SBW3AUnTAYRg0mX6MVnaTybH4AY/dt1L2rCzZthNR8cxXo7J
	b4pjkJQ==
X-Received: from dly4-n1.prod.google.com ([2002:a05:701b:2044:10b0:13b:4811:2202])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c3:b0:387:d9cc:7dc3
 with SMTP id 98e67ed59e1d1-3931f61cca5mr4683554a91.21.1786649691719; Thu, 13
 Aug 2026 12:34:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:34:33 -0700
In-Reply-To: <20260813193433.3318288-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813193433.3318288-6-surenb@google.com>
Subject: [PATCH v6 5/5] tcp: Remove mmap_lock fallback path
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
2.55.0.691.gc56d675ccc-goog

