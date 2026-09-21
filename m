Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1A2F8E95;
	Mon, 21 Sep 2026 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962725; cv=fail; b=G1o9oCfBtUVdnH8xdUR8s9Vwd1GLURJr+MBz1o6Ble+YOpC1l4b0OnK04/eVbZG2IAVKMzhnv8BRhe0k/G6GFc6iLpw0Qxai35XtXOTKQ4nONXhBvi+PZEhpHWTf5ZHSx8OctR1r8273dQOLilfiau9NR0QPn8mzOiIGq7YEwxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962725; c=relaxed/simple;
	bh=1mkf8VvL0zLOhwCNscDYeLtx26JUAQvYSNuRvMJdBGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KcVaMDkGFl3mqdwc/vRgLUuLqYWYsG+aYQe85iT5tXu0VjhogPOmWwyLOE3cdPLjCtxA9SQvEgizMiH4kg+aIC5rURjk9jta7IH7xlB75Vtd7fWlBBWG/c6uYRp06ymcdRyWW1dwODWGE8JppD4r304Amx1h/p24u1ItnVIji7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecELPzEl; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecELPzEl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy5IUv1yTi886Ar7J4nYIaz/dkTwjaM4ato+NeE2d17VVvObHVizexVyYIFTFn2nLsIjXKZ13AThl8RYygIPmo01xXFjEBBfKinXQbGZ8fvMOalOAHjYpMZmypEumju5vrnmeqq4c8k/DkE16l2a5g2BzWU//46oSSLekLsO5i3MlTmvm/Paw+DKzGgpRqEyxdcwO41GgzDnV8zkp8Eswf1P3fMe1lR60C9kM+m/VeWrZIHXNi+Ihpa25Nck8uPxPimxbdl87uN26uS9qmmckBB7QwbNJnc4yuE4lZnFF/PB5A9lMW+9yrH3LI8yKbOCtLwqM1awDfhgCLlOnDJ/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6is8Rkqwq8EIZ52TZamsIQftOhZX+i2JPoNc//ToAiQ=;
 b=H8d4wQsRYMeLq344M8ZBAGAfGScKnrbFh4AWSfs1eBWFnBdtJSZpSXdEa+fzRw0u/4r2KU8kNuNWXr4/lLl54v9VGJ+KgpBgCdedot1RABjhGIsnKVH+DWV6oVaXhpMhNgfSv9afHJuP4UsISJ/+Ef5CgUyAZTWkkg6IFfZyYsekZ2qHa+6IxiwGkGXj8nVAUPBrQWvsBtizs64dvrSXQ/g4m1RZ8BoAIhDKAp7rW2XxMXezWPClNJIeCuTYRsxd4/N5TxsrQUv+MVqBd9Gb/AOBedp0i/zefWPD5Nuv/XDEhs80do7bGC1kLtHwm7tRcpNfRaljtiAPDX46Q5HGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6is8Rkqwq8EIZ52TZamsIQftOhZX+i2JPoNc//ToAiQ=;
 b=ecELPzElb9APu7lrgegxXBXbFY1eLhoTKSLz7YDm+x5hnahBK29xA5zM7iVgfk2vZPzrwPTYOVs/qfL4a1rcFcb3sqfpi0NFaBQheIZXYyjharNSY/mA1S4O2rWb5tYsElnpU78hfaPj7GgTYcuckU6SuK2AzNy8scYVWnITOTzLKop8O7dQeG1o51Lo/bfFUoOT9fyxwOGZr+DkM7KMcEyNP0Kv47tGNkK1MtXX0ISbt9MYHRkJXKJzdFUciq2+x9uX6Pq9e2FD4/tR8zcR23Tzzy8lLw7VpzW7yWgCCLJEZoTdExfMByerWAAio194v2aPXBngBp/khu9slFLTFg==
