Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E349891A;
	Wed, 23 Sep 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175954; cv=fail; b=C/vjx/bqOYlLLWTM7S5h3S8ed2rmY0EDNzvhMnS24do+ZozdsTIFSLXrnORXOWtYe4P3s7LAcn83wcYUs8GYiENzuhdRaICagpmZEGPkIU3kl/EGkjglmM11GijNs7wcH8vwb/btiNqeAkTJhv8wtm2aeq7Eq71VuzYsH5nB0ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175954; c=relaxed/simple;
	bh=82TZ0TNT9Z+iYSGJPUhMDeclp17TRDrUgPv7/XTUWGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bcbFeoN413NzdcqMWcXjOtn1UwTdl5X6+NfdwF+lAbacx3FA5cwoNDgMTs0HXOaiFgGeUheRTPoZm3giAvDexuSLdTbY4ZD4+5sRjXitMJogpT3N5mF78qmNT2aNyEMVUhlymy2WLpK/cR/1HK1CT2hj/0o+mQd5wdbHmfNjYWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXleVRVg; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXleVRVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT7t9wwNuXg4t3TnZRLsi+WEjCxbVDf2sfsixAOz3jWm0Ob7ijdKkjhsc+2u0HJhlZVRoyRGSLqEDPumUEFDwADDgkN4Lm6XlQnngdUL5oQjBvKO3fZYeE52rZpTtIC2+OjMSUo9xgaFmuEvwqv7DwlGfYwYaGXMY7LKTMJ4ADO7J/Br2YPGXiOUjchCv7zNWWZ1XfYuaN9JWn1Y3ZbARt0A/pBN3XVt16oA6Qt/CTg3AjyfYxA/ODjxS+Ut53+3GAqg5B5eBhlYlfuc9avU04523Lgh7Uu/ru1ie6khgRXKblCj95Gxy5cO8s0CMc7te8pXw9fBL37aJI0z20iAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kuRZM5jHC2qMkHjUdbPl3oLRjKRu1i3yyQovm5xoDI=;
 b=HdE/DPkF7iiqmfvcy3KoJh6IGJrmVvNmoSdMgO/HlIODp+bM43QVc9g+142xkN1WCIEmQApNaZkSGKpTtxDM6j10Ch+6eQQ9CmJ4sWhwCPc655yG56sfouGCQrIOAU0bJZOv4HW2Db7lnTjz0fzO63G8XUV7EFXR2f7CHr1fTgvBsCSooDHwdAL3kMklStyKa7WF9YMoQz+nHwoKY2VOviEqhMVV4sJV6eL4iK1xKT2qI3BDHmAP8zoYhrMA9SaPMJvZJViYeUL4fZ7kaO25V//XsJNpfDWcqAoTvwhcXwWx9V3QonVsgCOFb5lAyjVMuGykSI99NYlhUSxqzgPHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kuRZM5jHC2qMkHjUdbPl3oLRjKRu1i3yyQovm5xoDI=;
 b=lXleVRVgEpiR518NhS7u0O3hdvFucjQPFHGBDbY4OBq1PDRNTsEUihNUHckiwAU8BzGSL7fwLMjDzrtj0xTwsml+bfjQmwSoxsSsigcdS40XdAxi8ZsjFJ4/5LRxgSBGdKvl4BNqTQwLL+J2OP0UnMWcA7M1ERXF8xQTXHQs6njLgZIRzBSjpKBVwk7rV0eNV9egDWr5LDJNFjGjAFjqJeus3bG/eTRYRqoeygwbJdO3xGIZQR3HB1w4DpbrWPEPNSO3loXUfGd+hsoaSTIHTj4E76Zf0BGTJFckMRjg62bCz+mQ2/iokRIwkA3XjnoiyahsdgOl0YiI7YyFbbCcmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by BR0PR04MB538501.eurprd04.prod.outlook.com (2603:10a6:2c8:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:05:46 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0428.014; Wed, 23 Sep 2026
 15:05:45 +0000
Date: Wed, 23 Sep 2026 18:05:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: pcs: enable autonegotiation for
 10g-usxgmii
Message-ID: <20260923150542.jo6inqtczwiignln@skbuf>
References: <20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c@gmail.com>
X-ClientProxiedBy: VI1P194CA0050.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::39) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|BR0PR04MB538501:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a31036-4be8-4308-4b62-08df19842508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|10070799003|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	H1C32XzZwdhb3yKsH+VuRiq07M4KJJ/qU08MC6XJE9R05eXX98AeatxPv4HonAwmVs3rStsWDEwLd0Nh24fucFpLOW9FmeY97fhNjmJQaW1oeDy/0o4+pcyCxmLgiQmnbnFxlyHuC7v5NJr+VO2ihgkzRtbB1xwcuRxtPD4dU6ZDjP1+lxN9XO9c97X7a6XH6kf7BtODavk4+mmwIGbxmBpd0o0VqzMjLXwrwSkNd9VKGYJ4xc5/QWWH6XL26XeIra2kkjz360SqQl5SRZfwmGwxngPeEhQBkd7Q2Onbnda+lYvOBzWq7q5y/diuA9DNfw6B2oT/NHk7oms8PhrpnbqHSxNuU8J/kOLxQO8UB2Eh53dQq3VTJfhE3K/A1wA6IvAWgRJvhhqRvyGtiPPTJ1v8UOtg85o2X/R1EQBlqGsl79UIZdOFtE+HfSepq9FCu95NyIK96kvGmas9ijlpOxoI6sTYl01xZAdbYy0MWCV6wvarObAwwjxbcuQlCHmmBVDWuaGYfpqx8nRiAmh78kIFQu5vNj+9JJbNBDW1NaVhqym/sC4QGOOhuMl9+gags/siugMtMdMMhvobBZ8kS1tNR/DvbCVzy/AzOs+NWpHZniePUWAdciF6Njizu7yGF7JT7+QlM6HDRyEW3JX8v6n2wHche8/jid4QrTh+lfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WR8yCV60OA8UmYoG/l8ME30h50XzjvJIr97QmkTOL/SJAFoxv8baSszvDhIk?=
 =?us-ascii?Q?09di2iqAaTYdtnnORjTNnYxOJep13RPJ8qRCLTGdTx0thsw4K5AIb4pxD74Y?=
 =?us-ascii?Q?doAxiCFlW4YU9ZIVUNGZU0y31HfOxjC/XCwn4Mv6NCdpqB57hDVibwvSJp22?=
 =?us-ascii?Q?ZUmIC87c/LN7DR37GLArfDRVtbbEZ4eqBRTB3I3BdSVEnkZmI5S6gd3LmYu4?=
 =?us-ascii?Q?cu/ZWbBgtVq60xf2rx8hloQQkpNoY5sDY73OLoNLFZ7NVwmosqt3RMN0hwzw?=
 =?us-ascii?Q?lJAbThnouKQuIvJRO0hR43F5CVSo66UmlxJf3PIgkKE6UXCd88gv4B2kuHEr?=
 =?us-ascii?Q?tdgYUYR1HVzgyinC4KK7wc/cXZI2G/8aOpOIHCtdGjp4YlPoGZivewhiVsih?=
 =?us-ascii?Q?8x3N5qU5tqFWzY+XsVyOa2CdfXbGUd6m/kQQiIF+XFlOIy+2uWPZ9uopMAuC?=
 =?us-ascii?Q?MeSuAm5JGS28NzMSyQcIePlMZE87PiGhx3rjgdevuzhgjlpUtP2ztjOuuml7?=
 =?us-ascii?Q?C4kPJh85R71c6V68W7RP+DrgifAFitEEE08UodS38RMIBIwf44kWxWNonP7P?=
 =?us-ascii?Q?eqsmb/w8lpSdDXNqVtGzSzzNSfNOkWAOBXg9x9a44X21Vnxy6NzZMW09BA5s?=
 =?us-ascii?Q?AAXbeYG47fh1d5Luj/63arAD0K3wXD6wOKRy2W/T+b7NOf9s8EKw0yZUSgrE?=
 =?us-ascii?Q?ci1QdBI60F8aIrux8//1ZEmSqpkJLehWo9R6wznbGI2LNtFldnR4/zkCItk7?=
 =?us-ascii?Q?pkSrJyBuv2RrP3GHS9Te0ga8b0EqgjDyet3906KMB61OtyPV7qIgaPLh2FRi?=
 =?us-ascii?Q?hDOmwV0X+rtu4MxgsH5RIWoa4K5PcV3cYOq01oiSb6TGVgeOzn0xYi9jOucJ?=
 =?us-ascii?Q?6stj+KbD8mUF3xUBq5nBwNK9cmvSx+by6v0NzWg1X75sdIQVxK2smBcBSgpz?=
 =?us-ascii?Q?RhRekfnj9uGX0XmPXcuJWjzhekA4Lzk3G+WEhVhcsWdNZ0n3/5c822ulj+c6?=
 =?us-ascii?Q?DGk7RGMBxu9D/Uwt1tcG1Yd35fcJqyNz8/DBwXkwOz2Lgr1XbbectIRA0O5k?=
 =?us-ascii?Q?PnOtgBTcfHcP6LZZSNrP6RDzsD/YWHjahdbLl8+dAoreArqJcKE6RZmcJZai?=
 =?us-ascii?Q?2+BrV89Wr55WaQNJgY20qQbcn0prfy3srqH6RnRzVE2b1w/wLSaNbl+xe+1X?=
 =?us-ascii?Q?+/5H66Vfvo6A6OoJiy2TJlwNVQfgYabiFkpYuGeME36JhXlHUHBw/wpVjofu?=
 =?us-ascii?Q?RU9XYymshwdDhgqItp2zvzAwVl17elSf680shXBgsmSKtzYqNYsjbpYQKMFX?=
 =?us-ascii?Q?YcbF6QvX08WOJM9YeYefJZXKjPkBromYH082mQrnH62JGpLme1HK9wH0xhyh?=
 =?us-ascii?Q?8Au45VswnIbAo5fKofIB4JYJam98LmcfQpsJMZ26yiIzhEsl4qZcktaDSpBI?=
 =?us-ascii?Q?YWV2bhg9V+5p9yvniFByCn0ZntkAiHKIxPX/KeJug9VlDa4AuARUaOxVsz+g?=
 =?us-ascii?Q?EkqeS4Hyu5euvGck5GnZmx4Uk9srVJjfCOiu359x1uEbv9yo9ie2mg8lsztJ?=
 =?us-ascii?Q?0IEmBYoXME1wKIIS3IdKsbZ6nkZk8+jaL+6fhyRJfUiB6aDLezYdd+AQia5M?=
 =?us-ascii?Q?ZF/Kl2gZ8gfD77WdzeKKRPKPYX2HvVmHS/ILekIBDKaS8SKTrj5rOeTrxITe?=
 =?us-ascii?Q?aon5EIBBT5kQOvFDPWqvTNihsWA8HRC8BZ0hHAutJQTwY1RcT1E53qJ8i/eT?=
 =?us-ascii?Q?xX0OdfVzTxRGhThBSEqG0KT4JIpVY7aA6Rw3owJ/Ge/I+kXdlXUUEWngeMc5?=
X-MS-Exchange-AntiSpam-MessageData-1: TbfXLXatNnoIhLygAg4EL/JYME9yQjCZo1U=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a31036-4be8-4308-4b62-08df19842508
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:05:45.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxwNNwG87gXtjkBdJB1SiepzrOo9I6fwyThJVtCnsZr7xeFj1IXxB3d1jvPFSRM8f7gmTgGF7Mgz1uF0ETb7cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB538501

On Tue, Sep 22, 2026 at 05:54:46PM +0200, Patryk Biel wrote:
> The Lynx PCS USXGMII setup programs the replicator advertisement, but
> does not explicitly enable and restart in-band autonegotiation or program
> the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> After programming the USXGMII device ability, configure the replicator
> BMCR with reset, autonegotiation enable and autonegotiation restart. Also
> program the replicator link timer registers using the value returned by
> phylink_get_link_timer_ns()
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---

There are 2 problems with the commit message. First the prefix should be
"net: pcs: lynx:", and second, you say you enable autoneg for 10g-usxgmii
(which doesn't exist) instead of saying you enable it for 10g-qxgmii and
usxgmii (to correctly reflect the code). You should probably fix both.

Anyway, with both addressed:
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
