Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD830D3F8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746211; cv=fail; b=STbUuo4a2sJ9wdLHmJUs8hNUk9gubWZYrWnb6ESjGFHbcHnXPVu4DoX3BptX57N4xz7t3ayNOJcK1mSV5xELK3QSF5vdHiZHzIBQBUxqBkI14KmjOIwrURQhx5t3fGL0EC5fFp7mAliVwhQNTVeYPF5bPB8o5bWayC7hun5yaSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746211; c=relaxed/simple;
	bh=EAMRRPwb3F8SKY28P/8L/6XhjqM5Vpe2bYbyKZ5Rt7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUm+NNELtnt4eVz9J/h+vZawOsEFfeK0VQR34dhU9Yx0R05iQE+0m/JVgbKNLddEBRVL6ETQq6QWZNpxHmUADttcoZNp/gKutXFm1re+09gkJcepNTSL8lhnpHXSkca/a86iUipmxbh0Dl3MzCUi4kM6eSeAOCCiNTmA3GpYp68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGbSiGvb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGbSiGvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746209; x=1821282209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EAMRRPwb3F8SKY28P/8L/6XhjqM5Vpe2bYbyKZ5Rt7A=;
  b=TGbSiGvbj75WFKpPPGXxDElD2OWXXWHoZBYWvdlf2c8Mvn+n3X+98SXT
   YJl3m6bCxG22N+ZtLcn/GxVkuMG/+ZI9dlAj6NrX5MUSJscNv0cY/8BwO
   G6Vm7Qqsw9LuGpAJA9rDzEzkq/76T8Ej2XbWoRuZUj7/DoyampenQNq5w
   ViKeX2Z+ECUZD+IZH2WRTPZILVfug+7OqrSWF5Tv8MHEVaABW79RPM44S
   y/AWaWViQgzdVosUJIUCrgI4U0F3fIdQWI3h5ZrLIhPXY7UhOSl+m4uY9
   /+20XLrnBupPya7PZ2WMUav1xZVy8q/h49HVzyD8uEZ7CEKp1nuOF9U17
   A==;
X-CSE-ConnectionGUID: F/MqWn5qQ6iOlwBupebHMg==
X-CSE-MsgGUID: aSsrdnX7S5GABGeJ4SZbTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90393099"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90393099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:43:27 -0700
X-CSE-ConnectionGUID: 0/fXokkrT5OnXsVhx9N0QQ==
X-CSE-MsgGUID: vlq9WBb9RWuss2t2hpPIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="299563049"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:43:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:43:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:43:26 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOTh3GBCkrGkDu5l6eYOKJUk/r9omwcxhWFcGAM6+bnNy3WLIQHElGqi4wwn4slavjIt4CuXf0iKyxi0pUPHh52mE/JomidtSTtb7Mkb4GXPzajItToxEETGHxIMWX9nRo+9ubXS+VPyTtp5X/z+Xm4EP4QOaJJp7pf3LQSo0NgkCjxQZUVXuT8YSFkaXlal9G5pHn1thwd52gtiEMYes7E2MPJg6obecykbf0yhvPyxDT2KuYGa3eOcFHAtxUVvOK/AYTAGn80HBOsEBYXP1yAL5Na3LB5bIlCV63+HZJmVXkEK/WChERSOxZlB/mxELThVaAEmdZEuydQK5CmLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+tm5GxJ9gJy+4VPovqYHq6I//hZvKRN7uK2K8PX6jI=;
 b=tjGEcovWukW4kJwbIsv7FBd01wi8deogfjb7pvU9itlv9Ar88PfIYkq1KENKS8N43q4uRvD5pB8luqzvzJNFE5mS2f/1VI/6EuPne1bUgc66DmVg2hGh/it9M4BBG/NbYLC9dZoqQpWTmfKAzO+/U6ECBQf7QQgrhtL8EZyfIvXpVWcraKO/3FbLS1nsu1+xNUyhzS5wkbTWwJ1BF6CoJfCBrkJEN4ybD1ugLJj632fYxG5ivC5IIZVHhT4j+sQpiidP4/ixzvr2kq63/rqO5gFviaM6pv7Qe+sS6PCZXyerMpxFzJAjTDBsFwbyVgy8AF/N4f/IOHKn4Q/Fud7mFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:43:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:43:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Rinitha, SX"
	<sx.rinitha@intel.com>
Subject: RE: [PATCH net-next v2 02/12] ice: remove unused ICE_FD_FLUSH_REQ
 from PF state
Thread-Topic: [PATCH net-next v2 02/12] ice: remove unused ICE_FD_FLUSH_REQ
 from PF state
Thread-Index: AQHdRtPrnNDrTrsSbUS8XqyLfvdYk7bUexeQ
Date: Fri, 18 Sep 2026 15:43:22 +0000
Message-ID: <IA3PR11MB89865D8DDA15F0B6B9483F52E5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
 <20260917183927.2692068-3-anthony.l.nguyen@intel.com>
