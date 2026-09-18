Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92D50B407
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746310; cv=fail; b=biHK0GbajwMaVURdWQgsJ1kq9fWoS7M/3ch/Me6OkZEQQ664CoGrOrTQ6uFpZZemGIunPxg2gycHYrhl/hNPGKsp7YsjdYOKR1wWblKxuy5paafcVZwH88oFma990Dao1Zveo08OdEQJk4N23X/X4hB7dPaZQZCUpsNLtbeHIMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746310; c=relaxed/simple;
	bh=xC5cDiHJqBX1CVvfVDPRa5PoRJQ8zKYZUqbGK9l9em4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jnmfa29r32UZ//87geeLF2M0uA+41gMWoOYy5DhPfaViGTGcrcyOnrqV43d9pz2QSDjOB5lc5ogb5ZKe4RW7fwwJXQnJbQLvOyfr9aLQZbb/oVjGu+pMbRKRoDiQ14Yj2ERjurN/o8QhEzWV7lnC3HsXhj9usHiNU1/82l4+rwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZyd+CZ6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZyd+CZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746308; x=1821282308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xC5cDiHJqBX1CVvfVDPRa5PoRJQ8zKYZUqbGK9l9em4=;
  b=eZyd+CZ6g2gB/xK3tw/OzfrDHOkLnm6f2osoxZBFNFAglMzI2nna4h3P
   v7C5PxSpYzpL49G7kg4pqQI38wPK8CncFyP3oDz7b/YIXgva1BygpMLk6
   6uwGRf3WY2iaGof1u97IfKXrqZofd9iWIvgLgDkePY2q27uxGVZ+6sQrF
   KAH6k+2+dBcnzP2lHKMYBLDAhGgJS/kD4bRlrCupU/nZW9k/fsYa5wQNY
   ieHMzCQmsI8FVU+HszBJ1aae68ZBjWGG8BdRjVqdDQPLR+8jpPC8SKc35
   Fs8nkBbcGRxmiIu+epn+T18CzDAj+utim33x60VBKpuUwaAQg644WU3M7
   A==;
X-CSE-ConnectionGUID: csxXR8mPTs2cGFGP3p/uow==
X-CSE-MsgGUID: 21mb2ilWT8uvRdoptL3wew==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77825104"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="77825104"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:45:07 -0700
X-CSE-ConnectionGUID: MlDMIPGfQdqbOCmu9sORxg==
X-CSE-MsgGUID: j8UKAKH5TXKBQVWdrlXgfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271129298"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:45:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:45:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:45:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snx9WR9Pm6OoEmYUzqDPi6HBi1/9mTEC8IlDhn6Nh19AlakLG592pJDlfSD3bDpcSaY9PZs+9IV7aLKfr2lVF7KDpsNS6sfnAm8vinuM86914nXpoBLGYa6U1vaKetpyhxgsCl7cpsbXm5T+/jKpkVF1LHxFJbQfJGPINFGHAa7xqRgW5lK1mANINIw8ZKlYU1zLu/zN1y/2LJ7VkPQpCyGKBRvcgMfYKY/C/m9+g1ft+cZS0AvWK/TSAzFCWDvy4Z6wKM20Ir71nkiKGhoJXcSQjV3SAoA+EqNXxJ8SDVj+pb1LkPKAXVS+SiGLL8iMJVR1uKkj3IayPvQBSlUcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojjcglf7/4UkX2MKeQCGcV9wHIpUzoZwJHOqiuCVnl0=;
 b=V9TOByeXQo+CHsDfOpV8wavb0JbvIHH0oswJZeJoP7REuleoTEPID9s9E0j8jxfd9OcgZS/bVd8qJvDWQ6s00i60Km1wmmczd7WxrlDBkhuUDUyShkHCJeB4fLHU0qmLO25j0cOpNemdpKhLpIvBUhLaSCYJTLGyq8+B+D5wgeKFL8IlkrJr3IZAkuEG4oKwogcz+UZDTiOvESMfH/AYNzNefs8haCU+bJ84lw2/b/CA6wfG5D3XgfAI6lL2SODTJ5ZsXW0HeECj7ZGJ1druseqyFMmKL18Qaq4TdQwzOISf0v7jGCSdp9yaXs+DsREqREceEMtWkwbYY9BcMU2bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:45:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:45:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tian Xun Ng <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Thread-Topic: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Thread-Index: AQHdRr6ucef/9VtgoUmXjw86AmfVcLbUe8Tg
