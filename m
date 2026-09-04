Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04961388E59
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505234; cv=fail; b=BzdH1mHeKr9X2iSoNNpBQoXXJSrVdM54lLONph+eKCy71lkJ0wD2cKJwYaIOsq2sSaOyTe1x2JCCAbJxLxW6WBgctXeRBY5CiaxlVwUOdPsSB4q0jpen47ez68ePwtIRCdp1HNb6tsUiE9v7HYn30aa7R7z0n4ih49yUAA7KktI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505234; c=relaxed/simple;
	bh=xYn0DyNDuIP/v9MLukekoWa7I8nF0HhtugEFCgVSSUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=naEbCC0SXasaZD3/cuViRKv8lp++4RyK2Z62E/B229aPPp2YtsedtBcOinbkfx6kZgG9zfZwqbpZSz2B5PmWxnwN72IAjYYMDNifGyTQLRLGqCNhq1NErnJHMFQOCDRn26LJRti0KYEZ0Z1/mU7QMLQXb8lfuQ+oWgrNC0uv47s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBRU1eha; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBRU1eha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505228; x=1820041228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYn0DyNDuIP/v9MLukekoWa7I8nF0HhtugEFCgVSSUg=;
  b=cBRU1ehaQYAPX9uXvsHJs/DXYdsvRHCUABl6/2DFCA0nT6WxZtWRLU6W
   yluqqjaJ7w2TNwExpjCcYJ1JrIiQ9mPqnpCWio6cjvcFoJQ93zSXyB2pk
   VQ91S2v9+d5UlzTldNrp0s+gZ/GM+Pnx7JpfSK74wJ4hD8cJ2tMWND5zM
   +/+o4b+E4rJN/Fdx3bcqZ3W1keYrv4teKXZBhMrK5geO+fGvcFOQXxCVw
   +kaZehD0cJKYoV38FPBdwB02PqvK6Ue/u25JcYCdWbo1XzgwpKgkZkrxi
   lLYzysmldkBhDa+Z/m1v3s1GZMMttkhHjMpTC4VVFcYsAteorde/PXwlP
   w==;
X-CSE-ConnectionGUID: g9vlWgHcTeOJv34FdF34ug==
X-CSE-MsgGUID: Fv+Rjb8PSvCl/SfGdQuJZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92699462"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92699462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:27 -0700
X-CSE-ConnectionGUID: ySEy17CgSNeXi5agTR66Dg==
X-CSE-MsgGUID: cdNo8SgMTpmeLKwLFrNnmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299826548"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:26 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZbPRalhyyERlGLnDDMJS8aTLeEkNoqxItUH96ik64Dk983PiEttqE280vQ7YrLAUtglJA2U/keWIpRAplYa33D3V3TchUdCTvnPnzuylVOGVyoS4SH2SljF11JX3SwmO6XLcVFv0zFexaQoLtFT7Qki0fKkkzq+3qBb9Uat5F7jojuX5gG2sQbk6kAwkrYC4ejujWw+Ln+WvH6GiZEbWG9g9V5CKiAJunH/5cSwZU6G9axIsIPJ5Rbb/vy2AxDlcIx/qeiXD9tsqK6X7AWhiJx9VAdw75tX5wN0UWy+Xlce5Pih+qCSxrW3U+EmlfEoxg4PAQnLYPxiPIjRz5XDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD/JouGZ10V9WiH0J/5x98q/fAwfiQLTiBpGismoFI4=;
 b=CBVLWvUULEXwOZHFea2IuWpaWPVnxfAAA7li8loKzLzJ8rZVHo4D4F3WYZZEvJVSn4F7Dd7+FjI3rgW0YG7A/qoOIS1YARk7wKQ7AR7B4RV796LGbyCSjdSZri7LRReHtqUlL0MOaS/Nl7Lx9pxhEFyyLgAWlLpyHZl1KsF2Rm0zQlLKN49Lz1zuPv5QjXSS3upm5O9H0tKdTBz0zK6zNfVkRheFKf/SCa8fBWpv1FfVj4xHULrR4yPGIorCGKBaACG0dLMxLqgAIkPmDdHAx2TLt+R8ywao718RT15Mtzr8Kxn/tpy39SjKV4xDvKSVCGkjF7D2GLyW8tDNoCIOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:17 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:17 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 03/12] ice: initialize ACL
 table
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 03/12] ice: initialize ACL
 table
