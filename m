Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724F3AEF36
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789495; cv=fail; b=XIWxzYoJBKF6tz7H9PVY5Eb8SEDF4DvE/Vr6TNdVbsMY9XU7vPSwMN8Nnu/7dBu3TG7Tl/KNHYVqBPocHIIhNDLrJP2cNWGPmWEIFRKKqbiXf1EpakUkweOGpjBUzWj81l3jHS6NgUMcYiHQZtjblNVaPZodwsiHtiz/UIYqHOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789495; c=relaxed/simple;
	bh=Ygul6KP79ZyumZkcFag32Q4NEDgPAKz+RhnfXV6RTMA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSdq+qimktxY770nOoYfZSdavGA+U4AWDgvpFEPQ0uzm1T2/b4YRJy1I+Jtym5cBjPwwaa0XLmEsYf85wfqXf1F66vnKjvXpTWn137uTAKhcfJJgdazjZSjvzw396/J0fMTYsAqarBNpuOvglWwjrV3oyV/oXUzunV0X42OaGoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg8y3x42; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg8y3x42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789493; x=1817325493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ygul6KP79ZyumZkcFag32Q4NEDgPAKz+RhnfXV6RTMA=;
  b=Lg8y3x42+iwkOEiBsDLFGttjLjKdPf11tRDYCeXelIBfQGHpnIQ6HdaT
   JDT2E4H/Xlp3WZSm840wO98KfWLh5EiDKNdxqay+SkuX/GYFat16w7DTx
   iGI5B/pnqT+1YXz4KolPLdTKbX3C+q1pinkB3WZpJGOEyHeuYu+/zhhii
   3C1dgfKPutZY3CiyhqV4YCXx03oUoZJtRHaBD4G6mGow/3AujRAZNv5Jb
   GleE05CqaE5VD1P7yLvg4XhJZaV0Bic1BzeWvIZiGWNoq9p6h4XiV3sXm
   Kyb97Ng/lrsvIBL4GJvmoRaT9GYRy42fj8dELMY+hUtIxzp3TroXOlURn
   A==;
X-CSE-ConnectionGUID: Y63Z/VezRbGiQp9m6s+koQ==
X-CSE-MsgGUID: yTZdFTzxQdqL2kvR5/7q5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86211055"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86211055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:38:12 -0700
X-CSE-ConnectionGUID: jJ/3w4IDRHGw5H2ut8m8fg==
X-CSE-MsgGUID: uZoEd17PQj65quni9HPHYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="285952489"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:38:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 13:38:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 13:38:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 13:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJn5r+b6rqtG7YpclDJLJ/Utxc7/2KVjSVSAHBFTvsZAkYlByr51UcKktaSRzYNVWaxPxg3XCOIyzdkxSjmcfxJgpYcrrkiydajAo82zBJmfnQ8psYtl+M5kGl+fCGRYC40LxREHB5dWBNtn/asp4UNAHSyjeuzypcID2pvgoJ5vsA9Vl4b5DA6Kbf4Zuj8lWygL6YyZpjUPGMjyYOohRDx1yBbBjNFGVHEaJlM5DrZfR196QErQIPqdbwLd88fTuRmu2MO0TqjTZ9otpIjYwQRuG2fzwummgsx0obdIjG8Z0mGqN3HqyTk2+uFSpPfgjQEnxKqooX5Q+9PiSVOx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wyTjxZRgeNXpTvtp/HlfNq+aNy4xz9y3aVVA/SM/T8=;
 b=y+pbxA3PIzyzS1xnYmfYBTqMBq2HBqHhYv09ZNd9d4sZv8DoINz6ctrqJBRuNOkAsJBskto44RN4mTZsjtxBcR5ulSpRmw7nv5kRSR8u2HqG/PSL63Gh5mBoSS6s3BIAP4I63cIHQci3GNG09bsH/wkACAhSwAK+Z0qvSNIMS1jwk4XxOY62jLQcuYZvaMIVn84ecWgNcd4YJTP2dkgL2ME0qzN8JJMSfnEUN3nBlrfoFXFdv71bfvGC6bCXRDokZj0UiwEYmtd3FqOVlt+mPwoBILUmFtiHwmuOFAAwAurdeJoARxk3Qc0vsm1IbPcJdKh8AlzdDsC9/7sWyRwd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 20:38:02 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 20:38:02 +0000
Message-ID: <c093518f-0b9c-4b1c-9587-ebe487497dc9@intel.com>
Date: Mon, 3 Aug 2026 13:37:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: add missing cpu_to_le32 in
 idpf_tx_splitq_build_flow_desc
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<netdev@vger.kernel.org>
CC: <joshua.a.hay@intel.com>, <przemyslaw.kitszel@intel.com>, Willem de Bruijn
	<willemb@google.com>
References: <20260731103137.4000876-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.2f2bc4b192e45@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <willemdebruijn.kernel.2f2bc4b192e45@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|DS7PR11MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: fd78416c-4d67-4421-988a-08def19f1d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K3LYqzTF0rSusxgOFqaBYXHACgXnhRlK+Vrifaa1/9VaHV+buBu+rENQd0P7MFVC2zr0KiUFDt2HXuRPdImEmKASLOoPI4TA/T9f6T2KwrPWyRteq+/PXfX80yPoCp8uHhylH9pdczROBLAkmjhjlwm2+gNco3yjqUwYheVKgqeQ6Js7qhfqWbmBcH37R9uTs6UPVg3uHHfLEYanTPM5GSKDkBLWfqpKFlcdg5p3LcPPVbnh0eLOpN8Tz6NQrpCXKnoXxlqkZiTCp7mYCV4gS/OJyHIQ7HKdpx6AKTuPL3clmY7RanV3nv1jO+Jx7cjLSgoZqpLqAGCDXIx4kpiFkMGdQDpZb7L7HqOKCFMjI0MVzFn9ngeS7uXPGzEHSJ9yQXv0qNzd5TZW0AE4di52mJHqhHu8jOx7S0OdNmP/v80+YBznGDlERKLvBmdeEojjHX2uIVy6V3ZnpHs/UDUff45+za2HBBAVWSSt40NcqeJQsaD1v/TZ4YmbDnDz6xN5ryOcbt5HcUTFRijRBTNMkIo1lS6DBRVsuc5GLWfoaygope6IjEEqpdmbWFo0ibVyGJ+nqmLHa3fVQanIrCYfQVT3G8FxweJRidz7BJc+B10LuPEu/2LKVE2OWjp9DDyoet3SwjJu55NjRc0348CiCgm7/ATsltgO0cODEHm+24U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldyT1orbXUrU0h1OURKKytCa2dmWmtQdjdrRVhaRnJBMzFPcUsvZk5rbDYr?=
 =?utf-8?B?dXpqcE16SGxUNHZvaGFYeHNaa3hCa0F0dnN2VUxJTVdBeGI4anJTNFlHUzNK?=
 =?utf-8?B?a3hselpOWEpmcUMvdTZhZ3J5V0JFYXBBWTFOZUtLamF6UWNXRFY4OVkxcmI1?=
 =?utf-8?B?YjVLSzhTalB4WkxlbzhKOS9sT01YN2o4V3N6TFZRbmsxblQ3bDV1RFlKK2kz?=
 =?utf-8?B?dXVJc0tWNjJiKzcvTklYaFN1aVFYdzM0dHUwTmVkZ0s2ckdsYUsvNU8vQ1NN?=
 =?utf-8?B?QmtuaE1LTFZTNzZJN0RmUDAvYS9iZjVBZ0VveTladkVJTjZRcFY0OU5DZ1lj?=
 =?utf-8?B?cmNvMGFxaGErOGJLN3kxcjM3RnJORDJHSWh5bkQ1YzRtNjJaMmRHRXdZeHE0?=
 =?utf-8?B?aTkvUVYxMkExaXVXcFpoM0lBQTRBVTZXYldXR0ttWEFUYnlRaHFleDQ5VCto?=
 =?utf-8?B?aEZoaTYyL1hQRFk3cVdQMnZPSGc4M0FlUlRlckV1ZzBPVW5NUEtQZTUvWWpR?=
 =?utf-8?B?QTFBVUdydjdOK3J3ajBYZ2s5ZHFESEw0TEl0SmFxVHRmNGlkb1J4TFVydENk?=
 =?utf-8?B?SmZ2d1EyRkNPc2JZZXlFa2ZCYlowcjhzdGJjQ21udm1XKys2blRKSzMvQ3VP?=
 =?utf-8?B?alFRMS9qVE14TlVFZzlReEJ1dFZ0TkpDZFBYREc0ei9nVCs1d3VrVXZuZjNq?=
 =?utf-8?B?bTg3NkZwRFpLeElUSCtuek5kQ3FGbkw4Mnd0YVFpQS9Zbno5ODl6TnVLOTdU?=
 =?utf-8?B?Yld1ZXpieWc0dDVqak5sd2tYVU13WWdseDNCeHR2R0xOK2Q0QzNJZTg2eXVp?=
 =?utf-8?B?YUVXbW03U1ZOL3V6MmhPbzJGNytOQ1RzVThWY2k3S0I5VkwycExwUGt6NkZL?=
 =?utf-8?B?ZTMybEFnVWpGOG5HbHZVd0NvWDRCYnRwQUc4L1Eya2lLQUJ3Rk5TUEJ0TlRG?=
 =?utf-8?B?WnV0Q1NqQ0ZPUFJtbTZUU3dBLzJZa3ZQQTN0dHlieENaTEdCM2ZhZjRGSWcy?=
 =?utf-8?B?UWRuRkpIeGZneUtHdE1UcWl0N2szODE5VzZIZHNtYXZmL3VBYW55NnRYOFJa?=
 =?utf-8?B?Wm4yUytkbVAvZFJ4Vit1SHlOU3orKzJVOGNqeEIvSUZ2aEgwbS8wZE5DRk5I?=
 =?utf-8?B?ZmY2OHg4RjRQWmpaRXFUZEo4QW4xbmY2ZGZCdjJzMzZtVmdPaXNRK1hRc1l6?=
 =?utf-8?B?eVR6OHlGTzVnUkpza2VFUDl2QXBBU1dBUkVnSUZUUk53ajgzRlUvbXBkNzR0?=
 =?utf-8?B?dmpXQnFQcHloVEJ0NVlIbFdSSFdJY21RakluVTJxY20rL0YrK0cwTklFNzJQ?=
 =?utf-8?B?SzJ5RG5VK09WSW5rcTcrSUtvSThqUUZ3d2lNTk5nTm1ybUU4aGlXcTRYcThx?=
 =?utf-8?B?QXovVW56L1dKOVB2TlRyVDI5aWUxNW9IQnpzbkR3WGwwc3hXZDVZV1dvMmRl?=
 =?utf-8?B?QzJsSkVKejhKMHJMWjBPQmYrSFRpVk0rVVdqaHo0d2lyZEMvVDNlWUFZQmpo?=
 =?utf-8?B?aGNZK3Nrb044Y0czZUlGdjUrWE5ES004NjZXTnRjSTZwYmN4QlNMM2xQSlhr?=
 =?utf-8?B?dDRzdWlYUUR0VncyWlBERGJsRGJiQ0pEcytSNXBRSkg3Zmswa3hFbEM3Nkdu?=
 =?utf-8?B?a09MQkgwVit3SzVaOFNRL3liYzVIaTZsQk9xQTN4SzliK1JwS0JuS3dkRzBJ?=
 =?utf-8?B?YVc1Z09ObWNMVmdkdi9JNnVEQTU4dndJdWJWU3FKTHBSYmhLOEhzL1c4TnhG?=
 =?utf-8?B?WFhFRTR5MkxzZGx5N1daSEtHdE13UXYvMzUrdU95ckdiUmVOcnJGSDVyUkdL?=
 =?utf-8?B?RGxLcWlNZ1BMaXdDdnMyYnNYNW9pVTliZzhMUTBjVXcvUkFBR3NkSzIzUkpU?=
 =?utf-8?B?Q1VIeXJtUjhxL0p5Ykd0THVpMFYxVEVRRDZDT0dGa1ZlR0FKZkJJL1pwT0ZO?=
 =?utf-8?B?NDBISFdaSUZrS3hENWkzcWFyVk1sTVEzbWdOQjQ4dnBwQWNNbldzakpqVEJm?=
 =?utf-8?B?S1RCblV1MDdvR1RFQVBieFRnYmdCZjV6MldvN1JOSUlUNnNjS1lsYjM4Wlly?=
 =?utf-8?B?TlVvVk9xMFlVeWZYYmM5NWdLUVNPYlZCZWF0d0ttbE5BWFl3b2t4N1BIUUJW?=
 =?utf-8?B?Y292U1gvVW9rOVZ1MzRyUUlHZDVhZE1ybUdDUkNYQ3BXbDQyc1ZHSmFaU1k4?=
 =?utf-8?B?YkJ4ekZBY3p4aUY4OXUxSktYaGxaSzZDOGR4OU11d0kzNEVqaUJ1VjBHUzdY?=
 =?utf-8?B?LzY5eXpvKzRYV1d0QnVtdWNxUVEwSjVYV3J5R2lVV0N2ZUhKbEp4c3lNWWQv?=
 =?utf-8?B?Lzl4RUh3eGhRODQ2aFcvN1VvaHNKOHR2bjNTVU9haWFzSXRqYTZqWTNQTXVa?=
 =?utf-8?Q?7PkWFQQ9eKstIhzc=3D?=
X-Exchange-RoutingPolicyChecked: rnwnbMy+gyeYR5mGovr9atmZ34jcpDtFk/Le/oQNTXX4xPX+/M9VygsRT59lhqvUwGFZbBWMRBoHHkyuMnfmD1yh3iXnn4gdBQRFicsiDe1s0begFma/uxYfiV0aQ8+2wZmzWDfKI7t+kyjG963DrzQgKTWHYPkeUlHjG+g0KTju6EzTcdnJCWoLZfMmr8Abepfqf+yFvFGK2FpnGyv1Ta+OKIA+brWjKkd1vw5ERk/keqfc8M90d86MNArdjS04fsgL01Hax7QmZuogw/GayCcs4smC6DtAHFHSZgtvJMU5a+rO2+MnDKvuPDZSv9xmotO4EsT/fXunQvu/dBzz/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd78416c-4d67-4421-988a-08def19f1d01
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 20:38:02.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ycfs6BAO9lLy62DyIZRSUAw3dJMl/1qWqwMvxCyh9SGincnN0u1LfbQotpFIuoI4dwtYPv2wmgSCxdovCixq/AFUt/njZoq3WCtJGgixVbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
X-OriginatorOrg: intel.com



On 8/2/2026 7:31 AM, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> From: Willem de Bruijn <willemb@google.com>
>>
>> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
>> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
>> field in a single operation.
>>
>> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
>> __le32 to ensure the fields are written correctly also on big endian
>> platforms.
>>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> 
> Forgot the tag. Apologies.

I see it's for 'iwl-net' but IWL isn't on the send list. Seems 
straightforward enough that if netdev wants to take it directly, it's ok 
with me. If yes,

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Otherwise, could you add the Fixes and include IWL 
(intel-wired-lan@lists.osuosl.org) on the send?

Thanks,
Tony

