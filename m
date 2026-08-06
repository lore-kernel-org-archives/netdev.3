Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAB40911F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013760; cv=fail; b=fotqUMj0j17FcSX4mFYwnzBO85M3MwgowYxXukkmUI1LehPuuPWRME5U+YeweeMjz6jLK5IkJ8CfpBkx+mGaw0tkDO5Zf+Pi301axhO8+e/AVxF3mttJsyhZD5MKzcLofx1AeugbQECsI3aGwV0hI+Ru/9WANcq8zfzZR9tUMpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013760; c=relaxed/simple;
	bh=nx/crkyt4SGEclAlPWIE0/8Anm//9xj/69jNJjqrGFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dg7tlX241jkmogLl0ZrKnAKkI6n27NR80dW838ob3ac9yJI8K7r/+6unUvw8gmYIFN6kO2HEy8ReifGBncIL6F9adHPv5E6+cQkqTDIs5b5ASzMXwjLAhES/fCE2qeBIwb6xmAqHsKXsPUDs4CMHzDJn17CDVsqTS7XX0IPYGaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXhuk/nc; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXhuk/nc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOdMa+FCcA8qRHxWpOq4TzpFyIFFb1NbdL9HSV9REFG3m1652nhtQsh1G2s3RL30JJpiuL1zQU+++QzW+q9tJPGYhD9ZcZDEggzwHSEXSm5cPc0Is+8YN4NfDejaGub2Gs4UDC4CoEO2ojCV/sciQwQHfW3vYDjH3ZCyGn7NdRCg3HH1AJoz7z2cQ1b0DMbKyY0QFgkLqw5+abmdxIL8sxM2uVD/OjZCU7r3r7XLN+yd0vUl42YCOic2a4/fnXzYkxIwHkccCuV5zffFZGA1aintOakksfvyaKydGnbwH7NuJM3cSfayymfraVPn+LD5Dst23C0SRLigEnyYJ2qZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7rLVAUHHsbP0kV8r1fERSnJzCXHyOqxhZ3MH3vGwRQ=;
 b=R1hSvGXS3R6haoBdZvouDRq4K7idRkoijP6iVNjynudlVGc73jdXM5L15PbUCYD6BptIFFrKNYncM4YeiSFR34xzushLVvmUH3DNBNhzvhDr5ef68h+QqFIf16RlCwN6PiwW1342LIH3tZg7oKBJziHX0AE4eab8LckVk85judl/NTScyvJ8HcyRZPLx7eops7hCDHRxi8cTFkns/lO0hBTW6iXgBX5TOl2hRxBSimRY0yMFjq7G6pVqcY+LUnFcLJpPMhXhJ/pNAjhg2KEAIm2EzgT39ggPnZ8zae1zOtQ6Nw7xuWwSXYx7Bvkl4ogNJAxTe4yuAdAhZoEjhtIC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7rLVAUHHsbP0kV8r1fERSnJzCXHyOqxhZ3MH3vGwRQ=;
 b=EXhuk/nc+a2aCrP6hhpe8Mvt4oPKdTzIogl9bYsIWiU+es8GizNaWLGP33NPsC8G1nunW8LS4Dm2LjfMA/drypecp81gUCXG0Uy1kHGls0iONpcPQMyGKDpT4URjLEDRYhrI6fUiWzkmVnB9XJ9U+hmtUOWBYDp2HAuSyCzmDAt1hTxGKpz80M5ve9xqlLuoZXp/YF1xwn8GlNasRXzBFGJeBPl9DyJcLo9syASmCR/ukeb/cLwT7tNFhBzxasteqQZrROfD9z1HZG9luwGzxp++9KPDF8ds7uWYHDYAhsF2bLj3ta6HfZ2pa/yjEgxv1M6MfpEsZXepzhplTBm+1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:55:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 10:55:54 +0000
