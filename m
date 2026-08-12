Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EF32ED4E;
	Wed, 12 Aug 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547820; cv=fail; b=a57E8CP+QiDw+V4pH3FhP/vt0H+d/V8Jg+gMA/qeE9AlYZzv4Nd/SSl+3i53Sn66PVqbljFAe/alZzQWXlj1CuNDEoDi8MHZD31oXpUvEaFPOwFX4Biaa4Cpdzti4U4jwqUcQ/2Dieasivgk+5dloKlPhFlckv1dC3Bgmz/VAak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547820; c=relaxed/simple;
	bh=pzb64qN2dL2XUpzXe+bQ1Mcgso23ob7zAU9YFLUyRyo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UdbG+K5YsWuecl3svri4l5CBHL1pLhsSVDo4FcXuvW8KEbNdl+yTj4varoHmzd5p56Jz/Sdcc1QMfWzf1Jkkrjiy8XdzfVbW31pGiOI17oVkvmYdq1og8Y1KfzQNYIYsMZ9Ia9FqWtOZV2JdU+rU/hfALdMMU/DdjWAPNE+ox74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Smxz6+tP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g8/pzGeG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Smxz6+tP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g8/pzGeG"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CEorto814194;
	Wed, 12 Aug 2026 15:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zKYKKBipll88HM74igCnYYK2VsLyy0zqm0e/+1bgcIg=; b=
	Smxz6+tPyQDjp62JjWUaJRMcME9kN7c5AfdE8ygWGTjrdZvxfgvFbro7VQAPZURX
	zNOjzkRpFn+wNv/F5jge6dds2g5696xp84BBtrHLiIZJles8uMgEVOY0CrfDe6Bp
	zM17IN6mPS4Xwxaylq/039VIJj2xavuqrxhTWIy3uptg5G3LYDXQCOtreBvGLKWC
	NezMa48xOBOXfXONHUtcN2aa7G4GtJDBBgwHj9UcVAjUkURwEo+2ilh97tM0zN1l
	K8bmF/zrSHMTWnIC6h1HFcDKKoy9DRiPKbXa2RXHxn94LRaIutGcT9rAlKCbICTC
	H0y+QrkVpHNliVMMVEOAmg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fww0sxvjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:16:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFAIgC026653;
	Wed, 12 Aug 2026 15:16:54 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwf0uj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Aug 2026 15:16:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/LlyxhfNtC6FxjChaV/EjgXoza8xnMKBAq90rAJmMlZblPPI8a8uaJwaTAz4g2VMuXeKetxfvkGrwLvAZAaadCAuUpf64TdlZTpCDYfG++dqGPGxWvS/dDEevhkpJYx5z0+tcyC735dRtG0scU5L6sRyLg8YOpWNGq6z0MVKx4gnVhczn/ayI/FzZvxnbcrrxsEex2KF3tHshXbcFkYkHZ6rBzJJFZ+UOJrJBiZLRsMCpaqEZJkHXw5IVtraoymdFBh9xti5XEEJKAL7bSJMdVULJNIw5zM0jp9UTdA63dSIo1qEcF2z7d2b1gDz6AxXuQ+QSfsyaqHPIoc2zdVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKYKKBipll88HM74igCnYYK2VsLyy0zqm0e/+1bgcIg=;
 b=E/uEM9TEyu3+yL4it7fX0+yu+gPy3nO2sTT0NC4urMIKBv+qtxLArhLkUIk7X1DI+RHnPC9gX+jVmW1PRc8cbu+Ne5MR0ayR3EmurCNWt2C4WCD9OCUBAfUTOfKknh0Si3Sg9hY+FEFt7fMuxK4JEJAN+Bf9sha8s8/aPBhzbj65oKD9jLREwGUjE3+/hYk0Y+hGpwbnQZkGtaloiJCI7YnwOSRcOSofjEhiq9jCWKMzARQHavPgsZUPY/7k8vIlwKyN0oj7sR0sw26GwlJ3bQAOnsZ3EAmlBUZOhEyc+OLmr0zPDXfz2TGtLjMNIG1Tj7uydWT48rWb1OVYRwhEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKYKKBipll88HM74igCnYYK2VsLyy0zqm0e/+1bgcIg=;
 b=g8/pzGeGLZz2tyO2fiFGVX4VU1vNw4L5jTrQdxpKCQdCsP/GWnVm8ySdxZjXgA340/Wch4SOaXHeIMz5Aj+Yl9XYUd8wd98puFaBDenD7hNLS7rgTUbwQhOx6XfA0Rs2UYGnHrgeic7AfYiwoU3aJhXKuldZUYtxa9bfipP0ZFw=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 15:16:47 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 15:16:46 +0000
