Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04133ECBDA;
	Thu,  3 Sep 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430947; cv=fail; b=YYUm2/aHK7Lv6nfGITz9To2bZQyLD9NGUmQN2qiQa+DI+X+WqOmHdcfx/bWkh7SAorJF9IUzsfceN2fi6FPiYmDpB3Kl9Gpm3tuAVrJ6Shfbqjma5oEhkcEjy9JRLsuKkMVILh6JYsgc4xgTGRJl6+IvLTQJLMXgczHqKJfsgpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430947; c=relaxed/simple;
	bh=2OCa8dpe+IMFC0TKfOe4csV+FL1XQ4dm9VIBbZOm6W4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aP93OxAlt4sMKdh86BM/m8OrJOBNZIVEfnolAI2q855OYMyUKc0+Z2oZEvzNPo6mZUCxl459Lm/eo/Ogi/rwLcY0CNf3pNRXUYcKsVyM+qVxmM8Gbvzw5yZpBZFU6VoVNXw9o4WapA1dKqWYnXS7gNvr5YsmWQRuX9/piHo0P88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4AtyHDX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4AtyHDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788430945; x=1819966945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2OCa8dpe+IMFC0TKfOe4csV+FL1XQ4dm9VIBbZOm6W4=;
  b=j4AtyHDXEx67I3QPf1N2VDys/9odXUesOs6116WaXy6YfemWZuxDadfM
   GOtWNd3a0yDbp+ewjwYRAaopmbr3kelY7LTCHhJdEY3We/nS5y6W3x4c2
   GMgmgt7KwO5oSYC2h4g3Ewi+x1hrRevEW4YWtMFDJSrD4K96aID4mH9PU
   /nB8AVqljDVYg38wNJWLCstsVis3UKYsqbwOB3hsl21BCk6qn53EdIdhG
   iLT++ld4FLx7kBUZRKyfAZSmE6zUmiSCl/3OnsE6eFyCE8/0FbnvaW6U0
   ivB9GnIJf3GmOgnW72MmwaymDyYdl7Z5Xq/68ztjfIDOmhntP5vIgMLBD
   g==;
X-CSE-ConnectionGUID: lDwpxtGsQNGCAommj+Qq9w==
X-CSE-MsgGUID: VokAvV8xTlqAjGIRNSAkwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88673614"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="88673614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 03:22:23 -0700
X-CSE-ConnectionGUID: E/MBFoJcRgmRHU9rqqXxpA==
X-CSE-MsgGUID: 0/g3bIJSQtCSbRP/uytgBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="299543548"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 03:22:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:22:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:22:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6HZVvF6HQI5699NYLq8s09iVfpkIjCJsN96OHHJ+0H8FciYJz3oQqnbQQs/MQRg5BvFbzRrDuhXnlE4xuUTwzQq/pBr32Z7Ri8GCHnVnkrNH1iQ5r6Qly4Q9t6G8XKa2BB6xUz2yD2YwcwbaXtXJDVwS0YfFaALZqM50BtZzsb/J5vzZL/bIrLpIxdHuCLed9uHfE3cowFbftiI/90PO+6Ytv/Hnvs55CaOE1kf8teR++r0vYtMzokuYyodIRfolYdU5GGp+ZLTAbvXzI1vktcNrq7+wQCXzRbdYHpqjG7bPT4IZOKioZbDu6vX8ZircYMJ7DbW5a64RnESsg4uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vi3AxwENBzwYiD8+8rLur6Yzdgct5N3JfTHAbkRXN4=;
 b=sgoACUQCtsivP26yjgddhUB93bEtDci10qKnOvHhjKtaq7NIQrYSlWQA/VHKiFBBaLJyQJkl6qQREYgtRDY/nTz3c/VUeJl8Byn6IRBPn3aIzTCDPQEDnoApvulvEAF7xBM8zFM2xSfJZ5MVmldA9x5hmCje4kAgQVChpWGVZyueY66Qhned3BQsWvBCBUzRKPJ9O0V0HUG9hBZVmqhztK9mDguhuaF2WTNPYGevSrlgACu36/Dhsz9rh5afuoA/r3f0NXFGpEOAB6ArWhX7ShwPea3TbXNXEJBnE2cTC4x9KFjFdOsmmsdC+XGIIE3dt6D+ye136P/1MjKG0bJkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:22:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:22:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Keshav Goyal <keshav74123@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] igc: remove unreachable break after return in
 XDP path
Thread-Topic: [PATCH net-next] igc: remove unreachable break after return in
 XDP path
