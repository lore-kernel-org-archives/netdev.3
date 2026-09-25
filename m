Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BF12B143
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346703; cv=fail; b=hHXRkFl8+FMkXj1U15/BuoQ42PobvKHcCTc3Plrh+C7Z8MZOGG7bqc/OmOZ3ctdLLvWlIINIzPltd/LRPV8eLpHnaG75sEuYOxi9dr64AcRcLRcthKqMKhkF3dvexXH/Htfp77jW70wO3YZsu8FUH85vdNrqCE07riwM779CO0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346703; c=relaxed/simple;
	bh=MK13TqIPoAkZJclfeBusX0KcJCW9sGSUckD3DZWQ+LA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2F4fQtPWWJg/Dzi3qjlMUgODu2L0h7dvtDH+sgqKTsEkn94gIBdQrFtic8e3rycdsG5+ZGkatr+X8vr/vZoEa8MyrFo2yLPDFcj2tw4TrySa5l63o/LKy2l1jWSzbOyhiliuhxVALESx8vfo7s9LhQRlTj4sAwBBAAxKlze+n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnl4XjVU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnl4XjVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790346701; x=1821882701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MK13TqIPoAkZJclfeBusX0KcJCW9sGSUckD3DZWQ+LA=;
  b=dnl4XjVULGDD1YW17A+NkzvALy+mAeuhKU79Op4DC+Cb5EE9yQMPQlQA
   ZZADeJgp8y6x0pu1jWgUzStCzzoj87aJ0tXspbnXxRbHsHeSeH2+XpF/r
   /puaOdOgFo4NGHZM69grOnLqOwQogy258J0uAJdmLlarhlSTbDKcVpEqN
   zW8dWBsLS2Rte0KbHp6yTybw3YGf4kVMk5adgIk/Ph7y9BIZFdzMnjGaW
   ZLK3LJSeheNoK9GkXNIXMK8VFs3W27sgDFm7fe0paOjDQE1UDHLb22v18
   1QCVRvfsT/K69dH9DmsnwWh3P9/wPexB3OTPITLJ1GXT9wnf602UaU9Lc
   Q==;
