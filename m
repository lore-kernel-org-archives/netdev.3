Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43054A35;
	Thu,  1 Oct 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819086; cv=fail; b=tv4ETsY4eAl0p/L3FBRkkbsMUOwKWCOdmktQsGG2zWsnNORryiQL3aNAOuPwqmOOpnNN1Jyv6JujOUi3te3dJWn9LJgYxPaAfbEbRlhWA9vkWM89NMb5O3sJYgNV4hi7SVDxf17ddwrDOe+rpPRoSPytqDdm/gqx4fmCV4rx7K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819086; c=relaxed/simple;
	bh=iLh/s4+EVMDq9okT9UykQlqHvsUmfCKDWQxvCKBswUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNDXG+MMZ5N+fE9nRsz1p2gIRI4q2HRpEszNza4oKyiX6tp1W2W3GuZ1wn1kecjBrZMEpN6cGw+OltJJra4RlkMbLyeuDNvsbPp8ieK0ToLAvevwiHPjWHoZZT2QAEVzzA9/rFnRpKViQaBvqx1cc2moSTz0MNo7T3/7m7oKygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQyLXC8p; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQyLXC8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790819084; x=1822355084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLh/s4+EVMDq9okT9UykQlqHvsUmfCKDWQxvCKBswUs=;
  b=hQyLXC8pGuLZfIU3hC4ru4jQYZ6UiLcBmiiOlahgPYjyOlOyBZ0qEVfW
   /XvUe7o9fCFERHkeh47b1Fc//KXwVgcb1GhYU5OBB5xnl8O/mFKLXqIYu
   mcgKVvs5uMcCCdYpNkykiwwnXsbqmL7NojlGL8daGKrqve2MXnTUiPhqK
   7P3IIIYE/BaRut00deyynku+SIEE+v6KhMM0a2gDUReiS+m/4bhYR7PAo
   GEh51AG/OxLAsX1iE7AXh7dpaNQO7M5VJqWt1QVzwNbC8A4EV+/EBiM43
   XgqdtLCE+JN38Y96e+mdaKOqqsPSfKBtXXkZCtf2befA3JGZcef2oYlol
   g==;
