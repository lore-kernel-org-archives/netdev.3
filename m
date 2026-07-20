Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3D42E8CD;
	Mon, 20 Jul 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558378; cv=fail; b=AA516svOJ68Y4nSIri+7FHOnvT0enALh3Kt94b44x4ZqXsLUe3Qzx08L/JEw9Kb5qr+tmknwTtQxwUCKDxn3U2bm2KxT6IMqgxCUox4D2zrNfvwou3x8tD0KQMUaL75rtK7AbxwvKtJQ5xpti+XtDccYBqVRAo8UIN9/a2F6NNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558378; c=relaxed/simple;
	bh=WADz2WeRb9f+19d1bZptZbRLIl975xVBKwgNvA5fQh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M37Kz3w3GryJW3eub6S0eeROPf6AlVwDzYEWyMcwug1TXDQxpEJ2xiocRbXWg/N7twzbMVPY8oHLRlQeSbJYkS0KApTz/LRKXREJ0qyINstNXb06cnq2jItB1GlUwmzAM0t6IM2AYA2WmxczANtqc1qOqwyu6zx2nhXdn6wIwCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gD1W2t3y; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gD1W2t3y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH2OqdcbXxteojvc04t0pWQPH3nmqNYmozTthEV7e2pxVigC9l1Fn3doxgB26PbaePaHUVt5LL/UeJFw3XEozzC87CppjP1Jf/Wdm2sWwB0IZ2ug2FeBSVUDGXGRIuTrJvviIrs1IRy0DAs6KoKhhL+YRXl95pafEYm1VFx5xAuhCxvo+cuW74FO8Q7cy5h2t7bCGY4UxYIfvKEFnpbAewG0+A9saKKhuspxbV48hKHcePKRGaOtQfn00VdaNBUtalow9SWHOFo9+Pa7BVlGJg8dZ3ZFEE8d/mFZXzd7eW2Ksn8+0J1w+qFJV1NfOljiPsgd5U+RpcSFNSfEz04Oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSecXEPGRFd/zl25jxCLYbBJ4nEmgNoEaHGj3LOGPeA=;
 b=bdGK7MIStNdLsqW+BZknKdpYxrsOo9BIAk1Tf9KDisuzLsUpNma0gdY+r+0Dh0vUU8FNxRcXHQxkyxxxPZmloQP9czS2bTVzYhARe22EYolvsoI9jupCxuDMZ2SSyyIl2A0RcvAKcIvX6n/6aliZI88CCmflFc7sCbj/gwqfSOYO4lHGrqLtCI41LlNokVAPDZI3NbbYhkAXzZpUnOQJEUuCogpyHtH5SuDRYwJjBdhkzepuLJi2SS0lrUN8FQdW6PukQBxvtLOoN/OIScXjUOPmobzWeJS4fVqIDg8A2OstFbcQxNiBazI6EXKZQ9IUihhUsCTnV2oKf2LuQSIWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSecXEPGRFd/zl25jxCLYbBJ4nEmgNoEaHGj3LOGPeA=;
 b=gD1W2t3yC5c/XsT8+/XhvpVpgYAggp89taDRmDvvWoa1I3S6YCIgnwxcV87JIS+4kuRp8ChgkR/mNBa1TKrhdu7FngYnBsM8Ooq2nphbUL3AoOdgNWOvG68Vj47SOny1WQ3qHLTHvHFarlTCQAV9MrPVvSyxRtIj3m0sYF7s5XH3o7ts30m0/rEpj323bBm8lZ4Je9wIQmeQgWSC4+k3L/Jstvx/GYPICY4fBCQsk6vHAGEHc4FrnXk7Om/fCoecuB0F/lPdVW4jmqzQLPsyT+4r2ukHxCDXGJNF3Iu7IbbGqDn1bPFN2aLd9b85utyziMxZffoVmVO2HWzM7yqg+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 14:39:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 14:39:27 +0000
