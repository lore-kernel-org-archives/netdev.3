Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30662E7370;
	Mon, 31 Aug 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171627; cv=fail; b=YQKVXIE/Qnp66lLLqqDTp4+jHMABa0eMrB6Di6E9sb+DDwbmyeKYVpJLUe9XC9szps76iVQRuJC7LjwnrTySMm6JmQ+OcalztdIIyp8uEZx4ckId3F+VkIDESPrwPS+JSgstMAHinRoLduO7r5JFz91W7B2amXndHMMrh6IFo/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171627; c=relaxed/simple;
	bh=q532oHGLysMBkVa5GhQsHR54QpWzU8t4PejPMdfPw4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjo86Yq9ymMWLe9C9DMPkwu8HLzXxsNhi94OJmlxYoBbvNPzdy4h163PugvSaNiZnlIqeekjOvBpC7Ai8QIrgnXX/2Td9xsMiTPbGatxdNgnmIyvqoo3XGe/cMNI9UA+DsHjnmAlev0lcJhQSnOIBW+twM1lnLU7p5Psb4Ww4eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAmNL5ja; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAmNL5ja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijjheGC3hmUW5QoP/BX8ItDPOaUcmxzy8i4k5TH8QkGjVLdeIqhotHmxgsyKcUOvSiiJKycRnD9idON++qfRukUOhN0RQkMep0PDJ53Et6EL9uuIeAONYjQe7304NHHvZitAXZsrff4L0XIlLhiKR8o3bnCn7Mhvqpqh00gr3plhMN4PbXmaKO0tGTftjfgSg6pn/orHJzvDOyhyWy2jQ4EhUraCVUt5fOLxOtu3uFR6dJiSwdleM8ixGMVZzbu9TODWESpcLxfHpdrgDOcjMRayYrr8cpOKmb+uP/1Bz7hO1coID84EdzafSA02CNNY4IcxknBHml7W+jkxzqP/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMlvYt/o9RAcXRI+fSPcFRCZdd9s1aHRvT24cJ2ss/4=;
 b=uby7OjyEMCUo3gWTbNnhxC8tr2PXWYBkgczdOrTnkFhIfX239DJ/YSLoCWwdYiUJxpU0PPAlY5OMBrEzrD9G6QScJwqK8n6RqGXMQC0yJaKhs9fLOc/pK/whwmt81wNBOiW476lFlLIyaR2ffb4g0xLllw/0rt+gqeiWYjXhycQ0iznX9N6rjj1gR6s6/mX3t9m2sUaG7FxSU1H+lOVTbl56bnx5Bw1OGP6p6NuEtjXVrKNsCL4TW3UpHO8h2/vemrFokzmVwp/3viyBr/V4TvM19Aq5kPCVDjXkg3Us4lEPamBfRea7181n8yKL1VZubUXZjKUM3E1G0xTtUFcRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMlvYt/o9RAcXRI+fSPcFRCZdd9s1aHRvT24cJ2ss/4=;
 b=QAmNL5ja8hoJw/MxE08KUo+7svEDkLkBLUO0AFy6J9JAwVCqbo1ZAirLhaA1DF5Hwcoic3fBmPwW1YxulBX5bHEJUBq5bUMUFmcyjdmQP7mYp38tLMl2mBWDTiYXQcbaPha15a/6RJ6HV4WfKF4SVMsmE7mvyZjpGbGTrEri6tYCYTQu7GZls0q4d5LP4VHFpEwefMSQI+lPJKsw//ZyneogB2K6cr3FLe+KpVU/26TN6C/S+FZbqYElzqTUXpDP7cMWLSYW/O4B8myaWtzEW2mN5WapY+znpfQIY+QrgtAzYapwwTe/gyzqM9vBLQMXS5b5m9j2CuPDj8bRsuHUJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:20:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:20:21 +0000
