Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9A13D886;
	Sun, 20 Sep 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872559; cv=fail; b=LkmctwiWzwRb475JN3mbOvdVw7HN8VaRUo6zFu7IL86wilAZL9LxAQKoQm3+g6sL78L44wzzyKDwfoGnWDywtndJPj0LccvJ2RJ5gec38nHe/o+P+sa4WPtN/qhHYFwrCOSd1CyjdBs29HzQmH0AL6oh6fhGtBwRZ61NP96059Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872559; c=relaxed/simple;
	bh=9Hc6K7YkLU1XLiXO+mfjCOtFIjYXgYuhMoYmRhYkVw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u39cAjFb5WJxk7hXZXhmNgFtjuhnrDRMgZ8BXGCwIph9DDUvYa3tuQZqJd1C7C//b9NNkrZrJ69bXDYnhbt9reXNz2UlRmdpv8ixhEfL7OUzGvVGJ5DX3/uLYfZ7cqmsP0q7ZCM4/IImF9ZnhiCoa4bCeyw/yplm7fD01V2UCsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=bcKK1tFT; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="bcKK1tFT"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K2RZsj2358225;
	Sat, 19 Sep 2026 19:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QX7GFzDBFVF1hZmDBJHyKW7/LWo3fOynL05Iu4kJHLk=; b=
	bcKK1tFTqsRI1qf9mhe54PjXHPTJS0x/sLVZaIntKA+OIz21B+jGIn5OF8wUm75f
	vrp4LaGbq/7QIt3FlI5iJZnNAfolaEcl+H6QfhcmYNRttvOKlC4lYYYc+2gYLTaL
	6Abadv901smdPJ6+P9AVfCIiUYy6ZPtZCbwpP/vCDbtCoSmwa8gQfPu+Nc96APcJ
	QRmC2Rkr0ravkfwBvcxKhtXCRP/rZQGOG6dyrLnet32AQvpPvmTn/LuS2lFHOmiW
	7wA3ERORQff+/G0ZNpJAgfWkZRD/13bwC4sTWJzjO8RcJX7+WzWrLs01/e9QSMPc
	+rDMhls7fNDx4XxDbciVtw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020090.outbound.protection.outlook.com [40.93.198.90])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gsswe0m0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 19:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwf3uextZxh4YauT/mXDvyGuH374jPfk5r4FAUJiJzvoHJ86Bcee7G1dX4lnmgyI6CHpEOHcDcRrcak6kEHML7Tlnu38dn9PjfoQ0b66vCRnkVTOw2+522GCbg0VLfdc+YvE/nOsznN0tJSJZxsXECuMXb4knHCd0Vi8qjIQZcakNL0OlawPEFxMkvAWW2/ajUDt+z96Yg4B3fBDrQX5p7WWr3O2KqGq17C2H31HkMpD3uvhpMAFcBPI72eA/7ZAmBzXJJtErwHiiMWBpFfPzhRyzrTlyAOSN+JhoJ32cZ32iRkSXJY9hBEO1C0kDYZ1CwNJJ1vYqpnYiIG4quRT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX7GFzDBFVF1hZmDBJHyKW7/LWo3fOynL05Iu4kJHLk=;
 b=o41ELhZATdT+N1SPQc9rRGn4rJxIMxeWvkp+bAdMA/DL9rd8oF46u/2Z5U/RYLIFC+E/QdQKgYXt/Si7mWHGQeurmGHJGaufsdtokPRmO9WnbnMbujtH6fqopA/KmQ0SuRd9bxm2zxWioQzvTZkhjM+RspC1IJczHz41YequQRL8ixUiIEvVA9lgpvSMj7BzlJ9XH16oGSGJr1dJ6WZMeOVFJ0YVLWgepz4+6RtAKbh0l2qrACilXSmEYRB00f6Iky68PoOzQ6ti0GwWIQtEWFDoN/3c5jkCax3Eld+AAOfCsIyKIkr1426Pdmt2bbZro5zxf21xwd/ySHAhddchdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Sun, 20 Sep 2026 02:48:52 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 02:48:51 +0000
