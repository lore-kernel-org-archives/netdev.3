Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E63B0583
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342067; cv=fail; b=hqlHpQWj/cJ43vm9eGrbEOg034rtquwH92/yVB6AfQhVMkC6CKr64ClCFnVUWGd3tetfl23zX0O4OmJxmGAjMJU0de6vAn5+lFsQWaLMhCn1+cQHKQdA+RMPc/5VGWs1JEDIKYu9591bjHIlMs7MH+Bh8lR8fINwDSwWOB0zxTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342067; c=relaxed/simple;
	bh=jxWnqGHUYEHb4WFivtIh5ImgpH/P+DHNrnWTKk15dHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8V8vQrVbPA81968WgVsPvYj8zBKzNVDDlER+ZMHPdH+7za8oHYlRbZOfscOkIkMV7o/Q28iFYouvj/2HbAbG4Tfoksfw0L2BDbIxX1wvoCRZj697GqsxsKDhU3uw5of9j9KAqBygwx+YCEIQnEKo73HvNA6toLNvNYXdYIyyKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HI3l3+uh; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HI3l3+uh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjhUx3x9bs8F/NH8BCPDwBqf0KG2m2wfqz74hz0KCLkKmqH2HXzyXztp+xAK7DKWD5xgbyzRIFojp+26TFSZQ0ht+VOPi7hS48rtIpZsF5h8Iw41Z0KNYdbDzF2oJTFTPofo4zP5R6uvxaUL+zTmCQZ9z5M9RbdqCX3CG2Y3wu9uG2HjVNPd/uDuyhr0kCCa72ZoWyHLnmSiHCLOKnZrELnxkcpY5YVDgkksBrp/JQJclSoMDa525kX7QE5NOocTghbmihdLqnOVK3Fsv5JIIvPQHoCUheFJKGbeD10ot7sQMc8F2Gp0GajOI54p0Ly1UNGYZbFKb20XzXAE2W2nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A08dsbkyTYoQ/ZonyXWxk1RAauwOhRw1Pz8dZN3xl8=;
 b=rftXxPMMF75DD9fzhH2b/DHEb7w6GpufDPw6irLR/l5II31JLBrdZhUfjwEvZ2sjHUV+SKa5Ve3aiABTpmqvbftR4Tfgp7FEsKufiuXi26RuIoBWv9qqnKNS6xK5Oug7QQL6doOru75yGjjShB+SUzN/2nLLBTJ7Y0Qxnd1xKfQ0tD1qc8EimuzWfjc9Du0HQe6ADk+DvkznYlLMXsfH/MjtKO6sUX57xmQGgfEm6YY7SyJ79Kik30j7puJQIF0j6zHnknM3XRbagYKEtztDbeHSdtOHAQOFR02lk5QX42fNDEm6eQQunBdpYwZy9Xa24bmFbW6hFbcTbIShJIM+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A08dsbkyTYoQ/ZonyXWxk1RAauwOhRw1Pz8dZN3xl8=;
 b=HI3l3+uhUzV40M/5fhlKtxizRO8Lg9hWV+7tXTpquSeulTwlogEoee/u2OLPU8xqp9Qg2OYvkh0t3DIi2AJPEPlaZtF4Dswdo9AblE9Ax+076DynBaVaVrfrEhTH+gfoKWPX//wBS1CWvRf5hKWvEkUzSk8H5AgqVAo8J/Tsz07FYyzVzD+2sBoloGLLGpz0Pa9tjJPcBYJZ6cgjJvsXVhZPJMJ4bchHHXLaGF0DCf0lFyVDAiQsiqPuyG5oMB5r94ffcK//tqPdgsJMrxoYNPsHPKY7hVLtS4uTTkTkUeojuHJ8HgM8sFf2/gUhVjuXyb2zisx16AQ1QH74kxQQUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by DS3PR12MB460943.namprd12.prod.outlook.com (2603:10b6:8:43d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 16:47:41 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%4]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 16:47:41 +0000
Message-ID: <b4f8b00f-cf51-4da9-87ca-7abed7f8db72@nvidia.com>
Date: Sun, 18 Oct 2026 19:47:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org
References: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
 <0c4ce4ef-4133-4cf9-ad20-7a4fdc4f0b19@nvidia.com>
 <a95dcfa0-2d6b-44be-9f22-9927d03af0d2@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <a95dcfa0-2d6b-44be-9f22-9927d03af0d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|DS3PR12MB460943:EE_
