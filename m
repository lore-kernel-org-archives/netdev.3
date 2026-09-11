Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAED34C155
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140215; cv=fail; b=W3bQGFX/N8d3zwx5qwwKWgwdzc9FO4NBe0H5Igey2SsDC2WTnoOhdpiEKwP4K+jb5g2PZ/d6uGavl8muZVNFdZrbLPp8U3dfZTkZ6tq2Z5qSiQX+zBpUiJ9+KoQUZytqrdFD5aCJKmgKjricoQFqnxxSpxJ+5Xg64yPmasuF/TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140215; c=relaxed/simple;
	bh=WMw+2V+pydeMfdcCvRoDSXKsJYqhvg538uF081wBRBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b28HTAoDUqLxaJsQBiKSoTMOO8jV/05ONxkumhX6GlGBkf2I4m/Lf8Tcv3ZCSQ8PPqBf5PxsqTOhHy4uutjjUDHugQmq6lcexqNxvM2eBrMs7cvYCi53g/C2GDzqLrTxm6JVMnnxTfDuusOii6EtVilTNm+u+Q53tLnJuiW1678=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EO6qWUpM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EO6qWUpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789140213; x=1820676213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMw+2V+pydeMfdcCvRoDSXKsJYqhvg538uF081wBRBg=;
  b=EO6qWUpMpMYfSlWQ/LOq033yY5gh+2u6P/cVHtV2RvRfM6YhBMgLjhac
   6Fek1f6sElWvNyesTq2m95kg14AoukMu0iueSOlmpn5rcQofuRyAsyQSs
   9c5c3mDKpIX6Uy2QU8Le86X+a4Tmfs8dAH/EQ8FIWHIYTEncyOrTn8+0z
   rfjQyK4jtGpzcq2J/aqdqnGYFvdaQDIELtUnSxoo/vHiBSBQKFzOJW+fs
   LjRo+c+hWJghvGKrt2YRemNxJQ0/+GhIozAXSJDOtVtFwJU3AmMkR/b1i
   RcXZLPRN2zhyjhnnBiGcQiOxBtTKCgYjIUi8g9Uqu+HwSe3NcEOH9h9tD
   A==;
X-CSE-ConnectionGUID: dkYd83BjQyev86BDlOUwdQ==
X-CSE-MsgGUID: Hj+gg0whRk6F0gVIvPIlzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="99933471"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99933471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:33 -0700
X-CSE-ConnectionGUID: i3+4q9h0SY6TyeA51p1lvA==
X-CSE-MsgGUID: 30yw+GL1Q6m6QpmBBcZUOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="267652967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:23:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ait7hBh3d7ywZS3U1hZbdSLA9DYpftXjSVBHRs+B9LPiJa1PCXdbH12G7ME13ztzKHvvyxyR5GmEx617Kg97K/5R//sisvBNejOVOr1eUPp2FqkRZajhXVLPyyZQ+J/WlzFiHV+BLJDQ5u+I5Z7SgimjigXdm/mwLv+p+j47DW09bOKMC78UpdVTyUSP8l8E3pVSsgG7kboCtk0V89SNJDN+q4gsq07IXh1h33L+npzWq0nCgaUbWE0rihmbpTm2wdq2HJGrp6KuDIB6ZJ4Ib5uUf2+02NmWcyZV09oaf900BSCO5DkCsjkHB1WGY0YGyjKykHIaHWuV5JbKIQFfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHirNAdkJq4i3HbURY0PoORwTb9vhKJh8EcyLAIVKX8=;
 b=v4yMNGzLs5El9mBh6X/T6fkoUdRntK+vOEXo2/WikBYmuhgCOi/yQmQv9322s830p8ipZ+UFgjYUHgDgCj+lDgWnEm16Ek3wWh2pg7S50/Eqx6r/AFs3Az5ig1QDqPCdlvo5vgDZdGrWSFQBXJLgBN4rgQIekR2IdJT+WLQF5O+yMEPrM5QxaPp1zmavxGUxsszwDybzIeDtuZ3I4XC2uBOHiCC8UgdQjZAxlCYWagnc07VuzVhKPJZaLktymVeKSX/fzlq2C0upK9FUYUd2K5vKdAoc9NBzAYl0uxxFV8rcOzrPxC/EQxu0Ov4oPMlwVFR7PkuevpfeSyfCJyXi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:23:27 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:23:27 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Index: AQHdGqxy282qHmY2M0qHkV98W02/dLbJatjw
Date: Fri, 11 Sep 2026 15:23:27 +0000
Message-ID: <IA1PR11MB624197D95FEA25F481C3C79A8BBE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260723140510.184819-1-mheib@redhat.com>
 <20260723140510.184819-3-mheib@redhat.com>
