Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA543D3324;
	Wed, 19 Aug 2026 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179828; cv=fail; b=Grp1B81AI1FGI3t0lommnTvrB6pkuoQMIF2i5K1Bz3pmDSzGA+6Sn/0US9SARyNbL5oqNlRZerADI6fGnKoDjnHmiMEyTByeWAqZ9JkQ6U9tV/G8ZElCfddhiX0Y3boZ1zs4vyGGCCQnS4JamX0Rp2Rg+JMWhf/Ulh19B4fDsV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179828; c=relaxed/simple;
	bh=FfTCyAEzwwXOoLDEhvVasb1qd0w1bZo4D4m3RWNWxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2rMIbQVtNnr+/3CbHQ8dLPIy1koEn6lMDex0LHCe29cvZiXcjRvxJ4Zr39rOp+UelAAeS/4LaeDgmjoNWaXnolFq7TMHy+XixNXDV+j1Eer5KP15PC/tdVfifRxnJmgwXw2mPYWq8kUwybo6AtG7uoX9LOt8Pn0tWDk/hblAO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=AG4AjHhU; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="AG4AjHhU"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91]) by mx-outbound45-182.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Aug 2026 22:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqOaLUYLOVHBzXjny+gy58s2EbCve2gEUSWMH9Rx1TSTiassc/r//roAQ1pMMS/1UTrEngIjCk5GVvAL45O0suJWK+9Wq0PZTS3jsC6l+hIxB50/IV4WsD/1ec0l6a6A+6XoiYfzMTdFUlEvPf5rUa0CrtnTkaZvlNHDWOhuAMtI/MLOtMl64wgEDqk27gJHsKWeHvEeip6erVhl56+4m2oen4GZ9/hjGptblIiZ4gB1v2lBOkD+SH84E6G16po7GKJGfysIm4epglIMVdnOWqzEAtNbolm7mGY7MAqOamI2JECRMINFtt/zMd2SL518rtxOkWQ00RRk37T3sqohug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyAL5r8ilIIKNAxAtMpvbrlTp0y3xpTFjRj0yGLFnmA=;
 b=VqTJSX6n4AlcRgiCGzZRZwWMC+1IGpxKrS4gQr5XnHd5NJL7B5gQ2Iy2th7TqXRBYOJOx4VIFDmZV9v/jJuJZdai7wDV4mcY/N2oXu0BU7sWA2f6sDTFrXRpylzh34G4uAjoGmoEFw/3y/ZF0SQmSEzlIpWItvg+XvuwC7fE9XEw0GndCd3SXseFrLhKlKcNl7cnOJ8aWt/+aYv6IrLaAXWGOewYmldzWn309lSkABTok3xFUqIXiUPrwuTz2riUq1p/vY3Bso3ybBZqkpESLdD8dnQEnBU0yd//+5BCu0LZfcYlak2EZ7PMSJqc/y+AeRiWwwTtb5/X8oeL2vPVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAL5r8ilIIKNAxAtMpvbrlTp0y3xpTFjRj0yGLFnmA=;
 b=AG4AjHhUGk5E8brB9lW3vY9ESFiQjm+Kq5ig2sWbJc6TH6C6TyVUb9HIhSpJ9FaqIPU2Q3/UCkXBVxtQuKv0aqXEBNBNjaiF+5YIv7J/1l9v4xWKiwBc8IqO7kusqlnM/STrWsQa7D4ipi2B/Cjcgn+pB1ygs8L3km9JXh7O8NDT0gLWWcPd1MGvhqV9Agr1Yt8gJJ06+66mh6N0ei6V5E/zsiBKZrpTXmbhwZw/zUKNC2OYOJyIdq4N2ilU4W3T1empE9MUEPW8qiEqeB8/BhReY682rR4FfMlYuJBhR82ltdVVjXbsaFqIgkLfciyi13daDSeCz6M+ouDqeI8Y6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:49:40 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 22:49:40 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	mani@kernel.org,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v5 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Thu, 20 Aug 2026 08:49:25 +1000
