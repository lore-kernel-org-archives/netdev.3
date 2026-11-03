Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697971;
	b=JNB4MbEkkLIipTNPS+AtrfAnw3psbzjp/ik62hlcgfUq5u4L9R1VS22QLpY8OzLS1BJg
	 VePlNM3OWqj9vyCOdfckYEDq7ZT9G5hj2eXsUYDqgJBwy9Mxs9Un1TvYPkPAHYCAxwN2B
	 0Rm7hFUY7t6YCoRrRMJ0dIirp9/uv5TvFSMf2OyUq4SYhOZ1KuB0SMAvodHpUio4V/N52
	 sGUzHfiI4jGN5KC6Zi+6iOpDkQLHUu3hLaAIZGFXFQz3KeUivRqHD3BfPPcTFQzyx37DN
	 GUxwexgal36ochsWLzRhkNcSKwTAdzANdlUn2chhveeIJ+d4fco0sG/j0RbUKB3H/iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697971;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8/ac8w0ML3h6ZO7myNngS/092C0glBOWdrbpDSMykVw=;
	b=Cpb+FpW0vP6AJ+WbUYK/uGMEO9Lu9vqukKU82FzSbvsPqvwTxej7oy0cjZcQgbx4dkkw
	 72OMUAc5XxlKJS6Z8hO9qTd+cBSEw3Lg+kOiHrKdvonrsVA2yhO1r9/wk3saIC2RyQ4dx
	 xGqDnMaQ5pX81MO9S5ENkzfVoGTcrYRg1fRa6br/sSvvcj/5Zxf5+SmVrOKsgHGO7Lyp3
	 ecsfQIuyz0NlBWHkmkM1vaWt5xWU+S44rqvuhp7EgVpgSJDRfC6n1/iXdRdVUCIRgwmhH
	 xq86Cqcmfc1AQGgAhtip6iVnbabkMn/6NcYhM48zPus01ZZP05A6Kz03jfcSz8FKF7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=pHnK9zQb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.126
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD896606A331;
	Tue,  3 Nov 2026 09:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD896606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=pHnK9zQb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX070eQCV9Jhmz7Jt1sGkll8W1cWFYHRoHQuphzb9dc91mtZ50ERH/G2XTP7NcZwviO/tL9py1i3aAIe1lZkDNPdUDO3GH+fYXypMIn9XZwtYSNQU92LlKnfIgMj1lu2Dq9hXnhY+xwukVInJPMmcVuKRxhRn28TkVubylWv00gnY73Q2MwlTP7zq/DqJxnUJZ0sEzOAX2wHLMcVjmItStVHBfbla4OyLJly/DrnM3rYEG+gbCpzh4nPX5PIsrdpkXSwpvWDei9uc5JtBVx1NSCGYimdsD9s5A/0OKXKNnBwKBBSB13cLhjA3hDJ3XQrWBI7VUEs74y/rMqPHRtbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/ac8w0ML3h6ZO7myNngS/092C0glBOWdrbpDSMykVw=;
 b=N+i+q5L608yAs8/5tWl9ewkr+6W4unrf9PPKhkCrOWFWD4I14ZDCjjwVUFTgenOJM+8ftmunOR4sEe+A5KAgCKskZSDKPJANI9GguWC55vSF064uW6dKoZfDKKWrMMngYQz6Flac23OP9WUbLjd2NqOY0HpqAsdSvNEZFNNITBmJ2UrkOM1FS9Uwm6Sg0BQg55xYzw8Hl91VIbtZo4o3Yc3X4OzFMjq32BfNFYs88fnDUpoU43fP0ZLXzFXfGccIdduh9cQxbnGCwFUD70L3pwvvaO0pvBns72BPQMzZxzerYroxYWi3wwJaHjKUlTVBbO2LlTuz8zz/JefJUJU93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/ac8w0ML3h6ZO7myNngS/092C0glBOWdrbpDSMykVw=;
 b=pHnK9zQbqrxYpZpt+Ca7F1KS5evEyQMvxx5YbT+VYFINUW0Nqf5R+xx/eEYmCe+JX5uINHR9MmEVjzQk2DdqMm4DBF+f/RoYs9S/H/GiSGmM4jNPiDWczpZbXH32mXpjdQoW4YD7B3Vxi7GwEvLcWrxGVEn42fvoyArVxbGLebI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1074.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:25:58 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%7])
 with mapi id 15.21.0592.007; Tue, 3 Nov 2026 09:25:58 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH net v3 1/1] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue,  3 Nov 2026 09:25:41 +0000
