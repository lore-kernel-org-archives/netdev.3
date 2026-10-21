Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591513;
	b=YZTYK3Omy3Sx8A3yw/KKdTMQhIeLh5/diSmGhGhhnochG7yxOYqLaK5krN31T5ZCYhF0
	 ncEUkkeepmHmLo4BN82CXlTKzKQc9poASTssOsDP8BiMae/r6nf34H42ehWefI3ANIMfL
	 YhRBONoZqVnK9qV2KmGwW+Jv0kdF0A00O0ZZCyVOTC+QfYb3RfAuDkhgLia1mMim+scoV
	 KTcPkmMQ6nzKXh9ibfmiw+qdey6slJZTyzMa6q0dLx5LqfqLUQO2XO+TjQNVQaiwdY/YZ
	 gLQQIubSQHardrz24Mmo0jHdOBCG2n6iCjVGpKA8fx/cz09cWPEekAHmlNdd+3O+RFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591513;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=FrXrhGc84F0SEW6ngQZtjtWKdGiIcLodKB76mx9Tm3A=;
	b=rtofw81Zz75CS01Fvdd0gEjU+5HaodscVAPCnRACiGZR9DFIpCu4fB4ZkEaVVBo1T/nB
	 l/8rJbcVAAD8PptD6Z4Nh1IKa6i3Pj8yTdtQo5so13m3C++HwLHLTIw+KCWMRjXL/6meU
	 2wVw4gH1+eo+VfJNmUUkwfgVOY27Q210LJ6BmcAXjdc4zybTDMoH/TcpfmUrvnT3Vaf/A
	 A8DDf4pCwsjQBz4cq1JmxK0wxnE2h7V3rzzuEo58WfD0sUwjafuHrqm9XDZutth6o9TIf
	 rYxq65p17UqUglmc39ZirT9k0NRu4Tu/sa8whiI4B56Y+jJmprthIh5ZEx+Zi8avCsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=LnDF2sZJ;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EE606A321;
	Wed, 21 Oct 2026 14:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21EE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=LnDF2sZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792591518; x=1824127518;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yW1XgpoWielDMW3UIfBB+wESIDB5LYWkKc7wBm5oMgY=;
  b=LnDF2sZJFDEQqQPIkMpFyGxjstKmffU5nqrJzNStEzSdJQCEaJ3JJUaU
   I10Dr1kQbfcARXpiNGntNRsWrSjbkhmO/NJ72DXojw6aO1ePl5gHTpT+H
   Jq/6DXURLG1qKjlzov8UnZ6OBkA8xNYcjwB1DIALwzV/JaM1SJam7VXai
   N+odYh0aa7fA8+iGPjrCM3GYbxuqCjnlRt0i5GFnAlOzOu2O88xVGB6oU
   kYAOFhxXtkGQNMR5hkZpQxVG1pk+rE5yDapYPaUzh06g3CGANHcrHWZGU
   Nal5xirHZqqwReo6VO/2ihLeon+XRBXldgun2qMNKeQpMSpZaHlv4NvAS
   A==;
X-CSE-ConnectionGUID: u22Z2VIBR/KVsPTy3Nax2Q==
X-CSE-MsgGUID: oZgFHj/kSEKlmX0aTh2m5A==
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="75812527"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2026 07:05:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 21 Oct 2026 07:05:11 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 21 Oct 2026 07:05:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 21 Oct 2026 16:04:59 +0200
Subject: [PATCH net v2] net: sparx5: fix tx DCB index drift in fdma xmit
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
Message-ID: <20261021-sparx5-fdma-last-dcb-v2-1-7b8fabdb9239@microchip.com>
X-B4-Tracking: v=1; b=H4sIAIrG2GoC/22NwQqDMBBEf0X23C1uqKnpyf8oHmKy1oVqJBGxi
 P/eYK89vhnmzQ6Jo3CCR7FD5FWShCmDuhTgBju9GMVnBlUqTSUZTLONW4W9Hy2+bVrQuw5ZcX0
 z1N19rSFP58i9bKf2CRMv0OZwkLSE+DmvVjqrn1WV/60rIWHfGWsqTUZ734ziYnCDzFcXRmiP4
 /gCgxSEp8EAAAA=
X-Change-ID: 20261019-sparx5-fdma-last-dcb-e2e8491b7d86
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_fdma_xmit() advances dcb_index before checking that the FDMA is
done with the DCB, and does not undo the advance when the check fails.
Before commit f4aa7e361ae2 ("net: sparx5: use FDMA library for adding
DCB's in the tx path") the next DCB was always the one after last_dcb.
Since then dcb_index drifts one DCB further away from last_dcb on every
failed transmit.

While the ring is full, this drops frames even though completed DCBs
sit behind dcb_index. After a run of failures, dcb_index can also land
on last_dcb itself. Re-adding last_dcb loses the frame, because the
FDMA has already passed the tail of the chain, and that DCB is never
completed again.

Fix this by making dcb_index the next DCB to use, and advancing it only
after the DCB has been added, as the rx path does. dcb_index and
last_dcb now only move together, so dcb_index always points at the DCB
after last_dcb.

The issue was found by an AI code review agent. It was reproduced on a
sparx5 PCB135 board with a modified kernel that forces 63 consecutive
transmit failures. Afterwards, about 1 in 64 frames is lost for good.
With the fix, the same test loses no frames.

Fixes: f4aa7e361ae2 ("net: sparx5: use FDMA library for adding DCB's in the tx path")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Advance dcb_index only after the DCB has been added, instead of
  rejecting last_dcb. This fixes the drift itself (AI review).
- Reword the subject and commit message to match.
- Link to v1: https://lore.kernel.org/r/20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index dbe86f937b21..15ec9b053824 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -217,7 +217,6 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 	struct fdma *fdma = &tx->fdma;
 	void *virt_addr;
 
-	fdma_dcb_advance(fdma);
 	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
 		return -EINVAL;
 
@@ -235,6 +234,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 		     FDMA_DCB_STATUS_BLOCKO(0) |
 		     FDMA_DCB_STATUS_BLOCKL(skb->len + IFH_LEN * 4 + 4));
 
+	fdma_dcb_advance(fdma);
+
 	sparx5_fdma_reload(sparx5, fdma);
 
 	return NETDEV_TX_OK;

---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-sparx5-fdma-last-dcb-e2e8491b7d86

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

