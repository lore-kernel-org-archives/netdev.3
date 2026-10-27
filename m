Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793136964;
	b=jqTmhD1d8iERtbGTBBfFl7JqAztPNXuy+5k/lhiQXJYI3EZnUJ7jFumod5LnFPKFJMlE
	 yojAwKAtoP+mPQ3p5a9A5d4cGz7s7m1eApUTLJWGntHZ2AkVDJm7O8HG9F/4QJCHZMBD4
	 qmjZpvtuQt36SOmkYoLd8XTVm1SN+L3PhyDQoEgcrU1XWnd4dGb+E1OwAPY6NJM2rrivb
	 xkYlpkK4XeoPyBoRpfRo7tBzedSslaDPLPbs6KJQM7zrMksdoCPtXXog5U/e2Uvr60EWO
	 v4Z/LJQpcrkPhTX/659I7zPO4WwFZc37RNsFooBgx66Ohox2NUzdgaPxhSSPC5bhOgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136964;
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
	bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
	b=5sPh+pqCDiZdh1XOrHu+MDvelAi3Xjgk2WhxPiMBwTEHqy0hdFmtUx4nQMFxTxHY9FEP
	 s57qmJ3CgRMqNWRHUfz/Bpaczxh+AsKPmjl72cA5eUOGreql5tCJVLKl4nPT1HWpQMwcn
	 ZZNr023PJEyyxoAtgkEFjnxA/KWDry1vaTr3dVYiJeX+E2iCJWxB7ZUD0x1M+s7IUZ0P6
	 abDCJW8DrETFL1Bp3cvjmMjk7N/YOOle/k30ySnBxQXh/T9Ty4h8rDH/GQ4aQPqKp1hj2
	 aSipT1d9yEuSicSLD+ebgk1ud+pZD/cev7CW60OwnxWzO61A9+QHJknzIcJdXztclbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="g+C/tPVE";
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BA606A31D;
	Tue, 27 Oct 2026 21:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 244BA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g+C/tPVE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793136962; x=1824672962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vY8prbnK/akgtDVnE/KuzwfNNnBqA/C03JK47Ctpfsw=;
  b=g+C/tPVEtQnpKBa/ezAy4Jb59JWO0aUFQ3rv3tW01wR6M+eX7XLHY+iq
   n8nzXWpOIAuTwyCduViq3rmVKMxWst45sFuu6oSIXKCB/GyFS538ZL9Dt
   yhff/4MyNaRJPRTT1/IoTa5LO6Gt+07FhHidXd/kVCxNq8i0IikGwhe6G
   EnO011y+t06ZyaXMJyze/FegB9xHDieBhlzJz61SkYydHtIA7kWbzNIib
   AA9uCG2kra31xSAan+4G0dfZPg2VbtOR8Uf+N2i/i/Z2BXReAdUMyZSOH
   lUUbz1+n0Dx/bactZNDF6ZkKJe1tlZi23jR+VHVRr8BYo2D/lB1OdaxKD
   A==;
