Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FF3F12EC;
	Thu, 30 Jul 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403082; cv=fail; b=Jcfsfy9gqXhRJeyB/lvL/GMoR219ldNEtBtJIPu+mOGbbUuUwKrcnJXABrjvqYJOml6JqDRVnpO8RCx2EfjL2oIlmdm54or45RsJMgdzEfr7gVD7wCItQfNC4KNjBLgtSQ/OmvOx05pMu19zEMvv4HiNjk1r1f2r6d1Y087sI4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403082; c=relaxed/simple;
	bh=mDWl/OuzU4kIlvqhfe7WyXriRVls4l4+1ZWdimC+Xho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5jrg3nCNRdvyN5g2Ibt3Sf8eQGNmKYIwuCFZZyDJzHP59jWzUe02dOOoU/as8P7uWeN326fSYuqFqiPExJa9diFpMdusUkHd/zZEHJ4xVkt7Jx6r4Le5v+6ppgfdnXBqT4zuWlFYEAn2c1/xHYNHRGf2sht8UwZVQ28vbJOCNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8DrTY1k; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8DrTY1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785403079; x=1816939079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mDWl/OuzU4kIlvqhfe7WyXriRVls4l4+1ZWdimC+Xho=;
  b=n8DrTY1kdpTSJdQ5fdAskJlOtMEEutsM0s34Y7jgxsoZudGR78+sR6yc
   wU+gWvaMNthkPFuhR05gcyMqQpZGjyGtpCp8sOyRHWg6OsVZFaztwK4gZ
   FElmaFOH9WiYOPgFKRdmg27SSn4AAXOXOmZVzKvSRLDtoyZsEjs0QbDyy
   7QMlTzqTJ2n0dq0TnsSsRb0VROcn4ITP6kijF7cya6HcqegBVD46Vng13
   +2enAUGZAwgGrxNI11HWZYuNkzKOMYX1Flj0r3MnCfmWSqWlbdZr3BN8y
   VXkzKl6Rw/ch7TPy9NmOGJOMvJaS+w8wFy7Opzot7wlOKY+JBjy1XBnL4
   Q==;
X-CSE-ConnectionGUID: tUffZ4soRWmGXoidQVZ42w==
X-CSE-MsgGUID: lUUCVHInTm6Zfc/bldZ6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86136730"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86136730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:17:53 -0700
X-CSE-ConnectionGUID: H7GUpAlsQ6u6s8If1ulL+g==
X-CSE-MsgGUID: 9xoVWmtcSXqM0jK1gJIwbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260851301"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:17:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:17:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 02:17:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGWZuGxbRa+FRyLldXYEo9gImX4GXQphlCwBDg5lV23+ie90B7XoIuYNxSEW8I5eNnDluzBdCE4DavFQObptQw9wi4sqzv56n+GzRaZ7CpdhAB/K/oaQb0+cXXPe4WtQu3TE9gbCI+tE4qjweYPJ7ViHc7BOPNf3dhSSqSBH60wqV7WtRlagB4lVL5uzckTzk2ceKgHnplWJg27OVOPnGDzX5DW3L2/xJJhrGcy1y/sKsWhdqIZO0SdYY+QXJt6ZIISP8hKFvfVaERstCif06/LcuoRhCVPkVWbQyKE8wxih6LpUptvmikbAst4hddYfGyHRDkdDXIAD0YrIhcAKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUZ1fPL2RVbFivsvEH5wux7js6SX0fqvcsKhPBrT8Wo=;
 b=UnRfDPC0mXxMUzMcSfYW7E7XMfUAYmDKlslPgpY1if/sWP8Cxjk6XPQuKB4LyO39da1PfXxe9DVeKK/9uLoY2/rNouxhpAyP44ohZo5TdXZsiRTgoyGxIHfMZnRNehD+zWPoGrdG18nVWRg6BsYI0jKNGJEXpDlBXcxws5DpOypLIw+naX+dI0B/vc1ImbbIv5uobVdHRlAEG3cyBb6yyw/c4FPBgdrw3xcP+iopivyPef962cjWXmOos2b5krtUlK6zTjlIV3ttk8sICXEjmYBAxroyR8azjGXRpSKsHVPuwY3s5i7/LJSBYbnBwcXV7iizbVF1tMenex4DE9X3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 09:17:38 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:17:37 +0000
Message-ID: <0773587b-b355-46cb-9f4a-f3eecf8e01ad@intel.com>
Date: Thu, 30 Jul 2026 02:17:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rtnetlink: truncate IFLA_VFINFO_LIST instead of
 overflowing its length
