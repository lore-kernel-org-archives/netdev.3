Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6830F555;
	Wed, 28 Jan 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615099; cv=none; b=YTg5nx+HwTc4LIlnCzY5zwGm7ULgJnf4Jbpq+7zwTyj1jUx3/6EFRw1XSeVdzqkF7ADSWbavauXgkl4tlwbP+b/NlspFMBFxp0Y3Ov3IdbuLDuZtqusAARuqDd0lbvfa8qc1Bn8M3LHff06tleYd4u0Q1mO2DQotcbiepleSmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615099; c=relaxed/simple;
	bh=4ohvm5fhYBh6VZdJuEVdOpHMU7B4aefcxRQthZ1EpU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggk65Zzk7etleefKhPTRkvxB/krhkiTlvXskbpOeS0vzbOHUydQBF3DUtbykI4scaQVta4kGGGHr5QT2a+iTUJLvYaV9i3CbLFwX8CgskuozCe9B+F79JrLkHHXwm4QONJ0C+wN5aFbDxv5tdn+gHkU1f3AjwTaIhQDsL1tPbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=K+iLZ2zq; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="K+iLZ2zq"
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 324da1fd9;
	Wed, 28 Jan 2026 23:44:48 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kory.maincent@bootlin.com,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v4 3/3] net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup
Date: Wed, 28 Jan 2026 15:44:40 +0000
Message-Id: <20260128154440.278369-4-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128154440.278369-1-zilin@seu.edu.cn>
References: <20260128154440.278369-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c054759fa03a1kunm1b02b57ddb3e5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEIeVh5LHU9OGRpJTU8dTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=K+iLZ2zq+W/jQd+hyYK8k3Nm7/eBuO+AT41YW+pX3UYqMLCyy2bfKC+oBCm4AuDpRefN+7j9CJ+D+0VQHyDyXlJMBjvWC1HaX3j5biclLp1A6iTR/YryHD44HXQO9m12EuSwRukht119UzFZXBSPkNSsjAbs2VCs0Oxd3G0wCDc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=CBdMc180N7C4v3ADEW9t7d40OZ9GfRgKpYtOHjIS0Ys=;
	h=date:mime-version:subject:message-id:from;

In setup_nic_devices(), the initialization loop jumps to the label
setup_nic_dev_free on failure. The current cleanup loop while(i--)
skip the failing index i, causing a memory leak.

Fix this by changing the loop to iterate from the current index i
down to 0.

Compile tested only. Issue found using code review.

Fixes: 846b46873eeb ("liquidio CN23XX: VF offload features")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index e02942dbbcce..43c595f3b84e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -2212,11 +2212,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 setup_nic_dev_free:
 
-	while (i--) {
+	do {
 		dev_err(&octeon_dev->pci_dev->dev,
 			"NIC ifidx:%d Setup failed\n", i);
 		liquidio_destroy_nic_device(octeon_dev, i);
-	}
+	} while (i--);
 
 setup_nic_dev_done:
 
-- 
2.34.1

