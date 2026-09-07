Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013010.outbound.protection.outlook.com [52.103.33.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998F4195C8;
	Mon,  7 Sep 2026 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763693; cv=fail; b=jY94T7+2ShC5mmp9yTMfv4rAzJjxzDHIec38+hnJAXrbXNPdShGt/OKhMVtJUj++MfPaXtd1O+YDOxAUpHneR7rP9JoYoyct04vS2c3x10wJQuYv0NB9oU408usxlE49xW+pZOpvpbcmujL09BfKqqKPZDsGdIgRLmJNX8HY9gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763693; c=relaxed/simple;
	bh=R5U0HAdKGZ/FSpVYYnTBaaXuOACG56D+ZfaT9iiEHiM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SrkTaBM44hYnGTXH/mdME3RgqFsQJJVstxF7VM/pwitcgy9ac+Y3daUpqPVnkUa7uLhBbgQXiTRzEzpjiK3MnvcVdUNVQtf50KWGU0o4EbldkZJC8VKR12Sf6W+gNqIv2PkUD3EoXYkBS8R0aB6A4M/3vLsasdqM+wyzHCJaiFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Fv+oHm9K; arc=fail smtp.client-ip=52.103.33.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Fv+oHm9K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUG3vuaGK0oAj7TFoL9R/BAZ/zrXmtlaW/yNb7m3HhFxVplUi98z0hWN97QkgZeKWg2nXjeQfEbdLFYmwMLPnqEi20TiLUvr4/+CRm0Us+Ld/HXXU3w9UVz/wQyxuNjECTUIFzTt7A9IZ40ZSzAd3NvGxiVgm8c+dcV8zAYYgOjpQnY8FApYWy9Etq4ttYl1G/kMaL+Kw27bJjPqcgE9fQrxeNJ/F1tmHye0e9LAfwbCVVwHqN9ZXzSSXWy9pt9b558pGgzRqB6WwYZE+YpVAgZzByCklvFx2UAczjrZUQKjv3bOBnsoUqR5Djj1iokdyeUY3m/Z9pxV9P2FXLGSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg6W5bs1umjOPtQbnhGl/QkQO5k9SOiMFqLlVjDUhyg=;
 b=p666KqUDhw4WMnv0gMIVQ0tipRMOw6i6GLBqLiMYux0VkUePfCzPU4OoSLWZUHtMde2htv9xAyC0foyfznwgzuO/vnt8l+YpR/28IeYFVKc8uhpxCsJHcDYTe2Qesley7nQAsgwh6UIu/ANgRG8oA6BpS1ftcbP/WTu2ZeqhTEm4ehEJ0RifmpkzdxbIeDzj0fsYcR6b5ztbYqSD8onWbPjYIojbBdy7yhTHPdajOfOM2Whz1gymi58tUswIXNmou8gXveQaF6X3gTB04p3QGv4SSjjsxrNyKM4zpgikZYXpuG3xWn//mfn2HMlMbkTy7Nl6+xC+W9s6kfewxkI2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg6W5bs1umjOPtQbnhGl/QkQO5k9SOiMFqLlVjDUhyg=;
 b=Fv+oHm9KvbXar4SzK+9UK8UY47swRzl00nLqv0sF1oDERusneOJNAqnIRAPvfprB4B17OAvX7qt0D879ZX1XLXa09TNwwXKz2OZpEBP+uE+6iib9iypjvCDXB1aeLBt2BwL2ETLlEbRqKlMumErfk0LRsB6cgl+7ibIoJaUQPpD3u5CbEdInU92tH8A7QZW4BnWVdjsSdflvbDL7PVGDCZCfPeRtOL0LVTshHyra+j9HPZ16g+fXNeBX7p//u38zlWjre6mXbGWhU3viu6EldLyMLeT2tXjNb+GWdWplD9fEBU38x5PTOigcsZsGot5XsE0K6HLUnwu+i5T5vZxR9A==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB0610.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:48:09 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:48:09 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] net: usb: cx82310_eth: validate skb length in partial packet reassembly
Date: Mon,  7 Sep 2026 06:48:06 +0000
Message-ID:
 <AS8P251MB0001C1EC5208155FCAB25268C8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907064806.578064-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB0610:EE_
X-MS-Office365-Filtering-Correlation-Id: 8965f03f-135b-48e5-9b26-08df0cabfa82
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|55001999006|41001999006|4140399003|5072599009|25010399006|2604032031799003|19110799012|15080799012|23021999003|37011999003|25031999004|12121999013|8060799015|24021099003|51005399006|19061999003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tji+zYVPD2HR6QH0ozIwWkqGhTlKVxIjEcudrlw8bnYyJxvDyB6Z9YJo2L1l?=
 =?us-ascii?Q?7BSQbF4YivxI4UhVOpQ1aZuDMWF7d3Xrfa8HtHKtKe/bk3ALGrsL9Q5AJHgL?=
 =?us-ascii?Q?WS9a2ZWbKvgUcBrFt3AFvK02l+g0m8Mftz60cGfAFXekYgK9MYx6Y0Cwb2W4?=
 =?us-ascii?Q?qb2wNtf1qHybDnsGtKb2AwJ/K5Y73RyCsI3aIc7ah7yGMzyBxbejs4Ii9yB3?=
 =?us-ascii?Q?ReS37OXrxasdiYnAQ7QfTmF4r6mVWB0pKf152cg10wSsB3cPjtmLaCTty540?=
 =?us-ascii?Q?3pENKxFtc/N1o7mde3LZMOIqJvx16D86fP2o0UZ+H1jzFY/bWpPCdLfXPbIE?=
 =?us-ascii?Q?rK5aiM69gUbmXJ5sbKP0bWiimOSpYx1b9U3Mbes7/kx9+YLUy/VSSu4/OkLx?=
 =?us-ascii?Q?ychgtCWCbPWxbguHKngyu8rMZ3EMgcwk5ssSR8lKoOclOGs22wq22O5StAaE?=
 =?us-ascii?Q?70v8uuo8XrQvwXMw9Dj39GGvDnFD5DRiaP3Ygu/tdFc13YvpwpjQQ61NF6Hb?=
 =?us-ascii?Q?02Ky2nEwnCudixdzIi2grX3ims9af2NcNITzJ7mZhaZ6XK9d/tOle/Cy4reb?=
 =?us-ascii?Q?zHZULoHnBi8KrqN2ARd00SE/YCWjzZXvfKlTc3d48bLBM8TRXrR6o/kwSKlH?=
 =?us-ascii?Q?PIZFm2E80cIXuhFx+eLgXVUMBxNYohbJflV0QJv4h/7Si7/gNpr5FvAuhUtG?=
 =?us-ascii?Q?x91oAf98igYE2VJfvfCLh2pPH2bODGrSO+xdeBHdZSM7qcEWN/RX/B5J5sWS?=
 =?us-ascii?Q?hqQNNp4rgrOz7ApXy1fpu1cK9Bs3IA0JrTQJ+Sxy6wM4YknB+GF4ACArqfmI?=
 =?us-ascii?Q?rhCD9uq/DXEWX3d6c1SSBx5YDR6Upv4coo/Rz/6aj9jcGYhsYVGboyDVWign?=
 =?us-ascii?Q?gxJisZGdpXYc40N31XAGrHR4BjPLkUSC01FwkxyNp5XB5skGm+wq38/HqZ45?=
 =?us-ascii?Q?kezIP7PuRVfya3+AJ7KuLfBglFnZ7V0AzKh9uXg+dE5VLT2IukbI913v379D?=
 =?us-ascii?Q?dBKDMVTe6742YlsJtAooxB2YexFbZUdEB1PLmu34L3fM2RYi1pnTTnggcxtO?=
 =?us-ascii?Q?xRR2Rh2loAjhMJ7FRQfshZ8KbKRjaepclnP2csjBVrOab7F0nBRrtzUu3/lW?=
 =?us-ascii?Q?NOOJzKbP1Hv9ipCGL3ZH3XtmEWfxykdlbaQDPRM2Ry4vVkMl4AjPC/mREGPP?=
 =?us-ascii?Q?TjswMPQyk7NdBEOjUj6D4f64jXvCPRhXWEeHJXYTLEORAaYFvL+RQEGs834?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUAD8mEbcn0GH+vsMRI/qyKSZVfKJ5kJQLhY1jG017z2VZ5K/gygII00+KTf?=
 =?us-ascii?Q?xpdybwMB0Dz/MF9nKVIGrI8SXVHs7EZuvXhYDgxUR/Ah9cES7wWds4ExL+bw?=
 =?us-ascii?Q?Ciyljsh6YaZX9135+EGe7gXrD0bWTF1bgPFN3GI5sjmdWTMhv1itNWeL5L0f?=
 =?us-ascii?Q?J/jFgbE+9ASi29FGIsIqXQf1LujYBrjXNq0sfbvYRJ0nQO/Qe8iItfAOVGeN?=
 =?us-ascii?Q?pdF0oEUOIzCHAI4EKvy+U2IQXotTq9uTuFadZBOqkMfQ9nY1edBxLwljqnFX?=
 =?us-ascii?Q?5hS8u+hnWVS5GOzfiX+QlSx6GzrT/q//uNtpwrM2LUCvMeM5tFwWnEhUBgWQ?=
 =?us-ascii?Q?i7bdBwt8rZ2cow2K87AEErasCZN+pRUzn/t+nPVv7m4GsoYVyAcZpgAI5Jg8?=
 =?us-ascii?Q?fACFuORcNk42T4jyJd4EPb6s1v9SRCPMMfoQPmYZA0Brg643JmRNTRTpJVmG?=
 =?us-ascii?Q?RQFI4ISG5dwEGo5IADdwwmATIB7mVj73nRTftnuDFXiKvCrYnR7nphjP1XbA?=
 =?us-ascii?Q?ccZ505YsOvTa2q1r7khaWTwD+afMviTcN0OQ8Zxl3n9SLWtWZbrmzpIQpQ/k?=
 =?us-ascii?Q?5YmKPTKXun4HxHbLARTpBcAMj0g0LUdtprL7foMDt2sq8ariVGHQQvWm6nKo?=
 =?us-ascii?Q?v+Kmkv8g6ZhEJa5fpVo38PI13iT4YwH4dEHC+kAfLUJ8QXkcSXBry4vWHV22?=
 =?us-ascii?Q?5OMIOgjii9vylQ0XvKNWWyaogUM3ajlsASGczhDEwQgtc4EU9lz2jyCGPWTR?=
 =?us-ascii?Q?dwJoKOKBbuwu+KhYQ676sd1kf1KPmiErolnpkmNtMR4B+bA8y79vBRuHdtAw?=
 =?us-ascii?Q?R/dVrjheN2zHm0hbCazHuVNVP3Ow/aJdNL43pDfNnjitAbinjy/kA3FmeKLF?=
 =?us-ascii?Q?IXWSQVwCqRjpa0IKDDSOU13oUHKngHBrSn41vr+PiWWM9fx7Sn0tCRxQJe5d?=
 =?us-ascii?Q?Y3MsT0sqDd8IyeoSSU6cao9ugA5AJ1mbskz+HscIadWb3ULEZgsrHxYSksqN?=
 =?us-ascii?Q?fivo0jabSpEp48NzqHtZGIwHKNE3FvhYvwCugkNrnJlX0R1J746q3kh56Fyz?=
 =?us-ascii?Q?XKaFyDmZlIFw+eNelJkyQcULjze8/Wl2RcEQ7mZDMSyNQb7Edu4LVJizyGp6?=
 =?us-ascii?Q?OQ0bfDxo8X4xotncwN2AgKxGmFxGstkL3ZArSiDC7P6jmR9zF9VYDAZtE6UE?=
 =?us-ascii?Q?8MwQqNyaDdHCFo7/irio2zoAuybRd6Iat9T04+kTvC3HD35TGEBB8fcAbfJ6?=
 =?us-ascii?Q?WY2dNXqK5iwybF2s1bci/aWCR0hlScKjg/SJMrueCJsy2sWdSl+yhojMuLjc?=
 =?us-ascii?Q?3EKGez7zmK0TZsIJsPvcwev1wdzjpd8124WjIzazplDQojL1rneymSGXVf3o?=
 =?us-ascii?Q?o4GG373D9dgbMNe+aC19aGgEC5H+9aIRjZ7AYSS4tOV8AOUgNvbfBhcl+tPu?=
 =?us-ascii?Q?3BT7eSoDi+aYAOZoMbK6zmNe9y1LbivM?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8965f03f-135b-48e5-9b26-08df0cabfa82
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:48:09.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0610

cx82310_rx_fixup() saves partially received packets and attempts to
complete them with data from the next USB transfer. However, it does not
check that the new skb contains enough data to supply the remaining
bytes (dev->partial_rem). The memcpy at the reassembly site blindly
copies partial_rem bytes from skb->data, which can read beyond the skb
data buffer when a malicious or malfunctioning USB device sends a
transfer shorter than expected.

A crafted USB device can exploit this by first sending a packet header
claiming a large payload but providing only a few bytes (setting up a
large partial_rem), then sending a very short follow-up transfer. The
memcpy reads past the skb data into adjacent heap memory, and the
resulting over-long frame is delivered to the network stack via
usbnet_skb_return(), potentially leaking kernel heap contents.

Add a check that skb->len >= partial_rem before the reassembly memcpy.
When the transfer is too short, reset partial_rem and drop the frame.

Fixes: cc28a20e77b2 ("introduce cx82310_eth: Conexant CX82310-based ADSL router USB ethernet driver")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/usb/cx82310_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 068acb052adb0..e243898917fdb 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -251,6 +251,10 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	 * end of that packet at the beginning.
 	 */
 	if (dev->partial_rem) {
+		if (skb->len < dev->partial_rem) {
+			dev->partial_rem = 0;
+			return 0;
+		}
 		len = dev->partial_len + dev->partial_rem;
 		skb2 = alloc_skb(len, GFP_ATOMIC);
 		if (!skb2)
-- 
2.43.0

