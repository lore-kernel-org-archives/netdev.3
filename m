Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B04CA76C;
	Mon, 28 Sep 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602890; cv=none; b=JjeN8MekHeNrjMfAgor89B5Cgn5IhzC0kElmhKWkovsNlzCHzDRT9TAzFVEyuZjvRJpJE+A1o5htJ+SeEwrc+YSXmlWixqptws3eAr845BCrGWemdDlSMUEdn/p69yYMGstXfqqJZ1QrENGhUrrIQVQ24vI4nTTOnM8jOJjEM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602890; c=relaxed/simple;
	bh=I99hF2SB9Sn8nsZ6bQmjmNrLftUWIxRtpyPEJ3jeyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zwfuwya68IBNNuXYbOh60VLjcbrFpma/aBc/Zet/R4uCvGtKNSSuX8HTSFRmCTtqopbRg70fAWyeN8zZCKBG1YP3uZNfSR58v1j8GoOuYZDC2WybjBLTdSqfjqt7qBLzEN/Vg/hKr+e4muKps0+xKRRWiHOIByjK78jP5elQvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gE7NhkHE; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gE7NhkHE"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f42c;
	Mon, 28 Sep 2026 21:41:21 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: e100: cancel timeout work during removal
Date: Mon, 28 Sep 2026 21:41:21 +0800
Message-ID: <20260928134121.826-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83fa8f803a1kunmc9b1dcc72001a2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkgZVhkYQkxIQk8aHx5PQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=gE7NhkHEkUjcitEgszq6ti/yUKYCEBZOVyFbgo2dhZp/CUKKSVuHYIZrfJAIVY7+3g4t8xlaLIGrsu4D0Xz/6BxYDxWR05vuoG5tp4XoH3842J5KWZyYjk4DP49t+42SkOkgcLwRq/IpH3sDVSwrGGXMq8c9iqbRzOKPxojJwvc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=0HgIHPw9ARGoHTinz+bKOgaAgSveGSzCt2kWpBpCIbQ=;
	h=date:mime-version:subject:message-id:from;

Transmit timeout and command submission paths can queue tx_timeout_task.
The worker accesses the MMIO mapping and netdev private state, but
device removal releases both without draining a pending instance.

Cancel the work after unregister_netdev(), when the network stack can no
longer publish it and after any RTNL serialization used by the worker
has completed.

Fixes: 2acdb1e05c1a ("[PATCH] e100: Execute tx_timeout task outside interrupt context")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/ethernet/intel/e100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..710c2c30d9ed 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2988,6 +2988,7 @@ static void e100_remove(struct pci_dev *pdev)
 	if (netdev) {
 		struct nic *nic = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		cancel_work_sync(&nic->tx_timeout_task);
 		e100_free(nic);
 		pci_iounmap(pdev, nic->csr);
 		dma_pool_destroy(nic->cbs_pool);
-- 
2.50.1.windows.1

