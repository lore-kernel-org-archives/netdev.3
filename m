Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2972330D24;
	Sun, 16 Aug 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882682; cv=fail; b=cS0fpYKRZEI5YNTByp0NgAfkqHHzsbtGfafB5JvLn5aEzRdBvmuUQvusik5gKrx1GYR2QT4OJuASzkWi97nwWMDthsSuTKivaxje3NeaXUcQy6Q6MYbIdKz6fuFCK6P90KOLmXAfkhhwIfXCIoMcpcRlm+JFbLXMNO4f1emnB5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882682; c=relaxed/simple;
	bh=u93SNrTMn4CJJV96DjzPeLStUn/ITc2Ysan8oGx9KU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tw5n8j8fsOZec2yW0se7q7IWqaO2uRa2GLwpteul3DZHgS/ADxKa5zOzo/lHjX2cL5jfA6wdtI14jh/9h87FV0GxErKeYT0vD9mwHaz1EBXbO1GqrdKHC/gNx/BWS5LNga49FHrwwLFeCPBe45ZSWrB8QvFfmImHFciePlgRDz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=NRv7qFxt; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="NRv7qFxt"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022121.outbound.protection.outlook.com [52.101.48.121]) by mx-outbound13-51.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 16 Aug 2026 12:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCLlGjnyX7mp5gNuOZ3/PM38xUBLaqutGeJ4Gx3Szh2j4PhVWUz1NzGbGAadyysDag031kmwei2myTHc7Xhu3SzXUhck28C6A7Htmn5lU4fy6wJ05ixxLWMx3ON7qMWc8tdVK5/t0DHiD7znSYViiG+w0MJ6+CvPay+WDvbKlwDN294pa+5qxsP0WtLHtFle1EWUu5RSfppVimzroyFD9x+gcPYx2Q5XldCpfnWe2NbxyultYShSb0MwrpdCwgJ2YNC9zZFzYYnuEnKCETvpts4NOAVsaNv2PAsOSQIJvAuFC0UQBPtTaTzJhD41CPhBnPi2CniuMVsiz/vFh+txhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C7RHkTpueYXBPHTENGAAGc/YYe2DIvzg7BFsajkn+A=;
 b=SnJpKNgOshTprBfErGtVPaZFSP+4/1+ypJmrKi+6hy3NtSXVMLnsFMMuIccLdfKfH3PEtJIubfgKXJhr73Ys3yFFKjWB9BsX1SVNIqg4sAnS2GoLETjydJKLdbVqhbCSYnxY2owQxqq3X6ZlMyuutH1eMn43hpNHsrgd104omNHLYDdltPCQRfo3LRBtptrlTS7JRFTM5+KiSPbkYnoeKcm9CvMlYJD+U07jMP3C8qBqPpd9F4oD5hYZzLzPFeQS6Ld80GG5rtGvu6zNFsMXu6zDyA3Krch47AkKO8FI9eln74z06cCCyRYAEmWlphJtGh+ap7zzg4cLaZAGuf/0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C7RHkTpueYXBPHTENGAAGc/YYe2DIvzg7BFsajkn+A=;
 b=NRv7qFxtTyhBcNwjA7BRhQ6jqx5LEU2v+ySSovl0MEv3vmupvIUBj1vd09hK/4LY5j2QVxDVG88Ke9AFYNB00yc4rMSkXtLwSQJ48chOyolrR/aGIIFesVclqWX6RygBgZZIOFBgyzlXyeiKn2R+ohmJpJ+7Hemn+Qgx9JTA60XoIQAoCqf7lIVq0JTiOEwn7ER+drGmicohaURYgOU/j1mQd+6YV6mnT2RvB+fu2+hnIHwVXDgN2SxY0GA4FYoCZ59xmcT+BKA7paJZhWIZrKSyJSSiU1BLSEToB2fQUvmNdw8eYEs5Yf29Qc3/t0gRspezHWCRMKnUhahvjQDG0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:17:25 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:17:25 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v4 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Sun, 16 Aug 2026 06:17:04 -0600
