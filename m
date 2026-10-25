Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792925877;
	b=IJGdttuQFKwRnEUxM5RjzLFy2+nzRCeGrN5Udg7Dmj/V6tHTrZ4f4K30XmpCnO0oF172
	 CxM0GTwVrJFwvM7azNIduHalBJxXXwUAf0IPdJnxKg2grWNaslwfM/T/Ju5xLkzLiO8Wg
	 fkbVAll9yphyLIjg0lmutMGOReSltoM0+KpI5lGM8cKixSNPM2TwHFj73fZgZYW2ygRML
	 glys6iauIcSZk3roJCrUsb4aYk02lyOFl34nwSm38eA0rGgz9p+LgJ/rO7ogvl517Hzam
	 rZF8S6UVW4H8a+4z5UK3QJuEspFAi85tf8G1YZ+1WZ1sPg4KslnGyRxO0UCC4OOUShA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925877;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=twbhVpuIJm+j8bcalGWVpQjHTY+70Mof1g97D/waq+k=;
	b=eVvByR9QRj2UMNZlasoG7M9RBiWnflrNL4hqEAHo9RKx/J+pSIHKPIq4ry+PnxuiY5rv
	 +0c31PA5eMGv5ujHTYFtKq4DjJZ2gq4eIEzPG391XWdHQKF49Fn8Ax2/MIGz1ue42MnZM
	 VUvoLR4XOVauDcSaobKFz3y8vrMlLxAoUcTvnSf1VYLwwcyPgtz3uXht3YDxnzyM1JGCW
	 dMkhk51n70TbH3kg1ndb0tBwdp06KmwPUnLJ4baeChOJ2zQ7dwpKzuvWqelyloMnWivOU
	 KYidzZTaxtmQkx1/MN22u2NJuq1mDXVk1FfPwtNG+f4JmiBe4zYED02etbu5Z4BHGUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IPTRVE5W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.28
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5529606A31A;
	Sun, 25 Oct 2026 10:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5529606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IPTRVE5W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+eXZ/Q8pd6nBcsWHMhc580M1LYm1iDfSH3XDUj2Q8yDp6yDoqMxRXSA4g4gjEHEcQ/gh3V5aVqLooJk3m7FrdSzuZvRwpUGj1ek5QPpB5XM9RXML4eUEEhZUED5F826nHXUBebZI4vkES307d7DqVb4O+B98Tt3gGLHbwrd2dJLhLEvbxiRoO5hqIWs+pMpqCPyomAGu9NP8cZef1sbTiMCFRSN0S7p0dwF4fATcKDh3bDL2REVywfDfRssWP/mvf4mFPy41COiVC69uBs6KJNlv+gEF9RhaaV7LHTHJ71ObAU1iWzI2tfIFS7VxUs8NLlYNmJ4DMp8ZW01HRN1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twbhVpuIJm+j8bcalGWVpQjHTY+70Mof1g97D/waq+k=;
 b=a2FO7IAmCfMCUFO25u0QMrw2g3zuwdmuKcDJ2nRTwBU39ZrciiRdHvyhrYMSVvCHD7/TKGhHl3T9vo26sm7s3NLoEVnzii06RL4cvM+BdowuJKvfm6oOJSZHgc0xg9DRl8Xt8rrRGEyIlgkuGuvDl6JtOr5pEviC+CO6folMXMp35Ck0s4C2DpY5cYZb9rdJ9Ob6r99grAoGChmZRvMAcusw2LX3Xn2n3cU0e66HQFF/QEtOd6/UGUYuOLMQiOAZS1apUUh8iby887pPYdK5ONhXwLUtaTQZ7FRoGaAvK1oMxQlzb9PTv+JkagGxLkBNVwNtfodusmVL3aIeT/zB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twbhVpuIJm+j8bcalGWVpQjHTY+70Mof1g97D/waq+k=;
 b=IPTRVE5WkuemB6iLbZuYYLADUTZewFWntBAfd+DKBdMvZZAIMsooRl5PGIyhaEU0Vr602ogkV66aUtzgAUYHxW5e1zJHi2kTzE7N1gkUu6BJhOnYNsiZdjFng3XFyOb3K5QKeTkrA1PeXJWfOEzdpUumMpoHhgZffX9cebx14Wd7a+vLTdLd96a4UAnQKdyzASBF5hjH3KYIzGUCwfQ564+MgYpXw7k2t4PzyD7JkX77ZUiyDCWioiUk/U/ib0aqH4xHoRwKf0jEYSAj223qcwt6a8oeiX1SB5fzLv6SdG9cPgH3RJagMvwq9kCkWw0pLFS6/HAtT5rLcO+w2glH4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Sun, 25 Oct
 2026 10:57:53 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 10:57:52 +0000
Date: Sun, 25 Oct 2026 12:57:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tianyi Chen <hi@tychen.cc>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: igmp: report interface group allocation
 failure on join
