Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794593316;
	b=qY9IiNkyWaDTKeS+nbPGgY2Quuzt65f3HCqfTDdoRfahw+wdt16cQ4zHeMjkrC9AqngS
	 eChrg0ikBBwzzbn3huxvEyBJVSihKzXbvwi5taUrRVW17ayPF1G6iD/X7j4jWxWBVpGZE
	 yyysfHAdB4X6NecuSlncwfOGhC7GND5U9vDPWYdELgM3xRJH+1CL3ggwYh4C3Adw3dNfu
	 KDwNvwcJNGWPU3+axbn5lti14yqWktsWV0pQAzp6MaW+5eE1zFVF6owqnc3zq1aZQzGYO
	 anSvE93vn7cBRDnvhnKizhTt5ufVhyKL4f7dMejykl8ILE34rAFkbuXaWR4dDCRTflA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593316;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ejw/zKAoNB7O8A/cWQ85lqicUnCLfjZUTcZ9k0BPHWE=;
	b=4ZGMjQl3T3KRTuzWw6Fqbe9w7kbBQpky2RBlx4BNIeC1UfKxvCQuRMJ9ATB/P8pJGmQD
	 AgPj1simRCy2vW9k0IRM6Q+SuvO93S1DVPj/IeeHinqLfKKDvgwy1GrsrHsmMmqYeuWct
	 DKgFGJ+cugNDRODc0vYY1Vyi2k5jgo1wGeXDHL0nA0gx+1aldjqRypU/sDBXis/jR6i7k
	 RZlXEjZthnQmReqae6DWM90yJWtKvkBEHAjd1cDz4k7SZm/2HzaWzkiBdpwPX1+mXtkZ5
	 aIqbeIorbrpRqaW6ccBExEq6Fmet/3eu5pWEvpyavcpkZoz3xRg2hNBsvuljQSU6tlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ywy7BG4b;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=KrJk+p1u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F8606A323;
	Fri, 13 Nov 2026 18:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ywy7BG4b;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=KrJk+p1u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794593315; x=1826129315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejw/zKAoNB7O8A/cWQ85lqicUnCLfjZUTcZ9k0BPHWE=;
  b=Ywy7BG4bXh6TpggDcdU2r895NKhC7exp1Rl6ke+XjBKuRGNsUVA5XDle
   p50w8FC5juWfCA/IKwoGacIQkvYxcf1t6ztPyPCeeLZXvlBjlrVzN4WZP
   Mdg5P28JpcpzjBwV/U5/rFshqe2EflksCrxoAimqSOxRiz9DZ2ARfzHYn
   lhRicOxr+WmNyj0Bsdpi/l0uuEZb16RaH4pGUJQztgr5UQqU8hBCkB0Nr
   UVwFqYi6Y7EhrG4towi+G5TMd7EDIu0FRo/XR6Vf4ma5DvBA3yOJkJhUT
   akb9TmqKrHJQWylKuizAnTd3jfIx8LGBiNmOaD5GxsJ2d87a1otfPFINi
   g==;
