Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19132556B84;
	Tue,  8 Sep 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873140; cv=fail; b=W8aa/5eHuMNy21FUSvSBLEK/oHGB1td2uTMpv53Pg9ywEsU4b+MKtYDECEtCTKbY8YcoDDkcXFc0W00TW4cRcMCqqB6/FyBV6EJtmVzwOAnRWswLRMB1yna7GC2L16uWVmUFRRWzafon/bHyfoTRqym4+slMtTaGTtjhhC5uzSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873140; c=relaxed/simple;
	bh=Y7VtdYKOBGX1YQfumpx87V6NLEa3Igal+hvvdO54oeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAiuE1v9ujDzeuEIOu64lKv4vZz5iI28YBNqYmCe4gYT7s/3vKHA50F2WBSQCZCc70yQet99ifSa/nrqNyOCb044/AY0EtKcXK4Hnt0siOb0OO9c1prFVzGp/selUSTqzXC2nedu6hfIcwTPqi5Zj6TpgTdYs7VUpP/MkJTXX6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqBlRe02; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqBlRe02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873134; x=1820409134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y7VtdYKOBGX1YQfumpx87V6NLEa3Igal+hvvdO54oeM=;
  b=XqBlRe025vtHrDU4fSkBCw25HQcy237AdxyVl/tiZP+0irLcQrkBP/8C
   g5W3TtxmdxsOKSvJWbt/1uCqtr1lLom/RmUn8zZuYxeDdR4EuFS6wjAE+
   tN1uWAi/GqKkEXPwZCdGFUyzbL5pehenFdhOKaAetNx4Sv8cAWC/2tVBT
   In/TMkPUE9hvcL6yXNNk8GAVtIMT11Nyhd6qnO+bsaFm0UqkvfuUav7zb
   BvDl9WG66NteCYMH1ialAg2gqnWzc2Xlfja7lAL7FlTC+Xj8wvjpNcBMo
   SyMCHf3KyO/Fx7NmyZCBPbZd+Cj5mPgnadmvSK9i5tZbd+O8T8mVBBvnR
   g==;
