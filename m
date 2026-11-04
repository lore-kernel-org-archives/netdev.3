Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793826753;
	b=EWF0Gj4enX8k6wM/MuYEFomuH1EMO4clGgval1VTkJXk3zwU2Uj8BZXB0o2aO2Re40hV
	 qUAXdXTh3andj9C0WSV6+QM62BfqxxVW7+Y3PzVRstDU/BVW6u3enwm5lsUE+TMdAa60P
	 DqfSCBhuVjJo76gJc7kiuikUQjl7HotIGSEYpj24RyJfLtb0UWS1DoqQAJSrwY7WRiTBH
	 JQLBhbAj7SyOQK8HBIMfU0NvRHf7Qtvq4p0OEn/9dAZk9GmFtL+Ro2X/NgvomoCpbbGfx
	 L3pl7OXG9sdW5DUsMTXvsyniM8qXylx24Pwc2deLMSUlZGMoflBZLJ5V+qPwRbqh6Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826753;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=AQ01f9dWgIRHL2SkSLZ7YMu3VzHcd9nN2lOyzjdUY5M=;
	b=woQ9AZi+FU4pzdGT4+A8sQQPyj5fs6TPImmJJR2vDnBgOyJ9UzwPZelw+jrUyk2recdq
	 orpPkllPKXxAHChhixaK/5dSi9u7DOfisE+NOnfBdicjNer2YmSPp1xV+z7NLL7PezWds
	 /KbHc/Jr1QMi/n663zOgd8bhZGTyrFB7vGVGiOlJB8cSSQsq2NXK139xUoR6QkhvPQbMV
	 I4Z/Jg9YYWF7wVWmlEH+6O/dJ8h04Gwzc/B19eUwt6or5y8r7HCuJjNy7XKcUWkNKc1gF
	 TwdU47OGjvcNqXfmSfNrqDLLgTR48tfTZOqT4eJDnBOhfgPU7jKlsXiqhYWWsdk7U5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Bk9e/aV9";
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28560A5BD7;
	Wed,  4 Nov 2026 21:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A28560A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bk9e/aV9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793826752; x=1825362752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oaCcUKjc+PrSYU/IEiy/0jg7kJEDowOrrhZ7lIPCcvA=;
  b=Bk9e/aV9C4ncpq4BXTHLDMg8klBK2Vd50FKzDWh71k6toDMZOAWjmpZ8
   sgomaNT6c9jKFbNYKE+XlRFfTLIt5XrL56Ub8DahlzXNnua0otx6pWNRd
   luCzBLQy5POoXsJ7F1w8A6ibfwz5Ar+tua9CcixWgPGFAqLkQsOVciQPe
   jjB0z/pkDRqqY/Ehr4ZzOWsCLSrK4sztnkDmX2KRdIeMUHsINYmbfjEwF
   E7OPq67pRznmfMG9OQeEbkQthWoAMDHxw4OUVaHjTSlx+m+3kLxHcgUFL
   +83Yq7gYUHpZkJ4GltRVH1Gj4EzWglGzEZXbjO0sj+aGoGYxC0Kpaqhd9
   g==;
X-CSE-ConnectionGUID: GwIxkvP4Q86Sv7Fa14/rIw==
X-CSE-MsgGUID: wVnWPSiRTFi837AoIwRmcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2627994"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2627994"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:12:31 -0800
X-CSE-ConnectionGUID: K7bZ2WeGSpOrYPNZUnZPbg==
X-CSE-MsgGUID: 2j8eSEvaSEuJ/b3qRxUHdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7180847"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:12:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:12:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:12:29 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:12:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO6j+nrH6BjiLcAkpKgqUuQdYUeYZUYhC8TNa6PwPbLkCzaoQJL16xPVr1yDe3ZmLBK4KtGE+1cyA7rqaBxzWNuXiQG+pMWCUXB2S1F3+a8Zv9hHQ23HehDYdFC6U5FGH5/ABDf9aIJDFVJMOs5F3YfjK61WdtsjPJ7+4F2r+A9Qkq2Sqn8A0BJCQIG4TFcvooli7jYQZjDMG8FlkDeJVG8jD9TnRW6sY9Yttj0BLOdbD8k2dMdkdgDXxe96rxsAS7knZDxBOgg0QvlZe4hs89P3jqltiHNrzH5SLQex5IOTDCNaN0zaL62WuhMSRJ5o2N9jLMteOPtEwrUBwm/FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ01f9dWgIRHL2SkSLZ7YMu3VzHcd9nN2lOyzjdUY5M=;
 b=j/E6wgHHqtcQSqEM4GKy2J35xREY76ZOrx9PoWlqPG+HcuhaDlX4QbiDRj0DKMFhgMLnpzt8Gg2LNiyODor0hlTKneE1cyDm3bj9OaBdujXvMeyPKsx1YqghI3vBYNHN7KJE/ZKLmxj5sCaAyebAFHxhsmYn1jih/jdps4pxUB75NyacYQQOtRGiI7N2M5BwOqbKQCEA9AS4Cvz9cNxEfiqt6hU28uWjgayiQ7UKqYv6s0yn1go0cTE5FZgrB6av1XYlgVwf7yjX0z7z6PK3K+X6lrlXquP9BwCFCooZNFC1l2VlVEHVOKdFM33axofBZgeSb7aDzkpqMnU83eyejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:12:28 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:12:27 +0000
