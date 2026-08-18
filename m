Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731C246788;
	Tue, 18 Aug 2026 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023792; cv=fail; b=fAGJQoEfiuRHGLf0FrAQflzbTGrxRpq82BP8lRN9bxWQuu4HMO/KJH+vlXxS3DrhH2X0OHh2FDssR0lT1/VMfr/EJr9X+Gp/ln+wNHPvy1lCwCXJMGHAOzV4zwTY734rnkg4yx0/ZKe/R5pT5h7cuhEfFnvkB5nX9LgDHQJA6RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023792; c=relaxed/simple;
	bh=0gK/t137q/OZW7PLjER+oQYAli3QTUCYRkgY3Hr1jDU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PiBUE/2bSMYxr/tFd5Cd4J4SzDHdjSd4hnVa6XtY7Bq9jMDPa/TK2ykLntfx51Ns3G+n7rE+k2iWxvu9J08loO1f0UFUjtrg2yODJQcLrN8cPnIKWyPCtPNc+ZCTvfXiX+DgQZiJXZRAuY/ISBzBDVFJUszmRj8uYSFnDjVRg7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qvIBrqKf; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qvIBrqKf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9KBBw+lXqn9d7ssHsePeowsf/1AA38SWd70npy0/Egofr1Ckbnarq97EFteT0VnCZHyruyLVjNSTYnfpvj1b7Nl7jsuAIOm86qyvibqLViGoYt7AT+pB5ndXVQ2Nx5QuDvIhkHpBztXyxy9e34M+GZvuOToDViOfaFwGAfkvZtYXWFVX414QKY9979bGHgAMPfgruQZtZc85NVzzAD5wuYmnsbW4eSuXrofXChfehaucliLNzKecTdPoDpKlTkL20av8P6Icab6/5Py/AA+S/dIbsf0ZG2+3jrs2kYTdrC/OaoIlrwjIT4OgCTT3N0ahdQa/Rg22mc8NQ1/1DiI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUsbgWdnw7er73OY7hM7t7wjg2vm/W6pTbI10Q9e1jw=;
 b=Kf0OnA1aO5rtcvhn+v8E4kN1DC+ML1IaRUV+Ql4JS0SpaT1y25oXx3mtHJBkDgUeXpMVH7L21T5Lf+0/l2QW0U2sxatQhMPP1YbvCcNo00/Ee0ljs2beMwol37UPsoXdPfOVugq3ANY6WcZGH4i685wW+Z63KZoZSEIhju2y0bksygv0bihFagq5HsBguwDe9PRlZ/24huzfQvq5k3l3bVZb4okQF9sdzk9v+yQwN5r9bnW8+u6tySSe7mBIo2ihhL7aTg4X+3o11uaRxOzO4nnma0f+3crbx3dqOQKSlknF7NFeF+0VYiGL2s7AVOQNeJ2JWqlOo3WV3szsbYvZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUsbgWdnw7er73OY7hM7t7wjg2vm/W6pTbI10Q9e1jw=;
 b=qvIBrqKf33wndCPxvoa3V9qweWh8Zn+Aptd2ZieaHOMCFkVsLXpUp8oHun1DQvORbD5tPaLf3KFlggTXgr5rnV/Xup9wKBM7BjEneCxrW+cc/M6FxAl/j6+eRki5z72S49lYmejjkRTiSRdzkfJyRudl/OaUzureCdbwS4d607aZ/LnXwWK7dh/3MllXX9tdI7IXFIexNwnBiPuf5bI8KysqvAFbU/1SI1i4B3QqogvW1RevGEmLudtTl/ph8uZtgNjZkuvqKGbPn4G6y2EcuLnhSGaTIq+r4HnzOrNcxShlxQrfrEzhrnYin0dHJT27t3B0V4Trv629koi8GMo+Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB11925.eurprd04.prod.outlook.com (2603:10a6:10:61b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:29:46 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 03:29:46 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
Date: Tue, 18 Aug 2026 11:33:41 +0800
Message-Id: <20260818033342.3154990-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB11925:EE_
X-MS-Office365-Filtering-Correlation-Id: 88637855-d0c1-4880-527a-08defcd8f355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	TLkjqUoocqg5ZwfaCcSKdm/MDhEaAWCZUq/0WQSmMnlnRb+mhRZNpI7u4yy1sonMQi5IbcPDyoSckSkTRUUROqGmiiQKoVr1ifpQDQKZM7AfdFtofCz2UfvTZRiOnuyi3K+2/4AE/IzkKd3ztsXmjYFpxeVbrnS5Syc6vWXIL7QVVEFgIFa7O4VrR5bA3ame/6fQjREPhs3FtSWsxRetipcmpvkf7GL2StCNAwLUhydcVaGqWMBGEbfNi+gLep7KKOv6p84T9rvzChmOuvDHfpfIO/u72USJvbW/byPaO4CmI3BtrDO2qPvzUig43013h2+Vl25fYTuILmwl4pyfvFTrKDYbY3JL0vQg/YpuDfFUv2jwTE6xDYzPuwwTW2e49ZgJC3KebDqIpGlmzleUMkpsZKsgQ7uBh0F2gnkoxP9iu98Of9XQglmKFNAEjZ74DVXG81whLEcmfe8hksFWc94jAbB7u4a3mh5oxlYqLD9QzQgnv+KUUlAVuqRv6wb+VikAp/BozDqgl/ZQSd+9JK1YY2mgkTj9tGIu4g+AP1X2/f439LD14LsEyYVb4kLOzmvWrg29ZK0JLTIv4ZaQJBoMZx6J9BrrrWw3/EWTAM3Fndri1VnjPlO1+xPwdYNebLSyi+ahUMQdBTT2baLxyMZTYEO1J/obveVNIE4GNfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SV9vRGN1Fz2pe4yyQVMqAkES7N+95S6H8kr6kt/O4i0rGuhkXS/32NSA2DAU?=
 =?us-ascii?Q?pN13RBjL8hSt/K73lTGqUeKXfLFP5dyV3KMHbw4juNYy6GWa891DB6w13J9z?=
 =?us-ascii?Q?JBo6uWCDCf+9rLpLRoP80RpbO7zsnHbfGOOP5gwfPNvnVedgffSYgN1a43lY?=
 =?us-ascii?Q?yxuSO6Spgx7yFFVwPyKgmheQMbZY5917tBXM39xlGbHZK4fBhP3xNjvt8sVH?=
 =?us-ascii?Q?nOQk0Vgv3F68r0M9g1E9+pmKx2vbmWNzT51R9ch77hley50H3AOMjNgNVhAq?=
 =?us-ascii?Q?ZTwvn72IjeKiSuMUvsrbk5a7IIDNNKzkWQzq0Fz8/lRADOKGQYjS21Dj65YI?=
 =?us-ascii?Q?VhHdSeyvauqyLrHzALqz238xU10MUIMC6bilQ9PmebmDrwIWNVtwzJ/KHFXG?=
 =?us-ascii?Q?2xVodkWnPJmXB2rz4BuZ9SCgUutho9xS6hDawCXuvmn8xsq84gQRF8ZQwkFP?=
 =?us-ascii?Q?zyHBSUWXUCd8PEtZBv/es+U/Th7ZEqApoP5VFB6u29/b3XwLSgPRxA76N2Ra?=
 =?us-ascii?Q?hdy3cPpiKHmrBIk3PvRj1CZWa2FJ9ZAADKpmnEN2khjHBMzosvNYRg4oVOUi?=
 =?us-ascii?Q?e6U6u4HADPd9I2npjDaaDpajd3kHytP/lulGq43DQCFoLU+1EV4lWuylNcsr?=
 =?us-ascii?Q?yfNawp82JR8rZVqcRR4Yck/NWy2wxBrgMOLHJpZDfFe1HYjCOFXKzLfjLxGn?=
 =?us-ascii?Q?E9KhT47NkRK2TqgujYeH9BopZueoXMqMEaDDShT1iKC61ilT48Xv8t3yxHvo?=
 =?us-ascii?Q?g4q1IOGk5qkMTVgYN3/Wo+PqmV5GBJj6qS3t8tBTr3Gwymo5Zt94x6QqP4FB?=
 =?us-ascii?Q?o3XOnid4Qm2VZNgvx3sxlUSaOVkXK4epow+14iMI+MYEZV+kFZDH5lO4WOYP?=
 =?us-ascii?Q?10ZEmtZkPihfphikLvY5kHFH+dtTEG9WKQ/EDj95Kb6Gtp/LiK/oaFj5CHLl?=
 =?us-ascii?Q?+4Cty9rxi380SGhzWl+99PKo8NoAzoayLyx5cGFw9Nuj7XAhOgw7L5dmQ3FU?=
 =?us-ascii?Q?r/nKVeVkwSWQW88ALg9A6Tckt/Se+jHl4qAfuKJfxDOSlylB94rPaW+FbZEE?=
 =?us-ascii?Q?15E5CzJ5bDWmiwAsVe5DDvmEYPDV3m8sDPmuDT5r2LFWMnYJw3MuebTQHVQX?=
 =?us-ascii?Q?qT7k35/xNElmnEK8CUg98T0eXovXe1KRZPzTF/QMm2KEoboOcs14J5rGHXJl?=
 =?us-ascii?Q?Czt71VnKgrtzO7CPa0QLWAgjT8nlPmrG5WkRavmTIZatN0qzmBWIR7s4qSY1?=
 =?us-ascii?Q?whMb0whiDRpo1Am/8xOVf+cXCepbmGj+zCKIwIL6hm4vGRRei2wCYSm3Hnu2?=
 =?us-ascii?Q?FLSfK6QkuCn4h9KyvFm6uDBnnWZqTpt00XIrsfZBLvZsHmqLsO7tBGyGeoSB?=
 =?us-ascii?Q?xT0Wnq0rC01htJJg+lw688k3qHMA/Az/Ybo5dR3oWIvV2Y5VLnuuY0xYA72d?=
 =?us-ascii?Q?wY7PjpASvl+LXR4v9LZGv4AHchkXMMCA5QXTKOd8i+yUW4m4w3Ze81zCwvb3?=
 =?us-ascii?Q?KJ1+ywYqEYBNWfv1OAM0RCWIVV3kRq6+hFJOFZP+tsnhk5xPssd1CeFm8E3i?=
 =?us-ascii?Q?yzp77HAuYqObciXLS5qkvbiLl/vM24Z/V/wGLUg1N8pHZYMMLPNx1Ju0n2eB?=
 =?us-ascii?Q?TOgJSYQVVEtVs1zxvn9WcEJ1INXRY4GNt4b8FGScTlbdhUrgIvtxj0LNKT2m?=
 =?us-ascii?Q?uBatqDqrJyawi8TH+MkqJiK500OPF7pv6aC46Hm8m8eRNIi4bzR4GUz+eSqo?=
 =?us-ascii?Q?J6FbGr9HrtT8KLv6fN/Dnhx2z4Wggo1KxcyWbEaNCgFmrAWjsw88?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88637855-d0c1-4880-527a-08defcd8f355
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:29:46.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn983BcAPQLvuXWm5Xbv9T3Y0fCP/3axCa1dPTpjKVNY+VsKdp+Jh3+941MRCuPjvKSUNJUOUu1eFE/uM0YaxOI20ZFXHYGzIWLo4W/IUwa2UrmLtXJkboQhlfNemj1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11925

From: Wei Fang <wei.fang@nxp.com>

The max_period bound in net_timer_enable_perout() was computed as:

  max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;

which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002 for
the default 333333333 Hz clock). A period_ns that passes this check but
exceeds U32_MAX is then silently truncated when stored into the u32
struct netc_pp::period field.

