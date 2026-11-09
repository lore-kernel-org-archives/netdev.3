Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191462;
	b=yqeIQ7WxdfP6VYMoRoSAwXWXZrhA4bW7oho41WgwWekpIhXBDCP4HBUqiZH6cA+1nGoQ
	 DaW54j7rGcfwC8uv2gOQSADATns+sSMQGzOHFNH5lRy5TgVJGHS2ZJWY4DUSfY/1N+1In
	 ttExRoVgSWX9Xf7CAmggDcgz9zTQ6bnXL/VDRATOL+4wd2YfLGl51G03P06MyOP/2i+az
	 9MIpcHZLhwQEVzWFdyOGqYmxAI+UBihxMELVU+7qHwD31MVJvX82FgpnuO43nhKciwjLU
	 pNxv72k9pC/aNnst/3SL1zU6kBkZ5y1IG5dnNVnK/litd7BnZD7/T42tS4vKcjui7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191462;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=Sg7kFJ816o8kJgvC4j52qN4GkMxGSDm4Q8WgxVvur4k=;
	b=ywa0ADHggmSUTecX2DqW+4k5tQGynuZYR5ClYsq25IoexUrD77U2/BFwU8Xg8U/qE0L4
	 AEtcKdsYjPqch2tsuheO+YiOKJIr+T5V+fswnRx7/zOCZ1fZC9VEkcdPll0Jl/y/AhoxS
	 AP2gWXFBLnHAbxZ0PR13fiWbCyucR7MMy7cxFiHiB05N4ntbBWZ5X9rrETKM7C9SvSeFb
	 tO2uTrHc11moiGTQvkN6GVQ5HzunDjeT8DbNqiQZz1q+TfD7txS9y/CshD35xRJEF1+Er
	 s8IWiwhT1oPlLZq6ZxkggJ/YenZ9FocVtbc84xmvdv5xO5BlSDE2ZhJXDyh/3/c7rRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=rg+iY2Is;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C59606A31C;
	Mon,  9 Nov 2026 02:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=rg+iY2Is
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A92UPdY43939940, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794191426;
	bh=Sg7kFJ816o8kJgvC4j52qN4GkMxGSDm4Q8WgxVvur4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=rg+iY2IsbtT5E9DL609reaWoZPb4slw/PLSOTOsLuFqtD9sEU7Y1kSteF0dFP+gUy
	 dNkewB6H3SPOpTt+IPI2lVl4MurW7UcZIfNY18TPv5oK+7IDbrlQRjAgadf2cmlc3c
	 4XrEfFknaT96Bgrs8aNne9E0JJijDt3GWO1eRI+k1dvEd3INPlkDTro0miL4p5ujwp
	 i5xrF4rvkYOXBU9CfALvNigVUP0uQWVAgxYmREsWmqFCVGwA5kQeteYuuZTIOZoIZV
	 YhzocNuMANSpGBm/oXL1jjVZJ+G5UirpdVTMMIzOHaey9iTQtt3tbqHeJUyuLPgWvm
	 1hWKBe8nXrsWA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A92UPdY43939940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 10:30:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:30:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:30:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/3] r8169: add PTP support for RTL8127a
Date: Mon, 9 Nov 2026 10:30:19 +0800
Message-ID: <20261109023022.770-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series adds IEEE 1588 PTP support to r8169 for RTL8127a
(RTL_GIGA_MAC_VER_80): a PTP hardware clock and hardware TX/RX
timestamping of PTPv2 event messages. PPS and other auxiliary
functions are intentionally left out.

The PTP block is accessed through the PHY OCP interface, which may now
be used from atomic context, so patch 1 converts the GPHY_OCP access to
an atomic poll and serializes it with a dedicated spinlock.

Patch 2 registers the PHC (adjfine, adjtime, gettimex64, settime64)
while the interface is up.

Patch 3 adds hardware timestamping via ndo_hwtstamp_get/set, reports
the capabilities via get_ts_info and the TX timestamp counters via
get_ts_stats.

Javen Xu (3):
  r8169: make PHY OCP access safe in atomic context
  r8169: add PTP hardware clock support for RTL8127a
  r8169: add hardware timestamping support for RTL8127a

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/Makefile     |   2 +-
 drivers/net/ethernet/realtek/r8169.h      |   2 +
 drivers/net/ethernet/realtek/r8169_main.c | 113 ++++-
 drivers/net/ethernet/realtek/r8169_ptp.c  | 556 ++++++++++++++++++++++
 drivers/net/ethernet/realtek/r8169_ptp.h  |  58 +++
 6 files changed, 722 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/realtek/r8169_ptp.c
 create mode 100644 drivers/net/ethernet/realtek/r8169_ptp.h

-- 
2.43.0

