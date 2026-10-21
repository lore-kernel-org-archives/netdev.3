Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598179;
	b=SbYGrcsw9dKODgRqUyKE0EQjERD3rt4yh945OOYoYNYLFg0TddHsoEk99VsTjSnLINFj
	 XSySJtMDL8xzqF04c5RXeq/K2MztuRHAwREANcexW22rmyRf6dvTH67bsk/759hma0E5y
	 4Yt1w+gDuFLVUDybos3KCQD95rKHF6Wac/M8g672HKC7jyPOAYUc3crJKX8V4AvOFpC9T
	 9OealT4RdkoGXcnnAnqK5r5NXeU2/GmWbdUm84AplTaE5VWOIhSJ56xBUPEvIICB6ydaf
	 ql8pEcEv3f9zVicZ9Av1mxoE326bgFoKSK70mC+YTUojZjXhYlf1JLN7Vhf4ZtBadTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xUhPV66fOhEACkkpf7HDlHvC6TlZrGc05mb83FyTwjY=;
	b=pv5rZZ1X9BfXxQNV80VqH15LlDLSMUReYccQUvM+qZYQxc5WwtdHz/Svvtmi0XTjVfWE
	 SHtVvZDSZp25vn+1JtDsbjtDWaNbd9HRvIbPj1E/jVQCy/UiaJrCIrgdviME8j7I2Mqv0
	 cY04AVkryoCn6FCY4KWe/O+17rR/q3xa/PGq87eUX++RQG+hWM4xAqBuOspoqdiiAKSKV
	 e2NVxRgnT25FRAwvw18vyZIsWoHN19kZDPrD6/7cMUq9DG9B95BnLRTUJ8j4bGTUwo97c
	 CNHpRgaUfNvPwLIYdTUD5gnt+zi8HHrCuAQt+TqFlYve8RLFxcuQLhECnDqTOXzdAFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dRAxB8G2;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C908606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C908606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dRAxB8G2
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea138a3497so5556555ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598179; x=1793202979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUhPV66fOhEACkkpf7HDlHvC6TlZrGc05mb83FyTwjY=;
        b=dRAxB8G27mGeptdGRV4myYB5tleb9EZlXbZP3IZWYQz6fUbZnPok4pFiqJmqQSd/lX
         RTIqOdiaIuSWKhILJlW3EyfBB2O3j3BQR1194ksCycajlbt+DFWzOO0mqSOHuExjsJS1
         LasLi9FUO7GiolXSN6sinMA/A9GeOzHNb+lZ2nfQOWlJDsx7goNT5B137PiTsER3nOSy
         cmpSV8iQVM49WIP112jpmOUOUGJcczv46cCfPiZE6RbG3zIo0pAshB4GMykjXBdcEGtC
         oeCp22RwpltmgTwiK/b3cRdBjEY0hASkmOMphJzVU7mMFJm/eicxDr+48IuRwJTHhr5p
         U24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598179; x=1793202979;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xUhPV66fOhEACkkpf7HDlHvC6TlZrGc05mb83FyTwjY=;
        b=C+7BUimB09F8+MBUfRNbKhTcWFRPnDuWgNxQOcuGdJYaEwekCitwQjjqZYrViBCpkt
         yo1h/HFZ+dMotvNTQSehPKV2kiMBiCOrCwKd48a2f5YSDGx7I9wuTdvR6xE5SjtbMp/F
         GIkJtFaidF+ooFPDJtt8YwqTBjmJVTQzS2Ar3BlwibrM152Xro8XthrY61uwmQcySyUh
         hRA1rpC4Oyvlsroi18QALglfRgmrYFVGh651KYIqxAq/Xug3IQI7CWA7hPExNaTw+6ml
         bLPa2kCDWJALGo24KDL4jVM5mkPSt6Hcwb97LBH+7cA90L78wZDPWX5DsIo5c0NjVoFV
         LePw==
X-Gm-Message-State: AFq9FYIMCFVGmZBPMiizcMfC1y+aSljwGrqnLw6tArdsMimk1YZmlkPV
	YdNUVu6/c4DD56VLb9Gzu/AGmY3jkkJLhYTZM0R1uZfLpliS8Pu6vvEM
