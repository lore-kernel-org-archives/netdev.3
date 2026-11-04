Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.135.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793753759;
	b=BPUVj6vBRRhana2b+hyCWaTtgmPcgjCIM6b4CeKaMGbztvRAqh5LqFjV6zLtuAXoXyzR
	 uvNgaw1VEA6wnZNaob6AJ3oA+uxSHT4sKQwd4a4GiGWZ1gWo34uQrme00GL16N0bFk7Xn
	 yb21A5CzkU23mLyzaTsyUp5GhduJ5KXaWjIy+RJ3JaqvMxd7ExJOCElY8oVGcmmuBe2SV
	 yhkUz3+2LpThBeBrN6ocmCqF5zavr7yGZ1SehFjKztGpeXEpsgaX+34nlO5duCJr/RLl1
	 Vez1qp366HljzfWdZdDOZCNOKado/WUX3zACnfdlpu3WwWMhIGPENRNaRkdP71g0ZKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753759;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Talos-CUID:X-Talos-MUID:Received:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ps7jhkm+39C+4CyCcMqaziqAcLG0AhYsA6JuC5YFT1U=;
	b=uDOecJ80TRmkbzmHx0Hdh3NOa8DMICRwGrcWoxqHeaDgx9Qua5oLsZkAKs7IiaewFRFb
	 +CcuA4rFc2w7fwf90WpcCUtQuRR2gmi17xpPdKHa+tzYYPuL0GJeLYqecgiSyCgrlxZcE
	 6bHDAtFbx7C9ZLGiMk3OnCcrMyLZkFbkYjsAIwZEj2sQ6t2+eRNDa8s65MulB/c1zNJ+M
	 HzntEFnyAstCjWUc6dVqMXM4OHsXxrxhtlfGEs1RI5XC5VvfTu2cG6In4RHV+igiVmV2Q
	 q3uSAIAiKf8Cg25BAfxXbsrfKWp6tbV3HHjaQTjOX73WY6rn1TnXWco/1sL0gqRBevA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uwaterloo.ca;
	spf=pass smtp.mailfrom=uwaterloo.ca;
	dkim=pass header.d=uwaterloo.ca header.i=@uwaterloo.ca header.a=rsa-sha256 header.s=ces2 header.b="S67vRF/7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.135.51
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA19606A326;
	Wed,  4 Nov 2026 00:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA19606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.a=rsa-sha256 header.s=ces2 header.b=S67vRF/7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces2;
  t=1793753759; x=1825289759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DgdCMoT5dpJLnjo2f6cHUgQ/sqeTHlcaNOhpC8khM3g=;
  b=S67vRF/7lnKxa/8KoR2UYLJ9vTD0sbTaaJtwS/p7i0qpt+yIvsg6/FO5
   k4HjTloKF6GvI7bZSbHR0ssXnOHI5WGq880UI+2Jzid+IYLHDxiaFK4E+
   AMhm9hN0BU53Jy9+2PREAIS/TRPkhLhZE9tlfqEicuMnm19qZrvDyl9JZ
   E=;
X-CSE-ConnectionGUID: AUZQWDeRSTe09UsxAvCDPw==
X-CSE-MsgGUID: f3P8caKLQJW2HHpIzWPBRA==
X-Talos-CUID: 9a23:e9MrUWH5OylgeJ01qmJOyXwtJewoSEbhwS+BHlSoIHhCZIWKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AAdmYsA0qll6PiwvgErpUZDLN+DUj7f+WWEsEsrE?=
 =?us-ascii?q?/mfbeFQxoGiWitB6Na9py?=
Received: from mail-canadaeastazon11020123.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([52.101.191.123])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 19:55:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2kyn4jqjFJCo/b0ZtFO+eO8G9LNcdkjaHf8nagZfkAWjcVVRPONN6ojspx+yCGVzuyHjZvmRUVc+mFksQWZOjTlPXB2fPq8HwqrMhDS6Mh8/OSCOH35P3NKC8sW1cAKWrC4d/QxwRqJNQgKDuMU4G8J3iJu6i/Ef9cvuPe1L1biqJ4/OK5l6UeJbQP8WwzaR7OESUfWlOX+agUstG+z52q5/IUF70jeeK1b+lpa4lXrBe666sWrWLZX0e11D7eOdn9m5aFDceBiypde4Jbi556owAU86orHKEClfiUbLpB0/6nL+1dojgfTmqwFVDLye9J7hjzByx906rRgVwyyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps7jhkm+39C+4CyCcMqaziqAcLG0AhYsA6JuC5YFT1U=;
 b=QhS2rm7778e7kV9ronOtqqILS+zkV2qqsoLhp3hA9x6YNrP56mgEwB6xtg9dsMujjhN3fYpON2jGSDvyuNkHbjryP4CTOCbfu2qSW22UHniRBg12kBy7H41eqGsMd6NNsd84xA9qGKJd5jDQBX3sKWbHc010jGihhcAjwx+9SdddvyzwZUVufIiatIR0EHNwyBWK44/0VIZW05wRW2IDwg2fEmwNMC+f5NKFXqHHZLYKdkell7m2mfNj8vDNGRJb/GcnjCMVafV3Ban5JrS1ZNy+OTqljxrARJtwQ7pUdBvsmGCMdzkq2y4Vli9i0mEkh7cKoRhJRuzgPO4WFh6i8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:17c::24) by YQXPR01MB6398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 00:55:44 +0000
