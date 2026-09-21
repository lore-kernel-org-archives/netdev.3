Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BD4825B4;
	Mon, 21 Sep 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987644; cv=fail; b=IwPwWR9EC7SQDjymdGHTigNZry/PivNBcLB9HUDbhNm7N8reO8sU3LcRAZQtMvjvWz8UE4CY9RDkAMvoo3tybv9xZVC4MyEp2lMHu3gydfHuJ3zEvVT2hrHQCsMdQUPHTDTg+jazKNdfTztw7K6HfPUglp6ir08S0DkPBr4+Vg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987644; c=relaxed/simple;
	bh=fP6qGGp3rmWppzIu4icVu1QMih/RKJneZxEE65Cnl2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1ztz/obR67Ry3uLnzIoV+cC3yE/kf0sgewK8u3d4df0RD4jAZyVRiQHrufuueNoYeArW7c4EycJIy9LMyIaG0nxhwRGEEyERWCMwIoyx/Ex5rBvys8k5U37BUCDpMV6LPnkZXrN3APKCOJn8XtxgIxEr5WJcyTb93j2/OF0Zqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=I9g2Ywd1; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="I9g2Ywd1"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAfwJT1474455;
	Mon, 21 Sep 2026 03:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eNdmB+wYxh2UNNpo3d62CuO9Y9SRrD1zSjWd0dBJcL8=; b=
	I9g2Ywd1FSsjy0Fi7v1ma1+f3DEz8NZUx4VsvWaRGj0Om/xRUj+BcKvKtHK6eoER
	0zClDqcLlZKwAZAzsO5Cqv8kcrqsi1s6jQqbae6PdDLAhHruzSvOdEzoQLsg3KZA
	dzxpvYq9zKiTshqOatgTzJuY4rM8lDsKPRQgCyay7J1PIQB3aeZ9aLMyGL/dQbK9
	ztYMjSWdWhEY1fQ1d1U9exj/Y2Vp4Pmtd+KU6qaTXr2oKX0HFqXGgbfL71rLVxJn
	n/Ou0MOn/Lm9W3Gh8E/93faB1hWnkLago7x6ujSQ+LSTITLXNHNfQsbMruPS50Ei
	6KE5Esf6nNJSNouASjz93A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020099.outbound.protection.outlook.com [52.101.46.99])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gsswe20tj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yqemwc2yUfDF6SrtBlhtlM5i+DfchNGejjFv0pjaD+YgO1TDDsGAF5Nogep+GzVCi50K3fj9XbsWT7MgPgEl83OTxRPLCkaRaTjqUocWdnEO+N9L5KH6SUjeU3JKI2ug5VZNvwj5Wae+aH9wl4DjVNFlidOfw/ij1MdXjjmGu7BXpQ64Pi1skEeLnRmapkgDIp5G5Kx2Zzpq2pHjZJwfxp3x7MfAezuzf+C+kHuJUhp8vj+gPUrlTrFwAvHCjFsHN88nb9jFwYJPgddHCkjlEOdSRiEjEvMAgEMcWFUZWmTfiUWYDGYjcC8cDGWoeQD9nLxxyZsdLdHJecUFfLKXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNdmB+wYxh2UNNpo3d62CuO9Y9SRrD1zSjWd0dBJcL8=;
 b=PssQzsxiQnMYMtjqLxxsxAUfgcV6OhcGsXAcDRmhbXXCFA3KdMeMVEbCbfwqs/Q0d0tyL+DfD+X9l9YpnJM/I6+F5Y9MxTY/JowzpGQYO97Rsj6/gh73gSDT91vRcQtJhe6ToWhpoJLoF9nkC5CtdTfY29cdlisZH7HTfW0xvdXFXEEHo4RtGbaUeLNkxmZ0JdmEosMPLRA6JuC+XWBQA7Zw37jLUANJWrFICiXCiWeRuocrxOJ09wF3CwMUAyJ6XK0ttOnlpcBY5idyYI4RBjjqhyqGqtEWCJpY9DNFNUtP7Pr4ikktTqR/l0rOM7QFrw66reGp2Dggft5SQDZQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA4PR11MB9443.namprd11.prod.outlook.com (2603:10b6:208:55e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:46:25 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:46:25 +0000
Message-ID: <3e23a695-d3dc-4a77-88b7-afc68869853d@windriver.com>
Date: Mon, 21 Sep 2026 18:46:16 +0800
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916061314.936440-1-yun.zhou@windriver.com>
 <178988609227.2160803.11846126417836059113@kernel.org>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <178988609227.2160803.11846126417836059113@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::18) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|IA4PR11MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: cea7daed-0ffa-4462-9829-08df17cd953f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7bj4zTeXSW+heVly3aODsh6w7Dd6ihQtH0zRnP5QdgbA4f7Gtmn6dJTWTkLaHQDOfkZ7nYsH8A+GN4ozHuSpe77wr0ztv3VxYTRRdrELVaUFoE2LdydaBCk3Qq57guk19C3Bvu6ynnI9+R28Cg1QVsDz/RrI/gqIz+gy8uy1hWSvtxT0tANTs1wdH+CkkDc1p4yhisDrlbSmB+XTIsxhjAhD4h35+hm0NgsH/HXNZF5HU6yWSS4o3fna0SujfDWJmHk8ReelRUrF5QUHpnp3RVYxu7BIkfDTiYT2v9zXIlydaLaN1dPGo50nGIk1P3UwGNaw9zb/F8b5LFW2OxiTALxXJvXuAq4tHN2oabPP0EviKlv8+W8ivVutZE+ybO78irQt2geacOZhQtAYTDKD1chH9NKvPzSCuOvJoIskbr/5I5Wpw+A1zhkSEZUIwcQGTLyWnDQATGYFkYeg/c5DnIdtuTPHJPnowZpMvacuZdbziPbG6RYag8C7TbROH3ApyAt8MZ2DCaQSaIQxV4azv/965yNjRcSova5MFxazrtv8Fc3aWZrUEOeAsnZfY9BC3wTphdqnGOoAkhKnDLzjxbluHwE/8Zkroj9o9nQ/iwAL8TrUQ1sCecrubyHsm7ZE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhONWE0Um1OQk1WY0tqWnFPd3UvcytyN2dRdDZuZEV1dzFldEw5SXhCY3F2?=
 =?utf-8?B?bzNwRHhsLzlDcWdYRkNHb2hPS1BicGxNN3F4VURBRjZqYjBVS05JdzZGSksy?=
 =?utf-8?B?OGFBVnpYUDhBNUtROTVuU1l2Zmd3azJBUVc1UllYaVhqQkhlQXV0em9iTlRX?=
 =?utf-8?B?OHlRYWJqZDQ5ZnpaS0FmdFYvR0NlZERxeHZjcVhiNzNxTHJ6NXJsL3pyTkUv?=
 =?utf-8?B?VUl1V1p6TXhRTGtsTTI5Qm5pbmpiSG9kY2VYYkRyaldQVWRKdGR4Y1dqU2tl?=
 =?utf-8?B?VTMrd280RDZ3Y0dUbHpXY05EVHI1eFZLOERXakFDTVFyUmFUdlpqOXY3NDhP?=
 =?utf-8?B?QjJNY25GS0Ywa0dEazF2bDBZWmFYbmdaTmwySFc5SWpHVEI4UEZnT0NFM3hI?=
 =?utf-8?B?dU1JdkNkMFZuTnVDQnREQlpUMnlpVnZWVkJhamJuQmZ4WGFMOWEwV0plMFJB?=
 =?utf-8?B?SnhNTjdGcnhsQVJLNUpOc2pRQUxjNmwycFczTFV0cWo4bU56ZFdMZ0tPU2Mz?=
 =?utf-8?B?aUdqVTdMTDBObDE5Z2JhY000MEdscExaeEJidFpxL0hjVjBWcEx2OTdyc3Zw?=
 =?utf-8?B?Ui9peGJabDdzQ1lmMWlablpFK253WkExOXlDVEIrdDU2ZDlMdEo2Y20vZGo1?=
 =?utf-8?B?VkZFc0M3VlBpdUo2VEMzbm1tb2p1VU5RNXhxTE8yVytqb0N3MmlUazhqTHd0?=
 =?utf-8?B?cXNudWw2alJJMDF0WWlyWUxTV3FvekpLTWdkTTRaWlhpMElFSTQ1QjZlL2hx?=
 =?utf-8?B?bVhkdGwvQ3RDNzg3azdIYitJOFFPRlBwdUJhNkYwdVRMS2RONGsyM3hDTFNB?=
 =?utf-8?B?RnppU0VVQ1E5Qm5YdjRNbjNGa3p0aTlJUTBGMkZrK1lTWHV0T0F6dHNicWhY?=
 =?utf-8?B?YTBXdTVIVFc2Wk5LWFU4SFpHRm0wZGJYNWk0Y0FxUUVkdnBXT1ZTUDFidm5F?=
 =?utf-8?B?YzRaeWlramh6b2lKWitqb2pPSE1CWngrcDdkMkZZZUxjSW50MEF2K2dTRFNC?=
 =?utf-8?B?WE4vOGpxUU1XNU1BWVhMNWtnWkFCZ1J3RVNvelUycVlzTzk2cE81allpTitK?=
 =?utf-8?B?anRsMGVVeFA0R1JUYVlwT2lFdEUrbG5PMGF6MkVEbXlTQ241cmRIRk9YNjEx?=
 =?utf-8?B?VzRZVGg2Y0pzMWUyemZpeHdFbzhydTF4VWFON0RGZUhqNXhkM2t2VDJRdnpx?=
 =?utf-8?B?RlpqSVhxOU9nVU83aisyZmxpenJYdkltbHNNajFIa2tIV3didE0wUDZKU2VX?=
 =?utf-8?B?bUwvMUNGL2h6cXZoS2tWOGxhQmIvZXJxR0hQMWFhMWZJR1VKM0FESThYRStH?=
 =?utf-8?B?cXVLdEkxZEdOdHRWSlBlN2NUL0dJRW9mdFNadDJLL2dVb2crN0FOckhwUUd0?=
 =?utf-8?B?bEttUnlYalRqaGVINTJaVkt5dGg3S04weElZUFFlZUZOc0IwYjVWaU1UaEt0?=
 =?utf-8?B?dTZJZnJITWhsdGxpVmpjTlI1TGx1MllPVUlHM0NSYlowSHdCd2g4THd1VDhD?=
 =?utf-8?B?LzRsb1NoR2xEWEtlL1pFcGVMM0xVOTRkdndnYTBka3EzcUZuaXJBUUNjaVBy?=
 =?utf-8?B?MTg1ejgrT2FnZm9zN29HVitmdjFORjRxZzdXVHAzZGlFaFlkTXBVaE15U1JF?=
 =?utf-8?B?bGxKODJoUUtOUTJZdlF5VEpIbUpsTG85dWtQQWhkR3ZFdm1vT3orVGR1QitH?=
 =?utf-8?B?Rk4zTmRSOSsySmtEZDh2QzRnNkNxTFlkdUNrT2ljUmladDB3Wi9QR2hVcFJO?=
 =?utf-8?B?K1ZkV1p3ZlcvNDlvWXVhaGxoUWhxejhGZlByVW9ianB1SXN5dlBtNXV3NXAv?=
 =?utf-8?B?WnovU1MzanpvVVUwenRUdVBVSnhDdTVZS09KV3FUMXU0RUM4QmliSXI1clU4?=
 =?utf-8?B?aGVHNUR3QmJoVENybXA5eTVkVlVVKzFORlovdWNLN2tIaUVHTWFEQ2IyK2NX?=
 =?utf-8?B?WmRyTVlmSkVNS2tyOHRVNFdxbGdORzJaVWMyU2RCK2VEbTJJdjZHTUxrZ0k5?=
 =?utf-8?B?bUFqRG1LUVg0a0M1QTB3WUNURkNjMHlObmw4UWFVTG54a1NEMEJzVzczb0xW?=
 =?utf-8?B?bDd4Ny8xV1I5MmtFcU1JNElmcTN0aE5GTHhaU21IZk5xZkd0VXlQZ1dSQlpv?=
 =?utf-8?B?VlJ4WXpzZ0xOY25NdGl3RHQ4cXhOQ1AzbHY2SWNPZ25tU1VtazdZRVpqMDAy?=
 =?utf-8?B?MnB6YVZ5d2FzdmxENUc4VnZndEsrZ3dHUWFpU0xGYUFwaktJRHQ2WU9qSHk4?=
 =?utf-8?B?R3hvZk9reFhRb3R4aU54OFRDbEdxWXppVSttOFdydHgrdUZIbnFuNC9QSE1I?=
 =?utf-8?B?RU1heklqTVJ3RlR0OFBpUWRKTDhsaitpaG51a2MvcFpCTlhidTRwQT09?=
