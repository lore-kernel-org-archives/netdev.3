Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1A28690;
	Sun, 20 Sep 2026 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873349; cv=fail; b=mQtBxfTZiF2dABR2RuuRnUp9FOXG48BMkmq9yOf0RgGULagKtyX7UQ2oYg6rYqlDSUgvMoXvhkOai9v05eRG8/2xdGnyicCeriVUU7nM7HWkAOvKuNYzbRBtCMpyo+SY7bVU3q6cuqb0+a24eMX+ekHri/Rwk0tvlMzS+p+9PFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873349; c=relaxed/simple;
	bh=2ZlDc0f0g36I/uZY5snxOVvbTR6KbyvmvELKQcV1HO4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNBM8i9o14FJgWKI5GO2vl8DexPFWLD1cz1tFp+7ySdBjZroC0rovDJT3JaaVBaHArYF06SQGRKowi0BHCpKQWNaoeLAbBIX+/aFsHHs49wgRfQO1tMwKzwZPwjT3tlN83+ALZ8IiKqdCdPkX3EVQK7wv0s1plvNyupLvtgsHBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pl3usSLq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pl3usSLq"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K31TtM1939136;
	Sat, 19 Sep 2026 20:02:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gO4pbNE9kCcfU5hu2/P5rMuxCY37VbZ1fsmMcxW7pn8=; b=
	pl3usSLqYO1OSLNnM/49E9R9XHA/aorc010URPWNpWHlXJaH7yF33YjeNJD1WoRO
	LuctRq5nxdQ/zLzosmWSL6sQ/3LOulLi09chAd7p902iM5pgsP70QVdmcs0vYqnK
	m+jWGQctO2rNn0ZqG39XQ+IeO3jG5IGQ480M/WaK0LRTa8wPyd094n3N5UgYAWF6
	GBj0Buhl5nSwVDdY3F354KAFJ2eJGevQOxXxFApIBkjSAZdJ0OHJ6E2kB4oXKatD
	Qpz8ewpwcJzvq0lmtyDBMnLxCKXFYfdn783JOdSnvhq7l2PvE1eBhHcmTB90QKUA
	I+3QH7DewS88U61DFfUIDQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020126.outbound.protection.outlook.com [40.93.198.126])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gsnp18te9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 20:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbGN+vukKvB2Q7WgVietsWJtI4s9t+9GP0pjagISE9UiJLcsIFsNqs23kyhSbqstuX+tWwlXmmo+emVHWnxmlQ+cY440qSsKQnZWw4g/mp2fAbff5uvqtkdliU7Q8qUfnB1AkijdLOP8Xl4A7CX1b4kAapzzYFX6VEYjjHOE3eg8C1x8r8rtr0Sjc2w/luvCDyRuSLR3TLIj+E2nuNBQjfoTn6qM/B3qCaMaC9ST4CP7DfiYPCgyt1ER4ZCRWX38hFcG+YB1+CaU0pgUhy69FzYel7kp6O+y1HgxJAI3whABBSxiDt/1/ht8QbcMDNhrkIcMYfY+PDZkmELTwy54BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO4pbNE9kCcfU5hu2/P5rMuxCY37VbZ1fsmMcxW7pn8=;
 b=XMexUyJdq3BaQkAP+htVXco8P5fl8hfB32BBofUHf8Hm5HgOF9NEHiJcimHmrWEzfKpl/b3LZkHIQiqKFPYVP06vxF8JHutEuTy5eMJtZgUNZTmeSAztuqPKMHTEmm/S7/UvG5+Rt4MmrTrrZHC7ZMrPJyWn/rKxxSn3dMNZXMn7/J+G3m+Iu4dVFoWc0BUp5IGPSB4rmcAp/hbt2FFG1vlpUjlFDDXJ791qp8BCt4rBIjnNwoKmVht+7F0P2kzH2LOtnINMrMdLfLUu2hbM19pxWR9fssNwbSBL+khyAZDWSupTV4sRv0cFpzvgm+FppNAxxujwEFdwlGL6PLtYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 03:00:13 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 03:00:13 +0000
Message-ID: <2e8b7676-ac09-4868-9444-fb621f43effa@windriver.com>
Date: Sun, 20 Sep 2026 11:00:06 +0800
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
From: "Zhou, Yun" <yun.zhou@windriver.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916061314.936440-1-yun.zhou@windriver.com>
 <20260916082028.GA879236@shredder>
 <c51150c8-85dd-43cd-a615-65cd45b3affd@windriver.com>
