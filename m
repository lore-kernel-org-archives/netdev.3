Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC693D75CD
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399797; cv=fail; b=SGqCozheecxxFXJR0IpOz2zPlp57cgiwo0oC3/4NHnQFgjHGizP6ahfVAfZr8ezCkUyZYEAVDXmEARexzg2/KqbubMo7wzEbZn0ezpJiMUDwa5yrdRT0GMRsgcnSE27nyFk1bOqMrAUc930wLzKRL9G15MqYdxGUsFto7/5lJC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399797; c=relaxed/simple;
	bh=F0qfBy2j0KSMIdkB/U+PRwlaFUULoJRfZegNJeLsv1A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gurWqo4ciaCmvNZ8QXTAEts9sv9w8ikp2pKxRTXnSC3pll5uS19UpzvyafN5PmdU2z9fzyJywHrSf0aKQL3tpa/b0WEL21N6xLvmRj2RqpE/CEF49ud9KwT/zIgMtUhaddd0JSpHjtuwIdj128jMhGVKO6j1CPa/QwQun7U+GIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJl+Hqer; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJl+Hqer"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780399795; x=1811935795;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=F0qfBy2j0KSMIdkB/U+PRwlaFUULoJRfZegNJeLsv1A=;
  b=dJl+HqerzA97jzlGqyYteoqPlNPNuWDF2r6r89afRV9KosDBcDibtGUB
   YxwCrQ8dI/fZX01HcSpIX4Nt6AXNlTgXkSHdEf0YuXmNIMXWmB6i/racV
   cRM/K/4ciQWVPbKNHyEajHXkbJLDE+aYxDkP46vihuelNwXS3dkIbCULT
   npdIF3QyoMZ9DtEStW1vtoKmBRl9diTOlT46K8x047YdU35ScDTfO9P0Z
   LNPgxC5coFT0itOrpbbsGB1y7V/zUh0ESZ7yYYKRG3v3/Bn0xvh7cbF8c
   g7W17++bBRj/n+G3V01TNydXM2NzrszouE2zkPYTU6D5FYSejpXcnEcft
   g==;
X-CSE-ConnectionGUID: nActEvhBRUWJxAfZ13vDNg==
X-CSE-MsgGUID: qnc1ALqWQsygM89c5xAW+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80325513"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80325513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:29:54 -0700
X-CSE-ConnectionGUID: 4KpyqNHhSo2pyDsIs2DUyQ==
X-CSE-MsgGUID: +pMADMxiRead/30Fo+Wdpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239446476"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:29:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:29:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 04:29:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9iWLvFa/btRRJIf5G4usvFt4pInXJkK3MEYNybpkD1/tTNEmNxrBvrRP3KktR4ckmmYsipiYtA073vrxMW+oUw8yfmzCEDVUvVcozlR5ZIF1rhf7/cPT6f8+PbLMREGb93Wy6xwlnGz95WIlY/hctvRSYGHcny2ZM1rEbJ900uhAO6CBrFX733Td09zzGNJb9jmwdRFglWDwwmAIhHquzUQEmh39/Hd4f0pDCLR7KPJUjWAYlXt9Y43trw0f6zOM+LA/lu8tLGvEusMTk3IzoDBNCvUlznY7PR8bvDQF8j1OqzjlnPnOPw7uFiaXyKZji8zSHDVYulUkiLgspCFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICWBoiTM5S52qIW9iH9MMM5GaRXSfQAfuxn8c0goMLA=;
 b=uymLx8jvDJ4+0Niir3czUWmhuYBCmHLzD+QSPgSPBi4/wkXz6uK780CM76eWCMPKQyoWGm9/LVVKF65NdCejy3oiVE0Ttiq4r6dxpZOYldjMzdk5F7taZRHFgpx0sUR+eL8lTrQs4dyP6M4o3ox6YvdEJDXXNSJxy1xvlGIBwCeFzY4t68RXbI0k9wJYZVIKDafKylbd2rsfm7zv4YYLdfg6SZoPQD5SmrKX2Y3/rGm148wnq6CHgufHW9HOotrnWeZvH2wTSTmCy6tbnzjeFj4Q87PPAOLDYEQlNrCYzb0Ge7OSdX/r+YttI5xi+JeXbNDAL1htkVoAP+dYA43guQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DM3PPFE8B1F622C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 11:29:49 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:29:49 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "mensi@mensi.ch"
	<mensi@mensi.ch>
Subject: RE: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
 otto_emdio_map_ports()
Thread-Topic: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
 otto_emdio_map_ports()
Thread-Index: AQHc8lClKSNKfd4ZokaU6Uw1LMh5rrYrAeVAgAASk4CAAAzW4A==
Date: Tue, 2 Jun 2026 11:29:49 +0000
Message-ID: <PH0PR11MB5902382887B38DAFA0F77F5DF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-4-markus.stockhausen@gmx.de>
 <PH0PR11MB5902AC16692DAAC68542A76EF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
 <013401dcf27c$8fe15cd0$afa41670$@gmx.de>
