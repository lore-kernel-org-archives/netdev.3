Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611049E12A;
	Fri, 11 Sep 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146779; cv=fail; b=LsXhp1hAUjiUgph/kn2A1nsFJGzkv/cxJBIcgVuKTsrgMqz0aqmfEpgq+aNjLQTUC2vWJZGH/ckD0B2tpJwS9Q8eXZyYlsr7B/lSxJn5k7Sopx7gPe8vYi5uFYOL8OkDbtYu1ZESiEbZGqlqrJIJ9JtGDwzzCE1saYP3FcaBEnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146779; c=relaxed/simple;
	bh=fl0usCGyk7uVllGBU6E8mEjlbBX67JQMzbQN24PWcmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6hy2PAshWEGF8dEPBouozx8qMcfChsE95gWWDEQCgnTBgBuojIoMV0dvlcMEqGdIwxIjWvSzROIz0vZJRzJ8QTievmH125ZGTTDRmZ6ucI/O7GFn/a2HimAJNwxJJiA5zYH38Z/Hxfk1P+rGu1ePcq5wVmWloGvAFVSnm+lWZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LmL4mRyi; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LmL4mRyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuJRpf94ttOYzQJ8k8AZM8BxS36FFUPxN2IyNxOpOqZlHIgSIoAjNnnF2xYODtTrck5LmMOghMw77GGG52E4ffqLzfdS/gbnikm+ti9UJpI5QeggDpOiyPTMktqeHsdTlzo1flQQx+bXj7b3IMqupFJbOt4EZzjQalRrlemR0dslUtpmYnwOBY0er/xr/1zU8L7bD/n7EptLWy1Fd3ov3jN5FQ117j5TgMmcKzaC7upg1jju43ebjmSFJc4iMIAu7JdRDV1ANv9cvHa6zN8qtUnXvmLJ8JXs49FohjMvI3rrmgJDD/bDEGApU2MUrnx63JznkIuJ61dpVXnVN4EEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVtTSBzmMBip76W/I3MpfY/Sd4qPMo9AFuHuVZ9a6lg=;
 b=aiSMe80vxLz0b6tIndtZu2z8yU0TVDgxNms13zDoLKCAg0/nDS2tPR+mGbPw9BJPgBwCvfQUnJbuQmRU8wUC9UqVzL7tSyGsaU6enzibYFL1p5FTSXnslsDOL98V0axY+Q60tACsD96s81yFiJZV/cI9CDlyv/rB3YWdnbBp3dzHSLk/mWp1mxXdX8c1PzoV+/XqeLft/gkA/4zj2DDIikrZJ6Q7Hw7GfXnDG/5Urx76WsLWlOP7FHk+GUhvJvoulhBDb715Yz5lVi2GQWQd+wUQI6mf3ZxJOns9iPfnuBra1TBK0o9aqNERhQgYaAxmtkNFJZ4a5peypMvplVW7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVtTSBzmMBip76W/I3MpfY/Sd4qPMo9AFuHuVZ9a6lg=;
 b=LmL4mRyife2zjKgcYVGfsaFcutY5DhRDpz0Ux42YdDLu7NXYDJh2Y4EfFbA5vBWLPQFfSCa2NuPx/ILM3D7N/hKW9KjbS2XT6c2Op+vvcRl0P8JvuTmDWuNl+7mDHudEgyLctqHJtB5Jer7J9RYZNaBTJmy8eTdGw95CRnCNaqpP79nl691lJEd95MSLb3bas+pg5R/Bmv7V7rg/kOWIAm59th8o2aExNvd1soQGn0lyx/8BL7/urqVqwhohojDno9FYeVDfvsKPeIpsX/a4QOWX6JjPgLWhGrfhhmj2LesfRWrNgreN/ZcmOJoo7IYmeQlDAtHm+EAmiknGoVdgtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:12:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:12:51 +0000
Date: Fri, 11 Sep 2026 13:12:41 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Subasri S <subasris1210@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: chipidea: Use %pe to print error pointers
Message-ID: <aqQ2iYIbIbhfLljT@lizhi-Precision-Tower-5810>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
 <20260801-usb-ptr_err_patchset-v2-1-1698e298c1e3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-1-1698e298c1e3@gmail.com>
