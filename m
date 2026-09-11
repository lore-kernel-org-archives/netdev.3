Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F7415F36;
	Fri, 11 Sep 2026 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160498; cv=fail; b=CliJjZem1ZehAabd2+ambW6AaZMXoWqfdxXWQasP0aH6vE64wFYZkM6aRrsg5jQeiWIgdLUfxxeg56OxTRlPW+uaOp0ysEZSEJIOmii5MLEjVENo63R24t+sQp7J2GTRQDu13nWn1UthdHQvmi0VuyIZHv9spwlubwroEp/XkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160498; c=relaxed/simple;
	bh=q2B6BVzyxm2bZsdPk1VolcKW114Euc3dUqESL/QhPMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3/PnMZS654yme+4AldZeX9IaWeezweZKDtfv5d02hpg1FTbtV4v6QlcyseQfC6+ITeolVSscnMsK51+eNG/wvZgYFer3cTvitC+N8H9XJaXzOTeki5UdRPPqdbIhwdBLm5+4ZQKx3DFo+prejN1f3J4lX+FGbt9kkjiRyjKIQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWMdHqKK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWMdHqKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789160496; x=1820696496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q2B6BVzyxm2bZsdPk1VolcKW114Euc3dUqESL/QhPMI=;
  b=VWMdHqKKVXBXSgwzLVq3EX25E+ebj9B9HpVowskwfgUNdF7IXGj+DrLt
   E+5xE+bT+tVYco7sPIlQrnMfctskJTxaqUxhqoz4XC4Lof5WneZ7/oDyL
   5CcPYIkr/EZGMA2b8UHeMuGbGWHxIWOEK0yiusOjNZqKZ8Isagxjti6S7
   DKmNPTUcKz4OHsxsZ8USXo0N05+MsXQ493RltwHc2U9emPzkM1zAWJrYS
   U2hzIFnXgTf46Wsgx+wa++qrMERid9BV9Ie691GLGaUfgMOWYvhyzhs8a
   eOu15z+H6GtitF0Ni+8OfkYF8C+g0Nblu19Tlucz3CVqw10JGhbQ83T1m
   w==;
X-CSE-ConnectionGUID: HaKhnkDdSsC1ykEdjUPH5A==
X-CSE-MsgGUID: /YqL6q0MSIqu7YjyEcF9xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="115165381"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="115165381"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:01:35 -0700
X-CSE-ConnectionGUID: Ll51+1QwR8ufNd47bqiMtQ==
X-CSE-MsgGUID: Hl4j5cgnTN22QKGw0Lewkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="268341864"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:01:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:01:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:01:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ3Ep1+IKQEwTxDbhs7NHBbwFu0QK5XVGgrhlCmvi7bUo3QXlQxHRpMPQ4aJQKGLC+hz/FtKxRcEynjiBQ8/a0m0/V5Nd73IEJqNUtCPr9m/GE4lTQnSmDYrmPu4ViEBIu12rVkLIGB4VW04smddgWqzQIUv6SXAni6CEwZW4gkHiMmNWze0r5piN2yCNuxr1ZQ6JsCOnO25DtlZin8oVKGKqMxgUzF5PBvh70StGWMYX50uDF4mwToPduMkDsfGma6O/sydYskV0rx5nmhwW+6YY5xxmTEIfXeynTBXiWJFZi1hiZ5DbzUc6UJUFxqguVjKrFXagnoQYEsJ6atmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NgCuMYZ+xLZfX7H5m9w/LZBvyP+YIhxplogNb19JBs=;
 b=sEwdoTP8Bal5ZiKCeecv1LsIzVIfeLdvLirHVF5l2KzrIodFe+OzBe1GWI2ntfu7qbhSTZAq53U4Qxr2oRgoIlPmv7bX8TGjLpqXxsl2zTo75CAylhBprN4eUwE1l+K7JQ0UMRQsdksfXPPI+xid0/Twgkdu8wOfBvBcIwAhXilZK5FoHvLYhwELfYlrk8tKXyC3KnOJ2+rb3/Vv0seSBKlKOoyPt6i+nhhh8vsvwy8w0G7h6stJAnqFTbd7x5DSMNmXoC4tsi4rxt9+t8junnJW9rp7dDkaswKKQyonSy3BK8KPXKqR+se9LmUyeBZS9S0qFD6Os1w6F4dCjMjLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 21:01:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 21:01:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Thread-Topic: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Thread-Index: AQHdP6TJXorQoveoIEahO6vEf7NCw7bJ4hDw
