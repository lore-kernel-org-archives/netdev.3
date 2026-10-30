Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367836;
	b=TPfG//D3GN+4ba3qEnORxoxgaBByysQNAzMfj4Dn1sWJvuBn9heezgLNpfqoRbrtB1/m
	 DkXihe7+AUscN7I6xExSlpSwyKq3SypXeg4JC4mNIi0zcPpvyhKH2tb25YOUYnqCPgYlI
	 BsSjZMgYQMUo+eypjStOzi92QBpZhmg42+4Xj8dpyfdbemrRXfMoGMQnwb0N/B8IfSIpB
	 XxjL2GLDR910lMqe9CaIrrPuKl2qcftUcT4WgCGZ+5w1hPyR7upKqOxKv8PHNUIEMNRjZ
	 5ETvBlAuwCAxR2BB5m+M+3AA7QfstC+ad3P/gQ4wkQyHZt4+vaIkpesoWQ7Jtxkm9TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367836;
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
	bh=edlkHQJyYlSgMDjvaT5yYyY2t9trYV6WY3061EsTng0=;
	b=JpXeZ/83GPV3mMdCIrZp5aRP2IC4d9Ysci5NMsRzMjIR1aUbfAfikcSJKybSVlGVtPc7
	 x7MCKEFtaopqVqi1o7Cr5P8Dct/emPvjCVCbHrDgfG5TgiCbuSpGheout9Gsp+G7m7kGf
	 Syfk9uA2kGTWP3vRWVtXkXfFgZZkUxf/btkioqA2joppqUf3upyvvS72LmaQmJ0LaMOh7
	 duF+HXq95lOddiW/fbQV3ZS7PtnEZvIuYrFJxb9vfsmX472dbO4kLvA+n13k1CoMs6bzD
	 2sV094E9ikiQc+fHI7aCUFZGfhEy7yviDc1WmuqEM4YVXrbTE0j46e8TV124MRywJ9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GBWDbXjW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.25
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFC606A31D;
	Fri, 30 Oct 2026 13:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CFC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GBWDbXjW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8yedyr7pubH+P1/Yq/i36qDYSfAtlOPlHMx00UGpAOPkZGirl/L3t5JoI0h4cmiLgkIwgIcMmhjegctl25ZSzu7MqfLvRsfhNUItHFWuXie9ONS3ym1Q/6Xke/TbQ6jR5H3aOn7EPxMRhZK1F1fG8bSv+GNjHBnZd/dtkuYUgMY0ULDH7K1GxuW4NgTY7kh2upLhhukpUXkF2Xunoo1Wmc24ggQGgucVfMGAvQR7ObeH+sjgxlQn5k0YnBA/ZVcfptcw07S9L+O10/utSZ7ufv8Rs2qEVNrauDLD2q8MQO9dq3oe9odHuwsVQYTNZa2J7Tb9Ok1g0jFRmi4YBOsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edlkHQJyYlSgMDjvaT5yYyY2t9trYV6WY3061EsTng0=;
 b=LV24WwMazoplWVQz/6zXfFxJaQlOvtLRNpooCq80wv2N8aP6JI8QJ/ezUe4M6YG8sH27aDjQMOtrpNVLh75xC4QlecIIXkgfFa3F1UELndVpdBabEM++C49lr9rXcPU8KdS8wKZDRnvIjNYyx6oJ/1Whr4ZuMf+LQvsBil8OuFlvuIufLrlITTBIawVW7bZVIOPCKHCKLV2pNcrbq8kuVvvjIELEZHstNBjTW/FP9t0g14anUFB3rBKmjIsEz9tPHFkOG+FdPJmk8U0c9JVDKC5yf4MtDLr4ovQjtZUv+dF/TSi5k0vtSumEZib/u+Gv4sXPdd0zBG+BFwTi7to/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edlkHQJyYlSgMDjvaT5yYyY2t9trYV6WY3061EsTng0=;
 b=GBWDbXjWr0ftVdHwIMUCe+be/v96/z0Xe2wPcCVg9TDWnC+qAAUVSt7zJzkv+Rw42gCnyE46leXPbvpuIg80pYJFxpQM7aEflWpczuhhbdBfGolptHQ/mWsGCbiUe/am2hys4lHDHET9Ckyy6lyKHM8U+INaKL+aXktFiuTWflA02ftm8RO92CnQ/662c5OKeARBGA58VwbXEm0BPpQhQhX6Ol7cS0L/xqgnxiiWo8dFIHvs8pSmTSQcVYzAJfO96rRNp0fsd8wBHstcJwigVxvlS9zoEHTrXUTlSuF8JLeDrjHjCGcOwRksueH7/71sj7+eXmbKa/QHGrr8bFY/TA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 13:43:50 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:43:50 +0000