X-CSE-ConnectionGUID: Cx7zUIbPSvKFvzBHeklYvA==
X-CSE-MsgGUID: eOJehUrDTXKk7Fthjfe/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94449481"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94449481"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:44:44 -0700
X-CSE-ConnectionGUID: j+2iEHl/QDW+L3EpkWktkw==
X-CSE-MsgGUID: +rzl/S4xQxGcNQNeHXxoAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274471241"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:44:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 18:44:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 18:44:43 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 18:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK4E9V6der6UY4exAGZagMPRMZpXayV+dJXfSjddM0haJuy+BrptCYpFYQWbDqoW0ZPcgAGusEhiFzclPw0yhIqJA8QJgLaL38FVa3blx/2e7YhFJQiEXq0GIBlx41QVObMph3RL0pIKEBoFI6Ovuuo+3wn3Rtwpn7FLYhtrZx/Ghgr9fEExByQfEyGb6wvKDkeqz557wTFNynO6W61VopRvIiCV2T2B/v8xLvjOokkHwpD2rQQdIt4DDxii6tfS7IDpsq4qbumZ2ENjWoh9bs2kTtRtrzEoVuwGqKvooTnfZaAiXDe/urlkzkI+HSH2aUugcpKBE8J3LvXqjb6XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6GLvS8v0YgdkZxhHagL4WDq7jx3wWPxaBG9a8/CG+c=;
 b=tJhagzB9xBVHqJmJ/DG+5X31yNW4iwrgx4knziGTpTSjT/uHBdQBO49sRqmkUQWVApvYBhmnKU/5Q4AFXv2HKUlzbF/k9r7RhLnH31wg/U6rViSHpcYp/ygQkELTozorh2oMPgKT0+4aHkp2UZV5QcGoDGzcPyKlUi2b68u73oio6vcQVxyZsr8ZvLULmK/j2rVIavXEycMDpC00wx1MIbU6kOw29vXGgf8cDM0mQVmSU4r72PFhQed9looF6gik720b4XqrIRUszobVnNEulUrHZrJ0L2a7vUauFT6gZfqlxFLptio11Cl+z8lk7/Ya2yRZhpkEdNPP2KewNlcCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA2PR11MB4857.namprd11.prod.outlook.com (2603:10b6:806:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:44:40 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 01:44:39 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Kneuper, Paskal" <pkneuper@dspace.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "Baldin, Daniel" <dbaldin@dspace.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kneuper, Paskal" <pkneuper@dspace.de>
Subject: RE: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
 igb_setup_tx_mode
Thread-Topic: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
 igb_setup_tx_mode
Thread-Index: AQHdQTwNzw7NslpJhEyM4ZIBFCZepbboCjog
Date: Thu, 1 Oct 2026 01:44:39 +0000
Message-ID: <LV1PR11MB879079CFFD6215B17D9E2339908A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260910113854.13279-1-PKneuper@dspace.de>
 <20260910113854.13279-2-PKneuper@dspace.de>
In-Reply-To: <20260910113854.13279-2-PKneuper@dspace.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA2PR11MB4857:EE_
x-ms-office365-filtering-correlation-id: 5a0e8097-00d0-4336-6d77-08df1f5d8ea6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: FPdGv3Zoc3ApOQ0pGAkhh7K6fGUwLdIfJ1N+DYQ+U1xUNW7HkdHsVbkgVX9zRjx0pkqiWphi+PHsJA7Bunb87C9J8eSLNgMiF86rxqpfSF4KrXguCnoIRBCtwLAm1p+FgV8IE8EbfPlh9Ebb1TeiKFzeAkc+81tJJXdYEYLMgKwq+mLp//rFTTucHffJC+4Y9b/LAxatZ8AWepZURg5fXkHVnPaRgHYXEH4YM/YfgufJ3F9Xk2q7yImB/IW9nDzGiJv6oxc8qNiBa2YSP8CXCacKVnQchegHx1tmg+8vGP+Elp82oxfihDkyC8xKwIoVdx2Q3P5hx4HBjOdO0zieojtBMhMncBzPGWFFOVvJTxqo5uCCTNlk5nublJRH6duEAGWQOJKv94IRJ4D3nSg8dYC3hGnwOhKlK5Sk/VYWjC1jkI3crpS+ev64tGIMNxEaQ+y1mowVK0LktBMZUKs42wWNdsJyNHfcq2AwSlMynoddiuS2pZjg0IwQMVN9lBkSc1F/AbZBjxdFqWcisRn8UABL+cTP0jJKLWSghF6F/ShCIa/n42zdrmkD9JsWAPReh/+V37TkhZlR562eAbZqfUalTaQlHG4eT/Gfi4qnL8iTPo+vlOwa8Vg1FpBwAKnxJpXhqDqOlribHd9ioL/6CGUGCbQXVhwfxm9lInf4xtR1+zpefe+NOgCLXmagZ8hzMy8ihK/1JKlwekpMtKarzZMlnVdBynEwqwxsRe0BrQbcxM4Q3417hlQ3Q6UwzjJB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qUTWCMHEu22eeRsHp7T872maflnl2f4YNslQxqCBGeJMHLuiM5yixxHolhTQ?=
 =?us-ascii?Q?Cu1faOH2U/bOXdH3t4C4fsMKpDu53IXAdi0yjhYNaDrMaTCMR4aE2wjaL7YE?=
 =?us-ascii?Q?aiAB034T8ZP2tE+8qoJQ9pKR/e3+yJIx/JfT42f83m9dyIq6D47s01fg1M+y?=
 =?us-ascii?Q?aj3nXTfNqMrdZ5KwrvdEgpvvRVFeCmTSro2KMTwUHqydS91Ccj1vLBnZd70w?=
 =?us-ascii?Q?tb5FYdl3egCEf5emrhhkT37bY0hafrKaDlkpTiWP0H9f59YWB3DyNuEtTkgA?=
 =?us-ascii?Q?97wDiv4VLU8ozJQHiPae+zjOCXdIjly2a4M9wRd25gL6pPaNTIzlqZhMh/KS?=
 =?us-ascii?Q?IGFQV3xtB4VywrfAlUiWP5JDCCWbVrtg4nZRLM9DixR0Hp18EYrhFa/I6sIw?=
 =?us-ascii?Q?xhF7XhL3SDK5P30tfIqkiRni67Ol9qCIpH3Jxk9AwbZt4hTo/vKkiw3BUwJm?=
 =?us-ascii?Q?eToV7MqOV+T9Gx7+TxKbxUGwxqjK+6bIhk65OA4DUejM9AsXJuYzlVMuAhYt?=
 =?us-ascii?Q?2reTRTbqGt/SAkGFrsjzO4KPrbVcarDOVz9mgzmqESYQb/Pe80vpZyjKQAwt?=
 =?us-ascii?Q?d1Rswt7nA6e7jbZ3J9SLYxv/qrANNZzj90kvusj3jny+fYvCKxD6Pqgu/t8K?=
 =?us-ascii?Q?VJ5Wjpi+QSXuclQNcHvb9DREu4Jug6ny53Y0NUxvBcYL2ULI/a876zSY3qXR?=
 =?us-ascii?Q?6Zs37pVfIgay34ZwH+m8+BKyebR5ioEPIy9CgsC1giU/R4kE4c3lGj17IGT2?=
 =?us-ascii?Q?uiGEXx5Zx+nUeEqYuwuIYQKyfAD+lsdRkQkeGibwwlmm0mP7gagmRvK3xoeD?=
 =?us-ascii?Q?qQC1M5qmfmoHwQoy6PSiTnp9rQUCGjDwhNr7TgC3m76kNIMhNYkJqbO1iErk?=
 =?us-ascii?Q?+MLEg4uGB1WR5U4y+TJO1KFn9eLz0mvcMtZjvFdzxmsyVnqGZ7HvVOThioek?=
 =?us-ascii?Q?M7e6r0wl7o0NBeZrQlrEh2EpEwCz6L3S9hpjVJHxmXyHqy1cDCoq4Vm06svS?=
 =?us-ascii?Q?uEuelgx1mDrNU8N0Bci1p/9/BAd4H8fYPnpPWQPC4UDZjK0luIO6ic+f3GWV?=
 =?us-ascii?Q?hfOebX52Xw8MdSeY7Y8tVwRasmSOtblqhGjB3zuaKOdITg37V/b3apVJk+11?=
 =?us-ascii?Q?ZofCbrr4URd2hVKPS2PgY3+PnMdUW03p1Op5NU+5NYOsLfiyfCOEiLG4BovD?=
 =?us-ascii?Q?t2VvjPeTnS+t4MwoLU+K0axQzc5YCNug/aKejCqD/dJB1OBpOX9G0/Zgu2K7?=
 =?us-ascii?Q?sNCsbU3J/9XhnBTqysw04bDBgXKRQlY7dxmoWS+4q8L0LIz5RPQmL94aOtFW?=
 =?us-ascii?Q?pfLVRUQ6Sxll5QPbHOpKlhoCFulrYFnV7EVFS6vhmQibBFgOfka5BTtJkgwA?=
 =?us-ascii?Q?YNfGGiNENb3uyYgUzglYct0WqdvvxJ4kq4ZKKlWRVgywY+kP9a7abnuRXOTH?=
 =?us-ascii?Q?Sb8oJiiGn2LHy59tUQ7WbT7qaiFR6HR114AfIp3Ogf2m1J3XxeZOYavKdfKR?=
 =?us-ascii?Q?QZA3ANMKC9CaiyNgB6Rm1q2YPJA21wDUmBZ1XZiMw7PjB5s/uveNBO81JA5Z?=
 =?us-ascii?Q?ZBAS8SirKxISxlweOSFlhoXdVQ73WiSwpaz4/fU5FU67Eavscu32UVQXBfvZ?=
 =?us-ascii?Q?XFge5LVqqpOh3O2Lw814BjBAPqqrya19D2VTnR4jVVjjtuFF7E51U4hRKv/p?=
 =?us-ascii?Q?BJ2ifyFUpvcRNxR2Fe1kkaaf7SfZL7U5wnlhyR3h1MsgnxURPVV/ugkFuZUm?=
 =?us-ascii?Q?RcfZQG3Gww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dVmgqowft3D2NJbb28wqomyklZldwDIiEulaVounM0lyQ5ULevvqODT0DctWDSseVqr9ZwhqiqnyMtTyYs7DIQe+GxRj4QaBGJH7Ds9Qrnf52s3g5cw2E1YqDiofMy98GCxgSvlytPxvBr3CXazl5a7hpcWfFhbS5bwHV9qpA+YAPJ92FnnNhunJtzwYUf8pzaowNN6kAsB7LF+D7F4zUUugmUdoIDH4Z8bMALTrhPZ2ABFGT0kqHJ3EtL0fFc5ucge4kgefIuJB2JM/xyrLtduq8QholCvRpgY9TIefBEB5C39p5Of63G+e6Mf60cnqqzDy78kctabRCzCMgc7DiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0e8097-00d0-4336-6d77-08df1f5d8ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:44:39.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SLk2oD7DE9hSE/UCrEOhDxAIyS3qiQEOkAgbOIoGr8LPOEQHRAzTfSONVYEknAxTBjumwOiASL3/izvyC5O3qpwkfMqpHmK0NKnimqnHYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4857
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Pascal Kneuper <PKneuper@dspace.de>=20
> Sent: Thursday, September 10, 2026 4:39 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
 . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub =
Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: Baldin, Daniel <dbaldin@dspace.de>; intel-wired-lan@lists.osuosl.org;=
 netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Kneuper, Paskal <pkn=
euper@dspace.de>
> Subject: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mo=
de
>=20
> Commit 05f9d3e1ae6e ("igb: Add support for CBS offload") restores the i21=
0 Rx packet buffer size with an unmasked write to RXPBS. Bit 31 of RXPBS is=
 CFG_TS_EN, which enables per-packet Rx timestamping. Writing the register =
unconditionally clears this bit on every igb_up() (link down/up, MTU change=
, or driver reset).
>=20
> Like other drivers (igc, i40e, ice), igb intends timestamping settings to=
 persist across link changes: igb_reset() calls igb_ptp_reset() to re-apply=
 tstamp_config and set CFG_TS_EN with queues stopped. igb_up() then clears =
it immediately afterwards, undoing its own restore.
>=20
> igb_ptp_hwtstamp_get() returns cached settings and never reads the regist=
er, masking the fallback to software timestamps. On an i210, a link flap in=
creases PTP path delay from <1us to tens of microseconds.
>=20
> Fix by masking the buffer size field, as the FQTSS branch already does.
>=20
> Fixes: 05f9d3e1ae6e ("igb: Add support for CBS offload")
> Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
