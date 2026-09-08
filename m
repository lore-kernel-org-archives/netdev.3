Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB84C9001
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890560; cv=fail; b=TpA2tLeTZrBjNGZ7U0Y6bRk4QLmUW6gsCmhgxjssVTC4nAtOaoc5O2W95C4YuSqDodrb6Nyz3KpWFLoDOwS7CQcgibVXNTQz0ZKhWkj2HRjKiiWMMhPImICXjqSSonfpOC0MFf6+vMVZ3GjLph6vl7U9xenhvhriYb3H3Pzj/1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890560; c=relaxed/simple;
	bh=jOcUyPt9PnSj/gGIwM3og5wVvCwGGDrr4AmWHq4gKK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXje9Zow5Hc5iNBCC54nPsdcdpl0Ipr5KQvVvjKsuzTuh79DUrsOs0cI+OwphmZHrJtFfxDj8MgQ80QpIVPOw4j6KZPpXkg/vdfbTbg7nT757YPjWTl8RVZfkLHIn2IV1RF7SX86tpw7D7bgCnYOp7ff0j8psbDrkhpP3AU+SjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igOwPHTh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igOwPHTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788890558; x=1820426558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jOcUyPt9PnSj/gGIwM3og5wVvCwGGDrr4AmWHq4gKK4=;
  b=igOwPHThj0tdEzMQ/nHNiKc/062twKU2+TZ1cv2bTleYTdMUSLY8D1ts
   yKIHAIfLJR41Wl8jC00CgWjmLDBCvdAn/3QhyPUboh0CxrcqneeEokGl2
   JBAfgQk+xDJqK2svZVubThnSi4cjtbTVUltce4IDZejX19QpiRGvfRR8M
   +xW3mi0X75fheWpugZL2e5AZ8ZSb2fNWKzgteOvoTToBupErIJlJr0dRU
   hgfT9iu47rp2mUuEZRDxNi850FcVJbpDXQRMVUHpdP9aPp6YZYkNnBs9z
   BZs6g8GFBAqtbUrx0+dduni80ey1fdL5X82EK+X2+vnm5sZ//HohqPEv6
   A==;
X-CSE-ConnectionGUID: IT9oD6jFSmKM1w8R6FHkPA==
X-CSE-MsgGUID: ekleBRmmSoSeBm5tdKFtEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106819514"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106819514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:02:38 -0700
X-CSE-ConnectionGUID: L91Inc1eRV6ubQ4VnUm0mg==
X-CSE-MsgGUID: XumunlFYQOyhNYy4a3bjaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="271052399"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:02:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:02:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:02:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcDM0rA/dfXko4TdqNoKdL3/8R/3r5mLnHNmhExIxzUyvHU1zwqEpewNg4ihqq//2vIDf196sl160ASQRGI+QM3U+eWbiy+x2KohGp2zrfHSy7Yqzy1L+noLTyRlp4LhidSjYtW4hwk0VECvitrzHFboHpCLE1QRVoXtukk5AeVg5EXGXAetqaZ9TGjsR0s1zdQ4z883w6NWTAmFZGPr20JWOUTJEucvnqxxOMVTf5dS5jRfWr1aKbbU3FIKInj6WxBjicV5VF75UVyMN32ErKbPEhHUbq3+lkcnc808gp5h8ze4ykPifnuAtSWS5a0Uo5tTPhgMyDj5WL62RWUyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOcUyPt9PnSj/gGIwM3og5wVvCwGGDrr4AmWHq4gKK4=;
 b=wzXSkCjzwoS/3AYKygeQr+lB+MaZSrbzb/rAFTrSpryx7n6ll5hVmVWdPAV3lTeoH1Jmzbk5nMRvnwj1z/iFMKkjeB7bSJNF/YC1ZPtbkmCfPyDgIi4BZOFAlFsmZtNQjR7Vi3bMfaQs35Lkv6246bFCzPEYTpO+V9zd6SB5Tw/KtrW6NJ17u+BHLiafPM1p1/9MUGA9mN9IZU4N4c+iPOPlt3M9yvj4Myyz/1QRECjZ8SsXTKu6Yo4osOcHEDP1SQtREo0+A9lL+Uxot+SyV8Xp+62R32kh60C/Vhi050uiMwePR77RFFWHnEhjvG6vz7D8AIHH+pXjkGfWsKpwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:02:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:02:23 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>
