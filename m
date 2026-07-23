Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B14322ED
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799664; cv=none; b=M1wQaiTZN5zr5OgmANiAJuaku9dxXAKPhvidsP16Q4mLEMfKutGtBiknoB2nm+v1y2c9+hl150dayOtvOfDBR9nFuE3W4AVsHF4DTTx7sH3FjlJqYRw+7s0NUtbGj9ASiu11af+WTrNFUioLW+cNq6KpTAWI9lVmWzWhPI0xODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799664; c=relaxed/simple;
	bh=g7PgbZxk0ZYEVAy5ZHU8r9/wH1xAU8siBXlCIHbfMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwA8g8TcosJatMBv0UN139jdE28/LJ7OKbDaNlf2kbYsFsnzWmrWcJioJAyHxOSSTBsNQzXMKLrpexSZHp+7woScoyf0M/c/9sXxfRsm5Mnj87XYVOt9A3252+OCXO+X+BfMrQrExBSm+fDx/Yhc4/5GN5HuGOA4pL+BM7YpGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=z3d8qHA7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="z3d8qHA7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cedda2ce6fso3604235ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784799659; x=1785404459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQ9bjv6SMDdqScWzoPZvoyCdrSvsUJw/PMPVLaeFbAo=;
        b=z3d8qHA7s8cGiEDmIAY6TP68jcF0EGXtt3/3SK/JCyMFBpkZf0oXjZUgcAF5q/2/Xf
         rba73Inepo0ggHooWA9oCilUG2zM0pw0lwIoQnBkboOhXWEe6wGTPPXKhXyrT8qAMjiU
         /lwqJY6WyyLcZztY9cb/U+kMKw1eujTo/nlnwpKSGbDtHr9M7D6E4SJ573vad/PCoxKi
         Xow8tAIUaaqAoqi/zEAqTVNjNUP9AhaPZHaFjCoF993fZjR+T2+GXjCfJjksuxITtPmP
         drbvL2Dw4K5/NyZBWgciY1/4HBVkV2i0VdTfZfurutNiT6IJC13t8TnlJsK6ItV9LMOL
         DDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799659; x=1785404459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQ9bjv6SMDdqScWzoPZvoyCdrSvsUJw/PMPVLaeFbAo=;
        b=eluQGcTetJsexiiLp5g60Li1iQSavhCK07KRWzfIXy4TVjUMRapQfpWiIDfpUd7QHv
         I73+ChGV9YQXM6p+J5vpd6CBb722RgobJIzWPEY/5O7b9zjg0rAl4NRqvD6k1z9qW6XF
         uLVqCg35UNc0v2rZDoB2zRlw5q+w1ft4w24/sztRIPlMNyUA7Tc9TBgGreEo4x4gQ+qY
         OOLk75d8lrqiza+GnDxIEq3O9FFDg0ur1x8IJ3tzvmkYPMjin5aXHzl+P++HE6GhaBEL
         PM9VQvye+FgZYMI9JgqpZSqU+qO8GZ2QWmRVYycz3j2JjC0MqaW+/jLW5Bt0XnnYxhgS
         AR3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqF0+hFqDO9hG54yvQTRQ7+dMek4Wjs3sIEP+U7FEc28vhKX/MWaDI+VhoKC1aqMCu/29SzMqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/i873ET6ngYBHN5Ia3+YoyevG2JilLAFMNnj0E04LlEh7yY8
	yr9AoNe3JOwzGmEiCzNxm3kUtckU8fXeS1nBS8muJ81vnt6r/FPXRHfvCs5/uWcZdb8=
X-Gm-Gg: AR+sD12PUWHHfRnaN8/Oom3xJMau7sKxuUOgZfmBt9XYkfb6qtB6SA0Z7PI69nV5ugc
	xxgZ7snyQvgeXGjXTevt/dGnTeqYQOMMG45EEnZb6v65bT3gwJMkU5GF4WM9r5fc1NHf/MQ6R7p
	26XbTH/2CSRR1CvBwd3pG5Rc6czjLrSKfNoX7swXyhzgP6ChoPPG4hYk8K5XysMuM6wbOSEVd5a
	X9x3zclRhMeuuPw+lIAkqAvGo8bo8xQSsiF5rNh44f0un001nocBe4QP75SoY90A2qbOrm5bbJs
	FychYXL4FTHYwS6e6UDFR1wpQaHARGVwkvkEcUEhix16u+gvUioBgsw7MW5T/dHmkCXQJsdVFaP
	VCokjNUqdQjqpXqLUixBOW9uBNI5k0KY1YEwBTvR1FUoXUqWnXDEwRUz15USlK614Y0g16WEkb/
	qb3alg5c2+cQ==
X-Received: by 2002:a17:903:b85:b0:2ce:9b49:d4a0 with SMTP id d9443c01a7336-2cfa6c7209amr25302105ad.35.1784799658989;
        Thu, 23 Jul 2026 02:40:58 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm30259905ad.31.2026.07.23.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:40:58 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net] net/smc: fix out-of-bounds read of rkey array in SMC-Rv2 LLC processing
Date: Thu, 23 Jul 2026 18:40:26 +0900
Message-ID: <20260723094027.391199-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMC-Rv2 uses two receive-buffer layouts, selected by
smc_link_shared_v2_rxbuf() (i.e. lnk->wr_rx_sge_cnt > 1):

 - shared (device max_recv_sge >= 2): each receive work request posts a
   small primary SGE plus a spillover SGE into the per-link-group
   lgr->wr_rx_buf_v2 (SMC_WR_BUF_V2_SIZE = 8 KiB); a message larger than
   SMC_WR_TX_SIZE lands with its body in wr_rx_buf_v2.

 - non-shared (device max_recv_sge == 1): each receive work request posts
   a single SGE of wr_rx_buflen == SMC_WR_BUF_V2_SIZE, so the whole
   message lands in the per-WR receive buffer.

