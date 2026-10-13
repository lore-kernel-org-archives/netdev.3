Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5052CCEB;
	Tue, 13 Oct 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905169; cv=fail; b=B/dYt6gehBlvlgpj6rOv/emkdgYjAdpHXavdhGYp0aKAqBwIJ4kE4iIzmWFR4cAHKYWQZKXYFU3zZpiPLI6oz37Wc14ylfS+HZ3C0uu2WKEKHHQPmd086FNoV2EhBjqLTAw5EiRYXiW6nY2hg3wX/qSt1GYI6RKKitxRCCkKLrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905169; c=relaxed/simple;
	bh=tMZ1ziYlTkwebljrQS3bmddi+kxVrEUPh0dw5ArQMiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IIrAhTjkmX/EQc3rnEIb5rVL6DhD0PFL2k55PmVcMupo4UGAQOEsckWHXhhY4zpazVpms9H0rDpTu/qCbPUyABIfqp04patmEn8tVNVcoA7wt7yDMEMgBCezi4rhhn0v+DNOQNQ0mY7sDw6JMVkawcHmODRdILulLxk5gKYvktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xw8AYGf7 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xw8AYGf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDFnrvL9tSACgnyXHzNz3+huIeIrl3hprJmMeZKhB73sbpbZ0fkPnszFv1+95stxJ1cLC75MgbOWCrSaZ9W53/rCRdzNvorOEAfL0Ny8l4d0upnVID0rGu7P3FDhH+77k2fXnMr2oTwrpCs0VqkkYfJwllIsOZv1AzggpKe8fyUaNWUOyi7A0gW9SZZIOiKhEHxMMxrwvS/t8dRboo8FlHg7n/amo1nbSNBc845Je4bwYbQNlNLvizUoAcsBs2uzRPO6oJm9ABeAVmLdLUoWq0/4DOabUrgFR0HVvYlT0Jg7Q29FIzAdwC77ymmkXgubnEsr60Y1Gn7D/Iegoni5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLXNebj9SCo5lJuP5kj+GIkeswp+rCq77dYnrIAHQXg=;
 b=EqfeMzhrZEqjCaBzWDCBwN1spIaa7qVdxuq5Syb3uEklxS6Yk0jnO4ZQKSVT+0OHSxszRKtmLiPPQo8ydjgXDBOdTnOq7iy+AVoMRpDUEgwyS0sVEo3kEJYKRYRFhtTp0AQJ/mmSexNCA2nT4knNx/SvYe1MT+l8OeXTvUzN5d4Ca+0CmEjveFjo5QdbflYcvI4q82DLvBrBnnWccGNMZt7cbuMzNnp8o9D6DomquaDFA73qtjVkNpOFneotQJI+O40JjVY1fKvV5yMLQgsZH202Yz9JiWAHkxTOxbrraf6TowfcKFr5wVU5Tp4sUdXdx74mqWw/qiizk8VHA5oFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLXNebj9SCo5lJuP5kj+GIkeswp+rCq77dYnrIAHQXg=;
 b=Xw8AYGf7p16IvmdzWwVD6DwigJb+6I3Spbhsk9uPlQpKlXOzoTsotKEUQYTC5P6dWDVMMjpMw5g0Ngq5xe36+opp9aZgOFGMs+cr3qyude0/hj+/5AboC4AUuMiz3VknUmdxOer76PdCjylI/D41HgmO4XOIYVKt8Lau8nLASygseHktfT7mIY3Os+psrNDvwhxl4X0jDPJQ4g2VFa/qV8Xo8BMspc4NV+RxzV46ohJFup3PxSJbXa9BtzCre6WiTcqkXqSDLpySKN2R5DF4RzPKEB0EgDTUS7zLHIeoJqOF6HpxtyO2zUyvAURt5uGvlGVXrlMnX9763qhVt6HdBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10204.eurprd04.prod.outlook.com (2603:10a6:150:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:26:04 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 15:26:03 +0000
Date: Tue, 13 Oct 2026 18:25:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Message-ID: <20261013152559.cnh2i7i36hak6z3t@skbuf>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB10204:EE_
X-MS-Office365-Filtering-Correlation-Id: e0602c8a-4d84-4a04-f4cd-08df293e4ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|10070799003|376014|366016|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rSc1iskwXI85kxaF5ePFldnv2SSVxNtSb/sp5Lr7ocASHAVferSUU5aCcxq4mJax7sali0iFs8VuaX7LtS8FD+r5V6dTEYnRZnczETWw//qKm3RAkGdJd8pn18HsyctU5k99m2AjbMKGM1GcTDv6nWwLQi0mjVXCn+AwJmppdBQxPkQGAdDZULpCnGU6zpU91AWlrRm/5u5BbhhM0tubMQoYovsBpTf9hu9wBY4lOwQyXmkX4gkCeadrHZdJ07GvdCnh6IhDnc+pJkCoD/NJaZfN3cdZ01NVrzmaYkdu7c/ZVs1rOdl0ZTmpu7VpFNr9T/x/5XvbGHcTkTFAnwtUmNhfFTR91/7TE44ba9WPuvRZ0wphjxnJk679LmBr8xyzZcyH1UAPc7Klj+dob22Q8AMJl12i4gqXRMXwuBIEi1B/CCHa7e5uR3X9NBJmDwY2BdAtloAWk/8MOvCbR7VtuEQTCnTdu1ezjnJdcdtC5Rx7rwD2KimntDZh+koc/M+K0C2KUYFimP+35ngrF60adH3a2tiWlJPJ9FTRb5xPXUiRTwrMngUfjNbxE/zGgFtZZQ3+K9xTdxQvhSmbCWkqgH12b0cCD+YFb6JZl8+puJEbBuHbShVq7S60C2MyTXYZgS+2S/OOVj9VllH6P+MCBjW2jkoY+G7HFFTW0H7B+PI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(10070799003)(376014)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SW++5+GQibX8/hTQCqrQ7+RihvzrIXtG1/+fTffVl6Y8eplLap066DptBA?=
 =?iso-8859-1?Q?UdkOFFXbAAUn6VZ6V7Xnh6FzVjjVizu3j8SxCyWjlB6cyetFbdk72VHO9k?=
 =?iso-8859-1?Q?/DFLWDQ7A2tM1R2Uj5d+7zKtteR1UHK4y/X5ce1RcwKOwV6XhfQJLv8MRJ?=
 =?iso-8859-1?Q?zCnaEQKZcbLP6p1TakZFGm8uEzZq9bqGIktDUDW8sjNGcWxJTGMT5jmzeM?=
 =?iso-8859-1?Q?scYQg6BRkjcid2H/CRrqRv7PS2HOYQ4s7IvPff1joO/cMf+FA66HoxG8ds?=
 =?iso-8859-1?Q?l6D8KU1oMf9+PN6m2SROny/s7sTy3sErVYhwL6UYwcZBr5GlOi2WUOOqRN?=
 =?iso-8859-1?Q?sNOq6uFxudTVjesOmKfJSbb6Gn3wlG2LMXvxGnQ7DcvV6Mi6ETi5QHzeEx?=
 =?iso-8859-1?Q?BaVPTyjodCfyIPfQ7qVMqMR7g33699VaS+YnJ25JVbc7eCKEEDwAxPDEg/?=
 =?iso-8859-1?Q?bPe9rYsifdaK/+SrD+xKb5Gll3Cj+oIvwB2lMsHnqVGkVk84R+S4ZWclNX?=
 =?iso-8859-1?Q?qpF93fkLpfXHQ9XAWnHtlAhCE58hnNrdNI2xYIh6jua+d8X1CJb7uKd+k8?=
 =?iso-8859-1?Q?AQqoSxpHKpMQ7dyDwrCI3ERN0tiIJNN0CoPVFyarnHk/y+5qjvC+f7xB+b?=
 =?iso-8859-1?Q?O42urTHCnJv4fmQA26g198OIVUlCXYGOehF1Bu1yqcq7lenKkrJzBK61hr?=
 =?iso-8859-1?Q?EQ81jFN95IsmDaxFR1F9BYdjhtoCm1nIr1EyryOPKAOpEW54aqaoqKnoVq?=
 =?iso-8859-1?Q?GvzxuYpH2oEJH94qsR751qRLVNyTFLeqIOpF5R5gOOgyX9487SJMFIMbkO?=
 =?iso-8859-1?Q?wXI2tPS+vHkCa21dv/6+1QXonAwDffB5t/oxORjpntzdq6r2D1L44N7Q1O?=
 =?iso-8859-1?Q?s2Fk2daYiio2t6RwMZPqgYHR0+cug9mAzaps3RL4cdj5rsli1nTrwzaBKp?=
 =?iso-8859-1?Q?s5R/tFtnKn5+v6CcsZv99+Mh71XlT57Chc52zuu3YdpX3PR+B8JX8eerzA?=
 =?iso-8859-1?Q?UT/5NbicuDDW7yZku12V3B/4oyMKDce5K8JG8pkcy/bd7+UNR7X7y7aifP?=
 =?iso-8859-1?Q?/Sq8jtn/Q9+ZIy6eTnI6Y14A4Hrl6BgZ9PqcNzK/0wER5TV/d/9z0LYP+l?=
 =?iso-8859-1?Q?NxGxH1V7VarG0D+nB9Lv3YYqv3Pi8ZYFaOqeMTlxQydrC+HAF26t7VwAIW?=
 =?iso-8859-1?Q?41Zgzl8/X7y75ZrEktALK5r0aWTqRlf2Gpvh5QPoi6f91LCLl55CKK4yCQ?=
 =?iso-8859-1?Q?r8RbIIGxcWbloiiE+KRlhkyUbsIunnN123AKLmqxebfibp+IYvbPddVTG0?=
 =?iso-8859-1?Q?pCsh1aCp+qTGjVX4KMSb77pGbQIUm0xj63i/Ygurpw/qiQQfuqr2GuLwQq?=
 =?iso-8859-1?Q?KaA83Yvf5rzbV+QHlY0uhKin+/Wb4RxWBrnrnbTlxShiRiYJyMsfYKd4M2?=
 =?iso-8859-1?Q?TqU/2TV5cXIXrtr8+90QiIakdQU4rKVh9OVK2FMbuMANGNYWND+aXgGCe7?=
 =?iso-8859-1?Q?gDOf7BafCOD70mu1M/DeDQNPs/tUnMw9IvuVCCuZug7F/PItfkihHQsuCP?=
 =?iso-8859-1?Q?w4/LjJYybjiYJ2L3V1U/88Mq4nNrM8Bj6MKmkRmkc1X5Ac1BvRa4vB/oXw?=
 =?iso-8859-1?Q?9VOCmLluNOPdTt5A41ehADnAXsnBdf5l+5Nwh34v+xlu8iaLoaVflJ4u2q?=
 =?iso-8859-1?Q?kAzN+6jpd7XNDG9Fi7VvUOmAfit0/b11mGeTPwFwtEaeiDjlY5teH14l8+?=
 =?iso-8859-1?Q?shT+HvbqCIWPTjIgw/1kY7xTdUD6gQV9WvIYaYeIaTOrNmzTrJvJDftmS0?=
 =?iso-8859-1?Q?AAqbOLzVSHO4yKHy+1fm6a1T7D2jvOSChLtxiMngjKv3XQO0JgrHq2rgGw?=
 =?iso-8859-1?Q?Dc?=
X-MS-Exchange-AntiSpam-MessageData-1: qjQDc5wtr1T9Nt03DNZiZ0ohPAutBhqmX5M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0602c8a-4d84-4a04-f4cd-08df293e4ac8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:26:03.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8Uvc/6oKiBan0BsA3DpaxuNXKSSHKM1g69QnGqHsJQjAT/vmsxJf50pjFoHOnus+AC2s6PhduGJfnfnPEFSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10204

On Wed, Sep 30, 2026 at 06:19:04AM +0200, Marek Vasut wrote:
> Are those clock which feed MDC clock available via clock framework on LS ?
> If so, we could calculate the divider based on those clock.

Yes.

On LS1028A, the ENETC clock selection is made by a mux called HWA_CGA_M4_CLK_SEL
(Hardware Accelerator Block Cluster Group A Mux 4 Clock Select).

You can describe that in ls1028a.dtsi like this (note that in the RM,
the mux numbering is one-based, while in the device tree it is 0-based,
so 3 is actually "MUX 4"):

 			enetc_mdio_pf3: mdio@0,3 {
 				compatible = "pci1957,ee01", "fsl,enetc-mdio";
 				reg = <0x000300 0 0 0 0>;
+				clocks = <&clockgen QORIQ_CLK_HWACCEL 3>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};

Upon clk_get_rate(), the qoriq clockgen driver will use the device tree
definition to index the hwaccel[] array and find the ls1028a_hwa4 structure.
This defines what values the HWA4CSR register can legally take, and what
each means. It will read HWA4CSR[HWACLKSEL] as 0011 (meaning Cluster PLL2
divide-by-3). Then to calculate this clock rate, it knows it must read
CGA_PLL2 and to divide by PLL_DIV3 (1200 / 3 = 400 MHz).

Note the ENETC PTP device already has this property defined (which is
OK, all ENETC devices share the same clock).

Without a 'clocks' and/or 'clock-frequency' property, we have to figure
out a default that works for everyone, or if that fails.

For example, with 400 MHz enet_clk on LS1028A, the original
MDIO_CFG_CLKDIV value of 258 used to produce an MDC frequency of
400000000÷((258×2)+1)=773 KHz.

Your new MDIO_CFG_CLKDIV value of 66 produces 400000000÷((66)+1)=3 MHz,
which is too high to be a default value. So from LS perspective, this
patch needs to be reverted.

Generally it is assumed that low MDIO clock frequencies are not a
problem. Otherwise, drivers/net/mdio/mdio-bitbang.c could never work.
It seems TJA1120 is the odd one for requiring a maximum MDC clock
period of 1000 ns.

Please use xgmac_mdio_set_mdc_freq() as model, since it exists to
solve a very similar issue as you are trying to do.
