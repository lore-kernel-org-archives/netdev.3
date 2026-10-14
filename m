Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE109419FBB;
	Wed, 14 Oct 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998146; cv=fail; b=F/tlwGhWMxWALlzETxOPdKwz1JjtrXgeumc0oMN3QANgJ5ZTosIaHexuXe3X3HnRFfVy+mTHtJf7OJy8jbN6QGqsD1HnghQWe5etYDwKmswc2KgpgpJ4vpdr8KVbojtuHXHdqcGXiVTTrpw1wBfYlQnUQM/s9mW3NMIQD2QriKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998146; c=relaxed/simple;
	bh=WYNuJ92kcCiwpxdfsLt90IMQziMHxjOb84Sme/xrM+w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBQS4Uzxb/SJhICWgLeC+9lfgLIbU3ZwZmSwbhoJ/tjq/q4UQ+88/cqrJ5BSsFv7WFLNIfsSVfEGHLLX30gYOitznsfcYsYQ56pIZbZ5OGd774LMea4pk7W7b7PoLXqSj6EZKPoaveBQl2Xa1ohDwRH4feTvhKLy6fEmONeoKnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhRmp0xa; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhRmp0xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791998139; x=1823534139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYNuJ92kcCiwpxdfsLt90IMQziMHxjOb84Sme/xrM+w=;
  b=PhRmp0xahgnhrXCt1UHjTJYxZa1v6soGQ3f71JqpWHQm+k9njro0FdNt
   AjdCV00lmOCeFBD+XHTX3U5lmeTOk+3OxexkrTofLRXySHppyjMlGagCX
   sW3Gi0WypARIfOSKfp/QeSDPoHG7YWj/5ZFxuA4NhTvJ12HXRyO7ejqfY
   2Y8vNBKO/dA4H6y7ktJ3+SCUvszEVHJAyJn/79QtNrDd4phkHxIhtPxw8
   FxBtx53g0AX87Gt5c2rNJxVKpY7KrqsADbn5rTbtPeEF/daC7JgElBsb0
   z/DVW5CNnioprIoYn438IY52/focXyqn7WJkc417a6HTShTaiEG31IHB4
   g==;
