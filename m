Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793708708;
	b=COPB5q9Kgv2QcS4OllbA6HpY15H3E0A2GYk8XlAD5emtmMleBIhCjffUKeBI1VWHrTH0
	 n/0md2+ad1NV0SPp6Mm9/G2RgXxN8qmT0jQQNv5iOys0C6STYwa7w/B7gnGvGFSYUoC12
	 TNnyoqpbfzHkIDkNP9iKS1wxpPLp5ZeNz9g95lqe1Jur9fugo13HEhuyLt/VsUm9gkkJc
	 lLF5iJSAf+6dax6szYHv11o+95aV11++RTHwFmiSOaqYd7GJLOrHUVW1WTVeFxH1mvzUt
	 ZdmtUt9yNV/0CAXi1R86M6/S4hHoOvVLZOWcN0Q9wBKaawijViU+WvJUDe7dGHJ8jKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708708;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=L21Q2FlvJVH5AOOr4CIqYxd0xClDXYphtL3AsaD2GYg=;
	b=O2SQ/8C1OFoAf50DOhUVvH8N0S9yfH/n9RSa5lvnX8udbkyRrVy/HPRbf8j3t3PK+t+v
	 U081KADYdybe6OoF4umiryzS1BAMZAm/cGfTkWeXOA8FEp2iymMyngAsbEIKA+Af6NpNg
	 FAjRUzqkUHos1uNYZYInqhwvsIa3XVem/B8Dy0EepwJsOVLT1my97ST5WblB5QPK3AcNl
	 h8PC5T2XsOxi3wumdbEc2sZy3tlEtOt2aPWAUIaW0f74aR6Cw7o47uAuwMXq6c67qgvew
	 zvVlBgP6roV6U7SJHB5bS4vD009qd8zWhMxatXNOUjOu3KZPfFPETwIDJoCGVC6EBpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XEzCxe9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85834606A339
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85834606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XEzCxe9e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6e6sCSh8Vbkj7R9S5s59RmF65azurRGzSTaJWQ2jGsvU1+IZBYSQpuDPYf3Q/4nmlU2WI1iWfwgVywQRNPhRyDQEW/K0nVgPmiDAnxVH3y5hCm4p4gLFe7PrPYYfm8Lv1GR1WorY0AIdyida3rrGTBtev2zia/8pA7TcfxEwtsfnUAeEXBCSid4Ow5KYD8aWRyXw5jDpa6S+tzIen+gsng9F8tcedkwOJqsi9laCCHrPdqF1MEFeRUNq6JHWKAyMSzajfA+sUbfSlz7QJWLjgey3vJNc6XBN7o9U51PJWzy3nhs6JRnZ6UK+r/Kk/0yWwGPFMtbRySQFowsWf3w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L21Q2FlvJVH5AOOr4CIqYxd0xClDXYphtL3AsaD2GYg=;
 b=od/HQsEi7Zs0/aEjmcLkrwv6FOEhBwEc2NVNs7WeYtumEM1jVZVW/cS5YMAKvlI3uvGnnRMcrdVVSh4znbh/XxyMil3f6FtWO2/aYZ0DPYXfvsmN0IzS7688GQKtyEwPjDmUV0kN43D2N7jeWvyEqR7prW8hf/GNTBgXpQ2+UZBg9dXfc54y9I2i8yHt1qsWU9jZiVDPH/jy6j/qnDtLLpSiAJG6VF/cqSKp/QYMaFf/IRsukPOmZyaVXtaS9VpBUjQQ4nlDdC9FWNBM6q+aDbDmsL3d2HKeZnH2UmWOAzGbX/nvPW0qycYfaSPsjF/U0QlEL/3EnBs697N1XZ0hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L21Q2FlvJVH5AOOr4CIqYxd0xClDXYphtL3AsaD2GYg=;
 b=XEzCxe9e7FL39BGq7DWhPrzdd6ebBCo4vD6/jWUoNUPMesAzOvkS+g43ncAY35JhboNob5wW3SInBj2bD5LaZ5KDx0DiPW0zNhPVuTfRDn0ZQKSyiRaAIj79asZ8b91K37i5kpEa+agA8uVILJ3DhDSwNcDm0xraHX1/2zuBp0kNDDMDjLrEWniJfxpPW01M5LEtARorK/eyW0cNNDsppWSAdrBicaRM+og5wi49iZz4yWL0La6d+Xr3X7m/6U9L8HWEE6XgniLlfbSue/WoU7mxdnJ7Qtw/5+qCWuIz0LZ4S24kmQKrL2yGcJApdkgKtgXNu/i4RHErUAifqKlAWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 12:25:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Tue, 3 Nov 2026
 12:25:02 +0000
