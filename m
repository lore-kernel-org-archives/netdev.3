Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07422384CD1;
	Tue, 15 Sep 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454022; cv=fail; b=AIt8IEhike3/H36EWHOwR4l/mSMbxafEjtzbye5jOxzMP+DxrPyqmzPM0wndUTY6n0InE+xvJ/k8jyG7Mh6Sq2x8xV3cHKsD6GidQx30IbwMWE7ZsXiZy4FkRt57wO/IRQVqXZ3N+T+KPFbkjyIXGwInJv0u5tg7bZC35YOo14g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454022; c=relaxed/simple;
	bh=s0ee0RznO+uqKuCSPd0s6TpVQKZhd7XNIp0UdYY8Mg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eR0vMzJEyAUoUSNlPtyWBCzhuWOogrpVB3d/kWBDSm13kq6rYOlcifn+14StTqGbQJjSSXsmJxB4PoxtFYmLOef20K3qcSdfiQcJsljTj4xw1B/UP1EiX5gU0q8PveB5W+VZSAQOgVhSvdjGcXJG22w5ti9hYL/YLJ6usy3caWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lXQRNSqT; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RAiOULt4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lXQRNSqT";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RAiOULt4"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2lqE23069382;
	Tue, 15 Sep 2026 01:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=K9Wu9UdYHmag8
	XbRBGQYuqda1SR+iPCK11C1Ly5POeI=; b=lXQRNSqTKUIwJdOhTgjgX8m4nsHU4
	SDIK0+bri2kPWj8koCpadxARd1LMBclzKs50Ru+L9zZavibBYk1zPOcFGc82lESB
	FePIDZY5hK3ihMTDNcLF26PlmDRxBR4B91QeeVF+P27z8G209GvUKYGH/hUvXy8c
	72NjJBZLi+Fxb1fYQ0dTTnPD06pJCYOiCagHkVfuaEbMHEoLsl4RqZG2UPt3XC1Y
	ZTk3ioISSdFf1icJcOnbo1Lo7yCpAyYAXw/+G11HOX+7hB9BPiRKKi54L2NnNB5H
	9LGY8vVkgwVK/qw1vTsCkUpUuBW+JnnUSPirN80qkSFXsg1qPBaMxZn8Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gppxsk5na-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 01:31:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/Z6NaH/KcNjDgNf//W1MolcDDRg3uZDLgsIkslCZNqB8bhgbvkUaw6KUP362bRLjQmD4bE3eK/kcCMo8Sm3gS/JWplntdf5/jjCnh+PDgsu22TSsMNTk7/0en1xTI8jj3SYXGYVm4dWB0eegu+Thz2m8b7rrT706fyqkOSRNLfyJSqaawwIlJrQgLLtouRWbd9C0CvMGc7C5+KWYDfTnBTZUcMw9M9jZNfIoIvZIrJ0Pdcfz+YwGgnJXLABjJwUZQtGA+Buj8CSZuWQTaju+27k4okh2VqjkABdHROx0HNJ0BfjaiO+p54X0QaSKrwssphXUjYFP4MZ+v5fxc4cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9Wu9UdYHmag8XbRBGQYuqda1SR+iPCK11C1Ly5POeI=;
 b=ImGXkuIpxIxw6TNHiqvrvRhykQeM+WeSCUIzM9GC1ydZZ0fkd/90/j0f9EdH/0vJMzggh96yYMibeRpGnN9frrjwqJ2M26WBR3PWIxDIxnXBn8j0Nfz653bFbauUyn83uVIQ40m5lghbsUsuwgFxIpTv5idNn71XmimOUD4lcdJigcIZCyk7utd+o19raMB+z7I1lry4dnzaI0a7JiFcZsKw8qkRI0lnYR614bH7L1v19rovk5hr1Hvfhdzvn+j0TThIKJjqMn8xhMmS3gHWlWGi0NxotdpvxYcli8BnJbPfcd52ZuyPS9tD0yx4Zqwy2mNe1qR8htx2HxW/guZyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9Wu9UdYHmag8XbRBGQYuqda1SR+iPCK11C1Ly5POeI=;
 b=RAiOULt4Gw6TYAprQGkj16swYZxsKLqwurRotKoH3bQaC1OV7+d6PmIvXm9vMrWhTajKmU78U6ZoTPmdizR0GFV+c3yXXMY7mBGDkij3eFhOhlgctO6udXXmLjecOAiFqRMSZ/nYx2PkhfpB9+KxU8iCE/dGrkYKJ0eHvsN988I=
