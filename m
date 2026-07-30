Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E84416CF4;
	Thu, 30 Jul 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411065; cv=fail; b=huvBf8Rkx4Mu+dfBFq9moy9NlmSYtmw28uE9tf4vVwlH7sm1FvXfIn6WzKSGAU7TjVeG7/oz6kOOvZ5Kfnns+DHU5LNBN763K8n1SWeiGkePMNNTMk5Tb9FG6YnWGHyyVMl767GiYgqMJeZF1+kuuVADzUPvIdalQ1efQ7t/kyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411065; c=relaxed/simple;
	bh=6IA6N3xp59fnOqpxa91yTuxLEAKaRfmKZkt9qnbkuA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SR+Pp0uQDTg33X7nZdoxeWKq3fF1nAQKsOwq0RxBboe9BjbFR4Ez1ok8ooxpjWVe61JzsBjylLU10pycOFx6o6ZVpa7+Xc46zYAWa0uS9ICgOcrUUbbrsdP2n0ayX98p0OGiZrsy2Zd+EW3exzG1AgzcLz/+XiPanfeHS898Vis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khabqW3y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khabqW3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785411063; x=1816947063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6IA6N3xp59fnOqpxa91yTuxLEAKaRfmKZkt9qnbkuA8=;
  b=khabqW3y3GFQMSE02zoPy/LUbkGmKuWheD9wDQbEiBX9ALP47v6ymLJy
   RisWKUAi3CZOTD7JTwxgi17k/fT8MzeLxIwhE9OBnikarcwYhUHGezQNU
   AkgWqc3z/kXvkD2T1XlFvQo836Ahtw0G5ciWQZsaUhnRQ8/AjDbo2Y1aN
   r1rIEBfE/7x76dsWTCkIt7sH8ORE3XnsDpgw1rUPM7XaQsaDSkZa+ik3i
   Yax7iUCQMNiJOZVzvEyxHAZ0XSFw1fkTgVYmX7uYF2FJoxiGnoUv4SYa+
   pQ1kN1R1QQI7flifVTP78DrIX5w2CuVE/r2xpPjylu7p4o+SAIsmGqzs9
   w==;
X-CSE-ConnectionGUID: aO5uGDlfT1e8dCagdZJgQw==
X-CSE-MsgGUID: UYE1NgyPQOCIWDlYO0jDUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86146338"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86146338"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:31:02 -0700
X-CSE-ConnectionGUID: KllvPaTkS7W0JRjp8yCk6A==
X-CSE-MsgGUID: il7KliVgQFWNyRieelObfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="290235566"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:31:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 04:31:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 04:31:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 04:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZMzMZvc7gKjtL3znaUzm2Md4QtZ2ugfjozdy8rmnMPZz3ccbneK7c6Hl/q5+I2CsHAPIzkncKrQFDcCh59LM9waF1Cck7aiN3CWyA3iBlhGgAkaFQkxmWx8PzvUjU3ofI0T24r0MI6RO2x1PBBF6tcrqrCR1BDYjS53crEXacbwAPW4uZmoIT6hJqickn5qFs4mcf9bMio7XpgeylD0+HKZ1W0/M90WcddDIyhW97E2youMjvVUrC/GALyw3NYMUPXvILJsumkeqfZ4mrCCVc2gdntWKTZ4mRQA20FS0c2YG+J3018tQnWSj6RtkIpWEHt4Kgat3NPhvMyTpDOyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNroP0EFAbHACQxxlq8Y/WcXgAXNCq0Es/Q7+ZiwOPo=;
 b=ckdRixii8/XZgcoX4HgBB668GTrxe4VitDMQXXcgL/0QPDLK3ZYB/D3rfu+zyo4kut6GJyMkavSdvn7cxgAVmaAURRTsUFMyRE8ml/0u45OaXtaFRSfxqtHX+23j9dBJ5V9BqTKMY1favOzJcjbN28FfNCEW6yDNI+4cxFEik9NzmYkoxAkRyrrfpJMvGL6CjfABc90Ej2UwDNPZom3CFLVkHBRDU2+2NKr0P8HkJMfOqaNC06puXkUYED4pCmG+inC6GXy4i17LTxblY/kwInNebGI8/pDAOe6JpjOSgtVm0TcqfvpRtpDeV5rhc/8Y7HjCNK2MlwY7O+KQa4NvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Thu, 30 Jul
 2026 11:30:58 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 11:30:58 +0000
Date: Thu, 30 Jul 2026 13:30:48 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Fan Gong <gongfan1@huawei.com>
CC: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v12 1/8] hinic3: Fix drop skb when
 skb_checksum_help() fails
Message-ID: <ams16FJUl0Oo-qC5@soc-5CG4396X81.clients.intel.com>
References: <cover.1785120952.git.root@localhost.localdomain>
 <d8091108ba3034f99c08cd8ad620406e7e9395bc.1785120952.git.root@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8091108ba3034f99c08cd8ad620406e7e9395bc.1785120952.git.root@localhost.localdomain>
