Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7523FC5C3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219095; cv=fail; b=pj/3jmF4S4UtAGT94MlggxT22gApCrLJyANy0fzm4k1A7QVcbd24rnMnOXhvCCXnPiWrZ17hiAZ8VAS6uww+5ooPG1/j+W2tU+Enh0Elp3RH3bCa8NS5+33iKpKr2bPW7jWL1YDnCUhU4R5JfXovMMJJrlvZRLZ0VohZttrQd8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219095; c=relaxed/simple;
	bh=5aZO/yVWjSb//tE191Tjwn6Jk4f2QifJvGfQrcbVD1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUl0m4g05AHoQtxedRrFKmf53AI3FuDmfknKtr24smT1cf6RjT0wwNZlHicWXdPi4NcUBOhZpjG4CJyh+OopHo2dEUt37bDzePCaiM48kYNUTHnEVYdQzQPPKyqIwZLg+lOquyLGOt6Vkj7vGnJp9WSC2hsrGS05lpE/07UGfgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Es+zghGy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Es+zghGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787219089; x=1818755089;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5aZO/yVWjSb//tE191Tjwn6Jk4f2QifJvGfQrcbVD1I=;
  b=Es+zghGybEAdKAD2mEdayQyvN2bb0F77+MAdHfUJmrekdt2vr5p1utCV
   Xg4D/T+YALE5lYDx+/fqEVuLJzEa1LX0GZEwx7Y/97b13l7wuqXtuL+qP
   tBaz25TjbVD9Px0f7NzcqpMJvMB6EXSCe66ff8kQzV5ygnQ5auKFXOPni
   gTxP+PaGF2Pk/qbOuxscAhFDP+KzFQ3pRU4l3SqnEX0FDIid/gHLVqNon
   dXl4SRhVuzcOQ31OZx95bf0RHvhLARaywaM4OgrZDTI2K58MjZFZEe77F
   5uG4Rwb6MwcXO2ZD19eQYIoj2cxVsQGvz9U4AOME7mxQ+ftmpkPMo0WBY
   Q==;
X-CSE-ConnectionGUID: lkswRB0BQ7GkPERKJiE95g==
X-CSE-MsgGUID: t08VjLb9RC+w1gu6p81ZlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87955366"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87955366"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 02:44:44 -0700
X-CSE-ConnectionGUID: H5b2k1tkQQGA27GfFkCkUA==
X-CSE-MsgGUID: aeD4dbgdRsuYUTDWaiC+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="295864552"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 02:44:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 02:44:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 02:44:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 02:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoCvyI/oJtwUlxoFMGD0HTCABs2uqQ4TXoUn8wahVj/F52Tn4E+cEyXKuAS06Hz+ZJY6hSemROsvL43/cZjO3psBBAB2bX02G183WnJeUwzq8+/sZDm9uQSKCWtPzCAcdfvTGXY5dupliyB8JG1SmC7lfxYe9SQMFdgY7IBHxuyx94DCtsf1qYwFT9mHYLBCGitydkEqc/6TLy68BeYiETe7A9cu0C93lFIxzJETKQpONQYS07byCiDaGsQJ6S0WgzyabwmyJYkHj50s66XquEUmS9v6EKC9ZN/20fPFiQtbCb5Y3GBYgk6c6WPJpVJCAZ/DXiZj6IQsO/b0tECzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+9ZxbUVIgLEALRWwcsZ+c08EVJa+KbFhOusiGpd/ho=;
 b=WtG1/Dq0lb82qYqgyxrA1017biBEwYoMKaOGdXinw+92i2Mcjgw/0S7GJgAMdOVbz8h1qcvI15xOwmNtWzL7WkIZWOhhx5dUMnUz4sdg53s3jXKOVkapBDR9jD7yltm7FeFqxwgzjCtGv2Gdq3BXdq5a4ccdv7egVn0EqmtvAlZRaeuVuKzuWF5DU6tLpKSmy/fPL+8veSp22s4vD6HCH6myk3Y6qypegwtGDg3/54XL+z0kz/Fif3Fao/OhRcWj2A2eswYAEaeSQ/8mK+7nsJRcfF0P0I7pyB1xZkhk3HuZKsbCAFHpGc6mHk2ykcvjYer40zt/M8Tm8gltxuXGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 09:44:35 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 09:44:35 +0000
