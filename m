Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012011.outbound.protection.outlook.com [52.103.32.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47884570FE;
	Mon, 17 Aug 2026 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996078; cv=fail; b=lX7iGRwqHAWrE8IaatOBc2wTGpWvgS/1VwXzEsd1AazPkVaWCd38V+K6/BoE7M3Pw+AV4Ok+4CH4Q48xrfmap4rNpapZ5zR2UD3l9Uwj15FuXopaX8OU5Jdk+F9LnHPJf2SexBiqrhGF5KmI6yzToalAFZXKkCBhdV4M2QqAMyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996078; c=relaxed/simple;
	bh=zrENmiXANfVgb6C9VgvDiFjGspJu9kC2CYBMMZFmK3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=juwWWN19+ZEHoG213TC7ReeI4lXMHXtIXlJQn1UQoa7T7FTWaUNfBDbKeobhfeyTGAcEy/0X+hXoC8tUPxoSxOFXmiNJInsv+hJ0k7m22CZSki/un2QFgXiOIC6IVc0AhG7GukSb4LoVT9qW9ml7Hva4A5ivraEbp0HLSB3jMGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=QThWjLXW; arc=fail smtp.client-ip=52.103.32.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="QThWjLXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb6fEwvByO+owNN5MjFhYGObRJDYoqxQnyNCp3Z5Icsd0WI9OsG0jv15Nv6P/9mqTQ5bC4lFJB4hgZyfhkKNaw0UtbbWnNDdKMVpuVo9eEjT8GCXKlalt3BKf3M27rSIaEOU4g6fE7JbJ5OuhNL7sCJ1ILvQ86LoMSNJfXu5dQpEYwckk2zbYTsh/gLHxD93M+DIBUSvAj05f31mEq76ATzng9wN3gbnlvIB26nYmXTZ+kIV3QMTazBucM+7NbRBPJLwmthA9CoDf891ONyYQ3FETZC4ZvnY7ensf+Zk89zHnC2rxSJqBy2twh/FIbhGViPSFTnLQtCOK3SnpjYXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EslrGGMJkuyf3hn+hnIi1xHzAFL4/G8Yxk0TlHaSJhA=;
 b=v8uKgjfhAVLQOAZtuuA92WCytTlS/MBqqB6eVpqtzLNkRCvcnz4OmWbjR8A//+3nZRBVD29P5aJRFy7/W4j0w3xpYyCJvJHSKyMGXhHxbJIG9Fn8Cnzp/P0oaykGHsF4JgZ93/073e+fXxwr8rzm7NQqk0/4uQcQRh6KNrakQmh8bZxQpXQqes8tZnrRq2wzeIC4vjK+QioittXxYognFeEpnOTHhJT6QveWFbobsc8RAp3qiR8vlqbzQhiMRrkWdMr+gPVUKYdv/YV2srRZYMyqaeaTu+9u7zC1RPw6ID4GeBgugWf5WX6KS2CYLulX6J9W3lHJPYQVjs12fU/egA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EslrGGMJkuyf3hn+hnIi1xHzAFL4/G8Yxk0TlHaSJhA=;
 b=QThWjLXW+OZAdNmIbIxaMAVoMGUbuXqcyxjfSvm7ejr5oiEuEpnbBmZBFo5ZSiTFFzY0pN1nP+wZspBXsr2d4x1NL6urR7Mxh373w1eglCdgVZ0crQ/PdZDdUQ6w/K8zifMUKBFo3SFgedc0Z+1o82uzmY7oypZ/pc5HXppHCiESrxur3coKbTlqm9EMepBMqUi14JqFfLhZS/sMDfq1KqbZdzyX8GBQN5ZyHEwvKttfrjBEa4Lq+6+3U1MKd9DgjVmWT/r/L4lJpsihuT/LJt9ZtKU3dvXcU+/kJhTTvYGSeEt0/wr4KO7M0f3hclmGw7ub7jKew8xhFfqlDzSDKA==
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e7::24)
 by AM0P194MB0579.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:148::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:47:54 +0000
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb]) by BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 19:47:53 +0000
From: Jason Winter <jjx@live.nl>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@rainbow-software.org,
	gregkh@linuxfoundation.org,
	Jason Winter <jjx@live.nl>
Subject: [PATCH net-next v2] net: usb: cx82310_eth: bound partial-frame remainder by current skb length
Date: Mon, 17 Aug 2026 21:54:34 +0200
Message-ID:
 <BESP194MB2832095AA142E77E4F39E33EB8A72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e7::24)
