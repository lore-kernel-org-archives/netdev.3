Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE53BBFC4;
	Thu,  8 Oct 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442994; cv=none; b=AsTSMOGJ4kl5w9iewdrUQDKFGx82OZD3H1rtYVZLGa4/US7dlng/ufCom6hIMYZlq2ib6fCnYCFTYNY/Km5/BjD1uLPgD5hkGLBD3PkIFuZOy7DpRxRa8AH0ulbeGb2aeSjC111+Ob7InmChWi4bC6XPO1lt4BJEqdY4UToRTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442994; c=relaxed/simple;
	bh=SL9bTUfn/hx2Qb3HKpr2J7B+rY/psLMm6SxP2dKw5nU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpZdRmRqwgIVlHT8cJcP+Bscmz66IebqMxFogLLpW1p8e41cBmhgKODVFYHKubppPvmpPrS9+WL7E//h4pbpCuI+NM7A5oOPUHFF9gGn1fhDqTvONRCo0Tim6nm75cg52g7Wvag8cEPA7yuoELX7WVqpPxpW4gjzhHtDn2kQwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=uXjspZud; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="uXjspZud"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6986vOqrD281931, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1791442645;
	bh=LETy6hp2X+5wWgTIxpGnGUUbTjpXUSM/PHd01b6dAsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uXjspZud6YCPWefn2fHc5RRkFL8nXQhTr8YPE7TU8YM/TIFk3FBByhRftxwpU6+a3
	 Hj3O3O7bGAe2KRE1dHkgKiJ61eD5R8JQRK0tQ4OGUUUI/c8Xumt6cDtZ7tCmRz0NLp
	 0d7wjuBeQVf5ZEEzN1+JjT++g39D1zHHLly+Gl8U9iWh9+S8czbPnuOvhRvDkK5LV3
	 5dOcMerrVAwVl/cBJuiSxCCCH69F6F7683AdzSzTUn/XAwFqCgBxpdyjrsw1mHWqi2
	 LZvAwQLn4PKhwNVdO0WIMY8QwPWTwBswMehckVJ/x/CGoHHPyIf4slIUrqxzaZ/e9R
	 l2ntfdFdSao1A==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6986vOqrD281931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 14:57:25 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:57:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 14:57:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v16 0/7] r8169: add RSS support for RTL8127
Date: Thu, 8 Oct 2026 14:57:15 +0800
Message-ID: <20261008065722.1026-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch series adds RSS (Receive Side Scaling) support for the r8169
ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).

RSS enables packet distribution across multiple receive queues, which can
significantly improve network throughput on multi-core systems by allowing
parallel processing of incoming packets.

Key features:
- Multi-queue RX support (up to 8 queues)
- MSI-X interrupt with vector mapping
- Dynamic queue configuration via ethtool (-L)
- RSS hash computation for flow classification

Experiments:
Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8 Threads)
Arch: x86_64
Test command: 
  Server: iperf3 -s
  Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
Monitor: mpstat -P ALL 1

Before this patch (Without RSS):
  Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
  8.2 Gbits/sec.
  CPU Usage: A single CPU core is fully occupied with softirq reaching 
  up to 96%.

After this patch (With RSS enabled):
  Throughput: Stable at 9.42 Gbits/sec.
  CPU Usage: The traffic load is evenly distributed across multiple CPU
  cores. The maximum softirq on a single core dropped to 63%.
  
Other Experiments:
Link: https://lore.kernel.org/netdev/0A5279953D81BB9C+f50c9b49-3e5d-467f-b69a-7e49ed223383@radxa.com/

Javen Xu (7):
  r8169: prepare for multi irqs and napi
  r8169: refactor RX path to prepare for multi-queue
  r8169: add support for new interrupt mapping
  r8169: prepare for new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add get_channel support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1122 ++++++++++++++++++---
 1 file changed, 973 insertions(+), 149 deletions(-)

-- 
2.43.0

