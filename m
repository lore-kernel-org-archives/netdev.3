Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435E3D9556;
	Sun, 20 Sep 2026 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886074; cv=fail; b=VyrY3NVv977adsKmI35dRP6a5OluJi0Odrn1Rx1AJxvmvkMJBZPT4RIh+u+F7l26xKAUXvklaVJaeglh4nqpZ8JNo606ckU0aCF4wJBdfXF+G0xMOEFLHbFSm/49PU3gULach1dDJj5sAUXk7idENew3QyR6zM2BSlar+d6UjDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886074; c=relaxed/simple;
	bh=3FFBCtzXJAhFp5Nnz9vMTJWidOJLPIAbZr33XArWoJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAGnuvsj0jB5tarBHiF/RkPdUkIF/fkLMhv6en/sPxJ28HpeyPeMJQztUm9IKmb260+X3Ohw3Tm2uo9ihU1pMDZFH86Tkz1kdv8RUFfriYqD926smTlrpS73vs8dwWmMefVaxUHyETp2E6IVeE6pprpLpk/AARguPPYM58FGpvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eHPaXlqm; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eHPaXlqm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzKnGurzWbXUaHZgovtWw+nif0mYlH3ShV+33M5tSnSoMQmQGMQeXSQKK9svOmwEsvtcoAbevLKA2jZM2HkuBkN2LwKIChhzl1vZdbsymnVdoJUeutIx26ZTmLNlL20GP76QaDnGplWR5VTNLFMqKcUUGT2izs6OxZ6ShqVdbWW2+CswzHMpb7BjgOqUYJjy4yVlSsm4iKeRbxQETbot4wI+L3OWEv/EqetzCnTJqot9dYx5YhZssk2c4duVbALcwPmFEgsGxujsTK5cLjWop+BHfdDagQdgxK+LR5Qwp7oc5p3bhi/hixigJ3CyCyb1cmHdx5givmOZBgwhtDQj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rUSOqmtBLItQLvrjC3e7t871SyuRodfvGgf407woZM=;
 b=sdaObh6xbJUwe6UiyMoaMQ7T/h2+//cO4eW9FAA340C36fLQo1fJKhdwFGmkvSfiiDYSfHjNliXy0D/3kf29xbzk7NcVVx99q9L91/ONwJpz4rWqDK2di9g1OSssAV5aHYtzKOM4jzkzDjGnpQf8WOBPo/IQhSpPvVQ1ZwH4OcGyFNr4hZjWpPD1T/zOQHZajpxjgHJuP3FXkyfR3JZ/JhvjqI5zz3LpBdt7RzYUUab5BYJgZVk9rn698skl+R9IWYazVS26P98zPKvEeQ4Uf8HMdpIUdZg4Z1u/+mfTYYNPOVVOveViZSehOwyqBRY4LmDBFfbkz1kWgstXtqHBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rUSOqmtBLItQLvrjC3e7t871SyuRodfvGgf407woZM=;
 b=eHPaXlqmn69LT7lWqGgWLnXG8qxA9XZ1opVA+G8d+puWA6JE2UhvWC9bJRYBrxiwS/G0DAm12WGkZwx9BCr9Xabj3rHPgKjBWTvNQ9xey8LSuAxMqZmr+swyX9QWqQ0E4zwK+5//jN6NVYMC6e58xEs6aekSajPo93JmGvYahJ/A0OhvYUU3XqOd2C09c+PKJhsSk5i9PxUqJSJkI0lGec7+UBYTMaTr4e0K4RNlI1ADsmmxuBUp5XzBkSGJG6XcHDdn/KJW6eeUCuSUDb+3rwMMZ9Mw7RGMF0PNyIsp7m8zV2bzaNDMEj//VzFRt4kCqUqnh+crnUmr9NIokkzm/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sun, 20 Sep
 2026 06:34:29 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 06:34:23 +0000
Date: Sun, 20 Sep 2026 09:34:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA
 paths