X-MS-Office365-Filtering-Correlation-Id: 28192e78-7831-4a16-3ade-08df2d378627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PjTGiS6X5LPcn3tHprjt5hxNwCFbiZ3/yVuU9s80HRJ7WgapcsdZyRl330lxZ8j0CrBqE6jrHFvwxr9b3+bOb2rQCZJKIg0Rr6va0dhNwhf0FtWMrFnzha4OocBKT/HitWiJuagaN3MBhn1VP3tIhNqQMqBIa+PxIreUHUxT+TJI9Gz2XrW1+6VM9aDEfo1Ht6ojgvweKwpOpW3n/SPFmp09szom/IajGJ26nbWA2tdEABk4xVLqqQSW2GJT1o/Lq86dqQvlm5AMUcKbj3w2tY/cmUzrdyyB6PdBMSxIXwrAb25DP1sBbKlHjeLHGRP+vix40Q58nMI+WfDpcn3f06oWv8K00xo/nSo7RTYab8NIJ518JJjP0MqKUtGYLidQfCH1n0W18G/PCtLF3kPaP4VMTOQnA7vJ8bcod/jIz1V7KZbvLwUlwbfXaAfOjrzaBP929elVetsWcQYYUC1Qm/JyLS/Lx38Vw7Y5uR0Yyd3rc5kBFVCBeATGtCJ6MkglmakLhsIgviVzvpKYb9LvfvZHDCjxNixAo85pGr/HqhYmKQJRIeItfA1H1rwV2MYpWoqPsRMQTHoQz90VlTX4oAeavTwCnqfSb9USD16/2G/m0p4NFGwH94blxoMhMyZEaD4XvdqCXaHZuhtTJYJH3Q8H2OEUahu1V9SRDkn5qR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K090VGQ3TTBTNVF5d01LdWFTOHdNSzY3ZlNJc3p5ZmVtempIbFBFb1JkdlBy?=
 =?utf-8?B?WU1JdXVuMFZEeVJYbllQaXNuUHN6VHAvNitBeUozbENDMEw4cG1TSzNuVEJX?=
 =?utf-8?B?Q2YrdVUzTTBVSDVLbWk2RG04dTI5TlpmMHVlS3lIWGh3Uks5eGRMUnRsMng0?=
 =?utf-8?B?SDUrL2xtUGlOZzJTYUdVUWNCZmhRdmtFUE1iQ2hZRnBKWVJwK1JpS2J6N0NC?=
 =?utf-8?B?MHRPTU9MUW1zNSs2Mnc4ejg3R3RjcFBUVXkxK3JHSm5WWnBuWUtCSmNVcU5Z?=
 =?utf-8?B?UGFlR0t2dUlzU3JBNnlmQVZ2RHA3NFl5V0svWlJmUHM2NUxRQkVkYnp6emcy?=
 =?utf-8?B?MzBCZEdLczEwRUkrdG5ENHB5dEMvQ05MZFpyMkN5NjlodklWQTZmSEFxcG9O?=
 =?utf-8?B?Q0hRWkh3QjU1NFhjck9uUE1qZXRJclJxV2crVHN5bTFKc1lNTUc5RnJ6Ni95?=
 =?utf-8?B?ZVA3V3NqN3h3YkRZWmVkQ0NSZ2pveXNwTEo5aS9XVVVDRi94aDRFTHZBdno0?=
 =?utf-8?B?Zm9mUnFMRmQ3MUJnd2VFR1p0d2hXNm5lTGIzYXU0Zk5Md01IdE9CQXJweGUw?=
 =?utf-8?B?eGxnNlpQR3lIRE1sWGNRUVFWSkNzb2JiZGNkS2hXUzhtS1gxbmNadWs0NmVW?=
 =?utf-8?B?NEpQc1c4VVNQeHMwaWZRbTlVQlhXS05DY0lpQ0lYRk1JRGJ5NlBQRzJSUytL?=
 =?utf-8?B?VHpWMkh1YWhoTHAvbFVHMkorZlFmeWR6ZHZobDdOSWlkWkJRbGVVOXVqOXJ0?=
 =?utf-8?B?MU5JaHhtSWNrbjROZDNvQ01LdWp4QUZCaWhsbWNRT1JtdFAwRU85VjB2dWNl?=
 =?utf-8?B?d1NpUnBSY25TbUFnd0NuQTczNDVBclUwbzkwdHNJdXZaZHRuWlAxaGtTbjRC?=
 =?utf-8?B?Z1BvM05HcDl5V2dzSDdhM3B4azR6NU9DNzFkZE4zejJDWjJMMGZUN0dlSmtL?=
 =?utf-8?B?Z0dnbUpCR0s2bXdIR004Ym9nQ3NEOVgzMDY4RHBlVDFEWE1aK3lXODNzWEhm?=
 =?utf-8?B?OTVjMmFDUWJDZllRUm5lZjhCbFV6aXAwTWJXWXpsZW5semMxaVhsbmlwU0xG?=
 =?utf-8?B?SWxpVUlIb1c1a0lNUmxNb2JhanhZQk1ReWgyWHRFNEMzM01JV0ZSVDBLamJ4?=
 =?utf-8?B?RlFxK2ZnVXVTOGhySm1DTldtdTRvZHhFTDUyTFlKU051VzBnUFJpY1o5bDBo?=
 =?utf-8?B?NFB3ZExKWWxmd2huUU93NzFjeTJrVVdLZ2UvQmFka1pJL1BWcVYrWFZ2RExL?=
 =?utf-8?B?OGZRNDFPcTl1SVpFdlFqZUluMkxGaVBuUTV0R1FTdjFoQzhhU0VRRFZ4cS8z?=
 =?utf-8?B?U3dTYUluVUFJditLZ0wxeS8xbzk0ZEFoSkhXR2NUWFlkU20zSEVjTGpVK2Ew?=
 =?utf-8?B?Y1dkT1N1cWVvN1RyL2FuTENlcDZCZ01BTE8vOGUvVmMvaXRwVjNsZDgvT1hW?=
 =?utf-8?B?WjFML1BRN21UdjhjL09CSVRPQzFMejBhNG5BdzFLek5wVGtoNWlUWnhFbTh5?=
 =?utf-8?B?bjJKSFROTnZjNzR1djVaZmdCUEx5S3Mra2pyN2ZGOTlueWhGTGtKSHlmcits?=
 =?utf-8?B?ZzUxRWpYdUJFZ01odDl6bk9BS3BQbFduTkFVRlpiODRNRkFMN1RCd2MwMHdN?=
 =?utf-8?B?ZVJ1S3h0NFZ1MXlzN2JWdjdnZW5iZmtkREpiZ3E1VzhXWVY3MCszVjl5dkNa?=
 =?utf-8?B?L1NBZnlOa0R4bEhDYmNzRzBSYlI3N01tZWlZcFFRbm15RHJ4RThWOGVOLzlq?=
 =?utf-8?B?UmhaOVpodzc0SDRhandQazB3cEtXbnVST2dCT1MzYllkMjJld2VINWpONGxi?=
 =?utf-8?B?MG5CeVpwQ0hyNXRvcE56Y1VFcEFnNW0wejZmdUpwckU3M2R5TGI1ZHVyM3lQ?=
 =?utf-8?B?YnZVa2FXUm5NVHJHSGZnYWwvT2tZTEgyeHM5OXFBV3Q4WmhaTUMrZ3RCSmZQ?=
 =?utf-8?B?THduck9Lb3ZEU3JKMUdObEsyQjhEZFQxZnhyempRRlU4WlF4UkNJYU1uWElT?=
 =?utf-8?B?VUZzTUp5a3dUVFJuMitQcDlvTDBmNWtCaUt1OS9hTHlCZS91YWJ5a0lOcHJJ?=
 =?utf-8?B?QzRneWU3QXlZWUxNcWNYN3B4T3F0S0VNem5ILzJOT1J0KzJQMU80bjJFVk9X?=
 =?utf-8?B?STVNcGw4WitqV1ovVU9oaGtpOXR1ckh4T1NrMEQ0WlYySXc2TXdzQTQ0M3dy?=
 =?utf-8?B?UkQwVnhJaERtdjdsTE1US1JCSVV2L2QvdjlCUm51aCtxSDZGUjBtSVVSanl6?=
 =?utf-8?B?R254SUxDc1N4S0JWaXdLTkJSVEhydFl5elV1Ynlsa3llM0Exa3hsYkY0Vnp4?=
 =?utf-8?Q?4OBOOcMC7s2w0pq3U4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28192e78-7831-4a16-3ade-08df2d378627
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 16:47:41.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAQ5fLJBYiEWf4f0JA05bIjlAYRlP2JnWUdt9b2HBzV6V88KugDve4GmL0vPOJRLuyLe2ZVZnzEbh0lDVagFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB460943

On 16/10/2026 2:05, Dimitri Daskalakis wrote:
>> ...
>>
>>> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "TCP-data-split can not be disabled");
>>> +		return false;
>>
>> I think the message should emphasize that TCP-data-split can't be
>> directly/explicitly disabled.
>>
> 
> Any suggestions on the wording?

Maybe something like:
"TCP-data-split can't be disabled directly, set it to 'auto' and disable
HW-GRO"

>> ...
>>> +	/* Disable HW-GRO if it was only kept on for HDS. */
>>> +	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
>>> +		netdev_update_features(priv->netdev);
>>
>> nit: the only transition that needs this is enabled -> auto,
>> so maybe something like this is preferable:
>>
>>   if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>>       kernel_param->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> 
> It's harmless to be less restrictive here, but if you feel strongly I can
> go with what you proposed.

I agree it's harmless, just thought it would better match the comment
above it. Either way is fine by me.

Thanks
