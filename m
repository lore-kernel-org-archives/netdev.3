Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021089.outbound.protection.outlook.com [52.101.62.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC04570D0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090142; cv=fail; b=G6TOqN2YTVNgVfno5cbb5xx9fOnSrzZTOAitlFFNimDav0d0suwgc1bMwGChdLsjblYFRRJTLzha4tXoLLRP+BrGe7pYjMN1904NftyU8oZXLxJN5zzB/Mb39Rfk49OQ4FfOlJFcGWHnerXqG+S+UcCo9xpSSGJ+VwJgV6De9g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090142; c=relaxed/simple;
	bh=QPSfgoj/x4Mtvku2gARGmahZGgQQkRs5K67fSJOqOvc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aByT4yh++2P8Qn5AQXXp+mZVfno/9UamX5K8/wfYVbTw7yqUPuLf1byUDJBztTGZpLp+8JTNMq7FeT8hZ10Vg+RcK1QcRkiuyzw8hn8xT3MHIzMS5VAwVDVwTwTCkehJtgAqa+fd1+GMsKuUiR2EI2APVIHKGBSSu6KXDv4sWr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=Z4aLH3z8; arc=fail smtp.client-ip=52.101.62.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="Z4aLH3z8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3mOU4pIWnR0Mq/0CwN9ce8z+mot+Z1+eSCPvNLEdBADDWKhfbExBcbStICeD/bu8Pj/rMjAvEYJXzHn9jLfjIb1A8oBnVeN9XljLNzw8ADkEcvntVumjFtwb0SClkYheZT58uQeC9HSvM1URqhis/ug5/Z1AGpBPsmUsa6fh1FoRHXikyGmOWMFyBQ1comOtAtuT/mzlB3jssEwb108WIqPN9CAVac4bqlis4ktktK24jwVl5/f5JclMyxLm9AqigsF5wDEMsluSWvVLW//CXCXRVCm6PLkqnLrQ+8ctoFsTdpQ6G+4YVDl52njQwnfMFfEyUtXgjK09e+L6P7yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIITzjXnlYW+KMDufLDGn9nEcL3a/qGDhwM0j3KtdGk=;
 b=akLsEXdRPKcyTmUtIjM7D6UMy/5HLHqX24bi4RJk911XgblefiXLZpA89copYxcMree8lfOjeQVzLR5iyZufImZ+BRjC2Jzmg2k7nU7qQNZNtZ4BRQp7Gjxku5u/gBu+UMT2KL0ZV2LGZ+6RaJdSNNMAakb1WHiMAzDsiESeza59BJQ+yj6vmJ976WFwnPMcTAfBloUzLiDaEOLUNkblpUnfCx+uc1xF2OroZpkxW5LrB3xdJPzpVNXBpULqFvSSBoFrGWLKYHEI5N3Jkf9h/XzryO0tZx55md6MhND7pEd978WZ9S64D0Gr3jp4uJt818wGW3X0DVPf0QisEdjKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIITzjXnlYW+KMDufLDGn9nEcL3a/qGDhwM0j3KtdGk=;
 b=Z4aLH3z8sqQc623G57YI/Wqx42ku/xgkEKja8qXuLJffPUxtNbrX7D9W9cPG5nBGqCQfq600CBsfXikpTxsq5kf05wGaYQ1f9GUuD6Jr+mkmoeSjBDANY2ERW6x7vKhzuyakKfOvIe4ed8PebdLHdXsJahbddE+5nxbPCdJJKOaP0YsiHC/GurGXvNrakXHBCQ/6HpkCPF0IihJP/gKMKLZayuqUZak5rOZ36hR0iu2kxfihesis1svdN5LpJ5IbOXYYNAk5Lw/j7feZ0yqgYp9GeSO3BEPYb910Tb5Fht6N9nIQzuglyNf6N8LLtKLoxOy8FY7dTtU8mD6AzN3ypQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:14:43 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 15:14:41 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v6 0/2] net: macb: 1000BASE-X on internal PCS
