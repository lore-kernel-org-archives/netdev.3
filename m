Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031254DADA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932406; cv=fail; b=teuMVhg2SD9XkLUE7U+SlSDhjwhiiCXYXI29yTZzRBvHyiveFAfLSa5N1E3AB27HqxrRxJr/dXqaQupdXI3FA12kJg1hL6lCcM5iNWzfdwCCF0ePIserbfAtpcqgXeHt2Do9Q9S+k2PFgY6332zsN5tPg8HbCT+aiaGsVftPpNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932406; c=relaxed/simple;
	bh=ErIc6b0BOGhoc6CKrHoachivRhNC/ScUXUw47tQRxFw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcM0ieClkaW9uCkov/znVTwmzHqRY+IMKvIUHvVITmfmCy04XFLTvnNeqpDdalXZ8uIVtV2F9lqYywDr8E2qCLH4GShnBq3IDrJzeuQ4jdgssW1JFm0fG5w9skbxIs0po0r6S9RsFF0J+pam6zjb0F4cWX03rzr6orikC4VYWOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys+t7ReY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys+t7ReY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791932404; x=1823468404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ErIc6b0BOGhoc6CKrHoachivRhNC/ScUXUw47tQRxFw=;
  b=Ys+t7ReYV+Jc1diIhtPNEvXT8AuecEMMGYoGWItNRrw8K52VrUsiwJJD
   WK31fRHctCPBpGhEcCm4DfXHNPku+BHFaYAiUBc0ke/6aWCrCeYCUlV3m
   ozIuUXIHxAqWiEQk1O4Ya+F45Oq3mXQQ9inkaJkhCaxLoRJQtfJXpeDq6
   w9LrzHdKUEW6dnZpclsfOZ07TQGa2Nswg2X22TcyL0356ncm30E29AbI6
   sCd31K73P780okvHf/kLPSiir8fJWJpjY3TYozmOlqwea3r18ObRCSNK1
   4NgX7QYYHsuYtCjcr4E8PfyVbsy8K/FN7dc8U4zJl5vbzHnqCCGUDZUyt
   Q==;
X-CSE-ConnectionGUID: X5z46k7lSBeTz2aO3MJVGA==
X-CSE-MsgGUID: 7+hVJjTkQTiqMrrXjz9MXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="572110"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="572110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:00:03 -0700
X-CSE-ConnectionGUID: C1dJUM+vQqKPAxRCUKqwMQ==
X-CSE-MsgGUID: zHfO4MALRqy1eo1xrIfiaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1203438"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:00:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:00:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 16:00:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp7uBPLvWzdpGRG2fUUbM9etY8o8BNSrzDfAzqIEbH3YVAqAIAypJ6k7iDgM3PkkKz4Lt2YZXXMNWK8m3F5jEazQRYXeZRjs7svsTbZ7GEpeIMXZKvIXQgMApGxwkIevOKPoUYLQqewyvMnitDrP76ECOHIxbBXIxQukIdmXsWdhyODgc5lSNw1l+i314+93KKGF9H1wiE5JMyU/U6VVmcqOkWqfyI68h/m3IZa4MZ1w/Gtu1Nzcg+1T64o+OVHC/nsXP1GSrwkDP/5/XmpqDFmhLa4+7BeYlqCD75S3HWV1p6PFygeeVuHHzFoSk7slm1J+GKeminnRjJFKY/Ju+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVxcZdWobI/NchhHbgfQZoIWnqyBwxBRbWgKwScUDSQ=;
 b=NdHBz4z6tQxQgv1UelIZSbEfebEVpbXXLCxnVKm57GDMPID3aumzRW5WmltkYEjAZS/kiAgZMg3wg0ANg8CZoI4LiurCk9Pe4+MmxhQgtDqX/zYA6L1S2IBEdq27AdD/rxS79AU4JDPO7OvwFBAikxm2HU6XcUTaG0BDHhbpXq93+1D4LIT7jCDwtDlvzVG6a9OykFnsoj9CXXTXj23n/AZ3mkoKN0mduR4X+O9TlJScQSWiG/rKp0qAL6nRWFWMH1qQGgDeV0Fzs0ffL+YKMTT9f/nPVSiBbQuoR4ZVliDjeeDQNxGqQLoXM9O0ZoKLwq1DdfM+KNqpeT7iXA+JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:59:58 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:59:58 +0000
