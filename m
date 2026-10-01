Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8233290D1;
	Thu,  1 Oct 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819136; cv=fail; b=EOR0BryTJ8d0mL5UiXw5JjrFV9/hHVDpdF12iVKriKjFjGrQRp6P4BrKT4XBpLz7yFFugOfSnzwnYq2SjHKat0rDILAS5jmG9QDCz9mDyyC4xm7FPLXN5Y58Fqg2eiiK8s0PjdbGGMmRR1GL2uD7I0X8/8ZilPa0oIe5/66pqrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819136; c=relaxed/simple;
	bh=g9QebiBvYM5LDb1OJY+flcZiAb9QlO64DMGo2qR2FyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALf0hIEXDi/T1VRElFDA23rg/lw613j6gwZ687zWNL7JidzaBpKMdfVHIUJ+P5bHvSmMSxsYFzx0D4KZWIJMy6eMtMRAOx+8cxyDsXpDyiJvb1i7FFwLakIrTke3yjAZTw96JG2JrOlyKPqTuSfe4dVSWO0YjrYRPkg2DvSRJo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWoijTu9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWoijTu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790819134; x=1822355134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g9QebiBvYM5LDb1OJY+flcZiAb9QlO64DMGo2qR2FyU=;
  b=iWoijTu9jCt/03oyMt5DZ+v1XaeKPQSlaZ5gKZHLlROPau+UiOuFuk88
   l0Fo7ouB2+Bm8mlvKvmormkCrUSffSxSKvSJISnjEUu2vYD8kGncrKfQ1
   s5AKidRX0FPssx9jtT8rYfSSHDjCiDbLgZpNcsOONWRCZVhOYMPhwobwY
   NKu8SzhzG7Bu+QWcNj0lSYNl7qFWu3fdZu9cmfMZRQ2mx7dCgd3KdLDa1
   F+kGFwMP7SWwZiESlEATEd23DD6NXmibytw5LpzGLYbvtSknq4EvlzTyd
   XwloXqORBK7oupA4hVJCPTtFGs5mDjAwxFf34D/W9GpOOvl/9OunoE+e1
   Q==;
X-CSE-ConnectionGUID: SZGrVYlgS/2E6y75rty7mA==
X-CSE-MsgGUID: iNICA3CRQEicfUkgPC1krQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101730847"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="101730847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:45:33 -0700
X-CSE-ConnectionGUID: z6XTU70iQceIl+3i5F30Hw==
X-CSE-MsgGUID: iG/ISaemRqmVklzOHwCtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275890087"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:45:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 18:45:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 18:45:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 18:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUqHPvS9+Wg+984iQXrn3Y2/8jekDtxUVE3rX3QEa5rQZ432t24G1bRj+ylCEGdFO3phtj0g/kdLQewKeCuhcJ/omjmN1ujnr/Ha/hrkcnwbbEsPUtIBYMgo8oibnt+/nuAsgHBXGw7HOqv7EUxthWWkCkO7Zn/zenUEJdAE8HMEOH5/c7fetudQ/Thk7OVP93nSisWZo1G0EI04OlS3JxC7xILjRFJBCmTMy4O5nSabMtoY5htRRCpxPAJge4Q36O+Y0twmXTli2ekT1yeoqh13RCjX5MfXO9wgDZW04SItPEtUTTpX5pEFCyXovMgFE4HTf27xs1/CAF/3+53/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E6r4iv4Bjp0ZI2xLrQyuWkYR3Zslb/icQoL/TRAQZ4=;
 b=xqNQxug0i31IPaZxmebhw6Jb2E6IE5k+HApe2sbkaEQ/UoAPGjuF28x9jV03VZyTBO3MOW/PybO0jd2CVmLcNhZD5xnJNMsRK6aIHNnhxJU+Md0mQPwfTBV1MnT4SU77K8E0ho/Mt+S6w2ZNbx6bIhu1Ys5ZEctAW4NYpmxWNFPLzezRBcWsXSb9jkirlCqh+sxsjW3tRb7tclFvKgIZlh2vvAC2pKxz9zy7nUfPSuRWrLVwj5MOoR+23PWDMu1AUPKiFw68a+Lb4qtSf8atKRj51utLPI/yBkqVgQwJv9Tu4GIFDx/53iydUYbDuY5Ii61q+4xC0QbpnFP6Cc6v3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA2PR11MB4857.namprd11.prod.outlook.com (2603:10b6:806:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:45:24 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 01:45:24 +0000
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
Subject: RE: [PATCH net 2/2] igb: Quiesce the receive path before enabling
 i210 Rx timestamping
Thread-Topic: [PATCH net 2/2] igb: Quiesce the receive path before enabling
 i210 Rx timestamping
Thread-Index: AQHdQTwMfelDVAVtZUWky49uIldbr7boCnEA
Date: Thu, 1 Oct 2026 01:45:24 +0000
Message-ID: <LV1PR11MB8790B3A23B1B00E7C784504B908A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260910113854.13279-1-PKneuper@dspace.de>
 <20260910113854.13279-3-PKneuper@dspace.de>
In-Reply-To: <20260910113854.13279-3-PKneuper@dspace.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA2PR11MB4857:EE_
x-ms-office365-filtering-correlation-id: dd7d443e-095f-4dad-69c5-08df1f5da997
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|4143699003|3023799007|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: lGziUYFa0k6+haD5l4m4Qa61RFC9FkK/kPlfbEcS7OD6wMwgrN3rSWYXRY6AAWRuoKKo2Cu8qUJoFtVJtu3TQgi/wJS4mzDRIyHprKTevTKi7AZT0+esbCLSTvhbWkP3gkhqFGzdoGy8zf0fDgh47QFyTxzkzITdINzeEC9mD5CdnW0UCGiIQHyN6irLuGA5sw3YjQT6ioV8+EuSE7icG0jEiszbCtp7JIsCSrtT9dgtfrY0ua7KWspX9+s2br9mkKCLoG2/qyl1aFHYOzElckN7lXPn3KU1UtnUm8qPnYuD/FZOh9sfvZmGxy5KRNfTr1yrcoRBPicdSFM2eNnJO3LCA2w1j1fwy3GXW498xCVGxAynEyTc7fGiIAwVNL/F85TX0qLGqKFrZSQ2LysshS85DTaC62I0l4QJdQ+cOEkRWfSaIfd1EBjaJfwjkfpPe81MpO+57yXrfilaR/GJheQdImaKBMielmk4VlK474EFmLsVvC9lBvBml/yFw6A1nhHkx2D3ONApRULB8PYjIDV8bI9xhv3YoDBKWMBvC2Nrf3KFobzlrhiT0P6f1QvTyMJsU8Nzyd8XhiHiEG161rwbbwwdBOJiIcSEPHJsCk+gG57HjC+Bn7dLaSygSy8h5ltjgAXdWxc3uyMVgSlluIMB7hvTSyIfN97jiAXLL6qYKekRHh7YGhb1Gb/byeUtd241BU+rGc4+tyEg4WVhEPxWFffTfpBS+2yVi6M4Bm2joPMuv1Ij6JgrGLnOrAs+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(4143699003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oy3/8EeNJVMaTO+wVowiNdnD22SBQAS68bwQiQGOKxATrDEkUGVncLB/Q4he?=
 =?us-ascii?Q?b/T/fLlKU1XsrR4V9pJt0ruA7ZgT1VXv00pyLScNhbbdHgY0YBCJaiz6n4bu?=
 =?us-ascii?Q?7EJAPEa5TEB6Fh05X+1Zhv4uh/JuoXgoKVPCQrGTaWkdu7UphaDwB7qqWURP?=
 =?us-ascii?Q?wtmF+VdxWzlMOrD/2EcINlqWFhNNgdtbsUkwOYHXIifsv8vnwo84hrahJmse?=
 =?us-ascii?Q?V/Y5sQ99Is7l17ffn1hvmPjykBxpmAxtI2O5WBbjZDfYhTunDjty5HpMKWeU?=
 =?us-ascii?Q?9s2PAIpCLlVMHL5bt4I6fxbGFpeMira6rNMmJSa60Kz+K0Ch2n8Bmceid+XM?=
 =?us-ascii?Q?FMk3+r2GmjpsnF8V4Ho32tthezVRbrpv3Btg/D1Bpo0qDE4ujaz5o+ktd5va?=
 =?us-ascii?Q?NVS4sqQHscEqMBT6MYc44TpRmsrSFtBbkt+3VozePutcMB5GDs9U4BtRMSbD?=
 =?us-ascii?Q?ji4r+Uoa673JsYweRMUWgj6lA/Ux5RAGsKrEQD6mqc1F/5IJQbuS3veJsxPX?=
 =?us-ascii?Q?ZrxxZ6ybGVSQ1Kl61JXjvbhv54HfqvMlSEwj3y8wSIV2Cn0n9rb8IPcTg3tZ?=
 =?us-ascii?Q?+jWxG/eN2NVZyINmXMvEh26ef2xZL3IiMAsjlGfnlKtSbC/0g/j788S49+qi?=
 =?us-ascii?Q?ksCPjyJGtlME4DVx4fabd36bY7yLZ1WHqd1kFcrk7CNsIr9FnkDBNhTrcP7w?=
 =?us-ascii?Q?6qXa8GFx7PEG75uZzi3Bcgm5NuJbIT4WgGLbD/mS6L1CDMwOtQvxrxvK+NbJ?=
 =?us-ascii?Q?ofThiywJchk5YzzS/uepxH4IdoVIrrz2dT1oXhbpGAWECRRzBss8a+GDa1s8?=
 =?us-ascii?Q?V+5nApCKV7g+3+TQwZH1M+0rTPR1aKMM14XOtGG8wRYuADWz+SHHFp3ark/M?=
 =?us-ascii?Q?TKngcB3rA/OJxJB3736XGtqMH/sFmDXN/4Z49LRHl1eNvYXdL/nss7biK0gY?=
 =?us-ascii?Q?ThQmFBQFifjEJFTpAQNtyUHImAbL3d9n8zBDraTiozFGwaZlTAmAcm++Oho7?=
 =?us-ascii?Q?5oiOPE/r1Li7nxVKuglS8uRM0nFNwhmYWwLlDUyIgU7QXGUG3091ZSETEOv/?=
 =?us-ascii?Q?+l0cVYPDwKEzG1GFrTCtNrOF+9C7hNC+oJM1E8KNvhCKn3y70cdfc9BrbCcD?=
 =?us-ascii?Q?rYXKaP7RVbPCaqpniWZZSXN1WYNyE3PM1dkiCpMi4lRhB4uOBN1VI8mxIf+A?=
 =?us-ascii?Q?/EH0eKy5UsF2cUBFXU8ls1l0lEE/KCS2dbNHfnLhhBDngtKLQLyTMhq5ob7j?=
 =?us-ascii?Q?YvwPcFI/aCkAlefgtKUIUQhOG6mCHWOmQwv3OV0Hk7xi6MdHPRmIFvlpybBZ?=
 =?us-ascii?Q?NEu3IueaIpXSBKGqXZ1tJza6Ck2jG9MQDQEWGgiConJ7z/SqecrVrerLKVxe?=
 =?us-ascii?Q?B/tZOSzRbwtX5tylWG3Di+6jN0m0ThlH8pdxqHrRLwIZEWKmbVdkzcebhhaW?=
 =?us-ascii?Q?Ts/2jBRZYiEeianbaUz3opJIbSMOkae94900oohaO9K5GEvFFQ+ivv0TN20P?=
 =?us-ascii?Q?TplkPqeqxe6W+AH+LzK/Mc+z/c4ppp5YIqfWYiIVn/a1wfBrfdIoYDTJOhDP?=
 =?us-ascii?Q?WmRIJQK1NiymVvAEI3vZVokle8ufCq10/D2gQM9k283/tZc4/oa2DKB2EuJk?=
 =?us-ascii?Q?Cbi5CxPhHy5uhbUU/+iThV5W5MKcWPBi/914qHORUtdGX1E40YrMHAuOJXEy?=
 =?us-ascii?Q?1orAvT+Zi8kNqGGXIcS1J/IeZ4b1WiY0+6S2NiCsgbyo+y5hkOmYzG4YX5lR?=
 =?us-ascii?Q?OrcE19rO1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: taGZEGACPIwjl2VEj0nppFsSQOutEn8Eq1sm02XzzWodDEN2QwsoCdKYuAm0rq/YxsAo54XWJdX7K1E1KUfltmMuD3vwzoSrchklKlsI3IHmAjozTIoR+ihon6uiZd7qF8QgC9fr3IJXx50lAGP+0QJw/JiHoex7Mx8lstEi7CGJ7VToNJxnES8MR4XZY8GhSN3qZxeaokaNc5ihcOxhPu/MBQBbXvTHV+8rIVzmtSir2k7HcYRxeQ/9v7GZ71I/Uyl1zLlets4E5+z2bIMqi3lfiZO05Pzq/jEXxzxI+b4QqtoZrYkU8mJcWScYo03MEd3TT3b7e6KkvHAHhsju0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7d443e-095f-4dad-69c5-08df1f5da997
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:45:24.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCcXfg4vpFxN5DD4ttXktdGxZTdvd6JOVeyInOoMOw1sebYcwiCyOgZ7qEyeyJiq79Rf/dF3E4Ag/a9HlRHtQghhqOhbtGH72cAQG0B9yX4=
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
> Subject: [PATCH net 2/2] igb: Quiesce the receive path before enabling i2=
10 Rx timestamping
>=20
> Commit e57b8bdb4833 ("igb: Add 1588 support to I210/I211.") enables per-p=
acket Rx timestamping by setting RXPBS.CFG_TS_EN with Rx queues running. On=
 i210/i211, CFG_TS_EN makes the DMA engine prepend a 16-byte timestamp head=
er to every Rx packet buffer and sets RXDADV_STAT_TSIP in the Rx descriptor=
 so igb_clean_rx_irq() strips it.
>=20
> Setting CFG_TS_EN changes the buffer layout of already-armed descriptors.
> Without a pipeline handshake, descriptor status and packet buffer layout =
disagree for in-flight packets:
>=20
>   header inserted, no TSIP -> unstripped, frame shifted 16 bytes right
>   TSIP set, no header      -> 16 bytes stripped, buffer tail appended
>=20
> In both cases the Ethernet header is corrupted, causing protocol demux to=
 drop the frame silently. Because igb_alloc_mapped_page() allocates pages w=
ithout __GFP_ZERO, the second case appends uninitialized > memory.
>=20
> This occurs reliably on i210/i211 under traffic when requesting hardware =
timestamps at runtime, yielding corrupt frames on off-to-on transitions.
>=20
> Fix by bracketing the CFG_TS_EN transition with igb_down() and igb_up() w=
hen the interface is running, ensuring the bit is only toggled with Rx queu=
es stopped.
>=20
> Fixes: e57b8bdb4833 ("igb: Add 1588 support to I210/I211.")
> Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
