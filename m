Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491411A704B
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755198; cv=fail; b=B/ev+iUU7PJE6G9os6MNcqnF0+CA0BpdmiZ09C1U2DOapvo0lSeot6LG4Re/zhPmPQGLxfSrZZoDWBPLGd2kwUgcpOMkYUTq08SECTxB3axJaf3M0XxvPoXgHjmIbFXy7pgB0HHqd57K8CJEOZg79lKPnH/DG926VcRJ9rxgbks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755198; c=relaxed/simple;
	bh=3+wzFijWZ55IFtIV4sJOeDCaENVXo4maBcYpuaBTcSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8NRS5FswTyb+F2eD4RAFKGQ+t7s5aQmeJUQP9GFuGii0rI6mhNrb9WjR4QqRlsKQUxglKvY4ovoK5TR8rO+R4SFERbeG4NzcrcSnDwmo6mrBm559VoDRpH+T3UuCCx6HKTWHHMYq8avs0JVzaxHW3D06PXPxFx3Q9UU50/SG6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EV7ErkRH; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EV7ErkRH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn1kdittCVvhTpY14LzXobdsEhyDdWmwKsOtBmGtIfjLqHN2H0hYBkBsapa5eTqQuSAzUk/jDSae+XDj8EqORJJOgN2IEFaAp4ukM063hLVBH7RcEjxvz6E8ghuqM5gbQA3b9bOWRA/sSyAbq0/2p+sSwEO6NXleD3I59qRfnzF+Ucu0CgOhYyDYzxXDHpIjiSliiorP4vqD7iLlJm4ZjlTLlzXJf1m+4K5eRKKlDBjZjBeNpEtA04SpDrOcM8+fThqSq78n/AfefOyz62cCyAqF0C4vjaXXLXJDYWg2qnHH+NDSsd34s8D5nXq0aW5epgjGXxiUAsyhkhzM1nW5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI99saZrvkbrQDHI8Xh1NsQJSP4oEccn0/i4TcuvepQ=;
 b=aby5FfRTpa+jg22VKer4Ka+FX3mNe5CAMI8c8lL5o5y2jwZIxKeBE4F7yuaJTffGrCsvz5kUv3hnHZg8jHRPrDnSs0mzilF0Q6kjzTU3aGe4mX5Za9K5h9ZBLtf5Pi4wEQM62uVM6sDlaAZB2A98PWJSoipGf4VGcv2F31C1b9mKBZu5fnZCAv8jjleA73YzRXfizhgDjLsM4E6+emT//YLTW3z8JmzMsP26C5D6BI3oFM4GCrvqdNxmliJpqzW0f5pkwW5hmTewIsLKV9FA/Wd2UAYZupscJRnRC4r3/tC8htnxanNB8ih6nM5RcoN181/3GXgGC56EoXnAf4bvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI99saZrvkbrQDHI8Xh1NsQJSP4oEccn0/i4TcuvepQ=;
 b=EV7ErkRHC6FCIcQGdAFQMGfwhx7i7VarzLbEn/UUzxu5QrENnPaLV9CEVOnXXDzdhui6TyYbmPVZlpHs+3OKmt3HNt9qHwsXt/Dx4RvPbJrJWh1lWkTtzlo7yt/dk3tR9SeQrqXgdaf4Wh8Y04PQBF2B3hGox4l1mvkzqe5t9ehm1LP3d7HQ3WtIbOqzuxNbY9bsFSNQjmManeFq2BH5vetNizzZN4jZhOW7mYVQq++ny7/gBJPlH7U2yLmcUZ/N4ADQ1z5jow7XcQp54lW6FYcJ7GPewVQTAYdBjoVI/rMCqOqs5/1xEHpSYbru7uB+TBvtkJSbg9FfJ2AdZCqE4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 26 Aug
 2026 14:39:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:39:35 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 4/4] selftests: net: Add exception cache tests
