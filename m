Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516600;
	b=tqvUe2MbKPpkI0mLsd8nhaTUgAfUH5CaI/6yzben/QKoqJhNgYALL7e2dASJz11qPjYP
	 kuheUYCX9g42Ovj9Rc8O0M1GNPsa39azUCaWQ7BBLWgm0UkdO6GNSZrkfsbmlvb6g+D0I
	 4HO9py4WO/8Kk/PvRZVF2zg8Am8iesP1g0KBhEJjl13HE2P8rsxuXR9Mv/Zyx6nEXsHgg
	 Of9fc2fLUeY6BVwcwfqAnu8AbOv6lbupxqBhHDSVbPHx1QnLcXxzmfoizM72HCYUhjNWj
	 mbOoyobl81i1lMOaWI0T7X8mAxmfjSqcmSBMY3paOJbr4p5+Hq3XN2vkMcFC0AvvceQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516600;
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
	bh=XCHFZnKMWUqLXxhplJfD8uiXCuW0fj33u4JuSgVDdtM=;
	b=rFLyrsrLgSMTPey5409kRI453iwmcL/SQknrPKvXVsATIelinJba8yhcv3uar98s68/F
	 Y58E9f319S4CEnyGiqU9n0FSEeIlXNtV4Xn5+9gKN+JuNcWZ3xaUdfW/1avtKrUjMl4L5
	 i72SFDSRvy8YFdfIsSx7zQIZKbJ1h7DJoQZjlqX3esCXxDsT0/6BsH8uzoWWIHoZn6M09
	 YfIe3Cuzm4RP7i+b24wR9DiO5pPz/KPo7ciNFayf7tAHSEpCCxaAwlpCuDvVWaMylvxZ5
	 J/s4uyVc8xEzSBICf40u/LHPUEFgh35lMrZ8tKPPiF9Q10wQ1xbGLAm3KDBQQ5eWE1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="hGHA2sN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6A606B518;
	Tue, 20 Oct 2026 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E6A606B518
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hGHA2sN/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drnCUHC4cg/iEMs0v1qrAzAQqkI26g8JBonoy+GU91+DMf5z6qoi2buwwKYMFSJp/8i+wKwWJop8MDINZmV9QKPdN1vPuOTjPH0mRd5tJIr8rU3bPZP5gZxn4LF8X23m/4MLsxjNPDGH/l0VntpETr/zfUC0DlO7lR86di1v9PXp6okOidAqlLy2aHUmb5hXndXeDNc4PpVs0vAdwAGg9aidxUAVhw0eAOpy2+1dpymTkiqOuUrygdWUMOcDic6V93DBFm29lvI4F/sUhUh7TJdhPZql/ixRHD2MNjn4XpZBeCgnjXK5p+gMDpvAYEYEW3VpJBOQsDaTSRDn2DfJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCHFZnKMWUqLXxhplJfD8uiXCuW0fj33u4JuSgVDdtM=;
 b=UAooco2sJpoIBHskCsSmEjIzGpkl9FyNO4+Ll5a0Pi0R7efO1Fiy2UWQmzuiPAWZR+htouYqlBrlso0PhAEZRalbfJ4HUHe+IT61LrXpBE7jj+uKt90cXbWk2TGeHCdt4EP6Jae7PbUp3JR3tZ/cyPIOxNSpqiCj1l58B6bFRayPlVAxtC4jvTb2yabc/yym3xOj32VpdKMm02+hcRDYqNpbZKd6t7OjbzaKw/q7ldLirlN2+uhBG6jjqAWyfkb4Iyy/+dUpitE9xsOrtJOVHlq3CwONjHjS0rZ+7b4ZaDqtMd3kLmfe48V1yarig1R0bkvX5m5HLm6ZHbBy2Y57uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCHFZnKMWUqLXxhplJfD8uiXCuW0fj33u4JuSgVDdtM=;
 b=hGHA2sN/8yuZE0S139a8PPcOEk/gldR5p9PKjRwWf0RbxlXI2g7LeboEqFOF9blB/XMWwXQl4di5lrsyIi9PjlxGevpWNMzU/9Hbgz8O/DjpRBc1k7kXdfpRuqSI14k5nk3+6/3ZWWfB2Ld/jPMkGUb44vktq3LeBUdj9a0wqWlMLyUPlhFUYsajpYLuWThYFy8WGAthlrJzeFvEGDyyBbSkdKbPm8Ca9/05dyZLa2YvM23Ha5R0/vTfi46DfK0NAMayCWxzPPh5U7+izf6Ke7/XI+Pg7N3Ir7hjjUfKYmX9ENeZ7dyi1F7kOqkzkepRcn9jzZxkW5Qmee2ubco93Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 17:16:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 17:16:31 +0000
