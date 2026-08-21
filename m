Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027032FA2E;
	Fri, 21 Aug 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282462; cv=fail; b=C1NSFEHHOUeE1oB8n9I2AjzRX5uQKEyER/X6vZOw6WmWLiMQlfXz8kS0n65rwbv5UmjHFroaHZwL5U5pxiloRCBBxETedfyfepIWqELuAdJY7OPjpRk8G3F0jdzjTX4ci5iI4pJImQl/xt54Obi2yPOIG5kxOWiPMYeUKIiKaYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282462; c=relaxed/simple;
	bh=UYV5jugun0395r8CzdlI6zELQC2gHSFRBW+uf6sxVMk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oVaMgEdd7r6qIbouxrHlId32TUhL/2ugXAFjSRmtQVHZVmdUe0MbnRLJ5WtKCfGlotOlJZzOUzhOd5FlCJvUwfmeBaFnelWQXIw2OYMGog1liVy9LEuRHdf25SXXuTrRwMnGF2JI9QnvKKj79cxloHKYMKdPZ2A0KWGHT+ojGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kR8bjGsl; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kR8bjGsl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru+cJHwL2v/FP8v/nTyyxq37re4cDSWEnt9ZdxJZb9Vsb9AY8dpKuYqR+AFOXeJ0vC4s3kSMP16XBZN48Etec/A/cEyDvN789UilaWTYA3+HAuU5GPM7U/XPFbOFxY/+Zm1gun7RxA9qkNGoAwuCVB3XbMQDmC8OCmEK3iVH6/31cDemm61K/q5/AeoEktykGy+z3QUjy7KzAQdsEoAk5x7qUB/lU5vkpFzzJ2OiRZc3mSeqhJ7Npy0E8jEy/dGQTKzIQP0aLsLxi5usKh3AlM7zH03XIMuEOFxWuwxqzD0/yfFwd3ZQDzHQmeMMZUp/iZu5ZvPRTXs1N3+BruRTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzbF2pf7TncMgU31ZO+EPjFivYThqqki+KBsPcCh1A8=;
 b=hvhZOz26iuhtiROZ9YN+VpPICshqvDB5AV6ZjcTKLL9+FUlwMieSmSHGgrZlsh2QxiuvmhIGm6phPhfK2LUSydA4Tda2COhtGbkmJRNHTHIdt2ssiImSpjS30vYT8t0JlKeKq5hSXf32d/dRNs5dqUjto70bHeP19H24f4OP9dacnPR2x5ryVgXF5gDR0djmF1uHZChedwrYo/qkbSVtaWmjnkwwqMTg+8D3FUv0nUVBjJRQz96BMn+1/KwYQyoU9h+mdyle1qLa5Ux27s1sTR60LfYingn9722nrTzgc/quv6WmVqLp4tst4B6UcnK8Knzsj8SY011RRkrptoAi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzbF2pf7TncMgU31ZO+EPjFivYThqqki+KBsPcCh1A8=;
 b=kR8bjGslb2QKqUtJ90O/cHkbgzC/6WfIeGh5U4cY+VLrr7I7UF64U2qQ/Au37mXNiwawIme6+cCF35Vj6TUq6mRM9mB1kTLZV1x+JffXoPt0W2HInByFhRsYgCJqt0xu950VarRZjPjPziSKYMWCPZPo7p1+rlefJRLCpW0EulFDbg4q0AeY5WqAgYnErBaVwn/yIRA8Tp/ZZXi2Na1rD4qmDXnm5IRKktvOxe2rtnnRDDA8UKgVsKWYaJG/2UARnXD8mIOjyaxtFjtgXpum5x7Gxrm5dk+nkZiZ+Jww3Ek3AupSo6zCOrAhHnB4NOVNSeBjwAezT/RJGyjb/KA4uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10408.eurprd04.prod.outlook.com (2603:10a6:150:1db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 03:20:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:53 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com,
	horms@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
Date: Fri, 21 Aug 2026 11:24:49 +0800
Message-Id: <20260821032449.1235065-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10408:EE_
X-MS-Office365-Filtering-Correlation-Id: b873b8ff-15c5-46bf-dad1-08deff3334c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Avl2kroNV4665BX+yHaYcFYAMgAPGquuOsHUxSzejfpVT0HKXcTqmDH09F1TiVivee5rkR1tYKDmBn7ZPp+DwDBRdv5vZayoQUGKokiY5Y9YCVE72N/QZBR1N4z9QuuxKbzi/dN0JahNflDOKm7OAxxL1hzApsfDfKIEsaD++/X5sFD0uWkH1SIpnEqPSLrkN78A4h8M6SO4WQGcUX1kWtOZdL8HCxYrgBUKQXsg7NGWAqiJnBEFhtsJUkATT4zTe+AtlgSVsNm/Jz1IwCeTKwCVBXTSO1CKpIylo3OW7SzBxNWEOM/C8d6zJPhaN92dvHX5Gp8vufCMCDsqqCRhPUH4zsIweC4nq8zPbYIRmzPnv7lYh5WbZEc5kpoNJRd0P+qrfzaci0Go9XtpoEw7049nHUfM0zgiZp+rnNoLVkAJkxIrCOllthWqnaDLMbayoTTS4yVGEXaBsCurAKEBY0bpPTisUfNDjYJEHeIMpiwaS8P73xOfqz7t8G96GR3bZWywwddZSDJ+CA7cRP1pmW417yAshB+IwSK3Pj3WWWnI7gKoStQ9buhcF//1ay4kYXxPPcdAvmeePKf2xlPiNEqj8qKjo48rafbVtzgHUaaqsn1YOEREbLMqAC1OYN8S0Q7TuktPaoeVv+FSKkx76UT3XA52ue+MyUm/tLfF7+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AP+KIGYlmhijp27CDgJPZewm/XR06NtTlqp4N89kvw84AZVwEUt8uifjNlvD?=
 =?us-ascii?Q?qebmpnp8cJ6YD2UvfDJ+dv0mgbmkHmjotgnvOt+F5sK3Q6nnF/GyZ2ipSwHh?=
 =?us-ascii?Q?/289Ojf4rmtoaVAu0kD6MsptuWs6N1s3gLkHMX8UxTAmC1bdxTd24iMzSnSN?=
 =?us-ascii?Q?esv/1Q0zxyk69FLn7feHQvrNtScdqxGTE9vYOGJsMOLdlwqaVeOH7sr2nv/W?=
 =?us-ascii?Q?JzB8K6xiRjdec2kI3h02a/Q3WiAi0szfRELtY2JS6QKyh5/9az3zqwCYNBy6?=
 =?us-ascii?Q?piJ/D1iF/aBu/14SuhlsXSIbqZf2HrviPR7vUKLxDC3B7jF2a76IuqQtI2vA?=
 =?us-ascii?Q?UFyTr+ZFaDD1Xm9ReoVlWKhLgSliU1Tsg3amgv9bSc1y8IclsHT9cQFGQsP1?=
 =?us-ascii?Q?u+s/QpT7HYqfeH95S+QLO9w1kluaZ1WCW8HT9cRSXtsk70/RleC2AIyc2uh7?=
 =?us-ascii?Q?CbuXI2bb30LqC0XV+lQMWEfvdAuC1NWGdF9Ln3mJ8UISgorXGuq/boF3Pbww?=
 =?us-ascii?Q?7hZSTnUsTrvfJqqJJDpruwRtcen/euRKxdxo8R5sYIYDVHZ0qWg96yc3jm9H?=
 =?us-ascii?Q?gQJ8SOR2L4yan29nsjvRVUFWZgW5Yj2RRPddPCdX4tqsx8+9TseC05PN3bPb?=
 =?us-ascii?Q?y7ye3yiiyRFE/OszWyL9pq7kO0lCoDMx/mGiImEGrZYEADsKSY7SRQn5cQNz?=
 =?us-ascii?Q?ILVBEWEaflMEhYDFgrPgLOi/PKc/hxVNky8o7OzKiKuXu/HWxFDF8eYBmqh6?=
 =?us-ascii?Q?6ADcmGU9vJixjHBT+5LNwFaL4jtHYYxsTv29Fbi1Aj4Fu1Jg6Io5Jh2E3DHy?=
 =?us-ascii?Q?rCMwAnJ8XvSVdGtgWK62jDfmTdSikhY7oPWJOwJzn5J0jhBukGCjPPRZsuvu?=
 =?us-ascii?Q?Vw/2DbL8mfgI+s1wL3+7GsPeuv15+OgFeIXjugenyleh3l4k+xDKHNF84Mw8?=
 =?us-ascii?Q?jWS3Ndjqaz7rjhxHotcjuF0HiV/IAxQvV1qNVsv2C+xe+qiR3ar/nO20RTKF?=
 =?us-ascii?Q?0iRdkVAt8p/99ZJRu71w6/FY6wpgO60QuEmZKus4rZZOUzUFyuxwEFa4Wx/s?=
 =?us-ascii?Q?GzyjUr7qkNoP7lOpFnS5jD3at/KrDFKzG9A2+xSkftL+FLydewee/TYQVhh9?=
 =?us-ascii?Q?gMwPtW+LimPRXzJ6haEAnNNWno8CBKuh7NCqE82KqTqM0RdBx2f9VHn/nMr3?=
 =?us-ascii?Q?gsSLuiUGQQ16m9Y5OLo7lk+cqz+uzp/A3sbjYqRT1J7X2P8veWvShzDeG6w4?=
 =?us-ascii?Q?ViLaE0odd8rDHpkHBqw9lGlI/QnlYk7dinA86tEPpYp1Sm/Tc+GAKzd1nmmS?=
 =?us-ascii?Q?5IqcdfFshHv/cJ2VJCSTx2jjgsYw0lMst1h1WJK4uuoetEVQDnOJ28wy4JNX?=
 =?us-ascii?Q?Y7x+e1tKIV1xs0yztXkBYog8p4Jif1yE2PvSBGRhZqxaGwZnSj3y/ePYR6OA?=
 =?us-ascii?Q?HtbKCTvfCPw+4nZWL01JRJ59EwEhPf1h5zKEuLjGEYfG7+CO2KDRbP8KefyM?=
 =?us-ascii?Q?/dl58QK1T5x4+pop+TGNINGwfTBeQRTa0iXIwUpt8aPFh+ERdTws6clWY7up?=
 =?us-ascii?Q?8us4zJfMMeMJ81HxJRMwXTh/o1CL5mIwzBfpDhYo9V+PJPCx5RGcqEV01NGe?=
 =?us-ascii?Q?wPa7z20ZMQvDPz1RwMpXMAdxpCtR+yM4uWCp82yTrclXcaCnM8R3xXdLjrWN?=
 =?us-ascii?Q?8XlGmMDPaSdlli6Y3DzAbk6XAzmJ41mOCbj8DoXWC6AVlvmfUaeFVUgDIssg?=
 =?us-ascii?Q?g3Lejlm8JFocgtVZ+B8ftAjIeYUxiRyGKtZm3zcOSEHU3MXdRoGs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b873b8ff-15c5-46bf-dad1-08deff3334c5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 03:20:53.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCvKUvozZmpbBkodr4lcx5w4IQ+j/i6bqV2dyyW7+DjKzCYxkTmNyk36RwKA+u1sEUifnmMYhuP/o1JYJAQbiIAzFaM5mDneKjP84EaPkIf07mHTZ52WmNDgQ3acoJ+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10408

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
v2:
Remove max_period and use NETC_TMR_DEFAULT_FIPER directly
---
 drivers/ptp/ptp_netc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 59db08e189e6..19ca99d80e95 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -440,7 +440,7 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	}
 
 	if (on) {
-		u64 period_ns, gclk_period, max_period, min_period;
+		u64 period_ns, gclk_period, min_period;
 		struct timespec64 period, stime;
 		u32 integral_period;
 		int alarm_id;
@@ -450,12 +450,12 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 		period_ns = timespec64_to_ns(&period);
 
 		integral_period = netc_timer_get_integral_period(priv);
-		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
 		gclk_period = netc_timer_get_gclk_period(priv);
 		min_period = gclk_period * 4 + integral_period;
-		if (period_ns > max_period || period_ns < min_period) {
-			dev_err(dev, "The period range is %llu ~ %llu\n",
-				min_period, max_period);
+		if (period_ns > NETC_TMR_DEFAULT_FIPER ||
+		    period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %lu\n",
+				min_period, NETC_TMR_DEFAULT_FIPER);
 			err = -EINVAL;
 			goto unlock_spinlock;
 		}
-- 
2.34.1

