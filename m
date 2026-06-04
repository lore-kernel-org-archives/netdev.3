Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12189247280;
	Thu,  4 Jun 2026 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568442; cv=fail; b=TAj6cuUdDvhGLOUTKL1Dr9nPRIpMDTea83sTZFvrE+tOJhPeb1K1rwPkMWTRy+bKI514SASBju4qmJ9d59RsdsqmOV+OgsRutUQ2yjyVwE5SlRWR5/vCN5oy+9fYNTdDmVQuc0kEhnqLlwLDN0tap+CoDm6VyoiIuN5lt30vvTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568442; c=relaxed/simple;
	bh=oG1H1XVzzD2Bp1pCvaNc6XWy3Szqu+ry4m9xeoteGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUyctXjqD3AqkgdSrxGIRanRn1c05U0hq4HuVoWip3mohZsUrUkDg0g/z/0LUKjnNqjtPcA1GKjhAsaDERYZnOKyI3rsKPzbebmYzIeYge44wfCKjijR+4vK5w7/e4Q/AEeQgvQKxQcPw6vJGapwp2Ua//cT4txyGvq7Cs1/8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ibuo11DQ; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ibuo11DQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbWw+rjjk+TDBBRfsQLOyqVgEelTIwcR6JatWQrO4U6F9CmmwF+1QBfljBhdRV1ZXodl0zPObU8HIu4iAw3liAObj2ZzxUK0ImYtW5uGZLu4Op8ZbYUhr+H5atzUzyFGLYOpmlANE0pzAWZi1YyfwBnOEhvkfkQuirZX5e7VFFomKBEjEg6A3SPXpf4+y6FMYHcvUjsIcddL8D2UP3AUknBokHUKmDxUoPb6C+ZIf2fOb4apiD18UmilagOCZCG3vBdbDuxvJ94l7hTnncuwfbVY5XM2G0tY47Dov98CJmRoGR39zqS076N51/CztzYIG22wdPs6ok6dqLY1QVR4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9cJ0EpQs0SfR0bA6M2Vr+zV1x5oYsJSC1uUPVpxuLw=;
 b=Q9Ggalt4lk0sFofnvw2kyRsdctL6d48jUPYqOH6Qgkmxi9GbURAHQhjFiwDFSK1sFvBClZPyIiNkGYxmpH2eyy/1q3iHyqc9UkAOexXkIUwMYnt9/Gc6BZDpYjkMaen1uD2tqOmLR50O1DGHLdRt8z58TX2uNA787SDjWx7fF5nHND3W/tGZfOuvM3U3/Wgw345+O5lo30gcpErEsQh/YrF4AxZGHaciG1+TO0/TE7kaKbLs1fUUnWdZp8tW2ShMtlkgrnFxb8i0wtsZsTYoJwtDtv2uikp/4ef8RLp4KVPOzkVU5VjyeOw3iznlFk4ztO0yWf8AP8oarsW5HVFsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9cJ0EpQs0SfR0bA6M2Vr+zV1x5oYsJSC1uUPVpxuLw=;
 b=Ibuo11DQDRwJOSQxUlUBhOgY3Ba808eLtRPu+LlcoXSb3K9XpKfkO61p74gHqefnrJ1KYnQad+TJRjwnY14TXZOF0pSlBj34vMbzaxdxH2jjnBvGRCpd482XPoWMc/JZo4Z6p9EVpYaMTY92YPbAAFd1VlPCHNbV4FhsUIhlF9/Gd4BRwOH4Jv4g4Bs/eqn/d+j9GcgmNr9DxDpKACvcsJPTaGx9CmU2TAmKGVC1rscWQYBQReuXxt0SWTSbT07kHc68WKxqjJ0nU21wJmHiOqknLMfms46uL4dsr3G+cK2GSZp6MQxITShjpaB4NldKbe14tJ6y3Y6VpNBFYSE9DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 4 Jun 2026
 10:20:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:20:38 +0000
