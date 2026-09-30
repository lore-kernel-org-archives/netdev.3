Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B53B3894;
	Wed, 30 Sep 2026 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749372; cv=fail; b=RExUg3MuQjcvXiQt3YUQK0FQI5z/1PRMQML8/UN97G1hpkMkOsp+vsplnf15a2axgxHmDC3Sh4B2CM6gebOlIm2dHhkY109TXrb+Li3RAr9MSDRLjLZv2E/Gr9Zq52XmDLEFtwIWebB2xUUd4uM18bOUW5rwgiLACwayCUeD/JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749372; c=relaxed/simple;
	bh=KbtYMPVY1rjw+ykz22ay0q7wG0sxEPAyqOEO35gvyjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbroloI8SOppUMuPMPe/J2SPoBf+7zSflTJDQwBppyOXeGjvtjcuRjTeHBGOQ999cjwOXZRi/+++uZEmdS9rEYpDhvh4C2o6Z5dYJY4i47WuWDKh10WNtX6rrlA8BFfjX1dt011JCpatblisnB2G9+FSyRVoOR9R+nJfTTGbE/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CH5eDfb/; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CH5eDfb/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzSyEgto9EokEJ7AaKR02rY7njf0lnuR7Yl2DfPAEm98RIcqkqIOkxbAo5Z6shhPZFJqEuhfK+HpT6nqN8Q8qXIyPkxzYIfaA+B4PpziUBtoScD9NWHVb0sLJwqboj78o2JLXgYU1Gkx82uEVp791dmxXg9jVneoh8JwjrK1Yeb2UEa8wTqYpvfdIwf8zjDCYZgEOIUUEJaiERlhamP5rQgLLcDk8uyWfKmnUQamTBDQcCp6ldAf0ksAAxqdLboSF6zYgCJO0f7Oqa4rxMtCfPkujb2ylliG+0QlxTEJNDjRoImf3vwWiUE9kWM86Mn2NMyQA5ZX9NALlkUmlLs2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVHxni2UsO9Nj2XinZk/+3FJvplhcwI19bGGkCWq8Tg=;
 b=hoocBak3xE6ZLyGGnjIkvGKRUih1NdSniqp+smT//i8uT0e6wqdkiG+tak06ZrszsgplNx2kDsFKd+W8OsZS8osFdvmehEia3fQ77XlbEaG2Hi0F701v1KPxSzD7kpjBEtFihHJrjA5edEzklrGy/5lTtoC9Q4D19NM/361D5sCk6se6BFtVG59BFc5ZJ7jMKHSjOhJqTR7rfpyk838XFgrm9KlPeo3SCmh5kali4VF6qcttu7bTlQZOV36+2cgh/WBceiGRRY31R1yQDvo2qelw4GfeADi+IiNwWb6mNYToVbhxStpMC8BilukUFZtykjfMAEkeFnDSIIQHcBjccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVHxni2UsO9Nj2XinZk/+3FJvplhcwI19bGGkCWq8Tg=;
 b=CH5eDfb/l8VKCncgW8HeP0OGhG/M8x/wJ8LW4TghQjsgYgbajE5DjAyNVQ6Nwl9wU7kVl+GZhSRyKBVx5YvpWgJ5VFQ/HswbbJkjrUtkAeVXKZqigBwtaTbXisLnbfPHYJWMS+FW+1o8WkoQh6yaBB57BkASwqeQuOpJ7VraYEo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by PAVPR02MB9426.eurprd02.prod.outlook.com
 (2603:10a6:102:308::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:22:45 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:22:45 +0000
Date: Wed, 30 Sep 2026 08:22:35 +0200
From: Henrik Grimler <henrik.grimler@axis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@axis.com, kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
Subject: Re: (subset) [PATCH 2/7] ARM: dts: axis: artpec6: align all
 continued lines
Message-ID: <20260930062235.GA60101@lap5cd525d1j1.sto.se.axis.com>
References: <20260928-b4-artpec6-cleanup-v1-2-e3b75e10acc6@axis.com>
 <179074623976.18076.8809897213040972245.b4-ty@b4>
 <a7d26f7a-a7ef-46da-ae9b-82363c7493f6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d26f7a-a7ef-46da-ae9b-82363c7493f6@kernel.org>
X-ClientProxiedBy: OS6P279CA0004.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:30::16) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|PAVPR02MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: d65893a9-1c97-417b-2642-08df1ebb3d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|366016|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gNPP/ct9Xc6J9ihUs/fipL2/1caoitoVMmOxC341nMhleUdeTCVwn2ADccjwJI1DFN7endAFV3ELL5vrMSpGf1QPBEbvPJeU3HmXTpcSKKt/iMarAnnZK3mk3may9B0wUZBOGKly9HedctEuvXzKZRe95iAxoFbDZkI05qjlUJT/BvaAXCjpNQvt3xSilhgmil1BzTKt4eYnqB9c0p5eieqoSeQ52Nn247oupb98lvdY5q8ubUNA1Vj1sYyriEJrLg2FFMwFEUXpOOvCwSaQ2x8urslc2ctmFl4fDyQhiMJEL8QPQsdwNI81ewwOATC+1T3gexSxrcrNtNoco9E1+oHRxrSUJXVZlOzw7WcTBnKIQv0l3op+NXgQKYapzb9v4hryoilIk3hzUGhx+K+ny2oZyiPiE4Lew3hAinak1tYG0TLQz7UrrKBHmTtclO+sBI+nZcVEfObBxNp9Mff89wAo+SjpgRoUJ/AwodMkCTNAvW0bxPrlv5ItubRZ+yFMcbagdSVmpGfR81GYksXpH7y8InMGACbHUzhMjsqxGQnYRpCzL+49+bxDQvo0DrJ4Qdlq2Z2+C+TGNbn9FH3Qfh2F/HcDlqYH3Et4BZ/9ufOOpqHhJPwP6e7FVAsfm93GI9M7a/uyqjVmQ3Ie71ZPpsZkejc3og7lsUeEndm0cSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGTu1ppH1P6GmcmIbPKi+fEDiVWCEZd0LVTthQLOeiGEArvKH/M7/F36yv50?=
 =?us-ascii?Q?5NaElj3wLTzWC3QwIGsdZAY7WN60gYnZXHH7VPviWpbUF4UgKMKPEv+xMvCG?=
 =?us-ascii?Q?Nw93PiMa8E4d/MthvXOisC23F4ZhBuz3jXei0k1vZU7w50dTvmcot9MAxtwj?=
 =?us-ascii?Q?k0RDKfd9Sz1jb5H/Pa4fbVwSdAMUxJlIQiTDTwuWMVSat2QFR6KVgdUoaZuu?=
 =?us-ascii?Q?iljjxyMo4bS8XqWCEsJyr6JfJmKaNrCL3URpuH5OA7ZjNWXIwzGxuonD8ofP?=
 =?us-ascii?Q?BzTV9ZGNSpCy9AxANEN/DCnGlpqyoBF9BeEoQIqdeCMrRPM/TZzgaJqlkeUx?=
 =?us-ascii?Q?ttuyKLbt0XZjtazcRohRby4RWXfFQ8wrTBR4ZrxhdHvTmf48t2N6m5Xl5BI+?=
 =?us-ascii?Q?/OQ3HlarHYw6QLTgY8SVSfmzz2jFz4WTVGjQOXeMw/QxtyEcO3U8/xC8JQp5?=
 =?us-ascii?Q?6d1XuMdLvUoOukNzGKk3MYR44doYliswT1dJlqbxuOTTOawOdO7Rm/D+6zbW?=
 =?us-ascii?Q?abDUpbjJUhHkxGEz7Dk5PcVycyL+iU1xVWUMz2T3Mx+UJC9OjUmTUaCvmNMj?=
 =?us-ascii?Q?gLADT9N9UvRxI3R0lbrAcDYZDOUggcd6EhCGzjm9CsgXmLcrLFMaI2kSnqMN?=
 =?us-ascii?Q?oJ7C8v3g59xYfKamuHVvlEoKvfZcQpKqmtM1tdjwHfn78lV25lOlAOot48xN?=
 =?us-ascii?Q?NQYDWn/Aa3JTnFH7ekJzULCUKLuGpKwwuNTdvUczd4Q56bGPaB4LPcEBU1+n?=
 =?us-ascii?Q?egeJ5O3lXf/RQpFQMNU/VLSuJ1jZD7vc0FDwKv82QJLTNu7BbUQh6uLUS1jP?=
 =?us-ascii?Q?rIrKj/yeaOCHsu9ABkgjx0nt6eXWT+OVeOReMIl45ElMyAW4QwaoX4ckixX3?=
 =?us-ascii?Q?bt/pos9VDBCPsC1Vs7QgbIp3MP+FXLNNXl5Tom7bANhY9aI43O3DXEd9X1bm?=
 =?us-ascii?Q?+oytt0uIeMIQtp/8ljV5z1ab3eJdYpMSN2F9nQxwHd5zxfcv8+8t+ZA30kH9?=
 =?us-ascii?Q?RiDWlCTQpT1fYflTx8j/2j4pAHclXXcMasFA/miNtIFy0dBWnMb4vuxhHQvW?=
 =?us-ascii?Q?zdo++V2i+Nb/g+i2x+CsN3lBXSoeXQ3AThcW37oj5SDLTwreTQl54a0hzcHb?=
 =?us-ascii?Q?Nwt2B0cmCMz6x1LymDm2bDMewD9duoKO0xKjiWMXOOqUOF9U6u+Nzi9YKAbg?=
 =?us-ascii?Q?Z/tlJJ8hQCKVfJ6HvjM41co9WRlCCi7pY4u4edY8QmQIjPJY8BZgyVlJl60C?=
 =?us-ascii?Q?aSd/TORvesr/gapHEJwTLCysYSFYyrhU30cd/MG7hHQqOVz+rCDeo92QwAc5?=
 =?us-ascii?Q?FFxYxTTeHbTHE8dU2BdNZUaJJ5fbtMF8mg7t5EHkALXGiL09UqqGY/AFio6U?=
 =?us-ascii?Q?1fUsS/1e+iFoBQ2Kb2Eh7R53BqGZ/sVeyp2X8uPNEWT3D5hbF3A9B+XQLBSe?=
 =?us-ascii?Q?dlosZBhisxq+AiyZFh0TLIpvNTBWqdggOlerRxjv/pf3xy6CaqA4ObJdkCqh?=
 =?us-ascii?Q?/9JIWEm7buZjkkUYCfZUOEplHWTSBzCQ7eU9EU0mz/OJyDc6UpCAkKHVe73X?=
 =?us-ascii?Q?G5rI4BRTZnvHhBP4RT6RCg8V1t838Zcu4moFSIossw3O0T9FiqyVWly6W4Rl?=
 =?us-ascii?Q?ZUIKIzOEzf7q27RDgb8h+gKXaYfPWGswdk50ivXW8GoTJvZZCt4ykLQy1+tS?=
 =?us-ascii?Q?zprk/X5amMZwcPHwXVgWtEGtovn8LuzLDNR3OUZtdjwLcMboKitWZpQEXzPM?=
 =?us-ascii?Q?smKWcCB0Pn0hUM/Q1iwnHJNyj5S1sIBE3C5pENr4m5mWZhNr9Z2i?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65893a9-1c97-417b-2642-08df1ebb3d47
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:22:45.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTdTiW850khLiDiCBMWvx1uUBmGa93Bh6/6nuRYrMuGRdp4t1qclERCqRTglJ4g868qhYlz5jMHBcI2SZCm3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9426

