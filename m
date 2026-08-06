Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779AB44A3FA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046779; cv=none; b=s6iuuZZmlyIz7J83EzK1z7U4FbPH7/mKuaq3NFpjIynPwVn+/Nvaw2FS/LIzSKx7BZ/DoAqbd+KkNwrb3Vs9XjRClud4a5YDsb9pM+XpqWyME0XAQE+N91uKpw59wwsl5U6tscQb84KGKcJSxomxg85RbwZKy9r/3ZQHvMGGfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046779; c=relaxed/simple;
	bh=TPi0HX2ysFtmGcnCVFDQsVS2ZyLYaf8xLB2ebNG9mOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+ajbP/2qcImMHihlfkNR8O72AGH/hVnN6a7ZQSz/BXAQWXjeZ5lpsi6IMjLK4pSccrzj7H0jJEwmyH0goAOiFyFIY2ryyXyQ7IYr9glyTRlGk3bZ7hYwdIfTgbPJaIbT6ngE1l//13ykaidBGi2GjkLw0T0qk9bUYDCb+6FjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpS44DOr; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpS44DOr"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9c26587e67so1315712a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786046763; x=1786651563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FBBPYUiw+wGnA3pW6euCqNL/2cPXXNetrkceEEdDJ4M=;
        b=hpS44DOr2zunUyEdaAMcKvOltrwHWaXiTJjDM3ugaWYV12Svs08N2FpBI3/UYEUV8K
         0mNRAwcKNa7czncq/LBMXy5s+/4UrIHvFe5aGRauwaKNMcyRkObJc9i+Lvpz47Mk5Anm
         +vbtaHitC6Ro2COJrgBabl7YeBiMnl947PIvlnVs8zoMGd9Np/HtUZQ0gzMKZx1A7Ycs
         CzdArs+E2Qy4LPvpAhCX5Y4+yTe06vafVadghmE4gN2GAcF/E7mAfp2zI7x4d+k+DDlF
         /fZdz9L+i8pp2dYekpkYYG+x2R7pgR8a8+gaZRCleA7bVXTDlMKD1h1JxOojbdCfsWf9
         x9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786046763; x=1786651563;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBBPYUiw+wGnA3pW6euCqNL/2cPXXNetrkceEEdDJ4M=;
        b=BdpZK/5KRWXobFl4DNii1XxlCce9T4wm117T2m468OKH7gIZUutSr44HPFGAA4vfoE
         s49XnTtM8yRggtMIZHhF6LCcOt7wik/kUBEScPp7kwG7fdjlGge0IquoxlDO4dtw10eq
         3Ts+T9B/OZ686rOk6kzDQSa+AgGL6QB1uTeoFzlYcG5Q5jDdYrEYoGckL/xGR5XcOOy8
         rGhzcW583mFl3MJJStuv/UJ4AMuyFyrwVXcBOBmKV0bfqDUOP4YfCe9J1xEYhxv8u3gH
         LJiQw5EG/96R6hydR1/cudXdwx/KVV/3KrcgMrUDi/FCVUeGgX0PaElAOUf/Mjw+yosP
         IzUw==
X-Forwarded-Encrypted: i=1; AHgh+RoAp6zqCEqKefQugu0dLdJhXDYtxWLIpN/5bjos2PtwChxOuc8ZXOnTiXa8nViFWY0QB83w/lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM71KurIzdKnKdgs/pxDKPhA+Co0PS/jTsv8USaRTX9lLGHg5r
	PISkd6/NTYGspJeTIXN2l1cg1UR9tSI7V2wRNuqVxKGqV7mQQOcpaG2I3CTOqjAZdsGa/fhCE2/
	0LZuEtg==
X-Received: from dlea14-n1.prod.google.com ([2002:a05:701b:420e:10b0:13d:31db:8d94])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914f:b0:3b3:a66e:3911
 with SMTP id adf61e73a8af0-3cb9c2c4782mr8716046637.19.1786046762261; Thu, 06
 Aug 2026 13:06:02 -0700 (PDT)
Date: Thu,  6 Aug 2026 13:05:48 -0700
In-Reply-To: <20260806200548.3124802-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806200548.3124802-6-surenb@google.com>
Subject: [PATCH v4 5/5] tcp: Remove mmap_lock fallback path
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@kernel.org, willy@infradead.org, shakeel.butt@linux.dev, 
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
The fallback removal does not affect NOMMU case because TCP_ZEROCOPY
is gated on CONFIG_MMU.

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
2.55.0.654.g21b8a5bc05-goog

