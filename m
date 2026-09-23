Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDB389106
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180335; cv=fail; b=lIakcSDYVA3UgtY9mHh4sSYA/lLEozTffedSiIqraPhpf066TbvgyxMLwcTMKPORE8JKYppRat/y5m9oSvJnQGd9kcZ8L2wE8Quu/ThXbkORI5OV6ozC9iyv9ceBQC/IhgMx9GwnktPzHjRz7faH8HL09yLt1QMLd//NoHfpKDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180335; c=relaxed/simple;
	bh=TnW30vGivL50fL4OYe1anaxTPyXqcpcFU35CXU70stg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXFVvJk6LpokQP11JrbheF+Z573pBw3l8xbZ907MR7pbISO8no56/+RzUT8a/6U2+QemA8936Ry78rae8qE2yIz3NugEu30oGkUpBWzXoo4geU3wJ8QbJwngXdPR1cM5SGsIE2jRxYjjTwgLj+U+ShJMRvP+lbOPmZiARtZerc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MnJUs76t; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MnJUs76t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO1Zeymk2t2jGelu7/lBP2cucEfVQOA+sm4xQT4sw78QTTe6OIq2hcCW8T+TioZQdZp/1KHL7bdXM5YSSNlk6iBvnnXMtYbF+fmH8274elWLxY5ASYOLqH0lqnT63xYP0GrRHKhXDkR39hXhz0sc0T8+/N+LG+tfu7BParjZIqgq8G0Am+Est2irs/AGY5n3ev8nmP30agdUSC7MDI7URwoAKC9jKWE6m/QXAATTXj2c4xMfsuN+jCsqj8YIXXo4uL7wlRLURd97/168++6n6uzwTgRtYJ6AuOeQQYC3w1/pHb+15apBqvz4shjjrnkDbH48ZuDGOHUk0zewMbJNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0z+GfU9IEpPO/QnvYAyfE7lrrJpn2T1Fjas4XuCZQk=;
 b=qgQVK/P5b2nzZGMLh5BQqRivdmqhXloKMDIeOD5XErZBNQL/6bWqCALJstODMUmhDSIqIbccrI481FppJML0Xi5I+vYgVeTnITRdaegsnABLFHimCZ4boLggWDSQ9/iVBdrQ09WTnBJoe//fETTH2KJKWSTCTV7gez4tSXjx80MmITLiVJF1hgZz7QvnVCEu5DUI61PJlOSeHc0rz9mWge+XoHAXBEqfZcEHGhjMhb82q61O75grNrtMlGVpERKMRXwcFo5nhBKUJ7kEbwjaAB20ZChYYjWZmCdfZVv04u2RiObicB+c1i7TvleGNhd/X0ykTL4rfq9V+hOEors5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0z+GfU9IEpPO/QnvYAyfE7lrrJpn2T1Fjas4XuCZQk=;
 b=MnJUs76tC0E++Nea6hAq1SxseFs5FSiFaXePJQn3rrwVX+X587KgAsGMoyTDDmvWVQpLu5mcDDM0FZ+yBmUvW4dTf6eMwVltF0HuS5x14m2alNxWeSaZjIG/MEOKb6BD5NbwMxTY/oveCydXvf2OGrS9fR6kioAv3k8LKiQ6HzWE6gUS23FQRqJN063KYSxATIz1r/988mb/xKGsmQ0VoQZUiD7cQVISEL/qDrt7zsioFDeSCaFXIIfOHmcsHWzGcBc+lR2G8x0mlJ+p79n8AnYjrQz5P0UCsyDyWjZVOi2uk4S52HrLEhhptyIa6OdU2cTP/tU1oKomcph+SO01uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:18:46 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:18:46 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 3/3] ip: netns: add "ip netns cookie" command
