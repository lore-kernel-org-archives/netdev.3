Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED43A1D02
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516467; cv=none; b=EcV3YX4XRUmq3bcLXuNMZ2yFlNnfxUl0qSrRO65H/RoAZcRx6rDwhChHXRBe37vrfnmN5e1Oo/YEvi8BehkC3xsyKfzioCH3WhMIk09ejiXWn3GIuvJK5Q+8Ib5hg9mJl0sLZaQTDo4TQWnD5No3HNUjXXqK6Gm4HS09cRa3CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516467; c=relaxed/simple;
	bh=o12JbMTSFeoK/r63AU+k/svS+uhqrFaerOKDJ4ZcB9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNI19ENs9JJZwwy7DNXLry4ZnbfSg3cGf7yHu+kkjfAAOOSjyhJcJs6KNP7mOus2WSMdSwjkuRRSARzLoD3dItlcJIyX4SHUfgLfb3nlWWV/1NV65LndTdb5mzAdhsAHmn1pfm5drbNQBkg7BlM2fCV8VRkw5FRt3W1RpndoqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=i5AYMia1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="i5AYMia1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381216921aaso1174534a91.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785516460; x=1786121260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnvpZgeA+OJHyhm7+CrlyRLa89rAxmMv6al1YvTxCwo=;
        b=i5AYMia1y/fIqZoFiNOwI7kl0Y57D+7Kj2WxKJ3p+oyv39NWIRXj1dXfPhWAHwywyi
         dmR0L2M7ghUtftQM+R5ljlTlyBtyHDcrXBAberKwkMk8EGtwwEWS9WFnotbBkaKzhtLH
         JUaAoPwjVw/Ciac4NYJpe69OwA0vDo0k+mrtIH1MlrPF9O9ywIAaR/B5ED55jJZEc/YT
         8OhFTN8P5KgzqGXNRnqGR+B9L2oyae0VBLLyLdZi77HgnAG+3oEahLLOwfjIZTERmxsH
         yEgoITv5U6XTtWP6CLhzPh2g8VR/MBXxrZcWvey5z1bcKj0Cztt0hyeRHwtfZDd/fUlu
         WhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516460; x=1786121260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnvpZgeA+OJHyhm7+CrlyRLa89rAxmMv6al1YvTxCwo=;
        b=fQWMldrT5z0NSfIbhBZ19a4yh8KsW28xQfCZc984XbewtTlUHuT4NpHmLhm0PmoW2v
         xcSiLjOEWCSacjDzSLNmac3/la7WuDFIm7lPdm6E+HxxQ5ICCADUYXwG0Z24KeENbPgZ
         h60h0f1N0F1IDWtkuLnpzGjUESSI9cKe77cu10ZR/rHGEbJZJHtR2CNH6pyudJ19+pke
         +xljGC5H8QwORg0DNSg2tt1lY7l55YZbxa9rV4OzerkEYHOMgf5wXDth2apJNVhbRhA2
         Z5UktypQGckT3FPtN2hZ/Z2b9nhmaUBzfOZi1bmO4/JwazvNZNJsAb0Cmxeihcc5IqVa
         aOKA==
X-Gm-Message-State: AOJu0YyUc32j7bIRrFOffMJimSS3Rr8SkGlgZCJ17asSrdUFF2Wbr2ug
	WM3zEkA0um3rk6SvEfw6PPBukLXATrmpfzHsoubCw49y88F4Vz8YKO3QldDi1Onj1tk+xubhhuU
	4OI7YHTBp
X-Gm-Gg: AR+sD12C4jiXgu44C8Sk/MXOAspp32MxCJTBNaGFriij/mgUVAHTMVr9gnlTwug9T6I
	UC24CZs7y6XCNQS+VukQvfaszMaTRWv6aOzUqhAE8PsmUk54Wl1qwCNmP1o/qAfGvKHz4KTuJT6
	XHjsVPaH7pcRKuDZSeydbwqUIKWb+La37Ig4yINzstP+FwK7KRzb0OG7756qKbmgFDpMKjgOCMV
	jHiYyQ1V2YJSvneJy4lVw/rtDSs0QUjs98EXp/wnfyULFYUGfppKbf7ebykltb4J1SQkqzfhyIp
	SSoMVnQHjuU87kqHcXiLMJraUgg/RINE5Ch/GTI6c4DzZ8BxtJ3/CvNtrNI7hQjLYyaiijB4962
	fJssw1ETufyxDRQeNM1g9r1Ir8udT/8f2DeMv/mZ9s7vQ5S9uQz0WocTlhjK8n/xdogQzXBkvtR
	a7QPUntohchfi1O9SJAmPeTjfnqXuyBiUNJSGkh2/JkiJ1nvZuoK4kJA1+HjgicAcNmiDgbfq3f
	VcoR3Q/vgI=
