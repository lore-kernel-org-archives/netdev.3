Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CB472061;
	Tue, 13 Oct 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897190; cv=fail; b=FaRvBmWhNW5rtOnC6dkcrC6OcLoDpnND9/vqhrGIXekdtbCwQbYZ+UgiOVOwRFCVZPswwqsoUwyBBeVemWRYKIu9+y+IF2QVyLE+/h/7NjpHr8IVU9t8kUVfTg3eT8o6oht2zagrc31Sx2Dsbi5nPn2liiKWRcaMikiVyITrIdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897190; c=relaxed/simple;
	bh=80bmWMDFxeDTSsisrh5PA9lyiMfNWC78WXOl8o+JqR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPU8I/ykaSD3xno+nPx5iSBCIeGy+c3cXybHNFXyhz5omCXk2WU7C1Zp49UCeph8GXLxK7sy7Tg3rx6cihWc15qlEgbaUuYrpg+0+zO5fCexejcqviNzlv95Ej7v02/r/Ww1C0SVNn6UZAr2VTjw5W3oLwNYWwPFpLdeWEm37cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nz07J13x reason="signature verification failed"; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nz07J13x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT+dDJQdBp/oxntypMcqrABw+kGxPBsV7XTRuAgQuk+XWheXPzIwl8lus9k+kwb3VUp+N4CRW3LbpieTk/q1sdkNRIivkFzs4j1JEw4EP+Cey8orrUzhcPmT66XUPtwUj1UGH23vNLNqyQFfwippeK/4IWZDikslY2DNbFyTa/ly+olHehvtgVUeH0qspbnwABTWf9vLHCKbg6dcnG6TfMgdgXsGd10iFy/O+QnZcs+4bUJTMbzDeTtcB4/694TJjEObUIEEJN22/9dFlnQ1ZyHE6ERDm4+lyCGzPN92hBq5XQULG60FHoYPG1IV7JPw1dgxiqOLszsoU0e1li2z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgXLXIIWk/fnKblgtHMMHjtqU0SauEiOB1W/14GBz7k=;
 b=X16f+x2joBLncPxjJ/NJ5aMwTRnYOt1Vv4ncjbqvYCIqBLZVJFVjn7HWZ4JX0fuPcHshXykfR0ZCrUbHkIObEBX203N51HqewMe1xJnPD5q5P1sdppR1k4C0qbJlGthZMcMPs7M981gE2c+o9/oNYTfh8wpPt95tKN2581fGc9le5xbnScjm8jxkynY6Osiv/R+JODhcZqGEW8E4qnWggU/eRZb/yJx4wl3pjJbtpHuN4Kvm94ctnRHeww4uXxE0dUgFZ7QmWbLOBryiq1g2ShWjrF9Ggkue9CZsGGdMWOIIEtCJHQ08PnTWiFcMA+meOBWNEX9hkD881AP/8Nigiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgXLXIIWk/fnKblgtHMMHjtqU0SauEiOB1W/14GBz7k=;
 b=Nz07J13xDyxRIxKMXVv0U3XGWZFveIzWt2gKJpoVU0oydW69L4ca4SGyk8+63j92qu4bdbJYHoi5RrJTHyFi8ywIAwB1o7trB1UXZpexOQIaqLa45PZksg27DKtOcbhgBMZ+vw5aRRFLLu1z0FnGMR628idrv7kgClnmuzmIa75okNzNr32R+nziNw46Dc+BVe6proZrz5liMhsTXra2x8dWhC2upRs3XyxQJen5PJP8xEgrm0V6MkJVuBM4Pvn3jOOjH0yAjaaXtk8clgTbuYOTUGQKh5l+wTNFMVaAJ052ZIlpqVfddvbYSGmShpxhLLAoaiqUstcignKsgkGFoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:12:59 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 13:12:59 +0000
Date: Tue, 13 Oct 2026 16:12:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Anirudh Virdi <avirdi@redhat.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, kees@kernel.org, horms@kernel.org,
	linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: qede: initialize extack in
 qede_flow_spec_to_rule()
