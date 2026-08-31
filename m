Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11B3C9EE7;
	Mon, 31 Aug 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788153054; cv=fail; b=W61rQ5vErhg4gIQJ98I+K7uibML/0sotpZzizg7zpS0F1cf3QQcNvSEH44baqOYagf8XbHqs96iy/g/7Y4sIge8s6Z8A0fJfMseS/tB43/7B/T3DthaoQiF9u5779eUlExt65ZeGmvEjovcLAxHN4aVwaDlrbTEvF1Tn0VMXcUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788153054; c=relaxed/simple;
	bh=h+KROVydj78W9bg08TRxlG5ItrmHyQO7jvOAv6M/kRI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=dD6zNzcEYgnApaqnR8PsQo/TVcLPCD6fuytod4ip/pORoHe+bCfqQKA0V1jdWc8Tham/6kWHfTluLDntfaSyXXYp1ISomfTnxc8q2Cx74+Kp8h/jpKk9t2zFfJVykPeq5vHV7UGvVYU2FpOotg7hUzknfoO+DiXisNyNJnSV7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=RJaC+k7D; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="RJaC+k7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiKgwaDzKsArRjJLeuKlwUgVNY9J1kqFRlgWVEbrlFEvgiD3sbrvrVbLwPpt3cdC7r0oYCGhPyLQ8Jh2q6S6aCRWK8abJXuFtNa/L5q3pNcN092cATte/UtlyRBPOXQtFDi3As8oxoAfyHUdrOh+k/PuaZS/ippMHdNBIBvWrcXggUHQmACjBPDCUOyvRu0cE1/R8WM+anZyL+yjCuFtPReF3Ey/j8GYRpNK5oAk3ITXOXQmjPb79FYhtWg3fOZ+ynpEkSXijzaqJmvzRwTAUnE3iEH5blSp1fXVaAxJbdai3ydFhmxfx3TJJyQZ+2fjXVJGHoPP8/53jr4fHiDmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvsl3s5zfQ9QVYOzurwmlKM32DPxhZSQv9vm2lb+Tcc=;
 b=xqGnsdcMmM71osYhFuHoVJg8onrUg9lKvFtrNzMggfrKMRz3G5/LwQ+X+yhDQLH0YR6nRcvx3Ks4sdqzLLZQZpzkG4Z/F8WLC5/Lgy8cyEVMrdVAhFfMymaBZBF2rpwGPDyrsaoQjxGey1q7I8WMyVUE4pMbi5CSBCsGbPMTKQx9r76vJAAY3DSQnuPryZrfRV2v59nW6lZldX37d8fzaREAJVEIgpwfTtUHW0g/v1I8tadBAvlQ81XnOKttg0f66DjitOm7oyoGJjCn6WFTLzlAInienKeUoNdjWbzvHHJ0VCRiSlcTKMkXeBSGl6bLGOOQhnHTkXv7XpA+a3kv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvsl3s5zfQ9QVYOzurwmlKM32DPxhZSQv9vm2lb+Tcc=;
 b=RJaC+k7D30ZxhF/0ckIfQ8zvzksLQMH7sNEkcM95UcUiSRUCn3GO10VgENwjL8F5j+zFemIw8FFt8HMm1lHNQlbgQ08qYeBd7dCCRAw0LOYve5dR5W4dX4lnqXvw+3Q6zDmA+D4cF2N+MYsf4HvAm8DX991PhWCDrkWAe+Vee3mXUK+1o+rqoSNMNsnb6N78q8N4WDaRM3CQuSLUymBabhq1lV/V2NWht3wU6+mLllD508FZOR68Mr1bf04y7nby5P3ncmGrO9JKQjXzvaYqOt6XsUcDYa+PFFsWouNtkuaaxSDjq6yVkxaxaD5Hz9g9LmvTkIcgsd3qMliDV+9cJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AS5PR06MB8701.eurprd06.prod.outlook.com (2603:10a6:20b:673::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 05:10:41 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:10:41 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 31 Aug 2026 05:10:31 +0000
Subject: [PATCH net-next v3] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAMcMlWoC/33NQQ6CMBQE0KuQrq35bZEWV97DuCj0Cz8qkLZpU
 MLdbdgYE+NyMpk3CwvoCQM7FgvzmCjQOOSgdgVrezt0yMnlzCTICjQofguv2tSah+5BxKfRR14
 a5xoBgCAOLA8nj1eaN/TMBox8wDmyS256CnH0z+0tia3/ByfBBVdGo66UdA6aU7IU7N3u2/Gxg
 Ul+ECPET0RmBEqL0mgLjdTfyLqubyDDz+UFAQAA
X-Change-ID: 20260703-ksz9897-sgmii-port-48ddb100e015
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristram Ha <tristram.ha@microchip.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Jerry Ray <Jerry.Ray@microchip.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788153040; l=8236;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=h+KROVydj78W9bg08TRxlG5ItrmHyQO7jvOAv6M/kRI=;
 b=znSi61ILErsJdsI+6ubei4b8lL3KxXXDdPWsePMz4KTf5bo8b3Acf+L4bAVcT35xmAntkyGdP
 1K1Xowx/ihYDFIG82xXIomUkY8vOJMZNEcPOUbJnsgEcS97P2mIccVD
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0070.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::25) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AS5PR06MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 298ac182-974c-423c-81ca-08df071e33d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|1800799024|366016|38350700014|10067099003|11063799006|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bg3jfj9gn8effxOyGYP2n5mlAW/YzrCIbxkY4gpWq0RYDu6M6JIE9qeLQU+R9xaU/eBJvUi27P+mkxRiwCRQnM8emkX4npoKMYO4rAMgPpbgiWwqjIdM7fHI4o3/0HuV55Sd4bhiislUiMXQUhuGxWXuDzFTwrqPbJx1qqPyg8xYQIUKXcHgxDDicjTwOOyfOGO/YsG3XBmYb+FRafpcd0BX8tFMZEcekm/n0BWkonWiQHyiKuCM0aIsacZnbowrDPbCJzenBP/OQBZYX+/mwM7CwGn7xS8dt63boG9ZYJxEqt6AVV1Z30JnOAqD8ty3IP0Qnj1SPebG08vfCA3jgMRB/hAW61pZ0LAX7y6+P1pJbEczd5ESgpihPqBOPlxqXgniQdZzOex8f3ybGEOhxHb95JZ87RW/WfUouyNEmDLZVS7FBkg5NHvMCrqLI3QfQpDsRiH9ot9xZ4rjfE93AzIXD7cRcF0Uo7Hg2czAszcduULHhNQehgYn5kVm/AnsNenNJrdhe7XD0ZGxRenqC57JNzM6wR5/rLAnVdWOivG1MFtxr8F+hxm4ZfDRFpziAAGhQaC/h9ZtpZDXl3ky77De/LWS4Nrnn6hB+TzrW/y/0pHDyoQ7K3OtEDRTrSuckMhEy8jAGrhfw+K3aV98BWrXai9B4etWiRxr9KzntbtxwZLraPtMmc1k7li2oiOicJZMRqlV33oxPrdkBgXR9yEKzrIYglCMH/81NGg8pdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(1800799024)(366016)(38350700014)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXFXY3h0c25nYWE3R1BlU1pQeEUxdWNVOUUycFFnYnIySTcxcHdsR0FMQnE0?=
 =?utf-8?B?ejZocTRkUWVPM3dUeHJzaVU0ZTBmQVhUeWpiYlA5QlI3aXcrcWNpWTJVaDRT?=
 =?utf-8?B?UUo1Tmd0ekZQWG40eFRkbmFnV0pkSzFwL2RpVnp4VVdxU3VCWEFSUEpVaTF0?=
 =?utf-8?B?ZVhkNXZlL2NsV2plZ1ltNG1SeU1FUlhmNnpwQU5aR1RyQXhKQ1BVNUdWTnQr?=
 =?utf-8?B?RmZmTStjUnJhbnFNeThMUS9HRFZrR0NPM3VCVTB4d2NwYkJBRVNJcWJkaGxx?=
 =?utf-8?B?MWdyaVBWUnQwcURCSWlxenRKMWQ5cmVIMU9YdW1BVmpXSm5IZ25FVzhhODRu?=
 =?utf-8?B?RStZc1B6MmVFYXk5c2s5NlVpZTM1c2kwN2ErNGkvNHU3Qlprb2tHK2FoS1ZN?=
 =?utf-8?B?bFJpL1RRSUp4S3JvRnR3ZUpkWGthc0VQMzQ4ZDA4OUlOQ3FPR1pvalhtTzdU?=
 =?utf-8?B?S0FSU04zNlFCRGZwdjRla2RhVUxmaldmODkxWitBNVJNYTlMeEp3T21UdUFZ?=
 =?utf-8?B?a2Qvam1lY204aVhFZUZtMWV0di9ES0FYUjJKOG8zZk9CMCtxeFNPWWNSeUdk?=
 =?utf-8?B?ckQrUnN5OTNNZDYvNUFXVDB2by9MdEdJSHd1ZzFFTFh6ZW43NGFIQzFGYVBz?=
 =?utf-8?B?K1V6Zk41Vlc5YTcrcU10b3gxN3l1SU9uZlZ6M0NkcS9EbFNRUm1aM1o2ek1k?=
 =?utf-8?B?WGZNVWExeHpYRGpzT0lVSXc0L2NRVVZTQ25RMGRYQXdhOCtsMDRxUDlmZXJn?=
 =?utf-8?B?eTAvMmpNSXc2dFVWYkNha3NhNExuckFqeHJUcnNuTzZCYmdrR04vMTRoRWJR?=
 =?utf-8?B?OXBlWWg2dmo1aHJMVFZidjlScElBVit4MVErMGo4L1RwUmxJbXdoOHlNQlFE?=
 =?utf-8?B?ZnY0V0JFdFlsQUJMbE9SSWcySGVNMkFoS3hMTisrcnpFeENaZnBZdTBOajYw?=
 =?utf-8?B?aXNZTHJjeHFFSFUvTVpZMzlaTnFTZWNqWEFKb2s0ay8xRUJQcExsVklNN012?=
 =?utf-8?B?WEJjL3NnSGpVSXRaRG9PODU3US9OTGEwVnF5NXE3cEZxRk9qSzBKdytHblhx?=
 =?utf-8?B?VnkrQUtnR09lWW5vbldMcDZxVW5vT05FMzgxR3FKbVhveWE3c0hhcjlSOVRE?=
 =?utf-8?B?SGFHM0lvMTNWeVlFSVlxSFAyZFVjNDVOL2dQZ0hXYVgySXhQU25BczRPZ056?=
 =?utf-8?B?NE5nNzR0WlBMdUtaK0hHMytRRWgxckVVS2FOR2ptazJGT092amVzQk5EVUIr?=
 =?utf-8?B?Z2xNNUN4M09IbGNLZU9GTWwrN0w4QkY3UHlBeEorVzlBSktETWpZb28rV2VV?=
 =?utf-8?B?Q0pNQmlmQTVzOTY3NnBOOE1PZElXTU1OM254ZXlMaStEZjgrclIwZGdBMUQx?=
 =?utf-8?B?NVlRRmEweStwWVJ2M1RONS9PMlJhUHVlclNKZTRBTVNQWXZ4LzFGWCtkUUJO?=
 =?utf-8?B?ekRXM0tLSUJVeWtQQloxRnhSSFpUemtFQ0I1eU9VZjZtWWlCNklreGxqNHNO?=
 =?utf-8?B?VXBPdFM0SGY4Sm5QMTl3KzcyQ0d5bGU3bnZoUnJwMzlnSDQzTnd5d1k0ekZV?=
 =?utf-8?B?TXlpcWtqRXZpNXJjT3J5SXZHOXBXNlZiQUFQYkRIWlJIY0RZd2wwK0l5ZVdH?=
 =?utf-8?B?Q24xdi9kMmVwVTl1enpYM1I3STI1V1o1Ky9acnIxbTkxdTFhV1pRNGNtb0ht?=
 =?utf-8?B?bnlwSEhQa3F6YUR1YjJCamsvMTNpTkJRMEtOOTVpMTRkYVEwUklMMk9qQzhY?=
 =?utf-8?B?Z2ZyRWZNaHZ2L0hpTHQrbENBK1dUbkdqM2hxa0ZmS1ZmV1FrYmdSUFM3dTVI?=
 =?utf-8?B?a2VHZzc3blNhOEFvRHNscFNjNnJxZXFrVmVZb2J6NDMxVzdyK1hYYmpEdEZO?=
 =?utf-8?B?Q1U1SzNCTjhnMFdibUZMOGk3VGNEZFlTWGIrRHVzam1sbm1TODlOTmxtWUJ4?=
 =?utf-8?B?NDNWNGQxa1E1enQzK05wZ1hDZkJ6ZUtKZXRLeHlDckl5Zlk1ejU4NVo1Z0hq?=
 =?utf-8?B?V25HZWZMMmc5QVo1MGZBZkY3UEZqZ2xuT0kzSVdPeHI5R1NSMXBhT1VmQUJw?=
 =?utf-8?B?YjdNWU5KbjdnaHNnOUJFY2N6MmVzRG1kbmpXWTZjT1NNSHpwdENISURhcEJC?=
 =?utf-8?B?MmRXaEFnV2ZNV3JxaWRvRVdIMHVlcTVLZE9WTm1raEpYSUlkc1ZpUFZHNmVk?=
 =?utf-8?B?Zkx0WmYwaEg0a2Q3dW1zbDM2TjJVclVRUmVMNWsyMzRxTk1kN3hHR0tnRnYx?=
 =?utf-8?B?aWVnd1RJWnkwM0tuc09WMUZ4MTV2Z2dJbWNPMGovdS9qUGtReXVPQmVGSmtW?=
 =?utf-8?B?K1pyYitHb21UZmFCZFZnd1N1K21wdEVaaGh0RGdpTlZJV3ZQT2M3aEU1bCt6?=
 =?utf-8?Q?jBzN9yKcxCis/SmQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298ac182-974c-423c-81ca-08df071e33d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:10:41.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xukBbuNLe8zOYYiMbFuRJSmpGSPURuvaO8sjn76rYtHBS1KhkmpCHHStLe+FlHFDwGf4pUcUsTf2ZXD1PxyPVTmhp7fUBse+hE+zJd8ietY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8701

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

