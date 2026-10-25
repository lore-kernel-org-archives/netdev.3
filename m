Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792933951;
	b=hTe3Ug4L69+mLPW4ygAtDwzPikWhL0n8WA/HGRIKkM1FU3vTCns2MVsH9NYzC2bs5ZLa
	 VQfaQDN6hyquvB1YEQo/WACYtzomwFoZww+XgYZ5+97nAa/Vj6eDbWOIApuJ3xLpIGqDm
	 PwzENROn9d7rMjKnotGh76ZJ0bqN6I7z84DgsSyIpDbtu9GDYEkNyM8lFmOsK+rb0H3Us
	 4a3ulBy8PIxT7aoZi+o3ebDYW52jVh+6Ml3R5Lk0FwgJif0OTCjciEcdnImp/x56Y5MdU
	 co0x7eA6oSKAd89wMbu/vC7JoBVt0Qa0X5dyGzcPX2uYoDynONVk3DfiATVDAjC9tog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792933951;
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
	bh=LqOF53XnlfQgUVJDALTJ3xVYCVEUb3qELUc3S3NTyhc=;
	b=WFJHRlMNO5diFZuXDlOmw09+nHE0X0EdOOKc0l+tp037jFPGbmmLwY97X7PvtW4JcsQ/
	 ZiZWjfm66e4eQ2pPXCX159cPnwtNHsEvolIdt66gpxj3vYU5JAhKXVsyldANYGOJbmsWs
	 3tPvj72b2M8CF47zLe01p+s+8aPUI7D2FDoX5Kc+qh5/4aNGeBO1x8iyfhu5SXFem57o3
	 8daZwvhzvpSrRQfUZepdhmmMLxJukhsO5djYftsyyU8uMHOgcjgIl1y3pTZjWPmyGu6t2
	 id+HfQx7DLn4n/KoysLjZnMIfwe+3HCp5aH8hRTvvHm5gl9mtd0dLAexNsRGP97oxTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=daGGvgbU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.19
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4450606A31A;
	Sun, 25 Oct 2026 13:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4450606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=daGGvgbU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofi59PhNmmgIXgsnNjyn5wCwfCyUzXwJLONftPdGZ+keaCBlwF0hK41z85GQPQLI0NIuV7rYngKi+Y/dePlBlZ3cN+hSb81NR2riJJju4/su/RFW/cvafPvNo10FhEHYw+zLzvHZIbDpqFIWWLlU3sqUI3W0iH8sJEbg9qkKeqyxCoamPxfw1/jpwfgC4w89JnIe+xnwY0uKlUUGLr6PECGZFHnWAIid5mUDBTF1PUB1ZW/wNYmwBz3PUeal9dsiLpYjpgcgdtGj6rSjUY6HFFvUzjOvGzDnVlHRF8846aTI+/gKshePG/Q4kMd5MaXnhUyA93G5BgKs/7UuX3w6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqOF53XnlfQgUVJDALTJ3xVYCVEUb3qELUc3S3NTyhc=;
 b=ogFHBsKDISfD6di08gJV6rLi0/DiBK3UrPtp5Co2Qy8hfsypCJj7aCiFKp2Ns156i5Wd+fZw4sAqbl+XAY7nOoL+k/YdUVKqHJnn04VIBVBsleM1X9pmqBnlXHnmTpY+S/2fYJKCcgpnH7vrVD6PzLEYqbjPGR35M5dlIiWUI4epG59shALpGy2I5d/egsttHO3u3VFQ1vv4q3wNoi/GrFROmIvgBXbkMfl8GoethumTDCbotih68EfPOK8OmstaMGtEhOOdxObeQllNIJUcXbtn1nDgwn7FpgGDjRb8w99w8lHcWRo2kK2DaE1pabmdoDHQm1UItL1gRLhMQbJInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqOF53XnlfQgUVJDALTJ3xVYCVEUb3qELUc3S3NTyhc=;
 b=daGGvgbUVCcAj83mAYiEADE7s5hy8qtyMu2ng3ssg8GK5t31xVRf1YZ/n9ZG+hrq7jO981C7DiRZ4C1HaczQvgd+YBkXSJlEcRnrLJF9hW5y0Fu9247CxC0r96mFjb1KMB3UaFedYmdhB8lsPTYz/3iRCODg+sDX8Ysa66lEAG7B1323yVghOAbxDYy/OHmTKUcajPIXcIKYy9ZyAFGw3nQSIvTF0pFqDa8yTZ5GnckHF6PAFE87eun4A8kA6sW45r1wHbXJrDOyJfrcoEWy+2TZpqK4vo1liFMAqNnPbTSpftnHubO1QLTjf+Ew7sBD8T6VInOFbg/YisUyryOQLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV1PR12MB028288.namprd12.prod.outlook.com (2603:10b6:408:515::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 13:12:28 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 13:12:27 +0000
Date: Sun, 25 Oct 2026 15:12:16 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: netdev-bot+sinfo@kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <20261025131216.GB184152@shredder>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
 <179275358416.3327.10205293492560698598@kernel.org>
 <attBBLegF7iEikaQ@luna.proxmox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <attBBLegF7iEikaQ@luna.proxmox.com>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV1PR12MB028288:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeab227-0bb3-4260-9034-08df32999e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ey5f/kN1Apfwi92JaHkTtKUOJdcSdgG0ndXiCCvPM+g+FsaGJn3rB9+01Mh+c9JDp/iS4UddkI2vDzhnb9LF4kz67JW6HITB0Bi/nk5KzJyomNxVryHVL2S39ek+knkz7K4q9oTueQwEdQ+mGrcDc8/kmMMx94/GY/ye65OrBiMqmsvjH8ePWYGJdoz1urGJOfBfXLr125get2BAwbxx2zJsAwZqN6gWJQ6UtItPu5VbA43mgaeJIOsRViRLSV2CcrmrLK+RAOvmEUPGr8PktBIVn6Xg6+Fkv/ca1Fsz4BHFZE7P4ncoCbhJbjxJO8A+9J0SD7N8cRDRIsn7AY24g8gU8mdvniZXmLNlJRwzQLumKHax7dKswg8Cc6FnO0b40svTilOkp6F26zTlhpEeO0VqbRzw4nW+Ty0VcZat0aawp9i3Lj5AseX759r/AbJxnwyneJe880lwHdZmSFJ4xTOKexC7BpTujzCLJ356QXsdrosWaP9TfbtuIpxv3oC1GJQ9ahRSEADu+EA7OGR8vv+7f7ysY5PF5y3sAfpuzubVuKHu3+Wmh3f20b09bveobI0emUcjbFHeJpgRRSWOWhDo5qkKqM9wKvZ94dkByeyZQnJd3hlCSJaarforrDBaKf4LBB5hX0BsJYyAavVQvDrBLxzfg0i0ot8W6PHdTWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HxRZoEbQgEo5XHPzQ7Dz5JkLbuzhrkwv89RYmKoKo9kL6A1j5a4qZ1d6kZL3?=
 =?us-ascii?Q?vEs3VED0s4DrrFZ5mA3RQFPMRAAaa8uG7vsGOg7PVxmXQSwhbXvc40asTOUe?=
 =?us-ascii?Q?BHqGys+EZkxCAX3HrjHx4CUyskyYetsSPPJCfCK6/jQ/zZlszSsohY21qPk1?=
 =?us-ascii?Q?mdslgPzoFvTd+1HyC8mVeEBqyZb35ZGVKxxvdgoN7Mc1T5jiRpj3BrjOo6dX?=
 =?us-ascii?Q?gQ6KJCzU1E/ZxvbVHOGrzjqneuT+02c7EiWmTKZ0NB0Mw9+KIRXeh0r66lwq?=
 =?us-ascii?Q?y7aiGlsNJEhTJthzWBaBHr5A1/idPTPWK3f0mSXyR+Et4VZMuhM0h2v2muup?=
 =?us-ascii?Q?cvj2NxAjvFvNFJ9IDqEWvso9xs8ICFahscupbiImkkoKOAxM774kv/YFtmaa?=
 =?us-ascii?Q?UZniA8ZvMxEq5dOmycjz9Ga0frE3WdKl0bmDDdFRKs/1GAtsLv/bbgJ9Xfuv?=
 =?us-ascii?Q?gACMIh+rNYWq+vqF9SlgWBhoWUwEO5QuVhEkEB8xvpPrknT3V2LVhMmevkfK?=
 =?us-ascii?Q?fXCrUy6Qd0gSr570PD9yjxLi2HC0T5Y+DRDOPhYhXezYklwrelRB9SnP6LFA?=
 =?us-ascii?Q?iHgLmP2EahdtBrT6bZllpgaway8kmPj/03V3B7UDMdUmYlbqaKrXPXagx/9u?=
 =?us-ascii?Q?Tsn7I2WPfhoYD1WhQB35hjL+3Z6vlIQSEw8LzIUup5NGxEWdAzyiRvLVRJu/?=
 =?us-ascii?Q?yJg8rF+WAk7WaIuVsbfdzQXKasP2RcE7ly4cF5bKMjeiOvw/TivucBedHv8z?=
 =?us-ascii?Q?cRvE18YxE+3MOgmlFMfaQ4LcdMyZiZ0G8dUBFlfHdqjL+0a+zDWbUhKPWA5N?=
 =?us-ascii?Q?vir/ac4puVCvkSwNrl6VGRMase63sIFj6pCygEMN9N9dpGgclGViX4sSNKSh?=
 =?us-ascii?Q?LFA/64h+QsPxU7tHCLpuSBvhquXiBcp8+FDtRi2VbKwFHgnlBeCG69OoxXbx?=
 =?us-ascii?Q?1GXe4JZbE56gMgQJsfTs7dRVn4i7asZO+qCYOCsvAsSnmG/FTt/Nk+ZtKV9O?=
 =?us-ascii?Q?qwaWoIGFEJLMCWRErbHLulyCFwP0cwoCvvqK/fuc6moVhdBTKn4d61jcnEDg?=
 =?us-ascii?Q?OQvUpjbusCdA8pcjUYkj02LN21/ZVOlWR5Iw0hazxa6Pf98FU2mE0iABKji4?=
 =?us-ascii?Q?mIsHoC+S62aiK+72nft/3VqsiYMZZfLix7QUedXjlw2W99aPmAVviApPeMY6?=
 =?us-ascii?Q?RimahE5U1Susmg9PL/w5n0jiQGYkiJj/4+9FyeB75gC7U/hL/7JIfCtyBSUN?=
 =?us-ascii?Q?F/WLKAqDnkWDbXf6hDTNdeqehKcZ+7A7IK7V+NJyaKzIdfmZQt1AlKrO8XVM?=
 =?us-ascii?Q?C2c7UON/TssEeqnv4yhl61nIPkwlfUKPLc7FvGJ31FZxAgBVQH4DQMHnzwpn?=
 =?us-ascii?Q?zSxWgtmFA8ujEocFNIxvO9+p66lZ+gIX/zdoPyL2rSgTn/TsY5Z/ti70MNqV?=
 =?us-ascii?Q?V2OHxqOSZff/YySKMcMr4nfL/dqCvv6MDXqFSeHV+peT1CtIFAT17jg7zKec?=
 =?us-ascii?Q?JzXVfMokyyW9WTfr4t7BtUSJeujVcQAMh1TjfrccHOC6ZL8KjOccJi8WoKKO?=
 =?us-ascii?Q?tQh2u73mSiaisKKIcEiufGmxFZW3mtNz3FnXMQIKIREnzdsFr8evwvxTsJnr?=
 =?us-ascii?Q?TdiUGO9xRI2S/P6r/Ye0Im2/FHxKc+aIVfp1biWJLVgQ0WI8lCGWRLqiv50h?=
 =?us-ascii?Q?WuQYbHF4YQWtlz4K9bLT2hXFOpxHZ5OFfzrVWQH4e3KJODK8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeab227-0bb3-4260-9034-08df32999e68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 13:12:27.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKcHlqMfw5R/+zuz2EbA9WVCVA2u6SjixrCu0mQ5hwFTn5/hJHqTruT1WWwvvGtu0x65qFdxw3TcXINBri43OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB028288

On Fri, Oct 23, 2026 at 01:15:01PM +0200, Gabriel Goller wrote:
> On 23.10.2026 11:06, netdev-bot+sinfo@kernel.org wrote:
> > Hi!
> > 
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> 
> Hit during development of ifupdown2.
> 
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> 
> Can actually be triggered.
> Check with `ip montor netconf` running and execute e.g.
> `sysctl -w net.ipv6.conf.<dev>.force_forwarding=1`. The state of the
> force_forwarding property is not returned

Are you using a modified iproute2? I don't see "force_forwarding" there.
