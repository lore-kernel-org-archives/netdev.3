Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6D231A3B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263569; cv=none; b=eTNXfOSCu332JRlCP7LU00ddorShAQd9G2wX/gqtoMy5SErf16nlqiNxTt2N3MWKLc4/UBlhGc1JsB2W2+Wx4nyzzCX0XMXNVSH+m2lt+ZDIzsR+toZS4vcdPQ1OodenWW40Q4HW1SKD04r7ugB7CfLARZ0pNFNvzY9pRuBRngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263569; c=relaxed/simple;
	bh=dD13UkGfcPZNbD79K9GXyXffJjKMgiNpho1msYOG8BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7myGnw1nH0kUbpNGwRmbF/p4BWTJbZ/MnPCTDZOxKSoNXr6cE6wn+WBR6tO7ck5G1GtQjJuCGWy5wJobplKE+Mdw9ehCosjQ5cuXq8H/Au6FZaukXwoZQj1AggP6I0TmGR/Ndthskq34iMHtZLHqT9VWUISVQvpy5rhgeRoTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9w3hxh2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9w3hxh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787263566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lBCqBsTXomNoN7l1FC6bHoUAUjFGXpi8oElm1Kq3dv0=;
	b=U9w3hxh22+BBLyNgwXlwTdA5moSUAbdEsOqI099aZVttozv/omh8WidA+KsVN2NY2SZMEb
	h+P4cxSvtUMditXOB2dpSROYgYdL5y2nxdsYFJijG1PWPuDn3R+F5eEpAvcIfYfWjL4wG1
	Fogq5RH7lgWjcqE4k1zEDR3Di/MTQ4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-awuLMl_IN6-tH65WWTWM_A-1; Thu,
 20 Aug 2026 18:06:03 -0400
X-MC-Unique: awuLMl_IN6-tH65WWTWM_A-1
X-Mimecast-MFC-AGG-ID: awuLMl_IN6-tH65WWTWM_A_1787263561
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AF3D1956040;
	Thu, 20 Aug 2026 22:06:01 +0000 (UTC)
Received: from tokka.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1963180034F;
	Thu, 20 Aug 2026 22:05:59 +0000 (UTC)
From: Thomas Walsh <thwalsh@redhat.com>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Walsh <thwalsh@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net v2] bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check
Date: Thu, 20 Aug 2026 18:05:44 -0400
Message-ID: <20260820220544.1240879-1-thwalsh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In bnxt_request_irq(), pcie_enable_tph() is called unconditionally to
enable PCIe TPH when setting up interrupts.

If the NIC hardware or firmware capabilities do not support queue ops,
attempting to enable TPH during bnxt_request_irq() is unnecessary.

As a result a flood of "RX queue restart failed: err=-95"  messages is
seen upon boot.

Older NICs (pre-Thor / BCM57414) do not support TPH or queue management.
TPH requires queue management to restart the queue.  NICs that support
queue management (with updated FW) all support TPH.

Gate the call to pcie_enable_tph() and setting of bp->tph_mode
behind BNXT_SUPPORTS_QUEUE_API(bp) to ensure TPH is only initialized
on devices capable of supporting queue ops. This prevents a guaranteed
-EOPNOTSUPP error from occurring due to NULL operations.

Fixes: 1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
Suggested-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Thomas Walsh <thwalsh@redhat.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
 - Updated commit message to include context on hardware support 
   and added Michael Chan's Reviewed-by tag.
 - Rebased onto net/main.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9377bf675981..abe24d749cc2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11946,9 +11946,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 #endif
 
 	/* Enable TPH support as part of IRQ request */
-	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
-	if (!rc)
-		bp->tph_mode = PCI_TPH_ST_IV_MODE;
+	if (BNXT_SUPPORTS_QUEUE_API(bp)) {
+		rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
+		if (!rc)
+			bp->tph_mode = PCI_TPH_ST_IV_MODE;
+	}
 
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		struct cpumask *cpu_mask = bp->ring_cpu_mask[i];
-- 
2.55.0

