Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793051030;
	b=YswqxmShDvjz5tm0+fYRZgK6rCAaVUpDek1AQzoblqdH6SanrXc36YnUHWceB//EXgDw
	 AOCKPIGc5ryy1lesO9/OkXi5/DFpGiF0VqJSf6M8i3FFJFJ/3DO7pezN/sj7txmNaGeYP
	 DGG4AhszypBKgk5ecGJYIe/rPa//peZYWWvV3JWquoImnybn7W6MdoL4USIbhN5mlvIzj
	 daYsm0pWxS7pi3Ej+CIAyFyZNJWeiD3zP8BsrS8+Kr4stJf8+4gs0y2H3iNu4PfDQVKTP
	 se0R2a1OQQdbycdozDRb+LNtd/zzzlVx+EdW8noMVsm5+pCv/JW1RLPQyCKirqPaJyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051030;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=V23TGp+dMyg4QX6GV8BrDPt3aL1BJ+OTe2yUj5SnoQ4=;
	b=kGOkOBBuhtE503vNDJ4qzgmF3llQ7BKgK7XiBIb2mbZ3jwk+gnAiFmukGKkg2dEY0G2o
	 eab3QRDqsO5jR3UprPcavFD7q4wyeTThjJIr6+ZAInf0Qq6oyOr7+sm8PBGd90OK5dsMj
	 EM2MAk8i/W21K+mwU3ytU6FlRS5WyCXuH+SB+dt57o64h6TjA5UR2z/0qT2CliopSWXIx
	 O47UYhUiuv9tkBhS0XwawD5RDlnGG8KMFyjjlKgI1oQBVuL7Zq06e6u/7uK1HndBuIUqD
	 WjzR5xpvn0appOcDUBU3H5a+kHBqhthkgckzIWPax9pBDZubfoBz2VnD0V3Ey+ymYUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGbLm+dw;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E49606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGbLm+dw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793051030; x=1824587030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OGtCn0LL9bfbiyUAJTvD7Sd/h8aJuYLyXyXO/KRYEog=;
  b=eGbLm+dwsApVS6l4qLg2AM1cDEUctusQZaKEpXHyg4xvPt/MYsMcw4NZ
   GYhnx/eGG95sgYXjFG0ZPcnkWbAfnxPu28s4DxQ7jN0yeHT195Pr3EgTM
   1kBhjNBmh/0tRemCVASDK+mvfUDPvNivFyxu8iAw+VH8CVUs+fhTscvIZ
   /hjhyd+DhODaxPUek00s3M7oTMER3jHbC5ApkTo7alDq6isYzD1vpGFLk
   qQN7qHS0n9IVuseVMyoV4NRi0Yk5Ta2oGrq86ttgfS1w9d6HB2rMjZkVv
   QdYBMShW4rdPzLtBULpvsjZEDksaciw7hrvWvpH3mAroXz/uU7+7eWJKI
   Q==;
X-CSE-ConnectionGUID: fd591XmNQ5abwaBkHEORFg==
X-CSE-MsgGUID: Hi8jKvo2QeybpsbnuReOhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1759176"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1759176"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:43:49 -0700
X-CSE-ConnectionGUID: 34F5TKO2T/qyRb1WKcJ2Dg==
X-CSE-MsgGUID: GWFNFTXNQ/ORgx5MFnezSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4765374"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:43:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:43:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:43:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT+VmuOErejgRZ6WDsW1Z6Rwa1XTYJwEsTJ9DzDb/n+d4un5JYcThWyqZO/fnY/wojYeoAMIfEsgN05Oxun2tiUE/0mec1co7L0/Q4BJSTKMriSuZiXeoCYHo9dwJRZT3chTL90BNm+SlF6prLr5W8OXCgZTcqCbskFuOZP7a62vVDGrbEJc87UaBBGTcxSO2bXFUNdqM4B+PACpBLI2YaYQF4momSGk+6JzZknIJFGzkLvXQMZAqaFBtJjGtOuaeXTN8h1NtatcIpmjTxKZBa6zclegTgsxtNvhC/IR46kACYPU1Xk8m6kedJKEeAgGafoDfCxOoKWCcufKvYSEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V23TGp+dMyg4QX6GV8BrDPt3aL1BJ+OTe2yUj5SnoQ4=;
 b=RSx8mMipBWOsgjMmyLfN/hevUa4AbEDP/P9e6ANkw0vesV4NSgqMajA38nffnPpZ8HBkHPbtfWskTtcX/HdvmAmWgFYXNhQkGyDN8Rn5AoaWTQL2z8EOiUnwuZeAv++LIHAr+WG86Th5ZlTL3EGp/U39vT8uCl7QCtIc92LtunO8OKpp9QST5T8GvUCfOR+f+rzOBuKypisFsRQsoE9tQNvFjYMdKTqDM4XgOotmExgjNOvRWUYRJ2K9YnGFnd1VhusUwCDWgje03l+D8u7NP8mpsgc+f7U58LC2Xywp12iadhQPfCQ0BeIOen7nejVIvgZ6uD5wB1HdAdDxVKdFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:43:44 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:43:43 +0000