Message-ID: <20260819224927.2274790-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819224927.2274790-1-peter.hunt@opengear.com>
References: <20260819224927.2274790-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0021.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::8) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0301eea0-f5c5-4026-428d-08defe442754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SlAiBOyGnick5Nik3lk8StjYpqY2uiMvp9S6QDQXMccTuo9KeQ1ECTos5flGYtas8lytACNkoNLTyu92ijfY8ZA5tEknN7tIi2E9z4Cf7AZxNhd1ETJjdpwj02CcylHqlqIPtVt3LmDUk7bubW6ZYevGDYXhyoloIJ5loCNSyIEaaLPWWyJQivaNIn1UV+5QDzZeDivbkfEK0ryphpnqGBdEIR1sqD8Q3Fnk3dFEdNfsXuNWhTvwnmRcwx8hWKcTFNmKVp0ECUhtJdsDSkUi5a92wvpz/Xawe88U9iu3HPe6PBNnzCC9iXHNaXavUV7T3GPMmCFNt9zTDdJ+aS/KAiyMWF4yBYeiSDUZlEnrMGhrrAjYtpvLFPhwyTjsohg+sZxUts8gw/zOCK/fVHp67pQPLKA+rR2Nyw3a9LaREv9VkCW7l0l7PT+CHN8tDiwEjPCLmWDpoX1jJxSFKwKyrqiU8vvO/l3uQu+0z2PFs0yu1bBxZ93yzGXawlJ3n2z8yKcjDxANa29vL2yKLyooTruaDviTomop6dXNsf2sJa3spXWrUfw8cfPizjx+r8qDCCTQF22cb8WyvKbODvPDh1Gc7KKv7ORVeKu/nEn3APmH5h2OHnGibEsB9WaDWiFqjl7VNBOZ0G3xgHcaKQmupvnAd0LK9jC0h0PcPB7na2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UuoUdP/+4WSHU34Btf1KkZJb/pT8FTCiO3jwkHw6CltXHNwGzRKsKKLK1ecq?=
 =?us-ascii?Q?ON8XEZwjbQ8Lb31Q7EYXpnY9YD26sG+v/9yNaFAhdzDKWV7XWlERq+atHUR2?=
 =?us-ascii?Q?0I3GvAAaXNV6vjxNsrMhZ/CIKtp4pzlJK3XxiHdsL+jp4rIY7ofdDOz1fVvK?=
 =?us-ascii?Q?aSd5jWcYS2h0uozMsVzwp+G9WHTV8rLSutISgKiQ775IXprq7nX7newFEu1a?=
 =?us-ascii?Q?TCsDEvzO4uTR7svj3YmXrZRefRJN0YppKS7Cf7IcKkILZ24eonDF5Z+nPksR?=
 =?us-ascii?Q?DF5cX+EyDD7pnI5rAfNrUfr4h2lhI5DEKvqvQPdOGS0I+EdvbHpQq1VQxrCh?=
 =?us-ascii?Q?ra6eQoVNAfBMbn799hq4nTkT/l3cLQcLZXCwjOW0/Jf5apSkXauzsSfwkED5?=
 =?us-ascii?Q?EMv7I0D0yYvHb5S1zcgMmRzrkdFdkIppLY6p9Oa92Zzr+nrxPduN4O086Cv4?=
 =?us-ascii?Q?vBiTzYUIRcwJv26Qyubozad4KpfgM+WaQau7oYCOppBGki69Jr2mPrKDk5Ie?=
 =?us-ascii?Q?Ashjw4MdRi0ya9ajTgO9l/MKtM7RYkNLYANp7RwCoWTlPMIsb8bjyNEPwTzk?=
 =?us-ascii?Q?dbiAOpgoGBAoYkpuVerfK7DsfMTACEGSqfNDRr+bC5exfnu8g/UXC0Lp4aR9?=
 =?us-ascii?Q?3+03DQPRmVO6ViclY/Ku9u/fA7uBqQ0t0c0cx2GL0u5l1VVj/OSWn7raiefK?=
 =?us-ascii?Q?En6t5em+XnRae1e8wY0FGco0ilORtYJ/MOFkHHEDUVvCXKWeRY8Hi3J7SBJl?=
 =?us-ascii?Q?/kGEms5PrlkYVxQWrY5fqQqUQpYOUj3HukV8K8AW1lGfBXqoVTH15syAIOqJ?=
 =?us-ascii?Q?jsxd/lNBWsrn7bQvn0OIBCRP1aFu0SSqFWyyUZH1q739BXgjtECCLA1AYS/U?=
 =?us-ascii?Q?OT9powZoMHhhndoUTZcxG9rvREiboJBxVJz9Kb0Sz28GziWcFBAdDubLz9d6?=
 =?us-ascii?Q?SjflYNN/pO7AVbG6fnDK0rbCP5HnzokC998jHd0fkvcuJ+WzwWi10QFGHA6Q?=
 =?us-ascii?Q?ZBUUmLVChEouClYCNI99pyFUqHxVvg2/bc5lxKwOu59hMgoPUjVPGC+Y5aHh?=
 =?us-ascii?Q?GshDsC/aGsUNd00pLosN1y4fG4EXynLldpkeEGgzu0Nvb8MUBa+ejzQSYCbR?=
 =?us-ascii?Q?IZuv2I5rjm7LOvh6a7eobtIeHpBl57UCE+lDuxaVMSSmE5Z6H4qyvxuw6WDb?=
 =?us-ascii?Q?XU1g24FK/mZWcmiTyrUvB/Urnj3P9fAYsLlO3Qh+mQ7hmM0BS5Zd9At0aha+?=
 =?us-ascii?Q?uNwXiebk87MSaFNLzr5Q19hhGn/PetAMRXVKsPPTrWMYlNLSa1/529o++2A1?=
 =?us-ascii?Q?oNfry7w/GZ0hgUFVrx0vbLFl6Stc7hLQMfIGpJ4621TSg2GLAJDmC1Q87co+?=
 =?us-ascii?Q?BOfyTc2SY9KRTQ+kSNRuoz8nCiQNX0It1XNOICkfLzImv51CXBUMLDb2n3DU?=
 =?us-ascii?Q?WZu01yCCg9k5Pt2ZMH8aD0KClRcAuPDmKXjzfES3/n/+cV3hfgjmShfQ70+x?=
 =?us-ascii?Q?IdKyYB0Qr1IEmmcRfQHNQcNOoWfbbjUkYnr5v9mW9YHUVRs8KFs5d7QFH3A0?=
 =?us-ascii?Q?ceMsNkbLz2F4vJ9vw/YomcRtlBYZMtc/Cx9FvbsIfPP1Gc7DO6ddAIFLCsBH?=
 =?us-ascii?Q?h35wdsQCZnGyCjn1caUF5/p9zQDxLPhvT4sFi6jVobJrs0YhQupBjz8Q0u9v?=
 =?us-ascii?Q?0TUP+KwbkzfTTqqG+JHaMH8d+XgUff9WDingL4fBXtyOGb1g?=
