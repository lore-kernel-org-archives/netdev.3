Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA14457B2;
	Wed,  5 Aug 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931269; cv=fail; b=LqpkOUt/RcHQ+5bLkKBwJS1i5Fo97XW6jakBHeCUyseMKwSyHyaMP6/Te+h/FQm9mP1ZXmsbrLMHH2gZyZwQ+zpJIp71MFJAewzdTq/F7tLR0vmrdciXEWmKWf0ZJ/T0BIjZXzQr3JdzbjiDiE1rvF17Tq9XSgCCyJUcfBUdQX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931269; c=relaxed/simple;
	bh=p5vh3W2XZqHW401tZMeRMlnDN2+gELkYv7+R+ZYk2PQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DknVYMFYiSn28QWWZ1FmrYxYrLo+esom1w2AzlKtEnKaUA0fMgeYnZmjKAQLdcdHZPFbIkDzyOTBXy+k/YTvx/YYn60FqsyNbe2aFasHUBKT4eLsyUNMrvWmYdy5nxEQfjOgRRye5VVyn/6W2MjDwrLtZ1ibWbwzl+gTO3rDX2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ISIHrBWD; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ISIHrBWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9eEYp9ASUf8HmTJwy4Xvy8BipJcOE25WLXuTfQwufImTycFg7K9Ipt0Fp3DdT4w45Xom8TC9jEDADrjmTEmGP1jvvOVCtuSZXMfqWh6IO0NIALuhr0AS6yAACjj/G3d7PPNypjqBh32MPsCsXqDlNYAs2RI3pfwmU/EThj0r9Rw9gueUWQIXRweqWkZFTQkos7HBSIugPFWzbrxcoLOwnwwb7+j52EcddITCKwnCj3RPcbvkKpORsu49Wa4tlMk/ucHn4wc1nQYHi19wtrzWi9oHKujZJ7mnnIgQYV4eNiXat/upsXqA9OHOIup/VvkWF/XEubyfulQr39LEJdLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/QLCfvdJb4/4asNUvyQe07YLSuU6LHTr7wCcUk/4ao=;
 b=EShH+fDm8LagrxD1Htou8m2AJ+vCb3+JoxZL2EGq7r4kfTqHSJhqlYP7YTGVeSCV2v7qbqsN+Sm4q3kd9u24DbSIxKo0SvZJAczECYCgm+DsUe1FvE5jBVJD/7n39KDDua6zd5LgqFJkqfsZq1NGqsilrXaqdnm6D3sFr3hDBW5+BVkdyv1vKdYihG1H+yAent619KWIg2k9JFA/SyGa42JLL1UAjAqYJxNEVECrDjEArEB3SfcUBYceFsZ9anFov7VnWfkODxXbvTQXxvW8SJWsWOhFKNA3e4hRS0nt8Ikar4cy9mVenC1cH9T2oXF9WQUmm3rYTrPCjYG5vQSHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/QLCfvdJb4/4asNUvyQe07YLSuU6LHTr7wCcUk/4ao=;
 b=ISIHrBWDGMaRbqfoypnwzcSU+L0ROVLwgNu28+InGeaRxvLr1SryZ/1w0R0L7qiWqZJK+NkpTRcp2/f/kIDrPX/8A8wDLdQe2aCTg8DKdFvwSy8Yz21VpWsgeGlftSNJ9j2PIbUjEDofNjbs2IWgLSbnXeIVglxZ5xh+QD2/6Eo=
