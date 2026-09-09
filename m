Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A7526A9E;
	Wed,  9 Sep 2026 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950211; cv=fail; b=kXvGZXT2kO7zjhlwSdV868Iv2U3V09rex1c4iy3KogrbpnrK78WW9ADgrnIiLABEJ0/yf08fMN8OOKUcqtlyBcEcoiDnSazAVCrJ91E38cE5zhwxRdIdq27yk5nZpiO7k+cdSQsCxnlo2fteFR9n8bIYPf5aJr2+/toxa8a4/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950211; c=relaxed/simple;
	bh=vIhgqkfpQtGD1Jidg3yMpE16QSBbJM8MM3Oq8WjNeS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PD39NNlU/zDYO1AwHS87qr8vhfZCXuKsHN7DgfJE4Z0oDcXqoTfbuCWbDzH8nfPJCDgUZ9Y9AS7BGE6wniisYRvGJY3d8pJ8e0r8LYKVEmvjcQt5sMa2pfLdpSbjFJvIqwOZh7CwgsuvKpDRT9zw5ztVO+yphDXNIZi4mwo46Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E+Ygy2tO; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E+Ygy2tO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imgNl3wc0qIFOGW4+nJ/iuFNVKS1lRmpoBqVw05eEsGgIpdHHQMAf2RSd7D0ad+BBylNmI8Tnm/ocNx11qTyJvmrgOfbVbKI9f81sm+wKdzYuT43beUCdrFkfjxL2jWCO3HnBUh5RVxpBCU3pH5egnMke2TYarNdBZI7vS+odIbGPCQ4wQi0Z6q3vXJ4AJzmbC4Dr6HJUWoDwoXimYzvaxZKtsbeCbUhjjl6b7JMWIpvC2xqbRRRgsuje04PCWPyl33iYzu3fxM9xAD57Kjzap3ufmfa5LrwfeoTw15F6IuXlhznlOFVajH+2g00yvcVk+pP0RzQ62GnAVlqqwzhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p91FYoVzGmh+n/TsmSLSwxkPwzjpTBTMPVmMZBvg1Qo=;
 b=eO+tK7tXCxd3VymWl/gXuMRAEo+7tMgf6lCJvbWDGv+2Zt43+GM8nvKqGwhTw2cBitL7vqZiqv1W7vsD2s6GXY68hTurXWtays8Kp04/3/L4U5AeqdaCAowDeK4gvAXj0GsWWjVZOjpkaE0BfReAYTVJVQ1XVqBDNgu09b29jaXGaTDnekOKizkaxOHrei4Ow3Qplqs5QwXzwaps4Ej1ydB9A8XWzwqGIce8nEGqucVtWrg011GkEA0+TippqKVZPEq9RfiKy0IEKB6i8TEBOCGFmL+z29WpbHlvGwHA1O2iX5QZXLIbQ4HH/vsOdXqgO9S4b5sYjC4eMCfnh5dlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p91FYoVzGmh+n/TsmSLSwxkPwzjpTBTMPVmMZBvg1Qo=;
 b=E+Ygy2tO7gVra2J+F7wrq6fftPT+bNU8m92cqC/jcsnEkDULNaGvPxGzNkezbKP6dTzjcCQfDxxIDsXhgWOrHGCH3kZ/1tEarwaS2qMZ21HC8xtp3IpEsyoB6l9MmCAH4w+ndpi+6h0n/s7Fnh614sSyrNnRAZVmwTY8RbB9clB2RcN/HhDZS3f1C17N7qU+Qasd4vdFM9qB/lHrwrsEbUppY76GlATFaZYjxz7fN9h0bhEDwLcLB6zLdiILAyK1Z4+MP4d8NJq6nXidbZK1v9RSyqvwiYI31PbeNeP88XVMP3SuvyD/QUFJk0m0N5JT9Cl+LtFgP/5QBsye53J9nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB617387.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 10:36:46 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:46 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
