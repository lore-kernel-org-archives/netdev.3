Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC937C0F0;
	Wed, 19 Aug 2026 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179841; cv=fail; b=AWao0ZAvRXfdRX5r38ZSN+4n5sJvl6V+yow6FtqTyb02a5HKOpK7z5bledtAzT1a/hn0PVN8DJPvPRbTaPESHtqagPVtierY56Ov9x5NTrEWmpRtM4zdNn//fZFIOgxDemnY0nnKXxpmvmwcHMvsMZc2kGyv7vY3PrqR4vKn+LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179841; c=relaxed/simple;
	bh=u93SNrTMn4CJJV96DjzPeLStUn/ITc2Ysan8oGx9KU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4MJsYKlXzfbEFcudRqdnbzOOeLPmG0vgLfTd/G3qaCjkL6cw57YmfThfdkuHRC6xtubLFUgXZBGTJTEaoxOCbTfJ01H7BltHOSwzQOs57tAehiorceEA47E0lYShtsUekTtUB6s7mXzQbrBrm32eRUrdyZvHlzwag6r9MCtOv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=u0+7FGai; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="u0+7FGai"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91]) by mx-outbound45-182.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Aug 2026 22:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfBxNnCtjEjF6MOEhhpd32Pb2/IZI7UHMZhuUOtBW93LRQ8EPqfh/ukpW4FWHXIniY17VsceY0hixHVDd1dhZkkwryEcgPhGWDWg6H9PJohzWUrUaKvaqEd6rw/2fOMJtdOI4bIhbqbXo9g6RQEj0/8VNRLgx9G4txSFXvrV2nXxYp5ChBvjFvo5eh28Ku9Te7M9SfmJF4P3PeCXS2UbO8tFH9sFyXI8qBOp5t9VeLUFaro2JDaS3BL29UNtpjwhkFIeP+M96fyfs/JopU8L6RCNQJZSgcR3zulqxHafsk0JOtPVeLT/1gYIJkVjZzxMPMqVEbI+sOpuK/81F4PYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C7RHkTpueYXBPHTENGAAGc/YYe2DIvzg7BFsajkn+A=;
 b=nBnbUdc7OGX/NkNpleehVFlm7aiZ1odCTFWBVsemRrF2plMiyY5beV1WKJlM/DOZ+Pq8psgId+qshng+TyCplS5PnMiPLi4W0qFtxyFocp8yX++3jQEPDNgPuDQ4x1XVulYjNm4vk1mNzGQLW47GS6TYH5S+UqUfmtowiZaGe0FGvaeiIs/1lRaL7551JfV0g2We9uHNOqSmsrrAYo9Y2QaINhGgxUr8xbaU5puPIqCGp1jP0S/2x7MyL2cCSYnVTptv5RsVwp1Ke5BsWeI7TC1P7suI8IN6B2FR88fenLqxGdMC80ha0OriQj3pZnD1CbdQwtsZAVQb/HGPq0qzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C7RHkTpueYXBPHTENGAAGc/YYe2DIvzg7BFsajkn+A=;
 b=u0+7FGaiYfCjo+Ct8xJh9Zps0tIRIqdmBwUgnC35BdIoom4m55dRdg26EFOhrLPtY28UhuHezqghUbTNOYEZUB2fjEwRqr8iytCaEAJxOXoscwTz9PWOCpCpKEUcAyNHe2Yv/GxDJrV+AS0mWbAvzl/IGDf9qyfjqxlEN/iCE5n8xd0vPCByNMnNiM7a02fMf51382mraKVlv3kUXGgMDlKqdS/KpKLdMpVXanbKpQlCCr5WvwiJuma9XtuNxD+hiR4oLxg4qGy8icdFtA8agJWDrhTeYldcvf7L5tNh8SpUsGSJtdWSVDxza8LJGYMJJinw7PL6qSPU4bNrqGoLcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:49:46 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 22:49:46 +0000
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
Subject: [PATCH net-next v5 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Thu, 20 Aug 2026 08:49:26 +1000
Message-ID: <20260819224927.2274790-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819224927.2274790-1-peter.hunt@opengear.com>
References: <20260819224927.2274790-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0144.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::14) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: b93646d3-36d2-4fc8-05b2-08defe442aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bh88sxe34QBGjSyMs2qgT6Vf3zTTayAB8KyyjCPjJ4j4T5hU6I7Et/D5WDw+8b2nvxyMfAXxihoxi7LY64w4iFhfJ6He58pw7f9OrhnoSyA01NCfW4bgyEDs1QvLXgrvuKFcJIr293T/i6RQJpl+sbeFu+14+l9EY8L8Xu7SbeIu5ux7Q15rqxvhLiQWQmL0RfiKFjp0BiDIkwxA+b7tthl14G+lJTx0TZF/vXdgph0CMCKQtOlZaoJm4D9KaCuKnpn9WnIlMcKBh8QQ0pNcaA1PB/eeWwNyGtIltIVduBILogTii/wByV80TCix/o6RiKIQ4PYB16Bd6ZswT7gCzXvmwNKmdhQpJz6B3/gaGfbnaJngxBcbzjhGmLmgyv0NA5HYZIxj7XAvYJFUyjPoyDBRdQNMNPUsrHUNLGLcFdfZMCrOLoKO7K5dbQXjatPanFG3nYxlE+/Z1H7Q09qg0pVtkvyVv8k/ThE7KJfZW44f4tS0msMJMiVjmr9CJCJQc+1M24TqsaFEkjDOQeGC2X6g0faMjoOw2K6DffiheIBa+vfFZoRbQ+fdWlhQE2/Xchmig+9hLni2czVBoraGfemJK0QgpOKJCoVtZzuvWHY3Ot7PYPtmdhNjtaUPsjBtxmWBqMCGKfD2IS1KMttDPjWRUCUwhzGO76Rv0eFSvoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qnHyKVpFfFQ+BUlSnfrUqwRLfhNO8t/+b6bDXcYEZ1cm/parAUx6OswttBSe?=
 =?us-ascii?Q?opDPoSG/8cdtobXLWWifC8yN9IyJeBwXrQMjl41zj6FvQsNXhVpcz22Cr/ti?=
 =?us-ascii?Q?SI3MisNF0qJxLDolm3NNhWl2nyfEEf+vVhha4iNskK5p41Dxafkb3t7Uhne4?=
 =?us-ascii?Q?N783iGJ9TKI0R9+/2U1nWAr7MsAA1rTkpy+zY6OfS+YAfFlbU/0+2/I4OdQz?=
 =?us-ascii?Q?TdN1LCmD2Sn6utcY8yPjxyz1uoRl3KDLymfG4y9pKBq6eHPslO5FrEHiHj0v?=
 =?us-ascii?Q?pAfjbTfDkjW6AP9HjOj2P2C6bpjLYEa32s3rNhwbUoxK/4H6zmM0D3Kd7Rf+?=
 =?us-ascii?Q?kiLXxyEdUutxPBrHJRw3ebmPCr+f06Up7VhKLewNV46vIxLKo8jJWspZ+Uhg?=
 =?us-ascii?Q?k756POzDV7mInxfZPYhtAW//elL4aWJE4G5wtzQUt3ge4uqgZ1FkrGJfbsZt?=
 =?us-ascii?Q?Asj3TMYIp8cjxtw/GYY5LbzZ2He3Lb2dZrUbPbb8poB8mQeuAs3fDdVv+K/E?=
 =?us-ascii?Q?wWTX6mKVo5hgK70nRW0a66K9OCLorfKcCXA6FOPHEy+Vx4yKeKwUP2v6qkhK?=
 =?us-ascii?Q?Igf5+5wvNDpA7OIh/3ke46kKr5JsuFOrah5rEaLZHV1axKfIeb/ekq72XsL3?=
 =?us-ascii?Q?AXzNAW3P7LJrZmlciK2X0UXUDMEn2eqWUGHvjIAGH/QxgDGYYL3/IFL7pnI9?=
 =?us-ascii?Q?zlfDkM6YCLzFf0dhnc3PkU5pZgwfeaSFzpPFtClhGurCvOvrtY1ZfyTLqbi9?=
 =?us-ascii?Q?qFn0IHP37te2z3Y9ffCL/EzYMGLROwVsuOL5isC21ALgNf41aZoNClx34qBA?=
 =?us-ascii?Q?eouCyq45HhlvAO2rh2zHkgxHjG8Eu6AqGjsr4iGss8vRNpqf3923C4QXIm9Q?=
 =?us-ascii?Q?i9XGmede+qDVdAVhtE7bWm4cfrxv0EBeLztEpK0XrSGWhRhPF3ibgGlNS3Bb?=
 =?us-ascii?Q?bxHb97K3qggKl0WYNaGSZ41AR+kY4dHxxTZQ3iYoH0XAhCvImHzabwIsjVzl?=
 =?us-ascii?Q?0JDwxGpQOPxEJkZC3AwdUWGoPajphG4HTgRPY7VFnc85MVm2o9NIe672M1qO?=
 =?us-ascii?Q?afp8y5NxPaToFmZfReojNsk0pwAvhq4j+rP9z6mY0b5kHVCEV8Mat/YWqJQi?=
 =?us-ascii?Q?rfkE+Qnf4OVIq+fEVGrtRzjSN1YfNVsbvgWGnMYjy7AcP/henRDff+WU3Myt?=
 =?us-ascii?Q?fRCxGiyZiFKdOE6hUP9oEdW6Xp6e4WtquVwjPD9IsZzgRodqd4CAI29Hc0Va?=
 =?us-ascii?Q?ZOhSMN4H1K9MRjxk5OLMJHtUcGCB8URJF1JMRJNu3RnMSA57iljug6xQx3Kj?=
 =?us-ascii?Q?8/HU6RzRiu7TQsI/EqUYz70AhKWiwtanXm9B8SVtGsttnIMAn5GMgxfKL/Lt?=
 =?us-ascii?Q?6+tMTVJ6B7D38mKbHUrCG+IjE5mvhG8L0S20fCKCUIRn5fgrd0YatZKEPTMM?=
 =?us-ascii?Q?00Wm+9zg4oyYhGJlvX8BuNudPQXNa8GymZwHaPbXICoc6gfHRY8CDKuv8V3L?=
 =?us-ascii?Q?Q0J+Hz+q4LV/oIXFBRjPyYO1lmTSEv7M91R1LBbpfApMXB7grPFoCWeVYN0c?=
 =?us-ascii?Q?yQGpJipz1hDn34vT9nGnOqlRaxZ/5rprFpkV7B7BeEEbQ4tIMAOm7pK6e0s4?=
 =?us-ascii?Q?pH+E3nwpt8iCAYI3LQyOoJ9a/ut+lEVeJpzcVvlcMkDIh5R61UHV/Kjg1zjO?=
 =?us-ascii?Q?m2RcgtDTZWm6Moptfnab57zlsg0YPdJMunyZJFSZ5nmyHCpM?=