Date: Wed, 26 Aug 2026 17:37:35 +0300
Message-ID: <20260826143735.1819315-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143735.1819315-1-idosch@nvidia.com>
References: <20260826143735.1819315-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fc5e8c-8416-4d60-0608-08df037fd969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|6133799003|10067099003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	nioEWGW+zIVdg5CFoudh1eo7nzYLzgrrw+fN2i6QsU19c9VTIsuwHvegnEqqeCwcNAk7ElZnWaYvwb9oHFmIJXTQEbdNHsUDTIitmB+O/BP8DJZajQnB5493abFeli58qOBTbwrywLnkZPfZRYnCwlxfZkA7PVuMNbGb4intDhGL0DzpSeQUma7jt6FdYmD7bg4n9ttK15mDwa+VhODGrGQbLxqM5/saaSSaxJAiODThD49Qmwtg0stgHcpkP6FTeWSjL2d0ZQHAiA7o5yxYVVHxU30g/lJI5eU4P5lS8Zle+e7cSnSwoY3humtKwmss3x84e8oB+kq2UaPG35xT+6qBBVcMQhkgf3Zsea2UWmfHL0EtwsdZlT+pdz4ph4xcwjIDuNvXBtQ83kIv5lLy5nrIFgl3BfTbemQFDf/mLZ6bi+E91ScDgaXFFpcMJHynWiT+WWQd25prxlXJq2QlV7NnPYW3YEAZk1FgzQDAMvNSYk9My5p1/K3tnFFTCv3BxDk16Di3P523NHz0pCX8SjXZOBOGnH+KiF054g2uGpO33QoT0/jOBDePUHUkB3TwPntNqWedIe5HpZuFVl1tBX1YIM43Jk1xd9Dvx7cGpf2x+sDf05TEqer3u/s+4ISZ4yQJMKAiENcsOMNe3gSgJhT+zL7pf5LcaK4QaFr18cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMC63EO17T5I/vjb1KMTLIKbu1RGbe9Durfmq5C/vLOHQ4CqOQ+DdI886zW0?=
 =?us-ascii?Q?njMdwTiiLa1Q3iWKiyZ6e2XN4A9iVouMvbJSRP12yxpd9HLNB0fyBYbtJLIf?=
 =?us-ascii?Q?5/h1GqTn94B5xCU8w0GfyOnui1cKtgoVWoeKNVDreJ6m9ET6Mt/+jVw27rgr?=
 =?us-ascii?Q?7xGqMH25+LUWVfWbAg9JTgSRt7ugHu4Ql7GnW23vJqVbDtttNPCitTVotWFI?=
 =?us-ascii?Q?PXtNVv0ksQw2FooJFoVEZvgN/ptX08ir9oqstrBR/m6CfDCwImTRsfT208kj?=
 =?us-ascii?Q?SJOoGmyQL/OK5otbXEnordrtgCGabQ1JOYII2jQyYrXydpJP8xdILalppylw?=
 =?us-ascii?Q?rFfKQGUo83DnExDTJVFAlMcvOQQlOdjuUxXkpmDzK46B3dtJqwp19PBgj/+v?=
 =?us-ascii?Q?oDLJpVYYpFAzx2/YBNRP+jFMmsR1ktXKCP+fN3No2WE1u6Mc869Oh9CNrQ+/?=
 =?us-ascii?Q?MeAmeRGbUBY40jnbEiU4N/hzEM99itOcW+M8PT3QwWtZqbRIdOT0+IPf7l4t?=
 =?us-ascii?Q?qpX6HlghNmb0tBCRUivNeTGkkWHnKd1uNhjNAwlsjT+Nj+rQcS9KHPFD8V+Q?=
 =?us-ascii?Q?9hKCO/5348qC+JyJS6pSHGuA4KDTsFla11YKt3l70NVwx9kWwnvSPuuKpPrg?=
 =?us-ascii?Q?v05R6HaiMl1NJ2PC6d5DJw5zINBm1V+qx55x7WUSLsVw0iaNU6K/NB7Qky+R?=
 =?us-ascii?Q?aB5D5uW5hmoQNF+15i7asHTqO6TsM7pnocHfohVvf54kuaZ1JZhtq+Q138JV?=
 =?us-ascii?Q?Kxtnq5m0q6YLMwcenriKR5bNjD6QDRsG+gdGk0egEW1/3YCQPnR8eqKAgUnr?=
 =?us-ascii?Q?4TUbXoydWb0DjqH2YMJZDiU+N9PZ7WPgUhuJYHo2ydEUKB3XSZIFCeXRgAg3?=
 =?us-ascii?Q?5stqjplhFCDffz3kmE+EkztQYuImCZ2alQZiEafKUGdQ/qetC+lVedg7ZolM?=
 =?us-ascii?Q?wNXvxlFdS4vKrgrn2p6fLnIrqO+iHGk8fgooBsOHqJIE7NbwoZN6fcaG64/p?=
 =?us-ascii?Q?Co+o0orzJzHTQMsGmpNwFuVP23MQU3A83iLRADVwe/Oz9sWegP0J/JXCKGdS?=
 =?us-ascii?Q?2k3em9ntrrwEQN+C/ETQ7lxvaDMZUBj95wUyjy7ddqyDVAvIkDTBB8ksmOk1?=
 =?us-ascii?Q?MAzX06wCdblETdHKKfbQ840Qb0Uku/itogPcYCPkR9Yi0vZ05oRamkTQDAgM?=
 =?us-ascii?Q?JbZ+s0ypck+JkRozmA314AMQkVUlDUEM0+hymRPLIVYFwbsF/O3540CxcqF1?=
 =?us-ascii?Q?KlMeN8xv5NPPJwg2d+WV8moUa7vVtulrR/lDgZ9o3uKTwOkjEl65AsXZWfQU?=
 =?us-ascii?Q?APWxQtJDqr6SYBejim86EiUKBTJDTXORhRhaLaniRZ6FAJxP6e9bJQw/p9Ei?=
 =?us-ascii?Q?cWUznXjkIce4a/wOVtR02LYOUu9hnhfDFIJ82QLiFwiX3wswENwMH3xb/7JS?=
 =?us-ascii?Q?DMVmWnf2zYSZlqaorQmZcMHoahbmhhNLGUneZkGHxwshSnsJt1g1DpoiD77Q?=
 =?us-ascii?Q?8YFoJ/OxMGS0ZNn4zJkTAVcva26R7TbKOGryY/pz0VrrJhbBeqgbCwEVtJPM?=
 =?us-ascii?Q?A8JVdYp+V7r6SYXnMYJHxP/c67jKBbUlyIG6vhz7UO9W9ZzX5vFjZdzDm4jT?=
 =?us-ascii?Q?WFBkhFK9CGVWGyS4voKL/thC3scyhJaZyWa95bPuPcCyd2Uu1I7znvYt8s/N?=
 =?us-ascii?Q?GyIkYAmtL+j42Z2Uk2wWc7ytkRgOKUo5ZXr8BOgvo8dh1QcjGqGuAZwbNsBo?=
 =?us-ascii?Q?j3cPhgnEAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fc5e8c-8416-4d60-0608-08df037fd969
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:39:35.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X01uqFIJe3uP+0Ro+yIqAZjyIKAYbYTmaOMH3ZmRMXPPVqZ+FXQABoFUG4OG7Xi99dXZoo0PJa+mUBx7KckBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

