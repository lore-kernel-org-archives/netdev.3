Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718380;
	b=VaaPsmLyypOrCBKPeIjemGQBEIgUrHNItJflamgxkDvQDGzdXxsm2sPi/VPxI2iTlRtr
	 NxexHoF8Kapugz2YsI6f8Exj0i27R1MDXvO9rzchg0woiiuw/ICivW7w3FXvmVIP8xVz9
	 zYrm0pVyDM1aOEz1I+c1mkumQIRSStTxeU4gOv8UvsGtK6298ZEoM36mITF1Vv25jBvzd
	 ZgHC+WHLcgcVD4Ma47MS55b7Bo01RVs+3de7NOcPg4sr9+D/UJ2YMyCinLAu10nU4lrI7
	 Cg7GCAkZMi1ymXO4s31mwVcgOW/L7h7O8VZZFaNS7W2cYTJXstPQ/3bjfBNMKXr3Hvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=HN7O1arYfTzDppbkwTwbXx2BMRZ0BHXGnmbVS6qakSc=;
	b=uHTztBK3rvUQ0t4RDjRwAZp4hG4tmDPL30c1gLWv6OTrm/uG3HiDLpSb9x1yTHQaAPrA
	 xs/ImugJ70/BEEaz75h7l2dIF0I9SbRl7gJncofgDaVAPSi0sIkywISOfJn/LbuUwlwZ+
	 XvRe/p6IrFfCThFCo3NQ1Q89OqjY7Ft5AgAdmw/E5A74pNMa8e2JIcTzQzz2fFyRs9exZ
	 sgNsGAVLlxLAw+Gnsre1YohYrilBoVPYnEbKp0v5NS69A0qo1/mhrtzoM3i9jORFtD58Z
	 4sTI1dOC7mbmclNp+zw33EJnUjKWXpy2yKfiAThfe8dSiUrBZAlZPuVVuRLEVDG9NZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rEepAPFN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE38606A796;
	Tue,  3 Nov 2026 15:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE38606A796
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rEepAPFN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2aq/lCIU/DJT4rEkiqsDmtOYIhfdxZsRIl8wVTKuPopyvC4WAsaWq6scVV0NhLlxzM1dF7k09VwkpcJEQIMwcP0o97RO6d7z0+O3WuXBPZuGmbzN0Hk7LgrKijxK2HLYt5HNt0IKe2Jqgy3PNnmZwX46+LsMA2CYKtovSvRNNMAHGs5vepkIQHNutGp4h6ayfbsWgEc0kMki3Gxih0LTJa7dT0/9c1+fCSL9fWEI0FFCA8VL0dywcbdb7prOcNxji+omHEVU+7qH2chjDZfeGifCbI6S+QSauH5w8nk2RSNoYSW7sM8X87q7SgjgOEezfQuZckS9VPJ4bdq8Qs3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN7O1arYfTzDppbkwTwbXx2BMRZ0BHXGnmbVS6qakSc=;
 b=zM9Htk1Fq3N9VbW2VYIQz70xvD63TxP34MpuYtXVB9xfwY36GygH13kPL0chzUlD3hrT76gw0oMscuJIzXUnuYfwjG860UXCM5qW6Fask8FlbkjalVEYhhxLb4q5AYAPTiA/vhknLb8eovcqRpS2AYMKn0j+mxzuDU/ot7jytdaRRWI+mPUIB3A/6s1cFELICsv1ODj1N+i9C0FTzTPloTzYesSRj+tM/HqsgIWCyPyb9O9oeU5kGf+nMtFYFVDzl9sLqYRtG0EyqUu3SzsQLXQemfVGwxAOgZmjnH2Pdpn23e3Sn7Wnb4DxIH64h0ks+Qxab1xXzyUbdTouQeZgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN7O1arYfTzDppbkwTwbXx2BMRZ0BHXGnmbVS6qakSc=;
 b=rEepAPFNi1kJX9nPmb0UVPzUvzIF7uDnbr2nqHWlmX1eFhUCMLBVLiuITikl+tikiJVC/rckfM+ROgmOoeWlct8K2RJCczvlWa9DktHFYXMG2x1bDxkX6xiM9GkU1Pwl274sbKCkqMU99fzARN1vVPIFTX2cACZUjXC1nGR5h7xGaNwS+6A6DGUq0k7X7YThNOnzBL+MLo8DofoeCWnM8090wEhJy7J7LSV6LNM9rnaYl09U8yRajoCiXTLba4gvgw3j0yj653lEBXljVAjOPpORi34BdFurF8J2plkPXcOmjuhdz69XWS/l1FiJhqnjFlsZ0fTjX7DGpn0gi/GqYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8656.eurprd04.prod.outlook.com (2603:10a6:102:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:06:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:06:15 +0000
Date: Tue, 3 Nov 2026 09:06:03 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Joe Damato <joe@dama.to>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
Message-ID: <aun4W3dvmfWRDFeQ@SMW015318>
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
 <aukcoWLVvSorX5a9@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukcoWLVvSorX5a9@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: DM6PR07CA0120.namprd07.prod.outlook.com
 (2603:10b6:5:330::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: b2582fed-19be-4859-bd73-08df39bc0169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|19092799006|23010399003|18002099003|22082099003|261102123227099003|56012099006|10067099003|261009223027099003|921020|261022105027099003|261021121427099003|261021123027099003|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	I0VJbwpFhHu3pJfLjouEaUT2ShYd/NkglcESgWbz10GvZeOUHEXtdzsO+hPzl4bF/E62DVlHQszFA7HuABvAxGgNTuDyrwvDlVQT7g7wVJ1sXkk66nB3xl3qZ2eqhE2x00O0T1JPQeBG44QNd8mgVXQLhwu4wI5MtlEYOW526RYJ3QEMZ3bI4RnxiGAA0bcw+brAiDnRe4QsKYWn6tIA3FAy+DqlK5jfWp911LzjiHs6HJZQtFeYbwM+e0NHcUedBMepyw0aJdm0ws6O0UVW1nX60ZbLV+Gur8ssbxUPL0ds0fGaAxRLwGkchU5BZYyldq0s9UR2iPU7OjoLNlK/CPwVcU+Dv541WZQvKL8ntS2FYNlnbATG9RMdICKd0cpOYxUYK/gdhkpinjzpWWr4Cul4CNJejw/IPO1X5WwHlcpEYs4ygMMsNcQfkd+Yqs8FcWkuadakcnZp0Uwk8W8JGiqQTyoysJpOIN553s+WQAzTLn5ekOyTAEYjLziLR3xiht7BZVCxeQBEKVK54ih6yXGkOroM2ER2zK8l0w3ckbPxt/1p/J5mMHVeIHXky6+YR2MYelnU9pnq6Gfr+rg//8ox/vlRvPgAQHky5n6pSZj6c97rqGmxO7jW6rD1piTQvJDgdvSIrJvrPujwIMqUcDL3ws8WiP/5r2rov7h+K2eijis3H7U22sIyXWj3LmUHAIm03d2+aMMhuihh828jDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(921020)(261022105027099003)(261021121427099003)(261021123027099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Um67BhoQPH3rutJt0YfVGzVAtrcF7EKlre3rJxMCO7zBupF2vEdTASx731II?=
 =?us-ascii?Q?/6n8NmvyHdDQujpAc6Q8G8nYMaVe4xDE+7/7vEqRehwzIKJAtGWi1tiuiEUE?=
 =?us-ascii?Q?LpRTVnvEaZmIR4pITOW7s8y9S9TThjb6LgHnDx1+0q3z3JVvNnYql4vNRc7g?=
 =?us-ascii?Q?DcJE6xjlJwO3r8+oBHir5OyCtycOamDI8LXEWraXnPVyMDUQk/iBqS+rais6?=
 =?us-ascii?Q?G3yKG8fCV5oARZBLdF9s0H4oBsm58bbdM7HTi2Wgjt3vfAOOz+0HJ0hG/mZL?=
 =?us-ascii?Q?ehcqpMaa1Vf6dWcxxkUAvTClffM1vIYcGySFD2bJV5ABTCLoDZjoCViNYHao?=
 =?us-ascii?Q?XNUMahfvZ9+DtySRwnRAyAFAyewCIT6geXGfA89/4HwbZPQUfUuuMC+LfLlp?=
 =?us-ascii?Q?KpyTldFbGaCZWjrOf6zm/BYcw9bIiOt1DZsnwOrQMrBnECsCqc9HyIu/7ngs?=
 =?us-ascii?Q?9YEkWwHRiVrPV+NGcB47hDgS8OFxUdXmLtFuM95GIefzQnJtNCZzKseCk2qd?=
 =?us-ascii?Q?FpI5okjxjMChqDqxqKsOVNVgQ3FYz+oYp+aVOQJm6aOzbl7V3TIFMqBp5Yc4?=
 =?us-ascii?Q?O2H5+uHbtTGE2Bpxr3so5m6S/KRtSfVVlShnEN4fN4F4i+lYQKUmUzGZqPzx?=
 =?us-ascii?Q?7DBSJEWNKwoHObJ045kyIpE4WBxn6U9Je9UOZaJfWukmGRmwkzI2V8AVUmLf?=
 =?us-ascii?Q?IrOqKBGlPgkyeZQf+5hyFvqMbDoiYBYKWduvMdA3yDnfq3gYyHME0yMl55qX?=
 =?us-ascii?Q?9+sQIJi5l0elFMHuYaBDHp2uICSKOXf7IBdXN072DATrYIIlQzD5UG0LZQWW?=
 =?us-ascii?Q?bzElCXNdNyoYiKrq78Mky5O6T6Dot2ZT53I6GbxU9sEf2/lXarHLTXpTdyyZ?=
 =?us-ascii?Q?/QMMDALf/QKSFZfzH8nTSmzVOzSqbYlaSPDXd1wU/qkPicBmoY+lJqhv/zSV?=
 =?us-ascii?Q?NT402PwoQmRJiCLY51jBfeZNkgbYPPys/WhTUQiaBwgi38416XDGe2D2/Q0C?=
 =?us-ascii?Q?Tk6EIhTjqyCvXZYxkonQFBi1b+lyYpRdABeaAggXFNeOGdBm9dKy49Asf/s+?=
 =?us-ascii?Q?l2B0sYR6j4Wy4Nu0dcAIxRDx3M94aoU0AQ6hsvKTZQc6jZCA1ZgAxThPVWVm?=
 =?us-ascii?Q?/kmSYPPVtfVUGUF+I9HYEUkfw9fnq5N/02AlUVNf+dxuEOPxpAHTXrz+I2II?=
 =?us-ascii?Q?l3XqCGMdx9XAMwdlDtOL8Oi3mn2wxU8sSAblWFH+rA6I+PDGEhU9bnzp59BQ?=
 =?us-ascii?Q?K8B/+ecTh0DDGUnHrAm3Ki6yPaoVqJVRK0KreNuIAZqGFCAFBNS+3FqUfSYR?=
 =?us-ascii?Q?SwL/y0REsxjxbunJ0teiNodqZZz4tqhFS5QJwbz31UJzgRrFhXBAT6O1hErV?=
 =?us-ascii?Q?M6B94h26IDRWbpKMDhmlykd1I7jw9lZt6PKGc4eoyl8PctgGeiE7toAZeY8w?=
 =?us-ascii?Q?ZlQxZxd35OnW/YlRhiVsy+GFQ6hq8W1E/R0d+OjmNxVgrkoVbE9LOnieDZ4d?=
 =?us-ascii?Q?jUpuVvql8EcYQ6WGj7J4ozUjTF858P1MvW1NUo/mafDkWj34MufYq5d5XK/M?=
 =?us-ascii?Q?hgI+XxBLj0/gaYudLcmOGMFrZPRjDf9IJFRz0vl2fumPtS1rcsifrCgu8dV9?=
 =?us-ascii?Q?1a2zbxRpE9Ot6VApdiPGA5qb90y5UPwIxJ43VUKkSQXkIFPcIn9uz3R5w4rH?=
 =?us-ascii?Q?wZ9rdabfrRdFUsTWXFUDrLGudb2ksSs3ZQ8rHNAt/Yw0G80Y0rmWH1SnWKu9?=
 =?us-ascii?Q?m3PeZ3PkKTN2XQMiPaEwxbwoRNkYVjN+WzDEHN4DUiqyjs75wIL6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2582fed-19be-4859-bd73-08df39bc0169
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:06:15.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNWTjf2epOZLEnFBr2Z+QE5d+U4pkJ5qNUPmRdQt5EvC+pk5khPVSxMPUM+OfbAAbiCHLO8w3WGdsiHEyEgWdCldRyLOUi8MW7aITROiBprduhZW5c0/TIiVFKiSlM0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8656

On Mon, Nov 02, 2026 at 03:28:33PM -0800, Joe Damato wrote:
> On Mon, Nov 02, 2026 at 02:19:16PM -0500, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Replace open-coded assignments to callback and callback_param fields
> > of struct dma_async_tx_descriptor with calls to the
> > dmaengine_desc_set_callback() helper across net drivers.
> >
> > No functional change intended. Prepare to make struct
> > dma_async_tx_descriptor private to the DMA engine.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
> >  drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
> >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
> >  drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
> >  4 files changed, 9 insertions(+), 16 deletions(-)
>
> [...]
>
> > diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> > index cc6ace8d64371..1479f8362e04e 100644
> > --- a/drivers/net/wwan/qcom_bam_dmux.c
> > +++ b/drivers/net/wwan/qcom_bam_dmux.c
> > @@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
> >  		return false;
> >  	}
> >
> > -	desc->callback = bam_dmux_tx_callback;
> > -	desc->callback_param = skb_dma;
> > -	desc->cookie = dmaengine_submit(desc);
> > +	dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb_dma);
> > +	dmaengine_submit(desc);
> >  	return true;
> >  }
> >
> > @@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
> >  		return false;
> >  	}
> >
> > -	desc->callback = bam_dmux_rx_callback;
> > -	desc->callback_param = skb_dma;
> > -	desc->cookie = dmaengine_submit(desc);
> > +	dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb_dma);
> > +	dmaengine_submit(desc);
>
> I noticed in the above that the return value of dmaengine_submit is discarded
> instead of stored.
>
> Is that intentional? I suppose it might be because AFAICT cookie is never
> used and the commit message says "no functional change intended".

dma_cookie_assign() already set desc->cookie in dmaengine_submit(). Of couse
it is not obvious. Do you need me update commit message to descript it.

Frank

>
> Reviewed-by: Joe Damato <joe@dama.to>