Thread-Index: AQHdChZP+7gpTYtR3U+BwHrlInrGW7a+NBjw
Date: Fri, 4 Sep 2026 07:00:17 +0000
Message-ID: <IA1PR11MB624197BFC3F72C3C1F5B0D238BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-4-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-4-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 004c2c81-0ed5-4f49-88c1-08df0a522d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: 6VRH2ArZG0BSgmesYZiFnRr/PMrAvgZXhuKBC4qAFy/6fve9dwvYSFJvhI+KQ2jE9o+pLYiR0d0gJyn8Qr1/wB6t0cuUlCQiNpkiSfLczlt6zA4DiLsOQF9h1YkYqSBWVIOsLvZtNtQvP1ujOP/r8OUuEaG7e4B3dSSvffRh/VcVjkoyacMdbXQ3/uGe3MQLVZ5qbf8dFo51c1dWPcVfk+0dtGZWfKpUhTcM+Rwa2kf+4PFiz7Oi4l/4uLCjMwhCkYS9UIc52RDQ59KgzxtIeKEq+qtdpB7DxuJfbaOIOorUiy3ompN6Xa50DfaIPmykXEDOBPKOiUac0XsydY8aNxdJNINGBy+KEmcCqn2IwX3cSEtv8WM8GmfxfB9I0QbwzwHX1Gz+aixmi0EbbsGqhn2bW97roYW53OD5OgidXHqj2PxRWBGdEc1TeEfdHUFXO/RYdtrf4eCs6MvJVK6FqicHdycaEs5HFc+5Co7O06Wpl0V6gSVs2T5H75ySh+IphRLs9LT1KO+1HEtJkzq38BOSt1FUAIotlGDkvveK05q0UYkY7g4OozSP4PQvCV/Lwc/S5JGom7h/mIuFFIU5sIcMOqcmtWZZBwbF8YAnoZwlcc/UORTr/r+0ob6xe1atC9x5mTBeFXsX0x/cZr9xRt5WVTpHvTCTsxxw4+jvqE3agtZx4Goy2Ti+m2b0Yq38jBfjFZZQuxggfzhgQAnmpSc1sqXiPnwbj+X3hDuVFvk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(3023799007)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l3x9z+2WyScr3m5K8aat+KpCTjIA2iojsOwpJeEdqr5ItLWf3pEPmf/koElC?=
 =?us-ascii?Q?YlNPreuxLSntRIWFD+IPPpz9ckp3mpzPltIroakavutVF+2/vfGybQX02yb5?=
 =?us-ascii?Q?JeLY85DZxykMvTIj6YTZPF9ex+YhXU7pHvfg4KqLUpSOe1dbJoB4ySBRxL9K?=
 =?us-ascii?Q?RRuEqtVIKzUOGoHfymNSkoSkm2ZV0dL3YfwjL7noCOTxUJd7GzUqybDM3K1G?=
 =?us-ascii?Q?vv+EI7waeFuBwz5g+1ASznVr4YV6xPuzsB5CMJd1uWgzhJtnke5LsKACmydR?=
 =?us-ascii?Q?77u3fzY3TRyVXkvxrqKdVua8DkBUrVtIlZMidgbVLkvZnhQUz3epFR1BvzbZ?=
 =?us-ascii?Q?QXdYM1DEgQrqZaSQ/n10F20mURqNuHcjHlkvbXeTwAFyQwvqKLohJaxQD85M?=
 =?us-ascii?Q?p7A9p3bKEleWItDTDeXcBcu+0xQZMRU1DAjoeK28NE9bZR6+7QMON7AkJxpZ?=
 =?us-ascii?Q?nkK4W1pKHJuPUCH4tLMwhPqaRyktkLe38wfDLG2YlEl0jFWC6Jp6GgyVUH1k?=
 =?us-ascii?Q?J1Z/yX9a5kM4uJc1zQ+YzlIvlm1od1lKKEmb3gL9HjA1dNNmLBJ8s60OzoLk?=
 =?us-ascii?Q?xRqi1a/qNqRhpWl7ukSMhsGb3xJ4tkHCwo5nc5PQSw7TjPOeQ1ACPcVa2Kzt?=
 =?us-ascii?Q?XOWYdhi4EcfhIQRCOOzjdy+ZXsCoUFsyGNbQoBnlyTeDJwquZ6/kxauI8D7P?=
 =?us-ascii?Q?FKfxuut7HVXC/owJxLVL6SLGkZwDU+vJvdDNrgRk/laQmtT+6v7dZSCwVwv+?=
 =?us-ascii?Q?jzwSM2QvSR734UJIBOC/l8LRvvV35/KOmsyBB8qaGaJyM50mtMXk97xPM/jm?=
 =?us-ascii?Q?iDsOcDSkz9/XXekrzWNvl5806f/IQmplIg7dA5FkkkaZz+KM7YRiqfpc5Ntv?=
 =?us-ascii?Q?etCwPx1cZdmJMuYhRchvXsdhIabWRT0sevS8RxtvA3laF6TV7tVO32U3aP8n?=
 =?us-ascii?Q?D0TovXWPrSh2KPa9lsXZl6LUJr41OIgxL9PFmhNhX4g67KYSx/8o4bFPTB2t?=
 =?us-ascii?Q?3DnvcB8MBDwtKdjbliPwbk7ddVoOKqIWPTIVGdCHw1we0X8iRC99No75E51p?=
 =?us-ascii?Q?Wuf/sxWHNVTeRu4mDLc3MQSIspJTPGZr/3nCq0CrNYbzkM49F+OX9UYZVU8h?=
 =?us-ascii?Q?G+imYMagWo8komBDKYtcm4kCYZPX4zkTG/+P66EkmLro2RhckeU5BseeQao0?=
 =?us-ascii?Q?oCVZxBuf/liwgBac+91RNufRHnirP8n/nhssKfsirvMGf1swlPp6Ayk663mB?=
 =?us-ascii?Q?jJHwsfdxuRgdoW3yXit6RBf4P4Avv1ZegSuJT5FwBWm5F4qPXAZGnPoVr5tz?=
 =?us-ascii?Q?JxyZfEa/fnSudK4+wLg98QSyAbCtoH7id94QdWLSn5arDjNsOXLnGVfkCn7a?=
 =?us-ascii?Q?heZV6CfX4Tea/gyD9g7/Lry5vgVEq6SvL9igYbl9UitqwUqLRJf9QPcugVBA?=
 =?us-ascii?Q?Uvlh92Jucwjxu+DQAqNJccwPHaiTe3h29Y2l0Yax3goJSEUnKxUFSb5r43RS?=
 =?us-ascii?Q?dKyasHMtHFTv3lv8hRhV/dzDUFHTT7YNdq8PHqW+T7osPJMWH8bIryQEpwE+?=
 =?us-ascii?Q?oyEokKBQS5BzhGdMnMP+/gY8ZD2LYLkVb1g2KaN6maa0KJ5JAFGfeDiop4YK?=
 =?us-ascii?Q?QfRJ4CT27i6HKyGdz1KC40YHOF03SSJOSQg8g+8cXslsKvG6MCEHr4/J2LQA?=
 =?us-ascii?Q?POVxzlLa1CADazuoHlGOA/DCdHD9uEflsz7cpyOJz5l4/HQ5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H2FCr1X0AarVBWaAqZPIUnAfXISfbMBar/Ra4Qlqs0enZph0FXdTuwI5JB3y5USc7U/cZ4/dptVjff/CXKk2zuMGAkkmqY1kvepzWKUVV5fpEz+t0CvF68Kd1ZnjSbAQJdRrh54vqGeZeE5Ao05bfePx6VDNufjV9BLh8J4H5ijqqwzcHHLPiGFXe2pwrtnnUHYcyUjMzRflNRSAt1S8u1543DMCroGip/PMjZNLq3Y23D8SjCJNfOfb+y3ks1Qv2zFqLrXw+UltpZydrk00KAcU650MbKEIfRjAAaZgfupDWm7UmDdd8ozCpUqPrwlb52eyqySFTV+MLPZsNx6hmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c2c81-0ed5-4f49-88c1-08df0a522d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:17.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /s63SA3Xm8QW23shTwlSlzec5IuSMivBHOjBKANARAZUFSW6liXurPSG8GPL1sROEMOk9/O9SxlYUfZiaRN9vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 03/12] ice: initialize ACL =
