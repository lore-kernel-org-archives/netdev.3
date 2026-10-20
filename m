Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516571;
	b=NFXi72Sb0URufcUyeSolR419hbVFUl78wIFzeHqiOBOSvQ2fYAi99xmWTSScgEpZOGvu
	 QN6hr0cSH85Y5Hjse36qucJkUxVLjqUaipVRHTOTP4zrTSXE4o1LQ8aZ2sQSkLkGryYfU
	 OSyuAVbnw0g9LXmKCIu9hS/iWVeWxlLNhg8oKdTNQeV+hsv+Ow1Bm2GAU6GGaa/dMxMUN
	 qHu69W8E3JGpc4OO033Oop8iaE9nrxSLN1u5ngWnB4RLUCj0x0x8iz61eKPTE7Oyf9sru
	 MIajknamoeKr/AqL93Wt5lW6DQQc6NZzo8XwKFeLjC9V6ZMWZb2RwQACu5lDvjlpTPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uNhnt8RQqo6qToCxElUhF7QOzL/4w+f23aQz64S+Np0=;
	b=LSxr5Grr4wiqFLgeJG3iqoIccOEb8CuC62vavXM6JkBpmcg4LG6SwA8KT1w5Y4GyiXBK
	 sStRHsNCTBseYW7aLD3tBdLEZ5CKh9YROEZQ4hA2n8HpUsH03PrPQUc/L3cmPrRQCJLJd
	 5gvXmP0yDzLn5IzRf0RauQnafwQ9JQrhOkrQG9LPoag6NK4r12Cw/k/1uK0EarRXELVC7
	 gEg7vg/wXQ2QXpSUmawhEGUAQ2NoDsWZHP1R2tlni5kgNStCE2pbsnXwGnT9K9m5sOC2k
	 V3N39YIYsmGpqpK0l7aKHVvckMqshob/WY74f4qaPHcDrKtP05cgeEiR7BRjlvgjyhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B+bq4GCe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.26
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7E606B51A;
	Tue, 20 Oct 2026 17:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D7E606B51A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B+bq4GCe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/3wZ1Pqviw9o7zJJeN6P6K8v4VHvkDkKkHnC8FKU/qLjpI8oLfmLvVLWDI4vZpR+tirDP9dP64V8lqSunWZnt9rT1soPkumBStCcRx2+SyvJ+T/y6VUKk9JAqHrkMaveh0TkDTVnlLbirGVjhENS0oU10/lKyiUjEiGhlBIFlItqjhMteqldEkDEg+NWUcgtLydYZ6p4kh9Sopz6G3Iv7DfUmNyLriVYEEDwpsYErUI2l8Oyj2LNOEtgVQNu1DzYMCArtKRNG/1UxT1DYRuw5TApag4wHD5zyag/r3kxCYGpxyTqVyuw9fBm4+caoORpHCFXH0+h9++sMo2lfmH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNhnt8RQqo6qToCxElUhF7QOzL/4w+f23aQz64S+Np0=;
 b=uIBlk5qO5mThFcnKPlcYAgZFA0YxD0/qKrTTEwHZaessaR8SoK77ZWev0Rf+KmrsaMlzySj75nkrwQctobFTTrdTHBd3dVB7KfEFM6MzwM0SJ7yQ5YJUJKamL8ArGIp7tZjtFk7VSteQ+OhDofGgGgUsHC+ZJn2S562KF8JKwf/0MPMXOARnzdzX39ntaj+PUkorcXEMSYRd/zMHuZppzf47UuUI8qiSesM5ltwTF3GKW+cHUxEesrZdBJZyKPYTxLf691t0eaRZqK2eSRn6t8ht75KZqN6+vLt/5EjzS4D064ijwacCQfpA5okCL6mDgI6jhWCVm8ias3ZmJhUrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNhnt8RQqo6qToCxElUhF7QOzL/4w+f23aQz64S+Np0=;
 b=B+bq4GCeaiVEXlTOtJCzl7adVNuysjEydP9QSHFW0QAketX9iL8DJeapW3JLN0vb/dAqgaGjDNIuwgYkiXxQzTO+qyxXOHBzA4bN3gLwxnm91jec6cWDakhNxId9fT2nc9BBPTUM2pJEDzJNadFVlxntdMe6WDsDerA7sd+SlHNKdQS3lYWqalpmWcoSNXBDBBMBw3qhrY6thA1z6Nl1TqvsMoICypRXD7aK35AKGY1xuv4Vrfe2gWx6tOxlj3KEac9SpYXKcSBIRWB0JqKJsLiEBkYC2UA/7qHDtHeItFb3vgKvFJ72YGGK78f7RPjNMhiajsPXnYEZG7Fn29ImLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 17:16:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 17:16:05 +0000
