Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE81A9F88
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725039; cv=none; b=Yx7G7ZOePFAmMyR9ktjcNkPXY0IzdHWazmkXJp0VIPuB5gorhQJWveW8fRG8OBZncpUKhFRhp2peBO4M7CucZdl6BrRNpaY16zjgO/UryzNjIUWH5CRH637QiPCzhsOOEicBODCZhNSTUgAF5gShTE2ZVMEucvyii2sOo+9h5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725039; c=relaxed/simple;
	bh=z7SkIp9z+bRtbbNXb03wvDdYtpeVVyvfRF8vBgvn8nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CrLwvU8BphpGXX+SJRDUj1qv05jUK9OLOfXXZEjaytCDoSTkwiDrOTiH0MUU2/j1w6sjbFh35rSTjMmk5q9WFzZH5/qiwU8nCXMCwZ0ZKWDD2TUXB3WcYj/QkB7z6YYoSc+YxEJO1iJZlpmcsb94IiiCJp5XIqiQ1zyd+JzhMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc4pfBcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc4pfBcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A21F00893;
	Sat,  6 Jun 2026 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780725038;
	bh=Qd5esQLYkEp9qLYF3uDQurNkA79QQQMRr7j4ojvsKBA=;
	h=From:Date:Subject:To:Cc;
	b=Yc4pfBcr8gFeMuG0vq66p8dzpYN9BM+hwza4eVwJDCz1PwmKRHWTM7lvahzg5v7KT
	 RDBqACQW8/eUYCkoKaOfkXIXwiU4LVYkvPRYVVlWQib+JSPY5UoxTzsd/xh2KYQbhk
	 A4wOwSJ6i3mKIuGu0URERl3ePZcJbmtUhvWxcQ0epTP4G0QOH+ow62bu9mchPZrRAD
	 xdijExBBMS3kfET120DVOjbOaeQeZxFLDqaOZP3I5oXEUWo8nQf02a4w6eJhdjBlTl
	 JTXTQOesP1SdzBIfffPC18UsjJuwbozUl9uym1Ma+pryWMuVBMjiyuKcxNIRN+On/v
	 abdb6qcbI1FDg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 06 Jun 2026 07:49:59 +0200
Subject: [PATCH net-next] net: airoha: Use int instead of atomic_t for qdma
 users counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ77kIMtoJfkSJrXHUPbjRJiyD+v
 UuZ0xxmLsichDN01QWJv5Ilqkn9qCCspAujTObgnX85A0lSXGk4po2Gj8UZNSKVuElA1z5dCH5
 s/FyDHfbEs5z/ew/KBZXPAu/7/gGNKAtYdwAAAA==
X-Change-ID: 20260606-airoha_qdma_users-no-atomic-0750cc2b42f1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

QDMA users counter is always accessed holding RTNL lock so we do not
require atomic_t for it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 drivers/net/ethernet/airoha/airoha_eth.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..a5fe08864fa3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1809,7 +1809,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
+	qdma->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
@@ -1863,7 +1863,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
 
-	if (atomic_dec_and_test(&qdma->users)) {
+	if (!--qdma->users) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
 				  GLOBAL_CFG_RX_DMA_EN_MASK);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..e89c2dff411f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -525,8 +525,7 @@ struct airoha_irq_bank {
 struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
-
-	atomic_t users;
+	int users;
 
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha_qdma_users-no-atomic-0750cc2b42f1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

