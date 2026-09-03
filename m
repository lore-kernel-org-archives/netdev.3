Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0384B0C97
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463184; cv=none; b=kg6WcYRVnKgry/T+5M53p3Cy2k8GkYNkJ/omnz0cfgtfzkWv3eQ7c3I0k1EvQb9ngOqnnxlG1gQ1qVuv+MUS01CwOTAeJHyZ+zTUAGwAgpZ3qYUmqm3oUPeoeHteEYXi/Y3CyTogkb+8ej4Yz5H233lZ/v0/yYwUgRT+NajfBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463184; c=relaxed/simple;
	bh=odNLQr0msLnpOLBpsC9aN81tjcKocFxzYThQR/kGCv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cTQYk5T6Y/+x0s+bnntyX2nqNG8gVY68EOlc41DCzDBjZb6W2BO7WU7mEkDSwtOl6VbJpI3VJgQJIZEl+0IND/DI2SM9oe/twEC81LmfzA4oH83/5XrfKpTF0eXUhJLszLsrCh0LsVGj7Vtlqng37bQANYY2qjV3Z+Ae3Ruffoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N49pLemC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N49pLemC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so2378885e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463171; x=1789067971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URcjcfxinzhAhjtlslyOZMEDSbVWe9BdaBDhgAMd9ws=;
        b=N49pLemCJOWDCSEnDZ5wV3zYXHBlrTsM47v7wF/r3l8tjitGUWy0YQaEuLgkBO53nm
         3ItG1PWe56n2YM1UXUcpYbe2k0YuuAXmkXr5ME8gsolwGmlutW+kZxXzLiSumU8PbWOk
         I5w/2c8p5D0vYiiQu3xVSWTXqrvE9hKKnQMlLCXdJmuW6lxvTXCQ8wAlKlhXHhR+kb0I
         inBTafHGhVowAdYRzCACcdWJcskZOHs0gSKKyjKn27rDISpVQY8pLG6yGBv80Vam2cFF
         H2elI77+An3onTUAO246bxIloi6CGdhl8kMga/KFWSI4MfKc2e7dCEie7iIFPRD4he0w
         6AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463171; x=1789067971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=URcjcfxinzhAhjtlslyOZMEDSbVWe9BdaBDhgAMd9ws=;
        b=QdN2S4/0wgcQ+GRLFAHmIW02RggSUNKhFM4ZR9M17NqaGyeMmVrhTCDty+lgqCy1H+
         nktn7KwC6QSCZ6vC7kTTskj89jo1Alf5OteXCMPJXYqvNxVRNCrZl6mZ12XI2WVD0RZO
         +TtCjKUTlhdLuQBnj54ejvDqKlW5wPQ/Ahm7bjJ8A5YHyIaw/uhBBgopKQPXQKa8XbeU
         jOPncIEG+e1VSf3Wm1zsY3IK8T66gucdR9Y/tx0WRFxxNCXtGT9MN7BqDq2LGyxikV5x
         +NQHcmiONDjkMJLs5D1L+3VgLH1waH4AaViPBAhRdV114/lafD1FNb6Y7ZVSqYVnTtan
         Hk6A==
X-Forwarded-Encrypted: i=1; AKwUvBzQjZ3RSui0+XoMd1yyizpE+Y3QJT2NoI9O5SruywmFyXtZX07oyLteGQYphysjKbiywTsZHSI=@vger.kernel.org
X-Gm-Message-State: AFuF++nD4404i4cxkfJFfYBufEAABCe5k4bu4Q7Z4H64FWSlDQFTiaQT
	fJTUk7X5XaJYfyuL5T5L8Rg7QvM+H27J0bnjRgDGC7z5SD/0X+jLDwcnsyESj0kp