In-Reply-To: <20260917183927.2692068-3-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8622363CD:EE_
x-ms-office365-filtering-correlation-id: 47d24502-2820-426f-7cb4-08df159b91e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: P6lVYEFraVSMC+jNKYW2Xz2cK9qcLFUVmOQQ70MWx19yHFHcnVTI9dvLJ2OM+It8Sc/WembMDwebqmQ8TAwYVoO6f0s+Jk8YpGfInjNkV8QrslJG3UblD7wGLwe8ed7l9OCT1Q1Pmsz/aTy8SlYlly38AuRlwlYRFvVrQ5oF91+U5onHO7oZuqL+W/VptRnKagoFB2elNsulUL2PczsWWFLqqQirD8idlxH70dJzF1FfEI5xHRqFeNk10KKaP/aP0ysRfDXgF2jh659Hp95B9iO6HzUr86CQh5rTCl6zX3KkvS/FYRWBP5bUf0uTZE/7tn5QclEeaK+xxMH4r8r/4wM6ze0UOlxZb3wNIDoTxjvejNRlwX658/+pOumUq+J576Tbi9rCfnu3jJnfnanIExdjXjaIGlMnfk8chdgCuvTEux7cF/whJoZZc6pctC1rhBbKL5QXTwlLd0de5+u9mN+jhHO0I4NNPYjKDEhOPJTgnduaY/nCT5NjUpF29P40SJhfsvepvYeYzuwwqxYQLOHVBTkYTPWeyTK24ylaKuZ3WEV5LfZRJakiXn6gRGe/j+UGOhMzbBFneE0oajBvFz+9+X2D01D8twxFYYdrtt1SeT3CMQ+AmB9f4S/PsI/PPqv3loAMZWh7T6shhk9sseBEncnO4hWV+4mVkIUTXjK3aKskj3jyIGo6Qodw36R8t6AznUULYXdGD78Od5X0FV5gEQRbpScqkQBSqJMdi8o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z2UhmIpJi0EDdNFH+q0gGEJsyMkSW4ZZ3hlhBRme/Zs62qvHw03DlO3648Xz?=
 =?us-ascii?Q?3IwzKicGVpYFvt2wQgvrfleVHKUU6Re2gE6B8dlqxo9eNwF/zSj+gJeynsdO?=
 =?us-ascii?Q?jCKkqCz3niOUULgJ3jSdoFVAeAi5uPp8JYaB7/M+qKgLViqSukVH3O8w1Jmf?=
 =?us-ascii?Q?4uh3/l/CA2ZOER/j/gWGlWaDG1RA3EL76AGLFVNpyJdvyhauCXOaypgiM0Un?=
 =?us-ascii?Q?Qa27Z5vyjQdTYadWjOis+zm4bxzSlq15l+rvbNP61PHfeRM7wUQwm6r5PY+Y?=
 =?us-ascii?Q?qTv5xEdUfTH66lKe2azPWmaWVyMAkgvMLc9x/+eD3DNpKyN2VN4o5rEdE0iA?=
 =?us-ascii?Q?6vzug3rmuODi1iJwe0bNDXpLSwsBvUc7zZ329cBVIcj0TDF+87JvNl5DVFSw?=
 =?us-ascii?Q?OcSpBA0aEvUFM0YVuQyeW7J8rwuxf/HRyfb+JATXiVVy5d+R5l/nEYGTYHWn?=
 =?us-ascii?Q?KIfDFBjYzvLSM7F/huPX/yaSia9NljVsyNggxmNWoOMAmerJUtZ12YyDChct?=
 =?us-ascii?Q?MCHKNbuziHuovwKoRBXerf3PShcvJYf8Be44D8Ku0e2mi8v+sarNXl22gGBj?=
 =?us-ascii?Q?QDyR9Y1dc4Zi+it8d8rjEUpVBuuAx4JK23FfjaHDfy173wFMNg8hRoKFXmt4?=
 =?us-ascii?Q?hSwgIZsdlcQ/3RulPvh1a8ynhBsQFXz2kGn6w3CZL28e43kJn0xIQY3jBFJl?=
 =?us-ascii?Q?1CkePNk2xlZ5m/s5ihei6TCpFj6XOXjrdx6HNkMl+xABXE8AT+0aKHBb/2kN?=
 =?us-ascii?Q?iJXmn16bHklKlTXPcyDpLx4vUH60R+YazKr5325gW8VxvaJ4xYN92XpabFJ9?=
 =?us-ascii?Q?6z/Yr0/CIQxFtqLN1mmKTnBtPyzk8SHnN3XuG8t5/T1ooUeyDmAlg0ulXBIE?=
 =?us-ascii?Q?8815KL1YrwFUvWVO6x9w0fzWdIYCywBAVqERoYakCejc0GBRqwJ6bTkT5WCr?=
 =?us-ascii?Q?P87H7xL0J5NYhFtXnoEJqKXkuPh26mygrnBdNk/qWsJiiQjUI619Q7f3JpbR?=
 =?us-ascii?Q?e7VPC+5wfbZGewKw4qSpKIO8eCgqlKzJwUXIK/SAeEDeAHyy0WiBJL9lXUgF?=
 =?us-ascii?Q?GA1+Uv/R0XUxHcgvkYnWEAkxMRS2rk/DPem4wWRhn+5MkcVOwT60cs1xOT6t?=
 =?us-ascii?Q?LlappYIydXnb+ve1/h/IVTtScHaiyaXZSkjAynsvio/Qpb8mbEoqPqf91lvp?=
 =?us-ascii?Q?iYXd3iGDVbnm96qFFk/vOOQSrmjhk+jvuxMUfD2O4r9Bq2wABYCcGtdu5YoU?=
 =?us-ascii?Q?K84xUgvu7+T6PBm35wNafCcz4hIjxglDqmGyjBMw5ewGY5DO7mCj5UXHnGfQ?=
 =?us-ascii?Q?A1c/j7FQSido66zPmuds2VsBfwoBO2KjpAE4IsYXqAgdAoCAOFqv5IyAoezQ?=
 =?us-ascii?Q?039rj4QuPkC3z6Cw4sID9T9qX8Tsl7YsVBwOx3LDujkmnmgQpmcKw5Rzr30F?=
 =?us-ascii?Q?kTg3jQ/CkE8lAw7+GBPjI65lJne27Gmri3D0KCtj6scWoKmlFQVMfLtAR4MW?=
 =?us-ascii?Q?3TAcHikdu9Iy2CdcZYdbgnjpYPsu9gK2XgAop0sqa/vs2e/X/5Nl3ETwz2GN?=
 =?us-ascii?Q?3e7bzV/E91WACpjSTxhVeoKKjS+aQuIASQSyvb1X2siaGKv2DrCNeshMM0t6?=
 =?us-ascii?Q?Bi93XHpX+s28+Swihz4ClgUzrW3Hr7CV72Bz0n5w5w9kl1fCdeE4O9lzOkgy?=
 =?us-ascii?Q?yGKTnmHE81FruZlyB65cTtJy92XcDF7EQKtQ2mg7i2W9OZOoSfV8Ps19WyVC?=
 =?us-ascii?Q?K16cEkpD71ZNkj8KmWu6ohhRqiWTrjs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UNfL6lm3sTVrAPvmDg0YJdQ1TyWLqyLgv8VffOf5LFA2lAsP1stl4Yhhbddj7xTiFNaeOZb+MuBIaPKrQbXn1b7wXAP59xnNkdc/Ce7fTSH8TAoHfOTziE2b95mjXG00CXwV+HrW8ZYlAY8xhD6LjkHuk2Y7RpZ1BLQHOPbrbraA3blY2g1Y+SmIlKl1PKHdoh94ouUge9YFilWR/+gCpsfvHVyR6w1eGfUuZXP0rDKHTUgLw0NQW2gaHWpc1mjrWxYhVzNrSPg2kc8H0W9XN24aq+Klad448K1AH1LmT/uo7AGkAdjRHDkVFw/JPSyjkRUcvzeRXl6Fj/izxjvTcQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d24502-2820-426f-7cb4-08df159b91e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:43:22.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uACUaAHQzjEy290C8DP+SwyKLukGNGe5bit1+YBc4sz0go2r47RQN6x8mT5My02TxootXtrTzxmQN4nrGsnBVfSUs4cEjVFJY1zQfhJC9v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Thursday, September 17, 2026 8:39 PM
