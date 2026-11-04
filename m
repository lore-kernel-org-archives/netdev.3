Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800682;
	b=j6T6eNU3uERW2XyDdwJbTBEV0R+FIbwuXsBB8oC81N58w3dr1a2346ThF67zZn7914JT
	 y37Hr9R6QNd6FEtZCzXQmc/04s0QckT8Iwto4CYM3EXNoBWKZN3JcdJCUkM1fL/h3TUnq
	 cHz5Po4bl86F2pBuFHgIhVtOL3TALJBkTJtlKNb1M3zNhi5YvVbITmiAJxJOud54bC0Ll
	 Rh/qpcm2jkBT+OtxDKuw6+3PQsXMdLJWnPK4+64SBH1yv/P3iWo3UtMqujdGywhA/jkDw
	 XUX68T1pySgWLkFFrD5nzyfoheE1wDWMtp1ZmpHLfrRc4anzsI9YEnKzF/MyJg1FtfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800682;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=0Ld5vX56sRU7cDmhENLu2s+g2ZXmsedVrDad1btRlgg=;
	b=W4EKzKeuxdTAvn4J0aziMIjwZaXFxJNvyomHnOz1bAdhEbUsB6pgC5qFE0mL572s6Fyf
	 pUPkO6nzoiebli7eDOkaN/+KkSpnN9BN2eMS/FvFNUVLUB0G3pmzSOMx5bGkDDEA9dsqZ
	 WKWPJ2J4n49KsXGFBC780XmPvch0ChMqxnlag82SPewwODHQ7D9eZL5cpwqoCLMIf5d0g
	 8VyLfZLT/g8fgLAnbkHBlPPDrWocNlbGotQnEX6WoKU5ip2ES2e55Xkdv9BjjYQbKZf0M
	 NNCMgUWQJb9aQRFiPwzhjFIufR4JwGuWN/TXcBrKDv0Ltq959jOgfJdmpZ9DPXKwqDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A9tNqL2a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.70
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B3606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A9tNqL2a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhLPz2rjrE9lRT4ZWgIfl5iTlxM4yaykgFPwP4LZpJU4E1+yvKd83MCFayfPHP1ex05nNyp5WoSWqJIi6TtS+gLVIT2NnF2rxMegRPz3Ij1odQ9y8LbZr8nF7Z7xbAf/gc5I+a5kBSUMPV9ytTFoK71yDnaWfZPDItmQqa243JUEl2lt/FVCwxhWRhxWOF2kxSKdesuOhSRIuDWXFwnP17t10RTgUTmNJgX6Q/2cyaxHToeJi8s/gs7PbPqgC5CXLWVyVzrb/6I/BBLU9KNbfDcIvNmFkGk42PIIcGtiQLt9C0vTcICPx65vJxyzdewnZo/Fsdtijio3e6+JPYx1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ld5vX56sRU7cDmhENLu2s+g2ZXmsedVrDad1btRlgg=;
 b=WGJzUSilOTFo056XcseNkG7GC6jtoAjKrCVNwBuQEiyWRpbJEPoerZWb92TjeQcAaRsfkzAgg/zmJD3+L5Qlg26nSSLSzr6WXybx4SIvLTnTeFrVvum9rJQzDlBI14FXuc3EU73gsPDaYyjF5KxKdADiw6L7cVjO0n1bZWOW8RCEQM+Vfz85TWVNJNF8II4wKAG+k0gLzUgh3e5WuubuUqAs2bAOdp7+xouXYhZoK6vxuXR5guogWC9nl+mPgx2e6eKd2v52HlV3vEFnJC8+fn6+z2ChREcJ3WdT0PPbT9FPEyD2P7WxeCzYdi/CHDgzKF4NUN4/xxxBETNmCnvavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ld5vX56sRU7cDmhENLu2s+g2ZXmsedVrDad1btRlgg=;
 b=A9tNqL2aZ6yWlZ335CQFOwvA84PvNsaFrE4c2FqfCBUU9AN9KOgnWgBxCrQxw+z8tAdzn2yk9bJOO1djU2lTIhZ5pHBrwHUXAmHqSmXS7ng9e3lJV6l1Yy32sRoeQuKcIIJ+zaMM6u+gDV20HWMZljvNt/57DvD+PSTZAxs13M4Bby9TbU2Ci3GSySs9jmlwvdrc7jF0zyPeGFcYphYsIr+i9JCmKo1nj9U77qI6V2RXhMobfrkK9nB5NWglzaylr5PREg5z5evUzOrV43BO/z5taU8HbXK3jvuib1uqk88hIba90yYoptMzgoDkxSdYH9eDoUD8gBA1aJp8e9KUlQ==
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 13:57:44 +0000
Received: from MN7PEPF0000014B.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::18) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 13:57:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN7PEPF0000014B.mail.protection.outlook.com (10.167.254.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 13:57:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 05:57:24 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:57:19 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next] net: neighbour: Avoid sending RTM_NEWNEIGH for a dead neighbor
Date: Wed, 4 Nov 2026 14:56:56 +0100
Message-ID: <217109d64f0cdcba1db9569ee6ff7304754c47a4.1793793623.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014B:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d586cdb-912a-430a-a86b-08df3a7b997c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261022105027099003|261026140227099003|261022075727099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VxWtaWsFWFfbV6xEo7qdz+428QWuT+nCbeTbHDzFD1bvNX7whKqBvThk4AvplLwhIDp+LUVC1ZyaFSIQxzpqLOyGW5AbN69oWanZT46xTFTVxgdx1MtTSD+qFh6tTqFLm/mcoarjMa3XK7tNpKzVb7N7hfdopUM1Pv5TJ+W88Jhb8Dis5HNyDVgR0hdrG3z6/h8wvOM6KbGaadqoJx0lkTiJCC57jN3hokXO8qt0y9FA4rY8kKzvJrA/DWnnet/OKI+p1E4iqy3Wa8SobLRrMhcsNWiuigEiq7MPqtw6INlCeFP+Xeow8puoliXHwShkHReWjMI37ZWGEDA8T6MbcO/o2Yh4rsDicjKDomKsOd3SpjI1k2BDMvObps6f/EnvLhxBftpTYVVSwNwf8R6R5IYAQwTw5LYyWfPmKMH0o1UOuxAoM3wwPpiqEFSSdWTyRu9N3iY7YPi2TwUHBEI9oIautf/0rydpVSzuEjrtciUmPWJUVJe9oupNNJT8kxFR4EeIWNArv0XR8O/aFBijevkytye5I/1Mia3Zgcn9kW3a3YbkV7OJLLhRQz1S/tz78hYaOycGI2yjm7xNSi74VAGvqSaQaTQZ/ER6QV204YlNVW910I+7O2n7uUStLQU9ZxiEma6Z/XjRZfKVFqJzOY31nRCg7H6+9xT+ffLT9AmiGaXcKOvHuZXy2PFIW2CBR+2Ot4dtch+O8Cx79eWsjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261022105027099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nc2EYmR0VXRY3anLPXkGApTUCG4SBndCIh2x3dMlauJOAgpEg8Rzy9COZo01qi5n525iARvdJvsekpsCY+vE5uOySDv42zAhIG085VPLD3zkkEF1Vfg/0CXBEelQWkYSQ/he29XtgQGAloCZ0PwO0BNvvkaoi751qpNP0f5XORr51FOJZFqnWMLt09pM+WgbalLSnPhmE2ysx69ONd0vzgumlAkfBbXKV+dUFSrB2ewyaaikkqlMd4BVzz2F/WC8U7XfCFGnK64wJZe66q+aEOYpLsNkgjeFS+aDmHksSXkZVgYjl4IJbdMYgN6NF26DYrsAGKmADdVBTAmBsHR/enKEXWB2N4m4PbbCzUwHefv2q80a4YUpkA+kc36jElb8lSeyH8MbiEEc+RAcswtKylm8arb+jvYOLoQdPKy7AYlIsT5vVpsKAqv+Qp32CuJB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:57:43.8413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d586cdb-912a-430a-a86b-08df3a7b997c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