Date: Mon, 31 Aug 2026 13:20:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
Message-ID: <20260831102017.gbsrh4yjnnhhn32v@skbuf>
References: <20260831085217.391-1-strst.gs@gmail.com>
 <20260831085217.391-2-strst.gs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831085217.391-2-strst.gs@gmail.com>
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: da3157ab-ba0b-4804-004a-08df07497681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|23010399003|7416014|376014|22082099003|18002099003|56012099006|3023799007|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Hh7Cpb86jUTjCw3ac7ZZhqqBEejP/4KS6i/s9/iuttuTkaz3nTem/b4CfySMT8kPcmFP8H/wR6/ADRosY8D3Z0ISvoKb8Q593NqBA5FPPUE2o698jaQhs+NurCSwvyehTs2slUlHEm0caXYreiLjTeUMmoPaaZoFmFVSLFCOmStVS0lj5FybiwcS+Yu9A8REHe1ig7kuEc2ExCwf8rqLbBwumSLjnWhA+ab9y6JqceIChiWbZd+a0Wo8u96NM4OqiUvjm329Y1hq0bxhKSHMx+6z9+hoL3bif1r+Va4qjuTrFwX04uliWb3WUB+J/MKLZXUJ32TrWC8OxcJDxoFHc06BSuHt9nCFWwVwakhqUgg1f9FGpmQ72BwmXShkmtCaBIPVf7DAeDpHYHafXbQD22HmJTN67VDIaq9jDV40McoN7AjOtCH5MoBydPCnN+G4hJyLggvTY2C3lex0ZVp5wtvjxrHogwKYAW8YSw5QOx5Ld1OEMKZ3gO4Mx8M2b/2MqCxFvpNPTCvDy116ndZxs3KavEkmgth8m5rg2dogiAIwZtszja9qZTtnHs+Dyoi0c3f+GJkySImCx24uXE87yiivhhFVgLeZkQjw09m6Z51qYpqZYSKdawGiob39rTr1gydCrBK/J/4NoxFZP8uuyeYALtE7x29tomz72Tt77F4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDVGzw23DYaEq5Hqc/bvEeXyKsVs1ogFyihsKHnsMap89bkyl0gbXeMTwnj4?=
 =?us-ascii?Q?esOqC1Pprl3A1+wcbRHpADEI3jm7O2hnL6g/BhHavKJEO7gOQvRDmRgerW9/?=
 =?us-ascii?Q?1BRNWA082X+HN0cE47RX3GSsv56Y3vsquPoAekLdSTjLDfwHUgT5yMTnP9Fl?=
 =?us-ascii?Q?YbrQZFbjz9DOWbdKHHAEHx2L5HTHrYPO+DY+AZCnJ8ham0pXqLqw9PDGB5B0?=
 =?us-ascii?Q?D8npPDgywFqA/vkVELi3cCDDwT5SmNvfaA+ktjl1kBkKavCF+GT0AVSXaMIx?=
 =?us-ascii?Q?yLmh3y0CtPNyB9ZtnoyJvEozocv6o4vnMD5lEnKKpTatkf7CQrm8l8q+1z15?=
 =?us-ascii?Q?mBJOwxjQWglUfn/xfS/JwW5MM4r7mOtqoY++tVEWZvAimGBxd28AdGD5PRCe?=
 =?us-ascii?Q?ViwdZoxZKZFRtNcWpoLf6QlkrXdLUMOoewvxZkpEHJVWHH7snUFwXyXn5EiW?=
 =?us-ascii?Q?Evj1rXv9hFLjTAopEltC/dbzyiFHIOEEQy2/cO9oEElGLvrcRKW6InchpJgU?=
 =?us-ascii?Q?ALCx4jAcZcLF032y/zx6gScI9vrBcro44fW1pcMlYiwdHF7ljQpG0e/RIX3/?=
 =?us-ascii?Q?yqF9NvlTKnhuQd22AkSnCMMHcHSbwKR/XMDSCkPpNNTB1DYOQ1qjIO+R9HGO?=
 =?us-ascii?Q?UIe+1EprsjymH2FsVKnye8pMrVV6CIZ2T7k8bwiWuA/DfTeyVCPHF1x0pO11?=
 =?us-ascii?Q?GPwqkNByF4akdn7yTo1SLLQE63cilllm7NGuDeC/c4sS/MnBgHvNEA4aIQ8N?=
 =?us-ascii?Q?ng6FJeLFsRf2JYiv7fu00OTbIp6i0JNp7FF1KZqdRsOn9HeHBdVuepLeFOKU?=
 =?us-ascii?Q?fG0N3U9CH0xkkQVaESjnszlMU0NezAH/ApJu6HSFe12cu3UDOlbyIGHf97UT?=
 =?us-ascii?Q?yLnwtTyg+UFp4YagvIvnSrZ14tZWyAJrQGpuuZzu1QgVlgVErzX7WX1eer3w?=
 =?us-ascii?Q?MVSBrTKFlDljn2vJhNEhkOxXkQ0iz6lo/sw31BMUIW/VX0ojdg2+9/xc7wzL?=
 =?us-ascii?Q?4iIYGJAHJ4u1B3E1ER+BAwIIZQ6hlwk5wjzzqpfjr38eFcEJs99rN7orPld4?=
 =?us-ascii?Q?V82K3coqW52Z5XePl1q5agbKe5DRgOBWEnRaTFuHh8WaSPWXcwWoywLass+Y?=
 =?us-ascii?Q?IcR8eJ1peIFKJfF4lRfq5RWyvbWrRzZVOQutSQnGIegiKH0hYX4ayZbrqpI1?=
 =?us-ascii?Q?5Y7oS0o9+Vukk+R5FNj/vFWXq96oMBo/KpjqUO824IH3dvUo02LWkBIoS7yX?=
 =?us-ascii?Q?gGABLz6yXUJjEqTTa/FE7vdAKzqEhTyfAtI1VM4u1qpK9aZesobWkA3rksSl?=
 =?us-ascii?Q?h/3i9RX0dqGYy9atuy2Nv3FuQkBIVlP/csk8eqA0lHcDTu6u+6p4BjkCXjBE?=
 =?us-ascii?Q?OIgwn0DtZmXsQA68X0jkEMmJ2gN4t0Z6UygkTPfp5SkkOj+p2QdKGtsZFwMM?=
 =?us-ascii?Q?ymTDIysfvClzmaJYEWpVkr1dnd+U2cqUTuRSdG4TBJ28gHqWMbWBAQqu9Dxx?=
 =?us-ascii?Q?pSMGPaMtn53tgE868P9ITqZSJaCBdp4me9eb/oYu0jBWdnyCckn+XWmWqVok?=
 =?us-ascii?Q?h/7g3LhEDRCWqEU6Kx/y2h+3L8CmEl3tegjmm16j30Q/0GWvbRVyYO6agd7A?=
 =?us-ascii?Q?PQMQ42HqxGvVCM6OGqZ1vGP0XlzmgSxDtSm6LCejP6ULVcnHXbKpGT8p8fHy?=
 =?us-ascii?Q?KwtNATWcJ9N6jenypURFjeOq+xefRQBPI+hrroFKOeTUIbqV9kXsbPE+ZMgQ?=
 =?us-ascii?Q?xqaJGZtqocXRwd6aTs3q3mpDBXx7aeilIule+FJ4Fy87fdES+To4FMHO+W/S?=
