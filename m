Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2B3E121A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673809; cv=fail; b=kpm6a5XxvBaYROhpIf21FbEWvDJPVQfELlZ8okgubzMjv6/bMt26wjTrMLXSB+YR9Ulw3+ZDuxw0Q0QkLu9zy9RcHE1cIcmtiSey92MSi4NiLPC25KQyDL8Omlhyn4e/FeE26jkSmyRsjV54TYXlqGnWUP437vy0fRUNL2FSq58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673809; c=relaxed/simple;
	bh=vb/C5BnIEkI0yrCCQt9nx8mOcikvJ2K2dYNfn1wzUUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cl5EabT1kHN0bwZ4oUpqDmPZ/BHehaXVhvdc96h0Fr5aBkwOjrFD+DQ0kS0YjFmaO38F+BNypdN8eLt7BI4rwtlGR9etlqaJ7O4cKHA68GcSPOG56TWfGdF6jgMBwBYWKeyQ2AfiTrr78Vw6A+sCThoUIZFvZwXagS6oSLWn5/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4O0txWw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4O0txWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784673808; x=1816209808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vb/C5BnIEkI0yrCCQt9nx8mOcikvJ2K2dYNfn1wzUUM=;
  b=W4O0txWwIkPs70Obn039Eaxvqg3tKXMKb5ApL2VORi3zLyIHXQBkO7xP
   TXKlX5Heg3yVZiGk2onkBmBcpgDet5goLiijeRRUWp8uq+GYZl1bltPWv
   iFaTQue90nwDx/JVtXe0+Fkrf551i5O5ZlXXOpgNPIwjOlD8ns5MTEvO5
   Kc7d+GskdKmNHFuQUkVDWIRGsyZOeUkhxGTJYNSyedVDFoZUaz25gRoBs
   z0wzgzMTl4vK/yG/nj7gZ58BnFokCBeDSCnWYbd9b5z0nhwY9GHreW4UR
   CBsVULZalvukkXZ2+r9fLw/AEMYqDC2q5z1qvQyIOj/UBqRBgWwx3/7/Q
   A==;
X-CSE-ConnectionGUID: OBeWvgGNQkCn7nVGvijNtA==
X-CSE-MsgGUID: iT8hUb/8RYatWLWQsmlElg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96807459"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96807459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 15:43:27 -0700
X-CSE-ConnectionGUID: Cmv55R4STkO56c7MJjuJ2A==
X-CSE-MsgGUID: +kUm8cGHSqqM9vvtVWo72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="262170320"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 15:43:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 15:43:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 15:43:26 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 15:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhpQK8PD/O2lUrWCE5Pw8gbm3uT7R/W6+n8XD6DolYgs1YxrcGOvpK+yF4hHCCRgl7zqJ1nUuuNskkBxuS82XKcO0GTsELIEm4OwNHv3foM0ZZIVIF2/Js37+7ZxcJhtRqg3EqbhytjlThvIrAkEdx4aDweWNH6Qv6pSFFQ89hbP5nJZDHOf+opUuKFp6RhKVxH7g2RtDgOquQPgmw7sm1wGmGEQlKvYYUquseMjZCySfaWOw+hEzroBmrWg35a4WgULsQsd/qnaqCaPdJSpGPpCyIh6ry5mXu41Ocgp8cUeVgkabl8VBmmdTKVt6wKuOzTslX3xz96z05Te4Jwj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWwx38K8LkkfdPJUPOPi0WXZr0d+6c9FpIHzHAxn3ik=;
 b=oy7fpJ2rZEmU5BZVO+1d6l4M65UQERdVOStdz4kZa+lRsvLmbEpUVV841pWzCOUL0cV7jJKGX+5TwAN4uPKJHkx5hFJXwnjVgZig1HadXziRqzU6xlgKA50AnH9wjz4Y/yQJvz0DZ02jk3/oHMV2nAN1ET1sE3FCSiXRu/v36CjUL82uPPOgTQUPnYhJw8jIh8TJHBtIudvJEuKjIbvQQgoF6PS1iJyMiSeubf6KBMD7DPyRI5IVgC8tFFm0i5wiLvSJqM6MCdICORvWKo0Aw+8ALZvD//rWyI6spJawWAavIyh3JxYUXg3ZKIXJxomjPnBXV6xfi35D1MFoEIBNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Tue, 21 Jul
 2026 22:43:15 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::5583:6ca9:48d9:889a]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::5583:6ca9:48d9:889a%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 22:43:15 +0000
