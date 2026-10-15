Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A851CF6A;
	Thu, 15 Oct 2026 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061781; cv=fail; b=HS3XWNLJvrIBVax/LQ9kf5rPc9tBC5Fl5CyQwmMQos+YtfV5d+PVZvvzOTovTHdqJb2hAP8jWvPwz5G8/k/ewdemYAYbzTroHFjQXo6/w0sPh2mLsMZgRIH/WZjWt88PMU3kAWZeJLztCWnWl3xOr5RuaCdqPqyGIv1THbnimDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061781; c=relaxed/simple;
	bh=4VNcGQh+nkHt0iX37RDY3iw6CAntaBDI+ngTkGyx0Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYiTJvSRcCvPcDhxAevXqMI3GX6vvOjxrpZYqwXU9WSgjEggiFppuE8Y69ZAawGwoDJ4bFpSqJaGFmFIkZUDbtFcMUZ+qXOi9gZ0SVOnXsXhyNRHmQ2GZZReWrKxhA21rAzUx4oZT28WJPFTq9dfyPC1R8pZJQANTp/oMa82syA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvMOdd0D; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvMOdd0D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOrL7eU8JbB4rv54rrEuMxXgwoa388RvHAmwtltME2X89kOHtjs6/XKyjZMrYiCfVEJ6L19zVFTjl8ZSZJ/qJLJ5P/JGKz9ASChxey6oEQeEy7gkZrztePRGyLB27DiRS5ehLYeJnJJOmuKrH+qnWJGKqV0OayjUM+8TBYZ6fPOyXJmOWnRZAIrm0Yq5tzxFLdxfMRKQvF2U1d+ndbTkB5Cgzq1dtfEwEpX0Z6DVioUS8Vf6bEO3r4Bo1Wge/wbGiqK5Rj8A71xjPNbtdM4Q11zlQICilsHOVndpxFi5Fp3qYPNLIhqo8MzWXghPCETmPjwgDQBiP2VeccEORzdHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0h9W0BrB1o68IFGG7BEkZsaL3BZeBLOMhkUeIESD+k=;
 b=UNbp+J+Rp+4/27vC7kfMlmXG0Lf7b+/zAm8dcbgB9o4nurhADelkJQyrwcvEnFVHO83oPG9jtOtGaM2qyZv7Bh1daALlSLSmiWJSqfdT6BtJgz78TSHdu7TvjzlEWmxiLRvwYwagQ9Hz4ycE75qmJD9Gc87a6/8541NiouCnl/TF6PLTj2QXfNVP+RXm8o5eyn8F4iDk8zclAHMMfl7GYYzyaJdWKxZiEyUcY8VMUMNP7bZ7vRq090FN1E7yFywhxaBgFcQ0DOdc4jbKfS6hUQ18041tj7XeYROJuTadj9E1pewbCbqEc3M9ZzhaCXZwfNz96YOD7Ya3T/Hlg4HoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0h9W0BrB1o68IFGG7BEkZsaL3BZeBLOMhkUeIESD+k=;
 b=lvMOdd0DwcND6ZdCAtH/wAlL8AZY29nU3DqiqS8de/56NDKa0HjvJJaK7Pgb1jy7wEZh1WAsQ1mAPyXzoJzyLt1VM7aqYzh8LglcBQ7pU59XqweGucppHr3Lmf21zHcwqonJhh2vwgwxq3I0Glg16NJxZcK1pTDBsKaATGGxtyNMhivvvlWh0PStJ8d608BHrS+BJCX99/7c9PPHlMSw0SGTA299q7+u945nNuvvg8g590dOSh9IKed02p9XV+SiiSXZy5bM4yCZGgTfXmOB+k7K0TLpePSETX6CJZy0iDKQ3LuK87OpWzeFw28yTLeR8bIWcXucth6XMo2xFc3F+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:09 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:09 +0000
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
Subject: [PATCH v4 net 4/8] net: enetc: do not rely on mEMAC hardware frame padding
Date: Thu, 15 Oct 2026 13:55:32 +0300
Message-ID: <20261015105536.1692348-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::24) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 217c4e19-2552-4c74-803f-08df2aaaeb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UTD7Hx4T32Tb56BDmKzTHqawU0zlN1uJ4owZ5ocuBFlszsV+8IDaPBOlrKU7949AOz3xYkgpZ7CieDKNO+I9Y9ucAwsG44epXrVoFZqEzknZ49Q5AYcAd3pCd+XbOYCFg1uS9YCJqnAqPtvLOAElkzCzNHXIQ3cvdV0AwEGi7EuouMyXgUzBu+MkUmL1J2lZCm4+haKdttUvVWc7FJx6GzOOH7Y9BOGtNscRdf91Us/YCZIPYFVKdqlsrNThT+SWPb1whwylw8B8KCOruiWTVEobEX2OeZAR+FD2NJO/+Oj1BGY2OJLh4uFz4upC3OakAWYfvk8cjN2KWqvpJF4Lopid3daS2AGxqHLknE7UPqWegGYEEjagv8U5w+qhl4xjMHnH+tX4y5snkjPkYBge+Nzwy671YfxhkLEdQtl++7wJrk1qP8STL7EOyYOqGxB+Lma5068l+M9WamCcfidoC5shzT7fTS6ow4DtRJA2JNIwCsiUMzimp/b0jHlPPPdMDmg6FVg/hikm8ig4zHXOKXLT62P3Vj0U3+yxdUjVx6thvFE1Y0VjIHtzRLQp7wstoIjZuNttkb2Z6vDnuK1eKqaNAYn+bT89/3g1Lf0LvSnCYZ11VQMT5mXYAUQp61C/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCj50SCOMzLSyvrxrsEd/sFG2psJBeBEK8xWuZPMvawjNGSvZKo8MKZ1lhrZ?=
 =?us-ascii?Q?U9nl7VRv6RW5KO15FPukm4OyS+4W0c5hBGjDvE9veoJ9RKAmDPjb8E51+/mW?=
 =?us-ascii?Q?frDqK1OwKwP9HxNkQaatjU2mBsiRrrhHfKAoZElehA/mn/0+q7aZyXuIp9UA?=
 =?us-ascii?Q?7I0Td8ti0nr0mejXhlYwMY2Kx7ikDN03a09J561HvtoqUAo/3Qvo7SGrlcTT?=
 =?us-ascii?Q?0ML/YvM22pgPNGXcBqpH5HQaRHF8lFssUkII8K2UltsaKfAo1UMtpFGLyIDn?=
 =?us-ascii?Q?3XRWilMi+RSCc+3PlbF5TESKeXaMOZIRZpnuZJnTDLB/o7rply9JOgQ0CT4j?=
 =?us-ascii?Q?+tLdt6crLdlgc+6MqcRo62VMvm1I71WfCsAIbMIsi3ekomJltk805mQAzW/k?=
 =?us-ascii?Q?fdSwO/U+iFct340mcCiRWE2P/iCTlv5/IsfAYKrBlWegtaOecrB1d63epUFm?=
 =?us-ascii?Q?ova1qDH7xm3GLhQq2zi9qd0Xaiyy9ZJmUMPYRNtmINT9yCtnwvTpi2SXAOPT?=
 =?us-ascii?Q?SiHiWPviTUQ5BnGhIBzQEtNQk/xoH+8evI2Rgd0QzFJuBmJfKC5lu7AXNWw1?=
 =?us-ascii?Q?Ay4miT9FF3aJvS0eQFT6xxy1maODOrR8D1WAwpAlAT3i4kEvXwCQCFTh7bPl?=
 =?us-ascii?Q?yaRAdH92qWUADI+RRrEu0WiC4jl5zkGjn3QR2WfCfR0X0CFhfopV7RfWOn10?=
 =?us-ascii?Q?uPPUeUZ0UVBAWHJ3p5QjFZ4ep7ekR87KN/ZVESohiHH7+yzs2lWOiPaPEDJ9?=
 =?us-ascii?Q?VUPraZEgJ9J1ImBMzxcMPbM9QJWE/F9SrdJ4iisnCnjJYowLuqkA+Xw37Y+M?=
 =?us-ascii?Q?kn2e6yhE8QS8Dyt9O8T1Kb7nPiwiqVqWcBPMY26jSOIOayCqnk3wmfZMhYAU?=
 =?us-ascii?Q?L+wygPqUtXZK8oiwHMpwmS7Ngk0EF65tm2nBSdPMPJpegrpqIfwIdWfEq/Fu?=
 =?us-ascii?Q?rG13mFQHT5AGTE4SejOlU+rPEH7Gcv9B5jTEnQ3hRJ/3zewnQyx1Zwq7PbEN?=
 =?us-ascii?Q?NH7mAQC+HhLNtDju/9H44+XCFxXTkMvnAUjLU1bNCDWjkLcPWWKBc09PZrMh?=
 =?us-ascii?Q?Y8tAeSJP35yp+++mqiEAjhFOEPG+W+MujB792OwBF7kSi1gQzzfHKubAM7hZ?=
 =?us-ascii?Q?d3dWDcuWUga++0iOnrnYIk9albPylSqd76vM4416Spwac8moBDZFFDFGJzDx?=
 =?us-ascii?Q?URqMdlirx+pITa7CVQmeEXs2wXRjC8JXF6h5XWBo9H6HLhk48+B+I7OdyNsS?=
 =?us-ascii?Q?63G3/BbAq+/MExZwtoKdl5wZ8SBdIr3mtME1h4fzSk2Gs8koyXXQZxjG6NcY?=
 =?us-ascii?Q?Nj7r9QkT8JeD9QBacGXRktEEt7S56fkKlGTvWyYK3GDLloC+/+4em64g0nes?=
 =?us-ascii?Q?blynrv7CGLt/6NRXlrE92jVoDqckP+RzQQqoxZpErcA2AuviIZfJSR+roYoH?=
 =?us-ascii?Q?V+DWVoi8oyBRXUbD7iM6lc63kdCArKhPMbNSBV6kr3onnv0DCB9rlNqyCDDs?=
 =?us-ascii?Q?+P06VQu6mP7xyUKpVbp0ROiNVB0QAp8ZKWEe+jC7Fn19xR+fwkP+GSFWYS1j?=
 =?us-ascii?Q?eAIcCeGAQUFhjQJcOeE/vz8wLr5stPvmL/cSg8OzijIhev6WpE6d3D/8z7yT?=
 =?us-ascii?Q?avQfsGNbU2JrYJkKUiK4ISD2i1/KYQOrTP1vYSa7NL30nFP/pphdfhh7pVgA?=
 =?us-ascii?Q?/vjsipFUi11uyqgUFq0W/Liw2wiPdBefnQHKviQc8paF207o2Ea8L7YCCQgQ?=
 =?us-ascii?Q?6xwwfCDGKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217c4e19-2552-4c74-803f-08df2aaaeb49
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:09.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EyEHzIFa2ykjdZsVJ7g1tIeyB9O2GSWF7i4/Eq1OsobDSMSVB5L42wf6Lg2jfE7NUpx4nQgiYP0YjH1LZmuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
This works, however sending short frames from user space and looking at
the padding bytes inserted by the MAC at the link partner, we notice the
first octet of padding is sometimes not 0.

