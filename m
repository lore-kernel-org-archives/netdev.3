Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE453FD55;
	Tue,  8 Sep 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878316; cv=fail; b=teSMWSsnTpJsJ9Afe/Bt//JvdvCBt38zdMWGRSnSBauMgRFd4NInsz1CVJ1BQBrQWK+cVLTnqGPzASC/6kwWEakMLo9+YhlKhDDesu0kvrTkTLMBWpqOHWFFYVNvgl2zMmfusIM3dZRka2E+JoRuNhO2GMC2xK+FMyAB/wo64Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878316; c=relaxed/simple;
	bh=tUSlClXU3iUYEvXuAiqV3CZVIl5I9GoL7JchhI3anYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrMRvKh979GvkMidubc6jCU4gy7aceRt7KADq1/Kxvjsj+r6NDzGl7kvkw9U+dY7VuWfj3Q25Cynh70j50Sc6HB0tQAR260oXNJs/zhosjKbtMzIgBdvK/mDptRcH2g1oTE2LlMSNq+N0DdFoQagGYGuV0eckt9w7rREPBPj4kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENFsDc4H; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENFsDc4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788878307; x=1820414307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUSlClXU3iUYEvXuAiqV3CZVIl5I9GoL7JchhI3anYo=;
  b=ENFsDc4HE8pSlqcC4z6fk7YIiJMU36kBTt3LWJ/mzxK436E3fFurdvYR
   CB2Ge1Gj++FL9kfADpHqlQSJ4K6XkaS3CDwyEjpeRmqAZcvA70l5tV0hH
   F0kZARD+G8AgvkPc+izAsJn1nAtmtcyRT/RZDMMeOZMcNsHp/eJSMqCAx
   4Yg6Bme3yImu2lK2S5z/NrJQevVm525qbqBg3rSMoU7IE+OJPQ2MzQE+2
   5qN0DarUXNP4e0ic3r39KTDTCuS77SWt6LpssoMgnfomywNt7XjNoC2X4
   mrgu0/Nu25r1l7wo+r4fFkzAhoHlevq0Z4HLMH2prrKixOIUGX/TBNfsm
   A==;
X-CSE-ConnectionGUID: 3UCZv6VhRxqVSL21wq6SYA==
X-CSE-MsgGUID: zs/OrMcgT7S1pxPBXr1W+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76842493"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="76842493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 07:38:20 -0700
X-CSE-ConnectionGUID: UzU649GYSqy18tCJaMn+cA==
X-CSE-MsgGUID: Of9qtgaqSIi/5KiC2PJSsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="270538250"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 07:38:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:38:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 07:38:19 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9RzLVMCOizA2XJzc45Brlv7EpWfX4vFIA8jjRd3wCRrhA+cfMO4HE5+Rw5RVg+O4z8aYM6S6nqOfLscPM+tKDQTIG29cuveB0Gjaj/nCMFyCNecpOaSML71sPF0U7/YhT1UePvsd4uOmS+hbJ1rZUiTu83E6Er4xoKglmTzp419ngJeeHbmCf1Ed+nCHW+v0Jw/21khiuBrQr4eHrx2juY0P2JcSfIi69IzLTTFs4Unl934nLM1CqrPnE4Sri3M8m6KrDqBJ94P8PR9MjZDASsrTqctei7x0Vj73b0NPwgyM5OB8IEcFupYD0JCHYrQfQN7DrPAOGLMiJ7nk9g05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAAySJ/HGLw3zNpCl7sMYQsaaEtaf2+ySo60jbBjL54=;
 b=Hu2Q3V5BV1EWmQh+Fxv3oycaKf/9FdRv+La3TZSoWrZmhd9FfcUoxUmZU+oQBCom/hiLb75YNbEXJxJezbSfn4cU9k/6qkedyuTKudMY/Q1diUVeBgFgXb5V0gfoYrt73g3vlHvMsGnWOjco3rj54qM5o8scfCQn552Ckx7J4SWk9pHHeg0SUzq9EitZIWbnEAmk+MOaEKKNRGC1iuacfqqloERdY0VdhJYIgtdMtNn+gYLVQirrfcfVkQsGvvb8UQRmwgo3+xdcxAU0QCpLuLUut1pykugONHN8d1lxOlO8qepPjPm6KZ19Rys2HMV+Vj0h+RvNDXttUg459TObpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 14:38:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:38:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Henry Tieman <henry.w.tieman@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Thread-Topic: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Thread-Index: AQHdPr92ImgMbwgB4EGzWggNwC8en7bEwXJA