Date: Tue, 22 Sep 2026 11:09:23 -0400
Message-ID: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cdd001-4574-4010-49d2-08df18bc3976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|1800799024|376014|10070799003|23010399003|18002099003|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PUwpDsNWFz8ospoMkKnQsV/fdvABlgBXO/0Y9HmMwmoGVKEvLB/T+Ej7287tk3rWr7vL11XftY/eVy1y8gVUmqDJO1qQJ8l8RmiCNkte4PFWiq8LAM182JSUbGAZZ10VvGabkVP7ou5ibdbw2BoDIDs0coQcZPTr4UqOD35CsediBXy3LRyCjD0h9AnY4oFFS518z1XHuYqy7NnCBq1SMK5pofuq6dSMjFp0wjUmr2UB9oDpPRHAOfvXGV1HzPVagXFPWTT1KSw3qOhlrC8DOFvv/9D8Xog40/7Dz8XfLwf1+frfYcKIumzNWxfhGuHChns+0VkyF8Y63vUtiLKhlSFHwvUXIoIDWLnqSGEfTyGLPu1wn8YcLrVTOCMgZuGPJ0/LqFaJno3dzb8sxT5eJyp2UOz0IC+qeHybXc8QVXHZSbRf+AvSg/g1eAHXe3fRVkdUvJ55+u2GAZt04lYzbdW5mSIjsWirLCoZtj8gREbTSLIJfTt1gqxq8bhiNrzVsPsZskln1FHvk0eUlINiJZ7xMrfanxJUase58Zzl/EeJ154iiuLBKN3s6kwnfOiZWpxxdLG+TejCas7/lnIadn5esdVMv9wzxIlHzkttqP+tOgZAeTdhjTtr+wiPJu1hnFXdJzgRn1yi9ZCeXjTZO0AHpzrE7JArKL4jLKzHBi0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(376014)(10070799003)(23010399003)(18002099003)(13003099007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE16VDFFT2ZTbDVJWGdQN1RCVmVoNDFyeVJFVWN2ZEhSVTlMLzQ5c2lQelVa?=
 =?utf-8?B?L0dtYVprRzdLc2ZlYzBpK3NvTWtuYlhwTUszOG16U0RuRTdMaU4zSUMyMy9L?=
 =?utf-8?B?UW9EaWg5MGljNjZzd0REQmRCREVhQ0Jkd2JRb0h4TW91YUNZTEdJT2NnbGtK?=
 =?utf-8?B?c2x3bHMyblUvN1dtOURjZHM3ckpaOWhnUTI1M3h2TWo0dVZDYit3Yk4reGdW?=
 =?utf-8?B?K010d0hXU0RxT09ZdldqWGVtdTFhc0tWb0xJR1FxMG1nalUybENLMEl0QUQ0?=
 =?utf-8?B?VUdLNzVKaXNqYkliRlZYbnJYMWxtUkpsRjZjV0hJTG93LzZJODVJMFlGV212?=
 =?utf-8?B?dlc5RlZJQnYzZjkxTmlZZU1EQ0JqWHVaVlBJcURiR1ZuQVJsakgzWVMrYzdy?=
 =?utf-8?B?NVZjTGFoV0Zjb1dhVGpjclF3ZEZURXRYbUlUQzl3U0RERDJJOG51M0xKUjBQ?=
 =?utf-8?B?Z1BIVzRJcjk1K0FDN0I4cmEwaXVyZWc5dTRuV2NjQWVLamt6K3I0K1FMTGlp?=
 =?utf-8?B?TlNEa1NDeE1uMkViVERCRFd2OTZaSk84elU2NENrZDFHK0ZGS2JqUjhLK1Ev?=
 =?utf-8?B?UU9qS2RVYnVqRXpEaHoydUZFTGNXNGVFbHhrQjVQUjRnSk5ReUNkM3ZGZEs3?=
 =?utf-8?B?ZDhUNUFYT0NGenRxRzJJRUZqQUNJK1N5Q29pODVQNVVrTHlyK2NZVGs5OWZQ?=
 =?utf-8?B?QjgzRno2ZWYxOHFEbmdXMWJSb1VDL0l4V1p6QS96V3EzNnVTNkFYMDY5Vklt?=
 =?utf-8?B?MkFkMHp4SWNGbDB4RCsvM2E4cFBPWk5RcHQ5djVQYWFHUVJlUnFzQnRwaloy?=
 =?utf-8?B?bmpscXN5dk9DVm5CT1FoL1YzcTI0M0E1ZWxQNWM2eEtXMTdZRC9McXVUKzc0?=
 =?utf-8?B?bHgyQzI2a0NZS1cxNkMyMkE3NHFIODJEdmQ0b1NlaVd1eGdPdndCZkZaS3cv?=
 =?utf-8?B?Rngvakxabm1Sd05VN3F2TFRuYUY1cVZpdk93cnNCYmpVZEt0VCs5YmJlczl4?=
 =?utf-8?B?ODRTelAyY3IvSGxzdzNYdEJXVnYvTU9heG4zaURRY0Evb1psVVlud2JvU0t6?=
 =?utf-8?B?THN6SURDcERWbjhidEl6WWN3MTYyb0VBQzZ3emovSVhzekVaMHFYNnZGQW5y?=
 =?utf-8?B?WEs1N080SDVwVHJZM2VEZkl4TUdvK1QzeUcwclNlS1JZSFVTaUxOT3VFbEYw?=
 =?utf-8?B?dDVodkQ2bWZOTUZJWGJVNkZnWEdUYkh3aDI0NXpwUTFPVjZReFB5NEFob09J?=
 =?utf-8?B?STVvODFIOU5DakY1dEM4SVl6Q3laRXZ2RTkrS3ZTMXY5VVh3dkxFZGdyMDB3?=
 =?utf-8?B?cFphMEhpMHBTblM2a2wwaGtFN2h4TldUOVpudy9YYXZBZ1diZnFFQ0RNb2h3?=
 =?utf-8?B?OTA3U3NYS2duN1J4VXBXNm1sWkRHNDk1bFhuQWdzYWlpdFVIZTRiZlcxWG4x?=
 =?utf-8?B?bW4vd0didUxPaDBJWjM1Vlp1RUtVTDVVamtCNUJVYWcxOTI4SFlqT2JnZ0kz?=
 =?utf-8?B?UmRDWXhGb284dkdENWwxVVdnZFRoUXVPMTlPMWordU54Z1JsTWNXaVlNVmh2?=
 =?utf-8?B?Z0ZsOXJvVzRWYnRGYnVreWJIbjJ6aHdLVHFKMFJsQ1FUdTM3RStrWCtwZmNw?=
 =?utf-8?B?L2xWaGRPRFNhZUE1VG04OTZnWVhvUVBCR2VLZU0vd0lyNU9hazRQWE5PRXlF?=
 =?utf-8?B?N3ViN2xCODNwVTRQUytnTjdPaHVTUEhSS2k5MmExYVVZZEtSQUJzaGUrbktE?=
 =?utf-8?B?bm1mWVJMWGVSRWJpOTFQYmZQZ20rc0VEMFV3K2gySkxQUENBem02bWNUNXpR?=
 =?utf-8?B?aWhmM3Z0SmdpVzIxUVN5ZGFlM0gvbk5WaUZYbzVZMGIxRjdmYjRTMG4xcDdh?=
 =?utf-8?B?bFdWcnBZczlUbWFDaHZhYk5wV25ObmhFbEo4dk03bXVGUmlCT0d3OXlOVGhC?=
 =?utf-8?B?QnY0bCtjT2ROOUJuK2srTGJ5NmNaZGVDbHZla1RZVW1yWEhzL00wbCtDN2F6?=
 =?utf-8?B?ZmFCeUF5OWw2bno3WDIrcm9WRmd2dmFSekRVZmhxN25VaC9jTFdyMUdpY3VG?=
 =?utf-8?B?R3ZCRy9WZ0RFbzdVZEJBa3A4clp6NlgyeG5UVDNHSzFxbjJxb1ZGV2V1UUl0?=
 =?utf-8?B?b0FRbVlUblNVZ3BDTi8xU1Q5RWVINHVTZTRyQ01VbzRTS0x5NjNnRU16eTlI?=
 =?utf-8?B?UHV6bE43Z1owM0cxWHlQREdxWUFjcHR4eTBYL09Ga0NCZXdhWk1PeU5PMGx1?=
 =?utf-8?B?KzQyU1RveU55WkdZNlhaelRQR3F6aUZydkMwM1ZwZUtCZWp0Q0xLYjAzaEQy?=
 =?utf-8?B?V2ZScmZEUlZjdGR5QWlJMGJYYUlzUEZQL1BRWVFVdENHZnkvcVpZQT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cdd001-4574-4010-49d2-08df18bc3976
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:14:40.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gvaA0xn2Wct6qE7ARl8POGbjpg8AtxAA4hkR6khWevB5cvEdRFv/IUtdWjRlMBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

This series adds support for 1000BASE-X autonegotiation to the Cadence macb
driver when using the MAC-internal PCS. The existing driver code is oriented
toward the PCS being used with an on-board SGMII PHY, so uses Cisco
SGMII-style autonegotiation exclusively and does not anticipate e.g. link
state changes arising from fiber attach/detach events since the SGMII endpoint
is permanently attached in such cases. The first patch changes the driver
to monitor the PCS's link by polling, following the approach used currently
by this driver for fixed links when the PCS is enabled since the driver
does not currently monitor PCS link state otherwise and this had not come up
with permanently-attached SGMII PHYs that report link state out of band.
The second extends the existing SGMII autonegotiation code to also support
1000BASE-X autonegotiation.

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
  Link: https://lore.kernel.org/netdev/20260813153705.23407-1-nwhitehorn@pa.msu.edu/
- v6: Rebase after 07362f68e61d8. No functional changes.

Tested on Microchip PolarFire SoC with a variety of SFPs (copper, fiber, GPON)
attached to the I/O Bank-5 PCS lines.

Thanks to Charles Perry, Andrew Lunn, Paolo Abeni, Théo Lebrun, and
Jakob Kicinski for helpful suggestions and discussion on this patch series.
As a brief summary of that discussion, there are a few areas near this patch
that are existing non-idealities in the macb driver, in particular that it uses
polling to monitor link-state with the internal PCS and the driver does not
currently have support for using the link-state change interrupt. The
intention is to address this in a later patch that would remove polling from
both this case and the fixed-link one. Other discussion in earlier rounds
of the patches was related to handling some ZynqMP-specific code that is
related to specific SGMII-only hardware that is not relevant in the 1000BASE-X
case.

