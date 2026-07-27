Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4223EA9B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192498; cv=fail; b=tqSfSU/sngVXJeEQ4OXbvUY90n/go7Phg6aPaoqmt/pmsdNIt2jaP31rttohPwNtskRWR2CyETCQlU8NnUH4ECr9k6VY7GkZImR+hsvIMjxu0CQDu/0RdTzzbpyLXhHgteipXoGmHDwDHfLDl0expGpx4p3Qh2etiwAhdltraPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192498; c=relaxed/simple;
	bh=bU/V8moBQ475GBjZmE1NmVHTudQL9e8YLzlrXQvKpkw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nL0SqynrkLzh5sXkGesVV9VxbJTsmbu3xERhshFMJw6uLHqOHeEHUAtZsQQSB9kLVn0DLyfG1oaevt0B93zZF+01PzYgUWrjMnilj0rU21V8qPlsDkkS/elmvvHwFWTQ/Y2LnhU+05KUPjK6wvdxh3fCAcTj2i/fON1at8pAxGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgi97fXm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgi97fXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192497; x=1816728497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bU/V8moBQ475GBjZmE1NmVHTudQL9e8YLzlrXQvKpkw=;
  b=jgi97fXmzXfPRkpBh8Q3GSHbgEDjlOMqDmjMMuH9saYUDNKz4oO4py+i
   4Or1lvi/JxPadpXfvvU75oZxe+Ja5Dlegu0/7K0JjXQ5QLqJ2o+5qGjmv
   MHiZLQfNmoqLg3w3OVoD4tzstF74sz0XtaDSE5iAXu1w4+KiGbhn3SjCr
   t8QewhwasD/A56niQwcSJv1XOw7O0kHQTH9pNUUWqJpRPTccq0jD5KPY4
   Y1ePcx0srHtCSuH/6g8we6mO8jDpzMe1fK4moC8MmtKhrqzMtKPr3sqgD
   zMkpAdjcZS+rLMQs3M5sy2mfC9s/T59T/CERswfE0MDciBJSpLlGtQ7bl
   Q==;
X-CSE-ConnectionGUID: k3+DeQpCQLSUkSBWtyd4Sg==
X-CSE-MsgGUID: WKBBJtt3QWOhIGuoCgmUUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85809549"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85809549"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:48:17 -0700
X-CSE-ConnectionGUID: dR3d9EtZSsm80K3L0qg2AQ==
X-CSE-MsgGUID: jBK7fITlT76kv8kR0dyyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="264517659"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:48:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:48:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 15:48:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 15:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irxPKiIkEwCF6m+81aCWk9LizTblKCCYRLUup2ULWFj1qbyuXKWmMbUxs6WUSanLlXzGef4b2g/+fZaS44TbWh782Curfo25ZmZiioIkpybnrdfZmMcdrImIjEgbEhe+yiBEhEgpFJIqY0mBaf9fm9RrhVGSwEPqhMQTg6/BnRr79cbqfV+EKRujlM4lkNHc1K/VY/TMQ1zvhqfO4zxjBavcPad5vb8NPVb/lEdTKbuGh3FDpnqaMtXY5hRSkjp0x0jH7SS1dNSFPN3zO79Ra+nEhYhW3sfeIF2oWJ6IutWHl2oUmatSHzd2sOmnSbCOOkAzk0o487gSHhMNQni4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO+INNZHXdqRLY7TpGBctxD428XC1HXog0qQt9Ptc8M=;
 b=vVf8GetHdA7WwcOAQeUY+rJF10CqMlUevE/Z55J84vxB9V+o1z7aUskiVA8VtW6wawbpQtwnth5cnet8n0ZkfDGinhPGyGdDhIceL77BeTswWrJASSmWFccVSYlHWTO/IivGYLVaUNAY3hjPr+6mRvgfug9h0iQkoVUKpe5bzyFWh3UhGb/cVEDXb9k4Vd7Y8i92lHmBpZ8RJd0ryIy0W9xmMMeZu2VnOTA+Uo3K6myMecOy9ItNuqvjM3vEE8WbnaQ9q8kZhFMTg3oqX/oRZZ7PUN0KynbOzfdm7/0T+BCXbx0Izn6NFjfHR+IIGrYUbBUJET5PfhWRLIzyRd+HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 22:48:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 22:48:12 +0000
