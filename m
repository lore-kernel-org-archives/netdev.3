Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600021A6811;
	Tue,  8 Sep 2026 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858554; cv=fail; b=sUqTiDV0/x5D54BvuH9e7Uk2+NXCh4bMZm6mvsqvgrNff6xf7aEHsTqv5eb0xNOlQng1sQV79AbI85kLWFYAPw/AZYlYI4O1sZptBcabQ9Inwz6/vs4HXoSqkFSzn4/gTPB3yieJ7anu4b4mk/M9qG5/36yIcJohktizKm0K0f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858554; c=relaxed/simple;
	bh=TOIoWQVoE2U2VNq5gphXANTyZkTlsBkjnVnUUYjTddA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SEwDykVs1YHbaOtVRKdrSkEkJoKzQds69xuMavToj5tSo9ybN8lSehB5gGmo+KtG2EsMl8shrbjtFiVp6NbTblc/IAQtct/UhSa3JS4uWaQC3DNul6Z7B1p1ChiZXSgeVmfPQef3JTfKHbUCVrgaGf/HY3PZFA70sWaQBLdFk84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvTkRf99; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvTkRf99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788858553; x=1820394553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TOIoWQVoE2U2VNq5gphXANTyZkTlsBkjnVnUUYjTddA=;
  b=NvTkRf99B694CJzJPRj2QSURzj7GkXEl2mwO7sCMZf6p+CZCYqq1qXH6
   dHF/U3pftGfny3tX/aeTryYuyDovlHFS683KBrOaLb8UWKr24cwX7G2vv
   S4z/8f/FOcKDLRhEdp26Omug94fnBue4Buww8aTJwc+QudnSm+vmTtomG
   rYikmcSgSBezautRfuey95XEXTQAhqd1pIJpQ3WENUwiDxzaih3vc4CWy
   V5dYWxgNRNjlOyLu734ibEzYrowxAKlbcMAKaSRgbd+rNt7pO22QPSWdT
   hzBef+4SyAJWiPoi9XY0e2VIGRVqr8iUINztoUi/JVC0T7fH5nup2x4x3
   Q==;
