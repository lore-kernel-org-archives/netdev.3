Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68B313E38;
	Tue, 18 Aug 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080558; cv=fail; b=MR1gGQCl9IN1JWUZ74Ag93zadyYyZudvqjbdrAR3LdjYKu4A7TqHacfZk/8YZPEQy4RLllDeAmzNMaltz8VH3uN522A/84aVPjf6olF+GNZy7SEfAU/MVkxwxO0fM/TKeALGAhZkyROnQRRtdC50b51wIRjMASNs39JBXom18sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080558; c=relaxed/simple;
	bh=fI+b8+oaZqqwOr9T94zBYrYoqO6hZ1h/ZINx7tPKbJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIkyeomtp9KRVhHpwEHLH1LwTBe9LWtsyPGwaJu5uTCe4HpdHPPwKvmr2osd3ERE6e7aVvhj7ODUf9NWtzu93VXhmYInbdTwvUXElop1Xlt2G0gsp7GfeF1nemVn3I5Ko9JlJlCpUsspnK3LmqLFWbltSpVIUVswP4O5P0gwk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hE9ryifV; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hE9ryifV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thiGqb0d0ZsIhOFfMP1PTLcV8AgjiJNM/WVSdtpLsSTaqjh9Qcf3+Gu1GIiuzdQc6rFZ4fIaSNxQ4WmNJSqnRhGvTVzM7tOzTDNlpVypYNIM1Ad6nelijHBRP+hpH1Qzgf/MGvnSyt4HIiSMyfHqEHkqQzOCzs9C9hkHG98Ryjur8tch5BKSHa6XS7s+kWz491JuEzRmVhNFfkJC7w5CRSklp9ifaYhsd4UQa3wQaMnJwmmwzkIgi9wmfi2NLZ2Ly+gkuTNSKk3ZoPMHJz+58q8N5NuQ68HiaK19Tg/MtPks+Mx1z65wrsgvh6rD/iX2MHo6YMHK1B2rKYNpt91DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9w+LfbqEPlfKhB/8GOjaJjzh7UQSEnqmS7vEaMEAgo=;
 b=Qjk4lQ1bVGbyOCEhOUvuggYZflSF57yZLrf+MnKoYCPa6nPBprSskDovJ7kTQ9YlUKi3so6500w1c2daqAoq4qVHngytgyAMCEZsKpZWJyEKR6j9zoNL+kdJJVv4YR/iiyJ8urmDQU1sKFBfY5lZ5KFPz7T8m7zOJXnLobtT8V5Slfg4oXpbros1tyQiAddacA1p11APMaE1krJUIfe6c8S5JhcEfgazqvlSzYh2L8a46vOMxjQdSDTmk8GY+o+Yx39270fuWZ7ixo4Q7Br6c9askz+x3xWZw+Bg1X+g23YyiYoxeD3iylqj/wYDEG8/Z0LaGmUAaLyWUFGAdx3myg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9w+LfbqEPlfKhB/8GOjaJjzh7UQSEnqmS7vEaMEAgo=;
 b=hE9ryifVh5zYlfj40e+W3AI0NKsrCB0IpmQKk59gLOECxgtubkK/UNxJX6oij+Mi01N7wnjpg9eT6JedyGLn5OzFulUSRZ4+TcIL2mXxZFkDOVwvok5MVChJPvUqJg1D7cA6mQvB/KTwiakEdZnBLS6oS/g7lGPm4lW3T7jzJ7bMNKD8tlLarw3r/E1F2pcGPLRK+u/HVh9G3v36VMXRUF8eODXe3DgyOMxly3p6/kjUJC7MKRZ6bk9uooZUZObqYp4oDeY4CFlVUbmrVKm+9OvwBj+kL+FUr/zlqcueqW3DGBWBySQxP7t/14yR54ATGJLXoMEqBTSpidqD/kTGCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 19:15:43 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 19:15:43 +0000
Date: Tue, 18 Aug 2026 14:15:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Marek Vasut <marex@nabladev.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alex Bereza <alex@bereza.email>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH V6 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
Message-ID: <aoSvVcOjydIlUiuc@SMW015318>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
 <20260818174151.1608971-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818174151.1608971-5-srinivas.neeli@amd.com>
