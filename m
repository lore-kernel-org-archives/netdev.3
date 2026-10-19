Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2453D58E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418712; cv=fail; b=PQRIOemMRXDi7piBa4loRTtLUveqezDNK2ufvKFRqJdOh+1CcwVvS6oi1QHwErzQzPY9FFrSV1x2dt3l1jwcaCoKJ2Z0DZIj2Ty8t5HqV3PeefP04GtKuclm0rE3r1GoEIc9NK5UP7NfgfkCpv1HFrCwLiKRVEC4tQj2QIkE0h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418712; c=relaxed/simple;
	bh=HRrWS488VoJnAee+u2R7b1p291DDuQbTVXILMNFLh7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0kQsUKTbosMBMXoNMV0o7be48aKpbdlKiP/4zG2EZHAellC3zntbH19GNSJdGCMjVtz1WTheB2JHuputARz+2xRqg5Z9idGefWaHuiBeK/USZoESpKjlo7ETnxBWJzj1Bd+WXvugbHscAec+f0rTqAXXQ9a6npKYwubP9jAAtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esezNWY8; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esezNWY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq2OxkD15Hpp08pE1WRlg8vWZXxirVF/kBSXCZwwCqke0QODrth3e3Ajt8JarehDTJbW/zrevEU6JRjaQW8+kF0X1YHWtvS8LKckcWj+5jyX7VQLoqAbYxS4OAWALm19Yh5P4iojYIc4iCMHO361ZCC3VCWd5rzoSnydlO5+79XdD3K9DW3Ez03gHy8Fiw89f/OTIrHIbFe2GxRJ4JIDhnjXEm8hNaRRz0nMhoyQRLImGo1m5gFQAojvqSX7ag7Eslc8ufXi3qD6agFq4afdyYgYk2CoRwelyWnt8yWrsivoDOvCJvJXvk/jCLLuOOIUwBklent491eceEEMYs40Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3gao+WpCkVsy/QfAKkfdYcXNiPWqI9TfrMYHusM7aA=;
 b=rDKrHKTLpIjdDgfOz4n+iTT9o5sGyILNSxS4gdGhjydmAXlIs27Ua7akAu01qLabc8rIQvOTeqimLy6bUfp0dUwsGun8ClOBfajP/6mfJnDDPNGnr0YfcGb1jAvb9TOZ6N6GknxLek1tUCI69o3+0IlBKL1GciXRv4JSCZKhotWRY6GOMQ3uR6esK8a5QS00XkwN9SbEgcfzkp13y4Cl+ZlGwzfREL8h4refZYFEVtYyuq/4gxmJ258WPkJn7mcT0LmQSvcguFhSInHzZFzWMosrtYtuBPjnnHBU10r16wCUtXcFo+twkR6mzvrikbtEmu0HpMuuu7cSFO1oX6szRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3gao+WpCkVsy/QfAKkfdYcXNiPWqI9TfrMYHusM7aA=;
 b=esezNWY8BKOUr/4ERYcGgTW+ywev9TXpzR3IJaT935CRKi0UYY22SwlX8+p6VzTSqQ1jW7xnidiEN3UY8leEGCaen1NY8USGpILIaA0fOyU5WpfRKgBMGRW9HQuIAglyyKJyGSd1xb+2W2QKUVJNtJwxk7O+BWqzjc5CCveUcFz7UJV+VDNqn2Cg0rnKXij+LdDQwc5p2W23PL2xjs9fSY06yqasl2inbqFsIqNWTEezFJ9noysBWq3pxZv1x2gqnDOe5Wgtd1mtvQ4b61DKSGYfCNg0s6G20gCo0Rl6ZsE6AMyxXKyenrSCf0+zgr0jqV9KWTR+ED6NAFiEs5ViAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:05:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:05:04 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: netdevsim: Add FIB notification tests for nexthop objects
