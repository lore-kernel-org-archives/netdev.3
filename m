Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6944D4871;
	Fri, 16 Oct 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162957; cv=none; b=erYFcA7VRB/yuhdJX/O9b99LkYT0ROGawdtpBQAUkOgOZy5wWvFgVVbUhNnH+P4ZRfplZyvkO6F82TAPIJv3hhgivxkShKGnj8snoAQ/BUNd1vOZ0HX0XOXRKX7LoLM5Grxnj+FE2xsD0UZiMHGiB2sq7wKd7jjEC9vtAxezLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162957; c=relaxed/simple;
	bh=jYoztW5ZAzdHi8HfincA4CFV9xX3X9eAwegE7CacxUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3lrvjFXee5eqTrrTxeIOtMnlhVqvrYffsnD0UgilzwXpBRbm7M3C+kbCEjSdEV6sP5pH3HksRCXISWSO6B9RMAfjLbc6nzFanKaNvkEfz749XpfJgjZYGtTq9iabGaamjQvtlBAM1gSeuFp2HzDwHpXtJah+D8ErQNrYA1CmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=RZj8V53v; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="RZj8V53v"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id CA91E240C26;
	Fri, 16 Oct 2026 17:02:25 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 261B72405E1;
	Fri, 16 Oct 2026 17:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792162943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/FP0aSKPLpVvvZrQy0imcxS48xnjj4SOrgBH9s2RA0=;
	b=RZj8V53v/zQC18Vt189wCgf0FE8V1nNuWEoePjIkdg+bDuaz6KxbPztkUIyhvba/OMkE53
	BVNqXocq9TFjaCcpYKUM8k2X8nPIvOBqjS9+BBDyHAryL/f9e3HrSky1Lss5eD54BO1/qJ
	BFDPYOmOd5LpIKf/s2QgRZP96VZLoZzVxtNHOqgsYv9EmMQxnNLa6cl5/WauoL0tWdj2Ol
	EDpcZw+YG/2jIUmUeKjE+ZN7tM7z7hBK8QlpBkcUi8Zq8yUGzZtQqkT7IV2DEe/Rd3Ch7o
	o10a4r3MlQkQVqXlKA2kXrjLHeSs0UWqXWgrIdv+Vfbj6SPl0BcSgm4SN0aFcg==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id CAF0D2404EF;
	Fri, 16 Oct 2026 17:02:22 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: jie.luo@oss.qualcomm.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net 1/2] net: ethernet: qualcomm: ppe: Fix multicast queue admission control access
Date: Fri, 16 Oct 2026 17:01:39 +0200
Message-ID: <20261016150140.929729-2-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016150140.929729-1-mail@tk154.de>
References: <20261016150140.929729-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 56a7c3

Multicast queues have global IDs 256 through 299, but their admission
control table has 44 entries indexed from zero. Using the global queue
ID accesses registers beyond that table, leaving the multicast
thresholds unconfigured. Subtract the unicast queue count when
addressing the multicast table. Keep the global IDs for enqueue and
dequeue operations.

Each multicast admission control entry contains three words at a 16-byte
stride. Limit the bulk accesses to those three words instead of
accessing five words, which also reaches the next entry.

The indexing issue was reported by Sashiko.

Fixes: 806268dc7efd ("net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574")
Link: https://lore.kernel.org/netdev/179143027873.434549.15034517641240789690@kernel.org/
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 125b73be92b1..95b29db45580 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -1474,7 +1474,7 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 {
 	const struct ppe_qm_queue_config *queue_cfg;
 	int ret, i, queue_id, queue_cfg_count;
-	u32 reg, multicast_queue_cfg[5];
+	u32 reg, multicast_queue_cfg[3];
 	u32 unicast_queue_cfg[4];
 	u32 group_cfg[3];
 
@@ -1530,8 +1530,11 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 				if (ret)
 					goto qm_config_fail;
 			} else {
+				int mc_queue_id = queue_id -
+					PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES;
+
 				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
-				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
+				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * mc_queue_id;
 
 				ret = regmap_bulk_read(ppe_dev->regmap, reg,
 						       multicast_queue_cfg,
-- 
2.56.0

