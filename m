Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DA470EB5
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164676; cv=fail; b=Niwko2im23xZC/qZbLvlh71RnFxPQtY1wMEjnI4rsxto9J69WtX9O45lI7so5ROPnlqNUQnxJRNC9ToR21WZI6JVX1r3Nbkks0I/SwBLtN+G5uL1l1WRqiHevHo19UxR5TwdNsrY/e4atIhme8b09PsTUYAkRmZNfViTQkzw8lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164676; c=relaxed/simple;
	bh=5lsPTDqyXWnzjssR3c2nRA9i4lb1rp7L9uQgiupBNsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UusttANnaB5ozcV8wdpwaxRtkzna31KCStVnFyQXUqHYTqzLcUifNB4xdOvQTqeLak8TFT7qQC/YYCsxpl3Agb+12JsPGbclnqEUXXgAuBWXwBNgivxVDd9HcCDfXQyUvQymHriJbIEOrVbGX/85CTakzDhlxKaNdlakyQs8Hm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMZlv3DJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMZlv3DJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789164672; x=1820700672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5lsPTDqyXWnzjssR3c2nRA9i4lb1rp7L9uQgiupBNsY=;
  b=EMZlv3DJF67O/zBczTX4rQyLuD7YMt2I19Vkmpv7R5Vfrn5IA2WA8dde
   JI9Y8c5QyDg3sknRLCJvAs+yAYepFnkRuUM/CW9KjOhRhHmPof0qLaKmx
   2G0Y8yl1QM9IVbLigj8ReLlKJLB7/z+McMooNkh+4ynvDbfLOE4mydEG7
   RAd+afBYhrl96bcj7RA7fs5rQV9izRU3n6pVMLuq6XmwhsBk8KhGbiGYq
   JnyEz4r9RB62r345cZeLH7Bdr2c68p4rd0qDb6kcFO6+wkIYbQlop3C3Z
   6oORcVL0pud2FjR9oqSn7XgIaou0cbL6Q1pxr8bPdKnfo7bV+mPghdbOF
   A==;
X-CSE-ConnectionGUID: 8YiecBfGSZSyEHc8ibwaeA==
X-CSE-MsgGUID: tf0FrcE/SG+qETf8woo05g==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472432"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472432"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:12 -0700
X-CSE-ConnectionGUID: fakrnI84RMWsh53KeesTAg==
X-CSE-MsgGUID: XZfxZyTUSlWrLum+8SQvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272010251"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhSIQGFA6m4inV7rSKjzAe049fFRBHBaCdidUmhdeY0t3AV+JkPzKj/z5jfUpOO3wqmQhA92BGwHkb83pRvd+DBUHFIeacxmATOmaurPMnYzMqUODzaWSvHahB6tBGbXVA76j7QjeHlShHdYJNYusHj6u3iW8SfoNzJQfXN/zzYSgb1X1fY6h2cIFYlF/T7pO+KVoOdXJ/l9EaZ5m2PWnEj4gZiMMvYPXoWjGb+0+5upfxJxy9/e6/gA7saYOhap+RX44Ip1PKOctkC1e5O2PD2TI4K5QjOT5LkLmhSihDGthcXxWOxCGdHtYANX3kdnfMzOD7f6ELh97HBDH693Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78LrgKfu0LoxTRqVirEJ2qnJM3MyrKhl1vXvsgp1gnU=;
 b=W7+E1Xrla4Ya/xEC1lBRSXiDtL8LJJMu5r5K+4SJPVGmpvvAsD4joB2SjR3z377Z2CvNvAb66k9axqa3DsCbjF9NFPOFP1UhvW/cB2cLkQEFXibWBzcAXZO+XU/m74pCNirqo2OOpXXiIAOX9Y5Sw1JDL6S8WIXrroe+CtboggrnisbPaZxFMXo8v+xDkqYbxU1vpuc85VRnZ4hRCYiGnpbIr/vydVkNvLVTCI5FTDVYA6tsFh5/w/Q9HQ/VFtR8WNRf2UTjvI0P6QXOsNIgcecNyEetkgfPQN5mnyUVGJl5632GNTlJBLHViQbqvNQV4ks8bj7hB8M31sqHWSV/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:09 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:09 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updating
 the pin states
Thread-Topic: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when
 updating the pin states
