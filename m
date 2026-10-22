Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792693187;
	b=byWGF7Gyo3qGTV62m15odlv++unQVu5k2NxB6yw65KmT1agNx6R00E5/OZIQPAp15VJO
	 G3LMwQI/xTnBAai6ssPpScnig0X5LG1QtxXBfF0VUo3OYYokPNeVW8LEJQ0+c9whWI6Z8
	 UYTbdKsIGqAVs6dqK9WabCJWnj9YFXbO0KIeRdVwKoBGfkZCpZak2phktAuscp1DYROOo
	 GFKZ+JaxQvDkYUirVFfJMktJdkBT2+uPh1yeFnr3dtOuQbSYOtyQJEYTioF2an9cmKJOJ
	 O933+rtAtP0VhwIHLD4vAq9QKhA9YSU61Nu7N8PaPR5WToAf8xRUsApVRPp9j9SuIRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693187;
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
	bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
	b=i7PUBow4k7UJQBHJfbYviuSSVzm1EsqihjXsxWfnT7KlRiLWs79dS2Z3UXi77X4C7p8P
	 ls7XIEli623p3hcE3k53jdJx/oRkY0dpJe3gCL8aiwWOWWDIEFupRcpvogtpSnX5CkivN
	 j+9t3OpfhCuDIxT8msqogLhDm3H0lG5jfqfY23KDskSZaYd8MOU2GgAhZ7l21TmTZVmwl
	 YKBPRUk3YeyFpAdznLEu8vtRGGLBaWl74gNHtuXvZIdFfQNchGylnQzdnxTD3PicKKn6U
	 2Ewz9/XOf3RSu7dThzv4rFz7ll7zgDtG/+22lHHFU7Kbs5ibSPojDLRYX8jG35aqpZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxHSHQqf;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B1606A32A;
	Thu, 22 Oct 2026 18:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2B1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxHSHQqf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792693185; x=1824229185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrZykq9yUYTWChJuuB3jArY1v4OfsCRgbs5pZRzXKRw=;
  b=CxHSHQqfyfGz0ykT9hN3fzTpsC0FwMeDW077C2FbxnxPB9CzOe4UNn2F
   +EZLHBTMxY3A8HvMeAbVVAdqcIQptF9PAJ845Yh5KfCQxzbJZ3GXec/gf
   iFtqPh7vZoo4WxDLkfGirpdj9P3tQmSscB/rvXLmFFPyaNEWHMqO6vWOj
   +3uWCer5N0c+dHJEDllmNS0GfZo9JrMHmbxDnCIye3W/SlTQxBJcZy5+k
   FHrDBBn9NKyLCyOISBEXJZY8kvhwZys9FLQeaGhTq5sqXfG7cy0FmDUJe
   LCTVd18GQESKC6qledU0x14nqlwlqZLnL2lKCQtQV4C8zOzpElwWalgYI
   w==;
X-CSE-ConnectionGUID: O7vUXo4HQpG1wgzzuTbaKA==
X-CSE-MsgGUID: NihD0o8kTg+zeOHdldHALQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1438513"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1438513"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:19:45 -0700
X-CSE-ConnectionGUID: sSdsEXAqT9+Winc3k6XjnQ==
X-CSE-MsgGUID: 6zr+yn9/SDWMbIBOlwCp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3516847"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:19:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:19:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:19:44 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adIkT4f/W9Hf6X91K9IDRqYe+Lj8xpfH3Y7Bkb+01sSLbOFMTX+kabu0O2tamLOwGEqNt09wozgIvWB6lMdSji5MTvve5cSyBPxE1I6OOlSKTdjx9s7mA4vpfu2vWAuvNSEvdKxj0yFquWnOBom50MTXfhck7piDUBX2N+g55yi99eQF1MwhOOrbfOkgf29rrGiY5svrm5zuHIUUEQZMrdgps/DwHNCi+/tfvSoRo3nBwoR8UWs8gdDttpqbVMjlkdYLBOcyfBq+MJTvzoZ+dX8rF0Egm6VgDlwsWuvVdCwyzyWX0BpoCtUDnXo2xjQOI6AVXQC/49lKqOVB7q3YmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQc+aIiJ7s8hgiGfMxXsehnerRuHRfXguO3PbQChDkY=;
 b=E8zei+c+v3f20tNptcO68Xo88KxrGg5NaxwTgFIEBQwIk/pLvSofi/sZdLWTsy4Ea7dz0lNx5iloG36EyTAaInqdyILy2PxePLrSaOTGrvWZftjJ/qJnzl5x7C9XZ0d7ZNT+I9dA/bqd9DB+WRjeIqaIcW69rAxgcfQMThbmFecQry2rlUc3KMO4MeE7IyoxnCxk7MLROlh+LSSggX1yX18waALKQyFBnTJ+mNeWvBMfJjhz9g+5r7P48d6qRfoUUkR+Z24BrTSBZvuJxW2MDBvyh0cpYkxxaYIihV5qmUR4Pg7Tb/czC9zv1RRVtaCwfqe5bt3GYYbYX3FZlzbQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 22 Oct
 2026 18:19:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:19:27 +0000
