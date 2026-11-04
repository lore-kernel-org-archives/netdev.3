Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807879;
	b=VH5v56YaQ8//NPry5D39Wn91mVmk24TqfuX35ddRy7E066Ctftcqy5YY9TTTMnEu0m+Q
	 BYZTzQj2xZuGqzn+NsEVelwm/GYafcqC9YyLwqwF2guXlcgpTkOowM6bzwSWdw0GyvDkj
	 9dPbotW+MQWaGUwTDSMfjKQYV5/bWuEZq2Fm/yLzJ5lcFmjXbCUsTg8k5zCeDuzmfup2y
	 To7No4OSKqb2XIbKG9FjjVsUT1LFj9lG2ZFxZowsG1LWmJg4dKHzZV/sw1VszsKvrwz0P
	 vZk3th/MEm81hw0hw96noTHVJnqMPsY1NXZd63RknqWosPGrXNgl8qXs3eyzFrW1NYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807879;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PQgSTD6kY2Q5/lRJZ1jp85OWt0HLIzgtSE1J42bFdTk=;
	b=nGWPuiT/+DzRasI/kZS2Q4VdpoEgDYqZcGrYg3doQJR3zBMShjaVkJDISSZAE7smlyCJ
	 oDrh8dXUciyngdIuh8PO49UuRovHT57OSIXBWOnvxx5+p/oDSxWAGXML2G7czRhHxXFse
	 ckv/GimzND17h060Ia7yMhD34wvh0tOMCPK2BVBMhgDjCr1pHN4nvwpHhuiIhCwys5IhM
	 NY/XTfVwnSJgMGiJSJdkaxZLw+nqEnaUS6zxQifFnifmGut40a2RfMGoYBB94StJVZQd7
	 Bf4u5/Tb0RKKNQq6gS/YL3iHE8duc6ZQDR+2NwJ/dO5OPO7OwcweaBdkkdVm0lmJSeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kneaNj+o;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=f7xlqI+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076E606D813;
	Wed,  4 Nov 2026 15:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2076E606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kneaNj+o;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=f7xlqI+G
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fg7T83844332;
	Wed, 4 Nov 2026 10:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=PQgSTD6kY2Q5/lRJZ1jp85OWt0HLI
	zgtSE1J42bFdTk=; b=kneaNj+oXJ/tWi/8uxG3IWVK8Ar1W7nPc4u7DKU8QD86C
	a0xsXrN4dAKwn6p8zEwza8eDt56XxL4lBgJqmcPSNvhHdSVlIw08/YpO4sNsexPY
	CqiVVi+WNgmyorB352ZTiAXiDrx24Mxni97wxr1sWz52oMRqKRLJBvwwRSyYr3Yu
	6jhl4UfrHXcJ3/xWWs4NOhWSgdbZTQYtSCcRRVJPJf/UnzMVMG9QF2Q8/MBYYCpk
	g2QyFG7HzotoMcDHG+c/O1cC9K3d7vp/Xq+XDkngmEiO1B8lDKXZnO31h+q+VvHX
	ZNmpbaTro712ourdG5h/+cEd9EAIV+2UvkipH681A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=PQgSTD6kY2Q5/lRJZ1jp85OWt0HLI
	zgtSE1J42bFdTk=; b=f7xlqI+GCPfDxYitI3NzjUC4qcn6ok97Yvl7y3CKqU6/r
	0N0wnuBzPcj/VM9sfZ863H4MyzXwpvplx+RrQnXiv3LVVZJMp5i5riEdZmHVNmr/
	OWgm522I02F7qCGhfpOqaqgS3jNLHDOx6bO5gJmPfVAiO5fYP+ZTRkD8eNnB2M61
	SjPKE1RzSZCVL0WJQzeZZnVL4Qz/A62xW1Iw7Ccc6NKFQpxiC7eL5DINPftL3Svu
	myTe6JLhvD7JOvpicbNr+AR/GQIYDVSRTSiu3sgSAUFHb8rulSQsFKLeY7YralI5
	SF4gsEmy9jzH4idgRVHK+0XwZXAXbvahFsSQ17IKA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqh167uan-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:57:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYLglKxdBcK4O1AMYY/6wxx8MxLy0IKVxtqfRW8BimPFiN+5p3b9KJyTPMNmTa4fU7EdJF0csfdkAE5/q1g25lVAff1FPAFRxTM51nTFXFGwz3fHlNCs2VeN64WyJPhSfSePWGRhd5E8pbjCetqAVPFN+XEoeBqJNUtXIEpDiZR1RQ82dMjJDGk8hM8O6JDjbDNgwQJrcXyF0w8PBU0hTYQ9moEBRG6/VeSUHcv/sDrbY4GK/9RvRASKjW3DoX9RL1bVPaqUpJSzPKLhCyEAwJBYF5vJ/t5pCuW3O5zK6MrMhBo7hVDdzFCihh3LC3Z257sJHsF2pwNsHRIAew+bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQgSTD6kY2Q5/lRJZ1jp85OWt0HLIzgtSE1J42bFdTk=;
 b=LVvO73w5x4nd7/Tfslz+VI+aPs2YxvtS9dcK3P2wFlJHnTx3E1cirPzUXK3QXdsOome3yf7tZkCgrWF7aNIcXVWBNHIKdaxHgF0ZG4xme4420jjJn/B/nI3Ye3R2pFdyUhPicLTBZWpwGTHiWyVomgbfzso++yYeVjyXJkjApcn9Ra3mDX1ocwWETDTYevy4X8meHQe/4XZz8YtbGMqTiFt0sTSWT03d9PFUfF5MFktqEkrM3h9WdFwUtiiBC2itR1APQOuedX/y0wG+yzw29ctr7rw+/3CPO2cwvX7MO6f3+TlDR9OM1w/7524mcM9g8EQ1iICXtpnIfuYRkNQ6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DS7PR03MB5526.namprd03.prod.outlook.com (2603:10b6:5:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:57:48 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:57:48 +0000
Date: Wed, 4 Nov 2026 16:57:44 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Stijn Cleynhens <stijncleynhens@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mieczyslaw Nalewaj <namiltd@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: realtek: rtl8365mb: keep the neutral
 PVID in VLAN-unaware bridges
Message-ID: <autRCms7HolT2-au@analog.com>
References: <20261104082514.2139278-1-stijncleynhens@gmail.com>
 <20261104082514.2139278-3-stijncleynhens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104082514.2139278-3-stijncleynhens@gmail.com>
X-ClientProxiedBy: CPBP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::16) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DS7PR03MB5526:EE_
X-MS-Office365-Filtering-Correlation-Id: 576f7939-15c2-4c85-fd73-08df3a8c5f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006|3023799007|261021135927099003|261021123027099003|261102123227099003|261022113327099003|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZLjXsDF/xTC4QSGhSbZ2axAQq4S2G6FNYHo2I1Xh7v0LKQ9FIcE1gWCA/EPVLOfAGgypQITfqJchJCFeqqlWEYWwUI5GXJz2Y8/GGFB6ybSpjxzvk/Lxmvti2W83Hjwging4354882cieZgFCm2i4R7DBbYIHEjGTjwhWgdxoNZY4ar3EXMTU3lVhg9Pexqwx1HBnEKbj1ue+aTyHB19UsFjSdf7FFKzMial8WzOTnty/VEmkVXyDMj1WkP1Tb8qAmTeWn0Xqv5qZFeBG8BumfgAjko/kTO4n7AzhEME7KEQYug8yBu2pHMZD73/69zAObXs+bL2i2jmVZiNU70k8UTXOPrDrMMJWZkaA+rXU5dIC3fsoNDk8qkN7lTAs2Kvlx5TefI4jVfiNLusLjcGtNo4oJOG2mShsaETupEDsDyIm5c6iqWRaG/saXHoOxdpOrIgrKm1IpZt7MFQseFSUYFG4iwGpNRL3Ibinv+KaadHWb2jwMfVUUQmDahy8PUIDBus+rlIWYDRAuZgrrWpMTU5XCUpCcb2VQuzMo1pgmpUIBmA/RrB6xIlRsir4EL24e5F0AlMB5ZGq2Dv43Etu6FBQ7q3Mt+i1kn6noeRAxpWGrY6iXr7QCDrRhiYO4CGRAqJZqe5ywPWZdyDMclZ3fJRDmoNaVe2Q/rCFgojscs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007)(261021135927099003)(261021123027099003)(261102123227099003)(261022113327099003)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhQdm5NQjFOOWl3MjViYmVRbDB3c2Y5MlVlSE9MWDNPMElkMUF6NnBDSDRm?=
 =?utf-8?B?QWEvMnJ4TGFocXRVUEpuQ0ZYc21UeHV5c0NCckxOQmZJdFhqUWwrd3g2czhJ?=
 =?utf-8?B?T09TTVoyWU1RQmtaZ1kyVGtsL3FiL1E3QnNZRVAvMGpxdmxDeHF1a2hQNzV3?=
 =?utf-8?B?L0xNeklPUk1UZldTS2hoSjRUUVV0V2JJNE00NmVyTTJCb1Yxak1zU0diMDJj?=
 =?utf-8?B?d21rME9oZTJDNm4vVmlRanFaaHdJTmRXZ1BlSUN1Q0ZTUklMZHMxUmJDTWdG?=
 =?utf-8?B?cjNaTGowYnFRekNHQVlwK3U4RGRNYlFtVGNiUytXeWRsNFNvNkdMT3RFSHBT?=
 =?utf-8?B?eFBwTTZ3Yjhjc3Uxb1g0Q3JyUEVRbElqSW1Odk9MOU5UNTVYcnMyTFVEVHd5?=
 =?utf-8?B?Wi9vSm9LUUJBaVZ0VTJ2K01Rd21QVE9qVXdjSFd0UFA1ai82aGFhbWh3Z0Fj?=
 =?utf-8?B?L2NMd3kzMGZhM3dKV2F6SE5lY1BVb1NPUjBsY2dvcDVPcXE5WFZwaFVmMWtn?=
 =?utf-8?B?UGp4ejVRNUR5N3FJY1FCZk5CWWlZakl1RHNCYVYzY2UvQW9jTUxmaUsrbUZJ?=
 =?utf-8?B?dCswTzNVZTEySEVrUWVVVVlJUnJHbG5QUWZyVG9XL0VCUUhkd3lTNWYxQXBL?=
 =?utf-8?B?V3FkQTZFU3pVWllXYzJDQ3FrU0pwUGdRc2RPT2ZLdE5RZ3BwRFkxUkdOSTZT?=
 =?utf-8?B?Q3BnL2w3aXkxanMvTUZNQjQyYmpLdmI0akFWSXJjY3VsWjdyaVkxQ1N3ZkhL?=
 =?utf-8?B?ZnZteHNxUnNhVkJVN2VaWSsxNUsrS1p0TW1ldUNkVnFzNFM2ditEUlNhbVdM?=
 =?utf-8?B?L2dmZHdqbU9MNFFDKzd2NHNJdWFwM3Rmei9NZmQ3RWtudUFwbWpLSG9WVFRS?=
 =?utf-8?B?MTE3bGZZWmpPVWxZYzJGZmhORzlCVUlTKzNEWnpmUkRZN1lqbTIvbk0yUU5j?=
 =?utf-8?B?VElFd1BWOXp6U0FaV3pSUldCdXhPTDJLajg4NWtlT082WUs1MUx6dkJlRDVU?=
 =?utf-8?B?QlBNdEJmczdYcmNrMFhSZXFkOG5ZMnlxU0tHaTZnbXBiZ2V4Mis4bXVJQ0Rv?=
 =?utf-8?B?aGt4SVpsSVhJeThML1NFZEpIOHRJRm1vYTlVVDYvK2F4Rk5YM0dtTXpFaUlH?=
 =?utf-8?B?M2p3OXphbXgvbXJvYzFkOC93bTkvc0lGa1lPYVdWZmJHbG1TWHpkOEhtZ2RG?=
 =?utf-8?B?SkNVaDhreWttbjNyZnJvS3RwQ3EwVXJzQmh4MEljc2swU0xxQjlrVStlKzlE?=
 =?utf-8?B?eUJjMVZyN3cvQTBMZkJmWHlCRHYrK0srdkZHQ0NTUitGY2x3TzdjSmk5MUdE?=
 =?utf-8?B?MUpQaFhaSGZZNWpOTWdsVGdqRjVjVFRLZmp3dTB1N0FHVmJmQnhCOVlCRGVu?=
 =?utf-8?B?eXJEQi9HZnJUMWtqN1FsNi9WTy94WUNCOC9XT2s5ZDZrOHRZZEVqV0lSWmVn?=
 =?utf-8?B?YkVnKzdZNUkzRGp1cERzajBCTCtha2xPcm5SblcwNTJIdHVua29LeDE3ajRa?=
 =?utf-8?B?UDU5UkVOQ0x2SUNPN1FUb2JZbGZEUGpET1BXRUFvVEo2amlRZDE5ZUYxMGtJ?=
 =?utf-8?B?dFl1TkhGVWJIZHBkSm1JOE40Q2NtS0s0bFJGUWJDSmRIRWpVL1lxQU1DZUp4?=
 =?utf-8?B?cHdCaGttNnJ4M3c3OUxIN05sTDF6UDQ0MUNWek1sWkNhUjNPN3Q1OXhPMmxa?=
 =?utf-8?B?Zmh6Y2pNZ3hINC9ZSTRsN2xSb2JFbjZNV2Q0QVZiTDFqY1JRL3ZCZWJnK0xm?=
 =?utf-8?B?NDRuT2NYN3RSS0lISU94SnR1QUFMRlI3WDQyenozNEZOaFlLM1RVTXFNMmNC?=
 =?utf-8?B?OFBHMy9EdWhxOFVMTk1aZlNmZ3M0eDh3eHE5SE51TVdrZVdWZFNRRitpR2Y4?=
 =?utf-8?B?SnVETXhlTUtDUitFbkNldGgwNnNETzcrRTd0ZWtqRjdKMXA3cmZmU2hLZDJ0?=
 =?utf-8?B?aVo0dnVScWNxcFlZNGcxVkd6OFpYZFVqYjh3K0hZWUlZRWxRa3ZGcnhGVUVY?=
 =?utf-8?B?aE9lYVpVSFdKY2ZBWDZGamlCMjZsc3hJcUJkYU43QXBCMlE1TTZwcytxMGxr?=
 =?utf-8?B?M1luUk5XdDVIbUw0VEhoRGdDRkRVL1BZSnlsYXpEM3hKRGtmQ2ZkWGdIR3Er?=
 =?utf-8?B?Tk1YbUdRaGRtV3RGT1hSVXBEV085ZGN2VDRzR1NrWWxOU0tjZmF6cnFyUGFq?=
 =?utf-8?B?MzdLdzROVWlhQVdHU2p5Wnd1YnhtbTdzRXZpZkZlNzJQS1dhWDByVDRYK0Z5?=
 =?utf-8?B?SUl0VjlPNXhvMDdtSXhsSkRaMVB2Skpld1k4c282Y2VJUU9GVTVNNE1GZHVm?=
 =?utf-8?B?MGw4Q0QyM29HREZUaTJiRm9DMWd3dEQzNVM1Rll2bEdCZVBBTkdEdz09?=
