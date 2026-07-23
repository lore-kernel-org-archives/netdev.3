Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBE419303;
	Thu, 23 Jul 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798236; cv=fail; b=OL/L4v56kiJLGhDJua6/NB5sZhnZ1YdE1epmMYQ7wbyLoVOrIAxAH+zPFHT9NU45vFaRR5fS+s5Jw7874SNdXI5F4S3aK5K/vNQHD1N5LX3XRrOzeNXmPFoCDWPUQ3tieRkKpATOmvrttLHYNfWAE6xquDWJi3dnbh1fpdGLOAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798236; c=relaxed/simple;
	bh=NbQ121BqCfjeOumBVmIfmL2X7V6pYmRnBA+1aAQ1P2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNsxGBgvKyYgl+tSJotnkdFhlUoe58oF6QhdD+abASjTlhwc18VlKkSA/nGhhcX+Pwav33uxVEUm9nRtTcudibIsAjphHsPogKyCkysUPERcbgOJII4PBBUmLJjwPK0Mvizu4q4sk6VtuN7xel5/l0xkkCt/gkoHNpGeQEDk1NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKFRzfke; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKFRzfke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798229; x=1816334229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NbQ121BqCfjeOumBVmIfmL2X7V6pYmRnBA+1aAQ1P2w=;
  b=EKFRzfkeWgotzr0EY+KqE0NkyRa2kJdyPfZdgtY8BrubkF9LpFzNmdKb
   jMYDGCeEZlOwy+/9GxYzWsXbKLPvytMxaLHxKHw205IOigh4X87eU0vU6
   YdzUw9TZAck9Y74OInWs7qgbjJKyS3sXw52RnLmGQYz4zqQcn4//Mez32
   f6UM8Hi20VtmjaxnAk0UFTkK7BDjggOABcPEUXpZhew4Emv7UtMqdr8kU
   mwkWICX74igQEi5h8YSa5F2e9Sl5SL9a95Z7sPtwVKb5iRP0ACbUYATKq
   vCgtwd4oPyQSiM7Ywj/1Z6KCQwtla6ihQJsyLlh1mHXThbU2zlaX2UP09
   g==;
X-CSE-ConnectionGUID: cLxmm7h1RCym/xAD9Ci1Og==
X-CSE-MsgGUID: QUN1mIAJQuy0VP/W/cYmmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="72990980"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="72990980"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:17:01 -0700
X-CSE-ConnectionGUID: oMZoTRHySR+F9Hvomcnt5g==
X-CSE-MsgGUID: SnJhdX7rS/Sp1fp+DHtrvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="254006988"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:17:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:17:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:17:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:17:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vywTxTZUx1hwYLW0qMhQ9mGlhAJZJvZz8y+LdGiuRZ6fSEhfO4gF1KFFp1R9qyizd+dgXRG0ntGl3IjnYc2mBKE5UGfUIPpSCJa0fofcd37DlYEPjhGbrsPaeMjmMCEc9E75S1O+3swouHXXjFSSGD8H8jmJ5FNIRhrb8+JPxzajUSjAmMCRXTjlz59mcXxSLgRHJQN0bFX8NMfnULArDtdI0xM8dBcQgJ2tLQg8rI+WPKwGSfw9ZhWdr/uigN3Arblu1XSkcD7We0teK5YLJFdzELn4Pz0fQaL2lmVAnRhl0NhUDVYld3Ysnu5jRYhhk/xWR26XkbzElINBRhd30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbQ121BqCfjeOumBVmIfmL2X7V6pYmRnBA+1aAQ1P2w=;
 b=trOt6p9k72DvZseEQgmG6FNsPMH7cSyVlpKmIsEBuD91mXBciXTiZ1cirhFg5TApsjcIiGuei7qiW1+7rGX6gskSbBwGKZCC2zirQr7Leqp087wsm3jo2HIgyvB0BLgLbCO9R4KXS2ZQ/WM6DzHnrwLllwKUlvHuGuDF81cszl2hMuMB5kLI9vn+GWQI8xPeeGw+MgtheBwWn9txloMLyqtCN2DTuPRmOCfqD88mcCbG2GBMs/02/W+PRIobBqcHty4paUQZlsYuKaFO7AFTZqHU+0nkzP4oWzPhobeXGO92X04tL0N+Gsq4nwOxZlci7jJXhkeHuhZjqA0p/XnnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:16:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:16:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Weimin Xiong <xiongwm2026@163.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] ice: parser: use kcalloc for table
 allocation
