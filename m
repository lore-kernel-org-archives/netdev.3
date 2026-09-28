Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019D2C11F3;
	Mon, 28 Sep 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625368; cv=fail; b=NhQnqTwFvcUB62qJp8DpDdpiaJQxRuUiLFw6nYTTsu65QH2YtQ8IPPvKNN6nC/cmlrGlrmoUEJ3dS5lr4v9jMuUlgx3o3TdngKj2SNb6M9GpS6wwKbBTIbch2M3Hz96/chcVelQj55V7hPUWHJBo7nkbujYEzMn5294+9YFZ/t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625368; c=relaxed/simple;
	bh=OwSF1DjN+Kz8q5RiVsZQVCvmkWIckb0IPHscSFO+jHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQ5kqTy1nz7mhNNnwhZ7P0vufXpDDQdaaXNyywE6z3u32xpN9wogjpmlhianOTL14AjDpok7S2D6n7Jslo/9WNoAfYxlAguyEKfd0MTpZZ1Sqe3C2VxRS8XSHO1eu+EOexMiGM64uOLhSnOt0ipHuojYeUs/YMVb3syTyJG8ZNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ojpw2/ET; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ojpw2/ET"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bac/hrBTA8SlNYVUrHRHdDwAaN6qrvQWUTQhfAmFhRM5y1t2VB9q6ewX7g32N9Wg9W+YxygSUL2Pa2Wwr1OwrzE6KYd3Hwu7WCOSWEIAXIkxt/JZRtOp+6PfoW9e8LuuqQVDoNrIF9zyf9VNyZF0k5Nnl9oJWMvJCcD2sHQKpIZZOQ1b3vMhUpDTWLxghJSRr/fIxd34lZUUG4AxcjaOFtoKtzxbRmfkoyiYMNwyLVuhr8Vr/kjvputcLO7oXIv6h6brARy8KFkvCjDpFyvGVqPHrP0smLFHxFEnGAGwCyzWETDLK5cfR4vO6R3lMml/T4EbmaaC0AFuYkVhpYizkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkIzNVz9U2qGyBqouHDhGCczSpjxqLeprjzCfos6N8g=;
 b=gjHYkZRMpl1wZyfRgguXs3aEWcr0gwSyCLN3xnrJJePyJE91kZnGQ/c8VL6wGnnxDDnq7XrKzMLg1hjCIVwmJHshccLgm3wh28dAuRg3PyuS7x0BcHVPbxo0mGRiW2vvsB4+GZ8wj7xog296MN0b+qnHWwceZE863dP4SBhBa4ie3klmuoMnpSS92Z3ME8kpPSkpbKoP2JgmlaT8/xN4UNUzOJdXAFWADEcRR5TOJPWgL0aAlasIzv0QrzKdan7j0EeNJKKV2KCMqqn0M3MUm/RdVtM14vC583y7SXKcgTt11Cc3s5oplapR4Pihg09N5nHqYnWAWm4k0FTssBqsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkIzNVz9U2qGyBqouHDhGCczSpjxqLeprjzCfos6N8g=;
 b=ojpw2/ETNjLGbQof6R2kQb4uvosaFUc7P0fBb63mWfmHOmPdPWZMdmOqQumBRsXVdi8g9VwqpWeysEdgU5AIVepsmd3TVz/qbiV+LLypWH91plX4n+cCMMft1mBfaXOyP7MDEbEvRVJJRIsohSCfBix4A7LvnpokwZRMTzqXeFYwU1oWjfXT3lFYMZhJcZTbMiVvKqRs+7E6bcJw68h+KUF3+GWvJ5qb5bunZLLJ67AuEnNXuW/Tj+VCVvr07vbR4U+uqwSnzO+T1MuNoIhVZHZNbL+Sn54FHss4/co6QI6HzOR/+sjewt1qEbhzYnZLSi0KX86UZg116FBkKFp6Ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:56:01 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 19:56:01 +0000
