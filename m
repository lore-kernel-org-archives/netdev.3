Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1174C6520;
	Mon, 28 Sep 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608919; cv=fail; b=uuQQ2LRYBeJiArEwm3sUvREUqnnf0Kx+LXKvLBA93jZ2GupWeqZF1n+XyJgT604/WNP9AQiO3Udw1Tso8r60GvCGJtu1e8xNBNSHn2VoGJM8ZW4vjtcsHXPM2IEHorqrDYcAbElyhhZuX/JQ+ChkJ5O/P0naZ21ENJy01oc7H1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608919; c=relaxed/simple;
	bh=SVELm0I+DzoHgWaDG+5TXqF5Xr8aDYIIAqcLJSukQGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfM66a8C4czB3SmBArZi117JKp94U1ox5n0WX+0IPpMxQkfSKSP3YWlFbbHBPgkZmBqwu3D+26csjYP5Oi0c2kJCMcweSrDufIXLTergzth9fTvRPFTdMu7H90hz+uMDaeP8PiQ64aBbHG5lASEpOl8DVawykGdcPXakN09LBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUybU0h4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUybU0h4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790608918; x=1822144918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SVELm0I+DzoHgWaDG+5TXqF5Xr8aDYIIAqcLJSukQGs=;
  b=HUybU0h4WA6MQLeGXbgQ/+5d6J4113AO6KwU9qrchDgIOh4kvrpKsycf
   IRLgZm5EUX/PgRdIJC22y8mQkhgW9IyKTukcg8vsApvkP5nB4pi+WN5on
   R81tcRyVbZ9t/S+ccQBIWPoopFeRs9iKLglESSDwloS//qY+AY0RQVG0E
   gCb7dJWH/hcWV7m0nDCYt/TtBti/PiN3LlzXnf7/wUDjlF6tKNj/v6NMo
   8MGPqsjY4lpGq49fQCDMkiYmZ9I/VUpg2hSPmvkqOYuS0ieQt1/2qmDtX
   RHVahKdCbC0EABVepoOxCVf4/MpygEHBqKoVzCs00ZGUY/YkwtJCSLm77
   w==;
X-CSE-ConnectionGUID: M/9G1oOWSYK7AYe/msnlng==
X-CSE-MsgGUID: Vc0uh8c3ReyM2qUcB+ly3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116837634"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116837634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:21:57 -0700
X-CSE-ConnectionGUID: 9Habw8uzTXai0YibMMCVEQ==
X-CSE-MsgGUID: 7fROJ5GVRYiDz+/S+XQJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304588720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:21:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:21:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:21:53 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYrz9P0gdxNryvRWjEHM2jic2nFzdgJg3GfuFjqJmum8GnntFMx/mn6/Xiuv9ZDzHuMqaFBISVYeiJY3J/okJfC8GhZavXiNhYsvbhcOpGtMzj8APyF+59zCgt8eJpUk2VPL/Usw6JNuJF3xnlT+msu1cztFvjZKlXkecUe15yfIm+oBMff0Z05dECq2uUeM3aoNLcgzZzbRa88qfMLsk6Uv1Bxf+tAuc17upt9jSzXSEDsNWeisH6kvmNDxJxeh8yd18BBcbgz4C4f08PiMLefAPlmLWMxba6XaTG8Z9LNgUs+4UIVxK0eKzMujYnwNIfx29nk0AWFAAr0qGMgFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxijq9Bb6//2fm3rnc9N0kIVAraOcWhs9FJdfOx9hbk=;
 b=gQeNnECrjdTTT9nQhfMcjvqXx+k1rC6oTal6UnKQ9qckbCO961jrzJP0MP8UTGhGPvLunsZBpNgIxchEGr8UpjyZfX9xpxmvTK/P2SrL+YAY6tlcEGCBwLUqlRms9UQWN7CLIC8IR4NWQTmyY2S6QSSMHZ61rLzUo86u6l4+K4s77XHzXDos+B3Dav2iE45udbXX+Z41kMi7hhqef99Ij2a/LuF1gokFJu4IlTKWh/eOBDdE9VYTu41p6agiUpZzzAr/GAUe7W+utUC2tUqY00rI82dpHfr46HYdjt3GDk6WdaNt/fMGLJBdsRPa7BQzo/NcmQGUnHWFXJgsDWH82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:21:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:21:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Brun, Lorenz" <lorenz@monogon.tech>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ice: fix pktgen crash in eswitch mode