Date: Tue, 8 Sep 2026 14:38:14 +0000
Message-ID: <IA3PR11MB89860C9B0DA0FD32E238516CE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB5821:EE_
x-ms-office365-filtering-correlation-id: 52f4ed3b-d38a-4d5f-c20a-08df0db6d0cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|921020|38070700021|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: S913VfVKLroE3MIQC0Gfyc1Nh80v0hI6or1Ty1w4fOEm1/Dkvypzfx/JH04XLzZtoeT9/5Rhls5N68LV2cuyPZh8Ggnshb/G1dkPu0dx9QwJEZJht+Bdvh8OXDzBHHXxdfNryxBZZqCQ5dHFB77tgPOeEWfDBxDXk1LdiRIASkY7BjJsnn2Uilet+5rJotGCiX67Pq6RoetmVYIvKAonoQt4V86zAIAH5q/HohIfuIRuIJymwJPEkVJ0f+HhinP0ql3ws5XgZaA2xvaJyy074bHSDFc/k2OR+0LtdIEBpQ/VUxb5cQoD4rGk/asQ5rtQMdyLP0AOyGm89yQlu2ftDUHswDktlwkugKuiJS7UM0nPvgOmqGR0Spd3Li8AyhWdxDzuBxLNsu8Cew71pfbiaTOjOZb5UCCt6x/aJiA5VP+wu5rTrvnIz8Rrjou4haoEAWVusPlCLXOgI9KDaEmmoDjcIfM8oZWSHtmXTCipyxjxcvuKB8M2IyT94zwXjviVYpkmKxFJrrma/3nnNxXyoq2yvVuR+ZFTPdtgbp63Vv9vBrUZhNLLHiqljQFoMMXE2O8yjbclYz3i/r+ltmZl1JfF4bknby8tNHmax32QkqsSZcym6lOgAD/uym//Hdur+crP9LUkqQnucivlND21TdovvM5m9ZdJgSAIkOKTRFn1Z+oeQlXzpVRhP59H52DZrvWeLC//1iIpb2BvpOCblIyIjMx40bzgpYWojnsd2Xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(921020)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3DdJoRospr8poNnzP14DZR8mAAWQJ5rQuUMieObczEW85KRzug3DMdrDYAt2?=
 =?us-ascii?Q?wuEDbXz4zWrJKK2xeK+RF2f5G7MNNGzvH90eq4bsNOhOvETna/5BWOxNuI+/?=
 =?us-ascii?Q?cejZxAKW/rYnA8abVLr1Isjw5yeyAtecb1OYYM70cDZ8mruOxfj3uEMdXQ2p?=
 =?us-ascii?Q?qNJog7dgriH7p629bhhBvqt9mzRB4zW+UsD4B3KsyGX0/oOBPujfIysP7udK?=
 =?us-ascii?Q?pjoozk/3a4vEZ0bUoLpZ4+gkGERG0hJpz6b5+cH7qvdwfrbn3zWN/8XL2gAJ?=
 =?us-ascii?Q?J7FfcF8i/7C2TCCv6p1AXfhEIQhMjes1SjlYmkBW7o2zyrXg4Jkm6QHqklB2?=
 =?us-ascii?Q?IKNACN9baZl1i6aQSz7g7gmS/JHdoTMa5b8u9REw1TIfBdlVw1PQOaeYkXl4?=
 =?us-ascii?Q?VLTd7SYxCAFfEfjH5wxNDa30tHsorqqjPxDrgKoD5o5pNc6UD+6VS55Ndzfj?=
 =?us-ascii?Q?HG1Nko7uvpEeEWpmvOGXRiX5+edXcsIfykxTvzkHa/FuuKLsQ/5BXdC930y6?=
 =?us-ascii?Q?/Al7/quQeesFrYLi6QQyJwzpHmxjsCFKfDN7a/5TsY3+TIzx+YAx4Qrxt5di?=
 =?us-ascii?Q?Y/fg8T3cIj69KsYl6wHMkJrV3WsWq5NKP4/KPDSjcrhvDfulTearkgGRoxZx?=
 =?us-ascii?Q?HtyLkNHEuuPPKy1ozhVJR6y8Sy2TmW0CdSbmh9+IZZWosCLkS0rqHci3hVB1?=
 =?us-ascii?Q?44BgSQstZ+lqwDduQhzQXOe4BsYb+nHgUjKKg22rIvoYAEMCSAuT6Zmpjxm5?=
 =?us-ascii?Q?UN2KxgfR06APB8XFOBZaR/i/z4Pf6+f7DKMglG/WLJuer9AEAsRfJ752WyIY?=
 =?us-ascii?Q?r0iX7PaOA9Et/gKoIKfKtvaf6DcvTcWk04oE4st1R7f3I93NNWBN3brnkgSW?=
 =?us-ascii?Q?+rCR1D63pxtv773jYYwVwhGBRGGetyBIgF8X1KBVlXdrL4Sq89Smj2jKBScy?=
 =?us-ascii?Q?h3Pg2Gweex3MiDI8uBPtvCRKB0OSIUoHeZhQpR/CThrZsQCrAoQG1t8bYk+n?=
 =?us-ascii?Q?CMpG8ZjSqkzQMM+kJAUdzOaSbr+MJL8TFTi8g0NOrIuXOTGnqmVbz2S3TmT0?=
 =?us-ascii?Q?WRFgVO9sz09p2ylF9qfqtw887b+rmrPmQO8Ogcrs4/gXVlIYcfCP0LRm07OE?=
 =?us-ascii?Q?JI9Fs9XHbTBjDP/Zaau6oNPH0oqaVi6AgL+w2EZ4qGGwK7WnxXR/bMUMA01b?=
 =?us-ascii?Q?uf8e60NL6Kjvl8jGLToqGVo533pI3WYqNcNa6DKWrGojUizMK2tPCNife+yo?=
 =?us-ascii?Q?TOUaQW64kUWrtRSSRLVEdE2N1FNGpvJy7dUM3GBguA0RwBxw3c8xG7zAB+4B?=
 =?us-ascii?Q?F6kczN0IGTc8r0YycSA5k1DOZd1C7IS9yaGGZd6p8oTJFgUmAi39dmKCNir3?=
 =?us-ascii?Q?4ChcSPuMY4l4xfPL6UWPpLdc4wFrXr/DBTFehghXggZIUZHMAQfLWeXmZlNn?=
 =?us-ascii?Q?J0P2WNwl61E5AB1oFZeFQDg0qhCIIF0/8By3cv0KUdxN2HFF69Ul+7HmAtUH?=
 =?us-ascii?Q?h7v144K1+rfWGiU2KtdQqQEP9kye+SANT0ooj+3GQNr1gBLvhUv4SM/zMir4?=
 =?us-ascii?Q?sTbIUuWJsGOXllpxmtsCPsXHdK43ErESmYnU3pUWW+Nycfxun5ZCPfRVZ8to?=
 =?us-ascii?Q?zbKkt7yCB34UglUJFFs/FL8AxWT8tqc/63kYmkgNTw/RiGHlpt/ZCiFMrI2d?=
 =?us-ascii?Q?Jr5R7+x4CoDW47OWJ2TbIsHzGxMDIgEI5URTCIakb5i7DsuTq8UNu9S1Yavu?=
 =?us-ascii?Q?ic5OZ/RJB9e8Pk3xgmayrubhrSD/MeE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fy0ztzgqqpbTltnjaMqP+RXrasnndMPnOBhTK8bnNB31OolePRrb21lh0SArmI9MZszVi7mIDYhlio4LHhw40p1L9gzqLrIDqVXfdBn026Dq1PV6diI+rKznHnJP5svZJcs+GxcgDkLkfW0llKZulF1feznIfQctaVxGWR9oGxqvEAyK9LS1iCyIzoeNrMSGuy7ISaWqd2xMNrk66xUPXJLnVHqCtJAtMTLDXaD30q61ImemWB3R7Ea6uhxZ0ZcJnP9T7M3XE5XfEsMoBFTQgxbyYkq/TLNaHoMdc8d4+hJDHCCT8PufgWdH1ftUhc1yuWx6GnIjA+rkK4ytyaetKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f4ed3b-d38a-4d5f-c20a-08df0db6d0cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 14:38:14.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSGnsbrVxvADb+IFjO/MeFST2zXyT/AuTcCv5cVfeyrN/2HhxAIEDtP4S4+ecB7gdlokQi+lAM9b/PeUqkI6fElWA+XtRp8JEfjIH2kX9kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, September 7, 2026 1:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Henry Tieman <henry.w.tieman@intel.com>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
