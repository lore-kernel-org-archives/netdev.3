Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB303644DE;
	Fri, 18 Sep 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712400; cv=none; b=raP6+cU8dGBDH/cCDVOYIsKHZE+wMBrGtlU2yM0MX1axUWy77q3AWIAZmvAlRxewXdqhqRXMtG3z2zn+qKPuFDbiNxXe1aAEENDLkfMi0pu7mtaEhnq57+6GHI1yvizFYuWpbb1jRBfFGzvgZnO4OQkV7w4SqKFPsoocO5QHuKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712400; c=relaxed/simple;
	bh=h/8FT6RWfn5rqfIZW0ot+IQQWoCzMGO5bjjkedwJZ1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jOpy82xSNrSk2vD5fMc1l28p0k5P1U3a92WYYLw6lL6W7QgveLNcbaNIhF+E5wliZbItudOTG1DUZWBJO7JHbClpOzI9FX79ckqMZi4wXThk3tl2c4sb6d/50mHNF7CDtMkwEiCNC067gFqJEkB5Y/0IfN9kEI/O+JRGHkcr2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=N3O66zrq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="N3O66zrq"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68I6JPTL03939109, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789712366;
	bh=VuIO0IzyQJfEE1iDAv9s/jG3bKDePDkdhMngbMEXFks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=N3O66zrqDKXKDjKgqUQaF5QZrcGh2bRaEJxJRlBei4FE9DP12RsM8S+OMd2c0zQDW
	 FMJ8RhNsRUgWU0A2lzfQgLtIXjhM6Uy5Mpoa7kTKUI3jeIxrVcZfSgCBSqlCgE0e+N
	 /FHHF5McLeDkHgS0HNcrkmSJJP4pETcdmsvSmSuymtmQN+A32ZgUJBtlF//KS1IKyx
	 K5i3gHqbvsSo0z2tBm2wXvz/YnhcTwvLW0gk9Hut6x/+8maSV3UWFKCnYfIwFAvAB7
	 U4n5Jpj8umS5MjNLOy5KtTBkA8AsxcX/MsFkrH8opsisNCkaZNR2YX16zRX+I2+7uF
	 dajGI9npW0LrQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68I6JPTL03939109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 14:19:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 18 Sep 2026 14:19:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 14:19:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v14 0/7] r8169: add RSS support for RTL8127
Date: Fri, 18 Sep 2026 14:19:16 +0800
Message-ID: <20260918061923.313-1-javen_xu@realsil.com.cn>
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
  r8169: enable new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add get_channel support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1099 ++++++++++++++++++---
 1 file changed, 950 insertions(+), 149 deletions(-)

-- 
2.43.0