Thread-Topic: [Intel-wired-lan] [PATCH v2] ice: parser: use kcalloc for table
 allocation
Thread-Index: AQHdGLR3tRsZIH/4XkGPvHx3g5s7sbZ61o7Q
Date: Thu, 23 Jul 2026 09:16:58 +0000
Message-ID: <IA3PR11MB8986AF2D3B2BE534E87E6762E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260716025100.118145-1-xiongwm2026@163.com>
 <6A5ED21A.2B234A.06153@m16.mail.163.com>
In-Reply-To: <6A5ED21A.2B234A.06153@m16.mail.163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 67282f82-37e0-4d42-84df-08dee89b25cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: +PhroT0HPvQ+Oo4sT0Jy0aZSY0A5qDHiyzSFxvghFv7dM6ibTZOykkGqog9D/U9BSTnLjFyqNNpRNdiNJ5zCn0K4S2EVrdpE8/WEJtEIkvZOiHay157dOTsXnodoq+eNg3BDMHP6MmF/m63h6EHDLPTea6n9OQkcZYMlaT6uZcx+8W7Ki8y0d2jIwb6NMnQvcCNVIr2uYDw+bt1cMVHLF4qa+014Nf5dev/5p4vOGh+raX41Y4x4LhLlHjQ5RawuDqemSfrJ4gxskgU0Q/o90kRwfI5E4XpVBwKBqQTxjgsGGvZ9H3EHi0vsz3m9AqcE7aFgbINtQFiB/XR/lGxQdP708XBVQLhqAwnyCBPIL+tW6CgxKNBkxSU9R3YLdYxNw06HZi2BiHE6nKm6Aznn3tfESNUwoeOMRwROc8s45r/rkRVnmXUiuNe76mAPafdQVn+Y+pWR8Ve7u2L2WYEs5OzKKrJyX3UAEp4adtFIHFCxd8we6RM+bu6KsV82Wt7eJ5JQtlbOvZi1qV7K18mTpWkS+4D6y98HVBXghOE+0rIv1CT/TXddQcFR9pbtmaMc+Ru6jR1vUUDRa4kTnpw1rcnUmbXZyF9y5nvw2oflPztVZfdRCP+132RYCXPWNA9T9Hgaew8Sro1lR45jW5S8jf4ctkM1CdPnUs/XM8J8jJXasSu5n6JRDmR+EHScu6kr8tXNM1gD5dUZDZwubFf9pgkliD5RQc8mMXIr34cCJVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TURVNDdKYnNhRDQ1UnB2OHE1czZoem0zK1ZHMDFESWFSZU5xdmRtb3k5aFNl?=
 =?utf-8?B?a09GWUdMT05CeFBXZWQzNTRQVGdxbHRuVk93dkQzV3Rwa0pONk4xWWdKNFFj?=
 =?utf-8?B?RWhLT0RwdVQ3SmZxVU4wb3gxTWN3K2RJZTBIYjhxREVsWjdOaEVQMFJ2WkpM?=
 =?utf-8?B?Z2wzYW1XVkc3c2xDOTNyUWJ5NU9WRXZsbTFkRkNsZ0xHUHdBTndaemRqcXBt?=
 =?utf-8?B?NEYrS21TQUpOK2xES2dFMFcrclk3S2diMk5tNmxXWTJZU1VMSG5JaUVFWXBS?=
 =?utf-8?B?dUMwNzdkV0VCcUxRVXN3QjhBZnoyRmdzVGtLUklLbjJKRDI2V1NGTGJlRk9k?=
 =?utf-8?B?K1gvVFMxVWpKV2EvWDdva1pQcjZDeTY5dkpCUGdVeHU3NWJOOU5FZlhRc0lw?=
 =?utf-8?B?bzZxN1JTQWRpODNNblRKUzNRNGxZSGlzc1FCNVVXanBzaDFISzVtNUJCV2tq?=
 =?utf-8?B?OWhOOWFIcEdidEtRb0dWWXFXUyt0Tzl0c0VsWE1lTm95cW5OSjFrY1F2emMv?=
 =?utf-8?B?dnBlcUYvSFI2dytKdkdVZzM4U1U5OEQ4WnpnbTZlTmVLSjV1ZllYeUVDRnVW?=
 =?utf-8?B?a2tGTjRNWTA3M0h1ZTd4TzRrYjNHa0crckY0aTNJbmZlVlFCdHlFam9FMnpW?=
 =?utf-8?B?bHRYMUhDd2hlV1dPZGpZZnY0QTVVSlZBOEV6WEVrb3V3YzQ0SzJsRzRoTHRY?=
 =?utf-8?B?OCtUVy9ZTXZnalBndjJGdjc5eFJ0N1ZtT2NGSEoxYkxrUmdqek4wOUcrbDFT?=
 =?utf-8?B?NVNHeEp6ZFRHN2c0NURUd0hjVHEvVDNmNE01dE5aTDB5WW5ETktWaHY5dkRV?=
 =?utf-8?B?VkhVRjFUOUN1eVAzS1Z2S213QVJsNjk5a0pFeThKTzNLUVhEVVd6QnNlUHlx?=
 =?utf-8?B?S1RYeEZXL1BIRHd0SWJlMVk0UmRKZms3aUJ2S1JFUlVsZEJTZkQ5dnlhQ2VD?=
 =?utf-8?B?dUc4YldxK2FmNmxETFFOcGJHVmFTNU44S2t3ejg0RGFSWEdvT3l3Y3d3dVUw?=
 =?utf-8?B?dHcxUkZ3RGpBV24wRll3c0lXWjhRckp6SnhHS3FaZ2tRMSsyV3NJZkxUWlVu?=
 =?utf-8?B?aElhTnRFRk1tbHY2TjFCeUt6NmhYcTNwb0lHMXhjZ3krZHI0SnFMcmRudVZ0?=
 =?utf-8?B?WElWaW1zRitBRjdOaTNWUHp6aThid2pheDFERzBRRnNVMlFQUENlcklhOTVI?=
 =?utf-8?B?MmozTlljdStJOGN1TmFXSVZNQm1weWVkVGF1VDZETFIxaG53YnZvT2pQVlp1?=
 =?utf-8?B?WFlSaDRPVTFZYWxlSFArVHBLdVgzeHNVdEhnbExuTWFZS0N4UlN5RUxrRFRI?=
 =?utf-8?B?SnpTTjdmMlE1U1lYQXFxRTI1ODZOVnhlMm04d09xZzdYMG1ucFQ3OG5ySDV6?=
 =?utf-8?B?b2dnWTZvYlVrSndvTE4walZJL3NkOGpseWQwYmZKT0VTS1ZFOWYwSjBzU0VB?=
 =?utf-8?B?MHZDcmhLTFQreTlvYlQyUDBTL3g5Z09wcmlCd2U4RUpDUE11Sk9KNlBCTm1P?=
 =?utf-8?B?ckVGb0d6bFhYOFUwWXNmUHVLVjRYVkVkMmd5MGlvbDVxbk8wZmlRdnRzMGRn?=
 =?utf-8?B?c2hScTN2ZXFXbUZrSkN1ZzZHZTlZWk95R3J4RTM4WWJmL0xIZUViZ1RrcUJj?=
 =?utf-8?B?WFZBVjRpYUk1WFBKcThTZW1KM3JsQkl3bGNSLzJINzZMZmI0ZnFaTE9JMVBV?=
 =?utf-8?B?d3M4WW5mVUhxY2RYeG0xdTFPYUxrMGtJd2ZtWUlNeFRwYlJSS3IyTjJ1NUMw?=
 =?utf-8?B?YTBBSTVKY1Z4MzJSVlBYWlhwVTYrYndBSjdpczFuSnNJdi9nNThoTkJwbjA3?=
 =?utf-8?B?dEVTaXh1VjFUQlRMK0QvQyt3aDhvQzFtenlEcFNiSC9nanhvQWpMU1lGNVhM?=
 =?utf-8?B?dnhjSTBpZ0oxbkhvaURqM2hma0lLZXlPMGdxU0I5aHI1YWFrVUpybXZXRDdl?=
 =?utf-8?B?Z2ZFVHdKOTA4ZkJiQjRxMWFGQTM0UkF0dklUc3pOcTFhNlV5TW9iWll5K3Rh?=
 =?utf-8?B?blYyQWpaYXBQNGwxc2tMUHJscXhKV1g4THJ1SW1od05iK29zeVJSdXpNTHoy?=
 =?utf-8?B?N0xNL0VnQlVIcDZ2R1phSTlXTkl2UW0vU2ppcDFwNE9xZnI5M1J0M0ZjTE5P?=
 =?utf-8?B?b3dzOWloZENSL0xVQUNkRXlqam0ycDZqeXlyS2xjYzBEOHBXNC8yUFJlZmY3?=
 =?utf-8?B?ZWF3UW84MTNmOEx3anVwRS9ueGhibWxVTng3SXNBenlvUmxnYXlvT3F4NU5j?=
 =?utf-8?B?MHRvcG8ydm5tby9KVmRnTE1WSFpRbGxWSC9hT3RyaGZ3ZTZ5QkEvT2FXcS95?=
 =?utf-8?B?ejhyTmRnYm9WbXU3TTFLOEorNEtFWFdpNldEMkVSVGpSZlNJWnlNOXg5Yndy?=
 =?utf-8?Q?YJda9aIbRdwmg33w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iCy4QuU9eLpibNhsAiwUKSQZ5Pl74QMon4XKWflDlI7a0dFdOv9CXIRcVV1bBXPJQAQphMENpLdJbpx1dyJx8lBlsoOpvT0R8cRT0kwCI7I5wXb0evQosXhFNMInOiu/BReh9OAkhSUP30rKA5zWspibdhFrFkp8AC6nfvOr92xlbYA0SLHfgjBS44SjaOVxaYNopRVxpPhYKPd/rDe8z6NQUF6pxhluqN1MztYToEv1U1qwq4SYLsHK/mkVeaAuzaWQKhrZ4JFxm/iufBuZ6DGtdagLkxP68FhljaosjR6USSj5TsizPGep2pxr8pl2nMuoTfIcBKUC8AFym34FHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67282f82-37e0-4d42-84df-08dee89b25cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:16:58.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KSRZ/AnD85kiVsrzqfFeC0EdjEB166hQZ9az2j2h2euQoLWcOyJmM0PRYWc/zGV/8B2J9T5WxMccjw9nSehChJ5XJh9FurZ2fHcJ1N8VNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgV2Vp
