Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793260920;
	b=zO6F9/+cs6OiwONt6kRSmLMedUuVSppTB2uZxVMhjAs05kbOQ9Ft6S1aF+hmAFVMq2DF
	 kLXWRI9Pl/hZxXYtor1Tp7VLk6swpqzQVI2eET+LdZAbaJ27i8dRXuuHr16FXoqaGYui4
	 MztjQWxsXaohV9ztIWjuahBnMMiRENyioYJHXSVEYwC1B2eKtEuWVRJCRB+SNmjBzweFR
	 j0st9dCTNvIPoUvQ7NKJFmdz8d8it3YiTYK0rKga6gLzjPKsnRNTXywszwjExMD1Q5Zm+
	 fIFIG4WU+qugoChZmH40Bn0fynDZoCv4kbTmgc+rVxOhOmZOMxTLkpPf2U5eY4/7p8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260920;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-Mentions:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=yuV4a2yPj/rv4YHjVT7b7EzUCa6aIpJLH5jokwCzn9g=;
	b=W36gKYEBqKBQ6MQAC4N5yppE6ZKWJdHk3eCFe/ZH2UflqJGAkskbIFyPi9OPJ3REO2gF
	 Zsw6THHwK1YDLCkEILCSTgC7FS6StDLZ7ZpxrpYF1RheePSB8IydtFu0cFiGbCKujYRJe
	 7eYFeG0FJZBj8jG9AovneE7TyHOxjkmz7uQO9/rs9GhibGYUPJ6IiExuEsSFOg7BVq0EV
	 ScJcpeunHiL6C3ZwXU31juh+8su+cwPr3+QGkYF1CX2tguG0gUM974tqH1PDevSpKSKfW
	 tpEo8uiR5RJrAgfIvVmxwEdcDSRtUIHtcsYvCBD4EAm42COl1KGgLYi4H5oqk8H5tIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HwZdXoLR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D04606A31C;
	Thu, 29 Oct 2026 08:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HwZdXoLR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793260919; x=1824796919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NsDY0SZIn72zd30zZOxHUlUYx/2TEbHEJDfGEoBtGlU=;
  b=HwZdXoLREJgrcWPESi0ibMLwSgiYShw//rS4Q46EDUkq7sfDDaXFDnKS
   OpJDW3tP7koZHXTurFPZuYNmtVQUbsxEWoeihq0sZoNbkcrZYJdFoyb8Q
   EXP3FYST+/5UF9zST0TywI7AMMaqOsbN4nLyzu+70IK3wtYOgPPZ53VLy
   z7+K3lUEilWWx77Qd2OwEFJJ3Z0l3vyo3/I4YuJoEKa+olRmLXGmK57F1
   eemPOoS07S7PYZwBNS5MSGzfkW/P1GgtgSFmQ405uc2/7s0CpOiFS2jyz
   eMfH65rYB8mSwuxPuD/RGUrhMkw4rJBYq+4r+QthWkdc6+pxr7ZDjt1M/
   A==;
X-CSE-ConnectionGUID: 160rvjmwT+GUdTlSTVDjdA==
X-CSE-MsgGUID: s4Xco/pySbe5ix7YR89DiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2011878"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2011878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:01:57 -0700
X-CSE-ConnectionGUID: JP736SuFTUqt+4W2rGrLsA==
X-CSE-MsgGUID: lB7UwNz1SGGwUBtjgGH1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5407191"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:01:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 01:01:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 01:01:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 01:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZoakxi/ZpQldu5HwHq0wWa/UJE+eT7RM2SvSaiUhpODTwSWzBYTU0zo1Z8Lpr/MaiOb4G3Gkvwi+DCtRCSWXzQwYt5f4sbNcUgv04iDQXx8UzI6kuQlzC/E5SgkKdHr4fRHyRbt7dtV4xmfuQGz+sVIdjozuASUZDx/zpuEhYtrH0SA2TisSPbY+i/3Wlw/RTaMLLhtbwKdLeFM1BUalInA/nu3qN4H7pyy58kaJ5xgh8IWTiZWeT6/9MnD4iFvE0AZVTOTGtZDbpsul/h7tGL2xU0w4nODNyEism5QBWYxyabdh0q3SCAs6EhtaL1WiAW569uU+dLMn9mFnQE4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuV4a2yPj/rv4YHjVT7b7EzUCa6aIpJLH5jokwCzn9g=;
 b=fGPiNyLku3CYFF7HaiXrKTG3j90TrPGbJC8KrRZt4mPuPro6RllfM5uHYNXwrBAWJwR8GFIkvgAJzEZAP5RYw/OAbhZiWi43hGNkgGYGFpbofUdZZzwbbx+eWFWqcrc2Yvc4RzjstAlESDnuUEpOkOp8YyRHu3rbuhYETwgvJ0D2SlHHtK74HAGAvNxC6E+vIjl4n0GbksAIT6IapKDRLHj+nBtLFHPdWjVMzea9jNe+Ay4YPHtHx6un2e8+UVakShQp3rGWlLJh5oxPHOAjmCqw20Wt8C41YDvInm/zSx6ggfu+IRlGqudKHTm5aqoMM6K81ZJRuNNnCod+mQNGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by LV2PR11MB391849.namprd11.prod.outlook.com
 (2603:10b6:408:410::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 08:01:53 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 08:01:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Binbin Deng <18983559317@163.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] i40e: Lock VF cloud filter list operations
