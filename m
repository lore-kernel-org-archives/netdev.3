Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478974;
	b=OdxT8Q/Uiey7oTU2MoTZEezn0iHLwSXOzJK+9WAqWqSb5/hT81JyTUZcaTc6aRb6T0zF
	 M7pETG3nnycpd9a7JFoIZkfJxuJaHwG6FqGPZ77b741i7PlalExpdbvX1KLvSqMhPzXdf
	 V4fC+llsiQsEsCCDM5zvE1ezXVZkjGzKSRK4jSS4ex4TQlbvWVIu+4xYt9+soj/NuRQeq
	 yvsQfzFqmQqwtLtVKBzO84hmSvu+0NqLHw9bJfWBz7oquQvkY5ZK/dhO7+NWTfVRq4bpr
	 UsfzhKo4F6fA8ifM2U6Q5xGc0312hr7nGNGPDKcem/bu1DOE/rkZTgQxwcdlmLTarDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
	b=uiRdLSdcfnXdYkZK+XHwQvCExZ/B+D/gibWwT+wIkHA5zFQBFpn+8knNC2ssQm6Yi515
	 fiZJ1eA3uoIzbUU48y3LfGRNVR+rbunC2WXF6UzTrGPxhjoh/MbWcLhwjy37UN003fAc9
	 zURKgwumCMApfD2nj6iAKZsglDNAvnzIbwivHqcKOxD9ZfwBNHTGPw+zxdlNjRSrU2LzJ
	 QnqwM7Zaz2tcZd1DyOz44vfzspF4JjvXe51SBnKFE1uSYq6LKkWyCIiOReI/62uu6dUHQ
	 h32Ex/kGzKDSbFGM0sXchnDvbjnMO1d8ZtJK5pghYRDL4DmODVaTBQU9WwukYHAddnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=alaIUi1j;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=MvRslNRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C6606A336;
	Thu, 12 Nov 2026 10:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3C6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=alaIUi1j;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=MvRslNRP
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ACA1h1w2297470;
	Thu, 12 Nov 2026 04:22:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/J
	wc=; b=alaIUi1jRoc4UaLjSAfEaquBwBcfbBqAqilk1Uile15RQNrAvvC5XIeAl
	DYw5ZpzmElsUv4PS0jJEYcUySYSymc/EE5OMYUGItZTpzRzdEFYw4jpWipvXYMTP
	pU/qdHEL5UkLqJ+9uC98DwgwAeMUGX2elhLege8iol8sSSX/1+oRDd1oMdZJW48c
	CRBSuR9mSNc2jcUO/5b8onDHQYwmNvwFMpfAnn4FRZ+UIfvjOHQLEozc0Q53APX0
	1SO4bwZVQ4mDxg9akCfXQ8kNQ+QZ+oq0gNW0BhpxK1xJvOQDMWg1d9aKSobz1EMY
	uxzsBNEdFQf0LBe44rR14jzrKJ6VA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hw7k49jwq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:22:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV3KjcJPOe+9FCJdQadauk6uaBvPelVElKxOmra42SF8u/ZpkEa7MHhX8jORi0Y22Lqu7nJULI9DlMuOq4JGX2HC2wW0/vdyt509Sp9VvtrT9jrQk962ZrcNYMJ40l1es/pexzw0biN+ukJjfxbHh+57HXNnOgM/0D8N4MVl2Ws1UpWMm4e1fPlxYtLz4j5VLahV2Vj3tOY7xw4yMZOPuMtuSMZAkEhtQlWXwQ3H8zmuBlLIxBxiWt/4lff5CDP1jqvIlxlpwL84BtVe6fuQ8nWDXnAL5wd9vRunagH+e5cIRQmLkOCjFeeGQk1Re/P1EcEV8Sz9v9/GQN6OSVNmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
 b=VoK0tfPNM3oM7nUf696D0WS9pu3+VVuEgmoNJKlvXEZiW6qgLhy/+VZPfJNPO8ClxI89bUric2Ppig6MDjkN4LB+insmw1WshqzKPnT9JmcFlGvRM+vvpQZQLBXMFrJypmwjYZpH2YQhTfWFiII7yttgpUYLBWXvMMetWCYXI99q+Qnr6pySrYm/4JRKk2c8sgM1S0NMttbusm3erObepPr9rc3CNiLoQvdJtiJOrNK2xlqfwZsMonv1uoegw/MfrRiQVt5Q7ifcBMht9ktqMruEOwGg67PWHuOqAPcIRVNzz68HvnLoC3EUWWVT2sXU0DmaHSM/Tlx0kdbBDYKsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+OXF9VL0IiKcmb75y51nGMUNWN4hcn/DxnM04i/Jwc=;
 b=MvRslNRPjQUYlRWIkRNHV6Jgy1yYqyJgunc9CIVEjpsn/Id5s3HitdZhKxY4C91AgjBPshu/Pg7pjiBpYJrJvHdTttl2bvPskUBYB3Sh4lFuF5QUk8uh/UYULx9tkXNgAtH24NXkDZcnpK8v7uk8dj1HdsgtuhBt2xgVcvKNbco=