Message-ID: <1232046a-bd51-4dfb-9eac-720e1a943dbf@intel.com>
Date: Thu, 22 Oct 2026 11:19:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ice: scope global configuration lock to the adapter
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Aaron Ma
	<aaron.ma@canonical.com>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
 <ac4fb583-4721-48ec-bea5-ee4e7380f606@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ac4fb583-4721-48ec-bea5-ee4e7380f606@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7c600a-2450-4bce-3fd1-08df306901f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7416014|261022105027099003|261022075727099003|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003|10067099003|6133799003|261021121427099003|261021135927099003|261022113327099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5yzU4HmM/m+mIIQ/Qlf+QocFOZwfj8n0MMeFNrEjfxfgAjXutxn8+EkHFypqZUrVNenXv4qN+TIFxdrv7xNLsMnYGakD0QamzcBlFOdmNyAwCf/V47hArK2PDH6Bi+nThR8QpSDNsjvWgU3W2BVCYdYhrM+hjPkD5U086Z9nV0S/8IhdYOOl4LeU5vXDHAsactY1Ur2/QQ7YhSzzPdBkvmiMSLlk7xsRZlyy2wWj/xW9U+j8DX3wSpYQO+yD6nyQ8jjTJK71MbgHUIGmYFQlJuHoPObe6Ri+zlIuMtNQAu7PqVWUdOIieRUObexh7m2MMaEDL83Sah2SBeoh4Fel3qW3BoubLTqyR/SjCWwGeifS2NroMFeFt1XDJMQwjbB263nqfZ5SHyD9mwe3yaBe3BcCFYLnK1lZrKr3FO7Vz9GRLQ/g+g1MhzqVGgXL42OHnr6TaYRMZqY4t7BBxdsbFvX/H5qFi6clIkeSfIlKPzSjG9uRY2zsOawKkY39Uul1cTrofSm+om1DKz2qCijXBTKL62yBhi9833KbTokfGjB5sP5CIiALIYk4Le6hKdCxrcyHHx8fxshLtubfHQ/p4pv/bnwu18s+IHuWKyc6MR3idWKYbjkp0YmdFSi085wy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(6133799003)(261021121427099003)(261021135927099003)(261022113327099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1DUzJTTWExTVdLdWJhbUpoQy9WL1oyZ0FhTUE1YzZNeW8xYWZrc2l1RWM4?=
 =?utf-8?B?clMvNkRlaVQxYzZsWWxMYUx2TWJFL05qV3ErRnEwWUxSN1o4d3NFVmdOT21w?=
 =?utf-8?B?QU5oQmVLdUNNTmlRdW5TOHBCMW5ZZVRpMHZydVBZaVpiSG43cjdGZXZTVVc4?=
 =?utf-8?B?WUs0Y1l1aThJZVZnTjVQQ1UyaHBaY2MyaEU1dFNGZTBCRzBTeW5zUlNEMlZy?=
 =?utf-8?B?MEY0akd4Ryt3WkwyaVo4a2dIVU5rUjVWQU9EWndWUC8zNGpiS3l6NTBHdlRJ?=
 =?utf-8?B?bld0QnlHeUhCT2J0ZlV0YVZJaTFsUUdHM0tkTVlEbzhDQU5KeFovOHJXbTJP?=
 =?utf-8?B?cWFwM0lXU0poVGR3TXJtRXg1T1Mzb09XZ0Z2RTBxU3o5cEpwNW9qNXQyQm1x?=
 =?utf-8?B?VzNhK2ZvblBNZjg1UW8wLzlrVmtEWXcycGZPdllUSkZ6Tm5GQnByTzZ2QjJI?=
 =?utf-8?B?TnkzOE42U0JZY3dqZzh2QXdRRTQ5bDFST2tlams0cXNta1dSOExHQXlOUnBX?=
 =?utf-8?B?V0VnSTN2U21mVkxxNzRUSFFjWUdod1g2Nit3bCtxbjdQKzJCUHVIclp1bTlC?=
 =?utf-8?B?NDhnNmhUMmhWNERTcDdKMnhKS2F4ZjIzTEQ5QitYK0g4cWVoVXRaQ2FrYkIw?=
 =?utf-8?B?cUJqaW51Wk5wbk1qOWpKaGxqT2crazFaS1g5eVRiNEdydFZ5djBmSVVoRmRn?=
 =?utf-8?B?T3VQdnJsaGt3cnUwc3k2M25LeVdRdllWMnhCT0J0UVVRYkcvR1hkV243ZXJK?=
 =?utf-8?B?Y091VUJBQzBuL24yNEpsdVJoMGtWd1B3U2U2alJCWUlzQWtnNEJRazhYdm9K?=
 =?utf-8?B?T0MxN0gxTHBFQU5kdExuOUxnTUZKem9EY0hsQUtydHRkQXFzMGZxSEU1YVNK?=
 =?utf-8?B?cWQxR0pqT2grckl1SzBzVnpURForcmZTQkdKWUlNa1lJQmFoSXkxOURwYllq?=
 =?utf-8?B?ZzI2Tjg0aXMzdnF2WXdvbkQzbkJZbkVsVGZTYk1INGQ2VXdpaS9KTndFVkdD?=
 =?utf-8?B?N1BVUk5KaThPMXVMSHV4RUVUenNIaUZEQjlzSmU0TkZiaFdCSEp2NlJ0ZFVS?=
 =?utf-8?B?aFFoYUNTTlpQVXJGTGtYdjI4MndYRHZJa2RlK2xOY3hKNHBRNFBEYXo5OEk5?=
 =?utf-8?B?VEJjbUZxc3pOR0NISnFJT3Vkbis0SC9JZ0hienFSUThxSlJuNkVrRVRLMENV?=
 =?utf-8?B?UmNwdUVwcTFOdk01NGoyb204OGFjdU5NZWdjNkFQTmp1eHJDcUxRVTIxeHFE?=
 =?utf-8?B?WG96Tm4zTThKeEcyL2RXeWVlZlluVk9iYUF1aExCNG03LzcvUWhiZmtqVzIz?=
 =?utf-8?B?aWRmTDljdE9uZHFlWHN4dzVkRk1oTWNrM1RZb2FMZmZQQVRnVmdWdWpFMVpt?=
 =?utf-8?B?aU14WjBzUWtrZFpSMXdkaTJHb2o0WTdxdTBtWFd0L1VIOTIwYzBzUTUzZkxO?=
 =?utf-8?B?MVlwZnhrL2t2MlBBL3RKdW1paDJCSlo5ZlNWM1EwZU1NcUN3YTJBb0VNLzZF?=
 =?utf-8?B?VGNtYnlTSXBkY2syM3ZYeVp1QzFZa3hnUFM2dkhWb2ZlTis0eW9nTUJXb04x?=
 =?utf-8?B?eUNyUWxyTFE0M3dwVFV4Q2VFK1FiUW44SWVpZXZXTHRlZHNoSGs1eVBHWmxz?=
 =?utf-8?B?elYyQUtSSGM4Vms0Q3hPdGp1R0RiY0NETi9LWXRYNnEzZW9iM1hya2Rjb3hZ?=
 =?utf-8?B?WmJ5WWVyL2FvakVYWkQyUGFqM1NkOHNQWEpQb0hhU0l3dUs0eUFiZHRQLytS?=
 =?utf-8?B?QXhtbXBlb3ZvMkltZGgxOG5vYVZzME5uV0U2bkVhRDEwY09IZ25lc0Y4RUNv?=
 =?utf-8?B?T3NneXIyMW9HclRhdkgvSXRYNkZjOGVpbjEycVhibzNsUU9QczRaT3dwMHJV?=
 =?utf-8?B?RzFuZjFSdzhqZDB5aHFWK1NIUXhYTlNLS3lmbEJyMisyWWM3UStwZVlMTXFY?=
 =?utf-8?B?K0pzZjVaS1NDZ1hRdEFUV0wwSzV6VWQvR3V3KzdiSzdnakJQeHNxTFhTa2N3?=
 =?utf-8?B?eEk0bTRralErTlZ3dFBQM2d4M0NmbUpRalpSVXJ6NWUvK1lQL2VHRFA1RDBU?=
 =?utf-8?B?M2NHcy8xemgyRVhadG5jTDZNeHg0aU5WZG9pNDFqZm56Z3hkaFNmZGNFek1S?=
 =?utf-8?B?WWV4ZlNuczRZWWtQSXA2RFMwV2p4S3NOekwybXg2aFJUOGYvRmN1NmViMG93?=
 =?utf-8?B?MnRqQzl6bi9JOEpnTjNXMlN2STdaK2wzTURHWUg2R3p1VmFvcDB6eWtVQUc5?=
 =?utf-8?B?d2YxYno0Zkt5YUdoVzIzQXg0YlF2RTdUZnVxdXYrM2plUEhUaTYzajV0Zk9R?=
 =?utf-8?B?QitkMEhFQm5KOGJzdkJPSnZENmRBZHV5RG5PV3ZtV3VMbFNBelZybzZMTjN3?=
 =?utf-8?Q?Cl758xc64Xf55iWA=3D?=
X-Exchange-RoutingPolicyChecked: FwvsRM8YM+xgRa6N1ul+YPj6VzB7yAjZt0K3mYr9z7/No5y/TZkCy+AlTiAfySqs3QGLgF3DdZ/nsUEUx8bVxPn9vnd5/HWsGR4k5f6POTM/9RnO5+Od0VocqawIJ+QR9mMSYfTypIH9LjkQ3E6Ozl7TUNLdvnG/F8mpraaQDrNbOxzvIKE9b9sRoo/SsAdbjB52NODQeIV0fELLxxmWON31BLaQbhU1B9GezYOKgCkwjbPCJyOltj4e0/eGBfijnGibaWU60YbO6bAeScGYMUUR9rWaPTvuwPFwQ/1ITLPF+WY54SdMOrJGE1qlF+P8IL67FRpFxapN6pfKMN3KYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7c600a-2450-4bce-3fd1-08df306901f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:19:27.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwtmq2R/wWtiCojp6lUU/Afdi8xR1NfowqR9WgcxKDEPkcfw08gLATsZfTU1N2ieU79+Fl4O/suOnZEmPXsZ5sveOddmep8DU+Fak7gWPMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com

On 10/22/2026 4:10 AM, Przemek Kitszel wrote:
> On 10/19/26 12:51 PM, Aaron Ma wrote:
>> ice_global_cfg_lock_sw is a module-global mutex, so a package download
>> on one E810 adapter blocks Admin Queue commands on unrelated adapters in
>> the same system. In addition, the mutex is acquired only after firmware
>> grants the Global Configuration Lock and dropped before firmware
>> releases it, while the opcode exemption list in ice_aq_send_cmd() does
>> not check whether the caller is the lock owner. Non-owning PFs on the
>> same adapter can therefore submit exempted Admin Queue commands or
>> sideband requests while another PF holds firmware ownership.
> 
> This is not a bug to allow exempted commands, does not matter from which
> PF.
> 

Its not strictly a "bug" but I do think it makes sense to only allow a
single PF to send the set of configuration commands.

>>
>> Move the software mutex to struct ice_adapter and record the owning task
>> across the entire Global Configuration Lock acquisition and release
>> sequence, including the core reset path in ice_cfg_tx_topo(). In
> 
> this is fine,
> would be better to not track mutex holder
> 

Yea. I'm struggling to understand what the reason we need to track the
owning task vs just having the lock.

>> ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
>> while allowing the owning task to issue the permitted configuration
>> commands. 
> 
> 
>> Route the Admin Queue fallback in ice_sbq_send_cmd() through
>> ice_aq_send_cmd() as well.
> 
> perhaps this should be separate commit?
> 

That might make it easier to review.. OTOH we also have been limited in
how many patches we can get merged, so I could see the pressure for
reducing the number where it reasonably makes sense...

>>
>> This patch depends on the previous patch in this series.
>>
>> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
>> (DDP) download")
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> 
> 
>> @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
>> libie_aq_desc *desc, void *buf,
>>           u16 buf_size, struct ice_sq_cd *cd)
>>   {
>>       struct libie_aqc_req_res *cmd = libie_aq_raw(desc);
>> -    bool lock_acquired = false;
>> -    int status;
>> +    struct ice_pf *pf = hw->back;
>> +    struct ice_adapter *adapter = pf->adapter;
> 
> RCT violation
> 
>> +
>> +    if (READ_ONCE(adapter->global_cfg_owner) != current) {
>> +        guard(mutex)(&adapter->global_cfg_lock);
> 
> no guard()()
> especially here scoped_guard() fits nicely
> 

Yes. guard() is not well liked by the maintainers, and I believe
recently they have strengthened their preference against its use, but
its at least documented as discouraged:

https://lore.kernel.org/netdev/20240829152025.3203577-1-kuba@kernel.org/

I thought recently there were some high profile issues caused by __free
and/or guard() that strengthened this to a hard no but I can't find the
emails.

Please stick to scoped_guard or regular bare lock/unlock where
scoped_guard does not provide much benefit.
