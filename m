Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1B1A5BAE;
	Sun, 16 Aug 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879416; cv=fail; b=elNU3CRFC2i368VwhEBZSXIENivwJ8Wxnfd8IkvmDJQII2hrNNKzPBc6fxTYiVQLed/MkgEaVREUo+skdET97bOK04ucAkRgcUurpAD+2BI+/XQz7orIeR5gFKRHZyp88iCf966JrjMwexuCTcHILGs+xRsHj834rTwSmQvP970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879416; c=relaxed/simple;
	bh=dO4c4wgp4mUmMdKUXI460ALMJVnAEMkxoekaPV9lXRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HD1PRWM11Kw0l5vNKMnRa1k8MAdm4bAvRj/tstTJByPmDjZomKssacNCErK4JUSOGAECMa4I/XZKZih4XLudBzEpUz8fe8AXYLQIV74PIXao/YplE1165ZUF+X3S6160WuRFRepJ/9twd9CJrU3CDJoEldtj+tbd09gbuGuzFuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+zRyvON; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+zRyvON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKMnQwPE8iGFaAjC0bmiXmqrsZeqCueOf1h2VxkxSfSRLS3AZOFgzm2AKJfAdjVXURkZtHYQS6OFXa0GyzSdxFca0KCE+RKysnwkA4BpdXSbJ/xi79NP/5sTd6uGhsnmtQsatIsNRYfvG+HUULzJwTmckyCqlm4fBqtS3BMcZuzP7XjMketWK3zgGlygHrH0JWaPst9nwu5d8Bo/O8S3cxPQxxPfEZ9ZFMXip4w3zyWAtd1wHJl+nrFKnrIekAM+GTsEIsZLnOeJcpBTVIVAO4wcXYnBh4hpM4yHQyG5+sSn5/nsWuUaOw11ZfX/YrejfX9hgDObktI9tDvbUib6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vce/palwPHaAOv13RiXOQ5fDLbfgF5Y2x1ZhvBriLEw=;
 b=EYhZa1XCMmwk8eRDGqJ/N8xkFxkRIcbZ6e5i2YemFDOEI6tOBtsIMDSZbf4A1RyGFQjEPuCFbx6b14u9eW9dK429RdHRfsHU12yDCJ/8LupqvSCLGUS/+4ue7VAo2njFOySz8o+zqdsTQ1RaIzTTCTgv8RfXo5AYkvNFJ5jKoXXyyaOA414TkRcZhEL+591kcShiCslPFJL4LYRQYLz0/cWj5BMftcuJM0hxVvPkm7uqMtF1aThxLPafVC3Nm1rbsQP+TOKgYrjhHj1NpUzNBkSpcW9AmAIccIVxUwclR7rzGXOw0gqcQp7d74TaGFgj1Lf45xwMTHubrDF2P7XpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vce/palwPHaAOv13RiXOQ5fDLbfgF5Y2x1ZhvBriLEw=;
 b=f+zRyvONY7FTh4ZkU9ZfrYjTmUt8A0ca53UJXm9CyRfnQ0PC4uaHpgWDYL7bFqz0JgdjJnr5XsBA0MgDW1jEUBrqKrLz5vknSsGZLYhO/6zOxdr9NaD8TWYkJym8ZulDkeakLworP44RyV7sMo05ZAhNVkxXTfdTMcd8Iu7fkbE743DDFA4QJ/43y8NSTzjQxONz+XpAojtQlLKE0REZRAEpCCNxsj80GEJ6Pz3gYLwVk75xuCWBHmSlIk8N+Q1SaML6N2/yrFrRmmMBbn0oQalCdk9BGu5oVeJitwXNWhn7fldI14ytvoi00ZiHXbdrb2ZxKY/7k+OJljhY++Uybw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 11:23:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 11:23:31 +0000
Date: Sun, 16 Aug 2026 14:23:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ip_tunnel: remove unused non-strict
 __ip_tunnel_change_mtu
