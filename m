Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8D5349A6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180313; cv=fail; b=EeXS+bVbyuJZmLBGQZtdeRmKZzmHRdbr4owHKdOmY9UUe4nbSFJbC3fF+ynAXhI5dEqZ3y76/+i0eL3ob14E7BqBDzB/xepdpY6TBKyu1uCXIRKT9qV9+Zd9pEK4Y82LNToEXggDPYPlnhi3YDg5voQRRmx5KbceLYbJO9INfUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180313; c=relaxed/simple;
	bh=GvV7yMH7CtabrnwufqiQqY/IGM3OvuldMb0oZ7QUojg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f99cxpCpHmnW6DDOu+bvKxH72bGU5vAZxrozxI5JQPqLta+dFd7hunj14PfhkFddsIUP98jmUnJuvsi0YXNOTWW3YzQuw4dJ2sAp/9JGVrxFUQrDIT4/vTYkN6++ltG7E0UvtmkzYnvwB69lfZ3eynGXWuO2VP4aiLTbomZnY8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAxcbNt8; arc=fail smtp.client-ip=40.107.208.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NAxcbNt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRF4iBdyJxuCW17RlTXKNMVv06ffYviQKUB/7MKS4aikl047AfWD/wtjQYpGkeeG6VKa+Gs+NeV+sVVB4cBV/wCMWBpJ6U0osjqCpdUFvw0xVmB3zaUd88SO4gDx4sMFPMq1P22r/cY4HwwdRqVbXS86Uw9FzLw4LXnT22NsluCH3jxOTYj+Vu5qJsaXujtIMHuUCvJwsKe7dLlzwQZZRaV/e9+CbM7+zMcfKWVhG97L4osBAaoWOvl199Vq3yd/k6Kay5/uxgCifDjKiHygQBKcs4mFX0yNASt1dfVvjzUyJNSKnuMJs50X2OlhjJ14SdvvaWJikxB8YuZq1mykcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrNhTPU5nwZ9lvtrRj/4A5x2HLLuphNGyqGlrYTTPQ=;
 b=ekmD8iWxdXICqUaThvJrDZU5/2XIHsvqiFTurhLrjo8+VAJwSSInbPPxd1JkBULueylWiEnBfUBWR8rx7WobI5CW+Xh7c5GutdhJJDrdAMz8pq9GqQytYq08pAPCBlFD4R+4KFTvXrsiYGOgRasWyQQWLp2J9cop8LaU+k5gETSS8HHOX0l5aepN9/rjWqe2mJUVSZpVaXynC81i6UXmZ4Tz7xE5jBK2zgNUwryTpA+GC8fI95ozgA9+qdfUxYQZ5+zBKru/ol7f08MI68GodNQtY2p67A8G5RJX4xHj+dalb2GOQCKLquwm3Srq1+6e0n089wPZbNQGo6HfsKF1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtrNhTPU5nwZ9lvtrRj/4A5x2HLLuphNGyqGlrYTTPQ=;
 b=NAxcbNt8w1BaEFtTvGeTZYXL9/PTNy1NOv7g9Gvj7mJmOswS7RiIHh8ZRE7zz/KB58oWBYAxoh0eBemD4Sslk6jOFnmbqOPaqVjIfDAr23sqmAHzEmAzy4Dm03P/dKNYotCRHwo6HsFlz3rBORvElWP8wBCAO3AYWo60Az3ipefDHIjc57oCIP6NzFVpUqGbRh18Vlnq36dGXUD0n1/+tQCwI4jutmmM0QKpZO3WQ39WQrKNiP4gHoXJVnToTcYAr2T2br3OfbQhYdk9qPPrrymcix7awQOgtyh4HNMHkA8Up1shVcVXjcpsk12qslpp5l6GI2g4uFIZozi+lbDTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:18:27 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:18:27 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 1/3] uapi: import nsfs.h from last sync point
