Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792594641;
	b=QCRuzxjjpcBeyBESBwX2ph0ZzKTdCaUn59lkzns4GQ+/2pCMX0OorOvSd9+LdtwE/mNG
	 YS7ZVV7KQ+MClf0mEmjNB1yqZBaFCarMxJBu4o79tpq5boTFvWtBh8z5KDnHEQOLLk4bK
	 uK4VDbD3tC4F2C16MPSMob/03QV9atMgL4l9dxqoTIPzXIAJ4+u7Tm2KQOdQ+tUf84LbN
	 DmBHKf6aYDzu6bAisazasQjwae0ehY52mFOZm8QaZgTHj8tRPkuiAxifkfuK+9hqETGE0
	 CFwbfMPXW67gS/702u6HJbgDp2QsDqF0SFUWaEDuMrIfZf6ctlMWdmDn8Z+BqBFKl4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594641;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
	b=Y/zmIIOVhiYGOM1oh0DLK9zb9s5wKAc9nNE7i/m3PSmMkMZyz7NM1LnD8WgbEgMettzz
	 Rp2lI87WczK+MexTFOTkCy0j1lHOOb5FyCy6cPuak48YoVBl3DBwmgfnML3gXk5GmJDnT
	 qko3xq8aRgZ/wSbeGDn3ePJPpDrpuXboM7uYwqup2rn9+lz1xhWkNTPn40KbmK/hIUhM9
	 UqLZ0ezd5o5yaPjaqKkq2/+vxj0y0V+fe6YoRqPT2NmVuY60OCKN5XFmJKW8eLIpwWATl
	 tDn7+f2255tl7cCbCX42FPOEjO84QuHSzfpNKRmORYd0m6DYP2G2bKQJZ2Jrs0pxHzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RS/KCTgr";
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A1606A31B;
	Wed, 21 Oct 2026 14:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E9A1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RS/KCTgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792594640; x=1824130640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=12ZJVmNOUMJ2Woq0j3ZKjo956VMFI0S7dN0zuh6+wQ0=;
  b=RS/KCTgr7lBI8gOY/N3dPR+LyktgfKapH6yuazzaHRFwL3rRqF2twdXn
   nP5GhbYuWmVHBOqnLgocrriMhESP8m+JfrLrdNqlV/o6EkWkmzr5F+stD
   PxyItuvjXtFwfxJJkEqhu80wspPHhBB4GwEoxjfhzmQQP9qvhVpuGidZt
   I/qaoXti2paw8KJOqjrK/f0uetLzYjfTGlLs2MIgIT7JTIk2H7i2ckwdR
   rWD0N1pBi5bLtr52B8Jocp6UPCIVcj5ayiPtLZEVvaqgHSDQO4ASTHyYE
   dlhZ4AhOC+GglYDBc9VkZfCxMmTTCkeNrPtrK6r4r50jTO7Avaynbyvgj
   g==;
