Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE53346A8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848360; cv=fail; b=dRIjS/KsTtuhrKiw1Ct6f3TSLOCwdSwbZE83laoBdgl0LtgxVxs7Jfx+ZuzKD6GTPQtV0+hQrmd42ww+eVNP8NrTzOnmg1IQqzPDWdF3Cfryysu/kC9r42x8MsD9BxL3dwY1cCCY+E2wTy9KT0wN64UfKB1IhplOLcvXGe4k50A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848360; c=relaxed/simple;
	bh=gKv22u3T8drb3Ctzts4yyswBjzObQYDmwJvzFSmSXI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ITt6cfzA3HgN4XuY+LRPRZAURxBMzjd8dx7YF9lj8J0KzirWA4gMIiizvLT0CaL2n7g+eKLJSVxHMEkqcqMaGE4lGep5sol1yiNDEoz/hP0T/MkcG/RWkS5No4tBCjZsZy6xf0mkWjbzrOUImIMDn5v/AIdLqssGmHiG+wKJmE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jg9Ww/0M; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jg9Ww/0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788848358; x=1820384358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKv22u3T8drb3Ctzts4yyswBjzObQYDmwJvzFSmSXI0=;
  b=jg9Ww/0MGUZlF9/zWzVF6Do1GIU6Sz9Ba40zlfKdS6y+8aN12YT7vdHL
   zeHkx+nuuX6mjd7BB/POVY9DYnAOQuEgljEccvYMwYOxhfvQQ+W6jnTyC
   7IpkYGAFzhRRiJ6ACPbjKL4zyfA8Vh/jxed7QOS0bs1Bt4o4RpEMHmBGr
   zqHnYWbjxY4PP7HsTKHHD1gF+YOuuPltDyYoy4lW7u9B9ej1XoLOWjzbM
   Cp60QwtMnsP0hU0YfmADMaQJqXcZQ8NnQtLVuPFFGieddgSU7NcXtElla
   PHUNyyB0PQnsd0bL6njyXNoEBsp2CDxQ40sTUixk5oBXjMRuo3ThW4BL7
   A==;
X-CSE-ConnectionGUID: O9YZVeMDSrSe3lpiRaNTBg==
X-CSE-MsgGUID: feuJyC6dRGqFxxOtcp/2Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100399468"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100399468"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:19:18 -0700
X-CSE-ConnectionGUID: tmbb3y2uQ5SNWv0p7R3haw==
X-CSE-MsgGUID: 5qOdnzYkTwqbp8K+dXSgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="269573672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:19:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHXTOcSjzvnqvru8ifollvJkgxeHQ71KMDdiXj/A6Rj8fcT8Al8WG6/7OG0ZXWhwMfZiFs4zNbbnSRqFvbJsiqPxnVuPu0MyXaZBHzqkxQUY4WLPENkxqVveRfW//d4MWhA6y7vkG351Qgbi8hrdXlRuXKnTAjWqM7rQSs3TlU6LDenGk4WX2L6XG7jhx0qk77UD9VkYP4SPIeLDTZDr0Ns+wQjaq6a8C+GNtbSUCW2AnEuA5I7Juop7wcjnVsSary/0tPUyh9gCDCQS6GAc4+fyMiXqeL4ofoDev8Tsowm+1UqYUN8qMUD+CHxf5r2dmFq4BSdAI0zl9FkErDNaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMnMTScWD/6vECpME4syWzx9y2zG+X0T1b+GO6HodFE=;
 b=MqeFiB3OtCDXN0ulUAA6nbGf3WuM3L89gjRdDKEmnZtP7/c+fOqIVLfejFCaAcWxnGvw8rxSW4zU+C+e5djzQw7KlLK7t4ud/GaJ4P6UpnnnSXMdkIgN8fuVQStU9gHX0/EnAs2+CqY5WmMX/ZK5aalJ01F1f0X27ZhlGR3v2BK+wFhsBgFU9qSEMzIpeeQO4LRGjLQPbU90U9qCMEp6aXITEbDks5dBHcXmPAvetIn7In9Bzzy4bq5i6Amhj6dskT2SMHQuORKjyJoBOLSAOsgd2iOjCaQg3CQO2ppxJdBzGWYKtwzovh09oMG7+WB4pgtRTED9CFxrtw0g67kdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:14 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:13 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers
 unreachable before freeing via rcu
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers
 unreachable before freeing via rcu