Message-ID: <68f6d0ce-4ae2-4861-bd66-ba46ece90c1c@intel.com>
Date: Tue, 13 Oct 2026 15:59:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 14/15] ice: don't clear in_use until HW clears
 ready bitmap
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-15-anthony.l.nguyen@intel.com>
 <179184693319.434549.15963891869718203802@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184693319.434549.15963891869718203802@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CO1PR11MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeea535-846f-4ed5-8f67-08df297db44f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|5023799004|261009223027099003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mOFXtR3I/P+fKA0SnG8Feyq4LplauuS76rEcKBWjYQnjI1xzqqWzafqOA5bTBX8hNn/9P0FHsl0MfWpueGDK5/YrGwHj63BL70IPIMXeSXjpsP4u3qjJCmBtjPld3GM/93/JsWVWKJgrEOIHydzFO8aLhAjDFL6mVyM7q1ecbhWsMinK+lynxt1Xa9fZOLcs4g/7LfC30hbaBhOFXlbmudl+SWnOJdRUehS1QggeFFEzX4XGcODCjLXaQcPBOL7aVXQ9xACddfeVGNYc6bWAf9uX4mxvG9kd0BRT5qlRq4TdLTQRVhgmFq9nJVOFxBNxNg4ml4qiMBRviRpf3qFDgOX/WEbmoqGyd6Vl4HCRGNyXk9flKdsiDJi4ERj0nAQmU9UNcZw3a0f7CRsftLTw2r9ZKMAb4KKfOHq7AsLGePmmUKWOr26Dpe/J4Ax2ciMgwW6ct0Fa2qUdC/H85b71Hw591mWlUvsY0uJGXZE8Lanj41KlxOubSsjGapgzU8vkygEhVM+mZknGSEulBmymBGm/TPSPaujiEn/dNYbAjJseKzj+OrIDZ9yCQTuGH1mwh0EMDN8swmSPCSseltnnsomyx0wkIIYcAI+ydi/2ErYDwtTsbwhON0C9FtIwMqiy3h9b4LLvIaLnj1m3xVqUYg2SyKpMAWi4YI3Dk6z1lLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(5023799004)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpxZGZGeGJmc3ZXSXp0UENuZWd3OXdwcEhqNmRFbnhVaGZ2ZHF1Y2U1QzZX?=
 =?utf-8?B?WDdTOUNKU25VNStPK1E4bmQ5TjJSTzRRYzVyVUk1aE5GMDBFYW4rdkpybkNY?=
 =?utf-8?B?OUpHTDBueVhrZUlsaE14YkN5bUJmYllhVUZiZ2IycnNmNEtkQ3gxdmhKS2x6?=
 =?utf-8?B?UE84RnRHNTJEUHltbzJrYkJDaFpTWWdpT1RTeGpidExUamJUL2NkeHM5YXE0?=
 =?utf-8?B?QXEwOWd5S2ZoeFBFOEV5eXh4RXFMRmpKNnBFdFQwSlRwN1lKU0l5REFxWERG?=
 =?utf-8?B?OGRwLzh3ODNlREc0WDJ4RjRVb3J4ZXFPbkkwcnltNnNjbnZ3enBuR2FHYlg3?=
 =?utf-8?B?WGtYQVFGT0tjb3RJdzUvZk84MU5ieGNqWXVYSlRHaGFiZ2hpelpCVTlqbHJG?=
 =?utf-8?B?SXl5R1VSMVJaODdQR1RoV3JGNERDTElOaENSK2E2T0FDOFJqV1F4SVRWYU5H?=
 =?utf-8?B?RzBIYkZRQ3RXdWxpYW9VNVpxV0FiWkVuUVFVZGxuN1hKQ1lneE1ucndqSWx6?=
 =?utf-8?B?dGpBTFlTZ1pPTjBQcmlkUHE5cnlYRHExVUxCT2U4anJ3RkgyeHJHVGhmUndG?=
 =?utf-8?B?SmdrNFczTDhnZ2NTZ3dlenowSjNPLzJBM25XcnZ1YXQ5d0tYS2xORXdseWMv?=
 =?utf-8?B?U1h3VnIzVW44VUdQSk9qcER4aFlhdXlRYkpuN01Jc2VvK3BVbkhFWFRWSHV6?=
 =?utf-8?B?aUo0UDFqMUZoOEhISE9IWWpkVmRCTnVuUHd0ZEJ5cmlmM2FPWmFVd2ZkeHRU?=
 =?utf-8?B?NGZDTzRRR2dJT1NPSmc0d0JxTEYwdUFVUGwxdk04OUtYRGZRUFhYVkxpMXV2?=
 =?utf-8?B?OUs5dTlhRVl3K3pmaXhWeU0wK3dhd3JiTGpMM1hZUklYZWdWYkEyd1BObFdJ?=
 =?utf-8?B?RDFKYkh1YWVlSGVjNkZTZzBoMDlzUzB6ZUFJV2g0WnlQcnJibnpLdnFRZEpw?=
 =?utf-8?B?ODNXdW4rTzhNZWJ6OUd6MUR0MjZEcnBSekN6a1NnMEQwTmxrRk41Y2VlV2ti?=
 =?utf-8?B?SjhLR1kvTytUb3Q5N0NvRFduaXdSeXVVZ01sWkhXU3lBandvZmV1V1oxU2pj?=
 =?utf-8?B?azI3L2hjUURnR1JucEQ3aGNHTWFsbXdMR1pyUFVTcklycHJOVDBBV0hFa3ZU?=
 =?utf-8?B?MUgxL2w5UE5MQTEwSkZ1elhlWVFPeUY3UCtQRW90SWhTeUJ3aStoT2NXb0l4?=
 =?utf-8?B?dG1Sc1dUdDlNdGtKbUtwcHd5N2tOeEVESVdJWG5vMWgxZDNDOFBYQTFxS1Ba?=
 =?utf-8?B?SXZ5U294a0M0TzkxekJacjVpZW5jQjVQU3NaZE4xL3pjdTZ4cFhOcCs0aC90?=
 =?utf-8?B?alZaRngvVTVxcVhaSWFBNkZFWndTckM4OEVaa3JQRmVTL28zMkY0ekdmQ0hU?=
 =?utf-8?B?MGlVcXQweG5EYy8wUWVnU1JVUkNqL3B6S1Jhd1R2aUlWYUtlczl5V0VHeFFZ?=
 =?utf-8?B?WGMxQ3FtS0g4RWc4bkhLd0MwcjRFMklnSDdaZXBRYUdVSEdERkxxdFVaMnIr?=
 =?utf-8?B?akVJelRJRFhwei9FazI0MGRvdkRlWW9rOWpZZzIvMTg4VHBJbGNzM2lOeHVM?=
 =?utf-8?B?c3R3TXpXcmNLUDdCWUdjbXhWSlRpQ3M1QXBsMDZTUlFVZzVabUhMYzdpUXBJ?=
 =?utf-8?B?VmZtN1ZOcXhqSG43bjhHSzBCSHNma3ZJNjNBU0Qwc0haUktGWXZWN3RXb2NM?=
 =?utf-8?B?S1FrV1ZFRk04WEhiYmVmV0NoQ0ZPSjlnRENYRXY4bGFreFN0d0t1NlB5bUpr?=
 =?utf-8?B?QjltOVlTNi9Ha240VXgzZ09XeWdpMDg2bG1BdEhPSnFYSkx2VlMvL1VsSHRS?=
 =?utf-8?B?aVVneStqcTJYTjFZWncvTStjckswRzdrK05pb1JiOGdGL1lUcWZPM3hjTTRH?=
 =?utf-8?B?c09JZU1BdTcydGsyTTlqMi9QMk5SNEIxZGJvcFdJbk95UGpjamFUWlhMbElX?=
 =?utf-8?B?dzZ3dEx0YlBTbThQQ1pReitRNWhxd1AwNDB2VlVGWlUrOGk0dkZRandRMGxS?=
 =?utf-8?B?MFI5OTVyczVlZFh5UE5TQXdRM3NFYUtIYVZHcWMwcUZLTzRZYS9iY3V6aVgv?=
 =?utf-8?B?ZDAyK2l1OVFLQ2ZwdjZKc25ITjYrdG8zOFpHT3NCemE0TFMzdDFUN1dtRVlO?=
 =?utf-8?B?TWcyM1c2ZlI2WStIWEZ1bWovZVpCNm1BUzhPK0ZvZVFzS29JSDJXR3BtejhO?=
 =?utf-8?B?aWVnUjFSdDNGY0ZLQzFpb1JZK2pwUngrU3NxZlVYSXRpY20xc0lnSVpETzV1?=
 =?utf-8?B?ak5GTVpHNlJaRkMvVVczQ1ZMSkUveFM3byt6L1F6WUdtUThHMDAwNFlRTEU0?=
 =?utf-8?B?a2tHVUdKeU1jSXhRZ0tSc3BmMVdxWGVDWE1WV1p2VUMrVUlBcXl2b1MvUndx?=
 =?utf-8?Q?4zL+53a6BD2DQa8g=3D?=
