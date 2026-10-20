Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456534;
	b=14dYpMpdv6B6GsqvE+7J9+jVvWc8Gvf9R9nDWa5G+WPJFTqECNMbyd4tlde7Ht0gkYEM
	 j5QhlT1KgPl6ZDwHR6ss8+XmPRcsvp/3yd+5jSX/gI16BccRB1hviz+OXlTTtcjMcDwVi
	 ZQG89M8zdpeSSfiT5VfGUef4QLrZeACv/aQEcq8ElHjSgMUxHELWcGGO58gHigSd4DajN
	 pvIo0/71YSDFyWkVgwQ3SGapprAkmA578UG6B2WMbmXbmq+F1rZVvs63wYe4WYMO7XBY5
	 Soa10EN4e2XMit4KZV9w+Uvzaufr4JlJQKRAQ16I3SUYOs7IPMgpmWXG7l2uLZBEkSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yipExmIrTD12/1N9UAm4uOC0Smz6xuSmoLIiL1iv6ME=;
	b=y0rME26fycPHcC11p6nOj92q517e+fsSBo5+6pQ5I4Z5wp3Vsiot4mic3m57QWfQxxgZ
	 N8UKek35Dyl1aM3m0qJC6b8m5twZ/ymIIM0PDOzNZK7JjJk+MFZp+5QeFXL4tJN0YLwOk
	 kNe8EmZICiUCm62SLYcyvG4+IFHu+RGXwaCClqNH/wOFoin9HCxkjFEWcn+AH+YVjBX+H
	 7DPuXW23NZwuFFDly+6lTj6dEw93GUO2uqI283ZN92VlR+5yRkCYcF5ApjYZNU/gRfSfN
	 iZjDQi8bM5mFC0c8NXA35eLlaueTTlrQQIwkJQQSSzlseI6IjrXZxdrwT2CFdpdst5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AzHXSm+Q;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E2606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0E2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AzHXSm+Q
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987a2ba0cso22104585ad.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792456533; x=1793061333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yipExmIrTD12/1N9UAm4uOC0Smz6xuSmoLIiL1iv6ME=;
        b=AzHXSm+Q8Fe894xwcN/n2nwtglUvPzzk12UXp5P6sOG2XezLYcUXtlP8iA8ljA+frg
         YTMa65772oOUDpIBljZ8n48K/WGe27YyCQZSU8rKT56T4C+uT2XJDwIgtKCuk9hiaMB9
         xIRFPyBms5dVRg6O+ojjCke3ra1wWNDHvoKRMsgCwPo3UMNHvKpa/3leT6kZSXAwpghS
         3/MMb/0eUMFi32M8UOOGfPpoJBosc74XePAsoxzjLBbsTNrahLtJW7lRPMM/LZYwALau
         1jZzA4rLrpHXgrt4Ht9HQOdni98Pjo4EXa63PjnVK2USa6n3XuMwBhg4Vm0dLGrrUsbX
         c2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792456533; x=1793061333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yipExmIrTD12/1N9UAm4uOC0Smz6xuSmoLIiL1iv6ME=;
        b=m+r983v7vOK59KxwRCzDagSUBdgpYJ/L9B2a4b/uEB/LyhFn8QI5pqxxsXuCcw5fSB
         LRR1nCaJCN+15UvF/wKDyFzPYpAeFjTs68gn1fl5tHrEceYlU8M6vzKsaLxXQPOwZJDR
         BUujrx/LvOSnXN9MXH9ce/yA+pexKG7Bss8oRAm1yOAoDx/MYTBJfLFukCGzP2IthvMc
         IqpY1pITh06MS2yKIR6/wf791ef8Krm8/J2XIRPtsfK7g/t252A93pgfV/Rq7d/MjTrv
         XM7w6oJIdGqjx4HPtgMZjVQthJl4ArMgQAZpfIxctzLMxXYgvdcXKLPiPtqA8+joXH/5
         LQFA==
X-Forwarded-Encrypted: i=1; AKwUvBz2kdY+E8tfHlU92OQfO51Rm+A1pK2xcIQmAMRAHd8qloL0Nt5V2BfQQ5boujBe/RYPnXtHt/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTM+AcPmj5+PgnApRdjazFtPB/ZKP/MlmUoUg0PPJ0uKJcZJ2b
	bBTNyA6gdu/1VTcco6Y1ZhWdHrDFa9pQc8i2eFqyIPm8mjX2UXFZECHYNFq7yPQVyQ==
X-Gm-Gg: AYBFou2X2XoxOv5nqkOebKbqGoz+lN4iqDuIT7rsbNTuNp/y/Keee3nR/27n7SI3Yc0
	RE+sy4Q2d+QmQEnZ0tEjFS3+4psYnTS+AI+Bijc5b5na4P79CJx5afYneb7p3wemRvRpP/PSs3y
	1R6tBPFaIRksvO0ZjK4ir1bLK8om7rZGzkz7yiCE23+glOdRPASsWO0xKwjWJxhE3JjRX60Uxnl
	c6PjWHgB0AnXLRmj59wPr4Le2Aj1l72lcDsUZ4lA2W9wbW33mLRBYiksFdTUEhDTPrkOppxaVbh
	2KKx1XibfrnfukdWuo/XYOjo08OuEvqM3dn/Xw5m8d2w7gtuxn25v497hkJGC9dJCIeZVx3IwnS
	GNUyHgcu/A+dmR5ZdUtJ+YefGdYIKjRrYLzn6ieWtX1HVHlrGKJuY/XRvS1P0gX3LodHYsF4Was
	L0kVhvFZ8XK+JiHeF003EguQcvtNXbA3HuI2fHpc28pcQtR5/WnkfEMjwm9frDWCLztGA+MzmES
	SST1KAjYhk0yNsWjq9N4R6erXJxlVx3UsgJusb6SpyKh1E6QhYgZVBGTWi2KLc=
X-Received: by 2002:a17:902:ceca:b0:2e4:4eed:5cc5 with SMTP id d9443c01a7336-2e9a6c1df91mr80141435ad.38.1792456531600;
        Mon, 19 Oct 2026 17:35:31 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14caa857sm6836175ad.12.2026.10.19.17.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:35:31 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl
Date: Tue, 20 Oct 2026 07:35:25 +0700
Message-ID: <20261020003525.1237742-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") modified the PTP core to validate the supported flags
of external timestamp requests, rather than relying on each driver to
check them.

am65_cpts_extts_enable() ignores the flags, and am65-cpts was not given
any .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for this
driver with -EOPNOTSUPP, where before that commit the same requests
succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.

Tests on a BeagleY-AI (J722S) show that the CPTS hardware timestamp push
inputs timestamp just the rising edge. Encode this in
.supported_extts_flags. A PTP_EXTTS_REQUEST2 for the rising edge then
succeeds, and one for the falling edge or for both edges fails with
-EOPNOTSUPP.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: James Clark <jjc@jclark.com>
---
 drivers/net/ethernet/ti/am65-cpts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index efbf2ef976a..df5659ead72 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -779,6 +779,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp);
 static struct ptp_clock_info am65_ptp_info = {
 	.owner		= THIS_MODULE,
 	.name		= "CTPS timer",
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine	= am65_cpts_ptp_adjfine,
 	.adjtime	= am65_cpts_ptp_adjtime,
 	.gettimex64	= am65_cpts_ptp_gettimex,
-- 
2.56.0

