Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C931E51E0
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190292; cv=fail; b=LNi1o1D9A+AS/hWAZXABlYuKFMwn4DoxjEgzmign3GdRsLNzgUU+L145bRNTGMuwKebanIZQSH4Aux8N47ZxEzsxMwAkoSqaQ/kpN18BaaZsP5VZcHtKwKYmuIMw045C79nrwue33Kl/0MT+vlA9UmiYu3FcnAE0dSnek4gcimY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190292; c=relaxed/simple;
	bh=BHc146JWxKGY0kOgZDEfPclmG8hXVKF6A761lPRlNVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jvr7MtYG/ageP2Xa94a6gSRS6OJPG4ETHOfVFNwUH34PmHfq7SW6iC7hKJ4+r6hf/O7M37L+v7T9dMi6Q7xtFQn2AG6uv4jHWZsy6UKEIPguA+8L4OysIpAC5z3ilTc+oPoYtl7GOcLutNUFoW1TRc45gdZ1zQQJsCzxvdOW/zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzZp/ipO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzZp/ipO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785190291; x=1816726291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BHc146JWxKGY0kOgZDEfPclmG8hXVKF6A761lPRlNVM=;
  b=TzZp/ipOx8FJcTdLC4FdMrKM6iNk7Pfw7eyM9UbajDK+IxWAtI7elaQ/
   pMaKBUL7/SWi2cL1N8gy+lvwsw0gmpub4t7QAri7yXn11nduY6HW8pzV0
   dADZPOegY6UXyP0b3oceQlhcD5t+ffOr+JdMJAqxVjcx4Ronjx7+azw3u
   bieMSo/9QW9Q9K4A7T+7SIkIUNacNmZZB1+5pioZJ5CisFUz3yxf4qRUI
   LAYXNvenwvOMF69QzUNu+id4S4C1eOrldYz3xCIz1XboIWDhtPqIrIEF8
   D2d0H6wTtzED0Yi9IyUjLANEZzyCzzva0jFkQd2QSLIOPU0VQMORXZT6H
   A==;
