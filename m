Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23B3AFD19
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747676; cv=fail; b=WMz20hMkdngDRATJNGZea8+LZKvw3MBSoeEDhTTmOBKYPwS3jVuqCAp4m+jkgrk2t2RCsJ2w2czpfcacEQUB9dashSb9g/bFBMHW8JHlap5uKO3bys869kE9azn8tRVD2Sy4XO+Tbr91P4+NFCbOTsp8CknkFxZoYw4Otb2SSl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747676; c=relaxed/simple;
	bh=cvJeP/wQg0NsfcUjfCADyj8GqNQgC4//t6HwiPc4GSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaCNOGJqiDPLURwaaY1idY0M8No1vKuDLgaNJymi7z6uc1wHlphdKdNmX4NtHS7ieZtZjo7N07H+Lx7FXHJ/o0WeKnjzWJAwfLQJ8ygVsCXaD4AjqHCZ2mmqQKHR6CTNi69DdOyLkC6SUAF+xLRnv93AY8px+emDaNOfKr98lBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugos3IkX; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugos3IkX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+iOkih7+1XbAxmgXCx55OcmGBJTg0xrOS9aJWFveoXeM+N4qQUYPuu7Gft2bE4UlO6xbctvBuEI2wfE7UU2Mdo8C5tuReUTf5J7shj4WwFP6lrJwEakHWmbDWfrqehzIduGzxEQv9SvlrpMgemiClsy6GyiOl5LbNo9NmoF/nqhuJ260w3zut9ikYdr156FR8Wa4dFiIF+6IYQ5JAiPVrFkWUivUDGBDYrd05ePn2eW6Phr4tQMpq0C1Do/UxCjkrIBhllstsqXtZAGDuAjgHcaIiiG6XCejO+fSBT7uEcDluwAXEdSj+alSV300OGtKV23dJqS0T7JjfliiIHbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qRgX3V5ajGHJI//9n0a2DlxG9nDbUrhJ0Fe/tV0dNA=;
 b=uDvJdsxzNDnf8HuNC11uoF6IMlcmi26XDZrMc9Ud4wqO4eXSFwu+8r3x3exypcT3eGV8anWRjPX1VnnP1eniAIHGgkx/r9WLNL1djejBjiU8Bsjg/rD3+E7v1sui2IjJt6AZhcI3mB8pDCQrugXREEsKtpOThEp+lVZ5092Z2vyaUF15J2hwViloZ7c0u9hPalnqbf/Dg7tL1SEU5zGBvjFailvGN1TmJTkDYOd/dJ2afVW6jypuPyLOPJJGzZIwnmZs7Q5YQkMVb4/6xWdvvvrf5FOOi3YGEugINu2m4/pK5ePBiwKK/TyHbDPfVktwei9SelOxfYbw+NvHQuEXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qRgX3V5ajGHJI//9n0a2DlxG9nDbUrhJ0Fe/tV0dNA=;
 b=ugos3IkX47vtdUlkt7N/Ocw6ThSiI+RwEjqpok11FgDuxyUcs0X6LufiWQfDc5jeuUGemBIg6RkGwLI/XpW2TZzCKRgw5zdXuZzgUiDFcWBXwZ0X/HWYvhKREBNvw/JFOrj1kWWj6dC6ukOF2rjdpamJItc6twI5NEGdfV+7pJ6dwsI0lbG0YDyVueVqW4qyaipxXpmxN1sTzNKpWojx3RU5nPwsoWWYj0DpXKe4Qunuo9/A9eRPZSs0IoThb/d0lGjijYDQ8xvb/ZhVcFHtExrbZLgqV+UrdLJI/PcmXhsUgmHCLPRn2z40Pw8SzSAyzal8IvWCeHIhIy8g3vMaug==
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 09:01:11 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::66) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Mon, 3
 Aug 2026 09:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 09:01:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 02:00:50 -0700
