Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E11917CD
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848341; cv=fail; b=E0FLZJtBekQZUppVYQhMGNGIzrQtZzQlcLiBwwmUlp/9p9SnCec9rzaPJjHEUZLwd+tTY855DZEKtGVYntWlywJeJix2uHeF+pz0hvUsDrCM/xM0TKwi9q0VEQxrHZj+sxqboVq3Zsu9RFqBPjOmOxAe/422yX91MnQ/tS17oW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848341; c=relaxed/simple;
	bh=W28VQ86wTpkeLd9WNkU1WXBdw6PkD3Ez4kWXJy7p5BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJh5fUVo4gv8GvXflzdBoG0zTCLHI3b9xtvDTtNfjaIRhPsulpfMSfUH/bZvlHx+/U5L27DkWuW94X7EgtKLJMA0yxHcj28gJg5hlg7RrcmfqY4+hK/430MLrk8qqRGUKbUjYTwmuB4PYlz39tSVDldpBPKnaPp2nqQ4brYnd7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhOcgRdP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhOcgRdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788848340; x=1820384340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W28VQ86wTpkeLd9WNkU1WXBdw6PkD3Ez4kWXJy7p5BA=;
  b=DhOcgRdPsCaAJkarXkpeoGws4Mvj+hoUForNwszFQ+usb/bZoL8uy+vS
   h/XwK02KlkAhO1f3WbKB7wUh/yC3PW1ZIBhiAtSt2M9hm/ugPi5DqF0bp
   5qzLXIhzauHeoe9VhMco3ETYvMKxO/UfrNkz8iyZk2kKQKMjsjsL0xQZA
   3IHXrrjY4YCU3ZyoMNRsXZQbow0NoN4I2uNGnx49SB/l6N6WWuplOJa3e
   niZNL3ukwAIytk6GPc5/83CCE0otc0kvhK5Q3Sw1AFr+jvghdN6EyCIRX
   TXfMKTPBtR7+uekqq+GiLE/NKc6fCq7rXzbNiQHjNTqIzvXAkvKweLcn/
   Q==;
X-CSE-ConnectionGUID: ZHcce4CBRP2OX0lZmFiqyA==
X-CSE-MsgGUID: lwuEugkqTnyNrdyBEikN3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89284723"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89284723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:18:59 -0700
X-CSE-ConnectionGUID: vAhEoCl9Q2KW3GdvN4vM5g==
X-CSE-MsgGUID: WBDvlTYERtmgVrwy1WFdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274413417"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:18:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:18:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:18:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzib7Dq4QfijBZKqM56HbMAaQiQKpwwpDDFNfl/V4350Q0PuCZuAubhtr9cfgT/CCwbxC7NKr6zjycJxeaxAwizPVW0KjH1/xgsBLqVrvmA3HbicN0i8QXs2UghL00TaUCLb6Kuf+LDPUlIZAcfD5eFPa5txFyQSmrMPC4nueY7IazbqKSJc//B/TiZ70AMRTFFnBpIniCvu5G+JGzCXMvGBnHZ4aRYK1B8OVeGtF9exJxOEF94qaqFtlXJ16OP8qP2VqzYJcUIAxiKhlzIQyIr8ltPgUodUDu1k+RMkKWCDBClO9VS39YSjKN9zz5igVFKDAUgO70cSMGziB148cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syk6PjXWt2MiSL1RO9RpDH7yla287xA5uQSmgAB9hMY=;
 b=G6OGVF+BbQnvIk2vY6Avvzpp+cI4+Z4o1CcRcxQgAKu9dnf57z6hO51MM4KSeTnTDOBhxTm7YP7PsaqWopdh/wE1eyVp9A/eYy7wFTWvIujQ3Ly4unalPZm7GO0bSVuyUQWXs11QXg5cf6lor70mXXWevkNPLkXq6RIyUBb/oo218unVGssP+4TbBw4f4tmEowkur0bOYiPA6TrDUZiwsPSKoSoFmxNNPREoKJh04GuPM0v7mmIiCgkhS1wQirYGL7st5Ym6SU6Sx87SvKyI/gVGNdfmH4mX49ErgbxCiMkSw8UqY2juWQIOl/vIqq+7kMhldl+fZxnU14Ng1D3uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:18:51 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:18:51 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Index: AQHdCVeWdfVMVwltNESqSuY7s2WwzLbEnH5w
