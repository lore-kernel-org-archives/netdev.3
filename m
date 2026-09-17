Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81148E0FC
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647197; cv=none; b=bT9B6IfJQbyFfsYy0cXXaNy+RnPSI4K/AY4PzIj4MsJWCR+f1uoKr4LXiFwlRICzfiN2kVWBgHHeM2gZGSg+PN8PoDmy/wequRJ8BGUO40Lw6Eyw9qgeXYmrzatxxolZMzpychyIZahjHMkLebkjP1RErdtQhkFjUpaN5/zU0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647197; c=relaxed/simple;
	bh=MeFrqAQYQIVbUicP9V8M34hZDEv+igpvOZgFQMA9wWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvum7ONN35qQYDnILAJgjuSDPr1jWmULJksFffS2LhCUcNiraYk0PtMkBCt/OJzO1zLxyQtF0rAeGcAWS5D3WZLk1iPWQ9vh0P93Ci/gK/cJLi6PUORNruJ5sakWIyxyONAVrXtgUt8rsk0h53irJVnyzzGU7J9zNUvkvvxel/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hldM+NdY; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hldM+NdY"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so388008f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647189; x=1790251989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GuXqc4H5dE+MDL7nEDkrFd3PYvzEZhNj1KGCmYesUCs=;
        b=hldM+NdYBLI0o/EhICZGfzfijLBESqtB0wOlWYxnuDGTxVPwmkBpTpCXZp3zsCAlbW
         TDl/9Dg4ZyVn5bZVMtxx9n1d7HG7hy5GeAiOe/fW6uLcoYfWCFIZeMVFKf9TGsOFJQnP
         0GKfBaigFnwqg3Opb1o5YAwoaKbydsPniUJ6syVn8mvLFRG3kSPJbMh6rN//zrSHApMr
         ltf0qWQ+XWsy3QphoThzBnvKcLLNkutwOwNgYjUldXa5TprYYkXK3EcOwm0eibcUgjMZ
         iu1E2OObvcKj3K7VshB+Rof3+j/ATQQldBBPUi+KLOZEyZdusLK05qxZ2zg+P2uMl8/2
         3OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647189; x=1790251989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuXqc4H5dE+MDL7nEDkrFd3PYvzEZhNj1KGCmYesUCs=;
        b=yFVfcDBytmyFZo9a6ygF5xVzCaTO/U7CsqUAPFnTegoRZphhyUDl+rzP25l1gT1iLI
         4ocJoVOe8/wVsBYeSUv2e57Nf28n4QWBxoB+JCwd7xPwQrd/VRW8tFOQYn9myGno94KT
         rBJuMpjTWvw+J8vxdr2AsEBSoFpF3hWbAAqxyvPDMeSQwO34XhqdulMc2tsDZ3N390YO
         /AIjzQdkVnCJIZyHKri418pxy1puRKpIFxQSXJXSpGLfqcLjjVTo6Zd6VHBY/d8WKq2R
         Nl07mT9vp85Plzfdo2373UNa35ipNSRAxLxaJhSDBEXVONpUBr0OyEV0PhWTVRvwi1KE
         7NDA==
X-Forwarded-Encrypted: i=1; AKwUvBybLzeTna3lPpcNal+unrDWC1pIYWD78vcgEu0O4dxAV/8lAILdZtFkMO08cxgVFqxbakW3o1U=@vger.kernel.org
X-Gm-Message-State: AFuF++l3gf79tYtcK57TrOQoejnIlPbKD2TuetRTkRIUh6bxFYQoeKDB
	KFIq7IMlgn160qSkOG5zlj0xeW3sNtVSHU/Sp6ZGCLOjE2gg1IhbQ9he
