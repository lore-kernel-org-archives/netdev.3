Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54548097E;
	Mon,  5 Oct 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204740; cv=fail; b=M4obrQG6ymHrNZcYw+CmlPAGzCxMTGD6l+YcVNAR1b/kPMMaeo2yCFGRwUBg1JEB/Wlz9LKqmQpvOQFvA4osRDOy/0oo71H6IBK1y90XmrynSD46SQ7zea7d9ZFn07ax0hdsDsyN7J/sNs69tRd+hepCOHk6HMEnNNwUd6mEQt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204740; c=relaxed/simple;
	bh=TAE0JFqXEROdZLuGwTmK5gcMboZYdP8/1EmU66Z5W1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=At6AxtNVXDo+dQS+Zwm7uCgOHcXOI8StiQKO+1eT01me1v3BGMk0zkVU1Bb8Roj1ThdxjiWFYykrbMKJ8DSJLmtoVScDEhpGtOK8MxlXuIC+pEW5kP3m+uheH5axNzmrLl8DHOgPfjQCaTlcqobH7+Jff7vY0r/3hZ4rv4zTqAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+ZsyStR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+ZsyStR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791204737; x=1822740737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TAE0JFqXEROdZLuGwTmK5gcMboZYdP8/1EmU66Z5W1g=;
  b=A+ZsyStR1OSFcVB5RDMNylOtuMcL23opoEBY4JQxcyP+f7c+DCfhKfcn
   rJ7b1icVWNLHmiDQFLr9s2/jOSAzNDIt43LoTQJdhJnBe9Sg9DfFhgWvv
   Oa++TDZE8FOQ4lbu1Pad4qqPPJn4Hdbi7TxYU+cfeZeVe5U9kExwfqiJz
   3gyLEhQmtkSQn81xY2tNgtngYNITMgazkAwfmJ/cyGqCm2OGDFQGreA4S
   7cKLRVG1ExRSn9/brLVnJCqXbGcKvuoS6IDCBM/A79w5E7KHpRP1BxdVa
   hl7YdrwgetNTnDhwEulHx2Isej7tPBxcKWZzQ2nB7RORkqGsT7mut8mdx
   w==;
X-CSE-ConnectionGUID: OQSkRDxwTjmcI9jfAUImYQ==
X-CSE-MsgGUID: q8nRyindRrChGXpJpylCJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="108250656"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="108250656"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 05:52:17 -0700
X-CSE-ConnectionGUID: bAcbpAzLTwyzdWFanpg/lw==
X-CSE-MsgGUID: ofcY5l2uTPieBg9Uu3SuDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="306324406"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 05:52:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:52:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 05:52:17 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxPTsym42IzmWrl3Lil7NdN4QMplvFvIKKuQRCvqlNzThhlVdquoqdpnKrwqNJdr4Ju7NHbBSoeCREAUFz/h/rofg7itrUPL/IA5f7Minl/nikIGqrPjTvS5RFBTKl8m6c4hK/p6BKE4q2KZ5M2diJahLxn5xRSlFcA896b9I4ClZWgOhiLI0xpztyHH82HML2DH2pAUXo55TrNiTp5x75ttN8ZbWNwmbZsQPKwCc3ozPo3aVChaYedNtPqder1C60P27MLh0o38kOpUTSisJbSw8Davd12weHb1Z+L9xK2Q3nTCMNZRmv6W2tS/QrOovxqqqZkunpabkuPTxtgVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do9/vAUXpSjFK50fXBhb1z4fed0QgL73rtRchtL5GAg=;
 b=A5KNMK37Yf9FuiRZXoCrHkJNT2rTDs7JM2ahMCLG54Gy5vJmE1OrwobPPXRvSbrE2HMJjRW9fJRD+o3QJBEkY5txIChPqIaqq2ILaeE/3TZrRWEqrFuGbYHlpOyBc8LwM5fAeJ1+sH/uIlN9xwmv04C/JwF/zxxoUxpDxsaBlQuVOQ6IrMOZFSlM56W47NtfAKjUT+XGccAS6K147pPnjWv27JhX7q15xoRK3+XD6VKg0HNNST0PylsMzDgXFaOT3cs4TR1dtvX4OOr6/xNNLtr8L+eILzhzkrgMfWvh5JQgayD/CLKtWGJmTl6+8WBmdZO+JkyduGx7SoytG+zG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 12:52:08 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 12:52:08 +0000