X-Exchange-RoutingPolicyChecked:
	RjaUlmb9t7sGfZNKYt5gBi1zVj+V79gR/e8P/Qd6XYhtYa3yQ7PdkdKmcEuVgqxBO8V7BmRcazML5aauKWX0+mDY6bROvwfPcIKTQRHajBhg+7EqRbwjdTVOgHj1peskqB3a22nIE+A29hlecezesavylb8wJDOqcwLIiNHiqXl/0uHSuuuSc7Ci9gr8PJg/3tIYQmpo88yRRsICTQYLacEKut6g28lwvTliU5l96gQcYFeVq7LXB8V9Qlp4n1ciq+V6f2Owd1jUQRQmVzyCGWINH1l9FFlgYnESVfev3MYyOmarJeuaYbtmjjUiDHoIlZaLNWsn+fNsK8T7INuI7Q==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93646d3-36d2-4fc8-05b2-08defe442aaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 22:49:46.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIxF/e54PTjDY0ZM2OqPS94KkudPAFLgQ1GwpG4j7JZwn/bv+SWVyyZiOpsZZCYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-BESS-ID: 1787179775-111702-12581-7781-3
X-BESS-VER: 2019.1_20260817.1854
X-BESS-Apparent-Source-IP: 40.93.196.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamliZAVgZQ0MIgLSnRMiXR3N
	DM2DTNINHY0iw51TItzdjA0iIpzTJNqTYWABMgMgRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275505 [from 
	cloudscan12-166.us-east-2a.ess.aws.cudaops.com]
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