Date: Fri, 30 Oct 2026 15:43:42 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, alexhenrie24@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred
 lifetimes
Message-ID: <20261030134342.GA36226@shredder>
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
 <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
X-ClientProxiedBy: MR1P264CA0175.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 18243e13-9149-42f4-01b3-08df368bd497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QxG2BSlncUzwFx7c0xQgXbjn5gWO2a4AxVBrh2Lzd1hmJk9BDGTh3UBg0KIDV/LManifY+10PWJc3jshgvnsNInA7QMBwvjSjCSxQetRCoG8laUgSgaJcRbPhAp+eIa724pFkFtnR35Id3/P0SzZYsf4LUeiJ8OyLbKZcpPPBK0VpEVNGReqFcMq2AFekhaHPBr/+tv2slOzy6fVPGT/cqNzSN5GLgJRpZjsr6wZOWrpkrG8DnIkf5a+SIetmhMRd04+OVBqRvzBY5OtnTX6jgpQtcXCKtwP2AZ9YyT4E4yObMmL4OWuTFJ+uqiWe1T7s68TCapDrtHyxhx7W4tbXtOBedGxqbbKb65R59/eixbDroBdmF/MVPTmlJ2kXakVQ0hvRJxhdH4v8fzOp7Apy3mZl//qp1nrPRXl24QJUNKC921i+bTWFHV+BVDsFEpnTl/ubjkcEWvOmG/b02dEVj7FnhYreCEoJGsW3Xo07ygxJq+k5UNVqpJvorH3M4WUCe3na7RQrd5wnLZfQAMK3T2L7sfA6+8dCHKXZtwR6A4Iia7TQjEF53vC/uNNBWl5smPIfAuV6XdhiMgA5yWn6pBynabbiRtmFeA6ztQTTBhQP48GVnmWAGBngXYbPdUSASIZ8mGlef3Y7UeRQ2npkZzQbCx+gmxTGR62lM6gwdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlEaNcLsYDhuvqCHqYOmKrjX2uRagjeaKOe7sD9GS2Thg2iodFr1rJQApooe?=
 =?us-ascii?Q?xsIEJBYmWc6Beh6H5oScrqQYgb8kVkLA3js8XELQ5CvrSrWWc5SKc97J3GTL?=
 =?us-ascii?Q?9tcEhycQD4Xg3nOoPTDVKmc97sQb1hK5RdOV1zOxRWOR6Y3iOk6+rQrMb0x8?=
 =?us-ascii?Q?/z/Ryz2wBGikKtB/yRHVJ36bL6zNbFutwvJVz6aALBmdlxGHMew6/1gwG6sM?=
 =?us-ascii?Q?geiUhLI2OWx3OPj+xJQieGc6IzIHEd7gIo11vU6W/JmoicWbtRLHXZlJCKNq?=
 =?us-ascii?Q?FbPa7ksjstIExFMwKIX/leMq5NYnuy5tWW3RMMEx3ss/gOfUDhQ0moDHzBZW?=
 =?us-ascii?Q?QOlT71Ecoxgh9WwoeLIZFF87dXp3jcSZrQxN3eckV+YUhcmeoFF8VoxRGfqF?=
 =?us-ascii?Q?R0tqQwDia5pF+bWupBqAtrrMbOUaEotKhS2wdcgaXEHQEP6cwkavzeIIyQ1V?=
 =?us-ascii?Q?eG4fu486PIXFFSZcJ8WWHDK/ybD0edAY1DGqjaNMmkFAHb989zK3TWPDotX+?=
 =?us-ascii?Q?DRuSQMXFpa5O3XpA969TnE0/WXAAw4QbeSA9n/3ta3Onk73fGmBUzxBkHFKa?=
 =?us-ascii?Q?RvvHc1kqY/uO+pOZKygK81Kaq92lpSm9IKKZA+je1S5XlmfMOVXmX9bb2rTY?=
 =?us-ascii?Q?t2XW13zGaO/PYTcJrA4gshs3XAzRbQQS8zdhEPpMVRAFQy7D2kHGgaG8gZvY?=
 =?us-ascii?Q?rk36pM72N4Z3/W2eTcNi0IxOgY5y2UNp+I2EsyBv++EZ/zRZdfrOxJMrunqy?=
 =?us-ascii?Q?mR/ANM9Z+v25yqYlTleczWfDtxyL7WuWDj4vv0MGdFb85276aUEnPcjiMQzs?=
 =?us-ascii?Q?EHNwp6+VaUhAQuZ8UNF9DikdUahBfFzGC+QDCCuXS214IUKlkrFZC6ut7bAU?=
 =?us-ascii?Q?kJsGERr7KQFETnQXCdMI9YoWnSWC09oB0uhGkXyozhEnRhcVwxGDJRsnsPe3?=
 =?us-ascii?Q?vSrgUrW4LNjcFp+FXUonMf5REnhy0Pg/bxnj+X7bwQJA+z/lFeaBd+S31s+L?=
 =?us-ascii?Q?kTxtbJxfQ/q1ZZZJ8qxPuK6DdbNvn0gaxl/ao6T815+79vf+2+ndw41Y/6AY?=
 =?us-ascii?Q?rIDGPDIVeXB/9tuCNMefTrY6GtzjwgabB+tZPa7W+Ze9hxYcBGyohzuixyE6?=
 =?us-ascii?Q?PjXE8kMY8XxLPFxjDgmRPwazHT1SS2EsUMf+0vzOhz9jy8YniB9tToHDv+5D?=
 =?us-ascii?Q?gIpc4jJaOsTUPvjNKe8sRTcAky30qVsExYPVgPDiwV8jLmeXg8WtiZKSAzUC?=
 =?us-ascii?Q?kKKsYNcV2pvhUKTCJLrblrGKwcE1OTFPNDKZGySPwr0Du8m+N7uq2aFtr3z8?=
 =?us-ascii?Q?RrTGprtF11wNl2GojvBS6N/iEJ9ePQmn917JxnRxPXXiQVaX6A9B82gskCuZ?=
 =?us-ascii?Q?bWBAXFkX3vDao8R5TDjUi175oXaRrF0i91geFK1aNJSbbfmmSxr4DjBjZ7Hi?=
 =?us-ascii?Q?uusXCyjpk3sa2fz0oJ+dI3laVSgVKTevxB0xT/2l08sNElxuws1g8nfE6xvx?=
 =?us-ascii?Q?MIF4c/Zom0PlfePb/vS9BTm4QXDF8kIp/aei1KILqS1YCyJt1XS0hSeLNwrp?=
 =?us-ascii?Q?XGt2nkOYSksLRqNom51Lvu+HsrQiHfaErHLT4b3CIdI3+IpKXyQ0FAhCa/ex?=
 =?us-ascii?Q?6xRD4rnU+Vch/cZd8Ck0CyYV6ap61+ZH4p2uLlk6LTh1w8wBskDzgpwvuSIc?=
 =?us-ascii?Q?LXt0dcDz9g/rqCSl4enn5F91qlEVnRU0vLb+XlHkzzx9g2Rg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18243e13-9149-42f4-01b3-08df368bd497
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:43:50.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x2iOMR2AtA8aighwq75DAcO0RSZaTXorbawTXef9NFXzkOFeBjnfTUinx9qTLtaTaWspMLga9/fNWmO/a55OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