Message-ID: <82e50484-fcfe-47a1-bfc6-ba78a935b375@intel.com>
Date: Mon, 5 Oct 2026 14:57:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] bnge: Fix error-path and IRQ setup bugs in
 probe/open
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
	<vsrama-krishna.nemani@broadcom.com>, <vikas.gupta@broadcom.com>
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f604e3-9677-414c-8fa5-08df22df7724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|5023799004|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s1rlbRE5gidkz00taVdB1XQTEuS8az5rz+QwekYpFDIsy+8rvBD6sA/wTH1IGhfPgJ0+TgrS9m633uTQMfPTC1UAcSp7cb7L6oa7ryvUkclemzc9II7cUcqx+C5NsUfDB6fVyDFl90nPCUbKqR2e3PpBu4/vPlNPFdEiLG3ZlYtGn/62DCiZ7JbCq21OXTXwwkhNBf+xTY1jMnzgjNb1C/dUxllcYIaUM+rafqJrqXcpqiqZZcOhFfhCaRl4Ba+RQAx/elcHy7f2Lp17WkOMcHsT3w7m6fXlNsRAaYBQPQscoohOhmPNws3apQG6sY09dql930Tc2je9VUyalC4DKc0uP6mBB1H0lYgpJTVnkJkHvwfat4+6HxR8Y7Kii5t/XdtjXucaea75kOHsaNPyF2aSeMq4WgIqjrvNq8ydF+uKs+AleejQbzUPFtPu1q5QWx+mwwyvVTH9ClMrRmlUcV0/Xk/uU1Lmcc9VX68bwbAABeFt2VfOPl4jGhthECkfNLi2UO76JTiYna7AydyHhCz+K9p1eE5JdE0vetC2cF7Xw3pOMMh4nV5eRDXtf/5pnJhYVH91JflUsmc4Lv19t5vWE+X8GU5AofgjujiGutt3apiC9to9K2f6bYarBfHm671vVelYkjloW92koyJOnxEaEHzpIVViadkVnIYBIKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJwVytpRFg3anNnUHpZZTUyR1V5RGFVc3ZTRWtRY2pSTjhyQVcxWG9BWENk?=
 =?utf-8?B?ZzVabk1CcUhNcnc4OFA2V1p5b0FEU2g5WTh2NWhzZ0Fob21GdVFlTzIwblR4?=
 =?utf-8?B?RVpmd3k0NHVUT3FneWhUNzMwaURlem0wSm1rRlZNUTBDbkg0NjQwWGF1aVZM?=
 =?utf-8?B?dktCemNsTm54M0ZXeE5pV1orWHVZNWlTdDFGRGQ2eTJWaW1FZ2FkWDBNYzVP?=
 =?utf-8?B?ZmJXMFFWeHBUam01OEN2NERIZ0FITU1iQWdDR241QTNyVEF2UmpiYUNRdTN5?=
 =?utf-8?B?bmtkM1J5VUo3dW8xVk1VZDdIcDMxUnlWeU4wWTdHcEk2bUl4MlhVaDU2ZzVJ?=
 =?utf-8?B?cXJ2UklnVGl1MERGZ2MzNzFFenF4anlPbGU3MjlRdnZxRTlaeDhMNW9NWXBh?=
 =?utf-8?B?cmdNTDNqalVxTDRrL1lVbEhaUGVESWs1bjRtcHVZbEZ4WFdDeFE0VWozaU1h?=
 =?utf-8?B?WVBlSHZZeTY1N3RDNXBkTERXUWRxTWtyNVFsQk5LdjJ2THdtMkl5UmdPN2JB?=
 =?utf-8?B?K0dKKzJHcXl6cVhYdkdMQ0dDcEozOVdvbElpTzU3cHhSNnBITGNyd25tZnNq?=
 =?utf-8?B?eXoyYXJmL3FzcTJaSlZ2ekY0MFhlRlgzZEJVL2s0UTBsY0JqdzBaVTNHQTJt?=
 =?utf-8?B?aVBBYm1tV3NYcTVGeFk2VkhCV1RvRG5qSHJ3bFhYb2xROEhsaUdNcVM1cFRC?=
 =?utf-8?B?aWFDMlFUbTFCendkU0hvckkrK2RObzBveVl2UG1OdWdHdnpFUk5jTnBJNHAw?=
 =?utf-8?B?MDQrNTRVc1BJT1RueGtwKzYvL1dUU3RmMWRRVFNDSFJHdHppUjdkdFpad1Za?=
 =?utf-8?B?OUpmVmhCR1BqNGI3L1VMb09WYXRueG5iZmtKYmhxa0EvRDFJS2lUVjNqbHhs?=
 =?utf-8?B?ejhlNnhScWFUNUNqdHFobnVvZDdPUlFRNHE2M1QvVzRnOXdJbmVrRjRMSU5O?=
 =?utf-8?B?ZSs5N2x0VTBxU05OUWVweXpidlBTak1BV1l5QjJmalZpR3hPeFJRV1NGOWVK?=
 =?utf-8?B?YlRmYUFSYzkrQlFNMFRkd2RhU1l6d1lsViswVFV6dlU4NDdudVVnRnhLQ1Q5?=
 =?utf-8?B?K1diSUppaitwVVdFRUQ0OVpzV0pLVUdLTGJCUll4N2NuRmpNWS9paFM3TG5w?=
 =?utf-8?B?d0EvcmlVSUdUYm1kSXhRSzZaMzhaYlIrVlRTbndrQVFTK3EzdHF6a2JrTW5r?=
 =?utf-8?B?T3lvUWJCZDdFdjRrVE1jYnExby9JRGhkNFhaZHBjNU9yTFg5dDRJMWFQUEdv?=
 =?utf-8?B?c0hZemxLMXk5RVdvdnFEZGI2UUNRR2E4YVJIbDF0ZWJ4bGU4TzdFQWhyYmlo?=
 =?utf-8?B?RkQrMVh5c1VHbmRFNzJLSVlvSGVpSk41MHZnRDJQVUpoVGdRUlRMajNTanBx?=
 =?utf-8?B?TWw5MFFGZ2N0RzhBRXpncnBxK3BEYTVCRlJjUStncTUrZW1qdGZjWFZRTjNC?=
 =?utf-8?B?VjF0WUd6VjZEWnQ2SjZWcnVuNG5hZDFUdzBSOVdSd0RLSm9JTFBvR0tGVGJr?=
 =?utf-8?B?Z2dyenEzR3pvU0Iwcmh5am5DS2xnRktVQ0w5UVdmK3JvVzdtMlg2aWpDcG1l?=
 =?utf-8?B?TXV2SVNRU01HR0VFc1Z0TjB1ckNnQzk2QU1mbGcxNnhISnB0NmhoTFMrV1V4?=
 =?utf-8?B?cWFxVWp1NW5FQ2RLb3VBVlZVczNuazZHY1pUYU1YQVFoWHZYdC9tTm5adkhS?=
 =?utf-8?B?NnNlR1dXYVVMVm5VQjY3L0xvUXIybHk1YU5UT3NlTExKR2JRZHoycy9DNWF4?=
 =?utf-8?B?Qmg5VGFYVGtnTnpVb2FaQm1yeFpTM0lnZC9rNUdoL1JUUGFyR0xVNlNiRVNy?=
 =?utf-8?B?d3JNczRoTUV6a3Q4dVFRcStLTHBndnZVTUVta1dGMXBDV29KOEFHdDlyb2w0?=
 =?utf-8?B?Tjl2U1ZlSGVaOUhjcy9rdnF2UzF4dWpKaWdwR1paZi9LMElqM3ZFOWJBdEZE?=
 =?utf-8?B?eDV3aUpvY2pZVE43cmtJWHFEUlRqOWtRbXc1OUdteHBKbitqdkxGUGFrNmp5?=
 =?utf-8?B?cE9BQVg2YTdTUTMzMUd2My9lNGx0Q2xreXV1bnFXQ2dsY0J5ZmxlV1YzOUdY?=
 =?utf-8?B?OVR3Z3IyZUIwTzI0bHJ5OXRUVkdSaVF0TzdrQ0E1RktBSSs3TEoyN3QxbnNI?=
 =?utf-8?B?MC9NUFBqeHZoWE91THZGNFFia3UyQ2ZScmpQaWsrcE1vQ2t2VlJTWWNKajRI?=
 =?utf-8?B?dEwrb0hwQ1dQVlNneEpDWW1XZ0NZczN5cjhpYnNUbnQ0OHhhTXdldk1yLzFu?=
 =?utf-8?B?KzMwc0ZFRFhsVVZPbmp3YXpySWVKOGhSV2JpQ0hUaGo3YzF4MjBjUndtNVBm?=
 =?utf-8?B?STltU24zV3F3eHhKZ3IwSXF6VFVPbms4ekRCclFvaXV4elRKT3JkVEpoSlUr?=
 =?utf-8?Q?MFJJ5clRe+pc3b/s=3D?=
