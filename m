Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765638889D;
	Sun, 18 Oct 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337569; cv=fail; b=OuLJZpy6xO9IuDfNyOeFNGLqHPPXO892S2J0wADDvi3dqhOSDdmqYjC2US4SmLaMxwPqglDNr5CUOuxAFhk/OwGXbKlDJtrZCmRkLX6ZHFqa3tX7guqvEzZKxhMkwwqE9s0d5H7Gn0lr8bB16yT3PdizGEukDr2otPVFmsjeT20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337569; c=relaxed/simple;
	bh=hQHF2jZfUMIN0s2nhtdTgf+WNUrhmVm+QYGhhTopAqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGG3GfE39Kn0bKmcCoBqBwZzRCbvPSt0tK2qtSlqrnXPPgJfYsA9O7uz3BkzEOH/sZhotadrJygWv5Ujb+1rZet9ikCuehi2K/fNUorXhsmR4rRmwlLnqiVHBl5K0Vot7Qqx3bltb8UJDKOI7vlTQ0x3IkWOgFgSFT1YXFfy3Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbNaQH5B; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbNaQH5B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNk69ln48vnvq88bWBFdEqTd6FTt2cIFzynb760tSpdhbdhNaNuYUJ1h3yLFYk4u/4Xfi0QFFLlETW909xE3jfHbb02Os3bpspGdv3s8gMLMNnkRYVlnwsijyyxJTpUY74k3u0cTmMkLwxvFN6fUyI8B+IWH4pcB5u5LC1rQQc3ZLlyAU9AyHHbmi/QOSQukjl80bkxsvb3c5Tj5102j6szCavGl/ruykAOQ7IIS0JAbpLXfWEqwa6NUHnExLMy1+6uP3GmhAkhA8Ejkiac9buIqYoP5/8nmLECBlEMFvzNHQcTzbUEwCzGU5acMtlNtp/Rs6mLn0dPG77ey89+bEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx+SZehD5RSo8E4hZXUQ0t5WCf6FJkE5D7pd6mC6eTQ=;
 b=AoFJdeCHn/Boj8NaP//kEay9fdzVi9rreKCAdsDQSFhO5uyRtRND9iCmC1FsJ9TqG3huHojoqkkRKwNl43a3nVE9uRMn9IgKGaqgKr/2gqRnuFSopgCbffaZpFXZhc3xTQSgK0t12Yt3kt912hpZuWiUpZyaa6hy2V55VtLAJnw0+UkCItyGHbmynchIdJJFnjXdjPGkMCEXzrsBQSBdKKEjU16fgPSSIWEycaHPCdGv618r31FpYXmgTr2eyHKFpCpJ1d1B9lmTci4j2p/HtSwWO2S717/oHmv5Xpawk2lMEqTDillplekSVltQQzd2KCOabn5rdj9JxZSIN2YRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx+SZehD5RSo8E4hZXUQ0t5WCf6FJkE5D7pd6mC6eTQ=;
 b=XbNaQH5BW5wkAcCuq8uw2BoH2xcol2JQqEZdGgHTWeQ5ylh0KptBmSH/4/YmAFHvkVc6MzEgyJo3ARALRMCGQqzgMvb4/YQ/5PzkuEO+4m47428FHpknAxcaihJXY4wUSQqlpoVA7LsuKs1mWTQbhlVtKHWJNORGDzXmkTnDzp7BvXTVCaqvSnyEcZpjkcTr3ORQrWRi7psNC/4IdyeQZVrq/q7Srb7JhJisXEmDRU+riyHOXKju25AGkhijw5XSwdkRY8Gx6+fbvS1x2EY0wSnQRkR9F0mANtUq5vKcOBbrVbEFrjETrKR7a8E4Sym2TUHEGTeZWpvxRrb5wwl5xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA3PR12MB460542.namprd12.prod.outlook.com (2603:10b6:208:709::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 15:32:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 15:32:41 +0000
Date: Sun, 18 Oct 2026 18:32:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiale Yao <yaojiale02@163.com>, petrm@nvidia.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Elad Raz <eladr@mellanox.com>,
	Scott Feldman <sfeldma@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: pci: drain EQ tasklet during teardown
Message-ID: <20261018153231.GA2601944@shredder>
References: <20261018040653.534066-1-yaojiale02@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018040653.534066-1-yaojiale02@163.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA3PR12MB460542:EE_
X-MS-Office365-Filtering-Correlation-Id: f10062ea-9f76-4d96-33e9-08df2d2d0c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eQ0Y+YBAw+7KD4ABsnnYxk8xfMyyqxKH7GNE2KKEWacgx0xAa+yiDtcsBcVDamLUzN3kYyPtfHmnNOCppRk1mpD0Pf2nJQBIxwvsJ+kYzrL3emaNI7YnZdcBtomp1MERN8avuMKyzxA8rEoil8JEDfrb38K6ddwTF0EpYpMScNJCsQmsOaFPVMtipeRXjlcQbVCd8A8wPgptzeVaRsmX3ZZH7qn1ajIH7nFr11EuPbSp39aZ6zPUYwW11LtcjCumqxJAVvNpYqcCKO/p9NFFWqgyO+y1h2hl0qBgN5tBoBsqdMfs+r0Pm68wXb1k9s2JVhT9sHP+UuGd8EMAdy7l7egLJ+6KoODwrlzCcJ2SdlZalf54Fv1Qh9ugh8LvAFwV6aLfFdLv60LvOjEPJCj+H12zwbLIiDqMSu87FuiH4rJuhZsBTLTojTpsaDooUIlFBEeBmOodzq6dkKOOK1vmJGLPtrI6RuGdx3KxykIA3o4UFOFREkuffWetaln7SHZKePKQ+fAFGtnHc2k6AZFTqVJvPXD4tWpfCLenoqEYd8rktDFhTtsQ0ZeNckboUnNYuyWqLz/JYys/xnWqkxZ8PDWbTQEAusRxJEjZsypHMX4lt4UBdPS42Hb2Id6NRs841Cim/zWpgNHZW3mqar5tmTsq5rtYXUnEkZclMz6WzA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpnLOj2UJVxKlq6+Jb0m7odU5/gEToicyQTPzpidtbqC7FI+GXAgxs5wC/2j?=
 =?us-ascii?Q?IEFgqwbn6kWqAzmMsuOPSBnDvy/W9Qv4nuPvJD9CyHcatju0Y+VIMn0D0Yhn?=
 =?us-ascii?Q?oIWTvKkl4ZYffDoloNtRFEEif2VrQ4sHpSnDbJk561ySORUeg7H9ULLdBwz5?=
 =?us-ascii?Q?W38JlRBmUsND8xq/rnZobrjKjEDQs7S05aELxs0X0n1X3Ifkby36lo9nSbod?=
 =?us-ascii?Q?ImOb+sZ5xwfdrPLuTcrKMJU6wYWaVmiXpd2tPAsyn9rXhNBBeSrgOnL64cvO?=
 =?us-ascii?Q?sn1GoP8J8aAllKMamKW5HFsbsODFAOCJ6pGFkzvgzOYFNgkMimJcBYsahSi4?=
 =?us-ascii?Q?Vxemms7A0VRsbRZoIwAzN36MkeroTLmcfgDdBMDsNoUobnhKtHHdCZlh+84S?=
 =?us-ascii?Q?tsBz241OuSH4ljcLhq2V13+W7xYWodTZwwN15L9qaDedjXxEuG99mLo9uKRn?=
 =?us-ascii?Q?I8CPo6kkrzEM/jmDhpnQ4mMxLi/GRXySepyc+IWdmlU9lrG+mFFllrc4boDv?=
 =?us-ascii?Q?GT4m1FoaEY5utbBKa/jU1qVkYKtTZPwkwW5TKtTOnRgKPbhbVjdmDN3gpSbB?=
 =?us-ascii?Q?yBx3YPxvBaE1nMlKuogiF2g3y20W8tFKXiRCIDYTfrYQnBogJWqmlsNAgYJH?=
 =?us-ascii?Q?PfkBHiN0LIQULvNAQD/9iQfnHn0GSh3RtBTlW9DWTdmKPnN0tqo4kWHMMxsw?=
 =?us-ascii?Q?R3D0r48CY9AQvmxHdqCU6m2B8SWc/ZwFL1uhk47Ru/r398vIlpIgtgqht7Ec?=
 =?us-ascii?Q?DMnHbB9nNtR0vrvMMc42UZXB+cPH6LKjQFDXZfP2L4+PkOhmzO/c6ghomC7D?=
 =?us-ascii?Q?lg08US4uxR/AT6lFLGJidaOxXDnuARpACi1cXgnytMM1yidX9j3uOEcM47pA?=
 =?us-ascii?Q?umZ0OQWwdzSnhZ4QnfOe30uK85ocB+HUlm+s2rGFDRWYcuVFKUZ8ULKHluv6?=
 =?us-ascii?Q?FhfGPLXmTSFbcDHHiuh6ufIxoRxw5GIePh3fOPZba4BHu6IAnBc3fl4vyB+P?=
 =?us-ascii?Q?r4JjuxUecAhbBdS5L3BCP8ceecleMr+Qa+uKGcA7+yrBRYd2kCWjXN0OSB1F?=
 =?us-ascii?Q?mB4sGlxbXr2WF9UqRJxMH5zu3tNFWXBewIhuqmuYe1/q+lOjdjm8fB19JyTJ?=
 =?us-ascii?Q?yQFtyFqMYN9od20GOEbT1izeUDsPLyB2mp2HOUF62QIH0VTKLyBF2q32oUqO?=
 =?us-ascii?Q?uRZWBkIOhsuBPi+sBMbjok6sRmV6jdAH2pza/gAZP/yTAyldXNR9MCc5lfsx?=
 =?us-ascii?Q?KzXlSb27rwhWacpY1zEMY+tPzsNhJf8E5EPZcv1csjkT4/l/64QHYaRDTXcl?=
 =?us-ascii?Q?Vt5Ki1nU+f4UIbXuLeedqzLznnBJ5rskpT6TDQ+QKIqP1maEZxZFOf/azyVC?=
 =?us-ascii?Q?mPYllcLKq3I7YakvH/3J2HudlEO3jmTN4CwTBqI4lzI2lqWU5XQS1r8ChKn+?=
 =?us-ascii?Q?IN4XQfwwKsTLxfYkeIJF7kAvkZcdluRCoPFaXgyDOLGxO4JrYr6p3uGvD5BO?=
 =?us-ascii?Q?3yrpJ+J6DEDlNgo9bFaUU3CW1tzYhrhROZtUJsygpldg7Nvv6D2TNKJo5yQc?=
 =?us-ascii?Q?1LVc9XsNxQPDwlvrOU8MGFW8A1Vj99/gogLj13D16JhcoS1ZexjQxJACA9JM?=
 =?us-ascii?Q?rqseRbYagG4+fM3bZfq9KYguvRr9K9/32nfFqM8P9fzvmf5bH+FweAlSO0tE?=
 =?us-ascii?Q?kP8E4drzgdj1Fbrs6lINaQ41TXta76bHj+0RTQKbD6bBVXn8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10062ea-9f76-4d96-33e9-08df2d2d0c97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 15:32:41.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMHrvigwg2k+C4wj/QKwcXdjAcK+jAld9Yjx1jGMxetjhcWEukhMj5u2PU4gIZCHOHveQiQl2sVRFj9yeJeGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB460542

On Sun, Oct 18, 2026 at 12:06:53PM +0800, Jiale Yao wrote:
> The EQ interrupt handler only schedules a tasklet. free_irq() prevents
> another interrupt handler from running, but it does not drain a tasklet
> that was queued before the IRQ was released.
> 
> The pending tasklet can access the EQ DMA buffer and queue array after
> mlxsw_pci_aqs_fini() releases them. Kill it after freeing the IRQ and
> before tearing down the asynchronous queues.
> 
> Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index bfe3268dfdc1..ba66142ae333 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -2085,8 +2085,11 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
>  static void mlxsw_pci_fini(void *bus_priv)
>  {
>  	struct mlxsw_pci *mlxsw_pci = bus_priv;
> +	struct mlxsw_pci_queue *q;
>  
>  	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
> +	q = mlxsw_pci_eq_get(mlxsw_pci);
> +	tasklet_kill(&q->u.eq.tasklet);
>  	mlxsw_pci_aqs_fini(mlxsw_pci);
>  	mlxsw_pci_napi_devs_fini(mlxsw_pci);
>  	mlxsw_pci_fw_area_fini(mlxsw_pci);

Petr already looked into this [1]. Petr, please send your version when
net-next opens for 7.5.

[1] https://lore.kernel.org/netdev/875x2788ac.fsf@nvidia.com/