Message-ID: <7e19829c-92ea-4128-aeea-efbf179010a8@intel.com>
Date: Wed, 4 Nov 2026 13:12:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, James Clark
	<jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261104052504.1886335-1-jjc@jclark.com>
 <7c4eec6a-66a1-478e-8d9c-15394061b8da@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <7c4eec6a-66a1-478e-8d9c-15394061b8da@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: da5bcfd7-3614-4db6-ce3e-08df3ab85351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|261022075727099003|261021121427099003|261026121527099003|261102123227099003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: qcKP25dlZuG7g9iPiHlxV4uUjqPeb9hnRWwc64SWgbVdCAbuBJ4ucIzwU0smmOpIoX4G69MX7fGSlO+S62yJJaVndq7g6bqblUhIZOjLvof9L7lgBDg0a0+2TECjfjMHs66NSjVBvl+7lrFznnQNAZEcMZ0TMGJmK2YB/iWtqYPRCKhMtnSYqxS50u7dPthvrgejXWyU4dA+x+GwtNWwz0Au0EygwiZiGW4izI6W8Ex0+th1nT7ONGlOS2POdkVAJvObjITtm8j1poo+Sod6F2qkSK7ykfy/D4QNgr3kLeZbNl5UWeSRbJfgMlAPrHES5iKnxOjnz9vZ3prapYCHe5zSR77XLMcCNqXWddioqSb8eHPzvR8cLUTSXJ9G5rb8AlkTrTq8N+8uLar0A1YzpNFwvsaUZuu0PTaagdr+BVHClot+myjQM+r4VU08wyAzA/5UEQ5osuxtTmB7bswycvixTsf9CLjg1SH6yTt+P8VhCS4J9eLm2mEs9v47sBvKd5rOTvm9mMobZwRA1+DZ+mNLf9FKaDL4/1IzgtqjTrSgnqumab7+KaxX5yNDm22TjSW9eR2VHsMPNIXXgYX7/5p7bebUP9oQko1jbAHnTfXRk5WTDK6nU+lYKIhQRyG4iPqYOQ/lnZ0RcrRSti9gNndLvMdiif/f0dH4gnWwprc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENQTmx0dktaUk5VVW1kMG01a2pQRjNFZWNscm8zSkVjdi9mSHNSVjNzTWto?=
 =?utf-8?B?c1JkWlBIWkE2WU80S0NsWE1CZlE3ZHBML0pOTzZ1NVRkT2t3Mkd2Z1c0SzB2?=
 =?utf-8?B?K0Q1MDlwQ2xQWnF2U1J2RVhJNnBIbW5kUW00dnlxT1dyZ0ZIcDlYYnRSMjdh?=
 =?utf-8?B?Ti9tcGtORU9LdEw1Wkc1dDZDUStFYnlMeG9EczlJWWVRUjlkTHNWWTZEOEwr?=
 =?utf-8?B?WUtvemZWbFFGaVZaRm15b0poRWJCQUJQZDVzc09OYmtKOXU2bWxPR1ZvNWs1?=
 =?utf-8?B?TGlFMklsNlIyZVkxVnkxMzcrTnRMQmZjUUl6OXBzS2Z4YURNRWFnRk11RXlS?=
 =?utf-8?B?dnphN29nUU9SdkUwUHMyczI3Y2FsN3RacEw5c0RYZ3lBTjFSTWJlc245U05Y?=
 =?utf-8?B?emZiOEtIaFF4MUtOaEFzWWxmN2lRRlNyWlFIVlArak1FZEVqbThkOGpjL1Bp?=
 =?utf-8?B?aDFleVUzOWJUSXBYUi9seGtXL3Bvc3FrZUtVdGQrMTZEQVo4OHRWcjlsT2k0?=
 =?utf-8?B?KzVSdFhuR1Y4QVNycmxBVS9uTFVaU1Q0cTRleFVuM3E3Vk9VN1Y4Qlp1N0RN?=
 =?utf-8?B?aGMwRFhXRXdKbEFMdkkweSsxYjZRZDlvN0IzdGxPbFNLWHBlejJZU3ZHVlJo?=
 =?utf-8?B?TGFndFBZQUQ3WGp2VjNtL0xsb1lJWnl6a0VyVENyMVp0SmJJOHU2QWlHcDVa?=
 =?utf-8?B?RU0rZnJjWXpYRjZEZEZQWVdBTzZwcWZvQkRXSyt0T0tQbXk0ZEpHaUJxMm90?=
 =?utf-8?B?RTRiSm5mSnJnd3IreE44T3ZCeG10eUJSSnpLWFNwOTRPNG9XcTdXVHhxSFI5?=
 =?utf-8?B?K2ZrNVB3d1h2MkJJQ3hneVdJczNJaW05cThBMlRvYmJzWlphWWhZVGIwY2Zl?=
 =?utf-8?B?UysxVml5NzBrdG1mTW1RZS9wbFhucFVUd1VTTXBnNkZ3elFKbTdGMW9SVnB3?=
 =?utf-8?B?YjZuYnlmUEVISUFXMXFxWWYzNjlZMWl4UWJ4eWlSZTA2enA4ZXNQQVVGbjZG?=
 =?utf-8?B?MzRYR3FjSkx1bVJLdDJFYStuaU9IcmMwT1hBSHE0QTliZ1FlZHdmcU9sWHRr?=
 =?utf-8?B?cVBNa04vdHoyWXV2aGd3V25GRXhuQ1Y3VG5MaGNJMVVtNXZ2T2ZaRDFiSHJF?=
 =?utf-8?B?WDJXRHcyUUR4dGJTZER0Q1RmaWVaRUNNVUNLS0ZxSHdqSGZlMmV5S3VQQkdy?=
 =?utf-8?B?MFh1M3B1RFMrUjVZa2xQOWVQQUE1K2lGZUNzM0pRT0xJdXBaai9wUGRyOS9J?=
 =?utf-8?B?MEFzTlFMOUVrazNNQzVLMkM0NlVvam9UbWlvWllmazM3MzZlM2ZzLzFZWDVh?=
 =?utf-8?B?OE5Fc0FnMVo4ckRLT2VRTkxLbGk2bmVMKzlERy9SN0Vlb3BWTG9hbmRoeWhD?=
 =?utf-8?B?YXlDR0p1V1pnQWg2VFNIVVpLVVBXZDJVMjVuRGdSOGp5ZXp4aHFwUEwxdHda?=
 =?utf-8?B?RkJkTXpiQnZUcVczN1h6anNmYklOdFUxNjltMmYyTVRUNmZVdU1SeEkrdHBx?=
 =?utf-8?B?d0Job21xaWczcGZGbFdEbWNHVU5ocHpVMGc4L3FyVUp2cXBDek9PYnRvMkpG?=
 =?utf-8?B?djY1ck1TYlJuZ2o1ZVJESWNSa2RhdE5XT0gzaDhuWjkveDQvRjZKNjBzMXND?=
 =?utf-8?B?Q2dmb2VBQ1hDMGtUbVJhRDJxODRPam1SQSsybll3VE1QRy8zWk84RDJSN3Jx?=
 =?utf-8?B?bGRaMWpMdVFoT0hmbHR1RExEd2tRdlRVZXNrc3lpdGR1aW01YmhFQ1p1SVlG?=
 =?utf-8?B?b1JqUTA4ekgvRGZnTkxNckJUVnpiZ2xqSHBHZWFxN08wS00vSkdVK1h4Mk5E?=
 =?utf-8?B?dSt1ZDdtY2QzZzNDaXNMUUlISW95VDJPTzFJakNyZkFDa1U3ek5qbTF2VlRH?=
 =?utf-8?B?OWlXb2tteG45M2ZPQnR4R2FScUcyNDZHUkw3TnFrVm4zSVgrcTIrdUtmbnpU?=
 =?utf-8?B?aG8waTJmYkp4ZVAvMzByZU16K0ZSd1B4cU9ueG51YUxVUjBMdXY1STh2Y3ds?=
 =?utf-8?B?NysyWGpQZTNjZDhrZzBTT0E1ZDFHQ1NhZWRZUzV5R3p2enBSSXRPWUx1UnIw?=
 =?utf-8?B?bFA2ZW9NTlR0WDUxMFUyUm9RaGRQU1dYb01zSjZydW45c21OekVjYmZlSjlK?=
 =?utf-8?B?S3BMN2ZqazVXU2x5azk2NXBEUTVpVHdYNjNva0pteVV2TTZXbEJHa2I4NEd5?=
 =?utf-8?B?VEY0VFUvQWN1clgzamlVYURoNURCNm5CMzdTcEhZMkZZWDBEOTNrakhCNmta?=
 =?utf-8?B?d0p3Y1daOS95Wk1wRkNhc2l6cFFZWTZVQ0JRYXA5b3htU1B2Y1Z5SzhWWVBK?=
 =?utf-8?B?R1RjZmRoQ2FaSEFPRXRpbFdGMGt1OEVCdXFKRDVsY3BJNEZqUkY3Vm9tclN3?=
 =?utf-8?Q?AdsKNyJcUHXYLc5Q=3D?=
