Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91825368D7E
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140205; cv=fail; b=XNietLYLl9WVdsMPtZJs8xHaxM7LgGWHj+KCujmp/iRHueCFs+VCuiB+D4g8NkLRD22a8SBoGvnGKFxDlTZmYwyvK8clFcckQVLi8jEjOzQdgBuMfJrWvHlWrBs7jcAKqHg63pDOrtPZTTUoe9oclavUT9OtcMOygAGT2gr+eH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140205; c=relaxed/simple;
	bh=oeWlYRJbj5iSkL/f63OI7bD7XondGnEYaAUCBaGYb5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPBmCqiloRt2Y0TCVrxwkzPBszH8cu0vQGCrpfrHZStuYKF6L7DfI9GUP5Kw/r1Hl9lcklevFBcTJg5dBOEe6CPUWjPWnrGRK3XKZefGxdLcvqXsxzX0u+HdaK0rr31RRyMaRjIzs2S/oJUZlj06h9sjfp8T8gCgTnjrORfjQno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0EwAxu8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0EwAxu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789140203; x=1820676203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oeWlYRJbj5iSkL/f63OI7bD7XondGnEYaAUCBaGYb5A=;
  b=S0EwAxu8/0JS9bp0DeXIwuCVNeHqB3sTp0F/Q7KBDMCD5teJoEItlI05
   YOcUoSKJe0nxBCbhy8s60YNHT7ITCmqk2fWly6IjLsdq7ssYgGjSJsNyB
   2yKsRwWH++bKwa+8YuEanMVttWBVd6eD5eV9HduanBvQQNt3iO0AT4rIj
   XiSr2eh7/ecMiB9bP8LXOMFG5Mf4INjSVeLWaDmMHu6e5uinJ9qUInXyS
   BOyGuuCuiCBt6CTobIXRcbZHFM9MFmpZbt7Zd8v0SCFwtiPRv1O0QwuSb
   MbWejwrAha25vX4MTIfhusczX70Zo/vSEv5E+lVPv92eeMBIt0a/F7r+8
   g==;
