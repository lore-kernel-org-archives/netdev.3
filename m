Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010004.outbound.protection.outlook.com [52.103.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F21DE4EF;
	Mon, 14 Sep 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413849; cv=fail; b=ib3mpMkLaGbQFA+s2ZRFA7zn2zfLe//Z/a1nT3z73s8LVHg8trcnb52/KnssS0jngdwnP2wJpP2+LgpUusznjy2S3O+NLN+LxcajRUw0QlWRk9VLXozJwz7Z2/6MwkrpIapXfEBRTlBCMMkovCqi9QHDG5qbOg25AYL9dXxiKEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413849; c=relaxed/simple;
	bh=7+1nzzyti7omfhyGf5/GHFhXoFL7txLTc3YJVsRqG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T+kimBKlgX4tfE7cpn8hRwfWFI95VBRIMJcrNNz0lLn+ci6gWJry3ve8HFrO/IzSGM9rLW/RsIGIms0zIbSR4P2nMOR2nKM11MhW/VWV//dCYx5E7Ef05vJqpkZJKyjNqyCz9MGDbRYOZ6BxQKJnNJGd9Q0PSGF2n5wOlqIhUJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=gfJ8U2L0; arc=fail smtp.client-ip=52.103.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="gfJ8U2L0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0PnI/c1HL972y9RqWfm1BF7VzyucGRsu70i9uMvKpKxkp+klDtWbogOOSVlqohXBPAxMateyXDJeFPCTM0nMejjSRAJ1C8Uyzw4N8feNGpNhfIU9brxD4WruklpCza+UqMlg1pEoKbcQvOHxfi8jy5/9lJ1oThRrnIp9mkh+HIWQTlZnrzJGfqbbDhYn8MwNJtOSdXcCW9l/FghHLK6bJ2Kwi/H7hElwQIiYdGZyin6ryiNPPryJ4ch2EAXnmFCL6G1Iq5zqrsyHS4VjDccWn38mB61s322i2dv2cZ0q2Gf3pH1oeHYgUq1uDm0gdH05gnLIicwP6VeFZvfOhLUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8ZfOKraQplgbR8r0M+qZzL3nRgkeGcz9IPoEviw+T4=;
 b=B0lVH4zcsAc/1gWFctgFSqkTPUg5JD1lWdN2BJM3fMWUi9xWv/4L+3j9iNT7CLDqMCgpvfJc3KeRIl+0h5kyaQ5LTKiVgMFcPqb5uqZqfJcH9rdlQhm1K8CtU1S1TfgxppGDjPHaFRLd7G/JlhsSZDZ+uCiGivM2jPumo1fIT57m1erPp0MnYVDOWwRDJIVwb3Ign94xaCd7RUySViHB7gvoTCbOIj58ARN5RlMCQGeWvXxJ2duEyX1jsSG4CL03Ek1krNA2LiZnXrPZaGmLshDRPyXyRFhf54+q6JjqvyJV5yBfw9i1GCKwcnPZ3faS5VTZnNPWaUNVaXzxQMEhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8ZfOKraQplgbR8r0M+qZzL3nRgkeGcz9IPoEviw+T4=;
 b=gfJ8U2L0kwZZcfevRTV11Ak95cDqmCNJCJJVGzqSKtzHueGKLY0KyhwYbPrwsep4wStS2xbjjpxXxQn9SbX8WvmvIm3XgAyLxtKpCR4R4cynOCFqAqew5rOCWR8Z6DJmcLsgmKY5G/iep3cH6Mvi9ytOUvO2mzLVCMyWtw0L7h1VjbcMGsoeiHNCFeAgWvftSQG78l0EyaFYqCs6Zfd4anQ4Ks6rNHgjhEmffBz5XwkPfrb3xpK+jvUFRI45SgwVLknk2jWSoztAZjThCZAL4aMYxu/Qagc2smNmvuXLxBMndKxWikMHr8BgxG4Z7wlBsvsxERM8bh7Yap9Q9pH3Rg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB0709.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 19:24:05 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 19:24:05 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Elad Nachman <enachman@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Volodymyr Mytnyk <vmytnyk@marvell.com>,
	Serhiy Boiko <serhiy.boiko@marvell.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH net v2] net: prestera: validate num_counters in counter response
