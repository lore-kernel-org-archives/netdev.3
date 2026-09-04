Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912D378838;
	Fri,  4 Sep 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501803; cv=fail; b=gwAmwQWjpOKwjh0BsX4Xg5/bAXLvffSFkx9ze858lH8fnL0rwzb2zIWnXPTJ7Mfz6A2+kOu8uTvGoFoCHDrkUmHCAlyozUYS3MBJMDOqxdL/nxQjNWV5Gar9wvPKzvSYEVL3kSVkTewaPcwvfK9ySnEjXwB4pWT4LElKMFn3FKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501803; c=relaxed/simple;
	bh=m7FMEG56dFwIdiksvg30lOHrO0F4+euf3MoG3wTuSq8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=RatBBdgIyQzOsXvkSJ98V+rJICFzR+qsbwqT2XcpxZhFPy2GMbWfcZSHPsj4e7MnlTwXEFFcQhR5i+HkjB+PFF+76sCz7pGFlo2SB6KuqOs/l2k68pfaPiTdjTrgLl0I/6Us+WChtDLeEKtobq8IuOKmxCcKe3QZePTNu2nHF8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=y228ltE3; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="y228ltE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW2YLHKDjZHvbXwwmBkl9RmjmjFg7chs8zawed4Y2WPioeltXdRiVQGW8mRI4KyF20g/L7/hERYXFIgyNd1J0w0VGrF9WvSxp/ZWFocnTzQ9Wu0m9UwGpHu8JLfiGGXMwfEG52OV/HSEsBY7T+OzaxfvJQ7HfGif5E3BJkdjIcF+oUHuH1u8ReBoWE5ZZ73xwffIjIIWfjUtKLImiGVXHBSy7OsCEE1Ry3Bq6Hp8ZC0y2yFBqEx+IWZtlZSTaGFi6xgAxmuzZD68Rx+bWQMVFy8RI2NJEM3g/yliJxHvQ9mdMXs0fKw0CFkUv+gQ+B9ItWhXqR9K/AVEDxAhOQoc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EziipmNAy9kUnsH8Zgyg/YeiosH68ir6Syat1OQmUI=;
 b=urUwe/kWqw3tHkkhGw0niiUVDWkkImJJERT3ztCxVGGRZkLZX+RSTkxlLini558zVUCFdGzXeSaPT56VJtXi6JxwVwmQene13zziad2iHeTDk18DK2TcS/dOLGm+ggOGaupenDYNJJKU1RlaiCbve+MqbFcbQiFO/HGdaRENEo3E+MoAABPf6TaGLEZDuR9Kf6UY1BNGopQ2oUYyHWJhKoSj8wHhWuJd1wolLCzMagLxvCIP3e1R95tlfAxddDugE/qhaAjWmMImD8ZRsnLyz9U+7DpCm2hr+FgjSwoJ2WTxV9QJC7jFvqaK4+7vGjXZjzNWLpJ6dSSE/R1P+J5XWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EziipmNAy9kUnsH8Zgyg/YeiosH68ir6Syat1OQmUI=;
 b=y228ltE3CHUAm3ujXR9Nh1/lilHPODyW+6jB9UzpssLGzZR+jwU7tVdsENNCPZDNA8R6P1zjR76LGyMshngnfUjkyFFTFdz2zZshYkQEfVMBKY1Loyncx+C9fpKMdyvzEhylyN/5WDaaTPmv+UQQK+DIy+mx6DV2rxRVcwa3iz1r0yUtDjkhGJjD3vzaPVQexkACqGBEHSWLehyo6LgTVFn/scudcB47g3OElhsgMLh7fOBvNir8XHFqA0P2S8JtFCjQtyTUeE2tiPzC6Jyq3vjIfZ7GgrHTcDeDr55IhXcexcnLlsloaQJoNIOw+iwnsRuVd6dNWEQQGNryLWkKgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PR3PR06MB6825.eurprd06.prod.outlook.com (2603:10a6:102:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:03:09 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:03:09 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 04 Sep 2026 06:03:00 +0000
Subject: [PATCH net-next v5] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
X-B4-Tracking: v=1; b=H4sIABNfmmoC/33PQW7CMBAF0Ksgr2s0M3ZihxX3QCwcPAarJUF2Z
 EFR7l4rG1ChXX59zRv9u8icImexWd1F4hJzHIcamo+VOJzccGQZfc2CgFowoORn/u5sZ2Q+nmO
 UlzFNUlvvewRgwEbUw0viEK8LuhMDT3Lg6yT2tTnFPI3ptnwruPT/wQUlSmUNm1aR99Bvi4vZf
 bn1YTwvYKEHYhHfIlQR0I7JGgc9mVdEPSHqPaIqQsq0zmn2AfEV0Q+k+2OOrkijrO8pBA70a84
 8zz/fpIUZjwEAAA==
X-Change-ID: 20260703-ksz9897-sgmii-port-48ddb100e015
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristram Ha <tristram.ha@microchip.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Jerry Ray <Jerry.Ray@microchip.com>, 
 Tristram Ha <Tristram.Ha@microchip.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788501788; l=9838;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=m7FMEG56dFwIdiksvg30lOHrO0F4+euf3MoG3wTuSq8=;
 b=D4hluc7IpKtqXPTognxaXKVhpC/mGjlGuavM1rsMK8qUV7r3K5o6VSlznZL4BF4ZjqyMLG4El
 C5BLDZLLNNDDOUIHi0I871DRlDFZfFyXOvsopcnvuAI2zmd6roxCjAR
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF0001A334.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::699) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PR3PR06MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d09f92-50a5-4496-08e7-08df0a4a3201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|23010399003|10067099003|6133799003|18002099003|56012099006|11063799006|5023799004|38350700014;
X-Microsoft-Antispam-Message-Info:
	87dUCVNkNE1WepNqZlZFF7X62sqCEx3rjlPko4cSQ333TYovuA5FLxha0SGa5gjefCOyirWJA0zJVcDq9SiJgoCJVG3lLeS4MOsLS4buG2iOzudImp+4Hdbi1tIHzbLgGKEwQ5PStJ13Fu6oJx2Ae96IV35e5iHq30cdKk7zKXoRW9EJoYR2h+oZs+mWSmvZTzxMzdDNRlyOaRO3QxXLsOK9ABdTm3lnTDZIhnstb6SsJVckT/6XzJkF/Dw1e0dw5xoJ499jECEK6GZevtsLGWGzbzN4GLdDp+9vXBUuwLvZCvpcdqEo1SY+7jW95utu7OHQkffMiyz0KKlyV3J0aqqSxYH/zPqUzsIw+D9usLUTSDCezvtAorBCrhafCoz9PBq4iFcAGMb7u4I58ri/+bJkLz4+o9RY0NSQjNRp8OfZnjhOu+0ZyW1PPKO1uvCG/bHBvdiEJz8LD2ldw04d3Jsrq+oO/ZI1Id7IVIAr8xb0I7+nbZYJ4FKCjVEZhKRHf2fLi1+7b6ojYz96yZlnmmIkOtOjk9AqRI5P9402KhHE7NcO1pKNtCqBCGOOQRCuPDjVXsVEL0nnCSFD5Q5IK/jktY/L63btGWLWBbF0jjy5k3ty8G1wbrySw8IryItOkpklcv/6x/v1uxWh4Ud+DI+eE+9vm3p5ftFWtzzmBQ9XCRxMA+hug5MxkFU24UyaL6jSg4pPvZTfB20EdvBVKclsE43eh75cJrUm/LbDn3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTlUT1hZelUxTGdyakxTTG1oQjAvZzI2V2NnaFJYZHExbXJqRmNzWlJhd3k0?=
 =?utf-8?B?ZXB6RElrZ1I5YUhrU01aU01ucHh0eGtRWE9PNldncmtGaHoxN1hIMTRVc3BE?=
 =?utf-8?B?bXlVck5COEY3aTBaS2kvNXVFSVJWUDRBRFdTbGtZOUVWbnI3eHBCblU2RGsz?=
 =?utf-8?B?MFRNWTZuNzhVTW5aWTRId3NucEdpY08rUzhyR0t3REFlTnFUTzRKU1dUSG1F?=
 =?utf-8?B?YWxtbVlNeG1WLzhLWStQaTlTZUxONlJoOWJjMU5nRlJtTjVuYll5dld0cWJj?=
 =?utf-8?B?NE5lbUtLcXo5QUlEbmtpRHVXSXA2N2VUUHR0V1RsTXRSWEVROEgxeDNHeXF6?=
 =?utf-8?B?Y1N5TDFUM1lxeDZIVnlrNWZ3VFEwYnhmdE1sd0dhNzJ6cGgvcXBwS3R6R1Yv?=
 =?utf-8?B?ejBYQ3hRWTBDQzg3dm0rbzQ2SGdqaDdRU2Y5L3FVZkhBTTBwWFB4Tm5iNXNn?=
 =?utf-8?B?bkwzZC82bTRSM3paS3NxMUkyM1l4V28zaTZTeFJzTWhSNHVUZWxrYjRlZ2ZO?=
 =?utf-8?B?QStuc2RnSzA1YmRkd3BHUEJMcEN5bi9nQWY1bjM5WWpueG5sRHRwYzRTVnEv?=
 =?utf-8?B?eDl0RFJXaTRnRXVEcDBpZ05sTlJpWDlzMGJjdUxMa0N3alhZaHIxRjkvUWZG?=
 =?utf-8?B?ejlCeGFFc2U2UlFlWGZlS2tvakYvemNmVk9tM3ZvaXVnVEdGQjM3SFN3Z0dK?=
 =?utf-8?B?dFlaMnRTcExxMlhFczlmRHU2eGdDd3hYcVBoSUJpc2xzK3dsQ1VyKzBmV2tI?=
 =?utf-8?B?RWF2ZDhzVStYSEtySlJYZVJpY09WZUxLclBwREZ5K2ZDa2ZRdU00ODVNRU9Q?=
 =?utf-8?B?Vk94N1REYTlBemQxZnBQS3JUSVBwZ2FWRXVQS1dkQ0ZCR1h2YzBjNmJjcXJE?=
 =?utf-8?B?ZDdVNkhNNHN0azJzbDRSRlRDOFdPVEU1T21iNGVBL2llNHcyNktweHhxWi9w?=
 =?utf-8?B?aHhTZC84OU0zN0k4ajNCeGwzakZiU1FUd1E1K1Y5WUN5RitvVDRid1Ura21I?=
 =?utf-8?B?K2U4UDcrcUc2bU5ybTNtS2pVTlR5L0JQYkplazBaZlNkN1oreW90bXFKVTlV?=
 =?utf-8?B?Q3BUVktFcm9uNkVLWDVkN1BVT0dUWXNzejBKSmhzYXFpYm5PRm44TGpYaHEz?=
 =?utf-8?B?S0xGcUNHL0duK0M3MEhGbERqUzdSZDMvN0xnZEt5aWZzc3B4NFNrM3JHRUVT?=
 =?utf-8?B?aXF3NmFuQnlqeWJoR1JadkZENjNOd0VnMko3VStMWGJjNS9QUTNhWXRCZ3VV?=
 =?utf-8?B?cXlFVmVjck9ralFLVWhkcjlzTGY0S3pDZklva0hablc1SVIxdUdXYnRYNVVG?=
 =?utf-8?B?c29lV1dMWU9XYnE2WWo1eW5sekFTNzZRSVc0SWNDUlFRMTFtZnFBQVVuaElJ?=
 =?utf-8?B?Zk1OK3ZTbHZGUnUxM21QWTNIUXl4VFlWVnNZTFJ0RXEzeThheVExTHhKa3Np?=
 =?utf-8?B?QVp1V0pHR1NjeSt1NTA2UytBcE1SeEJvSXBmUGM2bU9JRTA1c3pPekt2d3dI?=
 =?utf-8?B?d1FoWHcrY3FHbm1lSUJERTQzQ0RxVmp2K3NyeCs0Mjd0bG8xMFFuY2F0SUdT?=
 =?utf-8?B?SlplWUUrT2dhUGV2bzBrc2lEMS96cHkxdWFCdzFYUkN5V1ltR2w2YUZnZHB6?=
 =?utf-8?B?MFV6QW1UWVJYRVk1eC9CWVdhSy9PcHhoRFMzOU1YcGMrU3NJK2pnckFEOHJ3?=
 =?utf-8?B?VUN1dlJpdks2SytYaWNYVjhtVWpQRTd3SnRSdWRDOGQ2TGxEQTY1dTl2VzNy?=
 =?utf-8?B?SHR4bXlVVlFOVWhscXo2dE5yajIvQ09sNmtwN1JuaUNJUXU2V0hCRUlDYlh5?=
 =?utf-8?B?MFpVdnRick8rZWdUbENTc0lOSXBZaEtHT3NoWTJLNE9wbURWaXlGbEduc3Ri?=
 =?utf-8?B?ZVRLeU5POVphK1o5UTl2NU9rZmtpTGY2Q2VXbzZOVlJPeWlvdzQzblVVd1dt?=
 =?utf-8?B?V2lWMVpDbkpPYWM2ZnB5VFBVTGw3enVwUStYOVQ3c3FyK1ZxK29HTndjSlRC?=
 =?utf-8?B?SGgya0JsRFdaMmdxVmV4b0dRQVF5dkVXbzNPRVR1dG9yM2JnazMvWkVmQitN?=
 =?utf-8?B?NVdJeGJDY0prUjg4b0srSk84VzYwVnNJRTJZQ05iYlZTQldzckJHaU1XQlpF?=
 =?utf-8?B?U2JuVHpCV0dWUlRXbjZIVUZ1L1A5NGRiVmRlVkYranJsa0ppdjJqUjNrTEcw?=
 =?utf-8?B?M1hibmQzdTIyMExaYkg2WDdneHNMN1JXcDVlL0VmeEUxcENoWnVPOHdrVVFt?=
 =?utf-8?B?NUNXWUNnWnFFZWpXWDlQNnZKRUdHaHAvN0JqanFYdkFzbmxoY2pWOWtDS1d0?=
 =?utf-8?B?dmlNR3d5VUpQRkE1b0U1dzFFcndFZHBNTW02TnpXbzJBY3NFK0Y3VFc0N0FL?=
 =?utf-8?Q?JgEhBC8Umh7B+H3A=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d09f92-50a5-4496-08e7-08df0a4a3201
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:03:09.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP6ZQW3gDkQI3pMCWSBYsqA2PKcfYGQSV5TCahM5g3faPB+Ms9XhKCIZrnoj05Uo5XjP9faeTRp2BknNX+dxft33eBXIZUgj5NAyLZZCiD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6825

