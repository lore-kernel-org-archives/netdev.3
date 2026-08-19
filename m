Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AE437475;
	Wed, 19 Aug 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131110; cv=fail; b=XY1rKjvo2r5MIzRVuoDaF+tdo757T1EM4MDXCqnzS5BNVYvqxtZ/fgbYL4qVsU2+N/AVKVWGgHmgH9QBAaiEUclUTcbQ3vzKwVUqVSSa3rxKmx9KNwkOJkV0qAyMR+Nhyuw7+4nxe/zrdrAZuy5nCgmNhLGjAfWZWHrWHhqvK1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131110; c=relaxed/simple;
	bh=tHdMpyUpMA0Pt5Qe+iOXjRAdTgBGecNlw4ypeSq7egM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDnz0AuA9q6pYVj/JqIEblr4Nao4YK2gCcJn8NKDCj0RJ9R4vHoW5H6lC5koqnqDVDSCqIi4/fTXQJB/TlO51q7nhm1THFaf81huuzSaYl1Hy2Y3J1ngk+YXtw7KOZtehm9CB26Xub3zxG9h/Mwg6aZ2yQ1a94FN/8VacGJWkuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxIVJ1vL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxIVJ1vL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787131093; x=1818667093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tHdMpyUpMA0Pt5Qe+iOXjRAdTgBGecNlw4ypeSq7egM=;
  b=UxIVJ1vLTI7Ug/i1ZnEh0ytSRrrDjrLat+gYQxipB2EitG3KoEitQQV4
   ZPgYNGiLoPrsl4I2Rk5GKUFyaT2ia1R1+tNZKQ2uszQPbItNPtfif3Li+
   WbJBmzY9bo+/YfMtAy3YCu43Gy5PrbTDYMJeWVLzzCoHoNlKmLgxu0Lcp
   laVK6//EUqxGC5r7utJC5i6JWKO4mAKSSEHTqKUlj2guklNucSGcm1AyA
   XlykaAU50G2YqL2HJnkowqoz3bXUhgNCL97Z6ssdUYEeuXebDozVyuojE
   VzDa2u21l0JkbXHFIM/ii3WFBgauTf/dEH8uGbbCpqmnzpnn/J2aAw/s+
   g==;