X-Microsoft-Original-Message-ID: <20260817195446.53898-1-jjx@live.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2832:EE_|AM0P194MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: 665e20d6-972b-4a6f-d05d-08defc986d91
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|41001999006|24021099003|5062599005|51005399006|8060799015|19110799012|15080799012|5072599009|25010399006|40105399003|2607281247196008|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxEXaCmgDvBXWkBEQ9XWEmvK9bC+Bz2kNDgGom04JEKfEut/3TPD2e1mRYcB?=
 =?us-ascii?Q?JSZJeug4dEJ7XW6NKAiaCO2LDnDsrOwc0WxcVOWFaQa3zPzdPk/KyLKtwcp/?=
 =?us-ascii?Q?cdBB0YtZgRkIbQc/s5qB3udfjKdXLZbSJpKGjKHZVR8SzlBiR5mslWmSqtaS?=
 =?us-ascii?Q?YNsiu8Vh5LKHEHl6W+c9pcdFzr2mOfaPELvilq9mG+R6FXYeAhzdfs/KPhQt?=
 =?us-ascii?Q?yEtmQVtg9ROswfxhAjYN1ggCKrj/wQe+9Xj8rUU+WlyxtzIV7UGwyF3eJHDU?=
 =?us-ascii?Q?tHu+o2MGaUIJ8cdScJNlUBgsNVh6CaegpVk//O0l1aSgqz/jnBKWYg+cdNgy?=
 =?us-ascii?Q?VfNxsxjKVeelSTRMElEixDclzgZvsxul4p5oaQ87nY80SmIgStvEnUNyHJ4g?=
 =?us-ascii?Q?VnQqIfYuMoop3EkqXQN2cKh+Ev+Yc3k+s3jabebolLpWZ8cWU+9Z/Nb64Kma?=
 =?us-ascii?Q?lVhNq+jpnyponhT2smuCug1K8mGm9dFKZiFmitNTlrXCwArKzaoYTPgUwZDn?=
 =?us-ascii?Q?8tE2FQFKIUo0Zo2GGhCaVYMvQPfQlhjgqkyC/7lueYVWF4L/k4fZCTrOAAtt?=
 =?us-ascii?Q?XoNaYAX8KXc6ELwlQSdpS7v2TRyoOWsDRkqEMenOIQ1e0tuNj8kE5zQaf46X?=
 =?us-ascii?Q?kmZQeAfyOWCx/jNb2ps48cLV+jEZBDlaV5iekTlg6FvmFqy8o9J5b+pWEb+a?=
 =?us-ascii?Q?WIYZ+HBWAI5OxaSB9UXvus6JmI32xOxp3CeJlu3dNo5P4MTk0l6asM+yHb6T?=
 =?us-ascii?Q?epAAyeyLCH89EDXHC7ntkBe+dxWQaNkfHbeo03mn2wjpQw+kdJLdNREIe0Rn?=
 =?us-ascii?Q?IA1SGKVcWC/m8zOcMo2MAaaE6TVJTG/oKqbKdCsPfXZaxqU2Emzd9eP1nMNh?=
 =?us-ascii?Q?dfKw8HmeoC3zna7T5CQuvDhLRmau0Kvtv+lHrGTS3PSeBHGZpJ1wRo114WCh?=
 =?us-ascii?Q?mbD1oW/U8LaXMGuQbvxOxe3CN/ztwe3uR+0NDK+5vkGHuk2IgomLMD0V6vAj?=
 =?us-ascii?Q?NDD0OrRjThs4FhF+dYZS4tEVwA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PtentiI08VJmXv1lqCszdn1vX1Bc9An3GLvr3rXHi/CGIYsZ88sv9RaaviXw?=
 =?us-ascii?Q?CsrsJ2/UPNiLPbqPGlqOJgtzopdDXeBHm6O+CBbGOegrUM9QOlbCU3CmA5+E?=
 =?us-ascii?Q?PuhhGqu5J6aWvlXL91VCdPkg98CfRIYJYkMpGtr3yg6/YiXGIfqDtAJqG+fL?=
 =?us-ascii?Q?EljEIKqCyNr1/IqzVuxZMdF473XE7geWZES0nuJ0XKWl2DKaPl1YG4ST/SsJ?=
 =?us-ascii?Q?j84wmIsZG/KS9gFRcGcqyj53NO2d2Z8K+K6ppBtiDjqhOHGcHBtpxqSOoU8p?=
 =?us-ascii?Q?dBy1TSnLU2KmW+IbKUuzLcvtp4s432TpTc2AstQCTaRZbCyr0tFf3eET07y4?=
 =?us-ascii?Q?5B8K3Cz0fqngxLqY1x4jYs2aZ//eqkbJGSDoxt1XA1fv/IGyddCWQ6WbsOk7?=
 =?us-ascii?Q?JC26GLRCEpekcAMgVtlzJyP5OOg+WGd/mcvhDhuixeagi8Xev3+obaxd+VRG?=
 =?us-ascii?Q?QvC58+17ImLr/Z/GQNugFTqrXDLxvyEGNTpexpoaLy525rIRwLAiKfYXtmdx?=
 =?us-ascii?Q?oTuobT6ZDR/fF+vju8MXAkDPmZf8faHkfnUwhlVt+zbIF/MBs85lAHse7lxS?=
 =?us-ascii?Q?3OHrFdGETrWRd2BAlfZsua1ZDGWMmvaNVw7iFcORDdI0zC+Gf36zs47yWBV6?=
 =?us-ascii?Q?/Bfcl6SGaNnFekOlPq2N6Gnrw/NwkjUJit4Hkkl678cCjxrWmfy2pG6oftaq?=
 =?us-ascii?Q?1r1c4aN76LfYXA5Tdm4vE7p5is//upXUkJ0EBZCNM7wOMoZyvEMpeeZy94XJ?=
 =?us-ascii?Q?tm/+CHTOpqsO+iWfEiFHa07i5m9cfxdMr4wozArEa9cGFnHpOYPJ5KKsYpBm?=
 =?us-ascii?Q?EKC/Tcoio80LthkEteWQa1kQHv7ITfDRxKBTIjT9HjvO9SU6oVLD8N8NMOFo?=
 =?us-ascii?Q?NvEaXPo6sN2KNfDJbEF7JuLMN8BNJ2rUy2K7TkaOG/kzKyUBbISV6BmmVw3x?=
 =?us-ascii?Q?ijKQTKuS3T9/OUZf+syqjVCtRdPfkqbt7Hdk6nxof1OFuNsAwD/RTqjSRPnt?=
 =?us-ascii?Q?X/38Mawzx2zLhKCVA7OW0uXXyRNE1RGXalKq3R1NGGCHM6M5sQ1tACuhCgYU?=
 =?us-ascii?Q?VtbxJ8v8wUMBL/GsGiNILDjGAaT5o3GpbIdq2XIMekIkB9Gcs+kGs52mvo6H?=
 =?us-ascii?Q?lZ5Eqeuw3hupb3cc+qhtMpu/vsGtSRexVX2iH9xEasjvmikoKL6YrtbR4HxK?=
 =?us-ascii?Q?44U8PUqMcN4t0cHfSRjd0JNntTGNIU87Db1HTXLq4VY5HItPKQcPvGfNYZrC?=
 =?us-ascii?Q?M5yVTlxprVBPZJgmPxAzPrlPI3QyAcaoQrFM9VWFMt5qO5LT+sVCPLPO8dhT?=
 =?us-ascii?Q?FsuvtjF7D49lfyfaShWM6+u+eNN5uxpVy80eKJo1T/NfwnSu7K9sTLA9qld4?=
 =?us-ascii?Q?IcCupLc=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 665e20d6-972b-4a6f-d05d-08defc986d91
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2832.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:47:53.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P194MB0579