X-ClientProxiedBy: AM0PR02CA0161.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::28) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9bf9df-6500-4f0a-28e0-08deee2e06cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LfaJLdYXjA2A/n6K5Ii+Suxp4rv7EJ4q0A3JyYdSp0PGYvkdhyaOfQlpCQHQ9Nx7+w/D70o6BVq558GFPl57ygs/4f1W1VhigU1uhJuDLrd6jIHfC7YW4CldvlAXKzybKvsSWjf8M1a5lWt59DidEybOda1nk2LLHzvAJcgWX6WY9X6Vwu1lLSsNzLZ1B2z+BGC8mc1m5l1BinxGUTY+G4innnIDRJJNHI+fC/4wcT3wJ/LG6xqjLCkjZb3YVlX4fd4HlUchgOPRihrGUtIRLdkBX4+hetF3ERq4RIYRYEPUePGJWdjXUc82LOUY7mb9tCmfX4XDdPBCPi6p1FB2q9kRzvxzH+SJ9ewfZ+JikJ25y5wnAHKS834zbmyoPMc9ysiIrn7G9e07UlQEu9Jw+qZpv5hUSqQ4PsfYaSQoZaUTc4o5Hr3GN3V7ijsl06Q47b9WOSQV/mleG+kjOeo75KgXqgSINziI7OmxF/uvanhBCaVTM44ncuyNiit0+7k9kagwRh/Quws/Uq2rfaG9eAasqqq/fY22KCP9I2KC3wejY0WSdaqxcQZA1gvFcPZfI2fDdTedh4NPZ/G5wcC8q5mHLjPF89NQQ5vDowwkTtNi4p1xyQxTHgRDp395JCcu3KkwZ7yqJ2rPlu7828b7unARwv2n69x/dJCd4q0nkzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akeiVzJXXAX5g3enVRX5LARIXDRhOHx6Hluf6PMxPZ7YyFB8bNkKhjlhp7ZX?=
 =?us-ascii?Q?2rd7Wd6aZpN/RkMKj/yCMY78ZGfDsRnkbwKQre7JBO2euOUcuAdy9Kj35RUn?=
 =?us-ascii?Q?AKB/xeKHJlRHiobg2Tb9cLlnM2ScUA+LB5y3pX0x28HXDRhAdCnj+sKTL8T9?=
 =?us-ascii?Q?Ite56SO3Bn3oAwuYDuHIWfmUSQBDML0Hjab1DjIwTLNuxLMwAq2nBBOLOskx?=
 =?us-ascii?Q?J6Yc5LpAgdinSb3I6Wo2Y6G7sXp09rY2H4UiWtQALpvMQ8b/SbyFQNP/cMdY?=
 =?us-ascii?Q?KA4Pxc8J1wMwZ/GEq8O3XfkmeGCcrUrLUbgGYw4MGP+gGrWOv/Fg8WCNUaVu?=
 =?us-ascii?Q?SB3iwbkGHU5WkFhDpDYuiZN1WyG/IwSfDphKlqNOtwhWlyFQRpLO/PiFyPpL?=
 =?us-ascii?Q?9fsEDRUZcHaRD+5KTsBqUTJ6AQSYs+1zGKAenGXjtpendnCE5vKHjyNlikXH?=
 =?us-ascii?Q?v7V5vmV6KDkoACqd0EU6emdjZ8BL30WWtj27V2Xq6ELWEQZa+8YvcNC4Rjd/?=
 =?us-ascii?Q?cFW1sBxgTDc8C8vcE4Bnwa9Akcbxt6rfd72Jbf1x7vwplFSqxCUXHfAL5BMT?=
 =?us-ascii?Q?iRUUYsW4KN9w3xTL3b56xpaTtYVoyc0eI1UmMS/4j6tcxw/ElvyRYcWt6R5T?=
 =?us-ascii?Q?c1DdLN7WVDEK8n0XCWtKIWjyaJhWpW763qTElTg3LqwvoXx8Voo2X5oLI1KF?=
 =?us-ascii?Q?B46XHBgXGzbmE8SLj5neLD6H7+q/tvnOmQ3SkaAsW1G5Pe++uez6FGw/oA9e?=
 =?us-ascii?Q?nOlKglvV5fMgPjyUvTyqzjkZTxvvsBtPSMJPBdBv2H/0LohU635iI6lseIx6?=
 =?us-ascii?Q?u6iOLvSm/pOUXs5lXWh68Llo4YHxHOhtFxyor8hFXD9myu+1fwRqVx+4pALY?=
 =?us-ascii?Q?neQzmGpvkQW9scCDtdDqgAdMEcxGqgjuz6SkdxyuhFElhRSFm5Tt4N+a/foc?=
 =?us-ascii?Q?7s+UEXWo5ROAeMOYGq+Y8o7+jyQjJAbZng0WDDTe6ByHqwxGYKT8XBhnVuL6?=
 =?us-ascii?Q?/wv5jO9e3yxHJCWBwoDuBt2xMym6W3sd+IYwc/VRJVfDRkx07Uj3+2n1rWIq?=
 =?us-ascii?Q?kKt8rWdPuvNOaRG/g8rDm6mZSCmWX77lUEgUgkyCL/qbBpe6BQx4H4yzT4Zq?=
 =?us-ascii?Q?qmmS07Te/nm+Z+HoYpRKrSraxkqN3s5XYaghrRbrNrSrgJd8qgBVpaw8f0bA?=
 =?us-ascii?Q?+OdFM3ibQU5S3i+laEf+8XJ+Hmfw6xJseENYdAu14Ko3ePmoI/malG4hdq1T?=
 =?us-ascii?Q?DnYUarwcLZ71UjsMSywx+8CaRIlcIYiAD+uEgL5b3CUMb5GhJXcLv+rjSQnD?=
 =?us-ascii?Q?vT5hZFDWqPzAL+t2R6iEOVO1xw3affLrzjvluW+fDJMauJX36LnbLMVqNRkf?=
 =?us-ascii?Q?fLswru1Q/xIoM5Lq+WRZzbvwqfBfzQRPWQHprCTikbkgOtgEebhXDK/moQHT?=
 =?us-ascii?Q?BlhtP7G18XZ1YsQtPlnyJdQX/FO8Ce9RVTEIrVCpsRZ+JCgsSa4MiHFRLHrc?=
 =?us-ascii?Q?2CX8d8AcXiwLFPov0ufHI0Jex31QWi7KR+lpBJyBhMOQZ+vEFOyHk+8IqGaa?=
 =?us-ascii?Q?NOawz89dF34Rd71ABh3VJk3kUUkoWSQreqdi9COEd85T06qp2Bqo6wq1CXbs?=
 =?us-ascii?Q?FAZxqtUNnVHt66n5p4+Bprgvukv2NKDIhiUglOZ5Yg3rdY5f0LNEuvN9DOtq?=
 =?us-ascii?Q?ophLQ74toCICrkPnMf5fj66WyEzs2FYBg17XKScGop9ExbwGO0mZvFlsRxet?=
 =?us-ascii?Q?pjP1wKehDCzfJtZZkzUJHUkkyq6Nfz4KGaZgUQEZm26zSgO8hHR+1u/4hqXS?=
