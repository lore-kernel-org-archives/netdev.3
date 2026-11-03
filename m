Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702699;
	b=zxbfmKjpfmw1TfspP0gKYYwWLIq70B3nEutN9CJPQUoX12ftEmQgT3jCFgw+v57T1ny1
	 qk0qwuLv4Lsx7hBPhrM3xBKPEp9dT0D2rr6BxQqrXRQPTyxk0Kb4l1zr2Ox4sX1/WmOpR
	 JqGZln/K8lyrQo0uGzhqSJVIy7ziAaa7gvQIEjX+5KtSpm3bJuoY3aHlHodndGIkF6og1
	 v7rb4JWHau3rmQXGRa5FalVBA0KB6ODN3QYkU5j3eK9teDkTY4zHcRov3WA1VyIUDGuPy
	 juEE70AycJt/P6YibCAMSyi+PxD/Fvt4jzKG9BnnjT0j3nU13WxbYan8RR5Del0AJCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702699;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NTtjEqR2V65fDv9trZGNYOX930zyDPC9QF8SaJjXETQ=;
	b=iOQZo+KNl7Smp8SktANGVpWMXa/v4FYcxYUK4KivmMsZZ855x7n3ajy53jGwOUaGjxbK
	 Fy3RDAjkYkuj/QiC1erpXUC5UE9O1ci9Ze85Ixr04OwjHAQgod4No/3i+C8XmFCild4hO
	 NFkl2JSNi07rxg/hNKMQhZjc4Z2cM8kcJegdzSmYNT0/DijmVMG3y10YTqt24LLA6Rmut
	 wuHf65dmjub/25VYef1YW0CTpKw2hbqCOUTFeXo7cN3KfAzDsljrteA0t1QD56xMq+s6A
	 fiI8vU1nyYMT2WDPUQQEmURzy4Zmw6/6U5xAuoPQ0+LarF9YeLKjR7ELgVScv0QjTyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iOcRoqSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC2606BF9D;
	Tue,  3 Nov 2026 10:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAC2606BF9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iOcRoqSL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD3t4nC0CeD0H9S+bLmnYyNQCeSDjCoj9XQEDeRG8jQvCTWDWtfy3dNA4MleBy/F8T46YsoOE+5FEaKUlH39s+7qkqonEf5qYNHFvPEcW0vWbEtwb6icFL6/HazWEEPxnWodg4yzTMGIoKuhORnLkDCSTGK1lF2gx37J47geAkw5rVjBYTjoTE65hU3DHHZkZR20tczd6/QNAYai4dZtyHY2g6kz6o3UK+0QD8lXDKVJlNQ4psZtgNyreyELCkgALvKoxGaU1welLTlx2dzVd7tHIVXHKehL8EIZyQVxpIrR3esHnadkhZ8P3PqhNHdMvDCHG0aewgFFuil1ZYfkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTtjEqR2V65fDv9trZGNYOX930zyDPC9QF8SaJjXETQ=;
 b=F1WS0CdlAwOwxk2WiWLWMNluc6Iex4o4vGjjOZOPX2HBFGM6X6QUMYO/jHIqzFFxcxOji6LrtGJM4sJXc9vLqLr407+Bo79ELj227lOmHbD78Arz2d8K+0CjVCvqQhW894Gfq9xS/T5E0ga40u3iVL4MsauIsMXtsQdUP/1sWDE6svBvHKJ6OZ3xD0XSG/trfVlaKSSLxbdE/GbJxtJSUD8UEUaakIO/u9Dzy/eV75wYq+L3ZuTNZ6i2oIC9b0+fWJZOH6+4B02TAPM19S1zJEb3k6Y0dNQUYR1lMI3m6hP/VGK+SO1oHCY2N18dMllV4yCf6QRdDJq/W9TPNFaSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTtjEqR2V65fDv9trZGNYOX930zyDPC9QF8SaJjXETQ=;
 b=iOcRoqSLSFiMSQY9/zj0113OmGCxjyKpaUoKZnhzzlBy10QebyK5NAdZmVnxQgjH0zRjKSnzljrfC6iTTXCHiHx+5C79G1+/FJ/nwdj4udMY2zr57T6npx0HAWm3Sr5KxNR8CESHsLQS+LYJVYtSbeE0YerWCQXMqu6qCHKPEkE/mUExrdyuFfglUBqCdghe/Yjictw1ADJvee14HgnX9rmWmVYam5u74lPWHZFZ48CgQSbnkRf0CvptD3w4CzAXD4yhT05bON3J62oPg4tJxpB/2nsWDS5rk/xFaggsr8QQIZEbTnvHb7qm/wqBL+ZHSf2LiPG9tkLueIZJO/1Fbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:44:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Tue, 3 Nov 2026
 10:44:55 +0000
