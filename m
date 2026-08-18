Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88438A726;
	Tue, 18 Aug 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038742; cv=fail; b=l3vBONxb1MKAz2GIJVyzK03dBqeEVmuIPfbt8d7d4R7of2RgKhROThnmwDRwERVq5b6F8UWqzHDWQGxj8QQWvjPvWZL8fzRCOnlgU/Z+DdKqGFXGwrINa/OCYqglUb2UlD4YiEt1XVUGy1BH66iGxhY1QRsADjdr1jh/g+t2W1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038742; c=relaxed/simple;
	bh=PbfkS2BXYLnDCkWvzJ4AoX4GJ4jbdwj/w7NoO53cv9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1Lepb6hPOtG/KQFoc8a5rBYYPqt/KrDV1sphSwQs/dtCXcTP6QjlRB14lc9Y809KI4FL6bm3Oo+O7Ogl1WZYZXOHKIH/zKbI31sWyCaDwL4PM9UsFLKmUXFqOgASH/8BbNVBvni3pYleAov0jGMjqOT6+8lQF2NGp+7C5km5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwW4B8VR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwW4B8VR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787038740; x=1818574740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PbfkS2BXYLnDCkWvzJ4AoX4GJ4jbdwj/w7NoO53cv9A=;
  b=TwW4B8VRE6DKcw9gDwupe56TP8VxyGzbhq4ib5OqZhqkeUE+qP86WAVM
   iomAW3wwNysO4jTcYUn+ze9vm0qF9rYR1GLhlA9VCbfPHiEfcvgMnTAoG
   0A6EbKGFPr/UzGTEARWoo0z/rYEeiNt4hpTFREiHfIqtf/gpE5KHX0R4s
   1Hi1vXa+11zxzJlaD5Hlnm6YrAwJyRyuLsavcYOWN+jlJK3n1TR991QvS
   R6kr3fbqaN3q4ibkNQhAbqoyvq+QVcWtxincSs/HZCohRVgxSD+rJCWcL
   wPuJ/dZAqkoIu3tiJunAtINBsd7f7MncAyDclLo5t3Jg1iT2CPl0eRQSd
   A==;
X-CSE-ConnectionGUID: /Hk0Bah9ScKrY+RIiBaqWw==
X-CSE-MsgGUID: suHuL/UZTEmKmORZIJRIcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98885306"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98885306"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:38:58 -0700
X-CSE-ConnectionGUID: Q5zqFQkRTsCSpo0uWkRUzQ==
X-CSE-MsgGUID: 0frDH3IDSJCoFfr4kurL/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264709867"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:38:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:38:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 00:38:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL6lirT0JTUFBZLmy66x6VIw4gttA9+pvnxY9xKRzy8OqQYNA/Yi71GYdj99WYPO+LaCEm7ByPTgvatGdvO9lGKtY56qJog/mZYkZRdM5UAZWwiva+7O3FBazCfhbw0jctSQ75m5dLsCT/rQ6qcZdPpNxzaf7EcNyX3lpgO/GgqR952h90wf+gGRLbgwIb1EmUU/gk4TPnRowOXPUnhS2/dkSrvbs1DExtjvycub61zc2V4bxIoggFnu7qtztXLfijtScpzHr9IBzmIHt+zP5BGI8dWEwuKISAARgKgsaJ4DPACrYtC7gmgZVFd6Kxp5l5uE7Y3WtkQBpaDmiTut2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjqhqPW2czuM/pje9jfUOUSWSBfFeMMZqA7Jjx+eRc4=;
 b=m3vsZ5lh9fuR/dHUx2PLj9zORR5n3EQzfbuo3gkfonsuvQqaBmJI8EjfzJkPoquXnglN2dsVOSe1Wb2UcxMOdKZyiD5SF+cJqzoC/cmlC0KQCDAzsZDTBC0QjESrmALEqO/LbhWmNIlGz9g+6dHyQRymGkKOgX1qhB75UD2/7VCpDE/NwDO6Hx/9Sk0UeJUbKm+4X5TTIZFw4ScejYawhktJwCrX4z1eWVsNxEs0CudnaKfANt6Uy+OMnf7qQb3+c2J0Bq4fxMIis7Ol5kMa3G4AbkpC+4O3zfON+40Oh0TRzYi6wkLs/TgpubFq+fUwhJ7EqezmFaCn3KbWubnjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SJ5PPF04AA7285F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::806) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:38:48 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 07:38:48 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, "cjacob@marvell.com"
	<cjacob@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"hkelam@marvell.com" <hkelam@marvell.com>, "jbrandeb@kernel.org"
	<jbrandeb@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sgoutham@marvell.com" <sgoutham@marvell.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: RE: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Thread-Topic: [PATCH net] octeontx2-af: poll for TX link credits before link
 mode change
