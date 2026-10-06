Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC33E1701;
	Tue,  6 Oct 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274461; cv=fail; b=m3R3PV8ER/WzjUNTn3aE1fvE/ILM9Ki79KQ+TE99177w+zJipFDD0+gvDoPzV7GiitAq49aMSJc11OTwyN6URLoP9K2VNFJC7OdVHvP3xEiqc+HqIztAD6RT9L/AeLcaoTuDQL2RczFigVnVhaRcMLAOP8bPQFM0x63gPz5CrbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274461; c=relaxed/simple;
	bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILSWM2P0IQL/zJ3Mf32gIJec1cU6q2M4GSO7czV1jFLoA/6zV2+yLzCrqO7STp/8CQkNAkw9Y/VAipanJ092FbSSD8WMXj8QTGUW4ddnWBybRqBzzVl/EServCw60S7MCVJDvHpej7PCqwjfjBDnH3ZpnDx6Txpo9CAYS/IRIGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWjqJYkK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWjqJYkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791274459; x=1822810459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
  b=UWjqJYkKbGuBcMROChAaWJ5mq8Gihmvtm6IJVZ7IvaKtBn+TkPX1tsVc
   vI2+8KTIW1GaCZaUViFcd6nkNNmTCWhTlXd9/UZy//jpGofvsmqiEklm8
   8raG4IRDsROakE+V17lMyYeI37hiXAYirdNj+ghUkctaEC3Zq8OIX8YW7
   zI+lbdBzwvtfbTWhS3J9V1NIaNoaqgHaD+E2X8cWF0KiGFu9JMVlJN3yq
   u0m7CCCuj4DZX9VcfC9enMltq/DY07QVcH3j0SKf1e5rsSysqSWb50i16
   ydUZwoSB6qm5G2cHpjB/puKgIvjRzsMave8VcZlVWKNcU5WaQErwdUEfA
   w==;
X-CSE-ConnectionGUID: TSsBuSqqTwOO0Ip6JQ904w==
X-CSE-MsgGUID: EIp4+t5jSeiZ6RdaBptwSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="14118"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="14118"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:11:59 -0700
X-CSE-ConnectionGUID: L/E4hZd/RbGOBUH6a/uMoQ==
X-CSE-MsgGUID: L1pxdbqVTniVLHNIngcaeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280333648"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 01:11:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:11:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 01:11:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 01:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0ymwRQYikGe1TYaVlTLFcmoOL44oGr979BXC4TKLMMTeHyKTijLez1fk2jYU0sPDnYutXBQlbMX5PPmq3Wnh8UGh3DnHXh/vvMFwwb4BjTtSsvV1+Ul0Mdq1veeE/uKnE6VowGjXt/swZOrhwAnwhKhFCx/5Dx3PP40fMqXQVzWa1tpxJV5kWpydA1B/+ST+ZQ//AZ7tnpGi9AGyiW6ry6GRpOB9y+6BfBIPKa+MoxdJDHc8+dRdSgF7WoD8RR2sUPY1OJpaU2W1YdMtSFPJZzNOFWiOWbzHtrb5f6WLcays9Tji/OGU9gY1taY1qg4nGG/cXgYxQElEV/00OUbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzmATGRjgvcwu4ZJlvyyiEJEOuG9LOaSBqcDH2GdcNI=;
 b=Xd23OeaLXL23c2VWkG0N81urXO+cVRvubwxwlpmmUi7omxR5V8sIt2aRpH9Ht+MLnhsCLhQ3o54nm+7s4MxvzDpAOaYpYn135zfz8doEPdN1M8TKLqq/x7h9BJQjHwqywVSbrhl7Pr+y27iTFPIRvXVtbb2E/7SV5Fm6NLIQS2ddN12edXI2E4q5nPDMgXEpmnWyK3Ewc94/Uql7oCU4NUZ4FeUdmZgFP6Z99aPBxq0aVjohDLgMnjZYMoWwsTXetmM6KXPQ6VLWcxhS7VB8fWrl6LUKs00gAsLg+6ObT44+ZvpaPIRGxN8n2YKnR86FJENcGg9ti/9sJp/IWy1K8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CY5PR11MB6212.namprd11.prod.outlook.com (2603:10b6:930:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 08:11:54 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:11:54 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Tian Run <15503232150@163.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S.Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] i40e: fix VF queue mapping collision with PF
 queue 0
