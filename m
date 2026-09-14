Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E23233936
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367594; cv=fail; b=uUnFEAAi0aqiVcfDPdUD2kUPa/ODSUBPySC3UjPi+tEBtLp1qVQeOyIwqhar4kCqV/v2Oekutg1AeBYTBnOUmKvr9Vj2nEzVchc1dIwkd6hVZsYXjk5dD8G9USHZbfo4mOGdUZFzn2q+jrQTHsZUS3kx82a+HoEZXIXnQFGNyIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367594; c=relaxed/simple;
	bh=JCbpVFb8VFp8d1Ln61cZmpKH1Z5T1wjtwH8CGwIczvU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TeJ+cRLzInLntKw+pG8tFvwViuaQrxKvkwaegz9dL5rWedRnOI4837P9vzpomqjFgALLloJygMZJlGNizWS7m3tqiMD/uAcG1OvZ9wJQEDBzcRC6N4IsFSDdBnQjvX0PjSsbpslotJVTbddhVX/3KE+eo6QfOaZxE6aJ6pK0igQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqU0HMrs; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqU0HMrs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHouRPoLFexoaUMjIsClUWsyziIUD4KGckkvQGkkdcbFsejV9XPHlCyHOXn5pszqPfXf/afWmuG25pQShVpVD0F/m7rH5UgCpLFAe7sOC0K38+5zdPczktAJbeE9N8Jj0Ht8IL/I+rAl30ftZQ9kmD+VYoPID/66pQD8xzzcuMMIphhp/GMogv10EWbojvedbTgjd7nmgWcr5nM52PrQoea4kCp+AE9xk4c/FJ9M2Qt5TAT1he0m7gUz6wCQ1N7xjz2jEouJMNCn+LP9lr40T70MxJNdpPgIwdGMXBACAkNvhfaAasUoq0oA5Pqe1BXUeXwALAv4Iobi25yx9Iy1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXOJfP5V1xTMl9Xc+gHsiGeyAne7mQ9NFBawyqs+0YM=;
 b=SVei1i7/iBDZ8hlfl8GNI1bhBcuR9da6HHMQtIOMBJ64li0aOcp6CDCO5KlWseEFSxHMK3M2eHWbkJTBImkeW4hvWn5ajQA3wSyoAk+89V/QZcHEPpRVl0oouHUcp73V9emzprqNh9bPNHMI+bZ5Xh1kUMnJA+ku5foVSBVDSaLnega8fAWG65Qabpo5F1PKV654XUzf3Bc8Es1bVY1GWapYvDCCsur16W1kX6yW2McbZQrMHbwPHoUaXMcYPyyNbmUZ2Jb2V32Yvll1iP9SRG4RxttANSPTqCdIeb4nf6Jpawhunn+luH8wZoHRxqo3GZppBiZBtWHusRw4m2BQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOJfP5V1xTMl9Xc+gHsiGeyAne7mQ9NFBawyqs+0YM=;
 b=mqU0HMrsux3nMeP4JuyrvDRWZsvhVD4jsjQ/VCD6VzTm50ngohlaSSKF9vDoslABdE64vOi3FFuHbjLQE1O7TotYrbIi+/8g/Y0u2rlbnk2Rc6vP/JPCdJITHd6cI5ubHoesiAQcobpT5Z8MWlNItWxGJ6PKFd4Epac0YYYYgEvTqP4ISBUexHq6syFHijBX9MObb4gUPyQHaQOuWyDXMYZlyN0GGAaMNwW6ouCAh3IX5IecFaft8P61KSJJXvmNoxhEtzg8Wo/g6ITQhU3bFSltEa38H0nPEz7wD3r0juzpyoWxRDNVVpS1CgzYRHa1/curu0+8wXNHc+TNRF6lnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 06:33:07 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:33:07 +0000
