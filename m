Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1657C72D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195335; cv=fail; b=TjlSjXl3zSjBxkVG7YRRX1ZSPvKx1vx2gJpx3vwhu9WKpHFBWKqdJ/DHau+MyBf3t1g//Kg8NE+f238ny+rWJJknMU05Sqlh3uIKO0x3QTzt0N/7H3G7rJ9ghD0rrmGPbs7wpkGjgXWwyz/1RUSTzUNanXcNI/0Fw6h6IsYL/Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195335; c=relaxed/simple;
	bh=NvNKXORdFYiwqcc9HiLqATgMWzOocaagrT23nfdAW50=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtG7NHTmlRtRsYuUS1pT4GBUQRB2OfLFTU3bF/LDUDxJDexUxqaN/rf1Zhmj8cAvdxpU06PUw2GC27cXSPauJwHRXBy5SgCdelkmnBOOn0L6OJExWORLi3UNihLMM7i975TMULGBuxftaNP4A6N8Wxm+IxJckcN7R+QzctgvbT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdKVhKmQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdKVhKmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790195326; x=1821731326;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NvNKXORdFYiwqcc9HiLqATgMWzOocaagrT23nfdAW50=;
  b=QdKVhKmQcdUVvKWUQ67uhdd1CE4fZEhCDjw49a3KSQwNNf+kb+fsDEVp
   tvkU6289pV+UrqPINT1MdhPvzKwy69V4kwjBpmiZQU6SY8SeAJmOM6SLG
   ygSAVUPevcJ2kpStpOJPx0k1qjuFdMlrmMJTZZeOembJCPmMM61o5fVkx
   0XTQ0mQE0biBUHXoaX4yR0Tz1xmOkUkG+sxaUHKHFJHNlrc38mv4N3XZN
   t8VrhZHp0iJGTktjfnHWwNQIKpMu8Rimxt1YpOO8GwPOumhNAp7dOvK0J
   6pcinwTL+AABLeDf7iHXqf6L8Nu9ROJ9lFbLmK1ML3/ec3drB/vLkLMad
   A==;
X-CSE-ConnectionGUID: yanxUnxfSgufl0dfl5vG9A==
X-CSE-MsgGUID: 7DEI1sGgTdel/Stmr1Cq2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116456732"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="116456732"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 13:28:40 -0700
X-CSE-ConnectionGUID: QfEMssq5QFW3QL++EnG5pw==
X-CSE-MsgGUID: nOYrn0smRYKiXynrzHNKUA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 13:28:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:28:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 13:28:39 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AobHhWlCRFWtkULJyyGQRgZZAtRzzfjLKU1Lb/ykg98sPPp2jVOTH1Oh/lSKM5stBtD9MrkZpsYV/UrjhIOfkDi/ezwKPUBb6ceyBkpCkIfD+MqbUgH+Wfd9Cxvp1pZih+bykf4wiqw8nfIyif+MApxZkAZSyjS6R5c5BGw8IKy6It/9CQiqz2U3bEDsiqxBZfI8l8LIc1tHzjHvLU1w8F8fkBkXwBVIzAeGp/tBUYoka/CK+iqHu3k1e1lSUM7RBih1WsPWMujDkL73ePdVUyOFPBi+rb/3R/p2TJl/y9Cd5iv1sSG1vD4DQ1jOocspq9X1RRhOLLSqmZvPXcejnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tILU5LE5IWHoZ9ZgI5IvpGEBHuhCN5s0NHRkGEGeFY=;
 b=DTfuE+qJlkQ4risTb8flJbfVIbYjKuFwAHo8z89wYL7J2XbTBZTMfyhQHmTdxMbEarO+TmweNCvmuTBmdL4hPDw093Tnrz9XaLUjsxr9FpoYnVj0QCEA2rWKH52TRXHKPq6CXkvplOG6dHiPqqUG9d1eLMJEM0R9ShlC8G/oPPJmW2Pr/p7vD+awx4AW031ItsHL4NqqLri6NYK47WcvUgnckvdGtQuTSW+oEOnxPDpKZHaryQNWqLORDlKRZaKDYOPSj/WaxbJ3NZRwLQ5S159A2v/va7H0RyxpRaTbQSQ+Jur4ng/kz6um308+wRa2L80TdrMIJl5p0DSvMk7Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:28:37 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:28:37 +0000
