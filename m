Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013086.outbound.protection.outlook.com [52.103.46.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253DA248867;
	Mon,  7 Sep 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748962; cv=fail; b=DmyOzpWVGHrwrg5/G0ymzvdLRuedS/YOcoknAmfqvruDo4yX1Cqm9wSg0VYDzfoJDpjuwFHBvHlRUcoSby3P0OilahNFiaLUK+IsrE0gshy4UeDZtdJycoO+D7gTOnmuj5BO7j9k1LNxIj8SwvgHBcdNuN9wGGfwwLydnSQV8p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748962; c=relaxed/simple;
	bh=Dl3smm+YGdxL89NrwdZY0QW/JiOvs6pd3T1jODznuT0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XpJI4eK5O8F1RoKHL//uvHHKsx/TZ+gKF0vjnD66Ek0XO0HSgndoS2Dux/MCVsraUV2Hzo7duSWo/fhjnLTx5ySV5kLSHFEYfqpLOTfdfK1QGY0k9fTofMLGl9hAVjKm6oabY2gT1c9C6bUFFbmE/ARQTNRU8zizr7pR4K19A2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=OhmePvlz; arc=fail smtp.client-ip=52.103.46.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="OhmePvlz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6XGPomSASfeVwuBTI+ZaqrYjMd3OGDNp0zuwAryWOkypxX+ZIpaZ0VNW+wy3j9GYGacOCKnWdYESpQDIhkWfSbJ3690nVL4b84Mq3yXM0DcDsaZB4Oqvr0CfolYsOkSer7iiUjqtkEF6WaxEKEBb1eapKieFZJSMAP6xWlrYIuvoii+s++wBdgj4ozWG7oJtkAck8nugQpXLOUM3B7uDETIDd4HK9Pjn/wPIkRLINXPAyBFuL4KXSxHwJx1LR6zFM+g6FerKkHm5VfDMbQae9DoPEz/Wc0vUddvsEpRO7X4/EiWlbH6dIeFCFOF0c8m1TLjNHsw3kIdm7HvijqVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mLC9eqa2AYr/rm/AQppSP8vZ0b2S1ZCSDnPXCe4jLE=;
 b=LPZ8YhFErpBJSGuWKAUkD0mgxvv8MgdZh4dGmO1hsjST0tq/Kp2ctZ8Rnc+ke/KpoKB0WmAYwOC+Tbv5NYv2/AkuqGmhVeOLpwD7+wicDesJnsr3qGyZRPrXUtZr79Q2xGnnL2hpQNvBQq3LBgzU2FK9m8vC++UNLSwUK2urjiHIX8hh2OQZnYJIkNxWb0ZcELIXUQfiQC/Y4FO4EvprNkvtC1lV1rgaH7LlN4plJ/LB2ulc98kOYnIHtLYcHztMcmF59UB76so2M7qgExQjmKMnJtkhT4aLdLvTupoJ1jUl5GBbVT8pDct75QncAUnefkJmlESnLHBNUgswMdciBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mLC9eqa2AYr/rm/AQppSP8vZ0b2S1ZCSDnPXCe4jLE=;
 b=OhmePvlzYlXte9HwdV5mvW7pLAtR3m9nBowLolhb+bdr3GSDIFVGLPUu/AEOtm4Kpvkipa1O/gBavuAaYDZ7tgJl77huIjZywJ2KTsZZc5jAP6sCcodwqVoX+4G/gLlal3b+kKDxfEY/7u6tYfuB/o6MLiK9U2BNH5KJDPI5X+OhwYyn6eJtWGdRzhXwuWdxVdYhO36LNw4nZG//2HNmuFwT94FWsaOcKVJl6jmdbCLcnxdWi6MbdSQ1zLgJIuPtIMlPAyuryW+kDd4oVSnEu+RnqPHZZTN4s2uGygagh9/1jOsMai/z3sgoMkOxss0TcZGon7NLFytZtPU2jw5WMQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB1131.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:5e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:42:38 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:42:38 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: cai.huoqing@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] net: hinic: fix mailbox segment buffer overflow
Date: Mon,  7 Sep 2026 02:42:34 +0000
Message-ID:
 <AS8P251MB0001AE870B09020B46B5D7DBC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907024235.503359-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB1131:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f898aa-015d-4ebf-488b-08df0c89adf6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|24021099003|25010399006|5072599009|4140399003|5062599005|25031999004|12121999013|15080799012|2604032031799003|8060799015|19110799012|23021999003|51005399006|55001999006|37011999003|26104999009|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lRhN6RLP8yHrGdobI39d9QZD90rRFZKJ+H9ZUEUqLzXTStsm7wlebn0p0hV9?=
 =?us-ascii?Q?rVr+Ova0wAKL6oP9lNTxEeSXZwpvyTndT8TshQ51ZGe5QRYMF2f4WOYR/BpS?=
 =?us-ascii?Q?pviP0WYnec8GeR50jr3VsCrtth42yTRowu3b/w8GnWxrvl7zvT/ZbHea4gFM?=
 =?us-ascii?Q?sFLMZISt4OMVFCqhmgh0xt2XoxIpH39ku6bMgt/mGwF2sSFUPywbrQJQO+iM?=
 =?us-ascii?Q?yU0Klq1X8Yh69AeSUSd0xw9gpTkcEL2BkUPYG4wS7Po4JV9lQjPrR21heN9D?=
 =?us-ascii?Q?Vk+MSx/HJZ6jAbourh3spm29kUrHukCJ/B1oPS3GKbOb82cWvqG2hu4OQK1u?=
 =?us-ascii?Q?xczo9ZhMIAZDenH63LO/n9KWsLuc6uOR9PVbUIDP28FUHRIKY3XWbgIS2GOt?=
 =?us-ascii?Q?ktP/jNmgjtIZwafwGPCeYY+QGA0bODDUhsUAIW8PfUA6TQr7tgK3hI5cHkyF?=
 =?us-ascii?Q?G80x7gdF0YcSF5bZtsff4dl9PMmBdaBuLoPOz0Xdj7FNpI38c1v/Ob5NsgT5?=
 =?us-ascii?Q?qVM4W6mP/CR3F2f+b50CJ8Rgvw7xABjRC65FSXCifYUh7vDGEu6jwWrhspcd?=
 =?us-ascii?Q?LUJS9nOFM5Av5S+cZMKfYi06qlug5ApTbHg5pSnQnbJo9RV+sOUhz1ecxXdP?=
 =?us-ascii?Q?vt+IqcKQQIGOgCf/aDbc6qjT1dLwPXdl2vFPl6xmGogf3Ny46oTEOqVIJqW0?=
 =?us-ascii?Q?mAQ0XGq6qOdMvh3tTb+ZqDw7gGoJYpSQtYUWhQRfJq9dK0o4HwOCnUmgrk/w?=
 =?us-ascii?Q?njOoDBn/3M6OH+ZA2+qbD4dwtpWgwUnxINp32MT5dRGMwjTEIBcaZWyNrf8k?=
 =?us-ascii?Q?FnUIeqitrs7pSJAwlAEUQg2nw4DZpjq6qb59nuqQj0A3HUStM+oavGTB4Q2p?=
 =?us-ascii?Q?UkBbeODLfa2UA9/zRtkkzgjSB7AvvE5arp+/HQe3nGTJkR7jYZPiSA1SQHNa?=
 =?us-ascii?Q?FJW20IZ8HsmVhGu4i1fbhdmJV5a4nYS5Slt6K2CVu7knrUk3lwhAVx69uYn3?=
 =?us-ascii?Q?YGzFd4bl1h9BdAGz3vkvZS/m+V1UpOZaVAymjDWmxetoEAeWy1/705J40YHl?=
 =?us-ascii?Q?PPPCATc3iAZ3QwcCtd7JUMl4LoCQwcMpg3vudqZQ0J5IQTy8H2ppZcNfsmjv?=
 =?us-ascii?Q?+95oJ1595EfgOrfIWZ7f0n1vOOtakkfUWoBtCWNK4rO9gFYldeUeOE7bukaW?=
 =?us-ascii?Q?aQnY/nBuOEE1dnNa?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pFfrmWWq1lheL1aVAn3r5h4hKiYr54fdJ8OjqHjlvUVaStShEk0Romp6aKX?=
 =?us-ascii?Q?RzUt5df6nk2bm6hEap3loBTR/TUnOhJergiU90VuiN9pVt8ZkqNkRCv/sXVH?=
 =?us-ascii?Q?MGCoDdu4htr+4u6YZaM5BY5fyaSs8MRy+Aq8KiX6bcEib1UO7ZhmU3rN20/h?=
 =?us-ascii?Q?oqLh0mObeK6OHAEvaIfrLea8tmU0vyYQSe5Q6YeydPVFcMgFCSuM6YFNPcno?=
 =?us-ascii?Q?buZApcGJYmZxEEaG0J6IsmQNFfSZ5BayyMhBOn6aKeyaaISQ0+8QVeRf5j0y?=
 =?us-ascii?Q?XFeTngPJfdAwOPTiD3mRlzRziaxv6VBKF9K3pg0gDm4XXIrhQ2AjjBultjpv?=
 =?us-ascii?Q?FRYZbm1W4vpcwc/7IpKQ9II7MQxsL4wVKN7yXiuUh57LO74KkDI0r7EUGVQw?=
 =?us-ascii?Q?tFljTlFgKwGbWgZo3IesSp1V5fnQycd7bSDx0IykQRhlR5tQY4KlD+hI8Pen?=
 =?us-ascii?Q?L6iiDGJ7QP/WlBx793s+ZPGkKqm+tGwIktOTvJsvcU2E3OfTT9I7JpyPF363?=
 =?us-ascii?Q?bol0KSvxGssfxIGXSsD1xBXfyxcFwsGcQgur3QhO9AG7p662vHPgW7GwD9Rm?=
 =?us-ascii?Q?YUD3X7172VoG2iMWvVWOSEp2M1TRgIuabzhhN0NzxLUJQrJga4mNbXi2f3C5?=
 =?us-ascii?Q?Js+modmrCQLYz58isyeRBgWsTKaNlscf6aFWVJ8aL2vBPMXtL9lE/5pX090h?=
 =?us-ascii?Q?2UVpzkUC08cIqgFEeQb+TtYvvwMoNFjoFcaj63Ac72YEtXhYLJNmk4PT9KQM?=
 =?us-ascii?Q?uLMW0LxxCL5xyv8YyvyJL4q5TE8wRWFo2s015ZVhCyNHfk/reQOTBjwy2lqV?=
 =?us-ascii?Q?eAGWUeIttaWbpX4SqLOhklcvakPh+V32STx0wvtnZIdtwXnEzpeBXBRi5CE0?=
 =?us-ascii?Q?wuWWS8NJFzUIeZiGRvAdT3+QOt1wD8Ig8CQedkJ1d3Vhgx4XFp7SEJTe9Ip6?=
 =?us-ascii?Q?JgynO7GLyHxPsmhlIRLM4qZSXnOg6Tc/HiMlGzuntoToillx1gZEJ9rCJUbf?=
 =?us-ascii?Q?QxMT3sfVKG9MWd7PPyxLom+hnjr13dn5xtCSJHpZRTKFpKtQDxWWXFHGd1Jc?=
 =?us-ascii?Q?KtYXtbpICsAr3iJ536PgVFum1vblhYe6pjZDb//6SChqiuRdnTdNCy7EK76i?=
 =?us-ascii?Q?OMdB1RtIkdKqnPbct2FRPATs+xMIIS1bRLIFRkY1kVgZCyG/BBnVMq2bdqxg?=
 =?us-ascii?Q?KAGlQ63BjmwKEb9ADoGrM3ZaNh8qqG8/imwIuxMNElJuGMK5y0bYsUlDFBXb?=
 =?us-ascii?Q?b/c8YWIQUYzRqKr83ayfaz0gkAJDaBdq2tb9JnAhTS3a9wkj1yt6/Ra4SQXk?=
 =?us-ascii?Q?lGJdsqrzOzLNvp+rz0wiQUpCI3AxSFQy+wtyEeuOEWF3L7nqIPfAD0u4/fs2?=
 =?us-ascii?Q?MNp8ZcWjwCoMxN62VdH7wrcm/xAmt+lBUzOjw5Jg1eT7WUt94J4yNNPB/Xoe?=
 =?us-ascii?Q?23obyWxHk+BPMEEpH22aSZAazUnfrO/m?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f898aa-015d-4ebf-488b-08df0c89adf6
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:42:38.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB1131

check_mbox_seq_id_and_seg_len() validates that seq_id does not
exceed SEQ_ID_MAX_VAL (42) and seg_len does not exceed
MBOX_SEG_LEN (48).  However, this allows the last segment
(seq_id=42) to carry a full 48-byte payload, writing to offset
42*48=2016 for 48 bytes (ending at byte 2064).  The receive
buffer is only MBOX_MAX_BUF_SZ (2048) bytes, resulting in a
16-byte heap buffer overflow.

The hinic3 driver already handles this correctly by defining
MBOX_LAST_SEG_MAX_LEN and rejecting the last segment when it
exceeds the remaining buffer space.  Apply the same fix to the
hinic driver.

Fixes: a425b6e1c69b ("hinic: add mailbox function support")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
index 2784127327e6..6e67a6c9578e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
@@ -128,6 +128,7 @@ enum hinic_mbox_tx_status {
 
 #define SEQ_ID_START_VAL			0
 #define SEQ_ID_MAX_VAL				42
+#define MBOX_LAST_SEG_MAX_LEN			(MBOX_MAX_BUF_SZ - SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
 
 #define NO_DMA_ATTRIBUTE_VAL			0
 
@@ -372,7 +373,8 @@ recv_pf_from_vf_mbox_handler(struct hinic_mbox_func_to_func *func_to_func,
 static bool check_mbox_seq_id_and_seg_len(struct hinic_recv_mbox *recv_mbox,
 					  u8 seq_id, u8 seg_len)
 {
-	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN)
+	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
 		return false;
 
 	if (seq_id == 0) {
-- 
2.43.0

