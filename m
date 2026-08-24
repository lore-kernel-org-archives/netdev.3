Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3D3E7167
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560520; cv=fail; b=XLtBTBBOKpVj5zrqy+omYOJiqsvX83Ba16ugGYGMqOJ904W9aJ0qYj6uzNL+N6Bg0YDrgUBFU7TYkq9cNSY7iz1IIiuhi+ltiRhQ6RLCQNTsjoGm3rsEXznTxSkLTmgbH+IijwzG4CPQ47gSxCPeuY6678Aet0vX+yVIAH4SPuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560520; c=relaxed/simple;
	bh=m2ijAy9vTdhJjA6b22sV+g+PL9r6jBiWwYOIrzuv6L8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EKX5/1NGGNPGZMaFQ5R1lqolOPSruReLpsK1ymuCd9v5tfO9bomvoSr8mR45Fvh9C6avLbjHmHEmcmxbKaf+GbxHABz/dwqn5Bvf6zQgqe4oGeoe+pjstk5bJhiueUeeNnexjrz9U7GkQq9/xWvJC9LDrUDEAfKXN3egkfVGhC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsIM8CvQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsIM8CvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560519; x=1819096519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m2ijAy9vTdhJjA6b22sV+g+PL9r6jBiWwYOIrzuv6L8=;
  b=UsIM8CvQIF6OkWarPH3dm1ZHGa8uFnrl30EbFKFHrJRoAlAPO1dvaeDv
   eNxBMmvYZIaDleZ7/Waw50aq+VbDm3mKLxicNqzZah5JhkgwjjLr7ipTm
   zeUcEdxvTPyhXlQjUBDHgvRvEjvVITrH4KsD6l+GmYdgrn6ZS60Xpj2wR
   InOEQ8Pryp/PRhsOiiZ733k5qIW/fidd2KrWea6RckfHO2hh1ihaofS4b
   +AEUHxwwTBoQSvTUhKWljNJJYQL7MM7xC31zXsJ0aIwMow07nwiG8cy0n
   w5pNaUZPJ/RM07WLJi/kl7pJxFThYw8eQ2BYqy7fL+azaBTQ8GOvlunoL
   g==;
X-CSE-ConnectionGUID: O5J5WgN4S7OpdGRflC4pSw==
X-CSE-MsgGUID: QdWbIHwmSTyl1ZiIf5Mg2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="110791154"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="110791154"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:18 -0700
X-CSE-ConnectionGUID: aue5sDwUTmuWZ/WkIBnj5w==
X-CSE-MsgGUID: i9wS4S0/S+GVbLCrSEwpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="268898300"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 01:35:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 01:35:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 01:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TX+WOTUur2tCyBcf0OHwsXGoLp39SR9MIVc49mdguQeBzprQGE7IPn48gzIT7LQU7GkmFovnyoyeq7cR1hMsQ+70RSB0IQ0MsQlTEWnnhLxuR7vmxVvqOb0VKivcxKyAOQbJqjSjVLQbYIv5XE7/+lR9Tk5IHYgZ26kXgF3YuouyIsRiV6fU/ZpF8PPyplfAZQzwt2UJMxU3g7xVlgKyaesd3AsuO5dMIrG9yGMPIIz3ojZaiuh4yXojv9zSaDTDjFHTKPvv5c3R1tFnam137D77J+7QwWAFDpv6m6mYOM7aK6FAXdZ0EvRdJgWiG47l2LqwMHoG+aqduBKckRUBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lzKkTKcW9fGYBDtrmXE0OtvsavOXiYbfJBjURKrHu8=;
 b=L7LXtk234TjPGdLExnna1J8Kb19VO82x/4tsQW5xsq209sRjgBeAlSvUvYAVOSQk7W6RUjg4fZs8pVuJYBW9L31ChFFZ5cyRFm6mMnCg/gOY+MIugSpMuBqJWyNAwYb+17sxf8izlkfwBiAuKSsdJBNP92/NbfEMIXc2viz8UvJmgliB07cSAtkgy2Rotdu6MXPxIqyfxEbyA0shfz/r/Cr5/5yAtL/MfzVvMCogzFOPhGjw6Qkf/KuKmY4/HQUbolVm0Lut5Xz+kdK46viG+NwtbL5T+e+3H1mrNJpmhwzC5GWxnDyjSU496x1jlJ0wLbujeC4ExLUuCMks62Kd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:35:16 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:35:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>, Fabio Baltieri <fabio.baltieri@gmail.com>,
	"Zaremba, Larysa" <larysa.zaremba@intel.com>
Subject: RE: [PATCH net] net: wangxun: use BIT_ULL() to prevent shift overflow
 on 32-bit archs
Thread-Topic: [PATCH net] net: wangxun: use BIT_ULL() to prevent shift
 overflow on 32-bit archs
