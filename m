Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DF34CFA1;
	Wed, 30 Sep 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731273; cv=fail; b=LWZYzOxpsq17YkN+PnkrbwnxwG8K/5OPggl7/zDn30rkS+cLPS+wvpuhf82sZSyKLT/bSI5/qPRkqPHTOrcdsIyQWogRe7u+6JlzteUV7GRzdlfl7I+46HaHu7g2kGtQBUeHj953m3jMZSIxe1RUBhhdA0uPbLYJGPNIzEQVU+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731273; c=relaxed/simple;
	bh=bJf/Uw6v8H/OSdZ7LcAYlW+nfJWN9whkstDa0DUPLXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1O3H+NFiibzM1NnInmqAoTx977kkgF7R5iA2am+M5tjLmlqcUBdcwHq6wGodOzU568icKMwC+s5zYiUJXzVqI2vUw+KorMJDuRryk2BY3iNAO+brY7ypmv46k56KoaOU4qM/PDTnhesSKxxaoy3YJ+tAu/QALzAJHoXvGfEjO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNve5boO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNve5boO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790731272; x=1822267272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bJf/Uw6v8H/OSdZ7LcAYlW+nfJWN9whkstDa0DUPLXA=;
  b=GNve5boOOOb1XBDAuawjdxW2gga2x9XFbFJT2chreGQiDFQ26ElVZ30w
   QWkFrTIU8UujMLHWYvaP6JNOGDPSN7LeCOjXhkdZ1+18xqz+l6Pe+fd+S
   cqgNlRvDeJMjMlnlGWbDcEOl2fILtu5gF8XvF6TVh45by4pK6N+TXTir7
   3xKPWLqIaf9juYlLY4TrMEJdadugtn9ebr3L8DCHXNPwp9v62zsBn34uG
   s+TXDGmqXepuaTukCGtf14fQzjMeQuWC8Ryfy6Uhd1GSnUkf0uLyMT5bI
   S1QZOvnVivUl7bvK8QZxOEtGok+br70at7YIbTg/chcmVwB58jdgklpyg
   A==;
X-CSE-ConnectionGUID: 9uEySaI6TbqWi5YPysba6g==
X-CSE-MsgGUID: 2gM9KSpCRH+sMqGJgHHhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90227175"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90227175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:21:11 -0700
X-CSE-ConnectionGUID: NBexBKErReGXYq+H0EW/9g==
X-CSE-MsgGUID: xv7QXdDJSamU4o36PbJWeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280298756"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:21:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:21:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:21:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf5QsCS0Ia68NYMI1QpJeEYEd3ehroZ7JYNNzc1J+nFStpy94wInc/XDSSOMkSy5zi275amxTR/xsF8vUOAAecloZgDjGiiBpP2vVyLC72WufqA9dBkl2mLDw5BbubjgWlkiHn41H7BEO77qQ+aMTO+3WsqPRXdchPXZkmvXk53+Gyw5+xxe9r3iblQqFZ+sYL3+Q4OH1EdgwMiwxYP0Gk71BFF8wKsKTsmGK5n09Jiv192pPDwceNXnsGKRmTUEraRAbHTS7TXm1enPn7KpcCWavpibrWM/TJQmdJpYwo1TUfsiq9KnR4gmJjHGQuSNBitKqnmv2XnsgJ43iZKLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKfxOYH/apLzwRelC6jNqI/7r3wvYJYnAU7oCfzHx1U=;
 b=KwNB1IwnypbG9jU+BTHjP8bnnDP+M3PI6dme8T0Y5jD3JqBxiiRxTrFiRCOIkTyCKaDRavFuPNYL9XP0SZcF7ECTxmAUL8HWP9jmfWGehzUZy1utkImXd0ED4iuSxgLatL3XqoEp6DElSfzYlMcqrE1v/LXEGir7glUUpnOl+61+FnHjWLMDttXT+tW2ql/I1anJ41AA5p9xGVIXA1+ox2X9reJ6soXQKCcXlytcW1ytanTA7UQoZqqCaD6kr8dTbIhxcbLWkJNOfUNtwYeP1Of1xZEog57j/nmzKel1zUZxKR5SyQRheQvVegOY1tMiIGBhmlYKlZcQu9apId9gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:21:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:21:05 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kees
 Cook" <kees@kernel.org>, Robert Malz <robert.malz@canonical.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
