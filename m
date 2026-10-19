Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA03B27D5
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386430; cv=fail; b=Tv171XbRUY4R6TS8mp/cy7+pmnb1M6xDQgnCpCe+qJ6rIoNWXIPFqwXCvv2GIGrapyE9yD25DIKDMim04rt1J6pUZ1Z21v7Ijcu+l9JCSuquAjCQvTGuaYA6fJ19PlPC3eQkyvzpsEzWi1BraBnNGBUYRIauUirU0WcEiWorw4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386430; c=relaxed/simple;
	bh=tASgV4nFPTTbk1q2bAMzmXuDpH0MCrbQExJmlvKohfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ukp9T145VzCzmVJ0vckge9N04Zt+BiahzX9WLDlmunKqKxkcx5k5FZHkcj6iiIX6SKzMfxXVrBMlR/MerpAPWvyoo2DIe64F4KY13SHZVfrXqNdmZ0W0XUTp7VxPdI90P1Ct9LRitLxynZDYQyBpf+XylzZnPh+OrbI4oVVP+6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mNNQwVYA; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mNNQwVYA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPJ/uQLeSxCaO2/lR+lvOwwOb8Hw/6yt5BttsFjMZ2ooMPjN8Xj1lwCzWGTfbSt3zOY0u5k8ZOXcNpBTJIcKzE7x44C/H5tTpYNVq0AVTtwOiXdanbsUFwmrfeEehlEaU7Vsp1jJVdnHjLcqi5OnCAFnVTlZnNKKN7Mj/do/s/KRzyW2qHkSBNc+lkRKPqS+GL9x+uHl/hVM2Y78wff9BDZfSZwG0cN5an8FtZcnLzkSmAkYa4NBdeKtXK3Bfx9yDxrNbPk1eZwTdq+zxX1Mo+NHOukZIiIaKxCJQQsWiiiNzymYa+f+j0T8t6C/dfeiCZqa07mwUjpeAhvSiHThhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qVPwqI53fNq0v1Q5+8bd71LDVDktId9aAQM/xRHSpc=;
 b=QQwlpw6IOiEk7Esj0gaSX2xGMJNde5Pv0g6JUWpsmf93WQkOpmJJWVu8cBAcgC+o69wwEWHw0ycmk/+eriPaUMqz4lWtMgn8N2FY0URl5GLf5DrD8tSk7VRz2VRjabR19vLZWVWx6ogvQ1bwBb+y8DFsvpJQ4zERbeMY65uV5UTMyqO81l/wQmP0jsD6E5njVNrgcjjXSlSp2AKlSG/a2XIfu1ERoVdKosgBVK1O+1zxWR5R7/cW5gk3g6dN7rYf6jXWGj+FQws8BLe0H/aOyzi1Si1YLJmrn7g16azVJAtgUOfhTQ7Bt1DSSa5AOSiBbcBjcRDRyS6uG1HZNCdySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qVPwqI53fNq0v1Q5+8bd71LDVDktId9aAQM/xRHSpc=;
 b=mNNQwVYANj48e9dQVSdahO7dF5gbYCU438dTuAdheWfeLUsYBEExOhW9sg3PcCRQL20esBevDukhg6rdbcJjpKwKXRXAC01oH9n+utQlYoTe2Hb3YqQS3kZK2jWVGpjIeuWNQy7JOuOKf/kgy6jsS0RydtjnLBW6Fj5fLB6WwEzlBwI3z1bUHVhKxMuW+3Zl09xUUj+dq8fF/G/rMa/JSpQpG7OpX9QwtRdQ+EEddQFb/yjGN640A9eMGgSfd3h8GgadknfO1oKUuk5e0ljYw+nrdamgdAQXh52R5lc1WC91en3En7qFftHS9zfkotuJjYzjit9TgIBrWcQM8CfLMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AM4P189MB3521.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 05:06:54 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 05:06:54 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Subject: [PATCH net] tipc: fix refcount panic in tipc_rcv() when receiving shared skb
