Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021120.outbound.protection.outlook.com [40.93.194.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90290476065;
	Tue, 21 Jul 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656406; cv=fail; b=JnauMxnINB82PMpaIKHg9NwP045cDbliBgDEBjAtA8VdpKLcdKjYfdJz+pFEtoUS9tWYlQVhZ1YTzziRQ9ks5bWwUd7Z7U1DDxpOdvty8Su1dEDRKmPj+mx6kydGJUUqTPIkCtbOsd8/fi+3W7KY/rZNspro08h5bSflrFDV15M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656406; c=relaxed/simple;
	bh=pNV3iQ11UTJVfDL9ofkULsHwKw7DLfLEDOZG579yT84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwLY/LI+zFmrxDAKeqzDHhXUdQRfa4yu5lspLkXXac4AtR8bs6RA1ZheGBEen8gw8KExlVFgA7H5zTALhW4mbLya1v0mOvrFegK+4qTp32GwLanMFgekaqIImiIzMkBUm77tQaywz/gUbVjs7TYhXOiN3I7YfZ0yipTydjhUgJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cQmat+dt; arc=fail smtp.client-ip=40.93.194.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cQmat+dt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1jyKOc5PBUg2XwRot+dQcBwpFwh3Pt6UFmpYXA9bqM29NdHUtfFGM4FD460bKQbfqpv0BOJGNRFiZyzMnl74naGiyQVcSzifLYEXLObSdldK5g5KMnfhWW+X6vO2GpuqEieYKJ4tbsd7U5fZpPbTghsp7bKd+SBaxL5nW0piZ+aDSQ4RNJLvyrh35NSNW5fgsThlvLTqnDxlyXO93w24PXhkC+b/uW1XGQcDzbnGmDtHczfZ2KI9HZlzSb3QUx0KWkOhHyqsWkdCa8PmMAlXT1bSGuY8SkuWpMIYy87j1Uks8XWsLQQEt9KGhfr8ONib9xAhSKUtUKg5ig+NmbPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Viz+QIKgsg3LljvRmuFtg6CFhwSQYW+nD8K2mJYCe7E=;
 b=NtCDnC30SaQ0vUkIAVDU988kKx9wRgweWseof0XhpGQlrG5hma9KVA7sWvhkb1Eeu2JJRzu/k0CgfG/WrgegQX8GWiyNl+nOGc5AiNYA3L5KxlRcxS/DanJQL6tlDCYtJTsA23375gbc5XaBr/8/ZpJhSxeLb3vrO8r9Sc7m9JQkBJEexsdjILBWXxrpUBYgDN2rmHiOV6FBVfAUCRvV5LFNirMubdzTjrxOcg/GeoIS92zm0CriZdWwEMfP5CxBr0Zqe9oB2mawd+BGY7m80ALwYZoTv60lT9EB8XeWopt179pZH2W2bcdIFCgK7JLF5sw6b+SLtRAgF+eHd2iI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Viz+QIKgsg3LljvRmuFtg6CFhwSQYW+nD8K2mJYCe7E=;
 b=cQmat+dtajuPTzXugWW2h1lYNz+5JAPP2UP5ChM1mq+WXoahngWjbqWSbxSeaTLplW0OWG4gn65GjXZHuguohmRaUQAEQM7yRwZxhF/4EUSF+KvZmQ/qRqxiFRQUSkc1jv8haPDXVcCedRhB4xfszIpuNYmmCHCglf9+L79+LOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:19 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:19 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 4/7] mailbox/pcc.c:  add query channel function
