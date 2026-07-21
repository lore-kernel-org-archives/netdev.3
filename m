Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F5403AE9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676562; cv=fail; b=lvhBX8ifD8dtTZI84ih16FwCIJpK514QyB9DopVEDIbmiamRxDkRsPQmg7Em7jaqMM/gV6r9PrN85XIPz9Vt9J+FGudg8LWnZa+6TJpBSlZBJ3JQoovtmd59iS7Zl4ilAQiIcOKxa5wxaQYDxqexEACgq0f18PtXcpxXUw/DXGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676562; c=relaxed/simple;
	bh=jLarzqtQ/Caquu0s/sl4MPKYLdXIXhcVh9IS1bCVrh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPHFu37MU+hrfyRXVKSKOW9TI4dbDDhZKKa1aaU4ABP3uBAjPHbYqAmgu+0WhnaAY7nx7aQqS2Fja3PRkBxkVqt4OpmW9Ws4HAfsM7if+DZSQxGvwhV9lGHxPK5eJsC+vn+gAyhi0F7I3k+HXVgHj/e495fRbrbKT854fShY3IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkQMSeIK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkQMSeIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784676561; x=1816212561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jLarzqtQ/Caquu0s/sl4MPKYLdXIXhcVh9IS1bCVrh8=;
  b=MkQMSeIKc5PgSBWo3x6cKLXpvMwqiCBx3EBpguscyXLXfwIDqHgUV9Qd
   qYZb4l6pWewnuP/JlVUwqZEwLNCXmITMTSga+XVXoCEao72tzSHjRGuR8
   fsLHZjk0UYyprfxVzwXSytjiuNoy/RSEQFpufoseidXqgqFzqtZAYBg0H
   gZAhvVnRMV2E1E9RxypAeah35eRZevyFgzL8JVQeDhVZjaPTNPEt0Ecq1
   gC/2ofD7l541entodrQehPzRRb1erBQN1QHNQR1DDQvdkMuRtZVpgZkxy
   REYCHVJ1L2U1amhazX8w0s/UreEJxXm4C6SoV/WNp/tvaZDDhwQZ2YCwU
   g==;
X-CSE-ConnectionGUID: LG3pySb8T/qGCsUJUUkyEw==
X-CSE-MsgGUID: cvUItM18Qx+j7KnSV8uojQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102846264"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="102846264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 16:29:20 -0700
X-CSE-ConnectionGUID: rHcgaXb5TAWb+3fMCKoj1w==
X-CSE-MsgGUID: GtS3Do3eSLmHFHqW9f5Y0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="296121321"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 16:29:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 16:29:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 16:29:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 16:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpv0W9o7/GmzXPady4V42GojWBwjfwPtT8LK0nR/RqJDKoQqMmEyYTpvAL6XK6ajUGOtkUVWSkaar17CNaAzkf3/NojTOo+OPidNkUiWO/O5W2TEYxTPa8VJPuTtBYZhH9x/2II4d4Rmch/IWLzyzKS9EGy8BLQRnHCTP2gHQDFLcCcdJnjZRYGfE656/ma4Kq1frmeMGu+3kYht+6BjnR5+SMjnDs2J0gdaEs004vSEOh9CQ041qswjBRqlX9ZNQhyD4B1XIQN3YEbfv1KxAEliKVYw/Kd9WtxJDOXYSfdeio6WleD2LoEdVURS/lfljxc27Z5bs7XnnnL7H9g9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7tFnv+3vvM1piVsaSg37r7eS7u1FgRc4mtQkcwUk5w=;
 b=MWsm4gB/iFHreVYXwUXEWma1Mg/tpHcQwAWUEaTJ0WZQIM2mxfaznK82qcG0Fo/f9aj/owhlVNlQL/3w4dK2pFbwfnl8O4qHhC7mXolnDDg5QQuRDPrrtXUHipmRWVAc4j2Sk8pCkTvM0XZwVkvlxpStk4KOgceB9P0eOkiGgiaEi83erfytOpxy2FMMfs+cxAMEcDK+kYD/vBsRQqHLZtHv0OF0yagNXeU6rZfgbF4RiqPWD056L5VunH9VwR1xX/2uEuuYW2fnbW3r/OxvnmflpLhJr1NWRsSEqJL/prP+p03FiRXL4T89tzB0MPDkJQx0qagKSd+M66gAX9AR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 23:29:06 +0000
Received: from BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440]) by BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:29:06 +0000
From: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "D H, Siddaraju" <siddaraju.dh@intel.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, David Laight <david.laight.linux@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccwACn/MAAA/6EgAABI/OgAB9dWZAADCGeIABZfngqgABXDYAAABB1Mo=
Date: Tue, 21 Jul 2026 23:29:05 +0000
Message-ID: <BL3PR11MB63856413FCFB7F30D30E469688C22@BL3PR11MB6385.namprd11.prod.outlook.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
 <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
 <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