Subject: RE: [PATCH iwl-net v2 02/14] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Topic: [PATCH iwl-net v2 02/14] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Index: AQHdNOTRyuSZg7xRQUSDR43ufQ1webbFDnPQ
Date: Tue, 8 Sep 2026 18:02:23 +0000
Message-ID: <LV1PR11MB8790F089FFAFFB56D9C5A70A90B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-2-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-2-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: fc19cc16-45a1-42a3-671f-08df0dd3557a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|22082099003|11063799006|4143699003|56012099006|18002099003;
x-microsoft-antispam-message-info: pPBoFSHPw0vEtYZGr1TgnhOQfb70mlGp2ZmdLt0GCOC/6f001nwbRmQ5eWwDtBdKUIan2xTRqKuw9y8vkvc8HwzgxpOc0QhFxHEAxsr0ynJoAm8aYTFkvPRX2+YDEYhBNbljUTUDsx5NhTncYSzk5tLZo1vvd8MpWDMPNdwgaKa7cg4dKVReZRHPNhaFlpEIqYm4aVYZVU/YkgsVknvOmI9Vs984OT4/3XcZaF6id8VrqMFQ2IbacB7/KDUHC1kUFtN9h5jFcxR76GZ6A/lPEhFSO7mW7oxNxXKn25RvMZTQOd7YemAqel6l1tMA1D9hTA/I55H0FRhdLPlhwT5OV2oucHWfUuQTrPhRfC69spkdtkU7o80Zxs54rB+qZPS6lPNDpaAk9xQhg9HzMmgSBazZQmi5oEj3vDic33xh8fuRLN1nqUdz5ge43daxe9G3B6i/eYSM7K0eunN4yZhXwyYWJATTVbGnmwHFwGZwi9ssN8c8MpVGP9Xc7i49zkHPV4kMiErO0pxKOEapqXK3mkIH3rNuM1f25f6YDsS+buGnH/HEbHkMPb0NspjcxfC4vY//cOykhq8Ism9AbdFpx7g7U0P8i7qed+xzYrMy+8fBLbwuCnjIwOP5ct0Ou2eUq8UULC61kmMU0BwNPCmbukMnDFSp9mC00B4DBw9K1n8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUs2M2hnMDdUdG5XcksxdUxBNDI2ZWFOZ3hTQXpVN1F4QXVIcDl1M1BZV3dL?=
 =?utf-8?B?SXIzR1BTK0xLa1RKcndMdjZ0WjIvTjFVOFdXaFVtaXRXNG44TGdYSEZtcG1H?=
 =?utf-8?B?NXR3bGtKZ0dWZnRPdUpaUjhmR0R0bHhBZEtZd1BpWmF2K1Y4SEw3SHdFQWdv?=
 =?utf-8?B?c0MzeFY4SFcrNWtzaXJDU2VXUnQxQmpibVJvSEI2RGlac3luR0ZOdjFEWHNj?=
 =?utf-8?B?WWt0c1RXR1BtaGl6QW9OMVBwV0NWbFF0cHJLc0pWdVhJTTltTnlVMFJuWWNG?=
 =?utf-8?B?SFZKMmx0RXlDR1N6QXBlS1BocWN0d0RBeGpaMDMyT1ZlZ3V4eWZXaCtSVmcy?=
 =?utf-8?B?NHJGOEZYT1hUbldZaE5HTzVjZ3JRalNQNGtHdnRJZHJhSFo2OGY0L2hPNVcv?=
 =?utf-8?B?RHRnVnIyc2R5djlpckUyMFBtaEYyOVNqblhWbENNSGtoSS9LdjlpWE9TVEhG?=
 =?utf-8?B?Z09KTG5iUjhvMnVMOHZjait0dUhMYzBRK1FZZE1YSDBkcFYxRGltTCtRRHcz?=
 =?utf-8?B?MGo4d3dVcGJrWG1sTDF4QXNGOXZnUVlnQWhLMG1vZmlHK2dtTGdaMHBGSmE2?=
 =?utf-8?B?UXpROTR5SHJ4M1pIRWl0ZWlJNlpveW5lUHI1aG5mVXpSS1dwYkpNUGRsM1Zi?=
 =?utf-8?B?UUVhaWMzZ2JnRVovUUNtZnZaRHFSUWEyeGlkcHdHeTZlQXZEWGx6MU9ZTDFN?=
 =?utf-8?B?dXBXRGJnOFpHV2E4c0RTNTkrVVZPR1NPU0NCQ1RVYTQrTzU2Q3ZOYWZueUov?=
 =?utf-8?B?MlBVQkVkV1hreTFYd2k5NzQ1ZTk0VXpibFkyREZpa3R6YzRBb1BaekhQZ1ha?=
 =?utf-8?B?SWJhZ095aEQ1ZlNadmZ3U2dOR3pvQnhYcFFMQkIwTytIR0FGSVV6QjBjZE5o?=
 =?utf-8?B?SG8vdDFLODJWTktoTHAzd0kzenpUYmxxUTk0UFZNSU9kdm9vd284M0EyYWJo?=
 =?utf-8?B?NW1yV3hwQi8vcG0xdkJieU8zZ2hoMDhHL29CZ3l3eGhJL3BDdSsyVkkxNGsw?=
 =?utf-8?B?N0NHOWI4dmw1cC9tTHRhOFMwenlScVBCRXlIWGREUU54bWxwdHBWcHpteXJW?=
 =?utf-8?B?MFo3RG5rdm1uYjYzMFBVUXhwb05jWWdNUysvdmNMTytsSXIyV0xMNm84VWc4?=
 =?utf-8?B?UUR0Wm81U0tKaFAxZjg2R0Vlbng5dmI1a1hGbXNQWFF1MWFNaEVzN1B5UXA1?=
 =?utf-8?B?d1FmaWtINStEaVA5SWEvSWVibFVLbHlZQ3pCQlNRbXo1WGVoWnNVOTkyTkVw?=
 =?utf-8?B?NWZiU1hoMGJ1YnhrTXUrUE5ZTGdtWnBoL0FPdllaUkJQWHZDRWdWaFlEbTJm?=
 =?utf-8?B?NlhCSTlWS1JXMGhoTkV6M1FUcHNxam1iSHhoTHBua0JtUmd1NWtlV3VRUkdG?=
 =?utf-8?B?akFxVnNQZ3JXSU5DNUlXRWU2ZGhuS05uRXlSMWdsQTl4aUpwd3gxMWlvNjNw?=
 =?utf-8?B?TmJCSUZnZXhRZ3NYNkh4RFNUS2VMRlVQODM1SVFvdG9NY1RUNUtFTy9qT0NU?=
 =?utf-8?B?WWxYR1l0dE9QeEZLUEltWGYxRWdUR2Y0S2pmaW90NXpCTDVyMnVMR2JXb0pm?=
 =?utf-8?B?cVhTdUtqbU9wZU05TldZZ2Z6S1JLSTRPdlowZDFmR3p1YS9tUHVVYjAxN0lx?=
 =?utf-8?B?K01IODFSajVySWxyYnlEUUM3cGRHRVNCTURqbWpTT0VXUGJlVmw2Wk5KMmRi?=
 =?utf-8?B?dXlITitXYW5xN095Uk9RVzgzdlpDZHZxQTZwMm1BTjlWNTYzYkNwNG4xd2NB?=
 =?utf-8?B?Qlo2RnNzSjBjc3V4MThBa01qMy9nUGs4QVU5UFJ4ZzFRdTRJZFFlbU1VTEtp?=
 =?utf-8?B?RnQ5bHAzajJTZEl6R1NJRmtPQkg3Z0x6cTkyMTY0YWZzdm41QnJ3L1pScFB0?=
 =?utf-8?B?TUUwMXhrSDNwRTllSkxtaFUrczB3aUVMZGRJMjFtdUhROVpRNVY0RFphVG44?=
 =?utf-8?B?K0VVMjY5TGFrc1dpamd1TUtvckxVeVd1MUl4NFphS1E1VFhoM1Z0czRDNDYv?=
 =?utf-8?B?SHpxd295T01LYzl6SnJiNUV3OUZFbmp0cnVuZFcweWtpeGprYzM0NHRDelgw?=
 =?utf-8?B?Nlhta29YeEZod0dNd0QxOG9MejViM2ZON3ZDYkNwdFFycUdnNVBtWGxMaWM3?=
 =?utf-8?B?MTNmdFZsYy95cXVhN3kvT2hNa1NTNG56M2hjVzZJQ3E1Tm1UWnhWUzNIeDhj?=
 =?utf-8?B?WC9lSzlHOUdpajFCTEhOd3hHRks5RCtRWjFjRW4rNkdRN2djRGpDL2hnM0JU?=
 =?utf-8?B?d1lkeXV0cXl6dlN5Y1J6dXdlTCsvYkJOMGxmSEZnWEY0VkVHdnBRWFpOZ2FO?=
 =?utf-8?B?Zk1qWEhVTnVUK2kwNXYwWkR3aHFpOVc1cnZtMWxTeXdoWjFQVmM0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: idB/Hi82Rua5wXdCObia4vsUntAv2/Do0TsNAA6KDgWiCy7BvPYnxKFe/R2anrOmWvLvN0FvLAfuX5O2W5spZ1v2v4z22sB6leDv320iJFbVIGKg+6x8w6wWBHXhppyYQzgTMqBQjbDrKjp4y8zRusdWTzEhQ10MPV5a1OtqAQdUBXUGKZkChbE7YQFd96CAlWMF2gc2PigPg2mM02nPasGE+kNdL4CJEgcPEVZ8qkLI3rfGR96LTrpwJIZYZPXfMi9MHwz8Sv4vFyZQXF/3nd7UpOO2XNUTcSsd3ob/gg23JTpW4aIyEhX7gpH/RC/aVdW6w9BNGr3FH0WloVfF/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc19cc16-45a1-42a3-671f-08df0dd3557a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:02:23.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlrXRh//bD4IPKJ3BIfsYrWgUnbWztjt9hzx3nxkrysr6G2z8SPseTM2/P+Qxw4hjvqpPMDrXQOAEq7GIpQww8jLQqXg3kVuINbG5rh7gfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjUzIFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggaXdsLW5ldCB2MiAwMi8xNF0gaWNlOiBmaXggcmVtb3ZhbCBvZiBQVFAgdGltZXN0YW1wIHRy