Received: from PA1PR03MB11059.eurprd03.prod.outlook.com
 (2603:10a6:102:4fb::11) by AM9PR03MB7592.eurprd03.prod.outlook.com
 (2603:10a6:20b:41b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 12:01:03 +0000
Received: from PA1PR03MB11059.eurprd03.prod.outlook.com
 ([fe80::a171:1d74:5b7d:edef]) by PA1PR03MB11059.eurprd03.prod.outlook.com
 ([fe80::a171:1d74:5b7d:edef%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 12:01:03 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "theo.lebrun@bootlin.com" <theo.lebrun@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: macb: fix stale data returned by MDIO reads
Thread-Topic: [PATCH] net: macb: fix stale data returned by MDIO reads
Thread-Index: AQHdJNEfxXuh/Rfqhka8pGezdExgsw==
Date: Wed, 5 Aug 2026 12:01:02 +0000
Message-ID:
 <PA1PR03MB11059B8723E1C212E5801A52DC8D32@PA1PR03MB11059.eurprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR03MB11059:EE_|AM9PR03MB7592:EE_
x-ms-office365-filtering-correlation-id: 25c96005-6068-421b-55dd-08def2e938f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 QyNHfHD9lGyYDCBy9git0eJP56OnW5UIPk8M/3JKXLdCft4wfTQTwsaHTHAvaJ449uScgMfvng5xenFmPMo7GI1ClJFR5ypAk6CYSffscPRJe2nViELZ1yWKAJZ6iLfoqAF5D0fYid7MtnQoMXdAT1jIyMQxH96ym6f7J4Y3G9U7Vl79LTBynmRcLcZFnvQ2wfjUaJSPe2yO/TyYoGmTLGAuwSipvaoOtW92iqWWSaXJEX/TQZA239ldmYGxp/AvwmX41hfm2NXR7wRgS1iihyxHZQbIyp902dSy+uL9FPf3HqWTfQKw1Tu6CfqrSr+JTyzujZZN78Q4YBpU0aI4rD92xXvD4kCkthiduNOZHU16T1RUoyOf1YaVeXvaZWDTcygA/cN7UNbew+aq2gAIbBe/N4QmEGYDH9fWj3gfqQHaeZYW2WpisZ8FgKxTWlDqwnbKibOQpTZybKKtJamKWqBANDEbMlEJE8HkR6FHZCqWNUgU/y/wXRkRv/2QRdpJWvR+wA8m6OTNckTaPjYifZ4Krq5CeL3nLJQdUHfydtNeA5L4OiVWiOM19+97+FmxqHJpizMTb7Ns+B1ktOepXvd34Kk71Of+FawkVuL/UZv4LY44TyPpZOiLHKaiSwkQ2iT5W2eulAP59bPtDALkKaTlEJo91WhGyRVV7RiYgKNJPvZ2kX4J7HUeFajHhBSYVTHmqD0SM1VCeoYXgCOyAA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR03MB11059.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gObELl4JI0VwXzOeNld8+l9tkZeEWegBnpAxIAPbuQL6NAK0oLTxNtluG2?=
 =?iso-8859-1?Q?h8pmNnEpMUrCPyhBzwqic6ck3FZx1yB2eSCvxuu5uknDjsy0mwhzVbWDnQ?=
 =?iso-8859-1?Q?YtcVYkHF03STBSz6GzUcQ4PU4Ql5r2bXZVU7JwPfaaB6mOUOTyk83rK5b6?=
 =?iso-8859-1?Q?jsetvjlSqzvUqUIvaOa53+J5ia0qr5d/QqqxuXGN1Vs8HQULAd08jFXARO?=
 =?iso-8859-1?Q?8+lC6nA+ojbquS+58+Zkip74G/wTnOUG1rPWY/n+aa8xNs49M1HxSul3qU?=
 =?iso-8859-1?Q?VzMqrWFw/AOc1tOldPK9K5NEJcyt2DGZPydTR465tS+teev9SNSeP+1Yt4?=
 =?iso-8859-1?Q?tPD22j37F2gnJWJOfsMT143UWIHGLlA/t8emOQ0RsJyujnR69h4YQaW5W2?=
 =?iso-8859-1?Q?3co/a+NKs5pHimuFw1wAUD8DETiXpbPPOi+BRAhiR1M3DPgyNrTjbdAU97?=
 =?iso-8859-1?Q?+OeFk3QBzbZHaTl6m+wlC4TcwHCZXkcoVsqJhrmp0Cyuf2lM+fFphL9O1Z?=
 =?iso-8859-1?Q?obxAwrr5ybfetYHFDVpdNIQx8VwPeE9MW/DA5xzYuXF2ls97zK4Ysj6uiR?=
 =?iso-8859-1?Q?SL2mnzoOZiCWKRlXmZRL4mt91iZJMbg8Er4OAhxvBiJs+Xu6yyM11nhLlM?=
 =?iso-8859-1?Q?6Am068U+0RtdejR3Ql7u3OHVT6/YuGDZBwPRf/H0zjGIPPCDWTQrMOb5v+?=
 =?iso-8859-1?Q?xr11taCe4pEBINb/cEwk3m8EbR7vLLt5pe2WX6YBHKu8dcE4EnH8HjvfYG?=
 =?iso-8859-1?Q?1T2LfgtAHsO1trK9OV3LqrCyJ0vuSaJhlSHG29Ow5hTt+7bdpi5aUFBuwd?=
 =?iso-8859-1?Q?lHgA/A3HXCGLiP4AaxKxYFyQ7Q6BucJ57Su/cauI53xAZnmElM6S4W1tT5?=
 =?iso-8859-1?Q?KHbYZnlEtwc3b+gglhDem1xtOE13b9sh+EvhTBfF9u23P57bOH4ipRzHu0?=
 =?iso-8859-1?Q?A8QMxz+X0u/QS+77EHopJ0ojio7GtYGurgJhp1KexPvITtZDnhmrYC1a4L?=
 =?iso-8859-1?Q?ufdN/p4/QbaitBEQTUMEXhGrZUb9py952gf+s7nHas/WIg09ShEqLYifYU?=
 =?iso-8859-1?Q?2TcY1ZAhRkOwU2ikw1Xzb5zB52Gg+FurqTLXLWF1CgCWd9MGqmffCDsz98?=
 =?iso-8859-1?Q?xc+9aHDUIJdJcHbJhK3leFU9h/RGF13TaltYxVGDv5a2+H82EyNVU9i/aN?=
 =?iso-8859-1?Q?vww8DGI1LaqxuZ+X5IziOeRV9kJ2Hph/gxbqw/2M0ly6MpjPZty4zMWobb?=
 =?iso-8859-1?Q?mCrO2lI5M7spyrrLdSE2WeKcnVHPpjUHcBVl+AnqblVXJBxPRVVVQi8pxf?=
 =?iso-8859-1?Q?JP8v3JJsSnwhdddPMT5t8L4YpBne35Ru+jmWa6Yq1YgBjpg3RnXnKguL07?=
 =?iso-8859-1?Q?9gA6J/2K3bK51M8Iuh8u/Q1CglvjQ3S6wVWbS2kyQfQKV4eg/nJ4ZM/8vh?=
 =?iso-8859-1?Q?B7YnpE7kJmQxvSGA4GxI1d7v5KlbBE17bVAkZslRt6aiSerVWUlDXRjlUe?=
 =?iso-8859-1?Q?ZEtbilc+YuHDe3mAi2spUMb4IDZccuQdwRh5CaMiCRE6KuEdTTEnibcumq?=
 =?iso-8859-1?Q?RYymDKRM14adGZTk0nZT4L0t8GJEr4ooy22p6f1Q/rJ5mYOuSJLXmqTIg+?=
 =?iso-8859-1?Q?CIS1l5a11oIt7WmuIWfLkPbmjcOoGQeuL23jGkltP2C369N0duQDvSv+vN?=
 =?iso-8859-1?Q?H446LMbytHLOX2ujONBKOpm6QMt22/YvQllp/MmYQk+cnkPWMjuazlP5mz?=
 =?iso-8859-1?Q?m+0z141lq6a0ngkjKuek1EIzQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR03MB11059.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c96005-6068-421b-55dd-08def2e938f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 12:01:02.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIt7/kiJpVSsEuky6tTjiMz03ny8PVBp6+ONrntklKx2mNyQsHV2f+J1gSeYgGc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7592

macb_mdio_wait_for_idle() samples NSR.IDLE with no delay after MAN has been=
=0A=
written. readx_poll_timeout() expands to read_poll_timeout() with=0A=
sleep_before_read =3D false, so the very first NSR read is issued immediate=
ly=0A=
after the register write.=0A=
=0A=
The controller does not deassert NSR.IDLE until its MDIO state machine=0A=
actually begins the frame, which takes up to one MDC period. Neither=0A=
macb_mdc_clk_div() nor gem_mdc_clk_div() ever selects an MDC above 2.5 MHz,=
=0A=
so one period is up to ~400 ns - on the order of a hundred pclk cycles, and=
=0A=
far longer than a back-to-back register access. The poll therefore observes=
=0A=
IDLE still set from the *previous* operation and returns success before the=
=0A=
operation just issued has started.=0A=
=0A=
The caller then reads a MAN DATA field that still holds the result of=0A=
whatever completed before, so every read returns the data of the previously=
=0A=
accessed register. For clause 45 the race occurs three times per access: th=
e=0A=
address operation is still in flight when the read operation is written, an=
d=0A=
the final MACB_BFEXT(DATA, macb_readl(bp, MAN)) picks up a stale value.=0A=
=0A=
Observed on a Versal board with a Marvell 88Q1111 on GEM1, where reading ea=
ch=0A=
MMD register twice showed the first read returning the preceding register's=
=0A=
value:=0A=
=0A=
  31.8002: 0x0149 then 0x002b   (0x0149 is 31.8001)=0A=
  31.8004: 0x0b21 then 0x1401   (0x0b21 is 31.8003)=0A=
  31.8011: 0x400e then 0x6000   (0x400e is 31.8010)=0A=
  31.8010: 0x6000 then 0x400e   (0x6000 is 31.8011)=0A=
=0A=
The lag persists across callers and across driver entry points, so it is a=
=0A=
property of the controller path rather than of any PHY driver. It silently=
=0A=
corrupts every MMD read. Latch-high, clear-on-read registers are worse than=
=0A=
corrupted: their content cannot be recovered by retrying, because the first=
=0A=
read still reaches the PHY and clears the latch.=0A=
=0A=
Sleep before the first NSR sample so that an operation issued immediately=
=0A=
beforehand is guaranteed to be underway. The pre-operation bus-free check=
=0A=
pays the same delay, which is immaterial - a single MDIO frame takes over=
=0A=
25 us at 2.5 MHz MDC, so this is well under the cost of the transfer itself=
.=0A=
=0A=
Assisted-by: Claude:claude-opus-5=0A=
Signed-off-by: Polak, Leszek <LPolak@arri.de>=0A=
---=0A=
 drivers/net/ethernet/cadence/macb_main.c | 20 ++++++++++++++++++--=0A=
 1 file changed, 18 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c=0A=
--- a/drivers/net/ethernet/cadence/macb_main.c=0A=
+++ b/drivers/net/ethernet/cadence/macb_main.c=0A=
@@ -340,10 +340,26 @@ static void macb_get_hwaddr(struct macb *bp)=0A=
 =0A=
 static int macb_mdio_wait_for_idle(struct macb *bp)=0A=
 {=0A=
+	/*=0A=
+	 * NSR.IDLE is not deasserted until the MDIO state machine begins the=0A=
+	 * frame, which takes up to one MDC period after MAN is written. MDC is=
=0A=
+	 * never clocked above 2.5 MHz, so one period is at most ~400 ns; allow=
=0A=
+	 * an order of magnitude of margin. read_poll_timeout() sleeps at least=
=0A=
+	 * (sleep_us >> 2) + 1 us, so the guaranteed minimum here is 6 us.=0A=
+	 */=0A=
+	const unsigned int start_delay_us =3D 20;=0A=
 	u32 val;=0A=
 =0A=
-	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),=
=0A=
-				  1, MACB_MDIO_TIMEOUT);=0A=
+	/*=0A=
+	 * Do not sample NSR.IDLE immediately. When this is called straight=0A=
+	 * after a MAN write, IDLE is still set from the previous operation,=0A=
+	 * so the poll would return at once and the caller would go on to read=0A=
+	 * a MAN DATA field that still holds the previous transaction's=0A=
+	 * result. Sleeping first guarantees the new operation has started and=0A=
+	 * IDLE has gone low before it is sampled.=0A=
+	 */=0A=
+	return read_poll_timeout(MACB_READ_NSR, val, val & MACB_BIT(IDLE),=0A=
+				 start_delay_us, MACB_MDIO_TIMEOUT, true, bp);=0A=
 }=0A=
 =0A=
 static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)=
=0A=
-- =0A=
2.43.0=0A=
