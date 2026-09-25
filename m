Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C44BB299;
	Fri, 25 Sep 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348360; cv=fail; b=s2hAsRhfay5opJBFvKJK3vc0rH4a9Zuk+8gRPBBCQ6P4Br+PYnofViSr34XXfncNmGO8fPpq/VXWTZeVVq6DstEDFQ153+a9F+J2670Y7hh03GMi4uv1IHZh+UPlD4cqhO41G9HwnDI9j0hVN3CrgAVFB2/WiIWxLLHnrDRv0+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348360; c=relaxed/simple;
	bh=8/UAaanSxe+xF0AJUWxMA41uCeUJwCrnpTizb13AhEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfSCPwEqGTxbzxEZZAsZxdFZKUJCB873pIN5ShvgKTApj3FiQm3lovvyMMCesoeCHVv/r6V0/t77A5Ro8JvbVZU9uNOAxM3IqnD4NrKr55Et+8VWQOWvLr2hHRldZrGfSBxQOkXlUbHakV9fUzPCf/q84+vpLKnpmc5fuUSiVg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dtKQH6Y5; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dtKQH6Y5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQFNy0+aY6aghlmTQDpST/99LZI5d0ju3KsHH0dRHJyyz51MS7I6XDREAEbzXj4I97JEbXrDoP9/qLTGBu6lKJsfzEGiGMc4N/ObY1LRxs3cd3QUSQEhPcKXTzqnxKD2akKiI9VjQREmZj8pACYpMALiGpjc0lrGhkEoLdQrIKf22T65mBSsB0lI26Jhap9O0FND0KejuS3hy0qcBhvDF1Qt1Bp9tHXddPy1upe/bG6xNXPLfpTjzXFZRO6WBPpG2T0rEDiYRCcTqRpAl3fqW2ncEbfYMeBB8yya7Z/N3XV2MxUQuLZSzoY7UJ8jl+n/hFEl5BpQuGC3C9C0ccBlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1N/qcMgnVn7IsG/YL8A09rGizz8bLVOS8maSiHpFXE=;
 b=Dey1qsnsYSg1U32GD/wGzffhSvS1ROeQuk1GldpyJJUy/diVFjiC3bRifH/rU3tMGW/DLRXTMpSFfO0CHeWJaRkR/jyTUJEplEAPvVdrKhF6uP378Yrqcpwn++jIceybTsbLE/lEYvTinXvk2NZRMFbrQIE++qGoo2fqUKZylovFS3aDzRGU2e2bTwj7ffTAqd7aue9PjwDitjb50MYHP1qnuLCt+a6WlAVuOkYoATpbupcIm5Xmx3JUBfWZsagvJeaAUGYvSPlC/FDRhgSaXPKMhOsF7s73BuMDZKKIVPTyKolAcsuP/iJz2TSPpB6xySiT1rVgE7y4TF+K9K+t3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1N/qcMgnVn7IsG/YL8A09rGizz8bLVOS8maSiHpFXE=;
 b=dtKQH6Y5bQRyDwDv3nl66LFvfBVE4TsMY9SM7HpJYBHJQ9AduObF3KRyig+wyWoRa9sy6N6spZ1JfVfKDk/faVPbqML/pxRhDDRiZttosDdfOJaPz+A1HhCSXiZLGJdqsWpIsCk5NO+lP4VnbapIMKVR36elJpiik9sfxJDn/ouSExd5mItJUcX3i72l/tayXX4vpR7jy33qkZi28Ts/T75sBEyHp1MhRGjEya862PWKp2znOJboE33Ikitnda6ur4ap1Efi2vJvvuFgbTcOpBTdabnlPosyqeDea7oLpH9YAv1lwqlgAk4Qyv12CDtPNNtn/a67J/I+qM5N999puA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:58:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:58:57 +0000
Date: Fri, 25 Sep 2026 09:58:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 04/11] ARM: dts: imx6ul: Add Variscite audio codec
 files
