Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022432;
	b=lMLIBkOVbs7CsqGWmEefdnYTEiUOr7iT3BJ5DeHfzP1bxG8lzGqYx2fdNjXCzlGNSehP
	 CkWm4vkxt7EZJjyN9iTXNt7W5Sxk2lgMSAaFsp0czP433n0MouYuCiKN3e88YsTt+7O3x
	 +fXwRU6mT+keocVR2TcTsASgwzDGTFV9otWo/4yoAx7WihIu4TgBD+zi7VF0KMhd9Mfms
	 H2MmUz0tlQaVq/wIG/F+sZR8vXrbotFc4Ar/t6r5z7DBtKx+d0EC15HDaE+Yx80nCXjVo
	 y9lvKi9LG3hKv/n90f4kmh9a3E6Kj0Wrbuxu/6+euhlxRdEwMTQNhY+P8XN1xU288NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022432;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=CMDpq3SX25eoltOh6fRlQWDgSOu/p9POGr2uOh69ti4=;
	b=YizgcXWqXtNA81uf2tthRdq93iWpNdYyT01UyVZe7StjDJTJoNYdlm9AGwdnR7B69s8c
	 +AGvi9PCbPFfFhvZyA1LipxkbALE5/6oh9B4wuq24teG7104m3Qp+F90obBFYUXCp5gzJ
	 wXVofUeyDjHayY0OgaUgZZIQaLTHeGwndbVhVV8ZzlXycAVweeFzsf6nOouIXVksEiURW
	 1gEARUiT/WPe4vMmrinuCuOM1Zt0RvBYd68/uKSdVWwwu2bKwNhPdnX/nV70xLtXNY7Q5
	 SL0KSY3DKwZtYEnfDk4kr2n9ht5j+bGp7i3FLhkrVVZbin9LQRYHqY08fiwHRkNl7KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rCRpc4N3;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20516606A325;
	Mon, 26 Oct 2026 13:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20516606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rCRpc4N3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022432; x=1824558432;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=FZSsuCVIS62A5Iur16KkQlWqBTNAz42t+vGvyVs+4/g=;
  b=rCRpc4N3Cy7F6zoBe5sJNI/SqAPzF9UR8x2mZ7gSwXKO5GLAFIWxj/fn
   /FwrnaZrxbXGk/csNR9dehtvBwAf7B+vw3eWAYGDC/QtGSz0tlsSFM+TB
   40zIrw7yXI9Arhe3GlqdQ0iI1xr4UxX3I9ZV5oxuSgScLLpCqmWxjgeYD
   LpdEc3uegNpqv44+RN3P2ljM/N1VOVyQZ+8NdkTm9lmtwRz4RjyhtbMaB
   2e9NYAezLMPiaKh5HsHariLqYvaJKuL/LzxPKUR1ZEg11kSnD2t8MfOV3
   9+J2JAC27CPeUjU1DHCzCbvK6EOCwnjdN8cKeHcARBLwdN/GD9N9n+Lq1
   A==;
X-CSE-ConnectionGUID: R18wWG9GScO7v44QD2uZqQ==
X-CSE-MsgGUID: 05SZEdVXT8GhKjkO5jeCGQ==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="76044859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2026 06:47:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 06:47:10 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:47:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:47:05 +0100
Subject: [PATCH net] net: microchip: fdma: fix DCB corruption under
 sustained load
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-microchip-fdma-dcb-corruption-v1-1-36dab6caca07@microchip.com>
X-B4-Tracking: v=1; b=H4sIANhZ32oC/x2MQQqEMAwAvyI5G7BFBPcryx5smq452JbUFUH8u
 2EPc5jDzAWNVbjBq7tA+ZAmJZu4vgNal/xllGgOfvCTM3AT0kKrVExxWzBSQCqqv7pbiVNI4+D
 DPAfnwR5VOcn5/78h8w6f+34AthLrJHQAAAA=
X-Change-ID: 20261026-microchip-fdma-dcb-corruption-6bf402b99b12
To: Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

__fdma_dcb_add() prepares a DCB and links it into a channel's chain by
writing its address to the NEXT_PTR of the current last DCB. The FDMA
may be processing the chain while this happens.

Before this patch, the link is written before the new DCB's own nextptr
and info fields, so the FDMA can follow it to a DCB that hasn't been fully
prepared yet. Under sustained load this stalls the FDMA.

Prepare the new DCB fully before linking it, and update the previous
DCB's NEXT_PTR using the two-step sequence from the datasheet (poison
the LSB and flush, then clear it) so the FDMA never observes a
partially-updated pointer.

Reported by a customer running iperf3 --bidir against a lan969x board.

Reproduced on lan969x with iperf3, throughput collapsing to zero:

  [  5]   1.00-2.00   sec  73.9 MBytes   620 Mbits/sec    0    305 KBytes
  [  5]   2.00-3.00   sec  73.9 MBytes   620 Mbits/sec    0    305 KBytes
  [  5]   3.00-4.00   sec  13.9 MBytes   116 Mbits/sec    2   1.41 KBytes
  [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
  [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
  [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes

The race is timing-dependent: across three reproductions the stall
appeared anywhere from ~400s to ~3000s into the run.

Fixes: 30e48a75df9c ("net: microchip: add FDMA library")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/fdma/fdma_api.c | 30 ++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
index f7a42348e932c..fed41da550c59 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
@@ -43,9 +43,19 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 				u64 *dataptr))
 {
 	struct fdma_dcb *dcb = fdma_dcb_get(fdma, dcb_idx);
+	struct fdma_dcb *prev = fdma->last_dcb;
 	u64 nextptr;
 	int i, err;
 
+	/* Per the FDMA datasheet, adding a DCB to an active channel takes
+	 * three steps:
+	 * 1) Write NEXT_PTR of the current last DCB with the LSB forced to
+	 *    FDMA_DCB_INVALID_DATA, and flush that write.
+	 * 2) Clear the LSB to complete the link.
+	 * 3) Reload the channel (FDMA_CH_RELOAD); this is done by the caller
+	 *    once the chain has been extended.
+	 */
+
 	for (i = 0; i < fdma->n_dbs; i++) {
 		err = __fdma_db_add(fdma, dcb_idx, i, status, db_cb);
 		if (unlikely(err))
@@ -56,13 +66,25 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 	if (unlikely(err))
 		return err;
 
-	fdma->last_dcb->nextptr = cpu_to_le64(nextptr);
-
-	fdma->last_dcb = dcb;
-
 	dcb->nextptr = cpu_to_le64(FDMA_DCB_INVALID_DATA);
 	dcb->info = cpu_to_le64(info);
 
+	/* On the first DCB of fdma_dcbs_init() prev is the DCB itself;
+	 * don't link it to itself.
+	 */
+	if (prev != dcb) {
+		/* Write NEXT_PTR of the current last DCB with the LSB forced
+		 * to FDMA_DCB_INVALID_DATA, and flush that write.
+		 */
+		prev->nextptr = cpu_to_le64(nextptr | FDMA_DCB_INVALID_DATA);
+		dma_wmb();
+
+		/* Clear the LSB to complete the link. */
+		prev->nextptr = cpu_to_le64(nextptr);
+	}
+
+	fdma->last_dcb = dcb;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__fdma_dcb_add);

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261026-microchip-fdma-dcb-corruption-6bf402b99b12

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

