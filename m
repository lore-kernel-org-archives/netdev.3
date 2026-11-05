Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793904376;
	b=X0NG7brFNlUpptI/vy5eIXYiUbwdmiwAYrRqGUWLmL8CxCLljmLhDSOHWYqIrFXAsfzr
	 9a39A38uKl7elnbVK/vEr9L7T564rgEU5yrIZrjFh9aZwXUjF+Q6CO1oDh3aMZbN8IFNW
	 1gl81DjJZvRuqjQJdr9zd2cvjaGx2uMHW3MhuKelwPNCEr5yM4rOa19SqM2THqLHPYfRJ
	 oYsExoOkLJjpUzjgD0pOxm5ta8CQ82Lj4h8jQUp0d+6btnOTHlOaZ3iFQSRP59q1clXDq
	 CwHpFbITU16LioUuNhnF5K3Q8eP1ienM431Fl52lV6pMREpOAO5GcyO+Fzes8MUOG7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904376;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=ad5YBXy4eW95TRlbvGkNl4UBpwccs3myMfEwz6m8TtY=;
	b=Nhf6uEzHqWHs8QjFREqz0P7i/uEsEAmqSWEupcehqWOoOqabqwKpIXRkMQpjitHNN+uM
	 kK3dfzjA9LD5fGbkueet+jKmoIWCLrb9sBEK+UQ5IkqpbqBZt9yJVoqKdJTxeDbQLEmcr
	 XyZcNpInq/LmaAl5uAx9az/rjrooidvN4n1PnE9qL7vwik0U8Qc1iqVmLUAYS2008pb6M
	 Nxg3B0pUgqW8741xBkctityXV3yweJCTnaJ9dS6gmidVfShRDSDAzJecGTD075naBMi1P
	 GMyidhIl2UX0rIPzKEhlVomfSNhsCia+r4/uJz30X10vvCJvWVmv98MV7YwE1CqN9Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4H8ximW;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E10606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E10606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4H8ximW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793904376; x=1825440376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VNbuT/I9tKSKKDCrv1zY5jAXvp49R5J70Rp+7aH2g4I=;
  b=S4H8ximWNRwH+xEZdpuHFgrh7ZvYhTJALnrjXq6XotLdQpQiQfEuEW2O
   d1l4jW+HMveVghRFAu+JQg4GlSUS5qy4WNyq9Q/fKJ9PWgTYvBQdLAFrn
   REi9T1Zm1J8/fwwccbAROVVL9NRFqkp6xCQvq3xC63Vn6gCAKwhkkeOZz
   LyZaNJFqKfIDJHyeA7vInIxnEHslpT1aIpRuBcjBoBP/IYSHplzMP1aIF
   03xqkPiQqbPJOZDroaoV7fWmE7DaoMmifpcGa8syNXNsIg9NOxmxjBxf5
   6ed7ir0BHjSt1BHX3TyYGWVdch9km4g3Ev9RFIUeAqh5XX23S3lrm90fH
   Q==;
X-CSE-ConnectionGUID: aNYtvI0LR76Xx4cQ80H+Yg==
X-CSE-MsgGUID: nB+3eWZ8RRK6FaoJXC//5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2609162"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2609162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:46:16 -0800
X-CSE-ConnectionGUID: ITZSCNawTsOdvrA9IFzqoA==
X-CSE-MsgGUID: WOVXnu6dS9m9o6hHzuCMrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6974890"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:46:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:46:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:46:15 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:46:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAaWBLF9RLA1520uxmt2AuheV9FVL52FN+Mz+1hUJSxbfr6VBcOiKDx9mFuukHnTDxMSGv9G+PVN0hgxJMOEtVEcXjp55TJaeBP8rwgNp8iulPPRR18KO+fK9pxEsNq8NuHFhc7x/Wmx8WzVgTU5/uuQbmGF1yjUfiVUrPpF7/+6Ox+AG6cHghiUZ4tX7Pkeenf8FSDxe9/0wQte1433n4CwGv1QCLRzrKwc4zT8XtNOuclZl0Fs8JFiMqCpeEywyz8ojdDLyyvgSoxQD8Q3wFnDs8+v3+AT5oWytH1DdUggimgX6tD46uYKtsNNK4Rx0ofKjdMrKWrqwkIgpjDuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad5YBXy4eW95TRlbvGkNl4UBpwccs3myMfEwz6m8TtY=;
 b=mSU2hwj8ZUm68EaBtNiDiRFyHzNUuX0x1LW8Gb1ZIPhdxicia1FdNSXpYtz27RLtIlRZ9FD+JqsmdN7fycDRFA+wkSGHr/ibPK2A/PnMKfaMFzVkYeJyMEJtGtoV/075PY43y68RPR0A8YcoBaP+FU/rV49u9ICW/kKWYMzfNnLIgWNM1HcEmKwN5tL2Nm+zvfIOg32+OmEqIHf9GfOLYMQi6Kl8n7PAI8UbPYu03UQJSMK8TPldx6ijOnpQIG10NgnJ2GwjRQR+2Nn5TAofJguUhkT7MGC0g5ueYybd8B+UK8aMyGDgtpwtBv9Rsi9gVzehNL9pP1Pn5ZU5W5QJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:46:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:46:12 +0000
