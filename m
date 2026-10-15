Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D914A3F02
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065181; cv=fail; b=ukrFjz2TnznfaXQzp1BofP39bqRNlSN0QfgiMriFi9TcfSzn0vYb7HKlp3q0SyJXe9qcQfC4mJ9aVvfJCFps/2o0rNHelBX9U94P8i9P9ukF3nvQ2e5I3gSGwX7XpFumtzjBBl1DxyPzjxkX5s63SkDCFW48Ri8PUMoRbqe0eu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065181; c=relaxed/simple;
	bh=5hK58d6ysrinr1E0B7fojDadSyKEbU0nDunAFLAeZsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNSJsk5kTMsVtFcj/Gm4GbDle2cHiSUrftx9nUOaHfXffheYQ1RQElNLw6aH/IuOr8ZETE1evK1qPg2JGBcRIKrYT81khGXc2RuldJMf4BqEgQvIPxBLE6qNcvrVQwb8Q7kl7hVFSm+khVEmEzgsYeX71Im8b969iLNEu5YV9Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/7oKwhC; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/7oKwhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRLCDCo3lBG6yVvDrS4SyzktwSjVJwuaz1rf/ZQeaz40Lyt3HqM8Qft3gk2af72kZxdf+Vug6tA5Hg1MJvg5BAkU7ZCiPWC3flq72DhxWok9uYnj+P+OifsC/dwfyFeSfmayUcJbxu+xx3AzFgWie97XYDLIcdQQWwgrcq6bb3zavg54LNAwnj/oYJLen4H30mihrjNNjLKWgWHl5UPL0WfCDgzZu12sc+wBYaVV/s0wmbur/DWLsgg2+LOE/LfCkkbSoxPQlh5Bo2Oq1alKNaCR7ftItfkKHMMlcy6qpN2vGX+61KYg/30YuZpoXcPl/aGrz8lV1F6mjwxAUQ3eeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek6j5OeUrDHx7bwL56fzPEs25c4qJgH3KLnNrWdMb94=;
 b=m5hyuMSbqaKMu4fCG+qn3Wc0eNEbEq148sMsXGduFHaU/bmyQpr8ouYCyKA/64CxiyTqsYlnLY384aOyDT9ZM9Hdd1YGNOqjaiP2GhqaWCeqRpx6CvJwzWhJ/Toc7JhCtfKZioVs5wcXN8IHmkgSe3sOJN666GOcQjQ1wxPkKYScDObPEX5NXqPdTUSnio8EUi1bMsuFT8jGSdYVVmzV4cig0yJCkrGot/puUJaUvUny1bmxaU5MYy1DOnS9AEqf7ANMxkM1eCkeqphZI+f+ATj0MbxKSqhYiVHpzeTc4xgNF7XUZ/n6uP0LkZbmoPlyBO4v/xvSTGZGwYB0sO+XHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek6j5OeUrDHx7bwL56fzPEs25c4qJgH3KLnNrWdMb94=;
 b=h/7oKwhCv/qnW7MeS3PueT33+aye74CHXfhTAX6WaWNCtJ+npBhLwlqAl7dBr15ZhzGUtxRg/Bvo/aOczbnjhdQU9+J6xYJVt9Y2GyOuDPfWbHFasdQydQL/dDMyzKInQm0y7bvCKprAeIzKrHVpzFVIk7Ub/8xbY5dZrQXXoTflrz1bvmvVOFogUysaQd3hwwhp+iL6n0cONw2V57sLJ0QkKyE5KHDAKgPn6UCnB9XKzJ4i96YDZpi+goPjomL8uXAsXD6nJrBbu0KKGETWyhYi8TDsMmB1k/x6m5j5/qcTaO8JP3HR4IzG5khgezA7XknSE7gpjbn9UuYpNCBkQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:52:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 11:52:57 +0000