Message-ID: <08f85dd6-c0e0-4a39-8172-9cb35e48562d@intel.com>
Date: Mon, 26 Oct 2026 14:43:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 09/13] ice: E825: clear PHY_TSTAMP memory prior to
 soft reset
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-9-72289a4ac8eb@intel.com>
 <179297184201.3134.9594473446313979273@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179297184201.3134.9594473446313979273@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:303:85::34) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe81c5-ef9b-44f9-91be-08df33aa3511
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: Ivu3cBHYfXIf4yHAlJyiFlCXFrQoTkO5P3XxNvsZExVCMvXgYmAgfhAplLhC/tgUYf7XlrNk05B+u6g4nS9GUGIKLUDNqzkojWM0r683oBgmeyD9wLQ4DbpmquuYd67NYcEPy4XAvGogqbWwFkmddyj/PUtxKFluN6xs46QvNSnR0QXE5G28qOt4vUDjhfrniX/52LdudHuYz5+LP0RbkiL48/DXbsDogGNwJ9Gj2y8M0lBORyDgDq1xOy/Z0ktH9Ya/axMM4ThU/jErZOvjQ1JnDFxtmYzZ5mUEeFOA6lvsOi/0Uo0pJTYXyisysK745jUlpXD3BJb6XDJnBrf37yuNAod/lntn+niD8MICpFbwC10TYN6CP2mcR+ThRsSZ7SM1j3gTfCc9pFG5ORutisCtsKCTdvkqhhd3rxRIkjIAGJcp2jJ/6lgvG+fRIpsSt/xMuNnuh3MxLa+jXpOJuazfWpGmsn2iWNrDR5z7shEIXXxO1oQyf4jxOehMyjgLE96c933EDu6o8QGxU0QXIWsn7k8aSsnNW1IBIg/34/a6hvW6L6OGkU6lWLgu5Esp/pqd9pcJ0cJ47kAcWh1Jz6B/Pc5EGwPCadIVPaj6IzfD9VnQbwrBIWnXJBqVoihClKYKY3QE0Rn2o/FDMHm0i5BkWcf6D9uOA3ezdeZd+qA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9reUtrUHV5L2FqZEFzUWNmcGRSL2Z1QU56bFRNUHIzZEpDd0xmTjV1bHQx?=
 =?utf-8?B?MkI0S0xqT3dmN2R4UUo5M2kwZVFrTUJ1YnliYk1vdWQ2cTZyUDFHUy9pS0hn?=
 =?utf-8?B?ODB1a2piam8ySzl4TU41cXUrTlZwNy9Ddk9ncDNBcnNGak9xT2JkTnhyV3VR?=
 =?utf-8?B?TmU2cWRFdTBpaU5nc1hBN1Rxdm5VbThkNnhnWXkyeVI5VWxSd1ZKd09YbGw3?=
 =?utf-8?B?RGF5TzN0TERSMk1VK2dyZi9vb3ppK3gwcURnb2FLcm94WXB5bFp4NjVRZ2FF?=
 =?utf-8?B?Q1lSWnpOR2F4WVkwK2lIeTB5U1pXRkpncWdNTFNXL3FxdTBvdDZNNzB3Qit4?=
 =?utf-8?B?YXcwSmR5RGVCcUpOV2ZsSmVRcFpIbEdLOUV5VnN6WkM5ZVBVbU5UMERHSFE0?=
 =?utf-8?B?WmxNUHAxZDZlNytYZ0hpeThUUllCc3BzdGpZbGsxWDMrSVdVRFRNUU00OWlX?=
 =?utf-8?B?UGVMbzJuRFA1blUzZnRHbExjd1RJVDZTNXdCemNrenJEd05KcDlmTElWcjVw?=
 =?utf-8?B?NFBBT09ENDZVRFhoMGl4VDNNQWozakR1MWxJdHRYTUVrbTd1M3FWY3U3UHc2?=
 =?utf-8?B?UklScVpQT3hRTEwyaXlpNzBTOFAxakVSdXhVU1hOaXRhTmpIR0JFMjBSV3BO?=
 =?utf-8?B?Y2tBc2EvSmVoenB1WFZ2WStTNzRsb3Zmd3R0M0lpSUJGZi8rUzh5NVdBQTVJ?=
 =?utf-8?B?ZlRCSEpmRFU5MFJvbG5UQ3E0aDkxbFJRRTJMNHU2U1Q2VExOZTZTa3VEZUI4?=
 =?utf-8?B?bnJHU1l4SHFNYmJqU3UyZ0JCY2ZYOUFSM2NlR0RucHpHRVB6NWhVcTc3Yml2?=
 =?utf-8?B?MXRvS0VvUVZDMUQ3UlVQcjJRbG94WUlwdHljdk9SdkZIbG9VQWdRWHNRdmJx?=
 =?utf-8?B?Tm5jYWNDNmwxZHZCY0lBVDRkT05POUFUSU5tOXpxazY0VFROYmxSSHRYMEUz?=
 =?utf-8?B?ZzNHMHlianRmQ2hNRE1oenluME9lbFhXNlVPZzFXdnBHZG1yNi8vZU1kYXNz?=
 =?utf-8?B?MTFBeFpad09WZUdOL0owZ21IQU9JTGhOK2dnQTFCQUhCaXdGcXNXU1RWeEFv?=
 =?utf-8?B?QjR1UkNpUkt2czhRY0RSbW9PcDRDK1VabTVuUnFCSDRZOXVyL1ZLTGMrWlRn?=
 =?utf-8?B?a0tOMDlHQTRqSVZvUzVzSFBPcmRHaVNtcEdXSUhLNE4ybGVQV2ZSNlMwUElQ?=
 =?utf-8?B?MTF6Y3JZbWFOZzlOdzgvcC94ODUydmNCNzJvalVrWVRSb0hNdjFuS0c1SDlz?=
 =?utf-8?B?c1ZiZkVpK2hJZzl2R1BCWUJ2a2VEaFVDN2VUTVZSalNBek1sSWt3VEtOTDkz?=
 =?utf-8?B?WHAwT2FHSlp6d0IwYXlkbjJKbHZtVEdIRm12WmhzOXhUOTIwWlh5M0RSVU4v?=
 =?utf-8?B?QlNReUljN3NxemxSZGg1N2k5N0RUMEJsZWdnNVo0SjRLT056d2xzQU5JWWtN?=
 =?utf-8?B?VEN4NVJDZkFEVlhnR1pyY1VnZlJEUUg3TzdJTHp4bkRNWi9hM1VZQnJGQ1U3?=
 =?utf-8?B?cjA0R1ZlK1VmNm40VDJGTExaWXVaWUE0YXY4SGVVbVJqMDk1NEt1eWFRdGs0?=
 =?utf-8?B?K0p1RTJFSWlOK3FFeWJzUEs2blM2V3FqN1ZXeHFTc1psVFFGbkRCWTc1SUdY?=
 =?utf-8?B?L1ZtdnY5ZmMzS3oxT1o1UzhGcXR2WmdQbllubE1OaysxRkZISExWK3NHWGhl?=
 =?utf-8?B?cXZyOG4vYktqd2tzWW9QY0tiVGxnNzQ3NWFGcmJZMkNNOVM5cjJNMmlZODRU?=
 =?utf-8?B?b2tKZk5SS0lIeUk4REVnYitWdThuaElxc21iYkZvZXlIYTMwM1lHZVZNcXkv?=
 =?utf-8?B?R2RXQmQxUWFsTmo1blpObVNoaGgyaTJnNXNvT3lWTUFKdFMvalR0Z0plVzFa?=
 =?utf-8?B?MnhMNzdIRWhNMEZLMm03TU9iWXhFUnI1WDhHRjA0ajMxN2pkL3pkYkg2dlZF?=
 =?utf-8?B?anJUWTEwRVBjeEMyQnp0ejN3S0lTcTlWTnkreWpQYm5BQlI0OUtPVHBZQW9n?=
 =?utf-8?B?ZmQwalJTYk0vSVJ2dnYxcWVkb0h3TWRqems2ZjNkR1FkY1RMaGpGbklIeGRh?=
 =?utf-8?B?MXZZYXlNNHUvbDFUdFdxYis3UHpDMkxRUTZGUHVOc0R6c3Fua2R5Mm4rbjh3?=
 =?utf-8?B?d1VMU2J4TzZDNVhPUFYwdG1lSXNvZXQzTEV4QjJZdUhuYUlSNnNqVUMwdkRC?=
 =?utf-8?B?YWxaNTlNWG9KTEMwMGVQRG93QXYveU9VdDZoRnpySUlhUUlrMmRnWGFmOEFk?=
 =?utf-8?B?dkY3OVNCWXkvVElBQ1kvcFA5NHE3RnRRbE5CbXk3UmxSRDM0VFZodncxbWw3?=
 =?utf-8?B?TmQvNDVsWUtiVVNjSXF2TVlHb2RwbXZ3eFJiUEhaMGNiVVR5cmYvUT09?=