bWluIFhpb25nDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjEsIDIwMjYgMzo1OCBBTQ0KPiBUbzog
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IExvYmFraW4sIEFsZWtzYW5k
ZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+OyBOZ3V5ZW4sDQo+IEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBw
YWJlbmlAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggdjJd
IGljZTogcGFyc2VyOiB1c2Uga2NhbGxvYyBmb3INCj4gdGFibGUgYWxsb2NhdGlvbg0KPiANCj4g
RnJvbSAzNzZkZmRmYzc4OGE4NTNjNzlhODdjNGJmZGQ5NGRjMWVhNjc4YzQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KPiBGcm9tOiBXZWltaW4gWGlvbmcgPHhpb25nd20yMDI2QDE2My5jb20+
DQo+IERhdGU6IFR1ZSwgMjEgSnVsIDIwMjYgMDk6NDY6NDYgKzA4MDANCj4gU3ViamVjdDogW1BB
VENIIHYyXSBpY2U6IHBhcnNlcjogdXNlIGtjYWxsb2MgZm9yIHRhYmxlIGFsbG9jYXRpb24NCj4g
VG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBBbGV4YW5kZXIgTG9i
YWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4sDQo+IAlUb255IE5ndXllbiA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+LA0KPiAJUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3
LmtpdHN6ZWxAaW50ZWwuY29tPiwNCj4gCW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsDQo+IAlsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLA0KPiAJQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZA
bHVubi5jaD4sDQo+IAkiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4sDQo+
IAkiRXJpYyBEdW1hemV0IiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4sDQo+IAlKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPiwNCj4gCVBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4N
Cj4gSW4tUmVwbHktVG86IDwyODQ2MDAwMy00N2VlLTQ3MDYtYWQ5NS03ZmJhODdkMzY1MDlAaW50
ZWwuY29tPg0KPiBSZWZlcmVuY2VzOiA8MjAyNjA3MTYwMjUxMDAuMTE4MTQ1LTEteGlvbmd3bTIw
MjZAMTYzLmNvbT4NCj4gDQo+IFVzZSBrY2FsbG9jKCkgd2hlbiBjYWxjdWxhdGluZyB0aGUgcGFy
c2VyIHRhYmxlIGFsbG9jYXRpb24gc2l6ZSBzbyBhbg0KPiBvdmVyZmxvdyBpbiB0aGUgZmlybXdh
cmUtcHJvdmlkZWQgaXRlbSBkaW1lbnNpb25zIGlzIGRldGVjdGVkIGJlZm9yZQ0KPiBhbGxvY2F0
aW9uLg0KPiANCj4gdjI6IFVzZSBrY2FsbG9jKCkgaW5zdGVhZCBvZiBremFsbG9jKGFycmF5X3Np
emUoKSkgYXMgc3VnZ2VzdGVkIGJ5DQo+ICAgICBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRl
ci5sb2Jha2luQGludGVsLmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4gdjEtPnYyOg0KPiAgIC0gUmVt
b3ZlIHJlZHVuZGFudCBpbmNsdWRlIG9mIDxsaW51eC9vdmVyZmxvdy5oPg0KPiAgIC0gVXNlIGtj
YWxsb2MoKSBpbnN0ZWFkIG9mIGt6YWxsb2MoYXJyYXlfc2l6ZSgpKSBhcyBzdWdnZXN0ZWQgYnkN
Cj4gICAgIEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogV2VpbWluIFhpb25nIDx4aW9uZ3dtMjAyNkAxNjMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcGFyc2VyLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3BhcnNl
ci5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wYXJzZXIuYw0KPiBp
bmRleCBmOGU2OTYzMGYuLmY1YWU2YzA3MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2ljZV9wYXJzZXIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3BhcnNlci5jDQo+IEBAIC0xMDIsNyArMTAyLDcgQEAgaWNlX3BhcnNl
cl9jcmVhdGVfdGFibGUoc3RydWN0IGljZV9odyAqaHcsIHUzMg0KPiBzZWN0X3R5cGUsDQo+ICAJ
aWYgKCFzZWcpDQo+ICAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiANCj4gLQl0YWJsZSA9
IGt6YWxsb2MoaXRlbV9zaXplICogbGVuZ3RoLCBHRlBfS0VSTkVMKTsNCj4gKwl0YWJsZSA9IGtj
YWxsb2MobGVuZ3RoLCBpdGVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAgCWlmICghdGFibGUpDQo+
ICAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiA5NWUy
NGU5MGI1NWNlNmQ5ZDI2NmVkNmYyMDUxNGYzN2M5MzFjNzUxDQo+IC0tDQo+IDIuNDMuMA0KDQpS
ZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo=
