Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010001.outbound.protection.outlook.com [52.103.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD13E7BA8;
	Wed,  2 Sep 2026 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338048; cv=fail; b=fvQxz6I1NiiEa7fVuAXuB/MxU0+2bowBf4fnQDyTTQLXl5yRFhYvQ7iyJSlTMmjxpcBdDzsGCJ+8qxA8PFriDTcqIFO4BZo3XGqfPmh1gnJHjqrsoMXlVWPx3dWEQd9WNU7wwRWFzZtoqZ7gL7Z7iHjiWvSOs8QgOpoPtMsbvik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338048; c=relaxed/simple;
	bh=nZ7uRVrDojI4HW9f8Unzl0brLGV0u+OLV47c8ohl18A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QqdCimExfPu5ZZ0YhFvHkbNlLbj7bbSzL2FCFgo2hVIp4Eitqi7bs3ruCqthYgv8WSJt34fFQnPfwtoPJsO1OneVlx8oa7SRRaS+0YGL8C/iW8LmwKhMagbFTUK8osND5kX6YqobqtEBk52h09HipfkWil9qLD/VoSjCqcU8FJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=iI9sO/C9; arc=fail smtp.client-ip=52.103.32.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="iI9sO/C9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4GWQLTVFtToqJN3aYKZFmrvE6myyP/DnfcYI9YItC1U4FiTNCIl9022aCf0Y3QtLoIII3UsRn3/uzqy2g+D7VCyTmwQ7ocaE4xALoocWyL65BFB+G9Nv99wR60eR0uC7rwuJ6Gxx/Ku7H+NYjq0y7G7VSMQpCzx1ZPWmEE0wZ5+co9EcS2PMFlCjrPzpbGQOpvM0v4Axf05QyqoTX7Wp+zihI9swoNpbFvygfQ1uTs4VQzMPGGM1FmPVrvVcJXHpqZdW84mGdbRzvEcy8qJKrrs8BZ8dcW5azgCeM+50etdoWDA3OZWw7NP5sn3pW6ITPZW5d8l13Zrx1vCiLFm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgCv6bPTgP0N6UQvatB/0aukexrn56Y1AxP6TyHCR14=;
 b=vaJNoQFFDekcxjVVHYXpvAIuxbqkc3wojV8rgvg0q1qa5pJkpqGXMjCbVXuPcIcVKn1//9chYG6ZKXRzs+Yvrh4QU8G+dU+lgKcmI2b/Ax9avDorzcrLw1oKLArvYp+AiQVBciqAk3JiFj0dDeKxWURx8XBXj7MCJHu9BDus296+7SXsh4MSgQeeOAr8MS5Gu9jeB02mXsE68OJQjmV1j+czf1GSUxEvrczVkxE/wmmBVoHoLRZ7Y1X6TjxQW7ryAPXJKAmAVaF+HoCQQVCd88s3DFUAXAKh222Tgy0qABLyoGZjCl9QhR+10ckEyS4xY1Mat3GxdWesjwBA2P9DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgCv6bPTgP0N6UQvatB/0aukexrn56Y1AxP6TyHCR14=;
 b=iI9sO/C9HpTUmJxrH5s5TqjKCGr5BQp0WHOw3ZKn+QaPaxkvcaGpTBTqIIN15aGXLU7VJkWgn6r6AVtSUv4Uw7TztQjwJnNE2H9CEsNYBcIIJurEMEZ4zf+XUYiUHAxBecHWtTSKiW61qilhp0JBg7kYupm/ecjleG7L9UKaPK1jKsTCqIvvQrM4cEvnTSwBZm00VfvTNp9eytRWHGRS3boUnDF+sAKqljXyIgBSR+TuicXVLx+av87rbKtylLQ1D8LfiFlVtzBLOeklSLRsFqNX4mXpcTdNO2+MIk7Ad+fUSny0LIxxPSWH3ykYcpiYmynxnf8045MjyWaN2QWfJg==
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e7::24)
 by AS8P194MB1352.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:34:02 +0000
