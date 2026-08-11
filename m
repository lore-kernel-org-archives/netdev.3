Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5D40EB9B;
	Tue, 11 Aug 2026 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437152; cv=fail; b=cJWOmi/DrF4522wd9ejagF5Lf9h7e93lg7bFbL3xVC5xkczUi21748wJWeM728yOWg/xRzNKpdrYuJ5PdvgytVAPeAwoSqgJg+5jyHLjaLPYI/ZRIFhdTov0W8rj6Ag1qVjT1L8XuIqA7LwlxxqWKqq+hxaPsKydSbFPffJgWMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437152; c=relaxed/simple;
	bh=e8caF/hxKb9bfEOA5fwWBFJicgou0ifHjChExGSAvso=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g6oAKtnoNb5B0Ph1zzUIVob945RrZb0iTEeGr4NfssJOX85hlSPsG9B+zXtG4jrJaJbShE7Rbd4scXpzR2VFsKnfBsPwWePlpkPtdad73dsJEeskZYzS1AAx1wroimVCizSr1FY2MJWxRsAqCMYrGr9LYjGSpsJsH8WzCk+SkkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dZLSPQia; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dZLSPQia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT+qlmzz4azXf33d8cYJ8kr+t/VbtUQA+0M1b9LtttkkS1kCHJO1KB72qYkstapYhbJm2Woa13evjfediHAKCQhG8csyMLMtzjNR/istTSYODVCCwOLtvg+tsX1CrfrwQsoToK9+RgzYILbGfU4duUKZCpN2kEFd+B0gEFS/U1YjRD4/0PD3Hea5SZrHlDUZuDy7FnK/HLhNEbg0k+WjtEqImNp/1p+gzfXWOTWnNtbUPoAgwHRlOKn3Egllc9tas0N0snaQfizuiwVbXVFzBi1lXyCoxRfZw5fBS6O0DdICLf+UojIB0OCZ9REb8nIeQhxIMVle/XWRWOyykRBIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ielzt+N7RgafX8nN0ShOmvRbz3ckgOLPF2Ymoaecyg=;
 b=e3/N4l3ZvwXWwZQmF9M0jhbryw5VCywoXT+eloIib1EP9BM/q+7n4cMbUE9NV6luyhhplIreQ6Rbc7vAxktJ1UuBDKdc/C1G3eSXt3BheE9MWsQX8SOOM7QfFZNmSMiXwtHkkoUtz87RVxRDiPKwffRmtfuWfKj+7uKFvfOFImGi+6IAKD2wCFemM/lBMoWv37hsnjNSeN7wmggof5Rf/7YqbitY1JIkmvM7OhrGvlwV1GvKVoRTN0fePgw+sbZW6lJvDEj2q/1jklU4Z1CQB8vjyAN5JgkLtARdVvCVqLjVfbWwDuBRllajTaS7dETGWXrlkCLjOlBhkdZ4d3Z/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ielzt+N7RgafX8nN0ShOmvRbz3ckgOLPF2Ymoaecyg=;
 b=dZLSPQiateqHIgdBthdcfwUwkIEAvsOs5LpElUBHMa42pWTiSGwt+WXp0PXBtnkZGxRG2aUKdTQ1SWjfSh0s1UV5Fug3EF9JYhsx0L9v5CaDP73KwFl8f1MK/CJgYjFBmSNWkPJnjfDb2fNnVR6PVOgGyiscxZVPlH45cBuT7e30hIb1guIW7TgYr8dal4pwZVh9qEltaSpCOjVE44H9I8ALeMY7UTzZrosLu97rszjHukgA2bbJVYMMXEfHByUrjAS0MdpsMdy88vLZpgtnrZ1iovQBMROwdBJhvSxePA/eDXeiWhOD9KoW07qfidkQTsg2q8foAtPpaAb0aWACEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB12040.eurprd04.prod.outlook.com (2603:10a6:150:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 08:32:26 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:32:26 +0000
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
Subject: [PATCH net] ptp: netc: skip PEROUT disable if channel is not enabled
Date: Tue, 11 Aug 2026 16:36:14 +0800
Message-Id: <20260811083614.3589967-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB12040:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b10dfb-48d5-45ca-1c63-08def78312ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|56012099006|11063799006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mr+U0l1FHmbhGYlABVnWNi+xAxcAmZhWkhgj647HWmDw4S8NPN7KwNQ6V1BCcJJPMDoW89kzf8bXJNyHbfBZ2Iihq+6WhG3cyhVvAy6HY17iQldOVSbit7n/PwSdiZHWPwwWl/bN383lRGyVhvrlKElILsdr2ONP2N3qhCJHe4TyuuyeUVAEXjOyuU6zrcrKWHlqiQQ2QtWpuJRco4PTsbeUSuF2Z+UAYUuQQJNqnQbTW4Bu65gFIKQbTGobjWjB7w0f3akucpML/YDRhRYsGpyyu8dq6EeuQReg5pHRfkTrpsGTYkwvF4bmQfpLlEFXg3kxTa/b9Ohpz92GxksLlWqR2sF2Q2FiuHGY7Q3mlxxGBo60NeJU9LQ0tP2CUiYtIvImk4zUw2Xv2atlZzopZiV6o55mH8ToO7G5ZdGqgKIGuBAZWW7rPx5STeZRHv0SxvXkbacDBzokrRzocs9642TEDFiUm1n3uLHUhLKOvS2G2NW/bXO/AU0v7ntkhWv2GHtbrzNA1R4tdzxqS9DdKc5A1M+6CN3xRrf76sgb9VXhB1Js7SvrHIDThCcZt+MzJl4ytLKidN5JwPJXESijun7fkHOzvex7g7Mf1h5b/fI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0M1zVygIaQ2sgoT4fnYVvlI0b8h4IGJ19qW7M4lHS0B3Q8x+c9tW3XQWvPh7?=
 =?us-ascii?Q?wtgyMbrQ2+AJh+KIW6IeSmRNsiU7Ay0XQn7whx8oFVrzAcs5vQj7nQhB+nGI?=
 =?us-ascii?Q?xlCKoFli7q7kJZAfvHzj4POiiqFWyMTmOmWWuZCh8qw2bUsxve6jSMAnSN8n?=
 =?us-ascii?Q?lWk6i2Le622H7glSu/XaIkKiYetvO9oKzSxJuJb37qZHO7SYWvbl426Sx7y+?=
 =?us-ascii?Q?/NAzgLL4qladTqEzVD+nFcFD+OaU6Xg7Z3rlU+K8Eo9n50UEK6Ot8t3d02se?=
 =?us-ascii?Q?KTCmT4dXkkcE+/59e2fMRC0K2p9gsie5P4KAc2Y/Jt5vBYlbih3d1SyoEg0/?=
 =?us-ascii?Q?d9GbCP37rD7aDrssF5HCV2eslU+enWYNoxdxHNVL92q450ekHQm37LvKzrqS?=
 =?us-ascii?Q?RAuPcUAH137eCGuEbNDfu0mHAUdaA5gDKxri/ggZBVbncBpGgfQHEBA5IiSh?=
 =?us-ascii?Q?qcAtZDeMOZ4GEq+4LMLeuIeT3lmSW/wopX7ARgS9UE0rXAwkhyo11OjnFgYx?=
 =?us-ascii?Q?L2Kg+JkNTiZq+EKwTt2lYaUTnDs5+hgTyXJtjF1lnIQsr8wKjf1mbL5bVlfZ?=
 =?us-ascii?Q?slheiHt+MyDUH8EqnjDjxuyNePAWb5vu3GI1WxSIm51Ojllf4YE/EkltqqvT?=
 =?us-ascii?Q?ueQxo5ln+vULqU/ON20KUVR+FPkqY7nQf8LURLY+3WmHhwsvgFVribk3ZS3H?=
 =?us-ascii?Q?3qcXMeQQsbPEqtcJJ1B9KPidLe7/+n37JjJTfq/fdzQ72znB5NWG+WPVwKIc?=
 =?us-ascii?Q?8+ZyflQ9eM77pm8oT8b1FSBv2vLf+fjMOZMzshElnjNatz8mhohsOUKsw5fK?=
 =?us-ascii?Q?32w8P3YoGo5RNJOE+30OErp5v2VEC0QKEpBN5/sTkkeWqbGArtN47LC2KMjK?=
 =?us-ascii?Q?vun41PpQhZf2rp6IdWU0qKgPbYAOrRw8YCvQrKtsHzG7S1Bioi8WT5s0Jr2u?=
 =?us-ascii?Q?DGPO/A/yRorgvXMuRObP2N92RUBcItqxSHMHgJVMKSohApoxrdPmnDyl2tj1?=
 =?us-ascii?Q?SGiVmUdNYrEPAzKsj3U1arYVvzV8R/uhBpGY+6tCQG7VED7QHBQDgl7Qhb+4?=
 =?us-ascii?Q?IZxO+8E6vj7/AtVqU39KiiVQ2tm2n9bfSdctMB0DUcxOiK84m8ENn79vJBuo?=
 =?us-ascii?Q?uGxxRdgkc1d2h7gacIIGS3z7I2i4PohPHePVtnyHuIxG6TOCP+xNWp9udEy5?=
 =?us-ascii?Q?aKBb/zdhDkY2fCBgx1pvf80k33ffN8euGlV2z2V3SXxARPihWKrHyHocNkeK?=
 =?us-ascii?Q?VWQWji7OvuhjxxsYRBq+4OvGcFlSfBDsFtWuBB3vXeTAZW76Kh6T8KIdvA9s?=
 =?us-ascii?Q?iXle3MvmbOQ+qvnYGLjF4g6M97qNo0EWVL/NDubDm0mUyd6/IKqoeRySurEd?=
 =?us-ascii?Q?V6N5B3co2cMYL8kCy9Z9h9do9DnaAyrsP3Z481Upi9xgAwS+e1kPgTewOsBx?=
 =?us-ascii?Q?r5/eCagT/xX0Wk7BLHCnUyJFHGVLYMFLEqNcF+fwPo/u0Zbq/jF2rEkA8v1S?=
 =?us-ascii?Q?XZYxDd8DJjBkQNwFSFnIjy5ZT0neOfjIkmKcYl6Q3rxp1ypSAj7sJBSQs+4z?=
 =?us-ascii?Q?FtRk2nssmj8Rcb3s33bx7jcYmQBicYs8R71GkXCF5NUFBiR/a8BkPrBaaMsq?=
 =?us-ascii?Q?qpHO/qBMxWyWN87NsODeLnaf9K9gLZWkTPSiuhTsUWqjUqWu51UQR2ynhLhY?=
 =?us-ascii?Q?ot5RMAxCIvyZfwoSTKw1r2p47HIKAoXOP+8ZSEuMmdRxbYTWhN4UGm7JbjpE?=
 =?us-ascii?Q?YGVSCIgQlFsxA36cA+6fAylEn4ygNzAGHpTBAT5bBUuvIa6Ir0ol?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b10dfb-48d5-45ca-1c63-08def78312ac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:32:26.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmcgMEBhfaPmEC+1L0gjYZUmIXxAaQFqOD44xWTQQiQIbB/DK84RSSJOYF2RO71CgnB55teISGDiPKoumarxkoixCgiAj+g2wz6C07xtBOqTl/d1Zz0J0rWfFYZhu7at
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12040

From: Wei Fang <wei.fang@nxp.com>

When userspace calls ioctl(PTP_PEROUT_REQUEST) with period = 0 to disable
a PEROUT channel that is not enabled, the driver incorrectly enters the
disable path. Since the channel's struct netc_pp was previously zeroed,
pp->alarm_id evaluates to 0, causing priv->fs_alarm_bitmap &= ~BIT(0) to
silently revoke the alarm 0 allocation from whichever channel is actively
using it. This can cause two channels conflict over the same hardware
alarm configuration and corrupt their periodic output signals.

Therefore, guard the disable path with a check on pp->enabled and return
early if the channel is not enabled.

Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260809031908.46EBF1F00A3A%40smtp.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 1c20d7efab92..59db08e189e6 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -482,6 +482,9 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 
 		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
+		if (!pp->enabled)
+			goto unlock_spinlock;
+
 		netc_timer_disable_periodic_pulse(priv, channel);
 		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
 		memset(pp, 0, sizeof(*pp));
-- 
2.34.1