Message-ID: <27edd1c3-c5ae-4d23-9b54-0589ac690dae@intel.com>
Date: Thu, 5 Nov 2026 10:46:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: bbee094b-fea5-49c0-9f95-08df3b6d104e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261022105027099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BrHgpY6Yvf23ynPKIAL+ejAZDlb+cL4D2JTv+d1zTeSce8ruyX4LpFojoKkXbkygl29/1if+PNr/KoQuQSEXDiDNHfUwz7c/2gUhElPJ5imxWq2c7BgyD/FhjOJpfv2hy/c2IVRjIoPPJSDoArrIVpfVn6SKzTOWvO6hx9V+kvQqY4tAj6Qld0hiMf/07mEJo+AHVt1YF9y994oHobK6b/e/g/hmaPoJO6pC+Nr/D9S1XHu9dXDhI4Tl2rWXNNSz4vuTAGZ2SjO5/4MPXK+JP5f8XXLJBH7Ol6MhItRiBRDV0I908o3btqcX1vzlgC9f/RL6sd2D9W3oECna2i3/1rDXrcLJr/UCStTHjNHXNn5jP1bGcKINrF7b8Pc4gtDvoEqaA8IOBG3DWjQXTxks5z7onxs0CcwbX1Hhb/HEggduqIE5CBBfBMNARBQbqRRhdcKEc45SVDV1T8lMzJMRy2cW4Memdge79PfFmhC88Rxw6Nbcq5afU5FZvxlcp1MKMXypYHe1Lx2nUd0UG9G3qhArpgtODRtQq5N9LbcWQT/RlUGvlOivV7wMM+vLmmMy5Cay+Js5TqzcqMY0Ry/dLc3rwRIMMgaK+3ae7i6KTNtDyBXwrlnIvBNz8FLHFxWl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGkzYU5JeUNyUlJXVEZRdWVxWUpxdURtTEkxb0dWZ2FaKzNFWC9Pak9RMGhz?=
 =?utf-8?B?ZFNZL3dxdFFmcFlWbmZmWnVJekJ1L3MwNXZzS3dsSjBiMWswTm9SSTcwUXov?=
 =?utf-8?B?b3A5dkhLYlZIY1NHTmZXS1llQndsMFF0NVlnWTJVcjZFSXlXRzdTU0VkT3Nv?=
 =?utf-8?B?bUhUYlU4QlA0V3gweXF5ZVF6UFZNejhVei82QkZjV05vUnY0THJURWFOR2Qv?=
 =?utf-8?B?Q09aZGJGWmFKZWcyQXRCZVFJYlpxZDQ4WUpBVWFkNEs5WHgvOWZ2YW9MOU5Y?=
 =?utf-8?B?OWkvK003NE9PWG9KMC9uTGl1TEFCL21vbzRJSSs4VFBKNW5wa1d3OWdWeGZW?=
 =?utf-8?B?eUxqa3hvZHdoRHkyMnVZTlAyaE9MaHpBakIzQ3FEVVBKMVVaaGdFdEtqQjhD?=
 =?utf-8?B?S0pHZVhRV29wanVlajhYbldYTGRFMHZRcWN6N2dIeFlFMVF6WU1xK3M2UGpx?=
 =?utf-8?B?YUpSMElmam13U2xaKzJ2WmN0ZUVvSWRvM3NseWpvNmZBMm5KbkhsNFZDcFo2?=
 =?utf-8?B?UU1qZlFaVlNYVnVEM253QzBGV2lUSFpQMkZJTVZyWGNYbWZSZ1BPSkw2WGRQ?=
 =?utf-8?B?d2VuODZWYms0eVFqTHJUZlBVTVB6bE9GeVZXVkNOYTUweHlYN2lOY0NiT0Vx?=
 =?utf-8?B?M0dGYkhtYlVZU1REU0x3TU0xaDl6UUdLTWJTZE8rZ1ZybzJzVXhBLzY5WjB5?=
 =?utf-8?B?VGFac0lzR0hFYmVnWHFuYjg2eHV3SzRzeGdjTDNMTVlnZzZDL0lWdEZXNlRq?=
 =?utf-8?B?ZHhjTkVhTW16blNid0cwblpHYy83bzVISWYyU1dtdGx5VTQ3SkxKcC91aDN0?=
 =?utf-8?B?K29NbVliMVJQVXFEcHAxVDRXakxZdkxqd2J0VGI5Nm5JQjBNRFIwRDl3RUZ1?=
 =?utf-8?B?TWlWcjA2UkFZTVJPWXh1M3NadG1TVXNOT2tlQ21YZWdFbVlHb0l2S0N2bW1D?=
 =?utf-8?B?NFh4WXMydnVidG5SWFRCNWpVN0RTTzJnT1lkbG5rdnArQzdSR1hkSzJ4U0Z1?=
 =?utf-8?B?SFFVS2gxc05FdEhUTEk3bVp1d0NDL0lSMmZ2QXFCRVJ3aFdYWURDS0NKQkN1?=
 =?utf-8?B?Q2g0azVjQ3B6b20xVkxsRUJxaDRzcm1DeEVOcFZabmVvUTU2Um1WWGhOWUk2?=
 =?utf-8?B?WVJDS2FHQVFqRm0zQ3JkZVNJNjh0cURXTHA4WVZQS2JMTDJjeTRDT2taNmxE?=
 =?utf-8?B?YStlaWFRelovaWZnSDRVNUpwaUdINVoyVmlIcjFqSWxtUFhqWE9sQ1ZrN05m?=
 =?utf-8?B?SWpUaVpzV2tqZHRLS2F3cFJreVl1bWdnRjViUUFSN1Y1cSsxVkQ0QitIb2pU?=
 =?utf-8?B?c3RuaC9qSEZLSG8vZ0hYaGw0Yk9LbE96b0VPWVZ4d2hNS0RWbVhSNjVyRW1n?=
 =?utf-8?B?Y04ydXg2bnBIbTd4cXYwZnlaRHBCWUZ0ekJjTVdvOEI2dmpVZEllWStFckMz?=
 =?utf-8?B?K0Z0aGs5S2F2MGZvQ0l3aG15SXJOZU5hTGRUa3dTZlRHVXJMRkI1Mnk3Z293?=
 =?utf-8?B?NlJpRTVsZ2hhVWdCT29KamllU01RQ3R2YzM5ajU0U0Foc3FhTmtMcnExWlAx?=
 =?utf-8?B?RitJSlRWZnZ3VnhUTDA4MllZTVl6ODlDL1MrL0NES0RNdnhnUVdmb0JBQldE?=
 =?utf-8?B?OHkvWXNUUXdTNE5zZENNalVGTmlxY3Z4MElxTVdzamVPTXp2YXBab2ZsL1pG?=
 =?utf-8?B?UTBaOGF2aVhqRjMvdWRUVTdvdGRzK3JlT3JLWURMQW9ESERZR3VYMHUwOFln?=
 =?utf-8?B?VG1JNGRkemFVdUlnSnFtV0RwRkJaTHRJdjF5TjAzQ1FXTXdra2lqMUN2dEVO?=
 =?utf-8?B?YmZWdzhTOXlKVXFEUzNsRXNBY0kyNWg2ZGZsQm1SK2VHcDlrNzRnd3BEbk9m?=
 =?utf-8?B?RzhFTnUzTmM1c2d6MldrZldpTW83MUI2RjdvUkFBYk9NVVBRaU5XekdKRXFy?=
 =?utf-8?B?c2hlbVZEM2dDazUraGVvMFZUM1hEUHZiZEFHM1Yyc3Y1UFkyVkVxSVFBN2oz?=
 =?utf-8?B?cDVvSWVDc1JSNG1DRlU2OWMzSjVVQ2J3ZGFWYjVFRWZNYXZldVZ0bGpTSFBl?=
 =?utf-8?B?WHN5UnJSUUJ4QTNsMTYrcFlXTWVmNTUyMWpXRC9GcTM1YmtsMDVQYyszQWlP?=
 =?utf-8?B?SmlXTEtJR0R0dGllWERKYWRQMXF4NElKdU1LQUtwOUdQcXhxNHBHVEJxTnh0?=
 =?utf-8?B?OUpqL2h0cWxRRWJpM1I3ZStwdU84SjdmbzF0THRnTUp4L2F6STRPbFpBNS9E?=
 =?utf-8?B?ZXBuV0FxaFNIK0lPNlVOQWVWT2dkUG9nUXVobTJYOEZ2UUxiVko5dnBnVXk5?=
 =?utf-8?B?NjNzcXBMNVAzaG5SV240YXhaYlN3RWRlNDhtUDJ0SmFoUHNYaFd5U3VBMUhU?=
 =?utf-8?Q?H2Rbsy2QLIQRZe9I=3D?=
