Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967700;
	b=kTUInqV06eYE5X7hY/+4fKJPkPMZHU5u5VdAr/V5jCqHqyyRWh3EAfQGuBAWXzZjFl2o
	 8u0Y4PW+dwvvRvt/TznCK6X9NDvHDd5xQyD4ZsfcivW9XDarDXrzrd5TiSZK3bOU23KB4
	 SDSue+abYC+0nu6s0/79Pjw9a9JKDblzlr2VFpTjB0B4WRmLGztGNyhcqsDT+aU8mkXmk
	 iN78AUgOGBRdrSMp/w6E4dZ4VJHn4Chn9IsyHgIkvvUYnYsP+SAhbL39LbIDGHo2/PLxW
	 7VgBVuabpryiuDJFu1p/jj+J5we07JhTXTDpCxHY4ndyY2f+1LbMUrhjQlwW16jBMMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967700;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=Qn/RhPLFe7eM2gOJPShYS3JZVu2J5rMSgiNX2tNxYRk=;
	b=lozNVT44xKHmSP5zy05nlJ6S6VN7VQ2X6d2Ys4jfl7sOvxozCAOujhSwYXpNheUZXqU3
	 tLQvNuDzSm3eFCOJl1oRPhbbJooSdpqjRj3QU/Pvl6cTodtFuKZXG9msPhp6nbBcKb7Yh
	 WE6eWUT87lf5Y9PwbMO5K8IE8vo0Xcq8fWmLSe0O267T6q7eOH+2HoLiwYgBKeksK5Uk4
	 gsXDyT1b7PjrlZpaOa82hcSd6OXxrPzkLFckY7pikMUzmTkZkNiUETaoR0u8IvdtCj3l4
	 /a/y/UbJBtzj0BcDlWeD+VW3Rez9tMETD5AbsWauJCDrWqirlBcOPX5PT71CcbQcJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IMz99JC7;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AC606A326;
	Fri,  6 Nov 2026 12:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA0AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IMz99JC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793967699; x=1825503699;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=iZGWGigFbhC9MrM8azfnVKSspKL7hUqD96apEFTUXBc=;
  b=IMz99JC7kKmoQ0czDUeeP8MhmexnWtjoB4y7Y9fcJTtSUeUWQcF5G1qa
   LZflHJasMxIOWCi6oI4WsDshZqkWThcZMtFA9sSmWfWq6zKCgevnaRPGV
   zNgI3H83TWuS0OdqCRR+O26dWvWVJ6ixWCdjpVLRx0a6MFbNvZPSINBm4
   1cgI8wH3W9NF5Kt90zME+IDZ9OTg7nfJLdIstX9R/lNZgh6JxFTZe5UDx
   L1unlZRdNXEE/67YK1nyK+jRE18KLeBAz9sdU0Q0Mj901GJoq/KL+xaWp
   yYu3rbaHLb5BUCS1+UUrLO/KdBc17b4YaQDEEdii55Zsq3DgwqwB9nRGI
   Q==;
X-CSE-ConnectionGUID: LIMx5t7+Rba3YaoGHNWEdg==
X-CSE-MsgGUID: HcP1GZoTTEG/h7kAFQZ/Kw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="297557753"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2026 05:21:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Nov 2026 05:21:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 6 Nov 2026 05:21:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Nov 2026 13:21:22 +0100
Subject: [PATCH net-next] MAINTAINERS: Add myself as maintainer of the
 lan966x driver
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-lan966x-maintainers-v1-1-476bfb921aca@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEHG7WoC/x2MwQrCMBAFf6Xs2YUkxkj9FfEQzKtdqFtJQgmU/
 ruhhznMYWangiwo9Bh2ytikyKpd7GWg9xz1A5bUnZxxwVrjeIk6htD4G0VrB7mwx3Xy5p7CzSf
 q5S9jknZen6SorGiVXsfxB7zhFGNvAAAA
X-Change-ID: 20261102-lan966x-maintainers-4e3f407d654d
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

Horatiu is busy with PHY work and will not maintain the lan966x
driver for a while. Until then I will look after it, so add
myself as a maintainer to have lan966x patches routed to me as well.

Acked-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe23913b1e432..eec511996f845 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18312,6 +18312,7 @@ F:	drivers/net/phy/microchip_t1.c
 
 MICROCHIP LAN966X ETHERNET DRIVER
 M:	Horatiu Vultur <horatiu.vultur@microchip.com>
+M:	Daniel Machon <daniel.machon@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained

---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20261102-lan966x-maintainers-4e3f407d654d

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

