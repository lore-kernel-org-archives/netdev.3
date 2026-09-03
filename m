Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021099.outbound.protection.outlook.com [52.101.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27027A91D;
	Thu,  3 Sep 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413538; cv=fail; b=K1yfv2oJw1+X5GIveTkw5SrnTHRd62cN2PkwKyubva/Z1a8P2DxCOBAuYGsSJoQhGTNKYye8+Y26WBCAbMPYNlzUEGWuGt5XL63X5pqLAcrEmlhnkh6wo+iGizr0rKPqtbtbVGVrmwul0FfJPm4vjr5TdutdQCYiRh/MuCdCjtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413538; c=relaxed/simple;
	bh=oHhK3FBHrAKHZDscOi8sE9A49x8O5OqH6OOcmNBj5hc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=JFiliHzDAR9q5tLUNcbKkuaVqSgud+lNIlzbo5YgeiryjYMZy9xpbfX6JBKoRFMLfH5t2m9qLCIowyDZGlhV0Zbrd69fR2qqvQ7o0NLFgQGYMy9Lc6YgYlTcM9loY+d39EiDKM20ap+cjjs1XbAv3ILXt0aIVn72kCzbMsss8Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=USY295zL; arc=fail smtp.client-ip=52.101.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="USY295zL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IptGB74HJo/gpc/wLCQqM2Ve0/UDLiTVSr1ZVz4B9CXYVC0kUsnXGD1+RO4bYTe3Lw+npBr5zy6MXT9zodaSVi7iICZyYHjDjbiLalhPP2XX/5wzF3FJ0woeOGS7D7LiszNNbb95tlsl429Ftmck9XeLvC81A0QZu9DVl+5B8lLbdNxheBMbkCq3jqUvIEtzwLTLueh/fZX1cLp5BVwJ3CCUmfiCa3ZFdygyl7SnuU6x+JZxNEx9JpIt6AtF9r2gvb64CetBl3ERHQffebwNsVCrUyj/f9dYlCMD4QMW6qYUSj4zxUEOcFd7GSIRfQ0TM2Mv6xIuXwAVCUX00CIb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGC0vRs3kQJVmWuuxWqDKqypex4gGBRW9DilO20nkfE=;
 b=suBOfaHwPtv4dkEKWg+Yy1XibrZN0wf1upjXGOHeAuJIxfw7uNvH7Vn+eBwfBpCYmRBQTAoD5c2VwKcl+l6+RcimOzX63J6eYGZ2HiVdxeShgwHTERcJHyrRswxXwAbkPnAaJ2sKp3i+Ru2gRaqLHl9D1xMd47ib19qZFvPA9/BCVz40L070F9wKQ7+JP/Nf0PqhGa8zsL3Hf67FFNY8JPwPQaQM5mdMtNifyKQmsiTjhim/ni7zlAAeo0AN1+UiuGNxfoVZEIXF2D8s7b01VVIgzqsN0lucSx9cuzmWJz1Kn2enQAVQL8BuXJ/PJBAP6aVS0IMYyWUwnSInFjgSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGC0vRs3kQJVmWuuxWqDKqypex4gGBRW9DilO20nkfE=;
 b=USY295zLmkq/gCz7jNOkaA+o6fs4JqcyWAb9NhPu5rG52LmCSMq0wdDcwxYBDgk3IcnSH8Z/2qE1KqTgsy2kqN3GAqDqfsL/fUw03LKnZQBQF5Fvhf38KcwHycNPkWS3rTjHjD2FKnR6qkq0gR2Z9FGY7Moi6S44k824K548RPxL7+OIl2IHLncEu14zn9Ho6mkmQFF8MlREz777INad0t0jBRaTSQQI1jrXNE7ffbHuOSLrcJxRVSEuZ9fdnnmoYL7kDClsFj2ZFPa2I1v868pgdWRrf3LVSiGI/BD1RRIh3LYbWejXEHuTDjvpj93soFdg3+rCh6MtLwm+JH2dKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by GVXPR06MB9609.eurprd06.prod.outlook.com (2603:10a6:150:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:32:03 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 05:32:02 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 03 Sep 2026 05:31:53 +0000
Subject: [PATCH net-next v4] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ksz9897-sgmii-port-v4-1-538db2ffef2b@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAEgGmWoC/33NzQrCMBAE4FeRnI3sJrWJnnwP8ZCatV3UVJIS/
 KHvbuhFRfE4DPPNQySKTEmsZw8RKXPiPpRQzWdi37nQkmRfslCgajCg5THdV3ZlZGrPzPLSx0F
 W1vsGAQhwKcrwEunA1wndikCDDHQdxK40Haehj7fpLePU/4MzSpTaGjK1Vt5Ds8mOkzu5xb4/T
 2BWL8Qi/kRUQaBypKxx0Cjzjeg3RP9GdEGUNrVzFfkD4icyjuMTrRe+0EoBAAA=
X-Change-ID: 20260703-ksz9897-sgmii-port-48ddb100e015
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristram Ha <tristram.ha@microchip.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Jerry Ray <Jerry.Ray@microchip.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788413522; l=9574;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=oHhK3FBHrAKHZDscOi8sE9A49x8O5OqH6OOcmNBj5hc=;
 b=kWq+0aBFp0YSGrctpv9nPiNIUy5E/XwXmXYf21sTv9wX4272m941Ud59xkYuSJmIRyI9SoMYM
 PwGgdbSyY1qCSnb4tiHkqPjNAHQTwXYgXkL1WOQ+jsHaQDoC1hEO7jv
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|GVXPR06MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ca163f-62d9-41b4-083b-08df097caf21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|52116014|10067099003|18002099003|11063799006|56012099006|5023799004|38350700014;
X-Microsoft-Antispam-Message-Info:
	3wVEmDTh4/n0bUHqX4ZLbYSbiVmfwYYuWlgPUio8ziMknbMSxZpq/MmVe4npLN1zqp0odAloBwsHjaAdjsMBy+utqU8ViyhpelbebUN1cwmJviAjlAtTda1/7RICAwtratA/MW1EM5I8KXNcQfBz0Cw50TXNwL15X0+3/bPDiKGfDuQ6/MGGAe086dOZSmregqzzX7mkfI/+e8d87AqxlrD8HEa79+ctcbB4itTIHnFN43awFED6WoiCJYn4AD68HzOFUDMWAPh0UbDo+L0/vUWctd50NSNNuFNxF7gt2ngkBEfwrT3FwSaw3K4ZKisDmINK61vBlIETOkx73WLr+76AWyi7iYCwPazmXbigNWfVfSNl/IEoH78nbV88KJuztV5M9Bb6XpCJTLCupLbwT6ApC3ysJS8bqS3RS9rY8rZDlGI5R0WQHF4n8r6nrlqwo4MAcsySQDKbqbhQCrDkqVmlFaEiyVdQI3M1xx5PjdUH6afXNUGryCSCnS7cRq9PPho0Xt0aL2AzN1UZkPws0T1d3Cuze0rA/CyPQERXP0krvo2uwwu7XWTaSuh81CUd8QkeaW5GJGkFFI5a/ba+cCmfksZfbqyyAQ8LatOMLuo8lfFse3LEnjhlq5jE3NPkl+e0jnMnasSqDpu9bIlLk/ciBaYVuANJPtXpE6AmF+MhAfn8VVnw4jH/QlnzUhfCcrWdBfWjhbyLp7TKiT9YLhBm16n7Qd4tI+Y8KV3OtfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(52116014)(10067099003)(18002099003)(11063799006)(56012099006)(5023799004)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjlsRXdmQWw5RTFIUTRGL3Eva0V1dVNSSU94clBiWmFESldnRHZFcFlBeWVx?=
 =?utf-8?B?NkxFUlpENUpqa3dsdTJ5bWdVQUpMVnJQNlFDd245bWM3NzBvdEROYVFDWFBN?=
 =?utf-8?B?bHBLdHFEK0lsWnBOM0I1SUhKaWx2eWU2SW54L09aeUM5SnVwK0dUOGVPbGVx?=
 =?utf-8?B?TEVpOWhYTERjUVp4a1VXSis1UkVIWk5GamMrcWluTmdTdWxBWkNHVS93ZExB?=
 =?utf-8?B?TDN5aUNCMHJxNHJvNjExVWdXL0NIdjVXaWU5TjkzSDlFL1p6WHpxUjZxdk5x?=
 =?utf-8?B?OGpSTW42Zlc2Vyt6eThITy9xZFFSd1JjVnA3TzVVbDVwNytoa0pWU3lxOFo0?=
 =?utf-8?B?TWZpbVdMZHF6eVBWQ0hHMzJXRExIa2J5TTVRcnhqSnV4WmxTaDRoQStONGox?=
 =?utf-8?B?Vm52dDNtY0tMSkgvQ3QySjYwVHo0dVlRT0hacW5DeC9PbmlwNGhIMTk1cnln?=
 =?utf-8?B?bWxxWjFJa3pOYjlGbFlFMWpvbzFKaVVLTythSzAzNXN4bzJxT2FMZ1NJSU9Q?=
 =?utf-8?B?TUVPcWJwZWVGclY2SXkrZEtEOWZqWGtGem9mZE9wc29kdWRTTkg2MkhWZGtQ?=
 =?utf-8?B?RjQyTDZ1RmRBWG1DWTkrTDR0VStvL0twTWtXaytiOGZyQVJXUS9XY2hCMjFw?=
 =?utf-8?B?SW5UUjhKMWhJZkdmMDMyOFF3K0FqMHBvMzhXK003OE4wQWg5RDY4RDNZUzVz?=
 =?utf-8?B?QW1xS2dYMFBGZ21rdFl4UHZEWmtmb2VjaHZXK3RjSEZwN0hCNWpFcVhqSDVt?=
 =?utf-8?B?UlJIb0NTWG4xQUx1VDU4cHFQd0RucU5SQVRuM2RMS3l3OGs0VTlFb2JGdnhW?=
 =?utf-8?B?WitNMUoxejQ3OVprZ2FROS9LNytRTXIrUlZ2b0dQUEF1VlA0elBRMG5lMHc5?=
 =?utf-8?B?cVI3ZTZEUEUwd1R5YmpUUDBWNkpaZU9rbTlYcHJ4NVVDa2tOM3VZUGpUVWdE?=
 =?utf-8?B?cjh3Q0Y2SlYvVzdvTHVkUkpBdFQ3T2V5dFhuZ1dxSU8zS28vbzh4RXd1TWlC?=
 =?utf-8?B?ZWh3L0lBK2tqVU1OWTFwQkVDUW9xam9YQTFNNmozUHBxQWN5aEgzQVVXWDB3?=
 =?utf-8?B?dmtNUld6RE9JcTAyQldNVGZEQ2VoR3Vic2ZUSGxkVWVncXhRMGRXbWo5TGR4?=
 =?utf-8?B?NzAzK2NXYUZDOTEwdm9BWFc0TnY1NTJMOFBiR2EvVklxQkJabUY4ZFFZNUpa?=
 =?utf-8?B?d3RWVTA0NkhpOU1QbUVhejdtdkcxVGFJbEdoek54S1VaNUVydk5XaG9RQmtU?=
 =?utf-8?B?NldIWVplOHB3RFNSbVVaelZ0aVhEVVFtRTY0UFpWSWsySDlESG15NjZZN2lR?=
 =?utf-8?B?OGVGRHlZRlFXNlo0WkhRV0k2bkt4cnJzTlVqU2tzRzMwL3B6MlNFRkdaRkdm?=
 =?utf-8?B?WXRaYmI2Y1VEdk9IVXZTOXEybXU3c2NzeVIwTXI4dCsrWUMyN2U5ZU1nR1ow?=
 =?utf-8?B?TWpwMjZyOFlVUThtcm04ZXVJVkd6YWdFeHYvczNTS2V4MDJmem9JbGhmcHlm?=
 =?utf-8?B?Z3V4eVVGTU5tdDcrYVBrdnVQeUp3OExQU2VNZy9SMExoVzMxMkV3QjNOQ1kx?=
 =?utf-8?B?TUhZY01YUWN5MlJ4NWIvWTczcjE5ME0vSlc2TFJadzZFdStPWEJiNUkvRDBy?=
 =?utf-8?B?TFhGa0tGUGp0NWFISis1S2gwRE13NXhnUmdtbXNNVkp0Q1Rrb20xTlN1WGhY?=
 =?utf-8?B?VyswcDJ4UkxPU1prSjFaTGVtcmRKUlFiUGEwenZPLzdRaWZFODJ5SUxSNU1E?=
 =?utf-8?B?YVNvbTF4NnBha1RKb05lYXUrT1NWRUVMaWFtVXhVR1Rob2FnUFljdndkdi8z?=
 =?utf-8?B?RnB6Y1piaGcrTFRQYkVKaE1hcGgxK2tFai9MQmlYKzZUUEZCK0U0djdQZldm?=
 =?utf-8?B?ZElKNnJKUkxKYzlaOWVpd1IxM1JEOG5CRjdiZjNPN0gyUERTRGRxZCs4U1pN?=
 =?utf-8?B?RWRpeUluM1RoL3RMMWtzdVBHeWRuekxJSjd2L29XdnZxbzVNVFBldTNsK2Er?=
 =?utf-8?B?MWo0cFFoRGhJTy9wejNERXVSVDdoMytrSENhUG4yOTFnaFVPSHhqQU5FYzl1?=
 =?utf-8?B?L2RHeUVESEI5cFZFUlZ5UTJ4ay9LcWdrOWpnd2ZJVWwwQmJQZmpQS0M1eXhG?=
 =?utf-8?B?a1gyLzE2UkpIK0JwMlorbzZjL2F3d0duK2xUdkVXYTZYY1VWM2p4OVN3dXZC?=
 =?utf-8?B?L09MaGdReXY4NEMwZko5T1VvbE9ObXd4UXJnZjNDMk12TWRUTTRNYmQvdXp1?=
 =?utf-8?B?WU44OE1QMFpFNzdHeEVxelZsZklyRVRpc3pBckZDZkZ4bFJRY1lkYUIxOTBx?=
 =?utf-8?B?N0tjMmU3R3Z6aUdUWjY4T2RuaXNLN0NzQWg3Wkk2L1NDUUJQZGc0MFBhaGc5?=
 =?utf-8?Q?pVkvrNh2OlnDOqRE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ca163f-62d9-41b4-083b-08df097caf21
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 05:32:02.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv5XHNHR5a/YksshH4Vu+m4qv5JduMstjFNKhOrflamPIARVGCzG7c29Ley9Dtw50v3bZ4YInv77O50rLP7F+vIgAMfaxVYAd4vhTJmWStE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9609

The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
entry never set .sgmii_port. ksz_has_sgmii_port() is therefore false,
ksz9477_pcs_create() is never called and ksz9477_phylink_mac_select_pcs()
returns NULL for port 7, so a phy-mode = "sgmii" or "1000base-x" link on
that port cannot come up.

Only the KSZ9897S has that port; the KSZ9897R has a second RGMII port
instead. Both report chip ID 0x00989700, so the port cannot be enabled
from the chip ID alone, and enabling it unconditionally breaks the
KSZ9897R badly: ksz9477_setup() propagates the failure of
xpcs_create_pcs_mdiodev() on a part without an XPCS, so the switch as a
whole stops probing.

The variants do differ in the read-only bit 7 of the port 7 XMII control
0 register, which reads one on the KSZ9897S and zero on the KSZ9897R.
Compare the KSZ9897S data sheet DS00002394C section 5.2.4.1 with the
KSZ9897R data sheet DS00002330D section 5.2.3.1.

Read that bit in ksz_switch_detect(), next to the existing KSZ8765 and
KSZ9563 variant detection, and select a KSZ9897S chip_info entry which
is the KSZ9897 one plus .sgmii_port = 7, with port 7 no longer marked as
supporting MII, RMII and RGMII. On the KSZ9897S that port is permanently
an SGMII port and only its differential pairs are brought out, so
advertising the xMII modes on it would let phylink accept a mode the
driver never programs: ksz_phylink_need_config() skips the XMII control
registers for the SGMII port. The KSZ9477, which also has SGMII on port
7, is described the same way. See DS00002394C section 4.11.

KSZ9897S_CHIP_ID only selects that entry and is never read from a
device: the low byte holds the silicon revision, which detection masks
off, so no device can report it.

Device trees describe the KSZ9897 without naming the variant, so accept
a detected KSZ9897S for a device tree naming the KSZ9897. No binding
change is needed and existing device trees keep working, whichever
variant is fitted.

Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7: bit 7 of
the port 7 XMII control 0 register reads one, the switch is identified
as a KSZ9897S and the PCS is created. The port advertises
1000baseX/Full, clause 37 in-band autonegotiation completes against the
link partner, and the link comes up at 1Gbps/full duplex and passes
traffic.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Suggested-by: Jerry Ray <Jerry.Ray@microchip.com>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v4:
- KSZ9897S: stop advertising MII, RMII and RGMII on port 7. On the S
  that port is permanently SGMII with only its differential pairs
  brought out (DS00002394C section 4.11), and
  ksz_phylink_need_config() skips the XMII control registers for the
  SGMII port, so phylink could accept an xMII mode that the driver
  never programs. The KSZ9477, which also has SGMII on port 7, is
  already described this way. v3 inherited the KSZ9897 values, which
  are correct only for the R, whose port 7 is a second RGMII port.
  Flagged by the netdev Sashiko review bot on v3 and then confirmed
  against the data sheet.
- The in-tree LAN9646 entry pairs .sgmii_port = 7 with the same xMII
  advertisement and looks wrong for the same reason; not touched here.
- Link to v3: https://lore.kernel.org/r/20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com

Changes in v3:
- Only enable the SGMII port on the KSZ9897S. v2 enabled it for every
  KSZ9897, which makes a KSZ9897R fail to probe at all, because
  ksz9477_setup() propagates the xpcs_create_pcs_mdiodev() failure on a
  part that has no XPCS. Reported by Nicolai Buchwitz.
- Tell the two variants apart at run time in ksz_switch_detect(), from
  the read-only bit 7 of the port 7 XMII control 0 register, and select
  a KSZ9897S chip_info entry, next to the existing KSZ8765 and KSZ9563
  variant detection. Register suggested by Nicolai Buchwitz and
  confirmed by Jerry Ray against both data sheets.
- Accept a detected KSZ9897S for a device tree naming the KSZ9897, so
  no binding change is needed and existing device trees keep working.
- Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7.
- Link to v2: https://lore.kernel.org/r/20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com

Changes in v2:
- Resend only, no functional change: v1 was dropped when the netdev
  patch queue overflowed.
- Rebased onto current net-next.
- Link to v1: https://lore.kernel.org/r/20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com
---
 drivers/net/dsa/microchip/ksz_common.c      | 60 ++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  5 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..0bc809f582bed3abe50ce50553c7bfaaf4c75ead 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1486,6 +1486,41 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {true, true, true, true, true, true, true},
 	},
 
+	[KSZ9897S] = {
+		.chip_id = KSZ9897S_CHIP_ID,
+		.dev_name = "KSZ9897S",
+		.num_vlans = 4096,
+		.num_alus = 4096,
+		.num_statics = 16,
+		.cpu_ports = 0x7F,	/* can be configured as cpu port */
+		.port_cnt = 7,		/* total physical port count */
+		.port_nirqs = 2,
+		.num_tx_queues = 4,
+		.num_ipms = 8,
+		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 = true,
+		.mib_names = ksz9477_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz9477_regs,
+		.masks = ksz9477_masks,
+		.shifts = ksz9477_shifts,
+		.xmii_ctrl0 = ksz9477_xmii_ctrl0,
+		.xmii_ctrl1 = ksz9477_xmii_ctrl1,
+		.supports_mii	= {false, false, false, false,
+				   false, true, false},
+		.supports_rmii	= {false, false, false, false,
+				   false, true, false},
+		.supports_rgmii = {false, false, false, false,
+				   false, true, false},
+		.internal_phy	= {true, true, true, true,
+				   true, false, false},
+		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
+	},
+
 	[KSZ9893] = {
 		.chip_id = KSZ9893_CHIP_ID,
 		.dev_name = "KSZ9893",
@@ -1852,6 +1887,13 @@ static int ksz_check_device_id(struct ksz_device *dev)
 		expected_chip_id = expected_chip_data->chip_id;
 	}
 
+	/* The KSZ9897S is only told apart from the KSZ9897R at run time, so a
+	 * device tree naming the KSZ9897 matches it as well.
+	 */
+	if (expected_chip_id == KSZ9897_CHIP_ID &&
+	    dev->chip_id == KSZ9897S_CHIP_ID)
+		return 0;
+
 	if (expected_chip_id != dev->chip_id) {
 		dev_err(dev->dev,
 			"Device tree specifies chip %s but found %s, please fix it!\n",
@@ -2966,7 +3008,6 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		switch (id32) {
 		case KSZ9477_CHIP_ID:
 		case KSZ9896_CHIP_ID:
-		case KSZ9897_CHIP_ID:
 		case KSZ9567_CHIP_ID:
 		case KSZ8567_CHIP_ID:
 		case LAN9370_CHIP_ID:
@@ -2979,6 +3020,23 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			if (dev->chip_id != LAN9646_CHIP_ID)
 				dev->chip_id = id32;
 			break;
+		case KSZ9897_CHIP_ID:
+			/* Only the KSZ9897S has an SGMII port 7; the KSZ9897R
+			 * has a second RGMII port instead. See the KSZ9897S
+			 * data sheet DS00002394C section 5.2.4.1 and the
+			 * KSZ9897R data sheet DS00002330D section 5.2.3.1.
+			 */
+			ret = ksz_read8(dev, KSZ9897_REG_PORT7_XMII_CTRL_0,
+					&id4);
+			if (ret)
+				return ret;
+
+			if (id4 & KSZ9897_PORT7_SGMII_SEL)
+				dev->chip_id = KSZ9897S_CHIP_ID;
+			else
+				dev->chip_id = KSZ9897_CHIP_ID;
+
+			break;
 		case KSZ9893_CHIP_ID:
 			ret = ksz_read8(dev, REG_CHIP_ID4,
 					&id4);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c371ee22b80f9508c3b35b8d6291a..0cff33df06a4b8ca585d94f9fe437ad62bcd82dc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -284,6 +284,7 @@ enum ksz_model {
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
+	KSZ9897S,
 	KSZ9893,
 	KSZ9563,
 	KSZ9567,
@@ -874,6 +875,10 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define SKU_ID_KSZ8563			0x3c
 #define SKU_ID_KSZ9563			0x1c
 
+/* KSZ9897 specific register: port 7 XMII control 0 */
+#define KSZ9897_REG_PORT7_XMII_CTRL_0	0x7300
+#define KSZ9897_PORT7_SGMII_SEL		BIT(7)
+
 /* Driver set switch broadcast storm protection at 10% rate. */
 #define BROADCAST_STORM_PROT_RATE	10
 
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 028781ad40593248bae1b501e40ce31c5e0c69ca..fe8df1774289c401445ef308c8d3656e1e7c25b6 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -34,6 +34,7 @@ enum ksz_chip_id {
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
 	KSZ9897_CHIP_ID = 0x00989700,
+	KSZ9897S_CHIP_ID = 0x00989701,
 	KSZ9893_CHIP_ID = 0x00989300,
 	KSZ9563_CHIP_ID = 0x00956300,
 	KSZ8567_CHIP_ID = 0x00856700,

---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260703-ksz9897-sgmii-port-48ddb100e015

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

