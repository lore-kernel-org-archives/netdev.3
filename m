Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0426D4C3
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764879; cv=fail; b=b9HYLf8L+ixov76/1nKBVrQATzMQ7Y8kMCwam51hLvDDa6Mi5ZIa37WsEK8uHU9T3ReQl0oJijO7Do1mMxHlRj+ViCBrrpuOv39UyxolhgWt1pEMf1nerK2p6mo4qC4m1XcJo6zuVzXuBBK/LU3jawaeDqrp0dfDd187R/a3Js0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764879; c=relaxed/simple;
	bh=CFFtSO1dTSFZ6qpOM9V/bSDGW0orD6hR2UnO501M3Ak=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljbb6MQBH8rt+pilrw8uh/Y0LaWZ9y7DY6gf2McBqBea7hxhx+r7miingUi7j3qcKoGXmsN+B57D8KK4NrYbfZANHyzn0unF+xRCuj0iiBspvttOt0Fo4N0zARU30RCMdXP1sTEELi+luU854tX1FHHLyitObPL2ZARMZqspbnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9iPnrd7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9iPnrd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785764877; x=1817300877;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CFFtSO1dTSFZ6qpOM9V/bSDGW0orD6hR2UnO501M3Ak=;
  b=C9iPnrd7jDfO3HaB9yqFVI3l+cjJDoI8QVTW6RkwqUuNWycUZCzM8oFK
   G/uvGJkb4R8DTT7Eglu4hw0Iv8TN2iGb3dxWDvHlvx3oAPDc1STVenGmR
   xcKUpv8CO/x2t7YyDbwcrGRp52iXv3SiAAzAu4WF+g3t99Vead8jO+6r/
   qKg7rM6wiRenUSyGzZTj9qwxXwIz0kj8r8jBdQOuK8soTd1jlbDbLySfV
   ++/7tmTjsGhJCYw1M0CD7Sa4uljpH/kMPQP7WFFXAEmoBdWXnaOEavC/i
   ESs3JxHwHo2OksO60GfHEOVWY74gF6hZQ398OawfLu5DtppYyVxYaoinF
   A==;
X-CSE-ConnectionGUID: tw43SlYAQhW5EJwJn6tMhA==
X-CSE-MsgGUID: JDKn5xZ/TfGmGY6sSxPV7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="89977447"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="89977447"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 06:47:57 -0700
X-CSE-ConnectionGUID: YEaIUXYnR5qbI8VoSUTgGA==
X-CSE-MsgGUID: 1maxsfe7Q0CFTXufqyye8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="261813914"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 06:47:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 06:47:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 06:47:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 06:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phziur9+0LHcEQnAnvAUC83VSUkglfUZkTkOH2uOq7amTLWg1dqzipLXGFud6NGgkleH7yn6bZUACcXYOOB5AdbUEGbrqDdqmuipIUC/eohoJem4jMoDJq+l0OIAvIjKAB7hYAILqleertrtgbVN7kMQAn+3KchwD4Wg6LHfmzSy0k165v+J0N91NRG5Dl93CFpDQJcOFhTPvpnvpaguqWu6R7sjtCoJ7p3OEe6aYyNooZB2RNTWW/tgy9aSxUKYoHOX1h3JNuhfpOQxkm7xbdRiFz/K469uzXY/hOWLeDzhxjeZ6on3K8kVHUkkpFUUnTi2UpLaxWC9hLe7llCpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMICUs+K8Ht7eUa5HFfmrQC/Q/CfoefO96ATJ9BGrDk=;
 b=Ck2tvulnZvemUy4Q8s0qE3EF4Q8wzAZDvRPi/5i4Ma0bBFYBOS+yOg/zOaemyeNIqfZfa2wYfS6fwL3YJvwzomHKQVXlwb80CSaRddTi9HqVX02yTQ/9yRSnn1DSmEpLAC24UmnEpdA10iuqpQMyL4oU0MGdUsBZJvGUu+g/H2SDpoKmdAWZfn2FLO3o5nEE/dHfydGPJLWm3Hv75RH/0iZOUOoBzyXIvzlnSgUEHUOOzySCWKjPbsPl+u5FcPcjilx2R/4QfgMLKEm2imczlUFIAPlE+RbqOwnN3ku9D1bAGYNfDmd/Ep2J415u4uHJ6xowm41kAf5o+wzJnVrAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 13:47:52 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:47:52 +0000
