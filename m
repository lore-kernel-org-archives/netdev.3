Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982497;
	b=EOINbDK5QZcyt2KAMqfMuL2CpbFeFBEso/ZUxxNJE3QHKkJxh9iGeUudtjvc24Tba5xg
	 oVxsFoqPBj9wCYspFGPfW1pPBoAm6AHb8JsRMr/voGEep7Rta2MhfDOqgTawsPW9TkTr8
	 a0vDYaqpCYWVizYefWxZgbVRGzxrijV7f92CkphoHu49qE2DtkswcPepSow5uaKnzLrdV
	 19smRa6TaiUpME/ObZGiKi+QTf28IJ+SRFJpJl3Frbb5H3l6CUY7dzV61yM3olmDEmhig
	 MV9zo7Ihfr0iAd696JErVgljBzPZkVMsOS5ffQx4fsvfAP++Rw4wsgs2fUUpdkn5dag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982497;
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
	bh=51oqTCp0VerXmpj09a10+mbBp7/VFYLmOU/9b9PraDI=;
	b=C5ETUkQNKhy5OsFcEeBFiL6b84IVjsGPiqpUgbMrlX+rd4eUOHVD+zANAFgsZeTmLctj
	 HvXvOYKOODIe7v28MoIhBhVXwA1B26/TBonLXdvIDXAA9DnEpfUHNtSnL+i6NdVuz09j1
	 d06F/KVRhJ46IoLw10Y03XGouylbPcmEcTRJhko446PAT4EZzrXOm4JTLuBqpHi/jIhze
	 zfgCq5q6C2k2MMuYpPjx1xEz2tIYbGPr/NvfVdyL254T2AlTpWksK3LPlNVfd+AkB5yW1
	 4hi8opH3cAzHLyznCjvTDsteIPm7r64Nzv3CTlM8KYCvUPSJ/EL1vc1EX8guLyB9V4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cNFlmXGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252E606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7252E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cNFlmXGl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG3chQ9KdnCpeNSUyYbAXki1j1dP1q1HomgRXQTSN0A1j6Vnf6x2IdAfg5AWSqJHuDIwPqiBxU4XWcVKM60k2W1fBWTmyrI4729LqJwkGceh9jlywvqjdmZzTqYPHSCJXluHSlygO1id0SCnzKnl83k5QEcKtKHpbijaavjahuo9Q6G78r6BgNW00mZxv65UUSp5FSMDoyZFtmw9f0ZaTm1HblSxp69ZpSrC/MvFstCF2m27V4vIQ7edhR+9I1Eh5Xc5cAu6srGJ+Y+IIR+fL7eMolGZzbOJ0Y+0vC4Fqbl7JDBXi6XIAGXYXe1Iv3sxcmayLTbjy9aLVC4e4VNSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51oqTCp0VerXmpj09a10+mbBp7/VFYLmOU/9b9PraDI=;
 b=UavnaexhyYFoUb0i4XbZurdhztcPgS3mH+prKx6QKqbk3Vx0in1iJCRKbOyT7tLjV86E5Z2k3q4p1OWxU5+IlD8rLkMCSfAF4OgKuCrC/VokF+MVi4vBZsMtzaUd7o5BHwOKbwllVFh1vBVnMG+zmeJzyZbJp4i/ksJLt5oV209Ti2/AqCDOanW3QDdG3GqZaS98NVC4dUC7bFNPPQwrEWFhf3obNK4d4A7YJepB9fVPi9dDfzJHD7xJl/BzN6tDG3z+6dxYPkaNNzHmLU+hCjOx+8eUYRPyDvomtHDU2YZwD2YeTQUsnp4UP9S/+z1MnkfTQoki8ygneay/KTryOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51oqTCp0VerXmpj09a10+mbBp7/VFYLmOU/9b9PraDI=;
 b=cNFlmXGl6Uv+hnqtas8Zuvi/p7xqyy26CHFQvLffc1JJDvHrTyxEQct2Eai34OHaGt8sbvfqKGqv6cngXPCnvnTApeEOmJIW7H56qvDHteuwIXROLelruLJgF5kKlPqPTA1P1i1bBmYF8xfNkT9yBU+XTEZl36/l0GTC0alkB8l7FWPzrNVuId+wkimrtH+0VF74+/q4mivgOYkMGQyhGcEXUYCE0DrQNjzq82CFXwO5GBGulOlQtpkcXjfylnH3jbWd1VRW1GE5G+DHeV8dvB9cypcTgU9WHG+twvUydFOQLi95dN2XqGYcYdgjDP5N8t9Xn9LnJgm33bpsm0qypg==