X-Exchange-RoutingPolicyChecked:
	Uuz4T1usDdBf48eiR0PQRqH80+fB0v6UIEwt1J7NWHhgUzWyCmLJoW2nIyju8Gbyic3pWyXK1LaVL4x7O7wdJNKFz9QxvGG/vedwH0lKvlDmZv1GXlNAQftRgwESMbrumss+uj03N0E6uJRERqPdSgbxfhbHLYxvlbDtxiQ/SdtB4xymi3fvrBsEAriItSWhs8bhqVpJQjzevY6M4GgwOz/fIjZDuyRsbJvStV6STE8R0b/lRfTT8yMTSYHwITQS2hdcnEMOXv1Qz0z5IXuDA1EL/7Qs44ofTu4gUSt1MQlwQDlD+uYUv7BF//hEZQOQrhkA+JbKP8aK+zs514lRuQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0301eea0-f5c5-4026-428d-08defe442754
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 22:49:40.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWxMkhXac6yulHDdgCBI+0ZrMK35uUQPo1e7Fe6w2/q5kOg/VsLYMuFg3l6JsF1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-BESS-ID: 1787179775-111702-12581-7781-2
X-BESS-VER: 2019.1_20260817.1854
X-BESS-Apparent-Source-IP: 40.93.196.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGRkZAVgZQ0NzSMNnQ3CItNT
	XJxMLIINXSwsAi1dTAzNLEIC012dhSqTYWANzfR6FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275505 [from 
	cloudscan23-167.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
result is only stored in port->at_data.mdmbits and never reaches the port
driver. A driver therefore cannot act on the host raising or dropping
DTR/RTS, even though some modems depend on it (e.g. they withhold
unsolicited AT result codes until the host asserts DTR).

Add an optional ->dtr_rts(port, mdmbits) operation to struct wwan_port_ops.
Drivers that implement it receive the full TIOCM bitmask so they can assert
or de-assert DTR and RTS independently. The wwan core tracks the full TIOCM
bitmask in port->at_data.mdmbits and calls ->dtr_rts when it changes, gated
on WWAN_PORT_AT to match the open/close raise/drop behaviour.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close. This mirrors TTY semantics (DTR is asserted on open) and means
individual drivers do not need to implement this themselves.

at_data.mdmbits is protected by data_lock. In the ioctl path the ->dtr_rts
call is deferred until ops_lock is held, where mdmbits is re-read under
data_lock, so the value passed to the driver always reflects the committed
bitmask under ops_lock and is serialised against concurrent ioctls and
against port removal (which nulls port->ops under ops_lock).

wwan_remove_port() is also updated to call ->dtr_rts(port, 0) before
->stop() when a port is removed while still open, mirroring the last-close
de-assert path.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v5: Change ->dtr_rts signature from bool to unsigned int mdmbits so DTR
    and RTS can be driven independently; re-read mdmbits inside ops_lock
    in the ioctl path to close a concurrent-ioctl ordering race; add
    de-assert call to wwan_remove_port() for the hot-unplug case; update
    kernel-doc to note the op is AT-only and describe the mdmbits argument
v4: Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock;
    release data_lock and acquire ops_lock with a NULL check before calling
    ->dtr_rts from the ioctl path; gate ioctl ->dtr_rts on WWAN_PORT_AT to
    match open/close behaviour; reduce boolean to TIOCM_DTR only
v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
    on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
    wwan_port_op_start/stop rather than in the driver (Loic Poulain)
---
 drivers/net/wwan/wwan_core.c | 40 +++++++++++++++++++++++++++++++++++-
 include/linux/wwan.h         |  3 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..3a6a0c5a3acf 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -685,6 +685,12 @@ void wwan_remove_port(struct wwan_port *port)
 
 	mutex_lock(&port->ops_lock);
 	if (port->start_count) {
+		if (port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, 0);
+		}
 		port->ops->stop(port);
 		port->start_count = 0;
 	}
@@ -759,8 +765,17 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
+		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
+		    port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, port->at_data.mdmbits);
+		}
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,6 +788,13 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
+		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
+		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, port->at_data.mdmbits);
+		}
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
@@ -980,6 +1002,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
 	int ret = 0;
+	bool call_dtr_rts = false;
 
 	mutex_lock(&port->data_lock);
 
@@ -1036,6 +1059,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->type == WWAN_PORT_AT)
+			call_dtr_rts = true;
 		break;
 	}
 
@@ -1061,6 +1086,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	mutex_unlock(&port->data_lock);
 
+	if (call_dtr_rts) {
+		unsigned int bits;
+
+		mutex_lock(&port->ops_lock);
+		if (port->ops && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
+		mutex_unlock(&port->ops_lock);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..57406139304e 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that updates the modem control lines to match
+ *           @mdmbits (a TIOCM_* bitmask). Only called for WWAN_PORT_AT ports.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