Date: Fri, 11 Sep 2026 21:01:31 +0000
Message-ID: <IA3PR11MB898696171273BDD2364FC424E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-3-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-3-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 1fe672af-0761-44c0-6320-08df1047db69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: o2UL7CfHBw4pE7NRir4sC0/qfwLTScYGkWQlKIVWpOoMwog1rEQ2x1B3DOtgwlRZjcjNZbHInvcHs9v+z8EtQpnnPZMbVHIXMiEO/EWXk9BvLRMbrbSIZIqXAn37Kf77RbI/Gs0OPGZ4SYdtsfG+YOppdTIn62ESFL6m+9jeWaowVGN0+nuspD5NFh/83nUw+NnoxRdpVRfpQCspLO1c8vXh4PiHRzdDGflZ3ra0/pDRirZ8ZpDyRqMvlJcicxMjeq0+1/OaroCxgbE2rqgprO+bvRBS2a48UwooXiLquOeq0OLlLCn0/kJSvkFtjfLHJG8/s6n3CqhBqEI7FawxvXkNTv7N+pipSMmeliGbYi6oYgACa/mY+NA3hx96Fn50ZBm/vPr+TnCwc1nMiU0+0RjNlqRNWmY3Sl3aJp6UuYWPm0hOlp8xFrczPn+7wHcbX4b93vTXL9lwI8rEGXaKdST5EBlxsxfoakdC2rDWYroAlbE7X29sl/+wl4+L3sua4inf/TgDOanUerFmj8oIT0sNIyJk88eajuXeIH+BBjm2Uvspm9VvDUPPBgGxrajLyTA55Z5LzpYESBT/IRyvQ1JDKAcqh+sBc/Uf4qMgF71ecaja1ODZuNfXS/AfGS4tmuRUE0yKOo+eJvlnjYhcm390M3lowOMewxhqVW1miTI009RQlz5Tp4fJXmcr80xm6pi+fQIsKo6qM/EsvdH+KBeMYHNcOnuPrk7Ok3mn0033EnrR59zdYPqgpgNEhivj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ed7X0ic7LfQfN0iecxAr0hJ/3hMlVSC7Ixlyf6wThsRwj4xaxt4FraI4oTBg?=
 =?us-ascii?Q?AtTbHugqlwmEtJmc20Jk+Q6++U+ufRRqW/7Q4p1RbDXsPG4woV/vhLLHVRkI?=
 =?us-ascii?Q?g//fQm2iao07Fj8CuPxLtM16LkQaYF2/U0ZAyHn7Yi0CwKA3/7jG5aubK9bB?=
 =?us-ascii?Q?IZszpI7EWCFPWUmVfj0FOP90bwZT13dDE6G+y600evWz720yncvUCqFD2ZyN?=
 =?us-ascii?Q?C0Itsptr5Fh+LEs1ogr5F30nR99QnOym7k0EG1LkX2RWuazYYSQaPq8PBNJ1?=
 =?us-ascii?Q?sQaf10Y78qX4BqyCvdBVrF8MDoab2SOHUbYocqIj+ions5Gz0Pr7Ki56b/Ef?=
 =?us-ascii?Q?jx7mC+bW3OyUKGZagwvcKvJUQz2VK5wYaIKUBIsxecEbJdlIl2M99lCNuICW?=
 =?us-ascii?Q?uNIUSDRN/496nuJu1Qh+rYmvlNtS5uMq6cq8MIWPASE2OGjYIXbjsf++m4sl?=
 =?us-ascii?Q?lvdiee/iEX5mtA/SSWOLbqkBKv33fpVumC2eQmuoRwBXBWrLdJdh8z07ljhb?=
 =?us-ascii?Q?Tc3i7hb5BprGcxX3OcYdHqcql5KIdHlBQqomrrmM9t9PkT+9vIv5z1hLfjSB?=
 =?us-ascii?Q?i1iwmoD5nZVxbiTS0JQ3mWVF9lU4iPUaSHT4vmkYUgAWBxjg+iyNWVkX/Trg?=
 =?us-ascii?Q?7KmDPiCmmNCaC8AuhCFAR0j1GdyXf8WIaIKsE8VkCtKGwqDgKttcocugONlK?=
 =?us-ascii?Q?TLna/NkHr/sGWm0Gxis8wojJrtPdVRU1q0yoHvqcSYQeETw4ZPi4ejlx8nmf?=
 =?us-ascii?Q?jxePAeOSUD3+ef5XtqbsymUMEWZHbBaPjXgYxEEqMLhBPuACazXLe/NtR74b?=
 =?us-ascii?Q?DXrCBciNb0X057Afj9GDBW7Ewx2Voibm24h+BAo7431knt7hPO3Ae8vKv8B2?=
 =?us-ascii?Q?TIUYQhAL770XUefpOtkjsUwYv6pCqkA3A1CqaTNOfUFVrY4ZscPO0a2YvtBY?=
 =?us-ascii?Q?wEXFxxyZahXrP7si9dtGkoc5UcYG7O9jWDdTdajfqKCxHtt4V4kR26r3bx3v?=
 =?us-ascii?Q?vUUUYWhUCl3N0RzMdUWVAIB1xtQL+pRl9KDlyb9kPmmacyocLJ6v7/J7Dhqi?=
 =?us-ascii?Q?ztylyF3Qw3Oi2itG8q7GMlbilegz+2bfFDy8MNlO3QnAhy/1oYtsSSgaHMMP?=
 =?us-ascii?Q?ZsgoaYBmi8+jlf7Q9dWfqjom0HL7Tbe4ZHGs+A14+e6Kp+fudvg743D17UCz?=
 =?us-ascii?Q?3ddbY1CR2wHOg1ElBBbcKahLkssNs6hhQE/r/6BSD4/fSPLS4zZWesKvjbhm?=
 =?us-ascii?Q?9f8CZsVRRpq4XjNlAibLtjylPgP8Icp/xaargRqkvj9NCyAc4pfMDoYnEFy6?=
 =?us-ascii?Q?DK3yD5cNrHgqeLM54aJ5oQe0vUWi0yAhI8TJLr6SKtAtDxgKd1rlv4vzqwTh?=
 =?us-ascii?Q?3yZhguUERqW8cpJ/aZdAP5zLDzPZ23ryTndpS1pN8pH8DpH1c9nlWwP6M61c?=
 =?us-ascii?Q?JnKEgL0hj1c+4MyGTnwey1+H05Uj9lWwjOI7OPfpxCkZFV/2f9h3rKxy34KR?=
 =?us-ascii?Q?3Ad962h51Wzxuii3UtZH9X9IFcCGM615g1T/cDiUL512jysmcnxXcAy3MpFY?=
 =?us-ascii?Q?yEPN3NTEPXEOcDlOJOcyMf98B1D08z7FuU+vzgJxeEGoJyVIYMQagPxmOrK7?=
 =?us-ascii?Q?v8gyhvXP5Xq2tAPrOhHKyzviL5EP3QQrSLC+veEwXBM3LvnUnkjNX4HSbHfU?=
 =?us-ascii?Q?WXfz/Ns2GEWBZO8TT36E5k+nOIZybNtIznVs7iEGIX2vhA/IRgIjlTnKAZCZ?=
 =?us-ascii?Q?bsTrfSzD/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yvwlPsxjP2jMfjT6OanjNAW0PYWYvQpGrzF/JX+y5uYZCN9T+Jb2liBmprLZuw84mDvepVm1kihYaaHzs3y1mSxDM06AwlxGoN6twntInP0vG7IRlQlRylXRUowU4G75vTeMepWXNsKQz12uMpovqCdyi8BiZKElbCb3Au2Za2gnoQaE0GhcGMf5EuEHtkQ43Dx0qJBbZwCRgEfFhj8t24TCeBzUEuk+RaX3FMoykOOoZYkQWmI3ermtFWG/PwlXc4JPyfz+0rzB9O/Ktk/0dJiLpTIxJQ3AoL3nmWXQbgVSi2Im5PzY45dH5Kb0wuPMrhecoVln0Xdccd7m/ofHWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe672af-0761-44c0-6320-08df1047db69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 21:01:31.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w82CoueixWZSsU2QXLhEFF3O1LmMUsLB/WA7M+ckwxi8F2AkxCRJ1IFKRScxKLd3XHDTG8s3J6dELG9KJr1iKtJDk38Q38G0Y6SdOrPBJCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Hemanth Selam <hemanth.selam@gmail.com>