Message-ID: <20260920063412.GA1777922@shredder>
References: <20260918151405.716075-1-adrianox@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918151405.716075-1-adrianox@gmail.com>
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d0f8c0-1de4-4380-53c5-08df16e13557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XKVdtO++ZrGOZNJIFo3ypVd97bJTelaPsd9RCSf7B6vBr5E/h/z6/RzDaml6aZTZ6Or19nXc3a2FJwGCMV9A9O74Uvxai0346rEuLfsg/a5wM/bdkVapsQVfNjwEV3OSmL71X6diXRhg4ITjrauh9ZwL4Wvp4UMe2pmgA1rWzQhj2X3XKEebtV0xUUid8aSDG/58lGeSSZ5TzS6svAUY8kFxql64sgftjosYioXrBiz056VCyljv8yYyt6+gqAC1+yidSc7go+qXVsT1NT/xU2+6NzMxr1Fg6cHlZHj/7o4h1Ck5jRPU5ksjD+HnmlGyKWYSC26xgV1j0MuYFmahANyc8rR1y2K+MxvkoRe4QxK25Q5hii7NFFTycwevpjasZZJS+c7Wtk5gWSUfQr/B/rt1gqJjpd8ApHrya3CQDCRo78vOI6oRCxb+jSfs2X0rxrcD97EiIhhfgb1ywIfMVm1yge3/5tJ5iS4OiY1JBMybJEa9tyF4WgP3n69tgsi72phA8U1ras6z23kB+SasFr3pyqy9qDWmk6nC0m8jAZ9ZHLrNGnkeFmO1qRXdVYLX+V9AtVSKq0DBXjbdShQMhw0kE91WRfIV3wAoC72TvzuvTap0fL9gufsgsuNPFCUHpZmwJrqW9ts4px+qDdDLdff8TBmpjpU7mEcgHTcDhgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdvvNtVoxwLWoJbPhaJOJeUroMbyOBRN8p0ScoSdLv69hbgvk1iQ7L/ybUnS?=
 =?us-ascii?Q?uJfP+yKj1fCCiPCA5VC6W3+XytirXs2nxoUr6CdrqFhjvOtKtdAjzIqy6e1t?=
 =?us-ascii?Q?jPCuhwXkl3fVAnvZmgwF8mGEeH94gOQllgq9aNcX7GzJLc3X61Loi98znvkw?=
 =?us-ascii?Q?XJBae8VUoUQsX8TIX5Lf61cLetlauXVGKWHqYATKxaJUYXQx+FbYrIVBRDgL?=
 =?us-ascii?Q?t/MLXceK042K0+Tee0bRVgc2HSoSc6f2zz5yYVOaxyWtwA5O1YbZLvpJ4Ez7?=
 =?us-ascii?Q?6OpSYfOivyMpkt31OPNM0wYdArMvI/me4QgNtOGDlzR/fIT6o7FZ9v42mQch?=
 =?us-ascii?Q?tdwf9jcEiH643k9maQuBmYkFOd4f7rppbVfeDGv42qJHwu1/tJek+Ot9pMF7?=
 =?us-ascii?Q?J6+UqUnO+577MCkDJxColY758gWLSj+3kXZM15P44HIgmRFx/x3F+GjCvnob?=
 =?us-ascii?Q?LpUbWp++sVBIC1hoRlyextBA8KtbskxT01CoUjmB/eC+NGu1dfUHKC5CDb4n?=
 =?us-ascii?Q?cOVYXfB3Qy3NxI2eqV5nNVDxEjmKRKFE7HdB1Guw2w0iN7y8CPwFnNm8fEuW?=
 =?us-ascii?Q?lAWUORDQ49b4WU5SUzlhub6z5r7mKxU6HoTxTPQym6ZNMxgYS+h5kxxMXGzi?=
 =?us-ascii?Q?QzuZAS3riVrqdIA9D7cx3Xb6l9YOQN8ImwXLtdfCMYddeoPATvtmiOYYVP6L?=
 =?us-ascii?Q?/8nT4AW0o7MZEHcmZKqaraiEMu+IxqnhSO/ZVa5TjYe9VU7TbdiSJZONBjqQ?=
 =?us-ascii?Q?tqObDes+wSuzhd8SjKfRu9BD/ioXSEkmtbxlmZcQREy0GoA1+idY3oozCdps?=
 =?us-ascii?Q?0P5FfTpFyQcz6e5YVPTbnVAqyyheSsxS6XdnDglBMoqg8s1A3MlAi7SfvEow?=
 =?us-ascii?Q?98tflALB5OUp5sWlvErk4cjBlaWula3LoH8wtDyUEB/BNJ1VLxDXTyAt6hQy?=
 =?us-ascii?Q?tXd2BChgFwed7b2vR60ZJyVvconcYUDWcJg5+Wg+e0sk1RC4iqu5HUDvs+JB?=
 =?us-ascii?Q?3RjJzcNk1cLNino4pXdaidvehxEccDDisiu3sK1zQ0kXZ/y4rK2xUK2Ji02U?=
 =?us-ascii?Q?9j0xsEzBJMvYbMg+x1DcpnoFZ1T99hecTtNoic1aKcx5Af+bUsQzUDEcscxy?=
 =?us-ascii?Q?Ty8I2nXQrG5TyDTEugJA1RCZYu/idseeMObF6b22CIntrcTJp84B8MVFMBOT?=
 =?us-ascii?Q?hhDtRQpTi4LjD029MBKCSpIYcyB0I19TkutaT7YcZKsloVw8MIRftfmg/0Cj?=
 =?us-ascii?Q?6QGVy6+DQRg8m3i2V5qG7u8k3LmO2Bp9aPkCSNpfSfRkNuQ0HsYUD3c0S0va?=
 =?us-ascii?Q?2ET+3/dJPCHrp5eWFv6MNibItMvk3WbIkr4/cjO2PWPFyX6eLaNqzziow64r?=
 =?us-ascii?Q?jfCx/RoaQu0iAOB1zzPthi03sXTAOZNJJ7lwWoFOsfKTaIVVQQp7QcTX7SiM?=
 =?us-ascii?Q?4jKBjXDuyK3IEu+7Ips6oDPxcJeqo1JH8rlkzwNwF1gc1GWh4oqFC6wIeii+?=
 =?us-ascii?Q?bFwfWvuDb1ZuyYnqk9z9ptjMvFF7GNjVW2jrEvwWNJPli1J1pdRuJRh6vAOZ?=
 =?us-ascii?Q?yapP6+c/VxlbI3nOAVJSqPuFxnhzToI11CrkaATOy9zHP7tMJsWou01LUZZO?=
 =?us-ascii?Q?HUmTiqDHhJrLIckAFDeX/F8Bumx2hrMDEzQqjzfJSZcE7KGgwk0936QQdp7k?=
 =?us-ascii?Q?QH1oerZu7NdFbNvQILA/6xAS3t+jBOxLwC9fIl6hG9buzHvvFNY3CSOnd8K4?=
 =?us-ascii?Q?1fQgpmuqzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0f8c0-1de4-4380-53c5-08df16e13557
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 06:34:23.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQyWbFDQwLM7WoKwb5xQoW+GxiS/Q9x2E2WC4WJIR6HXkg51/sqnmlhsdWOjeWB2yv/nE3/PnIRe9h93MB5vBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974

On Fri, Sep 18, 2026 at 12:14:05PM -0300, Adriano Cordova wrote:
> proxy_ndp can be enabled per interface, with net.ipv6.conf.all.proxy_ndp
> as a global default. ndisc_recv_ns() checks both, but ip6_forward() and
> ndisc_recv_na() check only the global value. With the per-interface proxy
> ndp set and the global one left at 0, the router answers proxy NS but
> does not pass NDP messages to the proxied target.
> 
> Check both values at these two sites, as ndisc_recv_ns() already does.
> 
> Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Do you have an actual use case for this? Changing a 20 years old user
visible behavior for the sole reason of removing a TODO comment is not
good practice.