Thread-Topic: [PATCH v1] i40e: Lock VF cloud filter list operations
Thread-Index: AQHdYD7yRpCiZYHOJ0WCs+VUR1KK1LcUNpZw
Date: Thu, 29 Oct 2026 08:01:53 +0000
Message-ID: <CH3PR11MB566895DDC2FD235E47AB496E9DE56E2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261020025856.519623-1-18983559317@163.com>
In-Reply-To: <20261020025856.519623-1-18983559317@163.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: kuba@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|LV2PR11MB391849:EE_
x-ms-office365-filtering-correlation-id: a0615f8f-0b17-44f0-a28a-08df3592e4dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261009220027099003|261009221227099003|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261009221727099003|261009223327099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|261026140227099003|261028144727099003|56012099006|18002099003|22082099003|921020|261026121527099003|11063799006|38070700021;
x-microsoft-antispam-message-info: chTcnK31w9NyEPas0Sd0I5lByypDkkgMuQMfm/MkB5C6iPoVLur5H2mBtS22jkJSqUAlRbG6+TVv4Ev+mN0rlSg/2VaGOd1o/dB4Qhl84YWYVksq4D+VQ0zmajaFmgKqv/gHcw4yOTdH9t1nT5Tb+z5W+Y09AIgSKdjtX9/RJWp30ktoOIRAXEpVaj1S4OuP0BSloN47qaUzzxpB8HMPW5BEQJoJ4wHVnDTX2mTD1cjveDw2xLMx52EiBbU8j6VUlJwUP14qPY3k9u/RgdIdp2aQbRJ/1F+V8ynsRfUoa4gXAFg/UTmjZ6PVEt2vdWAENhkwlcPKsTisvu5cfVYvo2QvFXOezPYFm0cUr1ajtCVTSulz4qd6jl+7i81luOWw30FkmEE6psOsaVOntzMFwSKJqDkmZ225eKgHv2paW9WWUx+yrjROyjijzsYWedlWdoRK9vCdImKtdi/GDlnfCMSwuGXwvY9VnzyeH2609I4XqO1OxGkoJpcabIQn9qJpTgAtfLhDXwAmWGu6iJEyAXs6kLNBMUktXXKf5EavcbmlGnsYvYCdwMVYh3IkGrYKXY7cSvNBPO7mx5kG+OcfhY7V7rOu6tjSA/eemzoacAZVJD1FDEI8+NI04prKXdav5rqIsVo7d94tWq+55C7zyT5axziwTJBdOoWQuXtcmcI+uSO7TKRMbxlkZdRrMj3IDMz48ercpEEFEsTdBP9JiUBUb9x/UNOENjIBWHJG0YxTpKpzTuqHCtLQu6oaNs7W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261009220027099003)(261009221227099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009221727099003)(261009223327099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261026140227099003)(261028144727099003)(56012099006)(18002099003)(22082099003)(921020)(261026121527099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cuanBOJ6HkegXp4NfPz36upgqoJFc96u+f+8R7ck53sVLwkHijtGYHLmcwGL?=
 =?us-ascii?Q?kEdUj+bQtl/0TBgiE6J+kIQhI58MLfz5Efsv0f60tFZ0N+RcMG3sX6opTlat?=
 =?us-ascii?Q?zMc5M1IzK1vfpdyIU9djazXa0rg5IEZsFFYk7wODCl4GsVnRKjMqCymIWGXq?=
 =?us-ascii?Q?RZr3wOxQfNqcib9llW2aj9HaSYBQD4fxkVWE2YW7paF/SpY46qjhGy8UlhcI?=
 =?us-ascii?Q?+IC+J3U5Hz7wJ3jhDRX4Gmo0aQyInyorDnZaKEeDdTL2gWFXay+uTKMzy6vk?=
 =?us-ascii?Q?tE9Pb7Ab18QvGuu3P3+dz+Ni/2Tr9ZfRZ06Xky2bstHPBvSPuxMvLaYZ/DMn?=
 =?us-ascii?Q?YI1My/ATZ3hqI/zt4JVTdyDPdoBeepcor7vHsKph9Z09hcmphLJql9xmAVpQ?=
 =?us-ascii?Q?2LFxI5UAgBXZzd4FHf7YQSyTsPkySndvO2tVKNR1tMy+CNKnc5YmVtitDH7p?=
 =?us-ascii?Q?pdkSpFYWFSv9ix+Cu//07rOTfCkSiWIpx7PsdvTx9TZwMr5dtaT+mm6UWUip?=
 =?us-ascii?Q?vt/Fbdu/ShKOQqqT+fjFb2PtnBJCQDToocwettURFsNzj/43af/PTnj/hZbq?=
 =?us-ascii?Q?N3BRD4rv9fAxMMNgbA50ZvjQ9jcVzgapMPu1jNCX+tXMH0zjXhBurpSs8F1v?=
 =?us-ascii?Q?Rzw9J2b4xWleRLj7ackWpIHFFqlvqzvVwhqNX6A0Ra5Fk9p0PZL6C02WHP15?=
 =?us-ascii?Q?tAjuCxFa2Fw8/UOAu7aTnrX6SQOLLWprLqNTSxA2ntfMgdx0CDDWnv8eGOGa?=
 =?us-ascii?Q?zJ1RMDq4ZYGYfOSGZrgjGD2g0FpZaE6zici37JPx+vpmH0qUD8mZX5M/inIa?=
 =?us-ascii?Q?SEYa69QXvJkDBxXtyEXcUIm2VgALcSzHCAj9M60lhEQkfhfmMnHDkRauabt+?=
 =?us-ascii?Q?sTD15byEsJt5Rrb3zdsto9LO7WIf3QmA5TTs9AcKshfKZensN1aGa2xkKc+x?=
 =?us-ascii?Q?/geHiK7GoQVhDqHOjmWyLqCK4zWGt3UPv9IjGS7vXA6w+ApU+gi6SXBbke7k?=
 =?us-ascii?Q?/mgNUQjXRFHXPsoRrc04T7seiXTXsEVPaFqquUoxmLp1ZohVlISAk9yBytdm?=
 =?us-ascii?Q?u4dsDHEfRje4uNHhpDg/7sNdy2AnbDSi6nPekohdmJWY1L7OU7yi3zSbfVZ2?=
 =?us-ascii?Q?fW0HQfgdSaNplcyTt80WnlCGxGYE1FoYZxoJ8E7B51e+mElFhW3NC3yIasmo?=
 =?us-ascii?Q?J4KX7nA504Ds+jLCcb8rfomn02Z4kOgoABqNV5PqwBqNBgu90E5W1EWzplLN?=
 =?us-ascii?Q?SwjDVKbtKxWU1WIPc6a/u2UeIKzovDGlYq0rMaIYMLXtypVdLgsHOJ3uDHY3?=
 =?us-ascii?Q?A6gjXf7A68fShU/ROLC9ybxc2WwMwszQU3f9GhZ49oPHkQ/XDvnN1hprrGzk?=
 =?us-ascii?Q?4VdBYKn03FAT7F7d6WwS5R3oniY/6eSjj0de8GZ+V6G4KBa6AFaSP9tumLLq?=
 =?us-ascii?Q?jwMAPHSpe5zzGckWJ9mo/iCfK68ZHLsL/wFynx455P767JXFF5H85dypsdMw?=
 =?us-ascii?Q?JupNdM3I7elV4HehTD7ZwcMF2tZwWNrxcIaHoeVBr+ACz7bsKOQsJyFhjFwo?=
 =?us-ascii?Q?bctRDbUlhYiRIamfJc7myQE39TiQMqmCKWSQvGJhWaR7PZYxd3x3rDydZ1bS?=
 =?us-ascii?Q?vvafyZ9IKowMxDWfyJKyNr8JeBSK+AvAWbSnExUl3UD2wKl8dNa6FlgbDOrF?=
 =?us-ascii?Q?x+Kik3/8IfIBPRkqIVOFPqufulFB1JtOJE7C3N6uZ6/FPz76To4R26omFuNY?=
 =?us-ascii?Q?ngQxyl8vkjJknITDBnby+ZyJznAeqc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: goP8K48gxLA3J+lQ86r6VGcsGWY324vlVfImp0fd8quuu3b81X+JTkNGTU/YWRcds+cI/dGnlFX0501gaFWVQiCSoQ5Pv5t/rzVlnTmaUu+OzxqYscsJ0KCbfLHvR36igtj1pmlDCH5ojz45UDfqBxKkHwwCOJHHRQIdexVesF7kq1K4uUfxPO5TrHmJnR3gkg5rjsbDsvh0t9Xn+GIupSkPOrFX1YrMTsKnEheiT4IubL3qyBHxndUce5wUQ3xYpKwnai71uRBoc3KXB9x7Z9wLcJOR++FNPRjzpXCkFG4l8qyFbnqEjRTYvYg/ZxjIEKNCBEqXTokkOIc22k23Vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0615f8f-0b17-44f0-a28a-08df3592e4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 08:01:53.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09CGrsYcGudIC69BS8gZCu+a/sy2aezTnFu2+r16/KlTbvdb605krG+69AUuRZWLkz8hd+yMEI4baFYTBLq1VzSSCCcQip5Lpl3hcvhcHGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB391849
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Binbin Deng <18983559317@163.com>
> Sent: Tuesday, October 20, 2026 4:59 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Binbin Deng <18983559317@163.com>
> Subject: [PATCH v1] i40e: Lock VF cloud filter list operations
>=20
> A VF's cloud-filter hlist is modified by the virtchnl add and delete
> handlers and by i40e_del_all_cloud_filters(), which runs when ADq is
> disabled or when the VF loses trusted status.  These paths do not share
> a lock.  In particular, the PF's async VF-message handler can process
> VIRTCHNL_OP_DEL_CLOUD_FILTER while host-side ndo_set_vf_trust() removes
> every cloud filter for that VF.
>=20
> The race is reachable from a guest by issuing cloud-filter virtchnl
> requests while the host revokes VF trust or disables ADq.  The VF-
> message handler can traverse nodes that the bulk-delete path has already
> freed, or both paths can remove the same node.  The result can be a
> KASAN use-after-free, hlist corruption, incorrect filter accounting, or
> a panic.
> The virtchnl operation-pending bit does not serialize this host-side
> trust path.
>=20
> Serialize cloud-filter control operations with a mutex.  Hold it across
> the firmware add or delete, hlist update, and free, so bulk deletion and
> individual add/delete operations cannot observe a partially removed
> list.
> The lock is file-local and slow-path only.
>=20
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack of
> hardware infrastructureThe issue was not observed at runtime.
> It is identified by code inspection only.
>=20
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Assisted-by: GLM-5.3 coccinelle
> Signed-off-by: Binbin Deng <18983559317@163.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..f73a710f42f1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3740,6 +3740,8 @@ static struct i40e_vsi
> *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
>   *
>   * This function deletes all cloud filters
>   **/
> +static DEFINE_MUTEX(i40e_vf_cloud_filter_lock);
> +
>  static void i40e_del_all_cloud_filters(struct i40e_vf *vf)  {
>  	struct i40e_cloud_filter *cfilter =3D NULL; @@ -3748,6 +3750,7 @@
> static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
>  	struct hlist_node *node;
>  	int ret;
>=20
> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>  	hlist_for_each_entry_safe(cfilter, node,
>  				  &vf->cloud_filter_list, cloud_node) {
>  		vsi =3D i40e_find_vsi_from_seid(vf, cfilter->seid); @@ -
> 3773,6 +3776,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf
> *vf)
>  		kfree(cfilter);
>  		vf->num_cloud_filters--;
>  	}
> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>  }
>=20
>  /**
> @@ -3856,6 +3860,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  	}
>=20
>  	/* get the vsi to which the tc belongs to */
> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>  	vsi =3D pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>  	cfilter.seid =3D vsi->seid;
>  	cfilter.flags =3D vcf->field_flags;
> @@ -3870,6 +3875,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  			"VF %d: Failed to delete cloud filter, err %pe
> aq_err %s\n",
>  			vf->vf_id, ERR_PTR(ret),
>  			libie_aq_str(pf->hw.aq.asq_last_status));
> +		mutex_unlock(&i40e_vf_cloud_filter_lock);
>  		goto err;
>  	}
>=20
> @@ -3901,6 +3907,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  		kfree(cf);
>  		vf->num_cloud_filters--;
>  	}
> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>=20
>  err:
>  	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_CLOUD_FILTER,
> @@ -4002,6 +4009,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  	}
>=20
>  	/* get the VSI to which the TC belongs to */
> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>  	vsi =3D pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>  	cfilter->seid =3D vsi->seid;
>  	cfilter->flags =3D vcf->field_flags;
> @@ -4016,6 +4024,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  			"VF %d: Failed to add cloud filter, err %pe aq_err
> %s\n",
>  			vf->vf_id, ERR_PTR(aq_ret),
>  			libie_aq_str(pf->hw.aq.asq_last_status));
> +		mutex_unlock(&i40e_vf_cloud_filter_lock);
>  		goto err_free;
>  	}
>=20
> @@ -4024,6 +4033,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf
> *vf, u8 *msg)
>  	/* release the pointer passing it to the collection */
>  	cfilter =3D NULL;
>  	vf->num_cloud_filters++;
> +	mutex_unlock(&i40e_vf_cloud_filter_lock);
>  err_free:
>  	kfree(cfilter);
>  err_out:
> --
> 2.43.0

I'm afraid one more global lock shared among all cards on server will make =
things worse.
@Jakub Kicinski can you comment?
