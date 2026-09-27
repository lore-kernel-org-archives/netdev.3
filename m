Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07703C3450;
	Sun, 27 Sep 2026 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544592; cv=fail; b=XZG/+TK13wU8Xu2F5TZGmeDbPHRbciujKwPJjfnMq26v/BgxnW9PwcLSqgO4NVKLaUQmr481tmQcPH8MocZfPbTQ4z6DFy1jCy8HJ0IbyTCQIsQU0tE+Iq8yeDer/xErK5mnjOnUe52AxcEdGOHOB2haUePoCjDVgmFcp3KOlGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544592; c=relaxed/simple;
	bh=7axoYfJjw+zgb9ij91J401fW2ZvK6W4O7ptHM5MMENc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bmPWW9uTh6Ei+5twZka6xr6k1xzl/boGctHTNGtjk1YCmapDLFKbMC/fOawWvtUfXjuBOG8e+vgbvpMeYrO6WTxaVshJ1jtnglLNHGkgRKNt/WsR6viJAt4NgbjifSYAP6mVfEiEbhSILAgBJDN6OQgy7ctOpjnOW9EFfbFkW0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Evg+EPhW; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Evg+EPhW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De3DkQX7O7aQVq84ocUTyn0CncriOPqo7ImSyVJ8dR0lUDovTOzgToWuJv3ajBBallT+MYeds6v3zc9Fe6+eS+VI/zs/kCgU+WGe3DJwG9ePY+nSSpw03TwwOVYx2icBSV5vNO5VVvc3V1C0cpvHRjEs/evJiFGHFNY91LnSalZF7O8C1e+Av/KaLLLgScPdc0n4TWlLpZFtgOZEbdhQTia08WM1CE+lEvZFxwfH+Sry/9KgKhk9LnNRN4ZQzOkJMwnVEYH2PSVvgntL0W/M5vVI+c9aAUnU+5qW8Ol/wOu+C6oXz2hMUmUiqkC7ug5vcMDNr4QDXzS/ezQ1NIS2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED2TQQjjEp2CXRqm2Pekzhj/1XvNE1Rr4ivD/dnRVVA=;
 b=gIo8eJ1KVVk1l64yPgWVKoFBuSGwQMpycYjj0RF7cBjIPv1pLKne+wIuKRY+gUEx7xmuVoYJZ/xnh23F1P3ceR6qjSfEJG/KRrrpQ7GvsZ7WYQwO1aPxYlc/bTXFUs1SRntxOldB0HGdLZONFyfHK1XmNrURVaxZv1rq3tbcf0V+wBk5WzFdU6HSgT9bbTZ546c8SKIudKH1qPh1EvNQnZopLfny6XUmGEVMYfi5m4kSmH9ykQQPzetQJZ8DIPgFFHtHpe/94CbPyBoI0zk8Mpmnp/l7KFL62dyqpDU4BjGxz13bRz37E58p4h+ExWJVaeNm6h871eRfwm4U9dB8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED2TQQjjEp2CXRqm2Pekzhj/1XvNE1Rr4ivD/dnRVVA=;
 b=Evg+EPhW8iiTgQcW9tSeGPdY8YI7M2NK47oO1dJvn58exdTLHzycgDEfKLvxNS51irR9kZPc68xLvgFA9hHlNx6dlhWql+wxV11RkOVi4/uJG+OTu9R5VQqTLcY6nwRuXcojCr7TUDY9OLBJtvsoIHp+HJOXNgiY09DvUCfnPeSPsT80rXjX36d2NVfW1VK6t664gr+231EJCDOGkilxcYbqrwryMJTh0CNqOnKGlMyfLHaMtRbsa1i5mAW7hHFx23AOL7U8r7dDrPp94WlNwpyoTKTszvBjWJPu0cTffNek0o0ngI6cmm2uPDn2sUtpP6SOomSwYL7Q9pEBldJr8Q==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AM8P189MB1282.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 21:29:46 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 21:29:46 +0000
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
Subject: [PATCH net-next v3 0/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Topic: [PATCH net-next v3 0/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Index: AQHdTsdR4I9LZQ1afkexP91TF8qyIQ==
Date: Sun, 27 Sep 2026 21:29:46 +0000
Message-ID: <20260927212929.593366-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AM8P189MB1282:EE_
x-ms-office365-filtering-correlation-id: ffc68a45-c076-4803-a847-08df1cde7419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|11063799006|56012099006|10067099003|6133799003|921020|18002099003;
x-microsoft-antispam-message-info:
 76+5a4TZQeMcCKtBsxTLBQA0SFNiU1DteOg6y/ZfWXsKmEFue+E3U6QF8dm/viX3bFFnot1YwS00JsCDebdrpz7DzVvcX7OBs6UfNxQ1v7LbZp0EijzC0QSg3c5n6b9w0b0bhDX5b4YbF33GQOMnHez2evubHEcdNIu56DmyWtF1U63kFHD+Nqhx4xce+w0vuvaQQJJ0VQnLWEC80JZRs6anuqCSf3L4vQSnk9nJ5j+umn1jEe0RXJnSt8R/IE6/dS+ISEd+4C5eod/UHh9uhkJhtTWE5JHkWnqoXLTrnjDnjnd3iXr9jmmzAxtO+SDv2sv+gaoyhEmsfHsrjYHbrjUS1h7O0LsNalvEcJLR5da2f5Uwdnf/vegSEGU2GygARtE6rlaNYKOU2nvb5kK4vl1DGciiNXXKVduLSk1q+VhISsNqIaX/X7HXhNgjPAkpNHwwHwc4cSN4l1S4PCFa6iR2aG80zawPeKMcJPhDUHhFGw5mMoluR36iV1UZvSN9zlbwXAbYhhe1q0XTQREB2HfWDS4fH6fUGPVNSaoRJiOUA5PE969dF57PXjLpWDw8aDYvgzjSKwaMAv1Fj1nvcSDnylRoNvn/eFezVJeZ/7sb616VEDGqWJwfhy7irJKUIAEQGrjXOu0JZBxfvUAXu1sOcuppV6pKmhdSCkCX+RRWlS3GpCzidZ8RaaEz/lgpQ+9I6RHk8vu4TL5tnbi7JDPoCms/CxxJwhBMClIZ55TkfX0OEkF/j9Ha1Re2l0VE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(6133799003)(921020)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5VVYrQ1fVt/Gg7N0NM+5MnJa85OnOZj2QmQT6xCtetfiuCUgtBw3xMP9Tv?=
 =?iso-8859-1?Q?BrW3r1a7NOOO7tqdHB87DzG0H6ww3IV20R5FeIhEJ71TQjk14TN8RJ8VfX?=
 =?iso-8859-1?Q?/CVbdZx+BnHGBGj+z4UEcTuLePENuzoWVlYtYfERe1vltefHnD1abD0oX7?=
 =?iso-8859-1?Q?MLKu4raGHOj+HGPsjc3n3wO0ir56ZnJpEh3/sI/3J0u6/6gU28CPNPhA8m?=
 =?iso-8859-1?Q?ByfqxZuez2PgK9/iPaz/sKEu3ATQwnrEakbjjup4vJudVB3WI2Dqs3iTLG?=
 =?iso-8859-1?Q?DCY8SiDdIsM3nvCu2kHWwaH1NRvwDS3yoYFM7+onBf/FU4FWqqeqjVZBTj?=
 =?iso-8859-1?Q?a9qejhRMI87++ZVKua3P3mnWD853LL8g4OD4REbNl9pSJNSc0xZTxOB29o?=
 =?iso-8859-1?Q?XKGFKTxj7wiRxmO0D4bEEG4KTcMxON74fHIAlCzB9xVW4xDOYLyBJrJdSU?=
 =?iso-8859-1?Q?du46XuarVUtn51LQ5Eu6W7WM4zi2kDmXzLVWDCmOAceNUhHutcNQUSa6nP?=
 =?iso-8859-1?Q?3pVbL/rxKgk1CWZPJp1GN01EGwmS2CKwFBlvEK/hheLbiaHOg2sZSO7omF?=
 =?iso-8859-1?Q?EJrC91KdwZlaF5WCmmzjuiJS5fvQ3ca0FnoXTVIA5Cf7E7UvwRKF6tgWZX?=
 =?iso-8859-1?Q?hq+BotFC+hBUMEwbkqv/vmnAiNahAZVbv0/old6ftBlFukYnfd1DR3LOTX?=
 =?iso-8859-1?Q?YygsAM+pfM/NV3xCC1yMKBl44CGejLCvTocLiAZkKht6r4txlEK7pinsCu?=
 =?iso-8859-1?Q?P1h7Vovx7g27GZt5vqFMGrF5jQLkVTbnUQEct2FXv/Dz0dZddjv5+VTLYi?=
 =?iso-8859-1?Q?LZjf9YkmKbZrwDt6uZAuPNVfv6RYmJ/CAZIb6VLeivwtrhlvDN78hOSy4P?=
 =?iso-8859-1?Q?6iaqkGA93lESa9khgeODGOC1bCarz1yDghInO/zhDy9ga/HpJfEBeVNySm?=
 =?iso-8859-1?Q?6SnoXFYT1+kdLVtltT5zT3UUQMbAOwJV288kagpGqqLbXrGRNtGMke3xJF?=
 =?iso-8859-1?Q?q4i9XBg/6uBYVNYp0Lh3RXkPKr+X9SJVzVRk9ZGigcdSFhVJza//rSRwuJ?=
 =?iso-8859-1?Q?gcJJkAbE1DCnv7ewrZDTxGGyNwKFqeNYnSPjLlUFELwHwVjK32TwI/9T7z?=
 =?iso-8859-1?Q?Lp/UvHdq1FSHP9vSx2IskfUJ+GmB4MugRD2oy0tnDD942jPy574Tgovmmf?=
 =?iso-8859-1?Q?00CaNFpA+ly+7sX/+Nuh44jjHqgyQ6JvSQ7lfEB1fUqpiJaGV+j48Xaesu?=
 =?iso-8859-1?Q?GpiJJ4x10iDUjdia630clU9wtkcl8Pd+8pVw6e3btG5JbD/KaG1L83ce5A?=
 =?iso-8859-1?Q?JVbglRvS+dVli2wOKTHARANNai9tsHUtFjEIeIpKz0VYVSksR/KyX/U5mC?=
 =?iso-8859-1?Q?5896xsE9WtrFxkAmL6F6TxJGiFFeVUXJ0pfr5asj1xLwq0dejHdKbq4G59?=
 =?iso-8859-1?Q?LJNTn/FEaOIsRuMOmSGenAmAkGatVcdL8m+FufZW6JTkOukeO7zBMFTL/1?=
 =?iso-8859-1?Q?cdNj9q1yV3Up/+HVm6BLr0+afafv5MPZRMR2MTuNnPTDJBeay7bHjDVYIg?=
 =?iso-8859-1?Q?/6aU6NxiNT5wugrahGFTpsmKUJWjZAasDyY6uGCpa9e3wpxWCGIeIsFhIJ?=
 =?iso-8859-1?Q?SkeGwz6xq8t1lxFbjkywUXbF8AAOXvGw0KfW9XwLohJsFpIfrCmY1TZ7/X?=
 =?iso-8859-1?Q?eHqVQRSwqYdBf/mOep4K1VES78jqh+ZjmOiM7rMBd4hPW90XGoxLKgw83d?=
 =?iso-8859-1?Q?AXakn5/pbteAEpHC/xO7aTsApDVEQQCO6s4QEXeAih3/+44ab7sfnGKNKj?=
 =?iso-8859-1?Q?i3o1FOKwAw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc68a45-c076-4803-a847-08df1cde7419
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2026 21:29:46.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC8ZcK/y7x3RS3qd9UpOfSJWI+m5cCdy4DHm57RlyQR+YqsRNzNR7x2kjMq2tnJpXWDx6IFLjWiw2Cei2zAZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1282

Add support for an older PSE controller that supports powering Type 1
and Type 2 PDs.

The chip has four individually controllable power channels, each with
it own detection, classification and current-limiting abilities.  The
driver declares the static power budgeting strategy.

---
RFC v2 -> v3:
    - The admin power limit is now configurable before the port is
      powered and is independent from the class limit.  However, when a
      PD is powered, the current limit is set by the minimum between the PD=
's
      class and the admin power limit, to maintain compliance with the IEEE
      spec.
    - The LTC4266 doesn't support reading a port's voltage (or current)
      until that port is completely and successfully powered.  Since we
      don't have a good way to measure the port voltage, we'll first try to
      use the vpwr-supply voltage if available during probe, and fall back =
to
      50V (the Type 2 PSE minimum) if the regulator isn't available (ENODEV=
 or
      EPROBE_DEFER) or doesn't have a readable voltage for the port.  This =
is
      the voltage the LTC4266 driver will return back to pse core when a
      port's power good bit is not set.
    - Report the hardware admin state from the "Power Enabled" bit instead
      of the "Power Good" bit.  The latter is set when the port is fully
      powered (after inrush) so a port in the process of powering up looked
      disabled to the core and had power domain budget allocated to it twic=
e.
    - Added a Maintainers entry for the driver.
    - Avoid precision loss in pi_get_actual_pw.
    - Demote a dev_err in a common path on device disconnection to
      dev_dbg.
    - Add an err: label in map_event that'll clear all the event
      registers via the INTCLR push-button to prevent a possible
      interrupt storm.
    - The supply and over-temperature faults were too hard to test, but
      they will result in a disconnection event for one or more
      channels.  Replace those faults with a combination of a "power good"
      change and a port status check to send a disconnect event to the pse
      core.
    - Bail out of probe early if we don't have the required IRQ.
    - Replace the driver's .remove with a devm action registered before
      the controller and the IRQ to ensure the IRQ is freed before this
      driver is removed.
    - Drop reset-gpios from the binding, since the driver doesn't
      support it at the moment (because my hardware doesn't have it
      correctly wired)
    - Expand the description for sense-resistor-micro-ohms to indicate
      the property is required by the chip for accurate current limiting.

Link to RFC v2: https://lore.kernel.org/all/20260820142429.2285172-1-kyle.s=
wenson@est.tech/

Kyle Swenson (2):
  dt-bindings: net: pse-pd: Add bindings for LTC4266 PSE Controller
  net: pse-pd: Add LTC4266 PSE controller driver

 .../bindings/net/pse-pd/lltc,ltc4266.yaml     |  180 +++
 MAINTAINERS                                   |    7 +
 drivers/net/pse-pd/Kconfig                    |   11 +
 drivers/net/pse-pd/Makefile                   |    1 +
 drivers/net/pse-pd/ltc4266.c                  | 1386 +++++++++++++++++
 5 files changed, 1585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc42=
66.yaml
 create mode 100644 drivers/net/pse-pd/ltc4266.c

--=20
2.55.0
