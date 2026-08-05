Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CB3F8712;
	Wed,  5 Aug 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921494; cv=fail; b=PkIVxmQnk2wuDVViwvJexmL2sBpficQGDSRltgVQr+YQlnLN/ZNRDO/wq27Wxi5dnVoc+NYmOHqvaGRZxzP/AOjTN/v5QSa27ndx+BNqpxxXC34eCHWf7bs3ZsSYxUwgUA1VCRYZJgbFygr0wIPhfCfEVLZWd94TahhDuivS0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921494; c=relaxed/simple;
	bh=I5G7TKNhACZc1nUGwwjoXvo77B9Qva2Acfjol238O8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hgzQA+zg6ag8LL6hGmVxVXMFU0M3+beRxs9lbLTjwXgRHSpL/ShPqu+zL+ClN1jpZPSS745Ld3cIapILkmtObhEyelZeeAYCZOIBw7GI9kz2MXObGtzGLXYN5bbVkDzAxsFvo1ggq/qbmeEQaBezk2KzLjlxIiJQibDMo7oQFFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=E8OqyEv/; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="E8OqyEv/"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758eYU9987785;
	Wed, 5 Aug 2026 02:17:53 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020072.outbound.protection.outlook.com [40.93.198.72])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fuspe9efj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 02:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk3RAq4TbBx7SqhLYvmNBlteC4BkQSZIxskGzIL61bC1ozTSkgLPTmavpidIzuXxW260wnZQFdo7ilYsv6fmqDhCJaQuveZ8BIep3LUERUa1nyWl04OH3fvvejM0SlyjN2Mpr5dMhd+CBqgq7ZIozzo6PeeY0/CIF+egKe5u+qwq6fT0bkppMu1SwcHDVUNbziJo0nF+dtsIOVWDsiADEvPiZ+cKelssWLX10EkAg3AcVsweP/DWRzRF3udrZWHg+rdx8kcfeizc2Ik+6AKLCc/n5CCWUFMUCwWZrIiQ7Yo9bR+UYp72lkYUUGmXeBWO0lMOLH8SCFelBfK6f8TMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5G7TKNhACZc1nUGwwjoXvo77B9Qva2Acfjol238O8c=;
 b=F2ISrupWciZu7U9K0W2gbsCarg3/vwKESHy0Wy2L/qucv5MInwrf+4VsxVX9Rcui/5d07CXbJ4p1GDoFUKZa//+MnvZ9q3K5FAMlqjimtpnXtuhgi2jhEirH5sMF3o06wuSFU2yHwGZCVlpIMtJQqtfme1HVKbru5h5QqPo83HZz42EBIrzdKD5dMbsV3EjUG30zpMTPBCF9UFdmRQjZY65eZAoXw5lyI8AtkHLs35uUTGQjfvreuBhWf6nEdOE/3CsBpKisgoRlICbzOm3NUaTb0g0PZt8YO8tVVgJtt/wX4XCYeAvAvE8HVp9cSaLpuqnK6khxR+8QNB5pY21KLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5G7TKNhACZc1nUGwwjoXvo77B9Qva2Acfjol238O8c=;
 b=E8OqyEv/Zm6YiLELP9u9KNYeHU1Nvl8UKbnr9Ac5WbB8eScAuJn0OK+Ei/oHnX4wG2fRAnDNYX22vUzsQJPuZGV10O3ioqGDcX0GVTLGHL5yb3pDpIAhVKotEXi4Y2EHgxHDIhHQOYWPrhmQqSUMkkiIEB9rK0zDcMoeO442GgM=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by PH0PR18MB5815.namprd18.prod.outlook.com (2603:10b6:510:16b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:17:49 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 09:17:48 +0000
From: Elad Nachman <enachman@marvell.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net v2] net: prestera: validate firmware header
 length
Thread-Topic: [EXTERNAL] [PATCH net v2] net: prestera: validate firmware
 header length