Date: Tue, 3 Nov 2026 12:44:45 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] ip6mr: Serialize multicast router socket ownership
Message-ID: <20261103104445.GA1107544@shredder>
References: <20261030042221.73996-1-kylebot@openai.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030042221.73996-1-kylebot@openai.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 126b7a45-df72-44a9-1f46-08df39977fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006|261022105027099003|261026121527099003|261022075727099003|261009223027099003|261026140227099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	Ow5v6asUe740BVg3Nnz+QCQcpO6P2FjO2oke5FdFuoeZBK3Hmmtc8jOTfp9/MKfC208Vs3zxakj9Rgf239UqWIjNHmCs3FceZdtcx80+4cmRAk+46aVIfKlOfBDJqz+kWQNhWW8gsV69gdVG5owXS/baRtK1m283+GZ/BWmIgqyDx2BeCIaa3CVNUusw7RdilpYMuSy7Xf+NBuxZhkRfL2y7dVgTepP6SlEbgZhIGPqbr40/iCbzh/0p0r1bwzz7mBQ2++zEiDguFsBBqZrdVDgesJib5w/hGCYSRIUa8Pe0fEBxQeRb5MJ3bMAgcChpUU0ivkDQ0bOcqdJz23nTzN2svY/ehhfIhPm9EZn5Zng5HlHhQrTcjE7aAW6vSWGtZWD/TlVSLiiWyDMRZLFFcGJDbWdJAC7dYwYMW0fajYpwoYeHpbD6r615iSyCAq/jPOgP9sINiNriVgZCGKjzLGIJ33NW+vDIEgtZ+gSYCKcXZWrjq20C3ovNnydCRrErddO09d1MgL6q5s2eTOFtp39Qv/EyhmXIZrDuGJ576pjUWX6J3QO/5HcxoXGhGMYS0b1cuwPWxky07wbnwulJYLMtrzeRKAHGvNOwYIYmUODraM3pb7e6cxZBVAyKOfmfbe1ei0W5tveYtWnDKcO7A0k4q1G2TPcTeGnl/uYAqwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261022075727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIJDXOzmXDGAIpNmSd2St0SEKuBQswEKlry6f9LzuMuZ4HrmqWzdJUp4uW7k?=
 =?us-ascii?Q?MMXsn2uehMayvb7K3yQMYfu+z7wj5AS+96DEtHNIVzWJ2qNo5LD5nPpJRnwm?=
 =?us-ascii?Q?eJvIRAqlyzC6B5gFOMK8hBYorpLp39H35caLivjhEMTMgdWHoraWDS0HCXoe?=
 =?us-ascii?Q?LnNpCYVCLDhOqHhKMxjOYz6fZncivoo0MT4btRCJ9Me4wzaHyZFPi81wKcUq?=
 =?us-ascii?Q?MKL5MVt+G86yqld99KiS0lS6mvE+2A6lNxbM4cb0XPE3tODDH6dKQHz+QVIZ?=
 =?us-ascii?Q?ndIM/gCu+9uEZ6e5uzCW+ig8zmk4RGspO/2Ob5zTL/z73ait4Z/Ac13CTAuM?=
 =?us-ascii?Q?7EXJb3nNrRBJZvpaP7QOmj8qFQX4TAelqFBPiAP3hlHA6te9eCRK1NHQqXmI?=
 =?us-ascii?Q?G+n1f4ZqoUj4U/Ed8Wd3OecfEfjWLWyS8UOz/cvfeBp1ExoBhfGCYopxW0uK?=
 =?us-ascii?Q?UgtgqojbhPNqPer1t8JqXkke7EZFsHQYwTdT28mOrExRcTzhJM62DM+jJym0?=
 =?us-ascii?Q?R8xQiTjHYLmRXNPIsnMqbHo8ia5yDKRaXL4Ki1JFLfg6WDyq7HgN5bYinGSp?=
 =?us-ascii?Q?QE+J1bzaVwQ/qezQDT3FfkuTWWkancYKMx6EYquANRDOib6tbf/HjTrU2ryi?=
 =?us-ascii?Q?fAyPj3PdPz+clF0eebnl83+OHv86m3WvWTczl8B5S2WbsTGue3C21Bb5pzjV?=
 =?us-ascii?Q?FdgtmfMJUfCr5yAQG4/MyfxeHdj5bAn1I2cKid/Oj6ecJ3K7dwbCRI/Z6Ms+?=
 =?us-ascii?Q?wFce8ag+jCe4kyp7kp1WLNr9mxRmYHNTfxxYqFOAt9VbbHspN68YumjOKp4A?=
 =?us-ascii?Q?9wDpBJoJE7eG07WOVeZFZr7zdhl7t5beG8vU5sttPsIAXcIGy9lWyk6WDNwp?=
 =?us-ascii?Q?ps0UFjOUEhnbkJK51CNDEYMdkiy9/k7xftz2xPsC30VP1leuLJY7tTjpxUiD?=
 =?us-ascii?Q?8Vsr0egJuLmQAGEN6D2avSOyool0gVR6otTl85ku7jtOMqtmY+4JLxVSm0dH?=
 =?us-ascii?Q?HmcHage+YMbRK1ebmJUW0RpFKk1JROBJec9lEYeuy+8DaAfTzZwih8OgsxJ0?=
 =?us-ascii?Q?mW6qztaYNPqPtFYS0NWi8waiFXH2TGBFfg8hWuOo18TlWkvNFwS5WAx9yz/f?=
 =?us-ascii?Q?uL1ToDjXuRsuwlozUkHLqQTHCf+782ILQVdd+fbBXlsWODpIYpvdakQbTZbh?=
 =?us-ascii?Q?x+8Nz3mS2m8rZNMVk9OrPFTUGC9wQ0NZMydtSP0QQr6ti+kJxLNLfAxF+T3+?=
 =?us-ascii?Q?Q4qbxcyeZHWxRqYjqoTIMjQ06SMJ67GTvjr8gmpFCo5jjuqwl96K/IIp9ZL6?=
 =?us-ascii?Q?uPj5qHG4dYuPDFLCYZqgXJsCpz0pHauD6tNC+0MJ0mJzDOSLr+vq1hKrFxwp?=
 =?us-ascii?Q?0PyxIMx+ct0VfUYXlTmiD+mqcl2hhS5SQngf2PM5jR6tKYik5dAaOHFoC6lg?=
 =?us-ascii?Q?Uwov6FNVuq2VFB5JYB8MIJ0CbOkKzgvbB7juP275hVwqtVem4sMQz6g4+6St?=
 =?us-ascii?Q?yMPm8+tmVnPuG6B3GZYVwKSZVJtEJicmV1N9y83gkQ7MlKkV2GjyxsBT0tua?=
 =?us-ascii?Q?WpcTeOHSPjvGI/7nC7PMqUfXRaCRYR/8W3x8n+ftp6YmFSOj0PiNLkojSIl7?=
 =?us-ascii?Q?3AhEKWggdb1+TsL27SpY8H3dotJJ5YU0xJHo0Vm0nxXOu+KBaI3KkVQOK6Of?=
 =?us-ascii?Q?C/Nn6ETCRxpsG9qda4qjXQ02L+U77PPEt1sKVJW6C+n7MYux?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126b7a45-df72-44a9-1f46-08df39977fbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:44:55.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZZ/1npI/3bt/OHnbuaJgNXXD8Tm+aXP5mAvlusbupnl8TmcKqGZtcK/ER3kx93mztBL3AVT3I49Wel4EUzxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

On Thu, Oct 29, 2026 at 09:22:21PM -0700, Kyle Zeng wrote:
> MRT6_TABLE checks whether the socket owns its current table before
> acquiring RTNL. MRT6_INIT also looks up its table before taking RTNL.
> Consequently, concurrent TABLE and INIT calls can initialize the old
> table and then change the socket's selected table. Another INIT can
> register the same socket in the new table.
> 
> rawv6_close() calls ip6mr_sk_done(), which clears only the first table
> owned by the socket. After the socket's RCU-delayed free, the other
> table retains a dangling mroute_sk pointer. A subsequent multicast cache
> report passes that pointer to sock_queue_rcv_skb_reason(). This produces
> a KASAN slab-use-after-free in sk_filter_trim_cap().
> 
> Look up the selected table in ip6mr_sk_init() after acquiring RTNL.
> Likewise, re-read the current table and check its owner under RTNL in
> MRT6_TABLE before updating the selection. This preserves the single-table
> ownership invariant shared with ip6mr_sk_done(), without changing the
> locking of the other multicast socket options.
> 
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