Content-Language: en-US
In-Reply-To: <c51150c8-85dd-43cd-a615-65cd45b3affd@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0006.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::17) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DS4PPF0084F97E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d53b84-e172-43bb-63f5-08df16c34a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	LBEFgGLErqGylDoOMM6QtwGRaVdiBc9bebE/FGipZdLFKLMQMKeD7HiK4sR5SkLEs3kZoGO0NbFZw29CKKc89qcn/yo1PNMyMJtaQIkHIfbrCUTO0JIxqp+4P4+U/x6OT44mUem/dzzLeUdwT7mVRjJLV/2XZRWGC1sgZgxzJpdgCZC4UclEREn9+rhGxS52vNZu6EdhKiZypQ1ZqeowKNPjVah7mCwsmc4Hr1KGclebgPEAZiwhgoQM3Xcy3kG7o592+Y9bfpPkoNnLvGhz13TNOYad5HoQPOHnhkDfrGPbEgDpodtxgt3RfHFZeAY1kLwWJdcFAS69CH7dt+Y9O7S3xkCpWYynQPwaT50jbgXkwvZLz//8KdivXStbjh33rdgTDniRny3YIKjqf0hME0aPotMw5tc5iHWp6o/WJ9T4MOR4oMyI2xggORe18Konn7jWIwnEpi+hsyE7e3dkLtsvsU3HvEhu4EJsmobkJDYFqSu4tffdUYsPF8gYAmge5nEP2T7e1iILulKmjs/GwNcGDLONrRpenFHnRXIusaIkUyZlKgBqx75wjJJGNtUxiRRDm7P/YLPZUOqRuFKtONM77s9fG+HQJPWymdQ2/qz7kaTaTcjcI7lO09RJwTgyFyzBqNOYYiCtN4bmfIBFLdaH5AUR1mMVU86gl0yh32o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFzOUdHeEw1KzVzZFNGQm1ad3B4WlZPRjIwZHhESm9HZ09yRWFLMWlNUDQv?=
 =?utf-8?B?UUFrMzZhK3hIb3dxdmNQWEt6S2x1VE5TYUxidVc2TldIZUJpbXR3bjRQR2N4?=
 =?utf-8?B?S0VMcnRIRTd4SnplN0FuNlBXMnJXQ3FlNUozcHpyNnp4MzVJVGF2REl0WjRO?=
 =?utf-8?B?ZkRjQ01nNnZPNy9MdURZTFBiQzNUeER4MHBRbHFicTlyWHRUczZ3UkJyQk12?=
 =?utf-8?B?MW1XdGpsdTNSRDRRNWxudkdsNlFWNEV6Y0wvL3p0blNmVUJmc0hXcFFBWjJ4?=
 =?utf-8?B?VDRDMm1Ec3IxWGRsaHMza282VDhadFVjSm5ML1V0NklqcFk2MGtMQVBjU2lK?=
 =?utf-8?B?VlFoUmkwVnlxOVZtMllTM3cvLzNSUXQyVk1IaEg4clAwNVRFMGZ0cUsvaTZM?=
 =?utf-8?B?Mk5QdlhEZHgwWnNySEZPYWprZ1NUQm05ZjBpUWxpdmdlL0h6RUltcEV5T29l?=
 =?utf-8?B?ZDNweEJFVHVyZjczTUZYMERsRmVRd3pVYnI2SzZia2lNMFV2cmxOcjg0N0VB?=
 =?utf-8?B?WTJhZ2xab3Bwd2ZlaEFtc29mNEdhSytqQm1yMzdPcldrS2E4czh6ZmlPVUJV?=
 =?utf-8?B?VU1tUHVodUtZVTF6MXh1QTBKZDFBNWpnSUhpMlliOW5wdmk2QW9tMnN5Z2tS?=
 =?utf-8?B?SzVoRm9ta3Y0YmFWcENlSzBYQllodmc0a01zUm11RG04TFYyUFJzdjNDNGEy?=
 =?utf-8?B?VWxDTFZVeTltV21laW53VUNvV2x0UUFIanlPWE8xRHlkaHdxRnRVc1hoVUFV?=
 =?utf-8?B?MjdqSVk5VjNnL1hoVDM0ck8wMy9IUVpnaTZ1UldMMDZkYjJpbmpLd0N6OVht?=
 =?utf-8?B?MmVZdmMrR2N3Wmd6ekRmNnN1bkZadzBURFFyMDBFdEJRSHVTRVI1c0szVklx?=
 =?utf-8?B?K0FEZ1hDNEtVRGpjYzBHbVNaN21vL0dyaFlyc0dqb1U5bUlDTit6RDlaT1hY?=
 =?utf-8?B?dVg1TWhGbzBKbzAyRGtkcWpIQUZqb2dHZHkyWWF2YzhNa0xvQUVNbXVYUVBm?=
 =?utf-8?B?cDhzRHNzcHJ5VUh2TEZoKzRXNTFwNjZXb24xRlE0Zyswa0I3SmVLRHhNOFpM?=
 =?utf-8?B?Q0JaQVpCMlNQWjE5Y3N4bHFDU2N0TFNkTWl3bDA0cU83WGtqc3hENjNLZTNr?=
 =?utf-8?B?ZkhGbDBVVW5mNldWY040cHNOaEp2R2xBV3Nrb0w0ZWFvQW1nRXR4M3FHd3hF?=
 =?utf-8?B?aUlMRzRQMm1Xd3ZXblkxRWVRV0t2RUdxeEtXZkdpVUhWRFRSRktOMG1ZWmt2?=
 =?utf-8?B?M1AwdmhjR29hL01OaTFPRnVsK2pEWnhHSGtSUnBFdjlwRnFBVUdIdVFRc214?=
 =?utf-8?B?SW1lYUZWc3p3bTlpK3I4SndYL1FvR0JPbVJWOElOaGJTQUhMYzZFVDB1WXZ0?=
 =?utf-8?B?Y2J5dFdRempwbzlBSWVSVWQ2ZUh1QlFmZnhTSTkwOTh4T0ljd05rcFBzVjhC?=
 =?utf-8?B?QmpzNlo0T3Z4eVRGc1FDM1MxTm4xVGFPUnNqVTh1d3ZPSEdEUmU1OTNzbFFB?=
 =?utf-8?B?amQrVmJOSEg3T2pVWmlQWXRBVStRZXR4RW8vMVZ3cHZlcVFGMEpyYlIySXZi?=
 =?utf-8?B?K0dkemo1TmV2ZHVwMUpVcjAyOW4yM0pvKzhyMzRlRFZzQkJxR1lDNW5COHQy?=
 =?utf-8?B?Z1FrRXhZUGEwakxBSFkwTlFLZVVHamFJRmVTTWpUbHFVSzRuNm15cWZVSUl3?=
 =?utf-8?B?d05aK0JQQllxdnl3amlhWXA1bmtRVWtrVmR4NGN0YzhHY0dObXJkbVRpQTJQ?=
 =?utf-8?B?UVdpZkhsMW1ocW9GUVlPNWs5azZ5RU0rbU0vZlBmSEVBU1lMNWt4QUVMQmds?=
 =?utf-8?B?TmlXa2tURGZ3RVA1Qnpuc3V0emk5OGwxQXA2MDFkS0JRc0UybTFvNFg0Wkcz?=
 =?utf-8?B?VUlmS1VBYkg4SUFsVlpyaUFKODJyRDl6LzczaDByTW9iZnlza3RHOEhQYVVl?=
 =?utf-8?B?Y2RTalQrVFpneFZLM2xXbWR3ekJWYkFYa3ViczcvT3pPWVRmYWtjemNzbjdt?=
 =?utf-8?B?clZHSVNibE1JUUxwQUZNUXBXelA5b1hlYVRNS1RTclRzV29vSFJjU2pBZmFo?=
 =?utf-8?B?UlJmS3F5YTBZMUMrV1VzUkVKRzRFTm51bjJGTCtzM3ZMU3ZEZmRzVC9YaDBQ?=
 =?utf-8?B?S0hxOGYwMks2RVRqZVVkY0FYaUtnWXJKNER0aG1iMm0reHdYM1FpNVBxYldO?=
 =?utf-8?B?L3ZVSmdBbmhHVHgvUHc1OVBoWVVHdnVKRmRqbWZSbWxtSzJoYlcrWFI4YlNR?=
 =?utf-8?B?NEtPdVJ2QksrVEtEMkttcU5ENWZSNTZUcjVzUGdTM2pENmRnbWE1N2dpYnFm?=
 =?utf-8?B?MUhMMnZ6OEtNazBlNDFCc2xPSkY1MDh4aG5PNWRGVFdzcWlqWWprQT09?=