Date: Wed, 23 Sep 2026 19:17:56 +0300
Message-ID: <20260923161756.2914560-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923161756.2914560-1-idosch@nvidia.com>
References: <20260923161756.2914560-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f6fd67-89e5-4cd4-9bd7-08df198e583e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tE5PxEIUU7rH6GRGu0O5seDZwusfXB8rHR65sRmu53YdHFcJ9HfK4KxC/KLyd4mZFxZVBPLDRfhXlvYfw3UZEmmpa+ZQaImPT9NCkmftot3WBbIiKZ1G+FtalIRaQhsHOiAGLkiBgs2lg2/9HJm8TXzxMcLOKZGsn00dOYUrLJ9A0egAGrhZ3komd2j2lFdyG1dvk+qiWQVO+sBfgdgL/atBosdxyudJTpKxwlZMBmRnKS40RqNXYrqKWHi9MXzHhZdm3qhxm3Qp6sFc/+EVRxRaypgK6og4uUt+TkgNA+6IHF9/cQmOc0F66z/G6CQHceaExdb3mt7rvnNL9hVIr0sUV/jh7de3teQlQJy6bAdvjIg7/OYJ9BQTCGIOXW0NM8XwCl99/kvkjyx/tJzGgZ855p+S+wQ8/UsC6h6JCl1i6sudmmwDPbRuY8QQlN0g9pgg7WYWgEV6laZgHWsLDn1DK1kHm4VqRfvoKr4v5TvM3CzmuampdvOSXqPt54udTkiAOfHl+HRY2TDiXm39qu4GN8DK8D53ssZBDZZweTetgDEy6C+0ng4+tyS6dlgeGISJGLA/8eJzqlUoDqk/WjLLy3WpyyGSVqkXqSCQH/pryuF6t84g5Pvdcc8b5nDildyG59Lo/rU6EQg5DpAM0dObiLjEeD0S/7vwEDXyjxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9G3fmwxokpUzpkHaFBZ8xajwV2mAQhEl6pQfhmgSeRf+I8Xvy36h/2jtB+v?=
 =?us-ascii?Q?V8hEl18Bk641MG1Ffx2txKoWrPqpStaBH3LPkrZy0WOcj5jwkm4x9oDZN8Dk?=
 =?us-ascii?Q?F3iBIz2sGaAyvxX9b0dh8jT9DGgnNvnm3NTPcXaNalcMkNfEnmnxRdRL7mBe?=
 =?us-ascii?Q?uQaKellux37jsxtuyEOUoqaOE4UEo8pp+MCabMFV+TF8HCID7vsMlNesN7ib?=
 =?us-ascii?Q?Jk2CKIIpEJJwpP9W/ySH48b+ICcfVBvcZynlqsE+7lk5GFhNKS2Q/Slr9Pee?=
 =?us-ascii?Q?96X3emVww5/qP6JSElCgzoln5C5VeEGPSRAeLaIPJBu9nhglFeaSHwD9OkcH?=
 =?us-ascii?Q?tpcLvlOSd5fTthjHRAqsypbnKswWJ3W0WG3IswPK1rrw7yuq1Hx9TyZklMo0?=
 =?us-ascii?Q?bBL+t6Qt8R02VujUQkeNlwE1Y3mQD+1Vj+ZQo9gL7zNAc1P1Fn5Z7VIoWdj7?=
 =?us-ascii?Q?4wgpzULbvWmZKoowyTY5wbiExwLDWZF1IqQx8AU5m0K7tlwo9K//BKtVDc4I?=
 =?us-ascii?Q?rqX7ti4G2I9oA//bkfC1G/v/fseP7mI3bKykIitGAPgyFrWhKBJofHhhl1CY?=
 =?us-ascii?Q?jIR+lAhrjaA/VLRgHw+dnYhaZyBy2UPPa9Z0hX78DGySgz4UOhZCnOIih/fk?=
 =?us-ascii?Q?Tvh/XGIfuMTc2AWjDnMxDP1JcXgpJ0jQBo8Kuefh/1/lzIIr13hVO6B9W+3R?=
 =?us-ascii?Q?Chui8qT4d4ghhOUH1pmSX2LIVnHbpW6HCP7zPbWShxX8bV6EVTNRU0KILVi1?=
 =?us-ascii?Q?85Hiv0tO6aiC1pNgMqRZFAToyPiM9oTenxvi45ARtz/31qo92bNR8AOuolxA?=
 =?us-ascii?Q?6KKXRAU3DTw5rqeqSJOgOMfvp5iwJzauXFvjnV5Q7cVXmHETJFfHjZHI9T0J?=
 =?us-ascii?Q?B0PHgeZOeA3BtCfydWOOYCE8mCuzKZWZ6ElFArVwc6LEqIuQeXicuTE07Wmz?=
 =?us-ascii?Q?xI3nex6EtBFLFmw3554G48EHB0i/vRZzOaubIiROAbUGqPcWtOCKbR0WTQYt?=
 =?us-ascii?Q?4qrRYO/bQSr6DsMl8Lx3WJyisCBBkRHryxzRe0iMH85jdOaJjcdnIAgHQhzl?=
 =?us-ascii?Q?gg92AoloW5VPhE7vJ+oWzTWQX/977vLfXQy4ZUXuJjhHEdjryO1DVUHiuoxI?=
 =?us-ascii?Q?NaarGZrELdz+p4vY62DxZJvq4CZ3I2BVa94p7V45JgZBmWpbruxDH0L15tWa?=
 =?us-ascii?Q?DHbx1eNns9RLYbGBzEhCzVTysyW3idV2RR2fa9z2z/y7rRb3tcJsPbo+Tj3O?=
 =?us-ascii?Q?/Oai0nUmVep1HN3iCcGVHPOpmX7FwYqcUfy2yKgZtrPOHcG5U1mvoDiDPNVG?=
 =?us-ascii?Q?aNwvBrOCy+CPCEmp+OMJ4HgJ/3YHJ5j8+gYiVUfTDuC4EaV7TrnmBDO5yT6Q?=
 =?us-ascii?Q?2iFipZmXwpbKyoaW/63Bzx5O1e253fo+JSEuh02sksSPvAMdyVKeNCvTIhKD?=
 =?us-ascii?Q?idB7QEcp7u8M5XFuU9t+uqh+ejQll/0CfXofeBBYLTyNXurMwdQ4p4U1rhya?=
 =?us-ascii?Q?jPge7RD3EaGwhxilxo+7KVVLLP33LSzZjvRW9A3ydrKEDiykIBFlUMnzEcOX?=
 =?us-ascii?Q?4eccA4X3+khQR7lxF2+vgrellESpvTbAYb9MoVwncPKZp9hzSfodJDt401nr?=
 =?us-ascii?Q?URH4KN6u2cornBwGEQx4/orV+hmW0jvMImGBMUhrF4WgZ4voEd0pYueAD6Jg?=
 =?us-ascii?Q?zvNVtYpl13wjfm9P7MJXE6hJTwSiX2C/WN66xyRYLfW9Mnb6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f6fd67-89e5-4cd4-9bd7-08df198e583e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:18:46.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bke5C/+EdUr6KoqLILdWW6W7o+ZB9aLdIwxbA3sUyM22g4VoxIydoTH+njMLjrhdhJ8kKYPMz+W1AHfuA/YfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

