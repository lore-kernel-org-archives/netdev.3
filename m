Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793306155;
	b=EPvom2Y4PhOTb7pdYBl5BnvASDzIefFtvltraAcLTifO/qE8AW/0WNtobBoU0mTd3nty
	 yRtgArtcqJnGfgH1GHoHZ1FDjzps8YbBzvuUmzbptYMfcN1E8qUi9H5vixZCuHxC/Mukk
	 dpnBtZlZYoTWb///ebOKfxCRQPuu7IQQUxRvo3rt+LWKVVMX64oxLdLlVSgp5meYRmfL1
	 iRYO0TbaoHaIntwUIzVqdA1JlwZ9TKgZNqcvfOilJ8v3uBQMTHtTbSchFS2kAIQZnAqxg
	 DrtL/d1xRcveNf0qb18qkG7ckXRiA8GuyrCKsqZddPRC2hao7vj1IXK13Ord2Gbxx7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306155;
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
	bh=2w2+p+euHadjOeBv8tu30cQmuUgo+VoZqfhQqNpwOQk=;
	b=Fa+CRl1xfNqm7MOdvLxqvrUETvWoibMk5qgHZV79OuAlPI9jWkNvo+pLcGa/pnkJ1hen
	 HBYPHwWa82Tsyj76M5RaeCC5FKfxBLItunPNL3XPAxLgn9z4k7JIFhcEeoA147faRDUEF
	 sk5GKGYTZ8RBLd3xchaJX6Rp5lKj1/Z/QdUftvJT1lPQawpUSvXWQhJ64fJmP9dzoOQd9
	 SaWw+hviukijeG3uBkB77nSANuL7BZGv/Yh4qsdjw4/XVsRWCLeeJU7/X1n5jk3mIwvdH
	 RlleuU9Esl7krmo9/Ya10OUbyvnJIHY9ZkF6gexsZv9IDw62lhS5JWtIbca6wxL4FXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kHVPRWyu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.33
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A2606A31D;
	Thu, 29 Oct 2026 20:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kHVPRWyu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0e/d1FRiIPEHXVjfirok75MMFDgKjgMUf0UbZA6+LQJ4ib8W9lv8ejNjtf+dhKnFOmBfU2wxoaI4h23eXYlClS8me5KLV6N/I75vHBCo4scYe7dh9v7H3M9HL1Ndb9+Kvr3APBwyEEPcWXV4WVc/fy+QTYfkYzmz2tAbtje93lu+87QNKNzxL5rx6jDKMzO6Ppyuvg0uxregKAeoqm45HmZViUQ0ptdBquyPUhdd7wlmmLN3vaE9bzS/KZYfz2BycuAIvUBttHzIGzYx2s8X0ZuunOb6YjrJVX+cnnTc9Y2x1LCJ0GWj7/kG476uQLbdHDVwYGeYpfdeqA6wQ9qDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w2+p+euHadjOeBv8tu30cQmuUgo+VoZqfhQqNpwOQk=;
 b=BPL8xnykgYZCdm9tolaLf80z9UusBxYqMVY//nOujXK/tw66xQv1ikx5Tox+7pkevgc9o9HCd09hiwNs/b7xAg3QSguLm4dsZ602GcfcIJMCVMI5ORJ0RoX3NklBiFXubBsgLPHvMv9bzUVzoW0rCEOs3oLNwtsKgKundnZR0RCDSJSgmRw+xgdmsp0LyN9cLO0Emxf6iUrtZMSCF7JA5/64eN+MAGdHob0BZFsN5H+L/CDJEN5p2udK90d6eG8ghnm9Awrfr/pw4CkPtpi0LCRI4P69WW+s+ur8GehVSskVloiMK1oB4NsJTyJC70+qjiRFp0CX5b7MM+nbcBysxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w2+p+euHadjOeBv8tu30cQmuUgo+VoZqfhQqNpwOQk=;
 b=kHVPRWyumpKKWiYldHBhSXMAGqRP4Wvd+5+P/w48/AG0YSmmV90BnCcziZ516W4NX+v5Z0Zpd5dwpSGIkCI/yK9k4wxcfX2IYF9/Ix0yRgqilub8zI/zNYj3MG4JzYVXg0abJtGb/kiQHAFdiwfdEIP0mKojjPTd/64ot5PuNinaBAzjeJFS0cMuoTzr56yw7uJDfqg8HDcJhgHM52fhrbhywB759xQ9jncbtzIZFE6aLRPVDXMetYvzDJGSMtYw6rqb+hSBqnsSGFRynIwFx8jm1my+EEINgnJY5FKsEMHoRuWzAuQdxDY1qn5gG8bNWNUYh+8aql1NrTfhznxbRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 20:35:49 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 20:35:49 +0000