>=20
> The firmware package and switch recipes are shared by all PFs of an
> adapter. However, each PF rebuilds independently after system resume.
> The resulting package downloads and recipe updates can interleave,
> causing firmware timeouts and leaving interfaces unusable.
>=20
> PFR also clears package-derived firmware state on affected devices.
> The existing PFR path only rebuilds the driver's block tables, so VLAN
> recipe programming can fail after the reset.
>=20
> The failure is reported as:
>=20
>   ice 0000:04:00.0: Update pkg failed: err -5
>   ice 0000:04:00.0: package load failed, -12
>   ice 0000:04:00.0: Rebuild failed, unload and reload driver
>=20
> This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
> revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
> 1.3.43.0.
>=20
> Serialize rebuilds across PFs of the same adapter, while allowing each
> PFR to complete independently. Reload the DDP package from its cached
> copy and restore the default DVM recipes before rebuilding the
> remaining PF state.
> Abort recovery if either operation fails.
>=20
> In addition, stop the service task before tearing down resources in
> ice_remove() so that an in-flight rebuild completes and cannot
> dereference
> pf->adapter after ice_adapter_put().
>=20
> Fixes: 462acf6aca85 ("ice: Enable DDP package download")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Stop service task early in ice_remove() to prevent use-after-free on
>   pf->adapter if rebuild is in flight.
>=20
>  drivers/net/ethernet/intel/ice/ice_adapter.c  |  2 ++
> drivers/net/ethernet/intel/ice/ice_adapter.h  |  3 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 35 ++++++++++++++----
> -
>  .../net/ethernet/intel/ice/ice_vlan_mode.c    |  2 +-
>  .../net/ethernet/intel/ice/ice_vlan_mode.h    |  1 +
>  5 files changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 2dc3629d6d0f6..7de9223e971a7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -64,6 +64,7 @@ static struct ice_adapter *ice_adapter_new(struct
> pci_dev *pdev)
>  	spin_lock_init(&adapter->txq_ctx_lock);
>  	for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>  		mutex_init(&adapter->cpi_phy_lock[i]);
> +	mutex_init(&adapter->rebuild_lock);
>  	refcount_set(&adapter->refcount, 1);
>=20
>  	mutex_init(&adapter->ports.lock);
> @@ -77,6 +78,7 @@ static void ice_adapter_free(struct ice_adapter
> *adapter)
>  	WARN_ON(!list_empty(&adapter->ports.ports));
>  	for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>  		mutex_destroy(&adapter->cpi_phy_lock[i]);
> +	mutex_destroy(&adapter->rebuild_lock);
>  	mutex_destroy(&adapter->ports.lock);
>=20
>  	kfree(adapter);
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h
> b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index 4f695f32da3d8..f9265de973efc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -37,6 +37,7 @@ struct ice_port_list {
>   * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
>   *               Index 0 =3D PHY0, index 1 =3D PHY1. Used on E825C
> devices.
>   * @ctrl_pf: Control PF of the adapter
> + * @rebuild_lock: serialize PFR recovery across PFs of the same
> adapter
>   * @ports: Ports list
>   * @index: 64-bit index cached for collision detection on 32bit
> systems
>   */
> @@ -48,6 +49,8 @@ struct ice_adapter {
>  	spinlock_t txq_ctx_lock;
>  	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
>  	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
> +	/* Serialize PFR recovery touching shared FW global state */
> +	struct mutex rebuild_lock;
>=20
>  	struct ice_pf *ctrl_pf;
>  	struct ice_port_list ports;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..abb6e850ec09f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>  	 */
>  	if (reset_type =3D=3D ICE_RESET_PFR) {
>  		pf->pfr_count++;
> +		mutex_lock(&pf->adapter->rebuild_lock);
>  		ice_rebuild(pf, reset_type);
> +		mutex_unlock(&pf->adapter->rebuild_lock);
>  		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
>  		clear_bit(ICE_PFR_REQ, pf->state);
>  		wake_up(&pf->reset_wait_queue);
> @@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
>  		} else {
>  			/* done with reset. start rebuild */
>  			pf->hw.reset_ongoing =3D false;
> +			mutex_lock(&pf->adapter->rebuild_lock);
>  			ice_rebuild(pf, reset_type);
> +			mutex_unlock(&pf->adapter->rebuild_lock);
>  			/* clear bit to resume normal operations, but
>  			 * ICE_NEEDS_RESTART bit is set in case rebuild
> failed
>  			 */
> @@ -5374,6 +5378,8 @@ static void ice_remove(struct pci_dev *pdev)
>  		return;
>  	}
>=20
> +	ice_service_task_stop(pf);
> +
>  	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
>  		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
>  		ice_free_vfs(pf);
> @@ -7674,14 +7680,27 @@ static void ice_rebuild(struct ice_pf *pf,
> enum ice_reset_req reset_type)
>  		goto err_init_ctrlq;
>  	}
>=20
> -	/* if DDP was previously loaded successfully */
> -	if (!ice_is_safe_mode(pf)) {
> -		/* reload the SW DB of filter tables */
> -		if (reset_type =3D=3D ICE_RESET_PFR)
> -			ice_fill_blk_tbls(hw);
> -		else
> -			/* Reload DDP Package after CORER/GLOBR reset */
> -			ice_load_pkg(NULL, pf);
> +	if (!ice_is_safe_mode(pf) && reset_type =3D=3D ICE_RESET_PFR) {
> +		enum ice_ddp_state state;
> +
> +		state =3D ice_init_pkg(hw, hw->pkg_copy, hw->pkg_size);
> +		ice_log_pkg_init(hw, state);
> +		if (!ice_is_init_pkg_successful(state))
> +			goto err_init_ctrlq;
> +	} else if (!ice_is_safe_mode(pf)) {
> +		/* Reload DDP Package after CORER/GLOBR reset */
> +		ice_load_pkg(NULL, pf);
> +	}
> +
> +	/* PFR can lose DVM recipes after system suspend. */
> +	if (!ice_is_safe_mode(pf) && reset_type =3D=3D ICE_RESET_PFR &&
> +	    ice_is_dvm_ena(hw)) {
> +		err =3D ice_dvm_update_dflt_recipes(hw);
> +		if (err) {
> +			dev_err(dev, "failed to restore default DVM
> recipes: %d\n",
> +				err);
> +			goto err_init_ctrlq;
> +		}
>  	}
>=20
>  	err =3D ice_clear_pf_cfg(hw);
> diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
> b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
> index fb526cb847764..58fb191903a75 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
> @@ -240,7 +240,7 @@ static struct ice_update_recipe_lkup_idx_params
> ice_dvm_dflt_recipes[] =3D {
>   * ice_dvm_update_dflt_recipes - update default switch recipes in DVM
>   * @hw: hardware structure used to update the recipes
>   */
> -static int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
> +int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
>  {
>  	unsigned long i;
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
> b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
> index a0fb743d08e20..5dc705435f56a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
> @@ -8,6 +8,7 @@ struct ice_hw;
>=20
>  bool ice_is_dvm_ena(struct ice_hw *hw);  int ice_set_vlan_mode(struct
> ice_hw *hw);
> +int ice_dvm_update_dflt_recipes(struct ice_hw *hw);
>  void ice_post_pkg_dwnld_vlan_mode_cfg(struct ice_hw *hw);
>=20
>  #endif /* _ICE_VLAN_MODE_H */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
