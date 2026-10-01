Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B4A35
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819031; cv=fail; b=QBy19odhP1UYSn0viw1UdH+woJCdzm+mbMmJ4A+fT+hwHLUMsXh5xHiBHaDXxirRbbuvbXHHXcaSJ7ZK7b1FIKTNPRJaK0ZB+YPCguWBhRK6xN0HcwRXoXxwSL12KzgXrmDv+NzJg0CRBneRICVvAoycYox2bXiA60NlzklpcXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819031; c=relaxed/simple;
	bh=mowwEUhx+yaf8ssuPUx6WAlR/OylTvBHcducBLjsi10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tdr+Ks6zbg8z7MVsqQuJ1k1YjI9rEpFN1ymB9aBs5VSLl0u4HiE3CXS6Am2h+yqnOGFf/YwbKmr8sJJts9P01dEdY8iTJIlUoOx9x/CdEhSMaoMOjRHOGs3yzIz4QELzdBTOrhz+2MfH6vsBohOQSyxpSAtoqfbes+u/A+NkjN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/OAftVR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/OAftVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790819030; x=1822355030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mowwEUhx+yaf8ssuPUx6WAlR/OylTvBHcducBLjsi10=;
  b=T/OAftVR6DN0d5lZqwwxqjtonXSYtYRRt3mIo7cJAyYHH6B8Urdzi8Y/
   zvywWjzz/3VVPzXImgQY6lemyWD9orKDc5tjeWrdb2QFxo/1B5akVyC6r
   DYtuOBOe9jgbseBitvzMQzdy835/hed4+nxmVTbGeKkLYIEop53MQ87TI
   SrjvpQjaj2UK15MkPTX8pn0QhwEUij62We+taydhj1l6L6A5HCS3Srcc7
   P8Wrtu5T3brqeqkiAL761tZNPGjr+J7uLuYkzHnZpooFl9mEw8eGYfrDp
   uAm4yQz05HGY9q6Z52FrqIHW2JYxzjrfZdjE2eDQJrG6Ln+BmygaNCKbm
   w==;