Date: Thu, 15 Oct 2026 14:52:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 0/1] ipmr: validate VIF indexes before offload lookup
Message-ID: <20261015115248.GB1716181@shredder>
References: <cover.1791899747.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791899747.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d40b45-98d6-467d-71dd-08df2ab2dac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7d33QfrK8tFG5k2sqal6+STlrPfe1xnSHcskwgl2238exnUw+Ok10PEcxbXn+r0RwlS8D0811Xxl5gv6PhPfgImjSJBKBCf2D+ocMAagURz4aF2xZ20tORZij0IpYTHGV2SAxXIm6GDNZnYVmkpkdacHbFiJyzTW57jdUZgvPZ1hYEjEAuRnOMRKMmcP4fld1yp3+u0UzFKxhnIZtbP2dMzScaFKIsK00p3bLsT9YmF9JgyF9GF3vBSRsb7jNSNaj7JDVmaBSvjgr3blVR4vh/gRXgGmDz0y48Qnogc1UNt6CgYnr9OdGwKK+2Run3/cosoK3xhCoWNpwPaSKtf2/xhSWv6jYvIDM+vvg7GBbE3hihOk1JX0NDrEPlXih+I9UWzttJmhePTosfWohtITqmhzZDfHOUGAJ1kewPRJl5HVtnaV24+sABX4GYnKiwzfBGEguTGRwbjjIDdH00Rk5ZoiFTwnDIiDPLZTkZYKIzDTFi/UlOzP++9e/5o7xLxWtWNpzsgojpBLwoqE3MGYSUsroqo2dFgouVowYg0HIrhnB1F/xo1VeLKT+mH7xGd94tH6Z2AbeynSjEn6famJQAGsh8R3QrjVYZjzAuy36U5uOV+puVx1CO+swDfJjBvzbBm4sCc/Z4dlJWIsaKbC9RqSaejAoZb2keokyFl7l3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4VkpRB63cnDGK6mvg9cL8dOF8H9obif0FZRG87Kv9a7jM47xE46DzrxSE20?=
 =?us-ascii?Q?B0xBn77XzflJ5xeXr1lV/w7FNsGsWUl5F8+RKYGCRPEypDVgdke2Ukm95AHp?=
 =?us-ascii?Q?U2K8NBnezoiIU94vydjNIDOvMRha9ASWY7J153zhQGx1ZecgoDmTRmMlDUUG?=
 =?us-ascii?Q?l0mPojzJ+5Q9YTWZclDR/z9aARKN5OxSM2PVRMrvbX1hlsjbTIhLSGuT1bsL?=
 =?us-ascii?Q?7eO71M3MXJvNWx5u5IjXsp3kCvFc1N6rObS7pO4kaXRJWC4tI8qNpeD3Vc7B?=
 =?us-ascii?Q?HQmoVUubJiuEYnPKXLiwAc4RChrVoEVK4jSGNBTX7hoLKbYulkuBGnNryTv0?=
 =?us-ascii?Q?/REzKfIuGL3XAU0wKfNDZ3pJ0pGYxDOMd5OVR+t0KcAFAfD1xDNUJ40Q3bGQ?=
 =?us-ascii?Q?/x+XK9+UfiXBMKnyGFpfngf5kzTyLy0YRFMMQ7+WgsAvmu5+K4D4g4Eur0Qy?=
 =?us-ascii?Q?iCyWmDBV+TQCs+B3HAmZ48sFQ6VJx4KU3kN9XiuOAfNy2KgckjM15zexWEFF?=
 =?us-ascii?Q?ZtDLjhbIDaMt4Jh0+2DYT5ySppXv394ra3pcaECs80VEArT7rVeTXE6TpMmf?=
 =?us-ascii?Q?fNvgeiFyy1J+qtVjrogmRY2Vw4bD9hFNj2jR4QqgEy8DM1OA5aeMOnL4a08N?=
 =?us-ascii?Q?WwCrxvflM8phRgH78ijGMq4pKvOa68xcqCtxNEljzkDTmSeWO6ICumdk/Niv?=
 =?us-ascii?Q?DHlvC+G1x7LmG0e1vyJxmSoVCZL+/Ww8gT3T6s9L2W2z+dVTBfg6heMW/KAg?=
 =?us-ascii?Q?AiWNqt8ipWVmMg0SaWRCw8fzdLzMpjTPh2HXXDph0IHtr4cZQEXSXI+PC6b+?=
 =?us-ascii?Q?XLfSreX3kDjoCOrytT8aQ5SShzrDniuaWpymENIghvtOvrcJj+YLYpjRL+RO?=
 =?us-ascii?Q?4ihkxTwEvwpx0j5+rdX+wNqOmxnEG4yB764yqNu2sx8Lfb6fa4GUlmPJfGxd?=
 =?us-ascii?Q?zNZYlwKVxF4TfoHW5X1QPAH9j3vYqVmVFENExUwLttdAlmNYReO27Vn0bhdK?=
 =?us-ascii?Q?5jmHfz8NmoGP7R3gc1c2e31CBabbB0YWthOPJleq4ArWnZeyYIBbLHtHCGMG?=
 =?us-ascii?Q?NnnHVFZ7nuk1+t+MOETYVCdaUPWQ+a2HB5OYWYYrfvXERkTgNvkug5WUcCnH?=
 =?us-ascii?Q?PKWS47/VHpU6GD29b9c0SFsvbpVFV84KKmX/uC0+MoYbgUyJiTU96RNTvJXY?=
 =?us-ascii?Q?+/biXGlUuu4MK/4Y6w4YjNQtmH6JJYljxpkqoz/l4wUDA64t4uaJig6xzVkv?=
 =?us-ascii?Q?CIQSoQ1UGjfd3apCMWhUJV66/4aJzGv81nvL2crDLKJxMxRLopKiRnmLduq4?=
 =?us-ascii?Q?1Iw9PmIrzUhAwv4G+5wlYsoFAnkcDlDJVvqKU3PsvZLBGXoXsP78otWDeEMD?=
 =?us-ascii?Q?bPDjm+FXt+DA2PWvJgc/Ml40Qvl+lc+OPXO+TnC/iwcgfurqYskiHF37do2D?=
 =?us-ascii?Q?/MD2033ciUEKWAwse2JqIW95F2mfmuUY99JHmorS53La65MNpt3HWQ/Lh5iT?=
 =?us-ascii?Q?8bvLfAyxXL9rH0wcvMc8aHtNDJoUZPbf4ijrDnFDUoLShrgJAkq2b60D2497?=
 =?us-ascii?Q?ZNZCN/8INZldaIV1ojhfmIhNUa/y3RBEIyaEFghuvouPEVYWKfvIesvj7EpY?=
 =?us-ascii?Q?1b/SSGbpHpYyHZno5CkL++ZvuUg3crWSFycrz687AG4TCfiSgyBzS0qCmjju?=
 =?us-ascii?Q?JzMqSVU+kII009912RcXDu7ORYmDmazWUZDtg+RgO+SMdSr2zdND41mfw1Sx?=
 =?us-ascii?Q?m5BTvlfmJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d40b45-98d6-467d-71dd-08df2ab2dac8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:52:57.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8jF+DviqSncOZeafamZV57OOIc7KFMAbcjMdMj8UqBMZ2UbR7BHXMSWQyBhCmwkpPJeY4INkfJlbfKTfEtiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

On Tue, Oct 13, 2026 at 10:33:56PM +0800, Zhiling Zou wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv4/ipmr.c.

It's quite frustrating to see this given that you abandoned a previous
ipmr bug fix:

https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