Date: Tue, 21 Jul 2026 13:52:53 -0400
Message-ID: <20260721175258.87600-5-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:930:a1::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3614fc68-514e-42ac-3af4-08dee750f2d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sTMSnB1er7JHdCDNvEYUqveFOS7ZDm2t9fLj4AQycWvW3WmAO7xsmQKFx0WZUDeA2r04AW9Cibw5bFbkanHoqTpvAM8AaLtS7X+OmtkM/HbShZTUciWUyJyMsZOdXJ4q/gxnFMNBuA15w/iRkHt4OUJBtw9P3qIcnX7aWENfGnEi9op4Oq2z/R0i0yY0GfDOPky046tfDOt75oSVjttQqD7UbPXCY5ce1orN2V53njydwicWYS1LS9JZHJFuyuRVuwi7yRTIS4YefmlZrlHb+D0SAFZlq46fDHU+KJJag0tQaAh1DTvSk6TFSw2RtDoSUcKrsww6RBiDgmGWNjCqPQKyRTDl5I0uzFIjia5XRUG5lyEACE3XwtjXqBXdESXci9z4E1X4gw2bS5di3LvUdpon5lHtXVJWdJOS3V4MZVGdiZQkKw3DGJkkVgqIctERLDWGQZ8ZlVn/LuGAaRsPYsTishODcw/fpnZpDV3vhzGd96Awr6IzfiAfAbtD2WO5jWNkdDpHi2XII09m1OX8KnA6zZ/GhWitu0LrOd/pz6hP5IPvs7IDiQtRRf4Xs+qeeZQQ85XIBpmVd6EpmKYqBgdzQQytsLUPr/HaMfMrWft3ZPzdDHZAZ4iSpa+Mkb8tZDWiwe+lxFbCI6I1q286LEj5CzMhyaQd6yfiL8Zxb9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urIvCjGW26CP/jWYOAI1I4TdfCsuazKyVPZoq9P826cUvUmZhRfzW9tmwpVI?=
 =?us-ascii?Q?oc/uw3q7w7qebXFa6zCyjHk1MjelmiBWKKPcdM+Eo/tNu8pkGdFvw/uCVnxx?=
 =?us-ascii?Q?W8wf+OIlsxVMBEk7K6asCNURNXR9wKrxk6r98RdR/FbralyhSaPJL0E+1k8R?=
 =?us-ascii?Q?IzjLx1SsCSMqOQn6KhyVI79gd0VDnpnU7sSrBAtyIzutrxEIsxNqQ9LV1++/?=
 =?us-ascii?Q?od70SkAgWJJpeAPIzRJK+WKt/3z+elzZlPxAwOLopTs/CQSFI+apP+p9tdU0?=
 =?us-ascii?Q?Cm4XpY8gGrRO4BVmwXenaXRdmmSXLQNERcbG1ymSniuglnlIFhnDsT0YMsGu?=
 =?us-ascii?Q?zJTFJP9RuPGRAd0ro1swE74lot5XN7B/LC4ZWEj+96Xa80giiS4Cq9AssoOi?=
 =?us-ascii?Q?Llg87FKr0KgDrswvVmYSlcWnpPRsJOPnyoLfLh/RqrB7PMKLs1/i2fHT+Rfk?=
 =?us-ascii?Q?LkDKXoEldtOl/l3zQiReoannb70A5138m4aZjG46307O3x8iEHfoaTYx4zSA?=
 =?us-ascii?Q?PuJ/PFiOJ3Befvv5zsc+h5aZNuJaL0WSkuTacHLXPcQz5KNu8hKHYK46iHDY?=
 =?us-ascii?Q?35HXEIPeR0/yqrsyjuiJTqgjv1a8Mt7Aj2tBbJr4yne+rHq5MXE/yQfUcOK4?=
 =?us-ascii?Q?3UK8a+EvROEkXGpEu3GjuDtzEEnWm3JpYZYZcNc/8rrRBzLDvps6Q64dh2TR?=
 =?us-ascii?Q?SKkyRglikk9SWxyhyjNk8LIB3Sta/ZSonL5f0n4OqzQmPT//YDY7CTWu/iwS?=
 =?us-ascii?Q?z1vdgMCL9iOSordj7+jHV65G5gGDxFBehzfM6lTweMpUI0l/5pypafcDXOIj?=
 =?us-ascii?Q?g4U8twNR0ovFo+0VMN7gz9eE6vy6u+aMnT+k9DBYZg/NK0aLQzqoVkspzhnI?=
 =?us-ascii?Q?tr13ZHCNEzxOCFwsQoc4QOkTzCcRBhCQ7thPxcxbrI7+zFWHL2KGXeiwuTql?=
 =?us-ascii?Q?2SZbbyBJpdvudHiin1fXAGByF+nvmwqXXBnbaxtezIJIl9BUzwyMRAzvaCU8?=
 =?us-ascii?Q?5tlTWGT93pJ3pcj0bkvGo4HnS0xnQ4kFvTcPF7udq5XfOyXgN4WDHPBH3UvN?=
 =?us-ascii?Q?LxXNtd3L4EcKAXDjhPZVBKOzD3POEORpPTqGTex4eVgAWF9iho56WJVcDU+i?=
 =?us-ascii?Q?RIfm+4WTNZs07Fzd6ocqdBhHKym6n/6hfFGbBw+9be7VnqPpqhYsgfwlFpe7?=
 =?us-ascii?Q?tk/MSnR/KTNxlh0T59VJOD/NhJu7pGsxQuCWuR4iwroDzqcQUxQq6BaOEd3+?=
 =?us-ascii?Q?HsVVW+EOlpxEbA9q8HgD1sOAuBgunK81JYxeV2q4Ezc/jntPIETHZIMfpu48?=
 =?us-ascii?Q?x+M+U5wFkyPlR3v4oj8g3jHHNf6DG7Edn8mKKXW/ZJejXdIZJ61T7DHE1V10?=
 =?us-ascii?Q?wwVh+t3eU8Uf5KUBpAt9bzXMxB7wL7UJ/DTQJ9fHCcyhwlFCWU0H71QF8uv9?=
 =?us-ascii?Q?1Y4lkUrZgsQEqolqoZrIyDl1gYZ7HZNVQgUdTUEGpEzW+6SnYPO06q3R+pp/?=
 =?us-ascii?Q?rL/iSXsF55QaBb+KE7hAywDKysV5NuIEOrCUHJPE50iG9TkRsWwmmUftILvo?=
 =?us-ascii?Q?+k3Cau+JH9SVEDA3Eb9aGIOcWF21M+PES1Xx/OGnHtu83wjZeicaXYEJOy+G?=
 =?us-ascii?Q?eW6r/T/x2JAqe9n9Bn0Fw8VkC6qgnwij6wbVHxZ6MDWicYUKLWgVIxel5lFp?=
 =?us-ascii?Q?5PbuWxkesTQ+9kPj0pHctqbIfYM5m85uGw1paSq2KBKniIy8Oy1jwbOTAAwf?=
 =?us-ascii?Q?nn4LHonEohY3TA7nYVYIZOd8IGEkhUGuAy8QZh1pO4alLdjm60mpaKqbqDSR?=