Date: Thu, 29 Oct 2026 22:35:40 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] genetlink: Reject joining multicast groups no family
 owns
Message-ID: <20261029203540.GA1485981@shredder>
References: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: bde7e850-e94b-4840-17f4-08df35fc37a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|11063799006|5023799004|56012099006|261022075727099003|261022105027099003|261009223027099003|10067099003|261026121527099003|261021121427099003|261026140227099003|22082099003|18002099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	RFYJpjzFhYj889DuGztb2RjUInOd3dAUE0EYVi9mOZM+xtooU+o4vqGZWPWc1SQxJN4hgMguxcgeNPIktjnhnlJnurZjGPmjFPzZj/y0KqFAvuFRLA2pe/Ba69BBx82u8GGMH7q7mH8Lq7JCV4KYZKjDJhaGVLx3cUfawdEFuhXtbus13m/sN1ltHtEIPUx0bImZhq8WwV6JZwVlRJtoY/9xJ++odEarnZu9Ps0aaMWAIDwhWj1aVJnQDGlld9J3XgMaMWBC8cRQko9L5JG6CgIfBqAA1/puuQSYyWRm0sUYvxBO37tEJz7b2xCeb4EXsKehF9POwcUbKnLWdWJCLvxVxDvf3z4J//WyT3TVIA7VVhWraB4faTQXigrzJhr8+bmea2ix0Yc0rQje0zLjHztzSbfkBa/b4IAGnXLOJwN5hSMA1sEXkFdKmnbJlmBEZJXRiNf+K6pVPVrObFzpLH3/3Vzslrjey7L3elsfcHKnSbEx3FAuSNPltKCZsT06HC1KVJkkTweHn4Q9XtQnQeKnUWGOdiloUB6zLwhRLWJxjOTDYEoV8PMjyP773AEWKDl8xqcJuEMZoTh450U/bgC2gI80GY5QphH0ROzgnPmIlzjTu+g1gBrlicGLvYmYupMjMFvYaDKwkObqoELpWoK1P+OIebSONDHTtORbzYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(11063799006)(5023799004)(56012099006)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003)(261026121527099003)(261021121427099003)(261026140227099003)(22082099003)(18002099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/QHRj6A+BIi9FQAl7vjtBsl1covq43z1spqj1ZxkRXnwPNScC5iKEHEhrjz?=
 =?us-ascii?Q?j+ujtNXgsREAhNMLFp+JgrY++QxDoehLgB0uj1ElaWe05/UdsafxLZHFLNPO?=
 =?us-ascii?Q?FJgWjUhxFRrVbSJIzs/kq5cDRyfhGo1tIS8Ed5z3ARSZV/Z4xz8QLPkVv0gH?=
 =?us-ascii?Q?aIR8O/HxCMXjRfaQdg8YwLG2lxYlgBfU0RJaB183DiOrDregwvr22BGr4S38?=
 =?us-ascii?Q?yhe2zP5/Eb7j1Jk1sdYJMT7fyrtkZ49aQ9CwE5WEE2VCe6txTqJzH5o2HfrT?=
 =?us-ascii?Q?hmxWQuHyi/wcP5CKYoZY+uOIb8yMZ18xWejYiVwDYaDnclL0V/K1OO9+xrCB?=
 =?us-ascii?Q?NOZjBPoIJE74L5PWtyg3JHcCXRCLTB9LVtPi7jccs7jIA5NzFYy1tZpdOzw+?=
 =?us-ascii?Q?Hzc1Z8JWKwzrw37tR8jlVL95cBvUCBk/s42wAh3hd1h1tMTrdYf1tEWsOBWz?=
 =?us-ascii?Q?YNiHWJ00B93uJMWozYGOYQ7R79Kdp7T05P3wIVp0C6baOY0IJRBFjgCW3OnU?=
 =?us-ascii?Q?u68MU7JwqmcrrFPHGsXPP2O7s1VrwPTvL4maVF39m8tph837vDeuDcvVSwY6?=
 =?us-ascii?Q?JJyvryFo+TMgt37pw1V5hROJQIKJR17KcOiPTNAAD2ctsC6MNZ7GvMR68AIb?=
 =?us-ascii?Q?Z9pv3PDRqjSWK9Ly9dkfaiTLpLBRU+chOrRHbvFrPjF5yDtQzT/+lbwpb2Z1?=
 =?us-ascii?Q?D5Ws6z35Et4ulpy0TZPoVBmRUVOOU53t1FPEiwU+z0jbJQCa0T03wbXXsU7G?=
 =?us-ascii?Q?0Hr/NlsCs9qmdKnEQOzTw3mCCkxDucJD8mMzvQxGl38n035zOrjUBXOEjsPp?=
 =?us-ascii?Q?xeRGvJzWAsYhd7bS+1DJBCZFasDouYo5gFnlP+cf4pjh7GF67SzEElx9JNrQ?=
 =?us-ascii?Q?QyBfyuW2/G63sm+MdIZKlinc5UUYb7Ovfo4P0bUIDdeL2DiCyTTjb4XL9rur?=
 =?us-ascii?Q?02H+EH42yGT7BRTn+a2Cj+CdpGEPV4LtONijbbxccZlefW/tNpDl7bHZ+VUi?=
 =?us-ascii?Q?5H/IMp2Iv8JRPlhv7tgLUvM+A0VCyuIWg1VZmGHezt66hm/U1pyzTj7YdY/V?=
 =?us-ascii?Q?YeAAj1OqQh2bwc1QucYyBEcYycOlIy/wU7n8uWlS75Oe7QgjgokShH0cp3gk?=
 =?us-ascii?Q?Z84okaJmJNNgsWYvGHWnmFUdYu69F89nQ5WGoGJzt2HKCJcmwUjgRZlDEUV+?=
 =?us-ascii?Q?/wOZDKueMO4GI6R/egDdcI3ZRe7R1YjSsE+Kjkvj8q3hEiFYUjGys2lEPnHY?=
 =?us-ascii?Q?tCuJznSBwu/vvFbruj810gLonQrWZQVIyNJ9vtwOBX3AEQy0OGRXZARumDQv?=
 =?us-ascii?Q?fEIo/Qpq1nFIFRHHg2AH54hpYpteemiovtkFPryQw8P4uiVbxVcmwTKV1IyV?=
 =?us-ascii?Q?yo+umbGAuA5xLapRBCgAft3atZzY+02GPEExOO3wY+dcjIFuJ9JxmrVylMMe?=
 =?us-ascii?Q?zQxN5iBY3wpAGBCgudEjEUWz9aOJgMVZx14p3CxBAg5rt/12yadvEMWm1zbx?=
 =?us-ascii?Q?ZnM1KB224UEAqs0DWRonWoGllNQaGwWObkUSOaZP0FNcTd5di8jq1HQcUXzd?=
 =?us-ascii?Q?eJBseO/z5ZSVetVgjspNtLbZJgaiXwSDsC9+Do5w3OsGnBQrvsogQoRTqwiH?=
 =?us-ascii?Q?jhRSihaBOSqW79cjL9rdG8gZJNDBAj+/AkP84cILgsULu92fonQT1S/rg/ry?=
 =?us-ascii?Q?m96shoxuNysJQVNdHTnOzgQ2XVw6Ie8WaLb5cojXd4nHwO4u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde7e850-e94b-4840-17f4-08df35fc37a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 20:35:49.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncWNNYOQtFKW1U3fVADgGObDqMZAmPghZwmBNJUPTeM7tYqqCfOzp+szAk1T1R3xvlGv0MRTSLSlIdAkb5NJaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924