X-CSE-ConnectionGUID: pM9gqEP5T/aR1siICAoD0w==
X-CSE-MsgGUID: chkUze4NRhy4OYJqUY2/Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91785433"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91785433"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:12:08 -0700
X-CSE-ConnectionGUID: Hw/1B78pT+Cw5tXaNEuc/w==
X-CSE-MsgGUID: 3wIhVDeETaeMDR089GP5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294497613"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:12:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:12:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:12:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEvJNqEOrhg8TZXBTZE15HSHQXZvf3Qx6mLyELT/IMm5AZlXs/ueF3Mg7JjsAZhxkp9Q9PykZc0iWxfvQkDjWws9WZHKngzLN5VggE+UMuDxOBwIHtPVIEh49zKm6n9jSdwMKYLfrxl7YeYeZW9eNNriVl6F6e9HoxNxSP9YPFAqSQ1mIH89LEu/uN5jusLnC2L6NWfuVYHIWVCyUV2QVA5Dc+SpeNRDjHmV3NgMAaC74caOMpUOK/gWWF3l3k6MmHVpjvW0IuPepAAK6Iv4D6t2xARLrgzzbRvnzcVOy2yWZ2mm+BvLf3k9InFM798gCwJbDspBNyux7/lnHChieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKGs+ssWMjFM+MvtwrosrMxUIaQPjLJpOh4CYQ6X6Z8=;
 b=NqnyjGv9V7UPrcjeY8n9JcH7G0FBU2+MsV8ZOBBP5RkdCA5AcWULbQ1Rx6wSC9E1ALiAD1VjoCng/gOsyQ9K/wJVK81L84ENqtWP/+bTQVZOT6V3QwOx0PzwkEKqcWGH7MKGyZHWHJZr5QnKTvXgAeSvKPkLlkiNNtt6nZozxKYu1hzyWXMaZkjopJf+JqLXSAUFSNzvHKOoV229n+8zSNbvC2GBXowTJVUkTnFzW6/aIwuRBlUCCw9fPFtQce7xbtB4rPQBaN4ygWZl0OZ+qHAVxSzbw1wufDABphHGV08NEBKeCN7aCSXOG1bDCSLUcyT7tUtyuGhFBhhPYdABcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:12:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:12:01 +0000
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
Subject: RE: [PATCH 8/9] r8152: use linkmode_and_and() in EEE checks
Thread-Topic: [PATCH 8/9] r8152: use linkmode_and_and() in EEE checks
Thread-Index: AQHdPxOLfYE1x5/BfEaHR4Wcv5bbyLbEqQ5Q
Date: Tue, 8 Sep 2026 13:12:01 +0000
Message-ID: <IA3PR11MB898696F1BEF276056E6D7042E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-9-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-9-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 96d99e23-add1-4f58-c8e2-08df0daac52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: IpgMB4zZVf50C696hJiweRvlgsL+pA7jnWp7CgNiY642CDGeemHPz2ZiUpXNIYdCBLisXg8zDBqNjnnkEzPijrSoldkv9lBZW53ZDzId7nIJJ3HkCl7R0ImnLTQVP/3UKBxIt0tYt8QvKn0T4JsYgwwdSr1eRA1rmmqcnQqcPcVvnZYa2o0uArQ3oQmETFnHcTBEK4TphEsx4FP58EzplEDpSNGY2Li9/J7DSrtmzW6cWtJfZ2ZmwvzE5PxrBHJvxpNULRzidHUv0wkC0Wkb3jcZ0BLrFOtR2C5TmoIiosee2Zz6fRGQVlWWU3dhqvVpN0Q0+021wvAEq9zvG3OUvNLQb0BtHvsW5YSRfjFSP9oIVaYkcsTiZ9EKiJYCLrlwqeh6QWkKU+4YbEO8ZyAyNvv7ZbiS19o/Cn2gX096YvU6D2xn3Rtae13kvO9ROtmcKUffF9s8cKyXG2Atl11pESE1QqbzQaoCMaz842eXFaIUF1uMjqSguc0JjwAaNMcSWXUsgtelzvCHl4VZcJ75PZF8vlsXjd8CQEFeOL8yskMfF3i0QSkJxByGDp3wRJp8KKDmqrYqjHITJjdv1MzplBm9fO6+SVKno8MStKqXdaufDqW5yyJ7z5d+SDLpAItvWkXm0xKpy6BgYPE7gqtqNO6xvNE17504y0CgHaH3xzRAIIEENYsSadyMPxEL9zIHXEQZHkZ7BtKkLpAGZqe4GKI6UZTQBm+w+4yw0gr5kxuXVN+tnW+0VzL/veBFIeTx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gep8iibIFDLlEuEQATiw+BIGl3EjXuSvx3gANUXMLVgBwRZNdYqJsm8G2bRP?=
 =?us-ascii?Q?A9HfifaLe6VSRAs+UT/pjCxatwKwpz+NxoIAWZzpNIo+n/Ba9j0KaYxq+R2o?=
 =?us-ascii?Q?Yf2geZjO9LGp/+bqR/a1t8gP4hs9/KmB7AJzncReroxnrqYii9zfNf17TahZ?=
 =?us-ascii?Q?nO+B0j7J3pyIG4jq+FvBMfIyXIp5K+degcGo7NAh2tTQppT6CdfrX9eiABSl?=
 =?us-ascii?Q?dPmejXcXApni3egDakwbwN+hl8RCCZUtzcHA1GK5/G96f0Gga4Lk5zzry3a9?=
 =?us-ascii?Q?SF5TPo+AQKgpBdwzjolpxUfxMT/1XxcWM1lg3kFgPwSY1QhAchn1MiJV/Moj?=
 =?us-ascii?Q?7WDLjTbiHUFA8GDLd/CVSnyVU0NclfT6QkeBMbK3Sutw7VqPlsDQRvlcAnNE?=
 =?us-ascii?Q?SzYYD/z31uDlNQrjZTMSGWQuxlJtm1m5pQAqAhoyBTAPDDiwDIFrgV8dS0Xs?=
 =?us-ascii?Q?OgQEgFy1gnbL30Hh7N7gocX8G9vCyCjQqFZPwC2itV9VIV5vh7S2vVgTVoDU?=
 =?us-ascii?Q?LXDeQ0DGdNBvOzQeJ0MIsUadsaAXl9tkg2Zn3/bcjiF0xbfDHl4hTmZvYgf5?=
 =?us-ascii?Q?oRjUurLMhxqjuMgz3gmfTfo4iLmdfMONBwknqdsk01ECWeEgzclMt8Et0rOt?=
 =?us-ascii?Q?yZfnR+L1Yqk7tUNJsdz026dVp3ZZ7Zm4WCIe3aAEeaUVrDRmvqbuHvnN23XH?=
 =?us-ascii?Q?Uk6ZqcHIw4U4nhW1cOcRmiEIpBLRgkuCbV2CLz1oewOi5wOmZLBpMnLyIDN5?=
 =?us-ascii?Q?KBg9wDetWiqjBoy4VsKKt1C+Ez2YWq6Iq4HYPd2RKDzR3fJJdpvQguQwvnK4?=
 =?us-ascii?Q?BBXhy66Hs78u9hoB4Fp15+CtFAQivX8oj7ai7DTLbePqpKCJmMbbjcsXeKP6?=
 =?us-ascii?Q?Gmmk08S1xQKy2OnNui1P329jMx1clAnQiM9Mfvbpz2YHcWI31j7TqR/R4L6q?=
 =?us-ascii?Q?FydY9A0wFq/7IpNCxuOVnHYkhr2iQfgjJheRPvzJPhmU4nlivFH8/N+J0URJ?=
 =?us-ascii?Q?fqBxbWj91imv8pMPIYNdurkOScu/M4mokwskoXIDHfdtf0j8r1XVLO33JFNs?=
 =?us-ascii?Q?jjLLwOdVBpvFwbBuTABWjtDomtNvZKsMw1gvlEtSmFxAU1vIs9QeudXxtUd4?=
 =?us-ascii?Q?cqOTtrud/5avOsdY7rwzEJ/TWRmWKeZJ9s/zBXbfEd3otZ7KVUuGlwldF4/1?=
 =?us-ascii?Q?11oiU4vJKFqOCF1Be7thTQNDt3z5KUDatoJK1eVjVNUhyCpPPy8bM7wI/Szq?=
 =?us-ascii?Q?LTNvByeSoO4OAfY1PqafO9yq6/Ao46UtGynnudJuRgfzB/gpuVnvPhGrhwTs?=
 =?us-ascii?Q?iCL9yUPTFBM8MZdKZFv1o4EGKkW2q0Q46yR5urSybZfvYPhThT/d29WID9fw?=
 =?us-ascii?Q?dX/soLFo77a6Tavu1JYcbE5OcRHx73GipRO6y1ofqfyjlW6laShC5xU29Xpi?=
 =?us-ascii?Q?cPO2r/mj+oxXVAVg+yDvi41a4Sbg59ktMgiDx6zA89BUbi/ik+K8jFrked3h?=
 =?us-ascii?Q?ckkFL0yNkTvPxUCLkUfEk+D+8wZb8nc8mnVnZ8fmJ4FdWTHgoSb9/2hqY4Tt?=
 =?us-ascii?Q?CXKvZNyL4h4LePm9P9UeMRhCIxLqTuuFPbyGVuUmzAVE3LMrt6YvW0NlJ+Es?=
 =?us-ascii?Q?5ZhB5YsR3+3KuZr/NhTMiH0qs8eZ4NNOzP79ooyXv1c6k7T+iCKHyj5t/P2u?=
 =?us-ascii?Q?YVG0uL4YlqxPGFSsZGMS8RhCvm4tod/FJNIqLyRMwa7RfulULDXROge46DgQ?=
 =?us-ascii?Q?nI4zVsCmAYI8APv64obSs/HYFIR4TpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GuqT8st57bmMYjOBpuVQu2RUNVjah+YEmlAHvSQu0M5pYT6Ig4oTjgBzGjbltFYwwooYAVFmO+QgY5peM+A/GogurxdVMeTXQq2v0TmuefnBKF+J412Rc+UVR4/jCxWES/sgsM8WMP1gtbF6uH6sH3zPKI/g7cIzFohVRCQTxokml0c0ink4uqHoIwkxqNsm5ZA/XmC/6nwDB4Gq2Y6zvCaIWqtRavgjDXX9xqxXDYr0pzmBj1VgP3rKRQVQvEjj6BgDHNkEIYnSo/AVNtKm95GZcGAT5Zcgjy1y3O/iUymDEZkvITf3cWBRNa2lhVUwxtvN/Cph5OWoSYFDXL9cNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d99e23-add1-4f58-c8e2-08df0daac52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:12:01.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G246Dy9nK/fX12/6ykKE/7swMfYNbaEfZsP0hfN5a86QesmOTmgAaRl51Oaw5qNc3ee0duPaqoEvdeiFzmUUKKll3nKKjq7exKv5pYaCjZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
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
> Subject: [PATCH 8/9] r8152: use linkmode_and_and() in EEE checks
>=20
> Combine the three link mode masks in a single operation and use its
> return value to determine whether EEE is active.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/usb/r8152.c  | 10 ++++------  include/linux/linkmode.h |
> 8 ++++++++
>  2 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> f61686433031..75f0574fe1d4 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9149,9 +9149,8 @@ static int r8152_get_eee(struct r8152 *tp,
> struct ethtool_keee *eee)
>  	if (speed & _100bps)
>  		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> common);
>=20
> -	linkmode_and(common, common, eee->advertised);
> -	linkmode_and(common, common, eee->lp_advertised);
> -	eee->eee_active =3D !linkmode_empty(common);
> +	eee->eee_active =3D linkmode_and_and(common, common, eee-
> >advertised,
> +					   eee->lp_advertised);
>=20
>  	return 0;
>  }
> @@ -9222,9 +9221,8 @@ static int r8153_get_eee(struct r8152 *tp,
> struct ethtool_keee *eee)
>  	if (speed & _100bps)
>  		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> common);
>=20
> -	linkmode_and(common, common, eee->advertised);
> -	linkmode_and(common, common, eee->lp_advertised);
> -	eee->eee_active =3D !linkmode_empty(common);
> +	eee->eee_active =3D linkmode_and_and(common, common, eee-
> >advertised,
> +					   eee->lp_advertised);
>=20
>  	return 0;
>  }
> diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h index
> 49587a2e0f69..efd392dc62ae 100644
> --- a/include/linux/linkmode.h
> +++ b/include/linux/linkmode.h
> @@ -26,6 +26,14 @@ static inline bool linkmode_and(unsigned long *dst,
> const unsigned long *a,
>  	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
> }
>=20
> +static inline bool linkmode_and_and(unsigned long *dst,
> +				    const unsigned long *a,
> +				    const unsigned long *b,
> +				    const unsigned long *c)
> +{
> +	return bitmap_and_and(dst, a, b, c,
> __ETHTOOL_LINK_MODE_MASK_NBITS); }
> +
>  static inline bool linkmode_and_andnot(unsigned long *dst,
>  				       const unsigned long *a,
>  				       const unsigned long *b,
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
