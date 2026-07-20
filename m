Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7B43A7F0;
	Mon, 20 Jul 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564281; cv=fail; b=tbD8d4I9vE+cymEYkNR2CrXu9wVA/3DVPKz9M/SJIu3pmy2UsjoZRxKbqXqwVN3FptxAKNwbxzrUyOllVLJIsqQZAAuL9GyGfH/00k3nOETuMsjjDX6zudv3iZ1FzNAnpLF2VLWhKXT3TDfc8Uz8UeaqPjSkCX/Z3vhaQKRCc+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564281; c=relaxed/simple;
	bh=sUV8QhwHBdVBCxMF6KZqqHDw/cUPe8Ge9S6gOotH5bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpcNZSX6ddYNYkIpVmEFWJojEP5GHNZkURjHcb35b4NGRVdMgbcEdyZo1qpLNI4AwyhpyaVvmixhX3XoPelO4PhA167z4nL/lBf9bqNXH1UhWqo4LmDaDrOMREfZqkrLWjtOtr2q625j2vLFL3ujR6+xuKgGbmZuxDo1/hQ4eMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdFRTozc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdFRTozc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564276; x=1816100276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sUV8QhwHBdVBCxMF6KZqqHDw/cUPe8Ge9S6gOotH5bs=;
  b=FdFRTozciCccIZsVeDpAgeY2Dmmfezrs74NKvoh5S/HEL9eG2DDMdiFF
   srT+71orMc1y+Kz+Lg5KVmuPSXM88zS4YYRV/lb9rSJ8pOo4T7b0SykZv
   R52HQCzCX74ljOBjhepRVohddd2K7vQR4q/GBaMaSgnKNRSTx6tJmrpxn
   H8ZlW/ykiwyZkz03M2YXOqe7FxXQgGbEGZ5yWNYvDYNc4mwctj9dhuJBQ
   DLM3L0ScnvD0vjR2tDUKcm6TlKaFVnbYKuOpi8LrmsZRZodol52m8T8/G
   bedvx8lT8rL3LTDSJZKVsEDsIY5/oG+irG3jhdRntY/klxP9t45k1L2ta
   Q==;
X-CSE-ConnectionGUID: FVwOizYqRaeMifFukZYzKA==
X-CSE-MsgGUID: ITAOcs40T9qrG5MPgB1Hew==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85009707"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85009707"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:17:50 -0700
X-CSE-ConnectionGUID: xf5LmRpDQ8uyB1mxCSTueA==
X-CSE-MsgGUID: QKEvGeEDQl6BM8x0G52leQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295701903"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:17:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:17:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:17:50 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbH4NJqaOhg0g+Ng2jsXON9ht2HQOHzEy1T/zMvrrZT7bK4sgJLOnWp8Gr4VSMs+fd0vgWjzABDHCdoD2UAGSTjFLd4iHZBJAWcZ4JhTGaTDKAM5MjLR4Tkt/SWwpETF2EtBWsAxJmaIqZDlTNc8+mdnmaoz5cG5Z9H8p2JNINdaziZtlgbtkd8v3bUgZpUiMKgiMKRfARS++hvBhW2EDMfaoOgK5gB8ZDLyo8XDRz6b8d/jdnKy93kYgp6L2rA8NbKX55n8Wn2oLDRFXxnt/HztqYgc1fYYPJ36rs1qIVpHoRGNZ6MSdyInKV/E7ccLmfFIhOag5Mkl/wSOnLz9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwKVl32o5NFBCyfK7SDzDUdH6DbAnHRRwYun7BUgLEc=;
 b=HmbTKpUYthw4eVHPLWmlM7uOlHGDBWsvS0BIZ+hHYipwpetzMNcY3rk8yPp6SFbs8t9yOhT0GUjOfR/5RaEfCk/NDnMvxZu7VCjPY9rhoY04wW23Bq1AFcz2KOdv2+TE5dw8ZDzfcUCosQOfVlO0ZdKOfcC76eFMVBWUmqOSBhjeCGh292l3xxM0N0YuCUSJreX7WjbX2v27obr4AgCWrXVid4HKRk+r9W+D3ER0FlBkLx3NTg0lIpksdihJZ3WzLf3k0Br6OZYuPfcLqVaYmZ/sFOuEOVY3ZQak/GkX4UTDC7HuePaOYw4XSaolVGzHb3jjJaZTzcN2sa9BZmkpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:17:48 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:17:48 +0000
Date: Mon, 20 Jul 2026 18:17:38 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>, Samuel Salin <Samuel.salin@intel.com>, Bharath R
	<bharath.r@intel.com>
