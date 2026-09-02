Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F0377A96;
	Wed,  2 Sep 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365331; cv=fail; b=OdWwG7/+8TJB9NEiCGLPFSKbL87UmhRQDI1PlQtMhJ4L87rP7qz4divqWDWnkgwCdr7VzF4pfnPMtapwR/rpv736XbY6ZWg9h9G6xwwXwB6WFyf9eiHnLyac0CKK9SYwWbHTbat4KLiMVOgZvWlmYjRyruQKMvbJ1GH9dzFvct0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365331; c=relaxed/simple;
	bh=fSRK2MyD3Y1JAUNq5hStC2Ts1q1b02n3wqjkjPPLEOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbcqWcfFQNME2WyQ83S7l0paiYYzpDhJksieV8Awkny49TD9KQ9G6ec4+McKENIxBkrY0YZWY0Xfe/ADcqq5bkAQ1VcKROXgEVjrEW7kEan5eparyXn4MzUTvMdoE9Kw3eBSgex65Ox2yu1tGMrsU8DQ8LIY6ZW0AgU5TdKi46Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgA47Cft; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgA47Cft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788365329; x=1819901329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fSRK2MyD3Y1JAUNq5hStC2Ts1q1b02n3wqjkjPPLEOU=;
  b=RgA47Cft0UrkrtIHpwBmzuUj8tzUDDuyO1Stb3Z6mWJm6u8a/ALxhojg
   iGcf6ZndMbNe2T67loLLoIL90zU3ZWn+OtQ+N8OTsicFilSv7e6qEgOKp
   yEfUTXMMC8wV8Vheuld51vM49RjdymgGG+ZTA/Quar5Dw5jJ/hHy71U5Z
   VKsYPoxzWncqU7OAxiCQ8Q8rLtsPHJh5YULuP+7tN4Wz1+VbKjO6maSxZ
   6jITsbhOY6tV7h0ZqIW53ygWyVE59ffObfXo9ural5JwsKrrsacilDVtY
   zMpjAync35CZA7jBnzgHpAyv1EI2+jk9w/WGolwVN3O2khYNqjuYPEgRb
   g==;
X-CSE-ConnectionGUID: YVuhtCGxQoyM8fKggc3PYA==
X-CSE-MsgGUID: J1nHGtEmQseeS3DrHKt9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89039138"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="89039138"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:08:48 -0700
X-CSE-ConnectionGUID: FQp+BExXR+amUMKYZ9MHNg==
X-CSE-MsgGUID: go3MoRUGQeiub+bDHAypvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299321087"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:08:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:08:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:08:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRcoENxBE0nlvnOwQ/l2WUJdEkoXn0InbKAESbBfuEbFh1KN1ha9Wpqw4KMva+noiwbA0CEkRUIGwDLpR0oSPKmcjNkJEZEyssiqKsOK7PxQUwZM84LiPUhX5lj5tvR2Yea4DKfQwshN+Sostd3RWKUxVoNqHpbf6Y5dn8nIbr1JOa9SqQok6RuuRKZmcCdO2ea3tTukTdyG1HP2RAsZThnSardHs+KMM6W4yvzOzgERhTUGicjL3LVRhe+kI9pTqsP2W3hIHLY6vztFaMAeUtJXTO/G7wF8gSZsj2JkkYcuSw/Z2UjwqvHcRvqaN70VDlp0TyV7ZIkGGhn564HtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8RsbM5unjDporY3ERvV2PvfbxuTTafEz3aqPX+36Vw=;
 b=uqXQzEgmQH2WS3Y6eLacRsOApCG81Lo8breCvLExk/KXdpPdynKMg/KtIddlUI4IEm3JaSxqGGyReUrJNsesxkTZSx3PudBT+CeuJbl1mSVH0Dl7NOmbHpAaHLGzckQ15wiK2cLn785ZA8iZkHOK667clS+5eosPlc/h7SuxbWuFOVlEK5wHoXGi7oVe+MngoWg/iw+VLLugH7nkUuAfKXYWVRRc7srY3kIqtgahNSNixDU7RrXgs9WcZZdoH1K/aB29Ty8J1TFh4o5hVawnHjBys/USZXmWvwkYIJcSx0iRmoWNRVlrlXrcj1StrvM4WpKUVnQk1IKKUCShtpf3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:08:43 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:08:43 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v3 iwl-next 1/3] ice: monitor TSPLL lock
 from PTP periodic worker
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next 1/3] ice: monitor TSPLL
 lock from PTP periodic worker
