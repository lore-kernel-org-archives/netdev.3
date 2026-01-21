Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB527F73A;
	Wed, 21 Jan 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000771; cv=none; b=d+g4LbqYVR6H111c2abf40pJVKHmOn1tO8cjGwQo1LTP+eznkCNWuq+EH4sOchBVF+MXDLn86fl9DBLkKWwufsG9UKAZtlx5SEbnbKXFs4waaVe6i8Ra0YyfYES3b7ZfE+o4wkPnHnPQE6iLFLSS+wBzvC0AOYVhtDJOYEpF298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000771; c=relaxed/simple;
	bh=UYDGhUHXfre/NA1SuviN7j1ckKKUEt0fGh4eYorvYqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5wtY4pzMQrO4rsbqizKlB6vKWdZN4k3ukaqlfYYNQJISM4xxhUYNs65mcBgscIjhVFjaLC+ObwPL4NoRabR82/c0k4Y3uGqw+XcUqq078jGYOBDHe/2y0bfu2IP4dYxU7jhZ1tE1ztZ7yrLnpCpZD6olbfij9hOnJFX7lsfyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GXGr8txH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GXGr8txH"
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 317612f8a;
	Wed, 21 Jan 2026 21:05:54 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: vburru@marvell.com
Cc: sedara@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] octeon_ep: Fix memory leak in octep_device_setup()
Date: Wed, 21 Jan 2026 13:05:51 +0000
Message-Id: <20260121130551.3717090-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be0a95c8e03a1kunm6b02cf1618b9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE8dVh5IGh9DGkNJQkwfT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GXGr8txHxKZSkFnqjCIOJz9/ITobLSt8E7oHZstxVORMWoYvbjUbFljGjCEyb0syRYN0TmL8bsrcGa4hmu20UYZAZK/rOktWmlzvWc5TepdpdN3Kj51XEpa39sRc20Y4qVvDtMfa6Rer+/mPDRK9Y4HUmCsAzFm4Tukp/jdOJ/s=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=1eBNzfJM3+Q417qBDpLxBxNdfutgeCrnTgxAsg7X3KQ=;
	h=date:mime-version:subject:message-id:from;

In octep_device_setup(), if octep_ctrl_net_init() fails, the function
returns directly without unmapping the mapped resources and freeing the
allocated configuration memory.

Fix this by jumping to the unsupported_dev label, which performs the
necessary cleanup. This aligns with the error handling logic of other
paths in this function.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index bcea3fc26a8c..57db7ea2f5be 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1338,7 +1338,7 @@ int octep_device_setup(struct octep_device *oct)
 
 	ret = octep_ctrl_net_init(oct);
 	if (ret)
-		return ret;
+		goto unsupported_dev;
 
 	INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
 	INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
-- 
2.34.1