The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
entry never set .sgmii_port. ksz_has_sgmii_port() is therefore false,
ksz9477_pcs_create() is never called and ksz9477_phylink_mac_select_pcs()
returns NULL for port 7, so a phy-mode = "sgmii" or "1000base-x" link on
that port cannot come up.

Only the KSZ9897S has that port; the KSZ9897R has a second RGMII port
instead. Both report chip ID 0x00989700, so the port cannot be enabled
from the chip ID alone, and enabling it unconditionally breaks the
KSZ9897R badly: ksz9477_setup() propagates the failure of
xpcs_create_pcs_mdiodev() on a part without an XPCS, so the switch as a
whole stops probing.

The variants do differ in the read-only bit 7 of the port 7 XMII control
0 register, which reads one on the KSZ9897S and zero on the KSZ9897R.
Compare the KSZ9897S data sheet DS00002394C section 5.2.4.1 with the
KSZ9897R data sheet DS00002330D section 5.2.3.1.

Read that bit in ksz_switch_register() and use it to select a KSZ9897S
chip_data entry, which is the KSZ9897 one plus .sgmii_port = 7, with
port 7 no longer marked as supporting MII, RMII and RGMII. On the
KSZ9897S that port is permanently an SGMII port and only its
differential pairs are brought out, so advertising the xMII modes on it
would let phylink accept a mode the driver never programs:
ksz_phylink_need_config() skips the XMII control registers for the SGMII
port. The KSZ9477, which also has SGMII on port 7, is described the same
way. See DS00002394C section 4.11.

