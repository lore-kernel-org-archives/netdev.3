Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594469;
	b=WcEL4dUWXqVEoe5Yb1sfv27wuTzhDNL5dRDzHSA6wW9dC8mGb/TC1ucNbJAcwoWr34cq
	 X3n/UiSEgUCMu5SRgQvAoxwNa+yQnHRAzokrbFERW9YuMjDkFyC0lXlyQk/P72wOD7QlN
	 U8sDJ1bJPAU7j85F/KvQrEjsJSY2JGKUEUmnmYPdenF8GyaPmS1et73I5GiMueGlNKKpf
	 6zzy3xGAhO70yhkUnpmL3Y+2G1wiK+0MG5XB+1yCvc56+izVMe+1agITxxvcD7udkTGpi
	 if3fuJtjHMwTJMFSVXCLUz3uWSzo7yJSwlv7jg7bgd4yNAHjK4YFIPTZ40E6sG+TtNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594469;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Lbms0Gvy09EWJprMzS8/Vse4lIZhvk/sMhPezBc2PvU=;
	b=cZRKm0mJstsZTkFbKGdOfYPNUNi3xJ9xYYuUAtYnIewgFbADKyub8K9j8QifZLQh3ocD
	 t/4stA/dSAAfWBQQZ2lZIxYj2OdH/h7JBTeMkh85PH/iLemVowXM8pKxWffqraIehltHj
	 DGyTW/HFwtemY9cgm8I5ohRY52Ano3qHXAPrVryUpb/1s8giMMjXS9NLoSX3vDZsneFTu
	 ZWfUr6PL7Ll5eTXW/uLend7rtMUR7+W+4yX100eqe3zGsCgc9TFGZlwJLNrp6zXKEsmXc
	 JmSh1dvlhTlh+KCPKt5McvWf2xhjVQT94lob1zZcyOm2VNjRaxVr7WQGeOpG15A6+Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=crRHAdly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.50
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D418606A319;
	Wed, 21 Oct 2026 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D418606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=crRHAdly
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjlFJHHCGHRyouznytwGOS4tXurf1qJw3N/yj9i0VSQ9RisPvIEZpaRUwnq50rtIsHNpgppuZMsRqUoH2NFyiATg54PTWtQUJLYyEqlRJN5XzHmOurDnyyN0W0lSNBlfsW3SmvgUnXWBoArd4xoUKRcBz+UItawdxrbcDpUcWJaML0ZiHcDLbi0iAYn5QTAoEIZ1m8pNREW1ZFQhLQdC4a7DbOcY2f0H3vi5lNjJwfB3oMDWbuU6JaWwrYN8e80dagxa3mDnzjmY2mjXvMffv0Nh6n9j2eZQzLoak0jDFSkzjwGlj/Vy7YlR4bjGO+CxRXa9BV5ye31iUChoITBJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbms0Gvy09EWJprMzS8/Vse4lIZhvk/sMhPezBc2PvU=;
 b=T0EWA+HZZpdojrzstms5MIsPmakMg21cn3pbO+iMrJNOhtIPQiQo25L44Z6JbepKgHuIAV1QPqjjz7dJNb4WZXTe3+wbsL3orUkQSqybheHbNRhq3GhLf8sdVP7b48MfKuAZEzMzLvOB0gN6RES+8kggC2VL1LFCQeFtFb7hpczZyYXU8bX9cMNiaDgLgPAGNENwFesuZR85SYWBnSPyHcTVxU2sb21S3eDmv1bfYluTN7kHf8QcDNPW6HBAHj/QSRDhptPPns6+4UKogczqIMlIwcyi58mygV61pQ6F79a2FxRzRdlchCfhgQY8E+W/BKZwRT1L+KcN9+gMvZCkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbms0Gvy09EWJprMzS8/Vse4lIZhvk/sMhPezBc2PvU=;
 b=crRHAdly3ZAv0aUtcIqVDJQLFCWeU80gKfFuOl+LZsnWFhsHoY0S1rGaIHt4ur26himlMqEjHtwHt4Sv0L4W+uzQvxTx06wfBo1NZ1dvyXIrqcZ3SDBZVpIZ5UjPWetq9xSaAi+fPYfxDIh8S2ui5yRcYJ3gt6QILrNC9YCGsKvhD8N/sE4Cryp+G3tW7VuX3LtjfNNfTlh5sg1eCKNvEBojk3iiBksy6/X1/I94uW4wBaVLP+L3iwmGo47FXu9Uj+lpkkLhYh67J7L6o7wu5lnDlPNpgpOccGHVCEO6p8teEyX78/1WppQKQM/t+hnLqlaxNs9OkHHt452ZNJm9QQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:54:25 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:54:25 +0000
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
Subject: [PATCH v5 net 0/4] Fix short frame transmission in enetc
Date: Wed, 21 Oct 2026 17:53:10 +0300
Message-ID: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: acac6857-3c8d-4362-f565-08df2f833317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|6133799003|18002099003|10067099003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/JuW4Ohx3bKWC4nr/depMensJ9Zwago+b3HSFc1ORxSTG7WRCh4tmNNOA4vfTRe0igAkzyczKgqklVbiza+mfxj8G0gKeSVwoMIoihZsHmv4L1NUfgA+bVCfOGsqaCqeGI5yj0Aycs0VxaWpMWYs2Uh+uY6rXmes9nZN7MVFpH/PvcqU2Xj/nev9nOmroLw+3VLmV9xD6bX99dXsxbjdD7gc7VD8oiwSyyXxWUoGGGGsauuyInGRmu6uIigHTg0E0BhqYXNdwnjkNuF2KWEEXf6ywB+NX5rxKdCNmPlEHG2D2RR1c7GT0qQrbr+JnRNQ0a8Q5hdQiR+zbfvFytn1BOJur+pZBGdZCtOuQ3VZJ5VoZxqWS9JQiCJILjgjSI50SBzw7UhV/u8qBnVSXgUW7qJ++stSAgw5Z9VmyFHRSNKVAHWYFEMN/ZlvWRHxqYtbjjMVu8FDa0mRCFvDyEVP6Zzvj5YdQfIuxzGdmMLrJT52wozyenWSdDPVK9opWWBHlOejNifNIJYU7bbqKK3ahV4ZRFJo6danIlO+GEklSxGn7a5XNYXop1AcqEKqt4grepRVppmte2FpprqL/ezFaTOrugxFIpVsGbUUUfGD++GJc+FTUCCbbL2WlzglpeoN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnlUkwmUyTs8FJyGTnoYhxw1b4DF96xvJNkLVZlxhcjGhJzKAqvYuUY6ZP99?=
 =?us-ascii?Q?3kybh3V4tb76FAqC6Em1NiQStGvFIbdCGNtfSmd7c9bo6ly1ReZFG7OIgUr3?=
 =?us-ascii?Q?lICTeB80u+VhMie3bIYJGkVTlIBzIdlFVYEYRyMVCKE04QgGTQBOkLYG9pvi?=
 =?us-ascii?Q?dLKGO2Iv6pFX5cn8bXpSjjFybep8PuVFxb17e57Pb3F2uE3CQcag7FcJWyyY?=
 =?us-ascii?Q?RmT02VQDNogligRoP46QMKW/pD9Wt04YBlIzAMDrQ9jou/juVsHc8xX9EdXN?=
 =?us-ascii?Q?T7WNVDQIG0uhSuG9gHqj+N09f7M1Y+W+I/HCzuIEvfcOov+D6JmX71khV3YQ?=
 =?us-ascii?Q?+ngBexgACblNKxFwWSNPNzG06bShaMUJBQ24y6uURJxo93MCTJ3EEPnazKlv?=
 =?us-ascii?Q?aX1lNNyeR+JwviPafut6sJWn4RWQh+zyqb1KLu/onwg4mRgpP0TClg8XIX/f?=
 =?us-ascii?Q?cOWTe1D2vqkrFy8UuizG0OfRD4QOXiS8mwitiWb6zops59HSEhT3eSM9b3v6?=
 =?us-ascii?Q?TTZ9Fls7fWW++ng7JvxkBzZ1hAZpAu9PHzQ2uZBxVggc1VZYc9jNmH5CDxc2?=
 =?us-ascii?Q?Vd+m35hCMT++ixYriTtcqhIepmOBhnfPtlAotd0GoGs3TV0xTwTGLrt/Hl2J?=
 =?us-ascii?Q?RNxTsUuewyaCQi1XmG+ZvE87d2ioXgyH6pOEMwXjsDwCz3uQUNDSOQMqgjcy?=
 =?us-ascii?Q?YtwrdnGB/5aBpYVysPTGrFzJhleBI6/PgYIUioJECOObnUGkJcVNDqqLBIBW?=
 =?us-ascii?Q?sPCvjgIfgjTpbVzbLnWv/YHf3d0QT0u9lhuCuj7dI5r6nXR5MQnNeqzGh0HF?=
 =?us-ascii?Q?EAaQS2zaWVsjTAkAKOiIT7KX6A7ugunOuhSDEeUqdlwiMzOzeGPhHvvzUfoz?=
 =?us-ascii?Q?u30uDXawqFq9wSUA7kbr0CsfPNuBNrdqokUtu4n1BB/xYkkS98JLvwVz/G3m?=
 =?us-ascii?Q?fvgAVTEbPxqZqsEdYcT01nVwpNBXhKUVKY2rThhyDUcQT/7JRBr+4LqWNZUe?=
 =?us-ascii?Q?F+4a04feP2z4PCF85PBlmnnpBBxOCIoqD5CW5aZ/ZU6dJqU0gs50ScdyGHEy?=
 =?us-ascii?Q?TRwsouZ0tf2ZD7UPPsC5T4mkYGjfR/GHCCNg4behinsmIc9A8wwCEcl2i65+?=
 =?us-ascii?Q?xEF5wXzoKuEykios4n2iaxhy1pZTVEQI0K+7aPFm54/G6bfV/WtkiFcl9GRw?=
 =?us-ascii?Q?xnQxq96U720Qsr/B3ZoeAlhQx28lVuDNqnG/qQ98gP0I6p0F0wYwNi+6zmNd?=
 =?us-ascii?Q?rl51wb28MiIFA9PMt4UVPncMyba/lC9+c1s+IZr5DbtJey5W1xUbZuHXoj/G?=
 =?us-ascii?Q?1kg3JAuPvbyOBgpD8SSThzL/mn7pOJrH10dZogbzVhysKW83AfsTA8mf8C1j?=
 =?us-ascii?Q?HlTYaqcpq0KW0W2bldxY+IuRBc8Y0B8yH6GXl8hi18n63pC2e4XL2X1nONpO?=
 =?us-ascii?Q?EcGuTJgEXXNJ/O5beUq92yu1P4BJCvWquqdK44RWhWR1k3GdbE4YkhOhsnbJ?=
 =?us-ascii?Q?TdXObOp3MUqZHqiPsZL2h8+rRhho6ucx8GG/RKj5CpTWpGq20UftBhg1umMh?=
 =?us-ascii?Q?tWG0Po9MlZ5/vPDFkUvJ9YjF3Oj9ejqGXTZlJKHmazs0S9LBaafVuLNfz+1Q?=
 =?us-ascii?Q?P7DDjR6axUlAd6LEwd21/vPAoXHbJwwOwmYIpRxh2kDYrKp6XIG7bHsdLwPv?=
 =?us-ascii?Q?USl0bas3ClNvtyt8cmUCRGyCHiEKio+I+rPq8vO8fty2NRU5XcVA+eOxsu//?=
 =?us-ascii?Q?mW4/yMC5nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acac6857-3c8d-4362-f565-08df2f833317
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:54:25.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Swl5CeulD3yJvstezb4Fil0XlNBDF5x5YUffnXwDlHkKn+w5YyhTififFrt1uh2p0L/8mnUd6ohv7m8e041h3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