Thread-Index: AQHdM5lPkBlPZ+zK2EqYfXOnUqe/JLas36yg
Date: Mon, 24 Aug 2026 08:35:16 +0000
Message-ID: <IA3PR11MB8986E3061021A79E94ED5A59E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <45F5565CE6AC4329+20260824072119.48399-1-jiawenwu@trustnetic.com>
In-Reply-To: <45F5565CE6AC4329+20260824072119.48399-1-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB5211:EE_
x-ms-office365-filtering-correlation-id: 467d7217-a445-4db5-8988-08df01ba9f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: iJ0KY7feSZQX3Ekd1daatm9NqphH82lEBn6WKwhXyLJRA7ymRv46KUwlYWAwM1U9pIsM+eAM2e4fRY35HxbIVS6eWBGg8KvdOrYGkKmQRLnOA8F+m7r3supFykBbntOHi23tQZW7mDXkCXRHA3LOQ624cpVMLRNodqiZdWl2ndz2JWT/1OpwFQ+nXrZrUC+83uAskGY3AcQm8mvRNMRYA660A5/o6FeeKgVIl/kjzfnXff2hWLcztj7IC6RFA1GoWlIU1oC3QsswVgNNxCyZWygcUbETqWWDJbct+Fco+wJDGRyGPyj+Fk/Rrb7Mhag261Ojsg8OcxpQOd+qy1eH/A4dMoMgGcEksfWKhXAHY3t4GLa44d7eOJbPzkGqyJm4GLUCooGIi32jvdEq8ppapf1+FVzze7wr4VhMJ2CJNaUzEzcFvVBAz9yFwbvK523+Pmd6m79MZmRyM64ZWfyHCASeJo0uYCZCxJs4JU3lpKvjC2GD9V0Veh2Eyioamsg0shZPGOl/EBkZYLl8JBweiWjI2AT8QejpraZbQHADJVSqaD7o9qY3gwRVzQ6RNJ7ZnC0oEBhJYkngfMEACej8iFnq0MPiO7YTjYyPO2nBbEqA35xs8I92+RiK75ZIgrbQpVqECPY93+TgCMBXmJiUORSDWoItquiTaK5vQO1EG589Mf6Pw1SO50xfK/a8t2yYZJZRa36E8RhC9wylAnlhnCdn6fCNYUG3DNyALgbF2L8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmtD1LtZ4NTDFInmR2/k8PKvP9E/R8JjR4TWWcb+eCMLaSDEWxnpn3D1AYbt?=
 =?us-ascii?Q?cOW6Q5pd4Zu4CpPbP/mJRj/PtvC79aIHnlt58/zlkfBwfxzLuu5VneEl6nzY?=
 =?us-ascii?Q?BL85cCUkloDc6F02d9Wr+BRqXFTuF56weJVQw0ahN0IdCVLb34TMkR8mP8KF?=
 =?us-ascii?Q?1E+h3N9WH6Q1Zmj4fzl5xy4Krz3dZH3YDYt3+yXiXiNTrokajMJ17mL9IYGT?=
 =?us-ascii?Q?qHGht33gXUtl/MP8eAqGE6G6oxUV46KWA5RtAA931KyPoN8bwXn1fk6ZdYsb?=
 =?us-ascii?Q?S5/otrUp0OHtDv5YLa065CPEA6TLKMtWi3ANKyPm41tga1otCEh0TGVHFExK?=
 =?us-ascii?Q?DVmSo5sz50TDHZ7EDitqHK93MHmWNi+rU106QqAfSamo49uMiMLg9v6KEcv8?=
 =?us-ascii?Q?dq4rz1rRMFiGAyzxaqJpiOoV7TbOHbvkW6OqGo/PQFxZCCXAdS8mFwxh5tOO?=
 =?us-ascii?Q?j/5RZzwh4HNUwbx0nL1bePjgIA7cZEARYyTZRBxioJqJe5nXxXwtYGshWOs9?=
 =?us-ascii?Q?i7U1XvrsXkn8vmBb6N9xUAcR4Ae7umo8xCCmux2POH79ozZ+/PQORv19qZS6?=
 =?us-ascii?Q?J30Siw6ZxNg6IHSci3pb8WJGun/3Da3/7uK4ZEzPfPzGybplOK2O54JrmHqn?=
 =?us-ascii?Q?QJb7BES65ocuLjEvKtkuI2NkbAUGWE6/BKOTN1kQERefmtpWFDiCg47e0l5t?=
 =?us-ascii?Q?DtAMM8dQ6VK5LLJiOvdze53WgWiPDWnjtSsMuevJng5X0faB7cgXiQRxU0xG?=
 =?us-ascii?Q?mJ0KN6wyrWsbBtM79B/2eFYOtKjE6Q/BGARidC6Hy0GXTzvZ9gCCfdMx7gA0?=
 =?us-ascii?Q?f9PJdv3GekUtqEnp9LovnCqljhCAFDstCuIOo4AyjOyWm71mfjaTk9QxyEsN?=
 =?us-ascii?Q?dVINu+Bcg20tmlVmgqFUbM7KarHh2bHD0OhNVHQKf1HRSs+CUoqumBqAxEq/?=
 =?us-ascii?Q?HiM6mJZW7mE1yL3dUXelD40pBHB7BxvGHifsaljySHaOAA7BP/wiypmFCl0l?=
 =?us-ascii?Q?Qoz5tD0RZIYUvwIpdAZfNSy4HBXyAFifuGf2AltuuCNa7HoCq3YQ875mtqNP?=
 =?us-ascii?Q?rsXFKDFMTnUMcl82jpw5skrKqKjkxrXUPpk4TC3L75bPtWeIo8dFXkvJXxKo?=
 =?us-ascii?Q?8yGRo+53I5cZ+caf6XtTZRMnigY+Raw0+JOl6+GJns+13OM/NC4r9L2okJMg?=
 =?us-ascii?Q?ObjBHN1dKqyw++RQlSRlsmD8GchQqVREIqopH32UPqg3CYY+WvXiS1in3VHB?=
 =?us-ascii?Q?5b/wQT6OjcbakRJsz8qLMYvO+Lpb2ugp4t2liADRqePy+b6pNiN4F1nqe2NV?=
 =?us-ascii?Q?GJ8D6+kRLyWuDqJdbYptXv4AsAjLmQuWLqoUpAnsAWpp1KjCc5UuMFrnUA5A?=
 =?us-ascii?Q?VG1zEiQ96tYyA32zJQF5LWLPfvSa1R9Q9zo3vdaD1XgYbCFYCFAXpR8ynjzu?=
 =?us-ascii?Q?bzTCFkgAscjfDnzDLU/XTywuxlFI87y96f7OIZqYVdwover5cQr8ApPjsLfQ?=
 =?us-ascii?Q?U0TOplNnPJXwqyUfk24aZ8vcT1WRt87aK3Vxn95tFntwMuUnxrcoJCaYQKLS?=
 =?us-ascii?Q?pA9JbVYxJWrab4dupSOLe9ERB4BbeZnc8RymX7vQznFHVs4So6HTbRzoqye4?=
 =?us-ascii?Q?81W6BFkyosuaVcp8/FgdNWSNTlm+aTpcALGEzkne74mu9t3Qe/NHngsYuZrc?=
 =?us-ascii?Q?CCXyrndWyQXLphazTcjZzddKOvpdBa7W9vRoyPOdgwWEBc2nAI33FyH/Xdjz?=
 =?us-ascii?Q?17WWJWXr1YmTDKouNMZ3A5qx5yOZhM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5RwobjAKcPBPsyXjAManyCd4D5i6d+ncYIAfoBdznZmCqbx4Eb4uF9Q73oIjuP6u2xg1Gka3emcP6xmURQuKyeBzIzzg2olAjy1bTlp9rnJnxypYGNyN+kis2teQ7iMJKUxFvBinOV6rggshlR7SjUw4PDtz1hKlOmfdfb8UuxT0fU+gDQsByU/p/MV0IddCnN15CsqHH4HBjIdsh1zi9U1pvfV6oz9HiFHAuMe1dhOZJXuFVS99mGHpu8LhgFcodnKSkTudc2/a2eMjdB1pasrYvIyZ0N985/YTqOa2yaaps29V1zjDT/WQwcZoyG8FDzA3wmMnNbqexzlUVl3UTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467d7217-a445-4db5-8988-08df01ba9f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 08:35:16.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1Yz9mJnzVK+PtS+7juV/M8DyhUmQ/YVG1VaUwUSIRzC4ZAvOQBPB6BY5MVRfSVNwMQGktZ+emrMfixbK6eNys6x7//7YRAUM6JghZ9xtVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, August 24, 2026 9:21 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Simon Horman <horms@kernel.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net] net: wangxun: use BIT_ULL() to prevent shift
