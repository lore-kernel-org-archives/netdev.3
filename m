Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912434A0157
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890792; cv=fail; b=gzbtR+cBZlUMfL1v9gUc2Gvpe6ZILp15Y7ZTwaxHjHhTQ2Nd6o0+Njs2diw7FoydZp0Uwyq/9lxg76LwPm+0DwscfOw2b2/z6S2IJ0sEW/HQo+icdl4snoAo09mX3ldEK1MGSl5RBqWqfIgoCXYNCLMLU5nTaS1ntfIOgseBt3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890792; c=relaxed/simple;
	bh=cmKaiXB4+dGtACsdujsoTW3zCjiwiB1OrRPrCMjnyWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EKkr+GAQOzmAMH1il3N23kedTDVnNaMTq1o9JSH9MaBBiaeOgNzA1XOkBuBokMs6WKxQOr4W38IQmPlk2W5iKDnzrC3RgCZ2BASY5CRDtTrmfUVY/DYNGfSHPDjm+RaPj7S9fzE3LF4pVEZ0fuW7TWI3aGj2Hzh6ZNlFytioXoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOfkYLWm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOfkYLWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788890791; x=1820426791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cmKaiXB4+dGtACsdujsoTW3zCjiwiB1OrRPrCMjnyWA=;
  b=WOfkYLWm6reLYoe6kbfTQPIj3704iMoeecnmCcKpRL9LsjYXqeqXs7zg
   vMMmrUxO2sKzpbVnI+uaCeZbtKOV5Nb+LeklPRDwuOh79MWIdFwWjlK32
   oah8Au9bW1j0uOFFFy0HlWUDYIdY1q2m28NE8kqzL1Y2yF+xVOVqc6Eop
   7EztZSC2OaUI6OE3fwRsucjMJu8g+MONOglxsPZ2slDAC1b+p2l8cPYQY
   CKlCYm8A9qlcO9f6yDUNJUpzHaYpGuEMIWRI5v+uBgU85dNwg9k/n0ZWV
   JvhKYXwMvPY5gq0K1KbAHQ4VFzZuYMamsToz584VZr8vijpTLiL6Xw4G6
   g==;
X-CSE-ConnectionGUID: PEJhozRLQCWS2xN3UTbEZg==
X-CSE-MsgGUID: JRdOVLSgTzWZXSfjwKatYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88238928"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="88238928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:06:29 -0700
X-CSE-ConnectionGUID: ing/D4FaR4OAEPXRzO4IhQ==
X-CSE-MsgGUID: mKQD7M26RbCaQOTzR6cQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274863547"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:06:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:06:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:06:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kibpNs9GFjJnh6ujCLBKj9eShC0xHyRWcgAaKuewp/BWGBJpmPbmJKNjaoTElowbUvy06YmUxu+gB/86m15pEqMqOm39OFRo0Xt+d2ZN9a7nAnYHe8dvNRqvWOSLc3KzSJc55idzp9d+fLRRPep7Nce2Hmnf3fGqC9831Vi2D2LnM4TmSuH2QVVfcxmfY/0NqBKyEw+Zmp2jNQPUDt2EOd6clUHgsQSjlVyHShIEQs6WYlbXA541mB0FpZu2bkbqIYGqNv1ZkKDsf6drS3burxjkKKH7eQrd/Mv7rcVyY6fu/CMeoGk8B3PAJJa9R60rJ7x40MArzeQGaeV4aNvm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmKaiXB4+dGtACsdujsoTW3zCjiwiB1OrRPrCMjnyWA=;
 b=ISS62UE8o+HBO+uH/o+Fvn8T687/HxO7OTh5TIg2oOc4vlFYV24fj1pJzVPj05XfgRJzBo0mKl8y/mf4nUvdQ9uEDOpYAUQfrltgq0UY4UJXKZAv1BTMoxTyFX2AB1WXKBXuTGnT2uCsvwJ5W3SNuG3uHFKk6ivTyQwG4XgZqazHdDcjoVkZc+W+rcyuMcYMm611Xpogd7AgH7I/tIM4Ollvypf6dDH/vJMQ2I9HzlPpNzO0YhXFc6HfEFHvyjGybRlLH1ZGkyd4S6RfnzXPpWHWU9dZyRLNDurjL7LbIvgVp0m1RxakHzeQwQW90NRYpXwBwbiMIRyoKmk6jJukgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:06:21 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:06:21 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v2 11/14] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Topic: [PATCH iwl-net v2 11/14] ice: keep Tx timestamp slots tracked
 until completion or timeout
