Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792912828;
	b=A+hKWfC1jkECy0rYTgAeMh7PbVYcY+ymxAS+9U1yYDCVg/HqGiUI71wBflvk5Zcc5kTv
	 P5ATbSEsl3fY/aT4F4d3zGSZWO01D05HDloj/Xl5Q3haFZjxnf628jdZKv/fols3uum2a
	 V1Wd0nNVPIeZIHdym3UcZz3ktSor9lE1JBEhlagDt31FXzGs/sCaYdfDwaAZv698QlXzA
	 zN69g+HDHrfTwS5dGEpatjsmfAwEQfkNRMFChgFe+mX+Q+LOaAqGMBssWOQXhi7uCbE//
	 sU1YGIoSQllSkbZNJd1U2GbiW1lkVOv5Sjj8aA9O+vYGD6CazCz+S/5praqalnQ6YMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Vc/Zl4fsfLU0/QmL7gZOEKyMEql8+BKqFQTpDZh/z5o=;
	b=4AnU6W33lQs6L89Kd2m7PjoLcbi13vKRBT6U+qr8QyP5feVbOl5qNH29Z2NRdBgbgsXf
	 u9344ozyODZ4ck+/7D8z5GZkebj8rM1ThLWK4C+OblryUg8DPu29jxTnz2zL2X5DH4agB
	 Ms04PILHWDsOOWJK82QBKVlTXQlAgToQhGXRsxe79RljgESMNuhtEXxhnDDp8Mgff795m
	 ZgtpvOWhpzXJBWumG7F6HuLywsZOmdY+lAIthXbLSy56BUlbWHswmOtu9/dq0aSs2RseF
	 5GXNNAbGvFaxuolkQNBJOHBeDzlRVe44sXZ/W+kCWynfz8uWcAkYpxkII37iN21Nw0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cw8H2SXQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D0606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 07:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cw8H2SXQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxXfPxTYrGC/LLr7pWXrkT5DwzTOX+yIOt/6d0LOuaGqTxFq1He2muvouwemagFvMA1DNtY020zruLK79MRjF6RtVuP33eAnBZoCO465nrXnhj6EkyFrPDgFpA4nVm81ix7oxStqIDao1BuifRZDeGjsY/TGC75buFK2phDRxYz0Xmo0G4wkuIdR23SDw/fMd/GkmJpZQrBMJKBpCH64c+SYZLldMia/1Z1G9cr8uvILXbI1ettvnCeELTdmyxCG4AqoDEHZcxEUdwerKOt1C7Y6mora6jPOPZzalbkZzuCT4hEvoizpqBg6Du+JrdW41MST5MFWJAJ9uTBcbTbdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc/Zl4fsfLU0/QmL7gZOEKyMEql8+BKqFQTpDZh/z5o=;
 b=ZSKH7xsqoFsqkdwwcbnDV0mdegLYtiiKk+hsne0tT/8ALcZU/zvai0tw8TUudhQtxILhICRTqparslG5oajS97r6/TCa+yDFYbEd6/++yoEZHJiDEnXbcdnCkbh5xxvUAiSbD6O3mV3Y6UeDCMQNCoskvyPzfnYLW1bePNzpIqbLyvkouP5BTlD5orpoUCxFz14oa6CtekOwjsRU3GzbkJbyMgc3pobDXLFPqGGkmZAuvQIPBafSaVO4L4jy1IC+Zyp2Sv4wBluIlSq9734+aaNPBur5r6UoZhS0Sd9+ek2c2oK7nAB+K8EcMWQwFUQTvKejHIg3QxzqMrGj2pKNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc/Zl4fsfLU0/QmL7gZOEKyMEql8+BKqFQTpDZh/z5o=;
 b=cw8H2SXQfR8kjwJqoBOF2186+wjAOQpSb2u8pMHn7cuYDOA0zk3LYUSvoYVPTjUZ2iZ5BOi6FPM+xT9Zb4cvUjBVyfHXaxw7aZOPl/MBIBkc43FUyJlNstOQg+rnO9tih0lC7nwAphIptMG6DSPRMSiFM3QoV7hc0+PLCLov1BnJMoY4TRv+dm6gdLKnZwscub83I69AP3nSHIDOLaQYV0Z5r/colzGl7Fk7gN8HCSLrRakkrOKs9Avmzo1bQ21vNw7LREI8qLm53O94lRjAMKE5+n3HRDlpAsiuS8/jaqqbtBHgAQKFCaKOAtXW4kvzTAkypJozu5dQm6PhxiSPaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 07:18:24 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 07:18:24 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	yoshfuji@linux-ipv6.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] ipmr, ip6mr: Fix several info leaks
