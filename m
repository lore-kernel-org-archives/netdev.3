Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669850E59E;
	Fri, 18 Sep 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747182; cv=fail; b=Pdon3eUNauTfJC5Qg2y3yE5IiKz/5MfX8zoOa9iyUIEqMCleXrN9FhcMDUrcuADQUTryBiTVkwayNMRwDSruc3+brjuGVUS1HQFP4q3DAMEwoALAbn3BXa9w3ostLdVaRJRxpIH78SDOp8FDw4T2ilz7f4bIP+fU7fkFHrtlneU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747182; c=relaxed/simple;
	bh=U2pVVI4bCxO4DaNTBYEpz54ti4/YjjQhEAzhY2o9p+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzSO+aDhv+oJ5PdxAIwhcSGcJxLqmb7zCIuRX+ac8LK9YNMJb7sBEiaw+Ye+QITCIcVTj3OQ2pTBoYdcY4SJBZX/qJshx03eoueBsrTeEUGO8I0Aml6UOHWqsuYm2SwaA+TBXO9ZFjiF79eJqun7AIQJ9srjp1lqB6u1cnz3SCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0wekylP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0wekylP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789747181; x=1821283181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U2pVVI4bCxO4DaNTBYEpz54ti4/YjjQhEAzhY2o9p+M=;
  b=F0wekylPCAoaSve9ZlPXr+icwKNzIoIOb3rFQNeE/PgkzPaOYEvqQ05b
   tij7y51Usj/F9mypBpgWMGATfoBBHy/4MeGbj/osVit9OM52hoEb/s0Jc
   OvOo9aG2WKIMVTJnr3fLXRiEKHLpActsvXpBIRbGaBZdEfFxbQl3sHdXa
   wucrW2miQLixo769zEQVpwbT2Y4kepFud1pOEoVrf9S3KjDMC7QZtAzpI
   iV5aMNBOQXDDch0KFYWsVeoJABkHTuy4eqRlEmO+pBtKwYeBfwAcgu0TZ
   EF90NBgVEAOZe5vt+Fp2JbxVC6rO9pLznn8DclIbujBTEz8A+8/2sMROt
   g==;
X-CSE-ConnectionGUID: X+c7VPhbQ7+t8NNivC1muA==
X-CSE-MsgGUID: ThBH2uZNTgOGoCb9x0afKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90278422"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90278422"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:59:30 -0700
X-CSE-ConnectionGUID: F6zEinMBRIC3XXyL0Yej9w==
X-CSE-MsgGUID: o51o31zlSC6XR7GWUTQENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271135932"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:59:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:59:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:59:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5YyhESmQCH6eZwmpqxc9JxuffmntCrKw2f5VFxRP+ROmPdrZMXOoTqTtYNRx4+wCeLzykiwZIwhHSTlEmLwylbYGYIX2ywKWR+pxD5QCNKAWDfhz2nFqIYy1V80znrEPbkim1MXZo8wCa8dhoz0WSxa9UReL5BXLCkikhvO/fjiPe9FKfURWWAXwA5wfSbV3z5gzByLHootDFXnuBipNO4Z7Hwjm3GyzKcWu2vBMuvgfJebSdMCjtWLnZO5VAV5c/Fsmx7McdYzrIA9WbbfNFa3C10xLzFmsIhZkhvJtQH74m97vPhXfWDOKPkm63oYA4oGzkEnBB63tS3yHeYEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rciatL8skBYJsCA3ixwC/nVysnWTgGiMasQnxzF+O3E=;
 b=fQYvyj593TKltmTTZ6qhg/K25vsmuUKSO8Up2ITqrLmCP7Gk+X/JYoSLIEU86ct1mMI0kH8hgmhG3VTynOMYAt80sDcDR5GuPTG/F4lGjQOhmlrS3M0ggm2Y9Q7ZpG9jmz/Yr5APMQvnT/00rXnu0nSiIXzxWEMnMQIPrTGXEr7BzkXOzTfCgT7SlBKnyl9VpKScn3/QrjgV8cJnjtUYOsEGW9w0uoZFB0HxVtxjk0KyXjlGw2V6F+ERs2ONKNBEgUgEV3PbyKxFGN8pyem+inNzXgZYcpNJLTpyqmrgbR0fBV+7eiBvXYl0nOxArNHsbf4jAK/MWux9iOiX/4LeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:59:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:59:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Jijie Shao <shaojijie@huawei.com>, "Petr
 Machata" <petrm@nvidia.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michael Grzeschik
	<mgr@kernel.org>
