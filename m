Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058012B9BA
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833815; cv=none; b=Ghrjp85uqHbfopJTUIPlCxk6jyvWfQ+z6E52/MFvWGt6V1OtyYxmzWptHseLTkow+LGcpM4q7HvLy+XXWNH0GF3TJuHhA5JxF9bxLsHWvWnbm2o3qcq+L/qKfbsCjpenbPJU5b3Y2Yjx4zbGONCEcGo1YW+EbfztbWzUXRrfh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833815; c=relaxed/simple;
	bh=KICwhkIlmqTTCC3V8YCRz3Yamy/kNQUTm125zo79z5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DraRlRRAMUp9sn2f1h0ZZAH0DgTRu/EhoJgQgk3Tpa2wJu5WhcDuZxwcAvjmOOvegmIRsbn4ZIkldekw4aRGWt4nCJl3KXfsZ8aMJ+ZWVZ4o8PKbhMuphgJB0vUjgNofv2srIakW8wfBbHQSTlZvJnu6tSYfXgZpeblpzELjx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n60J08TF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n60J08TF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2533d83e3bso199479666b.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787833810; x=1788438610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=15LHDzQZCLwjrAwYA0HhaS7ea9AMExN/a2BoPBHIgUw=;
        b=n60J08TFz1qFuYpr2zOgq0cbhlxycb8SajKkend/O/XbUiogI6ahNUQprwU/MrV+K8
         +0q6e8xaDt1gr/7miSiHt76yjbHyyBPbP9cmyYYXHolActa36WVJ3AMw/M9PCGiOUDXv
         M7yQjCWn6wBFIcWztWZT8Ueocc/HdEtxVVMO4Kynhm864Sfl6/ihBsWYauqWlNVHsCjG
         dtfpCXJqcTR2l2+i0ihos/iQYuOLMvUzVOjmXRGr2l249RIRcjdMPCYxx8YBOGJ5LXwL
         z4qr+PQGO0owuZRv9V3rLz+4ZYkfdrumgrYIxfoQb1wsBeTX3wHvPQMDDj1SIdoHvvME
         ZCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833810; x=1788438610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15LHDzQZCLwjrAwYA0HhaS7ea9AMExN/a2BoPBHIgUw=;
        b=WNQjGF9aW8leM4GJuyzvG/GW2inCoM0XeW10GD9TqUSOcj/Mv0VEgkLZDLPcnzdfeZ
         ABEWU4+cArsaHxiI2gO2hq5an4/EVdDeUint2unqhSU7Fi+Wfo043llvd6hrYB+3xG9u
         T9NdX6xZ4tHOeJOCJnYbI7xyvKK3SkgVFJdsD9mp4M5lVas3VVy/TvdYYXCFB7v4kjfx
         2zgzIoMoN0pzo6lLU/wtH1bEQzZVqDRMM21m7HMeqM6bx4rSa9VJIRyoTCXU5DcDejdv
         hVEXGPzpAkMaGRaeIVVKyd33yc2igrTfbVJCiWgapnS1OAabJW/DmYWtZo7eLMNt18jQ
         UaoQ==
X-Gm-Message-State: AFuF++kXRMa1q4fH+ac7R4qYMMedc4m1XWQo6iOUoqcKTMkLs93qrsZW
	J61LNuvsRzu0v2+fWjjq4lUJOtae9mBQL3meO0KxHLBeIdgOsaOZv6S4weJF2265
X-Gm-Gg: AR+sD12/u4B/tWt+3qleu5R+m8Ybf6xkkZLhETL+ntVXMf7IIN9xRras8u1GnpBJ2W0
	LX/vq+uOgZjRoTJNXaeEj+g+n2Zeis5h7pwlbLsIpWq9IP5l8Ko2cZvGkayDmDCZSrZcUVtoV3A
	h2pkyIJOFygCNzjTUc4fbsBOe3P7MONlD3Q58qJslcdbT3hu8rBc0+ILwig+vBUPuRq8ruxPK/v
	lzHX8qbVZg8FTLSPlb1sNfYCQIZjVvqotaJHXNh3ADbW/YUbQecw9IsSGgriPso67ny9qJ7aWoX
	mxJAbz678CNeVDyUZ7ujxqh/n8OgyV+/KMUSDYbH/8FeOjizmF0/qzKzQeAmJF5rMWwqvLeLSXX
	Jo/a16H8dcUIHqgCwzomkQLXQ1umctOHgKg7ag6baRRm7S+GuCm6uRi4sxSFsNjEZ5MIM4WIswY
	Q9Y7whxbJdg82z+0RudUfRCkqzn0kD6P5StzNJWL7yiyu2CvCRFKBG2rBODzTuM+i4inx82Y7I1
	2Jnu3vqt6zDzdsNdj5XItuM0844JPk1cBYiDEreVnYHs4DW/CulDaEvwUIdd87Dd5YQYzrBHIna
	NL6m9gPFVDd7Zce70pKiGLfjdNxMn6yRPetDPLXgpOWvID6YxJcIgqGQRCJyTw5+