Date: Thu, 20 Aug 2026 17:44:25 +0800
From: Philip Li <philip.li@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: kernel test robot <lkp@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <oe-kbuild-all@lists.linux.dev>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com>, James Chapman
	<jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on
 seq_file release
Message-ID: <aobMefHEAq/5XBQu@rli9-mobl>
References: <20260810141125.1176545-1-edumazet@google.com>
 <202608201604.4Zj72hcA-lkp@intel.com>
 <CANn89i+BZ8HgXw5KYGxMRAoFMsfvk1GF289E73=PCN+x5n15dQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+BZ8HgXw5KYGxMRAoFMsfvk1GF289E73=PCN+x5n15dQ@mail.gmail.com>
X-ClientProxiedBy: KUZPR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:d10:31::11) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b306f6-5554-4564-9dd3-08defe9fa4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|18002099003|56012099006|22082099003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ftCaUYuBI3fPYK4T35iNJsdacTvt+Ftc9J54IKxDGtzolMoM6dtQMACl8rTT4ifh4F+b/2uZ4QEB2IZq9/zi1Ry2b9fD1XzajOVZS1UCcEeRXCjIKAqMhk7iT3mDBG98ZigWys3hY7i43iRlcbE8+CyzxeHH/tRLro3jDK184RKLPCIOPnXHI+g8J8lDCAakkD9DX56ZIXpgIh2thW0Siz8jhUVLRVvm9kMB6X4uG7FOYgeJSY5TBEyamhlXOW0XRxv7n+Mok78u9VRMb+KcY+j53vEW7eMuJYslgCmPnyt06zRLu+ay0yUmHzkUDcp7O8GRW7uCZnq2FV+oKDi/9aJQoZOVHjjhhDmP2aoyShcmSy2ldH32CwWvXG3K8HP+s80jxpxpDv0pAuJUKe6R7t0vAFqF374ijyOypbA30IBEUICp+FdhbmOGS66ZDXg+Ip/Kkm44XExHt2j74TMVfTXC3YdRwB3aapdrhg+CNFex3i/6DVUVdmMs3WLVWxTfPyf6YqKp92m+3ODjKEFcPIgAo3UTOlkBnmhaxJCCC029RgSb1B5DsfqLPRKMpXsdaGCitgznahjRla+M06v8Q0q8woWBmgirxQSynjybm/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJFMWRDQml0c3J5MjUyK2w2c3ZtQnVXU3hGY1A4U1RlUWxyVGNxaHVuVEFm?=
 =?utf-8?B?SWVvUXBUREdnWXVKK0VpRU9WYSsxdUJPQTBYOUVDdHI3K3NMWVBURS8rM3ZN?=
 =?utf-8?B?d3c4bE9lUDdxallSUTNDYUh0b01vZm51T21TKzI2YTFWQXJCb210THBrUXcz?=
 =?utf-8?B?d3RtRjk2bUtya2Z1UDducmxKdzlDeGlDY3VDT3FkbjBPVjNqVFhRa1U3YmUw?=
 =?utf-8?B?ZnJhU1hSeDdwd2dOSlp2L0Q0MEs4S1lxN2hGS3JLTVQzQ0JvMnEydkpIbzFl?=
 =?utf-8?B?ZzBBN2g4ZTlPRUNsMWVsejB3UkFVQ0JzclFpeGVyWURMQUVSaDBKcUN3Vzd6?=
 =?utf-8?B?NklqdmFTT0VTdGdXREFKR1hrOXc0QXlXaUtXZFRwMkthbVUzKzdpUHVPZTVS?=
 =?utf-8?B?TXN5ZDlRQmNDQ21aWUl3T2Y1RmliMkk4WEoxWUVKU0VDdEF2THQ2cGt6ek1Q?=
 =?utf-8?B?enphS2FHOUhoRzQ5NFNXZlV4blJxRzhCNHBTbldnczhXVmxMU3BFQ1dFUzl3?=
 =?utf-8?B?aDJrZTNvMkxTeXlZOUJWMGN3OUZQcGR1ZFFXVEFYVkhmTHhEYk5wc3hmWEM2?=
 =?utf-8?B?cmU1U0hNUmcxbFBrSUZ3VHp4NXJ5MFk0ZENUczUrRUZtVkRnUFgwU0dDdHph?=
 =?utf-8?B?ZENtZFZnbjloNGNiTUoydHd1NWdVSHFqNzNkWllLaGdxSE14Q1pMRDZlSVo2?=
 =?utf-8?B?ZExFZ094Tms5QmNtY1NtTUM1WGRjOHJOSkczTzY3MVErWHhiMHhvWUEvaUFl?=
 =?utf-8?B?ekZzcWtZYU1jUnd4alBjRkltNnZOeGF1ZEhtT1IxVjl2Q1VkcGdpcmN4ZWNh?=
 =?utf-8?B?K3d3emUyU3ZKWHZYdFQyeENmYTNRMGRXRDRSUGxDbndUN3dRa1hGSlJhMnJn?=
 =?utf-8?B?cnpPNGRFdk1oZlNIb1gyYXJFbFVRY0Q0RTd5V0M3M3d2YzA5UVZTTGlndWxa?=
 =?utf-8?B?T21sdlZKUnY4S1FyTnZFd2JtbzBVVmV2VnRENG5ObUtSekFWZDhXSENFSUhQ?=
 =?utf-8?B?S2xOcHU5WjMxWlozSkRvSnJKa3A0YmpZQTJiOHoxclNWZm5wbUhiWjA0NG81?=
 =?utf-8?B?clluR0MxcDRWaW10ZnBwS044SkJ4Si9MNWhhMU1rWEg0ZGlrakNCbXV0WjhZ?=
 =?utf-8?B?WDMyWVhzTEJKWU1sMGlqcE41R2hOMDJ2aElUOVU2cERnaU1ETXhCbmZJeVN6?=
 =?utf-8?B?cE5nRzl0UGNpRkJEeU9RVkpwaWo2WXRXRFpuU3VPQkFEdExEbHgySmFvUUIv?=
 =?utf-8?B?V3V0ZkVFejZiTmY2SjZyNGZzL3lkcFp6TmZFSXV1bGJ2dkxDZGhGN2xzV2Zp?=
 =?utf-8?B?aTkxQUFzN2NBTGlwd2JHSzJaQisvYjYwd2tqcnRQVk5EZTd4akl5N1F1Vysv?=
 =?utf-8?B?bnhMelhyZnhBSy9LMW5IZFU3aHhzejJFazR0K3RYeGJMWUxnR0dlQTlQbysy?=
 =?utf-8?B?TENGMmtvTmMzWU1XRGJpOUxtM0hNS0FZOHMxelUrYUIvNVNORVBBd1ZlQ2I1?=
 =?utf-8?B?WEJHUUNDdUE3MGF5dVJ2dGNKZUJMbUdWV2krdTI3dFg4VFZpTVNyeUpJTnZt?=
 =?utf-8?B?RkYrbUJuSWNXd1VpMjJ5bGoxcitkdzJXMThBb1J2YlNSS1hkWjg1WEo5UmQ5?=
 =?utf-8?B?ZFVzdWp0RGljSVNSSkFMekFjekx4ODJxbFl4R0lOME9HL1kxdU9YL0d3NDZD?=
 =?utf-8?B?LzVCTTJoYnBmTndpR01yNFQycmQzYWFrT29Gc2dHSGdQdm9mZnR6ZEZTZXBw?=
 =?utf-8?B?Um15YUxnRSsySjZDYzRSNkdwRUJiWk9uczZJRmFzMVF4UHltVTA0UWEyTW9o?=
 =?utf-8?B?NW5WTnl0eVNOczd5WGl6ZklVeW1HVE5vNUZnS0NMZlNTYTI3ZzkrdkhWanNa?=
 =?utf-8?B?YkZQaWJXL0NTYllTOUo1YlVLQWJjam5JcXk2VFM0dmVVWFFZQ0U5M0hHVVdK?=
 =?utf-8?B?YWJ3VWYrekMySU5LaTRtR2NSM2JxNGp4K3J1WjVhdjRVcnZwdFhkWkIvR0R2?=
 =?utf-8?B?bm15VURUeDdLMFhPK3hYSlkrcWZYVVpMR0xPZXI1M3NVejJLWnJaK0J0RWdP?=
 =?utf-8?B?T1psOUU2VFdRZ1ZKUjVNM2ZheU5OWkI5L0RhUThFQzQzV0lQZHVaa1d3cjZz?=
 =?utf-8?B?eE5oYkxSQTd2SmhrZDNxSVRiOTB1MW5OS1BrRWRwVFhER0xBQndDK2lQVU9X?=
 =?utf-8?B?T1I5bmN1eTdwdEZrMi9OZUVuMjV3a1FLYjJLdTltS3pPRExpWGlPNW1PMHZD?=
 =?utf-8?B?NzFvUTVJWjlBd3h0S1dhbXhpdXVQSEFEaUNsS0pvOFdSVUNqQmMxK0x3ZHJI?=
 =?utf-8?B?Nis2SmZtSituQ1cvTWxuU3dHMW5ZQzI0NmJaSVNJM0NhMjBRM1BZQT09?=
