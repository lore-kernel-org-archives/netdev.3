Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010019.outbound.protection.outlook.com [52.103.23.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B231282F;
	Fri, 17 Jul 2026 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259588; cv=fail; b=mtAvwRusAcbXSR7F8O68dtLssnnkkoE1OZxAJHaaVgwILRfzJGoH0UpY23UVf4dr6dxRNkmhebLjV7LS3/8QyuOYJzq6elFzWpvJWw9sQPEkkERHFrLa//MWqh5n/cvJTyW+jt7nJYQawKKOpN7qnGThdwHl+GFMb1DsoOGqvp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259588; c=relaxed/simple;
	bh=AWtg4bvl/muL+Qu3kkKuTYZj9jCTzNRhePDnvDx4dZU=;
	h=From:Date:Message-ID:To:Cc:Subject:Content-Type:MIME-Version; b=R04AJZlwru/QofNTHm3rWzJZkYqUo50l4uHZeYseOex7k6vPsxnU8UlA/JvltBcjV8kufdUxC0NsbdGi2IuvR9P824VVFH4h5R2sl1n3XmRGpxwBvJMwFXlLv03jflgdoME/+DcNdIjalJofALSS8AuME4fgkEfTla6/FhmW5RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AYcA6L+F; arc=fail smtp.client-ip=52.103.23.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AYcA6L+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfWzEV7pN/TkRPDdygBM4Mkq0WIa4rvqOVxbA1iG0KkWYG7voFIFzxWkcTGt8PVKQoxsLtdoFKpXFzB2dms2ir084o6VGYtoaiwbEDYn6X8aQR3tK+5IxZcm8JUNAS2AwCBKCqRHJJIkUKW7hkb/vV4ZbOLrmKhkZItHwfYTfwB0sw3YOISfvEYrbMCIRWxySHThaPTVVikxcfnlylk8+TvdIeuCuNxdGrcZ+WuttfFt5sn6ma7WtBczlZIUzlx9fSmx18YuwJBnGTtgk7SUk51l8XTjfP2cVJWSJnxAANVIjfr4yrv5hnSzt/euYEF+s6Nv4Oq9q1VmbRxfqwpluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdzlxpqPEplgm7l+AMfY5d20NgulUPCOV5cl4x95U6o=;
 b=D2vGYtfZ2vlu3mTEg/GGE4sxd1tcQHWBn4qTgqadBdWwdoyT7NxJmkxdOs8hgnmFAbIpG62aO/eeIPGtGzGvcJ86FBCQgX/RYbc7G4aDAdtYEbbG2iNuTZJx8SC/kNRnAZuYeI/qtJcAgfGrrCyS25B4L2n/hpbzQRA5W5z6dQtTi9rkZzXSfdpSLO3hm+8nirr4sO6Dv/EITTd02+aDUEFzONdjd+ezWCa4pVeXr/q3oOq4689VIyGNL/suoh2cd8i+d+N34OfsIU7NGFhzikKk+Lj2N5IotFpbpqfEdppFFRYZdAi483V+RN7xzrERzIsEJ9hXLQsrTP16nZ0weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdzlxpqPEplgm7l+AMfY5d20NgulUPCOV5cl4x95U6o=;
 b=AYcA6L+FIRzu8+bGLLrJcmk2biItCgZkrGCyxZ5cyokeSSFNAzMFoPhdo+J336+LmxlKwqkov0UQ+X9d8lIZkvZL+Sev7do73/Vva/a5YQph1Qi4nL9WoWfMpPMuaQM7ljiIY8rUTJ7eE0h24+OUoWgcEmMK4C++GVxgRHc8y4Kp0VvHMX87P4Ybi2sqiohb4T0+haRQqWlJv/zCrqKKfWCW8ZByOkl5QFO2PxU0ljpRBu1yfoUWRUuSbE4++20S7fwc8BtXSwB0afj/+I78k6iWMu8C+mH4DE7CJkL5Z442t68kUCZWMSTMikPLiy/wg1eEkCrgdfRK0TYjmzyOSQ==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by DSWPR19MB796710.namprd19.prod.outlook.com (2603:10b6:8:3b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:39:42 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:39:42 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Fri, 17 Jul 2026 11:39:32 +0800
Message-ID:
 <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: phy: Add Maxio MAE0621A support
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To MN0PR19MB6091.namprd19.prod.outlook.com
 (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <b22b41e5e8b0405e940d7dd217bfc7c0.1784259572975886.tspi3m-maxio-v2-cover@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|DSWPR19MB796710:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a0cbb8-c239-4796-4122-08dee3b50959
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|25010399006|23021999003|5072599009|37011999003|12121999013|51005399006|8060799015|15080799012|41001999006|19110799012|24021099003|5062599005|26104999009|4302099013|440099028|3412199025|40105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XBRcs2KFkmBmPCpWK3U8c7FvEslewb34nkz+N+AJ2/ep5MO49RE61IsNYxU?=
 =?us-ascii?Q?o78SkVBMssZkf74iJ0lfxWZtJoOj/onL4sr8ynlDvqvB1dmYyNH8r17/+oe7?=
 =?us-ascii?Q?qMcj5zYlTxWRxYW/U7o6BXBc2OhvmLMxVW8VVnNK3o9LOiORbJeESfwA4M5j?=
 =?us-ascii?Q?aQwaTcND7fYuJ9pSgw+HtxlJhzb20hQyGPfJXqbwocgqElcm1rK5iQca7PJp?=
 =?us-ascii?Q?dIcH+vk04qeD28ky5QSno0lwvBNar2V1BjX8TTN05K4oa9EADipOxAOCA/xs?=
 =?us-ascii?Q?HCBYabXSoWiSWOOyh+2xQAfzlf+2Vx9p8Yp0lX7EbdPeavKq5rU+tiRhNMHJ?=
 =?us-ascii?Q?MeC8FrKU9emtTppce5PP6v7otlFyvdzzLb+7p0S2LLPgr/o7JPXxJL6EGlEO?=
 =?us-ascii?Q?QF1FUxEr6BazLj70rNtdDdwD7sfQ/fs8oTA6Nkkjt9WENQF88zOVxPxVVGRr?=
 =?us-ascii?Q?vzhBA+0I8Nc/B8bzxM8jKts6dXNfRZis8ftea5vDeh/Yqa/+mKoEwCLPqhXB?=
 =?us-ascii?Q?U2O8UCi/50YlGd2dsCUZIXIGxGpgV3DAaLQEvcv0y0LyWQD2bslZGDeBbKG5?=
 =?us-ascii?Q?z6I7xsOZYH4TmITENVAdCOY6cAPmKJ1Lrlu4aTsjRXaN+0GpJ6yI7kCNT11M?=
 =?us-ascii?Q?YhoOEN12HIR0wd+iTlqzV8vyFL1bBzbPHJ1b7oJal+gasQtdmggBQ+N/q4gm?=
 =?us-ascii?Q?88fAUdtsxFJPJEbFVC/7zX2iUiiiHDm6jmzINJ495/xmOB3mmpG+hapz9Koo?=
 =?us-ascii?Q?VL02Ui8xnasSsUjfW9xlKW2736GJypZn7gOPY6D9Mse2ktQwsNKO1NC4aA82?=
 =?us-ascii?Q?9HOR4sNeU00CvGfHw/NPgjFCLEpnLcqLzRgV1YxmbuijccmuVtjxdhmmnIZ6?=
 =?us-ascii?Q?ZK58g6jnkfbCDLppSzP9u9ybJv/SABclnEhoiseBX6USIsFLcNKZeuviiIfa?=
 =?us-ascii?Q?FTfHbB9gjjrnaY3kiuQSsR/NeeJn2/0qynpUf3Ny7oiKR6/T+buOAYNMwal8?=
 =?us-ascii?Q?d2IOrBV4/CQYKJIo/3z58FZ4XmmUXlMTRObemM+YsjKQ2sXSXU0MM10D+9Q+?=
 =?us-ascii?Q?L+m3CmtA1wnM5AJRWCNHB4AFGzgVuzRK1Lpqq8aBaaBsuzNsv0QTg15so09t?=
 =?us-ascii?Q?1ExKLP2nABlK2vviQUGTiGbDmowRG1THsA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDd0B512DMvtY4jqI3okeGzZD7w9t4of1OipZ/Skqwb4VMsZ+0wosVnogeL2?=
 =?us-ascii?Q?RfVJ9hpzMcMoIs8ez1GVTXCMWHQa196IgZrZQrvgyavwXP0MeLErttP/OZOB?=
 =?us-ascii?Q?MRPj5pT+7kMdLHzykcZGUTsQWz/5cDUjYaupXVrDkPBlIXqgVYLm/fJW9bH5?=
 =?us-ascii?Q?8YOKojJqrkmpG42Wyc3Mf3PG/mo9t0YPYYxHuz8JYBLF68hLHF7UVv3S2cQC?=
 =?us-ascii?Q?LmauMv2e+8AySy8ElmkeW/lp/zzTpxtkNtaBVLAYJOJBsWsB5Y5LzX/h+I/f?=
 =?us-ascii?Q?NsOEWf5nSUvz56Rsjpz+5fLYtOa6GOdX6S8kJugMFmhonzV1x/iPyo229gSB?=
 =?us-ascii?Q?mUoQFO/djMD2RCEoBIh6cqmtQVciULaeelLwB2IJmQjbqniWoEW2qLpRRKwq?=
 =?us-ascii?Q?qXKB5kZ5AKoxTxSVzj520j9bqpGOSiCR+UO4r9oDWop4FuteH7ABNgVoIig1?=
 =?us-ascii?Q?d8iaPEOK9uFwSKl7mHVVIucguaVqWqigEX7+VrwhvZ0D6dxE0JGNk3rQ2ALj?=
 =?us-ascii?Q?pexfnbVsoAl0WzX3i58NBL4XDfu1wZc/TuNIToPGYlNfmWIWgNzPbVkEJEGd?=
 =?us-ascii?Q?xqnnu3ztF7b/FBVpoGM9Z8q7OwbqS0YdgAAWIO4qHaBLtVVareFAACKC2RWx?=
 =?us-ascii?Q?SxcauqPYzwLWlWBlPk4vIkAJXLMg4yGyMG2EkThpqkiGj1kt4tdiYvlPSbrQ?=
 =?us-ascii?Q?50lm6wOdhsAe9GGkQ6I3eTkQQBl96Q4B9d6li/X6ThvnxTXCIteghJhvyqtN?=
 =?us-ascii?Q?UMepSbcj9lqD7XMiEs9uV0D85cVjB+BfBH12LqeDuf1Pby8o1sRA71beiPak?=
 =?us-ascii?Q?3+3kYZ04CT5LAFPBl3zp9u5FGFfduZzIQ+3biQZSFOUmmSvPUhj8emSEt4A1?=
 =?us-ascii?Q?ozh7BWxQWlGgiS0qgpTdrdpZMIcRRjRF8z9Cdn1odmxzay+5bFAbAzR1o9J7?=
 =?us-ascii?Q?O/adGHf+twrELLO3Cd3vuLFu8834jVncwl8++qnT/2y2r+b0b2z0hx6e1y//?=
 =?us-ascii?Q?MWbUH+0Q1rEkebSDiAXMAURCm4LsBt7s9FyHSM/znpGfguNi3oABq5brIo+e?=
 =?us-ascii?Q?38E4yH9Vv6nn7bm8GoarahaXYtaw43e9O1Zy9jC/Or6IUmwSFHCn/bF8rwRT?=
 =?us-ascii?Q?ENkGfqkmc+N7GJsXubg4fyX+Y+LquSerR3RojX1GZXYb7xIC9DewRYbOC++d?=
 =?us-ascii?Q?jBB9rmu/HqJbwfMw3jH2BJLw4TTs0MxxU+59X4FivesGKWpa3XctnlyHgDvB?=
 =?us-ascii?Q?J0G5101OsP3qslAstpSKd4LWqHSzKVgVD4WvhqZlhKa5KWXScIRtGc8pWIrd?=
 =?us-ascii?Q?v2I5OYGt/8PdwXdFmCdqx94qA01QmpZ4zqUvXoNHkChntgTiHK9Fm6BKGnhV?=
 =?us-ascii?Q?V6MRrJav+9kSnoA61iy4Z/CTjUL3gxyc1XoOJD0UNWko/lvRJw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a0cbb8-c239-4796-4122-08dee3b50959
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:39:42.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR19MB796710

Add a binding and PHY driver for the Maxio MAE0621A Gigabit Ethernet
PHY. The driver matches the exact PHY ID and optionally selects a
125 MHz clock on CLKOUT. When the property is absent, the driver
preserves the hardware strap or bootloader setting.

This was tested on the LCKFB Taishan Pi 3M. With the PHY's default
CLKOUT configuration, the RK3576 GMAC negotiated a 1 Gbit/s link but
the data path did not work. A read-modify-write of page 0xa43,
register 0x19, setting bits 0 and 11 produced a readback value of
0x0823 and restored the data path without changing the RGMII delays.
The readback also confirmed that the unrelated set bits were
preserved.

Only the 125 MHz setting has been exercised on hardware and only that
value is exposed by this series. The 0 and 25 MHz choices from the
initial draft have been removed.

Public documentation for the MAE0621A register is not available. The
exact definitions of page 0xa43, register 0x19 bits 0 and 11, their
reset defaults, and whether a soft reset is required after changing
them still need confirmation from Maxio. The register programming in
this series is therefore supported by the hardware A/B result, not by
a public datasheet citation.

Hardware tests with the 125 MHz setting:
- all supported 10/100/1000 Mbit/s link modes
- 100 ICMP packets in each direction with no loss
- 936/934 Mbit/s host-to-board iperf3, no retransmits
- 943/941 Mbit/s board-to-host iperf3, no retransmits
- link unplug/replug and a normal reboot, followed by another 100 ICMP
  packets in each direction with no loss
- no RX errors, missed packets, carrier errors or collisions

Static tests on net-next commit f6f3b36c15ed:
- dt_binding_check with dtschema 2026.6
- W=1 arm64 defconfig build of drivers/net/phy/maxio.o with GCC 10.3
- W=1 arm64 allmodconfig build of drivers/net/phy/maxio.o with GCC 10.3
- git diff --check and checkpatch.pl

Changes in v2:
- Extend hardware validation to all supported 10/100/1000 Mbit/s link
  modes.
- Keep the binding limited to the tested 125 MHz setting. CLKOUT-disable
  support can be added later after its register behavior is documented
  and tested.
- No binding or driver code changes.

Link: https://lore.kernel.org/r/MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com [v1]

Liu Changjie (2):
  dt-bindings: net: Add Maxio MAE0621A PHY
  net: phy: Add support for the Maxio MAE0621A

 .../bindings/net/maxio,mae0621a.yaml          |  38 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/phy/Kconfig                       |   8 ++
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/maxio.c                       | 103 ++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
 create mode 100644 drivers/net/phy/maxio.c


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.55.0
