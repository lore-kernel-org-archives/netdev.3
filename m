Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAA374E74
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736077; cv=none; b=bbP3s2ioLweA8vBz+inC4EiIpD6htkk/DjNG0sjryZbybm2zw4YeB6lIuL0akqPOnW5nU6XFoaRPIHMOwaez8YgCmHVWCgqnCpsIwG6h2VjTjVDe/67B3NaOiqvAb2wVZDF6xPclIr7VcQyAKDzO7it20OjIGFdF7IdfBlAOUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736077; c=relaxed/simple;
	bh=Jt2JBi0RJqk4LCWW046JFBKUD5SQpWrv093zrdv9SXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5futxf1TffK+qnvClLpncD1fq5VSSFHlzKGxxj6KpmkIb2MXUXOpTAgQB//VLgJxOTj3Ih5t5Uwz+2Yh8tA6YXuTGFuHW/UcPkl2zScHTwy+bA/snBDz2VamZOU//u9t9F15LIyZ7EzKGEtFjBcyH1Qxi2zKr5PkJl3hnlg9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Fvfi9Oyh; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Fvfi9Oyh"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso5113391eec.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790736072; x=1791340872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpO0PbCCP33XzAfj3p2w8X9uM0F+LRnUqAGN5bqrDzY=;
        b=Fvfi9OyhTTM5K8EpKQDzb9djWFkTbBOE3zAVkpXseeYQyu6UTDjde2Jz8mSBkz5xDP
         Xt0PCv9ULsOjowPB8HrKw3Zc5cq6AsM+1oZ/955vD8rA/7orQFMZB4Y2S8VcTkGXzza/
         29At5OzDRkJ5nUxdnWd3PQtb2iuSDFewbTsVTjfAEkBAsReJPB0jhwrJmhiHXqXjGT+v
         WtCUmWsJvxSN8veESFxxJ1L6j8red8sBbr650FcgU0JDT4tvi+sYHsSObXaubjK/C0zF
         DN6MHDKQt5Od6i4TRku2sVrl5BThidNs2+CkKCyIp+4AsPvR6GhRuqsjor7qU6S1b4gK
         53zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736072; x=1791340872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpO0PbCCP33XzAfj3p2w8X9uM0F+LRnUqAGN5bqrDzY=;
        b=f5q4W3Q/6O54dCB7Ntija9Noge+ocBIOpIgDMWLlv128Gq1BTVha+STvn9YBYDTwFd
         8FU/4rA6rkHMVscDKbm0GbIa9W22A8zU8RD5sdybV35JH9UgH2NYRRQjJy/Hd6sXCFpD
         o3WXr4F0MdC/P1yda1SPCo2N99rEsa5N+j1VsUtVxFUlm/VECNHtpjMiPBwfhirxyQvp
         +2roIJN+rf3Feav/i7AQRx1Atm3LkS6V+NW9oY/B4ypJK86wUtlQYroeI9oMtuNfpKHw
         J/kCw1bDUnqLnJwT9LhXe1FHHdPHrJtvdSUiXImru0NfnMNP5HOHK2Xi7TmuUIdv3RhL
         jD/w==
X-Forwarded-Encrypted: i=1; AKwUvBwL8PXqc5R/Mmy/ok2FCxKnenhAcNLG4kw12T00SNC+pF/GhdVOcF2ol4qASLVrUiDHJXHqjOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYujQ7OW5C8jPOwypSnF4bkChst2bU5un6Dokqx5cL+k+cW3jA
	9I5bsggRkW/v+qKp5whjULl2BaBx8C9wlgJLX9Kr14YcWfWOA/mwi9z94qbvtdoD1QE=
X-Gm-Gg: AYBFou1GBD6jGEp9aYK9HU65wDs1RgeuwzZACA1UlllvnsMLqMosBZVLzD5bNSlRWZI
	2aSv1KvcibFUQMf5Qjp4mes50bmEe9kYidFY9o8BkRZUyM2XHUTocbwQzGvyhtf++R11L5HJEfq
	y1JAlA2UgwhesMzxoDQDHPwVX2V/3wT3PUysymOEDKbivsKvdnNxemheTmgT76KE5ZZCkMGO6AR
	9cpc5X6q5TOd5aQ+IDf+Cqu4H2D6GrlkB0JGt8dzNVYSbNUurk1WAJvZXyYu/GkNXpzr58u/x1i
	qirZDDPbvkcRF9e3BTviq4AJ9Lyol9WKh13ZddxGXpavcbKvrq2rZkR05ZagoQi1AcqbTV2i8jI
	ly2+rex5BaaHncbBIm7BosC8ZxCfUnf4piVNNO0eW6IqLSTSMpD+KW52k3ZpYQkhUhL7PWKRKN7
	9bGsOzrEChOfuUxTK3N5OnzPiQH7jEr06+Z+caaBo57JQD9kQvaJNViolSqcsI76NgaF+/Db+qP
	l+ax6C2ZVX9WOoyqn3MRtbmFPlNYpWrneU3c/jyXN99tiPbXiU6KMdBrU5mqE+J82xbFC4=
