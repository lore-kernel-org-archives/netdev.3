Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000E54DAEE;
	Tue,  8 Sep 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872709; cv=fail; b=QFRu6ncutfUieB99qXdc9k65+JLgi2jMuW2O7MS2IXxz1WVgoXD3Pyc4IFHcTnhATERi1qMbQ1HLEbieMzr3C1JK/+eUtSaoYMQ5nZi1isDOzVF6JbJK5ekRC1x2mCauS0aqXYKNRfnl0ww5rOrIW5c2GEWEOs+6SHjIpiHJkhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872709; c=relaxed/simple;
	bh=eLplvVneBGdu2tdOkXSMaM534nOW+rxSy/uZ8ZcSM3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lUTjCHv/sO4XGg7foTmUNtfVfxXIx+AjAA5QtVwzWZ8IJSwu7ZdfCSc003dcpcKmvdCZ/cdMvOKI+jDv7lEu/OxT6RMblbyRpvrQAm+mYWlfEx+hlyKw+y997crcdluba793+8c/zXPK1UqExv+SFANAj9znsbJsuhuEdfv0ucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfzNatPa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfzNatPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788872707; x=1820408707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eLplvVneBGdu2tdOkXSMaM534nOW+rxSy/uZ8ZcSM3g=;
  b=mfzNatPaLjsbRPjTykUcWt0frEajckgufgjol4vj434snlLobBkQGfJG
   BTiB+i+V95yVARQ1LRj2mehYeSa0P1R/NsCgJ8AuMjZVuW2n6CH7kGA9V
   rg6LErb2yQFT2FED3cOlUdo2ZQDZIZIk4m8/DCvc8VdOnIiq/SEtREgXH
   dmnqBUYiuKLVO7LaldEY/4Wj2ILNJzcHW4y0DjnErCCGhMbjroUSb6jRv
   8zJXOgS0FG78CsU0Fj2p5nVZmaAueqBtIYroalRVr7MYqnwaMRKwpZxe6
   Y/DRqWL+5JndhUaxB1tAqp1viiqla7F0phIIoKUDMx7p/QDOgt3oaPm4C
   w==;
X-CSE-ConnectionGUID: XxPDOYJmRcSFQNxniPcgSg==
X-CSE-MsgGUID: 4y5GZRtET1WTvRuow55jJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89477263"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89477263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:05:06 -0700
X-CSE-ConnectionGUID: lR+dkYpBQNy2ATiPAe6vmA==
X-CSE-MsgGUID: cpM16zqyS0KgXtGB7+iDTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="268419728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:05:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:05:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:05:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjfO4oklZdRw8HtEVi95rhN5YaRzfj+1NNfjlb+1ragqH+PxoNcaap3XlJLLAKL+FczhX4hj6Dr7BM/ss0dbv/D6mzu/ROT4q9sj0cKojyMdGwN37fA2E//cHuC6PdWkIEqpnAESCgFuFurYX9/WKg+rlMd/Zgv9+ZmZDVn2ncBvzloAP0ZFKz8k8xIc6MNZYUcgW7+hRIy/w0uo2sjEG7MTNhbkypuCsuSIOBVgmVIYMsd/8Qai194ufkU7YjOxUWvD0Sdo1OB2+0sO69MX307ovjFK1dhkgP4scFAG9T/1ODagEL9Sw+5BQN7NxW4soN61604XXXqE7xTQfUrNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCXPe3ZAKm+iItbhx2eR1LocMtAGEcDifNn2aVLipIk=;
 b=eItXO4tyTnUqG2Z9y9awgDSBnWzDA5vKEF5k0EsJZFCD1QUkJfvlE3+E31uO58y1urVtBeg19NJDBeGsdO862XD0ueVWJo5sOpM0+GcX9ogkdsIi0WMV+cYVIxKKR/siMd61UPxFSHIY95RWii7YsbTmkeeaPpXyVsBdPEaVl4oKRWAH5uj1wD7OMK/RGSkbzUrTbLyIagLI7thYEqas+5BmkL+p06+HWPvBEn/p8KQ2n0ctgcV+zdsGH+nF+I2Lal95CbxKakWsB5ktX6HU9gGIyajE/+JwBvDDiMYowa9UTnI44B5raicY9fCerTz+Bxkmc8+zDNxrGBBWEt2L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:04:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:04:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value in
 xgbe_set_link_ksettings()
Thread-Topic: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value in
 xgbe_set_link_ksettings()
