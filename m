Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0B27466A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062574; cv=none; b=Pv+yTxdkO1LX+fNfAtXZyfVSlJ6BP0ZQDGG1LvwRMwaeLxP+bqOsV6evBNJyt7cjcvoYEVupavZBGmiZtB34f9TpIRQTJqDcFqDCqUqCW2PGqbYdeH1zzXXoNp10WDS1gtfiInUaWfjORZT2Y2929RSC+kn2SW+j2pZdoCrzhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062574; c=relaxed/simple;
	bh=HSP+YjEppydjmNhY6cPAGyqYkYcuc0up9ay51BSTG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dE2eXL1ZA+d9Pb23b6gpaEn+221wy7GhLza9gOUTZhSAoppYGSmMQj+BxmQ8nGbMAG76phtECtyvaavhz9bu9hr5KtMqiACc6wTWjp6ZzCiv5MkHYSZbUSWa5MAw9jWxly5JBp0CfbOyuCVUPNjPm+hN/yqu+9fEHedMz6Lq/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ky6m/nLw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky6m/nLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787062571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/NoeZ52MrmR0uCwDVdns3GpeyxwEQYZZ5F0lC/2T2fs=;
	b=Ky6m/nLwR7XybkFgQI9/fj54RVKwRZx3ZPm6dv8KEGhA+OEdmSuG6fQiEO5cBTDrXibOgd
	TehMkEQ20+UWNXl+rKI5nVm0/oEOVGDK+kKKDPtwpfHV0hiR/B3tg1VC27Ia8qarxH4lZq
	2DBxxLkoIhfTzDDTBuGAt2biozTMMoA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-wDTZUXNgN8-Xpu1nSVTlXA-1; Tue,
 18 Aug 2026 10:16:08 -0400
X-MC-Unique: wDTZUXNgN8-Xpu1nSVTlXA-1
X-Mimecast-MFC-AGG-ID: wDTZUXNgN8-Xpu1nSVTlXA_1787062565
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DD9C19540DC;
	Tue, 18 Aug 2026 14:16:01 +0000 (UTC)
Received: from tokka.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060F8180034C;
	Tue, 18 Aug 2026 14:15:59 +0000 (UTC)
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
Subject: [PATCH net] bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check
Date: Tue, 18 Aug 2026 10:15:56 -0400
Message-ID: <20260818141556.64303-1-thwalsh@redhat.com>
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

Gate the call to pcie_enable_tph() and setting of bp->tph_mode
behind BNXT_SUPPORTS_QUEUE_API(bp) to ensure TPH is only initialized
on devices capable of supporting queue ops. This prevents a guaranteed
-EOPNOTSUPP error from occurring due to NULL operations.

Fixes: 1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
Suggested-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Thomas Walsh <thwalsh@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1e4944f3e606..9a2bbfa38f76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11920,9 +11920,11 @@ static int bnxt_request_irq(struct bnxt *bp)
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
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
-- 
2.55.0

