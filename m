Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDA3A1689
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576862; cv=fail; b=XpKVnHf/Xd03sBmI+68wRLKinOm1BmMnSH32+S2gJOgARMAzGSMiHrvShdNGMgqXn7qzwB+Hl+svWW8FUoystbTOnUO/Mb8rtbDqY47kdZYv3+gGn+NEmQyEHyWrjgUn0HIrN2K+SndFZPmzIQvmDZ/3qPQYzbhwBEhiF6UIuyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576862; c=relaxed/simple;
	bh=8YWxS93TQGQUdx68zN5Dmsv97fgK+V0dyR4kfFmFgec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fdp0xnuD0HdRsmfq4xW8Ka+jk/6WQEw2297ollugUCoT4X/lofdwPnF1fnZFIGYEYf1SLpS0jyRpVu5IjbAZnAwkXzvZAZJzJvWXJdM5aeFUZYvYgF3LBdcPTqWE/W/Sd0GZfm17pXWApz5RxJ/0A1M2fn5mTbTMpoRL66uCA78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IsbMQK3R; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IsbMQK3R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir/V9y75ok020qODQEqmcBFKPm4gM3nWU0qYPEk4gcyr/kPzDWG1yhi6DJTzBvCoohhlLt057U+V6BwFmixQnKRTRlo+i8WsS8e/SWYcKZIVVuWyihyMob9NAk8mDnw797pnY3mfsRF33X32k9X432sL4R99j+Ly0tear7+Xim9G7GJh+dG9uvS9YmpoIs5qJPjr+K+unukj43hrYs0Tsh+0kl4F3npU8y7BCjCFBVQa4Gunyg7t4hxjzEwq4DMG5golDC1Kzuck/4FIqmfRjJpTAUNPfPnP54O+KsHwFoJvwcwo4DlztWEWTfpnb88SM/JXKEwyqwE77m4W/EpK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2yISKzTSokx87pjIDEBv66UZbylB9gt+xRWGYdR0H8=;
 b=fTCl7dJZ2KGnHv/60Jmr6HiFCN+pyOL6KlpzRcQ47U53+cKU2AZZmOxKr2wHeO8jPFJCYgFEca9i90okDoCopzhfxuA36B0GXCgXqgzyKtur2S+EXxqm6gsHtWqqZK9XVadwC6HnyDIXaaR+IZocL4RHEyrsjA79FkWoAUumh7aSCVT6Bnbx/o4i5JrC2x2EPQn5gGy36Aw+4lnM6RbQpcDuK2yE4vEzLeVgwT8+s0wboGJPKDHtmtU2RZ7UqdqJwhk32OcYks+SLavJnYOn5A1KGVOiaqkY3UluNUlsQlNrBcBBZFbaGLyqj2aznyewOiimAyOmpQd1pKf5DVtnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2yISKzTSokx87pjIDEBv66UZbylB9gt+xRWGYdR0H8=;
 b=IsbMQK3RRcno6NYYtUQ8dg63noIX5U5W1A1UhON4V8K4K3F2N/dkMrd79hN1KS1GsSsAlkXwa0trYVDF1P3vik92iwCFM/VMcE3vDVhnpeCJ8k1RxSU8ivHLApvDC0EGU7WD+PMip7pPVth1kpn4zs+fQj0XpmcS1Tyt4DLBMd3z94STC6baJv/py5ew/B5tNRefxBwIPLV7DpabRSejuKq8hHcljFtBNR/5Y+ZmW/dYYxVbBrucQm6qqXqICUGIp0Ojq8hlMzJ6lvslL1F92sr3joeDE8QkF+Wev7KXeQo0XI7Njk4B1HrntnKePzbzyZX4ANnSkMyXvP9qrnJdVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:27:34 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:27:34 +0000