Subject: RE: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU check
Thread-Topic: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU check
Thread-Index: AQHdRLxliusB71OS1EuXs8EkFZ5WlbbUg7YQ
Date: Fri, 18 Sep 2026 15:59:22 +0000
Message-ID: <IA3PR11MB8986DBEA6956DE89077110A1E5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915024551.196126-1-enelsonmoore@gmail.com>
In-Reply-To: <20260915024551.196126-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ1PR11MB6228:EE_
x-ms-office365-filtering-correlation-id: 9a27afd1-5448-4a68-4145-08df159dce7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|5023799004|38070700021|22082099003|18002099003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: awHLCrrv+lkXmTqpubjc5MBXKJX9iwBgZoxPPc/abc7rPgBQDdoV+TkjPPAPbwtZSRuJypSOkHia7aVLPAZJkNCKcmf6dsoFTrjQrw3rE0WMO6hItrV9x4TbVNxEO1RRm+oPexZ5zV9XR6dQ5XY5y7dmRwXsQbe/z7zBhpUlKpYTHM0ulaig17hy7cmlrpQmIbGmU4IIMxkPMjdWXEmL3vcJlFI5KpmhbyVHxfDazje1n5MRI4c2S2ooVqqGH8Y4LE5v3g2uQaqEz3BwP7QurIDAkbi5DLl60p0A4aTnMFeFtqzPrFze6sAB7bPeqk28rgqTHdDhOlaL6eQ0jtTUv4I5QO1NY7qNFqdQKBI1X2NNOAYA5pXhdfundAvjJtSDtbS77KtGZLvUwUZ2SpBxKEnnckf185ZQSP5hbkNTkcaYp18Lu4VDuHlys8AiRXKdXXgl6eeiNtVBlDGK2QxFtWdTCUB4TofRXrmIvzM+/zEGQISt+tTSBZ2PO5YZFCMmrOBVuhxhcV4sGVfsSUJtHCTtKe/IXmf3FtEfGR6G4tG+h/HUI9mqjxU1JefhkyUOVTFI1KdDAjY1j2+y2qp8GJSoN2o4qiEuQqvk+PTpXyyMiFFUuzqZKeo6UvtUCLpjZgmxN8SZorlA2knPFEJmQjbae5MolOt3sopEc/e9MF4FSaB9Mb52E0t8xb0YGl/mCLA28kskGv3VDNpOX0Kp5bkcJzo8u4qC95BBHAM0Uj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(5023799004)(38070700021)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9XxdPqZn/zLJBH9pr2zmsIWFphe8wBQ0PviWrl8Qn4eX98IONWlzQ7ZUTH?=
 =?iso-8859-1?Q?FkOFbXaQM9BijmEezzfUXBnfAthOBngnCYqa9fkUMRe1asdSrvWlCfbNUQ?=
 =?iso-8859-1?Q?KsBTBlJIU41MGJGlnY4kqxIPg8/uu9TlXyXn8grEljc0jpwTY+THWvFCfY?=
 =?iso-8859-1?Q?474QZBTDH5wyOgeEZWdvBH+J2mpGyhtHAvFzDGbwJ+nbEZrcESmnxCP7qY?=
 =?iso-8859-1?Q?y4EOYvfTMXBnbKEM0O7IZUsXZaE4pgzeI6zcLnboexFoFRv5vD8lILKNyx?=
 =?iso-8859-1?Q?D2H8WqWC/LJPN3h9EVA6TCdRpw3LzCE7nngsyBC5/Gk3lRMFuUGH7cUv6s?=
 =?iso-8859-1?Q?MLnNz30r+dg76+3x1cN0tHhHQXj+90oy8dGZspqivSkgkJiMhFyQUa+W6V?=
 =?iso-8859-1?Q?ei/ISpVMMtOIgec2Qr0iuupTPbKaxrdAs54cHRGwSmF9NJGx0XhFKIVKXC?=
 =?iso-8859-1?Q?dRNc/gwG5rRv+yyCCQwQNE/TEwcXLexPXm02QwsNTTRUHBsl4Fl2sSWW0r?=
 =?iso-8859-1?Q?MI+ZTbcD2m8hUVryEZgBp981ceuxDS8JUot6ZRgo3VxrNFXXg7iC5BkPL0?=
 =?iso-8859-1?Q?k3CNd4JcZ5RJebC3RxkcADkJHz3gIg9dl7IsjBpdcO622v4uSwJIzDiH65?=
 =?iso-8859-1?Q?hZqqTTOi0QXdAuRrm/X4w4LbyB1yPW73oyDtjp5YHz9u0GtSk6vdi1B1E5?=
 =?iso-8859-1?Q?3letUZWrewnCdtx9GG+KaY5w52RVY7gL32kVHOOFwNfb+dChgXokW7BlGv?=
 =?iso-8859-1?Q?/wlYyOFksqWm9mTdhDQVByRI7V9txUUhB+I6mbNdyDyRLu5nzhCJVje+Vm?=
 =?iso-8859-1?Q?twVfECyuDjgL6F5IuyWrg+XJf23VuzPVpKgAd52I1Ll9jUPRWFXysBCppy?=
 =?iso-8859-1?Q?S9bk3Rv6SafOoztqNp9Rc9oijJOo/sU8ATd+dGTDYeFQBFf8DyYmmoNV8c?=
 =?iso-8859-1?Q?nleMit94pNsAJmWCTT0tDu19CtCHDXJiWOBsHwuFWXFk5PyPrRjT5xdbBG?=
 =?iso-8859-1?Q?WNiOnkOPTHBg5QDqCLItAELrzElhdcewcH6ZDdlMeD0jR6zIDIDy4UwbUy?=
 =?iso-8859-1?Q?G6m/e0XgF3qdp7Xe8+Q6BIBVQDYNGcMFZxzo7LCxckwJ5l7T0Ti6c0z1Hm?=
 =?iso-8859-1?Q?/PO1N/6z7qfG7sR+3/Tpe7Slw7SmkHH+ecvNNo4AnGqTJ/JdGmCz4XWWzs?=
 =?iso-8859-1?Q?+BGPt1UM2oJ2apF+LY73O1bY8a7U50eM7N4gtNlZTMd0vtXVaeBXp76NTR?=
 =?iso-8859-1?Q?Bnz7m7ajWsmbsRlYEooyRfZUqgc+HG8MPuyqNFoMj8QEzL8O1NDh0F8i8q?=
 =?iso-8859-1?Q?FROM5QcW5ScrzwMmev1v0056zLmygCBM/Dw+IPLUUs+/Ia5Mocz0hfJ5EH?=
 =?iso-8859-1?Q?MbTo6rK2tha60HrYmlLip5fJQiBdUg3k2vIMBROr8t16AtjT7MTe87/lu4?=
 =?iso-8859-1?Q?cSBrTGYlMJ5UmS2BtuIxJyo+tdAdcvEE5vPB5S3Nvc6MPRyq98av1yaUSB?=
 =?iso-8859-1?Q?N+AjZ8IG4wLxiq7qxga9fIbnVrPxZQvad2SFNmIH5wvV9tKKd2vCd9K5d5?=
 =?iso-8859-1?Q?sQpUPrzoSd6inSnCW2ZIpoRDKQez65MiyLXe0FqivAG4onYcoU7V08H86i?=
 =?iso-8859-1?Q?LEJypWOtzB2BIXY/oI4z30oV1mPQDYeo/khndhCSHvx8qJYrvQgPaLEk1d?=
 =?iso-8859-1?Q?2TC6hs4iHBGMd4EaT092ya+jMHd98szGzJDqfwSiNrT88kj68OLUGpmYr8?=
 =?iso-8859-1?Q?fj9yY/jcsBroJ+3I/5HZynHJnj2bhOyskqU3z+TcYQVR7gTQgu+MGbzz5W?=
 =?iso-8859-1?Q?9aiT3OhwGymUlYZGor3EM4JtF18zmCs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4fpOuNiH2QLExVNU1BlHbEMvp0msbNYqEk+QwKlhy0GYSDbXme/uBYYr2ctp5FWZpmam+jZHkVr2sNhCBq5Ed3s7QV1NEBf7YoJKV7NmIPXSXHyonTiaHuVUmt/e1YmmESh416vMKIPE+KVm9WC0ngjXz8tCnj8nKO+Mews5PDZVZ+MIbALGcqFmLeV9jjsoAPtrvKEVSX8h7uf+ZP/89ncgwhld2vGBmK2012K38WUdtPAaT9K9nzwnuBTsR9QLDDOACjxKS3APQP+Denhzu8uIam28ql+O0jVr5XGW3arfmHW3zBXN9/9lkDqmNKgbrKhkUagSDjpQzoFbG6k/8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a27afd1-5448-4a68-4145-08df159dce7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:59:22.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UyrvgMJuoc292V5P9ps7tAfAlw6VuVinQZA0FEjLkIPY3jpWCR94KLf4UHGaKoH9kvSpHoZpKS+q6tqiNL/6+O7OnGCsEwAOuB7ynui96U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Sent: Tuesday, September 15, 2026 4:46 AM