Received: from BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb]) by BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 ([fe80::6620:eb74:9691:a8bb%7]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:34:02 +0000
From: Jason Winter <jjx@live.nl>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: gregkh@linuxfoundation.org,
	kees@kernel.org,
	linux@zary.sk,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Winter <jjx@live.nl>
Subject: [PATCH] net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow
Date: Wed,  2 Sep 2026 10:40:41 +0200
Message-ID:
 <BESP194MB283265DDDC63B6B78D8D34FBB8B72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0015.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::10) To BESP194MB2832.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e7::24)
X-Microsoft-Original-Message-ID: <20260902084115.2537-1-jjx@live.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2832:EE_|AS8P194MB1352:EE_
X-MS-Office365-Filtering-Correlation-Id: 55503747-0f31-4598-6286-08df08ccf167
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6cUe9t9Fs5HiQGsDL5YS4QssPLB1ySwr2SMNdnztFterHzGn2F3PQPIzrG0QkA6qzhhGqPr7v7onevBVCzXdQe6A+LTEeamvIpmB1vAC+niDJ1pYmOVIRbgmFyJVP6mQ4m5iRir4hfKl5PeN774Js+JERNQAKXSuDV36bz8V4E8YnXxFtwgpasPXG2PMpwJEgPDQzQuz8snenZ/IGzQ6SFXMb3+zJI39oleUxImomiwB2/ZohvAris+NvrfmYtGIqgP6pN5h6saCq2OCIwEAHuLe5Mxr61OknCC+9pJKVswtmzhESMfihyLdWCTjdeefPWxYIMbjVcUwlD1GLRcXUZrwsjRLpUnzrNKDwpjLFJYRYrmETFbJ3KXqoSaiWI6xCcGeVDMbTJA9mruHiPNIEkHp4mVaqGp3YZ0KLnPdTnqklS/OW1F/oy3vyG7271VEHu9s2qCaJAiYviClZA3SDhWA7XVuJrnmY5P9xoeHosKzNvtbG3Lwk83wwJkQTcnIhEBFCKX/LPz0OfL9S9FsS5rdlqjaquU5bFkwrbwUxWfrI0S+kh6/EW9QEXPQBZkXoxjsyixu8ptgxJYC90eylI58fTCwMF0qQEc6LV7XFfxE3/Hmyzpd+YmdDkblQ4SQROywrnWy1ZiQsV7pH8HYrslfLlnjcpXXht0zI4x9/VgemaJbfCDgFKccBOjBEMY0HZSY3J6ULmhzInWcR5vO2XNjIXa+V0E0u43GWNe7hAP6JWOD/wCWY4Vo+jUxUlwkho=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|41001999006|5072599009|25010399006|4140399003|23021999003|12121999013|19110799012|8060799015|1474299035|24021099003|51005399006|15080799012|12091999003|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GTOmWexyXrNrTkDnJjnrtvyOkSYvDNVsc2ezZrKQNaOVDh0UW7W0oJWeBCjr?=
 =?us-ascii?Q?HfWuSH4p4N7Xzb2JwaSDqlj4LCLTUk3F7DmFwxpaBTSP81S5S2Z9pG9AeNxt?=
 =?us-ascii?Q?mxlmNLFC/nmO5UzFKwgI8Zc6QYKthg490qIhR7TnmcZzX8Fh++NDnBYdxEVt?=
 =?us-ascii?Q?lPwdUtu1bpXGyPB7KhK1tHDhKMy/BTbGB2Ww8Bu9IZdL4YFJ18LRhX4VtfEE?=
 =?us-ascii?Q?5NSxplSAGBmG6nw2YLCpgA4UfI0DPGM0eL8/AjYk5JjpeEhEUsV9WiwbOq7v?=
 =?us-ascii?Q?zCvmwFhvvdM1YD/MOLPQMvmHZ7mDpVyrKcajc/eX0dqDHjVAjNISwm2SJsG/?=
 =?us-ascii?Q?/PG9gjcjaBAbNjaigKRlAiuDe4Bm6AA/YZ8IYtgHB3PUxBFx61TG1K0w/o+Y?=
 =?us-ascii?Q?Ww30YZvXgAUpsDgXI55fgbWBZcaJSkrO93SOIcNGT0QXmGVORSf9QAgduXur?=
 =?us-ascii?Q?QUjYLprrngaK4mJV0A+TlKOCqOUXvDXQtwp6O/QW7YCe7zTiCeVvTUNT6Od0?=
 =?us-ascii?Q?OYJ4qnHQ3jIiPyO4UgDzikSGC+pB8kN9if7jD8+3R5M7In9Rj7XgSrB9fMBX?=
 =?us-ascii?Q?/tGe6OOHgHJLbWeDhZgt4Us8nHBb5O8pfqMpUOfrPX1D7n9ck3JKvRSnoKfo?=
 =?us-ascii?Q?JWXAAZgjaxCMfhcTe0RMFOIyWr8M8j087DKNgZ9b9S6KwvXpU+fGHZhgKdCl?=
 =?us-ascii?Q?o5el8jjZbDhd6YvRVTnTPMeEOjySHc6GjytM6oARGTSPoKZHnTKwo7wKrh43?=
 =?us-ascii?Q?F6akcsYmfQ9BJbsN3gynbDj3oh+U1OsR863C5/mZxgxbkORx3GW1q+Wul17X?=
 =?us-ascii?Q?+WQut2rAx+YSIWrhp0qgMzJ4kcXCs1K33/7Eu4/QQXj6UtdJ+WytryYkg6CJ?=
 =?us-ascii?Q?gAuRQMk1qD184XNozxLHWrqh9asveYk9SYys8mlDeJOWuoOyN38kBZizQVcw?=
 =?us-ascii?Q?RnypxRgroQaOcb8aJIVLSyU+uX/evblrMUS9XHwanjISRFSpnyjAcYatfQSp?=
 =?us-ascii?Q?emdamE95F3p6iAzbYkWBQnOcZv7/pBDxgrVNF0JAx7xbEKib0py0QvaGTUaD?=
 =?us-ascii?Q?sWqs1ggHm+eai2IxkvI1WWWotJlw8IWhkjXDhBNcfFXRX2zmTqWCmmovsbHH?=
 =?us-ascii?Q?C0pFYZfAbiDz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1UzRKCfDxd+GVEokxUZpyvo5TOgiwU5LhDDQjqHKG7NtjAkAAGufVKcOm9B?=
 =?us-ascii?Q?BeOTCdEs7eooL40gPSS7g9juj79uE4cXJamDThJ0vu8UzwBPe9OsXYCKGTf3?=
 =?us-ascii?Q?TIaHwUVsmng74HNRQlyP9+RVEWJUCV1me25zmxIrCDNJD4dLyV/rSoURTnUT?=
 =?us-ascii?Q?O1k6QuJ2pqWRNjeg/AfuBp0gRz9jrYeqARJwCFe1/54gPbpY8kPpRtDvaqJL?=
 =?us-ascii?Q?Fh78kNAM/cbqgqhLNNtCSQl6GuPArlv2wEeE6y0TQ/rmD9PJGwqo5MIomtKZ?=
 =?us-ascii?Q?+TGELA2oTIL9zNDn5eyiUbvuqBRYuPesSsI2WDI5kLRtFOY51ohA0vs+rMnE?=
 =?us-ascii?Q?/5hZyupPZLqCKPBTa44CjKz3iEhryd8xf9d/9P6as/ni+OlmCsvo+lpFzr0J?=
 =?us-ascii?Q?i1EZn6DcGmoTCIeAboNRjocsRJ0jyfkbkba+WGmap5++49Q+my2JdyrVQl/2?=
 =?us-ascii?Q?rz1Ye9LTXcNtzh65jOznMK3/bK1dv7GV2tVNnA530dpUvAML1AG3FSAdU6PD?=
 =?us-ascii?Q?plGYVJEKACk34V+pNjLPH97mTIGVXFw9ja1S9t77riXOcs719DujUEa0T9cZ?=
 =?us-ascii?Q?300z8f1zStmi6EaLhjW+feDffacc1184IscS710xF1mJUu2bbZ5u3q6ZQGnz?=
 =?us-ascii?Q?DVG+YZ4obmie/kJU0MfZj9fjBKPqt2EgAb4BJaI0OqWLWtDuCZkF70XGhYbL?=
 =?us-ascii?Q?UYQuUOj9eFv1wL03zzjrGh4Le1ABKgDCKFm7tpYoQ4Tie/mYQii8lzyJluJL?=
 =?us-ascii?Q?dFrJau4dCv6zY31FnhTCj1uk3mJ3iNIKX+nxHhmV4jiHzPZOwv7k3cRdj0GB?=
 =?us-ascii?Q?oZA/Q9FORSLhmBHE8x82r8icUY0xz+H2n68gG5vRRgNafOinsg3f7ONrNfZb?=
 =?us-ascii?Q?Ue2naeGHA5HMWF3UNiF3WutdPK0Vc9G9LbCiSuVQxPGKvujJz4IHtphidJ2C?=
 =?us-ascii?Q?fwdEloGr3TRJs+LtGqisu9co1bPsfnHFdiE8s0u7YPXyfNYZBQw1iCPe0yX1?=
 =?us-ascii?Q?lV5MIosTMqedwlNiWwq23oB4ag/A82jgLLEGWB9v4AU7eR7HWhqsI85EQkc6?=
 =?us-ascii?Q?r+qmARELqeCQbt22PfbajP0eJRqH9LJqKD60L93W8r8j4vY7bss3Vkjt9m+y?=
 =?us-ascii?Q?nYMXXX5sIbRaSHK36PbD+bKv3Hv+lmBObJFwDir4J+DUjhz/aZ/oT6D/bvMa?=
 =?us-ascii?Q?epqRan8IiuyU7aQelstxNW1aDbzQzug/y77geg+JbaVBOcGc6/9XnHR1RYG4?=
 =?us-ascii?Q?LmKUWHBcoF1oG6PQ39e1BfzZQHW5ViXvyRwBiT0tsfzHNmsGV1pyp4Fx/skw?=
 =?us-ascii?Q?WcclYAUX5YTUbFg2eeLpUCN6Rue4ncsWai2TN0TpoCVW5KqUbYnZHydDOgPp?=
 =?us-ascii?Q?8Og9Fto=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55503747-0f31-4598-6286-08df08ccf167
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2832.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:34:02.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB1352