X-MS-Exchange-AntiSpam-MessageData-1: xDg2H43YXRdkOlvkWf3EnmmoISiYreOjoys=
X-Exchange-RoutingPolicyChecked: O2NdyrBE3Y5QWr9H/BrvbiyMa9Q8qK2L8m9ncEW2Ud1LpOS+IwGkdEgZNnCDn1/ko3s7S8ZMSyNt9Fkmjo8WafxWkcwB2UQhOFMeRzuTmMbW2sFuH55VPUeO58ImhXwU3Cs1O4nfZ4dV816gdg0uZPi1ZbFSgXqKWAcJe8xrHh0Fhq61U3vlFr33rqCLiWg/0fyHtDnfu+oJjRGYXkkUxIPlA1o2APFnb2NMjHDYDrDXm6JjPBROKL6+cUaLy69JFZEAjFij/s/FgnKCXBRGSaBQkFZXeC6xBsvSXGmsQaJZLLEhr2SexA6yqizVz0fxEK5rHD5FtnhZ68youuPwtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9bf9df-6500-4f0a-28e0-08deee2e06cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:30:58.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H9smIt1Lw8U1uvYjgyX0f01StcbmXmPmzTWB/HwxPu/k6RpOgYU6vVppzuQN7zmc4qivQ8zhqBMfdAHkPxfY69WHnMhSBX362lLL3VFBIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

On Mon, Jul 27, 2026 at 02:54:52PM +0800, Fan Gong wrote:
>   Changes hinic3_tx_csum()/hinic3_tx_offload() to propagate
> skb_checksum_help() failures into a TX drop.
> 
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

Regarding patch 1/8 and 2/8 in this series. A change either fixes a bug or it 
does not. If it does, the patch must go the net tree and contain a Fixes: tag. 
If it is a prerequisite for your -next series, you need the fixes to be merged 
first (but it's usually not that long). If you are rather sure that the code 
inconsistency that you are correcting does not have any real negative impact 
(e.g. failure is only for features not supported by the netdev), it can go in a 
normal -next patch series, but it's best to explain, why it has no real 
functional impact and avoid using the word "fix", otherwise both humans and AIs 
can get confused.

> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index 9306bf0020ca..53c065194136 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> @@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
>  		    ((struct udphdr *)skb_transport_header(skb))->dest !=
>  		    VXLAN_OFFLOAD_PORT_LE) {
>  			/* Unsupported tunnel packet, disable csum offload */
> -			skb_checksum_help(skb);
> -			return 0;
> +			return skb_checksum_help(skb);
>  		}
>  	}
>  
> @@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
>  		offload |= HINIC3_TX_OFFLOAD_TSO;
>  	} else {
>  		tso_cs_en = hinic3_tx_csum(txq, task, skb);
> +		if (tso_cs_en < 0) {
> +			offload = HINIC3_TX_OFFLOAD_INVALID;
> +			return offload;
> +		}
>  		if (tso_cs_en)
>  			offload |= HINIC3_TX_OFFLOAD_CSUM;
>  	}
> -- 
> 2.54.0
> 
> 