This is a belated follow-up to Zefir Kurtisi's report:
https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/

which is that the ENETC misbehaves when transmitting packets smaller
than 16 octets sans FCS: it sends them but does not update the completed
index in the transmit BD ring. I did find a sentence in the reference
manual explicitly stating these short frames are not supported.

Separately, the series stops relying on the mEMAC to pad short frames
to ETH_ZLEN, because the padding it inserts is not always zero, and we
want to avoid any risk of leaking SoC-internal memory onto the wire.

- Patch 1 makes the software TSO path reserve enough TX BDs for VLAN
  extension BDs. Patch 2 adds one more BD per segment to that same
  reservation, so it builds on top of this fix.
- Patch 2 pads short frames to ETH_ZLEN in software, including short
  software TSO segments, using a shared read-only zero buffer.
- Patch 3 makes sure the head buffer of an skb is at least 16 octets
  long, which fixes the reported stall.
- Patch 4 covers the XDP_TX and ndo_xdp_xmit() paths: it pads short
  frames to ETH_ZLEN in the same way, and drops frames whose head
  buffer is shorter than 16 octets.

Review of previous versions found a number of pre-existing issues in
the code surrounding these changes, and v4 grew to 8 patches to address
them. Review of v4 found even more. To be able to make progress, v5 is
reduced to the patches strictly needed for the stated purpose. The
other fixes will be submitted separately.

