Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A753F0779;
	Mon, 27 Jul 2026 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151653; cv=fail; b=g5tT+64gKqlqo/iW2jpf/7y6suPNeykXCLZeRgp2mcSZgzyoyIFgYO3FIAwIL/HrldT8svMaQrhC4YNw6C/i7rJbTieEqu6GXCRYxCp8V/7IXZcBYTLvBtkfBBnEeOQByNQQqTvO4vzEc0fhsqGQnBl78NvtaYlF4evT4q1T6Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151653; c=relaxed/simple;
	bh=xWDEuIcdsoAmrBtQtbBcb4CD0t+CNtaw0mMFM2oWVic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwCUnbxsQanpJQJ64PSX/0uimTKmurLGmL2JMh73mFNr442CKpQveMa4Cm92+oILKvpStQyNs9q3fwpoajmGvO1PebmRRveppAWY9khRafPvgA0B2DM7PZlCBuc/U6jp86g+MXOhojmauH4d02u9R0e4wR9dvwjXkP8CLeUKIr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MG9gvPsm reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG9gvPsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMLN3TyyhaePHbe97H74clkwHKWEAZxmr3SWlNB3737pCWug0PU58g3R76Q3Hz2j8lIluUx5Z9PBcoaZbgojapsWvlqdKIUs4DebL5EQZEuBaT6fnp7wvnP57Oq/cB/lzMPeo+BMvz6CoQLvdhx7MDAm1IwQsphsSalTTWxmicSBQ3/zjDAZUo+PTu8QCey6vzIiRzc7+rzdSCsUvE5I3FPcBNL6/wAuTZVI40UOC7m0Gq8wQpCSG0khw8vpRVG6bYRMVri9M8rdsPUVEAYRbzSKkmYVW5jE2Mu6xsKq5Mj+TuUL3eENNyz3bDdjYu79YafIGv6mqmGVauNEFY0B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN1GnByO25ZMxG6wX8GI0lQCiDWYUvOfES/70gOx6ZE=;
 b=VnDTa9Pw8eFRzHUgDcC6a5rWyy5W/kxzArL0L6k/3cQpMiktufXdPpsmjvfB5L2rlS95udBMdiJH8hhzv8P2cysRGKGG/iu7PkngGnexLmpXDPAdnl8+spXniq/EZCy+MCKB3f4xfcapukzbuARFSnP8ksx7VZMrb4CLgS9ad1K5NAhjaN3Jkmw7qRvl5QZYJnoFRSqgDV2YwU9sNuGsoiL2y8bNVAo5tSehELeMsElk0gb5Y8Po6hdAMS5kruhAnWH3MrcIMihFs7w+vOHSASjlHcvFU/0ANkfJS96G9nM3QhBtqJWiMTLX37XFN+1dSa+JRfA8dk3LuemdjGMlYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN1GnByO25ZMxG6wX8GI0lQCiDWYUvOfES/70gOx6ZE=;
 b=MG9gvPsmAffXB5/u/nJ0v95U5IEeaKzxUie053LEMpwJWsbo6rxCoDH7PmYsEniu+oEfQSVITsl4NqNG0us7K7pytCIATo4lYaEfAgCzi6s2LlRAeNE3T3Jbd7cJNWV5RMGTDN1udDzlcPUPXJN9bSqru93gcXf5v8zMod6N3jWGaSDylHYFYP3OnHK/ONAj13SxeB4g783/xu8CCNgZJNSj11Iz7F8QldVvikHZ3oj5z50ReqbHgqz2CWvY4wOIFlU9Jq9XpAn+IU3i/K4ayx5T9413veSRvTWKZe3wONmGBVi43YuB2Fw/xi5h5bnr1uHg1BHrQrhQROBidIRiRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AS5PR04MB9971.eurprd04.prod.outlook.com
 (2603:10a6:20b:67f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 11:27:28 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 11:27:28 +0000
Date: Mon, 27 Jul 2026 14:27:23 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: kuba@kernel.org, Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sukhdeep Singh <sukhdeeps@marvell.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Manish Chopra <manishc@marvell.com>, 
	Rahul Verma <rahulv@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Sabrina Dubroca <sd@queasysnail.net>, 
	GR-Linux-NIC-Dev@marvell.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH net-next v2 2/4] net: ethernet: remove conditional return
 with no effect