KSZ9897S_CHIP_ID selects that chip_data entry and nothing else.
dev->chip_id keeps the KSZ9897 chip ID that both parts report, so no
other chip ID comparison has to know about the variant,
ksz_check_device_id() is unchanged, and a device tree naming the KSZ9897
keeps matching whichever part is fitted. No binding change is needed and
existing device trees keep working.

Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7: bit 7 of
the port 7 XMII control 0 register reads one, the switch is identified
as a KSZ9897S and the PCS is created. The port advertises
1000baseX/Full, clause 37 in-band autonegotiation completes against the
link partner, and the link comes up at 1Gbps/full duplex and passes
traffic.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Suggested-by: Jerry Ray <Jerry.Ray@microchip.com>
Suggested-by: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v5:
- Keep the KSZ9897 chip ID in dev->chip_id and use KSZ9897S_CHIP_ID
  only to select the chip_data entry, as suggested by Tristram Ha.
  The variant is now resolved in ksz_switch_register() instead of
  ksz_switch_detect(), which drops the ksz_check_device_id() special
  case v4 needed, leaves both of those functions unchanged, and keeps
  KSZ9897S_CHIP_ID out of every other chip ID comparison in the
  driver.
- Link to v4: https://lore.kernel.org/r/20260903-ksz9897-sgmii-port-v4-1-538db2ffef2b@vaisala.com