X-Received: by 2002:a17:907:e008:10b0:c20:2165:d74f with SMTP id a640c23a62f3a-c250c2e53f5mr544467866b.22.1787833809642;
        Thu, 27 Aug 2026 05:30:09 -0700 (PDT)
Received: from fedora.internal.pxprod (77-162-219-136.fixed.kpn.net. [77.162.219.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88a928sm785380466b.33.2026.08.27.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:30:08 -0700 (PDT)
From: Bruno Xavier <bfxavier@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	lorenzo@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	bpf@vger.kernel.org,
	Bruno Xavier <bfxavier@gmail.com>
Subject: [PATCH] net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
Date: Thu, 27 Aug 2026 14:29:17 +0200
Message-ID: <20260827122926.31123-1-bfxavier@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_pp_cow_data() takes two kinds of memory from the same page_pool. The
head buffer goes to napi_build_skb() and becomes skb->head, so
skb_shinfo() lands at skb->head + skb->end and has to be aligned. The
payload fragments in the loop below are plain data, and they are requested
with the raw remaining packet length.

page_pool_alloc_frag_netmem() advances pool->frag_offset by

	ALIGN(size, dma_get_cache_alignment())

and dma_get_cache_alignment() returns 1 wherever ARCH_HAS_DMA_MINALIGN is
undefined, x86 included. An unaligned fragment request therefore leaves
pool->frag_offset unaligned, and every later head allocation from that
pool comes back unaligned. skb->head is then misaligned and
refcount_inc(&skb_shinfo(skb)->dataref) in skb_clone() is an unaligned
lock incl. Where that 4-byte access crosses a cache line it is a split
lock, and on a CPU with split lock detection the kernel dies in softirq:

  Kernel panic - not syncing: Fatal exception in interrupt
  RIP: 0010:skb_clone+0x159/0x1e0

This hit four times in three days on a Core Ultra 7 258V running a generic
XDP program on lo with a raw IPv4 socket open, so raw_v4_input() cloned
every matching skb. Observed skb->head misalignments were 5, 6, 10, 11 and
13 bytes. Without split lock detection the unaligned atomic just runs, a
few microseconds each time, and nothing is logged.

Align the fragment request so the pool's fragment offset stays usable for
the head allocations this function also makes.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Bruno Xavier <bfxavier@gmail.com>
---

Notes:
    Tested on a Core Ultra 7 258V, Fedora 44 userspace, with netbird attaching a
    generic XDP program to lo and holding a raw IPv4 socket, so raw_v4_input()
    clones matching skbs. A bpftrace kprobe on napi_build_skb() and
    __build_skb_around() counting misaligned data pointers, plus a kprobe on
    skb_pp_cow_data() as a positive control:
    
      unpatched 7.1.9, 7m22s : 16884 calls, 72 misaligned builds, 10 misaligned clones
      patched   7.2.0, 7m    : 30479 calls,  0 misaligned builds,  0 misaligned clones
    
    Misalignments seen before the patch were 1, 2, 3, 5, 6, 9, 10, 11, 12 and 14
    bytes, so not even 2-byte alignment held. A kretprobe on
    page_pool_alloc_frag_netmem() watching pool->frag_offset independently showed
    zero misaligned offsets after the patch.
    
    The alternative is to have the page_pool frag allocator guarantee a minimum
    alignment itself:
    
    	-	size = ALIGN(size, dma_get_cache_alignment());
    	+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
    	+				 __alignof__(long)));
    
    That covers every caller of page_pool_dev_alloc*() instead of just this one,
    but it changes a generic allocator and would carry a 2021 Fixes tag, so I kept
    the fix in the caller. Happy to send that version instead if you prefer it.

 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cbbd60455abb..7f8953b48026 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -985,7 +985,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		u32 page_off;
 
 		size = min_t(u32, len, PAGE_SIZE);
-		truesize = size;
+		truesize = ALIGN(size, sizeof(long));
 
 		page = page_pool_dev_alloc(pool, &page_off, &truesize);
 		if (!page) {
-- 
2.55.0