X-MS-Exchange-AntiSpam-MessageData-1:
	/XRLVg+J2ZBM0TI1jstVFX7On1p5FWWGTS5PP+9VNq4mzUbiaNRyf0e9
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3614fc68-514e-42ac-3af4-08dee750f2d0
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:19.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1WqxN59qECm1JXWq7lM7lYYyXaDjDuL+evpbX7lTqQoPQjkPYsMJG7bgeiU1+LdE/1/AexVvrLc8lvlaLdbxtwyFAKbgCpPtdpaxW4GxRtE7qBwCHQxQYxSLFEADDDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

Drivers need information about a channel prior to creating a channel
or they risk triggering message delivery on the remote side of a
connection.

Add PCC channel type to records and expose PCC channel type to client.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h    |  9 +++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index b1c7d3e4c5e3..b9a01bfdc95d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -349,6 +349,50 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+/**
+ * pcc_mbox_query_channel - returns information about the channel
+ *              without activating the channel.
+ *
+ * @q_chan: a pointer to an already allocated struct pcc_mbox_chan
+ *              that will be populated with the channel data.
+ * @subspace_id: The PCC Subspace index as parsed in the PCC client
+ *      ACPI package. This is used to lookup the array of PCC
+ *      subspaces as parsed by the PCC Mailbox controller.
+ *
+ * Return: 0 upon success or non-zero upon error.
+ */
+int
+pcc_mbox_query_channel(struct pcc_mbox_chan *q_chan, int subspace_id)
+{
+	struct pcc_mbox_chan *pcc_mchan;
+	struct pcc_chan_info *pchan;
+	struct mbox_chan *chan;
+
+	if (!q_chan)
+		return -EINVAL;
+
+	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
+		return -ENOENT;
+	pchan = chan_info + subspace_id;
+	chan = pchan->chan.mchan;
+	if (IS_ERR(chan)) {
+		pr_err("Channel not found for idx: %d\n", subspace_id);
+		return -EBUSY;
+	}
+	pcc_mchan = &pchan->chan;
+
+	q_chan->shmem_base_addr = pcc_mchan->shmem_base_addr;
+	q_chan->shmem = NULL;
+	q_chan->shmem_size = pcc_mchan->shmem_size;
+	q_chan->latency = pcc_mchan->latency;
+	q_chan->max_access_rate = pcc_mchan->max_access_rate;
+	q_chan->min_turnaround_time = pcc_mchan->min_turnaround_time;
+	q_chan->type = pcc_mchan->type;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_query_channel);
+
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
  *		request a pointer to their PCC subspace, from which they
@@ -833,6 +877,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
 		pchan->type = pcct_entry->type;
+		pchan->chan.type = pcct_entry->type;
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 840bfc95bae3..bf97f407683d 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -8,6 +8,7 @@
 
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
+#include <linux/acpi.h>
 
 struct pcc_mbox_chan {
 	struct mbox_chan *mchan;
@@ -17,6 +18,7 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	enum acpi_pcct_type type;
 };
 
 /* Generic Communications Channel Shared Memory Region */
@@ -37,6 +39,8 @@ struct pcc_mbox_chan {
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
+extern int
+pcc_mbox_query_channel(struct pcc_mbox_chan *q_chan, int subspace_id);
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -44,6 +48,11 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
+static inline int
+pcc_mbox_query_channel(struct pcc_mbox_chan *q_chan, int subspace_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0