Date: Wed, 23 Sep 2026 19:17:54 +0300
Message-ID: <20260923161756.2914560-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923161756.2914560-1-idosch@nvidia.com>
References: <20260923161756.2914560-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 496401c9-67f6-4df6-d57a-08df198e4c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	onSsOlOr4fA4n8AN4d/TwfNUbV423AnMKHxn59vfh6X5VT3I7LBAiCMcHGiQLJSF89Jl2aTCqcOt3znyxx4v2z1XuST4YFVD/pnSPvW9d360k4fuSltgSKzuJl+D1alIx4AeIfVDqb6O7PMdVh79rgNkLpnkIYwaDKVMDTqtS2iHjC9nJoeyunuT85Shy0bMIMjXUFKafUxO+69MVUjYM0LyGy2JJKLCHegikMq8U5c84/SOWYiP49TPFuv8e4oTvdhdged6VzygQacXTo6oE8HXQYavCCsdPH1gNMeJu4hhUS5GXY/EqlYbatrMsiYDew96HYOOZNUZBw1vttZwsSw/D3vANSaU7YkIZ8dGc6ji8ggDaz4eCxKOWQh4Jd0C0kc0s5hmVT5tqXt0YJIph4PoquO4aE3+FX2Ig8CQRTdGP41RNvn/B53fERNA5M7EhZKUGEuQNKsNY4DY21W2g6Q1KuvUIek83HvV9U9dugCT0GNnHpSLd+/9/EvrkbVWJzjMNxP6dvz5059Nf347v2tDpnZFh1ASo/5Ek5isXUp85iMs/yHL0thCrevVYXJzhyv9SibTn2d5BmyacMek29aEWfUb2ufDeQaND3Ifj8wfvadgjgndeG/6UXLAgpUzUr2HgtEbH2mV3MU3SVS5hvV7Pu1MUOksCCzIXEp5OjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yR7FB9L2VF7x2UXlTDWCCldmPgZoCYTTvkLzyRlYC9FKPITi1SGxmCmcb42s?=
 =?us-ascii?Q?mave+2/pl9tuhXIn6i+234VDzkbGWanf4rfnp9Dx1t5V9w+POghmnstU/DVs?=
 =?us-ascii?Q?IwHa1gtFA1AMDzVWvE8TMOJBDZzQ24mRDJqFIra+cyc7mIgGowVvulyiSPTK?=
 =?us-ascii?Q?WzJw1aaZXhM7+Dt1lGRWaGlHYMgg20h1SEWJ22C9gC6LXEj2qEkc1Rko9FyI?=
 =?us-ascii?Q?pLNrn7x1MoolR+3ob9umktmZmX3PSpw8fX61mbdYl+RO9K3lOeW5DoqQ5Y3O?=
 =?us-ascii?Q?+QRL4U6dAZU5439fHQRi0nVG+UVrfazxcQgcqptuS5jXh19zPpotRRiU0Cpo?=
 =?us-ascii?Q?YJsTHu0elegrNWCw2ufRvtgklxhac8P3yF23cJueYg9IeRVljjrs8kh0Hnpx?=
 =?us-ascii?Q?kojgvGeHBmAkzt2Z+DnkeYpKSUwzAeeCg/wCDKex7pLvZEjkY8gpont5XZyc?=
 =?us-ascii?Q?dMrI1eJDs5joTV74/wonKsc4tGzMOrhroPdqsi/eMkRSTodFH94zrGcUSSwM?=
 =?us-ascii?Q?J5JYUL6jEEctlmzBg18fYT4Mjrx6WYjuKVdIm9EjvCCaflSzT8vKNwwsF7yv?=
 =?us-ascii?Q?trNm7km371RYFPyqt0kxIciFMWw/K1JHMMBk2VapjrXGEB5ZHmrayI3aEP6G?=
 =?us-ascii?Q?fZNRFVGSPnaobPikaveByHElPJwFXjpRsIyBJMZ/xQ5cu8i2amq8coMp7p+M?=
 =?us-ascii?Q?Ci8qHqTYjXn4SlNfKm73MEi+tbLJpMQzN6VZrS7xl9zGhs8dBcX9xRnaw++Z?=
 =?us-ascii?Q?Dp+DJ9yze55xUOG6lFQh9iXFLuUFFw9nMMtYV5QOYl29WiF1nhhq2vJR7CMN?=
 =?us-ascii?Q?0fBBaAGmRhcV2bSdPHP2XA3Zg+IhCsWhPq0+ptqhhadhaonPb3sTL1LTL4DL?=
 =?us-ascii?Q?eLU+/JcyhzB+LmT67pX7fJ7YgADhyDXTY24eZN+//4gmVFLTG3PN5NhVNJwU?=
 =?us-ascii?Q?tqoXIlXth+u5X9x5yCgdfzdTz+ilEmunXY5H725Ibg/dfNbPDBXhro1hTg68?=
 =?us-ascii?Q?toJ79yAQFxTzLtWhuMqkpBHkvQbxg3GL/iugKzLlxHNBYfOGz+0w947mosNE?=
 =?us-ascii?Q?OjzjES/b7LgI93lzOxC8sJvENHXeZ26v6awP08RJThjtON1n7fdpuzLwgXOq?=
 =?us-ascii?Q?U8f7rIOlNOa0C3ZySSXfc183pZEoRHSzd8BlMfvJ89aiDTFjhcGZfXosxngX?=
 =?us-ascii?Q?uRQf3Xz0ju3ipgl6QboI4mYUfDEsloXFncsBs4V/1N9+k3nIYS8eEViXdhBA?=
 =?us-ascii?Q?TO1lgZghszwYJ1nWufqndLqxRtNyMmE99MsQTMVktrba5bKTIK6+Rj/anrPs?=
 =?us-ascii?Q?dx6IJghRSy7ii2QgIWqcXPzV49kOysjL3de4OlfY+cAnKvcSD/9z8xOgzeqr?=
 =?us-ascii?Q?mtHBQPmUMN3ufJnISP8czDWJwEZ7NdVWa5OwBOWd2QXKoDyBTY4PZxEAKm5M?=
 =?us-ascii?Q?c3+1mZzx9sERQCn91gFs1aJI3hE8Z9ljb/j2pxbm3Kd4ITOz/CzOptrlLYWH?=
 =?us-ascii?Q?1XXDpjw4ZtPJZOPOG8gbfj3kiJ+O+kMOnVIj6PTtyi9O6/UBT/b2pLl6WFJ0?=
 =?us-ascii?Q?gRsTHDm37gZE/o0+li/B2h5BTjR19fRAsQX9FHhbNHMvFQckg1j+S22DZQz6?=
 =?us-ascii?Q?cRxT6JJiYkHnbvDSv3xBSQ9X1SzAcr7lj7F+5CMJ3+GMyi5NBqNM6XCSKqby?=
 =?us-ascii?Q?8GicQAtjljAxhjTmayHLElfxxA4n51YvBHVF16nwIyvsEhzk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496401c9-67f6-4df6-d57a-08df198e4c71
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:18:26.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeG92cGZd6dIdmAJZ5Bi4UhowH92PNSaAcDYIk1LrPuJL9DHamRU5CkYs6Idbw0tO23AoxQMPxF/5ef+WRaBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