Thread-Index: AQHdIPefOZ/OTVhKUE+U7L1KNXWh67aPM+ZQ
Date: Wed, 5 Aug 2026 09:17:48 +0000
Message-ID:
 <BN9PR18MB425186E93DEDDC829BD923C2DBD32@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20260731141500.1-prestera-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260731141500.1-prestera-v2-pengpeng@iscas.ac.cn>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|PH0PR18MB5815:EE_
x-ms-office365-filtering-correlation-id: 02c3cdc1-06d6-4df0-9634-08def2d26b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 r+LdoeSFcSB/6NXUpXb6BkEIP2fFNzb4Qtw50EjFcVCfNTLNn3+MEQnT6wODoGL/OAcCLYM0rRV2VYyVYVafUA+kmG4omWeQdL2kVtt2MS8YrRMZMN01ASoBuMf4nE4zixv5DPMLXpHI4chTqKDGhgNY7pDA1YFe+LcJJci1k+A2kN9+c4gVd7q2MPZSgv0GyOFBaclWnrX9Hd0SpBFM+61LGmaBhmTcTHhiwmkb+OWQWDeqAQBN733dR0bQtNTWcc98HSsJmjNia1aoa8P9XtZoyDCRJROHQbfRWwP8IqvBUSYQJkMLKCvLoW4rdllpqzw2hoC0L/vugciv0q/Lha4daba0otAuGKHiwbF6pfzHgtrHcpCNxCKjReMhVPWBGMMJ0Co3cBfDEWjNt0bKB6vGak13dQjnwtufGqU80B0BWllY9OqDzMMXWZpM3hN8mluZt0SIKVSHLvgX6jSJ95GLn+18mAYFRlhOmKd2SyIxORhLbgwicS1lvVitJrxW1n/fXZRNpONwPol8+eJ3BnLg8fvpsc7ePeHwpLs/+MOAryOLPMcyNZHzLVvSGdB08Z+AYtAKpG+jTFryU9OgOL2LjGlqTjI3OccIOfp4UvFfQvC2jc7m4VNSvFSVdgCM/AJTSOoN4u74Z0BcapvkoPmogJhY9uWBhzewNjqaOGf4jzGO/xyEYyKJ7phpI41DtQqKwAFgQCqLqDF17T7miA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmVBQVRmNjVkTGROMVNOTnByM2dPTHFmRDl5WlRvRnNHcGtoNFhnN285bUJQ?=
 =?utf-8?B?RHVFQlN0WEVjcG9zOE9LZTV2WTZCNVhvTXBrajZqWXIvQ0Jzb2ZBWC9YSTRY?=
 =?utf-8?B?aXoyVUgralhlZVk2WGg5bjlYb3p4MTFoMmZsWlc2M2c2cU9TbTZnbmFiZGl4?=
 =?utf-8?B?bmlaVTBGUmtrVzdtVGlrL0Y4SVI5aEtPblgwKytUTEpSM3piRGdpeXM5RThZ?=
 =?utf-8?B?VW9ZUUgzVHpXTWZxa2xsYzc2THVuS2FPc3VHN1VwNEV0aHdITFlNLzZwVGhO?=
 =?utf-8?B?K0t6QmtHKzQ4NGNRbmxjNlppQ21BdzlaejNuNnd1a3hvSUJwcTJsL3plV0NI?=
 =?utf-8?B?aU1hQ3g4OEVpdkVkV3FYYXlxLzF4QkFoTEYwMS95TmpyZzBxTWUzbFpVYUsw?=
 =?utf-8?B?dVV6UVYzZTNKZms4WUVwVk0zYVJ6OVN0Q1V1RVVSRTlsUjdVYzdnRWFJQmp4?=
 =?utf-8?B?ZDQ4L2twRFBEOHprRVhRVGlBRG5reGVkTlBQeGlXT2RaVjAwbzNoQmhuaUNl?=
 =?utf-8?B?T2lHYjlsVDlhK09pTHRaRlVTNlNEc2kyY08vSDRzazQ5aG9sbFRBbC9hNTJN?=
 =?utf-8?B?MzJNSWlidFNXc1NlVWsvNGxSWUtlQWxqeDZOMkJmWnN1dnR0VGNFUEZUU3Ay?=
 =?utf-8?B?bXVRQmtvdGNOd1J6RmowRURyOGhtUVNDcjZnMkVEd21HSEVqQ2JEcHRuQXM2?=
 =?utf-8?B?VDRPUFE3NGVHMmVwaTF0ME80M1dKaVVrK3oreVZKbFFneWFjRm9Na1JDQVhD?=
 =?utf-8?B?dllRb3I1OGtEWlpLd1AvenJmckpJc1Nlckh5eVF4TTBTckV1UytqVi8yU20v?=
 =?utf-8?B?THdvakVyalloeStRRisxeVRBdWVrb1ltZ3lPRDJmTjN5T1NQcjBkT2c3UXhm?=
 =?utf-8?B?Q0cvY2xTbWl6bFcvNmgxbG9JbDlKTUhnUVNWd1ZwL0tCaUZmckFXOTE1V1dl?=
 =?utf-8?B?TDBRcXRNN1RRMzhOZW5iV1BtRjJzQnN1SjJ3S0VDK1VSWFNiT1FXY0IwQWh2?=
 =?utf-8?B?RXBXbm1vczBBbjBTYXNRODgyYzFXZ2Vtc1dxQzMzZVF6MllRb1pJalBmQXZ1?=
 =?utf-8?B?aHZwRHd3N0R1eE93U2gyeWlkaldXMGNWOWcrS2hraUhOUkdUaFFaSGlFK1dp?=
 =?utf-8?B?WTBHMlJEMUpvTFk4WGVweU9DWG9aQ05hMmVwYXYvN0xzR0dKdkFqeWFWakR2?=
 =?utf-8?B?UTdzMTdQVzdYeGFpeElnbUtEMTlLZEM0OCs2dkVGc2ptVHRIVzRHWTFwbHZz?=
 =?utf-8?B?SEd5RG1zcUhsMnc2cGRZZlNOZkVOY1l5a0NmME5mekpURDZUbTBNU1o1K3J2?=
 =?utf-8?B?RkdwcFhUYTdNampIWmlRL1VnbnJNY0FJZmVWbTVVNnBiWi9teDFLcE9XZTFN?=
 =?utf-8?B?RERYNURvRWxOMmxaQWgyVCs5eGE1VHhNc3RWN29tU3Y5ZkFUMWtSVW9XRXo4?=
 =?utf-8?B?ZkNrNTlFdk9HbXRqdm5vUEc4YWhpeStHYWZWeU0xZG9LcE92QnR2Vm1zWHIv?=
 =?utf-8?B?SzV3SmJQWHNhNnhDdndoWmJKSXVkZVc5ekJzTGdaRzZlbUJlZ3FDL00xMXcw?=
 =?utf-8?B?MWtJSmpDWUhDK0QrcUUzUmR2cFJSNzc1NmNKNFdDRUhGRHJPMTBvRU50QmV5?=
 =?utf-8?B?UlhEb0VveEY5YzlnMG9ualpMNkVrRWpXTUVFc3JFbnlUM3ZRTk1oLzNrb2w4?=
 =?utf-8?B?ODF3bk5JZ2R6V0dmZ3dSVk41eFBqUEl4NlVyZkdJcnpMUldxYXgySy9LYnJa?=
 =?utf-8?B?UUEzbmczbm9YSlNaS3RGMWRKaVlYNUJDSzE4bkV2YmR5NEtHSjVlRERzVWhT?=
 =?utf-8?B?WHZzWWozdkVNd0R1SzIwQVdRa2JBZ3JHZnBVNkx3MklyZk4wMFV2Njg0SDJ6?=
 =?utf-8?B?VTFQOWN0eFNjckJCaXEvUVJxM3Z1cm9MUW5RTGk4bXYxdGdpUExlbHZrZlNX?=
 =?utf-8?B?TnRiVzFDNkhCYmJYRXl5Z1FrK3d6aTZCdFBvbnZpOVVmYWZWNWNpcGhOUExR?=
 =?utf-8?B?OEsyS2NFRGRlcW5SZ0w1RmJHZE9EdG4xd21OQ21jTU9xa2FRdGpIU2ZFbkxP?=
 =?utf-8?B?UDh0MzdzSXZ3UzBQTlFURXBReDZ0T1Vzdkx0UDdpOXFFVGlSbGxvQXd3Q0ti?=
 =?utf-8?B?OCs0T3ZCK0EzMWhrSnhkQjNyNU9JcXVYczhIOWYxYTB5eGJCWjdmb1o0U2d6?=
 =?utf-8?B?MUpCV1FDakFIUnN4ZVRmbGZBR0tzZnVUM0h5K0g2a2dLcUpxdWk0aW4zR3N6?=
 =?utf-8?B?MGdpUkdYQVMveHc1dFBuZUZmWm1xWkJVN2tnVlh2dCtUZjF3ajZhaDRoR3h6?=
 =?utf-8?Q?8F+XGmuVjgEENO5I0v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iJEtaEzhB2unJ59RUsqWHJFVKHO5XQhwSDLMR775ynJY415We/3GCVtKsoyfShb/+bCUhrDiKdli5m+ft4n/FeCOaIO+Q769yH0A+MelD9jcypJpVGwOiQLaW3cZB3vbngy8Enq/FPnMNtEU1+VWRxsWnqZguJwp6zFdEFgC9E9Q6Y+yyrPShY2u+wCafJY7PKEdQAO91vkJrY21OLhRA5cu3exq7EDrRICiU9AjbqDZz7c46STzKFdlGp2vz2P7UeHs18KbVOSZsFSE5eXRRX28BDAHklZDWkl6W4K0TxKBsMmHc9+sx1hN4UuKkt4gjWxF+XbvdNRTrQYEwWi+hw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3cdc1-06d6-4df0-9634-08def2d26b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 09:17:48.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhAefutvrICDFytyLTzBnW8KTA1xPIWrx7EAa1YITIhBc1ZQyANptj+E8NEDRK2xxrzOYKrXB/V75rhVQJht2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5815