Message-ID: <20261013131250.GA1038950@shredder>
References: <20261013105451.201211-1-avirdi@redhat.com>
 <9189f66d-7ce5-4f79-a55b-f73776c7c0bc@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9189f66d-7ce5-4f79-a55b-f73776c7c0bc@fiberby.net>
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: f5def238-5c59-43a4-17a3-08df292bb431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CjOVvWR0/QfmL1AZDUcs7B06BFoZwuVqyEw0bPn6Yz8fKoRdB+JckoZYUp3WpVu6mp6jIURwe+Jw9vwHcasHl0NshBS7VQIwwdOUw0eeqmaQ/AqifB0UIY0b4XsKSw7+j82AogqkAbBkGFyXsek8QW0kdoNYuKxHxcX4KBdfRqJm6O1V98M3CWYvkP8sia5s0Z1rHjOrz1nclOG8xHTFqQ1AjVe0qDZWY/u4Voc4Z0F+IX9bVefND6TTOS2PwRFtveFwi5oAdK9F3dzNgYD7zdNyXZErVaHZz0XlimGy9raxS+ArdoZRf5l6Jj2L8RVpM33gX/RhKK/TusXXztTtHGPRxdi2/rwV3tkxE9jg8EIHvbSNRf3KMxwyyYD/5m6pFvd2m6Lorq2ynPyILxrnT7SofsYDUcyOfy0LJqKYRWnONoVgeq1neQJyp/SN12CUkaS0CDuzv4qk7vCFOQqastXjO9/Nnxod1ZAey0tspXw10/MkXzBYNiYUA+zAapWo24uddmDCFlifBpXrlpYRk+jGAt64DboMaCpPQeocB01Ha6D3qtSQrScrZJPh/UCVK7Ywryoj77AkdIiFy7SmmMrrpDMaU1669kGG98W8m4oyrfu2Wu1DR4e6WH9Pns1Yy8REvrraL5yPbwvORmY1dK0tmEusADR4o8Jea0X2jus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?t0N+ODJuUbWVc9bc4vSlje5YoMwxu6HRGxkVrpw1ALel2K6YzqhlQDt1BG?=
 =?iso-8859-1?Q?q3gKnF0+PzpKd4zGEjQFdSZydqYMl9J3h0fw5IKcd/byA/iExmvMvalu/i?=
 =?iso-8859-1?Q?CLZZdi5qmMqDivf4svoJzWjvbTCj+gzS43/Q962ZX2+dBCBW6LZcHaNJ+l?=
 =?iso-8859-1?Q?nd4rcwWOjSjr4QuMS6bEs0aJJpJ0DGS3LSRrPQ1ofPIGnZ4EGpK89o1+xj?=
 =?iso-8859-1?Q?8ACnAmVykrbjlNo13J0S+NE3EixXw29EhqDo2o6EzDu+eKIDX+JmtIALmY?=
 =?iso-8859-1?Q?giwJxeJFidzLRH0OYFf3Uo77ekrV4IKl5qX5IMjads66UG9xMKd/Jrb+1A?=
 =?iso-8859-1?Q?8d/+DAqI3fAQY40dxPdRj1LTWuXX0lV6npIkuYufSCpfg5U5b/fxzYhgtH?=
 =?iso-8859-1?Q?/GDecTfw6u/8kLv918goDL74UIMwIh0d0uuee/QqQ8mTUsJw5FYbV51IyV?=
 =?iso-8859-1?Q?8jurvvyvgBIH+cwkN2DPw2Y2jl62PImIXm7O26KuV3B2eILXDjc1dsrpAL?=
 =?iso-8859-1?Q?ZUi0g3zDx+XFOB3UnnCRI/B8aOhJWFRVmVN6wnJ0Py5mfT96EJ5cRy92Mt?=
 =?iso-8859-1?Q?/8GS3d44eEEyUI7rNuXMXq7Cv2P3m9liehH8dGzMkxKbKTxdl/eTgw0VxM?=
 =?iso-8859-1?Q?kjMSJYd6ImLxN0FSD0//k8j/gg7BhI2i17tExvm+JM1LuhZ77fjn11kpG/?=
 =?iso-8859-1?Q?tHuvO7gF1xTs87Zs5xH3pCaamFB/WXDNFQad+unG68QfE1AqP3KxUiSibr?=
 =?iso-8859-1?Q?r86n52TaWPJISIkFanG5fJOKARninLpormvKzziVWYcU8HoEDrdhvdi/Mn?=
 =?iso-8859-1?Q?AycoyxY7KXQ/y9TqKQemWBDK/SErXCoP5FZNU6XOgr6JXpzhuz+Q2gmi8u?=
 =?iso-8859-1?Q?Z42FJ8KWt8+S2vqoNaKhpx2Snek5oQ3Gh6hMmcwyElE3JS/m4ciBQwWXtk?=
 =?iso-8859-1?Q?PpB/p3106c91LG0CN03Jd90T+/ClVZ+0WsksJaeHSge4alDGTvif1XnK4A?=
 =?iso-8859-1?Q?XV1T81bKA8WgavuqMCQ/UBhREeXortqrfdRvrGSenlFlMsrE/C2Tmxdo3G?=
 =?iso-8859-1?Q?QSPSjfTPPatl8Hun+djc+mRfbeCsckdrqVM3QeeU0hnRioWZzyfskwEZtQ?=
 =?iso-8859-1?Q?DCsC6xrBurHoKTiD6yEtGpWWHdjBk8NPUEvAFZ/CwtKW7W1LA9RCM4CGVM?=
 =?iso-8859-1?Q?kuhZ3sv1U48V9X6d5BEXIfg+hVWFFR5hXLS8a+lebVdZs8hH52StLMVWUW?=
 =?iso-8859-1?Q?maOB/sTgflaDePslWIaInoZYKn1dLVI76Pvb3I9bDPdujQsvpA7Wmxxu/K?=
 =?iso-8859-1?Q?vlEl9Hdbqlz5n0EGEdohrwzuXSL94iS7nXMpQ+3RjkRVWqVIMzzmU8QU2/?=
 =?iso-8859-1?Q?+Di74co+UhGFzVuG5JmP9+BJrLwkVvUS84RCV5pKDYyFU3JxCUqxcLKAY1?=
 =?iso-8859-1?Q?5BcKpKswuzccSdG4sVclEYV1wEufTqs2MNxNgjnjL+1ZKuc/7cj9cxe+gP?=
 =?iso-8859-1?Q?LaeR/ZCl4PtVF76Mdh5Jbrooq/4pGeGklbxkvVS/jV1n01ehi3/eOJQ5JM?=
 =?iso-8859-1?Q?s38kF8yjgypAx18X/1/XlluT7sRTVxmwLkAm9vvKDyh7HwvzD1VbHjd4yX?=
 =?iso-8859-1?Q?Vqq6gD8Zu5qCs6tNp+YDOvwla4hC2ZuIPBkpFLC7glTPiftcU+ZL3mQo0j?=
 =?iso-8859-1?Q?r5De/B2qGUhUsyV4vykn2v/DJzmCRS8FO5khAMx/ppJ0bQXdSTrhQW70qd?=
 =?iso-8859-1?Q?53NgMuyFK2X/tbvEguAkpKqr0Lus/aRmP9XKf+4ZxNC60E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5def238-5c59-43a4-17a3-08df292bb431
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:12:59.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiXeUfpQhfrKK3eNGJd33OhNWM7VENXN5YMDzK5fKPGUSbFut8XAXNPuxBbIPabP/LnZZy4U6bGGZNTYi2K7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Tue, Oct 13, 2026 at 12:50:50PM +0000, Asbjørn Sloth Tønnesen wrote:
> CC Vadim and Ido:
> As stated in the blamed commit message, my implementation was based on
> mlxsw_env_linecard_modules_power_mode_apply() by commit 06a0fc43bb10
> ("mlxsw: core_env: Add interfaces for line card initialization and
> de-initialization"), so likely that also needs to be fixed. I don't
> have the hardware to prove/test that it can be triggered.

Unlike qede_flow_spec_to_rule(),
mlxsw_env_linecard_modules_power_mode_apply() only prints extack on
error and mlxsw_env_set_module_power_mode_apply() sets the extack on all
the error paths.
