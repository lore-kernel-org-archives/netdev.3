Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571293EAC75;
	Thu, 15 Oct 2026 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061768; cv=fail; b=TSXWE8JzcI6qECPWmH1jy6m+G2ZigoseK6Qv82l+CO8kLbJd9HeMeg+xV7thdwmCxHdrX49Yr9iL56+qK1oq4woEEynQETioG24hKHEKsBpZH4oz7X56KGNAYZlZVWoYyw8ryoC0rHp33j3/oGskeSBoLitKpuPWjPlqSTcsCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061768; c=relaxed/simple;
	bh=Ov8I0h4vx4rVPEvDJYC3n1Otrsvb450QQwY7j9n8YSc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GKsJmKZxJJFBPS1dprLxstZd8awmhdh0MsLEob1HgB3Muf3V2Pk/dyMAzQPhahOCnWtWBuhebXapY+RxMHkEDtH2wfs93Nrc0DeNMwTnNHT3npwpbvEXRD9sxhixrvu4rsOaiCbdAs+Pmhu2+DU1LlIcfDL/xdF5fZsTKajqfFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3ohCAVJ; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3ohCAVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFJrUY0iRjpuv0z0XVyyat/GH0jURob/NAwb7/ybaKCwe3fy7l6EnNLoaIQFjWZ1UwmAP4eW0fcLhnbx0oQFjDr3hmWeTIYOAkp/6EljKk+i13QCLNRZrirYQ0y9g81Ihcoj/rm3xIpkCYxgSuf07z0iZ+tfWelMz+QMjfbs4gbtu+T8q0e2eaaBOPCBTEQ1+m65jj1myvYuRXVAmjWSp6OOa/XMgKwmXD2xXmcV9yXZ7Olna1VRXQhW70bkeuBOZRoH7QtOlsGiKeBYzumqVCrur1HK8EHYlhSNwE8dusGrHSN8AciRUAdBrtlARVf3NrO6nflpBMZt+FRahjlhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiw8SyCWOT3RpZkPActw4B+XAG07Kpd3PrDtcozaohc=;
 b=pUkObMGcC4hslbbCo81XVEZTyUJ0vGf155SZ+e0QzsbcaQ8ZtyWrj5oruuy9GlUsrlQLXLFdWpLf8Gv/0ly8o5UAdM0OufbhUbURfISwhg3SVhoKiFwhCHNW1s3Qw7coIkoq+qeU/WHMfmMCC3aGC5cwpPDGnQNamMHH4IFm5bwh3yD0HzXGTWzi8QF9ErL562QFZZbu4Nb+jgYzAvoU58H4T6+n5WLFpRrK8EpyHWlqd02uxGE+Fa4wfjDhg6ejKszDaTksXQsL4ymMbJ2UHVK2hlM4tHQ8INGUQv/DT1qiddxMZprOzULEbHDgA5Qq4wziyWZEPmiOcALgmy9OTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiw8SyCWOT3RpZkPActw4B+XAG07Kpd3PrDtcozaohc=;
 b=T3ohCAVJZF+elTqlwNswwbcJ5eGrmD4lXVqciYZv9DUA9H39Y+z6fkNLOHCxT2jgsLbNSaByJzvQpTiCOa1TnLbs0Qrkx6dC4dvciQGIEt/oCBHMSrmX4DJjpFjPFWVutFxJwC5U9HkVlpXfD9xuRGQ4R5sksBGxFr/TQakiLlr5WuxI1131eQ8D7flhjzgcvDo1Vr1YjrOt/vp2O17xIwgntKmHfWpUX5pQOj+Th5cgK5kMud/aVZ3v2tzEeRcugAIkxlpyME51X0rUGYHo3ZXt2OG32hkRmC8Nu083p9dbmoWCAitYGIAe8MKj28XXCz6rXg71S28/9z7wxyG6+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:01 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:01 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net 0/8] Fix short frame transmission in enetc
