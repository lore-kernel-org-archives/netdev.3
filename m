Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013072.outbound.protection.outlook.com [52.103.51.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A739021A;
	Tue, 15 Sep 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513053; cv=fail; b=gnZS2hO1nFdJaKTanDJMo+cKvRzvi+e1fY1B3sn2Uo/UhgpjmoIzf6HH8o9ouIx8fOTcAeFx2WlsRgixaKEOpTSNtVLWV/LHMnK+fg+XOWITm+vxxJU4rKMsp8bYDg2/c/ghV4mHp+2jpfUY3WKJv8fsWvGlxaPe//dTHpTcPWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513053; c=relaxed/simple;
	bh=UMWP/iPUSaAjauuAF4UyvFMuAthfXvbRxJ42gJ3pel0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K5Czrd3eE8Qq6J08RWD9lvxNPrQUkZ+dTDZGok5zGsUC4obpJC3PD65WBMndRxRv6/I6eyNTe66FofewxjgathYv2y1ZJPkPtSFHRf5WoJt613WQyC9hevkJH34zxtRCWLfzY9yI0BZrofu5pxZyZHPW/rrBl6xlTLzyhgPFN+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=PSVY9WdD; arc=fail smtp.client-ip=52.103.51.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="PSVY9WdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO7E97XMasxeKcs8E4gJzJJwQO7LOsKNKzVqYkm24G2e1C36KKj4hNLdAZreWQUFflQhTLCGxnAgscDEM9fHRDr2BcLivaNnebx+j+P9AMuo5lgTt3ITR4U1ttOnBptg0IXWhCHicss7Ok5BqBRzJkq/1WVwTGjB6I5DyYv2X2o96mKKc2aFtMms9MjyzpSlS0QceBl4bueM0UKmeT0oobrXvx4sWyxA3jbdlH6kcc9jjm0bwBtF3YLhE4LYmdaioh9nusQUk44xDHSyycwne/RWABEScHVNvCBrjSQ+AqBk1CIg2JOWrYUbCu9ZNk08XPbsV1vQX9sHwGEzQpTh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKU5cFJNvB8awsIUsFSpI9cKfOF6KVxCsQG3EP0RjDE=;
 b=Jv9LOMHkCOAbrxSgtgZlypEnyi44B1chM8e3uuMIs1Xzm7XX5gLNh2oNc6Vz/KVjHpLNBa+Yf8yJ7TJddG9FXAxKCsw/p67zWHj2Dp2cE7iY+MS6qarB4wWw3Gsj//jxKOp2/b4Bpc1I/q2xFsQS+fuou/oi4FapSpaz4jS36uGe8m8IxkV4hQOz/mtIpQogjqutDw0AM7850urXz823QgL9E8rIik1bgQM/ugkYnojl0kZpnzXsaO1B3rg8qN0QU3k8zpCa7UydZ5xCJ01HWPAs/Cg2X8X/cOGqI6FuvJYT0z0RcS+dFHM0bBDJ0bYWS/+ARpV9TAS9KW6KUBKMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKU5cFJNvB8awsIUsFSpI9cKfOF6KVxCsQG3EP0RjDE=;
 b=PSVY9WdDtQGrVz1w+BfaxFl5BAPHtogiV/1T+AdRLyAMnNpAOzRlfBfL6MeYZD6Toy+0Dyq9ddpaIolYocytJC+J48u8Jk0VH6C33BPNzyG7mwB2NWD1yxQMx0xDjzm0oUpJHjnG23gcglPXC+VN8qqvWL/N/Z+oI09m9FMuLpceN8e+WXIxoN35qowPjEjRf4XIXY5xFYAdvgymYusafGRTLNejulPFskBbuzAVbIr1byHep5QwpBnYrM5T3jcJ5fF7FqoQ0JW7v1C3zecAth4KydatRuawSLyLaUwip/WTsXPlzAAHLLbT+RieZFsc9bQNEXQA1I3JujmH/636AQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2PPFB01012AFA.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::b64) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:57:28 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:57:28 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH net v3] net: usb: asix: reject a truncated Data header in rx_fixup
