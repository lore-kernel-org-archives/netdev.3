Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AE31985D;
	Wed, 22 Jul 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726846; cv=fail; b=o+eyCsKzO4PdfDmLMMgQIynWxfaPBHUbwUMzE9C96RKPRPh1nLNGL7jLtoKX1MxMTjxfCpGs72Fy9XBULYvfJ4WE7PofbJzSHv9zXZjDznpe2GdKlaWsBsmdXkYDMElyfqDr9tqwAGARpHE/9BA+1DP8GyaynKfOowA71wKPOj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726846; c=relaxed/simple;
	bh=pZ9d2U0KVPn4f/bMpMgGvtt4zVNyemSO7icNpvw7+AI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gPuVDqnE069GIw4NvD8I2eRcb4MUHh2dWWczx1nO/N86a+RwOGGlOpNYU9tpmEbM03HLsEu0mZmdb5rwxIkd4f1zPDaZTuVowIn0oZL2qjIXtWmpIftYN5p1GizM9/4dHFFYu/7FnzTXPP4sP5DYQUG+PEpIIh0Tue44FbLygJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ef7R2+S8; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ef7R2+S8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkHS8/IcPT6pQbBY6mdLJYj3+u7h4m/fzde0WasvNrBo6my+d6tcmRC7qUNdA6l7DRXWD+3GCb6kEcDB4d/eazQ5eAAYWa0mI15MBLCrRjmHx5n/nX9pqi+zSUG42TAibKM9jvqBdTvfl2GGTZ5EcU8O+S1OKDlnisV4AcZmaguL8A0kaVFLVS2+aZFrzNc8fZo9wmXLiT9GZ8drK9cOkyvm1jRii83pg5ZOsWchTvRQ9nvAdT9b+2GPK9EaX1Ob8UossuFrf+Wt6pTB/G3/Fe+kUkfsY/nwGssMF2KTB+E4Sdek96roNUWKXndlwxeWXrR3IXzU6+zNwvWqIEbHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/eVPCguvaSbuzocn/QTW8qeluu99t/7ydMHWgvbX5M=;
 b=JFXVtjFFJb5oWn/q4J3R7Ao3cSvscUlCvMXF8STW1U3sr470lt9NgxYecGG+7uKs1cADayauAGfh1Cm3bmC6w/QBUNd3UJsKz86py7laIX6/JTVPWeaDDxBK0pW18eCeN6nGvTHdiLnLTcaC5+kzX5GJWWOlA14m4O+LTxWLc1CoswqoJ/xnnaSgwdBdWNb/NC/dptzxuulWCf7TIlGeeEb/Sqgoa0rROpXDAMd16AvFhDpmyqb0QoHsoJlMpZXAAdLqlCsg65JU7VTLJ0SrFNn1MwEs1IKVbLq666B83l2OObab75PQdGwq7tXEcGCFaeTrb/TcentyvcMgvKFUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/eVPCguvaSbuzocn/QTW8qeluu99t/7ydMHWgvbX5M=;
 b=Ef7R2+S8OYgGeq1f/Mp6+3XtVwDObxRJmHznemU4JaESJViUfMBnoIfQQXl4hfI0WjTFumOa0rghzXuBCeqtGva13sVFJvTGTSgLBcShS4ojrCvAowNZJUZpaRMklNryt52L7KmawhofjeS5IWceu2XZAagW17kdrtiT0vKu0Jre6KEPw7M8wT8WGh7E1byA0tN0j/Gph2nWvRwqWPADVItRN5x0KQnBj4Lg+WaHQk9Vd8f2A0GzS2P42vZNh7rxogRL5+J/dqxiy8kAhUFGljcNQS/jPYnpRpMWEkDabQppYUzLKsgxgiDUKxxNG2+v7pIr95my86Znhrt/HNFGOw==
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:27:14 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::ae) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:27:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 22 Jul
 2026 06:26:46 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 06:26:41 -0700
References: <20260721125753.35944-1-mhun512@gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ijae Kim
	<ae878000@gmail.com>
Subject: Re: [PATCH net v2] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI
 before teardown
