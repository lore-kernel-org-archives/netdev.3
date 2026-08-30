Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C93AAF41
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788092926; cv=none; b=h3HBY3sHEVtD7wee/GLjSBEgnz//Kdk9VxUO12OAG6/y++r31keojHpnRrX9JVRdw1BqeV9GyR/W0FrTEujkehYddS+PbLjt9QRdGKnRoQAIWX6U4BRVgkiZAmFQtIQhbpSCAWpxGYRWdUcZSmyxgk1BD0K5vYoIjnZcuxTcHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788092926; c=relaxed/simple;
	bh=ycBhFtqGNFCr6uY9UYeVTe0XKNl1r2DQMWn2SP+mj3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ojugq6XtJwdN+0uJFaGiorEZ90jgPrL1H4bmHegfoXkZZJwKX4Sw3I+6jejkkXpqYAY2YtlWcaxbwgvuMsZ5QUT7MBM4D5SOmMNSFc6ErRRyrJoL5dlHqgmR53ZJLNCVLexoTxuzOIGkjFHQYDeZfD0J2mR/wJiAr+vgEiLFJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdPHKOW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdPHKOW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38CD1F000E9;
	Sun, 30 Aug 2026 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788092925;
	bh=giq0ZKRP+1aIgx6E+QNEKTdfQEpdLDHpMpAo/DOA7+o=;
	h=From:Date:Subject:To:Cc;
	b=MdPHKOW8/AN3VNoICdI9/e84pyIxOt3M0yYc3aZ2H+YpGYwpc11bwEcJ5xmx4wpJT
	 LNIPJjOBFA+9Xk94bDSr02Y+azPNY8s1tPFLu/8hrGzkVEJKwK0xnssn8L7aGSQFzT
	 4Sevm2gU8775M2uMblhTVzkSJKG4vinfn2AQhCsadjOTFm55zf+9mhIOScKv8fmNUX
	 IMXvbTK4Ze8yDDLPVbB2PtFQBb8LWHEnvnzDfRo3GvPE3a28XENhs2LlS2gxZDmFoE
	 8ZCRBW/pJObTVLdXebvKboLnsievDAat4Ql/gnWACowVH22dFfGyB4CPLm5/lJiid6
	 2UD/0eFdj/14g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 30 Aug 2026 14:28:27 +0200
Subject: [PATCH net] net: airoha: enable RX_DONE interrupt for RX queue 31
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TnAtKvpKdBDdci9aa0QQ/j3pN
 Mxh5oVMwpRhbl4QujlzilWwbcAFG3dS7KuD0WbQU6eVZUnBKnl8ilRxdqgMeoebdQbHHmp5CG3
 8/NcFIl2wlvIBQxFW02oAAAA=
X-Change-ID: 20260830-airoha-rxdone-rxq31-21dc1fac2174
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

RX queue 31 has always been allocated and filled by airoha_qdma_init_rx()
since RX_DONE_INT_MASK spans queues 0-31, but none of the RX_IRQ*
_BANK_PIN_MASK values covered BIT(31). As a consequence the RX_DONE
interrupt for queue 31 was never enabled, airoha_qdma_rx_process() never
ran on that queue and its buffers were never reaped.

Route RX queue 31's RX_DONE interrupt to IRQ bank 1 so that the queue
is drained and its buffers returned to the page pool.

Fixes: f252493e1835 ("net: airoha: Enable multiple IRQ lines support in airoha_eth driver.")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..8277c1c87bb3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -538,7 +538,7 @@ struct airoha_wdma_info {
 
 /* RX queue to IRQ mapping: BIT(q) in IRQ(n) */
 #define RX_IRQ0_BANK_PIN_MASK			0x839f
-#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
+#define RX_IRQ1_BANK_PIN_MASK			0xffe00000
 #define RX_IRQ2_BANK_PIN_MASK			0x20
 #define RX_IRQ3_BANK_PIN_MASK			0x40
 #define RX_IRQ_BANK_PIN_MASK(_n)		\

---
base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
change-id: 20260830-airoha-rxdone-rxq31-21dc1fac2174

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