X-Exchange-RoutingPolicyChecked: kOGJHYbcKsaWPbgK74ooyA+THunlnReUsyZV7iUfHzn+rY+bFCmWcZ+eozvcnY64uuek3PU8PTgmUYh9WFvEzjdbZ6lmx1b94pX3fN0G/cCFpxySct7BI8XmYxFVT6PD3nB5JkUZRJQsQUuxUJd5s82B8vcB9KRtCS6CtS8FokXcMI2Fib3+QGD7FM/WRcX/bJrUIA+RXV6sluJPLph+GT3yUGppAfy9mvs3vfHP5QOiFSuxsyQ35Xx/Yi6I5Ycu0l5L08M4TWiIfPQQNKcP3h/E9BpklnGH+CWAkOQORwd6ZZUckma8neflJAQHRLpHnk14kL/iI23HN5Ft1GB8kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeea535-846f-4ed5-8f67-08df297db44f
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:59:58.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ttR+U3XKm79hBWusv8TgpPg0/yrtHaJpcvIdhglPfST4xhejiQsIwdZWz3MLQ9jNXiG/knYvsbR1JqC8JSAL/OkEmKQBdCQN8EEh9ngdNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 3 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] ice: Tx timestamp SKB leak when PHY ready bit is stuck
> - [High] net/ice: IRQ storm due to PHY read failure bypassing stale
>   cleanup
> - [Medium] ice_ptp_maybe_trigger_tx_interrupt()
>   (drivers/net/ethernet/intel/ice/ice_ptp.c:2994-3002) now calls…
> - [Medium] This patch removes the hardware ready-bitmap fallback from the
>   IRQ-thread re-arm decision.
> - [Medium] The patch now deliberately leaves a PHY Tx ready bit set while
>   it keeps the index in_use and stale (ice_ptp.c:622-634), and it also…
> - [Low] In ice_ptp_process_tx_tstamp() (ice_ptp.c:622-634), suppose
>   ice_read_phy_tstamp() succeeds and the hardware clears the ready bit,…
> 
> --
> 
> ice: don't clear in_use until HW clears ready bitmap
> 
> After each PHY timestamp read, this patch re-reads the Tx timestamp ready
> bitmap. If hardware did not clear the ready bit, the index stays locked and
> is marked stale. The patch also removes the hardware ready bitmap check from
> ice_ptp_tx_tstamps_pending(), stops the IRQ re-arm for trackers that are not
> up, and moves the hardware check into the periodic watchdog.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 9dc0b5fa33198..8d302b500a399 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -626,6 +619,20 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  		if (err && !drop_ts)
>>  			continue;
>>  
>> +		/* verify ready bit cleared */
>> +		if (tx->has_ready_bitmap) {
>> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
>> +			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
>> +				spin_lock_irqsave(&tx->lock, flags);
>> +				if (test_bit(idx, tx->in_use) &&
>> +				    !test_and_set_bit(idx, tx->stale))
>> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
>> +						ptp_port->port_num, phy_idx);
>> +				spin_unlock_irqrestore(&tx->lock, flags);
>> +				continue;
>> +			}
>> +		}
> 
> [Severity: High]
> The commit message says a failed ice_get_phy_tx_tstamp_ready() is
> treated the same as a ready bit that didn't clear. That holds for
> this re-read, but not for the first read at the top of
> ice_ptp_process_tx_tstamp():
> 
> 	if (tx->has_ready_bitmap) {
> 		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 		if (err)
> 			return;
> 	}
> 
> On that error the function returns before the loop. Nothing is
> marked stale and the 2 second timeout is never checked.
> 
> With the link up, the tracker passes ice_ptp_is_tx_tracker_up(), and
> bitmap_andnot(in_use, stale) is still non-empty. So
> ice_misc_intr_thread_fn() sees ice_ptp_tx_tstamps_pending(pf, true)
> return true and writes PFINT_OICR_TSYN_TX_M again right away.
> 
> If the sideband read keeps failing, doesn't this turn into the same
> tight IRQ loop the patch is trying to remove? The pending skbs would
> also never time out.
> 
> The early return was there before this patch. The new tracker-up
> check only covers link down and calibrating, so it doesn't help in
> this case.
> 
> Should the initial failure be handled like the re-read failure? For
> example, the in_use entries could be marked stale while timed out
> entries are still released. Note that tstamp_ready is uninitialized
> on that path, so the loop can't simply fall through. Or is a
> persistent read failure with the link up not expected to happen?
> 

