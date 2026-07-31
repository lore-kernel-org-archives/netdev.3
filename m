Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D753AEB5D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505113; cv=fail; b=PaU5JYymUrkBVfgpROtl8HE7y8OGu3I4P7ttIaUTg0BhR7kBVVWCMK2HDMQXT5McabeN6KzRV4DGj6oWcKJuBFcKB/LFgKr+PheR2xo1P6NmJ0W11cWpBmmofg4h4wSGAZ7S9cealtplkIGE/woJZo9wEQKRdkGJU5ZvCmyli1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505113; c=relaxed/simple;
	bh=UI53F0AMVIpuUwZgNiL21lms2hNxeWY7c4r+PzG+fpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3ijR3we11aLfO+dSdEH6xZbwg3HCDV62SirkO9oAFukVhoEWC9aVhr7Dukck/H1tTUFOzbBBYawlRPufi41wUCShDHQcO5T2boh7GZ6tzXcHAlb8wjxPndcbD+N3qskLa4ZtioD3iooOn4wp2D5Cym9Ww/tj+uFf/miAOLoy0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM7dljlx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM7dljlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785505112; x=1817041112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UI53F0AMVIpuUwZgNiL21lms2hNxeWY7c4r+PzG+fpI=;
  b=NM7dljlxGs+0lYmuTcpnPDuzR73XOO59Tom8TLWtUP2Ff/Mcqm4FsOF6
   aqFy2+j1Jw3ZnEZlt+mfgxuVMasm2yx0PM6x0s0levawi1/hG9vkdXuC1
   dvdTvPOhN/dCXlF4DrMX0QQFEXgWPrp860pePYuAjg26Z/Qmvs4GMVh7q
   nXaw2EvC/s0A64ZB1ocx6T+qzABYBF4S7krKCo7TBdcSg1qxDx8rtkLja
   vEFyER1f5Hg2/H9LY4Yi2I//XyOQ0Uwqe57pJ5jhpCanaBhLu21pZ4k3U
   CG7K+jwOAy12u8ohgqlzMt9HxTPMJhtMoDScMpjZQJ0qdFL6+AqRUMXyc
   g==;
X-CSE-ConnectionGUID: EzQr835UTBqiinQdCJB9Mw==
X-CSE-MsgGUID: BQ31DXJ3QNuL2aE1evVtXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86248282"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86248282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:38:24 -0700
X-CSE-ConnectionGUID: Ir/OO6j4SYqK0fcbbc3NsQ==
X-CSE-MsgGUID: A5HD/h5vSzS721qKOhe0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="258795135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:38:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 06:38:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 06:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7hkLLZZVTmBWfZl88e7oJyf6nNqPKI0KksXFhD3K8BCTW399+vtyW18eVCeHL3J8LriEXbLwD1+H9sw4a3CC3dXnAv4fBPQPX+No8N9tn4aEK7XyfDYkuwofmhgqyi/clYUbtW3jAanGk7vyImXee2kzdVCaFLtvfUZLqv5UYyi/GW86Hhxk584xx6ykjXsTmk2Bi7gNriguaWs0uFHWGzkwjqgvLikyY2QVrt8iRWfznNCCZsWPwbvIhJJj/SszuHUWAnKvoM/x2eS/OkbaB/D3UZJBvxTIvRgIL/HaPRDgXSqvMcYUN5DNdlnf1iipmELIM67d4BEJo8y7X2yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gs+31pn6Ir+fL56XGFAGyP7E/zqbxcw6HLxRAtenpk=;
 b=lD9NWuNVel5pGPFnW7ofVzdyj6qijOgUdoIa/jFeB18SrYO4U3dvlY41gRRJYiV1wWLFK9hzfHnJUwOHUJ2yD/WoKwMj6n+8nm7mRnL8xExVyNY3TYZdDitzVCuCtrGESc9APgYc6pOmBNo2Bb0ZgJF46O2yLEx4uN49QgLeuTnuyaC0Gi4lwRUQQ3eH66qbAcTM3wJDc65+4VpNUhQkIGppALEXiMByV1cFFFji8k0g1q/F2oW7rQ3VrTUcrH1MF0IfaWnHHVszDBzdJG6ky982xvkcKwC8EZ7w3XkR3Tchjdu7bp5x34rT2GTxDOAgB8u3pL4MdW+LeMph8Ix/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:38:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 13:38:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
 __libeth_rx_sync_for_cpu
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
 __libeth_rx_sync_for_cpu
Thread-Index: AQHdIOsbXzxZDOnXWkW11ts33JMGdraHocsQ
Date: Fri, 31 Jul 2026 13:38:21 +0000
Message-ID: <IA3PR11MB89869FEBF6A5207E65199B47E5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731124109.99065-1-tactii@gmail.com>
 <20260731124109.99065-3-tactii@gmail.com>