Message-ID: <20261025105743.GA126003@shredder>
References: <179260356668.911829.6576504063198285556@tychen.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179260356668.911829.6576504063198285556@tychen.cc>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa549ef-0136-465b-e596-08df3286d13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|261009223027099003|11063799006|10067099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	c0dMvxuqZ8v3SfxMiZwBAK6qSRfCeyN4v3BYxyzo+k3oKCdp39H3Y817uN8tJ1wfzsC9OyFlFVMRjGZwR47RT7Q1RAZVs7vaU52+8scGx5N+1L7J69cCzoMR//kGvJh0UIEoisUaPVN9pTDGaMS7BHqv/hVyzesPD4HMDr0x5vTxxgOSKQVWqVFQVFBdr7nuItf2KEa816QDjWpnApXzVuRaDaZSr1XJ60paf89NFf31JU6jTqd0VuU9bM5e2ANyxyo/FXpqyfJ/JApbED8RvE6sytL1f0CHTtxvIcp9gFmVFadAcXes7N80fRWuvcJ1d8OZBTVvPG8MxOg62FPjn3mXSLn3JpUWYCvHTc34C+Itq/UADIVwkUVW6UQYut92rd10xEo9RSvCB0rE6fKwAlwJzR8rE4aPc6VZNG4JkW+zghhjPON4apOuYDpzcFLhG/a1tsKfYg75sV7oHDYYkdpL9ie88NzR8+7ZVrm4IxDO81GXCh9uYZyrXvmuaPr1tsmnXq3OxnYbzdoMR3vBZCvXxQx3N2dkACIkxzb5Tg2KQ7puZRQDeSQZ2QCcn1AAlKp8eZZmgFj3owyAQ3S7VrL47Iw9kuxU7wnxjjPIdeKisb31DVOHibRMIA7NziHw2jRNExCwINYdY65M/ri52bkBR3o6LnZLN0Rd0BBN5+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(10067099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVYBnSnw5B9NWtGS/DCeahlpAyAEMweSDEZK7Qc33C7ShveRv9fCfP0YoOou?=
 =?us-ascii?Q?V9LuLiSMkM/6n3zI2nSRZEs8ziHdB2BRPI/ywEQ3DMtO/SHAVK7PRglU4BJc?=
 =?us-ascii?Q?FCHzgldIu98DCwawYdTd2+lwjSvALDIsM+cHWTJDrdTVBZxfTQkZdg/EIIW7?=
 =?us-ascii?Q?I3kafSu57nRqLDKGZW+img0mQASsSKs1gxZQl5ITz/R4oIfP+EZUgoZ/Qx34?=
 =?us-ascii?Q?yoDIdRejDwUGsATt2UQ1IW07R2o7QUaRPVPZjZLvNbJColoJ7HmZ+KpJoHPb?=
 =?us-ascii?Q?Zcps/QJRRnohaAwqRxgzIiWUuUHXd59p1GRTGNrqPXw/fSGlhXsLSl3PyviR?=
 =?us-ascii?Q?MIuXme+64Dt7gsEdE63VxsstbJcG8jeGFte/AcQHqWYON2I2EgsX6SMKKJui?=
 =?us-ascii?Q?yW3vDTXS5PdwcrEbcRPi39TkqmL+jAzsNy4TVH7SAO+XXlh7Ob19yhbSvDsp?=
 =?us-ascii?Q?KVqQy4M9CN7QNrcNU+1/BkK76v/NZE+xbEjIjM0amMiJFqSg5WtF+BqlAdnF?=
 =?us-ascii?Q?76uoXZnEX1uTHYT1LsKQP2qvKOTyRZUg/qrQlMg7J9b/QqCB8xwjzNV+BhXe?=
 =?us-ascii?Q?TVRAp0uQ04YsbjRfjBz4PeRg28wNhafvnmFGdi6qjU6ZyIRsEi6Bowidp0AC?=
 =?us-ascii?Q?R/nBEaQ+WbKxj3M7I00ImhEYhWfS3hQlGLveu7yppBeCQsa2jKTXIlFTVGv3?=
 =?us-ascii?Q?wq6jNVCFB6UmM2ZF95+pEK/hJ7dgCe/21ZL6lF5SZFZ1f01CBOvDUWhgBdNG?=
 =?us-ascii?Q?oTOaSU77IeLvxwI50pYw9EI57RGqjLZ6zZmniczVLishJJMiZY2vS0wnx9rJ?=
 =?us-ascii?Q?ex9Wn94UNuBq66UIP5GmHcAGxvIwV+GtFpF52eemqtiR99dR5ztHcfEYUbjw?=
 =?us-ascii?Q?4AaA+Mwnk0gjwfnZbxX3ljJRodh4dK3f8SEWCVhgBdXa/QcPob5KHeWR4PhN?=
 =?us-ascii?Q?9//6W0Bj+k86orMVK/rHQCn9rCAsZEoXI7PRSCASX2wzcc1WO5NTPWMeJqQL?=
 =?us-ascii?Q?V0SiXxdtpOfnofdkaB8hH0geH/30/hxkWSfaoJOGPZlBOwPDlVyH7KWcbi4o?=
 =?us-ascii?Q?lzgXLofSsF2BWwn3FdLy4k7/NFyagl7sX3c/qiDmrZWp/m6rOqbBd7vI7v2p?=
 =?us-ascii?Q?XbZ8v8a0O8+vnLd3WBS88Nfj0A/Swk80Ie8HTW84hyQvjAv52vzGNtdk51KE?=
 =?us-ascii?Q?5bv5/waAzI8Q1+oK0DKwHFtDm+b0bA3VoomyiyTFLACx/BBS7VWQhQgNb/sh?=
 =?us-ascii?Q?St0SwwV0i46SZe62LWdR9T4HeP8Tze0s2YVdWwf8pZgu1TpwfnYofFa5lEGY?=
 =?us-ascii?Q?gD0u5vu/DMe+AuPkjUrm0Y1WYVD2feiT239TDkNSwdjZAaawfIzeBSn1SGJ9?=
 =?us-ascii?Q?5qY+DavAJ6O065tL1MphS8fWNVPoaWlfT2NAnlNIbxbKvY2ytHe1pqLsv+Ep?=
 =?us-ascii?Q?GxyDeUpwLccKda/X1a3Mt9vMjuzK2jQ6fkStpZCwTVehe8R4kguxzKn25OAo?=
 =?us-ascii?Q?/+AX0jZ2AzwW265M8RQtVh4zXwLpN7KIJvopl8GnTtT0jUdvTuP566bA1Rw2?=
 =?us-ascii?Q?B8YKqvuLEI/1ZtVbS/ulRXvlvISqe5gTJs34EeQ7hnPBXep0LnlSKfxqT5K5?=
 =?us-ascii?Q?uMWqk/SXfkyIB7HhFLCtVt8Klmmt8iSrmMBXIYBPbWvxcklv9BA57zOOIpXA?=
 =?us-ascii?Q?N8Zkbf+JHa0JTFj7tIy3Sovr3ZnXHLJ2ievAUaZ5JeJ7Ygdz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa549ef-0136-465b-e596-08df3286d13d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 10:57:52.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+2SPjBGuMdnAVkn6TXjSIia0rHnAL+qD/A/ZO7aTHdfgbp68tRgqUmN+AFMRao7cYd8JRg0UtL9hRpqAOxDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

