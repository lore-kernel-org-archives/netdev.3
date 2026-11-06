Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979635;
	b=C4AmuNRYSOr9qNYk+8SvCKLoH2Za7mGpSjvhgh0BT8qsooWatDPPp5Laul5KIVfzuR2f
	 cVpjVeGyr3Qs46HiOXdic4YEAk8YYpwaPqmjXvWBfwCeBlM6G9oIVAkGigJdf44yNc1ve
	 PvJMHAmzglWcgxEp2EIFsKhC7fBCNjgbfzkRsxzN1wo+NqoIz/p0NTD7kJATJiGNp/02U
	 ZKT9LOmwU7Ag1ScJL1yl4++3BKGUSDwAbnfmKJ2N2GmX1gAh+KnR+Ah/2taFYKfuptnO9
	 j3Y/91euQ+2u7d2Igmb25VgkP6uCfOA/Bln4d6R+VJ5omYCNV5o5PL91k14vcgFO/5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979635;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ESkDZkRPOyck9xWvcTMlEJlHmb6QgfW/Vr0P1IxgNFw=;
	b=jlm5to0MoGYvThBkLx0Rogr1q1yE3Zd71sWYQHKPtDcUI+DlwfR51qDgVrd31M8iKLgC
	 tvNwba+JIgdcGJcc9nrPXOsSJWxtIiYCN24dUjCMXu3qUQLGb/sodUwDDWAqdoFjaTyGk
	 V8tD/42V7sX7dQV0Q/1643i6uUjNGyf5uEfYXKfOouO1gQE6FlQmWoWjb1D4YtYwQdhIh
	 GUiHDbRYEN76Ei5jp0X33nRs8SnJprBYdP0uSXsEfxg/Lp0wtjjD2DDeFmk0v4nCepIVo
	 /eTY+6FgnnV/QwZS8VwB66sO8R3/7azPzPxCWnD/TYeB/05S/9IFj7ipg8fUGqtW+Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lkzGjK1e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.54
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08C606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB08C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lkzGjK1e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9wk4VYFUdYtGAQGIJMjGm1ls0oQhC9t0EDsHzGEfiLesjWuGPMuLmIANViuRmjePpagk2akJmzToGsLiO6hx8KF3mNA0ddi5PT2ns6vqKjVHQHz4unOqmVpdPMkkf2mEwEnUjVUIIlRZeDAkTSCjEX/xuEh2kykoYm+Vl3LjBQd9QQNVleHRBQMvsJJhpPhg8PRzvkBLDRDx9q1Joa+WN6hxF/8l1FaC8gO2p5oDCmDrd5bPKTyWctMAA9+92TK2HZ+/FlKIHurYeFqBRxoJHX6pAX2ZZvbXmS6nU5/ceLr2V2H7pqKlJcKvhWdmUIfD6DNE/o0HHuXObzLZ5QLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESkDZkRPOyck9xWvcTMlEJlHmb6QgfW/Vr0P1IxgNFw=;
 b=DDd4f8qoLAUniuKdFjgdusQietukd1KGC8rYMnPbnZTtzczotyVwPz+8M8sb98JFfvuVO0N4XgL075511a6pjUZmUzCUQubJ4GTF8gQuEn3u19FQ++8JhERWwl+CC2FZDupFuRareEz5lP13CaMeXxP/SBj1exNgdMlAGvAVTk1JBp1Mfj7jTjsIvJTMbbdIku2H2O3hTUPi3t+K1EEQc7LKLJj6TO3LpSl1I3zMC2B/iqvA2l4FH/Qe0g7vdQ24nAuLzAGf5Lt+J3KpMwsNftUxWVYeA4i8Q5CdJVjl91GZJowHe2esTeVCD5wIGtUOboO682T0H2R0pR5NP3v+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESkDZkRPOyck9xWvcTMlEJlHmb6QgfW/Vr0P1IxgNFw=;
 b=lkzGjK1eUZ/P8iX8VHffQtA5YAMv8vtoXej4KOZfG2m6oUNY98IizaclDCkbj1Zhx2goZFIIHLwxgna2Wsqlz7GgX5tiFPQQWaXmZjoR4MVSdJr2Y15wpMDhbXrUI9VOghdlukXLQEAphiP9Lax+hbk81Vu4eU7ZbjBMtWiiXkAg8wntZyo12mXwts8j0rV4fOK38WHItldTNt6nC9l2U86b4DEpN079/yGS7gmnANMp1Fzx86NRRUjtd3b4pZi1UthUGGM1f7VZuFk72WgWYMwDAFYOpFlRsxAvToiaOhtw7RQJ4KFrEjfCLzeF/MbLc3jBGjXII2vTZpR7sKQCPw==
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 15:40:23 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::98) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 15:40:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 15:40:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 07:40:08 -0800
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 07:40:02 -0800
From: Petr Machata <petrm@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next] net: neighbour: Avoid sending RTM_NEWNEIGH for
 a dead neighbor