Message-ID: <8992095d-c856-41c9-912d-5e41f395a0d8@intel.com>
Date: Mon, 3 Aug 2026 15:49:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] devlink: Expose external flag for PCI SF ports
To: Shay Drory <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <20260803090012.257242-1-shayd@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260803090012.257242-1-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f52ecc-4fb4-4474-1027-08def165d05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: wnK7nVTBzKjdULnnrNxR4SgN7RCjrWpb8YqyGRWJ+50DgodpDFoDvbFpOnEQoh35aMuzS+pTwQzGe24jLyretXo72+jj++hROQvf/L6iIJzlflV029+BOIrB2L4L9yQHelRNif9NQMBliviI881HcPJnwJwk32QIYfBUjiQMOtHMaZeZ89zfl5aUbAy+XpQq1bcF3BYNGw8PpmJr3RPuFCHQqxIywBqSr16zdu4LAy/sCziFsn/mty9nRt7mVAJ3LQnW7SpxmoiBaWCE1vfsrCQlIhyIlaSHLBakk/LRdDRCaXwmsdtJXKA94ygL/VuK9Y+i2IUvLc7/i2Av91ZmZMVuUVM04p9lJaY3EJLSlUAoSIz6h7iBTCO3yyJYaQDXeLvNE6trwlWyxE0FQjetuw+1D7IeIQjfIdLdTI6RhaWATOjRMagj/CL+h/r5QWPG/opQWIKnDhRut/j4JiOxyx29kcDGg2RZCoTrHxwyZ8Od0bKTvxNYhDzUTKbYX7tsNyzwE1756mzdT0kWBIEfJQw08Js3b4t9QWIrF0HtvXJxPtUm54Ma2JDe7nlmK+8zZIRWcZD8GYUosM0TVRFmvL87Vc/5MC1oSv7kz3dSVQURgBU6Isz9aoDvcPZicJoU3WO//rcoeaYWWjttvn3E6pceu+xVyl9np6FLY4xcfGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnB2UlhDTjJHYjVZdlFDZnc0SWF1bU5mWXVwM20yV2s3Q0xIM0xrWEtaWEg0?=
 =?utf-8?B?eE05a1krSXhUU0FJbk1FRFB5dCtxOVVLcjNWQkMzTDc2OThOWkN6d3ozMER4?=
 =?utf-8?B?V3IyNjMzSEhVVWVMNkdXZjVSeGN4V3RXdEpReHRhS2l3c2hIMjdadDdZella?=
 =?utf-8?B?cHlmYVEzRitYNWxNczU2S1dJczk1MnZIK1N5ZWlNWHpHSnAvTlh6UU81UUdq?=
 =?utf-8?B?NC80L2JOaURNRkxoRjV4WWRLOUdHcm5mOE9sMkF2RTZqS1c0N3ZkWnpDZzZ0?=
 =?utf-8?B?R3Y5ZzFZLzhoYjBOdWJpZTc0U0ZqeWZ2ajRlWTMzWVAwdXNYeTJLOGIvVEdq?=
 =?utf-8?B?LytERkxIdVlid3dpcHZrQzRaVWg5aVAvcWZZaCszZ0hjY3cwVWw5Wm5lODVG?=
 =?utf-8?B?ejIramp6RVBQUS9VQS9OeEZGSExwRFhyOEpkRzVub3NmbGZsNEN0OXJ6aDZ5?=
 =?utf-8?B?a25TVzZrenpSZlAxVWRXQldudlRieDZUVUJnQmFBeUVwbEUyWDM1eVV5VEdW?=
 =?utf-8?B?dUw3VUpKb3RKSFVic2REZDZITlloUlQxME01Y05wUXVSWVdTOEthZ2h3NCth?=
 =?utf-8?B?S0dneWR3VEphbkw3SWUzVFVKc2J4amQ3aU9yRVpBTE82WmNsVnZIazFRQ0k3?=
 =?utf-8?B?WDRGWk53bHNxVHJqNVVmYWdrVXRZbStndjVocG9tWWxha1M2SDJUdlNRcXI5?=
 =?utf-8?B?SU1BVWtQRzI1YkZmeXErWGlSUWJDRWRJNTlxdnZhNmVpcDVkbWdRUm5hT08v?=
 =?utf-8?B?MWlOeXc4RHVlQVJrWFRKY0NobkRrTktJRXdubFB1eXY0RTcrRVRVVmNYTm96?=
 =?utf-8?B?eDZDejRjUWFHYkJBa3BIYVhsaXZDOXQ4MDFTaGVSSDZlTUtrWHpLTG9OaTJ1?=
 =?utf-8?B?amtGQjVCVjY5QmpDQXhRL0NwVTBEVnZBVHVZb1I0Z01tMGtjSGh1bDkzazNB?=
 =?utf-8?B?SXpTM2RTNXpzVzlxMlNjb3pzTTMwRXd5cWRkLzVWNzdTbXB4ekVRMnUrMFpr?=
 =?utf-8?B?aFJTN0ttNjErVHowOVVTNG9FclhXbnNhL2hrb1VFdGpEV2xyZTJQcTdmTGhZ?=
 =?utf-8?B?Zm9yUyt0WlpJTHkrVWdidU1TT2hqMFdDMTBRK1cweVhiRWVvd1E4b3RkQ3NT?=
 =?utf-8?B?N1V0d0EyYkhHdjJ3aWtuWWZXYTAvdFJvZHR6ZVpCVGtha1A1OVBQQmdMWXRM?=
 =?utf-8?B?ZTZWVWMxK3h6Q3FnUGVlcGhTbC9Nck03QnZNc1JSK013Z3ZYRUtWU0U0RFZY?=
 =?utf-8?B?aGtIN1phb1lBL28wSk5zL1FBRVM2RVlGMmtuSzdZYWNYZTdNdWdQYVFhejY0?=
 =?utf-8?B?bkhieEY4c0VEVmN1Z0o2YVFWMFdQWldZa1NsdldsVGF0TUZkZ0liTUcyU3Iw?=
 =?utf-8?B?SzFDNlhCZ25iYVBrNUVjMHJ6T0N5NVNob0M0S1IvRTBlTE9TT1Q3WnBpbXFT?=
 =?utf-8?B?cE9YejRHU08xMjJqcEZyRDl1d01TajFXS1kzYTd0M2lCUGx0b0gyNStoSTNm?=
 =?utf-8?B?UzQ2TGdCMUNXMHhUYWtrWDNrTVRPaDZNVWV4K2ZDdnVjbmVlc0FqMDFTRGY3?=
 =?utf-8?B?K0tUUkkxYkVLeVRUNCt1b1F2dHl3MHVlQTdMb0FPL0ZJR1FQMFNRMVY2RENm?=
 =?utf-8?B?UUpaMUxadUN5YjZ6REpNV1p4M3B1bFQ5OXdzbnl3WTBNMmVXcFZJdnRMdDBk?=
 =?utf-8?B?SWkvVXAyWm9Sd3VrSzRuU2JNVjh6dFhEMEF4S0h3ak43eDdhVjIvUVAxYWJF?=
 =?utf-8?B?TlNlZFMzUWZtOXh1a08zUUpFUThZVWp2S2VwcjI4bDJOZUtXVm82S1AyRUE5?=
 =?utf-8?B?bVFnOGJZYkhUV3hnbGNaK01BQXJlUEY5RGNwT0dLZzIvQ2lnWVZxR1Z1UEh6?=
 =?utf-8?B?Tnl1c3hneGZHcDlrL3dpa21xQkIvN0JWUzQyajlSRmtCVlRjN0YrNFFFZWZq?=
 =?utf-8?B?aEdUU1dvOVg5aDBOSGZLcUMrQkF2OHFQNHU2cHk3RUpnbXI5Vk1TNUdybFVH?=
 =?utf-8?B?Ry9pbURkbktsWVlMR0xxaTZPelNFQ1FkSFR3OGJkTk9jVHQ5TGFqaWtsL09n?=
 =?utf-8?B?WGpudUhYY2hFTmU5WndWOHJ5UHlTN0dtT25yazlpODlHRm5xTDdEMUorQ3Iv?=
 =?utf-8?B?TGZTWUpGZGNSdlphMVdXZTNKcVk0SkZ3TWVMSHFzcG05dzhRSEVSaXpha1Fy?=
 =?utf-8?B?bjZNSWh1cnp3MVlYZFp2QnZ4QXFRUVZCT1FTQmRRSGx0Q1hGc05wd2dQVTc5?=
 =?utf-8?B?UUMyQ1o2QVpZQVE5V08yMUhaYjQ4MXJQemRpbm9YaWhpT3JQWUNHVU9mZXRJ?=
 =?utf-8?B?NnIzZUVBYWJUbVRHUTRlMmJObGoyd2ZKWHoxcldWMVVkaXovejI0emo5cmF4?=
 =?utf-8?Q?nuRTF1/u/qRJYgiY=3D?=
