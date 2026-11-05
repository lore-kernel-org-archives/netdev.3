Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884844;
	b=DnDnN0XECxYQ0E9CtHa4pb2ucBgUGnUWGjbxyr55jlAv5ZZM1FC1JOtTkCFV66bNlV1j
	 J/mfbyBGE0UsRB3EHEmJaDPHWeoga4OWVJwud151ORbxTaD5FNdKMvMOhxRZa0urJH8cy
	 v9ryu7zwi3cjW67Ld3YtpboDEGpv5Px8Idp7LrXjaDNXuW3o2WdxMPtBfTBXqpRxCR073
	 9lqX4Saz91uJe/G4NCELlR4li2vUZ0PX3D+hHrkXvncm5JQqW4gcT3U2VZ2qCOjFRTWEr
	 fEEhI7PbUjD46iz3QVsV3mg26Q62CanQ+rwi9+rjQ/ES7T9Qz1M5+DzRrWI8wM3oVnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884844;
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
	bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
	b=lqrxITDwFs3xPufxLCDZltthldtbFCuPdJ7hJerCz6XaUsq7f9KSm+tTaHW2SCt+ok8/
	 gcBYm1MpwitEPTE09C5YuzheM0ui8wAt+HtJ+K1unghKpq93Do+bvsBqdHcK+eKz8rPJr
	 012UoKmD1e4rvW1O++PIukSNbFK+p8mdQZYffw1aIEQCkrF0p5QAzXixQ83znm0oY3g8+
	 lCWY51ri5WWUd8tbCngYSrMqVJnN/9tzmJxlZp/Vq4HGzU3jMovc4tbxUfBBe/CsLpd9j
	 BdAq7ePrHzK/mykknHvABhgzIGTNDteFk2L9KRgWokPGlVORlkPO/oxLXDtKCvO8i5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OEsGzSQH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD2606A31B;
	Thu,  5 Nov 2026 13:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CD2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OEsGzSQH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793884843; x=1825420843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
  b=OEsGzSQHaRREPKmGIJILG3NntOPbZeczN6t5fmG0FIPkETaK4RvxzY23
   M8b8YzJGgZl9BAtqQABPJ6ERkRXtfXMhRY5SNcDRSlcUzVl4aj36ucgvB
   DDCP3fJlcTGlYL9IYTkGaQD41US7Csfy9saHCu05v89IanjG01LqakGUC
   m4vyWSwHQ6q6mD26fC01bw6+uBvGNQ6oJ0xp0YXlA1iL0NmtDf2UOxJhU
   C0hDvWGcCGtzEYa5Ti/1xP2ZHeMUA89f/8QDAfxYqgDWThuVe5T3UltEe
   Sn11ihmFQYcvTaHZWIJgq3awdMWarQkPtMFTwfik07Vm/+4AvVuhf6q+R
   Q==;
X-CSE-ConnectionGUID: 2mkfdBjUTAS/dokHRryWig==
X-CSE-MsgGUID: T6fzJWtwTD+arxYNWDI2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2557309"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2557309"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:20:42 -0800
X-CSE-ConnectionGUID: GE5Gfgw6QnaD+2DZzOBBzA==
X-CSE-MsgGUID: xnmIIDrYTVqKa3iS1fkPeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7417629"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:20:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:20:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 05:20:41 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:20:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT/rrNZpR6UB/7i8K1p5GOMGPYARhUmkzrHCnNjHnbM65HpblGhTbcC9H2ELxx07cQpYPkcPSkmSYIy/fXl72kwxCkMlz8T6s/y1z9rxtzqyojF3uzaKeD527waCi4Jy7RzkWGOVyUeNtXLbMx0jMuvFfbLMnEI9ZVfl0H49bdA2KfnDLWYsHb2xAiz+kJ4QD7OUqtTC3wbd+jtoBl8xeKQl6uYRgVOsC2xzFtWknfjzrdjKn4v53bl+Fx4xGi/7/CkBqR+6k/th4gMbPFn3jN38wfpZZpr6U62KkgR65b7oVgS8uQ+x6Lwtqu3KUQPcfZoEyi0cWqpJBf1iXsA3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x85ET5mc1i2HLEFBf9uOg3USJS0vxv6/D5h2dTdn0Y=;
 b=emY92l+EjNFXnV8/xrGmKidEKn14cnyB92cTV+vKpKjubVLbnLKEa4ze0TxgpH7wYiqOlfXHed3xjolPXvkvH3fxdhgOjUL/jQBVsB5Hvg+dmK7SOWxyqGw4amjD9pK2/kdw+CqgrY1uWrIWm1AwNG0FKOTvjjHToFYuVq2TQLVe3NzDSDVOTTfmdWYdLYTgWTZrYk8duoWQc/emUJMnwkO2+8tDySvacZUSl6yTEtbtQnno9GTCD71hOtBAYgLbRDzmTSPsxRpi8Cy0fEh+xzuFROaAK8h8LyvjGKiNGNptb5gvD0iS/doycItD489Az4fqwG5CPszlnivUkqATew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 13:20:38 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 13:20:37 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Simon Horman
	<horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"Machnikowski, Maciej" <maciej.machnikowski@intel.com>, "Neustadter, Marc"
	<marc.neustadter@intel.com>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