X-MS-Exchange-AntiSpam-MessageData-1: lamWNV0AT0g0MGFrEH6RiQjcqf0GJz3isK0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3157ab-ba0b-4804-004a-08df07497681
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:20:21.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB2ZvqziwB7lEbr4VKAdNPCaC51Em0InL1WibHcxYWg5nm/RWpeg6DLl1nPCt8TPD11tMtTP/UO0eTaGNz4J1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560

On Mon, Aug 31, 2026 at 11:52:16AM +0300, Semih Baskan wrote:
> Before v5.15, DSA delivered the VIDs of 8021q uppers to switch
> drivers unconditionally: user ports advertised
> NETIF_F_HW_VLAN_CTAG_FILTER, the 8021q layer reported upper VIDs to
> .ndo_vlan_rx_add_vid, and .port_vlan_add programmed them whether or
> not a bridge had enabled VLAN filtering. Commit 06cfb2df7eb0 ("net:
> dsa: don't advertise 'rx-vlan-filter' when not needed") stopped the
> delivery for standalone ports and commit f089652b6b16 ("net: dsa: b53:
> do not program vlans when vlan filtering is off") stopped the
> programming, on the model that a standalone port is VLAN-unaware and
> any 8021q upper is a software VLAN.
> 
> That model does not fit hardware whose VID lookup cannot be turned off.
> b53 keeps its lookup enabled at all times, because disabling it moves
> the ARL to shared VLAN learning: the hash that selects the ARL slot then
> treats every VID as 0, entries keyed by a real VID become unreachable,
> and the hardware table drifts away from the bridge fdb. With the lookup
> active, a tagged frame whose VID is absent from the table is discarded
> before it reaches the CPU, measured on bcm5301x. Such a port is never
> VLAN-unaware, whatever the bridge asked for. Commit 06cfb2df7eb0 ("net:
> dsa: don't advertise 'rx-vlan-filter' when not needed") lists the
> reasons a driver may keep it on, and this is its first case, standalone
> ports that would otherwise drop VLAN-tagged traffic, except that here
> the VLAN awareness is held on by the silicon itself rather than by a
> VLAN-aware bridge elsewhere on the switch.
> 
> The existing opt-in, ds->needs_standalone_vlan_filtering, is not a
> fit. It exists for hellcreek, whose traffic separation depends on
> per-port VLANs, so standalone operation there needs the
> vlan_filtering state itself forced on:
> dsa_port_reset_vlan_filtering() forces vlan_filtering=1 when a port
> leaves a VLAN-unaware bridge, and with vlan_filtering_is_global that
> lands the whole switch in the state hellcreek wants. On b53 the same
> flip is a user-visible mode change for every port on the switch:
> bridge VLANs that were committed while inactive become enforced, and
> the unknown-VID ingress drop modes turn on chip-wide.
> b53 needs the VIDs, not the state.
> 
> Add ds->needs_standalone_vlan_offload for that narrower need. It
> advertises NETIF_F_HW_VLAN_CTAG_FILTER on user ports permanently, so
> upper VIDs reach .port_vlan_add again, and it leaves the
> vlan_filtering state alone. This restores the pre-v5.15 delivery
> pipeline for drivers that opt in and changes nothing for drivers
> that do not.
> 
> A permanent feature bit also means dsa_user_manage_vlan_filtering()
> must not run on vlan_filtering toggles of such a switch. The
> ds->ops->port_vlan_filtering call is unchanged and the driver still
> sees every toggle; what is skipped only toggles the feature bit and
> replays or clears the VID list, and both halves are wrong when the
> bit never goes away. The replay re-adds VIDs that were never cleared,
> so vlan_vid_add() refcounts every upper VID twice. The clear strips
> the feature bit and the VIDs from a port that happens to be bridged
> at toggle time, and its uppers then stay dead even after it leaves
> the bridge, because nothing re-offloads them once the feature bit is
> gone. Both effects were measured on bcm5301x hardware. The conduit
> change path keeps its explicit teardown and restore of the 8021q
> upper VLANs, and now runs it for every port of such a switch,
> bridged or not, because with the permanent feature bit every port
> with uppers has VLANs on the CPU port.
> 
> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---

I'm sorry I wasn't clear enough the first time when this patch was
proposed.

Nacked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

If you cannot get VLAN-unaware mode to work on this hardware (though
that would still be preferable), then the only acceptable DSA core
change is to always require NETIF_F_HW_VLAN_CTAG_FILTER on user ports
(what this patch does), *as well as* refuse offloading VLAN-unaware
bridges. Otherwise it is just split-brain logic, where the core
limitation leads to restrictions being applied inconsistently.

Sorry, but you can't talk away the need to also handle VLAN-unaware
bridging when you touch the DSA core.
