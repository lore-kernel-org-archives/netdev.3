Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51B3806CA
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420242; cv=none; b=bZjJ/Y0opXqv6TgthAinkQIxofy2RlxaWsW+m0BlFFhfSyqVxqAq8Pvx2f/kk/68LT5CnSi0Bq1au6XgvhPKul9pQ3mD3Gz6GHLt9N542fI6Q6RbZQhAhiwaC6b8tK1l/BSBuBVh+FZ1rhzGUuj6HJXfV9eRXklW9Fnbpw2LH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420242; c=relaxed/simple;
	bh=8pvcWvgo/ys4xDBalooL22luvHS/KmWjJnoRw0QZgFc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1lKi/QCQFpE3HTyUsQmhRrS8jxT+W+gEWVBywpbxUIJ+hUkVXnTaTE+lB3+3rg2/bxcMwRETPQxiBiOSvYr77g7eWhQ33hmIrVNMe/666bxHHqHM1M04EHOXcPSOh7HZEbQwzjLz3mbAW3fcTcp25wk2gGYXfq52TC4Sqe8+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqyj0fqn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqyj0fqn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d942c7cc2fso37384415ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420235; x=1790025035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=54URkK18dM3I5MkfwcXIs/GDO8OdoMiEOGVqcTQ9wt4=;
        b=Uqyj0fqnumYf4Ipyw9rmARw/h2WJs4tRWMBHRDMUOHIKTe1PTx7+5OiiSetsOTa0Oe
         ClAh2Afeuo+DGdOLOV4vfDs+3JleXVvBDQVC2f56vs8CeqWuSERqzaOxakcTk8TaAZOr
         PGqiIFILfXwBvv1m6FRhVqW6SButmx72JvvZyw1pNmLNV8LzXABpQYDRzM+yE6T72WAg
         e73mMToNFgqfmibOjBbVAC9QApwsxGvFMIZBtQ1/xPHFvmsmKk+aYlg1rbKyYXHNM7DV
         nnzo/R7apR37XI/FWK6TQrxxdw+SYqkYKd3h4WynoYV1xZ1fvrJ4BjarQvqvsPOVgzhe
         5uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420235; x=1790025035;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54URkK18dM3I5MkfwcXIs/GDO8OdoMiEOGVqcTQ9wt4=;
        b=p84uUkf3UV/tS9u0dbCASbgLmNlDvYsU71Fvp8dGQ5qY/CFqm7zBs9+e3/eWJXcLA/
         L+59asYwVW8QFo0YqHWNJq70FesFNIB7xO6BBREbtz4z98xHWaCHkt+cdvIkU8QYNBSb
         znRTQP4eO6M67P1PiDcXk6mMYzwdq/wgK3ZjohTGfThII53D+cMproBKmP7/uiTFYtgX
         L0+fPwikqDUw7UAENSh6oXWj5VGwEXR8J30xJDIGQdsYbekAMvzkmvOZhZbji+56Sq/4
         s3dHKFa7RDEgSfUO5arWc15Z2LnVhw+sayES0tVNv9U4l/JzrBmY4Cx5KiWTo2EekiSj
         vnXw==
X-Gm-Message-State: AFuF++lBXIfSeux7vOVn36uvElkmwfziOtV4+S6J2dEgxW3lKjKLssYK
	rX4gp9iHSrwgcuzcxn9t2E8BOGKSXSZIyPSoDcLpxW4V9/R8JDpiavdV
X-Gm-Gg: AYBFou2SMcTDWK+7ARVv1B3a4DVRBNDgUbbJSWiDKu6rPjwp4u/AbXCXA63c53rIaW+
	BDtEzQI5PnVttwe+3V7F+MbZW02pV1fmlYtENUdTrx+YfPqc9+jpSWTt6NXGtyBiWLYKMxkXthF
	6QyS9eh2bj/TSIrfajftYHkG9zXmXsJW3+x16pnjuhVeAbAtMG6oxwKJijhkeW21D+vA6WAGml/
	Q1krGuwhPHmefghD2h+hE2kj/Gp46tAZBjmVXFS4ttDSIegCG18oZ2Z6LMINvmfb9RjCUjTyB9I
	g8THzI6kLnsASF0+OkmsVwFXyKfZ/AbCKUyLGDvCe100YdEbY9Z/nBmizMnZQuJm3T/kFGNolKW
	13JrLMNtyUUDpaUzMg6cYzwRtuwerfJWoQkT9kFWYkDRvy0FDHmA5PQCaxTRSawrnj8o1HavSTP
	C4/rKuziDML7mtNQYKdcsKhSZzcXQg/jmZGNBvhJPTGmQe4YjWRAvsMClAUFjXKoSlWSYs2Z5Hk
	LDR81rcx1KYsePheWzqCp3AoHX5kBpBq6sgI+E4g8NjJ+CPxPK8VdDH4D+33wXRCA0o1t3v1i58
	v1wXqCwySlHmGYNXIjY=