Date: Tue, 15 Sep 2026 23:57:24 +0100
Message-ID:
 <AS8P251MB0001D5442318B9E58797D230C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0586.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::7) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260915225724.15630-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2PPFB01012AFA:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da0df50-ded1-4901-e464-08df137cb6de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|23021999003|19110799012|25031999004|37011999003|5062599005|12121999013|8060799015|41001999006|24021099003|51005399006|55001999006|25010399006|4302099013|440099028|3412199025|26104999009|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6ofmKLk0BSC1YjM6KV/PhXskTYMgQiXb9HcB6XbCxBOOUcO/WgBs6ln/9vx?=
 =?us-ascii?Q?8E2Y6gWy3xGl2PMlrNKvrEtTFeCKK1OBnamGa5vvym0BZjhBYj1OZ9vXsdCG?=
 =?us-ascii?Q?NYwPWrdMJRovkncluBsSwRE8BRGST4aSeXGQRiNk0d3BMGAy9gD3HPz8YOcP?=
 =?us-ascii?Q?HGj7ECOl6aWwxbzJneznfEg7QaWSF/xnqzUV3iu/JpLoq3YwJ6HxKL3JtjPF?=
 =?us-ascii?Q?dAAD801kQmqwmXO8ilCD+fvOZ8sQwsrXfEIPxKJYy8IGZvQTEgWWGbjih6m4?=
 =?us-ascii?Q?JJo7HT+xHWMHWYxHBK+M9eo2PNznKpUcrZh+d+zV8pJzAH60Vzq5ZWbB7ft0?=
 =?us-ascii?Q?hFgN8Lkagtl1qlDNX7ua1rvIBWMuEHjs/o5ryZaifb/8PJC2aEIhM1vfciNW?=
 =?us-ascii?Q?U1CrmIXZl+D0Qo8FRyg16oPyI042oxnJf7g/GmRSMzL1KrUYJ3JfSjbM3/rI?=
 =?us-ascii?Q?afThfEoGqHm9x+cmDH4MoBeTs2JUNtlUvSaL9MLslCrGqpnkMMsvoiQsjhDJ?=
 =?us-ascii?Q?am7kT+cj5tJFE959LtCYWiF5Dn6a4vQEZ0B/0X1sudYIphOIlZp8kJJHLio3?=
 =?us-ascii?Q?uxqdSOizhcbz8ZXW5gAoU6LOw5sxpMFSdPZ28ki76UkKv7POkAq5+bBPa0WN?=
 =?us-ascii?Q?xpJaOtk1pU5Li6b3qlpqxSTT4YTXyjJuMBdqLY+B1e0fV/z2tKeFPTM2Y4b8?=
 =?us-ascii?Q?0bjlaVtQylukSCaBT5JckLisbSuk7DUgRHfqFNv6LfpBcJNtaEmQcHM+6b41?=
 =?us-ascii?Q?tFVvG3ngXSyfE/J2YgmpWvB0EvWBdb2DcYeI/oVkpm6otGoiOnEHBTVpN1iL?=
 =?us-ascii?Q?RhkYUKRwZf3rWPkN+5Arqh8EyWHyjj45SVJtY4LTENQNBin6jn0Oh5kpW01n?=
 =?us-ascii?Q?bQFp+e/2XYYs5kzn57wKEbKdv7VUQWuthwWAe0sfqQRceXH+9bc8Y1epZi6y?=
 =?us-ascii?Q?UOwxTAjs74usJ1o0p1j4b3lN3NSK8AGtjAqtG2FKPJWXxP5wL09XprlAs45O?=
 =?us-ascii?Q?3ypzs5HI59bvzN5BN84+dkwKlZ61qHaYScO2e0ih+U/QM1SsHrQ1HteGzzkS?=
 =?us-ascii?Q?C3BulcsWsYvcBzSFqFov1P5yfahYgOgNAINvnYcJiFdJ1foeuzNvhxB1zG6E?=
 =?us-ascii?Q?0sikRvS18j/KkN6GbewbYdMDa29ppRSrCtF9A9CNDHCg24Wj+zMPT+vBmTJF?=
 =?us-ascii?Q?8dkgu/E0AKV1GQ3YcI6qSsFiIPpGD+BhbFvlZ5pHg2QPxYw7/23aSjsabn/J?=
 =?us-ascii?Q?5MugdSzjHpEISak7CR3J?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEutnf06Bb+BdKhIuiCgv1+UKmwQHVAzY0ceaam6uIga4+LXQOe9/fHAIobg?=
 =?us-ascii?Q?z8S0mjjdkWVat0/EcFLdnViePHsWkGhBYghTQ0i50QoH4Z/LLrMWWE2ILJ2H?=
 =?us-ascii?Q?BlAQoC1fi1MxcsMmbxYa0f1N+hSuyZpmqizARn7ZOiljGZOPv1YHKwbQyOpv?=
 =?us-ascii?Q?CKDSdmRhqzeeipPfVtERYOevR7DIC7jRIew/XXUaW09jq0rvGydvNeVKZL0R?=
 =?us-ascii?Q?uMBm1g1nOYMMTJ0lU4sV39GO2DXLvQozOsCQwA9moqze3YYCKMDU26wB5aDu?=
 =?us-ascii?Q?vj7JYqUtC8OuuTkikSY4BXipI8wq5WJoMc//5lB9k4spmVJ0OaswsD+T+WZ0?=
 =?us-ascii?Q?WXdK19Zfq+KrKBpv+FXAMOmWL4FRA6XsWUfgHuvkTZe/el7fjYeRyCB71kNb?=
 =?us-ascii?Q?XFHPJYifs0lMDR9htMgAukN6tpNvXHeAEmQ5q2vXQauEa4Nyw2fQ3/Z3Uq29?=
 =?us-ascii?Q?Omkn8aoDaQ+/qfyrHKbsxMVrmX5+5rihofFcckuuFOKzScQ4zUxXkAhP2Z+k?=
 =?us-ascii?Q?6OizfA0XorHdNAPzzcpEbfAnfTSbM1raeYFO8QPYfLopPKE6z66gD8h9vq/H?=
 =?us-ascii?Q?EyJjhIB2gE1vBK69uIA4gH0XhiWvC++wAUNhaCKVcBQrTSAMeWpB92llvboq?=
 =?us-ascii?Q?PHVVN1d81yEm256yI3ahGSWAIOHcTpwjIWT9dzCUYQT2FfEs1GcDt/E9Ts79?=
 =?us-ascii?Q?/lro+2yvPiR3QrMN4mz/g8dUFnPlncMa+iTSj1eicp9KetY7HJXnJ8xXBWbV?=
 =?us-ascii?Q?2+10xjDjM+cBOj0E72dXXpnKyuAE4RYIzdkDkyDsWZaJj5BTMeeeyMKyeZoM?=
 =?us-ascii?Q?KkszQQS9opW4cwJHPY0ZK3RdT1qJ7h4ePofVBN+koo5MJOISZiKjbUonD/ka?=
 =?us-ascii?Q?Bf98WiBIqgZ8Wg+fu1VPQyMoK0RHthYTgFn15u8VmllkLvGiNtStPrBIHTiR?=
 =?us-ascii?Q?H+aqqdWQKbIt71OG5Mmn257fngJojiG2DbZ8cWlgCVUobEhVHNP7JApGC30B?=
 =?us-ascii?Q?/1qBqdhPo3DFF2pDuaLMB6rC6XdwmSzy9h6jA9lSQzpZ4Zfcjy5UuOAZz80l?=
 =?us-ascii?Q?rJ4AMFyRaw4CxM8HvgWNi4p7QMk0dPJ+uX3lRwUf1pcJyHo3m86gsMYA0hz4?=
 =?us-ascii?Q?WzgZu10kpAEL5fw/wDz2/Wk+u4fz2A6NxZ6Ci7Hm+EmEdVZab40E3KkYoMK3?=
 =?us-ascii?Q?7FQEu7EZr9GU/iO1RfnoEPZSuGCmyX5ysr53Vt0on1AwJTaaANEl030Up2w9?=
 =?us-ascii?Q?w8GTeBFjP0V4aarzMBDC/zDcvRejo5NPb8Pi/dzUF+mntna522t4pyd7KdvT?=
 =?us-ascii?Q?yLkTNqyujmTjN8txP2+QgOCW73g5LOiLpzgEdJEdKLABxaBDmTuiVh8x6iCM?=
 =?us-ascii?Q?9TnyOW2fEqS5AJ7wvs1Erp5UvPBzMwunmZh37G4xfo8n3yszvQyaSuks3wAp?=
 =?us-ascii?Q?9idkMRv3UzgYR04Opt2m8NhSazQL0VWa?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da0df50-ded1-4901-e464-08df137cb6de
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:57:28.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPFB01012AFA