Date: Wed, 22 Jul 2026 12:07:53 +0200
In-Reply-To: <20260721125753.35944-1-mhun512@gmail.com>
Message-ID: <875x2788ac.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: b5969f64-8bd3-4676-540a-08dee7f4f154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|11063799006|5023799004|56012099006|6133799003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	84zpt3J1TwRUBCujz9SKlEoHIYn/OQg6EuaWWIJ9LsA+7phsueO9CvYHxXqtWahHnWcq7OJu/SePCewlIfXTOliLzXJvQERAUNy3VQqFjQYeP3nZ+zQa5jPWWMgPxda4RVeCGxGZw4xCmvDnyjX3acKzhd9qDDDNpmKUYOMeronbzgV9MPkXKm3weEH4mCj4D59+1XQ4Xe776SeG1ajKeiEbs/uJy1XONjjhMySwB3w8Sh6qdWI5BRCcUsAkfl3bCUJFGUdQYuxGGVYzXPVymmpMoW99hQXpOfyM8vgr9oE53TyOK2xVoyTQSV0SVtInZWyonIqdnhenSo4QPWVVbQPSQuZX4SlFV+lVFkWU3FLe8ksqIaxpJtznbJ3IqCHAXXPT1xG+v17s5c0DjAGmlWi4tbTOdm6b2MuYHgTybtuz24FjKTDoTORJjM33BWRUghyALcKKSkVvCd/chInKI+vwtRj19e/eiICgYQjhpEbIDaD6ncrjwsgLYgw7uGoIPNC/BGTo4GwveiiePHAOqOOi1qQJHziWYANdHKZVahr0ej4ikxZT9xVZSe78F3gwmHcvgYz2lXcTODW2x1AHqUDwjioKnaQDa3yvGSvkEpfP/FCHcYDw4jGmAxqd3PgS+cbm44QGfhtGOVbEQN2ojs8vfiugN5Hx1wEtqGkZTyvcZzzegLRAVQpo/9mXHxKtAlvSonA11ZsxDOxcRko6sQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(11063799006)(5023799004)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BlTMBnMctJnterpVqM/KNLdjba852BHnMZhjykZHiVF96lq8BWgchqmQcFb0ztHKEl6uj2F/BVZRdq0/Y2zsk90I7ijBGwfl5lr8U32Kf9KZcM1NfAK+7IVosEEE1ymAPn+Hj4/+AsAY+3zq5+QYE8WMiCZab0c/DOj76y7phxyWQrCKs38lcUPS9fd/NuWMDw3XAB4dpmtTOKRP3Eg1KzRO8n8QsAR6dl/waRNf2AdDxwaA871zr1ZxGhVRvzbT2wzZ6oYcRGCKwWVsK1ouiOQTB9r1wy19lxYpDaTqz/OOr3JX0NHp9Z//e7rU/v9V2mWbxp8Lf1eB5SSgLwEzsphjYB+ZTBOsERFatmw8xzBruUvIlrmPJgaHKfwzNefepr8qexxkcWbFb/P8vMmo7mmzD9MjrgmBUWDN+/I5ijsUgdnw7iaWCihH77So58mz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:27:13.8582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5969f64-8bd3-4676-540a-08dee7f4f154
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417


Myeonghun Pak <mhun512@gmail.com> writes:

> mlxsw_pci_eq_irq_handler() schedules the EQ tasklet. The tasklet reads
> the EQ ring and schedules CQ NAPI instances. The CQ poll callbacks, in
> turn, dereference the RDQ or SDQ associated with the CQ.
>
> mlxsw_pci_fini() unregisters the IRQ and immediately tears down the
> asynchronous queues in RDQ, SDQ, CQ, EQ order. free_irq() waits for IRQ
> handlers, but not for a tasklet already scheduled by one. In addition,
> mlxsw_pci_cq_fini() disables each CQ NAPI only after all RDQs and SDQs
> have been freed. A pending tasklet or NAPI poll can therefore access
> freed queue storage.
>
> Kill the EQ tasklet after free_irq() so it cannot schedule any more CQ
> NAPI instances. Disable all CQ NAPI instances before freeing the first
> descriptor queue, ensuring their poll callbacks have completed. Track
> the enabled state per CQ to avoid disabling a NAPI instance twice when
> the CQ is later destroyed, while preserving the partial initialization
> unwind.
>
> Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> v2:
> - Fix typo in napi_enabled assignment reported by kernel test robot.
>
> v1: https://lore.kernel.org/r/20260721062105.55014-1-mhun512@gmail.com/
>
> Found by static analysis on v7.2-rc2; not tested on hardware.
>
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index 0da85d36647d..feeb32134d2a 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -86,6 +86,7 @@ struct mlxsw_pci_queue {
>  			enum mlxsw_pci_cqe_v v;
>  			struct mlxsw_pci_queue *dq;
>  			struct napi_struct napi;
> +			bool napi_enabled;
>  			struct page_pool *page_pool;
>  		} cq;
>  		struct {
> @@ -989,6 +990,15 @@ static void mlxsw_pci_cq_napi_teardown(struct mlxsw_pci_queue *q)
>  	netif_napi_del(&q->u.cq.napi);
>  }
>  
> +static void mlxsw_pci_cq_napi_disable(struct mlxsw_pci_queue *q)
> +{
> +	if (!q->u.cq.napi_enabled)
> +		return;
> +
> +	napi_disable(&q->u.cq.napi);
> +	q->u.cq.napi_enabled = false;
> +}
> +
>  static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
>  				       enum mlxsw_pci_cq_type cq_type)
>  {
> @@ -1064,6 +1074,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
>  		goto err_page_pool_init;
>  
>  	napi_enable(&q->u.cq.napi);
> +	q->u.cq.napi_enabled = true;
>  	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
>  	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
>  	return 0;
> @@ -1078,7 +1089,7 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
>  {
>  	enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
>  
> -	napi_disable(&q->u.cq.napi);
> +	mlxsw_pci_cq_napi_disable(q);
>  	mlxsw_pci_cq_page_pool_fini(q, cq_type);
>  	mlxsw_pci_cq_napi_teardown(q);
>  	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
> @@ -1439,6 +1450,14 @@ err_cqs_init:
>  
>  static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
>  {
> +	struct mlxsw_pci_queue_type_group *queue_group;
> +	int i;
> +
> +	queue_group = mlxsw_pci_queue_type_group_get(mlxsw_pci,
> +						     MLXSW_PCI_QUEUE_TYPE_CQ);
> +	for (i = 0; i < queue_group->count; i++)
> +		mlxsw_pci_cq_napi_disable(&queue_group->q[i]);
> +
>  	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
>  	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
>  	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
> @@ -2089,6 +2108,7 @@ static void mlxsw_pci_fini(void *bus_priv)
>  	struct mlxsw_pci *mlxsw_pci = bus_priv;
>  
>  	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
> +	tasklet_kill(&mlxsw_pci_eq_get(mlxsw_pci)->u.eq.tasklet);
>  	mlxsw_pci_aqs_fini(mlxsw_pci);
>  	mlxsw_pci_napi_devs_fini(mlxsw_pci);
>  	mlxsw_pci_fw_area_fini(mlxsw_pci);

Hm, my first instinct is to just reorder stuff so that it's correct, but
this is not just init / fini ordering issue. The init ordering between
CQ and EQ is the way it is because CQ refers to EQ, it should be like
this. Fini then needs to be the other way around.

The processes have the opposite requirements though: tasklet refers to
NAPI refer to queues, so it's EQ to CQ to queues.

I think the fix needs to be done differently though. The patch has
tasklet_kill() invoked from overall PCI fini, while the corresponding
tasklet_setup() is in mlxsw_pci_eq_init(), the EQ-specific init
callback. Likewise the patch touches the NAPIs directly in aqs fini,
even though they are CQ-specific. Then the napi_enabled flag seems to
just be there to prevent repeated calls to napi_disable(). I mean, just
don't call it the second time?

So how about something like the below patch instead?

The idea is that since we can't relax the order in which HW queues are
initialized, we need a different queue-specific entry points that we can
invoke to specifically initialize the SW processes. By ordering them
correcly (and not forgetting a tasklet_kill()) we guarantee that NAPI is
created after the queues, but torn down before them, and tasklet is
created after NAPI, but torn down before it.

I took it for a light test and it didn't catastrophically explode.

From 116f63a959bcf9d658302605708e449588da8a69 Mon Sep 17 00:00:00 2001
Message-ID: <116f63a959bcf9d658302605708e449588da8a69.1784725020.git.petrm@nvidia.com>
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 22 Jul 2026 14:49:30 +0200
Subject: [PATCH net-next] mlxsw: pci: Le fix [xxx]
To: <netdev@vger.kernel.org>
Cc: <mlxsw@nvidia.com>

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 63 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0da85d36647d..30111ef16443 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1063,7 +1063,6 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	if (err)
 		goto err_page_pool_init;
 
-	napi_enable(&q->u.cq.napi);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -1078,12 +1077,23 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 {
 	enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
 
-	napi_disable(&q->u.cq.napi);
 	mlxsw_pci_cq_page_pool_fini(q, cq_type);
 	mlxsw_pci_cq_napi_teardown(q);
 	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
 }
 
+static void mlxsw_pci_cq_start(struct mlxsw_pci *mlxsw_pci,
+			       struct mlxsw_pci_queue *q)
+{
+	napi_enable(&q->u.cq.napi);
+}
+
+static void mlxsw_pci_cq_stop(struct mlxsw_pci *mlxsw_pci,
+			      struct mlxsw_pci_queue *q)
+{
+	napi_disable(&q->u.cq.napi);
+}
+
 static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
 {
 	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
@@ -1177,7 +1187,6 @@ static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
-	tasklet_setup(&q->u.eq.tasklet, mlxsw_pci_eq_tasklet);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -1189,6 +1198,18 @@ static void mlxsw_pci_eq_fini(struct mlxsw_pci *mlxsw_pci,
 	mlxsw_cmd_hw2sw_eq(mlxsw_pci->core, q->num);
 }
 
+static void mlxsw_pci_eq_start(struct mlxsw_pci *mlxsw_pci,
+			       struct mlxsw_pci_queue *q)
+{
+	tasklet_setup(&q->u.eq.tasklet, mlxsw_pci_eq_tasklet);
+}
+
+static void mlxsw_pci_eq_stop(struct mlxsw_pci *mlxsw_pci,
+			      struct mlxsw_pci_queue *q)
+{
+	tasklet_kill(&q->u.eq.tasklet);
+}
+
 struct mlxsw_pci_queue_ops {
 	const char *name;
 	enum mlxsw_pci_queue_type type;
@@ -1198,6 +1219,10 @@ struct mlxsw_pci_queue_ops {
 		    struct mlxsw_pci_queue *q);
 	void (*fini)(struct mlxsw_pci *mlxsw_pci,
 		     struct mlxsw_pci_queue *q);
+	void (*start)(struct mlxsw_pci *mlxsw_pci,
+		      struct mlxsw_pci_queue *q);
+	void (*stop)(struct mlxsw_pci *mlxsw_pci,
+		     struct mlxsw_pci_queue *q);
 	u16 (*elem_count_f)(const struct mlxsw_pci_queue *q);
 	u8 (*elem_size_f)(const struct mlxsw_pci_queue *q);
 	u16 elem_count;
@@ -1225,6 +1250,8 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_cq_ops = {
 	.pre_init	= mlxsw_pci_cq_pre_init,
 	.init		= mlxsw_pci_cq_init,
 	.fini		= mlxsw_pci_cq_fini,
+	.start		= mlxsw_pci_cq_start,
+	.stop		= mlxsw_pci_cq_stop,
 	.elem_count_f	= mlxsw_pci_cq_elem_count,
 	.elem_size_f	= mlxsw_pci_cq_elem_size
 };
@@ -1233,6 +1260,8 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_eq_ops = {
 	.type		= MLXSW_PCI_QUEUE_TYPE_EQ,
 	.init		= mlxsw_pci_eq_init,
 	.fini		= mlxsw_pci_eq_fini,
+	.start		= mlxsw_pci_eq_start,
+	.stop		= mlxsw_pci_eq_stop,
 	.elem_count	= MLXSW_PCI_EQE_COUNT,
 	.elem_size	= MLXSW_PCI_EQE_SIZE
 };
@@ -1349,6 +1378,28 @@ static void mlxsw_pci_queue_group_fini(struct mlxsw_pci *mlxsw_pci,
 	kfree(queue_group->q);
 }
 
+static void mlxsw_pci_queue_group_start(struct mlxsw_pci *mlxsw_pci,
+					const struct mlxsw_pci_queue_ops *q_ops)
+{
+	struct mlxsw_pci_queue_type_group *queue_group;
+	int i;
+
+	queue_group = mlxsw_pci_queue_type_group_get(mlxsw_pci, q_ops->type);
+	for (i = 0; i < queue_group->count; i++)
+		q_ops->start(mlxsw_pci, &queue_group->q[i]);
+}
+
+static void mlxsw_pci_queue_group_stop(struct mlxsw_pci *mlxsw_pci,
+				       const struct mlxsw_pci_queue_ops *q_ops)
+{
+	struct mlxsw_pci_queue_type_group *queue_group;
+	int i;
+
+	queue_group = mlxsw_pci_queue_type_group_get(mlxsw_pci, q_ops->type);
+	for (i = 0; i < queue_group->count; i++)
+		q_ops->stop(mlxsw_pci, &queue_group->q[i]);
+}
+
 static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
@@ -1426,6 +1477,9 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 		goto err_rdqs_init;
 	}
 
+	mlxsw_pci_queue_group_start(mlxsw_pci, &mlxsw_pci_cq_ops);
+	mlxsw_pci_queue_group_start(mlxsw_pci, &mlxsw_pci_eq_ops);
+
 	return 0;
 
 err_rdqs_init:
@@ -1439,6 +1493,9 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 
 static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
 {
+	mlxsw_pci_queue_group_stop(mlxsw_pci, &mlxsw_pci_eq_ops);
+	mlxsw_pci_queue_group_stop(mlxsw_pci, &mlxsw_pci_cq_ops);
+
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
-- 
2.54.0
