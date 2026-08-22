Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CD217723
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787372689; cv=fail; b=VQv/3JS/cVvgc+6Q6cPnJuWlSPL2J/oQG/lk3BHfHIALzXuu0rIanuJ1SOZ3AEKGiCax3UZn8dIvWqiI3fPCGwrT3zZBAi61jxvG/PNxkXZ44zuUwjcQWiiDRx80oaTha90Ymz0SPjBTwEw7qKOLWRphb9r4Wcg0RxyxsEaH+F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787372689; c=relaxed/simple;
	bh=h+jeufPy7nRkUHv0rZUc71Js9ZC4o3oykMNDZasNq3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcqUklnb3CtxJnNEDMTMxkPPH2vR3b8puFLAb8IVd7e/ybL002lWvU8m5Xp+Auxpju0a8RrQ4sm4KAHTh8OL0MQTu/+AhMFHbjjZILt3MyKSh7VGnvJ3zsoMRXS17uODO3r7KIyfsbhdK0EX7B4H0FstEGfPHBU/pHsWJOzx3FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZzc8uf4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZzc8uf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787372689; x=1818908689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h+jeufPy7nRkUHv0rZUc71Js9ZC4o3oykMNDZasNq3s=;
  b=JZzc8uf4v+UV1N9AJGhw+egoQ3mInxdMhShuoMAH6YLYsilmC44lLYH1
   kS8ZJ/xD9CiQFpd3+VZ+ZxfdxnBU11nzrl8qvVC+Lqiz6mHRaOZ8uQ0NH
   Ax9E4svXcfzjAV7pGmVSXa6cJzLkFnzA0tqJFIjvIZJQBWkuTusdMH1Xp
   yhNZFoN7EbA8aczflhDLHvAcXCw7z/PkfZpdnxfI5tUTzvuOHcXHjCr1m
   I9tvmm+PZ84lwMZy3ygBxs46mNCMLXW+70MTPRpoBTkuAEr2a6IBFt7Sb
   aA+79t3jRhu7esh2wgZ62dcPbT53HfvneylxFLjl2/ldmQ9Ubr1Sl7E0J
   g==;
X-CSE-ConnectionGUID: CX7etpKbSwuHx2VkhjbFSA==
X-CSE-MsgGUID: ZnBZGNkgQKSGH4hm8ZyiHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="113456315"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="113456315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 21:20:48 -0700
X-CSE-ConnectionGUID: v85pwTefRnia9M1e+5gR5w==
X-CSE-MsgGUID: UifpkvhiTdufdiuaAXyxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="267091655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 21:20:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:20:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:20:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK6oQd8CrqXsOYWEzwp74t9PwgxKJedMOXAQnImEjTmYxab7NUb8n8xSyGDTNo5K5S3/rqzBlP+4n50DUpEG8lmAqysHK1ss2ZLo0K735UVYWDUaS903nkNFNnKHH3XBvREH1i8EET804NpXevGKfeSkm1KfQ3fqzl9P1GWqjl2MIBijL+PkgkDZed7tb+KVddC4cL6Z+JErS0mwuAVzlauBPnrJkqyFaT8SLdlgbdVk6woVKNY+7p+mbc5oeE435kPmOzMhzGjJwD7YnHZ/REKK4w+hBzPrfIFoKfWGYf+RnnlZaG84/IKNMoWzgXYqsv79h7PNDJMvKaodcr2Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+jeufPy7nRkUHv0rZUc71Js9ZC4o3oykMNDZasNq3s=;
 b=AXPo77JkMUIChPbhPNzO/tXMJlGXw2BkBmICpHkqp0sIiyPkCnh3mv3zB23R9e3Ox0Iwv4zxEJhmMCOZOF0cyf6d/+yIv59DXeW8NFz+SDClput+uxZufKTPes9VSa6xV2Pjn5ueIoE76me2lAOuU6z7b8mqAwj7+709xcn/68QhDe6giIfTwx7saKbD6+anUda/XLp6T9LUlEtnNgmaMgZPNVmoA75PiJUfXx7/ePjlhgkcLs6R/EzU2gGtrwtt8Sppel9TYiwAepmzr3UeKVfcRtUycRckYD0x5ZzJaKBBpKeM5CSGOQH8ARwH3FLYlrkNfLloTXoWb+yuWOGr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:20:44 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:20:44 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>
