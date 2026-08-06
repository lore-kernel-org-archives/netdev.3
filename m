Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AC41E6D5;
	Thu,  6 Aug 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007957; cv=fail; b=E5FXYSk8OIkJMnUvkDcpAbXIhxRIZO4Z85D21UMuK0qmQdgPn+xprn0CMupRMcE1tmq+pO2SzpMkrDEon3gbD8TOpwdfqMLOAWQlqyBZCqrbtbatHgz18D6qWK1AjyRw2GsOz0GHt8oeE23f7rpP1t15t7JM6qacAw/8dscqSa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007957; c=relaxed/simple;
	bh=r2n/tD1HNur7k2c3aDeeKHAiEyvumjGYvZeqR2tLYxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRoKBUC35euuZety9aciECEJNB4wha5I9XtSa14vW1Yq7KTK8N7v5DrLZLhULPWbwsVSd5sHmlPL2srCPc8e/CDoJ7swR1ssYxlo4GDeSLA4zmLtGb5eC1f0bd67pcqxaH+IGEVVtayS2IJUebzT7HPq60cah7ilyIYjIGPAxJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKu/NGz1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKu/NGz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786007955; x=1817543955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2n/tD1HNur7k2c3aDeeKHAiEyvumjGYvZeqR2tLYxQ=;
  b=LKu/NGz1VGYpu21uSK7pFy8UZ0wEByhKAFH1J8jLIZvM68D0VX9xesHW
   CKCZIHSi3L4TbmiRQtpnUk7EofqAPm3qv2JXBjNquEiIusb6EG70peqW3
   dBe29WXMcplep799rtTDhwV985+tZUD4xBbFVjL72h1/W5GTHUFdmx5q5
   UGa5P4Pj7RrBSrk+WikC3ocW45OD1rkXnUtXjlZfHtrDg+ReE/lYh7CFG
   hOHxZG7l4DZw7o9CwtFGr5S3/AI1pw0yYbS5h6BW5pZ49FPoMase9IQUM
   QbR+2vgWFhS5Z9kv173EGz7yR1/r4wncAqGQTr3z/7KwGbndAi2dOGWz5
   g==;
X-CSE-ConnectionGUID: DY9C2DPiQ9mE8H8Nbtt8Mw==
X-CSE-MsgGUID: ezFEo+xGTjCHbsN2v/bFrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104128908"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="104128908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:18:40 -0700
X-CSE-ConnectionGUID: MjVjVZQERG2tjFrxc1Vr2Q==
X-CSE-MsgGUID: oxaJeYEHQR+nJA7SPm9TtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="259434756"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:18:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:18:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:18:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyKjxGmL9iiLxC3EJjAvXB2BaUP/uT4w9BMZHRRSEav2joa0sfE+EyDRDS0GneUm2XWfyNCDQxtTmVJTgpiyaLdAIH81uxoOEVW0TyQlRKjBXf7dulX3YD/JzOygkL8N2a+okzRSFOqM/i5HdWJawsq6V1ck33AzVVv23JNNiAqbRQxmNPEiVEUPjfVv5Ei0JFSA3GX07cL8FI4n1BWau94dFC0L0cOID2hTMpfOemQ+dVqQgF0gp2ZaWSRTVbohD6pt4+4J+E0UnzoBZ2U/s6V0Vj7abcUZXSozzrhopTk+aMtCxOPFbeqv0R5MIPJ/qp/jnjLsqYCm7JVrQl5FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2n/tD1HNur7k2c3aDeeKHAiEyvumjGYvZeqR2tLYxQ=;
 b=jAhd+t4b3wh18z9a9y5xaLaByGIVERcee8hqlsJS5OcTlhA+BrYqgTjxNPrRH4TIvqkYa0be6OQ+mDgjPEMsvO5Q9QPQLfMuIcYNGB5Pic37bk06RM9spLU9NIFXW2z2lViUGWXViwOCU14sBg3wG6kqj+5c7sSeLORNfJJL5kdcp8q5kW+wNfFMG1yMrmvRBkdTz4Zrt8IDb8y7ARms18pv3iNT86/DwOtnpIa3murJ2KXQmUnikdFSwO1hDLdCUk3rn6HoK9Lg8meZqFa6rf11sKv0Jh6z9pl1Li85ai3iCh/pZ5kUrBeftoXnMILGw66m9gDqgm+NhzMcHIzIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:18:32 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 09:18:31 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: James Hilliard <james.hilliard1@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: "mfd@lists.linux.dev" <mfd@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 0/4] net: phy: add X-Powers AC200/AC300 EPHY
 support
