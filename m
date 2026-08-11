Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023079.outbound.protection.outlook.com [40.107.159.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E943B6D2;
	Tue, 11 Aug 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443658; cv=fail; b=OGka80bSoAMQO5h04Wyz34uyyV4oouD3f4GhDBCmlFesTEOYDVBBu/y4ERZ9tVkgdbgiMa/6s0x3py1WPmcfeucHRtZ/8scb1wougV+eDvqAAVGGtI1+DWoy/ThCKB4+aVIvJcG18VSf6tP2NaKokBu/lOecYUOmz5U/fP4Xcb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443658; c=relaxed/simple;
	bh=0isHuBaCY/ko1veUOxG1E4d3gGRufWFuqx7w/UVhuig=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=FagYHkO2CuSbGIeCKE585rWUqnC4aBnzUkWULoj3lhFbX9Sicf4FSCwksDKCPvCAsRhSk9uLq8UPoQcCDm6X+iCH1osFL2PZ9F3jsL7zhJBXh6/M17vI9SDAneUCCqQnCA38XZpfJz4O046kUObyJyZBP9+QAFSsEQqCBR9tzFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=HuxHjSG8; arc=fail smtp.client-ip=40.107.159.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="HuxHjSG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvnxLGPNveFp3KljY5HqkMzx0Ojb1+8ghtOjalR0WA8FuPKsPKLp/1T7uOVIpDplGmLp80fU+TMhnBSbGGBWF9iwnukNMZIvlJ0jyw3BSm/JjOHxiu+yhHar/95XnNnLp9N3rIldXhOW0yqcBxLclphmOoZNMBAkEUDg8iOSnyuMxbie45bVg0t8oocWimsMRXpgjD1+wRWl5Kkwtb5NtTg1GfMAFSjDJMPQqvv7x1F01StuB2X1pPqT/KZfdCAGYVt25Q7zWoYCP6lN5fFm1sah0HFA+lBESqrWzX4C72sAngBGBbEmDsUzDhQSbwvr+RroQ809LurvYVRPWHeSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8LGXIBL9ZOw0JALU2BBQdpTEFmlHIxRgpqR+OzGm1E=;
 b=TwREJtf/U+U8gfRfQV3zrcBQ8xWtu02qgIWYF98VPdG4IdVwJ/laggzO01pA+sIqvwPQNL0vXrQYkmWEUrzIG03ZROp6SCFfp3wrb3g6WgAnRWMhVruXNAz0+/Wd0OAb0dyfyQxhU1pXmPmHMSjfmrqaDQA4gNRALCJzDbPYJcdtodGpTYxfAIJiq9p5Q1Da+SOjpVInWGJCaQw0HR3ZXeMKcH/gDYMFh0xS7wAGe9K/zAbv7+bsvYMcHZ53iZ12t4P9YrJdWWycT036TJW1L9WFjjAC9RZnfnriYVT2DOSE4Gs7KbJeae8sCqt5Vtc60w8SxzGHi6ghCEzBr96MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8LGXIBL9ZOw0JALU2BBQdpTEFmlHIxRgpqR+OzGm1E=;
 b=HuxHjSG8npIYytU70dh8oBhOo/pfXqiI1dAZVj+g0ozqBwbUWs3s1LYTc0LRwtxW2hdTeC5DdP9qkdo4KKQR5KxaQiu/1iBXGafd6bxwd0tmgiN5gEOmPIO+n92m4YweVvMuj3+0u6g9Kq16H2bRWb22ioYQOpQTwQ4CVXKfGgJDjw84KRcTSlDpyFbbRVApX4PPTreCyDfp7xQm05vVrW0+iOE+qOGctOZRZIb8dKcYkGZ4YoDiWXfErKmec7rMTg/wKblq3eYdXb2tnTyovX2QQywvLCK7wbmQMETCWe+XuKV+Qwwmi1Cjry/JC1cIr8hTPyGlS8RWR01fEA7NLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DU4PR06MB10453.eurprd06.prod.outlook.com (2603:10a6:10:617::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:20:40 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:20:40 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 11 Aug 2026 10:20:32 +0000
Subject: [PATCH net-next v2] net: dsa: microchip: enable SGMII port for
 KSZ9897
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAG/3emoC/32NQQ6CMBBFr0Jm7Zi2KAVX3sOwKHSEidKStiEo4
 e42HMDly8t/f4NIgSnCrdgg0MKRvcugTgX0o3EDIdvMoISqhBYlvuK3qRuNcZiYcfYh4aW2tpN
 CkJBXyMM50JPXI/oARwkdrQnabEaOyYfP8bbIw/8LLxIllrUmXZXKWtHdF8PRvM259xO0+77/A
 NJQMF/AAAAA
X-Change-ID: 20260703-ksz9897-sgmii-port-48ddb100e015
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443639; l=1990;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=0isHuBaCY/ko1veUOxG1E4d3gGRufWFuqx7w/UVhuig=;
 b=BACBaEKI+HfdBOQ0AS+XxHVjLP4MK2+BmCQ+EuJbv8SZb3QO6UiKaQPFU5CEwPz4uHiqXUqQ5
 DRtVeCrLr9uDjYgBRSroaXF7CSQH3eBvhQ+PxcL/Msjo2yWoHhgHgdk
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::11) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DU4PR06MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef56674-f886-4207-e234-08def79231a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|52116014|1800799024|38350700014|5023799004|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y9IxAhAeLMTuNIfE0SmoYl41jJGMf8MHuBCQF72/fmppKUinDR7ihlYTZcnMHbLyYnQRcQdBP2Y87n7FQQVNO+Ir6NE5x9bhYKXM9/FsO8DGbU9sNaIxdENDnNy1SAK0Fw3J8bkKBD+3hObxMoQVGcF0GbWPSwYxGLtRHkVgU1A9o3EkVG7uBl0WOoLfH+t3TzV2ZL6t/44u1DyT12RyCf/O8hFull3AmqYatdiv8BbD7+QsE4cvHOIVt5XjWRMxKCbaJnO1Fp7QBi2IRSIHQmace0PhAjcIxGL1kk3o6JWU3dmclE+fvGrI+H4Yk/G21AkdUwxmBm2CPCI2FS4me40ouQ0auTc96uCHL6j3zS91u9y3rtnk0WmG5E+4+FIKs6luZG2MRKiqMchg4epPuX6j8CkiGU/gTudy+cq4OSYnTDEX87rcamMsxmBTIcbNfwaX3+WqD4nIjT1zZdhoRaFxXvfh2esTkDkJidvmMG/jmRnjX136IHLqcW8kP294nhMA50heCeSLvLhyiDjBc82IBx7SVV8qMBTCT4X5+qRyqxQbFe7nlXUdXR1jgyMxM2qjb2AASaph6MRyvfVxIYeHGfWGFs9yZ+2CROhum29+CoEp1TIkiDsni9Ne+Pn6zc+ZfecD66Y59yMahwwdhTS+i97KvYn/1qs4MdPb76J0Hi9cr0oC7rjSlgfjantkrziRjyhw17jCd+A7zFtA9dBFxxyL990yDpsQB98/QLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xINWVDNnRuV1lzcCt0dmE2a0F0NXEwUmFYY2FrWHMvaEJZRjhxWGdUaEJq?=
 =?utf-8?B?N1AyaXkvMnhyMUhVaE5sZkp1ODhsZjEyK0VxSzd4bFFQK244TGxjVkN4YTRW?=
 =?utf-8?B?S0E4ZnBVUnBOQnFuRm1renFMYWxyWTVaYTFOZlpDMFZwTW42cExjL1lsNUlp?=
 =?utf-8?B?L2NzMGRQQkd1T2IrdTJxb3ZKQXo0dllTYWRkem4wY3lVdGN2N2N0dmJKV21N?=
 =?utf-8?B?d203UjBldmdDdzNNNmwxYXhKK2k2Tjlqb3hVMDhQb1p6QWNkSHJrK2JFZW80?=
 =?utf-8?B?N1NlQlFaZ1lEdzYvOStLdTVHelpTR2E3S3VlaGhrMllyNzJTZEdmUFhiOXFh?=
 =?utf-8?B?bEwyb1ZYZUhtM3liblBQaXBHNlhmWStIVjJ4WStBcXUyQWVvcm5MRVU4OU12?=
 =?utf-8?B?MEt4OXVQcnIvU2hEZFFJMDNLZXJBWlQ2V2grVStJVkJRQzFZRWZremovWDhj?=
 =?utf-8?B?ZjZ4OVZJMDNtRnY2SUJLT2UyRkwwMnBvKy9RSDRobVFKMGlBQ1pUZ1pINjlG?=
 =?utf-8?B?TWNUVG1BdVJIQVorc0c4OEhzcHQ2YUdyQ3c3b3JUNlp0cFVSUG9xNVZVeDJV?=
 =?utf-8?B?TUNyNlo3TnRZZUlBcWcwQ2JBditXRDB1eGpuRW1wekNheVN5MGNRZ0hSMnVE?=
 =?utf-8?B?NWIrWm9XTktGUFZvTFRKczZqNlBQQkpYZG9OS2pBdjI5SHQ3bitPc1V2N09N?=
 =?utf-8?B?Y1VoWkpidEJmVkYvRVNvOUxIWlJVVmF0WHRkdGJmQndHdlNoTS9QMmtTYkFa?=
 =?utf-8?B?aURHcmZ6aStBd3pQaTIvNlcyRnU1N2VzbFBaWUI1d2RVQlJSTXJWejdsN0xR?=
 =?utf-8?B?OThaWEJtSWY5YVlXMEwwSWZGbzdrYjBJWi9TUUZ1S0tVb3R6enh5dlFwT1NH?=
 =?utf-8?B?YUpINDMzMlB2eXRqSzUzbXRhdElDK3hZNUFJVXdBZ2lFbHV2a1VvUTRvMVFw?=
 =?utf-8?B?N1pGc1BRWFVXc3pXb3ZhZFBhZmFrZTltL0RoV2w3Sm1mMTVrZk9qdzl4SjIy?=
 =?utf-8?B?TVgyRm45NjNmODFRaVZPKzUvcFpYL2krcVVKSitXT0NzbU5nWnhFYUFCZmNx?=
 =?utf-8?B?bEVTeExlaTJBZkh1Q243R01uRkdReWlvVWxDWVJ0cVFwQm1aVjJSR3JZR1ln?=
 =?utf-8?B?bCtHbmx2bThKSGNrY1Jucm12bEwzaW82NUxkRjFWeFdOQTRKT0lSdTNYeTNE?=
 =?utf-8?B?czY5b2V0L2M5dHBudU1udDBwNVdwWUpEZ25HTzRUZ25WN2FFTm5PdGNDcjFr?=
 =?utf-8?B?eVRvME53eks3Z2NNY2tJNlgrMVE5d0JjMk0yWHdGeWg2bDJnWnlIU3ZBcjFk?=
 =?utf-8?B?UXg5NjZmU0xhcDdYSGFWMHhwWDVDL0ZIOE9tUzBDMVJHeE1QWTRKMjNaK1dy?=
 =?utf-8?B?ZFBWbVVEU2k2NXpTSE84WXNQQVNwZlE5V2pSbEt2KzRMZHpaMnIzRGdXQTBY?=
 =?utf-8?B?OEE4R3BQL2E4VUNiM281T0hFL25BMTFycG45QlhEY3M3SmxrSmZhQk1pdlVs?=
 =?utf-8?B?dUdmSVkyUEd4eURnSlBGQ3hVR0M4SjBQMzk4UXZqMWd2QTFnSmU0Z2dKQVlp?=
 =?utf-8?B?SG5YK213NER0WFhvRStWdzdBZjhGL1RQZkkyRDU5Z0gyRjFiQjRPc0UrTVAz?=
 =?utf-8?B?WklPVzljTWdqb3ZQM2ZpSHBvdFBSeG04aThEN2hxLzJmVWI5dHpjaDhpUnFB?=
 =?utf-8?B?a25IQzZFM1JzS3RERkpQdmVyWENjdUl0SGgxbE9tZHd2NCtIWkVoaGoxV2FK?=
 =?utf-8?B?dnBBODkvMWkxem1NZHdmeXYydEVNTmE2dkZ0YmRIRHgwTjlsUWpEdEtiMlV0?=
 =?utf-8?B?eXhIYVg4eUpselArbU9xVDFWSVYwai9CYmgyY0RVZ1pTQXkwdW12VzRXdWJo?=
 =?utf-8?B?cStxRDBWK1JRT05FWUZBREJDZUhwTHRPYTdUR0MvRE81elJJaTJwWjBiRXBw?=
 =?utf-8?B?cFJSdC9QVGFobCtWNUE4UlZaWlE2YjRvNWhtNWRzTGxmQ0ZyTWhaVXV5M2pl?=
 =?utf-8?B?d3p1dGF1YlJHaHpMSU1yZ0FXRERaNkFiVVkvUnpIQmJ1RDVjRFUxdStCdDdR?=
 =?utf-8?B?dm12cUtSWlZOYTYxSzlDMnNUVGJlcTE2VFFENlFoOVVJTDZBRlhUTGxmRlJM?=
 =?utf-8?B?L2loNjdGM0pXU0FLVXVoc25EZHI2d0hjQzlvN09YQm9oYnc0cTRSMVRscnE1?=
 =?utf-8?B?b0lzUFE3SGw0V3pGLzBFem1YUmhzMEZhQ3ZrWGZWNXhyRWJrNy9nS0RFYU9C?=
 =?utf-8?B?UFIzbkRXN1YzMld2V2hMMlNBKzc5WGpkZGxPRjZCMCswd25tNWJqeEIyNlI0?=
 =?utf-8?B?c25WYjQ1UVV4dVpwUEkvMis4aVFFM2FOQzlvVmNKRHNJN3lUMFVwR1UvRGU5?=
 =?utf-8?Q?icUa/94IAudHFNNc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef56674-f886-4207-e234-08def79231a9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:20:40.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JSMIuoSM/Cb/NnxWajtSyhpHayWY1cECAnnsGvVdo0I2AcO5BaWDyM1nIbXOzHn96xs3xmiLv4wMHdzsMzSwT2rDVCbYI4aXst+4VrXocY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10453

The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
entry never set .sgmii_port. As a result ksz_has_sgmii_port() is false,
ksz9477_pcs_create() is never called, and ksz9477_phylink_mac_select_pcs()
returns NULL for port 7, so no PCS is ever instantiated and a
phy-mode = "sgmii" or "1000base-x" link on that port cannot come up.

The KSZ9897 shares the KSZ9477 register layout and operations
(ksz9477_dev_ops, ksz9477_regs) and reaches its port-7 PCS through the
same SPI-indirect XPCS register window. The register-identical LAN9646
already enables this via .sgmii_port = 7. Set the same for the KSZ9897
so the XPCS instance is created and 1000BASE-X / SGMII links on port 7
negotiate correctly.

Tested on a KSZ9897 with a 1000BASE-X fibre SFP wired directly to
port 7: the link negotiates at 1Gbps/full duplex and passes traffic.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- Resend only, no functional change: v1 was dropped when the netdev
  patch queue overflowed.
- Rebased onto current net-next.
- Link to v1: https://lore.kernel.org/r/20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com
---
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..a80fde0a8c7e93ea2db4baeb2f941a260e23b687 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1484,6 +1484,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
 	},
 
 	[KSZ9893] = {

---
base-commit: b54074ffb813aa4b97585d97ae1ead69d96432b5
change-id: 20260703-ksz9897-sgmii-port-48ddb100e015

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