Message-ID: <20260816121705.858013-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816121705.858013-1-peter.hunt@opengear.com>
References: <20260816121705.858013-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0064.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::14) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 53710c0e-1bbd-4a76-e90e-08defb9054c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	27xpeVTkioljG2rJnywmKVayxp/rFFduAXssUCpUIGf/iO/j8f1+NOy1eXolWULUntZ9WLX8Nk5QWr21EvrfF2csU+1qgAGq7UTsnXyPKCs559nQCSz2Lk2iNBxk5M/wO/9XeJhvdhpexHBTan37J0+aObozq1Len94LpjspAw4NEwRnslBxlCFKOvYeOgJGyXUhjoBxeEO0nFl9diTMx4IY5umV19SS9blsjXZak3JBhYHUWrlZ2Yr2eNukugs/8eIgjliHDeKG6WR83+ZWuNBE5EB/vRk0AlA3+ZK6NMFtMkb+vNyZ/ONLANfoaRP1e07ax2amPPPxGD8HMk5rhCMebjz1HK5Gl1QxXyeLTSaIJMXjpO2jDWbicQZU4esR2w8W3/CdNHlc3DP6wkvnS4vXiCXhuzL3S4UGmn9Thb1C/JzUQlLG240qGGyjr3B903hw1cQ1vNNvfXTCVsumseNgHUb/lZk2dFdlhjk1igBc0LZs6Yj5jSrmo0/sIcRZPsX+CtoiJazb+0FjHFt3N6gil7IC3Gn/cfqGSeIlCm0pXqnsMtOC+saMh9WR//zQA+lKVc2nGQIyw/GPiU9u62Xzp+66bZzXIOypFGj1+5SZsj71rarYjhip3vUyLcekAc4p4jEFWePON0YWeqF28iSCumZK+i1jQkYWfNWNC0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNwqtUqxxSIe6rzOxSFLaW9wb9vdXaCEjrcC3TPa3hljIrfzAr0ylhTHzurG?=
 =?us-ascii?Q?UKzA+yNTg3IXYbXq0HjVtX98JzDFQM9Zx7cDIjMaThTETVOf33tLPD+Ub9Bd?=
 =?us-ascii?Q?dPuRs0BBwbYvrg/5VZzhkFG8nmG73jj2bmDS4gg3E32WKvI7ximcVn/xpjLu?=
 =?us-ascii?Q?tYBzNTT8/jemYOlx41JJDxjwErNYAPeT8z/ryfqZhZ+sb5MaqpJXgg9xQK3N?=
 =?us-ascii?Q?en6Q0TLf6ddT+8+2Wp7VmlfA2TOid3zycfEOdnso3nfpvIhUIJVk+B6nrgee?=
 =?us-ascii?Q?ysKi3WVH3EjSJULZqhO8hPI+NcqReQYT4hHUEWBo75PE8dtq2ldEeWGm4Bad?=
 =?us-ascii?Q?GrmTXBbhSG9nOzEXVkvLV7j7E305AXi2y2hBXfNN79DzsulJMv8cx3RlZmL3?=
 =?us-ascii?Q?XAt+5wMRQDnXMgvAzPlkSEDjT649KbAmIiLTcCMX7eumK/7D4/9qjKh3pDfZ?=
 =?us-ascii?Q?ZhZGIeEfyXq+FLI8uB0LCW7VXu8NPSq4YYG6d/6e9cv5zOS1h/4qa1xE8N/T?=
 =?us-ascii?Q?SWntWje5nWCM3/GRln+D1F5W41/iu3DPqbTRD1x3LyUFKs34ZVt54kifmKHg?=
 =?us-ascii?Q?NZNlyMiswgTzzQXh+GhwMqC3SC5kjgu3IM0hMLwWKdDXmhB7yE6TpYuDXfZG?=
 =?us-ascii?Q?AM+jxMwmV8kI+BCwGAqy3fCTM4XzUipEkHOlaUg2IEL2Q72LGangDlZinVvo?=
 =?us-ascii?Q?XVcdqZYcBCdFniqvjfeZmddM4+xH3z6d6GLjHI7tpYqHSC640oIIjOL2aVKz?=
 =?us-ascii?Q?2RKDx6Ho5ZokzwnUJxdpAt5FJ6R/Y+dVBmTS9J6I5qDqf1br0du+NbllCYAu?=
 =?us-ascii?Q?lN7AGkbNP5txvzVK6ceIAK6x+Z4vYhFiFSQtO8yJAfQ7XAjiMPdd/Psm/AxN?=
 =?us-ascii?Q?mbkpobVPr1fPX5uN9TfCyQP2gLAN80i1LJPcfd7X4MHib70doDmKTgkP9zcx?=
 =?us-ascii?Q?ZChce+vxcEgIi90fcEvd4eZ4+O1baXUUpPNb8Uj0K4JNoKWuzaMc5RBHg5Sl?=
 =?us-ascii?Q?nve1/TxdeJZ2T8d62X7mnuQXqnsXE29HxkyE9BJJK9qtcwc3XtMtVsgNn/oZ?=
 =?us-ascii?Q?sAn42+kK3YCjbiWjdCe4OJjRVAVuIwPybCuw3ve224aW1n3PXPWHA6rdMFf2?=
 =?us-ascii?Q?W2w/iWA65ofMIGtT6w+OBuun4DCFwxHILUxl41KvCc8eVQz67X17NUk2PgmP?=
 =?us-ascii?Q?QMHbmvDDkZivb22UIOq1S70I2/r9JL+aazQEwqWTXyirKzNCATFp0AB6Dam5?=
 =?us-ascii?Q?iyl6HVNpbi+iiz1bMOT4Od5X3VFGMQ30svd0HTMe/o6s4HAafBeUWznqR4cH?=
 =?us-ascii?Q?v031oJNJerHQ5UJ4/vyRjkC2DD3m2dMry9u3cnn37h7DfQYTDrBs8LqYvTif?=
 =?us-ascii?Q?p7pUHw5xXFycxi2/k2AE4DPZpaTEHAWHIrKvxjk+RMxnLqDyG0prZDXk3dga?=
 =?us-ascii?Q?+bQ3i4yWKsDRkjZilf3csVSPXPyWZCzHNXAkEk9xPxRiOChYDPYYdnnppMIG?=
 =?us-ascii?Q?xZySzvEQohrO0ofApwf/XseQp77spzMbyxN9SO6GBa8nNQOQvG8RWXYruHSM?=
 =?us-ascii?Q?FMrPUECBqnPCbBmr4nfcrevrJUpfe7kYAf0WfEIj0d4Kq6BhWzjDTIr3pFU4?=
 =?us-ascii?Q?eg7G+xI5/6vgQnQsJu+/9fn1UT7L0JDcsukd2JQn6YeN+3uGvQ1uDVjWcQ8D?=
 =?us-ascii?Q?6JHCaLpcOuK02f2M7E0YVMNddEedqjB57vOLV5H8/P9c0DlA?=