Message-ID: <54f684b4-b47f-4908-a330-64d47ddbd0e4@intel.com>
Date: Wed, 23 Sep 2026 13:28:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nitka, Grzegorz"
	<grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
 <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-9-e55b692d0e6b@intel.com>
 <IA3PR11MB89863DAB7CAB1ADFE4BD0AADE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <IA3PR11MB89863DAB7CAB1ADFE4BD0AADE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|CYYPR11MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3659c7-2d77-4545-d1ef-08df19b13f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: 9/Il2hiJIwVAGqi1W+G2qS5Q6d4Mp9QakkShFAKqTOR5HGwcoD58emWs3hMdrdjjnvEEpwMd+LADGPPHZW2l64aWXRH6Xb8yB/x8KzW0mM5dol5kwoF7ShWcFuKyNy7xYuAaylNo0EDDQ/kDVwakDJoP4ZhliWaBHTnpvkp2n4QZq0gjbMFqSuLotdyOebLYDYoeC89GZ5Q+BHhbajBNgRGk4Ld6HU2ziWbNa9TqWvKxb9i7xOG/z1jmpmiiZRYyGAn0cKVOKwf+wuLNENUAbstwKIDc5n4UDt3Vc5PipKtxn4Wfy5GuzqY1Wyh2wP1ixAo+EbVpzVZJrl+vROa5nATHa4uVSPbxgAB0qBgzUf05XSuoJeRuq0R0pbEqG754jKvFfkfq3LHChB/CiwKXHknDPfyMNLJKbpSU0yQeZjekGABhFPovkWDlE6qt2cIJmiTbsuzZvx3d1wD/nXm4Ba9XhOYW36TE+IyTBLciwjxmoIxVNjjAKM3U1nKRoQgXLTdwOT/TxuToEcIbYp9oAZrXrN5YLFOqffC4uvoN3IkBKgzd3h2tykZ1tX/yQeFI29KoQtX5W6wUNiHz6ghgiIR0yiHJyLnoXHr3SRMq2zr2pQv8SqyG0NLRG4OUObhuW+zWwIKuCAvxhSBqg4/AqvKaq4rmvWV87DSTPz+Tx1u3Z3JwHvnEfJmGEcFMQzEepoE/zRrcMDs4w3iypyYG5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtFdGpBcG9KVUdLdWN2eUsyV2Ivak9XUnpBWk56S2tjV1ZwR2VqR1dnMjdR?=
 =?utf-8?B?d3k3TlM1eXEyZjBFM0ZlNVNvOXMwaGxhSzNNbUd6M3AwNGtQUDVYSDZRQWN1?=
 =?utf-8?B?ejl0ZTk0aldHYlRpNzFCbFVsTUIxNEpQc0JRRWpHZjQ4WGIrcllELzhLMEFV?=
 =?utf-8?B?WHBrUTFyOUJpS1czUFNDeTBJZVRuUnlWU1Q2Qi9aTjE5UnU2eGd0TjltWmVL?=
 =?utf-8?B?dCtBcDNWWU5KUjlyR0VLQzNySU16YlNkTHJ4WkZIbmJubGwvMU9kNCtXUkZw?=
 =?utf-8?B?QzgzbnU1V0I0Sy9oSmpSSnp3YWVGb210dGppbFRzd2ZoVnR6K3pDcUlDaytr?=
 =?utf-8?B?WlpzVnRIUTYwQVZKZk5LNEY5cFRuZHBMZ2pjM1BGcWxvL1M4eVhQUUVUb2tp?=
 =?utf-8?B?V2RvTHpOUkpQRWo2d1M1YXBWSUtEaEVON1EwN2tvVnpibWowNk40M1M4L1V4?=
 =?utf-8?B?dXJVem1senZXUjVPeTBTRFRMcUNqUzcweHo4SlRwblZoS0lady9sWmdoZTZF?=
 =?utf-8?B?YjVjNXV6QWsvaGttU1FMeVZTSm4xOGIwbXFQUVFWZi9vd2NVZWU2eXdCZ1Vo?=
 =?utf-8?B?TnpzRDZ4WlV6cjBoRVBWTFdDL081WXFKZVVoazJKTmxMcWduUGlDc3VzR2Yz?=
 =?utf-8?B?L0hPYU9STEc4cUdYM013anl0dnBIWnRtMVVYdFk5R0JsV0FNMDd5SERHK2hW?=
 =?utf-8?B?ajNzTTJEZEpMSHdWYk81NmdMVkorazZsaStGYWVabmRqNkNpUFYyOXExczQz?=
 =?utf-8?B?SjdFQUJ5Q2FmangxQ0w5MGJtaEI3Qmp5Rm5rTWoxMytyZUtZd2Q5YlBpVDRX?=
 =?utf-8?B?UGZnL2pLMzBjb1dXTnJsZDNMdmd1ajBlNytLK29QQnRwcktMUGJNU2N2OHhQ?=
 =?utf-8?B?NGxOTnE0L1NzcUFQQXVCSTN0cVY2RHl1R1MvaHBXdWl0d2FlR2YzWFgzVXly?=
 =?utf-8?B?Z251SHo5WGF5Ui8yalZkeERvRVBZRUdCK0RXQ1hLOGgzYjFQaUl0MUdqUjlx?=
 =?utf-8?B?WmtpRWh6aGY1eFVmWUFScnNqZnpYMTZSVXkyR3IyMEFxVHgzeEZHRHZ2YW4w?=
 =?utf-8?B?aDZOM2tEZ1VpYVFnSTNFVUZiNFZXeHNwU1huUEl5c0xDZWdwOW9xTHJKc0g3?=
 =?utf-8?B?UzdLODNUYi9iWGNrZzA2MDZXTGpFanpTKzhqS1hwMnNaOGtqYWZlS01CN2RB?=
 =?utf-8?B?K0NEd1J5aXpuektEWDJ0Nko1VTBUZXVFL2tCRlhQTUtSc2tnazhJbktrZkpM?=
 =?utf-8?B?ZHMxdHFUOXdxSVd0ZFFGaGt4UFJXekZ3WCtDSmFiWVhEckNucUR5Nk43Q0Rs?=
 =?utf-8?B?aFRJaFl3Z1VweDBRVGRFVzQwTnp2RzVDSTNZQ09zcURkS3dHNGJTY2hHYnJG?=
 =?utf-8?B?cDhoVUwzVDhqdnA2Nkt1T1ZTemhXVVlpa3VianZWZ3ZTWUdtdVhnQTRMc3Iy?=
 =?utf-8?B?V1ZlOFk2WGdoSlNESnhzRThlY0RsaUExVGI4bEFPL3J6RTVLdVR4N0VrUHkv?=
 =?utf-8?B?eDFwM3dmbnMrWWdENHluOFJQL1JSUFl1L2R4bW1MTzRCWUJZakJwWTEzRjVu?=
 =?utf-8?B?WlVJRkxKWVBZMVhQZStWb290NDd0NzY4WnZHRVYvaVpWVm1uM0RUMkMxUUZE?=
 =?utf-8?B?OTZlV1cwY1l4d2RIMHF6Mkkzc2JvcExWS1l1eDZxeXJQN3E3UmJudEJSUkdM?=
 =?utf-8?B?SllGTG9DRjdTaGZQZkVjUStaY2t2SmF2UjhTOGV3TE1qK2xxSTB6RzJDcVdS?=
 =?utf-8?B?czRmNEoxdmxFcHlqdVA3a0hUYWhLMm00aFp6SzlobEppSnM0L0liUW5lZWk4?=
 =?utf-8?B?V1R2a09GVlFNQ0xVUGFCS3ZYRzV1eVFaWUdSK0FTUXlnWTlOU0lZd2ZNcStn?=
 =?utf-8?B?Ym5xK3dPUC90eFFNMVUzbWhKYlRWdzRVdFVHbXVhRHlnQ3lWWHozYTdDdVRt?=
 =?utf-8?B?aW5ibXo1S09hZlZqbFRabWZYWUJVMDJBSmhPL1F1RXFVQkFnVExvZXZQQlVN?=
 =?utf-8?B?QmU4RWQ1aGlFVUhkSkFZa2RYNE50Sk9naXp3WkI0dm1NT0kyVWVIcnltODAx?=
 =?utf-8?B?emdHQ0t2WnNZclVRb0IzY2VlVzl3ampqb0tJd2NEU1VtVXB6LytqUDc3Ykwv?=
 =?utf-8?B?dUJYdXFsVmZTZTJVTFBPYk1ZMzZDdm52SitWWUNHUUZrdHgzbENOU255TitR?=
 =?utf-8?B?MmtYaDlOWjR6MnFBcytTNjZ2VEJ4bDhGaUdzSkNpZmMvaUc0aG5aaDI5SExI?=
 =?utf-8?B?ejlXMXhDS3d2MFRGbjA1dWRmckZ0Y0dsWUo1eFlrL3Y5UnYwZmxLOHhvRzFl?=
 =?utf-8?B?aGREcWQyOTkvWmxkTEZPQnFiYlRaY0RaK1phNUdaSlkvL0FUQnVoWm5qbGRW?=
 =?utf-8?Q?1bZIlBTD7dLtoRi4=3D?=
