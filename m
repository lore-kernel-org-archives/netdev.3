Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571676;
	b=uqTpydMFi+wark4i99tdEnOY6m4y5ibkEfL8kUdo2Zm3sMYzVltdCl1gU9W3yeNNHJtX
	 NFZSyGR/VB3UHAsLJzd0fUqp/MWi5KtK9Wu7TpLlVhNDgekUALpJAwvmEKGvYfU9r6fiI
	 6hJKkcV56uCZqLLCHxBYCCaLXJ2iK4iWw/+nTaRLvJjfhGDSLqdZsg8nY8HIKeVxZRrxQ
	 vVGx/ce1/eb2Q75f7VQ9Jt57VUzSm4Xur+8f2g8cCoN6RYh2bT2+NnK8y68e5QnByF9Od
	 sLyPZhocu7CnE5L4qTh0H/MdfqCagm2+KwH5dcPZOHefavaB9D6mcu20ttNUVnzkwiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=mlpRWLh5SRC7Qv1Nq/OlB/ryEPEj6p53U5+uKN3A+SY=;
	b=VID+KKjrWazzV+Bbg0OQF0IHm9RwNZeWJAdWmjmhhkOp3j0I9wRXNZg63/Z9buJ482gS
	 ZdRaCWuIAbE/j/mEm4Tj2M3nqXynsL1df5WWn/hCBFv/qJvJvAJ4HF5+vm6MfR9xPOoal
	 crOC5M51D6vDs5DoKxIayu2KCTSi55rlq6F5JOTA+x/dwJ2enJ/iWwcsamDxXZbM3F3IJ
	 rWYf4pg/sZiJBc+ViQrOoLat7nCpqu2SP1QhfuC0XxFK12ZV2Ay2MOIXrsym3O4ZTe3d+
	 FvkkZSOd7MaRY5gTTAA317IEoOLuv2ktpK+BBt8dnG1BLHLIYPDiA7Dl13+jX7XYyEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="CiT/kXui";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="fR6SUMm/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B59606A8C1
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B59606A8C1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CiT/kXui;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fR6SUMm/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571676; x=1826107676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FdgBOz8PMT4r2LtMgPoGVlEYD5GTNC/uhx7q0MiKyMg=;
  b=CiT/kXuilZ8PF7nH0XA7TAY/uxbNMteKhsgvhz1kWEESoxHvGvUMPFE2
   NPoWmcZ71X1J9ONnJkNegjYl/fJcAPfOSk3GADwMba41ie7nzIqrvcxVd
   i+mSV90EcxHOmrf1Gh1WI2mCGjLOTEzRu1YWnIqCFB4hJ/xDPnY+yUpLt
   2bhvs8kYdmW3jkCBosUvuYIp6JC+fzyTmWqw6qUKNhvJlWtvsCwiw1ELy
   4xf8HjO+24CARyh8Nm6J1MyG5d0MiaQkNSRZ8uTkVEPa++0/wmy8AFpvs
   l8uHwaTKfZPG0tsEPtTKGIHR1o1Z2TjE+sXGyUY2aAwmP3m9IjhpqoqV7
   A==;
