Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A99595737;
	Fri, 11 Sep 2026 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160332; cv=fail; b=fZSyJys8rssm+4JAClgz/0GEgDJexJp7cbDWq7LOZmnpfGWmcXm3UvotxjWNrp2IYkIl4/3mlJuoLkHBp6sNFnskgBZXyNLqXayx8hw0Rf9jOFYbAHlG+X2ghIhe4EO8Kf8tJXWX3/YuawrUZucPtkb50Sl4ZLcoOVMsF9ZAF2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160332; c=relaxed/simple;
	bh=HkYAmBfTj16MreBfnQHHdXfXjk4mBKQAwGomuFZhQtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxuBxbgjT5zVJ41xiK+/McCPhpLmq3nT/qoPfuuzyaOT+XjE+j73Gu9/HGvZA9mbv89u9bmM/gWIPJohLz4VksFUFRtGHu2lwUIkVH4K59q9/ph/28YdBUVwOG76bM4+azvMHRXBIM3xuB2I2eNqNakaOiPqlYu5bXfF5TWLNUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H47Xjv5I; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H47Xjv5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789160330; x=1820696330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkYAmBfTj16MreBfnQHHdXfXjk4mBKQAwGomuFZhQtI=;
  b=H47Xjv5IwTRdqfoq+aEihqb0jRVyEkpBPxZ2ji02fau22jT1vb1ewJmo
   R5JbiiinXjTTvFOnJtD8hdQdgGERZVIdamGLXehywGTp5lW1N57fJfM60
   jjeDdIDRRCiSeWgwwipXNO5w/xNQb8jjxFnjonZNgeAomlUyB6PlKLF+g
   NPzJ3ET9N9YlUfw7HKw4zWKcxMVO7gbu8zFPDAbvkQORNjMlmAydzAoOw
   ZsavVtE5OuXAbIV/lHwnfBTgyhp7CVZWkQxSdch/D2UVjQDJJypu4/7UI
   +wulkyNf1nh3E0S4ngGm62mmP4Iot/FScyXlYNtabm5fZBxKrStEE4w5p
   w==;
X-CSE-ConnectionGUID: KcttGwyZT+WI79mAPSKEBw==
X-CSE-MsgGUID: ENxWqaTeQUixJ6lcIKlYeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="139033"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="139033"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 13:58:49 -0700
X-CSE-ConnectionGUID: KhpI2OeTTNCuKQEFLaa1DA==
X-CSE-MsgGUID: SvqlxD8XQwuDK0OKQ1895w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="275776311"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 13:58:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:58:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 13:58:48 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 13:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuo47D13QRWWZMJsHNB7k3sRfZ+H6+n74VN/+kvKKNTrcZU63ZrxS4hb0+bERU0OM/dAmSDACwhVCdK15+5WUavVw73Cro16Q6826BW7nD/wtJMZObsYQlnTuhhBilTrbISmcvg/JyauVtIXBrQL6HW2ME5IV1cA0OT5+bMXXMw0wE8VRVf2hwdUadB8CyQ0TxNB6lAD8oU/+Qmr7+8SgOgRyA6Q3b5WeSSUZInGHITGkOWtg6YHe8iImtI4lGZUmgvHmN94fNawr9Bg7yxt7JTkBsZiqkMGyGx7fHlwIDNQlX0VtN+61lgtzVYIt9aAvqR0IfVIGgb7A1g7+5Kxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JlIkIlpjrTN90R9Is6cubeB5JH50gTEsMoDrJBewAc=;
 b=H4BL0Hb7D/fy5X32NWqlQR5otjRSAXSGe/ztQ/ppX6nQhH4lzuhoO0ZDbWyFf3ewYtNxVTuBS3NaOxq5rt6HKwKjwc6zORc20yY1O7kuFpBbX7uvqtF8SLqu4RoCXoPgCsWTite4oGUSmUiLQvaTzx/j5E/pn20DnI+DjmgS1GMkvjloM75Da6TZpEkRb5/pUANdYfuViwNzA6w2ygilW55ZKlQ9MqmXYy0AWMj1iUdN2OQWtIIfKTvCKYk6j7JcjJGor0ZygzAB+GxrzenyT1g+4lPRNmCrPDbDklHsp+8oa7GG7qKFYJOtYFGxA1y2TE1RA22vl54bDChHNxWvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 20:58:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:58:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kneuper, Paskal" <pkneuper@dspace.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "Baldin, Daniel" <dbaldin@dspace.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kneuper, Paskal" <pkneuper@dspace.de>