To: Jakub Kicinski <kuba@kernel.org>, Artem Lytkin <iprintercanon@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <chrisw@sous-sol.org>,
	<linux-kernel@vger.kernel.org>
References: <20260725132236.88318-1-iprintercanon@gmail.com>
 <20260729185513.52564971@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260729185513.52564971@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e05e1c4-3209-4a77-4519-08deee1b65d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|4143699003|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hTG+07xJ1hAiusSdTncra4yIx9OTYW3WRDpj9+p5u9EKfuM2EgKBZUkOrxzNxayGbOKkMn9EMhKZbL+B0gh5CWveaV4rooglj69dqRKm5Hg0QUbp6+sa/5aryN+uRrJxLw9eRny+bAw2MVBTHMSTx1myyt6CuFtCOKFTQKOqe4yn2U2FRvR72hxIkQADG5ef5LJDTiSWfc7oFOwcvVlDvExFuNSr1T/+Kk4tICRoj5j5NTJyDhJ9XmG8/ctOdBc4vCXimq8lTiSzx4Wocuht7Cg4lGPrUuQoAxirQgBU1FSR4SpBBzV59Bcpg6PKKHjmg1eY3oWOk1cYo0jN6mCIorugI0snac/LV4+pAAr4E3Ecae3QgaimY7mWHAs7kms8G3dFPdxBJ+TR/S6HFoDtgGXQs1iVlJZnK2hQrdUYaQelLfLq/g+4Z5A/qAJl5wGzWz3BogADnX1/awH/VUL8qYmPTYUgR8ojxsMLzbFbBkED1xA5kYYCjiqGqsNUB6yuUUpD2mBg3/tIh/SYWgKmrWHIirpFKauL639+z3xX7gzf3tPJ6DTGx2SL5H2URF1Vyw71OllCGr5IuIs/VrfjndItCbq0hiqvCINF6WyPei4EVtnfXCJBlZtj07EOw88L1/bzYwJEVxkQ+ZuBtR0jvqsarUtSbJMIRX8/bvmr0KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azgrd1U5WTdVTFI5R01LbG81V3JrNkhKUDVaOHNIdklKYit5TnA4S21GNDFB?=
 =?utf-8?B?bFo1bkpDQTNLNE9XRmFheS90RFVEWG5RMUFUaGN1NjViSnI0R1ZCbS9RZW83?=
 =?utf-8?B?cThEOHRpeUlXaitUenR0YUcwOGFEY1JkOXNrNm4wMStuTGg4NXpzNk80UXE3?=
 =?utf-8?B?ekxiSjVtaDJGRFNVblRrR3Bpampybng4N3B3Tk50RFN5YmRjSnBjd094U2R5?=
 =?utf-8?B?dnJmMEduSHZER1MrRXczdy95eTVqdHA3SGtUYmtOZlBZMzk4bEJUbzBhbFJC?=
 =?utf-8?B?bWdZanVST29pamRON0QvbkNXMlk3RnF3SkdkOTBYTC9PUVhiU1g2RGh0Mmo4?=
 =?utf-8?B?Yko0OU9PaVJvODZHK2JhTzMrbkR6YTBKNUJJbitYZktSZS9XUm5zKy9YWndF?=
 =?utf-8?B?azRHYUROSVFwVnc3Z09Ra2hSalVRS1FLL3orTTRJbDIxQW5sVk5saVkvcXg3?=
 =?utf-8?B?N203Y2l5M2Vvbk1uMWxBSzlCUVY3SHp2ajJFT2RhTmdWMi9LNjJ4NUdMWjBK?=
 =?utf-8?B?SS95bkdSSjc4dXdHVk5DMlZ3bXlsYnAyTWd2cjltRWZoT3N0YUYyN2tIUUxH?=
 =?utf-8?B?U2V1RUhaWGlRdE5QZy94U0U3T2M0U2pNWlkvWldzWTM4V1Z4bjRBMlFVbVYr?=
 =?utf-8?B?OGlUd25ybTNobmMzd2djdm8xZmRpaVlWeDJJTmxnWnNselNyczN6MzJQZUk3?=
 =?utf-8?B?OWQ2MmdRazU5Mlp4V1BhRU1SUDB6Q0o4MW9uOFdwdG5KS0t1M0pHMW9jandO?=
 =?utf-8?B?Q1BuYmRSbzZCZStSdHNYendLVDhaL0pWRGJmeHNkSGlLVnNlNkhBRXVuSVk1?=
 =?utf-8?B?L2RQUjNNVHFDaG1BU3dsWU0xSDFnbndnS3d4b1MzUFo4aTdqRTFLMkxpdzJw?=
 =?utf-8?B?dURTaG8vTk9FSWNnQ00zVkVYSGxsUXFNclZlTjhPeXg3QkRhbXoxaUNuWHIz?=
 =?utf-8?B?clNUaDJ4WjNXeDlCaEJuVkl0b3VPOG1kWFNGenp3U2tENk9ldjJYbmg3NzRF?=
 =?utf-8?B?eFVqWVh6VnpJUDJCWlhiNzZqbjN3b3BVN3V1b05RQk1DcG1HYmExeU5xZlVm?=
 =?utf-8?B?cGlBTzE0eUtBWVZQVFJHYVRzQTYySGpFRENKakJLMFNZZ01UZTFVWnpLdU9k?=
 =?utf-8?B?RXFBVGJiTkN1bmJkNlRpQ3lYV3NxanNDb1JmSGlNb3FqVEVUYWx5Q0kybE9K?=
 =?utf-8?B?aElpQWhzUU9LaEg3MzZBK2FNbnF1aWZhdkgzMUlhYm9TdGRWQ2haeUJXaDcz?=
 =?utf-8?B?QXFZakdJRStxaVVnZXBYT25wNkh6RUNQVTV5MjZZdDZsNzFCSGhTb0VaN0Rt?=
 =?utf-8?B?OGtreEpaVmFxV0ZZQ2xlcTd5ZU1iRkRyTk5PWElNelgrYzJQbUp5dE8wSlg2?=
 =?utf-8?B?VFVJcDAvQjZyeGV4NVQwa3NqbEhTWDFpYVdRSzZ0dE03VGRCc2lPeVpVR1JV?=
 =?utf-8?B?T2RiV1AzMy90ZkxlTGE5SGdYRzRibzlGcmZYaW9KUHNmRk5pckhzNFBiaVZM?=
 =?utf-8?B?cGljN0hqenJsMU1LQm50ajZyQTZkMmhTVmFUMHBPWW1rTXVSNmpkY0xxc1Fj?=
 =?utf-8?B?QWZ5SEZ6YTIxdXkyTUxEc1Y4V0tvZEF5Y0dwbTlPV0xFbnhYYStkdVpIQ2Jh?=
 =?utf-8?B?UnRTNDRRd2hMUS9VazJRZy9lczd5cDQ4dytLSWVkZnFRNHJndzZ6UzRBWVFV?=
 =?utf-8?B?amg5Q3JwZklGa1lsbEZCMFBlTlplOWFiZS9qYXFjRXlLZlpTcnZXUStPaGpp?=
 =?utf-8?B?b1g3ZFgrZEM1ZWlxSzU1SXlRRW15ckhmYTRoZmh3T0lrSEF1QVl1a2NoUGtQ?=
 =?utf-8?B?NE1LNEdsN3NqSmJ2ZWh2R2NRbDYwUTI0Q3daWHkrZDhJeTBlZUorQTNnMjBw?=
 =?utf-8?B?eDhTbXJIUU1rVVhITm50Q3haNEhVQ2dnS1dTUGdzQ0dKMmhoZ2sxeUlxaG5x?=
 =?utf-8?B?NzdubWo0ZnFzYUJkS1Ixd1ViRFRXTnhmSk9zM1BSU2NXYmMyMVQ5LzB5Z1NE?=
 =?utf-8?B?RVpzVENxT2xYZlk4aXlUL0JMN0tNNmV5MEpIeHpkZzdmUyszdzZ0MWdDdzl6?=
 =?utf-8?B?bDEyUVQ1SDJtcGVXNlEvQkZHUFo0OS85TkNNdFhvNXdPWU85aVRxMEJQSEpY?=
 =?utf-8?B?YTBxYy9jSGtsS24vNTYrdW9HdStSa2ZkWjlJMEtJZXJQYUt0citLMVRmSUM3?=
 =?utf-8?B?bUNEd2txcjI0NXN4TEpiMEQ3eGFSOGJQWnplelZjZVUvRS9rK1ZSblZCcjY1?=
 =?utf-8?B?czdweHhXMzU1Z1ZadUYzdkxlcTg3ZkVsekIyTEw4cHR4UWYyTExSQWdDdlNW?=
 =?utf-8?B?RzA3WUdkcmk1NEMzSkdFbWhuc05hYnZwRGJQdlZmc1h2MThSbTUrZz09?=
