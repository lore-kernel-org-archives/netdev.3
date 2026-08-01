Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0762EAB6F;
	Sat,  1 Aug 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562497; cv=fail; b=ZJMLdQt6yO49u88UFSdQQkAYk0JlwNjYgeXU2SkK3nlzaAWcHNz+gqmN6pcylFrgDSi0hY5zDaXB6m4uM6jAeGyMGC/yZfmooBQs9VRcDpsrxuwwt+Ppg7yMSq+JbZsXQHTkCZmtLG9sIETZ+ZNuVmZ5saWj9qoobM/kGfkgC24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562497; c=relaxed/simple;
	bh=gtf0Eb6E0g6N5AESstySQFNHyez2DrpfistR5l6TrNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpaRubo6Xv5gKATR5w0b3H5k0OOipaq98r7UwTrhUzfAYFH27sVy+iJ+GTTKomsth/TXiMWWxfyZ4F3c64x9DbqYusd/po/lgoeb11ZBrgaIhIhpMvmvTDRpzOz9+lzg+xmPHcKpqwzw9iC4Dl8Ge72aU3yEXP+X1Jw/7uxAzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=teldYU4q; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="teldYU4q"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6715AKpB1347107;
	Fri, 31 Jul 2026 22:34:32 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021103.outbound.protection.outlook.com [52.101.57.103])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fs8xg851x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 22:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAgYZ4bqVvRoCYpNzIfsduzjkTXr7Dty9tuhF0ZsJR44nIXVd4NcCfGMtmrNo/GRnWxEPP4YntRZ+CCfrW1V2VV1gFdCyHnO3kKzsp0/p6+9rvVNtUdlJw1IWn3HW+aTXkcYliz+MXMWBZlI2Ss0000MR4m+tnuYGp6fwqT/O3G0AG8gZvnuiRjL8LH+r+bfF/oDnCpHbkIHSPWdx60Plxa2TuPMDNQbmDyUGI10xUhQ3GPEmqtwYhn4gGj8Cs30LgVap8BrbIAhoBiEDwY+YjJAUperWOCgZIjrgtSop6Ka6IGin82eVXCG+QJ88opUhrouNxeCiM2rO5MDaeylNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtf0Eb6E0g6N5AESstySQFNHyez2DrpfistR5l6TrNw=;
 b=LQSC9L+eVZK5gN56fwmjAio7TzLLoFQH8y1XlumXbAtWZTz92naambLzGuvAGbBroc14F2vLjNLpTLz+jrksp5PdXRQj838ILFfHcvkls8xHBP6ehiJtn1NQh8iJSa3tZ9zrUBLrk5e2Fqo3PEvKXapFpzMHME0CBxpYvlOExn5gDc+2uZZIJ3Civ2/K8NwwfiZiiMVhHw4p1YUDFDokZtjcN3atek/8lZ/Vr2OUodEf4/5oDmFySmsCicmlmtwHMwl/Ng2ziGBXBH078cXv0AtWCKad7+GTuUE16HA98Lw9xBMrP4v06zz3PEidPl1iJNmxjd1GJZlVuu5x5qPiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtf0Eb6E0g6N5AESstySQFNHyez2DrpfistR5l6TrNw=;
 b=teldYU4qGZBh/4kLh+EhcQ+Gozv1640fTkmgnGti8RTCJGG+6JKiF7jZ/H2Zmt/TGsy/da0FJTAXgYsIOzRIL5t4+S+yc4VWMvw3vzmho9MJIx89Y2LBh5Atjrweqor7JN4i+r02rDUG//C2mRDsfhl5wITIAx4X2J4PR5O//OY=
Received: from CO1PR18MB4747.namprd18.prod.outlook.com (2603:10b6:303:ea::11)
 by SJ4PPF796846B59.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 05:34:28 +0000
Received: from CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::ebba:a518:2bbb:b416]) by CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::ebba:a518:2bbb:b416%4]) with mapi id 15.21.0270.012; Sat, 1 Aug 2026
 05:34:28 +0000