Well, a persistent read failure really is never exepected to happen, but
I think it would make sense to treat these as the same.

> [Severity: High]
> When the re-read still shows the ready bit set, this continue leaves
> both the in_use bit and tx->tstamps[idx].skb in place. Is holding on
> to the skb here intended?
> 

It was, but I can try to re-arrange things to avoid needing to keep it
locked for 2 seconds.

> Keeping the index locked makes sense. The problem is that the skb now
> has no way out of the tracker while the PHY stays stuck, and the 2
> second timeout no longer helps.
> 
> With the ready bit still set, a timed out entry doesn't take the goto
> skip_ts_read branch. It reads the PHY again, fails this same check,
> and hits this continue again. Before this patch the timeout path
> always reached skip_ts_read and freed the skb.

The idea is that the hardware will *eventually* release the index, and
we would eventually free the skb.

> 
> ice_ptp_request_ts() stores a reference to the original skb taken
> with skb_get(). The sending socket therefore stays charged in
> sk_wmem_alloc for as long as the entry sits here.
> 
> The commit message says stuck indexes stay locked until the PHY is
> reset on link up. As far as I can tell, if the link never comes back,
> the skb is only freed by a reset or a driver unload. Until then the
> owning socket can't be destroyed.
> 
> An unprivileged user in a container can request Tx timestamps. If
> that happens around a link drop, the netns teardown could be left
> hanging.
> 

