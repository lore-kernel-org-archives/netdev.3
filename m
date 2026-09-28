Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91972264D9;
	Mon, 28 Sep 2026 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598728; cv=fail; b=PWPMAr2YSZFFebmfiOUGm58pBF8Xw5cu7yYUh/HQq7tjaKCRlbczc8yrDVVmDunknY3dsz4g6FNIvlt1pSkrO2oYOXcMLCnOILXhfhtwKL0VzLYX4t43IaD1Cl8F9vjMsKOTxv1cJsQISsAf9GyeKAcLVCLXXdZ0seyVd9cDQSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598728; c=relaxed/simple;
	bh=GhHeRAytMuMejefm5IHb9Yhn+cXM5kKhg50ddz/wX+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PPRmY9MlLmrMbP7BUyy/NchiSWTGI9rlbbQBnx4i4r02qB3NHFDu2V6gAeuN5TLql8WM/rcOQll5AOxCjiiV+UwEU+Xh0fUO9YGxK828LKfC0OlYXGxm3LecM2hZQfcjq03Be03rx1q7C4KA3JZtRUtpJwFR1OcLabSjLlpxxqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EvJoxugC; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EvJoxugC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOF2gudeyKQ79bREgIxRXpXwD4gdGJUFFznO7GkXbw7ho9wyUXKdOFMUWMJidCv/a3qbR32oHoEnk1m+1TVg+lLLi2lDVYXxBsnVWl9yrx2bEF6ZIQN1Lkw+PSrmSTw1n31sT6inbB+k2E94FMddMTZFvbXBbQ1f6C+7nu8Nfn3acja4EY9Uph2w0AANaQPCepsnefkEU3XtAYcko4aI49eC8sWpfw2NHjpGlmovEsS39spGyiFDS0+ysFYaWujiaCy1XXm2HWkVfWtWMEhiF2rnLCJqWnH7S6G+AcOOjGvkjvOupo5PS/YKlxH91ogTKH0e5G3SR/Xa7KJZUrb4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyHYUh8pM9bBMBYHRXwzhNpj0qUydd9bJGSOt83cOAg=;
 b=HteI42JJ0dgsyvIGqKPbOcWmnucgJQYdxCRF02WQiSxRIVcgDmI9DFm9UqEyQFLgDDU5MGJsNmUbIDSlgi731sMWydiP54PEEZ9SQxSje6SDtnxXRM5vy2+cBOJy4scgNSTO1CMrAMSHdqKme/cJH7bRyvl5Wah5ZObR/dZO6vaXayYrwY2HvF/YcGNHQxiD/nzAVIs7NVBy6Z4VZLGRX3a2jUGwCx+RWjsiVsBtlrrBspc+D32JXfhClp88fvoLldFc1H3sm6QxZRl2WSyZR72Fb++jjtJsEjTzoFsX7od8fL3Z5iK9hS8m8MuPOKlTb9E+WBJOXOcnW2XCcv97hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyHYUh8pM9bBMBYHRXwzhNpj0qUydd9bJGSOt83cOAg=;
 b=EvJoxugCk95tC81GSL0618eq3Ct0wxXYH2714lJS9Vu7KGSBJ4Gc+3t6UR2NhW8u0L03YT7OBqdhSXj+ZMM5rYxsxIVCwZw87Bz+oAdos5ifj6LVzlPQAXhaNd286F/+dWz57VqSonKc4ZAki5IGPP4ObG1B1S8mUILPNZG396DJzr9/Xuqup9+VCZACJAXIaFu9X0GRElc0kfj+01AzqPChiHw8FCXXqaUo5fWdApFEXEb/ZAuwiC99m8guVN8nnnFrLr7JqqL5DbBVADW2ZBPJ6Izibz4lfDvXfRttHBxTbpuNRAB+EAm9oaMJhZPQN/u8vyLWrX3OSfLUhA5RaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by MMZPR04MB746498.eurprd04.prod.outlook.com
 (2603:10a6:190:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:32:03 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:32:03 +0000
Date: Mon, 28 Sep 2026 15:31:59 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] dpaa2-eth: devlink port number from the
 DPMAC