X-CSE-ConnectionGUID: eso6MbwnSIykk8LyJQRe1A==
X-CSE-MsgGUID: EyfL8s/kRU+KvYjHF6OJ7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="112030775"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="112030775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:09:07 -0700
X-CSE-ConnectionGUID: t5CgwVYaRlquuBg+utYBzw==
X-CSE-MsgGUID: 9qsgQXVGSHCDxGE5Qs2BFg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:09:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:09:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:09:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg7ShjCWgJd4wiGbaRJ+wWZieqZgHu+PzAs4iTTMyic4huTcgcjB/A5ovh8sVgPaxnI7RcoSfs36yMOQeygKFkVkVeHUgPeQ49jIrGpAYORqWsbTtSBlxf6r1bsOk0J9AbP+wAZzTLBIAhAuiwFBsHoaokVUgHvOAkDaVADQZEZFfUBZwz25E/b2sdXLoOnSqBN7Do2sRapV21URIu+ZJyY4ZIs/tGKXsgz9d8ZN1NDNRJ9ClvFJT4nPNkuhzgEv2UgpoTFZkgK8GGBc608Zpenpf0AH2EmUEO1CwPduglBs7uvQcvfWy4YTZcDTA1JmRKJ4Qjeivfj2EmDuiRCJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIKfPFDrBegPC2tzdtJOfa/VgLHEGbs3RRFjWYinfoA=;
 b=PU/jXDqGVHR1EFtYS2yvl0pE8OnAjtj5T8t7ZIZcbeqzl1ZAVLRNYXH9IujuDlOZ82RT8Y2HvuU5Tpgw1zglafunw0b3zaaLRef6W458zfVbVlHIb6yY1gJQLewkZLq7bpZvPWQdqPSLCEwrThZ19NnyfCOcq/iyq79/cESDRhuSBignNEccjNyuL2BqMs3rEf4ls8+91xuN5wZk4InbnOYY3xN6Tz37kF8Jq7pOOZBJgC9KJZhsU9VDFueAVVvNJVwuz43SsHZx/WPVnt8VHDwL3edx083sW/HCl9XxkN080xIToVKnrdW+Aa1l5HelvJGMrpBMf/vqnY9gJBA4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by SN7PR11MB8043.namprd11.prod.outlook.com (2603:10b6:806:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:09:02 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 09:09:01 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Topic: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Thread-Index: AQHdPxOI5Bym4XcAaES50yR2ug5Ww7bEZP5Q
Date: Tue, 8 Sep 2026 09:09:01 +0000
Message-ID: <MW4PR11MB68640CF830DA38CD3057348580B12@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-5-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-5-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|SN7PR11MB8043:EE_
x-ms-office365-filtering-correlation-id: e77079f3-9906-4c76-4fed-08df0d88d300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info: Cahm8HGkNeu214XG1I3lkALNeWbCShDyqIQTyx/g6qt4cnFPH8uK/3FiFap1N9PbNJmAHVBtXbncvg1mlGXaCCfmC95AIBI8755YHDlBSKmCgo6DIzB/MKYhgYgu0qMmA4YIsrVNGqshTXWxjJQuG34WUzo20JUtf8sYkHtYMzObS1ApltmDA9rUt44L8/+kHCqLD6Dz4yI2k8IOcsWx2ewiUvODMIIhTUl+mSLGrp3dwcG+NsbHqb2u+/FGTPw+9Rq1jIBOldN2bqj/LvMaSgPFPqBzVZ4Tu7zsBMCiiawePCE21DFE1iUyKQNGxpjHuGzEPBQVffjDeVmHrR60GN/EEIqbmvRyKGbz+9drqLdEP2U1T3OY+CiHcaVL7iM3+GtNIRKSE1giRy/H9HPYC9EMvnJRQde1rMpUk0OELfB5mHOGVHFjvzL2UaeGVukMR0FCd3mbgtwpdghm/p0vUy5Uauwv49Ko/8xKRvkNoEtrXoBj7WKCfRvvszEWh2LfqhKkxgF3BCpL/+o0iexo2yoxykEmYI3ECeRvTKxf91ud77Rofy0jGnDXdxJ9z+Tr/gDcpPAmpjbiFxFH8uI4dA1LBIvoiMx7mWHvXchS1TM3AojOWeUEI3ExGvw8ifPK6mJdxXBbQdedQj/IBxuitzthpQsRiKi1xGpa7KLj3IjLMzkfVs6AdZK/ScyvxQs/6+2kga7nFPXTQPW/JarwGhJwByoHj2N1cuFe4xn+VFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjlJXXoYZ1vfKoyqfRKcpe6aVkym0AGE3/Zpo2q8g2zkicQgnCVkEEIJ9TlW?=
 =?us-ascii?Q?nRy5iXv9FrB6ZYokg4qa4gNnNHtCyH6osbZwu3uxISNyRSxmbB7X+jbe+xCq?=
 =?us-ascii?Q?2RNWGFpGDlCsJ9e3CvAFMOGzJkiMcXIjlaBu5n2Effa1iBIA8mctzCdvrqH4?=
 =?us-ascii?Q?IQZWJnfV8zys8b3edNAzqezDspjIhlEv28jYu8OZV3mbPE2ZOhV6pwNTLkWz?=
 =?us-ascii?Q?PqQMj53HdXFd3F4OO6NgVTHXjWCgvHKpN1n/ZL8vv8KhLlN8Rl3SIt2UaT7d?=
 =?us-ascii?Q?UWW3TrDaWLlVgTKwhtk7hn1ts7L16WJS/LZrjYCse2ZidXhVF2Tg+hnHPkRx?=
 =?us-ascii?Q?ezE4Z+nf3zp6FE9frQbi9Bk+PvrPALdJttt7h8zgAIIC41o59QUanny5PVcC?=
 =?us-ascii?Q?ypAJIw7UOMCKnAqFef4jstt/seKxqhZiCkEaP7uU0H8WP7xU+S5JuJoZhwCl?=
 =?us-ascii?Q?YSCxW1qGXNwJTqQgKz0m10PFo3X29VvjWhaLYodsQqxR2fta4cDq7wMVdJB7?=
 =?us-ascii?Q?mLgCR6yV4g4j3B3RZ68FXjiiJ/CyflIskQ1dhHdGTUvigxLGlS5W9L02L6Qw?=
 =?us-ascii?Q?feuk/wZ4P4xOA4mn09nY8Ayt2EEf9/HSEbe/uAyhCTTqiS7n2CQxVHFlAPEa?=
 =?us-ascii?Q?MEnnk/OFFlMyJjhI17ERcbYtdSKiVGRjWi34f4wZ5uK5pPSY6Kb48zUfjCgp?=
 =?us-ascii?Q?uytVRBu3SY3B43phHpgomN07T8ilwi9IXgipLAE6y97wDNNc3+nllSmXIJP5?=
 =?us-ascii?Q?X1YnfzZvGpPL8hDHWq5E+L5g4YEjo17eVrGFpxmvFMydOIdfLrUNy9boZedX?=
 =?us-ascii?Q?KMxw+oHoYjYMZ4b0S3l4T37hneZZ4q3WaZ8chUpYsITaJqXpmfFcEb1J5Ogz?=
 =?us-ascii?Q?UC+C/N/kGC4OHT4uq99DK4uTqyXa6+G59FvUZp9rp9scMV7dIuSuYgNanmSA?=
 =?us-ascii?Q?3VDVlh2nqhgG3G7aYV5D30fh+o/xKRxPPp40pDxh2p+K821vBHf8mqI4kACz?=
 =?us-ascii?Q?ecBb5UsAljN18I19ir5gA4McnmqR8wWV57Bxe7J/Dm96txTjBeaIISGlciOs?=
 =?us-ascii?Q?CGMvEDl6u3yPGqjcxfsfikcCRbRy+Ggavr5d9auFFOLWO4//HwOF12Fl1Vy1?=
 =?us-ascii?Q?6qr5YHKAUt+JPFayED0r6QZM1hSVS5qBY8LEZlMEmSVTaLADcmKmvk96uhQ2?=
 =?us-ascii?Q?iTB6n9Xicii7pd43hQLpqxZf1PPy0dcVrEC6DiIlLAY1KJK/dGysFJFEH4NC?=
 =?us-ascii?Q?EPMekh9X01vIG1phw1iIpelOd5Ju2UoLpOqrmdAlKkxeL8CR/+SW5k7H08mh?=
 =?us-ascii?Q?+6J4LFi9fuhkD7ZS07BzewV/BbLst3FWsImZH+KHNe59WEARZy7NHNT4LioY?=
 =?us-ascii?Q?kXF7KOAvsofRSlBfjjXsu7f4JK1+C42EELn406sOprr0/3ACcJGexa7BDVIz?=
 =?us-ascii?Q?21kHIZIEC7TZ94QSv92QAt12WSMWmhbkcp1AdOMFkAThTfp1xpy8pyYro4sg?=
 =?us-ascii?Q?6eKM6s+Yp6f1QzzR5n3T9MXpfFS4U2tUyqV5DeLgu2ZYNZYy/PrZiHLxBQDY?=
 =?us-ascii?Q?2LkhhliFDL9ZJIMDX7g6ydvfynqrZ8v9P7lx1CkRNW9XKXMDqbTx1Yd72QK3?=
 =?us-ascii?Q?5FwRHY+tEokfyXx1jY+7sxZDYnrQ6KUYQTLY5Ir5Aq5Umk0qvaUdE+IW0g0y?=
 =?us-ascii?Q?dRwieX9LlT0EJVXj8uoBAH5JuZMDwH6K0T55ZyfBGw3XvB2NL+gvhq7B+fAN?=
 =?us-ascii?Q?eXI1wMasLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uEWgWIKLpro18f/+T9MiHholtlb96hrBGow4Pi5b5LaHBcBL07XrhR30BMXhJopfE/l3d/HsTwdXKlZyP2ycGHRyrLsoM9OYdpTVtt7zs06gBzM1Q27htRQXBpKlH7g9Vabfj+sM3yLGtKOmFYFwY1wE1ntGcAkWHbscPQieq354anlCZYfx4Hh7I3v8U6qv8cWytP/iahS3UImk4Hl89hi8Nz/DHHORWcVe84PKwq5tPwuRqT8wo5XtDh8wTUFddYonaE0irlL/GxqO8goP0ZjHr9m+i/XITKQQoccndjxzAl6XMmCE+C3zdBFZ8HkwVJhEMKIUvUGIkr84qXI4fg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77079f3-9906-4c76-4fed-08df0d88d300
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 09:09:01.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgr2Mn5XoQIPnMfA3VGHeplTuVDMtmwf/rMj/H1SvSV8nhE5x9kT+u1Cwersk2BP+zKNbzaCL9j16pMAZBJTvS1ZE13nvtHoH3ly+M3NVK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8043
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju Rangoj=
u
> <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>; Jijie
> Shao <shaojijie@huawei.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton <akpm@linux-
> foundation.org>
> Subject: [PATCH 4/9] ixgbe: use linkmode_and() return value in
> ixgbe_get_eee_fw()
>=20
> Use the return value of linkmode_and() to determine whether EEE is active
> instead of scanning the common link mode bitmap separately.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 36e43b5e88d1..a7b7f89f29e4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3751,8 +3751,7 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter,
> struct ethtool_keee *edata)
>  	edata->eee_enabled =3D !linkmode_empty(edata->advertised);
>  	edata->tx_lpi_enabled =3D edata->eee_enabled;
>=20
> -	linkmode_and(common, edata->advertised, edata->lp_advertised);
> -	edata->eee_active =3D !linkmode_empty(common);
> +	edata->eee_active =3D linkmode_and(common, edata->advertised,
> +edata->lp_advertised);
>=20
>  	return 0;
>  }
> --
> 2.53.0

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