Add a test for the IPv4 and IPv6 exception caches, covering the
exceptions that are created in response to ICMP errors quoting a UDP
packet.

The topology consists of a host (h1) that reaches a remote host (h2)
via a router (r1), with a second router (r2) attached to the segment
shared by h1 and r1. UDP packets are injected using a packet socket, so
that an ICMP error quoting them is only matched to a socket when one was
opened separately with the same source port. PMTU errors are provoked by
lowering the MTU of the far end of the path and redirects by pointing
r1's route towards h2 back over the segment it received the packet from.

The following is tested for both address families and for both PMTU and
redirect exceptions:

* An error that is not matched to a socket creates an exception that
  carries the new MTU or gateway.
* An error that is matched to a socket creates the same exception.

The PMTU tests further verify that a lower PMTU replaces the one stored
in the exception whereas a higher one does not, and that a socket which
disabled PMTU discovery using IP{,V6}_PMTUDISC_OMIT gets the same
exception as the other cases.

Without "ipv4: udp: Create exceptions when socket matching failed" and
"ipv6: udp: Create exceptions when socket matching failed", the tests
that do not open a socket fail:

 # ./exception_cache.sh
 TEST: IPv4: PMTU: exception without a matching socket               [FAIL]
         No socket: exception does not carry an MTU of 1400
 TEST: IPv6: PMTU: exception without a matching socket               [FAIL]
         No socket: exception does not carry an MTU of 1400
 TEST: IPv4: PMTU: exception with a matching socket                  [ OK ]
 TEST: IPv6: PMTU: exception with a matching socket                  [ OK ]
 TEST: IPv4: PMTU: exception with a socket ignoring it               [FAIL]
         PMTU discovery disabled: exception does not carry an MTU of 1400
 TEST: IPv6: PMTU: exception with a socket ignoring it               [FAIL]
         PMTU discovery disabled: exception does not carry an MTU of 1400
 TEST: IPv4: Redirect: exception without a matching socket           [FAIL]
         No socket: exception does not carry the new gateway
 TEST: IPv6: Redirect: exception without a matching socket           [FAIL]
         No socket: exception does not carry the new gateway
 TEST: IPv4: Redirect: exception with a matching socket              [ OK ]
 TEST: IPv6: Redirect: exception with a matching socket              [ OK ]

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/exception_cache.sh  | 501 ++++++++++++++++++
 2 files changed, 502 insertions(+)
 create mode 100755 tools/testing/selftests/net/exception_cache.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 0f5c178bc224..517c09d60bef 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -28,6 +28,7 @@ TEST_PROGS := \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
 	ecmp_rehash.sh \