Message-ID: <20261103092541.273847-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9)
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad1c1fe-15d8-4c17-d99d-08df398c7835
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|10067099003|261102123227099003|22082099003|18002099003|38350700014|56012099006|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	Px0CXbO2w1EIXLbFg+/V4sMaz85YUdQsKsp/iTlyKUcJxgOkxfbeb/POEujPalhvh8dgvERUgLO1IDHdBgPeKZh7YBFolBmJ6dWfEd/7JhBcowfSOt+9MkshBtIY3nQvEo3Kur8ZT/fhb0cBNVCfi9KwXRmj9KC9bFJqVpFF/aoHSNRDeHCq71gPM2yEGRIxehN4rcfaFx8edC4mihJknAs47I7eSF6yKzOEaQ62sepUdAit+jOvFPJ4QwnB9CyGsYOuuZUJqjlFZ+j+w+L3ho/MFOkgTJYDjy/2Y1vc8lLkBbgD0n6jk95rHn9EcJdO0B+2QOzkCNsBpQGArdus//oHg6i5P5kapV5v01bSEoY7T3ijgfyHqf3/DA4SKlW51MON0wFnWy2x1JFdcHrNJyzloGHzfRUlsgYO/MI42QgVn9ziCDwZ1FE/bQ7EVP3sWRIbx13Ttq589ahsM5NsXP10vev/0k4n1L0Ji6OeRIyWltzOEHJZpYLw/LtOycWtone5Syc9azm6wlHv6CDzDCAf1hRRMl+z4T1gytqgnpKtscf2i1rMtTjaHOEzWhF1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(38350700014)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MNE9Wyx0VlgnCuNeT4NXwZWDjuf9KGCDEikrq38iChBz6esh89Iap6+aWPWR?=
 =?us-ascii?Q?bhrktAcz9ynHTXHA6XIHM2APF6Xc8ELQWyZUlgdRMycVCsjZ7vJfBWclWHud?=
 =?us-ascii?Q?C7smPKj7xJjRvJwLReKgbLuA+ID6cOwWB/OwYrb5Q/LYyaXIllsJ8+MqL2jS?=
 =?us-ascii?Q?/FHo753JKDReOnf+DysiyEomZGv1dkF3FGeEzkt5lpQDylo2bB9A/FhUEZN/?=
 =?us-ascii?Q?66Aa69cFiVtBU8I5ZCNXnGGJIDwme3iwQw1ApQgxmryvvOfLYZXdmaE4pCOt?=
 =?us-ascii?Q?8Z4RR6bqxMdqtWbz7Ez1S4fT26iIdbVClPb5gbWgqx06+A8M6wqKkR34Aa+v?=
 =?us-ascii?Q?dHcdt5m2Us6pr0SZw3q/75O/pu6dtPZaFV096cABvQHGGxn7Xd0bgFIASZBX?=
 =?us-ascii?Q?AprizpBjGEFRUUhKGVMwBDl/46A9dCcL+8DxghOP3IM4x6SMQzDOzlEJoNL0?=
 =?us-ascii?Q?qcPbswy4rcIebIpaOo84iIkO+STCV3DvNWg56EWF8c6zUalJixGNBxEUOvfD?=
 =?us-ascii?Q?N4bRNKBaikwqJgdGjuVFP/aUtAGuw5JCZB9uN4g2OqpmnW8VzfCjPG98DUNl?=
 =?us-ascii?Q?pE6flYARwhiRPeYIdZOQObcbIshzz+iL3PxxOaJnZG6NcYjSihk1RYO4B2IW?=
 =?us-ascii?Q?LgtGD0TN6xFEx2OFkPTL2RvGHm8Y8n96bOzdFiFJbRnkFT+Px6pIi6a+fCYy?=
 =?us-ascii?Q?73elV0r0tDa151smtSaweX5VbOZn8Xx2DMitbyxPVhLQzAGpBBCGOjBOlnO+?=
 =?us-ascii?Q?1LsftBd/7ZLdqpp5WfsII2wFZLQf5G7Gn6PmnP3ioyFlrLPVOF823P0Kzdtm?=
 =?us-ascii?Q?KwV6pqXT8hJnGfv3mqFGWyiwCvTLQPlR7GY/TBI3Vlt0RmcvtY+Wlj0HfNVs?=
 =?us-ascii?Q?Y8Y+dULnF5XSV99DLDIsEMkV6hKbN3xG1nVsr80SMrNZMyufpSTuGGXTlRMs?=
 =?us-ascii?Q?umJtrxRiFdWMafCmdDp4hZSM6ib3Fpso2zlCa7Cs0PIKra8R0NxNrULkqmYk?=
 =?us-ascii?Q?Qvj8m86lumTehiy3QhgdA8znJoWEJo0ijIZDAOEbx4sbGaizU0sqDzB9snS7?=
 =?us-ascii?Q?aoDrxYjjaX7Ieox06FmSC7EzidmEysOp6Rhq+0UhM9ey7iqerg1+kVSihq1T?=
 =?us-ascii?Q?I0RIEU7hpZjHD4LHmxzyytXSPegBuuMwHN2NMquJ0FZ1RIV2G1/tA8GkiF8I?=
 =?us-ascii?Q?A/gC66KfzI/FuD58HPHZ8CFWGvmNHXKbqWUm/3Sc+QPnSvVZpWynbOAjFEmF?=
 =?us-ascii?Q?JmEKrm2ZnV9DyWvkex9+VIm9CA9Wm3IUWouOF7y1aRlYFa8B361N99mPtEdM?=
 =?us-ascii?Q?v8UXjisz2HdB2JwWmNY8myWcvJmtR9Ki4/N+RFHRTwlwaQQdOWcCqw9tdDhS?=
 =?us-ascii?Q?CcoW066PiR8Z7txFa0edAKniiuE4K6qD+oxQwRX1AKd22UHnkG2G/FST3h4t?=
 =?us-ascii?Q?tclskeiyLtT6qkPPpmvQ7IbnhjN45/cAL0TZGu+4EpPE/rhicb1YQcsK2i9p?=
 =?us-ascii?Q?AEwyq/oCvYQx/mR6HkGZL7rMzduDrFN35q1AUUqYv4oN4BfAlUVJbaSMEqnV?=
 =?us-ascii?Q?tMllpzLr9JHSlwspqvmHMCsL6UewTDx3Nulali4TUVUGlhvY0Jyt3OpnnR9f?=
 =?us-ascii?Q?++H26zT4pv4dW/4k05gwBsCIV5tm4vfgizsrwW1XL/3AnHxzsfQ8dMHNuAsD?=
 =?us-ascii?Q?4ovbRDCA22OxpQvS/zrlHR/h9oyF/AdlqHX7J5ZiPbwIRh4oldvNqiX++Qap?=
 =?us-ascii?Q?Aq3SbGwpzg=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad1c1fe-15d8-4c17-d99d-08df398c7835
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:25:58.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOZWvaP9ZWvPd2jZIBv6S9/4bo899w0HRIO0kbqmOzxBv7eY+YWdThir3f0AdSFFW7qziIUA0RCfbHdVwVdU+vlwJHjoogzHDoNxeI8PZXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1074

