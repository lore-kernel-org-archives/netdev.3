Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565214;
	b=lhqQGQdD/hnTLTZc4STqv1GQMr4nF0Kx6ZkdrehTZpnWNUqSZsekHXGc7K7nodkehd4K
	 1tSTdgen9YEq40LgHoHn8DEHCYdrGHgLJWGIAjbe0YDN9V1/8EaPXKhK9C00aL3RSe2M2
	 yj2YsiV+v0x+ZuoosJ0nVOQxvRh7fnb8wC99DNGWtkHy6LKI8UfSXV6J8HlMmUaGDuKUL
	 mti1B8it7/fn9d9u0iyd7RE201njM2aQGw8Zw4hqePkYAnZ+P9DI+am9WaToKjNI1K+Av
	 Mxo9xVeZDP0q7+DYt/I8UpMQAUKsXeYDlH4Ao233FPTm0yil02XajZHkO4rZJuLT3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565214;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=5Uh0zn+Pbz7j6JKScOi5Lfgqxhy0yva3BbTuHFRB72g=;
	b=1XkVUU0j6+b0OT4/JCBA0wNriLbjBER+0xoC8y9xZSD2uiJNRqvEP3sWTE5uXtw0DOBC
	 TjwU7+PLVZZDHURsvinuJEOetLYGTSBrtX0/Y+z7LJR99bwYwB7etn9doBt3oWK7/IfqK
	 D1H8l/o5xj634dFxiE1niYOlMN47D+zSZHbeLYYqGaFx4QfYK5S43ByZDi8tnVrUGNv4H
	 BUWAsXj8eHGjFjRCaBdHE8RqX+kor1ogw4GYqAQAEfOIewgNjw6w9EMXi7D+CfAX4q5mB
	 ItbRT0faJijiI7QKpfmaZb0zv02sUf+j8beTm2MvXsaXRbDSywRVeGFeSpp+VA5MY/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=qkozkvj7;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135D60A260A;
	Fri, 13 Nov 2026 10:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0135D60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=qkozkvj7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794565214; x=1826101214;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Hv2lGe+rUPFOVDCKN1Cx1wXy4zSUr6oszD5pqm7SajA=;
  b=qkozkvj7hxAwzUCa+Lm5DSKpsVyNl5nnYX1E5QnlFGh7n/28Q4DaLh/B
   PyAYySR8hjqwGYvVBPAKETjYsjWHSNv4H/ssFpXuxVT3ozVwQBO0aNh2e
   whIZYSTFe6iOuYEo1NbqmQA/Altcpj/B2EcgpuSkGDNfY5ya1ZlCdXmHD
   ElqsfhpCr6/47tlW+Lm4RV0YXrYRWJ2PfUjh2APiBy9gTFJJ6h5Gu8Qz3
   Cu/BL+pawozoB8s1ngHVw96r3ZvogCEhL3QO/Q6otN/la+JsrnhmQO4Vw
   OF94EX7wD65axuJY3qqAtC7RfMujiezCrg4iinkW6N6R09JgGljtNNU3C
   g==;
X-CSE-ConnectionGUID: bNar/TdCTrWLJqQXewwtRg==
X-CSE-MsgGUID: P06oSSFoQ4CebaM+UoqnoQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="66461933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 03:20:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 03:20:13 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 03:20:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Nov 2026 11:19:43 +0100
Subject: [PATCH net-next 4/4] net: sparx5/lan969x: scale the nominal TOD
 increment in adjfine
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
Message-ID: <20261113-lan969x-core-skew-v1-4-b9b02b863d38@microchip.com>
References: <20261113-lan969x-core-skew-v1-0-b9b02b863d38@microchip.com>
In-Reply-To: <20261113-lan969x-core-skew-v1-0-b9b02b863d38@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_ptp_adjfine() builds the new TOD increment from two tables: the
nominal increment from sparx5_ptp_get_nominal_value(), and a one ppm
step from sparx5_ptp_get_1ppm(), which it multiplies by the requested
ppm. Nothing ties the two tables together, so they can get out of step.

They already are for the lan969x 328 MHz core clock: the nominal
increment is derived from the skewed rate, the one ppm step from the
328.125 MHz default. A 1 ppm request therefore moves the increment by
1.0002 ppm.

Drop sparx5_ptp_get_1ppm() and scale the nominal increment directly with
adjust_by_scaled_ppm(). The sparx5 core clocks are unchanged, as their
two tables agree.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 49 +---------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 544e9513a9a53..e37635e8fd730 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -22,37 +22,6 @@ enum {
 	PTP_PIN_ACTION_TOD
 };
 
-static u64 sparx5_ptp_get_1ppm(struct sparx5 *sparx5)
-{
-	/* Represents 1ppm adjustment in 2^59 format with 1.59687500000(625)
-	 * 1.99609375000(500), 3.99218750000(250) as reference
-	 * The value is calculated as following:
-	 * (1/1000000)/((2^-59)/X)
-	 */
-
-	u64 res = 0;
-
-	switch (sparx5->coreclock) {
-	case SPX5_CORE_CLOCK_250MHZ:
-		res = 2301339409586;
-		break;
-	case SPX5_CORE_CLOCK_328MHZ:
-		res = 1756832768924;
-		break;
-	case SPX5_CORE_CLOCK_500MHZ:
-		res = 1150669704793;
-		break;
-	case SPX5_CORE_CLOCK_625MHZ:
-		res =  920535763834;
-		break;
-	default:
-		WARN(1, "Invalid core clock");
-		break;
-	}
-
-	return res;
-}
-
 static u64 sparx5_ptp_get_nominal_value(struct sparx5 *sparx5)
 {
 	u64 res = 0;
@@ -407,27 +376,13 @@ static int sparx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	struct sparx5_phc *phc = container_of(ptp, struct sparx5_phc, info);
 	struct sparx5 *sparx5 = phc->sparx5;
 	unsigned long flags;
-	bool neg_adj = 0;
 	u64 tod_inc;
-	u64 ref;
 
 	if (!scaled_ppm)
 		return 0;
 
-	if (scaled_ppm < 0) {
-		neg_adj = 1;
-		scaled_ppm = -scaled_ppm;
-	}
-
-	tod_inc = sparx5_ptp_get_nominal_value(sparx5);
-
-	/* The multiplication is split in 2 separate additions because of
-	 * overflow issues. If scaled_ppm with 16bit fractional part was bigger
-	 * than 20ppm then we got overflow.
-	 */
-	ref = sparx5_ptp_get_1ppm(sparx5) * (scaled_ppm >> 16);
-	ref += (sparx5_ptp_get_1ppm(sparx5) * (0xffff & scaled_ppm)) >> 16;
-	tod_inc = neg_adj ? tod_inc - ref : tod_inc + ref;
+	tod_inc = adjust_by_scaled_ppm(sparx5_ptp_get_nominal_value(sparx5),
+				       scaled_ppm);
 
 	spin_lock_irqsave(&sparx5->ptp_clock_lock, flags);
 

-- 
2.34.1