X-Exchange-RoutingPolicyChecked: FizhwdJvKtusB7k6pxcx8qJm7w004bO2VF8uU2CKvYjxFn+VlAzsI19k83oNJ86p7rPGv5D5y7MNvrfiZ+yQCbtC7xWX+xMPdyd2nwJE11EExrDPjbTBL0t/W4Z8Lua1xIfg/FkgmEeJZJH7mrRVUsXNpkW0erAxTOnddxd/2oVgBxqD46w43vAOaa5rsasJx69LeS3CZXfK8Kk0yNu6A1VsaIMuJc2JmezikvL4gNJjKD5+YBAz0ZHwGaE+WlUzG36J6eblQP+C8mVna3eBQaXe3oPq+vTqD2K3Cd393p381rbpRB90B1q1uWMEWVXrIz5Hmf76LHfzuBNRAP82Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e05e1c4-3209-4a77-4519-08deee1b65d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:17:37.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dIxL2pFc2sQuSuBgEOTLR9KFYHKdUtsxlcoJ/0JJ+tIhdpU6V+5hIQWxt0a0coReA1NrkjjIXv60hjwBJZhyQ9agAYlUXWCFHOQDb/t1wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

On 7/29/2026 6:55 PM, Jakub Kicinski wrote:
> On Sat, 25 Jul 2026 16:22:36 +0300 Artem Lytkin wrote:
>> rtnl_fill_vf() closes the IFLA_VFINFO_LIST nest with nla_nest_end(),
>> which stores the accumulated length into nla_len. That field is a u16,
>> so a nest larger than 65535 bytes is written truncated modulo 65536.
>>
>> The skb is sized by if_nlmsg_size(), which adds rtnl_vfinfo_size() for
>> every VF, so the buffer really is large enough for the whole list and
>> none of the nla_put() calls in rtnl_fill_vfinfo() fails. The overflow is
>> therefore silent. Userspace then walks the message with RTA_NEXT(),
>> which advances by the stored length, so parsing resumes inside VF
>> payload and the top-level attributes that follow the nest are read out
>> of VF data. Those are IFLA_VF_PORTS, IFLA_XDP, IFLA_LINKINFO,
>> IFLA_PERM_ADDRESS and IFLA_PROP_LIST. iproute2 prints "!!!Deficit", and
>> strictly validating parsers reject the message outright.
>>
>> rtnl_fill_vfinfo() emits 296 bytes per VF on a 64-bit kernel with
>> efficient unaligned access, so the nest wraps at 222 VFs; without
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS it is 328 bytes and 200 VFs, and
>> with ndo_get_vf_guid 336 bytes and 196 VFs. ice supports up to 256 VFs
>> per PF (ICE_MAX_SRIOV_VFS), so this is reachable on shipping hardware.
>> Requests that set RTEXT_FILTER_SKIP_STATS need 335 VFs, which the 256-VF
>> limit puts out of reach, so plain "ip link show" is fine today while
>> "ip -s link show" is not.
> 
> We should cap the output at known values and document them as the max
> the interface supports. "The number depends on attr set and random
> things like CPU alignment requirements" sounds like a terrible uAPI
> contract.
> 
> Perhaps 128 with stats and 256 without?
> 