Message-ID: <20260816112322.GA30325@shredder>
References: <20260815001942.1089545-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815001942.1089545-1-i.maximets@ovn.org>
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: a42a1f5e-d3fe-4f3a-abe5-08defb88cd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	X9xlwt0gcr1mNJg2cKPsq/bCw8XE5eajjqOGk713LP7+PVmkP5lDoNP/xwXmdpQVQ+GT/ecLZN8Fcx6MjnwkCm4xmqjTYH3uBRNdvvaECcpuDBIyXV4ToFavy1SaZ9t0U+HKgmJSDVX06M8knt7Ulzi4CEF0/lsnrFbipZvVDMm87w6txMISoVyKnsR96tjhgN7xyXVjXmIcEYDHxuojyl0UueUC4oCVcW2xqPWHWzP5CuTAVEXXcw5gWLaZ79rX4bLzoc/jf/Fs8wOBqdxZDtWwxcfDQXvWabx2sPxGoVW93+1GToAxZMwQu5uupPNbNCm2AL3w5+AvdX3PEyaDv2PG03PAE3ewssf3NzGRmUaue7qHuPQMwHQe09f8N7+ctFfljgIlVjcn06i8lfq+TUPAOgFpGH9R+EYgh/n1Y8RagbXtEUudf8EXbOlGvFF3HZKEVj+5amr0O8EWbfojNG/3ul6awyd24SwWaiexatbefbYo08ZmabXFSqg1uJFMEb8VEsANpQHNLgLdTWF9776M7//ZfFC9szOHNLKMnkqVxaiAmtJ4h/H51m4LQGGjCSOdc3e7LI1hzmygGZwZUy/6F+Y04tMNYptKw6SyHywUoYmX+U5GuZuNXUqqHE8vBW4TqPhYe4XrCla72mD+NXlldeTqSX9Uadx9qAo5IiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IYqdCcbORpvvdoRBSHMZrkjN8R8fOqZfINFXJq1KwdrJ996cU/fO82YTGux?=
 =?us-ascii?Q?wlBqDucYsHJpPVRLVJKYJFLabHtIlPD1CYyqANOEXUcnkybzJqb16qdrexRP?=
 =?us-ascii?Q?ZpWS2xab6l+FHVH/fYWfIefem0gKS2ZHSjC+3sTY2jFY2i7IPIXasVhatG+M?=
 =?us-ascii?Q?UqI//Uns9YMw7aVRw9AclKZDKYkcbCzl4qW1nWg23Tw812FKAGPNXHcQtVTb?=
 =?us-ascii?Q?fH8UYU3yYjfN8J+7QWMOain4uFTTJWJRguW350/7pEFH6OZSEkZu+mb3b21r?=
 =?us-ascii?Q?xxSP2zvvtibkLON5iWXJNTvNf2+SKTNwKn9c7YFpIEacW48X5afszofRuMwd?=
 =?us-ascii?Q?jyTU2UdzT0nK5EKYrtSWC0Gvjz+OmbOcmdzRGwMcnr+gpKN1QYcVo9/piqFb?=
 =?us-ascii?Q?b6hpOAdjFqpAPT6awj8zYWixHFAuWKzLR+GNU//xVIG6uW9rIMzhW1IYgYeW?=
 =?us-ascii?Q?9UIFe+th8hb+uSoVwOI6oXP731aHD6SDf8o4jLrVDVGvspBdvJ1T7XrtLs06?=
 =?us-ascii?Q?OGmT7SgCJSlrLmiVWe4PsRJXrTiSsyLc8kC80p0ZBPA6mfCEPMLGQEjxs+UU?=
 =?us-ascii?Q?mT3O4kZbecmjgMe0L829orFElQldIJ4Vk9LN3EDQzfiK+fAI4R505z3eHHS5?=
 =?us-ascii?Q?DL3E0jyynolKEZO1WhfZfmQDdCns8S/IX7w3UqidsVMwGZMjzOgHf1mqqR59?=
 =?us-ascii?Q?KBJOLUjzC8crT1Y5ZTYU09Hr2vMSVuoAwctDBeDgloTlMs2uVtvui4CEFJlr?=
 =?us-ascii?Q?ztsfRkNYDKKR8z2dJOyRp5neycxUgm+6zwZHYYIFvlGsd0iJXUnJheQxZuo1?=
 =?us-ascii?Q?CvBq79mngfwHtKY8eq8FFMTS0Vn8tpyHYYgsVJsnaClShikAJEXwWIuJomVs?=
 =?us-ascii?Q?gzHczNvxZ+TE5SZi9fZ9wklczhhFpGpZiRpErjaAbwDz2Jdkv58sb5PDvOHI?=
 =?us-ascii?Q?yc123oTbOaULjg31XWT/PxPMF3biilBJg5NVSWs1wtxxOKAPhaSsEhc90/hT?=
 =?us-ascii?Q?Lrii1jDbfLtTrxgBo7JBhOKj4GPOp0ChQ9J3cpQv/Rf4YlfagP2unumUrEPt?=
 =?us-ascii?Q?HxoHgUsNbVP/BYiLEcIxIvMw13wAXQQ0q4ZQDOKGnI1+XiqC3a0ZYJcAhXNm?=
 =?us-ascii?Q?6oL8brjPzzKCygFG2tDfoHCGZ/BYobgWP0iIeAnIqtuartophzZsVG4E9otg?=
 =?us-ascii?Q?pXooYcaMUnKVu0KTRvTMW2kNRZUnoYiwKYSaagLg+ksZXTGp6FoyrJurDBKD?=
 =?us-ascii?Q?LKZ0M24fRmi1KanZ/ED4cPIl5mmKcYSknZowvnw7+Z1S4E0Gpme3DZ2LecIv?=
 =?us-ascii?Q?Y2lLpfFQ4MZuEjgHAr03zRSMxLMY2EXTa0bJ5LsnSx1GtX2Ngd/mv6/B/AMC?=
 =?us-ascii?Q?BSlLKNlLlcI7p77SqyqNQqQh77Ztfi00KgwlYi1xq3hyx7uZO1wFI/lwhPUb?=
 =?us-ascii?Q?82tQqa3elcEZ1P9ika4l1A4S6zQrM6m3DVxsWhBniPQVVj81J3lO72yoO94N?=
 =?us-ascii?Q?uUOm31ZEdNDf38oLO2KRGAsHmjkzwd4TaX6iwO9+N2YllJO23r8kLw4G0bhy?=
 =?us-ascii?Q?79PVR45juIldMhG4DzjP4MekKXTtCC5dtmB2Tq/cIGRY2CdaC2wC6WTPAh4+?=
 =?us-ascii?Q?qDjgi//tlkxLLbbMK48wTBaY973csb7ZfcTQORGl9XvYlavKngrXyL5U1LTR?=
 =?us-ascii?Q?S74R6bLE/A6Cd+QhoiKg8KsweuhBXMI1W+8lj17cgRdh1ZOi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42a1f5e-d3fe-4f3a-abe5-08defb88cd30
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 11:23:31.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1GgGqZe8VdLLGuFcGpfNs7kS0jpQ59GRDHme3eK2BfUjt5+1dmxpe2u8A/ErZy+8LQcNAVT/snNZfNUKvhy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

On Sat, Aug 15, 2026 at 02:19:32AM +0200, Ilya Maximets wrote:
> The last user of this function was the recently removed vport-gre
> module from openvswitch.  Let's drop the function.  All other modules
> use the strict variant.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