Date: Wed,  9 Sep 2026 18:07:29 +0800
Message-Id: <20260909100733.1139689-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB617387:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f94408f-e130-4b3a-6ab1-08df0e5e3f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|10067099003|6133799003|22082099003|5023799004|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	kcXv2wkSMSIlCMkBhYbhedkJQGMIV6+mpGsGCNHCOr7OKriLBnAeL3guEMFOJddemdgQM+/F7UJ1dFMmr+h8MSt/Jqn5JHUjCNPijlSwecOUrmYC+Q4/e8tjPjfPYODqIdcYPsI30bwEFSu9WrPDO7G67r+vmtSrjjnfI5rNfPqYbUlgg2hEXIMcRkXSz3RDJPSPJO9kniVNBs60Q7eUBiSe/D2mDYxA8uhotqKtD1ywHXmpPhTpiEBGp4gmzRXiEheu94HOvCYoPmRNza7Th6+aM5DmyiZ6WzX2KTbTi/T6pYZwyAktdpw4zp6WGZd/l+yQxrkJimgsmm6X8xDEdD667fiGjeSGotBVr9DsteaVPbYdqpnBMumSfkipegk/HTfmVlkabrDDgpzlL+Pwe61vxGdqCzLdWYUhkf2iBvSr4YsIl8S++jUkjj1qNbSjeBOk2c5S6j/418o78d9HuP1GwMXu+/AY2hSrWI+NlvH8UbJh6kA1L3sYVfDYovjCLIrXVc8OuRrEgcbEqeFsCkxkY3No13HM3Zzeh3j2dsyKoHdOjbBxxxOAVyAI3befsrtMkIH1gB+g6hxLiQGACEKLs1yUALSKG1xTddQY25iH1SiFa6EdPDA93F9vUSx/5aImRRlr0NVNkqHWJkkok9B1hFE5slt979iKogl8GKCFfFBl1sMM/sRzz32lZ8C64Nh52PnKC5ZlS+AJW7C8/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(5023799004)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdPbIhq5CfB72exdt1XmmzpfZZAd0PmnBl/60lN7jnfiWISeHJ+v8Mdm2BE3?=
 =?us-ascii?Q?FTojgmnp+7BLolF75MrDMWu30hUFs5VnpirEVEWqqwzQYdnzH8ZJqW6Uxbg2?=
 =?us-ascii?Q?KVYv6ZaqwO3jfydjdO0lU8ly7y5ab7wq/Nm+YI5EyqBi4iulNOn6lqElsQdi?=
 =?us-ascii?Q?Zs9LxU8oyGSwzy+Vy1QDXlbkJ102oQa1QvwNB1KMAeOwv6Pm9n5KK5y/DLmo?=
 =?us-ascii?Q?WMrFZBEOy9cBMiPo/YqdwiBPDyAoDNIHsCBzLy0kCpt7yBA3TMzKbgknXAXl?=
 =?us-ascii?Q?ff+vOpkR3TI/bGrxxPbeEbr+7sIR2xes0gTWAKIoQFN9RF9KxhPc2rSH5UeI?=
 =?us-ascii?Q?AbHFFs+xPT92TGOv4/OA0ZZ3pLF66yXNdMryKznLvCz6+xYfKwbjhB8OfDL3?=
 =?us-ascii?Q?gfrOnfJNczIuPcI0HyywY12q8mvOwD+v4IS6JnJlfsbLZaKcaaO7v0Ioqy3l?=
 =?us-ascii?Q?yo7EyYGzpCZhY0SJORN8i1fxn3pFDMVicAFPaXYYmFWy27vysWxbxqzKvLI1?=
 =?us-ascii?Q?qFGj0Oi52mhwzGbvfWiIPd7u6ztyUy3NnKKwyZwaazgpOO1dEPjM+yhh+GgI?=
 =?us-ascii?Q?8QyxjbSw+Ilesa2A072a4xlJr53q1peXtsTVIYa9IL1pkJVqTi6UYH6hS0gx?=
 =?us-ascii?Q?GpftTAVziTPd/5tX2fW2jDXz/zyf5rnnZdnxen/C5Ba4ErluA1/wT/kzECRb?=
 =?us-ascii?Q?VKFSsnwJE6PmW+Z+1jRLbIcAgsb8AKFbwnDn8jQa/Upa9loSxtI+zaX4Xjko?=
 =?us-ascii?Q?8cyBdwQoStgH5s0tnXMzL4twEG/P9bI7bpfrz1NStdZ6nkzKJYM67yIoPLbr?=
 =?us-ascii?Q?+StuPiYVy+KCZUtovNaOocwzMdtIcIWFXC93Z/B/t0zhW/W86gwhevYUSZVY?=
 =?us-ascii?Q?JpRrWKVRvP8/ob95o/Zx5//ZYsawBLTWprCJK1ymueqr0mNWoZ2uB70LlyHB?=
 =?us-ascii?Q?M9jVzCiGyU5exA2S3bdpzISwy2o3VvrUT2Avg2EnUt/kv9qNzdebk8BCDc8u?=
 =?us-ascii?Q?OL63YgeFZNdSrqnMr0Ej+rzog7ZRackeyrrR5BNBVC2t4RCrAv7kHJOl9L7K?=
 =?us-ascii?Q?f+L0WhJ9PJ6COrLttRubbAzy0koQ/cGxHkFmk+HJ6VWUHkthafW+G+7N6t4A?=
 =?us-ascii?Q?OxoEMMVZK++pPu0jRp8kUrheG0mD8AiG6+TcifgYfZJanBeVwQFSD11nxGuZ?=
 =?us-ascii?Q?Afnfm/kf6y4tN7wHlgaxmDhWRMVS2B8PhceHuctbzqGbdnWQYeTbKx6zIeOc?=
 =?us-ascii?Q?cFqpqHrtuywN29pR7D3vTxWEdr8LzvDDlHYZa+yAvBQXakeJRupXbybeFEZY?=
 =?us-ascii?Q?wk7p/nFN0LqzySMxTN5ZR/743HISpV93SuKWYOL5txjE8/GIJUw6Tr+P7dSe?=
 =?us-ascii?Q?YlM7TWtzJIRtO8XCgRGL/Ult0eaDPRw9Amio3lYQwiQiRUoJv6REAt0r9dAk?=
 =?us-ascii?Q?aH6Z/6aiXe8A7vBJ5v7kOtcZ46M9/V8qJk2KPx6IPtCTFKYF9/PIz2Ztxaw3?=
 =?us-ascii?Q?JQ1ds+f8RyIGX02TJ+ZlUj0UtOsCW0yjEV5dgAAWgxOPAoHP+KUc5Q0Y98O+?=
 =?us-ascii?Q?bagH3P5bGqs+iZ8GUPtVQPDIx+gEc2RSGd3xO1YKkJbbyXuOobAEfvfVXG0I?=
 =?us-ascii?Q?Zi1rPeF/DwaFLQJc+86ApxrSwWNVni1O/tQR8BKkMwgBCOKzyYuNwtRzLoI8?=
 =?us-ascii?Q?vUF8Y/BsJ2USyzhIkD5kuWMTAAKTW4elNKiaC/LxoRiDsD6S/P/Iy1+X6doj?=
 =?us-ascii?Q?P2h1JzJYlfhNmgac7prqnfDabqYsa7EZ0cGFwXoHCVCgSnfXmfpX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f94408f-e130-4b3a-6ab1-08df0e5e3f62
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:46.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLgsj6yBU45p7+3p606V4fjVuTNV4dmhF3fIZet0LFtG4SWmDiXbA1/a7NeUnTcmMKPgsexzwfGHwJkNJvtsuW4yX+I0fWmgzGJRc9VgI5h0LBJLnK2OjUXxKtxh+Vw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB617387

