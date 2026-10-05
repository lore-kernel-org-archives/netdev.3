Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A69499F0E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215826; cv=fail; b=bTttJA5+vxa7vPLN3pLTqB0lRAENQ/1YZcx5grHpD5V4SCcWXVjOwfmlj5tGqJl+wOSp7hmwOyGCz2FBPvvz6ngm1D5FiVdwbRyEvw2sf2RHfDIZNS7p7kK3EZh9ttV6V6eTalGzFptyquMbW32S0zDTVkgqzTojed7GmJmCtq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215826; c=relaxed/simple;
	bh=MUsa56BYciwn5Cz1551gzz42Per+lLE+nZGdcU4728M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8VpAGIN5Zn31arxIs4NiTR7+M/QGkP2wPoAle4LKzISKX1e5A7nSsIlRvIwUX+30L07WcQvqo8VLAdxmtfHySHqLH2BRf3KF4fyyUGpu+K1kuq3PO2liOYvsd+bvy56kfq1jsezMLUHXjnVb6QwpFXecEyLBo7VmSal+X4KmFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Otj31gi9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Otj31gi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791215825; x=1822751825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MUsa56BYciwn5Cz1551gzz42Per+lLE+nZGdcU4728M=;
  b=Otj31gi9mNWV3ke7nKQThNhEt66ImTT/ECsh+HvBPV8gKCIkTfQ/5EDc
   Ws/A8zRHnrOg/2v8g4LbME6NjnaKNB7KPz6o977QlJQgN/rBln72XpHA5
   kdR5hF+aJns7EI4nzyD5DnayUAYkanlg5f4nBMte8idslNpjwk5pJIFm6
   PYtumJS8zqU6EhTUke5lKn4aSruME7fjvczzwynTGAsiuSPjry6Z0QGYe
   rNkgfhmcMwtBVpDgFd9Z7Mr000vXTnBsIglHvX6JHp+V5iWajlHqVUGYM
   Orn6rFiKCuImesvjNm8gKIdZmOvIrAAbPQPGQbc7aiSlP8TXGuPhR5Ja3
   A==;
