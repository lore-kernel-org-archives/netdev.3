Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FA361DBF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433967; cv=fail; b=XfXPvEeB8pFcK+yuLvXUUtXrRveeAqMXcG57KsF76ndwkB/oOSoPMF08jkYWjZsICuzdIoH6uaWGJdWWQN9sTYbUimeYJdD0bJYGgn26Qvu/2RM0EnyXmMWBrA2/QjdmEkpPRbtesoLVdwLjSLn2cKUuwo1TmsLvJrzH3zlfaAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433967; c=relaxed/simple;
	bh=8ebPeQvzPr7FRaKwezYKuAZeEvfLFjcD2wPGi1um2PY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eV3x1OBHYujsGNuptALmNObsWAzXPh0rWMPQhbas1e+nO5DTOgCJcKxt5/QOZmqoSRpQgD8xT5n1CyNl4hA9RmkfmCZnNBQcmF+sShvUY6DsZjjioe+026NVi31gYFFSC1yPKGUzNDPVW3mFVHUy8kBg18H4lCigl2t7HwndIwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYEx9tEt; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYEx9tEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n60tGbMI57xd+RTdWEOoQ3p5iWdV6CULPQvtUglEgxwg2p7fKHDQGQKzJ1p9p36wLLy9yBcImZqV8lkEY207ZgzevWqTGjgbihWXMhmYpPMVxM4zidGIstYsJ56xl9zDrgpTmIUyi0rTH4elw/VpGnryfUJPMCeonahtHzYwDB55+QfwclWh/Bb+dCNAebmKSr7ErdHIkgCgz9CNBB5Q2vrA56WZ+LL0xkMwG6s+oTtnpvArcwqb2CyLTTwH4AL0Ab9c/YrlM0mhSBQsgZWQJynmpqxi7KWyzXOUsjrZhukqokOgst6O9skXZI0dmWRxl7QPH3lW09o9g+zUMkUUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1MNZO6nCYjS1GhsbHri+xibZnZ5/KBUXEYdpceFa/w=;
 b=ok5QjX98aQmL4c2E2afA2re8MTSN+Wfl2BLuru4eJBYdAxMH2+Wsmz/Sm5l99NSa8+XncOqnOHXCuJPhOFeL5pRiizca6eY5XEFvrxQYjkzTU4q5G5fwxyoRf+3v9BI5EqT2Rw1NVk0ToZViF32sPAaWiMc1pvjQkqfaH/hjQt2u3PiTjqTpkgxeKrVHsClZzh3OZPzrSlIQq+4GPZ3M+iD4GuFlPsaLwq4/5n7bBoambZ5BoUcWMK4qB8VQJU/TP/nVUCmWRL2fawGqzw/dNAEaa4Tawn3Feyxy3MRXGGaXEMM014k3JawnHBu4oFYkgthxzZanEwRR+F/+Dh1FEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1MNZO6nCYjS1GhsbHri+xibZnZ5/KBUXEYdpceFa/w=;
 b=QYEx9tEtcoo2sjrZXU+T76wqsHcciy3c/uEQ1Qq0u2BbZLf23gPo9iCDX/5eO4uO1Y4Z52cVOX/vyxrpBONAL6uaaWSrVPvPNWr/TMfchygeUprbx47+NDn0pU61lr5RDJdcIKOr31ytO8VvGD3UQmkK53mRv91Qt3JH6EO41vGKUI3hjCnxTRIF4jUDM07ildeujCDNjnuHFFNpsXslwPxbwmkqsRvqzI1XP43WUpRGSEAYQmjNnIoGXCQjdxVKY+2r5TVygLbuiRJr3NpfaF8UaNscVK74/TTHvfmXE86HG/t6Nly8o51M7Zs3cM/G3Jk9UyEko/5oQmxvcWvgNQ==