Date: Sun, 25 Oct 2026 09:17:27 +0200
Message-ID: <20261025071729.34967-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3451c4ae-8d3e-4e86-f30c-08df32682807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|6133799003|10067099003|3023799007|56012099006|11063799006|261021121427099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	h56oj/0QzLCOvNHG8uS/VcX4h71P47jSPxYkI6decEJ7mHuHjVvPVMKpmI7FLd2hxN+hR3fNoum0ovyLWKRObIdHch1WOHfrzpVThzpSaAxiCd436qAuhRpVUZkWLMrWaWQp1Izw0HtqHpPDKC0FVsqQqUPjmf/X0lbuJH1XfCWznHJFGyJuyFYGEkmPgLloQk1cFWyIf5Jp8YY9XrMK77+I+BEUvt+VFM960D4mGWpU2A9USI2doQprzlBsABTjgc6EYDNTBc3/G0BkcdPOaQ//bm2l4OjPi+mlueSop0yKlkJaiHYWPo571m7wSUe1QowNVVn4Ws/mZyxu3L8z4W2BQOeTn3d2xaXt/BzWrxSeTLY+dVH9V/YlGHL2Lv9Zd9iV41Nhoyqwzu7xURLQBrH4QTKbTRMsHrt1MiB9FxeCDWaBwroVQBWTHru3DGqnOux5obTM1tzKliZb4CdFuq4q5yDfiK2qtK1Uev3uoI/L4+zqgJAq6li3YKPz/EtDgWOtxA59gMM7oNYKR0Jj70yal1gva1HRXK7cyT4Q7zkr5UPYeyD2xEKFDJmOMh5OY5MzJ7259NdBcFzwKW2PTRqOi04abhuoB6Mx0TuL4Z9wr94eZri9jrFYMVAS3t4Zm2/+WDmn1zdDd2If/KIZEIryXtJ9YcG0iU/xh7jGsqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAc8Mx41EB7vBZO1a2pMQ52pIMvpy2nVAEOOSyVn743Bi360lW8gO2pPidkC?=
 =?us-ascii?Q?B/x/4L9f0kPUrKSf6LZ+WNaFQ0axVsEuSadnNj+hE7ZpmoAGHgeM5d8nfyhy?=
 =?us-ascii?Q?xU4TE6QJD6SWpn/KehMAmnKl+4gsS8ySS8MrxhDGET7r7I9mLS7mTqvu/bhH?=
 =?us-ascii?Q?BlawcvmHU3XvM/KPYjdvRrqfA1bjrLTn6r2rSys/Wv0gK8QsnMBu+5hE3bjc?=
 =?us-ascii?Q?9ktGEVaIXKE0Q7Du/Czn6WoZTL2av+MtjKYl4/DRXYRFNRrigM9V+HvXh8au?=
 =?us-ascii?Q?Clj3MTbPpeAleDBdQt2MgQEnpeQDuzeYcqAvH2As0DHX4GOwyEop4LGh+DX0?=
 =?us-ascii?Q?SlvcJ9BVVh4sK/xyHoS+b4j3oFeISXT0hhGP5oxakD4W3YAurSmH3w5NPQAP?=
 =?us-ascii?Q?8KrTHDWFsLTXWQPk0BxIpgaubZ/aOn32ZMC6NWgvC73j2yBEdX6+PBbaht88?=
 =?us-ascii?Q?Xrd3YsDOIMw9JeBXcYIXDTWNxwACalTO8hjFs8LPUqFbcF1ElepqhmMUjxRZ?=
 =?us-ascii?Q?ZOaqj9kMybXRPxchOF8D6z4DvE0XBjPoctmGKKGxYbiTpKsSX9a0MSYXUjqh?=
 =?us-ascii?Q?8t/0VP1+Sw+T+5oROTK2wkpi0sWMXAAYQ448kwtZwiR0HmRYkn7Ccanbi95j?=
 =?us-ascii?Q?zwTCjFfJrl3Dg0HIgj3lzADc8KaV9CiPvWNTHDLr9idg8nP4nVAlUHq1meK3?=
 =?us-ascii?Q?LwbyIMFcdQ8MlQyC3Jpa/IU3XIqlj3jF44jVJCVykYzncnxSwds9+7jSKbZj?=
 =?us-ascii?Q?xsjQk5uqKzjvorpakGy1M76YOxRrNGV45Gl95BiWhqOxjtFQ5b02O5GNScHG?=
 =?us-ascii?Q?6Ud944IJFXtXk9TbvrRSC1RH9Rwec4ty7Sh/8waNGARHaMAwwWO0+JCKr74D?=
 =?us-ascii?Q?/qDjaUuE7O9q3Ft21iOiopmWtlNA+dSAhZoV8dTDi63WBZV3CpYUtnaPRLfA?=
 =?us-ascii?Q?nBG105VBDUQM9xEgH1vuV2ATSH9KcVSKS3yEXwFXu3ZB0+a4AR54OS6SCNIi?=
 =?us-ascii?Q?dee2bmOCnzWjVXux7Hh3d7ndVwPboLA8d6qppWMt+VWmlqwlzRbtdgSr4Np5?=
 =?us-ascii?Q?IY1rhlzAa4LLW5WDO5dFRGQyobNaMHO4MEh/LhCGWvj2ElPwYiBhG9bPDEVR?=
 =?us-ascii?Q?/c3sNfg5hSmq+RVX79ib5coxb89SdMIz3vKR1mEonhCzOf09tjWghLN+dDa/?=
 =?us-ascii?Q?q0KW6/KoaXn2Sd08BoWSiNWnxzEnm5GleIys7b0gPfwcj3CbAOykM7Eimcpy?=
 =?us-ascii?Q?pagoqcHpo4ulUITBjQM6WEpvxhKRfo6u+UPsRmCZXO+PL26kWJM3c8N5RFtt?=
 =?us-ascii?Q?W69NvMNSr2isrlKGl1Hwy853bGc64chUyFMGqMDdzzswsPszwJvBFJXPmFak?=
 =?us-ascii?Q?VTF91fWQFRBpZpO4m1LxyfG7QtAeZ9Qr7FhtguuVySOW8vKdW7nIHX87j31K?=
 =?us-ascii?Q?MwqN1n+0Y6xcmSnexfSfao/Xl+IF6zwpOyPSLcTjisBKerz4oM36QywBi6aa?=
 =?us-ascii?Q?kv5vWAoKQe956S9IXsRIIWimdSZ4FOAZADykkqKe5FajqLJ3QDrMyGpLiWl0?=
 =?us-ascii?Q?rjdHHVC2c1XsMmQHUO3rWf87THdnjL7AAajAKW+IkRXyDD8g+xMrNdN4bYRT?=
 =?us-ascii?Q?OFNpvsxMhBbDdTmbma7DdglThRbXlUh7MK5pyFukgYiRF+rIcPh91mLGcNQF?=
 =?us-ascii?Q?YYW8PNyLuS3ufu8ekolOAyssAzQhggtqwRmZ3HMfAW8IlMSu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3451c4ae-8d3e-4e86-f30c-08df32682807
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 07:18:24.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Btn2MTdrHCiwu1PYYQkjfkZwXe+dvR7kYsKVVFU6jouWBgToyHX/dk3N4c5Nd0JStojNWahpBWaIS02V0cz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

ip{,6}mr_cache_report() copy the IP header of a packet that triggered an
upcall to a report packet that is delivered to user space. The header
is not always fully initialized or present, resulting in info leaks
flagged by KMSAN.

Patch 1 fixes an info leak in the RTM_GETROUTE path, caused by the fact
that ipmr_get_route() does not fully initialize the IP header of the
packet that it creates. IPv6 does not suffer from this problem.

Patch 2 fixes info leaks triggered by packets injected into pim{,6}reg
devices via AF_PACKET sockets. The kernel does not validate that these
are IP packets that carry an IP header before calling
ip{,6}mr_cache_report().

Both issues were reported by Sashiko and reproduced by me. See KMSAN
traces in the commit messages.

As far as I can tell, all other callers call these functions from the IP
input / output paths and therefore provide a valid IP packet, with the
exception of ip6mr_get_route() which fully initializes the header of the
packet it creates.

Ido Schimmel (2):
  ipmr: fully initialize the synthetic IP header in ipmr_get_route()
  ipmr, ip6mr: validate packets injected into the register vif on xmit

 net/ipv4/ipmr.c  | 7 +++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.56.0

