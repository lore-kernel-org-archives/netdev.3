Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888321C01;
	Thu,  4 Jun 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560446; cv=none; b=D7G6uKMZFPAmHBLEU9ynfLaVDCUqd0NT890BQS6IkVr70bFTBSgroltPMUxiVTBRdIxRnDQuVWgVehCuELUxhMpy4Il7gyr9U0WZQGRQzcd2FHD7pV5hSXcdXpA/4eIA6I6sfmnV6koi0pc7wv8gr9Pgmi5ZnPyQ+aE7jYJsip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560446; c=relaxed/simple;
	bh=JqcvaKwSx6nG3h24+YkDT/NXq24Iyxqk41OOMudJZjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRKiuZSgrUr97a9f8cuZ+xTOtl+AukpJKxsckZXnCVGZJ2sePrvNXZPTeGocbq3zDLXcTmjGdnVB62OPhsMh+LoyftaRN0KHuuayWXtF0257PjLitaFH+I8lPeWHCVQ6Wyxe9lKioKMligezQ86sefT+h527k5pemfZLtNK07zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZzQd7gcv; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZzQd7gcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780560445; x=1812096445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SCWr7VVrwdTdXENdWSzLWG9RcEa4Naq872RDRDK49/c=;
  b=ZzQd7gcvdquPn2wx19HV9b7/z3334va+Zct0lgWUniiIBnzE8cYUgNjn
   3Vf5kU4aDdxpDkTZEIXf9FG8+yJq18gyHVUwUVCUAzUeAs5yP7Yp1pF3v
   /ogUI3lZnqsLiELwHkNmhB0f64TRbL53b7tnQxK/WK6CUdvvn+bCzNadi
   FW3kI4KLgcsnE5E3PZB9JUhL72IPLI1vXyjJ85WSH6DBr4lNLZHtT7/fd
   C4dIUBgZ/7FtoMWg+U4fKssFQFNfvJUxGbELvxK/JU8FmQBYko2U+rWBm
   WB41bQ8dPjzeJgO8NTYnYnl5SxtWVmAblykYk0UASgOjr2eXGH+S/qBAV
   g==;
X-CSE-ConnectionGUID: ztusaaFLRou6y4G08Vb5CA==
X-CSE-MsgGUID: ZDQL67ZvRh6CpISUzPoWqA==
X-IronPort-AV: E=Sophos;i="6.24,186,1774310400"; 
   d="scan'208";a="21060292"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:07:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1103]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.245:2525] with esmtp (Farcaster)
 id 14e2a959-a9f7-4a99-8595-baffdae67689; Thu, 4 Jun 2026 08:07:22 +0000 (UTC)
X-Farcaster-Flow-ID: 14e2a959-a9f7-4a99-8595-baffdae67689
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 08:07:21 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 08:07:18 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Woodhouse
	<dwmw@amazon.com>, Zorik Machulsky <zorik@amazon.com>, Alexander Matushevsky
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt Wilson
	<msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Saeed Bishara <saeed.bishara.os@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2,net] net: ena: PHC: Add missing barrier
Date: Thu, 4 Jun 2026 08:07:04 +0000
Message-ID: <20260604080706.19366-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add dma_rmb() barrier after req_id completion check in
ena_com_phc_get_timestamp(). On weakly-ordered architectures,
payload fields may be read before req_id is observed as updated.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 8c86789d867a..297fb36ab8c1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1880,6 +1880,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			continue;
 		}
 
+		/* Ensure PHC payload (timestamp, error_flags) is read
+		 * after req_id update is observed
+		 */
+		dma_rmb();
+
 		/* req_id was updated by the device which indicates that
 		 * PHC timestamp and error_flags are updated too,
 		 * checking errors before retrieving timestamp
-- 
2.47.3