X-CSE-ConnectionGUID: /pgrfxD3QaaXG0BrszteRw==
X-CSE-MsgGUID: 8vMc39SjSLO9sRPNJ3yTEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1194891"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1194891"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:57:20 -0700
X-CSE-ConnectionGUID: tIjKDqQvR7i73AsWwtoEEA==
X-CSE-MsgGUID: mG8KKfgPSXmmtbfyrgp0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3053103"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:57:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:57:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 07:57:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZfWBHSSr7MD/uhoDp8a/cTRltr/VRYJHWK+rLxvQMDUmINiT4BvZGwKuDEUtLPY2dotSyckO71hFpbIE3oepv1aafuqzIEt5MwBy6DGe05Qiu0Qf5OmQC0HcDvc+cmG3DPVLAzwKwfi86jthnvSmM5Tgu565eE0rq8jrcytu6MRKE3yIpSEvgGS0kyve7wlvuwW2MuPf7AvDjekTdNCQqlsY10vxONZ3juy1Nao6076uwFPidwHmD4sRp0xEKrRJIzNKCB1NyyvPSaiiiGN5T5FwFWL0CbJ3OHjCK3JQ4mIdA3ePYRJW6Mx+8yVjBZyuNXRi5QIs9dFsKCiGN9bkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7Pl2inO9IpqkhssPOglP1H/b0sEfirJlvBcRbOzkR4=;
 b=jflMSmyyIlWdFz1BpzLNKu+KIw4JMwivKsSvQKzaylQ7KZrRaVTiynGI+hASnAd84Df+muhmLb7u5s5F0R17vZMpICoUCV2wxSxH3/bvY7t2+/3IT5h2Sz8G0hkts/zVOmeoFGOMdWB3q51wq0Q7Gs9BsBY8kaEqOao7TTum6BmRcXnUPHnawZ/41+KWt3SScYHjKyNzb02aV/GVvKUGxEGLF0HFfh+gjilXQSt5aesjfj0zpYntMB/uDXUDgd4YQs9hisvZ2RjYA1TnJFckEHS9stIYZccj3m9CeE3NfWkxsMSilr/rBjuKBBozbJ7jNM+fqs87ra/Ta2LZq1iOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB395573.namprd11.prod.outlook.com (2603:10b6:610:362::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 14:57:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0496.021; Wed, 21 Oct 2026
 14:57:12 +0000
Message-ID: <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
Date: Wed, 21 Oct 2026 16:57:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
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
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB395573:EE_
X-MS-Office365-Filtering-Correlation-Id: 660156ab-36f3-49a0-a2b3-08df2f839647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XrkqiYP5LLrLZ7qUwPpNQqu0J9h1u6BDptcD2rPDOXzaqLOZtLPp7v8CXQkVBCEUD1GbChBaclBrSQcI9XEp5lhf3mtgB4aiFf+vYdGqb6D+Eb2xSN0Wx4QsWg+0+juHvb8PxowQPVaIUB1BFiYwaJWGVmBUdqNha6F5+/YHVYBs2eEkSgWN6rjuTBcXmj0wCvYz024KpZ7kNZQRcSCinXGuWE8c3yE5APuQ82nGgsKaAqILpRhuFROsal6Xg/J7MX655T7l++9Vc6RCs4x9q4aGUvLSqkHf4CslMkKRawe/XsVJHPnyUn6lXXQPC03ahqz+7os90R3RBmFP3JQHm1eYgPeCk6NV0Ggt9UbXBQUpuhMKzRcfi/RwcrkOSL2QBUmO/ZCVnqNiWUYNbBG22wFcqUAaHJr5jD0L9jLfSzauXrbwy6R4pUrIYNpiInW2DQP89gZpq41KfsaB8ERGmT/mmNa4iOcPQbEilQLtZIVyXI2QgFnzHrvRuPkmSfrxQoZHjy9uOGriOM78/oj3fKrpgS3RzMq7TlO6EXYpK/A2p05g8qcVVTqbzJWfhLWD6JbmOSeEt2GAXHVQgsWHkysT6fhw/bnq9/P6iU5U56lOjP2DjgdH5X+BCaViIfDq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZ4ejdubkxEU2pOdlFvbG93ZU0rQjZSdUhwY3lZQnNFeHhVNlp6aStadkcw?=
 =?utf-8?B?SnMyaytLdUhoY29NT3VGUHJqNXFlV2JicVdFNDA0alBlVXpCZmp0WnNWQUtY?=
 =?utf-8?B?dG4vZlNIVGZjZHZROFVENDN2ZTEzcHV1aitMbndQdk5kWHFRYUxURWs0QmVF?=
 =?utf-8?B?U3pCUFNKM01JbUpSampMam9yRGlpZXBhMlZ2OU05K2hOeThQYlpYVW03amMr?=
 =?utf-8?B?Ymt4cWl0VWdONTlpYlRWaGlobTlQaXpwQjN6WDUwbC9GR2EvaE1sa2VWVWM1?=
 =?utf-8?B?bWZGUUFzYWNmSHFZZXpob2hTSVJXSkZpa05YbnZFVDd3VkVSbVRGb2RUZ002?=
 =?utf-8?B?RFBid0dNaU95SVJSaVIwMTlkRmh2UHRGL0JNRGsxYTNLeGthVlduMGhjU2pO?=
 =?utf-8?B?Y3h1N2pFRjdreThWdklzdEZON1diRUdxYXpiaERVSnVaRXhUWm44c0gwaVlH?=
 =?utf-8?B?d3ZkSm11Y04wS21xVWlMMzFUU2h1SFcxeGdEbDFqNjNIb1A3N245Y1FkeCt0?=
 =?utf-8?B?TWZPQjhtMW9XWGlIazdCTHRwSGhyVTdSdHlNZ2t1VWR0a2QxeVJMQnZEYWdJ?=
 =?utf-8?B?NGltRkdGZVFVVFBPeXZmb3h6OFBJc0pxL2xXeUViVTltOTE0VmYzaDA0RW4z?=
 =?utf-8?B?bTNqK2YzWU4yYW5QcDdkdXEySnR2dE5UQmRKVGVwc0ZRaU1sK2x6a1BpN2lJ?=
 =?utf-8?B?cXpkdUVmbnhrVGRvc0M5ZmEwSVNDQlpjenBSbnNrYWtuYmI2OStXdGNLdDVz?=
 =?utf-8?B?Wm44RXUzQVZYdjJnRUU5TWFOOWsyRXNtM3ZySGZEU0JscEZyVXMzV0hDNG5p?=
 =?utf-8?B?R1p2RHlxWmhuQ244Z01VamIvTk92SnNVUjNSbkNuNDdKam9wMFlpQ0d6aERs?=
 =?utf-8?B?NmYrNk9SMG90ZTk0WC9YRzF1cGQ1dk5vSU5GRDB4NnpZSEtNS0FQZjRqWHhw?=
 =?utf-8?B?QVpGWHVZOTkzQW5CWHpKS05jK2RHanlBVWNUUXpzRVFDS01GZlJ6eU5lc0l1?=
 =?utf-8?B?VnVZLzQzZS9WdW1YOFMzTkxUVXdXWm01K0hBMEhQTWpEMkcyLzlrazJTTmN2?=
 =?utf-8?B?b2QwUXBLRm1YS0tPUlJxMFMwL0FBZDdQVTM3SThsWHNXNlU2V1Z1K1lTdnEy?=
 =?utf-8?B?TEJTbnVvd1BhODR1N0wvT2E5aFhvQnFqNUYyaTlKaXRmVy9jREtVaEpMRWl3?=
 =?utf-8?B?YUw5L0lrNHhVSUVsN1N5THEreUtjZGFGYnB4a2tEb29GSkM3SGM1NjhJbGNE?=
 =?utf-8?B?NFJxWis5cUhrUjEvWVRkSXpVMmpsUEd5bFVFVFQrQUZTQzRnaW9pMy9RVTBW?=
 =?utf-8?B?REFVMnBmYmpGb3pENmk5N1ZHRUxwQ1dkeFFxTEE1bWhGcmFiekxZVjlWanFp?=
 =?utf-8?B?U0hQdzAwVHo0MTdmQW84WWtNcjRoVVA5ei8vOWlNWHhPaHFzWER1N01XTDBz?=
 =?utf-8?B?THlKNXpEVHBibnRFNHFtbnZrMkc2TTRDeEU5WWVxRVp6QUJRVXN4cEwxNzB6?=
 =?utf-8?B?NWpEVWN5NUVFUDUxamkzZ0hGR0JtcEJpcHZsTmhDSXF1MXEzRWliRVlFYXNu?=
 =?utf-8?B?SzVuZXVPVjZhRmFxZDJmZFdJUWk1bHN4a1E3YkFnNjZEbS9mNnJnV3JVS0Mv?=
 =?utf-8?B?RERvQldTaEhvTC9OOVNPY2dvd3UxbzBQK3RoUjQwVG9UYVFyYWFEZzJHWE9q?=
 =?utf-8?B?dGEzblpUY0p4d04rNytLSC9USXM3eUxjbGZLVVB1bEpldGhKVUhDc3Y0Vmha?=
 =?utf-8?B?RFEwOEZuSDZKc3ZMb2hHeFppeHd1cEFrWklPT0Z3ZDRRQ1NIdzNzcUdxSzFm?=
 =?utf-8?B?VkpEOU5xNTlyVHlFK3BZYnBFZitqM09FTVJEWUJHODNDV3VaNTdTcy9uSWoz?=
 =?utf-8?B?SkIrdnZQUENsRi8vZm1jWURnSmlDUVF6L0pkUDJiS1Z5dnVQVEJlMmYzdytY?=
 =?utf-8?B?aWk4M1Npc1hJS0loZHRERHd2cncrVzFkaUpxZUplWVQ1bmVHOUhLUVBYSVB2?=
 =?utf-8?B?SHdMaXV3UWhFSGsrVGxiRm54ZVdYZis3Z0pMQUdzMm4rOFcwV3BWM21wa08z?=
 =?utf-8?B?blZoVkNZL1RUa3pmNkQzSklSUC9YN1pIRWxQQnZ2NnpDMWN6b0FjTW5WNVM4?=
 =?utf-8?B?Ylp1c2lTR0tEZmE1MDNEZ1V3Ym8wRm9rS1ZhcTdmZEFQWm9ONkF3MWJ2ZEdq?=
 =?utf-8?B?WXZiTktUeDhzWTFnckJLMUFESE8zZDhHczZ2M2czcnFQQWV2ako0TktqZ1g0?=
 =?utf-8?B?WmM5c1ZFazFEcDVYaWlKN2x2LytWK3lvWnNvOVlVM2JRWXNRVTZkek5sQkZk?=
 =?utf-8?B?OVM5OVNYWThNRlBiOHFYQ0JmRllySEd2elpvSERmUzRTRHNwTUZJRkxkbGg0?=
 =?utf-8?Q?v8+dnLA0OGud6TSU=3D?=
X-Exchange-RoutingPolicyChecked: 5C7ih9J6LNIv8wuIP7lFMqXmiuM37CzfZZw3/PGeAOB0gRbXcWrE/lNlzWH+FHDTDY1nfmH8XhV2AbmdW9PcJPpMO7QVq8/k2HOhEc+bvluVZ6d0XGMcZk1fSZoX9eFrZ7KPopAk4OV5/Q+9r1Ah+DUWUACCYoCVbCVPvmWh8Skgatlt4vbJM5GXp4mKgVnL3+Hk/3fBzXehUY6KImgacgLc6+WkdIXt12NxzElXKv40/iGICzOov84dzUFYpjGZy4ZjBqWeRVlxNfn5bxM5D7ChpBZ74p7jkIs0PhFpVtz6z7EEN9fVgP9RyCI9iNBUge9jsEmraO3O44vgcdUWtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 660156ab-36f3-49a0-a2b3-08df2f839647
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:57:12.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA+UnsLjeEOFvs5CTaxEPNenuUJIenhICtDD7r4uAFvqW476fzm6CLGYA0NtwL8R7zPixg8b9J1npNlwRmyiGj+2ziYnx+kbv0wTCiKPPvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB395573
X-OriginatorOrg: intel.com

From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 19 Oct 2026 21:06:02 +0000

> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> driver fills its Rx rings at open or on queue reconfiguration. That
> fill runs in process context, right after page_pool_create() and before
> the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> needlessly restrictive there: it can neither reclaim nor compact, while
> the initial fill can allocate tens of thousands of buffers across all
> queues.
> 
> Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
> libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> to GFP_KERNEL.

This is done for simplicity and performance reasons (although I've just
realized that this helper is fully inline, so it will inline your new
GFP argument as well).

But could anyone explain me why the initial fill is bad to do with
GFP_ATOMIC?

> 
> v2:
>   - split into two patches (libeth helper and idpf consumer)
> v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/
> 
> Luigi Rizzo (2):
>   libeth: add libeth_rx_alloc_gfp() to specify allocation flags
>   idpf: use GFP_KERNEL for the initial Rx ring fill
> 
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
>  include/net/libeth/rx.h                       | 23 +++++++++++++++----
>  4 files changed, 30 insertions(+), 11 deletions(-)

Thanks,
Olek
