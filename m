Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D12F7EE9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690406; cv=fail; b=XyqrV1706Vzp2NuGHvGfWfF3fSMGjpqFTF2KdUNRQguCB+UpN+m3R+FP64N0oIAcsY+v+r82MOEHspZqud8rERlW98ljDU6VyZxMd8wEM9ZkirmXgKJaKI1kK6n7ZpULvQ1qn35X6CjwYVQBn1bSUPs96dZnJ00JvPrf+uTbJu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690406; c=relaxed/simple;
	bh=LaspyzG58mUpA5/80BV1VGlSc48ohN+dvdfltdex6Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8nlJLy7rtrIF0OIJd6lpburgWun8Hizq3ioHcJBmkp7LKNNksgbY/XFX/JPtxyQRNhwAklj4qX2gfylWKh1FK9yWc7XESEf3cekXEg0+9tBkOEQQcCpVpO45qZVToNy/KdpF5PS83GYbR4qwgGUZ/8QPcA9cuR2GTUkO7ENaGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSWr/RD+; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSWr/RD+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8h35UygJ+ot2nxqjCTJKWZQ07EmWdFPtKQxeNfSTmawirK0VKHJVU8fIWamiMKcE3dLGzxMOgqaMXC5h8vFMAa0Q/4b3Mih4/1OcpVhpNFPAMtrEklWJ/zcAbHcpufPUS9r9xAxT1GphqByxw8Gn32MTjcBai+9ftmyhpJtiy1Q8uPV+Ed+iZhvZR5l6HVS6eHZJu6xokk/QR6HrHG1b39HzpVyMv37zKm2JMW5dea54iUrNMx6oOPv6IaaYZfjqtOElNJEZQqQ+s1i62Jbb1XZ7nesTHID5xcmzAMwtGFM/TIWg8g8tbOJysMtfp9AzCpYm9hpwaa+MSevVSEg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHfIWO3YSd/uU3zkv9HMzHEnPRhdyD5Z6Xw4o6sE2WA=;
 b=JTu45SavcvbwiH12AS9zeSltXg6HrC36i4ZFF2sMnuBH2XPgl3wZzPhCH8Xpq2kfs1Y7y1tJb6oWhBpjA1nVZlvR5H6T7xTs2tmHQA4oPJgS2gCS+14LyekmEaKWgWgFeDLaotZ+MSv2RuJwJ22N2IykvvRpb5LCSfk10GfRjD3RfP0riScxQFegIOUVbIWnM65uaUazN7LhCYstbfzt1Wryd5N1GMy3mfq3HkGzcqjYIHWP6PZ7PR2RaW4DH1zoOMrPvCWVpfa6t5gzrLo7jhw0+1EB/Iqqkazlv7O06tfBZyxSbG0RkHnPDaaUt54ef1Ig8mgYY3O/PwkZ96tiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfIWO3YSd/uU3zkv9HMzHEnPRhdyD5Z6Xw4o6sE2WA=;
 b=bSWr/RD+w5gV0Da8wYh9IHQg6CV8CdNJmUhOL+yUO2MfK4rBM92yVYLCwE1SYlOvrItWBM0am5H9PNj+GDvv7tLL+rn1BcCviAQ+1Qw39jjVMb062MvCwy1wYkBRsOZ6Nr+KvtQt8r01XU0bRYcNyQyWWqLIHx1HzzU153E2Fr/K1UNcCwwNsLBZUgYL0XuQsqox5PpyMuhEq4zFAwy8aqQTyMCq1xQucIvNgYyO0AiKqnjkVfdS5tzZaPCpVp/qDVnyJZ9JcyAbryDE/76ltAhXkjpDuM3IUMolX4OBXHoSGwqeWzXCcdk/jYIGjaEf6XRmx8xiGmmu4D8Hj6nZog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 13:59:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 13:59:56 +0000
Date: Tue, 29 Sep 2026 16:59:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, edumazet@google.com,
	syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipv6: sr: use skb_get_hash_net() in
 seg6_make_flowlabel()