Subject: RE: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Topic: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Index: AQHdMctM3GdIS1JkP0myQS0jU3vFqLapd1pg
Date: Sat, 22 Aug 2026 04:20:44 +0000
Message-ID: <LV1PR11MB8790DF54205106110C3F95D690A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 41771ab6-d662-4614-c491-08df0004bc3f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: 7r9ntb2q8s9Hbjo7PsaYdVE5DnPrQk7R6xRqL+cfVB/mo3l9rtGKD+fRvLe5a1A/Gk3DPFRKGXEKO8Z6V1ofZsTJvnRdh+k83KEzwuC442MLzjHC9+eYk+Fcsi/hyZt7zuvn+z79K1HOZhLL5w+0IBOqFB1XinjQim1TyP9oJvEvJSismgBxHK7HeH/oAtvv7rLAQ4AaiqnTQIM8uBiHt1POKj/KDV2KubnDWWQXD7PmcZSv3HoZ3/tj0oJBKJ46okXhWrqYP5bkHlvA6IcwKoju0BKv+kLZFO8RZTqwbm4WpWAkVAVmdDKst8ffzbyFR0We1mrqEt9xicbnA/eVTRMy9NnBG2I3RSjYuxiMMLXNJqIizDBFcmRzavzfeP77is5GL+9wpHpYlxhGFebgq3OiyMB15HObSHlwHknAYoCySe7rAna2g32PIwSF6iAEJB6cyd8eCNnt/3vMtw4KlvAKI51M+r5d0DDayMAfSW+AWCiHalsycqqcOB4fm1xC/FZiAPwUBOE8juCf8iRUC3p8HTJyUZTRIqcnPcKqBGQ9TrWYIn5l2UYw3qweVZhpTFIY1NexQlVshTWRd3sj/u1M7mDDXTbdUHPFgtphWGyFL1pqwkiOy+5/nw5rmnUUKq/wsMevR3iy0vJqmuQxrmqeXb0BTn+8kwtY99ba5lV8Z1m5f+kQeGgNod0QweR0mNGr/X5hweLT3lg292ZWAcNIIkz4U5HNfum2DWy7KxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjF3bjdTeURiUHN1a2F2alMxT2JZMHdEaGh4WldFM2FDeUlSN3ExRGcwakgx?=
 =?utf-8?B?WXkxbUM2Wi9qV2FoNy9wdCtMdzE3M2lGaW1GNlhkL09jT2FaNUdrUkU3Z3k4?=
 =?utf-8?B?Ujg0MTc3bnVmcVExc2JmdFdTNVA1RXFFcFExMUxHZ0NHb1M2ajZZdXhmRU9T?=
 =?utf-8?B?b2VHSG9FaVBSTVFDb3FETHVWWnBVTXJHQzF4NTRSU0VuVXV6RFliYkM1ejI4?=
 =?utf-8?B?enhxQllDbXZnRTJtdm04ZFFDaWR6SUdsb1BtYlpLTThwb2NxdDlWZmpRekdY?=
 =?utf-8?B?MFphTldBUkpYTW5KZ2FoZGxEWjBIZ003UWV2Y2V6SjZNc3NoY0Y4bCtPZWdF?=
 =?utf-8?B?aml1eXJIRk52V1FOcEsvbGVERFVDcW5nb0g1V1Qzb1dsRWQxYU5DMUYxSkR1?=
 =?utf-8?B?SGFRSk4wVTZMSkJQT1EzVzVxRjFhT1JPODRPT2Y0NVUvOFM0T0VtWi9Mamlh?=
 =?utf-8?B?SE12SDcxeHdVWEQvWVRsOW9mRXcxeE9DOGJJWVJIeWxIdVdUVDVwd2NqRDRk?=
 =?utf-8?B?eVpMK2RDajkveThLdWRzbG1TWGlnbHhvTXFGR2N2ajRKdFE5K2wyL2dtNzRh?=
 =?utf-8?B?TTk4NzNNQThQVDRFUEtDR3BSM0k0MkUyZnBGOVhJV0pMUHMyRzk5Q1F4eDBW?=
 =?utf-8?B?dHdIWjZHUGdCTDArb2srYjhqS3ZDRXdCYkMzc3hMa2JSMUUrTDhWbHRLTlVS?=
 =?utf-8?B?QXdzQ0lHT0JIQmtwaFV4WStQdGVLQVVWaHFRSXhhY2RDbFYwbTBqbmx3UDZC?=
 =?utf-8?B?N3BQOGR2YjBnQ09XL2RJU0lQVUJOb2JabThvLzVDNVhjTURnQndJeUp3bGV6?=
 =?utf-8?B?NFp2RFlaajdoTHdIS3hxR2tvemd6T3dUU2ZjTWhOMGxxZW9wQUFVZko1SEJP?=
 =?utf-8?B?aS9MN3ZOSTBXdlNueGUxcHJ2Vlc5NVpjQ1RqMUFncURJcUY5NnRYbWRLN1Z0?=
 =?utf-8?B?YWZaa1dGOGRrRGZoWWVUTkRDLzk0WTNFUGJBT1lsYlVBUjkxQ2VkWGVTdjVu?=
 =?utf-8?B?a1lnUzIzTkl6MFRFaHJFMmJ2eENTdnpEUzcrRHQrUnMwZE90VkRLOEpLcndV?=
 =?utf-8?B?RHFhZjAwVlA3MmhVMmgrUllkcDRqMlVKM25ETXJaMXNGVUxraG9YTGlyeVND?=
 =?utf-8?B?YTVXMEhQcys1NFp0TUJuQTQ0Y1hNTldMUHIzYVRDWFoyVk5rNEkxWkh5S015?=
 =?utf-8?B?NUtXMTMwWTNtZklScys3VllxM0NyUTZCU1hpK0luYjZ6akJBa2k4YlpnL0ZP?=
 =?utf-8?B?QTFVQzFCUjhTdTd6c3FNRFlybkludzJ0alNTUEgzV0h4R0JvU21CR3d5NlQ4?=
 =?utf-8?B?aUZTRXg2Vkc2a215c3hLOFV5UmFZWjZTOVFOVXhtUmpINFJiSkpzT3ZjQ3cy?=
 =?utf-8?B?RUVsZitvMmJGZHNvVDdYMG9RQ2ZLOTJ4TG80eHJhYkMzdWZ5UnpJZDZITkU5?=
 =?utf-8?B?UC8wVS82L2o0TENQVkUvVFE3akVIUnNpNkFhR2tpaHFDdHM1NU4vbFdDZ1cw?=
 =?utf-8?B?bkYxT3FOdmdKbThkWWVtc3hmZTU3dHVqbzA3RXd1YkVOeFgxSTJyZ0FZZU9t?=
 =?utf-8?B?a3JDUHhpT3g1MzJsOHR1QmlHQm9PS3Nac3NPZmZGOW43c21FNDhGaGoxVEx2?=
 =?utf-8?B?cHdvWmJTSE5QT1RzamRvQ2gwdE1NYW9UZ0VYQUtTNUhHeFVZWlN0Y3pKd2FR?=
 =?utf-8?B?SXhsVTZJMnBsMVlHMmYvbTlKaWNBNmVqdzFHUVltbitTcVp0VG1yNEhzVGpC?=
 =?utf-8?B?WnZJdGZ3YXBybk10N3VpdGs3RTI0VlQwMzRtNU1SQ0l4ZkhkV2JXYU9tVC84?=
 =?utf-8?B?ZHMva3lvTFFaK0tQZFFuZGltS3RIcXJZNnRWZHlDMWtnS1hBYVJSaldKWUVL?=
 =?utf-8?B?RDIyRkFjcVdsYkdycHRWcWtwTGhqcXh1aCs2SkFaSFI5K2hjY3hjRTRIaGNk?=
 =?utf-8?B?T2hYbmRMMkZ5S0Ztd0JkbUE0ZDNyTWhVUTdzbVdtMG05dEpiMkNGS2RyQlFT?=
 =?utf-8?B?UlBGNUFxYjE3WGFkVDRtMTlwZjkxTngvZUkwN0tnUldrNEw3Vlc2YXh0TzYr?=
 =?utf-8?B?NXFjVmQyZXJJWTVNelRXdFhzaG1tQ1JzV2tROFRrQWpZckxXalpkWU1oWUR5?=
 =?utf-8?B?cDZwUHNaQXQwMXRTQ1hQUHdsaytieXFWd215bGZBVzUvdm5WZEhKaUh3QTQ0?=
 =?utf-8?B?TDU5SXQ3clMrb0J6OWtlQmpzc3dZVDh4Ym5lOWFudVlBOUV1bWc2TzI2QXRH?=
 =?utf-8?B?T0NOd0ZEVTVrRmoweXd1b2h4NVFDb1I4aWdXaVB5WmlBQ3BFQnVnNHRpampM?=
 =?utf-8?B?YmdPK25WQ3JFNEdGa0tmRVYxaXNnbW9rWjRTSUZIWWZkaFRZQTB6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZMnj76V7OgRzWXNPFniNWpf0w8DprXZAx78QswaP3/wqYL9jhVQOmL2r33I/+4vW+IkIHqjFXOeG90Ac7pRnuIBFvnz6V/awobh+XzkJ5vebMar5pHp9XzR9yf61a0RQG9omj4q/B+MfqTdWlWRDQOL6tuv4t3qF4A+G6exJztG803JjpYYc3/cQqEFnEBrdoUs8+OdpS0oO7Bj//Dt0rz3Qpc0iozmpUExOR6KMdrLziMuQ5VF6KVS5uo4Mv4SBsdClCT0K/1l2Xvt9EdFu+U7IyXX9LinGyTigJGEChV1Kt2mlzimLLXux4wlO3sScor27U4/AcnhOhWmt6F54+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41771ab6-d662-4614-c491-08df0004bc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:20:44.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9gDCIuR6+DM0nXQDv15VEM3Mo3UOvetn9vCd0bLjqRo5oqoixiLOJRigcfRH12k1D9rkfA1ofdQAPKqapjnE6vMuNQnKB1g/AwglR1CBDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB992400
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2
IDU6MTMgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5rb3JiYUBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVs
LmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBOb3dsaW4sIEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBCcm9zcywgS2V2aW4gPGtldmluLmJyb3NzQGlu
dGVsLmNvbT47IENhdmF0dXIsIFJhbmppdCA8cmFuaml0LmNhdmF0dXJAaW50ZWwuY29tPjsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCBpd2wtbmV0IDEyLzEyXSBpY2U6IGRvbid0IGNsZWFyIGluX3VzZSB1bnRpbCBIVyBjbGVhcnMg
cmVhZHkgYml0bWFwDQo+IA0KPiBEdXJpbmcgYSBsaW5rIGRvd24gdHJhbnNpdGlvbiwgdGhlIEU4
MjUgUEhZIGhhcyBhIHNtYWxsIHdpbmRvdyB3aGVyZSBpdCBkb2VzIG5vdCBwcm9wZXJseSByZXNw
b25kIHRvIHJlYWRpbmcgdGhlIFBIWSB0aW1lc3RhbXAgcmVnaXN0ZXJzLiBXaGVuIHRoaXMgb2Nj
dXJzLCB0aGUgUEhZIGRvZXMgbm90IGF1dG9tYXRpY2FsbHkgY2xlYXIgdGhlIHJlYWR5IGJpdG1h
cCBvciB0aGUgdmFsaWQgYml0IGZvciB0aGUgdGltZXN0YW1wLiBUaGlzIGJlZ2lucyBoYXBwZW5p
bmcgc2xpZ2h0bHkgYmVmb3JlIGEgbGluayB0cmFuc2l0aW9uIGV2ZW4gYmVmb3JlIHRoZSBmaXJt
d2FyZSBoYXMgbm90aWZpZWQgdGhlIGRyaXZlciBvZiB0aGUgc3RhdGUgY2hhbmdlLg0KPiANCj4g
VGhlIGRyaXZlciBoYXBwaWx5IGNvbXBsZXRlcyB0aGUgdGltZXN0YW1wLCByZWxlYXNpbmcgdGhl
IGluX3VzZSBiaXQuIFRoaXMgYWxsb3dzIGFub3RoZXIgcmVxdWVzdCB0byByZXVzZSB0aGUgYml0
IHBvdGVudGlhbGx5IHJlcG9ydGluZyBhbiBpbnZhbGlkIHN0YWxlIHRpbWVzdGFtcC4gQWRkaXRp
b25hbGx5LCB3aXRoIHRoZSByZWFkeSBiaXQgc3RpbGwgc2V0IGhpZ2ggdGhlID4gZHJpdmVyIGNv
bnRpbnVlcyB0byByZS10cmlnZ2VyIHRoZSBJUlEgYW5kIGNoZWNrIGZvciB0aW1lc3RhbXBzIGlu
IGEgdGlnaHQgbG9vcCwgd2FzdGluZyBDUFUgY3ljbGVzLg0KPiANCj4gVG8gZml4IHRoaXMsIHJl
LXJlYWQgdGhlIFBIWSB0aW1lc3RhbXAgbWVtb3J5IHN0YXR1cyBhZnRlciBlYWNoIHJlYWQgb2Yg
YSBQSFkgaW5kZXguIERvdWJsZSBjaGVjayBpZiB0aGUgaGFyZHdhcmUgY2xlYXJlZCB0aGUgaW5k
ZXggcHJvcGVybHkuIElmIGl0IGhhc24ndCwgbWFyayB0aGUgdGltZXN0YW1wIGluZGV4IGFzIHN0
YWxlIGFuZCBza2lwIHByb2Nlc3NpbmcgaXQuDQo+IA0KPiBTdGFsZSB0aW1lc3RhbXBzIGFyZSBh
bHJlYWR5IGlnbm9yZWQgYnkgdGhlIGljZV9hbnlfcG9ydF9oYXNfdGltZXN0YW1wcygpIGZ1bmN0
aW9uLiBIb3dldmVyLCB0aGUgaWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcoKSBmdW5jdGlvbiBh
bHNvIGNoZWNrcyB0aGUgcmVhZHkgYml0bWFwLiBJbnN0ZWFkLCBtb2RpZnkgaXQgdG8gb25seSBj
aGVjayB0aGUgc29mdHdhcmUgdHJhY2tlci4NCj4gQWRkaXRpb25hbGx5LCBzdG9wIHJlLXRyaWdn
ZXJpbmcgdGhlIGludGVycnVwdCBmcm9tIHRoZSBJUlEgaWYgdGhlIHRpbWVzdGFtcCB0cmFja2Vy
IGlzIGNhbGlicmF0aW5nIG9yIGhhcyB0aGUgbGluayBtYXJrZWQgYXMgZG93bi4gQ29udGludWUg
dG8gY2hlY2sgdGhlIGhhcmR3YXJlIHJlYWR5IGJpdG1hcCBmcm9tIHRoZSB3YXRjaGRvZyB0byBj
YXRjaCBjYXNlcyBvZiB1bmV4cGVjdGVkIHRpbWVzdGFtcHMuDQo+IA0KPiBXaXRoIHRoZXNlIGNo
YW5nZXMsIHRoZSB0aW1lc3RhbXAgcHJvY2Vzc2luZyBubyBsb25nZXIgdHJpZ2dlcnMgYSByZXBl
YXRlZCBzcGFtbWluZyBvZiB0aGUgSVJRIGR1cmluZyBsaW5rIGRvd24gZXZlbnRzIHdoZXJlIHRp
bWVzdGFtcHMgZ2V0IHN0dWNrIGFzIHRoZSBQSFkgdHJhbnNpdGlvbnMgdG8gbGluayBkb3duLiBP
bmNlIGxpbmsgaXMgcmVzdG9yZWQsIHRoZSBQSFkgd2lsbCBiZSByZXNldCBhbmQgdGhlIHN0dWNr
IHRpbWVzdGFtcHMgYXJlIGNsZWFyZWQuDQo+IA0KPiBNZWFzdXJpbmcgQ1BVIHV0aWxpemF0aW9u
IG9mIHRoZSBtaXNjZWxsYW5lb3VzIElSUSB0aHJlYWQgZnVuY3Rpb24gZHVyaW5nIHRpbWVzdGFt
cCBzdG9ybXMgbmVhciBhIGxpbmsgcmVzZXQgc2hvd3MgdGhhdCB0aGlzIHByZXZlbnRzIHRoZSBz
cGlrZXMgY2F1c2VkIGJ5IHRoZSAic3R1Y2siIHJlYWR5IGJpdC4gV2l0aG91dCB0aGlzIGZpeCwg
dGhlIENQVSBoYW5kbGluZyB0aGUgSVJRIGJlY29tZXMgc2xhbW1lZCBkdWUgdG8gdGhlIElSUSBy
ZS10cmlnZ2VyaW5nIGxvZ2ljLg0KPiANCj4gTWVhc3VyaW5nIGxhdGVuY3kgdXNpbmcgdGhlIGlj
ZSBUeCB0aW1lc3RhbXAgdHJhY2VzIGRvZXMgc2hvdyB0aGF0IHRoaXMgZml4IGNvbWVzIGF0IGEg
bGF0ZW5jeSBjb3N0LiBMYXRlbmN5IGlzIG1lYXN1cmVkIHVzaW5nIHRoZSBpY2UgVHggdGltZXN0
YW1wIHRyYWNlcyBmb3IgdGhlIHJlcXVlc3QgdG8gY29tcGxldGlvbiB0aW1lLiBJIG1lYXN1cmVk
IGEgY291cGxlIG9mIGRpZmZlcmVudCB3b3JrbG9hZHMgYm90aCBiZWZvcmUgYW5kIGFmdGVyIHRo
aXMgZml4Og0KPiANCj4gICogcHRwNGwgdXNpbmcgYSBwcm9maWxlIHdpdGggfjE2IFNZTkMgbWVz
c2FnZXMgcGVyIHNlY29uZA0KPiANCj4gICAgIGJlZm9yZTogMTU5LjQwIG1pY3Jvc2Vjb25kcyBt
ZWFuLCBzdGRldiA0NS4yOA0KPiAgICAgIGFmdGVyOiAxODIuMDcgbWljcm9zZWNvbmRzIG1lYW4s
ICBzdGRldiA0My40Mw0KPiANCj4gICogYSBDIHByb2dyYW0gZ2VuZXJhdGluZyAxNiB0aW1lc3Rh
bXAgcmVxdWVzdHMgZXZlcnkgMTAgbWlsbGlzZWNvbmRzIG9uDQo+ICAgIHR3byBkaWZmZXJlbnQg
cG9ydHM6DQo+IA0KPiAgICAgYmVmb3JlOiA2MDQuMzUgbWljcm9zZWNvbmRzIG1lYW4sIHN0ZGV2
IDM0NS4zMg0KPiAgICAgIGFmdGVyOiA5OTAuMTMgbWljcm9zZWNvbmRzIG1lYW4sIHN0ZGV2IDYy
NS42NA0KPiANCj4gSW4gdGhlIG5vcm1hbCB3b3JrIGZsb3dzIHRoaXMgY29tZXMgd2l0aCBhYm91
dCBhIDIwIG1pY3Jvc2Vjb25kIHBlbmFsdHkgb24gdGhlIGF2ZXJhZ2UsIGFuZCB0aGUgc3RhbmRh
cmQgZGV2aWF0aW9uIHJlbWFpbnMgYXBwcm94aW1hdGVseSB0aGUgc2FtZS4gRm9yIGhlYXZ5IHdv
cmtsb2FkcyB3aXRoIG1hbnkgbW9yZSB0aW1lc3RhbXBzIHRoYW4gZXhwZWN0ZWQgZm9yIHR5cGlj
YWwgYXBwbGljYXRpb25zIHRoaXMgY29tZXMgYXQgYSBzaWduaWZpY2FudCBjb3N0LiBUaGlzIGlz
IGJlY2F1c2Ugd2UgaGFuZGxlIGFsbCB0aW1lc3RhbXBzIGluIGEgc2luZ2xlIHRocmVhZC4gSWYg
dGhlcmUgYXJlIG1hbnkgY29uY3VycmVudCB0aW1lc3RhbXBzIGJlaW5nIHJlcXVlc3RlZCBhdCBv
bmNlLCBhbnkgd2hpY2ggdXNlIHRoZSBsYXRlciBzbG90cyBvbiBwb3J0cyBsYXRlciBpbiB0aGUg
cG9ydCBsaXN0IHdpbGwgdGFrZSBtdWNoIGxvbmdlciB0byBiZSBwcm9jZXNzZWQgb25jZSB0aGUg
aW50ZXJydXB0IGlzIGZpcmVkLiBTaW5jZSBlYWNoIHRpbWVzdGFtcCBub3cgcmVxdWlyZXMgYW4g
YWRkaXRpb25hbCBQSFkgcmVnaXN0ZXIgYWNjZXNzLCB0aGlzIGNvc3QgaXMgbXVjaCBoaWdoZXIg
aW4gdGhlIGNhc2Ugd2hlcmUgdGhlIGRldmljZSBpcyB1bmRlciB1bnVzdWFsbHkgaGVhdnkgbG9h
ZC4NCj4gDQo+IEhvd2V2ZXIsICpjb3JyZWN0bmVzcyogaXMgbW9yZSBpbXBvcnRhbnQgdGhhbiBz
cGVlZCBoZXJlLiBBZGRpdGlvbmFsbHksIHdlIHN0aWxsIHJlbWFpbiB3ZWxsIGJlbG93IHRoZSBk
ZWZhdWx0IGxpbWl0IG9mIDEwIG1pbGxpc2Vjb25kcyB0aGF0IHB0cDRsIHdpbGwgd2FpdCBiZWZv
cmUgY29tcGxhaW5pbmcgYWJvdXQgbWlzc2luZyB0aW1lc3RhbXBzLg0KPiANCj4gRml4ZXM6IDdj
YWI0NGYxYzM1ZiAoImljZTogSW50cm9kdWNlIEVUSDU2RyBQSFkgbW9kZWwgZm9yIEU4MjVDIHBy
b2R1Y3RzIikNCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBp
bnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9w
dHAuYyB8IDU0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQoNClRlc3RlZC1ieTogQWxl
eGFuZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo=