X-Received: by 2002:a17:902:db0f:b0:2d9:1dee:43e3 with SMTP id d9443c01a7336-2dd6c70a6f6mr84003405ad.18.1789420234958;
        Mon, 14 Sep 2026 14:10:34 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd445de320sm44236055ad.8.2026.09.14.14.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:34 -0700 (PDT)
Subject: [net PATCH v2 6/6] eth: fbnic: Handle FW mailbox completions flagged
 with an error
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:10:33 -0700
Message-ID: 
 <178942023343.7700.9423398932961964439.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
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
silently freed the request. If the initial capabilities exchange in
fbnic_mbx_poll_tx_ready() hit FW_ERR -- on the Tx request or on the Rx
response descriptor -- no response was parsed and the poll spun until it
timed out even though the ring was healthy.

Check FW_ERR on both mailboxes. Count it per-mailbox in
fbnic_fw_mbx.resp_error, which is also shown in debugfs, warn (rate
limited, since the bit is firmware controlled), and drop the Rx page
instead of parsing it.

In fbnic_mbx_poll_tx_ready() re-issue the capabilities request when
either the Tx or the Rx resp_error counter advances, so a FW_ERR on the
request or on its response triggers a retry rather than a timeout. A
valid capabilities response is honored before the retry check, so a
response parsed in the same poll as an unrelated FW_ERR is not discarded.
The counters are mailbox-wide rather than keyed to the capabilities
request; that is sufficient here because the exchange runs during
bring-up before any other mailbox traffic, and any spurious retry is
bounded by the existing 10s timeout.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    4 ++
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c |    4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c      |   38 ++++++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |    1 +
 4 files changed, 44 insertions(+), 3 deletions(-)

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
index 3c4563c8f403..6edfa0aa69f1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -539,8 +539,8 @@ static void fbnic_dbg_fw_mbx_display(struct seq_file *s,
 	/* Generate header */
 	seq_puts(s, mbx_idx == FBNIC_IPC_MBX_RX_IDX ? "Rx\n" : "Tx\n");
 
-	seq_printf(s, "Rdy: %d Head: %d Tail: %d\n",
-		   mbx->ready, mbx->head, mbx->tail);
+	seq_printf(s, "Rdy: %d Head: %d Tail: %d resp_error: %llu\n",
+		   mbx->ready, mbx->head, mbx->tail, mbx->resp_error);
 
 	snprintf(hdr, sizeof(hdr), "%3s %-4s %s %-12s %s %-3s %-16s\n",
 		 "Idx", "Len", "E", "Addr", "F", "H", "Raw");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 59aa879798b9..6d7eb8479edf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -292,6 +292,12 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
 		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
 			break;
 
+		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
+			tx_mbx->resp_error++;
+			dev_warn_ratelimited(fbd->dev,
+					     "FW completed a Tx mailbox request with an error\n");
+		}
+
 		fbnic_mbx_unmap_and_free_msg(fbd, FBNIC_IPC_MBX_TX_IDX, head);
 
 		head++;
@@ -1673,6 +1679,13 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
 			break;
 
+		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
+			rx_mbx->resp_error++;
+			dev_warn_ratelimited(fbd->dev,
+					     "FW reported an error on an Rx mailbox message; dropping\n");
+			goto next_page;
+		}
+
 		dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].addr,
 					FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVICE);
 
@@ -1740,7 +1753,9 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+	struct fbnic_fw_mbx *rx_mbx = &fbd->mbx[FBNIC_IPC_MBX_RX_IDX];
 	unsigned long timeout = jiffies + 10 * HZ + 1;
+	u64 tx_resp_error, rx_resp_error;
 	int err, i;
 
 	do {
@@ -1771,6 +1786,9 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	 * mgmt.version once we get the actual version from the firmware
 	 * in the capabilities request message.
 	 */
+send_cap_req:
+	tx_resp_error = tx_mbx->resp_error;
+	rx_resp_error = rx_mbx->resp_error;
 	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
 	if (err)
 		goto clean_mbx;
@@ -1788,9 +1806,27 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 		msleep(20);
 		fbnic_mbx_poll(fbd);
 
+		/* A valid capabilities response ends the poll. Check it
+		 * before the FW_ERR retry below so a response parsed in the
+		 * same poll as an unrelated FW_ERR is not discarded.
+		 */
+		if (fbd->fw_cap.running.mgmt.version >= MIN_FW_VER_CODE)
+			break;
+
 		/* set err, but wait till mgmt.version check to report it */
-		if (!time_is_after_jiffies(timeout))
+		if (!time_is_after_jiffies(timeout)) {
 			err = -ETIMEDOUT;
+			continue;
+		}
+
+		/* The FW can flag our capabilities request (Tx) or its
+		 * response (Rx) with FW_ERR, in which case it produced no
+		 * usable response. The ring is not wedged, so re-issue the
+		 * request instead of spinning until the timeout.
+		 */
+		if (tx_mbx->resp_error != tx_resp_error ||
+		    rx_mbx->resp_error != rx_resp_error)
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