Subject: Re: [PATCH net-next v5 04/15] libie: add control queue support
Message-ID: <al5KIqnITv8RAWiO@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <20260715180042.1972010-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-5-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: d441089f-e689-49be-20c8-08dee67a7052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +Ros7BRiRdbT2EeaxPJEDOOFVpZynN92Jm20Q5f6pOo7mI5VmNf+F9Z8gVmybLQ442ivTcX/K8esdNLIHXT7xN5HYS1Bz/SPxXxTYcAgNiK1GAOUMoKRbfxc1iUwgIVs13Q+7ZvrLoiiy0AhMrfTA49tVgTMaeHWj0/glBmxpfl/mVicjmtJrB3U7r8Us6hv0nCFy6DR2b7UqR+e/DSYj7tPq8mxm1v00WUU5WaHFELySXxsvkzyE6cHwFuWICwqLpI3EovP9elXy5mnEfV2A9UITVOS+zDNwKqNj1p9hNUXEarICW6aJW/aB0aZF3/ckkzG6YRdJ+lniU8g6BLr0l2Zx3LZKWi4zA2LyTTaNuBdl6Cc7Y+kv4WGGVlsALI+vkYHb6uYyxidxFbpQk6WZhscbRrveDKIf7TQAn7VWgFdYUXfRCyTjeK2A3cVGVD6GssaOOUmmrAR4UV6m05BROcnsWqYeZ2RopSok6lo0go8Mk42/xplao0nZ673tmrBq+uk7QpiOoSEeQwh1GWqW3Kh99QiK1u9ie5Vo8xo+yBUzTCXp5mSX3GUGKDPX/YiQO9EPHDO7Fqet6k4JPMilTOF1U5JpS6nI9LMwJR+wyfrd46haYfU/ei6zhGMRlnNXkf6gMxqp08FIgcOe+c/+LOCNn+Bf+6jxjs6nNGPXwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6RZCtJs2p+XkGsFVnI0E/anXpVzl4ey5EHsR5ls6kFksPjIO6or/ziXDCk/?=
 =?us-ascii?Q?Np6Zrw3FMxWMisPNUF5Qrg0p+Y+6sADeSoajZRX5veuC2lWvs7kqz8CzOFNX?=
 =?us-ascii?Q?OqcWikx+S75pX/svAg9K2EIZYqNCpn9+dtqZ3etKyCpjEcpAxJD3aMw6WZK9?=
 =?us-ascii?Q?zEvZeoCFUC1sJjt/5t/3G6KQPkjnddh8G6ztpt08GjFL4Mi/PSMrXWrq6wCP?=
 =?us-ascii?Q?7pOe6zufJFPwrQH5iSC4Qvume8qmaVhdB7iiol2Xp3buI4d9kP6yCRJedDQQ?=
 =?us-ascii?Q?WhKJLJBzoAG/R0KKSMLf6bGXEFnP3VH5uEJrE+wV5ih0+u+YKX6yIpO3cM+T?=
 =?us-ascii?Q?hSxww/IytVRijzz7yR/3f5KID47IaZWjGQePwZsEz7nm3un67O0x42HcYcO8?=
 =?us-ascii?Q?yLNadzB+mSRSJzxj2xzPT1hmT3Lf0J3PLAPNHNtNWfk8tJOR+/dJjRLhGIpb?=
 =?us-ascii?Q?xw5yTu0CONAsNXVJ9/+5fPreFgVXVt/fg+XJqYMKAR6+Zk4AiY6dY8SbIJxj?=
 =?us-ascii?Q?ZGxLqTDaJBcZ4I31haDBVSe0Yq+5jxLl6Th8ZFeoxDWBysokxu5QJ+NzQHsK?=
 =?us-ascii?Q?u603klPi4EV8FMU42s+EFJ+bc7Y4L9srkBOpX78FuNBu5OQmwNCnZc/O/81q?=
 =?us-ascii?Q?ZIGSJIeQ5kNy5/AmnGbHDcW342n8kwybxyweuEKzGC+YOIfaU7SHakJyTrTT?=
 =?us-ascii?Q?XKzxpWkZpmLolHnlsK8tJTnot2+y54aLMZo2OM4lsmDcDTk5aDslTLhuHkWT?=
 =?us-ascii?Q?ms56hTKD0XkNzrZ/EObM699kRazeRr9dr3BPBQf6HeA6g9DFDfzVBZIbbV1z?=
 =?us-ascii?Q?m5Dkce03FQMtsDy29/jLVz7cGbvNxCvIpTAqcWyUjpbR8GcTp56VyR3bNofg?=
 =?us-ascii?Q?LOPTKufwi9dTb9w4W4hhFyU7SAfiUg+663SZPN2kMM909vUjOL4JWSgAKmw4?=
 =?us-ascii?Q?f/nlYNRiv4xNWyEBqqk6cZqJKrXcVdFs8yd1BP+0aMtcyn33XwEdkvwmDX3X?=
 =?us-ascii?Q?Majzj+tFRR1mqHSLIZ95HIyeclizJQWELYoySJNLnAd1Zylds/7TvtB+5OUv?=
 =?us-ascii?Q?kbT5RiYfQN3RhXPf/t5AcdYbqdXY6YcvLGiykyPpIQzj82fgn027FcjFKtp7?=
 =?us-ascii?Q?ORI7371tAgtkW135/TsW2/UerFQefUx8O6ZuABtilpB5p2UdBt4brEbddgtP?=
 =?us-ascii?Q?Pd810mVX9jGCbcBhK0hHZez+ptaIHC7DxNeBPdz6gF9MWUKZgaFI4UzpPRfU?=
 =?us-ascii?Q?DGXtIYZ/Y1BIOYGucWJiMv8X3VYDbwQFIdbT9zc3h0evJDmNgv7WOGj01x9S?=
 =?us-ascii?Q?E/EC/Mb1K2LhkNTj9k/DPFg+ru2cLvbd3xbJ+51A+4BjHLw8O7uJ2XKa9qNt?=
 =?us-ascii?Q?nwsLvfpEnFuof6wDqKgfdEzVvU6/Qk/mAjzQC6eoAS9J+D5Yx9enpRvz9wzT?=
 =?us-ascii?Q?ghga1CjNrvZ2273anMXCnylkrHvyDmtfs/Vp9pXmy3JZrUZyWUitzNpr1pGp?=
 =?us-ascii?Q?pkM0RIqsGwHqyJUqe+x4FII5ZciZeHQmRhxLfsIO/91F5uDO9ABCNxpeliwd?=
 =?us-ascii?Q?qxqb4qHu/j/MHnC6L6/04EKGxcKcnoefk+ZgHLwMArSN+ZjfzsbjQLFL8tr9?=
 =?us-ascii?Q?e8efyRCVi8HP+FPPSPPWyNPMm+4vWH4T/3/9h1VRVRQpD3P7qHT05QEfooTH?=
 =?us-ascii?Q?czPX+ITohOEgDfzmVhMn1yak04rVf4XmiLmzDPZzACDMJzpkV9aXrSsLJsu7?=
 =?us-ascii?Q?KI/SddJ4SsyUl2A713s9qYjXblUZlx/0SGTSYpRAq13+984HiP3zJXzhu9O6?=
