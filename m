Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793541677;
	b=w04HyvQGuKnJagnpdExssDxVvVthH58txM360WNcj73kFl02HJtLT6ZGTkhK8Qtc9fsy
	 Y3SLaER+BVn2ShJRih9jKqUGt3pnbH+ZgcmpWVfSYeAA1553FkND05A1h74fiYz8J/+cr
	 35Hc0l7/qFwLDVvXCa7oEClLuBTb+TvP+WQFQs1ZjJ1yDYdX2hA9ZqFlC29/embi1V9bB
	 mLLX68iYDtyhZPQpV7iJUWjekXNNm+N5fKaJIwTp0mux3o5vn4oM+yFNOgc29WsDGPRka
	 QQUSixK1fFSQrwixM489pVnGeW9ZadbQAz0U+RVF5mKuDOrIt0g+JvvpcmxLaD+RPJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541677;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cDYjPZnonZN9d6uzR4v0LxO+kizDflyOXSR78WdF9C8=;
	b=JE8RrPZoRGQ5ZSIYG50zibBYerEe2i4zutltiDAwhe5CIuGLH5POi06aRaZKB60yje0o
	 984somh3ksyJ7oaW/RAqUj7NkdxOJHopBcslpmNgLcxvbo9zSpj1E56q5NVkPfuxoOaRw
	 FUr2JUrr293wgCOmPXpKBAXKoACY+pwg4EPJOztHdncUACoPuIkJhg30cMI9HfJkWDjCA
	 UVAmeg+uXsLcd8O6/glt+atfTFFl5aaDSFUvVJGokA9p071om7XY868N3Sw2LV7c8qOlh
	 ynTt2/kUBQ5K3GygJleE+SPCC27h4RL6+5Ck9Z2GF24Fdef5054pyCmB1OKd2tJnsxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=V7aAOLPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.97
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022097.outbound.protection.outlook.com [40.107.209.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B8606A327;
	Sun,  1 Nov 2026 14:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9B8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=V7aAOLPV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OczEOkqEnqmDQjrtk/BEO1VD9C6LyszPoKNkps+Sc7AHVDYZNZubffu0Xn0e9AqQ0fMdPV08JccPCgCdnzhxycK0T3mUeYWw91V3vt4OJ8y2stYzPxiQVg1oZc7CyUsFmd47GJsbhmTE3phzyCKKoyWqkyRNLfPRwpA/vVaFCgUe13FJcgw147PLns1d6gwQUQqXXdPdE+gPKnoKb5Y2XpnzNp2+SJbQlnmdREgxDm1lwZvzwWJV+FLqqrQ7hAhFyl5wBZ1zPWtEFwLiPDA+r/D7upvczKUDRVaSlXnHhLx7xqYpMwPp7xRj4/IbhOMOnh0Wru+ihEyazyF16ABxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDYjPZnonZN9d6uzR4v0LxO+kizDflyOXSR78WdF9C8=;
 b=v2ri7Ib4mqj1PuWkyY80eh2LqRC66nFZbNIc+bELswg2PgRtO5zE1D/pmmJgmZdw3r5zLPN/+MUX2CUs2lnvddkounZIXgyahP6tazdpVXYCBpg6an5UuqzOege+7QTNt4qS6UnMtJgnj1g3gh2uQj0RLrATbkEFeMdjVjF9fKO/xQCUo3OpQWmWA9LXlP179te6yIdnORbjPefKHk1sygVvTG4cf1KXwotKEQNUMHMBHgqXYg7FQe4FilQJ+/IZEpCqU98q4XnQ821opAE2B4WDIU5bkGQJrw63GlMTqt8m6seCc+LMYSa3QZoavrGU8szZ7kDEEbX/pcNfTOHbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDYjPZnonZN9d6uzR4v0LxO+kizDflyOXSR78WdF9C8=;
 b=V7aAOLPVG9tDIfqpmRdXZaKUSlJZAGPi78HokLxXLJZacvrPP9t9Z9qWjdHx3/lfZu/bSAsaG3kYjO/CmA2MQBKpyxL/IQ5wUSTJm68BgNSpCAt2gUeCFEtWW64DqIpDjNHzpE7doaJFrPNhY49ZvE08iqs9Rz2/Crm4+lBsPFRbdcuK97b9zshgZb/iZIxjlu62f+tP58+yDcj8NXQM2Xo0OqHQrrd08+NYYixXJid1xHeuTSQLwiK2pSEgDVw8yojeLgTS1jSZBojPyCIzWH9SWpa62ucP+ODOpUw88lsxIu9DLbXsTcLphPsnBt3xQFunROyedHTnIfG2yxCHsA==
Received: from BN9PR03CA0100.namprd03.prod.outlook.com (2603:10b6:408:fd::15)
 by LV8PR18MB5781.namprd18.prod.outlook.com (2603:10b6:408:1ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 14:01:08 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::99) by BN9PR03CA0100.outlook.office365.com
 (2603:10b6:408:fd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sun, 1
 Nov 2026 14:01:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Sun, 1 Nov 2026 14:01:07 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id C07084186B59;
	Sun,  1 Nov 2026 06:01:06 -0800 (PST)
From: Akhila Kavi <akavi@axiado.com>
Date: Sun, 01 Nov 2026 06:00:58 -0800
Subject: [PATCH net-next 2/2] net: mctp: Add Axiado AX3005 IRoT MCTP
 transport driver
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
Message-Id: <20261101-mctp-transport-irot-ax3005-v1-2-36ceb822f01e@axiado.com>
References: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
To: Sammai Chakravarthy <schakravarthy@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tzu-Hao Wei <twei@axiado.com>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Akhila Kavi <akavi@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=36085; i=akavi@axiado.com;
 h=from:subject:message-id; bh=X1zMNCQBPH7LLapuezbVkcy2r5jYIxc9cDiJqQKeJJQ=;
 b=owEB7QES/pANAwAKAaZBpzlrM+NgAcsmYgBq50YiXTApWCOaVde8GNRRtmEPeVTIVePLmyfGP
 JttYbj+9dGJAbMEAAEKAB0WIQQZuAZ2jpLwmauYGXqmQac5azPjYAUCaudGIgAKCRCmQac5azPj
 YOUVC/9Dvcsxxfzgm6UWBSZzQpK0ZfNsLlXtE0/FSjJuwHPFkwRRtDy/5hJ8JiKZJoGcIBk1pTn
 PEeR9KSs8N7IFdsBxjsc8eyImaTxN5GZTwvTzlu34aL7OZR0n2hIVQQYv+elNvu4VTcWqkF9qjW
 h4ZZHsSigAuXSwaO3W9HZXhuThkqmH1v9mXBnrbiz7NbEAWyWT5ryjRNVNzjDPR8Fh3i/+RaKJZ
 LrWQeTkS+r9Y+rWCIdKCqdjWxxxTy5txZkjQa37T8Z62znS/JwCYMvloK5GUdrAXEdOk5kI2Cc1
 ZygDwIXTmQWvHvi7lYdw/U4Xj6H/cPRp906cTlMHNX5rYMQiKMZuYAVZEn5axQ8ARRahezZz3pC
 YkaKcsDDCiXcBhquVoCDXn2y/H5J5+FVqUC2DysABjHUgClRE0wRYU3kcByOKbNIc5ritLyH996
 R8vpsf1XMqKXW2Ssn3G5Gshj309/AAZbVcq05CxaIzGfeYSF7ES4rlp4bOT0oaHQRiROU=
X-Developer-Key: i=akavi@axiado.com; a=openpgp;
 fpr=19B806768E92F099AB98197AA641A7396B33E360
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|LV8PR18MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 448359bf-a9fe-4c0d-7b93-08df382093a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|36860700016|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|921020|56012099006|5023799004|261026135527099003|261021121427099003|261021123027099003|261026121527099003|261021133027099003|261021135927099003|261021130227099003|261022115727099003|261026140227099003|261022105027099003|261026130827099003|261022075727099003|261022113327099003|261009223027099003|261028144727099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	kb8GVXu9EOfsHqXZ9MpIFkkH/5eNnAt+0Skli6GPLdewah1yybGf5U928SdtjK08HE/yq/Zhs9EbpwUDnS9++RmzMHAW/NGDKZhfUniM7FC8VOBF6S9iClbKOgcTKfkhqFlUeAFzVkY07iZOAPtclJ2YaPv1oV7T9mhIAv1NmWHYSLL3nesBqWUOHKkqGK5cFU7uG0UvYcqUwcdTBZGFoM3y9vD2oeb5ODLlJmXKN0Mec5en9pTaQkx/CxXjKSJ2kE52+/Y9vT3tZCoIjcNpNCwGNPNDIfLpuhQbOS1zVmlcbtGr3IyQErziuAwCjx8n4UAhHglKVDsfaAfrGEDBwBHY69QsLj1b1YAH4uC3w5zHkoXpRXb+m2XIG67SM010eobEanYievOz4lFQ3w3/laTP0ZsUmU8h132caKx4aMTI2DBDBAURDsTQvcjocxXJeaff0SN07Z0MnRMPFWKwB/S7ULniwIS2EwqgYwan2ihG73pwJ0llEcmYRPGY3FtihzuWH2J7FU541iryS8D5hrTW1XJ8Fh+VHx3ZDrfhmKkSHNVwaPThvDeJSU7NrQ1q6qrV7wPqT/yYfsODWDay3P1Yu7tbJqQepZBzHiQ3EnCKjB/8wrwH8agj2dxVR6t9QMMFDOk0AdwOZH4vP5y3NiJ8CIKpUg+L4g9rzpX4ir3Za4iDzick9V3MSqSFZQCV8aG5ICx/xI5+DUmLkUmd0UdkKX80VetJwRBYeIK6RLsO8UTN2Bz/Ha7erxLd1uaT
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(56012099006)(5023799004)(261026135527099003)(261021121427099003)(261021123027099003)(261026121527099003)(261021133027099003)(261021135927099003)(261021130227099003)(261022115727099003)(261026140227099003)(261022105027099003)(261026130827099003)(261022075727099003)(261022113327099003)(261009223027099003)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oRXorA2JeertYARpk1eMfCFDwIr+zvc/bL+izMkuNDY+JZ4utG9rwyQIzZ8zadzQeLIdKcbIly9c88L7VWVC6r2Tv/tRcTlNXb+VUdMfVqYrea/Qkx5xyjJK5JLsq7Ub1C2CdCdSRTzGKK0LYwEFEyBoVyl2LSBSp/rFiUiCEl885UXoRXKIN34pm0aHMO7JsyFtgHu2YYda0lPMlaQfctfFb/NFe9rgZmkSprTqszyFvgSnOswZckM8fBa8FQFWw294mwDHa8ejHl9P2w8E6NjZkOZWjuswdXeXQsSeDlHsbHilFQg8FcTazx2Ld7KFb27voftHHtG6RzeSUoJ45Om+/ME/T8P5AjK5ayCKawo90I5mriHNwPMo+T8DgWjP7lu0YzgduNNYb7MYyL7lEEY3CYkz4F9wfCqCstGh1bHGyfJY2XpXfvohja0Zcu/8
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 14:01:07.4991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448359bf-a9fe-4c0d-7b93-08df382093a8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5781

Add an MCTP transport driver for the root-of-trust (IRoT) co-processor
on Axiado AX3005 SoCs. It registers an ARPHRD_MCTP point-to-point
netdev, mctpirot%d, with no physical addressing, so SPDM, PLDM and other
MCTP traffic to the IRoT runs over ordinary AF_MCTP sockets.

Packets are carried in shared memory. The mailbox only carries 48-byte
frames: the 16-byte header the mailbox controller and the IRoT firmware
expect, followed by a 32-byte IRoT message. The protocol is:

 - At probe, the driver sends cc_get_mctp_buffers. The IRoT answers
   with cc_mctp_buffer, which gives an MTU limit and two windows: one
   the host reads from and one it writes to. The driver checks that
   both windows lie inside the memory-region carve-out, do not
   overlap, and hold at least the 68-byte DSP0236 baseline MTU. It
   clamps the MTU to the window size.

 - Each direction has one packet in flight. The sender writes the
   packet into its window and rings the doorbell with cc_mctp, which
   carries a counter and the packet's span. The receiver copies the
   packet out and answers with cc_mctp_done for that counter. Only
   then may the sender reuse its window.

 - On RX, the packet is ACKed only after it has been handed to the
   network stack. A resend of the last delivered counter is ACKed
   again without being delivered twice.

 - On TX, the queue stays stopped until the ACK arrives. If no ACK
   arrives within 5 seconds, the carrier goes down and the window
   stays claimed, because the IRoT may still be reading it. A late ACK
   brings the link back up. There is no resync, so if the IRoT resets
   without answering, the driver must be rebound.

 - cc_ping is answered with cc_ping_rsp.

The mailbox RX callback runs in atomic context. It only records state
and defers all replies and netdev access to an ordered workqueue.

Signed-off-by: Akhila Kavi <akavi@axiado.com>
---
 MAINTAINERS                         |    1 +
 drivers/net/mctp/Kconfig            |   17 +
 drivers/net/mctp/Makefile           |    1 +
 drivers/net/mctp/axiado-mctp-irot.c | 1089 +++++++++++++++++++++++++++++++++++
 4 files changed, 1108 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b16248974044..db7ee24b2962 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4484,6 +4484,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/axiado,ax3005-mctp-irot.yaml
+F:	drivers/net/mctp/axiado-mctp-irot.c
 
 AXI SPI ENGINE
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index c40ac9c665b7..f0fa7f1ecbe1 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -3,6 +3,23 @@ if MCTP
 
 menu "MCTP Device Drivers"
 
+config MCTP_TRANSPORT_AXIADO_IROT
+	tristate "MCTP transport over the Axiado AX3005 IRoT mailbox"
+	depends on MAILBOX && OF && OF_RESERVED_MEM
+	depends on ARCH_AXIADO || COMPILE_TEST
+	help
+	  MCTP transport for the IRoT co-processor on Axiado AX3005 SoCs.
+	  Registers an MCTP network interface so SPDM, PLDM and NSM run as
+	  normal AF_MCTP socket traffic.
+
+	  Packets flow over two shared-memory windows; the mailbox only
+	  carries small doorbell and acknowledgment messages.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called axiado-mctp-irot.
+
+	  If unsure, say N.
+
 config MCTP_SERIAL
 	tristate "MCTP serial transport"
 	depends on TTY
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c870b62d3f1c..fe735012409d 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_AXIADO_IROT) += axiado-mctp-irot.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/axiado-mctp-irot.c b/drivers/net/mctp/axiado-mctp-irot.c
new file mode 100644
index 000000000000..d393a8102f2d
--- /dev/null
+++ b/drivers/net/mctp/axiado-mctp-irot.c
@@ -0,0 +1,1089 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Axiado AX3005 IRoT MCTP transport driver
+ *
+ * Copyright (c) 2026 Axiado Corporation.
+ */
+
+#include <linux/bottom_half.h>
+#include <linux/build_bug.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/jiffies.h>
+#include <linux/mailbox_client.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/wordpart.h>
+#include <linux/workqueue.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+/*
+ * Command codes. Even == request, odd == response. Zero is reserved and is
+ * never sent on the wire.
+ */
+enum irot_command_code {
+	IROT_CC_PING			= 2,
+	IROT_CC_PING_RSP		= 3,
+	IROT_CC_GET_MCTP_BUFFERS	= 4,
+	IROT_CC_MCTP_BUFFER		= 5,
+	IROT_CC_MCTP			= 6,
+	IROT_CC_MCTP_DONE		= 7,
+};
+
+/* 64-bit physical address split into two words to avoid padding. */
+struct irot_msg_address {
+	__le32 low;
+	__le32 high;
+};
+
+struct irot_msg_span {
+	struct irot_msg_address address;
+	__le32 size;
+};
+
+struct irot_msg_data_buffers {
+	__le32 mtu_limit;
+	struct irot_msg_span host_read;	 /* host reads RX packets here */
+	struct irot_msg_span host_write; /* host writes TX packets here */
+};
+
+struct irot_msg_data_mctp {
+	__le32 counter;			/* echoed back in the ACK */
+	struct irot_msg_span packet;	/* must lie inside its window */
+};
+
+union irot_msg_data {
+	__le32 value;			/* ping echo / mctp_done counter */
+	struct irot_msg_data_buffers buffers;
+	struct irot_msg_data_mctp mctp;
+};
+
+struct irot_msg {
+	__le32 command;
+	union irot_msg_data data;
+};
+
+static_assert(sizeof(struct irot_msg) == 32);
+
+/*
+ * One mailbox FIFO frame. @len is the Axiado mailbox controller's length
+ * word: the total frame size in bytes, including itself. The controller
+ * interprets nothing else. @type, @priority and @flag are defined by the
+ * IRoT firmware: the host sends them as zero and ignores them on receive.
+ * The 32-byte IRoT message follows.
+ */
+struct irot_mbox_frame {
+	__le32 len;
+	__le32 type;
+	__le32 priority;
+	__le32 flag;
+	struct irot_msg irot;
+};
+
+static_assert(sizeof(struct irot_mbox_frame) == 16 + sizeof(struct irot_msg),
+	      "irot_mbox_frame must be header + one IPC message");
+static_assert(sizeof(struct irot_mbox_frame) == 48,
+	      "irot_mbox_frame must be exactly 48 bytes");
+
+#define IROT_MBOX_TX_TOUT_MS		250
+#define IROT_TX_QUEUE_LEN		20
+#define IROT_TX_ACK_TIMEOUT_MS		5000
+#define IROT_BUFFER_RETRIES		3
+#define IROT_BUFFER_TIMEOUT_S		5
+/* DMTF DSP0236 section 8.3: baseline transmission unit */
+#define IROT_MCTP_MIN_MTU		68
+/* Caps the MTU and the size of one RX allocation */
+#define IROT_MCTP_MAX_MTU		2097152
+
+/* A shared-memory window in host byte order. */
+struct irot_region {
+	u64 base;
+	u32 size;
+};
+
+/* One inbound packet notification. */
+struct irot_rx_entry {
+	u32 counter;
+	u64 base;
+	u32 size;
+};
+
+enum irot_rx_result {
+	IROT_RX_DELIVERED,	/* handed to the stack: ACK */
+	IROT_RX_INVALID,	/* can never be delivered: ACK and drop */
+	IROT_RX_RETRY,		/* transient failure: no ACK, peer resends */
+};
+
+/*
+ * All driver state for one IRoT MCTP endpoint; the net_device private area.
+ *
+ * Flow control: each window holds one packet, and each side waits for
+ * cc_mctp_done before it reuses its window. So at most one packet is in
+ * flight per direction, and the RX side needs a single slot. A peer that does
+ * not see its cc_mctp_done in time resends the same counter.
+ *
+ * On TX the netdev queue is the only queue: xmit hands one skb to tx_work and
+ * stops the queue, and the queue is woken once the peer has ACKed it.
+ *
+ * The mailbox callback runs in atomic context; it only records state and
+ * queues work. All sends, and all netdev access, happen on @wq.
+ */
+struct irot_priv {
+	struct device		*dev;
+	struct net_device	*ndev;
+	struct workqueue_struct	*wq;
+
+	struct mbox_client	 cl;
+	struct mbox_chan	*chan_tx;
+	struct mbox_chan	*chan_rx;
+	struct mutex		 tx_chan_lock;	/* serialises chan_tx senders */
+	struct irot_mbox_frame	 tx_frame;	/* owned by tx_chan_lock */
+
+	/* shared memory, written once before the netdev is registered */
+	struct irot_region	 host_write;	/* AP writes, IRoT reads */
+	struct irot_region	 host_read;	/* IRoT writes, AP reads */
+	u32			 mtu;		/* largest packet either way */
+	bool			 buffers_valid;	/* rx_lock */
+	struct completion	 buffers_done;
+	struct resource		 pool_res;	/* memory-region carve-out */
+	void			*pool;
+	void			*tx_addr;
+	void			*rx_addr;
+
+	struct work_struct	 tx_work;	/* send tx_skb, or wake the queue */
+	struct delayed_work	 tx_timeout_work; /* cc_mctp_done overdue */
+	u32			 next_tx_counter; /* tx_work only */
+
+	spinlock_t		 tx_state_lock;	/* the TX fields below */
+	struct sk_buff		*tx_skb;	/* handed from xmit to tx_work */
+	bool			 pending_write;	/* window owned by a transfer */
+	bool			 tx_stalled;	/* ACK overdue, link down */
+	u32			 pending_tx_counter;
+
+	/* RX path; everything below is protected by rx_lock */
+	struct work_struct	 rx_work;
+	spinlock_t		 rx_lock;	/* the RX fields below */
+
+	struct irot_rx_entry	 rx_entry;
+	bool			 rx_busy;	/* rx_entry not yet answered */
+	bool			 rx_new;	/* rx_entry not yet picked up */
+
+	bool			 dup_ack_pending;
+	u32			 dup_ack_counter;
+
+	bool			 ping_pending;
+	u32			 ping_value;
+
+	/* Last counter handed to the stack */
+	bool			 has_last_rx_counter;
+	u32			 last_rx_counter;
+
+	/* Drops seen by the callback, folded into the stats by rx_work */
+	unsigned int		 rx_dropped;
+};
+
+/*
+ * Statistics are updated from the work items and from xmit. Every update
+ * from process context disables BHs, so the per-CPU update cannot be
+ * interrupted by xmit running in softirq on the same CPU.
+ */
+static void irot_tx_drop(struct irot_priv *p, struct sk_buff *skb)
+{
+	local_bh_disable();
+	dev_dstats_tx_dropped(p->ndev);
+	local_bh_enable();
+	dev_kfree_skb_any(skb);
+}
+
+static void irot_region_from_span(struct irot_region *r,
+				  const struct irot_msg_span *s)
+{
+	r->base = ((u64)le32_to_cpu(s->address.high) << 32) |
+		  le32_to_cpu(s->address.low);
+	r->size = le32_to_cpu(s->size);
+}
+
+static void irot_span_from_region(struct irot_msg_span *s,
+				  const struct irot_region *r)
+{
+	s->address.low  = cpu_to_le32(lower_32_bits(r->base));
+	s->address.high = cpu_to_le32(upper_32_bits(r->base));
+	s->size         = cpu_to_le32(r->size);
+}
+
+/*
+ * True only if [base, base + size) lies wholly inside @win, with no wrap.
+ * Returns the packet's offset into the window in @off.
+ */
+static bool irot_region_offset(const struct irot_region *win, u64 base,
+			       u32 size, u64 *off)
+{
+	if (base < win->base)
+		return false;
+
+	*off = base - win->base;
+
+	if (*off >= win->size)
+		return false;
+
+	return size <= win->size - *off;
+}
+
+/*
+ * Transmit one IPC message. tx_block is set, so the frame lives in driver
+ * state, owned by tx_chan_lock. The mailbox core keeps one tx-done
+ * completion per channel, so blocking senders must not overlap; the lock
+ * serialises probe against the work items.
+ * Sleeps: never call this from the RX callback.
+ */
+static int irot_send(struct irot_priv *p, const struct irot_msg *msg)
+{
+	guard(mutex)(&p->tx_chan_lock);
+
+	memset(&p->tx_frame, 0, sizeof(p->tx_frame));
+	p->tx_frame.len = cpu_to_le32(sizeof(p->tx_frame));
+	memcpy(&p->tx_frame.irot, msg, sizeof(*msg));
+
+	return mbox_send_message(p->chan_tx, &p->tx_frame);
+}
+
+static void irot_send_done(struct irot_priv *p, u32 counter)
+{
+	struct irot_msg ack = {};
+	int rc;
+
+	ack.command    = cpu_to_le32(IROT_CC_MCTP_DONE);
+	ack.data.value = cpu_to_le32(counter);
+
+	rc = irot_send(p, &ack);
+	if (rc < 0)
+		dev_warn_ratelimited(p->dev, "Failed to ACK RX counter %u: %d\n",
+				     counter, rc);
+}
+
+/*
+ * Release the window for @counter and let tx_work wake the queue. Called from
+ * the mailbox callback on cc_mctp_done, and from tx_work when a send fails.
+ */
+static void irot_tx_mark_done(struct irot_priv *p, u32 counter)
+{
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		if (!p->pending_write || p->pending_tx_counter != counter)
+			return;
+
+		p->pending_write = false;
+	}
+
+	cancel_delayed_work(&p->tx_timeout_work);
+	queue_work(p->wq, &p->tx_work);
+}
+
+static int irot_tx_mark_pending(struct irot_priv *p, u32 counter)
+{
+	guard(spinlock_irqsave)(&p->tx_state_lock);
+
+	if (p->pending_write)
+		return -EBUSY;
+
+	p->pending_tx_counter = counter;
+	p->pending_write = true;
+
+	return 0;
+}
+
+static bool irot_tx_ready(struct irot_priv *p)
+{
+	guard(spinlock_irqsave)(&p->tx_state_lock);
+
+	return !p->pending_write && !p->tx_stalled && !p->tx_skb;
+}
+
+/*
+ * The peer owes us an ACK and has not sent it: take the link down. The queue
+ * is already stopped, and the window stays claimed, because the peer may still
+ * be reading it; only a late cc_mctp_done releases it.
+ *
+ * There is no resync: if the IRoT resets and never answers the outstanding
+ * counter, the link stays down until the driver is rebound.
+ */
+static void irot_tx_stall(struct irot_priv *p, const char *why)
+{
+	u32 counter;
+
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		if (!p->pending_write || p->tx_stalled)
+			return;
+		p->tx_stalled = true;
+		counter = p->pending_tx_counter;
+	}
+
+	netif_carrier_off(p->ndev);
+
+	dev_warn(p->dev, "TX counter %u: %s, taking link down\n", counter, why);
+}
+
+/* The window is free again: end a stall, and let the stack send. */
+static void irot_tx_wake(struct irot_priv *p)
+{
+	bool recovered = false;
+
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		if (p->pending_write || p->tx_skb)
+			return;
+
+		if (p->tx_stalled) {
+			p->tx_stalled = false;
+			recovered = true;
+		}
+
+		/*
+		 * Wake under the lock: xmit stops the queue and hands over its
+		 * skb under it too, so the wake cannot land in between.
+		 */
+		if (netif_running(p->ndev))
+			netif_wake_queue(p->ndev);
+	}
+
+	if (recovered) {
+		dev_dbg(p->dev, "late TX ACK arrived, link up\n");
+		netif_carrier_on(p->ndev);
+	}
+}
+
+/* cc_mctp_buffer: the peer's windows. Write-once; zero mtu means no answer. */
+static void irot_cb_buffer_rsp(struct irot_priv *p, const struct irot_msg *m)
+{
+	u32 mtu = le32_to_cpu(m->data.buffers.mtu_limit);
+
+	scoped_guard(spinlock_irqsave, &p->rx_lock) {
+		if (!p->buffers_valid && mtu) {
+			irot_region_from_span(&p->host_write,
+					      &m->data.buffers.host_write);
+			irot_region_from_span(&p->host_read,
+					      &m->data.buffers.host_read);
+			p->mtu = mtu;
+			p->buffers_valid = true;
+		}
+	}
+
+	complete(&p->buffers_done);
+}
+
+/*
+ * cc_mctp: an inbound packet is sitting in host_read. Never ACKs from here;
+ * that is rx_work's job once the packet has been handed to the stack.
+ */
+static void irot_cb_mctp(struct irot_priv *p, const struct irot_msg *m)
+{
+	struct irot_rx_entry e;
+	bool wake = false;
+
+	e.counter = le32_to_cpu(m->data.mctp.counter);
+	e.size    = le32_to_cpu(m->data.mctp.packet.size);
+	e.base    = ((u64)le32_to_cpu(m->data.mctp.packet.address.high) << 32) |
+		    le32_to_cpu(m->data.mctp.packet.address.low);
+
+	scoped_guard(spinlock_irqsave, &p->rx_lock) {
+		if (p->has_last_rx_counter && e.counter == p->last_rx_counter) {
+			/* Resend of a delivered packet: our ACK was missed */
+			p->dup_ack_counter = e.counter;
+			p->dup_ack_pending = true;
+			wake = true;
+		} else if (p->rx_busy) {
+			/*
+			 * A resend of the packet in rx_entry gets its ACK once
+			 * that is delivered. Anything else breaks the one
+			 * packet in flight rule; drop it unanswered and the
+			 * peer resends.
+			 */
+			if (e.counter != p->rx_entry.counter) {
+				p->rx_dropped++;
+				wake = true;
+			}
+		} else {
+			p->rx_entry = e;
+			p->rx_busy = true;
+			p->rx_new = true;
+			wake = true;
+		}
+	}
+
+	if (wake)
+		queue_work(p->wq, &p->rx_work);
+}
+
+static void irot_cb_ping(struct irot_priv *p, const struct irot_msg *m)
+{
+	/* Liveness only: a newer ping supersedes an unanswered one */
+	scoped_guard(spinlock_irqsave, &p->rx_lock) {
+		p->ping_pending = true;
+		p->ping_value = le32_to_cpu(m->data.value);
+	}
+
+	queue_work(p->wq, &p->rx_work);
+}
+
+/*
+ * Runs in the mailbox controller's delivery context: never sleeps, never
+ * touches the netdev, and defers every reply to the work items. @data points
+ * at the controller's frame buffer, which is only refreshed for the length
+ * the peer sent.
+ */
+static void irot_rx_callback(struct mbox_client *cl, void *data)
+{
+	struct irot_priv *p = container_of(cl, struct irot_priv, cl);
+	const struct irot_mbox_frame *frame = data;
+	const struct irot_msg *m = &frame->irot;
+
+	if (le32_to_cpu(frame->len) != sizeof(*frame)) {
+		dev_warn_ratelimited(p->dev, "bad mailbox frame length %u\n",
+				     le32_to_cpu(frame->len));
+		return;
+	}
+
+	switch (le32_to_cpu(m->command)) {
+	case IROT_CC_MCTP_BUFFER:
+		irot_cb_buffer_rsp(p, m);
+		break;
+	case IROT_CC_MCTP:
+		irot_cb_mctp(p, m);
+		break;
+	case IROT_CC_MCTP_DONE:
+		irot_tx_mark_done(p, le32_to_cpu(m->data.value));
+		break;
+	case IROT_CC_PING:
+		irot_cb_ping(p, m);
+		break;
+	default:
+		dev_warn_ratelimited(p->dev, "unknown IRoT command %u\n",
+				     le32_to_cpu(m->command));
+		break;
+	}
+}
+
+/* tx_block: mbox_send_message() waits for the controller's tx-done. */
+static int irot_request_mbox(struct irot_priv *p)
+{
+	p->cl.dev          = p->dev;
+	p->cl.rx_callback  = irot_rx_callback;
+	p->cl.tx_block     = true;
+	p->cl.knows_txdone = false;
+	p->cl.tx_tout      = IROT_MBOX_TX_TOUT_MS;
+
+	p->chan_tx = mbox_request_channel_byname(&p->cl, "tx");
+	if (IS_ERR(p->chan_tx))
+		return dev_err_probe(p->dev, PTR_ERR(p->chan_tx),
+				     "Failed to request tx mailbox channel\n");
+
+	p->chan_rx = mbox_request_channel_byname(&p->cl, "rx");
+	if (IS_ERR(p->chan_rx)) {
+		mbox_free_channel(p->chan_tx);
+		return dev_err_probe(p->dev, PTR_ERR(p->chan_rx),
+				     "Failed to request rx mailbox channel\n");
+	}
+
+	return 0;
+}
+
+/*
+ * The IRoT picks the windows and reports them over the mailbox, but must
+ * place them inside the memory-region carve-out. Anything outside it is
+ * rejected; a window inside it is addressed as an offset into the one mapping.
+ */
+static void *irot_window_in_pool(struct irot_priv *p,
+				 const struct irot_region *r, const char *name)
+{
+	u64 off;
+
+	if (r->base < p->pool_res.start)
+		goto outside;
+
+	off = r->base - p->pool_res.start;
+	if (off >= resource_size(&p->pool_res) ||
+	    r->size > resource_size(&p->pool_res) - off)
+		goto outside;
+
+	return p->pool + off;
+
+outside:
+	return ERR_PTR(dev_err_probe(p->dev, -EINVAL,
+				     "%s window 0x%llx+%u outside memory-region %pR\n",
+				     name, r->base, r->size, &p->pool_res));
+}
+
+static int irot_map_pool(struct irot_priv *p)
+{
+	int rc;
+
+	rc = of_reserved_mem_region_to_resource(p->dev->of_node, 0, &p->pool_res);
+	if (rc)
+		return dev_err_probe(p->dev, rc, "Missing memory-region\n");
+
+	p->pool = devm_memremap(p->dev, p->pool_res.start,
+				resource_size(&p->pool_res), MEMREMAP_WC);
+	if (IS_ERR(p->pool))
+		return dev_err_probe(p->dev, PTR_ERR(p->pool),
+				     "Failed to map memory-region %pR\n",
+				     &p->pool_res);
+
+	return 0;
+}
+
+/*
+ * Ask the peer for its windows, up to IROT_BUFFER_RETRIES times, then
+ * bounds-check them against the memory-region.
+ *
+ * The IRoT is expected to be up before Linux probes this device. If it does
+ * not answer within IROT_BUFFER_RETRIES * IROT_BUFFER_TIMEOUT_S, probe fails
+ * for good; rebinding the driver retries. Probe is asynchronous, so the wait
+ * does not hold up boot.
+ */
+static int irot_discover_buffers(struct irot_priv *p)
+{
+	struct irot_msg req = {};
+	bool got = false;
+	int i, rc;
+	u32 cap;
+
+	req.command = cpu_to_le32(IROT_CC_GET_MCTP_BUFFERS);
+
+	for (i = 0; i < IROT_BUFFER_RETRIES && !got; i++) {
+		reinit_completion(&p->buffers_done);
+
+		rc = irot_send(p, &req);
+		if (rc < 0)
+			return dev_err_probe(p->dev, rc,
+					     "Failed to send cc_get_mctp_buffers\n");
+
+		wait_for_completion_timeout(&p->buffers_done,
+					    secs_to_jiffies(IROT_BUFFER_TIMEOUT_S));
+
+		scoped_guard(spinlock_irqsave, &p->rx_lock)
+			got = p->buffers_valid;
+	}
+
+	if (!got)
+		return dev_err_probe(p->dev, -ETIMEDOUT,
+				     "No cc_mctp_buffer after %d attempts\n",
+				     IROT_BUFFER_RETRIES);
+
+	/* A window holds exactly one packet, so it also caps the MTU */
+	cap = min3(p->host_read.size, p->host_write.size, IROT_MCTP_MAX_MTU);
+	if (cap < IROT_MCTP_MIN_MTU)
+		return dev_err_probe(p->dev, -EINVAL,
+				     "windows hold %u bytes, below the MCTP minimum MTU %u\n",
+				     cap, IROT_MCTP_MIN_MTU);
+
+	if (p->mtu < IROT_MCTP_MIN_MTU)
+		return dev_err_probe(p->dev, -EINVAL,
+				     "mtu_limit %u below the MCTP minimum %u\n",
+				     p->mtu, IROT_MCTP_MIN_MTU);
+
+	if (p->mtu > cap) {
+		dev_warn(p->dev, "mtu_limit %u exceeds the windows (%u), clamping\n",
+			 p->mtu, cap);
+		p->mtu = cap;
+	}
+
+	p->rx_addr = irot_window_in_pool(p, &p->host_read, "host_read");
+	if (IS_ERR(p->rx_addr))
+		return PTR_ERR(p->rx_addr);
+
+	p->tx_addr = irot_window_in_pool(p, &p->host_write, "host_write");
+	if (IS_ERR(p->tx_addr))
+		return PTR_ERR(p->tx_addr);
+
+	/* Both lie inside the pool, so neither end can wrap */
+	if (p->host_read.base < p->host_write.base + p->host_write.size &&
+	    p->host_write.base < p->host_read.base + p->host_read.size)
+		return dev_err_probe(p->dev, -EINVAL,
+				     "host_read and host_write windows overlap\n");
+
+	dev_dbg(p->dev, "windows: read 0x%llx+%u, write 0x%llx+%u, mtu %u\n",
+		p->host_read.base, p->host_read.size,
+		p->host_write.base, p->host_write.size, p->mtu);
+
+	return 0;
+}
+
+/*
+ * Copy one inbound packet out of host_read and hand it to the stack. Drops
+ * that the core does not count itself are added to @dropped.
+ */
+static enum irot_rx_result irot_rx_deliver(struct irot_priv *p,
+					   const struct irot_rx_entry *e,
+					   unsigned int *dropped)
+{
+	struct sk_buff *skb;
+	u64 off;
+
+	/*
+	 * host_read bounds the packet, not the negotiated MTU: with asymmetric
+	 * windows the peer may send more than p->mtu. The cap only stops an
+	 * oversized window from turning into an allocation that fails on every
+	 * resend.
+	 */
+	if (!e->size || e->size > IROT_MCTP_MAX_MTU ||
+	    !irot_region_offset(&p->host_read, e->base, e->size, &off)) {
+		dev_warn_ratelimited(p->dev,
+				     "invalid RX span 0x%llx+%u (window 0x%llx+%u)\n",
+				     e->base, e->size, p->host_read.base,
+				     p->host_read.size);
+		(*dropped)++;
+		return IROT_RX_INVALID;
+	}
+
+	/* ACK and drop: the peer must not be left holding its window */
+	if (!netif_running(p->ndev)) {
+		(*dropped)++;
+		return IROT_RX_INVALID;
+	}
+
+	skb = netdev_alloc_skb(p->ndev, e->size);
+	if (!skb) {
+		(*dropped)++;
+		return IROT_RX_RETRY;
+	}
+
+	/*
+	 * Order the payload read after the doorbell that announced it; pairs
+	 * with the IRoT's write barrier before it rang the doorbell.
+	 */
+	dma_rmb();
+
+	skb_put_data(skb, (u8 *)p->rx_addr + off, e->size);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	__mctp_cb(skb)->halen = 0;
+
+	/* The core counts the drop itself */
+	if (netif_rx(skb) != NET_RX_SUCCESS)
+		return IROT_RX_RETRY;
+
+	return IROT_RX_DELIVERED;
+}
+
+/*
+ * RX work: answers pings, re-ACKs resends of delivered packets, and delivers
+ * new packets. A packet is ACKed only after the stack has it, and the dedup
+ * cursor moves only then, so a packet that could not be delivered is
+ * delivered when the peer resends it. The callback requeues this work for
+ * every message, so one pass per run is enough.
+ */
+static void irot_rx_work(struct work_struct *work)
+{
+	struct irot_priv *p = container_of(work, struct irot_priv, rx_work);
+	enum irot_rx_result res;
+	struct irot_rx_entry e;
+	bool do_ping, do_ack, do_rx;
+	unsigned int dropped;
+	u32 ping_value;
+	u32 ack_counter;
+
+	scoped_guard(spinlock_irqsave, &p->rx_lock) {
+		do_ping = p->ping_pending;
+		ping_value = p->ping_value;
+		p->ping_pending = false;
+
+		do_ack = p->dup_ack_pending;
+		ack_counter = p->dup_ack_counter;
+		p->dup_ack_pending = false;
+
+		/* rx_busy stays set until the packet is answered */
+		do_rx = p->rx_new;
+		e = p->rx_entry;
+		p->rx_new = false;
+
+		dropped = p->rx_dropped;
+		p->rx_dropped = 0;
+	}
+
+	if (do_ping) {
+		struct irot_msg rsp = {};
+		int rc;
+
+		rsp.command    = cpu_to_le32(IROT_CC_PING_RSP);
+		rsp.data.value = cpu_to_le32(ping_value);
+
+		rc = irot_send(p, &rsp);
+		if (rc < 0)
+			dev_warn_ratelimited(p->dev, "Failed to answer ping: %d\n",
+					     rc);
+	}
+
+	if (do_ack)
+		irot_send_done(p, ack_counter);
+
+	if (do_rx) {
+		res = irot_rx_deliver(p, &e, &dropped);
+
+		scoped_guard(spinlock_irqsave, &p->rx_lock) {
+			p->rx_busy = false;
+			if (res == IROT_RX_DELIVERED) {
+				p->last_rx_counter = e.counter;
+				p->has_last_rx_counter = true;
+			}
+		}
+	}
+
+	local_bh_disable();
+	if (dropped)
+		dev_dstats_rx_dropped_add(p->ndev, dropped);
+	if (do_rx && res == IROT_RX_DELIVERED)
+		dev_dstats_rx_add(p->ndev, e.size);
+	local_bh_enable();
+
+	/* Withhold the ACK and the peer resends */
+	if (do_rx && res != IROT_RX_RETRY)
+		irot_send_done(p, e.counter);
+}
+
+/*
+ * TX work: write the skb handed over by xmit into host_write and ring the
+ * doorbell. The queue stays stopped until the peer ACKs; an overdue ACK
+ * stalls the link rather than freeing the window under the peer's feet.
+ * With no skb to send, it was kicked because the window came free.
+ */
+static void irot_tx_work(struct work_struct *work)
+{
+	struct irot_priv *p = container_of(work, struct irot_priv, tx_work);
+	struct irot_msg m = {};
+	struct sk_buff *skb;
+	u32 tx_counter;
+	u32 len;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		skb = p->tx_skb;
+		p->tx_skb = NULL;
+	}
+
+	if (!skb) {
+		irot_tx_wake(p);
+		return;
+	}
+
+	/*
+	 * Claim the window before writing it, so a cc_mctp_done that arrives
+	 * immediately still matches an in-flight counter. xmit only runs once
+	 * the window is free, so this cannot fail.
+	 */
+	tx_counter = p->next_tx_counter;
+	if (WARN_ON_ONCE(irot_tx_mark_pending(p, tx_counter))) {
+		irot_tx_drop(p, skb);
+		return;
+	}
+	p->next_tx_counter++;
+
+	/* skb_copy_bits() handles nonlinear skbs */
+	len = skb->len;
+	if (skb_copy_bits(skb, 0, p->tx_addr, len)) {
+		irot_tx_mark_done(p, tx_counter);
+		irot_tx_drop(p, skb);
+		return;
+	}
+
+	/* Publish the payload before ringing the doorbell */
+	dma_wmb();
+
+	m.command = cpu_to_le32(IROT_CC_MCTP);
+	m.data.mctp.counter = cpu_to_le32(tx_counter);
+	/* Always at the start of host_write: one outstanding write */
+	irot_span_from_region(&m.data.mctp.packet,
+			      &(struct irot_region){
+				      .base = p->host_write.base,
+				      .size = len,
+			      });
+
+	/* Arm before sending, so an immediate cc_mctp_done cancels it */
+	mod_delayed_work(p->wq, &p->tx_timeout_work,
+			 msecs_to_jiffies(IROT_TX_ACK_TIMEOUT_MS));
+
+	rc = irot_send(p, &m);
+	if (rc == -ETIME) {
+		/*
+		 * The controller has queued the message but the FIFO did not
+		 * drain in time; the peer may still consume it, so keep the
+		 * window claimed.
+		 */
+		irot_tx_drop(p, skb);
+		irot_tx_stall(p, "mailbox send timed out");
+		return;
+	}
+	if (rc < 0) {
+		/* Nothing left the controller: the window is ours */
+		dev_err_ratelimited(p->dev, "TX send failed: %d\n", rc);
+		irot_tx_mark_done(p, tx_counter);
+		irot_tx_drop(p, skb);
+		return;
+	}
+
+	local_bh_disable();
+	dev_dstats_tx_add(p->ndev, len);
+	local_bh_enable();
+	consume_skb(skb);
+}
+
+static void irot_tx_timeout_work(struct work_struct *work)
+{
+	struct irot_priv *p = container_of(to_delayed_work(work),
+					   struct irot_priv, tx_timeout_work);
+
+	irot_tx_stall(p, "no cc_mctp_done in time");
+}
+
+/* Hand the skb to tx_work; the queue restarts once the peer ACKs it */
+static netdev_tx_t irot_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct irot_priv *p = netdev_priv(ndev);
+	bool busy;
+
+	if (!skb->len || skb->len > p->mtu) {
+		dev_warn_ratelimited(p->dev, "TX invalid len %u (mtu %u), dropping\n",
+				     skb->len, p->mtu);
+		irot_tx_drop(p, skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Stop and hand over under the lock that irot_tx_wake() wakes under */
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		netif_stop_queue(ndev);
+		busy = p->tx_skb;
+		if (!busy)
+			p->tx_skb = skb;
+	}
+
+	/* Unreachable: the queue stays stopped while tx_skb is held */
+	if (WARN_ON_ONCE(busy))
+		return NETDEV_TX_BUSY;
+
+	queue_work(p->wq, &p->tx_work);
+
+	return NETDEV_TX_OK;
+}
+
+static int irot_ndo_open(struct net_device *ndev)
+{
+	struct irot_priv *p = netdev_priv(ndev);
+
+	/*
+	 * A busy or stalled window keeps the queue stopped; tx_work wakes it
+	 * once the ACK arrives, since netif_running() is already true here.
+	 */
+	if (irot_tx_ready(p))
+		netif_start_queue(ndev);
+	else
+		netif_stop_queue(ndev);
+
+	return 0;
+}
+
+static int irot_ndo_stop(struct net_device *ndev)
+{
+	struct irot_priv *p = netdev_priv(ndev);
+	struct sk_buff *skb;
+
+	netif_stop_queue(ndev);
+
+	/*
+	 * Do not touch tx_timeout_work: a packet in flight still owns the
+	 * window, and the stall and late-ACK handling must keep running.
+	 */
+	cancel_work_sync(&p->tx_work);
+
+	scoped_guard(spinlock_irqsave, &p->tx_state_lock) {
+		skb = p->tx_skb;
+		p->tx_skb = NULL;
+	}
+
+	if (skb)
+		irot_tx_drop(p, skb);
+
+	return 0;
+}
+
+static const struct net_device_ops irot_netdev_ops = {
+	.ndo_open       = irot_ndo_open,
+	.ndo_stop       = irot_ndo_stop,
+	.ndo_start_xmit = irot_start_xmit,
+};
+
+/*
+ * A point-to-point MCTP link with no physical addressing. The MTU starts at
+ * the DSP0236 baseline; mtu and max_mtu are raised in probe once the
+ * negotiated mtu_limit is known.
+ */
+static void irot_netdev_setup(struct net_device *ndev)
+{
+	ndev->type            = ARPHRD_MCTP;
+	ndev->addr_len        = 0;
+	ndev->hard_header_len = 0;
+	ndev->flags           = IFF_NOARP;
+	ndev->tx_queue_len    = IROT_TX_QUEUE_LEN;
+	ndev->min_mtu         = IROT_MCTP_MIN_MTU;
+	ndev->max_mtu         = IROT_MCTP_MIN_MTU;
+	ndev->mtu             = IROT_MCTP_MIN_MTU;
+	ndev->netdev_ops      = &irot_netdev_ops;
+	ndev->pcpu_stat_type  = NETDEV_PCPU_STAT_DSTATS;
+}
+
+/*
+ * Stop all deferred work for good. After this, the callback's queue_work()
+ * calls are no-ops, and nothing but probe or remove sends on the mailbox.
+ */
+static void irot_disable_work(struct irot_priv *p)
+{
+	disable_work_sync(&p->rx_work);
+	disable_work_sync(&p->tx_work);
+	disable_delayed_work_sync(&p->tx_timeout_work);
+}
+
+/*
+ * The work items touch the netdev's carrier, queue and stats, so they only
+ * run while it is registered: rx_work is held off until then, and tx_work and
+ * tx_timeout_work are only queued once xmit has run.
+ *
+ * A cc_ping or cc_mctp that arrives while the windows are being negotiated is
+ * recorded by the callback and answered once rx_work is enabled, so the IRoT
+ * sees no reply until registration.
+ */
+static int irot_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *ndev;
+	struct irot_priv *p;
+	int rc;
+
+	ndev = alloc_netdev(sizeof(*p), "mctpirot%d", NET_NAME_ENUM,
+			    irot_netdev_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+
+	p = netdev_priv(ndev);
+	p->dev = dev;
+	p->ndev = ndev;
+	spin_lock_init(&p->tx_state_lock);
+	spin_lock_init(&p->rx_lock);
+	mutex_init(&p->tx_chan_lock);
+	init_completion(&p->buffers_done);
+	INIT_WORK(&p->tx_work, irot_tx_work);
+	INIT_WORK(&p->rx_work, irot_rx_work);
+	INIT_DELAYED_WORK(&p->tx_timeout_work, irot_tx_timeout_work);
+
+	/* rx_work hands packets to the stack: hold it off until registration */
+	disable_work(&p->rx_work);
+
+	platform_set_drvdata(pdev, p);
+
+	p->wq = alloc_ordered_workqueue("irot/%s", 0, dev_name(dev));
+	if (!p->wq) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
+	rc = irot_map_pool(p);
+	if (rc)
+		goto err_destroy_wq;
+
+	rc = irot_request_mbox(p);
+	if (rc)
+		goto err_destroy_wq;
+
+	rc = irot_discover_buffers(p);
+	if (rc)
+		goto err_free_mailbox;
+
+	/* The peer cannot reassemble, so advertise the full negotiated MTU */
+	ndev->max_mtu = p->mtu;
+	ndev->mtu = p->mtu;
+
+	netif_carrier_off(ndev);
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_VENDOR);
+	if (rc) {
+		rc = dev_err_probe(dev, rc, "Failed to register MCTP netdev\n");
+		goto err_free_mailbox;
+	}
+
+	enable_and_queue_work(p->wq, &p->rx_work);
+	netif_carrier_on(ndev);
+
+	dev_dbg(dev, "MCTP transport ready on %s, max MTU %u\n",
+		ndev->name, ndev->max_mtu);
+
+	return 0;
+
+err_free_mailbox:
+	irot_disable_work(p);
+	mbox_free_channel(p->chan_rx);
+	mbox_free_channel(p->chan_tx);
+err_destroy_wq:
+	destroy_workqueue(p->wq);
+err_free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static void irot_remove(struct platform_device *pdev)
+{
+	struct irot_priv *p = platform_get_drvdata(pdev);
+	struct net_device *ndev = p->ndev;
+
+	/*
+	 * Unlike the usual order, quiesce the work items before unregistering:
+	 * they raise and drop the carrier, which must not happen once the
+	 * netdev is gone. An xmit that races with this leaves its skb in
+	 * tx_skb, which is freed below once unregistering has stopped xmit.
+	 */
+	irot_disable_work(p);
+	mctp_unregister_netdev(ndev);
+
+	mbox_free_channel(p->chan_rx);
+	mbox_free_channel(p->chan_tx);
+
+	destroy_workqueue(p->wq);
+	kfree_skb(p->tx_skb);
+	free_netdev(ndev);
+}
+
+static const struct of_device_id irot_of_match[] = {
+	{ .compatible = "axiado,ax3005-mctp-irot" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, irot_of_match);
+
+static struct platform_driver irot_driver = {
+	.probe  = irot_probe,
+	.remove = irot_remove,
+	.driver = {
+		.name           = "ax3005-mctp-irot",
+		.of_match_table = irot_of_match,
+		.probe_type     = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(irot_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado AX3005 IRoT MCTP transport driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