v1 at:
https://lore.kernel.org/netdev/20260401172246.1075883-1-vladimir.oltean@nxp.com/

v2 at:
https://lore.kernel.org/netdev/20260406204122.167237-1-vladimir.oltean@nxp.com/

v3 at:
https://lore.kernel.org/netdev/20260915222735.1016937-5-vladimir.oltean@nxp.com/

v4 at:
https://lore.kernel.org/netdev/20261015105536.1692348-7-vladimir.oltean@nxp.com/

Change log in individual patches. At a high level:
- dropped the following v4 patches, which are unrelated to short frames
  and will be resubmitted separately:
  - 1/8: consistently track dropped frames in enetc_xdp_xmit()
  - 2/8: serialize access to the same TX ring from NAPI XDP_TX and
    ndo_xdp_xmit()
  - 3/8: fix bogus TX ring consumer index after reinitialization
  - 7/8: fix leak of pending XDP_TX frames when going down
  - 8/8: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
- new patch 1/4: reserve VLAN extension BDs for software TSO
- patch 2/4: account for the pad BD in enetc_tso_count_descs() and in
  the per-frame chained BD limit; explain why hardware LSO is not
  affected
- patches 3/4 and 4/4 are unchanged

Vladimir Oltean (4):
  net: enetc: reserve VLAN extension BDs for software TSO
  net: enetc: do not rely on mEMAC hardware frame padding
  net: enetc: ensure head buffer has at least 16 octets
  net: enetc: pad short XDP frames in software

 drivers/net/ethernet/freescale/enetc/enetc.c | 114 +++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h |   8 ++
 2 files changed, 113 insertions(+), 9 deletions(-)

-- 
2.43.0