X-CSE-ConnectionGUID: qUV0344VQ2y51rSe38OIsg==
X-CSE-MsgGUID: 9z/2Qf2zRhOD9RGugiCv4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3297001"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3297001"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:08:34 -0800
X-CSE-ConnectionGUID: iWxqzRIeQlq+8utaZTU9KA==
X-CSE-MsgGUID: 4JhoyFzpRxmeuF9oK5e+aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9066067"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:08:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:08:33 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:08:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:08:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCFVX/kPdKU0TPumR6biygHtRbqR0ICkLdWA5uRappPmkHDRaGrRgojC7seOqdInrJ5AfydPZgY/66LtXiPnzo16DCjChGqJN+Bj6RmjU/rbgCv7sZER6OdZP3LNji1GNDAVq09kqEACjA3XthdU8cEaphzRhU2NSXMbU+3FOBZemKsCfZYFsrx0fvTlI1zyzbkInmsPICyNjEmHlQlx2PTYCJWJqAlmMJHwY2XdU5rLMlLOvKwTtpFXYRR7a0Nu4JJ1X+PuiLse4f7U43bS4fYzjnlmhtuJYm1q8ovnIi+z5yt3WYfwiT6gcWup21DINR4bgZCpPQpmafWI1Z/RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejw/zKAoNB7O8A/cWQ85lqicUnCLfjZUTcZ9k0BPHWE=;
 b=uLK4fMeyCkoPuZJselbm2LBK8CCOfSIvWZZMYFzDKUxH5J/ivXVFUBEZ5dKdhrDMbRPAnYZCOhdArcfuHe4xlb8N4Qx5tL7okbBhImfsxb5sp+L4T85Kr45x5P5HiXXHYvhDVCFqp/mHUB/yNexFhY9Sl68n2AWXgqTl988zrmzGHiEdOA3f/mgIAUfaSBpq4e6lmHYfisDfGz79suOzaSu88z0+TboHXsac08ZVqsp+YDvE7JsyUz1qvJwcsEZOusWsUTvabeNIICpaoOx6u9nGHt32uwMSEjg9yfOeP0EgPCgv9SNrZ2q4z2xZm2YYXWIKN/shFhUoOF1OJPEgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejw/zKAoNB7O8A/cWQ85lqicUnCLfjZUTcZ9k0BPHWE=;
 b=KrJk+p1u+O4PQjRTibn74uydbIerGD8t6AZDmlgSFxmCdUtJz6hOdViL71yQP983jfzuAkhKPv2dRhPBFcm0qYMsJS6PGEK5NZmUxpG9Z8hMBVJSyLmiJHQd8pt3kOFw3jGcNsOiDaRSYl+dhUQ7aKpDDCYDvJUlVR9GcOopFq0=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ0PR11MB7156.namprd11.prod.outlook.com
 (2603:10b6:a03:48d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:04:20 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:04:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Breno Leitao <leitao@debian.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Chittim,
 Madhu" <madhu.chittim@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Alan
 Brady" <alan.brady@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Willem de Bruijn <willemb@google.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, Pavan Kumar Linga
	<pavan.kumar.linga@intel.com>
CC: "Burra, Phani R" <phani.r.burra@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
Thread-Topic: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
Thread-Index: AQHdcFjcYrQ1ydaa80ipKwXmZ6oLJbcsUgmQ
Date: Fri, 13 Nov 2026 18:04:20 +0000
Message-ID: <CH3PR11MB566895CF7867B29A09B9898088E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
In-Reply-To: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: f8e49d28-1fcf-424a-ba89-08df41b08a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|921020|38070700021|10067099003|5023799004|11063799006|56012099006|261021123027099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261021135927099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: X3oVj42l4vK9ZPSYQC50q28gR3RdOkyqCKvmu9ooPvBrE0qXuIHqSnO8+tXC0Aho16l8TWsoWqFFtL+RUeDw+CUc7QzazQhSEaaJBiw4SgO6req5F7BDin2CfjB77cdrpq/Ffq4jmis69k1elNT0AWs/4WNM8SdyQ7Sg/tRHL8tE7Pwu7e/FOvWJ3g2HbJmYPCz8XLQL3Gtx7gRQnxNtSXfeiJep6EEApZyyWhxdKi3DF4CuOknCp7fcQ1Q6UsD4efjg6p5EAFzqK8nM0w/aNfJy+osKUpqGL3ps1faG4gqPoCVMVE1EVZ7irF8d5mgkZVivAmnpKopwno0r0AaeT8KSjE1I8Z9dLwAgSo1qxdPQ2T3B8eZ+w4DIb3wVotaEXJw3DfLwRMNZD3foxBkt85UDOfZplesqtqh53W7BAgA3WWGUR9/aaI2FaUWAviFcIk2/dSLTl6DhhA3L+7+KjC9iIJmEYpUtaOKqaFxyyEFpgsSRq4yDXfUd9/7oiG9drp+ywVk5tjQdJiVKporUI3rIScCkufOJ/DW2dS3Qb/fDOAetDsZKFhMSNKRubFLGr62sa0p0hvej+ZoqUx85hLpnBZuNjk19OOYzXdHIcRtAwS6jXPdbf8gYQrY/R9eYf1nmhu7zRDAlwzL0X3muv7vr740LJXGc0DaWmerr9GEddnJhYEa8GCuIVvYAduSD64O4CYRG7zGI6BzMuWjze3PX8pxZLrHDF7EPJXfsn+MPgCvew3iNrIddZCKCh3Zc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(38070700021)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021135927099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5jYmVNa3RJYXNkeVhBMC8xTGUwSmcwZXRPdjhUOGZJd3QzcUVjd2RqRTRs?=
 =?utf-8?B?a01PSVJpRjJpRkV0NzdPeUV0UzVGeFpScm1BcGRVVkQrNDV5bDFvODRFZDE1?=
 =?utf-8?B?MnRFOHhRalp6TTBUbW5Jc245b25leWZhNWpFZnZudXJUWFhLVm5QTDgzbzFj?=
 =?utf-8?B?Zk5RZDUzZEIyWGRIeVMvNnprVndESnltNGl4SFprQWQwbkVSU29QZ1dRU3lF?=
 =?utf-8?B?LzF6NTJJWFpyTkFxMnU1T2ZMN2dhVXJJdnN3bityYXN4azR4U1BVeFQxK1RN?=
 =?utf-8?B?WkJRMG1hSEJMdUFJV3hwR2c4dkpUTXFyWldBdC8rUGJmUlNZK0lZSWlYZzg2?=
 =?utf-8?B?WE5ZUURidit4VDlwdkxyQ1VmVFRKaHFJeFJlbXBFeDBpUXM2aEUrbmlUYldy?=
 =?utf-8?B?MHhGenVMWXVEYzNOcnBpRkg1UnIwdUxzWjFXd2pLdERTczFrVHFMejFPTXoy?=
 =?utf-8?B?VklkY0Q5bjMyNmNuZ1Y2OUlOUnRpR0ZWbmRiRVNNRE91VWJxMkdsaytNT3g0?=
 =?utf-8?B?Y2RlZzNFeVNhRGN0OEdMSHBkSFhPOC9LSHhZdkwvNzNUSHBDSEpPSHR2M2s0?=
 =?utf-8?B?SjdUMjFJdW52WWxWVTlCeEJBb3dvOFovTEhZT09nZndmNjl1Z2VWQ1FHcHlR?=
 =?utf-8?B?c0g2MitsOStETjdyV0R1RTJxa0hmVkk0cks0eG1hMkYvak0rZWhLSm5UTWEv?=
 =?utf-8?B?RUZVaHRsSGs5Rjl4M2h6Y3BzemRabDRsbVNiSEhUVG9vcjdoQllMSlFwU3lY?=
 =?utf-8?B?N0RPUnRTSnVDcWltbTNpY3BCMkl3WDdPNnJCOW03aEhxZjlKcjYvcXN4RGh4?=
 =?utf-8?B?MlNKaVMxRnIyRGFXT2s0dTNDdnZzMnRNaEdzQkxtNjdMaDh5RGVMaVgzRnVO?=
 =?utf-8?B?QzFEWlB1WDlDWGdNUlUxemM2TWFOWU1kTTVnSllUWCtnREIwWVE4aDlydGRo?=
 =?utf-8?B?NzNXOHE3M3JkTzRTYWc4RnN1MTU4RFBUWnlTeVJvR3ZUZ3hpZjVoSm91TXRY?=
 =?utf-8?B?VXQrT1JOV0owdlE2UUxVbVBVdjlZRGlqdE9yaXV6eXVnMzQxbVA0WEhzQUNK?=
 =?utf-8?B?eUxtMDdPQjJFbG00UDVCMFo5REFyRHdDdXFITXFCbGpteitqV2wzWWVwNDlU?=
 =?utf-8?B?ak1JTHFjcTZTTTFDZWlRYmlhTXlMVWhXWkllZXU3QTloUVcxRmZjazYyZURw?=
 =?utf-8?B?NWQ1YThtRE5uWFF0Y1N3QjJuU05xRjhjWUtRQzBaNFh6TlJza1JWei9ramQy?=
 =?utf-8?B?Q0g5Uit3TkRGUHhMN3dmTW1RdkliNE1BMUFtb21JVHptSVNkRFpra3hrSS91?=
 =?utf-8?B?L3hoeVpHS1NVZTRpS1gxbWVTVmZtUm9RZm9va21JbVRqWlBhQm5tdjgzSVlk?=
 =?utf-8?B?ektpWFJpYVVUQTBJdFlDcnI1VllhY014YmpQZUZram81VFc3MVlxcHFaZ3FI?=
 =?utf-8?B?TUVya2Q2VlpXU3dtZ20wN1Z5blZUNXEvSjJReXZOYTlmb3JkUnBKOE1XQTFN?=
 =?utf-8?B?dnJ1bHhuREJhRmIrRHJJL2NjejRIRE1SNlJIZDdpYTBUZFdjbHpHVHZxbnYy?=
 =?utf-8?B?RTJUL05MakpzUkdidnpQUzErN2hkalZScExJWnNTZy9YZk5rOFM1UER3bmpn?=
 =?utf-8?B?RFpnakJLN0YwMG5hQkVzT1MzMDZiZkhrTEFreDNGeDZVK1YveUpHVTBqWlZX?=
 =?utf-8?B?TjMzK1dyb3I2OElzZEpOa2dtQ05RNS82ZWVMZitUemR2TmJtdjBLN0trSUVm?=
 =?utf-8?B?VzlkYXNsbmdUUG91bzdLdTE5UWt2Y25tUDNmdVEwbWRPN2hIazBRcnlVL212?=
 =?utf-8?B?aGJOZXA5dFRKV2RCQi9aNlFyU3FYaUk5eWdiWkV3S0RTaU90SU9VR1VsdUFP?=
 =?utf-8?B?MTVXN0pxbkJjcUhTZ0QybWFsWVZyVUhBM1ptNTI1US9EbGhsYmFFaklOWVRM?=
 =?utf-8?B?THJzVVdBWXQ2Mmg1YmlBaGM5b3ExS0RkN1NsbEJvRDdzT0pVdTdDNm1MU0po?=
 =?utf-8?B?dkRrSE5SeFFDa0U4WWpkbzFJWUx3ZGtmYzNXeXliZXJ3MnVLengreDdPTExO?=
 =?utf-8?B?S0oxWU9oWjltdEJpQVpnRTROUzZJQ292allncjRFLy9KUXFxVlFnVkR2bm44?=
 =?utf-8?B?NWEwaWVvYWw5UGVGcW9EVTBCUDFFOS9QSnMweTh6UFljRUMrLzVybkcrRU1M?=
 =?utf-8?B?NmNJSEJxdlYrU2lxSFhIOWVBYXBCd2JaSGU5YUgzN2dZYURtY2xmOGx0NnRO?=
 =?utf-8?B?U3RNSmZhNjAxMEswd1B1c29CQzNUdW84aVhtZjZhSXRrVGo3QWV6VC9qR1l0?=
 =?utf-8?B?d0NrTzl5OHhMUktuZStLTk1RaVA2NlM4d2M1TDdmRmM4K0hhSW5vM3pkaDZC?=
 =?utf-8?Q?+lKyCAlBaA5VRH5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XoJJ4BIyWYNZs6l0zydfvQsontp/jicQ2qu4RY/7W2KdqDl9pyIvItnRjBGYwRerY6n1GVggsvkpbFyQY0t0aVbiQebZ7lv8QDfXdQTj4BUXYCiAascGRddBLaN8qbe8ftH1p4zH1r0L+yzZflTwiRvboDFzimt0ImcSYICORNkkUNS3P9y43Ue0ZYT3vvjyaYAiMZok+fTnfNvSrSl2ZedgjxrNYjA+sQrUK3KB6AuJfNKG718iF1PZaGxJli9xTo/0X8vxYq9i2ckimKpXYZtPvlcXIUF7/SQacyRIe4lpRLBU1wijkYWhLLBTDpmmllr5AQwWUhCKDM/nlKP+UQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e49d28-1fcf-424a-ba89-08df41b08a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 18:04:20.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zs5zy7k7vD00zhQa4P9RE3KvPJNSdQtcHni1HVll3+vr6GssSa9ez1FQRudUTylGNdvDottneS+cZprrwohvn4JPlHxIU9+wguDfrq4g+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJlbm8gTGVpdGFvIDxs
ZWl0YW9AZGViaWFuLm9yZz4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA5LCAyMDI2IDM6NDMg
UE0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBB
bmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBrZXJuZWwub3Jn
PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJl
bmlAcmVkaGF0LmNvbT47IENoaXR0aW0sIE1hZGh1IDxtYWRodS5jaGl0dGltQGludGVsLmNvbT47
IFRhbnRpbG92LA0KPiBFbWlsIFMgPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+OyBIYXksIEpv
c2h1YSBBDQo+IDxqb3NodWEuYS5oYXlAaW50ZWwuY29tPjsgQWxhbiBCcmFkeSA8YWxhbi5icmFk
eUBpbnRlbC5jb20+OyBTYW11ZHJhbGEsDQo+IFNyaWRoYXIgPHNyaWRoYXIuc2FtdWRyYWxhQGlu
dGVsLmNvbT47IFdpbGxlbSBkZSBCcnVpam4NCj4gPHdpbGxlbWJAZ29vZ2xlLmNvbT47IFNoYWls
ZW5kcmEgQmhhdG5hZ2FyDQo+IDxzaGFpbGVuZHJhLmJoYXRuYWdhckBpbnRlbC5jb20+OyBQYXZh
biBLdW1hciBMaW5nYQ0KPiA8cGF2YW4ua3VtYXIubGluZ2FAaW50ZWwuY29tPg0KPiBDYzogQnVy
cmEsIFBoYW5pIFIgPHBoYW5pLnIuYnVycmFAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxh
bkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AbWV0YS5jb207IEJyZW5vIExlaXRhbw0K
PiA8bGVpdGFvQGRlYmlhbi5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXRdIGlkcGY6IHJlc2V0
IG1iX3dhaXRfY291bnQgb25jZSB0aGUgbWFpbGJveCBpcyB1cA0KPiANCj4gaWRwZl92Y19jb3Jl
X2luaXQoKSByZXRyaWVzIGEgZmFpbGVkIHZpcnRjaG5sIHZlcnNpb24gYW5kIGNhcGFiaWxpdGll
cw0KPiBoYW5kc2hha2UgdXAgdG8gSURQRl9NQl9NQVhfRVJSIHRpbWVzIGJlZm9yZSBpdCBnaXZl
cyB1cCBvbiB0aGUgZGV2aWNlLg0KPiBFYWNoIGZhaWx1cmUgaW5jcmVtZW50cyBhZGFwdGVyLT5t
Yl93YWl0X2NvdW50LCBidXQgbm90aGluZyBldmVyIGNsZWFycw0KPiBpdCwgc28gdGhlIGxpbWl0
IGlzIHNoYXJlZCBieSBldmVyeSBpbml0aWFsaXphdGlvbiBpbiB0aGUgbGlmZXRpbWUgb2YNCj4g
dGhlIGFkYXB0ZXIsIGluY2x1ZGluZyB0aGUgb25lIGRvbmUgYnkgZWFjaCByZXNldC4NCj4gDQo+
IEEgZGV2aWNlIHRoYXQgZmFpbHMgdGhlIGZpcnN0IGhhbmRzaGFrZSBhZnRlciBhIHJlc2V0LCBh
bmQgdGhlbiByZWNvdmVycw0KPiBvbiB0aGUgcmV0cnksIGxlYXZlcyBvbmUgY291bnQgYmVoaW5k
IHBlciByZXNldC4gT25jZSAyMCBoYXZlDQo+IGFjY3VtdWxhdGVkLCB0aGUgbmV4dCBmYWlsdXJl
IGlzIGZpbmFsLCBhbmQgdGhlIGRldmljZSBzdGF5cyBkb3duIHVudGlsDQo+IHRoZSBkcml2ZXIg
aXMgcmVsb2FkZWQuIFRoaXMgaXMgc2VlbiBpbiBNZXRhJ3MgZmxlZXQgb24gaG9zdHMgd2l0aA0K
PiByZWN1cnJpbmcgVHggdGltZW91dHM6DQo+IA0KPiAgIFsgMjE3Ni40OTY4MDFdIGlkcGYgMDAx
NjowMTowMC4wIGV0aDE6IERldGVjdGVkIFR4IHRpbWVvdXQ6IENvdW50IDIxLA0KPiBRdWV1ZSAx
MQ0KPiAgIFsgMjE3Ni41MDg3NjNdIGlkcGYgMDAxNjowMTowMC4wOiBEZXZpY2UgSFcgUmVzZXQg
aW5pdGlhdGVkDQo+ICAgWyAyMjM3LjQxMjU0MV0gaWRwZiAwMDE2OjAxOjAwLjA6IFRyYW5zYWN0
aW9uIHRpbWVkLW91dCAob3A6MQ0KPiBjb29raWU6OTgwMCB2Y19vcDoxIHNhbHQ6OTggdGltZW91
dDo2MDAwMG1zKQ0KPiAgIFsgMjIzNy40MTI1NzhdIGlkcGYgMDAxNjowMTowMC4wOiBGYWlsZWQg
dG8gZXN0YWJsaXNoIG1haWxib3gNCj4gY29tbXVuaWNhdGlvbnMgd2l0aCBoYXJkd2FyZQ0KPiAN
Cj4gQ2xlYXIgbWJfd2FpdF9jb3VudCBvbmNlIHRoZSBoYW5kc2hha2Ugc3VjY2VlZHMsIHNvIHRo
ZSBsaW1pdCBhcHBsaWVzIHRvDQo+IGNvbnNlY3V0aXZlIGZhaWx1cmVzIG9ubHkuDQo+IA0KPiBG
aXhlczogNDkzMGZiZjQxOWE3ICgiaWRwZjogYWRkIGNvcmUgaW5pdCBhbmQgaW50ZXJydXB0IHJl
cXVlc3QiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCcmVubyBMZWl0YW8gPGxlaXRhb0BkZWJpYW4ub3Jn
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hu
bC5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmlydGNobmwu
Yw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+
IGluZGV4IDkyOGRlODY4ZmE2MjRlLi43YzExYzg3N2FjZDBiYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sLmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sLmMNCj4gQEAgLTMxMTgs
NiArMzExOCw5IEBAIGludCBpZHBmX3ZjX2NvcmVfaW5pdChzdHJ1Y3QgaWRwZl9hZGFwdGVyDQo+
ICphZGFwdGVyKQ0KPiAgCQltc2xlZXAodGFza19kZWxheSk7DQo+ICAJfQ0KPiANCj4gKwkvKiBU
aGUgbWFpbGJveCBpcyB1cCwgZ2l2ZSB0aGUgbmV4dCByZXNldCBhIGZyZXNoIHJldHJ5IGJ1ZGdl
dCAqLw0KPiArCWFkYXB0ZXItPm1iX3dhaXRfY291bnQgPSAwOw0KPiArDQo+ICAJaWYgKGlkcGZf
aXNfY2FwX2VuYShhZGFwdGVyLCBJRFBGX09USEVSX0NBUFMsDQo+IFZJUlRDSE5MMl9DQVBfTEFO
X01FTU9SWV9SRUdJT05TKSkgew0KPiAgCQllcnIgPSBpZHBmX2NmZ19sYW5fbWVtb3J5X3JlZ2lv
bnMoYWRhcHRlcik7DQo+ICAJCWlmIChlcnIpIHsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDog
MWQ1ZTJjNTdlOWZmYzEzNGUxNGIzZjgzN2M4ZDdjNTNiNTA4YmQyMg0KPiBjaGFuZ2UtaWQ6IDIw
MjYxMTA5LWlkcGYtbWItd2FpdC1jb3VudC0xODRlZmI0MWI1MjUNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gLS0NCj4gQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4NCg0KUmV2aWV3ZWQt
Ynk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