Subject: RE: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
 igb_setup_tx_mode
Thread-Topic: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
 igb_setup_tx_mode
Thread-Index: AQHdQTwNXHtvnPkMFkqfOhhn7s17ybbJ3hrg
Date: Fri, 11 Sep 2026 20:58:44 +0000
Message-ID: <IA3PR11MB8986DA5A1264AE773B12F27FE5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260910113854.13279-1-PKneuper@dspace.de>
 <20260910113854.13279-2-PKneuper@dspace.de>
In-Reply-To: <20260910113854.13279-2-PKneuper@dspace.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 7944b616-a88e-4a62-5306-08df10477787
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: WgwMUkZ6zG8pzCp6LWFnampoiLq8P7sbSNNNEm3CQa91PeKKglS9nKHyjWeOiCoM94aZtwU8KwFGVZx/HyLrN7ajSo0l6aFHz3rHCzQkariNaNzAYXt0xzoSiu1Jfrf4G6zx3SaNZguchCiVJ3/e559aINBBnXvWshjyA2pSKvL+zkdyUihJMuWAtmn2xBXlCZDozqLj95JwBK/JRVNVNZjOIUyd1os5C3Qzh5AKv/dLoSauwbYAQ0w9BzHLtM595IQ50MpDJN8UOEuglHqmTk6SW3serb+4PzhM+FNv9B0IXtbHaoYc6nxmPLcbYH/MKTQ8Xs+823TPuCaqNZPquglTE8qMIH/A0TFBXAP+FGQHIdGkhjrybxn/6nNjF+lf7TygoipuHxa0qKYatmrG+jj6Za38TpByOVxt0e9Sgb3nT28TFsLIsl3DRqmzrWQ6zuraGz5jji8pgnOqCkpGd10WkzBti0NdL3r5PUZNFzpXRD0xygPUB/oN0HFUpOdUfLdEOPOJd7MJP3daK3JXdCiI+tIkpigYCXdOnOE9BRmgWHkp9R0f4SDAcwbrK2LyPqrfr3s+TiHeZOM21600aCLBkaeqWtGGIBVuE/HmLSOMeG2t0EfAdLPTtaIzQLayOXmx4nuArrTxLyNKH/0Y5Q4+2OlzgKLSutBMve1NUf9mmRavKeNw77Y7PLERO18/HyOgrbanIfEWNFja80xvEKV0oSDqg/oJzefNacFcn0+UBGxZ0e39j2lC75Pu8/Dz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oI+EvIPi5eTEtV6P2Q9OdAPmjVCtetsWB6nBhTNDwWT7rUCMU+MJbuCgR4EP?=
 =?us-ascii?Q?i8GnJ2lS6piiML6mopO1r40BY/1/CWFt8oLH6WHT9CrdI9Kyw4Nwp6o57ai9?=
 =?us-ascii?Q?0nMTq4rTi6WgjxpAddlGMvmsdGr8g2wWJfab5oT9Wh76nbgZ9xhiXv8DiPWo?=
 =?us-ascii?Q?4oCkza0m/iD+7VEx3pb5gKvwTxKEemOLYZjwP39REDKQGM+5aWZ7Vsz8uOyx?=
 =?us-ascii?Q?VhC5BGZUHdz6gtf3HUL22C+7DCtOl8IWhb6dTUMCGxuYw6b6NuWaSAJvMkrr?=
 =?us-ascii?Q?OVMx2PoPSYZhxqJSblZpqk4YVacDmXBkpnA2oXkD2Rvuf1kHLyD+ci1qkSnw?=
 =?us-ascii?Q?RlWCDuLEfoLhhbY/zpbN//K351sAX5ElUSRzDbPdXrlHznFeqWqTuesVyEyj?=
 =?us-ascii?Q?m0tXOrvBEMAp6Yv2lnfoM1wwKwABBqqdo3Xoqk+MjKzoXFUXTo75w+HQFKCB?=
 =?us-ascii?Q?H7/ELlHe/cBMj0aeeneQVY6VJQPAAY2R5MjC/7zKhOFtL2TpEycMeEoljKDE?=
 =?us-ascii?Q?YZfks0rQvEWUtgkrVmC9Bunt8v3DwS110hVxtmTYE3S0hSIv1hei0CpV+F52?=
 =?us-ascii?Q?79jXhzLo1U/yurTa/R4/cjxC9nRcYd96m6xMIIBm0BoqBnmwnRd4tZzYqSvo?=
 =?us-ascii?Q?rF+Z8/Wgsz07iVLtoQiDNsZC4QHqFzvjZhe7qwXFtF2n+s6fvytEIij/30Au?=
 =?us-ascii?Q?k6efXx2vcx63aV/NM5ZzswGmwsCyZDgatxG8bkYgEgdCbepk7U98WnlfYudl?=
 =?us-ascii?Q?9fihhGnPogChAaPbIMVvfXbJICtM0JuPg65EFAGcJFZDsDBuDgdN9nEYD/Ys?=
 =?us-ascii?Q?VUeVMtlFffllHEO5jiya3rqexB6ndfEYMZmYWJawhn6hSyjWKE3wxFnsi/ZJ?=
 =?us-ascii?Q?n0s9F1/yMw61KcTVaZR5fHywoiWQRsp8/MTPZU3i4RlRMiG2P7dVvaq8CQFU?=
 =?us-ascii?Q?yBnX9tWKIy5XNfkoGOe2A5YRHlW7pbx5ZtenLOlRftoH+MwpkblXdlNJe4fu?=
 =?us-ascii?Q?SQeEumeUuUN1lhlBknLj0nay/LBbl74Do3XN6RvGcltp7SffJyEIpdeGu1i+?=
 =?us-ascii?Q?1Y29VkDtULbMjZgBZFR7PsiIINVi3i4TrsMb2fGpIX1E9ko8q0MI7J77e3vm?=
 =?us-ascii?Q?UIdgWlNfXX8XNs1MyYNuzndXn2QnRZ9EeWT8R/6AIjZ8cCguqrjTNUcFQ76V?=
 =?us-ascii?Q?c7kDNLbA+ntWjmMzrudHeSUWbWvjOGKPUF0c8HO5f1pje2AAVMusT4s4m5hb?=
 =?us-ascii?Q?eFJbP8j/F/GKUicX/N2fQwqJhnfRunIDMLJbcDfD1XQ+rP9C1npEY5JK4UEp?=
 =?us-ascii?Q?t6oLqulhlkEQUDoooknoOjsGaRbJ7STQzpPH2x3aJTjiRfEvuu6MlcL4bUKn?=
 =?us-ascii?Q?0QiA1If/O/tmLLhft47biureEDWPQYBfjIrzJMXqOFLTk0BrGIuNI8x6BYJs?=
 =?us-ascii?Q?PqS9Y1rSUyIIetLpdIPVEeuUvsjB0x5CGvpjKJgRWsshwrbnPE14wq7uUx+u?=
 =?us-ascii?Q?ahdOqoXXUAT6bD7c8hL87wWMuWpr0/CiXA98lyPQIlPsAyNtMU6dxxSqRvm5?=
 =?us-ascii?Q?qHN5OsHmI3mbNtEIBxHJj7ZtHHsOuWGGEU0k2SRPBXNBUNjCV1NcWxPOnfAV?=
 =?us-ascii?Q?sX7d4q1PWUP4kxK85fe5qObrWSXSwDeykJGl6rNKffiSRsa1l6U/SsJm47Oq?=
 =?us-ascii?Q?zoDuAggfw9aqHHpApdvG7ycNqK5dYawJnAPwKjl34gfqxJvZZKjXzcNolVZs?=
 =?us-ascii?Q?495Vv3F6IZwSJC0GJGdg1ho0fnajZ54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ICsEEaOmAlvK+TVMkU5legxSyQMH3XE4C3kisj2+oAMUEzormP4idzGLItTH6I5xD/A8aUETx8u/cwfzkmggH0Nfjj8yS0CxjMOgs7JfcoVfWm07RNuZJgovPb1mmlivMxrR/XWgDV5FoVOdtqxMJtlKoHwyiunn5AkPjMEtg5WpuonXF6oJggKJ9wRe+zOwKqBYIDt7l0QJuXbFrePEsSbAvauXkAtRWslsm3qPLOWiifqetLNr7ekpd01oTE5FnUTPR79FcOUKyRU4IYlXPI5DacJeOFZOZZXS71VT6IEqkrQ8SLIcUOfXvsi8AeKTBaAqXwJRgtJKj3x5PzoCwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944b616-a88e-4a62-5306-08df10477787
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:58:44.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyoowArJ/5N15Tf/mBAMe804d/WubSNYxqi0WGp1S0atOLCyzqbeWDkEa1DVHrQPh7qa6JGqzxBXQf9ZQ9O6DFwRWD/O0CN2F73TRdLJ7RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Pascal Kneuper <PKneuper@dspace.de>
> Sent: Thursday, September 10, 2026 1:39 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: Baldin, Daniel <dbaldin@dspace.de>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Kneuper, Paskal <pkneuper@dspace.de>
> Subject: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in
> igb_setup_tx_mode
>=20
> Commit 05f9d3e1ae6e ("igb: Add support for CBS offload") restores the
> i210 Rx packet buffer size with an unmasked write to RXPBS. Bit 31 of
> RXPBS is CFG_TS_EN, which enables per-packet Rx timestamping. Writing
> the register unconditionally clears this bit on every igb_up() (link
> down/up, MTU change, or driver reset).
>=20
> Like other drivers (igc, i40e, ice), igb intends timestamping settings
> to persist across link changes: igb_reset() calls igb_ptp_reset() to
> re-apply tstamp_config and set CFG_TS_EN with queues stopped. igb_up()
> then clears it immediately afterwards, undoing its own restore.
>=20
> igb_ptp_hwtstamp_get() returns cached settings and never reads the
> register, masking the fallback to software timestamps. On an i210, a
> link flap increases PTP path delay from <1us to tens of microseconds.
>=20
> Fix by masking the buffer size field, as the FQTSS branch already
> does.
>=20
> Fixes: 05f9d3e1ae6e ("igb: Add support for CBS offload")
> Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..0f3c728a07fb1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1947,7 +1947,12 @@ static void igb_setup_tx_mode(struct
> igb_adapter *adapter)
>  			igb_config_tx_modes(adapter, i);
>  		}
>  	} else {
> -		wr32(E1000_RXPBS, I210_RXPBSIZE_DEFAULT);
> +		/* Preserve RXPBS.CFG_TS_EN so Rx timestamping settings
> +		 * persist across link changes.
> +		 */
> +		val =3D rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN;
> +		wr32(E1000_RXPBS, val | I210_RXPBSIZE_DEFAULT);
> +
>  		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
>  		wr32(E1000_I210_DTXMXPKTSZ, I210_DTXMXPKTSZ_DEFAULT);
>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
