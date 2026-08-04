Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956232FF15B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888664; cv=fail; b=t7mu9WWnereEgcF5jaHSsU7LZ87qN2S2Vj+jBpvM3rPdBE+/qhqHqtydXE+gfH/qYSm2jXzNbwj4oLFZO0buZl7pH5JDbAAuQBLxyJqQpRD6PKDRJrIDadaRGbETcG3gSEZsciBE/4F5W0xlMmn/bxUcHEM5sqY1Fs6+BwRTyIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888664; c=relaxed/simple;
	bh=6DwSuEUcc6D/epz9hpgBkmFQifwZfJP7DTbVcYohXH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEm8HWpko0uTrsXwySwu/Cs2X4Arc0nU8IDFH4h5AZPYpSA9t18e0/jdSG3sy9IQaKOBeiSfIvmKlv5RdNg/UvJXgqkrd90/fQG679OhFnD1UEFN37cb6IYTOqH2u1DC3wXo2kEcBLWmazXsXqMswB9V9rReeVIk4T2JFenruHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=lGEakl3a; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="lGEakl3a"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020135.outbound.protection.outlook.com [52.101.201.135]) by mx-outbound-ea22-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Aug 2026 00:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU2doyz0RnRf2jOjDwlbqMVdeLT9WI9n+EV+kRrcvF5Xfbhb7am7m07V64BN1vDxbsp/WZjUGwION+/1oBh/8/Diw7qNHvgD8PKIcrDz/7zsatvKgfP86F4Kd7oO3DhF+pKUhEAWwuBUhfgbPvqs/ggxw0GkjqGOTXiRIYhLYp77rYbz+cCL1XGUMGR2TuY3b9PDmQDxX9yKZIYui9ZJtQlqnuye+T63tPwEZqTZvPhH0hy2oWQoB+8SmAdM9AfsTPm3LoYS4E0Hv1XXPi0Df3dAVDmFLyUOz5CtXjiX0zLe6LibKiGmYKQd5XMyGCZaGs+OW04OtW6X+dz+/nMTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=P+BMO/nWSRe1T9c3H6pEaRtp2EnhPhBXiKapxO15doK/KTG6Vt4z1wpPL7Bw/c7P+y7sTQu/lme6W4PDqGmRzCEp2WQ1ebvfe4QlULHlVopBVoAtCfAmVpDGQqGfVmcjCL7Lo7igZSgphVZfClRR5LhtTPnPteKEjg21YZyOcsNDw8smQeBwF1BghGPxRM0Qpy3f7e80f0wDMm+6ivMtxKjR7Pw+9/59PmNw3pPp4CmdbAq7ue2HstDnW54FcNTBZo16L2JgOUyUfuYn2Nj+HBQ+g9HEnSPAW1wIWLATvgyrNYacYVRmOl1rjGSBmtnsbzvtwinKB1F9zEjj8Av7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=lGEakl3ahEn5AIuv568SByOzi3Y0ZXKo3gY00CpSr+yEZ3UK7E+KAZH4aQm536vzCB52eRAddKzF1tB9WcpApPf9+ck3K/oiy1WBKiow6WpqnUTa6wv+62/4gihiHX0yKrXvVPg30mHHi51Fx4JbDF0Zk0sSd3CtHuHN0rltqA4+h0j+AFmoGwYMq5WVZSahJteEIVOTcrvGmrxcKr09CeCNMig2ZDdq+BX1MKUPXI1vIHhEZO5wFVJt2X2/9d0WY7vtk8c83I38pT2NQzUfBPeMN7gXGbulox3T5VONdT3dsFn1mrpbKp94xCcLlVPqXQLcLyw0Lo82gMDifiSCjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:34:19 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 23:34:19 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	sergey.ryazanov@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Tue,  4 Aug 2026 17:34:10 -0600