Message-ID: <c51150c8-85dd-43cd-a615-65cd45b3affd@windriver.com>
Date: Sun, 20 Sep 2026 10:48:42 +0800
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916061314.936440-1-yun.zhou@windriver.com>
 <20260916082028.GA879236@shredder>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260916082028.GA879236@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: c37d3539-b8a9-4ba7-12b3-08df16c1b322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NbEsosKN1rHi+3pD9T6c4s6z92NRwA+YUsJiNnCmbbwbXrdciMmyj5HemVUDyP+TzG0PFfQo5zsu2h739vIHBpVGrVs0Yp2gctZmte2RSbscmhDqY8c/urW1chY3WV9Mifpn8Nxiigio6dKWpEcCb1XuFDwNv5iPmbnVNd3tUZSfZ2775KtyBwXmFNLleYfzZlCkr+zAEeQ+06W0MMf34QXK6goV45jZJMrK4t+Px1MyK5vMijOLDzRy/uuT0Rzcpx98N3eR6JWbihl+sxymiwB8yPsvhLwCnTRFIDayy9TNhLoXrmt4XEGKKfZIKSl/xieWuxwLltlsyIK6FcPZe/0mQH8JPZNidcna5HGZqUoE9ugVyonelx7YYbLmZN01Ro8UgtY9bAZxK0SBoijwZjmTLzMdAMMl+afiftDy4xXcKZUuhIHwUeLTkBGkgAHB58GqKh9chHmmDW0O0Hn3uto4gOREYKLCAfyCPd5lrlNPdsw/j4J2zhxV0rKfUCG4S+Nt7PlhUAp8sqD+bL+hIUGiGm4sTDLuHX2FAxDzfQ4+gChqtFFHpj0RYx8DT+h72/3oc9AGdWKoEmMzROgWJXr3vp1ypIkokyNNejF4ccLpJXATC0Jxap+SyUjpL7xz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bktZTDBibHBWYTBucFI2aVBEYUcxTnhlbU5KWFU4WCs1ck92Z3R6NFIydXFK?=
 =?utf-8?B?SWplRE1DR0dkVWs5MmQySWFSaUtxeHhYQStWWElscUp1QUtxVEZIWTFzMi9L?=
 =?utf-8?B?eTh6YzMwVWtUTzNLNnFpQlIxT25PWjl3YWtZMzAyT1h0N2hVVXdjaXJJSjhm?=
 =?utf-8?B?bXJwbytadU8yZUl2QUE1c1NrYUpOdlpSd0V6ZzVwUUZycVcwbnRodkR1Z1VQ?=
 =?utf-8?B?WlEwVkQzbVhFVlVuWWZLZWgyMzNySnJFeXYxbWRlbUFRc2Y1SDJ1NFdjcEJr?=
 =?utf-8?B?cHN5K2szSFp6RnpQcnBwYk0xRkxkb1UzaUZrbmxlTUNCUXN6TG55U1hjYWlM?=
 =?utf-8?B?Ky9tWlhKb3BXNExJbXhEUXZ2YWI0eDJGQ3ZkR3RRcFo3b2c5bmczVHJDZEFs?=
 =?utf-8?B?cXBZWXN5ek9KTk1aeFdUQngvN2hqOGhQY0hkTGNPemoyMmUyR2FJbEhjbVFt?=
 =?utf-8?B?cVRrbzY4eHdaNzNWeG1HN0VuUzdmRmh6Z3lqT0M2VHN1SjlYRmFzczNlTjlo?=
 =?utf-8?B?cFB2V3VTU25NUzZDZDZrNzQvTlJ2SGhkeU80NmpJNUpkSnd3bDhES204cTZx?=
 =?utf-8?B?dlpVdnZyYTRZNC9LWnFPczk2dnFDQ3VzVndqMWF5VEkxN3FoQUdzT21kK2NE?=
 =?utf-8?B?NXhQNkMvRXM2dmpncjVHOHNmRmVUamNjS1JreDdlTTZ0c2FtUzE0c25vWm9p?=
 =?utf-8?B?dXo1b2M2M3hzUkIyQWQ2RnJ2Q2lBL3JJYW1lYlFwZDJCRU5kTjBHNjgwM29V?=
 =?utf-8?B?S0h0bXE5SDlwTU5kZHR2SFUvVFU1VWNrZExveXBGMHJiTWZza1FUYjZFKzBk?=
 =?utf-8?B?Y2xJUUgxZVVWOVhOaU5YV0FBcmN5K2VzMVNMMUVZb0V3eUdrUEFuL2hZZjFX?=
 =?utf-8?B?NDBpbCtnajlHaFFidnZDSTh4S0I3OE13ZEtkVm9wT01UZGltajBFZk4yWVlh?=
 =?utf-8?B?Mlk4YkhsenZ3dzZEaTlVc25TT2hwa3YxVmpVYWRjVllsMXNTbGJCRHVnT0lK?=
 =?utf-8?B?K0tLeEtOM01tcFk4SERtNElnWDNzTStrR1pta3Ezcnh3YzBtbDJUcWxuSWNz?=
 =?utf-8?B?TGhUL2lRRzF4UDFzSWZybGh0VVNuUHlDcVYyWG5kanNIKytJTHRlQmE3ZFlL?=
 =?utf-8?B?bjYzWlcvMFhPWnI5MnZ1OW9vbTNUZXRBakl6SUpsbXlkSEhGQ0lEOGFEcE1L?=
 =?utf-8?B?UVRNMFRPTHFLcCtrSXJ5TnJoMDlURTNWZG04YThTU1BWVGRMK0h1SmQyVWlk?=
 =?utf-8?B?ajhHVW1PbUIyZUdvQW5SbG55SzErOGJGbG91Z1I4Y3hwaVI3WitHZ3dyOTln?=
 =?utf-8?B?Z3VWUUNWeFQyMzlJMDMxaHFtbjE4M3lTUXdhMStFdmk2ZGZGd0gxaVU3M2VF?=
 =?utf-8?B?dGNpUUtpQm5PcThuV3NJWE5WSkNMVE5SV3FyZC95S1lhbGNvZXp2aGs5NVJ4?=
 =?utf-8?B?aHAzSmFiNzBaT0pmWm1wbUxDZGd6Q0prdHNNb2VQQzVGLzZId0ZGRGpTUFdu?=
 =?utf-8?B?RkxxbHhvenBoS3VnZlRsdXBlbVNEMm91Ky9kcWRoblYyVkpnVzdWRWhKUStr?=
 =?utf-8?B?RnI1NHdYaWQzSHd3ZU1CWW9CeG5mUUFRMER2Q3ltSW5waFY4bjVVSmhzbFNM?=
 =?utf-8?B?V3h3dkYzM3lpYklSZFBHd2Y0TnRRcERYaVFqUVd5UGVXNURuWHgvb0ZjUXBS?=
 =?utf-8?B?UDE3UFdiRzhvdDhmNmNXYURnTlhKM2MzOWltdXR0bm8vVkNIYTJzMmpqZ0Vv?=
 =?utf-8?B?WkpwR29SMG1lLy94Z2IrZkdyZHFST21IZDRrVzRaVjJDMWg0WmlkT3BzU1k2?=
 =?utf-8?B?S3RtMDBCYWlWaWk0M2JKV0tVU0ZNc3loNVI4cXdkMnpZNmZOWSszNDBoekFM?=
 =?utf-8?B?cVFVeFdtcXZqMmlWWjFsR0l5V2tqV3liM0s2cGk0NXo2RVh1VVUyajcvSWND?=
 =?utf-8?B?UmlDUWc4NWZGMEhBU1g0cm9qeFRxWVhJSmtMUnpTRG40S1V1ampsN2lIcklZ?=
 =?utf-8?B?Wm1KZnZzc0k4UFU0djlsdCtybW50amp3NWVDQVh6eEszWkhGK2QvYUIyTzVG?=
 =?utf-8?B?eUpudXdORExXaDM4L2hVU3RXSWVzT1R1bW1BazJGcFhHUWNjcWdtMjNINVdX?=
 =?utf-8?B?YStiWmlrL1ZRRVB0Qy92Q0k4TDZoNm9KMzZjelBQUWVKa3poeGJtQ2ZxcU1J?=
 =?utf-8?B?MTNTeEg5VFlwU1Z6U0RNSktkOHcxU2dWeVJLb2ZkYWZWVHRpbm5ZYjRGZzJD?=
 =?utf-8?B?WXV6SVIrRE96dUZlUHdXRW16WldzQk1oZXRZZEJpNGZSOHRycmZDVEcveHJC?=
 =?utf-8?B?YnY5MHRHaUpHOEhoYi84ZkNJU01sMldLdUt1Y0JCRkV0OHZ5K241dz09?=