Date: Fri, 18 Sep 2026 15:45:03 +0000
Message-ID: <IA3PR11MB8986B87C6FD950C4AD69634CE5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
In-Reply-To: <20260917105205.37561-2-luckilystar08@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8622363CD:EE_
x-ms-office365-filtering-correlation-id: ebfd2551-ff99-4bea-5f43-08df159bce47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|11063799006|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: mpOPjnmq82rm4/+NmaCBHfdZ4nHcsB9oTxQjboVYYwAYZpJutM46VVtrCAngaRlff1M9ME69IZDdgcfRqXVCzUOf9mxmKQyUMdkLNP2A2vqhbdR/OmqG3z4AXWXviNtuG8RSmjq00l4qLyxakOGPnW4yWvJ0Q0WxlllTl08Zxyve6MseY8bavUWu6gtQE3ZQUb7QXFfFMc+w2gUSgY5mRDrxuFgY4ox0gJqdDKSvvOPEf+qJYmPhcFtz0bFI1azlIs1qwmM4dizFEpKewvtsootVFbq1HNHkWS8d7ZPvNFZSsEcQjxVokHagDZ0uOVe0NCXGJIELH6TUi8697Xzu6/DCRWh68zcwXA3YUPrexiJYPqnwr/8Lby4qvfWxCFF4p6K9/sW8xyLSsw8+PGZUR66L8P1js5FXbC9LxDE/9u+ta40BVUdhPQXlAZPS2mA0Z0JGdE5eG45vw4FIdwrT87QMBna2w/+IVTR/+qk50QssXicLMRmZtgAvnVFDtpx65LkkAGe4A6iS0WCVFyJLNxglbpjFbaDaclhYJBO6fnzeW15rfIQMnWX87KAS05AVsrx1BiiP0ao/gCcpAuOsFSRHCGzuWNW9/rj/H+aXHHNBDFFoxh/SLW2YbKveQx+qnE6rN5ddlJH4WlxiUSoNyKDg0Yz559kl6rfbBmiI0cz3Kbe0OgO2fWCWQgmEAP2MohU3tdMM5j+qjxVYHpsMEhdWdtrNjVtqfyc4mBN5Dec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0KqiJ2wTj4igBHO7JEkDve37DZgCkSA6WXN492h6Sm2Y3Q4lW8UQe7yR4Li?=
 =?us-ascii?Q?a6H5vYKaPdA0bqHvOXzNwTIzr/xz836Bggg6nX+HXvG7ffhtGFCEKpCy4RnE?=
 =?us-ascii?Q?rESz2t0QPRAY56YGQAp4phoethhGWnEJ3+s8AL12ExNO5k4tsZ1AzsxHbxqX?=
 =?us-ascii?Q?hyEOi6uVSmGY/V5Ulg9fqTwHax/azPDTq1uqCrhshKhmj/TxEEAk41i7rYvR?=
 =?us-ascii?Q?xE1gfv0sw97iZbuEc4vhTo0yU8KrN1/p+6CMr8buEm/D0VGaKar3G85NOpwn?=
 =?us-ascii?Q?MoOK9UON+ok5IT2UlH3OQ/V7Gqrr6GZ/M6IfhJkU0dfNaeob70D0RGt/nmdv?=
 =?us-ascii?Q?orff+01hH2IEJVxfvm08q6Kb5hOqf3X7iSiKC6QEJnjHqSKcbnAr53isLPoE?=
 =?us-ascii?Q?gxbnRg5XUu1yc9tSGA5ztCAoDLLuybRalshCZl6Zah3es5w+2zs9cJ1yi18H?=
 =?us-ascii?Q?xk4MlYtDim1sQDfaQMBq5Cbbg792yNijf0VU+aUMeXfJFY7EBnrSGT9BYI/h?=
 =?us-ascii?Q?gS4vTxY0uT0nzYKwCaBHQWuThHKtHiGIrm15Kp6HZxqaJVZX/sz3xSD7X+xq?=
 =?us-ascii?Q?V9WtlluRJkN21p1sJVI/KIf4x8x7o+5vBMYRGFbr7pmyyX6ogkkwaZrQW/RE?=
 =?us-ascii?Q?VnJUOzS97+NrG3TciEZ6XJ38j19pO2J+cCycggz7OzHPv8OTv9ZkJaY8PLit?=
 =?us-ascii?Q?eXrfD8YYfPh7pv1LZ8US/C7IRrk9F3YHoOqgX91pL8QMmBHNdmOptffLTYl8?=
 =?us-ascii?Q?wU9yfIN6r2BV+cxZMgfPZRSEJdcwz5meLLIECNl6JsTAirxwur4nQMxsaTx3?=
 =?us-ascii?Q?vurUJWSIEtlsIt9/2OSrqgRVVNVL9httS2mcCzGcrwE/TsLkOva6Nct4vnn9?=
 =?us-ascii?Q?6li1f4UolSucy8BSxpronNhnVCAfrJInhUQU9EgJEIjx4Yj0oL3FxJMvzCa/?=
 =?us-ascii?Q?DLTe2buINRZaEBhTIOzr1iEK5Ei9GjxyFwC1iFhreu1CE0pPHEQvZN1RdRiw?=
 =?us-ascii?Q?u5+lgBZWhL9jvB2SWtthZazIJu79/eaScBtIhBGoKBSE6lUxF3fqdePiU0bF?=
 =?us-ascii?Q?9qFdtqFFq5eqY90dC4nT8p016sFE3tOIMWepWJCaTxPHOJf2c/+P7f/8TYRp?=
 =?us-ascii?Q?EFTQXITPDQeX1sUzrmPX+HPjRNk+hY/1g5Ch1TnwWiVY6VfyNqm8ZiQp+MH7?=
 =?us-ascii?Q?IjDK4CJj2ky/gfWrVZMCDccqd9IEZmFu3MACCmmOXW+9arUAikuBoTXwZnO2?=
 =?us-ascii?Q?QQqAaHhCX50Dg/foQda2kbRxaGlePtxtiAa8vXmBK1Rdz34qM8K8gOdni+lM?=
 =?us-ascii?Q?3EsgZayykij0diKI6uLHypz2qDEQPQbdvI1ymd81dqYilK7gi4/hQe5sieRD?=
 =?us-ascii?Q?DjdKx4T0mWkVv7m5XtHqLo+pJnb2w9JMbIgQPv+vs9I7XwfHO7sExWzTi642?=
 =?us-ascii?Q?QZOwpJk+4aHYRzi2hc4OrvcLATClrisFu7leF2Qw/xgTLJJip7ofMhsQVaCW?=
 =?us-ascii?Q?Cnuk5NvSz/ICjs7Izq/3r9v3W+anH1DexJAjDlpGEpqih2XGqdq13COau8zK?=
 =?us-ascii?Q?XlyDE5ITwmYliRvN1swRTX8wfbdd1y/Ag0d5+PVSofdF4dggkBdaBRP8nRFS?=
 =?us-ascii?Q?nmpzZZscEeLvqmFpQWVy8CjsOVXGG/cNrCHlYnFo+KLfEtZrqnKq4ojSixiS?=
 =?us-ascii?Q?78Wt0DWuiJ4hYMitWNPrZDzTynCNhSep7lDrNqcfJqiSVUW/t6QVvnCWWkWm?=
 =?us-ascii?Q?VJwrc1/Gc91SkWVQPEbytBo3XbEG67Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aMNcbK8dDW9IpCNwxreRbcuNCdVB/X2XiyMgNP8NacTMJFIqQroYaegwBdXMWC0r7QRIAk4oWdPFlqiunVyPUI5NjKYjMyHIX0lHY3T/e/PXI73QU+4Zm+26LDqPlQfwp87Jf+c1p/eTZjDrBKZP+pPRCDRT+EnE/IwDawLwKbBHApc2oqOkqXTts7oKyTk46xQTq+IZyRo2Ml92dI75eUkH8+sor0atOMEzrqMyreMm1rsQFx3zBuopQ/5/Ma5z+uM5bz78nKBm71tmKoLtG4gc8Uv0V7tISMUw9UDKZ2h6VqBP/wR2Aa2usmCJutxuE9vmzlzwj0TeEOo3ka/QOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd2551-ff99-4bea-5f43-08df159bce47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:45:03.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Legmh8BRCRBijjiDZdkbB1fAuwePc/PFgv3DeK4NcN1c9a5LqroSXhRg7YTe/JUQT0okw6Xz2EKdstIyDnku/bL41thV4XtgvEbuRjxkk70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tian Xun Ng <luckilystar08@gmail.com>
