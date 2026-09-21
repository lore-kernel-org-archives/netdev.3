Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F344825D8;
	Mon, 21 Sep 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990382; cv=fail; b=XLLGpGB7i67q6XHRAWcqIGlAhu2OOm0zrZj1CxlEBwlCInzQ7QN44oBSmxzPhMfBjE1aK4ZPkwth46clyDkPufRCjSm8DSV0EsYUsD5V2U1xAxJEQ5W6F+vLHR7btcv5VtUvfHlBm0YoOrbvIxZqbudkHz6FHJ4rOfrAuQD+1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990382; c=relaxed/simple;
	bh=PlvSLWRimtQ3bhfmtl3dL3ulnfpCvzUKSxe0OiISpEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E/f7ooOBOKILAAkif+sPlIQS24Qw2tSATBdoxlfNWBoIV6/Mse7pHmKjJ2cdlDrMFM9pXX1Kx/F64UXQiOamHDtT6LiiCNRMLzDxyQM4Wg33gMDk8kjKrJYETMgCLvpBAzQExA9b0xDt2yXNBSXYAbmgSvIGnjsfix6+HPg7O5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzpKSKh7; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzpKSKh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9jV2Dp4jIZGWZ1nAH2sgCna6nb9utKpM5hiOSY/K5GJPdJLY+BZd60n4093dyGQCYdrFoIp0RZJRsgkpHc8GyAP9AJHPeDvfe9S0cDh/A7FD9GW6dd5p5MbzkLsc4rygshKvCKvIdelG3RstD1IlKrXtxy150OF1nHRKNHslzeR1PIYfh4qsQKMy/jJtRY1A1Xr/3EzKVwT9y6SdHqCR9a3WV5j1meEBQuCKhjjY76CC3Opzx/QmX37/Z2UBSCZHTVOJl3ytRpEl1+eer/vu+x2kxYXjc5AAyisRgzBwZ3QdTBUsu9OEE9E3PlZuA7VYdra9YjkKNyvR4O4FJyd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEBnJyIVEt+ZJYhEIvDH/ZkXR8m3YXTqfoVqj/qdg2M=;
 b=gGxkrns4abIwAlfbYjpiXIzNlAQwtCBMLlPN5JOREsvXVO2CsGUEwC3jorMLHFdbH0IHbqEG4l9TXx+TTUkS5jBiDB9dhUH1Q0Rd6W4iomHxlJTZoZGJL2jTBiUgx5fY9GoJX9Y5kakDCicQogvpEVqzybyeLx+cKrxWimQdO74/KXVwiXaglut0MtjpF/gg1i3j092ivR1p7LTwYHhB12al11jlCZ96dh0wCM059bTOMhoeta0vUr8X5zqD7YrSjLyubKNTWZhh/+QYgRsUoqZgVa7ieCwY4OonKASRWrdEt+D/O/jtZxjKLMQvqA7ZzH7Cf6ws5PKdodEN7Li8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEBnJyIVEt+ZJYhEIvDH/ZkXR8m3YXTqfoVqj/qdg2M=;
 b=KzpKSKh77cgokh0DThLJe3IrTwsTY1vWNTvCRHg9iALKSra/fyXtE6rHT7yds9BnBhbNX56ds+Xi1/Us7uacLpPu5fH1U9jaLZzD+0xAhPGQhYco1bAGwaGkZaDRH1kg/G+IRZRmhQyAzrgQ2faiklVaUsqjvK4p2K87eP2L4el+tC46CTyOXBSYbmi0moOXFBeHORpyAZ+arg9qLo/lh5ITJNld/JglX7zQYpKfho38/wJXFRLzvAzRjUAxzLwq21nODtNRNQG4pxbWHpMClGVcSm3oTRJ3tWU6ASQBU1I/d/kmqOJijr7R3LZkJovPA2L4BZeCfqhIme6r7V6ZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:32:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:32:56 +0000
Date: Mon, 21 Sep 2026 14:32:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tgraf@suug.ch, pshelar@nicira.com,
	linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v2] ip_gre: Reject enabling collect metadata through
 changelink