Date: Thu, 6 Aug 2026 13:55:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: zhilinz@nebusec.ai, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260806105546.GB1818763@shredder>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
 <20260805013126.4161847-1-kuba@kernel.org>
 <20260805081737.GA1284302@shredder>
 <20260805163740.3f921dee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805163740.3f921dee@kernel.org>
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c4dde9-ea4c-40a3-9643-08def3a949e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5dsXdylXT07kzlTbl8XVufFA8fkf66fSb9o8ZYT5DBwxFX4m6C8F1j+CbJj/OHT0WxyevjTXaJpzDlTkD/DovAFpr03KcUW8e8dThXqr1bwaApwZO5mwMTZKUOpG52R8jzl7vg/CpNUmcIrzHRkxYtOWVtSkFphlujvANgubgj/V27BJT662Et2Fl7106DQ4lM13/L2BW6z8gDKofaIXSmrh66sGSEs5pBatGyeQL5DQGIXeF6a8Qvq42AJ005pDuboh1E1OCUdQl5lzugUOEOv+Os15lC/ci5jcr4Ilm2FGWa51eTB13wyaagaqZGShDOsphZucssct2Ar3xN2eypFoa8c0W9GBNvTwwPH6vbnDoFTBcqtpKIxlUl4hq5thcxz0Xh+s73kc3ua9B3vosXT4HzFBWcHuW7avAMy5sa+663jhuABk8gIZ690vndLjjPKVmHQHLBFuIVVaqJM7A/DzRiu8t87lVVRHttBPn8WMgjsJ1CkJw99vBK4xOD5AHaq9ejj3f5k6tfkVqprTa9oOx8/azJy8i9xbOxkh37pWOAdtgBxOerDs3vZkYkUiZF69BbOn5FelQNkH2UI19bcMEV2q8ZE9CkQlqSuv97gxYDXonVXG24LnFtHCl564JLQvVsV7xTQssvKhQWnFm2lSV5dNBXlN6i11HbYZSfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAO/9w8Oo5lhQ3LaMqqX26uNEsjjm0uEfiIEKGJ3Nz25vmnF4p1y2v4/BZvM?=
 =?us-ascii?Q?d7dP21TNlCv8kuS0YcrseBxXFk7HLMWzM1E0neNj9IaikEHdoy8bELX4REql?=
 =?us-ascii?Q?nhJJQaflNxXeM+0H6PrN0D2qpMg5RorYm8em6yrbCqn0J9bnHKRf7xE3X+K0?=
 =?us-ascii?Q?rC3QVYy9K26aYvV7cvQ0AqZONUBa1mKUhHp7OELEeuFTqpYkZddhyBBKi/Ac?=
 =?us-ascii?Q?kcd4YBMK7HEiL2TImQiSgH39P0cM5Khkc3wO41++KGhJMAQqzngj14/CwkPt?=
 =?us-ascii?Q?EPDaf1/TBDzJOY5niU4n1CFKOFLtw2+jXD6RALT6glT51lCVJL88Hlv+CIhq?=
 =?us-ascii?Q?s1a8eiidQAWIlMH6zHpB6Yauyrt+bAhlL/cTI5iFEG08aTuTwAdvLaTl9HMv?=
 =?us-ascii?Q?PRZ1PsXpQvEg6BsbtJdngdBKBy8G8d1MCR6Tmj4/9d2aPVI3orqm3CvwnZVk?=
 =?us-ascii?Q?Lt56S4mwoz22cLvB85B8gzQRU4XGEXXMJtKVv2APtCpHWomojHrFCe7Eyr0X?=
 =?us-ascii?Q?t0z8F4BLwGcBdHNolliVWIfpIoCw8FEcbKCHX5/B0bp0yAml5MUsdIwzmJRJ?=
 =?us-ascii?Q?3F7CWCN+iRiv/kCTMzMIkVbqogXDNhVFcnh6t1uM/qqUXeHrVbAZD/CENaDL?=
 =?us-ascii?Q?hoKoGmr22ZgXuPqnG8pfieRxvf0aKweeqEIiS1zUqnl5K+muKWr4tJSbvaiC?=
 =?us-ascii?Q?EoWRyCZtBk0Ljl6P32Fb58ToTrTk3iwKJ+d0d0yQhhP8L9HQ4wiaJpO9A4Jk?=
 =?us-ascii?Q?tIJ7L5u5QVXgOGA3c74e6iStnOVDwxC7Bqf/kIpomsqXjdEGASnDWbEm+3u8?=
 =?us-ascii?Q?cPxwUDfEierm0P8vfZHYxHTlMx+lNvPOcfZY9mvby0CfIaDUNcBnRmNihGqH?=
 =?us-ascii?Q?ILZmFVqO9rmVj0WwxCl5BXlB6XWiBiZHMvQY/jP7ISxR3pY6OMWCV/TXeywM?=
 =?us-ascii?Q?XK1ILUAW/6SJhlRqeYclomQEAw4/6XpjVFM+b9cGy6Lnsob3SWAE+yqZLvEB?=
 =?us-ascii?Q?Mh5q2SpnZq/gK8aNrzl/NQX6YCtZCMQCYwaiw43ZWUVHAGI4Te12Gqq9iILz?=
 =?us-ascii?Q?UhBCx81p+9qFCH6yEmN51TJ+OXETTM3Idk5KuCdxA1+tT7mZNkKReMVE7Ijt?=
 =?us-ascii?Q?H+CcUJffwE2QLaAU+0Mie8Ca3dcet7+YZcNyAvYqHWZpIGUfZzP/nhAmSPm3?=
 =?us-ascii?Q?nZgHYZDXBZ/adHJaFJYC1c4gPTGi0okPtAEyHlughOUS24gApxondiZJb3Ly?=
 =?us-ascii?Q?T3l7SG+hwueYBH2G0Xaor9KPvzQ22dStG3hGKqnwtO3ZU9rQsGC9XXlmwDcJ?=
 =?us-ascii?Q?oRMTvFgSCDoxa5mKLH3O4ivUe82OoJExdGDmEJg1vNgblp42xTQV0h4QTmB0?=
 =?us-ascii?Q?u7hE3eJYanwkDlgCSLp557vRlV6bJA/CV3+FZxj+9fC17hfDZN/RZ69tIKgz?=
 =?us-ascii?Q?GUf1LA4b0xtyf1JpWWkl5xzcv38aH0+sSdcMBpvCnMVhAjpcLKZ8Zs1fG0o3?=
 =?us-ascii?Q?lnQyBdGECRz2vRXjJPxV+2FPr4vytJYmkFu/Xd6Z18zS/1yqEce8Y3kPhlOk?=
 =?us-ascii?Q?6sP4geEDhoeFU8KCbHWN9MHOeCT8H/2dlwclMcz/9PwWL2qizILWNnZUPPe8?=
 =?us-ascii?Q?bNE5Lc+NfYvbWsq4jam9cghqYM0+/ywEdFsVjTdfMP9C95w8l5rKiOux3IIX?=
 =?us-ascii?Q?n16F163SdhBqIUeFT5uaC3gzT8tPDbzXsd27VnsUJa3WB3yhc8x3J9iWQ9Yz?=
 =?us-ascii?Q?e+Mxlw/9hQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c4dde9-ea4c-40a3-9643-08def3a949e8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:55:54.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z3EotSXoWt2bRwTFjqTPovku1bu8bxL0VLXM238v4dO3vcBPiOcdHxFzBh/TJWfWhkfNbmYI6haEq4MQc2nHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

On Wed, Aug 05, 2026 at 04:37:40PM -0700, Jakub Kicinski wrote:
> On Wed, 5 Aug 2026 11:17:37 +0300 Ido Schimmel wrote:
> > On Tue, Aug 04, 2026 at 06:31:26PM -0700, Jakub Kicinski wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email says "Looks legit, let's fix both in one patch?"  
> > 
> > I suggested [1], but the bug in the IGMPMSG_WHOLEPKT /
> > IGMPMSG_WRVIFWHOLE branch needs a different Fixes tag (it precedes
> > bb7403655b3c) and Sashiko [2][3] found another bug in this code:
> 
> Orthogonal but do you wait for Clashiko (netdev-ai) before posting 
> the review? If you do I'll assume you already screened it going forward?

I did screen it this time which is why I left a comment before tagging
the patch. You can count on it going forward.