+	exception_cache.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
diff --git a/tools/testing/selftests/net/exception_cache.sh b/tools/testing/selftests/net/exception_cache.sh
new file mode 100755
index 000000000000..2e73872332f2
--- /dev/null
+++ b/tools/testing/selftests/net/exception_cache.sh
@@ -0,0 +1,501 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that the state of the route exception cache after an ICMP error is
+# processed does not depend on whether the quoted packet was matched to a
+# socket. Otherwise, an off-path attacker can probe the cache to discover the
+# ephemeral port used by a connected UDP socket.
+#
+# When the quoted packet is not matched to a socket, the same exception is
+# created as when it is matched, so that neither its presence nor its contents
+# reveal the result of socket matching.
+#
+#                              +----+
+#                    +---------| r1 |
+#                    |         +----+
+#  +----+   +--------+            | .1
+#  | h1 |---| bridge |            |    198.51.100.0/30
+#  +----+   +--------+            |    2001:db8:2::/64
+#      .1            |            | .2
+#                    |         +----+           +----+
+#                    +---------| r2 |-----------| h2 |
+#                    .2   .3   +----+ .1     .2 +----+
+#                                   203.0.113.0/24
+#                                   2001:db8:3::/64
+#         192.0.2.0/24
+#         2001:db8:1::/64
+#
+# Traffic from h1 to h2 is routed via r1, which reaches h2's network via r2
+# over the point-to-point link. The MTU of the r2 - h2 link is lowered so that
+# r2 emits ICMP errors towards h1.
+#
+# For the redirect tests r1's route to h2's network is replaced with one via r2
+# on the shared segment, so that r1 forwards the packet back to the segment it
+# arrived from and emits a redirect towards h1.
+#
+# The packets that provoke the ICMP errors are injected with a packet socket so
+# that no socket is ever associated with them. A socket is created separately,
+# with socat, when a test needs the ICMP error to be matched.
+
+# shellcheck disable=SC1091,SC2034,SC2154,SC2329
+source lib.sh
+
+require_command jq
+require_command mausezahn
+require_command socat
+
+ALL_TESTS="
+	pmtu_no_socket_ipv4
+	pmtu_no_socket_ipv6
+	pmtu_socket_ipv4
+	pmtu_socket_ipv6
+	pmtu_omit_ipv4
+	pmtu_omit_ipv6
+	redirect_no_socket_ipv4
+	redirect_no_socket_ipv6
+	redirect_socket_ipv4
+	redirect_socket_ipv6
+"
+
+# Shared segment.
+H1_ADDR4=192.0.2.1
+R1_ADDR4=192.0.2.2
+R2_ADDR4=192.0.2.3
+H1_ADDR6=2001:db8:1::1
+R1_ADDR6=2001:db8:1::2
+R2_ADDR6=2001:db8:1::3
+
+# r1 - r2 link.
+R2_R1_ADDR4=198.51.100.2
+R2_R1_ADDR6=2001:db8:2::2
+
+# r2 - h2 link.
+H2_ADDR4=203.0.113.2
+H2_NET4=203.0.113.0/24
+H2_ADDR6=2001:db8:3::2
+H2_NET6=2001:db8:3::/64
+
+SPORT=12345
+DPORT=54321
+
+# The MTU of the shared segment and of the r1 - r2 link. Large enough for the
+# injected packets to reach r2 intact.
+SEGMENT_MTU=2000
+# Size of the injected packets. The PMTU tests need a size that exceeds every
+# MTU used for the r2 - h2 link, so that r2 responds with an ICMP error. The
+# redirect tests need a size that does not, otherwise r2 would respond with an
+# ICMP error in addition to the redirect emitted by r1.
+PMTU_PACKET_SIZE=1800
+REDIRECT_PACKET_SIZE=100
+
+# The MTUs used for the r2 - h2 link. All of them must be at least
+# IPV6_MIN_MTU, otherwise IPv6 silently ignores the error instead of creating
+# an exception.
+MTU_MID=1400
+MTU_LOW=1300
+
+# Values for the IP{,V6}_MTU_DISCOVER socket option.
+PMTUDISC_DONT=0
+PMTUDISC_OMIT=5
+
+SOCAT_PID=
+
+linklocal_get()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip -n "$ns" -j -6 addr show dev "$dev" | \
+		jq -r '.[]["addr_info"][] | select(.scope == "link") | .local'
+}
+
+linklocal_exists()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	[ -n "$(linklocal_get "$ns" "$dev")" ]
+}
+
+family_vars_set()
+{
+	local family=$1; shift
+
+	FAMILY=$family
+
+	if [ "$family" -eq 4 ]; then
+		H1_ADDR=$H1_ADDR4
+		H2_ADDR=$H2_ADDR4
+		MZ_FAMILY_OPT=()
+		# Without the Don't Fragment bit set r2 fragments the packet
+		# instead of reporting the MTU of the next hop.
+		MZ_IP_OPTS="df,"
+		SOCAT_DST="UDP4-CONNECT:$H2_ADDR4:$DPORT"
+		SOCAT_BIND="bind=$H1_ADDR4:$SPORT"
+		SOCAT_PMTUDISC="ip-mtu-discover"
+	else
+		H1_ADDR=$H1_ADDR6
+		H2_ADDR=$H2_ADDR6
+		MZ_FAMILY_OPT=(-6)
+		MZ_IP_OPTS=
+		SOCAT_DST="UDP6-CONNECT:[$H2_ADDR6]:$DPORT"
+		SOCAT_BIND="bind=[$H1_ADDR6]:$SPORT"
+		SOCAT_PMTUDISC="ipv6-mtu-discover"
+	fi
+}
+
+topology_setup()
+{
+	local ns
+
+	setup_ns h1 r1 r2 h2 sw
+	defer cleanup_all_ns
+
+	# Link-local addresses are generated from the MAC address and read
+	# back during setup, so request that generation mode explicitly and
+	# make the addresses available as soon as the devices are brought up.
+	for ns in "$h1" "$r1" "$r2" "$h2" "$sw"; do
+		ip netns exec "$ns" sysctl -qw \
+			net.ipv6.conf.default.addr_gen_mode=0 \
+			net.ipv6.conf.default.accept_dad=0 \
+			net.ipv6.conf.all.accept_dad=0
+	done
+
+	ip -n "$sw" link add name br0 type bridge
+	ip -n "$sw" link set dev br0 mtu "$SEGMENT_MTU" up
+
+	ip -n "$h1" link add name eth0 mtu "$SEGMENT_MTU" type veth \
+		peer name swp1 mtu "$SEGMENT_MTU" netns "$sw"
+	ip -n "$r1" link add name eth0 mtu "$SEGMENT_MTU" type veth \
+		peer name swp2 mtu "$SEGMENT_MTU" netns "$sw"
+	ip -n "$r2" link add name eth0 mtu "$SEGMENT_MTU" type veth \
+		peer name swp3 mtu "$SEGMENT_MTU" netns "$sw"
+	ip -n "$r1" link add name eth1 mtu "$SEGMENT_MTU" type veth \
+		peer name eth1 mtu "$SEGMENT_MTU" netns "$r2"
+	ip -n "$r2" link add name eth2 type veth peer name eth0 netns "$h2"
+
+	ip -n "$sw" link set dev swp1 master br0 up
+	ip -n "$sw" link set dev swp2 master br0 up
+	ip -n "$sw" link set dev swp3 master br0 up
+
+	ip -n "$h1" link set dev eth0 up
+	ip -n "$r1" link set dev eth0 up
+	ip -n "$r1" link set dev eth1 up
+	ip -n "$r2" link set dev eth0 up
+	ip -n "$r2" link set dev eth1 up
+	ip -n "$r2" link set dev eth2 up
+	ip -n "$h2" link set dev eth0 up
+
+	ip -n "$h1" address add "$H1_ADDR4/24" dev eth0
+	ip -n "$r1" address add "$R1_ADDR4/24" dev eth0
+	ip -n "$r2" address add "$R2_ADDR4/24" dev eth0
+	ip -n "$r1" address add 198.51.100.1/30 dev eth1
+	ip -n "$r2" address add "$R2_R1_ADDR4/30" dev eth1
+	ip -n "$r2" address add 203.0.113.1/24 dev eth2
+	ip -n "$h2" address add "$H2_ADDR4/24" dev eth0
+
+	ip -n "$h1" -6 address add "$H1_ADDR6/64" dev eth0 nodad
+	ip -n "$r1" -6 address add "$R1_ADDR6/64" dev eth0 nodad
+	ip -n "$r2" -6 address add "$R2_ADDR6/64" dev eth0 nodad
+	ip -n "$r1" -6 address add 2001:db8:2::1/64 dev eth1 nodad
+	ip -n "$r2" -6 address add "$R2_R1_ADDR6/64" dev eth1 nodad
+	ip -n "$r2" -6 address add 2001:db8:3::1/64 dev eth2 nodad
+	ip -n "$h2" -6 address add "$H2_ADDR6/64" dev eth0 nodad
+
+	ip netns exec "$r1" sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec "$r1" sysctl -qw net.ipv4.conf.all.send_redirects=1
+	ip netns exec "$r1" sysctl -qw net.ipv6.conf.all.forwarding=1
+	ip netns exec "$r2" sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec "$r2" sysctl -qw net.ipv6.conf.all.forwarding=1
+
+	ip netns exec "$h1" sysctl -qw net.ipv4.conf.all.accept_redirects=1
+	ip netns exec "$h1" sysctl -qw net.ipv4.conf.eth0.accept_redirects=1
+	ip netns exec "$h1" sysctl -qw net.ipv6.conf.all.accept_redirects=1
+	ip netns exec "$h1" sysctl -qw net.ipv6.conf.eth0.accept_redirects=1
+
+	slowwait 5 linklocal_exists "$r1" eth0
+	slowwait 5 linklocal_exists "$r2" eth0
+
+	R1_LLADDR=$(linklocal_get "$r1" eth0)
+	R2_LLADDR=$(linklocal_get "$r2" eth0)
+	R1_MAC=$(ip -n "$r1" -j link show dev eth0 | jq -r '.[]["address"]')
+	R2_MAC=$(ip -n "$r2" -j link show dev eth0 | jq -r '.[]["address"]')
+
+	ip -n "$h1" route add "$H2_NET4" via "$R1_ADDR4" dev eth0
+	ip -n "$h1" -6 route add "$H2_NET6" via "$R1_LLADDR" dev eth0
+	ip -n "$r1" route add "$H2_NET4" via "$R2_R1_ADDR4" dev eth1
+	ip -n "$r1" -6 route add "$H2_NET6" via "$R2_R1_ADDR6" dev eth1
+	ip -n "$h2" route add default via 203.0.113.1 dev eth0
+	ip -n "$h2" -6 route add default via 2001:db8:3::1 dev eth0
+
+	far_mtu_set "$MTU_MID"
+}
+
+# Make r1 forward towards h2's network over the segment it receives the packet
+# from, so that it emits a redirect towards h1.
+redirect_route_set()
+{
+	ip -n "$r1" route replace "$H2_NET4" via "$R2_ADDR4" dev eth0
+	ip -n "$r1" -6 route replace "$H2_NET6" via "$R2_LLADDR" dev eth0
+
+	# __ip_do_redirect() only creates an exception if the new gateway is
+	# already a valid neighbour. Otherwise it merely triggers address
+	# resolution. IPv6 resolves the target itself, in rt6_do_redirect().
+	ip -n "$h1" neigh replace "$R2_ADDR4" lladdr "$R2_MAC" dev eth0 \
+		nud permanent
+}
+
+far_mtu_set()
+{
+	local mtu=$1; shift
+
+	ip -n "$r2" link set dev eth2 mtu "$mtu"
+	ip -n "$h2" link set dev eth0 mtu "$mtu"
+}
+
+socket_is_open()
+{
+	ip netns exec "$h1" ss -uHn "sport = :$SPORT" | grep -q .
+}
+
+socket_start()
+{
+	# Disable PMTU discovery by default so that ICMP errors are not
+	# reported to the socket. Otherwise socat would exit when the first one
+	# arrives and later packets in the same test would not be matched to a
+	# socket. The exception is still created, as ip{,6}_sk_accept_pmtu()
+	# only rejects IP{,V6}_PMTUDISC_{INTERFACE,OMIT}.
+	local pmtudisc=${1:-$PMTUDISC_DONT}
+
+	# Send socat's diagnostics to /dev/null. It reports the ICMP errors
+	# that reach the socket, which is exactly what the tests provoke.
+	ip netns exec "$h1" socat -u -lf/dev/null \
+		"$SOCAT_DST,$SOCAT_BIND,$SOCAT_PMTUDISC=$pmtudisc" \
+		OPEN:/dev/null,wronly=1 &
+	SOCAT_PID=$!
+	defer socket_stop
+
+	slowwait 5 socket_is_open
+	check_err $? "socket did not open"
+}
+
+socket_stop()
+{
+	[ -z "$SOCAT_PID" ] && return 0
+
+	kill "$SOCAT_PID" &> /dev/null
+	wait "$SOCAT_PID" 2> /dev/null
+	SOCAT_PID=
+}
+
+# Inject a packet towards h2 with a packet socket. No socket is associated with
+# it, so an ICMP error quoting it is matched to a socket only if one was
+# created separately with the same source port.
+packet_send()
+{
+	local size=$1; shift
+
+	ip netns exec "$h1" mausezahn "${MZ_FAMILY_OPT[@]}" eth0 \
+		-a own -b "$R1_MAC" -A "$H1_ADDR" -B "$H2_ADDR" \
+		-t udp "${MZ_IP_OPTS}sp=$SPORT,dp=$DPORT" \
+		-p "$size" -c 1 -q
+}
+
+exception_show()
+{
+	if [ "$FAMILY" -eq 4 ]; then
+		# IPv4 exceptions without a bound route are not dumped, but
+		# "route get" reports the exception and binds a route to it.
+		ip -n "$h1" route get "$H2_ADDR"
+	else
+		# IPv6 does not report a cache indication in "route get"
+		# output, so dump the exceptions instead.
+		ip -n "$h1" -6 route show cache | grep -F "$H2_ADDR" || true
+	fi
+}
+
+exception_mtu_get()
+{
+	exception_show | grep -o "mtu [0-9]*" | cut -d ' ' -f 2
+}
+
+exception_gw_get()
+{
+	exception_show | grep -o "via [0-9a-f.:]*" | cut -d ' ' -f 2
+}
+
+exception_mtu_check()
+{
+	local expected=$1; shift
+
+	[ "$(exception_mtu_get)" = "$expected" ]
+}
+
+exception_pmtu_check()
+{
+	local mtu=$1; shift
+	local desc=$1; shift
+
+	busywait "$BUSYWAIT_TIMEOUT" exception_mtu_check "$mtu"
+	check_err $? "$desc: exception does not carry an MTU of $mtu"
+}
+
+pmtu_no_socket()
+{
+	local family=$1; shift
+
+	RET=0
+	family_vars_set "$family"
+	topology_setup
+
+	packet_send "$PMTU_PACKET_SIZE"
+	exception_pmtu_check "$MTU_MID" "No socket"
+
+	log_test "IPv$family: PMTU: exception without a matching socket"
+}
+
+pmtu_no_socket_ipv4()
+{
+	pmtu_no_socket 4
+}
+
+pmtu_no_socket_ipv6()
+{
+	pmtu_no_socket 6
+}
+
+pmtu_socket()
+{
+	local family=$1; shift
+
+	RET=0
+	family_vars_set "$family"
+	topology_setup
+	socket_start
+
+	packet_send "$PMTU_PACKET_SIZE"
+	exception_pmtu_check "$MTU_MID" "Matching socket"
+
+	# A lower PMTU replaces the one currently stored in the exception.
+	far_mtu_set "$MTU_LOW"
+	packet_send "$PMTU_PACKET_SIZE"
+	exception_pmtu_check "$MTU_LOW" "Lower PMTU"
+
+	# A higher PMTU is ignored, so the exception is left as it is.
+	far_mtu_set "$MTU_MID"
+	packet_send "$PMTU_PACKET_SIZE"
+	sleep 1
+	exception_mtu_check "$MTU_LOW"
+	check_err $? "Higher PMTU: exception does not carry an MTU of $MTU_LOW"
+
+	log_test "IPv$family: PMTU: exception with a matching socket"
+}
+
+pmtu_socket_ipv4()
+{
+	pmtu_socket 4
+}
+
+pmtu_socket_ipv6()
+{
+	pmtu_socket 6
+}
+
+pmtu_omit()
+{
+	local family=$1; shift
+
+	RET=0
+	family_vars_set "$family"
+	topology_setup
+	socket_start "$PMTUDISC_OMIT"
+
+	packet_send "$PMTU_PACKET_SIZE"
+	exception_pmtu_check "$MTU_MID" "PMTU discovery disabled"
+
+	log_test "IPv$family: PMTU: exception with a socket ignoring it"
+}
+
+pmtu_omit_ipv4()
+{
+	pmtu_omit 4
+}
+
+pmtu_omit_ipv6()
+{
+	pmtu_omit 6
+}
+
+exception_gw_check()
+{
+	local expected=$1; shift
+
+	[ "$(exception_gw_get)" = "$expected" ]
+}
+
+redirect_gw_new()
+{
+	if [ "$FAMILY" -eq 4 ]; then
+		echo "$R2_ADDR4"
+	else
+		echo "$R2_LLADDR"
+	fi
+}
+
+redirect_no_socket()
+{
+	local family=$1; shift
+
+	RET=0
+	family_vars_set "$family"
+	topology_setup
+	redirect_route_set
+
+	packet_send "$REDIRECT_PACKET_SIZE"
+	busywait "$BUSYWAIT_TIMEOUT" exception_gw_check "$(redirect_gw_new)"
+	check_err $? "No socket: exception does not carry the new gateway"
+
+	log_test "IPv$family: Redirect: exception without a matching socket"
+}
+
+redirect_no_socket_ipv4()
+{
+	redirect_no_socket 4
+}
+
+redirect_no_socket_ipv6()
+{
+	redirect_no_socket 6
+}
+
+redirect_socket()
+{
+	local family=$1; shift
+
+	RET=0
+	family_vars_set "$family"
+	topology_setup
+	redirect_route_set
+	socket_start
+
+	packet_send "$REDIRECT_PACKET_SIZE"
+	busywait "$BUSYWAIT_TIMEOUT" exception_gw_check "$(redirect_gw_new)"
+	check_err $? "Matching socket: exception does not carry the new gateway"
+
+	log_test "IPv$family: Redirect: exception with a matching socket"
+}
+
+redirect_socket_ipv4()
+{
+	redirect_socket 4
+}
+
+redirect_socket_ipv6()
+{
+	redirect_socket 6
+}
+
+trap defer_scopes_cleanup EXIT
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.55.0