X-Exchange-RoutingPolicyChecked:
	wuJvx0JcARubjCMHOf6bYf1vq4CdEtPZvOSEZKk0zWGkDt2y10GmYRpbc8gn+6FCEXpgxmJ1pepMoRKjZHwY3e44Bsr80M+bvtBYWaWBF3Sm6cCHKRBVsk0+8g2okGxPomFoieUix4OKIMJwAmcXSk4sJngBMg25p0lBWQzR7cDa4KNETUmLvxkNxUttBsY9qPrrAofxW5e7b/y92WrcIeoMHNYLP+IajlnqXtv1Qu/icK37y9nYCGAfNmpWNy/xL4ODEcm69hicEokmcHxgbyZ43QFaNpRjBCFb015mNME79sKBzOcE0cu7Y8N8ZTnV6vVAGPIz8BcAHTaRCtEdsA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576f7939-15c2-4c85-fd73-08df3a8c5f2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:57:48.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbjPVEP7kFwieip8aWMEGpe2B6Boe8XzsK3SQpJ3ZE3Mc9kbJ3PydhqvCzcRNnzn3Z+1kbJ8fq1PUsf7ggHGemw+vMlY0fMkbaTiyb6+87U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5526
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfXxVP75s/b2ScA
 oD2IV/chE2pkpTkGl/A1ZQ4zM9CwEw5hA+Re4UffGv6+Yll9d1nLuaE2oKyikN+FZ67TSn3zts4
 yRgYvDAfhORPmAl1emkl+fRXNJmlJGEj3/wq4YW7vkinE16OQLV4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX5VI0QDKolBa+
 e2dQd4ZY7VubcjSdy/3nwKnw/+w53r+dQNZKx/lOv9mBrmrJIIOXBGkb4b9pdCmEnhRRUsBONbQ
 U9BdzzXxrs6yC1qsqhyVpA9jsD0/HS4Gv5WLLHOM/oejykheRnvVv9mjwGe/llcNkIS/xdHNuKP
 0yl8q72pb/HhqpAWW2/XWe7dXAySoLJpfyNMnTIE1g5a4x9QB62A4wF7tKcRVCzyHQ9PGrS5CWg
 zEb3Bkwuyh27ho0L3Ffjz5ttJztckmnsazmgjwT9RizluMIDnin1k8WNkpMjI2alEx8ytAM+r+C
 F8+X717evmXvuMNT51mshOotb0O9K0tU6GFhQObblzQc4MMjXl2HMb1KLzFAqnql/35HVYE3JfZ
 dy3q8n43tURDJD/05xg0q/ZTXO41BoImzwykHO/oEszDlB8h88tIqrp5e4Deyq/2Wn0HubayycT
 Vr72QNn1KlNHjOlx+Tg==