X-CSE-ConnectionGUID: /sS7hnNBSYOWgWTRIz7mMg==
X-CSE-MsgGUID: DU6rL9ncQBKtmg4C2EzBOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="745458"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="745458"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:15:39 -0700
X-CSE-ConnectionGUID: ISVAx7g5QoOVCd4IMT8OBA==
X-CSE-MsgGUID: nLXCN96iQPKu6od18ULTvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1796437"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:15:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 10:15:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 10:15:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 10:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz6gHkOJIYxxi0nCjtVIVzYIh8diXtImcOQzHI44rUh9Kc7fd1M0c4kGz8liFx4c6o21bpE6IY94VQW6UNOdHkPVqyCRmona/RC5HDNEaVVNLwnjfnS9/y1mS3C/bkyM8Lp0rYF/BfzNciAnVu+VrvOQqJz75LqUJb2C9Ems4cnNsqxZU1mPQp4S6IVH5Y3tRPBAJ35LpnFaOvu4UQShfKFcFakNPzsJOqii0mmbsfY7N2ULAxNP+iyEbCfCWy/rNHcmvIEjnDJGT5Ih1WZMcT32uO4/ETBTxPeeWXmAGLTWz1PGQBqNeiGGrrHi5iGm05RBd0NINpV8Jybq3svTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/8145QZeO3rLW74XRut7t1DTpyEa67EqFItuW0AIcs=;
 b=X3oLGCSUXdcyE4tL5sNMzU8mknBREeeUYSpyRlSrnzC59ZETc/gjPUNikHaXYL/lnBB9mjCZYR2D9tzVU9BCBXU9cECjE2ctuW/0cOGL86/BFw9ZfNMd2oJOaJwg3gJyQ0YL9810Wd+6y073l+VJ/WwsXn1SNSCUQp2X/ovitxXTelwcWR9VoNjikPSrCRpY9xicqufoyDIM8kBxFziDLVSkOsZhRUiqMbiQbgFFezP0RGXTqSf1ZXSI/vR9OTssav8oUncErU7LVkPtjGvnQPYsCgxu0m2BTLKpi21qcJDiVP9oLNXogXHpU79NgBT+6A8dILwd0B/XQLXqgu0dHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by DM3PPF818092190.namprd11.prod.outlook.com (2603:10b6:f:fc00::f34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 17:15:34 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Wed, 14 Oct 2026
 17:15:34 +0000
Message-ID: <6f36805a-bed6-4459-88cc-994ff6e939d7@intel.com>
Date: Wed, 14 Oct 2026 10:15:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2
 ioctl
To: <netdev-bot+sashiko@kernel.org>, <vjardin@free.fr>
CC: <yangbo.lu@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>, <wei.fang@nxp.com>,
	<xiaoning.wang@nxp.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<ioana.ciornei@nxp.com>
References: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-3-0f4eeff2295d@free.fr>
 <179176332574.434549.17881202126873427960@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179176332574.434549.17881202126873427960@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|DM3PPF818092190:EE_
X-MS-Office365-Filtering-Correlation-Id: bf55a3d4-7c6c-4789-90d9-08df2a16c232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info: HndeNrK/B8DPVduRMGxa/Ve++ng9nrlHAah8QHzLY+Gvff7NxT0+9GQrAftpPXbU2quHlSxCfyn7sR9tFko6d8Fy03ti0ybkWupcT5/g6ZEkuOHd98eNB4fY4xDNY85nNApMwCk0Unk8f0Ile62ihg5LRkpZ4MrgX05KuKOcb42xyCtNuvKCwgHKXmQ+zT79ZPcg3fEMTOwCaPHJVup0eKnaD8VpkgOzT62yjLxgKosoHy1r9WUCR61QCR1cPf6PqOYLuLP1D+o4VxQneuT0d/Hy60ewv43A6CG5RChWSaeiKpOO3XIw5H2nRvzBn3dDSjtJQe1KQT+NO7yyfacnK+hPUDDhLESa1JH3GuPEjrToLiKjeivWGDZvhGndh2qkm2aOVFnKF+gFVfWUUXJWFyOcmEyraXBSwnJYtJS2UD/Sgj5Bl4MaAb4/FXBS7CcBpnAHx5q1AxChaBt5tMZCicKzpkiSk4mFaw9AAgikRqS/lLV/sNTPXAP5FL5pi1bGJH4O4Y9xXzZrYpmMYimCzBVuhQqK86+CM4fcN31VJ2w13mB2W4LzVav2jUZokdSYVKsNT1w8SLhWn9kz6LKeTwZQuq79RAXa307zoiLw8ttJ0NEyJmJ1xv3mhi1EgEPbQxA3ODzWvpE64wgOmTdyOeubGIxOsmQroTq4dQDsX1aM4GIuzSUlKcSfW8b5vahJCJ6JJTE91tLJ7ntSTtgB4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVJT3lNRDEzbEowM21HbndqL2UrZ3ppT01TNUhuRDNVUEQrQlNCZFMraW1C?=
 =?utf-8?B?Rzh5WHJZUGNwNFF6R2ZySFNQMUxmZkEwemNLems5R2tpYmx2RnZoYjkrVFNE?=
 =?utf-8?B?c3Mzei9oLzNHVFFzZXZPV25rbU01dTBCWFh6bnVpdWFLbXZSOWVRL25hajls?=
 =?utf-8?B?L1NvTDFLY21BNjdiL1B5MVB1VWRxdktZR2ZCTTh0QWNEaGF5NVZndU9tbnN3?=
 =?utf-8?B?VzdoS1FBRENwSkdNK0FESWlmNDF6NEZObjNNVjdST2pscVlqaVRGV3hockFN?=
 =?utf-8?B?MFpIUDZ0Zys4VWNZV0tUOXdHVjFLUEl5cVJYa05sSGNXanBESWFhUVV4d2Fu?=
 =?utf-8?B?Tk9MV2xVWnJFckUzcTl3eGtqVER5TzFWeUdZRmlMQml5UlRGeVpEUjhBMFFq?=
 =?utf-8?B?QUlXVCt1aWx2Y25KSFBmbHlzSEdNMnAxcUFtakIyM085dEdQYXc0OHl0WnpL?=
 =?utf-8?B?WlZQdXRDOUxjQWhhU2JqdnhwMEM0cEI5Ym9pUm5DZXZLZXJmUyt2VnF2RXkz?=
 =?utf-8?B?Vm9SZlo3cjFySjVBb1BIY2JWTkRxbmtoWGNlUnE2bWZralQ2aDlnckJWMEwy?=
 =?utf-8?B?aDQvaFY4b00rbjFSTVg0dEVKSmowUzZJL29zV3kyOTIxdWhBZ0d1QTVqdE43?=
 =?utf-8?B?WnVkc2t3OWFmSWdFaGFraGh6WTkrYWNWdldSUkwybjc5V1h1RjVNR00vNXZt?=
 =?utf-8?B?ZHNqSnJuT0duV3NQbnBXMDBzS21tVC9DRUNLTVAvTHFCZGV0L1hzRVRHbEVP?=
 =?utf-8?B?RmtWTEFqeS8yTXJ6VWpHMDY3M1hzRVQ0a3VnWDl5QjllZ3hHbzFnV0xLZVZo?=
 =?utf-8?B?bmltMmc2dHpOR2I1c0JuYlk3U2RvYjhZL25kR0Nmc2JwSnlLSmhRcmJnY1hp?=
 =?utf-8?B?SXl3L2g2VGQxRjg0RmFXVzB6M2J4NVZSWXpoTG1ONE1Vb1F4RE0zb2l4Ukda?=
 =?utf-8?B?dk1kZ0Q1cHN3bjBIaDhpVWRBZGJZdGNpSlBSTlhqODVNUTVyQlY2ZHFhc3lh?=
 =?utf-8?B?TnJJYnkvTzZrT1RoNERSMzczUHpjcXRIVVpaN0JzbXk0OEcyS21Vc0lyaHFO?=
 =?utf-8?B?V1BjZ2tlYVVXeEI4aytmYzdUL3dOa3ZzcEVEYU90QjN3MXpIaUU3cExFWEVD?=
 =?utf-8?B?WWpZempTaXdYTjlxclVQdjU0elliM2REOW1BYlZDZzhTbmgvU2hva2lLRE5H?=
 =?utf-8?B?UGU4MXJiODRFajBINU1uUVNCV01VbGxDOFp3Qm13NXlQTUZDR3IzMFJSVzVz?=
 =?utf-8?B?TUY5d29GK0ZVTDIxMHhyeGZ5MUVxVXAzZzY4c0lQRWh4SUtMSi9GbVN2dzFE?=
 =?utf-8?B?dm9ENzg1VlNMcnpRRlVxM000QWhVOE1DdUZaZ2xhWUtsWmpHSHFEbkp3YWp3?=
 =?utf-8?B?bHJKak10SUJ5WGtwTFR6OTd0QTkxeW5RQ3lxQVhYd3ZaeGpEQUx4UmE5T2tS?=
 =?utf-8?B?aXdXWmhOSlRsOW8rVTdqLzJDU0tKaFRvUG5iQzVWNUpYY3VabTA4VWlPSVhR?=
 =?utf-8?B?anA2QmZ0bmxtRTEycmJpUzU2bTcvSm5LVmJBdG02RjhrOVBkNDdjcUFJbTBM?=
 =?utf-8?B?VUgzejFtdzNKSzN2cWYxRS9Tdmg1Tjc5Q3d0Y1JXNVNzMkhjZGduT2JDK0tB?=
 =?utf-8?B?NmZCdVpKNzJDQXozc2RFd1FwYUlWSHg0dUxMSFRBUWNmUVAreUcvWklyYlRo?=
 =?utf-8?B?WXAyZjZCSWJZZ1p2M3dvWmFXL045ZDF4dmJPSVhLZW5PL1BScjE5UW90OVF6?=
 =?utf-8?B?YmNNWGo0THpVR3dMeVBMNGtTUnNkT0V5ckU5UUZ1NWtiZlc4L28yYUFlL3Yw?=
 =?utf-8?B?QTNBT05sQ1JUWitodm9qOGNPVG1La0JSMzY4RGFtMXNKVWJKdnJlTFlIK2cv?=
 =?utf-8?B?TFdBa1F5OEFmMmpGckI4MUEyajNJeTNMZ25kbm1YNmdHcjlzQlQ0QkVsdGRK?=
 =?utf-8?B?bGhOMzFuY2pZZGxiL1JMT0NQK0VERDlYdUs5N3BKZ095ZXdCREdlU2dNU1Ex?=
 =?utf-8?B?WXV3VjhGQkQ0MXBNWXNlUlU2UmdGY1VTQk0wVmwvLzJZREdsdVhuVjVIUFlj?=
 =?utf-8?B?eUYrMW01N1FFWVRYa3poai9GTlA2eGUrZndtZ2JTODhETU8yQVBNcjZzaUpp?=
 =?utf-8?B?WTJMbDhCNkdTYkFwVWRlNHQvbUhQaVF1SlBlWkFXMGtSOGtudFpxMGR2Szkw?=
 =?utf-8?B?UkRPZGJHeGZTajVrL1JqMUlRV1Q2dldVd2Nva25xQ2o4Z0R6b1hIK3BGMkNE?=
 =?utf-8?B?dTBDSWtnQnNuaHhRRUROb2IzeFJjYTVEVVUvOVRZdmw0eUFXc1lsTmlFMGVx?=
 =?utf-8?B?ZVNLU0NsWFJLOTBnYnphOFp0enFNK2psQis3OXVrS2w2QVJkQ3FLV3hHdXZt?=
 =?utf-8?Q?x3DxAU/qJicoMDLg=3D?=
X-Exchange-RoutingPolicyChecked: BVpV6C+dBfmZIa5rZrLF0Wxt9BOw77dEVlUWnViK8roQC2b5M6LezOrk8B+6G2N3mySsqmFaay5a8gM1ZgwzFyJIqBxba1G3HJsDQUJ63yXHS4F5Ql3Wj55OoXVMl2AAhr9HLFDAkLJK9EXV7HaFkdJhglspXjvGUFnS4ybXMQekObe/JYnwp5jUxG4jbXMENSG5o2Gv3OQpq0SXqhRzv6cq5/0a+7ywdfXoV7Z+51CpRxgymYhO9VnE0vWMWCrRQmimM3ADooKqEb2FAx8yjabFu+L6ZExd0h95nG5DdtBQ+vaE3ijdx/Onw+9WhuPGtRkiRIp2sn9ofdr+8k7IpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf55a3d4-7c6c-4789-90d9-08df2a16c232
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:15:34.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umrblptArM/UVlEWd3En6l48z447XmHKjdH7/UqiRCca+lljRExTagG9ZV1E4mul1Qms2fWoIiGUNjzU0OBijR6sWlfsTW0lkYu01/xF10o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF818092190
X-OriginatorOrg: intel.com

On 10/11/2026 5:02 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says that making the legacy
>   PTP_EXTTS_REQUEST ioctl strict "cannot be avoided", because the core…
> 
> --
> 
> ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl
> 
> This patch sets .supported_extts_flags in ptp_qoriq_caps to
> PTP_RISING_EDGE | PTP_STRICT_FLAGS, so that the PTP core stops rejecting
> every PTP_EXTTS_REQUEST2 request. Because of this, the legacy
> PTP_EXTTS_REQUEST ioctl now also rejects falling-edge and both-edge
> requests.
> 
>> This also makes the legacy PTP_EXTTS_REQUEST ioctl strict: a request for
>> the falling edge, or for both edges, now fails with -EOPNOTSUPP instead
>> of being timestamped on the rising edge. That cannot be avoided: the core
>> adds PTP_STRICT_FLAGS to every PTP_EXTTS_REQUEST2 request, so a driver
>> has to declare it to accept them, and once declared it applies to both
>> ioctls.
> 
>> diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
>> index 76272e5ac5b85..bcd29104effe7 100644
>> --- a/drivers/ptp/ptp_qoriq.c
>> +++ b/drivers/ptp/ptp_qoriq.c
>> @@ -355,6 +355,7 @@ static const struct ptp_clock_info ptp_qoriq_caps = {
>>  	.n_per_out	= 0,
>>  	.n_pins		= 0,
>>  	.pps		= 1,
>> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
> 
> [Severity: Medium]
> Is the "cannot be avoided" part of the commit message accurate?
> 
> In ptp_extts_request() in drivers/ptp/ptp_chardev.c, the strict bit is
> only added for PTP_EXTTS_REQUEST2. For the legacy ioctl it is always
> removed by the mask:
> 
> drivers/ptp/ptp_chardev.c:ptp_extts_request() {
>     ...
> 	if (cmd == PTP_EXTTS_REQUEST2) {
> 		/* Tell the drivers to check the flags carefully. */
> 		req.extts.flags |= PTP_STRICT_FLAGS;
>     ...
> 	} else {
> 		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
>     ...
> }
> 
> PTP_EXTTS_V1_VALID_FLAGS contains only ENABLE, RISING and FALLING. The
> .enable callback can therefore tell the two ioctls apart by checking
> PTP_STRICT_FLAGS in rq->extts.flags.
> 
> Drivers in the tree already do this. mv88e6xxx declares
> RISING | FALLING | STRICT and rejects the unsupported edge combination
> only for strict requests:
> 
> drivers/net/dsa/mv88e6xxx/ptp.c:mv88e6352_ptp_enable_extts() {
>     ...
> 	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
> 	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
> 	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
> 		return -EOPNOTSUPP;
>     ...
> }
> 
> sja1105 does something similar in sja1105_ptp.c.
> 
> Could qoriq do the same? It would declare PTP_RISING_EDGE |
> PTP_FALLING_EDGE | PTP_STRICT_FLAGS in ptp_qoriq_caps. Then
> ptp_qoriq_enable() would return -EOPNOTSUPP when STRICT, ENABLE and
> FALLING are all set. That fixes PTP_EXTTS_REQUEST2 and leaves the legacy
> ioctl lenient. enetc_ptp.c also uses ptp_qoriq_enable(), so the same
> check would cover enetc.
> 
> As written, with the Fixes: tag, this is going to stable. Legacy
> PTP_EXTTS_REQUEST calls on QorIQ timers that ask for the falling edge or
> for both edges now fail with -EOPNOTSUPP. Before this patch they
> succeeded and were timestamped on the rising edge. Commit 7c571ac57d9d
> calls the legacy edge flags hints that are not expected to be enforced.
> 
> testptp hits this path. Running it with -e and -E 2 or -E 3 sends
> PTP_EXTTS_REQUEST with PTP_FALLING_EDGE set.
> 
> If the stricter legacy behaviour is intended, could the commit message
> say that a lenient alternative exists, rather than saying the change
> cannot be avoided?
> 
Hm. The intended behavior had been that legacy ioctl would remain
supporting the non-strict mode. I guess the way its implemented doesn't
quite work. The strict flag is cleared automatically but only from the
req.extts.flags, and not from supported_extts_flags. I guess that might
be an oversight in the ioctl implementation. Its been a while so I can't
remember the specific reason this version was opted for. We could modify
the core to also allow non-strict mode for legacy ioctls..

I'd prefer not to fix this in the driver as the AI suggests here. Either
we accept that both ioctls will be strict in cases where the requested
mode is not listed, or we need to change the core to work this way.
Having each driver have its own variation of policy was one of the
things I aimed to avoid with my refactor :/

>>  	.adjfine	= ptp_qoriq_adjfine,
>>  	.adjtime	= ptp_qoriq_adjtime,
>>  	.gettime64	= ptp_qoriq_gettime,
> 