On Thu, Oct 29, 2026 at 06:22:14AM +0000, Anil Kaushik wrote:
> genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
> family owns it. For a group ID that no family owns, it returns 0, so any
> user can join it.
> 
> A family registered later can get that ID, and the socket stays a member:
> nothing checks it again. An unprivileged user can join the free IDs, load
> a family module with CTRL_CMD_GETFAMILY, which calls request_module(),
> and then receive the notifications of a group with
> GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN. For example the
> drop_monitor "events" group always gets ID 1, and is free until the
> drop_monitor module is loaded.
> 
> Fix by returning -ENOENT from genl_bind() when no family owns the group.
> Nothing is ever sent to such a group, so joining it has no use.
> 
> Found by the Sashiko review of the gtp multicast group fix. Tested as an
> unprivileged user who joins all free IDs, then loads gtp and
> drop_monitor:
> 
> Before:
>   joins: ok=62 EPERM=2
>   gtp/gtp (ID 15): member
>   NET_DM/events (ID 1): member
> 
> After:
>   joins: ok=19 ENOENT=43 EPERM=2
>   gtp/gtp (ID 15): not member
>   NET_DM/events (ID 1): not member
> 
> Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
> Fixes: e03781879a0d ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>

FWIW, this restores the behavior of commit 5ad6300524c0 ("genetlink:
disallow subscribing to unknown mcast groups"). The entire function was
later removed by commit 1e82a62fec61 ("genetlink: remove genl_bind") for
unrelated reasons.

So, given that the kernel already rejected such bindings between v3.19
and v5.7, I think that the potential for regressions is low.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