On Thu, Oct 22, 2026 at 02:23:59AM +0900, Tianyi Chen wrote:
> setsockopt(IP_ADD_MEMBERSHIP) can return 0 while the group was never
> joined on the interface.  __ip_mc_join_group() publishes the socket-side
> ip_mc_socklist in inet->mc_list before calling ____ip_mc_inc_group().
> That helper returns void, so when its kzalloc_obj() fails it returns
> without creating the interface-side ip_mc_list and the syscall still
> reports success.  The socket then passes IP_MSFILTER but cannot receive
> the group's traffic: no IGMP report is generated, the group is absent
> from /proc/net/igmp, and the receive path drops the datagrams.  Closing
> the socket also decrements the interface group for every published
> ip_mc_socklist, so it can remove a group that another socket joined.
> 
> Make the helper return -ENOBUFS on allocation failure, call it before
> publishing iml, and free iml on failure.  The object is charged with
> sock_kmalloc(), so sock_kfree_s() with the same size keeps
> sk_omem_alloc balanced; it was never published and has no source list
> yet, so no RCU free is needed.  Successful joins still publish the fully
> initialized socket-side record after the interface group exists.  RTNL
> serializes the writers, not the RCU readers; this ordering prevents a
> published socket membership without a device group.
> 
> The legacy void wrapper keeps its best-effort behaviour: interface-up,
> init, bridge and tunnel callers cannot report an allocation failure.  A
> query does not recreate a missing group; only a later successful
> inc_group call can.  The silent failure predates the 2019 helper split
> (9fb20801dab4); there is no recent regression to tag with Fixes.
> 
> Reproduced with fail-nth on v6.19 and v7.3-rc2.  N=2 fails the helper's
> kzalloc_obj(): the original returns 0 with no interface group and 0/4
> multicast datagrams delivered; this change returns -ENOBUFS, leaves no
> socket or interface state, and a later join delivers 2/2.  On the
> original, closing the half-joined socket also removes a second socket's
> group; the patched kernel keeps it.  Normal joins, the existing-group
> users++ path and source-specific joins (allowed 2/2, filtered 0/2) are
> unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  net/ipv4/igmp.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

Looks like unnecessary churn. The failure is not realistic.