Thread-Index: AQHdCVeVRWMJXwAujEOa1QqXFfckr7bEnFtw
Date: Tue, 8 Sep 2026 06:19:13 +0000
Message-ID: <PH0PR11MB752221875E37B71B2D933011A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: e625031e-be87-474c-23ae-08df0d711a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|38070700021|4143699003|5023799004|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: KsR4y2Gl3qU70h+hDL0Xc3ySFFVW0ttJQNowEB5cRBxxsEFi4so4nrbabi/Ljts2XTPzk95cvwWKkZXNY4EgMZZQseCBtgqr7KHnhAri4UWVjbxeiAmlYqzwAEFEBGuBJygmfk8EP9jF+7M/aHPNWu5Q9zvQtob6khRyAOXXcRm7GmLKu5BefYWU01zurse6Fwipb56OFhIUrfItyHuTTGOZfKheT/H8c5rL3vG+MJLFDo5aS3JtIiWqP/thtoY5xjtoKcsYLHtaEUp4yqpdiZJEG1eW37dMqYzaVFdRz9CFM0m/YJAYfL+lF+PX4phzqdpsljgUax24qvi0r9SGyFbgTW/CRQgvvg/h28xr/lz52gbDv81XQR/OJEtotUAotzQ4co1Kk7IOKXmNC3yHGLPNbQNHbsmY/ps0ojxKoRExIuOCdGwJ1ghCG7G1AMmfF39wnzh3tSNMXW/lha5NvL0iGXSaUwBkyhrbQKB96lVRtE6nr3Y5YInv+k347cpVMQp2JPb7XXOQDPiKne3MqNus34g1g7c2QgWUSBK0gBjCV5+2WtboIn2ltvFzvnQBCbxAtOqoMr7Rb3RMAJCMA60bj0eZg3Ws5/9NjAB4MvVJEUkTAU4c8+PS4G5+/9WuGNPP3biQlX6vh+R3n0iHjudbfZxo9YRs5ZMOzyD8wX9XHuWBRWNVuhE8XyJZ/Ndd0GtUJCHjACm/3EgvE2tvanGl6R6Z6qpTnmLjhIMN4rE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ASSQYLGfE0DGJSgrebloXKGhWbY0+0GCdQxnRfWCZ+w0DSKu1k6PtUtbQ9a+?=
 =?us-ascii?Q?XbYtbgra7rm20K2EdM3T7mJRjuGjqC2sdMYstfEPo/banvsAn9LOTFnR8oue?=
 =?us-ascii?Q?wbmENkrV0wAcwE7+9KF74uUwo2YJT/DrZby6kteq9WgOxNtr5jA4clLFjY/J?=
 =?us-ascii?Q?A4iAUuNd3iSewI22jhE7ljEo2HD6ygz7kULSpIRbE2NWb1RlBZDCQNHNBSC3?=
 =?us-ascii?Q?xrFqGG9ZGwtJzFc3C2RU8X3ROAwWguFXzE4yzxrUTjdIUu2ix/JbSQ97t20i?=
 =?us-ascii?Q?XMs9nUQ9wz1WQUusUGT6EyqOic+SMctux9Aod62WAkwubAFp6hd/kKytjHZw?=
 =?us-ascii?Q?XrPEOeeavNZtPac3zD/NIi9ElXv2ZjpFY3CbJpQFoON3I/uhPqs4et0SZhSB?=
 =?us-ascii?Q?+LC1Vkb8MAM+u8butwQM5oIaqjw4cWBLm/MuiYcFh/H7AK3a2xqbJ/J0/UWT?=
 =?us-ascii?Q?HxsEhKcxRmMHeq3klp/YqogdRYC+tQe72m/GQvBxO9fbMkFzqEuLGPSqjTK6?=
 =?us-ascii?Q?uU38oxXFfeEMqudmFRIUceXaOhut5Fx4gdH65QXNhi27mX6+LDwaWlJh5979?=
 =?us-ascii?Q?XIP45wdn1drYm2n3OybiTQXOHNXeh75r1LGE2wjYcK5I3N5K5JdOTR1edT//?=
 =?us-ascii?Q?aeWjzY+njpbLUPNjshEHVroJQPxlcRX712mFo0KOTaic++buLoInsY8rvthY?=
 =?us-ascii?Q?A8gwQWaxT5sVO/RK+DRQ9mJ7fJDfOmwf8RpAQMnHxjzH1RTreqMn67mY+RPD?=
 =?us-ascii?Q?A+kW60M+gn3HRgE9gicpL2EdPFCwxJplQ+m8ZqrihEqYpUYLcns7OQJmjIR1?=
 =?us-ascii?Q?nXcOvIcn2o3dC1eotnWj9Qb23oAem9F9hCDeDCVukLCSqgBASBTJxF1b75Sd?=
 =?us-ascii?Q?i+ETmZ2RNEUKNmwZQ6+w86D0y23YZubIbpLS3W71AUZ60j/Uuur4n7KQ26U7?=
 =?us-ascii?Q?lHgNlpq7wTwTveXY+C+L7XeJLj8Rrfwx4YFLetow+syHFsSO0x/Vhh0mw0DY?=
 =?us-ascii?Q?4QNOQjzbHEgxYmdI22NbOs6NjXjrpra8MiX3Mm4DFlQs/zNQAgN7r3//Ch+H?=
 =?us-ascii?Q?JYJCZ1vY0ol8T05yULiIOEQPGdj/Vk7rJkZjdXgOyJ0OV6uvvjdMR5q1QhTC?=
 =?us-ascii?Q?onE8w2JsBgtdoUV3Kd3nv0MHOgoG1nXkqF4N3bplLBs2425DebvMjPq77SUl?=
 =?us-ascii?Q?vayJLyNngYi64WG9mxcc2YrWpvIp9qtT3q4VpRza0E9oCISS8NSZz67j/w+s?=
 =?us-ascii?Q?U+DGX00lYI3c2qr+exvQ5glmcroAL6IJA8ejN0PprmBGc0WmmCETmTQd9qdY?=
 =?us-ascii?Q?L4fzvKhBf0ns0kEQH8ZPcFddWywGFtt9a2EK1Q6PofeRM/aqs/0BavNOsHhY?=
 =?us-ascii?Q?zbZgxA/c2Ook7AAqiX6YSeTILFfpxDykRU8XTRru85gM/bPsJ97kslm0cLX4?=
 =?us-ascii?Q?VUMB0tOULHlKlMkewnLR3XunDAH+7WN1zd+gbkxALunlrFtCtJTpKvl32Ge7?=
 =?us-ascii?Q?bwjtl6hoHIe/b87kYl8uMeXh3VnD18/MRxAPvwbCB1ObaPL4qL4d4tVzFXzQ?=
 =?us-ascii?Q?YeZ2SxVcat8v87O1/epiv4uVbap8iCp5JhFwS+96GEImDam5lKEl/DHQWW6g?=
 =?us-ascii?Q?QY2mMutJSl3jIwoNTJr62KjHXbUY2GMeWgtORD2ilWx9G8p+JsjurqTcYTEh?=
 =?us-ascii?Q?ap90OYolqkyKgpdy88ondaORmxjRV2LLFkl44Jts4MrlrEXxcOg2nnRj5A+D?=
 =?us-ascii?Q?DOi0K6EKFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EtZSkagKn7Afzeo4Xy8qSt2bWfsRLto76bYoZDPxlM0SEiCDzpQ8MZv7gGe8oV253uCN1Cvzckcm2mvZbjIPYJ7LsO8dZsvnfKXnge8o3Z19raLAWvQfVCru1REEwKTv+XBJXEo2ePro8n7UWGTuOU9nvBnkSes2WTAdJRpK3e3q1XziZP4YQdIeA5reDiSX+AJQ4jNYOyUBC8XsEHaVJ5Xs3gHSIcuUcyvv4Ny6+2dNIbUWs/VVMyEUoqU0p6Xb6trMIdLDLAugIMZAGHxRjfoI54lA0eZhwsghXS3cEN29hg/Nt7ieXp5s/Bp7DYZxumQEs+d695RG53aDbHYoHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e625031e-be87-474c-23ae-08df0d711a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:13.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rzQin6Z52taN+G6LSY2h36Sv3EI8IEcUkJ216VofjGOEfHiceRnr1fUTye8Rpmr6+N/owBduXWo+xIiDD4rPoanooYNvNSRsediiV655lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E > <jacob.e.keller@intel.com=