X-Exchange-RoutingPolicyChecked: i/ruOBfawodLUlhWMKxZDZ/T12Vi8/zvtvhFdInVTqMSOH96JttAA7gqS5agTwj32z/GFxOxZK2RoGHUJqCmXbtySGC6EwZCBAa9ohnVx6VObG/VRJM2cl8bnWYQfdXMOHf02Jgk1qD7xMtV6iTXKqwNsxHlnXyQ54e6Vb/RJ7jcS8ju7xtC1TrTtHe5xiUbOCYn7Ho6PgXc5tFT6fPEjSVG+fhBN8F5ODRRMo1qC0lvQdFmWcjTvf/ocPT2K8pDE8NXg9m0Aqxir5Nz0XZKmyYO76gBd5gKOzLsfE7nBZx7F5Lg1mKBpjxG+3DhpoU6n/2DQrLD46yeJuSnBd5JXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbee094b-fea5-49c0-9f95-08df3b6d104e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:46:12.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho8TxFY98OqA6olZztfUF0YImAemcfIaizuccbEgrfYM6gVYhJcQ3wiraHNSdOXenNJxZ+dpgvtNoZl7SOl+02PnZXhqrLcG8KC5Wvlzgnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
X-OriginatorOrg: intel.com

On 11/2/2026 2:50 AM, Przemek Kitszel wrote:
> Fix deadlocks and lock inversions around ice DCB configuration, between
> RTNL, pf->tc_mutex, the PF devlink lock and pf->vfs.table_lock.
> 
> RTNL becomes the outer lock of all DCB configuration paths. dcbnl ops
> and ndo_setup_tc() already run under it; patch 2 makes the LLDP MIB
> change handler and ice_dcb_rebuild() take it too, so patch 5 can drop
> the now redundant pf->tc_mutex. Patch 1 goes first, so that a dcbnl op
> does not wait out a reset, whose rebuild now needs RTNL.
> 
> Enabling DCB in switchdev tears down the devlink-rate tree, which needs
> the PF devlink lock and pf->vfs.table_lock, both taken before RTNL
> elsewhere. Patch 4 only tries them, and only when a tree is exported,
> which it tells by rate_node pointers, no longer left dangling by patch 3.
> 
> Patch 6 is an unrelated fix of the ice_init_lag() error path.
> 
> Reproducers are in the commit messages, each verified to trigger the
> lockdep or KASAN report before its fix and not after it.
> 
> Petr's "ice: fix RTNL vs auxiliary device lock inversion" [0] touches
> the same ice_setup_tc() and ice_pf_dcb_cfg() code, so one of the series
> needs a rebase. With this one applied first, his patch 2 is not needed.
> [0] https://lore.kernel.org/intel-wired-lan/20261023070258.730168-1-poros@redhat.com
> 
> 

FYI, this series did not get any reports from Sashiko, and Petr's series
did. I think that one will need to rebase on top of this for ease of
application if thats ok? I've made some notes for Tony when he gets back
next week on this.

Thanks,
Jake

> 
> Przemek Kitszel (6):
>   ice: don't wait out a reset in ice_dcbnl_devreset()
>   ice: take rtnl before tc_mutex in DCB MIB change and rebuild
>   ice: clear stale rate_node pointers in
>     ice_tear_down_devlink_rate_tree()
>   ice: don't block on locks in ice_tear_down_devlink_rate_tree()
>   ice: replace tc_mutex with RTNL
>   ice: register LAG event handler last in ice_init_lag()
> 
>  .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |  1 -
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 52 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 46 ++++++++++------
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 35 ++++++-------
>  drivers/net/ethernet/intel/ice/ice_lag.c      | 15 +++---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  8 ++-
>  8 files changed, 108 insertions(+), 52 deletions(-)
> 