X-Gm-Gg: AYBFou2dEzXNo7cQTmD0gzf9F1+Xt22/OrQ3Np98RCpTMDvdJDGlgGAf/l99sbaU8ws
	egRfnUkCwWEqgLkWoheaQ+xxOUjl4WYMaJ3J2EqlIek7Z02QFwGu3GvXv7f8q2aBg/Y8iKQDuHe
	nax0JI6e2N+uAwovuuzPBsq0GuO6KqNes5Ut2SS27pRgO4VG+Bj+sE83pJNiL+mLqHKX5ZAlqqW
	AImnv8I1iuyldm9orBGSN32X5+pm13w7wi/iTfepTkwMtjuCctxdWkyHFdY8up4SJw7U6A9e0fo
	KG+MR20Ha+cOGvPoy9bH5FQlO5yyrKDFEYnHaghRH/Cj+NLBjZjtimxwxVgfL8m+fUCC+PdgkvE
	O5XRRZxLe5a+73yfx80nP1nku181xXH/AyZVPRaOQ9gqQeK02L+pTsdCrjtUuQNSdY958Khfvy5
	Yw4Q7Qqdf4YAMgYNkUTZe9U3TpCB/WSi1wITl+uILuREDoC4pio24o/pqLP4b1MH1Wi1NxsUFIl
	cSXK2/fj3M0KfZIvrmvEGYxsmTqn51/EsYUz/dq1zgddjQcF8QM9iU5DAEIsDJEd4UHWH57KcWS
	6MVQYGguMVuvvptrn4V9jD2NdE5bDg==
X-Received: by 2002:a17:902:fc4d:b0:2e8:79d:15ec with SMTP id d9443c01a7336-2ea437b4a74mr21629945ad.6.1792598178635;
        Wed, 21 Oct 2026 08:56:18 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea5a15517asm2885015ad.41.2026.10.21.08.56.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:18 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: hawk@kernel.org,
	ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: page_pool: bound queue_idx before indexing dev->_rx[]
Date: Wed, 21 Oct 2026 23:56:11 +0800
Message-Id: <20261021155611.68473-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

page_pool_init() calls __netif_get_rx_queue(pool->slow.netdev,
pool->slow.queue_idx), which is a bare `dev->_rx + rxq` with no bound,
and then dereferences the result (rxq->mp_params.mp_priv / .mp_ops).  A
queue_idx at or beyond real_num_rx_queues reads past the dev->_rx[]
allocation:

  BUG: KASAN: slab-out-of-bounds in page_pool_create_percpu+0xa74/0xafc
  Read of size 8 at addr ffff000006587eb8 by task kworker/0:1/11
   page_pool_create_percpu+0xa74/0xafc
   page_pool_create+0x14/0x20
   ppidx_work+0x2d8/0x34c [ppidx_probe]

queue_idx comes from the driver's page_pool_params, so validate it
against the device before using it to index the queue array.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN); it
fires at the claimed sink.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
queue_idx is supplied by the driver alongside PP_FLAG_ALLOW_UNREADABLE_NETMEM
(the gve, bnxt, bnge, fbnic and mlx5 rx paths all set both); it is the
driver's own rx queue index, so an in-tree driver passes a valid value.
page_pool_init() still indexes dev->_rx[] with it while only asserting that
the netdev lock is held, never checking it against real_num_rx_queues, so
the exported API trusts the caller for the bound.  This is a sink-side
hardening fix for page_pool_create_percpu(); the QEMU guest used for the
reproducer has no such NIC, so the pool was created through a small module.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/page_pool.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e5..87f14ae855e3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -274,6 +274,15 @@ static int page_pool_init(struct page_pool *pool,
 
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		netdev_assert_locked(pool->slow.netdev);
+
+		/* queue_idx indexes dev->_rx[]; reject a value the device
+		 * cannot serve before dereferencing the queue.
+		 */
+		if (pool->slow.queue_idx >= pool->slow.netdev->real_num_rx_queues) {
+			err = -EINVAL;
+			goto free_ptr_ring;
+		}
+
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
