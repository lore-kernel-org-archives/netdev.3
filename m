Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122D400E0C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804934; cv=fail; b=J3Fve3YhzOHdCiDP9dsKQkuWclIHKiNqKQPHLesbPCfkXn9q7MTsv2lLi3YL/D80mRDHo4rXDe5i2IEm30V0zSrbSn7GrJ6/No3BThdTHE7+kPHElRwc/ew7DnlqzC7vvnS5sh8apfMffyMcmU3uFvAiNrfakRM0yT/HK6g1ZJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804934; c=relaxed/simple;
	bh=Z7NgPM28EGeCR9cdn640+6srF41mZWEaE8KxZVHuJpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/YCoRBW8OrKYZ1LwRJ+rWoE5aa0+fajKgAYrDIsBd7dnSgdUyKH8LfZ2DOSRCAfRn8QaXbPT+fMGprJg4nm6j3HPGzF4JoUYjA5fKi6dHFc5aBRka9QPvcIlZp2amZArHOi7CzSAl5EGQe7xt0u+c21x67xSAecYNgFDUlaW3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKmFJc9Y; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKmFJc9Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC8YFUQkcGaDbA80iF2c7vG+3fHC6Rzc2i2zbKKOf6RybpLaISmEW31q0grXXj7B67X48lAQ6BBe/3HzfmgYyDMgX0LXHVABphyHHb/b6rxZFQVtzt7xpHLqJVZKlV3OIp/O8Hmz0cnpXSPjJXTm4p47Jm+X+eHwwxF3vX/0gWwGoxA4TECywriEhHKDPrFAk5lWF9obCbnrbuciF+IdBWeNNepLrZph60Oo/AojlPFg3lrmKYTjXPBoTmEwYAUe0Yf5DTyWBA15xCUhTP7qQwozy8hMs6sG8Is5I3KCaDqc6HjLM6w3rjE9ZCH6uOhpCxXMNnfVJxd1g+vlQeZbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cljMvzU9jfFPFmBUhYTgU3/v//H7IaDsM7RewIHiAk=;
 b=R+rd+ORY1ok/qojcXUQW/skV2oeTT35UHV0IrupEk7q0t9X2IGzFOrpcmw+UUWMoqM1+/Bc6u2+5rMvsGjhzZ+lBKu6MaeqgR6QsH9QJJ47KStRjdV09/BZDn5ZwZWShc097v+etd/9jVxgFrDO9+txakVYYSZ3q6/EAcQT1TzxUFiotB7daIAc5pGW4NaJuIxrD0YUsSy0P0DsI0t+mMXUQfQvyE6KbmFm3DDK8mDwI+GHACyjUyfTkwIb4feBhNDdQwI/pmBn19P+SBgaptPRaRqf7GUDXptdE2MfoxTZBrv5Jh5bVyN3Lkv/RvmzVOdXvvkAVGi2V6Fli3+zoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cljMvzU9jfFPFmBUhYTgU3/v//H7IaDsM7RewIHiAk=;
 b=bKmFJc9YlurUIlnlczRHbd+QhvL9OJLJs44aCXIwxbejVQTIM6siZJ/BDeaqDGOVsFy2NzycgG9BlyDDBC901Zb4n3q0aIij2eqGbZ4ZIU2ozxKBMODzYBUxsE5+Owh2CBRjeFecQwTqyg34GT3ACZj/hTF+FVmU6reYAGHRQKGLDL9RhBcnNgDwsPkHqmOmErWPRRIAN73uliqJInMw7LmAyiL+QvkS/gBZbQwrN9Ej5k8k6iEUjPwYF9TLDRN7jnnzistBxVOlii6jQa9tZ1u89bbEakDpQaTdRP5qYebx38yOP6M9SFG6BYCgmjodaZ/QOpqt0BWs/2RTyiVgiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 11:35:29 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 11:35:29 +0000
