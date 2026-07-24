Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148E31F984;
	Fri, 24 Jul 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875664; cv=fail; b=qxin74owUePMF4anvz6GwUfxghIXxp7zZj2gp1WX9YnWINIFX6/KtTsk3oOjy427tEzSV32n8X/hmnvA88M3m6BUtonXy8/y3F8P4qRCSDukuFwfc9bq6gzvGHcAMnfAvjYsrVO992a7g3qaS8pzCwTFB8tC9jN+aYF22erThBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875664; c=relaxed/simple;
	bh=QAgtejZDbInKhDDb+HvGqNprTo13IITWgLYG2P4jsEs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nWtIQQ64AmRf0crm99ut9svvAqAiqmEmlwxWegIKxaZxLQ61MmruN+p9RMiPUjyFShz/AinvteGgZ0DmafSxBbp+WNQAZgQ9fR1b+h1AMt+jmDjbAW6g4HA+yblOsJhiLloaYccOxVDThdbI+dD6qUYw5lZ4/lT33j4raz6PBbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aF9L7Dkh; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aF9L7Dkh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEXCALZo32s/WwEjGeJZLKMJdgfAimU5MaJ0XMSmWzS9oGm1hEaJSiJrQ7PFxgH5TIVfi2AAnSQhyML/wpRxYwKyikePlsc1NHluD1TMYwrJjCfTCnslY3N8dNo0uqciXCIBb4ARVo6PcvKkQ3EFRUwFVaipwh1LqthuMnQw91gvnkbgKt6UnqLyhvNlacXmwZOE1ppul2JV2bhZgTH8GAvjIp/N4wlNKrcCCehCpOccXJhWUbk+4GEQZcf4EByfOOP3bT8RMJAUQiW6ovFFZyf6tNGUwSkkX24r1OIY9/vDiE+QEe6rqmkxbkfjvA0NEJlJZRamOiJNEGBhQud2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgd/sbhABkT8pcI2ixy1Ct53XUxzhw2ndLMurwRnc+E=;
 b=dWK3mee5JZGXzsmukl+9VSSumFiLDCpON7x8Z+srA6HkHSoHsIlh5xoKxFTatGZi1SitACqB5/zqSq09sT0ztMWM+pd+axDdsZuIxJooSj1miOlKpAiTcKURpmKcXlBgGGJVRrT12TqH9HCp3awrNc7zisDeu+Jq248U/5uaZ/L5FEiXEKvTKG0OLU+bwY8jVVRAmCGYXXh4ec6AgztGOXTVkTIVLtcmlqhYWx7soRXMQSnvVIrHNeeSCLDRHLvqUAMCJwSvTPUJTP2K9+2aS0QVZcfZNFbgXHFMW8Wp0APTBoTJzg/gPX9XcNokQB460iXhKDZajEsKJiixXr97Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgd/sbhABkT8pcI2ixy1Ct53XUxzhw2ndLMurwRnc+E=;
 b=aF9L7DkhqM4NbnH23RRWXLNbwSj5BFlmc7gx1s64YJnuD1eP5c0cMOFhFJKfcqBdR5PL3Onu+6uRqu/1yl5t97x1ga5xORZxiyrIdbbauA+vEJObyXENLiAerhFvAnBU88FACIRwkw3giZyF+h8fnoo8YtSS/SDFvbM6d+DoLxPevwjkn3jbbXbgS9l0zy/Pz83alX/5xafibrEPG8spoEgWVs72If0ZTNw5bvtSy0U3DKQBy0Mb2Co3dcxiVeauQf6VtTfXL4rO9AuX9IKbXk4FJTRazd486T/dk6hzH4jcPgx4YW8Gre75x8zC+aSUzMFrjwMf0odUMOdY6tKDgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8078.eurprd04.prod.outlook.com (2603:10a6:102:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 06:47:40 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:47:40 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com,
	vadim.fedorenko@linux.dev
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ptp: netc: fix potential interrupt storm caused by incorrect unbind order
Date: Fri, 24 Jul 2026 14:51:16 +0800
Message-Id: <20260724065116.521893-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f802a26-4648-4fab-7f7a-08dee94f7436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	wPJBDHk8og33yKsB6S35UXQsT/4sFwYeomsl2A+iIbY71DNU5MoVCksokUJXEFSd9W3XiHhI7Kj3jvcmhQ8dfLvk26VNSulk+tAybltMNnQs6e40e1XTO81fbkeXogobGsPeyHmgk12P7dQNYsSLHyjxvRXG3Vkkky3R75TOTz3QcP+5qihRYGBe3sVVhQ0bnOAtXlQU9Lsoj4375i7x6d0oRzgFFaE5MO/fNUyjFA0lbzXIJihlzoudfSiID45X13MgpsSEaGLs5ymx4iVqdaZtJ8zGXMmOCXVU+P7D81/FdPp4wWqUZIRbf9aEOoY4KpQ9L2slKFckRW94RT+m7P6wDabhl+OJKpHF2s/tIsOqouXJH7LKe29Owh7004FlI6XisflNpWcd48WxMVN+RuKCOvneO68G4VR3h0mwrKb6XbgJKTa3oIV3mgyekO7NSFj4GI8ZVs1pL/bcpGZSfY529reM2iTmuhWCfX9DSZzpz0yc/ujrrshxDB6NOIit6MGWLQrqDTBbj42l5XiJ9S1n3SR2JWZhlG/rCEE1yWbJAO/6mVdc96yim52vQTQO7U7Bs9L57cP8BG8x/R9ztCsUfp3xCdhPLH4wdlqsI7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uG7ZtVmVT40QXIZ1DF2Jf4iTrYvT25xpLgBuD4alYU0/UJisOrDpCd311erp?=
 =?us-ascii?Q?6hxdiOULeSTOe1Dqn2vsKkXtwv2M5P6upNeui40fNuWIPNqOiifEvA1xDUaT?=
 =?us-ascii?Q?z9ry5Qov7Q00XzEMzyNBLkKJQbI+u/cZpiBk8OR/9EVdXJ9MUozFhDQ+5BcS?=
 =?us-ascii?Q?XjWuOKi4+sTaawfFCcbw+gxCwybpNk2r7wKEYjSfwFPSm+hY8hxjfB4op8JC?=
 =?us-ascii?Q?Pg138SUzdU27zfPkJQj+HO9nsG9xArIVLSuELsprNYc+PXrtObJYf6f7F6Ri?=
 =?us-ascii?Q?A3uz77GShiXbekJGBzl0ooIb2rXXKjlS9MB4YdJ4U7Oi6oNTVTd96SjIJP5V?=
 =?us-ascii?Q?e86qtwSZ1XC1+McSUzORpr1Mel/aq7mY+EfFfGFcIjVZDBCI9D2KMk5/LWHL?=
 =?us-ascii?Q?gvjE4KjoChKwS3VrAlp0A8VSJmszNRv4pDotgJZ0gb0SDH/ejSafttk7vwXY?=
 =?us-ascii?Q?FpX77H0E+0dYZ1NNFBdi+9+RHXx/GW3G9Ke2pwPhldpgOQy6A+k01G+hZ5H8?=
 =?us-ascii?Q?WQ0Lp7cPNtbR89i0i4Nc/PIkrWzpf5q+ENMKSdDIxDh8w9uya8z2ioMM4Pdj?=
 =?us-ascii?Q?6yZAUPN4OUA/U2wtF5EzxKcUBfa4d5C9Z/GjaF35rI1SV9DUs3jpiVZ3AxZO?=
 =?us-ascii?Q?cPCcaW9JZPE2sA87i6eM+ZXq9kp60SFeZIC7dQyHnroWy1x8brPKjko6iMdA?=
 =?us-ascii?Q?P2gNOlYhsonHDv4+e7uQMA3VIzgBIjTxEQo723QOXYOTYPJNMCFNwujBuStY?=
 =?us-ascii?Q?+0IQdfqslRAXACRS8ZeCJ31JP+HiVq6YHSTFcJVyyWM72zBeZCwBzTPAmTWO?=
 =?us-ascii?Q?yKLQnp5tc85piPgFkVshMfVxjpz1qWpLf0R852bkPNNpvRPJJcag8YRRHuOl?=
 =?us-ascii?Q?WZKJfwHYvgnMGNUmYGYdpGx3VW4NvD+b4t3P4JlZkWiqClxrPeV51Tjk4QMT?=
 =?us-ascii?Q?vLwBdgFoCnpL918g6OnxhvIiAdGPu6+SJXnxsyTxAGPWJu2Kn6OEQIRm+gug?=
 =?us-ascii?Q?6tmaqpbumzhzQmhqjL/s1TOlSPDmVOLNGJgBuw60/sZvchw4eWxgQqKQ88Ww?=
 =?us-ascii?Q?9b+ZmfVqJgaw+iDYcrvZiaEjksoraTHceAS3DLblfP/+CXm6bShXKBaz7KJL?=
 =?us-ascii?Q?UyrRefPUjkf3vzFeYOL+7kgct+8krJ1paTDLIXObY7CziLja1K/gJexU98Hp?=
 =?us-ascii?Q?MJOlSAqKm/MJF9OiLMbvvuJyUtuC5+MQq+kwT7FTZX2HU75YPKqaqFYIRp4h?=
 =?us-ascii?Q?L2ftaBfUsHxOU0t1QYWtfl1h0Z/9fMKp30GXIKUNvGNsyCmcPS5oQfn5i3wo?=
 =?us-ascii?Q?zJuug+tkTVL2uX8WosWQKvW4YS8+XRcT3hGS4w02g3erfBk8sz0MkkV/yphh?=
 =?us-ascii?Q?arpW6jCdh43cbBIyQn37WdBofKOnkE5TsgZ1hm2RUXpDoWkz73vdpMDL5yuV?=
 =?us-ascii?Q?FRT+nMlWC5Gjkvw4cqcNriHJiSqIlNmoPB/wWOwR5K+djpv4o4wffjUG2246?=
 =?us-ascii?Q?IXoUcD0TvV7VQEf48IMvGQYie0SDMje2Bwnyzd+kr5HZGWAEe6Kbl3TYNEfn?=
 =?us-ascii?Q?pNsBeTmRmG2hhaqWffPyztdjzrir3BPvQ+GjKt3FMXlF6D1AIe22q+I3TGaz?=
 =?us-ascii?Q?rCXz4S/Q++6tCzbCsHocst43c8PuBjULBpejm4xieNhljlWAv5By/FSe+kP9?=
 =?us-ascii?Q?6ubks5kx822+fB/Ixn+qIcPkdpyECkwUoTA2mFOrYrIs4+eEkNWUgHGgLduh?=
 =?us-ascii?Q?PWkY532PJcepo8Z4hBDdijCh/m9BzfTBN3wBj7qlUgMdxKFiRPdw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f802a26-4648-4fab-7f7a-08dee94f7436
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:47:40.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxHlUMeVShRfOkRqbzBkZ34dp6ATcVSodrgfcieDo5O50Z+HvteeJUO23M/nnDZ0kutilE+ibShUCL3tbgnOptQMU6BZ4jYgfDp3fu3WsyIGgBeDQ9Sin8ZPzKKtANIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8078

From: Wei Fang <wei.fang@nxp.com>

In netc_timer_remove(), hardware interrupts are disabled by clearing
TMR_TEMASK before ptp_clock_unregister() is called. This may cause a
race condition during driver unbind that could leave hardware interrupts
active. For example, a concurrent PTP_CLK_REQ_EXTTS ioctl can re-enable
TMR_TEMASK after it has been cleared, leaving a pending hardware
interrupt when the driver unbinds.

Since the NETC Timer does not support PCIe FLR, hardware state is not
reset during probe. When the driver is rebound and the IRQ is registered,
the pending interrupt fires immediately. At that point priv->tmr_emask
is still zero, so netc_timer_isr() does not clear the interrupt status
and unconditionally returns IRQ_HANDLED, resulting in an uninterruptible
infinite interrupt storm.

Therefore, move ptp_clock_unregister() before the register writes that
clear NETC_TMR_TEMASK and NETC_TMR_CTRL. This guarantees that no
in-flight or concurrent ioctl can re-enable hardware interrupts, so no
pending interrupt is left when the driver unbinds.

Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720012508.23227-1-wei.fang%40oss.nxp.com
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 5e381c354d74..3bab86afe8e2 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -1019,9 +1019,9 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
 	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
-	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
-- 
2.34.1