X-CSE-ConnectionGUID: fklR5aI6Sk6dsevPlQgFng==
X-CSE-MsgGUID: 3cYXddp+SXKk65nsO9/0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102942193"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="102942193"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:43:48 -0700
X-CSE-ConnectionGUID: WBq8//6xQVC18evy9G4cPA==
X-CSE-MsgGUID: KnMFoh4aR3C79cPv4XdcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="305362226"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:43:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 18:43:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 18:43:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 18:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp1RlSqda0Vi3RlBrwGxXRMR7lZCKKfU5zsQXpyTSUBn3gy5jo+RUAeK407lpr7Qc+hRTnMrB9UAK67l2OSgOhSio287O14kDgpAKeKQMr+rpfA4PXrmXsajmWzR+pbWxwqbro7yPl6Mm1zrnuk+t5sWIpocEpSjJxcVdfa92VzJZNgE3qJ4tACnQ3fdz5nql5wNJDfozdVZIPDw1YgpncGIHAYZ3YXUKWE5YTh3TngixPcQRV+pFtRZqIPx2rMaJwo1hD6SBrS3YjXBxWr3LU4f4Kw39+Ml8a5MFRbpQYMV08sBNZO5z/aZ0L4AwiNT1TDC99kVEPAduVQhCDO9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3kWDJhEguW6OqZNIaiuZ6BGppSOkB5xO83AV3LhNgE=;
 b=Mur9qf8ZHN3FJ6F0X98h8sLVTh8Br6JZRRfZ8Aeej87Hp7gUPIyPrhZHbdFZb1Yk61uyIByKGktQKNFPQTB+vgl0f6M9Vv9tPGtxBCGZK6bPEq53JmdJBTNINg14dTv6jLhLxMeqXPmPJ9f8WW63ayiGxrY19GPuxzmsR8HCVhB2hQuXj4X3NBFtUNlka3bRWAb17U/4J9qCeq8cQxvgDx/zSfWArlyNGQJcjkJR7UEZZ4lasJ/4DTO506OtlwhO7vceb2VSWUzFpiYOkY3Dx38p2eMNylwESXeE8LPgS1aJRzyMzbcPCCZpFqMi68UBjNrFXFz4yhiJT44+hUxN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA2PR11MB4857.namprd11.prod.outlook.com (2603:10b6:806:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:43:39 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 01:43:39 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "sln@onemain.com"
	<sln@onemain.com>, "jbrandeb@kernel.org" <jbrandeb@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: fix napi_disable hang in
 i40e_down() during firmware update
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: fix napi_disable hang in
 i40e_down() during firmware update
Thread-Index: AQHdHb9Ddz70Iw0UBUS25s0G5Zi8KbboUGvw
Date: Thu, 1 Oct 2026 01:43:38 +0000
Message-ID: <LV1PR11MB8790C3EE3DEF05940FA36E7F908A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260727115756.105038-1-mheib@redhat.com>
In-Reply-To: <20260727115756.105038-1-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA2PR11MB4857:EE_
x-ms-office365-filtering-correlation-id: 22ff8c16-0e3e-422c-dd15-08df1f5d6aa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: AF+O+zbOJ60B6S/xwBiUkKg0WSjbIC7hK2WrxL3BKAgOdmELe/iRg58ZrzwmDDx8UmPgHMxLVsP0sAsbEjBhyHeNb5r5Eq/rQGu7ktj1jMl2UX2jW5rX9z4QMM/+JLOm0b7UOhehGKy5WPhxbkQG2MsxzQlbJ9AV/OTGr9MehjZcla8mwRf2OZZ+P0W2ZnTjUPAoIm0div2cG84ufd63AiY8L0S/9zxTElie+T1cDXHzMxa09o7KPw/d5FbVmIyYkosXFASNrgUe2UPTW6+7eOOir7VQHMCoHobaB3qWdG/npRnugKN1nMNmLO80d7/kEufpyA6K87VzEx1rklGcStbNRng62A8lQUMZUMFhCxbiex6HoK88xuAuYCxv43BvWp1VsKaqWcTwSQ4wiKbydK5IT4duA0zmQKOSg0g4Ft8o1CK3v7saPCwLmHTd8V0jttWf6BQ+Si7HnoL7YpZ3Bki73i+x+tJ/94fEvtePgMv96BAm/MOfe4PJRHsDJStVYqr3BcenVfKp568q6Sh1mqdYwTJxrACaP0guPiZcIRzOnqw5cExv8HzlGG+RHL2gRda4D+TRqTPbTlXpxg2noVMWPRPcTZjxvqy0GHfLJQRQC5B/v5zYRGb1EasXh/PgOhgCc9mtSqeknxp/GBjwkgSfFWsEVv8EmacXdh293XrwdcTUmIPe7V1+Dy73NdSXouHz4m+rJ8IBGAgXb3h6kljDNgLYnGM25+xdq77/p4k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sy5tMylgQeYXhvPyCSt47TDQbDyP3OXqDDas/u48Q627SefyrSIUR9PYu2nD?=
 =?us-ascii?Q?qE383SvWoUxt4pUoNOHZFNK7Wl3pJci1LwAFLcokhCVIzN236/A9p61EEb9+?=
 =?us-ascii?Q?39cIQ0t4C+rHnnnMsj6yi1W1wl8TqV2Wu9z3zgkZ8XBUgYXjblk9GJhQh4Sr?=
 =?us-ascii?Q?3XHdrv6vcAngn589pnEsdPJ1WKBxFCSrURSMRk8of3JeVVZG7oGru3iJVMmk?=
 =?us-ascii?Q?vdhC6M+zql6ISeZvUfffrXxUUgesg4mswX3teKh+IrJCYxxHDBiWGaui7gYZ?=
 =?us-ascii?Q?H7RQHLz7pnKqI24dYl3u9W+mBq3fOvuWX26g9G/eLtO5FGGbu4u+nW2UvlMj?=
 =?us-ascii?Q?NN22RKxUudn0isH6ufILWP5hf7hzJ/caBt8NMfPdzajABvNbHr6PxroW98fz?=
 =?us-ascii?Q?iu/CHLemmK0gCvx4jHjDuzSJgTwpSo3ozb10IbyKGpj+O6KtSsrY/dtyIoMA?=
 =?us-ascii?Q?YyP9mPjS+2uRdF6WUdmBf7drNLVTgQPqlLld6GgPoEgtWgeclB9mIFY/7mJD?=
 =?us-ascii?Q?8GzFk+4dDUlKUC1eDBheCdkgokayY/WdpJEPzdaM1CcN28OjFjm/Oxa5+fw9?=
 =?us-ascii?Q?/AcO8h4olKgJOfOwT0SFDo0090JppbYM4RMkjDqhY73PcWiDwe1xXzc5Pa5e?=
 =?us-ascii?Q?nfJNZiAQX3o1q9kKtNZsqOeTS3xulA6lqc6CdX7DlwCVvzn6fNizcWAd/FF2?=
 =?us-ascii?Q?nbfRgjqxSm7zeBlCbUvzAt3kH8SMXBXmZyziKVERgrnQBhVWWSmo/IlAJS9f?=
 =?us-ascii?Q?pZ7HUzPXh8T46Qendc9Pl+wzmNzp/eIUtg5zFSDCBkdeZfOsQMzP09Vj56fZ?=
 =?us-ascii?Q?KSXoSLbYovK/xT92jC89n5jFduMjCnvGcOmeipEPD3d3wG0KarNRccB03ly0?=
 =?us-ascii?Q?8nScB6Kfxhzot13lMGWBXrObGyxxhEMtnpWjadw+MmNCrMyAtSDtlr3dDAhi?=
 =?us-ascii?Q?LAvKcC+C5uvVEB08BEG8WjicMzlyXtj/ni51BODWHcbQeyd3azdM9PGtblXd?=
 =?us-ascii?Q?hAbsBgv6dmkugn4FLvn94QRlB7oljY3jNoMkJ9yLUBIDcC9IdHJnMqk2PUVY?=
 =?us-ascii?Q?ZmJ0R2VWMbcIHunxI/29t/76fD0Lgr9iaf9/5sUgnPQqpWJ4RqOzOROvCNQR?=
 =?us-ascii?Q?TJ5nU+R6u2Vpm4059aIPr5EQg0bJGvmZXVOqDnKyxKCS0tYapVh4S0WTJrul?=
 =?us-ascii?Q?P8dVB4Qc/0kHCaQZg1b1ArnlPMzs7W20lAv0EA5C2IFVPEzmBUPNA+S5L4b1?=
 =?us-ascii?Q?30Sg8LA/DF8mGu59u8hvjIRah9ZiGCbrfRUMqZNF2lapjhOjz0DYESZqjLjX?=
 =?us-ascii?Q?fTQLS9Wa8TIMmA9+aAKF1QH5JT6JWZdOjRNNDambvWPxTLzL8Xq9l8DNgG+2?=
 =?us-ascii?Q?BB7r7rt9dPidMjkrDpE9ENDvV1IcJPDClcJIcI07BAD/QaO2C/kxeFyqSWqn?=
 =?us-ascii?Q?ddwIFaTUXvKjmlVDt38w2hmOLCgciqZEL0Rd71TTRw0fP5f+5RaRYFf35VZU?=
 =?us-ascii?Q?HEMAPA7zHvMGxq2x+opsZp9yyUee8DprE3c13I0Guc7/t74IUDj3MeqyAhmK?=
 =?us-ascii?Q?sor8rC59Btf+AiXdxVpR1azZYeBt29R7yf1sCAillmNCXdilPND2sq7y7hTZ?=
 =?us-ascii?Q?bfyksoLpazN08uElBWM4CjvAZPLRgkludBSm8vmceBAfyDaUMy3O/v0dhd+3?=
 =?us-ascii?Q?3Ki1GRUMSM/i/OKdPqo/MfZkKMvG6GFatmvYKYZpR6i6e30nFv5ptjd1ofNq?=
 =?us-ascii?Q?WJMfSNfVsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jhZmWZQSWSNSqHdDzfy1pZjU0iqL7ZrEmdoIIWvMEVYZRCEXbBIKkfs8wBHSaFxIn+7jb0tq8brwj9WkOf9I9PD2NGCeicA4b5c2wrzANVg/V13hYPE3Go8yZR2gpHXxWj6BAIQ2MuTQM8Ifx1yLWvTZeDJ+MBkyC2x1pw7cTMYl7H9s3zkRuza1dVwasAsQhTZphzB+qFs8JUNiQa6PHav0PtUDcQ+YJ0pNLxoRyf/q1ZlMm5fTJXxHi3iqnOtAwt6DSMVMcNUbmmNLF/d3tH7Vgl56ln0GVuvV+gaZ4bVJwh1tk8s4iLa0uN5G1J9NOSJLJpGdSbVpTh+znP6O8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ff8c16-0e3e-422c-dd15-08df1f5d6aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:43:39.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/7g1QetJg6PAO+z9EPzdVaMhQCUJhFrscOl26Qhy/RAAQH4sSTzVL25wc3qU+m6gJbLfvDfKhKFt6dUs7+MYWIzrVOv7ydxA6UPQUnieWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4857
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: Monday, July 27, 2026 4:58 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.c=
h; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat=
.com; sln@onemain.com; jbrandeb@kernel.org; Mohammad Heib <mheib@redhat.com=
>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: fix napi_disable hang in=
 i40e_down() during firmware update
>=20
> From: Mohammad Heib <mheib@redhat.com>
>=20
> i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it, =
as noted in the comment at the top of the function. All callers do this exc=
ept i40e_vsi_reinit_locked(), which calls i40e_down() directly without sett=
ing the flag.
>=20
> Normally this doesn't cause problems because NAPI drains cleanly on its o=
wn. But when the hardware is in a bad state, like during an NVM firmware up=
date, the ring descriptors can contain garbage that
> i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the =
poll function has no reason to bail out. It keeps returning budget,
> napi_disable() keeps waiting, and the whole thing hangs. The thread stuck=
 in napi_disable() is usually NetworkManager, and because it holds the RTNL=
 lock, the system can end up completely frozen.
>=20
> Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling i40e_down(=
). i40e_up_complete() already clears the flag when the VSI comes back up, s=
o no additional cleanup is needed.
>=20
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
