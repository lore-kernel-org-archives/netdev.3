Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B63BED42;
	Thu, 15 Oct 2026 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074780; cv=fail; b=U1QcxRPjvw8PA+ew2LVxnY2ADhCLEvpy+yyDb5J+L0Rx20v6uYObjt5pz4VAt2L2VvuzfjXuqQKVhrGV893Jfjv89oYgsJim1FOxO9qJ7uOm9GoWA27Rgchd8VlVC/3J2rZeGz9rGrOafqWPn66nbtXkanu59IdS50/IlSuKRyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074780; c=relaxed/simple;
	bh=O8aR901RlBnYrLos4/iyHbhBDSEeMVkjeI5MxEWBXlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EOoEIhokV2Wy+3p8OiK8qr2gaqc68TlhWjJGSMXlRQmja5rWXV6per9i33hLK5w2VdPhb7SzcI3VY+KlcnsF9kvnM6ynXy+IQXfw4SaLdQEgD5tj53G2ff3VVv3pnpRPMUGlRdlsSgMrKwGO+EuNOAgVXLTMnWDw0+TKJFgx5A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlcLqap+; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlcLqap+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWuweYMxXMZ5tzIFl5s5Y6iJzeIviuSwXk7A+iNItc1SPYe/LNftKVcg0987Rrjjzbqn6gx3RJbd3xRgIlPhMFrAZSQcTaYszfr9NsMHm68cXryfVzu2pLcFdOEf/fS7R8I6K5dgQ+Yb8m5eV19+CncJadupVwDMHEcTE/10ZkMLvQEuQE3NThhsp1LVQzrfdaVfsZ6u0wGVZCeFTlF2IzkdORyctlNYnx4Q5tBQPzX2nsDN6Iqt7UY4In0Ud0eoOw8OTTVFI7Jdti3/mthdBBO8jJZfAnAPH0jQB9INKs6+3j5tO2pwoShTr0bVWE95RrqW0kSOqTy/cMFE0/SZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5ytRlmNNkAoCh7PF/Aw8OrsRVQRsZMCQEzsVinyXTI=;
 b=H64yAM9XPdQtwioUIhlVpcHUl7Tn/Keh3K4oTjhFEyVmxqzOdy/jJ5lhDHXUnTp9DlwXCRnztpJwR5przxoJkUpUzPH9vZEBgcLozvNs/QNWfmFQnmaNKBI27vzTwDRTbOfm+HHjjOVALfd6COwLRaYXeTa8vTxnPg/bsXSODFUNZtE0K5MktpAXy7TAeeQuUS9FbPcD2HhMklLDJTB6XWVFj3nfvWFX4V/315uYW5Kjei25EvgqVqCpXbyCk1u0nZkC2bRPl53V4QsG+jQiNGIW2j07nAAoTfXSnOcwetPyAJC4fvDBX0nS0ocjwVhmBLQw0TQOUnMA4EXL8AstaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5ytRlmNNkAoCh7PF/Aw8OrsRVQRsZMCQEzsVinyXTI=;
 b=DlcLqap+mrvGHpfScLop0mw4yuTeSgDhDn5CKpbopmUPAT62WhCtN3qiXcjQvKYEVqxKwvqzEn/FtQh4hEH2H6OY80BxgeMn5cMb1iRpC/rBYgJbw3vAxcGQl2UjK/nQoK18NNs49qtst382q5THo1UJRpin3+XsspDl+qa1+3jxKrbOi9m/XzF+MhqOOXn8Lujz+Rwl6hNF92Q7qP8cNvUtc17XjGuu2JbWj1YlQV75tspOGIdeFyHSXQ2OBv5BzOCdyr1CpooNvsS6ZjmRTSSB3JmPeNrfK1WQZjvpkqujfjzRyapn9+oJrairZhuJQxNl5WR2WeDM4PBqLUfwvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:32:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:32:56 +0000