> Sent: Thursday, September 17, 2026 12:52 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Tian Xun Ng <tianxun.ng@bytedance.com>
> Subject: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing
> down vports on shutdown
>=20
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
>=20
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly
> instead of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on
> shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the
> virtchnl transaction manager down. Without it,
> libie_ctlq_xn_shutdown() runs before idpf_deinit_task() tears the
> vports down, so every message sent during that teardown (disable
> vport, disable queues, destroy vport) fails at once. The device is
> never told to stop its queues and keeps them enabled, with the ring
> addresses of the kernel that is going away.
>=20
> After a warm reboot, the first queue reconfiguration of a port that
> has not been opened yet (udev setting the MTU) sends
> VIRTCHNL2_OP_DEL_QUEUES.
> The device then drains the queues it still considers live and writes
> SW_MARKER TX completions (qid_comptype_gen 0x2800 / 0xa800) to the
> previous kernel's completion rings. With the IOMMU translating, those
> writes fault on every such boot:
>=20
>   arm-smmu-v3 arm-smmu-v3.17.auto: event: F_TRANSLATION client:
> 0016:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0xffb70000 ipa: 0x0
>   arm-smmu-v3 arm-smmu-v3.17.auto: unpriv data write s1 "Input address
> caused fault" stag: 0x0
>=20
> In IOMMU pass-through mode they land on pages the new kernel has
> already reused. With page_poison=3D1 that shows as "pagealloc: memory
> corruption"
> on most boots. Without it, nodes crash in unrelated code, e.g.:
>=20
>   Unable to handle kernel NULL pointer dereference at virtual address
> 000000000000a830
>   pc : __tlb_remove_table_free+0x48/0x118
>   Call trace:
>    __tlb_remove_table_free
>    tlb_remove_table_rcu
>    rcu_do_batch
>=20
> or with a slab free pointer that decodes from a slot holding 0x2800:
>=20
>   Unable to handle kernel paging request at virtual address
> 002613b73e862c6e
>   pc : kmem_cache_alloc_noprof+0xc0/0x3d0
>=20
> The early shutdown exists to avoid waiting for transaction timeouts
> when the mailbox is already gone. That is the hard reset case, where
> idpf_vc_event_task() shuts the transaction manager down and sets
> IDPF_HR_RESET_IN_PROG before idpf_init_hard_reset() calls
> idpf_vc_core_deinit(). Key the early shutdown on a hard reset being in
> progress or detected instead of on remove, so that both remove and
> shutdown keep the mailbox up until the vports are gone.
>=20
> Hard reset behaviour is unchanged. Remove is unchanged unless a
> hardware reset has been detected, in which case it no longer waits for
> message timeouts. Shutdown now delivers the teardown messages; if the
> device stops responding without a detectable reset, shutdown can wait
> for the transaction timeouts, as remove already does.
>=20
> Tested on arm64 (64K pages) servers with two idpf functions, with this
> change and the next patch backported to a 6.17 kernel: no stray device
> writes in 151 warm reboots across IOMMU translated and pass-through
> modes, against stray writes after 20 of 20 warm reboots without them.
>=20
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on
> reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++----
> -
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..646b6e074 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3197,14 +3197,22 @@ int idpf_vc_core_init(struct idpf_adapter
> *adapter)
>   */
>  void idpf_vc_core_deinit(struct idpf_adapter *adapter)  {
> -	bool remove_in_prog;
> +	bool reset_in_prog;
>=20
>  	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
>  		return;
>=20
> -	/* Avoid transaction timeouts when called during reset */
> -	remove_in_prog =3D test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	/* Shut the transaction manager down early only when the
> mailbox is
> +	 * already gone, i.e. a hard reset is in progress or has been
> detected,
> +	 * to avoid waiting for transaction timeouts. On remove and on
> shutdown
> +	 * the mailbox still works and must stay up until the vports
> are torn
> +	 * down. Otherwise the disable and destroy messages never reach
> the
> +	 * device, which keeps its queues enabled with ring addresses
> from this
> +	 * kernel after a warm reboot.
> +	 */
> +	reset_in_prog =3D test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags)
> ||
> +			idpf_is_reset_detected(adapter);
> +	if (reset_in_prog)
>  		libie_ctlq_xn_shutdown(adapter->xnm);
>=20
>  	idpf_ptp_release(adapter);
> @@ -3213,7 +3221,7 @@ void idpf_vc_core_deinit(struct idpf_adapter
> *adapter)
>  	idpf_rel_rx_pt_lkup(adapter);
>  	idpf_intr_rel(adapter);
>=20
> -	if (remove_in_prog)
> +	if (!reset_in_prog)
>  		libie_ctlq_xn_shutdown(adapter->xnm);
>=20
>  	cancel_delayed_work_sync(&adapter->serv_task);
> --
> 2.50.1 (Apple Git-155)

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
