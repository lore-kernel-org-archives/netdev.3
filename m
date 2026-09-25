Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CC4AD4A8
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346756; cv=fail; b=NKfZYCJYi35oB5t5+Sh7pxpPwyYChF0HJq0qGKww6Th+Vd25hYYO8k7EmUoUyQ4BYtEQub/gOZz63U3jAFkoTYYMHxE7QQsvVR5JaXHVrWf1C71B4JHirlpBPq1N3xfjkETU0ANikdhaNBnU3G4Xn13vL/Jrvl2ZdhX2Yc02iEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346756; c=relaxed/simple;
	bh=bUcs4mE/Y/eQa7dxQZFoby7x6SMJQ9nQaVEKzIFRWOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnYc5Ai0fqQIn0A55UkxlQyg+zdUvgIvMyLRIpeCyzjMNocoZD8C8Wr2TR0Qmk4BCm5Ola2xV69V/ywdRiOAFt/Xgb9r48shltfiJvNH5cJbNOVj2Z2lTWWcJAuwKX1EXgbwkLp5Be9WkspO6RHEXsf8a/pbs5kljTS6D88ATbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJtyr2nl; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJtyr2nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790346748; x=1821882748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bUcs4mE/Y/eQa7dxQZFoby7x6SMJQ9nQaVEKzIFRWOk=;
  b=NJtyr2nlthd+FIQ81ZtIUtGsGrNbtLrUNkcd8xczcm0RA/9cA9mzXp5H
   sKf3HOA1BVTs+gKnK+A0RPNVSeOiwQE6lt5d0snE0LqlrQN0PyXR5Jl3K
   oBCnGX1dgG/dj2o2z/cno3Drd5Jobb1b972eKGWYgb9oO1iiXSlDVVoH/
   qNOI+19gXqEqU2mEkLvdN3hKqhKbId4/vQrpeaAIqHWUdbNyiygFxwYj9
   0R2szrSkk++LO2cgGoqFaoBFEB+fO9XqMaX59srzZvO3/hCC6+MyV5Igy
   0mj2soqyoKDHxZNJS4O5twoJpPhfAIVhO1LHqursxgckpItnjvcxwIpKl
   A==;
X-CSE-ConnectionGUID: fIdn/FjQTNS0vjmIkIObzg==
X-CSE-MsgGUID: TsDBckZrQqG2akOUcCvQ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89997358"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="89997358"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:32:25 -0700
X-CSE-ConnectionGUID: 3/NFnIycSGKhd6bH4RCGMQ==
X-CSE-MsgGUID: ZnHnZJlLRuiaKE2Y8U2kNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="277717235"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:32:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:32:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JliRc+mDffIjOZLGiuf1OlcgRShd/8jj4dMvQv85ED4FUI6BGaU4KZvMcVqPkrtMSKgCS2Cf+Z3JqgPUx051zZQeIzH1w1wRMUTvBUS457DCf4WznP1r8lJFW+91ZqsTH5AZ5sgdUfOv9E/IKFOt+e1uRDtC+rfQVh4WeiuddJLjk1ZkAme8bcZaA/Q1fz4UP20Z1dB0GLug88xZxQ0J2jQhIYyIr7OmZUnFeTulVtksomngNpjul2dt3V7LJOhf/9YYj9M16YvO+tiLuWSZkjMlDgUzNVkXIbOVATqTBbLB2jvmV3ozRg7JV2a7QU03M3iCPtHgijtRCmkSETmZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBTF3rFtqIGXA14omU7+ggpXiw25VDEzcqTYFcD2nfY=;
 b=MaPhnbzl1zwcAkMdDUF+be4R1/a9mXWjY4aP9wzlwunVJC7hhpvz1JMdiqP+qGvRipS9FMr4vwDYArReeH8IWM7UZQhkYxVlYtNm1V5xN242mZZLbZP5W3btv10zwoTHeL9svp+Fn+6FlzxSQMK1BtlAccNASinrH4ZToA3n9pD6dkfzY404Cdk8XMHkeJP2+AevIwIhiGVMKxEjxwk2rpmIQdkCZVjWaD6h4+TCa9lg4djE7fzMskL1UQ8UaepJkcKHtwlr1RpyoFfSAsau8xHjgWe5VhA/qn6FHJXG672LKiW1UnvLYrgrmn7UjvD7pM4OxsHEK8/KqVFI77gp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Fri, 25 Sep
 2026 14:32:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:32:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
	<edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
