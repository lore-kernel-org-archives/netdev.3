Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AA3E3DA8;
	Wed, 16 Sep 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538664; cv=fail; b=W8UNWbEopZwwEiwKlQ48BbOtlQV7yHbTUZH5ukYwzqiIm+OUmYdzQAgh0D5UV/9LFOUmVU+P4/si+AxNXhvRZBdX7m/IxpW/mH/XIzylHVET1oEy6SFlaBnc7q8uboMcGK8jxkbE2fCHmZcyYUgfyBYeRZ//eaLUShs+P3p7Syg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538664; c=relaxed/simple;
	bh=7vCqa5nHaa+GjdQ4rUd+XlJXIE7mOTGYLecHUafhgkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NER/dY4iNYuk17QNlJM5204ijCIAVObK+Qs0wcvUuCWkxHqGKLLDDD6IG/23PZt80/LE1or0zgui1m4cix/BxeagjW2F6XVLefSltToPi626yxBkSZq+40uwnBl02gLuwGUSTvBDk0BbZiXoiTtpVzlESXj5KjOfv6huVujE/nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsQmbxkb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsQmbxkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789538663; x=1821074663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7vCqa5nHaa+GjdQ4rUd+XlJXIE7mOTGYLecHUafhgkI=;
  b=OsQmbxkbjzu/fIMZ9hjJ/WkIkj1GkdXndyFkru7Agu2oyvvNIBBpFXJL
   6WsWaa0aFsCAh7gGhgeGlWqqlGuRDJlihb+VeCdXbMIqdGHYhVpx//1tq
   MQam0ox7qbr/5IjpyZQu7YBHvdx5RYLN6GkbxhvmfXvPzF4w5JQzo8xyV
   V8iEwvYZdAtr50MzVHvyt/n7GOejPCyHLyLjJPct0vxEOGFkbAtk55aFH
   8hbu8h1/LW8P7c5dmHyElJ94bToxMDHWgC8ZUjpp0BIYzL/iRioKGOFeM
   lmNsxbV+OtoHeOq/BfrLGwazjJxDBkSF6B9UWSGV2akn/N2+/IX05iHpO
   A==;
X-CSE-ConnectionGUID: hREopjwpQvyXRHA6z3GqEw==
X-CSE-MsgGUID: RlKOiqM1RG23fimCoemvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100233492"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100233492"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:04:22 -0700
X-CSE-ConnectionGUID: d1L4kxLZRa6dFIGCRdvJMA==
X-CSE-MsgGUID: yYAdE6BcSfK1f+1j3q3QVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273204288"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:04:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:04:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:04:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtXHz/HYzaJbwyC5YNgMnUBMaT890KfTE1f74UoWatLzk0SxoAeYXfn9YAuw35QM9NAFw0111a/F4eoyjnI+FpsBAeaiiWw6KFGmv14q/RbQml3BSlp84q1r4Fe4q2nk5ZlHeJeQVW03UGLmlRKuuxGgPmjhUnCA0peiNBP/ckL88PpzxWJcD29mbzYat/w1/9e+AMKSSDpeeHE4/wsmSaqiLDt1wREw1sCREe/linXD/tHuCJXtLFZNRUxt67f4mQDFC0jIGPXLv+YxU3Z9RnUThEZrOnHXFk0mzV1tpfnEZfDbxGbLWIJBkYJVvQg/cvjGVdkdni3kDYCrVu83xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmPcP9TiEvZIaVyd10Sbnz3P5xZ8222/JZ9O9Rc20I=;
 b=PRxSMf8a0ao0MLfm+M9nk9K6Ml3eSoqcdMiHm7lHyaWpvp+xcEJ8+RG6eKUW0sMpzqaudhzVsAoGO+hvGpKO64R38Iu+i+6eBbMxbOugQ9HqlF3ni2oNM5pudxBfGWCuj16m/mZ10WYAU+L7IcePgzGIBN+L9m+/klsvNR21VZiLYK+k/WtrvTuITNQsNNc7jdQsilOWxWmSZcFO2c6bSXurBIk5csT4hYxMOgyMLTkROpR6RzqFqj4HM2HoAGqQ3eXBfqHKwrG2Krfv7dmveR7WtKrr38iMcwMOCHh473QVizG1sqZ+hVR7npdFlmBMJQscwVqp+oeE85gumk+3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:04:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:04:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Index: AQHdRQDP5WCebrtjFUG7Rd19ntyvtrbQuFtw
