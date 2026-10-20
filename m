Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792455489;
	b=lKAhYLaVQihxIvojsQLNK9mCjF2fBI9ovJ37awXNuT4OD+71/3s+3RBr9j3UTAJBLCZy
	 zNRptw+5P4pwrhW4CqP1J+LuOX+BSVzxisjtiQHtl0Bbwl8OZYSsjz1HDQhv+YSwGKHDu
	 /QWf2lMiIfTMsOmM2XbI+DUCaYnE3umB/2AbddyR1OWF/bZDZ/O/fsXEb5z3LJEw5CYmw
	 oCxlW/KkTyYKUmG4T5kyKQv5AdrrVmpBjJYtgAwzh6/dVGw4tBWtvY6eCOR21n/QQWVv9
	 26B16gpE/6EmVmcY6j/WrjAygXdkxLZczGs3I03UW/C6jhBm/7fS84wBOXR8R/8dYjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=W5Kd79V/WqGMODXzAuycKv9nCg7lNhcWduXl2v0HW9c=;
	b=JiqXgwTI8Oqyb0GCnpYybVXdLpaqbHer1zYf1XCQrmRgVTTfb83KvplxU8yTJqmlO2sl
	 lQw6F04VH4bPYiTUaB90h/xzJlJIuNa2rTitLZjNY1Vz4DW6t12Y6atSodyv1d44QcUBB
	 9nneq7DvnaTrSV7WswwMN0uIBOIn0415rDVjHmUXIN8VZcvfVaobt7e3QtFjjZvqNMLG+
	 5u4hm7O44VLHPAsi0S+rnQmwv98A7jagAe18Cb1Qg7XwerJ2CMBO5W4P5PkUqQuC/yvac
	 eAlLtJk2NGGoy4Jz/Q5KLj2goxG325oaMR9SYX7HFBKIpoa1bVfmjZp43ax0LjMyRbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gMJQ6Au+;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4C606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E4C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gMJQ6Au+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792455489; x=1823991489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qQSvVGU58cMfc17bjArDyjCV/vLX3GaryaEWqjN28kw=;
  b=gMJQ6Au+qea6eIPc66bgepS/rj+13B6i0dhTxBjX+PcU5XrJAmnXkWrv
   QEnR8FYOLiLl8x5rWg4RO05O4v7bdl1DPFU1TRofKOtQh3KvrHrs+CJr3
   2Qybf3pTFHRrDqUEImIcj2HWhaYIk68wFDfkLnr9R5og9boFNy+Kezsa9
   YwKRwXw48UHJDaMr/6l4I/jri3W2cnrJEyk06K9xTc4SMcFkcgaSrg3MA
   ap6LqOUhEi10EeMiukGYKQ2kcKekkDcJkZ/YN71jEcJmmf3/4IOUJuND+
   x2FVLY2R5imPkXf7xykdFm2qd/Ei6TwjMjcb2Fi4TUXPFX9Zh3f2tw3v/
   g==;