X-MS-Exchange-AntiSpam-MessageData-1: iY/UH5/zJmzbu6VHdUuVRDSo5VpOOOpBOXI=
X-Exchange-RoutingPolicyChecked: ArdSKGzOeJFyqCB5YDjjpTHM98tUAxCHy0rGoT4sd+pfKsYWAm4VqK/g8SZOCcCcdW/sP7WADpd5he6w1k5+h2j0u+KMPPXRrZ5uynz4METrQJJC9JdK2UmlMhvI5xdksVE7bSY8GZrHnV4aP5ShWVa4yXedKK5CtUmtGsPPTXyiyG9i383EyGdt6lIhBQ+W8gH+lVBSI+1cuOBEpqvL8TC+SOwsRpe2kFNK7iiSLMCYZbZPq8gJxO/b76ks5NGnBrMts2iL3M3122TUeNTAZzdaGeD96rU+3cIcMFWE6x2HapwVdMpzlAbwTqOIalMPQZwTvFMbAGZNmKPDD2QNDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d441089f-e689-49be-20c8-08dee67a7052
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:17:48.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IeCTSBQEZ3PR3n4JNXUV1ZGfpag7EkSc3T/rPwvJZBZmB8naqyRKrFoDlfL/OmCMggvdjzrLHHqjcM5XFVC68DFoELnCxBykTygNUMNoKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com

Sashiko has found one pretty valid issue and one low-hanging-fruit in this 
patch. Just in case, here is diff that addresses those:

Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 20 18:00:25 2026 +0200

    fixup! libie: add control queue support

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 0a179957bfef..1eee507dd484 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -127,6 +127,7 @@ int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq)
        if (likely(ctlq->next_to_post != ntp)) {
                ctlq->next_to_post = ntp;

+               dma_wmb();
                writel(ntp, ctlq->reg.tail);
        }

@@ -331,11 +332,6 @@ libie_ctlq_add(struct libie_ctlq_ctx *ctx,
            qinfo->len > FIELD_MAX(LIBIE_CTLQ_MBX_ATQ_LEN))
                return ERR_PTR(-EOPNOTSUPP);

-       /* libie_ctlq_init was not called */
-       scoped_guard(spinlock, &ctx->ctlqs_lock)
-               if (!ctx->ctlqs.next)
-                       return ERR_PTR(-EINVAL);
-
        ctlq = kvzalloc_obj(*ctlq);
        if (!ctlq)
                return ERR_PTR(-ENOMEM);
