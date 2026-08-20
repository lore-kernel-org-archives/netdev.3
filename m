Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EE47043B;
	Thu, 20 Aug 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235945; cv=fail; b=nPsXnvoDlxEV6jjqC8Z+gGANsQFrDVa/SaT+vMWEhfHfkBk8D2Q8IAY9/6j9Mrx6K6reWLi501XPK84tQ3qIl4eb3jbZdAg+FSc47aGPoFn/remdb0Ky467nwcNKN5SDKYULPvly5fATL6esKMm7qmkzwKcdVo5Dxdseu6Xf+TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235945; c=relaxed/simple;
	bh=MlnRC/dQ/elCV5gyOfnsNxz2oH47wySIvWqLuTdyvTs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IA6M9ye+BFwHJs1iFaIKVZc2IMDvi92DtFYjUlb04xQVcE2ICUmvjiKlpGT8IkHSAk5n1JoQN3X6Zp1pWCW6jrPjSF9GmMXYxl8hN5cDXcVDVu5AFKB7h+sdU257YRYX0FztjrdcJ70U+PCPWHegkz9yT/6fOXuOHYSDKXfcrQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=cMp5kNgS; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="cMp5kNgS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb6ojGcu/kKbFoq0DO8JUGYpi/5OEoV07P0CZrODjT7j0Q4VXlpyj4OixDKJio33yuotznFX2CVequw/cv23SLeba3tL1mLWF0cfsUuNbB5b0utKa0jIKXDE8Tn4Mp27uzxkOtRxhQPrFNOBThONyXrUFVsFZl2dqsRf8fSQ4zziYYfiWfDQ6sLjGzJhgGoxMBYCUYRMFzj6P4YR1M/GYbpI4HJGqzR2LUgb0HBZFZpsCXccFlKRN+EN6sZzJL82ZyoL2gzvfblzd7tO8r2eb5SEcESRGsNFVWRbYUUxV+how4PIdACqH6WVvdOnDJ1p4qbMGwNYOMSC1DOeyxOa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhlWqaDOEHw1xAOpYvwkF+Tj1feSSmX+ry1VZ+KKdEs=;
 b=tuUx2VdywqKW9RnP3rdK2XteCT9qvD2DPLRIno6+vq/xILOrYtntMJG/TAZ8OBUfXEjYHB732Z9aeDL1cLu7+eo8Jcg34/kSn0s0MQZpcZQGxUMesjMIYcNERY6xaFYrRWP5dd442WOQq9IAGO64CTSAOB0JBdvwcv9Z2hJRRibbB40fJ0p2dEkuegM+aK4utOEmVQkobSFF4VXqFBpHBG408BB3+PcTJJWduJ/8xVIR+7CwxLcQQUIikpgv1rHQEuh2n4FMoEPu2+HThZgXuhdQdelfqoOqrDhd5ZFoe1/ejajJuZo+1T9hdVGm7tbfSi9H2nIOnX3dkTARJpnEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhlWqaDOEHw1xAOpYvwkF+Tj1feSSmX+ry1VZ+KKdEs=;
 b=cMp5kNgSBJsVqsgSoe/cyXTr+q8m/aqLF4dXzh8bzZMknSAgQqYZwD/NhWLz8VWrA6HqK/zrsQFV55RFMTw9sqbVxV3nV+SAAr/q9NT116HwNZPHNS5/bn7NgH7M5GV5wsz+Bidi2Udqode88fMsO25fxo7f7+TAtpFJ36Nwlq5zgLTBsXwUgGKPLjoN5H7qdncUbzCelJh1yFkd3IPGwo9/tVWgaQ91nmHTOR++ImYX5KPWo9MwzMG+4lrE/AVkD7PkCdkiZ7TuCy11rJJag0DbnxyQ8tcIor3aYv7UIJi657bwE5WgidRKCcd7nI/sv9VCx+2/5SaJKmyj1u1Ucg==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by VI1P189MB2600.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.3; Thu, 20 Aug
 2026 14:25:39 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:25:39 +0000
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
Subject: [RFC PATCH net-next v2 0/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Topic: [RFC PATCH net-next v2 0/2] net: pse-pd: Add LTC4266 PSE
 controller driver
Thread-Index: AQHdMK/GAoecupEPdUSnby/yYa1CLA==
Date: Thu, 20 Aug 2026 14:25:39 +0000
Message-ID: <20260820142429.2285172-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|VI1P189MB2600:EE_
x-ms-office365-filtering-correlation-id: ca5b0736-7d27-4983-fcd1-08defec6e894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 q1veKRrUjJv7b5A0NIcM32U3hged3MOPTcNpKDaSpe05HXtNkXFHeDNcYW5GULSsBLfjvwg3nOBr4+572/Na6bWwDsaoLCap0xKjRO/kNwePguOs+IvfBCrBTH2nCEYB7nJLfEYLmbVpB8rl/kb1VMQdgYWSQ1V6pp8vx6z10aJUQyVf0wb2yJ49udIH7NQXrwduHpSFtH2R+qf2frgjdHung6ZHIrxsKmojyDKiVT1nR3PmNZWUfByZD5BQyKTBeeyBChCgvvOg6KyZ/39hRyTQT7dhgWZBwUa+FetLBwGLVb4x+uBmmT1bdtd4/TLr+c5CDChdC86XclGnR2ICHN8S6tYw3IxBHsjPT5NFQp5c6t7NZRYcZ2sSdnejvOqBfeS3aBbhvVf5D2CycN9REqaVl3Ys3zTNYy6d1JIMQdnD2gR4213EQV98Ux6bDdTozv3pPFssX6u4Wy8zv1nDidTBwfFB1WSJPUXrarROicxlAqGyUKTgzdPQ/A6vUxBDjG1R+ROoBKySVAFFoK7ZfZgwglyMfAsB+BeRxxx/cA3nQh0Wg9vzDxQdAX97ymBM8n1hXoN8tzIIuTUlO8bm+tqStqa3TIaeXS0RKDrKYML0cpAr4K+jcDsO62dykS/CwqMXKTfm1i++G4gUW6H4UuK2dO2V7vF9CkIKxhKg/Gty36Ures4o1K38NZTOV3BV18ViDd5tponmHkiK8da62zvpB8XS/F4dd1tqV/S0QPbQdwXau9UkLxpW3JhU633P
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kkLkIls3oKQEz5WNfZL2NgabJu5Nvn+CaRvdYUVSo8htIAIW7d6LV4pD8y?=
 =?iso-8859-1?Q?js2Vfyy9caABxBaHQ2VMG/dt6RvAlioERc41UoeNXlxc0BKYlwtxhXHkMR?=
 =?iso-8859-1?Q?FhaNJDcZsSw4gSL/bT2iPfCehwFodu1BEFbQ5U8RjjuKkRw/ZVdXNcr7HB?=
 =?iso-8859-1?Q?05odk8EX9Ljs7kqDFfu2ggVpMvC41UDUbv2DMY553i9Q5ggr/ZtoT4M74o?=
 =?iso-8859-1?Q?Ez06NLwHjhAPkRNieGAYmRjK17wxnybQEJ9wKm2LMHN0rlVSSEXFyZ4qmO?=
 =?iso-8859-1?Q?30FQayx2eaRjUgv66aVJvmo9g5jI3SlGXoUfQy9Z3IZqJpBYDpQzcraj9i?=
 =?iso-8859-1?Q?knK6XYXtzDgxi0DRd7Z0psgXtvwiwS/7kc7Ir2flSckFKXoLscc/P4XBxQ?=
 =?iso-8859-1?Q?3T6AAgJ6vP+HDTl5SL/wz+q1NOgf21HR89xd5K7rt631a2c/kmOZLcen/B?=
 =?iso-8859-1?Q?A7tOWvSK5Ptu/5czG+M6Yz14TTLeQ/WzLfGrR0z8d7UGjn2LplRtkwZthX?=
 =?iso-8859-1?Q?bDhxNyCT0zXd5/s+/7FOTuUJzB47S0oK3YZygNm8PLJ5aeS7p6lUvYAv15?=
 =?iso-8859-1?Q?2Br+XABEOX3bSxVa6NM4WAciHdGdQaz5KIxCnYeK8hNdl78uoVYeoGq3Dt?=
 =?iso-8859-1?Q?15dL+xOv5Vx408UyUj22wY2WQQTzIVdz87xS/xsbd1vs61Ek+yz3XdnQtZ?=
 =?iso-8859-1?Q?1GMzc8ovDMWlvh9y31oLKLVnIO+a2JatrJ18spioZ5G8WdrU8Oq/ihbTQy?=
 =?iso-8859-1?Q?DMPbOwNjyOm71Bakr7Bz7aHjBSFQPwoIVG6/RnhiC5xeszC1knJ3SWK30N?=
 =?iso-8859-1?Q?dRgZoLBfNFKZ+r4HpXh/lBqVHLKkRZeqvVO7ByHJiXaHMK2cEA+JDV1gBC?=
 =?iso-8859-1?Q?RV5fy7wo0TcXVEUj8trFdQDUiWO/bkJyxn3nLXNUcfn7U/xYN4HT1dfxrn?=
 =?iso-8859-1?Q?7bNoQ9UTB1LdZ/v96D9BlpEwOKHLPA+R2Swl3zsm4nAu/EnFCvaetsoLLJ?=
 =?iso-8859-1?Q?S3GxX7Rawma3Bje7VW5RDdOFbwY2LBCaceAgfLTlKmH4WMtxeozHedXoFG?=
 =?iso-8859-1?Q?lOVOimn3ejWLhM/9EUwE6cD+pBZEBb2vWMFYAo1D70K2LX5Fxp/k0uJRV1?=
 =?iso-8859-1?Q?QNTBpk8imk3XPLMVvJPwSO4YIJ41LVuJBRD6Gnxrpuqu2NjVTlzWxN32NZ?=
 =?iso-8859-1?Q?fYJb/CdTsJo22gAZf+1sQ6Ne8t9+oUm/V/ofGw0buIiGuA01g7EwtTO8PM?=
 =?iso-8859-1?Q?Snf1mf/Y2VxMkAzInklaSx2pbWxL42gpRly6PT/Bumc6BWMOJuoIPjQabm?=
 =?iso-8859-1?Q?BXj7jF0rqcquj5TXRWqGsEBn/YqWETjrUPRwB0KrHYXD8qrjwMdBIz2opV?=
 =?iso-8859-1?Q?B2h3TW5L42VPa8EhK5xlV3Ky5yPY78DXku0FFjLNxsRi0sDyUVnlAQMtGT?=
 =?iso-8859-1?Q?86qyDy9SBTo8xAnBzjVFV3MNHeNN0kRn6zEYKMXZ2DrfkzLl0+Hm4VtMm4?=
 =?iso-8859-1?Q?6bqGpbZJLRTT7mQP9Uuf6jO5LxHCkelOOT5/n74aYQmSw8UVn8cc11E8H6?=
 =?iso-8859-1?Q?ldN72YOoSomvceDLS7kkg4btrEpJpT/LCXZgCOnsf76fDNFy0QQmvkiZWx?=
 =?iso-8859-1?Q?aRdG/q5nLVlK5381D/53lF765KPH+9b0XKVivjemWACq/AOUfbjRqkiXCw?=
 =?iso-8859-1?Q?xQ2DQgFA7ccm9QxzVsziAP7x8RULxxG5C48qgRJsC+OpgV/YjzGFyKY64K?=
 =?iso-8859-1?Q?DfcwZLHs+mR7qx6d+4h8jbDxbArbeKcFVZxilaXJKIU56HkFif+Uj7RUh6?=
 =?iso-8859-1?Q?15mc0/7cGA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b0736-7d27-4983-fcd1-08defec6e894
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 14:25:39.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPWDfbatl6I139XWtjXYKsA2vY+NgAsFhD78D5nNaGCFukdM5eaegHoCgli4T4wLMUUd22Adq7g3UK+KQoLlTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2600

This RFC series intends to continue discussion around the support for
the LTC4266, an older PSE controller that supports powering Type 1 and
Type 2 PDs.

This chip has four individually controllable ports, each with its own
detection, classification and current-limiting abilities.  The driver
declares the static power budgeting strategy.

The LTC4266 only enforces a current limit (I_CUT and I_LIM), not a power
limit, so an admin power limit has to be turned into a current limit.
There are two problems that fall out of this I don't feel like I've got
a great solution to either and would welcome feedback, hence the 2nd RFC
version.

The first problem is programming the current limit from the
admin-specified power limit for power limits other than a specific PD
class.  For this, I replaced the linear regression in the first RFC with
the minimum port voltage for a Type 2 PSE (50V, from Table 33-11 in the
IEEE 802.3 spec) to convert power to current.

The second problem is that when the admin does something like

    ethtool --set-pse eth1 c33-pse-avail-pw-limit 10000

the command fails with:

    netlink error: Can't calculate the current, PSE voltage read is 0
    netlink error: Result not representable

unless the PSE port has been enabled first, and the PSE has detected and
classified a PD on that port.  I'm hopeful I'm just missing something I
can do differently in this driver, but if not I'm open to adjusting
things at other layers to support this.

---
RFC v1 -> RFC v2:
  - Rebase on net-next/main
  - Integrate and test with the PSE core's PSE_BUDGET_EVAL_STATIC.
  - ltc4266: Convert register access to the regmap API (replaces the
    open-coded read-modify-write helper and its explicit mutex).  Note
    the explicit mutex is gone because it only protected reading both the
    high and low bytes of a port's voltage/current.  This isn't actually
    needed because reading the LSB will latch the MSB until the MSB is
    read, so I2C transactions between the two reads are benign (Oleksij)
  - ltc4266: Rename LTC4266_ICUT_RSENSE to LTC4266_ICUT_RSENSE_025_OHM
    (Oleksij)
  - ltc4266: Rename the ILIM AF/AT constants to TYPE1/TYPE2 (IEEE 802.3
    terminology) (Oleksij)
  - ltc4266: Add kernel-doc to ltc4266_port_set_ilim() citing IEEE Std
    802.3-2022 Table 33-11 / Eq. (33-6) and the datasheet Table 5
    sense-resistor dependence (Oleksij)
  - ltc4266: Use the standard "2-event classification" term (IEEE
    802.3-2022, Clause 33) instead of the datasheet's "Ping-Pong" name
    (Oleksij)
  - ltc4266: Document the ltc4266_port_mode enum
    (SHUTDOWN/MANUAL/SEMI/AUTO).  The suggestion to treat any OPMD other
    than SHUTDOWN as ADMIN_STATE_ENABLED didn't really apply since the
    PSE core added the PSE_BUDGET_EVAL_STRAT_STATIC (Oleksij)
  - ltc4266: Return 0 from ltc4266_read_iv() rather than -EINVAL when the
    port is not delivering power, so an "ethtool --show-pse" query is not
    aborted, and clarify the "delivering power" wording (Oleksij)
  - ltc4266: Replace the I_CUT (18750, 0x3F, 850) and current/voltage
    (122070, 61035, 5835) magic numbers with named defines (Oleksij)
  - dt-bindings: Drop the blank line after "channels:" (Krzysztof)
  - dt-bindings: Move the channels "description" after
    "additionalProperties" so the structural keywords stay together
    (Krzysztof)
  - dt-bindings: Drop the blank line before "type: object" (Krzysztof)
  - dt-bindings: Collapse the double blank line before
    "patternProperties" to one (Krzysztof)
  - dt-bindings: Use single quotes consistently for
    '#address-cells'/'#size-cells' (Krzysztof)
  - dt-bindings: Move "unevaluatedProperties: false" after the top-level
    "required" block (Krzysztof)
  - dt-bindings: Drop 'status =3D "okay";' from the example and tidy the
    surrounding blank lines, including separating the channels and
    pse-pis nodes (Krzysztof)
  - dt-bindings: Reword the channels description based on the review in
    [1] (Kory)

[1] https://lore.kernel.org/netdev/20250517003525.2f6a5005@kmaincent-XPS-13=
-7390/
RFC v1: https://lore.kernel.org/netdev/20250603230422.2553046-1-kyle.swenso=
n@est.tech/

Kyle Swenson (2):
  dt-bindings: net: pse-pd: Add bindings for LTC4266 PSE Controller
  net: pse-pd: Add LTC4266 PSE controller driver

 .../bindings/net/pse-pd/lltc,ltc4266.yaml     |  180 +++
 drivers/net/pse-pd/Kconfig                    |   11 +
 drivers/net/pse-pd/Makefile                   |    1 +
 drivers/net/pse-pd/ltc4266.c                  | 1305 +++++++++++++++++
 4 files changed, 1497 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc42=
66.yaml
 create mode 100644 drivers/net/pse-pd/ltc4266.c

--=20
2.55.0