X-ClientProxiedBy: PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::31) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 07960a66-5b09-471b-079f-08defd5d194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	te7TMZQ7iXD0XOwf2ds/AHsl0FeB4afG2mjmeuSbPO1fIIaAC1ge1tVD9pxMUs2B60rlOCzSPshUp4o2C1HWephDqSLkqZZBco4bNC/ymBI4QqyQI+q/FDCn9QMfR6jG6Gvk1MfKOqLmr3Tnhz0KnHPVkzATsuxbj8ZFVDXZ7TutfElkICevCJWbHNQeQeU8B7MehZ+ABnEGEfQW6Osnor9aVkl20ragqcCyZ+9Z1uVbnpaGM1H+eVrSZ4oIiZLLNuxx8WHMPscO0vdEN3uYZLVotkL+EKPVn7W9Y9zgQiFqt4qSUxq23FZacR2xf2Yxzc8ooNvP0i7jjdDXSrjUzd6VxRvS0nSBda+QdmK08GnWd09F15KSFKm5FPxwSWx98rgtS+AfsOL//OWtqKzes2cOF6XubscTwjPKungRw3u4n053m4FmeRoMAP/aTUSYdWARdPBBRkxqAs6e0yWFsV4MswNme1/GaafD2Nm7G0Yeamg51Bz9aSs/62j+D0sLwskBwFo/6a0Rtm2dhILE586EdH1JebGt9jDlVMQN2k25Y/jRsOCa843PdNb4PK9Um8ct3TAoMmQEgvQR3sTPdt7D3Hku61r3bR6zK4Rc8FvUSgWaBiJ3UeDl9IjaQC7EeLzwSvWPcnGsYuDtopmaMyaK6rpUUwA4qTuNFa8727k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HN9pTp9DTWwim8ZfaX39poESlee9CM/U+XLYyJ1fYFIy2H/GfjaJVIyuOtWe?=
 =?us-ascii?Q?suOVHIYeSvwYATr9bXAXOXKP78FvQZiL/rkoUwMTpMxotFiofUqbWaDxe/EP?=
 =?us-ascii?Q?5C272+3g6LM0CIiqhsbjc6eArCI8wafW4LvtoOz4r8Hyktckztk1TCSXlSPo?=
 =?us-ascii?Q?LSFk7vpe6PhEsWIFGCdcA05JkY5lGxvmzJpFzX7WdTljZWQic1nLfWTJDJdF?=
 =?us-ascii?Q?kLWvAjiq0onjLYaMqEsbLV2y6sFrn+YUn1kJS2OK3Yw6yrIPPMB4m7n/1Ie2?=
 =?us-ascii?Q?qDRIqSwSVExo5i8Wz2D5nnFH2XlcRhHbnBTqK9LlCQboVLjKebuNpgff6kmM?=
 =?us-ascii?Q?dpUCwfCqtZourhrmRdFGk16+k7FsPX8kVeomp3632D502DPnBBexos5E4DYc?=
 =?us-ascii?Q?ywoCHiDwVMdUQd1nmfaB2pFRT/Jox0M3hAxSS+/RKfDwWWovtju0tO4Um3LW?=
 =?us-ascii?Q?3ap/p2H7+KR4rd6WqrWVTUO2Se6Shqh/XLX4Ayj//rjmi2nznuYbs628E8d7?=
 =?us-ascii?Q?COA/vYnsKFQ0D33GMgyLyzyZ5jQyGNSK43naQaJi6YMUN56avweUQqqadWGo?=
 =?us-ascii?Q?jCigGImgbtbmDG828lbNXCgYNSlpNiNbioP++5zdcDauCFKPFvKeBOyLz6Yq?=
 =?us-ascii?Q?QVJY5ZAehg+Le0V6Q/TKGuEPOhZpgHKeVxi0CW5TNUX56T5crQiNmJm3Ymiu?=
 =?us-ascii?Q?sT/qbAWrs+FRpIWA81UF+VnDtyWpsSMDrtctd1Aw4MNEquj6fAvmNpBY+6if?=
 =?us-ascii?Q?tnbKbI71Ftfq9i7JHADUz/pUTW8TlBYTxnOB0sYm+FWac7/6tBB9zqXTOUVd?=
 =?us-ascii?Q?/5imPMT6QfZ7MONlPPNu0kxyXoW9W31S4gX2MaGhB7BQizaiLeV3rNOctHOR?=
 =?us-ascii?Q?UV6sIfT4p6etGoYqeJAK4bvYjs4dlx+dvxQMxlrZSAsx6ZAD944f1z+zil1S?=
 =?us-ascii?Q?nDuBBt4kt3a2eU/ldZNenN9953Nda3olcLLK4W/Ub6jr2kBWMnQy4qqcn/UV?=
 =?us-ascii?Q?cOiZ6eVL748yCjd+TnoTICXAp/bc9xjl4Vx5/drO9mgmmSumJ4CyvUttEHfy?=
 =?us-ascii?Q?HnVyJRIAHHEA6plMom1aX4mNd+U0M73w+lWllEBhU5B4kNt1hrnsNQw0vAqT?=
 =?us-ascii?Q?BtyWLHd4ec8r9GRIazMqo6e75s1PlIFquO6QW3i9pKEAK63isgz8RwjtUsx9?=
 =?us-ascii?Q?uFTtOvQ30OasGpI0+blfit93+yN7YRzZUc18f8UwUARc78s4kwfY8YvtGZw8?=
 =?us-ascii?Q?ruVuRX3y1Pe+UbUAK7qsTX+Ym1ItQFC6qhPmPmOVWH/YfnrPYDDOth6QGkBr?=
 =?us-ascii?Q?eQW1L5J1V057ldHFbOiWbODsadDcbvvvYcIav/igxjlQrg43WRQa16W88zaK?=
 =?us-ascii?Q?oEPwkEyTnxMX7trcvthSI5/YsEb6sIzv+S7LqnyvwjWUOGs7O0SZztO/+6/d?=
 =?us-ascii?Q?VVDRh4Zd4MWO8fvgzo9VcF3sHbFjxL3XxHOBioGQ62FExECZ2+bc2nf9m4eR?=
 =?us-ascii?Q?Flxj6cUHmrNSQ77bj0ERkQmPdsdVW5Ky4CFm4A33wjNm4BCtDebD7UTIiSXl?=
 =?us-ascii?Q?HNMbPaGAtLp3/DtMutaJaYLheIelRuHx+/FUDKYWFmW0YT/nyIKwsBsuHRlJ?=
 =?us-ascii?Q?/pKs4ZRtcgiwJ9/Yu2yA3shBPsT+h+B8OClZtQyCLQvM2UOZKd6bwwA5wsYF?=
 =?us-ascii?Q?KRJZNr5R2EapntuOGdaL8JSemf1K5adNGmm4GCsa5p5E2TPlc9vzH/RTDF0B?=
 =?us-ascii?Q?lX0rvwti0gid3G+I7gi7uCzldfi75825Rk+RQETToE8SNHeQit/t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07960a66-5b09-471b-079f-08defd5d194a
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 19:15:43.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKyocVbzHR9JOCwlW2R2rCZiDYiHJPprzlIz9bJ1cq6AqZj/YCpC9IElMbVjYEgmQXushfcNdQ6zh+f0cRaWVtV94LG7SQM1WGRxsCbrhudO4/CjyrMctQjyU/e0IgId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932