X-CSE-ConnectionGUID: O2NlcFvcTXCbSTXTUOuRVA==
X-CSE-MsgGUID: osK0cCu6SyK+k4ydSRoTOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91021954"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91021954"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:57:04 -0700
X-CSE-ConnectionGUID: Gkq9dGKhT4KWRTjX39x9mw==
X-CSE-MsgGUID: SRKv+DQ/SNGwmNxgcBRxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276974553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:57:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:57:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:57:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNLSd50cX6q7DQFRUR9E2FTshgc1WGI4znC6MckKl3ywmI7BPIRlYf8i8s80APNmRdtzK15hukDcr1BkqULg+oT0q+SYvlQoLd7hx/IWTzgmqA3AapyTaNVMynXEtDmcV/U85l4Ducc7av1qvdizAUtnVAp5Epu1wKS1qcomUkr2t9KusJIwkLeexK/Vh7LlX8QHpzH3but4No0j8MmdTVm52LGg6TQeW13PYep5WaJkrFWKkYTfQfDs779v64A9tBZc3QsA42PGYrMEoCpq86olY0H4SVhDHaLKEE7o9FNmpeXxZRxatvmHid8we0t9UDIKW2LOCfLfu6q4zxtJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKLcsahXOv/QkNN0//hja42FXaVQ47Ihbyy6bVmESM0=;
 b=b1kYFeECiKCya8u1ReBabfG4picqiLnKvEsDai7Z1f1QAy3wdv2q5W0rEt+C+ZnZshNEX/9XCj33FP039T/zfgchuGknGaW/4LPsqqi1oGYlyM44xze9MXDERook5XPHEVa2TVclfMSsitAhUfg3pO1/Zf6oF4TobpWoNskRq9MiwN7/mWaDzz6Ko3av3vRF1kWgGzF0mdNxdObmZDCLblz5yE/eo8AxpMDOWe4MJSzq0gxFVaHggFHp8CQA8fXNQ6l4fHe4OvvEch4UI/Z+nihiOlM3oj98zkwmPHjDk8rX4IDC2uoBNm6EYHjpCA+RMs+EPQanUf6l8PYua7AXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH3PPFCE69B97EC.namprd11.prod.outlook.com (2603:10b6:518:1::d4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:57:00 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:57:00 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freeing
 live Tx rings
Thread-Topic: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path
 freeing live Tx rings
Thread-Index: AQHdMW1QjXH+nHJpFUGQrl1EhuueLbbvYUVA
Date: Mon, 5 Oct 2026 15:57:00 +0000
Message-ID: <LV1PR11MB87902717E622DF21B3446E7390962@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
 <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260821130157.1451118-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH3PPFCE69B97EC:EE_
x-ms-office365-filtering-correlation-id: 18d4a61d-e3e1-40cf-06bf-08df22f94a8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 9AkEPeuLz1u96PhmmX2ccd7ySJ+cd79KaW03I1+CDosigKTEtOXadR5R1z1izqbveynyKwzG4uaPsiPuacJphhIfrNI5mqijTSWujxG/sJqsOq9sUa79247I/ikcabSJ6X++WELJ8PM0t6UVpCFQUdOwKyQB/d9XTQeo+DRzSZ+hO/11NaCV5jwxusHpkB75lba1lZXU+5FVWqyrKMb99qN/XZSW+H+Csfob3IK/utxQ+c8sNietCtj+6tvVTQ/RFEoGTZwbTVHZwIJQQfx2cqFB3TN5IPs6uvfbWWvDFzL0U4lQlTlfH4/X8xa+YPP4y+B2KFSAKVXiT4Ug9zc4q/O3p0HxtNlEKa/DALXcKkN1PvFNuHSmtbrvPzqp352DN42VEiReQm4BAtHHHPF9izF9Do3KK8cMQROHvcBCbTV7TKC56CRDctnJzh2Y2HqTbvhk5WuJht6S/m+ixyMb4pENsq8JKy9txaHOs0Yhkx8kK6KGY/IXEGFvZiJZFjA65OAAnk7SHHIbPK5/m+gk1w1JSG2V+Gitgvj2iPPAsnh10Lg/bjVaq6uI4ZmVnmEhRKNFiFnYzw/KUgkru7M5ysvQCCgHCRf0co5Nt+pmZ1g1Po4dS75SdJoWr/sUqzK5/u/ALqkrv/vZcw2UEMSw9/YVb7KS5rfu6Z/MYjCSdw0vOvvzPrMN/YckOXItJsL5FfxqbcQyeKuERzISy3Tli7m2IY+D9A3QZIEaO4Lhc6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FTgxdtbtlIcYiRG2cTEOENGdfHEJco3dfPSoyfNOD41Bi9uW0kaAJhZB5Swq?=
 =?us-ascii?Q?gJOXf+YWISP+oDE4Wef/3hpxcEkl5ocGmqDWIo4Q71ycHCLLGM3Lw0uQyMiF?=
 =?us-ascii?Q?8aWeC9UvioX0XNObAuRRjp+CyXjeZZZrIeLnmbSN9/mvKDFW0JC4XH4My7Pa?=
 =?us-ascii?Q?GMf9qDmi/kWUJuPTmVFslX2rXAm0+5umHVM8zQyicpUREqtojAKi0g/j0ix9?=
 =?us-ascii?Q?oo044CHk7x5uWDYN6Gn6xc/hHxNC/E9D22ucd0iO5hTEeZAK0qMWsHUlliR8?=
 =?us-ascii?Q?SfJBW1rROq4AHBClzg1561s5PqhACgrBlH1O8Umz0tGVf7zkgsIMbCd0Z6Ie?=
 =?us-ascii?Q?q6IC0dyQBuvgoL0jRgvGENYlvdyHNvVflrWoyVmORevT1QdgfaoUKgMug7+S?=
 =?us-ascii?Q?Isk2w5bpEjiPg0pzUJw0hYjhy7JtPeuxQ8xvZXT8X5DRecubp8P3+FVCjnhb?=
 =?us-ascii?Q?u7XxJ399hzymBJ5N+4LaPjGzYYOrxLl1DfaWfAm8v69/PL4C2zZsUXJbN2G/?=
 =?us-ascii?Q?K+UZYm1AxiSlc2pEz1lH21sBMW81//G45zyKIzZRGdegyxQ3z4Lhki1E29/S?=
 =?us-ascii?Q?PrqYNEjMntSXUtFWGN+qzI4ZdFkPMWRAPo0ya0WcR8GbYRzXJZsgLtIYAstP?=
 =?us-ascii?Q?CRHusjqCY5UOig/E3H5Zw9iH1m89l18EIFUZU/pqLEhhTgAaihdcImrwCiz+?=
 =?us-ascii?Q?r/x+lBognsCXMCKt/FI4jaf9nY5UFLFZ7qfc/X4WOrut6aK9OlpeYELf5vIg?=
 =?us-ascii?Q?GX2k2pfq6D7lu6Jyiry3E5ajAj6YlER1MsaozizYCie9KLJnz78G82kuG31j?=
 =?us-ascii?Q?oik50hCvp92ipUgVgAtnoCGQhIS0h8ICseb6p5GhFVAMiVUxfbDfxf71HH9g?=
 =?us-ascii?Q?StaCC1TG3yMZ5X9lQljJU29O+0mMQeHoPYgC45xECi+4V4LfzG9Yf5tu0TV2?=
 =?us-ascii?Q?qBXHr7pUvzC/J2MTQwIkAAkeauIGT3YDlOBH6wkmwmTkyG3lGRzsbF3oCnGb?=
 =?us-ascii?Q?kQja4zHWbBUZzaaZex5iHTyzz28zrxogrkjm2Fje2o6j6hj5eqHShHFZN6oV?=
 =?us-ascii?Q?tLzpsjF70t+wNLS2O2T1vaQQub7GJogXCju3KIZMppz2Del/rSjJC9Xunfq1?=
 =?us-ascii?Q?WZ3lSgoEXovd+N5OTYv50NotB9yT+22ct67QkBuYm9oPTVDPQwagcRk35Yl3?=
 =?us-ascii?Q?vQhKDrFT/s03Bk7S35Lv7In4HQhg8l41fFReUGehkwhctHMeh9yZF3a0MGI1?=
 =?us-ascii?Q?EVCwmFVEny8e4vqhzc98P8WAECd0Iz+06Wae2xVTXCNsKvH+bdPKOvL4z8rH?=
 =?us-ascii?Q?6WXrh3rq8WQO3BlQezjlaQrRqCho/vammTDH0RAKBj1g5YC3OiTCWbs0+pxF?=
 =?us-ascii?Q?8fenQ/WpZ2Zf8n7Q+/sJxOVArPjV0rqOxdF+Sj+3afrbi4pz9WQAYwPp1Ump?=
 =?us-ascii?Q?XWwWKyXIpaocv83MkMGkBOE7PI4YKbnsq5dWehnhbnwmsIVhWu/ryxkWepWd?=
 =?us-ascii?Q?n1H7p2e7J/Ye/M8h/dtqF55ZrgiiPUeCkV93PMkKGpI8KcKhBr4sFQ2mLQJY?=
 =?us-ascii?Q?hjExNTGBP2tc2+WnN4qa1hdchqNvcaNpI03+TxTjIY3hx9Ue2BbelbKplJ5O?=
 =?us-ascii?Q?Ld+UCYnA2VLN6nmWSIup+NIzTd/7YIIWCeQC4jF7zCAoZkCKU4xXKSNbgksM?=
 =?us-ascii?Q?HAlSdQ7Y5R+Ejae9S61WnjUZTxclOGH3x5PZDoWVuPOh6XS9Qc4xB7HMEx2e?=
 =?us-ascii?Q?pwiseJknjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ENBS1HAUQhvET3MuI7Ie7uL2yftx4AIIcvRJeOgtFRu55nBiDmVmPLDjhByb5/RSG2rFdRu4cO6wp98E/O6Gf0dK7y6S+ZV1MiZu3xJYC0QB6Ef++tKz8PlJPRF1KLTCrgZDkq89jWRI02UjbV5cCYLYKYHLFBlno8tqkBKGeB+CI1buA4KDexBZQGUXOEcI/IqNIwXwXIJt0dabvsCIxJ2GUpu1SPWfQCrcH+OdzBT27Yg+mvLDdDQene3eec9jySHfF7jgZN0rKvZjFruOKeoGtI/3UYBQtb6REeyo1bRFbDE6SLC41vvnULWqREE92z+NDL3zVcXndl1qgQJ7+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4a61d-e3e1-40cf-06bf-08df22f94a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:57:00.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF8xnIqHKzg1BazIPuJ2SkuNGsxKULi3XjfN50/Ho+AxiIQ/wuI7Mwa5+EyFq1EJDdW8zkET9CtdYrMO+Pf15vPJT4J0c8aar8WnDhdqDZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCE69B97EC
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Friday, August 21, 2026 6:02 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-net v2 1/2] i40e: fix set_ringparam error path freein=
g live Tx rings
>=20
> The free_tx: error label in i40e_set_ringparam() is supposed to release t=
he temporary tx_rings[] array built before i40e_down() is called.
> Instead it passes vsi->tx_rings[i] to i40e_free_tx_resources() - a pointe=
r to the live, NAPI-active ring - rather than &tx_rings[i].
>=20
> i40e_free_tx_resources() unconditionally NULLs out ring->desc and
> ring->tx_bi.  Because i40e_down() has not run at this point, NAPI is
> still scheduled and the next i40e_clean_tx_irq() call hits a NULL descrip=
tor pointer:
>=20
>     BUG: unable to handle page fault for address: 0000000000002000
>     RIP: i40e_napi_poll (i40e_txrx.c:942 i40e_txrx.c:2769)
>     RAX: 0000000000000000  RBX: ffff8d0a53ea9800
>=20
> The trigger is ethtool -G with a TX descriptor count change (so tx_rings[=
] is allocated) followed by i40e_alloc_rx_buffers() returning failure, e.g.=
 under memory pressure.