X-ClientProxiedBy: CYZPR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:930:8a::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: 73703acd-642e-4e29-7424-08df1027e8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info:
	4/EPstkLISdDHgKl4ivoG2nZblsTRXmBrqRxBmQikCsr4a7IyN9kfKZfvBYsHxt4CNakMicDwo6VG7lDSRUYLIrFIQveS0ZtC3OJqY6oUIp+Wo0RtKnHqSC6f+jMEyCFSYyfU0+AMtVY6NEsg8R70ZI8koUzMoezwb4Bm06q6jP+PP+JLsRkvmqRvgcX1V/UxsJ6lpsrVGPHT/QM0bJL24M+X9/70LRjnsWdL/5qHIQ4y55FIFiz11fEXYWDaK2Zvf/OqGW7VyH2FO+gXyLiqXp40DGwCCFgvSj/C7hQ8vcCKomcR2VpiAWiXQ1D4HTw3vt4DfEHEFDYp4DhIuoNE0i8Npz3xHnAv2+9m+gPrNuAdGlANmUGQ3FPFbEq2e6vWye9n78iy4epqpR/SOEJinIAeRpxG55iHq0+fIRl6nnqmTx+qEf+T1QwT2UPF9BPArJFgZtjW6Ic6+z8vQ8iVI07VxFZW7KjvUa8mCcGB7akQl+qlRc25KpypFWq5QvoC5Gyk1SOtPg88Zls3RKJypjE6lY+OMaHG6NUwlTgolRnl4IUP2jf/+oAbpYNh8ZW6HqxwsgSQVHx1tUP7Zfc1nf+8cATEuQe6BCAcCUluxjfbqrxSOqU+3P5c8EKmG8/YhDO//y/m2l+/z02Rfl5M0FOSg0V82sHVLHOm2htk6ThyGlRFA6A3E82w81XsCt9OaVRI0dEy8t6Xeqlw4ZA1+wk+Ln0JVZ4VmWey4W8FUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wQiPbCQqA6Rd5WQDM9MXNC2dyEw853xleQtb4HvNCTPefZK0yGGezYKd4ORU?=
 =?us-ascii?Q?VQcQmFw3MBY/1Dpkzveox3AiNN7GO9tpHB8fOYVplh05gjDFbF/9OK3eoLG8?=
 =?us-ascii?Q?uG6/ok5T/v5GEoZVX4vAaO8PvIuCRwz7oY/xikmTbtWnHRk941k8VEmvWk8t?=
 =?us-ascii?Q?UAaVgvqu1d8W758/8tTpBXezHxiu6xTaEG7lGaOBea0Sfce8dD/7qyKlTESO?=
 =?us-ascii?Q?7Tp3BkyOJqALRz3lOgwfKx8SRpno1paHV/lfWtkeVx1BqupzfHU9Uoxgvl+q?=
 =?us-ascii?Q?zLHA92x+9872lSc1nsk6vOtKdH5eBI+4oucO4Hj1L/2a1mQo7MtXHq1n/P8O?=
 =?us-ascii?Q?RuZVHswH19CcboUOIqJE2qJBOvSp8mPchrWs/Kx4FqUZcfC4T2X7dm+TqCrY?=
 =?us-ascii?Q?07/zptQKrd+t9Puc2ON3BePr7+swcltINHsqfLaiOH5xA3moAr7PY9TOY7X9?=
 =?us-ascii?Q?sRXlqTauWSgDtiXCWxZxfbKV7qkns3GhrLdwYfCPXv7lddkxvY7z/Eh1EOkf?=
 =?us-ascii?Q?Emhsr6fPGF1WxhP7ak8bY7CZxh98j2WvebloDjZNHHzkl5OSdzW9LvHYBWxO?=
 =?us-ascii?Q?FOqhcVq49F4ItaKfTjN/jMkpm5u/N7kjIXXZtzLtoJSZ4e0JN4JS1WSE+YZ/?=
 =?us-ascii?Q?tSpyO3bcUV1Yi7nWTcZZDIA77tkwKBKL9kOICwg5iirsdO14m/lhNZ7GUpOe?=
 =?us-ascii?Q?rOZVaXQbG+tRG/2t/n2Vm6g1sZizvWP71h9LNrrwoUCcU7V3psqW3zw0hI7K?=
 =?us-ascii?Q?Efq3XXPk6+fz5ERT/bJU0gvHxQ7tfRKXBDvbQO9DD8C3APO4M0GwgXSLLFja?=
 =?us-ascii?Q?WP0FF1IOGP6W9QoAVsAdyZ+hx3Gk9g8XhIMY1xvwj7lOE1Yv3u1UMAqd/SUg?=
 =?us-ascii?Q?RkVLpRpv9/J/f1w3pPPOkD0PBSnggqCHG9Q9D4hofkMU7Vk+degw0RjE5uy5?=
 =?us-ascii?Q?7UtFaNepLXq5hRxWEKHC+jrFP8B8c6Cjo/6CTys3UwAShoF+AVpzs3S6jrV0?=
 =?us-ascii?Q?UVweeXgH1WSgDtHiJrpy8Azs1RzmzatVEMUTPFL2xC87jlAK4OHo8xmNOGml?=
 =?us-ascii?Q?gbugnquMjCAxFGaqJhankpEkWLr3k7ojf+akMoKdxXA73+dK/xKPH5SgWbpb?=
 =?us-ascii?Q?rT35Yd0U78Su89DUpW8rj3tgpL2G4DlAukCcYm0nay4uOrbbg2nH5BKMybqE?=
 =?us-ascii?Q?cC0+I1+yNUs3j7h7r1aOME51fmqksfXh1t/sC5YkpJn1EnFFF1NK3x5/CcvV?=
 =?us-ascii?Q?as+hcqyyPHB/+RTtKPtzPYuGUNtzV0t5sBz5JrhLF9NzFLPr2L/gJHoDWf4w?=
 =?us-ascii?Q?osRv89dDZnQNGuOvrFKMgZozyNhSe23/2S2ZddJshHh7Cvg+HBvvNF8KuIro?=
 =?us-ascii?Q?qJ4eaY+r9zlJOSUjBooI0KcBpa5OpaexlSFkJdcg3bjWAPWKgTGyQfgDSh2X?=
 =?us-ascii?Q?jMuxDMoWFECxg3Ner8+8j44ofqwkW9hUN3IQkJIzIutvsfYYzYYr47x1novp?=
 =?us-ascii?Q?fbr/KOFBL6zV74LIP28tJxz8A0Xpv+zFk15DnbDz3j/SI0F6beLNKEy/p2iI?=
 =?us-ascii?Q?35ojjPcJQqKY2/AvnTGQVcyGuaBIh948tTuYxyHgngxUdaRCnwBIarQNKwFw?=
 =?us-ascii?Q?aoDHSIFSpApwdbBCO5gEMbiLR/geUmaNI/WY69AhYrC74Nmo4kQJ4iZ1rmCm?=
 =?us-ascii?Q?U+yxoikN1PEudlegz2w/9Nm44x/PP3JDV4V7lUmaLSCpqIO9oFSeWuKOsefb?=
 =?us-ascii?Q?1pCvQeJ7WavuE1Bxglhk8wzKgUpfFODhTLcLn+KVofhe4qUlbAeW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73703acd-642e-4e29-7424-08df1027e8f5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:12:50.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0jEwHUrN5pBdlICW4c0sUu39e9D4lheDLDy+62TRXPPL/eTmQDSLh1LIW0/qBHpZk5HLuBnTVN8srmCiswTTDBr1AqiHQ2mVqmZncIWXExeDXfcN6PjfUms2mHFxgAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996

