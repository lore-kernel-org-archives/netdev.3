Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E624293C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731023; cv=fail; b=sItFcGrZ3FBrAA4VEWyzeLwVhM4YXG8h9DOuJSDKzYUsfBz27EG57rrmcEKQApa1zX9dMa/zXRQqxpfGKB3eJfFbdlSJV7ZebRTYvOE03VUsgcB5qFLN/6ywzn2LxlsSLKrbGR9uR2fjGFQVSTlbdOIp61xiS+doZqnAAIwDkF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731023; c=relaxed/simple;
	bh=v9mHqfTSSrVzQEfdKAxgG8bDn/v7AtAt/BTXT/U6h9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDdpREKyxOpzutT4wD0mpMjzriKXQ7W620gf+DpxAmLiNVMVj4Mz9JjdgNFbLCNr6mIPfyrf/r7xsFphvuTLnpRJRDwKevnAz2jAEWJ8uDA/j3sOPERN2sCBPQMr1PdEluy7fMASqn3VVD4x/nXYq5NZQjde9x9BksbG+peTsF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrLfcuoc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrLfcuoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790731022; x=1822267022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v9mHqfTSSrVzQEfdKAxgG8bDn/v7AtAt/BTXT/U6h9Q=;
  b=CrLfcuocgs1GVu2jyJ6pIrlbo/dV2si/+iNOxdUUUusS/M07qhJoETOW
   ZogdIjYGSZ8lZujW4G5/c8Ma1CRDTSCTdFUTPEidQMxbuSC7Vy7YoTq+K
   cnvhaSN9ow2asaZHP0azWuYzyhapmH1twBOSKm4/MdwTHTjZgzD/pvSQG
   z4Nm8fpyBvkDsY0vszpeCV5XShko7Wpob+5/aruxLzGCUZA1VJzCfIK1Q
   8ByJvhuZMpoknY/TcaC3uj3lpB78QY/MtkTulDMEvUiDaimYWji4U+R6F
   AdLfkVJ3UGjC6tMSFcp8JIQ59xPr53bNasY7LPjyiWhwrMkZ7xO2Yr3xr
   w==;
X-CSE-ConnectionGUID: +JyQLrnjRRqY2Il+OQNaIg==
X-CSE-MsgGUID: dhYICWepS5KLLOElDrtx8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="116990207"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="116990207"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:17:01 -0700
X-CSE-ConnectionGUID: CWY/tthSSoalVKGfELLKHw==
X-CSE-MsgGUID: gf8qXmNDQHiyOkD5bHpr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313485548"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:17:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:17:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:17:00 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSrpBToiAJ14bka4X/hW+3QR/MJbOqkACYkgXrPNkGw7+UXeT/CxxuJ+71ZMeuy1Kcno9Eysghen4MjMXO9MMePynPDwxVdrQgaGx7GbpHKGEqPyxAzRHacmay2RpVi7T/zdWBsmMQRPlL/p58TYaqBFkKXMOOtB27MKyqjlBoWoSjIbu/D/1/UU0i3RpLo3+sH3lFjvYQZSJ1egu2/CKO61gU9l+NKQLQSkVfEn8rfx62/Yqnyphbvfs2jkTQU0d9gC+UwYO7FzV3QiTJWZbcYpuRhCJnZZAvv21dvltc9M1QxdfC25qeYxxhfrn/9pa2nSmwqDBQEg4RVHHGcxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmV/LbzoM0gnt4WG48Eah1umOh69tSNcYndfnCBQKcY=;
 b=TPnUmcmqK4BJBzeZ+E7lTvpHgEc5bIxA9j+pf6i7dnAurY3CGImTUMk6s85j2cMVpn1idofmQvmLMSNjpR5z/7srYAzsqgdaMpihb8XK2vZr6+6anjCF1R3mKuFplNgxcumuezZTIfWwdS97ijyYqqU2VHATkOXYkItS1kN4i9w758VutOuv+BzvfU+EYoWSXZIhaPd3+EuIidDjwpYjKTRNmZLl6LjI0zilyPpOrOFsRPSX4dwHZZns+KzLbfCgkSSjjEchRxxPrkJSlmOpCVyyg8fv/hGFTySXbyXHY6LyMBfd0LhyojlCU0J5gW49jPjUxEd1YbFjJyKn8nLKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:16:56 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:16:56 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset
 recovery with device removal
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset
 recovery with device removal
