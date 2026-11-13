Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571889;
	b=Ao7uYLV5jHcK/tjmqtugdarI9zhOvoML/X/sLVi4I+7geAF3Y6bHld2ZTKcP3JSJwtud
	 0MdIaotQ39s5vHLi+1yUGp9EuvdzmGFFi3on7HF/3wDNO7JFY52dGe7chWSmZ/DGIZ2Ig
	 d22dL4YqTFOVqXacLtJxje+FLntPxdQE6RcTQGJBH7/6oF03wSTcw/jfwgs4AWB3I3lJB
	 4Bw9RjP0q1kIZiC3KrrW2YwYqldAAfPgCHnKTJ8Tj4PQWuHwVBYBrHhxhYKZBTZgFJ/In
	 IbatPuE9+AwkgNyeLqqub2uznWKFpjphF6k0jOkM6vit7MLfkJ/hWoCNrhfzaESoQjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=kR5NbiM0ySYwokcB0AkQJGkVEwlBYtndaHnisQO0GgI=;
	b=0annIYFib03lyTII4cR/H1669JdT62FWpqTRCurAyjor4DnfmjwRDBioXacy4mm9SpEZ
	 KFidMwD5DPAHG03GNHZw0k9XhHSdVqf5Q1FP0Iei9VGHNYRZbGjenwFztT6vt63uZrgoV
	 6CMoVJLS68/NAn0dHZOVKxLhVk3YP83l5BQW9eN5cq+Cz9TQzqN2O7iQ/bVM39MdZ5YOG
	 x3ZBBs1qbk77RDu9iz6+WVbfRH4ZF6MnFhkOMnrnGWTyNnZfI2YWE35msndKmHdm5qxOf
	 YO0s8QiwvfEUPYUxvpTBn7cbHFW0DOzud3E7efgtG4CKGan9awi96mXK+u1dWA1pzEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UIswa4lj;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Uw4AWY3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19891606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19891606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UIswa4lj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Uw4AWY3W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571889; x=1826107889;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G0tIJHxFCmEqc6eEdcvSfkhWr2+I5DgevjAVDH92mGM=;
  b=UIswa4ljTOYAShP/y5f2I+8GLlFUt/cdZ5OREVYBk+qsI4CyH8uiPxhP
   TxqWyaQa2/NCqvDl4ue+hpwwbphkyMV4sZu3iGWGTvBpciLwt9Zh8a/vn
   CmacjCoDseRM71Yps9UXGTopDXeDgyjUlMsqChMhuzP2Qz4hU2OHxjIsA
   OAsBVbyMfhMFp48E7XA7phKkM7AaxUj1Pfl6VV2P6DAMiXHo2TY+dd+BH
   Gaswui9WoT8QTErjwobAQV65L+wggJ2J8rM++fA8DaXq6pX2dj34XKRAF
   p9f2mWPw6p1eopBeUaz48UGGHf9BMSDScojbqVPZYwmqcI6znMZ/zgwV+
   A==;
X-CSE-ConnectionGUID: R2KTT7YhTjGmTYcVMbh/TQ==
X-CSE-MsgGUID: 7EMa9B2KRGGAGMZrjqmLHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3381481"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3381481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:11:28 -0800
X-CSE-ConnectionGUID: z9IpdVITSD6ntHVsuHeFhw==
X-CSE-MsgGUID: tcoaop1ARSC36I2Di/gMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9008370"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:11:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:11:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:11:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:11:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrCsDiUozXj+kXpf2Tc9xTBwfh+U+I6o9C8L0eopQmt+jk594XXzZXaOgXz+dTKxsMB5j//y1Av5znghUsdDkvxT8Ge+wAOqLRwQbxBjzrZhnEzaC4rL1oM5RkOgzJ8LsW4TGD99R0SxM9ITSAhayETfRwtFpmLwWCjRQiFVjhnGBZ9Wg1tOND9ZNxe2//g5ur4hKi0TCuYexst/vQC2LnQ+59cdOwhFfAg/DJr8cS8NchZ0d85cQj8Ea48Sg1ZDO9szLVS4UaWLViTSZTFXVxxcnsqL3e40188CAAAsQtF1uZix3OaJUId//vzRM0plaopqf1Fson/yfPkgfxweYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR5NbiM0ySYwokcB0AkQJGkVEwlBYtndaHnisQO0GgI=;
 b=BxJXCcUtYr4eNM7nwYAKRtdODrx29MhPR/E6a/BHixfLi5FKpbEgKwhXN362Ye1kPkjxb1OAFqq3CFnQahKkBSQV414G7UL2PcVaKE30/Tfm8VGFemgedlcAboy+yuxGpqEgiI9cAuMFmzdBuCHV12hJQCYUc1GBYAgoI+4YuR8Owh03Nb/CD1CfbAPNC+q0ADrcrSs25Z/fGNqmr2U8wHq/M+l6+ad9pT1HuAb9zETBC8nOt8dVRCsqz94kcjCNn2JfXNyohmsmTIW9tj7t/LRoyGhGDH87kUj81/gboPuvrdyB5nDv4Ra5c93YegfveGETEKMdLNscGZ6bh97UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR5NbiM0ySYwokcB0AkQJGkVEwlBYtndaHnisQO0GgI=;
 b=Uw4AWY3Wxp8sitPsT/bwarDAnTN/RJ2AeCl0NISmFXqwBRh3Bbw8Va9Tq2OjsikNne52Ujyeu6KI/EQPP2625DH3q3BnpjLDri1+D2Oq77lgG1tt9I2u9cK8moeHmj7Cp8pLT2EEJHYWVHsiOLRtx4p37OBvLpT4X5YvFwICCbk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:11:07 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:11:05 +0000