X-CSE-ConnectionGUID: 3yz5EjA3SKqWbDQhbGYo/g==
X-CSE-MsgGUID: uIj4FCseR4uEpjxBytz96A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1155062"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1155062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:18:09 -0700
X-CSE-ConnectionGUID: 1D0atXplTROAaNGIHdNmJQ==
X-CSE-MsgGUID: iPIKrw3pRCmL3SvGc91Jew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2656797"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:18:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:18:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 17:18:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOM+i9S4XBTbQzq0ADiCnvFT/qbSN6PdF1V05EFiwkQq7NdP/2nHXSoc7Oe6EhV/BAvuqm7YBHjK9Rffj5b4STe4w12VumGO5QEncMkPunipSwzXaNJwi4BP1YjlPriIwJV6RcfVsG6OvJoIoSsoUcgi9cfpn1ezbF8mo8DhPoGT3LSUCDgfSfPlRTJHlrc9G0ZMFEh35FkhQScRrnagS9+USKbRQM5xNM1IlXVHGWl9nQvND1uHtUsocsDFbuFY8pSSPZkICYQwEiQ//n9nM3Dk/dPAIy+92h8wyTDq0WRLOEkeNnBhD81iuCh3nng3441/0BP3vgsIvCVULMtjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5Kd79V/WqGMODXzAuycKv9nCg7lNhcWduXl2v0HW9c=;
 b=Ju52n33nZgcRS6C+gHNBcAeL90JWJ0ByrXc+Px0ZUgbAxqJ5JdM8NMHo80SmkaFF9jR7MGrIPpeAQXfeDwNMb1hgJIKaz7w79kmqQD2qusOnQEFSg4f17fBKvegoktBMwHHo9gvJCBCOdOa/pWd9/43RFpVt3nUYRHyx8GdoE+a4YUS8bZIVTWDmZZUkxiQWZNn4pJEunLxyrJfcd2Vf5HrpQSWZjUTJrwwNCuspNiYMOqzlvLN1SSMq0QtuQO+GAQoiOV8iGRor5caaIztRL1gFXWe9BoLrqPuWFY45OOi44OZ7Zw1UH0bUs3eA052LWt8Lr0HS7XkYD5StRwQ5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by SA3PR11MB984635.namprd11.prod.outlook.com (2603:10b6:806:5a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:18:04 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:18:04 +0000
Message-ID: <388b2dd4-13ee-4377-8d99-39f56a77762c@intel.com>
Date: Mon, 19 Oct 2026 17:18:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 14/14] ice: don't clear in_use until HW clears
 ready bitmap
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-15-anthony.l.nguyen@intel.com>
 <179244085807.3135.9409141978116916415@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244085807.3135.9409141978116916415@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|SA3PR11MB984635:EE_