Thread-Topic: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Thread-Index: AQHdTT3/mw0oX4rl5kuPy79D8beTq7bhGAuAgCg2T4CAFmfWAA==
Date: Thu, 5 Nov 2026 13:20:37 +0000
Message-ID: <IA1PR11MB6219BE8C90BA9A3BC9E2A9F192772@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
 <20260926170543.GA13925@horms.kernel.org>
 <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
In-Reply-To: <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: 01708580-dd05-4f99-5723-08df3b3f94ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261102123227099003|4143699003|261021123027099003|261009223027099003|261021121427099003;
x-microsoft-antispam-message-info: rzMCbH94WmNdcwtknawPocMJEsWQ74I5hWH9vI+8dMSNEKhfGeQ0e5tr5AZPf8uYOD3aqhpMXCIAFsmWVGv0QWI6oSIibRsmcOG7Nt8X0BwZbrAXavalGCgUl7gO6IVHSO02ta/q2VmFwSFrSF4G1hqfh0XaXi/SI1h8E9MGSKmoDgTk0xPDTuyID8HPInL+nKX7FbRf+1sZfLEPfusmK+cH0iB/yUKJM0kcAll2O6EACVVVYAQFB9ZlRm2BWRQz+WGC8VUtwNa5QmZ925H3jNJtiJMQN+C0cdys46Z0nZvkKP23uvDtvU8hJHcBwuLmIHw7J1ZoSvpSUH/KFyCubH3IF9x/ggv6DZ66T6iH9e8OFk91kXvJbpnb0nhgkWKyYP4h4ywfNao4oS8viThWSgIPNSlmzgLGfPr1LTLy+DwTsHTpn6TUjWi/OtK2CCWq7dVFcVfEHkQ0d+ShLBT4+KHIf2SZqz+gM40+9Q32ZTnMPf+lp5zNNLDqDRIOjRY7rm+lTc1K0zFoQH5sCnIi+Nh87Tu2avVETUEmlYAV8U1vE6uNXYgI1gfk6ZDw/jaGpwRFFTlpnlrOmnmCpoFBzTHad7+5yXwyH47/NHhZLaL8lKC0K+QUqIyM6cakzaYQSPYKoDHEJZCooJ/7JuH3Oq7cn/YSlmBQG1Z+le95wWwtFgz8aKchnuaVfLysOfRJkE5+ftvGHdbWh0lKfpHkixWSBiBQaFyWAYw1oJNDFRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261102123227099003)(4143699003)(261021123027099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVBRdzdCb1h4eUxiditobVo2djVsTXhEMXZ2VkZwM09UeHJIOUVFREtLY05y?=
 =?utf-8?B?RDlwVlJPZkNSRHJrUFEvUklWMGlocW42K05Dcm0wSTJpWmU3UWdLOUFDdVFt?=
 =?utf-8?B?eG9UZHV3T05jUTdQbHdkWFhYNVNHRXlqMGRvM1NHUWszRU81cUdwamthZGVo?=
 =?utf-8?B?OWVKdkkzSVNMWU5XOTN2NXRLY2Jqa3B5ajlJbVJjUitqenVCUkwzMFhmL210?=
 =?utf-8?B?YUJBVTlxL2U5YUxKVUw5RlR6T3I3aHd4RVpTeUdtam1BVy9ELzdGMnR5MC9k?=
 =?utf-8?B?RXJaVjJOdy84QlkxM2xUTWxEWU9jTXUyZVQybVZYV2dBRlVYd3FTV0FJTGps?=
 =?utf-8?B?THRKb2pVTVM2Z3hYUWpwRGxkc1Y5Vmk1L0dDM1JJNGJ6Y09ET2lNSi9hVmtP?=
 =?utf-8?B?Y09wWGZORkdEdjZ5M0Y3R21jYTBwUWc4R0pRQUM1ME5MT3lYQWIwWXVLSXEx?=
 =?utf-8?B?M1pIV2FBS1VIWXdsVlRVTGQ0azl3YzhYQ0FKOXI1NW5KU0VwZnBDZUI2RGp5?=
 =?utf-8?B?aG1KL1dpZkhYa05wSUM0TkhITWJYSlA0cWdYZlBBVjN1YzdZNDNGSmIxQmpF?=
 =?utf-8?B?ZzMvMithdUcwNEw1emtlbk1WYkVOVEpMaVFIWkZsdnFRWlhnZXlZbmQxZUJY?=
 =?utf-8?B?Rjk4bk4xazRQM1lTcmhxNHJpUFZIMVlBRFA4YXl2MUxsMERwWVBzdU5FZmp5?=
 =?utf-8?B?aStEOEI0S1V3eG9iZlFMOWYvbmFkc3c4UWRmV1pWQmZkWElMd1gvNVR1OXdC?=
 =?utf-8?B?RlhHdHpxUzVHRm9vMGlFSllOaVFldnhiejdOa3pmMFFyWUFrVlJQQ09ZRmlz?=
 =?utf-8?B?ZWJuKzlRR1g1bURVMGxjdUFHTnRXblhtMFFzQVNnZjRVUVZjbzA0WnA5L1I4?=
 =?utf-8?B?N0RnU1dVRmJxZGd4N0xEQzROU29teThHTXYxZHp5L3RQYnU0NElYVFhoS2Nn?=
 =?utf-8?B?QXNlaUNjTmw0ZVNzN0tzR3NPYmRKMmpSU080WHBaTzE5VzU4Y2dGUEJpdnQ3?=
 =?utf-8?B?eG1KM0tJcDVHcjdkYTVZNTZXRVNGWEtKa3I3K1dSdERqT1F0ejk5UkxvVHRW?=
 =?utf-8?B?UGZwT0kwc2NiTEgvSC9XV3dnTk42KzhpZHlFOEVXeXErUlMvOFIwTUtXTXov?=
 =?utf-8?B?a0tzY3Y2blBYNFptdDJLcG40ZktidlYzVXppUXc4QWUyYkVGdjZBQzF5azFS?=
 =?utf-8?B?eW82U0FSTWUxMDdQb0UrbCtYTk5Wc3Z4ZXFZVzh4YTFVckNBSTR6dDc5V3BM?=
 =?utf-8?B?MlhBV2N4aGk1d1hGazMrSDJvQ2N0N2o5WVFmZWFlbEU4ejdSK2MrWkVmZDYy?=
 =?utf-8?B?bWlNeUlpbVlINEFMaElObmNNRk5DUHBYanpjdWJic1IwRk5kV0NvckIwcGNE?=
 =?utf-8?B?aC9ndmVwdWRuZ1VYTkJuTUVNZ0hzU2JMQktMbHFydUJmL2JIN3FaTDdoVjFL?=
 =?utf-8?B?cERqZjJLZ2RuMWNKR2VGWC9nTHRDMFNPUTdEM2w4YmNxdEp3cFRuR0VoMk51?=
 =?utf-8?B?cXRaTDB4WHJmSHc4Z09qb1JKRHFsNmF2UnQwQk9nT3BPcTJvNnBzdC9XeEJs?=
 =?utf-8?B?Y0V5TVc4cEJKbXZFYVFoUkJtbUQ0N1YxWS9VdnVPa1ZEekM2OGNtdGNpZGtJ?=
 =?utf-8?B?SzEvUjhIYVRJdkFsTmZEeG8vY3BJd01qemVoNUpzKzdTZjI1enVnRE0yUmVF?=
 =?utf-8?B?NzJRV005ZzIxOXlUUkZmejFENlZJMTZ6eGtrVEZZU0pPalRPSDd5SFM2OGpt?=
 =?utf-8?B?MzlGK1pvcTVlSVdaOGpKUUZoK2p0T1BkQ203TlpoK3VJNnhYb2VENGVhcWY3?=
 =?utf-8?B?K00yOVpYYm9lT1E3VmZKenVYOVdHcE9BY2Fnc2NJbHBjVTBVcDZSbHJLZzlk?=
 =?utf-8?B?MkdwYjlPV1dmYVoyU0cwZlJ3SC84L0hQekpodklTSUxxNnd5S2hWZWI2NHdw?=
 =?utf-8?B?UHZUTUEvUEI4U3NFSGhpR2xoc3RsdkJpbHVBbjMvQkVuZnNUTXJJU0d6R1Vv?=
 =?utf-8?B?NVJpQmRDZmV4MFh2aEV1anF5dm1yNlh0azVsbkE3Y1Qvckg2QkFwNG9lOTdP?=
 =?utf-8?B?T0lVRTlQVXFDaGtWMENrbnNXSmJabWE5bW1CMDE4eWlmeStBMzhVWXQrVFcv?=
 =?utf-8?B?cktWbDZnMmxWWTVnWTNsNjBrMXh0aGo0VldjbGJzLzFaN05lbEp0cndPRUlo?=
 =?utf-8?B?b2JiYTBGOE9LM0pUR1hnYW1tRXluN3FnREZuN2NVdkwwd0h5QlRHdGozSlZI?=
 =?utf-8?B?emtucFI0TUI3VjRyNG1TUE15RzhmNFNxUGllZTlQelZzSXEvVEJ0Z2RTMExR?=
 =?utf-8?B?aDZYMmEyNzllUUIwMU5ZMEIyRURKK3FSWGVDYjM3bkNUSEdNeEIrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kt4InSrKv8ckhN5BK+pksrbc7A0E+3/N9kQgpBZjXAvrff7JDPXVn06QTjFIymZvli+240Kt6xXeg7C9AgSgYcQJxBvg1mlluYlDrStqxuWbpRNB75ot1eGHfxr6Ri1n7iPTaNrGkZIFZ9bJxoJ2etqsy0E+3cTyZ5jVvjNdzFe7qZ82+zt8qpAwjPb0VmJlZq3WIF0jFRzpGQ9h34PXLchT9pgaUmYGv/Ne/ZoEMNv6TMhGbD3W3OC8fQ6KCmcNRe2I2zCJCS72ykzyvKtYLfaBEc3nplZCDXkXaoQVVzsKgDPlKs5udveMMcL3YzwMKJJBXP/lV6IsbXxq1oPxng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01708580-dd05-4f99-5723-08df3b3f94ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 13:20:37.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dL0D5hBwGOnuovswRxlMJ4GsulSCZ9kbmWo5kXhAAy4vFBPC+kzGKmmQhL4HkXu7mZL+kIYQixC77N/Q30J5+lreiTD4wSpawBmUdN3oMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDIy
LCAyMDI2IDk6MTAgQU0NCj4gVG86IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IE5p
dGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207DQo+
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1
eWVuQGludGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeg0KPiA8YXJrYWRpdXN6Lmt1YmFs
ZXdza2lAaW50ZWwuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xl
LmNvbTsgTWFjaG5pa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwu
Y29tPjsgTmV1c3RhZHRlciwgTWFyYw0KPiA8bWFyYy5uZXVzdGFkdGVyQGludGVsLmNvbT47IFRl
bWVya2hhbm92LCBTZXJnZXkNCj4gPHNlcmdleS50ZW1lcmtoYW5vdkBpbnRlbC5jb20+OyBPbGVj
aCwgTWlsZW5hIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IGl3bC1uZXQgMS8yXSBpY2U6IHB0cDogc2VyaWFsaXplIEU4MjUgUEhZIHRpbWVyIHN0YXJ0IHdp
dGgNCj4gUFRQIGxvY2sgYW5kIGluY3ZhbA0KPiANCj4gT24gOS8yNi8yMDI2IDEwOjA1IEFNLCBT
aW1vbiBIb3JtYW4gd3JvdGU6DQo+ID4gT24gU2F0LCBTZXAgMjYsIDIwMjYgYXQgMTI6Mjg6MjNB
TSArMDIwMCwgR3J6ZWdvcnogTml0a2Egd3JvdGU6DQo+ID4+IEZyb206IE1hY2llayBNYWNobmlr
b3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBpY2Vfc3Rh
cnRfcGh5X3RpbWVyX2V0aDU2ZygpIHByb2dyYW1tZWQgdGhlIFBIWSBpbmNyZW1lbnQgdmFsdWUg
YW5kDQo+ID4+IHBlcmZvcm1lZCB0aGUgUEhZLXRvLVBIQyBwaGFzZSBzeW5jaHJvbml6YXRpb24g
aW4gdHdvIHNlcGFyYXRlIFBUUA0KPiA+PiBzZW1hcGhvcmUgY3JpdGljYWwgc2VjdGlvbnMsIGFu
ZCB0b3VjaGVkIHRoZSBzaGFyZWQgc291cmNlIGNvbW1hbmQNCj4gPj4gcmVnaXN0ZXIgKEdMVFNZ
Tl9DTUQgdmlhIGljZV9wdHBfc3JjX2NtZCgpKSBhbmQgcmVhZCB0aGUgc291cmNlIGluY3ZhbA0K
PiA+PiBiZWZvcmUgYWNxdWlyaW5nIHRoZSBzZW1hcGhvcmUgYXQgYWxsLg0KPiA+Pg0KPiA+PiBC
ZWNhdXNlIEdMVFNZTl9DTUQgaXMgYSBzaW5nbGUgZ2xvYmFsIHJlZ2lzdGVyIGxhdGNoZWQgZm9y
IHRoZSBzb3VyY2UNCj4gPj4gdGltZXIgYW5kIGFsbCBQSFkgcG9ydHMgYnkgR0xUU1lOX0NNRF9T
WU5DLCBhIGNvbmN1cnJlbnQgYWRqdGltZQ0KPiAoc21hbGwNCj4gPj4gb2Zmc2V0LCA8PSBTMzJf
TUFYKSBvciBhZGpmaW5lIGNvdWxkIGNsb2JiZXIgdGhlIHNvdXJjZSBjb21tYW5kDQo+IGJldHdl
ZW4NCj4gPj4gdGhlIGluY3ZhbC1pbml0IGFuZCB0aGUgcGhhc2Utc3luYyBzdGVwcy4gSW4gdGhl
IHdvcnN0IGNhc2UgdGhlIHNvdXJjZQ0KPiA+PiB0aW1lciBjb21tYW5kIHdyaXR0ZW4gYnkgaWNl
X3B0cF9hZGpfY2xvY2soKSAoSUNFX1BUUF9BREpfVElNRSkgd2FzDQo+ID4+IG92ZXJ3cml0dGVu
IGJ5IHRoZSB1bmxvY2tlZCBJQ0VfUFRQX05PUCBmcm9tDQo+IGljZV9zdGFydF9waHlfdGltZXJf
ZXRoNTZnKCksDQo+ID4+IHNvIHRoZSBhZGp1c3RtZW50IHdhcyBhcHBsaWVkIHRvIHRoZSBQSFkg
cG9ydHMgYnV0IG5vdCB0byB0aGUgUEhDLiBUaGlzDQo+ID4+IGxlZnQgdGhlIEU4MjUgUEhZIGNs
b2NrIHBlcm1hbmVudGx5IG9mZnNldCBmcm9tIHRoZSBQSEMsIHNob3dpbmcgdXAgYXMNCj4gYW4N
Cj4gPj4gaW50ZXJtaXR0ZW50IGNsb2NrIGRyaWZ0Lg0KPiA+Pg0KPiA+PiBIb2xkIHRoZSBQVFAg
c2VtYXBob3JlIGFjcm9zcyB0aGUgZW50aXJlIHN0YXJ0IHNlcXVlbmNlOiBhY3F1aXJlIGl0DQo+
ID4+IGJlZm9yZSB0aGUgZmlyc3Qgc2hhcmVkLXJlZ2lzdGVyIGFjY2VzcyAoaWNlX3B0cF9zcmNf
Y21kKCkpLCBrZWVwIGl0IGhlbGQNCj4gPj4gdGhyb3VnaCB0aGUgaW5jdmFsIHJlYWQsIFBIWSBp
bmN2YWwgaW5pdCwgYW5kIHRoZSBwaGFzZSBzeW5jaHJvbml6YXRpb24sDQo+ID4+IHRoZW4gcmVs
ZWFzZSBpdCBvbmNlLiBTaW5jZSB0aGUgaGFyZHdhcmUgc2VtYXBob3JlIGlzIG5vdCByZWN1cnNp
dmUsIHNwbGl0DQo+ID4+IHRoZSBwaGFzZS1zeW5jIGhlbHBlciBpbnRvIGljZV9zeW5jX3BoeV90
aW1lcl9ldGg1NmdfdW5sb2NrZWQoKSwgd2hpY2gNCj4gPj4gYXNzdW1lcyB0aGUgY2FsbGVyIGFs
cmVhZHkgaG9sZHMgdGhlIGxvY2ssIGFuZCBjYWxsIGl0IGRpcmVjdGx5IGZyb20NCj4gPj4gaWNl
X3N0YXJ0X3BoeV90aW1lcl9ldGg1NmcoKS4gVGhlIGxvY2tpbmcgd3JhcHBlciBpcyByZW1vdmVk
IGFzIGl0IG5vDQo+ID4+IGxvbmdlciBoYXMgYW55IGNhbGxlcnMuDQo+ID4+DQo+ID4+IEZpeGVz
OiA3ODFmZjhmMmQ1NzUgKCJpY2U6IHB0cDogc2VyaWFsaXplIEU4MjUgUEhZIHRpbWVyIHN0YXJ0
IHdpdGggUFRQDQo+IGxvY2siKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYWNpZWsgTWFjaG5pa293
c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5
OiBHcnplZ29yeiBOaXRrYSA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBHcnplZ29yeiBOaXRrYSA8Z3J6ZWdvcnoubml0a2FAaW50ZWwuY29tPg0KPiA+PiBT
dWdnZXN0ZWQtYnk6IE1hcmMgTmV1c3RhZHRlciA8bWFyYy5uZXVzdGFkdGVyQGludGVsLmNvbT4N
Cj4gPj4gUmV2aWV3ZWQtYnk6IFNlcmdleSBUZW1lcmtoYW5vdiA8c2VyZ2V5LnRlbWVya2hhbm92
QGludGVsLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IE1pbGVuYSBPbGVjaCA8bWlsZW5hLm9sZWNo
QGludGVsLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+DQo+ID4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX3B0cF9ody5jIHwgNDggKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4+ICAxIGZp
bGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5j
DQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiA+PiBp
bmRleCAyMGJkMTgxMzY1MGYuLmQzZTRhZWI3ZTQ5NiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiA+PiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+ID4+IEBAIC0yMDQ1LDcgKzIw
NDUsNyBAQCBzdGF0aWMgaW50DQo+IGljZV9yZWFkX3BoeV9hbmRfcGhjX3RpbWVfZXRoNTZnKHN0
cnVjdCBpY2VfaHcgKmh3LCB1OCBwb3J0LA0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgLyoqDQo+ID4+
IC0gKiBpY2Vfc3luY19waHlfdGltZXJfZXRoNTZnIC0gU3luY2hyb25pemUgdGhlIFBIWSB0aW1l
ciB3aXRoIFBIQw0KPiB0aW1lcg0KPiA+PiArICogaWNlX3N5bmNfcGh5X3RpbWVyX2V0aDU2Z191
bmxvY2tlZCAtIFN5bmNocm9uaXplIHRoZSBQSFkgdGltZXINCj4gd2l0aCBQSEMgdGltZXINCj4g
Pg0KPiA+IG5pdDogSSdtIG5vdCBlbnRpcmVseSBzdXJlIHJlbmFtaW5nIHRoZSBmdW5jdGlvbiBp
cyB3YXJyYW50ZWQuDQo+ID4gICAgICBCdXQgaXQncyB5b3VyIGNhbGwuDQo+ID4NCj4gDQo+IEkg
YWdyZWUsIHJlbmFtaW5nIHRoaXMgaXMgdW5uZWNlc3NhcnksIGFuZCBJIHRoaW5rIHNsaWdodGx5
IGNvbmZ1c2luZyBhcw0KPiB1c3VhbGx5ICJ1bmxvY2tlZCIgc2hvdWxkIG1lYW4gInRoaXMgd2ls
bCB0YWtlIHRoZSBsb2NrIiB3aGlsZSAiX2xvY2tlZCINCj4gbWVhbnMgInRoZSBjYWxsZXIgaXMg
YWxyZWFkeSBsb2NrZWQuDQo+IA0KT0sgYW5kIGFncmVlLiBMZXQncyBrZWVwIHRoZSBvcmlnaW5h
bCBmdW5jdGlvbiBuYW1lLg0KVGhhbmtzIQ0KDQo+ID4+ICAgKiBAaHc6IHBvaW50ZXIgdG8gdGhl
IEhXIHN0cnVjdA0KPiA+PiAgICogQHBvcnQ6IHRoZSBQSFkgcG9ydCB0byBzeW5jaHJvbml6ZQ0K
PiA+PiAgICoNCj4gPg0KPiA+IC4uLg0KDQo=
