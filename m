Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9953D9CC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180320; cv=fail; b=tgurmy5WKU43Wqfa5gqItiELXAZdZpm2Ergbc3D+Jw4LxX8Jwl9uJVPguI3MyCfz7TzMP9oWiY6uxwwZsXLwZaXbASZ8a1ZQpTy2FmtxAl+JdcIhfz3AS5d0MSUPS8FTP4LmozDpMyd+O68S5h0bdBgU/gqA0bjaD+1WafjBDdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180320; c=relaxed/simple;
	bh=R3QBLMaypXPr1QZYQdcsQWz+AiTiK0xd8vAhDcShJ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlPOjwPXnQeE4fqnMCJp+zyoDbTL4nITO4eVGKrWcYepIy9OvEOWT7TWCGBV0IqpWbfxm0RuD/LjzIDIVwT652Z8A5X9fq341VetUBSB5DWrF5TzFYZZKb9gqwPe5BFuGg3rwhlx3MK0wik5o1ydxLGnjj1kE6/P/7UT6g+qyOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rC6qjEGo; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rC6qjEGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCIL8pDJ1SIUefG002gmlS/6YdWjmKlCZbYY1warfyQmJTfLbwi0+yf3sW5uUmwOmRSHH4YV5NO4Ko3k0t2r980WdIWWhXtptjDlHpSk1eFbrNQdwoxIyaOxM74WVd/YdwnT+yoopOUwFzx06ViEWT6RFqELS6u2RX9PNuSWJ6W4UUzfvAJitUadjGCu6I8ZEDL4TvxdfGnTji88+INsOw0uUFP9xPvqI8qMhuTjvo8n+cGFgj7k5ktze8qOS8A91LBMmnIwLpnCklovbUgK+9KFzKwJfNr1CAp4zaJPEjCUFzMLHHpoWQqQBzLioVuaDfIyYCNg6i2aX5ItHX+Ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljqf5UvZvt2vRcW6bpB9G9u3mMdN+wRCb9NOrIt2p4w=;
 b=hfLiCSZapHChzLsgmR/AMapAfluPsydj7KDfM+656M8upcUhsFEjGx6y3PoTJgjxUbGFnx3vh39EXZvdg41i7B2Ko7HgUiqP3P2qvD5suhIwn3hBW9SglsN0BH6BfUllVNtlwSORN7npGI/fUmSg6f174cB+lIU07SPw6HZy4STzetXnqSMB7pKSlNAafpXd70b2IjRw6rWWGF+wF9XT1Q8rWai1IMmwOydOlkg8Pb39b1FvL8XbvG/vyiUutkRpFXjStY0HWUR+zjXwpotDD357dGEjc2ozTHj5Y94P28bfjjlcl4SsOxuSe7CvK7vtgqKuHdt6QOAlYqrtYTcQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljqf5UvZvt2vRcW6bpB9G9u3mMdN+wRCb9NOrIt2p4w=;
 b=rC6qjEGoTeVs3QScd2CjqxNfZ+tdjipeq0v9UY1Enhr02AaWbI64Rs9fCTv+1kx65aEkJEg14Immokma6+ugplN50qExGTEhD6zgbqkOhnMuC2Vp+0XoaC/rK1mE6s61AukLB/p/d7U67Hy+UkwV9PpI0jJnZ9WCXq8vtaPxw3ARiNH5D6AOuSs34MZx8O/DW39z+6tNSDR+QjK+atA+cIXjckTipmew1DfTLc1bs7QUk5VFzM9M7QOuJCYUDspJt/DvhcE7X2tCYGqvqT/7w7xOyszzpqq+ahutZfbF1En3Fpmc6iULVYurLgoizMVnl3SkM0uqtNc41imyeR3Ilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:18:36 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:18:36 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 2/3] ip: netns: report the network namespace cookie