Thread-Topic: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
Thread-Index: AQHdTPGUO4ulikGpbEGSUebSlltLr7bfW02g
Date: Fri, 25 Sep 2026 14:32:13 +0000
Message-ID: <IA3PR11MB8986CA5932FC8AE0F35B52C5E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6238:EE_
x-ms-office365-filtering-correlation-id: 1093e492-1d51-4049-47ae-08df1b11caa6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|6133799003|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0rQ4sjbeg247Sp2/7OF1J/pnckH+rtVLob0BGe/+QjTXjyErFk4rHyRaSmuwOPhdw2DSDf3jLpZ9KxsjXtxTYDUDohgIg1f958UxxrJg0pgytkA4iZuJxeeVWOmJ5/0wSfRzqBVfmZ2R2dgCaE1q1nvsLDcktbkmjdAccstw+L1Cu739Sluis2CoRAH5fctumyexkQzusEedppi9zCR5kqEL5gnOXOtcn+RCHI4Lr27mGCqvWh1/wisNoDsdsEUhYoNd3kBznnY/CCcULp9iRgGp3NEucNTKV19UcShgsECDDaR9HIm4x46k5x5ed7jbLNez4ehDAkqFh4/h0ciREXJzXkpXC2e47Q3IecjKvBeO4+epymF7D8Qf4ywb1My6yZaz5b0v8EyMCQ6Nc5vIYI1UPzXV8Ur+sDBNg1BlDo4/BVVIKYBICrIqKUzBPg/pINiqe5eM+gq1IKS7wouuHJsWXQDiNLzBUxvw0gSpGWtfUaKLOIxoR3GDfmUt8mRsxIX9BY9MSKn3jh3jTMnO+JQvzOHfoMcACE1FsujYEU4hjfID9ZK91IBRR0NUVjjCAmXIHifuLELtsXibkPTfYWFKhvxhfie4YTfl8eaL+GW9trE6ZP9AUJFnuqZ8ik/kg+LHhxkaoKEIREM6bvYFoTsSp7dJCh1wTPsf2Hge+0uwOn1oM0q+Gh9YxaqtDgQbPN4b2zV6PJMPo42SgajiU0tUPFBx4NiaRad4SHl6AwA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9HgpHYhOaXhtWyEoKSCBlZjnIcGfFgUQ2cAjctVeuhoaIZCK42J5rXuYpCyI?=
 =?us-ascii?Q?BcTts19n/RhjjDpMcGpFngrwtdwdLI9IVSA4ZPj3pbSDoeQOL1gNIIi5I7Fl?=
 =?us-ascii?Q?DbSl4p3+jB5YfeIpm/TCICOX39uYCVY1+X+a+O1FgQ3J3MYjbIon6u8HHKHH?=
 =?us-ascii?Q?6dGdbe0u3zNn3R6IkX4FfNsqexfAimEb4TzIZou5ix4zYG7DIxNXxig+VCxj?=
 =?us-ascii?Q?A2ZJh1z56A9nlwkkkBVXiP5BwVtPJdTn/Doifrx5GggfBkKGfcowRtKaa/bl?=
 =?us-ascii?Q?n6LlJKuChTs9WClEx8QRrhb3BgN9HCpl6tp9lO798VQTTMkjllTl4uRElAYd?=
 =?us-ascii?Q?Ci13jNsmg248t3flS7CvO/qgifdjlC3EzQT8xtOWqaEmeZ47GA0eysi8TYz1?=
 =?us-ascii?Q?cUf9Ms0br1aw0CCKwXllcYQ7hwwigpVNdtflVrOTlylo56Thjwoi5QL4ycQO?=
 =?us-ascii?Q?ZJjWMt1ffIqanup/aJYv9ynrktDfb/AgjO8EcB2L/2oouAMC3HYFUIKBBtSw?=
 =?us-ascii?Q?4IQCJPIE75iP3TefNgTAs1J1A239I0sbaYozw3tQr3apJuvaQihban8F+59S?=
 =?us-ascii?Q?Dbwi1XwHegEu1bISQKAi/wmOI+o3WPoJWA7h4kna2/2Ib6C7DquNLYncPtmz?=
 =?us-ascii?Q?++49AQz5LPICmwiwzNP5F+WjPLaWurL8U3kcWXWj/9dmQ+DCf5EYle+J6d7X?=
 =?us-ascii?Q?BvenFDCOA/PN+6JXSi3GYjJt6NlwVZ6NQvaJJ/kS0PTlxIqVwEf8QgXqKDPV?=
 =?us-ascii?Q?rE2bhnZkcM90l1lY8y9xI/8jud1o8TAy/uA3e6hKIsW7DurK4iOup7x3zpjw?=
 =?us-ascii?Q?xPRpCEzVfZ8GStuMJ//msBMqORLa+aVYGV7t4M6mAuZn0xcOzHPlU6bk50BL?=
 =?us-ascii?Q?pVZYLy5wSYvkZRNwMVZ1vZ+H6IkC4GEwXuGaaupx0EOj/8BW9jxMcfYtmM8Q?=
 =?us-ascii?Q?7ZweLrrvPiKrXI8baep+KINmTj+GkCq5w4hwOOpkZs4oCVo5eZV924aEOIld?=
 =?us-ascii?Q?Eqrj1MSlMEJTbC8Pc/2Bw+tLJTJ4xEHqNnXf/SObuawz2c417UNDtPiGNCpJ?=
 =?us-ascii?Q?9PZQ+Adl0Zsn68KSEYJCqOyrSr6o+OfZjiFjIBjYuFaFCTXvZYjKIUs/hfPh?=
 =?us-ascii?Q?Npj8cKZGpeq6pJorY/8IHw9rUYtNz5WlhM/ZXu6Zmo/bhKO75VezUmPxcO+Z?=
 =?us-ascii?Q?OpphKG9U1gpX8FvxcJ7Ae8ND5THgkUKycFSO4onUNaOoXR9pF4L7QlP/vkzZ?=
 =?us-ascii?Q?B62hd2Q/CzqyjmB+Bi8GNrc2DnRQ+imv8fXjsenSwsH4EvcTjBcBd17xgbKc?=
 =?us-ascii?Q?FB+aPfBxuB+z4kHAOyhAdqea993JjnK45UGjGozksfalBhjyF4kDn/rGK83j?=
 =?us-ascii?Q?9T6xuft7+Qp+AtOB1jfp9HCPeXPdWFe0lVFQjoKTESSipioLTDsWVMoTXoc+?=
 =?us-ascii?Q?vpySCTZn0wjJVJ8IMIM1B888LrstG1vH++vH7w7v7+FVPpRvvUE9sd0wjWcm?=
 =?us-ascii?Q?ma05ThqmXkzg4mL8Wm9CN28vU6rJWvBYKNAyXKSG20V0dC8XVpDvtPty5vF1?=
 =?us-ascii?Q?eNMgLuU6TLYU5EsiZ2qhDnJJRMgZ7Fu1WqLFzV0fVaNwdyOBB7cEgDM9UWrx?=
 =?us-ascii?Q?BMpH72op4OAFoeRl+gLRm5KPbA70BCUm5SdKWbz9tW/IHTXMSAI35TLM+4bt?=
 =?us-ascii?Q?SQWVrtcmL3miBwbRN9nhZ5zAOOzriZXi9OqCOPTET5HdG8FXd/xtPh4UoPVB?=
 =?us-ascii?Q?OllaRBIDew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NF9InN2ewjU0Qb/l1IswfoVS0XEWO5qv4hLHlMtnHGj63sUDmdd36nHHU3mgCeKGa9WQVkIJLvdIUuboIoN/tAHZnOnnvlIMIb0ZFiFUKkAeegc5cPkabSlJqWNU5CPWMkBy03DvIQQ9YIE3Lt8tUQ0A0JVqS97ywl7MFu0tbwUUfFVhNXOIKw7Ruaw366rZUNMRPaM3hsg+VrYU7CUzBgOc9uAp3piI8FEiTPnh6eJhNgF9KkdrT4Bp3f1BMvri00Q8RUzfObYjDOND8UF4p8/pwjR7QmoUzxVZKndkuT50MaBTAGx3D8kuPEH5luyFQirhGCnLE/fqhazXtZ/KmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1093e492-1d51-4049-47ae-08df1b11caa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:32:13.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t4eoxovjrBW3tT0pbFtWUjTlZojGFlUA0Xk94C5ytni0EkfKM6Yx6eYagB2smsmVek5tb+wQsjGIwqMrH5szXgjzqpwktRkACF63F8DuE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
