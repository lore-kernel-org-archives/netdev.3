Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013078.outbound.protection.outlook.com [52.103.35.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B041E6DF
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577139; cv=fail; b=DM5XoIpteJPh2pDl0HtykRu1xfvYNAljC/n+MChnUbwVqbypdyIqTqE4PMDZSlyl7EFzSB5YiPQWX5qEiSMKckv80sbb7IXDNojRzoHfPhgc4QaAxeJz/aYoSpar52+RtF6/A68rXwineNVNwmpNrFJBjxPhKUYrj0OQQEXJ07E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577139; c=relaxed/simple;
	bh=6VKnaxM4itBjUyDWi+1JqpMStFd+HASBpWQe5uYSYi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bGzWQg8tJSwud/0B18K+Dx+16XCIFduIZ4U+U9rKLkQDAhUdrHWzzfxgvlgJf7dWN/Rp7lP1X+bUnq7XwkVbjMlKfxAPSswEYOJO5xzvBp0ozGzxR8cl9Kaq+E0THM8rHUrSErURiChRRkh91/65VsEgTPi2kMf1hPInyqnnfAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BjV0xSZP; arc=fail smtp.client-ip=52.103.35.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BjV0xSZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri2dM2QJcD0myjGMqQ+NIPE/tWnmdaU3zCQzv9MqfDqH0gjTf4gBwj7xBSk6eLUZR3JyCZXrOqlbl8T5VsGyyzsjWdNTYOsis3U+hs1Cd6noZ14kM8q8ctX8NUQ9KFqLJolYqAZA/Sn9HqIoHtw8aMwisOVzKHE2WzmHFWs/6NuoHRnzkw4TZHjCotwZf3G0AiPrSKPPP1EBChBGsXwzkzjFwNM1EXWpl76Xghu6aO9CTn7c7U92i2eIENjSW7I8mKGjjSl5RUB/SfbvQFH6WClNmjM/Yt4gHS4mdauccbYUndF0GKhLPU+gKt9FEYfEcwGU0F2Y6UJTOfeIUcYZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ5JPBUQmxbmdCkl9hyoZPg+meHw7ytWch4YowgvYdg=;
 b=JmOFpCmXfM7gqvmt9Ec88AwGjf8pJhiJOVcgICiVsD2qXTsyrTi8aJvGMOgjwawaCzPoWNhq5jO5Ugb3GnZVNcAgTbfyulAE6EPLduwO0g/GWfRC8KZLWs9ELv5OSjSyrhof/bs6gqBKS1bXY/Qd8svkRumx9KFJKHGh1hsLnc1CQLcHGhqCF16GulMSEUQ9ZwO5dr19zSHkHLKN0kaBVf0K8Cdc9Ng4KwI2jcqP150FvOX5Yg46KdIZ8OQj++PPp6ga55mqkin4zEibhDpzBK9aciHHEj0uKGl8yw0PqBDQTcWQMKLHRs7GojVOrHGGesKtAEHQNB+YZ59y/MlMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ5JPBUQmxbmdCkl9hyoZPg+meHw7ytWch4YowgvYdg=;
 b=BjV0xSZPgZt7q8G/fdJNkrgWuWNPHsSoRmlR7cx+7oRNKREJOq1lJp5lDteRO/SvbidGycNaB1bOhJAYp4Gato2BIPrHlJ5pmjasFCh9QnpQLa7tIdLBmvRgFVGJJXn+pdOW5FVMxOatIVRByMp16ZPrhQDQE/z2w0To0DQmVrNVZtrO/2XS4y0HeoOdb55TSKy/U/+NxvYqfpl97TSkxThIEsqZV0fUFmyqXCJeCAR2S3OLm7oZu1hFBf4Wu+z9hrP8Jy8LI6d7S+mX38MdRuoVkEa8Q+kf5kisv/kR4hWXwdeaBrwq//BwF6tboKp+5tsj8pgYTXVar9vapOeGWg==
Received: from DU0P251MB0699.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:32b::21)
 by AM9P251MB0096.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:414::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:12:14 +0000