On Tue, Aug 18, 2026 at 11:11:51PM +0530, Srinivas Neeli wrote:
> From: Suraj Gupta <suraj.gupta2@amd.com>
>
> xilinx_dma_get_metadata_ptr() returns the AXI DMA APP words from the SOP
> descriptor in both directions. This is wrong for RX, where the hardware
> writes the APP words into the EOF descriptor. It also leaves AXI MCDMA
> without metadata support.
>
> Return the metadata from the SOP descriptor for TX and from the EOF
> descriptor for RX, matching where the hardware reads and writes the
> fields. For AXI DMA, expose the APP words (20 bytes). For AXI MCDMA,
> expose the control sideband, status, and APP fields (28 bytes). On TX
> the control sideband holds TID and TUSER configuration for the outgoing
> stream. On RX the sideband status holds the received TID, TDEST and TUSER
> from the incoming stream. The field layout differs between MM2S and S2MM,
> and the wider payload lets a consumer distinguish the two controllers.
> No in-tree consumer is affected.
>
> Read xlnx,axistream-connected for AXI MCDMA. Attach metadata_ops in
> xilinx_mcdma_prep_slave_sg() when an AXI4-Stream interface is present,
> so MCDMA clients use the metadata API the same way as AXI DMA clients.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in V6:
>  - Added Reviewed-by: Radhey Shyam Pandey tag.
>
> Changes in V5:
>  - Take the metadata pointer from the SOP descriptor for TX and the EOF
>    descriptor for RX, matching where the hardware reads and writes the
>    fields (TX previously used the EOF descriptor).
>  - AXI DMA now exposes only the APP words (20 bytes) in both directions,
>    instead of the status word followed by APP (24 bytes).
>  - AXI MCDMA exposes the control sideband, status and APP fields
>    (28 bytes), with the sideband position differing between MM2S and S2MM.
>  - Reworked the kernel-doc index table and commit message accordingly.
>
> Changes in V4:
>  - Restructured xilinx_dma_get_metadata_ptr(): AXIDMA is now the
>    fall-through path instead of a separate branch guarded by
>    WARN_ON_ONCE()/ERR_PTR().
>  - Rewrote the kernel-doc as an index table covering AXI DMA, MCDMA S2MM
>    and MCDMA MM2S, and documented that the pointer and payload length are
>    the same for both MCDMA directions.
>  - Added an inline comment explaining the union aliasing.
>  - Condensed the commit message.
>
> Changes in V3:
>  - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
>  - Complete rewrite of commit message and implementation.
>  - Metadata pointer now returns status field at index 0 instead of APP
>    fields, exposing status and sideband information to clients.
>  - Changed from list_first_entry to list_last_entry to return the EOF
>    descriptor where hardware writes status and APP fields.
>  - Added explicit handling for both AXIDMA and MCDMA types with proper
>    payload length calculation.
>  - Added WARN_ON_ONCE for unsupported DMA types.
>  - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
>    added in V2) as it's no longer needed; channel is obtained from
>    tx->chan instead.
>  - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
>    5/5 (xferred_bytes support) as the approach changed to use residue.
>
> Changes in V2:
>  - Added support for MCDMA metadata handling alongside AXIDMA.
>  - Added 'chan' field to struct xilinx_dma_tx_descriptor.
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 48 +++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 506ce1ec29bc..6ba3c172a006 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -651,17 +651,51 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
>   * @tx: async transaction descriptor
>   * @payload_len: metadata payload length
>   * @max_len: metadata max length
> - * Return: The app field pointer.
> + *
> + * The metadata lives in the SOP descriptor for TX and the EOF descriptor for RX.
> + * Field order depends on dmatype and direction:
> + *
> + *   AXI DMA:         [0..] app
> + *   AXI MCDMA (TX):  [0] ctrl_sideband, [1] status, [2..] app
> + *   AXI MCDMA (RX):  [0] status, [1] sideband, [2..] app
> + *
> + * Return: Pointer to the first metadata word.
>   */
>  static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>  					 size_t *payload_len, size_t *max_len)
>  {
>  	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
> +
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +		struct xilinx_aximcdma_tx_segment *seg;
> +
> +		if (chan->direction == DMA_DEV_TO_MEM) {
> +			seg = list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment, node);
> +			*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
> +						  sizeof(seg->hw.s2mm_sideband_status) +
> +						  sizeof(seg->hw.app);
> +			return &seg->hw.s2mm_status;
> +		}
> +		seg = list_first_entry(&desc->segments,
> +				       struct xilinx_aximcdma_tx_segment, node);
> +		*max_len = *payload_len = sizeof(seg->hw.mm2s_ctrl_sideband) +
> +					  sizeof(seg->hw.mm2s_status) +
> +					  sizeof(seg->hw.app);
> +		return &seg->hw.mm2s_ctrl_sideband;
> +	}
> +
>  	struct xilinx_axidma_tx_segment *seg;
>
> -	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	seg = list_first_entry(&desc->segments,
> -			       struct xilinx_axidma_tx_segment, node);
> +	if (chan->direction == DMA_DEV_TO_MEM)
> +		seg = list_last_entry(&desc->segments,
> +				      struct xilinx_axidma_tx_segment, node);
> +	else
> +		seg = list_first_entry(&desc->segments,
> +				       struct xilinx_axidma_tx_segment, node);
> +
> +	*max_len = *payload_len = sizeof(seg->hw.app);
>  	return seg->hw.app;
>  }
>
> @@ -2639,6 +2673,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>  		segment->hw.control |= XILINX_MCDMA_BD_EOP;
>  	}
>
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
> +
>  	return &desc->async_tx;
>
>  error:
> @@ -3287,7 +3324,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>
>  	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
>
> -	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
> +	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>  		xdev->has_axistream_connected =
>  			of_property_read_bool(node, "xlnx,axistream-connected");
>  	}
> --
> 2.43.0
>
