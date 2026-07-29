Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841E46C853
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353300; cv=fail; b=eUQZnzux+0JUGY2RALmdO32b3qxZVuRdSbOvseGYbX9sfZgRiVAiRIThVqBsCw+rNH+JQt8FpxKp/VkfDx7eN+yt/FMMAbhY17c3AOUMVX4rUY9N7QuxH+HepQeam4Mn3bnOvtPcgKoPNx1a6lVQ6oeBHprblYsw9w1arssE/Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353300; c=relaxed/simple;
	bh=tKQcKQEf9ga5N2Rdf5INUEpLm1Wj7DP9vcc2MAozedE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmlgXUXHUyBgBne1AutCqP5JWHZy3C/DJ6jYM8gJMFM37hDgYllpLCka77vIIONeWqdNXfxwBMyz/HXkhTc/P0tVDKVj4vXRBQEByZ+a/7E9YAeRU77TES+Vhh1oO7Wtr0M4eOywMwQ2LIUsUVUQujMLsHCD8uWaeOrjsZL1lOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=UCzwPdSN; arc=fail smtp.client-ip=52.101.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="UCzwPdSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymuD2Mv4CHQMEDeFB0YMvS5QycN4FgIET7vs26ex3MC7zoHpuup1KcXZSjFYIaqKdPxJhjYE7JW5nsq7aWz3l5RvTAleqXTb6JFTg16u8tRBzWsy+54T/J0pbe75H00zNIU1ddMO8Z/HGwMjG9vEFrW9FuWnyMtJObm/oFKNrabloTHN52TX969jy+ZtNv+tuhG5O8bMvBOcbUDRyW2YwQgL7Esq3HgBOW+z1ZPgmXK+ptN5CXCvKAGSWX8Wn5dJraQ14x79QLkXUd6sJHJJaW4nVNOpozOXnSfhf+gFOZDACAzjgYwiayANNNKqYHxvdvijM2dK53dGfjZQSqF67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77twBRbJrieFrWJGKY9M8tIspSrH6sXxedM8RerEtU8=;
 b=V+ybvSfdy42wiCdVxsmV5kyzPFdkzCgw0wWisduIFhQ2wPiZIMC7NDuP5jU1FnVkXNg2OJmXct7IuU1i63QGTFofl1MjhYf0mZfPQ72UdZ1ibbHhmdC3lygQ/0qgihqFzLmtJhDGCd8df1W5QePH4sjh5fRFrs65DlrIWfuVJUowI8XCnmLKHezCMxhf0UcoC43tzTObJ/jxW2FTjzo1kwFMOPMxwyibCC4nxgcdPrdqOxg/OAP2jFGopFnNdLwIrwNJ/4jU5557nEScZHIo6+g2SkwjUYqJGspkDHlqEFkgb0wzKcTDEgROTh/9vQ5PgD8LqPYD/RuDcIUuEaF4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77twBRbJrieFrWJGKY9M8tIspSrH6sXxedM8RerEtU8=;
 b=UCzwPdSNysUAN2giTITfi2S+5WY/rKwXyl9c3VFl8d0Z1km6WwerbIpDrm5CYXgd2eLbGcqb+m9U4STy6FxhvHlcwnBwW/qlv3tIGsgBp7LA7bQDcT9TUIQdF+5NxKnNeZsg5NnmoaFbTW7V20P5tOLe6nQ1Z3eEeeDY5BzW3ruspgVNKcfvYJ59lZxf/jOMs6XmuEQhlNfYnQyKEmpaZrHZPacNbchBZzv6MDPck7YuTwaSDs/XSzFDU3inbRbGw2IvEeVjiJh+spLjWvwiyURHzHQMCH9JZERkNpuzztr4Np+V++0HbjFLUXDCHaqEh/v0FyDi8tvq99z+zUZqcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 19:28:12 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 19:28:12 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v3 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Wed, 29 Jul 2026 15:21:26 -0400
