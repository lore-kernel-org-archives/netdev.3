Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A147F3AD
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400548; cv=fail; b=oqhIiMZ5dTaJlE3NClIM4amV4bDTLYZfTF+VOI2SplwFeJJkK3/nOiye37hxHAD20c1XyoXUQ5RTEPUawQaA8v7PAb7p4fEToMEuPo6nqdcpZlDEyoasvWiLcPOkIO0ktJGgTBYGW/Bxhr9Otir1QSVr7FMXUMx9CScxIn1a0co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400548; c=relaxed/simple;
	bh=SlxpXjmw1IKwgmJJwlsoUwCaMVoXTvb8LHxx/YS45Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IP35H23P520QulM9U77h9w6skAzHtocP5UaOaO2b7oXJH2iVCQf5RL5jNIQyQ7TAOOydKkPd4ehzqpwgA7Yr2Nic7ESPwhkp9MJlkubCMWMG93meoUyrRu5CgxqRi14H/Cz9dydsmZXu/CUTRw3pSaZE+y2QnTfFK2stRh9losc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LcQ3TBA0; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LcQ3TBA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVpoGVtQ98g7iTBToh5lGXVcw6O1o2dEdpm0GlL/8TJWcUmW2KUzCIPU48q1GBmj0L8EbluN0ghibpFIkFyOwVNrmOagp9QP+HOScOYL1tJ5KsJwXkjsfJi8nOUzOXrC9hNXszXUg/nUC/FJZVwLrJAGdNKIGqKsbkFBwnFEyrpkRHZHX9uB7FgBlKPsYOe7zPsWLpoJYUFpbmq6cOkrZsN9eHvMzrLKAssDEcAbWFv5B7PXh3ZkRWqAswuSfm9KC31uQ5mnIXN9yLyaUxj7FTHsOSJWRJjOB7xQE7ryF9Aqk484jZPW0fzSTccJZPCaK3VTIuPY9iOH4T6RRogH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPUdqaJCJfw9dZVynkydsaGHpBAvDuO6Gf7MWXZwiCE=;
 b=egkbTuk2cBiG6VywkVWcoL2v+OIT8mkXV6Hg7H6THHtdg1jUgNQN9s60h0x8xMKWQS1JsvoVbYWrhe54IUrXfIxfh6tDzOwyg/E5Iyo9gKOSwM1rBLeWyf+pf0hBo0OtI00hL1pIkvTE9XOVQCHOrgFbnXcWi5YmTE1tZQ1NLwfEx/jBFNl8YaPgfcfnW5/YcHrcdgcx9Mv3/xXsFhcu9iRsUwnC/tcvguZdRIc0HRsuTpRr9R+uSUb5GWtpEezCeBH80N4TNrZwTwcMGPzNDUH5h3g0S5NUJqAvNK0zWBv2NCI5GKdmpLFguC63NMUe/Ulah44dkJ8k0fuSDeeShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPUdqaJCJfw9dZVynkydsaGHpBAvDuO6Gf7MWXZwiCE=;
 b=LcQ3TBA0UFMUS9RarxqRl7/JdC40vflzKLkAwyCxS+f9tTai1b/7T2++KiwgxjQ2hcwqfac9dD1PsRY+zHNPMh93MMwt2d6RrI1aC0nggWpHo+zwqRve3t67MJb5MymsL3nn1RkrOBZO/3q8ouWbechrMJKSolXUJ55fJdvx58lMCiMvrhDjDgmZ1JOjL7Ij478O0xErwsaT/18A2F07Hpka0EQ+SbV0O+6dKZWf5vmwonCnhJeZaKe8EjAHUmcBjzWfxug8BTbNp11zNiTd+zWHGcstIcT5gPdqhmcZ7WVDt7hyGnExRNfPQT9vQlY16X2eZtsS+I3yVyHbRz2n2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by FT1PR12MB227580.namprd12.prod.outlook.com (2603:10b6:170:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:42:23 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:42:23 +0000
Date: Mon, 14 Sep 2026 18:42:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not
 set
Message-ID: <20260914154214.GA422548@shredder>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
 <20260914152721.GB391235@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914152721.GB391235@shredder>
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|FT1PR12MB227580:EE_
X-MS-Office365-Filtering-Correlation-Id: 77166b2c-36ac-4d59-0617-08df1276c531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JijXUlyscMkwJkGuG+/w8v8fskuxtfTdCojhNGRKJQRsvhZFUr1TAjw9Drl5VdJ9NpdCtPgf8u+bYTiXUy/VTgoP/24W1f0pwTnbt0B5yvo92jnEw6Qxa68GIORNNcx7PC9ZtBXszB5IW2yak0D85jAeWnxzlBKngY14VpivBRfov3ZgSit68EgpKgEwzPBuuJg/IqgNt07g6ET+n4k+bvklYMEFroOjYAGOPD+VT8C3nPEayPut86IrDpjDqiDHGWVcEKTKRTRKeYpgwaCMNRrKsbP7ZBlSr/IuLDVtNGe49U6QSt6/iloibxQp6pf0HWzn9Kd0LM1nrAyh2C7qxmqfEAJ6JDkG1trTuY6STddaj1tnRMxCyFGue+TEZud4ti7Mx/YmLrigGR10m+Wpd/WWxEAQaymhKfZUYjfAjHM0c5+9n34WdiL62v4mIya6UFNtMsyp3tJU6U2ZUHbDujWpLub58/oM3N8MNfLd6N8xKWZZ8VIU6GeH8cNx0FmuqxtHuayBD/kjjbH7xppFSnNYwlMtV9AzDEZhe3zU9c1aRhGhBfVyZmVFzhIa5+jevnVCLHhyrY7Pf7GCrMZ7Rkn+ejswAU8OG1qDjIq9GWELrMBBZ6EK1aeEKvElxbU+rvsVb3Z5wcg58jYoiJv83PyVtpZRGdM193LLaScSooY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rujq3qhCaiJo5ZKFUj7++PIvOntWyfifyNdd66nmTosyDTJNvMXc9UsBxbTc?=
 =?us-ascii?Q?w679l0/DynDDIGKQ6ZOUMPHBO9YSAtPTBPbd8h5doWAw+f+LWYuafqUug0Ej?=
 =?us-ascii?Q?v+EMnw6bKkCMzJLe7m6yvuZh54xwyrOeLZby8/mwRoT2bVFEzR/pPthiSkWa?=
 =?us-ascii?Q?t/70Zx/6A4XFTaiWCUyey6oU4J0oi8tzYC4TOmM6wZaY3a1LRtkQphd4s/0y?=
 =?us-ascii?Q?LokilDbBJML3YU453lYcsowv3BCyEGMia90HCtVHyojDn5FxoshYxbF62grV?=
 =?us-ascii?Q?wCIieOz7aW8mUTCpeg/3M2m0tcgfA5S6/wzSWwJCo2DDA/CnA44yltEF0GmC?=
 =?us-ascii?Q?a1GVAh0YGvpmR/Dqdca722OG7M86E5aubbGMaRgtALggz+slfE+koSV6U0U4?=
 =?us-ascii?Q?NwgUw757hW18ZIwIk9JH6xZuAsJdp2cIkfw1Y6UTsMy/15LBnOBYgnDS4/1B?=
 =?us-ascii?Q?n2IGmqD2DFv/5RMMG/uPJLOjSTnHmDxIEv7aD0qUa9Fpkquy8nyFmOQUVYmQ?=
 =?us-ascii?Q?P0GlWSohDrF32Pj+oGx/r9OuwkU1ljnGDTYH9MhlPvXLkh1QU6HsCt7fV4MK?=
 =?us-ascii?Q?DAF0Z2MzJLutvgZj1BWP9v6+tp8eApfIjenar/j1eEztxyCqzLqUyLntafU1?=
 =?us-ascii?Q?jO54Z9Nkf7f3/qPFxGBRdjO8Q2SjzDXSGJp9QBYZQuf1vYmvydM+DpaaOUQv?=
 =?us-ascii?Q?9/RdNGpcWNN+VjRyIEpm3cDbwMdi2sjrx+XdgtUuAnT8d9rh0tKmSoK2TpvF?=
 =?us-ascii?Q?sXcbl66OEJYmQbFrreoS8g5zNmGIxAZy4d1pfhheiMveWE72sdcu3n02PzmT?=
 =?us-ascii?Q?P91Dy67RridtwQtKIgAVaYMH8iZKADyINQjbBGCr9KKKPuAPDczkwe7YzxJd?=
 =?us-ascii?Q?Hf5VtGA9Jy23iqDiEcZX9SpkAdapHY9qyYl3/Yc1gPtvCCeuw/kmbQUEiCrA?=
 =?us-ascii?Q?2Xi/ei0BPLBPIRBEgpbKvAvGTMDBpOJOiezaqTb85UO7XvQAxeYOOd6ezHSE?=
 =?us-ascii?Q?IQJSnesJiVSS8mMJFTXT4aZ2M8PyHTDnxfWVMviPFVDvmo68Q7mEfRt2ijU2?=
 =?us-ascii?Q?wXPasIjDd8Ox9zyoQoYw5Rme8gyEYyoU84BtOY9EOc6x1iK5pHzEODAw/CDs?=
 =?us-ascii?Q?OLkiFHY0jkzyXpo4tcbaS9YRpof9L3I07/RkBMKO+Vsi+vmcgHV4TbcdQ2GP?=
 =?us-ascii?Q?5mkiWA81PUO6lAluHOV1E397j7J6bGNvHgMrfpu0+SpbQv1GJ+yt3DlpSDQP?=
 =?us-ascii?Q?xvS3snJyo5WysYdqhtiJkIxZzgUjq7NHrYTWgaORPTYgQTvkG8+EqiZ8MXtT?=
 =?us-ascii?Q?kIlf5A4oA3FQNCvU2gap/r+s+xYcQOwcmxwpQ5PfhrD3G7rkIUT2ru4KUhe6?=
 =?us-ascii?Q?xNPder/oZujLilGWJghndOVuiuA9LVAi/27mRcQmjxKC6PON1QwpZpf8yYlE?=
 =?us-ascii?Q?xGR0CdJ/d1WVgSmwE0HJOKfigap3DbfdMtm03pcoyYP6nX/q2OQr84AX6nJH?=
 =?us-ascii?Q?IQZjD6tpmTdW8tHY79Pk+1+rC6ngO4fUKexm+c3TUvTCQ28JAb/KArk6Mt9U?=
 =?us-ascii?Q?GApvGCap83M9JZs6ruRtLuCCxHsDq7eb5nyV9KmIsg22mQQOGbuNweA3OrRn?=
 =?us-ascii?Q?dfeuRFqSMjSxAblw9grP0sa0SC1dYNsmjCv8Ek2WGbLgLsxZDRhZqBIL+4Ap?=
 =?us-ascii?Q?S0K/EAjoj+19X4M0D4Y1ES1jHsLWjvbbPcD/dVmv24CKmdQU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77166b2c-36ac-4d59-0617-08df1276c531
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:42:23.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSG43rMk8GnrauWotuJH/q2+3H1XQ+S48lQHsGXYovd8veeFDJ/ca/0rsf/qkq044BunJZ5WrtEWG9ZvHAuVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB227580

On Mon, Sep 14, 2026 at 06:27:21PM +0300, Ido Schimmel wrote:
> On Mon, Sep 14, 2026 at 03:21:59PM +0100, Quentin Armitage wrote:
> > Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly" changed
> > inet_validate_link_af() to call nla_parse_nested() rather than
> > nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is that
> > the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and rejects the
> > message if it is not, whereas previously there was no check for NLA_F_NESTED
> > being set.
> > 
> > The consequence of this is that code which worked prior to Linux 7.1, albeit
> > erroneously not setting NLA_F_NESTED now fails.
> > 
> > In order to maintain backward compatibility, rather than calling
> > nla_parse_nested(), nla_parse_nested_deprecated() should be called, as it is
> > earlier in the function.
> 
> I don't think nla_parse_nested_deprecated() is safe. It will allow
> attributes exceeding the maximum type or with type 0, which can then
> crash in inet_set_link_af(). Can you try nla_parse_deprecated_strict()
> instead?
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index a90be57c63be..4e0e153f504f 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2117,10 +2117,10 @@ static int inet_validate_link_af(const struct net_device *dev,
>  		return err;
>  
>  	if (tb[IFLA_INET_CONF]) {
> -		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
> -				       tb[IFLA_INET_CONF], inet_devconf_policy,
> -				       extack);
> -
> +		err = nla_parse_deprecated_strict(nested_tb, IPV4_DEVCONF_MAX,
> +						  nla_data(tb[IFLA_INET_CONF]),
> +						  nla_len(tb[IFLA_INET_CONF]),
> +						  inet_devconf_policy, extack);
>  		if (err < 0)
>  			return err;
>  	}

Actually, nla_parse() would be closer to what is currently in the tree
and should still fix the breakage:

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..1f747826542a 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2117,10 +2117,10 @@ static int inet_validate_link_af(const struct net_device *dev,
 		return err;
 
 	if (tb[IFLA_INET_CONF]) {
-		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
-				       tb[IFLA_INET_CONF], inet_devconf_policy,
-				       extack);
-
+		err = nla_parse(nested_tb, IPV4_DEVCONF_MAX,
+				nla_data(tb[IFLA_INET_CONF]),
+				nla_len(tb[IFLA_INET_CONF]),
+				inet_devconf_policy, extack);
 		if (err < 0)
 			return err;
 	}