>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Sashiko AI Review <s=
ashiko-bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 3/7] i40e: make ring pointers un=
reachable before freeing via rcu
>
> Sashiko reports:
> ***
> >  err_config:
> > +	i40e_vsi_free_q_vectors(vsi);
> > +err_qvec:
> >  	i40e_vsi_clear_rings(vsi);
> This is a pre-existing issue, but can the sequence in i40e_vsi_clear_ring=
s()
> lead to an RCU ordering violation?
> In i40e_vsi_clear_rings(), the rings are freed before the array pointers =
are
> nullified:
>	kfree_rcu(vsi->tx_rings[i], rcu);
>	WRITE_ONCE(vsi->tx_rings[i], NULL);
> Under RCU rules, a pointer must be made unreachable to new readers before=
 it
> is handed off to kfree_rcu(). Could a new RCU reader (like
> i40e_get_netdev_stats_struct_tx()) fetch the pointer after kfree_rcu() is
> invoked, and access freed memory if the grace period expires while the
> reader is still active?
> ***
>
> Save the Tx ring pointer before clearing the published ring array slots
> and pass the saved pointer to kfree_rcu(). This preserves the intended
> RCU ordering, where new readers can no longer discover the ring through
> vsi->tx_rings/rx_rings/xdp_rings before the object is queued for
> deferred freeing, while avoiding a NULL kfree_rcu() argument after the
> slot has already been cleared. Since the Tx pointer is the base of the
> per-queue-pair allocation block, re-reading vsi->tx_rings[i] after
> WRITE_ONCE(..., NULL) would otherwise turn the free into a no-op and
> leak the whole ring block.
>
> Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of =
pointers")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
