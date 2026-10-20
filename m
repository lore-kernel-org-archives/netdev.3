Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486727;
	b=UT6mrKAhlnt9y9nvV2TcAjcG70fZbnrqQq73A5tz5SeifwPysxyQo9MID5uqA91Sbz1I
	 Q53fjDppAnHm7kcE/WILLI+3uoLulnd1wGk+3HBNCnXHTw6SXwmLgZtkwzdy565nWfwsM
	 cG4FnQ14kIfUQ/LYBBypuxSWaP6YMJsdt5EGod6Jgxjlp1gU7QKIPwSHZNsigttd4rtv0
	 785+dYkZ69TYKxUMsES6yBg+mOmHewAIJgrUF2pTh4DnUm1yTgy3g5WtfZKnpLeoQo7Yx
	 iZr6F/Rw4ydXo2OZFvqOjTMpDsh0pe5LH2dCnSsjNSkiLrHqmm+K2ldjmrudLsTLx8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486727;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=OatRvA2g2ft3qrMPP2PToIR4b5mZwUWsvSN9SYAtqFs=;
	b=DvsD1fzcbGrJwweU/R7q6+sbKweN8X+C/nVFhMdgmbKTV87SUmsU0v5a1gDPqdRqV/mG
	 y7At/tvTliIa6EEekXF4nPf6VIrkwkFaytKZCJ7UU5dVybazM3Lhp0m/TxHS7TSgiwBHM
	 xFyvtDLcM6hpBAgLrJru2TFtida5x8wGGCjCBDNZD1zIdvI+VnTIVISKpATcKf6WF7jZ/
	 gtSWzHm90CGtFxBwAjJZiNwGKayMzhUnkNuF018FGS2LL75D0eIOVAzgGK3MF4dgVNqFH
	 R+UtwYw+0c+ds97QI828sA0ArmCiD9gDv7CVY/hrtmREIdhuU7ReXRZ1Rey40DloiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=CYaDXHqV;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36D606A31B;
	Tue, 20 Oct 2026 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF36D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=CYaDXHqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792486726; x=1824022726;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=o4RlZx6NY4ZXP1UWTvwYZ3cQmizRyKcWC1/bfyI80oE=;
  b=CYaDXHqVs1ner67tJhrOEhdpvgUG+nMEEjdRRdSqU8yksYl0A2/vdzwx
   qOreop4+A4OkybWUnyzYf88oIlq4o9o8c0hC0JTrvrgmKMOTz44ZqQaoR
   kYCU0xocuh4iDm8TRfvXCYipDU373ppHKtzPNjh0RrGdKJWBXCPv29AbK
   Y0JW/zP7CwQdD5myen284LEtUhC+HIn0Qkbou4dOWOUdUqrVs8tp26s5U
   3KkGIw8gHuGf9rpJ4QptP/q4qeieYO+jhtOJxnCXSEwv/7lvHEENDM17x
   ODYRc5bO/tdTUUtnhAYdAy615an8XWyifn4cn2q9smDVpibf8JdfMTNS9
   g==;
X-CSE-ConnectionGUID: vF/0hLSBSY6Ft+BMIv4DiA==
X-CSE-MsgGUID: WyYidqJgRvOfgo1a1o0pAg==
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="64343655"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:58:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 20 Oct 2026 01:58:40 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Oct 2026 01:58:38 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 20 Oct 2026 10:58:35 +0200
Subject: [PATCH net] net: lan969x: fix DSM calendar for empty taxis
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
Message-ID: <20261020-lan969x-dsm-empty-taxi-v1-1-14790f1e7430@microchip.com>
X-B4-Tracking: v=1; b=H4sIADot12oC/x3MQQqAIBBA0avErBsYWyR2lWghOtVAWaiEEd09a
 fkW/z+QOAonGJoHIl+S5AgVqm3ArTYsjOKroaOuV6QMbjaY3hT0aUfez3xjtkWQHGlPdtbaO6j
 xGXmW8o9HCJxhet8Pryu3FG0AAAA=
X-Change-ID: 20261019-lan969x-dsm-empty-taxi-0c07d0af77dc
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan969x_dsm_calendar_calc() computes the DSM calendar schedule of one
taxi. sparx5_config_dsm_calendar() calls it for each taxi, reusing the
same sparx5_calendar_data.

Before this patch, the schedule is only cleared after the n_devs == 0
early return. For a taxi with no active ports, the function writes
SPX5_DSM_CAL_EMPTY only to schedule[0] and leaves the remaining slots
at whatever they held before. For the first taxi that is zero from
kzalloc(), so sparx5_dsm_cal_len() returns a bogus length and
sparx5_dsm_calendar_check() fails, which fails the probe:

  Port 0: distance 20 above limit 0

A later empty taxi inherits the previous taxi's schedule instead, which
passes the check, so only an empty taxi 0 triggers the failure.

Clear the full schedule up front on every path, and on the empty path
place a single idle marker (SPX5_DSM_CAL_MAX_DEVS_PER_TAXI) in slot 0,
so the update step sees a calendar length of one and programs one idle
slot into the hardware, matching what sparx5_dsm_calendar_calc() does.

Reported by a customer whose DT enables none of the ports in a taxi.
Reproduced on lan969x by disabling all taxi 0 ports in the DT.

Fixes: 5d2ba3941016 ("net: lan969x: add function for calculating the DSM calendar")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c
index e857640df185..4442c0c1a957 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c
@@ -82,6 +82,9 @@ int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 	struct lan969x_dsm_cal_dev_speed *speed;
 	int err;
 
+	for (u32 i = 0; i < SPX5_DSM_CAL_LEN; i++)
+		data->schedule[i] = SPX5_DSM_CAL_EMPTY;
+
 	/* Maximum bandwidth for this taxi */
 	taxi_bw = (128 * 1000000) / sparx5_clk_period(sparx5->coreclock);
 
@@ -125,7 +128,7 @@ int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 	}
 
 	if (n_devs == 0) {
-		data->schedule[0] = SPX5_DSM_CAL_EMPTY;
+		data->schedule[0] = SPX5_DSM_CAL_MAX_DEVS_PER_TAXI;
 		return 0;
 	}
 
@@ -167,9 +170,6 @@ int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 		return -EINVAL;
 	}
 
-	for (u32 i = 0; i < SPX5_DSM_CAL_LEN; i++)
-		data->schedule[i] = SPX5_DSM_CAL_EMPTY;
-
 	/* Place the remaining devices */
 	for (u32 i = 0; i < DSM_CAL_DEV_MAX; i++) {
 		speed = &dev_speeds[i];

---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-lan969x-dsm-empty-taxi-0c07d0af77dc

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