Thread-Topic: [PATCH net-next] i40e: fix VF queue mapping collision with PF
 queue 0
Thread-Index: AQHdRTY7YFIeY3UvUka9yU+18ViYMrbwSjcw
Date: Tue, 6 Oct 2026 08:11:54 +0000
Message-ID: <IA3PR11MB8985AE57DD2CBFF3C122EC028F952@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <178946707899.849053.3626754711268331752@bigrain>
In-Reply-To: <178946707899.849053.3626754711268331752@bigrain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CY5PR11MB6212:EE_
x-ms-office365-filtering-correlation-id: 18010978-c727-4bf2-e20b-08df23817be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|260925021911599003|10067099003|260925022911599003|260925021311599003|56012099006|11063799006;
x-microsoft-antispam-message-info: c4ye996y3kD1PeRpU/pdiebkxR4Hl0D/wIv3Whijlo51SfqXQlC/3BPY5I1fJ7qVEcpAQ5eoXvz+dR8yhcrbe7h3SmQy9a+Qsp4M2QPi9dhZXCeXb8blUBoP+h5anr3e4J7zH6KAnt0v/SSMnnxq4oTiRrW2f2i7UDMrMJLXQXehoYF8j4tWhMqwyu8/yg4ZeXDzdRzcGEGY2BO1hVssL68QHxqbcWxXBAe2pg19F7Z3GOrOJngw6MD2p36jOAREijCM74g9TisYmiMv5t2L9QxqQLFq6/KZTzouy92jToYW6vU8UAguRHDKGyQMcPvuUH1Yf2cwfxs7+UXVdfeIgpwWXY/v8Ggf+uaCwJ3fDiXUSf0+pBuFYEhJjXNly/eXBebRnoqt8YkZ2lSw3tpHCKQV2BcKn/prM9LAfK/bqzim7K1HxSsYth9wd3nR3Oi4qNVkOUB+421hfB3p1nbgclfeVpb82MVx5X+1wqhdWwFcbwa4HvV1p7S0JvyCdVPGcQftKN75VGXMjU3OWoxHn0f2evJ4fTV1TZC+B3XzeoUcWVunun7rg8yWSS0s3VBkpGDFtWqXMbxd7wjWn1IIlBwYPVbCXj/jW3FeiZQW6jxGDryFQ1qrp17PaSBzCbZZ+ZJtiNVFxDuzS5Mm9B8cBjdK5ZBuho9jH/Zl5H0xH/5UbScfPIjDy2HGLn9C6soShruI3igw4aWO9Ue0hCUBbAivza8ZN2VjBjnCar6qCYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW81MXJzSHRnTVpXNW9UMWtSUWoxL3ZLbG9Ra1d2U0o2UTBtUzhjM2V2VG8x?=
 =?utf-8?B?QzJ3TkRrZVQ2OVlORVVzSVRiczhzb1pHamtoeDVFQ2tmc1JjV3RLRHRyOUlJ?=
 =?utf-8?B?Y3dnRWlBUjg0cEo0MkFyditVWEozTlhoWGtJUFFMb1NBN2k4RG9hQzNhYlQ0?=
 =?utf-8?B?ZXlQMlFXT2wrS2xKdk96Vnc1b1NRR2Y3Y3BVUkFKWEJDYms2ZFRCcEwxMm1L?=
 =?utf-8?B?Y3Z0UklLUjAwWVg0OUlOWXRkdUc4bjFIcWFxdEllQVFCUUZpTHlOYit0c0g3?=
 =?utf-8?B?QWJSemNWVGtsUXlKUFZ6NXJXMDhUZVlxYjAxMEdUSXkwOERmeXBXajdJbkZ0?=
 =?utf-8?B?LytGYWR3UHBMOEE0TytsQ0NEOTVKMEpWZnAzSU5LRW1yZ0VXbnd3VUhwYzRI?=
 =?utf-8?B?eTF1SHM3S2tXbnpUV2gyWElBczRuNm5ibHBaaWVwTWJQOFQ1dXNFdFBwWmxo?=
 =?utf-8?B?Q3V3SG1DWW8rNmt2aTNpTlFMZENDT2U3RHI0cXdiWGdJR2JQOUIyL0pVM0tK?=
 =?utf-8?B?aEI2enJxdGRXK3hncCttdVNoMDdkSWFFNlVJTlk0bXBDSks4RmZucjl0dkh5?=
 =?utf-8?B?aVBkM3lKVlVhbUl5alh3Wmo1LzZyblU4NVBVcWprMU1lVCtzRXhDMVZXa2RU?=
 =?utf-8?B?czE4cjFrNUhXVWhRNVAvWE1OMkZvYWJkTXBsYmF4cXJSVXZZU1dHcEpZWXQw?=
 =?utf-8?B?c1pkU1hBMWowbGI0RjNOWUg2OWZsdmtZVkcvREpLcnk2alppTWtuek5EQkhK?=
 =?utf-8?B?eDNwSVg0Y09uYzJzb1hUdXBQbWtjUm9XbEpPTXJBZkJlY3d6QmJZci9CVVgw?=
 =?utf-8?B?TXZ0ZWRpVk1IUTFORk9FZ2xQcWxxR3R0WjZGbzBxdXZQQWpLSWNlczVhSmN5?=
 =?utf-8?B?ZVFRR095TS93eVd0MGFobkIwakpybUhiWFh1MDBLWmYrY0lyZm42TVpvNDNz?=
 =?utf-8?B?eTVxQW9JYWtQbC84bW4wL2pLSDlObWFpekNYVnFoQ3ZFYU84QUxtL0hNRDhu?=
 =?utf-8?B?dWYydkJZOWtEallHSWIzS0RVOVVDS1didXJlK1pkTlRDanJha0gxNXJUY3Ix?=
 =?utf-8?B?bTRuK1Nta3BwYndFby96a2tQeVRTMHlzQkRvWnpFUFhHOWlxSytMTWt1TnVa?=
 =?utf-8?B?bVkwdHkrV1BIemg5QkRQSzVaRUhBUXdvL1Yxc1haZkJHeGJKVVdOT1M4RlNS?=
 =?utf-8?B?MnBjS1gzZ3F6UUZac2dsRjFrY2pjYjkvck1HZkdNNXVNNXl6Z2kxSGVzdUpw?=
 =?utf-8?B?cUtuWTdFaGtjZmpHeDcraTkzMlUzbmI1aFVYdG56ZUtOZm1IcVlEb3gxZkZF?=
 =?utf-8?B?dFdjaVhvaEg0SXhxcFFsZ0xVK014SGpUWU9aZEV5RjJuSmtCVy80a1J1dllU?=
 =?utf-8?B?YlhhcG03d0FEOFIzSVZPVFhvL1llQW85ZVhrdm1hMnBVR3B4emtOWWhCZnU4?=
 =?utf-8?B?bXJRamJCVHJJRUNDdVozTXBoYk5Cb0hCMXlCR3A5RnZvMUp1Tk9CTGtSMjQ0?=
 =?utf-8?B?T1QvNlR3MEhMdzF6enpXdmFldDBQb3pCVnduamQ4aHBXTFFjMkgreDNyVmVt?=
 =?utf-8?B?ZnVEWWM5ZUdDR2dyMVlmZnkweTVSUzBvTCs4aUtFUjBTVlU1U3dzMzJhTFk5?=
 =?utf-8?B?NU9idHh2M0svZXJHRlZlMEkyWUZyVzkxKzhGZ2VmSDVOQ0hWNzliTU04d2N1?=
 =?utf-8?B?dVJTYXMzK29EN0MrY2tNc2NuVzY0aXZEMGlrRHBKdFhEL3RkclpLUTU0UmVn?=
 =?utf-8?B?UGhla0FjZUtzcHVKRzVJS2FWdHJsbW13YllnUFF1cWUrVFUwUmFPNTJYaDY0?=
 =?utf-8?B?b1RxcDY4Mm1wYXdFWGszN0MzOThIZEJsWGZiVWVGMUdMdWg5bDRRTERqVEhq?=
 =?utf-8?B?YzJkaEoyclBqbGxIVDVkWCtHazZEd3FLV1lQK2UxcHpiVHFrZHFBVHRiTXd3?=
 =?utf-8?B?OTY4Vm9FYWhMMmhLeHVUb2loOFdUaHdFRUVuYXdZZHYyOXp6NHhROHFHcEd6?=
 =?utf-8?B?bm0zZkdqb2wrVlY1VWhYYUtNcU40b3U2d094YWxhOHk3aWNxRlpSN3JLdXRL?=
 =?utf-8?B?aTFDd1k2b0Zzdm5sNXhRVmxQcTJvblJYMFR6MmlpSnlOelRGVUdTZURMLy8v?=
 =?utf-8?B?Zy9rWlc3aUxUVkFTcTNoQnQwZHB3cHVwNGRETzY5UzBxakduNTR3cGozUkVs?=
 =?utf-8?B?bG9UWGg4YlJuMjFmRXhPdEpjZTNGQm1kVytFZFB2eHlxclZmWitHazRTSjcr?=
 =?utf-8?B?azlKaFkxZ2tMc1hoNUV6akZ1S2FFRkpzaE15S0tvM3BiSWg1a0oyRk5SUTZv?=
 =?utf-8?B?dmNsVzRVVmtRTFk5WjczekFqWkVmNlVYVkJ3VzUyRXFoSUVGSTJ3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ezylGgRbSZWjY67Jxit6+YJ9Zdh68xELXiGurWjVwgeUJeI/OwuK8fBOiwS7gL2f2yaXqRUtyXzgW7V9/brxMIFUy+KNN8Hie8GOuZBgrZNcZhLtAkZlE6btmISqZsNomoFDPvUsaYrvJqFiaDxdGcobriIelgnieleyF8gM20kvmhZWKLMNvsimQcp3B6aXJw0LkCBiuH/l54phn4JyDrNwI9pLJVRDGtyEzABsHSDVVHO9mYDOtvKw5fvmE5ogxKl+eKZCzfRcmy+hv/Rp9Y+d8k6Sfswwqh4dYlOG3KvfdV/fHutY9lTtcxuaap/qptB3N8rEjOQKMt9HngYNlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18010978-c727-4bf2-e20b-08df23817be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:11:54.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hAe8nZYaw/ebmZoQxQEvkmYFmB2OMRr93JQOORzabg9Mz5fNmtE7K+kFgArEFYZ22MK+obxL9TsQbMOvH8N3MmsVUZkNJ+nRnIb3XkGtKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaWFuIFJ1biA8MTU1MDMyMzIx
NTBAMTYzLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE1LCAyMDI2IDEyOjExIFBN
DQo+IFRvOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwu
Y29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNv
bT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLk1pbGxl
ciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBbUEFUQ0ggbmV0LW5leHRdIGk0MGU6IGZpeCBWRiBxdWV1ZSBtYXBwaW5nIGNvbGxpc2lv
biB3aXRoIFBGIHF1ZXVlIDANCj4gDQo+IGk0MGVfdnNpX3NldHVwKCkgbGltaXRzIHRoZSBxdWV1
ZSBwYWlycyBvZiBhbiBTUklPViBWU0kgdG8NCj4gcGYtPm51bV9sYW5fbXNpeCBhbmQgZmlsbHMg
aW5mby5xdWV1ZV9tYXBwaW5nW10gb25seSBmb3IgdGhhdCBtYW55DQo+IGVudHJpZXMsIGxlYXZp
bmcgdGhlIHJlc3QgemVyb2VkLiBpNDBlX3ZjX2dldF9wZl9xdWV1ZV9pZCgpIHJlc29sdmVzIHN1
Y2ggYW4NCj4gZW50cnkgdG8gYWJzb2x1dGUgcXVldWUgMCwgd2hpY2ggYmVsb25ncyB0byB0aGUg
UEYgaXRzZWxmLg0KPiANCj4gaTQwZV9jb25maWdfdnNpX3R4X3F1ZXVlKCkgdGhlbiBvdmVyd3Jp
dGVzIHRoZSBQRidzIHF1ZXVlIDAgY29udGV4dCB3aXRoIHRoZQ0KPiBWRidzIHJpbmcgYW5kIHJl
LXByb2dyYW1zIFFUWF9DVEwoMCkgaW50byBWRiBtb2RlLiBUaGUgUEYncyBuZXh0IHRyYW5zbWl0
IG9uDQo+IHF1ZXVlIDAgd2VkZ2VzIHRoZSBxdWV1ZTogdGhlIGRldmljZSBzdG9wcyBpdCwgcmVw
b3J0cyBhIE1hbGljaW91cyBEcml2ZXINCj4gRGV0ZWN0aW9uIGV2ZW50IHdpdGhvdXQgYSB2YWxp
ZCBldmVudCBJRCwgc2V0cyBib3RoIFBGX01ERVRfVFggYW5kDQo+IFZQX01ERVRfVFggYW5kIHRo
ZSBQRiBlbnRlcnMgYSBORVRERVYgV0FUQ0hET0cgLyByZXNldCBsb29wLg0KPiANCj4gYWxsb2Nf
cXVldWVfcGFpcnMgaXMgc2V0IHRvIHBmLT5udW1fdmZfcXBzLCBzbyBHRVRfVkZfUkVTT1VSQ0VT
IGFkdmVydGlzZXMNCj4gdGhlIGZ1bGwgY291bnQgYW5kIGEgVkYgd2l0aCBtb3JlIG9ubGluZSBD
UFVzIHRoYW4gdGhlIFBGJ3MgbnVtX2xhbl9tc2l4IChlLmcuIGENCj4gNC1DUFUgZ3Vlc3Qgb24g
YSAzLUNQVSBob3N0KSBjb25maWd1cmVzIHRoZSBleHRyYSBxdWV1ZSBwYWlyIGFuZCBoaXRzIHRo
ZQ0KPiB1bnByb2dyYW1tZWQgbWFwcGluZyBlbnRyeS4NCj4gDQo+IENsYW1wIGFsbG9jX3F1ZXVl
X3BhaXJzIGJ5IG51bV9sYW5fbXNpeCBsaWtlIGk0MGVfdnNpX3NldHVwKCkgZG9lcywgc28gdGhl
IFZGDQo+IGlzIG9ubHkgb2ZmZXJlZCBxdWV1ZSBwYWlycyB3aG9zZSBtYXBwaW5nIHdhcyBwcm9n
cmFtbWVkLg0KPiANCj4gRml4ZXM6IDE1NjNmMmQyZTAxMiAoImk0MGU6IERvIG5vdCBhbGxvdyB1
c2UgbW9yZSBUQyBxdWV1ZSBwYWlycyB0aGFuIE1TSS1YDQo+IHZlY3RvcnMgZXhpc3QiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBUaWFuIFJ1biA8MTU1MDMyMzIxNTBAMTYzLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jIHwgNiArKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYw0KPiBpbmRleCBhYmJjNzFlODEuLjI5MzQ4
NjJkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBl
X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFp
bi5jDQo+IEBAIC0xMTQ0Myw2ICsxMTQ0MywxMiBAQCBzdGF0aWMgaW50IGk0MGVfc2V0X251bV9y
aW5nc19pbl92c2koc3RydWN0DQo+IGk0MGVfdnNpICp2c2kpDQo+IA0KPiAgCWNhc2UgSTQwRV9W
U0lfU1JJT1Y6DQo+ICAJCXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPSBwZi0+bnVtX3ZmX3FwczsN
Cj4gKwkJLyogaTQwZV92c2lfc2V0dXAoKSBsaW1pdHMgcXVldWUgcGFpcnMgdG8gbnVtX2xhbl9t
c2l4Ow0KPiArCQkgKiBrZWVwIGFsbG9jX3F1ZXVlX3BhaXJzIGNvbnNpc3RlbnQgd2l0aCB0aGF0
IGxpbWl0Lg0KPiArCQkgKi8NCj4gKwkJaWYgKHRlc3RfYml0KEk0MEVfRkxBR19NU0lYX0VOQSwg
cGYtPmZsYWdzKSkNCj4gKwkJCXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPQ0KPiArCQkJCW1pbl90
KHUxNiwgcGYtPm51bV92Zl9xcHMsIHBmLQ0KPiA+bnVtX2xhbl9tc2l4KTsNCj4gIAkJaWYgKCF2
c2ktPm51bV90eF9kZXNjKQ0KPiAgCQkJdnNpLT5udW1fdHhfZGVzYyA9DQo+IEFMSUdOKEk0MEVf
REVGQVVMVF9OVU1fREVTQ1JJUFRPUlMsDQo+IA0KPiBJNDBFX1JFUV9ERVNDUklQVE9SX01VTFRJ
UExFKTsNCj4gLS0NCj4gMi40My4wDQoNCg0KVGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxy
YWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4NCg0K