> To: Arend van Spriel <arend.vanspriel@broadcom.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Jijie Shao
> <shaojijie@huawei.com>; Petr Machata <petrm@nvidia.com>; Keller, Jacob
> E <jacob.e.keller@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; netdev@vger.kernel.org; linux-
> parisc@vger.kernel.org
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Michael Grzeschik <mgr@kernel.org>
> Subject: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU
> check
>=20
> The winbond-840 driver contains a check for boot_cpu_data.x86 <=3D 4.
> This field encodes the x86 generation (3 =3D 386, 4 =3D 486, etc).
> Therefore, since 486 support was removed from the kernel in commit
> 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
> condition is always true. Remove the check.
It looks like condition is always false, isn't it?

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/dec/tulip/winbond-840.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c
> b/drivers/net/ethernet/dec/tulip/winbond-840.c
> index a5581f1d0141..c42eaf0eef64 100644
> --- a/drivers/net/ethernet/dec/tulip/winbond-840.c
> +++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
> @@ -876,24 +876,14 @@ static void init_registers(struct net_device
> *dev)
>  	i |=3D 0x02;		/* give Rx priority */
>=20
>  	/* Configure the PCI bus bursts and FIFO thresholds.
> -	   486: Set 8 longword cache alignment, 8 longword burst.
> -	   586: Set 16 longword cache alignment, no burst limit.
> +	   Set 16 longword cache alignment, no burst limit.
>  	   Cache alignment bits 15:14	     Burst length 13:8
>  		0000	<not allowed> 		0000 align to cache
> 	0800 8 longwords
>  		4000	8  longwords		0100 1 longword
> 	1000 16 longwords
>  		8000	16 longwords		0200 2 longwords	2000 32
> longwords
>  		C000	32  longwords		0400 4 longwords */
>=20
> -#if defined (__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
> -	/* When not a module we can work around broken '486 PCI boards.
> */
> -	if (boot_cpu_data.x86 <=3D 4) {
> -		i |=3D 0x4800;
> -		dev_info(&dev->dev,
> -			 "This is a 386/486 PCI system, setting cache
> alignment to 8 longwords\n");
> -	} else {
> -		i |=3D 0xE000;
> -	}
> -#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha__)
> || defined(__ia64__) || defined(__x86_64__)
> +#if defined(__powerpc__) || defined(__i386__) || defined(__alpha__)
> ||
> +defined(__ia64__) || defined(__x86_64__)
>  	i |=3D 0xE000;
>  #elif defined(CONFIG_SPARC) || defined (CONFIG_PARISC) ||
> defined(CONFIG_ARM)
>  	i |=3D 0x4800;
> --
> 2.43.0