Date: Mon, 14 Sep 2026 20:24:01 +0100
Message-ID:
 <AS8P251MB0001EE76C8EC41B2CEFAE213C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0424.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260914192401.111952-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB0709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e564ea9-bfb6-4568-bb22-08df1295bd4d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|25031999004|15080799012|37011999003|25010399006|51005399006|4140399003|23021999003|8060799015|19110799012|12091999003|4302099013|440099028|3412199025|26104999009|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfB9WFcVBEX7W55x/3NS/SxssdOV4TwLEty1vADt/KNL1xvlLmp5TP0BSmRU?=
 =?us-ascii?Q?fCzE50WMFJ/IoHl8AE7MHXI77KguMGyTqfAsgleC3vpIjpgcp+bLZGdqSuIe?=
 =?us-ascii?Q?XEolUtJe2dGwYHWyfUyZbc02OvFSTeESd8s2jdSJbBM7yYjA+rEMDq/RmTOj?=
 =?us-ascii?Q?h5X174YDM+WWYV+eJ9ewDx6q7sEDNfZ7PMvBeRRlhROjfKmlVKxf4xMbgaD0?=
 =?us-ascii?Q?8J77BxqhgVlaCL676WViKVRPtysZu0NuSMIn3eQHwotGASvduKJVMTHu9PFx?=
 =?us-ascii?Q?QrgOh6sNounfboa0cqqhV4mjESKK5sJ18Z6cIOjQokXPKIi2Qb7ScBYSyf0O?=
 =?us-ascii?Q?8BUVZJ3j90XVv9qKYYj2gmNJrEr8JH0hMBST1sKwYK9gxnj5AM30ksdewqEV?=
 =?us-ascii?Q?dOB3nRyjNC9yjBn+ZhKgdjnnk5avfcxz3ynBplptsbtWBiP3US9xe3iPTOUk?=
 =?us-ascii?Q?0wl8BALZ8fbnJrFzTj4bzGxekc2QLiGR5aD2l8LFTG7DW8Gjjv9xG6yUg48k?=
 =?us-ascii?Q?X9Hf9yK2Xe6RQhZ2uBTsPPl7ySo3KbbTIlVLLvPmTS90qC0mAe8XmyHsyMgv?=
 =?us-ascii?Q?uhHWHfYDE4lr96bTgBoXWK9Yc6oMjEHYYoKH7kWDkrSk8iRG29USe0jdwvU+?=
 =?us-ascii?Q?RqRfj04orYY0JDBFfLNMP3u9I7n8Qtu0x6RXjgnvVKhGPL70dc4xsrftRP2a?=
 =?us-ascii?Q?aMKvIFtItzqHZnQEY8oQvDgVus1yiwLMQoLOG7dgWfZzK/+xc+NmauRJfGCO?=
 =?us-ascii?Q?pTsSgDqOSB3URo6maMkW16sz7f/t78oC+WSFCjzykhTGoFB/lGa9T9s+RJXc?=
 =?us-ascii?Q?QbkEoSOVUBJZWuoSxVgVa5KJMYq8fkNELEflajMU0ZVxQ88yGOr0FazgOmu5?=
 =?us-ascii?Q?MIPpeI9Xp8W++bhcodTbAwY/HOxlplQeiB+sFKfO+U1ZgOltOJ1+JSQ6PMmw?=
 =?us-ascii?Q?7rRToW/rS7FQoXjrYEuMbcUG4nxSspsWte06X++c1fYwA12+y7BOfU2qi+Id?=
 =?us-ascii?Q?S5XY3yuyLUKgyxqLaNGPAX68utbW+IQF/xOwfpNRfg+A+1i8GS+Hykd5Ylyi?=
 =?us-ascii?Q?xT75TOLOxzvq6IRgtIl9Sz6/isn0q/fCPvr/GAkSf3lIWMU0JCxVrZJbFUpp?=
 =?us-ascii?Q?442eYsjRgSwmwA2g/OOswzwqRTnyWVl11u0DMwxkZpLLflH+fn0gXTIAShB5?=
 =?us-ascii?Q?KEjy88DzmQRcb1kCmG16e3m0JhzQ59xZrIhBjQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LC4aVnYWsXzN4h9Onz5w7WtXKJ21A/dpkAmphicQLlUF/jAawGaaxU2VUVlV?=
 =?us-ascii?Q?j7QdP/Fatg18Id9I+uGB5iTgQfD0MkeE0yAf3QQcQLyCrzfWgF0JSAgphCwZ?=
 =?us-ascii?Q?OyCpoumBLuQzxFpHZwKgi2cbPmKZoRRqZQADIyYHCTk0LZNcsJZm0A2pmRLA?=
 =?us-ascii?Q?ioqfBjo5D6BBDv7/iI8K3EKCDVzcN245bJCUHSnMB56WmIeKU8i+qpVJZ9SL?=
 =?us-ascii?Q?o0JUh8SBys+/vq2dzDay0pJdxyxN0MzUGslmTR/xVSoW/l9tGePCO2jUpN8A?=
 =?us-ascii?Q?WS3lGX4++kXU2VaIp32etUpoj60kJYAnyKV/a9iIwhz/Yxz8c6upAd5AjwFx?=
 =?us-ascii?Q?Yiw0DWNFFd9CHfnN3vvUlwiSPaeaJ5XyC5DwRrEEnql5mLQcInulBmJGALEJ?=
 =?us-ascii?Q?IU3FjouAudo2qDVyofFVMyMakTCGLcwg2DKJwl7AR1AQGumM1VmQQa+x7nFf?=
 =?us-ascii?Q?Obe/3al5WmeddbZXhdspKz0Xp6QerZUPRrAlDZ42Qnv+Q2xEMjHHNekoBF40?=
 =?us-ascii?Q?B2EwEyq439OiKxzNY81L8u0A6f03T+9DKLr7hbUSGTwPLmh7F3BXLrCpPOzk?=
 =?us-ascii?Q?zVrTbb4AVs1Y8KMLFf1/MyC4bpKpQXemsTE4pyfGHBDDPvMmMfiJ1lPnfp2e?=
 =?us-ascii?Q?Ii8MX80HVPeDZD934+W3l24Vf5uPb4WMEeBgqqM9VCRx27tQamHFBvOTpDIE?=
 =?us-ascii?Q?iU0bPDV2OjeRqhLTo1RuLX7vcm8Xb2Landf7UuiTRqK92Mf7+d48t5XzNoXo?=
 =?us-ascii?Q?3Qwg/lgwLo+/gFJzZjYdhg/dkkAQhRa9+fNbvO7VQN1isds0QAY36nEi1oDP?=
 =?us-ascii?Q?LDvCe2cY3lhO86TWOXAIqNsY0IQYqpT/jrNsHSmIjXpZfDEHZHpQS8Dg/khF?=
 =?us-ascii?Q?KuRSQGNayYnwXLlWYdlMOLGV1UYK5xzQ+ICHFrAQ5WlbSRyDFsmVrqWdpFKW?=
 =?us-ascii?Q?W2gcwhJBsjSO3584L5MSdlJyDWcqyx3lphWi7r368QPBwBe9fUv08MyMl5RK?=
 =?us-ascii?Q?VXKRb3rBiEdCFueI0SB0QehbMSfR1sUaihoSybxH7sDyCnKaCcMYT1MtGvAl?=
 =?us-ascii?Q?uvvrGHRFBSWqG/6/9tG7uJ8a8/V5EChty6LaNrTPy7pS25qZ9UCayQ6s8Arx?=
 =?us-ascii?Q?9OA5Yfpr5hmrJl45WvzPmUlDLtAS1cX/z1bFRLj93+BxHBrLmOJubCCoopjU?=
 =?us-ascii?Q?gv3CUaU/7xAEUhiiD+clUYRG4pvrBo59pRP89c7wXBj4dcyCk3cyu3KNq4sk?=
 =?us-ascii?Q?fCXXfDSvgdti57uSx/rZ8voUAtCTPxgsCUFPsdzx1SPCtBKaJoO51vCAdIiu?=
 =?us-ascii?Q?Eth/zhfwpRxI8Ol10o4T9/2EE7U3E70BrwBj8/kGcQIYdruOCNnZnfXCKWf5?=
 =?us-ascii?Q?HUdndW026Y+6NrCNPCeflxAWdHHdI2gFwT6v/6VSRbInupO1QJRudr5YGubw?=
 =?us-ascii?Q?ccFBgJt3wGSmmgUJKTUees1TLNGx8e9j?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e564ea9-bfb6-4568-bb22-08df1295bd4d
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 19:24:04.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0709

