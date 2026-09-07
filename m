Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6E45519B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776136; cv=fail; b=XksHCqizUB8NA/ZtFD9nT3QbIwZAcN50a7J0OwUw2s9V0CIkognPwB4Ez9tuj5S5/067ZqVKYkzl+m5yBtQg+zB5K/hiz2zzNAlDG6yLknAPjPwcpr9KSKmO4siA6j8asw6+GLBQqwC6dpqMckML64o/Gx/oTpkVP7dgbR02kCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776136; c=relaxed/simple;
	bh=eWDe27/afzSC9yJCkpTb6pESWhrBkCKH+hBy7u75vVY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l0bIAwy/Ft52eHtdZ2YOabR151vzgGFMMxGfqwRmhDM70d0G5YZ/+bQykUZWweg1UCNQwwOfFMdGv2V9MrIKlyDFxBYxqgHk24lM5hzdLQLHDwFQTILPdSsZCDbw7MXImAjdIi25V8jb10oOm2fqrPbIveg3cpPEK7lmZeqX9b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onu718+a; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onu718+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5nXPzbgsVlQm1dq/VWxemTALRZCdXBLWJUTcQUi3/tMOCAJ1/xmbenhaLjP5WaGemD1qtRyToMpxvJikHIPsx4a14PBmldweV8ilaknqwZouBPQaQUPyKhJgX90pUiWJRvZoPiQaKl+JnylkiAfnj9W5qtE9GlURpvlJ7KHg5tGIUSbb92EO1Abk7fM7cJEXJ7iCcEYC75lGT+toeNoH1HJZ9tBsFc1Lu3OYXe0FIBcX6evhMiFAF4HMP9QhedrEXb99pBBGzowbxJb/wLWyajClDMjtuC/7mccIVgo3tUW4lF7W4eVskDYNhQTUn+uJv+uO5piyLppP+DP+HqDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmvb2kKCgtVVBYbUFXs6N+O8XsauTv4sCRN7Myuwl1A=;
 b=cc6NhB43hJbLIOqkOcDEe2ZTgqbg3x8fwrM1RAmrVLZxKf2IfP9c2sEUpJrc60tBPalPgZD/zoj4yapn7SncqoPghzTNUaNhd41HbIv7a9JI6UB236rvBj5jWQH0bAjzIKRAS/F6rruaA/LmQzsTE63sV//seG0WjJMuYI4HeYI15oB5lleb/Bk+ZdQ/IIao/aeAB8ZREOHDgxJNi2qEwzv4lw5RsRysxkJJe3OVeeceeF9HnOpviIqUw2rCz0b2kjF5RGZh0dR7Mf83YaDCk2eJzcVDMFGrsJjlCM/2BabDgrjCCJR80cStWHxu3OpQ7hTRG85njW37XQVihnZTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmvb2kKCgtVVBYbUFXs6N+O8XsauTv4sCRN7Myuwl1A=;
 b=onu718+a9c9vj0dEEMeJaYoqFwQqmlDJsuGCgtBlLrx0Rj/AOKapEuBcGy6tbuKi41sciYMp32BnHVWaoSM5OGNuGh51oYkcbHNm0MElOJFtgitSE2ivEFVQWjs6jz0XFha2CAtUTQN1lT5ul1DL7QJrhVzAAaWznWA9TEa36+BMn4li2ifKS1KxbRONTkYSrnxlrVVvBxxk18zn+A7YHHB7qyAzLKJAG7IAiLnkzYRJ0dqn6A2Hyy+UFXKfI4egi0O5KtnQMFYobgIei7Ud0UKBU5w2yRX9o/ryYmGiH7VFYenUWNTZVuzybL1QDcWyHyoLLZ+7TJDdZaZG5stZAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:15:27 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 10:15:20 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipv6: udp: Use ip6_sk_redirect() for tunnel sockets