X-Exchange-RoutingPolicyChecked: S5TTZY/zAVakTKaXTqOzL0DIdFHwA+lRmUH2sx/Egky2XxP68gr5sJitiRBsCQGw/biz4Tb/bTD4uHqgp/QonrwS1A4q4zlAzTR0YOvaDeEC5w5oWQ8uH0DIe/5U2LRrzlKWN4mRoyovxHjloVRKHuJpjrAGE7NAhhW35C+aWQEGuvN+o/Lx9pkOs7EzlNld/i8W+17BRZnXqYF481/d+4FHm/+U5tEP2i4rAD3YOUqXChvwyCBoKCAJACthiQKwDQTxMLlg2RFSHHb5r/4noVSGGoQasMnsw+rSluRKoAX92l8/BtnGMI/q12NB11emSd5MnEftqjpbWSIVq7TglQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe81c5-ef9b-44f9-91be-08df33aa3511
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:43:43.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgVIkXSsgJ8rkaRRntZmIwRsZJf917TFJg0IS6xPwonmKz0n2/kHCT+cKTQF7mArItC9OgEQRNzjl9740uiXWQeBoDmZTT0hS7jyhiljoHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On 10/25/2026 4:44 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] In ice_ptp_phy_soft_reset_eth56g()
>   (drivers/net/ethernet/intel/ice/ice_ptp_hw.c), the read sweep…
> 
> --
> 
> ice: E825: clear PHY_TSTAMP memory prior to soft reset
> 
> This commit removes the write-based ice_ptp_reset_ts_memory_eth56g(). In
> its place, a new ice_ptp_clear_tx_memory_status_eth56g() reads every
> PHY_TSTAMP index for a port. That sweep is now called at the start of
> ice_ptp_phy_soft_reset_eth56g(), so the soft reset clears the internal Tx
> timestamp counter after the reads. E825 is also dropped from
> ice_ptp_reset_ts_memory().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 07b55fbb88dd..5637925c0e68 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>>  	u32 global_val;
>>  	int err;
>>  
>> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>> +
>>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>>  	if (err) {
>>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
> 
> [Severity: Low]
> The sweep has no return value and always runs before the PHY_REG_GLOBAL
> read and the three PHY_REG_GLOBAL writes. Any of those sideband accesses
> can fail and make ice_ptp_phy_soft_reset_eth56g() return early. If that
> happens, the port has been swept but its internal counter was never
> reset.
> 
> The new kdoc for ice_ptp_clear_tx_memory_status_eth56g() says:
> 
>   Due to interactions with an internal HW counter for the number of
>   outstanding Tx timestamps, this *must* only be called as part of the
>   ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
>   may become out of sync and prevent new timestamp interrupts.
> 
> Doesn't this error path leave the port in the state that comment warns
> about?
> 
> I could not find any visible effect from this today:
> 
> - ice_ptp_init_phc_e825c() stops at the first port that fails.
> - The error reaches ice_ptp_init_owner() or ice_ptp_rebuild_owner(), and
>   both treat it as fatal for PTP.
> - Recovery paths, such as a link toggle or a driver reload, run the sweep
>   and the soft reset again.
> 
> So this looks like a robustness and documentation mismatch rather than a
> functional regression.
> 
> Could PHY_REG_GLOBAL be read before the sweep, so that a failure at that
> first step happens before the counter is touched? Alternatively, the kdoc
> could be updated to cover the error path.
> 


We can update the kdoc to better clarify. The intention is that if any
of the writes during the restart fail we will error out to the top level
of the PHY restart and log an error that a link restart is necessary,
rather than trying to implment more complex restart or other error
handling logic in the lower level of the driver.
