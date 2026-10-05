Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18830ACEE
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222186; cv=fail; b=iRAG1oahvEfE4YexfJereRZJ0HDM6V/s8HACsu1WxJqAe5WAHqu21kVtqqH3GY56LTuGY0uD4GQu7PoonIR9kjZ2LGWJfVBAEg0Et7NJ4e0u84i/vBGmyve/BaDRFih51XN/Pm6eOBUPeDAB1HAVwtCiUcNxi52soBloyuEN804=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222186; c=relaxed/simple;
	bh=zu3W9y5gDWcWih+8wmAVraYPD88sy0y5d6OlaUI3D0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pRsViK5urHLREXanMtIFSNAn7j9NSTFnklbLU23OCq6UJbi1yHS/ymQ5OpXBx+4+3Ru0Grk+cS/GiX2lCGIOuw8tZmGbH7tsYGLC/w8VfWmTqABUh5cR0P3FD0YGVqiqDL39gtT+dt7aziaXpQBJthDTgSbI4NTzckMTqJjGkd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7abI6Pn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7abI6Pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222185; x=1822758185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zu3W9y5gDWcWih+8wmAVraYPD88sy0y5d6OlaUI3D0w=;
  b=M7abI6PnLc2vA3+bSrn+4GyGKdgmMXJO8PhwNiZtL7WNJjaJf/uJtgV8
   4Oz0+kqZ+oxflLVnWEcr8YWvkwBYy9aF1MlS8QYYbL/Tz7YyLgNeTEUso
   nemgVbf7ZEoEfExaFJmJdSAJUpFuddu7nq6s3aFv1WiPGOWs9yxp2U570
   dPJNY1n2yPlQ5qUKyqdv7bEpYSG09ieBZXIyqJ/GCcg+zXo0mNrPyqwPf
   91/CkdaudvJ+5w6mTC5FxgNLOLrByWulhgtLP/qD6NsPNDD7ornO9EYzD
   JPRxlnKaoVnybS+EaOp7zJovWgLRwOOVqAP3hOLZBiP8co9m4TWKjmg85
   A==;
X-CSE-ConnectionGUID: GSArJBLLSzii4J6AUgqf4Q==
X-CSE-MsgGUID: VJKI0FUZSbu6hIZ369t3AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90935013"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90935013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:43:04 -0700
X-CSE-ConnectionGUID: ti/ZrXTASKWgLrhQ7QjmuA==
X-CSE-MsgGUID: YzHg7u1nTNSjMUlNTy61dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="284771071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:43:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:43:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 10:43:03 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv2AFVmTdhS3gB4Vs2fSa15JY01JlNq17UL4mR730/zX+KXvaMr38Yzdbxdc2SouXj/fBeWza/+FUXv1t0AM3bvA3TEJdVqG4mC+DV/+vuejG9WGZvlSejRCr+Nn9sXoKldh0bTUnOPL8bMZMyd+/mxYNBw1BMJ9mMn+3ESMziqcMinoM6pOcy7qeWntui7k4JmaYe5CExjJKZsBeVqvOffwG8f3XTmQSWGieMLqsR34S0Ng/v7w9ZSSpAwGK3EvM5NojabGomqCeKgFRxH9yKZxbXGzPp18j1o4l7hfnRG95412djkaTM7d7aNloVKGeasHTRiUSADVCeVeVKPMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0WjDwAaMSdZJ8s1d+LQdB/TOhNEzRvhsey0KI0f/+M=;
 b=tNjWz+rZj5Dfo0VILYbxYT2mfUjj9jP/ngthbvoiGYVSxd2G+vpva3d0+gmXBIFM06AltoJsRM1xxR9jjR46oHabLnEPF2c5iVszhQxR5SHeeVl7NWHJ85Bw1r1ysIrYrP3qWQLS+H+n2VcHn0o2+wrFpyWDYKCSRhzRgr2Ii6I9ckULvujBkehbJwm7ySjYTKStan+iVUwlgMcXEFMWVLFFLWC09uyv5NWK0fLmjxA/EQgtVsLQkxBYh7/4Mf3N533dx/IC2JXU6CQWVs3Ahvka5MDUbq7jDW4dT+PzvYhHX4n2uLfPf5oTpu/xgEjIqsOvRMXE9yLkA24E428h3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:42:59 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:42:59 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/3] selftests: net: hw: add
 devlink info test
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/3] selftests: net: hw: add
 devlink info test
Thread-Index: AQHdLFU3wu5sASDaEUGe635Ynxvwu7bviSLQ
Date: Mon, 5 Oct 2026 17:42:59 +0000
Message-ID: <DS0PR11MB64227A82B506D70DEF7862399B962@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
 <20260814174919.4177289-4-paul.greenwalt@intel.com>