Message-ID: <20260729192748.6928-2-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
References: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 273b398b-e8b5-4bb5-8e39-08deeda7870e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|786006|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Sq149DO7HuAQEg46MwZLWuBK7tARVGyhavB1aBud2NJyrnSLyuy9uD90SKI2rCcBZKkQPFseBlvuhDhD4YG3SiVvfPa2Su0/NFntFcoG4YTPLsCg6ZAlOEyudYY9kYRt+HyzCvcfE8MruCDeWVYccBCEMsiS4F5MzgMHi1gWdMpsZZ+EFYh1eSC/1ORFC8SWzA8XJcy92kLn3/JuMuWvn1BsEXxZv37/o8VjS2zKkaBJlklu+U6ZtuBMFeDUMCapFOOZjC2HSHCPfx4oDWG7HXfs26YIK695tBAkbjDxQQDhhM4QSGRXlQDycsVnwvVCXCWNMzeBRuAMwjCr5MaY+HAELGmT83j8+O43RQ2DZMULPjBHnJuYZE+oqXfWDkM5hFfQalk3R+CLo+k8mj+XMNPB48YlrXorgm2X6Y52g9g/mL+UOSL1oQ9JLlluRwpzcE27DbxYWip9YjiTUMNAt6osIceNdmJw+OiC6LhPzpyjZ/i+/W6xmgOHhljIGT7jpPSYQ35x1uHDiIZ2VyWv9R+syt+PBZAdUz72C8XrUTcug1BFaK4CgDSWpfmhGLkTrKLx3fOOBASRyLw/7zrxy0EcHRmJ+OVa4R18TsquriMJb3OHLcEODzz1N5LbbXpODOXVlEilIY7kYhddyhY2Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3k++DG7vuiJhYrP61OmxXTJMHvI7SqRkRC1B+plHjpWa9j3WRTyc5sxsogz5?=
 =?us-ascii?Q?iJL4kxFlo1UVn5z2EMDC9N39cGzyoreW/IxsrNwwPQNpFYD8ULH1zZOve7N/?=
 =?us-ascii?Q?UmXYOXV5wwsCC/+pUQogImX7Omn7TftzOJCMrqiPaEq0C6iy4nvR2fwKqum/?=
 =?us-ascii?Q?76TYwXR0idA/AcJDjqbxFLfaHJlIME++hQfqkjadDtxRi3OJyMrGSO/nxhsY?=
 =?us-ascii?Q?e7LqnwktZDacg35ocr2dVV3vU+gcvvJOrWcxZ2hEeOquQ8Q/9ZNFIUbYJ+Hr?=
 =?us-ascii?Q?2oQkDmS9Zv90jdlrZ7ZkZxSOeDGSvMwvDL3Jzw/GKq0eT6+h8vTkdWnn20eC?=
 =?us-ascii?Q?42b0YzoA6L+/3jdKsRDdqHX0+NKRKsVHkQcVotH3GlPEh/a1Mocxio7AYQAV?=
 =?us-ascii?Q?i8KWE1imKmOQbwGeOhCLgIjZ5aVbMNa7zGnTN6Ame6WU+7ibG7v5LpiS8yF/?=
 =?us-ascii?Q?hOEq6xe99VEpu5TssIfgh4Cf6Tp5W4+eIwdeY0C1jf+M7frTyIQWePwSUEuD?=
 =?us-ascii?Q?URd1AcDBHkKtYvRgMFnqExuYjkof7dHaF62N90NSv7+IijzMdKa4Xs5xc4xu?=
 =?us-ascii?Q?J+l4iOkpDLVGylj1Dg9zQdYuo3TVZgD1Ksj6tfOeG5ubUGw7xpZyvj0Z2tSb?=
 =?us-ascii?Q?ABJnJjPZxkMxHZWZyw7v87dhXLnyBrVTd9btJ+Aw8enC0ZXLGYWJg4EGvvqA?=
 =?us-ascii?Q?ZLQvmYsPZ5N2OXfAdBGnfxwLcRvCiE6k1LD6WP0l0Sb4O16IERxthqdBkGHS?=
 =?us-ascii?Q?zkaWnM2CKX0qGg0Zlcyk7EjlVno96/99djLk33KVMK0XfNBA2bXJYmryeJa/?=
 =?us-ascii?Q?I3zNXp8F8lzL4DEMo+nFPUkLCLMJcxMvXuQoWVhPYkhpX4QS8kbMC+v3K7iR?=
 =?us-ascii?Q?qbOTRB6VMPo1gh1atyd+QlIQy1QMRNkRbzA5Gv2bNyxwLoi2cFGLS7bBE+fb?=
 =?us-ascii?Q?d2h7uQiYnzapLYSyCecOZpCoRrL7j6TrUA7OJHdiorlBd3AWAWiS3dAjSoXJ?=
 =?us-ascii?Q?aG2iB07w4vwkNTl/eNiuXyMmI/J47EmJgYDqQM7ajjP2LGgscInib2Dw3Ckn?=
 =?us-ascii?Q?tFixyXybcRU68muwaoATwAj6RWtVVJOZP4481Q8u8CiiVyw3RxYsYeFhEvhH?=
 =?us-ascii?Q?8d8cIdSIpAKZQ5X6g4AlPP0ThipRkmv2JGOe/UBHsgaFXFaPWLW5WI1hSGPb?=
 =?us-ascii?Q?5Jt7VEaNLFg9Tf8XQOdcYEY1wcz4H7PfTjOE0xZSSPhH7bticdbphadVwcr+?=
 =?us-ascii?Q?8OHbg32uJz5EZzYtQbb7XYEMrxMUybWI4WxovbTS2f2toz8hCPujzN33BJkY?=
 =?us-ascii?Q?NjX8dCUc7rEDAH7+lmwdOmgsAQwvpQbEWOQhGqUsd4SWSZ8wF3iYnztEjGqx?=
 =?us-ascii?Q?blmZYTJnyzy9ozWBsVN+UI5Gd6fB+dbkuqCmZPheydUE7v7yB5BfntwS6jJp?=
 =?us-ascii?Q?bWrCGNKbRacC+gIbq2gpHmyTa0B35VrJ3C2RwTB3Ow0vzIPSGFF60HWA0IzX?=
 =?us-ascii?Q?Yw/M8wdLlJK1a+9zzEKYFGQaKbAKByubkm0mByp5zgzgVlThu0oH+D1t+X/w?=
 =?us-ascii?Q?OS3AF37rFVupkgO+A9UDAycdZJ52zin3jpzt0aioqETqpweklSBFjyyfIey9?=
 =?us-ascii?Q?iBj/M0ZjvU5NSNPXMMFQwTJUary0hwPGZq+6e+z++h9TzABauGLfccE6VijF?=
 =?us-ascii?Q?seHsJLfpK2CklV77zBmK6PX01OtEdAIaqFBIpax/LsforT/79vW1+veRAneb?=
 =?us-ascii?Q?mi1Qre1tTw=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 273b398b-e8b5-4bb5-8e39-08deeda7870e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:28:11.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2poJR39udxqod36ioBczKUTUrH+Qobn7aBDzfuy55ReeDcEcIscY2q3c5+5WTPcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

When used with an offboard transceiver (e.g. an SFP), link state needs
to be measured at the PCS rather than an onboard PHY. Poll the link
state when the PCS is active to allow the kernel to detect link state
changes in this case.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..c15a9c7e69d3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
 	struct macb *bp = netdev_priv(dev);
 
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
+	bp->phylink_sgmii_pcs.poll = true;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
 	bp->phylink_config.dev = &dev->dev;
-- 
2.34.1

