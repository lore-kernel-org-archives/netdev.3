Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286C3546DF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730996; cv=fail; b=FaLyuHqQDwum45P1KfZlRJux/8RyxibIrBkEuA7QfrbRNZeW4iAlxA84lqUhabzL+Op3FhVIoW2rgcffZNkqiJKiEeBPi/5NxplwIqfKZyrSkTghn9fPdenJ3dFaPWOY7PckSQ+OKm345Duh5KecxzSEsRvApvLaVS8GX/F2Tcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730996; c=relaxed/simple;
	bh=bklFkuzOIET+CNVd6mqqtrw0BeD496uAaEkZk+Nezlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h616z9hpJncn+To56vp+w3riG0HrP+O0D2HQtvEHd25UhxFiS7i733GRFL7BvNIXOcH2BQWsoeaTXdp55pPSN9/k3YTYI6AoM9e/AZnPvBMJpJ86jgeUM+NnU8kvbdf4sB4r/qnFy81WPdWjfrbWkv1aINKIQHw+wTjVNNpvqWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVxYl4RB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVxYl4RB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790730992; x=1822266992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bklFkuzOIET+CNVd6mqqtrw0BeD496uAaEkZk+Nezlo=;
  b=NVxYl4RBGO4GHHIXDHxJs9pApw27WULNFO7A56PEKWplvZuwU7zOAuWE
   XwN+eqtzA7i/vzAPCivvtMdaNXC9+vriWIQuMt5lyzz70fC/cVZPsKHfK
   Hq5keZ1o4J9xs6tYiwKWqRJROsV2bkmPaHcF7dR+NbZpDoGaEWhJAoGNp
   sHIWQzU76eopf4qUqKMJ+7FhfX+Ad60R7dfgqV/3YPr3gMuHhRFl+AMbX
   ntUL7etAwM8VgMYPoka+jjaFlgoX21HJan2iO6zNQSHnVGJfRmaN3m6fj
   h3K9SJttqloO6wwFGsRE6W45bySCGLA/pkJyKkzCMxBWfDG+zSifBH8zP
   g==;
X-CSE-ConnectionGUID: hqgeDFl7R1eS+hON+Y0rLA==
X-CSE-MsgGUID: QKNdLlorRTqVPxCR8ArbrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94175748"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="94175748"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:16:29 -0700
X-CSE-ConnectionGUID: MkD+Wh/JQeqRwfQzKUXRYg==
X-CSE-MsgGUID: LoreFt5PSjmnZzpte8WN2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274733226"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:16:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:16:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb3G8dV5iTY+d0a7d2Shou/uqnE3hTY7bO6dc9F8vn4PBzljGNfcZ1odGf0F3OQmVI0Nz5UJoEHUPTqDOXbzH0ll3JJKJ49Y3+FopFD9pnCoFV7n9JrKHEophPQpgnW9AV8ud+QGzm5qa/2xX18p+JXG7uwu57kc/TxwLpliMKwTmhjfKK/m60QaSqiuI/ATdAANTecbxa1CHq/VGsnibplFKiCihWq/rlQq0lmsRsDNRqS3DnrSpRUbLFVdNcZsmTePIju1BTblqRAptC1hDcniw4S1ijO5UftKyvP2vZwEGRkABibjISaUESAr3Cfkxc6/9acjFi5+gBqmS/tfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuvdE/1hXLu2AT4PgcUw9sIxnGbHOYrMHHWPG6Kakoc=;
 b=xucjDUfoYI1Ch4sXyieOfaSZtjB37aaV9z1TwMOGYOxZhJTbXv1O7Rx/0O1LtB43/ogShu/yhySnGbqAzeJZApZOQjlcRNkhKAdHXf4RPWQca6mw1r7li50Io3T7QK12t6qNrub6QFv5feEiH8yMH+ObreiIdeYq8DUQMyV4k5HNWA/PMYJ6+cm82q2eSWRQid8aXt4iNfxLtUZ9LcBlKaE5Own6ddNcfXIYHbpGsYLGao10ozdc4khJ8kl6tYzEotnWJzjrYM3vIHEnq3mNUDkteGP1dGfFVhkYxtYkCxn+dSG6STgjf1q7qxb6zCSa9OozQaC3TDoaOxalXYCCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 01:16:26 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:16:26 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize
 timestamp configuration with PTP teardown
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize
 timestamp configuration with PTP teardown
