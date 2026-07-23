Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139B41A4E4;
	Thu, 23 Jul 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.42.203.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838974; cv=fail; b=kOb6oOGQcJDtt+AdvPp8Fj5XEhqkgPkpfssZBXf5IDVyyPhJNG2+jM3d1jbp+UuRWyPNDx0ZTut0zCxdL/cFN6a+OeGTI2ygZ0AuKifeYvhDTPCErpQiJgTe4IqY38Mwd/1xihFcy/dHAXz3jlbXEFDKBZzQjaJ19PkMtpKDQRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838974; c=relaxed/simple;
	bh=lqyMy6wFoJyB6ZsQUF5OUlCeuukP1CpKuPzy7REX2CY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uHrXOAvbuMNqSsF0fypu07oqo0hv0YpTuR9uwcVn1yX0d7dStVS8CqNLW2dtQ7K7a3CHb7iG/1AUP4Qbs/H2XAC35FUFpvYGtq16fUi4j3Z4mbU1RfYrbqvbocL1b6YCLCcXCZPf3YMaMbmBbPC09xPlFTwoFdL7tcdZ4Xr+YYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s05DvboF; arc=fail smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s05DvboF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784838968; x=1816374968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F8mhpmEDshmhrnJzOm0SjRPxlbbTONvQUQTaAO3cAYY=;
  b=s05DvboF8aoKyYbmINhO4XTYXupu2n2RpTfisPTangSg+sZ25/3VnctK
   7azP0LJddaO9DkZW8QBb/UOLRfvJccmJxt2Cj1kpjpu/x4/UOCAsWsC1Y
   cE3GFfccCKmZszYGUeuwL0BhK1jIeMRFIklLXaXjJyji5B/FizHK2ADj0
   U+tSL1z+P9yz7e/MOhOE6oTTWJ7rVIIIF7O147BqmXZ9j/Lzex33h8sNS
   1do2u7RUXBr0/25RYdL/OJj+AQ5K2YAe9fke7Bxedgq1yBXJm6BXiSeU+
   Iwqo5Dyrk7zkvHYLtEa7kfYgMp8NLYI1aXlN/w+g31AP1WS2v0yYJtG/S
   Q==;
X-CSE-ConnectionGUID: Af+hxQb8S2aFeNd8/1eKOw==
X-CSE-MsgGUID: /hq+x+LYSc2guX7TX7KC9Q==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24278323"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:36:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:23741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id 6ff998d2-62e3-453f-ab91-d57202915d59; Thu, 23 Jul 2026 20:36:00 +0000 (UTC)
X-Farcaster-Flow-ID: 6ff998d2-62e3-453f-ab91-d57202915d59
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 20:35:59 +0000
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 20:35:56 +0000
Received: from CY3PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Thu, 23 Jul 2026 20:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBInXKrVgWWNU0oS6qtdC9HZVw5LZr+02FEc3TE3m7hq3Kp8VJJhAjja85ehPcpYH3HyzhgHH05feJ/p1JRLcbEZsrnHI+eabbYyLcSHJuqLtF7CT2YPHx0z8OXAY0wTf8RhctWhxWr22b/VPDctGCLFXc7b6QeTesqGqF6n+TDq33OdlE22rdv3b4ViRmcQwUMQbQNYA6CEss286rNbDjYfjbO1sg5W5dwiPXbMN5E1o4ri2GjNVHbEmFl/XVjXK4slKldk8Jl84HyTGpSGZFak6TcjdOiv1lJ7YGFBrRwY7dytyFfDnIzKLXWN/z7MyO1yFyzCUX/wXBAq4vJr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8mhpmEDshmhrnJzOm0SjRPxlbbTONvQUQTaAO3cAYY=;
 b=BZqlPKncAHuSjAMY25Qmf8MVhBsdvqg6FOYrMftig0wOzmFaCylkwRoFvl7K2iwRqT+/ZBJ6tfTJwjszX3E5h97OpX/LfEIS5bdEu3uwu8QnUPe0o7BLrUA8jnREfaLhKgHwXvdNH6L0Bsbw7APvw85fiEflxGI3SPqQkhS/NFZXx7T8u2yqgSYCWcXec4t7+FKWkRCJTlHKgfSx37wgcjNiqzGcsh/Sxp/QzoQZQZLTL/lgFgopJHzLDLC6oM6T+63HX1aSgMXEVPeG0oKnikuCm4YkBIyf+2CcKt/B9Jskw1ANJPWNaIzGIQtkTXygJ93UW0CjB8T9wOjqQopR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by PH7PR18MB5703.namprd18.prod.outlook.com (2603:10b6:510:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:35:48 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 20:35:48 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>, "Julia.Lawall@inria.fr"
	<Julia.Lawall@inria.fr>, "Arinzon, David" <darinzon@amazon.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sukhdeep Singh <sukhdeeps@marvell.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Manish
 Chopra" <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, "Shahed
 Shaikh" <shshaikh@marvell.com>, =?iso-8859-1?Q?Niklas_S=F6derlund?=
	<niklas.soderlund@ragnatech.se>, Sabrina Dubroca <sd@queasysnail.net>
CC: "cocci@inria.fr" <cocci@inria.fr>, "GR-Linux-NIC-Dev@marvell.com"
	<GR-Linux-NIC-Dev@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 07/36] net: ethernet: remove conditional return with no
 effect
