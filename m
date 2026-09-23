Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CA45D910;
	Wed, 23 Sep 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152097; cv=fail; b=CBLubi1WITTDTzXqrad3wHbIGZc0Ou0MkBSXFX+duwtg2WfPgO2VhEVVKnLhpPts5ivH2sngaIKzMghnttY5DdgCjQTju0/qVF4rwHOu9ApsroRP0d5mNV3rfIsbr0PRGXj+UpH5t1Q5arNnKJOuSjzXppqG6rRbfMGxDrrbFZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152097; c=relaxed/simple;
	bh=woV75iHnGuqDNdjZNt0m+LMnWT5aM0UjKaOFUZWRhbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/gr8i8WFEWzcvLS7XUSiYZt0LOP5DIooFZUZentIG/oloqVgYOC9c80IjN6dAR7Xk79oHqLuYWSlNaaQhhc7h8nEwgr+NspYW+0wd3Imo+tQOz89AmMHK3nI6QezvGMpBduh8eIHn/nBX1l7/6SiKCoXjp4tWrdDYYg13rqdXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hi7ID1VM; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hi7ID1VM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuByIy/2s2K+uvRYNfzUFM/uy0CMfdShvG1QsoVROBdnQeG21LToX7HMXYuiRpHw8GX+uOO+5KYbIAaz0olvCHijxIiS4mVmFLwOGHPNPhZvNGpaE4qQecdMXkqm1o0EtbusbC0k+mXab5ejXfcPkH6YszY91xM/BuJDjZqZagjY1fzLKC33eSvfu0S4KTSheVsNgbl1Ov3wQh+zriaUqRa33a2YvY3GGHXSPX1pxcfz4qRDIm+zFbVTBue+shqSwhWBnXpg90DyhwiuoNKLx/U45Yo/cYSYfp5BBZP9KM19rVPKTqEwH2PTilSK9y4hq7QpUJtDSaG9awNfD4jktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSSdBsQr7XWMsiueRcxzVMNtve1s7Ng7N47m3vQdIVA=;
 b=epg13WDSSaGZM6CobkzI9kQ7sp1n3lV/86zGOqPXl32+v7200Af8MDn9GkNwBpqPp3cOVJUQt5CWMVNtkV2DX9sw1ydN1kQrnq3ZXcefoUA5DE7NAEOJic9k88U+ha0wNpRHgJCC/8vpBuat1adO3s9+9X5H4oRNdjtZAFsU19tWIzZjTQgABeKenE50zf2JDF5YxB/mK1B9gU8l0ZZ1AC925dsn0VXnkajTxb+F3K4ARs2WYx2LZ2D3qXxaAzxwL+qtWeDJr908B4fvFi84kgT1Qv2U2aU0VsU8JNbYxo7hNKt0KlwEl4urDuuC3HXD+xeLmY+2dnJ/CrDKqU9NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSSdBsQr7XWMsiueRcxzVMNtve1s7Ng7N47m3vQdIVA=;
 b=Hi7ID1VMiRlAF71rZ+W04PGR6MoxK0kMdvsslskHjzlByIshMFl6D29mbF6rxggBQr2tTbp7RnggTmX5EIZlK2FtTSCLUKr9AWtmwoxR0TahJn5uw16625LDzLa6R7u8GAPecZAlB+u1gc6FH4DVVCTOnlLVi1Jm7MSlFHmPMz4jT/fZc5VppDAbrJoc/Rw1Yltorn2McpYLuxquCAF/4LcMAm6HhE5Zc+DRwwFYi8vmivVdRoMr+BUwWggoIuCR3A/Vd8RcqIzu7E2tL7WmPrUSoZouwkDtKvlUjCf/grj0Dqg2Vo8hcd0DYWq+ebEaLeE/fvCsay1h+iwuqzzQ9g==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:28:06 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:28:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 01:27:52 -0700
Received: from Lancelot.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 01:27:49 -0700
From: Faizan Ali <faizana@nvidia.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
CC: Matt Johnston <matt@codeconstruct.com.au>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Simon Horman <horms@kernel.org>, Faizan Ali
	<faizana@nvidia.com>
