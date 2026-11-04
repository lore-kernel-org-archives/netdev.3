Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827208;
	b=sg9lF1GGlFg9Ngkv8sxQwxxL9oMJx9fVDQ1b0Ep8wo8L2ge9ywPk1mRZ7CKdsNopZNuk
	 aAbZTgtTkyAPS6nDqMbXfYxl01KkN7vpxJNxC7WjPWMB+Hb0SXxXG4f2JxvwLErI80T9x
	 OF+TkTTURWI5CG7oNQZVouTBH+OEOiUZH1SS5X9x92Ck0g6Pv4DCuGA2931nc1o7xA944
	 Dvp6S9SR0rGOX3r1/gVq6K8/8U4lGysC4PmL5rBWvLf6snxIu4f7iY2HUk/5m9MSZUsg9
	 sZMIWRQb17iuZaxs1CC9/e7XedqUdrT3Q8igUqsjw4z8RRTx/a5qqpYO8ky8Wkc8IcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827208;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GyvBlJfrkoDDza2jjP3oC5N2lihedHzRT++WbEUI6iw=;
	b=JO8HAOdNJC5zNyVCZz4UaEXr/nSj57GtdZrCeVRzUXFlUUpahZclZcthQYEEFwPu0TIh
	 XgNKH78HI7y5vd8keD9Q3oFwAb7apKeJkBHF+DfUDguA2cxGqmI4V0L5MCJr+iTEEOSY5
	 TxCIfBYd/O6RnDc0HRFH0TdoU3Sxr1sZDFe2l2YhPiIvW058IFtDwrSJbtjb65ztUqmNU
	 KtZqp6TRaN1gpV4fhKsKOEEDbuUNr/XXiTBSyNQQ7zXnHkxu0bDb608XgCgZ6vXDLI8es
	 8FKPt3DjXEBG7DwvyggUFy/uNIiJ3d0lrM5RAlkoSb/isP203RLUCcVIE0FPJwMmVMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VpiJkLrw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783F6075DCA
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2783F6075DCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VpiJkLrw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwgsqdDFi6j72xqy8KQnJHvcekbrjxloo6a3OBytt8eARga8HyhD6TmEPXJ4Rx9rinjzlkoZcCjqRzOyz8ZiTOrdy2qnTfk4WcTMR8crvXBIBafrqycyWL0XjvpbG2litvW2BLBFMSHrU24F2va00zDkg7QZOrBWXVTN5a+1dLA4KiR12Fcv/sSG0XPWk5F5eviOcTB2iNyd6b7W5TvW+W1mKPzwhGRFOyLgtotWqrNYNNsmj/gu3YLuZJMqYb4Ed0tu2TDCIlO6eFphjUH6jZm1tw1XU7LJMMzxr/Q0LZdBimYBrnVz0cCOFgAczKusTofjEEaf32M0SPX665slLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyvBlJfrkoDDza2jjP3oC5N2lihedHzRT++WbEUI6iw=;
 b=KNxT8n45v/0cDiR2jOoCvrHhhhNT0HskeFK7EJSIvdOD0nwP+ac4tQ23VNeURNIZT7wcWkKHx43CoxR77r9yDptK3fAoVKIHA+rRfHZI55nmGKJNAqFAqhJ+rGM+AJXFrleqpnHaQ2jQMY3I4/X9fV1rMQOQZcYVFZpyolRig1RxjQ2bSbPdZlD0GyUrs1doLObntm1Tm/WWwcAMBV+XEDh5z/KpISwKpeAYNF171UUC2GmXvouRocthVYT3heDhz/eMejtLQLxAr2jnXWOJLiGI+hrCWf+Ps7rjVElnBhm+KyvXX+prsSl+j9I14U+a8Uv/qS+qvn1skrUlq4qS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyvBlJfrkoDDza2jjP3oC5N2lihedHzRT++WbEUI6iw=;
 b=VpiJkLrwrAxSZ5Zs776vCPkhcOmy0Dm9TctYTznTvQUnu5y04Xcr1qbYmcY2tJxfcnsSMz2sYx0UAOB5T3S3jfaLLU+vvxNM5JZ9mY4OriYErpR6KgwFlN8mYCpUgODzB3glta6j1vGbM5O1fkTg2H4s8MlfarHf1LK8LYOsB18=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 21:20:04 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::22) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 21:20:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:04 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:20:02 -0600
From: Eric Joyner <eric.joyner@amd.com>
Date: Wed, 4 Nov 2026 13:19:44 -0800
Subject: [PATCH net-next v3 3/5] ionic: map the FEC type through a helper
 in ionic_get_fecparam()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-ionic-get-fec-stats-v3-3-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