X-CSE-ConnectionGUID: jSnezDlRSCKnNAVqDA6Nmg==
X-CSE-MsgGUID: oPdpK/qIQgyH7a8LocVClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90091125"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90091125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:31:38 -0700
X-CSE-ConnectionGUID: Q9QW38JTSQK3dF1+wMDVAw==
X-CSE-MsgGUID: 929+enCaQpukFDZBhID8oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="279052635"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:31:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:31:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:31:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4WaEce9pg49/ltWgXclLeHsaeYGKlC8Q/eOOyHVu5S74DeiWhbqVl2r2qCr1vZkV7NVGMBmHmPVC7tXkvpALsYyjm7S8Jswziqi51R+EwJaZ3BRUfFfVNnMvoZce7DuqneLokqNcj6jzAGwJd0rGCx5BQH0brsjttvEjpTXioNoKPwymmEb0EaclgAh4szpbOJMTM5p09xoED4Tac1fxq7mFw+B0uhzvgB5yfU6acCDExb+0cno3L7Y1mCqaIOY8CyYQssxlfSJOOECDFHCTbTTBGIINnEoQXvI2817jMEh2M0+1/oFWM0gfwS9/J0ANRiAFTO/o3lcRPV8CnSyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jAPfhV4MD+XElmJtEVYRauCWJv0x1By3JwAoudSwWE=;
 b=APYIV5eblnup8P7haiD8DQVqdD/uGIqqN5kzbNr5oOzomELJu942UJKdmbY5tvo1OhRIAA21O3IFXhFjddRCJfJKLOOk84rXKn54ePy9DMu+LUkFAiS3uC3GOb51/w/bgavZ/dF11sw/SDumlvK4v1amU8TSxvnQh93fblpMaQP3N8YOtIYfOAcjOrIfqZiveB7/QlGgV0SgXBktkKL4SYaac+06fux3vGbGTT8idp8WRkT9dd8g4Z4vifEqT3n6zzxdSuQ8l4z1yqod/ThJpM2pIwY1MPqMg7fAu7ICUauWCY5HMcgSrr6xcYRRqNAWHgZOUliAVW3yCYorEQOlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:31:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:31:33 +0000
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
Subject: RE: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Thread-Topic: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Thread-Index: AQHdTPGTurIYsE9W5UyANBBfRCGCbrbfWxZQ
Date: Fri, 25 Sep 2026 14:31:32 +0000
Message-ID: <IA3PR11MB8986B2B607DDD392CB1C2D6DE5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9572:EE_
x-ms-office365-filtering-correlation-id: 98218fee-2b3c-437c-aa6e-08df1b11b250
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: oa9P+2PLrVgWRTRlpGep0gDVvu5rqn0QnsuyeROt7nV1aateOEp7kqn9vRc94pwqKt/xFisjAJEQOH+Nf9P7bvSLpZBoMroBc3bzkMKuSYG+Sxz6+JvIGwDAvalayGZr7By8LzJowGt1DpzhmB9Mos49DG/G+C/151rE8iRrs7SWjDMZtKGhTlEB11rLRB1ZfNVFDx++A4R98A9KKOuXY94uHpj3MMmjoeYZaS3ArsmXbabTgAf+J5yX6cSSrrx+lzkpaE8+laY92G/Gu8VLjAsaPAzqqv+0dcjL9pvGAHT+8rgbdYWu9A6qS4f6g3cRVYuHWP+AEIdSlCcLpyxgwY75IgICCTAsE2FtA5Omsw7x3kU8eQFDAxQyFnV65azIn0+AalnXqxHPzSarodIfk7TuJMnB+N7v1zUCr8vhY5ag2cblPQHCakzri7j9+Xnhbla/oSJIc7lU7Gc63XdvLD0KtGS0geiR1BbPR89D8zLdt9YqHeoyonWKqISC8csJ16uc99HEg2XfZxkfMg4n/fC2h7VtoZ2Jwc3ZfF4JgpWmZQinMMgQDyU8T7uC0SNTSE6epR+CgKp1UdbU7zTmkPNwu9Chi8dTJuajv0ZeVmOnJvxzCkt8Z4ZRDdnvCqyiTrlFheTiVlp1baCycz6A0eP9NwC9RPmIgtjliTXEY39exE9d2jPdrLJdVKXM8X8ZLzSmXvxZGIVEi5D5p7/UTHnbTXqpB8NboH5upZL7TR4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWj2lusSYYCP+fxUOApudDzrj9WdEBjgkQgwKs2wKizcmFuxMoESn+w2uqfv?=
 =?us-ascii?Q?ShZQ2QZalhzXGDorevmrZBruSCHX6d+7pcbqpioVyeVJJwIElMH0+HIaOqQt?=
 =?us-ascii?Q?GIWSiIk1yg8+R1d1o6Lrjo/+re3DrHDPXUeHppPmWbOWM1vvfyF690qaPEZU?=
 =?us-ascii?Q?y+hlLKErEEX8tQ1JkHT0N371t34KwUX6w0cIOOTPsb7uLFL0ue4/etIPnfef?=
 =?us-ascii?Q?2V69tjrX0koEpM19dNtauDDI6Utvl4ODe+XJIhJbKTICCPhqKii7oUey76yf?=
 =?us-ascii?Q?VnpQcorv/dvAiCS7eUM7MsMcX7hou19h8rM+zcy7Zp+RtbGyNvsXuE/67s50?=
 =?us-ascii?Q?lC4LUbDwrTx5pUFxVuou6f9PBq5cpzim3kspAymL+RbFi+k/35hDBn8HFxT5?=
 =?us-ascii?Q?19LKgNTibtg3vZB58c6CaTnWp2Yu0fyYLShibgkGhOHbVk7K/V8HBZeoNq2j?=
 =?us-ascii?Q?DsPhtOQXEFnuBjCdfB+4Vtv734XQVHV+ucZah6NY70iZNs9JV0OIgvAbMXb+?=
 =?us-ascii?Q?fAfQI3ldVELZGdO6KiB4lB/X0wSPj2En/yo8+zRpiIe7cLPQBxluHkA8cy7n?=
 =?us-ascii?Q?9m2WvtCWuhALe3RjX5cJ9tbBJyLI8rq209N3kpOQVIVTcWaGJZ4E26djWieV?=
 =?us-ascii?Q?Xy2ZNwptYR7Yki64EWJLkn+8w61T4xWluEbxmwIEkpXWi9YXztR4pOZrh50Q?=
 =?us-ascii?Q?hV4FvaFx/C2qDDP0/4xPpLHSkZUMu36NpfyihgPllwTJvfR/BWKJ4aBJ+HoA?=
 =?us-ascii?Q?fEX42wmlqaSQC0h4ZSt2lfRwKrRwVShQ+3OUVZPDkuaU8L5vWJSZP3guW1gZ?=
 =?us-ascii?Q?Lwbc1VIVJqGPaSPGo1pg9PHsSamVxINZs5/0b5FMHN+b1xBpKb9WXuXmXqMz?=
 =?us-ascii?Q?QuIvSiEaIRRq5Hg11VAmTypnGvna/10TUbXYhclGE+zC8ht64vk9Y3upPXLH?=
 =?us-ascii?Q?hnuFqd6ygukOWmEA4+r78QD7Q5/CD0xCgpRnHdnC0VOYONYSOqNM+onZQsLX?=
 =?us-ascii?Q?nwVmK9Tk2yjJ+L3BMKidp2q7ORPaFwurdfi0zYh8wZ6CgL/yJTLDID08swyY?=
 =?us-ascii?Q?bvTKdx/gbBpOBtg3ecJFIfrvSpClp6tVdTu6UUvHLBLV9z0fV9Wt9gJ0+wr0?=
 =?us-ascii?Q?RvYuWi7bP7nUS1un4TUcgtQCz2m41zVf7Q8lQWmIQ5n/h2R6JTiWJiPqGG33?=
 =?us-ascii?Q?qlaLZfRqHsetX7wYex0or/UQRGXW0sZMtnyZzmUA8ZBtv/YF1/rr0oFkpYSB?=
 =?us-ascii?Q?fUHLjDBKLKs45zq1mPhqkoOfaUy8TTsrrqQ05hI3zVeiQc8oOg8i+wjzSlQl?=
 =?us-ascii?Q?vuoB67Oqw2LDaMA0voShGyq/KrqsCgvChvk3iWEDKnYcj2Ie5BmO+dlnGnxm?=
 =?us-ascii?Q?xty5MC1nc2efx0u+ijvpgVL/b6gQObuHO9HfJavsI1CFl3VFSP/EKzhtVXg7?=
 =?us-ascii?Q?0G8lefRTH1oK/y+LUE1MlpXJx7itmEN7daElwfNLGA4bN/LP337uX5RkEpfI?=
 =?us-ascii?Q?b0/QCtboiZ40AFbMqFUNqP6jVos3aEMHQGXXbS3ZMyaa1NMvPnMBAmTzh/lx?=
 =?us-ascii?Q?Jnd/lg1D2GZBu/rEYOj5fadiw6o2xGXTIcgqSI6L2uK0aze6SDooh4VAY6Fg?=
 =?us-ascii?Q?7ZgkCxF+XrNWD26xYo5KusfeJ8KyasPWAseNm84Te1D5F6pBml5QG/HwJ0Ej?=
 =?us-ascii?Q?tvCjR181kdyek3UOLnE33hR9t+u607hl4rljdfOLfZStuJ4wgx9p8MAn8xZ1?=
 =?us-ascii?Q?K3w0xabBwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2sMzWqD5IhKLciSHBYvqCf2z/hxD/a4v8c+DH+1XlI7b5bAsfApRSlqbUIyEjvugmlhlejJsgGf4Wifpi++Kf3gtxu3S+Sdn1mwa/fkBWcb1nq3nQ4H1cdewllrbVLKmrVPvQlVLlqjBASn3XNX2dLk/bFDUGDwzGS3AphO7W4leP1MiHRruBZiZus13YsW2aUYoQjxW/RAflyvPLN0iqzeFYfFJXRDFfH/glfDMExVi7Jk3xFnP1N3nMb84+nq/8BF+KJMr5L7ZdljwyrRBmksCEZ/WOoEkbY76eWPgbJ8qHpHwXrTVwutJEYU11J8wOsUMB6fphzD9s4XQgBMjGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98218fee-2b3c-437c-aa6e-08df1b11b250
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:31:32.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dr5dsZ9LTozUNi16s6+AAJDFTlDk9fVP1hqYwGf/Y2/aFtFyaQ7zTLwEiXKf8V7DFeMZF4kjF+yvav4xYbwCEWoNQy7wmt6ACgae3W4e2pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
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
> Subject: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
>=20
> ice_vsi_set_num_qs() mixed two things: deciding how many queues a VSI
> gets, and applying all the side effects of that decision. Split the
> decision out into ice_vsi_get_num_qs(), returning both counts at once.
>=20
> To make that possible, group alloc_txq and alloc_rxq in struct ice_vsi
> with struct_group_tagged(), which gives the return type without adding
> any new storage. Field order changes slightly, num_txq now follows
> alloc_rxq, but nothing depends on it.
>=20
> ice_vsi_get_num_qs() takes @held_txq and @held_rxq from the start,
> even though the only caller so far passes zero for both. They let a
> caller ask what the counts would be once the queues the VSI currently
> owns are back in the PF pool. A later commit adds the caller that
> needs this: the rebuild path has to size its ring stats arrays before
> ice_vsi_decfg() releases the queues, yet the arrays must match what
> ice_vsi_set_num_qs() computes afterwards.
>=20
> While reshaping the whole body, drop the kernel-doc line promising a
> return value; ice_vsi_set_num_qs() returns void.
>=20
> No functional change intended.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5:
>  - drop the stale "Return 0 on success and a negative value on error"
>    from the kernel-doc of the void ice_vsi_set_num_qs() (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  6 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c | 88 ++++++++++++++---------
> -
>  2 files changed, 55 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index fadfe94bf1c8..f1ba86d066be 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -403,9 +403,11 @@ struct ice_vsi {
>  	u8 rx_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
>  	u16 *txq_map;			 /* index in pf->avail_txqs */
>  	u16 *rxq_map;			 /* index in pf->avail_rxqs */

...

>  		break;
>  	}
>=20
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