Thread-Topic: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
Thread-Index: AQHdL7UhIz/fH6S5/UWhPc/+uVBbbLbmlGog
Date: Wed, 30 Sep 2026 01:21:05 +0000
Message-ID: <LV1PR11MB8790EB395A631878F050F9FE908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260819082458.665947-1-poros@redhat.com>
In-Reply-To: <20260819082458.665947-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 949787f5-0f57-44d4-eb30-08df1e911976
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: N6ze8tCggID6n3AiCOKYplvK8h6bWDe++0zKgjfPIHWLnfLxDCZpE+8hPqHWMfla5+umQDw0lUTZkVGyNZToCAN+uKC5bmXsLaIj7iIn/H4J+/UIfPPAXA5tkvUqkvKI3t/2LjSWlZG9wE07MgBiG55Zaxlp+vreLd1+onpekXtHs80qk+wBUzuZ6eGJZ9j+0hCiFyrAC9lurFSGNYyF+FDoF+iRKdreUjTaZKUBicqVHEwwIoMGSBED0o0lteEbwpCDAenPngYo+XG3wTzCtWYMUoQtx5EWhXVksiT7ortY5mm14fn9VBpN2s8jKUb/Lb5pfbIAj43Uf8AZ2ZD5EtqrJYb+MVHJjH1tqX/TR+ZHfRn9/JCL50p+KlujQY42826c7g0a035h3wmSZOlsxUHCIy6+B2YS815PS906bd5EFsq9RGVzvZRjEfzuTfP98rQzTZMKQkArPxqp3b/flTwA5/WrAU3IroAFhERsb5YiEkO2QhtMiWglKX3w2hRj+1i9pYnLMbGwAvh0YR+YNCMY9By6FDpmvjcGbmDPxqotMQDkgRgYjXAegnl338UIxUTqEAEm/OYcJD+A6VhKmEBEBc9b9ZWKDQ3RIgoUcPTw62gYQ2H1PxY0vXWVsXJoeHE2BN457U/rn12j2nSMxyzcJZY5W2aK9TjI5hpntUURHM5GfcE6LEjhLOEXxMzkvr6i/OdQtxAADQFS0j0gscrTaDB5GsH6nZNt6tFiyxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E5dmBcAcxcdnuUiQZciChiNTWwEA81RtEJFSAU9G4fJYGCwOyiSLvJZpsogw?=
 =?us-ascii?Q?BSdYsSTdhuWuMo8ePtWW6FNn0p24fwXjXwEk5UstQHHr8QPYLWQM8OpkE6Qh?=
 =?us-ascii?Q?L8VzXoB0/B9PnPqwlpcaH58xNy+lnnWzdEZkbyhyHEWUO6wsrS2sl0AMoxEO?=
 =?us-ascii?Q?o8ef8GeOQkk96l1fHBuSgeLApMLKu1xoWV4V2JIcOvyp8YOkZeyQO+tRZwLc?=
 =?us-ascii?Q?Uj01WZiHjnHWZvbk+ietBFOxwDdegJuiRJ7QGuuPlxpKFcX1hTv/aV9fQwLM?=
 =?us-ascii?Q?5B+5L4NzRSdQy2OYT3mTlMbySv8nzqlHXy4RsTHmrw5FWbvxFkEWXNDtiCCW?=
 =?us-ascii?Q?Byu79jSSORIbbe90gCiMrEscwMGTSkvNia6tiqccTUis6gVutiGLQ0SdkWNx?=
 =?us-ascii?Q?prkCSFsfEGbpS2WCyT/HzBHY94mvPyxvpQqiBae72rsRLmrBjdHRloMfl9R0?=
 =?us-ascii?Q?evT+3N+O76MaA+C8cpOd4R6cStcCn+SCiYCFYCXYKMVVA/RBxYJQSwitKhI5?=
 =?us-ascii?Q?WY682lii7eimXzA9h74QzTt1lNc/xzMxgGugWFwqovxTEGCKT5bztqPm8wDI?=
 =?us-ascii?Q?PjzC2KzlAtaweBYWli+hDioWsbtN9Wp2rJauB1xGEM8K+W/rc5topguYNc43?=
 =?us-ascii?Q?zCKt9AAZhZNQGaW5nfdhRF7PXqMUWFrZV9chlaRg9ZW9oCZ4XEM6pVK1TPzb?=
 =?us-ascii?Q?Cb1w4jeL85PRQiu7yPbzFYg7zcR0NaaUq4QQvOM+/L2aBZq0lmPXdUs6lBvJ?=
 =?us-ascii?Q?D1APRGHysxsAIfYXgBghPm3UhB5LsWaPbhaWoj5tS2r3jUAIN8OTsl2uI1Vc?=
 =?us-ascii?Q?NZL7BOSO0TvlVzNRjWynNHOafwbdHhO3FJCoOfrrzIPVz7HyxrJeUHe4kAVQ?=
 =?us-ascii?Q?M3kgpVDswdvKIVVRIWl+D4aWHw43crlC/+j09whXrGBHb/TKiw1hhQnjxZ2w?=
 =?us-ascii?Q?CQ6QlxnERb6Q91u7CwgBOBSq7iVEJpjCjnBihFF+7nNrg14VweI5qb8w83FM?=
 =?us-ascii?Q?xXrIDX73Sp9oFMJ8NE29e7ACEKK7KUuE2xggQDRkq5xELcqlrpvrkWByWXL/?=
 =?us-ascii?Q?bXAhSWlej/Fqw5utkNtvxGOKb5NVcK5JlfA1zAV2DeNumX78AUPTWCk7ww61?=
 =?us-ascii?Q?r+HcpXcEN2KPAXBFwtwUbnBN7L8Nx7nHWVbPajA4hd4A9KB39HCOeNwqIeDR?=
 =?us-ascii?Q?CL4czcTGlAbmizD40zBHMedNRtnzfn4S8ibAhgYRb2JcttKvxG0XFQEy1DEH?=
 =?us-ascii?Q?DOcqayMfCsIg8Sx49fzud1qugGGfXeT7VrBQbCnj5s/hbjVFENfJ1mzcvDkb?=
 =?us-ascii?Q?Xyz0e7i7pI/MSP+UXmVACCr0IkRpRn78L9scCg9lmoqpmVSmWMp66aEEinXq?=
 =?us-ascii?Q?etBUQauZmzK40Yws/0TpWxZgAwdUahK4IclMQLxVZg+WNs+q5cGKKhvCq2el?=
 =?us-ascii?Q?onnlV5T0Ono7llVdSt2N7GCzbJRcueofKeNYzrzEDc7XIyEgRlCoU8DVD9WG?=
 =?us-ascii?Q?9uHxcwDvJhFznUPTy9g8vdg4jbGVVlLUxGA3h+Yzl4od+2giOWD1Sr0+B6LF?=
 =?us-ascii?Q?RfGvrDjukFZgJTO8MTqxF2L3+eShnE8RVk+U9l7DXZLPfJyjJanBKAk9+OxY?=
 =?us-ascii?Q?jLE+f1k6dyI1s1ShgBV10DqdVZztcvgf3y95FF3DTELHxy/6TLkLdWWk1xad?=
 =?us-ascii?Q?gBlUnSvXzJjLlu/gwvR+HvTAI8dUI4fDS0fLpECjhzGNBEjR+Vhvsj5bXYyB?=
 =?us-ascii?Q?eOMUVVAIXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tw7tCJPhah1QI0GAUzsQGqbHg75GFbO15lH77WhyMioc2vInQXedSExIZ/QSmOn3PSb+kuFV/wX6pc/DTmC7p92+IwYDXWuyhrc4wrnS3HS3ZK3QW7lH2IpvOSkkagEj+3mg+DrKdDyCf1rlouU5I4AN6B9OhHMJPK1ckrkW0O5U4ScVRTjraklxNuhzYKFDI9rTVbvwE66Fc4x3S6JfQmDV7Lb94nhslGybXxg7wemXLtBP/lmxHNOfNxUbR21Mj4nHdtRhvymg5uu1hNVYoIk4G0C4x0WZqjOntrE+l59g02/8bi5u/V7tOq5M1gNtrjtyDCyYMdFobHibIzvexA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949787f5-0f57-44d4-eb30-08df1e911976
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:21:05.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uf6PJvCcAxgIp3Toz/kBPWoRrU1RzTxFgEBdUfC0PaxBQAdgBxTzCaaHQrLqW2z0GmZ46w6Q9/lGIm2B9LA5niEAF6uN1c9PqyFfWWsl68w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Wednesday, August 19, 2026 1:25 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Paul =
Menzel <pmenzel@molgen.mpg.de>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Kees Cook <kees@kernel.org>; Robert Malz <robert.malz@canonical.com>; Rath=
eesh Kannoth <rkannoth@marvell.com>; Daniel Zahka <daniel.zahka@gmail.com>;=
 intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-net] ice: allow reading the last byte of the NVM and =
Shadow RAM regions
>=20
> ice_devlink_nvm_read() rejects a read whose end lands exactly on the regi=
on size, so feeding back the size devlink itself reports fails:
>=20
>   devlink region show pci/0000:04:00.0/nvm-flash
>   pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1
>=20
>   devlink region read pci/0000:04:00.0/nvm-flash address 0 length 1048576=
0
>   Error: ice: Cannot read beyond the region size.
>=20
> shadow-ram behaves the same. The regions are created with those sizes, so=
 a read ending on the size is the whole region and has to be allowed.
> ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does ixgb=
e, which grew its region support from this code.
>=20
> Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM r=
egions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
