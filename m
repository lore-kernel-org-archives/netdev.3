Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0139A05E;
	Mon, 20 Jul 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543554; cv=fail; b=LBp09kEp0nwbHLnUbCSAFPH5Ddr6Mjpyvq3goR11dGjZ8+VKCay5AyzqxCgUuEGZGk4Xdmx9qzluPVVq7182wQJ+SznTNZ1t2ct841xHjqj/nk2wEwCCytkTrIlUfi6X3U4rGRBCa3vGIZWXV61HXRj94HGc3KUmOkfZ8k9UZW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543554; c=relaxed/simple;
	bh=wwTLHGb/rHujHt3JCBo43ObrvheeXMIYyScndFebzKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/b1W0Sj/0KOJ6OQ6hIwZDcPkB7xsy6s3IDytHXn8I5rkKdIQc8c8cfhEiTffvNssCbapV+6jGhjzbjvy73aX89f+Ncow4sN6MYcEIClncz38gY5+XIy9uIEQROCPvOMsmRhiDYM9n/V+MoE5T6ut765OEtMSBCYqFVEiUX91oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=slBidgpQ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="slBidgpQ"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9xO5j3931640;
	Mon, 20 Jul 2026 03:32:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=N7UawsaKzILPE3Ce9x1Y6c7STsuCK2fNH8OJnP7gRvM=; b=
	slBidgpQYffDB13Q1wQXb5Gxc/gCP0kpWfomBOAZUmQfxAS433k0awgV/Dh6Oa4E
	j8kDDTG+VJhNQoC7KW30nznJx5Ve6Eq4uUTXJ/1nTG4+c3Ho9uyWN85ZMf9KDQOK
	IFuQF+igfnAXsjwRJeS8MuxBOzE0wGzkFaS7QkLzqEiaQTRPukvVykdpVrTBJ8Md
	G42BR5booobgWR33iWkKplwxj+7McMebA/+GfDgRYnaV3ZLs4s194Q0TOwdrybyk
	lmmNgkmHA9YrZ+M2aSNdF5P6c7A7WEuEWVcLdxDVfzkDOW6P/nrGs0KiraCO3fDQ
	Y9DjCktI0h+D++Gm9HU4AQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg90cstu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 03:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEgNBbnOGSiEeZkL5Fq5fRJTmlGJkgvQYobSVYulR0pbGsFUikbXEiyP0L6rOtz0RrubsiuvC7CcSdtt2/3d8iJtuH9tJlW7za+HDPh+j3j6be9MKj8Vhxxos72wy2AFvGa5Y0WzWNuz3cOIhKuKQ5zXHR9ws6bXbG5gHCLAcBsLTre/spSZg7i547D4UpqWE9NNimaSRXE+7kxl4bp3LzoMyZBGX15IFdyrscanzQHOUMbMjVU3B9oz/DLgknzucfHRbNq0ZHnDGvH/mxyLIvLktfyfuXarA3viF+wZgdMwXu87ljLLRMa4BBbf3LgYyt3IxqBrM17/oejq2MdxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7UawsaKzILPE3Ce9x1Y6c7STsuCK2fNH8OJnP7gRvM=;
 b=d2E/auQmAgKsAz2JSPKXsapEXH1WGzGwZmUB73Loq1swyJoR836sxb3S5+N1H1pTq/X6BcezTK1IrZJH2f0d1RaFXmSmY0sdvOcf+1lIVAw9Nfyo1gc6YUhnbz+f/IW7rgFU0gmqOEkxBjh0AtISbkjw1ULI7ghTu9AKXfKXJjVxy3c6CxSDpTQ0QGlu1u5HLgXYv5HqOOs8XIujBFMg8PTgVX5gyQufKBBQwlQh84iGT6w7WamLljcUwI6vdUugoub1omn/vDCpejE/+3ZhJhKtR9/7n3Qs1TQsHM+sFOJz4L+YzDUyCtx9SH9XWKGVGdRP8qz8EYdj/0vDNioTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5333.namprd11.prod.outlook.com (2603:10b6:208:309::23)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:32:14 +0000