X-CSE-ConnectionGUID: 9O1i6YXqS2GjAoaNrJIwgg==
X-CSE-MsgGUID: 69YSvvxcSiOaF/3Tb24zKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="113184016"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="113184016"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:18:04 -0700
X-CSE-ConnectionGUID: dPCED1cpR4SkhkkLyPmoFw==
X-CSE-MsgGUID: Ynj57mQCQJSd5qI16yQNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269769463"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:18:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 02:18:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 02:18:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 02:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvTRq4xsVVI087Kra4KCI9FJrrJxnPU6wQgLEJDCmA0gEm3LJ+BEJyS0dnFob4FDW55SWyfP8h3Lt4H66RoCsH4XhTSoJfTb4Fhe29ELQGvDneYuut9pq1V3k4EiU9cgFCHTfzsbqZERDiwymlZAhyqH0OPb4V/b+Kp9ao0XKufGM+aHnwvBUpMjuYAxyyRHkgSmmQzpu+gLoKZlW3a3aYrHBCEXvOiQr0CZwEIHCAmu7STbqaJVXAM0oo5V3dTGLSDRkaulk0x8JOcn6yomy5I5dojYsG/ydj2I8t1VAKrJmY4+l8uP4CZ3Hg31NUvbAdu4Z7FWS0ljE52Irwvjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gisw9utIntN7kKKlkbc3+nRDtl5rkKcMC19z16X+p6Q=;
 b=tLVyRLdTJ9g9MOU9Ubud84yAoKtohUqcurqE03JpRc35dEWzNAG7uPNUy3YTVvVMNi53Btj7lJUXqdf4+QAv3+cuiFWLlH38uegHp/vLQTN29eczJYtCZ19J7nvdyOOZyFiQnXhcXMz15CVwLW4NZtuqEmUGnCJiAvMzuvaRrC1CSNZD4lkHF1pzpgHZLHG4lQJbVbqnUdZQbOzJOs8nzF8LW1yO4A2GszV3QXNQgNWwkUELxAyGUQSQorNUER+OQQRdPD0fHcmiuDqumLkYguUvE0MTk3QbwvLkJpdmUHq0JgBZygvGic1DcjVMy4zNwMjFr7Gy1aq5a16wmV5R+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH8PR11MB9854.namprd11.prod.outlook.com (2603:10b6:510:3c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:17:53 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:17:52 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "cjacob@marvell.com" <cjacob@marvell.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkelam@marvell.com" <hkelam@marvell.com>,
	"jbrandeb@kernel.org" <jbrandeb@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sgoutham@marvell.com" <sgoutham@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: RE: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Thread-Topic: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Thread-Index: AQHdLsL0RCujSpf/jkSxKRtteF+gKrajasRggAFg/oCAAE2qMA==
Date: Wed, 19 Aug 2026 09:17:52 +0000
Message-ID: <PH0PR11MB5902FD7CDC98BEB8D8BFE356F0A52@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260818033652.2038116-1-rkannoth@marvell.com>
 <PH0PR11MB5902CB2559DB564EA0F2488EF0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
 <aoUzX2qMMDmp2_fB@rkannoth-OptiPlex-7090>
In-Reply-To: <aoUzX2qMMDmp2_fB@rkannoth-OptiPlex-7090>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH8PR11MB9854:EE_
x-ms-office365-filtering-correlation-id: 64c27863-b53a-4cfc-c9ec-08defdd2bf50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|5023799004|38070700021;
x-microsoft-antispam-message-info: TjCRm/U3hfsmxZl00/dRbIib3yt1+KdUUwJZDRT7oii0/wEKAXmXTwtorUp7p4oo1f8w+kO9m6QwuTmAttV/TvMui/5DMcxcl22qndO4GLI6Kl1P9Dj/BYwKqkvT5ATDUokpElFCTLKotfYyERxiAfFgx1LIRjD99Axdh4Mb0Xtr8cBEdHtGdZhMZhzuU9s+B0OYxkggHWO5pZq6Ogwhtl+a6odsKB+xtxjCx5vBt4xOnR7hyhFXh0x8S4o9DWNJRbAtgU32Lb0t5ofE4Nv0eYtQ7utLY0iLA1SyriYu7aYLYyPSTxj8/vcVWqQDIdf2n9YbNwESWVjn1V7kHx9Gq9glUOCkOI+cSZplIiDbBtoPxw2lQLqtuD1XN2cANMtlTL8j7ikIJzyj4j6LPSrwkA6dBLPx7yHOShoT1GiHXZMtnpLu+xjOvCrj2LF4CbbTlh0AWhTA09YQo7zltJrmcePMl5pLJ9lprofEzsT8DyA69TCeJmNAleoIfCcZjOtINnsYxHryetCIH3BzGr/AjDV50Xnp1Z5oDViUITJNb5c46jG/d8x0qedvCssGodQRNlFoz7UoM4RkjjiJPig4NRb4Yg+VjjpjrWAJKx3YOoMb3H9fgwc86JazRyUmr2PPokjghHoOVu4TdLuwKzYvrEKUjlH0td27Mj88Huhytl3oBk/1yoN5HLJcXSMXxfc6zTLS7mOZqKFjGh4cRsEb3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oAkbrSHVs2lloXliwVzrGStJfFSA5bgp5wUrIXrYvVlhpqEvhGEV3KWI9qwl?=
 =?us-ascii?Q?9pefM/10lBcw2waEAj+tLNbmrFxUFhPXhKn3VRrzAPEaFrOKMtm+jtBtkacy?=
 =?us-ascii?Q?iUGcW4qPDEUgW+67raCYlokLyDFVUBbW7QQUEIO6E9zPVjzHvX3qqluKNN5Y?=
 =?us-ascii?Q?U8e/Q4ji9DfiRcMBLeRQfyaWn5wjLujCpdDBrNPULuEEK76iHNafxfgF8HRl?=
 =?us-ascii?Q?uHDt0VuffSplBWiiWbLBDwtJJr4rRC14AlgZMnVCvA212jHs6xt3ANlU5Tbf?=
 =?us-ascii?Q?C27GW5BTJyKfVZ5zSg7VQ7JUyKCu+rnofENjs6UhtUcucGgL9BMzDyIQKyRD?=
 =?us-ascii?Q?4JPQpcw4lLafxf9hVoRzSfsic+wlmdIrCGCRtDHtllz15bxqDge0tSYAl7HT?=
 =?us-ascii?Q?rZmx8GrI2lGT4+7RO/HoMKhgAH378odfRWYFbsen6P89aEOJ3Ow5f6o9YSIt?=
 =?us-ascii?Q?CydPgBzNKwGgn3Cj4eUo2JzJe8U03JFimNmJ20DzQKliykUxh2EhaE5rDTNo?=
 =?us-ascii?Q?y9l4QqaqMo1fEjis5soll2I0r15GDHaQvr2rwvnGDnBRpPdQECtKL/A0/5AD?=
 =?us-ascii?Q?9uQ0/3mopAELbf1EBraLup7BlwnjoTnJcRow3G1XFtAfzqnCtkcTJ7l+4F8C?=
 =?us-ascii?Q?GDe4gT1mYZI+dvD/5y74HWoiuT47HsWQ3yAKcUKADThrYreIIdNnbNxVESdj?=
 =?us-ascii?Q?K9D3MbTWgMBJBWuKX97OxVBqQBNoW4kyp9e1dC/5C2UKcn4HpZuLJoVvXuxf?=
 =?us-ascii?Q?+8birh7C7hlpjupQdw1P1cmmO8K//GukHubuccDBTpgIBNVrvW9ugQZZczeF?=
 =?us-ascii?Q?5cmeTUhpsJTR1V8catDC0vDFxVuRKRxwarCFO1NNBVyVnRxsIY7W1C/P2k5Y?=
 =?us-ascii?Q?QgwN/esBWp3XMhpFnKykjZ4bQZpHrieTYSMB8M6mgY9awIsCfGlR6KDLdw6s?=
 =?us-ascii?Q?BgeupdKXNTdwLzN9iq8keMPHrqTynuk2gE4YhEI3014Sj1Nk0xcjnkvcocsA?=
 =?us-ascii?Q?uhT6wG87pa04gUInTYNS7Lh4cuC4Dkj3TeBlbxCpYAgO/+SufBK5FMVAh7uW?=
 =?us-ascii?Q?gwHYn5UllnqRrMXYCPglY/v7G6oQ+d4HdmCppGkvHTfvkbZTVsRKaJkJSiRB?=
 =?us-ascii?Q?F/CqN8SMf2+H7cymr+/ay7UPAYykPiSovHHhms8wEsK8xeKO0ii/Q3dqv9PJ?=
 =?us-ascii?Q?LINfSvpYP7Z+BUJQBBA2LzJe8kP/6ZlMM1kuDKdhSOm4kM5AbZWlo5L2EwLP?=
 =?us-ascii?Q?PytctiNTZqzZ5sGnpttyzjTaJuEgbtl9Z4R0dbsK/ZQ6ZVZWvNwS3S/KSOaF?=
 =?us-ascii?Q?1u3M9qvp35HT3VqlKNrr8/Q/s2QHU7jq2NfwEjV1GSL19gKXce2Y1l4mRNL7?=
 =?us-ascii?Q?X8TwhHu2CAxdhZglT5DeEh0zzUf6RFnn5qeJCGMKpvbXx52R2Psozq32Kd6U?=
 =?us-ascii?Q?wzqOAhepV2e3pJIwXXFFeF1n24aolrtG9L5B6rHQcT8kIEY29CFlRIx47eg2?=
 =?us-ascii?Q?C4DqSHvjzKCvd+IVG3jGGBKmJb2ILKtgfyPqk/utzvTz6HEqDNdtKgwGnkas?=
 =?us-ascii?Q?Rge5d1b6OZX3ID8tjIYbVnGw3H7JZfDNb+u8hO2Z2kTMK/0tzl4ZJywLLiDF?=
 =?us-ascii?Q?fG/YjzB9f2jORuYJ2s7PV9wrQrHQf8DzJiQgvJ6SSWX4q4Ap30hFrHaP0DE6?=
 =?us-ascii?Q?+O5BC9ANyIS0DJ1dxN9hOUr5vKUo7Qd8SoevNFln/RWkkU+guM3iS1J0ki7d?=
 =?us-ascii?Q?MXmXFSUr/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hAD3QFcsFfd8GajgtYxqnURa+DdKIFXuOd++Y+v77um/TxSsap7SIFQ4yq3lkXJCHjVaqfHPn/l8Aj0rdcG1EZT8GdMpv78PvTdrziNKOU57PzSqCYezkArFJRCqxkU5orrdTKrgtJidl+JsEXnARZTAijlDhzaShHTMQAIRKrjiUqwpXEVNqPlLLbsRonDqONh3aF8zgAKOBOJXTG1yYy/bYLoztjwdtZhQTLS5MRSH8VtM4/LtosRHL9GkFfYQUpNV32daGgPcSHVKjnpP/iurkz79mSxzo3tMGH+e9KkRUajR4OufNdeTBeQNjPFNdEYIU2Ru9n+flB5/krV3Xw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c27863-b53a-4cfc-c9ec-08defdd2bf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 09:17:52.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hqY4ORrfgUBtKl6M8hL9/7caNutbBVPA3Mns3kgEyUM27XP6aFc7m7NRlfKtAFIvXbRN+NV/DtwF9jOcV3s+NI8R/7zrBSimDOSioOvBjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9854
X-OriginatorOrg: intel.com

From: Ratheesh Kannoth <rkannoth@marvell.com>=20
Sent: Wednesday, August 19, 2026 6:39 AM

>On 2026-08-18 at 13:08:48, Jagielski, Jedrzej (jedrzej.jagielski@intel.com=
) wrote:
>> From: Ratheesh Kannoth <rkannoth@marvell.com>
>> Sent: Tuesday, August 18, 2026 5:37 AM
>>
>> >+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifun=
c)
>> >+{
>> >+	int link, blkaddr, count =3D 1000;
>>
>> count can be declared inside the loop as it's not used outside
>> same for regval
>historically the Linux kernel required declaring all variables at the begi=
nning of a function or block.
>
>>
>> moreover defs instead of magic is always better choice
>AFAIK, this is not a magic number but a counter.
>Could you show me the Kernel coding guidilines which mandates this ?

naah, probably i cant but what im saying is that what imho is worth
not mandatory
at the end do what you want

>
>>
>> >+	u64 tx_credits, regval;
>> >+	struct nix_hw *nix_hw;
>> >+
>> >+	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
>> >+	if (blkaddr < 0)
>> >+		return NIX_AF_ERR_AF_LF_INVALID;
>> >+
>> >+	nix_hw =3D  get_nix_hw(rvu->hw, blkaddr);
>> >+	if (!nix_hw)
>> >+		return NIX_AF_ERR_INVALID_NIXBLK;
>> >+
>> >+	/* set TL1 sw_xoff */
>> >+	link =3D nix_get_tx_link(rvu, pcifunc);
>> >+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
>> >+
>> >+	/* wait for link credits to return */
>> >+	tx_credits =3D nix_hw->tx_credits[link];
>> >+	while (1) {
>>
>> cant we use just for loop if this is simple cnt decrementing?
>Do we see any advantage ?

if something is a clear for loop why make it complicated?
again, not insisting - just asking

>
>>
>> >+		regval =3D rvu_read64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link=
));
>> >+		if (((regval >> 12) & 0xFFFFF) =3D=3D tx_credits)
>>
>> FIELD_GET(GENMASK(31, 12), regval) ?
>ACK