Message-ID: <aeae3684-a1c0-4e5c-a6dc-6c525ced4fc4@intel.com>
Date: Fri, 13 Nov 2026 13:10:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Petr Oros
	<poros@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Michal Schmidt <mschmidt@redhat.com>,
	<edumazet@kernel.org>, <horms@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<andrew+netdev@lunn.ch>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<leon@kernel.org>, <mbloch@nvidia.com>, <jacob.e.keller@intel.com>,
	<jedrzej.jagielski@intel.com>, <anzaki@gmail.com>, <brett.creeley@amd.com>,
	<ohartoov@nvidia.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:10:110::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa41748-aa9f-43fc-c181-08df417f3084
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|6133799003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: MWME9J5mglDy8MvJOQZqxx2h/2EJiTYkrFr/khfxn7OsoMkI7w4ENXXj9rwbzHDY9GEX8fzWs9gq1XzvC91KyxoiNhwUXNKXipHx3NVWGXSafMlNHXVoc08xJzY6xL82u3j6Ye1aG7pqCftbTNRf04Z9qZsAVN3EAPFn7gd17Ww31b3KKom/+Q3se1jWJYLsptIStdyB9nUHQv9Lq5KFvZj1cynthX5cW3ZZPQfI0FF3CEsmGVJnDm1UC1bB9rdy5XTs+No2hebR7owxHgC1irvf50PLh4Wy7/x2xVhe3X/hFK4km6vEl022lpst1tPX3h3dl6UzWiV/0PffhpxgQ3+/fTXrAyu+s9KpAazsznXGGZQ3LfxyOxUBzhBxfnF6BXwT9SDY5t59JR2MqnJc3quJ2rZAHeVIHmaS66nJSQDilCq540FBLWJ4J5gXunZDx4fS95h1DEBrb1e9Go/FiezokECdbSSDYCEzYIvYE2FgcJrUBXQe+d8yvH5B+T2iRS1JPJFp4cyWK1HfhsWRL1JvcEMp48Z8E8PTi3MnP9Rxc33wUbx8xtIF5ruWsKNi7J70S/fxznMKhamkFBOOZA0AGhkJHLphDYO3OojdjmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmo0aVZYckpxTVFHUlAwNU9xbld3Zk5mTzVSU0ZtVmtrdkQvdXNqVHd4MEhK?=
 =?utf-8?B?TlI5a0c4d3JFYlU4SUtFT0tFTk41RWxEZGFpUmlSK3YyamsvMmJIU0FTRlVB?=
 =?utf-8?B?NHpxK1YzYWNFZEd3N09KS252VlAyMVRpWThKNHljd0g4bjZhT1hXdTZPTkFj?=
 =?utf-8?B?RmZ6MCt3YkI3dVR6anlhN1BxUnpVWXRmVFVSQllySC96NHJuQjRkakx5emZF?=
 =?utf-8?B?d0FBK2FUL3FRRFVwZGpkR21seEUwazMycTNBVm03VXM4UXlJN2poNVJiRlBV?=
 =?utf-8?B?cCtYZVlRSjJ0cEV4bHJ1NEswZm1oVkV3V2xYallqRzhzcmhYVlQwYWFVTDFh?=
 =?utf-8?B?S0RsZVlRdEpCaDhLay9uWXk1ckdoM0FnMWo3cDFWRSswckJOR2tNYkh3N3g1?=
 =?utf-8?B?ZlB1b2p1Z3Z1bTd3V1k2K1dVOVpXSUJHSWR5V3pQcCtlVUtUZ2ZPOW1ubGp5?=
 =?utf-8?B?b2lLUEVpUDBuSldQdHg3VEp4SlMrMVByTWh3d3gwc0tJWlpyVTN2Um9IeE1S?=
 =?utf-8?B?VmdBbGVHVno1WEFGeklrOUZYT25EOUdVaTlVbStuZnVZSi9FUTE2Y2E5bGNI?=
 =?utf-8?B?Z2NwQ1ZUT1lsM3MyR0RvcEQyZ2h6RDZTbEpPb3doM0hId2JSbUk5SGRJTTc5?=
 =?utf-8?B?OGd4T1Zyc1JEa3J2RDArSVZxZTF3VVJhb2Q4djJBbDRaR25RYXdLeDdwZE16?=
 =?utf-8?B?UHUyZjJLUEtzczdBUlB2TmdpYXNZeXQwRmFMTnYveXZEVDAvWFA4Ulg1K1lm?=
 =?utf-8?B?T3h2akxHbG0yNGF2UUlQRCtCa0l0c2dtdHh4QWcwQnVIREhZN0h0WmpQbDBF?=
 =?utf-8?B?QTBWQmtUelZWQTQvRWVkbU94bktCVGtkaUZVNzY2U2x2OEdoY2lIL2NpMjFm?=
 =?utf-8?B?N20veUJsQjhEQjhRbnQ5Vm5sTGpEMnFoOVUwWUp3dkF5bG5MalVRSWFPN2wr?=
 =?utf-8?B?YzhpeEVoak5aSzZEdTh4Y0J4UEU2Y3Nxd2wyYzZWeERDRnRoVElzMWZMS2hy?=
 =?utf-8?B?M2ZKNDZPQWJBeTI2a1ZLWHRlK1hWQjBucS9RZFU1Z21UcWU5SWFwRVdmRVJa?=
 =?utf-8?B?a3Zxa0lXYjBZR1ptejc5OE9sNEZHSUZ5YVdrK09KNSsxbXczT1NVVlZQVDN5?=
 =?utf-8?B?YStrQkJxYkJLRGtoOVJac0JaNkR2YlNmYlRYU3M3V2tMM2lBVURPQzhkT2Qw?=
 =?utf-8?B?eUJSNzlkR3NqRHNrSWlkbTVvbXJWY04vb3RRVVBxQ2VNOEkxMVByVCtZdXlU?=
 =?utf-8?B?akxlb0U0VWJtS3RxNjAvUVlPY01Cdm9lRDJ2Q29IRmk5L1ZDU0pHSExMdU96?=
 =?utf-8?B?WDhwQnAwSTcySDNwY0tka21UdGt3dHdBY0VzR0R0R3N0WEEwdU1MWHMzVHdW?=
 =?utf-8?B?VWF4Ujl2WUs0TU1Ra0VWYXhCSHZ3dnRYQVJLUWsvRGNZbHgvV3lKSzdTa1Nj?=
 =?utf-8?B?YWpPN0c0aE9KMUttbk9Jbmo4VWhOcUdOUyt2S0tHMVJGdmZwREU4eE95RE5i?=
 =?utf-8?B?Q3dRNVhFMnZkY3RxU0djOXV5MG42KzJLbXpJek9YSkJtQ2tPbWh2RjJmelFZ?=
 =?utf-8?B?TUJGZ2UyeC9WbGhDRTBGVFpnQ2xCdlRJR21qNWtHNnE2UFhhWFpJejhIa2Qv?=
 =?utf-8?B?cVc0R0JGVEJnZW5peWFnQ2VpN0k3VkdLbEZ0SEVlc2VjN1Q4ZnVsQVNrcGcw?=
 =?utf-8?B?SjVWdkZ1d3BDcWVFQVJKcVR0Y2FSOGppeURXaGY0ZVRKZlJKaXRBd1lxZlBi?=
 =?utf-8?B?OFV2UnR5UUVXMmdKYnQ2U2N6MkxkMW1qcU1hUjR1SUoxd2FYUXpTb0tSS3lu?=
 =?utf-8?B?UDhMOS9OVFhDWWFlVVRhRnlNS3BCWlpNcmZIdEdaa25oUUEyUWR5UlIvak9j?=
 =?utf-8?B?MGpTdi85Q00rL09VNExiZFk5a0FNT1FORVpPamZiK0JIYy9rUURVQWEwTWdN?=
 =?utf-8?B?SFp1VTVFTERwcGtXMDNpdHp5S3p2MXRIOGcvaFNkVEd6WWhKWWx2SHVSVW1R?=
 =?utf-8?B?L05jcXo2ck4vSmpJb0Y0OTFEZUZvcmlMMFhSU3BjQmduaDhhQ2VFMk9vWWR1?=
 =?utf-8?B?M3BKRmVzUVF4eDJyUDA2NEtZa3VkWkhtRHJpczZidDRDcGp4c2RhTS9ZYVdt?=
 =?utf-8?B?QkVZNlNMbGZwdmxYZk5vMURSakZqQld4bHlTbFRNWDVBYUhVYzZoSUVRais1?=
 =?utf-8?B?UTJQb1NiT2t1QVcrTmhDcjBGU3N2Ly9CV3g3MUFyVXZKSjZYb2lFT2htUGhn?=
 =?utf-8?B?U01iNWt4dkdVazBrUHYybGxtTzFUT1hieEt4SlBSUmM4NHF1SHBWenRDdWZ0?=
 =?utf-8?B?elovY0NpY2JKNEF5cDhlZlFaVHduQkM5WHB6UVpUUkFPd29OeVd0MlNqM2lo?=
 =?utf-8?Q?6YGvi3k+BuN44SqU=3D?=