X-Exchange-RoutingPolicyChecked:
	lYETDFgeG/uc4Wr+OiDewJbbviLFFPXGxzH6k4HUa+F2XC2Akorr2rFXMKrL/JLTkJ+NE8xrJGsKnwddlOfZDGKAAHhF/2kxknWviruVoe9bo4ybPTH8SL8xic+xcA+PaGQJOkZ1Iw62zAYR58ZH7nfMz+MPIa1jbVPmwaWgz2ZboxNGAje1LufjRoyamvrNynhpHAGwY359a/a3KESPdP6EAAh4R4Q8+PGgpITnHUxSJ0sxV8aMIkkgc8nTiARVzNv9/44CaH/Dp63L2WGuLt3Z24x7AG6aeV+FzTvUP2EI6ZwBEPDSiaCjmXcBd8s2qSKt/PfEbiWmpq3zSAkT9A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea7daed-0ffa-4462-9829-08df17cd953f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:46:25.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb5B4iV135lXOzzTI0/1l7KVhO3M6Ccccd3hYt/etsfsWqjzDajsWBl0n18dWUiYDV7y82LSiqZnwmBOAdDB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9443
X-Proofpoint-GUID: AMv8OGi7lRRFd3VPvMyQiKGegiOIUNGR
X-Authority-Analysis: v=2.4 cv=WLrqzXsR c=1 sm=1 tr=0 ts=6ab10b04 cx=c_pps
 a=s8W5O/SPP/itI6RUWNtt8g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=gLIKHLzNw2RV7LWUXAsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1MyBTYWx0ZWRfX1kNalmeokIWW
 8y5CYLITSowDsqV71f625c1n/aRFxH2laNzqD4T0oFeioXBMCnUjJVTxjljgSzqE8C9o02NMEV2
 rtdL8SKmUOlEDpleG6wHwL5bDHN1F0McdGSiI8ohamP+3Ke4vx7+0VUalHffGpMYmMpoD/aEuXY
 d5t7MLx4NBZ+jovU4pW7G5TLASzGU5iIbt1kclVv5UOOGko+QhcSEBxVh1C6Om5iyy5WtBsThIX
 bt6VCHmLh+o+afqRw6z0zXVg/hRB5jLWuQhOao0RF2zd+ut3M5PMc+SxdqE/OHhPj7+nDm/Rw05
 LkVwFOcyF3VrhJ8qTBLN33kU68o4e2CxJi6/ejOsEANQCftl9Rk1/rz0gsr5R6qd1hfRjOj8IiV
 k0an/69F99NeyNiEB90yXeeYogy9Yw2bmHFDGNP7GOmUkD2YENEvl6Ruz/nqIED26M+CapVxn4d
 UlP0m/78Mnp4/SL1CDw==