Message-ID: <6ve7m6yzwonkghgzc3r2wlpayxwugecohkytllskq43y6utmao@aquhnej6btih>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|MMZPR04MB746498:EE_
X-MS-Office365-Filtering-Correlation-Id: dde586a7-413f-4017-837d-08df1d5c8046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	Y26qL3T+yIEzyXv0svvO6OmDpf1y1SgngsTyiF4736gLfhB5MWuE8LUgxIad8lJuj8g8Mg94XYxeTP3D7DuecN1HJxbNmMP7ZPk4G2yhdnkWTXcfgTZdtiS2UMZp75i9q783WKpD0U42vLGtyMKWyi1ss0IAJFjKeujNoOL3RRpioqka0yWqf6g43P2v/92wEBJCVPFYPVOvKVV0mV10ICsBRjgQErs80vioOfkL3RsDGWk00DcsyGYZTRQLVJ92HPhLcpTjLGmirG/6a+pAIQcfr6TIpO+H+zVcYUUkhsLEsT2+1YlgxzsJ0dbFNsZCZULVIT5buPXmO7UIcu/6fToL5B8vgKGUIZAo2x1jlgVh6QHRww3LBq8MhWj/6g4fuJb5D5QP0GugMVi/Hkk0xmkgn3lzkKt5sRQdnqCsAGQdhI+I+AAHUcjfdcM+b4ja4cgGQzOCFAWKHbUJEfgu3qbVHrqhF2/fq+fW7qa41/xz8sYCHLeWhUr/78gQWluFbhtYx/eavUhxMLdXUSRL8X45JUQ4mQX7TWiv6cKCp6afsf8s+r0XoLJfkRHAzj2BA4l0uqF1TA4eL9A9G21V1emhSVbQf8i6K9VssQW9L0m1KwZ4GSC/pnzKXcxMsMGPvLSh9igKG7E2HkeSTBdOlZIpUhEzCCwIOVHgEElcQ8gTyNFgaeamQX4k3kdHpf8bEoSQ6g9kcz/cTHxdmv0kq+Ji+iIpGnWWwaxE4rd+g0EYhPLe7o0ptfkazImhdlub
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rzkXHTX1GVtA2fMaAJXbL3/yV4pZhTDyTM3d+Re80XsRYqSZu9aNY4Co6oCM?=
 =?us-ascii?Q?f6cggXOZe9lu3dlf+MBDc21FkWHhhPSAKXszvWZ6FnKwGJh0wu69OFXknsXJ?=
 =?us-ascii?Q?hvKPz6X6+nA8OveCaF7+3wEVL6pqfWgtyE6Jav5+iF7x/gmeYHcxqKcDFKbv?=
 =?us-ascii?Q?XPnrXFsIBRawyMwswE5r50qUP3ZQeJJQrbtmayjXwReLXd/VUakOUSeRv5J7?=
 =?us-ascii?Q?ypXqWO4owAaFKK7JrAw2loLeSAwY0WNO1m5J1IfTgpqJCaMmE9SkTGN5OSul?=
 =?us-ascii?Q?kxS9U20QG5dy1Ngm5DJIaJGxSYblicb4LBNx60fuWZCTk5CuLv9RPKBe8xRG?=
 =?us-ascii?Q?yIzjyENTiGna5zEQf08GPOEcTmWWGDUrq+xuO33P8UEsU9Kl+6Wy6cUWxfvI?=
 =?us-ascii?Q?TvdAKytHPhDNErkqxgkXzYutbJUx58rv2xY7Zf9UceEfx6/7c1oT89ukwX7u?=
 =?us-ascii?Q?j9eOhqgI4bdkJXOEW8qCnDSR5znuZXDXvoQfzwdaSwiUYcA6myiGPCMKVmH4?=
 =?us-ascii?Q?MkJFhEvzTzdVi1+Od1SQ2yYBdUkxoHr28A1xnM4+Kg9VgEK/8KsGnhZShYnE?=
 =?us-ascii?Q?EtRQmrf0FaKRwNj27BGbnAI9UruqTEnWnUgvkwCWBhXDV89AcaJbWTJ/DC8z?=
 =?us-ascii?Q?BP6plttmyrEBjeoXNT0Jk2/6Lu5m9vSPLbNSBBG/NJtyjnruuVyZB5Vlik3r?=
 =?us-ascii?Q?YxFaqGW+Q+T9dWja2G9/f189GWArQXAr3kUXlyAoldTT4qjmyoFWasDQjcDw?=
 =?us-ascii?Q?3trnsjOceaiZMG9kwsHCQbRGqMok2kGMnAHvjRkJ3uE5f/sTrWJxQ+UGErcy?=
 =?us-ascii?Q?r9zCNb6XYnBhUNT1sbjPQpP3JScBKAzG/t+kyPbh2ReJL4/JDEEsTRnx6OHW?=
 =?us-ascii?Q?TVbz4Z7IQkUO1w1B9rsBOgcpKrt0/+rOt8R4iog3QkT6JMNbVKqG1Gg+dosf?=
 =?us-ascii?Q?GFLSMJWuHLe1Iy7BEf2AvK8yQrIBFCwmViKRwnJTWM/Ss7009am982zwaOSQ?=
 =?us-ascii?Q?XJllKBNDLAJhHfAu3NSSrkeI0/VxMMUtiWAn6CRhVsHgh07vubNHcW8c7JeW?=
 =?us-ascii?Q?sP8KgfxawrYa7C3sG19bXMRhmffPGrIO5191//AQPTDQ3TiBdmU6+vjkruOv?=
 =?us-ascii?Q?3NaiAcRVlVWUjkUXLfvFkJRzg+dHS5WbEPOqcenPH4vK9JWm2jbMqjuGLq1/?=
 =?us-ascii?Q?O6T+MGUesdqS9/ZzWPHGUCnvZMpwmr/gnOpX0vkKZGDpDqTd+SOYJ7l7e8wx?=
 =?us-ascii?Q?413b+A8yqPhzG/dZnSCtC1hzJg8uRBnmbiUD+Y3uU86biOKCqwP1Qddcqb4M?=
 =?us-ascii?Q?b7rJrv1t6vh7uLB+rcYTKX4rCJ9QFNFfoc1tEf/6zoJ2dk3ZugHlLZzWoNmF?=
 =?us-ascii?Q?P4hF0zdhiKLbIZoaobVWIBRJZ7GKNJYZv4ToFSS/Q6DM847Yax3LGZhCoUeI?=
 =?us-ascii?Q?AdSO2Dg+d6Y2/xTj2URO0VZyt1fZImqqRDQQUZ7A1HLoMxpUERor26qsewjh?=
 =?us-ascii?Q?AC60Q+1t7t+l8d7teZ4+ecaMcjIF+n3db9jYI1E9kis/CC4OIbzOyR3Gzc0w?=
 =?us-ascii?Q?FHgP4WYjEfxyhkwUEzigwYuCCceC4+SSptrEjEAIfkVnVohCfjbr04nvw30r?=
 =?us-ascii?Q?Lt2JmQPTzt165DLzUUhIiGauVu3fOEH6InjSGitU8VwE/Sg2E9xKw7cjDeUZ?=
 =?us-ascii?Q?wXireTdqYwRAESqaRvFZ+yEpQRLpIasboKxRf4ykbi7y/kXco7AV2OMT0zRB?=
 =?us-ascii?Q?vKoNY3XqEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde586a7-413f-4017-837d-08df1d5c8046
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:32:03.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+wbgmsREv15pKCwagfSIayXKTGaOSQZvef0U1w9XS1hqWcgqJpZYlCmvu8q9u2Gu7K9Do7Dpchc8uKlNVDc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB746498

On Wed, Sep 23, 2026 at 02:57:59PM +0200, Vincent Jardin via B4 Relay wrote:
> dpaa2-eth registers every DPNI as a physical devlink port without a
> port number, so all the DPAA2 interfaces report the same
> phys_port_name "p0", including the DPNIs that have no DPMAC behind
> them.
> 
> Patch 1 uses the DPMAC id as the physical port number. The attributes
> of a registered devlink port cannot change, so when the DPNI endpoint
> changes at runtime a warning says the number is stale until the DPNI
> is rebound.
> 
> Patch 2 registers the DPNIs without a DPMAC as virtual ports. They
> have no phys_port_name, so "p<dpmac id>" is unique.
> 
> With both patches, udev can name an interface using its DPMAC, for
> instance:
> 
>   SUBSYSTEM=="net", ACTION=="add", DRIVERS=="fsl_dpaa2_eth", \
>     ATTR{phys_port_name}=="p3", NAME="dpmac3"
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
