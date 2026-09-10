Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93333557D;
	Thu, 10 Sep 2026 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021906; cv=none; b=LoZ34OUVn1PszrkTVlOObrF9zSeXqv3jg7l6A9lM1bGIzz9d+uNSlsd2yPYRkX98if+qCvVDEyNwTGOqkMMX5QH85fvk91B/PCB+AYCh4W/1ZHBH3QuIVzpoXr3FudWL4ULAewMq+2Yc9M26sC06b7IGtXuG4qoiU9M7rO84WaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021906; c=relaxed/simple;
	bh=dd8R8lcdVa2SVqHaZuqajLeS7jxapXsOie6WN6fIJZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFGnPUgzSHI/+dOjlez82NQfBhp4wH11Ix5+70WuTSi+3xWEnW7kmr92sNN08miux9OaEHBUpL7uKKUEVfUbdmTuR/APW6eHrQh32JncR+R1igI/60dJVjvMpE1CO4p+rW/I6hQIKAd2GYr/6wC3rcDT7qqkt65WQqYkeGkgO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Gn07jyyl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Gn07jyyl"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68A6VDeH41272533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789021874;
	bh=r+4RxvSRxM1iK1HjNAAbSQvG9SLkOQxP5FTgUOsYmKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Gn07jyylwDhNgzV2oaUuEX9sDR8+jqzQpp8ZAm1TnldevYs8AItDnJjcbPcStXgB5
	 1i4Ji79yNTkfDEUz41Akj3JLR/ij4P3CIt62fx57pSFymXlvJVX6r53Hzj55IDP5UY
	 tgz32vpjz6Nn8Bi64bTGzuSNR9ag2EgpifA4SXe8rPIX7TU7bTekdWGBEzONurTsws
	 godVkt3MV+t3V5xrjg5ik42ZdRjmTmM9B6a++5m4m4etZa/mVhpxIgFzR0JmYpFWUO
	 N3V1EprU6eYyKaSV35J1VDKO/Mpdt4KiQg0yU+LWDV6gTBFljRhNPhDjtximmizOBK
	 IY1Q7zedw7fpg==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68A6VDeH41272533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 14:31:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 10 Sep 2026 14:31:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 10 Sep 2026 14:31:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v13 0/7] r8169: add RSS support for RTL8127
Date: Thu, 10 Sep 2026 14:31:03 +0800
Message-ID: <20260910063110.1350-1-javen_xu@realsil.com.cn>
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

 drivers/net/ethernet/realtek/r8169_main.c | 1084 ++++++++++++++++++---
 1 file changed, 937 insertions(+), 147 deletions(-)

-- 
2.43.0

