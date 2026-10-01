Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61B4B7A21;
	Thu,  1 Oct 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863123; cv=fail; b=VySjIchWchpbFPUvAkeQLgxPtOS+IPPu+cOWE9JdDDD6CyfYV9z5bIZglrdso5bjQSgZsgEtPJ7Fhr7kPjM/WQNlmRY+ScYZFddoLwc0De2XocZkjTd4HDBVYbMB+48IFQWAnK8sL34DwXSs8yqWM22o8pohyHnvTCP3Eyid8Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863123; c=relaxed/simple;
	bh=SUa3tpL3ftw3WF9SfOauI6A64G/B4cTc1PJvjAD2euA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BuQrH3I0ZCMCma56CRMyLI1sOF7YGbKszJ5ynVvekomWIKsvd4Vc6ZiyREG5/VEwzXrs9vOu8srrAoq8lkOPpWFsVTow82gb8YDtz7Hy2W3U34/fFOZ0kpsIvj05U4NGIoWcba64r8iFwyqRC7KNUU9CfitDb34QfYEsYEgV+t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Nhb7RfSg; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Nhb7RfSg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWOy1dQeKtu2oY4lRBndyEzypOlFckt20qtuclua6FarTzirLjVEOuEAfWS6Lk2r1kea3br64HkZFoYH4OrROKWuzgGguXN6Ha33KICYEkolpP8Q1pdWl7ufRDWeTPjQBX8IEu2C9YvfyI+JuJFugKC5vNw7bUbDJF7LPLInNhGf/fB+1XmfT6EENPpN53JNowcv7K2urgWMEeenS6VD+bnbDnytPpDeboqRgK0ISlbYoeVwMcuvQcGLy/zlypX7q/ntzUKxapnIWtdRnDjQSMrgltQncwB/gj1/UcGadTxwJYF5uRJ/1aM3Belhb44beZBDq3DXCgsDqNmLC46nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKL3flqqEI01+/YtCHb9LcZA7I7LVIgTPZEO3xL8vhY=;
 b=ZovZSUhckdI4SYigTwjUxDA+7Y90a69lSu/HKg4UGQlqWwd0kxXVpmq9+9exP4ZaWDDE4Xdzr4fI5gXbls+nCb8Fxy05PIN/RRwb3dOKCLHpS6KV3xP4PZ57xhk9pukOedSFgEfJDNviqRLHNKU5b+7Sw6Ni+z7y5cXRmTJOg7V0oKPxr6AqqsrJbHAOrZjRE5cZiRLdGuSNQAfOmDGhUQNcRaV69BN/ZPRULi90wkOMIJ1Vy2YO3UoBKevqp4UFp/BxEUvWLn6ifgBALsWzcKATHYj72p+cPIqI5jg95ChFloCIu9KkAoWb9e7SxV0GR4nw1Z6qbrZlgdTwtABbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKL3flqqEI01+/YtCHb9LcZA7I7LVIgTPZEO3xL8vhY=;
 b=Nhb7RfSgSXPc82wfcRsnOi58hZO7lDOuNVktUBaHNt92YSp9Sv2xekW1YbR+b7OOijfIXqcFpqQ6KfBSGtNxbgqwfffvbdj/tlDyRnebetBDkopPoa2+6wFHg9a2AMwpdhE+35yE3DDdNjrorkI9fyWF/J3ZszgUG1uL5dtxZjU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by GV2PR02MB8697.eurprd02.prod.outlook.com
 (2603:10a6:150:78::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 13:58:31 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 13:58:31 +0000
Date: Thu, 1 Oct 2026 15:58:29 +0200
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
Subject: Re: [PATCH 1/7] ARM: dts: axis: artpec6: avoid _ in node names
Message-ID: <20261001135829.GA981103@pc67698-2615.sto.se.axis.com>
References: <20260928-b4-artpec6-cleanup-v1-0-e3b75e10acc6@axis.com>
 <20260928-b4-artpec6-cleanup-v1-1-e3b75e10acc6@axis.com>
 <3caea146-74ab-42d2-ad9f-d36d1adedc03@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3caea146-74ab-42d2-ad9f-d36d1adedc03@kernel.org>
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|GV2PR02MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a0f2a1-e77b-4465-417c-08df1fc41328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	jK+o5XhrM4nIZQS0X3m1CX95RySI9Gz++5vjygQoAzc/vVgE0VaaqIywAddM4lbf6ms5gcbHTUP/54Um18UXJck1hNMKSxBoEIJxDWLzVDAJVixa9YOpb/e/2EluogQFD2BRFvKdZHSIbYeIEHyq2v7rnSRkV+oV9E0LuplsFR2fB70Yh9C8Ww5gCoFaSIPXAUzVwUq3p5iRhjHIv8V1doNd0199KUf0ApIm+dTKde+cNknD1TFQzRX0pecqXt+U1adnaCcxeZx96rayV++5sykRyCcaKmHNn2DWL3FCiELzanGB0rA7ZAlkwQB+PGsrVBWjS5QBhNiV70hX7HmxNGT4OQYJ8AJgrfsZFUnflKgloFFSLbydvR4OPnuvX78V1LFKH2XD/CjL7eQd42XRpBEwSX24kxuiCL88Jp//dGerJ6Y8Z6z+71i9w1Py2xqt8IxH0DSwqL7Z8/xtuQBjp+9SgSirMQXbAQQ7vPGBT28pBH62TQ3rUOq89QJ9CqnmvLdIjN37RxPjbvN8zObDUZSMG372y19LbuxkcIPvnlKED3dhbQAt9peFKGtSZKxT1v7fb1RYFDAygRsEOKtNHPUOz7JodIRNpWldPqSrmnEc/RjfMu9D1ezZAru37UBaHQbxheAXClqt+33JPLrudtBy+xCjop2RznlTzk5Nj28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T36plO6/iaEEC8HrTrKI2N2UVodKLEGRNKTJfWrGIUZ0RtzEUAdUK62YnOFM?=
 =?us-ascii?Q?21/hYGJJHhSWOfxXUmDTUZ+VgMsipRR3qZ++3qgRMgMx3mArH+E7EtBxlncf?=
 =?us-ascii?Q?u6d/Vz6aJNWGNnDjFXH/UaoT8OSmD+APBwtFolf0EQByTqYE+iW84SqHlimv?=
 =?us-ascii?Q?J8JikY1yaq2uPOOmaDxoSwBKYkL96C0LFLWkZKGqrOWee2wkOPqsGRq9G98r?=
 =?us-ascii?Q?L3o+9YibzIZkDdnP7h91nKNvRaB2Z35PcPxiGWaxAra5GOJah0HNwwJpa5ML?=
 =?us-ascii?Q?VD3wEqjMKx54kubAIqQ57zZ5TgGYiUitxKW7L8VfLKx9vGAexqBbujR189h9?=
 =?us-ascii?Q?OycnFN8zrI1yb/5Vb8obLIXKn3V0QlTGr4nvqg3/N6kVWaflJpoT0S5Ow0Ef?=
 =?us-ascii?Q?cgivq+LJctCIx53nRtzggWA1JkvhiGy2O/t2UF0SDGgY9DN/agfTgwsj1/Ja?=
 =?us-ascii?Q?YsMIZPUQvC0w2+HXxtIJJiRluiYpLkJKrGfmA/FIEfwpNkV1tmzk0UHPGPlK?=
 =?us-ascii?Q?0WjY9nnEbKDTjWcejCLKZHdE8MdfAs5oS4X7ZJbJzGj3hC5SFkSJfbma5Mq6?=
 =?us-ascii?Q?RIS4rolVa/mqF38uOFW8fjYK0GYA97GJNUGE1UN+l8Xdh9CsYAQpAe9nOi7k?=
 =?us-ascii?Q?WHMyHSURJipba4FLgjrKG94OVNWHcWy4f1Drt+7kSX2PKFAa2kZSeaSaFjG5?=
 =?us-ascii?Q?rXj6y/vkcGiSb3NEuqRsIK4Eq1SEOEwcOGHEqngfcwWLXsgh30ZvbzmqsQ8e?=
 =?us-ascii?Q?nBbSm0SyPjzZn7XyY1yZuVaog6I6bTeoY7ZsmLu9hPccRyeq1j9vro0bi/7g?=
 =?us-ascii?Q?nUqzyDnJeDCgtz+CA3lQdJbZoDhxNWdW8K4TUR6Npvhq29e9MQP1c8lEx5L9?=
 =?us-ascii?Q?NLs3Bo8bgNwr0l+4vQPyUY0AUtibqUUnhq/W9k7F54JLPBNsAnE+sDjdL1Pm?=
 =?us-ascii?Q?FR/G7ymRol4Zima98lo8mBaVG3LvNEnfLPzpkJxRZTUO1WO3kwDxE/b7CVG+?=
 =?us-ascii?Q?sLY7ggjYLTKWasUCMnXL0SNAYFbb7kmrfzKH5X/65ELX13Nfl9rrH9kk5XPO?=
 =?us-ascii?Q?djymStz+smJbrBOVwFvCK3a2Kn7I+nAB/kdISK2X5dgyP/ngmEyoq2P3Cnzr?=
 =?us-ascii?Q?IBnUTUTArZ5lVkdzrJRX2bpVRW1AldYSKu7dTNTZokJjgQLYuUB237tE4xdY?=
 =?us-ascii?Q?fgEcRNy2eAUGH5t/Esy84Kx367L+oE0qt7QRXoYJ2d2TvE8Li/g+OB1g1Kr6?=
 =?us-ascii?Q?jXIbkDrSrGCMqzU2KjnyQKU6fRn9f31S+gGNlicsCtcfekPExGfCsR1V49Le?=
 =?us-ascii?Q?xpMWYBEtFinVJ0yfKS6Gq35kIdMazESvNMceGQC+4ierg62Y+hAH7h56Cf2t?=
 =?us-ascii?Q?HHILKI1a7HU2iQHLOhIW9XzwNYBAFnmDMDp/odVflzE5k9QZYq3KWiDzyAbD?=
 =?us-ascii?Q?XBpOK5vU5GpstphnvbEopyvRK1eDkPIow99EF2E3bOaxJaTukdL9qcl1ySdZ?=
 =?us-ascii?Q?pad3KBS04VkmPws1rwOg17HbldtvK7ZoQpJeqVxR4aIxIi44hCi7bM+f/V5r?=
 =?us-ascii?Q?IPIJ+/A5IMHhdvhdlEeaA635fAsuFqOYjzqFVuwaq8NWoz9jXla5hmR4VEoA?=
 =?us-ascii?Q?2MUkGaBS8LFgNm8H7UkMN0+k1AE53rBrrP6g8QakDflVf2NqM4/tOxRYWopn?=
 =?us-ascii?Q?xeI2xZ4eafyySQ0/aLHsGlHKgF03z9iKhpQhMNiYqIqPQbm9Dlh+xNM4iLfa?=
 =?us-ascii?Q?SO2/cfFJYw=3D=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a0f2a1-e77b-4465-417c-08df1fc41328
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:58:30.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ6amsd7bHtiskv+U7rac9G9XVAKnByYF5HtTkMs3b8mBFy1sjmB1VEWzlpXGlaZLjzOg4ejHg6ZhDzeQdKH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8697

Hi Krzysztof,

On Wed, Sep 30, 2026 at 07:24:43AM +0200, Krzysztof Kozlowski wrote:
> On 28/09/2026 14:04, Henrik Grimler wrote:
> > Node names should preferably not use _, use - instead. Fixes
> > dt-check-style strict mode warnings:
> > 
> >   axis/artpec6.dtsi:91: [node-name] node name "ext_clk" is using discouraged style
> >   axis/artpec6.dtsi:97: [node-name] node name "eth_phy_ref_clk" is using discouraged style
> >   axis/artpec6.dtsi:189: [node-name] node name "pcie_ep" is using discouraged style
> > 
> > Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> > ---
> >  arch/arm/boot/dts/axis/artpec6.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> > index 037157e6c5ee..ce642dcc754e 100644
> > --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> > +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> > @@ -88,13 +88,13 @@ scu@faf00000 {
> >  	};
> >  
> >  	/* Main external clock driving CPU and peripherals */
> > -	ext_clk: ext_clk {
> > +	ext_clk: ext-clk {
> 
> This will change the name of the clock. Did you verify that it is fine?

Good point, the clkctrl driver does not get the clk by this name, and I
have verified on the artpec6-devboard that it can still accesses the
clock without issues. Will add this information to the commit message.

Best regards,
Henrik Grimler

> Best regards,
> Krzysztof