Received: from BL1PR11MB5333.namprd11.prod.outlook.com
 ([fe80::f5ec:bde8:d36f:ff]) by BL1PR11MB5333.namprd11.prod.outlook.com
 ([fe80::f5ec:bde8:d36f:ff%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:32:14 +0000
Message-ID: <a2e6de79-6210-47a9-ba7c-d3f09b123221@windriver.com>
Date: Mon, 20 Jul 2026 18:32:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
To: Ido Schimmel <idosch@nvidia.com>, edumazet@google.com
Cc: dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260713151435.1815104-1-yun.zhou@windriver.com>
 <20260720075352.GA2233846@shredder>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260720075352.GA2233846@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0171.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::17) To BL1PR11MB5333.namprd11.prod.outlook.com
 (2603:10b6:208:309::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5333:EE_|CY5PR11MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d689a9a-28f9-4c39-faaf-08dee64a29ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	TYrZf+61SP+HOTqt/WD4oGJ4NaiLP+Tn93R6VKUACTZBAFFIpW8G21oXK3xu7nMsvP5n3RRsqgm+42BVYWUZ94hS7YKLblhpIwTezF2togqpX/4XGVPbd4Lc4VarZ/nRHWpYc6zW8MmpM/duyuxI0zz1pVBV50PNVvYyaKyOOI6zD46jeETmW+CNTQMaV29ZbylzDi5V8K1rh52rI6flkRc3X/Fj+o+xcgW9UHYGVYFlomFKBRYS+7wvnqj2f9+0wG7JBZCpBlPn95WNyce7pl4gpGKtAwoEu6Fm25LbelgPde7GyI+htkVvPcY8tW237n5Fkzccm5i6a+WeiqiIG4FaEHRiJHD8dePIY44k0kE8PWA7daZ7+boqdbA4PQd0gTths0eCKZ5jTT1A9lhI2JhI8dQ2RGdc14fSP3avc5FjmjEN1sbnzQk9WkeSe3c2yb5iI22APECHXD3trsQzYuVt65rC7f4AmQUsIq0TQ7Ho2+7K7hWfSIECX4bZ1sdmUNXpw4Ib1BajmSJATj3ucsK3L2DL/7ql3LtsLazBZW+90cxGw9BVcjG7pAc/Dgp5lnfjTINT2aVpta60pZqfNh7kQuu57wZWxOKijr31/g6JVPUDGDPknIViC79JCeaoaAiNu+EwYZ9RqFItNqslAJ6PC73w3j0sSFouN6wDKZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5333.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXI3ZUVsazhqcFQ5RCtrVVRFMUNaNUFUSUs2Yk9TRkF1NWxES0Frc0NudFB1?=
 =?utf-8?B?ZVY3OU5EVHMyT3k0dysyOHJ0Zko1Rk44SGxmSlNTWUNyWDgzbi9RdVhub3NQ?=
 =?utf-8?B?RUJRemxJRkU0MTBPQ29qZWlMa3ZhYjZQTXZrNGYxOC9odWREUHVla0daWjlU?=
 =?utf-8?B?RnFJVndza2JLc0w4Z29sUkhXT2RmQ2l3RmRwSzlYSTdDRGc0S3ZXeEhxcDR3?=
 =?utf-8?B?NDZuZmJCd2JxaUYrbGRMbGw4NE5rNmVtNWxUei9DaGJBdHNvSWRLOEViaExL?=
 =?utf-8?B?VHNCOExJR3pKUWlBRG04WW5yOURRT3hIYnlqWGFoNHJ1ZUpRTk13ZHh4QjNt?=
 =?utf-8?B?dTdIbXVtNmpHN0RPSS8zVjVPL2VsTnRqS2dDOTFYbGdESDFIdGFnZGtJRnkv?=
 =?utf-8?B?S0tiTTVWcHp5R1d5ZStBb3E3RHp0L2dOb3VyTmVTeWZ6M1VTajZuamZES3l1?=
 =?utf-8?B?ZVQxaFVLa0xZQVZuMWVLS0pXZ2ZVZ0Q3ejkyZ051ODc1SmZnTjZFNFE2d1Mv?=
 =?utf-8?B?TDNvbmRhQ1dEdUF5U1VxZnZCUTJlKy9IeVNiL0dQQkVlZjBhcGprUkN2RE5Z?=
 =?utf-8?B?MUNVMGZvdEh0cmlUNWVraEFMbWFZVTQ2VnJJRlhzWkdhZS9JU1hVSEFNc1ZJ?=
 =?utf-8?B?SWVlWWQ2V1RxV2VpN0U5MDJsQm00NlhoQnBPaXIrZlZYTFh5K250NzR4c1pH?=
 =?utf-8?B?SWFENGg1QlBXcnRka3RjaTVZZ2pzWVduM1JYTjRIV0JmWm80LzgzbnhzZkVR?=
 =?utf-8?B?MjFNVEFLOHQzclc4d2MwMTFMUnNkcHJWSWs3NlRMWEJ3bmhKYTU3Vy9CTlQw?=
 =?utf-8?B?Q1p5amtnNk1lQ3ROU2lNVzZYZ1RQc0U2QzZBS3JJTU9KcFV0bi93ZWhuYjZi?=
 =?utf-8?B?RDdWc01iZTBzRW1vSHRteGM1dE8vRzBzNEo1dXA1eER4TkhRcDVqRUJxWGpV?=
 =?utf-8?B?VDJHRU8wSGdoQjlUdEZPNmFTb3psaHJPeFVWR2xuNFd4anBFOGFvMnBCR05O?=
 =?utf-8?B?eStHZUkzNm53Q04weDBnRDJUUytsZSt6TkZSa3FzOStUeE83d3FSRlNmWDBs?=
 =?utf-8?B?VjBUNXpYaHdaS0N6QzhEUGUyTzJoSjFMK05wdDBIOEtqVTBvakhNVWJKWGlY?=
 =?utf-8?B?eS8yZ2Y4UHFNT3AwRWZUandDR2YyY1pHWFRBQm45Tk1nQmtsZEkrN29ZWDNs?=
 =?utf-8?B?QlRhTmhUdjZ5b2RDWlFGaFdhVjUrbUNPeWR6SVNWc2NOQ3BzMHRpTC9WWm54?=
 =?utf-8?B?MDI2L0EzVHBWSmpNK3V0K1RmaUZGaVBxQXlnTGR2RkFQbVp3WklaZUJTV0Yy?=
 =?utf-8?B?SnM5QUt0SENIZmwwTVJYMUFvZHBtczBPMlJPSTdUSHZTTlFwMmFMc1ZZcHhP?=
 =?utf-8?B?RUcvd2ErdGFwdFpnQzQ2VmQxb05iMjgwaG9lVTJiSk1YZ3lvK0xpd1ZCZFd2?=
 =?utf-8?B?YkhYUUZienNhcXE1aE9iQWZEL0RTVEh3UDdLQWhrVTFwQk1mY3hJMFZEUDZJ?=
 =?utf-8?B?aCtacUpwZUZRTDBTOEU0ZHhweUtFU0JXRDdZSTNOckJ6UmFQWHdQVUUrT24v?=
 =?utf-8?B?WCt4YW52OGxaTW16WEUwdTJTOHY3TloyU2NMeEhIV2RaRjZkNFBZaFEwUUhC?=
 =?utf-8?B?RzA2NmVJSG1pYVNVVFFuVitzUk5vWnBnQ0gyNkZwdVVYUWFSSldoWmRBZGwy?=
 =?utf-8?B?YS8ya0Q1K2dKR3ptMXJuMDZxcjBTN0l1YisvbGNYSUYyazA4SGR6dDk1cjVw?=
 =?utf-8?B?ZURnb2tzMUpPcGxKTEpnZ1FsYndlSlE5aVZvNVY3WGo5V2F4em1XQWpKMWh6?=
 =?utf-8?B?dEg4YjRBSDRmQTZIaG8ySUhMZTVZdUJQc2hJT3FucVZUNzhkaE9OZWcyRWY5?=
 =?utf-8?B?VjJsMFcvbVFWTnF4ZE5qZ2p5WjRqTmVrdEtiblM2RTNwZXVoU0FGWVFXQVB4?=
 =?utf-8?B?R21JZVRJVk4xU2lqcUtObDU0N1JuUzRXcDhlQlFQM0dINFpHQmZ2bTlQenB5?=
 =?utf-8?B?Yk1tK0hCTEh2cllCUHE4ekRsL2ROSEZRZ0ZBNmhOM210a1UyMlFzZGw3cFc4?=
 =?utf-8?B?cm5HU25GUWNhdGx1SHY5cVJQYkV4d0lESDdsRmpWZmh4WGp6M0dJTTlyYWlz?=
 =?utf-8?B?SXNBKzBoMGk2ODRQSUVhWkxVMDJ6WngwemhpUWNnNTIveHZDN2xVZHFKU1pv?=
 =?utf-8?B?Y3FkaVVqWHV0WmhwRnJlWmNzb0NnSnNJeXVaYm43S3dEZHpnOCtrYlViSm5T?=
 =?utf-8?B?Y3ppR1dUdkZRRTNmQ0lQMmFMTE9LWnNOeEtMRGxFeE45dkFhWHRoaE1lNlhC?=
 =?utf-8?B?b3lhNmJwWnJqTjRwYnlZaTFqZVg0SW1MNEtrVnVlWmdMQ3ZxNGZidz09?=
X-Exchange-RoutingPolicyChecked:
	oKktTmtDiETQ/6BTa9W1Bjx+MZlj+B5UrCCwnccXV2Y4zosG1rTQBbeMkOY9DJd1CYvs5igtKs9TBzBkfeMF85Lggv1pbNfRA5FGqzs4Ph98cDOt4v5fMlKe3l5obZeEcCEhLPBmE6cZBhWftOfbgQ5afsD2Cpcu/M9xAjkVcRQpRTf/VhratPrAP0Xsqbawr/4fWlqMr2LQl63+z7Lcv1lIl53qzHYqhEWvHbCIV1eQ1vnXzXaN/JmM9AlNvihNqydLRFfGhcMyr1ukDI4G//pVOuDT8IyI+Ql6Sj1rzwTA3QyMGFiXtCYGNDGks8P1j1k0z32OKzWaJwRc3D5jig==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d689a9a-28f9-4c39-faaf-08dee64a29ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5333.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:32:14.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 289pgvc7yrlsfAFkugllemlVA7vjqD7wW4R1cYJF6dEWuYy8jk1ZuUcqZ79ex+w3VqJuT7Fj9iaTCOQlV3Mbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-Proofpoint-ORIG-GUID: N1LEBYPVUsUgMlmohcjT-h1sPQIrFtgZ
X-Proofpoint-GUID: N1LEBYPVUsUgMlmohcjT-h1sPQIrFtgZ
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a5df930 cx=c_pps
 a=BP8zQLqIaVEyLeHVCiSdtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=QF2OPKz8kxyVU141xs8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNyBTYWx0ZWRfX5pQVwugI1skE
 EaIv31g0yYs6PlDxftQRyDWy+V9TyqdURE/IM+iuhTcaRETwJUJTO1WkE/s6Cwylb9PcWrIhQND
 cG9hV3ylW9zfO747hlaROM6j1hk1xC66TJNcD5niMBc+XzuXzKwE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNyBTYWx0ZWRfXxaQgAixsa08Y
 B3Vt6gyfAtTMDa6B2af8M0Qyn/jzn7eB9O97PjFeu08Bob4xTUab9gCnPbgwFc+6TefzlUrRy+2
 kEZqS02m2vvrwejuxoDw7lnm2UyLQThFiWjdCaNkMVaMjRSun6394m5ZbBxEr70Y0gWS2CUSAHa
 RLVyf6FcLzfwchYY5gaxE8PD/e33lLpuhA/vEzcuDGkcXwYh8JuD8U1IP8Bop7gtUm9uXA8gN0R
 0/3de5Lw/hiNPPPiBiWtzLFFZf6WsVrIpuxCAcLt8riDuudeGLuYezyJDYaKi4HeEotNgkQTh1Y
 8Hd8YBHtXxjy1fNBlQmItvBJmEAoVbLTxcPZpIAod6kNQXScV8rggAGlPdgsB1fjOnTA+wdNl+P
 lUz83s/ll2bR+sgIiasW3htdFkjuqja0YWzYqRYbAsJgXPzBC5+b0L/Q/9W73WsYD9fMSTd0zIv
 hOcAwmQWPVF7PdMpUgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200117



On 7/20/26 15:53, Ido Schimmel wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Mon, Jul 13, 2026 at 11:14:35PM +0800, Yun Zhou wrote:
>> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
>> nested acquisition of _xmit_lock on the underlay device while already
>> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
>> the same lockdep class, creating an ABBA deadlock:
>>
>>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
>>
>> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
>> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
>> the sibling device with identical xmit structure, already sets lltx.
> 
> erspan_xmit() (unlike gre_tap_xmit()) is performing non-atomic
> __clear_bit() on shared tunnel flags and KCSAN will probably flag it.
> 
> Eric had a patch [1] that changes erspan_xmit() to use a private copy of
> these flags. I think it's better to wait for Eric's patch to be merged
> before setting lltx.
> 
> Eric, can you please submit v2 of your patch to net?
> 
> Also, doesn't ip6erspan suffer from the same problem? Please try to
> reproduce and fix.
> 

The following command sequence can reproduce the problem:

ip link set lo up

ip addr add fd00:a::1/128 dev lo
ip addr add fd00:b::1/128 dev lo

ip link add ip6erspan_dev type ip6erspan \
     local fd00:a::1 remote fd00:a::2 \
     seq key 1 erspan_ver 1 erspan 1
ip link set ip6erspan_dev up

ip link add ip6gretap_dev type ip6gretap \
     local fd00:b::1 remote fd00:b::2 seq
ip link set ip6gretap_dev up

ip -6 route add fd00:a::2/128 dev ip6gretap_dev
ip -6 route add fd00:b::2/128 dev ip6erspan_dev

ip -6 neigh add fd00:a::2 lladdr 00:11:22:33:44:55 dev ip6gretap_dev
ip -6 neigh add fd00:b::2 lladdr 00:11:22:33:44:66 dev ip6erspan_dev