Date: Mon, 28 Sep 2026 14:55:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 11/12] ARM: dts: imx6ulz: Add Variscite i.MX6ULZ board
 variants
Message-ID: <arrGNEC-9It08FKj@SMW015318>
References: <cover.1790512621.git.stefano.r@variscite.com>
 <4e63d123736daddc18dcddeabe96b6e2bfd65611.1790512621.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e63d123736daddc18dcddeabe96b6e2bfd65611.1790512621.git.stefano.r@variscite.com>
X-ClientProxiedBy: CY5PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:930:1c::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM9PR04MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dacf1e-9556-4db8-52f4-08df1d9a7dd7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|23010399003|13003099007|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Rw3cq7P2ifmvfs4Ul8kLuQsB/RKl4Ms255ZgcA+8fT/qpWripaP6V3/mwrX2Cd6MdtWMA60yZkFxqhpCDuOdFuUpmywB50kK6V3iGzcsA/kx4eu3nXazkC4m8nkcuk9wE9fFCc4LI4ayY1mVcnwRGOLEy4WIxB7GAlrx3ssyC/97LB8N9spCBKWldipJTlOj9o5nCo/3AEojYBLRrJMpBIXG1hDJ9rfKWnv+miOjHHMbC2ew1Y2Z7nzzxhCJm47V0yvzWu8Im9zDSbNSAOZcMdlj3GjbKcTnhIOtRjWcbmJdj4w0Mzlx8OfpETsMzb6lSqGO/oDnQ67ITCG5jEnIoB2B+kdmO3qR2qIwaeQhjz0FWODZXyjhBA059O0UM0A9xGCiWpG/2Und4oNYsWvumU0GbfcSurNu67EX7m6uEaGgG+nv4kRP8ZhtEoOV+5NOdjDsQRyu1sEHj4LsccJAPbZoOY0zyX7WGBMch1phUO19rlE2gP6Za5tdd1dK102lkj6wSWcplVmqmClgA7Nn+Yiuy2bUJY8yQqsHlKQ8HGagso+cj1AMWaipfvfQyB2ssHLGLA/NTwo7dddXKiGVgDSaz7WdNjPC45UcMWBSf2c=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(23010399003)(13003099007)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?fdvUU5qsuobKUGo6iMWYCP1U1ZYjqZs3U9dP6D1XtA9Xu8JXkS4Tt+tCINqo?=
 =?us-ascii?Q?S4ijv9jmTs87LRCClO/Lzgcts/sqI+xerMWt9uu+KVnmGTih/VfyRxXEBe2h?=
 =?us-ascii?Q?GakrUfN28EyU1HieXafsxtHYfqXFB+54wuVfetXVpogBRMbGFyIdIHVZM+H9?=
 =?us-ascii?Q?gq7FlgOuW3ugaoECoJ5QRb/JNLi2vcCs2ztckwKJn1zKb0/8CUAiVdA3nQ0Y?=
 =?us-ascii?Q?wGTtF+hfvrGyvnhGv04aUNSeC28KL76hZH5UDWqcA/nVXkjKY3a6rjjWRy4p?=
 =?us-ascii?Q?FlalYthGDukSDSi70evZChmOLjOMOY+iu2iXgtnjPw1mCuTHj7l8QsPvXJxv?=
 =?us-ascii?Q?QMrTrYym+vnA2cFclWNgCOFtWOxF8qgdONZraWreFgKQV4Dlg2nm1whFi1vS?=
 =?us-ascii?Q?YnrpbKo64tbWpc3X3T0hS/S5QaB88hYh+vV5Ha1i38eAnXgRsKCdatOZriBl?=
 =?us-ascii?Q?1X5KbZgzGQlhl+mdNvf2rQeb7UNh/p+abKrEcIk5jRT8nmHx53ewvqbokpuI?=
 =?us-ascii?Q?e9Zq8pQPmlBKy89Vf+IeXcEiharSJ/c82ho0BIP40bacBz7u6djRcETXN/jr?=
 =?us-ascii?Q?tRuonMUy3lWYNmdGhFzqPeeZWqKpX7uUNGXrlYINOpCQAz6UPmApRxunlVF7?=
 =?us-ascii?Q?vGmYc7qdvxLQk7eg2ey0t5+IvxFLJUWyHbm5frkU9U/JS07CVbg43Ba6wLX0?=
 =?us-ascii?Q?zy2XJtCRI0otB/zrkyLAR6X/j9wl5XrHV1LLuqz8aSfIa44jJg1YMvCDdDzT?=
 =?us-ascii?Q?v7IqnCi2nCQ/XecYpvStvLUcdNPk+oPgPQws6DJiK2AFFeHg8r3PTvy/REN5?=
 =?us-ascii?Q?7++OdC+6NLYa/eynvj399k5I8U2qBwc0qAWGizftAv2c6W7O/bcuRMUOLHGT?=
 =?us-ascii?Q?5X2xwa8b9jXz83e/Qf8lAeW39JzEXjFzb6/DLok7/yXqg2XBOA4a94erizW1?=
 =?us-ascii?Q?L0ZLBzz9/y2SxikIKYMl74Bx7n7oFHWeI/Y7wVFsRf7lXNTHh1aHdUNHpdu5?=
 =?us-ascii?Q?MrBHOATr4aFDmg2+gI4h0GAlKFtsHptez7Pxc4IAGVn7B7TJ1dfdmTSzv288?=
 =?us-ascii?Q?QUCpiZpJ52tDgzzL3O0kRR9WaQeVcM90tS4OOPv/CGZIHj9x8bY/Y5QJDZh0?=
 =?us-ascii?Q?PlCJNhBcQ2UD+blpefMg+ppIjtI3pZq10teLuvk+60RJZEDtX9riPSZPdc0e?=
 =?us-ascii?Q?PI+ekQdq0qJce41Y1qhadfgKIXFWC4DM9WqcgR+NYlJYGIVZ0TB+/kYvfshv?=
 =?us-ascii?Q?fHUpyrfSo/EEdyGxrf8oX/oj5coNGG6XOAQBaVrvtzteKRRYr0gzb+pqKRBi?=
 =?us-ascii?Q?b6nCQE3GlfXuSoRCB4JG28vmS57JoQydggopyyzPa7rEJnF22avx2/3pDtgb?=
 =?us-ascii?Q?zvjnIB8wC6/if6FiY2PqeN7AWE4hSHESAlEL9w+/AS/KsU7CMzBwMW3NPfkS?=
 =?us-ascii?Q?zmmn7/HAKGYuRX0zjHf3uBeHdN0VPqAkuIovrxYMu/xZPb7TeBIu/NFoBKNJ?=
 =?us-ascii?Q?b2hOeY7hx0sVx0RGOisWngwAxgu/6w63QucL4XsuwwlWMQgVAY0aJ3esdTAc?=
 =?us-ascii?Q?VJHaHYn7AwwJM1FJtooi2Vx+J9xFsl6RjTYiApzjwDpnTdaMDJCycfG28noc?=
 =?us-ascii?Q?YgEhdbRL75BBcJM7QJDepArJN6rYuXPTvHyiFzeq4LyfMWrw0sx460PWdw0T?=
 =?us-ascii?Q?J7kaIHJ1kwIyQ6pgYZvBE3olJVr2+mmL03YHB0G3zZdvvVLRP14lJNx2l98j?=
 =?us-ascii?Q?4jLDm/ckfj1USgcz8N/XP7VKIUYlEQMZ46lGXNgssPne4TaVZqYt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dacf1e-9556-4db8-52f4-08df1d9a7dd7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 19:56:01.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7io8KiDIVu/O2UTwDMKCmwYSyCGCv3yJbNHE2vf0UOvBVO2QGi9b6NiEFZUMEjVvhRzUkIdU+nP/UlE3nWu8+46aj+bFYfOyzSTKG/YoCBYcMF64KFYkOIGuBaovNMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8397