Received: from CY3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:fb::12)
 by DM3PPF35F036B4F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Thu, 12 Nov
 2026 10:22:34 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:930:fb:cafe::9) by CY3P220CA0012.outlook.office365.com
 (2603:10b6:930:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 10:22:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 10:22:32 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:52 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 04:21:51 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 12 Nov 2026 04:21:51 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ACALpLX3612463;
	Thu, 12 Nov 2026 04:21:51 -0600
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6ACALoce018516;
	Thu, 12 Nov 2026 04:21:51 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
        <philippe.schenker@impulsing.ch>, <devnexen@gmail.com>,
        <horms@kernel.org>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>
Subject: [PATCH net v3 RESEND 2/3] net: ti: icssg-prueth: Fix phylib stop/start in emac_restart
Date: Thu, 12 Nov 2026 15:51:39 +0530
Message-ID: <20261112102140.2744508-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112102140.2744508-1-m-malladi@ti.com>
References: <20261112102140.2744508-1-m-malladi@ti.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|DM3PPF35F036B4F:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a465de-e214-4276-f233-08df40a6dcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|261102123227099003|22082099003|3023799007|921020|18002099003|261021121427099003|261026140227099003|261028144727099003|261009223027099003|56012099006|10067099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	qGzV5aazkqOAs2g3aKYKimBe8rDtX0HiYc4L95YXsyElW1Jg33xu8pJQE1hrdZ8iNkMm685bx3Nd+cIaw0mKXmjPNZePeXlIqABbF9aruH6AISw//tiP4Ci4c63BdNNX+KAt0alF+GZLBytWrMzQZ5KZkp4AaCmVJZHk1tY8cjBfcjm4PjiWBiZDamdhjg0P0T67YOIfZqN3YwVgRC6LvFBcuiWFcxug5xrByPVJdlq7plzUMuXKKPb9X2oGbbpLKDdoqpDLK/lNRHwIPvy6SaGs1kDfUhkFwtU1v8ivGiuXrzBCzaOjfOwNTUyZN9cRfKNdD/Oj7SS4h3Sn9PNYRJ4sPHJIEOFIYOaEtg7wITh2bYWBndPqWU97kB09jeUuf6lcKuYftbndBELebc3LOnnEhofDo5qhio4wBPJcIs3i45i4CTq0WNHmhoI2i+AiwfQq7RDAWsio130XT7DLk4UC0vLqbNIU1dSNIp8F3Yp9xZjIKkaIhnDjtcVAKMenat+3VgfMSCJeD1uhs93UjTPQXut9LyxOVUutwYvdaJfbumYTLCi63gCWWW/JbfVFikDlhf3YI4nta6V+gzK4YA8N/nvyQHN2qvTOGzV+JOK7Xyx49GoQjZ2PtMgnp5ieknimv9mcNQ3Vc4X6DTSSFQ1geWdPIAJSHgu8IfS/fDtLXINSfxYgr+I827Q79wSx8Tix1G8nL5smOMDCFyGgAIy/iQF0q4eCE8prDZuhIEDelFGkVM2vPVJGJZCrp1ze
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(261102123227099003)(22082099003)(3023799007)(921020)(18002099003)(261021121427099003)(261026140227099003)(261028144727099003)(261009223027099003)(56012099006)(10067099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W1YAXuR2EZRYrv71CWqUYmfguiEm/Lu0DksycK7Di0Apmw3tAd6peKHtWWsegKh9wss5q9rQGPwvcHHuTetUafS+lBGk4X71auLWvZ8I/C7ynGI1MgldvN4cxssjleP2eWNS+rhqrXMqq+CL7L/URE20DvGIV/y9O6T+/o4v/OOCiRzFtF9RPZw16aiQfS8iDuw+SmbLYzXRzXXmQ4/S0lF5zpZFM1y+4bcr2+/rdPbBCJJQ6EVG6EvHpWjm9Vj7PflBX4I8jpZUG8nPztjQBlL2D7G2dLERz6iIZCqoxs4WGeAnP23zMSJZSOUczM9svazzlXJenux0chVMDC3lFnmgGo8iY/BoXeWh9+Vecw1Y+co9zwjmZZd2VSv00tAnjDSxQJmh+Mq7h/i7C2hCSEi3TGNnYMCwt+0WSD0+/zqX3z8cS7yxVtOnJrSODpBv
X-Exchange-RoutingPolicyChecked:
	AeIRJmh6XZpoRgepEjcEy1aDzc5hsgA7rX6rae4AKl5UL3Njhc8w/rk9/E4kRbQFSGetw6MahmmuG7bH7x2P5ulh1F4HSzMFDaQBRHbetNwYLdK7TIEbis5nELSXMYdJCY+kwFj3P2bGTsp9Xthpmmjj762P6yaVWcaL7z1KyoQkvIoqCI5OEMEKOumjSE7CGG72Rlb9qf34nyoxzR3uvebHvD/N+tavq9YgdfnWQIaSxkTRtgFz5oWoYpAQBZx4j3YoHTKEISjxizCiMBY90R0XC0f5BRXZIryFbtIn1VmYISONFPmktnyShLFoz28JDETjma317KX+ErTWfAmh8w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:22:32.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a465de-e214-4276-f233-08df40a6dcd7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF35F036B4F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXxRkAOvTf8hfW
 yhT9l+J+PP45OlG6whtJ7mTfZWQFCFMbFEnC3D0eHeQt9W6kQMJw89HeCy87C7t7S5UzgkKJaR9
 uxMYncbAD8xcd1uFKVSJ0VTRxvTdTiM=
X-Authority-Analysis: v=2.4 cv=fNCsTpae c=1 sm=1 tr=0 ts=6af5936c cx=c_pps
 a=V6MklVWPegrOQeIbI7BYwA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=-OF9Ws2OJ2pFFvDUBdgA:9
X-Proofpoint-GUID: g05GOMTOwQs8TmG22lrDD6WXkb3aT8tz
X-Proofpoint-ORIG-GUID: g05GOMTOwQs8TmG22lrDD6WXkb3aT8tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX+aq6+vOqNFc3
 JjZRwjT8Pjycnqnzqgt5nD2KZcD8UUiWlZmmHV5JrPQhYpdmYap1X0V5gEQkLFWKhs1m5/+fDk5
 HMLYZx9Jc04MI1sW1tm3te7gm02/V/EJoQpojFOcNVLGAyCY8YzItFxDyWJM2RNSWh2+XEpJsiH
 8rv8pB1mjg5Ek8A2iwG6PfTWE4I88Lk+GHDvO3N6DTKRUm3IRN11cFQMuJjelrfnFWd7uFyr2vu
 21UO34BF4xxpjK/d1jNF3KhMM2QPZDQDx5K6t/qJT/Ib3055a+hEs0H68sq+B23shN4GkGrMIxT
 dGzIA7A8vahamSANf14mHC6sX+4U0G8C80AfhgS8SjNvPNvhwz8OjbzimBH9C/94ybhWXlnO6DO
 tA7L7q9vlVlcj5yK+dIBNltZdCjJ/ROwO+7sxvHwefFkDdSEEXTb9hzDV2O+t18Dhia3m+u28xN
 sHeSWdpQfZJWPbqCmdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040

Call phy_stop()/phy_start() around the firmware halt in
prueth_emac_restart() to prevent phylib from issuing R30 commands
to the stopped PRU. Without this, emac_adjust_link() can race with
firmware reload and write invalid state.

Fixes: 9facce84f4062 ("net: ti: icssg-prueth: Fix firmware load sequence.")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v2(v3-v2):
- Added this commit in the series which fixes the pre-existing issues
  flagged by sashiko

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 21 +++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..ef5dce595f68 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1837,6 +1837,14 @@ static int prueth_emac_restart(struct prueth *prueth)
 	struct prueth_emac *emac1 = prueth->emac[PRUETH_MAC1];
 	int ret;
 
+	/* Halt phylib to stop emac_adjust_link() from issuing R30 commands
+	 * to the PRU while the firmware is stopped.
+	 */
+	if (emac0->ndev->phydev)
+		phy_stop(emac0->ndev->phydev);
+	if (emac1->ndev->phydev)
+		phy_stop(emac1->ndev->phydev);
+
 	/* Detach the net_device for both PRUeth ports*/
 	if (netif_running(emac0->ndev))
 		netif_device_detach(emac0->ndev);
@@ -1847,20 +1855,20 @@ static int prueth_emac_restart(struct prueth *prueth)
 	ret = icssg_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
 	ret |= icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
 	if (ret)
-		return ret;
+		goto restart_phy;
 
 	/* Stop both pru cores for both PRUeth ports*/
 	ret = prueth_emac_common_stop(prueth);
 	if (ret) {
 		dev_err(prueth->dev, "Failed to stop the firmwares");
-		return ret;
+		goto restart_phy;
 	}
 
 	/* Start both pru cores for both PRUeth ports */
 	ret = prueth_emac_common_start(prueth);
 	if (ret) {
 		dev_err(prueth->dev, "Failed to start the firmwares");
-		return ret;
+		goto restart_phy;
 	}
 
 	/* Enable forwarding for both PRUeth ports */
@@ -1871,6 +1879,13 @@ static int prueth_emac_restart(struct prueth *prueth)
 	netif_device_attach(emac0->ndev);
 	netif_device_attach(emac1->ndev);
 
+restart_phy:
+	/* Resume phylib now that the firmware is running again. */
+	if (emac0->ndev->phydev)
+		phy_start(emac0->ndev->phydev);
+	if (emac1->ndev->phydev)
+		phy_start(emac1->ndev->phydev);
+
 	return ret;
 }
 
-- 
2.43.0