Thread-Index: AQHdNOTPrpPZ1Y7V2EKBUT3sAd+a8LbFD5Pg
Date: Tue, 8 Sep 2026 18:06:21 +0000
Message-ID: <LV1PR11MB8790F723F08C406E5181AD5790B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-11-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-11-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PPFAC42FDD50:EE_
x-ms-office365-filtering-correlation-id: 32781a20-faf8-417c-0daa-08df0dd3e371
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 8NpoDscwQQIzBjM0I2QkFl1n2Cushzw3o+1Sr3uHFFTn9cXGeUFQm7aGWBAploGPDFh6o3KYNG7VGrKPATxFzqfR2igdpJuyBSfg/9pHS+hLCCV1qIsPeRbByiXZJ07CuzYWMdp1yKGyl6XwPv7H1k+Ldhkr/0tsA3HH3coJJOoDVKwTiSeiJ41yB7MGw6qRZn6kx8GsRRB7rxDFj+AGu1lS0WDZ/JHoOoeoByzWaPIJo1Hd4haoGNah7YfSL4OMA42rSCqrjNfPvsUNLF0x/2aG04P0NIlxhsupwwE7tDHQUFtCSFRPa/ufCmSS6iM52TgNQ1V2Zsru6FgPZGZ/3vOoXJoE7sl5MTnh/gn6LX9nk8IujKhrgHHbSmBlLiKepNEkT2IzJH8AztHk9tCUiqxNe0ln9wMGta/UdHvYC1Ew9hqQYf02EXXHrZIbBFleVpL++7HfM6tT2AXZhJW59/5NW8Q8PPr+kU7V5glU8VvH/laeWGm3Fy1V+w+/JWHpK0DHgs4rEzr/7x/L5O8cZ5oxVcizIIdry1qlidAXdW20UgtVDJJwhcYVwqhqcePXgVPwl+/+TPd+WUP6bXcfIpBaILuXve0lIA+F5aqFtIQApjhzq+1ZHOQ5a0oKS4dnvMvuEdLtMClmTpvFpv4hQLXLUfQ+reBjSdMCCBXwOOb7lfQk6EIAXHvOY/H0I11fpanuyQv+ZZJ+IPiu+OrVChZIZsedPDryTDDdllXl47g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJwb0RVSVlkdDU0US9Zd3lRSS9JaC84VXpiV3RSWU04NXdUTFFiY1RCTTJO?=
 =?utf-8?B?d3hZdmtOR3BnclVrMmxtb094MFpKeXZxbSs3eWZWek45cDd1WWN2SHFiWXdK?=
 =?utf-8?B?RXpVL1l4NnNoeGZ3eGx6QU1hLzJsRkxZZmF3VTZMa0ZJTU5ZSmpXTXI0Tng0?=
 =?utf-8?B?QUVvZGtoN2t1bXlaNStqdkNWS1Z6ZE1kZEVpZVZrZ3dPemZBc2NhQ3Y4WGha?=
 =?utf-8?B?UGloSjFTL3YyRklXanltcURPa25ITCttc3VDOURYeWlmNWhWRFp6ZTBWM2s5?=
 =?utf-8?B?ODYrVmtFSzJWOHJodnk1Z3g0Z2hMQVVEU3VrU1pIUUpHUzNYUlloaTNHUG1a?=
 =?utf-8?B?N2R5SzRYbEJ1R1dEM3h4dERWTzJwSlJaS2N2K0YvUWEwRzFoc2YrVXdQcGpt?=
 =?utf-8?B?N1ZuNC9jVi9tbk1CMGgzVWdZM1ZxSzZVbnZPQlRLUGR0ZTg5V3JJOW1UdFEw?=
 =?utf-8?B?bHdHMjVOM01YOXRhQTlDM3ZvT1psRC9wQmNYRXNLSlVOcWc2Z2NYRTlJdlQv?=
 =?utf-8?B?aTV5ekcrRHB3a2Q2UmQrQWI5VGVKNDJwMklOWC80U2lxdUJ3L05IaUdKYjBa?=
 =?utf-8?B?K05FMXh1V2k2SlhxMFRWcjZkeUcvNzdQcnVFRGF2Sm1vMUpNZlZ4TnQ5dDNt?=
 =?utf-8?B?T0ZsZzA0d1BSVHhmZHpQdmc3bFA3OTJ3OGJTN3hRZTZuS25uRWZkMko3UUV5?=
 =?utf-8?B?UDhwQkZ1a3ZPZElQelgxTzNHVU56dzlrRUpwVTJoMFp5MjJoWHM0ZFNQVHYr?=
 =?utf-8?B?aEcyYTdIQUl5SXVFNCtVYWFuRlRtMStydzVlcmNuN0RmWTFYckg0dzkyN1JM?=
 =?utf-8?B?YitiQ3dCY2dsM25laDR0eHFQRDlsVi80TWFmSzBnSFQ1Wlc2NmVnQk01b2c4?=
 =?utf-8?B?R1IxS003dkhuZVo4THpsMlZrYlZ2aUxFNzBvUStrWXZWa0lYOEVuR0FhQjhz?=
 =?utf-8?B?V2sra2ozSzIwYWVOd1hPSkQ0RjNmNy8vY1JwcUE2V2YzeVh1TE01OWJYYzc4?=
 =?utf-8?B?MExoSCtPbFBHdU8rUFZadk9XZURSZWtCN216ZjRzd1JFbURIejFTNWlHVFpI?=
 =?utf-8?B?aFF0aENZdHp4WlhHcmFyZFcxUFFoK05CSzAwcjAwdXRiMEs5TVgrYnFsbzNr?=
 =?utf-8?B?Tm1mck9Xd254aWdaZ2tXS25ROGtOTUhIYzdqbndQM2hBN2dGMU5yVFpDSnlG?=
 =?utf-8?B?ZkNUVVYvRk43Q2JpRFhwREpCeW4xSzlZaVNYUmJyQU9paklVL2JIWFY5dEhO?=
 =?utf-8?B?VU9VUSthZ3RjWkUwYWtWcmxENGlNSEluUW0xelRpMXB5WFR4bTEvcTFhWm5z?=
 =?utf-8?B?MnpvajNWcENMV1djcklGczJoajBiNlpyV0JYLzdXQmFYUkxVdlhnY2V2VEN3?=
 =?utf-8?B?aTE4YVU2bVZiN3Fpb0xjTXpWU3JBelJpdGgwdzlIRGlPL3QxV2NsRHhBUnNQ?=
 =?utf-8?B?Tm95SDYzbXY4dTlnendDYnh0SWZOMThWOFlEbUVxU2xLcHhYblY0Tm04UFRN?=
 =?utf-8?B?WU1FTkVyUHQ0UkNPMkJjUm9pZnZHWExRa0tTREhydno4dXU2a0JKSUZRU0VH?=
 =?utf-8?B?YzExNDQ1TCsrQ29oNFlxMmh1Tm1MZWxqV2g2QXBKS0tLT1FSeTFLZGhTZzlF?=
 =?utf-8?B?bGVlREhmUlZWemJreXNEanpxaTNENDNlREZsaVFtWjJuRU03cnZOeWZUMGdH?=
 =?utf-8?B?TExjWmQ5cXhOSTFIZndBcm1jNXp0RkhuTDZMa1lVQmwvMkRaSWc0azBYYmgv?=
 =?utf-8?B?KzJ3YVNDT0t4Slg0ZFIxQ1pOUDBYelhVYXRHNXhsRllUWEtqQjFlRitGK25s?=
 =?utf-8?B?Nng2eUtoUzd3VXhVR3hvb3lnakpXTnhnVFNqWWw3MG95UDFIY2hqTHZhTHdo?=
 =?utf-8?B?eGlMZmJtckE4eXJzemR4ejY4YjV2RXFaZmYyUDkzSVBFY0l3S01ibHFkNlJJ?=
 =?utf-8?B?bGo3S29jbjFRTWVVNVJIZEdTeXE5V1ltZHNqN2ZxTXR6T21NYXAxclNsRmtx?=
 =?utf-8?B?eFkrdFIrWTc1dmxoR1pEdHNXc0lyTW02QlBuT09IV1pUZDVMRFJTdGZsTTRq?=
 =?utf-8?B?c01aNTRZSndSeklKU3FMRVFGQVZaVEJXa2dqbWNTandNZDlOT3prSHNhaFh6?=
 =?utf-8?B?Y0lDYkJnQmZ6aEZtYnNxU1dYUE5oemtJYkV0RHEwVkJEZGNoWGN4dUw0ZG42?=
 =?utf-8?B?azJUSmh3S2xXNEYwcGlyN2Y2cU1CVGtaNlNGRFJnSmQxRUVDRGVPekVtYUl1?=
 =?utf-8?B?QUgwYWdqRllXMWFMRFVRblNpN1h6Tm5DUThkOG1Ydm43WEtBU3YvUS9uNERv?=
 =?utf-8?B?SWpZcGFhYkp1dVdIcHNjMTh6LzNSYTIxWDFnanl6UStDQVg2WUdXZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x2YoYGg1yh+jUotXSFTT9WAt0EPT8lBLxFI5rtB6yn6ElIGwJutI0Fpt4N8/fqfMeq0BkwWhSXe1WkZEfDEUoo1u/sKn7S2zQqEtqe4rrRwW1OYSymlVke8Wmyl82OoL731V7NhYNDN1e8LCYDscP1+GgEKfZV6XZj8Fc2LeJ5sTMhm19TkQcXXBF5+qMHxHa0qUIk2m5L2l/r+6WY+gnd6enBTOMGqCJXS+ZFIzyCANTtULEkwDbBOilv89SDCiRqvYNiCES/PbeK5e2JYJHmnTuRov/N4OU2H1IDdxcIdcx25kQqBvmvX+RVhU2QW0y8ik405gqQu3vV6C4D48kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32781a20-faf8-417c-0daa-08df0dd3e371
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:06:21.4855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6i5ocIB2tSVJaGtkVtvuf3pcC1OpE2A3HFjV5h/XCEVo6iK7aVZ/4CFX80e7FcLq5k4NcmPaJvZhdOkz9J7b6anILVlpNLZx1ESeF6Z/IVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjU0IFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
aXdsLW5ldCB2MiAxMS8xNF0gaWNlOiBrZWVwIFR4IHRpbWVzdGFtcCBzbG90cyB0cmFja2VkIHVu
dGlsIGNvbXBsZXRpb24gb3IgdGltZW91dA0KPiANCj4gRnJvbTogUGV0ciBPcm9zIDxwb3Jvc0By
ZWRoYXQuY29tPg0KPiANCj4gV2hlbiB0aGUgbGluayBnb2VzIGRvd24gdGhlIHByb2Nlc3Npbmcg
bG9vcCBkcm9wcyBldmVyeSBvdXRzdGFuZGluZyByZXF1ZXN0LCBhbmQgYSByZXF1ZXN0IHdob3Nl
IHRpbWVzdGFtcCBpcyBub3QgcmVhZHkgeWV0IGlzIGZyZWVkIHdpdGhvdXQgcmVhZGluZyB0aGUg
UEhZIHNsb3QuIFRoZSBoYXJkd2FyZSBjb21wbGV0ZXMgdGhlIGNhcHR1cmUgYSBtb21lbnQgbGF0
ZXIsIHRoZSBvcnBoYW5lZCByZWFkeSBiaXQgYmxvY2tzIHRoZSBwb3J0IGludGVycnVwdCB1bnRp
bCB0aGUgbmV4dCBsaW5rLXVwIHN3ZWVwLCBhbmQgdGhlIGZyZWVkIGluZGV4IGNhbiBtZWFud2hp
bGUgYmUgcmV1c2VkIGJ5IGEgbmV3IHJlcXVlc3Qgd2hvc2Ugc2xvdCB0aGUgaGFyZHdhcmUgdGhl
biBvdmVyd3JpdGVzLiBDYXB0dXJlZCBvbiA+IGEgcmVwcm9kdWNlciBhcyByZWFkeSBiaXRzIHdp
dGggbm8gaW5fdXNlIG93bmVyIHJpZ2h0IGFmdGVyIGEgbGluayBib3VuY2UuDQo+IA0KPiBTdG9w
IGRyb3BwaW5nIG9uIGxpbmsgZG93bi4gTWFyayB0aGUgb3V0c3RhbmRpbmcgcmVxdWVzdHMgc3Rh
bGUgc28gdGhlaXIgY29tcGxldGlvbnMgYXJlIHJlYWQgYW5kIGRpc2NhcmRlZCwgcmVqZWN0IG5l
dyByZXF1ZXN0cyB3aGlsZSB0aGUgbGluayBpcyBkb3duLCBhbmQgZnJlZSBhIG5vdCB5ZXQgcmVh
ZHkgc2xvdCBvbmx5IGFmdGVyIHRoZSB0d28gc2Vjb25kID4gdGltZW91dC4gVGhpcyB3YXkgYW4g
aW5kZXggaXMgbmV2ZXIgcmV1c2VkIHdoaWxlIHRoZSBoYXJkd2FyZSBjYW4gc3RpbGwgd3JpdGUg
aXQgYW5kIG5ldmVyIGxlZnQgdW50cmFja2VkIHdoaWxlIGEgY29tcGxldGlvbiBjYW4gc3RpbGwg
YXJyaXZlLg0KPiANCj4gVG8gYXZvaWQgYW4gSVJRIHN0b3JtIGluIHRoZSBldmVudCB0aGF0IHdl
IHJlYWxseSBkbyBoYXZlIGEgc3RhbGUgcGFja2V0IHRoYXQgaXMgbm90IHRpbWVzdGFtcGVkLCBt
b2RpZnkgaWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcoKSB0byBpZ25vcmUgc3RhbGUgdGltZXN0
YW1wcyB3aGVuIGNoZWNraW5nIGZvciB3aGV0aGVyIHRvIHJlLWFybSB0aGUgSVJRID4gZnJvbSB0
aGUgbWlzY2VsbGFuZW91cyB0aHJlYWQgZnVuY3Rpb24uIEluc3RlYWQsIG9ubHkgY2hlY2sgZm9y
IHN0YWxlIHBhY2tldHMgaW4gdGhlIGF1eGlsaWFyeSB3b3JrIHRocmVhZC4gVGhpcyB3YXkgd2Ug
ZG8gbm90IGNoZWNrIGluIGEgdGlnaHQgbG9vcCB3YWl0aW5nIGZvciBhIHRpbWVzdGFtcCB0aGF0
IG1heSBuZXZlciBjb21lLg0KPiANCj4gVGhpcyBlZmZlY3RpdmVseSByZXZlcnRzIGNvbW1pdCBm
Y2MyY2VmMzdmZWQgKCJpY2UvcHRwOiBmaXggdGhlIFBUUCB3b3JrZXIgcmV0cnlpbmcgaW5kZWZp
bml0ZWx5IGlmIHRoZSBsaW5rIHdlbnQgZG93biIpLCB3aGljaCB0cmllZCB0byByZWxlYXNlIGFu
IGluZGV4IGJlZm9yZSB0aGlzIDIgc2Vjb25kIHdhaXQgcGVyaW9kLg0KPiANCj4gRml4ZXM6IGZj
YzJjZWYzN2ZlZCAoImljZS9wdHA6IGZpeCB0aGUgUFRQIHdvcmtlciByZXRyeWluZyBpbmRlZmlu
aXRlbHkgaWYgdGhlIGxpbmsgd2VudCBkb3duIikNCj4gU3VnZ2VzdGVkLWJ5OiBKYWNvYiBLZWxs
ZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBPcm9z
IDxwb3Jvc0ByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kg
PG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmggIHwgIDggKysrKy0tICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYyB8ICAyICstICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3B0cC5jICB8IDQ0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0N
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQoN
ClRlc3RlZC1ieTogQWxleGFuZGVyIE5vd2xpbiA8YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+
DQo=