On Sat, Aug 01, 2026 at 05:59:50PM +0530, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in imx_get_clks(), ci_hdrc_imx_probe(), and
> ci_get_platdata(). This prints symbolic error names (e.g. -ENOMEM)
> instead of errno numbers (e.g. -12), making error logs more readable.
>
> Fix coccinelle reported warning:
> WARNING: Consider using %pe to print PTR_ERR()
>
> Compile-tested only.
>
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++------
>  drivers/usb/chipidea/core.c        |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 56d2ba824a0b..7bfe37ed68ae 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -218,8 +218,8 @@ static int imx_get_clks(struct device *dev)
>  		if (IS_ERR(data->clk)) {
>  			ret = PTR_ERR(data->clk);
>  			dev_err(dev,
> -				"Failed to get clks, err=%ld,%ld\n",
> -				PTR_ERR(data->clk), PTR_ERR(data->clk_ipg));
> +				"Failed to get clks, err=%pe,%pe\n",
> +				data->clk, data->clk_ipg);
>  			return ret;
>  		}
>  		/* Get wakeup clock. Not all of the platforms need to
> @@ -448,8 +448,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		pinctrl_hsic_idle = pinctrl_lookup_state(data->pinctrl, "idle");
>  		if (IS_ERR(pinctrl_hsic_idle)) {
>  			dev_err(dev,
> -				"pinctrl_hsic_idle lookup failed, err=%ld\n",
> -					PTR_ERR(pinctrl_hsic_idle));
> +				"pinctrl_hsic_idle lookup failed, err=%pe\n",
> +					pinctrl_hsic_idle);
>  			ret = PTR_ERR(pinctrl_hsic_idle);
>  			goto err_put;
>  		}
> @@ -464,8 +464,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  								"active");
>  		if (IS_ERR(data->pinctrl_hsic_active)) {
>  			dev_err(dev,
> -				"pinctrl_hsic_active lookup failed, err=%ld\n",
> -					PTR_ERR(data->pinctrl_hsic_active));
> +				"pinctrl_hsic_active lookup failed, err=%pe\n",
> +					data->pinctrl_hsic_active);
>  			ret = PTR_ERR(data->pinctrl_hsic_active);
>  			goto err_put;
>  		}
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 07563be0013f..09db8a4eace2 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -680,8 +680,8 @@ static int ci_get_platdata(struct device *dev,
>  			/* no vbus regulator is needed */
>  			platdata->reg_vbus = NULL;
>  		} else if (IS_ERR(platdata->reg_vbus)) {
> -			dev_err(dev, "Getting regulator error: %ld\n",
> -				PTR_ERR(platdata->reg_vbus));
> +			dev_err(dev, "Getting regulator error: %pe\n",
> +				platdata->reg_vbus);
>  			return PTR_ERR(platdata->reg_vbus);
>  		}
>  		/* Get TPL support */
>
> --
> 2.43.0
>