During the processing of neighbor timer, in neigh_timer_handler(),
when the number of probes for an unresolved neighbor is exceeded, a
non-ext_validated neighbor is marked as failed. To send the ICMP /
ICMPv6 destination unreachable diagnostic, neigh_invalidate() unlocks,
and gives opportunity for a concurrent update to mark the neighbor as
dead and send an RTM_DELNEIGH notification. After the lock is
regained, neigh_timer_handler() proceeds to send its own RTM_NEWNEIGH
notification, this time on a dead neighbor.

Sending an RTM_NEWNEIGH after the corresponding RTM_DELNEIGH has the
obvious semantics of recreating the neighbor, which is not what we want to
convey here.

Userspace can in theory recognize these faulty RTM_NEWNEIGH reports by
the state, which will be NUD_NONE, but there is no reason why it
should.

The following diagram, which illustrates the issue, comes from Andy
Roulin:

timer handler (softirq)                neigh_flush_dev() (linkwatch)
write_lock(n->lock)
nud_state = NUD_FAILED
neigh_invalidate():
  write_unlock(n->lock)
  error_report()
                                       write_lock(n->lock)
                                       unlink, n->dead = 1
                                       refcnt != 1 -> nud_state = NUD_NONE
                                       write_unlock(n->lock)
                                       RTM_DELNEIGH
  write_lock(n->lock)
write_unlock(n->lock)
RTM_NEWNEIGH: state 0, no lladdr, ndm_refcnt 0   <- stale
neigh_release() -> neigh_destroy()

Fix the problem by refusing to send any notification other than
RTM_DELNEIGH when the neighbor is dead.

The issue comes from a user report and was obseved in the wild. It was
reproduced on a vanilla kernel by extending the race window by inserting an
mdelay for neighbors on a device with a hardcoded name.

It is tricky to track down where the issue was actually introduced, and
practically speaking, it may have been present "always". At least as far
back as 5.10, which is currently the oldest LTS-supported kernel release,
the code still looks substantially the same: neighbor timer causes neighbor
invalidation, which unlocks to send ICMP, which a flush can then race. Even
2.6 has elements that look like they could combine into the same race. I am
therefore not citing any particular Fixes tag.

Assisted-by: LLM
Co-developed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/core/neighbour.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..6fa490f7652a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3593,6 +3593,13 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	int err = -ENOBUFS;
 	struct net *net;
 
+	/* An attempt to send anything but RTM_DELNEIGH on a dead neighbor
+	 * indicates that the neighbor was marked dead while another update
+	 * gave the lock up for a bit. Do not send such notifications.
+	 */
+	if (n->dead && type != RTM_DELNEIGH)
+		return;
+
 	rcu_read_lock();
 	net = dev_net_rcu(n->dev);
 	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
-- 
2.56.0