On Sun, Sep 27, 2026 at 02:46:26PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
>
> Add i.MX6ULZ board DTS files for VAR-SOM-6UL and DART-6UL with their
> carrier, storage, wireless and audio options.
>
> Reuse the shared option and carrier descriptions with the i.MX6ULZ
> SoC and module wrappers.
>
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v2->v3:
>  - Use the shared storage and wireless option DTSI files.
>
> v1->v2:
>  - Update audio includes for the shared WM8904 and WM8731 files.
>
>  ...z-var-dart-emmc-sd-card-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...art-emmc-sd-card-wm8731-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...var-dart-emmc-wifi-brcm-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...t-emmc-wifi-brcm-wm8731-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...ar-dart-emmc-wifi-iw61x-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...z-var-dart-nand-sd-card-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...art-nand-sd-card-wm8731-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...var-dart-nand-wifi-brcm-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...t-nand-wifi-brcm-wm8731-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...ar-dart-nand-wifi-iw61x-6ulcustomboard.dts | 21 +++++++++++++++++++
>  ...lz-var-som-emmc-sd-card-concerto-board.dts | 21 +++++++++++++++++++
>  ...lz-var-som-emmc-sd-card-symphony-board.dts | 21 +++++++++++++++++++
>  ...som-emmc-sd-card-wm8731-concerto-board.dts | 21 +++++++++++++++++++
>  ...som-emmc-sd-card-wm8731-symphony-board.dts | 21 +++++++++++++++++++
>  ...-var-som-emmc-wifi-brcm-concerto-board.dts | 21 +++++++++++++++++++
>  ...-var-som-emmc-wifi-brcm-symphony-board.dts | 21 +++++++++++++++++++
>  ...m-emmc-wifi-brcm-wm8731-concerto-board.dts | 21 +++++++++++++++++++
>  ...m-emmc-wifi-brcm-wm8731-symphony-board.dts | 21 +++++++++++++++++++
>  ...var-som-emmc-wifi-iw61x-concerto-board.dts | 21 +++++++++++++++++++
>  ...var-som-emmc-wifi-iw61x-symphony-board.dts | 21 +++++++++++++++++++
>  ...lz-var-som-nand-sd-card-concerto-board.dts | 21 +++++++++++++++++++
>  ...lz-var-som-nand-sd-card-symphony-board.dts | 21 +++++++++++++++++++
>  ...som-nand-sd-card-wm8731-concerto-board.dts | 21 +++++++++++++++++++
>  ...som-nand-sd-card-wm8731-symphony-board.dts | 21 +++++++++++++++++++
>  ...-var-som-nand-wifi-brcm-concerto-board.dts | 21 +++++++++++++++++++
>  ...-var-som-nand-wifi-brcm-symphony-board.dts | 21 +++++++++++++++++++
>  ...m-nand-wifi-brcm-wm8731-concerto-board.dts | 21 +++++++++++++++++++
>  ...m-nand-wifi-brcm-wm8731-symphony-board.dts | 21 +++++++++++++++++++
>  ...var-som-nand-wifi-iw61x-concerto-board.dts | 21 +++++++++++++++++++
>  ...var-som-nand-wifi-iw61x-symphony-board.dts | 21 +++++++++++++++++++