When a frame straddles two bulk URBs, cx82310_rx_fixup() stores the
number of bytes still expected in dev->partial_rem and on the next call
memcpy()s that many bytes from the new skb without checking that the new
URB actually delivered that much data. A malicious device can declare a
large frame in one URB and follow it with a short URB, causing the
memcpy to read past the valid skb data into uncleared bytes in the
receive buffer and forward the result up the network stack.

Drop the partial frame and reset the carry-over state if the current skb
is shorter than the recorded remainder.

Assisted-by: gkh_clanker_t1000
Signed-off-by: Jason Winter <jjx@live.nl>
---
Changes in v2:
- Target net-next and drop the Fixes tag.
- No code changes.

 drivers/net/usb/cx82310_eth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 068acb052adb..8ca6b75fdd20 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -251,6 +251,13 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	 * end of that packet at the beginning.
 	 */
 	if (dev->partial_rem) {
+		if (dev->partial_rem > skb->len) {
+			netdev_err(dev->net,
+				   "RX partial frame: need %lu, got %u\n",
+				   dev->partial_rem, skb->len);
+			dev->partial_rem = 0;
+			return 0;
+		}
 		len = dev->partial_len + dev->partial_rem;
 		skb2 = alloc_skb(len, GFP_ATOMIC);
 		if (!skb2)
-- 
2.55.0

