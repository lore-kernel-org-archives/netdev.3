Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740463D3498;
	Sun, 18 Oct 2026 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296446; cv=none; b=lcZFedKeiAeSefMPKkO/9OzmqKXP6RSYQxu+ujTD3nF4Jo9H68sTZwRLgbS+U+3sHlzTmV1QAT7HlRi7Z+7qn314KBEjULwNVpdx0QgYlcdpPibH+ugPVakeMeYDRyeiL1hOmEGoeR3EqRfYAC1l5xXwAhd9aX1tYjrmkRWevPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296446; c=relaxed/simple;
	bh=V02QebQEHICC8E/12v8vbE2xk1/n++ep7v3y217CPqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDMS3/xSKJDfQb6WbufPmRP8qGXS+mY3GSwW1rtCxef+wHyElmJ3TMVnQw/N4xUeTGPltIMNRQzDK36kT7L+AO45fE1jQJwKB/2M6B6CaiXAv70mxacqiL//YtYDS7Stcolidz/eFP5iwAObhVX7oq5sontOlWptp1XGpY9diSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GeZ8x+vr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GeZ8x+vr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kb
	nVAWjJPxIQx9LhwxOpcLtEsxnx7yNsZEXcLXTFR6w=; b=GeZ8x+vrWPteEDuW4+
	Mi6MxzkvbSFvScJphvYzDMeB2RLNjuOMJ3r23HVSz+mvTLlTL0Fzxz28DR0c2QIs
	hbJHEMOJTDaLeeJSGei4sg4/mtq99fohzSchDglvUQjvJSDH1UdE2vWZX3tioN1k
	xu97+snC71AgQsW9Pu/noFuKM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3VxrSRdRq42uQAw--.5404S2;
	Sun, 18 Oct 2026 12:06:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Daney <ddaney@caviumnetworks.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] net: octeon: mgmt: drain TX cleanup tasklet on stop
Date: Sun, 18 Oct 2026 12:06:34 +0800
Message-Id: <20261018040634.533757-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3VxrSRdRq42uQAw--.5404S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr43Zw4fArWrJFWUJF18Zrb_yoWkCFcE9r
	sF93ZxZa17GwsYka15Kw4avw4FkaykXrs7Wrs2qrW3tFW7urn8Z39rWr9rKw4kWrW7ZFyD
	Cr43KryxC3y2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtCzDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhRWkGrURdQkrQAA36

The management port IRQ schedules tx_clean_tasklet after disabling TX
interrupts. free_irq() stops the hard IRQ, but a tasklet queued before
that point can still access the TX queue, ring and device registers
while ndo_stop releases them.

Kill the tasklet after freeing the IRQ and before purging the queues and
freeing the rings.

Fixes: d6aa60a10b2f ("NET: Add Ethernet driver for Octeon MGMT devices.")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index c190fc6538d4..2cf3365b9636 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1254,6 +1254,7 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 	octeon_mgmt_reset_hw(p);
 
 	free_irq(p->irq, netdev);
+	tasklet_kill(&p->tx_clean_tasklet);
 
 	/* dma_unmap is a nop on Octeon, so just free everything.  */
 	skb_queue_purge(&p->tx_list);
-- 
2.34.1