Message-ID: <2a0342c2-4276-4ba0-a921-20c5ea8ef8f4@oracle.com>
Date: Wed, 12 Aug 2026 10:16:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Anand Khoje <anand.a.khoje@oracle.com>,
        Shannon Nelson <snelson@pensando.io>, drivers@pensando.io,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joe Dobosenski <joseph.dobosenski@oracle.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260812115247.308464-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20260812115247.308464-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0055.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::23) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9e90f7-f7db-4e61-bda4-08def884b9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	WBf2YMXJ9ykzjMOqFJd5IRPVDsdIB4DOcEa8ixCi/0bFldqZ9HNBKxOhCmLo8a+QZPn57kPtGxW3W3HuzJfa3FLaU9he4hjUvLOtqRAiOFnmynLY0b/IFfai6Yc3zflygh7IOWrZD8gb0SQBTsAhd76h7DWTI6IxvpOtOD/tCoIMMDvBrzzHB8lZ1/k/tahYIXq3ZFhykzgrDVauv0XMfl3kX+vWoe6ndSr2qwhsCvL4300Bl+2czpt2X+OBFgR5pChC2nnrlxvhKhIU767IZynSJIFLY4CPEXKEh2JVf6swSQkctK+FQg9VKFYwKJ8q4ONysYqMhL1qiRUxsra+tZXMbnv1VwGIkE/xYM/Y/EIrUGX27cLyS8UBLRnX24Wp+lhaN54znL+1C+k1oYppSTFsY1t4Rhiir4KDmfr7jIMdV8ar4IFo4BxWrO2/aSsjoTm1fNBV02vjX7udskCcc6DLHXyJrqu77yEjURWzjEYrc6xqgtpCDM/uTMm9i4WmhKJ6BMYKdniD9Laq4IgG2WzHA4IMsJLuiHMPimim1LsXfhrHdh1IwGNfN6s9OVqy0NdMNOFIJLNMfm5/2+PgcKNzVz9EQqvLdUaRuxOqEb5EytX/G/MYd1fkp9Da09QPoyAgixX4K1xAwaomaZ5NsgXdXP0RZb/jYbNIeRZC4CE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW9IcVdjV0Z1MGR2eW1CR0dWNDJFTVFXYUE2WWpqR0hvV2w3b3hIL2daSWZq?=
 =?utf-8?B?aEN3NzE1RWlzWW51YUxKbTdkT2FlZDBKVytIVlVHSUk1ZlVsdVdvYlI3TFVU?=
 =?utf-8?B?RkdVQ0NMdExObDlKWE1haVUrMDMrY1NOdWJNeDJ1S2VLTitGNHBvNU5qQnlx?=
 =?utf-8?B?cUFuQTFadm41aXFhNmhRdFU4U3QzNHdPZ2VqRTdrVEdPa2RLWElqbC9VZWlV?=
 =?utf-8?B?R01RRTdObXZ3S3ZqQmNDMzl6YW52d2Y4dWdpK1JRVjEyNmw4eHRkMXd2WUpE?=
 =?utf-8?B?cXFDSWJDK3J6UjUrOGI1T0JjN2NrNExETnE3aFQvaC95a09xYmNFeFp0R3pC?=
 =?utf-8?B?TnJXTStwVmZzTGFiamQ3a3VKVFBhVXNjY25pL2VZZHc4OFl4dTNZdExiVXov?=
 =?utf-8?B?aVpkdHhLMW5rVkpkQUljZVNUVjVXZ3BMR2w5cnpSd2RZaHR0VkVHYlhzSWRX?=
 =?utf-8?B?eEUxam5qVWtYOVB5MXJuemdDVncxT2xKdjRPTVhjbFhjU1lqYUhWdC9WN3Fw?=
 =?utf-8?B?d1JrbHdvY3d1b2xOQVpnVUl2N2h6NnFacmc0WnVkR0tUNW42OXRxeithd2xO?=
 =?utf-8?B?a0kwMHgxcCtkTzVwd01mVENMV2phVFpSSERBV3hkOU9EN21FL2RXc0ZkeDJa?=
 =?utf-8?B?bzlVQUhFNm5aYmlnU2Jkb2VCREpSRURNVmxvTVJMbUpqN3FOVkFubC90UFBz?=
 =?utf-8?B?dHVMcnREam5JdzRXamF0RURjTWRoeDlvSnF4eU5MNFlmSUI4NVVsMlpsRUpP?=
 =?utf-8?B?bCtPTENaSDRqQmYxaERFemJxWUJjeFZaRm1pOW1ORFMxYlJPK1FWRlhUV3ZS?=
 =?utf-8?B?Y1VQY3k5ZE5Ed01ReXd5NjZpaDdCd2NsSDRJdmt4R3A3UzRhcUlSdmNEMVpN?=
 =?utf-8?B?eEdMOXh2ZCtaTStlK1VZOUQzRElkeVk2MEVnY2hUODRSMHdEcTVWOUNrY01C?=
 =?utf-8?B?TERCSCs4OFVrcnFOTy93YjM4WHNjdDF6RGk5QzJBdkptbXZYd21wdzlNeGFX?=
 =?utf-8?B?Z2UxOEJjQTREc0FNVWU5cmVLOE54bzBpeURyVjZpUFBPemJ5b2xJUHpXVXRt?=
 =?utf-8?B?SUhJMThvZFVjdVJiV3cwRTRXZ3YyNkwzSERyUkVFbTd1UGRPRjJxam11WWVn?=
 =?utf-8?B?ZUtzVGJLNXRlQ29kM1hkQkFJY09oRDQ5K0ZsZHYzNmFyU2tmc3BEcG1jbHM4?=
 =?utf-8?B?Z1BId1hGc0VjN1crbzFhUUtLcXZDcnZtRDg4SnJvdzZJWUJtbURKVWlIOU9l?=
 =?utf-8?B?NjRWOTNiZGtSTmNFZmlBbGFYN2ZtV01ZZ2lkVWNWa0RPQXZDVVhLZDVwb2Fj?=
 =?utf-8?B?U3V4dkZtaENwNDhyMlhFUnh6TytkUXBCOEVhVFhOejNRS3pwbFNhTnZMdUpW?=
 =?utf-8?B?aTNGVGhOL1d0RjhWRnpYN0o2NUlDVi9mdnM0ZmZjalJKVzJaNmpLMVI1Y0dP?=
 =?utf-8?B?dXBCMndWZlZycm82Z3NTby92Z292NkprT3ROZFlUN3pKdS9IMXkrWkM5Zk42?=
 =?utf-8?B?ODdwMzI2ZEoxeW1paEQ1MlMrVENqKzJ0STVVblFaMC9HTDJVMW5ZbGIxMWV0?=
 =?utf-8?B?WllhSmQ5NjF5cTRKaFlkV3RqcXVxZ2VQZ2lmMkgvN1hpK1ZSa0lMaHZUZ3ZJ?=
 =?utf-8?B?azE2SkJSVWFOUGRteTd6bkZqTGdnc3A5YkFQcEZ2QzBNYndndG1pWXBheU90?=
 =?utf-8?B?RUxNMjJrdnk2SjB4bWlkbHNDcTUyY29DaElpRHNzSWkzcTNRUk4rNEdYUnRr?=
 =?utf-8?B?T1VUNEdHZUY2TDA3SVVFSlFYMGZEWGQwQWdxSzJpZ0dXdkJOdjN6ekZZaE50?=
 =?utf-8?B?OXBHZm9ZdWlIVEtiZmY0TWQ3aTBheEV0dnFpa3VpekxPeHp4WHlCUU1qaWtX?=
 =?utf-8?B?MTZuc2hrQnpVUlN0Ym9XbnEzZTUydCsxT096eWZvTTgwcGpzQnQ2cTJwMTVH?=
 =?utf-8?B?RWV0UGFFRGxkVDhRZlYzMXFrcEtOQi9tZXNsRlQ1ampJS1p2cytSRmpQN2Ex?=
 =?utf-8?B?ak9zendyU2NCZytVeUphR08wOWYzVUlNUTY4LzM4RDc0OWZNRWZhbHY0ck1s?=
 =?utf-8?B?WWY3UTRlTDV3MGF2WkdaL1VRT3FTWkxDWW16bHM5bnNIdjVpR2hBeGtiV05L?=
 =?utf-8?B?eHppWjY1THZQRGF2MFA4SXd0VzViWnBLZFlJUzUzak8yZEVUR3RqOW9ZZFlM?=
 =?utf-8?B?ZHdIU0RhWlh1d1pPWHZubE9Jb1B5dzFsVWZySXF4Q2lpNXRPc1UySE5aMlBk?=
 =?utf-8?B?a0dQOXBwWTAxQ2xTY09NZHN1RWowYTVsaVoxM3NkUHRGMnVVUHN3Y1JpTHJQ?=
 =?utf-8?B?aXNlTzA5VVlTOWtJaFQyZlZnVjUyRmJSMzRQQ3VwNGtvMGFURDlBRFFXN1BB?=
 =?utf-8?Q?5r2L+irj/7i/x0ds=3D?=