smc_llc_rx_handler() hands the received buffer to smc_llc_enqueue(),
which copies only sizeof(union smc_llc_msg) bytes into the fixed-size
qentry->msg and queues the request; the LLC request is then processed
later from the llc_event_work work item, after smc_wr_rx_process_cqes()
has already reposted (and thus recycled) the per-WR receive buffer.

For the shared layout the rkey array survives in wr_rx_buf_v2, and
smc_llc_rmt_delete_rkey() and smc_llc_save_add_link_rkeys() read it from
there. For the non-shared layout nothing preserves the message body: both
functions instead read the rkey array from the truncated qentry copy
((struct smc_llc_msg_delete_rkey_v2 *)llc, and (u8 *)add_llc +
SMC_WR_TX_SIZE), running past the end of the ~72-byte qentry allocation.
The loop bound num_rkeys comes straight off the wire and is only capped at
SMC_LLC_RKEYS_PER_MSG_V2 (255), so a peer that sends a DELETE_RKEY or
ADD_LINK message with an oversized rkey count triggers an out-of-bounds
read of up to ~1 KiB (delete_rkey) or ~4 KiB (add_link) past a kmalloc-96
object.

  BUG: KASAN: slab-out-of-bounds in smc_llc_rmt_delete_rkey+0x6a4/0x780
  Read of size 4 at addr ffff8880059ee748 by task kworker/0:0H/11
  Workqueue: events_highpri smc_llc_event_work
  Call Trace:
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   kasan_report+0xce/0x100
   smc_llc_rmt_delete_rkey+0x6a4/0x780
   smc_llc_event_handler+0xa13/0xef0
   smc_llc_event_work+0x189/0x260
   process_one_work+0x633/0x1030
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30
  Allocated by task 43:
   __kmalloc_cache_noprof+0x158/0x370
   smc_llc_enqueue+0x72/0x560
   smc_wr_rx_tasklet_fn+0x474/0xa80
   ...
  The buggy address is located 0 bytes to the right of
   allocated 72-byte region [ffff8880059ee700, ffff8880059ee748)

Preserve the whole received message in wr_rx_buf_v2 for the non-shared
layout as well, by copying it in smc_llc_rx_handler() before the receive
work request is reposted, and read the rkey array from wr_rx_buf_v2 in
both layouts. The reads are then bounded by the SMC_WR_BUF_V2_SIZE
buffer. This also removes a latent use-after-free on the SMC-R server
add-link path, where the non-shared code dereferenced add_llc after its
qentry had been freed by smc_llc_flow_qentry_del().

Triggering the bug requires a RoCE device that advertises
max_recv_sge == 1 (a configuration the Fixes: change added support for)
and a peer emitting an oversized rkey count. Reproduced under KASAN with
soft-RoCE (rdma_rxe) after forcing wr_rx_sge_cnt = 1.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 net/smc/smc_llc.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 954b2ff1815c..1c32bf970098 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1099,9 +1099,8 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (rc)
 		goto out_clear_lnk;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
-		smc_llc_save_add_link_rkeys(link, lnk_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, lnk_new,
+					    (u8 *)lgr->wr_rx_buf_v2);
 	} else {
 		rc = smc_llc_cli_rkey_exchange(link, lnk_new);
 		if (rc) {
@@ -1501,9 +1500,8 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	if (rc)
 		goto out_err;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
-		smc_llc_save_add_link_rkeys(link, link_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, link_new,
+					    (u8 *)lgr->wr_rx_buf_v2);
 	} else {
 		rc = smc_llc_srv_rkey_exchange(link, link_new);
 		if (rc)
@@ -1812,12 +1810,15 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	if (lgr->smc_version == SMC_V2) {
 		struct smc_llc_msg_delete_rkey_v2 *llcv2;
 
-		if (smc_link_shared_v2_rxbuf(link)) {
+		if (smc_link_shared_v2_rxbuf(link))
 			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
-		} else {
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)llc;
-		}
+		/* The full message, including the rkey array, has been placed in
+		 * wr_rx_buf_v2 for both rxbuf layouts (shared: header copy above
+		 * + spillover DMA; non-shared: full copy in smc_llc_rx_handler()).
+		 * Reading it from the fixed-size qentry copy would run past its
+		 * end.
+		 */
+		llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
 		llcv2->num_inval_rkeys = 0;
 
 		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
@@ -2104,6 +2105,16 @@ static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
 	} else {
 		if (llc->raw.hdr.length_v2 < sizeof(*llc))
 			return; /* invalid message */
+		/* For the non-shared v2 rxbuf layout the received message lives
+		 * only in the per-WR receive buffer, which is reposted as soon as
+		 * this handler returns.  The LLC event handlers run later from a
+		 * work item and read the message from wr_rx_buf_v2, so the whole
+		 * message must be preserved there now, mirroring the shared-rxbuf
+		 * layout where the body arrives in wr_rx_buf_v2 via spillover DMA.
+		 */
+		if (!smc_link_shared_v2_rxbuf(link))
+			memcpy(link->lgr->wr_rx_buf_v2, llc,
+			       min_t(u32, wc->byte_len, SMC_WR_BUF_V2_SIZE));
 	}
 
 	smc_llc_enqueue(link, llc);
-- 
2.43.0