Date: Tue, 8 Sep 2026 06:18:51 +0000
Message-ID: <PH0PR11MB752226FC021B80C7FF12A345A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: c9e1834c-a965-4495-758f-08df0d710d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: eI1faCd6rIBmEm7mfn6P1HzBVs6Pb/mRT3gM4MwFlYJmVXsTSJL0gZcBZ+qwvaXsX3LNokZA1K4DVd4B8ZV4BeZE4LyonRLybgNpZWN2lLKw/iphi/uqjppCOgjjH2diCjU4FdefGIP1nGGYHu7tsgw7mj8KffiR+moHpYvJD7pyaHPqFWutwuKGTLGq2U0rj51l3Ft9w5IxqmKr1ZJlzGkSAdb22rvr4Yul2FDLOBu2kBz/LQStwkPoq5WJiXeM9S2k44qBpAsRkNUfpL1QIBcIXCPDpRWsyqxXeH1bn3dF6SMzN4LK2cfVh8HRm/0kHx0RKd3oEd2nooOneWhU78NwAqvtemIfvUJTnu71cI5ZqJjpmvVz317AlE2RkeUpyjYo+lrNQtInl0L18O8tPOZysmOv8OhH2aWNhOPeuXi7zOzJqy2nc9/8uFvB3bO/sjcFkH7AP+BvdTX5kvnXLbk7NakJ9Dc54erUtpDdF8c9OAgPP3mBce3VWdC1IEtkI1oB9Rv6IgkGy5G77+zgcBxAneOZnBtIN0wLiOrIRt/tUg2lYOhxNnUcCFlKCZceiIH5snHJChqroGUaEiDy95MEvZ7dlSE/DaAjTDfmNHQ+ha3Rhl2seHmUhe8WWM1GDTFvspk6IpH/dEKVHQTFKPQq8iMdcgNngSfZ1PBwyHr2Ae7E+cNDj5NRleiPiJqcOjEkgXA6HTNUTjybRYsByni8JxkYQcZgrfWTBkEeRFs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VPrWCxpEF+dfFUmiygTjPT2WN/sBUamDDd1DGck/jyiqWKJ4tcxSU0Rz+Jux?=
 =?us-ascii?Q?2Tjf1Lu/jPIY3kZldd3kAwzawKfKlFjCm3hD44EddhoVdEzOZHijAw8UBVZ3?=
 =?us-ascii?Q?Ta2p6mj0I/gHYyna5TA1jfkxGAl0gFXvkqTxhc/TMincsSu1O04SlPjqV6ai?=
 =?us-ascii?Q?6lpPcdW4MopxiTmFJWM9OLvbL7riaGrOo9Vokf3/kTQT14FRTbEzYLcv0wus?=
 =?us-ascii?Q?rMNKZcDg7oxBk0rvZS/2L3SHRTsYI6MJjq7RlshH4oXcDnr8Xoe+EMYoFGaR?=
 =?us-ascii?Q?L/6T6n+bH/WBNYLa8P+YnAqXVayP5pb5GKP1nHl5K3JLBlc1RPp1YiriDulx?=
 =?us-ascii?Q?S2cDQ5829phalQ4ykTDDEWFIlfHzqm0XRIeefq9Z3hPJvsnWaZGY4RX6jaqj?=
 =?us-ascii?Q?R4IU/8fOx9Hb9/WeFmacFZ6bNMkE+pfRuGE+6mJZ9Lc4xYkG4tO1+mL2ViO2?=
 =?us-ascii?Q?UusA1AxnFmLvEazxyPSnRZ/3eYP0GbaPaiUt871nyfXMEO3KQFNHZZadrJC9?=
 =?us-ascii?Q?R/17hDQ16In8iuHQD55fJEIP6hikONuRG0SsfGhhTcQpfl3PyF6sivw4ydsf?=
 =?us-ascii?Q?8wai9jVaDBwb2rdmbGmlViBi44CNLkD5PRkFGjM5Q1xUZD3/tckpOj6WZ5fl?=
 =?us-ascii?Q?vz15aVnefnFfe7Hka7/MIfVNlaPwMcMWWsQJVFwMoavKaHR1Xu5si+XFe97U?=
 =?us-ascii?Q?0uNbqvByIx6JdVrqXySXVRI3Xo4tkaBmrfQRtqQGownhNZIy2lXtAv540Ge9?=
 =?us-ascii?Q?BCPEM/+rt/oQL9HzVFks4VTxnzWSvlisb7umlnMNqobqfD2sKUMBEh4ML4Vc?=
 =?us-ascii?Q?9zuuIupUfeksUDDjxsn38AaSXgE949FfukyJg8lghHKnjLnRKnsAMLbe7ioF?=
 =?us-ascii?Q?S+Y3hY3MUXJAUk1zczDNoe3OnQiU1xJ0EThBYSwOI5yv2Ts6Gu+JCU/wrl7P?=
 =?us-ascii?Q?nxgGpmATzGQfqzDq3O9vpet2z5KRECECLfYWnZ4emwmJiMyBAgPipDurhE7K?=
 =?us-ascii?Q?aciU1oJIUl7FE2WlQeDRe5PQ7bDsJDlhoRkjAlW9PBJ9EOJeC5qIM8zEC0Vt?=
 =?us-ascii?Q?QTjnJW4Ib2/ZxFOG6HTtMOsZC8QlCC2RLHUsjnidf1dgCca2IH+0ctytrVJZ?=
 =?us-ascii?Q?up3aVVFlv0VNb9umEaM8oeokWE2mTcNPm+UJkhjmo1ALRXDmQhZOsKk/nbjS?=
 =?us-ascii?Q?PBRIGnAjWqeSl8LO/XUp1VVf92J1apT521psBgD7duBZ8CTB27f2zBnzmrVS?=
 =?us-ascii?Q?f7pIBeh2eq98/+T3iq1PngzJfzA4uRsdWEP7080+iCPqZO+A/LF7mE37S76o?=
 =?us-ascii?Q?LV9FufU8PpM8U+FKvwJPzAMbu6ysF4eJfb2zkUo3b6h23A1MjyTOBwfrkp2U?=
 =?us-ascii?Q?o7iGHE0/gRs3BbUSYELT+nP6U3/ZWReXP3H+1BNrSWMV9/bxrSFcy1sNsilb?=
 =?us-ascii?Q?9f33pxZ2rKuThK+Tm/Rl5y6m4ZeKm80kwUDYGJBIVK4lZzsKWWdFw6cWiUA9?=
 =?us-ascii?Q?WFLZ6BGwJXZxbSh7IPqjkbrC3p4lrwnNp4jgdrTAgmFsYqA+wIoRAsGrg/7P?=
 =?us-ascii?Q?dcF0sLCxDIxj1w/brBpPKBHDlPsCNtkwQ8HjijcofjeIM5Jp5Dcp/IHIr1fQ?=
 =?us-ascii?Q?isuSjqNC0XWVzYjxUYuZVzsjWCI+rBDCUtecTn1Fqplr/dkeASZXzQX59wUj?=
 =?us-ascii?Q?wdoxaq6drSnxeO/LNugX/bJFKLb+wBuYKpXDN7UtKH4PRw39/xrsCS9ggIpl?=
 =?us-ascii?Q?+NmnVsCqaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l/hwnXy68XiGZJ3W10lsVQkwpqYhCHgxQVepiA6nzn8SgjySgjGRn3x3quA0QvEgucA/zkFt21EuPXzRsKyuD6/yj/ijeo3DedBSllD0nX4uFzTnpPqejAWBPyPz3e//uEH19RQEOO3rYTzkN0GsA510AVL3va0lEY7umKXBdu+AwMvGEqPka3NGqPTCwGpZ34ZqghSW9wct0N5gTTS/2FUOdjY3i9Q9MsoXLnhy7Zrt+n3MWW9HVh36TOCMl7Fy/u5ZRKax8w72Aq1Kz2ZNL3u9M46gRQBwsfIS4E/ByrGenNmUYJYSBb/DsyepCYu+mm72q/57lnZHaLnlqoDC6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1834c-a965-4495-758f-08df0d710d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:18:51.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tBVoidlb6Spc96QR/YOscilW1xQLRyX/P6MiUg+f5ToptrvwaTbBcjy6nU8eO6QlFADoEDzlUZEKoLW5eZ6CHxgQ0thIAcsJy4zA4sG1Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 net 1/7] i40e: unregister netdev bef=
ore clearing VSI on reinit failure
>
> i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
> state before allocating replacement arrays and queue tracking. If one of
> these early allocations fails, the function jumps directly to err_vsi
> and calls i40e_vsi_clear().
>
> For a registered netdev, this frees the VSI while
> netdev_priv(netdev)->vsi can still point at it, leaving the registered
> netdev with dangling private driver state.
>
> Split the error path so failures after destructive reinit teardown first
> unregister and free the netdev before clearing the VSI.
>
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs f=
or PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
