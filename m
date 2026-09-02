Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E24AF689
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388339; cv=none; b=X8iX38uuD+ew5BpPMiHX4J/Bzjap6QRDa/kmy063GdrqzOOmm6uKOI3l63dqC1wJM3sXyZld+Z10hGySYZh77a8CIobBbX3rB9/IHI1xaedEhVjZE8kwy2WyHmhSeoIucmX7JCAV9vFy5Yc0481ln9NnLxE+wWd/rIjGK+N9TiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388339; c=relaxed/simple;
	bh=Zm0XcOpJWUytUZY7b6SexkzW4HCxLFo8LRKtAFhDsts=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj94BwBIJ7UnDPwkxzC1pd6xCE3hsbRprkmOuCltzscCY9q2eFUEnVEtnWlcyenPiLW9rxD1kohaMvajhk1FzQrInzK7styN+hpZRSl2DAz9ii9k4KIMdg29J7yhwUFqGOyWdTpw0zjWJguGtQv8lTaSxELy+shOBz8696BaHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YemGL4AH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YemGL4AH"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1324767a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388327; x=1788993127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IMpR8RuJeYxEvmW0AT9REYMUCOwZcKYr/F3t3kyqMpM=;
        b=YemGL4AHWNW0G0Kc8YOrZg0k0CnJUuU9LZt9ZG3YU5xbTw8dzb8eHYbsF7Fp6dTF91
         P/5iK5yL92P9k3prMRkoucnUDIonUUM69bA46KMIAAN3WCaqGxF84rRQrK9SD4oXelsf
         y5+dAW8INLmZopnDggVVd1T3QvVBGz/Jrlhb/MN5bcB34kvCCiFV2UFe1eWS2hP0WlH+
         fyexQQjkP+pOEmNy48WXKp4nyCSjx7ILUTQFg5KLu5aRyVE+lhYH06KFaIy/q4Lrt9En
         z36/EuYuR6MfHWlxJ5KFsSGLWVPYt0y0Ad+cKjQPnMfg/pmo48jEEitgPqwkEuLp/2Un
         J/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388327; x=1788993127;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMpR8RuJeYxEvmW0AT9REYMUCOwZcKYr/F3t3kyqMpM=;
        b=l65JKCg1kHGOvIIol3pCu1HAdTEMqFX3twWKL0IniWcrjJXp7db4j0dfQiYiQ7icoA
         +JK5++j8Hc1bkMRd7SFYY7XKyx0O+xuXSEw3EDjP3eJUZ67nzVeQbJbcBfGHVZK7XXSd
         ByefFPrLSX7mD10NDiYVaqfrpwmRxinzwDJ4ckCRVIMeXY6GIVu7T/wxiQZqMUM5pwYJ
         Fp3zazdCcZXBIAune/WxLXcZM3S6aSTtWOeUsRdE+ZkeZC6J6bJxSMal0P5ULj1tmD2n
         vJjGMHhhFihlkIZL3quRTB5AzQ9wrCWQeSUlVAGNSJvkAkkO5eaeanTDloIjcqhBJ9ta
         c1wA==
X-Gm-Message-State: AFuF++nYIigcnBGsj1Xvr18bqqdSt2B4clRQp1mEYUgqpRCZ42eH5hNN
	iJcAqHQb91LTUrXThX6aqtvx4jNmmvt3pGi8CysovfDYxMiR+ImRAD+B
X-Gm-Gg: AYBFou2UxMACVQo5RSAjDYvJFUJgoq2LrXSWsrlqoCEcsQW+QmL6V5TvWPsXAQIU6Mt
	KGB6BRYBrociRgo6MU4gcOgLEYajHgKfqpaLUUw0l3fswUFvWp6DMKv5ZQiGXDsWDCNPp0bBGX5
	7KnhJ4+ORasJUNqhrAPRjT2bS7uf8UHZZVpA/uONE4QCfS7teItaKSxcDnR8fkMPCwiOLRooQe1
	3lUZccXl+cKRQrUpwQKTjPq/s9nRVMFJ7oR4ZF2YvPly31v4v1IZacgMLgL+kaeYH/HSQMDtm5t
	xvpCrU6ADRoVLLkv1A55365OvHT2AT5ttOGx0VWfdpdO/YJg2FyKZ4r3fKR9B8RQnHiQOq0k7Wm
	J5TwSrSMC8uWwh6FoSmeUqU1RW3uJjxqSiGIr30W8Dfo9bPYtwjQHJQ1JQ7rWmUPnQRplkSSL1c
	22ui2a7IZRsePFT+NLeiCdmsl+FY715JIFilbqe7TfSla1/qu5TC668tTj1WSP0ZLuEWRCRqF6L
	4YT9Cm0pQhuYCywnQrSiLmMNRqSeFa1cCtqzTrxtQlQYrmJUPdYeJj1a6TFtToooidsJBZpENX3
	4u7ErVsO
X-Received: by 2002:a17:90b:17cd:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-39aee178f15mr9483485a91.20.1788388327446;
        Wed, 02 Sep 2026 15:32:07 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm1405185a91.6.2026.09.02.15.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:32:06 -0700 (PDT)
