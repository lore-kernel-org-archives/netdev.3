Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013072.outbound.protection.outlook.com [52.103.46.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB1340281;
	Mon, 14 Sep 2026 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421033; cv=fail; b=ftBXUCNZ2zR8xmIhbBKbvQK9VV8PmN5LExV+nMSMUjO4FPJ8WDU1m6jOUz9XjW+dEsucOpoudDpCilSNvoBUsagIWwOr2GOO6gVvs+maH/t3Thye03Ca+VX51ExuTM93gg30wOIhPtkTzEBdVIdFddUQbcAGeUGBfYMMZ7cmbJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421033; c=relaxed/simple;
	bh=JqUCUC8aQgHQV0AKPUH7zpQ88HIikDgHozj4gyl1ZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UqY9OzmVlkEd81lMIF+AoVb3G4glSV934W9YaBZ9PUQHIA5X62JQbDWPO1lS0km2z33GMO3mRd1DvTWfR7fOXnV356fVKlicI5Yc//IH4ADc29YSyrM7EJ01AkCmjvwIvOxqeQj/TY9iFotOXK45nHMPubK8ukfCHL0GqnEaGKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=W0SAP96u; arc=fail smtp.client-ip=52.103.46.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="W0SAP96u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJgErdCmndWrYOtGI3JPxXIyUqbr/7DxV39IA61WM2ICTovg26WUWr/LKVJSxzl5niXdKgElxwh3Gffh9NmcE16dzTY0xkGCb2uaMWPeTUDEUN7CywZNQqme4WJhnO1KJesCfEYnnB2PcZ4XQz4UmESuX4EjBz3klf9NsbREP6bjM6E6FZS7yR2rDOqhKaEtxA8KdEu++JwiN8dZgtDi6zL/l/mVUHza7Yjzgb7JGMXWx2E4MJrlHS6YWjuXJMX7qTrlXa0ubIQGSzsvBOVPLOQrQCuD+lCTQrQIFmMRLvzPJ+wKHSWusYsUXx+rpnOJ/gb7LHv8PrV+EvKxBrWXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyi2BzvhmOlCqydFNPat8tB45Jj/2DtY6YvCyluD9vQ=;
 b=iJm7+LLQY1nF8jdgyGeIrOj6yCCHYhMdiZ+4EByWi4QN09trbYV+c9oBF/MteRimqmjtCZTfk1IkMV8iS3Lo2VTcogn9OPFK0nSAGLUtchVraLciW9JNxsgiWpa7fH8Lai3tW2X8070cZy5E2QhZjXhQNQlZ2VXrj6vlNwhdwkxbJsNw+ZeEXPptoq7aR5asMpSxbkhZrL0gdk6k6IIb7arKuYn4xiIC+6x4dFwnr342PysxY6dtWoZIiT6mqlgfxIZFG85ogm832tal375vzE5pFzQs58TLMQQOiVjC9rPwGF2eWF6aF3cUi/uLHIAXkoMg0I+a6f7Y5PwF03Xlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyi2BzvhmOlCqydFNPat8tB45Jj/2DtY6YvCyluD9vQ=;
 b=W0SAP96us5e2Ksg114EnY+7Fn6ESvQ2g8nnksMmob8mVlwmKgOwX65P4XFq1xhrn3VbiskzpLyIf/hdtCpJvh4qAIBzTb3lw+BOMoPSfw8MY0woKLb1q01MT4lsUe/yfF8VPsqEkXvtmCmLwRDK1+JNi2Q/c8jwYxNVw2ZW/nXJK0WCfrbqk9aUiW96UH5cGgo+Bl0omGsBj/4IC6W/qTul6sFkDFtOmnV7oNxuz8STEvYsbLZgwJTi6hoCTZKMrM813ew2oKQqkm/5YsrjaliALABr6s/3AJFyLGCQ38H8G2xVMbY0hcTUT4mJqfE3f9id/KGqKMov9W3Vex6BX7g==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV1P251MB1145.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 21:23:47 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 21:23:47 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH net-next v2] net: usb: asix: reject a truncated Data header in rx_fixup