In-Reply-To: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 49842275-4d61-4c23-5502-08df3ab964df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|10067099003|18002099003|56012099006|261022075727099003|11063799006|261026121527099003|261102123227099003|261021123027099003|261009223027099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	ZHqkutOE5CpvRN4avdZhw/D3XedTQX4Ycrz9gkFtESIP5ng/61e/lkCjfigeAqf8tNCKYqsaJQvVSGRdUv/dK/py+76O9xA8puzluqjvkbfbRsv53PMKzHM1vDjlrgMcqk86BEEPiyt/Hvg8PYjuaxL8513e9StQ8AjyQv3GC/1cp6I0GtCYtyAOTrC+Gb6pahTqhbgw19xTsjQ8dVx4Y4b5rtxbCtqXAcMmb/9fU5jg3IrKa2AiHIswxmkpKViMde2SN1thvRqm5WkSGrCIhlh2b80SFQxYqQ+ZvzlqoJ7qfNaeKNU9/rd6Ai/7zDwPW4kdzhHkALsx/LNp4QQNSi0GbsTcIc2tl0coBZt7xinglP609+eNsksyzaat5SMHwDA87IXEBawaIdbNy/hwOncIIuoAKL7PwoRRPA0SPkvxOZSdoVsrfAoSwZ90CEc2RE2coeZOYMXDBUKgfQ4vOOTeLs83ob7Evg2aVqZebZxMSBxde7KnxSaCP0RKIiGPUIvrrjL8jzZVNhl+BrYkgbL2/fDcJUwnOLbaK7NYQie+lnYh1/R5TedMbQVLW4fF5871TC5saFd5o5aOyjfRR6WzHddbcFd8nPyoQXCc5ohoMfiNV9h6CKVOEZdqyBf7Sp7UWKZjO8HKzHd88Tw7Xwjw/4S3UlDhOJ2MqSgFKIWPpvygkr6jirettdi5tl0J/8BPW6o/qW1zI7noOOxAOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(10067099003)(18002099003)(56012099006)(261022075727099003)(11063799006)(261026121527099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X8mwyjazlthUi316DcdjQGa3Bdj5mUp0Lo4gkabijnAa3jzNyfGquDUJquZFNHXN9Z8MR7jRaVd7crq/mk9uGUtPHBpBX6DAb24u8PRbvyjk4Xco/Z8VYl31vgAhmuTf1IsPdjwxV9mQjYeP1cFvfNesNEimkosq6DSH89VHyculyL3DKROnaee7xaGj0EKCaVZZLycifeR5l0mKZSnPAphtzoVTRExB8p4rh0oHHbpQxhBGeKAkbHWjAG6TXFaYhVmnFCqTuDjXQz6QtoYdE4hkEV+TRdTOP4OfAK6oM5E2Mv4Qwf5gBVJKZd/x4gpS/Bkbd+z5EnE4oY0g1Av/8iXh4Iad8aMcMTQ4nomnm0Jzk/UIRyD0CXfTScZDSaMnMCFoGRYH8NFY5kCyHlpXfqaOcQMqMdXwhmz0ykgtSjMpzP5VVYWakCTvp07/Z0Fu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:04.5069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49842275-4d61-4c23-5502-08df3ab964df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

From: "Nikhil P. Rao" <nikhil.rao@amd.com>

ionic_get_fecparam() maps config.fec_type onto the ethtool FEC values
with a switch that assigns both fec->active_fec and fec->fec in each
arm.  A later patch gives the two fields distinct sources, which would
mean duplicating the switch.

Move the mapping into ionic_fec_type_to_ethtool() and call it once per
field.

No functional change.

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 34 +++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 317dbf96964e..bf7c70438a8c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -419,25 +419,31 @@ static int ionic_set_pauseparam(struct net_device *netdev,
 	return 0;
 }
 
-static int ionic_get_fecparam(struct net_device *netdev,
-			      struct ethtool_fecparam *fec)
+static u32 ionic_fec_type_to_ethtool(u8 fec_type)
 {
-	struct ionic_lif *lif = netdev_priv(netdev);
-
-	switch (lif->ionic->idev.port_info->config.fec_type) {
+	switch (fec_type) {
 	case IONIC_PORT_FEC_TYPE_NONE:
-		fec->active_fec = ETHTOOL_FEC_OFF;
-		fec->fec = ETHTOOL_FEC_OFF;
-		break;
+		return ETHTOOL_FEC_OFF;
 	case IONIC_PORT_FEC_TYPE_RS:
-		fec->active_fec = ETHTOOL_FEC_RS;
-		fec->fec = ETHTOOL_FEC_RS;
-		break;
+		return ETHTOOL_FEC_RS;
 	case IONIC_PORT_FEC_TYPE_FC:
-		fec->active_fec = ETHTOOL_FEC_BASER;
-		fec->fec = ETHTOOL_FEC_BASER;
-		break;
+		return ETHTOOL_FEC_BASER;
+	default:
+		return 0;
 	}
+}
+
+static int ionic_get_fecparam(struct net_device *netdev,
+			      struct ethtool_fecparam *fec)
+{
+	struct ionic_port_info *port_info;
+	struct ionic_lif *lif;
+
+	lif = netdev_priv(netdev);
+	port_info = lif->ionic->idev.port_info;
+
+	fec->active_fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
+	fec->fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
 
 	return 0;
 }

-- 
2.53.0

