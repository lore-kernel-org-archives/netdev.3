Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179551DDEB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915935; cv=none; b=Lhooh5UTvonal9FkoGED/9kcm2W/FGeDmz42D9fplgZTOaIBu6ccZPkKHoY9idyGunWTACo2pfnOqtp4DsoiSkyje5ifHtZQQUVLEuZHhGeETNhymd+JyfThWYGxPD+fP4aXIKdIgxeOZ9wHh2fYz8GjRXwRBS1IQNAoJ1D6AAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915935; c=relaxed/simple;
	bh=AlG/JZ6VJ7vRBe6rEuyNKsPV58OQf13xQXX8THhv3as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ii0/VVYKhW3/0hk/PlZv5Wqr+UXU0DCH9mQYyfU+BUJ5vCvxS1RczyMWvBs98cEWqCvixWITihnHiynIsmp7eE4GEalEDDqjrBL0vJndEi8eDE6G5StbD2Lt5o5CKMvSPbdF0QKMUK4oRu2p4biKuoxihOo51/cFL6WBOg1SGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XfKxXSOV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XfKxXSOV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53505bc6524so2331401cf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791915933; x=1792520733; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KFCW1M7qXicNkXoNFz0UEyrqo2R7uteq2KxnBN5zNno=;
        b=XfKxXSOVc7prQSLwXIwVuBllKsr2o2KQVK+/5VGkjEGQUESSOJm7ulPM0O1qUImVtg
         pBDtueQJqRTmJaCCmF/k/7j99w8fqNMWKvB1wY2WjCRX/bgD1kEADEc8sPQ83szyru7v
         6bleLCzgm70RqzOKVRy3L3ROa9YALXiVr/O+/g/gmK1UgAue2d3rjnVcmVwg3ry5m4L9
         AsLHg/uELfVFqYNORwI4LY3Ri0q/+lEAmxARzKhjpeXLQjdA0L4+87ZCbh5xvLUgpcN5
         xrigD953YYYvAP4jx0ylU1Hc6vhuoJmcqnAA2MnLx1qLldw6l/aA2LjDJPhq1n0l/TQq
         qpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915933; x=1792520733;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KFCW1M7qXicNkXoNFz0UEyrqo2R7uteq2KxnBN5zNno=;
        b=gWkVBRt6pvElfT1q8Cp7/qagszTRquw2LsR+A1eeqsI0mNjBOVW64xk3Au2zXV17Gp
         p9WTSmquuz8uvL5cHLZv6yZckAwlAStI+HF8vxoacAvXmVrjkLC+6XCWUEdbvU8NnNQH
         9AEsQtmlg7J8n+h2bI0v2t/3bSVXONxdRX9KzBLnF1g50lNYOW9eT0sp9NSvWmpj76tL
         tujErv0bGixkTFgFBxJzCCl44vgHDWmC2zBwaik8L1jviiDWyqjS9qXVmG9h5DLEFfNZ
         C3pCJlesiz2fHDya5TjTv3jd9TGtPXmgvqYtaGBvR4qVi4TA4Hxz4mjxhdzODB6Ma8BB
         3iUA==
X-Gm-Message-State: AFq9FYJVmfzVt5/bXEDqdO1a7OQJFEKSFtOtJO+zyBBut51cNAhNjIEj
	cQETMpAZ0sRH3Yvr3sgTym2DBk+FtLJsTSy4LDNqi9jh2lx8e/O6NkENKAyN0MWuTHY=