Date: Thu, 15 Oct 2026 13:55:28 +0300
Message-ID: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::26) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a16c1e4-28a2-4217-8554-08df2aaae695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	JRWrjKCMOZ4fhAhMoz3caIlz6gvL8uRQCByGoHgeElrmKB447xFswAW4UK+QoMvo2C5YemCtc9QIT4xkz+TQ2NUzUZbIFfPTgjZSmNcMrKyrxuChPF3nHN1VfccIc1kNEy4m2+Ygn9+g1L8UYbv0/IHgOQ3/hoz4DOg26Hlbzdd78m4kOIOCeK1aeJOvUf7T9Kok8nSM1jUhacx0Ma9OhB+FWzt5yn2kKzbov9r3KAW1MR2dCzS4z8B/OTxzBPhN23RW/WKHcpTj1e5J2pHVUFHZ19e4k6BM1zrKCX7UjN3G8OfRGWJmB40jgrfJCVq5HlfHcOG19V1/NkMOCSSP6N1PpN6VQS42mCiWh6jwFlv/QAsVz+Ng5zblIff21x6RyCFud2WTOOpYG0Zxr143+ul1UQI1mF5Jjv6MoO3iOCbaAiq1ait0/pW6QKuIEgEeTOGxQTSYMp/0b5FpNyrDZ0vEoQo/FwCxIadlmLhnY7Mf6+OiQgx8SpTroa7HAnO4Er4d893R0A9Io709iKt9upmOBHJTs/y4OXrObD1MUGdjJSg4vrdwK+Y6keneKSpH1ifHQCJlzKfaKq8Ew6C8cJCUM2pOvfHHfCrGZYqK7VXD6FU27pXSjtRIWz23mmo1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFTrRG/Ybog1GIuke1fXQjx62sdI16+sWsb/pv6lVRPI/5V/Nq9Q/xDqpFNL?=
 =?us-ascii?Q?GSRuqZqGcfVYDjLeswuMYub9kG9VVTlmVNqmt6bTHb/WtJGBKQn7cAGAh1nX?=
 =?us-ascii?Q?d1bQ5EWQdqf8SUFSWEytAl8i7W+qkKudhLqf5IP5yYa9xK/Y6ulyA8m1AjtR?=
 =?us-ascii?Q?VZHC+/x9ypSOWp5Ombujat1XHmZ5jTE2lFBHU1Av5JRtqQ0yW7p0usdLTpb8?=
 =?us-ascii?Q?wdFO+BGjZ2x8fYZQsiWQRzgk+ULiPRyVO81gaDw18RoVq2IhoeXMOyChJEJp?=
 =?us-ascii?Q?a1wWOpLWLKNHsURf/MAtt++BXPvEErXE1MSTHVLOHo/Cir0j2b1hkcsQUvt6?=
 =?us-ascii?Q?Ag7JuUfnRAtW0T1FFPLoAm2cOJtUq4mxI37gpqCRwP6EPNl/qyLN1JTVW7FF?=
 =?us-ascii?Q?+nJeDW36hz6+hqsEIlfqT/aoYcpCxk/dbGG79BOxS9yvq9MV7netJw1ydS+r?=
 =?us-ascii?Q?JipRTdpRTdgBbQxYEOWnDlHdTHhtdPhqntLD6yTKciymu/cN2Qvtsxlid7RT?=
 =?us-ascii?Q?cAClj6oqKXnw2ZOH7q1+CDeCdevnlZZ6wPbkMqCJ39femVfCLamzC9h1+rqR?=
 =?us-ascii?Q?HaRgY61N5+PEfWGM8tRIZdEEjsorDGxz6XcA8OxNC1WeoJCIRAfqds+/O4zP?=
 =?us-ascii?Q?BMnRU8KPGA9MCTJ9u1VfAYj1wyYa9ptxp7OispWcB3D7BqDKfjp9mrGOgRYm?=
 =?us-ascii?Q?WTdu00nVuL14GomewfZ93SgySbB4F/+nRHQ9jgTjCxrJObloSq+gMTxwPDyl?=
 =?us-ascii?Q?JhA05g3ZOb8PDSTeQ+S0IlRhX7edXX2SgFNWU8sUzY/kkGVMS6JMHD5XfYQo?=
 =?us-ascii?Q?tJFQjH/AjboX0LwNKEwhTBQuQVjwou+sZH0pXZiUrvrIFDWMXFgHkXDhpWMW?=
 =?us-ascii?Q?cpTNeI2uepWlu27ZyzUH9fnRRck3dNTGXnuVXxWRwoIhJ82l8AKt/JF60Z5p?=
 =?us-ascii?Q?euS0+bPd8QVIG6epdhtUZgfICycKH6UFMMgyTN8ul5jZMC6tIKKDAPRC0e13?=
 =?us-ascii?Q?gAAEzDUja5FhKmCJrLCLc+f0cwaJQXim7v4V1i1vUkEAMHy7lk5rDGvKht7B?=
 =?us-ascii?Q?b7xOZd35CeLL4tK6S9Iw5k1WeM7gn3ZydXN66UcCl0ZLHZxmWMkHRic/rRyE?=
 =?us-ascii?Q?7/tqzxSXD+JJQuDNVMVsrHXLLnRxbrgufB7Vn8P/CiwHLXfDD3czx9215E4G?=
 =?us-ascii?Q?6rewRYYHGmrAtkkkUjlekKkZX0PCTzEJPhaXDctSTZXKppm8jFBZCp3HPgE0?=
 =?us-ascii?Q?0r5HMlO3YoUbFdcY20SCLar5AkGskU4ZlQcB0Rg0XqeeEUm/yDHuWG0fdGJG?=
 =?us-ascii?Q?+ihOIxIEj19FFNvDnI9EJIlqhSIlb5v4H+9g2XGTC71KiWuZI/cZBWNk+ErE?=
 =?us-ascii?Q?OU9oLDAnVIR0MRQkfk3N9izYnh1V7zhdpdV0lH2ZM1ca26bUB9+htTn9wAba?=
 =?us-ascii?Q?d6ztujgiWfQnK2kTt1rapXltZMB4/xShbH1eReJhzQZYgWpZ+s/ByW1OIZLZ?=
 =?us-ascii?Q?XVNV6A622Pa4+Ygt2vnesFg40RELNKvvXG53UzxP2GegfCVNlfX++tXyjwGY?=
 =?us-ascii?Q?1JiIUixa3iocWi4pAX7eUFTLFmDPH7AzwF/arJT0zRk9hF+8tRv/rbl5Y/RR?=
 =?us-ascii?Q?XINAEPTdrlkyn7wvaYu4An30CVhMfIzmgjT32aUz2HMOMKiJPMcThPKLLpaP?=
 =?us-ascii?Q?00Jdu9j1HMXDhnsReJjH4AGpuDuVZXETRcr+zPAHtsVCZtDE/W9z7LXnpDwW?=
 =?us-ascii?Q?d8g68qZb7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a16c1e4-28a2-4217-8554-08df2aaae695
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:01.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubsylNvf1DpMsgXj/8tI8ngtKOlVdlP4j31CgnKCcDWq4J7V700j/L6UC9NNnzYqt7ZhEmFbe1xNtnnyjB57YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