> To: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; andrew+netdev@lunn.ch; netdev@vger.kernel.org
> Cc: Marcin Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Penigalapati, Sandeep
> <sandeep.penigalapati@intel.com>; S, Ananth <ananth.s@intel.com>;
> alexander.duyck@gmail.com; Rinitha, SX <sx.rinitha@intel.com>
> Subject: [PATCH net-next v2 02/12] ice: remove unused ICE_FD_FLUSH_REQ
> from PF state
>=20
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
>=20
> It's hard to tell what this flag was intended to represent. The commit
> adding it only added a check that was always false, because the flag
> is never set. There is no relevant comment and commit message doesn't
> mention it. Therefore, it looks like it has always been unused. Remove
> it.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at
> Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h                | 1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 3 ---
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index cb7a73bbcd71..a56e9b7c4dad 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -302,7 +302,6 @@ enum ice_pf_state {
>  	ICE_CFG_BUSY,
>  	ICE_SERVICE_SCHED,
>  	ICE_SERVICE_DIS,
> -	ICE_FD_FLUSH_REQ,
>  	ICE_OICR_INTR_DIS,		/* Global OICR interrupt disabled */
>  	ICE_MDD_VF_PRINT_PENDING,	/* set when MDD event handle */
>  	ICE_VF_RESETS_DISABLED,	/* disable resets during ice_remove
> */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 744cd0b82470..516b57ff3b1c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -1793,9 +1793,6 @@ int ice_del_ntuple_ethtool(struct ice_vsi *vsi,
> struct ethtool_rxnfc *cmd)
>  		return -EBUSY;
>  	}
>=20
> -	if (test_bit(ICE_FD_FLUSH_REQ, pf->state))
> -		return -EBUSY;
> -
>  	mutex_lock(&hw->fdir_fltr_lock);
>  	val =3D ice_ntuple_update_list_entry(pf, NULL, fsp->location);
>  	mutex_unlock(&hw->fdir_fltr_lock);
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