table
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> E8xx hardware provides a Ternary Classifier block for implementing functi=
ons such as ACL (Access Control List). In this series it's simply referred =
to as "ACL".
>
> ACL filtering can be utilized to expand support of ntuple rules by allowi=
ng mask values to be specified for redirect to queue or drop.
>
> Begin implementation of ACL filters by setting up structures, AdminQ comm=
ands, and allocation of the ACL table in the hardware.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v5:
> * Commit message: remove example ethtool filters, as the feature is not
>   fully implemented at this point in the patchset. Moved this part to
>   the commit that finalizes functional implementation
> * ice_acl_create_tbl():
>   * fill num_dependent_alloc_ids with actual value, not always
>    ICE_AQC_MAX_CONCURRENT_ACL_TBL
>   * fill remaining alloc_ids with ICE_AQC_CONCURR_ID_INVALID (was unused
>    in previous versions and remaining alloc_ids left with 0)
>   * struct ice_acl_tbl_params has a new member num_dep_tbls for tracking
>    the number of dependent tables. This new member is explicitly set to
>    0 in the only caller, for clarity.
>   * Note that the only caller (ice_init_acl()) doesn't use concurrent
>     tables, so this specific configuration is currently unused
> * ice_acl_create_tbl(): move alloc_id check against ICE_AQC_ALLOC_ID_4K
>   to the success path, as the AQ command might complete successfully
>   with alloc_id set to below this value to indicate allocation failure.
>   Also, the AQ command might fail in a way that leaves the response
>   buffer invalid. IOW - the check was meaningless
> * ice_acl_create_tbl(): add unroll of ice_aq_alloc_acl_tbl() -
>   ice_aq_dealloc_acl_tbl()
> * ice_init_features(): remove ICE_FLAG_FD_ENA flag dependency on ACL
>   init. ACL should not be blocked by fdir being disabled
> * Add ice_acl_create_hw(). For now it's just called from ice_init_acl(),
>   but will be reused in the rebuild path in the future
> v2:
> * Return -ERANGE in one branch in ice_aq_alloc_acl_tbl() to differenciate=
 error