> Sent: Monday, September 7, 2026 11:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Randy
> Dunlap <rdunlap@infradead.org>; intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [PATCH iwl-next v2 2/4] ice: fix typos in comments
>=20
> Fix typos in comments, found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt. Only touches comments, no
> code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>=20
> Notes:
>     v2: designate the patch to iwl-next and use a subject prefix
> naming the
>     component, as maintainer-netdev.rst asks; v1 went out with a bare
>     [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff
> unchanged.
>=20
>     v1: https://lore.kernel.org/all/20260907064528.6602-1-
> hemanth.selam@gmail.com/
>=20
>  drivers/net/ethernet/intel/ice/ice.h       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c  | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c..e5f940d324dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops
> ice_xdp_md_ops;
>   * ice_is_dual - Check if given config is multi-NAC
>   * @hw: pointer to HW structure
>   *
> - * Return: true if the device is running in mutli-NAC (Network
> + * Return: true if the device is running in multi-NAC (Network
>   * Acceleration Complex) configuration variant, false otherwise
>   * (always false for non-E825 devices).
>   */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..fe47ec0ba809 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused
> struct nlattr *tb[],
>   *
>   * Features that need fixing:
>   *	Cannot simultaneously enable CTAG and STAG stripping and/or
> insertion.
> - *	These are mutually exlusive as the VSI context cannot support
> multiple
> + *	These are mutually exclusive as the VSI context cannot support
> multiple
>   *	VLAN ethertypes simultaneously for stripping and/or insertion.
> If this
>   *	is not done, then default to clearing the requested STAG
> offload
>   *	settings.
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..9ef1aa66fa2b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf
> *pf, u16 restricted_id)
>   * is correct etc. Then disable old mapping (MSI-X and queues
> registers), change
>   * MSI-X and queues, rebuild VSI and enable new mapping.
>   *
> - * If it is possible (driver not binded to VF) try to remap also
> other VFs to
> + * If it is possible (driver not bound to VF) try to remap also other
> VFs to
>   * linearize irqs register usage.
>   */
>  int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int
> msix_vec_count)

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
