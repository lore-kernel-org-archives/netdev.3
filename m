Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED983DEAC8
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961689; cv=fail; b=uNiamYdfbe5e81Do+PsOH+5IdPoBfPDPNw5c+Qlf7sDUFbCDQJhsNGdDjOEXzPI3oGHF1kk4Qm4ALSLty58WxWcIZFBmCg0TSGWcrnxQjc60yUE/jEAVMFt4Oy5CaGXxQpv3vQ6Njocx6DBJ2mBDWuFlpx4PvmBDyBpLsDgM6N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961689; c=relaxed/simple;
	bh=yyKfYMD0lop7oGBhbfwNECRVfiiS769CqkLKxejIy0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmKFkEOCRLu3XLGewivMISv4AX8O7v1GWGV4Kz+nHMAKEHBjU3vt4GTWC7zfzxsn8MKDDIGpsat+Egx+1x5WB3l4hMBm7PBHSiIxMT9OGV01FVdLO2A0ObqWqt+SA3bCgF9bFMNEl+ioUH9VBJSC3sIW/6L6x/35Vxu03EMtHi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oq9EuthY; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oq9EuthY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtSaKl8wE4fKxtTu6A+Hd1rPR6fI6kwzv7I2BK7UOt5VOYSBkGU4Zscaz+w5QbBIC8rfLjevD92CSXMNJV6Uy8gV0LWW10pbZSpF28is/T8v6RhII/5zciCQxsK+HjyMgdBVbTYsh5TArvu4vzuAOJvHRutzjreRV+CHC3SyulgI9MZzgw1Fw90HY43o1FaUq2QbUhHFeb7wjtslGAhfzJW9pHWEw1uUTqqKP6GgCo7VRdAcPDmqJby8+rkr1DTm9qRcX7YCBTKbwDB9Zvu3oNgBAiw/GjoNYeJ/i48ewGdWCFygkGbgTOftumwB+nqB1eRZbO6X7ry4098z72DtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyKfYMD0lop7oGBhbfwNECRVfiiS769CqkLKxejIy0E=;
 b=kKUDQsv+Rn3Hn53iUUaKc/4em8gOObfHltXPVCa/kWGjNhtzkHSXOwtKSNc7q5xHzmkZumITB5kjP7oIIzllcQ5hYFpssqL6m6e9tQ5shpEPm9UujG6i8ro55vijHwo1tYOY0NVv0FLSGLLMnO0DWiRNmBiDwc8YsJLap077R7dqmSjwSoLerQ76V7RoLw/KFa48PaOiQItbF4XnxvwrkDRJa0rdQEf1T543G81+aOyY3xRNjdnY+sAGuZFsTgLJEHBI1PZcNQgMWQM3IfSaJlf3jFEE7ke0qTPRFILUM29n3t4ISAF3JO6MCNmlYZmRfQPXvdv5j0dhoUPx6GItMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyKfYMD0lop7oGBhbfwNECRVfiiS769CqkLKxejIy0E=;
 b=oq9EuthYcbQYf6kYfJ4PQ5arbRzoZBqjIagvszNyLjTgIOlFNChfqLsEwAQ3HYp0p3dym+xL/q9dRaP40FojXzIqu0Y08jLbQaDc5KM0PkSVOWgYdvllTn9SjmQWSKNT4SHcAA49U0eF743Cx7OYPGW6bYm7adstkXyv9vRmUiz6WKQ4DX/9Wm2Yy9l4PU84pwCwIilI+bjvsYXW4X0gNFJ+bm+yXCXebrfzxOk2D5A7kRZYI9dLQOBDtC7F99EeOx7bb5bInRsAp/7Y/IXMHb63bjC7a4D0CgSzgQTWqVS6DNLnS1OkS0bd3vZEE3pC5xuqjg3yKwVT5t6z+DwTgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:14:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:14:42 +0000
