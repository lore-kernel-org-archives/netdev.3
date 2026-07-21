Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020113.outbound.protection.outlook.com [52.101.193.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC846EC86
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656931; cv=fail; b=Xbu7F8uPnOG2QxMZwdSNXXqGUdhzQ7zi5vm0pVlPAIEvj36CzqNQ+efokH75D9DgQBjSYkyCmMRefLpi99F+DYyPAt733Ka1USfKCVy8Sxzi6XfyyNCsQw0mOUERqJWsWI6+p2FWVABjORcV8dZetcTXYgUSoWuvQWCSxFCFzKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656931; c=relaxed/simple;
	bh=R/rco2eTbaYaRIWCwIqNCrJSDdRz+DmzJwvGH0x6va0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m1zvQAfgsYqFJwcf8mv0OGz8TkSYWD2wv0uQYE+Q5yVz1k6i7wzH1rFXl++TzmXde1magfE3mVJQtgDV5z1q9KYxk84ufuT5n90fxyyIilA/F8yUj8EyCwm203YipxCVtJvt/B51MStLohIktAq4jOYKS9jdly9ZGFwUxoZ7SfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=0mvuL3z/; arc=fail smtp.client-ip=52.101.193.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="0mvuL3z/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v89CN6Jw+ITrzBMR2895L/pKBjbEhDi3PJFirKbstffOhdGn12koqwcNBRH/A1a8YwFC34FUYlix96JnDGe9x6dtntb3RcX4h2Jq7ps6e/iYtw4HT6wJuBTbIBCoV1Zq1UGrXNFm0NxfiwnkFwvBbVX+39G1i0m0pOgDcJp5JjWAc9dI4jdthhfjzBUNzN1wsIJqC50JSAilQjMh3PyqqqJ4D4x419ZFYcOyqY2ajneP376b2DaFI4wkA8p0u1fTDy9s3Apda7T0HbuyfMiLetR0eR5sZP39CRBRRMZpF2ul6dSkDyXKqn5BBMAwpGjjldhnEXDYoJvBYPGJDDeqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/rco2eTbaYaRIWCwIqNCrJSDdRz+DmzJwvGH0x6va0=;
 b=Wx7kaVmiW7Fec5zcROtlJhOPPlIKh+HFKb1BhZWD293I5Qa2CMMycITSAe6rFFNG0TizAcjO1RVADQWlwfrjtZyb76mqYA29lB/HI0KjAkcn18et/he40z3frSTI3mDip8TLN7GYmeflhpi6uiioIHSKst+VU0NwXxvoZeZwZ0YRFavnVQR1zdpotbo0/xgFWjUqRR0aw+TrmoVnBcBEOxshKYKY/oYATer8SveZb4ICr8kZ4FOQaqBRnRrA8MNGPye5UN65j0mjdP1sSSO7unDKVIoW1QcDpBiQPJlF67X0P4vxCFQZa7BRwgYwaYuq+qW4q7fs5cO5bzJjtc2y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/rco2eTbaYaRIWCwIqNCrJSDdRz+DmzJwvGH0x6va0=;
 b=0mvuL3z/Puj+cvUGX1YX/V9f2sobBct2yi5AiWhsShD0wdskmf9pFaoVusCfmOju6nTyXmcwrvAz8rd3k0Ap+rYEmsLrvtszNVCwCasYOGehe0VAOZlQCZjia10498AWIt0jDqSGqbk9cXNefsK7RGSSW+YfAKX/40MGDTDjLt3rOzZH1ZRl1KrrSuwmKQbO7rbJIcfMh2FI76eQ5/d24O2CZRrEJxGw7X9IH3khN+F+6F/ULfSCD3Djrkhd/WOZOd2+lYXV6zrcRPgzetJsEQruJP3jmzrRVkcYDdmK4lx8rFAFX+qFdSJZ03iPGqGTkdVcio2c0W1SBZRB5m2D3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 18:02:07 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 18:02:07 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: [PATCH net-next v2 0/2] net: macb: Updated patches for 1000BASE-X support
Date: Tue, 21 Jul 2026 13:56:00 -0400
Message-ID: <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:610:11a::31) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 25043b41-a139-4122-a087-08dee7522dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|786006|376014|1800799024|10070799003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	788UhxayV/pEQY4fDwjcKN9R3wvVXQAdPTlmiHEUCba9f379wCC8HkhYr/fiPOF2rQEpzvdJk13DdE0v7kxmSaunXkq4Zbg7fsErH+kwQDdNRwfdv7bUZPwv4Oih5Jvyoc/kFn92VjW5qcPdi375MnJqYmTeVv0a1t/05tTt8QIaKm+eaL6xNv5UKUEliT+3tSM3hgGHl00e5y0wTNedeoyy2TlSaFtqOHlJ9MEvinHRV5BTqYq0lbCws+l9qMQvi+ONLl6g3UzwIce/FjnjC7oJh0dfw95T+MehrM7NY0h3FQDi792LwgmIh1Z9QA3vIAluso2LdyMiCs0uoEyhOczFQrsZaM8Ag1XSxhXwi1uahiXowumkfowpQAdY9DyETASaWrpPkHRhdgX0XwF7AaMWnkPHs3lxBrsFEZ0Oh0bcXTwhmdW5NQDKFX+o3325MuuajFBzUHuKLsfUK2nLnXgIN+bd+9JtWsMxUm9viqWC9W/ITXCgZB9KAkSjrpoSEjZk8CenVSrpO276A8iEKDk2zXzp01d0aRa+M6HL8DwKIFshNLXxqVzDUuRRpq85Q+75naa+lpR10uNSeDGE/r2WQBqXPhIdgNVBfnuz2K1/O9o9lYc3e9SBenXoP91Iu981FbD+C3aKIhiDoRqTJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(376014)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvqgjjQOpqV1hNFQeu6DrpE+t2tcqRIzf22fkrVuQs5rYlC9KHW5nGozIe3f?=
 =?us-ascii?Q?CBE76oD8JT5EDKEZCGzzlf15VgCVK0UOHncvCL4E7V8aRjfPThFiJQV9DtGX?=
 =?us-ascii?Q?92eH7apRWwy8UwB8u1jzhr5SfMdT9VPDjYDRLdwhNotdARYI8Bg/dgmbtCWc?=
 =?us-ascii?Q?OaGKoNCCYHfVaT/xLF0/iTzlljG8CdAb7nXu6axBaUW5MqoM/U2NPJO9yiZS?=
 =?us-ascii?Q?VDCT9URbap7XQVixSJWkLrYhljQvSTmfFH4zgr93mTgIcMpMYZe/zfxitXyT?=
 =?us-ascii?Q?poyWf3i8lQ2LQFZ6Rjwt0z9lF5ck3/DyjcfrAWMGAezuzadA8b8tfPejZo4d?=
 =?us-ascii?Q?q1L3sBkUCFQtusJpoq+32TLLqbjT2mznMZiinKrUh5jeUtayE5fQ5Fj5TuDp?=
 =?us-ascii?Q?ijnjNVijue+sVwgGbglpBdEjMLdaczf3ju9O7BO8Ji0BPaWlrm6TMkSvuPwX?=
 =?us-ascii?Q?gzCOuwzz6U9AfHS4izjc73PxAqkVDYLYHDRycWezIC33E9N1V4BxOgld3hII?=
 =?us-ascii?Q?4C09WaQXqbDRv75EwrOUHsWbjpFR10S0UrUAuWpiPz9RjIawLu+a4Ka/DALU?=
 =?us-ascii?Q?8u6tMbyrE8YAWBjPJ+Uw9o3qi4z62CxHBQe3PDtxBhEhrR0P/UBzrFgo28zC?=
 =?us-ascii?Q?wIWyzrLkaaxO4jPxf4RCGJgtchly3XiEoyGkRxXkJTQitG4ZIxzwK7jZSVks?=
 =?us-ascii?Q?OvkohSRl0G6PYPLlotqhdJd2dJZKW0kkhcuua179vlNSAE2PUSSj1HmBj5UZ?=
 =?us-ascii?Q?oHapzROd3dT7kezwobXar8H8elUqEsE/+NrJwp0RP14u21P93fcQNWUgIPeR?=
 =?us-ascii?Q?SnMMoZbULTBzO4rJg/pMJ5I/pr3nZ+FicBy9Y7+3Q9L1pA8kH2K2h6XrtvYd?=
 =?us-ascii?Q?jZEVi9dTdCqVfjPU22ZCuhq7JpGA35Lwdpuv+/EuYcz7t3r5QNcggURgEw57?=
 =?us-ascii?Q?n5CcAKScMM4pSlpEoU15kInpfJjjsZjyETe77yCeudzh1b1HrBWwBNlS8eim?=
 =?us-ascii?Q?xnlcVKQP5A0SKEpVyxU7E1Nimd3ebv9QZa7Af9hVYT92fBgBrXS12hMhKlUP?=
 =?us-ascii?Q?s/OjNO4FX6yx/W+kaqjRPZ63D9+THXlVLEjgNzDbMDMeiCScYyQtZeQcYT0Y?=
 =?us-ascii?Q?lRodAS227nmaJFWw1WoclheR8q0NXtk/9dOXiyeh30XtNcC+PrgxUw1nlhaJ?=
 =?us-ascii?Q?QOBSPapLWNc38KPfG8heZFZBHzBvQzqb1Qi4oWRDjERde+RohDbicfghgKjo?=
 =?us-ascii?Q?RfEfOmnrdzGBsfM67pjW027WlLUaNcejxQ/e0B6nNc7kfMobZtYoyJ4M00SV?=
 =?us-ascii?Q?S9UHydso+WcHufqTNMfYAw/t7Tn8SvBN3+FVyCc4idGifrLo4tMfVpOrSJZV?=
 =?us-ascii?Q?i9SJd4INt6w8GqXb9qeuClmvk+rPjxeJXRP0Rzggv7rZM4gsdw8YsQI0zik0?=
 =?us-ascii?Q?uZ/6HF0Q/TiXK8LN36T745py5F9Lt3EZ+8k4eu6Vn7i5mwAQJqqVbUzsRQvZ?=
 =?us-ascii?Q?cFX6YTyob4x5RsNNa2usE0VIblrJEDGfEO0zKNPrHp657RE0GZgFu08NBO0/?=
 =?us-ascii?Q?OWM358MsScWtobmRUTDKPKLUvA7QhPZpGaTkP3GYcgvZVlzL2q3Ap7++8cZx?=
 =?us-ascii?Q?JftphYRTp98onD2zAk7ZvKi+NOkFvzVKI6FAdmQHoU8tEXM5sJEVfhCx7aSb?=
 =?us-ascii?Q?8SbvFF5ploFHJmjRHf3p1iWff94y3y4tJDwodWJ4wfyw0GHPwQPv4/mG1uxm?=
 =?us-ascii?Q?hM4A28Nang=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25043b41-a139-4122-a087-08dee7522dea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:02:07.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eq3KPiMt4Qjls1oKKhiiZAFfTJP0fyg2zZ3llChxeTt5Oiq49Y97z6WcKNaUNI50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

This series adds support for 1000BASE-X autonegotiation to the Cadence macb driver
when using the MAC-internal PCS. The existing driver code is oriented toward the PCS
being used with an on-board SGMII PHY, so uses Cisco SGMII-style autonegotiation
exclusively and does not anticipate e.g. link state changes arising from fiber
attach/detach events. The first patch changes the driver to monitor the PCS's
link; the second extends the existing SGMII autonegotiation code to also support
1000BASE-X autonegotiation.

Thanks to Charles Perry and Andrew Lunn for comments on the initial revision of
this patch.
-Nathan

