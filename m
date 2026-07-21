Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63519472F96;
	Tue, 21 Jul 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656396; cv=fail; b=jGkgruaBmr5/JPvjU7xkOB+NPP3JFRST2tZbsqdId2fnill/T+iyC6ZPlhS8l9rFOSVoobt0SNZHLkag32mvcj1eZhOktQMZ6EU9XSVE00Gzrv58boZJ9bUa9KYq1d+iJl1rAshF8voMVZAf6xsrI42Y0YpyEHZfElMmGSb29jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656396; c=relaxed/simple;
	bh=FPqpHRql3cOzRAXwUAaZ+kklpTnwq7YYld8cjnUk29c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGax5PokYS9FVXDZDHoYF0osIE2quRzNuouRUsVCGCjr5QFFR2RpqtSvMLQ2qwVPmrwQr1+Lv7xQ/tI1FPb8MR6R/lcyHa/7UQouO8Pta02ZwfyrSRtgbE4o2/F5XD6shl/+8wJ7D39XvANGaWvPWPMLfrhiuyD+TB+HhWpRHUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=S86l+f99; arc=fail smtp.client-ip=52.101.57.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S86l+f99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrwD6T2UebYG+5ps8yHwd4PQJWIlwkhG0CJHjzrwEX7XBnFB4VqIgX1THIAjIRHBuGgtBL+mH99ySlOiPBDNA5rbpwimrIQl5R9CTo328WLrNG2VuxliwGfcRgTn0FGOIftHI/RCq7EhEg0gWqjm62nU2ayAeKG1Cn0jkpBRwH2wHZkL+qwHoOgGS8uwESO5lJB/c2+Wl6NnUKDlpRH1LZec7P+sBXnw4VbGRuwmp9HkV5ybnpNpYXwFs8bNVZ0Ut4wYUpQy7UyU4TdKSkgTCyFJm3yhzBB9PgHqXcmt59P/cpMlSNRNKFjPx1jSsSdyLFVWdTFZclnxdjDB+nHjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fo2fxte7/1Yjgk2RsUOE3H7mMgOImB57DI9puWXrp0=;
 b=XGEwOtrwxWphARmI5YA/Umfl2wdEke9VfdeEx+2BZhb/2VuDqTnQmeGA/KCOpBpfbI90usdD04rd150gyhy6ROJ+dARCQB8jola5UndsOv7AXtZ64hfhTnA2CrJPelbJtDLkF+oKrZpsyCaN0/6WavJal/U3RuCis1fxissuNIC5Swvvjs/Vb6TvEYUBru3x2sgrTiR5LChP6TzYxoqQw43m7AHIoxd5/AxUALetlVKDDNy0JoFLfWtlpKEqpoFLbxhZNxk4QlpUlexnEkUyrq4JSozBrPM4lmU9lmcG0cGH9Jwhxj5RVxdbY2mrfWexf0E82l6KJqlJ1/SLNtZ1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fo2fxte7/1Yjgk2RsUOE3H7mMgOImB57DI9puWXrp0=;
 b=S86l+f99jVtI8sQhT+RS4edEF75hKy3lNf5ioLfGVzJOa+WuOIBJATq4ym2ljaJv0nr6TwgzTimW11O6Dv4F0hpZIFcKki4qtUltY7l2pgULTHhCTu2N2wK/ci+9IkBNlNUhKKAwkjehowSWwnVU3wUY9Nj/Dn6S4wrKiecRGL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:12 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:12 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 2/7] mailbox/pcc.c: ignore errors on type 4 channels.
