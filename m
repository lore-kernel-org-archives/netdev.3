Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792762522;
	b=r9w+lQ2e2sxOaM6P0cE4NoyEaisxTuJz6Legy85/j483hrkqVltJ2itY9nKDcEmWiczo
	 x9FTIFXTKFfbCJa14YZOqXZSg9S9ol8IcIBOaMXFTas/eXcC+NhgPvmLLVvztorZAnxwQ
	 ux/QazHPt+q1HQjL7IRZXmZw7eGdbpsMtvekS+xzYtooe90ozB4NPi9BWEaLySpw8GIaP
	 +KN89pAS7PzlV8WPYq02dJDGSwnavs2jfDeFYXsRNuABKOwNUZZMRv1yMSKoJTUA2ZaQC
	 s88ouW/Bk7NYwCO2JdxbSWruLv2UizgVbkxqDsgx6u6tx+4lNLa0bo8GjNcOylOnvpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762522;
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
	bh=8pmESVchCac0VravW0cWmY+ltZJOKQJUh0MHe+I9Elk=;
	b=WDJcKOg4LlFlRcYu6UYGZ3nZ0C64pXS3L606fIzgr02s12LWwoWZtxfuAPbnOePVh4Iy
	 g0Xnn47HyAdwaCqosNxSWarZBCV9e209GlK0B7fXkXV5ZD0ygLDIMLUYPcx9up6dslX6v
	 Yp4SVmqdywjo2TsemWuFum3WIeox0t0WldhVeYBT8Hk8yFvYoiUNRNKmxaSxNwWx7bGOi
	 LVadjsguLNo+465hZrAMb9KjrK1TE+wWdVlEG9bOfmnCBytT2jjvtBg8CGqS9RBYYRySq
	 3+Vo9GUg1Vn6oIDB1acO/A5jLBsIpFaLsyEkVQv0rr4b4vQX185xcjQDppJWB88Edyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a5GnIpc2;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9E606A335;
	Fri, 23 Oct 2026 13:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C9E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a5GnIpc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792762521; x=1824298521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kIc0MYycd5dFZwjESRlQj9NdauWMCWG3Oo53zxGkO48=;
  b=a5GnIpc2YZHlb6Ju86IZVEgYN4EanbNjqRLgffwQXY8rRQU4djtSNnWq
   w/txLSKRd4CP5xDIQxG1DB99W3a37qhL+SoeOT/GCY7XeOrF8un7GciHO
   ZJQa25VaSftEXxqiDHtI3b5BL48jcqh8sYkUyXOymcuTEhQBGRj0aEI2y
   CPHqU5HxN2jBt/8CzsrfF7SG84hcYLWvGqcDt6O+sM69QnYo2rqx5s5gG
   DPpRdvnP3hr9xCC98eC/X1AwLAzJdNMtdz7g9RZvPYg/MduWiThZ7UY//
   Ngpt2gM918Sktg7GSMqUmu20dv2Mg6WThj5rigDbOZsAmAk+8xa8i8V/I
   g==;
X-CSE-ConnectionGUID: GqledcW6QbGuFkZrOtUdJA==
X-CSE-MsgGUID: rhiYN60TRvi9NpfSjARMxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1527959"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1527959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:35:13 -0700
X-CSE-ConnectionGUID: 0V7S4hofTHCiptm8/GPliA==
X-CSE-MsgGUID: Rg7HNR3OSSeT5nSewlfaWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3758841"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:35:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:35:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:35:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XY04rsz8aMHvvWXndiAqM0/4Ywe6i+Pkbe9XQ5pqwYSL6apAUM3MXX0M4/PCK+7DwYvqoIeipxamMI1psxgSN1JVjWgI9/ASMO4fXjk1NyP0swWzSrY5hKuhgdykkrifKst/XhIkFFFawfmLZKfWuj+I5qxIOB4AgRMUclHZw0fRiIlPuF4iN3MRyTosH2J2UByzWqx8kpIloO68nOZNIMWOrGJ7AWqZudY5FLreYkTtB07OsdVT1GkKq6S4IBqaqVeSEEXOEHnaRsYAw3/NLJ1l4LF8CUXJwbBYu0jj1FrT3ym3Y0uiism1srXytRKzzz+wH3NajV51+Ig1vK6mjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pmESVchCac0VravW0cWmY+ltZJOKQJUh0MHe+I9Elk=;
 b=rc/w0mh+wcdh/VqMh2EqrgXDqaJM2Ay0FX6ac7JqP5rxr9qah0pFbxYxnVAQ/fMkOZtw9tZ/iVDP661p2osB7vN1t2kUlM3KT7qHz3NsMBPdFAYE/wamKixe4uhqTCs/XErT4I/Vp65vKPw3FZojKZRZB+Wou8miNz3AHoXGeryfNjnZ7Kp6NYvJtn8XC+3CC3ukcyBt+XCzULOx49aOc8D8xdCkjqivyhv9brEekI9p3Nbb8mdAQuFVQj7XfDHFPEJGuDj5MjhxX/hHB9FkVoxhqyHhRQ4/a5JsWsguHMdAXbHPJ0AJYsqR00/qMFselESnIhPwbXtwiPLIkuYbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 13:35:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 13:35:01 +0000