Date: Wed, 23 Sep 2026 19:17:55 +0300
Message-ID: <20260923161756.2914560-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923161756.2914560-1-idosch@nvidia.com>
References: <20260923161756.2914560-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c09b6bb-2164-4d86-dc5b-08df198e521e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NsOKbjTKjTT1unIeDY4sfptKyhNWZJZfB6KDj3Wq3RZpvrfKzCofNMgpv5wF8+3nc/7JsaPKz47zB7DYlZK3VyCb6kq1OPQ43sWzS4acTCOM0p0sgWDfGNtGHVD6l56XpWrIXeYZagwZWG8Q30OGo8xPnKXx3+9fMjvHZlACCoOr71Zgh0HBi72qP6ia8Ul01YY768Qv4aUit3c+z+Ao2eZtp4b1l5ylPUfL14cUJLP3v9aEMsgD+7FwVN4rWWs0EwNjUHphPp0dhwu8sZgzhMT0UFYxlltEKkbdDeJHBgc6tSLdqrIcd+8+9t283Wf0FRdOmQP52EzUvLWE60vL7BgdReInsb4XP94F609rdHjbiWlMEbic5a00Gx6q45tLDp4KT0GtPpNWFrW3/RtoBV8tVDppoQZM61o+fgJ1uUiIukpGZsvytiZ8FGWDZAq+M/Z8BeiRmmwEwCg0jdVBdZ9vsGrNb2A63Ne/sDvH9FbIGZ50iHtpFZQDe1RqQr7psc4aWZ8dC5clJrT/qXl6oXZo8HhRpC3KQVfoItt2hapHlrsxMDFkMndiikQeADscYq3lqCZJWIz7fz9GPw9csFM7Io4KKS1ZdLlAxvvpNdu0dIWKICzcDRGn76Rx8MQz5glF7VylgCc2d/mFuAilGx9BeV6C8HQW/IgvWWuCarw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k45a4LZthhZJ13SRQdjjL/TrsAHa2oLRNlEpsSh3KX+Kr2LtsNqKOt1VR22Y?=
 =?us-ascii?Q?KY3frQQe7SwipYjQU8PVo14DGC99OrWZArX17BS1tE1Ozt6QVdanosM09Tk5?=
 =?us-ascii?Q?aPUBwKkwpRE0v2kvd1NmYtylb7D+ZP8XK9bFp6yU+rc35GzkNlho+I500ShO?=
 =?us-ascii?Q?7TMiFqz42H5ZsihcALyuLvtncY3aru9UaouJjqOjEo4lTLX3m4jQQApRiU7X?=
 =?us-ascii?Q?0u2wkn522rUaQeP+8oXG5U45xfEPQmfeCJHKV+0qEH3qnDYsZkHKaUNfy8PV?=
 =?us-ascii?Q?G5O948wBGbn+BswiHa4TmiZk9QE70tF4ot98ZYOd8xq6PwGxmSrCYKtYStSu?=
 =?us-ascii?Q?Xc7rYzWfOVTWHYXek/o58TzVuDNLYoYmsfUlMf8LlyQeC4gzLNccFjsLX96i?=
 =?us-ascii?Q?9s8MNKpXDzUn3uiHlZ4Uu+me+n2TxUFMKoBFLvl4DsJVGn1Edqv0ue4FRfAh?=
 =?us-ascii?Q?PYJc0nAhvSUW/IljCJLdAKCScM3YsExBlfnzEdytz4nR9LkCJiOonj0STGmd?=
 =?us-ascii?Q?IHtGcJEoxQgW99b2aEkgtzY4Fm++kF5M64LdQoWH25rkNkF6tYqbTzE1uiUE?=
 =?us-ascii?Q?fQjMLhz/R7iKsHkFW338Xq23NOkCT9dR9ojv78vwoCsVX/4CJVph7KCqmHBo?=
 =?us-ascii?Q?BRiceYaZpxtWXrlE8OcUysgwpE69tg9LmrUE27nG6y+4g8VExCLUq2LDThxD?=
 =?us-ascii?Q?/rUFH9r+rd+99FgMyHsRLLgMEY5fxkRhJCcGrWYEj+A+4xYDU8Mn0I1Za9C4?=
 =?us-ascii?Q?1g0XUj58j7b1ALIZWxnCUCAhjdGJpdl5d6U9xvOQ74gYfiLbZtZRU6bGFadg?=
 =?us-ascii?Q?Bk6p+H04rCfOUWOFFPRZuxCHbf6c7FFu7qy6pahdz6ZO3E2GTQo/FmYdxDYx?=
 =?us-ascii?Q?NzHJbPNbbhPLiVgdA2UiybVJ3z3Q4Z3xBRV5DmmuvSuz4JfwEleS+t+SSJ7s?=
 =?us-ascii?Q?uR7lAtcIG51GCyPT9UanyZfSBEdw4FkscYOmGNi/PkuEVzWZ4/L/p5cRYcnm?=
 =?us-ascii?Q?CK+NWQ4wBCnRXGbnQK41WIFowS8mY34RiXSUB0uguzZYXF0x3rD09s9y5mzx?=
 =?us-ascii?Q?E+4+pWz4W9OBOHcTkOqqJD4GqDjlQyvGayka83U1L0SIJIBx4i0Gxm6e9ptA?=
 =?us-ascii?Q?DGfp5fxkImc8t/6phbGSLCqFMKlWVjPUuddivsx+TXgWlEK6mxlKIqNKo/kJ?=
 =?us-ascii?Q?+88maYuo7ODTRcEJmwJZ0UtjYhLzrvU4NBICZqMQ7tvCl7pt+g7iDthbJwR3?=
 =?us-ascii?Q?wY0r3UkQ2c9hhImZ5drHq3IIwNScRfUYvq4cQlx+Xh7dbLbZiJYlFfXkIBz0?=
 =?us-ascii?Q?rXu8MWSI2ffRSyGn6450Q20eBzmOl1mDc51VV0jdQFfcMNjfN9N+Uhu5shmG?=
 =?us-ascii?Q?pWTMk0b3+L2t+MOh6fc4nwMaIyYFsWgCl4vq/8dxIuwjrahyM8/nKv1GK7Vp?=
 =?us-ascii?Q?MGvgFq9tSOUGhV8KHwAHCAoWL6SOOyCm3MyrGl244e7qmsSqz+8bUP2qWR0f?=
 =?us-ascii?Q?yWBqiuakpICsxiZz66/NufVeCxFhYfow/DFlfECoLfxtKEo8P7hWRMFxYc5W?=
 =?us-ascii?Q?FjuOtzzQB7MLVlq+sDHhtcvb5aTeIuNqELPEUCSi8OjAMRscGnwu5XpGgWy1?=
 =?us-ascii?Q?89gTvullGUNWzoocKCiMGgz6rbVaaADweTYDd5aj5zj7w1TxKsM0Q1kb2GYv?=
 =?us-ascii?Q?DStksHqRq3BJPsday1o3V8kHHsASVXKzq12oLtl/uyuxxA7B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c09b6bb-2164-4d86-dc5b-08df198e521e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:18:36.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9gPyG5sHLn5C9oJSysU+/a6zUmm5SVA2ha9X3yEuigQsnKDhvh6MmdIud+XWPcgsZRDo4wIx04RT2T2uuZaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

