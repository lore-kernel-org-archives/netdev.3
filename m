Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27843FD3B;
	Wed, 23 Sep 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176179; cv=fail; b=XbtUjiof+Ss89sx99DrT2+bvTIJ/XsJHQRBmzIAbgq5ZMl6ZUAn7IsYi3Njkdxu4j5ztrgP16dg9T1VtPA/VH2xb9oDuRNUWHxPMUuE6cnjNoJ2CR7EZe00ySDZ4GDcD9hPT0xTuHXySDW2AN0BQjzKYXqv94hSLdiciDdiwpOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176179; c=relaxed/simple;
	bh=/l3+ZnjtoCspAMexWOSFaVId8NcIkcQwBMyE0XmNnA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+H3BVr3693tWqQ6n0J40czwWcfP0sHeX9R+RdfjV7FplOymoU+CyqnBmKykpJ/qv2VXVjsCGD2QUxbTIsuSoe3p3pt9sNG8z+iTCzcDksEnljCN7vvzy6efGvuStn4emfUoqqZ8I0Hjgxamk+zQM6xlEdSSwFUn4P8aI07BFm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RNyr/hTp; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RNyr/hTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLmVXPzZmyF8zBK8WosX94DXe4N/KMXmM19qr86QN54Llxp1BsK5dbkQ+tcoDuh9w2MKGltGmw/YGlX37bF+dEwkMteWzl9OUa8ls47b5qEU6C+GYSncnkAJJz5Z5h3ntj0Tfw2SpbK9R0n5HVsd3rXwow+v3xgT6UBYopyzAfmpyq83MygJl4+Za5C4gCQcCJUecNCFfNv/ztfgsVhkgsTh6x/n/AZ99hiaIIyFeElKn3bz6s4tpABkPZfFvcTTFM6QO4izib5poj09ArDCbXuB2JC8CXbhWWwoN01tjfRKdebrRSEU3JkL5Hp0yMQkzLXFBhWkYNECgI9dT1UVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re9zy3oSDhDTDDnTE7PIbVzv1+AXecNFo/2GbFD99rs=;
 b=I56vt88u2MPINn7bzXozVVcBei07TqBJ+dKJjbHMebaU5kf4mtGGsr4FGKQjK3oVYm88xZQXR3uIyHQB3ig+9ET8b/ZQkJDExJH+JTFJNlbZDxw6nhfqG9aTDSyG8t+ZjNtVLKUIYoInydEnVkyXMNfrmjG++s1dKHEshyD3aHCgyOgnYMd8TUzBgQrOnaRC9xxw7QlZ1Ni7KSBh36lSBJatW0YgSmXIvJazTefBJucnWDeaK8Wbx3HazfevpkEWPjYew6Bp7GQiIfPsET45T22rsQcZJ1aR0Sti8wldxPf4+ng/ugwZDbY4mrv0B+xXhXIKZwLyfPvju7FPfYVXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re9zy3oSDhDTDDnTE7PIbVzv1+AXecNFo/2GbFD99rs=;
 b=RNyr/hTpNr1GG1jUYl39BnOrf+hkuE6tKrHo7iBM6525uJOnqyzLAANuKO/y2Zs79G0fDomMQSQb9+KfCf+A3ptbjcazrGIxjLZdAChhaE5eS+Q7IsZbq9F9Ng3sDKXnXsHhYpYCd3HOV2NgPySUIUvJgZVLYNXL364B7FOqLvr0hWMOg4FOyLSykCa0Q31cD2LqSRyNoRGLwBjHD2anloJzAf6lnnH9ljFVDbhKST5vQY8l4wmQkKeNZnDLIsfKAGr0y/D5z7GGcw4svR6vo8HpERvqqYpFJ/x6iv8KVk2w5zOO0JiBARFPzrSnVxrOZqk+PHk9608ho661uOrrtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by AS1PR04MB9557.eurprd04.prod.outlook.com
 (2603:10a6:20b:481::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:09:34 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:09:34 +0000
Date: Wed, 23 Sep 2026 18:09:30 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] dpaa2-eth: devlink port number from the
 DPMAC
