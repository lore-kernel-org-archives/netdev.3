Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395193644B3;
	Wed, 22 Jul 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707266; cv=fail; b=L2bdxOMvDz4hc9D8oKIqJgMb/tClWjp4eN0XU/HGuomCfYkSPjl2VrD8jZOju4Uhgj/0dPQ7/8iu6LseWe3J7s/37Alb3KfFb6rFUwWr3FdMBhS+IXSqU8yW8GM46+jd88qP8I5gaWI7xp7k/He9K++q4LM7qkNQWj/JQ6f9+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707266; c=relaxed/simple;
	bh=x5fjM8ZchegrJmBzcv8ow3ryrznBS9AbPHYgpGR0Yd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5pzD+KyfG+lIPQPXvSMP/fItbhFGFBs4JCJ++HwHEQufBw+VA0+WHLOKJEwlJBG9Ea7p9950IbkQ2XylNTaoUePTSW7KC26f0LyG81ycsM6kSwPMYmIGhHi7Guh/u/4Sh8fI/wQSx7KGaS2ykrwAaji0XGwHmwiWE0cK7o624o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B4Jf+sV5; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4Jf+sV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pojh4VEyG10DygKq+HrzCuPc4CPWC5TbwVggbe5L7FFQDzs/MCiyAdV5GpNGU8sEtn8xho04Usj670pBeJnntvEqq9A8T8saFyT8IuScSxjtSFWmJw7JV530vqnSgrPMhOZCnIdzuiH7+fb7eMsaXFj04HLxlSJMiwvrY/RpCSk6HaxCPsYzWQnysy+a9U253Ko0X3QMGobqKzBUEeRVJBlX6tjlCZ7rJ0Wdu2so2p5hkWiHqyPvDEuG+sTbutaaTAvQMot6umS1OBSCgmpZ8IBMuHWmLo10t8h5PrIe/22cNHlOMxSHGgsxtQAT3zcHBFlC30Gx8kwmxAuQLJ6mxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj1QmheiAyIOYxau45ixCtS0+gTaSJCMXCxO5PzkMTw=;
 b=MveYZdomQcWMg2xivHe8ozgk3EcSvm6p/tqN7+PO2Xcc/0Dcfhp+rpTWQ+PtbjvBfPKLEhvNY2iULTWEwdn2wba18ZCiRytcAbeieG+baqd0pAVb6MQ6lQly1qmrE4n8IQP0/kPmZy0fcyLYkrk0DNTQCmRLK5zBkdf/8DJ1GR0Ca4E4IUGC99zfbMGhOfzTJNosEovM37eJJaa7AZnF5WFj2n3NPU+TXK90RVuo78lD0jfBcm54c/JACDlYACs3lEYY5FQkz3AVJmoYbrHfZxDaLVIZHo6/GyCoJpWQS1JSpdrRap8SEXljDht7Q/vsaa0GJ2UJ31eg92wDdff+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj1QmheiAyIOYxau45ixCtS0+gTaSJCMXCxO5PzkMTw=;
 b=B4Jf+sV5/rET+ZsOoEHWiEhMZW+j6KqRnXFQJYgdhdGuebjglQxxEpbKBSE3IF6bUaNpz+KTbwrJEUm9b/07mEEtyrmX0ItrhvpisCGTCzpJxj9qJoW2yT+PEVSrvAE0YhjDSru6dqZNH9Azs6aaA8yfisdx9WI52RXlkKU0hkmmoXsmTqz0VpjoO6kUmw3TtNa4ZJurTKHybj/CAXbARnXuXD/gG9D6HNoblFPCL6wJgSeepZ9CWqrWmT6GjNDyxjDanfg43dOxBgrvujRB4PUUtwKoBZbvwGBw2e2J1P5T6AMPTh1PEIJZMMOuwfAkEcwQkg99z7QdF7o9SCdH6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB12105.eurprd04.prod.outlook.com (2603:10a6:150:335::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 08:01:00 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:00:59 +0000
Date: Wed, 22 Jul 2026 11:00:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: kr494167@gmail.com
Cc: ioana.ciornei@nxp.com, vkoul@kernel.org, neil.armstrong@linaro.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: fsl-lynx-28g: propagate PCVT enable errors
Message-ID: <20260722080056.vd6eni74tscmxtpb@skbuf>
References: <20260722033619.10647-1-kr494167@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722033619.10647-1-kr494167@gmail.com>
X-ClientProxiedBy: WA3PEPF00000525.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::679) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB12105:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3ed8dd-2c48-48aa-308f-08dee7c75e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|10070799003|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lDScj+ewYuIsJLP3bXIVopsCTV0CpMztLzUsCLUAgLe+nrDeEIcPhMdABqhxzrwV4HmymbvUGwVGry0NH+V17f/pD/MS/By/6QKgg8tuKEImuAA+Iff0e5kqlhBjlXQo8eTW5u/hwC7Bs1fPxNIAlBN7PRichlJAJ2z4Z4mQsGFj5Tvkc6PAfo1rrBSH7keHwQrUX8ddEGA24SOarpctwciCvoW1ubIbIMi7xbY84Eze5rixkal78Uwlzx7c6sKDy3L3qa+MYVylrZZgD0mHrks5pI0xCWDb22KGTDY+I8yjOVnjG0wtv1ZiJOkBrKcrASmo6RM44TT25TsU0zPoxDKzReXp7rY0pFShUouD1YK3aw6ML8S3BwgWYJfWwJHvW3pjZkIvFUiVgkTnWGxBBk5bNk/6zxnDkDf/LqcyJCeiulhD905nBIJuIVwsT5Cno99xiiX5ETPuMg8gIyK5siQyMfhWE/XCypwqXsmnVrTnIcWSPuxE4USroCD5ax7sIC0QK2T4xYY04rqAd6Sr2U8NV342W+WhxKHIiHTT23IqxCcKaDjYVfomcoAL09aXiNchztb3A3kryJbJDkKGhaELONoqbJPKuNLLUlOpVEjYkkZzZt3LdKVZ3KfNOoXBLHs3xSkafG1L4iPQpFWe/08rMOvc0SlOo2XAgoQwOgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(10070799003)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmjOTdz8b6VnkRBXtACmHBo1/z3z9oAvDdCrLsHsngTI3y6cL/q0i/2BJ7C9?=
 =?us-ascii?Q?LwJRvP22qzXdbdZylxLQxQ/qxmwfaKb84IID4IMeABwo+sP/L/EE57OgGOTP?=
 =?us-ascii?Q?KylNvYSR/fm0+TX6TjYt31IXPJnmN0O1PwClAEK/e1XM08U3LcTDkIUYeYuq?=
 =?us-ascii?Q?Wh86IDqIhOGK7BFHd1MsW3ZikMKiErTFgsW/Aqkv5Kt8wujVgaf+J6QZ5EZH?=
 =?us-ascii?Q?793eVDVkqVlbKZuUXln5WZK8sZ7WumxV7QAHfLQdJeACPtRdBXm+Eqn2dRTi?=
 =?us-ascii?Q?Li+MHV1oJv8fnIiMRx5llMEYwFEuyykga+ubvaRoJ89mh8a/rLfNabZoYoYa?=
 =?us-ascii?Q?CZL9lOWqD9ODYzBHXYIETos79LgEnn3SQPbcycc5FjZEmYti1/7yaOPiTD94?=
 =?us-ascii?Q?KyPoCt3YpoT2LtCkWRogr1XQhuvDRB//YvhcNoivQxQ/UfOvcLMEP6GTkOy5?=
 =?us-ascii?Q?BgMy9Q5Cqe8AL2pR5FBazisqLLotKioGzhXr/Zi6d5HulUr3M99Eg7zQPpEt?=
 =?us-ascii?Q?Pw0byZa8js35SHoDZn6eB8yUupSFIUpR57ZgX5BhISJcdXiOsAhjdV8CkKZL?=
 =?us-ascii?Q?V3UVO+E03O5s8RzgRSbg8eaLGMdf++7aJGNLy5dbM/Gfvd3xHuYtQ9eh/fD8?=
 =?us-ascii?Q?KLNG54y97b/QLFlZlssxROdTYMmLYcnZu0lsR/4H1w1daxm4LrOUlD0kMNoB?=
 =?us-ascii?Q?fioaGl07bBZjcjGwOacs+4rYY7n8LeqnxY6AGF+PN6WVYaSxEMs4q51/t6Nn?=
 =?us-ascii?Q?HU7XWFC5sb5hlZCjAuFYuJfiPGegRyM22KQWmXS54aChGozu0588X4fK1Qg8?=
 =?us-ascii?Q?DYaN3qfa3GGEeYKExsDnIx9ogtXcoSmkWwqY6er3NWiFop8SQyaIWfbqL2kC?=
 =?us-ascii?Q?Gr03Ny/vRs323YXAA0v2pnczOL+6/OAjfB08kjNee4NkemescrO/DN2eAWSg?=
 =?us-ascii?Q?uawVSfSkyTuVHw8E82n26G5vYYk1d5HaoA+JPAmmBPgq/H0MHU0HJAhTPBhC?=
 =?us-ascii?Q?p8+7+W36KpDsBMQFkQ/trJAwboOC7M0V/hhLvYkLJvhld7SgkhxMfhjYf8Ox?=
 =?us-ascii?Q?JtHppMQDnGj0MAblfuB3+rfEOkM5fYEz1KC3CYoBZs4DdHSja1kTSgp30Bcy?=
 =?us-ascii?Q?NdcvYjoF8J6BcyjUpgFmb1DZX9UcTy3XCKRYTEqHbGxb9E+yfay6CvGSRkUP?=
 =?us-ascii?Q?x3oCBJ543ekl0oce7sWy6LYmQGXmxNEeyfAVvc8//GIjM37HEkx50d1ZahpS?=
 =?us-ascii?Q?CpxURXEmneTXycWw4Sz/AGxznk6tEDucGKjgyfwqcSkeFPwEAaZASQCOe4uv?=
 =?us-ascii?Q?2n4b5zzE/lcwRo9s7Yoc0N2B5yNqcoWqkrNWOsyEiWfy7N84XsDrATRVs9NG?=
 =?us-ascii?Q?owd7pvCkoRSxt/5f1eRoRSVqUooYzsg+Iot21dEkG4edaUFl5v456lpU9wm9?=
 =?us-ascii?Q?RoRhlKIIuVNJIG9lFmFEhbBZLXrkfUbMkl0l7pq1Mj0V1CXc8AP5fY3BUz/7?=
 =?us-ascii?Q?esfIdb9g+bZs6JaRsimkJtHTQqsgM14Y93v96TOloK6/Bo2PtejSnrq1D8yV?=
 =?us-ascii?Q?hpA/5rCHQcTU7rTM04jGu2pLZt0Zkg0iBkWLDkSLdEYoXeEkZV726BXkiTYa?=
 =?us-ascii?Q?BkTOpTrto/1tfVXtEkRKv1sgFtvfWo4wAzea+BWu3nBs3yFwoBYsgVX3a0jQ?=
 =?us-ascii?Q?Gsks2a1reQARCEMM+3XPxMEtEI+ZuUlYHWdMKSj8VTrSMUOwOD/NPWeIK2vo?=
 =?us-ascii?Q?VihKUuIJXOPS6Dml8IowL/U95/UCZgGZqsOAEqXoshA7ofl82jxC4jgmgW/M?=
