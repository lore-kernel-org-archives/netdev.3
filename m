Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792581156;
	b=Ly1rXgdq1CBB7idOMMynAFpKgT0DNSN/awfz49zlPpgspsRN+7zAr9hIDcl4iyTmToPU
	 PV1OCxO8PN1am7jfJlwxMMASJgZZ3BKZru5XtS1DytcsWymYCQMc7yVFtT7vr1VoPph3x
	 7iUPdZiqbX8mx7Bul6lHbUoqtoDirylOzTxCG+mcYqYSXGLqpjfLDkvni4Gijr7SWOym0
	 nCho06OjV/dAP72zkFFfxDTi7yzYSL6igEtiZ/iNsjOloo9WNOkdJzn/cKQVWP9dyxz1F
	 GIKmP/cAeC7oJGXH6PJ4bQD2xLJCFVuXYI+NM9kBu7FkHPdOm4TTrcsHmz8CdJpzIsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
	b=KJq8urNmwxLPEUZL8KlX/JozZqCEsLDRKjzl2AEugbuuvXSLNJxCoCC8URg5+Nh66G9z
	 sHN5t00R/Gw5wPWRn8uxEne+nz94awVIP8tBWgTz9xEX+ZTzsxu1spAuSKNAb1HgoVxQd
	 WW1giZFN0GXWpZSG9lTfSJq0TfL8p//QIBk5m9nzAmxoqmUQcqIKrc0pHOEhCP+RdvYv4
	 D632DjKfxv8I2rpgeQs0qd7pYDrIDVsHEHQ5XkypDD14Rby1ycXJV4Nf8Kea+/+THanPj
	 RFOFlKy7fYTllWrZ4LlfUdBAHCEsMhhXm53eYS559u+TZxUj1nAGYL+vg/XgFCcUJaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LbxGJT+o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F5606A321;
	Wed, 21 Oct 2026 11:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LbxGJT+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792581156; x=1824117156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uEO4AgZQftIUIlWb+cC3CNRaJOiWA2YUbcx654+zjaw=;
  b=LbxGJT+ofJljzI9WgHjDAUnIcApUpt+iiiw4CrbEh07Dsb8rtjU5Uvxr
   vtmtYYcLCgOXHVdSOpa9MamlYRlk4uAnIrHPrZrf3wZuE+9Fphq0l5MtC
   lnVrQaASSLItEIrIjAfzq6zf6mDtw2PVjw21KPtBp6WYCrIQ22Lh1GP6i
   N+e3leetgi1Il7FRmTMURTnHgCedqt9Vs3VkMQZMeOlluisq7D2UgHycL
   IAzRg7JCrGp2BvwdKHlEms3KVatYZQKFV8eLWi+WRw7chyQl8rztcoXiL
   PfO7pFyzvDopuLO20bgnwv2Ykir2a4+NHHK+E/9ePGjkGPvrPxm+UikhW
   w==;
X-CSE-ConnectionGUID: p+IFEenMTmGz239LJzsPRg==
X-CSE-MsgGUID: Sz4PjwDORDWRSKxG9aD81A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1338836"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1338836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:12:36 -0700
X-CSE-ConnectionGUID: SIQ8f+CXQfChiUM7YzMDKg==
X-CSE-MsgGUID: ulFQj5niRQmgyxX/9ALOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3528356"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:12:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:12:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:12:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHWSUBOOhWxoToyvj7DLfDQru9pGVG61C7KwJ/We66Kn2DvJ27pSXj7xnYVzR825NWr9UTXPXeFLMXFCHn2WA9C63Da9rXLKbLU86nlqRPBe4rt6VT288Dv7AEUZbjyNIsM5vGYVRGwu5e+yXHOEZOHOqsCazPctZZqzS25OhqMh/ebDL9n7y8Y+rbQPZdIUE6zRbw4uQAb0aMT3OEG2nZgalNh3CpaNrQU9JR7YVhBmlh4r9wy2oVQp22LtzBmTnGy30Y0qs3U+xV/5vT9FVfZAlk2lRzOmv4/lVmKHIvq2pMuFwuZx4s7OHt0IN1FNNyD5OfREexosuX0+1NKWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzOwwO6Vb4ZMEqRl5LojXX2sOV974LGw65Vis0Yhr2s=;
 b=xf6M7Cvv/3EryA8tqpa2i6KdkYYwV5JOp6+XcpUE5RVycAA2lRMWwlvNHbrs1RR1V+E5sV28gREIPCMsksEwH/T1KYYyhV7TjsCCIWHd07msvC/kOUfLr5JGH//oQIxRYkrKrR8B8nvfpswYv5rsxh1iCZmLFnti3oGbp8DYlELXBcPOsVahYTR8VzpKJ6KaljRiAnBuiTxWwVisuuTf8cOsRXEj9rMcIktl03HCzgG0Hizkz9los1pOHLOBIlBQZ1NoI4VpS3xRAaNsafyxIeG1d0pmfaAzhUlqfohjEYbxp3FVlc7IfyQSLeALdBiRxWwJ5DX1dr7919aMrRF4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS0PR11MB8737.namprd11.prod.outlook.com
 (2603:10b6:8:1a1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:12:31 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:12:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 3/5] ice: scope global configuration lock to the adapter