Message-ID: <2eecb396-8b5b-4e82-bff5-c163a6c16bb3@nvidia.com>
Date: Mon, 14 Sep 2026 09:33:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: report phc_index as -1 when no PTP clock
 is registered
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b15bfb-972d-4bc5-9bc8-08df122a09d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|921020|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7t4ixkop8nqXfdyY2IH1R1zAR5h70WqAht7C/wNyETWTkohshg2tJbaR6rxpNGo7wArEKOmgnwFJMzhD5uJHpnxatrBgtvy8PE9CVMY72GUM+6y8UR7BnlhaW+wr/qjLTYrfPRFaHF9VwwqtLkiCHX8QyXELK9gx/Y9uI94YGTXmnfSiciZyR5aYCehqw7PG2f65rdNxUwIFLSeEevCPlvCny4OYvQHmNO5mlzwgeqA5EDlzBAvquWfBu6II3nsxDvyNLbRcqgxAdhsSYR3nJaaVloXgqOXt1449Jal/iqFukr19IiJhw9+f4YHQOWJ2d/JPw98jDMr5haiLbnbiuyBjXJM/D9si5wU4dwmD+FV+bhcT6b5z4bXYHyDmebvO//Q3kPKquNXRc7EOyGQhqw97hpvIzqz/8C1x7+fEvog5mfCROD4eoqc+iQkU0vssreaalYirXEUrLMFYS1yfzTzZ7+t66wfae+7adauKxjWrs8/2H7KjdWr1Kbxr9Lq7wI8yXrfCSx3SDRKEIaqZRx0K5kDVV9iQUps0PVSVHEHSk7OG113+/QiKx3KAyizC81ZDB1pYcff8RpC4ceeEWS9f8HAjyrxh2RnAQnSpgd/3oy25XYV1PnuSJzTYG9Uc9y1enzsbiaJwmGC3011QH1Hg8FBD7E7PZcCN7AnS4LrMev8HEevRbAf30XPsv0EPF0s1JVs7xZElZNgt7nFLHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG8wQXVwNWNzN1JLOVpEWFpmbW1HNUNqREpaMElNa2FvaDcwbktrcUM0TWMz?=
 =?utf-8?B?T0VRQk42dG96a2tNN2ladjRXcmVsR0pQWE9mV1JXYmY1UTNiSHZkWU5hNU9t?=
 =?utf-8?B?Z0R4WXdJa0tnSGg0NlVUbTZBMUJjekcrMXVBWEl0Y0FNOEkwSnVHalNiZUpq?=
 =?utf-8?B?Q2lWcnhwUnc2SjR1K0pSNDBFUEd0dXBmZGVUQ3hvaXgyWld4bXlyNjd2MUNa?=
 =?utf-8?B?a1VpV1RZUWNzck1mRDRlUHVsWEsrRHNyWmsyKzZYVXl6TlJkVWRpdmNzbDNo?=
 =?utf-8?B?SHlHeGxHWjBiV3ZmMlgrNzFsbVllWmRiZllKWm5lSThCNVU5UTQyNnlST1FO?=
 =?utf-8?B?WmptOUxzWW8rM2E0YkVtZHpzSCtVSFZ5cWk4TWZTN2o3a2VOZ1BSaklnUnlz?=
 =?utf-8?B?Uy9Cb1d1T2xXT0lkM01CV01Yd0QyaWVWdUZ5NDduSW4xNENJb1JldzU5MklY?=
 =?utf-8?B?YnphbnhVZVVaVjk2aGR4Y1V0WkttZGlCY255UUdlVkgvai9PNWxrQXZ1NjNx?=
 =?utf-8?B?ak1YbnJYenNNLzBnb2xvT2g3Mzh1U3BvbzhTSFF6RXAzQ3V4WTBVN20zS3hz?=
 =?utf-8?B?ZjRudGNhZXRyRFQxQTBaMUxEZDZyMkJ0TjRCdnJnRVBiOEh3S1h0UkhSaUli?=
 =?utf-8?B?Vmh6TXZiaG03NGRUZEs0NGlycmhsOTNQcFZBT0pnaVVwY2doOFErWXdrT1lD?=
 =?utf-8?B?Mm54cVQ0Wm4rbWxUb2xJQTdnaDRyQ0ZaNUZ1eXJoOFNZdFpSeTV0NDZ3VnBn?=
 =?utf-8?B?cW91d2prT1RoRGdQK2VKSk1YMGJvOWRNcjI5L2ZxZmFOYzQwbzF1Vkk1ZWNB?=
 =?utf-8?B?cFRZcVcvOUM5cVc4cnEzc2R0cTE5dGYyaFJmdGlDOHJtQVpEUzQxUDMxT2pB?=
 =?utf-8?B?SjFyb3p6bHVzVFVMcjJrQ1BLT3JzUGRTUE5Rb1U5cFRhME1jazZpZGIyVGxa?=
 =?utf-8?B?L1EzREc1YnhraUJlL2V4bGNRT204QmlMOUxueld5OWk5VDJydDBGaHJRUzVM?=
 =?utf-8?B?bzV6em1JenIyeHltZzl0c1A3aU9TZG5PUHdpT2RGTHBHc0hYd0VhZS9zRjlY?=
 =?utf-8?B?OXhvMHFsa29BRFFyVXVkQVpzQWhmU1FkY2ZPdmRtVGs0My9Gd2FDYlVGSzhN?=
 =?utf-8?B?UDFGeEx5cXdSY1dZMHZwY2QxVTJIU3BaUnBLc3hRWm5ybVhCeWdUTHRHbGQr?=
 =?utf-8?B?UDNYYWJEUm93VkxKL1JPNkpZZGJDeXVsSlpCdVozZUFDY0RaRUJJV0ZGbmdT?=
 =?utf-8?B?NlZOR3dXK256RzQ5UGJFdG8wNWVUSVRET2JtcE9sR0dueTR4ay9ETWc4MEVG?=
 =?utf-8?B?Y0VJVEFUUEJUdTVtR0dwZ1lJRkg4Yk04eDEwc1dJVnVpUzZJTlM0aTdaTGl4?=
 =?utf-8?B?bjRqeE41Z3MrL0dmbDJDaSszY1JIV2VtTXRuVUFOTGxWOG5zU3JXcENKMXV6?=
 =?utf-8?B?RWsvMWtVYm0wUnFwNVVaZHdUR0hxYjhQNmYyMC9uZjFMNnA1OW1sMlFZbm1k?=
 =?utf-8?B?dk81SkhTWlJRaUlMSzVQWjdoUjlDYUNNQklKZzEzbWZIOTExT1Zhd3Rza2ZD?=
 =?utf-8?B?bEx4NUpjMW5sMjVuM2tNaG43M2ZLOWJJZUlIaU02bWtVcG9jOVhUajYxTmZn?=
 =?utf-8?B?S1ZBUkN5bHJ3ZjNWQWpEdkJLeVR2Yyt0RnhKQ1UwelRFWkVsSndrdXoxZXRY?=
 =?utf-8?B?N1pDbjZzbVV3ZUx0cEVtSEVQY0liNG4vRm42SlJMZ3BxWWZRb211aUhJWkdw?=
 =?utf-8?B?eFN1ZFpMRzEwTkkrR1JHdXE4TXZ0cFJXMVB6TFNkZWhUQXhtN2NZaDdBRVFH?=
 =?utf-8?B?alMrbHpLdnZBQ2RWZHJ4UTFKeUZVU25GbEJHSW5GNUhLdDhxc3Z3cU9KZnJL?=
 =?utf-8?B?R2MrWTlubitCYy9GMzF6eU5IaDZKWXJvSC9NVnAxbFVBaUROZTlJcUh3Z1pV?=
 =?utf-8?B?VVZ4bzQrdTRhUm1YcUNmTjBZSklwM0cwb3ZDWGoxN242Y3JlMjEyZ29MVW0x?=
 =?utf-8?B?RHlHTFhaS3NDdnZEd2tFcTNxNWNRcWZmZmd2MHpoVk82b3RmTjVzeDBBMGlk?=
 =?utf-8?B?TUdkUk10OG5TaVBNRzFyUDFwd1lidFo4M0g1Qmh5cVp2MUtWV3QvbXpMaUJL?=
 =?utf-8?B?MnlOUjB5QnF1cmYxakFpUEFEei9saWk5R0FTQ2RiaFZ6cEFLRkhWNi9vYk5a?=
 =?utf-8?B?NWljY3pmUktNd1k0R1JVZVErSTZBbzVsbVRpTDRCbUZ4ejMrTU1WT05hTWdX?=
 =?utf-8?B?WmpaTVQ1Q2h5TGdjZ0ZORXV3RXl0S0hKK0FpZTF1dVVBK1NRT01LUXNOVWZT?=
 =?utf-8?Q?v6IskQJOekKGjHghXO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b15bfb-972d-4bc5-9bc8-08df122a09d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:33:07.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPYYCz6QqGzueNsT9y7cnfUdAt23wDge4DrBNu17I9C+SSEwpSUv2cwUW1acVaw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

On 13/09/2026 0:16, Lorenzo Bianconi wrote:
> When hardware timestamping is supported but no PTP clock has been
> registered yet (e.g. while the interface is down), stmmac_get_ts_info()
> currently reports phc_index as 0. Zero is a valid PHC index and would
> make userspace resolve the wrong clock; the absence of a clock should
> be reported as -1, matching ethtool_init_tsinfo() and
> ethtool_op_get_ts_info().
> 
> Report -1 when no PTP clock is available.
> 
> Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timestamp")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
In all other drivers I just removed the assignment, why not do the same
here?