Thread-Topic: [PATCH 07/36] net: ethernet: remove conditional return with no
 effect
Thread-Index: AQHdGuLDHMLwqSGC80SEy6rJKdftmA==
Date: Thu, 23 Jul 2026 20:35:20 +0000
Deferred-Delivery: Thu, 23 Jul 2026 20:34:27 +0000
Message-ID: <SA1PR18MB4664DA66B9EA117823E78D9AD9C02@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-8-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-8-ekffu200098@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|PH7PR18MB5703:EE_
x-ms-office365-filtering-correlation-id: 02fb406f-9a5a-48ae-a82d-08dee8f9fade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|56012099006|10067099003|921020|18002099003|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 9mWKdtAmZRJiJeemqgQAmQdY+59Ms6Wg0cuwd1cTiU2LrTyn/ssn867XIuE9ork94RaVCbhFl2MC4yx9HT3oLeNI5B0zL+4KcS2gsDTRexUzaO13bmTASxe0v/jj/QJ4V2etb2v/yUBDaWmP4yH7Fg6oJWexAQjYcaEomgCfOUerBAGGlLwtbCL9SWt53niYDLNAsEQLVwZgoT11tXMTGDzpqXDFRNSuC4QE7154DlnhfNLyRQ2GWY/Nio/De3hOXUDbAZ5nc0ul6DZOH8OM+4MMjG71RduxQBODbug8uCzaTUD7mdygYByrt3EXqIcPDr6zKjQ7t5kDAWdNlmsBW4xLtVwTatiuokqcTmM+N74Awsil0IwjS9lLqLFmW0r+DGawvypV7l58OPv9T23rNvOVb/PYRxnMNnsUWPFI47cGNLxUDNKUoXLDth5ApjGHrpyO7/CZRWrR/zQi/eb2a91F4j6xW/nUGb0405hMxgaHXoqDkdi19zVGcs0mi/t6egvHy1b2eE3mLO+OQmZcTSczt/+krvvBELbZQv5xoGeCE1LvLJTDNHnLC6Nr+AbfU8RdcDqnY4bTpp8H5FP1Pk9ULjRr8X9VyOxF1TZXyK7xDq8fsp0ZmRP4lmGU1LSFnaOm+BUumuphOBwK9yHb0XYDQvEeE2JhucQlYwI4YQE5ISVmfxO0basYtYq/r0cKwMGtNEpvWKYCo24T9hHovCQKH9qN8DrolKDxLSzNAPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099006)(10067099003)(921020)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JPSd5Ib6I/widKRAKgu3iQnmvLP3XeH5ZJUOiCmp8UgroS9N8njdNbKkH3?=
 =?iso-8859-1?Q?5Hn5W3IlK+TDkNcJLz6dGxWYN6/NPjuAj48k1hl0NmUaFOeAsbqM6JLeqJ?=
 =?iso-8859-1?Q?K153ug0GFo6sZs+olxwXddkLUnz36ZzuecIJEHA6TreTyUPsS8nHdovLMQ?=
 =?iso-8859-1?Q?N2sukNUP0vDsIJq7yQKNMtTL8sd55jEXB/05VowKKvS9uELAvgnVNN/eKi?=
 =?iso-8859-1?Q?rnMqJkJ0hIr0jkHkYLxFj9Ia9/bzLfMD0Em8Dnb8RFmarmXeVFBdXV3RwU?=
 =?iso-8859-1?Q?RqbOKOI98mMIsPpgM15Vm1jpiTXwo6ManweGewhgmoFqUu1a5OUEWL7f/8?=
 =?iso-8859-1?Q?MYZrya1fYuGuuUwnOC8Pz4Y9Bnt99thDHxdR2Vtjo4sf7Q9AOtiDf6p/6D?=
 =?iso-8859-1?Q?ATLOHp31dOIpB/WxhTxtW+cQiQr2RU407jLqmpHVm8hMijI/9ct/GQoqe/?=
 =?iso-8859-1?Q?bjS6tmmhgK6kdHGVthdGS0GYmYG8iCyX7rsHdgb+jNMz4WZxIHESwl7HHT?=
 =?iso-8859-1?Q?JBjipeYPML0jiVjQXUe+oW3HnAW1Y+lj9hbf4KOw+LZzvoiff5UNQRHOSo?=
 =?iso-8859-1?Q?iX+gMdhzRmzLz/SQZPL775DZnduOtFm1KWDk0TOCdGRTm4JaSLCZ1YdfFF?=
 =?iso-8859-1?Q?mfzJZwuk3/r7R3sKvcoAYD5t5c19TJXx1dkIqEvXeKo/pGqGhXdjQKrhy1?=
 =?iso-8859-1?Q?T+Dh4G/Ufs6zZUkrmcnTuLqnxd9YqNQwAp/SWXSu0I8TDdidPAJPBvCWsD?=
 =?iso-8859-1?Q?NTQcSwRVAzlxrvjV3KhDDf7VO/V7PJ7mYaXf09WdfZXpCEeWS67X3qLkvI?=
 =?iso-8859-1?Q?hueSlLhP2Eyf0mufwLXV1NGZTbXSHQGFU9OF6HtWMW53z1qtKgXn01gaI1?=
 =?iso-8859-1?Q?TD03Qmu0UP1lLehTLzEVjpHLXbpgJRcTuOI83eJNjW0g/PYsnMMleGk3Qv?=
 =?iso-8859-1?Q?RLFUc5A2MJzmaJCDw3oVozlzd7a7YmCj7Y+04s4JPNRlIvxYvbsU4rJ/R5?=
 =?iso-8859-1?Q?C4fGfLe9BM7yfEvc4J3Ahm4nlEHR1l0TrDM0H9iHg3ozFVQcsjUmi8pAof?=
 =?iso-8859-1?Q?moYkPi3uwwYFGLVloQNCLj54dM7MT8QAiUF/95Cse1chiSnyxVNxoc01Ra?=
 =?iso-8859-1?Q?vGgwzhwxVNpmtmHfGRyge81oe5G9tj3pB3cCMFuKVH0bGGxQHZKNAtgX48?=
 =?iso-8859-1?Q?le06l481azEe/p9f9sf1DI5+nnl2HaYMA4sTeWaqo0Twysw/HrqSEyxE4m?=
 =?iso-8859-1?Q?sYdvni7c/+7paKIouSPBLmvr6HWbfwTj+2tF5ypRAjZ1WIZ/FwFtnydUWa?=
 =?iso-8859-1?Q?Dl1JWcS7TvAAENqus4KEddUC9P5iAxSphhw6x+OkcRhlJghydl33VHmg75?=
 =?iso-8859-1?Q?Kp+89QlrtXsGpn3BmxL90viZi+JssM7L3r91xlM2l9bsKjixuBkOwRmLSb?=
 =?iso-8859-1?Q?NzMFuHGzapGfuaVDPl1oyat4H2O9Ife5hgClrndEJvDDfYXe05rWozRPWD?=
 =?iso-8859-1?Q?7MmKKC2KuT3FAZhTANJGSvVnsLXJAE+22fOkkWhaBjCGv6cYsrqj9KLry0?=
 =?iso-8859-1?Q?S9r3Scp/gVAftNe9SRtE+Lgo6J5zUutOXTchdsb20KH8md8xovnXygjrdo?=
 =?iso-8859-1?Q?lZAeNFcbYEhMoqRziqcKDoA1WGnJSNOr3gEUfOIDr8tasKrEZHYXAwPRbo?=
 =?iso-8859-1?Q?fJwBLlQD5z+J9fM/ar3l5fToTeu4hp16jkkWYui04TYepk5SLyWjwFZhwp?=
 =?iso-8859-1?Q?ORafyrKV5OkEV+ex9zwL0ti0nRYEkyQoEGfdSKG9esWyXs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cxuaMegXaN3UXXlgEg2Nd06jphUR5hY0WzHxC6HSTTIn1VHIy4fLIqmMWiWSyNOwBMGZLLX/ZSGQ4XlrQqfAi+7Je8n9hWTFXZjWigIgOfTEz4mGTmOB/N6Fvc5AabmrdnoqT2lwnpXgCsT1dKYodvo18I/T8S25KKcow9QktW5vrmQWD1A0gj+MrFynwFdU/SpZznixI9ab7VbA9Y1miqMD3Bny/3xm3gBF2c1B9OLze/PQ3c3NQDcvrGNF6UMdsGY2egvkSDZja9fG632W9HWBeEoaYeZ6LnNpYlofM3vyWvs8N3xRIQBklU//ynGdSBgMawoUJj8avTWO6HHheA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb406f-9a5a-48ae-a82d-08dee8f9fade
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 20:35:48.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8uMfMxZVKhZtGVUrp8AhyX8yRlBX505MRQB7UyWSh9rLqr4cYpuDUld8gDc3Tf7LpLacYAQzkwIMiQKvp7Jag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5703
X-OriginatorOrg: amazon.com



> -----Original Message-----
> Subject: [EXTERNAL] [PATCH 07/36] net: ethernet: remove conditional retur=
n
> with no effect
>=20
> Both branches of the check return the same value, so the check has no eff=
ect.
> Remove it and return the value directly.
>=20
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
>  drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
>  drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
>  drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
>  7 files changed, 7 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 5d05020a6d05..ea89619039d8 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
>                 return rc;
>         }
>=20
> -       rc =3D ena_up(adapter);
> -       if (rc)
> -               return rc;
> -
> -       return rc;
> +       return ena_up(adapter);
>  }
>=20
>  /* ena_close - Disables a network interface diff --git

Thank you for this patch.

For ena_netdev.c:
Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com>
