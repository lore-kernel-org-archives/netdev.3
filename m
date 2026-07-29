Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A244A71D;
	Wed, 29 Jul 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319651; cv=fail; b=MNA5ZwdLTTI0yQgFEFBbJ/bKOX56/UjH/VcHTsRIJW2v40rN3VRrC2MKqKpmIyvZka8ndJJVg4zoPQNElH89PSHQtJfIM50i0RRGEwiRYZkOICl7HTE3yV/tyIQKSKb1IqxkEh8duWMciyvTLgun10QBA+LiVigW5QZqjZo5zuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319651; c=relaxed/simple;
	bh=xG2AvS9BpQqXQqW2+idukU8x9VR7pofQ8AeYhny43ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5RQVuX51qpH/msM6uAKbuZLr2rIqbvKEKjY1S7zSe93RBIChrPCSpsNs7MiujsW/i0dbAJSlPedmHwTvvTwZEHYY0doW7wHO8IE7+nezHG/EyvDR7nlQxFcF2MV7s53yMC6rG5hq7aJGY3rUHmxmGlVu8XP2l92VjmJUvg3jmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfufAX39; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfufAX39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785319649; x=1816855649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xG2AvS9BpQqXQqW2+idukU8x9VR7pofQ8AeYhny43ds=;
  b=DfufAX396fFrXHi1d3YVWNhg4fEy5mCFffsOcYPR1yUp9dEqXhGicFLo
   9xyEHId+gvWzuLAZtD6owY+xfwHkp97g4o4PM+5DLGCCvwsfIzDdD0R7G
   HcLTv6W4Yd0K5+eCrnV7lRCLLj+GR4zAQTMtTH7Cos2a3I0Q/I9h9bfId
   +YWlELl0rHJuyZPDUXexBUCZ0tfXdcYHkT7x6BJChBsTz1S3jT2/p7uoN
   l3+G5EbNcFz/hXIRSbbzabC6wUCvWdBAMHaaJAaqY7SkRQfCeXo70L5RC
   sSzNBuDzDwSdR9Rs7W2wVzr1hyncOTPKHtNGmyY5IE857bbg1/fKe+ddI
   Q==;
X-CSE-ConnectionGUID: IgFUTgrIRqmZZCZFYQeh9w==
X-CSE-MsgGUID: d968x4jUTb+46klAGnp/iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96505902"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="96505902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:07:28 -0700
X-CSE-ConnectionGUID: lQC301l5TCmasIfJ52O3GA==
X-CSE-MsgGUID: j2iz1ljFRiK3T5wH11CDow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256639505"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:07:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:07:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 03:07:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mozxX1gmS45UJFAksmiV3jxACHlhH407La+a+aVOgG217vlDfNGifY4IRiSjSGgjdYQUCAHpbEY1orfBZZ5rN9jN0+YDwX5EoFUt1GA0iFBFLAdfvz2NzATUIXlliY2+H8NOo/b2N5/TW2ZyG1dD70Xihhjz21IpNxmLD04D42Gye6Ug/pzDbhlh8IRP0uE2tRaxJb7KeP74CiZWqlnJIbpLryPlWv0bi2Gh3PXTwjpw8iX7oetK1ksxhOBfapEjQ/IDM6BuNCa69iQZn1zsS3W9X9AEH0XyBadoHCXbktSROeD+J+T2OiDqv/eBSHbae5XzbKO58zh5mduRrZEDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG2AvS9BpQqXQqW2+idukU8x9VR7pofQ8AeYhny43ds=;
 b=g8+bjVSRi2xVyMofAMcsznht4+DhDvjdF/YYW839fwL8zfthkknvgQPTE9vACCjJEcBhQrAJoZHHt5oXU/N4bHhUvnCE049URl1jurN9sUA+ey6mkL78ysfWCVQNJnO10mwXrTs9TJ0EJOOzYwavjngRwlKeadraUjXprMPuyP426tj8gBcoaMd7tb5wtMK+Gu/zX7MeiZiNR7POEtQFEWHTPcbM8Z/k7x24rt0mP/i5QGPNeNaHMNNM6Jj5D7gb3s6++BNPquCg16f5RaGlKZ/+t0XkUU3qJ8E4x49fjUEKZrgC743rCVUgLckKsIGivxB/fgAbdfzRphExIpb9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:07:25 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 10:07:23 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Seongjun Hong <hsj0512@snu.ac.kr>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] e1000: drop dead switch statements in configure_tx/rx