X-MS-Exchange-AntiSpam-MessageData-1: yGkXGHg033JFk1LpZIw09e3qFCgsQcPmATM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3ed8dd-2c48-48aa-308f-08dee7c75e12
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:00:59.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lndivna6Azh6KbGFnIhV9BunXAZ06EicMuNM5BVBpsjJo626nrXUlibavlW2se7kkvlHefbW8Drng2yQwdfK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12105

Hi Surendra,

On Wed, Jul 22, 2026 at 09:06:19AM +0530, kr494167@gmail.com wrote:
> From: surendra <kr494167@gmail.com>
> 
> lynx_28g_set_mode() currently ignores failures from
> lynx_28g_lane_enable_pcvt(). It then updates the lane mode and reports
> success even though the protocol converter may remain disabled.
> 
> Propagate the error and leave the previous lane mode intact so the caller
> can handle the failed reconfiguration.
> 
> Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
> Signed-off-by: surendra <kr494167@gmail.com>
> ---
>  drivers/phy/freescale/phy-fsl-lynx-28g.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> index 38afcd081a2a..1fe406adc83c 100644
> --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> @@ -1003,7 +1003,9 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> 
>         lynx_28g_lane_change_proto_conf(lane, lane_mode);
>         lynx_28g_lane_remap_pll(lane, lane_mode);
> -       WARN_ON(lynx_28g_lane_enable_pcvt(lane, lane_mode));
> +       err = lynx_28g_lane_enable_pcvt(lane, lane_mode);
> +       if (err)
> +               goto out;
> 
>         lane->mode = lane_mode;
> 
> --
> 2.55.0
>

Did you draw any conclusions from the feedback you received on the
lynx-10g patch and decided that it doesn't apply to lynx-28g?
https://lore.kernel.org/linux-phy/20260720101906.80584-1-kr494167@gmail.com/

Hint: it does.