Date: Mon, 19 Oct 2026 12:05:49 +0700
Message-ID: <20261019050648.287309-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|AM4P189MB3521:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b008325-b3b3-4b79-2cb5-08df2d9ecad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10070799003|11063799006|56012099006|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RAoOtRZUylk6XuqlMjBuvsDJbzVms6iYx4p91YQQzGwimnvk6TLXQTxzaQ+gyQnJTI5cgmfJs1LgBdJ2Z2oa/HmlOAy5hiKBh6USXHr+/TGaGgSecr5PMhTk9lCVPRxQu5mblpvy2ZM9RDW7h8CFNPedDrD1F4FzOBgLaNOe7SJdiWNxhuBwxPzgYykxgyJpl5GlcbQNIiXbY36iVgRl0c6lwGFpe21hIGbkVdSyikYAAmQvEUvEBvpFPzJjJF+VmLzu0dJjTyS5me2U5YdyY18qWsr5AGZiiZn0XNQ+zhBVz7mVA/o57nSaPOIhNIXv7ArDP+ZmIUvBGO+8qrciXY6sxK7sbS+jOWs5YX0GvcTY45JffvH2hp7q/+eV+UNk84/tJWXlabmpMq5+HzfPJio09ij261efgym41F+qwXKW2WLsxRRfHuiCUc5GLR1SLweR4fH90T+75Or/ZMrSIj2zOVTbwQ0YRXBqaelF+zjWq8oYrCX8Gm8e/k56saPj7oAs1AZCm+gpZnRP8q1klfbUdZ4kWS6ZJvKSAve02d7SMqoDsFemdddyFDRvPr+oPdgaBzeGE8yJwjNp0hgveB6QaK8YFd7c7lBJsNovEEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(11063799006)(56012099006)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EogCwmV33NJ1CIn4kO+9IXXXOoAdNpW4LPcgVVBoxr+3Tg15kpel6izPg8ch?=
 =?us-ascii?Q?Z7ZlpxmpNAMigt3j2LD5lQ7ZgRWinMMoahwhF9v5PdMcYxRbqytVQoBTlLkE?=
 =?us-ascii?Q?RHeC/IE0BjCIlF/bii4YUDpJFdu3SDX53Bkuvzvy5ATVujCC8Z1CG1abufJC?=
 =?us-ascii?Q?o+rsIFZoU5xGmLjQMItaEe5nSGy2DELfYOgGPu60Vh8l/69A7IVDwq/wm5Kp?=
 =?us-ascii?Q?JNH6Z12c5+5zl6W/LKy6dyZyyJ8ZxE04r1qftzVDCyXZXd2oaw5+ATjcAhaV?=
 =?us-ascii?Q?uPBl4w8YMyB2l1IRTymolz2aofMsD5DSf5ptvwhGRthbALmIgCkVkOrVtHUC?=
 =?us-ascii?Q?2w2owgwYxKyWGYlah1qnTEWF4VQIEcVXlCzAxPuNmeGx6T/RFob4IKPhkmqd?=
 =?us-ascii?Q?sUAzD2O8eKLHk15ZpLf2tTRgFXvYBpoY6XoDMS/MlTR1yM+IsEKKGl+Ztv2j?=
 =?us-ascii?Q?Y2qfKbR/8DMNJISszru9soVCf/EpONEVxrSBuYIoOa929+WcWhBcSJ/ZLPbn?=
 =?us-ascii?Q?R1MroSLO84kBM0ti8VB6XyQYX2OU9aeo4XLO0YNZAESDQpaIVCFk168ygkxp?=
 =?us-ascii?Q?j+bw8nRR26ryrS4/4NzSY5R1s+nAQjL7idQYDOKERgCoM7C4QoqJ93g+o8oi?=
 =?us-ascii?Q?uGguNqdqd8d7TAJJy6KnyTVIGdIHkKko8QOcNCae6KuFxBoU1BELxJXjVsJ7?=
 =?us-ascii?Q?4mJvGMPM+g3Osl8mdVMeFQUiOKoEB15AgX1Z3rLFwiEYRcqYVE/o1WEr5bbi?=
 =?us-ascii?Q?39EGfAaVX8f7QnTwZGtUD2+LrTnRMgYkittTpoCV9GqwP6mmlCdUkgg30kxl?=
 =?us-ascii?Q?HXzsu0Y4aDncuttmW48L/ArXlJHuN+ltTDhMzaKsuVE8jDjnkoItb3SzqL/u?=
 =?us-ascii?Q?V6IIf+TYFG/aG2AQ6hPbdcW4CtivUYIrg5LPxXETdBFtJavMQq0ioZ/ZOojV?=
 =?us-ascii?Q?mnwiVdl9WUSfZ9LB067pjZ/wbDCvaFxwdCLU+eTZPLXQe2YFrOtGKLKFoDr6?=
 =?us-ascii?Q?L4jolHcgPtoLVape0yjE1fJaRW5bhI++mNMTneA8XKt7odEaf7A9dT39YWZ9?=
 =?us-ascii?Q?VYfw7PAGcDTVUOEGtekkuUkSHVRqX5hkzSvMOxNGCV9sQq5KSCkQz45wRJFZ?=
 =?us-ascii?Q?xki8eYozHpV5TpCl1Fn2Iq2pZ1l1f6i3d25C7mCVR0EirTyCLsGj4LVQaizL?=
 =?us-ascii?Q?GFIh8TJRIHKVPiN+4HIG4i+KHZ7jlC/kRKvglePWh+pkLUQG+cBZAI5IxaVH?=
 =?us-ascii?Q?w6cuikQoW9a25y08zPpDJbgEhCZTjTHoi8DrAzNL3OpVR79LBs/uPo8kD7GT?=
 =?us-ascii?Q?UJp9cNbAHiujF9rl72wQ63gpK0JF0nNTbakiRbUGwQpmswb9ikGHkuKYTYfN?=
 =?us-ascii?Q?WPHH3vY+PZpVSc/QAA67bHh7EZ1fdEuxEOJ5b3l2SzUumorLPCSTd9ZvENr2?=
 =?us-ascii?Q?WoT05s4BURKCSu+jx/wAvH2fC/ejJJ2KlDzGMNsaD+Zlsi1hBG8uPHVThCnT?=
 =?us-ascii?Q?luvh1JWawkstKGUn0uk0MXfXgLof9XJ4UCLvZ+rX4SzAIQgdGj7XVxgYLP1m?=
 =?us-ascii?Q?6k54hIqwTrtmBo4FTAkHqhHpdUGkhpIcgEPotuNLnxaqV4Nt90F1F0Xk0015?=
 =?us-ascii?Q?MwwWW/GBSel4sYym+vNNtVgvMTncZ2Jze3qpUzhhybVJ0eOJaBnAu7CZrSN+?=
 =?us-ascii?Q?2X3mS4OsnbKZTgGa1eyNgiEhLyIsF4VkMFRZZbdx9/WdgmX6C1eB2KojCpi3?=
 =?us-ascii?Q?LhyqPikE+nmnBJiW5nAzA0zO7XIBSsKMJNzd9eUHh9Rh31z35tz2TDQCL7d1?=
