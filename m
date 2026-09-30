Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB54E73D3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774441; cv=fail; b=cYTiTLtsfl2qsXUnhl8XAKHsv+L09VgeFtcXX96/4M/h50UsaIV1TRSrH1lfIBZZgfHIxXc0gWtLYA0FgnKHtRcrNsc94ikA1uPSRpcGB+SkWbht1JeEtBZpiWuDY8weF5BCvJ6Mn8F/vlUd58iqCplKg1CFmW1FNC+0obuzppk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774441; c=relaxed/simple;
	bh=WOdw+rT2/Ipm0xr3Uf8BsdkAHWz+HbHw//+WSp8OgxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YQUCbZKK39PFT6DSQNbjKdpHGSfw7pbwGu7uZWWT8/02LAjIr7VaawHSQd64hBDQn8fFR+2FyfIiKAKhwdwhplCjtrk2NXhGCuwDwvmIECYRgpCraMYDm5IgxIj/4KgRQCXBXC6x2CaJIS9sp9Jw9Zi88JIa3UyWNSX2XLHKwDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anB3sq2W; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anB3sq2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774427; x=1822310427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WOdw+rT2/Ipm0xr3Uf8BsdkAHWz+HbHw//+WSp8OgxU=;
  b=anB3sq2WYA7UpXlXpV7um4pZH6HfZzHCU0xqH7QZxWZ4aRbft4OZIIbE
   3ngC6D2bhkDENGYZhhR2nAlQcK4wgS4o1ePN6cNPn2hwe+jx6ReiRI1p6
   TYXq8IsKXf1V45tNQ4zrY8yi0F7Ikoe/mQoTLJP7G+adz5sWMN8kBc9As
   ja7F0HXHDuT/39K5iL1VpW7bperhh5wxl1eu+uZln+QmYVtlYFZourC/s
   iZrAl7qgsqwiS3BZxajmzyaUvPRK0lt1mRTPnyEbk+jUDz4EJaQvjOJGd
   ptXhuUDB9CwMkBS3M9kLiSeLHWyqh7DZYjK/kG808Y81vGU9j9mX+g1mL
   Q==;
X-CSE-ConnectionGUID: 7Z5l2PeXQXWBSXLbpelv4g==
X-CSE-MsgGUID: inPmozwvSwKBGnrRi0emiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79078160"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79078160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:20:19 -0700
X-CSE-ConnectionGUID: Oc3mF4aDQ0au4qpcjBhfOA==
X-CSE-MsgGUID: TUXhNlbEQgKLYk3SAA6y3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="301957153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:20:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 06:20:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 06:20:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 06:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9WXkW9m0Z3wMrDFwI5j767gg11vY3Dj+4b7/Mgo1YF9o2eqPqGl4ZpdKPy/htdzODmCXLpZ/T3atRD85Bmbo6y+V4IBOxO8MOFNVHu/QnXgLUsDA/LmVB8J5cRntrX/sMOTCRbAmRM7SCDFbsfhh5g7kTzzOsxJFI5z7LhSC8RC+P7bkaAWJL0O7VZbCcw6tKkKhkJqY5wXEdOZKugMk34zrH2yNh0BmYvDXzV/X0hK+725/KB/NR3mX7QoUZ6Jvrpa3Oz4npPnVPvjLK2HVEmmO9nu42Zat5VV3IjvmmpOHX+9g9rLg/lknUyyYKlIjS2orrsr3x2inUYjCmZ67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOdw+rT2/Ipm0xr3Uf8BsdkAHWz+HbHw//+WSp8OgxU=;
 b=a5faCvAwOw5qGszm32oKUkSFnWG3cta8DEGHNQgkaVFES2siQ5tJjhQUreL5I5WfrOoXY9H3GkS33/RtZyN9oH5YcKmM7XPkxcY4lnf3ujNQV1wzQq4CVFVeOCuj0LJ6w5BXn9ag8RHD/0Rzj37a3Qe+O1i5TyLa9ZWFcSVtxwwBCkGb5u7hkcj8qUYqvepwpd/YUtKcb1KfFEWus7ixZQCUFww+Ax33HXfy/Gg2vD84CYw1M53FTLc0FPGfMe1u5HuQvRAyg4+myrpniSpR4y8WMgVHSFKMMmDi5QHl0XnB1VYZsQrrh9fOWerI9xvYChGe/eHJ+zm2wa+CXBBKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:20:13 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:20:13 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"lee@trager.us" <lee@trager.us>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>