X-Received: by 2002:a17:90b:4c44:b0:38d:b36e:982d with SMTP id 98e67ed59e1d1-38fbc55b74fmr470916a91.29.1785516460530;
        Fri, 31 Jul 2026 09:47:40 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b551b9sm451299a91.2.2026.07.31.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:47:40 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 1/1] xsk: account ring allocations to memcg
Date: Fri, 31 Jul 2026 16:46:23 +0000
Message-ID: <20260731164623.4694-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731164623.4694-1-zihanx@nebusec.ai>
References: <20260731164623.4694-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP rings are allocated from setsockopt() and can be mapped into user
space.  The shared xskq_create() helper allocates the ring backing memory,
but the user-controlled and long-lived allocation is not charged as kmem
to the allocating memory cgroup.

The current implementation uses vmalloc_user(), which allocates the
backing pages with GFP_KERNEL | __GFP_ZERO.  Use the same VM_USERMAP
vmalloc path, but pass GFP_KERNEL_ACCOUNT so the ring backing pages are
attributed to memcg/kmem and can be constrained by existing cgroup memory
limits.  This keeps the existing zeroing and mmap semantics while avoiding
AF_XDP-specific optmem or RLIMIT_MEMLOCK accounting.

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v3:
  - drop the v2 RLIMIT_MEMLOCK / user->locked_vm accounting approach
    after review feedback
  - switch the AF_XDP ring backing allocation to the memcg/kmem model by
    using a VM_USERMAP vmalloc path with GFP_KERNEL_ACCOUNT
  - include <asm/shmparam.h> explicitly for SHMLBA, matching the
    vmalloc implementation's dependency
  - retarget Fixes to 423f38329d26, the original mmapable queue
    allocation that introduced the missing accounting root-cause fact
  - v2 Link: https://lore.kernel.org/all/20260730153832.11238-1-zihanx@nebusec.ai/
changes in v2:
  - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
    user->locked_vm accounting via mm_account_pinned_pages()
  - drop the earlier socket/pool lifetime coupling changes and keep the
    final code diff limited to xsk_queue.c and xsk_queue.h
  - retarget Fixes to 423f38329d26, the original mmapable queue
    allocation that introduced the missing resource boundary
  - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/
 net/xdp/xsk_queue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index 4dd01b7d858e..d95b6d0d94aa 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -9,6 +9,8 @@
 #include <linux/vmalloc.h>
 #include <net/xdp_sock_drv.h>
 
+#include <asm/shmparam.h>
+
 #include "xsk_queue.h"
 
 static size_t xskq_get_ring_size(struct xsk_queue *q, bool umem_queue)
@@ -21,6 +23,14 @@ static size_t xskq_get_ring_size(struct xsk_queue *q, bool umem_queue)
 	return struct_size(rxtx_ring, desc, q->nentries);
 }
 
+static void *xskq_vmalloc_user(unsigned long size)
+{
+	return __vmalloc_node_range(size, SHMLBA, VMALLOC_START, VMALLOC_END,
+				     GFP_KERNEL_ACCOUNT | __GFP_ZERO, PAGE_KERNEL,
+				     VM_USERMAP, NUMA_NO_NODE,
+				     __builtin_return_address(0));
+}
+
 struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 {
 	struct xsk_queue *q;
@@ -46,7 +56,7 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 
 	size = PAGE_ALIGN(size);
 
-	q->ring = vmalloc_user(size);
+	q->ring = xskq_vmalloc_user(size);
 	if (!q->ring) {
 		kfree(q);
 		return NULL;
-- 
2.43.0