"ip netns list" only reports named network namespaces, i.e., those that
are bind mounted under /var/run/netns. Network namespaces created by
container runtimes are usually not named, but there is still a need to
retrieve their cookie, for example, in order to correlate the records
in a trace to a container.

Add a command that reports the cookie of a single network namespace,
referenced either by name or by the PID of a process running in it. If
neither is specified, the cookie of the current network namespace is
reported:

 # ip netns add red
 # ip netns cookie red
 11
 # ip -j netns cookie red
 [{"cookie":11}]
 # ip netns exec red ip netns cookie
 11
 # ip netns cookie $$
 7
 # ip netns cookie
 7

An error is returned when the kernel does not support the NS_GET_ID
ioctl:

 # uname -r
 6.12.109-virtme-g39a867754a8a
 # ip netns add red
 # ip netns cookie red
 Cannot get cookie of network namespace "red": Inappropriate ioctl for device

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/ipnetns.c           | 46 ++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-netns.8.in | 16 +++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index b62d2b0f57bf..165317b14c1c 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -36,6 +36,7 @@ static int usage(void)
 		"	ip [-all] netns delete [NAME]\n"
 		"	ip netns identify [PID]\n"
 		"	ip netns pids NAME\n"
+		"	ip netns cookie [NAME | PID]\n"
 		"	ip [-all] netns exec [NAME] cmd ...\n"
 		"	ip netns monitor\n"
 		"	ip netns list-id [target-nsid POSITIVE-INT] [nsid POSITIVE-INT]\n"