Date: Tue, 20 Oct 2026 20:16:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] erspan: skip the platform specific
 sub-header of ERSPAN type III
Message-ID: <20261020171623.GB3236673@shredder>
References: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
 <20261018090236.2487997-3-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018090236.2487997-3-yanhaishuang@cmss.chinamobile.com>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
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
X-MS-Office365-Filtering-Correlation-Id: b296c98b-b6c1-4ac5-a3bf-08df2ecde296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xaQGV/Zwh4HcAaWv/b6tdWsxqp4yZtoaUWcUr6wkmi8rQLMkAugb+J8Ngvx0dXt0JpSEgSjAq/U/4Tpc2vezcRD83RvqZ7SNXlzrANUz13A5j0Tgi5hh7FuuvV3LoZk52T06P7OYOVUfvylSlPattpV5OsR8E4U8FQ/ahUi6nxTYYtX52vjioL08kFZ7RWLo+NqZY0+v7xhf2kxWrDBqdopKdRJrDotnRaKXKut+mPQCDUvusKH57aKDIHm7qLc3RzZUAmBdp9Q6xaXThESEel6XsGMPq78B1Qy1kILFpiJj+QJkOnt/vLrtApooHyq9mhEAwICMUk78af9UtyLQGLb1UyZwqsFx6mU31Z4QBVQSII9C2stDmo3zi93eBXf1YOc/2T62FafHtZlFz2VZWyXPqbR+M/u7vjH/XXgvkKjzxOoQCOy3ABXVUggQTpX/mr2T/kvu5Nustp2U8qPZu2Nrp4q890iiAaNQTmbznO+G36djJxWLHAfkH3UX2TiqjzrmqtjBBFJTtaGiy5iRgJHUbLQ3WJW1pyTltJff/CyoiOjcxKJW6omCneSrEjgTFG9n1QY8ChAB3DVJ3efWb4KXx69Gihh1utGbXbThnCMrymAHzIDky1mwyTchew1d+36QBySqe2TrGq93HKc3AEKgw62DqKtGWCjtgTwdEWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ot3PqJnt64Vfi1ay8fe73VALCOVcjnKH9z2h+MEud6WzE0N4Rsj014znhLqP?=
 =?us-ascii?Q?YaDAkixt2uN0jH4M8eDR7+SZSG2JGXA5JvKBLjURb4FUanKjge/pyfDmT+ra?=
 =?us-ascii?Q?6L7bwf9K9ljwe3sUmDfp9HS3AcQtT2ApxmaV345+3U+UydXmkVDf06gEJCYN?=
 =?us-ascii?Q?0jotswzQJl5O0O8wiypA2y4+GTvi0WDruKP6FQLiPTfT3N52Qb8ko0QMq7RQ?=
 =?us-ascii?Q?vhSddCy0dKbFrMPzmBZ4F6tySzxSDBmShWc8EMyQlRSPq/BszrtslLPSCEW5?=
 =?us-ascii?Q?HGkGoPFYNGoLiaIskicHpBjd4pPcgIwfwbXK3fpMoM8t+d+CGaIQo6apIBuT?=
 =?us-ascii?Q?E3mtAiChQwFjkVZ7QuFag+mGFNDi5bJRWmS9R+A0dzhF/WH6vMvR7RhQmxoS?=
 =?us-ascii?Q?+/Xm40sPSqdHuZHiPGadwFWat0NhUoxEKNMWOTaDGaCVaWo7POOCU8laPvjy?=
 =?us-ascii?Q?OWWtqDK8TQgWt4/e03GDMZxWPw3AxvuxnBguu0Fg1iu+PRkKWnBCJ1bno/Ve?=
 =?us-ascii?Q?Wj6cNAIp43kd+w/eNTBjg1ilJu+FObj6eYOCG9w3RwcuZR5CQnwiZ5jzKVUP?=
 =?us-ascii?Q?egjYBFgZO5p0abqTKv7TUl2bnHCQsDOZ4Fqe+zVdMLpVVCEQOPmhRbusym1V?=
 =?us-ascii?Q?ufxXZkptf/XAqTgvvNa11cWStZNRUKvDIQrO8x6e7Kmk1A5GBgG5ZmYzA4Hy?=
 =?us-ascii?Q?0vnOul5eAUUrMv3o9/I5cTOQVK8vnKrO/JdqwU0UiZavfKqVdjwnZ6zRz26u?=
 =?us-ascii?Q?TXCQjWOj4I4iyiDsg/86+zNlctYOzSL1ONPguoNItdSkz6HOzibPz9PSaif7?=
 =?us-ascii?Q?cPkIpakMh1CkeE5UqeiUgnlnWKukihtSowbACxbXwQeQxoxOCQCTlkF8E5bw?=
 =?us-ascii?Q?PFBqbdu05nozCcsl8wDKZt1F/qsgNkZ+lOUhebbgkfZ6ZnqRgu8QLOGtnH2q?=
 =?us-ascii?Q?JyxrSd4CCWfKlMyT/WATr9KBy51RfnMGZXWfe3q5sNpqBrkIsl1NOE83XoJE?=
 =?us-ascii?Q?UjWhoG37pMH2mNT22a8lxnZHi0HqSEAEjaqydOSmRZQ5DsMwPyFuQl//ikCA?=
 =?us-ascii?Q?KOYetoxkX/cjoJKjJ943hwYV7gcHpLMdK2/DRqchs8CbtKZZpIZti+TEk4oo?=
 =?us-ascii?Q?ScodBuGCsbMEgptnybvRmmiGeE0i/MyisgA/GYy3tLxhlYWg0gqJ7giG8Oea?=
 =?us-ascii?Q?xvbItUrLNMTvBuyu9D62+nihIPI9Ry9QgE80DwtU42qm0yXY67pOmrR2qtTr?=
 =?us-ascii?Q?EjN2wxrr85s5KRSd0edLZFOqwwzyPlrHo7V8dpSeFiUfLwhXgJ96JYQSBfW8?=
 =?us-ascii?Q?WsTA+vJKJeaA/RpSp78kY+JOtkpeROK9pJeIxcdetyYw6MrnnumjagUwetF+?=
 =?us-ascii?Q?vKYAT4mJBN03+wrkjVX+GI2umy1O3SudC1LF7zGimn/piAeBWAbDR5YVrgfz?=
 =?us-ascii?Q?eVcqPpDSAX/YEsF/W3dmM5Pd3cf/O1u7OH5Ljq1HMaljtCgkOFd5pnsLm3kG?=
 =?us-ascii?Q?rxH1thOWHn2QdkcMEC8Wa4tFsoeeQKKDqNJs71IVs+OEE+S0cJdNpaPVOlKf?=
 =?us-ascii?Q?ax/NocB4WJ8N17DKWV7jIlx6pLId69hBvY6dq4Ybz9fSbW4ZXCfdCSW91plN?=
 =?us-ascii?Q?vpw7IHof3KYo9aRrFaqIGsRD4bmA5jVrLmxIIfED9Eau1/uW9P1yLXpQYaka?=
 =?us-ascii?Q?p0T+jOeR+4tMOaocHTJpnXr1PhHsfoPK8XjIyFRNksUp7dLn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b296c98b-b6c1-4ac5-a3bf-08df2ecde296
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:16:31.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdF4/wo9N69PkWjdKpc/yL1Ajz0/K/+jdi5FFnuGa+CEb5vfYhk5PcVtMv06r69zbwPXfmFaldcFE9AhlNCYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

On Sun, Oct 18, 2026 at 05:02:36PM +0800, Haishuang Yan wrote:
> The ERSPAN type III header has an O flag, which tells whether an
> optional platform specific sub-header of 8 octets follows it. The
> ERSPAN payload starts after that sub-header when the flag is set [1].
> 
> Linux never sets the flag on transmit, but it ignores it on receive
> too. When a peer sends the sub-header, its 8 bytes are passed up as the
> start of the mirrored Ethernet frame, so the frame is corrupted.
> 
> Pull the sub-header as well when the O flag is set. The collect_md
> metadata still only carries the fixed part of the type III header.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-foschiano-erspan-03
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

The cover letter says this was tested with hand-built packets. Do you
have a device that actually sends the sub-header? If not, then I don't
see a reason to add more dead code to this driver which nobody seems to
care about given the lack of reviews.
