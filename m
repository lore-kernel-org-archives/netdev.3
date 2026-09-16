Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B17372058;
	Wed, 16 Sep 2026 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538637; cv=fail; b=a0C0CcUqmIpKuhpWejnRVNh9zS3sv89WhE3qNMNV1Yvql0r+GJtAWjfwuttVBTeJRK1peyjMcubBK4azoXwWYbpf6sQSTmt9q+oOUQjMdrLecapP2zrTpVySzpZFMMIEdIZaI/DrXmnzZrFclRKHghMblN64UDr1TzoPxkFMFkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538637; c=relaxed/simple;
	bh=5eG5jjCFjS9w3+f3CqdScFuu3ZTkyPbVc054evw15aM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYAtdrNZLzsBD2aEunFxjxQ3v6I4AvBVokQ2ekcCMs4p/EqKDocYLrOUOH6fwcmkRq1FfwK19kok9GRlCdwULBEC0Y+fGhINH0aG4+kQJJn4Nu4hp8QhrBleRiO6y1N9yuFsFumR34d+SRqgZkddqpYbjw0gs3F4J071Zu3gL0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3If8PBb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3If8PBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789538636; x=1821074636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5eG5jjCFjS9w3+f3CqdScFuu3ZTkyPbVc054evw15aM=;
  b=N3If8PBbOBXMaGpcH8O7yc1mgn41lRHwSegdhz5JbPDEdJMZLW/p5G49
   VZcyslVKL/tNf8IdwJi3GmpZMCBFTsm1IHwGF9hO7//31zQKc905Uq38L
   MW9SuxJsWU7nRQBUdP7vYESHNRH1Nn1QvA3E2nrc0jOhnYTzi3BLLV0Hz
   WB4/8TADPsBYYO9zNLPLWjjdRyOI4TVvNCD4CXLl6LZps/sXFkzcIp0NZ
   qmvotyz70W2oLzOpA0DVRj4ouI2d1xV1KwnaXhzSwx9USuxvzweNffCqU
   sJ20WmTMkX2WS6seshN0dUeva8KmZC8Y4Mjo0fRN2hfX7PW7fWlhO/el4
   A==;
X-CSE-ConnectionGUID: U+JAuO2kSoexBWwcyA/lcQ==
X-CSE-MsgGUID: h17PBhVxT3GQ3IS/yHD10A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112678174"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112678174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:03:55 -0700
X-CSE-ConnectionGUID: 27u8AwB2SC6QFQRAIPy5ZA==
X-CSE-MsgGUID: aCvzWEj/S3yRw3C5UQXpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311507438"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:03:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:03:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:03:54 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl4nO/cyoZsZt5nF/PrkVLqM8uST0fMnCDeT0+JGmWX5zqmnpV2zX43l0omZj0w01K2rI/BND7P4ZfhVl2c/0LwoSixgMmOZtKivQUf0OXAvISiwe9NyoeSvQRsMniUz6SD6L/xA1zmAThSthNJWAf2JgqHLJ+/VwLZDxtzS1rz03VHzjNyKI7nrMPCsD894lxXeSY4FLZ23YyYkaCJuTSdOFvgZdCWHSZeBwUKlJD6o04cV7kH5sd6KADbc365pLoj51DFTrFYm40U6FBCJhuODuQ+AgJAEbvsltECIBJskUmf27Uk1flHTJjx7Zv1PpdJrs5NGuplyfyyuzwDHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agIf9bBAnuhwqU2l7HczdkGv+Ttnoi3DnzUMpLf2X/U=;
 b=LwmLb+GO4pz1OsP/IgtXDSaZznb4S6vl2sYtXv9pvgdis+03ysl8/+s2kUiQ1+zZVv10pruVV7Uu6WANXPz2q+NbJ9XkEz5lDlTQlIj8v5e+oDs+KQzZfeeyCLSo/NxEAnBq9FdqK7qo8BEI5luD+J1YwLY2n/Cf5wXwOcpZ4axD9TxlW4boF0tcsFSHLQObu9MUaj4J+NF5r3i0xqwyEO6hhtzDJye3yHXhgW3YYm3EWGjEdIJ6ZuegcOwjNYNFRXRaqClN5lSg2Bbh5/oWvXWU84XTUWqHSf1MDoWOYN06Wf4M4U6/jXPQ9zLEYDtCQ40t7cTwaCPd/ddD6qb/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:03:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:03:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
