Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8E3B19B2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021092; cv=fail; b=itNOuTbzgHyOMBePM/mZOWiTfnyZ60G259iPjslqxcR88e+yIPqmc+RGsc+vc0ZDFXakPm+T7CEgS/8IrEwlGQCbWO6TNMVVr8izzw9+UjJiwnJoRNenTJcMZ9F5tUMVGkZ4OehcuCHB0UOn33MdXLzEVSSFkx3Wt5Pnqlfr1cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021092; c=relaxed/simple;
	bh=6zLFq9fFeQulMNzzLR85byuH0q30rfJz+9cQOVchjhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Znp0eC3NjrlHi1A5c87pHjPsUYGpyyfmiuhaKavr6Y/BYxbjx+e/IZ7/aVM/uEqU1RjIa1VrxhstZfK5nxF0D/VksmdWgMLH7ArWaq4gzv0qma/B+GQR8FQnH16fP+/reODRp8/yiVC+AFGCcDTgBVGFJzo3z4rLn6inCUERciY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACcd7b/z; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACcd7b/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790021091; x=1821557091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6zLFq9fFeQulMNzzLR85byuH0q30rfJz+9cQOVchjhU=;
  b=ACcd7b/zQK5eTKpOfoeTynASs+z5iRU5vUdj+vRy+HFTW8a1orNH/be8
   Is3uWhXBxjFmSNi04M7I928YpEajMvNMlDE2bmRxDem9Kv0E6F2M694gM
   Z6XG5scMJZBg8sCf7W7SaKoMafKac5xuNSKAZX5BhstHE0+Wv5oJzffw6
   srgVlbMddadfuK6wX9VYyYat/yg4zam0p6JlfY7YK1gs7HWMj7l6/A5qn
   9Yzm+FnAQ3b2LqvleNU0ZeFRL5W9gNWk4q/jzKZlEE9hyn64Zbv+S/2vV
   GHZcVQU2FVToFRc1i9/qUrc4NnvtksNp1x4XRwYszuKNRyKRoR245B5kA
   Q==;
X-CSE-ConnectionGUID: KRrUQ8MiQtqoXHPNsSy9tw==
X-CSE-MsgGUID: iPtuchyJSbeGf7pueooTug==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1073145"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1073145"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:04:51 -0700
X-CSE-ConnectionGUID: wbKdcPSeShCMvw1ep/tVIA==
X-CSE-MsgGUID: vD41CGE2TF66R7QTAg7iww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269313752"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:04:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 13:04:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 13:04:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 13:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awz3hHYpVMLGn2nCHgK8OQXJDqF7ur7P+gN2TWy2OZXiF6J8Yv+oajX4flSxQ5J2pu/bpXXhUJ3yH3aowEmTG3M0bjhi7zPZN621kuQbGnDg143doG19nQf0UzwP+fEYjzTY8hfDagwVhBb2bIxYMwVjlen56WChR1umB4EJqbDfLtkWAUO9VIytIgNtwqk75ODTp//sHS+1x4Bz1Vi3Y3S9FanfwjaQ7L2QRaKX8m7IRx9j5pXeWjij7GcOafJGIsRwJEOYsVY5jGwGH3tjmVUdcywDZ04brXtA23QyV5WBpH/DSFwGKY6zKF4TJQmBKqJ7Fbn8seMn4OlxwRzjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjU9zcgLxneh3bwixlI9ZnLcBVQXczirk1Xpje5gNYA=;
 b=DXC4UDxF7j+5QEgUQLQAwJm45sUjqV2YgpLSVf7K2JRKLYMkUr8s1S/tjz0aT0U6PARn1pTiPPu0i2NT/jKGiFTONQr/ORgJrlPpY2GqFOcTJCic+NQLltbk8s+v5DMp1P8OUOkJudTFS3hE/Yvk7JpWnvLrzqzZS35L+RydXHTMH292e0mbUvPv2ClxgKg4EZBk+BVoSQ+h6nx9emIHwetg50/IxnOvFIQFspN1DCCAj5iNPLHD+IUHhwQyRtD3AwuiCxK/qW3Ld9stC59jIi2iUETKsqT3CvQreTIMNEZohKbTPatXkKRyYyMbikCNqA1ndw/iwkbK5pGN8aJrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Mon, 21 Sep
 2026 20:04:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:04:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sang-Hoon Choi <csh0052@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Changyul Lee
	<lcy8047@gmail.com>
