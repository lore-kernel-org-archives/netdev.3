Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1763F3273;
	Thu, 15 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076579; cv=fail; b=n7sjwiUe69j07X6OLD1DsuQ7U4vclr1DRS3RQOTbwTX6VHIjeB7I8EhSnjLliX28E+889m1Siz4+ydUgDVer3JB7oNRIKqu2ONUsxIDT4naSqDgszc6Qow5n7AKq49ATaykjKZisF3a46eIEXezlQBGNNqu598P8kh4BVi64xjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076579; c=relaxed/simple;
	bh=0Zol1f7OX0mkkS4SnZ3l630d8gf+EYfExiWxqlMRg9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0KQ8iL2vBmm4RXXQ+xPq+1igYTVzATOfMBgCZq7VWd8esOdIpRViwTd/+nolXoLlIA3iNQsBm+JwHNwUzJRZgg56C69v5GVJP37LjSEszvFGOX41d3Vgz7bhRhT5NPtuZoZNFsaaVC3UqQvVvbRdDbk++/HF8mLMk5V0bvPE5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPey62Bt; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPey62Bt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU43rSDOTCGc+l5x93DkhLEYLWEhor4n/SroJ/E693JRwNjxcV0JHAspQRHukJssCUmqaiqey02NeOSDEYjYFlxGIhfdKIj6eb2xjc/RFvEETmQSx0jhpDezsJv8aeJ/vYwbGWTySTrJaje00KRBIC74ahxu7KOixDdvIEWo+y7nChqQdTTZXGn0ikQFZQ6GzDqMLWrgRUDpJKEuYT+uC80XRfOdaOi+g8YInjvNuo1KlHrgfElYoBmOxjTsDL7zvKtsLDlhWHfQwUedjyXNFQvYoz2IyMNcZtk3kBFCZZuKfmCsD5GLyBmlpEUL0LYi5BZQ+dDVFYS+D2uEdJJEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2Z3VFzPg1aj/igBDyO92pv+ARVq2DCMqW3oLHcgeRQ=;
 b=a2oVPN+NsK8YxqF/5aXDHE9BvDuEqk1FX+hztepsOOg/IMjI2cx+WiIwC8r2Dk791gYAS7jxJaQhxzeTJCPj9BSWvWvLInuSPCUgj3AdJC9tZt2OXxZ+Uq5/ZT+6NfIVA/amUhdlv/d7a+ztQL5194e/kMVMVrJH+DRYbkOK8HNwXupncZJ/xWOZhHghogP9MEe/quyqXid/e8nMS9TDOrpZ4cX3X+GewvPkkvRWKi5pPI2IyAAm/L5HvleJHvB7TD/4RhmL5QHoHYpfYK6Y164V9X8BXIbhr9Wx2IofIzFdlqI+Uzwl9KTK80F/agiU0UHDJVyg8HBihQW8nP9TNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2Z3VFzPg1aj/igBDyO92pv+ARVq2DCMqW3oLHcgeRQ=;
 b=HPey62Bt5HI+Xapza2vzedShW/Ll+OVFo1JFAYKb5cXtOT2u/sKgQaoWZU8N6l++3/ElUvpeNTll05MNP8cimvhizavWf1waIb5O2rIBe1MS8vQrmMZkbagAgU06ajl+DyoiRgUpBI3KuzdK8B2OMJegwF8TNUlqV3ucfxbAisaUgBkremNnHfa2ipLR6o8idbYajjNb9e7/QzXLwTPF2CexE6YvwmakBeqYgatcQLKCD7/WUPcK8zp3iIOzGyq7L6QxvL0VG6vi9myYt8Qgioii6FHOX/9wFigePM4vVUoTdkQ7UemEWVXdtmxgFi7tzEJd2xqMGcBWegUoSc/Uhg==
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 15:02:51 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::20) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 15:02:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:16 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:13 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing the rings
Date: Thu, 15 Oct 2026 11:00:42 -0400
Message-ID: <9e3d980f9853cd73ce4e845f9c3e5b5cb93fd2f5.1792008404.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab00b1b-356e-4d97-cca4-08df2acd61dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	XDTtr8nU7kVEsx1PmNDEZRjqsJl2Dep86FwPmBuK+LWAqGQgE7Rv/tvRystIou1cagejUVMWxNMaNlIYtstEv9pFG1xTt3WY8WVhgWOwDEnTqUeUyW9TIU9ZUN/a5frY72C5kTD1Q896FbdOR0fC2kKXVPoED2tOcSRXPMDps60mszk2VP4QakfQhCkY6wKT0bKLhnonZRcshYuohzVFAmWKZQ21xXcl+N1JUl8EB0O3DzH0GL/eWGoPyVJ8Lclm4y2B57xleq9IArEUqHcS7HQ2BNhwf9mrEetUw/MY1IEvB1+6iTm8FSvnILbhOWF6qZOqGDrXseMuu+fDZW9sa0ydx4yrjNR5OLvMGfXsQifzX6F6EUry58PZer8o7PzHsMRAE8YIardw1+vYXDj0TJ8VU9P2wZ22v5hupitd/86v9UmXRXqfeUrKBaTVaf3fMm96/pu+VCsLrUFL5/TH6k1mSsAqtCGUxzkzY49EqpRygVQOo5L1xWnld1jv5dFgLHsy4zeOHXy1FvmDcQVGoz3cC8Ar7gtNfrEl0M2K3aTyqg/JTVeCkfLRDrSFImIiHVWRqWkqp1Lky12SUDKd/tGMjG7YnnCPrsXgHshifvvQ0XuhzByQgD5TQ/0633ane3zXHGiPcIonYHuWvUJca25df5lM3HIsVzq8Y6NjqE0tK7H49p1GpsGv9ejYx27B7hivJtI/Rqs2Klm4emfCvo8q69wgsO3hILHoItKxvNGVCHDOog/2HufFzBJzc9V8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AfYmVjTptwJQ4z+KlwjjNI2dJu3PDy+GUoVuTdAZaoIEZi3ZnS8OneMPAginBg6Fkhk5dLUh1ES5zob6MG7S/Bjp/11ZT0VrSuP8QkOgcY5SRygvfZ8uETIwCG4+FzfugZ6pfYAx6llCeAhaSyIrMUpqMOGCFuXOe1D5JHBODibLc1XXoRP4Il1dxVoCuAf7cKH5iQQhOBELIG5LXz/aFB3TTkP33ppg3Uu57XPG3Iq9GnVy+Cpy4jyHU3k1+cyrXnMaEPm2bwfHzfclczBNa8LM37pwEcTt8j2sItXLcOSccT8YmS+BfiB0v96Sy8Cp+fdFepcMtcp/2C24RuGZQdWH7T23xe5r+umzWDA3qo4NW7BWP/4EekuSOiNiqr/mX4rv9F0ciVXfnKKV6an1Zy5E8o7gvN6oSjvFhbLw9nbNi/WH/B9hIo763aDP/VeY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:50.7570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab00b1b-356e-4d97-cca4-08df2acd61dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

lan743x_pcidev_shutdown(), which suspend also uses, calls
netif_device_detach() and then lan743x_netdev_close() with the qdisc
still attached. Detaching only sets the queue stop bits. It does not wait
for an ndo_start_xmit() that is already running, and the TX NAPI poll
still wakes a stopped queue as soon as it has reclaimed descriptors. The
TX NAPI of a channel that has not been closed yet can therefore restart
its queue, and the stack then transmits on a ring that
lan743x_tx_close() is freeing.

Only wake a queue from TX NAPI while the device is present. In
lan743x_netdev_close(), wait for any NAPI poll that may have missed the
detach with synchronize_net(), then stop all queues with
netif_tx_disable(), which also waits for transmits in progress, before
closing the channels. For ndo_stop the qdisc is already deactivated, so
this only adds a grace period there.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Assisted-by: LLM
Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 583f631df701..8d256a80dac6 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2125,7 +2125,8 @@ static int lan743x_tx_napi_poll(struct napi_struct *napi, int weight)
 	/* clean up tx ring */
 	lan743x_tx_release_completed_descriptors(tx);
 	txq = netdev_get_tx_queue(adapter->netdev, tx->channel_number);
-	if (netif_tx_queue_stopped(txq)) {
+	if (netif_tx_queue_stopped(txq) &&
+	    netif_device_present(adapter->netdev)) {
 		if (tx->rqd_descriptors) {
 			if (tx->rqd_descriptors <=
 			    lan743x_tx_get_avail_desc(tx)) {
@@ -3336,6 +3337,9 @@ static int lan743x_netdev_close(struct net_device *netdev)
 
 	lan743x_phylink_disconnect(adapter);
 
+	synchronize_net();
+	netif_tx_disable(netdev);
+
 	for (index = 0; index < adapter->used_tx_channels; index++)
 		lan743x_tx_close(&adapter->tx[index]);
 
-- 
2.34.1