X-Exchange-RoutingPolicyChecked:
	nJ8hs40boa2YCMBeNuPZcYQsJLhi+gCWbmAUkW6RdFO+HxB3SqjHlMojpD+i/wa5bYWSvYTTZK4zmbaj3RxDm0IR5ka0KHG6awp53siu6Ofg6vehNTaBUcFqFMuYgXEM983xlgX68VQaUpeH/Gw1SKhcOeltos66v0hU4PJuYnN6giIonEsWRUvvy2utJJQR7ofKy3N5tzLBeFGOyEwkDHfMEkk9qRUcWWsF0ceqTpbZguBqgGwiWGlv9OYYvqOB52vhqdXOXEVLiAke8xgM9rT7Ew7QQU3LYxIcaVvzP0SvsIv8faCydoWLeHvdOXXlioYhfVataauZsMOYNdDeUQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53710c0e-1bbd-4a76-e90e-08defb9054c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:17:25.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6HBEPa13g7jrCoE0VEqCnmHOTPzGQeERmHlHldtH5XqE3lEHRV/0iEiB8ETkLnK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-BESS-ID: 1786882672-103379-7715-2277-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.48.121
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamliZAVgZQ0MIgLSnRMiXR3N
	DM2DTNINHY0iw51TItzdjA0iIpzTJNqTYWABMgMgRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275424 [from 
	cloudscan9-104.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
carries the host serial control lines (DTR/RTS) to the modem; it is not
Sierra-specific. It was not enumerated for any device in pci_generic, so
the host had no way to drive those signals.

Enumerate it in the Sierra em919x channel config (shared by the EM919x
and EM929x) using the control event ring. This is the device the change
was tested against; other Qualcomm modem configs that expose IP_CTRL can
enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
it, added by the following patch in this series, is device-agnostic and
binds purely by channel name.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v4: Reword present-tense forward reference to the consumer in patch 3
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0d0d9c7ffa4b..ba47dd153837 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -728,6 +728,8 @@ static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 128, 0),
 	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),
-- 
2.43.0