Thread-Index: AQHdLsL0RCujSpf/jkSxKRtteF+gKrajasRg
Date: Tue, 18 Aug 2026 07:38:48 +0000
Message-ID: <PH0PR11MB5902CB2559DB564EA0F2488EF0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260818033652.2038116-1-rkannoth@marvell.com>
In-Reply-To: <20260818033652.2038116-1-rkannoth@marvell.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SJ5PPF04AA7285F:EE_
x-ms-office365-filtering-correlation-id: 09dd16c9-296b-412a-2fdb-08defcfbbde2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: QDijJJAwi5cpIY/WJYSDiwnqmMU4cQoD6iDUnMdZjrHB/FlrCRWa/h7y63+ZvLz/rDOmR1Uqz/CiIb+5xvAvhgEpRWyhQp0sWPKww0xr6QsEC6Ty4XWUBygqhcYp/RSyRkQaLeQixQ65Esi9P2BcWnP7Fy1Cd2/dzVcq++JKHn83KzP72XprJjfHNAVKXvl1b9zrqoEOwZqabEwDVyv4vVoP4hsaP3Pzf/EnC3y3zfZ+chEo3bI6Sju8faE7CDh1StFoiYvxYJaiDzHg9Q2Qop34CiC+CKefndmTJ8w1TSc6eUl2+j/MS2dh75oUfmEkbyYyAwQ3ZKXj5f4MFUrXoCKkpiNl/M3BOAqbI93V2Va3L6txwcds1Vzfz7sQsfqo9MS2dAduGNQziPxdHYwFeUZBuAnvSGFLwDgkO4/B9z5gJm2lnRmKgePDuL/nsiSu8Hfvkqa4JPZnr5f6utdsDDz6D2BATy7NHpXHtS4WN5xfO8dSsQqRuacxIqdWd9CgBiF5VssHsL2hCHgn/1rsdnaclMcg45esNESsEZJPn+cE7htPAVcpeoOyKLSeS9EjRgiVaYt8hmILZ+WBYKmhHibym9EVFCKJP43Xn/KJPbrs4i/Ngh5VC9XQ++aodPeSPYUYzvIPhsqCOfplGxbSJ9/o+dk3vUUz50qA9RYkhC8t7hfFlwBZ3f+gpXc5prMKpa8/9AfIDJpmmHBmoS7OzeMe0K3BfWQl1p0p7W7Pw8o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N2M0yWCc7YoECUd7gKOLz9Qf+GeuTRTvWiLfaYj+o5K8mvoCUEI1sz2qCW6H?=
 =?us-ascii?Q?p/SNTHwYj6I8swAxbEMVO3tRVYKeSarnpv+Pcari+pNKJC0zoRu9TEGeBMDq?=
 =?us-ascii?Q?ITVe8jn8xshdS0k2tULbJxOKUGCDQINmaaEVfxDHhf0KHya1d9VxNURa4dM8?=
 =?us-ascii?Q?biwj8nUjs06WBTT5RQxPRSTBUCDBOdP/umz4v2QJDFoFvTgiw5eSw1uq9gRc?=
 =?us-ascii?Q?FBl9zxpnT+1MhmKy5utuwhtIyOXE1bH64F/79K8CqHZ4EepBbKyWM7LmXao4?=
 =?us-ascii?Q?jkFESX/OsUYihYQCcz6xeOA+VOiiAaRVJQinf+6+56pK6I5MId4SrOFmqsOi?=
 =?us-ascii?Q?KniUo5jn5bYN1M5GaUK3SMtiPdjhvD9gpT5Srv2ORBTDzAHmhXzCc1Us6Cr+?=
 =?us-ascii?Q?zA0HQVm+DRHPZwQbTc6vfY6flEU87uqouYlmQtbxDIyt5YT2qZqCgTKEzwDE?=
 =?us-ascii?Q?KavZ3Z/AGCv5gVhvnPeRONvRvCqHbdpGABu6YrpPamiAF8wikDWQVcTz8wdq?=
 =?us-ascii?Q?b6oZ6SXvx98wWqhDACINBu920dSKhhVqTBhBHQIy7HkBU6CyP1EspP3Ad6qN?=
 =?us-ascii?Q?6lIyFnziEQsxG8AfGwu8tIWQL7VGc7sqMsjgj2/Wemso3GoFxsUuOo9UbDAk?=
 =?us-ascii?Q?MJJXuTt3q6BLMnzwYlRhKeXz8RDNvE3VbPxTMI5ZQlJ8drqbIOyF88hZFIrn?=
 =?us-ascii?Q?PDEqtFnSlpTGjkPpYQocmvGQG3Iitba/IpXFE2yDWzH8qH+T6g7pA3mOyvHR?=
 =?us-ascii?Q?k2OBxGYBt5ImHieEzOdCbs1O+Qrow2UpXhqec66onzOMCu76y5GRrChK+1BA?=
 =?us-ascii?Q?uTeiyks5sfB5WJ2Msky8D+n/qzSzIq/s4p4DGX/jhmbtrO0NXAtXXBbt00XW?=
 =?us-ascii?Q?V8vIc/KtwUp/Zkn3lfVhhqJmh7VOwuBm/zzpgUO7C8lkgtz+AyqSV7jlk3w9?=
 =?us-ascii?Q?VH6PGCcCFH11SRJF9ztQqzAZC37Qe4XUYpjFKMVcDTx7syFybmenPkf+6Znv?=
 =?us-ascii?Q?8AcBoyZoPqUgQh4PKf4K+WDHSEYZ8TyGxDHpexho35YjRIbx+AmcQrq4JF4z?=
 =?us-ascii?Q?2LuQaWcSo/UtTY5NdSlos1uEpPuqoyD5+931Sir01HIxcYzlbF/bGEeQ2kHm?=
 =?us-ascii?Q?75Ov/legMygsJtevSm1fcK+4bEIweNt//dbgaOQc0IMnIO+RpRqLWJnzxnUG?=
 =?us-ascii?Q?0R9LjCelOAww2wSBn/5eVRJhYp8YF2kbedf7rvWQ9ZXRVCNTnLD6iUzgDmvR?=
 =?us-ascii?Q?iUHRB26BgDLdFB2Uvq18CK/wmV0JJu/aR859YnStYMk63lMRnAUsM30Xau/X?=
 =?us-ascii?Q?hoC4CiRkLFtbQjDiW2olNFumuKwkjWL69eBkubc5fmDFL3kXuBhfLT9vQqz9?=
 =?us-ascii?Q?mvabowOF1fQDFZkfcIvnQhLdZ8WtpIO5rwlm4bbDxgQiXRchwWjcI6w11yyr?=
 =?us-ascii?Q?7/WCYz+J5RArPtqBZrKNyQ2EM/T1D8ToR6717g8sl+dXjM7jqhAM9pOnk/+f?=
 =?us-ascii?Q?TfYnXtguZAcNIfAKB4s1rsF6o4xZcMvu3H3H1cMfmNj6rbd1NEv0SqG6Md3t?=
 =?us-ascii?Q?7CQUNMj3pKTiaKcqyWOeSKSq+It642Ebb9WfaPTwkb0Ed6iHEuz8JqaUC2I5?=
 =?us-ascii?Q?P+N4PxBKJ6roatrBlC2CG+14XFWiIgLVacVsGCTyCljFwPKwd6Z46VJXrclI?=
 =?us-ascii?Q?q8J3q4+GcRyO70GIkhFQ2CIeBSg/jBT0H4TpIOwIyuAhWS+tRjAFWKPnyXqF?=
 =?us-ascii?Q?XJLx0x9TSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WfN5kFNbfjZqvZ+bagZs5bkhNAQG7pQR+mbbuNDv7RZweN5qqR2KauPOXuFP7eWVKHILGg0cLrpyc4fATX7E3fJsgbe5+eOZoUg7AL9622oIo0+AaGmrQvH1nFHEqKUKKhUaByLtvLR3AMYGMtjz3lrk65qlMeaf9Vn6RR0CB+j8WouH26LyCr/nm5lBE3MPXiJlO5XwK4RzOdUPKX/Ji8GmVuntZg4YHGi6EnBJwCiHyorb6zEdipQwWl/JkB7NBcGrBUKUtxVkC6vRd4R9Ly23Z66OxrGlKnkYsqm71/fW1Cm68dhbs8Ggrq0OHDOxIzqXNTshVvmd50QVYptvwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dd16c9-296b-412a-2fdb-08defcfbbde2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 07:38:48.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjqamM0tBwNKLj0oyzAsGjJJ4TrpKTpoBAEUQE3fyrVc+PqZ0kPWJxYYmqB955pA9tiCBEEKaUIvYXQKi7oR1ltGlIhKkG8eNhCYAfxavCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04AA7285F