X-MS-Office365-Filtering-Correlation-Id: d708d5f1-89d9-49a4-4df4-08df2e3f9b9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|4143699003|261009223027099003|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: bjNqrEDkT8jPpJC2BXP5P+qaIFm77dS68oqZEeO2iC/dk6RBF1dCMImiLa4QELXGa6Dnn5L1T5nRJJ8G7v3s6m181439xiyIeKVkPmqn8j4dAbAHf/cKaZ0qX/C5JQdVeGSZ7fy1YQ6Usm3MHiKJRIrvYK445CSi62RVcZjy/DOGX/r+osRsLyt0+f0wXG9XbBVYISDqpT4j/R5VkyIfK3Aog10CH64KnkIHBo5dKWVyDvae20XGfE0rAqqn8/aIf9WLLviFkvraUUDh0ozvGQS6ehhaIPIBN53QfG5OGf4RXBxsHode27aG0f8398JRt7qAh+PPOPc5IXGOifpRFUAXWD6DqTysY5wjPfkujoSuEpantg47ELYKe+Skr4Nze1Z3a3G0fG3jBl0TG6iPtpvE9tBzoa7t7cuKTkPsgqt5OxzR846gKsJu+wWY0PXsqGVKGP477EpmH3U1Z6qX0sC8Ik9oHd2R5vY9+cfldn0a/LEuDk8QGzkVOr+ql1yDMKbpkTxxGykrSffvMeOXZ2M+sncT5UCvP+VihTRqun9kbnOWEMlRhgP1yptXofmKYpEN4y2Z2Eik/e0LGbe27TKCCqu3fJHWIVP9868FsTsJk8GjknrtwxR75LX0A5+I0lsGJdMCaerAodnC5aDiieQ1w2gROv+K0a4jDaJdAXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(4143699003)(261009223027099003)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU5YMFFjL2hpaEEyTXJaMGhseFI3a0Q4SWJFWXVKcFlRRDJ3NFZFWjdjMTAr?=
 =?utf-8?B?NFgzaUZoNUxDNkdHbUkxK0kyc0xFUXBxRGxtMlgwWnJwakg4TEhEMVJwUkRs?=
 =?utf-8?B?eFM4RUlYTENlSVhra3lMSkx2ZDRqS3M1WitoeXpzTEpkUVFETlFQZVdSb1dW?=
 =?utf-8?B?OFJCc0lXRG9SbjNrQmpJSklzaDN2MmExSTZERyt1WTVmVDJMK3pTMXBSM0FO?=
 =?utf-8?B?RkJjR1pobDZhRkVQbTVyZEEyLy92ZzVsaE5IeWFZdm53ek16SkhUbk55bHJN?=
 =?utf-8?B?VmQ1b0J3TW94VzErK2tVd1dzei9QeTE5bksxWFFHRHZoUkhPR0hxNkZLSVdY?=
 =?utf-8?B?V3FiYmdwalBNNDdCUkszK1E2UngvbDU0QWZPdGJNS0IzMG9JZWptVUVTMHky?=
 =?utf-8?B?VGF3eHdmYS84QnhOa25qQ1VOYzlBTzZHYVJBM3p2V2x6VXhGU2F5VE1DVWNT?=
 =?utf-8?B?VGVNSmJBWFNMNnc3S2hIRUFsR0JDak5mSWNEWlpha2VGSXJPK000NUhhM0NQ?=
 =?utf-8?B?OW5qSysrRDFQdHQyRHlqaGoxRGZiSEtpbjlhL1pobEgrZUJpT09QTHMxcXB0?=
 =?utf-8?B?WG5wZTVjZmtuOTdaYjF5RXE3enlFdFVmUHZMeXRiR3dWNmtNdkxLRlBVM2pi?=
 =?utf-8?B?cm4rb21Rc0duOGpOdXpaazI5VklHSEs4b1lkVVA2WmhnWVVWR1JjSEJmRXRi?=
 =?utf-8?B?UGZvMGk5SjdwUUh4UHJMakNCdXZrN2pMYkRLRXRidUhvNnNxL2VwOHhsWlZ6?=
 =?utf-8?B?WlpEbmgxQlN3MW5wWGo3cmNjM0FpQWJtMDdCVUdkWEJqOUtUSXZ6RzRGUytR?=
 =?utf-8?B?S0xabWV0Q2puVm5QNldyVmp0ZGMvREwrUzAyUlZaV1gxQnRlMlYvR1pKRmNx?=
 =?utf-8?B?a3Z2Z055d1EwNFN1dnlIcXVKclFMdmhNNCtSUy9QU3NPc3hYUk02MEpQOFZ4?=
 =?utf-8?B?dkF5d2xqZFpZUENrbmFYeWF5MWZDUzNxKzd2MW5xUGd3MlRXSUVtOFJUc3VW?=
 =?utf-8?B?TmlNV1AzK2J4Yml2bUZhZ3ErdUhHRzNJaE02cXh5UWdMV3hKYURQU1EzOUdT?=
 =?utf-8?B?QnJPTjNPa1p2NlREdHRaRitJRGVTM0ZubGRXeWE1Y3BHTGJlU292MXllbU1C?=
 =?utf-8?B?alpyMXdaYmZvWTdCK0xUeWI4QU9jS2RBV0tSVU92MGJOUzVsamRmS25XR3Nm?=
 =?utf-8?B?QkNmVFVpbDEwT1IreCt6T3AwRTlGemVsMTN0akF4ZDEzOEhYQ3dkWW85MUNH?=
 =?utf-8?B?U3NGQUF6RkFPLzYxRGJjSVdmc3FWczJkWVBkS2JNbzlHc0xPcTJNOEpTSCs1?=
 =?utf-8?B?S2xkUXVTT2s1ZDJMNEVxNXhIWnZlLzZXWmhUQlJmVHB1NmlPUUJuWW9NTmh0?=
 =?utf-8?B?TlhNN0Vkdy9qUUVrNlJNV2JicHNCbnRZUU1KMzlFV2tXSFRjdDFCMmsvOGwr?=
 =?utf-8?B?ZHNYcHRLQnB1QnB2OFZUWEI3Q2dpTytJVVp4NmN1WlBkcGhmZjRPMXl2eGVI?=
 =?utf-8?B?VkxBNUdiMDl1b2VUUTMvSVh3RGN1T3VYMjZXeGhZWEZEamhwSUk2VS9hRlN1?=
 =?utf-8?B?ZDBvQWpvOUVQRnZRUWVpTlNZMlBBWnNxSEswN2lpaExiTk50UFJOMVZxOVhk?=
 =?utf-8?B?aGQrTWYvK3EvZXhkYXlNcFVqS3NGYk1Wdm9VbFAwazhYUGtmTC91d0xpVFY1?=
 =?utf-8?B?aEtKelRNeVpVamRJcWJYblRiNVNQczI4bDZpVHltVitUb043ZlRJVWtrUlNu?=
 =?utf-8?B?MFhPVnV5dFBDS2ljeEdnQ1k2cm04Ylp5Z1J6TGVQWXpXRlQ0dTkvU2hoV3Rt?=
 =?utf-8?B?ODQzL2hHMFlCb3U3TDhoRWx4YW45d1A4UUg3S3FJeVJxajhiM1NQSCt4amJV?=
 =?utf-8?B?TXFPOS9WWm9mOEoydGhrMzloclY3V2loa1N3UUk4WGJnZ0k4K0VZSlB4Tkg5?=
 =?utf-8?B?MEZ1b0xVOXBsWEs1MlRndWNUZG5Sa2VuOXV4VDJxVFBhcUVnbkFNTFp3dFZr?=
 =?utf-8?B?eUxqY01TcmJ0Ym5nYkNiZ2lUY0tJZDJHYlUvNm5uVVpxdjRlVWRieDgyczc0?=
 =?utf-8?B?dU16UTVJY05wZDBUN2lTV0F0M25iT0VyRlFPblNiaFMyWCtRdS9JaGIwNXFE?=
 =?utf-8?B?aWVWVkdxUHNTSStDM0g0VG5wYXBXM2s4c0xvNVFldGZhZkVXV3VUVXZ2MDhZ?=
 =?utf-8?B?Z0FicUVQbEx4bnJsZGZNeXBCQXBlKzU2aVVNMHBQcGZFNC9QMHpNV1pLV2Rx?=
 =?utf-8?B?emhLV1ZHYVByeUlzWTZuVDNxdGhpcEhoc0RFdmhzRmF4c2s4ajBzenZqamVw?=
 =?utf-8?B?Q0FiWXZWbElnRjdYWVgxaFlVb1N0MGp4ZEZDa0ZnRmIyWW45V3dVZz09?=
