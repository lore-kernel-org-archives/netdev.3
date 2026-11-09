Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794227373;
	b=EUkv7Orysih2jLAen1lE1PilCWh0DvQRdaE9toB0eOh29Az5Qjt4EL0UeznbrswCjdxb
	 Ix4FVZLD8vfVVXFdFBLwKkvHF5RPAj3q5Mhh8K45K1vN7pnLDEgp3HQ/4yiEmf3jpFMj1
	 tfY6sKhUA3jJNPD5KSvCYddnTkFEFo0alJ2evUFSKfNcQuti/XVFhEy4obO4H28KZSD7A
	 rm+U3ZK1JMH092jPZv0DTre/0yVaOtifTYm1fTLz8TWg6guKKF46rW/HKwKLyjxoJfskp
	 p0klG9LOBJ4JzkGWrFnFPK7ETWH4YjGOyeQWGr2iUv2dZ4W2iJMszGMSk0YFZolseNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227373;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BLVnJdUG1EqOrd05eXc5NoSwsGwgW5Wjnr+9e0uIwIA=;
	b=ZDz+Um9muW6OUCl/13TlCtjOOTh3aTgWsd1Xlhh7zgL+BESYTn+SyA1qTcmYFJ+FNYPt
	 oMkcypR+0KX6ANDVs8gFdBS5xhDP56G/zGP/FX/ZM+EC/JAEK3zA5lkKl6wPsEbE56GV3
	 KmBNWPpfhfCVe77WNLwJwVDc5ofYipXQesKH50/gGRpdrxiVdLLnlzB0QNHh7H3OBzk8k
	 6rIofd/NiiBJNc/VewbdIhL30Cy5mv94A3w4r/3oi0RA6mNMabE/8J5sBRQ+1L2xnAq6j
	 BW2iBlhQUhwrfcLp5zM4V1fxmiepSo1iFa5FdCxghZuReSO22WkPr5QINJW0mOEfbwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jdgb7U2j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.37
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8F606A32A;
	Mon,  9 Nov 2026 12:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A8F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jdgb7U2j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F02tmmv0u9CRIIBLdn2hCP/Gmnv+DPvl31DG5CXJzjhqZw4ZyZJ/G9uD5w/Arlhf5C233G25qygI0ygYIkXflTpcYa3xCH5CxWHcl2PDffMB55hwt7aARBjs0B4i4plCYHuFCy7WlNOY0X1aOU9juOFinQSOMMXpxNvoxCCkAZyNAkFk4TuK+FwPCe9WBathXyjSx6jN/IoMFellMlSS+DiuXfT1P8RknA2w4yiDnmFvSNO2rpf5F8xz2vwLucYdG34VbMzocvXZff+qcLK/eXxcqWA/jT+OOkglrujR4opaH1446Nh74kxUXzGmf14Tr8q+b48JBUU96OTNdl4I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLVnJdUG1EqOrd05eXc5NoSwsGwgW5Wjnr+9e0uIwIA=;
 b=vOXimIKjS1e+Wwq7NVu+Usdd7o5w0KZyfgv+0GcGCeAm3TTz6hHuXWEsqd3ME+ZsvYwu8MCc+b7EJfMLsrsGhQQcl9sXFxCcslAm6CfeDBRWctW56/Qaz8UHNlLz+FPI2FOAVhEx4bTsxEB3gqV3dr46QDBATn6m6+4GEbCCAOBCaEWpiERQW9EtTvt8udwI7h3Ur4pTKwx1FPmbBm87laNyAFd6rQu/5eppjllw/VMgE1RjWgrItVRnZkt2ZCNLSEoMnLhCA0CQ0ZPfd8gclUB66H5wKcLP3Zk2wWY39DzUO4C2grmYa8Shr5mRKHveKFhg+G0v7tV2uhiM3JeM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLVnJdUG1EqOrd05eXc5NoSwsGwgW5Wjnr+9e0uIwIA=;
 b=jdgb7U2jAycE1UVk/iMDlQcvooZgwpxQDCj5JXsobMVOHKizxokCfoeHHcEGooVszRP6MQTgjPBdyxDWCEg/ILMsljoPKU8p/0X4JiEIbheooLiv2UxwCMXl6r/KF1cXaUuC/lOk3sYLdpTXIs+WYDsDJiQPf9a5eZ0yWFNlxTYw+qTBwSThpW5/z4BoMS7/uPmv163aMgduZpRM3aIEgWdcykKX90wytnQ0Kpni/txD5D75xm9wFFggzYUL0OD7NcX+0/OSMw82TMvC5YL6zndy+aJPFvflGY4m+VbjGR1dps1rBzWn46IZE5HTQ4W2vpzBi3OD3P0/RDao6sZU0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by PH7PR12MB7139.namprd12.prod.outlook.com
 (2603:10b6:510:1ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:29:24 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:29:23 +0000
Message-ID: <529136c6-26af-4193-b887-92e0ad865544@nvidia.com>
Date: Mon, 9 Nov 2026 14:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: SHAMPO, Disable end padding when
 relaxed ordering is supported
To: Jiabin Deng <dengjiabin2023@gmail.com>, netdev@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
References: <20261109034444.11241-1-dengjiabin2023@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261109034444.11241-1-dengjiabin2023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 044ff3b8-afe7-46a1-f92e-08df3e5d1624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|56012099006|261026140227099003|261026135527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	LENtjZkYEAz189KbBNepKU4lHyfWoOKcdogRL/kETOm06tJ+tZaUDlYd7aO/JK5sfwpqcZ8BxeFF6y7/Aku/amhHno4FvmG+8PpPeoD3RsFXGVEfBWOb2GshfJZNWw+cRJHqFJQrVCk/JT+5hd3DKx5vezbYdih9ikcEeIJIsHdK0jBifSJcI3cbucwVJfkLpVnz6yba+x1JwJ6JBEXE+4hbIjgctG76gm+5xHomsimFXYLU7j51LfglS3zuVdL22nt8fsWL+rjQ6G6z1UzEbtSVhR3ksFsaLfW3y9/jx3TWTJ7xufA2nYV/uLizUCS9RdtBdFkuzVM4bydT4FT2Epu3rFxQq5hE//CRj9DsqBObdr1bUc5C+rNm5i5+JgLTpJngtMpZBVg/fFxbw3HJkxfAcz2zmqsEmwtKfe+ifNItrKMlbqckhpofRLSrFGI2utWg9238LMJcJTljRPZffCQH+zOymX87EyGhGsJfol6gzDChl/SZR2uyDhzE13+c3r2mowVIH8mcWJfsC/PuugCU6uaD/lp94JsCNW6petw6uDRo8psljwDTTKm7RbXfyPaeUBXgDH2TQMPfw3m9qT4ZLgy5eRQvbCQUuA8F3SXDm3njSdR1QuWO9HG1HTrMtrEQNMOaSioMZdqBjeYG6Ixj8v+mx0ZYORz358/rlyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003)(261026135527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2tFYllHM2ZOQzdkRHo0by90VTB0QkNjYThpZ2pWU0V5bWhERXBDZW1WUTBO?=
 =?utf-8?B?OTFIY0hKcUc3bWdtQmJPN0gwVzhvOThHbjNtUXlWRG84QXM4OGI5aSt3aVVy?=
 =?utf-8?B?RTFobGRVNWFMMkVBdm9VL2tqNFBMMVlEa1JKQlY1azFPbDM3NWFSUEJHYmZO?=
 =?utf-8?B?M1hPQWRZUWtOWTJnb1hHeVlYRWx6Zm5yeFdpT3ZpM3RodXplcEhTc1NKNk1N?=
 =?utf-8?B?T2dVRGZDNno3WkVacjNpMjJsWHVsNzNySDVKR0lQRy8vVThFT21kVUY3YkpT?=
 =?utf-8?B?WUJsSDA2a3g4b3hyODdYZEtLQVRpcThBSjhPRVZZQWVZLzlvMG9EM2FhT0V1?=
 =?utf-8?B?ZmNTalJvZWFtK2pYeHBKRmRLTC9yRjFUNFFTZWZPVkFJdm54aGtsbTFKNThz?=
 =?utf-8?B?L05ZQ1daS3RHSXN5T0ZxOTZ5QmNPeUI1aTBNNDdiWGdudEc5RDdpRHl1SVI5?=
 =?utf-8?B?QnBOMWVrRFc2MDRPbS9NSUZXY3ZEKysyam1aZ3BkamJWZC9veEk5ZGpRZXRR?=
 =?utf-8?B?VzJvcElWdVVONnNkZ2JPSkJEcXZUdUtBbTFCQ21lWXI3OVRyRVZKY1R5em1S?=
 =?utf-8?B?TjRSK2wzSVBRdXZjWm9SR0gyT2oyMy9XVU4vNnJZU0VhQVpmeXVaSGlNTE01?=
 =?utf-8?B?MTh0ZjIvMkZDSmRYMnVyU2REVkxSc3JvTy94c21uM2xwN0YwUjNZZnp4TW1y?=
 =?utf-8?B?VHR0NEVjWWxWbXY5YUYvVi9qMmhDcVJtdWo0MmNvR0M1dEg1TGVLNzdZOWRG?=
 =?utf-8?B?RDB5bTMzWHo5dGd5U2dDRDBlQlhsWHVnUFVzMDNTdGsrSENraTdRRWJKRk1K?=
 =?utf-8?B?STZ3TXpncVBrbGdmUW8yR21TcGFPRlNVc3ZYUjFtRVltOGkyck5rZW05Ti8x?=
 =?utf-8?B?am42QkZPcTVvZTJiaEFqeXFvb0NoNFQrd2FSWUVOVlRreUZLajFrRHNHRE1m?=
 =?utf-8?B?aGFZb29OcTltcjlONEZWUWtDOVBMZDl0Nm1QSlFvVkdyWno4Yzg5SHhOTU9Z?=
 =?utf-8?B?OTlUb05YSHVPekJIT2VxWmNRRmREOEQzVGxCZS9zSXFMU3AvZElJaDIzek1y?=
 =?utf-8?B?T3lMand1a0Myd0FOeWV5MHBLTUlhZmVtMXBBQmwxblJacnNhaTNYS2R2cEZF?=
 =?utf-8?B?MUZ3eldadnNCMUtwRVpGSjJJbllHd1NPUUVRQVRPdnJKV3Q5Vk50YWJQTXpU?=
 =?utf-8?B?VGZkTVlwcTE5SFFqTFNhWXo4SmdIUlphRzkxY1V4YkRXNWxxMHl4VGt0ZTE5?=
 =?utf-8?B?ZVRaTG1GOEtUaEVMV29oZHUxSEhzbXpubjRZUkJ4QjAxa1VrS1ZMMk1vdUhT?=
 =?utf-8?B?djlUdjVQTUdJNlpBNUJteU9OaFZwM0VEQmVueFFqOUNxQ2lxSExqQmFRNzdK?=
 =?utf-8?B?T1hLRWI3cjRRZDkwT2hvOE94aENabkdjMU5tcHAvSmxPQnZHNzNhSmExbHFW?=
 =?utf-8?B?NjUvdEJiWE54RlRhbzVmSGJ1NkVCWFJnbVI4TUVrQ3Z4a295blhxVjFXSlNZ?=
 =?utf-8?B?bTVyazEzeXNqelJVQi95VWxPbzFUYkVkdkVLaExrRlgwNVZGMHRiOGk2TWUy?=
 =?utf-8?B?aGcwaEQvZi81QS9PdWNrS25xR0xzbWJrQ1JnZWMwNWxKeHM0ZG9UalN3MFBT?=
 =?utf-8?B?cmJFMS9DODU3RjNnWjJ6L09JMWhLVVVRVWZWVjUwMC9JTEsrcWpRbnZjS1Bx?=
 =?utf-8?B?cTNsbGJGcDdtbGl3OGVEUG1VT3gzbStmSm1sSm9pcGpVRWd5Wms2OTRlZmtG?=
 =?utf-8?B?RHM0Wi9vaW5MOFYzaHd0c0tDR2lENkR5V1ZPZkNRQ2RtOXFmdE5ub3ZCeG5P?=
 =?utf-8?B?ZXNsczdEOTVRTGw2VWswemtjWTZvZy8raDRKWlNwZEhEUHpXUW56MVVKS3Fs?=
 =?utf-8?B?NzNiMS81UURjRGFlL1B0RkFqSTFMa3RqbkJWUlJzSmlvY2EydkJUWGNoTkZq?=
 =?utf-8?B?b3p2WU96N1M4WllTSXJLT3M3bkcyV2dxb0Y2aTNVT2JYZUZPTFI2ckJheWJ4?=
 =?utf-8?B?a2FJNTdSVEtpUW9GRk81NmRFbnd1bFVpUzlpWlV1L3ZsUDhiVlBpZklvcHpR?=
 =?utf-8?B?Sjl4QmpIQWh1cVhrU2plejNROVJiN1RyQ3ZBS3N4OU5HMkN1bG1ucjEzQ3c2?=
 =?utf-8?B?cWpkSGFYSnA0djU5Uy9HTGQvWTJwUWlQUHU4MlQxaDh1NlpoYmE3N3lwU0lp?=
 =?utf-8?B?WUhkN3lGUVp5WnN3NXExTjYxSkFxM0EwSm9TcHZvdi9tLzJJWGErZ3NUQUN1?=
 =?utf-8?B?b2FGMk1tQzR0NHVmUWQ5TnRkcDB2QnVGdkNPb3R0ZUl3V01ud2dSRWhacXBS?=
 =?utf-8?Q?gif4gvSdzj4YN/0Rco?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044ff3b8-afe7-46a1-f92e-08df3e5d1624
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:29:23.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb5nTtliZPJtpNIjWRmSn08kjaBrH3FjlvKXx72R4cZ+OwpSSSaKUmJ/R7FP71tTHaKygybjiSap87tYgnEWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139



On 09/11/2026 5:44, Jiabin Deng wrote:
> When SHAMPO and relaxed ordering writes are enabled, aligned RQ end
> padding can corrupt received TCP data. Due to reordering, alignment
> padding written at the end of one packet can overwrite data from the
> next packet.
> 
> The current RQ end padding selection avoids alignment padding for LRO,
> but not for SHAMPO. Extend the condition to SHAMPO to prevent this
> corruption.
> 
> The issue was observed in a two-host test using a BlueField-3 NIC and
> an NVIDIA H20 GPU. In the original test with MTU 1500, 354 of 400
> transfers contained corrupted data before the fix. After applying this
> change, all 400 transfers across eight message sizes from 32 KiB to
> 4 MiB, with 50 transfers per size, completed successfully, with no
> incorrect bytes or corrupted intervals.
> 
> Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
> Closes: https://lists.openwall.net/linux-kernel/2026/09/15/154
> Link: https://lists.openwall.net/linux-kernel/2026/10/20/1322

nits:

lore.kernel.org links are preferred.

The Cc list leaves out the netdev maintainers and 
linux-rdma@vger.kernel.org (from MAINTAINERS for mlx5 core).


> Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>
> ---
> Changes in v2:
> - Clarify that the corruption is not specific to GPU or DMA-BUF memory.
> - Explain how reordered alignment padding can overwrite the next
>    packet's data.
> - Add Dragos Tatulea's Reviewed-by tag.
> - No code changes.
> 
> v1: https://lore.kernel.org/netdev/20261106083719.22798-1-dengjiabin2023@gmail.com/
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 5caf7820a136..159f79302a08 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
>   
>   static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
>   {
> -	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
> +	bool no_pad = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO ||
> +		      params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO;
>   	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
>   
> -	return ro && lro_en ?
> +	return ro && no_pad ?
>   		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
>   }
>   

Thanks for the fix.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

> 
> base-commit: fafbc4051123d5459ea6950899cec08ed946e278