From: Sathesh B Edara <sedara@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>,
        Simon Horman <horms@kernel.org>,
        Guangshuo Li <lgs201920130244@gmail.com>,
        David Carlier <devnexen@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>,
        Kiran Mallisetty <kmallisettyv@marvell.com>,
        Vimlesh
 Kumar <vimleshk@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix RX
 skb frags overflow and page leak
Thread-Topic: [EXTERNAL] Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix
 RX skb frags overflow and page leak
Thread-Index: AQHdGfPVfUszfeIOZUylTqIClUKmhbZ5v8iAgAA9v4CADrnMgA==
Date: Sat, 1 Aug 2026 05:34:27 +0000
Message-ID:
 <CO1PR18MB4747AB7BF286B86D25294844D8D72@CO1PR18MB4747.namprd18.prod.outlook.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
	<20260722090443.0c24a5df@kernel.org>
	<CAHPEe=HeQw_qtrrxc992q0v5CAys4ES3x1YTge4hev_2Z4B64Q@mail.gmail.com>
 <20260722132855.0faea241@kernel.org>
In-Reply-To: <20260722132855.0faea241@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4747:EE_|SJ4PPF796846B59:EE_
x-ms-office365-filtering-correlation-id: 9e8a189d-ac5a-4005-991d-08deef8e8e04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|38070700021|6133799003|4133799003|56012099006|11063799006|4143699003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 F2Q9aTbHpBUhfTq65DTyWw1LN5x0KHnyc+u7qNxKk6b4vkQul0ZXO9/7L1P/BX0LPpt9Nk+7byB1z/BRsmxDdER0DYta3lXOG7YYHFXFg8wspk/jzllVSwu5yabXF3qJj+6OO0tDrVMwxnnWZdLRYWwZF/sPg7yxrma3603/13rkpGj7jGgXViBsz7OoAceTzX5yMoPKuirpSxVjGKElzXPox/Xi/3AHKbYQalwDAFG4S/hViW+VtFniwePm8xhe4HEp//IfqloBrqiYzbY4BXL5M95Yyf6epYh9jrHeb4DNmJ3ehYTNDVD2YPWOaNPWqeraDPVqyZbM63XDmJgSqfO+pEjmrI8OuQ144HKsJeU31PezmI6uwVx5hNWey80kI4mUYqfS7W0ujAHgU9UqPu5nTTZJ4uhTOgXqH/AORuBzyndPtNg5bYvqeiZVSQv+d6ZREWnuV4mlUr+apY7Uc7zfB2qHnX9WOyIai/VdqFWJr9F2UMsq4FWH3UCvVuuxxDA9SiikUs4ng+2doK3hLMyLbncqJFdjDPExXSlfncn4jmz3c7Smw9SrVGv+3VQlVLYLRPUFp3Gad0HlevD6Vlu/eJEnM1kFOjFE7L/f+EW0AbsKU2Ssn4qYlpAa2125Q7NnPVShK9+nKqHZam/YMpmCGYUBwky4cYzqebK6aHZG9URIoI4lP787UH9fjWMp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4747.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(38070700021)(6133799003)(4133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW5sQ1hXQXNKNUU4eUZ3aG5NUlhqTU9FOFh5UGgvZnZDZ1krS1lKODJkUmoy?=
 =?utf-8?B?cnJ4c0tHRy9YRy9tTEJXdHhzNFVWb25qcHFEU29FNGdMT2NCMDV4RHBHdk1W?=
 =?utf-8?B?enloSTI1L0RyQVNCdTg3OGxlUm96aXk5R2dkNmRRNklGd2l0R0ppZGZDM252?=
 =?utf-8?B?dmZ4ZWNIOFZZZUhjUWljeDhXMGhYbXBVNmsxSHNFb3F5dU92QjUyQ0UzdVl3?=
 =?utf-8?B?bHlOeUFDTjl0ZzRMNGE4S1puems4dHV5bkN6Yis1ajB2OUpOZnZFYi9EUzdl?=
 =?utf-8?B?WnBaVGZzY3g4dml1VWlSQlVZdGxMQ0cyZDdHQ1Uyb2wwbTNnRW04eVkzUURI?=
 =?utf-8?B?dU9CY3FqS0hMNWw0QXkwV1pkZzE5WFBXWFlJSnJDVGI5UFJmNUh6bGhxVko4?=
 =?utf-8?B?V2tqZmU2L2cxNGpsbzk2dkZOVyswaFJWWjlLQVJ0eWgvd2NyNkQyckFQUDhU?=
 =?utf-8?B?RjJoVUphakZSNStBdWpRVXNYY2Y1R0tHQjVRa1hFdXJaKzZTdEtUNS9nUlBl?=
 =?utf-8?B?VTBHOVh3ZnBKbDVSb1oxS2pCNU9aWWxNSUk3OEg2eG13Yi9DNkdERDlEOU1q?=
 =?utf-8?B?aWtLbGI0WTIycUdiUDU2c1E4SC8rTzh1aFBwUDBDME1hZk5UTHkwZnIxK0Ju?=
 =?utf-8?B?eFlZVnREbUFJTXAyTE1JWVNFNHNjdEtwcGdBZ3p6ZTl5U1hvRCs4YWQ5OTdz?=
 =?utf-8?B?bnpua2cxMTkzcEI2aTlBNzVoZE0wS2NVVHNDV0dXd21NR3lUVWx0emVpVjI0?=
 =?utf-8?B?d04xd0tHWjJHVHZvaHM0L1IzWHZwRVFiUVZMZFZBWEJNWkMzQzVVN1cwYTdJ?=
 =?utf-8?B?ZjE5Z3J1aVU5MWVzNDNmVnc5TTZuSEJhZXRsR2FzUVdEQ3VzMm9RNXU5RUdq?=
 =?utf-8?B?L3dYWmJzTHNjVW9YRE1UK3dza0xRZ1dqRWJ6ODFXU0xhTGVLUFZXcHhMSzdR?=
 =?utf-8?B?V1dhQVlSSHV0dWlQekNvM05WMWVnL21kcEFrTHZYRzN4VHRidzVodTFnMHJs?=
 =?utf-8?B?RUFxVmhubEFHMktBdkFlNXVvRDhQdFErT2dxZWRSTHNHTDZHYlF2alZZVHhr?=
 =?utf-8?B?RnFBa055Q2FNa3gzc0VQeVZTamJlVWN0RVJEVXZoS01FWUhxSkhydmNudmVF?=
 =?utf-8?B?ak10S00xYVNtNVdBd21LaUYzY3JnYTQweUtLZkpJWW1PRm5leXd5aSs0WTVF?=
 =?utf-8?B?aXJEZ2VJRjI4WE5rSkVPTStncmxsekVSbnhNRlZLbm1LUTIrUk9oMjVGd2N0?=
 =?utf-8?B?bEN3MEJoL2lkU1Y3MHVYREh3anh6RXgvbUF5cHJzbzdZUXJEejc4MkMxQnFS?=
 =?utf-8?B?aU9jMUM4TGNpclpabDRXcTdMNEN1NVhtck91SEl5QzVjNkMzOTRXMHJpYmt6?=
 =?utf-8?B?NmxqV1E4cGpsS2NXUXd6OUxlWDV3dmlXTlh6L1RlYmNwb0EzYjNrRHdpZFhF?=
 =?utf-8?B?cktyTkFGYmMzUStjZlQwQUJ0cWh0NDE5dm5vMXpzTjdCSkdmaTRveG9DQWlJ?=
 =?utf-8?B?L0VaNld1UVpGMFA1ZjhlNC9FcG9TOTh0eEU5MmZvSmFYSDJQWWc3eHNJR3lU?=
 =?utf-8?B?cHRWeERVeEZ5Q0pLZ1Z5SGN2bEgxNDlkQ3ZhVW9kWmJSUys1aE03ZWJjcUdl?=
 =?utf-8?B?SGpaQzcrWEdqWTRKb29UeDM1M2pXVHl5UndOYWQ3YW10Yml3M0VpakhEblh5?=
 =?utf-8?B?WUZ1bnZHN3RMcHo4enNScG9MWkFybFFudUwrdlZoSk93Sy9HbGE2VGxhdDdM?=
 =?utf-8?B?VFBlV2ZPWlVPZmlSY1o5c3NIRUhRSFI3cUthSk55L3M5K3N3U1NnSWhRc1oz?=
 =?utf-8?B?RkJ5RnJ2WEJnYlJpZElvWmRWM3AxUWVFdUR6YUQycEw1dVFTQkxSYzVXWnJV?=
 =?utf-8?B?RHA0L0xLN1Rkek44QnQyOHpkSngzeWIwMmNMU01SQ2hoUTZQMjc1L1hJdS9t?=
 =?utf-8?B?bW5mZTliZzBLb2RSdTlKTmtOZjluMjN1eERRUXRHQ2ZVSWltVHYzU0pzb1pl?=
 =?utf-8?B?NDMxU2txbDc3T1NtcmUwNWFBNVNPdlZ1bnNDSlVDS1owRFdvdmtwSEhBbzA3?=
 =?utf-8?B?NGZtNFc4VDB3blJBcGZ3TFFkNGYySWZMVWpGTzVpc3lPM2RNN1Ayd0Q1eW84?=
 =?utf-8?B?djJGMHRHejk5S1crRmJtdS81UTlBcHB1QTh0RFhRQWFwcnNEQ1BFVlZRcXR6?=
 =?utf-8?B?S2IvVnV4eFlEWDdVQ1R0R21pZmVEa2RXVUVsb0czVjFjejlrTzU4MUZNalFi?=
 =?utf-8?B?TWpaaDRLWkdXVXNzYmpCQXlSZGNoK2N3NUEyRGY2NWNTSThTVzY2SUcwTDdK?=
 =?utf-8?Q?MAX6oORIQytouUsx0Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IdyZ6D6i7evvoJ2/hKTPXDEOIonP2Ivg35vHWZEjQ0PXg+7fcJRwQrdsRcVMyC9miwCZoLLXZM9qT1q/0RlQwwyuF6EwK56/so25sM1CDTbuZdQpZHXf1IasSu3hErbIaYgTlczZckZi3K2ZF/zYbqvT5CokYNTqCQswc6uyjMNeWNXJHA800b57XlgqaVzVQSx0Ilo3udQgL/hdlqJPv87/qAxx34J6YVU9AcTxuHYiTeMu79kV1BlnaYWd7JMi73EeYxwstdGVx663ixzVLLCZAoimfv0rOhwgChy95EWJdR7u8YHR6/9+GVYteVTXIND1b6ZdNQGC/sK4XW/X/g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4747.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8a189d-ac5a-4005-991d-08deef8e8e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2026 05:34:27.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNI4MlxbJUFgNixLA0S9MMuxtbzBJsE5cGqNOB1YcAw8wRXtdttJiQ3zE6YUcIpXBnRIOcximKwUSdyiID1zTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF796846B59