Date: Tue, 21 Jul 2026 13:52:51 -0400
Message-ID: <20260721175258.87600-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ed::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e79464-2e6e-462c-da52-08dee750ee83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	MYqD5+Zj9LrPlFfgmSAniAULIY0ok91W3CgfnI6Us0l3hdq7hgYb8pL9FkqMpSPZ/dusnqQrwXw9GS7pripEt7syrlAnEAjwACOAlqznXCjupzXt0zrBgwkikd69wzEL6F085BbAxGScZNZDUftePmc8YTNIxRDS5+8JgD1xV1dR5Gv5klkjdcBAMavOWVqniGLaJQnBd1ynpwRhELarjGThBb0fyRUTRM5FEFJVmyeKd0zKA8UA6KqOA6GWPruTIZngsMxtZnJUEPm4LoH5/gs9G760MX68JV2s0WGm2P30bVBjRja6DRo19gSlxU+zdT9RRWIlgYTvpdcqf8BGCn6cw45QALvncxhuuSHooyMaok3fu+xs/Vhqgf9Y8bGuSqdlzWagT6xqiWsbCz6rg73jvKxML2qcIpkj0G9ssJiCLKa0It+7HSpRLH/czAQXJRGHDKHo+hduPAJ7L/APbqln1hEvJKqjx/SY2YmD8j7jKFNeHIOFoqBKdBjGqlaBOmrr6oKh0IAt5grjJlHvTogW8IwL6pQKKhzp0tWML4nop1fDt44WqeoUC36vmaopvzKjK78Cw4ZQP21CpNyZt97JhsVLq+PPU8I3C4ZnXLyF64KR+0eY2bLm6iZ+ZX+fOx58MbQzXp+zbPuxt81FYrRZEN8sJFQ4GRM4y2nOSSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Cn2jJ1qFD/7nnWRpRqUvumjYWoURwgGOiMhR/ftx+C8ixIHCkRpY4pHaDb9?=
 =?us-ascii?Q?Y//M0N/3mxCz7vkxGvpK0YBZlI5mEjadW8uF8nJvOx7wHJ2V2g8slxNs1UGr?=
 =?us-ascii?Q?jh6SpocuQTlsuDfMMMpu+vAJIUfTLyfVINHs1ub0D0ZCarMU9BsO4+F876id?=
 =?us-ascii?Q?c4kvUvJ7LYwE81QLBb5E/BDhScw3h8iAOdXefzxdihSBVdx1C8fuJk/Pmquq?=
 =?us-ascii?Q?hMRHWcgK27x0p4p7wrBu9LE+5ImbmXN0kIIgeZrgnlp2DyivPULD+U+ztI8z?=
 =?us-ascii?Q?iwnyLDZiotiICVV2NyzU/3e8vzUglMxapEu0ZLrvoBqOLVdCLfLCjceJnSXq?=
 =?us-ascii?Q?A2bS65/prZRqICLtFF8t6pn71mQupDECdxyKkfStTP9LizYcAldx4YeYvY+G?=
 =?us-ascii?Q?4IvOfn/ZryjjBuSBwLFZYOuylqVLxs14YF4bHlA7CD2g5g3L+XDNx+ptfY6L?=
 =?us-ascii?Q?GFsBG4B5ipWMKE05SrmGnjE+yGiVP+raGFjEma3Z0WN5Dr79y7TczaSx3GpL?=
 =?us-ascii?Q?tLG+F0ySndyv9ntyHEurhRPooaPuJ4bWbN84T/Ttp6SaCUvFpvdEKwN20Qg7?=
 =?us-ascii?Q?/byz+jpv9YQR3NhSf+EG0REtYGtr08XGjh4Rl9WT7jD5g8r9/8L3XSSQTooG?=
 =?us-ascii?Q?YtSqDXnUTfIetZQTMRrBsUQrDbeOm7bTV6mvGY+twTT8sUhaWB4k/JJEbVcB?=
 =?us-ascii?Q?6gLipdejrpMx1lbXGMfjbkCZhO1/xMzkC+DrXvyRrTukGsx1smyttydPn+2q?=
 =?us-ascii?Q?odSYe5+lnrmteUg/3H093gDxyZb5Aefe5bTXwVpNV5yPC1nlPFTEyp81ad/6?=
 =?us-ascii?Q?aKj9P7Rfoq4zRS0S10eeaHYgIgy4YXHBOh3J39ivVjo5Dwb4NCHWWDJTZ2Yf?=
 =?us-ascii?Q?XAuEL1ACSszPhavRKuiofza8xWwe/3b83ypl8guwI4SaRZIuVPMhC+2vaOjE?=
 =?us-ascii?Q?4FVJt8P3sWmVz1KQEZb4D52W3CIk9a840ddS4yW6wonXrPd4HTCS/ZuWrzR8?=
 =?us-ascii?Q?i5xkXTwuHRPj/nOj7ppPxDWPtAcF3Z1ZWY2H9Jiz59MHJXvNuzJr1BrZS0Pa?=
 =?us-ascii?Q?75Be2r80e84E5xR58KhKhCHQ0xyLowyVAhvLZZq9EG1YARPBD2WDF1/LqtyT?=
 =?us-ascii?Q?ea+u64m39nQ0sscBr4iSfaJRcTubYZS7CQO2ois5YApj7uxd/zi9/4ksNRsU?=
 =?us-ascii?Q?O2fPccIag4aHHnm5WpmJ2qbnGhxW5aEzk0tx+xi9k0sG/7vyyN/zfPTVAIUK?=
 =?us-ascii?Q?rqmkvfsqAwn74UpqKtm3JJMVrlphzQU7IPpJ/u/UIFf9KJunV8pUyrto0Pvg?=
 =?us-ascii?Q?5zbgTAwGTmPwu5F82YGw8v9D78VKeBOnw6sDsCtmrAmzXp1W/B+tVaH5O/Xc?=
 =?us-ascii?Q?jyyi7lqYPXF+6jXRAd9VJQB+g2vu9xRNoorKeFy4tAESvLmR+rj56jRTEbPf?=
 =?us-ascii?Q?jMKoG3XlbEeFvPn5vE5aXURPILH9sVuaNYDSuJnbvW6vAV823hMJsv6Ex1GO?=
 =?us-ascii?Q?8XIoSFfkbUTI9abHqTZAK87rmHUZzP0augBRlGaX566GNemxzyTtOJSDnA8H?=
 =?us-ascii?Q?RiBAgV5bxVabNgnpc+T0ijPJMWrtE7EOPaaW5tv9shlN2yxg9xip+po0b0pS?=
 =?us-ascii?Q?GAOnpnAXq3RJxzRqE22K0XRa2lCuIZGdQyroMVSH+WbMrwYnCmBDX4bxe1Z3?=
 =?us-ascii?Q?I1z003VodkdCOuLIaJdbIOHFs5pj5pKJAzSv4QqVpbHmSg/hCOTbtV3MFv2/?=
 =?us-ascii?Q?CvXkIWM1xDM6UD6W9kDqKQwrGj4Q37VTmOKS19XaZjSLpm/0gVZciqo9roc8?=
X-MS-Exchange-AntiSpam-MessageData-1:
	/yzbVYdd8VciZO6FT+OE7ujde1LyW77I1cWxDnar/SSEmI4Cv5xEk/4m
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e79464-2e6e-462c-da52-08dee750ee83
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:11.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGQS4GLbZJRyoG3KL2Kfjw5CSruTsyPyVIY2LkV4Utpgj5Fu09RI1Vs7dEBndxH0tMphyREAXRfK40jeNrSvEZf4mujLALdyxPgBTha4HwnIXjkZ/WtWPWUxwXEg+Sp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

THE ACPI spec states:

"[The Error status register] Contains the processor relative address,
represented in Generic Address Structure (GAS) format, of the Error status
register. This field is ignored by the OSPM on slave channels"

Referring to type 4 channels.

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#hw-registers-based-communications-subspace-structure-type-5

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index da26578a8aab..3c059fe87ce4 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -270,6 +270,9 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
 	u64 val;
 	int ret;
 
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return 0;
+
 	ret = pcc_chan_reg_read(&pchan->error, &val);
 	if (ret)
 		return ret;
-- 
2.43.0