Message-ID: <20260804233411.1953445-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804233411.1953445-1-peter.hunt@opengear.com>
References: <20260804233411.1953445-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::6)
 To DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd179d8-186c-4507-7dc8-08def280e812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 9OpOPD2IpadSzk2WcckwCc7iwrbf+k27CjJSYunWXfDWWPHfebu7E/dyYrCzt3ZMeSRosfaXxZnN4Wza30Wm0/Q5kgb4hboszXul6NcXxbCmyXQY2xVa29ol812DiAyEE1ENfn1czWlqcF8VNo2GbwDs+EkWQgtHXdxRmYqhehlvYPZI9sekSqxIvAJh87aO3CqJKVm26V1lwhaKff6Jxu6V9o0x48PGom4QWSidGrGMDRKl8jynZ/ql4ffZVrOPFNZixJ/Hxw5uBkmN2oAn3UV7eGaE7kcFZsdNX/fsRqgaEC3dJoKA+9fZlPrfnCFP8zsr+/cdtyqoXeM71yDQZZWBChbLkrtvxk6kULs7T5MVwBLaAfji0jhpxalLG1BQPU0qEInFcgKt4yV61yeWc3WuLL8Gtf2pSWYD9npGGbdGp76/DJr9n/8/XURWN6nRSWYzb5PRhrr3eCQbkz9FrfiDoEpJcV6rBSum90mSZf+07hIo3nHxySNKYryNshhmr9u3OiQcjgGgxsRuBa2cG+Tqa6xd6XK8tB+D0Db6ARoW5qaF0G6D6lt2Rto42TPmmczDRHzBtilAJ4687HPTkfVxLGh0rEkHCLeAfFvgOE7GIK1PGytFUarFv/YO5ljKqAFz2mcK729ItUrs3nun9T3ypuvN6+NcAu3s9SHOufU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ow1xRCLKTXSb6mnXbsPZtOjxCYzV1pKY/ETRNX6dNHIhHh41gpc/Uh38fD/V?=
 =?us-ascii?Q?UUB8gxScjyFmP5hICxGXBcAsL3r2TE6gB6B7j5HDNBrP5Wex/xtUJe5fW4+5?=
 =?us-ascii?Q?qI8AiWacro9WuisB7KV0BsY2wOCeg4fGYO+fQuC1vNTcer5YZTCodZ476YvN?=
 =?us-ascii?Q?12JFzZTeIBv3Wni0W4jcpVjuKZPtyHnVmVWJdMY6lapCnlgrs/rvSldq9BYq?=
 =?us-ascii?Q?z1FcWh3ZDrY5PvswWl7BjHogkuIFXi1bF7ZGc28w6dRWJlkUNkHODoaOTrFS?=
 =?us-ascii?Q?Y0Gyc0ul9gXtfQdOyjHkOSUJ6Ip+fLRVgNseedQkFQTWaVIwBOfFO40b8FVP?=
 =?us-ascii?Q?Ek7f1I5IrKBd9ODVIOqy5JdBSpfSjFvzaoFrWYWRBEAsN0+Vt/wqZqXOZh/z?=
 =?us-ascii?Q?ZgzroMGzY9J2/MqATWxOFLWmtuoJHF+O4cdZz9WGi5UeRvpgg8q+BLpWzwHi?=
 =?us-ascii?Q?AyJqb/GjcuyXANZsvUUCKN66IcpKyutDjhUmQL0BhUfUIsg5hBzcJhS6Wrq1?=
 =?us-ascii?Q?Z0sdFWxBuL7tJb9M0RQfZRi4i6hWAUpKzHE3+Kt8Oi2W9TDiYzVKhBb+Hef8?=
 =?us-ascii?Q?ucZxImCqBkeCnF5z0gmTk9kkyKYlvwOY+Ms/7vrwRkC3pjuAlgdcg/RZmS/1?=
 =?us-ascii?Q?vqbfiO7JWL6BxUfvJHvnmq5X4G9eCdVDXmdG9EIE3qEwNTx3EV2BeRn7pdZn?=
 =?us-ascii?Q?5wgO6j0eTZG0iPmrn8+fOX9zUhMf+G54OuZ0bCpPFvoFgRvsmMLS9gJMXd/4?=
 =?us-ascii?Q?Tn5g75Z0PQ2a4U/yGa1Idg4iFN3gyzjsJIdOA2QcVMbz3i4PebF0V92CnBI7?=
 =?us-ascii?Q?UXZsfk62uQSyJujj39GnieASa1fhRkuUc4pld9skKqM6N7mGhKqSkjKqLO3j?=
 =?us-ascii?Q?pwNty2AzUFXJloHCnQOUBq3P/xoKa/qZPD3Cx9z56ti5P0fZ5H/G32MeiLN3?=
 =?us-ascii?Q?zaxhHObj1jQ4U8PceSClppmrH0M6DjDrmDn7JNfX+jjUcuJdtg+1MI8/BZFy?=
 =?us-ascii?Q?48ajVBEJqwrkEnkxb2azZlJJ6kBxnaWFJIcaYikajy/8u+7j1H5QdXDFEWag?=
 =?us-ascii?Q?RxWuP8u/xIJ+oI3EJGvAv6KIh192y/DqAzBUBYicDr0kBN4yUck4FcGxPVLH?=
 =?us-ascii?Q?0/qMHnoW1r6ektCzEEwn2TadKkBYwQdZnzhN5nx2m+xR1LmaMgIcSLWSehY3?=
 =?us-ascii?Q?nDc0QIH84KYaM0ADPIa7vL3CfVGr6rxOoVMyyOhMpcI42V0JXf3YDgEYQwan?=
 =?us-ascii?Q?TgUA3akcOAnzzng0iQel9DBjd0z9WI+VCIwcd3ePjjj6PzuuvIVsqM0eiOCk?=
 =?us-ascii?Q?keZlpmI9Pw63MuOx1VQ06qOPth0a8MHjQJAvEBV6CldfBFRhNya/gI3ZhZWB?=
 =?us-ascii?Q?Vkg3k5BhWRrbd8ahtoPz7FaQ6MB1wwNg2uFegtLWX0jIDMYUFzLZpoYvN3eZ?=
 =?us-ascii?Q?2RXkmhBVOXRPaC1b/AZOJfoe8hgV83iZicBdJmJgWEQ/hIUZa4PhRJZzXYRN?=
 =?us-ascii?Q?jGaSC33dh5dFhqKT2FNXRvBYWm/1/OFbW8TnIiR8n1V5qYyFIq9YF3QqfJdm?=
 =?us-ascii?Q?SVxQe5yiOIXXp+GYL07ZrX6hPxT9oYtXAE6vgGUqI8NVEaSBHo5azJe5d4E4?=
 =?us-ascii?Q?qZfPtA7iz1QDGRJQ7hbm/9PspAnPJaT+DRSYWxpL3Mf+hNX78RxZm8TNZKM5?=
 =?us-ascii?Q?dFnXDtKmUf+SrX+nHW4L5wToGuwZu/ffAHpwPJqwGlq+4HGC?=
