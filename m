Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793886167;
	b=5T6KSY1hbCIegJoGGXsJnJjt8cqx6m6PWFnBHbzUSyLQuP+5TdJBhtVHd8aZ4ILanUqt
	 S3jJuQ8is5axNpqX2I7mJFITkb4kfYCvZSmJfwMH0H14HqivybEr/5Iss4T5JEeSm0XIQ
	 Q+Do+UacOTjz5J+Pm0oxwTpWoCYFpPR/HlJeSK6C9KgSE5RnoQZJHoLp8NA5PqXv/4uFV
	 JW5pu7oDy0QPWlBy46CnWo1f1J99RrKjd55MgNUUOwSFPt3Nvqo7eKYYqGRACwnNbwvN7
	 ylaihltro69xkZHlMNfbAmdNArXuFjGNNvaw3joo+aa8hmb1EFKZv8TXIe7BN/XXnag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886167;
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
	bh=VThW3QDag265+3p9RysvcC0bjTLj33B0Jy/GwrxzoVA=;
	b=uHItNb+elTP+7QYaJVAYqjNLwMpJTe5lfxHIPsLfsH6qahEwCM4HD7LSoPXk3iOefC0P
	 b2DdcYJtfUZ50iHe6OVBFAGXuiSwGKZQn/Bw8BbE2PQmoKOJ+gmOOVOiQpjSD8cx2IN70
	 hAVGfGhof38hh9GJwcAXbYgjnH+maoQCf734DQCJHvJmgsovUp1MW5ZUNrlAJDC5d867G
	 Dn0Cyhe226EZt/+aoIPRzC/m4hNTbiFX3pdibnxr4wB4TXvLAHXXpR57Th3q3w64ZwZ3H
	 NbBjxUAXD8nFU29TQJnlN5U1lGNogT0BvI6RIsm2/yl3ZtRrumN/E3Bw/MI24KFsIXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="PxgX8/Q8";
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19908606A326;
	Thu,  5 Nov 2026 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19908606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PxgX8/Q8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793886166; x=1825422166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=03NnAcxvlEW+hrLznacVloR7tHwXEPsJVOZciofxJxY=;
  b=PxgX8/Q8vmI37G37AHKxZQc38g6lhVAH3trVDiApbUTkA1rwQFPV8QEy
   eHMgJsaCjtINIjq9LP6N9Hsjr9kHohYuByMlQxe9AsRPxZvfCgxNvdL4O
   Ac//OaK/QxtQPm85rC4ZhpvtRn8KYvtRrfJr7T67baPrSSyQaTUkJ36fe
   hZlITTR8ARJC4G31Gu6zGqNIfAZWMf3nUciAXnatS6wGd2cxIuKtP3/kL
   FnH9mgK3jFvnRkEo864E0CHVF2hG0ZwqecfInyPX9SiLc8QhOellYyERd
   52nqwTkQn7mj4WVWmV7JeTNDinj0xoYVwJzvdFM6LVOLgNiqjmCP7gh/k
   w==;
X-CSE-ConnectionGUID: u7E4Ti2AQruXy8bZOQOsqw==
X-CSE-MsgGUID: 65Yw0GR1R3q57dldv7OQaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2666155"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2666155"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:42:45 -0800
X-CSE-ConnectionGUID: ttxrB7IlTqOJLF5EXVwvbw==
X-CSE-MsgGUID: sVczVtDWQCajant0fa6TLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7176641"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:42:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:42:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 05:42:44 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 05:42:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCoakJb6ksjA6vMzvv/wCXtX6Pt//OeFxhkam0y96g+gEx/Wc5qvGbefHh0xjhLb1OpT2QCu9tjPoVSUjUro+SIIC/8A2aEE11mMzjy//tflUvhjzfaJMxW66NxhRZYZ3JJUoSgH42JC1MbtKF9iyj6gOD8tOjnKEBO8ChSiDHR5bpl/HkjEtCHNng6yCnUwtz3rmtaVQnccN33I2oQRHaUuKJ5Jwvpg9SLvrJl5Gg8Zki4pDinBoQNnSgd9mYBapjV1gqSUvj1ROMyDarrXqTr5aVugJLv71xj9nHSO6gPLpbRA3bGFuX34HVuBgdE+WjoPkjDG9ACkrRPq01oBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VThW3QDag265+3p9RysvcC0bjTLj33B0Jy/GwrxzoVA=;
 b=geXNwXU+e6uDF6h8GgW5Q1vkn8EP/qbvEVE8R1tBI7iBUnCBu+Mwm398j5+Iqe1lKsO2k0MEWRsIpDEMSftD3Kg+r9gvrG1oQMkghqhZyUEDCFyIUfH1UyZQbeRCojjszvySOY9JPgWJHCbeyncbTRjpmVT1sAsk0OdAviFYRUOZSWuVIH/YnqeqiifMW4Uy51yKVQRgTZ++dVxguNOYJocdjXIz2l0cnnZkYFqRZ86FEIjqShdSDuYkqjGV9m0WbrJxXPIL4PJRCE6zVsJcrwB8nANcGAEJLq9MMtG60ODACToFV6sYozVupaQZQlSuaP7tL+KUrNK9AjVKz/JShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:42:36 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:42:36 +0000
