Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF5450410
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353295; cv=fail; b=pNhd5DIhCDZs2xEyXIagcOfe64mUKLdeZi9+5Ir6k/LR2VM0bDDW3qAZ5/vblQkZsvERVukwzJH3Bnhkuc+E8fGm00jfkG6G+QFa6iilatNK93JGj7HMBmjcD13dSN+3gZovp2j3exxXkkBNnJG/FnNIrGdYGEhClVYx69JZmtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353295; c=relaxed/simple;
	bh=zuJpyIUFRFH9yKzTegi66zVtnARSy00r4wfMKfJXdFA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rae1Z0li/20SLFk0seXNSYIsI1+SDxQt4d2SdFQqWkKQQGxvtHGQHozptjAvEw1zg1JhEtUbHyC0HF3NTlOdiuJcIEU0azYTd0bT+HnB7T4rg7smtiOKG8jNkCztxXwHS0fHXCDt2v1yfEcHfpxVXwz5kY0NjaScvDEy3HSfiSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=USYVIiBH; arc=fail smtp.client-ip=52.101.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="USYVIiBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfekehq0ctQGlBHFCJ10UBTqsAwcs1eG3VeMp0WQQ5KD3M9TTP5osV/ufM043yKZko5Tn9O9LGn9kTcWm31L+OFoiSZS0BhaRK2r4Cb9kdAVg5Fn9sGhST7x4bnU1TQ8UnkaMBB7jDt65yirdEH9Jg0/WnOY1Jb0vRiQKRkWOMSwBaYbbD6LSinPWfEriJDAh1lZFXeHFs4ZurJbw65AcXNMi71xZorqeOVSmxAaILp9JhRAeqqu6OATtDACuzpxaWG8lbs+D+lBdc4/YzBShEUkI+Nx5NH/ie/RXocevmO3hEeF1GmGPgebUuhq/7xoi2rIukF2cvnrJcZACql3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuJpyIUFRFH9yKzTegi66zVtnARSy00r4wfMKfJXdFA=;
 b=YNNOg9tCCDkHDFsQ68pQmfnnbzAXLKoID/8yNAI2fX0n/CxIQSNzE1dxrj0O1M3E4dUtgPSwqtD8DGTY+6HJ0Kb949wx1bMpRZtq/IO6pqx32l2gjsHFJHmKbtPgj5wT+FCWkSs/X6KsDoYlPlM0YCT6XvBBIGYTWbClNwulLRNl9ncJvFwTfGF0vextFUgYRhnkmd49yD7Lynd4Z1PFHQ7lNX3w7dikbMx95PahHlzcSeQvmmQvIzXwlhljKNgT9DPX+dDH7E+TQmPymjY92vN6XI7wDgHWr45EbKP0NFCX8nP1Q9a7bgThEtvnc/1mmyjt/ZB1Mi/ay3BU+V21Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuJpyIUFRFH9yKzTegi66zVtnARSy00r4wfMKfJXdFA=;
 b=USYVIiBHY6iO1U7axdvMv92+FFFN1K5I4b4eaLFrxANlW5At7aIpZhIath+WhLhifqCRjohXFhqUpNQ/Qn9TWKnr0+MmZJlzbt/yhXyrlB0mAwzp8N3cm+fxOFf20h9wlCepdioA5SDZrqJz56D7WhVU2PTUWS5wPIRG9YGpTEZ6XszX5rozPZHbm7TQsD8z+QJC2Yjw+S5i/cEu5bwB8qiGX8QuDg+4863zrJe6JubAxPd2YzUBL5UhpYBbYgs97dbEa+HrKKWTj+8Vua8+yosLkGkCBdmfTFu61eGlPAdtJ/SsA+jsb/frvWG8yJ6USSj5NNwYUZcljtgvIyTP2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 19:27:59 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 19:27:59 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: [PATCH net-next v3 0/2] net: macb: 1000BASE-X on internal PCS
