Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020125.outbound.protection.outlook.com [52.101.196.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5E314A65;
	Thu,  3 Sep 2026 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401686; cv=fail; b=brEERN2RgJjreTIqbUsrx32kgRbhUgZEsu3QvZ7/bI8n+qfde/hDpDBS7Bt5qao3YVGp1BT9tX6uThZWghQfqqVbNLyDyHfUvGqrQvu7xSkqCxS8auKXB3Ygczapzjx40RwmYWyhGYJXClF7xNJRSooFY/kZ/9eGffU28DjgsF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401686; c=relaxed/simple;
	bh=CL509SeO3o3kXKWOWf/PfkwoxXAhYxXN4nKdrAGaPWc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tn76O8qOqGN1daW+m0SSTcJK89Z1sdenTzsikL90eRfev6f5gVQuge8yFFoa1p3irsezGWGWkUyHuMExnKo9Nj9dVSZ9hWhenkoK2qPezU8wZKMjr4PJITzG5tEE+DfQnUyFbkLE6I6jXQQnMQChYAbOFVXkIJr0NtXD7c9f8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL+Ba58fBBdm3iJJNqZnB9Eo7TP5okBFK7SuMOhHe5y1ULXENQn3ux2x8nsQIvJCGMDXWQIfH8EK4X4KX/1deUZ5vrUxoZrQcpSKo7hCyFvk83y8Jch1z0RpT22LwqDPSvF8gG51GHMnmYVeBLxcIbC+Eyo7n0E0OIl86yHnf/hHaf3lCosbeiNvAsTr9Nvm+S/OlR15h+6qTyFBWxtQl3luZcC78rGIZCyL8zuRAaizMgOVVtd4r9MsbETZX5lYK4aEQrscSPhkXtFZ5F9po9LQZh32r7Y3cqgXTXgg8L1c1SaUFCqDMLV3+av00cwSdqoTwWQMqSwEtuuSr/BhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yRDTYfKjJpJhxqjpweztfeoC+dr0/0NbEom6dkeACXc=;
 b=nBHc6hRAzYcRh74RNI7fLBWSQ72eu88vr+mZtp4z/SfkcQqUTIA1IrwLzF0m0jtrbAvBaF7iUuFudkwLNxJ3V/nVFnbz0k7Mwk0kIb7bf0J2vZ0s3TGx9kgDHN6ahT0+2R9NPBgyRgw8ERTgq4TuAOyb1JOVZXIVyq3AlMs4F7E+sD1DQ2x0OB6/JN7wE9KoJYcLxZt2RPubXJu82BxykFCm5DppuVwne/mt9OFAB/4x1b6cVDkxt/57jO0iNqWzYxT1z74t6NrB62UYoHk9GG5MhDG/x24i1GcpctUO/Ev5p+Gx+0ZemHclLSpZIAfUZErAoZHg6X+q8voDmxOrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7807.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:14:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:14:41 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sean@ashe.io,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sfc: log active datapath firmware variant on ef10/x4
Date: Wed,  2 Sep 2026 22:14:37 -0400
Message-ID: <20260903021437.174319-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0526.namprd03.prod.outlook.com
 (2603:10b6:408:131::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 830f9f8e-ce97-49ec-46b4-08df09611cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Twll0PXT6vWC7yJxFr8VQtXU+JaGzJhtUri6R2hlJj8Lf82Mau/eqeKqUcBTM9rZxCJCKq4VBLYfD/HwWHLHjXr2PDqkCANtnBIQU1ufYg7kWUMeNe2sCrpCmEg9iIibd3WJeqU0jRsLXvoR9xhYmAX9PemKWpGi97K82/gArmFL4+WeYIVoRv0vDeKNNsHwGt7OeaDWT0JtiVf351Bh3gbAJj9xzzF6wR62xfULQXCQXaOS4oF8J0v3bgcYPJBC6T85vyqdcEpoKueXFg1/+GTolf/5UTkrVlefQZ4beLCBrmHXrxii8MeX7zqurE/BggKJk3oimz5cvSViwTSPamP4ADXN59qLy2fGid9Kq6KU4kIJDkvEf04T2W2Fk2xKo616m2bZHXgen1q2kiAPxYR4Ez1j7nFcl3fr8Uejkfts+Jz9piFenw3TL+nt6fWXotkYT0//jXkbfvWHNZmmZOUYyXjm9WsBXC3dGWitXVSwK7bqnNMSNpYMnSNEPzAF5qkM2yKZwmWJmcJRMrVYcmKnZkk8+J2huSXKMvdtjFsUoKOGERudQFiUCxI120ARnUKmy/B9np/270MeasVvf8ZXA4IV5gS29ITMvjFktES16OS8fXyTBpH+b1LB/3z5KniSGuO5Tij7zp8dWToM9v5MHS2RMTgHDU/iws94CV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tc5kacAjKmzcCWrBQfkCCVOoJrkZa3lm0ljqcOvR8OKOdpGJB15cW8RRb4LE?=
 =?us-ascii?Q?JP1LZ5Z6XZ7Ke+6/p2ZqaX4lgBJKuJSQXwe/igtetPAYz9IRuGVT77m6B1rC?=
 =?us-ascii?Q?LS81lcHmUBlKzCSHGPoKdYsWqCuPDzn8KiTPEb2d5JWzqDlxPvxtyysBVfzU?=
 =?us-ascii?Q?ODXGuLHKht1Ib/NIaYg0sz4vXpidpYuRIhLbwejDIPyOnbT4ArHBDUKgDwGJ?=
 =?us-ascii?Q?rCsWbnLAKV5m75g61p783xxy7/4JdqN9ZxwqIJCYCi2I48Jy/l/rnLnoYZXR?=
 =?us-ascii?Q?oZlkwBCObKc7AFbWbIUfhfZXBkQBHzYGe/aPoJcxUGUtUV3r6ybl5fXajpuv?=
 =?us-ascii?Q?k8J94FioY5Zyo3+5qAH2nqEAOYS0AocmqV1gEuv5rOIpD1zWHbNh9N07cBVJ?=
 =?us-ascii?Q?1mXDcHFXtpmpzGX2RaPIDMCbViqeqka/hNEko9fISlSa8Tv9qc5fsoM2Knku?=
 =?us-ascii?Q?KTrihS1lhkmUUWZb+/GIzdNpFh7htuKGzPaBQ7IGF3SV89k8vA8chWvjUQYN?=
 =?us-ascii?Q?rbzBDzkccQZOGauAMsldnnzE6vKeGTO147ccMS4vN5rO5dvVoZTmQn2FucJ9?=
 =?us-ascii?Q?G1PWTet9v/OffWYCpuzajY45Kbvwmi8y6e+QT6uC5V+k867hMOIvMVo+CDMc?=
 =?us-ascii?Q?URnoib9ILKn9fOxoQpmURFCnzd7DqRWDcSzLSbT739PIGW6waYYJp3QIUMpr?=
 =?us-ascii?Q?DTIqT3qlGImYAN8E+VTzEeuSN2QIjRs5Z3rzhpq8ttGpBnFQ5VEPjTxK0IDR?=
 =?us-ascii?Q?wxbp0zeNtexZ2IuEmi0VXzpugJTgvrFM3rjwTbA1YVrdh642f7sfhj/Khn4R?=
 =?us-ascii?Q?e1Mvn7kZpd1uJw3sF13S9npQHOoephSYSgb8Z07dNP3+6vu/+gEhkiScXJdO?=
 =?us-ascii?Q?BAJpi6KkvYm4shvLjTGAZb/ZbX0xZ1m/JLktiQmw7gM8PagrBYnQLUX+KfyL?=
 =?us-ascii?Q?hLwRiquYrk9E4mZVZ/SGorWp1Mxq72Po9912I7M6jJqLxy2JffI1ssfNdD7n?=
 =?us-ascii?Q?dzUVK+YKm7f5Id1M/zisPZnUPpUFT3xQsDZHSog6sz5nAXgd5758zvv0229l?=
 =?us-ascii?Q?Ks6Sb67KoGkHxPeo3/8Mut1hyZ+wnMYPFfcL35M6TsnnHXxlHE1ZtvStnS9j?=
 =?us-ascii?Q?lkWdSgGwOEwn3fm5az6KgE6kuSZWcv07FhMoFd7FfKZ4H3kXejVo/QB54CHx?=
 =?us-ascii?Q?hY5MJG+Ka0W8GMwkBOAPyjPABSTLtzmCucGer0zlV9Puwj75b+AxrwdygOHG?=
 =?us-ascii?Q?whxMZF8hSUNynfBFpMOlIIFdd7xPaqgaD+nxVrjdPF9xLx/fU+/0f/DIflKP?=
 =?us-ascii?Q?J1F4as3lBNAoPWiFIx7DXMiYO+JoIjxQh11eev/o/xNNVLn4DY0QX3d3X0n7?=
 =?us-ascii?Q?cl6LsQ8euD9lYyf/vbwMpjz7eCw7h+f6DOJnKDZHqbkO2X54AnuSILOvBwKl?=
 =?us-ascii?Q?jVLurVtP87mYik+uxH8wlSsGDo53rLPreBsuswwRCPnxAp8t8gfu0T8W6Qb4?=
 =?us-ascii?Q?i2RCw5RWp1QnNUosjtD9g+tpJLy1EYrf65Stzdx7fckwiJhoYijBIqB4r5JO?=
 =?us-ascii?Q?IoSke/BYBAqN/e5zRjRB4G2K/TLrSOvAYTbkUlJEmdQauW3GBfZWunMG8ftM?=
 =?us-ascii?Q?xXHFZ2LWg7+EK+LJSxgdYXPspgeBk9OGxrjDYsigTc8UYLc74YUdnJNZ9LjM?=
 =?us-ascii?Q?F6+7RMeQyuS3kl1JxPEWYRapW+tq242sz3zIUzOtRQaDj7jVaUP8sz4SHb42?=
 =?us-ascii?Q?vVhBTXhdNg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830f9f8e-ce97-49ec-46b4-08df09611cc3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:14:41.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8uuDUIZkZ492iUwpGXbosoD1cbFFyw1KKrVslStTF9DlzeS9E79N1h16H8Brhp1RI08XlRr+qZsYwHV2lCpeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7807

EF10 and X4 architecture controllers support multiple datapath microcode
variants (e.g., low-latency, full-feature, packed-stream, and dpdk)
within the same firmware bundle.

During adapter probe in efx_ef10_init_datapath_caps(), the running RX
and TX DPCPU firmware IDs are queried via MC_CMD_GET_CAPABILITIES.
Log the active datapath variant name and numerical ID at probe time
using pci_info() so that the selected variant is immediately visible
in dmesg for verification and diagnostics.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/net/ethernet/sfc/ef10.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 73bc064929f6..3b92e95532c5 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -105,6 +105,26 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
 }
 #endif
 
+static const char *efx_ef10_dpcpu_fw_variant_name(u16 dpcpu_id)
+{
+	switch (dpcpu_id) {
+	case MC_CMD_GET_CAPABILITIES_OUT_RXDP:
+		return "full-feature";
+	case MC_CMD_GET_CAPABILITIES_OUT_RXDP_LOW_LATENCY:
+		return "low-latency";
+	case MC_CMD_GET_CAPABILITIES_OUT_RXDP_PACKED_STREAM:
+		return "packed-stream";
+	case MC_CMD_GET_CAPABILITIES_OUT_TXDP_HIGH_PACKET_RATE:
+		return "high-tx-rate";
+	case MC_CMD_GET_CAPABILITIES_OUT_RXDP_RULES_ENGINE:
+		return "rules-engine";
+	case MC_CMD_GET_CAPABILITIES_OUT_RXDP_DPDK:
+		return "dpdk";
+	default:
+		return "unknown";
+	}
+}
+
 static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
@@ -144,6 +164,13 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 	nic_data->tx_dpcpu_fw_id =
 		MCDI_WORD(outbuf, GET_CAPABILITIES_OUT_TX_DPCPU_FW_ID);
 
+	pci_info(efx->pci_dev,
+		 "Datapath firmware variant: rx=%s (0x%x) tx=%s (0x%x)\n",
+		 efx_ef10_dpcpu_fw_variant_name(nic_data->rx_dpcpu_fw_id),
+		 nic_data->rx_dpcpu_fw_id,
+		 efx_ef10_dpcpu_fw_variant_name(nic_data->tx_dpcpu_fw_id),
+		 nic_data->tx_dpcpu_fw_id);
+
 	if (!(nic_data->datapath_caps &
 	      (1 << MC_CMD_GET_CAPABILITIES_OUT_RX_PREFIX_LEN_14_LBN))) {
 		netif_err(efx, probe, efx->net_dev,
-- 
2.55.0