Hm.

> Could the skb be pulled out of tx->tstamps[idx] and freed (or
> completed without a timestamp) under tx->lock once the timeout
> expires? The in_use bit could still stay set so the index isn't
> reused. Or is there another path that releases these skbs that I'm
> missing?

Since we're going to mark the packet as stale, we might as well free the
skb immediately the moment we do that. I'll investigate how to make that
safe.

> 
> [Severity: Low]
> Suppose ice_read_phy_tstamp() succeeds and hardware clears the ready bit,
> but this second ice_get_phy_tx_tstamp_ready() call hits a transient
> sideband error. What happens then?
> 
> The index gets marked stale and stays in_use. On the next pass the ready
> bit reads as clear, so ice_ptp_process_tx_tstamp() takes this earlier
> branch:
> 
> 		if (tx->has_ready_bitmap &&
> 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 			if (drop_ts)
> 				goto skip_ts_read;
> 
> 			continue;
> 		}
> 
> That branch never checks the stale bit. The slot seems to stay locked until
> the 2 second timeout sets drop_ts. When it is finally released, timeout is
> true and pf->ptp.tx_hwtstamp_timeouts gets incremented.
> 
> Would this count a PHY access error as a Tx timestamp timeout, and hold the
> slot for up to 2 seconds?
> 