X-Proofpoint-GUID: iwKW9toEPQqePtT62WkBwl9vUvyp_FiA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MiBTYWx0ZWRfXymhXIANbAZUm
 8MjI2aRpI3g1ZMldy7ob9r6krpI1hqK0sWANJhblJ5lJdklc+5d7P9vXaCXr0KvySxkJRE6eG0L
 iiubJWOhUdyKagKtRFqo1YLRnYAFPZU=
X-Proofpoint-ORIG-GUID: iwKW9toEPQqePtT62WkBwl9vUvyp_FiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MiBTYWx0ZWRfXwQLkmyQvaF/k
 bU8m8Y8JU/I4NZCvjVRNgTDkoLJCqtkV5XZo8V0Q3K4A/rjjl+sGjaFODstBWeCiZoszTxQvkC+
 xgol+vC4ciU9o8EWCgo9XMg5PSIk0dLlOMQjKWvbD0KvZcIPqOItoywZFe5IM+jQPedpmLC6WYr
 FNIuKyYh1sIQeOWzZgDtUqdDUDVSW9qMME5ZHyTqPyZ9EOop67Rn/rGr5FrBIDD3pnEttGYfZE+
 abzD4yMDwKcQN9xG12zklamy5pgrJAIb15xt1flrS0VLsHUYm7CLMJbde0eRNWhiVNM1WIC2uDE
 rBRHPWOWIaXQv1KHDA0P7wDdj+hYuveUKcXMSViU13DZ4Oo2hXCFiVcQkK0L7IVg3booL/8eJgn
 fM1FSs+tK38M88ZC6CfWS91v+mN4p2So1xTiLh7Gd/AQrp+loNuOJeulc5US2zq6B72LxjOZ+Ts
 OhcCZMNXgecV1KTKV/g==