In-Reply-To: <20260814174919.4177289-4-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|MN2PR11MB4584:EE_
x-ms-office365-filtering-correlation-id: 9eb43bb4-4d48-4ac8-34d5-08df230818e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: c0VotGIpFotCij2AaYfeMDI7b+nuXv9zGOQFaWdiWvh3hQDyOrZLrof58Zta5MQXNxjtwi12ignnX+ye5f8DNvFYIbrHFFu8riU4xXoQzQioarCLCQTxPhRqiuy0788490coaBr27njv05EDWYVbwkKeA0eq2rfTjTucPygUTfUOduf95+FFWwdi3JKJn6CVVkCEfVYIgiPDugW60SEb0jtaj1O973sSEiAeeC00aqEPTFort4fg54NNUTnmT5xIYKrRyKEu9dMdlwGFzDCFNDfn98IRB3qmA/17j0l1ruh53CxSizT1s0ef1M1ruB8Q4VGBwbZHqF/wkq03QJPsCFJAzOZNbZfHi0Y2blqVZ18z4xS+eybsk4T3QL3EtoBIeV0kJ1ghps9lxs+VMpVuCccqSIN30BqK01NdBCPfFExuwtgC5C2Q+3L+mKjsb9RlB1uBL9hCRo2u4ASlTA0dFerLcZeix6M5wLt8MQ6xVeCF7bVD6emFmfH2zae4ViT3V3fpAIRWi2XLhdsTaQE0sixdeN7IQQzPMQKOWJFLyF/z4ClGA2Y7dL9Q74k7vOG019MMhiyXbXs13i3A4BRFJO1n2sHrEmJzAqL22brCiljpan/kLMzvCUHawYk+oYgIsMNUzcS7a9FhlCaTTTCiuIdD9KiGC+EJkfU5o8elm26YgDUbVKVUzzjHzwqTxaT/f/eJdaGEAPfhJbRgd1k8GOUKw1JTPwqALNv0iS2R4z8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6422.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qhxF61t91pe2vxYHdu9XSZ2isreoL1HzOcpwLnhM9NUglvdtBdoG4a+sMlb/?=
 =?us-ascii?Q?H/HeKVIeYEx5Cbdv96lFOO2r4gSWow95FrQ+zgIfOuRmoHjEnKVKl82SOX2d?=
 =?us-ascii?Q?7uTUGWLM8YGlIVHmLRFMBOSoPkJyLed7uGx+JuumsUzc6MYTd2dEWP5hkDSN?=
 =?us-ascii?Q?yVJNOzJu+ETCy9E5D1s3/8xv+SSzDdDxS2S0CzMXw1kSp3oEYVymn68JE3sT?=
 =?us-ascii?Q?ainGJPIF2AiRGnnDR34KMngj8rOxzN19UN/un47fP3y4VJopGAQrKCYsctEq?=
 =?us-ascii?Q?e+QhCnKyYw8/9QoH0EP3DCusj3CSBzbFBeTCX3l+z5hF2Ik0J8vfGhevbyp5?=
 =?us-ascii?Q?3nGBme/gKvg2N/I9H4WOCnJF1oizuWAZ57UP3DoMvzFnDjuL7+ZBDd2T8g/9?=
 =?us-ascii?Q?2AHv9TsKgSsitihYAvQxjbGwW9/rSKWvZZfJFOGerrF2quzC8w7x9jfUZZIA?=
 =?us-ascii?Q?9RU6FAOhkqmMHSrd86daxpI8ZFG0CnFDqTQxOshrzoCW84Fp1ofWdnPLJgXh?=
 =?us-ascii?Q?0ZxyMfbCYkyCWnD3FtF1a0yuy5lXN/8spA9ks8MjVzVx5TtVwRTo9eBggvQ7?=
 =?us-ascii?Q?Y1CAhrmFSvfSoXOTy3oiZyaezLsQpdlkuuIf0GyGB9Qp+gkW7jb75on6VOVN?=
 =?us-ascii?Q?d1qmXeKdF2WdqG6pMUztE5IvUETMHIjSDMDKtXueygUyHywvzFYp7yHdWFm4?=
 =?us-ascii?Q?V6hl2YB1E4iiSoO5bfrAgzClL3yPU8XYNjJ2dqbBDR0wGE513Z5SfzMYwAVI?=
 =?us-ascii?Q?USEsQspU0nsvL9VlYR4qDHZRY/fcGyp+jseXqoZbTcLyxL08MVceHSj9C0Jm?=
 =?us-ascii?Q?zG/wOp61e1FxEGoVbtNrZguLtV+O6Og0kCW9cWmPPdhlq+IFvUFDKaK+fduc?=
 =?us-ascii?Q?ptT2OxEesmYgwbtIt5Que05DP1GOk5ovfGqNFCpBQC3HcASY2yE81dbQhq8N?=
 =?us-ascii?Q?dHH/P/4sfRmeGbMidRKgYrEKY6SGkoZFykJ6MhmaWoKxSqlzZzKo9uaqj+BK?=
 =?us-ascii?Q?2L6ATxj1I1lhjpF2jpq3cieG488wZHDDwHFijfy6RKJOaxQ5ZHtC1fh3zbEu?=
 =?us-ascii?Q?k9nss/rZxLjXfrmC2XxhFt+Xd0a/YzUQaySpyrU3xuq1tW5NHk6RX6dn4LEr?=
 =?us-ascii?Q?pQtGNeOp86WSvmkw/5QEkPB1P8Xe6SqgUy9zCXcvHOkSzT1Rl9JqNDbNm/5Y?=
 =?us-ascii?Q?m1p6Kxzej3szvCXp4L9oz9TlcDeIpVmuvYO7fWRfDT4EshBTEaf/DO4uwzV5?=
 =?us-ascii?Q?72kmxfnQdTL6JkwM/lKCd48uM9DwigSyPsXB8oMXq3A0mf8mbHqdSOIfmzcL?=
 =?us-ascii?Q?KHGoiYDRVfYzkEssIENgXqwl1TT0WA2WTIpZPb4Xp3a1+RW3qWGaG0FdvUoX?=
 =?us-ascii?Q?wNCiA377RycwOPWXDMl8kS2AM62obDrk23RSgNy+tTSxnMNu/1bZ9/FHpvCo?=
 =?us-ascii?Q?0GGgUlRgl/oM7N/YIz41lLNNxRn5w0psqu7Sl0nJXl3VVa+D8TlkmTfWPPKu?=
 =?us-ascii?Q?f5lNDYq+qS3hl82v9XTkevGC/8cxbe8E4VY/Vw653hO06Lvoa+5TPfPOQnCu?=
 =?us-ascii?Q?NLA+hrm8Xyvbn/afQ2f69kGSiAO0folJv/0MHDPEkB1OG5dBs0v9SwRQ1iLG?=
 =?us-ascii?Q?u9h+JdNjEwxIbbQFK9AK3L7EJ3TvxGlCqYaqrMwjgfuL4kZmOO/+b4wQh+Zq?=
 =?us-ascii?Q?p6WE1Knd7UdRsml3MIIHzc3Aia5TZDw2F8IcVIVefZMfQwr8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nFqAAc6R1pC34cHA7WMUZev8SMjRMUw2ORvyQWXA53MSCuw0N/IHoP8nejRSlXPpw7Ik3j5Yi6sifbdR89oJQbgdfNnKubGWstB43wIAjC9oLST+NJMzj3dxPL1b2704cAemOP+Ls6y15HwTqB9aO+CDMHh9gn97c1ddvXXVB7fLWvaFVdBBewS/uJiyaHVED1Q99B3pH9dmCgG/aJeJdMPu6bxp9vzYkRj8pH2XDnxYtncHherkndptqLt9T+d2rjAS25ewpwacMWMHNexR4MnPBABfxbTvarqXA+fMbPqfgtxGkQkkACWSQ+3/RWXK9rRD9Se7NVke5pupkpKx4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb43bb4-4d48-4ac8-34d5-08df230818e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:42:59.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N8B2tqHvGmt1wiUcpWjBHIuuUjFixvStJRTPJJCvDnzVPwYx6Uvv7xpwAj3H44fXFvRSQCNUtYZ4bNYcphxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Paul Greenwalt
> Sent: Friday, August 14, 2026 10:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] selftests: net: hw: add d=
evlink
> info test
>=20
> Add a selftest that verifies drivers properly report device information t=
hrough
> the devlink info interface. This test validates:
>=20
>   - devlink dev info command succeeds
>   - driver name is reported and matches ethtool output
>   - at least one version or serial_number is reported
>=20
> The output format matches what NIPA CI uses for device regression trackin=
g,
> helping maintainers identify pass/fail status changes due to FW updates.
>=20
> Example usage:
>=20
>   sudo NETIF=3Deth0 ./tools/testing/selftests/drivers/net/hw/devlink_info=
.sh
>=20
>   INFO: driver: idpf
>   INFO: serial_number: 00-a0-c9-ff-ff-23-45-67
>   TEST: devlink info                                                  [ O=
K ]
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-
> information
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>
