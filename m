Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013079.outbound.protection.outlook.com [52.103.35.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5636B905;
	Fri, 14 Aug 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734102; cv=fail; b=aoo6K8TxbwME4/3pgvQn/FXe8LTc4PGzFzUiDXNK2rOl1O6olXxhoIU1S+uB4M4WPs4s/gc3hthQCzSoZAVPg5nwt6ODDvtZLTkf9SwZZGME8cBqFZwfRf1syKRYrMKkX9B13n88OCaQTS2XdcmsHvwq1anen7k80e3KmjY9Fjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734102; c=relaxed/simple;
	bh=dpKD3fNyypE7pTAJjxtI5inaGiuzWauqcy56rHtCWQI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PLiaDr7JTuNP1SYki4ID3l7/vMpBakZmG0V2mO8tZJ4a9LwPP+IKd3+92tM83gARNMtXsmTHFXV3EcJUeFA9a075g6lZrWpit8ZcxFABBRQze8TRKLyqR9n9BZfCetMgwdeUADW5/sbp7VHBGZpcHHKMtuVEWvi9P/dc86nVdwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=j98swGI+; arc=fail smtp.client-ip=52.103.35.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="j98swGI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+/dKovMT2dqlzXJWsJaxTpodVenauHsFJfmP8rgj9Zd8UmRfCkZAmITyGENkYdKzCi/X6NJ7u1BFOq7c7nNbYoiNwHNVq+r23i7YFyqdhgJd9pVMCxgkIvGhXzai99690yTXG49vKANtTXe/iGUl/+FuzSEMNuGXz+cQlVhoGJZYROfuU0tsfqWJ8nrArMqOA+Ym1xG43ljEGuG1n/q67OtJBpD93pxjFUyhOaU+XhyC0LVX6YO+p3LxYtI1lrZItKcpmcF7qxvQv0cpW4MmJnNLE8b6t/TOc+5LXtuPnCMqTwKJLUIy/LbSevSXLjg1a9WPjqHVWXAP+3f8opSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYVXBbt0vONt2fx+5zVREqYhTKHxi7Ism9w6sxGV0G8=;
 b=ylazYQQDeC9QIzTCicUpQRY2yEdvXeFNQBSiIiixUNK67w6RCg5y5FW2JNoh6FnaAWRMjrnKy7joAzQ1Wbt0P9s4gyvnOTVE6ZbVEdpD3ch3wAWqbT3vQyGQGAW7zDMc+hrgMeTSBL4U9yVPIgzL1fLnSpxUZJgGkTU37PENlqWu03YLgEcJsbaQWWhiODDVhJY+eVc9URPeoULfUjQvz3bEYdnp8W7gdlFg3MY3ObeH/KIaKHW0yhPNsMwigKkcHcTydYwazBS98zRMoghJXOyqJYsE9cxoFdSG3hQiliZaPnSuFyI669roMCypjOP1GFxlvTCycLbTYzS0XlpbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYVXBbt0vONt2fx+5zVREqYhTKHxi7Ism9w6sxGV0G8=;
 b=j98swGI+MkFB3cc9l5U4hLb9trcshzjYYD71xJXYid5E27e7aqsqIOFyfLiwdP8qfXDSMJ3a7NvL5WiVcfD34psxKzBszudrzX2HqfctHTCsI2+HVWtwYDPw173d1U1ezeq1M19deGrbRN1kM2n5Ol3yAQ4XH1RSdnSlfJL2wo+uRct3Jr2Hkm+fbTvfvOSxTEpjfkTuIu/8jVme28dRd6qTn8zrZfnUmbeV3Xu0iwZ5OsrKc6FnwFE8Bi1YD5hU/7tZy06xrbKDYofv6s+PMse4pwJBAX4XKb1k4DWg70UTh7fFQ4hu0oTJx3w8qBOCzMHCWm4pEygCXbkBoOIo2w==
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e7::24)
 by DU4P194MB2969.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:63e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 19:01:38 +0000
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb]) by BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 19:01:38 +0000
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
Subject: [PATCH net] net: usb: cx82310_eth: bound partial-frame remainder by current skb length
Date: Fri, 14 Aug 2026 21:08:14 +0200
Message-ID:
 <BESP194MB28324DC870B7DE2E694CCEEEB8DA2@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0112.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::9) To BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e7::24)