prestera_hw_counters_get() trusts the counter count in the firmware
reply, using it to walk resp->stats[], sized for the requested count,
and to write into the caller's stats array. A malformed reply that
claims more counters than either holds reads past the response buffer
and writes past the array.

The array is sized by the block's counter count, which can be smaller
than the fixed bulk request, and the only caller passes a pointer into
the middle of it, so the helper cannot bound the writes without being
told how much space is left.

Pass the remaining capacity down and reject a reply that exceeds the
request or the space left. This also keeps counter->total_read within
block->num_counters, so the next poll cannot start past the array.

Fixes: 6e36c7bcb461 ("net: prestera: add counter HW API")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - also bound the reply by the space left in the caller's stats array;
    v1 bounded it only by the requested count, which is fixed at 256 and
    can exceed the array, so a block with fewer counters could still be
    overrun (Sashiko)
  - add the Assisted-by: LLM tag
  - name the target tree in the subject
  - Cc LKML
v1: https://lore.kernel.org/netdev/AS8P251MB0001CC8A4737B0CC46F41DDFC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

The request itself is left at COUNTER_BULK_SIZE so the firmware sees no
change; clamping it to the space left would also work, if preferred.

Built with W=1 (prestera_hw.o, prestera_counter.o) on x86_64; no
warnings. I have no Prestera hardware, so it is not runtime-tested.

 drivers/net/ethernet/marvell/prestera/prestera_counter.c | 5 ++++-
 drivers/net/ethernet/marvell/prestera/prestera_hw.c      | 8 +++++++-
 drivers/net/ethernet/marvell/prestera/prestera_hw.h      | 3 ++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_counter.c b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