X-OriginatorOrg: intel.com

From: Ratheesh Kannoth <rkannoth@marvell.com>=20
Sent: Tuesday, August 18, 2026 5:37 AM

Hi Naveen, Ratheesh

>From: Naveen Mamindlapalli <naveenm@marvell.com>
>
>When a CGX/RPM link mode change is performed while traffic is flowing,
>the link is temporarily disabled. NIX TX link credits can drop below
>zero during this window and are not restored when the link comes back,
>leading to a TX hang.
>
>Set TL1 SW_XOFF before initiating a link mode change and poll until TX
>link credits return to their original value. Clear TL1 SW_XOFF when the
>link comes back up.
>
>Fixes: 56b6d5398613 ("octeontx2-af: Physical link configuration support")
>Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
>Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>---
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
> .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 19 +++++++-
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 48 +++++++++++++++++++
> 3 files changed, 68 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net=
/ethernet/marvell/octeontx2/af/rvu.h
>index 9d5b7b51bdfa..66e46528e3bd 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
>@@ -1048,6 +1048,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16=
 pcifunc,
> 				u32 mcast_grp_idx);
> int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
> 				    u32 mcast_grp_idx, u16 mcam_index);
>+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc);
>+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc);
> void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
> int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
> 			    int blkaddr, int nixlf);
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers=
/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>index 87d21889dc49..85143684bb6f 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>@@ -234,7 +234,7 @@ static void cgx_notify_pfs(struct cgx_link_event *even=
t, struct rvu *rvu)
> 	struct cgx_link_user_info *linfo;
> 	struct cgx_link_info_msg *msg;
> 	unsigned long pfmap;
>-	int pfid;
>+	int pfid, err;
>=20
> 	linfo =3D &event->link_uinfo;
> 	pfmap =3D cgxlmac_to_pfmap(rvu, event->cgx_id, event->lmac_id);
>@@ -249,6 +249,15 @@ static void cgx_notify_pfs(struct cgx_link_event *eve=
nt, struct rvu *rvu)
> 				      rvu->cgx_cnt_max * rvu->hw->lmac_per_cgx);
> 		clear_bit(pfid, &pfmap);
>=20
>+		/* clear TL1 sw_xoff */
>+		if (linfo->link_up) {
>+			err =3D rvu_nix_tl1_xoff_clear(rvu, pfid << 10);
>+			if (err)
>+				dev_warn(rvu->dev,
>+					 "tl1 sw_xoff clear unsuccessful, cgx=3D%d lmac=3D%d\n",
>+					 event->cgx_id, event->lmac_id);
>+		}
>+
> 		/* check if notification is enabled */
> 		if (!test_bit(pfid, &rvu->pf_notify_bmap)) {
> 			dev_info(rvu->dev, "cgx %d: lmac %d Link status %s\n",
>@@ -1221,6 +1230,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *r=
vu,
> 	struct cgx_lmac_fwdata_s *linkmodes;
> 	u8 cgx_idx, lmac;
> 	void *cgxd;
>+	int err;
>=20
> 	if (!rvu->fwdata)
> 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
>@@ -1230,11 +1240,18 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu =
*rvu,
>=20
> 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
> 	cgxd =3D rvu_cgx_pdata(cgx_idx, rvu);
>+

intentional or leftover?

> 	if (rvu->hw->lmac_per_cgx =3D=3D CGX_LMACS_USX)
> 		linkmodes =3D &rvu->fwdata->cgx_fw_data_usx[cgx_idx][lmac];
> 	else
> 		linkmodes =3D &rvu->fwdata->cgx_fw_data[cgx_idx][lmac];
>=20
>+	err =3D rvu_nix_tl1_xoff_wait_for_link_credits(rvu, req->hdr.pcifunc);
>+	if (err)
>+		dev_warn(rvu->dev,
>+			 "tl1 sw_xoff/link_credit_poll unsuccessful, cgx=3D%d lmac=3D%d\n",
>+			 cgx_idx, lmac);
>+
> 	rsp->status =3D cgx_set_link_mode(cgxd, req->args, linkmodes,
> 					cgx_idx, lmac);
> 	return 0;
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers=
/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>index 964bcaae098e..92d8f318783d 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>@@ -6704,3 +6704,51 @@ void rvu_block_bcast_xon(struct rvu *rvu, int blkad=
dr)
> 	cfg =3D rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0));
> 	rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0), cfg);
> }
>+
>+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc)
>+{
>+	int link, blkaddr, count =3D 1000;

count can be declared inside the loop as it's not used outside
same for regval

moreover defs instead of magic is always better choice

>+	u64 tx_credits, regval;
>+	struct nix_hw *nix_hw;
>+
>+	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
>+	if (blkaddr < 0)
>+		return NIX_AF_ERR_AF_LF_INVALID;
>+
>+	nix_hw =3D  get_nix_hw(rvu->hw, blkaddr);
>+	if (!nix_hw)
>+		return NIX_AF_ERR_INVALID_NIXBLK;
>+
>+	/* set TL1 sw_xoff */
>+	link =3D nix_get_tx_link(rvu, pcifunc);
>+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
>+
>+	/* wait for link credits to return */
>+	tx_credits =3D nix_hw->tx_credits[link];
>+	while (1) {

cant we use just for loop if this is simple cnt decrementing?

>+		regval =3D rvu_read64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link));
>+		if (((regval >> 12) & 0xFFFFF) =3D=3D tx_credits)

FIELD_GET(GENMASK(31, 12), regval) ?

>+			break;
>+		count--;
>+		if (!count) {
>+			dev_err(rvu->dev, "TX link(%d) credit poll timeout\n", link);
>+			return -ETIMEDOUT;
>+		}
>+		cpu_relax();
>+		udelay(1);
>+	}
>+	return 0;
>+}
>+
>+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc)
>+{
>+	int blkaddr;
>+
>+	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
>+	if (blkaddr < 0)
>+		return NIX_AF_ERR_AF_LF_INVALID;
>+
>+	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
>+			  nix_get_tx_link(rvu, pcifunc));
>+	return 0;
>+}
>--=20
>2.43.0