X-CSE-ConnectionGUID: 1s+9G+qPQuqV/QxoMTtuhw==
X-CSE-MsgGUID: FdPl2x7URP+GWwvvGt0PIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3264619"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3264619"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:07:55 -0800
X-CSE-ConnectionGUID: dnNbPtC3RWGprKkEHtpl3Q==
X-CSE-MsgGUID: rZ7DdNXXTlyLAlbmjdOLow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9326192"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:07:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:07:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:07:54 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:07:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRBBSMt5sIg9gvLZ20aZEW6OBsOXjVzzBWhbesFyrxRqAQSEPsBzqbuMYqdkQv1SuZPidh9d/ssH1WQSHZIoMjQDhCRgXnb5FKP0PpmnyMEDKA39BPRuaAWpZSTC+CMiWGAgNw95aPmRu42y09MGxoCVPAJPi3vCFS1tctbkLNv+2PGV+mirgDyhart4PgV4GrqUHHMw9R5OOGLwTgLsMJpfOmnfvAEb4jM1UvE4+k3lxRjexcKmdhVQFx3OMl1az2adWPeaY89ASsob6kxCGPE1ChcbXgHQoB41QYIVeE20lUuYhKvSzLCe7pjn1aIYIEMCkxm/p4c0TAfPPK1PyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlpRWLh5SRC7Qv1Nq/OlB/ryEPEj6p53U5+uKN3A+SY=;
 b=ukGcsWblSkaeLMSpopE1XRcdq1lRW3OJijLImWulTonh4qxq+7rEYf2LoRG13IHlx8+Y3qyb1Kff8vLMhoBk95gr3OWx79yDbwravZ5xx+KbEcYleHQa9SIEDdihmpUNNI5h7nzTdTC3trlRJ7XK7pWrzvQk9QSpOVTl/rfBrATma4qbneh4PpghKAE5CeKh8NMKxfPAh3DkDF9gujlRIiXYsN60UxAmfoQjWaiSDPTkNH94bUJem0P+bWlhS1c4CTyrvnLOiEwn5pF2/oHtEvGd0t9IafKZ2PKs6+tesAq3wJAwDEh01UciNiN2Xz+D8CgnVhqZqVDiI3JYPqpJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlpRWLh5SRC7Qv1Nq/OlB/ryEPEj6p53U5+uKN3A+SY=;
 b=fR6SUMm/cob5ZSm71KO6ivCLOHtGvskAKiPuKpDTc05HAG6+dPPg44i/2/gui3DFSiWR3o703dbzPVMUVdGOFJVFeWBeEx4eYx10SaPue5w/4/AIcIDBImm11wvltmg3Wz7a3hHnBHf/7ThOgwikl5UtrZ4cWLKwZaAgNgAiHK8=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA2PR11MB5003.namprd11.prod.outlook.com
 (2603:10b6:806:11e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 12:07:35 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:07:35 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "anzaki@gmail.com" <anzaki@gmail.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>, "ohartoov@nvidia.com"
	<ohartoov@nvidia.com>, "Oros, Petr" <poros@redhat.com>
Subject: RE: [PATCH net-next v5 07/15] iavf: extend iavf_configure_queues() to
 support more queues
Thread-Topic: [PATCH net-next v5 07/15] iavf: extend iavf_configure_queues()
 to support more queues
Thread-Index: AQHdcR4NIMevs+RSKU+rGKjgeFdrrrcr7NDg
Date: Fri, 13 Nov 2026 12:07:35 +0000
Message-ID: <CH3PR11MB5668952CB299D868C8C88FC839E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
 <20261110141534.95614-8-przemyslaw.kitszel@intel.com>
In-Reply-To: <20261110141534.95614-8-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: 27e1e75a-fce8-4027-edce-08df417eb404
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|4143699003|261026121527099003|261009223027099003|10067099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: yymxm5Fe52RAj9C/zeF+hpn8jWY4dyV8XyAiVtqm3OVEX/nh5TIT2GQoztklz7v5KNoWEIT9HY5ODAxpeGwr0PVSKuAobiVO5kVExneetfWwFtY85LR6qRzbMzDbfPJEAKlyZYQjFA2HmA+NjFzvbcHGhTR8ofCp7pETaizPf99nSpP65NBt6ABfjjoB5PIdAwe2jaA31NqqimEbbuA6G7BBoj/SbosXNLsdf5wtGekIBN5ul3xEuwAcU5V00IyPl8MSEbu9aeQetgkphUFMpG8jprn98XDswCwk9IzH6+abwWYjyWBkTMceUEJoYGdvOzNP2z2ZH9NiZm558+W/adw5NTCBQpDoYYYpl2Xg5gLiSGTQc8mF7p8fiXYSzyPH3r45OjPJ1LZ/OJ2NlsAU8TIuWDn42F/sgkDk+jZ0CkYa1U0up5ZNs4/9sVm6VxWErKEJ/90s0fObxaDPIxB2AmSrunKU9U1IP568cd5nTb5DZSffqNR3P1oKtzfhHhMuueUbUsBKQB1yVz715B/Vg13fFDZTVNk3WzHJnijKqd/gzDmMVrgC2ow4biHUTjtHGne8rNNWDejxa534oBqA5rwfcsbegOBAXO5R2wyKxXtY8NQa5oYCsA5GaEFbiT50KcF5SadXiPff2bNPSrDL4mWWu8+mWEFWgzSKMfWBGc2i0O7sQMuMG+JrWeRdIUhcKNQKlmV6wq1inbw8h+1xBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(4143699003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7IzuSIjRPcZ1pkM5tf/h7HaMRp7L31saYRIqpSM3oKx9hYHwvBtvxLeB8d73?=
 =?us-ascii?Q?KaYN/DtY6aGjgKCNuG72lDlhSRvR2lHqVo2+aZni3Ix2t5bxyZlxsXppqN9E?=
 =?us-ascii?Q?B88Tg+1o71J/88J2BOhHuXyQfFjhauMHLfgrFy2yd1UU3RjAGnoc4RKiyWM8?=
 =?us-ascii?Q?XvWBFa36SL2kIGCCcWVYBv3BA/SwtbBlQjyN55fgq+cloXn0dMYPwmgUi46L?=
 =?us-ascii?Q?uQ7M172c8s3f1LP0dQ5hSgykmdQXUD3keyLZbiQa1+uOuRQSVPTNQYfb3voB?=
 =?us-ascii?Q?VS9onRdyG7Q8wHVCmpqt/B3Q1onPsevMSgaPdTQXWdKMkplcEnjuf7GBMPtM?=
 =?us-ascii?Q?S9nO7PRavmRf+FSw8oOwW+RDhUaXSROIat8EUP3QsR4glYBLoBo6wueaSSAR?=
 =?us-ascii?Q?s2WHTOsePN8HK6V2aWDnjLcmPgZ0H+CoEiSO0NJL0/eNj/4Bi2FXqJcCj2G7?=
 =?us-ascii?Q?nFIJstXLqS3zmZeYmjCLG5giRP72Hj0/9XHDcmIXN81C0CpIkjau3EEYjAA3?=
 =?us-ascii?Q?+ngjclzIA1l4Ik2XSaUNWcun/mdRkfgghuagmJL2jCr9XalfkoArj+RwUgup?=
 =?us-ascii?Q?q0DzJpXJBSHWqkcYOZkXMKtn8hWRfSLQBZ5hK0j962X3a0loHhmDuj+M+F/P?=
 =?us-ascii?Q?gIj2qoBE0QneCykHSC5Y+IFayiFdcVTWhW8CIIRSMc8P73MIOf+jOBoE8XtP?=
 =?us-ascii?Q?S2iWMuq91VkmjsQgoccq2X63ewdxUVtRyUX/EGAJ7/90xtV2NCFgNU8HVNzG?=
 =?us-ascii?Q?3RZHEKVKnMeaXG3fbdifjuDFI71TztZ6tVNlyBMtMmJa1JV6GvYA3VT6jF7N?=
 =?us-ascii?Q?1ifsw8KPOwjlEtYEXA+nN5xxx72LhDQBaTUhkVswoi5XC8BaBJUN6lnqYEaM?=
 =?us-ascii?Q?fDeTXJNUd7Js8zgUFkPqNzBsNzP2Mi0RoTd43zo805SzSwv2Dgo0Vqsldwct?=
 =?us-ascii?Q?3CRGoJvXTpdlwJ8avPHWcp3B1aj+CTY5t25NYj9lmgyoadgGmAPIzNunyAXK?=
 =?us-ascii?Q?XRVJ2o77h2v3VUT2IfodWiWLKXPESgD4xj38GtyqeXPbIZm7PAWwTsVTVej0?=
 =?us-ascii?Q?n3T9a/8VXm2sS180fyxXrbOWSW1bnZfW/pW14EEjwPfMETR9Xi7SoHqx9gBD?=
 =?us-ascii?Q?0FVm/rpGPbkYBeV6WhqjU8+CcYxIIeeoVIr3r9sByPKFPUd1rD3R1pMf1uX7?=
 =?us-ascii?Q?CFIpUpnoUubum7C/b/eY+HopyzhkhZBfXJk3QB81pe8pqJlGYi5OBwCjWxUf?=
 =?us-ascii?Q?qRedMyLLOv0vf/PMfnRAdSCDm18AlELLQxKGsmfRdkiIASGWv08zC2p1zsov?=
 =?us-ascii?Q?ALjUtd46WXqp8lS7UzvSrAuDuO7g+rS8AkoT8nkDARPuTs3990ryOIcV3gWl?=
 =?us-ascii?Q?xwMVc0V3tQ3s5YjRh5lfV4xLehnD1fXBrWxumtH4TBnrDzWkNAX1cyseADA0?=
 =?us-ascii?Q?3XZHc9pJ+BaRb4WZNJPmbMFVq2UdatNscH1S66NPUdKYOJJvAQFLTtRHk2iz?=
 =?us-ascii?Q?KZ9I+/1cTZ8Tq1FpnAOBYi1aY3EfuCugIm2i96bDsW0AHYbRieRHekH0y2yV?=
 =?us-ascii?Q?F0YbIAbFNcyln3t6tRc3xOnnk6MnQ6ikC5/PZJ4Z7oy4TNS7R3DuHd+nXRJj?=
 =?us-ascii?Q?W8uXVwZOIhrth7TbgXyLU69xI3L1LA4/VerM39Xe2RYU897cvfOMRH1GQ8WM?=
 =?us-ascii?Q?eBYDFiP2YKIjjLOtDLARe4acxb29l3vqip2WZ0NTBOjcGNwGQnYF++ZEclCf?=
 =?us-ascii?Q?nCwNAWsmNA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: b7zu17TzfHEluZiAvlrrGIwibrsHV9fVf17alCHOy2L5AQabTje/KNBScay4VBm8wpnS3YZUELvKCQoR4yFi7ogiQbKINdj8C88W/sIxxNFB6xjTOD42nSK+3nCHCB1jemqDCVXFUeq9GQGI8MAaZflGSR6+QKsppxI33tD86++FQxjNloIR84wzY+o/nCuYoEfSP91xe0n+EUy9OBTdcKtysRkNukrZfmn++8Rx9aIfIYOfMSInsr6ytI56iyw67cA0UKDYNtOW6K1PnJqkOKXhWyO9FZ/zrSl1INo8uaR6sBwV12paA1Pa3e0OqunTZ9c/Shn767da1EC0JRlkBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e1e75a-fce8-4027-edce-08df417eb404
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:07:35.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RE6tZqLnu+pLzwZK496Ot4Nvy0224iPZCTM7VOFD7tDLZjms0klf88YF7aSczLP5LIuZRa0cUGVKdaPuWDcMaYq37U5OGYL215Yxw/hkABs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Tuesday, November 10, 2026 3:07 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
> edumazet@kernel.org; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Jiri Pirko <jiri@resnulli.us>; Jonathan Corbet
> <corbet@lwn.net>; skhan@linuxfoundation.org; rdunlap@infradead.org;
> andrew+netdev@lunn.ch; saeedm@nvidia.com; tariqt@nvidia.com;
> leon@kernel.org; mbloch@nvidia.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; anzaki@gmail.com; brett.creeley@amd.com;
> ohartoov@nvidia.com; Oros, Petr <poros@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net-next v5 07/15] iavf: extend iavf_configure_queues()
> to support more queues
>=20
> Extend iavf_configure_queues() to support more queue pairs than fit into
> a single virtchnl message (62).
> Virtchnl opcode used was already generic, but we have just not needed
> more than one message before.
>=20
> Send one message per call, and keep IAVF_FLAG_AQ_CONFIGURE_QUEUES set
> until all queue pairs are sent, similar to what iavf_add_ether_addrs()
> does for MAC filters. The next message goes out on a later watchdog run,
> once the reply to the previous one has cleared current_op, as for any
> other op. Stop sending on a PF NACK.
>=20
> Add helper, iavf_max_vc_entries(), that determines how many entries we
> could fit into virtchnl message (ending by flex array member). Will be
> also used on another op later in this series.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v4:
>  * send one message per watchdog run, instead of polling for the reply
>    to each one with a 1s timeout, which could resend the whole config
>    after a late ACK or NACK, and could take a stale reply for the
>    awaited one (Sashiko)
>  * stop sending the rest on a PF NACK, in iavf_virtchnl_completion()
>=20
> v2:
>  * fix typo (Sashiko)
>  * abort iavf_configure_queues() at error (Sashiko)
>  * report send and poll failures with dev_err(), they are not
>    recoverable here (me)
>  * cast via uintptr_t in iavf_match_vc_op_cb(), for clang W=3D1
>    -Wpointer-to-enum-cast
>  * commit message: the limit is the number of queue pairs that fit
>    into a single virtchnl message (62), not 31
>  * commit message: describe the switch to a synchronous op (Sashiko)
>  * stop at PF NACK (Sashiko)
>  * on timeout keep current_op and IAVF_FLAG_AQ_CONFIGURE_QUEUES set
>    until the late reply arrives, instead of resending right away;
>    clear both on other errors (no retry) (Sashiko)
>  * fix dev_err() continuation alignment (Sashiko)
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  2 ++
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  1 +
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 25 ++++++++++++++-----
>  3 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 8c45536fd502..a41d2726ebd8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -269,6 +269,8 @@ struct iavf_adapter {
>  	u8 rxdid;
>  	int num_active_queues;
>  	int num_req_queues;
> +	/* queue pairs sent so far, for ops that take more than one
> message */
> +	int cfg_qps_sent;
>=20
>  	/* TX */
>  	struct iavf_ring *tx_rings;
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 2f8a80a11336..d39737dcd425 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1258,6 +1258,7 @@ static void iavf_configure(struct iavf_adapter
> *adapter)
>=20
>  	iavf_configure_tx(adapter);
>  	iavf_configure_rx(adapter);
> +	adapter->cfg_qps_sent =3D 0;
>  	adapter->aq_required |=3D IAVF_FLAG_AQ_CONFIGURE_QUEUES;
>=20
>  	for (i =3D 0; i < adapter->num_active_queues; i++) { diff --git
> a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index e6b7e8f82c7c..356565aa41c8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -8,6 +8,11 @@
>  #include "iavf_ptp.h"
>  #include "iavf_prototype.h"
>=20
> +/* how many Flex Array Member entries do fit into VC message of type
> +*ptr */ #define iavf_max_vc_entries(ptr, flex_member) \
> +	((IAVF_MAX_AQ_BUF_SIZE - virtchnl_struct_size(ptr, flex_member,
> 1)) / \
> +	 sizeof(ptr->flex_member[0]) + 1)
> +
>  /**
>   * iavf_send_pf_msg
>   * @adapter: adapter structure
> @@ -375,11 +380,12 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter
> *adapter)  void iavf_configure_queues(struct iavf_adapter *adapter)  {
>  	struct virtchnl_vsi_queue_config_info *vqci;
> -	int pairs =3D adapter->num_active_queues;
>  	struct virtchnl_queue_pair_info *vqpi;
> +	int first =3D adapter->cfg_qps_sent;
>  	u32 i, max_frame;
>  	u8 rx_flags =3D 0;
>  	size_t len;
> +	int pairs;
>=20
>  	max_frame =3D LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp-
> >p.offset);
>  	max_frame =3D min_not_zero(adapter->vf_res->max_mtu, max_frame); @@
> -391,6 +397,8 @@ void iavf_configure_queues(struct iavf_adapter
> *adapter)
>  		return;
>  	}
>  	adapter->current_op =3D VIRTCHNL_OP_CONFIG_VSI_QUEUES;
> +	pairs =3D min_t(int, adapter->num_active_queues - first,
> +		      iavf_max_vc_entries(vqci, qpair));
>  	len =3D virtchnl_struct_size(vqci, qpair, pairs);
>  	vqci =3D kzalloc(len, GFP_KERNEL);
>  	if (!vqci)
> @@ -402,10 +410,7 @@ void iavf_configure_queues(struct iavf_adapter
> *adapter)
>  	vqci->vsi_id =3D adapter->vsi_res->vsi_id;
>  	vqci->num_queue_pairs =3D pairs;
>  	vqpi =3D vqci->qpair;
> -	/* Size check is not needed here - HW max is 16 queue pairs, and
> we
> -	 * can fit info for 31 of them into the AQ buffer before it
> overflows.
> -	 */
> -	for (i =3D 0; i < pairs; i++) {
> +	for (i =3D first; i < first + pairs; i++) {
>  		vqpi->txq.vsi_id =3D vqci->vsi_id;
>  		vqpi->txq.queue_id =3D i;
>  		vqpi->txq.ring_len =3D adapter->tx_rings[i].count; @@ -425,7
> +430,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
>  		vqpi++;
>  	}
>=20
> -	adapter->aq_required &=3D ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
> +	adapter->cfg_qps_sent +=3D pairs;
> +	if (adapter->cfg_qps_sent =3D=3D adapter->num_active_queues)
> +		adapter->aq_required &=3D ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
>  	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
>  			 (u8 *)vqci, len);
>  	kfree(vqci);
> @@ -2551,6 +2558,12 @@ void iavf_virtchnl_completion(struct iavf_adapter
> *adapter,
>  			dev_warn(&adapter->pdev->dev, "Failed to Config
> Queue BW, error %s\n",
>  				 iavf_stat_str(&adapter->hw, v_retval));
>  			break;
> +		case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
> +			dev_err(&adapter->pdev->dev, "Failed to configure
> queues, error %s\n",
> +				iavf_stat_str(&adapter->hw, v_retval));
> +			/* don't send the remaining queue pairs */
> +			adapter->aq_required &=3D
> ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
> +			break;
>  		default:
>  			dev_err(&adapter->pdev->dev, "PF returned error %d
> (%s) to our request %d\n",
>  				v_retval, iavf_stat_str(&adapter->hw,
> v_retval),
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