Date: Mon, 19 Oct 2026 17:03:37 +0300
Message-ID: <20261019140337.2886875-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019140337.2886875-1-idosch@nvidia.com>
References: <20261019140337.2886875-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ccbd18-f4b6-47da-2bf0-08df2de9f94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R7SguF3w9JzMFPieTSKlYH+4SQEsFi6q5yubitu1l20uB8Bw1hi7XKRBFYi7/AR75KN041UXzV+88JKoQBlYYEV2+rHrNSGHr92WydgDfKpikZWBGpOxSNn8vttuCFJi8raQldh3OpGeemehtVMVLh3FmRnx0Pt+q9qdSHhP6ky7HpdggN0JMOgEKIdHu+I4BzHQbwmt7iFthrMien76XWrXxuBzJjYJ6YJXAR//hoZnDi6FPnFsizV3RdHpumzCoJLEnvbNEsYsybDXJHrxG20oVadKtSNZ2qRZOp6EOa1kq4ouLGcnDTdcdykVgBTIjzSUL6ZEOaENaQaErwFJBEcvh/m5imam8FAUEB11SIzIraGLxKD1Mu2v24MRF3N1UDTco88ddt7zCoXbSENZRg7smYpjNtunjwDniP61GTd1bxN10geojbD6oVvPHluB8vAGurmnrdJ+gBT8/3UyvDdhp2t8HySJFbC6tiB/3cn0tMRN+6494VedgVZihGVKwPWQUk1TnB4iOICmaZ4Bvidwxd+7SCqU8LBrC/XU4r/G0iWE4cfbiN9u7gW/GEV98ctAMATFolnf2hY45A7IZaD5GMr/yHbrVOKpQJtzjd56Pky82mh540+9ZY7x4SoL3YSOQIKoUzZwjSJOrQqtBr1d6FqE3KB0XYRITuYhJ/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhI+SaqjYVpbqpc4Xfk5zRI6qsIN9+YIGPcudpj8Yq5GyhXIv5X5j1b+JJL8?=
 =?us-ascii?Q?f3DqIYzz/skqlRKtqt4YDnqam9VVVWy8HIvww4cveaKumgLChqzvP51mlZAD?=
 =?us-ascii?Q?BYJIrczqPlO7aLdhcjmyVB5L8hdU+mlT4YesOrXG5ac5NJz3FZv1Owm1oXip?=
 =?us-ascii?Q?zmjdTPuvZNEHTvEoaruvGl0ZtJiPkoc4EuAaKkZ93h9RY1dswIqtMt1yxbQk?=
 =?us-ascii?Q?UcKxRZrGgRVTcP2InOLI2Y1AjdaPHgIJ8Q57hH+JcrKlJpRTChgRM0XyEqVY?=
 =?us-ascii?Q?aRXyrwepMkHyAwsoDBjpPR5v8AUW/hZf+5Rv5C33ErpEbAxLYmXe94fOaUzT?=
 =?us-ascii?Q?m+58vJnRn8KfizO1kZ/MrVoA4noOyZye8y55MqHPrAb5+YiYWkY0VHTdWYhX?=
 =?us-ascii?Q?oAUKVddQi2qCNELxB6QtIYrctnU1ptp8HCP0+qTpx8WSkI5F0bnIMdC+NvIT?=
 =?us-ascii?Q?e98KCf0Gmv0bdj8iKpZNePfqWJUVMssC8wFu4ZVeZ4Scj1lJDY94hkN9BQ1i?=
 =?us-ascii?Q?SstJ1KqkisBGkuzCilSucg6WjdmySq8fx4elrx+fcFUowESl4fgAc5qShOfK?=
 =?us-ascii?Q?5rZFSL1V1yUfnU7xf3kIw4VuKNCd90ZAgprltdsBKGVbHo6t0nrDH9jPyav2?=
 =?us-ascii?Q?UZHLWnXUEmnjzqi2/cwr6GG6ohX95yX5Y0cEos7n6+kgz22ZZMyJ2vxcPHWe?=
 =?us-ascii?Q?y+xrsszP4sC7r3DsYPNxzPtfbNAXcxPCZWRqu2vZae5wcZP705eH/57wg3vA?=
 =?us-ascii?Q?odp2j+IAw78BJU6WN3juW28x3g5R9aRhxsxJFbsHI3s4y6LdbMwxu5Uwm0wm?=
 =?us-ascii?Q?MpR9pMeXIjSZbC6uwk3r2Q5M9/QDVEFjUl6sAATiT1aULaR4htFDTzSYCLEI?=
 =?us-ascii?Q?YpuK08tCMqkMSGq7mBKcIobNG+j6Ak4/5zRh5TY1A8LB2HlvOadtDREB82ev?=
 =?us-ascii?Q?UFWxdOYOoyCi9ViXU1dIZkD4qGzsB6AJM0opNWV3UExJDyexeczLI4M1aCO5?=
 =?us-ascii?Q?a106fEV1LuxyGdreg8DNYsC+MM/FXBL8TjZhnY3wxE+NbZu3uOJ/NucFB492?=
 =?us-ascii?Q?8SIQ/Pv8/mFkaFealbCphd4Nf8Phunm30KlTCaIgBvllip/0KwNf+eB33q90?=
 =?us-ascii?Q?Pe5Q9HcocH4ZBig1V9w6Bm7Ap0L4cExvvscX7um3LdhdyHNT+Q7zV08kPPpv?=
 =?us-ascii?Q?aH/xrU8MtFNU7jAcJurD2J1BCfPWNB1nvKR7+mVgZuFDLzO5iuC1Yk9gFRUt?=
 =?us-ascii?Q?vufcrLazSVTgjPPTD8GUlL/msN9NdaLcApQRC40ADvg5ftBx/a6mH3EIgW2J?=
 =?us-ascii?Q?rmHj+zo4exKxSj4eCr4d5MsmpE4x0+pqTGCkpqO2j2UFZUcBuWWGO+JFv9i1?=
 =?us-ascii?Q?rAAAJ4wAKLGoCaonviH8RUYo9QzSYXzq6sWDUk/2Z4mI66v28UcIoPsbleK/?=
 =?us-ascii?Q?S5tGqZRntsKBM0qnZ88UYQk6tFTXg4E7SBkG6HvkBADjoXmO4OxdDnzTkKT2?=
 =?us-ascii?Q?Z5KI2Co3LwsoYj1jSl12p9eTop/se4AK/p8shbmkDEV+z66Yzj66gV27Buva?=
 =?us-ascii?Q?9kV0k+KrwP0yY36REwcvgLNFhVwt/JVvlMi6/N1G7VyckAWo7Wzusb/GxsgC?=
 =?us-ascii?Q?XN8ENYAKPYg7erVgHoqNECRlQe9L/i9CqI9/nGqfmjn9+N6fCuDqBspMcOoK?=
 =?us-ascii?Q?F7RgibeuR6oSjI6u1UwqXPOesD9Dv9RiS6bhFOE14etl8No4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ccbd18-f4b6-47da-2bf0-08df2de9f94c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:05:04.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I31184AVr8+5dhUb9igt/NGff84BNN1HbYM/7KHc25LmQvoOnVBGu9mskBaW43Zu+0GUeJPY30EXZU+YLNkG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