X-Authority-Analysis: v=2.4 cv=fdGdDUQF c=1 sm=1 tr=0 ts=6a72ffc0 cx=c_pps
 a=0/0ATQE1JRcUx1QjezCFVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=53fTOkpDZIen14EW-cwA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01

Pg0KPg0KPiBGcm9tOiBQZW5ncGVuZyBIb3UgPHBlbmdwZW5nQGlzY2FzLmFjLmNuPg0KPiBTZW50
OiBGcmlkYXksIEp1bHkgMzEsIDIwMjYgNToxOSBQTQ0KPiBUbzogRWxhZCBOYWNobWFuIDxlbmFj
aG1hbkBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQg
PGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsg
UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nh
cy5hYy5jbj4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggbmV0IHYyXSBuZXQ6IHByZXN0
ZXJhOiB2YWxpZGF0ZSBmaXJtd2FyZSBoZWFkZXIgbGVuZ3RoDQo+DQo+IHByZXN0ZXJhX2Z3X2hk
cl9wYXJzZSgpIHJlYWRzIHRoZSBmaXJtd2FyZSBoZWFkZXIgYmVmb3JlIGNoZWNraW5nDQo+IHRo
YXQgdGhlIGZpcm13YXJlIGltYWdlIGNvbnRhaW5zIHRoYXQgaGVhZGVyLg0KPg0KPiBSZWplY3Qg
aW1hZ2VzIHNob3J0ZXIgdGhhbiBzdHJ1Y3QgcHJlc3RlcmFfZndfaGVhZGVyIGJlZm9yZSBkZWNv
ZGluZyB0aGUNCj4gbWFnaWMgYW5kIHZlcnNpb24gZmllbGRzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQZW5ncGVuZyBIb3UgPG1haWx0bzpwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+IENo
YW5nZXMgc2luY2UgdjENCj4gLSB0YXJnZXQgdGhlIG5ldCB0cmVlIGluIHRoZSBTdWJqZWN0IGFz
IHJlcXVlc3RlZCBieSBBbmRyZXcgTHVubg0KPiAtIHJlYmFzZSBvbnRvIHRoZSBjdXJyZW50IHRy
ZWUNCj4NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFf
cGNpLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9wcmVzdGVyYS9wcmVzdGVy
YV9wY2kuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFf
cGNpLmMNCj4gaW5kZXggMjk4OWE3N2UzYjQyLi4xYWQwZTYyYTg0MzMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcGNpLmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9wcmVzdGVyYS9wcmVzdGVyYV9wY2ku
Yw0KPiBAQCAtNjg0LDYgKzY4NCw5IEBAIHN0YXRpYyBpbnQgcHJlc3RlcmFfZndfaGRyX3BhcnNl
KHN0cnVjdCBwcmVzdGVyYV9mdyAqZncpDQo+ICAgICAgIHN0cnVjdCBwcmVzdGVyYV9md19oZWFk
ZXIgKmhkcjsNCj4gICAgICAgdTMyIG1hZ2ljOw0KPg0KPiArICAgICBpZiAoZnctPmJpbi0+c2l6
ZSA8IHNpemVvZigqaGRyKSkNCj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0K
PiAgICAgICBoZHIgPSAoc3RydWN0IHByZXN0ZXJhX2Z3X2hlYWRlciAqKWZ3LT5iaW4tPmRhdGE7
DQo+DQo+ICAgICAgIG1hZ2ljID0gYmUzMl90b19jcHUoaGRyLT5tYWdpY19udW1iZXIpOw0KPiAt
LQ0KPiAyLjUwLjENCj4NCg0KQWNrZWQtYnk6IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFydmVs
bC5jb20+DQo=
