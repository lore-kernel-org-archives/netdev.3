Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F083AD530
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945250; cv=fail; b=OCWRwHseH3sy5vaNAOwAdm8zHeEmYGi1Wo0dvWV+9SfS7ujk0RDaa3Z9J9fdLyzVIZR4Bb/Vx0DTke0B3XeXRnktJl8cIG6YtQZyDDSUyYkhllReYiZ/88oQPLy5sOG/5SGmsOoFYgEvSxXhwImcwty2F7O5R4iR7h2Rnq8Hvrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945250; c=relaxed/simple;
	bh=706cmopSZKajXuBAlqFDQLwyHRupoK/Fweyze8RFlB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ec/cNNMkfci5EZFIvDPsXy5XmdjHCT+BUiY+5drSrrmxw2VwnDb0LCJ4DKPbU4CnHzJoEbrSWBRPkA8IrcIwsE+f0t1W8H9IKBW1lCbXcU5iRiFHSXUMKcJ5zLtlJtpZ5rBfF+1bbVElX1edN+Adee3cBsxXwbIOXcuyB9Zomrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ek9lYSk/; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ek9lYSk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdsxrtkX6OcNFyujJcd9Hi18ntEqHVhQm00tWnjgPNadMSUHXvLv2Z4Tyqi9tO9A+FA3jCg+GI+lYepH23dspEXqD5KSkq/qLZB04sT8ZKkf037I8MD/RZUxkCUlT0Yx3/3q2TAuK8pea37DncPwYllv1q1ijAzqzxrrUbYW78vMcs8RKpYBrEUV60RvAe8ZReRHM3UMPktY++Gb4jxXDFuPdnLGKWBKvumJyncoitdExFllSKs9ch64SKqThDf5PClo+2UCLCW1dwAgve9TulbR5OksUJ2JkW2d36GV4j9sEmrpo9DpBkqgP9pbygwCH9raLCwQhubyiKy4CtEp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yK8d38K9094fPulArdpwDfbvNm4BT2EzGYk1keqfSQ=;
 b=QepUKe2zgrR76boy3eBrjog1BDiKa4DK9/RAZkbyhuJfNWlHs8R3Mt1CWE6+pbeGCeWeRbf+oCIHS1OKGjoenq56ZTtrw0RZWacZBXO71Tr7Jq0++gaBTa8B2Np3uZ9XyZD8la3BNUx6AoTopDXv4Y32DpvbTiDbbgXgDbAOIATBOK8ogpPhXDQBoXVYMlEB5TKSQfhs6YscnUCy0GjcZBo90haJyWSudw7dlvKmkD0uwKq0r9pebp6C7na9NFCw5EZo6EGIODDnxB9738BjCx/pAIicA3gEBB71nS1k18sNyrtlovbxE5Td0fF7zKAjZ3/c0DSPXeiIzLNCSA5SFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yK8d38K9094fPulArdpwDfbvNm4BT2EzGYk1keqfSQ=;
 b=Ek9lYSk/aebbtojff/Tol0zmpJYcZlKxaqfAK12SJOUdYHWqSDT31ICStp9wUgWkVmeGXI03q6hSrGjyLkKrGH3hkpPXvjKHoidH2Zm1xJ8TCFxVadAKoKwYTYkl2JUScrQQqgWzIUfF8EsQ6Jwnyi3j7zwyOzYmNUmqT385Z1Z7GFI4ejHg5zuHGdAiNUBNPMeRIjaQRGeDuaq42rLVaz+44LBrN7KpIJDmhrrVvd7waJjjxOlTIoOTlWH6YS2IGTRyxJA1I1JEJo4FpD6UlRCWmMIcupZUg+MbqQA4HdBy7Zl2YN0ZYimi6oM5Tuatce/f8+a6ktU8PlqnvuMesQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 19:27:23 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:27:23 +0000
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
Subject: [PATCH net v2 4/4] selftests: net: Add exception cache tests
Date: Fri, 28 Aug 2026 22:23:44 +0300
Message-ID: <20260828192344.2596928-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828192344.2596928-1-idosch@nvidia.com>
References: <20260828192344.2596928-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ee87fb-4871-4661-74a0-08df053a6277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WvyuJMsnC9CrBnCooXsmtAJOtoCZ3G9gyBa4YeWRSExodxt6+7b5YJ3v3WLOdTcrx60hXTqjz8B9LwnTfgr6jVTS6ZqifD76jqSQ5bYuSnD9MgpDF+fgQCGW1GVZOKwR+RahAHW8gZkTX/WGMvpcrg5hqFCNoQ2r/PPvEpBhyJm76ov8QLPXaOehSmB9iFMYcwWedq3x4gMpzRFKaydrbEr1UeGUOLYXP9AkzMR5FVwc2gzbW/BKpTQoo3Ej8LIAW8Z2IE4CHdnYugDBeALWvyL088VvOEJ45ir6Guo0Btj5z/JzN+b8xcK4AfCVAc8NCD8W4LoTs4vxxQHv7PDof0l1RLgNqJAd4LSdHHTugPCqMGcSBXh+pUmNgI8XTbigmWvD1bwmxfal4loa7ShyPavmRZgSTFgMm5TZXDEmCKCAFTIMu7JnLFr+WclLLNPBMMEZYejVJn/jfEpvWnPTykOfSwe7dMxnh1w0wiawkt28xF0PpbaWzNeJGpmErIPINebw53DLIwpHjKhees4TJA/S56T9jDMxhLbBujDGX3OouySqPiVxolRuEWm9Ms+NFM+a/Ml4HDVOHWq4KdCvskAoZhxVrt1T8IGmI+ZqZE01pX6F7SbAXfTIQ74QwJoXM/MtLtP1q0jPA+tIPrJ5kYckc8ppnVmlXAzLq6Lg8CM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6ECZ5gIuN+LcnzAMj07TlN3BK+r32Zp4DahBlqt/IHpY/Iba4WrAmE6VZaO?=
 =?us-ascii?Q?9+7d3dbfSun39BaqdJgNbADnlAQAhyS+d7Y5rxZUZFvG7nxH9Yb33gkwKC9l?=
 =?us-ascii?Q?UiWfiaFRemEUwcYbMNTXOALCQrAm1FqRrmwDvR2+Xc4zJN+wCX2aHqCVhtCV?=
 =?us-ascii?Q?BvUNotR7VpiRVN8prkNKYo00D08vJDtTlajI2kewNzkNYx23ixQc7F0cyKKH?=
 =?us-ascii?Q?Xszo8VvcVIRl87U5oOfOTZ45QDmOmJmgC24W+RZ3Uhg4YqzFB6OQEsigbXnH?=
 =?us-ascii?Q?WYBEZ6lQ/tMxz7xdHRQmAxemIA/DUTxmtu9XOyl3i8LNonpHXkBwO/rWAPYl?=
 =?us-ascii?Q?Tdwh9c2y9m8xOK08dk3aWBQY5JWPnXkUIZfg1eBDYpyvamZaHa1ifw22dbSB?=
 =?us-ascii?Q?QbuzoauWHw/m6dxFHXKGcjsL3J77wOi7QPmoms7uir3it93YxGRrmo/PWbEf?=
 =?us-ascii?Q?XW+6+a5FELDe1A74iew8eMR4AASphrulNi/RtWM/FEU9fou4dJCnvik9svKP?=
 =?us-ascii?Q?dA33MZ9oX6FMcNV/L/BtxSpMqtosv627BR29krxpqjmJmIvm+uu/f2IEtv0x?=
 =?us-ascii?Q?Uuu2dSzggWh46laS8TNbSUSpAA4J4hpVstzb9+3aNzU+Iurhj8sN747jnAxk?=
 =?us-ascii?Q?C/uoGeRvtzibf5WrJmw1UBvqLZ8Zo/CF+CcSo7Ft+gjBssZ35WatT9Gaep7S?=
 =?us-ascii?Q?/avbSHOHP6QXbWcPEy5usqSFHWLpKBvviUlRIeCjQfyeNZ1k0DzbLL6/ON/x?=
 =?us-ascii?Q?QoVbiEM6ySaZGg5OKLs8wUff+ns8/wGU++t2/OKqVxSUFrTifmcM4TjTdHjG?=
 =?us-ascii?Q?eoBrs9AdLJmJ311zu3JXiGpcsYgSNvMV539FGnJi9UPNTD62ZGriPt0tPCLx?=
 =?us-ascii?Q?d6vIzAOxeKUby3QeK57yJ4owI05/rplOAQpMB56cNgmeRu2SO/LMKv3jFhYT?=
 =?us-ascii?Q?ZRiHBIo1RJ9fR90YwTec9HTw3jWAdOojlpHwYbiqL7ZPwOzaMm3skzoFLmT7?=
 =?us-ascii?Q?SkhNKoUQOzXBp1nH4Xezw/fZY1Z1CX5euO9y3nH2zGqQYhBA7IeD+1WShP/V?=
 =?us-ascii?Q?axIXkcTtzJPH+QLJJ21jX4ngmoEEJtIWweJJHUaITW4mP1ebM70B4YGfM5BE?=
 =?us-ascii?Q?QtJh0Jz514mExx5RFqqtZjMWNkuWkcDCnQhvJ+DjwKHhOTyLaCn1nuHhrJEZ?=
 =?us-ascii?Q?ulgylBMSsK2pSoi46c4KzFcA61S+R7FOaGPWf6/zp2pHEkrnXAu+i+qmKlKc?=
 =?us-ascii?Q?0d6A7toL/P0Zeqw3uSYeQjPoFuZ++uI9KtXIoIXcubPdOC4tG/m7h/FiNlP1?=
 =?us-ascii?Q?m8kXQqJNpprl2SLXOOydaiYXmbdMiEBsbD6Hks/BlG2ovIrwLg7s6g0i+0oo?=
 =?us-ascii?Q?Dd+M2img9jHJKBwB0/RDk6Wrr6+gEd4nN57ailu6kOyLlHdzeh/+cEKEsCBl?=
 =?us-ascii?Q?kauiO2HN19IGqN/uLcrV4Fggj/BXgoCI8RHTq4+ICEhRZM0fHuZBWhOXKq+D?=
 =?us-ascii?Q?avecz1i7Q8bfc9ZMoTSTFPGaJfSZbfKgdyegqHcMht7VU8Ge2gyLOfO2YuvR?=
 =?us-ascii?Q?Zeky5SMQp5uY3e88rhb5SRHdIcXmg+JRfIUSztADN60/6jszU8VIjqds2EjN?=
 =?us-ascii?Q?+DZ9o2cr1VcGPIWatx3UKr3CQXRtDFet2wRb+LxLnqCmfbLEamw+rD3Wm8nt?=
 =?us-ascii?Q?wasGdLcFO/KGb9LnaIm194qWF4rbJkT7lDEvoMEnpx2Y1AH7rNgKL8sWySD0?=
 =?us-ascii?Q?0I442/wCiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ee87fb-4871-4661-74a0-08df053a6277
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:27:22.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6y8NZ1dAHS8koat0iS9U8M17YqnvhaCh0CKa74fn/E82gkkTrlJuaw8PK5UYtT1HvrXlaPMowIrZWMdoJrsGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

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

