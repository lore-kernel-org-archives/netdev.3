Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11B54CF5B;
	Tue,  8 Sep 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872848; cv=fail; b=cHYenFCXte2dlruNJaYSrz2akHH2W6eKyl3JKPmOZxIXJJTNG+F/jlORXYVM3vJwFd/aXGI6wWWaCtaQdy6QLAL7/qBgkRCNEpsChd4lXOFo3oIKAYEt7oukR6sElAF1oFjUOhLAVbqyQ6MqbN1YO2A7qzGY/6jZ4YQJjIvccVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872848; c=relaxed/simple;
	bh=POOKxgJsUUFYha5vIM7EQKqz1z7UAuuN3pR7wIxpPB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kOjQ1YI3j0QLjqU+uyP2l/1Bgx15e9LvCie+Xyogh8eMi4QUuyK5I+rauHbV55UB3lUetJDmoTIf6/yaicpHajaGTPf3ika5hoYkFKjPiEAJ/+miUzv3rkWsj9zGrT/S6u8voEnW228EDIdfTFknOKMSKucjyMt8xxy+yY5M4tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aD7qZrWL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aD7qZrWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788872847; x=1820408847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=POOKxgJsUUFYha5vIM7EQKqz1z7UAuuN3pR7wIxpPB4=;
  b=aD7qZrWLmfbla9g+A1M470Wx/UIXxvSdnmJVqUIQZyMNHQcdCfKdGI+d
   eaWVGDwIb4LjqpwMUZEaDx7tVYMAjjCxI4cjsMyZTLgAEPzVdQ9LTMXYQ
   PNLfsw9w2em0sbaNfo/U2dmzNdkq0SukUKkbktmrxdxdKYmKQFSZX9wfU
   e61YJFb3TvgiZEZ0NByJHhtEXM+gCXA1t2tQz8FpO3oo+rF/w3e03oC/4
   4sgCih2zsMEoSEQcc1yQax+3DVPxu8eWWKw6c9Xku3EyEPeoJsFvL544/
   +xmSkm+thVHER1Riu/g7AMzFrv0r9jvmWzs4F7yHO1vFgj2USQ1YoCP7B
   Q==;
X-CSE-ConnectionGUID: 09BrUGFAQ7ObxpuWEpwjVQ==
X-CSE-MsgGUID: 7o/xFT/xTZ65kPJKYs5ahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114813249"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="114813249"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:07:26 -0700
X-CSE-ConnectionGUID: +Upekwa0RS+nyKr4Hh5xQA==
X-CSE-MsgGUID: wAV+yjK6TYWU3tpwkrhxvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271506592"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:07:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:07:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:07:24 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRc+DwtgWKmmPpWjp43BhxapZKezAHp40mEoDypJnWU69yHFBmHtJORVSoQgabVW8oPiL5N5tcG/HOC7FS9cz2QSpzwXzACYsbILVrhw1Hhxt3Uqakgg3U1zP5f2BDO44Tdtt1hBNSKtmy4Hnox+uCJdSzFuMzeoRPi6uZv2gddcE/u0X9VBbSWLCb7Zarh2XsMfsj9dPdDIyxz7hBU/5NKzVZQcYo3LroE+YYXya/Vv/PCd5qLukA7tgXJS3dTynILSNtfcvz4tji4oFsF6NvdVIBG+/wtZOKvlzamyZ1A0uLnQAIX2pdWfLD6LryCVM6diQW8gXF4G18kzc8SiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn/pqiTgB+0CM+j+7k+gSvNGHZkTUqjTJo1fPIlN5Ss=;
 b=HYLlNPksXXe8r3N+naUdIBrAu+ZFYHfIDZRxhoq1pUaixPiCcr1M0Ef9PcJTIjjQNpf6ws8G5DCAHyUyh5b90VsT3KxQ5ovb8q0knlsNLCQy/PELn2DM4X7gDM13PoFLlappz1DfWQSXW2GP9cIU+UxcAy61Yn0380zOiL42t6fGf58XW1SLb1fH2dKY3Vao+XeCaP5zpMcaEMGpiFbpca6VO7F1ZKyoOF37RnwcNASSWBZ1+cUZ9M1gBJFsgG0wdrBMQprqaHwZaITm21fVSPXiZj0mbZiFs7vq7rqJu3YQmuzwzL6EvtjR1uKOlhQJloljnoqtmheOBVH4E3xsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:07:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:07:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 6/9] net: avoid copies before linkmode_and()