X-Proofpoint-GUID: Q88oy8nSca1AMW9CIofwgwziEQCMbwrk
X-Proofpoint-ORIG-GUID: Q88oy8nSca1AMW9CIofwgwziEQCMbwrk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAzNCBTYWx0ZWRfXwNs7vKSFK3Vq
 5/dfIerLAZ6dvghNM8j9vcPrx5nzSXewm0JyA0/tjBP9gmCl+HuGgJFR+NiM5wHuTeUEbE61+Sc
 jWVAaVfcwv/pMjdnoKxMHPHpJtpdI/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAzNCBTYWx0ZWRfXy45c5Z4MK+dv
 OUvSW7nwRErlOmcU4N3q6CxJ1fTTZPfH8MyATtA9nRXF9gJ1jt9Ard+3/O18bybLfKQtxqEGWIt
 m9TdRbiyYpgOUnyAOY5T2/6sUKFuO5bo5Bq9p2zEeSw8HHt4kYYDqNoFLdeUHnELJlaPLjUTzan
 lIS/0Us4J+FIZOhQNp9mszwooFEbFBc1jUQc9HEz9V2YILFM+agrepdwpFxo6IFvcKFps4Y+lJH
 BkkCc3FVchO8bZ6q4UDGf4AnzEEFH9vY+qXZqIIPQ5Gq9F6YAsVAudMUscZnRl7wvpiRuCav6sy
 yrY2euB3XNmB+7vSTMbobKG66zTEeBfxkLNzkR5fcG503+djuU2adUYmmr83tvCWs2U+TO/I0jn
 dbyOGOz6nVE2arqbh7GxbB7O/GrQBlI5jwlCLtmv4Og+J/07C/FdAGhkmAcaWrT6OX3nLizkAzY
 swIY88OwpZCyhoQDVmw==
