Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDD476691;
	Thu, 20 Aug 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235951; cv=fail; b=ZwJcYFQ9qxvZUYZk9PukAO3bmRCKt6u6/3zby0Y3DPzO2Ag9ESKIt+L5egNr7Fw7DNmJzJaZnpepipb28fQVkLzmUNSfswEBYgryugUAYe/RMdFNxAPTEw6b9k+SDVQ9eoAGUu0KuIq2JLcO5MlwSuNXEnP8NVupEbeMeK35bEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235951; c=relaxed/simple;
	bh=5PRzGNWj48c6Xrpl4gQKbw2PQNZoMjYoytVdfbWwHGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2qQBlNsyyurwsnSWZer4QHVuKxZ/k5Rx0mSHSucnQhhLok1z3f3ZSn+R/dIuPYM0XoyLqxA4UMBN8j6j07LDZBAPsmpRf+eN1WBztfXXREx8P0jfxV5aLcf9/QKdOjItsdvT1N3C5e+62agdVRvPa0bPmG+i1FiDE/vvCsKwqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=hQK5YS8e; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="hQK5YS8e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhBG2oy9uAXNziVOItA5nKpKqeqanuv8RHTxkVL1FbCiMlXaNmiLjLlsBUOu8uwGcrM4Cm3wf7yUcxxDhzKkkU3l5QaRT3ivIVaUS06WUOb02yAFUS2mV5uGXyHAUvl27iCgFdF5MkmZU/9aIfWUjddzpyjgc3/zxrHEWo2ZL6Wr+LbjMGxRHJYxWYOdOGpLKeqoW+sbLxOwnWis5YQiy3f/1LG+CexBl/RaBJ44sj6RgtDqd0kcaqP+E6U346CUlWrN6jpmOp9IAsy6QGas2cApHCLhhfThMLS5yazDDLYubYBW7YpIeAek3PyN4KMJH045pF0/ETtqoHjqjrcO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+8KVW1uSF7Pam1I2jR45HkZbjQ2ANUDyC40b4ao5o0=;
 b=r5W5N26CJ+QAxzoOZJg7VTBMoHnLqNJShtptUjBOAnMLZa/hDoGsg/oLh8t5kpsAXZiXPi0lw6oPzqjF35BpnWfWI4yWJlDfbr/Zf5XbtUK+zs+XjPc+OzvaO/d6GpZLv57dMLhSZyfdx4ExzfSZZA1LNaQn2SSg8lp2tO7GwxJ7YweUoZZJkY4NDE9HeVR/w8N8kQmzBYbT2s2gYZOixB9ORBsFzlAY+SpTyjxwFqDvZ7GSZYLCayNquElBzKuPmb6f1vjdxXKTw9WX1m24KWDFgyxRWj9H8PV8zbcvC8IRaaWetRToFFH2Xt2QPF85ul7yDkZ6wGxHrjdwN0klAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+8KVW1uSF7Pam1I2jR45HkZbjQ2ANUDyC40b4ao5o0=;
 b=hQK5YS8ep/GLGFtbyyft9rXhFJnfmq1TtM3Nu0j3ZR4mmoMSfY/JGlhNC6pAIQwhOg3mMa4+ek5ff1TYvhtQYkaKqnm5Y1bqam1Sv4fPeDtNMjknH96UrlgwrE0XbMIRv3hexA0it1R8jpa371i4q3UZQz5pAqNkHh8gKA12bgWQaoQH9Sr8xyiECLmh0pRUCm0tsLfUcxYKpt6Ju+kIm/45vCQbZN7+KnE7u44LDGKbkWer/5QwE6pEAUsdy+PoQdSij3183P7tJz1JkXz5KhvUoULWf/2BJn0V6ZMXJeUVweYDyhmg5sJzA/3rd16QeCXazz3nkfum/vlEnVb7GA==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by VI1P189MB2600.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.3; Thu, 20 Aug
 2026 14:25:42 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:25:42 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Kyle Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Roland_Kov=E1cs?=
	<roland.kovacs@est.tech>, =?iso-8859-1?Q?David_Nystr=F6m?=
	<david.nystrom@est.tech>