Message-ID: <dikut4xqf5ky4vobqe7u2uetwd6vninhgo6ublm6j4odcrqh33@7igoo74jc7og>
References: <20260725150852.859188-1-ekffu200098@gmail.com>
 <20260725150852.859188-3-ekffu200098@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260725150852.859188-3-ekffu200098@gmail.com>
X-ClientProxiedBy: AS4P191CA0054.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AS5PR04MB9971:EE_
X-MS-Office365-Filtering-Correlation-Id: e70816d6-f43a-4be9-00c0-08deebd20a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ww5MNqE0R6D4agAOZa5xsrd7B7Cy0fJIoVY9mOFKK4EQ2X81LEaI69WV60bKTUZbpQCBObqcGoZ9nRoJEkqbAAe8x2PPOyJ/fqw4vcEdS0eTufj9V1OHxgJ/e2LwYe4bqWbk/Q/e/nSXRHSFov7TVrTaqxWnHCNM7jEv8AtUL2biO5Yg71AkWdrCNkePS2pH+5j++ExK6R1ESSMkspItuQeDiBRkZSDe3U4VSl+hWgkezY+fgsg0IiKX3urZJCbKP89lTiRwrryaKsweBekh0XsM3VlcaNQXg8Z+EI4Rq7x2rB8IS0+qRTi8NqTidGc7rmrzrIKvq0UrC1dzOW4cly2o5XcSinKlWRQxi7GjzmEnn5phiMzC36IBvIFI6ltyBz5uvgZODohbrhelqNwdybBAxik7apsKxsFkYxBaxE6TEBid40B/+qgfE2I3ZuQUqaUY18eIszuBrIfj6UrhRI+cGx1pd3BFemJ/7losEHKuQ5oPXNxczs1m+0oYCum+89p48bWK/jR1Q8UZg7r9IaOpV6iWPa+uWMzRRQJCNAZWBq+/c3AcLdZeB7ABNmbP75ru4QJGBNHYrLfduWxaub29oNVR2LiGCVVfBJtIxp+C/xX9+sghekhkSLIybrQQzMWuUzIQhYcfvMwaJHEBnE94CroKLgykbb9VtAogjUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wX3c/1ZKiuHrqj7GExj5CfeoJ78w7+RM51iuzt/au7w5aSUuMAdxaS7SfB?=
 =?iso-8859-1?Q?KfLYm1YQ855gisRvyLu3hdv/LiWOqrMLZXIWqWsSYCdUaiqdY5v0jl1ztk?=
 =?iso-8859-1?Q?wfKYmhYbJtCeeRVMogk9JAED5TJqUPoAINz9t4vIajSHzioTRm+Sy05sU3?=
 =?iso-8859-1?Q?/6ZmXtGj+6a2tJ9n7T7AU30TC5I++uYaCVqK4RuSdymE37Muug1PYHx5ct?=
 =?iso-8859-1?Q?TkigLg18VtzjZMO3AhKZ2Ucdo+QKrXszbz6oOsprLdo2vmSw/Ovy8nl4up?=
 =?iso-8859-1?Q?9zbV0JQ/dR2zEmpj2Py/DKX1ABZs9jzMxp5hKg8s1x6Dq4Ako13tb8Jcnw?=
 =?iso-8859-1?Q?Y9P0K0mcgC0/DYuidBl4SbxHjtL5OT/vLkAsQqAgPZRfgsfXseAtwLgVnQ?=
 =?iso-8859-1?Q?HqZkd3nNp92m6Wri3Og8mV/WsH6iuVMhTPxm0/ciKfbSGMJ/e0cXwIDdU9?=
 =?iso-8859-1?Q?HbRoyWLpbu5hnM2nwwp20OtW+afQG/kxzfC+HYzDBiH5RQ6KrMi/uTKkzt?=
 =?iso-8859-1?Q?YN/vvBxCVnu8Zx+PpHOihB6MaDqqtAvhUpXtxDh9TuSL0/KWh/foUoqgyh?=
 =?iso-8859-1?Q?4LqVazkAq70oPj9Ur7k6HtR+gQvywpoGJdxtEyOfuw78jh/Gy6YBimVjVR?=
 =?iso-8859-1?Q?Rx1KLEhWCKT3Z1iaFB/ucMJZqfThR005b4+jE/Ui4ptztrEO1IdcufvYoz?=
 =?iso-8859-1?Q?7kzdjrWaLKa3426PJ3lvE5IByneAktp258VK9uF3X//s1Am1VLkbSzkrF1?=
 =?iso-8859-1?Q?3O/0MFKV3y1Eb9JOSsb4HmWMiTzfVVsepFgVKZdqUVmIgCE9WpK7Rq+Jkm?=
 =?iso-8859-1?Q?MmEqUnfZdE2nl7m4dz+Gdbr+Q7UsWnNUMfsbqphcSvdFGYIK5313PA7CgZ?=
 =?iso-8859-1?Q?MIO/qRH+yts0v5x5qlycuI6NptXjsq+JyelzLmJ8HW7dfQFWFY95u97KsT?=
 =?iso-8859-1?Q?tijYNCBX2+cN6Eaz2aKxCl/tzLR6aCayrzyyjZ1VarX3/PjiVOOMANrH2g?=
 =?iso-8859-1?Q?ZsjKQTLwbIhtrvqGU/aTeFlfF4AEeftIGe1eMYIY+qlk/1ifWVXPC+pjTd?=
 =?iso-8859-1?Q?I3kY8a3uZ08dyH2S+Enq6lN4KMd7GWbOVQjWnKRwZUwB1ywanLbB739GR6?=
 =?iso-8859-1?Q?pbiqLtDTXungeoVvmtYXQKNgHk+jnDj6bfSxGNUq4Wqe3LYJI9cVQbAwio?=
 =?iso-8859-1?Q?ANMAaK86SZZ89qXCsrGLsDfiKVjD/Mz40cro86aJqfQcsdujABAMxk0+zM?=
 =?iso-8859-1?Q?d7AziGzIPGfuo9EuijqQMJ21QKal8inFSnJPDTl3NrIH9qLbURq3RbYCbx?=
 =?iso-8859-1?Q?TFl7Ynk2qHD/sERiuya4P5L+rq2NZho2zCHBCo6FuNKUTX7u82xRV1ytnr?=
 =?iso-8859-1?Q?jnG7CFzM/klapbEKTQAsrMTqUj0Eky3ylzRkPQPubhNj7TESY1pqHUQvpp?=
 =?iso-8859-1?Q?PKGGYBj+sjQKmoV29gDKFRBtpX4FGCSp4Y0R//jqM/JOkmAoBkb/5psQwr?=
 =?iso-8859-1?Q?NWDcspQmBP9vajvZ7/+HTtZbb9YCFFJsPlA3mvMddXBWdhIab+e5IaVh81?=
 =?iso-8859-1?Q?WxDZlFFZO8Lw7Puu1FXQUu1F5Bjzk3jLhF2mNLgGuYwCScUFykCy0LqHTL?=
 =?iso-8859-1?Q?WRD3A68aiebqUNL1PG+n7nL3uBv905JvHe2nD+e1zQELUHqV9AsqepF3d0?=
 =?iso-8859-1?Q?HKkxafC6XLWlH4s6AQGiOiuUZzwJTtDead7jhOqkPIk46BwGsw9Z2cwpTg?=
 =?iso-8859-1?Q?vV3ZFh5eSrbanP976QNa5iaQafHYqzUb7z4j8yPtPCaF/muDms/rLWJCvQ?=
 =?iso-8859-1?Q?tCynEkGV/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70816d6-f43a-4be9-00c0-08deebd20a53
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 11:27:28.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCe5aRHk/tv1ZbN+dSQ1QMfjDuFbbG7QtqoVJ+Tw1WxPidxEy4TbALcLVvUkH5m0xxLF9txFy6o5CyAf5NlfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9971

On Sun, Jul 26, 2026 at 12:08:50AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com> # for dpaa2-switch

