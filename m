Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792493781;
	b=dnhyuzjZyCHGkNJlFqzpWQPitpxCrtyBDGp8svRjAsccZs52Z38+jzlxiaQnyn+cDHba
	 2/40iO+VcYyl518Vl2c0O1PuYRi8ybO4bZDkaI+U8LtiOG47N6rdenROIhOEx7oNCe75w
	 lgHd1DoFDaWpMdEKQd+hqNplnmFByJtN/IK7C3LSM27rY86sHAcerMJk65ncsKYit2mwG
	 dqRNCs0e+2bKU/o7zAHKLLlarggA41RdozvOaFO8+gjpq4yQxm26T1U44fHCGISDrnFOH
	 LQlkD+X8hha5n5SNxyig3F8Gxb7zm1lxiNa6yyGZYhUHSIzWPA9OQEU3sWW9sroiyDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493781;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=41nCqUX8lRCUKUDzaqjMdekXDFs/LensTodWqaRXlWc=;
	b=Xld2rvtnVABHyxlg3b7HNGu3bz2rjDK8/zgFuvIlwX+zLxCcVvdG/kOZRMWA09sAKqgJ
	 yBngkQ7Jqxce7JbI+/WONoeZeXvsF88rb7hlSNoc4nSQ/kybzYXMj30VDMwdC25gd8xcV
	 3/ADK9UMNp6Gp/7NeyFCPfE51MFboLwW4nyK8WmWRkw1AJv8K4Q/dKx/T9DbV9fpDC7T/
	 XNeCoDCLOj8Ia4BkMI/0e1IBS5E1NDGvXse0JU0BalrE4xOqvGeVqQoCWMsHq2ZBp3ybM
	 rOfN+55uwxk1a4ljx3EFkdkdRSBDtmL2rC4X5//07iuTyaPb+r75OFTwBJk5W8370TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XrKNBtfS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E6606A319;
	Tue, 20 Oct 2026 10:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7E6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XrKNBtfS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKeI3SkXGg/kjG+zmMIKGYFjmQyyFoo3x861jDNDe4IfJTjHypF3tBxgQFI38n0F0KimMOiTeaJK7vsuhGYcAl7HxcqrF05juCpsJrNNyrg9bpialKn63dchro8wN+V2rsV80silfQgyrDGOwXYkbI13y/rETmIRyV0xI3321x6fpw+t5U8nfeIA5THmSxYabJlcmj13atDIGvyAagJiNtIlKY6yuSbvBeVewYJTx8RonwSLGRh36Snk4zbHsd22t+jv1SmuV37qtTbshnDkBO0Lnd4sAgl2Bvtla/WK2D+fbLkmIioPtSvcBrOy6iE3AxYZtBQFEp/YcdPFBRjvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41nCqUX8lRCUKUDzaqjMdekXDFs/LensTodWqaRXlWc=;
 b=y+f2BseT+dG6wz9uJt+TJIgSiQNAv486rxPqWq8YXTUkYiO1b24DjkSPxG9TD+cz7i87yGcv+TMTWNSdfhqvxH2LH5BCLnlk+JAo+CJooUSGrLVafwMgXi751zzEG4v7OA5kT/Z/UDHTm3yGx0bkAWsMjpFxYNMRGVoMctu3uwOEVC6xWBW+wyFx0AVIoKHHDXz1IjjUtplnZXPk3kk/u2iW1IbdUZQt9rAct70hUNtKkTxtxOqGYJh64Ax//PWeyt8LCoktx4N+9ZckSUegHVpvYUvVRf9GJWNfCsmA91pLf4Vhg0E2OgHbzEEYSChRHcMS/LrlOpRgqAK4nh0BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41nCqUX8lRCUKUDzaqjMdekXDFs/LensTodWqaRXlWc=;
 b=XrKNBtfSioDul6L/F3msJsbT8VBzfBiqsLyyliFzGEVxzM3dBUpd9arT33nrYKkujUZFhdg6en1Lu3GErTGZ+krc5nES6uO475/PHQfQJqbD8Sq45nQDWj7GUxMmUJRn2TJThl+sgtZlZXXowFsRP4/PbL58Szgx3zTz63bEdBe07vNaH+OEDLRPqmk2Iftq2xerv0Y+PQgv7Z9C+Mgoy26Fm6PFPqYXPhoYucj9OM3ApCXOl66r8k/5YPE0U3Il9ORiYrSubnFJ6n5wdODeJY71IlVxkbBWZkUs7INRvBQlCeZJggG0uRh1t1EIpmT1qCYp1L1yzfE8O4fxopTxUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by SJ2PR12MB7822.namprd12.prod.outlook.com
 (2603:10b6:a03:4ca::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:56:18 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:56:17 +0000
Date: Tue, 20 Oct 2026 13:56:13 +0300
From: Dragos Tatulea <dtatulea@nvidia.com>
To: jiabin deng <dengjiabin2023@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help
 requested
Message-ID: <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com>
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com>
 <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
 <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com>
 <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0195.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::11) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e0367a-1e1a-4010-a61f-08df2e98c483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mqbvejrqCa1Z1iXGLb/kfT5YsiDjY3RkOQ6B8ie+45H5UgTiSddYrAwTLe9omkudTSLEq7G22+ohRwsoUGPNvU7J4/l6Myul8s6U+0LdYUH4YRgF4Qw12Z7093Q6RC0qNc4K687GRXqGjo7r247hfH8ftKqxHexfzj0rzVTkYfaaPC8HtELEaPbZc1E/xa7kFICqLqK/zFXD4noOnBUO9u8FIHpCjUkrCqrNwB+W3gzqzXzrheybzHX7e625MpBQE/ExskNskUA2/rpnHeifUhKaPlyjqM/TCjpes3rj3QNAsnk0FjGVnt7xeCylSnvc2pr8t76WD+0kK3C/fPBFCysAjcRXUGMYSf/K2NfANYhHT5AmEIpOY9n8N8yPg5GXo91aTraM0CtsdfxCGX2JP9lcTv0z9qq7qvlXkxzF1PnufPvZLms2YdYFL+giUzreUvAuACY4+Sk63hnR4/CyHefUs9L+OpjvScGwbEq+d8ygNPAGXtz0fd4Mihv1ZYlYi1DO/yn9nk1PTAXSwUX6oYmJfnI3Wil/+A/S2xAddc3FODrSIQ7BKsS5EPFRpN4OFVF7lpteHzHrFHc/0TE29sQXlx5pKI+Rntq34EYucI2gj9YPPT98X9FSfdr26YuwDczmGhtCpvvQSlAjrRhG0r5Y/crQ1ymdAj0MNr/GjAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99VgAzeKnAiH+AAZIYdm+d3Mc378Ge2SlPaknD5WO+K8RJ6Aktbwt4R4vcJX?=
 =?us-ascii?Q?hQ2CnKnQSy7/t80RhWXLZ7y0FyO5tXUWVQEHvIxH6WVlG4W6kD1Z++zekIns?=
 =?us-ascii?Q?/xLMIon1p/HHMgOnEOAfInaMx/a6T8bS0kqUqeRMirqCbwxcaI/YKPZYaj+S?=
 =?us-ascii?Q?HGAcFyIuwyv/FOzeiFvCgHpLggdEHJTWQZvSM+nv8LzxK37H7Ldvo/h23xIV?=
 =?us-ascii?Q?txspxqIFT+CDLmtrit3rabF/BcRDTwjbvRoxw5w3eYpssIFgg2tDABsB2aog?=
 =?us-ascii?Q?PlMI8AU48UT4soK5OZ9BOFYpUoh6OnWC2FyNvAJuUOPrjEZck0OChZyV7h8M?=
 =?us-ascii?Q?/WmrBhv5zeWoLeiD59ZViLKPfO9WqdphlEEpyNzaJudNIT5Vv+WsQpumfs3x?=
 =?us-ascii?Q?0VX9TG+Bd48euck7QI3wGc9D6VQhdAa3O/E/GMIrDNQdyL5xYBdAi4LY+mCF?=
 =?us-ascii?Q?o+AiplowvQ/tzUmOsPyz304H/FVVFqtvXjofy2Z3if7vthLE5CSdg7AVxjHJ?=
 =?us-ascii?Q?niO6/c3uXu3/FY8cDsTOIQ1cp1g3yRWa1IIb7PFF7n8i55Ic9g/uBxb2CC44?=
 =?us-ascii?Q?DvX87xf4lpRwAjtp6OCCWFURO+16WPP3Tk/hq+vpA9pbhXszVEAh8mGRMxY3?=
 =?us-ascii?Q?2Bwy5HASBVx1M0NdffVRLOtJJd1/yfvkZbsulHOrdcxRW/PZmpyFWoZ2xEsd?=
 =?us-ascii?Q?ZVNVMFDytMX/RvETAteyoGfsN6A/c6fkw4JnvGZHqrLu35CKZq5nUuSKY0J4?=
 =?us-ascii?Q?aNuPoZkRSC0jMFc4hQM7DlZjZUAxi1An0CgkjP8hFhQdXOzRREINcPcaAGRd?=
 =?us-ascii?Q?BLAan2tg+iQlQAlV3BwwYhLlvPdRp7fIecPOv9fAc/PyZXeSM5E4fj5zBiEc?=
 =?us-ascii?Q?pBylVGmKdu+c2DNy5J6ZkGVXh4EhmJ3IKws2EvwmFUVp8VPlSTkWT3q4xisM?=
 =?us-ascii?Q?k3kWoYLFJb5STIMlL2oZJTY5MmeVToQF2UaVDTy6u54xwrKGJxXBNhgwTcw7?=
 =?us-ascii?Q?6EFCWUmpC5MrntnglrxQ+oZ8xE1shGGYnC2mYbNX8JnlX04D80ubNbfYKHQX?=
 =?us-ascii?Q?T2FOPILpINv8mXNAjGQYPX5IKK32jNdQNA7X8Tj8dbXW9FTmTaL0NH04W6h9?=
 =?us-ascii?Q?JDdR9RcFjAbdDr+r/jloa4RoCZRh1GRTfcU1BKKa2YFMypDhZKPqxHzpgX52?=
 =?us-ascii?Q?RzNfxp0y+BOL4U49ICrWQER6qCWHGKADfsTQEGbeAc2qTFhuTVncdXw9BNAq?=
 =?us-ascii?Q?3pLZ1580/kzWj4r3a09t4BxSZjPULg+YCyF1vFr+2gBLcVvzHo6PocD74EmQ?=
 =?us-ascii?Q?AYiVHZxs5hg94v49XA2JLLZJ5aJyRx3RKCpP+fX71FimAHWfss4s8ZlNbjWE?=
 =?us-ascii?Q?IlchUV6ps6NDC5IkrTpHZTB1YI71bSKbu92jYr1dSNqBmVu1yNMkLWNrajgC?=
 =?us-ascii?Q?sF1Jh4tvXNu5k0AW59Wc/Ci0oitwWQFq5QFXL35vLPukd8LiFRJe6jOJaffy?=
 =?us-ascii?Q?gcpgYH3kjCb4IFK+NNtDbId/MejHlvszyGwfeKvdRTNY0P9sj9a8GTidSFaU?=
 =?us-ascii?Q?m9uB1O0i5Y9gTd55rjgwu7Dx7MyR3DxCGETVDyLo+qV4TFdkuJAOqLNKOXwf?=
 =?us-ascii?Q?BWYtkSp6hRO1JbZdhsVGUBR+YrlqDTY/SUVh/0W7viKP69n3A+/WKKsRNta7?=
 =?us-ascii?Q?Q+bCi1USpWo8KdVQWqNhWOe1RTaTfe/k3dF6l6QRBUC3nO/gt4IjVovkzORG?=
 =?us-ascii?Q?WxHsWUfznw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e0367a-1e1a-4010-a61f-08df2e98c483
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:56:17.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1Z5Iw7YWlxfgkwvsiDYwnIIR4FwCDO3C8Pi4066luDUtA/DXFj0pOsFtAXeLWKecpEoyrVtABtDiYWwwNxcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