Subject: [RFC PATCH net-next v2 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Topic: [RFC PATCH net-next v2 2/2] net: pse-pd: Add LTC4266 PSE
 controller driver
Thread-Index: AQHdMK/IDCxK3gpwkkW/1vH9tmtf9Q==
Date: Thu, 20 Aug 2026 14:25:42 +0000
Message-ID: <20260820142429.2285172-3-kyle.swenson@est.tech>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
In-Reply-To: <20260820142429.2285172-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|VI1P189MB2600:EE_
x-ms-office365-filtering-correlation-id: 0ccf9019-62d7-49b0-669d-08defec6eaae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|6133799003|5023799004|10067099003|11063799006|56012099006|18002099003|22082099003|18092099006|3023799007;
x-microsoft-antispam-message-info:
 ih38LzqmQbsZ1FTsttWhbfFww2UsimRJPJDDGm+m11GPi3mXnZtxkdHK1EGdIijaYzC5lGqT/R9xr8ICrMI6bAAGL9HGXX3lU2/sNOWhOJRpIUKLMZwFyOICSSg5rAk1OnU9qKlmjH5mcnYJMjcotVt3kQpAG89cJyL1QDgeDWhAsCKUbYCFnLgZ01cexysmdivvQF3X6zdjQBXkR+GCrjSlQ33lgNfKgjC+/O9Fut4me4U3IeOp/+MMaQe3OiGdZsBR4Wtj11Fl0R1eD+a+xGRmZtVCocez06tcu1Dr8aywMzLcPFnzYvcRmSqbYY3BOuVBfvW6BcCEVkcs0T21YtMmG8x7KpIHfj9R/sYjlF1CosknjGTmJ265Z9ON9XYbllJ8z95CldDMP9HEWe6welxig1vFxqWmJnPbspH7tnOPvUeDERi4Wpqfee4OiXLFfrBWHoJYssKGVrZdD0n0/667jfc7jsa5t+tyn6hJog+ZybvDmMl349nQ4KEfFkeYSV1dqg26ouBLUBo/yOSXn4EVvFAomXmvyv4B/2sMQPuTmiVEYj6s6Tz6wNcPfoVUPoILKCCHt4cUFrViEs+LMc/TLhbln+/u3mDWpO75mTwx0Bgw9ODWzDV8hiLqX4fy+tndZzZClnqptfVhKK535dFvdmIZvD+4nxQoMCgQGxCAmvn6vkuBtLG91kmOIW9lhDIZXlByUc1uREOZMY5pcSJuCxUIgqp+tzIyTu7V4FtB4O9rOzr95atYz9tB6atj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(18092099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rOuSK32HzZATO5vBb9gsB3OAZTbqNabRX4jUH1B6mhhnr17mgU1z/sCs1v?=
 =?iso-8859-1?Q?KLlQI5UH3Hk2I5K7lDb5cjZrZtDMO7AMWlBt+gVuxGGgzpGArldXcuuoxY?=
 =?iso-8859-1?Q?0pVJEuAKDgn3El3ZVtb7m6wWQYFEltke5wJK6PY9lhKWJLXQNaYPfObnCT?=
 =?iso-8859-1?Q?24r4cCBTQRtKoFGFM3KGKRDyHcyj1Hw1686xBXZYRfW6laEiksoY8btadp?=
 =?iso-8859-1?Q?slPFpVVGiqmAy9YuzYJG83LohGAzqgcLnxm9ZZgR5onBUiBqZBcohcnTN9?=
 =?iso-8859-1?Q?BqTm+2TcX1WvcEU8mBbNb+NbvST730kyO4akp4HUz9kOdhpqHo1bq7bsJF?=
 =?iso-8859-1?Q?eu5D/jL0fP1wRdxE2/EV9Qp2R2ghaAFAq7eGzpwCHMA4zJJwQiphz2UM/e?=
 =?iso-8859-1?Q?TczqcG3mM1+8vtzjVK4RnQg4I5fbdgJm2zGnGtstfxsKlhTd2pEltKMNUU?=
 =?iso-8859-1?Q?QYgs6Cqx67YgQrf/bnV86eS0srWlZWBBoVoW4rhrm95pGrRiHWoDOKPk2X?=
 =?iso-8859-1?Q?5NjiOlvc8LauI+qPgwk+IbOPlfmxWNhjRwM11lZHfd8JQkPKyugjiQJZ9i?=
 =?iso-8859-1?Q?GpfFl8XLvOWoEDTGxs9Lpqd9I17cG/IoZM6oviSZlhkV9h9KPL4i/kRGOd?=
 =?iso-8859-1?Q?Ytw6yqNsLS4956U2QeEiTcLFv4bw7iL7S3UwurALG3gFn/ergMQCJBD+C4?=
 =?iso-8859-1?Q?mDs5cPLmurrhjf7d3iuI2IBg1EptdSByVEOxQLoOTg07tDj3WkAwjM47PS?=
 =?iso-8859-1?Q?A4xn/3Fbn9A1ZVEwTnoeN56hGUBqBVc/kCGYlf03bU4I4oXL6SI10fZC/5?=
 =?iso-8859-1?Q?PCSzX3IbXCsQPeAKqMiDVBfcUlDvBh7MBPVQtyxqB5dXXo8v6uAR883CEc?=
 =?iso-8859-1?Q?OjTwFl1mwoVRN5lT5bFAegTCjI0hTBTUVRxYnDAcBuhMq/Euqi5Yt2IcgC?=
 =?iso-8859-1?Q?HL43jBLXREpAx08O6CYh7rHeZyDYJt2mbfZgw+oPhwy3xufyMUxzksC8yU?=
 =?iso-8859-1?Q?rJK6LniOhutfnNNDqPcXsdtiiSf3KqrVrxTaTSnzJ1jVopwdy9VO5Ajd/l?=
 =?iso-8859-1?Q?UJv9dGkIWi7VMrlY55kgWu2JK8mkIBIMwLeXxTki3Dhoi7NpBUqFb0CmNa?=
 =?iso-8859-1?Q?5Try5jSUpz6b1AJVsbJQ0gxyVhlN8QqPDS1uPx00bzp5H2dw5VK16bwN4y?=
 =?iso-8859-1?Q?ERCARuXVKO6mCYQD3iWvNpKOUTXIefzmec1i7rFxTdeVI+o54qKBA0exJ0?=
 =?iso-8859-1?Q?12dAJeN3cNwiZ9vp+IAwhL5e49MJ9q6uIc3H3OlG9baxdWdknWPGVmu+lH?=
 =?iso-8859-1?Q?a87yaTtkWuEHIpK9GOF/Qffqm0neESg4vVzqgrYQR/BVm+cTzCB1mEURlw?=
 =?iso-8859-1?Q?BCQFWu+TdLQeBWm23vmXthwTel1kER+Cetzz7rfpwm9imjpejkUHbMryKD?=
 =?iso-8859-1?Q?9e6bOE+HDSZLeeoNvgInxWM1/943Op9XyGRcnWYNh2jvZ6AtxBZvGju9n3?=
 =?iso-8859-1?Q?roW0bAEl3n1wRujLJ/e4RyuLltW5iitQesj2dNatVC7TnhhhkDgZyU0Plc?=
 =?iso-8859-1?Q?6+I9zF1awvF4vrANEMP9hVxC8iqror826uTVj3UXn1c997QGjcuRz/WC/u?=
 =?iso-8859-1?Q?uLIuQHz9uQaZjccepTdgP5HH82IyQrZSzS7JFjb2tT+ujpOtqJK/abrbFR?=
 =?iso-8859-1?Q?rPO+PWcapeeqQ11A9sW6eBsCBhZiygQVnuz333JZTrsmPTZIcFhlRYCuj+?=
 =?iso-8859-1?Q?+ooJEot3XymFmKSRaG35JuDBgQC8jVKdq82Fp5ipu1YEv2ctIasvKktMTc?=
 =?iso-8859-1?Q?z5iMXKm30Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccf9019-62d7-49b0-669d-08defec6eaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 14:25:42.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWHHaBCVHTPlykXuzoxhDy1Sd14z4mG1PdHgQ3tG7khDTpgVQPXILcBSMqY2mZNJlFUl8MPpvmT9KzQvtq0Zqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2600

Add a new driver for the Linear Technology LTC4266 I2C Power Sourcing
Equipment controller and integrate with the PSE controller core.  The
LTC4266 supports Type 1 and Type 2 Powered Devices.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 drivers/net/pse-pd/Kconfig   |   11 +
 drivers/net/pse-pd/Makefile  |    1 +
 drivers/net/pse-pd/ltc4266.c | 1305 ++++++++++++++++++++++++++++++++++
 3 files changed, 1317 insertions(+)
 create mode 100644 drivers/net/pse-pd/ltc4266.c

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index a0f2ae668c67..844c1b237df7 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -46,10 +46,21 @@ config PSE_REGULATOR
 	help
 	  This module provides support for simple regulator based Ethernet Power
 	  Sourcing Equipment without automatic classification support. For
 	  example for basic implementation of PoDL (802.3bu) specification.
=20
+config PSE_LTC4266
+	tristate "LTC4266 PSE controller"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This module provides support for LTC4266 regulator based Ethernet
+	  Power Sourcing Equipment.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc4266.
+
 config PSE_PD692X0
 	tristate "PD692X0 PSE controller"
 	depends on I2C
 	select FW_LOADER
 	select FW_UPLOAD
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index 9cca5900fe34..c3fe4efcf1de 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for Linux PSE drivers
=20
 obj-$(CONFIG_PSE_CONTROLLER) +=3D pse_core.o
=20
+obj-$(CONFIG_PSE_LTC4266) +=3D ltc4266.o
 obj-$(CONFIG_PSE_REALTEK_MCU) +=3D realtek-pse-mcu-core.o
 obj-$(CONFIG_PSE_REALTEK_MCU_I2C) +=3D realtek-pse-mcu-i2c.o
 obj-$(CONFIG_PSE_REALTEK_MCU_UART) +=3D realtek-pse-mcu-uart.o
 obj-$(CONFIG_PSE_REGULATOR) +=3D pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) +=3D pd692x0.o
diff --git a/drivers/net/pse-pd/ltc4266.c b/drivers/net/pse-pd/ltc4266.c
new file mode 100644
index 000000000000..2f9c37ebf1d2
--- /dev/null
+++ b/drivers/net/pse-pd/ltc4266.c
@@ -0,0 +1,1305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Linear LTC4266 PoE PSE Controller
+ *
+ * Original work:
+ *    Copyright 2019 Cradlepoint Technology, Inc.
+ *    Cradlepoint Technology, Inc.  <source@cradlepoint.com>
+ *
+ * Re-written in 2026:
+ *    Copyright 2026 Ericsson Software Technology
+ *    Kyle Swenson <kyle.swenson@est.tech>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/ethtool.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define LTC4266_REG_ID				0x1B
+#define LTC4266_ID				0x64
+
+#define TWO_BIT_WORD_OFFSET(_v, _pid)		((_v) << ((_pid) * 2))
+#define TWO_BIT_WORD_MASK(_pid)			TWO_BIT_WORD_OFFSET(0x03, (_pid))
+
+#define LTC4266_IPLSB_REG(_p)			(0x30 | ((_p) << 2))
+#define LTC4266_VPLSB_REG(_p)			(LTC4266_IPLSB_REG(_p) + 2)
+
+/* Current-sense scaling, in nA per LSB, selected by the sense resistor.
+ * ltc4266_read_iv() divides by 1000 to return microamps.
+ */
+#define LTC4266_IP_NA_PER_LSB_RSENSE_025	122070	/* 122.07 uA/LSB */
+#define LTC4266_IP_NA_PER_LSB_RSENSE_050	61035	/* 61.035 uA/LSB */
+
+/* Voltage-sense scaling: 5.835 mV =3D=3D 5835 uV per LSB. */
+#define LTC4266_VP_UV_PER_LSB			5835
+
+#define LTC4266_RSTPB_INTCLR			BIT(7)
+#define LTC4266_RSTPB_PINCLR			BIT(6)
+#define LTC4266_RSTPB_RSTALL			BIT(4)
+
+/* Register definitions */
+#define LTC4266_REG_INTSTAT			0x00
+#define LTC4266_REG_INTMASK			0x01
+#define LTC4266_REG_DETEVN_COR			0x05
+#define LTC4266_REG_FLTEVN_COR			0x07
+#define LTC4266_REG_TSEVN_COR			0x09
+#define LTC4266_REG_SUPEVN_COR			0x0B
+#define LTC4266_REG_STAT(n)			(0x0C + (n))
+#define LTC4266_REG_STATPWR			0x10
+#define LTC4266_REG_OPMD			0x12
+#define LTC4266_REG_DISENA			0x13 /* Disconnect detect enable */
+#define LTC4266_REG_MCONF			0x17
+#define LTC4266_REG_DETPB			0x18
+#define LTC4266_REG_PWRPB			0x19
+#define LTC4266_REG_RSTPB			0x1A
+#define LTC4266_REG_HPEN			0x44
+#define LTC4266_REG_HPMD(_p)			(0x46 + (5 * (_p)))
+#define LTC4266_REG_ICUT_HP(_p)			(LTC4266_REG_HPMD(_p) + 1)
+#define LTC4266_REG_ILIM(_p)			(LTC4266_REG_HPMD(_p) + 2)
+#define LTC4266_REG_TLIM12			0x1E
+#define LTC4266_REG_TLIM34			0x1F
+
+/* Register field definitions */
+#define LTC4266_HPMD_PONGEN			0x01
+
+/* For LTC4266_REG_TLIM* */
+#define LTC4266_TLIM_VALUE			0x01
+
+/* LTC4266_REG_HPEN, enable "High Power" mode (Type 2, Class 4) */
+#define LTC4266_HPEN(_p)			BIT(_p)
+
+/* LTC4266_REG_MCONF */
+#define LTC4266_MCONF_INTERRUPT_ENABLE		BIT(7)
+/* Only report a detect event when the result changes, not every cycle */
+#define LTC4266_MCONF_DETCHG			BIT(6)
+
+/* LTC4266_REG_DETPB */
+#define LTC4266_DETPB_CLASS_ENABLE(_p)		BIT((_p) + 4)
+#define LTC4266_DETPB_DETECT_ENABLE(_p)		BIT((_p))
+
+/* LTC4266_REG_STATPWR */
+#define LTC4266_STATPWR_PG(_p)			BIT((_p) + 4)
+#define LTC4266_STATPWR_PE(_p)			BIT(_p)
+
+/* statp<n> (0Ch-0Fh) detection result, and the "Signature Good" value */
+#define LTC4266_PORT_CLASS(_stat)		FIELD_GET(GENMASK(6, 4), (_stat))
+#define LTC4266_PORT_DETECT(_stat)		FIELD_GET(GENMASK(2, 0), (_stat))
+#define LTC4266_DETECT_GOOD			0x4
+
+/* if R_sense =3D 0.25 Ohm, this should be set otherwise 0 */
+#define LTC4266_ICUT_RSENSE_025_OHM		BIT(7)
+
+/* if set, halve the range and double the precision */
+#define LTC4266_ICUT_RANGE			BIT(6)
+
+/* I_CUT is programmed in a 6-bit field; each step is 18.75 mA (18750 uA).=
 */
+#define LTC4266_ICUT_STEP_UA			18750
+#define LTC4266_ICUT_MASK			GENMASK(5, 0)
+
+/* Cap I_CUT at the suggested value for a Type 2 PD at 638mA */
+#define LTC4266_ICUT_MAX_MA			638
+#define LTC4266_ICUT_MAX_STEPS			34
+
+/* In an effort to convert the PSE core's power limit to a current limit, =
we'll
+ * use 50V for the PSE port voltage (the minimum for a Type 2 PSE)
+ */
+
+#define LTC4266_VPORT_MIN_MV			50000
+
+/* Recommended lim<n> settings from datasheet Table 5.
+ *
+ *	I_LIM (mA)	RSENSE =3D 0.5 Ohm	RSENSE =3D 0.25 Ohm
+ *	425 (Type 1)	0x00			0x80
+ *	850 (Type 2)	0x40			0xC0
+ */
+#define LTC4266_ILIM_TYPE1_RSENSE_050		0x00
+#define LTC4266_ILIM_TYPE1_RSENSE_025		0x80
+#define LTC4266_ILIM_TYPE2_RSENSE_050		0x40
+#define LTC4266_ILIM_TYPE2_RSENSE_025		0xC0
+
+/* LTC4266_REG_INTSTAT and LTC4266_REG_INTMASK */
+#define LTC4266_INT_SUPPLY			BIT(7)
+#define LTC4266_INT_TSTART			BIT(6)
+#define LTC4266_INT_TCUT			BIT(5)
+#define LTC4266_INT_CLASS			BIT(4)
+#define LTC4266_INT_DETECT			BIT(3)
+#define LTC4266_INT_DIS				BIT(2)
+
+/* Per-port event bits within the CoR event registers. Every per-port even=
t
+ * register splits its 8 bits into a per-port low nibble and a per-port hi=
gh
+ * nibble:
+ * detevn (05h): LO =3D detection complete, HI =3D classification complete
+ * fltevn (07h): LO =3D tCUT overcurrent,   HI =3D tDIS DC disconnect
+ * tsevn  (09h): LO =3D tSTART overcurrent, HI =3D tLIM current-limit time=
out
+ */
+#define LTC4266_EVN_LO(_p)			BIT(_p)		/* ports 0-3 */
+#define LTC4266_EVN_HI(_p)			BIT((_p) + 4)	/* ports 0-3 */
+
+/* supevn (0Bh) */
+#define LTC4266_SUPEVN_OVERTEMP			BIT(7)
+
+#define LTC4266_MAX_PORTS			4
+#define LTC4266_PW_LIMIT_MAX			30000
+#define LTC4266_PW_LIMIT_MIN			1000
+
+enum {
+	READ_CURRENT =3D 0,
+	READ_VOLTAGE =3D 2
+};
+
+/* LTC4266 Port Operating modes
+ *
+ * LTC4266_OPMD_SHUTDOWN: Port is completely off, will not run any
+ *	classification or detection cycles
+ *
+ * LTC4266_OPMD_MANUAL: Port is "Manual" control mode, meaning it is
+ * possible to apply power to the port without a valid detection/classific=
ation
+ * result. This is dangerous and can easily violate the IEEE Specification=
s, and
+ * is not supported by this driver.
+ *
+ * LTC4266_OPMD_SEMI:  Semi-auto mode, meaning that a port will detect and
+ * classify devices, but will not power the device until the host (us)
+ * instructs it to do so. This is the only mode this driver supports.
+ *
+ * LTC4266_OPMD_AUTO:  Fully automatic mode.  Requires the chip to be powe=
red
+ * on with the AUTO pin high (which will set this mode for all ports) as w=
ell
+ * as an appropriately sized power supply.
+ */
+enum ltc4266_port_mode {
+	LTC4266_OPMD_SHUTDOWN =3D 0,
+	LTC4266_OPMD_MANUAL,
+	LTC4266_OPMD_SEMI,
+	LTC4266_OPMD_AUTO
+};
+
+/* Map LTC4266 Classification result to PD class.  Note for a PD that has =
a
+ * valid detect signature, but doesn't produce a classification signature =
is
+ * still a valid PD.  The LTC4266 indicates this with 0x06 in the statp<n>
+ * register and calls it "Class 0".  This is a different state than when
+ * statp<n> indicates 0, which means classification isn't complete.  This =
maps
+ * the result to either an errno or classification value suitable for use =
up
+ * the stack.
+ */
+static const int ltc4266_class_map[] =3D {
+	-EAGAIN, /* Classification is incomplete */
+	1,
+	2,
+	3,
+	4,
+	-EINVAL,
+	0,
+	-ERANGE
+};
+
+/* Map a PD Class to I_CUT thresholds from the LTC4266 datasheet Table 2 *=
/
+static const int ltc4266_class_to_icut[] =3D {
+	375,
+	112,
+	206,
+	375,
+	638
+};
+
+/* Maximum power per IEEE 802.3 class in mW, indexed by class (0-4).
+ * Classes 0-3 are from Table 33-7 in the IEEE802.3 standard, and the
+ * class 4 value is determined from Table 33-1 using a Type 2 voltage of 5=
0V.
+ */
+static const int ltc4266_class_pw[] =3D {
+	15400,	/* Class 0 */
+	4000,	/* Class 1 */
+	7000,	/* Class 2 */
+	15400,	/* Class 3 */
+	30000,	/* Class 4 (Type 2) */
+};
+
+enum sense_resistor {
+	LTC4266_RSENSE_500, /* Rsense 0.5 Ohm */
+	LTC4266_RSENSE_250 /* Rsense 0.25 Ohm */
+};
+
+struct ltc4266;
+
+/**
+ * struct ltc4266_port - per-PSE-PI context
+ *
+ * @ltc4266: the controller owning this port
+ * @chan: index of the LTC4266 delivery channel backing this PI, establish=
ed
+ *	  from the PI pairset phandle by ltc4266_map_pis().  All register
+ *	  addressing uses this member.
+ * @rsense: sense resistor on @chan, used to scale current readings and
+ *	    to pick the I_CUT and I_LIM encodings.
+ * @pw_limit: Admin-configured power limit in mW.
+ */
+struct ltc4266_port {
+	struct ltc4266 *ltc4266;
+	u8 chan;
+	enum sense_resistor rsense;
+	int pw_limit;
+};
+
+/**
+ * struct ltc4266 - LTC4266 controller context
+ *
+ * @client: the I2C client
+ * @regmap: register map of @client
+ * @ports: table of PSE PI contexts, indexed by PSE PI id. A NULL entry is=
 a PI
+ *	   that is not described in the device tree and therefore has no
+ *	   channel mapped.
+ * @dev: the underlying device
+ * @np: device node of @dev
+ * @pcdev: the PSE controller registered with the PSE core
+ */
+struct ltc4266 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct ltc4266_port *ports[LTC4266_MAX_PORTS];
+	struct device *dev;
+	struct device_node *np;
+	struct pse_controller_dev pcdev;
+};
+
+static struct ltc4266_port *ltc4266_pi_port(struct pse_controller_dev *pcd=
ev,
+					    int id)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	return ltc4266->ports[id];
+}
+
+static int ltc4266_read_iv(struct ltc4266_port *port, u8 iv)
+{
+	struct ltc4266 *ltc4266 =3D port->ltc4266;
+	unsigned int lsb, msb;
+	unsigned int statpwr;
+	int lsb_reg;
+	int result;
+	u64 ivbits;
+
+	if (iv =3D=3D READ_CURRENT)
+		lsb_reg =3D LTC4266_IPLSB_REG(port->chan);
+	else if (iv =3D=3D READ_VOLTAGE)
+		lsb_reg =3D LTC4266_VPLSB_REG(port->chan);
+	else
+		return -EINVAL;
+
+	result =3D regmap_read(ltc4266->regmap, LTC4266_REG_STATPWR, &statpwr);
+	if (result < 0)
+		return result;
+
+	/* LTC4266 IV readings are only meaningful while the port is delivering
+	 * power. When the PG (power good) bit is not set, the port is
+	 * delivering nothing, so report 0 rather than an error.  When this is
+	 * reached from the PSE core (via pi_get_actual_pw), returning errno
+	 * here would abort pse_ethtool_get_status() and fail the whole
+	 * "ethtool --show-pse" query for an otherwise perfectly readable port.
+	 * However, when this is reached from the regulator ops, 0 is turned
+	 * into an ERANGE, causing "ethtool --set-pse eth1 c33-pse-avail-pw-limit=
"
+	 * to return ERANGE back to the user unless the port is actually deliveri=
ng power.
+	 */
+	if (!(statpwr & LTC4266_STATPWR_PG(port->chan)))
+		return 0;
+
+	result =3D regmap_read(ltc4266->regmap, lsb_reg, &lsb);
+	if (result < 0)
+		return result;
+
+	result =3D regmap_read(ltc4266->regmap, lsb_reg + 1, &msb);
+	if (result < 0)
+		return result;
+
+	ivbits =3D (msb << 8) | lsb;
+
+	if (iv =3D=3D READ_CURRENT)
+		if (port->rsense =3D=3D LTC4266_RSENSE_250)
+			result =3D DIV_ROUND_CLOSEST_ULL(ivbits * LTC4266_IP_NA_PER_LSB_RSENSE_=
025,
+						       1000);
+		else
+			result =3D DIV_ROUND_CLOSEST_ULL(ivbits * LTC4266_IP_NA_PER_LSB_RSENSE_=
050,
+						       1000);
+	else
+		result =3D ivbits * LTC4266_VP_UV_PER_LSB;
+
+	return result;
+}
+
+/**
+ * ltc4266_port_set_ilim - Set the active current limit (ILIM) for a port
+ * @port: the port to configure
+ * @class: the detected PD class (0-4)
+ *
+ * This function configures the ILIM register of the LTC4266. The ILIM val=
ue
+ * determines the threshold at which the PSE actively limits current to th=
e PD.
+ * The chosen values are based on IEEE Std 802.3-2022 requirements and typ=
ical
+ * operational values for the LTC4266 controller.
+ *
+ * IEEE Std 802.3-2022, Table 33-11 specifies ILIM parameter ranges:
+ * - For Type 1 PSE operation (typically PD Classes 0-3):
+ * The minimum ILIM is 0.400A. This driver uses 425mA. This value fits
+ * within typical Type 1 ILIM specifications (e.g., 0.400A min to
+ * around 0.440A-0.500A max for the programmed steady-state limit).
+ *
+ * - For Type 2 PSE operation (typically PD Class 4):
+ * The minimum ILIM is 1.14 * ICable (or ~1.05 * IPort_max from other
+ * interpretations, e.g., ~0.630A to ~0.684A). This driver uses 850mA.
+ * This value meets the minimum requirement and is a supported operational
+ * current limit for high power modes in the LTC4266.
+ *
+ * The overall PSE current output must not exceed the time-dependent PSE
+ * upperbound template, IPSEUT(t), described in IEEE Std 802.3-2022,
+ * Equation (33-6). The programmed ILIM values (425mA/850mA) serve as the
+ * long-term current limit (Ilimmin segment of IPSEUT(t)) and are well
+ * within the higher short-term current allowances of that template
+ * (e.g., 1.75A).
+ *
+ * The specific register values written depend on the sense resistor
+ * (0.25 Ohm or 0.50 Ohm) as detailed in the LTC4266 datasheet (Table 5).
+ *
+ * Returns: 0 on success or a negative errno.
+ */
+static int ltc4266_port_set_ilim(struct ltc4266_port *port, int class)
+{
+	bool rsense_250 =3D port->rsense =3D=3D LTC4266_RSENSE_250;
+	u8 ilim;
+
+	if (class > 4 || class < 0)
+		return -EINVAL;
+
+	if (class < 4)
+		ilim =3D rsense_250 ? LTC4266_ILIM_TYPE1_RSENSE_025 :
+				    LTC4266_ILIM_TYPE1_RSENSE_050;
+	else
+		ilim =3D rsense_250 ? LTC4266_ILIM_TYPE2_RSENSE_025 :
+				    LTC4266_ILIM_TYPE2_RSENSE_050;
+
+	return regmap_write(port->ltc4266->regmap,
+			    LTC4266_REG_ILIM(port->chan), ilim);
+}
+
+static int ltc4266_port_set_icut(struct ltc4266_port *port, int icut)
+{
+	u8 val;
+
+	if (icut > LTC4266_ICUT_MAX_MA)
+		return -ERANGE;
+
+	val =3D min(DIV_ROUND_UP(icut * 1000, LTC4266_ICUT_STEP_UA),
+		  LTC4266_ICUT_MAX_STEPS) & LTC4266_ICUT_MASK;
+
+	if (port->rsense =3D=3D LTC4266_RSENSE_250)
+		val |=3D LTC4266_ICUT_RSENSE_025_OHM | LTC4266_ICUT_RANGE;
+
+	return regmap_write(port->ltc4266->regmap,
+			    LTC4266_REG_ICUT_HP(port->chan), val);
+}
+
+/**
+ * ltc4266_pw_limit_to_icut - Convert an admin power limit to an I_CUT thr=
eshold
+ * @max_mw: the power limit in mW
+ * @class: the detected PD class (0-4)
+ *
+ * The LTC4266 only enforces a current threshold, so a power limit has to =
be
+ * divided by a port voltage.  We don't have a port voltage, and so we'll =
use
+ * the minimum voltage for a Type 2 PSE.
+ *
+ * Return: the threshold in mA, capped by the class limit.
+ */
+static int ltc4266_pw_limit_to_icut(int max_mw, int class)
+{
+	if (max_mw >=3D ltc4266_class_pw[class])
+		return ltc4266_class_to_icut[class];
+
+	return DIV_ROUND_UP(max_mw * 1000, LTC4266_VPORT_MIN_MV);
+}
+
+static int ltc4266_port_mode(struct ltc4266_port *port, enum ltc4266_port_=
mode opmd)
+{
+	if (opmd !=3D LTC4266_OPMD_SEMI)
+		return -EINVAL;
+
+	return regmap_update_bits(port->ltc4266->regmap, LTC4266_REG_OPMD,
+				  TWO_BIT_WORD_MASK(port->chan),
+				  TWO_BIT_WORD_OFFSET(opmd, port->chan));
+}
+
+static int ltc4266_port_delivering(struct ltc4266_port *port)
+{
+	unsigned int result;
+	int ret;
+
+	ret =3D regmap_read(port->ltc4266->regmap, LTC4266_REG_STATPWR, &result);
+	if (ret < 0)
+		return ret;
+
+	return !!((result & LTC4266_STATPWR_PG(port->chan)) &&
+		  (result & LTC4266_STATPWR_PE(port->chan)));
+}
+
+static int ltc4266_port_init(struct ltc4266_port *port)
+{
+	struct ltc4266 *ltc4266 =3D port->ltc4266;
+	u8 chan =3D port->chan;
+	u8 tlim_shift;
+	u8 tlim_mask;
+	u8 tlim_reg;
+	int ret;
+
+	/* Reset the port */
+	ret =3D regmap_write(ltc4266->regmap, LTC4266_REG_RSTPB, BIT(chan));
+	if (ret < 0)
+		return ret;
+
+	ret =3D ltc4266_port_mode(port, LTC4266_OPMD_SEMI);
+	if (ret < 0)
+		return ret;
+
+	/* Enable high power mode on the port (for Type 2 PD support) */
+	ret =3D regmap_update_bits(ltc4266->regmap, LTC4266_REG_HPEN,
+				 LTC4266_HPEN(chan), LTC4266_HPEN(chan));
+	if (ret < 0)
+		return ret;
+
+	/* Enable 2-event classification (IEEE 802.3-2022, Clause 33), which the
+	 * datasheet refers to as "Ping-Pong" classification.
+	 */
+	ret =3D regmap_update_bits(ltc4266->regmap, LTC4266_REG_HPMD(chan),
+				 LTC4266_HPMD_PONGEN, LTC4266_HPMD_PONGEN);
+	if (ret < 0)
+		return ret;
+
+	if (port->rsense =3D=3D LTC4266_RSENSE_250)
+		ret =3D regmap_update_bits(ltc4266->regmap, LTC4266_REG_ICUT_HP(chan),
+					 LTC4266_ICUT_RSENSE_025_OHM,
+					 LTC4266_ICUT_RSENSE_025_OHM);
+	else
+		ret =3D regmap_update_bits(ltc4266->regmap, LTC4266_REG_ICUT_HP(chan),
+					 LTC4266_ICUT_RSENSE_025_OHM, 0);
+
+	if (ret < 0)
+		return ret;
+
+	if (chan <=3D 1)
+		tlim_reg =3D LTC4266_REG_TLIM12;
+	else
+		tlim_reg =3D LTC4266_REG_TLIM34;
+
+	/* Each tlim register packs two ports: the even port in the low nibble
+	 * and the odd port in the high nibble. Shift both the value and the
+	 * mask into the correct nibble.
+	 */
+	if (chan & BIT(0))
+		tlim_shift =3D 4;
+	else
+		tlim_shift =3D 0;
+
+	tlim_mask =3D GENMASK(3, 0) << tlim_shift;
+
+	ret =3D regmap_update_bits(ltc4266->regmap, tlim_reg,
+				 tlim_mask, LTC4266_TLIM_VALUE << tlim_shift);
+	if (ret < 0)
+		return ret;
+
+	/* Enable disconnect detect. */
+	ret =3D regmap_update_bits(ltc4266->regmap, LTC4266_REG_DISENA,
+				 BIT(chan), BIT(chan));
+	if (ret < 0)
+		return ret;
+
+	/* Enable detection (low nibble), classification (high nibble) on the por=
t */
+	ret =3D regmap_write(ltc4266->regmap, LTC4266_REG_DETPB,
+			   LTC4266_DETPB_CLASS_ENABLE(chan) |
+			   LTC4266_DETPB_DETECT_ENABLE(chan));
+
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(ltc4266->dev, "Channel %d has been initialized\n", chan);
+	return 0;
+}
+
+/* Read the port's classification result and return a class 0-4 or an erro=
r if
+ * the result isn't valid.
+ */
+static int ltc4266_port_get_class(struct ltc4266_port *port)
+{
+	struct ltc4266 *ltc4266 =3D port->ltc4266;
+	unsigned int val;
+	int ret;
+
+	ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_STAT(port->chan), &val);
+	if (ret < 0) {
+		dev_warn(ltc4266->dev, "Failed to read status register, err=3D%d\n", ret=
);
+		return ret;
+	}
+
+	/* Can't have a valid classification result if we've not yet had a good
+	 * detection result.
+	 */
+	if (LTC4266_PORT_DETECT(val) !=3D LTC4266_DETECT_GOOD)
+		return -EINVAL;
+
+	ret =3D  ltc4266_class_map[LTC4266_PORT_CLASS(val)];
+	return ret;
+}
+
+/* Maximum power the classified PD is allowed. It does not depend on the p=
ort
+ * being powered, but it does depend on the port having a PD attached and =
being
+ * enabled to the point of running classification and detection cycles.
+ */
+static int ltc4266_port_max_pw(struct ltc4266_port *port)
+{
+	int class =3D ltc4266_port_get_class(port);
+
+	if (class < 0)
+		return class;
+
+	return ltc4266_class_pw[class];
+}
+
+static int ltc4266_pi_get_pw_status(struct pse_controller_dev *pcdev, int =
id,
+				    struct pse_pw_status *pw_status)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+	int ret;
+
+	ret =3D ltc4266_port_delivering(port);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+	else
+		pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
+
+	return 0;
+}
+
+/* With the static budget evaluation strategy the PSE core calls this only
+ * after a PD has been classified and the power budget has been allocated.
+ * Program the current limit for the classified PD, reduced if an admin po=
wer
+ * limit asks for less than the class is entitled to, and apply power.
+ */
+static int ltc4266_pi_enable(struct pse_controller_dev *pcdev, int id)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+	int class, icut, ret;
+
+	class =3D ltc4266_port_get_class(port);
+	if (class < 0)
+		return class;
+
+	ret =3D ltc4266_port_set_ilim(port, class);
+	if (ret < 0)
+		return ret;
+
+	/* Derive the threshold from the admin limit against the class in front o=
f
+	 * us now, since a different PD may have been plugged in since the limit
+	 * was set.
+	 */
+	if (port->pw_limit)
+		icut =3D ltc4266_pw_limit_to_icut(port->pw_limit, class);
+	else
+		icut =3D ltc4266_class_to_icut[class];
+
+	ret =3D ltc4266_port_set_icut(port, icut);
+	if (ret < 0)
+		return ret;
+
+	/* Apply power to the port. */
+	return regmap_write(port->ltc4266->regmap, LTC4266_REG_PWRPB,
+			    BIT(port->chan));
+}
+
+static int ltc4266_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+
+	/* Resetting the port (RSTPB, issued at the start of ltc4266_port_init)
+	 * removes power AND clears all per-port configuration, so the port must
+	 * be fully re-initialised. This returns it to semi-auto mode with
+	 * detection and classification re-enabled (rather than shutting it
+	 * down) so a reconnecting PD is detected and the PSE core can retry
+	 * power delivery, e.g. when budget is freed by a higher-priority port.
+	 */
+	return ltc4266_port_init(port);
+}
+
+static int ltc4266_pi_get_voltage(struct pse_controller_dev *pcdev, int id=
)
+{
+	return ltc4266_read_iv(ltc4266_pi_port(pcdev, id), READ_VOLTAGE);
+}
+
+static int ltc4266_pi_get_admin_state(struct pse_controller_dev *pcdev, in=
t id,
+				      struct pse_admin_state *admin_state)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+	unsigned int val;
+	int ret;
+
+	/* Report whether power is actually being delivered at the hardware
+	 * level. The PSE core relies on this (pse_pi_is_hw_enabled()) to know
+	 * which software-enabled ports still need power delivery attempted,
+	 * e.g. after budget is freed. In software power control mode the core
+	 * reports the administrative state to userspace separately.
+	 *
+	 * Use the power-good nibble (pgN): the power-enable nibble (peN) only
+	 * means power was requested, whereas power-good means the port is
+	 * actively sourcing power to the PD.
+	 */
+	ret =3D regmap_read(port->ltc4266->regmap, LTC4266_REG_STATPWR, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & LTC4266_STATPWR_PG(port->chan))
+		admin_state->c33_admin_state =3D
+			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+	else
+		admin_state->c33_admin_state =3D
+			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+
+	return 0;
+}
+
+/* Get the PD Classification Result.  If there isn't one, return 0 so etht=
ool
+ * omits the attribute.
+ */
+static int ltc4266_pi_get_pw_class(struct pse_controller_dev *pcdev, int i=
d)
+{
+	int ret =3D ltc4266_port_get_class(ltc4266_pi_port(pcdev, id));
+
+	/* ltc4266_port_get_class will return either the class, or an errno.
+	 * Returning an errno from this function will mean the ethtool command
+	 * will abort with the error and not emit later useful information.
+	 * Since the "power class" is expected to be returned here, and class 0
+	 * and class 3 are equivalent in terms of power allocation, we'll return =
3.
+	 */
+
+	if (ret =3D=3D 0)
+		ret =3D 3;
+	if (ret < 0)
+		ret =3D 0;
+	return ret;
+}
+
+/* Get the power requested by the PD before enabling the port: its
+ * classification power.
+ */
+static int ltc4266_pi_get_pw_req(struct pse_controller_dev *pcdev, int id)
+{
+	return ltc4266_port_max_pw(ltc4266_pi_port(pcdev, id));
+}
+
+static int ltc4266_pi_get_actual_pw(struct pse_controller_dev *pcdev, int =
id)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+	int uA, uV;
+	u64 uW;
+
+	uA =3D ltc4266_read_iv(port, READ_CURRENT);
+	if (uA < 0)
+		return uA;
+
+	uV =3D ltc4266_read_iv(port, READ_VOLTAGE);
+	if (uV < 0)
+		return uV;
+
+	/* Convert uA to mA and uV to mV; mA * mV =3D uW */
+	uW =3D DIV_ROUND_CLOSEST_ULL(uA, 1000) * DIV_ROUND_CLOSEST_ULL(uV, 1000);
+
+	return (int)DIV_ROUND_CLOSEST_ULL(uW, 1000);
+}
+
+static int ltc4266_pi_get_pw_limit_ranges(struct pse_controller_dev *pcdev=
, int id,
+					  struct pse_pw_limit_ranges *pw_limit_ranges)
+{
+	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
+	int class_pw_limit;
+
+	c33_pw_limit_ranges =3D kzalloc_obj(*c33_pw_limit_ranges);
+	if (!c33_pw_limit_ranges)
+		return -ENOMEM;
+
+	class_pw_limit =3D  ltc4266_port_max_pw(ltc4266_pi_port(pcdev, id));
+	if (class_pw_limit < 0)
+		class_pw_limit =3D 0;
+
+	c33_pw_limit_ranges[0].min =3D LTC4266_PW_LIMIT_MIN;
+	c33_pw_limit_ranges[0].max =3D class_pw_limit ? class_pw_limit : LTC4266_=
PW_LIMIT_MAX;
+
+	pw_limit_ranges->c33_pw_limit_ranges =3D c33_pw_limit_ranges;
+
+	/* Return the number of ranges */
+	return 1;
+}
+
+static int ltc4266_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				   int id, int max_mw)
+{
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+	int class_pw_limit;
+	int class;
+	int icut;
+	int ret;
+
+	class =3D ltc4266_port_get_class(port);
+	if (class < 0)
+		return class;
+
+	class_pw_limit =3D ltc4266_class_pw[class];
+
+	if (max_mw < LTC4266_PW_LIMIT_MIN || max_mw > class_pw_limit) {
+		dev_err(port->ltc4266->dev, "power limit %d is out of range [%d, %d]\n",
+			max_mw, LTC4266_PW_LIMIT_MIN, class_pw_limit);
+		return -ERANGE;
+	}
+
+	icut =3D ltc4266_pw_limit_to_icut(max_mw, class);
+
+	ret =3D ltc4266_port_set_icut(port, icut);
+	if (!ret)
+		port->pw_limit =3D max_mw;
+
+	return ret;
+}
+
+/* Configured power limit for the port, in mW. Defaults to the
+ * classification-based maximum; a lower value configured through
+ * pi_set_pw_limit() overrides it.  If there is a PD connected and classif=
ied
+ * on the port, we'll use the minimum between the admin-configured limit a=
nd
+ * the maximum classification power for that class.
+ */
+static int ltc4266_pi_get_pw_limit(struct pse_controller_dev *pcdev, int i=
d)
+{
+	int admin_limit =3D LTC4266_PW_LIMIT_MAX;
+	int class_limit;
+
+	struct ltc4266_port *port =3D ltc4266_pi_port(pcdev, id);
+
+	class_limit =3D ltc4266_port_max_pw(port);
+	if (class_limit < 0) {
+		/* We don't have a PD detected and classified */
+		class_limit =3D LTC4266_PW_LIMIT_MAX;
+	}
+	if (port->pw_limit) {
+		/* Admin has configured a power limit */
+		admin_limit =3D port->pw_limit;
+	}
+	return min(admin_limit, class_limit);
+}
+
+/* Description of one delivery channel parsed out of the "channels" node. =
Held
+ * only for the duration of ltc4266_setup_pi_matrix(): what survives is th=
e
+ * per-PI struct ltc4266_port built from the channel a PI actually referen=
ces.
+ */
+struct ltc4266_chan_desc {
+	struct device_node *np;
+	enum sense_resistor rsense;
+};
+
+static int ltc4266_get_of_channels(struct ltc4266 *ltc4266,
+				   struct ltc4266_chan_desc *chans)
+{
+	struct device_node *channels_node;
+	u32 chan_id, sense;
+	int ret;
+
+	channels_node =3D of_get_child_by_name(ltc4266->np, "channels");
+	if (!channels_node)
+		return dev_err_probe(ltc4266->dev, -EINVAL,
+				     "missing \"channels\" node\n");
+
+	for_each_child_of_node_scoped(channels_node, chan_node) {
+		if (!of_node_name_eq(chan_node, "channel"))
+			continue;
+
+		ret =3D of_property_read_u32(chan_node, "reg", &chan_id);
+		if (ret) {
+			ret =3D dev_err_probe(ltc4266->dev, ret,
+					    "missing reg property in node %pOF\n",
+					    chan_node);
+			goto out;
+		}
+
+		if (chan_id >=3D LTC4266_MAX_PORTS) {
+			ret =3D dev_err_probe(ltc4266->dev, -EINVAL,
+					    "channel id %u is out of range in node %pOF\n",
+					    chan_id, chan_node);
+			goto out;
+		}
+
+		if (chans[chan_id].np) {
+			ret =3D dev_err_probe(ltc4266->dev, -EINVAL,
+					    "channel id %u is already used, please check the reg property in =
node %pOF\n",
+					    chan_id, chan_node);
+			goto out;
+		}
+
+		ret =3D of_property_read_u32(chan_node, "sense-resistor-micro-ohms", &se=
nse);
+		if (ret) {
+			ret =3D dev_err_probe(ltc4266->dev, ret,
+					    "missing sense-resistor-micro-ohms property in node %pOF\n",
+					    chan_node);
+			goto out;
+		}
+
+		if (sense =3D=3D 250000) {
+			chans[chan_id].rsense =3D LTC4266_RSENSE_250;
+		} else if (sense =3D=3D 500000) {
+			chans[chan_id].rsense =3D LTC4266_RSENSE_500;
+		} else {
+			ret =3D dev_err_probe(ltc4266->dev, -EINVAL,
+					    "invalid sense resistor value %u in node %pOF\n",
+					    sense, chan_node);
+			goto out;
+		}
+
+		chans[chan_id].np =3D of_node_get(chan_node);
+	}
+
+	of_node_put(channels_node);
+	return 0;
+
+out:
+	of_node_put(channels_node);
+	return ret;
+}
+
+/* Find the channel a PI pairset phandle points at. */
+static int ltc4266_match_channel(const struct pse_pi_pairset *pairset,
+				 struct ltc4266_chan_desc *chans)
+{
+	int i;
+
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++)
+		if (pairset->np =3D=3D chans[i].np)
+			return i;
+
+	return -ENODEV;
+}
+
+/* Build a port context for every PSE PI described in the device tree, bou=
nd to
+ * the channel its pairset references. A PI with no node is left NULL; the=
 PSE
+ * core does not register a regulator for it and so never calls back for i=
t.
+ */
+static int ltc4266_map_pis(struct ltc4266 *ltc4266,
+			   struct ltc4266_chan_desc *chans)
+{
+	struct pse_controller_dev *pcdev =3D &ltc4266->pcdev;
+	struct ltc4266_port *port;
+	int i, j, chan;
+
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		struct pse_pi *pi =3D &pcdev->pi[i];
+
+		if (!pi->np)
+			continue;
+
+		if (!pi->pairset[0].np)
+			return dev_err_probe(ltc4266->dev, -EINVAL,
+					     "%pOF has no pairsets\n", pi->np);
+
+		/* The LTC4266 delivers over a single pairset per channel, so
+		 * there is no 4-pair mode to spread a PI over two channels.
+		 */
+		if (pi->pairset[1].np)
+			return dev_err_probe(ltc4266->dev, -EOPNOTSUPP,
+					     "%pOF: 4-pair PSE PIs are not supported\n",
+					     pi->np);
+
+		chan =3D ltc4266_match_channel(&pi->pairset[0], chans);
+		if (chan < 0)
+			return dev_err_probe(ltc4266->dev, chan,
+					     "%pOF: pairset %pOF is not a channel of this controller\n",
+					     pi->np, pi->pairset[0].np);
+
+		for (j =3D 0; j < i; j++)
+			if (ltc4266->ports[j] && ltc4266->ports[j]->chan =3D=3D chan)
+				return dev_err_probe(ltc4266->dev, -EINVAL,
+						     "%pOF: channel %d is already used by %pOF\n",
+						     pi->np, chan, pcdev->pi[j].np);
+
+		port =3D devm_kzalloc(ltc4266->dev, sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return -ENOMEM;
+
+		port->ltc4266 =3D ltc4266;
+		port->chan =3D chan;
+		port->rsense =3D chans[chan].rsense;
+		ltc4266->ports[i] =3D port;
+
+		dev_dbg(ltc4266->dev, "PI %d is backed by channel %d\n", i, chan);
+	}
+
+	return 0;
+}
+
+static int ltc4266_setup_pi_matrix(struct pse_controller_dev *pcdev)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+	struct ltc4266_chan_desc chans[LTC4266_MAX_PORTS] =3D { };
+	int i, ret;
+
+	if (pcdev->no_of_pse_pi)
+		return dev_err_probe(ltc4266->dev, -EINVAL,
+				     "a \"pse-pis\" node is required\n");
+
+	ret =3D ltc4266_get_of_channels(ltc4266, chans);
+	if (!ret)
+		ret =3D ltc4266_map_pis(ltc4266, chans);
+
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++)
+		of_node_put(chans[i].np);
+
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		if (!ltc4266->ports[i])
+			continue;
+
+		ret =3D ltc4266_port_init(ltc4266->ports[i]);
+		if (ret < 0)
+			return dev_err_probe(ltc4266->dev, ret,
+					     "Failed to initialize PI %d\n", i);
+	}
+
+	return 0;
+}
+
+static const struct pse_controller_ops ltc4266_ops =3D {
+	.setup_pi_matrix =3D ltc4266_setup_pi_matrix,
+	.pi_get_admin_state =3D ltc4266_pi_get_admin_state,
+	.pi_get_pw_status =3D ltc4266_pi_get_pw_status,
+	.pi_get_pw_class =3D ltc4266_pi_get_pw_class,
+	.pi_get_actual_pw =3D ltc4266_pi_get_actual_pw,
+	.pi_enable =3D ltc4266_pi_enable,
+	.pi_disable =3D ltc4266_pi_disable,
+	.pi_get_voltage =3D ltc4266_pi_get_voltage,
+	.pi_get_pw_limit =3D ltc4266_pi_get_pw_limit,
+	.pi_set_pw_limit =3D ltc4266_pi_set_pw_limit,
+	.pi_get_pw_limit_ranges =3D ltc4266_pi_get_pw_limit_ranges,
+	.pi_get_pw_req =3D ltc4266_pi_get_pw_req,
+};
+
+#define LTC4266_INTERRUPT_SOURCES	(LTC4266_INT_SUPPLY | LTC4266_INT_TSTART=
 | \