Date: Tue, 20 Oct 2026 20:15:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] erspan: drop packets with an unknown ERSPAN
 version
Message-ID: <20261020171555.GA3236673@shredder>
References: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
 <20261018090236.2487997-2-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018090236.2487997-2-yanhaishuang@cmss.chinamobile.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a5da6f-7245-40e0-a19b-08df2ecdd2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	l1/ZsNHHHVHGkQFn4idD2yk1yrj7MYMIHRmzVK+PRo2PR9Yui5iYWm+K+YSYeNO7ldGaePfCtKmSzrWjuAUGeHynV4ZKTuYSVs9Hvdqc37VK5x/233OaXmvA4GuuqbNCKir8KvXiE9x9oJfuJPnHYtvAFbAD9ErCOEr2c+eQuRFytWRe0IfXkn4DjJXILstqPfWA2fx2rJtkpGerocMHxAHTkpDohdx3WLS1BCq0F5Nn4sP9Vi5GnzupbfrUpI8Uc98+D0vXJaltmjuwkkXObboZW2ww/Yui21RkTVp9LBKg5Bpm+htqihMiUyfF7KRKF98yyyXXhU2Gpc7UrnSsTI5Yk+STnuFcHloPxcMvZER/UBSiI1I0Fy3wYPxWhl1opKdDdxKXmngxdqmhYSIulXsPei/2a1dYcOkDHoDDsC7sQ9daXfGaYZS3jO/qz/JEq9UFIfNb44qW4OuSnE5ZM10bD1J8gL3VHgRxgs9EqVnhH9ZL5cCwqEMqSpSoXisYYBBHrPxFyi5GCgOX7+WaQ1EiwJMytfVj9n9NTsn2ONsDUMke8l1Ep6QMfvIZpS87FX4Gz8FuNf/j9fVxR5JLzyiE7C4/v+OZqJhKmcOc4soeUFYLwXjw3qWjw3KYPj8HHXop3wHiDjmX+qmcoWZd+KcMXOn6fAs3DMGvqSW7kVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuB5DXKI5Lx0gSsjXd12pBOTw66pKFBFdREKQo0uyMK3S0kX0dB0CuF4990m?=
 =?us-ascii?Q?DR+ZShdiTaPtLdT3otUf2QNN3O+cuD7fq0yFJy+tdvUgrEawBG09oPI6dMzF?=
 =?us-ascii?Q?I4w+Nvn6flbSUfsbvmWbXKLUQQcUAY7Up+9UKOQnYAimjJwaydoQMk5fZYvG?=
 =?us-ascii?Q?MV8AMYCoFtL22QBCPt8VzsCUMh6bFLy3OXJQaRhgMyen/GkxzUSgO4uPvfyx?=
 =?us-ascii?Q?PRiA9kpY18aWsdGpK3QuZROZDQiCZH8OP0oaS0asRyU8T0PSBOdEAQ9w9Efd?=
 =?us-ascii?Q?zVCN3mIE/veYAXElMiZRRaYWL/fhhiC4vw6nVJ9npHBGt9X3WRv2mAnTt8Bk?=
 =?us-ascii?Q?L9AZ7FNiZpUvqYQYPMy21emQOIaTIfMsi7tEkfvfJyoEGbtd9byA6Pxe6hKf?=
 =?us-ascii?Q?G+XpqdP7TrGLiW3MgfLkEyQTHIpcmG9UZv5XTyFlV6aFn9A7SJgZyzVHgV33?=
 =?us-ascii?Q?WJ45r57uwv5n8r5AFt49H1QF5JG0Ja+IAvVZoN5JFxYhZvvRPCpM3RL5pdOw?=
 =?us-ascii?Q?Mz/Omc9L6VuNYewstVWYjHC/A+OJ0V+F9423qGJ7+TiTAnetzaPvudG7BSi6?=
 =?us-ascii?Q?wQNBAuLPpCtrHRMh4DyU97+z3B3UJC8gX/ucV8mp0qztBN7FR22c6hav1h2w?=
 =?us-ascii?Q?Ato4JU4hbH5VkCK6VIqG5zHabxSpKNiZ23UIHcsfEMuo7KckuMvXjx/pwrZW?=
 =?us-ascii?Q?JomFSGyioMsf1MCAyUAdcyZiwnV9Tv4xKTtLVjTj6lpSFV9hDvNPZ49mZm4O?=
 =?us-ascii?Q?lEMMzswoDJbu4dmVrJqJOebP3EJuQZiiukOrrYXOWJFlE5EPcCN0G7su6MbM?=
 =?us-ascii?Q?XYyAx3LjrtZUUyAS6mqYw5hlPr+wE43sjdZpmEg+gay6h0KcJlB6KLFDUDZ7?=
 =?us-ascii?Q?TmFgeomDHiOgXdHNHnRsgQqg+BPZypP/+ogRxD8HA35YlU2sDqv0ePD0fkYc?=
 =?us-ascii?Q?ojAvYefyaCKRIzh4F3Oa5u/0/oImMnactX0C8mor2BxldytAiakAE67rWy2N?=
 =?us-ascii?Q?qdpcSkPN48vWmRA32L0tXB/S4XkET3AEhm3MNqG+lSG+c7Car81RIkNEqOgQ?=
 =?us-ascii?Q?OxW/3Dn7iPYG6ZxpyOH4nrVA7I5jy71sToseA0I4KpA6L/7taySsyqmvkYsI?=
 =?us-ascii?Q?j9N4/mDXsVURVMnvfGAhD2LSjzQM8Xsn+M5GnQKlWGhrplFngb3PDK8Em2e8?=
 =?us-ascii?Q?n06jtt1N6mvHXTSJoeZj5SypqIpNdAGhb4zouiqh+foqsUDiSbsYY3qv8yyO?=
 =?us-ascii?Q?bLNIXulY6DFwwbhRAlC/fH+9lCojd0Mt4kFaS0mSyCaDjbEE9X5E7dHxVxfk?=
 =?us-ascii?Q?z6nc3gOREbAdE4APoo8Q4psSVdpiQVtk7a1VWWYv/vyPr0t9OLphDwMmczdr?=
 =?us-ascii?Q?Q6uLjEtBhhmmhbY/ft9Y6+VkfhLdF+7oPQx6oa/FMS01tdSSFWrcxlplMHfQ?=
 =?us-ascii?Q?rEzDqMA2ugr3Q+v1ZDtNPm9iN55ME2aMvev3P5zUkBL+phZ+HYlFaJdF6e2o?=
 =?us-ascii?Q?cbYYYlhwszeyisPnkNtM4M0rnLZ//7iL86j+uis8HBjHhAyVBus+shReGMCK?=
 =?us-ascii?Q?4wKMac1TTAOfhFG+EWeAYiiCc6w0tyZhatreRfeswWpA+ewYhCz6N0BPSRpG?=
 =?us-ascii?Q?+747yDjeGWKK+0m27NgoQ5sHsgjwqqBhGDgMqtVb21Idp/z4E9JtEJnSBlLF?=
 =?us-ascii?Q?Mhf6jX25P/mZizHDyUVsrJKNcF/BdO3Tw/D7bdVqY9/Oyddm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a5da6f-7245-40e0-a19b-08df2ecdd2cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:16:05.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeT9ZTtq1X3pZ127npdD6p+T/9jZF9cVPPMDJ4kC45wKtiD73UNpVKmNvaQi0uRZkfmnFjUzzzGEawXThb+Teg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

On Sun, Oct 18, 2026 at 05:02:35PM +0800, Haishuang Yan wrote:
> The ERSPAN type II and III receive paths take the length of the ERSPAN
> header from the version field of the packet, with erspan_hdr_len(), but
> never check that the version is one they know: 1 for type II or 2 for
> type III.
> 
> For any other version, erspan_hdr_len() returns 0 or the type III
> length. With version 0, the ERSPAN header is not pulled at all, so it
> is passed up as the start of the inner Ethernet frame, and in collect_md
> mode the metadata is copied from 8 bytes after the base header, which
> pskb_may_pull() did not cover.

__iptunnel_pull_header() drops the packet if it can't pull the Ethernet
header of the encapsulated packet, so there's no memory safety issue
here. Only reading metadata from the wrong place.

> 
> Reject such packets, as a packet with a truncated ERSPAN header already
> is.
> 
> Fixes: f551c91de262 ("net: erspan: introduce erspan v2 for ip_gre")
> Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")

Given that this never worked and that there's no security issue here,
drop these tags and target v2 at net-next when it re-opens.

> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