Hi Jiabin,

On Thu, Oct 08, 2026 at 02:48:53PM +0800, jiabin deng wrote:
> Hi Dragos,
> 
> Thank you for following up and suggesting the CPU-buffer comparison. We have
> now completed both ordinary CPU TCP and CPU-backed DMA-BUF receive controls,
> with no payload corruption in either 400-iteration run.
> 
> Please find attached a standalone GPU-memory reproducer with a README covering
> the required environment, build instructions, two-host execution, and result
> collection. It includes a Python TCP sender, a C++ receiver using the CUDA
> Driver API and Linux device-memory TCP interfaces, and scripts for SHAMPO
> header tracing and offline byte comparisons.
>
Thank you for the reproducer. Unfortunately I didn't get the right HW to
reproduce this.

Pasting from your previous email:
> One possible lead is an interaction between SHAMPO end eadding and
> Relaxed Ordering writes. In this version, rq_end_pad_mode() disables
> end padding only when LRO is enabled and write RO is supported.
> SHAMPO therefore selects ALIGN; at the same time, write RO is enabled
> on the payload MKey when the device advertises write RO support.
> 
> Commit e2351e517068 ("net/mlx5e: RX, Avoid possible data corruption
> when relaxed ordering and LRO combined") describes a related issue
> with consecutively placed LRO payloads. We would like to understand
> whether SHAMPO might also need to account for a similar situation.
> We do not yet have results from padding/RO diagnostic experiments.
Initially I dismissed this commit because it seemed unrelated. But now
I see that you analysis was probably spot on.

So disabling alignment padding mode is definetly a very useful experiment.
It would go in the lines of:

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 70a855c6d19c..794d8be88f0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
-       bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
+       bool no_pad = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO ||
+                     params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO;
        bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
-       return ro && lro_en ?
+       return ro && no_pad ?
                MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
 }

Could you try this please and let us know if you still encounter the
issue? In the meantime I am checking about this with other people.

Thanks,
Dragos