Thread-Topic: [PATCH 3/5] ice: scope global configuration lock to the adapter
Thread-Index: AQHdX7gXv61ZbOtoHUWGG6e/kGp9u7cH2kEA
Date: Wed, 21 Oct 2026 11:12:31 +0000
Message-ID: <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-4-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS0PR11MB8737:EE_
x-ms-office365-filtering-correlation-id: b6f304c8-d4b4-4d22-43c9-08df2f643382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|56012099006|921020|4143699003|11063799006|261009223027099003|10067099003|18002099003|18092099006|21046099003|6133799003|3023799007|22082099003;
x-microsoft-antispam-message-info: b3/D1hKAn9x40G5eQ432C3Ld35s0WNCXhiPU+r1e114VFhbGwIHPV2dolgReLlEMotvRuYjT9gkyJs6KSezvwRclm4o1BFYNnifRmTOSJQPVvSIIWPtmJtj3O3TZqIURtPTYpFRSl9Oeh/cvahqmfboQgPbaLFpn0SInVhNnhlYd+IraGMy6K7S93FMj6gsIT0h9HkSSGlVJtEN36XdaTuIclHhcgWEMFjeKJJlZExOerRZSox7jASeubOkgXXYRjAoPqZplOfZ0NSvOYnHmkEnYd6QPMHvHV/P0it1mYCKua0pVpsO2oBx95KIgID+svzmKIBHmrV+GoiO0mYzhuFNYxf7grM8zXm/8oL4YIWy3r2Jviubl3etc836IUTLTj7RICmtxXNqwRDu+frSRh8HCVv5OdOFMNA7gBGCGYlfdVF7LvD7UtVw4CWRZ34DiUYyyG51Jdps6dbXUugQeVJEnyC4GSmMxUGH/eQdcHcCWAvmwvgjwzJ7vnzoJZ7jKbD5TIktXZpHybkTd3s8HBYnpi8DS4qd5fygdVgBTD8ZF48o3D6MbBvpm1gpm07PJGKFM5ez6fPi6ZoFx1F6bGZMtqpLbaP2+nr0stD4zIkylsr1pnAMuLTYa26lND5PGR5EC53YID598FDoILA9t0N648dv1CC1XBpWj3fktcJ5JcJop5mxR7JPxumb2bBSkSQOQh4LVLEpKUFaDBWnbL/LSZnHm3mjs8jMmmQJtK/5C2zAIsyEFscIZBRBPxcch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(921020)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(18092099006)(21046099003)(6133799003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BAXSL6ownZSWy9TjxnWD5+zfb1HOBsWVDlTfdEbVqZhz+jKd4xPu3nFNoODW?=
 =?us-ascii?Q?T2ZDKLNiV7ZwKNnX7cwAKi5D8gitbLBTKHKEBIys0qjoAotJqQF3XpUaSqom?=
 =?us-ascii?Q?tUnKIgf1NQU22dTQaXhjfQhaib2WW5NsKm2UPP0FhUzlaxBWlgzlFfq5SjPX?=
 =?us-ascii?Q?rVdoc9ayY3o01o1tiJSE6twhg9xR2MWvLNHMf0BbUWWODPuwQVcty5nKZLrh?=
 =?us-ascii?Q?rXpQXwrygQKVltIqJY1GqjD0+hA1IAJIxJhNRVKxZdxXBfDzr4XPZEvSZEpz?=
 =?us-ascii?Q?CCuMgtS27kgcGRMe/X/7mDpy78oAR7uL3KTEG39YGu5tLUio8mHPuHAlDuH/?=
 =?us-ascii?Q?dY5G7gzc1+/QYfhrEvyGH9DlpbUztNRWdbZOP52uIDZLX/K9CrzU9lfsopw2?=
 =?us-ascii?Q?G+r/OTTLWdlD1hZRrg8uL++tcY9k6in0+D+Chs1WUspJFynl9OF+40S0FlWY?=
 =?us-ascii?Q?FsVvrZeOHesEEZVTUMjvYJH/u7101Jw+VLB7AX8Q15h2MHJqE8ccADq8HjKK?=
 =?us-ascii?Q?h1un4e/nZia/YfTFhh1XBlwA3s3Rsc6d9ty9OJG2sya8RzbYd7FIC77Qx6Ml?=
 =?us-ascii?Q?LoqXDtgCxmCKWBtp3jvy2FUQAYA/18yHyRK/aC9SEPBHCNQDr+DwnLMzbT20?=
 =?us-ascii?Q?l8PoFWbn9zmdSH6kN2jJwO5f0IOLr9QIds/sITP2nCbXR94MUWNL5uvlnl0X?=
 =?us-ascii?Q?SEBJyhzDveSXgofr6Tv6RGxrsvPJMHZ6mbFKS4VUG+th3Q/xAacXWL0K+FPH?=
 =?us-ascii?Q?nH6O8iba5M1DStBYnRiWlCsFElIIA3W/J0Qoj0p9JdmU4I0tEHJbdUkh7oue?=
 =?us-ascii?Q?om0NUn7ImVfCTp/H13x+/UGthL/P9+qMInYn3wFjts9AmIzSd/04m2wqelmo?=
 =?us-ascii?Q?39j0By5sGpEtfMWSjVK7ycnbtATzxF3LwiqBy8bwGlHV6TYASpCYn4jga1vL?=
 =?us-ascii?Q?038zuRqzUbtcnW8SnWpWbZZ24x1nH54LCiDq/k/LV2UI52Uah6gZKzSePC4G?=
 =?us-ascii?Q?qFiKSOkjyYUZOY8mPUhT63cwZIW0sDbu4s1p80/+20hu8dyRBm1WTW9c9rkV?=
 =?us-ascii?Q?VSz8NL2rL7PXCkzYPpEy/BKwCxTrS+xpqRDc7KxXY3xdvgF8VFXMJ6zFAuYY?=
 =?us-ascii?Q?mArK/DzDpZUdd1mnDwjUpPBw8tkVc7QvTiZ6dCTHL8KDyPPdExsocaafd/Bf?=
 =?us-ascii?Q?zz9yj1Fc65S6ksHSPd9FAdr+4Th1qzCr0e3Ne1S5ePsG6sArQajS5LRP91JB?=
 =?us-ascii?Q?SaTE8DeFCXkwJCNFhJbPYyo4MGnA9Hhw0ns2ghIC/ujJ7uNA3/R1Y2ILy5iD?=
 =?us-ascii?Q?YeSUHttZlvT1O/lHseTwl1RhWMjc2oFTTVN26srm2Wlg/31NsQtebf8env1o?=
 =?us-ascii?Q?TNQbH5hcG2OS2F1sI1vTeKVP6nWrJUIzRDOhrgS/9DaH8zZkpbXQepX+V6E4?=
 =?us-ascii?Q?dDp4v80bH2Ww3Li4n3HZaQYiNFcx8HF7AvUxpJeOtDSFd0T7ssa0lP4+RUVS?=
 =?us-ascii?Q?z/tho70zbtWw6VS8kxB8F0NfuYpL/LclVzKMfkO+Sg3KscN/ApjSW0yqHBpT?=
 =?us-ascii?Q?c4Varp+92iuenx/gdSvWg7dz1DdiMgt5/USCQCa4s54mfh/MkdWPbRFZEWGD?=
 =?us-ascii?Q?UrZScd+az6nokIfL//mFq82RH3FUTmp+Y8Zalb74C06KxuDy/pnQuG8B5EsF?=
 =?us-ascii?Q?sFqarabeGIMF+KfXJe58CjmnA3vTnEPhFY1zTsNIhij64vsmcuMSSMvUePcy?=
 =?us-ascii?Q?MRpB8MZ536bslCMmBtRsnR4+RzHvwJw=3D?=
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
X-Exchange-RoutingPolicyChecked: 4QUlfqWOGcw9fMGM++nvKcCHgZRcMnZkG2LibQd8SN0MPlHQYa0J7lnrfueVBohd1ZU98V4BQLSTjw7BHnrJX2n9SMrgs6VN8NioxWeAUkoofMnozbJAe15fOYEir6epsnScHIl5Nw4GDUkSGs6MYl1m0wprQ8+hWKTKZ7t1E7x8sB1HDPmLIkcu+9SR/EBpnFNaEjdT1q1Olt3bYyhCqs/cgShXYs51OQXP0fUSvN8+VrNycFZf4scQGWLuTIaViFEEs4N9YEzuXnG4skEF4DDpGAq61myfu3VFSoXgiKX8mJyqQNWGdFRKKKPgBvHmNzRK78dXlsaMHzP4QB4PnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f304c8-d4b4-4d22-43c9-08df2f643382
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:12:31.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tICzGZRJ/BHeOCVKExy60MAMXs2mOUevvnY0iNc7I7XovYanX1at2Rxic0DM9TCeWLvbpO/j/zM0Rdh26Rgynq8iERyRjQPvAzqIaXdw2Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8737
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 3/5] ice: scope global configuration lock to the adapter
>=20
> ice_global_cfg_lock_sw is a module-global mutex, so a package download
> on one E810 adapter blocks Admin Queue commands on unrelated adapters in
> the same system. In addition, the mutex is acquired only after firmware
> grants the Global Configuration Lock and dropped before firmware
> releases it, while the opcode exemption list in ice_aq_send_cmd() does
> not check whether the caller is the lock owner. Non-owning PFs on the
> same adapter can therefore submit exempted Admin Queue commands or
> sideband requests while another PF holds firmware ownership.
>=20
> Move the software mutex to struct ice_adapter and record the owning task
> across the entire Global Configuration Lock acquisition and release
> sequence, including the core reset path in ice_cfg_tx_topo(). In
> ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
> while allowing the owning task to issue the permitted configuration
> commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
> ice_aq_send_cmd() as well.
>=20
> This patch depends on the previous patch in this series.
>=20
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
> (DDP) download")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
> drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
> drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
>  drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
>  5 files changed, 55 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 7de9223e971a7..17819c3a172fa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct
> pci_dev *pdev)
>  	for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>  		mutex_init(&adapter->cpi_phy_lock[i]);
>  	mutex_init(&adapter->rebuild_lock);

