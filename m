Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F14779A3;
	Fri, 11 Sep 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146834; cv=fail; b=X148KfMV77NwHM5oeRWWrd6Y8Q/IzOIxyQkknsImqc6VGTqavFMsRsKEk6oKZd4ik35B16zPTM6/SaU62Fhkjz6n/PebCJb9v6jbARaWiH7ME90VZwDg7tOorBt2wW2x9655NvBcZGoDgD17pwBAqLYKAwgr6AyeGi4NA2toRUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146834; c=relaxed/simple;
	bh=jHsDZrXzg4fsfEOddmnR0VlKMROGxQ7yteTE1ti3nn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SEzjq3MSKQLWkOu7BJqrnz9KdOAStbiGn1N18VAX33JDn16qUT+pRToJ/c780zjpLE0Rx+B+wfuGEbWP8v9CB8syHJGV8qRY/adnzHAq6M/AVP8I7tpLVpgDXZCVsWUDqW4N8NigbhgM49AFr4PRR8JbFGhOvIPrcaR7uYydWLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lCCNgiDB; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lCCNgiDB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2IiIUYPhw/PtgyD9fyABbfrKmvYWynVSmMb+VypVTffsz70qmFO3luzcSGkdSkNgBJwcEd0wSJzreeWkuP+oXO7fEvMOAFjRp66r7/kiy7x3ht6wabZ8z+em6mwg8o69T7ogKxzsXfzWDc+pnmW88wA1uPTJlTLdIO08p/WfHSIvyVEM/FEIy2OJMoeCiGfs36nlyimzexuqVNqM/bOfj+eBnCEv3fpua1zxT4lri4YyiINxDGUoVnipSVTpTFacw1gy0nkTjJb1Rdwdcy3M8PfVdAdA3ZGW8yuwNlRTb4vGZESPfXfMoTzzBeeIT3m9y+5ATmK0Mo9802ZJ3a0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC+QsT3SsbvW0eDe4tpTCTH7S+rJJd9Y03UcCDDUw8s=;
 b=dG6jt5ii7yZkA8fOP+txlr2K23fQr9ZkANLaIWKJXVcRBVGiCKAT7doXPgV+IvriqItCLc/F17r8/ST6e3X8M7WNzXXFdte4E8kxiqNz9J8SZBTclHUKJ+RwLURF3Wf9Pc1EfY2NghOD51msXxQKM8q9Y7lmH+2enC6tmCHSd97VnCRF0jJ3dsjqKF0L7c3m2f3yn3KAaQv2e/j059ytBam7J3rzoM1xSY0LNF6JvfZkOnJqgaXyf1HZ3KBHdwqDO3B7xtk5TkGxylxbYFq74shpnyXjAXKhKRe0UugyUOEl7VqIauLmg+/7IWAbJcF8X0bJfnK+CBdXm8Zl4paSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC+QsT3SsbvW0eDe4tpTCTH7S+rJJd9Y03UcCDDUw8s=;
 b=lCCNgiDBB3SCZDH7ayiiFfFt+qAH9hVHjlxktdE+XNL/HEM1XC8uWV3fskXrSlnakSEVmHqiVCeeZpXcYgusFWhPkjDwLiMk6Bp3F0qdEMIB3WAIvgEeGQGMvE65jd5Clck/fSBturFFD4f59SHBT3Aog8XNiG72r9x6/MI5PPYUC5NHJtflGZzkAGmjPbKGXxa/K/yrLr/2Rze2+nqD1/GvibncHulMQ9WyjDK+TkDSk283YuOblC0XLc6uqzXBBP5+esFOzd9ld7OwhFTL7/CPtq8aWOQx2IhpDtjBr/87COOYYSTZtMeswEeazcqw8hIcTJSVNywQz1FtR0t2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10126.eurprd04.prod.outlook.com (2603:10a6:150:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:13:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:13:49 +0000
Date: Fri, 11 Sep 2026 13:13:40 -0400
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
Subject: Re: [PATCH v2 2/3] usb: misc: Use %pe to print error pointers
Message-ID: <aqQ2xOWaHllbEyJ3@lizhi-Precision-Tower-5810>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
 <20260801-usb-ptr_err_patchset-v2-2-1698e298c1e3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-2-1698e298c1e3@gmail.com>
X-ClientProxiedBy: CY8P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10126:EE_
X-MS-Office365-Filtering-Correlation-Id: 732468d4-368d-47aa-cd28-08df10280b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	yTenbfG0ILwVBtIPzl6UQSSbQ7XbcxmczxrnPIF/qn6XySpJcuqDYDEfzu2uLgoNXzaUKbuIWxPoabbXVl9IgDeuRFVYgdKh6v0ldRT7cfL7xA9h4z9FPWynYURSixV3q80/qHcEep8PmbNLz1PbUe8fw9l+2EmoA5FlDG6lAwbrvsKYCBfWwTY70v/+KYB9/4fs5Y1x7VLrGTk5hEjPNqvg2nlNSmjCrvmTQMuP9BhqdU3O7ZLwKPYxgFHbguh6E/NHGabqs0khuYLN4iuH2N1WmFB/AFYd/vWEjCmLk7pSfDFG4xFXYAWp9sqwIUeaKQSuoZzO8etSx7vE4dbqACF4D/t3WjjK/SefCiRZltziagP6Vrib+FeOErypZIqZxNXq9RTd3mgn/WiKxuObNyKk0wQ30xYemO0w8WFwJop60SdVQRGliyj7KLNeJJop/tFk6OYmFjBw6XknhJzQxYKTwH2/7xoHgmMX4rS62r1d3DLI0dMXBazjASP9RDkGQcUn7YW7gj+PPvFKWvWyGsd0LWXba32UblcCLSV/aNXF3Om2Ajqvfci+R3BRfhVq4UTYXgaHFaPQZJXgxc3TUt1RTHAa/NRC3J/QYP8qnjOKo5KtNEOCGy9ZaGnUErATm0XxcfifOL8/iIhfidZ79uzHXDvxo3Xgi6+54oOjPr2awaxFb8+0AzXvdmOM+h0cm5ultthyQJqvOAHMbBW/Z7lm//0IBzAtgeDphg7fHcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KT6Zqjmqi6quMUGmtXIWv1orH3SuaM8CzpfHWNbtvuA75tWKkaFh1zDyWNO?=
 =?us-ascii?Q?HNkWfUoY1pUpzByWSgL7Z41arKnSXkKnYpNjVPDA57lYxRMvQAcNkbdtudKT?=
 =?us-ascii?Q?N3mjL4nAOsVs5V4l/fAfo75sgdyyWXoygfrovjjxWkvsxA/mKfPDo+dkMAnH?=
 =?us-ascii?Q?7Mv5eyOL0EksBY33EhyQtTyi42uTj5rx2x3iLNNP6VXNlx3RoVHiieWkXyuC?=
 =?us-ascii?Q?pFjW/oXWeT6wnJFq0ggZOiq/3vidvbUBQ2is52UvXaQjaMIKZOXIPw2luuzi?=
 =?us-ascii?Q?Px3LbO6ZcnXcNIWAiVPS+aoowTT/Ew6IxYWZ0JrGF5IqbgKrfsqw8JQQZR7v?=
 =?us-ascii?Q?jbBd4t7yX+wBepNLdV2rcX5Sm/QheQcsj1CJGuO8M2QjiRQ2TW2MkLQG/OtS?=
 =?us-ascii?Q?JswVUYZPUaVhkLIpFqazsoorBPNQzsY5gqLIsWMBsy7op7OrMRq0BhfH9kNq?=
 =?us-ascii?Q?RG+kVFfBY/UyGYWN+BlyIWTw+RHxB27MvtS2H3WUyIAOg/9PQkOPsaIppeQt?=
 =?us-ascii?Q?Ubyc7WDLa7pTYV0qnc/aLqN2Ly63vIj/UIVJzL4+OwZkGWPlVp6PYgAP9BP7?=
 =?us-ascii?Q?UHvsZcaHr7SazcSDml6eR7dJuP0y4T0l9RQ6tYAJujTMMELWlbOQ9s30Q7Xr?=
 =?us-ascii?Q?IuOnV4ryegS5+UiOZ0iZekBmxn4DxN94ogipd9P0Ee/gvDm5aAvBJbI5qwR+?=
 =?us-ascii?Q?6MY7r4SIR5jFpfHBJMgISmYW57xjp5ff5RBF4wGwkhMXiYxCM7zBH6+npFdh?=
 =?us-ascii?Q?/dH+vsbY7wFVad7ZoBcBbMa0fDRNsCUlZgVs/eji3qV4PYuYNXaUWmzj20DW?=
 =?us-ascii?Q?3HQICegJKEg7CemEK1TqCc7d8HYB7WyOQM/xrL9IDbW9BJGItji7DDGykCIO?=
 =?us-ascii?Q?oFDYocSo9N1VJ1QFwRI20TdgW1mIZuHdkHtVGo7+ZUKm1xW5xJCHKFHKsJL2?=
 =?us-ascii?Q?lGD+TzzZ5xDNQedD3d3vbEylBdohM+GWUDach+GX93WU0vPaEd+GdyeIm/JN?=
 =?us-ascii?Q?OYveqI/ODhGRzBDNSHN0UJJbGSiPDGbynorIJaOePgBa9NT6bY3hKZTbjs5B?=
 =?us-ascii?Q?mriqvGiFNcVwMt0NW+QWEDtaAWA7g2+rGjsn0gu3w0Juu6q5jKkLEQouuGzF?=
 =?us-ascii?Q?M2+9aTOcYhl6lG6qEl7ojkZNqJHvkATJzojjClKqfgg4Euv5rhUMLW3XpmC3?=
 =?us-ascii?Q?v6ZvmZZl5Xxmay9dlNqF7VfBiJS6q862SAyuudqMjt/RnnCYFYoOPnsqBFtj?=
 =?us-ascii?Q?NwcN6fM4qNrOl6jVtASk2AFI2UABQlClipVpgWhpo3NRBOjv5EKR/VCJupBc?=
 =?us-ascii?Q?mO3OwDOtyGi2ZDxo5hMjoezzYytJFNoBRj7RgbljWolTFql5umGKDeblFJnd?=
 =?us-ascii?Q?anIqv8zvMlWA0iSasQog7jL9XY/7QfWbOn7RuGZV16NJ+3ircD4E9Ba3d7TE?=
 =?us-ascii?Q?pbjSukXxf6u2ZxvMJ5ZO1HMDlbmu/XuqKxxn2rJNJ26Fbb7dWzrKYi3c37eQ?=
 =?us-ascii?Q?73S46YzsyzASdxDkrrTSnPWDUV6vDViztOb2xHroyY9mXUa1HzyxKQPVg4bP?=
 =?us-ascii?Q?j+K+G9xfJmEG1PkAYnyHu+MQo9UbvQsH0pz2RT/SjAZFW2FfA7d6wtP7LJzL?=
 =?us-ascii?Q?dz5u4zgGPhli0OYaRhnFXCxDWmUOdowem1zUCQqrZktnmnwQVDO3DE34o0wu?=
 =?us-ascii?Q?wNhR/vzbLk8GGXBwqZl4/iYiCPhykZb+UlLkbprtpFSGajfWLvDtc1NFbARO?=
 =?us-ascii?Q?gA/aOYfCXzP8Xfy585z/lwTtUw/14Q5LRllCi91F7wZFG2sm6Olz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732468d4-368d-47aa-cd28-08df10280b92
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:13:49.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8vnIqyY2lr6sJ5xDmhtDyQavw/dXbWJ+y/T6Vr9/6Q27UC86j1lxnjAmKAI3M2kkzPuxbxAP9e2r60MWY0gVDax5WBcPH0tvRI0YHmr5+OY6gS8Ig5HH731jgsGORiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10126

On Sat, Aug 01, 2026 at 05:59:51PM +0530, Subasri S wrote:
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in various drivers across usb subsystem.
> This prints symbolic error names (e.g.-ENOMEM) instead of
> errno numbers (e.g. -12), making error logs more readable.
>
> Fix coccinelle reported warnings:
> WARNING: Consider using %pe to print PTR_ERR()
>
> Compile tested only.
>
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/usb/atm/usbatm.c               | 4 ++--
>  drivers/usb/core/hub.c                 | 3 +--
>  drivers/usb/dwc2/pci.c                 | 3 +--
>  drivers/usb/gadget/function/u_serial.c | 4 ++--
>  drivers/usb/misc/usb3503.c             | 3 +--
>  5 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index 9600e1ec0993..c78caa1b57c9 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -979,8 +979,8 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
>  	t = kthread_create(usbatm_do_heavy_init, instance, "%s",
>  			instance->driver->driver_name);
>  	if (IS_ERR(t)) {
> -		usb_err(instance, "%s: failed to create kernel_thread (%ld)!\n",
> -				__func__, PTR_ERR(t));
> +		usb_err(instance, "%s: failed to create kernel_thread (%pe)!\n",
> +				__func__, t);
>  		return PTR_ERR(t);
>  	}
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 5262e11c12cd..8c750a93c350 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5671,8 +5671,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
>  			descr = usb_get_device_descriptor(udev);
>  			if (IS_ERR(descr)) {
>  				dev_dbg(&udev->dev,
> -						"can't read device descriptor %ld\n",
> -						PTR_ERR(descr));
> +						"can't read device descriptor %pe\n", descr);
>  			} else {
>  				if (descriptors_changed(udev, descr,
>  						udev->bos)) {
> diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
> index f3a1e4232a31..7ff9c4df941e 100644
> --- a/drivers/usb/dwc2/pci.c
> +++ b/drivers/usb/dwc2/pci.c
> @@ -68,8 +68,7 @@ static int dwc2_pci_probe(struct pci_dev *pci,
>
>  	phy = usb_phy_generic_register();
>  	if (IS_ERR(phy)) {
> -		dev_err(dev, "error registering generic PHY (%ld)\n",
> -			PTR_ERR(phy));
> +		dev_err(dev, "error registering generic PHY (%pe)\n", phy);
>  		return PTR_ERR(phy);
>  	}
>
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index cdd1dfc666c4..da31e5cea0a5 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1311,8 +1311,8 @@ int gserial_alloc_line_no_console(unsigned char *line_num)
>  	tty_dev = tty_port_register_device(&port->port,
>  			gs_tty_driver, port_num, NULL);
>  	if (IS_ERR(tty_dev)) {
> -		pr_err("%s: failed to register tty for port %d, err %ld\n",
> -				__func__, port_num, PTR_ERR(tty_dev));
> +		pr_err("%s: failed to register tty for port %d, err %pe\n",
> +				__func__, port_num, tty_dev);
>
>  		ret = PTR_ERR(tty_dev);
>  		mutex_lock(&ports[port_num].lock);
> diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
> index 759770a13260..1160dc594b1c 100644
> --- a/drivers/usb/misc/usb3503.c
> +++ b/drivers/usb/misc/usb3503.c
> @@ -202,8 +202,7 @@ static int usb3503_probe(struct usb3503 *hub)
>
>  		hub->clk = devm_clk_get_optional(dev, "refclk");
>  		if (IS_ERR(hub->clk)) {
> -			dev_err(dev, "unable to request refclk (%ld)\n",
> -					PTR_ERR(hub->clk));
> +			dev_err(dev, "unable to request refclk (%pe)\n", hub->clk);
>  			return PTR_ERR(hub->clk);
>  		}
>
>
> --
> 2.43.0
>