Thread-Topic: [PATCH 6/9] net: avoid copies before linkmode_and()
Thread-Index: AQHdPxOMIVgvx8ORCEudfNIrLpVrCrbEp7wQ
Date: Tue, 8 Sep 2026 13:07:17 +0000
Message-ID: <IA3PR11MB8986C95AB016A1E2C44F9758E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-7-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-7-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: ac62d731-663c-4096-9638-08df0daa1c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 1JITwhbqE9GBJLsy3hGFtNglirbXJoz2p2gPYCLJkhc/cRlKStJEiCP/7xGJ5N/eb1YtMFRCrvCyx/3/0jqgd2Zne+QddObW2Gb2CRN8xWgDg4UzLxSOGIAVupUuG3C3QxgBPX1aHt2aOqvmMOaBiywvktQ+o+hWpJIOOHW60Dr9ip/MOlrJkPu4Ws9JUda1gQFAY+ptK+siI9HAstD6A9dnQ/9rhfcqwBgCB+EPm6C98ZnuMEZXRnGwapqAbnazV/GX4dLUz+FUHJxlJ+1pv6JtyMhHSDWJE+gKfpGZO7W5Q/U58D6Ruv9nw89M7M3azfpeY9BAhX3awcFAfqvIXPIrkVh2HfCgesf8QgLlH55E13fyC+lqtxjRO8BNPsrzJBOejx3LxYoLHzeODCGfQXjzTCp41t0VupdB5BII986KETkIph+ydDjE1Xahdd9nbleNy42GAsp4TevfU9Or/G1lpZm7eg0DuMsEWMeb5tCM504o5lTuzrHVQyMZe9Ar7v2zUdSv1jrvC3qmZIg6LbnDDp8z8au6BXi4uiWQoa/JoIew9dl5t2gf3jg6KTQII3Cd351G8nBhaj4gWmRAhhL4dn6ICGJKMD8ub/CRUoCeHSOlZ7MCZr6oIPVSjkGEag5ipdMAo1s5moQBi+qtOJKwGD9zJrrbi/GbvFzPssa2CxuTCut+vR2I/qMkF9R/51BTVkYscATVzv3eSPp2pT2uG3FZJjx/8V9nV7IYYHxKsqOo5MkeKrkyeXUrasFI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MY72Vj6A7hTLI1Aw6kx+GrJP1OQUC260M7QZunUjoWY/HWtkZ2kOgzzCkcPs?=
 =?us-ascii?Q?e1Mi/rAdhv5O9WR1EasaDByZH7budfPmfFX0zr2hlxMlT0QJ/KZYcZQGpNrY?=
 =?us-ascii?Q?K7GdhMBP10Yv43EhVmH4p2DJUmClmNjLC5aoX2Fvc40qPgY1xiZkhFQo8W9K?=
 =?us-ascii?Q?C1gfql/NvwirbIJZLnUPvVW26Z4cYRBvIo6dTkdxPWVyO6iokFkr1XPS7ywB?=
 =?us-ascii?Q?dEiOvIuPmXfxZIdhCdXbJYL4Za4BafyhN4/T0WVMQ0V75+WGCCsK9jzx6KZp?=
 =?us-ascii?Q?iyGaNNyx/EdIrI9D6VWAzjKXpBqnhiEP+hMa6yiAtqfxgv1kO0/74AR0fPos?=
 =?us-ascii?Q?FN+M6/ptl6w4PCGi0gTU8rVxALlwIYwWLJ9qVq4i4VYL9nKi2lPjqHZ55YmI?=
 =?us-ascii?Q?625K8UwQ6Eq079MSI3/s9FmCxXTw1+ipuxttNpQSP5o4niZA1BipOv1EJu4z?=
 =?us-ascii?Q?0ycmhgUxaZsIlJdW04IaalLoL6lbof25QqLffsVa0E4nT5OUIMU47jAUDBE0?=
 =?us-ascii?Q?fmugGYyq3lG2qJaOqTZhEl/uBAbQ8JlGRuXM1yE4fyTWmgfQGLjtrQaNnlH0?=
 =?us-ascii?Q?7jEDVaov6h2x5eMTgcHhndXmkcCur+vq+1XejUzsjdWUrECsBImwiw9ZRNHC?=
 =?us-ascii?Q?3hWgEJ/9aYBVteo5AcT1YyYoWBIT8f+RK+DTm7GqGp1CRqmf9D9R4E6smlIr?=
 =?us-ascii?Q?V58wg963I4glh5b51ajXCXrIZLYygu/n8XIh7ogu/8RYMNH1rns7G/7+Gr6S?=
 =?us-ascii?Q?IsESi+ekswaiYgol8EsUr6a+BW1lU8mNygAb5I9sD7NWCVXwvJh5q4UeFm2o?=
 =?us-ascii?Q?e05f7p94hHnVjt+rupftuXZXWN7xbjHOGJezEYyDPAA8o9Z/paoW6jSCt8zW?=
 =?us-ascii?Q?JBuLVYU3HD9lV1UiW+B/d3Spvd+43z0X8lDXGTymGOxc6/FaADC4eQcD9DN7?=
 =?us-ascii?Q?P+oT3ysLmJANqxSAQdvyzeCy4yyf/KQfhkVXHHQBGVfLjUVCzfpfXA4vvwte?=
 =?us-ascii?Q?ZaPRg2F7TXdUQ2fXGEbfcupc6O7SmoXhRojnPP7CzTO6eeh9RLBjYqFVF8pc?=
 =?us-ascii?Q?eEnvwtRBYkFGF8uCU2rzxXcXXPNdaDvuGyZxWlVfuAuskl7OPsDciI5fSMO9?=
 =?us-ascii?Q?NNUwj11ny5pyFGHjGEWh07ZfPIhmEhSlntWs9V1/e0cZmCwCrIhAppCfoR8B?=
 =?us-ascii?Q?z/BZAWqXc2OZXgsyktXvl0jA5IMjI0ASAOewz9UPuwNexWhgpUL3nKurdRDA?=
 =?us-ascii?Q?Xo/Gd3O6PueWNZS7pcz4yaxrPOu4IbL0hN6Q7OlE6y9fjKKYQ69hcjfUzFfi?=
 =?us-ascii?Q?IJqhEUypa1G5e46+L3TQe4s4OSvg2lIkZ18/BqZUF6qUjYY6vpFbNNJIRe1I?=
 =?us-ascii?Q?tswx74k6SpP8+wWxR53+YiSvkjeT/F6rplF/Yw9K27pHrsyohmwutbMs4e9+?=
 =?us-ascii?Q?cxpvDveIdGqoYoApjDMPNGSrcwVCc7HKgGaXJWz/2NIHoAsP7ErPjbIIjrhM?=
 =?us-ascii?Q?2DhLTFNm3RRplxdMvD5rsyUWgkf9Jd5i0ldOeqRm6EvqBX1PKheGAi262iZr?=
 =?us-ascii?Q?xE8J+x8M1xZ3ODbam+mfjibfkfHHxe3xiFUxUUfh8LoHFzVxABXoHwsueNhM?=
 =?us-ascii?Q?HsBuV01US8rZ3M0+ihq+mz2LEyq+p9I1WJuxMk4/BYq2SrTQaEQMn0WU2X6p?=
 =?us-ascii?Q?YIxy0YA0pT+01LLveSaaDrd+GSQO97u9JBJHjkXkcF+YMkTCzOO+NluCJeE8?=
 =?us-ascii?Q?6dKoaPSPlk4v2DtiHYmdHVwXLTSyT2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tPpRNZsL7ibB5H6qbLmY6+ijjECzM3VXincEaIcD9IwiaTHikE2aGZUWZqTvAjRsO3ovV9LPDFSjTIgVYOs/0gqbmQGx4sb3NmegF1ty+2/qLYvUrPv2wrgbJkFWM0j9Cip6oTxQJ+66/75SEZmqsvo7Ar9oJIc+8AT8GF1eNVcXAm4CVBCXl1C/+cEfyYFkFFrG1H7CjoOUZqOHGcYcVlXmBuaj4sbSrpPJNfc/MNok9R9epevcn9gZVdmR+kRpDKx8d7dfoMKvW0vkr8d0FCBa3H9B+8FL8H2b85z8K8PnSxMDvhX7VtyN0ID5l5G99IMPBcxRv4eLSMb0gxLrog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac62d731-663c-4096-9638-08df0daa1c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:07:17.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcJUE0jYRBiAPSgPiLH3dHofsnK1NHoxNDp48So6NSVcuYysN767bk4hVyV8JUYF6iTy+gKV4TmWgD4mCTkaexGasntPPA3AVjc9+g3XO1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 6/9] net: avoid copies before linkmode_and()