@@ -710,6 +711,48 @@ static int netns_identify(int argc, char **argv)
 	return rc;
 }
 
+static int netns_cookie(int argc, char **argv)
+{
+	const char *str;
+	__u64 cookie;
+	int fd;
+
+	if (argc > 1) {
+		fprintf(stderr, "extra arguments specified\n");
+		return -1;
+	}
+
+	if (argc == 1) {
+		str = argv[0];
+		fd = netns_get_fd(str);
+	} else {
+		str = "/proc/self/ns/net";
+		fd = open(str, O_RDONLY);
+	}
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open network namespace \"%s\": %s\n",
+			str, strerror(errno));
+		return -1;
+	}
+
+	if (ioctl(fd, NS_GET_ID, &cookie) < 0) {
+		fprintf(stderr,
+			"Cannot get cookie of network namespace \"%s\": %s\n",
+			str, strerror(errno));
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	new_json_obj(json);
+	open_json_object(NULL);
+	print_u64(PRINT_ANY, "cookie", "%llu\n", cookie);
+	close_json_object();
+	delete_json_obj();
+
+	return 0;
+}
+
 static int on_netns_del(char *nsname, void *arg)
 {
 	char netns_path[PATH_MAX];
@@ -1055,6 +1098,9 @@ int do_netns(int argc, char **argv)
 	if (matches(*argv, "pids") == 0)
 		return netns_pids(argc-1, argv+1);
 
+	if (strcmp(*argv, "cookie") == 0)
+		return netns_cookie(argc-1, argv+1);
+
 	if (matches(*argv, "exec") == 0)
 		return netns_exec(argc-1, argv+1);
 
diff --git a/man/man8/ip-netns.8.in b/man/man8/ip-netns.8.in
index 597a2602b32c..9b3ad14de677 100644
--- a/man/man8/ip-netns.8.in
+++ b/man/man8/ip-netns.8.in
@@ -42,6 +42,10 @@ ip-netns \- process network namespace management
 .BR "ip netns pids"
 .I NETNSNAME
 
+.ti -8
+.BR "ip netns cookie"
+.RI "[ " NETNSNAME " | " PID " ]"
+
 .ti -8
 .BR "ip [-all] netns exec "
 .RI "[ " NETNSNAME " ] " command ...
@@ -182,6 +186,18 @@ not specified then the current process will be used.
 This command walks through proc and finds all of the process who have
 the named network namespace as their primary network namespace.
 
+.TP
+.B ip netns cookie [ NETNSNAME | PID ] - Report the cookie of a network namespace
+.sp
+This command displays the cookie of the named network namespace or of
+the network namespace of the process PID. If neither is specified, the
+cookie of the current network namespace is displayed. See
+.B ip netns list
+for a description of the cookie. Unlike
+.BR "ip netns list" ,
+this command can also be used with network namespaces that are not
+named, such as those created by container runtimes.
+
 .TP
 .B ip [-all] netns exec [ NAME ] cmd ... - Run cmd in the named network namespace
 .sp
-- 
2.55.0