Message-ID: <90e0df20-126a-4429-83a7-77f95234cdd1@intel.com>
Date: Fri, 23 Oct 2026 15:34:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to
 specify allocation flags
To: Luigi Rizzo <lrizzo@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo
	<rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261019210604.2433620-1-lrizzo@google.com>
 <20261019210604.2433620-2-lrizzo@google.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20261019210604.2433620-2-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 02832984-a7cd-4608-ad0a-08df310a7002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|261021121427099003|6133799003|10067099003|22082099003|18002099003|261021123027099003|11063799006|261009223027099003|4143699003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: kXrVHF32OncGlZ0C3Q+Hk9qTELQm8G4g4UtrAIztHZta1QOqG6nBbfAejARjuIvCW3G70FVfR+wDkMZdYpFQpOB1zfVVwD3ngrQAWcIBXtQOMMn39MORlgWRKRNpnMBQ7ocIa8QEc6XYU203jpzL8FsG7Uxp/fSJsm5RUCbdohb/mVihlQhAuhGg/X/9SjHqmmHTMueclT/eatCh58ncBztIF7hVuOwPgkAMUvSPwg8M7MQv0C08EYffqt+ieF8iqejoOJzEBYFfFu2YHZmNIypmC1kDMoPr24ShLQdDKs+hLJe4CGuEMmeUljgypzOP6Mpgzbyvkg9UoqhqJUjyJ35saJ4ZOnC5twPbGjSazQ99ApCDSPGoHmgQtrNxvSltVo/5fxqxq98hEjNUia4YCtS63zS7jJz8vqbN5UIcRpNJsGM+ak4nvPs9kLBO3KJcVA0PGJKJXnEll2ywZLArBSVknYfYwwJWgTRq6oLm3mQyaLJIO+nGAWqM/eZxVz4DG9BlImchj/ELyT2zZAjv7bBZY8Y1/YEANUbd1HApmaGXB6dgVmTheYVVqyoG37+382KB/OzYCwm/WVRINUShzc5wskRfyYZLNJMFRxhkIJ7c1HpAAW1yrr25VbluB7VADAmnq1cE5TZR/wDWQWF+yiXH46+aUXZ9YKr8Xv0KFNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(261021121427099003)(6133799003)(10067099003)(22082099003)(18002099003)(261021123027099003)(11063799006)(261009223027099003)(4143699003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGoxblowUWF4dXFFSGxwZy81MW5TazdTM3UwM3NGR3NVWjA5SSsyRFhRTnJo?=
 =?utf-8?B?MWtWT1ZDWnA4SEhMK1pGeGtyZU9FQ0kxMkFEQjljaUJFSU9xQkZuNHV6dFZu?=
 =?utf-8?B?Uml0R1J1c2FCY0p1dE9tOEg2ZDBXVzdPeHFzWlhZd0s3VFlLTHdVbVB0aGta?=
 =?utf-8?B?RW0xakE3VWswVTRqNHBpcjNaSlh4TSs4Ty9PTDFxZ1V5U3ZnUEFEU1EwVUlF?=
 =?utf-8?B?bFJ1Uld3Ym5uZTF4RnN2YXN1TDN1TGNGRVppT1RVVEgrc0dJQ1kwZ1NxTzZG?=
 =?utf-8?B?Nks1NisrVGo5L1dLK3ZBZUR2cXhwcWh5RG5Mc3doNlVrL3B6cHNVazFBeDBM?=
 =?utf-8?B?bldvTVpzVWFHZ2NabmdWOVc4NXQwK09MZ09oSjducFdwWFpZbFV3NVMxVmdj?=
 =?utf-8?B?SjRjcWl0Y1R6bDFBWDlaRmljTWc2cHlOQnA5NHhqYnRvYTZLZU42TU1Nb1Ix?=
 =?utf-8?B?Q2pKQ2ZBQ3BMNG93am5sTnVRczJUcHV4Q3AwTGxNdGRFQ3AxOS90SlVYWXVU?=
 =?utf-8?B?UlNGOHpjN0JjKzhHVDhjd3UwYWorNXVPRXh0WUl1M1NBOHU1cWFKNzc2VlI5?=
 =?utf-8?B?cGFlY0NPRGRWNWo5Q25CbnV3aUVmeHUzMlE2WXZST3Z5aXZydzl4bmpYUU1I?=
 =?utf-8?B?WWk0Tnh2Vml0czJudm1oVkJwNG5qcEcrMUdxWTFmZ1Bnekk3dXdsN1hGb2Y3?=
 =?utf-8?B?OFBldnhFYTV0bVFLNWxFRUN0cjZESWo0Y08zVFE4amR0ZXBuYmxtdkNQU2Q5?=
 =?utf-8?B?MlMxM2x2a2tCcDdXdTdrYk9EbUxiTlE4a1l2NHBBS2RLQkRmaDA0WnJ4bXVl?=
 =?utf-8?B?MXRLbUpDbW1YWDA2MW5LY01mL3Q2NnVCUWE4eXVnY0JlR0RUWFF5bTNNTEFT?=
 =?utf-8?B?R2dRQ2RpalNwVFNsa016S1BnNlpsTGtsTHpGYnRRc2hUSFB5WnlsdVZERDZM?=
 =?utf-8?B?M2drSkdpbmdBejUreGpyWEx4R1BYNVZxMTRUWWQ2dnhCeEFGelFoVVhVRnlo?=
 =?utf-8?B?b3Z5ZkRrb2FvWEhoS0xYOHRJcExHcTdQRm5STmpYdGVqZWk1dTBPRGExNWJi?=
 =?utf-8?B?SFNCVnR1Tm56NTJwM0FwQmZnaG00Ry8raUltTTRuSVV4aTJYcTZOenNSYTBT?=
 =?utf-8?B?OUZvQUtkUE5Fa2FqRWxMMWdPR3FjZExVdWdDbDI4Ykw2SVFCMXh2YUVBWVpv?=
 =?utf-8?B?UG95SlBwUUdwRTUwZzJxTjdSSVhCRTRhanVoY091bk9XeDBBcEJlSlg0L2RP?=
 =?utf-8?B?UGRSUmRkbk9TbkZTM3kvSWVVZ1JVMWt6RzNVZ0J5Vk5lVEJzVE9ZVTBlVEVr?=
 =?utf-8?B?UlpsTGtTL0lFRkNMcm9SaXJoY1AwcDRwT0w3azR2YjdjdlB3YWQxR3hKVXVr?=
 =?utf-8?B?WjI3K0tiQUJybkxyaUdSbHIvV2t0UFJVSThZQUtOSkRVVCtwNFJZckIrT2Zv?=
 =?utf-8?B?U3Mza3BiMVgrUFViYTlVOXZpcU1YbERjZXpyRitmUTZvNEQySXBxdy9HMHNY?=
 =?utf-8?B?am1KS3lLMnl6L1dMaFMwUjVQRmd5SVZsWmQ3V0lEUnBSUDNSY1g5ZEphQS8z?=
 =?utf-8?B?SnZHSkpBOThzUFRZTnRNOEVNcDl5WVNydjNPVkEzT1J0VzZkeEZMbU0rOWxL?=
 =?utf-8?B?OVJHdFJGdnY2WkNHOUdqcGpmc0JkTml2QzdvRlRtRzM4TzBZRWIybTl4dnFK?=
 =?utf-8?B?ay8rT2g5aFpQSlZHNlFWeldhSzFRSllFY1NsQjQrb0xCUkllL2w2OHJudm4x?=
 =?utf-8?B?OVdRN2VJVEh0QXA3WTVUNE5LUVlnNHRheEJJSGp4UWxMMFdrZ3hLSFZ0ZzBz?=
 =?utf-8?B?S0ZCZmpSaWptRElFK0Vuclc1VHNYZDF5eU42bTRxc0hvcElQTkU2Uk14QXkz?=
 =?utf-8?B?UzAvZlg0ZFVVaGJLQlUybXVrZ2paQUxSU0tPd0E2N1pScWFSV20xOEJwckhm?=
 =?utf-8?B?cEhvZHVUTHRNRkszcXpVaW54MzVKVlBlVTNSMkJ3M0RJS0FFUm9SUmdRRnhx?=
 =?utf-8?B?a29YSU10aTVlZHNCdzYxdEF5a2tPaVlDaGRDTWtoRWplLzdBKzRjcmpucVJB?=
 =?utf-8?B?UU1PR3VHUDF0dTFWZ0VaOHpDc0E3WXJkaEdSNXNWUDIxUXByV0tTV3dPUXA0?=
 =?utf-8?B?NzB2WFg2VDBSR0V0VHJtZ011VDlnT1orZUVhb0Q0UzdCYUdYWDBUWjRqc1pM?=
 =?utf-8?B?ajNkUVNpdVhDOGVtN0hlWER0YWQ5WGdLcjhpYXR0NStsODFzR2lTUXFyQlJO?=
 =?utf-8?B?bXNpUGdXcUZCaWkzb3pJU2Z5VWh6VGxZYityWERDaVRraXhJcU1FQjh6QlJq?=
 =?utf-8?B?d3FLeSs1aU5VV25YcThjQjJmakxJVThJTDRaU09PRmMxSy9MRUR2U0tCbThZ?=
 =?utf-8?Q?y6qkqufEuZv4i9C4=3D?=
X-Exchange-RoutingPolicyChecked: dg5UVUqQU9hGrv+zSP2Wptq1xiYAZpnkPLvU8NIqgoGnEzEPH09CtVCamNJwgdNsR/PCwXnfSdvdrq/6aViLlv7+k2VFIiwKZDiHPbDkn/Tn7igamuvchIW0puhZogrme/KO1bBI0xj//dxjSjE2acJQlx/Ro+qj90nTsAY0PYFkWC3AoD490Rl6dVe10oFy7dV0HlpcaKLNTVIa1fzqD61BByA5fwhqdZtLqsFr0nYiZ1rJufr783mFhDWmvZGHPBSMULRsxwW05jYgVLOGdhpTEaeTx9tjmfSTb+/oD4BXg1PvnS1CEQW3WspZ4eaUU92RoiThxmDAdPXYeope0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02832984-a7cd-4608-ad0a-08df310a7002
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:35:01.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdXZqQ7oWxb8YkNQBTEqqwloIiR6QlDqnsE9YVRFNzDMbWbBGuyjaIS4a5bMu92qDRYemS6fFrAvw77G9xO4mlgXFHdedVcOEj5IeGqgQw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com

From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 19 Oct 2026 21:06:03 +0000

> libeth_rx_alloc() calls page_pool_dev_alloc_netmem(), which always
> allocates with GFP_ATOMIC | __GFP_NOWARN. Drivers also use it to fill
> their Rx rings at open or on queue reconfiguration, which runs in
> process context before the queues' NAPI is enabled. There, the caller
> may sleep and GFP_ATOMIC is needlessly restrictive: it can neither
> reclaim nor compact, while the initial fill can allocate tens of
> thousands of buffers across all queues.
> 
> Add libeth_rx_alloc_gfp(), which takes a gfp_t parameter and passes
> gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
> libeth_rx_alloc() its GFP_ATOMIC wrapper.

If you'd really like to go ahead (I'm still not really convinced, even
with "O(100k)" which is not that realistic), here's a couple style
wishes from me:

> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  include/net/libeth/rx.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index 0e736846c5e8a..14a528ea8a075 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -96,20 +96,23 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
>  void libeth_rx_fq_destroy(struct libeth_fq *fq);
>  
>  /**
> - * libeth_rx_alloc - allocate a new Rx buffer
> + * libeth_rx_alloc_gfp - allocate a new Rx buffer
>   * @fq: fill queue to allocate for
>   * @i: index of the buffer within the queue
> + * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
> + *	 initial fill of the ring), GFP_ATOMIC from NAPI
>   *
>   * Return: DMA address to be passed to HW for Rx on successful allocation,
>   * ```DMA_MAPPING_ERROR``` otherwise.
>   */
> -static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
> +static inline dma_addr_t libeth_rx_alloc_gfp(const struct libeth_fq_fp *fq,
> +					     u32 i, gfp_t gfp)

Mayb just __libeth_rx_alloc()?

>  {
>  	struct libeth_fqe *buf = &fq->fqes[i];
>  
>  	buf->truesize = fq->truesize;
> -	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
> -						 &buf->truesize);
> +	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
> +					     &buf->truesize, gfp | __GFP_NOWARN);

And here I'd also place the gfp argument on a separate line.

>  	if (unlikely(!buf->netmem))
>  		return DMA_MAPPING_ERROR;
>  
> @@ -117,6 +120,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
>  	       fq->pp->p.offset;
>  }
>  
> +/**
> + * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
> + * @fq: fill queue to allocate for
> + * @i: index of the buffer within the queue
> + *
> + * Return: as libeth_rx_alloc_gfp().
> + */
> +static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
> +{
> +	return libeth_rx_alloc_gfp(fq, i, GFP_ATOMIC);
> +}
> +
>  void libeth_rx_recycle_slow(netmem_ref netmem);
>  
>  /**

Thanks,
Olek
