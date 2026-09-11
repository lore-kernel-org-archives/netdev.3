Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56954A3D3F;
	Fri, 11 Sep 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146878; cv=fail; b=rtalhpsQADWgWFNrjfMVq1xyGFayt90bRWrhWbDJo4onbgjqxHkqqQ2rwc1bc7Y1Sf68qSnenBnKzHeyV/cYHG8nBJgt+OCt+HM5GZ39NqxSbRwbjARmaSd8xKE3nIowqnBSooP8NdoUu5EzK8aHjgsV9ujDeP3pw2os80a1JQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146878; c=relaxed/simple;
	bh=hU8NvvdhaJiQVRxYVxDK40M6EK8PFEBtoNTigrhA4Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZANLsLxObCnzpD+MYrfDojVZqVVquymzAjT5F+4wSGu0dZEjEbVR0+OXeaKSL0Om/yibp6+yKL6idq2GeFUhWsqAwmE0pupWK+nheyFaaSrOB68IK4Btjl4WXg3/J7maemhi0VT7BSpl3v1AwsplHik2jofuQukg7sM5j0fynU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nt2mlS5J; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nt2mlS5J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULgfwPie0tYt94E24HJJMN1pIpKD/ATQ9SqPfw+o60kYEEeHS5tLw0T3Wrq3U3vtNLOEoz+r18XeDaDdPcleQ/MlvNQvXGoi+Tpry1jEGdbq/Jp+cmHyJZiXao2DbyPogNye41+Zwp2MyGPdT/sx1dmET4f3KNtgbgxlYgm8fy/vAS0l8FjpWb4TYkBtJ8dnkbydyi6spvXhbDpkSNIknfyCWd0aL8yoT6ipxADVdbKW0FYR7eg6gzBJ5X3YwixT+O753wG/c3pJX6i7oe40VhfvdxL1D7Pwpw7ivNq/1evJdU6nRdLYIkWxP4cKCkppQSOed5p1/x2+C7pXIxOJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XecmXT69Z+ab0z5DBLgIaUEPgBa/z6RBS5UICHgPyU=;
 b=dFHWjyDYibWvVDh0s+0fptvfgLeJB6I9WJ1KCDiIty2baCTn/hXvSrtneJe2hKU1N6OccyeOdxrg5zmJ3EDN2PJQLzAsKACPm+EIvCrFn90npVHUOrDyxp5SWQVLLR688BQ9aCmRws4SAJLUcSQbyx1segjO0ZbhgN++FJCVY2tOSlq1CnZhODHflWLNWSpsVmYdKzdrvwYp8nBwltwkDBNKNJdI4Yl3dO/GUfaU8JTHrcK8Lup/+2jHUdLFYDa6/pXjfOuJZ1AwtSFj1gZ9S/Hq+t2YtZDHd8Xk/euEqk+ULle7ZvPGpTVU+frwb8/987wV088mM8+wIn06cdn7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XecmXT69Z+ab0z5DBLgIaUEPgBa/z6RBS5UICHgPyU=;
 b=nt2mlS5J+rFKSBEalqqf7nfp+yxlFlV6s8aDvV7Ymyhs/v9LK4fqZkLd+ESyULZlAdb9BNtfSXm4/v/onqcqXb4g45tS99P6G75/qivYFVn5upy4rrGaH/5mbifoVnxxcnxuiHTFvUNyMQK5PZtXxQfgINZRWVeWgPwx/LqPvA0AbAPExJC/oY8L7Vag0a+7TRpT6Ed35Jm2GMBP5rMbn6E1tpUSubVR0PpLbZ0r1z9smNbDYxzLmTB8Y5xgcsuao1qBxzsYTdyfMsDMyNCTMdx9onuL8PhAiWM04RYzq1evusITAdnMnGNIYIp5tVxJJwh6yJhRNhNR1/PK+cUNlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10126.eurprd04.prod.outlook.com (2603:10a6:150:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:14:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:14:24 +0000
Date: Fri, 11 Sep 2026 13:14:15 -0400
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
Subject: Re: [PATCH v2 3/3] usb: typec: Use %pe to print error pointers
Message-ID: <aqQ252-G4cMDw5Lv@lizhi-Precision-Tower-5810>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
 <20260801-usb-ptr_err_patchset-v2-3-1698e298c1e3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-3-1698e298c1e3@gmail.com>
X-ClientProxiedBy: CYZPR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:930:a0::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0a7fca-adec-4886-2809-08df102820d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	drvgM6sf+WJqX1CvZhk5eIHCUNgvkVv5WaYnPC6LP+Fy8UjKSpIzan7J7ysyNd/rWAKyXBDeQXqeTwQvWGfD1l9vRKy6Pxax530skrQ9u6qgvHgXcVp+eZg5ERgoHA3I+HEsV0mCmuvbzd088wIIhXIjBGtEpQbhCFhkNOYjNMhkWFmqe6blfCQl6hK5X6MiOMlxMUZKsWfsyuzVZSuvjw320boQmysOkPqBwwSMwssY8dGUjHxyaVlzzBssOBurgp5Rhs//o/A7459/ShcshCy0mQ09hzmDBvSnqDeKVL0uUtF7pSaF0txDlvEAcHerelJXpc1z7MJxxmzw9rHXyj/uxgW5I78a9EwvoeXs5AFovSSmdlkUG1byAQAsWWEYT3vej8Al1hlSgog5QVaT3CwzYwtOfA85OvL364NQpdMUQsDENjrqHUGrBE54l3PyOfX8oVrELUxaO/Q0XpRnoFhxcZ4S4xxMfswFp+RRaDXSYhs+bolRS6qWTH0InY+N7r6NMx054QzTh8WSo8HuevUAmXndpSvOkhRFqlvKumG6emImn9dG9Bznz5X+Ka8TEGiZk5l8PX33+mZ5lLwZKl2+/J7yDWwLLfXgsdbiCrf2SyoohNUve0vfoglwnQJVNrpCrfqOipkLFCUM37bObhK1toSCBvgd56egSw12C0DMvcEuhKrgonKnsbSFKEdJ1OsXqwo8Q1ZH1thT8r9C/1gkrPZFEi/f5ZlO0N8P1J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNGtdmMYxXrJIzDO/Aa3ENNQrZzMFR2JXy+5ZuG9NgR5w0m4lbzEedhNwjd/?=
 =?us-ascii?Q?tAZK1s+cnEpQIt3EK6xy+EI7ncNNV3oku8rKh0tuH+9iWuJirhhksIehAmd/?=
 =?us-ascii?Q?h1miGrWcnphxPrx61msoRh0LSKR1P6KpbMr1sUAKgsQN8EXv0ukaxMKmg7Dl?=
 =?us-ascii?Q?2+Ie/EWICoSXzodZ/8QNZyZheFX3PM2EE49Y51w0mu+z5URbskRNJ3443lDb?=
 =?us-ascii?Q?X648iG+RX1gE56oIESQ40rGQwuAHMcWgKN6N3gwzGfW3e8Ra8a3XjmduWdOr?=
 =?us-ascii?Q?ZnqmM3F81aEDLqfMLwKXV43DLlwvPhlc1UwnR8/0zv1soa8+V1gASaSm1rBN?=
 =?us-ascii?Q?FasJbKuDKulEFFvpbJg7mTwMRekE0NJxaQOPo6L3nZr2cMcJJKLHVk/22q5o?=
 =?us-ascii?Q?lznfgYhTGJcpRbrQAjnZAm1OqNWKQaA6bbfRi/x0eYs1Pslo5fcHC8eh0otT?=
 =?us-ascii?Q?nQehsmjn5S7VDg2zBSmgCMkRwYIEtn4npOZE22VJmYLl+nTyXeNewf20evuk?=
 =?us-ascii?Q?bC9so/PahDM+8e6q6UyAw13FCdWs9UHKpaJE2ZvMW0Xohh9y6yu9LkNQ8yjT?=
 =?us-ascii?Q?Zl4LZ7JhvtMwW/Hyw8nVgHQY0BHcEGB4rDJNgTOvH2iwfUJ5SSQbg3vcV1I3?=
 =?us-ascii?Q?FNVb8s7gdzBSDWqYkJGkBDYrXLXdk9roAKCEtrWJDW6QWknLDc5vupnK1A0v?=
 =?us-ascii?Q?C2UxA6AvdF/wLgksHtf7kaSj6Z//oDCyOZpGomyCcN6uznjRzAjCNaN+z3pk?=
 =?us-ascii?Q?9WIWR1XPa92mY9RaVLTt6BaNlxVxeTuxw/hexlGehUw5lTuvUaxa3auJtaYd?=
 =?us-ascii?Q?UODQjYjKjiQooMuiskTqOyC9jLERRed+zqXgj8Glyzz04xw32h+KKQeUN8B/?=
 =?us-ascii?Q?Obg2Me3+AGLTQOWpEua+xioPxsRRUgoU01ZXKmQW8rPoMgHJjCTZeQxvmfPU?=
 =?us-ascii?Q?mncXXIbIbuc0KL9RwQzwP+KF2fE9KJPuAko/pMstT9ZcsLjsVp1l6uY71nAu?=
 =?us-ascii?Q?PDwK6nDgYM5ZncckZpV9GprPHoaFHiI6lbFQxUuSO0P+I1w9SYh6aFwEvi+u?=
 =?us-ascii?Q?sjzJrR4mcVLhKukgoAXiJvJnujL4rYQkek8qJeKaVNa7DUVuZRHUjgy1hThc?=
 =?us-ascii?Q?sP2dgB3MX7qzbu4jTZ/KjsYQkUZT7Av/MEZZpaZJnQUZ2jDrSz8v863jrIS7?=
 =?us-ascii?Q?VDi8reP/C+/CNVIXPAvo5f1Agz1/4UTIGuTSd+Kg7+Rkm4MVYS+t5UZPU/0f?=
 =?us-ascii?Q?jOVQpzUXgUfVqix1XaWk27qGuupW7vpz2BX6XQepG819wiOQcM/tSWQMTWY3?=
 =?us-ascii?Q?bNU/Ucc4ZQoRI0BkGJ95fr5sUWGZuGjoK2bYvzmlcamjhR0sDlH03FSHpqXl?=
 =?us-ascii?Q?rrFXhv4oHTq83bQhTszOZ1IYyc/nVKoRUFdvkPD9AlzZSeSHyGUAvuu2EOLn?=
 =?us-ascii?Q?Rim8CUljqJp4jEbxKd5sSE8FK3b292Ab9SZVFhTQoUCMkLfafiKwN2PGWWlb?=
 =?us-ascii?Q?0hqxbcPz066xpwphtQSR5j0E8MfEHUeraIvhxRRUTefQO32+XWSBDACSTYV2?=
 =?us-ascii?Q?/H5/4BXWt7VqqNNwacx5xt2kKZiNNjvfOoRFple5iNWaXimTt7wu2al1m4zt?=
 =?us-ascii?Q?SjESrNPPz9IRwtPToXSVG7B72347wXqXfEdQVZIqS9V7axZp7+jB+/DTvqUb?=
 =?us-ascii?Q?Y6/+ymKjOLu8DCSGDOWYJM1LImKAlMUlv+R5otnLLqBGej/fZsx/q3RKH1Nt?=
 =?us-ascii?Q?aGPnoH4tJiQ43fuZyHsrR1chP+lARSjQUcGSTw3T6pyL1yKxZncD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0a7fca-adec-4886-2809-08df102820d5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:14:24.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue4FBGV2dyRBwPPZoRFXYzXMfdtKwIPPthUMRgBU7Ro/IFrR4Lp6Ezqe4vMZw2ic/rv7vE47ax5yK3pzS5Aig3HwCEOs5X8z6Q5QhJDWx09pog4fizWjhgVTBYgiKxFZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10126

On Sat, Aug 01, 2026 at 05:59:52PM +0530, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in various typec drivers. This prints symbolic
> error names (e.g.-ENOMEM) instead of errno numbers (e.g. -12),
> making error logs more readable.
>
> Fix coccinelle reported warning:
> WARNING: Consider using %pe to print PTR_ERR()
>
> Compile tested only.
>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/usb/typec/mux/pi3usb30532.c | 6 ++----
>  drivers/usb/typec/tcpm/tcpm.c       | 2 +-
>  drivers/usb/typec/wusb3801.c        | 4 ++--
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
> index 985683fe49e9..b32f4c433de9 100644
> --- a/drivers/usb/typec/mux/pi3usb30532.c
> +++ b/drivers/usb/typec/mux/pi3usb30532.c
> @@ -139,8 +139,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
>
>  	pi->sw = typec_switch_register(dev, &sw_desc);
>  	if (IS_ERR(pi->sw)) {
> -		dev_err(dev, "Error registering typec switch: %ld\n",
> -			PTR_ERR(pi->sw));
> +		dev_err(dev, "Error registering typec switch: %pe\n", pi->sw);
>  		return PTR_ERR(pi->sw);
>  	}
>
> @@ -151,8 +150,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
>  	pi->mux = typec_mux_register(dev, &mux_desc);
>  	if (IS_ERR(pi->mux)) {
>  		typec_switch_unregister(pi->sw);
> -		dev_err(dev, "Error registering typec mux: %ld\n",
> -			PTR_ERR(pi->mux));
> +		dev_err(dev, "Error registering typec mux: %pe\n", pi->mux);
>  		return PTR_ERR(pi->mux);
>  	}
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 89eec20a2064..ad10470ea73b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4796,7 +4796,7 @@ static void tcpm_typec_connect(struct tcpm_port *port)
>  			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
>  		partner = typec_register_partner(port->typec_port, &port->partner_desc);
>  		if (IS_ERR(partner)) {
> -			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
> +			dev_err(port->dev, "Failed to register partner (%pe)\n", partner);
>  			return;
>  		}
>
> diff --git a/drivers/usb/typec/wusb3801.c b/drivers/usb/typec/wusb3801.c
> index 6062875fb04a..86d13ab41670 100644
> --- a/drivers/usb/typec/wusb3801.c
> +++ b/drivers/usb/typec/wusb3801.c
> @@ -277,8 +277,8 @@ static void wusb3801_hw_update(struct wusb3801 *wusb3801)
>  		if (partner_type != WUSB3801_STAT_PARTNER_STANDBY) {
>  			wusb3801->partner = typec_register_partner(port, &desc);
>  			if (IS_ERR(wusb3801->partner))
> -				dev_err(dev, "Failed to register partner: %ld\n",
> -					PTR_ERR(wusb3801->partner));
> +				dev_err(dev, "Failed to register partner: %pe\n",
> +					wusb3801->partner);
>  		}
>
>  		data_role = pwr_role == TYPEC_SOURCE ? TYPEC_HOST : TYPEC_DEVICE;
>
> --
> 2.43.0
>