Message-ID: <araMJFirhP86Dcb6@SMW015318>
References: <cover.1790344389.git.stefano.r@variscite.com>
 <ef56f98137eb9d1e0af3aa1b801186d829dba521.1790344389.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef56f98137eb9d1e0af3aa1b801186d829dba521.1790344389.git.stefano.r@variscite.com>
X-ClientProxiedBy: PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: d5618963-de98-40d9-0692-08df1b15865a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
 WlOLTSuKhGABnJvFrKlo1yvHj936OMZMqSWskYuokMHsgrfWst8+mKdHV20cUDqn74F45nKg8/njcubS6zS03O9KXzV6l5ZWKr55baelgeWdKAkRpKtXzsZ3t7i9RjJnH6Ojk0a3h1nnp+Vfb2gM0EzpoQvZ6jjjQbBwTczxMG04BsOcGAse8aowDjblhYP6WXQBqBQJUuSRJ7ZJdQS8TssUksNTOAf8DwFjUsmcddvhg08QFBMKBTlS6tJex1lkIlauyub3aQYTQVwHHgNlsV7f7i07USvFQgjF0LzsegdYB2FVEHFolxH+mWPZl3YSMkEAQ3PwEtE5kctG7AJhv/aRrwCX09mxdu00Y0X1Iu2EKdnWfBnKVgxChu22fVDjxaO6kCegXrFGARPUYvy6hsiaHUijU5cYvy+Odv24U1k7+VXW4ZCIsZVOThtkveh214HpwIPVlMcivvuWKRKHSMCDPa6W9t2Za2vXJuBKz5b8Melcx+ebam8sGr4oyWT3DSPjkPLmq/+hDcq9UVbn79q0tIsYG0Qd4rco3umuT2kWMWWOrdJV7WSOkAYF0ij5p7bm9kS4shIoG0PrFBUP+QOOhxyzvX/TxZcoLWuKTZI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?u8FjSSpAu69/bTZuBYtR5tfnyR4j2n1rBZRHLaFv5X/P8nwiOkYCkEU1xvPt?=
 =?us-ascii?Q?rOcxJ0JHM8KinysQrjuFa42CUlM4mFNHt4Z2zFAJpOtudsZS+kBpRbz8j4u6?=
 =?us-ascii?Q?YrO391wJHd+IXuS0dQ8FbvKVawFd5p8ivDZmTb7i3Ak0mBwmKEy9xzfkyKJV?=
 =?us-ascii?Q?Mcqd5vYOx+k9ls64WlNkOLw/H3z1y8IEGdDFcE0mf8wQRyTgWRnUQU+hSFiX?=
 =?us-ascii?Q?uz3y8hQI9SSYRyMU/npqf1LLuxON7UBVVs7Uagf66NK9f8GP+At4ExgtjEfq?=
 =?us-ascii?Q?sE+HKxqzvXpwf8M97OhvMSnYTf6hHZc7dyd0Wf0cZ38dO1U7oyRv5fOtrzYr?=
 =?us-ascii?Q?u5gJIOCZ6irbUleArxQ0BMDO934xFSe64MD8lF2ROFIpgRm09Hjkd8jwj2J3?=
 =?us-ascii?Q?Z2yL7H0AX1IIqPgkCIkf6zXDA0Zb96TT+5FY4w/FSFiRtuxh4vMf+U4Bq3M6?=
 =?us-ascii?Q?+xq05DWUSQWHlMdNLTQHeOyWp/m5x4kjmyIN8LpUAa0VOZzjIvRvBOciz4br?=
 =?us-ascii?Q?Z9uFIr1MQ602u5eSZW7rqqj/IzW8SvGHKWayuhYmWUC7K3KwiaUT0Aa6sP7m?=
 =?us-ascii?Q?GKBsU7ArQouNCRI9uMFMZLlbx5kWsAeZXCaXHqRpVjBFaCzzRSAfnYnatwux?=
 =?us-ascii?Q?IIYIZiomu2WPz5N645uOSg1tLGLcx0K8SF1Rj83+g8fMMnFhEFFy8BqvGiQW?=
 =?us-ascii?Q?SmEplvFYvD4aE3hBY6olzM/ULpfHdozy4PavxA7XFVDxvetIT/nfVGU2Zeff?=
 =?us-ascii?Q?UXSLblGnDvSSu6z6HWmspBBMx3sbDJYRrgTgMIJQcXPzXySjAGuxK7QjiuG/?=
 =?us-ascii?Q?h48MXsCFaXbk2JfHA/3H0QiNnZB9W0p1M889vGhF0cjzi7swLaucLHPA2vaa?=
 =?us-ascii?Q?EMccRBkHCHuSFOb0G6QqBQC56MSR55wV2HCfwUsrvKAAcbVY+wNkDCvYVr+r?=
 =?us-ascii?Q?JYQ63SjWgEa6XnF4z2lRUaoc+Bt8SVewpTv7AvJC8DOBYOGHa26X7PaItDhT?=
 =?us-ascii?Q?JCVnUk0e2JABxhjp/OyyCtFcC8kMZBD1j/oIyNCI3prpCNClbhsyUxAV7s8B?=
 =?us-ascii?Q?P6F/B9jvY9wHUNVY8Ne9J5W8/PPTVE0HQfN1F5Z9k/fiPcX38jpO5W3GprvN?=
 =?us-ascii?Q?hrxrA7auFFeZT818JCnZkwE2KT7SouwU+wYldRoUNNFQSTo2uyLVi0kakTIj?=
 =?us-ascii?Q?0hcQS2npscjD/PnBzCJqf/pxHt1dRz4ML8i/oIILiB2bDVFFtG9IlUNDE3ib?=
 =?us-ascii?Q?L8idDpBYiGeBXUpTDOhvFlUAt6EsMF2MoJAVDzhIoodexR/nSZdjwoPrNaNC?=
 =?us-ascii?Q?0JWv+VPUZhV/cS8rybyDAMEKvAvIx/66IwUURwLoU0PY3mQiPAPP4Tk/r0h+?=
 =?us-ascii?Q?yWrjOaQrOL6fSIybKJ3dg/OHzqcS4oo+DQoreYyB28lB5QBmlpDRjvDs3/kl?=
 =?us-ascii?Q?Rv3J1rgx2ldg0WgN43XI5tD39qFdob6Siq0kDStOIqytIzmGATtE/eg/cGR+?=
 =?us-ascii?Q?SdTcLVEc+ACGvKMV0kAQo/6AUHvUSfZqHbOIWTd6iKsoU/a6vO5gxSt8uZYV?=
 =?us-ascii?Q?Ci9M6JOUii3sVitLLKbMyUoqFdqURHkz8eF2GTxzwFl9Y9wD5s3aOURUBAvD?=
 =?us-ascii?Q?d3qjX5rfrDd//aBpMzf5NJB9UVT8V10p3cXEsOpawipBZGr//nHJMBsNby9T?=
 =?us-ascii?Q?ntq4nPDv+MkGZyG9o2BefUQfKG3ypC02Bd7VPK1uZ95SY/qEBReuZz72aqib?=
 =?us-ascii?Q?KIcuSiZulLIR/WHPqVa1srMLyuw8fKqAkU8XO7rHHtZzfEVGM2kf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5618963-de98-40d9-0692-08df1b15865a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:58:57.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lb7wFIba18dINvg7Zegnpr636YVSTxtjY+tmV82GSMrjmbSAmiYOrgQXr8IvbCBOuOKDKepy2vOI/QaFNOrKq1ZsEk+GxLDswz9MynTVMsBRsONRRJK02eICrWwcK1mu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214