Make file change should be in this patch also, make sure it is buildable.

Frank

>  30 files changed, 630 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dts
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..612246fe5638
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, eMMC, SD card & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-emmc-sd-card-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..cddfce9c41d9
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, eMMC, SD card & WM8731 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-emmc-sd-card-wm8731-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..c942538d64e7
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..cceb477aa49d
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-wm8731-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..708c341911b4
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, eMMC, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-emmc-wifi-iw61x-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..308514e7f1c2
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, NAND flash, SD card & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-nand-sd-card-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..20586513b1fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, NAND flash, SD card & WM8731 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-nand-sd-card-wm8731-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..afa3d3d9ac10
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-nand-wifi-brcm-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..ca16b34b5a1f
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-nand-wifi-brcm-wm8731-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
> new file mode 100644
> index 000000000000..7373a5d438fc
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-dart.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
> +#include "imx6ulz-var-dart-6ulcustomboard.dtsi"
> +
> +/ {
> +	model = "Variscite DART-6UL with i.MX6ULZ, NAND flash, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
> +	compatible = "variscite,dart-6ul-imx6ulz-nand-wifi-iw61x-6ulcustomboard",
> +		     "variscite,dart-6ul-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-concerto-board.dts
> new file mode 100644
> index 000000000000..1351767d435e
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, SD card & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-sd-card-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-symphony-board.dts
> new file mode 100644
> index 000000000000..973fc53777e2
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, SD card & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-sd-card-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dts
> new file mode 100644
> index 000000000000..f34cb378a611
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, SD card & WM8731 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-sd-card-wm8731-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dts
> new file mode 100644
> index 000000000000..ea9f6e4d2e6e
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, SD card & WM8731 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-sd-card-wm8731-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dts
> new file mode 100644
> index 000000000000..2271acae99c5
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-brcm-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dts
> new file mode 100644
> index 000000000000..590cd1830787
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-brcm-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
> new file mode 100644
> index 000000000000..79a4b39c20af
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8731 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
> new file mode 100644
> index 000000000000..eadface31718
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi BRCM & WM8731 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dts
> new file mode 100644
> index 000000000000..f16bf6b0de0c
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi IW61x & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-iw61x-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dts
> new file mode 100644
> index 000000000000..44a2b61447d3
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-emmc.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, eMMC, WiFi IW61x & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-emmc-wifi-iw61x-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-concerto-board.dts
> new file mode 100644
> index 000000000000..c77d897864d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, SD card & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-sd-card-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-symphony-board.dts
> new file mode 100644
> index 000000000000..a468c41e603d
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, SD card & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-sd-card-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dts
> new file mode 100644
> index 000000000000..aabd99bd5c2d
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, SD card & WM8731 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-sd-card-wm8731-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dts
> new file mode 100644
> index 000000000000..6531a4fe25d3
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, SD card & WM8731 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-sd-card-wm8731-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-concerto-board.dts
> new file mode 100644
> index 000000000000..b802e5f229be
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-brcm-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-symphony-board.dts
> new file mode 100644
> index 000000000000..100f3f8a5764
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-brcm-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
> new file mode 100644
> index 000000000000..c2b71b782e77
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8731 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
> new file mode 100644
> index 000000000000..c53bfe5b3b14
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
> +#include "imx6ul-imx6ull-var-wm8731.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi BRCM & WM8731 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dts
> new file mode 100644
> index 000000000000..82049810d604
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-concerto-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi IW61x & WM8904 support on Concerto-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-iw61x-concerto-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dts
> new file mode 100644
> index 000000000000..b4980a5992f7
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"
> +#include "imx6ulz-var-som.dtsi"
> +#include "imx6ul-imx6ull-var-nand.dtsi"
> +#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
> +#include "imx6ul-imx6ull-var-wm8904.dtsi"
> +#include "imx6ulz-var-som-symphony-board.dtsi"
> +
> +/ {
> +	model = "Variscite VAR-SOM-6UL with i.MX6ULZ, NAND flash, WiFi IW61x & WM8904 support on Symphony-Board";
> +	compatible = "variscite,var-som-imx6ulz-nand-wifi-iw61x-symphony-board",
> +		     "variscite,var-som-imx6ulz",
> +		     "fsl,imx6ull",
> +		     "fsl,imx6ulz";
> +};
> --
> 2.47.3
>