Date: Mon, 20 Jul 2026 09:39:16 -0500
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
Subject: Re: [PATCH 1/3] usb: chipidea: Use %pe to print error pointers
Message-ID: <al4zFG3zCD5FJ7eB@SMW015318>
References: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
 <20260719-usb-ptr_err_patchset-v1-1-85f7f2e4fefb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719-usb-ptr_err_patchset-v1-1-85f7f2e4fefb@gmail.com>
X-ClientProxiedBy: PH7P221CA0068.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b28cb2-24d4-4a65-d3da-08dee66cb37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info:
	7y8itcQbTdIfWPPEVhyJgJ+pFrFT5MLYmL6RJ6zxzupEWiPgz6n2pklXFU5guC/D62jN4yRBVywX9AS03LYWuY1LivHrFdSS8HrtD+qaRb2R3pSs3Yn+xPLgHZi0D2PecT6U2g9HzDj6rdtgnOyWrFjxkzq7NeyZzujSiNqUvc9KDd3chIHKhLXSZ3OS8tCO9FWEL2xy+EU6jrC/0jDbR1Cbh+HgOOZak8oXLDZDE4eB+eMFWtsEfUXVVOL/y91n7MDRnybDiPb5LXn4/NBJAfC8JU/VCU3rwc1YKWD2GfIhYnwrv/96TTJMOmS+N0Vha+UpKHrKMni79g9paqSUQxP84fTbx7OWIWhzA3pHaK7k0f+ijH3aUf0TtCGtPcDg3v/O1v5dzJ/O8YwViXEq5g6nFPzrIq003DPxu/PHR4csRSgl1hNhCfV4xAY4jfUmVaCja1m3QZFgRhmS2l1Qeji/0rR/pB2iH20zUuvXT9PGg5B8N9oc3rkzRi7ma/tZglhwYycl56ZIy7d//JRmV4VCReD6Z6EcpOqdj3SLnOfLcoGVATgGUNRzckHpERA8GU3PWGGv3ise/6QWjkYvEcbmp9ySTomot+GftvZ+ZLdGMdKmj+gKY4biDdjmpjKy+u7V7mjQRsA/AQAA0IHfk6veiT/1r2+LSkz+SKgNV2EQszN8FyAVQYwt0IPOEspqxafPJmjEFPkmkhEs5cUxdAMAxjJ4e4DLnBaSra72X9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vS/c7Zpqg+m4Vo8nR/8RBILmAeLsM+EcpqVO0cHNRiN/7sZnGMNm/ritZM58?=
 =?us-ascii?Q?UJIeezOoqrwvjj08huDhmBoRvtiM8bCtVNILMX5ZVA2ICt+BtZS3eDze6j9o?=
 =?us-ascii?Q?96Oa3QMyWFvyMBVt3Qw5qxrzjW4FB4GcHehUdJvnUM7xLyBlM/iw7DhwT1TG?=
 =?us-ascii?Q?fYpOULEZyEnvEgDeQyFNn1d1euYbK+dovRJnHO8X/sjQuABNe4zFAf9l2jA0?=
 =?us-ascii?Q?3E9SLCf5RqitwcKFj3UDhFvAres4jKH5NAuI9+fs9TMyCrYOT9oaID3j+I91?=
 =?us-ascii?Q?kxdIzvuW23cBvJfJ8E2E18UfOgOr6M4/WOZ2awL09XObWxJhWykGPDBlsi0g?=
 =?us-ascii?Q?TyYeYxqtJ4I+Ld8bUpFTNgI8p5M73Lha059swBIZ6+ydMnWBGm/DFp02SjQF?=
 =?us-ascii?Q?sQbdeYVUKx8qYNVGfCC9DVibj22nCrB012NUbhEbslu23/K01Rk02/v4zMyx?=
 =?us-ascii?Q?HGsvhpOHe0qDkdqL2OTdTMMpjW/WIKZwakM8HQpo2LXuumTfGjoWwrtIFc6F?=
 =?us-ascii?Q?zYka0GvWrSjp2SHPMH4sx1DEd6mMgxjiUzim1iXrSs2Y6Brgofkj2WOpXj0v?=
 =?us-ascii?Q?YGA6zJgO995XLT/LIj24rvQqIBzvZTHholpVxRIZGw670Opi68DLtX+IY9cZ?=
 =?us-ascii?Q?OsKOwO6w433vCusiZc0SoVvnw4e2eacuPbRd8rN6DVmz/ThHSayWEkZ5ESEh?=
 =?us-ascii?Q?gfrF/UfJDHwBVpOxRpoJgWS4GQqDVNzpRXC0Nod+bf37OZUOD9ib929t051Y?=
 =?us-ascii?Q?3LLBrdDYi5Pr5PFfGRX2C12JO5y2SX+0FsM1v2aFpH2BheDhQ0ADrBe5pTpu?=
 =?us-ascii?Q?qt1nlLjHb2oOtbfJkn5LaP2/CDnvmFA1LHwut39h8Z3w9ye1VW2mq8faSggX?=
 =?us-ascii?Q?D65zhbdlsH1cuKv6QeosoYPpaqvtUzj87ZElKXiKP/0cbNcCd1bN0ngBvJfn?=
 =?us-ascii?Q?x+wS+EiU8gnJJ/P5npRhinowAq2YYc++kLuoFqwhBnU1rSojyBKW/GL8d7Z5?=
 =?us-ascii?Q?LwZ72HubA2DNsWaaMQ/b0E8tFFBaLa6A5BgBAbPJqUi3jxZl04laqF+2Ouw5?=
 =?us-ascii?Q?xdXC2MwxIlqbsnmRgdWfMwWT6hktLcVOLhlgTfhSVIvXuAtnoffs0OTitmSI?=
 =?us-ascii?Q?eMndTPUfTclQt5B40mULXuJK+l+Bn1VC8bqyJnjST/xQf5TvhRmz+a2sUZnC?=
 =?us-ascii?Q?/f/yY5y88Ioisyue3O9rgsH68yq42J2WpCabK3O+AeZ90RHMqCd9D2bOaSId?=
 =?us-ascii?Q?6hlUi+B1Yd39m4h+LE6D26xJ2yrhg4qcrro1G/RCz61C2iog0jnDzeZb6efe?=
 =?us-ascii?Q?aim+8YWQ2eCsEcIXaZBj/mFrg3zZqjky8aGdAPA5uH8jVxrIYMdbYO6FZZe1?=
 =?us-ascii?Q?QnlHFX0/iop4CctwJHmP8ddMYCCIThNUI32lKSIJaZVKA96sdJ9FxFtSw9al?=
 =?us-ascii?Q?Ws4aMMP9vlqTjecn/0wNzvkAlw2lJLdr7IRFLGEoF429sZJ/YZIdXdz3ki5k?=
 =?us-ascii?Q?Q2sLYqRGaBTvO1P4UoLz/CjvhpoH5u9BGijpGL+CYvCj4zDvrV8OwVHwL1Xc?=
 =?us-ascii?Q?sJZTC3k/0hH1QWFkjKdtdjCKR0Mp5Je+7v4tQZ1XlYqOWOmjvWB5bNfBxUnR?=
 =?us-ascii?Q?aoHO11sqxscIvzJK0uJuom1ylSNwLWSi+y9N3So5jhjy8JmgkYCwL4tHIQmC?=
 =?us-ascii?Q?QpwPOjuSp4UYwT4VcTaQC1rmFHzC6BU4i0nXKN4YWtdVD7Zmli99hw7eQDYd?=
 =?us-ascii?Q?C/cwI5xeK623EzLvvm61sTi96SqPrdBgsJccGJtSwy09OBH0znad?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b28cb2-24d4-4a65-d3da-08dee66cb37f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:39:27.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKVxxTPTBsE3v+zbnZqgpBOGj8NpwYs6QEmIuN34B8+9CJoW934Pt3T+4rBJ99iE6atCdl8Fs5Zzsd8yGYyiqj2knNQnbFJDzbpzILrSg+q0oHjNuJssjwt0L2oKGBsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360