On Fri, Sep 25, 2026 at 04:02:21PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
>
> Add separate DTSI files for the WM8904 and WM8731 audio options on
> VAR-SOM-6UL and DART-6UL modules.
>
> Put each codec node, the SAI2 setup and its pinctrl in the selected
> audio DTSI. This makes the WM8904 option explicit instead of placing
> it in the shared module base.
>
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
>  .../imx/imx6ul-imx6ull-var-dart-wm8731.dtsi   | 71 +++++++++++++++
>  .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   | 88 +++++++++++++++++++
>  .../imx/imx6ul-imx6ull-var-som-wm8731.dtsi    | 71 +++++++++++++++
>  .../imx/imx6ul-imx6ull-var-som-wm8904.dtsi    | 85 ++++++++++++++++++

what's difference between imx6ul-imx6ull-var-som-wm8904.dtsi and
imx6ul-imx6ull-var-dart-wm8904.dtsi?

Frank

>  4 files changed, 315 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8731.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8731.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8904.dtsi
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8731.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8731.dtsi
> new file mode 100644
> index 000000000000..7d74fc3b7014
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8731.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,name = "wm8731audio";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "RHPOUT",
> +			"Headphone Jack", "LHPOUT",
> +			"LLINEIN", "Line Jack",
> +			"RLINEIN", "Line Jack",
> +			"MICIN", "Mic Bias",
> +			"Mic Bias", "Mic Jack";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Jack",
> +			"Microphone", "Mic Jack";
> +
> +		sound_master: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	codec: audio-codec@1a {
> +		compatible = "wlf,wm8731";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_3p3v>;
> +		DBVDD-supply = <&reg_3p3v>;
> +		DCVDD-supply = <&reg_3p3v>;
> +		HPVDD-supply = <&reg_3p3v>;
> +	};
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_sai2: sai2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
> new file mode 100644
> index 000000000000..1e1ff8c6d7b5
> --- /dev/null
/809> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,name = "wm8904audio";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN1L", "Line In Jack",
> +			"IN1R", "Line In Jack",
> +			"IN2L", "Microphone Jack",
> +			"IN2R", "Microphone Jack",
> +			"Microphone Jack", "MICBIAS";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line In Jack";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	codec: audio-codec@1a {
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_3p3v>;
> +		CPVDD-supply = <&reg_3p3v>;
> +		DBVDD-supply = <&reg_3p3v>;
> +		DCVDD-supply = <&reg_3p3v>;
> +		MICVDD-supply = <&reg_3p3v>;
> +		wlf,drc-cfg-names = "default", "peaklimiter", "tradition",
> +				    "soft", "music";
> +		/*
> +		 * Config registers per name, respectively:
> +		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
> +		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
> +		 * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
> +		 * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
> +		 * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
> +		 */
> +		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> +				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
> +				   /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
> +				   /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
> +				   /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
> +	};
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <11565177>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_sai2: sai2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8731.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8731.dtsi
> new file mode 100644
> index 000000000000..7d74fc3b7014
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8731.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,name = "wm8731audio";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "RHPOUT",
> +			"Headphone Jack", "LHPOUT",
> +			"LLINEIN", "Line Jack",
> +			"RLINEIN", "Line Jack",
> +			"MICIN", "Mic Bias",
> +			"Mic Bias", "Mic Jack";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Jack",
> +			"Microphone", "Mic Jack";
> +
> +		sound_master: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	codec: audio-codec@1a {
> +		compatible = "wlf,wm8731";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_3p3v>;
> +		DBVDD-supply = <&reg_3p3v>;
> +		DCVDD-supply = <&reg_3p3v>;
> +		HPVDD-supply = <&reg_3p3v>;
> +	};
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_sai2: sai2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8904.dtsi
> new file mode 100644
> index 000000000000..72a73011af6f
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8904.dtsi
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,name = "wm8904audio";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN1L", "Line In Jack",
> +			"IN1R", "Line In Jack";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line In Jack";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	codec: audio-codec@1a {
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_3p3v>;
> +		CPVDD-supply = <&reg_3p3v>;
> +		DBVDD-supply = <&reg_3p3v>;
> +		DCVDD-supply = <&reg_3p3v>;
> +		MICVDD-supply = <&reg_3p3v>;
> +		wlf,drc-cfg-names = "default", "peaklimiter", "tradition",
> +				    "soft", "music";
> +		/*
> +		 * Config registers per name, respectively:
> +		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
> +		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
> +		 * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
> +		 * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
> +		 * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
> +		 */
> +		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> +				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
> +				   /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
> +				   /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
> +				   /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
> +	};
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <11565177>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_sai2: sai2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +		>;
> +	};
> +};
> --
> 2.47.3
>
>