X-CSE-ConnectionGUID: IrHkHPIISESwG4u5AHr68Q==
X-CSE-MsgGUID: +ZRjLQIRTNij+k1qU5PVOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1850719"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1850719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:36:01 -0700
X-CSE-ConnectionGUID: tF/AEm2RTxqyf5SP+kCHSA==
X-CSE-MsgGUID: 7y+rO3Q8RO2HDfEesx9ioQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4712370"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:36:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:36:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 14:36:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tiyu2JAJsBChiE+d3gdiU+NfSqckVA2aRHgtmnc/zOitMWtmXDI4h8HmR/VQbWl1XIVMLbgZhTGxQ4Zz1Ro/j0+X30Y6N5Clq6/qTdMCMZaWl/bQ3KCA15wGoVU7Fv4WjsPt0+CAJi1P8k/wWCXUdbBc6nzF6Rx6OoEOmQxIUe6VtFHDgrzSX8iIWxaHeMhDrxze1zrFOO84t1kz9RRvliytTOzo0VvsG14hWma4v1P709susY+MHR0zYufESCOv8ZWtz83/u+jDpY86+wNZ0JyK36Q1TprlhWxYgOTggQw2fXWv3UMpGrht/7GdGhMwvFkuFTphW6X7t6nSSofECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
 b=rcrnp2c4ouCWsMq0g8tDli6tQd2YlYhkzBdEkw23N8jp240y3lCP4fRPlFP8IkCXAJa28D5mehENUy5ZqTgzJ5QBnkkvSqtMPlLx3aoACoDkE5oYbgSi5ATTL4S0RRPYHZ/17uDF9GZLhfooMhz88ZEQq7zEfSzvqlbUibPlRh3uDRBZrGttld39XkcU7Zx668lspaMeztSTH7BJw96qL4/mWEevov8RE1wCaxFWJdoRStVsKxwS6HgpalS4aFILh0VqBxf8b9nd8VkJo8564egcro5WLyVwCt61oBO01xLi5Rl2XebHX3+78Nf908ZGdvUHpkHwiG6vMcmtFPBUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH8PR11MB9458.namprd11.prod.outlook.com (2603:10b6:610:2bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:35:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:35:53 +0000
Message-ID: <f225d50e-fe71-4344-a88c-3c9e678a6211@intel.com>
Date: Tue, 27 Oct 2026 14:35:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ice: check the full PF reset polling limit
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH8PR11MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b27550-8005-467a-0cad-08df3472470b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|261022075727099003|261021123027099003|261021135927099003|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|22082099003|6133799003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 9tHdu//mm9DPgyomN6CNp3eTd5VRz/crnq9IG5LC/5jYePBofd+JwLTLz66cnSASKhTlGox2nAqAM/Tk8plG9zTcojdQncC/E1r9A1MJRKBRTiteTbyJKoC4m9pScQykNheelk0f74YFU5w/1xFRWS040tRr8wjOAWXjw8aHyzZrPcQEbAy1zK6Y+sEOnnLQ8lPc2+DcDIRHkuFh11C8sgMdWGIp6wB0rcngl1C1MB8UAPOtyMsBzywbQKNznhlatOuD+tjzOr6iRK5nwxJl5Hi02c3/rgrc7PRxUzK1FiDb5an8yGKJBC+nh5qLNzq7sr1Y2Zxk0/KlGt+tbnfBK15QhZ6GKbMvFbYyLX3rmQ8+KQwJtCd2c6oIOvLGaeXmkBiRKfFy6Tpt8p+6MmQ2eeFL9nWlGysvMdW+DgyvELtJW6RRCxuvYyBiiFHQdFV0kvAa+cvE8+K9p43o7DiIEKU7ig8PGDBf84dkOXWjx2zuafDWvdrWYwNAuvPnKlcOylcrhpd2/UQnCTGVZZ65NIDBcOGg4dfHTWqOjX3Tw8VrqZd09pOVvBl54PbwQ87KO+zxldYxcmeCrdCyecujlwpg7TpNd/miqvp8RiTbGgJNyGcLdV+/siYJq59or8CRPNeHftdUFy8Md3qldqNbcqmEE/gyLBuFPZ8O5K59xGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(261022075727099003)(261021123027099003)(261021135927099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(6133799003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXg3VUR4YlcrVXhzblZRVUZYR0cvSFFseVpSc2ZTYjBTMEpYeEZHdmkveHlC?=
 =?utf-8?B?U2NLWVJpTjc2SE44bEJQT2hVTmxEUFVLYTVpNnZLeVU5MTFoZHlXVjJwUldM?=
 =?utf-8?B?ZEdCSlhIKzQyLzRIQmtqTVViVGZ5MGdpY1kzaG5XR2FIUWtGQU9PSXBjY0dO?=
 =?utf-8?B?M2pZbm9kd1RJUXlEcmtGb0pWa1pONVN1VW5FZkZ5MHVJUWhyeERLWDQvME9T?=
 =?utf-8?B?TXkvZ3pDMDRtR2V5NlVSZHg0NmJnUmZDOTlPQ0JEWG0vL3pad1pPUlNBRDls?=
 =?utf-8?B?RGg4aG9vblNtRTJCZXhNRGJQZ1pKVXRGbm8xWUlobXRzM21waVVRVldVR0R1?=
 =?utf-8?B?cWNxMy9aQThrM1RvbzltSlp1VjB2a2xKZ2RRUlB3YTJRb2hlMTRnbjN3Z2VS?=
 =?utf-8?B?MEJDMTdZbi9waHhRUy81eGlNMkF3UjhEWWoyK3RmZnRjUUFKK2k4SEpFenVm?=
 =?utf-8?B?RXBybU9icVA3UVNrN1IzUFJzYktzbWlWL0JFMEllSzlEcFlYNTQ5TUQ1N2lB?=
 =?utf-8?B?SWNVUHArU2creW5wUFRSekdwU2dDSXZDTUIzdTNsWDArUkw1V1Axd3JhTlJl?=
 =?utf-8?B?UHlwTkJlTEFUUzdubkRXanhrdGpLVTY5ZHNQN05EaUtFNlg3WXF4NzhxV1d1?=
 =?utf-8?B?d21JRDgweERPdWJtWmxTc3YrMTNUbk9EUkpLaTJxenVwRDdCL0xZa2N3UGpX?=
 =?utf-8?B?azFIUmE3MEdjRHJXeDg0MHg0N0kwOVJMTEo5TVZXbkoxV2thaDhNK1RMUURW?=
 =?utf-8?B?c1M1ZWhpSlgrSVlONFh5MUtKOE1sSjkxVW9FQ2lxdHFFbGFVVzdoTzB2OXBh?=
 =?utf-8?B?aGttQ3JDU3JnbUY5WUU3cFh1TWRGOXRsU0tVK01yem9MbTNwN1J3Z3lqQ0FX?=
 =?utf-8?B?SVNKcm1MR25hOVBQR0hJMFFzanlxcENsb2p6aXZOZUpLaEVSMWdFcUsxcXR0?=
 =?utf-8?B?ckt6Z0dsdEdVR3ViQ3dLWFBTUUdINHVFTEJxUS9LRnl4YlZMWUo4elVGTVB0?=
 =?utf-8?B?SEJ1WHNISkpZeTNodStiYnJsT2FtWStxdXJVZDlsaUR0RGk0T2tJYXJpd1JG?=
 =?utf-8?B?dDJEWU1GV0F3ZW55NXJxN1lCV0R2N2crd2tJb2ZGZVUxdHlyYWVtNVZaMlVv?=
 =?utf-8?B?SDcwY3RSa283T3VzaUl0NWNuSjRJeHdPVEsrQnAvaXQ1bDBTbTk3cXhVNGk4?=
 =?utf-8?B?aGNxSTVHSGpteUs2MEppamozMENWYVpSYllOUzZJTGF3UFhZZWw1aUcwYUZj?=
 =?utf-8?B?OUpjekg4bVJOaWVlMnlZeEMvMjdBL0Vhb01hTVdCZkVKZEw0c1MzVis3dmFV?=
 =?utf-8?B?OUxFSUs2Ym5NVFp3R2cycmROTlZFOU85djd5amNFWkJzSFNsYUVzTXhTRHdR?=
 =?utf-8?B?U0NqZ1hWTXNxbkFJdnVjUW1DZE5ENXMwL1ZKd2IrZFZOSVEyQ05kemh1LzYr?=
 =?utf-8?B?SEE0cDdPYTYzNXMxazhZbzNpdkl2clR2QnhKbVNzQ0RRU2J4YzhmelFtTVlD?=
 =?utf-8?B?dTdJeCtoMGdNRWZBV2FQSEhPOUlDc1RwN2lITDl3UVc5aTJKTlMvQjJZZnZ3?=
 =?utf-8?B?bGNtOUJOb21ScnlXOG55NlV6M3lpS0R3RDZCWGZxK3ZwN0gySlFEM082Zng4?=
 =?utf-8?B?YkZkU2dkNjBlNWlaL0Z5VUNGN0NVNXYyaGJIUVZIejg2cGFNNGs3cmRoUEI0?=
 =?utf-8?B?NEVxcVFCakxjb2Z3b01qbVZaK2oyTjJnZ1UxSVRzVG9UQ2d4a0JWcktmdXc3?=
 =?utf-8?B?ZiszN1hKdG5za0hYa081MUVGcmx1Q2pFSXRTVHA5ODRmT1lFTkNZSWhPRXJr?=
 =?utf-8?B?ZDl6b3U3NldqT1pJd1JHdlNuMlNBS0ZDN1IrQWdwV292elhWVzdlVktFVWRq?=
 =?utf-8?B?eFplZlNpQnptOWM3clhTYXkxWERXSzFSTUN0dXlQZnNhM3Zwd1MrOHJTREg5?=
 =?utf-8?B?K2V2ZTVIeC9OYXcvOG5yL3doVkxhMUdRblVST1NaMHVrSTJNTzd5OWdtdzRx?=
 =?utf-8?B?SWtQTDBJODVqaEQyK09JS1lXcWtZS1RSY0lORTYyUlhMc0tZcGNFZmdCL1Bi?=
 =?utf-8?B?V0puaXhrNlVuMjhFUHNOc1JidVRTNHEyZE43UGs2M0FiZVJiV05QeWhsQ01T?=
 =?utf-8?B?ektkMnpLU20yTStXcjR3OW0zQXRCZVI4T0pwMVFOdk1Ga1FacEJhaWFQRDBz?=
 =?utf-8?B?RGNLRnJVRWZ3S3ZmK1FxWnFreTlhYzA5bDdBRFVnMlBYdUphZWJOT2oycXM2?=
 =?utf-8?B?OTF4eXk0dUswOVJGSzNFaTNoY3J2V2ovOUVTRG9GWlBCVUxCQjZJVXBnWXIw?=
 =?utf-8?B?Rmc5TW5EdEJxcWxUS0xCbFdSNUxCR21mclBla1FmWGJaTjBaOElMSFZ2c0ND?=
 =?utf-8?Q?ewojF/qdq0Rwi6GI=3D?=
X-Exchange-RoutingPolicyChecked: dkMBM57RXYTrhzJneF0Vej0SQjbC3hLQXd+rBEVLinF99yIbRfrAH7DfRhQq5KlAXtVMvGtPKcdrCrtY/wlKX50Vud2Cg/YgQpUDes65BeVHZsxoJ4/+uN63WzgbJF9VkxDxNlFECArcdTiyRxY3a45BsyWnkoIIwIKDletaCUm0HcygpXLGc8elcZ3x1BE8nUpEUqdRSy0hOVwjaQmnbi2aFwUKrqxIjN/rWxmIEl7dL+wuLd02kS84wMFlHN5VXci5AOjuhnh7Ks7QdFejal0ZiTjG6hZkOttn4ROkXTKtDpHUJLGKTX4euXgrZamjoxJkc18eGmB+SbfsYKe0KA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b27550-8005-467a-0cad-08df3472470b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:35:53.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y7X8o6ynJqSgbq/0U3mf/KZmsglmc46daTFeMqmexKFI0UYNrChuFRrf3wif0yEyJt5HoBJWlsDhjRSTl7Uyc4zkXG90BxmdymtEcf40cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9458
X-OriginatorOrg: intel.com

On 10/19/2026 3:51 AM, Aaron Ma wrote:
> The PF reset polling loop includes the Global Configuration Lock timeout
> in addition to the normal PF reset wait. Its timeout check still compares
> the iteration count against only the normal PF reset wait.
> 
> Consequently, exhausting the extended loop reports success while PFSWR
> is still set. A reset completing exactly at the old limit can instead
> report a false failure. Subsequent initialization must not proceed on
> the assumption that an unfinished reset succeeded.
> 
> Compare the count against the same bound used by the polling loop.
> 
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..82b803e74aac0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>  		mdelay(1);
>  	}
>  
> -	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +	if (cnt == ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT) {
>  		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
>  		return -EIO;
>  	}

This conflicts with
https://lore.kernel.org/intel-wired-lan/20261002130752.2597259-9-poros@redhat.com/
which is part of the series
https://lore.kernel.org/intel-wired-lan/20261002130752.2597259-1-poros@redhat.com/

I think Petr's fix is more complete, checking for the actual reset
status is more reliable than *either* the old or this check.

I'm rejecting just this one patch from the series and won't apply it. If
you need to rebase please exlude that fix in v2 or later and we'll carry
the better fix from Petr as it goes through the net tree.

Thanks,
Jake