X-Microsoft-Original-Message-ID: <20260814190822.11811-1-jjx@live.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2832:EE_|DU4P194MB2969:EE_
X-MS-Office365-Filtering-Correlation-Id: d5559ff0-42e4-45e6-e7a1-08defa3677d7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|4140399003|41001999006|25010399006|5072599009|8060799015|5062599005|15080799012|39105399006|19110799012|22141099003|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4VgZaY074s1usCImaRR5rLvEafGjsrze/WH4hKgRqG8I8w1enB/ZXSPT7l1?=
 =?us-ascii?Q?z1jyZGS/kGMUAIC2xUY0Oi1GBsTFwWOMFeG6zIMaDzv9JNZ0QrXWoj+6VcpV?=
 =?us-ascii?Q?DHNzSY4E32UjxhG/atr/gRh1DXZvH4YtVmOur40X9ZHXBFFpR4Lso7GKAp7H?=
 =?us-ascii?Q?GbWyBFCbW8LK+iaCKBkPLOl1FX9jw3CxnDRjlRjpbTCym3DFIfoID5mqh/wg?=
 =?us-ascii?Q?LUEMaQo7otkjEmyLN8RialhNWAMyXHEPDew3F2Uj1EfCt3WxqiZzYVprqtX2?=
 =?us-ascii?Q?ILkPclL8yBtYO3EiJHVvTY4svAGB+Me29+tFRm1bPM6QWKsepv9uz0QQoSYn?=
 =?us-ascii?Q?OLjb8ydQTP9tw9IywOamQcRdhWhwCeKtHfT9ZEsCEPRg842fy3rB+fcQA0SW?=
 =?us-ascii?Q?lwfnKg1HNztDziWRVXxNjybGpwHkc+xTspTgMIbOMoOidVw4VdVppR1sMB7D?=
 =?us-ascii?Q?03bAKkvL/hc5UknaxNuekpRwxrDexXPCSbssjfgZYtfCxVb3Q0WvZhu+Yqop?=
 =?us-ascii?Q?w5e2nRQV/LhjGH9fNDNIoD2KP6quEIZZz6+JbOhu5B6MuLSsDfFFmWQi/Vn4?=
 =?us-ascii?Q?PP24BalGYV6bsKYgmrbTanw5NNbmS2oKNjHfB+P6xGWP8nUoYXpDonV12K02?=
 =?us-ascii?Q?7ipWpe0YOdIRuaI2CMZOdHrXMnc60C6RMpIeNcGfSO1IB9bPbAq5L2S8qEqZ?=
 =?us-ascii?Q?0WCeQr1ID8nVR5rVVaeuLnljPKntWdcWgTMR8AmbXOc8pAFOUG4unUI7HBBC?=
 =?us-ascii?Q?Scxj/DXbe2BT3AfIS8ztO1QMszVkm8X/AlAYOvoKLP0IwUspnpb3E/3a9+Pi?=
 =?us-ascii?Q?OWVTGu1fdyKTnlniU4JTkkVDQmiTMgSKKy6c4iFj96nhX+p3iGltxgaLluN4?=
 =?us-ascii?Q?F8/1zQlS8lU367092dG2gDaUzsjg8ncO62LxyMkYT3vUc+kN7ATOG4GlkbWg?=
 =?us-ascii?Q?g39/1rVm0uCqiikkrTLn7RWRKHCKFPxO4VHYOmetZJs+Qw9km8S3nMKJGA8s?=
 =?us-ascii?Q?hs3xv6yUBGknLHNK73XF/WQwXutBswlmbg7sswAorHx4Nkx9PKaZCNwmWzY0?=
 =?us-ascii?Q?0ujX1al2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qD7FfhZH/UcqoQioc1mTv4bWnx5dNLDRmzSgHxkmQCX32ySQEwMqpSNa+9qM?=
 =?us-ascii?Q?3U/PnM8mF45JtolnZAcUgQtoHgKUU1mMx5hsLZ+RVwdFVImVQicOLTvDy5Q5?=
 =?us-ascii?Q?E/OKBzcMYusOGONrJ+RjaEh+Yc1JSAzgsniGB1hOZmQ6+vfyGJN2+YP/w0Uc?=
 =?us-ascii?Q?CM1/bzNa7gMaC/f8tKPBsfslNrp4sgpAb0LRDMGdlqbnF12gLva5L1NcSvla?=
 =?us-ascii?Q?E1FJ967dzY1NbGHRAkjggsUMQF/tUd5+9BnBKnRf7Z1G2cU8+GOY212cptCz?=
 =?us-ascii?Q?ZCBw5NTffYLq85fgft3AQwkzrjY+xy0rlePFwFlKyA13WMXjZCBDS9e5Jn1j?=
 =?us-ascii?Q?Y9sC7y9786/t/yoqlEgQbbeNMq9OdaJRABIyAEoKdsoU5+2KM45hwqnr5ppz?=
 =?us-ascii?Q?l6hFA0ZWiLXUY+YGZh0A5E5/eXy267Fr60MjT02G2rVx1MUwE+kN5JlRgeTL?=
 =?us-ascii?Q?2XB+v6HKFvCXpE4KlRyQfYCVctQfz8Xa5FRklaajsnDlcSbctGCgF5VOwrIR?=
 =?us-ascii?Q?2Mra3EffXi/2xQEowDq7kg9mS6mcQdIg09WhWHu9F1i2zU16tRstjDsJ4baR?=
 =?us-ascii?Q?RteK6OXtb6Eos7OQlhUOVUuzBr210+ijZIs0oQkEawZ0E5UVodpBajIgBzgc?=
 =?us-ascii?Q?lOW74814Brot++u0dnjtUFqQMfwDZuElnf4my5u+1XGdDKO3mYmP2bEO0LA0?=
 =?us-ascii?Q?PMlaau2O5XJGla4NkpeceCLFze5A/OhDRCsAsXyNYpVYsiMFs65tbxqdYnqe?=
 =?us-ascii?Q?phvwBYphA8rDNaabkB5bvxmZu5bcPjg4UiM0hEn/fP3jn+k/WTuWLmWTlenD?=
 =?us-ascii?Q?HJb04svYJxrxeA4w1O7YuVG+SMLn3dXaAcpeHjmkFG023P7wnf2Y+qdWLgFX?=
 =?us-ascii?Q?BBO7earcCxVzCJCNJ7mTyegRpSnYtWILDJ4iQsc0hR0cIEz9+s7RXqG7tGXj?=
 =?us-ascii?Q?TB3R6Ncea79VUb3i6G2ckuSU5Fm/nnqI+7OiZDtXUt3bwgxl6lMMW+zxr5LY?=
 =?us-ascii?Q?CYtV6VUteS8GCntI5yiU5ZUBIdw82Yy702zM3CkdRPUQbi2l4q4YstP1GEtq?=
 =?us-ascii?Q?k3c3OaWtuFXB2Uqa76iGDNzoiNhvkAudUlGHYyJXkqPUqPnQg9fHfq6mwqJN?=
 =?us-ascii?Q?y6/yviEO6cPR/sTLvfRdK3MgUJoqwt6D4U5FHjU8KNJ5H5JjhxOycy0tGAcj?=
 =?us-ascii?Q?VdnIv0JZyPX0EDVifIeZJA1eHJgeajnID6MGGnXRRdhSiI4QBd4Ov+LtmrpA?=
 =?us-ascii?Q?bY8I5pYAAzSVxMloiXNE8uh9akIySCe3GxmRMWfpPVRispqI84VRRnfmAsn+?=
 =?us-ascii?Q?LXUjyNLoHhq78qnzyYw+VYieTI9D1aHmALQ+BRXRbWnyZRjC+53gphgEu1Ly?=
 =?us-ascii?Q?QTPjL+M=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5559ff0-42e4-45e6-e7a1-08defa3677d7
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2832.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:01:38.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P194MB2969

When a frame straddles two bulk URBs, cx82310_rx_fixup() stores the
number of bytes still expected in dev->partial_rem and on the next call
memcpy()s that many bytes from the new skb without checking that the new
URB actually delivered that much data. A malicious device can declare a
large frame in one URB and follow it with a short URB, causing the
memcpy to read past the valid skb data into uncleared bytes in the
receive buffer and forward the result up the network stack.

Drop the partial frame and reset the carry-over state if the current skb
is shorter than the recorded remainder.

Fixes: cc28a20e77b2 ("introduce cx82310_eth: Conexant CX82310-based ADSL router USB ethernet driver")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Jason Winter <jjx@live.nl>
---
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