From: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, "D H, Siddaraju" <siddaraju.dh@intel.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Laight
	<david.laight.linux@gmail.com>, Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccwACn/MAAA/6EgAABI/OgAB9dWZAADCGeIABZfngqg==
Date: Tue, 21 Jul 2026 22:43:15 +0000
Message-ID: <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
In-Reply-To: <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6397:EE_|PH7PR11MB7431:EE_
x-ms-office365-filtering-correlation-id: 30aa5812-b271-46a3-eb3b-08dee77973f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|56012099006|5023799004|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info: jeXxazHreyZovdcqy9lhkULLtGbkYRJ6kF73UcENkrwVpFIl4y0jr0AwDkVIa/3LbYfhR6bpBjtJMUKh1RRo5Ka0jRK7F3NDWBchRxX+SXWOqfFFcmcOMbyuCjEqRLWQqsrHViKxAmbXTkmdgazM9bvGXY7q/Fp4wLxxJSDDqTAKqEfHx5bleeb3IjM9rUYRyXM+LVxceI34yFNZiWSpe55z2ASJruJP33R85UBpqmaADHCf7ePrUEz0nFggZZSVH25Bprn3dH511IcRGf6eOpKB1XoEtkkGILPZVvFSXaEt6dhSjCcbsqA2ng7TA4h6cTWjaN/FQWkCM66SKT9HqtBMQlZPX8ZKgSvSdbG8WZdHolmt0b66Tuwkmfvjw/Ln55eokEYuFLOz243hQpJf/odUC40+cnZzgyHffnx/wgBIDAClNdAC4iOFMRpn26WTFqM7LSsxQJ+ASfA3mGrNaDjdMLcpjL5l3z8IlE8e2RjirsDjw7KqYxufYLv70abs8R48lBNNlQ+9awmtlxtGXFLpwKseHE3t3Nl2hshNCyJ/SviWy2/oFcon69iQQcQxDBt+DGOYl0AFl9kawzDgF2f+IkJIdSLrlftcyck+koCr1ggJXES7bO78kd/OUb668WnKJC7/gsCPfOvrZMULT2uBmgBpv2bod+0mDuZVT05Nwzf1Vnr7nqYIhOeYLUapoj3PsOIBxgwm6V8m9Pjo3O1q1JhGdFY2oCsRrAVVSnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(5023799004)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oUX2bYrJGxsAdQOBDaYkG1j6pT3NJg542v0iZhkQkX4ykAhS7kaVq1+gxr?=
 =?iso-8859-1?Q?crcWRa1iLmcBHQHZgosB3IyAhwWWPDGg/eR/Rz6Hyc93v2pQOclaIHbha+?=
 =?iso-8859-1?Q?vi0EwvlPX+zC9vbv+3RNlHEzqvQNEsxcILgQgrhkx6W97KYmJWGin+cQ+0?=
 =?iso-8859-1?Q?9G3gyE7uLAeuML8Zac/Vz6jE54zjvb4dvFAmd4XJiy7y8cjEdEXE7Sxltu?=
 =?iso-8859-1?Q?z6YZ4EjZtFhzqD9h1UmMN244Bl4G22SdmxioVSn03mTVKTmUGCbXIuH37W?=
 =?iso-8859-1?Q?BthJ0oYIfRiKaTLfL99trNP52sDNFWRGyv8Eh2x9cjvuRiLRDyV+kKQy5H?=
 =?iso-8859-1?Q?rtVtw2oWDs3h2C8MOrNjPFJ9wnu6IWFeX3Rco6ETnYJnHOUgKwkwsf1xSm?=
 =?iso-8859-1?Q?crpnjpV15znn3LfBXUVdl5v/rJCA0HFzRcOz9iNtIHA/JR7xlcA8kGvJ1z?=
 =?iso-8859-1?Q?R8l1zmpeBtK8cIw9n9eaX5b3sYuBp3RTI6SHqzAcR2BdtmfAPco5lp0WlW?=
 =?iso-8859-1?Q?VQi0sJL1QRoIFSCX8M0sVZ1ndG6eHioVARKcAcdbpVwtq4L2ubasD7gAl3?=
 =?iso-8859-1?Q?Fz2P+BtMs3qtaBmDjwGAXQ5B9706DmmW+FrxJ0Vm0iXrfZXcEFr3vd1q8g?=
 =?iso-8859-1?Q?rNSxUbWjbOMhuoP9jnP3Vg8kN2GW2JLSEPJV4GPC8sFXHmo4SeUr8nIOqJ?=
 =?iso-8859-1?Q?f5hX5u7R8xDq1GeMYrIfmuh4XwlCdh82D1Ag4ARi4W8xnzs6nh/n55Rv8j?=
 =?iso-8859-1?Q?qX4WbFSnWDn7DYm5sYnxVtyNLMgCpPM+n8+yuPrw3pqaG0RVjKXI3ZScTa?=
 =?iso-8859-1?Q?Ipm1JaUYjgbyjqzlOkX5jdx0gmhi28Vab18sbRU0M1feH/RJsq5goS775T?=
 =?iso-8859-1?Q?bThtR3yMvG0IcRzyJeWYk4V53gVD2yRblbUtDUI/p8wZ9lXsa5WiHqWb/p?=
 =?iso-8859-1?Q?/aBKmOe3ODsw0Z1dbgD46n4lNw3RvWsT+eT5wKr1EsCYqdzPwKcbPpYLGW?=
 =?iso-8859-1?Q?MY1ieyXHFCG2v8JurajUZpdtuPp0Axm5ou0TCRvT9X/PXSjBczxVKSaY65?=
 =?iso-8859-1?Q?TVGz2lghJ2IywSCs05vPjnDNk4QhzTrgB/ELvlV+D4W3p2a56USu8ohNdz?=
 =?iso-8859-1?Q?jU6xQotV49gVMazuwKV6F30V4ASky5rI36ak+UPnHe3mn2aB+ucpBcxEhO?=
 =?iso-8859-1?Q?rg9Z6wZmZI15rQVTFSDPEUyokhbNpMOPDxmaQweqmone+O9tGN6MoKbgMJ?=
 =?iso-8859-1?Q?rpNQ9DivLr+9pXz1274R+AUG8ih3Dk+QCEgyEm42R7o6k6UtqH8pYpFe7w?=
 =?iso-8859-1?Q?iDsK5SlI85V7ZT0yL56/5s6usexxuOkaE8giwR+cCregKqjjno4U5LZinJ?=
 =?iso-8859-1?Q?pkhuBOmk9eylfH1wRKHEIrV9oNYCcRRJotOSmeGQm4LZ3RgEptSUKJIMQl?=
 =?iso-8859-1?Q?r83swburcehJm9Rp7WK/OIp/md8iK6b8BxR+Kb1/LkZgueKtzjxD1y74sd?=
 =?iso-8859-1?Q?WaB4ezLc0RUBNrPbElBbjY3ZHqo02LQZ6sT9bTytyQiehkS0dmZcBHY18g?=
 =?iso-8859-1?Q?FL/f1N/YhOEqJMa32iUIOOik/ek90UcIY/IyQvQ5isXQDYo4qtSGT1hghI?=
 =?iso-8859-1?Q?XvFrCp5FmvkI1tYccx6uHH+Bi3OZ32lWNWvg2OBLd8AHcgwNlJOtDCkX6I?=
 =?iso-8859-1?Q?15pQzrJvD5eTDKMSRNYGHSQEE2/lpxfFu9QZUS9N0VZycoRziWyl5zDpcr?=
 =?iso-8859-1?Q?Kq1ZuQJpbftYdHBOiQhQHe+NeBX01AXhxQ0fgGHKJpMMfI9xuXrIHfoFwL?=
 =?iso-8859-1?Q?7row++2LEw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z3cyZQqwyPG/qV0XU84i6xdqQCcurPrMCNjcErIZky/UwfUBf60o7n1HIKvvHhK5Xdb+3vSQERvhJep01xCShl7l+7GXZ+qe3GAmCqDW5yr+6YG/iHE0TfqCIMkaluD79UqXgeZF12Grtp5PcZAya4Gq1EybIOyANqzzqluDU1yuWUoiQtqk3DBqseOITiQKmjQCESFmj9HXfkjEIXiPdD+vka/qr+r1X1R1wzo7eFS86LUZwUAiW9J5swyGyR/ZneWPlhy3SdA/2jLUyeJmosqGvapll/URK42HLW23u1rAoZEXcAkL8nb4EPl7YNXuEbVWq6m5QCh7RMME7Q6KsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa5812-b271-46a3-eb3b-08dee77973f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 22:43:15.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHrM4u7l/7Hzg914tccleXOo/pQqG1KG3Qi0vYq8fYjv+s+e8mMoShH2nx/oP64QtVe0FKi/XE952eLqeYDCz8i8cyEQSewFe2yfR7q94W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com