Date: Mon, 28 Sep 2026 09:27:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ipv6: Remove FIB6_EXCEPTION_BUCKET_FLUSHED.
Message-ID: <20260928062725.GA273658@shredder>
References: <20260926033355.3295550-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926033355.3295550-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f04015e-3bfa-48cc-a3a8-08df1d29951c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pMX+4cUEDRLce7B1RiyfcE9pzm8fM9suj+BmNrI0vACn7icACG/0hva9OO/Y+UVBfaDD5/TYl+DSuHs3WVVyCzwi2AEaO9J/dUmCQu12xnTtKksAdiAhnczdUs7HN7qpxlnGVs9JSnukipHlkriMGivWa80ni98lcQcAN16aQ3OwouuDOd0hfHy8qTrlYYjRqgcTtmmgeH54r7NTYXpFjQRf3WhaoMDzEIHqNK/JkmHCgPlFjmwSHg0RKwHN6fxaEjdKz9cuvqZK5q5LKhJ3ldHnx/qJvN2IXa9jFnHvCH9TSoI5XQeDYoS2wQtxUom/1g5A6YnnKypFp5dYG6LFE7sF36eKqcf3olJhCd0d75vKV0rCUcl1QD1kqCYVBVj0vXJdWMQZpZ86SZXD7XxxQYyHnFl+wv8RiIvDIDik7pp7ngHHRfv3xpu9kwWU0DRzmSsFOyeC3yI9va+a49ZHBe3DZNBcywMgZnEMeWFo7Vg4fJ3S5YJlxB2s1QnSQuIZ5RjkCG9UT8mVggL08B98TduCcgZbXvBh5k0LBX7JDSGbBcYc+bq81iVKqBciChIIWk9QQStNnGzyXRPNXZadUdyAqNa4890OKwwTeA8QYpgR2KiL3IppIR0e/Pxn8MNpNFEItNjRLcyonPTc3flu6f2EzGa+WwCJqRFTj+YlXJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?538FyQgjbqfOxwUKLp+xacGwAYy1l+iCcmnttTgNKQw29kbWYA/nnkqBV9EB?=
 =?us-ascii?Q?ER86ctPMODLnGRN7hvfRo6JhfHpQ8HEXcH+qJssFjOKycVJ0veH/bQLflCgS?=
 =?us-ascii?Q?im9nJRKZbM6wNpSpzWUfVp9TEIkSp4hnLW+XLuU/Vyq1B+Yb1VyVUgF9Ox43?=
 =?us-ascii?Q?8XqMPQySGVVs+F01iEghHe3RvUw8v8yfTOc2FtdDTsNXIX+a3H4WtK9wFLLa?=
 =?us-ascii?Q?bHyh4DamL5z/iS1xsO1xxFXrZnF8U+Mgb5l3RyuNsEn3NUb9t/FPXJDsDMtm?=
 =?us-ascii?Q?EECcY0G9RzWbdv8wTYu9raX/s4kq37r5C8mh6sPXfnQOdygDeijgzJyIkHae?=
 =?us-ascii?Q?s5AZr9Wt2X4T0o6lu5GN52wx7C7HENsuQQmSNhQfMmRUpPS4t1t67mXDLQM3?=
 =?us-ascii?Q?HQBafBXVHpcsoCxY+otswKWrzX0Tpq3eoJObKnHnXilZUOcUlZn4nA036II2?=
 =?us-ascii?Q?Ak7YSOUTxCb66w0f5IZICv6dnsHQmoOuuBq852TbVA27I7jPfXZIRnpYBgA0?=
 =?us-ascii?Q?kd2A+yGBxGaPHwhuQuSUGnC3o4nKMDvL3OSjLKJcM7lugFWGf+sa2gsQy4uk?=
 =?us-ascii?Q?s6E2w6cf3EPUjdkXcvuirBLMrsybxA9DVyaCnz/2++HThZfvns3AqjeCRalz?=
 =?us-ascii?Q?+lOL9AD2bbVC387WXqsnLyYXmXcmHqi7zA+P/B6FZZFC/gB2KYCFdfLVDWhp?=
 =?us-ascii?Q?sE1B4Dp/E+2EKJ8cLYieUls6wv+RX+l4i93iIqAPRuvTDkciMKjK7D+v5t4X?=
 =?us-ascii?Q?r2PSiOeqs1vABYjKtKgN/K46cR8NMUhrSpA1GxvqKP4K9CtoXKy4rvpACZUo?=
 =?us-ascii?Q?a7A4JQiF40gzz8RaVCBO/E/NcM7TYOdOt5O+qjnLU9BEnBa6GgyqC3Me5A3G?=
 =?us-ascii?Q?w+0UD1AprXJO7Ac6/EMsdy/sjsDjNNyg64bqSIsPMag2pr1Cfgjdi6mPDPsu?=
 =?us-ascii?Q?V980XnPdCtx1q0+O00MlcBsSCRXseK1O8Ji8+H/CeyszFP4VtDDL16mcswCA?=
 =?us-ascii?Q?y+VP92RZPRFDY9v2qrjEFwwEgZsn9ZOkhcezVFws+5N+VulUrkGfGBnfCaiE?=
 =?us-ascii?Q?gENWfKHyxe36Rdin/flmi6XfoganxQfAOEmJCachk2lQ416IJuFapPOVU+C2?=
 =?us-ascii?Q?nQw8eNl7NQj7e0LDsE+N3HXMFTGy0fkGcuV9oxlThWcwD6wwvsXo8h4DitSw?=
 =?us-ascii?Q?wOhmLAnLeqKxHTygGImng04SUQqgQnMbN8ziN+MTpzKqnMOXGQYjXOQlZBri?=
 =?us-ascii?Q?9ON+wbYLAPrZvhUhpHijcP2EOjhZrs9rN61AbEAF40xV/qFQUgTwWXT4M9GO?=
 =?us-ascii?Q?Qp65FFAaBwuwY+yG5hr6V4d3jcUilZ0aaYyK+20t6b9Hb4c8PZXeDMJ98f0e?=
 =?us-ascii?Q?+1hj1BGO4hmaApmckz5NEcmkiDYV7xl7AaH4KJckjK4jAumNiER8rzvBnblR?=
 =?us-ascii?Q?7Coi/xzzmeowEkObUd+9R1Oq2jhCUX1qOflfw/1AHeqJPFK+kp12rpJTfqcU?=
 =?us-ascii?Q?6XEKvpu5JhW8iUTwCeE9dxrd8dxrjopKXEPuIi90BnfOukDIaRInAuxLH8jz?=
 =?us-ascii?Q?uZz6n481hyxajN3/q36+PVDFSGPTm3VBkvJYHagNMi1C5cqg3RQHjLrwi2T9?=
 =?us-ascii?Q?it08hIgvNzRSWNUq3NA3oDgrEwvUZ91iISlLTTLcyps4W+0i4QEa9tFYxIYC?=
 =?us-ascii?Q?j/iJviT9Xg4nQivfgTBcBYmGVCgcF5hymFhv+4FutA9euhKT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f04015e-3bfa-48cc-a3a8-08df1d29951c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:27:34.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP6Qsd3Dv7LLJsVu1kQTtnFNmuSXl3r2Hm5FTfFIyPPdUP0E0evwYkUgRQkx7EvZA1LLxEi+1oA2aArlzCsgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

On Sat, Sep 26, 2026 at 03:33:52AM +0000, Kuniyuki Iwashima wrote:
> The FIB6_EXCEPTION_BUCKET_FLUSHED logic has been dead since added.
> 
> Commit 0346ec2f080b ("ipv6: Prevent rt6_insert_exception() for
> dying fib6_info.") restored the original race protection in
> rt6_insert_exception() by reusing fib6_info.fib6_destroying.
> 
> The flag now prevents two races for per-cpu and exception routes.
> 
> Let's remove FIB6_EXCEPTION_BUCKET_FLUSHED and set fib6_destroying
> in fib6_purge_rt().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