Message-ID: <0c4ce4ef-4133-4cf9-ad20-7a4fdc4f0b19@nvidia.com>
Date: Mon, 12 Oct 2026 14:35:20 +0300
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
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c5bc47-35b8-45a4-039e-08df2854ea99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f+kyW5mHbTruX3nPVALQbxqMFgAGXQuks7Wd/sF8mSnHu88vbrCMGHCZSaRZSaMV0I8E7aQEWhEHj2FHe4uwVqtmk7ja5H7jBdFk9LIzL6GL7E+BdANRe4t98yzF8gOAHF2gjWlXXZVTQLSfzFsau30oGVpfD7K6YaGJrP1ZlRrmA/vWkG/gphQbB2CCAqy0ylxdlaV8XfYbCYZWBOvlsbZv388DO8Gvt1E1uWezyQG2VymzNV5wb8LeyWCsVFX6DHDolF+jcZJPy6ibANz6ISh1cn5GYAo3pjDLl8WLuaKS+9x6SgV/gZF4mjD7KbYXjvH4qOR4hGy8C7+nUiVuR08pftc/lIY4jfIuIVVioRrywX7353OyU6VqI54E+kuw/oMLg1tUEKat3ErFMPd1tM8JnuLohs0QPHod5awt7xuLSfRqh5JKDlyXM277LVFrEkWlFbc/dghXV2plAarlOvkvcyhI6zl6MNrhxb63Mo+nXUiSanZ9KsdePtKrQ6erjtYQGj65Ad3N0nw2wRNMW3arfUsy52mg78c4xQ7fK+MNjwyEM38pfPEaa3nlcnVrhqHPwFQ0fTkTPw4CDiPRx2aIiAbtgfFTdEJhJowj2AL1uELASE8wRQ/uf9rkozGxKlbflEIs1CAOi+AQSgTkoetVD56cQR4bFxvI7OvxI18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEtwWndQTkZJSElvZVlJdEtrdEdUUnZtOCtUcnpZWlhwaWFlTzVjNUs1QmdG?=
 =?utf-8?B?ZGpSMXRwNGQ5V0RIREhPMXRUbGI1cnBDaGlMUnVvaGJidjFKYnR2Mi9MVDJu?=
 =?utf-8?B?Zm5BMHpqeEZ6VUdYcDRtVFB4K0s0Z204bGI0T3dGYlRDbm5NejlFcmgyV2xn?=
 =?utf-8?B?eVRKWFg3YkVaTGRpa1VhME9VY1g1OUhwSHd4YXhZMHRKMWdvTHV5RU90NjNO?=
 =?utf-8?B?T3RucDBqM2RqUnhaYTVQSkF2TmVPSmQxSVBUK2NaT0l4OFhjYWJoVDJSbHdr?=
 =?utf-8?B?dlIwaklNbVVhS3B4d1d0SlBNWFFZV0FHcG9kTWtVNXRvdXNUWFdJL2F0bWFS?=
 =?utf-8?B?WDZ6VE9TdFNHTElrMmJtMUNEY3ZXM3ZKUXNlK3BtYnI5cGxpYjcyN3RZREh1?=
 =?utf-8?B?anNRakgxVmp6YnlwYzFDTnIveStyY2M3Ukk3WUdYMlNWQm5IeEc3S1ZtZ1Nr?=
 =?utf-8?B?ZHNlU0REaVJVY3ZhaXIyTC92dklGWlJtdnljSG5JUzlnS2h1ellCWHdnUE1j?=
 =?utf-8?B?aU0yd0ZjcnlvczZ4b0tBdzNMb2hNRGtsb2ZqK1ZsQk91UFNJb29tMURqQjNY?=
 =?utf-8?B?TmxvYnYxVVRicWRsbmtTWUxVQllDRlh4bWhkZG04Z1pnRHV1dUYwYUdmMlE2?=
 =?utf-8?B?d3QyRkw5Y0w3R0dSZGNFc0NlWi9SQzFhbFhtYzA1bFZNVkE2Q083dGNQTTNj?=
 =?utf-8?B?NVNnM3dnUkVEUngyUnNNSE01aG1mNnhSRHMvcXlGdk0zRHlxbklmV0xybHQ5?=
 =?utf-8?B?U3J0NnR0bWxpM09tNnkrVytSUkluc2g1V0NZYzZBT1lQS2M2ZVNOSDBLcWNz?=
 =?utf-8?B?ZFY0TSt6dC9xaEFwTEY0RU4xamxSY2o0ZWtWREhBejAzY2w4bklxcStUeTg0?=
 =?utf-8?B?bFQ1bFEzTU90M2pHU0xvMmFVS2VxREdWYXJJRWdla3JWRTNyTHZBY0ZHUmdO?=
 =?utf-8?B?TDBCcWg5Z3lqTHFtQWE4bUw0bUw0QkZNNTdhRzZCMjh2VjBnWWJLaEhIcFpQ?=
 =?utf-8?B?QzBXN0FaM0sraitHNER1T09LektKT3hhbHh0eWY0QXNnRklISWJRTjU1ZnF0?=
 =?utf-8?B?UHVmajhOTjZVb2doRU9VN3JrbE5nbHorMm16Rlo3ZStnUlRBbjBBOEswM29i?=
 =?utf-8?B?VFpabzdubWZ5VkNkL2lKejRDdkVvWnFrV2t0MTlUcDcxbjAwRUxXK1dCTDNl?=
 =?utf-8?B?Zk96T3JlS3Uzc0VHQnVyUnJ6Y014eThZcTV1YzRWZUhFbzNBZXdoNHBCa3Rm?=
 =?utf-8?B?bGQrL1c5YjB5TGZGU2I1OTdJeVFxOEdpQUp1bGp1eDg3UnFwemh3d3JmbkRk?=
 =?utf-8?B?OVZ5MzFOd0RSMTMxMXBqRUw3TkUydDdnTEFPdk5hdG44azVIZkNla3VpeHVT?=
 =?utf-8?B?Vk5aOGRNazVUNWl0ZDhaYkx0MnJMV21keWhqRlBRM1EyNzZqL3h1MC9RbjFF?=
 =?utf-8?B?WWRhYUQwYmZoSEEza0JKbkxweE1jVTBzcFVaN1VISUlBZU5jNkYxZWV0eTFL?=
 =?utf-8?B?a2lHa3FjaXR6OGFOMjBwOXV1ZGVac1FBS0M4dEMwWVFqZXFReHBqMVZjenhp?=
 =?utf-8?B?Zy9GMVZ2cWpBeGI1OEdEeHV1dXlNbXFKTkNmRFhFSEJlMGtheFpld29FSXYv?=
 =?utf-8?B?L1hjSGRzc1VhV1d3cTZpaXhhQ2ZpeG5ROSt5R21DSEdsR3k0Uy84QmdyMHBO?=
 =?utf-8?B?UzZHVlFuMlYvVDQwYVFPbWY1VmNCRHgva1FtVzhvbjRPMExtbkNnaUJ3blo2?=
 =?utf-8?B?YnhGVkZFaW1NNy80TW1ML0lsMzBYWWtkdHVvYkFiR1Uwbmgva1ExTEtIeVpP?=
 =?utf-8?B?bEZQdlFEdFhZTG1RSTIrQ0gybDVZcTZhQ2ZUTFM3MDQwUmxBQkF2ZVZ5bjVV?=
 =?utf-8?B?SFNVVmpnWHNlTG85bmtYTlRlTTdJeXZLYm5ZTFoza2R4VkJLNjZCVU9oQXBh?=
 =?utf-8?B?cG03Zjc2UjVpYUxMNktIS0w2bktMUHVpazhUUUp5aEFlYzFzNXNxV1JLNUhw?=
 =?utf-8?B?Y2VOOUxjd1R2MXVvdmV2NHliYVZrVkY2U2JJWnVLdnlzRHNMcGo1bG93VlNr?=
 =?utf-8?B?VmsvNjR5dlNyZ1FsRWROWHZYTURYUm5wRkRwYXM2cjJqaTRkcUtqakVhWDhl?=
 =?utf-8?B?UkRoOG5pMnNtaHBGSHhMR1l6YXRySHJQeUFTNW1PUzlvampVK0IrbXBqMWZm?=
 =?utf-8?B?bjJQblpvR1gxVDQzeUpMNEIzOW9MTXNLOUY3d3BsOU0wWkFxTlJJZXBuL0E0?=
 =?utf-8?B?MU1hWjJGdnpNemFQbWdqdEl4VzAwaHI2Y2c3aUdqUHNWUitITUZubk5JMEpB?=
 =?utf-8?Q?bfXHzMuoAD/rNooJOD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c5bc47-35b8-45a4-039e-08df2854ea99
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 11:35:29.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rJra90gYfZW9EPFmjIL/DGAk1QJxLQo3P/SGMSvq84ZRug1c493eYkRQyX6wRSpeyIvY/QGNJvW3mZKZkqEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

Thanks for working on this, a few comments below.

On 09/10/2026 5:51, Dimitri Daskalakis wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 261c466a4d36..c30d751cac2f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -378,6 +378,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  
>  	kernel_param->hds_thresh = 0;
>  	kernel_param->hds_thresh_max = 0;
> +
> +	if (priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>  }

With HW-GRO off, tcp-data-split is omitted and appears unsupported.
I think it should report disabled when HW-GRO is supported but inactive.

...

> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "TCP-data-split can not be disabled");
> +		return false;

I think the message should emphasize that TCP-data-split can't be
directly/explicitly disabled.

...
> +	/* Disable HW-GRO if it was only kept on for HDS. */
> +	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
> +		netdev_update_features(priv->netdev);

nit: the only transition that needs this is enabled -> auto,
so maybe something like this is preferable:

  if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
      kernel_param->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED)

Thanks,
Nimrod

