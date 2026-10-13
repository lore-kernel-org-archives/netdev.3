Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230647A89B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908852; cv=fail; b=UYhTmy4QVlWAsvbWlPZoKt4NETIBN+rdelbECB5002TmhP0LGuO7wu0M94ezAaRgmXMii/zGqE18/8KoOrUW40czZ0qmuIxUblKz8A8UuHeo39bkZx5jd3owA9bE/xNb7oVzrLvrPQfAkv8cux66ofat6fI7INJCJIPuh34erE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908852; c=relaxed/simple;
	bh=t4DPjYu4EvgQO0d25gGdT0U4MdR4RgGwvXxrxhkcDL0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZpLjN8T1ZBDTdjdK+9zESjd9xdU6dFGoVLvaJd1XvwiYP3CH47rBkZJdQ2QvFrrAloUyASpcXtu/y4ywrjIQ72A80ldWzdGUp69cnvNEoJ98SPY10UFr9Lw69ck6ntZxWWSGLWA6bxlXdqkTTDQZdjV/SAt4kYXgqL/9vZdWWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mt6LCkDH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mt6LCkDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791908851; x=1823444851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t4DPjYu4EvgQO0d25gGdT0U4MdR4RgGwvXxrxhkcDL0=;
  b=mt6LCkDHttGaETCliUh093voxh3Soa8FGAD63O3GBaWE31DJsh+dlsm0
   LUGXg7Rr0swTELNTCWVjCYG2xY6IDFFYObhqVQY1CLKMVEryLxztbeG73
   N3NzdPjvIobNIIj+1wOIZYWXTM32Ch1FHiNY+yTdNMwtkEMJ1wNKhtqJY
   dfx+FVtVr5FzLKqasc1JhTKArmFakHqXC/Pht2IpF4XRCeABI3pHuiX7y
   5l4Ap7CmHAxuPofrArAREuk63Jai8BNu8hHKGPqR5FYtcaN/UwVjl1dtV
   D+r+Qie6ovtJFJRSjjWUbI+iqpsbE7iy7ALYTiCXBftO2QEC26JwOBgqR
   w==;