This is fine per 802.3, which does not require that the padding is zero.

However, there is an unproven suspicion that the padding bytes may
come from internal memories, and unfortunately I couldn't get sufficient
priority for this octet's origin to be investigated by hardware
engineers.

To be defensive and not leak any sensitive information from the SoC,
let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
have to do anything.

There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
things are trivial; we need to call eth_skb_pad(). For GSO, things are
not simple, because user space may set gso_size to a very small value,
which could make the GSO super-skb smaller than ETH_ZLEN; padding that
would produce more segments than originally intended. What needs to be
done is to pad individual segments instead.

When a GSO segment's hdr_len + data_len is below ETH_ZLEN, append a
zero-padding data BD and advertise the padded length in the header BD's
frm_len.

The padding bytes are always the same zeros, so a single read-only
DMA-coherent buffer (tx_pad, ETH_ZLEN bytes, zero-initialized by
dma_alloc_coherent() and never written) is shared by all padding BDs of
the ring. Like the header BD, a padding BD carries no per-BD DMA address,
so cleanup does not unmap it. The pad BD becomes the segment's last BD,
so the F flag and the skb pointer move onto it. Segment checksums are
unaffected as they are computed over data_len only, before padding.

The worst-case descriptor reservation grows by one BD per segment.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- split from "net: enetc: pad short frames in software", bring its own
  justification:
  https://lore.kernel.org/netdev/20260921112946.edo5uw6cl7jx6oez@skbuf/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 58 ++++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h |  6 ++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a2692761a6e2..9ab90145dcfa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -524,7 +524,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 				struct enetc_tx_swbd *tx_swbd,
 				union enetc_tx_bd *txbd, int *i, int hdr_len,
