Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37D3043B2;
	Wed, 20 May 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247003; cv=none; b=OY69cTRKm1P1wTBzwyBVUD0pkwrZzLhT++P9PFIbBpWwF3ZB3nWAZuTmfUX5HiU7kJrrAEofgYEa6x4o7Bi2dDbVPa8TThq90reFVKdmEWFE0GM3PcG4ECRMjqJgk7KNGrJJKf63bCWbfN1FLZ7FGpU19p3ZJ8XOgF2F+QZ2DYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247003; c=relaxed/simple;
	bh=GrEKKmBOINCMoW08RSTPJ+x5d07iRJdkwg38U9wxHxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IpwB3VWcFTN5sOKaH9Amdw9ufXSUonCsqzV/Iq6kGMXVFseV6Ka6SDQaj7CGboRi4KSclxkRYOavVluwu6CnGCYwbfiHL5FRVVvK8qKtgIhbZStBF/PliInRyArb0+HGoXUkbwSp4BRPB2m2+j7EPgUjLpsmSe1qeWyuiq4CKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=LkZe8GUo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="LkZe8GUo"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64K3G5mjC3896058, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779246966;
	bh=PryQ+Lj4rzu9ID0uIAjVG55OBAh3m1escAql2a+18xc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=LkZe8GUoDyjTOJu/1ygU5D8OkjpxcEDlNvF/pfVBqzWiSD/48Jeg4TwDfegTRO+jQ
	 0XO63ZmONBHM5Ia0HuRoLzoBGmXZxRAYe9gkAltxTC35TLq2voY3YvlPLSNApj3f5v
	 v2DMRf3gFxLV79DvB9jNK5XsBFYCxuq0wvvGmguPbV1R7DbQuRwbyPvfaaXOzL97Ul
	 8IbdjOprt0ysi5eMbdsg8u0Eg6fDYdfAGApo8rwT/GIfMHBHgrDht2j+P1AOicoc/z
	 u0gNslTiN5p3Q9hDVMz0GC/SNgEa6RG6W3rYoLz9oWrjC/y5TdmsrWzngjANRhhfSL
	 zcOwYIlEVMJJA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64K3G5mjC3896058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 May 2026 11:16:06 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 11:16:06 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 11:16:06 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v5 0/7] r8169: add RSS support for RTL8127
Date: Wed, 20 May 2026 11:15:56 +0800
Message-ID: <20260520031603.700-1-javen_xu@realsil.com.cn>
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

 drivers/net/ethernet/realtek/r8169_main.c | 1100 ++++++++++++++++++---
 1 file changed, 963 insertions(+), 137 deletions(-)

-- 
2.43.0