Date: Mon, 17 Aug 2026 13:14:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Ren Wei <weir@nebusec.ai>, ncardwell@google.com, netdev@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
	edragain@163.com
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260817101433.GA323029@shredder>
References: <cover.1786610865.git.edragain@163.com>
 <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
 <20260817082803.GA242453@shredder>
 <CANn89iKamqEOMfNmbF9nLGT=+6rPmj3KexW+spPpp4DzJ7G8TA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKamqEOMfNmbF9nLGT=+6rPmj3KexW+spPpp4DzJ7G8TA@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e31cbb-14db-42aa-38c3-08defc485a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WuAbNYuYHfmBwn+sUVghRaSidYXRFjTEISzbVIxcn2zxOPz/eyK19l53ms/UHiWZu0MbtkjIV0FuJ8Tk6v+FdcM+aSGcq2n76QgM47JdgE01+XnG4OWJHqPQbvZqa08MCzb6Uyp4nixiEVEV2a6CrUTA0taMIGT9L+qRA1Phvtfie3lNws9aRkx+jTMXUs55PpN9udS0pK3XfmGzIv8fpJPvW8FEVw8PFzwPfgSnlSl+kU+Y3YYCgd2p9xcAWa4t/++NgJrYWCi/wcUZFyhSgydlBh7OiMX+g0E1mLaMqNvlbSeq+hFudwMh3EJgqLuCn13d+ZNbpYX1Rahb5l9zo+XOLkk8sqfdJK1NXFZUIohlfCxHbBMk5WIk6/eWKitHpjFXip5b+dxXVJTmdZCh09sCPkKu1bSwfc8B0A4sJ4VSodAuZSOkGV4W93b+wzChJCbyJ7tgJxQZOa4SW/lmm8enc8biV3GFYKRS37sgXpp9MM/ev3pG08/syLA1bvz6FdHGJZr36DDChffC1z6tFKnoOIIQQ/3ZeBqLQiwD/tFhi/XbcCYeW2qCDY/+87A+N5ZrtFA1OO9Bq5gwp4eMwPUPo4Ta0NYgj2uaj1LVNrr0jWYnM9xqAzgTfZzDBPPdk1SO1OxiqtZ15RlJYI24uPj6JkR3lm13Mgm6zdBm3bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgx9n3DjkED4TdjRpDj+VmHbL99ohN4k0x0nQNQPbNod05KtYE1DIqtome4M?=
 =?us-ascii?Q?xN5I1IvtujPSozSCjEO9SLwpgfwgpv+XqgjCsK09N9X2A+16h//z6Qr2cTDH?=
 =?us-ascii?Q?jI9CePuqRV5Vw2gyjb84myfuPlzfzVFnvYzItRHccx2ph+R7y1CwLt4TJQ3K?=
 =?us-ascii?Q?ULpKid9wP3Bkay/8wA/fKJCZKPr7oZ60GolRhfsoGjNQ3rU0hpG9Ei27M2+5?=
 =?us-ascii?Q?kHXfsT0c+89acGdT6G1okXgTbn9M4UsvSb8uyv8n5c6m0vg1htFPiq09iNCe?=
 =?us-ascii?Q?97Nx6rHrI0EWzAf3Ir5LKoHPw6tvHP1pTU8gE1/DvNOmLl/m3nyaYyILrL9A?=
 =?us-ascii?Q?vVmhRDK40fFjr58m2yCGQu+95NwLAb4AEiJQcC4rH/Hwy4GQzZBagkKuDqvP?=
 =?us-ascii?Q?kNvoUZapLPRKBccr5iUwrD7IcMF8EIz12RFmPETrifbl6nzJNvlqGwQ01tlB?=
 =?us-ascii?Q?Y7LWTa6+JCv1ZF3sl8wLHtReBy44sqd0pZSx3FHphlvtg6voWPA/2p+k/58e?=
 =?us-ascii?Q?EeVln/+m6EFvT+2zniGaC5/8Wx0vUF1hr6bEyEjdL5uyo0g6ECDuBpKsL+OT?=
 =?us-ascii?Q?0gBP3/VR/hpIuTp/4aVfscJmVRrlz7BS47PkIEa5EfUjE9w5mky0c4yc8/5s?=
 =?us-ascii?Q?aqz+Ee2x312c4Czfcp7ZIVEEJIF7D9l8L9S82kKmUnAOTzZ1ImQOwgndZrn/?=
 =?us-ascii?Q?hPGBlVHOIANMJlsYVRYlVSFckC7JY/lU2LGk53pzQQ9ZhnGNsAQqSuQvbPmG?=
 =?us-ascii?Q?vPJwA7ouOziMG0P/JoghHPfI2SUZreqaaIWUEjE4HA3K26eEpWQ1Hz44XAF1?=
 =?us-ascii?Q?/3qAqlULmTqYU09vuW5vn5CggD+d0T9eUBLgw4a0e5hf9hciKARZ+pR1M/iO?=
 =?us-ascii?Q?gQj1EyCEe9f4rSapI0BRidKpaU0/R9C3lGtUYU+7oeKHUPl4BolvbFUsdCqM?=
 =?us-ascii?Q?hqyfNDw2KMnTnqBaNVZo4oI78M9ZiTreJd1Rd0XV7KoaGYvUZb+2yPzb9bHs?=
 =?us-ascii?Q?b4tDPpUDLTjFnzWIQDtCnDbEyXuEUYtWXKZ31WlGfD6kQCcUgY4gSIOJSIoV?=
 =?us-ascii?Q?mMR8qbQvrWtAhzGxiV0MfjFpT4tdChhYIx1RpN7Kan3QQjItKv12QuWKhe/T?=
 =?us-ascii?Q?hTIcXQrdJyZG5DadHu9VWkg4Jh5FEDcNM9pAkD03QuixMbdvnum2JYpvWSIF?=
 =?us-ascii?Q?M5c6QtpqgEqDZ+2aRoSNGS58tfnlRdMgzvuS0SY0ja02Z9ysUCOaoaFFWaBB?=
 =?us-ascii?Q?lb7LtyFvhaa56zO3zmZkCXfr6lpZ1h5FqaDuVAF3OvxGX9Hd95lcs5h5qBnX?=
 =?us-ascii?Q?oehRsU3kX6cKNxxYwXy2RzZho4z3yCIJM54t1I5aG+n6GuQZJK7k9NjI8dNI?=
 =?us-ascii?Q?n9P2ZtPsGibD5TLB6ItrrhaTlAzg8QXhFD5HneqwR7W/pz3lN1TdkaabP+kT?=
 =?us-ascii?Q?CYaK+lhN19B6ONqpjpTU7mNw2GNFdFq6EpclJEPG06P4SMWnRf1EtT3rWsQr?=
 =?us-ascii?Q?GLvmW7hFaIuM9mZ6g0HOeKr9s6/sRAlr+vYObJEAUH/GfhSLbjfh1+0sH8r3?=
 =?us-ascii?Q?OeEvmOXJrCyCI73o96v2mSLz2ejQdeM3hzlMeTGB2ZOJDBty522aVzZwnJ5Z?=
 =?us-ascii?Q?XFsZ6CJBn7HEmwEGnUcg44tXTxCsWnpdckxYRE0FyKCdYtQ1ocUZsFFpgCyd?=
 =?us-ascii?Q?8C3A7ZukjgK7zOJN51CZI7k8pVB92a3/DW1PD6PyznAcg9GU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e31cbb-14db-42aa-38c3-08defc485a97
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:14:42.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEl76lWH531PUxZ18J/B8Eo7a8SOHMVFdIaCon72q8IRvb8PLgNldoObc8W6xEJuBh/KyR2Hqx/o0GuvooIoZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

On Mon, Aug 17, 2026 at 10:35:32AM +0200, Eric Dumazet wrote:
> Sounds good, although we probably need READ_ONCE()/WRITE_ONCE() annotations.

Thanks for the feedback, Eric.

Is this something you want to post separately from the diff I suggested?

They don't conflict and my diff merely adds a floor to the return value
of dst_metric_advmss(), which TCP already calls.

If you are OK with posting yours separately, then the author can prepare
v2 based on the diff I pasted.

Thanks
