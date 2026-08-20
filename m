Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010018.outbound.protection.outlook.com [52.103.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3715A86D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233573; cv=fail; b=mGIPexV6ErYXRUC0uy9XenPSBiVvP8HUu+sPm2ZRObMPel2tRhYjKpF9VeRafGfsEVCRFBtWoL5981DEx7t8mtyIXDA/eI45juhPfdqtkHAR80IYCWLtlOrL0/qGLTpRGw0r64+dJkdxwlhIGsHwxyeN6k6zW2Xc5lGCZr048ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233573; c=relaxed/simple;
	bh=huoabaYwuycoLSW08iyQqtmkzxs+uGG1G47BiLSF0Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bxBWpGoClWwv+r5HcSznD9ZBw5ZaHaDfMWv/bdpzEl3EnbSwB3E50iQy0buwiz7VmDz2sqf4BUF4C0euYPJfb/QxJJFYN1Vf2zmCwpLBcCILsYtP7OfBj3af+CUL5nfzMaszIDUiNgjOiG8MIfX1Mwci+k2+wjFukN1zxY89Av0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lVzaHEPZ; arc=fail smtp.client-ip=52.103.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lVzaHEPZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIb8QXOr8qHHBH7ZmqGrtJXjuNdMWyxb4WAKGbO6NK1UOdI/5ux4AwVhU7nwG1HolrjL+hqc4irE6hCgbvMeL5mmOaWuRzbE0vDAedgxW8SeywfQqiP7mn58YvvamzH9BZbQymfMp5WZvf3OdsMRBKH76SAImjzE5pmIn97k8Ho1iDh3jC5E5Y0ydJSViukxxPQY3O13iCjB+0/IgbdeZ6FDmNlcZqBuvwi6MpzbC83BhmMKAzimljC1HZGzQkz6tlpkOr1gPS412MdxSr8Hdy5+kV0wK25OMuLVl6pRwEufKN1eY7rzK25at+hHuuCSfArptfIoRiD1Kf8OYg1vQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYi8lHT6c+l4Y5z/Vk+pew16pdAGBLLF0TMDMeaCneI=;
 b=CsbHZEsFtuGuugb2NbYVg8lnu+LTP/c4OkUP7a4/2/xCUWnsyquXsxxL5mYXM2fPcbvsnTJM3xNRrxEatkYaFmnTyIocdVZwfU5PcxAgGN7SbHV3Mfxg4NMMzg/ARo+zZ1tGIQpVJlUGh8pW/obgTI6iS7cDZFdhqQ9WBwbThY/gqVB2V6LENidg/oXk6wyYn+Af656gizn1WAHgha94ComICwcCHfCavISG6zuz3fibY4vhhyOSrZw4x2rcuUaY4fi5GzAqi7Eyl0tt8r07qlDYU6Teg75Ct4hR3fQWLZjHqcHgi+pMb42XHOfIhah6RK8OD0T/rEeLt7GXuXiuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYi8lHT6c+l4Y5z/Vk+pew16pdAGBLLF0TMDMeaCneI=;
 b=lVzaHEPZ7O9SHzKWC0tlp24SfIxLdPHXqUOEJCagIaA1prEJ7f0YTNq5R/wljv+1ArNf0oYExNP6sEyqA8r9cDHkxo21Y3k9oyA7oZfMMoELOaf8MAJBlTHRfVUkG9W6RJFE9/ZuGpCr8VnuTkCx5DnZO3a2wffgFPJuUcGhkQXAha5FSpLZcY5gQhEh6AjHzkQCLhocVSHcxgOahyG/0lJECyEp0ctPq704Q6iLFmWXyFemlBN9QOvZwm3exP2dv/64ZhEubUYWTDAhj6i/SRjOSJ3svjMoKVDRRh5w6A1AwKgAzZG8JyVZIkZkKXOQR6YhE3SEiPeqnDbcxS9Iww==
Received: from DU0P251MB0699.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:32b::21)
 by PA1P251MB1066.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 13:46:09 +0000
Received: from DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 ([fe80::5d06:7ef9:757a:2816]) by DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 ([fe80::5d06:7ef9:757a:2816%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 13:46:09 +0000
From: Edoardo Pinci <epinci@outlook.com>
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Edoardo Pinci <epinci@outlook.com>
Subject: [PATCH] net: dsa: mxl862xx: enable assisted learning on CPU port
Date: Thu, 20 Aug 2026 15:45:54 +0200
Message-ID:
 <DU0P251MB0699AAFE65D7D30FE7D4C474C4A42@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008CE.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42a) To DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:32b::21)
