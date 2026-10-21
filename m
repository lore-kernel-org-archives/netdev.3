Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594470;
	b=wBt2D2J2MV7PhC+Pa5k/RlJpuwWJ2JRbqn1RXeDM81/L7xMyDZjWxGEg8S82E8w39SB1
	 xWcAtBf9OK5niNd/Y/srB7IKS4DEHK+oewKt4hZBnMWyITwp+trNVDbMNnkrGzpUoxDE6
	 V5XvIzBDVV2Bq39WvgNqiLj7bSS+/rkAoKjObmT8PFzWe1K/JVOZncf3OARujGmon1U9b
	 4yqVb+em0tHo5OvbtS3YLqSnpdeAtjeMX8eqog5rClxuNxil5rpivlRSrw1fOp6ehYUzP
	 CoNbleXZMHKFaiHKIJ61sATjw05W8gox5f3Oyxh60rbbtvboQDj/3kYCjupo5LVCTlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594470;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YZb5AGc3P5G6xwWqUXgKbl3CQ2zp+s/ipKopzu5kA5w=;
	b=5YrE87+S0tpQOKSWj/9D2js7ta6mgYSTjANyDbArgrWk7s50FjOyNoGSBowDmIfqPFyr
	 II1WULDhBHsv7gNnu24CUEg8YjlK0gtZ8NWtdax/7V4/MDG/I9s0hd12IHkdPZ4hRMHiS
	 NMswrwE7NSo8VeV/S3/3z/+V6vlpOPrQ51137m5FMfejnr77HUjUfYTH6CvQavYNu4lYl
	 EXycJs4WAOzZMcolMiX4zVI7HCMt+6Qgr4E1bBwVyxFfLY6aXYYMofo3hufJFL74GLRip
	 0B74LSD0dQOe3ujObGEVoxZhAL2+WIn1/5wzv5s2iesIz/YVxCMnHsEHoXvzRpUhfkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FKiKbkuo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.50
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7D606A322;
	Wed, 21 Oct 2026 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C7D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FKiKbkuo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0HL0GoVcG3vYjQuFmplUUIHCgtNtBRexxT49ryjLIvyTVys2TYbOGWgbMbzPkKzZQFsH7ohRJ+b1Ij5LWHOtlGEFOTuc+29ip3SYQvDXaJulnI07Rmsp62xfVgHNaPnXtE0zkEXRiXQPPnH3SLxL4JBpx+TaR4Z2nzQ0msIoZbi1OacAVfJIA2q00qrUPx8cXW2R2Am07inbQSMiZX0fB9xkjO0P9rdLyQqv3PV8wIEh0cPlNSZl+gu1iGrwRDKdmUxBm/z0vga7hdhzbjOkwXa4inigPcxBl1M1L6b2zQEeh36RqbAcv8sW0iemv1hckrMBeOS3mX2tfqmQ6/x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZb5AGc3P5G6xwWqUXgKbl3CQ2zp+s/ipKopzu5kA5w=;
 b=ci/Rz2j8Zv92bxD1ZJfZE4frQBGdr2OWIp3aq6rLBo3LgvOAmvYiRgHB6ozrMCAX8zDuRdDJxXdIFDdsZIRsl2TDaMMhQKiq9WCEthqxdkivuLibjByb+RYx4jqgCSk0XSg6f6RF2e502rEp8+t8aNNQHCGQkuhpMjBTzMRE/IKQ+Jtp0vgqCV2ucBIS4YFrSAjnXc/sbriwoGzmyHf2n94eI4eBq8nyZfKhhIWwsBKlY5nOjeWTRBeGfKyrzDmv88hsDrSVc3jSNzPs2yxDBTVi+XiVEh/emvySx1jPwDTOBLNDXxw5LT1MKeZd1jBT+oajR/BS/OK+iqiDFB5LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZb5AGc3P5G6xwWqUXgKbl3CQ2zp+s/ipKopzu5kA5w=;
 b=FKiKbkuoGavuS1Ao/TEUronhwj6dJpfPBVeKw5EPiZobFEGiXTef4KmcB43I6QLlKHoWEyg5CUfUWAJRJf8HJfiUQGSwSDnWL7qrmKCCjNW0y/dWbRDX5z/2arjrlctD83oCoq6HeC4Vslg6EDukpJtL4qYehcboFzY12kfuH48JVTOD8bov1yL6Rm/pVMMlIOh7DYcdcprPvooE7Y22MQGdYFlw1hDRTQX8fW0g7CuFSInKSnZ2z4nl+kXLJfMDncSSmg+RdZCq3NkNL4D/SWDx9oU18vz7dOdnbLcgsYg4d2PSFoJpXr8uhFOUSMPqDEcuUxwvNzmH91lkXnxbAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:54:27 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:54:27 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net 1/4] net: enetc: reserve VLAN extension BDs for software TSO