Changes in v4:
- KSZ9897S: stop advertising MII, RMII and RGMII on port 7. On the S
  that port is permanently SGMII with only its differential pairs
  brought out (DS00002394C section 4.11), and
  ksz_phylink_need_config() skips the XMII control registers for the
  SGMII port, so phylink could accept an xMII mode that the driver
  never programs. The KSZ9477, which also has SGMII on port 7, is
  already described this way. v3 inherited the KSZ9897 values, which
  are correct only for the R, whose port 7 is a second RGMII port.
  Flagged by the netdev Sashiko review bot on v3 and then confirmed
  against the data sheet.
- The in-tree LAN9646 entry pairs .sgmii_port = 7 with the same xMII
  advertisement and looks wrong for the same reason; not touched here.
- Link to v3: https://lore.kernel.org/r/20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com

Changes in v3:
- Only enable the SGMII port on the KSZ9897S. v2 enabled it for every
  KSZ9897, which makes a KSZ9897R fail to probe at all, because
  ksz9477_setup() propagates the xpcs_create_pcs_mdiodev() failure on a
  part that has no XPCS. Reported by Nicolai Buchwitz.
- Tell the two variants apart at run time in ksz_switch_detect(), from
  the read-only bit 7 of the port 7 XMII control 0 register, and select
  a KSZ9897S chip_info entry, next to the existing KSZ8765 and KSZ9563
  variant detection. Register suggested by Nicolai Buchwitz and
  confirmed by Jerry Ray against both data sheets.