Date: Wed, 16 Sep 2026 06:04:17 +0000
Message-ID: <IA3PR11MB89869FA8496B0FAAC52BD47BE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915105447.574951-1-xiaolinkui@126.com>
In-Reply-To: <20260915105447.574951-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 0b1d563a-bff3-49d3-00aa-08df13b857f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|921020|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 5GtSp3HcqRwV5MRxJdPpG6S/TTGJ+CgWgWWzS++8kyCuX+0x9tsivph+Qjt4U8hNFE2Hy0etG0HHjlh1saIgGh9PFC0ZpkPaxQUNtbY8s1A1UfgRuLYVHiaiFDijCBH4CmxWOJeL+leVTCoNP2aTIwk7Zv8N9qi+XHqdD2phtxJ6hvPh48PO9QbHj0L8Ybhz5566e3m6boFNGJN6FRVjSXaZkNooLeo+PtydFtiOsLCdl3V0F939BJLr84c/dfKXKUm6Hl1SIefFmIsYx+pHrI5OSCm4eSB5+BTjF2Pg5aWNs9HzZsVinoU1vjn3n5dSyaZfqVqvqk6lw4iJujB8ixSikRl3slSaXr4she+jWSkiQZMHScFYvI9lfsujEz9gLVyE8l+CMAkoECD8KpqbLu35x+N7sOMdObo6pc3uoqx8XYlZ1lDW3fKgfXBGkckMwQBnn+zjQLElQqsnmtNtkiyGHY/fxkGVUCOZ9Zz2IV+afnTYsCTblKCuzgXten9tgfKhITQuQ4oMy9ctMwjms54BJIHzUtrsnO5rAXh68H19sq90ZG8SwzcHwqOChcifRuhzXsYce8UoxNddBiL/m0uo82ZxfIXBgZBkbM7ni8kiN7pue1GDXFLEb+291d2PNUspKduhbXNAaDoR8OhC4nl38LmGxHA9v+rvOIUG+7Ta/ErH3Aa9vxo0jzTgX0z064Rhm/aQt1SnZU+gc9iNXMXI+wNVgqWBv32/LlTUdII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QbhFyM+WvLjdHRgEBXCPywUheuq5XXXd56fVUCRUHBBf6r8+HPWPZk9xdOl0?=
 =?us-ascii?Q?EWeoObLDswFVg3LzHZBqGLf/1AeX+3MMDqeO6g/bEzF0S+mRDsRZzj2v303L?=
 =?us-ascii?Q?Fu5bH1VJ0DNrfLeJsoytHQ8tUOl4aEM/uA1aNV280j6hwE6CMpTCDrbgQOkb?=
 =?us-ascii?Q?z/rIIGhASLB1AphL1wcqC1axOqDJUC+Akgm+hrRKa3WWVPYaGQoGyZRXbhUg?=
 =?us-ascii?Q?R1OSmdbZ3RWvaJoIJClYf7TboDTDlHj4TzFxuqPN3j6ccDzqJP3lBsfwAV48?=
 =?us-ascii?Q?CiZDgLIlygq44ulTxAyH5LmzlhS/UHy5U7fzxMPz/Z0kVUOP0801nvVjEpKC?=
 =?us-ascii?Q?ARk+e8Hc2qSnCy70jCnkZ1Sd6PtdtMx7JGaf37oRI2nX6Xe69WLSNqJVuRwj?=
 =?us-ascii?Q?/aOeGubRJ/xQDg2KKZFYOgYLXnCn/VuI3gDoapDUPv/Hqncf6PVMaX76GMbK?=
 =?us-ascii?Q?uGFc7uOhTeZD0rnngN7J2fVyOM+ybJsh0yZgGPL9aHKue+TULG9z35ZheVei?=
 =?us-ascii?Q?AjP4yTwzwHKgHyG/0EFf2yKvbxe3jttIYvMnJVNiK9Hh1m0N/+ZY+KRkVjcX?=
 =?us-ascii?Q?C96+zk+2ybZQUegPlcj+w/RBdATN2HGkOZpnWrX6/wmsxhdWDfeWBC+cJ0rz?=
 =?us-ascii?Q?Qrrc2TtMBaxJugnWSsiUgnjf4/OdMo+S78CXZKBCT/KDPf8kkBzsYC+BT+uB?=
 =?us-ascii?Q?6ICyuyK8pwrPBtI67d2X0JJo8hT5+KxYFKLAWYGQ9DAgrvB/YwnfI/xZZ5QP?=
 =?us-ascii?Q?Auv4pQoQ33wAW3jszd+3txn6fhofftdEEQ1PIzjV5LPlTIQFlRLceP8qaCfj?=
 =?us-ascii?Q?pL+Y1MKzpgMgq6FSgA5psQau73uRyyf0/+11k+aD0jCJ077HUNh9X0Pmks6B?=
 =?us-ascii?Q?5h/Zf2ianOpC/ygdVo3l3XcyVd9uHYE0b394nK5snNxjIqKWq4i7T7N0jGAd?=
 =?us-ascii?Q?tGfEOcrPMzrvFZWDbVJajY0hE8UyMpA9JmQxDKj+zGDSsivSBhR8mFm5Drvy?=
 =?us-ascii?Q?JLygPQli1UH09Isx2gbKiLc9EbSDFtN9jNUgKe1FAahEF7ubwKI+NJJRW854?=
 =?us-ascii?Q?OWqCrRxjD0C027bKRoc/uzdFx+74tJ6/WV9A9PWCWjF5U2DbiX0vAeyuWgUg?=
 =?us-ascii?Q?mK0CXngPTE5Wn+XFU53T/f03/4sVw7FkQeH4LAheK5SbP7mBVMUYCDbYwAs3?=
 =?us-ascii?Q?/RrO2Ud4WVMru2PfaGYETB3lr5ux4uO2va3ubmI1046raAraTxZYLjnsV+wJ?=
 =?us-ascii?Q?8GWfQVdSkBDA/XqhJKYUmLqtTRPARLNZiOIL7SUmaSE66oO2ZadLs/Ud3lTJ?=
 =?us-ascii?Q?HxXQ8+ytDo+p/x05v0EpfzzxzC+pg29hfszy7hoSw70b8LHD3+TVsHr58xr0?=
 =?us-ascii?Q?etCsFgo7880/zh8CDDTXJCbjzNAdvrt6qI+8mB8CiADEyE8g1V/neSkoZkq5?=
 =?us-ascii?Q?pKwGRSyjkOXseQM0TCKNFngB3amBXsk7V73cqa8Wf6tVNBX6i6diQ1EFmdEr?=
 =?us-ascii?Q?l4mX+hfa/kBUcLb4VczrW6R8KX7kFl8S0v0qVuevWkie0tf6vw4k8zc5eBvp?=
 =?us-ascii?Q?c8knIoyk9lad1pEqo9bz9jp12E3L/IrPrpcE6ELi9by4tEM+fraj7KQuXZXd?=
 =?us-ascii?Q?HUM710F8lto1O/lDSNhEx2HZp8TtxvYPCsqOOs9I9t91famfq4Hcw6YHDIl1?=
 =?us-ascii?Q?dxuFbvayttEgfBXSie9H/gRfcqYfQgPs5DE+wq5WzqiPA/1vWVHExnlMwsEK?=
 =?us-ascii?Q?AKyvxpMLmaXUGl9RPLAE1iw9VYsTHw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D/bd2w0qe6fR3lKEqQXhgQLyzZOFYYXIv+M/ZuRYIEut2XgckqiZs13kw6CC3MPGDkluuTIE4cwhKHNsMkPipdN/MelObAij0YZBd3aH0Oo6f3TSjMwZ05voqz3huEvU3ba+M5CDOncAdUAChlK1hEpmEVmvdl/s3R++ExL8Bj2JT694P6YMVqS1LI1lHz3VjdD43oXOjpXcNHePrg5iVJWdEaOL4oukpyo1JvA4wf+8GpQFCGDkM9d+iuSWBrVT6nWUZVQxs9FotKLGgXVA4M91At/o+LocYc+fd/lh1/TveC6CjFq0klDFYvXAc5dir88RnEr019rMfyEgKbFWVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d563a-bff3-49d3-00aa-08df13b857f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:04:18.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS0PF1Al6nB8P+UR2EvXULMUXdMceporDXKqp+kWmK/HBCwXyfX0VxaK4Y+lFewGyqAtW23yDMhU+sR/AsEIoUhWp2zU/zoeHGDyvdkZgDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Tuesday, September 15, 2026 12:55 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference
> in i40e_lan_del_device()
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> i40e_lan_del_device() dereferences pf->cinst unconditionally. pf-
> >cinst is only assigned by i40e_client_add_instance(), which resets it
> to NULL whenever the i40e_client_instance allocation,
> i40e_client_get_params() or i40e_register_auxiliary_dev() fails, and
> it returns void so
> i40e_lan_add_device() cannot report any of that to its caller.
>=20
> i40e_lan_add_device() can also fail before it ever gets there, for
> example when the i40e_device allocation fails, and i40e_probe() only
> prints a message instead of clearing I40E_FLAG_IWARP_ENA.
> i40e_remove() therefore still calls i40e_lan_del_device() and
> dereferences a NULL
> pf->cinst.
>=20
> Only tear the auxiliary device down when an instance was actually
> created. Removing the PF from the i40e_devices list below does not
> depend on it.
>=20
> Fixes: f4370a85d62e ("i40e: Register auxiliary devices to provide
> RDMA")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 84a97ca8a6d8..9a4f50af5347 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -496,15 +496,22 @@ int i40e_lan_add_device(struct i40e_pf *pf)
>   **/
>  int i40e_lan_del_device(struct i40e_pf *pf)  {
> -	struct auxiliary_device *aux_dev =3D pf->cinst->lan_info.aux_dev;
> +	struct auxiliary_device *aux_dev;
>  	struct i40e_device *ldev, *tmp;
>  	int ret =3D -ENODEV;
>=20
> -	auxiliary_device_delete(aux_dev);
> -	auxiliary_device_uninit(aux_dev);
> +	/* i40e_client_add_instance() leaves pf->cinst NULL when it
> fails,
> +	 * so there may be no auxiliary device to tear down here.
> +	 */
> +	if (pf->cinst) {
> +		aux_dev =3D pf->cinst->lan_info.aux_dev;
>=20
> -	/* First, remove any client instance. */
> -	i40e_client_del_instance(pf);
> +		auxiliary_device_delete(aux_dev);
> +		auxiliary_device_uninit(aux_dev);
> +
> +		/* First, remove any client instance. */
> +		i40e_client_del_instance(pf);
> +	}
>=20
>  	mutex_lock(&i40e_device_mutex);
>  	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