Received: from CH0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:610:e7::17)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:28:12 +0000
Received: from CH01EPF000BE94B.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::a0) by CH0PR03CA0222.outlook.office365.com
 (2603:10b6:610:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:28:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH01EPF000BE94B.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 6 Nov 2026 16:28:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 08:27:48 -0800
Received: from tuxedo.mtl.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 08:27:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2] net: neighbour: Avoid sending RTM_NEWNEIGH for a dead neighbor
Date: Fri, 6 Nov 2026 17:27:27 +0100
Message-ID: <780b925d4f8b398f425da9cc69ef5b435bdb5231.1793980278.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94B:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: d19f35db-442b-45f3-35c5-08df3c22f343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CvBLjQeV1SizHnMpc4sKDcSPp6S02ZNSVH/8SV3ZJpVcOWdTQl9z3jz98X0cuQwZK41k/zhAX1XkeH62h3kcl2Y2dE0rXBvBxRx1gcNpEmseog+EFo4SIX055JBL2DFvDK0rb2n3NMZ5Mn2zOKweL6wk7fWpc/EUdlV3g5QAgLzw8S+8ttVFsxOrBfGNJ/3tNRwE3EF5efRBzIKhdLs//rkYN3BnzjiMJzkpA7lBARUwTVnmn1ns8Pfycznxkqd3g4WXFnqPxqOlNAGkWbO9ig02QYvDPVbnMhxnkTjcML2r0a2WlsNHHbH9Im9lnXKPj9BtMaTtvu3e9f9bgv5U5ffL8dM3Hem210rIfvj9UMc2R7o1o/pT7ybxQL3+HT84h8RtaaKcu7UluwHdm2vYW7Vn6iXzuU/YXnQjGwtVR8vWENbBOrfXi9+mbzZm8fLkk9R/eUUL3BfiSaW8hSYZGl7bps2WBVXaAHL/Orlz6Y+HqcW+nm4YMjoacvS/oG5rTknnPzRmzLAcRClh0DZC9esGRvWEPfi6f64Klr3jG+mA6Oat/n7gsYsc+jOMYgd6bFDzgwew+Jt721ivCSSgbAmDzyeQWhOTbTFnqYs7+hhva/7e9qYnX7kHqX3XWe5lNxOY+MtlR7ySK1BsPMSMA2dDsR92lEBI294zj4DndO1J0RIwjaiHKPsZivfGMKuN5A+ESYbtFb4sWRrOH+pkdA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/2YBAxhWLcUqN4pLFR8URmYqwDqxyO5Ac/8rZqHGGkG9QWcM1zFJ19KAmtXXexZaGcrIAgien/8FSV35+doopFuaFL/8R+6m0etcfMSZrNWeNEqxmSFMqixjrYn8ZPh/nqYHJ4loBmQj+sys3fARsLGlqpomP2FJdgcLJynKyggovIcVjEvRcScmtXUSI2DdkkObee/kAkuYppL6m7Z+bjh23Z6os66NFHLzfAseziVlbVKqpYUmSFhkK+Qb2yrQgkLigjmyPewyfWwyQBozN96ebbORlFTB/qeicWJRVOHDHsnMHc5nJ4M15ON+FYuLXirrvOTmphVYnBwg6Isv6/4WcTbMF3gLP+S16UspM6F3M8Ga7PTpYaHQyagdlZE6/JC96UuL2oeGnAoFiXZ4Mk85A6dpHIIsXN47T0jnI/FofgVbrNMNqsUOWsOouiK5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:28:11.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19f35db-442b-45f3-35c5-08df3c22f343
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799

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
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Drop the comment from the code.

 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..d013d9f4bf9d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3593,6 +3593,9 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	int err = -ENOBUFS;
 	struct net *net;
 
+	if (n->dead && type != RTM_DELNEIGH)
+		return;
+
 	rcu_read_lock();
 	net = dev_net_rcu(n->dev);
 	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
-- 
2.56.0