Hi Krzysztof,

On Wed, Sep 30, 2026 at 07:44:54AM +0200, Krzysztof Kozlowski wrote:
> On 30/09/2026 07:30, Krzysztof Kozlowski wrote:
> > 
> > On Mon, 28 Sep 2026 14:04:48 +0200, Henrik Grimler wrote:
> >> dt-check-style in strict mode reports that there are a bunch of
> >> multiline properties that are not aligned, fix them to make the dts
> >> easier to follow. Fixes dt-check-style warnings like:
> >>
> >>   axis/artpec6.dtsi:290: [continuation-alignment] continuation should align to column 34 (to < or ")
> >>
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [2/7] ARM: dts: axis: artpec6: align all continued lines
> >       https://git.kernel.org/krzk/linux/c/60c916de7b3bf0ff2a4d1d31753a29765941ab89
> 
> ... and dropped, that's not my subsystem. Why am I Cc-ed on this?

b4 / get_maintainer.pl picks you up:

  $ ./scripts/get_maintainer.pl arch/arm/boot/dts/axis/*
  ..
  Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
  ..

I believe ARTPEC-6 patches has gone through the ARM SOC tree in the
past, so maybe that makes the most sense now also. Will update the
cover letter in next version to suggest this.

Thanks for looking at the patches in any case, will fix your comments!

Best regards,
Henrik Grimler

> Best regards,
> Krzysztof