Thread-Index: AQHdIz0LkQ6MApPOYkyoKerJWosWA7a7o5sw
Date: Wed, 2 Sep 2026 16:08:42 +0000
Message-ID: <LV1PR11MB87909453CC6E1C6AD24CEFAD90B72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
 <20260803113507.1858083-2-grzegorz.nitka@intel.com>
In-Reply-To: <20260803113507.1858083-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: b8ce2d4a-fc69-401a-4777-08df090c75d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|22082099003|56012099006|3023799007|38070700021|10067099003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: PArCgSg/b2Rx/5BmZ7jSCX0hUE6uUPnYsZsE8eBbwHpnwj4D5UX2xBzTCNE47Wth3qoy37v77EmM1JQB8Sj8G9fFJHu9mB8/9BSNCbiOx8kRZB9jgpA/e2RzNGoEyeiBVL0b3bluUvIYvGKZoLa97ivMVXuUzp0JVA0hjbXLMflhJMbSNmdAkj+/rCOogTGy5o/gt9NgECTgV0KHeuoW1eFuRVIzdE6eVx/GVMqB/QNsBPFvbsO1aY9muGB9tIfATJJZ7n9rAI6hZIGBensDc+MTLgajagXN9emf468Q3qiGFIlTs2HS0mRwzb6VwothS8NJjgzsr6PjsVTOBpWVFOnTD0qMgAjTRVPL+QG3S9Ro6c8dXqRuviWqDUYdk2hZesyMUY8p6HqcG237a2tW86RYDBz1vlDpzszuNhOE61KBoUydmYivyKQQpScUNMP/R984Nj+Aw21OFaGAZMwX0KVilyAeoHfywa+a+7XQ0EF63F1ajZWlTGQxiK1v556a49QLAPJQyqFlLf8kqDHAxC1n7kmXNgCLmrAsxinmxH5+2lUeAJvbjj07chrD36RyzvDPmTt0IsnHgjaLlw/JtSXrhcJPRSOH0+ElZmZLVyQ8TcBqYFUgWuW7SDxLkAis0jPbT0UI5m8qPvP4qitnpmJ1+AyQlCUsdnUZasxjuWyGv9rRbtrJ0xEl0jQ2sVbXhEiJk4NmmH+f1IKLwoHCDS3nhHTJn4gdJHaCx5q1QEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cq2n3SymvQV/jatMLkoj2tTRHFnVsF7JVu0ZO5DCIgwQ6L4co+/z7V/DPs4B?=
 =?us-ascii?Q?MrjK9ZQTbIE/JS2WsIWeHD3NatsCdQZJZwrGEGgN46irA+JwZ3ZUbuZ3fe38?=
 =?us-ascii?Q?nYG9jr6M/ZblSl/kjzK96GwvMkbH/JaDOqaIFjp5uDsO/nEQVJB4NuWeleA0?=
 =?us-ascii?Q?TUeiJkg0swNxvPPVqimJRMOsfs+eRbFwA837+lJ6UYF7iU7jK5ZTiq8MflmF?=
 =?us-ascii?Q?rjf2oFChQw41ZUPQ0vscsWIvHWaJB5hB0PoxzqKdtFqA+/Hl8IIh5cnHR50c?=
 =?us-ascii?Q?Psdltom7xluAuXUd+KUMSSpNsL34LGnoB5HNPa2EInkuZFD9CmZrrJQ+v5j4?=
 =?us-ascii?Q?r3kli5CJOE6AQH4gm9Npfvhj1jb830tKM2SFGNixh/wmHlpsYXACr7EokGPh?=
 =?us-ascii?Q?a4RTGZi8a28/Abjcc4PvmeWJ9g8Tm2BljXy70BKLYEwCtNcPi4Lyn8XMIeCU?=
 =?us-ascii?Q?8Em1r6GTuKbMwcneXw3Hv67vkSZXjsEjPoQDtbKIhSkT5EFrIEurVUb354i7?=
 =?us-ascii?Q?oR/PuCKA7WzZgRVK2wpWIGfM6ccTSmDlBeyEIb58yT4m924j3f/wBs/jwruN?=
 =?us-ascii?Q?bOMYinS4AjEUugwoomIekvVr4f971NCq28T2H1s+2mayLXLNn1dZPtE0ob9h?=
 =?us-ascii?Q?5GcBOK5PinNmY6p6vVJnL0fVldUnIh+iH7TvsAr8KIuhcahqyfFYlN2pJFHZ?=
 =?us-ascii?Q?6iX5RgqOc6zXbIhnOk9gam8MP+zbY4FdfgjdsyfOMSDql1LQtzvcIBbGlZwp?=
 =?us-ascii?Q?gApJsbS7+w5P5a4uiPhq6jfQ5AJ9pmPPnAD8mRZ/H8tS3QeV2yGpKUi1gAaZ?=
 =?us-ascii?Q?oonhPDdV8nnmfsgB70teXMzJF4R+ap9k5lP7ghkwHAD8DhfrN8zZRIweLbEn?=
 =?us-ascii?Q?pvNHmTo3i+NCk+819FZxR8XJteCjfDk4zS63wY19MFbynkonHIoCWxRsbVRg?=
 =?us-ascii?Q?VIWUiTFata/WRnhVvU02y61NZplRT5A+XH1KmdBODZnAWrIx2c45Hfwh9L1i?=
 =?us-ascii?Q?TViowO7yNNAWAnjv+HUfiNLau+8OLfWeC4+sHzoCE4NxRvrYuZoycECjfUpN?=
 =?us-ascii?Q?CrL2kFKC0Rh434rhjxPERafS0sWB/c3ovFnNJrcEKbbXW/xdEVtiuJ1w8SS9?=
 =?us-ascii?Q?DvPIjojnClSsI/t5FNTvJ18nk1SjhHECcv8JX4Eijy6Jw4X0KaebFU26mRjj?=
 =?us-ascii?Q?/ELnvMzAguB1a2W3Fw5i3z3wBHVi0VqQR1VKW+NYJ5PEPjkF781P40SMopIW?=
 =?us-ascii?Q?fl9eofLjjn9dHgPf80YPXppPVmUnW3LgxR6VSA0oXX6oLpnnpX3w35nIqKAw?=
 =?us-ascii?Q?LfXTLonDGwWb3fszgL4dZXpvNS5RLT/Q0VnyiVEHk6fzXGG7B0tGnQflaw7o?=
 =?us-ascii?Q?2XD2JOwSwrM8/8jQKDqnk4HbK0jpO3FAP5fb3yQ7bCoDOwD0PbSe8lJcOp+W?=
 =?us-ascii?Q?jEDlTcAhAAp3n6Decyo6/oXLbIOu/pLQ0ZiKNlr7NyRK9bckuIZMk7r7kw11?=
 =?us-ascii?Q?4ACywKQKsM666DwX3ksAY/P6IVtz3B0v2eqqi0WEde/tgvzMYB9a1CIOKtHU?=
 =?us-ascii?Q?RNFieix8qs/XhxpRxIwVVWjiN5yQnXo/pBwA5Qa3HQDbL7OaOg9CtTdJiDNh?=
 =?us-ascii?Q?KxNIHPZKRJSpg4e7zbM21jde+DLrNsZrjNkb0vIdgySYMnT1F/VeDL4j4/ju?=
 =?us-ascii?Q?1fyN3pxClV6W5p3tFWeOOHP14aMDynlNFfOuWIMt8glts5fe+VWqyGYuB6ST?=
 =?us-ascii?Q?7G2cLra3Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3hUzBCptgEbjMq2AVTiY1CBnReGAoL4go5U2DH9qIpLNMfpH9tmLjJX50Zm1sEHMhRj0c7XAC8fNFfkVZ7HYOvaSq0/Ykl+O/rQhrX4wQZ296KNj/m9gBKxkbLHKDu+ugSc+myGRKIZ+sAg0hqGrBjyb3PNxuSIdyFVhL44KA5liFO6rg3cgI0nctBkz//Ph3O9LR5Xhce293Z76eySVe8SjnHidSio2myO4HMTD/WE6sl0h3LgU+MnAPR4BDpQLQPwVgjZBPUXfRZspyONW4AQ9F0yiiVsXe6WjMU4MeLiW93rk7y39Ikete0P9vOxrPnYTScQxZS5qQll94Ta7+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ce2d4a-fc69-401a-4777-08df090c75d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:08:43.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22e4r1fPc4vevxfTqZAqIbboPCHliL+kxof4G82Kio0xdp+gtnv/94reFUHBa8ffZxUTvGA6/IfZpxu4HqQhQUTkS+kuZS/oFIzRM0ZBFX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Monday, August 3, 2026 4:35 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gm=