Thread-Index: AQHdPxOKAYokbZq9REOHwoM7/ccIcbbEpxFg
Date: Tue, 8 Sep 2026 13:04:58 +0000
Message-ID: <IA3PR11MB898628CADBB5FB0A020C271FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-4-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-4-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: b6fc79e0-3f70-4b96-fc78-08df0da9c916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: zOPKG7NlqVb9a8IhWrLmiypQOtMpxPGPA9RAh6RH0UMgQO0YI+4tQyz5ui2IANno0UKfTR7c7KWwaweB9QZXMlWpTZOc8uA6lo0Z63AxTgtETGz0jz7Cj0TZ2KRkBfkbuUHS9hMoTiGnb0bc+T6tVqXmLc/IzJ1Jw1i7Oy+8wxLd8wH/eAD40zDCzzYFwr8xJi1MIBKAMIXoPi2kNB/MEFrP1jchp3xN3ygy69HpzOv3ujJlIr00vo7Rv035oQ8rD9SuoQdPaIFyIEzWegZwsVuudcv6Oo8lSu9i7s9EBu5DdKmvOWXAJbz0b/I3rkWFS6n3EJCNOnMrk7IPviTiccDZD+vaWmPO7IbikdczVabCyHcQ1RESIs3fQ4QcFrDFiv/a3hBujEReqEY5cHjx/56RZiGGb7oEyj/k7ySy67+esIPvBGC8uRhJMZkKBwf8AZrfUQQb4yYsgyESW2r4xY/yk2dS8pK7xXBHO7i1owDVyrKS+3/mkEHnmqpkkIUMqA0Wjt3cLGj61LHqpRtjql//1/1W6X3+2yjMIeWgVhU1B0mK99d/v+nfzO9EI9lW2J95yZDyJoNvYbGQ4ewdHpgnRaqX5gAOkX91l6uwb25FqyAq3W6LLnVQhdVjYdlA4t9hI87MxS3WXVSCxZSTDFGUV+C2wTLGBXmy0t+Njj1CnheoBskAuFeAHfgyhAUoToxqZjtz/cXJxIz06T6EA0+tJm9axMLzZWhRXksonZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5qibDitGdwEsStXqhSp+eYU1/wPHlZxoA9declvsuE1Ca2Y/UuTLUVxlIRf?=
 =?us-ascii?Q?/98o0G1COvGORtxUsJTrRU26sCFKThM2Y7S1wK0ot3OUKYiZ1dooO6bM/VLP?=
 =?us-ascii?Q?TArhSgazwq7uhwOZ+rJ6+yeZFh0Nav9UIzfutRn+LlFFfWrWrGYXNCAbTf0B?=
 =?us-ascii?Q?gsBbiWj3v4vGMMYJPoBaCjaB74MTlaP5olcBqBbaT4atU9A/Sbq9LFFWq+gA?=
 =?us-ascii?Q?YQsnH/U96VSZ1Sq0xe0gH1VaJ89akd5ruoMOA0rzC2BiLJdUXwMyABu7mNS5?=
 =?us-ascii?Q?fgDta+2l7+X+PJ82bO18mibhdt5uXM4ERtc4/dl8u4nzHqpUFngK0pCt2o7u?=
 =?us-ascii?Q?wNsF2y4nb16XgF02PUSWdRsWhu6fXArKlzoFiFU7+6VDYC/VMrZ9JlVkid7w?=
 =?us-ascii?Q?tismbz29pwB/hIVagQm8HAlu+Ff2STB31Ty9ZwiZO9Uqn17d+GtEe66KPFDE?=
 =?us-ascii?Q?wORMPnEpEdWlp0y+yk7iDS/ry7uBhgS5hL8m9KnX3gBeTC6LCMNBGq3J14vA?=
 =?us-ascii?Q?on6dhjjp+EW2B5dwuCzf5arndoeZYzV9NjqU0SakooR+z4tbOPWM1tfn79hU?=
 =?us-ascii?Q?nDRnyLQspVOX4CxZnHm5idXm0neuEpCO1s4jcR8I2LB7XCi1gbdu4JotFaUl?=
 =?us-ascii?Q?4WYBAXaFKnR/71eN0wPeUWCs7XjwjmbdlsvD6VaPvZ1WKUZWFRyGmK8BwPUc?=
 =?us-ascii?Q?01QFf12Nb/RKpBjY5EazVKCFIB0ezHW32mskKyLmOwUWP64KtQufdM95lJLi?=
 =?us-ascii?Q?St8l6fjscSC7ksfIXE2QKwaag64uZnRir2wYGbgZ96JsgINZXJmLkvU9TucX?=
 =?us-ascii?Q?pNkqRgEXaa3XmcOcS6Zx9hWudo0z1TuHTccQDnWXE5hE79GBuqY4YFNGFAVR?=
 =?us-ascii?Q?dN74O6+ZTXNLWCsfBFl1igeoCFSEnS9d9cJO5EH06dgaXmZUyLd1jOrguOcw?=
 =?us-ascii?Q?AdeFlJox78eNV0rsOW0Js8C3m6x+flMblOumg/nhdWhmfT3h9IyqfjGJxVe+?=
 =?us-ascii?Q?swuX2w0DvOTB1OTWb3Yf3AG5CD4prYl+K+zjY78lmoRz/52/6S3ZW1dsbA45?=
 =?us-ascii?Q?FbEf8qLjhr145ZIHRJ8oy7+j0CSHrisqE2SHIyYeq1ZIcSAG7jWjjHFAuVAj?=
 =?us-ascii?Q?r3p+2xnCfJp0OX0TP+qFnGFn6gHMUSjLSIjMbYwbPIvIPyy9cUBwVoZ0zz+d?=
 =?us-ascii?Q?I0QcSdkTgTgKEspPf91ufPsSQLYZxQTiXhfPsRBfaCvlPk7lQ7ixGsyF05VM?=
 =?us-ascii?Q?vIx6dYqFAEOaiks00ApLljHgrPuBmHw0ImuPBdCSknjEIaC/w9mG9+SEsq1K?=
 =?us-ascii?Q?g7TPzLFLCY6RhwTqGItmg/gUhvvdBQxequQGQ9AwLcW4T+tJrohMikMVn4G3?=
 =?us-ascii?Q?QtpNId3UTAa4u9SX1GvJO8I7hgt0YbAdt4bEi2EM4O9nWNz3/ppQwEhKXj2U?=
 =?us-ascii?Q?eqRs+cTgWQL/D085cVN9bAfipFNRmUEwqTg5xeVpl37SuCxTtv5hM522AdnA?=
 =?us-ascii?Q?28DauA3oDMhCV9PmHyqzyLcL/RZpYtGMFwj1tMs993pTBkzxc5L88OHxaA87?=
 =?us-ascii?Q?/DE0b8Tcpg5C5oA4iqqIX6wlfjf0rmGCfTcy0mc1T66XZwk6N4gUXxt1BtdD?=
 =?us-ascii?Q?5nUWAIMUvXxqXcrfrLZxAVqKswJS7zAgg/6gc3z2Jki7cw6IgA+xSJLD3sJ1?=
 =?us-ascii?Q?7+xvfjArjNIhcu/hnBCXlv2oq6DTOFCaBEBNdP6p0WGFwJhOcPDqHA5lXl61?=
 =?us-ascii?Q?cx7Zd5V1O+Ir6O2a2Dygx5bepymw5/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cwz51ivmEVGdxPVDgv/RRd1DpwdWTv2x0mQLR9Jf0SeL9kQr8Mjb3f3wmRvcRxaqLbinDRm3qEYP3VPzWaIKtXyBa5/GlgTwVM3yRYsQNBcWbUEKt9zUkyktrkvNQtSu2qAfottXoRTXk4Uh4s94ahuCGCip3fm8AYxg6M/YDUwhLx1wAPILJv/CgPt1TlmeQEF/2kOYIcNy83o3fy4oUsDEiDJ85dD4tJlvknXA4WGOe2L39mBn1fnlaelmyTJzLkx5lb2ddGS398r1XHJDPQFvLEQ+9ImpWGd9x+lkDu7APYDRxeW77Y7vmY0j65dBcpjK//hRLQtukxzKOnjK+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fc79e0-3f70-4b96-fc78-08df0da9c916
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:04:58.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE+OF7LcvJk61cqQsJ2jwssw1iQRGSNGffBDNeUAa6u2Msq0Tptt3ZwCn9l2GUy4022bFMNeHGCMF5kotlfko9JLdU2IaAC36F1nZhmgoeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value
> in xgbe_set_link_ksettings()
>=20
> bitmap_empty() is O(N).
>=20
> Use the return value of linkmode_and() when validating the requested
> advertisement instead of scanning the result bitmap separately.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index a9f4fcc4daae..113a10855938 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -231,6 +231,7 @@ static int xgbe_set_link_ksettings(struct
> net_device *netdev,
>  	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
>  	struct ethtool_link_ksettings *lks =3D &pdata->phy.lks;
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +	bool has_advertising;
>  	u32 speed;
>  	int ret;
>=20
> @@ -267,11 +268,11 @@ static int xgbe_set_link_ksettings(struct
> net_device *netdev,
>  		  __ETHTOOL_LINK_MODE_MASK_NBITS, cmd-
> >link_modes.advertising,
>  		  __ETHTOOL_LINK_MODE_MASK_NBITS, lks-
> >link_modes.supported);
>=20
> -	linkmode_and(advertising, cmd->link_modes.advertising,
> -		     lks->link_modes.supported);
> +	has_advertising =3D linkmode_and(advertising,
> +				       cmd->link_modes.advertising,
> +				       lks->link_modes.supported);
>=20
> -	if ((cmd->base.autoneg =3D=3D AUTONEG_ENABLE) &&
> -	    bitmap_empty(advertising, __ETHTOOL_LINK_MODE_MASK_NBITS))
> {
> +	if (!has_advertising && cmd->base.autoneg =3D=3D AUTONEG_ENABLE) {
>  		netdev_err(netdev,
>  			   "unsupported requested advertisement\n");
>  		return -EINVAL;
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