Subject: [net PATCH 3/4] fbnic: Handle FW mailbox completions flagged with an
 error
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Wed, 02 Sep 2026 15:32:05 -0700
Message-ID: 
 <178838832539.11136.10707141286493607929.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The firmware can complete a mailbox descriptor while also setting FW_ERR
to indicate it could not process the request, for example on a mailbox
DMA error. The completion carries no valid data.

The driver did not check FW_ERR. On the Rx mailbox it would sync and
parse the stale page as a normal message, and on the Tx mailbox it
silently freed the request. If the capabilities request from
fbnic_mbx_poll_tx_ready() completed with FW_ERR no response was parsed
and the poll spun until it timed out even though the ring was healthy.

Check FW_ERR on both mailboxes. Count it in fbnic_fw_mbx.resp_error,
which is also shown in debugfs, warn, and drop the Rx page instead of
parsing it. In fbnic_mbx_poll_tx_ready() re-issue the capabilities
request when the Tx resp_error counter advances so a FW_ERR completion
triggers a retry rather than a timeout.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    4 +++
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c |    4 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c      |   27 ++++++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |    1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 14af30e189d6..baba3471bf5a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -1216,6 +1216,10 @@ enum {
 #define FBNIC_IPC_MBX_DESC_LEN_MASK	DESC_GENMASK(63, 48)
 #define FBNIC_IPC_MBX_DESC_EOM		DESC_BIT(46)
 #define FBNIC_IPC_MBX_DESC_ADDR_MASK	DESC_GENMASK(45, 3)
+/* Set with FW_CMPL when the FW completed a descriptor without successfully
+ * processing it (e.g. a mailbox DMA error); the completion has no valid data.
+ */
+#define FBNIC_IPC_MBX_DESC_FW_ERR	DESC_BIT(2)
 #define FBNIC_IPC_MBX_DESC_FW_CMPL	DESC_BIT(1)
 #define FBNIC_IPC_MBX_DESC_HOST_CMPL	DESC_BIT(0)
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 3c4563c8f403..4581fd8c8edf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -539,8 +539,8 @@ static void fbnic_dbg_fw_mbx_display(struct seq_file *s,
 	/* Generate header */
 	seq_puts(s, mbx_idx == FBNIC_IPC_MBX_RX_IDX ? "Rx\n" : "Tx\n");
 
-	seq_printf(s, "Rdy: %d Head: %d Tail: %d\n",
-		   mbx->ready, mbx->head, mbx->tail);
+	seq_printf(s, "Rdy: %d Head: %d Tail: %d resp_error: %lld\n",
+		   mbx->ready, mbx->head, mbx->tail, mbx->resp_error);
 
 	snprintf(hdr, sizeof(hdr), "%3s %-4s %s %-12s %s %-3s %-16s\n",
 		 "Idx", "Len", "E", "Addr", "F", "H", "Raw");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index ace6685df039..8f4a195bb8ed 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -291,6 +291,12 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
 			break;
 
+		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
+			tx_mbx->resp_error++;
+			dev_warn(fbd->dev,
+				 "FW completed a Tx mailbox request with an error\n");
+		}
+
 		fbnic_mbx_unmap_and_free_msg(fbd, FBNIC_IPC_MBX_TX_IDX, head);
 
 		head++;
@@ -1672,6 +1678,13 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
 			break;
 
+		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
+			rx_mbx->resp_error++;
+			dev_warn(fbd->dev,
+				 "FW reported an error on an Rx mailbox message; dropping\n");
+			goto next_page;
+		}
+
 		dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].addr,
 					FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVICE);
 
@@ -1740,6 +1753,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 	unsigned long timeout = jiffies + 10 * HZ + 1;
+	u64 resp_error;
 	int err, i;
 
 	do {
@@ -1770,6 +1784,8 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	 * mgmt.version once we get the actual version from the firmware
 	 * in the capabilities request message.
 	 */
+send_cap_req:
+	resp_error = tx_mbx->resp_error;
 	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
 	if (err)
 		goto clean_mbx;
@@ -1788,8 +1804,17 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 		fbnic_mbx_poll(fbd);
 
 		/* set err, but wait till mgmt.version check to report it */
-		if (!time_is_after_jiffies(timeout))
+		if (!time_is_after_jiffies(timeout)) {
 			err = -ETIMEDOUT;
+			continue;
+		}
+
+		/* If the FW completed our capabilities request with an error
+		 * (FW_ERR) it produced no response; the ring is not wedged, so
+		 * re-issue the request instead of timing out.
+		 */
+		if (tx_mbx->resp_error != resp_error)
+			goto send_cap_req;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index d84723e4cfa3..5f9969247e30 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -13,6 +13,7 @@ struct fbnic_tlv_msg;
 
 struct fbnic_fw_mbx {
 	u8 ready, head, tail;
+	u64 resp_error;
 	struct {
 		struct fbnic_tlv_msg	*msg;
 		dma_addr_t		addr;