>From: Andrew Lunn <andrew@lunn.ch>=0A=
>Given these two answer, phy_interface_t is a better fit. I'm however=0A=
> not sure it is fully correct. Historically, it was used to indicate=0A=
> the interface between the MAC and base-T PHYs. PCS and PMD either did=0A=
> not exist, or was an invisible layer, back in those days. At that=0A=
> point phy_interface_t was the bottom of the reconciliation layer?=0A=
=0A=
> The introduction of SGMII and 1000BaseX made PCS a thing, even if=0A=
> initially it was generally hidden away. PHY_INTERFACE_MODE_SGMII then=0A=
> corresponds to the bottom of the PCS, with the Base-T PHY also talking=0A=
> SGMII. phy_interface_t then moves from the reconciliation layer to a=0A=
> lower layer?=0A=
=0A=
> So what exactly does phy_interface_t mean?=0A=
From what I can tell, phy_interface_t seems to map to the interface=0A=
between PHY and Reconciliation Sublayer (RS). =0A=
The PHY includes PCS, PMA and PMD. PCS was always present (implicit).=0A=
Depending on the data rate/throughput this interface could be one of many -=
 =0A=
MII, RMII, GMII, RGMII, SGMII, XGMII, XLGMI, 25GMII, 50GMII, CGMII, 200GMII=
, 400GMII...=0A=
So phy_interface_t will map to one of these.=0A=
=0A=
> And historically, we have only had a single phy_interface_t value. Are=0A=
> there use cases for needing different C2C values are different layers?=0A=
> Could you have a single lane 100G C2C split into 4 lanes of 25G C2C?=0A=
=0A=
Yes, one lane 100G C2C can be split into 4x25G C2C where both will use CGMI=
I=0A=
(notation for 100GMII). The difference is that one lane 100G C2C uses PAM4 =
modulation=0A=
while 25G C2C uses NRZ so the PMD within the PHY changes. Since the through=
put is same , 100G, phy_interface_t will be CGMII for both. In order to dis=
tinguish how we achieve the =0A=
intended throughput using one or more lanes (n=3D1/2/4/8 ), AUI-n is define=
d accordingly=0A=
which in turn may be used by FW to select modulation.=0A=
=0A=
> Another thing we should consider. Most NICs above 10G currently don't=0A=
> have Linux controlling the hardware. These lower layers are all hidden=0A=
> away in firmware. For you hardware, is Linux actually controlling any=0A=
> of this?=A0 Are you adding support to phylink for these intermediary=0A=
> building blocks? Should Linux currently care about C2C?=0A=
=0A=
As for your comment/question about FW vs linux controiling the HW, the inte=
nt here=0A=
is to use linux to tell FW where to go based on user input.=0A=
How the link is eventually achieved is all in FW.  =0A=
=0A=
Vijay=0A=
=0A=
=0A=