From: jingxuanxie <jingxuanxie@deeproute.ai>

TPACKET_V3 retires a full or expired block while holding
sk_receive_queue.lock. prb_retire_current_block() takes
blk_fill_in_prog_lock for write to wait for in-flight copy_bits()
before publishing the block.

On PREEMPT_RT a copier can be preempted while holding the read lock.
The packet path or the retirement timer then blocks on the write lock
while holding sk_receive_queue.lock, and the receive path resumes only
after the copier is scheduled again.

Try to take the write lock without blocking. If a copy is still in
progress, leave the current block and its metadata untouched:

- the retirement timer re-arms itself and retries after the configured
  interval;
- packet allocation returns NULL, so tpacket_rcv() drops this capture
  record and accounts it in tp_drops, while the original packet remains
  in the network stack;
- a later packet can retire the block once the copier has finished.

Do not dispatch the next block while the current block is still open.
The existing lock order and completion ordering are preserved, and no
new state or worker is introduced. The trade-off is a higher capture
drop rate while a copier is preempted; original traffic is unaffected.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f09477..8fd6372ab59b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -200,8 +200,8 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
 			struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
-		struct packet_sock *, unsigned int status);
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
+				     struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
@@ -711,8 +711,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 	 *
 	 */
 	if (BLOCK_NUM_PKTS(pbd)) {
-		/* Waiting for skb_copy_bits to finish... */
-		write_lock(&pkc->blk_fill_in_prog_lock);
+		/* Retry later if a packet copy is still in progress. */
+		if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+			goto refresh_timer;
 		write_unlock(&pkc->blk_fill_in_prog_lock);
 	}
=20
@@ -738,6 +739,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 		}
 	}
=20
+refresh_timer:
 	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	spin_unlock(&po->sk.sk_receive_queue.lock);
 	return HRTIMER_RESTART;
@@ -946,8 +948,8 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
 	return (void *)pkc->nxt_offset;
 }
=20
-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
-		struct packet_sock *po, unsigned int status)
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+				     struct packet_sock *po, unsigned int status)
 {
 	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
=20
@@ -963,13 +965,14 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
 		 * the timer-handler already handled this case.
 		 */
 		if (!(status & TP_STATUS_BLK_TMO)) {
-			/* Waiting for skb_copy_bits to finish... */
-			write_lock(&pkc->blk_fill_in_prog_lock);
+			/* Do not wait for copies while holding the queue lock. */
+			if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+				return false;
 			write_unlock(&pkc->blk_fill_in_prog_lock);
 		}
 		prb_close_block(pkc, pbd, po, status);
-		return;
 	}
+	return true;
 }
=20
 static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
@@ -1097,7 +1100,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
 	}
=20
 	/* Ok, close the current block */
-	prb_retire_current_block(pkc, po, 0);
+	if (!prb_retire_current_block(pkc, po, 0))
+		return NULL;
=20
 	/* Now, try to dispatch the next block */
 	curr =3D (char *)prb_dispatch_next_block(pkc, po);