X-Gm-Gg: AYBFou2G13hTb8nCefUlOmpG+nHANAqvfGejh/N0SnNy/EX82aLLQEXfO9CiSsOJIai
	6dyH+8m2UvYTxWXQaGDCeK6Gbnb+AE9PAKuFZDUYiWOn2rFHYH63UInEh58nTo1L7JzhyXyE77m
	XzY8Xv2I/bfI4JticM2YxXmQE43hQvfFTqfIFLUtANLB+pjyYHNzdhTIrqlHi4AzX9raDUSeMTt
	ZSdfY6BiAdtucOfLiOnjx5jc3de/GjOchG3W7px0lOAMKL1JZywxCnJZdSPsSQcAtY9rQu9VGgI
	z/i5BSURYJx4AoQ6jeGe7rZPQBvVy1dAIESa22a+NlBZTnatg07kDRRndrmVAx0r0zH53URO9kG
	Y0/2v4CT2qjJnrLuQsPvGhwUuDG/SmRDm4hXNtBWneEJSv2/Q4F1L64Bv6T/C4BR5I2BeaMJyY/
	jZH4w+R01xPS2c/xC+6cg8S7YAMA+ogyL4DrPP11KunEFZ/2CHepdAj5wZnBYs7DduF2PvqzaFD
	kwHh6p0/zmVIpc=
X-Received: by 2002:a05:622a:4e04:b0:535:a5f7:d59b with SMTP id d75a77b69052e-535a5f7de55mr186236721cf.42.1791915932663;
        Tue, 13 Oct 2026 11:25:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b76eea2sm107276361cf.18.2026.10.13.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:25:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 13 Oct 2026 18:25:06 +0000
Subject: [PATCH net] net: axienet: don't advance the TX ring head before
 the descriptor is ready
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAIF3zmoC/32NSw7CMAxEr1J5jdUvH3EVxMJOTGsEpkoKqlT17
 iRlz3KeZuYtECWoRDgXCwT5aNSXpVDvCnADWS+oPmVoquZQV3WL3CHNKiYT+ieJ9WqCQa3HQci
 jc55P0pLj4x7SyRjkpvMmuEAawfUH45vv4qZ8nWtMUZADmRsyeowld+UG/8hgXb//dwa/wAAAA
 A==
X-Change-ID: 20261013-b4-axienet-dmaengine-ring-head-ccdb8e3acb75
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791915929; l=2932;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AlG/JZ6VJ7vRBe6rEuyNKsPV58OQf13xQXX8THhv3as=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBomUl/RFNb7o7hd3lkq0GvyegzlXY0C4reO22XN+8hGLGwHC9ittbqyynjfwdMXd/zfN9u1sJL
 GMd7gDVRTMgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

axienet_start_xmit_dmaengine() bumps lp->tx_ring_head before
skb_to_sgvec(), dma_map_sg() and device_prep_slave_sg(), and none of
their error paths undo it.  The skb is freed and nothing is submitted,
but the slot stays claimed.  axienet_dma_tx_cb() walks tx_ring_tail
once per completion, so the next completion lands on the abandoned slot
and dereferences whatever skb pointer is left there: NULL if the slot
was never used or was already completed, or a stale skb that gets
consumed a second time.  Every completion after that is accounted
against the wrong slot.

dma_map_sg() and device_prep_slave_sg() can fail at runtime, and so can
skb_to_sgvec() on a malformed skb.  Only advance tx_ring_head once
those have succeeded.  The completion callback can't run before
dmaengine_submit(), so claiming the slot just before that is fine.

dmaengine_submit() itself can also fail on xilinx_dma after a channel
error, and its return isn't checked either.  That's a separate problem
and isn't changed here.

This was found by the Sashiko AI review of the skbuff BUG_ON() series.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Compile-tested only, I don't have the hardware.  The bug is in the error
paths, which are easy to see from the diff: every goto after the old
increment returns without submitting anything.

Thanks,
Josef
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 09443623a3e2..a5800409e45a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -929,7 +929,6 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	if (!skbuf_dma)
 		goto xmit_error_drop_skb;
 
-	lp->tx_ring_head++;
 	sg_init_table(skbuf_dma->sgl, sg_len);
 	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
 	if (ret < 0)
@@ -965,6 +964,10 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	skbuf_dma->sg_len = sg_len;
 	dma_tx_desc->callback_param = lp;
 	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	/* Claim the ring slot only after the steps above that can fail.  The
+	 * completion callback can't run before dmaengine_submit().
+	 */
+	lp->tx_ring_head++;
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
 	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),

---
base-commit: 8bf659bd54e1f00e34cf5244b1d289c506fa47c0
change-id: 20261013-b4-axienet-dmaengine-ring-head-ccdb8e3acb75

