Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020094.outbound.protection.outlook.com [52.101.171.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D1396D09;
	Thu, 23 Jul 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805578; cv=fail; b=aaHPGxeOFSF+rwKmzlzcD+ch6t59vhPOSvKM+dvIlRMlcelbkCLF49X07JEVqNgl2QSpHuwzQG+h0F50yHNqWynK4oM7TnYVUD0grJzfTJfVD9eg4578k0IGFDIEJ6qwzXUj6BBqQ/G9uPlRqCF2FzL/WuDqgmhDO1SdvfMlqMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805578; c=relaxed/simple;
	bh=3XlP0kEPsmKXA6o9bidtng8uNK0n72OM04KoPhhxFTc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UvG/li/iNb3Wyu0y8z9HZjxDbI/cJfdl1sh/8UozD+iINPJdr+3qQU+fC5hLJUwN107IDw5ozMMuM/bdxdC2G3KXBGFjGxLa+cnuxs5jZGhQtwHIJ/W32su8DxIb54sYSNxVQ7v8xCamLzWF+oOUIbSMjbLYFj/fXP6BSVgBIUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=DBJqLdKm; arc=fail smtp.client-ip=52.101.171.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="DBJqLdKm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxsi8t7OLkTBtEOa7ip7P1yQyI0WSBRVlUsjvu5bEzkFSPJA3b8ZQ40I7t9Cyklll3gGLn3VGFAxYArSIXM4ME8bi7JBx+jb6GkZ9oz2jcsLfXaitZ/IFQsnim0D/tfInvzycvJTAUGo1MnCRXSUXtONN3yf1GPNlA+qUtrARZk7OFg4w66nNmL4S+rsTV69E8O6JU/4lLpBF/AcPAJkzvUu8TEJoHoGG1fVH0zQW9o3XX946ab9SRo21QMSEk2y/025vzUxjWn7BKfmxbHOEW0aHXfUlc+dgyHQbakfwYrVal0Ao79hi/72ycJXztdznxmDiWenb7pfaMUg5gSNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/204nIx1/2olnG8SQshnPewQ6hobGmtgVl/hhAgH+U=;
 b=Dl0p1bxMgrAdVbvoHHPmYxUhJNC1xfYDOlS8zrlypZHai6ekYck3nzNtT3f9i4TvrJfs/tbl+1yYsJcivzZOH84JkAG7er7sFSCVLpsVSXNzunVQfFRtLy4xzUYxT1hrDJF9mgBeAqKb76PkToCJlkk6C9IMMdhw3Kzqz6M48toqbpH3csTX5aLnZAsS5xdu0uo93yo2xYxBYk2XbDeIciou2acZ5Gz/gCPne/4Oel9Iaj/Abo+6zGTGr0PNO+DEqHgt43QY0N2tbIr+xN4nNkKlsYB6USYY7V3lSdlckJxr14Kdcaqs5B06D6975EUYF3ZZWFKML/HsZ9Iz4sSfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/204nIx1/2olnG8SQshnPewQ6hobGmtgVl/hhAgH+U=;
 b=DBJqLdKmyJJoc3gHU124N6ijlXhHkG9eDSvHHInKfI40+tN3zRz4Yo1CmnHAmkZPpHS64ZvH1iBOXxL3OC979UzBu8fWnNRYGdCwd8wGZ5UK6aU8c3gLfzA73VZTieiCmLV+7bMMBqhc/eZaovMRqUy9NmUCIHlhzly5AhFHK4Y=
Received: from FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c3::16)
 by FR3PPF76E49D46C.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::157) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:19:33 +0000
Received: from FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fff9:96:1d35:3df7]) by FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fff9:96:1d35:3df7%7]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 11:19:33 +0000
From: =?iso-8859-1?Q?Tobias_G=FCntner?= <Guentner@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: phy: Keep PHY timing role
Thread-Topic: [PATCH net] net: phy: Keep PHY timing role
Thread-Index: Ad0alITWptjJ52jMQ9yNJA1MjXCJGA==
Date: Thu, 23 Jul 2026 11:19:33 +0000
Message-ID:
 <FRVP281MB5880362CC7F6E70359B4582FC7C02@FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB5880:EE_|FR3PPF76E49D46C:EE_