> reallocating them in place
>=20
> ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
> with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
> not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
> after a rebuild the arrays could end up shorter than vsi->alloc_txq /
> vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
> end.
>=20
> The VF case shows the divergence. ice_sriov_set_msix_vec_count()
> writes
> vsi->req_txq and then calls ice_vsi_rebuild(), so the old resizer
> sized
> from req_txq, while ice_vsi_get_num_qs() reads vf->num_req_qs ?:
> vf->num_vf_qs and ignores req_txq entirely. Once a guest has raised
> vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES the two disagree and
> the arrays come out shorter than the alloc_txq/alloc_rxq the rebuild
> installs. The reset that such a request triggers is a different path,
> ice_vf_reconfig_vsi(), which does not use this resizer at all; that
> one is handled by the next patch.
>=20
> Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
> struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
> queues ice_vsi_decfg() is about to return to the PF pool, which is
> exactly what ice_vsi_set_num_qs() will compute once they are back
> there, barring a concurrent change of the PF pool; the next patch
> stops relying on that. Copy the surviving entry pointers over and
> install the new structure, all before ice_vsi_decfg() runs. The
> entries that did not fit are freed by
> ice_vsi_free_unused_stat_arrays(); the old container itself then goes
> through __ice_vsi_free_stats() with @free_entries set to false, since
> the entries it still points at now belong to the new structure.
>=20
> Allocating up front also means a failure no longer leaves a half-
> updated ice_vsi_stats behind, with the Tx array already swapped and
> its surplus Tx entries already freed, but the Rx allocation failed.
>=20
> Put the allocate-install-free-surplus sequence in
> ice_vsi_install_stat_arrays(), next to ice_vsi_new_stat_arrays(), so
> that only the sizing decision is left in the resizer.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> this removes some tech debt, but it is not independently backportable,
> as it sits on three preceding refactors; the NULL dereference and the
> sizing mismatch are fixed by their own patches, which carry Fixes:
> tags
>=20
> v5:
>  - drop the false "requesting fewer queues than the PF pool can hand
>    out" reproducer, use the VF one that the code can exhibit
> (Clashiko)
>  - describe the real failure-path benefit, the old code already
> returned
>    before ice_vsi_decfg() with the VSI fully configured (Clashiko)
>  - split the ICE_VSI_CHNL guard into its own patch with a Fixes: tag
>    (Clashiko)
>  - factor out ice_vsi_install_stat_arrays(), reused by the new sizing
>    patch (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 144 ++++++++++++++--------
> -
>  1 file changed, 88 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 134984077d5d..448d3c7780ad 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -557,6 +557,80 @@ static struct ice_vsi_stats
> *ice_vsi_new_stat_arrays(int txq, int rxq)
>  	return vsi_stat;
>  }
>=20

...

>  	if (ret)
>  		goto unlock;
>=20
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
