Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0423D5244;
	Mon, 19 Oct 2026 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409385; cv=fail; b=Fby2fiFQZrObINsBizV7LYZB19wI8pTRxRN/IvOD52WJd4LLt+oVY0WoSfvESaEwSuzP2ufSEQgugERUITvNyns13S4rdsM4idOABpUqTMvJQIAfceEDsdNvu2qvppLJ0/AVdXAZOFscp82+UiF6pAuhGFTZc0YWfhuwSw13t+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409385; c=relaxed/simple;
	bh=68XQl+cOdDL0ChLqvB8HN81dLFZcIa5/0JhoKXxQZhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShgcvnpFM9SnN7I5+gz/6Q6NmcO1ZZ5y8wMMIvspIeCrFnDeW4a+3QRHrq8WihJm1ahqjh3+BTEGdyYOjdsbU/4jxoX2mrXzReqpHxHvkXWNY4n8UNIgfS2mEawwl9U8QsKJ14yM716YLNVTNnycrboiP8w/BL0SmkMPZX61kyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH7LPUh9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH7LPUh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409385; x=1823945385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=68XQl+cOdDL0ChLqvB8HN81dLFZcIa5/0JhoKXxQZhk=;
  b=JH7LPUh9ygUn6dbDh5T/7ZCEFFI/RmuaCV3i1zE+C8kOzOk9Zjsqszgs
   fwwlXNs70rMlPcWmUZkRglAgyochAsOThBwbMW81+nrt0r2VVg5nXlild
   OYjrJabhvoiEBEr1b9j/0v82hpsyOV0vzZsILG3BIWC/PzhV+Zp1SkUAy
   wsBcx5mL+K+E4nk60upq1VfBODP98xSdgOiwLlv5FgPf+iG6eM8oBqEKf
   lOqmnxB6woFf7hXDWbaFtLWxzmDL0oyaC7eIjEYZqjrQTFcof/3KCgDHR
   iI69HOUy+jnMWtzVhXIUVU9w4bUGrP5vAv2SSVnfAp2aCOBpvlEedU0b6
   Q==;
X-CSE-ConnectionGUID: TkSx8ksmThqVg863wcBttQ==
X-CSE-MsgGUID: D7Nm0E4QRTCnhpRZDDRVTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1082786"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1082786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:29:39 -0700
X-CSE-ConnectionGUID: 9pZffdTtTHquV8ngR9ozIA==
X-CSE-MsgGUID: 0dI/3wKtRh69dllFpSj0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2490060"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:29:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:29:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:29:37 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHo4lQdWptUAaC5xCMeba76fz0nzIZxdZwtIubwadNbXbtJB7WvjdZIxnAbgcuCF0n5KIUddo72nOqkWDGlea+ft4Qo3gkws2j4tiKD1PGuBaOCezuB73Sx6iTlY7QRRmAAi1G7B646Zts+jFnn0ZljD7DKGo7BSVVQPR9lzZjSpci80vI1vQMoZBTmAhd8gvtOqbEXPOEKnmHkw6c8ok6xn+/3771HehnOde7igYLPyNXvv0RBGSqOwq3i5LnEgBaEp7FVplKJW9G4OFWO0WkILaqWY5WLeok4LrGpJThi2QO8BJfCtIL6aPm0koK2BU/oN2x7dAeZGDsIEzcHh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68XQl+cOdDL0ChLqvB8HN81dLFZcIa5/0JhoKXxQZhk=;
 b=S4TxRJ8d4CtnvTbTEnNr9kr8U3JQbxrFujoi66k7Uh8NmQB+5KeuzhZrfT+ypYbMKcfySBI1hBk326uvdQfQkJBjRPsZ59FgrWNVE9VDtTcbKSOxalwE1kp+/v9uB6W3u8rYKmja6BxKm69RR/Qvp5/+1WqIKSCSKpYtSBpCUTScII5deazpk4FDPjHt181CWR/E3YWMwSLahIUbptnflvBsXVLrWnRXS2pPTlvEHm3evdkqkN9JFXjLB8Tkmb/svaJQqRNwF6SEVEfuE1R+3D1102FLpj9/JAcBIR5Mv/MahOPD+RUP/N7IvR5Va3OPdAiWbFoHScQ6qnlgAK3GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:29:34 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:29:34 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 2/5] ice: retain the adapter throughout hardware
 initialization and teardown
Thread-Topic: [PATCH 2/5] ice: retain the adapter throughout hardware
 initialization and teardown