X-Exchange-RoutingPolicyChecked: nYnYxus8c68sB2eTzVJ3s28Rakpc+XgDswTNf/CSwo4w0KEr8WvDUQuFQcP+3RpUxB3BcFptMFeGfbL6igprKReQfsWJkMwQtKFMEGk9raONecQmHwm6vGACxtfjbUQ0/tPTlQ6S4EeKI2eqAN7Bt0q+7UJpqq5Z5UyU1FQvMkTdCFQZSfpfwnNk+WiPlF5D9wM5gCfl7y2Q7jPfmSQYlyV1Dqf38YaHFK5sgjed8gOXJjebFYMRVSrqQ5D2yqKSZXAbfFDI0lduCrMOTeVIK8Uk9R+E1E3Z6crKXKzHje6qCKcrS9DUMqw/3WZgPcOzN4nZs1mW5Rw4wEQ/o26EBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa41748-aa9f-43fc-c181-08df417f3084
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:11:05.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra1ys1+Df8F8AOkdJHJahDkB2BYkuSlW/gdxnVR6ARPg55stkosUiR9R2ntxn3deKMIrt2ubFPl44vwUyPZ6dUqug9u1PcbtuxqdQKBMp30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com

On 11/10/26 15:07, Przemek Kitszel wrote:
> Also available here
> https://github.com/pkitszel/linux/tree/xlvf-v5
> 
> The purpose of this series is to allow iavf to use more than 16 queue
> pairs, in two modes: up to 64 and up to 256 queue pairs.

Sashiko review [1], summary of the problems:

1. Division by zero in iavf_fill_rss_lut() (10/15): the only real bug,
    but triggered only in weird conditions: a failed VF reset
    (iavf_disable_vf()), and then the PF reporting a different RSS LUT
    size when the VF comes back. One additional if () resolves it, best
    if it could be done as a follow-up.

2. Bisection: a non-default setting (sriov_vf_msix_count above 17, as
    the default MSI-X tiers give a VF at most 16 queues) is needed to
    cause minor problems during bisection (VF queues above 16 not
    working at a few commits in the middle of the series). Fine at the
    end of the series, and still much better to have the patches split.

3. Minor wording problems in commit messages and code comments: AI is
    way too picky here, e.g. it reads the casual
    "valid when lut_type == GLOBAL_LUT" as a wrong enum used. A wrong
    struct name in a comment, or a detail that is in the changelog but
    not in the commit message, is not worth a respin of 3k lines.

4. Multiple pre-existing bugs. Of those, the lock ordering ones, which
    I have hit during development, are fixed in a separate series
    (including both lock inversions listed in the cover letter):
https://lore.kernel.org/netdev/20261102105346.30739-1przemyslaw.kitszel@intel.com

5. The rest is either in the cover letter already (VF has to trust its
    PF), intended (ethtool -L in the LARGE mode is async, as the PF
    grants a request by resetting the VF), or an error path corner case
    with a benign outcome (e.g. a VF left disabled after its VSI rebuild
    fails, as ice_reset_vf() already does).


1st one is also reported by Petr, with a stress-test reproducer.
I would like to merge as-is with a followup.

All other are rather "cosmetics/nitpicks" or pre-existing.

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com

>   45 files changed, 3099 insertions(+), 351 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
>   create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c
> 

