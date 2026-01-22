Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D445313E0F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043096; cv=none; b=odzjlqUuTRS1KQMLJ9zIj51exa54sobiflAdFjqkl0xIS/0RSvpdKa0vAq25+wCSSi/3lsMKuvsVoZFtRFIpiFguzL55lZ6wtPy+m23NOaU8UtcJgxWNXAWgi6fuahc68E+r4SwJu+pDoEXXi9FMJQiSeJGyVkMfKBXM1/qDiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043096; c=relaxed/simple;
	bh=HAkLwHnKtoXhBRVynLcvKOlz3q//Vn+K6euzyBzQb30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5C+eOM3lt7Qv/BpZlOBxy56F99ug1yeoboROlmL27pBGy/Nh/cyPNvowgkmqdpKtrPjVvJ+y1MVVy2sb0lH1vY+g1dKmgSIZSVlYN8Y3lLy2snwIChmkq28qYOvuqXkv8olCXnOAhlSySVl+K9vTMutVAMHvc8BGern5QLL658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPPeQsOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPPeQsOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E4C19425;
	Thu, 22 Jan 2026 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043095;
	bh=HAkLwHnKtoXhBRVynLcvKOlz3q//Vn+K6euzyBzQb30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPPeQsOue/wKCD6nbyNTAn+n0mXwIWimvLsq4CtBV8syDwsCIgWhiNudipp5KXQl+
	 H53OfpWsscrLrcWKUd8L7mCwikA6oHBRzL+q/MkJY8YjfBi08H6wJfUVZ+ZXXdrKXs
	 EVBTtcnX9bP8ENjthnQOE6xLpGqQPKyhpIaYDVjjsfYVYB6MdWLiBb/4auprHGeMdt
	 HroAxPZqgaTWiQ/zPK2D5Iem8OM/wEbLP0D79RWy7D/ungCFtsTGF5FtKG2qgeDImx
	 W45hjm2K3/Fhhg2u78zozl/T698Op1KiJutzKdWYP3bgDUBHJcQ/USlnSY3QzPQ2+5
	 Ohr3n3rYp4lmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] eth: bnxt: plug bnxt_validate_qcfg() into qops
Date: Wed, 21 Jan 2026 16:51:13 -0800
Message-ID: <20260122005113.2476634-7-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122005113.2476634-1-kuba@kernel.org>
References: <20260122005113.2476634-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Plug bnxt_validate_qcfg() back into qops, where it was in my old RFC.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d57e833ce690..8fc0720c3057 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15983,8 +15983,12 @@ static void bnxt_queue_default_qcfg(struct net_device *dev,
 	qcfg->rx_page_size = BNXT_RX_PAGE_SIZE;
 }
 
-static int bnxt_validate_qcfg(struct bnxt *bp, struct netdev_queue_config *qcfg)
+static int bnxt_validate_qcfg(struct net_device *dev,
+			      struct netdev_queue_config *qcfg,
+			      struct netlink_ext_ack *extack)
 {
+	struct bnxt *bp = netdev_priv(dev);
+
 	/* Older chips need MSS calc so rx_page_size is not supported */
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 	    qcfg->rx_page_size != BNXT_RX_PAGE_SIZE)
@@ -16012,10 +16016,6 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
-	rc = bnxt_validate_qcfg(bp, qcfg);
-	if (rc < 0)
-		return rc;
-
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -16311,6 +16311,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
 	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
+	.ndo_validate_qcfg	= bnxt_validate_qcfg,
 	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
-- 
2.52.0