X-Proofpoint-ORIG-GUID: JT_CSpG-Kf-d1tLL3pqbUwH0x-Npugca
X-Proofpoint-GUID: JT_CSpG-Kf-d1tLL3pqbUwH0x-Npugca
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6aeb55ff cx=c_pps
 a=9AjoWhdl+q7f6/Aw5qa/DQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=pGLkceISAAAA:8 a=yJlrqC8-b5213dFiCpIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040063

On Wed, Nov 04, 2026 at 09:25:14AM +0100, Stijn Cleynhens wrote:
> The switch looks up its forwarding database by the VLAN that it
> classifies a frame to, and untagged frames are classified to the port
> PVID. With configure_vlan_while_not_filtering, the bridge PVID is
> programmed into the port also while the bridge is VLAN-unaware, so
> untagged frames of such a bridge are looked up in VLAN 1. DSA however
> installs the FDB and MDB entries of a VLAN-unaware bridge with VID 0,
> so these entries never match a lookup.
> 
> This breaks assisted learning on the CPU port: when a station that was
> first learned behind a user port moves behind the CPU port (e.g. a
> wireless client roaming between access points), the static entry that
> DSA installs for it on the CPU port does not override the learned one,
> and unicast to the station is dropped as a hairpin until the learned
> entry ages out. Clients that need a DHCP reply in that window do not
> get one.
> 
> Keep the PVID requested by the bridge per port and only program it
> while the port filters VLANs. Otherwise keep the neutral PVID (VLANMC
> index 0, VID 0) that standalone ports already use,