Subject: Re: [PATCH net-next] net: mctp: add MCTP_OPT_ROUTE_SRCADDR getsockopt
Date: Wed, 23 Sep 2026 13:57:26 +0530
Message-ID: <20260923082726.2918670-1-faizana@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e272f7d7556a59671db7e4c5503eb69efc27759c.camel@codeconstruct.com.au>
References: <e272f7d7556a59671db7e4c5503eb69efc27759c.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cfd3ab-4212-4159-1c84-08df194c9789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EEFeyRrZWbI78wJqyVksYge4dgnY4X2LA0qToEdCbiX5meI2bKdduFjshbdnqfuieidC9V4kIopXoJIz+odFb+25oqhzwW78udic5ewOxqRyz2Bxc64yCUDctoaLoV02TaFpVsjcGE/CkHfWbybB0EqVTY4TX0PGGu8Ip56KieFiNZmC2f+81MZLigdR2xHkk5y0j/SDYpQDL4+cA2t3aDpbdq5PE22x/T9D8t1LgyYDzojtCtF9+ssWzP0p0IpJ5EXbYV5rQu8Vd9Hpf05gCasexJuQkHGn+7SvBNVkjEfmATVUI3FDgY0offtgUsxogAigX7L6r08dMChTmIetulLAYuWYNz7I6DBNdqeVCbmxeC/Bbo4s7XL54e/9bGCBIRcXIX1C6s2rrtVJenJfj0k5cTL7YCtDB7+SA/QT4dE1MOVrb1oO/Br2uoNmqPt60kbJlV4FpZl943hN6rGUI/ylxQSO2fxpLibV2cFYdvsqbPwphZsYNlh44BntTkzWL2XEM3BYMn6TwC3XSvW/fR9rT1X/TZch0xeqmPKwJxBpVm+YhQ6C2YTqY/4gTPgIrP3sDsCtudbcxhGCMdGsohwgDkzqB1T9Y4WvwpSJfUtB7ROqb9r4gdb/JSUC9LqvYjom183JaaZB81Bz6aeX3Eb22rLjXq3E5ZBivrihf8w8D5d5uBH/hyTgTzSZTTxzraPN/ct6JefLNkje+2Jtug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gDi9ST/KyDauovuHhuj+ks/z9hYw4FtvQeu9rscDkyjpLPTduA5y/K0Q8QqL3l37nILLA3M/BbmKrSMc8nMsEEzwFuiPpLhM6F3SfeHdJp9awVLYlmJfp4L3jroGji24GLs/VJtRK8WWYY8hTYz8nOJ9BcF/XuEralec29MNsJKNtgdzJXDg3wvWoBorh7QUIH3CuiG4RaVYlZuUMNW77nDWZ2912cQGXzRbnnQJyLLHiWCf4GEhm7/bdKSMBP3k+NTd7rM8NQ+ZP5Jbig/xzB3lHGW3+7mAcP0pwCgGTxacYccxh8iI5lfnpKnotVBwI7mHhP4p/bj0Tk+Gh2dM8+uYx8BB32VqyWySNVjXcRSEix8e6IXusv2tABqH0cWARX1C8Z8F2gaKQHehbzYiSudH9/i53k3sJSWjwZmCuxxVIQB2flALmkL9vOOdsQzQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:28:05.9211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cfd3ab-4212-4159-1c84-08df194c9789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615

Hello Jeremy,

Sorry, I missed following up on this earlier - continuing our
conversation from the earlier thread.

> As I had asked earlier, can you elaborate on why this is needed over
> choosing any local address? Is there a routing topology where this
> would not work?
>
> I'm not against the idea, we just need a fairly solidy justification
> for adding user ABI that cannot be changed in future.

In theory, yes - any incoming message destined to an active local EID
should reach an application bound to that message type. That said, I
still find these problems with simply picking any local EID:

1. It requires a snapshot of all available local EIDs first -
   information the kernel already has internally via the routing
   table, but which applications can today only get via ad-hoc mctp
   route/addr correlation.

2. Not every local EID is reachable from every peer, even on the same
   network. Example from our hardware:

     BMC --USB(EID 8)--> SMA(EID 20) --I3C--> GPU(EID 30)
     BMC also has a separate mctpi2c0 (EID 9), unrelated to the SMA.

   Reaching the GPU is a gateway route (30 -> via 20 -> via 8), which
   mctp_route_lookup() already resolves correctly today for
   sendmsg(). If PLDM instead picks "any" EID and gets 9, the GPU's
   event notifications go out via I3C to the SMA - which has no
   knowledge of EID 9 at all (it's on an unrelated bus). The packet is
   undeliverable at the SMA itself, one hop before it would even reach
   the BMC.

   I acknowledge this is implementation-specific, and additional
   route provisioning on the bridge could help - but that still
   requires out-of-band configuration to stay in sync with every
   local EID. Separately, how device firmware handles Set Event
   Receiver packets carrying an EID different from the one it saw
   during Set Endpoint ID discovery is also implementation-defined.

3. A picked EID doesn't stay valid - interface teardown (hot unplug)
   removes its local EID from the available routes, and Set Event
   Receiver is a one-shot registration with no way to detect that
   drift later. Further events would then be silently dropped by the
   kernel, since it has no route for the removed EID, and would never
   reach the application.

The kernel already walks this resolution (including gateway chains)
correctly for every sendmsg() - this just exposes that same lookup,
rather than requiring applications to parse route/addr output and
re-derive it themselves.

Regards,
Faizan