In-Reply-To: <auzmIrtt_gMVjWhs@google.com> (Kuniyuki Iwashima's message of
	"Thu, 5 Nov 2026 20:28:31 +0000")
References: <217109d64f0cdcba1db9569ee6ff7304754c47a4.1793793623.git.petrm@nvidia.com>
	<auzmIrtt_gMVjWhs@google.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 6 Nov 2026 16:39:56 +0100
Message-ID: <87eccy2ckz.fsf@pmachata.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8be755-e412-41e6-fb34-08df3c1c458b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|4143699003|56012099006|261021123027099003|11063799006|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UnKlco1bNAEv78x/GQpRpOW1JfAqVVJrEd/HOFs96/W20uN4OXxWbLiB+UgHMd+Sl5sY4ts1CiniO7/lSAx3CgV4JJJ2SV7K1anoAXgj+9bXmUA8PjjBHzS0LOtnstLV4s6GFdju0Blvg6J+0b0BKXwUYteHE+uJyrl72YqGuyOe2IBNi2kzMGXmacLx02rIgLvZMBQyhntzleydctHuqvD/Ba7Dlkn6cLxc4jnGh9y4Fi0vpdQj3aOlIQuDTP617EKWohioGG8HevFeBc7l8cEzcVkl//PXRBQvu6lhGonk2saaDxrNYgM6nTgbxZfmTbJlXumIlJ9tpaa9DNddScFfnuTYygIaiIqd4toj86awJJzeUjxXkFLQl8Mbnq1uAEs8WuFGWZa3CxmbQIxQ7DEJ9jf5pUEZYsyYlDCchAOhOw2gjnuqlEqsGSBsXZw3ert1sDBk3XyGIhgVCzsrhc7ABz78IRThLqdLwAbtPX7nZ6arjwxWl1JAqz3i98TIDr9x+qOrOMiyu4XOyjkFtAyx3qcFofM/qV2TH1PieYomS9Ti9c+iGSNJ3OtA7T1hF1EQny8CHBpceWP9c5iJ7PTkdRa2q5qsM5ezwOCNXeCjPS4R+//rwLjll+laxVpoNb2tJmexOod7cxpVG99SXG28Iom2gAtUqlIRP3dZWJYKiapawJKHTCpQI2GT63zU0C4nh8YUHeOCubrvVQd3Xg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(4143699003)(56012099006)(261021123027099003)(11063799006)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Stzmcl+NYiuwigWEFIsg2GtFnN3hOT63C+hU5vRFpQ8TBaY+TSITmNrtJXprj7y2E4YOFL3XTwM+lYrejf28t8vcuHHKwr+Lhc1X77YBxoGJRsFBpPEI/74uiwr03VdkW+leoNVhM4SMdnEPrDc54Exk2vWxdzG6BiuQzcMibsF8KIc8tF7C7svQBle9+UkD4GRnwaCNKznmf6v+BkBLtd8AkWGj0MWijJzlHrj6fOomcYkRblXOPaaO5wT2MCtwoA59KxH0PnQ+LwAsQ6Qw3tfuRbpNdXHBOQtZ3ERRG89YOrYJZAncgKlW36ED5mpls6MmBYq990FFzUa0q+UNV+L89lDK+H+YSF2R8ackHNwZc+YdpvDL6O1BjLwuzfe2D2k8uLLLV9nv5F67rs8Kw8GJ7dR0xGJkC8w2LP1dy1HDJQZn3jtuLm7sLL5j/Ca7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:40:23.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8be755-e412-41e6-fb34-08df3c1c458b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

Kuniyuki Iwashima <kuniyu@google.com> writes:

> On Wed, 04 Nov 2026 14:56:56 +0100, Petr Machata wrote:
>
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -3593,6 +3593,13 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
>>  	int err = -ENOBUFS;
>>  	struct net *net;
>>  
>> +	/* An attempt to send anything but RTM_DELNEIGH on a dead neighbor
>> +	 * indicates that the neighbor was marked dead while another update
>> +	 * gave the lock up for a bit. Do not send such notifications.
>> +	 */
>
> I'd remove the comment, it's apparent from ->dead that there
> was a race and the rest is just repeating the condition bleow.

I figured it might be useful to clarify how it can come up, but yeah.
I'll respin without the comment.

> Otherwise looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!