Message-ID: <20260921113245.GA2154085@shredder>
References: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 4862164c-f158-4892-9297-08df17d414b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GsR/pNQkT/k7KDIv9DoRcD6Zc78CdmfRwzuh0CQ1QJSIUOGCmZEOHoEt3knnqTP9/ScRJkgrjXnyKtmqLeY2GpAR9Oob4vvZyYdNsPAVaOue7AeCUI389sNFBJxpxQTXYiOQvK7M+v1JX9RsMgl4AMsJnF/uNURSC0AEzFinWhXdfJtU8rd2z0aYMY9Qd6y/0pq/WZPBkyyloza11+E00UBufySXfn+GYVUJzjs0ct/T94SD3gDJ/Dx3ZH7KBCmGi7txin91+VjVu34hc/aVesZgwr6+FbQQvEC+UONj6LxFWmikn8d3RilFGcdXirAK4ixWVAc0HbMj3XYosFdSlBfpRUHN+AK0XwNxYF3tEyNxIMDhGrWEeH5+aVUP2rSw/+JuM1q2bEsPwa0HY7Qo1uN4NGFxCrAjaPIXV6ujNX1yVRtDBawWZ/y9Auq0/X+3zExBQEYGnhlRrHCl1XyC1GWLgBWQDKUvtCzzu2QDjczegDtAIVeFDAyXEVbG6kZlv7nx0kqq7JQ2gmUc99l00j/H4qvTytJAkCspA+0spcyznUcedUAY98W+oWFt3Drxql8frXnbGLIYEyCIFh+nKeo/7CtAUSt/IfXVCtGDX2/xiNDA5I4k1hH8ocuVpWyR4FuT/ywhri9MEiBdc7ZSWPBr+ldYiBsq15ADQIigx/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjVJfMbiYZ7xRQJltCqh9joA9PbIKmqwJVfXjUwG36oGbo0vu7+tSp35XEr3?=
 =?us-ascii?Q?RKVwlv/jypkdXuxVt3Vbn6L2QLVVGAdNebcLtu4llvBOsgPhux18fZd/faAO?=
 =?us-ascii?Q?6p3JXjFiXd7wNXUuJi2Hx0Xh7gA2ceRBL2eEexw12sLtxBHhervrWlZJ/8th?=
 =?us-ascii?Q?pNu6uh4H+IXflItp1nvVwSljYmJu/rhK6rw6+A10i3xBR6nc8CyQ65MOxY4z?=
 =?us-ascii?Q?UWi/+U1s9wVcPjnF0zljlUABve0v3E3kXXOwQ8v1VBpWp4Wjo98A9Xvg6seR?=
 =?us-ascii?Q?nfQmaUDSFYq7qhrdbO7ZgifiKw2CN8W487XioA2QsCh801kHtR4XxrancUXz?=
 =?us-ascii?Q?Z1GBcdQB9IJzpmyx01jQDVZPKc04UrYslInHrxh7Jt5UC653ub16T2pqNTLK?=
 =?us-ascii?Q?aFt1N4aAy8qJUPF0zQU5jMhklBCYpgyshacCFTUrgBGmnnDm4bw/HrIds3BZ?=
 =?us-ascii?Q?31O27aQmgewJKua8+NdhRVrfirMfU+OwUSChVEyMHrpR/P26ED5ad3dyVdaF?=
 =?us-ascii?Q?zdtf3fargM9PN4mPuc5spVBO6jpXolZF9U4KUjTzUnSuHD7CdIdyYsTUu3Tq?=
 =?us-ascii?Q?GK95n9O1EfHRRoUzcfeY/9+iRYEEi58JwqBUrPurJ/QPuz7CiiJxb/Af0Zyi?=
 =?us-ascii?Q?RjH7kFLWobb7zUdJBaDWtby7ye5ugg4WFXA9j1dfp+E94XkZG6ATEwstX7uP?=
 =?us-ascii?Q?gsJqDC1kujWHXutCSrNwYemAx/x71c9kVVASPLoxC0VzhF3dNqpcFpKgYzzC?=
 =?us-ascii?Q?F77GZRMnbZXrtdAdmBffStDM+1DHmx8CFAw8TXNFhrEEQ9z280//TIGFwkyv?=
 =?us-ascii?Q?0hXs0xiJ++hsFpcQSk7gzsiREmwF9P8z9/V27JCgu6qOQ9xm9S0FnUZpdWmG?=
 =?us-ascii?Q?D0D6527s5fdySzXeMryr/2BVo+eIkpgsrONGQxQuMGh1izCLMQEo/VcGERPG?=
 =?us-ascii?Q?V++65MOFS3udwF7CMQYYSLVHcdyOkm8n2A7TUifoqc6YrALZMSUW3B3wblG4?=
 =?us-ascii?Q?4X6OLGEFfk44p+ZOQvU4pPWCVjgz462ocfEPRaP9iwMukRBGcdTGzHWUsfVV?=
 =?us-ascii?Q?ARogyIsI2wFqmBglYpAF0s2HHXr1iFTPFoSaNNaQhRq7Q6Wu9q4KTNoPjI3s?=
 =?us-ascii?Q?9IAMvbPwjdXdtXTzUx/L2Ah233eeEcYZ9EFy4cmIkQfVL2OwJus9z+/FGF2Q?=
 =?us-ascii?Q?snTiXjGL1nFi4D81aaD7lXN8au6TpftZ/ayBiEbeURt/Ts2ojHaRRD69feuw?=
 =?us-ascii?Q?5oRBFnLjsHbbMQRL3L3CMopOXqePKn1aT0vcNbfNEc/0UGixBd53zNh98ejz?=
 =?us-ascii?Q?Y2PMiceyJYGXOkFDOu5fgrgoOWqtdw1HnuJi1d41l3YDG2P4cz1sx3nv+Pv5?=
 =?us-ascii?Q?SiFPmPeJIa5OLkbuNGfnmiO/DR/dMieBXXVbdCcqMXNVCNXkldqu0QdKivZD?=
 =?us-ascii?Q?K6JYueW74IU1HjM1gJIcU62D4uvhuScWQkTD4LNjC2y8Sz37HROxTR7dQSEU?=
 =?us-ascii?Q?MmBAcqthhaOw5Gv71YnQXcnSNYo8PFhOsU9E/af/MzaI70Wfxbn5ATOBk1GL?=
 =?us-ascii?Q?noSJOLGoIl97ZlMv6D7mOxJHf2tbKP6nfBABIXdrZ22pwdLg502jyAYVXUCU?=
 =?us-ascii?Q?7BJ+UWFKiNsHxDGmmAWRxRYYTdVsBuIWoQnTuOZtoDj9W4XNZjf8sTKweyAA?=
 =?us-ascii?Q?fLpJsJmhoUNXPZN6rLxACTEC6C88iyv5ZTt8ZSymI7LinsEff8Q600Wv+4O+?=
 =?us-ascii?Q?F74+I/UteA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4862164c-f158-4892-9297-08df17d414b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:32:56.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy38xnEdvhbcJaviZA0d/CibxugLu5U1k1I5R8shkpkAzTR32h1HxsFR46UG/1Yd8kUIMHcHiI9nYeVF/bNKGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

On Mon, Sep 21, 2026 at 11:18:59AM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ipgre_netlink_parms() can enable collect_md on an existing GRE, GRETAP
> or ERSPAN device. Unlike newlink, changelink does not enforce metadata
> tunnel uniqueness. Converting a non-metadata device can therefore
> replace the metadata receive entry for another device of the same type
> in the same netns. Deleting either device then clears the shared entry,
> breaking metadata receive lookup for the surviving device.
> 
> If parameter validation fails after collect_md is set, deleting the
> modified device can also clear an entry it never owned.
> 
> Reject enabling metadata mode in both changelink callbacks before any
> encapsulation or tunnel parameters are modified. Allow requests that
> repeat the metadata attribute on an existing metadata device.
> 
> Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

NL_SET_ERR_MSG_ATTR() would have been better, but I don't think it
warrants a v3.