CC: "D H, Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "dasshubhamk@gmail.com"
	<dasshubhamk@gmail.com>, "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and
 PHY test
Thread-Topic: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and
 PHY test
Thread-Index: AQHdNEtqYt8GYD1sa0OXr4r713I2tra+F7OAgCk8C+A=
Date: Wed, 30 Sep 2026 13:20:13 +0000
Message-ID: <SN7PR11MB81095CC1A6D9AA8F0421F3D4FF8B2@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <20260825043708.1512634-1-shubham.das@intel.com>
 <a5c85a6e-918d-49a3-9a29-c0ce429fc9fd@bootlin.com>
In-Reply-To: <a5c85a6e-918d-49a3-9a29-c0ce429fc9fd@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|SN7PR11MB6559:EE_
x-ms-office365-filtering-correlation-id: 6ec28ce8-fb3f-4c8a-eba2-08df1ef58f6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: GZeGasxgu7tdfz++IfxfOAPU5XqgiZSRWgNrYOem5VDR5H+A2mgxqxqWb+dE0uOqnty8UmOccHMIVnwhekUXdI3Ydn1pN+gyfJJ2fN3MRfgFK6PxxyfGB1A1S52hz0lF7m+b7lyeX4YKhwI5p2Uo0RO4SuL7K6CXZ/1RLsF5Nrm0a4QyDhbdfqHR5Ts9nC3PfcaNlWTdl/+SvvGRL0eofNbXbg8R3Z5AHWVyUJXB5QJEBQgY3ukGBd+eb9eNDYSLAC5xK8JrLJruU0TSZxwX/+sDvlq3Ul+FEgD6Mr/8GwQvbCtohU5G6bTn/dkx6eJbmLZAB56Uts2mq1Y2A3kWtbZCh7X4Wk+FODW2szNuHXjgw6alC9bSrxgbe7s/A73LFj3jMjH1UR1IAPa7Cd+kxDTDcFDiI4hQRP/HVqC6mrlrG53R8+iAih8wh5lgknsSLB/m7vX9LA2WJ6G5h22h8EMGp3RmRZu5A0FOgg/CdMYPCntK2+pTX/EhQflTDjwSwDNM18VIc8y5Cwr5VbxwzJKzBNqzeJ/MHpnuug5EuhOCHtIrLX87mLWDuV2upObV5VyGms3/amplqA8m+XkO3LhAi5Mnvt5gKV4RPvpZw+2Arfvc5POJEcWYgyfrEAHTUlViv1t8wl9wqxbPAAALmehpVxd/q592G89R2zAWpI+94QB6HKUwMfrRPaACYkrdB8LTA5kolmSWVkT5EFG1kmAnxbF5cUZU7zLiqQusfBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTc3bnd6ZUU1NXhGRWNNK3RodW5lMnlFam1ON0M0eHkvQU5vaFhqcDhsbi9L?=
 =?utf-8?B?YmtBbXU3MWJnVnpyVFNGOTdqRXdwdUlCWkhNUFZZMjQrblVWbHFERkRYUy9t?=
 =?utf-8?B?eHdudndoUDA5ald4bDNYaHg4SWJvbDh5QXVhc1N3TzFreVEzNmFDZDZkMGxT?=
 =?utf-8?B?dEkrcDAxNmMra0hKbWR5a2QyNG5sc084amJ0Z0Z5N1lsOXFOZXpmdDUrMEhK?=
 =?utf-8?B?c1AyRDhtaDl4RmVBcVY2YzZiUmpvcGgyUHI5OHI3bkp2eTBCSnVvOVRncDBv?=
 =?utf-8?B?a0c5bGdJS0p5OGxDZjJ0SENxS3luR2lJaXRzRGkrUUFjSFpXN1ZmdG9rQjhK?=
 =?utf-8?B?QWpQeU9GNWJYMEJqdlVDWFVaUTV2VDhETW9ON1RnNUhabFZJMVMxd0ZFRmd6?=
 =?utf-8?B?ZkZ3YXFIeXpKeGNVU2NnNXczWlVtQ3N1RFc3SWRDWDZYSHhVQ2JZdTNmdDNw?=
 =?utf-8?B?YUY2TmVkamZRaUx2RXRwWDNiSGpHWCtVd2hFSGgxRTBpQzR5OERPU3R6WmJK?=
 =?utf-8?B?K3dtZEV1Q0J2ZW41NkV0RG44T0FOQjJmSEwwbXFpcFNYUlZudWprVnMzbXVw?=
 =?utf-8?B?U1lNMHk5U05SWDduQnZJblByMzQ0OXNyRDUwdlVLblRqUWRlSWU4cU9NaUIw?=
 =?utf-8?B?eG5FdGNRZXhQeWkvbTZFemVnczdRNkhaWFlJc0dQZjZBaWkxODVjQkJuTWlv?=
 =?utf-8?B?eC9tZ1RIR2syby85T1FSRGYyVUh1ZGVuRnZLMGZXb2sySlkyUUhrRVl5Znd3?=
 =?utf-8?B?Q0NTV2dmYzJFdUNLU0lRZXdUVDhuZDBzMVRCNG1QM09sV2Y1L0VLelh4bUx5?=
 =?utf-8?B?N0sxNE91RFhwQ2tEMVBENjkwUWNlaStPR3pUNXdmbDNFRVdpVHlrajFFZTNQ?=
 =?utf-8?B?TUVjR3FtZGwxVmx3ZE13bStwdWZkV2l2Yzg2QW1yZGlMbWlGaUFZQmVaNlZU?=
 =?utf-8?B?RThOQWZJbzVVUUZyOGkrN2NlMk1ZenlxQWRWTHVvUlZ5YWJ5NGxBSm1nVWow?=
 =?utf-8?B?S1hDdWE0cUxYbERyNlQzTkwyVUtrakh2TTdWVGZyNmsrcnlLZy9tUmVZV0RY?=
 =?utf-8?B?MGM4NEJkM3pkRUNhVnN6OW1KbHpaYW0xYVowYVdEY0xaV0NCcFJ0SnBkYXBx?=
 =?utf-8?B?WFVQTy9ES1d3UUlCaUJTNkhEM1pGS1FZU0pLcGNpNUlKQUQrTm9hRE1NUlJ2?=
 =?utf-8?B?N1VJTUZNZ295bEtDK2hSSXM5VGtSSTlOTXZrSi80dE1uZXFQb1U2RENTKzI0?=
 =?utf-8?B?aVRHVll0WDVGdDVZWEtjUENraUhqNE9SejVEdWZCWWZ6Sys5UmxOeEJWNHdJ?=
 =?utf-8?B?THAya3ltcVpDR0pod0h6MVdCR21kS041ZVcwZGVFM21sT2FHYlhLT2kvc0E4?=
 =?utf-8?B?TnliQ3hFWVF2WFZQek5yd0JTTzdjTkhQQWlOUkRzZEZOM2k0aER5YTFFbHVU?=
 =?utf-8?B?aVJteUpqOHIwWXY2U2VBTmxPcWxzOW8wWXBUTThvMit5cFM2YUVaZ0FRMmJE?=
 =?utf-8?B?QURqVDMvMDNYNWF4NnRTNUJOdnlRVGhGL0t1dzlqOGpCK1h1M1VxRzNHdHZP?=
 =?utf-8?B?VUV1UDlrcmZYN0c3NUkzTnVZSDlXWkw5ZmJnZGZuZzJNSGlvWFJRcjc3V1FR?=
 =?utf-8?B?Y3Z0bVd4c1p5aVRseGIzbnhwTUE4RitGQ0lxWVNRUXQrTXN1QVF0N2E0Q1k3?=
 =?utf-8?B?SlNMNlgzQjdPb1phajVrRk1ubXJsNHFCYitBUW9qcEd2WHg4ck1NZFVMNDM5?=
 =?utf-8?B?QkRFQU1GZGRINXlROGJuWmxRWUhTZUdZT2xzd3ZORnNTVStYRHlEM211UnFx?=
 =?utf-8?B?R2prM3VhZElLd3NhRnJ3Qm51U1RucytuSENHa00xdElsUC9ibEVadzkya2pC?=
 =?utf-8?B?eGllUHJsa0E4aGVrTVlqMTY3MXRvSDRpWkY0dEdzNnN5elBKV0xHWERjeEtX?=
 =?utf-8?B?c1Q4NDREMm5FN3hjV0FzMDZrYVdQcExYaW1IMFJKbkZhOWpobVNTL1BsSUpX?=
 =?utf-8?B?bXZLc1RLSjBzWGVteTQyTUxVZjRhYUMzR2U4NThaWWs0N21GZW15N2dvdC94?=
 =?utf-8?B?VEMxTDFtaWp5UUJlSTNNMHYvUWVVVjJPWTVIckFkcUEvcDFvNTJhYUt3NFd2?=
 =?utf-8?B?VjUvN203M3k5WHkreDQwdk95V2NIQ3NocmdjTUJHbzF4L2x6cy9FT0Rma1dq?=
 =?utf-8?B?V1AwVTlYWk5BU1NDMml0ZUFoSXNWQ1dNTTR0WEpwL2UvVk5IVGZITmE1MVFw?=
 =?utf-8?B?dWpJUWREemlOZ0lML3cwbnduUkZxbFNHeUc5WERLME9tOW0xaU9uL1lhNEYv?=
 =?utf-8?B?K3hDY0FiajdoQ243ckxtZksyMlJtQmR1T2lDZmxRZGZzcW9zUzloZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xjKtYxwkIVkzGjie5KczcP+XM52oxBFxRjjXbOh+PPWC4zs3yNw0n3WCM53jU6iUlknTRzR15e5OYAMHgneqwhoWz8jfCsStO/cHRv9rA9b/bIfJdhjSGc8Hz4oYpEvp64W26mSYcf7MWNVLA2T1FKQJWxbn0VKmAsl06xQMlAvWg/ZaP3ELToSPXEl1YWh5CsVRQ9MJ9E9V7rGnIwxHJU1FU+JURwUkmRcTjeiNPCCHX/a4YC5z6wljzKAUcQTECgbcF8EzzshC+AwwOG0dEgwPOitiD493wrOWH80RkhwsV7nB9CnjvTAHsKa82s50O+y7dgMIylJZXOUjzi0kUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec28ce8-fb3f-4c8a-eba2-08df1ef58f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 13:20:13.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zW0BL74PO7VY1TmYq9JNzYwHdt8vGc+fXNus24XQqT9EbxyPtSLIZTYGwwy+AI70YvBbNzfcZe5CzGt3wUovoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

PiArQmrDtnJuLA0KPiANCj4gSSdsbCB0cnkgdG8gZ2l2ZSB0aGlzIGEgcmVhZC90ZXN0IGluIHRo
ZSBuZXh0IGRheXMsDQo+IA0KPiBNYXhpbWUNCg0KSSB3aWxsIHNoYXJlIHVwZGF0ZWQgcGF0Y2gg
c2V0IHdpdGggY2xlYXIgc3RhdHMgY29tbWFuZCBhcyBpdCBpcyB1c2VmdWwgaW4gZGVidWcuDQoN
Ci0gU2h1YmhhbQ0K