From: Wei Fang <wei.fang@nxp.com>

On ENETC v4, when VF performs a PCI FLR, it resets PSIPMMR[SIn_MAC_UP]
and PSIPMMR[SIn_MAC_MP] bits, which control the unicast and multicast
promiscuous mode for the corresponding SI. The reset (default) value of
these bits enables promiscuous mode, meaning that after a VF FLR, the
SI is left in promiscuous mode regardless of the configuration set by
the PF driver prior to the reset.

This is a potential security vulnerability: a malicious VM could
deliberately trigger a VF FLR to force promiscuous mode on its SI,
allowing it to capture network traffic not destined for that VF.

To mitigate this, make the following changes:

- Add ENETC_VF_FLAG_UC_PROMISC and ENETC_VF_FLAG_MC_PROMISC to
  enetc_vf_flags to track the PF-managed promiscuous mode state for each
  VF.

- Update enetc_msg_set_vf_mac_promisc_mode() to keep these flags in sync
  whenever a VF requests a promiscuous mode change via messaging.

- Update enetc_pf_set_vf_trust() to clear both promisc flags when a VF
  is untrusted, so that a subsequent FLR cannot restore promiscuous mode
  that the PF has already revoked.

- Add a vf_flr_handler callback to enetc_pf_ops. The ENETC v4
  implementation re-applies the tracked UC/MC promiscuous mode settings
  to the hardware after each FLR, ensuring the hardware state matches
  the PF-managed policy rather than the insecure reset default.

- Add enetc_vf_flr_handler() in enetc_msg.c to detect FLR events via the
  PSIIDR register and dispatch to the vf_flr_handler callback. Invoke it
  at the start of enetc_msg_task() before processing VF messages.

- Enable FLR interrupts in PSIIER only when a vf_flr_handler callback is
  registered, keeping ENETC v1 behavior unchanged.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 20 ++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 12 +++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 50 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ++
 .../freescale/enetc/enetc_pf_common.c         |  4 +-
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index abe1e8dafe24..6a9b1e079ae2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -212,9 +212,29 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
 		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