Date: Thu, 15 Oct 2026 17:32:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 4/4] ipv6: do not restart DAD for a dead ifaddr
Message-ID: <20261015143248.GD1794897@shredder>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
 <20261015050651.1841557-5-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015050651.1841557-5-4ncienth@gmail.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7124fee0-9e8b-47e7-f8ae-08df2ac93462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6kGR6DjElxF5eigBwya6Nh0doiKEO9hczLpFrWJ/LdsUf2Dz/tutA9Xw4B9eRRGaNFzzqVAtGAA9FRtqKXnbgUJjqudnGwwQDSIjZtSV5CZfXdTEdUiIWPZTeAxuiQGRhshDJDCDtNg8wJD3EJ97myADA5lMH6XUkPHJqwiz885La2+UBJA46TbrVFBDWG7eMHWwL2pqMav6Sb68j+CawKktGUBl2obNANv2Y7nd4jwGFq+odm/meI8Upz459ZO5cPkogvbyBVLu0BG8LEZWWy9UIssq7yRnedNZm5bek7a+PYTRkQLNX0X056g7QDZPsk9BFRdrgEVSjsm7NEfmfwyu76WTTd0JNUzOSqpTKHC0tqXpu930RDYylacGphIlwEX187hRDQ8+qDs1afZ+Xgro73MI/7KiwqVmsQm4HziC/3GtAh3OCVeZsapXNN87PhJfLMbJBeIcH7ckUKOejbTvfdpgr8p3T3LIpXNbTVfEaDRId5UP+UryUwucQMzL6/xxGvS74yo5KaxX9NDCiBmQKmjhUDruog7F5+UvyOyarFoKetuAoPGJhWPvnFzwxr+2c+pdVJACNLdX7McJR7hwspxJgo0BzewYumAZnTx3N7bFuCEhmE5itLr80QfTYHj6dWrkoO6fAM7BNUayP9UdFvLPiVJoJNTmhLz5rO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JogUu8uHAjZCC/USvs+fPvnwncHTR63/gv+VQfjnGsewKiP5bFDCI/HVeCp?=
 =?us-ascii?Q?EftH4ju+q8OXOK1lLZKCpfCr6ShbEvPd6ztYoP7pRfBKDfD0twCz2NOmFXM2?=
 =?us-ascii?Q?POb2MzOdJZq8TQYsh0j9t2Aw6dnoMn1eX+DC+9f4OyCi1Fm9Bm3k+VXhg+B4?=
 =?us-ascii?Q?0uoUzOK9XDeFNuVtA0dJpTIixFiFCqBSuLKk/qY4NxzaUwQwMPRqOifV+rre?=
 =?us-ascii?Q?22ey1VuD8Ryrp2IgxDnQKmJUOzEYN5bdqNcb8//azBim4gkuaUwjr5HryO+q?=
 =?us-ascii?Q?K5r/6rG7AxDYC9J01qrthMYCWWxrVK99OCeyVF1vPnGZByWP5FSQW0915KNe?=
 =?us-ascii?Q?iPvZ3diCP7T7qWPFz98R/d5Y3IlHRCJ5+idCECpRWhnCPT0/tgH4FhdvvCIy?=
 =?us-ascii?Q?FMj5wLVjC/e1KNIUkg+wUCY9w7md7E3bbNQjXNkvt6iWWXrQJPhRuex6NZbQ?=
 =?us-ascii?Q?WBT8MMo5RWVyRrTOK1zw09CeKskqhtmLMRjFB+jdQ8uGjjJB7OP/IeiJ7zzJ?=
 =?us-ascii?Q?gPmqQOqeLERFFQ6hLQLr+JSi/hdUCH1BbujaeEx0sj2VqkfzQ7a7SD9WGHwD?=
 =?us-ascii?Q?euM9pTD6jVeePGVPxsMs/xKtbSBpnPoFmYk31UpHo0m+a3cI1bU8AbVQlb/o?=
 =?us-ascii?Q?2hsmVh+pIBbOFa5UkhWB+fUAklE+DXp9ofpU8NUa8v6Q3ggVt9frozA819La?=
 =?us-ascii?Q?gfTIkU2cuuN7YO9/wvaXWjepKIAzU9vXkZvAe8cn6WJH3TO52EAICOk2km6y?=
 =?us-ascii?Q?jDatW/RgQRDuBAX6IAiu/xi8f7L1mzH1OTmMWoNQgxPbwAX0Mbdh2LHAaYFJ?=
 =?us-ascii?Q?GJ1+5BLJc3hNOzFCRTmI/UOyqluBiXtd3OwmVfda6cOwaVnFvnbqj1VRwLk/?=
 =?us-ascii?Q?/3LJI3Hm/YGy0yXmJlN9jddC9xI0lkiIwH33XbMYXeNUEDSypUtF36nWIHEG?=
 =?us-ascii?Q?b/sLB1njzWjqZFwB1VTel/m6OitF/nY5q+c05nj1wKE8Epj8gXtIJ5+/Nr4k?=
 =?us-ascii?Q?21NAHJgkthTrzjAxNbjBvzyfdKCdbkr/w+F4wFzZqBiv8p28BNQVv+u1cimp?=
 =?us-ascii?Q?nRERIJdjprP5rrJ3x+eAG7w6RMuxTIpfQHDKFXJrnAWJlVvqlCXcyg8dY2cS?=
 =?us-ascii?Q?BRyQqlAov2IrYjd19juqo6yU6eEFxOJcjWSlwJZB+nS0J2qcczs6vYc+nzbg?=
 =?us-ascii?Q?jV36bjvW+BTR/BfZ/6EJl0yKNyuc99s83LUAdk2vOImHc2xKQN7Le+jp9U3n?=
 =?us-ascii?Q?riPh1cM9+j6qX9xv3t2XtAN9/ZHO7tfwphpnFkCpsMXiFKDLm4qTJP+tJ2ue?=
 =?us-ascii?Q?3WIXe1l6e39vxEzY+BIKD4z5sEpB5nifpp5ELNX8ijBZKNoawX8b/Tw7PT5c?=
 =?us-ascii?Q?pFXO8gjwYDamYtTsXgAzwALadPKZCOkWmod2K8FVslccpJ1OZVgbBGTLKOMZ?=
 =?us-ascii?Q?Floghf9f3SVwcx5zFRJ6LcSL6iFHPVd0jPeAkoV1P5VhDk1wDDu4mU+9tGqk?=
 =?us-ascii?Q?gj7+3wniYd70td1zWYGU2DScKqVRSS+wxFKgY6hoC2g6Zkq0aS0+MDCSJVHO?=
 =?us-ascii?Q?3fZ+V640ZkRVGPfzaRpN247gcoD92aqbmjrh9lK24TMF7qwH5QBGzEZZJsYf?=
 =?us-ascii?Q?h/uqo4iEHWGcRmxlSdX/P5gbm6zRuvSKKL5jk0eQ3j63paVp+KOD82/W/qcN?=
 =?us-ascii?Q?kf4qLzSHv/Ek2elfG9c3aJq6Jnx5YrAhnjfUUyMIcqpL/GJFn/m+2x9mAdoi?=
 =?us-ascii?Q?jNCO4Jinxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7124fee0-9e8b-47e7-f8ae-08df2ac93462
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:32:56.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyKcPeqCZydKwXOSJ9Y9kjbmxVxpLDYlnFmzw7xefZBI5KUXAU3rLUkjL6hQCJPpDpcaJf8NYx6GOLcauI3JNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Thu, Oct 15, 2026 at 02:06:51PM +0900, Daehyeon Ko wrote:
> addrconf_dad_failure() can create a stable-privacy replacement without
> RTNL. After ipv6_add_addr() publishes it, addrconf_ifdown() can mark the
> new ifaddr DEAD, clear its route, and unlink it before the recovery path
> takes ifp2->lock.
> 
> The recovery path then unconditionally changes the state back to PREDAD
> and queues delayed DAD work. The MTU teardown path can leave IF_READY
> set. For an optimistic address, addrconf_dad_begin() can consequently
> pass the cleared NULL route to ip6_ins_rt().
> 
> This follow-on was found by source review and was not separately
> triggered at runtime.
> 
> The new ifaddr is already initialized in PREDAD. Under ifp2->lock, record
> the retry and queue DAD only if teardown has not changed the state to
> DEAD. If teardown wins after this check, the work observes DEAD and exits
> without reviving the address.
> 
> This complements the existing lock_errdad check that preserves the original
> ifaddr's DEAD state after the same function reacquires its lock.
> 
> Fixes: 5f40ef77adb2 ("ipv6: do retries on stable privacy addresses")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/r/179161099408.434549.14449036924552933828@kernel.org
> Link: https://lore.kernel.org/r/20260513025509.3776405-1-lilinmao@kylinos.cn
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Same comment as on the previous patch. My diff [1] was simpler and your
commit message admits that it's fine:

"If teardown wins after this check, the work observes DEAD and exits
without reviving the address"

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[1] https://lore.kernel.org/netdev/20261012151316.GA798355@shredder/