Message-ID: <b5b19d09-c608-4694-9c24-d747d109dadb@intel.com>
Date: Mon, 27 Jul 2026 15:48:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: cancel pending PCI reset work on AER
 recovery
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20260727170030.361116-1-nikhil.rao@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260727170030.361116-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c09b0e-7bbc-4127-42d4-08deec312346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: d4QcTAIsz5pBJHs6GGbB6fr6vmJK76LOTiAp4GJ6ZR827Qc4ZT3j635sQkk/AUHoZwFtcA80hSQKH0XBYrcdA7TB6DIfxERpR34xgCarU/0oXHrvRoEz59g+BRzsrXB3MZvQHaVbQUQBi/IAs32TLXGVL/pHgQROduAFzQ09zc9e0rYKGdkc9NeFjtsHfMDGwUVQj0tlSioodPe+RZZGYj3TtLo12j5LA+g4NldXaotQSaQfnh2Gp8bwCdm5lXEjTOb3hflPmGINbffwKIpZab1sVMWsokcU79HFkEFU49OU9c5fI6JOpVXW0aWRtxE6kRbPbk0WpZKwh4v2UbSxdwAkqGshBIDZvAVZWJd0Mu+OgeGrZpB/t2IN0Yiv+J/O2R7oPpE6QgeXJ+SPQeBJ0eK2HKftW3SucjFAm4xzKH+x99ZURbxeuTmD85aaFavOrTijvoRqBt0e/u6QDZXWsS5IRQ0c1654FnNrM0BMLaocQDwhRzhg0P+EKDbY4S0N9MejdKnqt9Qfe/q6WwHtttg8i2PTw4JfReQzFoQn6Q1ZuMmI2P7HvAohj75bd0nMLheT5L/zDg0mlm9bVHzLXGL/IzaOGh2xOwxTBuy/jlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZmaWlwTHhZQ0tiTVlESi9NdjRXZ1pEYVB5U0tVT0RaK1ptS1lUTDBKMTBP?=
 =?utf-8?B?QWJuOHY1cWpxcUtEZXhVRVJEdUNHWmZaS0REc0xiZUFHR0xMeEliRHM5MWpM?=
 =?utf-8?B?NkFGS2hoSXhnaU9rSE5kRVhHdWFkOENtN2UyWllxYmdaVlJYcmFqS29LV1hB?=
 =?utf-8?B?ODQwSXlGUnRCYWd6S2pOdTFQU1k4cXJKZ0gxQ1JZbzV5RlRweDFKOTFlRnlM?=
 =?utf-8?B?cW5kblZYSE0wL1VvUi91eFlkYWZoWWUvUGg2bDdYWjFURDNPMEQzbnArK1Q4?=
 =?utf-8?B?Vnp1MnFVdlZpVTBxTGpOUkRXZHJXUGtpaXpPb1BlaUp4MGQ5ajNQY05OckJj?=
 =?utf-8?B?bUVsOFRlL1hvR093WTN4cVMwUEMrSzVPd08wZUFFWnA4dGVKUTdoV3FXNm1w?=
 =?utf-8?B?bHYzNEpGMmIzeXk2dS9ybU9kZm5qMmtwblo3L1VVUnZVWlQxaXU5VTNjck9P?=
 =?utf-8?B?cUpRMU1saGtrTTBBY0JrR0pJcExtWmJ2UGRPdDAza0owRkV4U2p2MUd4c041?=
 =?utf-8?B?b2xNSTdwVWhBempLV1hyUzJDYk83N0psZ0pVM3hneW1wY1BsZStEVWp1UkZQ?=
 =?utf-8?B?UkQ2ZmVFM3UrWFVnUTFBamMwTVIxUXBkb3FJYkhrbW8yMFpVSVcyajhWQ0x2?=
 =?utf-8?B?ZEFSS3F2S2VNZWJ6MzJMTHlER1NwaFBXamJXdE10U0lialI0VDQ4K0ZuVk8r?=
 =?utf-8?B?YkNrVkY3MW15OWlpQkZpQzRvczcxOS9FdE5TOVZzNWp2S2lLRDlDRzFPaUdk?=
 =?utf-8?B?azRjaFB6SDhWbS92S0xnM3BHV21PU0VsbldiUkhYU2VobGdvVFdub2lzV3lL?=
 =?utf-8?B?TjRLdlA5RitlSy9vYWpKenIvZ0Q3R2d5WUxiZG9EMWtmSXhFaGZ1UC91d1lR?=
 =?utf-8?B?MGRSOGQzbzBzUDR6Zm56S3BHb0hFWjJtcjVzY2IwZVRsM3NGc1JFUld6Wk11?=
 =?utf-8?B?cHJwc1F3ZTJzS09nZGF5TUx1UERYbGMxVG5VTVkwazFaRUNqbUNYbG80eDI5?=
 =?utf-8?B?c1czRlIySXR0SkZOUVBmQTZJSkdDb2h0OVp2NC9jZnFqM080a0tnRTdLZFJP?=
 =?utf-8?B?djh0LzVyZVJ3d0ZUUUZZRWVXUVFuV0V6blNBZndxYVI4V0N0NG1IL1c0cXM3?=
 =?utf-8?B?OUdKc2Uxb2hXUi9nYjJ4NFNFRDFhNktrUjEzVlN0L25haEJtLytOdjF1cTlX?=
 =?utf-8?B?LzROSFVXSHgrOXpzQ21OVjZxZG54d3JabkgzR1BxNDNJK0wzT09zRE56Rnla?=
 =?utf-8?B?NldQazJjQkFmVnk2SnQ3TnBXNnJJMU50dWorSVBWV2MrL2ljRjhnZHFSN3Vw?=
 =?utf-8?B?OXZIbHEyZHpFcjZ4UDdPNkYra0JHTEJDSDB2blVJN3pMNHdXS1ZITXBxVkZh?=
 =?utf-8?B?dmJLK0xUNDBXTEh4VThyaWxzbnpmVXZxVm9TajJnc25qZTQ4MzlwSC8zZnVs?=
 =?utf-8?B?NHdXMlQrUFhsWmhaUGE2YTF0Vlc3dW40clhrY0poc3hlWUhTbkxqL1RPV25W?=
 =?utf-8?B?VGh6Y3d5M0QvMVlmazJIc29NRitKN0dScXBtL0VESE80N2p0S29oOVZDdTdn?=
 =?utf-8?B?MytnV2o3UE1MVThwTWxOTTJSNGZSL1lmNHExaEY2ZGpzMVBLdWViNlh0bVFh?=
 =?utf-8?B?UitndzJzZFV3dEpwOTBlcFE2Q1FTZ0ZLMmNmalRqNHp1ZG5KTituTWZ1K1ZX?=
 =?utf-8?B?NjJKYUVON1FoVjFlcGhicE5mNEErZVlnM2ZoNmFqYkdHNW1jcDAzdlg2ZnRt?=
 =?utf-8?B?TVE2VVhGckgzUjBJTUoyZTVXRXhrbG53cVJNOUZuUWJ6NHRDT0pmTkgyRlAy?=
 =?utf-8?B?YVoxeDN3TFVvaXBkbVBtN2s3TnF0ZkZVWUJUU2tEUGVnbmRNdGNaRXkwcGtz?=
 =?utf-8?B?anFJZ0JkczZINHRpcmlRMjRJV2NzVjRnU2h5ZjVTYTlRblR3bHFBRkN3NExS?=
 =?utf-8?B?aW5wM2F3Mkl4QlBwOXJLZ3h6NWhsODNBbTBRYk9uUGZ2SlluSmlIalF0QzFt?=
 =?utf-8?B?RzIwMUVjSXlSK0dPemdBbTN4R3I4WHM2SitXVDYrMzJHRW1nb0ZMQmFEdDc0?=
 =?utf-8?B?QnlubjltMzh5blZyQUZMMkU3dWxLZE84OVhuMmRkejlKMHRDazJSTjB4b1cy?=
 =?utf-8?B?TEdxVUtiVHBOVHBUdkRJU2xVczQzQVhIalR5b0ZRY1dTT01SQ3E3bGZTdm5h?=
 =?utf-8?B?cHkvUWlvUEJkQ2o5KzFmWndqVGNFSXB0aGJJbjJCcWczL0hLdVdQMnYrcWI1?=
 =?utf-8?B?RENNdTNzMlNjdFZiSWVrVnFYc2RkV05TZzR5YWdPSCtybmw4UWpCSUZpSVQr?=
 =?utf-8?B?TlE1cWsxVHpna3lhcDg0SFY5OTF5Mkt6dk8rUkdHcTNYa1l6NWhUZz09?=
