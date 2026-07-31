Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF41E5B88
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505070; cv=fail; b=QDNn4G0zGvZTRFC8r0PVL13kPHTRjGImIeKmeWt2M3OoiZIAlSEVMBO6mBiLbRIWZUNi4Mbg6A9iBNaNsVKxqyOnENQsXoOjUi5i6HOGAqG/K4rqRqQzzQr3jMjRYj4wOv7owv9S4AKwFqM6CBLuiPrNDPte7DidGUUiDydAh14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505070; c=relaxed/simple;
	bh=rlrxIzWFPz1GQ8xav7nvwBXbKYPfFCxY29n1x8dRjgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgA3EaONw0uIGtNjcQJ+2pvm7acswTMCiVmoIR4cJBUBR0Uke2TXmnWgyQpB9wIy6xzeLikzmlz14HO1lwoSCJ4z2I+V4GcuY1BoIR8In26XwBV83WTcDLFuKLqRXDNfcgKdo8JzSaqlKMO7L1aG+EZ7bhVaKFJ4vBaGqz4N7nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDPctB1V; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDPctB1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785505068; x=1817041068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rlrxIzWFPz1GQ8xav7nvwBXbKYPfFCxY29n1x8dRjgQ=;
  b=QDPctB1V/fp4FgkJporxzV55kDbFZ38RUkv/+ewnHiFWjiMWxus2DLwS
   5nfKrbcRNHjfrM7JnlK4jWmPuFKeAcPNIsXIN4+RY6+fX8cDM7rzrioeN
   zLXVsau+ckYYCdPNgkXGPv4QF06zvfw24Cd0jAhx2A6CtnTE4RW+L1mwq
   uBfoPLUQFukwHrI6tqrxGM+sK9Qpgq6MXww1VbNdlFYcG46iCzLFWn+Iv
   uP1yKHb6AEr38ZHSr9+ghyOn3BYb1BsdNRwRuqlmcfTwKz7u3omshTcSn
   XwJFKeSHQaqOOyB45NXDk/tj+zzGBQ9enSF+TZ72wh5qR0X9N+ZGhKU/t
   Q==;
X-CSE-ConnectionGUID: v+QDDd3ZRiCtQY3quA64oA==
X-CSE-MsgGUID: 191jbVY4QgO7SIYjrtC+3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86248231"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86248231"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:37:48 -0700
X-CSE-ConnectionGUID: +j1RqHFrQxWkF/MZdCH5zg==
X-CSE-MsgGUID: WBNfSP1KS766dhdNXxuSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="258795022"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:37:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:37:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 06:37:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhfCWVpHAY3PToViJB4tG0EPtiLCvjnV/DyEcsfK0yM2StHmDpeYh3ch8HZfS59MbCo/6OKoMiH3hCUicIjZejBL+eSI3RrlfrTFR57u7ZKxQsTiBf8FXS+KU+uGc68FPbLgVroEvVvYUJmPUzIw8Rh4cjrhKlPdlFslTIHpFV/JLYP74/L14R1o//dmG9pyGpqo2hP6KITpBkpBc5VZX2z0gencTMLgvbcSjR4NJOygD3IhaN/R2RbQqrEcL2aYw/zOQhPdYIaVAkKW/Sikh0O7+rS4KHDgoHWMzmltd9RiwUtDE3Ok17cP1uQFSN/ZiVsACbkGcEl6lT4l0coOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r7kB69iKpdy2rQVQFA1mssI34NLJzkh60aQ6CVevCg=;
 b=c5iaxNq6YZWyqt/bk8JDMFl/nmGaXtPYAN3Z3QIYSUN0eVTkkpX3RxhWHQC1Zxj0UMTRzZODS5S0D7KW6IvSzo2amRvD8EG7x75q+NKme69nWFKi4eSl1KGw7szXs3jy4q8CgemgvBMvCBGZcmQt3EiJtAM/dOGtCXVjq24rp7SMIVNfwPu3z7gYABXAQT9yO+fvq5IC/c6QxcEh8nzLX1c8RZPPCptbiNqCf12ma0mkERC0YRfmycLIv5cnlYbWWmG/WhywbL8TfGSAhw+5XKNy8TIdif7V8SJ59ShRxq25JqeT8jAxIIFqw8MT6xc1Ji3RGLCR06b1bxZXS9Ksow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:37:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 13:37:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/3] libeth: add
 __libeth_rx_sync_for_cpu
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/3] libeth: add
 __libeth_rx_sync_for_cpu
Thread-Index: AQHdIOsZPinqtMiYIEaX9kEd+bGF1baHoYvA
Date: Fri, 31 Jul 2026 13:37:44 +0000
Message-ID: <IA3PR11MB898630CB0167FA981446F8A0E5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731124109.99065-1-tactii@gmail.com>
 <20260731124109.99065-2-tactii@gmail.com>
