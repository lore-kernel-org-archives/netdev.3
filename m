Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6E3B5310
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450961; cv=fail; b=Mbg/oXYBDEXQ6Ws82Rz1JAbRUkXy7mWWwdwX7+gjPBfSGf93g23T89/4UYAgem0q1fdEaBPzT35hQy305rGLxXu/3H2xFWMOk8OMxsDr3uOT+IET6T8E2EB+4kFa0iWcZZs862hgh/3rqgrEVlsldVmbYDePZKb3kj6+dufMQWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450961; c=relaxed/simple;
	bh=tH//aNTwEXJgD8a+VaQmUViY7Jum6XY4GRpbFlbJJnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWG7fbbsPM76qSMvM0r4KZN0Rf2TXXQPeZpruTOzKDiEsTn0KWL5VtpNrFZalvK3qZ6euMGSpuFbZTllctZgneR76PDYU7VzoRYXuEUJkxKQNKsy39hfQ60kkpfyqd6gbSqBYhE+u+kwnqtJe8UVL9+MK9hTEoSYLOnwZ0GO25M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnemvXmJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnemvXmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789450959; x=1820986959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tH//aNTwEXJgD8a+VaQmUViY7Jum6XY4GRpbFlbJJnw=;
  b=FnemvXmJ6BhW/YEn3/TPKAufkbKno7xfsLQlWu2EqZDl2iqBWkgv2g7Q
   thU0xVsXN6f0PD4BACDU2c4DW6hy8YYf/7FcRqHyLIRSlod2gaxg+245g
   pDQ+5OukSgPdbUefOwfuURj8xES4861Urm8CicbifjvGLt2Gw4qCg7v0o
   Zwo0SLtN3jZPqHpntPQui1FMwh108XO1OANaq/bC/A4td6hgB+7djx1d2
   4yiBGXAgCjbsyAEp7Yr6A/ceg+Gsl+oeH76GC9/VUxv2FBG14Wbiix4NM
   yfUMsc+4olySPVt1nVe+DJCR82z8EeAMfR1Zasy5potD7ZcaewiylPR+x
   g==;
X-CSE-ConnectionGUID: n1ZN16kSTAeQ20awBnt4Sw==
X-CSE-MsgGUID: VKuSUFBgTIW0bnzdAyer9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88942713"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88942713"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 22:42:38 -0700
X-CSE-ConnectionGUID: HwJ/VzenSieCKjv9uNjnCA==
X-CSE-MsgGUID: RQiq5Ep/SLOsEfOZPhNfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1058242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 22:42:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:42:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 22:42:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjTHyvQytqJo2eESI1zdlafa0i6XFgs1V08VgbrLuGkfAy+UJHMJ8dzXBFUakr7dg7vHBKJShqujhJdRPN7wF3J9QBsZM/L7ctFo9YsxeQ4YbgW4Chv7niNz8OYUPcmQDJra32eyXYJetyCs6vTvKPxZBk7l4Mo6E/oi7coBPHQME80JifYdcstgNq9yzEzDilWUzBgidfwYyqZXMR+xgnSkl5WqpdEmmbZfU/vABZRR7vGCf940eIo5iJU2Cb4meur/7uBEj3boplFQ9pGDNpCwTT1Aw2n8pRSW6HdQd6htyKBKQb4B04otqRJWmmKM10+/wHcwdqbA/5TH7/v7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d3Qum+KxqExBs9db12LiL8Awnq0QdhtJh62EvELoSU=;
 b=btPjrwFJWnGc00kpXyK62/Z8dWfb/Jp3G+OJL6RxehL0QB/ZB82Y9tlAoFD6MXJK6dIJxcqrIPGsvAc5wrwJpV+ubfQ6M2PbnNwcQndlQvdRdeefliNIpEcfIeiEwfKAjMzj3asnI5BWjjZpAFe8edv9CppaCaVWAzdSdTlpvxjF1vMXBuzKJYjvtAZLpzJzHJEY2JU24yoVItqVMLzfFTbQm48lzYGY1kF0wGyedZflrsNulTKXPumKXePoSEr2RA94pUXqY/coHga01ddnvF7LglZ+O0QEM4YleVoYq69MTRtCM9pUiPDrA/thZu7pw3TusnCgNz8+fFFW2JF8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 05:42:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 05:42:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Johannes Berg <johannes@sipsolutions.net>,
	Michael Grzeschik <mgr@kernel.org>, Denis Benato <benato.denis96@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>
