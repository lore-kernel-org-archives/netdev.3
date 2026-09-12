Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010022.outbound.protection.outlook.com [52.103.33.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5747A89B;
	Sat, 12 Sep 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231975; cv=fail; b=clWCpFWk8nTZSz/NPHnkTAnywma4fUcUVgXs8zJzQjjqVvWiRYWmElFGYgQyibPq8JwwR6DIKLwC5JsgjcAnCCOgDJd/v2AjJd2q7YH8t/vr7/33E8r78rl0iek9M/GZm8bf0J8EciYdlt/Rvo7d0uoTXSM53yf+mIQ2l0yArZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231975; c=relaxed/simple;
	bh=ja1ge2IeEyhlA48K1+GNlrCCKprMxf11TVdd05VupFg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CXNDGdLNTFVHBwbZmN1WVgNhrACh2FNXqAWzhGQm8TEVsX8metBh81/B07Splb5Z7SH7PAsTsHAMXbscLduJTVRCwE+zsoHsrxiGiRYZ3IdDC3A4jrmacfvDrC2MHWreRkH0mUQtLvtD3eS1DBeamTtnuZs1t8uTx8S95jzE8WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=rgJ+7Y75; arc=fail smtp.client-ip=52.103.33.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="rgJ+7Y75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjmGazaVsLmqa9sUKgWff8I3DB/r8VL4Rwcle0PYIIcSQ5WyTEHg307kmNUTGTMOg4qazIlnKHcjv0PSnw7UHiu+fhYpbHN5P4YezFOpp6TRbteIH47luSk6FyZcfg9/ybJGRyaxWhylf1fywtq5dVay6Znlnzo0YOqsW8m1+6xyKWzkERwdNo1gP/23vWxeVMvEqqm+7HVh8SSv/ONym4HfE1+1Ujl6mtQyHh4O17NMS2z/MYohc1AgbV5+ONKBZG/FPt+L0UMD4HpolK/8jajhgr17uM2fkJtXZVXazM68+GzhmySfcIKBQps/7Qbm01VFkWQulKfg35nZtd4ZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9dJnW1OiLd13tJJLZDJTM/1LwPj0n6omPip4h8lVeE=;
 b=Un4LlbOrhc0AeH+GqQcRIfy6wZ+4ylyiyNaHsWbvtUAJ5OdA4xzI8pvV1vZpgnoCeBy6y2bfmqrP/5eQfqCzWUDTiaOZnkc/Ruc3jIfdiilQ2kHKBD3re/kBdz4hvz9w3zUaWNpps4aDD3Y/JBgMD+b4dAoe4n/92aj6c6H5w1RLCzY9uhtS1cQxXdOO44fUCB65ug4qLwHkB8zbv92vvrJ6EU75hSpIcQrR34GCE6A1xHiHOwNS+Skur1Eerjgeth027X6uZFZm2dM7o377FrGvuk2dzv1aWtK995OLplADg4dwy07HPjhUCKyLzJyvZqsg1ga55Rm/ROYmbYw6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9dJnW1OiLd13tJJLZDJTM/1LwPj0n6omPip4h8lVeE=;
 b=rgJ+7Y75x5QRX3IEy7/ipXCx3pIeFMaZ72WS7O1ORxo4Xxb3Bf6IHitJs17nFxfx+vvDhq9YJXNUrEaMp3RCo0v3XtHThXyzHaEsOB+LTnbwXSsg1rzjpE2g9CVPf5vT7oVk9thUZDKdI6zliVsWP7Wrfak5/SnnqVKcYnP7Atwmq1PNW8uwoMbViLEwh0KVD+ctunNhHUflOqRz3wqaxKpk/rwFtkLBcK2gFtRS2FoHLrAk1GDSWyAX+Bm009M/QIZ6IUmtdoHzdtA+VeqDiJpB68MtTeC7Rj8NKDZKsac4bhTrgxFTaxQzVg0mZC+2KBPovxIl/2W38+JHL4/Xgg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS8P251MB0086.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:346::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 16:52:51 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:52:51 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	yun.zhou@windriver.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: validate CORE_CONN_CREATE response length before reading fields
Date: Sat, 12 Sep 2026 17:52:49 +0100
Message-ID:
 <AS8P251MB0001A22DC617BB5B888945DFC8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260912165249.45578-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS8P251MB0086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e37e987-a155-4f4d-ef26-08df10ee4828
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|25031999004|37011999003|8060799015|12121999013|19110799012|5062599005|55001999006|24021099003|5072599009|4140399003|25010399006|51005399006|4302099013|3412199025|440099028|26104999009|1602099012|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enCe5Ec6utrC3uqVeTodP7trFymZoEFUeXFVxUOPEqC8pLUz4ze0/bba9QLy?=
 =?us-ascii?Q?bkxax9sySAyQLop7Lsn55yXwHqU2Hk7jMiIr4WSxgw0OQlSoKl6xCMU2vnde?=
 =?us-ascii?Q?KPSbzjJ6HyD8W90kkF824f4TzSK9ChA4OpHhR9Sq/U1UHh9ad8n2m+CulJwy?=
 =?us-ascii?Q?eoFyQlVNDUADzHE3GGekHMU+1otRSfJX+1RfLcrddkTBbT9mIvUwpgGAEdJ3?=
 =?us-ascii?Q?el4ti68HAlm/6SoI8OFPM4W8wUhY7nXR7db12ZtBBgrRNHRDK2rwOXAIDVIh?=
 =?us-ascii?Q?ISp64q6L2Rb5l8rJ1bx9vmqcadx04USgf5sR7Ei4tMlN8EQFup0+HlHkIDRw?=
 =?us-ascii?Q?6pZeVTC+QKvk+AfqCPTlWxOslrLlZfnHkrHRMiO+AS0E+L3uw1iH9b0iUETy?=
 =?us-ascii?Q?2ftDuxsO5siUPqFGPz+7XLqspvdBkpeE/j5FHDi5G2wc558r95OExE1shGjd?=
 =?us-ascii?Q?hvAmtKGjqAJdysoPL9XFL8VSvoKz4wm19OcH1WfZ+30sgKuvTqkyVQnaiZSE?=
 =?us-ascii?Q?M3SMyPphSxrvj3SN4tNHkB9YPXvK1kiAjvL3Qsf0rkLoMl9B0vN3xWBoqeTs?=
 =?us-ascii?Q?R39Ni94ljsy8mPkDJbKB+FyN29A5CnfDys0FfroyvQgpLM1r7pe0olrFI/GZ?=
 =?us-ascii?Q?IZhFzBQDMMLMETOEajLN9AGaA83JKtB7GTbXZ/0/EQArLc5bdAidD/XiTgzd?=
 =?us-ascii?Q?JBdZb1qykTYqwbvOUWLFe4XjUi9OKK+xt/o/gFMXc2+LieMxNZc549aBvEhj?=
 =?us-ascii?Q?4K/9Mi49BbGaCznE9XNPb1RagxIu/kjzWd+b/eGzpEpPOplQiqYJHx4M3Y0j?=
 =?us-ascii?Q?ZM/cOKitMH4YZoYsLE7CfYrb4k0K6h6lF/kdimdMdxnvdMB6PJyZ4Y3eazKP?=
 =?us-ascii?Q?IvKhBHqiaG0UHAW+5tdwr5NKBaiFTp0NqJsBxx3WYzT0rR6IyiwC3mAvKXjZ?=
 =?us-ascii?Q?GAlgCyB84Qi2kOOc//8IFiOegMmRs3Tbl6ccrlIXGk0HWlMX6Uj1qD5seVcp?=
 =?us-ascii?Q?i27E5ruKZDskP73N4D9GTk03C0hrv7YD1wxzHJeNfYwZhCt31qp5DAhie/uB?=
 =?us-ascii?Q?UmW2+3J5dBVY4cu5Cqr4xx3EflCle+WxRWTmlN39WTXDp5bu0VhfFWbdqqth?=
 =?us-ascii?Q?xVln7LcpE0pL5JlaRNLts00JafqJD1EM4K24V2WVcN/pwmkojfyghDYnkwAZ?=
 =?us-ascii?Q?OHSs90mazcceY1ku?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1E8MNGy7nDoUisvH3Ieg4aWse319gnZOmHNdtdUrJMWthIR7T2j0LM0G2f4?=
 =?us-ascii?Q?FNXZTJK9rXiT5/5EX0KAEMdIOpQHLPup0sVk/M6gkwCU9zFP6jLPskoGkheh?=
 =?us-ascii?Q?x+dHpU5AXFgzahC/2SkLEefngGPWDxfEAcjd2QHZTRZHLQpmADhrAEn5BG9n?=
 =?us-ascii?Q?QGp1W2C81F/8evSkYWqpMOOWNrGUMnGrWvZCXc1CCkwv0zGWP1N9kPWFxO1Y?=
 =?us-ascii?Q?V3Pyd9ZhiPVpAJf6OTDvdbTMrNrwMXB+EraUtppwevC//6TWTMjD0AJscVCG?=
 =?us-ascii?Q?0s3SYV+KRQ+eNlTu3MaLu+e6CrYJ2bsYG8TpKvWQf3hnNOzzI9sLTx1mOBP/?=
 =?us-ascii?Q?41bFsVwcK29WPk7j/M8Kqu/t8hSPUhrn40MOnamqofjTemfKgyKmS9PSYZA3?=
 =?us-ascii?Q?b/GwtXh2OFOW+pExMClpEF2UEepNZIRTk71hYYhvas7S20UUUXiJ5Rm8iMxL?=
 =?us-ascii?Q?f3MGXIH1wGHuZbKi42rBGM7Eo5Fx/UoLhprH7Z7Bpy4TUnxSSWk60RTR5xgv?=
 =?us-ascii?Q?ySIvULgmGbiFrhUqp8l+mj7iY0DOfSioSFtx+aKPVwpc6S5K2IkLw/0e+rzm?=
 =?us-ascii?Q?0IQ1qSB7eDNYqZ1kjCPmKwVytExZdjt0iVic53/FjfFGr08j/crJoDIdO/BG?=
 =?us-ascii?Q?sSU9wqnhb8BXoMiYsQ0r8Y61fQUvBgX6Hplz/eBjGK9LLA1+d7Fh4X3gTANg?=
 =?us-ascii?Q?Eg4vY6w27IugxbDcH/XiWgR59//uuNI/0JX7Iw0mgN4HRrvw4gHocEIU9FcU?=
 =?us-ascii?Q?87ldNa2Pkfh8WjRQnElHRA09hlB+8f1Fks5mItcRHllkUV73MNS/lL97YI32?=
 =?us-ascii?Q?XLjL7aUUXfDl0G48boa5RHc8ekwT9L0rDaxU3egQ84jo3URtgBx2/ENy8phs?=
 =?us-ascii?Q?iy0taoX7YBCoQJlT+eGkWX0zPoHhyA/rs7t6cQ09nvoQKvFBJOw6POZg8qOS?=
 =?us-ascii?Q?iNEf8AnLRCDv/RJ6uiPG9G6UKxTB3ZV7G+wTbKmX8+RHPJi6Wiu9RmZCuyBk?=
 =?us-ascii?Q?tiLuEl9DIKEfdZyE8ej27O4IYEwAxEFct/bv/VgCVg8R+irJGtH46gGfUhs7?=
 =?us-ascii?Q?CQKiKxD7ox3YqfDHWFLRUO2FYF93ig2mgiIl+Cjd9zyEFHOB9nCanUELq+UO?=
 =?us-ascii?Q?wE/ajHCOMtzZgSN/VauXdEG0vy0k/pICvz/0zWi+n0XOJw1+85lja0Eq6yZ6?=
 =?us-ascii?Q?AJwILqXmVL8NYaZ56eQRS1PfaYCRl5DEwvpKGfx+z14zluANXPvHZCFL38ml?=
 =?us-ascii?Q?o0HR7Bb7fXcLRyrlwvHAA4L/8ia54tNYKENnx5TRR9+KAmKG+XopkLmtmJoJ?=
 =?us-ascii?Q?uiT7ua54/hhItwsNGn2DwhzeGSLHspgXdHszko345zDzHojjeuQQ/Kylls3D?=
 =?us-ascii?Q?WI0tSfutpcX0ViUiV0FVnfuU8T5ZWYudq8O1u6I3F6j4qzjz1A2Mj3NaNrc3?=
 =?us-ascii?Q?YgfLZB0+HLfCUTu/Nmw/dY1/4lfySH/n?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e37e987-a155-4f4d-ef26-08df10ee4828
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:52:51.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P251MB0086

nci_core_conn_create_rsp_packet() casts skb->data to struct
nci_core_conn_create_rsp and accesses its conn_id,
max_ctrl_pkt_payload_len, and credits_cnt fields (offsets 1-3) when
the status byte is NCI_STATUS_OK.  However, the NCI transport layer
(nci_valid_size) only guarantees that the payload contains at least
one byte.  A malformed response with plen=1 and status=0 passes this
check, and the handler then reads three bytes past the valid payload,
using uninitialised slab data to populate the connection info that is
later used for NFC data exchange.

This can be triggered from userspace via the virtual_ncidev interface
by injecting a short CORE_CONN_CREATE_RSP frame.

Add a length check for the full response structure before accessing
any field beyond the status byte.

Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
  - add the Assisted-by: LLM tag (Simon)
  - designate the target tree in the subject
  - collect Simon's Reviewed-by
No code change.
v1: https://lore.kernel.org/netdev/AS8P251MB00015EC8F8C2D4D9B536F94DC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Compile-tested only; I have no NFC hardware.

 net/nfc/nci/rsp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..72b748f0be9f 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -312,6 +312,10 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 	pr_debug("status 0x%x\n", status);
 
 	if (status == NCI_STATUS_OK) {
+		if (skb->len < sizeof(*rsp)) {
+			status = NCI_STATUS_SYNTAX_ERROR;
+			goto exit;
+		}
 		rsp = (struct nci_core_conn_create_rsp *)skb->data;
 
 		conn_info = devm_kzalloc(&ndev->nfc_dev->dev,

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0

