Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010019.outbound.protection.outlook.com [52.103.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB913B14A2;
	Mon, 14 Sep 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427226; cv=fail; b=BCjpUq7+wC2M/DpMEz2UwnGL9sPK++e72pKCS1roWSfe2XRK5UVa+ou0XHPKMMh2A1xAZVnauEsILVPsQptx0nC9oihb+XSm9M1mPdOx4EOEX215wFBR1Qiwh5kk4BZFGWo7eOIcYFjOZrusQ8ftRBOU6JcKPDIN+4ki0Itk4Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427226; c=relaxed/simple;
	bh=7croyZ9dpPIvZUWjK8ZQPJmoYXSlnM7ZNPKZrq4J+Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WzRvq/KgXIVo+QG6JE35+HBNWK0BwJy6wQbLCzf7Xm8alTjEqf1vTzFadI4Kb5iDt5f9A45FKXYjXAHZM3Vt4Nhmd6EvkH/rPYUtunXpqB3VaCwCfIJInx5y/MQMTvVY7qXHNO8dAz3DS9z0BpNlA4x4Bz0HyczfvMTx/ePIxBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ksbCu2Kv; arc=fail smtp.client-ip=52.103.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ksbCu2Kv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo/2o0JlzrgFqklYBxiIDEFJPRrOcBg/CbThh2O1xGM2apxuEcfVam09c1mgoIf2CTIeVWfaajxiSKJUun4aGVZAQ5EaOhNh4iJ2EZAfj4nI4WDVb+XJkC2xbIF2YZzXKFGZ6LgjUCJQy5wpLW7dSK5szTfrqcjfGdB4y8sg8bo+YS0fsBGi6lJVMyUj9iUO47f1sQY5XzIaBOldk/pz1bPYitw++zJ/4soQu4zQ8vJ/ivX+1Ojr/6R3Tgo0kt4Qop1nfZUpk7VefHVxTRHCPpg+OWO0Pznz01ZMrvXYBeq0nU6T+0HuV0mNFhRbRpWLylAfNekfXjQnKZ9eRLEbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuZoavzq1vIRSu+p6dqh527j1JOzJEPtPAPkHsWnwks=;
 b=UK6lEQdNZWmOLGucSoBlzb3dlxKehFVgWFmeb/uawbWhlcakrE/DZnTBCA+3WsQC0oVim8HtzkPujVdU4nABN7C2szWZhouJ693XctPUbx+pgFKC0Luk85iwPfN8VtG10f8of1ZQJmqKnLfWbAjuR2uwT276H9DEepxT6Jrr0y7/G243GrdgD6flRatJNAzjSc6rsvWYHG1sucgeYkvvvwZxJazbq6tyPNIVdJGYAtUH/60iG3+vD/h+YNPNy31PS58ssg7XvFctgqwT4rOaTELsSm8hqcBuwup7dho09IOArivlIWftR8t6MPTZ+CJMaXfcPg3l5Qua4r2QWKd9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuZoavzq1vIRSu+p6dqh527j1JOzJEPtPAPkHsWnwks=;
 b=ksbCu2KvUxXObKv5tZo93yiZhuo6GlXSPwHVtkhvBCwTyQ8u0h0b59tCURIaXQXC3EXwDO/sffZht1lKrKaZlZ3eyA8wz1aXvER08Aue9vZQRANQZJiM8Z4VkWbsyB9MMgbVYgLU6plex+226Ve2jTqc2izz20+7vtXcxhjHQBUacPolTyByPCJihA0rPIQoAj5pequGyb878P1kIzuQ2cAY2isnhGS5h2+g6iWqxiqU1M0tKAH1fq2AzxlQOJY2KvKBtUZZPASoli31u9+onHQ+jcpPTrlmvif+ZAGeim+v5FfMhzyUla5w/5HRNG6l2KDT0KvCQTAng4TdKRvPlQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV1P251MB0882.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 23:07:01 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:07:00 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH net v2] net: usb: catc: bound the RX packet length in catc_rx_done()