In-Reply-To: <013401dcf27c$8fe15cd0$afa41670$@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DM3PPFE8B1F622C:EE_
x-ms-office365-filtering-correlation-id: 2875ba08-25ed-4ddc-8fc6-08dec09a41e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006|3023799007;
x-microsoft-antispam-message-info: Qj1Ir0I8yfDJgLkdXdoGbVH55GLmZHMf0IDYJQ2YKQdADzVgj3I+jksReJLicEEytaqx6d/F3akG6coi40xhHVCNuZP1EQ4GRdh2aIhMVPDCCi3vPNmN5b88QiY/XBEwnHtwlYbQZTOFElaOQeghYApl4msrLByHsfkHILBxjMVKBkofwaaDDIYY7skezU+W872xBRABHm6EXyk02mHopq53lhhBME4JzdqqvNpGeF8HwZQgyWkhwFia+Lx0keHBGETOOOeGQoj5wxUH3s99ZSDBirF7rMvMRAFc46oUXEeCjOsXVT+0y4W8gFCCWnfv5r87S3AXp5i4NsFNQBf2JrPQfMXLRRB0MqWVJUfLdqeLzXpxBfoyhDSYxxg5qU4Q8KLVc1kfMSvXv33XQUq4SkvIcLmlajKzeFgm7Ei0pF7+B9Msl2ICjPY3ThP6FrA3709CoRlMP9SsXUfsojEIYZ51Le8VQyb1+MYIChk+SJIQU5woPri152XBWTmSwlf+X3uGbRJ5AzTxkBTmrJSdGkvXCCw4O9zU/0NR8q5TUMZzsmhWcu4ORAo9Rf4nhUu3xx5ExyJSbNu8WV3Ot0QBPB1uJx0zpHrX3i/fw0XuyXx2294pM8BJS7RKBv7fB75nGU8kccaC+vGfi3oEcCcjQyhsiZ4WIZ9Bfxld0sp0u96Ni8NjAeodP1HiYZFvIZ+qWa7181AwRTFKpHxKAOya6QXsVHS/K3wp1bovePXJwd0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e2uWvFDjmn4SgUpgooTRUju2/vvhJhMfz4VCNeSWhnWzkICIL/ASVRZcC/bP?=
 =?us-ascii?Q?zleedjbNFwI+R4wtH0KyJndwRkw6ivdxhV5oomZ24p/z1fP6G5woWscWzBnS?=
 =?us-ascii?Q?OFaT68aSFv2y3e9y/hTowgt7tonQ4q69fLatA3x2r0ixbVti8aVtTs6MH7NG?=
 =?us-ascii?Q?qs6CfORsevTAxcjDdTNFJNqbIIdt2S5obiNYTG+UJJKj/Tp8tT/fgZkoBw6g?=
 =?us-ascii?Q?q/YnXLPfMZW/lO6lrSj8bOOHPg3P2qnSLsSY0Cs0AFm2n2qNIeQbhi1z0qOQ?=
 =?us-ascii?Q?SNBmpjxN9e9hdGqgXip3Lwq7L6BiVnmu8JmjgkPHiXRm/gdnkat/vmi77ZSf?=
 =?us-ascii?Q?dHk901KfsijcO+CUMYxfQJpY0KukugYLAQEc6GyL4qGt6zHepGj0BsZ3COYK?=
 =?us-ascii?Q?Gi7lxbxBL7MrRsTd+0/Vk4d6kF7lfDh4Fgli2wuXfYoeEPZRaaWn14S3kHML?=
 =?us-ascii?Q?WEy8Sz6e8a3gkI8GFILd0y5Ie4e7LdBKf2SUiRL0jrGI0gNWdvvQMPn4DJk2?=
 =?us-ascii?Q?jzAWgkGjdz1J6+P9u+3A/r1QW1kV6xPkj5+gcGgpdgoNf03TLcsbrNTr8bFg?=
 =?us-ascii?Q?/xqwass/pjjPb9wd7Bo2ptBALzaCwqFXxz3ClUg+vEYFYvXAiCDQehMiHgJt?=
 =?us-ascii?Q?RslclvhOKOsOOk7gkji4bQcpH4w9k/sS3vXCUhnFqZYUL8YOneumAiyT/lmT?=
 =?us-ascii?Q?twMQgc7zn1EQ+CNmN4TgYavSMLSJFN7HAilBEEVaWag0UoNYmG2iCLppH3zv?=
 =?us-ascii?Q?/wVpCRqoYQv2z7tCvIzZI3C+CCAt6CWt3SATtGHRGb3QFMU2nHMFBT3zcK8W?=
 =?us-ascii?Q?hG+jWxrVPj2llWHu7whPC0alFYiCoLFpYOgtb9gYjXFv/+GVRcOz6gzMkTVJ?=
 =?us-ascii?Q?mmUvkFiRwpgA312JLQUDxXqcscQjKdPobdQ7azIbQMUL9vdImsQ1N+dRLjmD?=
 =?us-ascii?Q?1BSq8jkflrC9lJ5OT7a40h/5P0gWQ0C1MzB2fIc4Wvn+4PdVf1kScOjaGMMa?=
 =?us-ascii?Q?VwZgkWRiAcjiq/u4qgpeTSGm3ygbAe7suXDihoBsYbXyTyTuf/HYX1C7q4/P?=
 =?us-ascii?Q?+YyJJy1Gdp6/f6f+HCbU33Ey/ZAb+Kj33CFsIf1OqrNnZKhr9wePADeYjkmR?=
 =?us-ascii?Q?QNq/saR01xrK9WGjvv9cbQrdyQaWqelJG4Duw/oCrHFzjj2iWb7c/Qby24gX?=
 =?us-ascii?Q?F8EZ6A2ZLl6qTNnYc2qmF4cXTNgbbNz7NZF8QHyhQ6/F78KPXcxGm8zBx9IR?=
 =?us-ascii?Q?V3vxbZ6Boc/UnSChPOJ+o+n3B05evoO5DnSnIsgJjgn0gxLI/5uGJz7ZHCr7?=
 =?us-ascii?Q?ZlPVIXqx1swLOXIdJdFkHhzX+Zf124lFq+Pbxk2JTCih45mDgXNOZm+vfaTT?=
 =?us-ascii?Q?guv4j/r12+0eHF6o7oplmBrPxIzGzBg5+Naz0cZAKX3YbEGkuyyn4KRiyw7t?=
 =?us-ascii?Q?sXAQT8521EQsNCJgutUeKG4cd53rIHW15zf52UiVitnPWfTSf7QUZJ2IpwrP?=
 =?us-ascii?Q?0h5T1W5JD9/cGlAwtJA1uNYJCMpZGrZs5zlwW5DQdo/dZ7CfA36/rim8KV9Q?=
 =?us-ascii?Q?G6c+Ptn+nJhpI9X6QTNUAYydoJfLFz/7I1U7Alc1bgT0/tjJHrudccu2tKaB?=
 =?us-ascii?Q?NUJgIBstV5JTU1QBIZ/Up1VDQOB4tlYAssFkXRJ/QJdK7VlK1ByVb8eXZM+L?=
 =?us-ascii?Q?PDZD971sm36j2Bso/VgtCAvUMEpt4w2nLD168eaC9kpbVDI106ezq6dm9fUa?=
 =?us-ascii?Q?C8uRovThLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H1CMKEbyEH9ok1XZGDyvpHffYW49YxTvSLXjbGBju41aiA6pL+4DfJwd/nzeJWMgqErkRr17P0o5efoZuLJWLSRAQ9ifESPcCtDvHh94TUvrN17C8UrAFfVsIkACar3CcyzztmWKPkGQWj8Ezh2C1ClchuNE+ilXjz8MjV30eLRhaLZNQzwWsQsPyLRgRwTmwP+g9YWAsLlecLdufnz180MN4VjQU7XcxlMJ///4Z5y4VWPZTa+rUyMAFLWIllP1vvF02ai4YcB+PXwa3P7jo6Db6gBSx65CJxaf/UreJXem6LFA2z8ck3iy3ScMQl1JaQFpeULxDHYbZzNsoVyblg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2875ba08-25ed-4ddc-8fc6-08dec09a41e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:29:49.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kgf3G8sOMuKPD7RM5HX6wqk5BAw0alYq3413oJR7yA+ET+D6tBLRxH552LHTsxGG/Cr8yHdGqURIYRtFnISo2KfabPKIY9JNedKZBBGXzAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE8B1F622C