Subject: RE: [PATCH] net: fealnx: remove never-true 486 CPU check
Thread-Topic: [PATCH] net: fealnx: remove never-true 486 CPU check
Thread-Index: AQHdRLx/QlV71oUVok6+bzJSXscEPLbPIG/A
Date: Tue, 15 Sep 2026 05:42:27 +0000
Message-ID: <IA3PR11MB89865771A4F0F4D3E72DAD92E5BA2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915024638.198865-1-enelsonmoore@gmail.com>
In-Reply-To: <20260915024638.198865-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6439:EE_
x-ms-office365-filtering-correlation-id: 6953ca69-a5fe-4c70-0581-08df12ec207f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: qgvONa4cuveP7O3sBgb0ZLkX6z2s5zjZi/dx6crHpX9nm+RyP2gN3FbPQxWn8U4H9fM4gNv2s5h9VFbKWtOa11LK+StOQtSKTDyGp+cfD0YDV622+FixQLzc6OZZaTPg8Wri0S/ysIY7SsQ4jdSU16fxSKC4753QIer+OvNP2fu9YsNeK0eAhbJJb4Vdib1BO6jCOIagBu0UisDwniyM0Er+YLX8HCAk++2r/rudUEnwoWPS4qocLM6/eJBgqI9bZ9LhHgHgVbU8AGfMeZPVwrbIDd1fgC5bfbs6xJXUp1oaS7ioknIl3unNlNL5mMU/KGXf2lahHKjYs5o1dPhUt2qyVCAvukKfd14qdPdsFWtZCRi7rNExnZAyV3xzRo9sbO7LlUSVeTZig6EMj9VXgyPFH4nEDDIT35RDW43gGHdgxX3HMgyRW6VIoe0hluYOrDM2gj6CYCOjB3YrD4aXlfp5qzw2Ny6f5rZoDMYAmalvJgn9RQ6txV18P/VJSfpRAUnTgpx6EPRhHGh+tVfSa9jOuMcGPAUfzLt2L2DFKMBuF0P0akfiCBklejfVBQOio9jfTZ8kd/w/uaS1/zNVydO2YVpJIRyumsoc2KfdiysDds6FI2dzFmaUmfKsimeU3MkQPI1WKWmLDj7PyGi3RyY2nGkLeZJK4XtIOhywC0PC0ph8hO3Tlt1hYy1fAZHybYPRRijf7LV3F7nocoFdNfLLTPCKtrba5pbOhCTmPt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V9ZJMWytXtY0dzoH38FZTWmR2LNDjntD7r3Dmr8UvCdRMohIPqiUtMyfJh?=
 =?iso-8859-1?Q?NoFTUlOpTtIz+toQVrbcBhRQrkBtDudA4NfznWPRZeP3zEQj/KvWMjtLmf?=
 =?iso-8859-1?Q?mag7hJIkgLGsh/O5biV5fQ7M7Q3eUxoCV9k/kVEBeFV2IlWINiEhjFNCSz?=
 =?iso-8859-1?Q?/18s4++MNUz8jSD4WELZHfoeIQnnCfI3kDOsmHU5uoOklZnOrWM/Mubpcf?=
 =?iso-8859-1?Q?gWMqc+rOrT1lz6gsNO8c6GbNDxXhN93t6unO3oNO/YNaxKWBqAYx7mzKyZ?=
 =?iso-8859-1?Q?axP8FmJ9iwbVXFl/Cu8Rni3yMUu3hwuB4g9VGmMdNVOeyWWi0DUOc4daBF?=
 =?iso-8859-1?Q?RYbDM6FdwDAtShCbm278CF+hpo2pmJj0qQpEBYIu0tAm6/grIZ668Btcig?=
 =?iso-8859-1?Q?NTis1dIUk1bzDUkJKbBPNrUJp8fuj0Nivyp1GuOVb69/4pLUMPWAchQY/D?=
 =?iso-8859-1?Q?H0QyrFgR8YIbbb2UipFH8ZP9LIY3dvAVLU37Z7QjhnQiwoetngMhSfQs8P?=
 =?iso-8859-1?Q?Y/gjWxQpm5hfcfwqJGXOfG+yt81KrFqtSXhjBvMzRuRHUoMPd1wVaEd/mu?=
 =?iso-8859-1?Q?ZzagVgTv4BFIQzGcmWch/o1HrCzw1YxdwOtxMpkKldt09hhHqLnLqBgWSC?=
 =?iso-8859-1?Q?mPLBLwOYyZD7tPBPhDoLAWZSC9fZFDJ37IiCJtamKocXta/LhLOrbya2YX?=
 =?iso-8859-1?Q?ocO+3+UjEG4piX5xuMdSUX4KmbAmBl3WLcZsmjj4vC7v39W3kEG47yjLQQ?=
 =?iso-8859-1?Q?e7CHfGFjys++6CQafLHC8Pj/98ngs1ovOOVisdRU9nrkZZaUHHu+wqTpOs?=
 =?iso-8859-1?Q?UlHbusuyQni2XbRbjRSiOzqb2IzaxCx5MfLY92p9aDiQiYsACf612kO1Ki?=
 =?iso-8859-1?Q?z7ViJPDz/n5yA1Bb52qUgHwca5DiV460b7tRRRaWBbyKeEY0IaQ/M7VEAv?=
 =?iso-8859-1?Q?K+DTawZM1fwmlM8kObS7Cmgt7ZQa9GqSKQSO30azPSJWZ5MoZwJPdytfxj?=
 =?iso-8859-1?Q?hnCf0MTGX/u+ZtSF5gfXQYTxtEg6fnLvyGRlcXfpIkbtEluiJU17ragsk1?=
 =?iso-8859-1?Q?MJzWP+Lsl8JB8iqAGNhu1gCyLsfjHoH7NPxnlXJllhNwA2D6ikNWN7Ffuk?=
 =?iso-8859-1?Q?po/Y47EPFhW2PuhuZLX1jRv9K04MT5WsiUKEMOGprGXA4RqpeZc/4m3pI6?=
 =?iso-8859-1?Q?yzFM/qigBm7gnTAqUdO/lGGt+kQVOSxH1qhFpigtvACynwsCJ238G1Q65Q?=
 =?iso-8859-1?Q?wutAog50F0tFnBdOfnGI7wrwXVIQbLRJwX7DOD6VrFEfBodoVw+mo8OKdp?=
 =?iso-8859-1?Q?d8xAEgQ0JIHbLO8q4FCaNROdzYtgx7hS0X7AUylfINkyFqHiTnSU4KiUKa?=
 =?iso-8859-1?Q?Tvsaeb7Fkl9mCU//zgHH/CHSgWVy2N2iP06pXrwh8ZoWKch0exFxTkCVf3?=
 =?iso-8859-1?Q?9nVPWffeKh2cquxqaTsupfIbIZedq3Y71lINf1y+SH7tNBmwOszA9sTMS5?=
 =?iso-8859-1?Q?YFR3T5H4dNprAvA90PdsxefoWTrFpDIyevzj/BnXHEKLaeB6WP8PfbNzjw?=
 =?iso-8859-1?Q?MzS7P924epM50xTgF7/8ZAJJd8IIaBy1Q+kWyS9rX8qkJkQ/Y2RrEE0cNQ?=
 =?iso-8859-1?Q?ZDxvxGCcDGHyo/HNYRDhm2p1RnVVUM9n+Cn7MZqXx8YOgioPz7KYP26lKH?=
 =?iso-8859-1?Q?RIYKhMnxivofdQc7a7iVb1BLRA2nuEgYxZ8sTZoSPz31Rrdzy3CXn/iQeg?=
 =?iso-8859-1?Q?BktxeFFxFhRxBAdT4XKHgIqL+AsSnNbGmu2pLVsuiCRd9etM5548JuRlPn?=
 =?iso-8859-1?Q?k/bBNiU+8A21NP6+xyYWTAv813d03ao=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JZ6LnGKB4UkV6jmd+9RZ80Ndmxqtr+CRCZgHt2nK6JVLBvZcp/ICNzXCYjSLUxjh1x88m2kPWiGjBmcsBpoK96gAppSYBR6pYa5Feb9IzXtOemFRQbYzl6MHxXlUCpjaa8jgk/HUerMXao8bUTPjP5JXiwHvlbFfkmrnS1gKPhas1lp9BsKXA2oA5lSOxux7z66wi/HLQLm6YElDNNZQWtWRFO5zHbb3W0BgchPp7WJn85W9q3y30zOJ98ANJNHab6HppQsab1TublF8PvGNYW0//oMKvsjLXAL3eQbu5oYIWWWYs5lN6bNTJEoM78IznMc7Sz16WAG0Y3+5+3+SCw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6953ca69-a5fe-4c70-0581-08df12ec207f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 05:42:27.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt9CLnyGl6+9VrVo91XF1ulut0t/0n079sRWDght2+mOUeX+zXCXtGKp6uieMa65hpGHlkE1hYitXyWXVeS4Q7pfSH2R1tJxSO0jLet2oO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Sent: Tuesday, September 15, 2026 4:47 AM