On Sun, Jul 19, 2026 at 06:25:46PM +0530, Subasri S wrote:
>
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in imx_get_clks(), ci_hdrc_imx_probe(), and
> ci_get_platdata(). This prints symbolic error names (e.g. -ENOMEM)
> instead of errno numbers (e.g. -12), making error logs more readable.
>
> This patch fixes coccinelle reported warnings:

Avoid use words "This patch", just

Fix coccinelle reported warnings:

> ./chipidea/ci_hdrc_imx.c:452:5-12: WARNING: Consider using %pe to print PTR_ERR()
> ./chipidea/ci_hdrc_imx.c:468:5-12: WARNING: Consider using %pe to print PTR_ERR()
> ./chipidea/ci_hdrc_imx.c:222:4-11: WARNING: Consider using %pe to print PTR_ERR()
> ./chipidea/ci_hdrc_imx.c:222:24-31: WARNING: Consider using %pe to print PTR_ERR()

keep one is enough

> ./chipidea/core.c:684:4-11: WARNING: Consider using %pe to print PTR_ERR()
>
> Compile-tested only.
>
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++------
>  drivers/usb/chipidea/core.c        |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 56d2ba824a0b..7bfe37ed68ae 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -218,8 +218,8 @@ static int imx_get_clks(struct device *dev)
>                 if (IS_ERR(data->clk)) {
>                         ret = PTR_ERR(data->clk);
>                         dev_err(dev,
> -                               "Failed to get clks, err=%ld,%ld\n",
> -                               PTR_ERR(data->clk), PTR_ERR(data->clk_ipg));
> +                               "Failed to get clks, err=%pe,%pe\n",
> +                               data->clk, data->clk_ipg);
>                         return ret;
>                 }
>                 /* Get wakeup clock. Not all of the platforms need to
> @@ -448,8 +448,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>                 pinctrl_hsic_idle = pinctrl_lookup_state(data->pinctrl, "idle");
>                 if (IS_ERR(pinctrl_hsic_idle)) {
>                         dev_err(dev,
> -                               "pinctrl_hsic_idle lookup failed, err=%ld\n",
> -                                       PTR_ERR(pinctrl_hsic_idle));
> +                               "pinctrl_hsic_idle lookup failed, err=%pe\n",
> +                                       pinctrl_hsic_idle);
>                         ret = PTR_ERR(pinctrl_hsic_idle);
>                         goto err_put;
>                 }
> @@ -464,8 +464,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>                                                                 "active");
>                 if (IS_ERR(data->pinctrl_hsic_active)) {
>                         dev_err(dev,
> -                               "pinctrl_hsic_active lookup failed, err=%ld\n",
> -                                       PTR_ERR(data->pinctrl_hsic_active));
> +                               "pinctrl_hsic_active lookup failed, err=%pe\n",
> +                                       data->pinctrl_hsic_active);
>                         ret = PTR_ERR(data->pinctrl_hsic_active);
>                         goto err_put;
>                 }
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 07563be0013f..09db8a4eace2 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -680,8 +680,8 @@ static int ci_get_platdata(struct device *dev,
>                         /* no vbus regulator is needed */
>                         platdata->reg_vbus = NULL;
>                 } else if (IS_ERR(platdata->reg_vbus)) {
> -                       dev_err(dev, "Getting regulator error: %ld\n",
> -                               PTR_ERR(platdata->reg_vbus));
> +                       dev_err(dev, "Getting regulator error: %pe\n",
> +                               platdata->reg_vbus);
>                         return PTR_ERR(platdata->reg_vbus);
>                 }
>                 /* Get TPL support */
>
> --
> 2.43.0
>
>
