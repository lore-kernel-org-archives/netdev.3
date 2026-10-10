Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53DC3C1F;
	Sat, 10 Oct 2026 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599179; cv=fail; b=FRaI7CX5nk9edF1q6uJ+aRqCQtz2bjEuH/CdIX0j+nukvFmfbPPpOFdxKqL8ZXkUexIIQnUWdDVvQz3oMHJrsKx1rkSLO81pnTJMDOusGzx8NUXco6r8jEUbPCQCCFogjMU+h2EWGg4jEELjcTPBLVKQCGV4URcpURDmIprDR0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599179; c=relaxed/simple;
	bh=3QnwyBVXWRFDFFukZrawyXg95y1pmwjzav6RiCyEAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4nx/qFGsi2RvSUGnfsZ909N/jfLa7EaHDr+d7/O7AXVRxt7FvfNJ7rMP/YThwjuF+ZXK+Fmt584lvh0pqmuECLkSZRKX7YERr3/sJMadsdVgih/bL365nO+mcfmd8BKscIoo1KQy3eOA+HZqp0+G0WfxGJxzIQOi9jk9f6welw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ijbtX0r8; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ijbtX0r8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u70+LYviNDJSTAyKvakelBKdp9Th2n87e9YaAa/a7NzRkzIRsqjdoWOfge51IpBPfurJD5Xf2+yLVSNq4Rd0z4Sg7Y+Z5YDGP5WKrH1/iqUXT/vGWHIHOGzB3dfKeXpl31isdLePtoEFwIKmCWvMNU8yNBz0LgCcD2VYlfBZqqfdFe+YOUfTaOsD1aKLL3lmUHqmBsm5Mb137EZrQfwZYp6kazCeVjklC42D7V7XHf1drRvKYxvczLZ1FiiFJc7Vgn0Hcn9a7ILWLTdu9WKFrLDkIBGFJ+Lqc1D/Ng8G2mMSUG9gTtRxK0kQmb8tSKlkRF1WiTsXVfIcP4jondihqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af9SLWlzUWPbLhcB9r3oLQh+9ekeycZjmqqqlD9CPws=;
 b=qKobJiNCZW+hsmTMpyooK57t4vKpos1wYKXz9hz4tGeftWVXgpYw7DKoldUiYre83bpZ2qziXrfdymMRxhmA86vf8kfrnuWD+RbA9XxwMHZ44NnmXyE5Fwv2PUpj/b7XX5ZBBXUdj8T7LOysSHbx8WLApz6k6EDE1DWlIKdn0PcJHAjzo81Ugh3alArbZEIQsB4g59D6pL0byqimD+JICDqNsSeKu90ilvM8SDcjdn+wbXWQjqZXbotSHzqRPbCF3yATeuD5qvNBd5uZDP6m9Co/+a4Z/dTjRtX2bnruWb6kn9proZ2du3f2OSFY+N13JLr+NWIU7uwVxKGxt8M8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af9SLWlzUWPbLhcB9r3oLQh+9ekeycZjmqqqlD9CPws=;
 b=ijbtX0r8NPe4uv/JuyMi7wNUoZgA20M9fh4IpBUYXfi6knV++pIFqlatwTt9OgQuG3DHf3tRSn33rjals0jWGKNCxhXJxwBLjnb+Cc1vRzboHAIwXOJAUomTuNrqPYBI9fQ0mlx0rLs8o9SfUvY1Dmau9Y9B8LgNudt8tjQ3K9cPTh21MvXXWWpa3CPq8PG7w3pp5PFAhZbVqonw2XbquBGsKZ1GSl4i/5E+ZHCwH2IL9XNXLKHgu+HNZxJO1QrRYiapGO/VbyN1Mh6CzKwy+Jk/676wynFQXipU10ojSiVMfs6E6npsXoo8gF+5F1VLu8zIcEY7l104mdczAdV45w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8315.eurprd04.prod.outlook.com (2603:10a6:10:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:26:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:26:13 +0000
Date: Fri, 9 Oct 2026 21:26:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, s32@nxp.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a DT overlay
Message-ID: <asmiQded6KfagAcZ@SMW015318>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f.1791548316.git.claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f.1791548316.git.claudiu.manoil@nxp.com>
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 141cff6f-4e2a-495b-47c3-08df2675daae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|23010399003|366016|6133799003|18002099003|10067099003|22082099003|261009223027099003|3023799007|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	3OSQfnkEXjA6MLZ/C7s9alqlqP2HfiSu71TX9OtLCCkN6kE016d5c/ZYfyOcAUd73mneNHH9Hu0pw+B17L7DR7jSBn5AMRAKJmX+XT8gIa7ypfM6Czd+USl05HiAzu8ea4zXdip5QeFMUDAoe1P1Gr6Ob0HxzP6YEkuEFigjIvwK2034U6suCr1qW0xPOH4WMjdsknoChrPmAcgEfSrL+2S1P3cqhD5tV8RH1hkikJKqZn2llB/afArZ6Gds5SF60Ppwfpat91RESJbLwG+VBWYoYc8q/yoVGCtcC7U3az9x8MyAvsPW9oyE66tzCBXOOU21eOy9kkoTjwnhwQLaWboxp0hlgEoVClkCmcS6P6GuJDc4fwG3m4bxLocw/XycJ4drjUAdwand2ZuaaxgnnflC8RN7pnLfDY8zKKOl2coK2QOsN0BZzVo1DxVy9EN55L7FmlBZEq0rnykzEG10wdFINxAwDFRDJoBYipp71oEI980uPN4rYWfduEQBZEKP3MSv31/BILPQSTz1OeGkuxsiKODwoGMARX3YPwh6azzuYDpS63gZkQbs+EZfHeHFHLUioKaE75UWQ712kAfZ1BjIyv24vIccwCV8Zh9DrQB2D/wlqkc6iZaTIzlmPHGTw5KZE4P4vYNVcrFu0uuxSDQMhE8A9WhzzDMWVPAU/LU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(3023799007)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrK3BtgOS+7D09fWJko4RQAqBp/d2vmDUo7k9ZiWrv1CbrCMRK/UMV8HbQIX?=
 =?us-ascii?Q?a19oZ09QbzGGkYjTbxtbp5ZQm6YB+aOYvGKSBvD6cqiMVUSq8S13gUAwvlD1?=
 =?us-ascii?Q?DkIb1sQdF/pjE4wbPhwfobKw9pT1jF+ZcT9c6bQk5aWYuYuOS0oV6NPeFa3r?=
 =?us-ascii?Q?MmVWUmeCO5LjD3WW2mfSC1QnlArNEu8SPGmino4YgYi1JtB167pdyDSHsHHP?=
 =?us-ascii?Q?a2B0jDpJZowRo30Mdc/4SPlEL7ug0Jc/YotUOxRQ7WSVSTaGM0WlwA1Q3/Er?=
 =?us-ascii?Q?zkDYRY/u55u+spGctuV1I9AIBHfxFUH44myrnXd3hMG567uXu0BntUA5lRJZ?=
 =?us-ascii?Q?X9Od/RpLEP4xLOgqKKVTRjyC4r3+Sqpir87aIaLQX9xl7QuEYoG+JTzJJ1/9?=
 =?us-ascii?Q?DpNVciqxDyKaEb2AvKyOkHizAsyvbTjvr2DJT3waB2ZkWd4pdqMp/mbGofk5?=
 =?us-ascii?Q?lyCmMA60GElYCCJxNpusL+InjgbA6X+SXziz3j+5uOVVBYBQ4YjsODU8OjXG?=
 =?us-ascii?Q?Jq7HGEyTfeCY5JeUYPEdoKx5UdZrJpcvPpcyNFJmkmMsa7Xxx/vwc2kegQra?=
 =?us-ascii?Q?R6vc72dib4V0IIytYu0kMEY93mH2ZWR/G+ovtMWLQDSmt9ClcZq4A6bpjnoK?=
 =?us-ascii?Q?x/iN7cCRJ+IWBQ2xmkYJl5LUh4qKomwwpA3bZNrr3gbBLtm9N+NLkjvm6iUN?=
 =?us-ascii?Q?hx4cW9ZDgdV2dRiZuaRk44NJc3/+lELJeuP5vlwjTwqRykIzfaXIru7wvc/e?=
 =?us-ascii?Q?A1vr6GEkjg8s+60PR0e8YBymteYzSL06Gtys7lfkUUyHQJ2cvcRSMj9prc8L?=
 =?us-ascii?Q?oSmcPwHM8wZjFU2H+lsBnYWP24zi9p8UtrLXI2KmCx8dqhutd+z+WcnXa8Z6?=
 =?us-ascii?Q?asr85QPSBUK+wznMAISimezjLUbVDTqDfbRNjHMWHvMySupIQXmfXXAsrAVl?=
 =?us-ascii?Q?oEwI7OC1ep1+S7J7RT2p+o9EGkTZmiI2YbFNlrHFtmNDQkNZOjKXjM80NjxF?=
 =?us-ascii?Q?AaLz9SJyh/km6tqhESBSMUNS+L9YAIGwvvy/A7vZaJ5r1NiNWsZHpryAi7PD?=
 =?us-ascii?Q?uRs+81h378EG4vQeszY0n91SBQ/WjKvOS5b4hwbaC0KXG/sMjHClaqxLBmeM?=
 =?us-ascii?Q?H+nBxxUxA6bI0HNXX/dPxMcf0eisHLOjhNmx4jNbvmWel8lh8XnBvA3jjjel?=
 =?us-ascii?Q?9bqsRm8C3+ua8AfgWaAS2cyWcfAA1JsDR0Q6sWLGdqSmRLm4NwcljRPN7aQn?=
 =?us-ascii?Q?AZ0dTdOOnXUc0hKSjmL2A+6qU6wm/MURZPP+6DrzmgBLeC+7jU8yB5gWkTUs?=
 =?us-ascii?Q?UrtYqgp6Oy5snT28e25PA40NTgjAe9OmkS5+vchQV5RxvUzplS85XRVFckO7?=
 =?us-ascii?Q?vCrl0gCgYEFs00oh3avTbAzpLpwlqp1Wc0TzDouGLvyGjCAwG2LHlVZ+yZ+N?=
 =?us-ascii?Q?QqueVdsveHEVZAsIYQk+B2OJfs0/exwNpgelBM2fywnKpO0PrgJ/P6xUmXOT?=
 =?us-ascii?Q?pzoxeMLC/PF0ii3LHM/iS/o/Ymz0mwhwL0Iw5BGYFKW+eStoYd1S7IIW0gOd?=
 =?us-ascii?Q?kDHQTP1Xol/hZBzXvc4dMeiQ3o7UUVdIRlmA+56Ejol9+9v7xeZFVDR4OaDE?=
 =?us-ascii?Q?7RlZQKngMQUlOgPanHtE9RYE3lIVEVGjP6H1uIZV+LEN/D3+vybw+a0Om9S6?=
 =?us-ascii?Q?1dwbJj4xpMFB+81ivDp9rDUhMvsUNeMRntKkNYdeaq0HYpSXu+dBdfRHr1RT?=
 =?us-ascii?Q?k+3QJQn7ajhBlAjJ8sjyhmH4c7AW8HziHktRKeO1oQyT/VjhZAR3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141cff6f-4e2a-495b-47c3-08df2675daae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:26:13.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBnzATsE2ruFzdFNw/mvnvCQW0EJT4P5edSE8F8ntRUU/i+0aq8ch0EnNOcfVsYQo9X6Q+xmVvD3BsBXd8GszkZKS+9HhGsQBJf+dBngRZrujQuIJJuTaIA4BMKzyibo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8315

On Fri, Oct 09, 2026 at 03:40:30PM +0300, Claudiu Manoil wrote:
> [You don't often get email from claudiu.manoil@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> ENETCv4 has special internal links when connected to the on-chip NETC
> switch via internal switch ports, called pseudo-MAC links. These
> pseudo-MACs are proprietary, they don't implement any standard IEEE
> interface (like MII), and can be modeled as fixed links with the link
> speed determined at boot time by the Port PCR[PSPEED] register
> configuration.
>
> We also need to be able to probe the ENETCv4 Ports featuring pseudo-MACs
> as pure PCI devices, i.e. without any "ethernet" DT node representation.
> The typical use case for this consists in a board with NETC connected
> via PCI to another host which probes the ENETC. Note that in this
> scenario, the pseudo-MAC ENETCs are connected internally to a NETC
> switch that is not owned by Linux.
>
> Since such a port has no "ethernet" DT node, its fixed link has to be
> synthesized at probe time. Rather than hand-building a named software
> node, describe the fixed link with a self-contained device-tree overlay,
> following the approach used by the Microchip lan966x PCI driver. The
> overlay is compiled from enetc4_pseudo_mac.dtso into a .dtbo blob and
> embedded in the driver via the kernel's dtbo wrapping
> (__dtbo_*_begin/_end symbols).
>
> The overlay fragment uses an empty target-path, so it is grafted onto
> the base node passed to of_overlay_fdt_apply(), i.e. the PCI function's
> own dynamic OF node (created by the PCI core when
> CONFIG_PCI_DYNAMIC_OF_NODES is enabled). The fixed-link node is therefore
> spliced directly onto the ENETC netdev's fwnode, exactly as if it had
> come from static DT, and phylink picks it up through dev_fwnode().
>
> The overlay only adds a new fixed-link node; it deliberately does not add
> a phy-mode property. A device-tree overlay may only add new nodes (which
> are tracked with the OF_OVERLAY flag and freed cleanly on removal), not
> new properties onto an already-live node such as the PCI function's
> dynamic OF node. The phy-mode is instead set programmatically by the driver
> (pf->if_mode) before the overlay is applied.
>
> The pseudo-MAC overlay path is selected when the port has no OF node, or
> when it only has the empty PCI-synthesized node (OF_DYNAMIC), which
> carries no fixed-link description. Ports described by static DT take the
> regular of_get_phy_mode() path instead.
>
> The overlay blob is applied unmodified, it only selects fixed-link
> mode and carries the duplex setting; its 'speed' cell is a placeholder.
> The real operating speed is sourced live from PCR[PSPEED] through the
> phylink get_fixed_state callback, which lets the driver override the
> fixed-link state at link time. The overlay is removed on teardown and on
> the probe error unwind.
>
> The driver gains a build dependency on OF_OVERLAY. In addition, the
> node-less pseudo-MAC path has a runtime dependency on
> CONFIG_PCI_DYNAMIC_OF_NODES: that is what makes the PCI core synthesize
> the per-function OF node (of_pci_make_dev_node()) that the overlay is
> applied onto. This is intentionally not a hard Kconfig dependency, since
> the ENETC4 driver also serves regular ports described by static DT; when
> PCI_DYNAMIC_OF_NODES is absent the PCI function has no of_node and the
> pseudo-MAC probe path fails gracefully with a clear -ENODEV error.
>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
>  drivers/net/ethernet/freescale/enetc/Makefile |  1 +
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 98 +++++++++++++++++--
>  .../freescale/enetc/enetc4_pseudo_mac.dtso    | 32 ++++++

Not sure why need dt overlay here, there are already dymatic update dts by
of_changeset_* API, like of_changeset_create_node().

Frank
