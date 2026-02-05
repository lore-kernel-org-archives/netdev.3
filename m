Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B512C0F91;
	Thu,  5 Feb 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308176; cv=none; b=caVq2G6GB2BDKXeOQt9E4AXWtn5/xfaVRNz+m+xrDc/VkWJqyUEfgsqibuTelIor16hA0BUUl6myVeTTKpiZx8YWh9Dn143J73z0eEy7MLBFG1ZUgppH/D8J6AQ76BkU0OrB6Li+tEO+Rj+piCMmtVpnkjKBoSeuqfFSQyj7nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308176; c=relaxed/simple;
	bh=PV2Zzmkef21eRrCOQf0Q175nJBjzm+KyKai2dRqEd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPTpPd4PYgAtq591dwL02MohUcOgtUUOREcLCKS6sXjloJzw6prHY+Se+1zBb56mvRu5CRoicPhaHUA51HuyWSRNEIcPvPwu1YI++F9d0rzbbDLe32kW0lzWBMfCwnTomyA3nnyHUb5NPPAvJCij7hbMQtVnWsDn9jX7Le21ZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPu012I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPu012I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35156C116D0;
	Thu,  5 Feb 2026 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770308175;
	bh=PV2Zzmkef21eRrCOQf0Q175nJBjzm+KyKai2dRqEd3E=;
	h=From:To:Cc:Subject:Date:From;
	b=XPu012I95Da8GFicm+it7uSEyUJWRr9grvbTowU01/ql5Q84ZvtvdEMyfi/aEcn8f
	 sPH8R+a1EAD1KaWzDCyO1K9HGkt3BftsC7lGcJyXqWc0qk4VdSR3bdm8jA3o4qU0E0
	 cdd0vMvt/zX2k258Do+FwWpUM3i+CbvBcHtdU6RjKovV7N7Hf9UAz2oqkVmAlZEAfY
	 VfdlPYBsfCsABiURwQ2sRqXLMtj/aVy6Krnpq3e+02yltKjQpmVew6khzAx5HIEKIH
	 sCB+gQG/LPTfNUKNtyqENBtlCSuUgDohv+zTvCax5KYynvezSvNLUC80kGfgR0qjVu
	 9DKwAvY9IjuzA==
From: Arnd Bergmann <arnd@kernel.org>
To: Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] hinic3: select CONFIG_DIMLIB
Date: Thu,  5 Feb 2026 17:13:48 +0100
Message-Id: <20260205161530.1308504-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver started using dimlib but fails to select the corresponding
symbol, which results in a link failure:

x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_poll':
hinic3_irq.c:(.text+0x179): undefined reference to `net_dim'
x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_rx_dim_work':
hinic3_irq.c:(.text+0x1fb): undefined reference to `net_dim_get_rx_moderation'

Fixes: b35a6fd37a00 ("hinic3: Add adaptive IRQ coalescing with DIM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/huawei/hinic3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
index ce4331d1387b..02d6f91a7f4a 100644
--- a/drivers/net/ethernet/huawei/hinic3/Kconfig
+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
@@ -11,6 +11,7 @@ config HINIC3
 	depends on X86 || ARM64 || COMPILE_TEST
 	depends on PCI_MSI && 64BIT
 	select AUXILIARY_BUS
+	select DIMLIB
 	select PAGE_POOL
 	help
 	  This driver supports HiNIC 3rd gen Network Adapter (HINIC3).
-- 
2.39.5