Date: Wed, 21 Oct 2026 17:53:11 +0300
Message-ID: <20261021145314.1435049-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::11) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: b0587100-8fa8-4c08-026a-08df2f83343f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KSS0ME8CijHihw2YPko82NAi0PiCQlue78U8yiIEzSpIJZbWRVTDdLFOp/yEvvDvxlmkI1qpJZTyBnLmGkGWFBbUe8hOZRZ+xZ3FOme3ZgSicgJfVsjkMQ1Xby2lZDvZ/+mloYboY/UHNrcFVRUZ1WHvBE0jCEGr1jjkrmxPb3SiApPWPtJwzrsa8E3wJCLuc3FT4O7AZHrjBVa73aPibKAh4QitneKsxc47MFyYIKAJwuPNZ89D5MCPM9BU7UpXrdmXjZW81SNkjzh5kiH98aKV21Uq5XEpG4jdby+wTGqe7ZFPiWvneHO4ulK8mstc8qV+RbdRle+Gbyir/7x8e8W5nZQcdKuML9x/QXue3aDSP7E3VNcbaeN2Lrq44hUim1aJE0T4GwcZFiehGjU75h0Ansit6XNcvb/OpDLxtGJiItieC30khh8CYz7U3cyw8Ccaln7ufc2Sy71H1LaBjDsr25UxrNbaj6tquVl5cbJkOoLRMly/hyw2tnnypIV1k7UcCFMT2tSrgkSAizQqFf/scFgvKTvWqurBFCfNwTx3bGrkIObXjrfg94l/skYh9jyhAjIy7yePbW4jHcX9GckNKcugXdgO0ENRRjDyWc5ayVueiX88HsSjLDPF6RkhI+BzpSV1a1dY6MeCOMaOqj/1133R98Mcum5W3i7aEv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdBgsvQfllBA9pMcdZKBsrIACEddndDZaNo/CB+xjqV8yPCnbatXIT06NT3n?=
 =?us-ascii?Q?4xfeXEyzypInERH1Uy9+h/XfgKFJK/JdOTywFaNRhxPM6WDT66eIj9eTWGjT?=
 =?us-ascii?Q?vSlLez4iZvNzo+ad1fsW8Yz95+PediGpHIqB8FTKPzGcWMsMPn6lwY0NI7x6?=
 =?us-ascii?Q?OKSW6m0dF6woFIqojY1Mqoe1C6Ll/zlKIP++UD3G1Z8q2neyMqus4NlmZWce?=
 =?us-ascii?Q?q18xNP9PtUNBzPOGbVJOqc26hZHTlmJNqfLHFEx9ex/2TBVI19cdFPiq7jwo?=
 =?us-ascii?Q?9Ita4I4sEyQj9h9pBYFNzpnxEmxUOjoPOF0NTSxn+urfFaVnVEBmfDbnIzL5?=
 =?us-ascii?Q?g92ClVP0df2uUOqPfdNCOPfd+Y4W5VMp99XhXYYQ1zZn5VSJmLu+m8TwV/NR?=
 =?us-ascii?Q?nQhO5vci1wA1ZtcMYTPh8owuCnoRqNJTCPmEzL63Ntf3P9auexuji8tcHNtQ?=
 =?us-ascii?Q?5+XpctzD1RThHxvT0RBrMXARQ2kJQhz4TSDKlI4t9PdfD2vcZIyO1QCab6ij?=
 =?us-ascii?Q?0pshyd4TiTI/HL/8J6CxdEArsZn52gTjLtVZhoLmMQFRTbghq4T46n3nO2bH?=
 =?us-ascii?Q?PbT+sGdG3I8P72SnWu7NPiSQ2X0mhgUk/Xp9yX0kZZI124jjyoFBWIp9pSCq?=
 =?us-ascii?Q?y6Mo6Ixp/Q7GT8RVcOIJ9CEGHPIb0A7eYXbVj9kRt7jJxXH/YC9Y64GxNFd1?=
 =?us-ascii?Q?E1o2hq7klybp5QS+WTPtARlRq7q7sItD5ZTN2fU02lNV7gr0Vsq2wdCuh2sW?=
 =?us-ascii?Q?00JRTCDD88Ish+AWcPKeR4U9XZqUXf4hf+sNTRStT89WNRDxC6WL28a/q8Cc?=
 =?us-ascii?Q?ZZ6V0aTxnEwP54hGfwydqhCr349M/W7MQqYu+VSmQy1e63enJqqhwLHmkVmo?=
 =?us-ascii?Q?6sh5Mq08mn+CzHF1WNEuLblgfNgA1pC0LUVraugGU+Abjiz30HNgbW7tfXDL?=
 =?us-ascii?Q?/ZyKw5X6i+QbfMA6dxVmw+ZwaecxxtOt8xAlk1M47WrBcz2fpt9UccUt+VAg?=
 =?us-ascii?Q?oSZekBcRiNPD9/nVH+sWHM/21Hx8N4Wo7WCQKG8/mlZRoZTNBSbfG6RmgZy7?=
 =?us-ascii?Q?9AwJjvZKrYwzGAaYoO/7nl/Z7l/82/6rik3qhLHePQKarF5nrLZH9kh4yXNV?=
 =?us-ascii?Q?Sy8XXRouFshjBmyNP028xGOLnORWQ4w/ReJVZwsbpw9RDCqdrsHoIPfRSAY2?=
 =?us-ascii?Q?ihVhZTzRauSt/vLR7Zdh+WalhrhovpelKeZSVG4MrITqCmqoAd1GlHeojuIA?=
 =?us-ascii?Q?5jII3aetuIguXGfn+skI53bwXes6zyrqDYUz4r3LedEBSY1RJwg4iCyuZM99?=
 =?us-ascii?Q?OsP5mFprnH0o5WAlvJ1Zh0DoPDtaOMpl5ky4/YPxxG9OB4UScRhQwWeXUnD0?=
 =?us-ascii?Q?6Ed/CSUh08E9gcNDLk2bDcAPLtF2ReCReFIJtfvQDtwhjpSwRGAkV7Gmp1zg?=
 =?us-ascii?Q?rzmH3WClaA5gCjHjV+dRNXW4kN8dHRJApcytS3+i/YSbWQumLRSGuD5HTfpu?=
 =?us-ascii?Q?NIWmrNpKQ2+sHa53j+zI1NpynUeJIlzDJQQiYY10sKIKHqFvIKC+jv+FE4XJ?=
 =?us-ascii?Q?nfuha8fRunygvOpztn7vPmTVemeun4VhXGEg96tPUtUnwtS85HOfNGGT4sjN?=
 =?us-ascii?Q?yRvFFWIWvYwvbiysplijQuFhv/9Bg3GkEyW3nyMiGnyJJywmG/NGmtsyptpg?=
 =?us-ascii?Q?62nRWLoXpRP5BsLuWr/q0U5RvTJJAS6dU8r17A9TDREv3lOIhdFpVPKOYrAr?=
 =?us-ascii?Q?iH16/iUFqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0587100-8fa8-4c08-026a-08df2f83343f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:54:27.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtKlURD1FoalIJVpcuhXERUXhP/YQDGg7jjYww2zGcU6XQ2QP7x7017UqnFsLQPpO1+QgQHh3GHlZtn1WBTzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