X-Authority-Analysis: v=2.4 cv=cLzQdFeN c=1 sm=1 tr=0 ts=6a6d8567 cx=c_pps
 a=FfGi2H57Qjid8cR7gtztuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=RpNjiQI2AAAA:8 a=QqwUylPediNKu58C2-kA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01

SGkgSmFrdWIsDQoNCkFwb2xvZ2llcyBmb3IgdGhlIHNpbGVuY2Ugb24gdGhpcyB0aHJlYWQg4oCU
IGl0IHNsaXBwZWQgcGFzdCB1cyBhbmQgd2Ugc2hvdWxkIGhhdmUgcmV2aWV3ZWQgdGhlIHBhdGNo
ZXMgbXVjaCBzb29uZXIuDQoNCk9jdGVvbl9lcCBhbmQgb2N0ZW9uX2VwX3ZmIGFyZSBub3Qgb3Jw
aGFuZWQuIE1hcnZlbGwgbWFpbnRhaW5zIHRoZXNlIGRyaXZlcnMgYW5kIHdpbGwgY29udGludWUg
dG8gYWN0aXZlbHkgbWFpbnRhaW4gYW5kIHN1cHBvcnQgdGhlbS4gDQpZb3UgY2FuIHNlZSBwYXRj
aGVzIHdlIHN1Ym1pdHRlZCBqdXN0IGEgZmV3IG1vbnRocyBhZ28uDQoNClRoZSBoYXJkd2FyZSBp
cyBpbiBhY3RpdmUgdXNlIGJ5IHZhcmlvdXMgY3VzdG9tZXJzLiBQbGVhc2UgaG9sZCBvZmYgb24g
YW55IGRyaXZlciByZW1vdmFsIGZvciBub3cuDQoNCk9uIHRoZSBwYXRjaGVzIHRoZW1zZWx2ZXMs
IHdlIHdpbGwgcmV2aWV3IHRoZSBzZXJpZXMgYW5kIGZvbGxvdyB1cCBvbiB0aGUgaW5kaXZpZHVh
bCBwYXRjaGVzLg0KDQpXZSBhbHNvIHJlY29nbml6ZSB0aGUgcmVzcG9uc2l2ZW5lc3MgZ2FwIGhl
cmUuIFdlIHdpbGwgbWFrZSBzdXJlIHBhdGNoZXMgdG91Y2hpbmcgdGhlc2UgZHJpdmVycyBnZXQg
dGltZWx5IHJldmlldyBmcm9tIHVzIGdvaW5nIGZvcndhcmQuDQoNClRoYW5rcywNClNhdGhlc2gN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyMywgMjAyNiAxOjU5IEFN
DQo+IFRvOiBNYW95aSBYaWUgPG1hb3lpeGllLnRqdUBnbWFpbC5jb20+DQo+IENjOiBWZWVyYXNl
bmFyZWRkeSBCdXJydSA8dmJ1cnJ1QG1hcnZlbGwuY29tPjsgU2F0aGVzaCBCIEVkYXJhDQo+IDxz
ZWRhcmFAbWFydmVsbC5jb20+OyBTYXRhbmFuZGEgQnVybGEgPHNidXJsYUBtYXJ2ZWxsLmNvbT47
IFNoaW5hcw0KPiBSYXNoZWVkIDxzcmFzaGVlZEBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uDQo+
IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgUGFvbG8gQWJl
bmkgPHBhYmVuaUByZWRoYXQuY29tPjsNCj4gTWFjaWVqIEZpamFsa293c2tpIDxtYWNpZWouZmlq
YWxrb3dza2lAaW50ZWwuY29tPjsgU2ltb24gSG9ybWFuDQo+IDxob3Jtc0BrZXJuZWwub3JnPjsg
R3VhbmdzaHVvIExpIDxsZ3MyMDE5MjAxMzAyNDRAZ21haWwuY29tPjsgRGF2aWQNCj4gQ2FybGll
ciA8ZGV2bmV4ZW5AZ21haWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENI
IG5ldCB2NiAwLzRdIG9jdGVvbl9lcCwgb2N0ZW9uX2VwX3ZmOiBmaXggUlgNCj4gc2tiIGZyYWdz
IG92ZXJmbG93IGFuZCBwYWdlIGxlYWsNCj4gDQo+IE9uIFRodSwgMjMgSnVsIDIwMjYgMDA64oCK
NDc64oCKNTUgKzA4MDAgTWFveWkgWGllIHdyb3RlOiA+IEhpIEpha3ViLCA+ID4gU29ycnksIEkN
Cj4gc2hvdWxkIGhhdmUgYW5zd2VyZWQgdGhlIGZpcnN0IHRpbWUuIE5vLCBJIGRvIG5vdCBoYXZl
IHRoZSBoYXJkd2FyZS4gTGV0J3MNCj4gaG9sZCBvZmYgb24gdGhlc2UgZml4ZXMgYW5kIHBsZWFz
ZSBpbnN0ZWFkIHNlbmQgYSBwYXRjaCBmb3IgbmV0LW5leHQgdG8gZGVsZXRlDQo+IHRoZSBaalFj
bVFSWUZwZnB0QmFubmVyU3RhcnQgUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1h
aWxzOg0KPiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5n
IGxpbmtzIG9yIG9wZW5pbmcNCj4gYXR0YWNobWVudHMgPGh0dHBzOi8vdXMtcGhpc2hhbGFybS0N
Cj4gZXd0LnByb29mcG9pbnQuY29tL0VXVC92MS9DUlZtWGtxVyF0SzNaMWY4VVluVTZ0RS0NCj4g
YzJaeGF6bG5yY2Y0N3JNd3pSOGJmZW5WV3p1YWp2SlBZc3FxeFlkZ0h2VndiVFItZWRmMkVLcWtS
aUlBMGFsYyQ+DQo+IFJlcG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVy
RW5kDQo+IE9uIFRodSwgMjMgSnVsIDIwMjYgMDA6NDc6NTUgKzA4MDAgTWFveWkgWGllIHdyb3Rl
Og0KPiA+IEhpIEpha3ViLA0KPiA+DQo+ID4gU29ycnksIEkgc2hvdWxkIGhhdmUgYW5zd2VyZWQg
dGhlIGZpcnN0IHRpbWUuIE5vLCBJIGRvIG5vdCBoYXZlIHRoZSBoYXJkd2FyZS4NCj4gDQo+IExl
dCdzIGhvbGQgb2ZmIG9uIHRoZXNlIGZpeGVzIGFuZCBwbGVhc2UgaW5zdGVhZCBzZW5kIGEgcGF0
Y2ggZm9yIG5ldC1uZXh0IHRvDQo+IGRlbGV0ZSB0aGUgZHJpdmVyLiBUcnkgdG8gQ0MgZm9sa3Mg
ZnJvbSBnaXQgaGlzdG9yeSB3aG8gc2VlbSB0byBoYXZlIHVzZWQgaXQgLw0KPiBoYWQgYWNjZXNz
IHRvIGl0IGluIHRoZSBwYXN0Lg0KPiAtLQ0KPiBwdy1ib3Q6IGRlZmVyDQo=