In-Reply-To: <20260723140510.184819-3-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: 94a8770c-f991-4c45-942b-08df1018a0f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|56012099006|4143699003|6133799003|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: eNZsKGVUYyTc3WzMJy+Z/N6aBot6hKhDrR8TXEfuUllqD8LiBFzxT0ZN2JMG0eUYxd/TLGmaXi9EhryIHzSHAGXPhljioP67KsCbUc+x+t/4iJIL2z1MFLB2xZ86jr2628FGU9s4s2xowKrEScQips/EFk9/yET8AbUAeN7rSEd8iKI+p01BveTm21W4DoZRegQsrhaSIRnI9tAfbnXgehBC+0AZX/ABsb8JyP4RdnlEw7CAdSMvFGHfunC3fasrYKyN4hgNlHnc42dyQEIQg9IowPH1CFs01FfJorKivladmyYVr791xwMHIalqZibZFZXjXPExpPj6upCxwfYErESnd9EwAH9TGxuuUWijyCV1tPkTKBsPCw8jBAYzq8z7Ai0gV8lrWWrYe7o9hkDEcWQedqNYkqIUVx+nW5r6mrEsfzAQzzS1QdovPNihr5Jas0LbRiCT4TcFRLpOHvVDpmhNbQii2OcsHznLu+6z/MzfMGSppK0XF7hzdFKs3U2bxr+DUTh5tgoHypfdH/LB2lr51mAdbMF9wxeJb00ebNUnUpSNESENlMneQEF1pyR0Fy7mP4ilibd3PDQ3uZMbO2PvN3o6JAqFSGgGfr9nKZR2F4gS5KtbnGc8bRjwX0ZJPjNU7DZplc3ABNPfN+rj++wC/Aws69ARZDatseMYrP038rsbRsFlk2khOej954+k9JgLWUOSfVNwhatuvvy9DsNu9t6cgpW9EsR2H/TzFxo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aNNWJm8m1neR0fjymvkJlcoMq24sHjoMy4FRbatEQkqF+KY4xvxDryrOu603?=
 =?us-ascii?Q?hAiga+8ZsAhpuPd+e0erlYGUDDW1FbDixBU3yVOcbVKmwPSX8E6mIWbMzlqU?=
 =?us-ascii?Q?sRKLkPEpwPThFcO5eUIg/NvE3s2XadjJZf/03yCo7d8/Nbv0GJx2toAekzD7?=
 =?us-ascii?Q?fRnDw0YDixl7dWjRrB6J0VeTp7m2gne6H1qc4/RAhEVwc1GmqqJNrRdBdEP1?=
 =?us-ascii?Q?jcKil7NKwFic77BmD85KoxFcfZPgGfWfb8xPxaiiE+SLxnh5Tjec6+XqyKyC?=
 =?us-ascii?Q?bkHP34928lyYrBIkxnA5VTe6EdxcFTpN0LeJFRzzn1kCrxoltI0qv320a3MU?=
 =?us-ascii?Q?wFQ9Evxp8TyS8YmMLn1g7k5CBl5ovPT9rx3w+FPfH1cY/e3HNXGneNmTxGGh?=
 =?us-ascii?Q?E2OnR1xhpfYPJUKwGxVteg14fd4iexptFd5mHVGTIe6jZ7RW6HF+uswdAsYy?=
 =?us-ascii?Q?RCCk+BZ+Wjud96on3SpW3TiiNsrtOkBueYZPYMLlpoJsUiuDOSCRWnwhQFPr?=
 =?us-ascii?Q?y0TaQ9nmZ40DdqZzIFQtx3kkVQEN6SgcykVhVF1Jbek6Ju8ZR7QS1tMpWoBu?=
 =?us-ascii?Q?jOL/LvTwltUjuZC1zV8vh2PdpMOk9/XIx+h6qEzGYMvfTbrg1tC/51uozeYH?=
 =?us-ascii?Q?PdmnsHz3ScdWwQrAYETVTs8pOEcfb3IC1TvuK7clg6gm/8Wh6CgGCcPiA9JD?=
 =?us-ascii?Q?IuhimyV4sy56jtcqQESDlZuo5Z465KI4QNKp8YITGYsnrbZS5+Omt3JRdMBO?=
 =?us-ascii?Q?ili23y5Yl8XJSuceDCvV561Ezix9F8CuatJgd2A4zetOoqDh3mByU2pCWIAj?=
 =?us-ascii?Q?9cRPb3wAjXTWJkvUaSUJseVjHazGGUyBV7okGvRXrRMYaXmhJ6J6Rif6hzr9?=
 =?us-ascii?Q?bgm3xMYS2jMmAO5z0CPdnMS9Z+NnmRJBGmjGBgLFwgLL+EbgDW5997qfoTmU?=
 =?us-ascii?Q?Rs5AngUfRMHJ+9+tPfht69XaxWafQsHX1HkRt0s94oeTuEBGUHwBAfAN5W5s?=
 =?us-ascii?Q?8tpd3Pxj+Z61N7HSgU9fsIP4NNXKV+AZr2RpyTU02/M3NXYe64CUSLuxfrgt?=
 =?us-ascii?Q?Gkbx2ukk7kHWycb0lYQmGEbHkmA84HlZRsUnLIsS4Rl4ie7D9c3tP6p3Xnar?=
 =?us-ascii?Q?aE8jwr/gwhcQaptOMfFXH0U617C+CgKDcfuY0uYd0Y1GKSf1dWv0s0ZJi35q?=
 =?us-ascii?Q?vEdr5SdBYa/r+crceL8DZL4BDxeDpWBECKD6u+zym+CqWvkhWW1IL7wt5eW3?=
 =?us-ascii?Q?KVB6/tC08xN3FX3Jo8FaEG/MhBl5N3HhP0AqUgpRZV2UKB3ajLXx5uUOn7It?=
 =?us-ascii?Q?MeQ3qSsd5tYlMgAWDM5qiTHieHLf/ZUhipgs+JzxKeELlUESj4tu+rpbMA6u?=
 =?us-ascii?Q?8XQtENnJZSX5R9nmTGTgAISmZEi9xyyew4tCEmx1zXzjF/Fl3b+T0gbQ66ef?=
 =?us-ascii?Q?yiuXW/09HYPKfm7uprni5WNJg0CTOUW0jFJ/macppFyZsD5AEKjuny+p+H5n?=
 =?us-ascii?Q?3ytnUtq2lgq8u1aZq6RzwZwGZhyMLh+FEspfLQ2pqnkQpZDs9lcf19sfZFFR?=
 =?us-ascii?Q?VJsv4rFoqaXBvzROdrQ9C2GCFbCfhw0SvbD5ZNnODY3JfMul9OxlTZMycMcn?=
 =?us-ascii?Q?pk/ihUqsL0KfUtBRtltjgQgLrmJHX8X9Ap3v8wBcNwtz2RyW8hQ8uElwn228?=
 =?us-ascii?Q?j1UWqtXx/GB0qG16L4g+quYIjmw64uKWS0JtW93itZAjePhe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OQ4SOsDA3WXAhx+aQB/QUoA+NsQbebEcPJ+TVgZF1mXxehZdk+HaVYujZY8wC+k2aCO9zqTNjGKaGWu5UlBnZKZ36oMdNOh6vjWX28OmSc/6nM7JFM7SdqHjuVdiFqnlyYwf4cq4Ld/XfNIM6yIz9i7CI1HznX8R9Exv+z9ndPQm5DDARqtsUhP7qgh+hPplVlbBxcG5MppaFBr+V3FbzKHx9AoiQ3/IBaxDiigdYl1zv86hs1OmBYbHiEBVMOyuodpZwGncARIrEaD+zmwXjQTuRRYWVk6Ce0k3ORvJX6DSRvG2XgMVEEED6U0Z5xOEaZVIH7kLvggd//ZtqlsWxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a8770c-f991-4c45-942b-08df1018a0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:23:27.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jI/kkXncfqWMzVnxj/cw/DZalDjWVIB4bmtfk6xph4QfF2+lu6czIxFbb48WsY8fqFnGnV6F69g0jpQsoG5FRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 23 July 2026 19:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org; pabeni@redhat.com; corbet@lwn.net; Nguyen, =
Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>; andrew+netdev@lunn.ch; horms@kernel.org; Mohammad Heib <mh=
eib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink para=
meter for Flow Director ATR sample rate
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The i40e driver uses Flow Director ATR to periodically update flow steeri=
ng information for active TCP flows. The update frequency is currently cont=
rolled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at driver build time.
>
> On systems with a large number of queues and high-rate TCP workloads, the=
 default sampling interval can result in frequent Flow Director reprogrammi=
ng for long-lived flows.
>
> The amount of TCP packet reordering observed on some systems is sensitive=
 to the ATR sampling interval. Increasing the interval reduces Flow Directo=
r programming activity and can significantly reduce the associated reorderi=
ng.
>
> Since the optimal sampling interval depends on the workload and system co=
nfiguration, a single fixed value is not suitable for all deployments.
>
> Add a devlink parameter to allow administrators to tune the ATR sample ra=
te at runtime without rebuilding the driver or disabling ATR functionality =
entirely.
>
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
> Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
> .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
> 2 files changed, 56 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