+					 LTC4266_INT_TCUT | LTC4266_INT_CLASS | \
+					 LTC4266_INT_DETECT | LTC4266_INT_DIS)
+
+static void ltc4266_enable_interrupts(struct ltc4266 *ltc4266)
+{
+	/* Unmask interrupts */
+	regmap_write(ltc4266->regmap, LTC4266_REG_INTMASK,
+		     LTC4266_INTERRUPT_SOURCES);
+}
+
+static int ltc4266_disable_interrupts(struct ltc4266 *ltc4266)
+{
+	int ret;
+
+	ret =3D regmap_write(ltc4266->regmap, LTC4266_REG_INTMASK, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* Reset the (SMBus Alert) interrupt pin */
+	return regmap_write(ltc4266->regmap, LTC4266_REG_RSTPB, LTC4266_RSTPB_PIN=
CLR);
+}
+
+static int ltc4266_map_event(int irq, struct pse_controller_dev *pcdev,
+			     unsigned long *notifs, unsigned long *notifs_mask)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+	unsigned int detevn =3D 0, fltevn =3D 0, tsevn =3D 0, supevn =3D 0;
+	unsigned int intstat;
+	int ret;
+	int i;
+
+	ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_INTSTAT, &intstat);
+	if (ret < 0)
+		return ret;
+
+	if (!intstat)
+		return 0;
+
+	ltc4266_disable_interrupts(ltc4266);
+
+	if (intstat & LTC4266_INT_SUPPLY) {
+		ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_SUPEVN_COR, &supevn);
+		if (ret < 0) {
+			dev_err(&ltc4266->client->dev,
+				"Bus error reading SUPPLY Fault register ret =3D %d\n",
+				ret);
+			goto done;
+		}
+		if (supevn & LTC4266_SUPEVN_OVERTEMP) {
+			dev_err(&ltc4266->client->dev, "SUPPLY_FAULT, 0x%02x\n", supevn);
+			for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+				if (!ltc4266->ports[i])
+					continue;
+
+				notifs[i] =3D ETHTOOL_PSE_EVENT_OVER_TEMP;
+				*notifs_mask |=3D BIT(i);
+			}
+			/* Supply faults are critical system-level hardware
+			 * problems, they aren't fixable in software
+			 */
+			goto done;
+		}
+	}
+
+	if (intstat & (LTC4266_INT_DIS | LTC4266_INT_TCUT)) {
+		ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_FLTEVN_COR, &fltevn);
+		if (ret < 0) {
+			dev_err(&ltc4266->client->dev, "Failed to read fltevn err=3D%d\n", ret)=
;
+			goto done;
+		}
+	}
+
+	if (intstat & (LTC4266_INT_TSTART | LTC4266_INT_TCUT)) {
+		ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_TSEVN_COR, &tsevn);
+		if (ret < 0) {
+			dev_err(&ltc4266->client->dev, "Failed to read tsevn, err=3D%d\n", ret)=
;
+			goto done;
+		}
+	}
+
+	if (intstat & (LTC4266_INT_CLASS | LTC4266_INT_DETECT)) {
+		ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_DETEVN_COR, &detevn);
+		if (ret < 0) {
+			dev_err(&ltc4266->client->dev, "Failed to read detevn, err=3D%d\n", ret=
);
+			goto done;
+		}
+	}
+
+	/* The event registers are indexed by delivery channel while notifs[] is
+	 * indexed by PSE PI id, so walk the PIs and use each one's channel to
+	 * select the event bits.
+	 */
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		struct ltc4266_port *port =3D ltc4266->ports[i];
+		u8 chan;
+
+		if (!port)
+			continue;
+
+		chan =3D port->chan;
+
+		if ((tsevn | fltevn) & (LTC4266_EVN_HI(chan) | LTC4266_EVN_LO(chan))) {
+			/* This means the port has disconnected; if we see
+			 * this, then we don't care if any of the remaining
+			 * events are set.  If the device did disconnect
+			 * briefly, it'll redetect and reclassify accordingly
+			 */
+			notifs[i] |=3D ETHTOOL_C33_PSE_EVENT_DISCONNECTION;
+			*notifs_mask |=3D BIT(i);
+
+			/* Report over-current if the port went down for any
+			 * overcurrent reason: tSTART (tsevn low nibble, startup
+			 * inrush), tLIM (tsevn high nibble, current-limit
+			 * timeout) or tCUT (fltevn low nibble, I_CUT timeout).
+			 */
+			if ((tsevn & (LTC4266_EVN_LO(chan) | LTC4266_EVN_HI(chan))) ||
+			    (fltevn & LTC4266_EVN_LO(chan)))
+				notifs[i] |=3D ETHTOOL_PSE_EVENT_OVER_CURRENT;
+
+			dev_err(&ltc4266->client->dev, "tsevn=3D0x%02X fltevn=3D0x%02X\n",
+				tsevn, fltevn);
+			continue;
+		}
+		if (detevn & LTC4266_EVN_LO(chan)) {
+			/* Read the detect result, and if it isn't detect good,
+			 * call it a disconnect
+			 */
+			unsigned int detval;
+
+			ret =3D regmap_read(ltc4266->regmap, LTC4266_REG_STAT(chan), &detval);
+			if (ret < 0) {
+				dev_warn(ltc4266->dev, "Failed to read status register, err=3D%d\n",
+					 ret);
+				continue;
+			}
+
+			if (LTC4266_PORT_DETECT(detval) !=3D LTC4266_DETECT_GOOD) {
+				notifs[i] |=3D ETHTOOL_C33_PSE_EVENT_DISCONNECTION;
+				*notifs_mask |=3D BIT(i);
+				continue;
+			}
+		}
+
+		if (detevn & LTC4266_EVN_HI(chan)) {
+			int class =3D ltc4266_port_get_class(port);
+
+			if (class >=3D 0)  {
+				notifs[i] |=3D ETHTOOL_C33_PSE_EVENT_CLASSIFICATION;
+				*notifs_mask |=3D BIT(i);
+			}
+		}
+	}
+
+done:
+	ltc4266_enable_interrupts(ltc4266);
+	return 0;
+}
+
+static const struct regmap_config ltc4266_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D 0x5F,
+};
+
+static int ltc4266_probe(struct i2c_client *client)
+{
+	struct ltc4266 *ltc4266;
+	struct regmap *regmap;
+	unsigned int id_reg;
+	int ret;
+
+	regmap =3D devm_regmap_init_i2c(client, &ltc4266_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to allocate regmap\n");
+
+	/* Confirm we are talking to an LTC4266: the id register (0x1B) should
+	 * read back its documented reset value of 0x64.
+	 */
+	ret =3D regmap_read(regmap, LTC4266_REG_ID, &id_reg);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to read ID register\n");
+
+	if (id_reg !=3D LTC4266_ID)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Expected an ID of 0x64, saw 0x%02X\n", id_reg);
+
+	/* Reset the chip */
+	regmap_write(regmap, LTC4266_REG_RSTPB, LTC4266_RSTPB_INTCLR | LTC4266_RS=
TPB_RSTALL);
+
+	/* LTC4266 requires approximately 10 ms after reset to be stable; if it
+	 * isn't, then there is typically an undervoltage lockout/something prett=
y bad
+	 * going on. We give it 50 ms here so we don't need to poll the chip and =
use I2C bandwidth
+	 */
+	msleep(50);
+
+	/* Let's make sure the chip came out of reset (if not, the chip is probab=
ly
+	 * either (no longer?) present, in thermal shutdown, or watchdogged....ei=
ther
+	 * way, there's nothing we can do in software to fix it)
+	 */
+	ret =3D regmap_read(regmap, LTC4266_REG_ID, &id_reg);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to re-read ID register after reset\n");
+
+	if (id_reg !=3D LTC4266_ID)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Failed to re-read device ID after reset 0x%02X\n",
+				     id_reg);
+
+	ltc4266 =3D devm_kzalloc(&client->dev, sizeof(struct ltc4266), GFP_KERNEL=
);
+	if (!ltc4266)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ltc4266);
+	ltc4266->client =3D client;
+	ltc4266->regmap =3D regmap;
+	ltc4266->np =3D client->dev.of_node;
+	ltc4266->dev =3D &client->dev;
+
+	/* After reset, the LTC4266 will interrupt with a (single) supply fault.
+	 * Clear it here and discard the result
+	 */
+	regmap_read(ltc4266->regmap, LTC4266_REG_SUPEVN_COR, &id_reg);
+
+	ltc4266_disable_interrupts(ltc4266);
+
+	ltc4266->pcdev.owner =3D THIS_MODULE;
+	ltc4266->pcdev.ops =3D &ltc4266_ops;
+	ltc4266->pcdev.dev =3D &client->dev;
+	ltc4266->pcdev.types =3D ETHTOOL_PSE_C33;
+	ltc4266->pcdev.nr_lines =3D LTC4266_MAX_PORTS;
+
+	/* Power delivery is gated by the PSE core static budget evaluation
+	 * strategy: ports are only powered (pi_enable) once a PD has been
+	 * classified and the shared power-domain budget allows it. Requires an
+	 * interrupt so classification/disconnection events are reported.
+	 */
+	ltc4266->pcdev.supp_budget_eval_strategies =3D PSE_BUDGET_EVAL_STRAT_STAT=
IC;
+
+	ret =3D devm_pse_controller_register(ltc4266->dev, &ltc4266->pcdev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+						"Failed to register PSE controller\n");
+
+	if (client->irq) {
+		struct pse_irq_desc irq_desc =3D {
+			.name =3D "ltc4266-irq",
+			.map_event =3D ltc4266_map_event,
+		};
+
+		/* Enable the interrupt pin, and only report detect events on
+		 * change (detchg) so idle ports continuously re-running
+		 * detection in semi-auto mode don't flood the host with a
+		 * detect event every cycle.
+		 */
+		regmap_update_bits(ltc4266->regmap, LTC4266_REG_MCONF,
+				   LTC4266_MCONF_INTERRUPT_ENABLE | LTC4266_MCONF_DETCHG,
+				   LTC4266_MCONF_INTERRUPT_ENABLE | LTC4266_MCONF_DETCHG);
+
+		ret =3D devm_pse_irq_helper(&ltc4266->pcdev, client->irq,
+					  0, &irq_desc);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to register PSE IRQ\n");
+
+		/* Unmask the chip interrupt sources now the handler is ready. */
+		ltc4266_enable_interrupts(ltc4266);
+	} else {
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Interrupt is required for power budget management\n");
+	}
+
+	return 0;
+}
+
+static void ltc4266_remove(struct i2c_client *client)
+{
+	struct ltc4266 *ltc4266 =3D i2c_get_clientdata(client);
+
+	/* Reset all the ports and do not re-init */
+	regmap_write(ltc4266->regmap, LTC4266_REG_RSTPB, LTC4266_RSTPB_RSTALL);
+}
+
+static const struct i2c_device_id ltc4266_id[] =3D {
+	{.name =3D "ltc4266"},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc4266_id);
+
+static const struct of_device_id ltc4266_of_match[] =3D {
+	{ .compatible =3D "lltc,ltc4266" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc4266_of_match);
+
+static struct i2c_driver ltc4266_driver =3D {
+	.driver		=3D {
+		.name	=3D "ltc4266",
+		.of_match_table =3D ltc4266_of_match,
+	},
+	.probe		=3D ltc4266_probe,
+	.remove		=3D ltc4266_remove,
+	.id_table	=3D ltc4266_id,
+};
+module_i2c_driver(ltc4266_driver);
+
+MODULE_AUTHOR("Kyle Swenson <kyle.swenson@est.tech>");
+MODULE_DESCRIPTION("LTC4266 PoE PSE Controller Driver");
+MODULE_LICENSE("GPL");
--=20
2.55.0
