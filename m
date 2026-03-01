Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F328725B;
	Sun,  1 Mar 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328494; cv=none; b=DXPdjLlhxW96noIaO2b4kvtwav1lk8oo3SpOX4Xx7EXRiSttFeE0gFKgOctqKurRcUB6+1QIeNE7gqdzmWX3lcICiXjk9PAoQd6asxm/HLiV/DpkfFK/B7YJ3xg5yQCI8SP+hxJIJ9xR6uGMb+bGYri/I1UiivwFWMWMIeWUE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328494; c=relaxed/simple;
	bh=caGLC4eiAMQuTnRrjh2L4wlwOWWY1jUeLUW3d4w/g0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feNWgHFCimEGfAsN5q8B7HRvR+GyWBVwoRqpWQ2DUbhLbqukVMmQvJyyWCC+j4h3jX1qm0P5h551MycEWB6elPtl/0N+6/6StyXuGNk9b0zzPwjogtgF8v2zrJyOrMwnb5mJd9H2lDQ5iVBi7iHIDJhIEnyFAhoGkg9BykT9CB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Vo+ttC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Vo+ttC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE031C19424;
	Sun,  1 Mar 2026 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328494;
	bh=caGLC4eiAMQuTnRrjh2L4wlwOWWY1jUeLUW3d4w/g0c=;
	h=From:To:Cc:Subject:Date:From;
	b=i8Vo+ttCsB09oz4w2xuwNtQViEoT+KhsJ/C5HycLyVfqP2jkEXs7Ru4/q5+Q5RRUR
	 OdwSaPXO523RMSljTiHwt/KjHw6jYv69KvVni9pm1o1aSxknD9gpLeIxPpdVAzSGJf
	 +VAU+N+zhoPd1P3l8wBkjmkTIFOpyI0z0JHODSEdG1ynla4xFlMgS2q40eSqB7OxUH
	 xYtQe9minaICWyUqSi0d+yd7Bkyw8Tu44cSdL3+UoHRD54UQaCa4DMR8WhBJCTjn7v
	 cB4sMo3e4srkld38A3wnE7pO6v+J4iPgW5YYSjGtnus4ZBsAcSp8rAx3iR+CDhUysV
	 T9w3EX3KOkLPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:12 -0500
Message-ID: <20260301012812.1685923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36bd7d5deef936c4e1e3cd341598140e5c14c1d3 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 6 Feb 2026 09:53:33 +0100
Subject: [PATCH] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260206085334.21195-2-fourier.thomas@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a56127..dff84731343cc 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.51.0