Date: Wed, 29 Jul 2026 15:21:25 -0400
Message-ID: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 349eeae2-72ab-4284-eba8-08deeda77fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|786006|376014|1800799024|23010399003|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	XsKSrWg803rV+mmbC9MCtGTLO+MZAGardKrNVJeh5AzTXFwMtkGcpl7I2E+2/WTP4P36ZEYFgU8UHh33hK5ll4xBTrgWo/sG9li+WV2aPNJwa/fRNSQm540k/L6Ynj29CVjzMTNqmlHUdKDpNm/mJzo50ySLZUxC8v+HzhpdcCUI9Hct4zhsVuoa13HaS2govcP4Mha7fk9A5kSe7uxETYmG3yumdG4p7k4i2ahRVmbBbw+u24mStjijPOCIP4/+sln77uTYG/vWCX7x5SiY+2+slwJzIHxVp8M4I+6WumVzmPs8RTMWYU7yzxjDD1/K5e1rT+c6I7Y6ii2uGaLGpq3sQsl4hMWitUJF9Sl5EWa1PA9rrcORyzlQJ+4hBXE4ICQwGvnn5xH2Ul4NGkW1UnJFRh346KORcSNVMzy3lZOIDElYeug1njxcoI8x9Oyj4aKxY3u1HASrVUjiDp/xg2AnmXsFpm8M6Z3MedeAtTvyGcUK0mzTGsGaht82pkV2PAnekDD6A0w+uKf5vjdpMpG8A1uAqBcMKwsaPoBpM+zNZ0uzyuACFFokRxWq7Q2+CGAufyhWurh1K0wjyymvS/qs3Sv9sxiqqCQI+5PovX5ubuU8fT0x3PpgzkdbfYFNKzY3zbI5jghVyWLSJzyCuGbnvLiQOBgClJDFWGDco0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vv5eUk+R0HIk3gSJVvuJEpcua22x0dP8tAzyeTmLAXw/dLsONJl6erYwFUlx?=
 =?us-ascii?Q?w1s1uLOuyp4Jhn8c/cWJcqna1R4urJqZjymdUWe0LWagqJ2Y2ALG9ftZeFnG?=
 =?us-ascii?Q?khQNbo0Q5ZMNi47yoV1k2NGtCfaXrCD7JVK5nBcQN82BpJ/sdWRKkj4OkiYG?=
 =?us-ascii?Q?HXVSC5R3K5B2Gxlw9wLN8pTkIqf+uYBST7ubOOh83qJxEi/w21jjMX2TiI2x?=
 =?us-ascii?Q?JB5aUP3RGAylmScyF6Xg/XAnsQdf0+ZlAQ5Z7z4C8fdPJdNRf+n2KHE1Xcq4?=
 =?us-ascii?Q?PA1GvcaoSYDYO4nC7w0P7n4IPCaSv8bpn9PvX2VKUUDr+6Cgc9lxVxL1WZOA?=
 =?us-ascii?Q?pjeHgbFsy+Ce3fsxgrxBmWigJ3ukygeCeJ9OK8Rb6c6oNV3BTUYiF0k6LZ4U?=
 =?us-ascii?Q?qQSEjRzr+fS+GSa4JF2AF1Nyhb59boyPpa7iUV++FGneF9HyYYva/lvWFbIM?=
 =?us-ascii?Q?cghVED3L/WcDDNdwmMlfHUhL6vRTpHtCKbPsfYIV2mst7GP25jznWtfzWjZR?=
 =?us-ascii?Q?hXlLqIq+5fotm0r8UHTleH6vhHcQbqhcyBFlHeR0QjDGWOV9LnxpfGNQehJ6?=
 =?us-ascii?Q?0Wuh4xMJ9io0oyfyoiYDagR34GHGc7Q/mmlRs7vQQVqBTdV2f5BR3uxSLg+/?=
 =?us-ascii?Q?tGnpJHhUABkChcOL5Ruh+tpEOxnCscCAvSsX64lr3CU/JHCZgTMDJZGVaLCI?=
 =?us-ascii?Q?aNg5Txk1aH6c5sKHAasR7zMCMUGBzL71+RJllvwRCjacJeAXt/xvoWCexSha?=
 =?us-ascii?Q?/EJCEHwewol5TiB/TVXIkqAggF0PbIgP9VwhuJgKo15MNGudWa1lI8j68xk5?=
 =?us-ascii?Q?kOZviKL/n/IdwJoxKANJ8R8reE8n4bk9WrVBoHuNSy/RfrEKRnttP3/mBv8K?=
 =?us-ascii?Q?NYdgtYQGnJxQZITFsd1oLuN61kCj2+i5Og4QEmKVNWbUpY9gKPyvHmH6gLYY?=
 =?us-ascii?Q?CyFklTRIctvg/JxxdGrw7zlFMPAfffo7NEYcIB9pGj8+mKbb6jWSFUJQVV97?=
 =?us-ascii?Q?VvAdf1MN/yawBN6huqAQz8v6gOheeXPawcpkFEgb25nLD2LoRwnTnG8h0NT5?=
 =?us-ascii?Q?dTTuq2K5GyPR42eY3QbO7FCyFCPtYsiL+CKqZhAnN//Fuhh85ZX90WNTChmr?=
 =?us-ascii?Q?OGBY4igqJwre8XfoonXnE9IP8mrCPz00gC4V+crhy/lj+AnShfg5uPv+HR2O?=
 =?us-ascii?Q?RV8qj8Ol0U4VUbZ9/H3s6EnYvTY9ekFvaUTTte1y6Tyx4sbybs7akNrbhzwm?=
 =?us-ascii?Q?yfZHHIpMECbozSMVtH9kOgUdjyVMvuxqFOnWypm5+/NeoSWMTB71s2b/2GEs?=
 =?us-ascii?Q?anUjfHRhZjJ75ZTSApwxOD7Oet8B6xqmZTo0C2bU0xeMCaipvUMT+8o2/2FY?=
 =?us-ascii?Q?AETHTHoxkrSjVBXXvmzPZ23n2goVHmRAgUTd1wNaxmxVOhr7D6MM+5sIKwBV?=
 =?us-ascii?Q?NbGzf1313c7m1q7k3fqLI+17sPS4J/yfzNRLMWgLnIif7HWZQRZudabqgvPN?=
 =?us-ascii?Q?inUjlMlB/3qPjf5g/voFzcrsedIEolNXFzjWpkjSjtjUGTqzhNPfS8J4JU3A?=
 =?us-ascii?Q?7Dhk2Irh18pVKWovhRFoXnuDFb152tS4ZkiG4mC4z0AA8BRdJXVqweDONCUt?=
 =?us-ascii?Q?lliwh39R/EGfa5dDUDpZ1+hGf4GAh9iRMogVRcpVBN+jvcjMPF1/gZbqVWcC?=
 =?us-ascii?Q?yp2FT+H6+oGlrRC+K6mEG/FPDxgWhB4N8201PCBBOpSJTOGHPrmQ1vg2Pfjz?=
 =?us-ascii?Q?pOxkutSagA=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 349eeae2-72ab-4284-eba8-08deeda77fa5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:27:59.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEwVxonCi1hdXSkH8r2ugO1/GpJr1ivVHl3468GaFGorbodzi08p2wzDuWn20yBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

This series adds support for 1000BASE-X autonegotiation to the Cadence macb
driver when using the MAC-internal PCS. The existing driver code is oriented
toward the PCS being used with an on-board SGMII PHY, so uses Cisco
SGMII-style autonegotiation exclusively and does not anticipate e.g. link
state changes arising from fiber attach/detach events since the SGMII endpoint
is permanently attached in such cases. The first patch changes the driver
to monitor the PCS's link; the second extends the existing SGMII
autonegotiation code to also support 1000BASE-X autonegotiation.

Changelog:
- v1: Original patch
- v2: Split into two pieces and clean-up of a few details in anrestart().
- v3: Fix mistakes in commit message for patch 1 and improve wording.

Tested on Microchip PolarFire SoC with a variety of SFPs (copper, fiber, GPON)
attached to the I/O Bank-5 PCS lines.

Thanks to Charles Perry and Andrew Lunn for helpful suggestions on this patch
series.
-Nathan

