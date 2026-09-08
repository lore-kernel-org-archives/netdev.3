Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48C56C64D;
	Tue,  8 Sep 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873321; cv=fail; b=cwwBZocpbtNU7MFlR11fh182sao3e2YS7RBNSP0WLPxmAVH/1XoAas0E+nE3yKtyE5cDESP6K9Y0SkIPTz0/a7qRl8AWxDolHxidp/OCZAcaJrtGkcdiYSY17xguPhJb0CartFZQItvh5mhiYdOE6+8VeiNASFrhX48k+mxeEto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873321; c=relaxed/simple;
	bh=2OFUELpMiYqpFK99C52QhcEegQ66rGPPnyA7wa3kc0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwCnhWjyey0PQeS7LLAn+ZQMiH4AD3uTfCuF+Vpig1jIeIw51V/a5Eu5tAFOznqqNDJ0giTA6bbyl+OWXtaHj57bEJ1SGfuoXt94xb7yDodvWZj4fKYkdNkvxXliiFYDbfOWP98/kVWE7Mbg/DJ49hMJ4a/Oc06SobDiNx6N17A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STSdthOH; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STSdthOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873319; x=1820409319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2OFUELpMiYqpFK99C52QhcEegQ66rGPPnyA7wa3kc0M=;
  b=STSdthOHWYEv88spm0rX3q1MOT60qZYghM7cSVS2oiNQ24vw2NcziciE
   Yu0eTZFqj78sRmG8wtIdxAMjleUVqwKS3V5RAOTtROFv0t+PyTWWZD4D5
   qlfitiPRF+0EvKZo4R+xbaEL1bxIwsTXwP9RmUnYOnnR6nzi+BRksAy0/
   hUq3bymGqcKmpV2fnx8BtGhpv3NdKQOYEtLbPCNwGLIHWxsjvVOksa+GB
   Da/HPzVUPfbsWS11Ll5coQfZgJNEIDXTZuts1HOVpFOKDSh5mVSIvXt3s
   tjeNesUcN9la66M7kgpVOHXw2Phiniz66oz/bh0TE9vJyi5AjpOFM7ExW
   g==;
X-CSE-ConnectionGUID: CWa0ooaTSXG9B70IeHjPFw==
X-CSE-MsgGUID: oc2VXLpiT+2JC6lI/mVmdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93094735"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="93094735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:15:18 -0700
X-CSE-ConnectionGUID: W8viSTOYSb+eN8GWJlRcZQ==
X-CSE-MsgGUID: ZVmp0mzhQAuqG8MYnB+3lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="270510507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:15:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:15:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:15:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzuAbKguAl5cNEwkJJh+vV5w+/0gYgynDtLX6Wm8OaUVNulpbsbhyDAs4o6u91eZOn46pnq3iHucdVTU+cPm7389G9lhFA3NBJO/ECn8xLmGgmQLZYicx9uuvacyDtQJabUoB9azVTLp6341HjajAuukhUPkq0qdFOKM/s5iXAVqoRBdHhKwwNKt9FmVnwTcSQaQ8mEgpkPuSpUuNHPexBZFG3N+MMLLzw9HM8uEe+QajFnXSwEq3FCdLfZQ+zjJ1H5wkIb50r88ZQ9yew35q/fNU1yh/bLkNQWBSL3qC72nVjopki1gSJ1myRiBEBWC1annaYX4XkCrDZnVKYYfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYTRWxnIW5JcWHUnQ6hW3jot4a1EkxsGYyZX3M3yBFs=;
 b=fM+qSqPJhx3Tbv9rt6yNuQBDdWEBeRKbDShMnxSLKCkcYLMViQaDfxaPP65NzPVUUH2rJN0khBWM338fXGiWzhsdz+uLzhHQfZKA//iizsKA/cjWVNjsiNWCnKh8WotlkH3WvUinWArVNGtJlc4azS201h8fONWwJZF29qFvypsV9CjHTKuYnL8T/I/mrwpXNsSbT2KKdFtqsdHDN9UG157Eyqf7KaEszpwmO9mTsdbwsTzIqZiYr966Yszxqzdjzlv6JVyBQVe8Xd+UQ8OECZY+GpME52ulPtzfHxiPXzFbRK0CQaI2U/ozKu8CjTXcnt3VhxMb4p0DplZYto0Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9297.namprd11.prod.outlook.com (2603:10b6:208:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:15:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:15:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Richard Patel <ripatel@wii.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew@lunn.ch>, Steve Douthit
	<stephend@silicom-usa.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Topic: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Index: AQHdPagzXf4PJZE+0EqfcaUY7S5n57bErM9Q