Thread-Topic: [PATCH] e1000: drop dead switch statements in configure_tx/rx
Thread-Index: AQHdHzGbuiqAjudnTEul3J4TBfU8rbaERJ3g
Date: Wed, 29 Jul 2026 10:07:23 +0000
Message-ID: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
In-Reply-To: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB7450:EE_
x-ms-office365-filtering-correlation-id: da71844e-49e4-4b1d-4bde-08deed592f6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|11063799006|38070700021|56012099006|10067099003|921020;
x-microsoft-antispam-message-info: XXcm+vMjZglTiDdYTpis/imH8GnIo9C6Pziz5H2+5bfhV92h9tOhHTRA2y7isO9B232A5N4sGfAAfP+piHVIlswOKsnRhVso8QLnPp10nl8oVjxK+fU0ER7eZQdgcZLNRnEG9sQhnaWNsLOPiwnrU6AmBJBoDKIDiw9feP/4Z785uZhL1BinHDT226+OYihPQsDcRNIc+z8IF/eDgf5udAmaNp4r1dK/XqZw++WReUodeEsvb4mYtpFlzDfoDf3Cc2IqI2zcQVJYJqzqnyiyoE+w/MFbgrovBrsJPCfUnHw4wDDerPZOvXQRrXWlz99P7ZCRJtX+/+dAIkDjU1RXHVyWrteVHfLuDl8an80sLS48YKUf7tCmKrH04Bzmpw7Rv2VjSExK/4hq8FqROiJAJTI2S5/p9L6ka0/TlrJcJIqpF+JT9egRParP6HRtzk5aRH10mFD3nL3XntcntH9y5DXPFC92Z3AGEfYk84qC8VJr7muY2LCAw2qKHWkVPs/CoISV6bn8nk9wwxsTVZFAuT7tdF6yTAjl2lhD13FkYC8Xv57HLmwQ3+vqVTpypxcfx0Fu/sV/QkgA8fuRiVmaOt4+ZyUqJHb4THfi9KwPqQSpgt2VmEZFEGTIj/U0c78oBbdZE3tDmCPyBY5vRWFTm79yghJrwCG5Mv2D7b/MqO0SQ0srytq2z2KXyC4l8EG50vqGm+aLMM+1tPMZbtTdrfcWywS+P67lSWpBARUJMWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(38070700021)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wESGkSF0A3NLG2r5LzraCdTM+PL++ws7+3rXph2VgVBDpmZLfShThewup2ps?=
 =?us-ascii?Q?T2uYlgjHZM6cz/2jB7exWlwlIiUiQ1jcsKuwlo2aQTIo4aNyaH6G80/lqybb?=
 =?us-ascii?Q?RcfhSDaeRew8dka6N0y3fK8HMWH/Byf8kc15OllL/wo7JKbaBkTWNDB499yq?=
 =?us-ascii?Q?TpNy5rnpd9prczEUoe/c0qIiGRJCjI5hiZW23WFIick/9oAcedhRd01DSEPv?=
 =?us-ascii?Q?8ynRPyF6jRC/jEwBJzuNUtGK/RjlMsokuyl9tfbfz+3i/U2auRTL782ErWZA?=
 =?us-ascii?Q?LO0jQ9xQ6PZJT5/s9HL0HfyTInBdAb6PKt5gHE6jaX8HJti4sj/9NWHmpeN6?=
 =?us-ascii?Q?dF9WD0DIwi9uGwxEtOIFJqvGmPcyzkMhhSOnIZCDo/7Q0E2URqRkhtSdpHvY?=
 =?us-ascii?Q?+sCHRHrZGHyYspeVH0p+d7mvudOAd2LTZAa9peofaJlcdR3kaCoDsZ/8OW+i?=
 =?us-ascii?Q?9SzyHmT1vtc3Sy9GKKr07MVbxIu9tQ+cULkR3zkes0kVXBGQh90oxD5TvlAc?=
 =?us-ascii?Q?dHXxITj5WDor9SnfpTJ654Da9+SKQqor2mNS/CyyHsnHKz11N/SRXoRoGyQ7?=
 =?us-ascii?Q?YGMlMp+q4m0Qiilhh49pgv1ZRQ/gSUQb2I0a4VIsLRGfPsLew1qQEnliMODy?=
 =?us-ascii?Q?bLg1/cEv4uj/nbQnewMnQC0HOcrvPr5tmDmPQ2vnDg+u+rY4buy9l52qILjl?=
 =?us-ascii?Q?ms+4+J36XT3bewMK5JmMqQ1yWE4P1FS6zLYv17GMDB7oSHfvYS2MXPP2kMAo?=
 =?us-ascii?Q?RAHMhqJkjzMB4gJUsk3GJdRSNB8wzaPvX7hBRPykXu/see55zq2YDr0iDNwF?=
 =?us-ascii?Q?m2QOSxRaqSc9PdR078e/WjdyJcCUj+S0QzJyl5zr4ztxVNtupdGg2rq5hEti?=
 =?us-ascii?Q?xnALIawA0FeTc1vzUdhI12Tdh3DOihd6wN/6mo4xBQWv79Y4253sg60jdPCs?=
 =?us-ascii?Q?FSSfjBVoTVBylGp3A0A7Ecs2+bThvsDluGBRp5NKi6BpzRqHe0lSrvp2DY4X?=
 =?us-ascii?Q?xue9dd9rxTqAdQ6Q2wrxaRI4f6DDrUoEHBpvJA9GMU56VMRnPmon/NuHsKKr?=
 =?us-ascii?Q?7N6PtIxGju3MecHRmAVFWDnLnyJPFRXlT/1FLaC43dFe6bf8suOEyEG2k0GW?=
 =?us-ascii?Q?BSatth28QWF2qE7/m//FH8O/Fr2srRE6s6Aq+aBj42CjtysW/S7uyvoiTity?=
 =?us-ascii?Q?ppVhrko+OA7tSO5rCHUrLCCDOH0i4lPF/xnYaPQLhsM2Nx7ZLdnteAKhyy8p?=
 =?us-ascii?Q?YYFx5SoDLkDVMhfEJeZiF8n1npxFZwUU2iFVH+Yfh6FtMFc9RT9J6o8tcCFs?=
 =?us-ascii?Q?4G807r0gpOFMZMvhsDOqgzFDd0DY7F14b22sJE6lyJYZTQH1XThohVAQLxnC?=
 =?us-ascii?Q?oRDwdZA5ucUaoMq0tjWWYc+2mDbRFr8WrOOs1fnRC3T5dO4gtq1Oo7k/AvNl?=
 =?us-ascii?Q?ai/Jei9ltcHyreA60JV07bnkcqmlOXtwAKw0kGXovaSB0SRUKrFMiIK3ih0d?=
 =?us-ascii?Q?T8gm3QTUpwOok9hkc5VbVNstpAKSdIedt8+2tnAo3mGA5G+LTy9n1wV7e+uA?=
 =?us-ascii?Q?QAWPASyWvrTerdGMk7WyyI7o26Cjn/+6PYDBUBO83x11+mem6F2Bk3HmxS/i?=
 =?us-ascii?Q?B9B1kAL5iMmQr7dSXeUc7LB6490WnLchHhFHzuHVVxfwxyMxSQttSzYtG1S+?=
 =?us-ascii?Q?hkTa2O9j26cn7LJBH6D3PvDJEL5SMMWz0VmK4N1eTgULIWn+nLiphJAOZUSz?=
 =?us-ascii?Q?yyc+a5FOcg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UFwKtVLZUBZySq0wud9lUaORYKJjTBFUuNBhz/oCLAOZCX/TWheMKw8gow7UAT5jK7RHiXRoYbIzoRlBHEvOnqYQMkdRtQaoB1grA1rnLemdWRxKHbFld8lDdjvrCmZd4rT5yYXKrpfhjDWhPYGp6SCvwqw/7m+L4uaWR+O1yJN6eS52T2RuFNyDLDW1SioXgKhGJlSJm8PLOV93jBkffevjVYoOV34mNx5z3a1dzrjtS7O1Fha2giant32Dgo+fsYcO6w17fKKHUTogdXlSry3PM47qec2yqluXTllAKC8SsBtLcwijBvizv4rJti11xlTtuKSfxgaJZPh1AFL0Eg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da71844e-49e4-4b1d-4bde-08deed592f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 10:07:23.6334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNSd/n3n2QhfgWDfytdhP5GmlmsR8Xe+w/xeA5/Vaxqh7hvutB0AuyJRG5C0jbnSL9gOXx1bCnBchDFjpmEP/c5Xl/JG7gNAsxfFRRVakT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com

From: Seongjun Hong <hsj0512@snu.ac.kr>=20
Sent: Wednesday, July 29, 2026 10:01 AM

>remove unnecessary branch

Hi Seongjun

First of all commit msg definitely needs to be extended. At least
start with capital letter, finish with dot etc

Once sending to netdev please also point target tree in commit title;
net-next for this case.

I see the point, but as the code is quite old and its extensive development
period passed long time ago, i believe value of such cosmetic patches is
rather questionable.
