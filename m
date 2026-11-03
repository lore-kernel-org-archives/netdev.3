Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702828;
	b=0X8bVQpsbh031vRIrQu6zqcvLijR/GTMy3VUqCAFBdBBzG0vPVoViUPTFBA2SC2g6K/T
	 9MtNvCGf/AK7c5nikHA0hsSM5p9icEdeqcPq894mpCnJKF6h7CwOUaS+GWlH+lQH87xRd
	 /OQnuiDCyIBvao0nvc+N96bgl0jLaMTuSmMljf9nmyHSTDRNjIqRcGnY2UQ15M2MrrHMQ
	 HTPt+887JxnZpTb0500to51W+nzuoJOJ5/N6L9/OK0wNNMtgfrUkJCSn188AfQvNo6v8H
	 /yPlQYFKzijcDVs0geB5O76O6ZyCuSld0md58QGWowPSzQCGWvBKLrTt3NGWCNNmdtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:X-NVConfidentiality:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zubcZKrFCwpdJ/l6TQeGKSWOF76sttKGzTiAFZnubYk=;
	b=D7Zu2KkRBen8mDUMGmH66flE3kbup8oXHtzWjgqPjzP46HiibfEehlNtpFraFN35O3VP
	 r0xIiFjM5fcPjSjuQX6iS1/s95gue//9AB/TspQh47N4BmYjc/7NeFzNJitNS3oX8aHt+
	 u/1hM47NpYuh8dn2On+dmCF4S20pd1CIvCswI4QUI4ZHezRe4uHboEy0S80AoYbYdnUo1
	 ZscQ/hkcQVvMInQVq7tHXqPHI+6ZtPmNwBC0Ew7mlzmTDdB9kjDSgPuCnHlmgbl+j8W5S
	 RAA2yKBl4AyOHNUCJJ15GCdiMtVKcvVWX4hO2ET/4XLkgwfrQIadL8xIhWU/YPOEmvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CsOlhO6u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.17
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A4606C5BE;
	Tue,  3 Nov 2026 10:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F02A4606C5BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CsOlhO6u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGIp9aaDwwv0EbKQFz/j/FzA+yPHOz7oGB/yIo7tnZctRIstYKiXENm8/qSg/1+xn5VH1ILqOWseZTOoAqnA2qOMWj068tcayPFyHWu99GxOr8yATAgEB6vNjXkUBthA+LC6zL6knUIo2TtPkluLEJlznDRv1rkPZy2CTIZiQnwm31uzVbBn4U0gt0+KO6ZtvDHItgdfaHGEFr5TdLT0SGMYoDiLHBBqO+BQUKHvadI8WWb9Mcy3lUtiIO1Wtn2Pw6oT1lmdXJGbKn1De6L/KyL/pc8XWWCs3foRHz06UVIe/bFOS8ra3ND5BM4LPVb9WgG6bhjdUX73mkzOkmBOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zubcZKrFCwpdJ/l6TQeGKSWOF76sttKGzTiAFZnubYk=;
 b=S8ImK3QrM+AOgyfeULfJbq6nPAtSNCaJZynpuefwgrbrx85gs+H/qUL02zrzPsocfBIHZvou+XlSyGeiITCuGwEfQ4sNg0sac/qhc4THGe0sN2PXQecAd69WF9ZmnW4zxvf87vc0v/nQHdHIVxG5zgQ/DHZ++fwiT+lpqBUMUMs6Dnf6cyu+pMKPxzTCP1qT2dnNnzdewgZH0m+cH1IShTmgVCwGDgSPo3s+XxP/ppyiy8qOrN4C5ZAxsP+H0qXc3xkGp2sLwTrVw93CI/kb658VNEb6suR41DFTj9Pv/DpRWRkwuX06bFGVGOaogl5h66kqKNpaPgzEJH7X8EJ2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zubcZKrFCwpdJ/l6TQeGKSWOF76sttKGzTiAFZnubYk=;
 b=CsOlhO6uVfIlL2RpPpv2YHUBN7TM87geIPzxmG+1cQ3xwZ7bclNwrA5jWSO+RSZkosW3imynEphaAkVISz6V1q06qsQbjjXVKn3yqfrsJxDemjwBP8vPUoARZi1xgXKEl9PHZH0pN08N95bmr+pUHKAAyaN3lfEgoL/nNdBOxawCZSfwgNP/W7pJsqj3B+pNcbb3M5KEpTa0Bflw9YMlJzd/3JXQ+5r7LlqYM5ck/bKzGDzxmISRwjExs7afjlXLHf5oE8LYC5SDxZZ71lmAAO4Uo7f5cTqoSQuukKzXkvAb3pGAs5JCJVJ+Ej7M63ceIDsWDM1/Xxk0pmgh06VRMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) by
 SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:46:57 +0000