Thread-Index: AQHdJKcSNcymdUMav0eD5pCAGeHSIrbmqV7g
Date: Wed, 30 Sep 2026 01:16:55 +0000
Message-ID: <LV1PR11MB8790B06A61F0E6ED4F59A9E1908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-4-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 2d337d9d-09e5-4771-9829-08df1e9084a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: YT41KaUdapFuikSa0Qu/zB9M4/VrRNaIibqJdm5s+Zn8BGgb3OWrmzogVJq17YfBpwNi9LJut216pM/KcWSNtdyvaoLIroVJegI5mc3HPNapmkGzHJuJGGmfc01U8VoXtanly30pDoMt+xr8bU4+syW5aMyTeNfd+tlEQx9xHUwIchU7pF0MfqDCZytP+8kZH9CVKnmlkR2dMrPfPSj1WeueGW+0c2Cp3DJe17g28y/yUZRObtz1yJfjKpSHJ8Wum+hPWRiqfGD+sSLB9V48urLuDG3cAkjY5V2z0bbHV7KZZZoJ5b+hqQvLAREs8MWzpvI9krhGgge7l60QjrjfPX24fPX0mgqRyJqedq51q7bJkbXJ1Y0iJ4S+UnopF/6Lo+s1blypO+MF60xDzyu0zCv0ZjxVrPHbmLPw1efEhXQbEVqPNz8GE0IbEHeELmyfyuG0TKChpknw5LL55NXJk5y3T+0U4h+39rz5ACX8Lmhc4cSdFQ7dT0WSrPNaC7Qqs4FaNoFLr3foemwZRMfPKbuo8lOHLxSzBbidsKOqdNru87Oauoj3bliNmFBPXCqn2hLVApQgs+vF506HttU+EZZiG1+Fx29knPasMwQotslBUh3TLNcEKoXV81Ue1vD+SF8TUY+n5hHF56xRKdNrzxP33B5/Ym7yxsAYVUXTTLotRm+eo8I7zGoymwkrT0caOFPvhq/6rtwrTmmLPydKDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NuW7ZHhpyqCZ0Af0Z1h6nK+41HDT5J7oxxrJO4wr1SQ5Z8IOh0qHos+EA58w?=
 =?us-ascii?Q?sRYqlWBDTE5xBGZDpnrd5lCp6PwpJmDK2Z8H+KdVsHwtaC9NG/i4f1vPcZCB?=
 =?us-ascii?Q?vXgPu2Afw1xnJt7YTls+8x/ryc7WVhEUHzbfUPHSyrYiSTotOjXOSJqWt9lf?=
 =?us-ascii?Q?lNzNdRuSrOsz8z9a7G0XVx4QchJJxXxnmfWvQl7hM3rQeyRqDtDopwi0uMRc?=
 =?us-ascii?Q?0hSkfsFDbBsfPh3TlKbgVVc32D6fI4DU9QZUZbgpMZOYsTb6Qt3EV+FWwTtM?=
 =?us-ascii?Q?AMTTmEC2fuXQ7vOBz2olduwB6jCUQL4tB1vk4mZA7S7s/nggIIazRIJnTwj4?=
 =?us-ascii?Q?KhT9KkJKzFxVGCKvdgCpnf/YeP45V+1zBI7EsXvNZsFe3uDw8nHQGhPduPMW?=
 =?us-ascii?Q?rszaR1JEVnmvxedz9Sl7/9gJ1DVe7Mf+P4bWuwD0rU0vh7j9zihcvDM+d97T?=
 =?us-ascii?Q?VX7ZvCECS0R406dJFja6ZWBpaGD4waI7u4XYOUEZQwqMw3RrwAB/9JUS3GpZ?=
 =?us-ascii?Q?1DMzVh65Wn5VAa55EYWFjNVxpC7m1ek8PmLLxtR7X0EWjzR0VCbLpEh+4/mV?=
 =?us-ascii?Q?lXM3y4XgvmRcuUGP6+4IiTMf/fvYUjn2+Pp5ltluwC/NJS4nsrJLnhGqu/AL?=
 =?us-ascii?Q?zyZsw3UkZXyUu4YzpGx7fZ7sl4zo9uY1cBAb+uLgCsb3miwYpOmK8vcQ99Im?=
 =?us-ascii?Q?c21wKjWEy+r1vfczdh6DCZHOR1sZSZj9LWXLRUaETyXPPAqm83b4n0P476xz?=
 =?us-ascii?Q?x6u7ddWwmV8GexTMcH5Gtl5gallN04By1g0V0hAklC3cwmo1clFhc5L1GQZA?=
 =?us-ascii?Q?zfpBKygHOcV7nJDQe9O46nSivDfxP6S0S9f8wAWrtdbm0BGptd2kXQ+zhDr+?=
 =?us-ascii?Q?yZJp0oFDUsVpAT8WSaYPPSwwY0sAgNmYG8IZ37Lr0itsYJx/vM/6O3wRnVw+?=
 =?us-ascii?Q?qEMdCNQKqXsY+K52VLC5LjzmvRa2rev6lCcYo5lHmEFGJUTve7oCh4rPukig?=
 =?us-ascii?Q?hU6DYD4WUfUOC5j+xb+toFhXvt7V/rYTm2hZNe/Ts0yfL45RYtMQrMa8cpLK?=
 =?us-ascii?Q?APgYcRIuq6cvDw1dMbvZHzLmaUvn4XHcQowmVDOigB3s16sXvmVo92BtS7cl?=
 =?us-ascii?Q?tkE8kr95kBlxMoe2AeJJXXUrlKJe66GudzJAfc6B+YGSslf3GhXH2F8TyqHz?=
 =?us-ascii?Q?NIB4D3cDhy201zCFPK34pLdiszp1ndmZ7MP8ZLgiQ1CGDbge2EySg9shLDXU?=
 =?us-ascii?Q?86VajDGCJKKJLx6Q4V4xRYJIJv2MQyiOFX+pQxvHV9LPLZQxgK9GigDhlH0R?=
 =?us-ascii?Q?90xYscHSQ5t44HKtEWTMtnpmjl1jebb1tCTpPHwgER70s6EUrDpxisPga/At?=
 =?us-ascii?Q?xjS47+is45E9RuqvVaaX16qeIihlzETDrkGYiwi7B/io5ynlwiKsfDcM9nMh?=
 =?us-ascii?Q?Mk50GyYFDiHkqYxnrjPOW08tjNjjlGtZxYtXk7YOZq9I/9PME0b28v6KkW0L?=
 =?us-ascii?Q?q/ENXWm16yimHB5TORySDQfyVnOOU+55jnW/r/Kd7SLVSvm4/QCvauly3F/N?=
 =?us-ascii?Q?fUGnw9PHEmObLA9kb61RiTGwuA5Gq+DcS/e2Clp72nuHpMYKbiSXWp8kY8Oj?=
 =?us-ascii?Q?J8nKm7epj/61bid9cZYXehDa26F+DpGAf+wu+gu8FStHj4penJgZ1shyZod/?=
 =?us-ascii?Q?zqzfT9LtYSFwyFe8Iv3erkuSkvVu5cDri6Rtvve/j3Er4zwyGxcRL9FBnC9Q?=
 =?us-ascii?Q?4n11RCzZkQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 08NsQKQccCpspOvyU8TNHq86bLRydXsnTnxR1nx87Ck7NH2EnljUcsF1/lVtMLH70wCvFMJWeSc9NKdfu7pe3DMnInmXrpn4UT9VxS8WfJ7Ib81IMdFl17Iqd0kkHbp+AUNHm4buP75QqOGCXkRnJ0RJrl0OZ1zqQ4oNzxb7Dw2GIVnxLISG/qNooXistdYwscqsBGldP2hypM/MAgK8zSuZzwNNor4uGRGPzckb29ssw3bdo9OpbNpEHGA++6qL9ATxfkAfkufzCkM3otFHYZCH3jyrChGILPgXSLyMxYwZhp5axqw5mTqveRyM5kuD3O125iH/se5wI6kYYwHzfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d337d9d-09e5-4771-9829-08df1e9084a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:16:55.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxHom/XHdJM7Cz04fKR2xyLuUmqgoz3b46hlm7s1RxETCz2hW47nv9G/DVSgCIETk1rEKkjtCH1jn7A4z6cGF0KMqUHgU5P84PaBW1Io/Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, August 4, 2026 11:52 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset=
 recovery with device removal
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> i40e_remove() currently tears down PTP and device resources before claimi=
ng RESET_RECOVERY_PENDING. A service task can pass its initial state check =
before removal starts and continue into reset recovery after the remove pat=
h has begun teardown. This can make i40e_reset_and_rebuild() access or recr=
eate resources that are being released.
>=20
> Stop the service timer and disable the service work before claiming reset=
 ownership. disable_work_sync() drains the current service task and rejects=
 later queue_work() attempts, including those from interrupts. Claim the re=
set bit before starting teardown so an existing reset owner completes first=
.
>=20
> Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++-----------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