Message-ID: <rljgvjn3gbyq6ixikhnrwe6z6rlmfd3pepns4u2dujzjo6q6uv@kb7uozq52ozm>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|AS1PR04MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f7db9f-fb05-40eb-6f87-08df1984ad46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info:
	/shVG10nQYU319H0MuaZpUcj61ui70dV7cjm1eLYQOwTpNVGvFl6SWnNk34ZT1GQ4IcHPmOAZ5EkBwS9/acQzZ4BFW/MDjBsk9S7l+7tjgX6NqidCiUgszQxkL+KNeSkZ0juVIm4GTQcevH7bn2Vgt5kaHFCBQRZKQNhPpWcVA4+U1gJm7Uc8HF3hQcouyCmqTWZAVCw7IyqdLKb7vd4klVt54uK1RDEbRt0jcjXLV6j+3uzxQC42BbHX7uuV3r4Nj6Uva5Us57Y2DiocTvlrmGH8G1UzXrxCSVux11xqFRLeykbuUlJrwY85k/R6z8qd1dJNxJm572jzosKkjGf2McRDIH2SC3/mxUFvl6Jf5JasoIVAqDXNpc8Rl0Wbg9/RNJtydZysc+TQqhXaumu/aF1W/C6C8boUB9aNlhaz2LxduqxlF14lQgGcO9N4E1qxH7gOJqY/RQm4Xcp33Br616KNsliz6AqF24wo9MtTnKNnwHC1R0Rze72SkiWYV2SiSGm9qmpBV09m+BuEKnQC65AAMBSG04GL0h0vxbusQ+B7/S0trvY3mxarwtjqXFJir013LhUkQbb/R8kjd4G5MouQH41D0/VxAk6vQrmW58tK6fgCV78/q44EN0guwS+BH9C3wL4zY80EEB5oI8TccdH7pu1Ngzm6Xu9y8NdHGIWeckVOXq9yi0UUL7G+bqnzn12Kg7N10t/wJoFQh3E4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80/2pOqNMQ2nANA7PHW9otb3f2S1CGlgNNUkuMJEiyu+/KxMPdoQAMRaVGen?=
 =?us-ascii?Q?DFmJ9UxZNBIvxjqmuPq2U6o4nctAQ/BlAg8SRiYmZD7TNbaXxh04spU5iCM/?=
 =?us-ascii?Q?vOySQ4IKu7gekKrkZMXT70wBYw+QjevS91zh+RWUhLWj2ApJxdMLl2HzezUO?=
 =?us-ascii?Q?6whETsypo8WEovbf8RzALLTpcDsumROmzNmT7adCwbUGtc6lbOCgKlNAdH30?=
 =?us-ascii?Q?PRutO/CGaOZof7GbEauhMSt6rbDetRsnS/e3SJKamgQuekrf+T+TrA57lglF?=
 =?us-ascii?Q?cq77qQ/ezVf0omgDZOfFGp04w9vBf6uj43fkadmFondboQdD7KPj26c60HvJ?=
 =?us-ascii?Q?nIDWTWv7MSY4OkR8Cr2h0adqfZQw6wkRDlRKhFkxsn60hs9vE9IOeuEgUd7M?=
 =?us-ascii?Q?mYQqcyanETNCPs3Ul7HMbosKCbX8uEjL19KvTc54IaPG2rL3nJmK3qeETd7n?=
 =?us-ascii?Q?qqeKTHhDyXC4o/+ipOaObcN0xODf0ScyrIGwyWvCEc9bzbQxANy5TnjICc30?=
 =?us-ascii?Q?HgmuJZSKwov0GfJ9niA8QRJcJ5snD2OLqLr3ndiUPd0eyufSZT6h7oVIO5sq?=
 =?us-ascii?Q?gdutdorYhfan7IAGDSTVC01w4kX+oywYBaef8k2r5GVaKtLKnP2nnT2iGBdp?=
 =?us-ascii?Q?Yb1P9ySUUlETQ25Cctdy4pofbSxFlM8eKl14OWe/SxVZpDMaiIVx7+r13tmj?=
 =?us-ascii?Q?bpMPqYbT6TGeIz17h/zlfiYutX3mpyH1QjMbOqLf+w0I8EJdkB4u8jp5pG6r?=
 =?us-ascii?Q?iw2PZaeKSAmjNu/98BU9bR9tIUyD/FMXr+gW38wWeUjhiZ3lndP3Pd1nEMhc?=
 =?us-ascii?Q?KjtKj0kKQRJttIimnnMsKGROwjzSTCgDjz5eqf0ccL9pWMPVuSUJH5ceB+Hi?=
 =?us-ascii?Q?s3h6tQbLAfvuy4NiLql0Jpk1gUPPW7um+X4wGJ0NlmplNA1HGpMt7s9u94Rf?=
 =?us-ascii?Q?j0duNZgJ004woCr9uqhnjX1EoaTfCGxaRLmiEONSQ/YjTA3t/YwhEsBXE5xd?=
 =?us-ascii?Q?o41LhuHSFGYZXWdH2tEj/3c8AhR1yrYjD9SPY2acZd/3kyIUonsVXX+nftaz?=
 =?us-ascii?Q?LwWuDb4MpSpcL/PePr75UQJ3bBXlVOKNe/U6J9RRF1mv1huv3dYLERGyfEp5?=
 =?us-ascii?Q?0Fxman7jHQldSoXI+/oKy/gjSa0aiiX7s79Q+zcFoeJwoHo7OB7YIHrVZj2u?=
 =?us-ascii?Q?yQ++Olla8awGgzB6azSHFyBbpLCqh6Ni3SXTwpCQdd7sHuTpj4d/ZPSxTjo6?=
 =?us-ascii?Q?GUiJAh6Q2K6uoIVcMj3nYwW6WrtpJ5eDN6COatiYME2uSc7mZPxPLIppmwJ4?=
 =?us-ascii?Q?C5N20UN9uASYgiBjs9aK5kE0RAg6nNKszSp+npjEdU8/NiH7E7GSwU5cZwuL?=
 =?us-ascii?Q?n1/ph+d2etjoHLy2uQjyhbKfYN59wbjJTvfZG0X49FdOyugccwD2tgO3F7W9?=
 =?us-ascii?Q?B2lQyiX9NVzXhKOe+HxJgGzoUpyFGY2BcB5UTPg+gODBjiRJBJE/bSW8932a?=
 =?us-ascii?Q?NktNexgjxnEmYEZgXP1Lcf0ARDLbCt2UINzGiKsJywoSABlfyt6iSY0znuxC?=
 =?us-ascii?Q?Z6r8uoqkF6rz+fjnY2ToJG81xwn0Rd+RMwR267hRU3lbZbM5kqaB8aIXIDjP?=
 =?us-ascii?Q?I7lAX56CMzFxBaficnOaLwRjuHcVMDTro+LY14ydBdp+iY2rBCzTYUjVZz/7?=
 =?us-ascii?Q?+Kzog5ESkmosEpLA32ByW+uxsNz7fWRwazTHyKvTMzF3hQp4wefOstm0qtyj?=
 =?us-ascii?Q?ECuNVXSUZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7db9f-fb05-40eb-6f87-08df1984ad46
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:09:34.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXvGr77LSHdIbkvm//SVQt1BhZjOBjmBsupzcNPrShtFsj3Z4qL681lewuq5UuELGx3miCPpAP3UHvGljAdQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9557

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

Is consistent naming the end goal? Because renaming can already be done
for DPAA2 network interfaces based on the of_node. I usually have
something like below in my udev rules file:

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="fsl_dpaa2_eth", \
	ENV{OF_FULLNAME}=="/soc/fsl-mc@80c000000/dpmacs/ethernet@1", NAME="endpmac1"

Anyhow, I will give the series a spin tomorrow.

Ioana
