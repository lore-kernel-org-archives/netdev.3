Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11010010.outbound.protection.outlook.com [52.101.189.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B942255C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154752; cv=fail; b=AwiBEovwaMjv0qnHn8qCw3Tjy8oPzt6JA4B59pzIlcHm/WF+USr1AYeTLd2hxxU3dVeNcE7QNLy59B6Hnfx/51DIXKDtd4Te8l4yuLsck2U0It3ZjPZbmQWRWHjDVZEls6bnLJfhL+rPNd8o3kxNax9259J0t1mFYFhD4FAwgYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154752; c=relaxed/simple;
	bh=r5I2MVDqMkTaJC/WSKmgVtHno5jo43ymKAQ4sKNYSUo=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=INXXbSRccqVX0wc5sDWFwQFABZJfHG4oo/+74xC3+JHxkjg8aDBpJ8Eg4nkhalyz3p0XLULKRwApl4thIxMj6YgCB5f8QqrtRPLVsyMoe+zEWrs/qKY6KNxTZNTqCtP8HDXi12N9ZZhcAVWfglbLHFxadof40mgETKn0zjhvXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hydroquebec.com; spf=pass smtp.mailfrom=hydroquebec.com; dkim=pass (2048-bit key) header.d=hydroquebec.com header.i=@hydroquebec.com header.b=qVFkPxF3; arc=fail smtp.client-ip=52.101.189.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hydroquebec.com header.i=@hydroquebec.com header.b="qVFkPxF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjGoihPoJ02v358yO5xditRmDUcjtfzALY5bSe6Wb8+7ghwnNg+50dqHRSBri1BuTnVgrDnDdTCnnDeStnSGAo78ZomQD539RSvms4zq0HoZE2t0/LMwYmIrTGnolfTOWWSAWfU14J/Ew3AcTEm+gmoZ32gmHguv+/YmXqMXTKoLxI3DX+bSX9A7PZInKGJrsvXiYrkS6aEMB+Za9P8rVAsPN45TN9AYAZN61PulwM6DShjmCas8YplmHoJxLKWntOWTuEvG/ltNEg7QdvXhg8kOe/vazu3xrqJJk2rxJNMJl5OU0x7WDlf/FqTfCtRuVxrCmNyjOD3jLN+X11AT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5I2MVDqMkTaJC/WSKmgVtHno5jo43ymKAQ4sKNYSUo=;
 b=yg8ndX/kgSup1YUVUZZVbfpZXfwPSJtjgitdTPsKC4w82PkMEo7fZRmWcjcqkfK1qIFxGLdVIv+67rH4PJPmOcq08xfDV3Z8MwXOMuhmhdRgdClt55TywRz6vBlihbDtPMON7hOJLnQ1d0lLL3CCNBC6AWfeEHMUdl/+3ok8WGoW82u8F8UP7ZwpIXeAXfffpKeW69qGQsYdRtKHM14Sq49Re+vjy9bPrzrMTZxA5cysU6At/SOfgGAYBruF2rD94P3XE/2IF87XoOxMnpSEIT0zDn0PL19l9HSMsWRmjV0WkDenbjZ6qpP7TvPi/fsLzgXQs7LvhypAZzarONIbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hydroquebec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5I2MVDqMkTaJC/WSKmgVtHno5jo43ymKAQ4sKNYSUo=;
 b=qVFkPxF3a60NbEokTSw7FG9O4o9qR3Yi2qkOSVW354Vo9BBO/mtlw5ImWOtNr5Z5gapz846ahtW1cucHFNfrjwKslG0d7sPyVqRm9BIS9ves1tuTjTo44FFVO3F6yP3F3L6t2brb6qmqhNvIDtT2ydOZi/gRAQYNJAUeAEWBmXF90he84reJ/11hVmJ6QVxfBmJPAVUHTt4X6OZlSjE78Gjwwf9blUTxUOZHSuo8q4Oso7d+aOGWqDjNDINwdbihlghJEd42IJSSOIpoK2PLngAvDB+FufBnagCBzvwBkqDf58/e4kzWSsTTDo0tHklMtL7Md8MAwBcPwyd/k96E/A==
Received: from substrate-int.office.com (2603:10b6:b01:10c::26) by
 YT4PR01MB872093.CANPRD01.PROD.OUTLOOK.COM with HTTP via
 YT4PR01CA0504.CANPRD01.PROD.OUTLOOK.COM; Fri, 16 Oct 2026 12:45:46 +0000
From: =?utf-8?b?Q2hvaW5pw6hyZSw=?= Vincent <choiniere.vincent@hydroquebec.com>
Date: Fri, 16 Oct 2026 12:45:46 +0000
Subject: Recall: Re: [PATCH net] ice: fix null-ptr dereference on
 false-positive tx timeout
Message-Id: <GGCI1BSYKUU4.ZNTPAFE579ID@yt6pr01mb820068>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 58ff9299-6a51-cfe4-fa8b-1117cc15a533
request-id: 58ff9299-6a51-cfe4-fa8b-1117cc15a533
X-MS-TrafficTypeDiagnostic: YT4PR01MB872093:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19003699004|18002099003|10067099003|1580799027|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HysQ7VxFTyDJL2+DEqrdMgl6qoNJW5N+JMkPoL50LsI3WEwj9aJTyuRCcuLDpNo2YggCsSe2p7AVMebd/yIvAAly1ojJhpTW4XIDH2V1V/5KYNQhQumsk1/TbaGr8WSXUEHsQjbUWeaJsCJqau4VSewTHs7PgvzUqb2SVSxC6mLDl7eb+M/wFESYid4iFN0V9Xa/3hIZjHIQPhtV7ZIFy9BHB6P5BM0UP/Uvcq7uXUgvlfsovKUjn19fCAdAJFSQ7DKBH03bzZUll/bvDz6Hgl/MiWfJ4WQli7yKtnnaFMy/z9fQsyvBh/XG6aycemCPMEXMuWqFLXVj0F0C+7Ia8YQnhxKZcJ0+SUX4e71wEJzh6fqzPG31DrVokapA7KjUEFqSapKHquGsZ3xqV3LkeUkGYOJvZ18fkak5NVXtj903iTN8hiPKtHu8syJIzoPtjMLgDc3UQeoPRX6cYezsopJ1GxJOD8f+WlROA605Fbal7Fe+DdP/Guiho84x0cPruoZe/G3NQGLC1jQtHy/sM+WSI8JjRSoV0tIRwPl4Hxj9wMX+4fqi5U8pO3C2HNgc1XSI9qYX5lNU56byJH7mXDj/WywukUIebNSc094YoTiGRxLspnmsJxKYhWAq2jXWU8sBYFM553acvElWZn1v9bSKrhwNyltNfOJoEydZecoONpXqT8Y0+TOW/ZIUnr1pH6a90Lm7wS7gtqg3GzzfRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19003699004)(18002099003)(10067099003)(1580799027)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kbr4m199e+FJadOCkNctvQkB6uRnl2oEQ17WXjWTSlKMfU+OGs+mXVutlnlhRk9OaebjFOKTWYaXdCaaBD/jFNSzb7U0Wgk7PPn3W9g/By7ITO/u4VhAmcYvbtub5pMmVF2CgSk239f9p45nGZZ8fIfcCLbn8sREQeW5JrFUuB858Vh4AyDWf6LHq5mVflJpWuRshyW/NcFAYRMamn+bZTUd1C6lRiVyBHowLo8+/kihH3I/jOaWlOUYLnUQ5EagmEQJ6jw7pchRoJbHYYkVABtqiZbJUClfPoZZJhfr5TyWPTATtsbPfnghb942RivuFPpKO8WX9jIMagMAdHJgC6UqVzPo5BG/hwx2WR1nM9KxKmyHM1ZrWSOecj6+jqoLmAVnsqYDX2IdZ1hdrXq+VqFBuqbjhZxQ3ZIwAnENIVEibPfPCkI36MQX7lPjg/GT0dsP2eBrT9VmeZPm1afE4LCM2L0iIyn4OvDPl5OoKGyupo3y9OAEVwCUjaSNl3NKnW29jOITCgTndDCC01HVTkhQ2uSCVxGuEJ8qQ0zfrrrGAzcqnwPQW6h9MnGFXWza
X-OriginatorOrg: hydroquebec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-YT4PR01MB872093
X-MS-Exchange-CrossTenant-Id: f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:45:46.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	7f77f9f3-f51a-4976-1808-08df2b836665
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-OriginalMessageId: =?utf-8?q?=3CYT4PR01MB647290A9A61F5D68E2422446D6E39B2=40YT4PR01MB647290=2ECAN?=
 =?utf-8?q?PRD01=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-Client: Monarch
X-MS-Exchange-CrossTenant-MessageRecallSenderObjectId:
	3bc9e205-614e-4a00-af94-5f5047ddc206
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB872093

choiniere.vincent@hydroquebec.com would like to recall the message, "Re: [PATCH net] ice: fix null-ptr dereference on false-positive tx timeout".