This seems reasonable to me.

>> On CONFIG_DEBUG_NET kernels nla_nest_end() now also splats via
>> DEBUG_NET_WARN_ON_ONCE(), added along with nla_nest_end_safe() in commit
>> 1346586a9ac9 ("netlink: add a nla_nest_end_safe() helper").
>>
>> Using nla_nest_end_safe() here would not help: a nest that does not fit
>> in a u16 will not fit in a retried skb either, so returning -EMSGSIZE
>> would turn "ip link show" on such a device into a hard failure. Bound
>> the nest in the writer instead, as suggested when this was last
>> discussed: drop the VF that would push it past U16_MAX and end the list
>> there. Userspace sees IFLA_NUM_VF unchanged and a shorter
>> IFLA_VFINFO_LIST, and everything after the nest stays parsable. An empty
>> nest is already emitted for a PF with no VFs, so a list shorter than
>> IFLA_NUM_VF is not a new encoding.
>>
>> The other large nests in rtnl_fill_ifinfo() were audited and cannot
>> overflow: IFLA_AF_SPEC is bounded by a handful of address families at
>> about a kilobyte each, and IFLA_VF_PORTS would need more than 560 VFs.
>>
>> Fixes: c02db8c6290b ("rtnetlink: make SR-IOV VF interface symmetric")
> 
> Not a fix - this is along standing limitation of the interface.

I'd argue this is a "fix", as we were previously doing objectively the
wrong thing by randomly truncating the message at arbitrary points.

That being said, this *is* a well known limitation of the interface that
has been around for a while, so I can accept the argument not to tag it
as a fix for net.
