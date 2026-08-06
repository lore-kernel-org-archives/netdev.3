Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8553EB106
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047760; cv=none; b=u+YvxlGNm0BnLtvUs6pKRbqUmSMbgx3o0A+kL8qiQQQJUrn3GQFBQ8+V0iG49B2ni1l3FbKb/brwMPjgw5fXJsDXS5PpmYRqPZCkzKJFMOaaZJvH8AYlVMfKYCJcRagTmxNni8HSUDq4nfcPVZWWVWld6JlOBH7n3SS/+7oAIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047760; c=relaxed/simple;
	bh=Gez05llZiKy/G8J7WnNS+nYvyAAxYBB9QJy80qsmAns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inIxdTW9wXBOPMS6RcPq/xxJj3tRiUEsYmJCci32nrtX2S6hdHmxB0ywW2+jUXMeUEn4zj6k9fNqa6oT/GJf7dfah8JRv/oPXbk6BenYNOGZEtNbBMJIhM+gIAUrTPapWoM3osaCRuDnhDnBOWwXm7jP8dpFg7NSbNXucP2brLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWEjEXkS; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWEjEXkS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786047755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQ+M6asN6ba0YV9KzkpF3DYr2IiuGmYABAjtvcgOS0E=;
	b=lWEjEXkSiEahak79mLmzg/Zl7AxvJn5N9cXbJ67lI9sKuO7iDFYbMxt9V4JDmOXZ+Ynckq
	6GlnC/vlJn69uVf0LFsQTkILNrCdmUORKR7ykKm3UHN46GNAhi+L0D6O6s96Z644lAR0oI
	yF4qt58jZQbhvmJDywwCfAtfeVCvnpY=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net] bnxt_en: enable PTM function
Date: Thu,  6 Aug 2026 20:18:49 +0000
Message-ID: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The patch mentioned in Fixes missed one main point of implementing
proper PTM support. To make it fully operational it has to be explicitly
enabled. Add missing call in probe callback and disable it in teardown
callback.

Fixes: c470195b989f ("bnxt_en: Add PTP .getcrosststamp() interface to get device/host times")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 25099077fe4f..8a9c7646b53f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14978,6 +14978,7 @@ static void bnxt_unmap_bars(struct bnxt *bp, struct pci_dev *pdev)
 
 static void bnxt_cleanup_pci(struct bnxt *bp)
 {
+	pci_disable_ptm(bp->pdev);
 	bnxt_unmap_bars(bp, bp->pdev);
 	pci_release_regions(bp->pdev);
 	if (pci_is_enabled(bp->pdev))
@@ -15546,6 +15547,8 @@ static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
 		goto init_err_release;
 	}
 
+	pci_enable_ptm(pdev);
+
 	INIT_WORK(&bp->sp_task, bnxt_sp_task);
 	INIT_DELAYED_WORK(&bp->fw_reset_task, bnxt_fw_reset_task);
 
-- 
2.47.3