index 3a762d17ba6c..f261104729e9 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_counter.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
@@ -342,6 +342,7 @@ static void prestera_counter_stats_work(struct work_struct *work)
 	u32 resched_time = COUNTER_POLL_TIME;
 	u32 count = COUNTER_BULK_SIZE;
 	bool done = false;
+	u32 remaining;
 	int err;
 	u32 i;
 
@@ -368,10 +369,12 @@ static void prestera_counter_stats_work(struct work_struct *work)
 		goto resched;
 	}
 
+	remaining = block->num_counters - counter->total_read;
 	prestera_counter_block_lock(block);
 	err = prestera_hw_counters_get(counter->sw, counter->total_read,
 				       &count, &done,
-				       &block->stats[counter->total_read]);
+				       &block->stats[counter->total_read],
+				       remaining);
 	prestera_counter_block_unlock(block);
 	if (err)
 		goto abort;
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
index 7695cbb2ce62..2e5cffefea70 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
@@ -2305,7 +2305,8 @@ int prestera_hw_counter_abort(struct prestera_switch *sw)
 
 int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
 			     u32 *len, bool *done,
-			     struct prestera_counter_stats *stats)
+			     struct prestera_counter_stats *stats,
+			     u32 stats_len)
 {
 	struct prestera_msg_counter_resp *resp;
 	struct prestera_msg_counter_req req = {
@@ -2324,6 +2325,11 @@ int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
 	if (err)
 		goto free_buff;
 
+	if (__le32_to_cpu(resp->num_counters) > min(*len, stats_len)) {
+		err = -EINVAL;
+		goto free_buff;
+	}
+
 	for (i = 0; i < __le32_to_cpu(resp->num_counters); i++) {
 		stats[i].packets += __le64_to_cpu(resp->stats[i].packets);
 		stats[i].bytes += __le64_to_cpu(resp->stats[i].bytes);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.h b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
index 0a929279e1ce..2e9aceb7a136 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.h
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
@@ -235,7 +235,8 @@ int prestera_hw_counter_trigger(struct prestera_switch *sw, u32 block_id);
 int prestera_hw_counter_abort(struct prestera_switch *sw);
 int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
 			     u32 *len, bool *done,
-			     struct prestera_counter_stats *stats);
+			     struct prestera_counter_stats *stats,
+			     u32 stats_len);
 int prestera_hw_counter_block_get(struct prestera_switch *sw,
 				  u32 client, u32 *block_id, u32 *offset,
 				  u32 *num_counters);

base-commit: c297ed90fbba72d32b7759aae362b36d15b2db1f
-- 
2.43.0