X-Gm-Gg: AYBFou3PjFhMlxNu/sJCRD6YNFPyLvqq9Gn1kbemJFh7dXuHBc2tmn3bdxTwpwb1lfB
	y4xXx05lEPZ4yRMMDCQBgGr1ZN1prWEiOGZRvYIdebWEXCPuzFhHq/fF41KfJNWWakv8kCu5pab
	m8JcqyzaGZXXK0gpnYrcfAA8XkZfysnaB+X9OTYNqlmkAaQBsqzHJg4jUIonvA3QhIOky58VkZr
	qzK+KoSsX5ZpZL0AokWpHPSYeg1UgBNChYI8RJOSwaJU5KY+VkYtQsK8yOJqmqUtsy81gFhYvKt
	/VhyfuEpbchjiTYtrPakjXeYfV+AxowFOXAxJPsIMnVfQsFAxBWuB+L9O4jewLAgZncHhkzCEqb
	/1Gok9eLLI5DQHmgdAQERScJNOOnmA9nfzmJilYEphxzdimD5rw0kEPkx3ReLc8OFx/54GPs+lf
	PAM72N2msN4oysu4qMQXK8i1MMj/AhPlz9d1A1RJuJEgEHz5Nc/6RHJpym3qKs3VHNlxTO19f1H
	eDjQBpFUQc4Cc8U9McHeoVcYyagcaQRxXMVepKKA9aAml+IOo8JDoA80pSyRHk1S6eF8MKpeihR
	cnpdu9UkTgxams0xhU0=
X-Received: by 2002:a05:600d:6501:10b0:49c:f2f4:edca with SMTP id 5b1f17b1804b1-49cf825c891mr2074175e9.15.1788463171272;
        Thu, 03 Sep 2026 12:19:31 -0700 (PDT)