Date: Thu, 4 Jun 2026 13:20:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
	david.laight.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260604102027.GD771160@shredder>
References: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: f92c76b3-83a3-4682-b54e-08dec222ec3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MnIkoQGVuQ1PB9tjyoBeJLiQxPHfH/+GBUSfEfBDJYie+srZPCOosR3nE0HstcVXybP/ZK13EyRNF181s6ZBwGrvLaNf5hm+/TJ6FE5WdB88r3BAiWfMe8jQ+q7FxphqVaO3DRt8SET0m48xyPH32Xr+mzwSNL8NkqE8pA1sVHNTeNS1su2A+gGEOg0e5J65vzXkYiecz5JAFVURL8sHUftNIMT1YeuMFGW0lUTQvS4/GWC774ogBZDth+ZqoKy7kxQNtoSvEM/xA8t34jDmYczBmgFyFiMdesxC5Zz5WESI3raBvwvTeW4WzvJStQHwQqiJRRZzAcX7bsIrmEO9u/bNHD8WOiIBrfB27VC3yVVtjERHbE+rejCAFAbbw4c0F7WK06XHbaBoK+oOaAJRbdEdYCiXf4Ewucs6OxPj9K4Tbgk+WgHK7ga12Sj8kN3dbc1S1fSP1jtKCqQ3JlHtFO0N+xeMB+8DzNyP1WTADQzaxAfwkW51zfERQeFgFtT2gfVLZLfbUfHV0a6We/zLe79q25WMB/wuyF2aOQITcwilXm0iI6WFI+ZqUeZSBIth6in0xmCVHsf/JOLaj0QaOkp/S4ynUXvDsuwUcPloiWF+o8VEIk+vAfxqZ2vfArIqnqpwy/wI8W/ARLX0+cahSz6eyLCvqv9NjkoheFg96vYo/wMABVtLICDmeyue0jgi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rm/4MzeAoB6Z9U0TyA4a8gmpWgCviXxJ/vUE3AughhhM3MSQsLQyIn6jLysF?=
 =?us-ascii?Q?JYVlo1zBZ8ALkvxucNpCbyPQ2RrtTiZxpNikGv38NMu/dKvXFqoBoQg5Zqjh?=
 =?us-ascii?Q?ck9avfQZDCfwQ5sPi8f2tc0/rld8pkoBHm1n3+DGKdISrm6HoIyrO+P1E9iq?=
 =?us-ascii?Q?lPO6D7iwqsAFkkfJlNbCB0c4colbxriH1f1y7YAS7hn5MkpvL+zLeIQtcis7?=
 =?us-ascii?Q?zH64j+z/n6dlyRHJVtc/KRH2/N8cGEotYeS7EeQEAzjET6c1dUq3FwiEDFSa?=
 =?us-ascii?Q?WHsCIpXx5lwnfHRGnnhvnGnFiUu+2qlZxMTfZoGmHorGZu7jGEFj+PfogWKf?=
 =?us-ascii?Q?7keAaqMlEdiHOYK5QY740fOQaCFLe2oLzPOsDmLKVxR4TzffQhdPnrH0ZSsR?=
 =?us-ascii?Q?y3kyWS723tP3lktIf2eqeA7cS9x9hXYh9HDmRgzJTU+kFfZDvgl3SdYLgK0v?=
 =?us-ascii?Q?w+q4QTgi/wa5xa6ZTl+jrI3T/36nO6DkzAqPZEnyNX9KLH10ubNoNVQBCcf4?=
 =?us-ascii?Q?fZd4Sht95A2VhZSaLZHANizgiqf7xKUnXmWV3j6jgKNFLzAzck+Y1XC4snUA?=
 =?us-ascii?Q?z4n4I5ahQXbIC5nvi0bXfRUs9YPbLth9gV+hEtrVces3kZHw1sxoUmBJpaFN?=
 =?us-ascii?Q?2LAIhUz6yEiS+uYgtquFrIAcMSnkgk8qsnQdaKKyFgWPgdN1n2gjoilJWjOb?=
 =?us-ascii?Q?hokEXyfljh97bJfZO6zzFjEFgUT1LeP8SbTBHp6+bQqQXjOsg6/Y8jJ5hfhr?=
 =?us-ascii?Q?RQ3Q0PByjK0kDM/7kyJg5UjN9LFrTRbxkXse6Z1dntOkDAhwcnNyGQj4mpU8?=
 =?us-ascii?Q?ExfcWyVbXCu3fIkJuMnPafaf0hAo1rae2HW2f3eRmQzE+bL3YFxqecczotjA?=
 =?us-ascii?Q?p4E5KTa8e6C3f9hesUM3exwvPH7Oe0ei7sxAilrFpP8MLLH1HGjNGwNRYfnO?=
 =?us-ascii?Q?pDCtnbG/Z7OhhFfMMjmEgDj/vPKwr/vqBRqEasugeI4wugmQB2NupqkEaIst?=
 =?us-ascii?Q?xbKszD2pGeza3WhtezQKc0M1HgHMMowxwFZn7fo2nmQdc46XyfY+HHZm8FbD?=
 =?us-ascii?Q?orCwPlsUDHvLqCZd9VU1bCn9TRYWW5oiOyoENtfSOTWDvPFS4d4ffCdOVo6P?=
 =?us-ascii?Q?v42f8hzhowGtMc1TYpx0AKsUqobZP8aB7pIiAWA5U3rU30hBnsvX4FmakwTC?=
 =?us-ascii?Q?eZiQtoCf4Y1YfdcJWIErIKUoAFX3yel59TKRQxi+P/JhP56zFuXhT8dEQbpC?=
 =?us-ascii?Q?vL1rFStgq9GFALX9CB3cEk7dBEE5+QLa0y3QzkuWQdqMru6PT8mZP/bcXcrb?=
 =?us-ascii?Q?VcNxUqI2/qfgNDu33akcQBID/69tBizm3nP2zSWnepJmsULfSmq8cWB0QVNw?=
 =?us-ascii?Q?mlsOUveJJ6PlEFo++P3rmoKElTkMtrKYRFJzdrircTIibDvKQWUp9HdTAn2Q?=
 =?us-ascii?Q?MJG90tnVol4mpuuAGfIpcixLiA4vd7SLzmpl22SuirtpKohQyA2COpIGmZSk?=
 =?us-ascii?Q?uHGxHGKqUn1eE20nmR6ScJzBrrJusVCBHzXRFFeOE5jxrUY5i8lmd1ldfzi9?=
 =?us-ascii?Q?VU0d1yGnYTOzS0YT+ajrpJ0s/wh3nKk0StwNqc7thK1VKD17LsRt8768n9IO?=
 =?us-ascii?Q?HS9ji7BoXDCOmt7zpatpyWRw43hrLstAu3oXUJ14JHdzqCAwhTXjR/Sni3fT?=
 =?us-ascii?Q?LxwCNGBiaMx+KakqjCikw/7HpvE3eDKpiK5svCZzKwF+q+tsnw8Cyq4b9Nlc?=
 =?us-ascii?Q?PnctlpqAnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92c76b3-83a3-4682-b54e-08dec222ec3d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:20:38.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsBRcvVDxqowgZWQX2i0/SSwxhaHL4nUR/BVfbRPtVZjhU87fs6b0CLc7c+aZuVDIUilQMIEF1cQfUCAXM6Hrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

On Tue, Jun 02, 2026 at 08:25:06AM +0800, Runyu Xiao wrote:
> ipv6_flowlabel_get() reads flowlabel_consistency and
> flowlabel_state_ranges locklessly.
> 
> Use READ_ONCE() for these sysctl accesses.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

For net-next:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