-				int data_len)
+				int data_len, int frm_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
@@ -541,7 +541,7 @@ static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 	txbd_tmp.buf_len = cpu_to_le16(hdr_len);
 
 	/* first BD needs frm_len and offload flags set */
-	txbd_tmp.frm_len = cpu_to_le16(hdr_len + data_len);
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
 	txbd_tmp.flags = flags;
 
 	/* For the TSO header we do not set the dma address since we do not
@@ -613,6 +613,23 @@ static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 	return 0;
 }
 
+/* Append a zero-padding BD to a frame shorter than ETH_ZLEN */
+static void enetc_map_tx_pad(struct enetc_bdr *tx_ring, int i, int pad_len)
+{
+	struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+	union enetc_tx_bd *txbd = ENETC_TXBD(*tx_ring, i);
+
+	enetc_clear_tx_bd(txbd);
+	txbd->addr = cpu_to_le64(tx_ring->tx_pad_dma);
+	txbd->buf_len = cpu_to_le16(pad_len);
+	txbd->flags = ENETC_TXBD_FLAGS_F;
+
+	tx_swbd->len = pad_len;
+	tx_swbd->is_eof = 1;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+}
+
 static __wsum enetc_tso_hdr_csum(struct tso_t *tso, struct sk_buff *skb,
 				 char *hdr, int hdr_len, int *l4_hdr_len)
 {
@@ -915,6 +932,8 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	i = tx_ring->next_to_use;
 
 	while (total_len > 0) {
+		int frm_len;
+		int pad_len;
 		char *hdr;
 
 		/* Get the BD */
@@ -926,6 +945,10 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 		data_len = min_t(int, skb_shinfo(skb)->gso_size, total_len);
 		total_len -= data_len;
 
+		/* Pad segments below ETH_ZLEN so the mEMAC does not pad them. */
+		frm_len = max_t(int, hdr_len + data_len, ETH_ZLEN);
+		pad_len = frm_len - (hdr_len + data_len);
+
 		/* prepare packet headers: MAC + IP + TCP */
 		hdr = tx_ring->tso_headers + i * TSO_HEADER_SIZE;
 		tso_build_hdr(skb, hdr, &tso, data_len, total_len == 0);
@@ -933,7 +956,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
 		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
-					      &i, hdr_len, data_len);
+					      &i, hdr_len, data_len, frm_len);
 		bd_data_num = 0;
 
 		while (data_len > 0) {
@@ -955,8 +978,10 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			csum = csum_block_add(csum, csum2, pos);
 			pos += size;
 
+			/* When padding, the pad BD is the last one, not this */
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
+						    !pad_len &&
 						    size == data_len);
 			if (err) {
 				if (i == 0)
@@ -977,6 +1002,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 		enetc_tso_complete_csum(tx_ring, &tso, skb, hdr, pos, csum);
 
+		if (pad_len) {
+			enetc_bdr_idx_inc(tx_ring, &i);
+			enetc_map_tx_pad(tx_ring, i, pad_len);
+			tx_swbd = &tx_ring->tx_swbd[i];
+			count++;
+		}
+
 		if (total_len == 0)
 			tx_swbd->skb = skb;
 
@@ -1029,7 +1061,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 			count = enetc_lso_hw_offload(tx_ring, skb);
 		} else {
-			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+			/* +gso_segs to cover one pad BD per segment */
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb) +
+			    skb_shinfo(skb)->gso_segs) {
 				netif_stop_subqueue(ndev, tx_ring->index);
 				return NETDEV_TX_BUSY;
 			}
