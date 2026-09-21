Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3C495500;
	Mon, 21 Sep 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005104; cv=fail; b=gTCtPH01s6JbPV7+C8Rbl8kerPtU9w/GFf2RBZKMbvLyk0wQXYyjie1qCxFLQZZMvzp+LVEDKSY2xsDRgOSwLg8iS7Aec3O88QXpmnxBPtHLKfkI8ks5FLIdh3XLQR9jsouUeHL1hXhoMmNw8tQMdPC0ljoMvw1QApyplhzE34g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005104; c=relaxed/simple;
	bh=Poad694m0qPvhSesT+th1zTiLEWmUAULNZZymKqZU9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNX7Wa6oAC6GQmLLq2uI1P8aBmlaFziowuGWDAln9edsSJhIEkxK/Gd1mKnwP9twzqvOW6L3wza93yGmruQVGKi3wRMu23Sxr6ln/NMVgmfFa23yVKIscXLCDbek4GCVCP2Ch+fZUBHc+47jlgI6emqN5qYugyOtco1KRFUNVpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4yaRZk5; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4yaRZk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790005101; x=1821541101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Poad694m0qPvhSesT+th1zTiLEWmUAULNZZymKqZU9E=;
  b=f4yaRZk5cLBq5lS5KnPd9I3aRvIoCw3zQWqlG+Wwn/bmqxFP62c+jteg
   3HughbIg5dDhDKFak+jV46NtdP1ri81GTU3WxrlqVm5dyEfpyOdlSb57Z
   KedqutdGNcgOg9FfDnqVcDkPaspWWOTImL8v7NLcsCmK0mvfe3wqSEuJa
   TGDW+tH6eBe2b3R7oYmyNT9KGqFE1ArdFdaTRBS034PnVoVMrvvG194XH
   ly11ivkKi8OQrmv0yrUWSiwAukzvNRMor2R1No6vPvAgi0g3gWNKfMD59
   qYKsWeZkBe7sVzw/V187Q51A0lDp4bL+YkdZ42RU5gx07qRIGaKxpv1dU
   w==;
X-CSE-ConnectionGUID: bXEdzym4QJCP/oOXnn9pWA==
X-CSE-MsgGUID: 3GXJuGAdTPKZj5kHF8gFJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90398209"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90398209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:38:20 -0700
X-CSE-ConnectionGUID: +HOgJsw4R2agFYr7Hot+kQ==
X-CSE-MsgGUID: aJ6YuRU7SlyMNY4ysJRytQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="298939846"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:38:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:38:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:38:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwji47BGjDo/Shvr1q4Dx/rhAcQ69bP0WsPiJsaOgow4WcpPCDlnl+wGxPHabZ/ZYrNDprkSx7xcS/HBE4j+H4TFLFjTXylpV2VA5IulTCNMGiXTysMd2alB3bEDr+aIfLK2rhfj9S/5L73dPizqnat+UMkbfRB7bl/RGQWj+hzbbbNIu62/szqEXbTJaJkvfdQITtqNELgOq4OkSm9sYFX/aaDiB7jntpwLJe3zT27JAdDaZd4Eic+d2ENK6cz5/wRXXUPvI58KyxgYiSIba3Pe5ueX3YpX9zzdB5TEX5pzOSwTZNorK6Eu1dNJkcpDUfgjD8pzHRS0Rap21GWxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G5PwWRPekVsWCXJhBC4O6pgzO4gtiPTmTiL9195cfs=;
 b=TiB9gnEEab+PQWm3YffcAAfjgnwEl4aDcnNC35Yo0Y0grU9Q1Ur1vxhUT7+9WuyJt37e5RGK2EGapD4K1SkcsaM4EQKX3iBuaTsYVN/Lm2XmejOSQ6h0MpAitrwrGruHbUMGeeR5yqPqEhK1CrVYzVg8NNzn5gBHqRqSWGkG8zoOtCaIj//+u5NCnuJTD7jnIEEcipW5j7xk9z6L3L/pO+y3xBIEYZ+pKMDjIPVQyzbUxPDqeW+J2BDo51vcYSVWTLa2N8gYm7euustL53KS0OpykihxOQEABcshhQJceIvf2wg9jqtwwN9wwnCjYwjb3GbyQg+hPq9va18OLq+ZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB8967.namprd11.prod.outlook.com (2603:10b6:208:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:38:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:38:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com"
	<syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com>