Thread-Index: AQHdOu1PUGGBvCA+I0e4Uhx2LyDfjra8pkOQ
Date: Thu, 3 Sep 2026 10:22:19 +0000
Message-ID: <IA3PR11MB8986F43DCC22F802B8236D18E5B62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260902093443.93466-1-keshav74123@gmail.com>
In-Reply-To: <20260902093443.93466-1-keshav74123@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN0PR11MB6009:EE_
x-ms-office365-filtering-correlation-id: f7b273a4-a799-4db5-1e7b-08df09a53c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: +gshIqnNNDf4Vlf6BLmsAofYDFae7s1XWoSUg3qw3fuDXBApXdm9q3AYblaILrO3Wj/c8YghwdAunp8gw3y22FR2K2KyiNR1WNzpPfYg5+h8dBXEEM76jk1suBk+Jok3xKjuwWalmJ1t/jqvBesVk4tCMeDri3p4RRL4iKQIxyNHMeFL0eodJnFAK60c6w3eqEHzXMXOIrs/ZWZRbrPt9UEolVNi1XvnNDffHEDzHRHyIVE6H4+vwf/2Hvzg4Hld7eHJ0Opn9XW3nB6edEywV5guqkKQISAZ3FutXJliogG8+nZwUWKkwoKZyBqCJ9yU0vETl+Z3qwFWHAuyLE2z9WlGBcbc3GY2V2ErBz/MkYlNpyebsBIKSFBi55VobCbfbHPVjvKsQ/j1itsP4VE47PLGqerUwn9beKL4k4sD7twb8/WPqJ4SRnldZNZ5eRqIVBumOmWGU8kd6GNOZpeBdBATQXW7fAT5ADLJVYIwfw4ev2ZZkkVi3rPviRpqwl1uZhKPfnTZwZqNZWujoGBn1c5fvyxxYFAtmHoHQaq3XM9aL/I5u1vdXWQX/K+Kk8mZjErU3/aE7XZ4Wt7vMi6vvugZaWyME2hULlAVEvF/T/LnIcTI1R3kaCMaEMZW7zLmOOL7MgnB99mNbGoyX6TMW67o8ermIXJ8OyFx+gYkCehY+zpOyUK9owA/aQSWeL/xxI1Vw7pherG3j3PUq7Rxi3Z7EATlK1BRgAdfw5Ntetk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4d0ScNes3ylO8Zh7hJjGWkMDjSp4ejKV/yjB5vbz8LLfo2y8FrE6+4BvfkP?=
 =?us-ascii?Q?ubuwd+NIiq4uGh9tD92trjB5LZsY6EaxE0ATd4sHcdpTGws7niz1vjAkEsJi?=
 =?us-ascii?Q?Mpsf/OVCdyRT/eYdX/mL1tqIAQjSJnDHfe/RqUw+fZOl6cckxvT21jEXWSBH?=
 =?us-ascii?Q?oY1FIX1ssn4k05MuYNEyWw4d15ZPeIUgBJbghoXGPBMxXQJTM4pFhQvFNHAs?=
 =?us-ascii?Q?l9kQEfNQ8rJg3XEF0QA3k7+Lt2gwcWYaKGnobZ+N4oGH5M/GMqc7XemdE2by?=
 =?us-ascii?Q?EovvQ9E8jNKaKxzJMIqeAcogj69LZ/HDP9i4n8Znra55XeT9VKyVr/ifWDdr?=
 =?us-ascii?Q?zX16ocaSyYUgGBBoe0OOftgmfv2ibu/Vbmx8osJ3KkMVkzuekjqGu7ZmgdNw?=
 =?us-ascii?Q?s2tHZtXBPsJdvq9R5vqrNl+PedIE1NWVXr73dCWKGum5OlZYActMfIcil5Xi?=
 =?us-ascii?Q?6B7kYVjvEsaLnrIPz1rZexxyFX0vZ6/RkRxOQP72FwxEFu4ucZmFLJJHVg2/?=
 =?us-ascii?Q?p15td89vWTPMJbT5L9STD44BRQs0zlX+bSaQeGwC/fJ9xVIYix6CNDzGZcey?=
 =?us-ascii?Q?7QDiCet3NsRQwQoA/A+3yZtkbBgMgha9WOENxszvc3mXly+VEbA+cnfuAZHk?=
 =?us-ascii?Q?yX15zImM5bXQi3eptveWwkpoZth+djm6uBoXbkSEDPbUXWWZe0h+6nsGBtzp?=
 =?us-ascii?Q?86JnkgSGRfB/H/aGY0LMcuvKH2pYHIG3SMX5sudnc+4TvqhKUP04DiI8/1pU?=
 =?us-ascii?Q?jKlNCMJ7T5Bobcyb0YdUtYGGX9f09jeap5UjeSBJVTQxz7k/4+0sS0qTxLO2?=
 =?us-ascii?Q?YfsaB7PsOeO2NQEmSwzVtJIho5zOsISL6UCou3fNT+ib4qtcdhiWNudsw0gJ?=
 =?us-ascii?Q?Q+owUiY/RcpLeRRJzOmUAUOcilg/T8gwufzyXlmpX957rKup75YAj19cRfN2?=
 =?us-ascii?Q?v/HiKXsHqeudEEkzzehbE0JBD3XlRkV3Irw7H2UknYQOpBLnbOI08z/GhTvv?=
 =?us-ascii?Q?eaPraonq7UuzcjN3yKlgrKI+jazAV8LFYIjuRi9kvKrBPiX0wfOp5jHUPeyw?=
 =?us-ascii?Q?2LNfEDjbW0QryZdZWfDIH49oDNRQdoVeVj4Oabk6sPJd3Vma1QOLGKV1z0vS?=
 =?us-ascii?Q?NyitmOmZwyIiuT0WRl1jKC/gr8nD74NiJNqgRgHAIdk3pk/o+v70crYVSJcs?=
 =?us-ascii?Q?RWwOyGOvRnRVq066i9qHOGtguwaJl6DKBErAT3w5zqSN6WjYSVVrB1S1Cq7n?=
 =?us-ascii?Q?rIVWyA5YtkQyeoul2ds6sLs8zw7d/Zt1ZhjmZvxs4IquJbYxhTKm9Phf6RCP?=
 =?us-ascii?Q?1pQBSRb1gPPpZzt5wL/oylImgkaqFu5Mm5tGGkp4Yo1n9LBCE1k3039PG70d?=
 =?us-ascii?Q?E48CpHIyXAXHzAybnrh29xAAEm9iK1fUyLhElIMHVuzcYS4cxTirOQhILaQr?=
 =?us-ascii?Q?a/heWpwkV1iT5td4VCyS7vROjxxK8vedbYGsgQ60k+o7KRQsE4Ys24p7ehMO?=
 =?us-ascii?Q?mst9UOuuzidFzvsbYzLZwcoSqbuSRtbHDsh06OQ/7HusFokKAV2GOq/olqRG?=
 =?us-ascii?Q?LcTkX+TTiDhoV9V+plGc3zRyQQdNbb5u8jnLQNqPMOYlYQ8vJL3G2Sm/xVP2?=
 =?us-ascii?Q?g7RYsoPkTovy+btF8iin1vAab4YFB1A3q92XeRnfVuWGflqi/hq6pNVLz7pw?=
 =?us-ascii?Q?/u71q3azSYimBWWOghfpf/4P0a8G5WGlf2j7+8YtsCF8iU6EMkBmq3ANacd3?=
 =?us-ascii?Q?uQ0/knWpleIYYpQXl5+mcm28Acfe2z0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hDGAQEgJHb8ClIF7GIMI+4QAUNkCcRK21twD32zSu5fd3winYjm8CNWJnpwxaUuJXF2BncTnF3/3Mo/K6CVHQE9jZaXxmDcqzehs0a7IitSne/npL8k18aslwFkXHKXqmzYgiBkinkvx3iq9Y2j/x85eBKP+p5OJlOWvv65xY7KtT/5vIUw/4zpkQwPPHiytsmhi97QhCl0NmAmiMOAjQ4jrw74cu4nN7LxLu9aVc3VbODvPIQ9tRhJnVvQbT7SYK3sqgtpzLgXsWhtgO5v1yy8ftEL9dR3Eu8DGaDYU3SuBLtLqIsR0G/JH0CoMhmOvBYlYUOn4XOJhYPti/WwWJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b273a4-a799-4db5-1e7b-08df09a53c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:22:20.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n38JDyv/cChBajkxeAg+f2zacbpbdCBw+DiX4a37YHjCJYK8ttMtS+WmafWJNqBhZcnr2pOpk34FBaTWJO3ud7a2X7QeRL95XBftdy27bQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Keshav Goyal <keshav74123@gmail.com>
> Sent: Wednesday, September 2, 2026 11:35 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Keshav Goyal
> <keshav74123@gmail.com>
> Subject: [PATCH net-next] igc: remove unreachable break after return
> in XDP path
>=20
> The break statement after "return IGC_XDP_REDIRECT" in the XDP switch
> case is dead code since the return exits the function unconditionally.
> All other return statements in this switch are not followed by a
> break.
>=20
> This was flagged by checkpatch.pl:
> WARNING: break is not useful after a return
>=20
> Signed-off-by: Keshav Goyal <keshav74123@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..3b7dd104d8d9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter
> *adapter,
>  		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>  			goto out_failure;
>  		return IGC_XDP_REDIRECT;
> -		break;
>  	default:
>  		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
>  		fallthrough;
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