Import include/uapi/linux/nsfs.h from kernel commit 69963a0678a3 ("Merge
branch 'add-support-for-rtl8261c-d'"), the commit the headers were last
synced to. The header defines the NS_GET_ID ioctl which will be used by
a subsequent patch to retrieve the cookie of a network namespace.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/nsfs.h | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 include/uapi/linux/nsfs.h

diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
new file mode 100644
index 000000000000..96bd591feb67
--- /dev/null
+++ b/include/uapi/linux/nsfs.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_NSFS_H
+#define __LINUX_NSFS_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define NSIO	0xb7
+
+/* Returns a file descriptor that refers to an owning user namespace */
+#define NS_GET_USERNS		_IO(NSIO, 0x1)
+/* Returns a file descriptor that refers to a parent namespace */
+#define NS_GET_PARENT		_IO(NSIO, 0x2)
+/* Returns the type of namespace (CLONE_NEW* value) referred to by
+   file descriptor */
+#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
+/* Get owner UID (in the caller's user namespace) for a user namespace */
+#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Translate pid from target pid namespace into the caller's pid namespace. */
+#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
+/* Return thread-group leader id of pid in the callers pid namespace. */
+#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
+/* Translate pid from caller's pid namespace into a target pid namespace. */
+#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
+/* Return thread-group leader id of pid in the target pid namespace. */
+#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
+
+struct mnt_ns_info {
+	__u32 size;
+	__u32 nr_mounts;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
+
+/* Get information about namespace. */
+#define NS_MNT_GET_INFO		_IOR(NSIO, 10, struct mnt_ns_info)
+/* Get next namespace. */
+#define NS_MNT_GET_NEXT		_IOR(NSIO, 11, struct mnt_ns_info)
+/* Get previous namespace. */
+#define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
+
+/* Retrieve namespace identifiers. */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
+#define NS_GET_ID		_IOR(NSIO, 13, __u64)
+
+enum init_ns_ino {
+	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
+	UTS_NS_INIT_INO		= 0xEFFFFFFEU,
+	USER_NS_INIT_INO	= 0xEFFFFFFDU,
+	PID_NS_INIT_INO		= 0xEFFFFFFCU,
+	CGROUP_NS_INIT_INO	= 0xEFFFFFFBU,
+	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
+	NET_NS_INIT_INO		= 0xEFFFFFF9U,
+	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
+};
+
+struct nsfs_file_handle {
+	__u64 ns_id;
+	__u32 ns_type;
+	__u32 ns_inum;
+};
+
+#define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
+#define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* sizeof latest published struct */
+
+enum init_ns_id {
+	IPC_NS_INIT_ID		= 1ULL,
+	UTS_NS_INIT_ID		= 2ULL,
+	USER_NS_INIT_ID		= 3ULL,
+	PID_NS_INIT_ID		= 4ULL,
+	CGROUP_NS_INIT_ID	= 5ULL,
+	TIME_NS_INIT_ID		= 6ULL,
+	NET_NS_INIT_ID		= 7ULL,
+	MNT_NS_INIT_ID		= 8ULL,
+};
+
+enum ns_type {
+	TIME_NS    = (1ULL << 7),  /* CLONE_NEWTIME */
+	MNT_NS     = (1ULL << 17), /* CLONE_NEWNS */
+	CGROUP_NS  = (1ULL << 25), /* CLONE_NEWCGROUP */
+	UTS_NS     = (1ULL << 26), /* CLONE_NEWUTS */
+	IPC_NS     = (1ULL << 27), /* CLONE_NEWIPC */
+	USER_NS    = (1ULL << 28), /* CLONE_NEWUSER */
+	PID_NS     = (1ULL << 29), /* CLONE_NEWPID */
+	NET_NS     = (1ULL << 30), /* CLONE_NEWNET */
+};
+
+/**
+ * struct ns_id_req - namespace ID request structure
+ * @size: size of this structure
+ * @spare: reserved for future use
+ * @filter: filter mask
+ * @ns_id: last namespace id
+ * @user_ns_id: owning user namespace ID
+ *
+ * Structure for passing namespace ID and miscellaneous parameters to
+ * statns(2) and listns(2).
+ *
+ * For statns(2) @param represents the request mask.
+ * For listns(2) @param represents the last listed mount id (or zero).
+ */
+struct ns_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 ns_id;
+	struct /* listns */ {
+		__u32 ns_type;
+		__u32 spare2;
+		__u64 user_ns_id;
+	};
+};
+
+/*
+ * Special @user_ns_id value that can be passed to listns()
+ */
+#define LISTNS_CURRENT_USER 0xffffffffffffffff /* Caller's userns */
+
+/* List of all ns_id_req versions. */
+#define NS_ID_REQ_SIZE_VER0 32 /* sizeof first published struct */
+
+#endif /* __LINUX_NSFS_H */
-- 
2.55.0