In-Reply-To: <20260731124109.99065-2-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: b548491b-db87-4e0a-f48f-08deef08e6c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|3023799007|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2t0s9tsS4/lE+Anl1C9I9F9hT+UBwv2XngOpN0TgdpEy+SSqOIp8IJtoJyXyCXmP7n5b3JhNTEimAu9pr/2S9k55UO9KfiGnfQ8PcadCgu8EVEVJeMeLggLzrGHjQofiGoK7N0agFW+cGWxEB7jyrDsaXAOuCAhVvUeztSTjN5uPnobPXLaLD0gX7mu0Z4mGeXOgijW1OZl0IxBht6Y94jy0yzNEQF9LkB2ZVsA+IzGMPOQ7VXlCNoIzJkfmQvasBGppQZOI8ZwHPW1GM62qq4epacvMhR+XmSwe9XElXT4Gz9jAGJF63vC0bjUsN3xlPwb7LLosx9CDcWZNJv4vcoi7U9eMKJClO8l1wc/+8kJ+zEgRHEeyuWOwr2bLNFqJvDPMyqIR/OW8qxFirvCHY/p89zaDyuR0M7mPxpwblI/O5QP+PlnS1JayfmkKNuUDZW90ilZw4Wfu/YPuFtBTcaIj5fSi2G1gWszG/4INS8kaa0WYF0WZvmJmZ6jFsd2vpZ+kWQpnXi40E6vTGDZXFzS3C2/i8Rn+ildRS8iRy46eQ1ozukFl/gpCvOPd7NIHBm+0kppVGL97AbyFNpb90euN8V6GxcaK1MV1z48uDK91RR5ef7IBlf9YiEcsjlP9Tf+zGnFKEjR0U/sFyb8PoSaNQtKFCdeATw0SpDJbN0pVLB7IWedBwRIq3qvVOnj1f8swVdmXSj+rXwmTRX/zYOej/YK5SFV8qm6UyB+eZW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(3023799007)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?euYac3S4jwHwo6Wdaob8TVg62l9cg+Wp6iVSbbtm1ER7a8EYKc06kDn5zhpx?=
 =?us-ascii?Q?y8hMzgiEYx1i6zzJsWaF1L357P7oCZT1w07xk7gqI9kJix0vtJbqn2VDvBCH?=
 =?us-ascii?Q?fHXvsqDNm8cG+KHLCsSLF3sxOsh1wHByND79mtjoXlUrEQNmX8Ya+sB5PrHs?=
 =?us-ascii?Q?yei4qbIbUYHOjZpbfP1Ll+1/oLm7WGqcq+7uLhmBLzwlH/rhR2v+cadCXRpW?=
 =?us-ascii?Q?mEPljf6OHh2dBk2WfO3vp1/G53wIGSO/n7NYxQB5dt86h8ymhJAMDbWG6JSU?=
 =?us-ascii?Q?EFuTaE4JH/9fYaHMOK5TxEXirwwHNfG6CsSUaE27i1zyrpcTt3X4aq/lpWE+?=
 =?us-ascii?Q?ZtZFeYFwTNszUsBZLthTcHKd2lh5uVqALm6tjDbKqdpUwirqnheUZBDW8DY7?=
 =?us-ascii?Q?0X/0m1+Si9VICmXFrtqgDToZIC0ZyMieXM7Qj1nvWUWo2FtB/dxRh6+pvgPG?=
 =?us-ascii?Q?cpie/cIwaOI22QWX9KcXFJlmdqLch7GYzvBMt6pJYlbd34luZWeWi5uRk+pm?=
 =?us-ascii?Q?/wF+SrOqLYEdqCEi0dYIbad3qdY0+ChNoGNJ5ygNT4XqXGAW2dUDsAZZ4eG7?=
 =?us-ascii?Q?kUF9h6y0kapMFt2h5s1UXw/nULp8vEzR7ijcFAm9wPiID1k6hu+yf4DpXudI?=
 =?us-ascii?Q?UDm5Vs9CysaOIewHTP7viSerjCBaITvlYZCtmp88fdinXU/pnZE0kcDjYjuw?=
 =?us-ascii?Q?P15GPwiPP80UrsqDpwC7bE177CeYCyAu/qgCi4nUIwHrgUvu/zsK27O6KUpw?=
 =?us-ascii?Q?Q7z2OZOkBCEzPQGXfIA0i0IoVaMHmq6h1GWsw3YvtTcbo+SBViz5kDmyVhEI?=
 =?us-ascii?Q?YLN76GOP/NwIgQtb7NkPFsLlyXQEbw0tHFYAn+TnKpnm08SeCNmzxJzskm3k?=
 =?us-ascii?Q?NzETeJ/NPFM+OL2CbBQBGyXV5Gcwem2Lu0YHr48Qo3g8OmqKVDW+chmXQBWn?=
 =?us-ascii?Q?9RyOeREcs2/ul36t42LXYNWEH9WeLyK1Ew28X7/C9lvsGLn3bHSkYnAPbpLn?=
 =?us-ascii?Q?tz8p/EiDokkXhoSBcr/7gwl4whM1+g11QatlT/wvtAfIDZOR523bGWVHmcrl?=
 =?us-ascii?Q?5aedPxLFg5dcRTBB0ZplVMevEtB2WhciFEMk89UEOJtLE3I/R4DOzXbSUmmu?=
 =?us-ascii?Q?tbzDnF3zCesT8g8nR+HTYtbRuWWPKsiGVNr8hubfjvTJjeYfqY0FArEEAlb1?=
 =?us-ascii?Q?ouacpXYzCV9rX8zBZ0FSvoSnd6ilpMVPo78Sh7u8wNG9zKVaRYj0l71spypo?=
 =?us-ascii?Q?WhDJmVjyAX4IaIl6HBbrz5DoJ3UJZ4ZSC6POZeTNiyU+z8kqZbbUIoAgg83Y?=
 =?us-ascii?Q?R8HA2b4ixA4JOvHCkOgXWgw7RMZS8fNqhwunKszGmxMIyY9dsk+W56DEoZce?=
 =?us-ascii?Q?fUFuqysK1y8Lxep2X76Z4f4YggLKMXpbvKNC9mpoMDlfEGNVN4eFGaZxGbJU?=
 =?us-ascii?Q?9yVTwTiH1Igb8hF39d/tzksfiwKfXl9uw+2Go59/HF0vx2yjkvoQzHLP/Vyx?=
 =?us-ascii?Q?DWLO9THYy/z4UySjjJlfKxJXLRbPilSJni8ocvfUr5Nn+yhYBSnPTIqReeun?=
 =?us-ascii?Q?omSzQ98nMczgS/NB9l965T4zK3xHt1NbLL18ZVlnsFPl7yIJEQoRzawJWdHL?=
 =?us-ascii?Q?fZTQ8YTn6dukAYors8JPLOgZjvSSTOs9MURZZRPewiaFrz2qy0Jmob0cCfAw?=
 =?us-ascii?Q?BP8m0XxvNUQmCiZXmDAdgacmEtdZauO0hNhFVwjmZvh5Q5lC0sNO6bPnPY2r?=
 =?us-ascii?Q?s5AmDtCpQtGbuVgeVWlqwS0xl0L8LoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: km2NyvDKuogskWg1pWVS+kCK0lvobnmwaka+nSyZvKQJK0bUFXG8XkP2HnAsN9TaBSfETGCDr6GXU4mQY/aGrup+03oXROZpCnBpWEmLUQtU5FPg3XRZYcuo5rVAU16otIXlPfz2aA4lWpzIFahHG4ChJEhRic6NxCTlLFITgBFG+AUJZsruGZEGLPy6TxFx2flxZj95UksPC95rqLQDJ0Mz3QI0Ngzgvnoije4uMR7NR/JPicEwKy7SBnExzz4mooDdO0dPWZjBSRuqLHjSvp4M6L3PfYkayFBkvjg2d37ei40dZ9yHZfc9XopXm/1Jg/7SfrJHzhjWVSwjnJZpKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b548491b-db87-4e0a-f48f-08deef08e6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:37:44.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anby2o/KDQ1QJ4My1Y1DmgYnH04HY52DDAj7FIT6/+fvm+YjBY3sqaxBQlOEWiPfF1y3NwrUrdzD/VSw1IiA9zxEKmTxFRxyj8R0ptI/PJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matt Vollrath
> Sent: Friday, July 31, 2026 2:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Matt Vollrath
> <tactii@gmail.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/3] libeth: add
> __libeth_rx_sync_for_cpu
>=20
> Deriving a netmem's page pool from the ref requires loading a pointer
> from the netmem_desc, which may not be cached. The driver may already
> have a cached reference to the correct page pool, so add a bypass.
>=20
> No functional change for existing callers.
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable
> ---
>  include/net/libeth/rx.h | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h index
> 5d991404845e..fddac084e001 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -118,36 +118,51 @@ static inline dma_addr_t libeth_rx_alloc(const
> struct libeth_fq_fp *fq, u32 i)  void
> libeth_rx_recycle_slow(netmem_ref netmem);
>=20
>  /**

...

>  /* Converting abstract packet type numbers into a software structure
> with
>   * the packet parameters to do O(1) lookup on Rx.
>   */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