Thread-Index: AQHdRQrRfvaJSY0aiEeOb2fulu+PKrbQt/Qw
Date: Wed, 16 Sep 2026 06:03:45 +0000
Message-ID: <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915120354.610499-1-xiaolinkui@126.com>
In-Reply-To: <20260915120354.610499-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 33853584-7114-45b4-8025-08df13b8445a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|921020|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: qN04DiMF70TjfG/j5+GtAvzdoOZW/uxAyx1QhT+NUCUzoOv6Mdh5pjOf3ME7Q/cfFFnSn7UnqWNmG0deapFFOUNtz+rK/XWIAeZl4A/W0NFgKCXdcMu5cWFXMWOwA14a+WPP5dgzvUZaQrGfOZ4ITLk5VNHKOsxVrdZiAhabIcM4KcTE60KlUcdeOBUj89pgmtim+9oMwoLMUur2gtJHYFCOX7vvoO+3oKdv0ts7y3QzO0GKAn7nhlf7uwM1/whfGZVF/VCdYDsCP20RCf8ixV3K1AbWCIrfHneJStCVPDudThuUKvsi5iICHY0JJ3a+rHAwJS3tdYwRRncBw6/R2KMdfVYfwFmuvQinciofEJqtr2sRcIK8UcecwkmTyxX5uqOz0QF7Rpvb2AT+70MvyRFZdKKjJ9CDLvHEjo9g3ANryy1Kr7ICEmaTSeMIuzAwh1nDWzPr/LqEwmfB/kRTaxTC2MGc8AapxsxCx6nn92kr4jfHLAXyPlpdIvymw1ZqkQFY9xC3V6J60xJal2R6LhhYdmu0XygLdNnvzoE1wBrbFHPOZq1nxikVxG95OfXyIg92MTWl6dnFzu0c4CcY+W2Y0k9xEjBMPkcJwsELXwuifAfOBuToIarQVLwLQrJoXpwEc2cohhqgNvJlPfg2MnhVu0dvZ2ei8DwoA2Ponh9C3/mrGylZZ5Pw/GtUlE8mNKTmBDRXLl/5m5dfQh2qmbSMR+oqrd5D7WuBOSmafxZ51Af7GWjuqyLvp7Czw6R/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QiK5Cd2QsxPoDRG3IhZB2t/WYYfRdMOvpTJw6CAPGnkDOimG7RcepTUT+V8/?=
 =?us-ascii?Q?n5rKVVtVWW0OXSTaicIC42zEtYgyaatOuufvsuQ3IQTwVLLgiFCQRiguRqXZ?=
 =?us-ascii?Q?zLNJZ40NFbAVAnBviRFTCMqgq8VS+BbS7CYCjktSTd8xKJQiqn7dnrFwCrGl?=
 =?us-ascii?Q?Nvu6g6nrGWN1z3jSivy6kPcCUpaIgZOZAJhdLEM5ALhZDw6HXzX9wYva5o3R?=
 =?us-ascii?Q?mKi6on/ucEubin+HRwLolXl5eTuMsjWfY6kWhpSZqxb/t3WNSWp4LjsmSl2p?=
 =?us-ascii?Q?DqjGFbZMqSsjXemYFo1SOXK0Wz4XHvRYiZyhr/e797sWX1rfTV8Y9mo7U43W?=
 =?us-ascii?Q?mFnFs8lQzcd93OUy+P/45IcXKx3CYHEqUO8dULVKwMlOXMmw2qDb7DWjhFIi?=
 =?us-ascii?Q?9S+DuqwTcEje+thdkaO97ExEz3FanWVLPwW2vP2+rhvMP5yqhk7tLJ5GghUD?=
 =?us-ascii?Q?UYwFwBMNXUPDFB2XCBzACqKSiAjTjvYhc68x1xhDSnHFb09ZZI7Jm4vrDduR?=
 =?us-ascii?Q?A2c5DHxbz/oxr+duaiq6a707F8sAg1AoVBhz+rvFL0f5Tn+Y3JD6dJsbJDvp?=
 =?us-ascii?Q?ot1iNKoxrIp2TJe1eWSZhw0e4IGkywQaTNVyIKGwkmIyaccpYkINUKFuXb4q?=
 =?us-ascii?Q?LXd3NoSJtQRoURPbFu/yctR4CTNd0Yt8RUnAORne5bL2wrEB1wql2B171Pkb?=
 =?us-ascii?Q?qIu6rcg5v0F4B6a1zxKso4BddpQ6bF5Nr+LNkqsK+U8I2IkZIoNX2Tzb0H/w?=
 =?us-ascii?Q?XjTO0ICLD3839nNPHVRdsrZKo/zv38Ds+T3gOjpvroiLO+5UbI9+43gG2fb9?=
 =?us-ascii?Q?jiNxAyu/5ZLTDOxXKTdmsmBpwc33Inzlv9J5/YfCQVCWyI6IFyHZKPN6i0dc?=
 =?us-ascii?Q?A+S1TQ0j3f0gRdtZGgKiDuvy1Tx4j083YGvt+iVnJwGypdxwPYVCQ+79PQ4F?=
 =?us-ascii?Q?JPjVXGC7xWMqIwm8NaCZUbwxcVYPxPYSzdP9H10LYqqLnewUeJ5Mg7QdABPG?=
 =?us-ascii?Q?50bufpH6J5qTy8c+73PFy3eSANmrvjm+/z3reM1kmypfTZ3qOyLRbP95Fahk?=
 =?us-ascii?Q?UuvSBRQzM2hkCPUJsCJVoYwfQr1TCmZUp2MabLmqJB7inM9+OwD6Q1IO16+1?=
 =?us-ascii?Q?MlaSF/Nech427ZDd3RdRYsVQ+QgGORyz68gw00Chc/nisnqj3evqTqTzImnC?=
 =?us-ascii?Q?UK5+/EnhUZE6IHq3rLilFC+Ksdvu6tf6mo+QA9bLypUARJxaR5uEAlH2pB3T?=
 =?us-ascii?Q?TYtW3njMdmGS3Ne+NQaniSD2++xNT9bRMrPpZfW45Yhw+qXkuyYzKgGq1fSB?=
 =?us-ascii?Q?Th4g7WuP3tyUKgAq0VNXvmBXdgPYCyPS7nCRQmoKSdn5QVTyRHCrRMqKFT68?=
 =?us-ascii?Q?O8eGpVahtLJ6FZkhr44xDxLAp8SeYTEI+CV0jnzW1qALYU9Ey2E+saScxA6R?=
 =?us-ascii?Q?GXEb6Kkyq3VcA1FI7zVpUf8xHbACpUY1V7dnWV7Xs0gMH+3RwfMiJITcUtU2?=
 =?us-ascii?Q?YkY1HcJYvKoshdVtTqtyeogcoBMm72sATIJnEJ2xBFzsnVEFaJVV2w4VRy3m?=
 =?us-ascii?Q?MTFPD9ddiFXgO1/pJMbiPuRmpVZDCw4NYRvSdxt/hsNn8vZ6LUMVfVvxqdYU?=
 =?us-ascii?Q?TFLfq9qScHeRBLwJBKbFbDezdKLK/cKlQmipeWaP0eiorUoMy9EdSVLTyvFD?=
 =?us-ascii?Q?k3qTPj/4axVEmdnQzhe3kbbbtQJc2x5FyZw8WUA7uZ5dpndVVkwNBnZOEqvV?=
 =?us-ascii?Q?NlwrZS1tHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C0w6gK+IyuibsGw8j9fenygeeuPFZIYCl5Mj4U+5vkAoOKfBZwO5gKzXWcl91VjFUAnG7WymBIvxkI3cJMzhAE7yz4ppbU6N240UmSxDGqZepye1iGOr2/fT8Qvt+aHLbh31K1u4EMIBLdhEF4cZa5YyNGeU/X6CbE3VhD3Ku8RJVEVbttT20r7VvCx+jqwQ2ZaLeKYVrwx7+Rpka9cbY8LHopALKo01Ei5mA+jNEQPflOk2KUrz11MMRVA7FrIIAp+FIEjxXYmc9WgCbnxvWlNUMRrt9WsGu2jR99psZLKwrA/m8tIgXP1bMm58pfhcK01StYQRvbVcDIGPcFD7Lw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33853584-7114-45b4-8025-08df13b8445a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:03:45.1185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWPutyxo3nC51ELkVpoy0Sz/JR8pZFPSTI/ITLv4kMF2oAJvMdrrUNY01YXPP8kKLZhQPcYPMudNoX25A+lHx6TbWMrzOHMXWFLl3bJFFBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Tuesday, September 15, 2026 2:04 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile
> count returned by the firmware
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
> which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
> plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
> without bounding it, so a firmware reporting more than 16 profiles
> makes both helpers walk past the end of the on-stack buff[] and
> compare against whatever happens to follow it on the stack.
>=20
> Clamp the count to the number of entries the buffer can actually hold
> and make the loop counter unsigned to match the field type.
>=20
> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index daa9f2c42f70..1d6d8b3835a3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct
> i40e_hw *hw,
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
>  	int status;
> -	int i;
> +	u32 i, p_count;
RCT please

>=20
>  	status =3D i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
> 0,
>  				      NULL);
> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct
> i40e_hw *hw,
>  		return -1;
>=20
>  	profile_list =3D (struct i40e_ddp_profile_list *)buff;
> -	for (i =3D 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count
> reported by
> +	 * the firmware is not guaranteed to fit into the buffer we
> gave it.
> +	 */
> +	p_count =3D min_t(u32, profile_list->p_count,
> I40E_MAX_PROFILE_NUM);
> +
> +	for (i =3D 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_eq(pinfo, &profile_list-
> >p_info[i]))
>  			return 1;
>  	}
> @@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct
> i40e_hw *hw,
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
>  	int status;
> -	int i;
> +	u32 i, p_count;
RCT please

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
>  	status =3D i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
> 0,
>  				      NULL);
> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct
> i40e_hw *hw,
>  		return -EIO;
>=20
>  	profile_list =3D (struct i40e_ddp_profile_list *)buff;
> -	for (i =3D 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count
> reported by
> +	 * the firmware is not guaranteed to fit into the buffer we
> gave it.
> +	 */
> +	p_count =3D min_t(u32, profile_list->p_count,
> I40E_MAX_PROFILE_NUM);
> +
> +	for (i =3D 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_overlap(pinfo,
>  					      &profile_list->p_info[i]))
>  			return 1;
> --
> 2.25.1