X-Proofpoint-ORIG-GUID: AMv8OGi7lRRFd3VPvMyQiKGegiOIUNGR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1MyBTYWx0ZWRfX1ofNwzUkmOw8
 iOnnsXPI/LZH8JO5GtoeDYCRkNm4h1StE4vCzJ6sYaXqC1AVf8v3u9u86AC+yCFhDJIBH0T6PBn
 nQ0Tz12jAfQy1h1d7qaFY8uIfDAeZ629haPAbZhjIIp1woSLwawe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210153



On 9/20/26 14:34, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch enables `dev->lltx = true` for both IPv4 ERSPAN
>    (`erspan_tunnel_init()`, net/ipv4/ip_gre.c:1371) and IPv6 ERSPAN…
> 
> --
> 
> net: erspan: set lltx to avoid sch_direct_xmit deadlock
> 
> This sets dev->lltx = true for the IPv4 and IPv6 ERSPAN tunnel devices so
> that HARD_TX_LOCK() skips the txq _xmit_lock, avoiding the nested
> _xmit_lock acquisition when erspan_xmit() re-enters the stack through the
> underlay device.  The change is tagged for stable with Fixes tags pointing
> at 84e54fe0a5ea and 5a963eb61b7c.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> 
>> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
>> index 82309efd417e0..0058cb20e36a1 100644
>> --- a/net/ipv4/ip_gre.c
>> +++ b/net/ipv4/ip_gre.c
>> @@ -1367,6 +1367,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>>        dev->features           |= GRE_FEATURES;
>>        dev->hw_features        |= GRE_FEATURES;
>>        dev->priv_flags         |= IFF_LIVE_ADDR_CHANGE;
>> +     /* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
>> +     dev->lltx = true;
>>        netif_keep_dst(dev);
>>
>>        return ip_tunnel_init(dev);
> 
> [Severity: Medium]
> The commit message justifies the change with:
> 
>    "This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>     atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
>     o_flags is no longer modified in the xmit path since commit 9958e69b9893"
> 
> That statement holds in this tree, but the patch also carries Cc:
> stable@vger.kernel.org with Fixes tags on 84e54fe0a5ea and 5a963eb61b7c.
> Commit 9958e69b9893 ("gre: fix ERSPAN o_flags race/corruption in xmit and
> fill_info") has neither a Fixes tag nor Cc: stable, so it is not queued for
> any stable tree.
> 
> Both hunks here only touch the *_init() functions, so they apply cleanly to
> any tree that has the dev->lltx bitfield (6.12 and later) even when
> 9958e69b9893 is absent.  In such a tree erspan_xmit() still does the
> read-modify-write on the shared per-tunnel word:
> 
> net/ipv4/ip_gre.c:erspan_xmit() (pre-9958e69b9893) {
>          ...
>          __clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
>          ...
>          __clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
>          __gre_xmit(skb, dev, &tunnel->parms.iph, proto);
>          ...
> }
> 
> Once lltx is set, is anything left serializing two concurrent
> erspan_xmit() calls on the same single-queue device, given that the txq
> _xmit_lock was the only thing keeping those __clear_bit() sequences from
> overlapping?  The same question applies to the race against
> erspan_fill_info(), which in those trees sets IP_TUNNEL_KEY_BIT back into
> tunnel->parms.o_flags under RTNL only.
> 
> If a lost update resurrects IP_TUNNEL_KEY_BIT or IP_TUNNEL_SEQ_BIT, can
> gre_build_header() then emit optional GRE fields that tunnel->tun_hlen
> never accounted for, i.e. exactly the header corruption described in
> 9958e69b9893?
> 
> Would it make sense to name 9958e69b9893 as an explicit stable
> prerequisite in a note below the --- line, or to fold the equivalent
> o_flags localization into this series, so stable maintainers do not apply
> the lltx change on its own?
> 
Okay, I will add the prerequisite in v5.