Date: Tue, 15 Sep 2026 00:06:58 +0100
Message-ID:
 <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260914230658.148754-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV1P251MB0882:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bb0e6e-4fef-48de-bc1f-08df12b4e210
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|41001999006|5062599005|8060799015|12121999013|55001999006|5072599009|24021099003|25010399006|15080799012|37011999003|51005399006|25031999004|4140399003|23021999003|440099028|4302099013|3412199025|26104999009|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irFfpChdySt4NYT4ka9I7Zv2jnLP4+lprrkIjahG1yvF/76XF2WF4PyhYPtw?=
 =?us-ascii?Q?4h/Js2RhDy1yRRhBWOga5J1aEzgvMeiNBb4vS39ZCB+yJOjoJiBn6wgb6RlF?=
 =?us-ascii?Q?OqKG8iCNNhGs5skb1GKX10OHppRLKZt8vQ0mr/9Qarkgqe9m8UXaPYZQ7Oo6?=
 =?us-ascii?Q?gfcVkAW1YkckJwQ0v7vjqUQWrXjNPPBUW1IH7l820ecw9KyJdglBqZ4//N91?=
 =?us-ascii?Q?SXPwi/gPL9MSOiGjtLa679UkAkk8YXpkG2jLSLOOhFLPvSh/gQEL82DsPQyS?=
 =?us-ascii?Q?lcH2e0sXK1Ysb+EGprKd1oGduTr6r9WJPp7KJuYbAHXoztI1fanFPBak0ltZ?=
 =?us-ascii?Q?82fD/WeXFB2k3hnTvMeayjCpekfHFeI2pPDZoW0hIP9JjIlPoLFSdu30SW9G?=
 =?us-ascii?Q?xirafX/vVVdBmLcZqaAZbrG8gsMO3fMEuTuAOQfEDWoTjJ6vEpG13Ofn4Tc1?=
 =?us-ascii?Q?6R2iVhHTPLtW8OEqX9yNvWiFA/E1NEwojnW2mMTHaQvIwhNCfFjiNYakE8kw?=
 =?us-ascii?Q?gvuQXrK90cDns6vb0BHlFxhuL3VgqJ/0fujVxDwqAOwrbu2oNLlWMmdQsgwc?=
 =?us-ascii?Q?vj77bxr0NsZhmNjgNby19Jn4KxBYLFI+9QE+1tiKEEYwC/jt2BRiuJSYTHdn?=
 =?us-ascii?Q?jsmBVUY5AXRKQDN+UwRRrcxNpgD/scPpLBhLHkz5Qk2OyU+MZ+01fgcOethr?=
 =?us-ascii?Q?FDQWGtYMt9XdAZFxVwolLkBvcxf6tOqoUVFPDXNknstadyEfj97Tm/a5rL0w?=
 =?us-ascii?Q?tjRZJVx1sEedwgaj1trZJmHz106GWriU4fGgL6SWCsJO7EEGPEDFQBzWOQmC?=
 =?us-ascii?Q?1ZymDc/r7BkJTW1431BSvFy9U9vjsftxRIB0ECkDAqgNZkRQbgMOSzQxCWl/?=
 =?us-ascii?Q?hZNg+5S2ThiUx0zcBxOQFe0nLxtGq/zRIWJ2vqYY4mXPKHpa9Qy3zwQOSWw8?=
 =?us-ascii?Q?1KSXe9ULEuA1N2cIHQ4cq8M71nIiNvozIWZtVxJy3J83kZn9qkaKk1lIZMHV?=
 =?us-ascii?Q?yhVVJHIVXucwBwR2jZjP4P4PPXeukz+Dz+Gj4E3BlgP6+06bvDpliaTg9SEC?=
 =?us-ascii?Q?2BysNtpXEAqht0UEO64wRbjBL7TnNGCPQ+SCtFwhcPPeARbauRw6P2FtZIQt?=
 =?us-ascii?Q?7KQdxS/CFlhC05hkyb9rdWEm5Qv1WNbY9WvC1ZZx2Xv+rmUdrnAIbU5Em5PM?=
 =?us-ascii?Q?jmW2g8xdXCaFYricyZYWjnw95oca6TlvSFc4F5BSG3vO/e3o/598l0b/z4HJ?=
 =?us-ascii?Q?zGsnNRwTYPvV2GrRGIbh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pfVlyoqHDGRJ97Cx5ybMkrbPDM7L6iURCiDgkwgcIoo6rpPAJVGeKcVuy2PS?=
 =?us-ascii?Q?WCET6A4RC59WwlHVlFH2JzOZDvDZuU+VZlyj7OqkugW/aC/9bmbLv3v6Losb?=
 =?us-ascii?Q?XHg0hGBvhHoFnEQGZ2BLyJY8LDBK997NgWqaMX4wZCYzXQ8nZ/DlWTDxLsVl?=
 =?us-ascii?Q?qJj3vV4c81PjIYjBPdM8mJvF+R0q2vSuS+5yx45QPvKPGBZ9eS0PpL5svmGE?=
 =?us-ascii?Q?aQRM08qYSgMz2ygIdFrGxJMvRrBDuMokQtXQZo1D2H4dzUFQ51Rx61hEy1n/?=
 =?us-ascii?Q?Up6i1naYIxc45No+JMs7omzT/RBHFdGegobfSKmnlGvjA08W+PZVCBgVqv50?=
 =?us-ascii?Q?ftmTfULvVOXc5rVhnm8U0WvimCPUC4ifH8FPIw12VSZn6mOhjdo9Sg0/g0tM?=
 =?us-ascii?Q?kJgbMVkjSmRt+7OP5hb5ClRLAut6uDxZGPHpE/jQtuUuwJo1AsL1NXEYwnu5?=
 =?us-ascii?Q?3O/lPpPu8r+HBDdihEIvIYF/XyFKOQ1tsx+Tm3xfB8ZH/NaVFL6fOgBDvp6L?=
 =?us-ascii?Q?lncjtHuvb0Tn9zhKQfdZ5o1qnOPLPFoBRWXLVppVCbArvJVmNNBiFSWNNks5?=
 =?us-ascii?Q?SJ9i57uOH0xdevpWLoacRmQu4yGCXjQ3BXT0DH5feGnOq/IAm2hEnlsRUub3?=
 =?us-ascii?Q?2Pg6feUapgrC8sDQw/FxJHGaqk5qRrY0ZeGNzm0HaUZl9isvP9RSWh5UxnpB?=
 =?us-ascii?Q?EKuLJj5TOeisQchOoTBYvNI+109DBPsLQzu4oUKBX+epf5a5LzV4BhFBFTsW?=
 =?us-ascii?Q?Kx7xsPTIcjBdjEks4FO5jIeCIbHKFuTtuDzyZBp8kfKOWsxdbmzbTvNgnWqs?=
 =?us-ascii?Q?8baGxKhvXPdv3HYPTqgkZk8De3aSnMesfcJJ0ASY3dCN3lIW1BxXinFthitR?=
 =?us-ascii?Q?vhLezYmK4ZbZe5Fmz7e9/uQEIt3xVMzfbm1BKaWEyoHfac5IUJJGld7Y6keq?=
 =?us-ascii?Q?BhFd2LEVRHemv3BdfSaRLKyGwoe8a2RkJWsxqfy9EtmRhRpUlNTsL/BZ+Phn?=
 =?us-ascii?Q?I0gYR8mjFwArqk6LNKyKeMx3t4bAjgaGn1QziG6GO57CC68aupo0x4sedEha?=
 =?us-ascii?Q?sLKrdDhCfMfZq6Do5mDMpVWnOeozgy7VKScpUyWPtqD5lAp+P0Ytg8A1HQra?=
 =?us-ascii?Q?EoudFCV2dPCBtM4K9fEnrqTcaVTAaDfghXnOV/6PB2R2Ss/10z8YSxFfKZTT?=
 =?us-ascii?Q?OqQjkPsR0Uno8dHjnHuwtbVgty3Lakap7sNR3lEdtt/bvMwpT/ACm3E7fGQ0?=
 =?us-ascii?Q?vWbj24A0/eWnAMXGDYM5z8IB7GNCLAtwXQCzh3H0Az8pywRji5HzjpsbwFPh?=
 =?us-ascii?Q?0oqHJr9gGzP9ua0QCZWAveQgS8qY7r2/RmUjJP/Wo3r1WhnyBMWd/LG4GDtb?=
 =?us-ascii?Q?63JVjMb9HWMTAlySuc6Xbz7PdCG6TYjpuF0QVh39PjeQUomK01LxcG++xxW+?=
 =?us-ascii?Q?m8GQ7qjU3ShK88+zacjr6AZOZL7+PF/P?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bb0e6e-4fef-48de-bc1f-08df12b4e210
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 23:07:00.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB0882