X-Exchange-RoutingPolicyChecked: JeT5QRzCVYvfvJKbX6TKyUOkTRr/mpC9pK5nhuKs5FD9dl4GsQXOI3SH4gQR1NcDzQceC3GogBw7hfXVrlxHlMcWAV/Y3LLQ6BlzicGzM614RktIVoaAS07nUk/mG8o+O7Fd5zHJ/7NRGywUOy/YVmHmc3n6S4bL1DqWZH5cyD5qwzXYZ6DW0qT6eekMrhKf0YTMRQw9R6hue3+BElQYw+qaHA7qN+WTqfB+Mr8zMotSfeTyPmKClPOwpP9Yj+8LfWuwN+r8aOKsVZLTpddWtv855aX49y5md4NWgzwItatvrctkbL387gdGazn5VR46BTIXS83fLz42AN4ulpWOTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b306f6-5554-4564-9dd3-08defe9fa4b6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:44:35.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItHczgZItjozgb8ne4JyZU9ZGSLLDetnEteqliIEafGZ4NhAn9vwIGyNbml/9UrRVi/kF9Prq19GxP2c1s9c0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 11:19:46AM +0200, Eric Dumazet wrote:
> On Thu, Aug 20, 2026 at 10:13 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Eric,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on horms-ipvs/master]
> > [cannot apply to net/main net-next/main linus/master v7.2 next-20260819]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/l2tp-fix-tunnel-and-session-refcount-leak-on-seq_file-release/20260810-141125
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
> > patch link:    https://lore.kernel.org/r/20260810141125.1176545-1-edumazet%40google.com
> > patch subject: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on seq_file release
> > config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201604.4Zj72hcA-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 16.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201604.4Zj72hcA-lkp@intel.com/reproduce)
> 
> 10 days to test a patch is unacceptable.
> 
> Please ensure reports are not sent 10 days late to avoid spamming litsts?

Sorry about this, the bot account had failed to receive patches for a while.
It is just recovered and starts to test the old patches.

I will configure the bot to avoid sending results for old patch to avoid spam.

> 
> Thank you.
> 