X-Exchange-RoutingPolicyChecked: ROB9kGClTqwNxTfTasEe/iPXEmIX7kRQxyyYur0hScvPtN4lQg+6iU75sWcU5VkrvSPoSxj2VL+y1EeJsB8kTptyOSS43+SiXnPwT3mZ58UTF/VtzB3GOOuHhwiVrLIQ7bsdCNmnHrinD9gKFxeSF2oAgg8QEzjKNZ+WdfD6z5JZzoQrvYKBK7997vuX0xLquit3OyTb+tJAeiAmFObWCgOt0eTEMoh7xThkF30tUklnJdDWjbpeAUId0S/q9AWSLJN0rubOquQD2ilzLQ4pVN6PyJta6D25MzxJfo71+yZ3EQb3ycBgNqCHBX0bLJJwIe0QTNqvXeSn5G+9lTx3EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3659c7-2d77-4545-d1ef-08df19b13f4a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:28:37.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzwSzl+gnZWmUtWNyYTaTem1no+9LRoZnCMKDdNDeNvfy8h1xrbsxc0YGr6iKLuVDRnVKNSVVBqNc3P/wYP6lBeyO5horXO36+ElBz1Xd9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-OriginatorOrg: intel.com

On 9/23/2026 2:41 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Jacob Keller <jacob.e.keller@intel.com>
>> Sent: Tuesday, September 22, 2026 8:03 PM
>> To: Keller, Jacob E <jacob.e.keller@intel.com>; Nitka, Grzegorz
>> <grzegorz.nitka@intel.com>; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; Intel Wired LAN <intel-wired-
>> lan@lists.osuosl.org>; Machnikowski, Maciej
>> <maciej.machnikowski@intel.com>; Korba, Przemyslaw
>> <przemyslaw.korba@intel.com>; netdev@vger.kernel.org; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Machnikowski, Maciej
>> <maciej.machnikowski@intel.com>
>> Subject: [PATCH iwl-net v2 09/15] ice: E825: clear
>> PHY_REG_TX_MEMORY_STATUS prior to soft reset
>>
>> The current implementation of ice_ptp_reset_ts_memory_eth56g() is
>> flawed.
>> It tries to clear the timestamp memory by writing to the
>> PHY_REG_TX_MEMORY_STATUS region. This does not work properly, as it
>> does not trigger appropriate PHY actions.
>>
>> To clear outstanding timestamp memory, the driver must read the
>> timestamps.
>> However, naively doing this as part of ice_ptp_reset_ts_memory() is
>> problematic. When reading the timestamp index, hardware kicks off a
>> chain of actions including clearing the ready bitmap index, and
>> decrementing an internal counter if the timestamp index was marked
>> as valid.
>>
>> This can potentially leave the internal hardware counter out of sync
>> with the actual number of timestamps. This occurs because the
>> PHY_REG_TX_MEMORY_STATUS region is not zero-initialized when the
>> device boots up. Instead, it is filled with garbage. On a cold power
>> on, attempts to read the stale data result in the hardware
>> triggering a counter decrement for a timestamp that never happened.
>> This underflows the counter, and prevents new timestamp interrupts
>> from being triggered for real timestamp requests.
>>
>> We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
>> timestamps. But doing so may cause a desync with the counter. To
>> prevent issues, perform this clearing always and only right before
>> initiating a PHY soft reset.
>>
>> The soft reset will clear and reset the internal counter and the
>> ready bitmap. The reads to PHY_REG_TX_MEMORY_STATUS will reset the
>> region valid bits ensuring that no stale data is left behind. This
>> combination ensures that we always have a clean slate with no stale
>> data and with the counter properly reset to zero.
>>
>> If a read fails (i.e. due to a transient sideband queue failure) it
>> is not treated as a fatal error. There is already a dynamic debug
>> message for each read failure. Keep track of the total number of
>> timestamp registers that fail for a given port and log a warning
>> message indicating the total number of failures. Continuing is
>> acceptable as clearing the memory is a precaution against faulty
>> software. Correct software access won't read the index twice and
>> won't read it at all except when it has already confirmed that the
>> index is valid by reading ice_get_phy_tx_tstamp_ready().
>>
>> Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at
>> initialization")
>> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 100 +++++++++++++++--
>> -----------
>>  1 file changed, 52 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index c8a67a307832..e1a5ff5793d1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -737,24 +737,6 @@ static int ice_read_port_mem_eth56g(struct
>> ice_hw *hw, u8 port, u16 offset,
>>  	return ice_read_port_eth56g(hw, port, offset, val,
>> ETH56G_PHY_MEM_PTP);  }
>>
> 
> ...
> 
>>  		return err;
>>  	}
>>
>> @@ -1177,19 +1147,43 @@ static int
>> ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)  }
>>
>>  /**
>> - * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the
>> port block
>> + * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx
>> + timestamp memory
>>   * @hw: pointer to the HW struct
>> + * @port: port number to clear
>> + *
>> + * Fully reset a single PHY port's Tx timestamp memory. Per the PHY
>> + spec, the
>> + * only way to clear a timestamp valid bit (and its read-only
>> + ts_memory_status
>> + * bit) is to read the timestamp memory location, so read every
>> entry
>> + for the
>> + * port (two 32-bit reads each). This discards all timestamp data
>> on
>> + the port,
>> + * so it must only be used for a full reset; callers that must
>> preserve
>> + * in-flight timestamps clear individual indices via
>> ice_clear_phy_tstamp().
>> + *
>> + * Due to interactions with an internal HW counter for the number
>> of
>> + * outstanding Tx timestamps, this *must* only be called as part of
>> the
>> + * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the
>> internal
>> + counter
>> + * may become out of sync and prevent new timestamp interrupts.
>> + *
>> + * Failure to read a given index (i.e. due to a transient sideband
>> + queue
>> + * failure) is not considered fatal as the PHY port is about to be
>> soft reset.
>> + * While the soft reset does not clear the timestamp memory,
>> software
>> + * shouldn't be reading the timestamp memory without already
>> knowing it
>> + is
>> + * valid via ice_get_phy_tx_tstamp_ready(), and this sweep is just
>> + * a precaution to ensure the memory is in a known state.
>>   */
>> -static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
>> +static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw
>> *hw, u8
>> +port)
>>  {
>> -	unsigned int port;
>> +	int err, failed = 0;
>> +	u8 idx;
>>
>> -	for (port = 0; port < hw->ptp.num_lports; port++) {
>> -		ice_write_ptp_reg_eth56g(hw, port,
>> PHY_REG_TX_MEMORY_STATUS_L,
>> -					 0);
>> -		ice_write_ptp_reg_eth56g(hw, port,
>> PHY_REG_TX_MEMORY_STATUS_U,
>> -					 0);
>> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
>> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
>> +		if (err)
>> +			failed++;
>>  	}
>> +
>> +	if (failed)
>> +		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY
>> timestamp registers for port %u\n",
>> +			 port, failed);
> Failed, port arguments looks like swaped.
> 

Yep. Will fix.

> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
