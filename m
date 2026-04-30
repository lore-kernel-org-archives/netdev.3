Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9B227B94
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511483; cv=none; b=b7QByXIjts8yyf5yo4fKF6DpCg2+SIVaYgseVOxMRw0hdi0NZPwhS48zUaJ4SV//TU0fkFGIhMhffjLDPY7IAM/yHzULh6B9qRld9Hg/UkXJKJ9Gm29odscNYc93wKLrHgdmqk/zoV7OZ65lTfkWVLRHuqyzfSHYVIA7XugCcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511483; c=relaxed/simple;
	bh=oOAdb0qJsBhN/mc8MGPUTEb8kfFjH38xk+R7O+q+kfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WR9puYPBwiDzedpIATaKaAwV9p04ZONyc4s2SLg3JN1bKdcCjPV2gWHV/R7kBl8KZExFW12R8Z237FzjXvfexEj7cdzRvNht26XxnfzLrtWcJx4Q2nFxxJxxJgqTM/n7cZ5pdXgpDQvkFqFXPnYVuU1fk4JVvTPgnQrqGx54nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LEYTbXiA; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LEYTbXiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777511482; x=1809047482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5tw3nj/8W40iW19D5reSEynmJR0t2qkB/TGoNh2OvVc=;
  b=LEYTbXiAxqNq6H6xs2YoU6FMADeTmQ9f/jvkO3OpMEtC0jlvZ3bv68dh
   XBXkLkzJEylhQJmQtjuJEF9nAmIWiqLPUW8lNTfZCn2/ytYhiZ6JCUwML
   lAbpIPPvoz43wuMGd94YyOd6LlWAnh/Hxhn4zYy7n1CpfWnQX6vrA3wFy
   x6Q7N6nMlDzdy0M2ygyuFwN8ZYiZ6GIAe+u4acsUft8MAMpt15PT/u0Ez
   zYb6nNBCOH7RSrxPrfRgmJA+CBrzb/MEYK+vpD09BFqqjDSjnZ8RUOwEe
   4NPtzi4eMA4XU1cb4m7X9Y02V3HbLpGKM32g2lzczkfjniJ0Tycco2H/1
   A==;
X-CSE-ConnectionGUID: SZql5KcQRAWo8pk6NJ/Dyw==
X-CSE-MsgGUID: jiHfUKC+TPuVXc/ZZbXgnQ==
X-IronPort-AV: E=Sophos;i="6.23,207,1770595200"; 
   d="scan'208";a="18505964"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 01:11:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:12776]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id 08a6718e-2043-4796-84bf-5bedaea2bd56; Thu, 30 Apr 2026 01:11:18 +0000 (UTC)
X-Farcaster-Flow-ID: 08a6718e-2043-4796-84bf-5bedaea2bd56
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 01:11:16 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 01:11:12 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>
Subject: [PATCH v2 net-next 0/8] ptp: Add PHC timestamp quality attributes
Date: Thu, 30 Apr 2026 01:10:52 +0000
Message-ID: <20260430011103.18883-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds quality attributes to PTP Hardware Clock (PHC)
timestamps, allowing userspace to obtain error bound, clock status,
timescale, and raw counter values alongside timestamps in a single
call.

Motivation
----------
The existing PTP APIs return timestamps without any indication of
their quality. Applications that need clock accuracy and
synchronization status commonly rely on external tools such as
ptp4l, which implement synchronization logic and can export their
measurement of clock accuracy. For managed PHC devices — such as
the ENA network adapter, whose clock is synchronized by the device
without userspace involvement — these tools are not available, and
the existing APIs lack a way to report quality metrics to consumers
of time.

This was previously proposed as an RFC [1] with a single ioctl.
Based on community feedback, the design was reworked to cover both
the extended (multi-sample) and precise (cross-timestamp) paths,
with a shared attributes structure.

Design
------
This series introduces two new ioctls that extend the existing
extended and precise timestamp paths with per-timestamp quality
attributes: error bound (nanoseconds), clock synchronization
status, timescale, and raw hardware counter values.

A capability flag is added to ptp_clock_caps so userspace can
discover attributes support.

Patches 2-3 add testptp support for the new ioctls.

Patch 4 implements the attributes for ptp_vmclock, reporting
error bound, clock status, timescale, and raw counter values.

Patches 5-8 implement the attributes for the ENA driver,
reporting error bound from the device's PHC layer.

v2:
- Fix build bisectability: move ena_com.c consumer updates into
  patch 6/8 and ena_phc.c caller update into patch 7/8 so each
  patch compiles independently.
- Add missing Cc for Amit Bernstein (co-author of ENA patches).

[1] https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/

Arthur Kiyanovski (8):
  ptp: Add ioctls for PHC timestamps with quality attributes
  selftests/ptp: Extract print_system_timestamp helper in testptp
  selftests/ptp: Add testptp support for attributes ioctls
  ptp: ptp_vmclock: Implement attributes ioctls
  net: ena: PHC: Check return code before setting timestamp output
  net: ena: Update PHC admin interface for error bound support
  net: ena: Add error bound to PHC communication layer
  net: ena: Implement gettimexattrs64 callback for PTP attributes

 .../device_drivers/ethernet/amazon/ena.rst    |   2 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  17 +-
 drivers/net/ethernet/amazon/ena/ena_com.c     |  47 ++--
 drivers/net/ethernet/amazon/ena/ena_com.h     |   5 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |   3 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  67 +++++-
 drivers/ptp/ptp_chardev.c                     | 137 ++++++++++-
 drivers/ptp/ptp_clock.c                       |   4 +-
 drivers/ptp/ptp_vmclock.c                     | 195 +++++++++++++--
 include/linux/ptp_clock_kernel.h              |  30 +++
 include/uapi/linux/ptp_clock.h                | 225 +++++++++++++++++-
 tools/testing/selftests/ptp/testptp.c         | 175 ++++++++++----
 12 files changed, 799 insertions(+), 108 deletions(-)

-- 
2.47.3