The 0xffff length sentinel detects a router reboot and schedules
re-enabling of ethernet mode, but then falls through to the rest
of the loop body.  The next check is

	} else if (len > CX82310_MTU) {

which is the else of the just-matched if -- it never fires for
len == 0xffff.  The MTU bound that normally caps the
incomplete-packet save path is silently bypassed.

With 0xffff > skb->len always true (rx_urb_size is 4096), the
incomplete-packet branch saves dev->partial_len = skb->len bytes
into dev->partial_data.  partial_data is kmalloc(hard_mtu) =
kmalloc(CX82310_MTU + 2) = 1516 bytes, but skb->len after the
2-byte header pull can be up to 4094.  A device that sends a
4096-byte URB starting with [0xff 0xff] therefore copies 4094
device-provided bytes into a buffer allocated for 1516 bytes,
exceeding its requested size by 2578 bytes.

The next URB then reads dev->partial_len (4094) back from the same
1516-byte buffer and dev->partial_rem (65535 - 4094 = 61441) from
the new URB's ~4KB skb, both well past their allocations, and
delivers the spliced result as a 64KB "frame" to the network
stack.

Bail out of rx_fixup after scheduling the re-enable work; the
remainder of a reboot-marker URB is not meaningful packet data.
This restores the invariant that partial_len < CX82310_MTU + 2 on
the save path, since every other route there has already passed
the MTU check.

Fixes: ca139d76b0d9 ("cx82310_eth: re-enable ethernet mode after router reboot")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Jason Winter <jjx@live.nl>
---
 drivers/net/usb/cx82310_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 068acb052adb..5df657acf3d5 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -282,6 +282,7 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		if (len == 0xffff) {
 			netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode");
 			schedule_work(&priv->reenable_work);
+			return 0;
 		} else if (len > CX82310_MTU) {
 			netdev_err(dev->net, "RX packet too long: %d B\n", len);
 			return 0;
-- 
2.55.0

