Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793635932;
	b=erv2sr2ACAYJvxrxjv4VU5WTIGPsl0r4quWusdUGD3ktCg5p4q4TD9RgIptzs33+3+2o
	 6Ttw//NDNV/h8EjQ2DSAkUrjQrwCexVJbZzOinNT6rlROXdtcZTk2Uc2Y0zr16d7v6fL/
	 18D0+yaFdb8veg80RRUJrSjHr5cJKHyCelJD1zkOLTPFRKE12jAZCvc8X/BgZ+EgfdRI9
	 J34tm/tLTUi144wpDWqBcqYTLsBfccCB3UN91QI59I4qVWaiNIjAiZnrIS2rt/uzjQWPE
	 9iV1SK8ZTjEbHDUaRVtAUyPMnQe69ez3Tiyc9rr+BP5FWJTRKF8ucL2Mh1rgefNX52A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635932;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status;
	bh=VtG46m/z52xKmXpebB+kwiqbFvfv8uxemmSbCqfRRXg=;
	b=uP8+tZUxrFFtqyFJoc1pCDXaRqIE0Mz7lwvLQnvhrwAFZvmwZsmbzhib1Qr6dLpSX3T/
	 fxIq05+Cj0xRV47EMX/UJ2X7VDtRDBInfWU1JASKWPCdJnYiQmSk7TdCAaX8DtKoR3lAr
	 bYrvzA4h78Yjs+Oe2rLlSPOGNTeXnfLoV5GEGccnjQXQkiiaxKXgYXyBOaHa1VVI37s33
	 Fgf2OaOEvwJvD4IZELWa7SfFSzhEZFq7RCtQB4cQvgtn6XEbcw78oy/XYtF+TqPsoudei
	 9+YHJeC8RtoIAJEbxIjCDuJ/kbHtdo4bAHnMlCTH1u6R87CpmDt8qT3MeWGjn2LFcgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=u1EVKgxl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.41
Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29946088B2F;
	Mon,  2 Nov 2026 16:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B29946088B2F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=u1EVKgxl
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022141.outbound.protection.outlook.com [40.93.195.141]) by mx-outbound44-116.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Nov 2026 16:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVpAmCoudx0Xhg/MjKbMD7701Ii/9aMIgeewneizIjsbmLVh9htNIwwFTC2DSwC0Umqw24gvdue0OPiFrr5sfYphMcZUOkXxIhZypcqPjn4Ss/T3aKn7qN6aMGjiMZ0Jb4cGNi/5h1oEMSrwV6tvoVB5LPZU2ReDoo2YWQ1WXnxEVGUS81CMBnuLzWOm2irlaYry+48xLDfAgprdyceY4QBkLh6qjUc0GrKElNh9JuMuTWzZeVju0Xo1nxzzyQBje8B+l0KuNYcqITjLmeoTXRENYOPZyy+HsS5v/u/8c4xYIe9aCqJBap8m5Fvo9Bakbw5Ax8RZNFNKqMLJtk/8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtG46m/z52xKmXpebB+kwiqbFvfv8uxemmSbCqfRRXg=;
 b=L83YK9/8unJmG/v57wlfr8R7Q2F4PIIBoTNvBkYefXHJW2YQi/iME9kbBj1HqEYtnn34DxDiyg780o5lB+OVrdTH8wbmRBoayPQf6sE0nh9B44VMbAEEXVRYzC3KDyD4kRT/LIwXZKr1BN1vrKZ2UPY/rSpFmDq0XIjzq+A5/GMtuTwuHgTGSlT8tMUn1BkvC8+1VwzaPWlrn8rm7ZW0X0xZRMU7jo55p4OkLH+qGuqGgxO3+pDVKfs6yXh5nxraWmXjqBMmQOwJgGPzooF/pXvZjyn84bho8wEvVNcQVdOZw+c7EiCvQesH8+IHOuGixycu0sIHzdRNQjAXm/fsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtG46m/z52xKmXpebB+kwiqbFvfv8uxemmSbCqfRRXg=;
 b=u1EVKgxlvL3NSbn/P213BrJU9j2AMhSsChVsfKsVuKsiWvjQ0qb1sZpYMsZOaA9OShNPeNAhzFOSk56meblH4ISewWxhX1z43ZtgjDhw9SRE4gPs6qiEAEhjEbr6qewMRfxzGMaSpuYt2LN66jCZAbc30kBPbLyW9L4n8gRTo3UOKyzdRBbnOUZzn7Yo5uOUVKKdjNKlbFqc+6GkRjxvdQTUalugvg5614yL3UUCPKAU2xQIq4ydfNIFFFGzsoerdQ5YLAr1kUHnja4SHYut40xcL+JkZ257WN3iygpcJ2eTL7s1WsdA8HOFvRYIM3p5NqwCYiu7ueqiWyre9k/LsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26) by BN0PR10MB4885.namprd10.prod.outlook.com
 (2603:10b6:408:126::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:10:37 +0000
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a]) by DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:10:37 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Daniele Palmas <dnlplm@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced
Date: Mon,  2 Nov 2026 09:10:34 -0700
Message-ID: <20261102161034.1530788-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179340002701.3131.15535297427661129303@kernel.org>
References: <20261027171055.1796482-1-peter.hunt@opengear.com> <179340002701.3131.15535297427661129303@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::25) To DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26)
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
X-MS-TrafficTypeDiagnostic: DS4PPF6C5A39D55:EE_|BN0PR10MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c5ad3b-15a8-457b-4927-08df38fbd4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|261102123227099003|56012099006|261021121427099003|4143699003|11063799006|261028144727099003|261009223027099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	txgnGfi3xHYMek5XUwfl8jP/++itQf06sY/nyA04+p/zCZ2YtIwnje1V0aYx5M3y4ZIVwLtz4ZcirZmpnQqSXfI12YURgC47Vdr6S0MYcEbeNZbTQ4Ye99fisKa3b4VQpBOGMkUKbplfx+90juDuOMcLNUkr12PKCfs0NN/hhS/SWUtOUsYOYNkhpQ+JRBZWdpA/DebAawOtpXm7VO7mKmVBglMOxNCHX1icxP4LsBzACjeD1pFhtY2/KvhzTVAjE3ocWHBLb8Lz59e4O5KWq1MCnAxbKlRvtFezkEdiZiUbkUJLwruqt2F1RJ6+ssgnIpBQ1LN0lFOAhGX2mWmfKssyzSNmKNSdPzYWy93CzmP6ZYG9x4FSSJpealUD0pPpxE7swpm0RG43LHTsfmWe6cZzLIkyRmdufEUvB6X92PdktnvhytXkatSoiet8Kb20tAC86XwgoPQ0fwVtMnnp54TOLUxQVbwUHG2cFLmtTaY7qpnSrF8zrwfUIpJsi85S3IgkAYN1rMQDo32TYPGm2gpn3PQaEG1ZeNFl17ZM6FX2Lhwd7SduHKOOPgm1jDv9odz62AeVPEWN01ZyX9OOUnH86kK7MAkcR/9koQR9V40AEuhVgdPzpNzplht6nmFxQFn+or9mbgmq3V1kUX0inND5wvSQ3dYwQHzKpySxmF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF6C5A39D55.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmaN9PXpkfC7/8a+NmEATletKxlf5NheFt/rgk+TVuZ1Q1O4Hsdl1u2hLInk?=
 =?us-ascii?Q?/Fx6HQRBVw0NSoOox8L82RAVEcK02SfRGfDeJBsLhqycYK+YiRRkYw+OY/Qf?=
 =?us-ascii?Q?ZrjN2wzjccdsmcd+spLrF3biWy/XQngr35qX8Ax41qUeE8b0OzfMSs8E3OD3?=
 =?us-ascii?Q?a4OHNQiXSD4JPsvSUH73owZAbgtFfxD/pmmOpFVN+pOUh49StP5LTmfwpUN1?=
 =?us-ascii?Q?jEBHhD/Oy68s0Rt2WgnuBPWsHt4ClphXxB0jCfPC4c7BLBCba3VvDhBhGqdz?=
 =?us-ascii?Q?prhvxPKFyxw0V0Uew51Fqmrfeyr4c597oe8bd5z4mPo3SASfp7waysT4wX2B?=
 =?us-ascii?Q?7bjWEKKdpwpPomD1toICCA56J3ZYcMzCS0RWqIB5f0zUeWak0lp734VWW9hX?=
 =?us-ascii?Q?9cCpLd+eNQqTUgki6gEzryktnL0cnx1uP6lRd+rC4ujtvwp6iGcYRW7Osr8a?=
 =?us-ascii?Q?QkITvAdiFop8u3/vnLjoEYHmab6NnJPsB0oXUfvNgGHDIl7/S+ZfmvvrJOv2?=
 =?us-ascii?Q?8c0cC4EB849qTiOv77P7M/QgPzjL0nTUpDGudQ5OZZZipmH2e8fcqOFunrmE?=
 =?us-ascii?Q?3QiApcY6PFxPCaasBnFO79lZW/AYbqxZfvyQGjZ0iNjlYJZpE2eS/7FxDO77?=
 =?us-ascii?Q?ycXSQpgot57KvSs0DHk2arBRn27o2LPXW6HqSm3HPvvFajKHfgIJ9O9q36JW?=
 =?us-ascii?Q?lx66Lb1B458AKs2UJsNaEU6RZYX5AiIFW4eVIZsBUlx+3RRDlSe9WvhKt7In?=
 =?us-ascii?Q?R3myM8shbNmlg9Vd4PQQlROUXjGh5Hc3YAT/V50aqrfqDw89pjo7uVZJ70BT?=
 =?us-ascii?Q?OYP20ZF/ZOiFWA09M87YeDg6zIlp/Le2ak9/vcOhbq3HPB2F8e09VctY/rn2?=
 =?us-ascii?Q?3CdzVa594SAFijWfPUOfuE96ULGiyoLyuUNfk75Wf6TWG/TxeFBBWMgEHgH1?=
 =?us-ascii?Q?PM3zRimoJsPPGB0gT/5Tc/LchSckcgnJA+vY9sj5JnCB5Z1nvq7KjQsraTf7?=
 =?us-ascii?Q?3NI1yTX3Pm7m9vT9Z6CbZQXT5IT2gudhr6ur+r5vL4IQQqo/Vu3S+s1tNnX9?=
 =?us-ascii?Q?2yYMwhcP1q6n6yPuasadoCCOoDMejUzy8cVqLkp2iecqtR+9bHMnhXFWSZc4?=
 =?us-ascii?Q?GZnbKuT0Z+XnayVAlg/CAu+uAgPCJw3bWkk5xAMmR8Q8eaDb3yyw2pktYJiq?=
 =?us-ascii?Q?dN3o6AkmzOy1J+CETYeitD3Oq9+9LUm3DEpumzM3h1FspXDAcVD8cbLmHXU9?=
 =?us-ascii?Q?aG1ixwShNd6dY/Qls7Et+6PphOipBCybM14wBpnHIgp8x1PcZ9sr7CW71x9k?=
 =?us-ascii?Q?llIBoQV4iYXuEMHYxBgM49is1MIeekXYJDgK51vnEOCgqJHFzZUyVJIdrM+L?=
 =?us-ascii?Q?tfNBiWnmPAGgF9NsyjTc/H5fyRAEffyqZsfIbHbs95jX3Dy2whgvbpDGMJXJ?=
 =?us-ascii?Q?pyhpLtZwLPaXiEWoJ6TVOZgEFJrTGNZXIWDIpfbIdPL+tW7INZxfM7HoFixy?=
 =?us-ascii?Q?gePsejC5b0QNQqNFpr1u5qcjjDO1uFPsVEoCtRY5mPaseVkkkYW/NAjjA7iU?=
 =?us-ascii?Q?5m9ycqjv8zdCPqqex0gkMUI3EscGTJndzs3VAyIgcyqaTl0MaMM4xkwxbGOS?=
 =?us-ascii?Q?svGNyxi5B1P4kztoTxTp5mNAJOT/1/NBPZSdPojHeEJCj2wBWq5GMY3e9isT?=
 =?us-ascii?Q?jLAMO79QZYSm3OrrEeyjZ6b87+dX36CEiuBBPJLdAS/WLRDW?=