The kernel identifies a network namespace by a 64-bit cookie that is
assigned when the namespace is created and never changes. User space can
query the cookie using the SO_NETNS_COOKIE socket option and since Linux
6.18, the cookie is also the generic namespace ID and can be retrieved
via the NS_GET_ID ioctl on a network namespace file descriptor.

Report the cookie in "ip netns list". In JSON mode it is always
reported. In plain text mode it is only reported when details are
requested ("-d") to avoid breaking scripts that rely on the current
output format:

 # ip netns add red
 # ip netns add blue
 # ip netns list
 blue
 red
 # ip -d netns list
 blue (cookie: 12)
 red (cookie: 11)
 # ip -j netns list
 [{"name":"blue","cookie":12},{"name":"red","cookie":11}]

The cookie is not reported on kernels that do not support the NS_GET_ID
ioctl:

 # uname -r
 6.12.109-virtme-g39a867754a8a
 # ip netns add red
 # ip netns add blue
 # ip -d netns list
 blue
 red
 # ip -j netns list
 [{"name":"blue"},{"name":"red"}]

The new functionality can be used to filter networking events that occur
in a specific network namespace:

 # perf record -a -e net:net_dev_xmit --filter 'net_cookie == 12'

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/ipnetns.c           | 25 +++++++++++++++++++++++++
 man/man8/ip-netns.8.in | 14 +++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 587534ae016b..b62d2b0f57bf 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -16,8 +16,10 @@
 #include <sys/stat.h>
 #include <sys/inotify.h>
 #include <sys/mount.h>
+#include <sys/ioctl.h>
 
 #include <linux/net_namespace.h>
+#include <linux/nsfs.h>
 
 #include "utils.h"
 #include "list.h"
@@ -444,9 +446,26 @@ static int netns_list_id(int argc, char **argv)
 	return 0;
 }
 
+static int netns_get_cookie(const char *name, __u64 *cookie)
+{
+	char net_path[PATH_MAX];
+	int fd, ret;
+
+	snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, name);
+	fd = open(net_path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	ret = ioctl(fd, NS_GET_ID, cookie);
+	close(fd);
+
+	return ret;
+}
+
 static int netns_list(int argc, char **argv)
 {
 	struct dirent *entry;
+	__u64 cookie;
 	DIR *dir;
 	int id;
 
@@ -469,6 +488,12 @@ static int netns_list(int argc, char **argv)
 			if (id >= 0)
 				print_int(PRINT_ANY, "id", " (id: %d)", id);
 		}
+		if (netns_get_cookie(entry->d_name, &cookie) == 0) {
+			print_u64(PRINT_JSON, "cookie", NULL, cookie);
+			if (show_details)
+				print_u64(PRINT_FP, NULL, " (cookie: %llu)",
+					  cookie);
+		}
 		print_string(PRINT_FP, NULL, "\n", NULL);
 		close_json_object();
 	}
diff --git a/man/man8/ip-netns.8.in b/man/man8/ip-netns.8.in
index 2e12e28bbb2f..597a2602b32c 100644
--- a/man/man8/ip-netns.8.in
+++ b/man/man8/ip-netns.8.in
@@ -89,7 +89,19 @@ their traditional location in /etc.
 .TP
 .B ip netns list - show all of the named network namespaces
 .sp
-This command displays all of the network namespaces in @NETNS_RUN_DIR@
+This command displays all of the network namespaces in @NETNS_RUN_DIR@.
+If the
+.B -details
+option is specified, the cookie of each network namespace is also
+displayed. The cookie is a 64-bit identifier that the kernel assigns to
+a network namespace when it is created and that never changes. Unlike
+the nsid, it is not relative to a peer network namespace. It is the same
+value that is reported by the
+.B SO_NETNS_COOKIE
+socket option and by trace events that identify a network namespace.
+The cookie is only displayed on kernels that support the
+.B NS_GET_ID
+ioctl (Linux 6.18 and later).
 
 .TP
 .B ip netns add NAME - create a new named network namespace
-- 
2.55.0