Date: Mon, 14 Sep 2026 22:23:45 +0100
Message-ID:
 <AS8P251MB000193C798F98A11C73C3E9DC8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260914212345.119840-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV1P251MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: aa28d2b0-8785-4c35-011d-08df12a67680
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|12121999013|5072599009|15080799012|25010399006|4140399003|23021999003|19110799012|8060799015|55001999006|24021099003|41001999006|25031999004|37011999003|440099028|4302099013|3412199025|26104999009|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XaoofOy8P/QmWi8SSDI3bh+63ULSoMMfgbB9gLihscb+HYXiwCOIAE0g+lk?=
 =?us-ascii?Q?Y9RVISTEVARAt09dpkbBrgDYMg5EM5a90Fo3Pa2dDWXzg+DVAOLCnQqHWWmw?=
 =?us-ascii?Q?RHzOI6IPlFRXTnHHRE+Tq6RPAW22OmSs9kTVoiX1Lqt36pYi5s6kgAsw3jo9?=
 =?us-ascii?Q?qhcZUrzfpdUXAQAr8pwxZrDjEIc6bn4uWlybFZknoWWG/Cjdkkv5d21bB+E0?=
 =?us-ascii?Q?gXmjPJJspCkNYjEOa7nga5K0NLOC9Lt2O/WpnCfXflOX/VDtFZi3l0y11RPu?=
 =?us-ascii?Q?/S15KtBwZXYafkz/ih+gDm9Thp9wMKDWBNqRS5jDzz7C04c/YaGyHxRh9gdx?=
 =?us-ascii?Q?9EN6IBhFDc2EnJKrVhjnIgDqTXwSkweHl5O9E1l7+PjMCbuSroyCVAH3RCGJ?=
 =?us-ascii?Q?Kf5b0C6ZAahvgvcxQeBv8YOSElOe64Vx2aAUbC3QWCsxEFHNO+3aeeJcq+4O?=
 =?us-ascii?Q?OzqL8J3M6Arvikw+EhEMnMifpyTJcUKQrkiB5WbNMz+k6IWfofzj0sc/s53E?=
 =?us-ascii?Q?pVSK11vrCykAQVWlYncDur+VCkugQEnwMjFHGURaCaIjShKNbR0iXgxD/dT3?=
 =?us-ascii?Q?mG9sZIcgvloARjW8l1oMJcXe6pXmh+ffVzTO9dszXKhx0Bjbd575p1P2o9qz?=
 =?us-ascii?Q?4x1mwX+hOI0KxJutPB+2veN8s7WJXVUH2VAvQ8B6FTGpz/3uuCyRzvrai3S/?=
 =?us-ascii?Q?H/fEHdqe9QD3cpN5g4DCTS84yYizoYNXPRcQ+BhbqKPsjveYycjDAwhBREeG?=
 =?us-ascii?Q?GBooDyZEQhEuIeuTEWcLOWsdjE2Ol7UVcvXjJS4A+A4nVN+gLIXN/dl9H+tz?=
 =?us-ascii?Q?OQ1sOqzAmLnl9HJBxBkoI28pbjMeSQzzihZrIC8ljVZrzy5r/8HM9Oc3Kbcm?=
 =?us-ascii?Q?HH9UhCoT9jlNHt+ZpsrWFemj/n95wMSq8KQict5aHGgvb70SvTo8YFCOSWXN?=
 =?us-ascii?Q?T8M/uby3OFOXrUHtFYtILFX14I8nrM8Jdlb+6CL3sOBfN2IevIEfe4xa5oT1?=
 =?us-ascii?Q?8VDE/frpgkIGmeZxIiox85UQBsbMgBp5so32D7eB931EJ8xbMmM/NtQrJCgu?=
 =?us-ascii?Q?zQsr1BMovRv91nk2jWlbiJ1sZdWB7ASo998ilLmGDnWooFaAdRQfLQPbg/7m?=
 =?us-ascii?Q?RXRj8NYxXGomciv3AhIyIxCcRBjZkIcKb6WC7F0ss0pWkEORZtWOxJSp+shG?=
 =?us-ascii?Q?zQFSrD6lWkOqNavEQoBwkMXhTiKQyXtuN2qUiQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HfcdTe871Ow2TwkDeWRcvfOAijNhZKTIwMjxYh1RIfG8gFXSVWfeMhZwhBF?=
 =?us-ascii?Q?wIiJ7g1M9g21Qd92MgW2qiji5/NFNHvBp96UZeVW8eJPHMV3lIqstUS7vJfR?=
 =?us-ascii?Q?3d0qVrgXozbtQS84maT+oVgiKl/ZHd5DfyF0rbcNIIrAvDScuODYZ7prqMhL?=
 =?us-ascii?Q?ioHvD1fWylJIODxYOf2zZmbBUlwsUstqk43Q7zzRarcGUtx7xJGzxmIPgLKR?=
 =?us-ascii?Q?07nHzCqTHLJY6xMQW0DVvqIPvGGApGeFt1Pzn7+4HTV3DcEOxAgRzOI6g3Yi?=
 =?us-ascii?Q?sqXXP5asluB8mCcE904sGY2Jz2ObYhby4a69fP2bGrfYO4L2iO0Henzd1OgQ?=
 =?us-ascii?Q?UQadYC54bVOCyWUB2wkGi+DzvZsdZizQx/vemfZi7DevJX6iduXhud0CSArT?=
 =?us-ascii?Q?4cLxpwlYKB2e4tbU+q4pBmCkiaBVA1vZF0WRnhlL9QQUDOLuu6IIEskp1StY?=
 =?us-ascii?Q?TY+He0uQqyToYV7cX4b+Irj+ctTbq97l5gt5OJCIAuW4pykqBRdy+xeC6Izg?=
 =?us-ascii?Q?tBn3SV5pTqdK7iMZs094Y22a26fmTBvRgekHn3oIS+bADVMBDOh3nCIamUQu?=
 =?us-ascii?Q?T3lq9p0qBpQAAj5qx4ywlSvyOmZe29gARp7H3xi1RMqbgV1+aMstVNWb2fIX?=
 =?us-ascii?Q?UhL0TR2QkJgoeGJe7GP4J3xpaRW4Vdbtxx9P420Ub6bKhG61uGLZw0KKrHpV?=
 =?us-ascii?Q?Zm4hHZ30hgu0D10abmY02O+B7JTbAbs/L8hyU7pR90un8lBQfzJDcrUzhF9F?=
 =?us-ascii?Q?a7SHA+ZvW1mEfRs6A3uIgj7b0H+XBy4Yfg+nOSO6VB8TPfevO4MkGEscz2xU?=
 =?us-ascii?Q?L8yJfk+dHcGEo0nm4rdfhShf8cu9VNxQNjhdwIE+RWQz5Mpy3i53IRl3uJQI?=
 =?us-ascii?Q?7P1U46n4RPCZb/X5jgLxNr3bX9hN+/33+8RybxktRzQ0Ha/ZJlyZiuqhHh+b?=
 =?us-ascii?Q?pPdw+ZP2nxu39nsO1AGBD8kfVLR6jQPqSvmCViEaK3xjhuSdUNNCarB/Yq/r?=
 =?us-ascii?Q?PqKVITB4jMj2yPkE/zR21Zk/SMnbHVeleF0xFNkwSqS/XP6cbANLWlr5AUzr?=
 =?us-ascii?Q?IU3abI/OMvCimvHiTInt6ZGn4yJwimvDnudu4G3tdZ+qPPlGHFo6n7R6fdJS?=
 =?us-ascii?Q?osyLH80Cg8lg36hvNVbzY5ope5f8N5AJ9ico77kmtlhmQe9pa3hOBmJNvIvP?=
 =?us-ascii?Q?4H/c6HjPu2+DsC5C3OzpwuS1YOO7kxYg0YE5VKJBqNdr9ChT6Ndm0NakKq+6?=
 =?us-ascii?Q?P7TZISjUU08sZNALQQic17bi6A2QCQGPtcUewXGZSOb1df63a1htmSiTyPam?=
 =?us-ascii?Q?rYEhNza3eoSTAhfQUuO0cbaNghTGoYYwVDCZP8XnSgxVuWHaiABgau+u0/F2?=
 =?us-ascii?Q?jswNCsi9r1VDkC18elLYtq+ZFqIwF9CvnawoS+d9McvriNZdNszu5RvV0QY9?=
 =?us-ascii?Q?hrBvm7ZO8vlK8o0QoovlxzLMoV7fBBwG?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aa28d2b0-8785-4c35-011d-08df12a67680
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 21:23:47.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB1145

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

Only a device emitting an odd skb->len can get there - every asix
rx_urb_size is even and offset always advances by an even number of
bytes - so this is net-next material rather than a stable backport.

Fixes: 8b5b6f5413e9 ("net: asix: handle packets crossing URB boundaries")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - guard the header read inside the loop, not the pre-loop predicate
  - rewrite the changelog around the unsigned underflow
  - target net-next, drop Cc: stable, repoint Fixes at 8b5b6f5413e9
  - add Assisted-by: LLM
v1: https://lore.kernel.org/netdev/AS8P251MB00014BB4591CE6011152DB4FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Built with W=1 (asix_common.o) on x86_64; no warnings. I have no asix
hardware, so this is not runtime-tested.

 drivers/net/usb/asix_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655..8c5f863efe7d 100644
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

base-commit: c297ed90fbba72d32b7759aae362b36d15b2db1f
-- 
2.43.0