x-ms-office365-filtering-correlation-id: 372a18ad-0eea-4d76-f48a-08dee8ac45da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 AnxJaa0duY75pKTkuU2i0kU92AQoKY5s/5483EzudwWg6FqHUIZt7TT31X10iUJaBQ4cG3xLt4JrrqfUOllDw8r5pqA2CSM6E2/b2FBa5NYipLJl9dEGbPTJXEVyIXAn1njGtL9MczNgV8QDZBmNT5HgEefOg97gxyNR1tp83OjkuKzpkOlc0CYcoSV/hvh3PnEX4W7x1ae+nNg5UH3tNiieEaovRtjGKMaSe569Y5osmM4NbM7sDB7tWPO/RZMDRr4mDKZvUSHnQRBceyWGmk4n8WJ2vsyDHoblDR6D+R426ncyY6lN/JrObHoHe39iRLk25Uey646CJF+MpK6WzbiYQejfGmTKskq+tci9kuY1pRiwWAW89scR5FTV2msYikhQB9rXPjpy47GxrgMVaqXVl3c6qjw6HwX59Jv4LnL6BA0yC8ewpOPjx7emk7pt0olVN4LqnpI9TliHvYSpT5DsDz+9hYbWsrxnNXv2My0wF9ULZVI3FraKV34dLJY/iLV2mjXGEJeV1asg8tendm2RnQpyv693AhhwfkOIaIUVtUqYkYsTL4/RU/VzoNYZ1YZDhQLP6bQ96Q4tKMoYeudULWIE2Og+Ubu4qx63wfvbKKVO0tZDHGwOooPgkPOEhDYFtc06MVXrgG0d5+KkBWHO3nNBpdSrsth/TEwmv32VFFID3sVQa+PblectP30MPrb0DfpSUu5SX8nMrQXASWGNq5odTEwxodRbxUsnNxc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Kguewl1TTusqrPPYJpGFpF3owGiDq831ZKgxdIbVhHk4dv3Exmw2UwPK8S?=
 =?iso-8859-1?Q?UB06IYXbKrSe1RyYR4AaDRfxk+UNMnus5JD//lmYgShHDsS4jzQ/kla/Lw?=
 =?iso-8859-1?Q?ftSn22L1o16dIdVAAJ3t8Qugx/DmpCbKMsr/FW8LNqIMblGDn8GL/IWsBl?=
 =?iso-8859-1?Q?0gjRGJbbubYz/LxvnfHNTglOyMTeKvaS2Cccxdi9u9+AmBYxMYqh/CwPr5?=
 =?iso-8859-1?Q?dmBhbAFjM13qq2331/3JjrdKWuMC/rzu3SYVmjvqI53Run8hProlA9eU5q?=
 =?iso-8859-1?Q?j5AuDVO4Cd5TFLjSM7eldOIJGwHIUTwDzl8sng+LvvfnsPsJfGn10dDaln?=
 =?iso-8859-1?Q?0nDj4lsaWg1vUOp1UKk4WnBHWpn/b85lJ8MIOqrziDalAD35E0RFnmb6s0?=
 =?iso-8859-1?Q?rNhAUnsDx4MvhFGlR3TP+CoEvuTTKpIhGAlUoKyY1AfRNvqcdFN49EZQm/?=
 =?iso-8859-1?Q?iBOY+VUFscN7KQYWLYv6CEE6dqPN4Wfr7J48PYSDywtNrWw6w5MR1Y9b9T?=
 =?iso-8859-1?Q?N3BW0V8nE22B5/inGTneaA388XAkNHmkBx7wSsKyTQOeiBLP0RGF8kY+Uq?=
 =?iso-8859-1?Q?QPS7P2ZcZtk9wxE1rwxl4inuRJUJjKMawydwTGQY1KbfzG9PgpYrdAb0ty?=
 =?iso-8859-1?Q?PLI8bILNiN9cuhw7++MRfu70SLXrQNs5UloKoLVa8ttOSUot4COciyuOWk?=
 =?iso-8859-1?Q?1gBvcaOD0BvuG2ljknwkzk9RPVmooS9ERGZ14XN/MNZfyv1u8YMqiYkeVT?=
 =?iso-8859-1?Q?LN8oDB/bO47QxONkmhIq5cdQD+BXWnGvex+CU7o1/aIdn3bfKx0R4mj8Q7?=
 =?iso-8859-1?Q?JoRjVvlanPWQwA59mDi/dJvQ221D3PL6jNvI1AbfjO3JjbkCyPQKKpOq5F?=
 =?iso-8859-1?Q?mJR3lQznKges7U7d9uEgYD6qHuLanknY9Y/o8tSLmHiMECmG07MakbZdeF?=
 =?iso-8859-1?Q?t6sd3Tj8S1BdLsEw5JTzB+S/7s6Eo2wjxo7kh9XfCoFJW/EklHZRYiYCo4?=
 =?iso-8859-1?Q?SbD9dMQe3Nq/gzUmaX+yQuqx/8lwtKeK43/fVlf3kvwcbDb4INgjiZ1ND1?=
 =?iso-8859-1?Q?36Vs5JgZYqauiepYlB3L8MHIc8IQUhjRN/zn1m6v6b7AXrgY1mzEeC6UpK?=
 =?iso-8859-1?Q?N2kN29AGnSHpi/zUXjMNvgxBtTOehcXZbry2DIfX3tNtH4DUV8MaxzjpOD?=
 =?iso-8859-1?Q?W+u3dyw6JGP4uDnZW+lvzprO5yzKqz+Cge6PK1QUF49FYKC4q+vmM+ai4u?=
 =?iso-8859-1?Q?psNCGQ7K/T/w9atkWN0+V16u3WYSKEmtMfvmck5c0CZbKzNbiPn3fsDXYG?=
 =?iso-8859-1?Q?cUZtEjA8qTU5qaIIAk81u9kceX3Q7jRnBaR1Oc4sIAD4uBiS211rp0Vzva?=
 =?iso-8859-1?Q?5S/j8jZpAvQ/NbckR/hBhh5AFv1lhHdI01y0uVLjF6UscsH6DtBvY0oTgy?=
 =?iso-8859-1?Q?1vq2bC3bz/lyTYHZvc9cOKJHU0110Qw+Cw32KdgztdqTMmDJry2VsIZUXS?=
 =?iso-8859-1?Q?PF74JelR1Mf+UR0IgMdnvUw3CofYwU0nFNDd9qm7Tup8SQ+h3EsbFWM/gW?=
 =?iso-8859-1?Q?hzs2QJHWebQsrKK7bf4IKIFRqLfmQDOmxqDJqgY2dEu6E0ZyY8jEmHm9PW?=
 =?iso-8859-1?Q?F+4Bt93LKdmvvOzyw1BZmJBOjUhWTXRmrwce4X5x8AHGPQ7io3LeFYbSxY?=
 =?iso-8859-1?Q?zgzPkzU0RJUpnskCFzIOGvffsHTVnuE1RpX9kdBVVr6RYIzAvtza103bs1?=
 =?iso-8859-1?Q?IMm90NoM8NPfbeldg2GrW/DdZaxnSGAEVZb4xWdNzWDPKroUgujnmGq0rr?=
 =?iso-8859-1?Q?W4unVSwNCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 372a18ad-0eea-4d76-f48a-08dee8ac45da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 11:19:33.6939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4Ab3+eTEy3QD2mLXPyfkqawQk4R4HME37TDqlhj0qNQtxXarAu9PSj6ft+UEhi+5pLl9jOuxcrif4maNYkyKEYJ/F+pCz739sF+zf7Xpbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF76E49D46C

