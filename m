Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E04398EB
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755139; cv=fail; b=VNuY/UpBeXBfovkZ/s18307blkz9Wq+2b1Pxc1dB3gULU2FjwLZ3qj/CGzN6qtNmDDvlw9OPOfD0ihUF8m3E0t0KXrHSWq7Ni9NNop1f0EkK23lVpKHxJakbmX21x0Jk9JDVYDH6wP31XaGl1rvDx4gFRKcUW0BVjvl65aVSsvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755139; c=relaxed/simple;
	bh=kRtfp3scK7Kq0fssESP21guaBzyf0SCPxMPjfWOxgYI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NpCHnJvaXJZkYDAMFYXiNJLOMxRsXaD6jgV5cOnVNrEoxY1y942gBfUftKVjfZXV1s6XRyipKX1RT8U7ARMt1y920yTtYQqjIO344cPj8dQEx9e2hoZuH0Ot/JZQ/095A2Kp5jLc78RiLhsJzdCYRsBxNO2petSzO51KzgyOYJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLnw4uy4; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLnw4uy4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuHsB4/O/J5LaZvxhW5JKe3M+lflM9SSuZnMRozGkyPxVq5Q/xqptbQtU0qv5Ise+LkGhSHl+MBP8YEfrR+/KfgLBfmxy17LwEhonTNz3sxepWEo9HSzTyBJM23PjVSsG4NNaduqSNx0Q8rwt+J9MqWs7YjWJG21ebv1g1zt37AFkC9iKFhfqf8y/NRdcN+Cp6QPZ0a6vFRJgF6lcZqN8rUssySSxnNuuVeoZ8Wicb4y3jJi6bbO4sVvNCtvRDyMVqvl70e+o2rsx5QyDPBWAum6aKcOiPWtaSMvcbPd5bTaY+VQNR0rH6THMkUy8Dgo0eKnNVkacQgiIts+OxNmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSgrNABNc2q8SV8P+aURQ4iIOCDrEvpLjwX2mckq0O8=;
 b=H7KhKlHmamJYB/5Cr20Nw+Gr5YhC2pBv1/JpOcieKrVp8g1PlaJhzvk4kzMZXkw9EbiUpHKGEkTSCCTDVxnBfcXFfgtttR5YBpYvv3CeOwz0A+RzhjC352TcPy0eoS01OyS0HsP2nrH2zCM5vjuxQKbbaA2Wy+PR932nj814GVl7yxCYA7fJEWfHpx3t8EHMwe57zrYs/fcxRRBW5xQaiojhwYRkKn90G+8cxykwnPmZlXKrSGGemVj0Pu6kfxb7IRvfwtfs9Mmi/yMEtWJLjTgdXpcEmtAqoT9rWYCuN4G0dbDZGEF1oNrbEXI0qp0EjgiKFUn7FhQYNyz8oV9T2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSgrNABNc2q8SV8P+aURQ4iIOCDrEvpLjwX2mckq0O8=;
 b=YLnw4uy4lhL9QIx5vCh+uAM9k5DTDVPTlPvh9KiZF2sGS51gmeptnRSlnp+lH/XZe580ieOP02G6tUPG+6UHdqf0uR3mVvw3MOsCdu76AE1HMsGHY/u5jl9msuNeqmm7J+4zy9vXovrwlDKu4BkoRisV5GWzbSFHifHym0OamOVMA4r19Ok5mTZXNG76H9pQM5WPRUFFOcnRwyzvBztPXP+G1LjB7TSKzMWdvLHg5MrHcUgB61lthpin0RXc8Vvp7Csteyh/XByiNTzxHfDrOGZX8IHiGuCB7qLHm4Qy9ixcI91IsZyxc319tBfkVfXpOfrmwyiWFBjtSUsCvjA7Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 14:38:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:38:54 +0000
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
Subject: [PATCH net 0/4] Mitigate a side channel in routing exception caches
Date: Wed, 26 Aug 2026 17:37:31 +0300
Message-ID: <20260826143735.1819315-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 337d92d6-a8f1-460f-dc91-08df037fc08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NRtmsVdu2ci6fsZkT6ZpDuUgdv0XOgvDM7KZHkYUPEA9E3skq9gBobVXIMPJZdJJXr4i6klPhEJPjRoNyA0bWGhbt5UWd4j/4Z9Q5VjZeFwJ7S8rraziIyZguqhQ6tXcKOWyzpK8b2nw9Yo1RqWCKbsA0u5L+H7XAuPFLy44PmqZcrJe4SV93yDKYjkXB1EBNNdv6cWlxO9a0UTZGszIxoCvlZZqofi50S9NS4WfXdyv6NSxSrk54+MUuEwYkVahCfqfX6DVt+mf2OC0DkcU1pjUxYyx1WIa1aXx9NSjcI/v8iiAsouW4OPyr9Zi+snaidcQwc6nbz3Xx9VmKto5yydGXEPG0mNcLW3lOOE+yhpIzqUrqGLFv5kcxPn8+Zl0guFk9n6ozS0EY7J+1TEXkMEvovV0wGHSkpPdBD7tLvbYsxkYcfWJfRtNZBU3Rzby66ddWx1LCpVUHLElTFgvws8Lr1Xu8ETvAYU7rkfdhhfFklMBkhnMxwO6sE1VkcgZO2W/zmvWGaqEGFBDjDz0HfDaUfgONaowV2RpU7utcFD6h3KsagZ67RuTD4ly+IyFAi8ih6uJo1qv6w99ccYOxyEwTGYGTr0gK/eSune3/lfll4rUsYAlEvauUseguP0wTScqCgJTjr0kDYZcQui+IZ6qn+V2wc4CUz7aOMo8928=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvw5ZhmOtlndPVaoaV16paInU9/Zsr0pgISsR1YgSgKjjk19dPHlJ6Ugp0TG?=
 =?us-ascii?Q?oCQR6zq0HvPY5Yr/m8UyjY5YuyInzd8Hw00sDGfJce6vFTo7+17KsDb0cJGl?=
 =?us-ascii?Q?+DWNCVk1731AX2Eld8jS3BZ1Maf5vzt23ZCV+XARU3QriO8BoTLu76QWlFWJ?=
 =?us-ascii?Q?7a4ofW1oyVpdAJ4bEWcvBbyzJEWfVwzjNY5I0LQrNTyJDOQha1kmh26P+yUq?=
 =?us-ascii?Q?lCU5/wDHpcHyiF2ZgQgGEUtQkky4HFIHRJJi/EbCp6PfdRazKT0J7ow4mxgB?=
 =?us-ascii?Q?wf6mXpWrXTmnrev80vmpXfoPI+KqS5EUxX/eWycEaU5kFxiwSawWO3leZFh3?=
 =?us-ascii?Q?096zsSoWDhHYblszMzP8bBq7CCjU3K+e/L55YCcl/ckoW1Ac+UadcAbvTljG?=
 =?us-ascii?Q?ev8xXQPuQRbV0C1eIACCRDufdofjAxBWarQe5vNe271Osqlu/RiDV0xnQ8G2?=
 =?us-ascii?Q?BcwNe765r4IobLAWZBkuk7OhFc8KjBEJarSBhMVFU0eDosqcFY+F3mp8Wdwi?=
 =?us-ascii?Q?2CpuqUnk4H62PRDopamhA95hiIg0UWwIB9ALvBudaP6n6FRzZTcc9GU5fUwv?=
 =?us-ascii?Q?sYGcVftlpB2AJPmPEoom1ckNSajUxkZFpJgn4EKV0kuvQBls9VC4SB8D23t3?=
 =?us-ascii?Q?4EUA+fnWMr4GsyAq83swnIk6KY4ibb5cUB5ruBi+mbZXYA+Z6wA/kjQcUad4?=
 =?us-ascii?Q?dzaulDy+i+6EjdLh/WLMfpySzJHlImxQl/euhgArLF0K8GO+yqiwx2kRk7Gn?=
 =?us-ascii?Q?h9g4fNL87H9LQsDGwizcMq75z6bpV8He8rNI9DvLVZ+w9UkAXp6xAouFXmDM?=
 =?us-ascii?Q?f8pQlG9TIkAcdeUyQeySfXC1g1DthIIFQ9ZjAuZ1KRdDMGCvEvNX8ho6m2yq?=
 =?us-ascii?Q?ZdRF7TDg+yS7dmP6R9NkyZA+04FmHGhQaEEWTQJuPiwwClfELQPiT/1jQkuK?=
 =?us-ascii?Q?mxENAS2SB2eTK/NHKbZ3o4ABI4yRpGo2L524CtsyRvJlYNqHHB5ECP7ItTsU?=
 =?us-ascii?Q?CvlCcU8LHcwhsPlI2o9RIN01eZoJUO8YtLrTMfmNni0SmsIWUpnZr+Ik/+F6?=
 =?us-ascii?Q?DbCAxv6hhW7YSIOKS5AQST7Dw0ryUt71tOLdJ+2Afg233E/ncb92OrqZun3M?=
 =?us-ascii?Q?lD0HlUHy+NXhefKQebh9L1+5u7LM6znaEXMgOmXFENdFob8Bidi5eN1TN1ww?=
 =?us-ascii?Q?j09iEagNZEsrFod50DcHAtoN0diqqYXxPSVYyYEsxKdcz0o+rrs9gDaU3L4y?=
 =?us-ascii?Q?XHCmyTw3Cy070diy2DfUxcb+kSs7HlXx0DPQU1fyC0vevDucEkE5V2h03+VU?=
 =?us-ascii?Q?ux8p8kpDRmr+VZb0HJXq7RqNJLwzkvF7PVHWX2UYkj8UBRmJKWQaMXoTpFky?=
 =?us-ascii?Q?YK4s8G5V3+maldg95IqBL01o4q5Ie44rmFLZylT4hPOt037B8re04HUKeQCG?=
 =?us-ascii?Q?KHcGOwYsvi5SE4P7nMQ2uXXPPdloWkAk24ZNVwu8C4oMTxb74qMgNNmu9EVV?=
 =?us-ascii?Q?V+W1m+khU4/AGsDClj0hLyF3guUVSCE3XPaRVN/V+S3QWCxRDr4Vg4o8daB4?=
 =?us-ascii?Q?p2a/JIlN94eeeyqM33/yPTrglE9NJMw0jbMBSlV+kd8jtQ79c3GGKdurEcL/?=
 =?us-ascii?Q?SC2qid3X028I2i2x5Rmmtq2F1Db+RtEVtsK+iIaPRl0klGF4+LZpNZjGdxfv?=
 =?us-ascii?Q?bzPGRxBbI1X+xN3eMMAhcwXHc/S9lJlccwVoo8GIodsF8vsnK0KC06Xi3pKY?=
 =?us-ascii?Q?U/9zoEfU7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d92d6-a8f1-460f-dc91-08df037fc08e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:38:54.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR+ODRLCuoyw8xkqTThaiB6A2Lceg8C0FUIHMDkKDrmPi3BjDjX2rTwCDeHgGtc96gbgIQhYXG+4/Qmi7Z4kiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809