X-Gm-Gg: AYBFou1DlAwvwXYwCE2Z/2DgcwLwoXo+PUpkC2L5vv/y5JbhIZTwu3JiiwD1Gi+Z9+Y
	o9EVjJ0lKz+Nic5LiEYS47gZVVWZExU/ol3VbwTGkJ+xBUX2wgL/PM+0uVG+tL+k+wQmt3rlauJ
	cJBQAgaOSypZjCkrEISWv4SBzetXNNqaXuz2JXkRoy3ypB9xxvOj5sGMaXpx0cXSsvn1/8DhAAD
	FDWILaJMreuMbtQjQ6JQAbvMhTJTe0qsc5xQyx3CLg1mG8G7n6CxjdWJnY2Ru7MvdoKVJ/VVphU
	E8nKv+ZMg4lNG9D2KSFaTXfzeZTCqSZiqoKW2sD7ibYIBDvha/DwNcGDcg7lFve6yFVPLCXzbfo
	6eWqZPmOYBTjiqKWcMhW4urh/gfGx5jsN4Ecb9O8sAT4dBkhv6lVOlZk9oKIe1R64RdJnClKIv9
	VPbnteUEJtwZdb5eUYAmLZStsT157sKkQpaEaCIxz5zLWH7gwbFxDq+esamdgl5IjQ7zOAQ9Oo6
	POGvKQd3U5a+XqN2g55ozBpdLkAB/fa+Obsj5t1
X-Received: by 2002:a05:600c:1986:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49eb732e404mr79422515e9.27.1789647188967;
        Thu, 17 Sep 2026 05:13:08 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd204c1asm70146675e9.4.2026.09.17.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:13:08 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net] net: axienet: restart the TX queue after a DMA error reset
Date: Thu, 17 Sep 2026 15:13:06 +0300
Message-ID: <20260917121306.23499-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_err_handler() resets the DMA engine, frees every TX
descriptor and sets lp->tx_bd_ci and lp->tx_bd_tail back to 0, but it
never restarts the transmit queue.

If the queue was stopped by axienet_start_xmit() because the ring was
full - __QUEUE_STATE_DRV_XOFF - it stays stopped.  The only
queue-state clearing the handler does is netdev_reset_queue(), which
touches __QUEUE_STATE_STACK_XOFF and does nothing at all when
CONFIG_BQL is disabled.  The remaining wake in axienet_tx_poll() is
reached only when axienet_free_tx_chain() returns a non-zero packet
count, which cannot happen after the handler has cleared the status
word of every descriptor, and the wake in axienet_start_xmit() cannot
run while the queue is stopped.

The transmit timestamp is not refreshed either, so on a kernel with a
TX timeout handler the watchdog condition stays true and the reset can
be retried indefinitely.  axienet_device_reset(), the driver's other
reset path, already calls netif_trans_update() for this reason.

Wake the queue and refresh the timestamp at the end of the handler.
The descriptor ring has just been reinitialised at that point, so it is
ready to accept transmits.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Compile-tested only; the board I found this on is not available to me
for about a month.  The BQL/STACK_XOFF case was exercised on hardware on
2026-08-26 and did recover, which is why the gap went unnoticed - see the
discussion on the TX timeout patch.  The DRV_XOFF case is reasoned from
the code, not measured.

axienet_dma_err_handler() also tears down the TX ring without excluding
axienet_start_xmit().  That is a separate pre-existing problem and needs
a separate patch; I would rather send it once I can test it.
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..b6440c06f260 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2778,6 +2778,15 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	napi_enable(&lp->napi_rx);
 	napi_enable(&lp->napi_tx);
 	axienet_setoptions(ndev, lp->options);
+
+	/* The ring is empty again, so let the stack transmit.  The queue may
+	 * have been stopped by axienet_start_xmit(); netdev_reset_queue()
+	 * above clears only __QUEUE_STATE_STACK_XOFF, and nothing at all
+	 * without CONFIG_BQL.  Refresh the transmit timestamp first, or the
+	 * watchdog fires again on the next tick.
+	 */
+	netif_trans_update(ndev);
+	netif_wake_queue(ndev);
 }
 
 /**
-- 
2.47.0