Thread-Topic: [PATCH net-next v3 0/4] net: phy: add X-Powers AC200/AC300 EPHY
 support
Thread-Index: AQHdJUKok7Afzep16kyPSdbLfYcMFraQvl2A
Date: Thu, 6 Aug 2026 09:18:31 +0000
Message-ID: <PH0PR11MB590277BD30A0D65438E4C5CBF0D22@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
In-Reply-To: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA1PR11MB7810:EE_
x-ms-office365-filtering-correlation-id: 4a4e1762-07e8-4ac7-7352-08def39baee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: OThC3WQTtWI27Wh6VZgNGFuyHH5WBy3nIzosvORrQTdgigfDRnZP1W9LSnDCBc9k4Sc0I1OfUkOxvN2JjnCrkqHFjxZgt7OYNAKlAHJoAw3JgDTtdk5NyTHqc0MT6Gxhnofc/8l5WA99nI0nUNsT3PXJBWz+hDOEho1pgyH7mPaqvgFXbDJyJghxjN0dd2S8xQQocxP8qifnROwWTlFc2YwL2GbuKoPtwuIZBU4kOpGqnplDUSjeACzRpqXeOLJusEBmAI3YOQ3iikq0VRdAgeU2liwFqsxlB1AcayhIYjZccCKWGF4VP8PoVpTPfkYuPLdFlKCFkzzgR2IQZGGKfjAdVTnPH+Tx0mdYZZPIFeONfYbmWTjhVwAXPnJjNmIRy2O13KCvoCsPQplav1AeTuIk8kCSRc6s24KEpzHH9EbOLDN0AC5/2VVwuQEGLe3AiAp4ckSlgGyv2o6g0mk5ijzB+0N/RZFz5B8gF7ahdUww3QYhaztC77gIYDYm2Whfvf4HFkiqFLU4k+1btVkcOte8vJASzGCf+7etPKXH9rtM4ObiSISGy6ee1wRfcDsGVwB0WxD97ODGizy/W7Z5w9gDKYnWob8kWsGQwqYA3xgbUwc5c7lOp/waR53FPCfASByRUHl8/69LZTlzRMF4N8BTbWvn13paWaOty18HMEvwelJyIvl8G29rxhKuKYt+KRqQVRq90Z2tdPMGBwxc1HiARGulJ3V36UtfaHaZsTqFpysOlTf2KFDA60cixH7E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emxpU3VMWEM2OGRhZ3FiUzVia2U2UWs0R3NEWWRNVHZRa2NudTUvMzdPR2JM?=
 =?utf-8?B?cDB5OWRDRVE3QlFoQWdHYXFQcFU4RjRhNGgrWmQvcW9PTU5NRnFtR25VaXRu?=
 =?utf-8?B?cWh2a3c4ZlpQVnBIL0tGQ3FVTEd5Ym1JNGwxbVNPL01nTHhHNndCVWhLK3N4?=
 =?utf-8?B?eFFVb3VvVjFCYms4dU52ZkFqYUY2Y0dpUDdodytwWWFMVkRrTkZ1a2ZNdEdw?=
 =?utf-8?B?RnByMTQzd2l4WUpUUTZFQ2VwNXJUc0h2SkdsMThpQ0p5VXozVmxzVHlNenla?=
 =?utf-8?B?RzFSWVFKclQ5WmVjSEp0SXAzSE5uM2R0YTNERGhVNy9oM2tFcVlIcXFnNkEy?=
 =?utf-8?B?VWhQT1dqTmZPT3JTRXhjR1JsdlVtd3BXU0dUdnBGeGRRVVZXUUhSeFVGUHlW?=
 =?utf-8?B?bFBnS002dnpWVCtBQmdFd2lMbnI4bTZxRDAzSXNqeTJ6TTF2YjluMUJTb05X?=
 =?utf-8?B?SEJYd3R1WGs2M2hjNWxLajdLd0JCdE95ZkJINXN0NDhDZWdLWjlRcEhzSzda?=
 =?utf-8?B?bFMrRW1Odyt6WWlXRlNsa3JyMW9RVEVjOFdFanAxTm80TW1tNzRpUnZaMU9i?=
 =?utf-8?B?QUNQQ0lxQW4vZ0EzM3p4WUVxZzU3M09STnBncEliODRGUWk3enVOOEJXcU56?=
 =?utf-8?B?UG1ZMDl1eFp5VktaRXE3UEl0Yks5dThDQ2ZWRWtzSWN2cDAxR2JRYUU1Z2Jn?=
 =?utf-8?B?N2RvZ0VzdU5LOHBMQXZnYjNBRTk0WnE5WnJlb0tFdzBWV2VEeHdNMW50Wmd3?=
 =?utf-8?B?Myt6WjIvSGNmUE8rajVFaTV1OWJ1UWlNZUVLdEdNSmE4aGFTQUxnNGVQS3p4?=
 =?utf-8?B?enFOdTQ2SGhmbzJuSXd4aHdaOXhJNHdmQndGRXRoL0ZYMVExZm1pVHg3RGp3?=
 =?utf-8?B?YUhXVmNqeWhhVjV4WUVsWkVRMk5LMzd0Y00vNDJ4Mzc5aCsrRnM1aXQrRmd1?=
 =?utf-8?B?V1FZM2s4SitJWXE0WXRrTTRWYUhvUGlCeU11alZjZHJQd1lHYzB4aEQ5cEFo?=
 =?utf-8?B?R0x4eEZsU0FxRENPSVk3cE5qQzhFazVrSHoydTB4cHhCT3BOKytKU3ZhT0ta?=
 =?utf-8?B?WEJ6MFJPZkhJUVpVZ3JjeWhLTE1JNjdrdmVYS2pZcG01cWRqeW14dTJ3cGJW?=
 =?utf-8?B?aUNFc3hOUzVBMEhTUThpUGpYc2gyK2YxbWNhVWdhZDE2ZER2OFZlbDVwWDlV?=
 =?utf-8?B?RDkzdWVqMHpGdFYxUU9tYk5GaTF1ZUFNOGF3cG9DaDU3WjBweGhDaTF6T1Br?=
 =?utf-8?B?OGltWHRBUWY4NGFHaUdNeVVSKzZxd2Q4M2dpL1M1eENpcmlwK1Y0dVZCdFNU?=
 =?utf-8?B?a3NrMkdIL1hBZnZDNlpIOU9UVjhIQlM4Nlk1VUVCSWhCc2JFT091ZmUxeW4y?=
 =?utf-8?B?d1VzaGdNcVZJTHg3bS9CNGFXcWJWeStPZ1J5aUJjUWRDRTA2UDBoMUd1UmxX?=
 =?utf-8?B?WVZWbzdtOWQ0NXVRbGg2ZExCVERHbTROSUhyTWZQNldnT0pLM2J0bHBzYkxz?=
 =?utf-8?B?UENjZmpkd2c1SmtkVzhLbmhnYmVZaThjOUtoamhsQU9SRWluWWRCY1dERjlL?=
 =?utf-8?B?bjQ0OWVkNVJOVldXdW4xNzBNSVY0WDRkdDloVFRWamFHWU9WN29lVGNRV2Nk?=
 =?utf-8?B?aHNTaDV4Y1V0cFdWUXR5YTJEbzBsSEE0TU42UVJ4dUE5UG5rQTMwZ3I2ZlEx?=
 =?utf-8?B?ZWE0TTFnbkVDUWkzdHU4KzF4WURwNzBFVGZ1RERYNkMzV29ZditDMUpwdy9x?=
 =?utf-8?B?cjJ6NXBuY1VGem9GL0p3SUJaY2pqWE9MU09EV1hsOTJ0cEdUWUQxNWpIRmVS?=
 =?utf-8?B?YlBkbkd4Z2ZqL1pURmcwaHg1M3N2OStqd3d3eHF1eGtNcHZqdVVmcU1qK0J3?=
 =?utf-8?B?WnprZDlOTHVrQTlic2RKeCtaa0VXRFhPSUxlMVYzT0phNStxbGk4d3R0T2xR?=
 =?utf-8?B?ZlJwV3IzQnlSNnBsSENUY1F4RDZpY0ZuZDM3N05STUc3LzlkZEJ0R2l5czJn?=
 =?utf-8?B?MEl2cDVDTDdVSEdsakVTV2lqa0szcmFvZEQwZmdRN2swNUJhSGpvejA4dlVV?=
 =?utf-8?B?RzdOSUNYK3RZWG56aUk0aFp3UzNrWUNhOER2OFhrM2NQbWFsaExVeS9DK1RW?=
 =?utf-8?B?Uk1qSWxGN3NraEM4U2s3QnZXbm9hQnJyY2tFc0dMbE5oSkg3aFVMY3VNMzNR?=
 =?utf-8?B?WlplcHdKTlBEOE5iem5ZSWtBSEROQ1I2WE0xUlFtU240K2FaeitLVk85SmIy?=
 =?utf-8?B?RlM4M0Q2TlhsSUdkYzZVdGk0bTNuQlBoWnBFbmhrb0FzZEdYaFdZckx6VGUv?=
 =?utf-8?B?R2xCKzV2RWdSQzdmZ2huQllyTldHcVdMdXJBTmNZZVhDR3MzOHBNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AfFLCApJS1ngJ6zqVRWYSuutq8b0aq2/nsXCt6mc8WW+cghI/+bGlFaoOqj3L432lRSgPy9yxbSQHfI3UhjjtHX/gsFpYY1vr/GE8KCiViE7No8uqSfkzR7EHagIhOLeTz83V7eUdOvAFvrnBVbFmGDPgKix5mtipHOLaYQ2L45GDrY6mquz3c1H++VraF9M1Zlke2IKSNvoHH5c1iO1uOWVMLrTELplGcKnaWAM3Ti5b85wUCqqPooSxFl0TatQftIZd7Db9KYqTBtHdZICuDFbpm65FiYCGTNU5PgIi6pArfZ2koO48Q8BY3vxmSVVK2IdxB3yk+p8HsxErrn5JQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e1762-07e8-4ac7-7352-08def39baee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 09:18:31.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOxgNV7eZ2bQD0PiXfMdu/YbAjag/of5FpRon+a8NjhemKmoUqJg4ys6zSHTtFbsyUHVbzVLo75jkLtGIz/UDkQrICBtsoA3vC2Znya2auY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com

RnJvbTogSmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgNSwgMjAyNiA0OjI3IEFNDQoNCj5UaGUgWC1Qb3dlcnMgQUMyMDAg
aXMgYSBtaXhlZC1zaWduYWwgY29tcGFuaW9uIElDIHdpdGggYSBwYWdlZCByZWdpc3Rlcg0KPm1h
cCBhY2Nlc3NlZCBvdmVyIEkyQy4NCj4NCj5FbmFibGUgdGhlIHBhY2thZ2Ugc3VwcGxpZXMgYW5k
IGlucHV0IGNsb2NrLCBwcmV2ZW50IHRoZSBjbG9jayByYXRlIGZyb20NCj5jaGFuZ2luZywgYW5k
IGFwcGx5IHRoZSB2ZW5kb3Igc2V0dGxpbmcgZGVsYXlzIGFyb3VuZCBjb21tb24gcmVzZXQuDQo+
SW5pdGlhbGl6ZSB0aGUgcGFnZWQgcmVnbWFwLCByZXBvcnQgdGhlIGNoaXAgYW5kIHBhY2thZ2Ug
cmV2aXNpb24sIGFuZA0KPmluc3RhbnRpYXRlIHRoZSBFdGhlcm5ldCBQSFkgY29udHJvbCBjaGls
ZCB3aGVuIGZpcm13YXJlIGRlc2NyaWJlcyBpdC4NCj4NCj5DYWNoZSBvbmx5IHRoZSBjb21tb24g
cGFnZSBzZWxlY3Rvci4gSW5kaXZpZHVhbCBmdW5jdGlvbiByZXNldHMgY2FuDQo+aW52YWxpZGF0
ZSBvdGhlciByZWdpc3RlcnMgd2l0aG91dCByZWdtYXAncyBrbm93bGVkZ2UsIHNvIGFsbCBmdW5j
dGlvbmFsDQo+cmVnaXN0ZXJzIHJlbWFpbiB2b2xhdGlsZS4NCj4NCj5UaGUgQUMyMDAgYW5kIGl0
cyBjaGlsZHJlbiBjYW5ub3QgaW5pdGlhdGUgRE1BLiBNYXJrIHRoZSBwYXJlbnQgYXMNCj5ETUEt
aW5jYXBhYmxlIGJlZm9yZSBhZGRpbmcgdGhlIGNoaWxkLiBSZWdpc3RlciB0aGUgY29tbW9uLXJl
c2V0IGFjdGlvbg0KPmJlZm9yZSB0aGUgTUZEIGNoaWxkIHNvIG1hbmFnZWQgdGVhcmRvd24gcmVt
b3ZlcyB0aGUgY2hpbGQgYmVmb3JlDQo+cmVzZXR0aW5nIGl0cyBwYXJlbnQsIGFuZCBhbHNvIHJl
c2V0IHRoZSBjaGlwIGR1cmluZyBzeXN0ZW0gc2h1dGRvd24uDQo+DQo+U2lnbmVkLW9mZi1ieTog
SmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+DQo+LS0tDQo+IGRyaXZl
cnMvbWZkL0tjb25maWcgIHwgIDEyICsrKw0KPiBkcml2ZXJzL21mZC9NYWtlZmlsZSB8ICAgMSAr
DQo+IGRyaXZlcnMvbWZkL2FjMjAwLmMgIHwgMjA3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAzIGZpbGVzIGNoYW5nZWQsIDIyMCBpbnNlcnRp
b25zKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL0tjb25maWcgYi9kcml2ZXJzL21m
ZC9LY29uZmlnDQo+aW5kZXggNzYzY2U2YTM0NzgyLi4zMzYwYzliODZiZTggMTAwNjQ0DQo+LS0t
IGEvZHJpdmVycy9tZmQvS2NvbmZpZw0KPisrKyBiL2RyaXZlcnMvbWZkL0tjb25maWcNCj5AQCAt
MjA1LDYgKzIwNSwxOCBAQCBjb25maWcgTUZEX0FDMTAwDQo+IAkgIFRoaXMgZHJpdmVyIGluY2x1
ZGUgb25seSB0aGUgY29yZSBBUElzLiBZb3UgaGF2ZSB0byBzZWxlY3QgaW5kaXZpZHVhbA0KPiAJ
ICBjb21wb25lbnRzIGxpa2UgY29kZWNzIG9yIFJUQyB1bmRlciB0aGUgY29ycmVzcG9uZGluZyBt
ZW51cy4NCj4gDQo+K2NvbmZpZyBNRkRfQUMyMDANCj4rCXRyaXN0YXRlICJYLVBvd2VycyBBQzIw
MCINCj4rCWRlcGVuZHMgb24gSTJDDQo+KwlkZXBlbmRzIG9uIE9GDQo+KwlzZWxlY3QgTUZEX0NP
UkUNCj4rCXNlbGVjdCBSRUdNQVBfSTJDDQo+KwloZWxwDQo+KwkgIFN1cHBvcnQgZm9yIHRoZSBY
LVBvd2VycyBBQzIwMCBtaXhlZC1zaWduYWwgY29tcGFuaW9uIElDLiBUaGUgQUMyMDANCj4rCSAg
Y29udGFpbnMgYXVkaW8sIHZpZGVvLCBSVEMgYW5kIEZhc3QgRXRoZXJuZXQgUEhZIGZ1bmN0aW9u
cyBhbmQgaXMNCj4rCSAgY28tcGFja2FnZWQgd2l0aCBzb21lIEFsbHdpbm5lciBINiBhbmQgSDYx
NiBTb0NzLiBUaGlzIGRyaXZlciBwcm92aWRlcw0KPisJICB0aGUgc2hhcmVkIHJlZ2lzdGVyIGFj
Y2VzcyB1c2VkIGJ5IHRoZSBpbmRpdmlkdWFsIGZ1bmN0aW9uIGRyaXZlcnMuDQo+Kw0KPiBjb25m
aWcgTUZEX0FYUDIwWA0KPiAJdHJpc3RhdGUNCj4gCXNlbGVjdCBNRkRfQ09SRQ0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21mZC9NYWtlZmlsZSBiL2RyaXZlcnMvbWZkL01ha2VmaWxlDQo+aW5kZXgg
ZGQ0YmI3ZTc3YzMzLi44OTBlNzZhOWFkMDAgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9tZmQvTWFr
ZWZpbGUNCj4rKysgYi9kcml2ZXJzL21mZC9NYWtlZmlsZQ0KPkBAIC0xNTAsNiArMTUwLDcgQEAg
b2JqLSQoQ09ORklHX01GRF9EQTkwNTJfU1BJKQkrPSBkYTkwNTItc3BpLm8NCj4gb2JqLSQoQ09O
RklHX01GRF9EQTkwNTJfSTJDKQkrPSBkYTkwNTItaTJjLm8NCj4gDQo+IG9iai0kKENPTkZJR19N
RkRfQUMxMDApCQkrPSBhYzEwMC5vDQo+K29iai0kKENPTkZJR19NRkRfQUMyMDApCQkrPSBhYzIw
MC5vDQo+IG9iai0kKENPTkZJR19NRkRfQVhQMjBYKQkrPSBheHAyMHgubw0KPiBvYmotJChDT05G
SUdfTUZEX0FYUDIwWF9JMkMpCSs9IGF4cDIweC1pMmMubw0KPiBvYmotJChDT05GSUdfTUZEX0FY
UDIwWF9SU0IpCSs9IGF4cDIweC1yc2Iubw0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9hYzIw
MC5jIGIvZHJpdmVycy9tZmQvYWMyMDAuYw0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQoNCi4uLg0K
DQo+K3N0YXRpYyB2b2lkIGFjMjAwX2Rpc2FibGVfYWN0aW9uKHZvaWQgKmRhdGEpDQo+K3sNCj4r
CWFjMjAwX2Rpc2FibGUoZGF0YSk7DQo+K30NCg0KSGkgSmFtZXMNCg0KYW55IHBhcnRpY3VsYXIg
cmVhc29uIHdoeSBhYzIwMF9kaXNhYmxlIGNhbm5vdCBiZSBjYWxsZWQgZGlyZWNybHk/DQpjb3Vs
ZG4ndCBmaW5kIGFueXdoZXJlIGV4dGVuZGluZyB0aGlzIGxhdGVyIGluIHRoZSBzZXJpZXMNCg0K
PisNCj4rc3RhdGljIGludCBhYzIwMF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0K
Pit7DQo+KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmY2xpZW50LT5kZXY7DQo+KwlzdHJ1Y3QgZGV2
aWNlX25vZGUgKmVwaHlfbm9kZSBfX2ZyZWUoZGV2aWNlX25vZGUpID0gTlVMTDsNCj4rCXN0cnVj
dCBhYzIwMCAqYWMyMDA7DQo+KwlzdHJ1Y3QgY2xrICpjbGs7DQo+Kwl1bnNpZ25lZCBpbnQgdmVy
c2lvbjsNCj4rCWludCByZXQ7DQoNCmkgYmVsaWV2ZSBpdCB3b3VsZCBiZSBuaWNlIHRvIHN0aWNr
IHRvIFJDVA0KZXNwZWNpYWxseSBmb3IgbmV0ZGV2IHRhcmdldGVkIHBhY3RoZXMgDQoNCj4rDQo+
KwlhYzIwMCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqYWMyMDApLCBHRlBfS0VSTkVMKTsN
Cj4rCWlmICghYWMyMDApDQo+KwkJcmV0dXJuIC1FTk9NRU07DQo+Kw0KPisJcmV0ID0gZGV2bV9y
ZWd1bGF0b3JfYnVsa19nZXRfZW5hYmxlKGRldiwgQVJSQVlfU0laRShhYzIwMF9zdXBwbGllcyks
DQo+KwkJCQkJICAgICBhYzIwMF9zdXBwbGllcyk7DQo+KwlpZiAocmV0KQ0KPisJCXJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGVuYWJsZSBzdXBwbGllc1xuIik7DQo+
Kw0KPisJY2xrID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoZGV2LCBOVUxMKTsNCj4rCWlmIChJU19F
UlIoY2xrKSkNCj4rCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoY2xrKSwNCj4r
CQkJCSAgICAgImZhaWxlZCB0byBlbmFibGUgaW5wdXQgY2xvY2tcbiIpOw0KPisNCj4rCXJldCA9
IGRldm1fY2xrX3JhdGVfZXhjbHVzaXZlX2dldChkZXYsIGNsayk7DQo+KwlpZiAocmV0KQ0KPisJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGxvY2sgY2xvY2sgcmF0
ZVxuIik7DQo+Kw0KPisJYWMyMDAtPnJlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRfaTJjKGNsaWVu
dCwgJmFjMjAwX3JlZ21hcF9jb25maWcpOw0KPisJaWYgKElTX0VSUihhYzIwMC0+cmVnbWFwKSkN
Cj4rCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoYWMyMDAtPnJlZ21hcCksDQo+
KwkJCQkgICAgICJmYWlsZWQgdG8gaW5pdGlhbGl6ZSByZWdtYXBcbiIpOw0KPisNCj4rCWkyY19z
ZXRfY2xpZW50ZGF0YShjbGllbnQsIGFjMjAwKTsNCj4rDQo+KwkvKg0KPisJICogTm8gbWluaW11
bSBkZWxheSBpcyBkb2N1bWVudGVkLiBNYXRjaCB0aGUgdmVuZG9yIGRyaXZlcidzIDQwIG1zIGRl
bGF5DQo+KwkgKiBiZWZvcmUgaXRzIGZpcnN0IEFDMjAwIHJlZ2lzdGVyIGFjY2VzcyBhZnRlciBl
bmFibGluZyB0aGUgaW5wdXQgY2xvY2suDQo+KwkgKi8NCj4rCW1zbGVlcCg0MCk7DQo+Kw0KPisJ
cmV0ID0gcmVnbWFwX3JlYWQoYWMyMDAtPnJlZ21hcCwgQUMyMDBfU1lTX1ZFUlNJT05fUkVHLCAm
dmVyc2lvbik7DQo+KwlpZiAocmV0KQ0KPisJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LA0KPisJCQkJICAgICAiZmFpbGVkIHRvIHJlYWQgY2hpcCB2ZXJzaW9uXG4iKTsNCj4rDQo+Kwlk
ZXZfaW5mbyhkZXYsICJBQzIwMCByZXZpc2lvbiAlI2x4IGluIHBhY2thZ2UgJWx1XG4iLA0KPisJ
CSBGSUVMRF9HRVQoQUMyMDBfU1lTX1ZFUlNJT05fQ0hJUF9NQVNLLCB2ZXJzaW9uKSwNCj4rCQkg
RklFTERfR0VUKEFDMjAwX1NZU19WRVJTSU9OX1BBQ0tBR0VfTUFTSywgdmVyc2lvbikpOw0KPisN
Cj4rCS8qIFJ1biBhZnRlciB0aGUgTUZEIGNoaWxkcmVuIGhhdmUgYmVlbiByZW1vdmVkLiAqLw0K
PisJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgYWMyMDBfZGlzYWJsZV9hY3Rp
b24sIGFjMjAwKTsNCj4rCWlmIChyZXQpDQo+KwkJcmV0dXJuIHJldDsNCj4rDQo+KwlyZXQgPSBy
ZWdtYXBfd3JpdGUoYWMyMDAtPnJlZ21hcCwgQUMyMDBfU1lTX0NPTlRST0xfUkVHLCAwKTsNCj4r
CWlmIChyZXQpDQo+KwkJcmV0dXJuIHJldDsNCj4rDQo+KwlyZXQgPSByZWdtYXBfd3JpdGUoYWMy
MDAtPnJlZ21hcCwgQUMyMDBfU1lTX0NPTlRST0xfUkVHLA0KPisJCQkgICBBQzIwMF9TWVNfQ09O
VFJPTF9DSElQX1JFU0VUX0RFQVNTRVJUKTsNCj4rCWlmIChyZXQpDQo+KwkJcmV0dXJuIHJldDsN
Cj4rDQo+KwkvKiBNYXRjaCB0aGUgc2V0dGxpbmcgaW50ZXJ2YWwgdXNlZCBieSB0aGUgdmVuZG9y
IGluaXRpYWxpemF0aW9uLiAqLw0KPisJdXNsZWVwX3JhbmdlKDEwMDAsIDIwMDApOw0KPisNCj4r
CS8qIE5laXRoZXIgdGhlIEFDMjAwIG5vciBpdHMgY2hpbGQgZGV2aWNlcyBjYW4gcGVyZm9ybSBE
TUEuICovDQo+KwlkZXYtPmNvaGVyZW50X2RtYV9tYXNrID0gMDsNCj4rCWRldi0+ZG1hX21hc2sg
PSAmZGV2LT5jb2hlcmVudF9kbWFfbWFzazsNCj4rCWVwaHlfbm9kZSA9IG9mX2dldF9jb21wYXRp
YmxlX2NoaWxkKGRldi0+b2Zfbm9kZSwNCj4rCQkJCQkgICAgIngtcG93ZXJzLGFjMjAwLWVwaHkt
Y3RsIik7DQo+KwlpZiAoIWVwaHlfbm9kZSkNCj4rCQlyZXR1cm4gMDsNCj4rDQo+KwlyZXQgPSBk
ZXZtX21mZF9hZGRfZGV2aWNlcyhkZXYsIFBMQVRGT1JNX0RFVklEX05PTkUsIGFjMjAwX2NlbGxz
LA0KPisJCQkJICAgQVJSQVlfU0laRShhYzIwMF9jZWxscyksIE5VTEwsIDAsIE5VTEwpOw0KPisJ
aWYgKHJldCkNCj4rCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBh
ZGQgTUZEIGRldmljZXNcbiIpOw0KPisNCj4rCXJldHVybiAwOw0KPit9DQo+Kw0KPitzdGF0aWMg
dm9pZCBhYzIwMF9zaHV0ZG93bihzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPit7DQo+Kwlz
dHJ1Y3QgYWMyMDAgKmFjMjAwID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7DQo+Kw0KPisJ
YWMyMDBfZGlzYWJsZShhYzIwMCk7DQo+K30NCj4rDQo+K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGFjMjAwX29mX21hdGNoW10gPSB7DQo+Kwl7IC5jb21wYXRpYmxlID0gIngtcG93
ZXJzLGFjMjAwIiB9LA0KPisJeyB9DQo+K307DQo+K01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFj
MjAwX29mX21hdGNoKTsNCj4rDQo+K3N0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBh
YzIwMF9pMmNfaWRzW10gPSB7DQo+Kwl7ICJhYzIwMCIgfSwNCj4rCXsgfQ0KPit9Ow0KPitNT0RV
TEVfREVWSUNFX1RBQkxFKGkyYywgYWMyMDBfaTJjX2lkcyk7DQo+Kw0KPitzdGF0aWMgc3RydWN0
IGkyY19kcml2ZXIgYWMyMDBfZHJpdmVyID0gew0KPisJLmRyaXZlciA9IHsNCj4rCQkubmFtZSA9
ICJhYzIwMCIsDQo+KwkJLm9mX21hdGNoX3RhYmxlID0gYWMyMDBfb2ZfbWF0Y2gsDQo+Kwl9LA0K
PisJLnByb2JlID0gYWMyMDBfcHJvYmUsDQo+Kwkuc2h1dGRvd24gPSBhYzIwMF9zaHV0ZG93biwN
Cj4rCS5pZF90YWJsZSA9IGFjMjAwX2kyY19pZHMsDQo+K307DQo+K21vZHVsZV9pMmNfZHJpdmVy
KGFjMjAwX2RyaXZlcik7DQo+Kw0KPitNT0RVTEVfQVVUSE9SKCJKYW1lcyBIaWxsaWFyZCA8amFt
ZXMuaGlsbGlhcmQxQGdtYWlsLmNvbT4iKTsNCj4rTU9EVUxFX0RFU0NSSVBUSU9OKCJYLVBvd2Vy
cyBBQzIwMCBNRkQgY29yZSBkcml2ZXIiKTsNCj4rTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPg0K
Pi0tIA0KPjIuNTMuMA0KDQoNCg==