Message-ID: <a0d74537-a397-4e3e-b77b-38ef2b9cd194@intel.com>
Date: Thu, 5 Nov 2026 14:49:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ixgbe: make EEPROM init_params() return void
To: Ingyu Jang <ingyujang25@korea.ac.kr>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261101234725.1414173-1-ingyujang25@korea.ac.kr>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261101234725.1414173-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f83a57-7f2f-422b-3c2e-08df3b42a6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261021123027099003|261022105027099003|11063799006|56012099006|261009223027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4+bLq4ktXcwinpxHMdfNt/zfLOWB4IbXPhNj2OWTiPD6t1dbTqdAVNH2NWg6jxOBLjWNup4CJHKaWWMsQi7bimfj633GvGsNI9SxHFzwAhwM+DN6Xc8pPCT89s3XffK9euYH3mDl65Wh+ER3XJHpFJJ20NKuOKQqUmKzrInoqDdCGbWS/9VJPhfE1dvZbqJixCyGiYtL1s+p9nFrdftk+Ztp2TiSbPepmhMyZOp6QUwY3LOPfLoWpXgz8l45QCrMgCwImOymrbRwrFOUjT2FWn9EEJXggSAiZzY/71Eqdpga3sbtymYf+DzjP05vMrDLyEy6giahMMCxkg3defEHmN+NLQ2S40eREeHul9yGhdBvk1sBXBoWJATz4dKavTnPVqkgI5X7+bVttrDN3PzywNN2tVBu3lzQIHwxv2/EoFklYod0812f5wtSgjgwsZArjzj4shGUW0ySpXPoOskcvvg6oFHr6vmJV8pO9hV2EViMtNn+SrGRsfBKpPOxjDIDnFIm6GDhxfye6HFkKHXAYOvgDonP/jNxOexOs93s0lUqjtI9f9V2GZmYCfPHnkxPAp9Xeph5HzmqkUIkMvM2Zk06nU5N9cQg5pXOT7dsBYZnKWWesivAzDhPxmIDrWQu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261022105027099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhvSjNNaG5hdmlQVzNHTUtQSGNsMkpnZmlIYmtwRUpmMyt3d0xDelp0TGt3?=
 =?utf-8?B?Skd0R0dCV1NHeWtGQUhiaE5OWTRoTittMVgwNVBiaDE5SSs3TzV0UXZGVmJ4?=
 =?utf-8?B?MytXS2ZSd2hZbks1eGFYdDFLS09VTWJjUldCNW9taTQxVG4wRlVKOHhDMHdz?=
 =?utf-8?B?bkdrdEd1T3RHT21aOWJHQzVRVitwOXhtQzh0TUc1QzIzL1pMK01tZXp6bzJX?=
 =?utf-8?B?ZEdOTzdlK01CKzNqTVZRL1BUNlFkSjFQSXAyUU53aFNmSitMQldXUUVIWHN4?=
 =?utf-8?B?TTR2SURjWlRwNXYrdldwYys3MUJ6TC9NZGFVQUo3R2dzMktzTzBqOEMwOUJK?=
 =?utf-8?B?RzlGb3A2WTcxcG9JbHlGMksrZnpkOTFzT0VrSWtGK1BCV05KL0Ntdi9ORGxn?=
 =?utf-8?B?a21lMUExUnB3aTRlYmE5VFAwYTJ6RHphOVNtOWlqNUhvT2d2ZkU1VzBtL0t5?=
 =?utf-8?B?WkdTL1NGdU9qRUhWY09HbExYOTh4d1F3RkhWcGNhTWd6aFNjU1V0SHJUcVhN?=
 =?utf-8?B?alRkNVV3dWNuRVZJUlZnN0NMK2Z1eHBVY0lvM2xtc1RtU1FQZHBCaEhaV0Qw?=
 =?utf-8?B?UE9nQmlXVjVDS1puaFgwSHY2b3JwOGtYcWJGeFhidU5MTE9pNVRkSVYwN2gw?=
 =?utf-8?B?ejgwLytoYUpOSW1yOTBkNGwwd3hPRktiRWEzekdPSlFxemN5MDlRNHdRUGFv?=
 =?utf-8?B?cEQ1eGxWNnJQbi9sTi8vVVdlK2p3QURpVHBKYjVOQ3RkVjdsK2ljRVNUT0NP?=
 =?utf-8?B?UEdoekYwN1ZqaEJwQjUxZFVadU9XYktqL2sreTFTNzA2bzgyQXFEN1AxNWRK?=
 =?utf-8?B?dHdBQXZVRU43UEFqb0hDWVFQT2N0ck0vbmhkcjk3QzYwUnpTZ0prY2R5OTJK?=
 =?utf-8?B?UFJjNm9PaWZSUXB3MUgyNFhKb3Ezb0dTbnJDWWxUWUkzN3RMVElxN1dKeEdG?=
 =?utf-8?B?NmRJUG5sTGdsQmFkTi9xOUxGaDNPSGxJWXRWbC9xQWljOFB0QnBaTGxINC9q?=
 =?utf-8?B?YVpBUER1WTU1VnVidTk1Sm11R2RlYXBheXhiOWx0UmloL0tCRGlrRnFxdDVP?=
 =?utf-8?B?QWYxT0Mzc0ZDUEc4UklWWnpIL3NLaS9Wb0YrYjBKbHZvQUVxS09PTTZSSi8r?=
 =?utf-8?B?YnVoQ3A0SGpxK2M2NlRCalRKdkdUYW5mYkdjUVMzWWNpMXpFTzFVWFhwVjU3?=
 =?utf-8?B?NGRXOVpkRGhIbTV0Yk9ZOUs0bVlpa09DVEtqeVF6emp6bXdEeHViditGSUtI?=
 =?utf-8?B?S3FZS2hjYVVPdlQ2d3lIRytoUHFneldCZkc0VSszUCttRTdoUi9lRVRxY0hJ?=
 =?utf-8?B?anIxYmk2NUlid0w1a3hheFpRT1dXRWoxSUZlK1FVbGZFRHZNRlM4bjY2SWhs?=
 =?utf-8?B?WlE3WElnNzJkNk9ZczFCbTRwd0p0b1N1MGs2dW1FSk1VRFlsTU9qMTZ1M3hS?=
 =?utf-8?B?bkpFKy91Ymk3TGZrckU5d1RBY0xERE5EelptYnF2YU5JcW9jRU1CNWErdGFX?=
 =?utf-8?B?OXY3Z0FsV29yS3UzRzdxRkU0dGN2bE9hVUd4T2RnSHU5eE1uUFpuaEtWT1FX?=
 =?utf-8?B?cThuaklmM0h0RWlJNE1sU1l2VlFRR3RBWTBFMGgrWDRINUJuZlcvdjR0bkoz?=
 =?utf-8?B?V0VJL3RJa3NRM1lUZUE1b09Da0JkemlGclpYZVZCeFBKZC95UFU2Nng0SEdH?=
 =?utf-8?B?UmY5MEdQbmdrNmNueFp2SGZqc3NUc0VQOGNiTW8yRE9zNkMxaUtCT2dCazMw?=
 =?utf-8?B?WnBIek90akh5OFpLWUY2SllYaW8yM2ttR0U2V2drVWE2ZHZRWThYSGY3b2lU?=
 =?utf-8?B?bldsMjc4ZGt0TVd4WGlXZFU4enhVUTRwdUlWemhLUVA4dmtSNkNBOE5tVW80?=
 =?utf-8?B?bkxWeG1jNHFPVmdwNkFlRG1ROHdZK2UwOFdjWWpFa3ZHZm5DR0J2dmJWUVdW?=
 =?utf-8?B?U3RBVEtrdlJldkVPVGNtOFlUZVVjdlNGM2FkZjFjYkt3SlJIamxPK09vRy9s?=
 =?utf-8?B?eDRTMkI4UjBKVldhUjFjRyt4aUEycnl3RHpvZFJpZmROb2hxNlZZZkpWVGU5?=
 =?utf-8?B?S1hhZDJvanlrdmNIVkI1azRzS1E5Y3gvOHlCM2JoYWNpbmRHWmVQVGQxL2Ev?=
 =?utf-8?B?eS90aGlTZmlSN05QUmpxSHgrNHozekFSNWgwR2JUTzQ4dndqQ0t3VytJVmo5?=
 =?utf-8?B?R1FuSlg0VHJFaWs5TTBCeUx5Z2llNXN4VExxNVVBcUtIbTMrZWZYUXg5QmxD?=
 =?utf-8?B?VTVNdjhFZDYzMEJBMHRlTGpOR1Yzb3doUlVHNzF1WlNxbTZoZ3VSRW10NEUw?=
 =?utf-8?B?STFmK3VhaWxXUDBuQXBRa0J0b01sNnFzaWRtZDQ4L0hXRnFaeU5YQlBWbGxK?=
 =?utf-8?Q?1hviJX8s4bW00mb8=3D?=