Thread-Index: AQHdOVgf+6nVha2IGEqcLWZKKAytkrbJ/96g
Date: Fri, 11 Sep 2026 22:11:08 +0000
Message-ID: <PH0PR11MB7522B2DE2A977721B8234A80A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-5-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-5-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 720f832c-4d5a-4619-2cf9-08df10519522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: S8gti6u18fQu2oRx8s8MfSUC44t2hxGs6aYPY18oe/HkfZfbSIhJnjv0l8hTV4FnsDRHHGDkwJtST4dyfJYLfRx4Ny88LqLSk+SJhyWHXDM2VmJ6D1JCclsAcD0UB+HgUxZJIIN/eBq4GmHfGO0PqSezCC6nKJy0lyEfCJe0ffmf404htDcc2SO7+zwyCho8JY43pwbhVux1lZf6mosqmPo03NqaPmVmGa6DSlgkB+uTVgWWqQ9VhbTKU6vgtTkxKT0U0hiq/hKB8w1LadUg2rL/Z8jdp6aVt6/f5x9VSYPo1sDbYcSdY54CFH5wggTl7Wlyh7syqMwYDQCtK3fJjHHrAFNkDXcMV0UYegQ+wI856uuo5VITNpionRJLs116luBl5R0pjkmdp93OxBpa3+p+3yMxw2jzhsSY5SliqhQINhYwg3PLGn9nsmHV/JenAA8mXH2BxgTMi2BeM1vnfKNkEwGf5a9Dvi48M4Ahn5DDqc9s9sASqIgapLMjEEklBgEjnBdElzKCwRyqAvyvqwb5/c9EcCxmKaPKESP17SbrHpo8/ZcjqU57vLGvz2uVT005yIh24P8SEbePneCZC5yigFjud/UBkZCi2GhyK2gGt8las6kDiPpA90YKlAVtemvmbx0wxBjiVvV1BWMI5RGhv4mGxDWvseCszMmHBn2kW0XMlUj3I2rZ9xvWqLCyW+x6XKyl6FQy+irYRgIOU2YJxluYCg4/WRkJekCUf9o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUCQt1bYynlMjFsmwnNFf3F2ueRknB6Vu8Y6WzIZjzFaJP5gKf56FdIVRkiQ?=
 =?us-ascii?Q?xbXxz47W0pA8pPJ2z5b65JyMm7mwq0uqXPkcv2CDQ0MsEBEoQofjcB8G9dfX?=
 =?us-ascii?Q?7/W943hutCib828lWlPtOmXLIIJlOZL8UN/UFkrNaO5xjKla009ZUfBTQPX9?=
 =?us-ascii?Q?BdVFWX8anA5fXmMqKRzCoKypwl/mYjNH1KdZAyR8Xmz2dTFXNBH2JJT2LGfO?=
 =?us-ascii?Q?g0Sn8qBcWDvchOvOgY3BfddKmurCA2OhbqPRkNgIDWJceZVbprQn/ANofn67?=
 =?us-ascii?Q?AsDvyB6NChB9GVRlLzGJnNsePWVjvGlKkQDnaTpy1PdxY1QjcjtLq8o7yrZf?=
 =?us-ascii?Q?fGElpuX+u+63mS7qbi4d5UY7P5JqbFQZXyC1FsNA/nMFMjw7eq+AvszfSJzy?=
 =?us-ascii?Q?vZkOxYGURm3h/gXYfOkynyjFSDzaWDQRXHSSYZQuM0h3lhXjfJq7PaZGr+NZ?=
 =?us-ascii?Q?wtRfLCvtwg3cOwvJKN/b/3274GaJRfijtlJfMLNS0GHkqZcp1tlCRHkbzHhb?=
 =?us-ascii?Q?mKsOlhXfoBguul+fjltmSMgPAo4jwmNwBjK6uwJyu+mASKwe48g2BeMjS5U/?=
 =?us-ascii?Q?/hc5Ieqry5ml/bDJq/OpdIjIXLc8qerN/IUgQt0dNT0ngE1digY2Zhsog3rB?=
 =?us-ascii?Q?8FFPniCUOm814Rh1VPyVDORpOwXbllVQJLVrjdYEneFFIuhteH+oMlfVI8hI?=
 =?us-ascii?Q?5xgormV2J5BjkRyJFoZ7IuSL/AhNygD10UepKjQBBJ+J7VI1WCbX48uVqy4r?=
 =?us-ascii?Q?rA/GMmOQMsRu+HNGgjmeR9shUBVE5GFuQYeP398qwMylLizWbPvj1rbDHk76?=
 =?us-ascii?Q?+W8GCdQZoBjPOrxJDuNZ3m0/bMO4aD1zLTFz5uqmacGIEa9D7t4poT2thyxH?=
 =?us-ascii?Q?PoB9Tp9l/ur3qgLh9qJfJqOhkuojl++FrP1u3uhdvl0N7ukJMXJAYGbRmdw6?=
 =?us-ascii?Q?O5v/5GdPAdcIxYmQJ0Ef71fTQbEdINgBfSLpGWgAeJrvwTJVyJl2HcPHBxJ4?=
 =?us-ascii?Q?Z93ZXPN9QEaX63t1OYnBVe6z+OGVtDTydrC46gNaSYc5JAVrO77CoDomT1ic?=
 =?us-ascii?Q?YyH4Z7PEVffDGhxurb8KSU+4nb1AVERhdOZ8Q9Fo9yIF/S+sTz7S+z/UpPxR?=
 =?us-ascii?Q?pcgigA7ypG91UlABuukE/bwWBtB9TKKQDABsshuF2pd3JGcZtSU3fLfbFQ2l?=
 =?us-ascii?Q?PvHGa6VVFDP+koRCcoRS9+IYwWQ2n/jDu+FqBA+rQ4ydlmxCShklmzmWKufc?=
 =?us-ascii?Q?FMDVSjuHqQ3Wrw0ur45FNFV6ocLStvkf0QV3fNEUW/TGLYY0Z41T0MSH+GdN?=
 =?us-ascii?Q?By4vltz11ms8DBGbS20ZwkY+omr4D/jafpM3z7yOgxHLPaCDhVty/zzviJSZ?=
 =?us-ascii?Q?hZAnKJgdZ2VEjjQQkdsdyZ2JwGYjOtyYuzsynMtFMcAXq8OQMay5fJI5K7Lm?=
 =?us-ascii?Q?70jSYEAwKkGXS+2q5z6nYbxrxHaevJVTGeG3UJ4M+LspLJADZRYkTIAY680B?=
 =?us-ascii?Q?a9b8lb1aK6CpzZTT6zcHwXomynBlsiyaeThu6TVGH2OVgfGg3gZWMOnUWpQ3?=
 =?us-ascii?Q?sHebPsRSIoK6jA5BhEcZQRntH06G6W6RZswYl2UQgIn8ahtbl3y0eyhEzF47?=
 =?us-ascii?Q?mVStKyzgUmqfvaVcIqyfOXm+wRmONMQ+9jwZypaeGZ5R4kmmLP6pRd1eB54T?=
 =?us-ascii?Q?g0AiEKdpqdrW5WQldqZX5ST/z7MJ5Np4hJ7ZrDC10Ng3JyPIMeK4kLcakNHU?=
 =?us-ascii?Q?K/3ZboY3NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ii6n90z/bZ1pItOh/qmLFryrFHXz4Oq578Fu9eyyMctWmeDOChLDD+/QtgX36KNCTlPDWu5+GiGjBru9nxoMWmH37aqyLGkapnu9XRo/QbrAKfUbWwjbt1mbS9dmOmoUDPCQEEJM8vx6/HxId+dkScfnNsn0jvUrVvjEBpc/UHJxJbqmx17hOHo3tiU9JUW9RmuD2J7w6Gut8IgzTYNnZFMznfNvrFL26uEYZi7Y+Ro5dL3iVRXOOuHxw7yAEDQohQXufkXyHUSg7di6rbzILGUPMKnKA5CqItCI2T4kMcaQa2kuM/H2ZMQQ3KboDevHminWqCbOAOEaHfgdqn/elg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f832c-4d5a-4619-2cf9-08df10519522
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:09.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN4gUQ3D2T/WGIsf8rqAIcED+6nGkXpTHgsBoY5DSv7tyDUfQ+pbO8zUnmwVn7G3MqI03QWJ7U8hij311bOcptXmG8/Humt2CAyWX+3jYmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updatin=
g the pin states
>
> Add bounds checking code so that any potential out-of-bound
> array access is avoided
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 46 +++++++++++++----------
>  1 file changed, 26 insertions(+), 20 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