X-Exchange-RoutingPolicyChecked: Yafy77NwGG7YX4MMqzW7z4Sok8dGiTAHNpiIVDB7ODKc63uM9QnHCPOWzmO7Ecnu5e2F0ZQRM5OPTULnHXr8cc0Uiucvjjp01e89O1tgt4ehaVUJ0Q/681MvaM0/fsH7qgAoJeTJZzR/29W/C3qY9m5z6BB6nteVpi9rqREVOvEcqbhxKAHr1o1552Ughr3Wgsv0gTWXlaz8sKcdP2zTRAXHluj8nbQXDZioA/SsTMdygnBqk9/YzZKejg+QXQBpkBAoUh753vE790q0A2mYv5ZYdl+Q3PCo43PVtekgDFqNXZ794ZT2z2p8EVsozQ5/blokOybVNJHp0q/ByY4lSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: da5bcfd7-3614-4db6-ce3e-08df3ab85351
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:12:26.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rxYk0HkOXr6UZFBYjcevQxTCe41q241wZ+oLxHfU2dwR+ElJ9v1pWGpqBtdfUAfwfYDi0MeFseMRCtt0+w26CUQn2RfYkqJnG1YNF79kUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com

On 11/4/2026 12:58 AM, Maxime Chevallier wrote:
>> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: James Clark <jjc@jclark.com>
> 
> funny this wasn't noticed before, this looks good to me :)
> 

A lot of programs still use the older PTP_EXTTS_REQUEST ioctl which is
permissive and doesn't enforce the edge request, so i suspect a lot of
software just doesn't trigger this.

> I've tested this on cyclone V, stm32mp157 and imx8mp,
> 

Great, thanks!

> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Thanks,
> 
> Maxime
> 
>> ---
>> I used an LLM coding assistant to help prepare this patch.
>>
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> index a37405534beb..31a66e855d6b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> @@ -277,6 +277,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
>>  	.n_per_out = 0, /* will be overwritten in stmmac_ptp_register */
>>  	.n_pins = 0,
>>  	.pps = 0,
>> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>>  	.adjfine = stmmac_adjust_freq,
>>  	.adjtime = stmmac_adjust_time,
>>  	.gettimex64 = stmmac_get_timex,
>> @@ -294,6 +295,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
>>  	.n_per_out = 0,
>>  	.n_pins = 0,
>>  	.pps = 0,
>> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>>  	.adjfine = stmmac_adjust_freq,
>>  	.adjtime = stmmac_adjust_time,
>>  	.gettimex64 = stmmac_get_timex,
> 