>   codes
> * Use GENMASK() for ICE_AQ_VSI_ACL_DEF_RX_*_M
> * Use plain alloc/kfree for hw->acl_tbl
> * Call ice_deinit_acl() unconditionally because ICE_FLAG_FD_ENA can be
>   disabled during operation
> * ice_acl_init_tbl(): remove first/last variables
> * Merge ice_aq_acl_entry() into ice_aq_program_acl_entry() and
>    ice_aq_actpair_p_q() into ice_aq_program_actpair() - wrappers with one=
 user
>   make no sense
> * Rename ICE_AQC_ALLOC_ID_LESS_THAN_4K to more sensible ICE_AQC_ALLOC_ID_=
4K
> * Reorder members of struct ice_acl_tbl to minimize holes
> * Remove ICE_AQ_VSI_ACL_DEF_RX_*_S - will be unused after switching to
>   FIELD_PREP() in "ice: program ACL entry"
> * Replace memset() with =3D {} in ice_init_acl()
> ---
> drivers/net/ethernet/intel/ice/Makefile       |   2 +
> drivers/net/ethernet/intel/ice/ice.h          |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.h      | 118 +++++++
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 208 +++++++++++-
> drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
> drivers/net/ethernet/intel/ice/ice_acl.c      | 136 ++++++++
> drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 316 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c     |  59 ++++
> 8 files changed, 843 insertions(+), 2 deletions(-)  create mode 100644 dr=
ivers/net/ethernet/intel/ice/ice_acl.h
> create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)


