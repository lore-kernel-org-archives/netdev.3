Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D68449B22;
	Wed, 29 Jul 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322049; cv=fail; b=JXjRNXCfjV7x7Qn/E6osNO8HNyd/RoVid5QWqU/MApaZThPmtR6eJ7iQBLVGX35qFgQWaLiVRlHWkDVyNka2yInnkq6v+VZOSkjoMElK5sY6SCrtD0qjKJkkNpVAMRs4SHC7dJARZRkm6o6/qiLTp/2yTTKXmtjMfzI4ygk+uGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322049; c=relaxed/simple;
	bh=jw/sTpaDhYEtH+jH3Un+rOPRqAM/zuIgOCr/lykaiQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3Q3eIHbNeW89JP0h79Mp0wcvvocBe80YAJudpQy+9hlo3cMoKEu7FJY4mvfCruPElwO/QWhaLVLH4htjGQ70ff0xsSZ5/8L/eGZcjNK2tXIYn5eBsQ3lwZgmoVWb24rSo7KeI1YKt3ZjFWm5/tTyToNpaUmIaPuSIumlrXgZ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y66nsS5w; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y66nsS5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785322047; x=1816858047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jw/sTpaDhYEtH+jH3Un+rOPRqAM/zuIgOCr/lykaiQ0=;
  b=Y66nsS5wojx92w0Av1gC6OYTfC9UH7c3J1E4XmwJZ9cr8Q7PaTg0cEzP
   D4cmPT7I/2tgsUg3hhr1cfYiJPS8W0d0HrGnUuLNi+ubJLMmbNUufMOk0
   FwY5lGEg8Z5oQH0dfQCwWUjvXH1TBV3c+mrMAfkzfZbGa2aR+iqJ198lx
   8PUSyKfTmd3OTfJsb6vBHlaQrXaph+LaYo436vF8hKZE183egKsCoSzem
   fV1nNzs2OEAtX3C9hXep15ECwBc/BxC9ok/okrkOl52y7rQPgjb8iqlif
   W5RF0xfiaJpdmtiY9WJPXhgPszYyCUM3hkNzULXI/b1h1zw00p5FOGyTh
   g==;
