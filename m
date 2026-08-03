Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC193128CA;
	Mon,  3 Aug 2026 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723226; cv=none; b=abyNPhP/TXUouWJC+IlKZTKHV7mSzjx90LUhcuizlL+DAte2VV0i9O0otSqx8VgbOC9ayaXnSVB/Mk/yJiGb9AewCMbSA31jWwT+fqDi6kWjCFkIrnH5fMt+628IPuOtPUwq76MmFX44UAXsyYf/CPDufYCdsgrT6eeynFqXe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723226; c=relaxed/simple;
	bh=0irXfFbuWvbTFf9KItvPlMVl1g4a8njJNFfaqJdJIxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRrt3zqhlaVdxvOcg/DArEUpxVBPom4HP8V5tlzBSfQvEZyMt2hZc75pODTx5y83qhxu8kE1wS4tyg76XXehdDU+N/8YBtHdi0adc5vEKJeh2VZgX1S/WpdvrhH+Kpmh65kYWNNQvoNXjd7VcnjP+iFuyoR71PN7W/0Mlz5l0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=gafJSKJT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="gafJSKJT"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6732D7brC3810900, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785723188;
	bh=eBRsuBAQ/enEAXWpVmfA1YghJZQp2uan2woVJ09Ooc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gafJSKJT9QF56FfjSubrztSTmOI4MkUxOa349BsGSEWxA4ho4tk6GNZpxuqLGebL6
	 PwB0h9Reh5eb4KVM7kG4p5aFLlAXbNwrOuH3SC75220hYG6OTavutmJSADGzpP/46P
	 jowAKpKodMNF7mvNO/hwNV+VpS9nK/Tb8uVw9bLTe2JrJ2nCU1euyMkh/QM6hZvM6z
	 ygA5wvWt4HWJtZvkGyyvzmLllGQ7aLo34ntuKhkbOKkdj7r5O1DkHm86mh52eI/C+V
	 O48VVpzDQUtBByiZKjcxfYXY17xXyW62Q7hLtzYD2/iQlXjoxoelugrpFwpceS+Ehi
	 rY532I7Crnu1A==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6732D7brC3810900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 10:13:07 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 3 Aug 2026 10:13:07 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 3 Aug 2026 10:13:07 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 0/7] r8169: add RSS support for RTL8127
Date: Mon, 3 Aug 2026 10:12:58 +0800
Message-ID: <20260803021305.488-1-javen_xu@realsil.com.cn>
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
  r8169: support setting rx queue numbers via ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1107 ++++++++++++++++++---
 1 file changed, 967 insertions(+), 140 deletions(-)

-- 
2.43.0