Date: Mon,  7 Sep 2026 13:13:58 +0300
Message-ID: <20260907101358.596953-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdb8995-c3cd-4474-08e4-08df0cc8ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	AUavR0RPlxvGUMQc3Uff2n/1sp7A5nqQ1CTpIaBbVYX440+FWgZ0SkNg+Nlw5d9rBur6CGHFBjabTFxaW4EnEiQsC3jMqw4sX42q5ubak0T959UrnjjdEpS1OMZxT4KVtzRa8ECdaDTvecwNVDI7fzOU4d5DG9jprtzOkXyOCnUpZY8A3+pZbWOO/n8AL53472qnXfaJm6+e1Z+fj1f2FklBFjDcq52jjYm/Q0LWAuEEmeZUL25T5NwZnkWYCewhnXPZOUBBhsKxPWmdGVYTHIK9T+SPt+S35M0x/kHG7oR8F72W1BUeFTTZy10YpFcb8943u1trhjeLAras9cBk0PJBOVgRwvsuIAj5wCl6A90GooijQU3y/uAjRCF5+sBnvzBMJZAqOKb4fiBmOEPoS+0ddnaP6rGkPPNFxtaT3CEN/9atR9/SM0110bsx5JVqi4MJjyd3wDN54NdiLwvYJBq6jUeSWvfb+4TlYIfRZnfav67fJPAXURnwwv/6cdRSAtd+ZM2b6y6fa1B7KjIc9DNivl19glBPJ8Iy4+JkbfdNJAkkgXVvm+dNgTZp0RM2Up4EQv4zg8i09PI6rvbveyNwo5KN96uXTle64iFwfNgxDPYKCUHVApmZsEbUi5wQ+EoOh98ae/fN8k7XnXvnUHU5qfykABx1LAsWwr2xB2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxx+cuXzM8zhwMTjsCD+wtoq75Df9D1jvzmSaG4HB9AXLh3gjkgTraS0lC7R?=
 =?us-ascii?Q?mPHDvIKgLysgT2oWoZ3iPwIRgRcPYxrCFQE6CvXE7w1hFMsTPlu+rFFbNJHr?=
 =?us-ascii?Q?SKJCyhdSyWXFZzPPMSXZZJYAu8FYPrk1BxscXBFq8tx7y55c505v84daHnKy?=
 =?us-ascii?Q?FUExgr0NdhnWhMUI1ThkHQrbkn0sEiDKBnnI5JCuLSghrZbOIYHh/DDzBfh4?=
 =?us-ascii?Q?6fg6cK549ZlLVQdhShnI1ypkZpA1RHNXjZykAfjvJgFLJ/MRP0L0FmxTPoHW?=
 =?us-ascii?Q?d7F+fQZWBRhsKty2fXArk3UFGtYp2mSHOVAFhHs9VAve88Wo+O1PgyIwunqk?=
 =?us-ascii?Q?h0g3aCCALoSaw9SQbDvy6pcpK7JiauODk46WYgGKixWcRxxvzab27AFDTTBS?=
 =?us-ascii?Q?W2g8XY2bphCvxzs2vm12J7EwuWesiLHXfUAS6z/FHxd+GL/9e1YMOIdByacV?=
 =?us-ascii?Q?MF+gfy1ATP6X9pgP501RUuwOouZ7jqipSVO2BAOjtxbhtoFMaumz4eRNObGK?=
 =?us-ascii?Q?K0CfnkOnlW0+yw3tZpVU6WALVetYE06E6V3e2NohyeXUKUjceujZdIShl4Mg?=
 =?us-ascii?Q?+NrVe1IXaOniJ0O9hzIDTa5WbIfPGvxF5MEXGe/kXF3J5wWaeo79hvT3fnVY?=
 =?us-ascii?Q?0r+rx0/BjDiha8kjPW3raxOIXKwjtxw4xpBiUHXo08qz3Cy6N2jNtzmYb0NK?=
 =?us-ascii?Q?ZfdlUUP0AV3MmMcamW0pi+X7s+xb3prW+IUVzrRH+B5be8tN6u/AaR6gDp2i?=
 =?us-ascii?Q?8PpS6BOt/OJV9yUDEmzpe75pyCjoVFm/Vi7F+PKEiV9OQhfM6SWER8Cz/gvi?=
 =?us-ascii?Q?ZifNnRUrBpzpiTBLgAy8t3ZuwdV4H12qtwtNQYp9yYGmOjpJjBIcnEBaxz3y?=
 =?us-ascii?Q?n3A+2dxJ8vMozvpWAs8UsyVJe/a1kj2uGRu6sviFdJADjAL0K8/YOiTrIprX?=
 =?us-ascii?Q?N0gBeFMT45il+H8meHG+t2I/tijuzB7tEWkghRoieEDzoQhDubClHHQjZLSh?=
 =?us-ascii?Q?0zKwutB6TzG/R/ZFD4bfJcw/iw1N6a2SOEna3aREJDr+u8Rg1S23gClwa0IL?=
 =?us-ascii?Q?AXi6vYmihHVd6wwqc2vUDjz6SbBlimDzoFPpDiQ+iu3B5Y182/lPYle3Nlf8?=
 =?us-ascii?Q?hfbwn6fJr2DoN26w9wNk4F1IZ7W+sUUosXwmMMwh/JWERlJScSJ2UWoTcYpC?=
 =?us-ascii?Q?Bz2JbyUO5FMtgkk8bTCSQdp4ykmCCXjKQb5o9IUX4qEmxBARKZR5XD7Cr6Se?=
 =?us-ascii?Q?PIkkGqkOzifwiSbijCfkTbGB8MOiSR+P6fx1Zs3AyMgcZe+B0FUR6v2F1nZw?=
 =?us-ascii?Q?kajWI3BiKl22mJhizQ44zcdIkH20GPqXBMEpueLL3PmC0QwV/5iQrJ4jUVG/?=
 =?us-ascii?Q?ZbSwjliYMePrl5AbE+Z1ArSFiEQ1G7fKT+Ei4+Gkv15kRMt8QYXF6YcbaxUx?=
 =?us-ascii?Q?8Z56MRl2vyU0lJf2XJVNX14hqaTEZxKL+OffC9b7LdeVWtpiR9en7pSk34Oe?=
 =?us-ascii?Q?cqzSAkZ8Nb7PeETMHSKmPiEy9mObuTZiMjwzBDu+Pg8izb3+caYit2BJo33T?=
 =?us-ascii?Q?HZKvBmix4vYaiK343Dtu0rJuBVbx7PphrTYlap79Tjgux61jU8bs3cz811Oo?=
 =?us-ascii?Q?0uzJO6aYUsAjWjsGaYRBm0abhjSzsT5G+Opyj0hilrPFFNvlaPYDq43o7gSs?=
 =?us-ascii?Q?qg+3lgra4WDCtbn6iEX+o2zLwtPQUUMQGbW8IISi5/bIblux?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb8995-c3cd-4474-08e4-08df0cc8ec0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:15:20.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxLAWCEf/hM76OIjnM58HCYmvXkLjJG1uxN5HJ28EjUueg/ULDRziO9lK8ZHDrpoMlx5XXsvXY3DdNVQjjvxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334

After commit cd51b74bdd0b ("ipv6: Fix redirect exception creation for
UDP/RAW sockets") the two redirect calls are now equivalent and there is
no need to specifically call ip6_redirect() for tunnel sockets. Simplify
and call ip6_sk_redirect() for both tunnel sockets and regular sockets.

Note that for ICMPv6 Redirect Message packets the VRF driver does not
reset skb->dev to the VRF device, so skb->dev->ifindex is equivalent to
inet6_iif(skb), even when the packet was received from a VRF port.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/udp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 93478d1ad576..59f9872c3552 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -751,13 +751,7 @@ static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			harderr = 1;
 	}
 	if (type == NDISC_REDIRECT) {
-		if (tunnel) {
-			ip6_redirect(skb, sock_net(sk), inet6_iif(skb),
-				     READ_ONCE(sk->sk_mark),
-				     sk_uid(sk));
-		} else {
-			ip6_sk_redirect(skb, sk);
-		}
+		ip6_sk_redirect(skb, sk);
 		goto out;
 	}
 
-- 
2.55.0