Read that bit in ksz_switch_detect(), next to the existing KSZ8765 and
KSZ9563 variant detection, and select a KSZ9897S chip_info entry which
is the KSZ9897 one plus .sgmii_port = 7. KSZ9897S_CHIP_ID only selects
that entry and is never read from a device: the low byte holds the
silicon revision, which detection masks off, so no device can report it.

Device trees describe the KSZ9897 without naming the variant, so accept
a detected KSZ9897S for a device tree naming the KSZ9897. No binding
change is needed and existing device trees keep working, whichever
variant is fitted.

Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7: bit 7 of
the port 7 XMII control 0 register reads one, the switch is identified
as a KSZ9897S and the PCS is created. The port advertises
1000baseX/Full, clause 37 in-band autonegotiation completes against the
link partner, and the link comes up at 1Gbps/full duplex and passes
traffic.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Suggested-by: Jerry Ray <Jerry.Ray@microchip.com>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
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
 drivers/net/dsa/microchip/ksz_common.c      | 60 ++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  5 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..78442cc3764363a97015c71cf22f756b06044160 100644
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
+				   false, true, true},
+		.supports_rmii	= {false, false, false, false,
+				   false, true, true},
+		.supports_rgmii = {false, false, false, false,
+				   false, true, true},
+		.internal_phy	= {true, true, true, true,
+				   true, false, false},
+		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
+	},
+
 	[KSZ9893] = {
 		.chip_id = KSZ9893_CHIP_ID,
 		.dev_name = "KSZ9893",
@@ -1852,6 +1887,13 @@ static int ksz_check_device_id(struct ksz_device *dev)
 		expected_chip_id = expected_chip_data->chip_id;
 	}
 