Subject: RE: [PATCH] net: e1000: fix warning in iounmap on probe failure
Thread-Topic: [PATCH] net: e1000: fix warning in iounmap on probe failure
Thread-Index: AQHdSd6SKc1qfuTd60OoAKqrPmb1zbbZKdvA
Date: Mon, 21 Sep 2026 15:38:13 +0000
Message-ID: <IA3PR11MB898634DED4F39601AFDF1145E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260921125932.7943-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260921125932.7943-1-nsvatoslav515@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB8967:EE_
x-ms-office365-filtering-correlation-id: d8d2b2af-db56-4cb7-3a11-08df17f65923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: 34f1LGC3juhIq/117xHwhTjJsAHDGmQbGY+0bWfpjx/5hS1YUkxOS26f46P7f+fAhFVgeth0Iw7SySHEVxc2/rV3351JtJLRiKFXq6g19E/F42fUnOm0sbNoqsV80ZSelpo5NFeEGYxKsGhjhVMXBl5f/fOnce213JxmCXrC5N96nQtFxANigkBOOrQ6MayN7Blpzv75Bh1agNJefhy3PM3TooEXHgbs9UKn8gFxJnPKiQKxEtY1v+IvYUZ9bfelswR2b0QQYlU+n9/gZee4unglj27h9hLHvQP7QUlcbHUbKT6dLUBIPVcJhTiwazXyR+BUppYtXkJaV6/sge65Y0IaUaQV7gbNm+xoR2O8ixvPC7vl461bh80skDpoc3nvDC9ZslUx+B6HAnr7eU1Oz8r1s/raybaN1nCQmQqyQvJZYYw+lQRLvYDymFPAiIuPuf1G0uPpAgRlc8pRpNxQVSKVuQAh7BTRNnIYzHLKnnFuJ5ARnNoaXE8oX0hPbHE5D7/AYR1acXiXeFYFthCmSDR6jIrxK9RQSPjK5cGrITvZEfXI0xKc8A562Lr/PoU7iZTxe1oGOI/5myGazvtXSvTG8jd5R4jwIZI73q4/vbV6jN05MU2AHB99XVJy2uiC0qaAmxmvhqJJdDow7GxsyA6+5CgpeZhVdB+vZb/18B9pEk+inPm2T/QGnogr/V9Wa29flUxYN73LcozT2zGJRv/nMc+Ia3SbongocRaPWjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HA0IrYvDq5N8Ienr8UJ0a74qoOocvIKff9GwR0P6nLp1ls/zYPGI302pipWR?=
 =?us-ascii?Q?5H3YDror4GOT7QR9p8TsKjX4sKsFCUbc2n8FGgT9BABAY7h/G2kGJYP7be5g?=
 =?us-ascii?Q?lqVU8LcT52wk5/EjgawsNuBoOGOuy73Tuc7huDwH4mkZNlXBUZ0ojCCv0Bjm?=
 =?us-ascii?Q?w+kyE/qdrVGjzLiGI2KQhwniFEZwPqO3DxGqloIfFud8BC0G4f6UboC8Tnpb?=
 =?us-ascii?Q?3ZuuLb+32ebBi0tKdG4IbFV2B3FOOBjDWH/jDK2ShLcHBQkX3aKlInbMbO+O?=
 =?us-ascii?Q?T2sQeyg6EJRlRSEf8dk94fJwEcuZ5rA5kvKCV0lUlTuItR2jwObpjUSkyuOp?=
 =?us-ascii?Q?Pp6vcU8jt0+RoTzMLB3XSyp4Bc/Kf6mXk4m1ZChTefP69rMGwfiA4D+u2BaM?=
 =?us-ascii?Q?q/dwm3rcSKUsbiO72jTSz5F6RHIgjMxQgsqiQq9I3L8oyDVoxo0/rIrtD7ug?=
 =?us-ascii?Q?VqeIsBMGTkuwe2+8IDO0XR/AvZN8NaUSfc3CjJ+g/+5lbVljuLEzpsOBnzM6?=
 =?us-ascii?Q?O33+xNKXD8nSIAf50L3mHDeqvpDsLOjUdVuL1pVRq05nIAoOihL1OurejeMB?=
 =?us-ascii?Q?k6eFba9rv3Yg8MuT0a94u4kte8bQxPsIgJQoRCc177jdN76M7LEic2X339Go?=
 =?us-ascii?Q?caB/1tNrkT/IBtmTnvHlBcpetMmyFnNHGSEUK6M63Y+w3CZNLqTeIqqX5es4?=
 =?us-ascii?Q?jA8Yjjl1AHuw+nWVhcll7lGwt3BGIQcXlTKSjmmqPQHdkwChDIXwitfeFsmU?=
 =?us-ascii?Q?sEwd+wv1E47gkJeFcrI18O/bZ0D45bv9PYx38oFuDlZ0thgpTGGaO75nfPlh?=
 =?us-ascii?Q?Y3S56HP+DsyBfPiihxtGuRmOGWrjSMg8RSIMZSNr3bpzt2BUHUmG3yY0WRd5?=
 =?us-ascii?Q?jdKjA9ElK6UVcBAj5MRlAjXA+qtDqNThG6Zbs/ZRUGt8rloNygZP7dHDzDbF?=
 =?us-ascii?Q?f+RwtDZhUi9X7a12/ek+AliXpjzckMOhpx3AlbGHLIIQxsVGfreTwThNenUw?=
 =?us-ascii?Q?N7e8uH55b/3M9dxk2KSHhCxkLbYwizzzVU5MAbdcSQcCLElrtGuRxccOgP2Z?=
 =?us-ascii?Q?4elgW1g0I4cUTrWYh9lQOcFSpTjPU0fo1RmQ3KuuStMwCjY5HfUnNOsnDvzH?=
 =?us-ascii?Q?g6mBOUlKrrmJVfK/RkT6JECo2SqsJo2F26v+i9XLd626bRk5v4e57Z38GaI5?=
 =?us-ascii?Q?/DljZhOSJN5zeJmSGDL3uYDOQPiK22OYml4JtB4jeiqJhSowamjFIo99y5t1?=
 =?us-ascii?Q?oJjoQFy9QFYRYsgFY9WbuHrHM5LYQdxVQSnSjIeg0GOQqNTqNNggZTVO47we?=
 =?us-ascii?Q?tqoIelKRON7UEAT2jzYzF/TdFivYnOhKQdOY/lAoG0xcYuvdgdxCUzpLdUV4?=
 =?us-ascii?Q?3Xsk4c+pWO3Pw4+u3/XSAqYvDo3khREikp81gcE2hDiAOvPzCyvnq1rlFm5Y?=
 =?us-ascii?Q?pFqhJeomoai5XIMcY5UA2sEdY8yN70YYfztVpair3h3h2dRHD3dRnpBZUupc?=
 =?us-ascii?Q?U5nkFVUrBIajUAnASb/S6i4/x/PjqBVrsB56BvO9Sd+Cy4Vzh9ljeJSnyVxz?=
 =?us-ascii?Q?bQqXwGanqVjkAgJl/ZDQ6zQxdEEzSlzpGZz2mhxuWNAVmECI+GQpJlr5iWae?=
 =?us-ascii?Q?Gk4fQ9rqRDSTQn7WPMRHuGz6acIowic1DEt076+32i+R10Oa0dnt3er+X3tX?=
 =?us-ascii?Q?6frvqPGLdGrWZVfK181XJjvF+33bXBL7Leh+6IoFVhHEsX5UGU+elRofVg7s?=
 =?us-ascii?Q?qoBdlYrROnM2W+JPAGjssNfeYWKtk9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zECTLzj5L/r6UKTWkJR/G4ds9oDQm/mR1l/HrqyNvf4sFiReaKHr+sarC7FBrXRE8kWrDS7zXVr8tdjggkcG1RdtvewlyN2GtipAmnSQE5kE8oqb4Ffij95oDeAYYRVQFsdPl0W/J62UcUcPMsxTek0v5qbUvfv6ltfFs4UJyNVelO/msLCBCw7SoeaN5ddnGX2zszqDMvUNJTmV2+jTt006nN83/KU2uxHzAW/I/o1tfCf3UoMl7uobs+D2ZZ4W0q94Sg+zPWQQ4KNZp9w0P4NiCOXlBAsIbGGA0ZGN5ppl/5IvBG782lx3wymYGG6ARFayfC45mEmDjeM6MKJvQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2b2af-db56-4cb7-3a11-08df17f65923
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:38:13.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPlgldWr/gvambrW2HGLU0I+eDnuyyk5y5RDJuQfDurxZrBXGmseSvSyWw3zAG1NBo1lW/gbMPrjD1SUP71tXuulLm06P/il6I8psTGjq6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8967
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> Sent: Monday, September 21, 2026 3:00 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Svyatoslav
> Nikolenko <nsvatoslav515@gmail.com>;
> syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Subject: [PATCH] net: e1000: fix warning in iounmap on probe failure

What configuration you have the reproduction?
What are the reproduction steps?
Is it a crash?

Please specify which branch you aim to net/next.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com

Rule of thumb it needs Fixes: tag then

> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> -	iounmap(hw->hw_addr);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);
>  err_ioremap:
>  	disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter-
> >flags);
>  	free_netdev(netdev);
> --
> 2.47.3

