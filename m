Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE13D668E
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945209; cv=fail; b=uY2J6DVTms+AibqsLc1zag5e474jr/bTcuMNOyGdvFtzwjzwphPkxzqi/lmSq4Ib9/OY67pc7f9yQofBTpJDgnYlqpbEfQoScPp8pXJip3fbH6/71jXNJx3mOlwmjcP7CibkCU8+vxBmzMInmyS69h4gyisQkMtV1PLi3X8Q4QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945209; c=relaxed/simple;
	bh=jMQJF/fL1bLY2KarlHKzp8nvt68ro1UMwIH7utlsqE8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mOAigUgOnETu+hWe+v3In7qQdwkHXwqQ6rB9nCevyJd4SFpvybUaMZS4fvoj6u254EQ36rW2xr30U+O2jbNcLUoKszd9gTomW9RGlpWZ4Hw7/BYRxhs8zxSUuWcpyU9X5ZKa/tOgy35qOyiEhMm3qUJv+Bk9coTYN19GEBFP5tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3uj5uCw; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3uj5uCw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjXCejCNiMmSSW5cWyDpvCGlFOQzCu5T856BP5cLXNdG7zS41XzOCg1tVh0hR4z0w9KCgdsdrWdvbzBG6BSkRjzpRcGRfu5rsjm91RsSPsQlFIMIYS/Zbp+z20HWKzrKCmCnXXsdKmBUHKNQsv+XYtOkbsuYkm6y3Wzeuwa4l9gHk8dTXfAC2Vb0eU/RZPET5bD48b3tg0JarNi2S+Q2n0bX63Csi62p3ZHl3n6bQK8H/327MpXKiLaSlGMdCP4FCI2jRraIm5mfu7IhxDXJfmCkSc8dMANcIPREEKeWw+AoG6kKOjv3CzB9wvcRh7o+RoHAAy7maXSIjCJ+9BMe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrN49U0EPb3brdmxil/mivz+uYkhGiOhzU1C9c6y0xQ=;
 b=BxGib632Yo13siALlqoSwQlUL2noq1jYRY9+lC95KtnpBv9mLRydbb/RPxKRRMV0KKL19lbCtdAZTsRth35p012Nug4G2DHE1X4pDOdGAFXy3xzsxZj0YQDf7+GYX7LMw6flSDtkqwPtQPCItdheT9jx6RkUkyhHncGJBPlbuNXcvNV2ibgpYsbl7sRejXJfoLuDAVrdH/th3b+9oFnPFY0VxIfP82gW9rBoLXjgQDEdsDCtkjNTiltdHrKdvxEw5I+JIn8aVd7bioRgAMZMhmljN96gZGfpxJkYbABFswxGx5+hwKi0NqoEA1v4m2vPQM5XK4SY2UHUIhrvDBV2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrN49U0EPb3brdmxil/mivz+uYkhGiOhzU1C9c6y0xQ=;
 b=L3uj5uCwkTM5lcyqDYU4EWXEs9A4ir0h7tFQYY0aRo0GQF4N2RXIQHm1qMAYI6FgFoIOC6PdK/L2ggavjFVwnuXeAJu4jGZOF5xwA6itsQ/NAnrSfurUMJJDtXmwHc06ZF2L6eSqoeWxJcfYMcSnPAAftgOPynkHe2ATEQDRC2/ykOApAQSBkM4+6fPyIDan7E8vcXgIIx0m8xdQLKbDp1mVQsuU/Azm8VXyfc1nFnV4z2gO15voHfAEH2wfyI+FkDY1uOMKEcin3Fuw5puOn7cYGDgVvEl8mia0NV/ywi5muix7jRXFPJDgeRG2vOtLuYKkaASCbWunLDGGpECrbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 19:26:38 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:26:36 +0000
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
Subject: [PATCH net v2 0/4] Mitigate a side channel in routing exception caches
Date: Fri, 28 Aug 2026 22:23:40 +0300
Message-ID: <20260828192344.2596928-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df1db51-6816-4112-c965-08df053a46e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	RFnnQimqjXpyh/ITgS+4CHElc+zt7xcrHXaHkPGH5NfsvLwXpG2voxmAOeFUHjD/ET3pb1IYRBU8gidpykMlLL0xzVcgO9vAX7MQN00m4dXHcrBMTKRBPQCu+d0/FVPiWgqXX27E1wnBmTeNLkfBPC/OFcJTk59mxMDGysoc6LvQLZ6nTdW2HtWoPF//ndBTwjuCAA3QPLGGoX9JTj0TMHBzaRXJ9ysT/iWlayYcr3zeodyfZM9unwW8CCdMYCnUS9GPH4huADJwmaMABN2PTMD4NktooBJZbJYUWBThTK+2ZSI3BdOkGDObVLlTE0+RP3FdT0CqRIUSGP5oRzOzHTONpNPIRmreLsIO0LkQ0mXSMhjU9H8UahyGccxRMjDSMhRdU7L+t84BQsAGFXKnP7GqGm/5xIzLP/pf/ePn4Yf6497ZGjnkgwk1pMSp2HyHHJPLG1CPV7v9Q3CT/5Rt5IwJ3maaNDeT84+Z01anYwRdpALvzetPgi3SS1Z1fgWsJSO9gKqXF2ApMCLf0m96CjNN8kba918E8q10Ad6QX6zeay5cqSL1mb2B8tNDGPwcVZh0C/fzn5jMLUW9b/+VDOAdJr/n3Xyb2KtmospEcsCnnf53lKEzYwv3DmcEZuo79p29LjQyDI3nqg7dvlbsci2eq5Q9msQQcQI+OfzpZo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2tqkgp2qftQnuoJzUYeS7pvg5wfRvto5MzMuMG6VmDOBOhBgZnkgbwOXUzDR?=
 =?us-ascii?Q?NQ6wsFQu9Xm0k1lhPveaUquAAcObzn59BFYdAqiVGencPJ2aRpGmyvrKDX0K?=
 =?us-ascii?Q?9eTQFpgNcAg/qM0bgjgQ9EL4L+p4ZiNWYERcjCFx3tQXJs4Tkxv1ocdybtpT?=
 =?us-ascii?Q?KYWLJMqoNc7V3wwbuxQZYHP4l4rmM3Egv5d4h/7SekDWQHjZ5Mobsiilu3AE?=
 =?us-ascii?Q?Ye0F+e2pUP28HWp2FsFZebTp/SQLIrCjhznYGRSfo4a5TcriJPkCI4HAcIAZ?=
 =?us-ascii?Q?7fEd/0tbyrt08Z1IaDhF1hFF9IFs6c8MxUa0ikEdreAIeIBjq4xANf3FBu9d?=
 =?us-ascii?Q?Bz2nEaifLWbpuDb+lrTNpRRXCNf35vrBjGveMaCCZAXl83EFlTvvtCidpHQY?=
 =?us-ascii?Q?g6GyXTUEo6RkJZakPPQQ+V4fq4qpFoAu5GDG5d7WuuQhR4Hlx40Mo0AK/4qO?=
 =?us-ascii?Q?Ec4hhITMqEJQZvJ8bU1ixf6wB7GEowdhEt/AJ0hNthcYP47F5GLQz10tnWMe?=
 =?us-ascii?Q?3XX/dll3yPvwGtITaU1Cl4mgyRNm9/aU4eAXvLeFEAO+m8FbTOx3xPV7Ky0X?=
 =?us-ascii?Q?2hbsqbTSDAAx70xj7Py2Y0+H5XJPP/PEX57TQ6TCcT/Lfl1NXtljI9saDUZs?=
 =?us-ascii?Q?72Ui8D7vHHQUatHxOOwpegViK6y1dzsqDYDvRnDUsguUPp/F2eCqsTAs0Iqn?=
 =?us-ascii?Q?612VXY86Q9Erz45FUVuWcfmrfCXBKJAh4i/sZ79ivjVZ9O++5XlJaqOGmOSt?=
 =?us-ascii?Q?sj+hfl1+1vgnLtBacIJrYU97/ldqFYH6fqj6ZuvZ/a821IaPJjv4X8wsJLU0?=
 =?us-ascii?Q?lET4sBeU/oiqmt7cxK30qH/WU3XxQLtoALeFa0JrDKHKkOMCUxTxJc3IdWDN?=
 =?us-ascii?Q?R/sW//Nt8zNE/+3B+/Q66SZ5lhYuPwbVZ9hvpRQDzuxlvLEM0qrcgBwBMWn7?=
 =?us-ascii?Q?OAKsWDb60FzWdIR2UDTOwxDILXmYtv2XNvm2g/yD6IPjUHtZmwU3bPvSMiqO?=
 =?us-ascii?Q?4Ujau9L8fUhxZyKKeeGbMSY/+ROeHgEH9S5cIG6XeHD5/GcgUeBVDj1rjZCH?=
 =?us-ascii?Q?GgDcMvvsjNGaijwrNHZUaEhJea0nL2kJ3zXcaxj9+qK3l4Uz3i5cHDFvmwsO?=
 =?us-ascii?Q?9/ktKGmbWkcGQ7oLMTIH2B8+6U52FFbB5ZiQtwvFZT7SnVR0sK0o+dNB35nu?=
 =?us-ascii?Q?yl2ZoxgHKj2o+maRfJTlsUQ6Es1bF6NHO+ueb9dUWc5F9k3KDZJDFGqGEa9U?=
 =?us-ascii?Q?bQxyyfwkZbF9wlgtRVM2rhOEN9ZzT/plsIq9Lw9ZmPRvPD7pKXQZshif9px/?=
 =?us-ascii?Q?4QglmIa96hxY4bGdCh60awo2PWXUk9OLgphEQcGS+OfBvlttDsQxNj6dKTYQ?=
 =?us-ascii?Q?v6dcWtxzZcM4ooHaJ4hs5dCMZzpSW6OdEVnVqTbJXH0MjVFEzwDJyanTHjFt?=
 =?us-ascii?Q?Pd4Mub1Tbuwnp3DTj6d6ZQE66pAZrbQpJaxQU2C61QKGa+rEPDGw+IQDjUdh?=
 =?us-ascii?Q?CZr/pfNZhlgVyr9HhEHN7R2I6Ypvy+X1eCQpRqsrX53TIUAzdCm1LWoBXLQK?=
 =?us-ascii?Q?lAziBl26sEvGEevWyChvf8VAXzbTmIh/ggHc/nMN162Z8/DL7g30V9BgL5C8?=
 =?us-ascii?Q?1KR87BS4o0x5y6dk4cFYZwIrOqoux96JXOoJRpAo3R9OkCNILVBwXXR3YV2n?=
 =?us-ascii?Q?XiSQFFYFmqTAa/2rrMAovBhgITywAuMv7Qei69IWKlnx6jzRTvhsP3CHgyz8?=
 =?us-ascii?Q?HD/205t3tQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df1db51-6816-4112-c965-08df053a46e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:26:36.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkaK/pNJHqT0qGGzrD+5hppjU/QaQJ6BHpyFvueiHW6qSg4HMxO3Igwyuso4fbKAJx9ug17IaUkzwVX2Y/3+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

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
exception, even before trying to find a matching socket. The exception
is created by the same helpers that are used when the quoted packet did
not originate from a socket, so that guesses (right or wrong) from an
off-path attacker always result in an exception being created or updated
in the cache that the attacker can observe.