+	/* The KSZ9897S is only told apart from the KSZ9897R at run time, so a
+	 * device tree naming the KSZ9897 matches it as well.
+	 */
+	if (expected_chip_id == KSZ9897_CHIP_ID &&
+	    dev->chip_id == KSZ9897S_CHIP_ID)
+		return 0;
+
 	if (expected_chip_id != dev->chip_id) {
 		dev_err(dev->dev,
 			"Device tree specifies chip %s but found %s, please fix it!\n",
@@ -2966,7 +3008,6 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		switch (id32) {
 		case KSZ9477_CHIP_ID:
 		case KSZ9896_CHIP_ID:
-		case KSZ9897_CHIP_ID:
 		case KSZ9567_CHIP_ID:
 		case KSZ8567_CHIP_ID:
 		case LAN9370_CHIP_ID:
@@ -2979,6 +3020,23 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			if (dev->chip_id != LAN9646_CHIP_ID)
 				dev->chip_id = id32;
 			break;
+		case KSZ9897_CHIP_ID:
+			/* Only the KSZ9897S has an SGMII port 7; the KSZ9897R
+			 * has a second RGMII port instead. See the KSZ9897S
+			 * data sheet DS00002394C section 5.2.4.1 and the
+			 * KSZ9897R data sheet DS00002330D section 5.2.3.1.
+			 */
+			ret = ksz_read8(dev, KSZ9897_REG_PORT7_XMII_CTRL_0,
+					&id4);
+			if (ret)
+				return ret;
+
+			if (id4 & KSZ9897_PORT7_SGMII_SEL)
+				dev->chip_id = KSZ9897S_CHIP_ID;
+			else
+				dev->chip_id = KSZ9897_CHIP_ID;
+
+			break;
 		case KSZ9893_CHIP_ID:
 			ret = ksz_read8(dev, REG_CHIP_ID4,
 					&id4);
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