X-Exchange-RoutingPolicyChecked:
	I1r/Nf0EmCK5esD1yQ6IuFmROeuIb8DfVnNySDWPWoJpeAAcgepvVqI65u/5MhJ7fpi8y2WKnMBdsSjdAi/0dlem6XwQ0A/9H/YHKEzqtgT+fmeQ/dqHFVfktvqNX6oaopkDnIwv4Ys2s5ogVdqW1lKeKzTs+mLS0tpz+uzIgmKSkJpnJSz06vxcFFb0e0SEu+F6dHM/MODAnFEpyi4dvAb4tzAlqJNS3h1mPCKuFP0rWzCqLs+PlsN/SZHMEilJ10I0o1JkeVkoGraAN8rUqzW3tgX7Ss3Xhi2b5gpA+zUzoxV90DUGqxQgzPq3nSE829gW4XQhTILTTWJTaYoOOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37d3539-b8a9-4ba7-12b3-08df16c1b322
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:48:51.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZ6y/xUnvGjrV1syVaZF9WMR5D/Le0wHpqiPq8eRNm508V9C9F8cDEiJfU/udi1DM1ZAjIvk/+yihSCPC0stmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-Proofpoint-GUID: NFJgyFPLJ6uZEPrtQ8qntn4BJFf5Q10F
X-Authority-Analysis: v=2.4 cv=WLrqzXsR c=1 sm=1 tr=0 ts=6aaf4998 cx=c_pps
 a=O2bURPg9OTzncuCi5jyorA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=HJkPzozMfburt-u3MEEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDAzOCBTYWx0ZWRfX33pDWGjXzaBJ
 lMgBs/AhaAVNszfCMa6lUbapCbuj5FyrDsXs3M8qDCPcIub+C+oBRr05p/nboCZJYtQDZgwbOB5
 Q1B1K7rVcOK7IZEZEoiEVqB7mbNKpro9l35BlTnsMhxpaGG7x4qjGQLG56ocYV2CmfHL7eG4XRn
 9JaZtoTl+zIZi3t4vIlXEePqsUSgrL+RtnDYsj1rpsU07NkV2zP1+gj9a8O77uJtxzfLaRCoqy4
 iLxwejlV5sB6CdY3AkMp/mXGI3Rdp8z7cgNRGEYx6Qm0khcmNuMp/drcoOvneTtqMyMWhP+H+6z
 SbhqGUnNEmA50tdhzo90pm3149aEwmoFpnGOJl1wSrcVvCNjh9b2EZcg6oHqxeicZWwPSP5RrVt
 C9HigrWVoHMXzaAFgMD5vP+REoNC+ybugwCmajEfdGZcg68H2yeVojAcRJ2ifKmeS1rPPbf/71F
 kQe+1ayIh1QX1NlT1Pw==