In-Reply-To: <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6385:EE_|SA1PR11MB5874:EE_
x-ms-office365-filtering-correlation-id: 4eb21cb6-c528-4c22-1770-08dee77fdb5c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|4143699003|11063799006|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: KNwCTKl0quURKDvZYahVlMoCRJOk2AHPbZKY5Izmvy0JeaJlx7HH0KFPSWKGofMK0Nt9TK+xsFMbdzIhkL3epoYcbWj570X2N+fl/hH21CD6YVyTpr6LEHm9gCjPIejs7geqe7XIBp+8CexCo69qyRqHBIwxm1Le0i1uOFkoDyHd/P++keqXxvD60TbV0TCq8DWjuRuwp2AGKtdAxVU/1QzVe0FjctI0g7ENUVsnY/ffXzA9RgdNhWC/Glp5QA2t9F7ui4iqtg/P2v998FsAEIQ42bzzgHiBhVW88HlS/zN2VmKCLWeBQXeu+95zY9mIn8HgxifAvJTYIs+HoxF32sp62uZZ1VcYBxg1fsjiVrR3+l10AuY6mnSXKeM8z4C52l0UjmxAbWH613XyuqPHVKGts4gqqd0KC60YAWb9r9XjdSm+2lOQs9mha02icdTXxnCgALcRzkth41yZ1SRmrhQ8ifWFeCtnjXtUa/Rw3/imuFYXJ4MNGnmggOvumE8UEoJb3czWxfON0xqJBJ07oIK9NRBoIrY9DUxAeZiaGcc5HU0g7KrvmbO8R9NHjMoCTbl6uwrhnwxRk2tA+uxT7SHUy+LXE/A19fzp3iFp+rhZdPWpdrZuy6dlp/quSmSicELlPlXz2AbJX0FwWRtqz5lspDFHrxLpwiiy+FwuS3Bm3PVbi2flWrCjVnh90Lpy29xghck6BGaXrFggxnR8F6AUMP/Mo0fPEDY/Bnd3GQM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6385.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eZElsWk+hyDECQ1+SAZKDIsz1JPqEcv6d4wV2+zD9Kg1Thco/RKAJlCMSv?=
 =?iso-8859-1?Q?8/jv87La2TjJ0rpLjQnWm+pSH6tZ2GwF1grP5X1q5ZRDBIRhXvFkJfBJDS?=
 =?iso-8859-1?Q?Dm8EDidcBu7KkJ5K6Gr37MXR7nAOFCgEUOQ69hSI4RvgFS4U336vwt4oAg?=
 =?iso-8859-1?Q?kisdGVXWsvWiN5a0yN7YfrcGt6X04eQo/6C4KM8Ll1LqmD9WMj/QEDTKaB?=
 =?iso-8859-1?Q?ffXitBBMPiIYwPVgrjltmGOokQN+FS3Q4A++sqZOZtAl0AKJ4RMJH7mhin?=
 =?iso-8859-1?Q?MWKudb7pp++QFlGDJ09dBQurH6wIWUNTuVB3bYRRMzc+Fpiwn1TRHeKbvx?=
 =?iso-8859-1?Q?Oqw5RF/yi76U300rrYDPwp98fRGztK+SfuuITbx2T62dkAUVsRKkBoxMdY?=
 =?iso-8859-1?Q?EnnEPIxyaOJ7inI6NdR3vFoSBwdwjHJUumpZD8BvW9fy4n36PoPxb5d/oC?=
 =?iso-8859-1?Q?JXJAnnHyKzWU+PQyaMkTbzYVTuGaOQJ77T6uk3aE6eeaBhI0Etl2b6pYn8?=
 =?iso-8859-1?Q?eO6uyXsmAKLiwT6yb1kB/UWwjkdP8KZMWunRlRakAY6xhNCHgiJfAFa1oA?=
 =?iso-8859-1?Q?LcbEOAflpRtSewW9SGHyU+9O7k331/kFuJeQ93dZ4vxHre++yLLK0VwW8e?=
 =?iso-8859-1?Q?5aNR92X1HjiIFZmRzi/guz32mtiNXSiaq6srBI8NK6cW81luBRdhjIGy0m?=
 =?iso-8859-1?Q?eSXKX2uvBFXL+VF5DEmpV/k2T/XJYjPNz5oKDpP6YfR9K5MXLVOlcOhg4L?=
 =?iso-8859-1?Q?pZSuKZpb4ek7xWqSJwaYxoEunJ5KLxn+AlUtvmxMvseq+XPvlTRVdOg8xB?=
 =?iso-8859-1?Q?wKe9cF0sjwj9hUgY3An9vRF1OceH6EMaEy8DdqMXMYXLPEJi1CQX1P+E9a?=
 =?iso-8859-1?Q?tHKSrkqbB+YFob1ZlSDkSIsJKQuCNcOcInMw9ex+QKkY9LIo8pMusWgiOz?=
 =?iso-8859-1?Q?opTUWGkmTvaz9dsUxwuPos15MZG0+zep6QmZqMqC7OrcaJDk1BoUFyukhy?=
 =?iso-8859-1?Q?CLHjHCUypBtv0IItnwHYNvypMitTesht23qGip6KyfD2aTa+SLPeXz3kq7?=
 =?iso-8859-1?Q?J7jnJSVJL7olw88iEKQA3cZ2KHUwfgOd5AXKfR8NGIT6x5ik8Yvf8hbiC8?=
 =?iso-8859-1?Q?dIBU2FPLbtl069SEcqkb7hCiCoSNL95GKgEvyPcihmOwM1j42JSp5BzCXU?=
 =?iso-8859-1?Q?7SRTJgAX6/WpmmSvoAi9CC+NGCZpkhakxdmSmyGIRuuIGPOYMQpaN6XMC4?=
 =?iso-8859-1?Q?JSlkrMebxfREzyZs9lYHA6IuBweO8kf/MhZee9qI1uo0wB37jmf5AoubmB?=
 =?iso-8859-1?Q?b5QQWXytHWUkO63k2PEYj/Pz9EdDbbUHvMdODa1EV6qcdNlpOQfS1LfLD3?=
 =?iso-8859-1?Q?olnYnVHWIg7QSyEr859279Z9/bS+deJ3xz7dV+etRhV7oMOCHTWkYpQnu6?=
 =?iso-8859-1?Q?+4Er1kuLryRFXM6mWDCCrgKUUD2hv6bwcickMpcge0+GWCD/ys4ZODucrb?=
 =?iso-8859-1?Q?gNerFqjF218SuqjVaCsOVs7+QLnlfO2AiXQNTi0cHi3AFmlb1kYjeNeTae?=
 =?iso-8859-1?Q?F6R3QlsG5wE+eGxswpVdF3FMj6i7ROZY/GS4VbifD1RwLufSakkQaNIz3h?=
 =?iso-8859-1?Q?AGewoGTAngoUXfpcw/WIYLaSYypnOAMsQDXUphZRi2LsyY3DoRGfmJwTic?=
 =?iso-8859-1?Q?fTFOo+hRK+gJmyYwrWTR/BoVj5JGrA9FMdA4URw51b0Cx3yaDLfmYxplD5?=
 =?iso-8859-1?Q?mIzUbt2nJZaffXh4DkTJ6hHKnRFR7HzghOZwCBTQoAzxZqSCiaFVlQz+V7?=
 =?iso-8859-1?Q?rCiTrdA/Hw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G464qGVhOu28o46+U57NJaDoN/vwWhhN0RZnUSFtFNtt5Fxy3EvwKmCP3mCM9w+Sj534+UziwGo35x+TVDl73W6nKXXBouOPwysGc5ialXuXhHJytD1lr3mzLcpvpIeUV5fTDJeXt9nfq7/iksI5Sf6nH6SAUte9kSA+HA9DisYDbLmodARo9MTmJkgc9X/naK2BP2sVDwLAwTDChTocxOk8r+crg3d/zRR7N/ZyS64P4dXDC1BBTSnB5UuR3ykA/VyCFOEfIuniB3bSyGRQaoNrL8CHlTKEeNnXQH1L8hcp5hkb2g/EtgMh4Vn1Ieqy6eRwWdopuQAA9iklYpJJ/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6385.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb21cb6-c528-4c22-1770-08dee77fdb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 23:29:05.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6SspycUSPytPHgptSxJTxa3w6BTv0vbaQ5z1sGu1UBDNWwx3QEWQIRncFjz0Teiv5J48dlx/k85szwwOu67gtnAgq3vIyyHGx2842xnMSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com

> As for your comment/question about FW vs linux controiling the HW, the in=
tent here=0A=
> is to use linux to tell FW where to go based on user input.=0A=
> How the link is eventually achieved is all in FW.=A0 =0A=
=0A=
> I don't see how that works. ethtool has no APIs around=0A=
> phy_interface_t.=A0 All ethtool offers is link modes. How do you see=0A=
> this working?=0A=
=0A=
Correct me if I am wrong but isn't that the role of the driver?  =0A=
I expect device driver to translate Ethtool link mode argument and pass it =
to =0A=
FW via driver-FW handshake (device specific SET/GET functions). =0A=
MAC and PHY config. which includes phy_interface_t for that specific link s=
peed =0A=
is then implicitly handled by FW. No other intervention from user should be=
 =0A=
required.=0A=
=0A=
=A0Vijay=0A=
=0A=
=0A=