enetc_start_xmit() uses tso_count_descs() to check whether the TX ring
has enough free BDs for a software TSO frame. That estimates one header
BD and one data BD per segment, plus one BD per frag. However, when the
skb carries a VLAN tag, enetc_map_tx_tso_hdr() also adds an extension
BD to every segment, which is not accounted for.

With a highly segmented VLAN TSO skb and a nearly full ring, the driver
can then write past next_to_clean and overwrite BDs still owned by the
hardware.

Add enetc_tso_count_descs() which accounts for the extension BD of each
segment when VLAN insertion is needed.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c6571b5cc842..f6b352a3a49c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -685,6 +685,17 @@ static int enetc_lso_count_descs(const struct sk_buff *skb)
 	return skb_shinfo(skb)->nr_frags + 4;
 }
 
+static int enetc_tso_count_descs(const struct sk_buff *skb)
+{
+	int count = tso_count_descs(skb);
+
+	/* Each segment also needs an extension BD for VLAN insertion */
+	if (skb_vlan_tag_present(skb))
+		count += skb_shinfo(skb)->gso_segs;
+
+	return count;
+}
+
 static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
 {
 	int hdr_len, tlen;
@@ -1029,7 +1040,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 			count = enetc_lso_hw_offload(tx_ring, skb);
 		} else {
-			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+			if (enetc_bd_unused(tx_ring) < enetc_tso_count_descs(skb)) {
 				netif_stop_subqueue(ndev, tx_ring->index);
 				return NETDEV_TX_BUSY;
 			}
-- 
2.43.0