X-CSE-ConnectionGUID: FXoJWjPkQu6qLGO4Y56nwQ==
X-CSE-MsgGUID: zbdh0NicQZqYZMMRN+bImA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89658247"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="89658247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:11:30 -0700
X-CSE-ConnectionGUID: nuNugpJtQravKX8jb/M+tA==
X-CSE-MsgGUID: tPrEyFxNQY+itvHdoWtp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289490482"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:11:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:11:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 15:11:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDJB2wvoBXK8lgDqzMMG0wWnYNRQSe4Q+QAd+R36hOcYfz408Z34PiQ8mH6KZ5OOcBbCiuAEFkbG6SqQ9fzm8MRHCIkbWKh5UUOVNK3NTzztLFy7K90k3g3pa3sB2WsIyG1/4nswH21j2IZ5aa5i4oRA29+XIkNf0oxMx7zYvTOEs3GiSeWgY0Ub2DdBX6Yi7oB9NHN1PjChAxyRutOoQ7/78j8un7OQ8+Z9km//NE7ue6uc9xwcsni4XrUJtNtz/QI8vtV+Dwt0BbyzBME0q80HiSWQeqfaB48ZqUK1IpuapQApMg9d14+3IFAttvdyz4Fe4uZQUxtzYdjvWV1URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAGOcdbwP/1qKp0/kZfxGCMh5lWEu4zQanLccYtVcjI=;
 b=jGOg6nABMh/0Ue88J+kdW/jYpM+lrpa2WXQjUYYm27mg3Xta2hydIL6KhGWe+vt7f8wzuzPRLuaNXOHhZtoKQfbe6Pe4x2efOzJt38bDXTUKz3B1DCO6tix717RbPA8Ro7uiNQgxnQjnChruGZURLK6gz6fhvjdglNJDGCZuKkJcoHku1A4nen+VGv0+BFayuOmSWfFpAYGpto+eNYo9Rk3TWsQGxcVrsZYgestoOmFYzvR/z6dB69+cr8E4b8YE+lS6HCudKLE+eq6RJ5BrPPW/x/pSSfBgwbcv91szpbjOA5XiHH8WO5JD6UfxAEEy2Z/dekP3a/Do3NOnN67cFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by PH8PR11MB9853.namprd11.prod.outlook.com (2603:10b6:510:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 22:11:27 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 22:11:27 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Laight
	<david.laight.linux@gmail.com>, Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: RE: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccwACn/MAAA/6EgAABI/OgAB9dWZAADCGeIABZfngqgABXDYAAABB1MoAHFvhAAAJXdzPAB7TPBA=
Date: Mon, 27 Jul 2026 22:11:27 +0000
Message-ID: <SN7PR11MB6900FFD91358B67F27D981A19ACC2@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
 <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
 <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
 <BL3PR11MB63856413FCFB7F30D30E469688C22@BL3PR11MB6385.namprd11.prod.outlook.com>
 <e1d14d88-dbe4-4e15-b794-6277f9df7e6d@lunn.ch>
 <BL3PR11MB63853AC8E50396A1B95E127988C12@BL3PR11MB6385.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB63853AC8E50396A1B95E127988C12@BL3PR11MB6385.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|PH8PR11MB9853:EE_
x-ms-office365-filtering-correlation-id: ca9b578f-53a9-4054-389a-08deec2c0140
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10070799003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: dOttPDEQxclMMCaFpWmORUvYiWfgPRAKBrHzcu5s6cMyxDcn/mBd4MdsFkXNQD0TL6sOYgASt3KaTz5/j2F7vlqaw0Yt0zngm0YkAKaPjb6VVsFaC2kh1IQklUQuM7uP/bPV3CQCUBO1KcViwJil1Yt03LU0uyofKj3mtj6QwpSFgBsdWuR2WeKXaUhQ93JnAfIlj5DpHulQh0RHhaeIVBJztsPXZsgjcqyW2oG+rOL6dsnR78Ory0c3TdQcipGHq4RVfefojltbZx9eLMTQJ/aagl1X+Tgo+GK6oaQ/YYxy5zn1/pNDYUheLs6yckwgkGXoKqYppSygqradUPwgOcdaivkF91SHhghUFo6cHi1/yU9/oztRw3gVkEFEkwMx9Oq6Sx100DVI44GL2HFIovkC+SGrVYBUmRfahNahfHnHIgCCMg7Cpa8erzwqYkl5hv6O4zvTjF4b2pe61XTbWCucKavUZfblexzYwUftJXuOdMu6yfFXGfU5gCno0OfQDtdBG27WSVloFwY4yx0IxN6P3/vECp94+WW05kD/7aHmJmdcJYEF3L6C9Cgd6ItMdVx22Qb8gQCt21Ue2PBEyTq8DM3GjTt4CTuPUONCWOx17frOD7XyEW2EggV0o2EUcHVUpZTsaDkdKRdfmiyBHQtjziSdMPoMtAL0WU78QJNdTaXjFxfXA1zI/PgAaxjguvuA8gJSxsZIY6eadYLuyYxaKJOaaqOk4IqNxblW9k4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F93iDZYLXjtV6CPysv5+VJ3p49TWYBGNlG4Uq7CwJ83wJyGafxxHCHZU5aKb?=
 =?us-ascii?Q?FJpgHrNAl9JbkKsBA3lQCj8U2JBWa4670LDwJvWb4L842/rrTc6eHZnovaGt?=
 =?us-ascii?Q?M2C3FITB0MVV3vlpl7L05E8VQ2E0HMs1eVrjD6R0daeMeJU6HV7GfuRDd2Nt?=
 =?us-ascii?Q?QQnRYBeK5NkOjZEOUD4Tud2kkTr/UGg2P5yMbetMt/4guKAr024DieF0yC0/?=
 =?us-ascii?Q?/5xkcldaSYjQnAFvMSY3a1kVrIxtpzNXy9xTLiGlnfVARpTZaxe7iQy1ICLi?=
 =?us-ascii?Q?Dscji/ORE+3jZJt3gS+OLq460etFxO5hk8Q6sRPmBGi+7jpcA/g/bXdEN468?=
 =?us-ascii?Q?8SS8/n6X+XqtqcvXROWPTW3Zy76aOqfm7d6KVDoIUQjKzJqVUqKtAPAbm0l2?=
 =?us-ascii?Q?/plSerJ2E1S/219uh4kVG82zEkWeIo/WxMUs6+8XExlmDFkUp3isxJfBIaIo?=
 =?us-ascii?Q?ZKcRmBS8lDVwpmAYGi3IXbKkMXoZfH7f6mG362jeFFYrq7W8YW6ei6WVdPz4?=
 =?us-ascii?Q?ciwJZC9PTjmKMjOzDjEyxR64TsRTButQHVKmfMQkyLzjSPEU5M+vjmSSpgQk?=
 =?us-ascii?Q?HffqUmfhZx+YGSnWHmNHCHH0NkCWrjsOp3/j78Bh27tOj7kChiNsbz9if/Br?=
 =?us-ascii?Q?DHXe9isQjN69YmstnDznhsVY6QjTBhqsE2hH6f7hepPEUQEi/pOe0dAxYL3s?=
 =?us-ascii?Q?04l3cnfT4EcAuFbS2dkXQ6rm2co/VTfeBx+UtqF1g4ANCJi6TiHULRAwFqVk?=
 =?us-ascii?Q?EE8Dd4w2UGZRuA8iSldkiUkjXAv2l1aoGrwbVhDhRURILYM9/wP6qteWnKFF?=
 =?us-ascii?Q?WNWcYLkW2PsbxJzdsP/hrOQV6TF2OpwEkbCykkDb7aEdnBfnX/dSVvnuGisk?=
 =?us-ascii?Q?wueDoj0QBIF5KLGzGzcVEzj7lr9HI94Mr79Gy+PbsL+nesf+OFNvKt14Cd+K?=
 =?us-ascii?Q?KDNfIhDxhmobw6Dip+SUBE4gR0pI15T95JwQNWQ8lxjJsLguni1fptCIkWWk?=
 =?us-ascii?Q?Vps8ul554FxkomAKkQVczrI/g8h7s5OtsQjwW2J370SrVdy0nTxMppOxD9cN?=
 =?us-ascii?Q?i1TwVwgqvUIyDhgRPpRq24UQwtFAWArbNb3BO/pFoLD6MChaFwFEKwHH7uVd?=
 =?us-ascii?Q?hAQ1fra9haqbbG0q70x6ukKRYwcVeuembs9tflcLiNoWQmdse4Q8OyLDr9eN?=
 =?us-ascii?Q?sotQu2bBdosyKsLxo7j9JTUoQtgrL37dQexy+/YyX0938vzTXEkCuX5KWzIL?=
 =?us-ascii?Q?HPCBy3XkaiWNuWlBvYpTFngVOHkKNiLa0igimKUnFMYNXihHHmdiHs8jaOOr?=
 =?us-ascii?Q?AK/1zyok0ggDYuED3D7EbMZVm3dyeK7qIMQGFsGxGElF8Nv5WwlsThTP6BkB?=
 =?us-ascii?Q?RAWENMirZr308D2oSP1jx9BX9hAWGkk3OoPb+Cim+GhgTYsOrLo5f9mTzD+7?=
 =?us-ascii?Q?TvVvc5UpMJaq3QWdVfAGuescptemI3MCWnocsvtrqoJqSJijuD3TzE9d6gQk?=
 =?us-ascii?Q?G2WuG6rUJubmJnsU9IWPkvmeZrJkjpHg0mwMR+e+ccajX6+7qRv7mvwo5U8O?=
 =?us-ascii?Q?g3501CUpXY2e3kveuRj1Bk56jPwSsCkVcIhH2dzsYEGI+CggM9y2C5qHmmpN?=
 =?us-ascii?Q?+btHkGP8gI4BIXNhSSqplwjcLwgyClt/1QE9U5eGrXpMcFr16r0PD3XW1k24?=
 =?us-ascii?Q?7fxNWstahIpZ2gh82CY5flXw5UfBEyQZL/Uwz5bhLKTtkq0dRE0ddnGdZUYF?=
 =?us-ascii?Q?grxVaOrGXhHXgq6ARc3oFQ1H29Ny1WgLZQA9ld6S2OALefy+n1ct4TNdU7lb?=
x-ms-exchange-antispam-messagedata-1: TR4u9n5xZyJ4Aw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QQrVwfkrzMenGGHNJ497me59k+Z/adrI1k4hE7EFm/fu7MAD92aM4NY0+tDnbdLQb2Uqt1GKtVDc46d/y6kb7sGC7zmOXHJx38hUz1UvqlC3ZyHMChFSH5/SzvYU5rv5B9FRmSbCsJRzkcJJZpaQX2dEMkiq7WuIz3npQnSIKKW7U3kC0zJVrlYDslRwhcCJjKILcb4K0ly7qNPbS9+fDij+2rmHWnKa4aRjcciKavU0IyAmKGR0psBOT3IMOF5pqIuMbBhYNnMVq+U/f8TAWvyuSRb9b7xFLDlCb1JxVZPMpeXyDymcWB4gR64hIsO3p7qiEo7E082WA+wjEH0cAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9b578f-53a9-4054-389a-08deec2c0140
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 22:11:27.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nzQFXaxZL0L51YQpMlxvvRgN/M5mZrHyfXAkQo3RES1t9EH+uYI4nD2JY6NdOAFzHFP5hTLotQa1jloaSRWDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9853
X-OriginatorOrg: intel.com

After evaluating the current trends in C2C use-cases (for 10G & higher,
especially the latest gen firmware orchestrated high speed PAM4
signaling), and distinguishing between the ethtool link mode and
the phy_interface_t, we think the ethtool link-mode is still the
correct fit for C2C protocol to model it as the electrical domain
channel/media for establishing links over the following primary use-cases.

 1. System-A <=3D=3D C2C =3D=3D> System-B
    Direct connection with no intermediates. This is clean replacement of
    KR link and user can choose to operate the ethernet interface at all
    various speed and modes of link that exists in KR.

 2. C2C as simplified KR with fixed speed & low reach =3D> no need of ANLT
    The on-board copper-electrical trace interfaces are so well designed,
    and optimized to operate for particular speed by offloading the
    analog signal integrity into the on-board "redriver" chip like
    TI's DS560MB410 or DS560DF410 - like the electrical repeater

- Thank you,
Siddaraju D H