X-Exchange-RoutingPolicyChecked:
	lUVe1oSnEjMv13fBzZXnwcztTppSR40Hm/4xswuBTneF95aoluHYGHjl+dzqYv/7YZ2kW6Yuvzjif4djinxFq0k4KaVDo1gtduHRpEkbdteGbYVUocPNvGdWIgqAdujYMpt6p5PpPGQxm+sRoCc97dBtz0LUhGuAXrqNO2E19e3QRvegsgj7LjXGqDLh5fVYJuKuMO6lqEhdMLiluB4vpCCbt/RG79d++VBljjRv9Gu7DrnEV99ajTFjUCyIK63N+EfCBkRXN9o0wzmkAaRO10wAL1d5Om++Z4qO8u9qRkgs82C0eymszVRbIOmkZeiLC1Ajj8W1Rq7CIJ9aUFqMAA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	08wXShRxUJyqL9bq5GUvz9DLx/fbHJhk7pi7iNKYlrX4c72uPl9wXf/GPfDCAyp+x3RLk/hqAksqiVj0XY92QeZsbU0Q+SeWNvBLInW0cLCF+leI66b7zkHKLufUWJxrgDYccaLSIwDNzAMv0P3d8Nci8E+fmgSaRsvb3qaCTRbBi5sP/C7jn8ZHXE+doHc+CsPCHUHScA8ZzeJnqk41pfE7PzIjdtjPucUkTB0NcvnSEKjhMtU8A2VzRpfyhCg0eBp6Gvo77inGXRtnU77N2r9BlzntAmbMemzv9g0fL7SY/0z+g8KhdyR7/dCKJR6/AVxZu8iQqxOCcQvNXEY96fw5fUsX2DG2JwoXlB5QDoIvtS3R0PGjOBEAIujlHQYNjjaoXiuk2PXeipstluYk67Cha1ZqUYsxhnMi9CGImnw4A13voaEc6LOq4cPnl6kuFmEDxNUZw46xn8F9hON7cjgbR6Bh0s9eV+H2nzVsrFtbO3QnIlc3psY8ODWQwCK2JNt1L6UAxRCLGPxyRB6hRQ1adtKMDYrJg/wLEq86OE2KgaQAw59Bcq7EWKOjMvSUZa5Tt0LygITFMfQ9EB0GLwnPuyYBLMhdW2lF98H9m+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9e90f7-f7db-4e61-bda4-08def884b9a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:16:46.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI6MusNRE0z/fJzU0oUO8DKI3B9wz0496cdgbFMBNNFbk/6VtczHq2emBukifne0HTnXn9INfeDQcn1IMt9vzEf6sX7fv1GZICzXxexKWlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120124
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfXxYkXlET6rdmn
 X6IvZjFmCk37ISbhq02eDD4o57a03FSuVFt0s4IT3+x9lbg2Z9dyemUQdo7slFB78L2ufg1VGWu
 jkDsFd+N8ccDx+IXG1Wtx29eDALizApwpI+0C7GP8o3xb3PIj/4/
