Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE33750CA;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651657; cv=none; b=ZOy8hP24FguVdqis8pF/jxSUO7BwgUXBCvIUZsEYKBHktzjtZ/QwYSB0qQzOCztxyOvVSTiXgtFT+QNh+QivJPh0UeNnnPU6zDZ7n64z2dZEZ1Uh1M43+2EDz0E9XgNH/xiGtdL3cv4+HD/B8bZBx70WDHmQkB/WxsgyUkS+M5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651657; c=relaxed/simple;
	bh=RVQ07WiLnsNI9EBQCtaXpaM8HBWSvbFzT3z9UFTEIic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6sTKXd72kIEwTRttk6/ysVXiPQPRsyAvtgxhMyUmie3Q3MwADDgInzLL1JPLi14lIhkX9+i9is3rYh2jhEEO8x08FnPFQRMaTZ0wTUCduYbeuhmh+aAfCtwqM4E0fudvDDp/89vODyrddmXxzTY6GFZQPvTfG/F/ZFbYiBS31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=k+Dtcfap; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="k+Dtcfap"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KD540277428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651613;
	bh=YiPagqdbnbKn+6b8wuOqOecUAtV5gW5FYd6c6iDng9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=k+Dtcfapmu3kQYgM6a8u7kDUpX5YJcQwPjPs0ekOtgVDIXpZrldQk6NGcEduWoMEP
	 BpsYvB9HJa+EU08LZdAT9WjhBS/2un0gMgVj8S9ABQRuDP7knl73BbwV+MTh92S3th
	 Qv9sPktxJZGrqALkH6uG+P040JSlU5lo93dyI6BaT1zukO3Yv2izjokvU9ryVkKIME
	 iWWsuHwTYka2YwBHBACRfAeencDhJmPw7Y77t9GC41RgAL1u4R8ciQyUBoyv031cKh
	 VE6HHq/jDPcLpLH7PgUcbBseO98+Br2F/JXLn6UcX5anXn2MO2nMwzYSfzxMb3qMFA
	 8QkST/veemuiA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KD540277428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:13 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 20 Apr 2026 10:20:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 0/9] r8169: add RSS support for RTL8127
Date: Mon, 20 Apr 2026 10:19:48 +0800
Message-ID: <20260420021957.1756-1-javen_xu@realsil.com.cn>
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

This series patch adds RSS support for RTL8127 in the r8169 driver.

Currently, without RSS support, a single CPU core handles all incoming
traffic. Under heavy loads, this single core becomes a bottleneck, causing
high softirq usage and leading to unstable and degraded network throughput.

As a result, we add rss support for RTL8127. This RFC patch is just for
discussing. And we do some experiments on AMD platform. Below is the 
result.

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
  
Patch summary:
  Patch 1: Adds necessary macro and register definitions for RSS.
  Patch 2-4: Support NAPI and multi RX/TX queues.
  Patch 5-6: Support MSI-X and enables it specifically for RTL8127.
  Patch 7: Enables RSS for RTL8127.
  Patch 8-9: Adds ethtool support to configure the number of RX queues.
  
Javen Xu (9):
  r8169: add some register definitions
  r8169: add napi and irq support
  r8169: add support for multi tx queues
  r8169: add support for multi rx queues
  r8169: add support for msix
  r8169: enable msix for RTL8127
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1437 ++++++++++++++++++---
 1 file changed, 1238 insertions(+), 199 deletions(-)

-- 
2.43.0