Received: from PH8PR02CA0038.namprd02.prod.outlook.com (2603:10b6:510:2da::10)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 06:31:38 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::4f) by PH8PR02CA0038.outlook.office365.com
 (2603:10b6:510:2da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 06:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:31:36 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:30:57 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:30:57 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:30:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6UvNu507778;
	Tue, 15 Sep 2026 01:30:57 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68F6Uu4Y013689;
	Tue, 15 Sep 2026 01:30:56 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <philippe.schenker@impulsing.ch>,
        <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
        <devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <arnd@arndb.de>, <afd@ti.com>,
        <parvathi@couthit.com>, <basharath@couthit.com>,
        <vladimir.oltean@nxp.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: [PATCH net-next v8 0/2] Add Frame Preemption MAC Merge support for ICSSG
Date: Tue, 15 Sep 2026 12:00:50 +0530
Message-ID: <20260915063052.2274986-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 733d018c-aaf0-42ff-cca6-08df12f2fe5c
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|56012099006|3023799007|10067099003|13003099007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	kMM6RlzDUv89PaV8prCQebK349i2HFk+ky2cYQZC0N5O4RqOgvP7o+3/VM27YCo1EMw1NKP2gHsnhn+oT0eMgDNW85WmESue5XwsIYwqxYiirBy+ftZ4Hla6GVE9gBAXVfusCPqOqCBNtnekFHq7ODwxhTdU57+rC1HTfcSlP55epki5SIQtqsO4w/K67Tyae85QM9zLWgQ05PYZZ9uHzBi9JQJlYt8EQ3SEiWm1T1/nwgoRwkRFyVLwsfRDM93bMkSeqK3ixG2EJbOo8AzCDjpuabc+xBWOqzM50mFFlCCSFPWAyxSekJBcb9aNY7CBPAOMUQYbNQ4pEvjyeOTItva5f6jEgsEBEgTe7/A/QYagAmHsFqzD+Ff9dhsTAejcVpmN3yuoDmrfMpGoiS33eTjmDKsuJO4jty8hdwiXsNiHHVgmxHC3uaHYxav2u5AbHSGb9yIb1E1PpjnTV4X98lVO/3aem/6sCj6m3v8xyz0q+NtFFs5xj/H6gLcklRTxeZZbFgKWHmVsvK1flpO2kbjW/LymYYXs3y/L9tnSHBcFNL+6BBhDhDtkfi90oPJF96mZb9TQFXvCFoU5WCmUwoXTBrl64e1nNgyPLX4BFDtMq5Z5E7s1BOQUhDNTWDYUX5ucm+W3z9mr0C+8WNnJEYPqtIodBwp7fd1i+E0W2QudkEw5ExiFJ8w5dBjg0gb7LQLEI/wQMz9TCYeNXr3vLjyr9ApBIbaeYHiSsUYPAbf37DZDukhT1mGdMPnk4Vjk
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(3023799007)(10067099003)(13003099007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H4cB1lCbkws301isVJqMmNiC3gC3FZrVi7r53RBcH/4PeZ149F6n76jbmXYLQ9fOM0s77SJD/GnpW/T0kszTmSJ2a6ZzZqF0Nu5JCaaos/NfMcgwciNs6AdmQxfzBOALF1dDcw/S6sQungjr6uEDIc33SHxor/wcdoHxnHs3ev6j3Ib+maJF1X+kuEfDiK42SRpeh5CUcylKEKLNZgxZJS3q2x20+rSBT/TCwYhIY7ZufXPs0Se4YSfjnTnGi1mw/+D7bIwzzua559EGuFFH3bH1WHKpYhtqEKqEANUpVRdTsWHt8TLsth77LsH64HBzEPgkv8vHDQnhFvH9cMfEXtSdq8x6XPAgk+6f6wOi8MDcs5EJ2QtiyoAr4yAXwuQeC5oQwQ/jlYt6TfM+l1rv/LASRrKEkZ3GpTOwo/Rx0c23E495jDFI8hcU89STL9C1
X-Exchange-RoutingPolicyChecked:
	r2G7bnyxHGyTv9psgrEVS/VPsO/62Vhk0HQXawXAuc+4IUDOKPQrMe8e8s7154XHkFb5FmjYtIOFdddZqeNnc3HTmAWSBgRxWIcDIb30isnokoMDWfs+2CODXVSzNMhuXkyNfpCiSq8NVjn80zAqeWFl5pZhx9xzUZbbpGMgjpCU3IhZxahwpKTL9ZUjkzEPXP5OUIqv8Ql7/uN+SdmM8UAuC8Nc3JBvjnymbbKYX+LJGyXz3lRP39GRHcm3fUfqsjJr9vcSADXX9Hflxm8lNQ3cuwDSr7tTdR5pHSB6iR0tg+7UZGBSzDcGk/68tc+st4EYg28cYhnfq74JSrtcxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:31:36.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d018c-aaf0-42ff-cca6-08df12f2fe5c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-GUID: 3LPg1WWp3KeasyDWZmWjmbRS_w5LDgw2
X-Proofpoint-ORIG-GUID: 3LPg1WWp3KeasyDWZmWjmbRS_w5LDgw2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX8Vf4XraD6a+Z
 LB9BXHI433WDSEev7GThaKrsQcVsO7eRVwsRwIqN6irURGt10SW874RtMIl/4IPN2dHJpvLT8fn
 W/Kw7D+U9fyHtXI/yEiAVFZbDUuLduXwC+ShbBSUbsR47w6vzMiamENGFnScT41hZji4kncaow2
 +m3pIAr3DGv+iCxgVCyohFI2H6aA+jHlGX6Mr4sOWV5Nr+hwBtbduSc87JJnrp9gp23FpIJPBNc
 EmeagXl9+7NL7uu4gbFzlKiOMYDunOjEr5I/epMFe+GmTrBjIogkrfm/6ziY7o/MLz9wm9gmSps
 H2s5l2XJ4gnS7WyLMVFviIHBCYL8l/gPIJG2bT10NYsW1ScCluVB5Yg1HPHpNLj8y6qc4yxpMGe
 viGsKivoMsxW3MhPaavni+joedOxleMTlAzQzGL73BDMwBNSb0k9vS+nN1ZL2pxbHwyWuz458OF
 SO+zY1Z5lsBFaYB/l3g==
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aa8e64f cx=c_pps
 a=j0PM1b0aAxJgDjDzr34Dzg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=1Bw7fkigwWfXGVEehwMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX22tgigu3O1Zs
 KxYbj8pdSVL1BQ7Bb2/L7LAKL8lC2QmDZMPbjIj+PUsHVGKQWeDCDjzgBzsk9QeX26I6W1fUKkr
 kYAykb6m5oShXbd1f4vLnKYeklEpnrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150091

This patch series adds QoS support to the ICSSG PRUETH driver.
The first patch implements mqprio qdisc handling and TC offload hooks
so userspace can request TC mappings and queue counts.

It also integrates a driver-side mechanism to program the firmware
with the IET/FPE preemption mask and to kick the firmware verify state
machine when frame preemption is enabled. The second patch adds ethtool
perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
.set_mm and .get_mm_stats so admins can view and change MAC Merge
parameters and retrieve preemption statistics.

v7: https://lore.kernel.org/all/20260610052511.781752-1-m-malladi@ti.com/

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
  net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   9 -
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 132 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  21 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 305 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  68 ++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  84 ++---
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 11 files changed, 580 insertions(+), 62 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: 272a65db243bfa34b9277632830e0e06d7e3518e
-- 
2.43.0