X-Exchange-RoutingPolicyChecked: kUK+GQyx9PRACUV1uef4IlHL4teVblPOr8AO7cHbMW4eUzQLf6IXt7kMGYc9KVdrhsILlgrw/EtOXsaR9DGjM1Xvx0D21nfEwwsM9vDkZDB5neMtss0p7ZA43xXg5NWsUXenrK4oAu1nyEp1Fv67Vc7mIrcAWfHNegsMqMrktqtFaLjSRpGin4DRYLi2gbuD630RMoGD8+HZW7r/944ah+1g0jTZArtTF1c/01Feb97kOfYGxoqmMN+jMdzsv44wTvrWNKGTfbFzwempO7kqYXAdvvvEdfJW+2O6aHDfxtBBYtcyjJxptzXbJpzhmcByg3+f4YWDdprDkjGC93v2sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d708d5f1-89d9-49a4-4df4-08df2e3f9b9b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:18:04.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv8YHgvCGCAj+49c38noZIha5SNl31WYCUJhmmsy4rzMM7CxWYo+vcXJWvkoD01H36YgTy38GiBMbJhKJ5tRNOdBC2HuVGqLXIqe229IZUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB984635
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In ice_ptp_maybe_trigger_tx_interrupt()
>   (drivers/net/ethernet/intel/ice/ice_ptp.c), the patch now reads the…
> - [Medium] ice_ptp_flush_tx_tracker() now increments
>   pf->ptp.tx_hwtstamp_flushed on every flushed request, and also…
> - [Medium] The new 'ready bit not cleared' branch in
>   ice_ptp_process_tx_tstamp() decides based on PHY reads done without…
> - [Low] pf->ptp.tx_hwtstamp_timeouts now has two writers that are not
>   serialized against each other.
> 
> --
> 
> ice: don't clear in_use until HW clears ready bitmap
> 
> This commit re-reads the PHY Tx timestamp ready bitmap after each read in
> ice_ptp_process_tx_tstamp(). If the hardware did not clear the bit, the
> index stays locked and is marked stale. It also moves the timeout count to
> the point where the index is released, counts timeouts on flush, and moves
> the hardware ready bitmap check out of ice_ptp_tx_tstamps_pending() and
> into ice_ptp_maybe_trigger_tx_interrupt().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index a9658f859c2e8..74e0c0138c501 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -627,6 +622,27 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  		if (err && !drop_ts)
>>  			continue;
>>  
>> +		/* verify ready bit cleared */
>> +		if (tx->has_ready_bitmap) {
>> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
>> +			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
>> +				spin_lock_irqsave(&tx->lock, flags);
>> +				if (test_bit(idx, tx->in_use) &&
>> +				    !test_and_set_bit(idx, tx->stale))
>> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
>> +						ptp_port->port_num, phy_idx);
>> +				skb = tx->tstamps[idx].skb;
>> +				tx->tstamps[idx].skb = NULL;
>> +				spin_unlock_irqrestore(&tx->lock, flags);
>> +				/* Free the SKB immediately since we're never
>> +				 * going to report a timestamp for the stale
>> +				 * packet.
>> +				 */
>> +				dev_kfree_skb_any(skb);
>> +				continue;
>> +			}
>> +		}
> 
> [Severity: Medium]
> Can this branch mark a newer request in the same slot as stale and free
> its skb?
> 
> The decision here comes from ice_read_phy_tstamp() and the ready bitmap
> re-read. Neither is done under tx->lock. After the lock is taken, the only
> check is test_bit(idx, tx->in_use), and that check can't tell the original
> request from a new one that reused idx.
> 
> On E825, a link-up event can run this sequence while the IRQ thread sits
> between the re-read and spin_lock_irqsave():
> 
> ice_ptp_link_change()
>   ice_ptp_port_phy_restart()
>     ptp_port->tx.calibrating = true;
>     ice_ptp_flush_tx_tracker()   /* clears in_use[idx], frees skb */
>     ice_start_phy_timer_eth56g()
>     ptp_port->tx.calibrating = false;
> 
> ice_ptp_request_ts()
>     tx->tstamps[idx].start = jiffies;
>     tx->tstamps[idx].skb = skb_get(skb);
>     ...
>     clear_bit(idx, tx->stale);
>     smp_mb__before_atomic();
>     set_bit(idx, tx->in_use);
> 
> Nothing in that sequence waits for an IRQ thread that is already inside the
> loop. When the IRQ thread resumes, test_bit(idx, tx->in_use) returns true.
> It then sets stale[idx] and frees the new request's skb because of the old
> request's hardware state. The new packet's Tx timestamp is lost and
> skb_tstamp_tx() is never called for it.
> 
> The timing window is narrow, and the freed reference came from skb_get(),
> so this is a lost timestamp, not a memory safety issue. The existing
> skip_ts_read path has a similar check-then-act gap.
> 