X-Microsoft-Original-Message-ID: <20260820134555.1085195-1-epinci@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P251MB0699:EE_|PA1P251MB1066:EE_
X-MS-Office365-Filtering-Correlation-Id: d57bdd18-0d36-4ca6-2814-08defec163d2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|41001999006|5072599009|25010399006|4140399003|5062599005|15080799012|24021099003|23021999003|19110799012|8060799015|16041099003|12091999003|19061999003|3412199025|440099028|56899033|40105399003|53005399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZFB+XzQ5927h50zSjOj8UhExy+/HVhskMNt5gz8Wb7919q6vVkFXVbZCEdV?=
 =?us-ascii?Q?hTs62XesXE8unnOKcdKpSylmVEdFLPoHgREXh6JozC8C16yJVQO1QhxzeEge?=
 =?us-ascii?Q?PvCfngTAr1iAJuq3VTcez7PBFRI+TVA4m/OJy44R35v49BflRtt351Wg2MRI?=
 =?us-ascii?Q?AcTSzdWEEMNmzavyUocKmgvzUmQU64vQq6N1hzxkqoWaSnF/cg7S5dmC1DI4?=
 =?us-ascii?Q?zXfHM8ueP4QhfXhFaP78XyEk6UnGyf7/SvFjeqtS3zZNICDGg27Y/WNlhgPK?=
 =?us-ascii?Q?xKNkUyjgpX7bu49BDihCJIKMVG2y2YAZeWQg6KraKf4Bo+dhrrDpHAMQnYD1?=
 =?us-ascii?Q?zE8iHRAFjH9Jixz+4nxu9vHoekS0mdvQLB8UqF8f3o3LUTQW/1/blbV0zFYw?=
 =?us-ascii?Q?XG3dJkiPHhU22bG00/PumAxXv7v7I1Kblbz1mOOwzOixlYJgYrDkDJiYkLah?=
 =?us-ascii?Q?4Zfsi083azm7rwQr158sN2mp8t9/MbQCI9KwiGyBgNt97Za/zzlxK25nbF7w?=
 =?us-ascii?Q?sR3Q558oQsZg+4hKdhdJXuJ0SqTdwfgrk7x2TLtlfzX2gfD0D8O18FT8qlre?=
 =?us-ascii?Q?7nHDDYO50opYetEl+ZL0/d3gjIrAyv8RiFrFDqS6NJZpAeTdYL2FS6TZf9JV?=
 =?us-ascii?Q?uwGTwuZYLuCBjUSQfRLZLQWqDaojUoo6Cc766hkqQSX+9aJaxrI7oL2xaZZM?=
 =?us-ascii?Q?OjS9STuUgJj9pmLRXAE8TiEMDeFng5ijNjBpfOAKngnnuJZuaeEh0OEuyBZU?=
 =?us-ascii?Q?xgBNbhrEfMjR4i86DTABBlXOgdvqf+7v9T7+LbK4PxostIuCV+HKvNtvjXrO?=
 =?us-ascii?Q?UNqEa5o3Z0B/2/MqBXyMxyHbzx+1Kkdt2h/vM9MyvewiNUcAj6iDhT8Xhy+J?=
 =?us-ascii?Q?ZL0/WVn8hCuP6KGYhVuOyv+WY9suaJlUXsvKJugbzCRsir9DO6iRtwRQz1B8?=
 =?us-ascii?Q?cDa8NfVBRiHJIwZn1LF6/MyvGAF12Iq1NggbbfR4T6adFQWeJcFxHfixPjPY?=
 =?us-ascii?Q?VYixKpvnmVj3SA5WRTVoGRRorJl9sy13H6elD2VzoOsFUStkHd244BCu1x34?=
 =?us-ascii?Q?H20oBKY/DYB7ek6xdCp9BKkfBhPNUDQ0NFiU2L+8xVu14r62KXmneIbNXvOD?=
 =?us-ascii?Q?m+4R7F5Bjnk3P7GxY7Uka+1i4z62H3+8hA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkge/xI6k3fHPWffw8HYAvcqQ6EGZ+qfszdJ87IwR7/kC1U32yWbUS7BV9El?=
 =?us-ascii?Q?7fC0wOEawryR4KhUiGWzC2YXBL5mxYf21aXN0eDR7v5UlQSMdj2SbsYCm/rc?=
 =?us-ascii?Q?sst2VQpZhJgFmcJEXh6+fXfA2nVnWzuAu0h100p+4QcbZC2rdEg1R7syfmu0?=
 =?us-ascii?Q?/xJ+BkyQwnGQzPX/Bj8ZluM4+LKnxL/7N3hGn/Sn0gwMHoMX5kq7Y6hSvzmp?=
 =?us-ascii?Q?j54YlU7Bz/256qDchYxOH63Yo7X6YAWCiBOcnrJZqCyWRWPUjjKaGQVqQbpx?=
 =?us-ascii?Q?7lfHwaxY0rnSGvdJErwEoFeoTouTWh8jhKPC5GyDe3BQGQ1/ktDg6fkqXQlH?=
 =?us-ascii?Q?cgI1WyMnCVDxccy/wFF1v9uP5P0vuqvrHLwho0oqZ7yr21B8sby+lUgZkqSG?=
 =?us-ascii?Q?jmRfJ7C8Ny9xqxC0dHIfOcVkdrZ0dGzcJYSP5d9xQ+NSEKyQOQdPxgMfEGT5?=
 =?us-ascii?Q?fdh+VsiMhx4gQ7/oemnAUHj8xGyIZfa9vxTqeLxquGpsSjWC/eCN2OHkFORF?=
 =?us-ascii?Q?wvi225++8/teZMKKE40l+uzgzGU5IfAKRJ0lMja5YNan5xUduONohqP+qHx4?=
 =?us-ascii?Q?8kvNzBaTU14OMEjnOJLwowCw940B37xy6od6p50P39qR47O7XSpTNFr7TwA2?=
 =?us-ascii?Q?7RAwEuY2gBnFnhVIh4/e6Ug5R+v9Fa21yNfw4sZ515ZzSVas4zAf0rNPE757?=
 =?us-ascii?Q?oKzjUY3TfnSVCCpQGK1RiPRy+a2llMEClBk7O20mh7HccdEjvVodV05oaDYY?=
 =?us-ascii?Q?oenIdjqIByVMoWZuB0XUrtU6mhXF74n8Ky76D6+5odMzrfOAzpMYLHj9bGOT?=
 =?us-ascii?Q?YPnvLOlel8/I8dNQJxdr+0kdihN9sXqQN47iPM+6wMjkDJxipGvgSfK4zvLz?=
 =?us-ascii?Q?jDUFdvd2SKqPKNTfNjoYWqTzZ9ezB11Hcx7rIIwQpng0sBDNxbLaixngbasE?=
 =?us-ascii?Q?SgX12e7DOWw3YNxxgI7gZkSgm7fia0ENGCGNSokN6zFr4+dlcgs+Y145xkBw?=
 =?us-ascii?Q?w+GmjjSO1fBNy1OEhT13VkgS5Av0yn4ARCHmuI+iyROhzHr5RCHKkDsj6jAT?=
 =?us-ascii?Q?DZB3/d33D2Xj70Ut07SUJW+K2Bbh3dwwoc66CG1AGvMNYcgQ/Tl7inatxaYd?=
 =?us-ascii?Q?yuEyoex6Tq8UBaVd6PlANGX4haCSVi1FNETBWTI2dLk83XwIrDUgc4j/z58T?=
 =?us-ascii?Q?9dgrgUfZSsiL5gRLWtDAq52X6HtpcF2irG96JPuEC7viNxqloTcHWoSEcmEE?=
 =?us-ascii?Q?+gRkCsGodYMtQg0ARSW4KuPxizvx+F12I/dRscx8K7vJs8ahSZsmsoHX+a4i?=
 =?us-ascii?Q?9ikhWX4f4rHT34nrS+c2jGADMc6M7twQy4RupHMvJtDZ5ZfVadQvE19syjqt?=
 =?us-ascii?Q?j5IGewkHAO9lgGc9xw5I5EmgQZta?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57bdd18-0d36-4ca6-2814-08defec163d2
X-MS-Exchange-CrossTenant-AuthSource: DU0P251MB0699.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 13:46:09.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P251MB1066

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
@@ -4571,6 +4571,7 @@ static int mxl862xx_probe(struct mdio_de
 	ds->ops = &mxl862xx_switch_ops;
 	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
 	ds->num_ports = MXL862XX_MAX_PORTS;
+	ds->assisted_learning_on_cpu_port = true;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = MXL862XX_MAX_BRIDGES;
 	ds->num_lag_ids = MXL862XX_MAX_LAG_IDS;
--
2.46.0