Received: from YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b6d9:6c24:ae98:688]) by YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b6d9:6c24:ae98:688%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 00:55:44 +0000
Message-ID: <ae3e5838-6985-48be-bd99-fa5a21143942@uwaterloo.ca>
Date: Tue, 3 Nov 2026 19:55:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: cancel napi->timer after the grace period in
 netif_napi_del()
To: Eric Dumazet <edumazet@kernel.org>, mt4022@columbia.edu
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Joe Damato <joe@dama.to>, Dragos Tatulea <dtatulea@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu
References: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
 <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:17c::24)
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
X-MS-TrafficTypeDiagnostic: YT5PR01MB11875:EE_|YQXPR01MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6f5bab-aa27-46a2-b167-08df3a0e5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|786006|7416014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dAiiM3T5TgfxEmpwnfjtzlzFMlWS1elHfUDjF7rEBLlc8XeNTzPtaKVeUY1TFkVJXz32KpuLS8m5oYKcbmyG6UeoVwSoXAVfS+j4smrhN++1vwzmnDkFRN+TPMobcM6+dVa68KW+bac88sKxZW3gifT7NpERGiMR+J2qBD63tssBclf8SOuvnfg3Qk33RW2qAoOG7tJMqToimaco1FUmjyb210BHSkfDlJEkTok7FKhOp121RT93soqquFwvg73VqTPhBFkaFO2FNcFvI3LZmU8WChLng1bLG55iDfreo3Rf3bXyB2C+r6yEkNERf4aP0yv2Y3R/ifmWbGGg5deGTp1u/FI+HRoawqzySMOTIGKmh9+G0uqQ0KjM4xqVR+8w4U5jEBG76R3AB4+FBSF1QqCo3Wn9AVdPsHJqan9UQ3Dgcjd5rwe7U/AW0LKeEUqE6LRhh+Q62G99HYc00eAH2jUdd/LObq+taQe1pYEUzMM4ouoV0K7E0jRQ8Ua0Oh5AXMxCi4WKF5rKceY5BJUmnBYe2TP2rOJLZUz8458Lcs9PvH6PF3Nd+eNEMCEnBSjsRfKnUnq7fRIegOpS1dU8ddkdgK5hihu5Ave5tA2bbqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(786006)(7416014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDRMRzlVRW5nSUZkVGtnTStpR0hsV3JWMWN6dHJhYTI5QUk3ZnhWdTF3b2o0?=
 =?utf-8?B?RDc4cEF4TGdnbC8xZEVoeU1ZSGhDc2pzYkMya2ZhaG5nWFhScTlZKy9Hb2hX?=
 =?utf-8?B?TEN0RGhPKzdrdE00WklXd0hXSWl3TDVOY0QydnFVcTBCWlVHdGI5YzFlbEth?=
 =?utf-8?B?eVYySmVSVGVSUkwxSlUzV2ZlRjRXaU9RY2Z5WDFoTzkyUWgzbnN1cVcxM1hs?=
 =?utf-8?B?U20vYnd3alBnTHkyQUlHeE5ncFJhczZFZ3N3SCtYTWQrQ2IxNU8zakhaaUk5?=
 =?utf-8?B?Y3VXdFpSNGZuOWRNRkYxZHhBQS81WUtnVmZac3pVQlJnd29pWTFiaTZKWUxq?=
 =?utf-8?B?eEVpS2sxOEtFL0lPb3ZjZEJHU3ZGUnBCYzFKUmNrMkRNYU5OYXhHd3ozbVhi?=
 =?utf-8?B?UFRROGdpM1BzbDNRMDVBWnF0MkZKN0pLaGJTWUoxQVM5aWZPRDB0QnJobGJI?=
 =?utf-8?B?UXVYWlBNRFA0MjNsNklyRThLN0x0SHJZRVBpQkE1ODYzSHZnU3d4SXRiYktV?=
 =?utf-8?B?N1IzQ0NzbjdVemN1UHZjTG02UWRmRlYwbEdRWlo4MmlzcmZRTTR4QU95bkgy?=
 =?utf-8?B?QUxLTndoSWdTY3p1bHBGTUEydUcyM3BlYnJhSktuelBYcFYzVFBJcnIzVGpJ?=
 =?utf-8?B?R1UvR0NvUEdLbi8zYkxUMGRwa3R6Sno2dE90OUxMMFJVcHpOOU84OU0wWHdp?=
 =?utf-8?B?MHVMNlJmVEJ6N25RMDdSNmhjT2Yva1RheTVvaWJjTHc0aTJ6VzIxWUdPVXZ3?=
 =?utf-8?B?WFFRSEhkZk9VWTRNdk1OTVJZeE9KY2VKUUJVZ2ltWmd6UTFGcGVQaFZsSjhP?=
 =?utf-8?B?dXdqcDdGMmFMeHk2YzdMbzVBNmlzeVJVTU5rUDR3RFZjMDYwUTNXaFNqNDFE?=
 =?utf-8?B?UTdlMmpGa254bk4xTjg1OFlJRmV6R3Nxb05PanNqWlY5RFRsUEpWRTV1VldI?=
 =?utf-8?B?TnpBaGUvcWNHcyt4Vll3OGxMcVpocGlqQXJidndoOE9URmxxU2h1ZVVueWtq?=
 =?utf-8?B?dzl1TlV1ai9VbjY2U05wZEpmN1I4NzY5bnlTUUd1OURUeHlTajNEQTBWdVN6?=
 =?utf-8?B?NUxiNHJ4S0tZMjcxYm95UnIxQXI5eWxaVGFBdVQxUEV4WVkrRWFUdHE3Tndi?=
 =?utf-8?B?ZlRSeVpNS3M5dlNiekxPQVViTjFaSUo4NFYrRE1nUlJjTGptak9IT08waXE5?=
 =?utf-8?B?NjA0eFNqOE56OXE0UWwrT0kzd0VTbExEcWFNaFR1cXEyTzl0WDdWY1czUUlD?=
 =?utf-8?B?cVExNkQ1eFB5ajB5aHRtQzBPNlU3Q0xwc1VRMDYzS3Fhcms5MG1oRmJrT2RC?=
 =?utf-8?B?RVFDbmEwNEVHVjB3UUsxYnpWRkoxb0picmsxN0ZmWGgwVmlHUmM2LzAxRWVw?=
 =?utf-8?B?NlpyZ0NSaXIycmdQK2FLcmN4MG9Edko3Sm00NlhDUVFKTXZCTnI3ZDBha3U1?=
 =?utf-8?B?aDgwcFhnV1FHangrNG9zOC9ITDZ3OVZDWDZSNUtobXRIK0lXTnNLSU5yd1hN?=
 =?utf-8?B?d3hvLzNZdDNyT0huMkphaU8vTnV1VDNzNmZMVVYwSHVCVHhobVJ5R1FWWE0r?=
 =?utf-8?B?cTFoQ2pYVnVMU0hNekg2OWdCWVhlOEprZXd6Q05ZOUJncGV1cDlrNVhNY0tK?=
 =?utf-8?B?SGhaQzRHc1haY0RmSDFtZGtIWWN3UkFQaTY1RWdtUzYwd05HK1JkREc0YkFQ?=
 =?utf-8?B?dUE0aDJOOTZVUDgzQllQS1RRZTNsUGNKMXVpU3psQmIzb2pUMHl1Tkh6aGdX?=
 =?utf-8?B?SEhoY0U4Qm54MnlkT3ZXczJ6U1ExUWxDbzVSTVpNUFd5Rm9DOElES2Q5VjF4?=
 =?utf-8?B?NXpZc2JMQzV6Z3oraFc5ZlI5TGlmWVU4TU94Rm5UU1VkVUFQZkZCMXdwQWFQ?=
 =?utf-8?B?RlJKazkzU21qZCtrdEdMUDVxdnpsZlBDZEF6SWNpUnlmeWtDWk5VaVVLWk1y?=
 =?utf-8?B?dEp1QWpTcmJmUEcrTmQ2MXc3dXBLN0xJdmVZUEkxWldMUDREYVVwUmh1blhl?=
 =?utf-8?B?MkNCUkU5MjhST3pidlFXWm5XclJYeGlVOFN6aThBS252U1FvVlg1SjBvUHZO?=
 =?utf-8?B?ZUJsOWtwdjJLaEZSYW5aeXZMWXh1UlNXZ1BpQkZtdHkyVHc2dnBxcmF5TjBL?=
 =?utf-8?B?OHMwTStvaFNoMll4RzNvcDJrVS92SG45ZVcwYit6Qk5xamFUZXp0UjA5bnln?=
 =?utf-8?B?WUQxQ2c2YmtCR2pDVE1yaHNvV09Za1dFSlg3K0t0M2JXbXNwVjY0TzlUZXIy?=
 =?utf-8?B?WUNmNjZyZEZlYmpkV2cyb1dBODcwdkNQUHltdXZlcWh5em9HME9xZGxrcGJq?=
 =?utf-8?B?UXlBNklHWGIvc1h6VlpTUjRPZmlOZ0tzMWJGbmdJa3E2N0h4SU1wdz09?=
X-Exchange-RoutingPolicyChecked:
	Y20et3zPny4CHwfypPanbo3yy9b2heYAneuIQt2FHCRwRG/960rHvWDosbCADMTDtjm4YxTXIbi6es6hKAtqu9330Z7b+sC+lQ/Bc6EfVawTGItV29005K/d4lgowylrEATjh703/Q4H80HzGCtX1B7zhdUlGLP4WTPhyM8mG5rFRvqro7saurer/fE1CKujtAnu3+wV87Ra+/LCKKNmHkNz+BuNYO5W0Z287va38XAGsAskNUiugrxHhPSGUm4PLJYVOBkfb4kdqPAXCeAjj53j0Syx+lFIod0JPXgPaiNxaq+QJCVskEKraxgjcvsSwbNeFVv6aTE0F7UCTWyKjw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T4QOB2pSFdYdsgqIHzBgcoXnRXE4R0mnSBOx6C5kp/tNiLHvq/0eLHsUvH/nRVdpswEAk4vgoMT5iWHqrHppWQ6n8MalPG7/xs7XEqxOwf+LQzvKaWQ8FyBjrxpmyEArcaHdsgDtp5tGz6EIo9mgZQhHNaHy4cD2d2goaBaa5dEcoMkUN3xjj6M3PjP68+zRZWOrhI4apc3PS0/FBlwCiFbEtSp8PnDufjC7WyJSfl512uinQZq+nvWjm1gLNwgD8UC7+2aNGtyUgVPKMh3+2v5EMyxl9aB1EkoWBeav27SXepSfVikvjv6mhNX8fogBzSVvsQMtTHIHDvZjafpztQ/irUBH1K1uGPJ0pHQsG5JfaXH3TkKNbMhgjkkbkSabItLTc1LnptWOHI20jWxGZQFdy3CbJVgBSjkVivOQgRuLbayTWBJNKj7jNfXwpjseRyJnwi+aVYr56lKCx9+2wH23BGo+/y6A828RAMbpWc7L/EVKJWb8NZHtrIyvxo8etdR8vyAuUX/LhTu20oqQGI+yoixttHvSRW5C496SiSN5OUl7iSrFistLQD6qGBFzgLrNRxig4shltX+BmxbUgkqsnAVLTHMyQ2uNbRvlp4pyyUor0/KLWDyuPQlHxFLu
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6f5bab-aa27-46a2-b167-08df3a0e5b47
X-MS-Exchange-CrossTenant-AuthSource: YT5PR01MB11875.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 00:55:44.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZV/7/LIPD8ZHBBlTOQqA019JzFQCeKRD3/JnliZjIvMCObY5wowomXL4BIwFEdi+EXk1tyT1NKkabz9YgIAZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6398

On 2026-11-03 13:37, Eric Dumazet wrote:
> Le mar. 3 nov. 2026 à 19:19, Mani Tofigh via B4 Relay
> <devnull+mt4022.columbia.edu@kernel.org> a écrit :
>>
>> From: Mani Tofigh <mt4022@columbia.edu>
>>
>> A napi can be freed with its timer still queued.  napi_disable()
>> cancels napi->timer, but napi_complete_done(), busy_poll_stop() and
>> napi_suspend_irqs() start it without owning the napi and can do so
>> right after the cancel.  netif_napi_del() only waits for that start to
>> finish:
>>
>>    Task A (epoll_wait)                  Task B (queue reset)
>>    napi_suspend_irqs()
>>      rcu_read_lock()
>>      napi = napi_by_id(id)
>>                                         napi_disable_locked(napi)
>>                                           hrtimer_cancel(&napi->timer)
>>                                           napi_hash_del(napi)
>>                                         netif_napi_del_locked(napi)
>>                                           synchronize_net()
>>                                           /* waits for Task A */
>>      hrtimer_start(&napi->timer)
>>      rcu_read_unlock()
>>                                         kfree(rq)
>>                                           /* timer still queued */
>>
>> With netdevsim and debug objects:
>>
>>    [    3.073483] ODEBUG: free active (active state 0) object: 000000001504358f object type: hrtimer hint: napi_watchdog+0x0/0xa0
>>    [    3.073515] WARNING: lib/debugobjects.c:629 at debug_print_object+0x1a4/0x3b0, CPU#0: napitimer/66
>>    [    3.079603] CPU: 0 UID: 0 PID: 66 Comm: napitimer Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>>    [    3.084822] RIP: 0010:debug_print_object+0x1ae/0x3b0
>>    ...
>>    [    3.103822] Call Trace:
>>    [    3.104408]  <TASK>
>>    [    3.105933]  debug_check_no_obj_freed+0x496/0x5f0
>>    [    3.109988]  kfree+0x33a/0x510
>>    [    3.110715]  netdev_rx_queue_reconfig+0x357/0x580
>>    [    3.111780]  netdev_rx_queue_restart+0x8f/0xc0
>>    [    3.113924]  nsim_qreset_write+0x24d/0x350
>>    [    3.117832]  full_proxy_write+0x109/0x1d0
>>    [    3.118741]  vfs_write+0x1e3/0x1250
>>    [    3.124758]  __x64_sys_pwrite64+0x18c/0x250
>>    [    3.129645]  do_syscall_64+0xfb/0x590
>>    [    3.131385]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Without debug objects, napi_watchdog() later runs on freed memory.
>>
>> After napi_disable() and a grace period none of the three can reach the
>> napi anymore.  Two need SCHED, which napi_disable() keeps, and
>> napi_suspend_irqs() needs the napi hash, which napi_disable() removed it
>> from.  So cancel the timer again after the grace period that
>> netif_napi_del() already waits for, and in free_netdev(), where
>> unregister has already waited for one.  With the fix, debug objects
>> don't report a freed active timer anymore.
>>
>> This bug was identified and confirmed with the help of a deterministic
>> hypervisor currently under development.  The C reproducer below however
>> hits it within about 1s.
>>
>> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
>> Fixes: 3fcbecbdeb04 ("net: Add control functions for irq suspension")
>> Fixes: 58e2330bd455 ("net: napi: Avoid gro timer misfiring at end of busypoll")
>> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
>> ---

Thanks for reporting this. I'm very impressed by the reproducer!

> Bug seems real, but could we prepare something generic (in the core).

I agree and I believe Sashiko has found this bug earlier [1]. I didn't 
have a reproducer at the time and maintainers didn't flag it, so I 
didn't speak up.

I thought this could be addressed more easily, by adding to each of the 
3 calls to hrtimer_start (maybe via subroutine as Eric suggests):

> static void napi_timer_start(struct napi_struct *n, unsigned long timeout)
> {
>          hrtimer_start(&n->timer, ns_to_ktime(timeout),
>                        HRTIMER_MODE_REL_PINNED);
>          smp_mb();
>          if (unlikely(!test_bit(NAPI_STATE_LISTED, &n->state)))
>                  hrtimer_try_to_cancel(&n->timer);
> }

     hrtimer_start(&n->timer, ns_to_ktime(timeout),
             HRTIMER_MODE_REL_PINNED);
     if (unlikely(napi_is_scheduled(n)))
       hrtimer_cancel(&n->timer);

> And in __netif_napi_del_locked() :

This change is not needed then.

My reasoning is as follows: SCHED is being set in napi_disable_locked() 
before hrtimer_cancel() is called. hrtimer_start() and hrtimer_cancel() 
are atomic to each other and impose strict memory ordering via the timer 
lock (I assume?), so the SCHED bit is propagated, if hrtimer_cancel() in 
napi_disable() happens first. Memory is not yet released due to RCU. If 
the napi might be scheduled for some other reason, I believe it is still 
fine to cancel the timer.

I am not sure about hrtimer_try_to_cancel() vs hrtimer_cancel(). If 
hrtimer_try_to_cancel() fails, the timer callback might "running", but 
could it be on a different core and slow enough, so napi_disable() might 
complete and memory be freed before napi_watchdog() is done?

In my tests, including the reproducer, this works, but this stuff is 
always dicey...

Thanks,
Martin

[1] 
https://sashiko.dev/#/patchset/20260523012247.1574691-1-mkarsten%40uwaterloo.ca