@@ -1039,6 +1073,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			enetc_unlock_mdio();
 		}
 	} else {
+		if (eth_skb_pad(skb))
+			return NETDEV_TX_OK;
+
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
@@ -2294,8 +2331,18 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 		goto err_alloc_tso;
 	}
 
+	res->tx_pad = dma_alloc_coherent(dev, ETH_ZLEN, &res->tx_pad_dma,
+					 GFP_KERNEL);
+	if (!res->tx_pad) {
+		err = -ENOMEM;
+		goto err_alloc_pad;
+	}
+
 	return 0;
 
+err_alloc_pad:
+	dma_free_coherent(dev, bd_count * TSO_HEADER_SIZE, res->tso_headers,
+			  res->tso_headers_dma);
 err_alloc_tso:
 	enetc_dma_free_bdr(res);
 err_alloc_bdr:
@@ -2307,6 +2354,7 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 
 static void enetc_free_tx_resource(const struct enetc_bdr_resource *res)
 {
+	dma_free_coherent(res->dev, ETH_ZLEN, res->tx_pad, res->tx_pad_dma);
 	dma_free_coherent(res->dev, res->bd_count * TSO_HEADER_SIZE,
 			  res->tso_headers, res->tso_headers_dma);
 	enetc_dma_free_bdr(res);
@@ -2434,6 +2482,8 @@ static void enetc_assign_tx_resource(struct enetc_bdr *tx_ring,
 	tx_ring->tx_swbd = res ? res->tx_swbd : NULL;
 	tx_ring->tso_headers = res ? res->tso_headers : NULL;
 	tx_ring->tso_headers_dma = res ? res->tso_headers_dma : 0;
+	tx_ring->tx_pad = res ? res->tx_pad : NULL;
+	tx_ring->tx_pad_dma = res ? res->tx_pad_dma : 0;
 }
 
 static void enetc_assign_rx_resource(struct enetc_bdr *rx_ring,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index bc7c0740498d..08613e6a1d28 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -145,6 +145,8 @@ struct enetc_bdr_resource {
 	};
 	char *tso_headers;
 	dma_addr_t tso_headers_dma;
+	void *tx_pad;
+	dma_addr_t tx_pad_dma;
 };
 
 struct enetc_bdr {
@@ -186,6 +188,10 @@ struct enetc_bdr {
 	/* DMA buffer for TSO headers */
 	char *tso_headers;
 	dma_addr_t tso_headers_dma;
+
+	/* Shared read-only zero buffer to pad short frames to ETH_ZLEN */
+	void *tx_pad;
+	dma_addr_t tx_pad_dma;
 } ____cacheline_aligned_in_smp;
 
 static inline void enetc_bdr_idx_inc(struct enetc_bdr *bdr, int *i)
-- 
2.43.0