>=20
> Avoid separate linkmode_copy() calls by passing the original source
> bitmap directly to linkmode_and().
>=20
> In phy_ethtool_ksettings_set(), also use the return value of
> linkmode_and() when validating that the requested advertisement
> contains a supported link mode.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 5 ++---
>  drivers/net/phy/phy.c                                   | 7 +++----
>  2 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> index cf881108fa57..5801da6100b8 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> @@ -205,7 +205,6 @@ int hclge_mac_connect_phy(struct hnae3_handle
> *handle)
>  	struct hclge_dev *hdev =3D vport->back;
>  	struct net_device *netdev =3D hdev->vport[0].nic.netdev;
>  	struct phy_device *phydev =3D hdev->hw.mac.phydev;
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) =3D { 0, };
>  	int ret;
>=20
>  	if (!phydev)
> @@ -223,8 +222,8 @@ int hclge_mac_connect_phy(struct hnae3_handle
> *handle)
>  		return ret;
>  	}
>=20
> -	linkmode_copy(mask, hdev->hw.mac.supported);
> -	linkmode_and(phydev->supported, phydev->supported, mask);
> +	linkmode_and(phydev->supported, phydev->supported,
> +		     hdev->hw.mac.supported);
>  	linkmode_copy(phydev->advertising, phydev->supported);
>=20
>  	/* supported flag is Pause and Asym Pause, but default
> advertising diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be330..cd71186cd842 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1160,6 +1160,7 @@ int phy_ethtool_ksettings_set(struct phy_device
> *phydev,
>  			      const struct ethtool_link_ksettings *cmd)
> {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +	bool has_advertising;
>  	u8 autoneg =3D cmd->base.autoneg;
>  	u8 duplex =3D cmd->base.duplex;
>  	u32 speed =3D cmd->base.speed;
> @@ -1167,17 +1168,15 @@ int phy_ethtool_ksettings_set(struct
> phy_device *phydev,
>  	if (cmd->base.phy_address !=3D phydev->mdio.addr)
>  		return -EINVAL;
>=20
> -	linkmode_copy(advertising, cmd->link_modes.advertising);
> -
>  	/* We make sure that we don't pass unsupported values in to the
> PHY */
> -	linkmode_and(advertising, advertising, phydev->supported);
> +	has_advertising =3D linkmode_and(advertising,
> +cmd->link_modes.advertising, phydev->supported);
>=20
>  	/* Verify the settings we care about. */
>  	if (autoneg !=3D AUTONEG_ENABLE && autoneg !=3D AUTONEG_DISABLE)
>  		return -EINVAL;
>=20
>  	if (autoneg =3D=3D AUTONEG_ENABLE &&
> -	    (linkmode_empty(advertising) ||
> +	    (!has_advertising ||
>  	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>  				phydev->supported)))
>  		return -EINVAL;
> --
> 2.53.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