X-OriginatorOrg: intel.com

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 12:43 PM

>> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
>> Gesendet: Dienstag, 2. Juni 2026 11:38
>> Betreff: RE: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
>otto_emdio_map_ports()
>> ...
>> >+		if (addr >=3D PHY_MAX_ADDR)
>> >+			return dev_err_probe(dev, -EINVAL, "illegal smi
>address %d\n",=20
>> >+addr);
>>
>> Could we have more meaningful error code than EINVAL; EFAULT perhaps=20
>> if
>that's bad addr case?
>> what do you think?
>
>EFAULT seems to be the most unusal error code here.

#define	EFAULT		14	/* Bad address */

But yeah, EINVAL is still fine

>But looking at other implementations there is no clear guidance.
>
>- phy package uses -EINVAL [1]
>- ax88172a uses -ENODEV [2]
>- altera uses -ENODEV [3]
>
>> Also - is %d convenient for printing address value?
>
>Will take that as it matches the other MDIO outputs.=20

Sure, not insisting but [2] actually shows that hex is used
		netdev_err(dev->net, "Invalid PHY address %#x\n", ret);

>
>Markus
>
>[1]
>https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/phy/phy_packag=
e.
>c#L215
>[2]
>https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/usb/ax88172a.c=
#L
>213
>[3]
>https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/ethernet/alter=
a/
>altera_tse_main.c#L625=20