In-Reply-To: <20260731124109.99065-3-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: 137720d7-feea-48f2-5745-08deef08fca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: G5rvq+dmluK+lc28789M3cOLLELNRMXGNN53Nbsgh4bZP9cATCbfdQ6rz4MST24tCBouRt/Kr2rtz76w39VWK/5hmY+FBITuD4SuQoxCJbMksQFCr47XBRje4I3soGszrfGpW/LK2ebGvnyiLXBZSZP3VzID6B+rbNZrFjzaSuSp+RPWc9hCILYQNArt4/+4RilY99KrGjiM8UbMvR0khe5N51htSTmLFWodunzFSKD6r4ZUgEZGrO0tvW17OUnVwYrx1sieDmkAKmz9Xy0dP/PnOxqivzqHJlDmTgDLQb5jnXwXjRhoPVIqXP2BX61PTdJISf5Gz0BIZUS7xTXRcVrJWyRHnbs4LOvCEMJwYdFKuk7rUzHBoixD9SSc8OdpNmn3npHaWrFP0z7Mm2Kkos+yObjr9SOJ+4qHtfTgsi2zAl68xFvdoZEuaAvRr7H/Vq2dWVhqO1agvLOsq9Xo7KIL6nML3Gpp347iX1pxr34/+wN1ipVvys4KBRotQyXn5HAU/Q26Bmo3Km+UO7CvJy2T2byvkmm9GXtxlF7Yqdb3aF3CWsdZQ0YFRvDYvJj1oS/9uIwFH3rEyvzgRlVLg3A0wQc7k3h9JsgqCzTbG657w09BTzH98noxrQ2TUhoIVQytD9hdDVDQ2BgXlfECGDwcf94wjN2kJkWFtUceaM8fEtwckX4hVdGmF0WlSxXe3Ooa9XuQ7sGrRH8f85EJxLj0Pv7MOhl0OoFCjJUiVdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5Rd3EYEybD3JZ5mtLFfNWFgG2rexBPALBK7PmUXixgfZ3mSIbC7VF/PP1z7?=
 =?us-ascii?Q?aRfDuXZbPDO2J2gIJ+oHEV6A9Yh/3xpq8Hao5ULWRk3kNG12fNOBnjnklCko?=
 =?us-ascii?Q?ZJY4OuIRQTsNlu+QXDKoBbs9zXj7LemDkXN0su9QZj0sMJ/6EV44rwUke1Uu?=
 =?us-ascii?Q?IGo+H1e/S9gksUg9Is+6LQDQWrHWnv+exKuYXPAHRcMF01cdRsdPK85WgfnB?=
 =?us-ascii?Q?xroh8QR08+T63OycREdVswKmSWUktIvhRNGNkTg9MU1kRtp6U73NLkVpEWyS?=
 =?us-ascii?Q?K8BFKltjNK09kigRLC/amM5kNGho/38hOIyT6iUoY1IacgYEJdEQe5XTwmyp?=
 =?us-ascii?Q?9WZy8Uf+ECWsAYL7ZWKQDLgWUGH8rWQdpKmCw8FbjEEREglIRpl+xCV1++Fo?=
 =?us-ascii?Q?Y+jZrKC1zwcBOhU3GRDOreij27oYnlAFhWx701y6HyFOnbybhrMge4kmx4dA?=
 =?us-ascii?Q?/Nwz5KNBf07WJoZHWSp/gCeOOEPnvKJd1QAHlJ0QdfvvaH6t0x9OpEmmTuf0?=
 =?us-ascii?Q?5AWvirVOOPO5Btd839YNKhNzLVsfAr60ZwbxOMCXZ789Dz+JOUZyEjhqmYaY?=
 =?us-ascii?Q?y3ZbY6Ggtpi05JB48Lb0DANkWiflJNQA9CLQm35OX0qwBTiLWF3Zxu+6obTU?=
 =?us-ascii?Q?21OP2kA3OlzZNG69NdVGu3fIAXSXgLiViLLg/vo4pCcryb+Q3+i3Cc8DNFSG?=
 =?us-ascii?Q?4A0NBSpgJuTdbCNI1On76LS4LqllqpfAz9ZGvSPV9+9qL/NE/IlDEyYct6uH?=
 =?us-ascii?Q?yJbGWetNGdewk1oCD7KPTBMREXjrhVjLmKkxE7XYFZKu1ycWbEcqjpi5SZwY?=
 =?us-ascii?Q?duxgQCWEV/gmrxWc3nxV9rqymGSP1yEFPkLGuFmIMUQq9oDDSdpmBd37b7OL?=
 =?us-ascii?Q?KQh7XcvgE2l87641Eyw3Yt1cwTbT/5PNJ363OUDbQEtkFaTjyrKg0NHi+BZc?=
 =?us-ascii?Q?1EoTdkZK5Kz0D+CbD2bYcAvyko9NmacZE/YRvI1V/ObG6ueY/YxeyCmRid0Q?=
 =?us-ascii?Q?bWc+MK0saWGsLqqqeG+wh2hC+iLudgZfJcPTlPx5AneAn09cNR8F0pGZIL2e?=
 =?us-ascii?Q?9H99TVuLFetl2EsMWWe5QCK5eRsGvcv4NA7vAoR1OJ6mpJp9U7zD5da4EPZx?=
 =?us-ascii?Q?OOO0wzmL9Dl6UPD7nk60vp8e8KXIxw5Pu+jiwrdKKCqPM7DRMC4GftwhfNS0?=
 =?us-ascii?Q?4A3kN9Pr7KTqs0xrmu39b6PNSgFXSbIeDpBWFRRLZc9zWqDeoMsBV9lEXCxK?=
 =?us-ascii?Q?inlEnOYuZWBLmbTCLu9bt5R2aZKuDJBEgswLdV9AOoMF+3HK06ibzTeZvQ7e?=
 =?us-ascii?Q?ShOm2lSRBouu8jZJR9hOhq/vOs3PW3EDnctguE/+oAWdHSaatmR8jyxs1Ku9?=
 =?us-ascii?Q?xh6gEOywMn9pBfAXcnUF/LbevvbxRLn67m5IO4d6GTS7O5rP/t9rxnnPofuG?=
 =?us-ascii?Q?cS9l9PP/3lrGwg6cEulfjRv873v6I6f1vLI0ie2PB6ZvcKgowmVghy1J1xBa?=
 =?us-ascii?Q?0GXIHYNFCjMPtw0q6UUi5VUaGmcq+epnYQ4UuOvk66zvCj2PoUpGmMrKlEkp?=
 =?us-ascii?Q?xSdn1oJMV06veiYgg2FXxLyukBYrx2TCxvm5iSWTgYXCjJTXGTdskGb8vhHw?=
 =?us-ascii?Q?36tAevDtMtz9taJVEgljoX72KC2kjteNCEBYDGwt61icOUf+MCDT/mfHSOqG?=
 =?us-ascii?Q?Pl6iy0gL8aF/ytXjJzCbOtDc4+bjhtaJMAwBJVJSURrhg50wyzvOuLc4isXS?=
 =?us-ascii?Q?7d82dUHpkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Di0TUoOMrpvtBurntxckfOVkxe9pihrOoMFC2v/7Fm8uZZ/KxUFnal32XQ80qm19qO5FxYdIvCHfnOlbFDy/hGk407Rhbfsol5WiuzsI07FujhkegKoD8aeJpDZ0bNZQw76wZO2JfRs1PzPLAghnds1vdSXQwx2wDDOXL2QzJ3yD8vvQvxTxH+xS0EG++MokanfguntXEuaYCx4EDvHRgvomlogwMmPKWfQJjsGpeE7xFTnW03mcDjqkEXdui8ZDxfRGbwuzQiPWoOix0iLKK1JqDw6i0uwietJsxkvNEW5wT3FvtvjjM1OT6b80mWDFWV5tu9Mwei5LC45i5MY8Ig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137720d7-feea-48f2-5745-08deef08fca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:38:21.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhP6Cwjm4f1NOJpWyIJyOGJot9vSD9RhIeLl6mtCqp9kLUMisTCCFiR/1/gtkMk5csbgcRylNc3uZPcD2VqfZSPGcMXSyE83yScUE71p8AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matt Vollrath