X-MS-Exchange-AntiSpam-MessageData-1: VnIRlnMZssJyi2A01MKbMdPea6MMzhAmWRw=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b008325-b3b3-4b79-2cb5-08df2d9ecad4
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 05:06:54.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAWZJyL8yCjmXKEW2biLJhgdquj74vq5xR4cV+9T+Tdp8J5/IDUT7f/FNlE8Eifh3rN/pKhFuZ5zFICZU8oQvytxufXZMRUXS2a4VRssJK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3521

TIPC assumes that the received skb is not shared with other users.
However, syzbot reports a bug triggered by receiving a shared skb:

...
RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
__pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
deliver_ptype_list_skb net/core/dev.c:2533 [inline]
...

The root cause is that local delivery hooks in the kernel (e.g.,
deliver_skb()) may increment the skb's reference count (`users`) before
TIPC processes it on ingress.

Fix this by copying the shared skb to ensure exclusive ownership before
passing it to tipc_rcv(), as TIPC needs to modify the skb's data.

Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.1999@gmail.com/T/
Fixes: 6e967adf798a ("tipc: relocate common functions from media to bearer")
Fixes: d0f91938bede ("tipc: add ip/udp media type")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/bearer.c    |  4 ++++
 net/tipc/msg.h       | 26 ++++++++++++++++++++++++++
 net/tipc/udp_media.c |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..1f8d85e083e1 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 {
 	struct tipc_bearer *b;
 
+	skb = tipc_skb_unshare(skb);
+	if (!skb)
+		return NET_RX_DROP;
+
 	rcu_read_lock();
 	b = rcu_dereference(dev->tipc_ptr) ?:
 		rcu_dereference(orig_dev->tipc_ptr);
diff --git a/net/tipc/msg.h b/net/tipc/msg.h
index c5eec16213d7..4144c3bc991d 100644
--- a/net/tipc/msg.h
+++ b/net/tipc/msg.h
@@ -1307,4 +1307,30 @@ static inline struct sk_buff *__tipc_skb_dequeue(struct sk_buff_head *list,
 	return NULL;
 }
 
+/**
+ * tipc_skb_unshare - make a copy of a shared buffer
+ * @skb: buffer to check
+ *
+ * Return:
+ *
+ * * skb  - Orignal skb or its copy with the reference count at 1
+ * * NULL - Memory allocation failure
+ *
+ */
+static inline struct sk_buff *tipc_skb_unshare(struct sk_buff *skb)
+{
+	if (unlikely(skb_shared(skb))) {
+		struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(nskb))
+			consume_skb(skb);
+		else
+			kfree_skb(skb);
+
+		skb = nskb;
+	}
+
+	return skb;
+}
+
 #endif
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 230645cc01c9..ea1122510d97 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -372,6 +372,10 @@ static int tipc_udp_recv(struct sock *sk, struct sk_buff *skb)
 	struct tipc_msg *hdr;
 	int err;
 
+	skb = tipc_skb_unshare(skb);
+	if (!skb)
+		return 0;
+
 	ub = rcu_dereference_sk_user_data(sk);
 	if (!ub) {
 		pr_err_ratelimited("Failed to get UDP bearer reference");
-- 
2.53.0