X-Exchange-RoutingPolicyChecked:
	PBA9sedLvJVJR4LG6jBxsMTlhcXdrCnwoFb9meWQqbZxmolDiKXXHwMmxYcAlq236PwRNiogp7XiCqRaLkHzVd73wCzeD1bYmpdITwz5uSRodWJjUHNFQaEPB6G2rgjPJVeHB7T9y2I98ufFhoyD51L/GqS5+IeWntWoHh3fsSTXa1++mEa1tAFBdeUGmBLbCJ1WAV0llKwscjMFzWCMipC42zlSmZOP73UklIBnKaFfXUyOOomTUnxUfcNHBpUCgRMvMuxp46j0kMGvjU0uYnxDiSvHJ0JJ4mPSYZhlDNj2dHMJmkqkjw0AV+jX2iJJHz2ozeFqowvqspVG9cDXbg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d53b84-e172-43bb-63f5-08df16c34a5a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 03:00:13.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtOiv1S7AVsmEVnddD1N8iq8DRx2dPGB6bmma/tCUu9P0auj6Eg1ol96wxSkidUeqvEjbFSt/grA12xd4paGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDAzOSBTYWx0ZWRfX+jeAPbqWq1ed
 kXcZbW0epmoM5Gx5p4sg5QiRqFq0yho6L2j+DvipM1qtSZgZVmCtRxc0iE/J2kCicUaxnDMTSFR
 +SwAzCPMliOwncdpP+0nSSNRqFlIh2nzmbYXPLLMsM48ieC/B1fu3RH6smrSBe0Qdjb2fCMvPgz
 xZHlL25Mi3QduSSjC4JGYruEuvQz0gQq0xZfGEafegsv7QzAoPVTaMfqVZCqqvBus6QHkuDpRkH
 8jo5MbncNzEYUYvWMMbKIwameWNgwp9rOse9L2PfAwSwfh4472FKsJVUdwAjk1u2O5sehVkuNl2
 fZENUjLKBT8KJkco6+0HKjQBRYNGFH1jGLj0Js51r3vDoFVoTAB2FsqVZjoc3f4nDe4I2OzAmn9
 qCld0jpDERQwzC6f//NI+YiZvgZrTxVRPK2wtg8Ki5WJuLtVvt53Hc06GEjXZcDFBojl1DRnZoS
 FctNDt8Niu+MuJUkoPA==