Date: Tue, 3 Nov 2026 14:24:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vincent Bernat <vincent@bernat.ch>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] net/ipv4: check RTNH_F_LINKDOWN before
 ip_ignore_linkdown()
Message-ID: <20261103122450.GA1158309@shredder>
References: <20261102231456.965943-1-vincent@bernat.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102231456.965943-1-vincent@bernat.ch>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb8df5e-4d9e-4047-3c11-08df39a57c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|9063799003|10067099003|18002099003|22082099003|261102123227099003|11063799006|261022075727099003|261026121527099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZaPUpe8H+xpTGHMixW3nlZ1+3nvxZ55o7YzHTr+WI3Py0r2aNWcbqiWlTKTbrdP/te6Cih2CjJErpO4ehFibcHoa1Gzct8wMEPnrljje2oePP6q+VN6i3Q2wBFhXZ7F2vMYvGrgCrT6IfDNfIbml1kcGrL/jp9dWwVYoRKAoFIqmedYSozo4FVX0pNcl1omUh22E/gEe9JCHrdrZAM38G+AIe1T2o7I5fhFJVsWtpazYx9hh+QHzYNr3qZObJBYClpCaefSZt4LFVvw0o1ZjWuVHhpZVvUyxkFWt8wzjpoqcxVnRb42UI0H8xBRAafKMCulq45uxWJfVFIvcGwZFnxjdbeo6eDPmseG2hXwQsUtCBAAt8rQDXclN7uDhJgW7x2cIbP+CnVrL0A+7VG8BAMJde0smeXotNQPwa1awYOyz5tvlGXEDr1Q8FZQ1FEZY9bveLoJxZ1cj9TmQIE2r2TjaaqzbOjrPwPxKLnR+JU2u80A1fikWiOYA8XADIo3dXxUtVnzAETP1DuJ1bxQaakQXEXYvk18t9/lX+mi72dUov4+6/hiV8W+ZTteecxC2GxJP6jI1X1QCcnojRm5IRmL6bdDwoxkuoKEWibjnOHPBwWY4pHVqZnVLX1bRNXK5Pt3mXljRudHyyeS9/IvgkDF3guEGP5wHx2igA4uEMSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(9063799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(11063799006)(261022075727099003)(261026121527099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMBZA8FMLpeCgXwbS8O+1KfUT6YGd5Jiw3+6STmeekavL4NbrvdtKGEMx216?=
 =?us-ascii?Q?XRtdrqIRAb4og4zGGaxCtWnfAoRLSuOpnteSYtKNjHPG+zZ7neQDw3CG+Jm3?=
 =?us-ascii?Q?6wf18LSx6gN1079xNDTuZzEIV6RoRwBIkUV/MYU2SVcEkk8k4J2XuwjJxpNO?=
 =?us-ascii?Q?3jvrsGguFFA1tgzLtnGgbm9+4FOLJ+LVX04s4+MG83HyWw2hNVEJalEXfzRQ?=
 =?us-ascii?Q?FFNpJMHxKqZ8wZNIye2f4ShHYAz7Njqv7sn0Hyil6L8qv2JBDx0Feb5T7v/G?=
 =?us-ascii?Q?r4sfJmzguqoFNu0hXIdO7j2tfpr3RZyPDlStMkOpVESQgoFketK4zcuwpH0m?=
 =?us-ascii?Q?V3dKNg7U8XD/CjD7hmxzMML2b/e1FcCDx+qx4iHzVkZDkljfqei0yMC0lLfz?=
 =?us-ascii?Q?VQTxbmuvxxM6OC4cC5VreNOBlK+LT3n5D0SkU/RcqUm5Oi3RWGO/QhozgITS?=
 =?us-ascii?Q?3GDrrUQnILFA1H4MQGGWy+wiQcznRPQGyurSoKln7bVJY7jCQHuM4f7Nr+QY?=
 =?us-ascii?Q?58neqRhd5jCh+HoAUEp53FVLQi7JokYZi90L1aGWD2BaZ+m47ao+HZF1G5VU?=
 =?us-ascii?Q?TeaEBLQ3XzpNpNBE3tP138WBTu8P0QV6IfRuRbNeQfUXRO0SmIrBqDSa/rAL?=
 =?us-ascii?Q?/iaI5nZ6L7LY9JZui8NXyLzsSIQxJIjFTqPHzVOM1pxJTj5imLav1L/+x2fe?=
 =?us-ascii?Q?AqGl/59v9iE1jauZZmT+ejLNDSH/HlxBBJQnaih8PhjkYQ8bg+wz7xZdL1Nh?=
 =?us-ascii?Q?d/cLswRN57JOw9Tar4UOmky9CYdz5cEWCImtXoskJo3KEMCXmSJZEQoLPgr3?=
 =?us-ascii?Q?m8W5EmAp5GFGhFeFXpDM19rP2KlnHRHEeMAJ7KvWP2G1Zut0eDFEx6qzz3lb?=
 =?us-ascii?Q?gKAidLEyiMBSBuw7nzmsxpDqhQbG7zDdZMPNGGewu4GJtRG68gyoSMnTWpTK?=
 =?us-ascii?Q?dGwRbOdL+Yrkwhh0saXJaPrs0DjMNThemdzh/FQmfuDmmny2iZrBHEufdYeX?=
 =?us-ascii?Q?DcXHt8VQwBhUUkJdpCW3QeZsIhYTLjriEp1Mu7PKz5VAwQB9DrN2pLFnoDPa?=
 =?us-ascii?Q?orjrsI3iveBRKYPVjp0r9ytD3Geei5Ko5m2Rw4qQT/+bOKUKnZdmCyDDC/EF?=
 =?us-ascii?Q?r4gcg7B++cRcRPVitSssPrPzBHlhNj/fxcv5OCaVEdFqDqgZRCTGZuCEMs7x?=
 =?us-ascii?Q?Uq4KH5/6ujh5gpQY75Ktwa+po5SIJ4WNXFe9FNRUUFNpiWdjnFywBjkKouNf?=
 =?us-ascii?Q?C9YcKgYYAm1kelR/58sP2eU0p31uc9InDEn/fMe1M6TVNl3MszSs5KWkJ6V+?=
 =?us-ascii?Q?D9sF3As2vPWqf1sUr/Jg+mxPESuAsqxmH8dLsjhkrRdmmEAwpl82LcCVDOWS?=
 =?us-ascii?Q?dHhj0ML2CxjDJMyeZE1vSsFZIli9MbCaPlkr6dYjqoLWDI+XWI+ZMhGHQbc3?=
 =?us-ascii?Q?gDtlC2NTNIz5B6sA1KX6QAg1p66ijaPX6EoADQLTY03QfsqS7LEBHbo/hICg?=
 =?us-ascii?Q?qYxDitZTHhYBqTLrqKba4lafwHF8tfGL4qbLFYFRwdAwYXYz6WpqOKJg/Pue?=
 =?us-ascii?Q?XNrulGMPLTqq8oXhZ7K4sxlEYCniReVDXxtuRubqMR5cqK2dHMc/nbQLnS8i?=
 =?us-ascii?Q?RGEqPEQoCfX9l7nPar2w+pbe0FWoeJHoo51ShzaHfpXL52YEWxg9y96fAe04?=
 =?us-ascii?Q?/NNjUGi3Hr93LDtwlASYij6903iG1QRnbweFXsu0DJ72zfh+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb8df5e-4d9e-4047-3c11-08df39a57c02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:25:02.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iW1q8rxQ2u4yzpOJSCUT2VOXPnmv8Oq95cuXeESn2WMurmOcIK/CDM1cuE2R9Nm7hDCQHZwaqwJbzuQKcLIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

On Tue, Nov 03, 2026 at 12:13:30AM +0100, Vincent Bernat wrote:
> In commit c0c5a60f0f13 ("net: evaluate
> net.ipvX.conf.all.ignore_routes_with_linkdown"), I introduced a small
> performance regression of about 5 cycles per lookup by adding several
> dependent memory loads through `IN_DEV_ORCONF`.
> 
> This patch cancels this regression in the most common case where an
> interface is not down.
> 
> Here is the distribution before this fix for lookups in a table with
> 500k /32 routes:

[...]

> 
> The median lookup time goes from 132 to 126 cycls. Benchmark were run in
> a VM pinned to an isolated CPU and running on an AMD EPYC 8024P (Zen
> 4c).
> 
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>

For net-next:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