Of course. The change to flush tracker was problematic afterall.
Reverting back to marking stale should fix it.

>>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
>>  
>>  		/* For PHYs which don't implement a proper timestamp ready
>> @@ -643,6 +659,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  			drop_ts = true;
>>  
>>  skip_ts_read:
>> +		if (timeout)
>> +			pf->ptp.tx_hwtstamp_timeouts++;
>> +
>>  		spin_lock_irqsave(&tx->lock, flags);
>>  		if (!tx->has_ready_bitmap && raw_tstamp)
>>  			tx->tstamps[idx].cached_tstamp = raw_tstamp;
> 
> [Severity: Low]
> Is the timeout counted here only when this path is the one that actually
> releases the index?
> 
> The increment happens before tx->lock is taken, and it doesn't check that
> in_use[idx] is still set. This patch also adds an increment of
> tx_hwtstamp_timeouts in ice_ptp_flush_tx_tracker(), under tx->lock.
> 
> On E82x/E825, ice_ptp_process_tx_tstamp() runs in the clock owner's misc
> IRQ thread without ps_lock. The flush can run at the same time from
> ice_ptp_port_phy_restart() (E825 link up), from
> ice_ptp_flush_all_tx_tracker() during reset, or from tracker release.
> 
> Here is one way it can happen:
> 
> 1. The IRQ thread sees a request that is older than 2 seconds with its
>    ready bit clear, sets timeout = true and jumps to skip_ts_read.
> 2. The flush takes tx->lock, increments tx_hwtstamp_timeouts and clears
>    in_use.
> 3. The IRQ thread increments tx_hwtstamp_timeouts again, and its
>    clear_bit() does nothing.
> 
> One request ends up counted twice. Also, a plain u32 increment from two
> CPUs can lose updates.
> 
> The commit message says:
> 
>   "This ensures that we don't double count timeouts or count them
>   prematurely."
> 
> Is that still true now that the flush path also increments this counter?
> 

I'm going to revert that flush change back which should address this.

> [ ... ]
> 
>> @@ -849,14 +869,20 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>>  			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
>>  
>>  		spin_lock_irqsave(&tx->lock, flags);
>> +
>> +		/* Count the number of Tx timestamps flushed */
>> +		pf->ptp.tx_hwtstamp_flushed++;
>> +
>> +		/* Also count timeouts if we flush a request that timed out */
>> +		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ))
>> +			pf->ptp.tx_hwtstamp_timeouts++;
>> +
> 
> [Severity: Medium]
> Doesn't this count one flushed request as both err and lost in the ethtool
> timestamping stats?
> 
> Both counters are incremented here for the same idx. ice_get_ts_stats()
> reports them as:
> 
> drivers/net/ethernet/intel/ice/ice_ethtool.c:ice_get_ts_stats() {
>     ...
> 	ts_stats->err = ptp->tx_hwtstamp_skipped +
> 			ptp->tx_hwtstamp_flushed +
> 			ptp->tx_hwtstamp_discarded;
> 	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
> }
> 
> The kernel-doc for struct ethtool_ts_stats in include/linux/ethtool.h says:
> 
>  * @err: Number of arbitrary timestamp generation error events that the
>  *	hardware encountered, exclusive of @lost statistics.
> 
> This patch lets stuck slots stay locked for well over 2 seconds, so the
> E825 link-up flush from ice_ptp_port_phy_restart() is likely to hit this
> case. Should tx_hwtstamp_flushed be skipped when the request is counted as
> a timeout?
> 
> A related detail: an index whose skb was already freed by the new
> stuck-ready-bit path still counts towards tx_hwtstamp_flushed, even though
> tx->tstamps[idx].skb is NULL. Is that intended?
> 
> [ ... ]
> 
>> @@ -3001,7 +3009,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  	    !ice_pf_src_tmr_owned(pf))
>>  		return;
>>  
>> -	if (ice_ptp_tx_tstamps_pending(pf, false)) {
>> +	ret = ice_check_phy_tx_tstamp_ready(hw);
>> +	if (ret < 0) {
>> +		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
>> +			ERR_PTR(ret));
>> +		/* Don't trigger an IRQ if we are unable to access the PHY */
>> +		return;
>> +	}
>> +
>> +	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
> 
> [Severity: Medium]
> Can this early return stop the watchdog from re-triggering the interrupt
> for ports that still have outstanding requests?
> 
> Before this patch, ice_ptp_tx_tstamps_pending(pf, false) checked the
> software in_use bitmaps first, and returned true whenever any request was
> outstanding. The hardware check only ran when software had nothing
> pending, and an error from it only turned off that hardware-only trigger.
> 
> Now the hardware read happens first. On E82x and E825
> (ICE_PTP_TX_INTERRUPT_ALL on the clock owner), ice_check_phy_tx_tstamp_ready()
> walks every quad or port and returns the first error it hits:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_check_phy_tx_tstamp_ready_eth56g() {
> 	for (port = 0; port < hw->ptp.num_lports; port++) {
> 		...
> 		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
> 		if (err)
> 			return err;
>     ...
> }
> 
> ice_check_phy_tx_tstamp_ready_e82x() does the same across quads.
> 
> As long as one PHY can't be read, the watchdog triggers no IRQ for any
> port. ice_ptp_process_tx_tstamp() is not re-run, so timed-out or stale
> slots on healthy ports are not reaped and a stalled hardware interrupt is
> not recovered.
> 
> This patch also stops the IRQ path from re-arming for stale entries and
> for link-down or calibrating trackers, which leaves the watchdog as the
> only fallback. The commit message also says PHY access errors can happen
> during the link transition window this patch targets. The commit message
> doesn't mention this ordering change.
> 
> The kernel-doc for ice_ptp_maybe_trigger_tx_interrupt() still says:
> 
>  * To avoid getting permanently stuck, periodically check if there is any
>  * outstanding timestamps or if the PHY has marked any index as ready.
> 
> Would it work to check ice_ptp_tx_tstamps_pending() first, and treat a
> hardware read error the same as no hardware-ready timestamps?
> 
>>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>>  
>>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 

I can try to order this better. In practice the thought I had was that
if we can't access the PHY anyways we shouldn't really be triggering an
IRQ since the only known paths for a failure to acecss PHY are because
the sideband queue is blocked which we don't really expect to be a
transient failure. However in principle there is nothing that guarantees
that...  Fine.