Received: from DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 ([fe80::5d06:7ef9:757a:2816]) by DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 ([fe80::5d06:7ef9:757a:2816%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:12:14 +0000
From: Edoardo Pinci <epinci@outlook.com>
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Edoardo Pinci <epinci@outlook.com>
Subject: [PATCH net v2] net: dsa: mxl862xx: enable assisted learning on CPU port
Date: Mon, 24 Aug 2026 15:11:43 +0200
Message-ID:
 <DU0P251MB069949C6DEB4D1D51F31FE87C4A02@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:32b::21)
X-Microsoft-Original-Message-ID: <20260824131143.889788-1-epinci@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P251MB0699:EE_|AM9P251MB0096:EE_
X-MS-Office365-Filtering-Correlation-Id: 11963acc-67f5-4951-8a82-08df01e150a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|15080799012|5062599005|25010399006|19110799012|8060799015|5072599009|41001999006|24021099003|37011999003|23021999003|56899033|12091999003|19061999003|440099028|4302099013|3412199025|40105399003|1602099012|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmcaLkAXthLFd32t7uHIMG3CCFbFbGvk7AQOtvzxHn+XV8fG0sZGukmpwnPT?=
 =?us-ascii?Q?p7Oiu1SAdfSX56QSZnHktl0s8KsvMfmo4HoU7XxNebyRom+zDE7YlG2NrYVJ?=
 =?us-ascii?Q?IVc6elNmA72Zbxw9IYlB5t76mUVMEos8rkKDBtX9n2joFxaCLPI9Wzk5hqWr?=
 =?us-ascii?Q?suPf7qb5R3CWEhEJZeTQV170FMxYNl5OpZcmL1y0V3ducu09rOuR3tL3vxjM?=
 =?us-ascii?Q?t6CdWrN16MbbYFrNh1K5tNCdNboTTp9L4qJF6MgvPq8qIM8r67srt4S2ykMP?=
 =?us-ascii?Q?rA0r45BtupLEhWAayHBu2sMVEWxQrd1ajUYKn21055H+xQO+2fFYlMGVKzQc?=
 =?us-ascii?Q?MGD9eQn7itq/JkAXtHjRG3JcAoZE0FiHlL5A3cj7r1B6qxPXuj7HeQ1OPx03?=
 =?us-ascii?Q?xcV95psHp8TY3AJB/pFPgE2oNtpNXBnuQFeDhAIAqDmk9ojfZ5scNKro7HbA?=
 =?us-ascii?Q?Y8ywqNAyiV+f7zQT2ImdX/rPm67TTntxksjbcu7ijTTlT3Sh+UHEBVTuq2G0?=
 =?us-ascii?Q?z/hZTwqMJBREJh0aq9G2foX4PXDF42xc9jAWHGcDxScE3p+qle2CNaszjFYN?=
 =?us-ascii?Q?XyewHZdPiKeEF81MFzs2/D6uii69ck/Nvg/z9VeL/YmAR2M2aC0t+FTKmjZ6?=
 =?us-ascii?Q?Lkq8ZPHh2AJLw5cnX4KgRGXDVBesQFmQ9q3mjLOzZatVBjHDnPSHLCR5Qix1?=
 =?us-ascii?Q?iKW+fonSdiCznonIP4ZAf0dobJyzvdvstHRqz7C2aU7Sx8HfeSmDqgl5OS2l?=
 =?us-ascii?Q?usgPevtlr5Q+myuqJR82gKW9AgsoNXmr7Edd4yM48vOeI8589+vX0AoU0StW?=
 =?us-ascii?Q?HvGmiQQCmtNz8Da1Gu06QX50/guz6ckEp9roZyVugzODIcDpC9VvjaGE3pQo?=
 =?us-ascii?Q?yZSZfIibEQwWqFxR0s8VJAyzyUEUBnGOmNbm5kAWUcQyl9cSQAJad2AX+r1T?=
 =?us-ascii?Q?2WjpEEupYZCnr+FUo2G0x+2qwcf4knvIRti5zx/rvELT7Rw4/sI30hmyhz2K?=
 =?us-ascii?Q?ytnx/q+K9oyZezT+8KcsECcaR93VJ7YcL0dgv0UfvPA5fqC4L7rXhBUCnbQZ?=
 =?us-ascii?Q?MY8VV6gSNGWvUFQtRJ+mH05BnqXqlslewjtVER9opa6DkAJPGmxNMxrs5xac?=
 =?us-ascii?Q?VPOypNSCiaeDZJzdVnN4cENBI/Z/S+RQNeTjN1wR0SGRZgCbjFxXqZSHgKYv?=
 =?us-ascii?Q?0LiQTDAVr5MiMJ3J79a1gQlDyQ/FyZlRrQ509g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDrG5o8Su/HCIWTdakjOVCvbngdJiYNWd1phlfhPnM44T0DcGQQutq25KBDo?=
 =?us-ascii?Q?r3Rs491g6Qi2dKLjsTYemCb7F9o+oRLbXDc6IjpxOlULppGepUJ28xtNACWf?=
 =?us-ascii?Q?Nbh3BMdJY/0mA83Z8g6w+duC8BQjv9sL/7ejHGr2tIUt2ya1Fp7gZUkgKR/E?=
 =?us-ascii?Q?/VZ1VT7F99nHNX5DnAOL9mA/dWI3A8BS+mR0dXSHV9jtY/gKJ8jzhDBxaTTV?=
 =?us-ascii?Q?qJDU4rSixSV4n+pZPCbY52FSHD5JIlrC7zOhlMWC4mMkbNGisr/B6a5p0xag?=
 =?us-ascii?Q?bWsMZm25tg814q83YFvDhFdua37oZvQLqCPhCLLIpXIqE4lLzPdE9IrYyMhb?=
 =?us-ascii?Q?a7QpDUn06QTHB/qwfLVfsAo1T+EHcCbKla8cKpea5ihuCYvbzlmBtEi0uvhi?=
 =?us-ascii?Q?h4VuB6mK/bxR+Y5UDcASdc0S0n4zkVyH6ToaES8297XqUQYx/vlAwdhUKotZ?=
 =?us-ascii?Q?/oaFpSxB9+yvRDlt9T6SMY6h2u+EPGJp7kMNN1IdVjpUyFJLaJ8v6fIXjpSG?=
 =?us-ascii?Q?6zT1MwXS2WP4mBmmvIFfJpRwL6zTCfuKWLExc7w5L6PH1/Y9PFzNCtVU5S8N?=
 =?us-ascii?Q?mF+jypBH9iqtEFRLs6DaLrSrpNmhaXa8s1idXakmo4nWTixRt1AkktOgzI4Z?=
 =?us-ascii?Q?Cedb6h8OLuFQkVadt0aHi7k9I/jzuspK38BfHSdFqUMK80dWp47PZ8RtbHD1?=
 =?us-ascii?Q?JApEmapor/e785YtHx+GOoJYLWbnGZ3X3X/jJDaWBKpYcEB+5jMrSJNPyW9Q?=
 =?us-ascii?Q?Zx49/wyGd5GjO4OtOkoKwrLER/GaBFotNOuGOgNX1lseyMXfJHvXPJkpuC8l?=
 =?us-ascii?Q?rid/TZJLApU3e0zZ9tq1QiFVOrsIlbCsJnuGvyi6ixeidY2t4q8N/5N4nwyA?=
 =?us-ascii?Q?vbFJvrI3Zq02Op96ujiOo9FQHYSInQCrUihF18gZta9rp5nocTrKYSP8GDiY?=
 =?us-ascii?Q?XV6VgnonS7d1GwJt03T8H7z16yGEhStzjWPQE2jUCVlw4lyPj9zRZ/1jwMji?=
 =?us-ascii?Q?gfpXzJaZD8zHJGlx7MFwytAnSIFaETHrTnbOVffPOQ/uTmDw9eV3Oc8LbPL8?=
 =?us-ascii?Q?2/Y5WBsFBlcc5iOtKg8qeQXBL8YF9vfldSBRjmaEApG7BRB+xsSAyBk8Tf4j?=
 =?us-ascii?Q?oWdP+3aFQ5E29vMond+E98nOm0kIvP2l6BgWqhwSAkFaGrOfxCp31OwI9O9o?=
 =?us-ascii?Q?TfmIo/7DCFzo0/cjyrxvROjiR1rZM0sKnngkNU/Rp+/ecqEm9V6TlQbHK6HK?=
 =?us-ascii?Q?kgSsRJcCJW/ZJ7XDQOseAzKcn1B/kH7zyB7lLFE+GTCFzmpn7rC9Qa1u1aQ5?=
 =?us-ascii?Q?G9j7UDICmaPcofGbzK0g/aUZO8G6vZ0ZRVjBffUFJyxqZg+Nde2tVDTHDPMr?=
 =?us-ascii?Q?o/10jRi7YzUl6/0A5jkyu6Izvyd9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11963acc-67f5-4951-8a82-08df01e150a5
X-MS-Exchange-CrossTenant-AuthSource: DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:12:14.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0096

The MxL862xx driver enables FDB isolation but does not enable assisted
learning on the CPU port. Consequently, MAC addresses learned through a
physical switch port are not updated in hardware when the corresponding
station moves to a foreign bridge port, such as a Wi-Fi interface.

The stale hardware FDB entry continues directing return traffic toward
the original physical port. Traffic entering that same port is then
filtered instead of being forwarded to the CPU and software bridge. This
causes downstream unicast traffic, including DHCP OFFER and ACK packets,
to disappear after a client roams to a local wireless interface. The
client eventually considers the connection unusable and disconnects.

Enable assisted CPU-port learning so DSA installs foreign bridge FDB
entries on the CPU port. This keeps the hardware FDB synchronized with
the software bridge and allows return traffic to reach locally attached
Wi-Fi clients after roaming.

Tested on a BPI R4 PRO with a MxL862xx switch and a BE14000 WiFi interface.
- Without patch, wired uplink on lan6 port (mxl path)
  Wifi clients connect but roam away not getting DHCP offers
- Without patch, wired uplink on wan port (no mxl path)
  Wifi clients connect and roam successfully
- With this patch, uplink on lan6 (mxl path)
  Wifi clients connect and roam successfully

Fixes: 340bdf984613c4a9241d678915e513824f5a9b19 ("net: dsa: mxl862xx: implement bridge offloading")
Signed-off-by: Edoardo Pinci <epinci@outlook.com>

--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -2111,6 +2111,7 @@ static int mxl862xx_probe(struct mdio_de
 	ds->ops = &mxl862xx_switch_ops;
 	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
 	ds->num_ports = MXL862XX_MAX_PORTS;
+	ds->assisted_learning_on_cpu_port = true;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = MXL862XX_MAX_BRIDGES;

--
v2: 
  - Rebased against net tree
v1: https://lore.kernel.org/netdev/DU0P251MB0699AAFE65D7D30FE7D4C474C4A42@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM/