X-Received: by 2002:a05:693c:864e:10b0:347:8d01:164f with SMTP id 5a478bee46e88-34cdbadaa6cmr224445eec.19.1790736071471;
        Tue, 29 Sep 2026 19:41:11 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c388d0110sm2465555eec.20.2026.09.29.19.41.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 19:41:10 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH 6.6.y] net: ena: Add validation for completion descriptors consistency
Date: Tue, 29 Sep 2026 22:41:00 -0400
Message-ID: <20260930024101.96014-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7 ]

Validate that `first` flag is set only for the first
descriptor in multi-buffer packets.
In case of an invalid descriptor, a reset will occur.
A new reset reason for RX data corruption has been added.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240512134637.25299-4-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and net maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-40999. It detects inconsistent ENA completion
descriptors and resets instead of consuming them.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The code change is identical to upstream.

Could you please queue it for 6.6.y?

CVE: CVE-2024-40999
Upstream: b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 933e619b3a3134..4c6e07aa4bbb55 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -229,30 +229,43 @@ static struct ena_eth_io_rx_cdesc_base *
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
 
-static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
-					   u16 *first_cdesc_idx)
+static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
+				    u16 *first_cdesc_idx,
+				    u16 *num_descs)
 {
+	u16 count = io_cq->cur_rx_pkt_cdesc_count, head_masked;
 	struct ena_eth_io_rx_cdesc_base *cdesc;
-	u16 count = 0, head_masked;
 	u32 last = 0;
 
 	do {
+		u32 status;
+
 		cdesc = ena_com_get_next_rx_cdesc(io_cq);
 		if (!cdesc)
 			break;
+		status = READ_ONCE(cdesc->status);
 
 		ena_com_cq_inc_head(io_cq);
+		if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK) >>
+		    ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count != 0)) {
+			struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
+
+			netdev_err(dev->net_device,
+				   "First bit is on in descriptor #%d on q_id: %d, req_id: %u\n",
+				   count, io_cq->qid, cdesc->req_id);
+			return -EFAULT;
+		}
 		count++;
-		last = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
-		       ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
+		last = (status & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
+			ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
 	} while (!last);
 
 	if (last) {
 		*first_cdesc_idx = io_cq->cur_rx_pkt_cdesc_start_idx;
-		count += io_cq->cur_rx_pkt_cdesc_count;
 
 		head_masked = io_cq->head & (io_cq->q_depth - 1);
 
+		*num_descs = count;
 		io_cq->cur_rx_pkt_cdesc_count = 0;
 		io_cq->cur_rx_pkt_cdesc_start_idx = head_masked;
 
@@ -260,11 +273,11 @@ static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			   "ENA q_id: %d packets were completed. first desc idx %u descs# %d\n",
 			   io_cq->qid, *first_cdesc_idx, count);
 	} else {
-		io_cq->cur_rx_pkt_cdesc_count += count;
-		count = 0;
+		io_cq->cur_rx_pkt_cdesc_count = count;
+		*num_descs = 0;
 	}
 
-	return count;
+	return 0;
 }
 
 static int ena_com_create_meta(struct ena_com_io_sq *io_sq,
@@ -539,10 +552,14 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
 	u16 i = 0;
+	int rc;
 
 	WARN(io_cq->direction != ENA_COM_IO_QUEUE_DIRECTION_RX, "wrong Q type");
 
-	nb_hw_desc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx);
+	rc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx, &nb_hw_desc);
+	if (unlikely(rc != 0))
+		return -EFAULT;
+
 	if (nb_hw_desc == 0) {
 		ena_rx_ctx->descs = nb_hw_desc;
 		return 0;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 4d7446bb66b771..60d8d2d99af14d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1335,6 +1335,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	if (rc == -ENOSPC) {
 		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
 		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
+	} else if (rc == -EFAULT) {
+		ena_reset_device(adapter, ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index 1e007a41a52564..23466d62fbc5c5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -21,6 +21,7 @@ enum ena_regs_reset_reason_types {
 	ENA_REGS_RESET_USER_TRIGGER                 = 12,
 	ENA_REGS_RESET_GENERIC                      = 13,
 	ENA_REGS_RESET_MISS_INTERRUPT               = 14,
+	ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED	    = 16,
 };
 
 /* ena_registers offsets */
-- 
2.39.5