X-Proofpoint-GUID: OFEv5dQC_qveYqXXj_rfMQePKZV7c0zD
X-Authority-Analysis: v=2.4 cv=V4foQuni c=1 sm=1 tr=0 ts=6aaf4cb9 cx=c_pps
 a=zTPsRPtK75HwG7WtZKDGLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=sUMH9g5_OJz-NEqG168A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OFEv5dQC_qveYqXXj_rfMQePKZV7c0zD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDAzOSBTYWx0ZWRfX3YCtEgoaAjry
 jgmob/80XThkFd7nNK7zt9ACS2bJgKjAY+/ht4HntNu3iM1LsxPqelVnHMKu2ZFPOGULpIg8hlf
 A6hlF3Bg3JX3dxVr5hoyB01o1hUGTXv61grXsTM9sGcBylaLWnzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200039



On 9/20/26 10:48, Zhou, Yun wrote:
> On 9/16/26 16:20, Ido Schimmel wrote:
>> On Wed, Sep 16, 2026 at 02:13:14PM +0800, Yun Zhou wrote:
>>> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
>>> nested acquisition of _xmit_lock on the underlay device while already
>>> holding the ERSPAN device's _xmit_lock, creating an ABBA deadlock:
>>>
>>>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>>>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
>>>
>>> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
>>> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>>> atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
>>> o_flags is no longer modified in the xmit path since commit 9958e69b9893
>>> ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
>>> GRETAP, the sibling device with identical xmit structure, already sets
>>> lltx.
>>
>> In v3 I asked that the commit message:
>>
>> 1. State that the overlay and underlay devices should be of the same
>> type (both erspan or both ip6erspan) for the splat to happen.
>>
> The devices do not need to be the same type. The actual syzbot report 
> [1] is between IPv4 erspan and vti6 - two completely different tunnel 
> types:
> 

More precisely, any pair of 'locked + re-entering' tunnel devices whose
underlying paths intersect could trigger this issue — for example,
gre{6} (which previously didn't have lltx set correctly), and currently
erspan{6}, vti6, etc. Same-type pairing is just one possible
combination, not a requirement.