Add IPv4 and IPv6 test cases that program a route that uses a nexthop
object and check that two notifications are emitted for it, with the
second one carrying the RTM_F_TRAP flag.

The new route_nexthop_check() helper follows the same pattern as the
existing route_{addition,deletion,replacement}_check() helpers.

Without "ipv6: Hold RCU when emitting route hardware flags
notification", the IPv6 test case passes, but triggers suspicious RCU
usage splats. The IPv4 test case is added for completeness.

Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/netdevsim/fib_notifications.sh        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
index 9896580c3d85..c49d6deb621a 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
@@ -8,10 +8,12 @@ ALL_TESTS="
 	ipv4_route_deletion_test
 	ipv4_route_replacement_test
 	ipv4_route_offload_failed_test
+	ipv4_route_nexthop_test
 	ipv6_route_addition_test
 	ipv6_route_deletion_test
 	ipv6_route_replacement_test
 	ipv6_route_offload_failed_test
+	ipv6_route_nexthop_test
 "
 
 NETDEVSIM_PATH=/sys/bus/netdevsim/
@@ -269,6 +271,50 @@ ipv4_route_offload_failed_test()
 	log_test "IPv4 route offload failed"
 }
 
+route_nexthop_check()
+{
+	local ip=$1; shift
+	local route=$1; shift
+	local nhid=$1; shift
+	local expected_num_notifications=$1; shift
+	local outfile
+
+	ip netns exec testns1 sysctl -qw net.$ip.fib_notify_on_flag_change=1
+
+	outfile=$(mktemp)
+
+	$IP monitor route &> $outfile &
+	sleep 1
+	$IP route add $route nhid $nhid
+	sleep 1
+	kill_process %%
+
+	route_notify_check $outfile $expected_num_notifications
+	rm -f $outfile
+
+	$IP route del $route nhid $nhid
+}
+
+ipv4_route_nexthop_test()
+{
+	RET=0
+
+	local ip="ipv4"
+	local route=192.0.2.0/24
+	local nhid=1
+
+	$IP -4 nexthop add id $nhid dev dummy1
+
+	# Make sure two notifications will be emitted for a programmed route
+	# that uses a nexthop object.
+	local expected_num_notifications=2
+	route_nexthop_check $ip $route $nhid $expected_num_notifications
+
+	$IP nexthop del id $nhid
+
+	log_test "IPv4 route with nexthop object"
+}
+
 ipv6_route_addition_test()
 {
 	RET=0
@@ -385,6 +431,26 @@ ipv6_route_offload_failed_test()
 	log_test "IPv6 route offload failed"
 }
 
+ipv6_route_nexthop_test()
+{
+	RET=0
+
+	local ip="ipv6"
+	local route=2001:db8:1::/64
+	local nhid=1
+
+	$IP -6 nexthop add id $nhid dev dummy1
+
+	# Make sure two notifications will be emitted for a programmed route
+	# that uses a nexthop object.
+	local expected_num_notifications=2
+	route_nexthop_check $ip $route $nhid $expected_num_notifications
+
+	$IP nexthop del id $nhid
+
+	log_test "IPv6 route with nexthop object"
+}
+
 setup_prepare()
 {
 	modprobe netdevsim &> /dev/null
-- 
2.56.0