Received: from YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::13)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:51:54 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:b01:2d:cafe::72) by YT1PR01CA0074.outlook.office365.com
 (2603:10b6:b01:2d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 03:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 03:51:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 20:51:40 -0700
Received: from Lancelot.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 20:51:37 -0700
From: Faizan Ali <faizana@nvidia.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Simon Horman
	<horms@kernel.org>, Faizan Ali <faizana@nvidia.com>
Subject: [PATCH net-next] net: mctp: add MCTP_OPT_ROUTE_SRCADDR getsockopt
Date: Mon, 21 Sep 2026 09:21:18 +0530
Message-ID: <20260921035118.1649687-1-faizana@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: 138cae9c-4386-43cf-0ee7-08df1793aca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|13003099007|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ghOuMTWW/w1hda9G4Bj7Oi63N14vswFO8VikVbY79FXsFzrb2wgZMXGtcRhjfxtXKcjITrw+I2YRnLKoVxMdwgh/UtzoORSo6eKfrApSRLnbhISTb2oCgiEf4C55xHoOItZBGeCQl2xqPifiVXfweCElKugmQwRIAl6HBvRp3E+HeWXNUQ8SF4zSO4zY9AnmhePWoL0fuUusk0l4fol4bedVUwxK6ECHCFhaDAqVLGS1t16TpvUBTdGPXENAGFo3qYA2nwif36jcYdUDc1/W44zmjWIgtpat7sZE0H45l+ylMwGsYrgqN5gq/WmruJCyQhi6Rq1YO/HGp/b51q4mRguykZyMG95TC4aNMP5qROkHwzdwLJwHqv1jM10kF0FRYL4B8KQcXyd6iSjurraugs+ovycYuWvq7w9SJyi0r8yH0oDcfZbQeoTm4a7Ina9Em9PG5GL4uihJ1MJNYBZDfYpOHJ+uDUS3HiRU0f0LfzhqKV1cOefIe9Nq/5VoSVconlFfTb7c/v02/NIyHXo4GDjGxXHfjK6kbKlt38m+hC0sjNPRzkLcbF03DR0fQNjGp2/N4qRwWg8dzln0wE+vWc496dJEyglrHdyWRaJl+t7WTwiAB4P4060ZX8EeaNypAlTQExAH4IAuv7gUX95hr3MTlVr6o4c+WWIv3YJv9/TH9zinmmjuRamaM3Qc5vptm7MgarsyPtQTsp98dtoiqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(13003099007)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cBpSu6IuVauawq2nWXURI6inmAJ48JUVrO3qgw6hkEA/D4r5YmIvHW7/2Wt7OE6osV7E6+Zvb4/fkh1PXaLdxHmZKtCy4Nu0hHWShU5wVhQLjgrYySR4C+FDGh5Ws8OS0pIRHYpW70NLUSpLf801gigU+5Cvb4036+2UQqS31mU/IzFN3hq1dKVFl2pqUQY5LeyIgjK0JRL25yxLoNvn8iEIOYc4CMCbh9/0PyU8/cR8hwclRStvN2jcKfqQwwFyIE8wqeo0sDslLVsd9m+TP2Z5VBxHMVxwg+xGfCjAhn8w+qdJNn9TV0ETd06RuTqYW5JpOpIA4Ne20EUMeJKwyF6IenPPed+JTC+2xq+WSu+f5rVGHMKzM7tFww6cOa3XFtIMDc8dUf9ZDdSahbQToFHmshRdi9un5mDWngq0tHM2h3ugv6DsTqFdfvlhyhcA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:51:53.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138cae9c-4386-43cf-0ee7-08df1793aca1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281

Add a new socket option MCTP_OPT_ROUTE_SRCADDR that allows applications
to query which local EID the kernel would use as the source address
when sending to a given destination EID.

Applications such as PLDM need to advertise a local EID as the event
receiver address to remote endpoints. Previously this required a manual
multi-step lookup via the mctp tool (route show + addr show).
The kernel routing table is the authoritative
source for this mapping, so expose it directly via a socket option.

The caller fills in net and daddr in struct mctp_route_srcaddr before
calling getsockopt(SOL_MCTP, MCTP_OPT_ROUTE_SRCADDR); the kernel
performs the same route lookup used for actual packet output and
returns the resolved local EID in saddr.

Verified with the included kunit tests, and manually validated on
hardware that the resolved source EID matches mctp route show / addr
show output for both reachable and unreachable destinations.

Link: https://github.com/CodeConstruct/mctp/issues/147
Signed-off-by: Faizan Ali <faizana@nvidia.com>
---
 include/uapi/linux/mctp.h | 13 +++++++++
 net/mctp/af_mctp.c        | 31 ++++++++++++++++++++
 net/mctp/test/sock-test.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/include/uapi/linux/mctp.h b/include/uapi/linux/mctp.h
index 19ad12a0c..7c3d4a936 100644
--- a/include/uapi/linux/mctp.h
+++ b/include/uapi/linux/mctp.h
@@ -55,6 +55,19 @@ struct mctp_fq_addr {
 #define MCTP_TAG_PREALLOC	0x10
 
 #define MCTP_OPT_ADDR_EXT	1
+#define MCTP_OPT_ROUTE_SRCADDR	2
+
+/* Query structure for MCTP_OPT_ROUTE_SRCADDR getsockopt.
+ *
+ * Caller fills in @net and @daddr before calling getsockopt.
+ * Performs a route lookup and returns the local source EID in @saddr.
+ */
+struct mctp_route_srcaddr {
+	unsigned int	net;
+	mctp_eid_t	daddr;
+	mctp_eid_t	saddr;
+	__u8		__pad[2];
+};
 
 #define SIOCMCTPALLOCTAG	(SIOCPROTOPRIVATE + 0)
 #define SIOCMCTPDROPTAG		(SIOCPROTOPRIVATE + 1)
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 8af5e2b3c..5c6077e03 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -425,6 +425,37 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 
+	if (optname == MCTP_OPT_ROUTE_SRCADDR) {
+		struct mctp_route_srcaddr rsa;
+		struct mctp_dst dst;
+		unsigned int net;
+		int rc;
+
+		if (len != sizeof(rsa))
+			return -EINVAL;
+
+		if (copy_from_iter(&rsa, len, &opt->iter_in) != len)
+			return -EFAULT;
+
+		net = rsa.net;
+		if (net == MCTP_NET_ANY)
+			net = mctp_default_net(sock_net(sock->sk));
+
+		rc = mctp_route_lookup(sock_net(sock->sk), net, rsa.daddr, &dst);
+		if (rc)
+			return rc;
+
+		rsa.saddr = dst.saddr;
+		mctp_dst_release(&dst);
+
+		if (rsa.saddr == MCTP_ADDR_NULL)
+			return -EADDRNOTAVAIL;
+
+		if (copy_to_iter(&rsa, len, &opt->iter_out) != len)
+			return -EFAULT;
+		return 0;
+	}
+
 	return -ENOPROTOOPT;
 }
 
diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
index b0942deb5..b3ebc504b 100644
--- a/net/mctp/test/sock-test.c
+++ b/net/mctp/test/sock-test.c
@@ -379,10 +379,71 @@ static void mctp_test_assumptions(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, mctp_default_net(&init_net), 1);
 }
 
