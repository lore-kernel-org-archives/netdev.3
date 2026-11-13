Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579432;
	b=OONSInaf5ekCtpwfOk+lFroFC7yNLY6vBKrUvETUVmEGEK2AeEa/RGfmRBaSWvNgh59j
	 VlrmwbxbJADJl4MKPAcr7us+ULVJIOCQRg79RdKtpoFpVA+VfY144UTqRsO+1gO76jTrW
	 hpwQoGmyIQFGHcF6uvi2REsaYL9ZnHhHQgDO5lw1of63rkQqe3ZGg6c9xmwsk2ittS9md
	 4wRGudb9YL0Q1LuUzCIXqiCguXlC9iuDyvQFqvDJRtxgrxQxv2MC87X0+1+tEsap55KQ5
	 T3zygQVj1SqgPcL79VFPv5dE2RXZ2a0jF87mU8P1UVd5G34UFGdKglxqvdn6xCYNlbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579432;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=ev+Xl72+1OCLuwasUtviXG9+6wDTgYoAYsCBeKV+34I=;
	b=dGCjpeu3mpJ8rqPZ1+FQ/IG2HzoP8YpjqTZnVO3hqhW+HtpqpDij65+forGNfL3mvTPO
	 wU9/m1SfnairWTKNgOaUOfa22Mze7H/PKyenppNi/kURQ7t6OmnPHjPsHAmycuR+BHMye
	 3jhNiJLf9BikNS0bPIcCJCxykXsa0UAZPmnT5PKg5wXPnj/oZ99+4/Ro9UXVtM4VxVs+t
	 Myu+Ouepl8/siqQV5pF0b7ABP5WWu2Ej5uJd6idgn92N5QuXfcH7Ez7dV1qiqf2//ykLd
	 mzVdIoR84KPLCrQTz9XBBzsZngPBAm/RH+OqNhC/LJ13w4Vpglyn84KOFnzXEO90gCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=I1JA5P5q;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEED606A323;
	Fri, 13 Nov 2026 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FEED606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=I1JA5P5q
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 549b5a83e;
	Fri, 13 Nov 2026 22:17:05 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: Fix potential QoS capabilities leak on removal
Date: Fri, 13 Nov 2026 22:17:04 +0800
Message-ID: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d544e98d03a1kunm647ab2784891f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUJNVh8ZSksaTU5MTx8YH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=I1JA5P5qmnbqbrfRDiLxoEbIBviJDrid741fAgSv/KcQjU0cXX2wAPCKE55hKZRbuw6P37kLYmHuzBHL3h1WXSuJBOUSkCKDPNcmsjiuUYYt9nTmAcuQHNSYPYpTKYgCH+LVKblxSB2OrZ/SxaltCxYRfCZe3dMXLsWuSmd2vzM=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=ev+Xl72+1OCLuwasUtviXG9+6wDTgYoAYsCBeKV+34I=;
	h=date:mime-version:subject:message-id:from;

Probe allocates qos_caps separately from the netdev. Remove frees the
netdev without releasing this allocation.

Free the capabilities after the workqueue is drained and before freeing
the netdev.

This issue was found by our static analysis tool under development.

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..a2e7bc4cba88 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5680,6 +5680,7 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
+	kfree(adapter->qos_caps);
 	free_netdev(netdev);
 
 	pci_disable_device(pdev);

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