X-Proofpoint-ORIG-GUID: Bt7XaYB2RGHbAM5kCp3GpzXmrrT1rVoo
X-Proofpoint-GUID: Bt7XaYB2RGHbAM5kCp3GpzXmrrT1rVoo
X-Authority-Analysis: v=2.4 cv=FcAHAp+6 c=1 sm=1 tr=0 ts=6a7c8e66 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=3XpYI8G3tIhY7uw_uvIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNCBTYWx0ZWRfXx5dN/4ZnvEGY
 4xxd3tMJ7qk44t/iZIcUzgICF6gGuDUHb/sLQyiGFsiE1zKNjh5JgsPdtU8ZT9pKN81rrad+ClQ
 a7ueM1prelQGrP0nJWCks1WV/sxxtZEAGrlPpVem5GhTCGIVfFhp2Yp5Q8UVR0tMCuP+QMmS1OC
 FU8PML0JDfRjSwYCKjgPnOi2Ex6g8HWfK6oVhgZcDd1jCf4NbN6jgbJzsdwfwhJ1i/M25Blpj+0
 y0Ik777c+pvbu/9qrNOEQzUrM75/cfAnEkDRkZfvgkCMaIMnvmZI3646IsHTiSgAGrQfmPyg20y
 tTZeV6hONrO8ApQfmEkjHnZbfuW/Xj0Pu10E2E6TXuJXB/J4Ofe7rjhHVCq6BcwBaREicdyViy8
 4HP80kITwgcAnzhobg6B+Fn8JkAxewTF7s7iJxevodXwtqvduLNZo+nLiFwIsauu5tKj66637rZ
 RV8FxoSj0Vlvfme3y8A==

