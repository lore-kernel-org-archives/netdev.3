Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020095.outbound.protection.outlook.com [52.101.201.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB04481A94
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635454; cv=fail; b=J+6E47bbsuEC2/kfEu7Q04waW12ipkYJG+gF1PINPWcsyAiC1X7AWG5gVnTOOKelDrfZfObtOT09PNTJW8xO4zd2Ll0OAZGmo48U0X23SdRxDBK3jnM3PK0wnd333exOW7jPPRYP+5eoNFpbUQ0VOXr992y6tmF8Dc1Se7bpgV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635454; c=relaxed/simple;
	bh=N7hxNAuMzZJIPybPPUHWKhguBR4RrZHabiv0c0n4+1A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HJy7P/c5hZaP1dJcqsO7kQlpMk9SEjW3gC8uZwT+pKsS9TnUYL++biUWvNUzhViXjVXB2P1SAldLa8hSvm6oAydnzYxZrzBU+ElUzbxukOzT2L/cnng/AFY8gOpL+TRFU5ZQ2aw1qyI3idgYRqwnhHIZCtc5/LvIi6jhyzAxbT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=OvcomtMZ; arc=fail smtp.client-ip=52.101.201.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="OvcomtMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSJLoUDDX7OhWmZz5jw7Sz7M2EGTKlWkTtxdmfonf3bf4UwJqCIEkgm4RNWPwmHSs8mJBCR0lcvwSud04gT7P3F2NEWsW8Jk2tbKHplimclFHqvtetxR7imFuXyNFvJnvRPz33dDzzblo8W+d6UEWkkyBGFFPiniqi6zKDMYbse8gCiGyiGHLB5vs0/XGRx2DqEcJuwmdC2iBodtGTjP6FUmtrsetNEVOUnFnqiWtZGrzgNW/2wludDaweuor+bxjYYnnTAY2BvYYxOua0Gn004xNb9mG0FDmSYXERnUA1hTdw8wlEVXW+6qa0uZEOo+tpTb+Pn62lCqFWACNjpW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlaFsKdY86MPDp3aWJB2CkoDyvgcW29dJZfeKmIbAYo=;
 b=pEjQU00CyEAuba/4ZpZvFPFBHApCgt70ptl28iyWQJViKc6eNxfh/q9yRZ73SmBxFfx0KcCG95m45u78Q9UmPZTyISfq0ujDmXum9AQBelJYbgF3zFnsIRWdEJkoSf+AckNcpcpLu3ymLXZhWemwJyuIIMYvVd2e/6HR1u+r22qlJOUnAVkX8HF3R220xWlUgFoLnkmTs22HAWpiFCEokAadyCisKfT+fFvpUjQHwWHYbrt2oWanNDlzmb8ahanL5rjSx5zyl+Rab6xtPiZe8xARj/icCM5EjjSbjap09huM8UpFFr2vATxNBXRwA6bpxOeZod8vClsvzfQf85vSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlaFsKdY86MPDp3aWJB2CkoDyvgcW29dJZfeKmIbAYo=;
 b=OvcomtMZxKYmwMMxOzP7HzAgc8+QocxT2QfNXwwMGOoEtAVR9o+Sj0WK0RdvE2Juq5PqVr+OBQsIi9h42HZf2gIsGuW9u7yD1atNKHd6CimPt5CAl6LQR1kqhprdq0yiZvDg6r7q11y8Di8hmse2KtHCSkqCHXFUxb9x7hVYqZitr12Ca7pi/Tf3lvmba2NJbL6Wk1THpujOVppVHSnoghE3IubGDusSDDyDdvDC5dVoEh+M375YA00MIhnH6VQqA2WtoLj919M9XYzpo6BXvEXRJxlcJv6Nr28rYS2rY+nZEKJz9XOWSm1iL0DlYiCysjQhx5oWnsGC/Sac/fVv1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 15:37:16 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 15:37:16 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org
Subject: [PATCH net-next v5 0/2] net: macb: 1000BASE-X on internal PCS
Date: Thu, 13 Aug 2026 11:26:08 -0400
Message-ID: <20260813153705.23407-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 8970f156-9e06-4489-c6e3-08def950c080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|786006|10070799003|23010399003|18002099003|56012099006|11063799006|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	DUXPmEqMrp2Kj4YLAcevx8YZ105F/1m7x/NI+9qfyKohb9StiwRgzwP9a4dqGuO09GiTt2gGXwjvfhuaSE0CBMVvBqsqIwp9ghx1EbypyJSXBUlv6Hk3vhnPdAXrZZyURrpXmQaCe4N2MIpqf22re7NNy1/SIlL56OboTcwmHJZLFhSdjuT8F5bTPGRci3fSxGZDihj+LfAgQ4Mp/1i1thZYn60GBgpkgQ5WnowSE7j/NAcdPCjtU68/I8AW2wBw8C2oBSDOgDqOGHmpRLH0P7P2YXLwZSOHsgCStKughrY8ivobn+8HUIygGNEM5bMgdxbwTLXKW8KMxgltGQilrKz7V/p65nq7vxvQm8CbrRuwaOtNt0NEZQqOdSLqMlWhh7mkHdjSIKmAo3+x5APu9ZXOjgFIZ0jH8FcjQvm5tRRhW+yAfs4vTMO04Qfa44QF7zukeTsOh3I2He438JrgqJ+IxMSkBaXprwABUmxTyS+YvKnLVqFnqHjNV+g64sFYDCjQN9AS3/HAe1NOIRUs8Cuc8vXmM/9Ku0yCpeRfRvZjs+RbFUZLPTBtW706cdiyOoSOg/HZDvusbBAnT0JQvOHCA/2QzNXXnvop0UcwybxFW3QptHdw5IIFJTZvBnWVY5l5UzKHslKYbmV8kJa2j1Vz4K9paWdPWLe+hx9UZI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(786006)(10070799003)(23010399003)(18002099003)(56012099006)(11063799006)(13003099007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGlJekFYMWJmL1FWMzM4dGI4MXQzTkJiSUptZ3JUdUNlbmFjWFVNdTZEN3Vl?=
 =?utf-8?B?dU5HTEVSMHkwTEVQYUwvTU1mUnFRNHVLMlhnZG9nRlRXa3IwMHlSakYyOEV2?=
 =?utf-8?B?RldlQ295aGZJWndCNkVudllRQm80VkczZnVGbUE3YjIyUUZESFNpcGNFMGFi?=
 =?utf-8?B?d2Uvd0tCL0FjQ0hPcGZBU1UrR01UMWR3TFdldlRISXMyL0o5Y01SekVuTW95?=
 =?utf-8?B?OTFVMEwvenRHTDFib0hSRGpBN0hjUTFKNGRRQ2I0NW9tRWU3V04zU2M0dktV?=
 =?utf-8?B?bUYxdFhCMjJ5NGN1T2lFemEzWFN6ZVNlSUQxMlBQNkVXVmp6emhYa1A2dldr?=
 =?utf-8?B?N1RMa3J6cGwzdlYwNTNjTHRxUGoyR3dRWkNjUUc5NFRkL2ZWTmFOZlR5bVJD?=
 =?utf-8?B?cjFtZkJZOXBIVWdZd05MY2FqUUJvaUtwNnBYdGEyL1k1VjhvQ1pWTEw5U2o5?=
 =?utf-8?B?ODdQL0R2emNhdlN5eG9GcjhQNXZEYmIxTVFDVEsrdC9wTkJnL0RkWEoyMnZZ?=
 =?utf-8?B?NU1jM2tmRXdaaXRoM3BoN1EvYXkzL0kzcWY5bE9ScjdRUUZTd3R2dUptLzho?=
 =?utf-8?B?R1Z6d1RvVnZRZHVJSXJaQ0JzVXpnSEdzWU1ndlZ0ZmZ5Sm1WUnJLejZxb2RS?=
 =?utf-8?B?RUZDaXFqb3JBYkdiT0FNN0VqU1JlT0Q3MWMwR2VXR3dwc2FxeStVbUNaYXpB?=
 =?utf-8?B?U3QrUG1lckVmQkRsWHluUTRidC9oSjJKcm0rY0RZSjZHOU55eVBLZk5EdVRS?=
 =?utf-8?B?V3N0OE1sbjMzMmFvVTdObXN6c094VG9URWRtdng3aFR1NTBJSUpoVFoxanZy?=
 =?utf-8?B?S0FwNVhlY2ZoSFRlZFZZRmhkR1hZSlo0RFBKL01wVDlmWmJ2UUVxOWxNd1NQ?=
 =?utf-8?B?U21nSDFYbU9NRkR6N3VKVEJrQllSLzY5emtjTnI2WkIwTkJac1NidG1tU1dR?=
 =?utf-8?B?OE9HSTRXdGlWM1FNMW4rVDdGa3gzUWsyNUs2eVV5TUl6Z2YwWlJQZkRjUjJB?=
 =?utf-8?B?amQ2VkRxUEZ5dTR2bVJXM0U2RVZFY0lXQndPbnRheitQWVJIanBaZjRlTmli?=
 =?utf-8?B?Z0VNQWN4djgrcUtqc3hQVUgweHRCWGdjSkxiVlVkWTNkTDNtTEk4emovZm53?=
 =?utf-8?B?dzd5N0VobjhOc3JaNzJ6OFlPWWJvUzRZZUt6bXhSSkpONDBXWjlIaWZtMVJ4?=
 =?utf-8?B?ejdKaWdsV05lNGtrNmNFVkt5MjgxRnIzVVg2MXp5SDRDakJFMklhRzhlN3I2?=
 =?utf-8?B?a1Z4cGdMcGRySUlaUlB6QzdZR3VmNE1lU3NzbTFhUnAxWmorUUFrL1lkRVNK?=
 =?utf-8?B?UHk5VWJoZFo2ZDY1QTJMMSt2RmZucU9mVDlLMTl6anNaVUJpSVBOYzBIdW1J?=
 =?utf-8?B?QkdXb0ZFNkN4MnZlMVY5VlhJSWpTVld6UDUxSjhEaFVSSjhTQnR4NzZjVUh3?=
 =?utf-8?B?clplZXh1MmMwaTQyS0NLUGltdVBUUWtMNHBpOXBrOVpiVlpsNTl0b0xTQ2xJ?=
 =?utf-8?B?UkNYemRUYnFVeFJyN010MDlHejdMVVJOV0NEdjc1MEtHNVJ0cXRWL2piZFBH?=
 =?utf-8?B?M1grOVByUkdsWDZqK2FlaU1EOUdPM1RHMGRuYmIxcXdvajRoeU82SzZ0NUQ5?=
 =?utf-8?B?TU1YN1JZZWRiZTJhWnpydncwemZYTmw4dlVPVU5oMm9nSWRteEE5Yi9sYkxr?=
 =?utf-8?B?RGJvTVMyN1hhRU10ODRkU0ZXa0dBQUJ1c0pYQW1wS1FnN2JpV3RxSEFadlhr?=
 =?utf-8?B?Sy82R01Hd1NKZ2ZqYk9IU3VDYnZPVCtFSU45NDkzR1RnbFF6RjFVaXc0dUp2?=
 =?utf-8?B?KzExSlRRZWY5OG1VQ2JyYy9RSlBjOWpCaE1CK3diQ3dCdjV5V2pheVdRRnFl?=
 =?utf-8?B?M1haa2NDbHJROFpmdk83ci9rcW5HV0QyYlRpRVcwQmJYTmZPZWxpbEFPaWR6?=
 =?utf-8?B?SjkxY0tZcVkwUUlkUjJGMWNlamk3VEhLamdlY2M4NkV6WlZ0NU1IUEFEb0pP?=
 =?utf-8?B?cWNjMEloTytQREd0NGtwRUIzcForcG1GMTRVdTFLT2xnRExqTWVnUGFVTWRu?=
 =?utf-8?B?MnVid01Db2NWai9HVysyUmJ4TEp3bmQ3enFvNUJVVGRTQm9VMTlPSlo4NmF0?=
 =?utf-8?B?UUU1SVBNelJyTURNUG1seFdKN0xrbFVjdHNlT0Y1N2RyQ05rQVlVTWthSk95?=
 =?utf-8?B?eWZRWnhBc3YyM1VPeVdXNWgwVFJJeXc2UVI2NkhjZHlGekx3VWNLb2hWdEQw?=
 =?utf-8?B?dFJ2d1BBOXhYU3M1Tlh0S0ZmeUo2bzliZjBUQzJac29PTksybUdaMFRYZ0V3?=
 =?utf-8?B?RytWUEd3Z09RTjJ4cGQrQmRMZzdTbzJWMGNzR3pjT01IZFM0VTB5dz09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8970f156-9e06-4489-c6e3-08def950c080
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:37:15.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nfo1OSJ4f7DTs+SQPpa5BmLLMzKCNT5sLq0y1VSMfwZckB9Cr/kpWplx74O/Ygx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

This series adds support for 1000BASE-X autonegotiation to the Cadence macb
driver when using the MAC-internal PCS. The existing driver code is oriented
toward the PCS being used with an on-board SGMII PHY, so uses Cisco
SGMII-style autonegotiation exclusively and does not anticipate e.g. link
state changes arising from fiber attach/detach events since the SGMII endpoint
is permanently attached in such cases. The first patch changes the driver
to monitor the PCS's link by polling, following the approach used currently
by this driver for fixed links; the second extends the existing SGMII
autonegotiation code to also support 1000BASE-X autonegotiation.

Changelog:
- v1: Original patch
  Link: https://lore.kernel.org/netdev/20260714200904.70428-1-nwhitehorn@pa.msu.edu/
- v2: Split into two pieces and clean-up of a few details in anrestart().
  Link: https://lore.kernel.org/netdev/20260714200904.70428-1-nwhitehorn@pa.msu.edu/
- v3: Fix mistakes in commit message for patch 1 and improve wording.
  Link: https://lore.kernel.org/netdev/20260729192748.6928-1-nwhitehorn@pa.msu.edu/
- v4: Fix return value in macb_pcs_config() to indicate to phylink when the
  autonegotiation advertisement has changed and autonegotiation needs to be
  restarted.
  Link: https://lore.kernel.org/r/20260807201741.3275-1-nwhitehorn@pa.msu.edu
- v5: Fix bug in the v4 return value from macb_pcs_config() that caused
  phylink to be informed in the wrong circumstances about updates. Also adjust
  some whitespace issues in the earlier patch series.

Tested on Microchip PolarFire SoC with a variety of SFPs (copper, fiber, GPON)
attached to the I/O Bank-5 PCS lines.

Thanks to Charles Perry, Andrew Lunn, Paolo Abeni, Théo Lebrun, and
Jakob Kicinski for helpful suggestions and discussion on this patch series.
As a brief summary of that discussion, there are a few areas near this patch
that are existing non-idealities in the macb driver, in particular that it uses
polling to monitor link-state with the internal PCS and the driver does not
currently have support for using the link-state change interrupt. The
intention is to address this in a later patch that would remove polling from
both this case and the fixed-link one.

