Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBB397925;
	Mon, 31 Aug 2026 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154830; cv=none; b=toHFbyhjPDjpLzICal1Jd1oZNki1un63qPogEiv1Jujc9dNgogBIcHRFWvXnH0ylq1PzX3zB0gM3ltykzSNwuv0tetHvPfDO2dn7XDJ7yGtBNlyjR8BdnDIRVfTf1Ajlbm2h+/82MPFRPyVqrpCYKP2rNtXeiQx8XDFxyAZSB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154830; c=relaxed/simple;
	bh=mkM8b0Wkwaox8na0+498w8Hu/fpiSE8Q4cGcLuCBiOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fi5uRqxwRcpXx7oyX0GjGIyuX9J+zJ877Y2he4sC1/gcGKR6SmJo+WwXjx2tcPLANIm5LsL0Z3cZfAvRPcVjzkLGeuy2t21EVEJoi1NPNC0WZPWC0Qn/AKL9s+MLQrqfo0r0wUpkvn4WnoGF/p8iXWlq2BVCHxyZQ5QpFXSPw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=gNEiab+9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="gNEiab+9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5dhCfB479611, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154784;
	bh=eJQXxc77ZbJ5La4ZzBG0kDTV7IGAh+xPSeNOU9s+H9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gNEiab+9HtBEjuHZGBCEnjIDh24sWTFK+Hsxa3SUX/92nb5E66vF/P+vKzHJ2B4o/
	 5UJY4UY0BfvJBiloynjaLBvJKVJn3+fKSCAxrA0hpvx0oB1kNK8CozrokaZYHKhzqp
	 fb3KU6zCou/peTyrd0G6pXhpKN87D3vvWxy+Q3FJg3jnU9g4AiUR7bGZC4SycQaBZc
	 ejvF1RHuGi+uiyyhWMoNLSvYpvDVSq1gBbwJr86QOwCk2VUvsv382oJCBzbP9d802h
	 SEHDcwM03wHIHRWGInKfjMwyDqOaDFWGAU8hID86UTfrKhZeaFHiBMkHCXUxGi+bHc
	 hbAPRW7bIcFyA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5dhCfB479611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:39:43 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:39:43 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:39:43 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v12 0/7] r8169: add RSS support for RTL8127
Date: Mon, 31 Aug 2026 13:39:33 +0800
Message-ID: <20260831053940.620-1-javen_xu@realsil.com.cn>
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
  r8169: add support for multi irqs
  r8169: refactor RX path to prepare for multi-queue
  r8169: add support for new interrupt mapping
  r8169: enable new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add get_channel support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1083 ++++++++++++++++++---
 1 file changed, 936 insertions(+), 147 deletions(-)

-- 
2.43.0