Makes sense.

> so that untagged frames are classified to the VID of the bridge
> entries.

This part threw me off a bit. What do you mean by "VID of the bridge
entries"? If the neutral PVID is programmed on the port of a
VLAN-unaware bridge, I would expect all untagged frames to be classified
VID=0. And with IVL this should be classified local to the bridge. Is
that what you want to say, or am I missing something?

> Commit the PVID
> again when VLAN filtering is toggled.
> 
> This only covers untagged frames. Tagged frames in a VLAN-unaware bridge
> are still classified by their tag, so a tagged station that roams keeps
> hitting the stale learned entry until it ages out, as before. Fixing
> that would need the switch to ignore the C-tag on ingress of these
> ports, which is left for a separate change.
> 
> Fixes: 336e3e4a1ab3 ("net: dsa: realtek: rtl8365mb: add FDB support")
> Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 139 +++++++++++++++--------
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c |   9 +-
>  drivers/net/dsa/realtek/rtl8365mb_vlan.h |   3 +-
>  3 files changed, 101 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index b90e46c16..a7db267bc 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -838,6 +838,8 @@ struct rtl8365mb_cpu {
>   *         access via rtl8365mb_get_stats64
>   * @stats_lock: protect the stats structure during read/update
>   * @mib_work: delayed work for polling MIB counters
> + * @bridge_pvid: PVID requested by the bridge, 0 if none. Only programmed
> + *               while the port filters VLANs. Protected by vlan_lock.
>   */
>  struct rtl8365mb_port {
>  	struct realtek_priv *priv;
> @@ -845,6 +847,7 @@ struct rtl8365mb_port {
>  	struct rtnl_link_stats64 stats;
>  	spinlock_t stats_lock;
>  	struct delayed_work mib_work;
> +	u16 bridge_pvid;
>  };
>  
>  /**
> @@ -2004,6 +2007,41 @@ rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
>  			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
>  }
>  
> +/* Program the PVID that the port should use for untagged frames: the PVID of
> + * the bridge while the port filters VLANs, and the neutral PVID (VID 0)
> + * otherwise. A VLAN-unaware bridge, like a standalone port, gets its FDB and
> + * MDB entries with VID 0 from DSA. As the switch looks up its forwarding
> + * database by the VLAN that it classifies a frame to, a bridge PVID would make
> + * those entries miss every lookup.
> + */
> +static int rtl8365mb_port_commit_pvid(struct dsa_switch *ds, int port,
> +				      bool vlan_filtering,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb *mb = priv->chip_data;
> +	u16 hw_pvid, pvid = 0;

Please separate the variables on their own lines.

> +	int ret;
> +
> +	lockdep_assert_held(&priv->vlan_lock);
> +
> +	if (vlan_filtering)
> +		pvid = mb->ports[port].bridge_pvid;

I think an else { pvid = 0; } would be more explicit than setting it
upstairs, but it's a nitpick.

> +
> +	ret = rtl8365mb_vlan_port_get_pvid(priv, port, &hw_pvid);
> +	if (ret)
> +		return ret;
> +
> +	if (pvid == hw_pvid)
> +		return 0;
> +
> +	if (pvid)
> +		return rtl8365mb_vlan_pvid_port_set(ds, port, pvid, extack);
> +
> +	return rtl8365mb_vlan_pvid_port_clear(ds, port, hw_pvid,
> +					      vlan_filtering);

Can we unify _set and _clear somehow? The code gets quite confusing with
the two variants, and it seems now that with the vlan_filtering
argument, you can unify the logic.

In general the patch makes sense, I'm just straining a bit to follow the
logic reliably. If not something like the above, can you give a thought
as to how it might otherwise be simplified?

Kind regards,
Alvin