A truncated value of zero can reach netc_timer_set_perout_alarm(), where
the local u32 period variable would also be 0, causing a divide-by-zero
in roundup_u64(delta, period) whenever the stime < min_time branch is
taken (which always happens for a start time of {0, 0}).

Additionally, netc_timer_enable_periodic_pulse() and
netc_timer_enable_fiper() both compute:

  fiper = pp->period - integral_period;

A zero pp->period results in an unsigned wraparound to 0xFFFFFFFD,
mis-programming the FIPER hardware register.

Fix all three issues by capping max_period at NETC_TMR_DEFAULT_FIPER
(0xFFFFFFFF). This ensures that any period_ns passing the range check
fits in a u32 without truncation, so the stored value is always valid
and non-zero. The accepted range is reduced by integral_period ns
(typically only a few nanoseconds), which is negligible in practice.

Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 59db08e189e6..05d606e636b1 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -450,7 +450,7 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 		period_ns = timespec64_to_ns(&period);
 
 		integral_period = netc_timer_get_integral_period(priv);
-		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		max_period = NETC_TMR_DEFAULT_FIPER;
 		gclk_period = netc_timer_get_gclk_period(priv);
 		min_period = gclk_period * 4 + integral_period;
 		if (period_ns > max_period || period_ns < min_period) {
-- 
2.34.1