X-CSE-ConnectionGUID: m+iWfO/LRDWbFQVG2CoFng==
X-CSE-MsgGUID: mNGjab2ORKSeXJjZi5rkjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88546523"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88546523"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:23 -0700
X-CSE-ConnectionGUID: GgkByG1xTkWg34cLp8i7tA==
X-CSE-MsgGUID: R9kSQDJBRiWssbaDXkJReg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="295434748"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:23:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.48)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTfSvXXQY1YEkPviWYAlEaN3wgFDM8zRtogOijQaEnRJlFNeUGvmgJ/1w8TipMOXk/5LwigMWBAwf6KtET95lcWvtDNQnPh7H5L9qqgif6vAtLthLzhlXBMTuFK5k7zJUajvR6HYANfewUiMowRCmQWkW/K4MzB0UiMRafzH5aVQwX+h9zKGwCnSap2RT3N+W5g7a1NMOOo+stAuOJon5852w1Y/DwKOMCEithCAPtE5DKyR/qydU8zmQUQREnYo7OMDu893fW/YyjNAJ0WsGb5SiOmpZEmvkw4aOIdtgD7aXLnf4p6NtvOXYIGx+ugKYOyKdmUSDJ6QielpmEUgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG/SWHwLfygpqnc8GQG4G9LUFtzId4wQYGwi6hJ4HE4=;
 b=BmzaaDBKc/Nnc+adJpD16nUbThg/Ez5AycNdwE33hWX0YpsW9Y286TwLYVMeOAqODJC7XpYcU+x3dErypWW8eRmAgkMcICNSnTYBiOZznk235PvkpYiz0TF0fk0mDLmE+VvSBQAG6IB7BxigQBdjqMeEIs9On8shJqI9VrxpOt3kDrvstce2WDjwP0UBdYEYckpPtBxaUIMBFG1qtd4E081zLMQ2t3paD81z1QcISl+OOEhMg95HIjbaKopzWdD1cXWQTrglwygP9OXHrE9gnBSY839xz6r9YExpayhJ2nzjD+BqUnZ81v3xS2JFNqtKm/Ri6J4gTPqz1nMI1VVU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA3PR11MB9014.namprd11.prod.outlook.com (2603:10b6:208:583::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:23:19 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:23:19 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample
 rate from ring to PF level
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample
 rate from ring to PF level
Thread-Index: AQHdGqxvOATeGbVkbEiDgO79g7oEpLbJajdQ
Date: Fri, 11 Sep 2026 15:23:19 +0000
Message-ID: <IA1PR11MB6241AC8EFC4ABF18A3208D4F8BBE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260723140510.184819-1-mheib@redhat.com>
 <20260723140510.184819-2-mheib@redhat.com>
In-Reply-To: <20260723140510.184819-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA3PR11MB9014:EE_
x-ms-office365-filtering-correlation-id: a8bde752-f49b-40e8-b99b-08df10189c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bvm2g9Z+okH2VsWb1jNtV48JWx3jNJGzylVCdtiSo+2tUSrp9dMpSOs8WwRj90gOnVoY1K6IYZRYKvCRluyi+XUuNThErkbuhyzu1PIjZkoJx9tkSw7URvDxDmM3Oq7E5FzL55GHTVIXGf1QvEEZW0RTe9CeaciGwVo/9ammzYG819rOka/G5GvtqoHVfckV4+oLltvK5fQ4byGzwOv+qKQpDxsD4QjRdQhZRcPLVoOVAUrClYvxPSSEWAfHmGaU7mpRQ0HGe/hHpn8+hy0Pruj4X94LNID5Za4H0CPhHhybNGWXsIWR0oRcqrKETnq1n4EcIll9msExzn2lxuSumq2uWeiHyPDWdZMfDzqtUHzbHymlCtiHDJOTBo+vJh2RMyGPSF7pgfHzvYIfZhCogtpHUpUFM6waBFWlbD2P6pLT55Eeh0xj0/zNuIMhPCesT6ZbfsMQLkcUs+ElryzJOUSIJxbUQg+Q8HwE1arPDkeID5ahmv36Kx/r5OdPwZzl1ist+35NsxqKWF7k2qdllyIdyxeeuEQVHK46FyTE+rQa1KrwUgLbK1qsQuQvfXf/Gkq/PXqeE8dTVKNoR6fk5rUMzy+WIG4i15nHkrZch8JRS0XfoanKfKZ+BHOyS5zflsAWxlzqhceLzY8BFhvVV7Cr4ug4pkq5vgqMbOBEpDzdEl6v0LcxKQkk6LRdDIU/5dAWn1dF8fxbAauHxWxpUnMH7P5fthkSOO/s6oblWjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUI8EXYT17i/kocRK75Eb2yTRd/ufsZjtRgGRRaFjkgbtaqFkNSPYYUD/Sd3?=
 =?us-ascii?Q?GDGIdaJ56IQMs2VtxrIBhi6wRHPonZMiGKLzRaz0FBNGIeoPQvv+u52176wV?=
 =?us-ascii?Q?pCo4+AoZrameQedpaEoq9jDMZiLqp0bFB7kWgVLhZYYqg4yVNZufSA/CY1TJ?=
 =?us-ascii?Q?AvwWLDw7uJKFdoF6PvJu9PO/BYFnmHK243IKOYZgCaK1ARcVZyTbTaMMRTGU?=
 =?us-ascii?Q?5PwgDF7J0oFAmOHW/VYQj3E1aO/PV0tztpI4EdVKe0nWwY+HLhMf3bdkvSgq?=
 =?us-ascii?Q?Dak1jvkcdw7GoEIsF8tD7k7xwmqAMOmqQU0u0rXhTrOMyzssoi/RHuQ7c7wo?=
 =?us-ascii?Q?+amLhMQI2UPTlThGxZbLDKggwC0q7y447lJyAjAVxMAWvF/GmeP0l12L9r0e?=
 =?us-ascii?Q?jkYeDMz5AcaO22RaNbJmJeXnEMA3SsZwSpn7P0x9m+dCkRBj+BhyXMRjR/2y?=
 =?us-ascii?Q?s6L7KYA2PjN4ER2gYHqplk2zRQjEJU/9yqtReHhy8TYfx4fNd6a0nZ3y+sXq?=
 =?us-ascii?Q?zW2DwIXtYPvA4cUxcvTgfgjc3nBIQxn6MAgYBGp8dNOKVzAdvuhgn0T35lIE?=
 =?us-ascii?Q?+22895xZsDsHFM00v5TKC6ZMQJFWUb5TfRBCjD2C/BaJieYDfeL23Ou1Briq?=
 =?us-ascii?Q?qTtmjrhN9bkfTST/bcnXi1iPpKdHM4X0hXQv4krVoPy+N5RK7pe/C54f9Zgs?=
 =?us-ascii?Q?CGQrfQMnGrB3Rd9t2gGx3L/cX89R1LDscczp4vzdITsc1Rjd/x/ndWOkyb92?=
 =?us-ascii?Q?v1fDnrAQweOT6R8BYGDMNmxW75Hvm0daRhLAO71rk8bupDluBijAwuJJFJp5?=
 =?us-ascii?Q?Bial6m8yJNy+dLDmnYx7E9SqH+PYFt6Sk7ZGSpLvZomfVSpMisb03UOFYgZG?=
 =?us-ascii?Q?rihyRhYW16V4gtPdgYJZwrKyNT50B28FANlj5e97vTVFHE/TXB4Nbzbxh3MA?=
 =?us-ascii?Q?HwUVoiu2mx2lPQWNGd8/gKliBkHBoYYPJEOQzq7ipXfUUGjfcDf8lJguiLKt?=
 =?us-ascii?Q?Vc3zoyiEvL9cT6EWRyJ8K91cgOgsTqBeRTmB4hhowf9JovE+daZluHqLitUM?=
 =?us-ascii?Q?L6Uxf/CFGUFesUcl4jSueBGB4GHtYgFvAtZ3JYXx6lGgisUhE6PHmmlG7zq6?=
 =?us-ascii?Q?trAzcZ3ahPZ8NBUMvcHW8xHXO9agaJVc1MNWBeyZpEhgwlHKjqTycCTR+DCf?=
 =?us-ascii?Q?GXPOzQ2s5RrWtmvohCBn2OPDivjlfCEm3BV69jSJOQdnz/B5lUkPcwvtxvQv?=
 =?us-ascii?Q?d8sMjYHmYBZDXFqvmpKGVS2H1cYmEoREbRm6WgISyJvyprENWd9SaKvYe3QS?=
 =?us-ascii?Q?peKOtpWXPNNzgO0EeYgfoB61vBwU7OtR0mGwpXUfNAY3eDmCnik7zLCY6rlb?=
 =?us-ascii?Q?zEZngMKVs407bEM8kRVVnyOkVpo4dfYZ3cSAGtmHnxpjIVFUokN1gJTjrffv?=
 =?us-ascii?Q?OEWW8IHs8uhSXn8HyBVuK8pnGJTYSjjhaTZBi4jTmqMxIdssWdQJkeaYx18q?=
 =?us-ascii?Q?/s6vgAi4gOHJOs1cq6OEkZebc+GQiKiiCC+ggwDFh4Z7XF4lLA0VZeOp33aB?=
 =?us-ascii?Q?9Gxedko0pV+0g/BeIgQee16VKb6TbYWFipZa2R5WW4J3NqAWsW/FdyOS2iG1?=
 =?us-ascii?Q?G61qUwXBmAmYzIJgcF7OPPWRxV7irDKM8m4VYh5ZA6J5ID1TVz1u3id6pVWs?=
 =?us-ascii?Q?xvk3Jela1C1El3o2pq76E9F2tUJY8dvOTXvtrwR0HWyyRajF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fzDSXk14st/TxYmmzn9jExYi8cZpBswUSFGPPyo+xRJs9hHSJU5jQn0lq0Fi3YOc8/JCCKyVwx/nKsRU0STi/R8XUfAzNTQBsVByVcjDIjBj2Lzd+YXu/zeyxli+RaKbVpNZ2msLxOgpsI8M+aXhS5tAIC6Mf+MiJIDixsZjDaH3YrtdHV6ZWJBX68n4o5n6fz6lbdJ5InQzViM5DbyQDqnOEWvsSTQJka7vB/o2Lc3hsU7L8O7UVef74QYLwGP8HIExQM6Nfl/AlKQjmSYouWLvVH3pgsNH2gSobFdEtPBVCCvCKgeykxMeaF1Ob17Rkt/DH6G9vlEkT6+Jzouw/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bde752-f49b-40e8-b99b-08df10189c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:23:19.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBzuh0s0hY9/WuFhuyHUFoDhmgoaJv79L+lmrTmffC5L++VbKnYHGpphyDS/JoWTYePPUxfjlJ7KYjV2RfNbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9014
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 23 July 2026 19:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org; pabeni@redhat.com; corbet@lwn.net; Nguyen, =
Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>; andrew+netdev@lunn.ch; horms@kernel.org; Mohammad Heib <mh=
eib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample =
rate from ring to PF level
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The ATR sample rate is currently stored per-ring and initialized when eac=
h TX ring is configured. Since the sample rate is a global policy that appl=
ies uniformly across all rings, it makes more sense to store it at the PF l=
evel.
>
> Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initiali=
ze it once during i40e_sw_init(). Update i40e_atr() to reference the PF-lev=
el field. Change atr_count from u8 to u32 to match the sample rate type.
>
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------  drivers/net/et=
hernet/intel/i40e/i40e_txrx.c | 6 ++++--  drivers/net/ethernet/intel/i40e/i=
40e_txrx.h | 3 +--
> 4 files changed, 9 insertions(+), 10 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

