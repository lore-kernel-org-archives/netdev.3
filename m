Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5152EE5FC;
	Tue, 27 Jan 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513709; cv=none; b=i+RJLSbdyBQLYPBXr4c+dZejGb55AvYSSq7i0vJ+2f18mbYGqeoUBbJFNZK7HttZHwmsitqYUikpQUMw0mw/QmncGWt8ZJP4B/YEGaTM6ZNff3NtcZ/8xEgCejSnu8r3WJ4atQm8h9Lc1yr8GHyrsd8AD9NKBCWjVYqLnTyy5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513709; c=relaxed/simple;
	bh=TcxQG3Uk1qVoNLXSi42PKRy+0aSvGUu1h4ix3ulP84g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXnsEB35R+/QvZsEndAycXWxtMlzxGnYamxJjI4100Uhoa9EH/ZLsKCtNKfRfwHrToaaPSQ8VAUIYFoXzpfF9UrzxzjGPjSEddOZ2PjBYq6Cg+es7LRMsv2Z0uKPm9hNHnF99sz8Mvh5u5At6MgDDcpv/OKb/UpPP33LaoBO39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=PQ2bAgZq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="PQ2bAgZq"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60RBYRVE02868626, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769513668;
	bh=HPkFL8AOlRYLXUCPkupQ62Marl/S2MmVMmJBQIb0WxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PQ2bAgZqJIjjm96by8M72FMuQENLb6iY5i5Upj8ISZZrDo1Yu0Xol6/esRgj6kW18
	 x2dbx7O3pB9upphp5ZKbdCwmP+SipRmuZ4R/U0r17z2dsq9C0e6V/P8h7fiX3PkGWU
	 wlpU0ilARvNNxQMDpL5Pvd52VMVQ6uJ9MbEPPvs6kj4f4Q0TCY8ecYWKquhKpUPSNT
	 VC6O1VwXWoNiWtZVpK/9MboMuV023PLwBlXyYt1IAPriZD4JF6kAFV5WuIoQRQQYLm
	 shSM+Hr+SyGhOv2tfpprHJ2NWVwnGAnsLc0JjiTWYl4KkdOt8K5VPxr4SIht+o8L3I
	 MvuJfAEKGtZnw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60RBYRVE02868626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Jan 2026 19:34:28 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 27 Jan 2026 19:34:27 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 27 Jan 2026 19:34:27 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/3] r816e: Add a Makefile in the r816e folder
Date: Tue, 27 Jan 2026 19:34:24 +0800
Message-ID: <20260127113425.1989-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260127113425.1989-1-javen_xu@realsil.com.cn>
References: <20260127113425.1989-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add a Makefile in the r816e folder to build r816e driver.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r816e/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/r816e/Makefile

diff --git a/drivers/net/ethernet/realtek/r816e/Makefile b/drivers/net/ethernet/realtek/r816e/Makefile
new file mode 100644
index 000000000000..0f028c7ce7bf
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r816e/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+# Copyright(c) 2026 Realtek Semiconductor Corp. All rights reserved.
+
+#
+# Makefile for the Realtek R816E power management driver
+#
+
+obj-$(CONFIG_R816E) += r816e.o
-- 
2.43.0