X-CSE-ConnectionGUID: 5KKSSyllSgSl7Yks6f2i7Q==
X-CSE-MsgGUID: 0gO6fy+cRY6N5mSqoRTrAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="526642"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="526642"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:27:31 -0700
X-CSE-ConnectionGUID: gpgA8DpdQHu4O4WtyfVPfA==
X-CSE-MsgGUID: 8t9E0YDsTK6d+Cf9Dh02Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2971633"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:27:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:27:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:27:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSoqHTVOib4AlcxjKtWF7dr6jKAj7Q9uAEzwMWzYG6nN0TolkVAucQzRofpbYfvGNRI1ePGo+1XCZjlruBXYVRZiebS4xCPva3C/IZgmB6v9hwJW80lngMc8jNfqX7QW4OIYatDpA41qqCo1lWzm9Z4Jw69hhVUDpgR3ov/D7ov+q3YPDLNoxSmdUGsnhhrCaps/Y/x3Avn++T84eq5d8pCyz9PfuZlIhR//cL6mgXeWuNT8lqhjntACi8UPM7E9RF5iA8RiAtDjYjPjyrE9NJ2J5nIXGe3RhFsnBuVUv/ASwhKPgUCVJdILyyrmOzSuN0XsdNwJm8MDgNArOwdP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eHK1zdres7LT1Z+3sTI6yVfERUIMsh1zimgbkNDT/Y=;
 b=zUFoVQKd7NZVIJjlo3GycGLhe5v00PdVKMMO20LL+bPnXHcwPaEZ/dzwnaOBrTF6rFX5qOgOH9HVTAjLIHlkHibTUz7ihtBWOEIVb1vGFYkzBP+jDMe8DwrePzQse1Nt1frjiNfVWKYJfMqNMqGQ5I1lQvzlUZ6OrrcJUQNkGlcHRaJT+wBctfFQI1cWSVyBDNwGlTwQ+m6QLtYYLrU8xXfDTz2g2yALk46YJ41apIKvgxDvOVpKf9h3booLRJSUBFEYZjDYQYQYP+Q1xlnWRT25fwCQijJdfZx08CxGDvb7szW18jWiYSmyB4nbl3KqkIzZjbxtv6lxV6qVrCbFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA1PR11MB7246.namprd11.prod.outlook.com
 (2603:10b6:208:42e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:27:26 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:27:25 +0000
Message-ID: <e798d410-9dce-4206-87f2-5b874bc44ac1@intel.com>
Date: Tue, 13 Oct 2026 09:27:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has
 started
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<aleksandr.loktionov@intel.com>, <decot@google.com>,
	<milena.olech@intel.com>, <joshua.a.hay@intel.com>, <alan.brady@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-3-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261013121224.84482-3-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA1PR11MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a948435-ab81-4064-b4cf-08df2946ddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: KTqWk5OlbU72iQE/Cy8dbBfTlyXuVUhuZjx+xNt6gCKyL7s73Z4Np9hjkFIxJLizSA/ZnihXFRAAXb1BQZK8G6jIxWonn5QG6TbirO7itVXS/7RoCCj4U0w4msfOud7tgyCVz9ilLdWiZwgQ5JzzDstpcqnMcYC77kG+wA449IoSbs59sEGS0Xqwg4+AO4XvPMehD9JGoP5U00wi9BShvpFN8xeyieFgaflxfNGMhEYuwR8aZ9weg+ZXcm6a0fR75l3t9jtVBzsHHwKs/8xai9/nv7eT9nFKV+VVhbcnaV6A/c58RnErndSSK6fLV1atrSC/rizDLfzMep1mAFw8I6hX2pgJqwiI3lUGsSyVnajteUdiRL9UKoAmefM2UXvm8ojBRl82hzpNbw7SVQDplKNYuRsqxUCRVjCgjC+VVJ+sGky25VsAKi8EW/dvplc4vUUdNcdYdQ17MW4u/Tc0QMMN4/mKUbrQdOlQJegULvtrm2nAu1UGRqf8cV+wPcfs/2N4sW2GSCncd01KIi84DtZPPIVX5Gml5ue09smz7QVsurd8zpUXP8y66fBYhMZkErYse/RBSe9mj68qU47G9u1cPzwKw3LZ/Dy0rA6JYD6FXuS0ZisdWVj3rV0HWo9Hedu+3+Ld4iOjsPTdj7R1AN7pMfDebvCy2yceMeXtC6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVYUGh5eE9vWlAyb0ZsWSs1dURpSStZelNXd0xRaERIR29oYjg4cm1mRFdq?=
 =?utf-8?B?ZWVYajZucTlXaEJkNFFzZ3JmQ0VubHFndlQ1YlZmS2RQbnJYYXFVVURKVVJi?=
 =?utf-8?B?M2krM1RPMjlRRGQyemZjdVcycHRLK0pncUZ4VEZweWpFVG94dHlkSGlFL2U5?=
 =?utf-8?B?RXZ2dnNXKzVuR3ZHNVFhSTlQNDN0N25ObHJBbmsxbko5c1J5cHJkbVdEZDdJ?=
 =?utf-8?B?YW42NEs5SVJicXFxWCtTWjBMaE1tZmIrdWF5ZlpDMFZLMWlobmQ3NWlpWGkv?=
 =?utf-8?B?TTl6VTMzOFZjSzlsQ3RqU25zY21zYVgwRlZDR0ZPVjYrakJ2MjlRdmZ1Mlox?=
 =?utf-8?B?M21GQTF2TVBCZDhXTUl3cTkzNGdsRGNDK1dFcmloSXhwZE5LMzg4cGQ4SFBo?=
 =?utf-8?B?a1lDSVU1UGl0SHArbEVTUzZYZVNWV25mM1VRQmJIcnZ6UU1LWnFnb1l3cnJo?=
 =?utf-8?B?eXo5U00ySnNXOEM5UEM5ZGlSMDlLODVmMkhORllDVHhoYng2WkJSa0l1dFFQ?=
 =?utf-8?B?TlovME1SaEhlUEh2UGQ4TUtiaUQvblh1NEwwak1CRExMQkVSOG5lWWhkcDBw?=
 =?utf-8?B?bW1UMXk4QWw1SmVzMEtVV2VwYjFYL3hwbnFYa3NaNUhOTHMrM29Ed2xXTlRx?=
 =?utf-8?B?MFdxT0NnTEloOWpPZ2Y5aUwrVFlVVGVhMWtVeFFwSEZ1dDJ3SWZYekdSdXRM?=
 =?utf-8?B?NWFobis2bEJhRlU5UnlteUtoY3VIWDFoZmpwMjUxYjRDWncyZ0d2NDBZQlpD?=
 =?utf-8?B?a1BjRkpjOVI4R3BQd0M3djl5bEtDenhxMU5CMjF6aGo5U0ZlamQzYUphV0g3?=
 =?utf-8?B?V3Z0L1FkYlBFbVlSQUZ1eWJZeHl3RjVyd1VlbG5pYkZYc2lYYjd3K3dnY2Za?=
 =?utf-8?B?b1cwNW5oNHVTOXMxZzFpUGYwY1Q5cU1uOTBPaDltK2dIT0xxNXY5UDRsQ0sv?=
 =?utf-8?B?VE00Zi84SUxqWEVQaHVSYjVPL0EwcTJ3Nm1sMjF5Qkh2V1J0UmhPYjdGUnpi?=
 =?utf-8?B?b0M1OWJQeFF2b0ZuUThrTDRMRi9DblJ3d1NZMndYcXJFWUVnOGJFckRia3JZ?=
 =?utf-8?B?ajNQTTU3cVdxckdFTklya1hGbXFmc2w2M1pndXpqVSsrcWZiWUFWTzJlbDJj?=
 =?utf-8?B?dVQ1WEhyNDRJTGMySHliY0JRSWZ5endkbmZpSVBTazNNRUNxRTkzVWw1NzdN?=
 =?utf-8?B?aW55LzNJQ1JaUTc3cWRsZ0h4Q2xuR0xjSGt3NjhhbmpsUllkc0pxRVRvcjZo?=
 =?utf-8?B?U2FoWDE2R3R3S09KbTFhNmc1MVhJM21OU2xBSmVFdXJ1VThkSkFzMXF1dGJj?=
 =?utf-8?B?ZXFvRVJCZFNhdmlIU2dPcDc3cjh4dVZ1ekg3MnJ5T2VPVTZROHNCNFpZYnlw?=
 =?utf-8?B?UmFrUmxYL2NkREpvNlVKakZRQjhNUXBpWCs5RnZPMkFZSEYxYlZ6OUtJTGZr?=
 =?utf-8?B?aUhVQS9DY2xjOERNV2NnQWlMSHplUThzU2d1U0prOG83SnNydWxKbSs2R1dS?=
 =?utf-8?B?dGhKOE5rYzZWZzFUTERHTHY0Vzh0Z1Y4Z3Z5dnI0T1o4V0l0WGlaU3RkZXBI?=
 =?utf-8?B?eHE2dE5HZStjaUU3ZlVFYXlTNkRNUVZYTGNJT1laNHFjN3FXQTJtb29KZ01P?=
 =?utf-8?B?YUErbHIyNzhEL3RzNXEzOU5ydU1kVkhWMWswbHRBUHRXQnhHcEJscEp4QXJU?=
 =?utf-8?B?NEZ3VXAwb09DNzZubFA4R3dLMUpCWGJuVXplMWo1eTVYZjgyVGFsLy9wbS9G?=
 =?utf-8?B?OHBjdTRUWE9BTFZ2d3p3aFZGK1RUSDN3aitrZk9qYjVXUU0zNHF1cXhidmtn?=
 =?utf-8?B?NGtUNlZXZTRWUU5NVTd6azZ1TTkxZ3hFY1NueGRtd1RGbVp6OFJUVmxNSkN1?=
 =?utf-8?B?ZGQ1WktFVnpDV0NVQmF3UExtNld5MHdSeWhUdFRCOFl2bjQ4aFRyY2c2SWJw?=
 =?utf-8?B?UVlZSTIwSkJxeFpENitQZXExSmRHOE83empMYTJzaUpPeHl1R1JnbHpkOHRL?=
 =?utf-8?B?VEF1WWVtS3phRnhSMVk1ZktqQ015aWovRTBNSFA0dEdHVldGNkJCc3BqNnZi?=
 =?utf-8?B?elVDRjVtOUxsTGJUV0l0WGdCTXAxWGMzd1YzOEp0b0tKL090R0VHbVE4bUdu?=
 =?utf-8?B?SzNvdzRIdmw2Z0RQcTBaQVBEeFBPK3JYd0lCYVNkdzc5K1VrajlXY1g5NzYv?=
 =?utf-8?B?VTdkZFl2eGx6Y0RERXcyMXg4MHRia1h4WnNGNzA3b3lWSGtWZmRBWUY0dlkx?=
 =?utf-8?B?Y3orM2orSVZ4bE5XaUdYNHMyZzFaNmt3cGFabTNITmcrQmJCZW55VlR2cHJX?=
 =?utf-8?B?Tmt6ZzlrTlpuOGxoMDZqZUhiblRyVENmeTBqMVdxbENBWkFjMjV1VkFub2gy?=
 =?utf-8?Q?m+YVR5kkaks85ybc=3D?=
X-Exchange-RoutingPolicyChecked: ek466WGbqRGmxmdR+zfJzieJ8LTlZQCfvf2Mo0xjrlQGbToxbJyPHowJ+b2Gy58CttivdCWZFM5HJccDoC9Czose8feSVbyRItNZ/6N39VMvNUG1w9AOYNAq9fi6jUgg59A8SZfpk8Q3UCzTS/U3C+3UkF8OslDULXx3qH+AsEb0Edc6SjNe2F88sK4maJEtG1/wPjkKiivtFqKOgIbYsUw/HBqViLnfwIdg/+YtjAusSEE9gcCTgJwaNEZ/tw4BO8iFTCTCxEyyTPALnZLdfj//HyVSbc073YIIS18nEw8dEyTsc624YKZ2NaB8Y8iKrkZVGzgjd2+Q1iIjf9+Riw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a948435-ab81-4064-b4cf-08df2946ddcf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:27:25.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf2iIr4v2fcrQlRIL8bzDP/rKhwS74ijzw/CJUJdGkVDbJHVumf++epDxc2664D8ijsXRuxqegCyIkOLnOpXo+SJhFJrw27BKEgcO6yXeeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
X-OriginatorOrg: intel.com



On 10/13/2026 5:12 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> mbx_task keeps handling mailbox events while idpf_deinit_task() releases
> the vports: it requeues itself, or is queued from the mailbox interrupt,
> until idpf_vc_core_deinit() cancels it once the vports are gone. A
> VIRTCHNL2_EVENT_LINK_CHANGE event handled in that window looks its vport
> up in adapter->vports[] without a lock, and idpf_vport_dealloc()
> releases the netdev and frees the vport before it clears that slot, so
> idpf_handle_event_link() can follow a NULL netdev pointer or use the
> freed vport.
> 
> Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
> The previous patch waits for a running mbx_task after the bit is set and
> before anything is released, so on remove a link event is either handled
> before the vports are torn down or ignored. Shutdown has the same window
> today; the last patch of this series sets the bit there as well. The
> window also remains on a hard reset, which tears the vports down without
> setting the bit; that path is not changed here.
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index d0db60647..2cfd216ae 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -40,6 +40,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
>   	struct idpf_netdev_priv *np;
>   	struct idpf_vport *vport;
>   
> +	/* The vports are released on remove and shutdown */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +
>   	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
>   	if (!vport) {
>   		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