Date: Tue, 8 Sep 2026 13:15:14 +0000
Message-ID: <IA3PR11MB8986DD5E9AC23B822E9562B7E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260906023319.1978945-1-ripatel@wii.dev>
In-Reply-To: <20260906023319.1978945-1-ripatel@wii.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9297:EE_
x-ms-office365-filtering-correlation-id: a0a6f66f-1522-4e87-83b8-08df0dab3880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 7lCZ+0iSK66luzwuYC9URkktHQAMTma723LUl7X9ZSjiPokeitTVOt3eQKmcooOOrzOgDIZAyX418pdndIni29yrdLxp0sjnCslEP3dKTgUaQsc89qwSPsm/NKZIvlhCwe2jYGlGZXHV7cNe7ChYaVa14bi12b2rtJm9GlOa9GHuPmoMirTasElQZxOHYJ9Ng3b4y0cdjs8LPJyxOBACQJbyt7QUZrJuIKQKZgO/ISSZM1JyqlEqwor/JGfCx9kN5EwRhY1LpV9KYcX13Vtd8coDX45aQLxjq7vtQ2cfleesXHeacxsLELaBdUAXobM1X6KLt/lRElo4o+68+kFNaBsis8eXUZdQh3FQAXbJnkjTatYOVGmz+4z4OWeA+zlaW7urW+kYKVTvmP+zV7/dDR3kdp9ubVMMDxjdjrGKIrphfnOxyL+w5pLFdi5feHljb5dOUJBT9wg88Ryh2Hye9ohA+5dzU8zQ4oDT1G6ZnMu4EJDEGKmk4PSBgs0AHcx1QmjI4+EbbjHb54jbERX/OkAxYY5U6aX+c9tSZOhsVbLpyllu18iunn1orbhg3+/Mh99rXv0iyThZrcu9sDlpg5uZYwqUPan1D0sOGkabazeYFFp4njNamvxqnwM1TwX3ARtOa115MV/GfMZgUT/0+Lnm0QZS9wWvzloTMOQndVn8wsA7BXcHBgbm4rT0aY2wlm0ViL3kW5MLJrFRw0Et0vQavFZVdpH9LAOkvx+hhW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+OXXi9bYIUc8H9ViIDpYyJXAS4+7T92lvMeb+jJSv2hg6tAk2d7BYF7C4rVF?=
 =?us-ascii?Q?YHqoHUb5Li/CXiiFT6aYRQgH7qgg/heTl/ZxeqHZwbKDfhke+F/LBh2FDo9t?=
 =?us-ascii?Q?N/8lgFldOmbchL3LcvVL3A00zaG27c1r4OK7sVhjlPhaIBGlkMBgGTOXbk2k?=
 =?us-ascii?Q?ifZarYMrE1I0Vlt+Li8Wn+S4VQl0kPGB/J5rcYt0lrk808e8ufSbGo5xtz0j?=
 =?us-ascii?Q?QTo8Y6VATrZA3CbHAhk3wk07AEuL1I6hvWRNbFKT6JMM55/Zgq1biBvypp70?=
 =?us-ascii?Q?mKSgbDMLbBu9NZ7QsXFL6QI+iuRO5eRZY8CdE1xJO+Dho0STSD1xtIG7C2HH?=
 =?us-ascii?Q?lxKLK6bulQ0FJdyYMdHY78H3LnBz78dQnB93AjtmCXA72u9ERaPwI1n+2WyE?=
 =?us-ascii?Q?xIJojq0reQw3Lk0X3rqikjdgOdmmzz+XAYC/t4/WODaFHG82Xc0fLm5CRSO8?=
 =?us-ascii?Q?XGQWaZ7ZnbBASkGHwigSqbfdneE7BOxVe+siHWNOfJ9DQdFitiCTF/Tfec9G?=
 =?us-ascii?Q?t4gT+nQgq2P23UYfdNYsAgAAuNhOmpYqfAz3FjIUfCGebO0Sq87vw0V+upB1?=
 =?us-ascii?Q?ouArhzun77/Q5rTQ6cNmjJNx+Z+ugTJJjInxxMLnuSpHBtXYDKlwD9rYPdRs?=
 =?us-ascii?Q?l5YIq7HSFyiEjSRGwN84LJsos6jeFHxxxkEfeIm9kXJSsopXd/fffnR0ooyb?=
 =?us-ascii?Q?bTrNBBqW8gCAJaGHK5PoBKMCK0s3v2mQ8EYU5KN0IEo8MX+HqX9E0h0Zd86U?=
 =?us-ascii?Q?883I1iGXBrpcrSytTcqFG2taLP5hA438nSSCgQc/QrDCTH0IsbRB4CZj2lSA?=
 =?us-ascii?Q?0gwYPT6p97YTf/B4fVAJaT2yLZUfVgYJPZNZfElHfsUxJVpDqn5316wwQkSS?=
 =?us-ascii?Q?7m4ek1nmzcw7YOlKrzurh/JrMSGfdq568BOZCICN551koloW/9zLy9Y0kYc7?=
 =?us-ascii?Q?Q+ZhNGNO2O7tcw9OcsrJ6jeN4SUULrUsMN2xRbLWZC5b5/B5/9rYsWR2knZe?=
 =?us-ascii?Q?LBn1ZffLaYksZjibwYjSFcPTBgfEe9coZJkcKrHXFWWLPmgBzEm9jBNexRHr?=
 =?us-ascii?Q?M/CMHZghCRfY8Jm+F2TG3wcTcd+PB7LATxkdmvGD3EkuAz/Hiu17PcxtcTA9?=
 =?us-ascii?Q?L2tscFA4TUuaA57zL4qka6I49KVFsYOoq5A8NR9gyIVsHWkTRlFwNtKU1WR+?=
 =?us-ascii?Q?LFoNt2/RJyNd/VYfqYd1Bfw1HRhE2GQM1APFBaJmzuQBuoaD/rQNayqcWR/D?=
 =?us-ascii?Q?roUCW44zuU44HRUeUQbCCnfa3xnI+ZGKsjXOU4Ty2F66ej1Qms/iQIAofCbe?=
 =?us-ascii?Q?Nupa9G8zb7Yg+eHyezhRIx14JusDyLF9Ve5Rm9wRXc72Cf6fLIECyIZ5LUNT?=
 =?us-ascii?Q?Bn6sGzv4w9FGSTVZqJThdTsx/EgtHU9m1/T05WmMnzwvaio5GJ5a7RmiZZPD?=
 =?us-ascii?Q?qRXRYRWP1H5/VWhdxwNhid0uEwYPkY9glVAHSfGlIcyDnF9kxRna6ZZ21l1N?=
 =?us-ascii?Q?9tl01lsGOcE7YqDKafBClpl1MN0kC92sDVoW/P1xgqnMyF3miYBWHRRa4FZu?=
 =?us-ascii?Q?xFw3dRnKDs9sDJT4SsfTLOXHh+mtKqmIEBDNxJtCUABMJjkP/mE9e3pCdemh?=
 =?us-ascii?Q?bWX7ygf/w7z6LzsDvdgyW9cRDY5dZkMvu0bo3sr2TahFK1hERQ2G8tFlhYOR?=
 =?us-ascii?Q?55WLmNkUppmysrEgTeOgte6smajFJGIjcKXxATvwYQ5m+SxKD7ax/FGU8Ytz?=
 =?us-ascii?Q?6kAi/tac76tu1BfCORT7YqFVhS+g8QI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FyA7fiQDJ2EVoBFaHja8qU/9LJSEIXUSaE7PHcjnaKPrztQWZuWGZ/7etIglBwIi5EdqvmPViro0i00153UEjb5F6ZsmZVn0DzvMl+8dhIfj82cQsIHCGucacSGeHjOVBSkf8F9Eka1bk+nQyku3v8bxkOUFip14DqWxDMJ3AJnFkFq/PP/BazvpDfySXslFMq/TfxQwI1bab0/O9pG3NnmWrCIAg2+a9DWD2NhAZT81WXSTZ7SzlSKXW20RwONafHYdIVjPvOfonzt6zbSeVYEVHamUigI8KlQZqdxgn5y0ykROpL59bg6UnXIZP5SSlcymPDl3NzHYRz+ve6k92w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6f66f-1522-4e87-83b8-08df0dab3880
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:15:14.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReTbumKT6cxjrlRzlYmRgTxOPD8+C/yy18ij2PXQM6GhWWj041jZdDbUJF45B5NTq/OhLwpQIwfAeXHujitjmVbIlJEaLZ9ZKuYOYxBtrlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9297
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Richard Patel <ripatel@wii.dev>
> Sent: Sunday, September 6, 2026 4:33 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew@lunn.ch>; Steve Douthit <stephend@silicom-usa.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Richard Patel
> <ripatel@wii.dev>
> Subject: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
>=20
> Plugging in an unsupported SFP module caused ixgbe NICs to get wedged
> permanently.
>=20
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
>=20
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+
> module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported
> module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
>=20
> This code path failed to unregister an MDIO bus owned by that netdev,
> so when unregister_netdev() tries to tear it down (via device_del() ->
> devres_release_all() -> mdiobus_free()), it trips over the leaked
> registration.
>=20
>   ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
>   WARNING: drivers/net/phy/mdio_bus_provider.c:711 at
> mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12
>=20
> This prevents ixgbe from reloading, even after PCIe remove/rescan:
>=20
>   sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-
> 0000:3b:00.0'
>=20
> Switch to devm_mdiobus_register(), drop custom unregister calls.
> This is safe because the bus is already devm-allocated, so unregister
> always happens before free.
>=20
> Assisted-by: LLM
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Richard Patel <ripatel@wii.dev>
> ---
> v1 -> v2: use devm_mdiobus_register() instead of another
>           mdiobus_unregister() call
> v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-
> ripatel@wii.dev/
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2..96f60269fca6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8471,6 +8471,7 @@ static void ixgbe_sfp_detection_subtask(struct
> ixgbe_adapter *adapter)
>  		e_dev_err("Reload the driver after installing a "
>  			  "supported module.\n");
>  		unregister_netdev(adapter->netdev);
> +		adapter->mii_bus =3D NULL;
>  	}
>  }
>=20
> @@ -8693,11 +8694,8 @@ static void ixgbe_service_task(struct
> work_struct *work)
>  	}
>  	if (ixgbe_check_fw_error(adapter)) {
>  		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
> -			if (adapter->mii_bus) {
> -				mdiobus_unregister(adapter->mii_bus);
> -				adapter->mii_bus =3D NULL;
> -			}
>  			unregister_netdev(adapter->netdev);
> +			adapter->mii_bus =3D NULL;
>  		}
>  		ixgbe_service_event_complete(adapter);
>  		return;
> @@ -12104,9 +12102,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
>  	if (adapter->hw.mac.type =3D=3D ixgbe_mac_e610)
>  		ixgbe_disable_link_status_events(adapter);
>=20
> -	if (adapter->mii_bus)
> -		mdiobus_unregister(adapter->mii_bus);
> -
>  #ifdef CONFIG_IXGBE_DCA
>  	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
>  		adapter->flags &=3D ~IXGBE_FLAG_DCA_ENABLED; diff --git
> a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> index ab733e73927d..74631cb2ddbc 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> @@ -1086,7 +1086,7 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
>  	hw->phy.mdio.mode_support =3D MDIO_SUPPORTS_C45 |
> MDIO_SUPPORTS_C22;
>=20
>  	adapter->mii_bus =3D bus;
> -	return mdiobus_register(bus);
> +	return devm_mdiobus_register(dev, bus);
>  }
>=20
>  /**
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