- Accept a detected KSZ9897S for a device tree naming the KSZ9897, so
  no binding change is needed and existing device trees keep working.
- Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7.
- Link to v2: https://lore.kernel.org/r/20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com

Changes in v2:
- Resend only, no functional change: v1 was dropped when the netdev
  patch queue overflowed.
- Rebased onto current net-next.
- Link to v1: https://lore.kernel.org/r/20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com
---
 drivers/net/dsa/microchip/ksz_common.c      | 61 ++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  5 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..81798a9fa671dbb490cef89e0b18398242879068 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1486,6 +1486,41 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {true, true, true, true, true, true, true},
 	},
 
+	[KSZ9897S] = {
+		.chip_id = KSZ9897S_CHIP_ID,
+		.dev_name = "KSZ9897S",
+		.num_vlans = 4096,
+		.num_alus = 4096,
+		.num_statics = 16,
+		.cpu_ports = 0x7F,	/* can be configured as cpu port */
+		.port_cnt = 7,		/* total physical port count */
+		.port_nirqs = 2,
+		.num_tx_queues = 4,
+		.num_ipms = 8,
+		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 = true,
+		.mib_names = ksz9477_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz9477_regs,
+		.masks = ksz9477_masks,
+		.shifts = ksz9477_shifts,
+		.xmii_ctrl0 = ksz9477_xmii_ctrl0,
+		.xmii_ctrl1 = ksz9477_xmii_ctrl1,
+		.supports_mii	= {false, false, false, false,
+				   false, true, false},
+		.supports_rmii	= {false, false, false, false,
+				   false, true, false},
+		.supports_rgmii = {false, false, false, false,
+				   false, true, false},
+		.internal_phy	= {true, true, true, true,
+				   true, false, false},
+		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
+	},
+
 	[KSZ9893] = {
 		.chip_id = KSZ9893_CHIP_ID,
 		.dev_name = "KSZ9893",
@@ -3897,6 +3932,7 @@ int ksz_switch_register(struct ksz_device *dev)
 	struct device_node *ports;
 	phy_interface_t interface;
 	unsigned int port_num;
+	u32 lookup_chip_id;
 	int ret;
 	int i;
 
@@ -3933,7 +3969,30 @@ int ksz_switch_register(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
-	info = ksz_lookup_info(dev->chip_id);
+	lookup_chip_id = dev->chip_id;
+
+	/* The KSZ9897S and the KSZ9897R report the same chip ID and differ
+	 * only in chip_data: only the S has the SGMII port 7, the R has a
+	 * second RGMII port instead. Bit 7 of the port 7 XMII control 0
+	 * register is read-only and tells them apart; it reads one on the S.
+	 * Compare the KSZ9897S data sheet DS00002394C section 5.2.4.1 with
+	 * the KSZ9897R data sheet DS00002330D section 5.2.3.1.
+	 *
+	 * Only the chip_data entry differs, so dev->chip_id keeps the shared
+	 * chip ID and nothing else has to know about the variant.
+	 */
+	if (dev->chip_id == KSZ9897_CHIP_ID) {
+		u8 val;
+
+		ret = ksz_read8(dev, KSZ9897_REG_PORT7_XMII_CTRL_0, &val);
+		if (ret)
+			return ret;
+
+		if (val & KSZ9897_PORT7_SGMII_SEL)
+			lookup_chip_id = KSZ9897S_CHIP_ID;
+	}
+
+	info = ksz_lookup_info(lookup_chip_id);
 	if (!info)
 		return -ENODEV;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c371ee22b80f9508c3b35b8d6291a..0cff33df06a4b8ca585d94f9fe437ad62bcd82dc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -284,6 +284,7 @@ enum ksz_model {
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
+	KSZ9897S,
 	KSZ9893,
 	KSZ9563,
 	KSZ9567,
@@ -874,6 +875,10 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define SKU_ID_KSZ8563			0x3c
 #define SKU_ID_KSZ9563			0x1c
 
+/* KSZ9897 specific register: port 7 XMII control 0 */
+#define KSZ9897_REG_PORT7_XMII_CTRL_0	0x7300
+#define KSZ9897_PORT7_SGMII_SEL		BIT(7)
+
 /* Driver set switch broadcast storm protection at 10% rate. */
 #define BROADCAST_STORM_PROT_RATE	10
 
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 028781ad40593248bae1b501e40ce31c5e0c69ca..fe8df1774289c401445ef308c8d3656e1e7c25b6 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -34,6 +34,7 @@ enum ksz_chip_id {
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
 	KSZ9897_CHIP_ID = 0x00989700,
+	KSZ9897S_CHIP_ID = 0x00989701,
 	KSZ9893_CHIP_ID = 0x00989300,
 	KSZ9563_CHIP_ID = 0x00956300,
 	KSZ8567_CHIP_ID = 0x00856700,

---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260703-ksz9897-sgmii-port-48ddb100e015

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