Hm. Likely yes. I am not sure what the best way to handle this would be
because we want to be careful about ensuring that we do not release an
index prematurely.

> The commit message says transient errors mark packets stale. It doesn't
> mention the 2 second hold or the timeout being counted.
> >> +
>>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
> 
> [ ... ]
> 
>> @@ -2837,10 +2847,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>>  		if (!tx->init)
>>  			return false;
>>  
>> -		if (in_irq)
>> +		if (in_irq) {
>> +			if (!ice_ptp_is_tx_tracker_up(tx))
>> +				return false;
>> +
>>  			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
> 
> [Severity: Medium]
> The verify path in ice_ptp_process_tx_tstamp() now leaves a ready bit set
> while the index stays in_use and stale. Can a stuck index on one port delay
> Tx timestamps for healthy ports that share the same interrupt source?
> 

The ready bit was stuck regardless in this case, while the hardware was
unable to perform its automatic clearing.

> The comment above ice_ptp_maybe_trigger_tx_interrupt() says:
> 
>  * timestamp data from the PHY. It will not interrupt again until all
>  * current timestamp data is read.
> 
> An earlier commit in this series also says an unread ready bit means
> delivery for the whole quad degrades to the periodic work.
> 

Hm.

> On E82x, the timestamp interrupt enable and threshold are per quad. See the
> single Q_REG_TX_MEM_GBL_CFG in ice_phy_cfg_intr_e82x(). On E825, the TSYN_TX
> causes for all ports go to the clock owner in ICE_PTP_TX_INTERRUPT_ALL mode.
> 
> Before this patch, the hardware check in the IRQ re-arm path caused the
> storm, but it also kept serving the other ports in the quad within
> microseconds.
> 

True, but we potentially locked up CPU until the cleanup happens...
Which is worse? :\

> The in_irq branch now looks only at software state. Would new timestamps on
> healthy ports then be handled only when ice_ptp_periodic_work() writes
> PFINT_OICR every 500 ms?
I think as long as there is at least one outstanding timestamp before it
would re-arm in software since the shared interrupt checks all the
trackers. But I guess the moment there are no outstanding non-stale
timestamps then we'd degrade back to checking once every 500ms... until
the status clears.

> 
> On E825, ice_ptp_link_change() only restarts the PHY on link up, so this
> could last as long as the bad port's link stays down. The latency numbers in
> the commit message only cover healthy links.
> 

Nope. After the link goes down, evetually the stuck bit will clear and
then things should return to normal. I don't know how long that takes in
practice yet....

>> -		else
>> +		} else {
>>  			return !bitmap_empty(tx->in_use, tx->len);
>> +		}
>>  	}
>>  }
>>  
>> @@ -2872,41 +2886,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
>>  
>>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>>  {
> 
> [ ... ]
> 
>> -	/* Check hardware indicator */
>> -	ret = ice_check_phy_tx_tstamp_ready(hw);
>> -	if (ret < 0) {
>> -		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
>> -			ret);
>> -		/* Stop triggering IRQs if we're unable to read PHY */
>>  		return false;
>>  	}
>> -
>> -	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
>> -	 * available, 0 if there are no waiting timestamps, and a negative
>> -	 * value if there was an error (which we checked for above).
>> -	 */
>> -	return ret > 0;
>>  }
> 
> [Severity: Medium]
> Removing this hardware fallback also affects the in_irq callers:
> ice_misc_intr_thread_fn() and the E830 top half in ice_ptp_ts_irq(). Can a
> stale index on a tracker that is up miss its re-arm?
> 
> Stale entries can exist while the tracker and link are both up, for example
> after a PHC settime/adjtime:
> 
> ice_ptp_reset_cached_phctime() {
>     ...
> 	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
> }
> 
> Such a stale index might become ready after ice_ptp_process_tx_tstamp() has
> already passed it in the loop, or after the last refresh of tstamp_ready.
> If so, it isn't read in that pass. Then ice_misc_intr_thread_fn() runs:
> 
> 	if (ice_ptp_tx_tstamps_pending(pf, true)) {
> 		...
> 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 
> The software check is now bitmap_andnot(in_use, stale), which is empty, so
> no re-arm happens. Before this patch, ice_check_phy_tx_tstamp_ready() would
> have seen the ready bit and re-armed.
> 
> An earlier commit in this series says the PHY doesn't raise another Tx
> timestamp interrupt until every outstanding ready bit is read. If that
> holds, would new non-stale timestamps then wait for ice_ptp_periodic_work()
> (500 ms)? That is well past ptp4l's default 10 ms tx_timestamp_timeout.
> 
> The commit message justifies dropping the hardware check for trackers that
> are calibrating or link down. It doesn't cover trackers that are up and have
> stale entries whose ready bits are set.
> 

Hmm. Ugh :\

> [ ... ]
> 
>> @@ -2999,7 +2991,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  	    !ice_pf_src_tmr_owned(pf))
>>  		return;
>>  
>> -	if (ice_ptp_tx_tstamps_pending(pf, false)) {
>> +	ret = ice_check_phy_tx_tstamp_ready(hw);
>> +	if (ret < 0) {
>> +		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
>> +			ERR_PTR(ret));
>> +		/* Don't trigger an IRQ if we are unable to access the PHY */
>> +		return;
>> +	}
>> +
>> +	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
> 
> [Severity: Medium]
> Does this early return change when the watchdog kicks the interrupt?
> 
> Before this patch, ice_ptp_tx_tstamps_pending(pf, false) checked the
> software in_use bitmap first. It only read the PHY when nothing was pending
> in software.
> 
> Now a PHY read error returns before the software check runs. In that case
> PFINT_OICR_TSYN_TX_M is not written, even if in_use has entries.
> 
> ice_check_phy_tx_tstamp_ready_eth56g() returns the first error from any
> port, and ice_check_phy_tx_tstamp_ready_e82x() does the same over quads:
> 
> 	for (port = 0; port < hw->ptp.num_lports; port++) {
> 		...
> 		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
> 		if (err)
> 			return err;
> 
> In ICE_PTP_TX_INTERRUPT_ALL mode, one port or quad with a failing status
> read would then stop the watchdog kick for every port.
> 
> After this patch, the in_irq path skips stale entries and trackers that are
> down. The 2 second timeout is only checked inside
> ice_ptp_process_tx_tstamp().
> 
> While the read keeps failing, would those in_use entries and their skbs stay
> unreleased until a real PHY interrupt arrives?
> 
> Would it make sense to check the software tracker first, or to ignore the
> PHY error when in_use is not empty? The commit message says the watchdog
> continues to check the hardware bitmap. It doesn't mention this change in
> ordering.
> 

Well the idea behind not re-triggering is that if we failed to read the
PHY then we probably shouldn't bother trying to read it in the IRQ. I
guess it didn't consider a transient failure.

>>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>>  
>>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 