X-Exchange-RoutingPolicyChecked:
	FUeVknPa+bS1kLy8vuoQyI9iuv+40RtTDT7vFYsL8yrDR1417ey8iBo4pofAPqNw1Zn+5oUOt0gDdhhfbV2ph8Ab2u8nsE+xh3DcA9x6k5SknjgWs9sGGH9T0Gpu7eUgzvaAu/r9DO3H2Ga+SfdNDPiDPVQUp2VKSfOtrn+zxGORaL7hA2+nHYIPql4iuN2VSrUs9CmIjMGzLMPdf1jNfnrs2pSNr17WLKbmY+iXfdgP3ZsFHv1BBb8H6z8y9ia2/hk8HmSYejtQJtO4RghKbQuK/9ETf/IYjJPydBhwiaHsk4I0A6z6OHJsvLReKylXDyjQ1ISjPr4oJeiL88Bm8g==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c5ad3b-15a8-457b-4927-08df38fbd4c9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6C5A39D55.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:10:37.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwTy+WoB3gARFrlgf+F6F4/JdeeCwkT8VbFEbfdiEW6m94PZVP4xO0NqjBmaePHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4885
X-BESS-ID: 1793635852-111380-7719-12-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.195.141
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGlgZAVgZQMM3CLCnNIC3NPM
	k0zSjN0DLVwMzc0MQgxSjRzNLUwCJJqTYWAEsRjPZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277295 [from 
	cloudscan15-107.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review. This has since been applied to net, so for the
record:

[Medium] Drop lost when the transport refuses it: right, a drop that
hits a full UL ring (or a failed allocation) and is followed by a raise
within the 10ms retry still reaches the modem as just the raise. The
commit message calls this out, but the new comment overstates it.
Tracking an unsent drop until it is queued is roughly what v1 did, and
Loic found that too heavy for this case, so the flush stays best effort.

On the flush in stop(), a retry left armed after a failed attempt can
fire after mhi_unprepare_from_transfer(). That isn't new, v10 had no
flush in stop() at all, so the work could already run after the channel
stopped. The message goes out on the IP_CTRL channel, which is still
running, the AT channel only appears as dest_id. If the port is
reopened before the retry fires, the retry sends the latest state, i.e.
the raise from the reopen, so the modem ends up in the right state.

[Low] Stale comments: agreed. I'll send a comment-only patch for
net-next that says the drop flush is best effort, mentions it in the
dtr_mdmbits comment and drops "one attempt" from the remove() comment.