+static void mctp_test_sockopt_init(sockopt_t *opt, struct kvec *vec,
+				   void *buf, size_t len)
+{
+	vec->iov_base = buf;
+	vec->iov_len = len;
+	iov_iter_kvec(&opt->iter_in, ITER_SOURCE, vec, 1, len);
+	iov_iter_kvec(&opt->iter_out, ITER_DEST, vec, 1, len);
+	opt->optlen = len;
+}
+
+static void mctp_test_getsockopt_route_srcaddr(struct kunit *test)
+{
+	struct mctp_route_srcaddr rsa = {
+		.net = MCTP_INITIAL_DEFAULT_NET,
+		.daddr = 9,
+	};
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	struct kvec vec;
+	sockopt_t opt;
+	int rc;
+
+	__mctp_sock_test_init(test, &dev, &rt, &sock);
+
+	/* Query the source EID for destination EID 9; the device has
+	 * local EID 8, so the route lookup should return saddr=8.
+	 */
+	mctp_test_sockopt_init(&opt, &vec, &rsa, sizeof(rsa));
+	rc = mctp_getsockopt(sock, SOL_MCTP, MCTP_OPT_ROUTE_SRCADDR, &opt);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, (int)rsa.saddr, 8);
+	KUNIT_EXPECT_EQ(test, opt.optlen, (int)sizeof(rsa));
+
+	__mctp_sock_test_fini(test, dev, rt, sock);
+}
+
+static void mctp_test_getsockopt_route_srcaddr_no_route(struct kunit *test)
+{
+	struct mctp_route_srcaddr rsa = {
+		.net = MCTP_INITIAL_DEFAULT_NET,
+		.daddr = 99,  /* no route for this EID */
+	};
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	struct kvec vec;
+	sockopt_t opt;
+	int rc;
+
+	__mctp_sock_test_init(test, &dev, &rt, &sock);
+
+	mctp_test_sockopt_init(&opt, &vec, &rsa, sizeof(rsa));
+	rc = mctp_getsockopt(sock, SOL_MCTP, MCTP_OPT_ROUTE_SRCADDR, &opt);
+	KUNIT_EXPECT_EQ(test, rc, -EHOSTUNREACH);
+
+	__mctp_sock_test_fini(test, dev, rt, sock);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_assumptions),
 	KUNIT_CASE(mctp_test_sock_sendmsg_extaddr),
 	KUNIT_CASE(mctp_test_sock_recvmsg_extaddr),
+	KUNIT_CASE(mctp_test_getsockopt_route_srcaddr),
+	KUNIT_CASE(mctp_test_getsockopt_route_srcaddr_no_route),
 	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
 	KUNIT_CASE(mctp_test_bind_invalid),
 	{}
-- 
2.43.0