Received: from DS7PR12MB6022.namprd12.prod.outlook.com
 ([fe80::ed94:5edb:3834:5a3c]) by DS7PR12MB6022.namprd12.prod.outlook.com
 ([fe80::ed94:5edb:3834:5a3c%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:46:57 +0000
Date: Tue, 3 Nov 2026 11:46:50 +0100
From: Thierry Reding <treding@nvidia.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Convert snps,dwc-qos-ethernet
 to DT schema
Message-ID: <aum66Z1w3spgTXWM@orome>
X-NVConfidentiality: public
References: <20261102203353.1384705-1-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cta34f2ri6kq3kjl"
Content-Disposition: inline
In-Reply-To: <20261102203353.1384705-1-robh@kernel.org>
X-ClientProxiedBy: BE1P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::16) To DS7PR12MB6022.namprd12.prod.outlook.com
 (2603:10b6:8:86::7)
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB6022:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afe987e-8214-4f7c-9204-08df3997c815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|10070799003|18002099003|22082099003|56012099006|261102123227099003|3023799007|10067099003|261009223027099003|261022113327099003|261022105027099003|261021121427099003|261021123027099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	YWK5edwdLaONdaLq1GxSjUDavNCP67tr9ftPkAy6QsXPmARDV1SMtPUhaFMzA3QEHlbGYtf+V9jtuwbBQP+jQNnP6PyBVi//TXzW+gaeWFSSmAZpaukK2fgVszbxffz6pjPQNEbJKgoDaM1DSNA/b8V5Xgr/G6wN/oNPI2mVd3ixGBo/7WB6/hvAo6KtrUcP30+p9Hk0OlNkmDFB5geQox5KZB7S3wHhed9RTSFuiVdWxOyMxOEaOa5UVyx9z7bMZH1ON8cGm9lHc5F58dn/sYnAfPc1tMQr9n6u5OwIK2esX/qLW5WOWotybXAC2UpVtdcv8cxbRdWEBqpvLUO4r1F3Pwo3jtS+6h69ao5yy7cJNax29d6E61krMoZO/JQFeLPIEjCZIorYHo9IwwdeiX0h2pgJatHdgPCNOXkJg7UKABcSe1um5TDn28GjpzbIh987u7nKx69WnnC3RzFPdeGOq2XCvmjrJGtPO4knvwPP2qRNjuCSUhIrdxurQ/i8V0BDvRhIGwr6L2Szuj0OWWHEkyVc0jhHPtyrzF1uZWAu+Hoa0n9dpgF0Fu4zIlX03RKgTrqRPareW6/SvBi5ggTeFUZoZ1WhSVEAVR0B9CH2u2+cwNTncjmcB2EdJXgnaA0KusPqaSw9P6zagzmdWgMslCBYdWAVBRiVMFUpjLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6022.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(261102123227099003)(3023799007)(10067099003)(261009223027099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021123027099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwvkVhQ4Z44d6KMJeYRKa9Y2tYH9cIngWR2y1fWJPDaovjacqtKET4nMqSLx?=
 =?us-ascii?Q?c+Q631pIxCOfdG59w9XGla+vZWKPkvx1G1tQntVeii/qtmtPUC0NVpP2faJ+?=
 =?us-ascii?Q?6LObrDTMFdfmcK82ejx/eG3780WraOB9KXf4I6ubNrXgw1rjCvP5ZGf3liPi?=
 =?us-ascii?Q?YG/KKDz3Sm7pTOnY9GzpEAPtyZANSByB1Idgi4VKksLnRghcfv1/eMwUzRl5?=
 =?us-ascii?Q?eSXN20u/j5Kpe3OfE43R0zen3UlbZOOXSubpF6tI3wuhrXrxGLN2997iQfGr?=
 =?us-ascii?Q?4WVF5hCaztQhfdXnV1JgdezwY4Ab6oJoVvl46pzLkLuvlTXakavVXy/LUnaJ?=
 =?us-ascii?Q?TMFsA3P80fQzznZqLR5DOJ4vLTlzQOGi6w4rL1K63LLiercuImrS6QWSigS+?=
 =?us-ascii?Q?JObSU23LbSSVW7ldh2aSL7zh/tIGnxE4cWC4zVLuPBTboKO4zYJF6pYW9zXe?=
 =?us-ascii?Q?VQ8rgrHVkNFPoxlrbk/R7lxH6msjn9Xdtud5BuOvwoV2bwPlGfoKNDqdu2gI?=
 =?us-ascii?Q?a8HXnMOFNYdSWfAfHXxW+RwXBQltDrBMLowFlDqkOWBkvnZSPLNG8hSLq2Pf?=
 =?us-ascii?Q?9zj5+XCdnyMqmc/wfoZ9p7SdjBnazs+Fzar9+BtHrBkfETuClDcuKhQYUCVF?=
 =?us-ascii?Q?gycc3+z3NDScyzt0kyFD4eQm7dkTHS5Esg9a7wLzB4yFm+9Qx5GZjYHzgP3J?=
 =?us-ascii?Q?J36XiqYVsZqz+84GrBaD2XyZD5+gh0mb1STauPiqttQzgh8vEKzpHBmYnmIt?=
 =?us-ascii?Q?alyQYilQgrvueaw6G9hpBXxpsIIhmtS4d3llfiO6kgWdyoyVIipEF7S41R8j?=
 =?us-ascii?Q?C9Cj72hxdpTL7efREkA0vLrde5Ug3in2UxRNg0mk2gNYZVwTib0X71tXejaq?=
 =?us-ascii?Q?WFmvBNlaaABN7k78eAk7C2ZgTWvfdOpjt7l9RTUB26mCcfiGVyS5LK6kVBjk?=
 =?us-ascii?Q?h7JBnUYMY/4mzLwzG9Fd5zaRyTesrS6QrLisJyPxWs2OQnRZmgDjyRPFeTRa?=
 =?us-ascii?Q?ljzENpSps5WIz3nZ16lLcwXnuwVXIJt5xNwSPAK9juImdLRwyZgNh/sqKluW?=
 =?us-ascii?Q?1VMkpW0TCVf9e/sUNgu26OZBjtsm23o1w7WosnWnDu+rC0LDOgnIvbXZsaf+?=
 =?us-ascii?Q?hW9tuFCPXVcva69wd2Djixui4L9Nx+wv2pozPGNX1sqHyJZbnsznA/3UHsqO?=
 =?us-ascii?Q?HZUxJPzAPr4C/H0VtjUOfQUyWtIxVcuJtgN/YN3mDffIDzjnic4wMebZdMfx?=
 =?us-ascii?Q?Pvjqxc2Ve5iqKXBFEQ4F1QbnzxxBb1NEFpGIGMrt9+SVFNE3kwrrisEmf/x9?=
 =?us-ascii?Q?g169P15qzrcbSsnSCeb/OxFZk5Z29EBIA7/Y0tqiNjC1nITp6akrnh8dv4kh?=
 =?us-ascii?Q?23oAsyA6ZbbnVtZDn6FRyG4Gw/iNbQqqpymAvKHDqoVIyIfdqPSMlVJXdDHd?=
 =?us-ascii?Q?6kx2SHPyEcByJ4Y1tb8TV4zUQVKuYcAzjmBH2B2UOXZzz/1aGALB5jiDYJO2?=
 =?us-ascii?Q?Y2QZqCNT3mp6hK/ZgYAobCcJj3f79oGkMg5QNKnhQcB9OgkpzF/mk5ZR24h0?=
 =?us-ascii?Q?Fes3huyAR+wPxok+CS4QKr9Or4JYTuNY67xMjMVQNZy4IO16LHZc1dF5tdQ0?=
 =?us-ascii?Q?OFfIAWgU4XBPQBWFRVo9GgzDnQgrSS6oHzqmGO85RAo4cW0+YgAgnT5TfJ1t?=
 =?us-ascii?Q?rI7lMAMXd+8sTfORKVd2+54HfnM6ECBmZ9pVvEdbKOAtEvUWeb1JXyFO/r9u?=
 =?us-ascii?Q?7BK0yM17tv7l4hZFk4AmFTAFSq62bL6IDavMjlGI+4NehYIDvROBXC3IMeQE?=
X-MS-Exchange-AntiSpam-MessageData-1: LlEizSeSqK/Jyg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afe987e-8214-4f7c-9204-08df3997c815
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:46:57.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPm3epOcE9FE+kLn2PNtRbbDR1uoZiuwgMtvISYNVsjltHUFTHI3o2EA+mPfAUfT+0RiNVII987hLGTKbYR6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

--cta34f2ri6kq3kjl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] dt-bindings: net: Convert snps,dwc-qos-ethernet
 to DT schema
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:33:50PM -0600, Rob Herring (Arm) wrote:
> Convert the "snps,dwc-qos-ethernet-4.10" binding to DT schema format.
> The binding uses several common snps,dwmac properties, so move them to
> the snps,dwmac-common.yaml schema.
>=20
> Drop support for standalone "snps,dwc-qos-ethernet-4.10" compatible
> and "axis,artpec6-eqos" as there are no users. Also drop the
> "snps,dwc-qos-ethernet-mdio" as it is also unused. Add the interconnects
> and iommus properties. Replaced the example with one from Tegra186.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../net/snps,dwc-qos-ethernet-4.10.yaml       | 225 ++++++++++++++++++
>  .../bindings/net/snps,dwc-qos-ethernet.txt    | 168 -------------
>  .../bindings/net/snps,dwmac-common.yaml       |  20 ++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  20 --
>  4 files changed, 245 insertions(+), 188 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/snps,dwc-qos-et=
hernet-4.10.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/snps,dwc-qos-et=
hernet.txt