asix_rx_fixup_internal() runs its parsing loop while two bytes remain,
but the branch that starts a new frame reads a four-byte Data header.
Only a two-byte tail is special-cased, via split_head, so a three-byte
tail reaches that read and leaves offset at skb->len + 1. The clamp
below it then takes the unsigned difference skb->len - offset, which
wraps, so copy_length becomes the full length the device asked for:
skb_put_data() copies from one byte past the received data and
usbnet_skb_return() passes the frame to the stack, before the trailing
skb->len != offset check can report it.

Reject a Data header that does not fit and reset the parser state, as
the other malformed-header paths do.

Only a device emitting an odd skb->len can get there, since offset
always advances by an even number of bytes.

Fixes: 8b5b6f5413e9 ("net: asix: handle packets crossing URB boundaries")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---

Notes:
    v3:
      - target net rather than net-next (Andy Shevchenko)
      - trim the last paragraph to the offset argument
      No code change from v2.
    v2: https://lore.kernel.org/netdev/AS8P251MB000193C798F98A11C73C3E9DC8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
    v1: https://lore.kernel.org/netdev/AS8P251MB00014BB4591CE6011152DB4FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
    
    Built with W=1 (asix_common.o) on x86_64; no warnings. I have no asix
    hardware, so this is not runtime-tested.

 drivers/net/usb/asix_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e..8c5f863 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -179,6 +179,13 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
 				rx->split_head = false;
 				offset += sizeof(u16);
 			} else {
+				if (offset + sizeof(u32) > skb->len) {
+					netdev_err(dev->net, "asix_rx_fixup() Short Data header, offset %d, len %d\n",
+						   offset, skb->len);
+					reset_asix_rx_fixup_info(rx);
+					return 0;
+				}
+
 				rx->header = get_unaligned_le32(skb->data +
 								offset);
 				offset += sizeof(u32);
-- 
2.53.0.windows.1