...

>  /**
>   * ice_should_retry_sq_send_cmd
>   * @opcode: AQ opcode
> @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
> libie_aq_desc *desc, void *buf,
>  		u16 buf_size, struct ice_sq_cd *cd)
>  {
>  	struct libie_aqc_req_res *cmd =3D libie_aq_raw(desc);
> -	bool lock_acquired =3D false;
> -	int status;
> +	struct ice_pf *pf =3D hw->back;
> +	struct ice_adapter *adapter =3D pf->adapter;


pf->adapter can be NULL during ice_init_hw(), is it ok?

> +
> +	if (READ_ONCE(adapter->global_cfg_owner) !=3D current) {
> +		guard(mutex)(&adapter->global_cfg_lock);
> +		return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
> +					     buf_size, cd);
> +	}
>=20
>  	/* When a package download is in process (i.e. when the
> firmware's
>  	 * Global Configuration Lock resource is held), only the Download
>  	 * Package, Get Version, Get Package Info List, Upload Section,
>  	 * Update Package, Set Port Parameters, Get/Set VLAN Mode
> Parameters,

...

>  	/* Since we triggered a CORER, re-initialize hardware */
>  	ice_deinit_hw(hw);
>  	if (ice_init_hw(hw)) {
> --
> 2.53.0