On Fri, Oct 30, 2026 at 03:30:56PM +0800, Yingjie Wang wrote:
> ipv6_create_tempaddr() raises a temporary address's preferred lifetime to
> regen_advance + age + 1 when the configured lifetime is too short. The
> result is stored in a u32, while regen_advance and age are unsigned long.
> If the sum wraps or is truncated, the stored lifetime can still be less
> than or equal to regen_advance + age.
> 
> addrconf_verify_rtnl() then sees the new address as due for regeneration
> and creates another one. Temporary addresses are not limited by
> max_addresses since commit 4b08a8f1bd8c ("ipv6: remove max_addresses
> check from ipv6_create_tempaddr"), so this can cause unbounded address
> growth. With dad_transmits set to -1, a baseline kernel reached 2859
> loopback addresses in two seconds.
> 
> After storing the adjusted lifetime, verify that it is still greater than
> regen_advance + age. Reject the new address if the check fails.
> 
> On an x86-64 KASAN kernel, the normal configuration created three IPv6
> addresses. The negative dad_transmits, positive multiplication overflow,
> and large retransmission-time cases each left only the loopback and public
> addresses. An i386 defconfig and an x86-64 allmodconfig both built
> addrconf.o with W=1.
> 
> Fixes: f4bcbf360ac8 ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20261029175827.GA1411453@shredder/
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