Some tools leave master_slave_cfg at its default value (0 or
MASTER_SLAVE_CFG_UNSUPPORTED). Depending on the PHY and its driver,
a PHY may fall back to its default (bootstrap) timing role, which
can prevent it from establishing a link.

For example, consider a system with an Automotive Ethernet PHY DP83TG720.
Let's assume that the PHY timing role is bootstrapped to "slave" mode,
but was changed to "master" mode via ethtool or device tree overlay.
Assume further that the timing role of the other peer is "slave" mode.

When trying to (re-)establish a link (e.g., after unplugging the cable),
management services (such as NetworkManager) may change auto-negotiation
settings and inadvertently reset the timing role if this setting is
unsupported. Now both peers have the same "slave" timing role and cannot
establish a link again until the timing role is changed back to "master"
on one side.

Keeping the most recently assigned timing role avoids this problem.

Signed-off-by: Tobias G=FCntner <guentner@schleissheimer.de>
---
 drivers/net/phy/phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b6fae9299b36..daff4f6827e4 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1200,7 +1200,9 @@ int phy_ethtool_ksettings_set(struct phy_device *phyd=
ev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			 phydev->advertising, autoneg =3D=3D AUTONEG_ENABLE);
=20
-	phydev->master_slave_set =3D cmd->base.master_slave_cfg;
+	if (cmd->base.master_slave_cfg !=3D MASTER_SLAVE_CFG_UNSUPPORTED)
+		phydev->master_slave_set =3D cmd->base.master_slave_cfg;
+
 	phydev->mdix_ctrl =3D cmd->base.eth_tp_mdix_ctrl;
=20
 	/* Restart the PHY */
--=20
2.53.0