ail.com; linux-kernel@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kub=
alewski@intel.com>; Korba, Przemyslaw <przemyslaw.korba@intel.com>; andrew+=
netdev@lunn.ch; edumazet@google.com; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; netdev@vger.kernel.org; kuba@kernel.org; pabeni@redhat.com; davem=
@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v3 iwl-next 1/3] ice: monitor TSPLL loc=
k from PTP periodic worker
>=20
> On E825 devices that own the source timer, the TSPLL can lose lock when t=
he TCXO or TIME_REF signal is disrupted. Recovery requires re-enabling the =
TSPLL via CGU register writes; without it, the PHC keeps running on a degra=
ded reference indefinitely.
>=20
> The DPLL periodic worker (ice_dpll_periodic_work()) would be a natural ho=
me for this monitoring, but placing it there has two problems:
>=20
>   1. ice_dpll_init_e825() sets ICE_FLAG_DPLL only after all initializatio=
n
>      steps succeed. If any earlier step fails, the driver would run
>      without any TSPLL recovery mechanism.
>=20
>   2. When CONFIG_DPLL=3Dn, the DPLL worker is compiled out and TSPLL
>      recovery would be silently absent.
>=20
> Add the monitor to ice_ptp_periodic_work() instead, which always runs on
> E825 owner PFs regardless of DPLL init state or config. Introduce two sma=
ll helpers, ice_tspll_lost_lock_e825c() and ice_tspll_restart_e825c(), whic=
h encapsulate the CGU register reads/writes required to observe and recover=
 the TSPLL.
>=20
> Cache the observed lock state in pf->ptp.tspll_locked using
> WRITE_ONCE()/READ_ONCE() so a follow-up change can consume it from the DP=
LL periodic worker (for user-space notification via
> dpll_device_change_ntf()) and drop the redundant poll+recovery from that =
path. Precise synchronization is not required: both workers converge on the=
 same value within one poll period.
>=20
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c   | 70 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h   | 11 +++
>  drivers/net/ethernet/intel/ice/ice_tspll.c | 88 +++++++++++++++++++++-  =
drivers/net/ethernet/intel/ice/ice_tspll.h |  4 +
>  4 files changed, 172 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
