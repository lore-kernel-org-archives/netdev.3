Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258993E3157;
	Wed,  6 May 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055247; cv=none; b=nhHTqGJkw6gsUiPmTBj7R4IbgbbHZxu9jfWAHrnrXqiDxCq1K1Q6QakpvwkDr1CFrIk6qw+tNnfyUaQXovEvZoEnmMPPE2QQtjgJA50aTcTQZGWRbq8S6BVPDGuz3CPKnr/NY6HlSvNrTADlzg13zTgPVVfeNE4+BxnZ9ZLVKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055247; c=relaxed/simple;
	bh=N7nwxj+Q2AUrAmdS7zfc3xmHw2DywhJQPljBfhzZir8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECTo1mAh8S/tMrQ6yWztgEQwM0UFILPFy7S5iR9MyREJNVJTbAesR5G0E83CwC41i6J0GakvRQsmDtdRZEDjMQluvMA0oeJFoHsujVfCYz6Ot7VPEdnHa8llwzqEy1UqxPgMi/cEAd7V+y7wCCU6C2vYSvD2KFIc+xDuwJ9jlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=HB75JKJy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="HB75JKJy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468DSnqC1854043, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778055209;
	bh=obMeRHDu8J4WXJmBF4tuyTVfS6RGSd+9A0CpsvJ5ymw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=HB75JKJy9LjCE+H8KfjcZUlKlgv/NRygYhjpJRJsZ/Xlt2dalzNHV4ULPMw2ly+Ps
	 LH385BSRkT7kWugH2HXgjhEedfy+N8df275HTZ9iFf2ewsrSjsxsBAzIlh59yO2X78
	 g3I1Zc0ZrDdslJe5JO5Y1xRggkTzZJxX6SJ/SzYetcZL7j0DSTSVOBJnVWUUhKJnO2
	 zIC6JjmJzeyU7sz1B2gFsgnuIRUMMOS3qIGodDP0fjUX2Ibc6wS41CJP1YbCWFRfOo
	 aQzh6x3KxqT5K7EpWUo+EKRB6la2FLG9RAvDlhh477cCo+jerXI/ZkqyPD6VY4eX2v
	 1xen79LIt5Lkw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468DSnqC1854043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 May 2026 16:13:29 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:13:28 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 16:13:28 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v1 0/7] r8169: add RSS support for RTL8127
Date: Wed, 6 May 2026 16:13:18 +0800
Message-ID: <20260506081326.767-1-javen_xu@realsil.com.cn>
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
  r8169: add support for multi rx queues
  r8169: add support for new interrupt mapping
  r8169: enable new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1202 ++++++++++++++++++---
 1 file changed, 1080 insertions(+), 122 deletions(-)

-- 
2.43.0

