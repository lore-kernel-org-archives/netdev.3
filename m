Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84247415F1F;
	Fri, 16 Oct 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149621; cv=none; b=nndaKTqMUONdozQXwC8aPAeqVWf+6QgF+cH8VfaYhP7ciF2rT8KT1y0zIQ/1pmePVFVPrhPwbHE/C5IfIXIkZhyYMhE9itBqnOMdva2WfyZhWYXrdyVGeMgj/h+5q6ZQfCpxaBkH0LCRF9+G/Jno38ApirnBVmIR0q/d4aLSvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149621; c=relaxed/simple;
	bh=yC7/op8iHdXpBtfOBlqmSIfSNyxQdVW5x8XqgtLiVeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7vpiXp+z+7WT+JYMIIQzPqmtkDuL2lDCNDq3pqolBazXUyRVbJTBY9uy8ny/DAlvKzXbquH0+7K6piANS3cIPfZ17kWW2q1k2gCmD6qpQar8y1ClGDY20Q5RadsBmgzLsaKcgTJa26SGat3iF/I3jGnLjLhEfxBexlTUkMkWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=2kAsX4y/; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="2kAsX4y/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rhJI7F0zU+E/8xsIkBIN5MZPJE26Grg+5HNG9FQ1W7Q=; b=2kAsX4y/5GbY0reGuaB8BzWyQE
	As/CswEbTraGIaIcVuHy6YLEFtKTdg2nXf7aHrJdoY0Wg2P6PgMeRtJHmcIE9LKy8mgEJ3ZMSTuDD
	gEaJvL66/pUVTQiBSnr5DfEHYExnLgKdFMp5oJUQB1OUt0u96veNd5zZI2AV1Z4QKb1nhIfa6KRUx
	5imqGV+rS6ZHyg9XovESgdDR9WIdIachTCkzINYniuXMT493bS2wNs9yEsKk11WfNHuzpph9DBVxN
	JbD1bv1tZOwIUerHu2iGfvZF1xpalL0ZVUsPhop0tLT5box48EfWyFJ07nFXHhBRHlF2CC58aDFPo
	FKZBqtSw==;
Received: from [115.246.246.98] (port=28851 helo=bulbasuar.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <saivarun@couthit.com>)
	id 1xHfZP-0000000FERK-27cF;
	Fri, 16 Oct 2026 06:53:51 -0400
From: Sai Varun Mudepally <saivarun@couthit.com>
To: danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	afd@ti.com,
	basharath@couthit.com,
	horms@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	j-rameshbabu@ti.com,
	m-malladi@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	Sai Varun Mudepally <saivarun@couthit.com>
Subject: [PATCH net-next] net: ti: icssm-prueth: use dev_close()/dev_open() in icssm_prueth_change_mode()
Date: Fri, 16 Oct 2026 16:21:35 +0530
Message-ID: <20261016105206.167094-1-saivarun@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: saivarun@couthit.com
X-Authenticated-Sender: server.couthit.com: saivarun@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

In icssm_prueth_change_mode(), if ndev->netdev_ops->ndo_open(ndev) fails
and returns an error, the function aborts without restoring the NAPI state.
Later, when the interface is brought down, the kernel naturally invokes
ndo_stop() again. A second napi_disable() call on an already disabled NAPI
might trigger an infinite sleep waiting for NAPI_STATE_SCHED.

Use dev_close()/dev_open() so the core keeps IFF_UP consistent. If
dev_open() fails, close the ports already reopened and fall back to
EMAC mode.

Also undo the br_members update in icssm_prueth_ndev_port_link() when
icssm_prueth_port_offload_fwd_mark_update() fails.

Test Log:
https://gist.github.com/SaiVarun754/688a21038f1b2bd2b89d2db65224edb0

Fixes: eca327ae9aa6 ("net: ti: icssm-prueth: Add support for ICSSM RSTP switch")
Signed-off-by: Sai Varun Mudepally <saivarun@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 38 ++++++++++++++------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index b42c98e861e0..d50aa0992c33 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -1100,7 +1100,7 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
 	bool portstatus[PRUETH_NUM_MACS];
 	struct prueth_emac *emac;
 	struct net_device *ndev;
-	int i, ret;
+	int i, j, ret;
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		if (!prueth->emac[i]) {
@@ -1115,11 +1115,7 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
 		if (!portstatus[i])
 			continue;
 
-		ret = ndev->netdev_ops->ndo_stop(ndev);
-		if (ret < 0) {
-			netdev_err(ndev, "failed to stop: %d", ret);
-			return ret;
-		}
+		dev_close(ndev);
 	}
 
 	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
@@ -1141,14 +1137,25 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
 		if (!portstatus[i])
 			continue;
 
-		ret = ndev->netdev_ops->ndo_open(ndev);
+		ret = dev_open(ndev, NULL);
 		if (ret < 0) {
 			netdev_err(ndev, "failed to start: %d", ret);
-			return ret;
+			goto err_dev_open;
 		}
 	}
 
 	return 0;
+
+err_dev_open:
+	for (j = 0; j < i; j++) {
+		if (portstatus[j])
+			dev_close(prueth->emac[j]->ndev);
+	}
+
+	/* Fall back to EMAC mode */
+	prueth->eth_type = PRUSS_ETHTYPE_EMAC;
+
+	return ret;
 }
 
 /* VLAN-tag PCP to priority queue map for EMAC/Switch/HSR/PRP used by driver
@@ -1639,6 +1646,8 @@ bool icssm_prueth_sw_port_dev_check(const struct net_device *ndev)
 
 static int icssm_prueth_port_offload_fwd_mark_update(struct prueth *prueth)
 {
+	struct prueth_emac *emac;
+	unsigned long flags;
 	int set_val = 0;
 	int i, ret = 0;
 	u8 all_slaves;
@@ -1661,11 +1670,20 @@ static int icssm_prueth_port_offload_fwd_mark_update(struct prueth *prueth)
 	 */
 	if (set_val && !PRUETH_IS_SWITCH(prueth)) {
 		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_SWITCH);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(prueth->dev, "Failed to enable Switch mode\n");
-		else
+			emac = prueth->emac[0];
+			spin_lock_irqsave(&emac->addr_lock, flags);
+
+			prueth->br_members &= ~BIT(emac->port_id);
+			if (!prueth->br_members)
+				prueth->hw_bridge_dev = NULL;
+
+			spin_unlock_irqrestore(&emac->addr_lock, flags);
+		} else {
 			dev_info(prueth->dev,
 				 "TI PRU ethernet now in Switch mode\n");
+		}
 	}
 
 	/* Bridge is deleted, switch to Dual EMAC mode */
-- 
2.43.0