X-CSE-ConnectionGUID: lcoLO1Q8TLutld9fzQQrbQ==
X-CSE-MsgGUID: H1JMLnZcTPalWMfHAkr7uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97435151"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="97435151"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:47:26 -0700
X-CSE-ConnectionGUID: xRq1MbAIQu6GBBmPHdNUJA==
X-CSE-MsgGUID: myo0wlK8RmS9lWJSPXRsow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="253636147"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:47:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:47:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 03:47:25 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEJARZTCTe6suDdnorbNQ8B4w53hLK3WNC6NK9Rpmqlk/XPR/qMzBMKBp9qHS/NKX0XnTQGrIgToV78XStcZ2QBNGW6pbxdGNMBZLMPQweUAHDSlIMLzzliJe2JssNvqeTfI+iPO3NejcNkDbfwSSP9rKiHOYZ8LjIFLIfWeeoNRFq3eWsIuJ4G2bIkwTi6soUQy7gRoiav1uLBfh8pcOj128Ry6pZZj8voWZLo1hKcR804gLsq1abThmdoslsCiv+bF6clLb0TnGEJyncso1JzewsXBt08cp1LVdwzJtWTJxNOFaPuWNuIphYq5ZDvWTsSFT877CIN8My9QgnF1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw/sTpaDhYEtH+jH3Un+rOPRqAM/zuIgOCr/lykaiQ0=;
 b=psFz7uqGWVVr74+mZa7B7hGg0/dNnA+otEe8H9bSAOtynVEe43NEzHDQxyQGYjqiblj97N+uUzsDgrPZqJWAFz839IF73bTabx/72TkS4s9xPebUKkvKU7Nu7Cv+VlkTnGGfbJUP/QNZCu0+XSLAFniT7Z5a7QR0lNPUgomvlZ8YZwrgoa8ogcGJAM8Gcbk2vl6bzBQWwCPbuY4ub1LuN9tFjVfbWhEmglhTBmUM8QkSTXBxe+snBxIkFAZP1Z3cz4p6gioJbgsnFtW1YNBBoYdGO7HkVmUfRoI49W+ezp7Ce+qx3vC3Wu/L+R8C++wer86VBGjNF9OtgLynnO4o6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA4PR11MB9372.namprd11.prod.outlook.com (2603:10b6:208:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:47:22 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 10:47:22 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Subrat Pandey <subratp@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>, "gakula@marvell.com"
	<gakula@marvell.com>, "sgoutham@marvell.com" <sgoutham@marvell.com>
Subject: RE: [PATCH net 1/3] octeontx2-af: Fix mcs string buffer size
Thread-Topic: [PATCH net 1/3] octeontx2-af: Fix mcs string buffer size
Thread-Index: AQHdHyzZac10z06QYk6GlATvhYB2DraEULlQ
Date: Wed, 29 Jul 2026 10:47:22 +0000
Message-ID: <PH0PR11MB5902D607518134D4FB323044F0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260729072337.664479-1-subratp@marvell.com>
 <20260729072337.664479-2-subratp@marvell.com>
In-Reply-To: <20260729072337.664479-2-subratp@marvell.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA4PR11MB9372:EE_
x-ms-office365-filtering-correlation-id: 7b558a22-e586-4a0f-d6f6-08deed5ec516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|3023799007|5023799004|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 2WKGSP4pltM4LK5obfARKou+g6aRAbw2XzaaETrd7L8HBfHM6q6QNLbuAmpxLyyxfgXGq8qwwjVnT+yimdRsNV3TTUGgkQ8uUTtCs6X76kdsG4wBjC7RnXw6PK2TT/lXGSNb2kHcD9/7NdxUEpH9Eq5S8hoZu27RqcdfAaPQdmJI9NPhwB+/miQlzC/RRVsN+kvEQFflW4/mN/kb7FdMavR3yEgBZdQxvVZxTgv6tNbUww5p8VcIvCSrkMWdLoUYqi210zn+/Rzm9Y1+pMp+Skk+MFiTDt2AjL2yy8ZUeH68XRFdlo0ekJoUSrHlEeG8RCvgDzInSpwvGQdl/m2LdiT0OOrzYlbB0iwZvcbzZuYCdLnGuZmxOaV9xoW0C5VS2Hdm2frL5eEMPhOUKUi6Y9VAVWZU+LsJg6lfdaaeXT0OsVs5PSjYsBrxD0b2ZEn9/+DUJf/4UNcaw5KnmPThUxj9MCtjQAWHK/q2LAVqFYnTXDN5gaX+xpZBuK6hJwkxpXbAPKutVrdrEfxXIhewNmm5MUF7ZPMwiq9gwJcj8WrcM3SDUbLbbMFrwC+yRXEpWNH7jwG0MRxyO86ltT1UdKMK1T8wTRSXMAFWqnAHbhsW9QTMNn1qZ20l+QYtQg3ZYOVbv5ACLdA5Yzd4v4WhkqTbV3s/CTUAsZrPJXwjOuSAXzPFudRQBVWdmfLO/giPMtlyuDZsuf4z186QWzKN5vXVlsMk8G/fEQQV1yNYbLc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(3023799007)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VvxmiKkhj0+QQUFwGckefOB1HaNzk16P4jZZR9+gmvWV9ROqN8HPsWhFs9Bw?=
 =?us-ascii?Q?tLOLI8Q9RK0bLVfjKNbkGBQd66hyuJBFCVqMaN/0poL/oOXPOzt5g/Z4NOe8?=
 =?us-ascii?Q?njjqw6p+7hMwVXUtYS9w5H7/CsvwfjY/XSLZOTIvYMhH+8HpJM+2N0Rgv9xo?=
 =?us-ascii?Q?1VWj3NscaahkG0mRj/SmEioKqhJATAFlLH98+8jDZ57C7GH1g/XdmE4WIQ1H?=
 =?us-ascii?Q?FlicDzmbGVPZvVWHqqhKWFQ5DPAQFxmlKe6i/CL2JwclBT3DC8NS1wlRLBN1?=
 =?us-ascii?Q?HyDW2CX+Sf4WZWz5AyVjC/dEEiUGKA9z9OHKla3dpucAKv3bgAPp6A+obDhK?=
 =?us-ascii?Q?nYrJxwL7dT3Ofb5SB8sBkaj67SxjhZvXX0SsMdbCnrzYZihwtGRFhbIxIuc/?=
 =?us-ascii?Q?m3URUxLuxSACyh76S5XELanWStAJlHioLd93NKzspMbRHjGEYnZvlgeQmDwf?=
 =?us-ascii?Q?kHPNaJfM1wZT0AHZYzR/ALUqaYJDqkucau+JJJKd0WAsyiKZKHcQwjTH5OKV?=
 =?us-ascii?Q?PXMFbxh2tUegHYhD2cdQT5xwfbKCzOw7p7R1YT3NwB3KFdvBX5soVvhqneVH?=
 =?us-ascii?Q?tQmfY6oe6m9fAHkV0JrWjJ3ok0FHTEzxdjpSh+pitwwFlwVjpTWU3v237VtC?=
 =?us-ascii?Q?ApunFP9Og7cJXjo7A2j1rtciOYktmznqkJfuXTlMGwhLDvWncetJelz3ovei?=
 =?us-ascii?Q?kQH96uKgSGSX2pxwlExiq/4Zva1h3PTGLmisBZCIbkrNu9osARf/6b/K+AcU?=
 =?us-ascii?Q?jRwz2kS9wQnCcX265Yr1SMmb7JEi/EDWsLC/YzsU3QkqIQsmt6hN90ROhUBq?=
 =?us-ascii?Q?NpztYwHndCqw1Kp53l7zkUuDFqekRlYj7OELfjNOVawi9X0eqp3wPSBGoMxX?=
 =?us-ascii?Q?TkGfEK62WEdRBob8aVuqTExPhALaEICyzmtXxjS2LRQMJJf064L/31v0ayC4?=
 =?us-ascii?Q?gRwp/rosN3Y2WX5pQwCj+/OOJMP2MFwOhXj9/BD8RFT+uxFIvPPCmQM/UJDe?=
 =?us-ascii?Q?eY2GZsounnZ4GTIGycILumo8Ip/IDfkDw7619Kay9FPWlIMEAdU++RvrxGLP?=
 =?us-ascii?Q?QHxTwS0SR5LhM2vF7VAzzruJqFR5Wy0M+ULFtL0AF0dBtGlnSHHw8LOLFiDH?=
 =?us-ascii?Q?gpGrWZknVA7gf6LWF88SqfcuvClmxXM6WUtXeDPN+h8Rg3wWZ9qsK5sq+nYq?=
 =?us-ascii?Q?0vKErlOLfsBbqUp2a4wc4/1k8R1uoExk/RIR2sLnJeI5wS0dcOBWivmZBawf?=
 =?us-ascii?Q?TyPXL7ezr0+vKjVEGc2dupn5dSAKoL8REzjIsguKkWgZVz3g5WeJzMgV0TBH?=
 =?us-ascii?Q?R5UxG84AzagiKnoeJmDbrIEAcTrYjyHVPaK3cYJV8kmxd7lf0rNq3Uy63uyN?=
 =?us-ascii?Q?MBOL5PULfQTK210G09+g+kEjReoCuHXdSLTQ3Env07WBBqr0JDY4MMqVOTDO?=
 =?us-ascii?Q?F+iChlGXoJZIFMj6ynUdIEdZTsSUUUFT899oUu7Tf68ln17S7sH1nPTjpmwb?=
 =?us-ascii?Q?KRqtTiOqoGkx6zLpI85V/N6c4JnihfuqzGtYLJej+I+yvFFveWmbCS5IOIs9?=
 =?us-ascii?Q?Ys9ldilLLTvITeX12d1tNktWRxz/p9ovx2ZROgOBxlmiYPaTcQ5MYDa+NLra?=
 =?us-ascii?Q?7ZdwpC8rqpFE1t40FQVWUGvzdyVD1LqSHJ3LdYMIUUesyB/gvhV43AYzUUIf?=
 =?us-ascii?Q?bx20bk01PTwWWWgD/TPp3V5bBgN6xsNGXUsYjA9XMZy2sXcFyGRY1coasMy4?=
 =?us-ascii?Q?4AGDhqS4gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mk0sW4H0xY4/d4kiPT2ODQd/kVUm20EEeRid9JZhUB5G7dL6i1AFzGptHHViold1/DFwl2S0iwhCOzR/fxb6bf9XMsEO1nPsqFPRr86WcAFGXkqFNejf3vtdJ7t78V63tFqCA7+UQELCANqom6r/5vZjU8Sh0EwR2Vf5lYjM0odUuYidYM91hqHdZG0pOU+91jtr8BMbt5pPfW8VklidXKorTS9E8jzdvOzOwcfYY4pwxhcYarfbjhHVoDrdspFYqK1DlBDkloMTgD5pVsYnK30U9a+z5KahlPoq155DiudKpShJv2lHqb615c1d9R9RppfyyTeeg/ZOEnlb6DWykA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b558a22-e586-4a0f-d6f6-08deed5ec516
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 10:47:22.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqH+YOG14Zb6wRIG5OvIyN+IzTGT7ApPDowAjc2FHG7e8874q7AwjzqTdnH2HuUpfrMbFmt9YinWGYlk73p0qi8qj6IG4lYB8RLtNziVadk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9372
X-OriginatorOrg: intel.com

From: Subrat Pandey <subratp@marvell.com>=20
Sent: Wednesday, July 29, 2026 9:24 AM

>From: Stefan Wiehler <stefan.wiehler@nokia.com>
>
>The "mcs%d" name is built with the unbounded sprintf(), which writes
>without any regard for the size of the destination buffer and can
>overrun it. Switch to snprintf() with sizeof() so the formatted write
>is always clamped to the buffer. The buffer is also enlarged to
>24 bytes to comfortably hold the string for any MCS block index.

Hi Subrat

Is this something that can actually occur during any real scenario?

>
>Fixes: d06c2aba5163 ("octeontx2-af: cn10k: mcs: Add debugfs support").
>Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
>Signed-off-by: Subrat Pandey <subratp@marvell.com>
