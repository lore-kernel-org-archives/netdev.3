Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0A1F91E3;
	Wed, 26 Aug 2026 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787711047; cv=fail; b=ZkUvpSD2BxyTWPJMgRvYT3wqcwAptPm6ZaCvxPSqm8lEZXL24Ufp7GelNMt/9WjqwIna/6ncob0XX8k8ivsoZ3sa9IB6m3CIDl5Ek3LC0GklCkPROXvNaE6YDqZ57yekTB0NnZYWOX9TYfZ6QxPI6f8RLaz1SWtZclCZ8M1VpBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787711047; c=relaxed/simple;
	bh=WzDIARSAULfE5QffwMX3m7mx43hTB8mVs1i+CA4IpPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZKbnqCfWJ6U7ctXqgm+MVByokNbBVLhfYuYoEU/gTldsAkPo5w6Cdg78u3Rrl5Lk8J9RFpTDgn3dKUHy8TAoshoG1Dq9xgYt1tFQOpLxp1GN5l1xFlhgY4g0XHgt3F6Y/aZeUxo8cIudC/dyoTMDphKJwuiZgrz9tyvc8bQyAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MmP0Vang; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CChTW7p7; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MmP0Vang";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CChTW7p7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787711045; x=1819247045;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WzDIARSAULfE5QffwMX3m7mx43hTB8mVs1i+CA4IpPU=;
  b=MmP0Vangkaa7E6VMvwxjj8yGx8dmS75wJYMX4ZLZBA8iye8Qo3yvFef2
   mb6hYY7aiq8Wrxb3V6XVLWNEg0KrUu4Kalb07mKlxWCItDwCfNg0JZRPs
   8dL/ddU134QPjIDo+anuJmvxdjKq9u1mi8QWVnmwOgzqK70HBN+lIpVw7
   JgYoxg7uYuxo4Js2/V9g0dFdJ6/ss919AcOyw3BuL1FBakDFFlOu/ikqo
   opdshVTQDdUtMDoOiXntXSHbafknfjW2Vn5/Hi6dhwknvXXwpTw1rF/sa
   WNFogCucy/AI1BTlrldotV4osy6drVsFtlXoGYraSkmjXb+9TfDqCuyn3
   g==;
X-CSE-ConnectionGUID: Vliyol6ITAeedancDZMvlA==
X-CSE-MsgGUID: tJEVumdRQGa7wkQSCUgpNQ==
X-IronPort-AV: E=Sophos;i="6.25,243,1779120000"; 
   d="scan'208";a="153317084"