X-Exchange-RoutingPolicyChecked:
 jE2djvrc9UT7+oNnm3bQMwYG+kyRh2/RpLezWk5dE/psSbGi/jOVRRay+wIfoC4Dyu6MKlBoCCyRg70aacdNd0p4mltwG1NAJ1aP99Z9ldP6fa1dbCX0fD2UZrOqcO3AzUJZUNsU9KJiK7LrCQx3SteH/dWIjuEZI4Nh8d9j1XJ6gJyKkNjY0P5aQAoDLMoOnDiDQl7saM9/ifpa2bUSnpHm71LCXaR21w1wlk5n0AGl1hVkzbZ6T8Q4NS+GEfhLG3nR3SOcCLUzDJStuNeSOVujZCEDvGMeXV35M9Q+e53fyDbxFRiCjeW9SBxrw1Q5x8ByR1vgi8OY7wKFH8LCKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd179d8-186c-4507-7dc8-08def280e812
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:34:19.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKpPWg33p7uMjJZYn49Ws2nrA/DGl6SU8uH/Nh1ra+YZnSuZtRifRDIQXhm2QfCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-OriginatorOrg: opengear.com
X-BESS-ID: 1785888660-105811-23583-21893-1
X-BESS-VER: 2019.3_20260804.2013
X-BESS-Apparent-Source-IP: 52.101.201.135
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhmZAVgZQ0MTQ3CIpxTTJKD
	nZyCg1McXI2DIt0cjI1MDM2NAgJdlQqTYWAD8yPqZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275152 [from 
	cloudscan10-57.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
carries the host serial control lines (DTR/RTS) to the modem; it is not
Sierra-specific. It was not enumerated for any device in pci_generic, so
the host had no way to drive those signals.

Enumerate it in the Sierra em919x channel config (shared by the EM919x
and EM929x) using the control event ring. This is the device the change
was tested against; other Qualcomm modem configs that expose IP_CTRL can
enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
it is device-agnostic and binds purely by channel name.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
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