Thread-Topic: [PATCH] ice: fix pktgen crash in eswitch mode
Thread-Index: AQHdTT0DccHCALKZtE+mRU2oqa/MLLbkHy0g
Date: Mon, 28 Sep 2026 15:21:48 +0000
Message-ID: <IA3PR11MB8986F2F11D6594337EBB871AE58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925222645.354053-1-lorenz@monogon.tech>
In-Reply-To: <20260925222645.354053-1-lorenz@monogon.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 9c18e26d-f38a-4408-4431-08df1d743740
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: ggXxTsse4us6IaccYgWTo3KrsWLAeu6NWIjrkv0pqeJ7TDUhq09ylp+3HE0k0z/hrwOHJ35Tk9jp3z9HhBGiN7HD68y/lhgFg6YksYhADTcKV+LBW+bHcac/xYma9OESIFOGTBpsyKU8/+KCrnkVtse9LumQPmodn6UR1zUvmsEtlQW5zfJLR4fRBwMXAm7D7NiZP0+CWChWFWnF858Z43daTMKMEWr4WtVFlcZdXtWOB3g4IfnSjzL2xHs2Jy6yltAKDxYX+WjSrOnpnB9A8mWlpOOnPwBnYQg6zG0baQdktqgJE+EFGm9D3iKy/Y+OAtVtFEaUuONuzUDiY0Qr7kADyudz3VcB86ermf2cWXU2sqL07L56p5V32i1qXtuI2uu+o+PuYmYFPueFSC5Fyo2Rh9QJbtyZbLuW6HLE4Kg9fHi0SMXkkc1MOnD/o5qiNKU8Xe05Srdc/l/IBD7UW8MLLlCDTm3gTQ50vXsFml2i78NGgNWqtbLyG7Dc5wO6/YKmpt0JdRInXR/RsxJu2OrhF9WJIncAqcxh1Wb4u4GIJqn99u4VFBw0JzxXBxWl+jY17WKEgn2szZJdiliLRzk5kq1vBOwlAg6G3HnIqjTRkvrj5Qf0EQdCFCn6mX5lbQfWxcjxmHDCt0GgED62IaxojoGUHV9tMQQQViM8tHYD61NAo7cz0yAE1oQ3wCdMTJlV07BK2V+LcliHCFH76cMO1s9hSgYTDtPoyzKyJdty+SEVaQ/Xs9En9Cw4PsNS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPvFfbLpwfdtQ3A8ueBPi++5HO3Qkb1+umR7yiEzUNpjaeeHjfvD9Fr4Emrr?=
 =?us-ascii?Q?EeAQv2IivC5lqnGe2DsGbHjTti49ekDbUxtNAQ9SDgbYdcWafnZb6LbbYGme?=
 =?us-ascii?Q?SI3bIMXWDTJmBkJlmpBp/9VLPHbZ74XGJ6JI/mMO7B+D9vFVR3p2QUCjngQf?=
 =?us-ascii?Q?r/Ryxcf8IZ8nTNrc2Xen/tdnhrSqNGrFZjV3IG+J9sBcQPJISyrlqmZsRMQO?=
 =?us-ascii?Q?gJhYF+k1JdpSouPVIKwZEWbanKa5HJw4/A/D9TVIj53mzhs6g5XucSX0JqbL?=
 =?us-ascii?Q?uavSS12X9GDRk5C4IgA7NqKpsZY9vnsPrgDka9g4GNYTUiR1IJ+n8qH4JAHb?=
 =?us-ascii?Q?vyDQRPIWZgBSX7DqAjJClgkiNV0Ml1h/jbKFb8RinqSId8Dx6QJhWEyxpCyO?=
 =?us-ascii?Q?9HsnjNNUecoLA9l0xEnxXsGCtKLY8PCDKm/Aq5QqEBSANWIpRr7ujtam5Vd2?=
 =?us-ascii?Q?9QX/a+c0PJ50rBhSCKnbrkvxWiJCu23cwBEuP4oQxlvEzMbectoOVCkby159?=
 =?us-ascii?Q?JehYtCuQuLrRvUBNyyEtie2j0CXIMVrovtlMpfFmYuurVVQKo5mGasqi7ImW?=
 =?us-ascii?Q?CNrcf0YwtDs04pDukvz8CP+ou/WNkfwSs47LFW1DNGTBYnxim3iilRMsDx92?=
 =?us-ascii?Q?35LWtJ0rQqu60LcM8Ldu1aKH5JiK4mi/u02gOhbcgkLExOIbNR6073n++Fvy?=
 =?us-ascii?Q?wF7fR3yDuGT9TXnXJWAd2bUVmXuV8F9kVVABaurEuXGpsxXSJTyWlW0BFXq4?=
 =?us-ascii?Q?czN6QF86f9EmuSkHVl9eduGsDq/mki+SOaENxkNrMPnsl4W4W6MkaIWhqUGt?=
 =?us-ascii?Q?lAoOO6SFh8Q2CkDjh3vYlV6HWF/qFw9I5EObNO9n6DIdM1Rugj2+ZHu5ZC3y?=
 =?us-ascii?Q?2lq0tLOysnHf1bl3LsO/FnGqW39wuDGIdqU2VXrifN05pshEhYzcVqsOQREP?=
 =?us-ascii?Q?yEuYN6JakgGKTEVn8Mhz81/927nEJxSDTRrC5NgBm41qi1fq8uYJx12CJPYK?=
 =?us-ascii?Q?+ujnQv0iEole5SvR7Mn69hr8TDKFGuA8PcDH+5vz3fgOHq+JM1GmbpLXfIQ5?=
 =?us-ascii?Q?6+0BXirhK86eNaLlsCvWRz/ntW8zecNRP+P3Jbeu96UBinBiNCOr+xer7QQt?=
 =?us-ascii?Q?mpMn3/fWkO1hFp8Ghw4fK5RvNayKDKmFhrUL1vn7EYA8pkHpLErzRnYbex1P?=
 =?us-ascii?Q?50tYzP3MT2FVCe3p+SVhBZOY5OVhPFcedPXyQaUpV7I7JjfvFm8GlS7RZx93?=
 =?us-ascii?Q?zGcPtusQ2Ag/2t3zFmb7BeMnJd/o95KLbLlFXMtu2iUcj++o70C9AHsO5yoG?=
 =?us-ascii?Q?wtJYMkeCH+pY+mqLEFLZ0k6Ry1fm9vZIlXWEy1I119aLQ8go6N37S6VV+hYS?=
 =?us-ascii?Q?lgIgBtw2LksoUX8KCj9SspXV0c/jM6jsckkJFt5FmP/ZDRpkbihc3wXAyUTh?=
 =?us-ascii?Q?wVatDkH5NKNRoAJcray4vuVgnY7s0TVlEzbF6yQyaHyERrn5nwenQGdp+4CT?=
 =?us-ascii?Q?wCAd80XlbWZ6OgjBR1sjzHrNvkOZ36IgHzhpNSyrdk8TrtTzQHztg2eKDtIx?=
 =?us-ascii?Q?dhz4swgxI9a/2zntMB3xWbBEeB4SX63xODS7A5w4km85XDpOEudaeBXBfex3?=
 =?us-ascii?Q?0KJmK6O/UH4uKlxy+hEk8ApX6LmqEKMwhmhcxyVmMjbxRjg2ejclS11CqHo2?=
 =?us-ascii?Q?XLcc0pk21T4hWBYNhxFX2HQCHq4lQRYRiQ7BCSec7S7E8hw67eAqoLdqD0vb?=
 =?us-ascii?Q?AnDP5CgGxErNprYB0aDYhqUX0odOP0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P29h15E0ng6YJCoyBkVUu0HOhKUt5haKc+eR9bzST+nf7pH7Nd4rvf1ysG+i7ptPZC9LiENMlMgLFLB1QvCrpBpsRi176ZADQMiWfHabTQVmwpigFhptgfzFM6c1m1swLxwL1b4mYZi5wSbtH39D+jY+I99IP+9xPoFtgOUm0qBKtYG1+haFgJy6ITbc0ScMyD/4dNf3HxGnIV3gee/ntbG1uLEikb0Ja6StE78ivNT+7b40vc0+BcslacMIYhyBPu6wwDpYozJbBXeZurWtjnT2q6Qtjq4du+uxLmQQWFXU47ejeVusmj4Yem9dpoaP7OPV8XJ0FbG4BFlU4al07A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c18e26d-f38a-4408-4431-08df1d743740
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:21:49.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4X/UAA2RE6h0TiJmPOxcbw+fxAg6K2QO9yH63YX/6PYQZXoGyoGd3YyrzdY5qo/jGzIBIFZ+Jt3uoJDJkXpBRdb8yG+/v/ffTSRwIaZ/14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lorenz Brun <lorenz@monogon.tech>
> Sent: Saturday, September 26, 2026 12:27 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ice: fix pktgen crash in eswitch mode
>=20
> When pktgen reuses an skb on an ICE port representor, the representor
> forwards it to the uplink through dev_queue_xmit(). If the lower qdisc
> retains the skb, a subsequent transmission of the same skb overwrites
> its list pointers. Dequeuing it from qdisc->gso_skb then dereferences
> a NULL skb->next in __skb_unlink().
>=20
> Disable SKB reuse for this ice path to prevent this.
>=20
> Crash signature:
>    __dev_queue_xmit+0x5c9/0xf20
>    ice_eswitch_port_start_xmit+0x83/0xd0 [ice]
>    pktgen_thread_worker+0x82f/0x1c10 [pktgen]
>=20
I think this patch required fixes tag.
And if it's serios bugfix it needs to go [PATCH net]

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


> Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
> ---
>  drivers/net/ethernet/intel/ice/ice_repr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c
> b/drivers/net/ethernet/intel/ice/ice_repr.c
> index 096566c697f4..2603cb0f6a54 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -305,6 +305,7 @@ ice_repr_reg_netdev(struct net_device *netdev,
> const struct net_device_ops *ops)
>  	eth_hw_addr_random(netdev);
>  	netdev->netdev_ops =3D ops;
>  	ice_set_ethtool_repr_ops(netdev);
> +	netdev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
>=20
>  	netdev->hw_features |=3D NETIF_F_HW_TC;
>=20
> --
> 2.54.0