YWNrZXIgZHVyaW5nIHJlc2V0DQo+IA0KPiBDb21taXQgN2EyNWZlNWNkNWZiICgiaWNlOiBzdG9w
IGRlc3Ryb3lpbmcgYW5kIHJlaW5pdGFsaXppbmcgVHggdHJhY2tlciBkdXJpbmcgcmVzZXQiKSBp
bnRlbmRlZCB0byBtb2RpZnkgdGhlIFBUUCByZXNldCBmbG93IG9mIHRoZSBkcml2ZXIgc28gdGhh
dCBpdCBzdG9wcGVkIGNhbGxpbmcgaWNlX3B0cF9yZXNldF90eF90cmFja2VyKCkgZHVyaW5nIHRl
YXJkb3duIGFuZCBzdG9wcGVkIGNhbGxpbmcgaWNlX3B0cF9pbml0X3R4XyooKSBkdXJpbmcgcmVi
dWlsZC4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoZSBjb21taXQgb25seSByZW1vdmVkIHRoZSBj
YWxscyB0byBpY2VfcHRwX2luaXRfdHhfKigpLg0KPiBUaGlzIGZpeGVkIGEgbWVtb3J5IGxlYWsg
aW4gUEYgcmVzZXQuIEhvd2V2ZXIsIG5vdyBhIENPUkUgb3IgR0xPQkFMIHJlc2V0IHdpbGwgbGVh
dmUgdGhlIGRldmljZSB1bmFibGUgdG8gaW5pdGlhdGUgVHggdGltZXN0YW1wIHJlcXVlc3RzIGlu
ZGVmaW5pdGVseS4NCj4gDQo+IEluIHByYWN0aWNlIHRoZSBDT1JFIGFuZCBHTE9CQUwgcmVzZXRz
IHJhcmVseSBoYXBwZW4gaW4gcHJvZHVjdGlvbiBlbnZpcm9ubWVudHMsIHdoaWNoIGV4cGxhaW5z
IHdoeSB0aGlzIGhhcyBub3QgYmVlbiBjYXVnaHQgdW50aWwgbm93Lg0KPiBIb3dldmVyLCBpdCBp
cyB0cml2aWFsIHRvIHZlcmlmeSBieSB0cmlnZ2VyaW5nIHRoZSByZXNldCBmcm9tIHVzZXJzcGFj
ZSB2aWEgZXRodG9vbC4gRm9yIGljZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgd2lsbCB0cmlnZ2Vy
IGEgR0xPQkFMIHJlc2V0Og0KPiANCj4gICAkIGV0aHRvb2wgLS1yZXNldCBlbm84MzAzbnAwIGly
cS1zaGFyZWQgZG1hLXNoYXJlZCBmaWx0ZXItc2hhcmVkIFwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG9mZmxvYWQtc2hhcmVkIHJhbS1zaGFyZWQgbWFjLXNoYXJlZCBwaHktc2hh
cmVkDQo+IA0KPiBUaGlzIHdhcyBmb3VuZCBieSBTYXNoaWtvIHJldmlldyBkdXJpbmcgZmVlZGJh
Y2sgZm9yIGFuIHVucmVsYXRlZCBjaGFuZ2UuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vc2FzaGlr
by5kZXYvIy9wYXRjaHNldC8yMDI2MDgyMS1qay1lODI1Yy1taW5pbWl6ZWQtZml4ZXMtdjEtMC05
ZDA3MzFlYjQ4NTglNDBpbnRlbC5jb20/cGFydD04DQo+IEZpeGVzOiA3YTI1ZmU1Y2Q1ZmIgKCJp
Y2U6IHN0b3AgZGVzdHJveWluZyBhbmQgcmVpbml0YWxpemluZyBUeCB0cmFja2VyIGR1cmluZyBy
ZXNldCIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50
ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRw
LmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5
OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