Note that this mitigation does not make it easier for attackers to fill
these caches, since they can already create exceptions with little to no
validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

In the good case (matched socket) this comes at the cost of an extra
route lookup, as the exception is created before the one performed by
the socket path. When the two lookups resolve to different nexthops, an
exception is created in the cache of each.

Patch #1 fixes a pre-existing bug in the handling of ICMPv6 Redirect
Message packets. Discovered while writing the selftest.

Patch #2 creates an exception from the IPv4 UDP code even before socket
matching. Other socket types do not need this: raw sockets have no
ports, and for TCP the ICMP error is discarded unless the quoted
sequence number is in window.

Patch #3 does the same for IPv6.

Patch #4 adds a selftest.

v2:
- Patch #2: Create exceptions unconditionally.
- Patch #3: Same.
- Patch #4: Add error checking in topology_setup(). Check for the
  arrival of an ICMP error in pmtu_socket().

v1: https://lore.kernel.org/netdev/20260826143735.1819315-1-idosch@nvidia.com/

Ido Schimmel (4):
  ipv6: Fix redirect exception creation for UDP/RAW sockets
  ipv4: udp: Create exceptions before socket matching
  ipv6: udp: Create exceptions before socket matching
  selftests: net: Add exception cache tests

 net/ipv4/udp.c                                |  11 +
 net/ipv6/route.c                              |   2 +-
 net/ipv6/udp.c                                |  13 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/exception_cache.sh  | 521 ++++++++++++++++++
 5 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/exception_cache.sh

-- 
2.55.0