Received: from mail-northcentralusazon11010041.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.41])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2026 10:24:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+tHcq2bL2N5in6y6gV5haD3lsx/ttkxF7f+LLRjHBGT2SWWieOCMF6zUCiIYn5iMizOuCX9amRuj4e0YAm9SVA0Saxw4aQl2BsyIQpCrJIYZnxJR64GmhTa/dNwE5/HpUOxo0GrQoRR7cNwMsYLLtAQrqaCDjw8jl7RpgDHDvpQEEZwYglgjH27Erx4/Jm6o+NPl4j1ooKfs2P9D7CajC8qP9MD6fDET+aRjlmxzAde4aLrQWEvRGaQV1zYebtyaKXiWQ3bH/hMdbqMAQ5b1U2+k4zO3UhuuD/3kea7EYH6reBwo8SB/XCAdYbpXudm8aUfgS/nPJ9YAC32gZ1SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GJ+pmNhxDc/yLBvbq0r5vxWoY/HVaE6P1gUnZ47jUU=;
 b=PWWHnL2o65vjXcpQX5osJ8Apv72hkFgScjc+6KkHV7PlciGtAN51PYx5G+qO0I+NJk6pUp+U5OGGLgWB+Th4CxdxyPHINfeyioGSzhL6KmpiS4bvqTpJXx+QlKCm31MP5YlAoq8TenIPsDKfBEYgujAg+UHRwbwPXkNNhT7TAVELxOwMQ+caE9XfZz7g4nCvftrmwhK5Jg0GtakwTi4ePPS5p9An73iSDO+odM7H+YY7U9Ilm2xmBSswQtnEnGfNBeQyi1odw6bjBn7MoSDDh5xUxTmI3zoatl6odCp+EADwivkEZqzEUN9znsVGxcq442pHTO644zKKhwThfkENsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GJ+pmNhxDc/yLBvbq0r5vxWoY/HVaE6P1gUnZ47jUU=;
 b=CChTW7p7h2DAMwWicgTvhJSG7veXHhxV+7bO08nP26Daj72N0jj3PyVdzrddZ19terEvkdMEu1fGzDT5eT8UIzmVs4hAlHrbHQsU7vIhOOoShLmWrtgJ0e+bq4bqMk5/FIKE4KtAOfg3KXuJ1JNdXYaYYCmCZ8q7DFEpvi3Ft5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by SJ0PR04MB8291.namprd04.prod.outlook.com (2603:10b6:a03:3f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 02:24:01 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 02:24:00 +0000
Date: Wed, 26 Aug 2026 11:23:37 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, boqun@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Message-ID: <ao5BNjnM_pwcdk9X@shinhome>
References: <ao0mwtt8ePAINFni@shinhome>
 <20260825064507.1499-1-hdanton@sina.com>
 <ao2WptQpM2zSQHDt@shinhome>
 <CANn89i+-PHiqn+yKUi=PbwN+qCd6Lr8KY1T6tL7pKPRPmi_67g@mail.gmail.com>
 <CANn89iKWpw1=z-pxfF89tN_AAMqG4+tu--zwy++W=bnHCKcLnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKWpw1=z-pxfF89tN_AAMqG4+tu--zwy++W=bnHCKcLnQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|SJ0PR04MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cae757c-83f5-405f-ba98-08df03190f50
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9Ot1c7+ZAlSH1KwQ4oaeJrPScVlzTRlK5QS/Lx11AvO9KSVZcXmo1WI3YKN6dcwCelUBULkIMeeC6GygFCKjLvGbs3Vt/Vg/JxIrS1h8D54VtrpPi3l+BwSCkFMIJ48+2NBLQ0V6CCmLvnW0sLF9gKI0znsl7o6NzbMYqLgtv9JvmoP7wtzyJIHpoOob0gocYdlZmYt1Eenxz9+NkuExBmR/bcsc64afVOZpx1GSkEqXw8VLuarspCA5tk2vtG1fvmS+WwSv8cbC4gvpzlm3TPddj1GzJWaRztxImEbffJMx4/e2YHrLcoP1RLvwkgmPdQI7FNquGtLMNLmQR7WT0TLx+TVBdSOmGfibhdUc/I3uKA4QBdzlp43chcZZ+QELbUGGwDx/EhHp7N44EgtjOflvBKJPnpjEVHD4HQxrhXJXyTsEOMmeA51/C+ofYPRfI06i8HNNDA9DKOpnFRqNU3/VNK8Dli3nQw8tfPbTy44ZTHDdorOTTgs06Xn7TnKOtvVRL0LO58DNZZppr6+9DnYFDzVsHM9tgO4eY67FPPo6OpQ/3GUgXkC0ODHbmbdz4dKfOMSR8+wJEgO4A5RXIcZVZxxNGNUifMsxG8Va0z8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5NWmpyTG1vbHd4ZVNKWElUWUpxOUo4UEErWWhMU2ZKVHg5bUdKV1BBaUlm?=
 =?utf-8?B?RWxIVi9HVnhOd2V2K2l0OVZ5bW9QMDh4eUVwLy9aQTlndytEdjZZVnFIMDFr?=
 =?utf-8?B?TGYrc0Y4dk13aUZYUmMyOTlGaTM3dm81SkZQSUZYUWp0OVIwc0poZWNudXhz?=
 =?utf-8?B?WllYVng5T1pXdG1CaEdLVUNnTVhlOW1lOE1Zb1I5T25qV0JNeEkvQmlKYjF5?=
 =?utf-8?B?ZldnZTZ2Z21XSEJzZE1JaTJ4d2dZSTJpT0M5WW5GRXArMHJielVwZUp0cDJP?=
 =?utf-8?B?aktTQ1ZGeG1jL2VPeElRUUNSUk1xOW9wSElEV2VUZTYxM05nUkc2bWJINWll?=
 =?utf-8?B?NTkxblJMcE1NQWJnbWFIY2FhZWVRdnhvSG9DcDhwYnlyNFhZQVJOSDhxRDNm?=
 =?utf-8?B?eDVKWCtPZUJoc0dkYkFrZzVBM0I1TEdqRkQrckViaCswNnU4ejRWUUVUbmV4?=
 =?utf-8?B?SmxnSU84OW9HTzJvQklvaUZ6UTkrMUQxQkZXbDNoa3FOQUFCenU3L25NVWRP?=
 =?utf-8?B?Sk1BbmlvQTc3UUs3U0l5RnFtejlsd0NEeTVRekx4VG1ubUx6MEJjQnhvdG03?=
 =?utf-8?B?ZzgzSmRuQjFVdFBVUTJWTytUYWQ0T2ZCZmdkRnBKNVJLNmh3SlpmWWQzRHpX?=
 =?utf-8?B?azk3bmRKNWhoSmtBZzNHeXNkRW82OVdPYUNOT1MxTC8vQVpPSGZPVU5UUUh1?=
 =?utf-8?B?aTVYamswQ1Qycktrak1qUm9LcjJmdnN3dk90Q1R3U0RSaHIyV1Z3R3Jzd3pV?=
 =?utf-8?B?bUhwVHhTNnVaMEVoTXpQOXBZUHA4VVlwc2Z4M1czekhid0FCV1VrNU5lWGcz?=
 =?utf-8?B?VVdXVWJPczVuTmVUTnhwQjlldUlHLzhCZzhVcjIrbTRQd0R4bHRCR1JjQlZw?=
 =?utf-8?B?dDhHTkhUMjRyQ3BaeXBWcnByZXJEalJ2Tm90VzZnQXZoVkhJYVVFeGhTdVFN?=
 =?utf-8?B?S2pPMXY2cE9rcWRXOWNVazlLczJKWHUxNlViSzlZdFE3VFluTDgvYytZNlF1?=
 =?utf-8?B?YTk0Vit5T2N4TTFGYUdEQ1h2KzdYcThtNnkwQ2s0aDZwMnpjTlRjMVBQenhq?=
 =?utf-8?B?M28rdytiNC9sZ1Q0VGV4YXhEVXFzdnY2Y1hNUTdNQ2lBL2lOWjJvYk5tWjI3?=
 =?utf-8?B?a0dhOXB4VnYrbDBnMDN1b3RYejRlbkJJck1xSHZmOE5NWXllWlhSRUpNTWRK?=
 =?utf-8?B?Y2FwNEx2SS9vZTVhL3dqeFlSaDJpa2NMdEZENDZ2Uzh6aWlkOE5scVdUOWYx?=
 =?utf-8?B?VXZYZXRnNnUvTTh0RU1yYWFESGMrMUJKS1BVQTV5Q1lzRFRZZ3hpbEdtdzVP?=
 =?utf-8?B?YVJ1YmZYZERDTFZKWGVtRjkwM0dWZzNGNWtsaktUZEw5NUkxSWFxK3JFRGxn?=
 =?utf-8?B?aXBJUjFKQ1JibWRFdXRmTERyaVV2Z1FWK2dBcUM0NXkyYlJhbVJrcUhqU1I5?=
 =?utf-8?B?anVHVnRXWk4wTUNzOTh0dkxwSnVyV3daVGUzc1JRYVFTZXI5Ukp2YWV0WW9F?=
 =?utf-8?B?alVPNzdUNnNFU1BMcFA4dUd5Q0ROKzlWOElRdGk0UnhLQk9oS0ppS0NLNkdX?=
 =?utf-8?B?aXd6Wi81TVRSRWVSNlJCNVYvS3MreTRiOHBGcU5lY2kxdy9aOUFLOGRtR0Nk?=
 =?utf-8?B?SVNmSm1XYXV3cWZXQkVKTkROb1JvQkRrQnpydkV3Q2Q1Qkt5WDJTMDdabk1w?=
 =?utf-8?B?V0tOMFFXaHlBU3p0eHY1ZlhvRzhwNDNvR0ZPMU96a0ZvVVQ3T0FCemlLWjcw?=
 =?utf-8?B?c1o4ZWxRd1N0WWYvTFZJM3hNcllXR2JFUDRFeTZvTWJyQytzZmZOQjNzR0hu?=
 =?utf-8?B?UEE4YTZqMk5WTjBrNncwWXAwRHNzNEpJNW16M1U2ZThvZGdZcWs3SVF2RUY3?=
 =?utf-8?B?VEVkNCtKY1BDR1FFblZ2Ynp1b24wT2UvV1liWnlxRWtMdy90d0FoenZ2cTVq?=
 =?utf-8?B?YUZJbXNvRGg2M1JyT0FhYkpaVzNmMmpKREcvWXpGQUllZi9WNVFYelJGRVF5?=
 =?utf-8?B?dkhFSjJBMjF0bDNRbXp3a3BHU2U5MFhLdEhmbGNFcVFmaFI1cC8yMndHVUtR?=
 =?utf-8?B?ZzRIR09UbVg3SWNHOXg0MEowODdKQkpTeHR3UVFkTEFtN0RkaXBtbEEveG5F?=
 =?utf-8?B?VlN2Mjh5ZVNrUUdycDVIUXRISEhrdmhYMVdiRUhkNnpvL2Jzd3dxK21kL2JL?=
 =?utf-8?B?aU5mMyszTGxWQkR4ZHJkY1JLK2FNNWN3cW44ZTNGRkZEYjlYZ21EU1UydGMr?=
 =?utf-8?B?dGJmd29NbHZkMXdxK0htM2FFZGZraTlhOC9EaThvdnM5M2UyV1lhaUwyeWVp?=
 =?utf-8?B?QU9PclZYWEVXQlRiYXRvWjk1NndUOHJoY3NKeVRIRmxYKzQyc2EwQytEaWor?=
 =?utf-8?Q?hiPnJVIxiBtGOfSg=3D?=
X-Exchange-RoutingPolicyChecked:
	H4777lXBftzFzRIug+tBSHPrCK1vJmfS9DOk+4ypsVvkqGNzaxrbmulrrMIAeZtb8DI5EdBVSAkNQXRzncPoBTEYThvDQeSQsWmow/ohH6epILZWUEcLlE9KXeQr2tLTVFwQDCI7Q1g1eBrcuPPxes31aW9lAoIiZ+lv3Jk6j2YBDMsr0RGnWjrxBYoY4NcK9I2Y+UaoRD83efgQhdG77Hj6M97mYgRdP+eepDS5dzEeQoZVKt6kULw9ZgglfCmGW7uSvu50FQ27eqq6F1CyDWDbub08VRF+h1epC3IdfR5OZZI7wH08JYIbCB4GJpBODXZHA/fz6bi4Fr3Gp+9yGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eyWzqSH90RagaeaArSLXLCYGDV+04d6Yv0HEX1l7lo6ALouRa4cq8ndJuPhFBqXTW1CPcD6DpOk3WpzCcJ0E/LiwNhgyh8PEWAMOjTQW0dxeezlo+lex8TtTqnuAhPhoeeZKeKFTZq7KkSfIF/F42gArFqqG1Wqg3Pu29xZ2pyc59vm2zEyyki9ncg9Wk5+jfbHZQxhjA8un3WjaZnLRpHkY7pe4yvapQEcLQIDapoIoehKr/4Kr90uXEX8X3Vty+UNm/m3oJuj0QjQAwpNlTYSiJvHmn9imIPavqr0aIi7ba0bCxxK7GuvDo7fiq9QU6lgbGl0AU0MfyQtrsGiuPEQqsz9e6+2Adlm6HVdUNFAmfvxp8XX3CyFV1EjHJ7psNaj2rOV2maGeQ/4AV+MbiC+ti5MvBrj6jMDAsB3Kn2iKyOcPGBGisSYBXyoN9LrY36vWUMXijS31V8dnoHSypkcLcmBBd5+MOP+CYpMflXO99+c/jtplVvT2oeDWd2aS0FlThffXhEll/wsi2HX4Tca3DzO3q16sUEKg7+ar/jsaRzVFmyQbKIZnwo6I+yhs2EkiPhi/vLSu1euDEpi/RjK1qty/lrw0QS+nyy9MJFVwAqIpLNbKHJLMEuELX7m0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cae757c-83f5-405f-ba98-08df03190f50
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:24:00.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5C3k8MgiOA8DVX9mRFtZporNfsP9nsQuuQiKXkXH21SjYnw96XV4kWSYIDQihhcNDFxYDuBdpNBg4GK9kADW9EDmSWFV3OsTXuFP4g4qMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8291

On Aug 25, 2026 / 16:27, Eric Dumazet wrote:
> On Tue, Aug 25, 2026 at 3:53 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 3:26 PM Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> > >
> > > On Aug 25, 2026 / 14:45, Hillf Danton wrote:
> > > > On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> > > > > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> > > > > >
> > > > > > I think 19bdb70c77d3 should be reverted.
> > > > >
> > > > > Just reverting the commit will reintroduce the other lockdep WARN that the
> > > > > commit addressed. I hope to have another fix to avoid the WARN.
> > > > >
> > > > I do not think you know the root cause of that lockdep warn, so reverting
> > > > 19bdb70c77d3 is the right thing to do because of [11, 12].
> > > >
> > > > [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
> > > > [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
> > > > https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
> > >
> > > I took a look in the commit [11] and the discussion [12], but couldn't follow
> > > why the commit 19bdb70c77d3 should be reverted. Could you elaborate a bit more
> > > about the reason you suggest the revert?
> >
> > I think you missed one problem in lib/once.c
> >
> > Revert commit e8eef69a99f1 (or restore once_disable_jump(once_key,
> > mod) inside __do_once_sleepable_done())
> > so static_branch_disable() is never called synchronously under caller locks.
> >
> > Previously, once_disable_jump() deferred static_branch_disable() to a
> > worker thread via schedule_work().
> >
> > Commit e8eef69a99f1 made it run synchronously in the caller's context.
> > Because __inet_hash_connect() is called under lock_sock(sk), calling
> > static_branch_disable() directly inside DO_ONCE_SLEEPABLE() takes
> > cpus_read_lock() (cpu_hotplug_lock) while holding lock_sock(sk).
> >
> > This created the bogus lock dependency sk_lock -> cpu_hotplug_lock.
> >
> > Every other storage/networking client (sunrpc, nbd, cifs, iscsi_tcp,
> > rxe, siw) uses static lockdep keys (static struct lock_class_key
> > ...[2]) without issue.
> 
> I  sent the revert request for review :
> https://lore.kernel.org/lkml/20260825142515.1965654-1-edumazet@google.com/T/#u

Thank you for the clarification. Now I have better understanding.

When I looked at the lock dependency chain among six locks below, I assumed
that any of the dependencies could not be cut.

   set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu

So I thought that the idea to introduce the dynamic lockdep key for nvme-tcp
sk_lock instances would be the only one solution. But you pointed out that the
dependency sk_lock -> cpu_hotplug_lock can be cut by reverting the commit
e8eef69a99f1.

I did trial and confirmed that your suggestion works. With the kerenl v7.2 +
revert 19bdb70c77d3 + revert e8eef69a99f1, I confirmed the blktests test case
nvme/005 passed with tcp transport. The lockdep WARN due to the six locks goes
away. Great :)

Assuming e8eef69a99f1 will be reverted, I agree to revert 19bdb70c77d3 also.

> 
> >
> > Use my pending TCP patch, which is a no brainer :
> > https://lore.kernel.org/netdev/20260825023614.1228551-1-edumazet@google.com/

IIUC, this patch uses GFP_ATOMIC to cut the dependency sk_lock -> fs_reclaim.
I did another trial: using the kerenl v7.2 + revert 19bdb70c77d3 + the TCP patch
"tcp: use GFP_ATOMIC in tcp_send_active_reset()", I still observed the blktests
test case nvme/005 failed with the lockdep WARN due to the six locks. Hmm.

The TCP patch cuts the direct dependency sk_lock -> fs_reclaim, but the depdency
chain I face has indirect dependency between sk_lock and fs_reclaim:

  ... sk_lock -> cpu_hotplug_lock -> fs_reclaim ...

I think this explains why the TCP patch does not fix the lockdep WARN due to the
six locks.

> >
> > Revert 19bdb70c77d3 in drivers/nvme/host/tcp.c : Restore static
> > lockdep keys nvme_tcp_sk_key[2] and nvme_tcp_slock_key[2].
> >
> > And we should be good.
> >
> > If you think each nvme-tcp socket MUST have its own LOCKDEP class,
> > please elaborate, because I have no idea
> > why this would be needed.

As I noted above, if e8eef69a99f1 will be reverted, I do not have reason to
make nvme-tcp socket have its owy dynamic lockdep key and class. Let me wait
and see how the e8eef69a99f1 revert patch will go. If it goes well, I will
send out the patch to revert 19bdb70c77d3.