X-Exchange-RoutingPolicyChecked: wIydZJrWyuvLNa+iASEhGFSACodjC0bSglJC2cNSYQjaNCATsMcIKSyKX4yfZhy1phC8do+HnKuX1vwrUNXkiSZwVgQ4ap3FQ42d5vR2AyW1Tv4M0IPu/GTG4kU8cc3x9qBOtdp988xaTd6b7s7VEu2JcoD/CZJwTIAMYT8YeCSdA97b812QAqVXnrPqNY/iKitpAYWWtoJcF4dJ1LF3qQy/Kt4ZwlVxuNh3R0agAOU+QQV4dXC5LVgq5v1WirvZDaWfel+JliMTSkfiLIKLWv9rxYebS0VvkV1slSCjB86o7BhuS0VEZF72YCLE+2Qd7KqerblD2dDDNlhn2LI9pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f83a57-7f2f-422b-3c2e-08df3b42a6a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:42:36.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLdYOO+XYtvcUNLnXItc/eaIl++3HVdKxpTxsFjqiy+WHzKXr8BccjudOlq3TTP9aIRUURcP6NpGYqvAWyTSqdqylGCxPOFF3DYDzfuUlxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-OriginatorOrg: intel.com

On 11/2/26 12:47 AM, Ingyu Jang wrote:
> All implementations of the EEPROM init_params() operation always
> return 0, so the error checks on its return value in ixgbe_sw_init()
> and the E610 NVM helpers never trigger.
> 
> Make init_params() return void and remove the dead checks.
> 
> Link: https://lore.kernel.org/all/8524c812-b659-4670-b370-35682aba2d2f@intel.com
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

thank you for reaching out,
in general we don't want trivial refactors unless as a part of bigger
contribution
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

especially now, we are drowned in patches, so this particular one would
be on the very bottom of the priority list

> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  4 +--
>   .../net/ethernet/intel/ixgbe/ixgbe_common.h   |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 29 +++++--------------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 +---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  4 +--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  4 +--
>   9 files changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 3ea6765f9c5d8..ab2c0818f2417 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -857,7 +857,7 @@ int ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
>    *  Initializes the EEPROM parameters ixgbe_eeprom_info within the
>    *  ixgbe_hw struct in order to set up EEPROM access.
>    **/
> -int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
> +void ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
>   {
>   	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
>   	u32 eec;
> @@ -895,8 +895,6 @@ int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
>   		hw_dbg(hw, "Eeprom params: type = %d, size = %d, address bits: %d\n",
>   		       eeprom->type, eeprom->word_size, eeprom->address_bits);
>   	}
> -
> -	return 0;
>   }
>   

[...]