Thread-Index: AQHdJKcPD1ONr5tqskqBEuAQdZMBRrbmqTZQ
Date: Wed, 30 Sep 2026 01:16:26 +0000
Message-ID: <LV1PR11MB87902F76C5CD8AD36FE90073908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-3-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM4PR11MB5232:EE_
x-ms-office365-filtering-correlation-id: 954af86e-c956-4e1e-f664-08df1e9072df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|260925021311599003|260925022911599003|260925021911599003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: d1MpTeU+nNTlyW4BFFDROCL7vFKp+b2/bdNXSV7++skIc3abCnbRcZ+NqNgFyx5Y46j2JXJ6Bc8hXHJSqBjcT9BTa22gkxNI0A+JVtQCkm5jAEihi5vK5b4fwj3uClosQGUPklms/cWu8+bt58bPHqYQllTLr5HHFvFUUe1nZpWKmnt18utc0R/qZNWao0Hg1LeKQz+9iEz7+2EONkAidul+q2+DXtkiQnUdB2Sl09g1TNEjj3xeq5oD8OESZxitmo9BV1kSmvF0u1vb9aAfi/lQU+BFbJvtj8shf3m5uT6Ctklhnn0RxNsa7llY7InJXWi7qP2KxF1rlVlOa1AtH1LjsHbNaDiZ4PCqktWTl/oXX5gSKqUgj8Qm6HUjcelaJEd1jbHivM4eBmLS/6Bxhuo6ZxgGS6qL+YyV9v8hVi1B9Lhwu4p0QpQlATaMstqeBVM+7SrLdb9qmvWav8+tr3j6oqzqIv6nTadzFBco1oDHMbpwlkJmkqG2IBLen9Xeb7XbBd2poTcF0M6NyvRLHwDMCgeXRdmJsuEj9vac+zM6h26klnI3J9TiOTHgBUwHgZyZDoP+uLofZ4w8jALBcEHCX2Sf8dyd52vGols/2ilPukQvdxNLhhYROO8k7owyLQKf6JLjI7uNrqBhrFwk1827ofmPJ6VBwCqJoznGBwNKnx1aZhjXoQCkkI9vjW3EazBtd0QTEhomUytFhALlUNF0JfHJj8Bx6w55vzSxmdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnAyZYVwIO88IbwfuwK+EYaqySUKssLtmS3lMxSZaPUyYtsp3zLfkESrU3Cf?=
 =?us-ascii?Q?y4xG8n4qZAh9SUvs4dvM47gMbk2Tr1PsQKH3XJLxbMBrndUQvE5LjMT2aUiC?=
 =?us-ascii?Q?XZjkJ6ZYimegone/wwidOhE5MQ1NifKJAzXTMwVQLwPolyKvupDRAWgGsod0?=
 =?us-ascii?Q?s7aAoIlyrO+1SpDxP8C9qY+d1r+ofpd1YNyoqTFJeWUThMgpEm5FJOC3IyhP?=
 =?us-ascii?Q?fMTf59ba9rmWlY1sRTV7vvfGjsZDVHFyFQu4J1XcQP88EO7LwqsE0RHouaJC?=
 =?us-ascii?Q?2IwlxDwyzPb/GI1A/EDOdwXJppM8eqQUJ2wcV8kCUzNJ/FfEMTzRUQsFYd0+?=
 =?us-ascii?Q?qvWxFbkQOgRKRI3UDl+Uo0bHcAgNBwwOE8GcLM5S8llWUQLmtm/hHTkYCOwa?=
 =?us-ascii?Q?ffeiximNgUAIZbi97/1pVUGxhWAuSz+n6kEpIzO3ZlCCU67U90eMLmKaVtSn?=
 =?us-ascii?Q?B5yOxIoaXsmJAL3mOM2aFZtaDTRSTJjyJQCZZNoe3Gjh1Txq1fDNUPNgaX2C?=
 =?us-ascii?Q?RQ/zEbD+Idg5Js3vw3dZPLdwfMWY3qEZ/4ItrBYvtjlH5ADTzbRFQt/dEteJ?=
 =?us-ascii?Q?tdNEi07h2jn7ihZGlATH7op6VJkM8TwMWeB8ytw59VqWQ6Z4s646635GjGkV?=
 =?us-ascii?Q?YHsY6zsdeMTSsSnA5M+uGSnPcHh7+sV8gO2Qujm+Gj27Mbsc9w+x20ePbvVo?=
 =?us-ascii?Q?uXQxVs4dc21zukRxZNrBHnKBkGrAcNfA6U6l8d8/tXAVCebdkwKOME90zwOK?=
 =?us-ascii?Q?FhlFO3g2cH+S3S2N0cDMJsMWwu6yVlYXWn5fVyfPfoZjm5p+ypcRRRPOHUiG?=
 =?us-ascii?Q?V/jNnMEqxE5uChZADTf7h7RHQzBQWegxzRPFoIkWdn3fCUQKKMe6ZcUI0rLv?=
 =?us-ascii?Q?22Fv6EaCTIGmS2OxSdYB6BUa3ZumSgaYFSrE3kthexid+EjfAzG9wDj73cl6?=
 =?us-ascii?Q?3wqVo+u/DjWAB4Tqq6eOI11YrMvK31wFezv59BSq1e6aL77+WpNhFvo4pe/K?=
 =?us-ascii?Q?Bq5kD5OpG2SpFWIZHnT6Wzd4aVgiysdVhqjvSGQjdIHlA2HEOd6lxCRZ9bpg?=
 =?us-ascii?Q?m9BeRFHVsVgBQO46s3St1AMvoa4o/bnzH5OCSj3teDCdgY52KIwvDxaeDcTL?=
 =?us-ascii?Q?1Hok/yQUHj2CIAAY0VgUnmUBWZ1DWf35tHYjqnaiApUKvVKuknXqNbkc3o9i?=
 =?us-ascii?Q?o+7MSvFGxtRPZKMn1BCcTyNI8D2Cq+JrYjgtsAVWJYAWUq9p0FwrUPRc8Aaf?=
 =?us-ascii?Q?rx3YuY/XVWn0NLOJ1/A6C9p9vAuM8CZc9AB9x8bezIlj/yEu98zjufmqSEGQ?=
 =?us-ascii?Q?m1espTI71j20Fyp6HBANM8VbkyHz1nUM8WNVTJpTgdPjie1uHV/gWfKxWIx3?=
 =?us-ascii?Q?mq9ah4lHS+MZ2NVURXA+2bAdJIbYUTu4bmf65aZaoZqTkUNmf7Ut0QL3QPda?=
 =?us-ascii?Q?J9FBsmEfEmg33fef2uW7DNrcdjjmjb1+wWQ8q6BwM96N8s84+19UvA1+lC45?=
 =?us-ascii?Q?kwC0zCXcmLFA1MWLnx0RNgDQpOhMoVaNsX/H6F6U3oqFB7s42U+kQ/LhzAJf?=
 =?us-ascii?Q?FYfuIPDaSQB1Lxq3I/r0anOimks+tarxFb8hq3ctAGuETUQ96to3EwICHSuL?=
 =?us-ascii?Q?kAP1NVpGTeJ4jIrlI+CzuJl1QG9AvUDdw1Xr703iJap/R2Vh74yZxXjlBXxY?=
 =?us-ascii?Q?BapVfOcLQIKKLw84OsJsNKdRzpIwr+s6phWQuSzraIvYq6+S1s4Feye6L9Zk?=
 =?us-ascii?Q?ufDEtF2/cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nrRkPnaKm0cDz1gSBlWEM6xwh/WGdFznpbUYm5R/jEHn9SAb5RKsolp2frL/Lp0OGD1AJDNVpFnidqsT/KEmfK2v09T/35Dku5U812FDqPHEosyeN4snykK0uOuii8kAZr9DSD78vm80M4mhWZxebTl/eVV+ptKJDSYbQaNxHGffZOkHVNwM7PImNgAQzKK8FdgF2esCI942Y1jHbAsng4Bin9nHFpQhH/bOoTaAQUGPiScZ1XWSctMnZu3A/j7nIPUO5bUj3XUqGr5A2pk4iaM00N3CNo4kT9YC+m5PamfZOYWNsxNzrPfLTs66CGsTl3CV8LWor/D7BSdzFYim4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954af86e-c956-4e1e-f664-08df1e9072df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:16:26.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfDNq0c7bRKvig24Ar+G6J9YkY6wKgU5apERPJq9dxO7aoZJchNBD8YNC8lKusd+uN4USn+1rIcaeclhZyfpGarkDyiSLmBjQO5J0AdIvDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, August 4, 2026 11:51 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/5] i40e: serialize timesta=
mp configuration with PTP teardown
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> i40e_remove() can call i40e_ptp_stop() without the networking locks held.
> A concurrent hardware timestamp request can observe I40E_FLAG_PTP_ENA bef=
ore teardown clears it, then program PRTTSYN_CTL0 after teardown has disabl=
ed the event source. This can leave time sync interrupts enabled during dev=
ice removal.
>=20
> Add ptp_config_lock to serialize the enable check and register programmin=
g in i40e_ptp_hwtstamp_set() with the PTP state transition in i40e_ptp_stop=
(). Requests which observe PTP enabled finish programming before the state =
transition; later requests return -EOPNOTSUPP and cannot re-enable the inte=
rrupt.
>=20
> Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization =
clock")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +  drivers/net/ethernet=
/intel/i40e/i40e_ptp.c  | 17 +++++++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