Subject: RE: [PATCH net] ice: initialize the SF number XArray for allocation
Thread-Topic: [PATCH net] ice: initialize the SF number XArray for allocation
Thread-Index: AQHdSgIPNMZi5pZSgEaVaIlOae7+ObbZdH1A
Date: Mon, 21 Sep 2026 20:04:45 +0000
Message-ID: <IA3PR11MB8986BA3EF87B604D154D7638E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <179001656821.91284.11640142428321627272.idr-bug-50@gmail.com>
In-Reply-To: <179001656821.91284.11640142428321627272.idr-bug-50@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB7552:EE_
x-ms-office365-filtering-correlation-id: 52c954c1-7d26-440d-5752-08df181b9551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|6133799003|18002099003|56012099006|11063799006|22082099003;
x-microsoft-antispam-message-info: 2J8mbYpc7+3I4SxXGi+N3eT0BMTd5hyaHcW6268tUBVuc0UE6HeopAkPySE9yQoBO2nFInMV3KP/N/l7xDxOEBmy1yvAuNGNEyTboW8Qs+eL+BcwqlukZwKK7HS6LvNZ4gcaxOwMc6fcEF+YWHkfkzCQsjfkzjG+NinmIWjkm6qN58IkfeOptjIMeRUnHzQSNBNj0kN6/zKkFUFKthSq+wxSB/Xo6jK4vJCPyuZ62KIPjvBNUXl2tAweHv1/jN9+zUNI3XSutjpJJZsLgxHhdmQFzyGUX9Upq+3J3WSHJ6TUPvZfqc9/DA0zlTDtWR+W7KQNDA3KxEDxg9+HxWuKS4UkzSUuVBFyBMfo4ZgFf+1U1s4izpQY4M5IC9/FbTPPISHGkJUxZJp93TheamCIgLNdbUDhi4GqVUFOBNGe9cSbZOZNYWkG0gitGIEoizXQvRTr6V9BlEeGalTUuBxaaSbErgzBqRDJch8L6VgqKbQyYKo7RZi5DCr5zKv5waSlzq0mHGB4XGYukmITagIDeuXnwPCy8XrX+A777qX3y9yoJT+5jGBQFsEbd+BxiXSFUTrvpLVnXdGNFwgeNVSOuCVMEUcFBDn+I0uCOM/ZWqeejzXR+y7WgjjlR1tsP3ylZGiu50ieoSV3nsS3eNj4wPUPRnyH+cFL9QlDOS4dfQMbQyNl6ouSKCtywmQYxLZf6sKsIXK8Vq/bOfGUxmKdJEkUCc3DRPPAh1woOgZSAS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rmiW+vzOVWFzrdI+q/ph33ODdkeqceoFHTysZvBhfL1n2LwsTtfcoBz+wRvs?=
 =?us-ascii?Q?WzI1oCeAPX3h2zukYbYUlW7vS+XFhU/uT1IXHltzqfVbzuIzrV9usNzZufrW?=
 =?us-ascii?Q?jd42MQJV6hmw9W6zAM09WZR94edwb8oHPax+vFskYFA7za5HZG60yrMoyVQN?=
 =?us-ascii?Q?FHZYOe0ZPJXULTL4N+FArmASG7GG74iubnQg2A6pi6+AzmzZ6sXFX3wXR0JA?=
 =?us-ascii?Q?d7S6LxqjNITaL5GBl7mK5Yg5pL25rGYPEC0nNke/KkKt/+uAlu88mObDkNkK?=
 =?us-ascii?Q?sCEyZ6qyIxhmaeR9Ua801oM/Y+NJ+OT23VghoID9+5vhPqcfEblekN5ST+Qt?=
 =?us-ascii?Q?DkDE1NWRrNchaY8Pv8K76DVu45E8sjwsuST+YDZiNNK9R5ctj1C1o8T5Gy35?=
 =?us-ascii?Q?HGa688abjV0ND0mf7kRjn4un8SVzvI0ZJVl7b8A6es0yT/S4zIv0eM4zwdmG?=
 =?us-ascii?Q?bsWcoGdEPYCwsX3g2VRM15j0BMC4rVfjprMjr13Nu0QPGxLx2MLIXUxayc5k?=
 =?us-ascii?Q?PAn61f0RR+swTAXoduRQONTJW+nyX84hyM17GV+PfeFBPk314YELTTOCE1vu?=
 =?us-ascii?Q?997BG3hjER8HkeIWLOxWq+gk4BuJMYnzi4YOQLMsOnZQ4awY4eSddXe3lB4y?=
 =?us-ascii?Q?axjATiZ7Ni+XflteoUeYKF9JF6j3moGwamh61tnglihOErF+uSCfhbZOPENq?=
 =?us-ascii?Q?fMdG9Tj8X+op4wxcC3VmkSfFXk1QOyJuWVgD3yskpot4Jxqw3kTh9qdb5AOG?=
 =?us-ascii?Q?LC4Y7Rp7K1nX/Ar6o23CTTC8stKJB6NQUonmfMsLPIamo+O1b5HDilvrYbuC?=
 =?us-ascii?Q?369SbL+9DKorZswAe63TEvBEsjIS9hZHrgcDOQFlakoD+74thGohVZsjXZG0?=
 =?us-ascii?Q?Pojrmg+woZWRQOKwdJUj2CfvtPYyGDvRYAC70LVYVhdOHgqkQS46I9mYSkbG?=
 =?us-ascii?Q?oqklEyOR11IYWIkopr/ZsBMZ1OokGv26Pe+qSmmKWXNLYJQ4ZWH3kWS8zK4W?=
 =?us-ascii?Q?0sst30vxRWMKUj2Gbq4VfdbAfOWj4HMviGKyo52vbS4MrS/276eei7pNMJED?=
 =?us-ascii?Q?OMLOHqIRxwoTY4umlW0R34MTch64eCyeFM3bYBCIFiKJqqdPiSYq4GMcqQ5o?=
 =?us-ascii?Q?zLVHSm7VmaKRaqIAfvURP0qXV3rh01KW+JzGht4sEAF+y4S0u+LSzqOrOyeF?=
 =?us-ascii?Q?wgZE9jWUB7cPB849nKU3ICDbqhfJ6uw5zphVhFIwnhqzj9bxPTRJ+oHlrEVX?=
 =?us-ascii?Q?OZbehvDkw/+znMew9UwI703j6fPbOC6wjoq0TU6f8BJbTOP5ajItcvEz6OV0?=
 =?us-ascii?Q?xXqjDoe24FoAic6D5636hti5I9tFWWjZVeMi+6VmRnycoqKPhs38Tsn3Vqgl?=
 =?us-ascii?Q?r8nTgnM64NDX+D7sUBe1KnXbZJTtMiqR98SmWOof7pe8Ew6zn7b6L6Dq/ETF?=
 =?us-ascii?Q?IKNlq05gYBNd+KmUzut3SHovkTZ/G3q8xpE9ZPJd+x05ci0vIanh9mic2p0c?=
 =?us-ascii?Q?6AEzyzKD32wh9Q6bwXl6LF070r5hQfp7t1FQ1qqx1+GBGkp0cWnYZjDL1BOu?=
 =?us-ascii?Q?ZxbZEg+WB3E/v/DOvbWLEL3N6lr019hAo9+TaxhJLPKu3K9Iy1dSlVcrjNfH?=
 =?us-ascii?Q?/OlHqM5ENZrM4UY0VKsOXC6TdH8/8/HL8xFhwf9A8n7/ozEZXL4k48vVzSc7?=
 =?us-ascii?Q?1VkVhhyF1lqpCxSlPW2tZxvdbSfa1qM/x6HK47+nf4Qjmi5Bt19tNnqQrKt7?=
 =?us-ascii?Q?qiinAmszNpqVg+joAQJuzWKF22SIRkE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XiiRVmJzs5zYYj3oKRftKbWi2uwc8cRI/CGUZ5TNg5w2Ol71Qbo82+gRSFAV5FKBDMsocjhnVmal7qYWq248HF7NCi1S1JgxUkAN3Jr9c7rzIo2osVAnMywcAm4Ip4HA6Xzy3vadI/mzHLLsFs/mydr98PAM+gVRbEgr8Oph6XUfgc9oYtfWHUC+uC1mwj0FK9gj4+sQrg792GfC6i4OEQobUYRppd+P8Rjcc25DGz2lWD55m7g8VXYRwHqCqY4VLm/4eQMt1IKae6t70L9dDdhz1tBZiBfS3AGd96WJxxy/k53YluKZTp2S+5XFdbTR7ONFQoWPDFzZSVOnM7EsBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c954c1-7d26-440d-5752-08df181b9551
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:04:45.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0EaypNZlQRR7QsRdM5hv571WbI7vLbGk7VaNy8fWqx/zLMf2JoWQc3+rY83iYfYaOg7T60zIVOzUZg03tgDr5UhRPagz3IgDma3erdGy3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Sang-Hoon Choi <csh0052@gmail.com>
> Sent: Monday, September 21, 2026 8:49 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Changyul
> Lee <lcy8047@gmail.com>
> Subject: [PATCH net] ice: initialize the SF number XArray for
> allocation
>=20
> When a devlink port creation request omits the SF number,
> ice_reserve_sf_num() uses xa_alloc() to choose one. However,
> ice_init_pf() initializes sf_nums with xa_init(), so the XArray does
> not track free entries. __xa_alloc() warns and returns -EINVAL,
> preventing automatic SF number allocation.
>=20
Do you have configuration and reproduction steps?
Can you put it in the description?

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Initialize sf_nums with XA_FLAGS_ALLOC. This also preserves the
> explicit SF number path: xa_insert() with a NULL entry reserves the
> supplied number, and xa_alloc() skips that reservation.
>=20
> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Found during source review at mainline
> 5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is
> unchanged at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.
>=20
> The ice_main.o and devlink/port.o objects compiled with x86
> allmodconfig and W=3D1. I have not tested SF creation on ICE hardware.
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482..f56c2b748 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3996,7 +3996,7 @@ int ice_init_pf(struct ice_pf *pf)
>  		ice_mbx_init_snapshot(&pf->hw);
>=20
>  	xa_init(&pf->dyn_ports);
> -	xa_init(&pf->sf_nums);
> +	xa_init_flags(&pf->sf_nums, XA_FLAGS_ALLOC);
>=20
>  	pf->avail_txqs =3D bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
>  	pf->avail_rxqs =3D bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