This is a belated follow-up to Zefir Kurtisi's report:
https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/

which is that the ENETC misbehaves when transmitting packets smaller
than 16 octets sans FCS: it sends them but does not update the completed
index in the transmit BD ring. I did find a sentence in the reference
manual explicitly stating these short frames are not supported.

The original series was focused on handling the invalid frame
geometries (now patches 4, 5 and 6). However, review pointed out further
issues in annex code. The other patches handle those.

v1 at:
https://lore.kernel.org/netdev/20260401172246.1075883-1-vladimir.oltean@nxp.com/

v2 at:
https://lore.kernel.org/netdev/20260406204122.167237-1-vladimir.oltean@nxp.com/

v3 at:
https://lore.kernel.org/netdev/20260915222735.1016937-5-vladimir.oltean@nxp.com/

Change log in individual patches. At a high level:
- applied feedback from Wei Fang, David Laight and Sashiko
- dropped "[PATCH v3 net 7/7] net: enetc: drain and cancel one-step TX
  tstamp queue when going down" because addressing Sashiko's feedback
  would grow this series to a point where it would become impossible to
  make any progress; plus it becomes more and more unrelated to the main
  objective. Will address that part separately.
- dropped "[PATCH v3 net 6/7] net: enetc: linearize PTP event packets
  with one-step TX timestamping"; also unrelated to short frames, will
  resubmit separately.
- split v3's "pad short frames in software" into patch 4 (do not rely on
  mEMAC hardware frame padding) and patch 5 (ensure head buffer has at
  least 16 octets).
- reworked v3's "pad short XDP frames coming from devmap": instead of
  padding the xdp_frame in place through a new generic xdp_frame_pad()
  helper (which only covered ndo_xdp_xmit()), patch 6 now pads in the
  driver using the shared tx_pad buffer, covering the XDP_TX path too.
  Consequently, there is no longer a change to include/net/xdp.h, so the
  BPF/XDP folks are no longer CCed.
- new patches:
  - 2/8: serialize access to the same TX ring from NAPI XDP_TX and
    ndo_xdp_xmit()
  - 7/8: fix leak of pending XDP_TX frames when going down

Vladimir Oltean (8):
  net: enetc: consistently track dropped frames in enetc_xdp_xmit()
  net: enetc: serialize access to the same TX ring from NAPI XDP_TX and
    ndo_xdp_xmit()
  net: enetc: fix bogus TX ring consumer index after reinitialization
  net: enetc: do not rely on mEMAC hardware frame padding
  net: enetc: ensure head buffer has at least 16 octets
  net: enetc: pad short XDP frames in software
  net: enetc: fix leak of pending XDP_TX frames when going down
  net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()

 drivers/net/ethernet/freescale/enetc/enetc.c | 160 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h |  12 ++
 2 files changed, 148 insertions(+), 24 deletions(-)

-- 
2.43.0