+static void enetc4_pf_vf_flr_handler(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_vf_state *vf_state;
+	bool uc_promisc, mc_promisc;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_lock(&vf_state->lock);
+
+	uc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_UC_PROMISC);
+	mc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_MC_PROMISC);
+
+	spin_lock(&pf->si->gen_lock);
+	enetc_set_si_uc_promisc(pf->si, vf_id + 1, uc_promisc);
+	enetc_set_si_mc_promisc(pf->si, vf_id + 1, mc_promisc);
+	spin_unlock(&pf->si->gen_lock);
+
+	mutex_unlock(&vf_state->lock);
+}
+
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+	.vf_flr_handler = enetc4_pf_vf_flr_handler,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index f97602714118..c18ad8b9b071 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -110,6 +110,18 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
+
+/* VF FLR interrupt mask, n is the active number of VFs.
+ * It is available for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_MASK(n)	\
+	({ typeof(n) _n = (n); (_n) ? GENMASK(16 + (_n), 17) : 0; })
+
+/* VF FLR interrupt bit, n is VF index. It is available
+ * for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_BIT(n)	BIT(17 + (n))
+
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
 #define ENETC_SIMSIVR	0xa30
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index aa37a0123274..ff99937815c0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -27,6 +27,9 @@ static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
 
+	if (pf->ops->vf_flr_handler)
+		psiier |= ENETC_VFFLR_MASK(pf->num_vfs);
+
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
@@ -208,6 +211,20 @@ static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
 		goto vf_state_unlock;
 	}
 
+	if (type & ENETC_MAC_FILTER_TYPE_UC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_UC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_UC_PROMISC;
+	}
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_MC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_MC_PROMISC;
+	}
+
 	spin_lock(&si->gen_lock);
 	if (type & ENETC_MAC_FILTER_TYPE_UC)
 		enetc_set_si_uc_promisc(si, si_id, promisc);
@@ -542,6 +559,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	kfree(msg);
 }
 
+static void enetc_vf_flr_handler(struct enetc_pf *pf)
+{
+	u32 flr_mask = ENETC_VFFLR_MASK(pf->num_vfs);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 flr_status;
+
+	if (!pf->ops->vf_flr_handler)
+		return;
+
+	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
+	if (!flr_status)
+		return;
+
+	for (int i = 0; i < pf->num_vfs; i++) {
+		if (!(ENETC_VFFLR_BIT(i) & flr_status))
+			continue;
+
+		/* Clear FLR interrupt status, W1C */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
+		pf->ops->vf_flr_handler(pf, i);
+	}
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
@@ -550,6 +590,8 @@ static void enetc_msg_task(struct work_struct *work)
 	u32 mr_status, mr_mask;
 	int i;
 
+	enetc_vf_flr_handler(pf);
+
 	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
@@ -676,6 +718,14 @@ static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
 
 	mutex_lock(&vf_state->lock);
 
+	/* VF may set these flags by mailbox messages, so need to clear these
+	 * flags when enetc_msg_psi_free() is called. PF-set flags (TRUSTED,
+	 * PF_SET_MAC) are not cleared, because these flags are unrelated to
+	 * whether SR-IOV is enabled or disabled.
+	 */
+	vf_state->flags &= ~(ENETC_VF_FLAG_UC_PROMISC |
+			     ENETC_VF_FLAG_MC_PROMISC);
+
 	spin_lock(&si->gen_lock);
 	vf_state->msg_fail_cnt = 0;
 	enetc_set_si_uc_promisc(si, si_id, false);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c5eda6c8eaf0..1a9fa3714c3c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -11,6 +11,8 @@
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
+	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
+	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
 };
 
 struct enetc_vf_state {
@@ -34,6 +36,7 @@ struct enetc_pf_ops {
 	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
 	void (*destroy_pcs)(struct phylink_pcs *pcs);
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+	void (*vf_flr_handler)(struct enetc_pf *pf, int vf_id);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 9dbb0a1417ea..86958f1e9cd3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -623,7 +623,9 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	} else {
 		u64 hash;
 
-		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+		vf_state->flags &= ~(ENETC_VF_FLAG_TRUSTED |
+				     ENETC_VF_FLAG_UC_PROMISC |
+				     ENETC_VF_FLAG_MC_PROMISC);
 
 		/* For ENETC v1, we only support setting the VF's MAC address
 		 * via VSI-to-PSI messages. Unicast and multicast promiscuous
-- 
2.34.1