Without "ipv4: udp: Create exceptions before socket matching" and "ipv6:
udp: Create exceptions before socket matching", the tests that do not
open a socket fail:

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
 .../testing/selftests/net/exception_cache.sh  | 521 ++++++++++++++++++
 2 files changed, 522 insertions(+)
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
index 000000000000..8d3eed5c532a
--- /dev/null
+++ b/tools/testing/selftests/net/exception_cache.sh
@@ -0,0 +1,521 @@
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
+require_command nstat
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
+	check_err $? "r1: link-local address was not generated"
+	slowwait 5 linklocal_exists "$r2" eth0
+	check_err $? "r2: link-local address was not generated"
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
+icmp_errors_get()
+{
+	local ctr=IcmpInDestUnreachs
+
+	[ "$FAMILY" -eq 6 ] && ctr=Icmp6InPktTooBigs
+
+	ip netns exec "$h1" nstat -asz "$ctr" | \
+		awk -v ctr="$ctr" '$1 == ctr { print $2 }'
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
+	local t0
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
+	# A higher PMTU is ignored, so the exception is left as it is. Wait
+	# for the error to be received, as otherwise the check below would
+	# pass even if it never was.
+	far_mtu_set "$MTU_MID"
+	t0=$(icmp_errors_get)
+	packet_send "$PMTU_PACKET_SIZE"
+	busywait "$BUSYWAIT_TIMEOUT" until_counter_is ">= $((t0 + 1))" \
+		icmp_errors_get > /dev/null
+	check_err $? "Higher PMTU: ICMP error was not received"
+
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
+	[ -n "$expected" ] && [ "$(exception_gw_get)" = "$expected" ]
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