Message-ID: <20260929135946.GA844364@shredder>
References: <20260928194524.3617299-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928194524.3617299-1-edumazet@kernel.org>
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c293c65-b845-4db4-f8d4-08df1e31f177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/pXME70PU9RfE8Xjy1/eaFCefmeyDjS7GpnINl+ZB5HJGMF+zpbfvpvZ8spBY5rMFIUx5PUF5xC//lMRTBEEILvfenId5W4tG9f4YmY+aUaBIrnxgHs91XB9/5RugX+D72UyrwiAV6ffT4CA7GIuHAgxZMmKM5rzVrWXM8rkzTRg9du/FPMKcSCGEriN0Wd+3bZrhZEHXKVHxURPt1Lq6uGWTkJd+OEK28Da/hYpmfImV+oaipVY91B2RcvCPX62z0A7rC8aFbZ/NvSbyU+fUlcL0PY/5GEvR27cdQ6kESFIlkEbfK1YixQFSh+Ht0kKBBxK2ldiGZOKrt9at7HrMQLIpgBOQawC75nj6iZZ/W6TsdEh2IjS4SL0n6KgcQEHk1XNCpJyWJVUcaVB9+rHYi2ikneQ5pu4E+oL6joKuWEZYvmDUqTNPSHYj2NNGUKA2lQuJcf+zGxFU+u8EM6sLUEEmOP5GS5DgvsP7QA8EciyZrQ2MMsn1X9hOuaj3jeJtdDIiDusqxtR7uMSF2Jme9ZR7Pxv0jUC/Nd6gZNBLNAPxGkGGdyADNODml5/4ztKDNGy0d23k2fbbHFPedkvxizJrG7Ak4pcZM0RkSlBci+4+kvu1Ui8pkRBHz3wWSd7XUUKBE6I/PF0eYz3cDm/DnNBlhj72COz5lCJnnSDQyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyMm8NE+4I928fAmp7NeaeYOE+RYDeabMGrEtmwIKdka0cp2SmV3JKK1ifEq?=
 =?us-ascii?Q?cQYauFWqxt23QPkJBTVIMqiflrqqfi0PsCYvorydAVzviDdFZUfbDsL19X/x?=
 =?us-ascii?Q?acf78QNcAv83asnlQKdKG2jLtGs/4YZ59yuT0mTk27Z2jFR3HKLd/faR/vkH?=
 =?us-ascii?Q?NqM7M+OrORl52PgVFNlhpR8qEnfnGCKS+HghjCk44xkuVtgWlZNYNjtIy7Ga?=
 =?us-ascii?Q?MbzvbhaSwWB6affCX2d8IQ/w6Eq78owpI4d6gW8VtM6Hrb4rxEI4MlxTffxE?=
 =?us-ascii?Q?K1w8k3tFwMZ5FiHjdxYzuZl2BlpUnp1Sv4ByQhAXU6Ob++ypnTVPeu96UH9b?=
 =?us-ascii?Q?aFIQqlkNXKrQzs7YSJriT6vYoi0PgsPDf2dIvFbsilvBa5PkJkJRv0tfXFc7?=
 =?us-ascii?Q?hJ89nCv+PjBtGYx6BkEITh2PdRqbvsb1kKJyU+bS1748/jIi6QdKN3EHt4uF?=
 =?us-ascii?Q?bNuFkyNbFOmn+XXa2pMEIKP9XoFrunMBZ+dFw/kj7rQS4bWHf+hXd9kXH8NK?=
 =?us-ascii?Q?H74fYqPdVY+trGv0MeitUXxesCbyHc+LRAToTByB8rktxAvKRmdL1sAAAnRW?=
 =?us-ascii?Q?iycnOg94nBEdRLik+25xxNb/5pebk7UqtNQtVf4NIelf9udfkVkfP+9rqzf6?=
 =?us-ascii?Q?3FgPdmn2LmrkK1E6ny6N7yNH09I0d2A/BAOR9xGB+wzGi4W7PLQrQ/FPSDJD?=
 =?us-ascii?Q?0fKKwjsA1lwuJgwt4XuYmdPKOIsJJFAaHoFCh54OiMABJaFnx42Ej5fTkCev?=
 =?us-ascii?Q?2OMxv8mgAE1auLQqLS4g7TOaHWHYw46O3jqJTUjvvjc/5cCMH5htLeA96JNh?=
 =?us-ascii?Q?Qo5JeDBBABsBRbvmQcqsDnDYXbDnqP8KP6/CRv2Gf8/jTl7JsCZdjxaadxG9?=
 =?us-ascii?Q?ZwpaIkKdsetdbfjNj06dBUqcqlUnHunlPXOh3cYyL4wRyrI9AIyDXDbGK1L8?=
 =?us-ascii?Q?9VsKbeKdCFvloCQEdE3/btmfLwefY2YBxj0zbTQME+IO/Xn3zGCI9BbHqOGs?=
 =?us-ascii?Q?9NYhkbXGR7/Uuq/ty9On+JP6Y9p9qLMikXjHHh2xZoqVZNUNaneR4xHpltRA?=
 =?us-ascii?Q?FPKit5ABJEBpHel2KUadoGVfvxnkl77rKUAHMKsSJBjzUmSNWhTLTQTdAFEW?=
 =?us-ascii?Q?vAa94VqnzXZO2tACcGXMsK1l2M4j3PtICd+pTsElK+cLLhqwa+NeZ4zvU1P4?=
 =?us-ascii?Q?xl1IY+FSomFkkVuNc0vEvOnu5vP/5vW4EIUmWnrg0Ofg1sn5LC4TSp9FB7nR?=
 =?us-ascii?Q?8dlaeOoYpl6tYgUmT2VU3wiJAiPkuOY43q8gDR0zdMQ/1u81SqE9Y7HjIUNH?=
 =?us-ascii?Q?otxPs06oatONrXACL51SEZMLBCz+nyluJfiKVQmkxQ0qek4goc8RFY4wSHVp?=
 =?us-ascii?Q?nazd1kqkDviFHjKrG7Oz6251zSlkl0qGrBgtLOJWocmUpnNH4iBsUPyO80g0?=
 =?us-ascii?Q?JppJvEB5uCrSB/+b3K020nQRZlHs3alIiGnPQOSzz3gJ3Xvi3sIelk0p5MLr?=
 =?us-ascii?Q?QEVs0+YeTjBU4ZrzSZzi/rDP/48DpStmkwFt7kKon2MuE/rioGCcRGXJsNmo?=
 =?us-ascii?Q?GR/ZbZjWGQ6GrBezJiRbAuVOpBVMpx+ajgbcMIYGmhdiw0BRsYc1ZWk+dLiL?=
 =?us-ascii?Q?z7GyOwfIf5GFK0NNuRoPVT9jYvm+aWaV6ngwXSRbxGM5lrqT6JnI+hlK4dxY?=
 =?us-ascii?Q?xfXNAao+WgcG/bddZZ6g/7SVjzYfwBELqPh8kGtrnkk8UbKd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c293c65-b845-4db4-f8d4-08df1e31f177
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:59:56.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lPYiny6bfY/XOLGldyP5x1Ppq5VqlDrINI/gvANFuJfQbggQTdi4SjevtkCA02EySGPtN3t9CB0aYfgewlNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026

On Mon, Sep 28, 2026 at 07:45:24PM +0000, Eric Dumazet wrote:
> Since commit d58e468b1112 ("flow_dissector: implements flow dissector
> BPF hook") __skb_flow_dissect() needs a net pointer, either from
> skb->dev, skb->sk, or since commit 3cbf4ffba5ee ("net: plumb network
> namespace into __skb_flow_dissect") a caller provided pointer.
> 
> syzbot was able to reach seg6_make_flowlabel() with an skb having
> neither skb->dev nor skb->sk set: a TIPC UDP bearer sends a discovery
> message through an IPv4 route using seg6 encap, while
> net.ipv6.seg6_flowlabel is set to 1.
> 
> seg6_make_flowlabel() already has a net pointer, use skb_get_hash_net().

[...]

> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Reported-by: syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6abac2eb.3654fce1.1bec97.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Congrats on the domain change :)