catc_rx_done() walks a multi-packet URB, reading a two-byte length from
each packet header. Its bound, pkt_len > urb->actual_length, ignores the
header offset and compares against the whole transfer rather than the
bytes left from pkt_start, so a crafted packet header makes
skb_copy_to_linear_data() read past the buffer.

A length below ETH_HLEN is also accepted, including zero, and
eth_type_trans() then reads a MAC header from the uninitialised tailroom
of a shorter skb. The is_f5u011 branch takes its length straight from
the transfer, so a zero-length URB reaches the same path.

Track the bytes remaining from the current packet, and reject a header
that does not fit, a length past what is left, and a length below an
Ethernet header.

A transfer shorter than an Ethernet header, including a zero-length one,
previously became a runt skb passed to netif_rx() and counted as
received; it is now counted in rx_length_errors and ends the walk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - reject pkt_len below ETH_HLEN, covering the is_f5u011 branch too (Sashiko)
  - hoist the remaining-bytes calculation so one check bounds both ends
  - drop Cc: stable; no conforming device reaches this
  - add Assisted-by: LLM
v1: https://lore.kernel.org/netdev/AS8P251MB00013A0DCA600A79DC58B0FEC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Sashiko also suggested a sanity maximum on pkt_len. I left it out: PKT_SZ
would reject the 1537-1600 byte transfers the is_f5u011 path allows, since
RX_PKT_SZ is 1600, and dev->mtu excludes the MAC header that pkt_len
includes.