When an ICMP error that quotes a UDP packet is locally delivered, the
kernel only creates a routing exception if the quoted packet matches a
socket. This allows an off-path attacker to conduct a side-channel
attack on the routing exception caches in order to discover the
ephemeral ports used by connected UDP sockets.

Previous mitigations tried to make it harder for attackers to find hash
collisions in these caches and make the eviction of exceptions less
predictable. Amit Klein and Noam Caspi demonstrated that both of these
mitigations can be bypassed.

This patchset tries to mitigate such attacks by always creating an
exception, even if UDP socket matching failed. The exception is created
by the same helpers that are used when the quoted packet did not
originate from a socket, so that neither the occupancy of the cache nor
the contents of the exception are indicative of the success or failure
of UDP socket matching.

Note that this mitigation does not make it easier for attackers to fill
these caches, since they can already create exceptions with little to no
validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

Patch #1 fixes a pre-existing bug in the handling of ICMPv6 Redirect
Message packets. Discovered while writing the selftest.

Patch #2 creates an exception from the IPv4 UDP code when socket
matching failed. Other socket types do not need this: raw sockets have
no ports, and for TCP the ICMP error is discarded unless the quoted
sequence number is in window.

Patch #3 does the same for IPv6.

Patch #4 adds a selftest.

Ido Schimmel (4):
  ipv6: Fix redirect exception creation for UDP/RAW sockets
  ipv4: udp: Create exceptions when socket matching failed
  ipv6: udp: Create exceptions when socket matching failed
  selftests: net: Add exception cache tests

 net/ipv4/route.c                              |   8 +-
 net/ipv4/udp.c                                |  10 +
 net/ipv6/route.c                              |   2 +-
 net/ipv6/udp.c                                |  17 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/exception_cache.sh  | 501 ++++++++++++++++++
 6 files changed, 534 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/exception_cache.sh

-- 
2.55.0