On 8/12/26 6:52AM, Anand Khoje wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
> 
> Fixes: e1615dda41144 ("net/ethernet/pensando: Add out-of-tree network drivers")

The above commit is local to UEK. It needs to either be removed or 
replaced with the relevant mainline commit.

> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c  | 14 ++++++++++++++
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c |  7 ++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index fd3ee9820531..1822361e1070 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -920,9 +920,23 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
>   	};
>   	int err;
>   
> +	q->partner = NULL;
> +
> +	/* Only normal RX queues have matching TX queue partners,
> +	 * skip partner pairing for hwstamp RX queue.
> +	 */
> +	if (q->index >= lif->nxqs)
> +		goto skip_partner;
> +
> +	if (WARN_ON_ONCE(!lif->txqcqs ||
> +	    q->index >= lif->ionic->ntxqs_per_lif ||
> +	    !lif->txqcqs[q->index]))
> +		return -EINVAL;
> +
>   	q->partner = &lif->txqcqs[q->index]->q;
>   	q->partner->partner = q;
>   
> +skip_partner:
>   	if (!lif->xdp_prog ||
>   	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
>   		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 301ebee2fdc5..73998d61593a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -545,13 +545,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>   		break;
>   
>   	case XDP_TX:
> +		txq = rxq->partner;
> +		if (unlikely(!txq)) {
> +			err = -EIO;
> +			break;
> +		}
> +
>   		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>   		if (!xdpf) {
>   			err = -ENOSPC;
>   			break;
>   		}
>   
> -		txq = rxq->partner;
>   		nq = netdev_get_tx_queue(netdev, txq->index);
>   		__netif_tx_lock(nq, smp_processor_id());
>   		txq_trans_cond_update(nq);

