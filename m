Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FC3148AF;
	Sat, 24 Jan 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769258538; cv=none; b=mB+KRzpfyO5Cjgl5jIO/8LdWwiIiOtVSNllbHOywONTZW9HwhMSgs3WsoDuPkWLhPW18IMK0xCo9aM9nXOfjG0A7A5XM8H+kdCxgJOcNOok/uuMiY1aX2DNQB65ZpqLjBz/bgC5k7gy3j7IrQ+7yMGqEdAQ9UxzpzOlhLtWPDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769258538; c=relaxed/simple;
	bh=WEY3QIlk5KhkPUC3wCFtKgryn2tZq2Avvo4/QJkJIfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=du69Xfsw14RlhzG0cdKOWMckV7D0MYnGIb6QKR5dZPb9O8TZUHxsXl/c0o+kYVrMWQMeqpw/Bi3cj7tUSROlyECo6a2McC9RV+WbxOFYvHLAIGLF09Liad169o/9IZnNQYybjDNHTkl7SsL0ln6a367jZtzPAIQmoxU75G/ATQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=eFyp+T48; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="eFyp+T48"
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31d4a5555;
	Sat, 24 Jan 2026 20:42:10 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	kory.maincent@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v2 1/2] net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
Date: Sat, 24 Jan 2026 12:42:04 +0000
Message-Id: <20260124124205.102499-2-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260124124205.102499-1-zilin@seu.edu.cn>
References: <20260124124205.102499-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bf006b6e703a1kunm29d30d5ebf2ec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEIYVkJLHUkfHUpJSU1DQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eFyp+T48ByBpxQkjUsJbk6jK5DKp+PcW1qSwn/s0RVoe83Gfct5mTXgT9tb8ozGGVqH8T2ZcXk3qIdE9QxSfmjjgCyTwhEylcKUJLr6aHMcR70qluGrEPaVXLonnS0JsPhDRbeNzTBc2NIsSD80i7hk35GAX9jusipbR1WWZ7tM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=l75UusrGbGZ1rP2E70An8DUw/ZPmyU1q4YyaS498Big=;
	h=date:mime-version:subject:message-id:from;

In setup_nic_devices, the initialization loop jumps to the label
setup_nic_dev_free on failure. The current error handling path uses
a while loop that decrements the device index i. This logic skips
the release of resources for the device at the current index i where
the failure occurred.

Use a do-while loop instead. This guarantees that
liquidio_destroy_nic_device() is called for the failing device index i
and continues for all previously initialized devices.

Compile tested only. Issue found using code review.

Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Fixes: 846b46873eeb ("liquidio CN23XX: VF offload features")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 4 ++--
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0732440eeacd..3ba2806f5d1e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 setup_nic_dev_free:
 
-	while (i--) {
+	do {
 		dev_err(&octeon_dev->pci_dev->dev,
 			"NIC ifidx:%d Setup failed\n", i);
 		liquidio_destroy_nic_device(octeon_dev, i);
-	}
+	} while (i--);
 
 setup_nic_dev_done:
 
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