Received: from CH2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:610:50::22)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:39:19 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::54) by CH2PR16CA0012.outlook.office365.com
 (2603:10b6:610:50::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 07:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 07:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Aug
 2026 00:23:59 -0700
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Aug
 2026 00:23:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: pace ethtool_std_stats
 packet generation
In-Reply-To: <20260810164858.7fdd834a@kernel.org> (Jakub Kicinski's message of
	"Mon, 10 Aug 2026 16:48:58 -0700")
References: <20260808163653.2460381-1-kuba@kernel.org>
	<87ecg6cnm7.fsf@pmachata.org> <20260810164858.7fdd834a@kernel.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Tue, 11 Aug 2026 09:23:52 +0200
Message-ID: <8733wl86if.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6925d9-8b58-4f65-a13b-08def77ba72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dnzRXLFV5ZCD10kq1z6mgYvUVMed5I9sFCj3ApfvDtpuq8BYEHzyfk3PpVdGQ722Iep4edAE6Ngl/1qdeTFW8jvH957ZLfO58T4o2Ph8kKoUt7CD1IkLs0wvuJG+IAEZzO5joEZ7UxacrEt3i8sxJac+qfTN03YNtekdiEo/P9CzuBxqdS3i+T/J3UT3WNS9rwzyd5AEVrGLtYpTrnj1wpEWlUg0kg0oSWh0Ndxw7Zz7QhNfNWHSEfdbnvT4IypY6tmnLo35BB52vr47Cd6+BDnLMY4Q/WEO1XoRPW9Ese++OSwR27rs2Q+A3acO4KhSsnbx//tGAsiOyjNpHBPvMRcqgXiQPUFOQ2yH87G2dcq+pbylUtRzaDJi0dCNKdk/7WM/qZT1ONAk9fRRu0WEEHuxLXRuGBe76IWjvclOAd7b3g/tqhDoPMeRJMghzhT5szeeYGlT1lUOcjTa9l5qb+6+cfoczVAaXEOG9hZf03bWBwU243SzvrQphaHJbODIadJJm6+OTL6uxGCLrKjKrbYap3R8Yg5VOpuRAKuxkk/aUiVM+ptJnB+rxQcGcT3RM7y/EpNAY7D7VzTFKOE7YyAeBhyso26M93VjIFKTAbaf005n1POXk7NpHyxwbOzl0Hl7LgJlZoDln1dcGb/jMpp3wDc5E79UZvKvwl6unYy63ax5/pBF/eXGGArk11ANKwHNywO1hm3OcohjAdlLVg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tLk0YXofHZgTOVy3aYbNQT0A//a04375o4a0UtdEzZLRW1wqztOGsu7cCiMUpaaS6z06oB+Crp7qLjwbyKgJOSR/T2DoK1b8hQ1kxaGSAPFHrFVIdE+y5YIUlt21XjJ6bQsWpIuZ6LmyV9niJFM50qIQDHadLAasQTRYaKcbMW6U/UzmMEzDmsLO/1PhlCodaTG0n5pvxZLt1razTu8BuBhV4QZMv3Rf82AUJzz6m/yp4gWO7Tvj+7R409FKq3x46UbZ67CLNbT592waMeRIXqYpW1YIDsOg1PChl9WT85aeGoD+4eQchBUdZk/Am6PEMCQYrt7fbL4pbV12070nDxoFyLkOUOtOHXgGsUvMdkAqq65tY4MLsjqO+aWgixhfZs5/fmdpoPCSwpkbU81LHzs/Khu1WG6O0YM8t8Jnzr6kEdcfFVqaQr6NC3KQT793
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:39:18.9126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6925d9-8b58-4f65-a13b-08def77ba72c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 10 Aug 2026 11:48:32 +0200 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > mausezahn defaults to sending packets back to back at the maximum rate,
>> > which can cause packet loss, especially if receiver is running a debug
>> > kernel. Space the generated packets out (-d 10usec), like ethtool_rmon
>> > already does.
>> >
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
>> 
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>
> FTR Petr send me a review tag on this off-list ;)

Oops, that was not the intention.
My mailer setup is currently in a bit of a flux :-|