Received: from mvcarch-fp.net.fpirim.me ([178.251.46.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm33888115e9.2.2026.09.03.12.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:19:30 -0700 (PDT)
From: Fikret Pirim <fpirim@gmail.com>
To: fpirim@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net] page_pool: keep fragments cache-line aligned
Date: Thu,  3 Sep 2026 22:17:44 +0300
Message-ID: <20260903191744.3260893-1-fpirim@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_alloc_frag_netmem() rounds the requested fragment size up to
dma_get_cache_alignment(), which is 1 on architectures that do not define
ARCH_DMA_MINALIGN -- x86 among them, where the helper falls through to
"return 1" (include/linux/dma-mapping.h, include/linux/cache.h).

Two callers on the shared per-CPU system page_pool ask for arbitrary byte
lengths.  skb_pp_cow_data() in its fragment loop:

	size = min_t(u32, len, PAGE_SIZE);
	truesize = size;
	page = page_pool_dev_alloc(pool, &page_off, &truesize);

and xdp_copy_frags_from_zc() likewise (u32 truesize = len).  Once such a
fragment is handed out, pool->frag_offset sits at an arbitrary byte offset,
and the next page_pool_alloc_va() from the same pool returns a misaligned
buffer.  Both callers turn that buffer into an skb with napi_build_skb(),
and __build_skb_around() stores it verbatim:

	skb->head = data;
	skb_set_end_offset(skb, size);

so skb_shinfo(skb) == skb->head + skb->end inherits the misalignment.
atomic_set(&shinfo->dataref, 1) is a plain store and stays silent, but the
first skb_clone() does atomic_inc() on it.  dataref sits at offset 32 in
struct skb_shared_info, so whenever (head + end) % 64 lands in 61..63 the
locked dword straddles a cache line and x86 raises #AC.  On a kernel with
split-lock detection fatal for kernel code that is a panic:

	Oops: Split lock detected
	RIP: 0010:skb_clone+0x159/0x1e0
	 raw_local_deliver+0x1dd/0x290		/* or __udp4_lib_rcv+0x703 */
	 ip_protocol_deliver_rcu+0x51/0x1a0
	 ip_local_deliver_finish+0x85/0x100
	 __netif_receive_skb_one_core+0x85/0xa0
	 process_backlog+0x98/0x150
	 ...
	 __local_bh_enable_ip+0x62/0x70
	 __dev_queue_xmit+0x3cf/0x11a0
	 udp_sendmsg+0xb79/0xfe0

I hit this three times on an i9-13900K, on 6.18.48 and on 7.1.11, while a
generic-mode XDP program with frags support was attached to lo by a NetBird
VPN agent.  Locally generated traffic on lo always has headroom <
XDP_PACKET_HEADROOM, so netif_skb_check_for_xdp() -> skb_cow_data_for_xdp()
-> skb_pp_cow_data() runs for every packet, and any nonlinear one poisons
the pool for the packets that follow.  The three dumps agree with the
arithmetic: skb_shinfo % 64 was 30, 29 and 30, putting the 4-byte dataref
at 62..65, 61..64 and 62..65.  Cloning came from multicast fan-out and from
raw sockets.  On the same machine, with no special load, a read-only
bpftrace kretprobe on __napi_build_skb() counted 40 misaligned heads in 85
seconds against 2033 aligned ones.

Where split-lock detection is not available the misplaced dataref corrupts
whatever it lands on instead; I suspect this is also behind the syzbot
report "KASAN: use-after-free Read in skb_clone" (31 Aug 2026,
extid=22c4f9a7026c86bcc3b8), where the head is freed early.

Round fragments up to at least SMP_CACHE_BYTES.  Architectures with
ARCH_DMA_MINALIGN already get this or stricter rounding from the same line,
so this only restores on x86 the alignment that page_pool_alloc_va() users
implicitly rely on.

Fixes: FIXME_HASH ("page_pool: introduce page_pool_alloc() API")
Signed-off-by: Fikret Pirim <fpirim@gmail.com>
---
Tested on 6.18.48 in an 8 vCPU VM: an XDP_PASS program declared
SEC("xdp.frags") attached to lo in generic mode, 8000-byte UDP datagrams
streamed over lo to drive the fragment loop, and 86-byte multicast to eight
listeners to clone the next skb.  Misalignment is visible without
split-lock hardware by adding

	WARN(!IS_ALIGNED((unsigned long)data, 8), "unaligned head %px frag_size %u\n", ...)

at the top of __build_skb_around() and booting with panic_on_warn=1:

	RIP: 0010:__build_skb_around+0x28c/0x370
	R12: ffff88812a58bba6			/* head, 38 mod 64 */
	R13: 000000000000045a			/* frag_size */
	 __napi_build_skb+0x39/0x50
	 skb_pp_cow_data+0x233/0xfc0
	 do_xdp_generic+0x377/0xd90
	 __netif_receive_skb_core.constprop.0+0x533/0x3f10
	 __netif_receive_skb_one_core+0xe5/0x520
	 process_backlog+0x196/0x5a0
	 __napi_poll+0xb2/0x450
	 net_rx_action+0x418/0xdc0
	 handle_softirqs+0x19e/0x4b0
	 </IRQ>
	 __local_bh_enable_ip+0x62/0x70
	 __dev_queue_xmit+0xcaf/0x3510
	 ip_finish_output2+0x990/0x1f20
	 udp_send_skb+0x60f/0x1310
	 udp_sendmsg+0x1586/0x2230

  unpatched                            trap after ~25 s (twice)
  this patch                           375 s clean, 97 M + 146 M deliveries
  align the caller instead             378 s clean, 91 M + 138 M deliveries
  unpatched, XDP program without frags 272 s clean (pskb_expand_head path)
  unpatched, no XDP program            200 s clean

I also have the caller-side alternative that rounds up the length
skb_pp_cow_data() asks for; I went with this one because
xdp_copy_frags_from_zc() has the same pattern and any future
page_pool_alloc_va() user would share the exposure.  Happy to send that
version instead if you prefer to leave page_pool's rounding alone.  Either
way a DEBUG_NET_WARN_ON_ONCE() on the head alignment in
__build_skb_around() would have caught this immediately.

 net/core/page_pool.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1061,7 +1061,16 @@
 	if (WARN_ON(size > max_size))
 		return 0;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	/* Keep fragments cache-line aligned. dma_get_cache_alignment() is 1 on
+	 * architectures without ARCH_DMA_MINALIGN (x86 among them), and callers
+	 * such as skb_pp_cow_data() and xdp_copy_frags_from_zc() request
+	 * arbitrary byte lengths; an odd-sized fragment would leave frag_offset
+	 * misaligned and the next page_pool_alloc_va() buffer would be built into
+	 * an skb whose skb_shared_info is misaligned (split-lock #AC in the first
+	 * skb_clone() on x86, refcount corruption elsewhere).
+	 */
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 SMP_CACHE_BYTES));
 	*offset = pool->frag_offset;
 
 	if (netmem && *offset + size > max_size) {