> overflow on 32-bit archs
>=20
> The macros TXGBE_INTR_MISC() and WX_INTR_Q() rely on the standard
> BIT() macro to generate interrupt masks based on the queue vector
> index.
>=20
> On 32-bit architectures, BIT() evaluates to a 32-bit `unsigned long`.
> Since the number of queue vectors can be up to 63 on txgbe devices,
> performing a left shift of 32 or more results in an integer overflow
> and undefined behavior. This causes incorrect interrupt masking and
> unmasking logic for both the queue and miscellaneous interrupts on 32-
> bit systems.
>=20
> Fix this by replacing BIT() with BIT_ULL() in these macros. This
> ensures that the bitwise shift is always performed safely on a 64-bit
> `unsigned long long` type, regardless of the underlying architecture.
>=20
> Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ
> vector sequence")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h    | 2 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 65e3e55db1cf..0520288d18ab 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1427,7 +1427,7 @@ struct wx {
>  };
>=20
>  #define WX_INTR_ALL (~0ULL)
> -#define WX_INTR_Q(i) BIT((i))
> +#define WX_INTR_Q(i) BIT_ULL((i))
>=20
>  /* register operations */
>  #define wr32(a, reg, value)	writel((value), ((a)->hw_addr +
> (reg)))
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 877234e3fdc2..fddcb011fa2f 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -303,7 +303,7 @@ struct txgbe_fdir_filter {
>  #define TXGBE_DEFAULT_RX_WORK           128
>  #endif
>=20
> -#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
> +#define TXGBE_INTR_MISC(A)    BIT_ULL((A)->num_q_vectors)
>  #define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
>=20
>  #define TXGBE_MAX_EITR        GENMASK(11, 3)
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