X-Exchange-RoutingPolicyChecked: 18yqIFUPLkoNA+fizdAV/7kGvLazy90ueEGAM8JLnkCehAa7LNVLar53Uh4zJA2xeJY85CwYa/ZrvwxcGfsEU/v/jdLT7ZEaYpOWvO/RgQyKOFsnOdGU/ghhIW/Chleu8Oo4q3J6FehxnrKmyJTcPgEHsNMDk5j0I150/06RwlDvtbsh+Je4ZuwJs+JlK5DQDtJ7z8i7A+gx9mA66kiJwTkFXoxxUUuHJhnK2kTFdjm7IDVVXf7S5UUyDTy67wq5wVmG/RFmnRY2YxcVWc1ve1reFn6RpPwwi9AYRpGIr1QtWey2MroHx7qie9uSNBNTq4terK9FBa4nbCRfXv5BCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f604e3-9677-414c-8fa5-08df22df7724
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 12:52:08.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtfAsPBt6u9qlGaCH9ysOUaoYSPuBzJJTi+D33dAi7Ld7ztFfiCUPAPjmwsj+ZvqGUFOIKWRZRz4oNvDztH0jvrU3Z8uHA6fA1ghL1IX3dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

On 10/5/26 2:17 PM, Bhargava Marreddy wrote:
> Four independent fixes for existing bugs in the bnge driver's probe/open
> path:
> 
>   [1/4] Unwind bnge_alloc_core() incrementally to avoid a NULL deref when an
>         allocation fails.
>   [2/4] Require aux_msix + min vectors so nq_nr_rings cannot end up 0.
>   [3/4] Treat an irq_set_affinity_hint() failure as a warning, not an open
>         failure.
>   [4/4] Clear bd->netdev when bnge_netdev_alloc() fails so it does not
>         point at a freed net_device.
> 
> Bhargava Marreddy (4):
>    bnge: fix NULL deref in bnge_alloc_core() on failure
>    bnge: require NQ vectors beyond aux reservation
>    bnge: do not fail open if IRQ affinity hint fails
>    bnge: clear bd->netdev on allocation failure
> 
>   .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 51 +++++++++++++------
>   .../net/ethernet/broadcom/bnge/bnge_resc.c    |  2 +-
>   2 files changed, 37 insertions(+), 16 deletions(-)
> 

nothing controversial,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