> Sent: Friday, July 31, 2026 2:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Matt Vollrath
> <tactii@gmail.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/3] iavf: use
> __libeth_rx_sync_for_cpu
>=20
> The Rx ring already has a reference to its page pool adjacent to
> fields touched every iteration. Avoid loading the netmem_desc for sync
> by taking the shortcut.
>=20
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index c30abf17cf5d..3ae2f0a0ee4d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1387,6 +1387,7 @@ static int iavf_clean_rx_irq(struct iavf_ring
> *rx_ring, int budget)  {
>  	bool flex =3D rx_ring->rxdid =3D=3D VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
>  	unsigned int total_rx_bytes =3D 0, total_rx_packets =3D 0;
> +	const struct page_pool *pp =3D rx_ring->pp;
>  	struct sk_buff *skb =3D rx_ring->skb;
>  	u16 cleaned_count =3D IAVF_DESC_UNUSED(rx_ring);
>  	bool failure =3D false;
> @@ -1424,7 +1425,7 @@ static int iavf_clean_rx_irq(struct iavf_ring
> *rx_ring, int budget)
>  		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
>=20
>  		rx_buffer =3D &rx_ring->rx_fqes[rx_ring->next_to_clean];
> -		if (!libeth_rx_sync_for_cpu(rx_buffer, fields.len))
> +		if (!__libeth_rx_sync_for_cpu(pp, rx_buffer,
> fields.len))
>  			goto skip_data;
>=20
>  		/* retrieve a buffer from the ring */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