X-Exchange-RoutingPolicyChecked: OvrRVFUoK1VjFVP+gwbAdW0CF60c7ghxD2MQMvzY2r9XLuF45vwIvMYXiIl/DEndnAE1gQYJWOFc3AAOXx0yOKzcDw2r280YfbcU6B93Ax4jHarnB6mfiv9sOJ2N3LYcCS7lJEmvU4wLxyP7r/nNCRSaC8Bd8MYww2IucWmBjvHga0oCxKcuQBSQFx3W0Pg0HQ5xDogWTZJR+L+SHU4aKLqb3aZPAObqj84XUldqnsDaq3xpJWHm64VhezQtBV3pqTgZQqbERquMnwfOJcTneJbqxXwmNu0uP+8v7XIMlyYzljoZ61HGXRTxNLleego8Dwu4FWUYygxed30QBEUiiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c09b0e-7bbc-4127-42d4-08deec312346
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 22:48:12.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFmfnPI7ZjTZ/Y+rmHoxTXKzKhIc0hlVHPpWz4RqnefMeuMVZfsT7lnvxGdxT+DGPI4Gl6iZafzgP6BugebJgqeBK6C26GYJLu3YqMAmAUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

On 7/27/2026 10:00 AM, Nikhil P. Rao wrote:
> pdsc_check_pci_health() queues pci_reset_work when it sees a broken PCI
> connection, and nothing cancels it. When the PCI core starts AER
> recovery, pdsc_pci_error_detected() runs pdsc_reset_prepare() and
> recovers the device, but a pci_reset_work queued just before is left
> pending. If it runs after recovery released the device lock, it resets a
> device the driver now considers healthy, bouncing the link for no reason.
> 
> Cancel pci_reset_work in pdsc_pci_error_detected() after
> pdsc_reset_prepare(), which has already stopped the health thread so it
> cannot requeue the work. cancel_work_sync() is safe under the device
> lock here because pdsc_pci_reset_thread() uses pci_try_reset_function(),
> which returns instead of blocking on the lock. Only PFs initialize
> pci_reset_work, so guard the cancel with !is_virtfn.
> 
> Fixes: 81665adf25d2 ("pds_core: Fix pdsc_check_pci_health function to use work thread")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260714180223.1642792-2-nikhil.rao%40amd.com?part=1
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 8d94a4d70395..1bdfa9893904 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -555,7 +555,11 @@ static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
>  						pci_channel_state_t error)
>  {
>  	if (error == pci_channel_io_frozen) {
> +		struct pdsc *pdsc = pci_get_drvdata(pdev);
> +
>  		pdsc_reset_prepare(pdev);
> +		if (!pdev->is_virtfn)
> +			cancel_work_sync(&pdsc->pci_reset_work);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	}
>  

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