X-Exchange-RoutingPolicyChecked: hvhdiSrmqaltzMB6lNcV+gyV4oLCFLbb5ne1btV8VLspadk1PJAUu70YI4YhovfuS3jHB2TPDV691JRtcEx6g8UC8R48GOqq45r7lf/PsNB4Ejdko73rgLoLQeFIb9XThWjkPuzcsrQEYDP9Dg7wyPDqx/cqEQehlaIqwqFB/74ez3UBEHymGhjSfuOGy7DsUAjokYkdd8rxMWi44bxFI+Wmia+acubeSM0szExViRLDcdhDTnjMZnmSUIh/PCqBcGyWMNumHakn3MnLnXY57Ul+QQoYt9+OyNdRybfsdyxlMGGElyC3zWXgY0hcTrn9qyX1rGLh3o7l5OHqQFLWFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f52ecc-4fb4-4474-1027-08def165d05f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 13:47:52.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MJYLkfA4nJmTiYFh5CuMo7DEUSA0EbImnG/W4XulbeCk5L9cs27jQkqcZXzyyPuoJ5i0MI5crjJJfwTLN9rVfLy1zzBn1YbuljUnpONFTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

On 8/3/26 11:00, Shay Drory wrote:
> The external flag is part of the PCI SF port attributes, but unlike the
> PCI PF and PCI VF flavours it was never filled into the port dump, so
> userspace could not query it directly.
> 
> Reporting of the external flag was missed for SF ports. Hence, put
> DEVLINK_ATTR_PORT_EXTERNAL for the PCI SF flavour as well, matching what
> PCI PF and PCI VF ports already report.
> 
> $ devlink port show pci/0033:01:00.0/163840
>   pci/0033:01:00.0/163840: type eth netdev eth1 flavour pcisf controller 1 pfnum 0 sfnum 77 external true splittable false
> 
> Fixes: a1ab3e4554b5 ("devlink: Extend SF port attributes to have external attribute")

Cited commit has neither introduced a user-observed bug nor a buggy
feature, merely a "backend for a feature", and now you exposes it,
making "the frontend".
IOW: I will rather call it a next material.

OTOH, code is fine

> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> ---
>   net/devlink/port.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index dc82cac68e7d..1528f2d148df 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -267,6 +267,8 @@ static int devlink_nl_port_attrs_put(struct sk_buff *msg,
>   		    nla_put_u32(msg, DEVLINK_ATTR_PORT_PCI_SF_NUMBER,
>   				attrs->pci_sf.sf))
>   			return -EMSGSIZE;
> +		if (nla_put_u8(msg, DEVLINK_ATTR_PORT_EXTERNAL, attrs->pci_sf.external))
> +			return -EMSGSIZE;
>   		break;
>   	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
>   	case DEVLINK_PORT_FLAVOUR_CPU:

