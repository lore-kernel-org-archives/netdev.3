Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7F39A4DF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477873; cv=fail; b=mSeKcw06lQjEFO+FWNTc0TUrFDPnv/q1gyhsmTSmybh889kAByiEBbdMUO6z3ioP0rjNKzhr9X71O+0ufI3H+uQ/83QjcGheSbxdUciPW3Z+UqqrULI5zZT8btLR3UD5qncJeRAUyg0Y9vQyMHnwdaUQnWqNVAYI0faAgFo1FBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477873; c=relaxed/simple;
	bh=2pWdUK4keP1jQN6ehExJiHtqDgqKzpeKbx6oT8do3b0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohZ++HLrvxJe02kpNcSIxXpI7BJQBAb1dLpfxVHIz4EZHdF4QQ5pV78ThxsRKa+J5JPxtP3j5zE9GQZYK9S/5mODF4ybMiqUttKnr0OvIXra3dWz1kGcEitJCU9sdJ72IQJIG5vieyStwxK+oL44UDk2invqjCrIM75zylGDT1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ef8AH2d5; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ef8AH2d5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZjG+G7/zV/sj0bsBvJW4vGXi7V9AnFv8DWEDAtoyddebvr8+KRKJqkET+DE4Y09n3eEc+p4O55pSq/NbO+g1pzi4NVWAU8woQcBl5F0f204KVeh6c6F08xXj9k2WJBzzVj23tM7uCdFeLlRvwCmRN1yadVz+qTMtL/U+IShbz5Cbd5VM8pT/1LT5xq3MGPUvDZD23xprAxNteEAWq3FCMld15JVcp0H0fksbsrmyfglcJNU8Ejt+ok07WhA1zO3hxAE5P5SiPu+epCab3A4Vio0uUAStQTvoyr/bOmL4lUxOyZzcmZTGvbXLTAHRyAo2WCc2oFEsxj/0/kTCriC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKnXZ6Pawr+t1vavyRc3uN1jmH/FoEPjN8cjnI4q0EM=;
 b=C7q8REPJUNBExF3JFbkqDA/UUlt2FqN0YyZlDOi3a+ibU6zaq8ctS8x6mo2f7MD/hwLb/V+67zR73cKNnm4Rp80eFdAUTNCCdG66k8xRvbVPNt/KvMFTUZ0/ltDB3o4aiQNdkvUYTKdlThUcnCGxpaXKsQZB/IFj694zsgHmnCBzSlrjpuDK9NO63Eac2MzGJDUFWQd5umS1VH1KlczsLommqXrI1ESYPgOTMQlyfQ6k7j2lMJWNDXhA68pW5brRUJ6xKN4qPzYlpqMaFam7iOuSov3EZZAQMb4uO5RuLskkebV9l8p8EEThcRqy3can9OHvPWBvc8R4UqSDLRl5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKnXZ6Pawr+t1vavyRc3uN1jmH/FoEPjN8cjnI4q0EM=;
 b=Ef8AH2d5PVMoeqobRu3iMFFzV4GiHZpOIZu+6Kufje81rR9XTFFtM9L5HuyKRwdGjM6etFzPLWrqJxUT7h9KgjtcpGAaPJ9SghczsPUOK6ipgO6dB34KdqYKsClpOxW9t5uqP74M5vLQg3dclfzNPsniM9ng9fEJ3Dh0n6RMZds=
Received: from MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::32)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 19:51:04 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::51) by MN0P221CA0020.outlook.office365.com
 (2603:10b6:208:52a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 19:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 19:51:04 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:51:01 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, "Nikhil
 P. Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 2/2] ionic: fix completion descriptor access with 2x desc size
Date: Tue, 11 Aug 2026 12:50:39 -0700
Message-ID: <20260811195039.1315045-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811195039.1315045-1-eric.joyner@amd.com>
References: <20260811195039.1315045-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 497a6714-8ec9-4f84-0616-08def7e1e0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AuQMlwF/ou56nWKuY7wbzhoZn1Grq9F18/vPNZp3FJt/ORuEGNicWgthoxoxuvDsHLewGFZAUF+kfk7nes67OZT5AolsLRG+zX8V226SctWDTO8AgjszdWwk0XSMz237lot1zChL7UlYecwfFw2u3cqJ/FUsfvgGSrI92hrWyRDakKHsUbYc0hnzRL5QS3HjQsEJ0n49SUKSEvmmWQ10R9DhywswsJ8mDbsSTWgyzazC5Qa4t+OAXaee3e75dLUF4nr5n41ujAXFyUiRkuDsBK8KsbR8a7B+4zoivnUkC8jJkggaEKTUuwKWW+1vKHdw9reFXQ6uNe4XOV/D9s3QzF5Ju+cso7JwWbVeiELNiO8c9abt+gRa8o823oHU6mK7gN3X69qvStks0+MLX2xKaRjvv5B91gXPzuLbZ7np+yeMl/FfBlOrfxM7NeTiFJUbgqPlRFSldQ+5Q731T4sFMfSXB9FUaUI0bDUPMb9WCu3KNmZrs/yruPKSrVEu0sHSmrCW9eIjD+Hb+QG9MM35mIohm8yKcjpNO4QS+8N5ugcxeHrL1ue6zI9BQJHYXv0QH8+s2OF4Xpm6LUIduYx5kwzAtzlkR9EAD83KhScKg3eZkF60MBsl7GrscPK//Uzx93GGduQqbwbfgUoPqf/fMw5K3JG6oNwvf1pbWuxpnUXnXzMJ1kGRjYd3HHWB+euV3njEeeZ+nae4Abg9tOU2Gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b46oiofqjOOJbuu6r2XdZWtVBd49/m0doGn+wQoJeb8R9pK1dHFm4kJimmujSqI/kretpGFsvoTcTUzw8V5pmPm6rOlW1vjod07JhTd7luPRUmGxyY82orDNlkdQjr0cPugFJO/71dFpK6jwsyrdId432e9qZFpPAmlYLnwS9EmaYCw54XiNdBnT3WCNhOzvEbgJsm+jyrJhyS6VHYzP26395IyMxrc+F3+7He63eogb3jIcJA/iDBHZhT7ryOHMud9vyEsajujuW+8eNQEde974mWI2Or1LEu1FfKocAQ29aeNlKUXvbfEC2SLgXN1QX2NUnJU/DpVPYdIbs3S/rHnY7GndWNwNHm1U/imZfX/ZS0nd/jFht18C+YUnJ8V+aZ/cexPjsL96FyXGrHfK8QCXwkR7URiomgZWDan/XCx2NTS85cDxz8os5q+BM2dO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:51:04.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497a6714-8ec9-4f84-0616-08def7e1e0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526

From: Prabu Thayalan <prabu.ponrajthayalan@amd.com>

The old ionic_rx_service() and ionic_tx_service() used array
indexing to access completion descriptors:

    comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];

This assumes the stride is sizeof(struct ionic_rxq_comp) = 16 bytes.
However, when the IONIC_Q_F_2X_CQ_DESC flag is set, the actual
completion descriptor size is 32 bytes (2 * sizeof(comp)), and the
completion itself is located at the end of that 32-byte slot. Array
indexing with a 16-byte stride would access the wrong offset.

Use pointer arithmetic that accounts for the actual descriptor size
from cq->desc_size:

    comp = cq->base +
           cq->desc_size * cq->tail_idx +
           cq->desc_size - sizeof(*comp);

This correctly calculates the completion location regardless of
descriptor size. For the common case where desc_size equals
sizeof(*comp), use array indexing in a likely() fast path to avoid
performance regression.

Fixes: 65e548f6b0ff ("ionic: remove the cq_info to save more memory")
Signed-off-by: Prabu Thayalan <prabu.ponrajthayalan@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5b58460350be..05938689248d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -701,11 +701,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		__le64 *cq_desc_hwstamp;
 		u64 hwstamp;
 
-		cq_desc_hwstamp =
-			(void *)comp +
-			qcq->cq.desc_size -
-			sizeof(struct ionic_rxq_comp) -
-			IONIC_HWSTAMP_CQ_NEGOFFSET;
+		cq_desc_hwstamp = (void *)comp - IONIC_HWSTAMP_CQ_NEGOFFSET;
 
 		hwstamp = le64_to_cpu(*cq_desc_hwstamp);
 
@@ -729,7 +725,12 @@ static bool __ionic_rx_service(struct ionic_cq *cq, struct bpf_prog *xdp_prog)
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_rxq_comp *comp;
 
-	comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
+	if (likely(cq->desc_size == sizeof(*comp)))
+		comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
+	else
+		comp = cq->base +
+		       cq->desc_size * cq->tail_idx +
+		       cq->desc_size - sizeof(*comp);
 
 	if (!color_match(comp->pkt_type_color, cq->done_color))
 		return false;
@@ -1182,7 +1183,6 @@ static void ionic_tx_clean(struct ionic_queue *q,
 			   bool in_napi)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
-	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct sk_buff *skb;
 
 	if (desc_info->xdpf) {
@@ -1207,11 +1207,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 			__le64 *cq_desc_hwstamp;
 			u64 hwstamp;
 
-			cq_desc_hwstamp =
-				(void *)comp +
-				qcq->cq.desc_size -
-				sizeof(struct ionic_txq_comp) -
-				IONIC_HWSTAMP_CQ_NEGOFFSET;
+			cq_desc_hwstamp = (void *)comp - IONIC_HWSTAMP_CQ_NEGOFFSET;
 
 			hwstamp = le64_to_cpu(*cq_desc_hwstamp);
 
@@ -1246,7 +1242,12 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	unsigned int pkts = 0;
 	u16 index;
 
-	comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
+	if (likely(cq->desc_size == sizeof(*comp)))
+		comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
+	else
+		comp = cq->base +
+		       cq->desc_size * cq->tail_idx +
+		       cq->desc_size - sizeof(*comp);
 
 	if (!color_match(comp->color, cq->done_color))
 		return false;
-- 
2.43.0