>=20
> Pass &tx_rings[i] instead so the temporary rings' DMA descriptors and sof=
tware buffer arrays are freed, leaving the live VSI rings intact.
>=20
> Reproduced on real hardware (XL710/XXV710) by forcing the Rx alloc failur=
e deterministically instead of relying on real memory pressure; confirmed t=
he box hangs without this fix and runs clean with it, including repeated ri=
ng resizes and normal (non-error) resize paths.
>=20
> Verified via git blame that commit 74608d17fe29 ("i40e: add support for X=
DP_TX action") introduced the incorrect vsi->tx_rings[i] pointer at this ca=
ll site.
>=20
> Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
> Cc: stable@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2: No functional change to the fix itself. During review, a related
>     but distinct pre-existing hazard was pointed out: freeing a
>     temporary tx_rings[] clone with i40e_free_tx_resources() also
>     resets BQL/dql state for the live queue it was cloned from
>     (i40e_clean_tx_ring() -> netdev_tx_reset_queue()), since the
>     clone keeps the same ring->netdev/queue_index. That hazard
>     predates this bug (Fixes: 9f65e15b4f98, 2013) and is also
>     reachable from the i40e_setup_tx_descriptors() failure path
>     that this patch does not touch, so it is fixed separately in
>     patch 2/2 of this series rather than folded in here.
>=20
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