Received: from nps-server-23.mtl.nbulabs.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 02:00:46 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: Shay Drory <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net] devlink: Expose external flag for PCI SF ports
Date: Mon, 3 Aug 2026 12:00:12 +0300
Message-ID: <20260803090012.257242-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2394f4cf-4e72-41bc-5dfe-08def13dc3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SP+OJtYwfApcE5LnrX0gG+VW3LVNPe1r3TkBs2etav7WN6YM8Q/TRwfkI5PVw/xwiCa3JLnXCGUKho9xDb0H1f7yuoHtFJpL2eZfWbl2fTQmukfptPeHB0TghW1SH3rhJO7KJB9SdUSfoFd9aI25oe6X6pdUg2qccHsneSR+/nEZQYpu4IKuMG8pMElQJ/GB1cIc2vZSJxMG0amLsWPb4nhZ2w5GWOCqS6eZZ/ozDD9rmhwzuGoy5KtxgKFLuzJqXlN8p9XUWkSenRlv0pjulmU9ePkOSGa1ExMnvKeeULRXulleE88sXye8T7eygxxswEj1AY6Q8etZdjfL5JkjYOi+bVjN/HsCWn4+p+VfJXwPcMy4RKybiMSKxEhFCaDs9CP6BZRIXh5PQx4GFLAySBSONelPH/9co0k6Tu/RNlweZpVw16UMgKgo/a/Eer/Dj/APqwReVCDaqLIQ4XJcdLKDJTZuP+Yt1tjQdl96nHmFkrsUDoN+PdNdYKjVOVCWucHtxWAI0LhT15k17jAaVvoNfi+AIF9dqjVyslDWaJDKyFnsV8jNczPp9BJ+m2tZi4dpsHCi/4+arohbtGxw1f3OzeKrA4AiC40VST324cZ1BJdYhCCH+zpdFUQYDwLXcD5ajte9FMov0+OyapTz8FXnm1aqQZ/0hE3O+gR5trspRM8VAvnV5I1HUnebbihS7g+7pHxP25WOKpIS4HDZvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fZfTFfVFIrQh0pYuZmqA1zGb/THzouJPcw1zoLDOEzeOvOOqRSz3Gh1wycLTMJKgAGURXjsJlh7TBSIIDWvg1MunzoUEiQwgA6zcEsvEWp4rqBwAzjWcLo3Du18AKS84EBUVDmeX3PCdfXb+skt7PqAP+lj3OX4Ef6GXKCxKPsFyXfXs/btXHWZRxy0ajMGSYczpCL1lq7EjzeT+iE4ymtxqAszSlmeuapDSRdATp3AXSmhsvTs27KIjWGej6E65071MggA6H03ts24az/oPXiCCY+IHAHgDuJrjUyLK87FLqpj8pmx46gZfBL6bK5M8huq8YCKcDB2i1o/6TI7Wvvm850bjBxQygcenmNQ2T6EyubJaMhSEe4q0OV+GkDl0HCsc5OIhLScdatsrdAXzijYfJ4mrazpd27c4NXc7jwGC7PYOkhgHkR/DjBsCg4Jm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:01:10.9280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2394f4cf-4e72-41bc-5dfe-08def13dc3a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

The external flag is part of the PCI SF port attributes, but unlike the
PCI PF and PCI VF flavours it was never filled into the port dump, so
userspace could not query it directly.

Reporting of the external flag was missed for SF ports. Hence, put
DEVLINK_ATTR_PORT_EXTERNAL for the PCI SF flavour as well, matching what
PCI PF and PCI VF ports already report.

$ devlink port show pci/0033:01:00.0/163840
 pci/0033:01:00.0/163840: type eth netdev eth1 flavour pcisf controller 1 pfnum 0 sfnum 77 external true splittable false

Fixes: a1ab3e4554b5 ("devlink: Extend SF port attributes to have external attribute")
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 net/devlink/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index dc82cac68e7d..1528f2d148df 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -267,6 +267,8 @@ static int devlink_nl_port_attrs_put(struct sk_buff *msg,
 		    nla_put_u32(msg, DEVLINK_ATTR_PORT_PCI_SF_NUMBER,
 				attrs->pci_sf.sf))
 			return -EMSGSIZE;
+		if (nla_put_u8(msg, DEVLINK_ATTR_PORT_EXTERNAL, attrs->pci_sf.external))
+			return -EMSGSIZE;
 		break;
 	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
 	case DEVLINK_PORT_FLAVOUR_CPU:
-- 
2.38.1