I've had a variant of this in my tree for a while but never found the
time to properly finish it up. Thanks for taking this off my plate.

This also gets rid of 16 warnings on 64-bit Tegra platforms and making
another 6 boards issue-free.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>

--cta34f2ri6kq3kjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrpu5oACgkQ3SOs138+
s6EotA//SmfJrKb1cGMNIvO6bgW4wQZoNoegMvQMcwFkrGBxo5lnHUX+Uu1QtCsv
ZDN2Usk9S7KoACQgcwOIAqxYmwbDG0gssQFPfbBTjez1Ua3tnDrnRV85u7Pmp2YW
93ahehgg120n7XhgGE5mLvoJOVA7r3Bwib5s14xOXsUBy0TYGRB7NVEJz8WMw+9M
LUUOOOEav5ozcYHLkCh6/dvUZutPujiOSno7kINOquE41mX4gGqkDo43ZCUyLpQZ
zJOga5zvnam+dadvMN5P4elV4Uo75F2fAFTWEqUdqaFUMyz6ogOa6XEokS90GG8+
PUG9phqQlJmPTNWb+6qugZDlV0wn5vil6ddXVd/FmrRqHwIJMoGvBbJ2/RFCY50b
v0GhUQnOmew14QCNymRBHKZtl22tbbP/dzn7851Xud9JwDNMubsV6O1/98Lr6Snk
vOQpIRb0hfzecpCHwoxRJsH/7w1AElfM3sTMySH9Dzroda9gNSM2/U/l3xL5+kMz
55uXITqLoTUtVGpelIK52iukecEhUxvw/a0f60q5tIIus3ea+Zaw/RnCvCuzsGtt
WBx2TV6DI9kbULsBtnh6wh8MApc5uUAFrG3wWYF+4d6/HLz1jeOJ2hcA74i6HzSh
HGLbto4EehPc8s9Ox+yKLsbUpSzWlw8AvE9ySBLc0c9nffi5b7c=
=gWSl
-----END PGP SIGNATURE-----

--cta34f2ri6kq3kjl--