Thread-Index: AQHdX7gHJ9yRCkWVu0yYztFAVRZWvLcEupmA
Date: Mon, 19 Oct 2026 11:29:34 +0000
Message-ID: <MW4PR11MB68649F1F90A9B483B463F67D80982@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-3-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-3-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA0PR11MB7813:EE_
x-ms-office365-filtering-correlation-id: c69862f3-d1bd-4a10-3687-08df2dd4402d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|21046099003|22082099003|18002099003|11063799006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info: Z6CNKH8/U7ERCCSIxyRRqxQ44YLp3XuY+R4Wyx0NrrIWjRHBBB0mCwb66kLGl223hXB3ZQnG3CnP1mQKQIrOi92SgUEp5aR1CJpL1RtJWoqTTAeZ4a0mQEOVbV5Z4xBE0fRArOGxefwZlHMs5SonRkQ//hhnYvZkmlQBNGDxuG0l7tkRAPH71nQbM1pD7+2lfQ16o/hZ1v+bXhM5VLbjbeJG+HDclejl6LnoVSwm+XEo1CwT9LME0zrks2hTz7j+utmsDOOCPHiryGwrrpbKLMR9lqyJnJcPJyIvZvdf1rxH+VxNvVLrvidpkJ0w7G7gdK35u4qAF8+GKAcZA2pi5p7lXt7Karqz5YwLeDqTIuMqb36f3tl1snkN98VIWWz3EpElG6csAB5O/D+NTsh2/2uHe2GZi92WACKEDPxLsAzoTaRYdVm9WIy5h9I7waqNh3fQwd+fYacQbzv+MziVU3kCMz1PToyFLjuh+gWBRoVyh9kloWtQMJlBbel/Nf79u/RIYJRHgUk/YnVl0PGjoHEYM847uetUPYZpxq9oEnpaHfZpk3XmkftI/SScKYmq1lps3BeTz5JXs+VuFjOa63dQtEuyodnAPLTp7tzWD3e01BZwMJTz7JvoKUZfnivOS6jAuwJ5G4xiLG703P4j0ZgYmMKtAuZKxuBGrfqbFzYNriHc44sezMJnKq7itY6oxMnuR8t3jaj72+T6V1ygqZneyJo4yduwUvWkMqjeCI2HHolX8lNiS0GKy9sTQ0RT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(21046099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+o7Xa7PPS03XC7oaN7Ci4Em/jZW5YlN0C+sZYLSO3uwCRW6pPUanQJUzbnw?=
 =?us-ascii?Q?/AolJbu8D092G+yWHJJ2aXWESaNRjiQ4h35+RJDtyQHS2valrSzsDpFu8xI3?=
 =?us-ascii?Q?vsTgqBmqxgxWKXSK/vGGsQogkBZZ1c/XExkf0HHqnl7OSE4gVGp4SXr4fv/u?=
 =?us-ascii?Q?epcp9YPC0HdgibkRo6tHQo8AI2k3moFfRveqJ6C24+MvWFMTvvPMTH8DMfUx?=
 =?us-ascii?Q?qYL8PAX2wcUsvQahwdPcvI9GbYsxPmUqmHgEVLeo94AOsKgRsKcksRbIN6SH?=
 =?us-ascii?Q?ie2+Vzdtue0AL3TuPxmpnnkrShtEsx0gt8ve4QQ0jfRK5MB20o3n237BdzGY?=
 =?us-ascii?Q?+SiFxRRoop6q+UayQGo3k5i8LuAL8grkktnXy828ogQJRUncDzkxH6B5mc/d?=
 =?us-ascii?Q?CaFoRR25sOPQqEHGvN0O2kOJAngySzovXp60kP6E5WH+BqSCTQyFQO60eR7g?=
 =?us-ascii?Q?72nxkeV4Abqr+MvFIVX+WJHMEfajYZVK87ywu2QS6djgj48xKLmuE5DzC5ik?=
 =?us-ascii?Q?JpfGKerxU95xtiUkXH3Syj9YKkyb2toq96EMCWbzOeQBaVmMz/dewHF1MAH8?=
 =?us-ascii?Q?c3SGnOga2KsEJK0+J8WgaomFLsLOZw0qCHC49ZypPo/DuseCV484kXg8iG0V?=
 =?us-ascii?Q?3dk+boOUvia7w3uh72STaWUFNbAjQ7nhHwXam11xe1MRPE7je6bTYnTbYvSZ?=
 =?us-ascii?Q?pS4Ur6W+Ros20eM0klA4gC25+GFrg9+H7AVxHyY/ZnD7ygcOdPcT2c6AXF2V?=
 =?us-ascii?Q?r+vlZTYOsPqgtIUkQIW21bADCRK2lo03r8gWfq+YnVkZygofiT8qaJtuG+++?=
 =?us-ascii?Q?nE/nj5IP/F5VUiF723qXopA5V3fFzrCuXqJMm+4BFha6zSxGhkXDY0Y2DD68?=
 =?us-ascii?Q?7veIfuDFH/k5mT0bYti7J7FKsk0OYlE47KLoozbfpwPe6lJG4vnj2deaJl3n?=
 =?us-ascii?Q?DEuMtyB3m+RqEL6PCwVwt1r1AJS0GM1pi31/YYuE+vUgQPKk1sdEtJ7pmOOc?=
 =?us-ascii?Q?oRzZBnQA8BwJIMYDUnrdS+qpulXl5bD69tLZwiPX0jOwp+SPPNgQGPUNu5Py?=
 =?us-ascii?Q?AQ51qTjIBqSw2Pa9jYwU/DGHDeVLF291kJZ05yRwm8emDe5ZMQ6J2ZrQS/82?=
 =?us-ascii?Q?/QAKtiTQLiDXIOUksCDvJal/j67BT8dMMvt7Lo8qhxYyCq3z3E/bmg0OCdxR?=
 =?us-ascii?Q?sWwKVQF8nCbrcx8DRazY1nesmuwrcJOM+8kIpiPjMoslMc/iO9xHCG8fO48M?=
 =?us-ascii?Q?4RM+f0pc7W3C8p+nKGMEeif/H4RSezmiCLGPRovIkb2/3WzLwVKq5aJCsPSR?=
 =?us-ascii?Q?B4pQQ9p/hx6ToMNJ0cOBLAo1D0rD9hDoEV3HeJxyX3M1VfIdHDz33ALAQMbA?=
 =?us-ascii?Q?lsotImuJuTNdu2RScWPiyVWeqYPJaLpqGOPMC7bH0xsvFZccc1x+pXcCu87n?=
 =?us-ascii?Q?6B7IgQ2AomOBzFV8z8SWe5UyUu4jOkdNclFabZZDY5baXZg42W4MOP+46rBh?=
 =?us-ascii?Q?CdqqBlBARXXt2FbbcvawOOU5/4OkJ0FK9vdmgvZZLz1hGqPZb+dcGdTVP4K7?=
 =?us-ascii?Q?DMPYikOJGcfr8HToTIwiJ3O4Bip1QLP2zUgmA/lRgIT7yEuuC5WyrICt/Z/r?=
 =?us-ascii?Q?l8cpb1ZhBXcG5wkR31+7YyQ1Vm3tSOrcdo8qNZXcdUWelzK/Gggsjh0GrII5?=
 =?us-ascii?Q?AZYknfYjSGwk8XVyxQTjtOy8AnpzV1MMexYKRmmS4duBGrv74SaNJnnW7NB5?=
 =?us-ascii?Q?jsngyUESmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wZR9zU26pSsAJuTjdWNyWUaaG1tpdfQyr31yntfFnoJgL8119gE/9Y2PB8+LPsv1VW9VoLUeKMLo7aalIVM/bup47zB279Q7YRp5Uiry1zP/hXv44dL28wMlXt7mRvwdqGsWoAr7CBvVN3kafEftnhns9bz/ZiBZyF09XuX/+OD82QtG0zWJ35vT4hYPr4z4UJP6Ra3YGvMUUIXNdQC02ytk3Ao/9pRGk9JzY4X18aOI3K/AFnnLzBbRiYteziN6L5oYlTmY5nWd8bwHXyORjdPn4CjCuRR9cKJCHy7py0WbgXpjAUaZTLF66QvRp4lMfHL6I6jwYn1D/bJ3P8IEYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69862f3-d1bd-4a10-3687-08df2dd4402d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 11:29:34.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxqP+mBbfa64x2nc7xcN3k2Ib06MC6s1mBH/VQ8fLh24MKPCtb56z8gI54F/MXutb6VFXkmInhrAvZgMbGTXN4TaPE5g9NIZsMh65zJgtN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 2/5] ice: retain the adapter throughout hardware initiali=
zation
> and teardown

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