X-Proofpoint-ORIG-GUID: NFJgyFPLJ6uZEPrtQ8qntn4BJFf5Q10F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDAzOCBTYWx0ZWRfX/57qtzPJx9T1
 NQK8dduHQ230BG5I2bBXncXJtSPbUi+jMNgTMRWe4GIgQaYbOg9QnUayru56vEOkNbWVkoQcOv4
 YtHi9FxmnvzFwQx9m0fQNlfeahAeOJiyhlMzROT/CZal97HdGuCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200038

On 9/16/26 16:20, Ido Schimmel wrote:
> On Wed, Sep 16, 2026 at 02:13:14PM +0800, Yun Zhou wrote:
>> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
>> nested acquisition of _xmit_lock on the underlay device while already
>> holding the ERSPAN device's _xmit_lock, creating an ABBA deadlock:
>>
>>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
>>
>> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
>> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>> atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
>> o_flags is no longer modified in the xmit path since commit 9958e69b9893
>> ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
>> GRETAP, the sibling device with identical xmit structure, already sets
>> lltx.
> 
> In v3 I asked that the commit message:
> 
> 1. State that the overlay and underlay devices should be of the same
> type (both erspan or both ip6erspan) for the splat to happen.
> 
The devices do not need to be the same type. The actual syzbot report 
[1] is between IPv4 erspan and vti6 - two completely different tunnel types:

   -> #1: erspan_xmit (net/ipv4/ip_gre.c)   holding &qdisc_xmit_lock_key#2
   -> #0: vti6_tnl_xmit (net/ipv6/ip6_vti.c) holding &qdisc_xmit_lock_key#3

I can reproduce this reliably with erspan <-> vti6 cross-routed in a 
netns (no same-type stacking involved).

Additionally, I think it makes sense to set lltx=true for vti6 as well.

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=15b29287180000

Thanks,
Yun