> To: Jakub Kicinski <kuba@kernel.org>; Uwe Kleine-K=F6nig (The Capable
> Hub) <u.kleine-koenig@baylibre.com>; Arend van Spriel
> <arend.vanspriel@broadcom.com>; Johannes Berg
> <johannes@sipsolutions.net>; Michael Grzeschik <mgr@kernel.org>; Denis
> Benato <benato.denis96@gmail.com>; netdev@vger.kernel.org
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Jijie
> Shao <shaojijie@huawei.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH] net: fealnx: remove never-true 486 CPU check
>=20
> The fealnx driver contains a check for boot_cpu_data.x86 <=3D 4.
> This field encodes the x86 generation (3 =3D 386, 4 =3D 486, etc).
> Therefore, since 486 support was removed from the kernel in commit
> 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
> condition is always true. Remove the check.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/fealnx.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/fealnx.c
> b/drivers/net/ethernet/fealnx.c index bdc38aac5850..708b61f21915
> 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -839,8 +839,7 @@ static int netdev_open(struct net_device *dev)
>=20
>  	/* Initialize other registers. */
>  	/* Configure the PCI bus bursts and FIFO thresholds.
> -	   486: Set 8 longword burst.
> -	   586: no burst limit.
> +	   No burst limit.
>  	   Burst length 5:3
>  	   0 0 0   1
>  	   0 0 1   4
> @@ -858,13 +857,7 @@ static int netdev_open(struct net_device *dev)
> #ifdef __BIG_ENDIAN
>  	np->bcrvalue |=3D 0x04;	/* big-endian */
>  #endif
> -
> -#if defined(__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
> -	if (boot_cpu_data.x86 <=3D 4)
> -		np->crvalue =3D 0xa00;
> -	else
> -#endif
> -		np->crvalue =3D 0xe00;	/* rx 128 burst length */
> +	np->crvalue =3D 0xe00;	/* rx 128 burst length */
>=20
>=20
>  // 89/12/29 add,
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