Built with W=1 (catc.o) on x86_64; no warnings. I have no CATC hardware,
so this is not runtime-tested.

 drivers/net/usb/catc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 96e82f94edcf..39b678f175dd 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -233,17 +233,26 @@ static void catc_rx_done(struct urb *urb)
 	}
 
 	do {
-		if(!catc->is_f5u011) {
-			pkt_len = le16_to_cpup((__le16*)pkt_start);
-			if (pkt_len > urb->actual_length) {
+		int remaining = urb->actual_length -
+				(pkt_start - (u8 *)urb->transfer_buffer);
+
+		if (!catc->is_f5u011) {
+			if (remaining < pkt_offset) {
 				catc->netdev->stats.rx_length_errors++;
 				catc->netdev->stats.rx_errors++;
 				break;
 			}
+			pkt_len = le16_to_cpup((__le16 *)pkt_start);
 		} else {
 			pkt_len = urb->actual_length;
 		}
 
+		if (pkt_len < ETH_HLEN || pkt_len + pkt_offset > remaining) {
+			catc->netdev->stats.rx_length_errors++;
+			catc->netdev->stats.rx_errors++;
+			break;
+		}
+
 		if (!(skb = dev_alloc_skb(pkt_len)))
 			return;
 

base-commit: c297ed90fbba72d32b7759aae362b36d15b2db1f
-- 
2.43.0

