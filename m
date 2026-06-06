Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978C13A3ED
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729546; cv=none; b=IrEKcC6urvthRg/W2XAGPx+hJgRUumGVQUhbxFpCkI1LzB1Pj8dTOIa7bYZlc/SCggU9OLJsOLesXLrF2oSYm4fvcr/sEeozHTjXeI75dnwqkA59DMugDUmUjtf4hdn6naLhJnh8QxHLEIdFp0li+pDVrZ1c99Urir0kRqUtQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729546; c=relaxed/simple;
	bh=/lf38YXSMSIYNB+i13lAcVZtU1MxrKusBPkFAbH2Kzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hsprd3jD+YlEv2ufUWI6e2OYwus5B3TBn8HnSoJHr+1Sa/IfJIGOzePIe95W73zS0URf+MJqQdfaSpDlxBckwh0sjNjWKuqZz4YIxU+L3PdzMtcYp3t6N0ZdLFJlJU70r8VlgTMdZZm+CWaQFEEA5vVgVW/d70saeOb7OiwJ4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGbMGLGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGbMGLGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ED11F00893;
	Sat,  6 Jun 2026 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780729544;
	bh=7Hi26MYjuAXv+lAIB99rWxPcRNW1nP+Lo1MKB1YaTkU=;
	h=From:Date:Subject:To:Cc;
	b=JGbMGLGKIMpgpJuVJQoRvYr2BQs2XnS+wGt2NBV5McjAmRdKsv7nMt4SORrRDJpgj
	 6ZSToCUcsnGbADr13PgKubnSXjlW3vYHC6pGLB6H/tor1G1JZhIBm+kGNcPLIBWnRK
	 1QhbrBSkA8DjlLgWAo5XMos59sSxZ3pOdPodA6yXcTUqLZs0l6Pxcdv3dxokgGqwWs
	 nPMDbY56RxT29KjoQD6QwePPjU6H6PFiVc4bOSj2GVPw0f7ODiScfVfqDg8vxq0P71
	 VUz1zE+EfYSzYSbN+pTLWT6rBNflcdig9gsZM6FxYIxJfiryhF7NylC8FxxZIlY3a8
	 Ovo9F+CLHCTCw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 06 Jun 2026 09:05:24 +0200
Subject: [PATCH net-next] net: airoha: simplify WAN device check in
 airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-airoha-eth-simplify-dev-init-v1-1-f08f8e404049@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMBBF0V8ps3YgVqvgr4iLkLyaBzotSSgtp
 f9ukLs6m7tLQSaKPLpdMhYWTtZwPnUSkrc3lLFZetffXEs985S8oiYt/M4fjptGLEpj1SEOl3A
 PwbkrpC3mjJHrf/8UQ1XDWuV1HD/FReFHeAAAAA==
X-Change-ID: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
netdev is always registered before GDM3/GDM4. This means the explicit
check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
special-case of what airoha_get_wan_gdm_dev() already covers, since
GDM2 is always marked as WAN during its own ndo_init.
Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
which handles both the GDM2-present and GDM2-absent cases.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..b333a7b309c2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2004,18 +2004,10 @@ static int airoha_dev_init(struct net_device *netdev)
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX: {
-		struct airoha_eth *eth = dev->eth;
-
-		/* GDM2 supports a single net_device */
-		if (eth->ports[1] && eth->ports[1]->devs[0])
-			break;
-
-		if (airoha_get_wan_gdm_dev(eth))
+	case AIROHA_GDM4_IDX:
+		if (airoha_get_wan_gdm_dev(dev->eth))
 			break;
-
 		fallthrough;
-	}
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
 		dev->flags |= AIROHA_PRIV_F_WAN;

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

