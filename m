Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAB319617
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497078; cv=none; b=W/+iTu8dxtQ9rOGzIzHXcPSmHQLLCTfyDyWnVaz0vjStnYUwGhd5HdydXFiiBBMmED9jCtu1+W+UMlNzGKUq4MmlKy7/llLO22Udr8HpPB/PV2Zsh77fKJyqqS+JcLNTjhpKttBAa2TFq1imicXrG/LQDkAfNQW20JcCwhrRgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497078; c=relaxed/simple;
	bh=HNYxBdyOh14kqgiYmhmFiuIu85oIFik1ZXi46cT5wHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDoCk+MBdN+XsSjWeyq8J9H7CnVu2Fyu90E3Iz3eNuC5kpct3SNn6df79IRdeS5FamaOmLSOmsL4eLkixPAE9dskJSLV7Ua4Mm+pqKXy3qP8OSpxYkBHfcdKMEYuy2zGl/epN5UkSCKAJR46vfloWBQrDGCniRRNZMHkuFLg1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGeYK//K; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGeYK//K"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fcaa5f82cso453534a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786497074; x=1787101874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3M2OkRAFnIlxQQMdn0Hyw7w0AIFN/vFNTKvAHQz2U0I=;
        b=sGeYK//KFQnjK04R3ksCYpzxKEZU9as3qcLOXPWo8RUuajY+LjCqSKXuxbe6Nvp4nr
         rDbG1il5Jm+51vhA8cRkl1MwGQArVT8RceAZI/Z8Or1JJmceKm02k2e0uAAyQ8ljgMs8
         vUlHYm/jeUwmb9JdrcmoV2gZ76kq9DgaHr+CMcSVE4fVnD3rj1+02Hb8J59C0BGWZtbv
         mRC/d2kqw1AkkQseQNRxQ40yV0xOi14Tv5ONu4sKe3OtQKrgfNu5zQjIF/gJhojV31pQ
         RuFaBwTKNsMP1ThrHukBdyoWAcE5ROM4VAuzSJlSp2xqkJmPcaBiXIZA8GsO8q+4vovE
         t+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497074; x=1787101874;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3M2OkRAFnIlxQQMdn0Hyw7w0AIFN/vFNTKvAHQz2U0I=;
        b=sjbfQ2NNnyAB3/KA92Qc+kipvBTu/++qutHymc8+04JS0AX8WbMcE7JYIjFkVNnEH6
         yoib92Q8TLLu6PbruA4/Vhp63/m0Vt2ivcgAorurgRp+tj+ISL4QUy9Qh9Mw5PIz9syy
         OKqYmpbaWRxx6zlndFfH/N8QlYHuJ+Vam1AGdKgKR2Ckp83yGtQlZJ6GM1gBL8zX3aeh
         PJSHupuv5t31eHaOGF/JiSAr/IvuOjaz8sP8hZISMXhjwPsUHLY9CYu413PkPCL72m5I
         qn2+mbNNBmiXIw8Oh7pm5A3HmjDUIlQqJ5xW2ib18HZfs4FgOsCrlCA8woo14pyjbbZ0
         4rvQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6rgH+GzzapO/ayuXiQ+z9CFH9tgB0kT4zwG7TkGhppFIQ+S4xQbZ+vwht2g73qCJozupQCCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8qQs9PWkOI0sBcT55nldlndfn9SHYi3WpD4fru8AxIZQrvKq
	2+Q815hurZ39OyheWHa1uWkVrWdm+CiTbrj26cPi/0ipxsm+NVexzD05HuolCKG5Z7DIXm2brFh
	esPHZSw==
X-Received: from dloo28-n2.prod.google.com ([2002:a05:7023:a5c:20b0:139:d9c7:3cf4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580e:b0:38f:18f9:785
 with SMTP id 98e67ed59e1d1-393012380femr1349300a91.8.1786497073970; Tue, 11
 Aug 2026 18:11:13 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:10:55 -0700
In-Reply-To: <20260812011056.902771-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812011056.902771-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812011056.902771-6-surenb@google.com>
Subject: [PATCH v5 5/5] tcp: Remove mmap_lock fallback path
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

